Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45112DDB2C
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Dec 2020 23:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732073AbgLQWDW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Dec 2020 17:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732037AbgLQWDV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Dec 2020 17:03:21 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D44C061794
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Dec 2020 14:02:41 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ce23so261639ejb.8
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Dec 2020 14:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9vdnsUgYkB36Ep59teaQpHG5J09HGP1/qSDhF8tulqw=;
        b=IyWl6xJfaeIwBHp2Vnyb602iv3sW5tz1Z1AonhBzz//6kqX6ut9KC3FJr8VW8yMCoO
         WRkzbAJo3tcX4BE4tIWUTt9b5IMTegSH0DxRJYvoOCTmYk3N7ZxBLzBGTWkXrzz85kmB
         uJQ1gHlb6oGRhyKkKvoevO32Bd/V8u31wI7z/0YmWJEKPv/Yu/8MTwjHgTtwebJGBHfz
         mMzBZBYMFhrvEj93oVEq2KK1wAh2W8sOEFebz96Puan3tNp4aIGxmiPOsd45rAIxLcmF
         AozEgbPb4M4QG2zOLYiatpVfuSqNk0lpaAu4P2+j5Wt4pNPzxaptN2sOKJyjbtCayXCs
         OsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9vdnsUgYkB36Ep59teaQpHG5J09HGP1/qSDhF8tulqw=;
        b=X91JQSTgDL4J1UIZJxQ0ejFQOKW9vIYzhMiExBFJlu3P3p/yN13QFwgqHAuWhfFBUM
         0CBcTwkBAYsC+xUWZ6o93WldLKMaTBg5RIJlIKzM2dQDi99y0sFpXiptgYdxdnALjb7H
         IX/4RAFpCxpnDVqhpkQ0XcSnld+auQ2Ws81IVQHA+MsOIt0W3Wr++KES0hzI94d4PVBm
         +91rakxqfA03xYbXCUujjlBqK9kGAacNl9UVvRWWcOnEgqcT4D+NiL28wxIJBdeOZz8K
         Qf+Sr1CDbmphskgjkWS1Ehwo6h/5ILjmTZqFKuZ0ddtXKET+uTDmfVLBea7Gia/bc7Cw
         i3IQ==
X-Gm-Message-State: AOAM5332TyZShnqR44CkFuSbyKnuzwANF8wgI90lbeY5NNv5JV4BBiWk
        VnudSUHlepNORcMphlFMMCoTwyApCnJvNdJlXDlMRQ==
X-Google-Smtp-Source: ABdhPJyrI5y+cymaIqjTdtLsBCNiORBZzKUiI7EZcr4ephYPlGDRI1t9oCp94abQkVwD0TaI9OLg1Gw6Z/Sgo+obFp8=
X-Received: by 2002:a17:906:ce51:: with SMTP id se17mr1122204ejb.314.1608242559864;
 Thu, 17 Dec 2020 14:02:39 -0800 (PST)
MIME-Version: 1.0
References: <20201217185243.3288048-1-pasha.tatashin@soleen.com>
 <20201217185243.3288048-9-pasha.tatashin@soleen.com> <20201217205048.GL5487@ziepe.ca>
In-Reply-To: <20201217205048.GL5487@ziepe.ca>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 17 Dec 2020 17:02:03 -0500
Message-ID: <CA+CK2bA4F+SipkReJzFjCSC-8kZdK4yrwCQZM+TvCTrqV2CGHg@mail.gmail.com>
Subject: Re: [PATCH v4 08/10] mm/gup: limit number of gup migration failures,
 honor failures
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, mike.kravetz@oracle.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jason,

Thank you for your comments. My replies below.

On Thu, Dec 17, 2020 at 3:50 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Dec 17, 2020 at 01:52:41PM -0500, Pavel Tatashin wrote:
> > +/*
> > + * Verify that there are no unpinnable (movable) pages, if so return true.
> > + * Otherwise an unpinnable pages is found return false, and unpin all pages.
> > + */
> > +static bool check_and_unpin_pages(unsigned long nr_pages, struct page **pages,
> > +                               unsigned int gup_flags)
> > +{
> > +     unsigned long i, step;
> > +
> > +     for (i = 0; i < nr_pages; i += step) {
> > +             struct page *head = compound_head(pages[i]);
> > +
> > +             step = compound_nr(head) - (pages[i] - head);
>
> You can't assume that all of a compound head is in the pages array,
> this assumption would only work inside the page walkers if the page
> was found in a PMD or something.

I am not sure I understand your comment. The compound head is not
taken from the pages array, and not assumed to be in it. It is exactly
the same logic as that we currently have:
https://soleen.com/source/xref/linux/mm/gup.c?r=a00cda3f#1565

>
> > +     if (gup_flags & FOLL_PIN) {
> > +             unpin_user_pages(pages, nr_pages);
>
> So we throw everything away? Why? That isn't how the old algorithm worked

It is exactly like the old algorithm worked: if there are pages to be
migrated (not pinnable pages) we unpinned everything.
See here:
https://soleen.com/source/xref/linux/mm/gup.c?r=a00cda3f#1603

If cma_pages_list is not empty unpin everything. The list is not empty
if we isolated some pages, we isolated some pages if there are some
pages which are not pinnable. Now, we do exactly the same thing, but
cleaner, and handle errors. We must unpin everything because if we
fail, no pages should stay pinned, and also if we migrated some pages,
the pages array must be updated, so we need to call
__get_user_pages_locked() pin and repopulated pages array.

>
> > @@ -1654,22 +1664,55 @@ static long __gup_longterm_locked(struct mm_struct *mm,
> >                                 struct vm_area_struct **vmas,
> >                                 unsigned int gup_flags)
> >  {
> > -     unsigned long flags = 0;
> > +     int migrate_retry = 0;
> > +     int isolate_retry = 0;
> > +     unsigned int flags;
> >       long rc;
> >
> > -     if (gup_flags & FOLL_LONGTERM)
> > -             flags = memalloc_pin_save();
> > +     if (!(gup_flags & FOLL_LONGTERM))
> > +             return __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
> > +                                            NULL, gup_flags);
> >
> > -     rc = __get_user_pages_locked(mm, start, nr_pages, pages, vmas, NULL,
> > -                                  gup_flags);
> > +     /*
> > +      * Without FOLL_WRITE fault handler may return zero page, which can
> > +      * be in a movable zone, and also will fail to isolate during migration,
> > +      * thus the longterm pin will fail.
> > +      */
> > +     gup_flags &= FOLL_WRITE;
>
> Is &= what you mean here? |= right?

Right, I meant |=.

>
> Seems like we've ended up in a weird place if FOLL_LONGTERM always
> includes FOLL_WRITE. Putting the zero page in ZONE_MOVABLE seems like
> a bad idea, no?

I am not sure, I just found this problem during testing, and this is
the solution I am proposing. I am worried about limiting the zero page
to a non movable zone, but let's see what others think about this.

>
> > +     /*
> > +      * Migration may fail, we retry before giving up. Also, because after
> > +      * migration pages[] becomes outdated, we unpin and repin all pages
> > +      * in the range, so pages array is repopulated with new values.
> > +      * Also, because of this we cannot retry migration failures in a loop
> > +      * without pinning/unpinnig pages.
> > +      */
>
> The old algorithm made continuous forward progress and only went back
> to the first migration point.

That is not right, the old code went back to the beginning. Making
continuous progress is possible, but we won't see any performance
betnefit from it, because migration failures is already exception
scenarios where machine is under memory stress. The truth is if we
fail to migrate it is unlikely will succeed if we retry right away, so
giving some time between retries may be even beneficial.  Also with
continious progress we need to take care of some corner cases where we
need to unpin already succeeded pages in case if forward progress is
not possible. Also, adjust pages array, start address etc.

>
> > +     for (; ; ) {
>
> while (true)?

Hm, the same thing? :)

>
> > +             rc = __get_user_pages_locked(mm, start, nr_pages, pages, vmas,
> > +                                          NULL, gup_flags);
>
> > +             /* Return if error or if all pages are pinnable */
> > +             if (rc <= 0 || check_and_unpin_pages(rc, pages, gup_flags))
> > +                     break;
>
> So we sweep the pages list twice now?

Yes, but O(N) is the same. No new operation is added. Before we had
something like this:

while (npages)
     check if pinnable
            isolate
while (npages)
   unpin
migrate
while (npages)
  pin

Now:
while(npages)
    check if pinnable
while(npages)
   unpin
while(npages)
    isolate
migrate
   pin

>
> > +             /* Some pages are not pinnable, migrate them */
> > +             rc = migrate_movable_pages(rc, pages);
> > +
> > +             /*
> > +              * If there is an error, and we tried maximum number of times
> > +              * bail out. Notice: we return an error code, and all pages are
> > +              * unpinned
> > +              */
> > +             if (rc < 0 && migrate_retry++ >= PINNABLE_MIGRATE_MAX) {
> > +                     break;
> > +             } else if (rc > 0 && isolate_retry++ >= PINNABLE_ISOLATE_MAX) {
> > +                     rc = -EBUSY;
>
> I don't like this at all. It shouldn't be so flakey
>
> Can you do migration without the LRU?

I do not think it is possible, we must isolate pages before migration.

Pasha
