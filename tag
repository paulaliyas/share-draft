// src/components/analytics/TrackedLink.tsx
"use client"

import React from "react"
import Link from "next/link"
import type { ComponentProps, MouseEvent } from "react"
import { trackCtaClick } from "@/src/lib/gtm"

interface TrackedLinkProps extends ComponentProps<typeof Link> {
    /** Unique CTA name, e.g. "footer_contact_us". Enables tracking when set. */
    ctaName?: string
    /** Where the link sits, e.g. "footer". Falls back to current route. */
    ctaLocation?: string
    /** Extra data to send with the event. */
    trackingData?: Record<string, unknown>
}

export default function TrackedLink({
    ctaName,
    ctaLocation,
    trackingData,
    onClick,
    children,
    ...rest
}: TrackedLinkProps) {
    const handleClick = (e: MouseEvent<HTMLAnchorElement>): void => {
        if (ctaName) {
            trackCtaClick({ ctaName, ctaLocation, ...trackingData })
        }
        onClick?.(e)
    }

    return (
        <Link onClick={handleClick} {...rest}>
            {children}
        </Link>
    )
}



// Before
import Link from "next/link"
<Link href={CONTACT_US[locale]} target="_blank">
    {t("contactUs")}
</Link>

// After
import TrackedLink from "@/src/components/analytics/TrackedLink"
<TrackedLink
    href={CONTACT_US[locale]}
    target="_blank"
    ctaName="contact_us"
    ctaLocation="footer"
>
    {t("contactUs")}
</TrackedLink>
