Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B12E155E57
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2020 19:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgBGSor (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Feb 2020 13:44:47 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34192 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbgBGSor (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Feb 2020 13:44:47 -0500
Received: by mail-ot1-f65.google.com with SMTP id a15so287549otf.1
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Feb 2020 10:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IjhtgulTAQXBu1YGOFSxwbPLcfJQiJFhkbSjm9+x1so=;
        b=kR63NLulLCf1OtpMg5zsJoETCfdAgFNvwuQh9Tnft+n/PnimQH2HAaQonNVEZK8Bc5
         nTdk56t1uQrt2u1NfhF95HKjfBzC8070Qsa3f8g2EIyhN0pMU674KwiL8QMmP1T5UP+v
         K+sJIoSlqWp1GWDlDiQHdGK08KuaqoU3oVsHdDQahoNg9T4UvdFR2K/GLsEifhfimlQs
         iAZQSqkv3W8yjWNihEuxEVlp5OEoBVFyccg+8Ba/UAut7hXOjJzZeYLD2cLmXXrv/PDU
         1j3l62eHkq+lsQArUGrbpzETylGn0gY5bmMr/IrGkZ089kGuRC5saCRlm2BeAS0hEdD9
         jGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IjhtgulTAQXBu1YGOFSxwbPLcfJQiJFhkbSjm9+x1so=;
        b=NlA27leC8Y8jw+dsPiCRKp+35pFlo+mz4qQQvLS9ZyRODa1wnJ50KTeTr47NHj0E3/
         /owiT5Fsd66aKZFjmhEzeKTENf7TQjawTRUptfNRtEHSCFUJTf0Fhr5dbs1DndBVxOfZ
         0fRwom6GS+plmHT5j5w03y30otXD6wpgf8+tD2Ojv12wDuO9eVz6F4p5E/aaulUvIKnN
         Ogh2yasuEP54GZHaYZoVcvGoBrvW0LfLTSf3Jy0rPp1jrS1ZvbLxnivGXUQM25UmicxY
         kLTIg4S2jK5SInlEHUu83qUs5fUDCcZE2ymkaV6pPVcM7BWfKmOxZkD/kmxuAEJFgkMg
         O/Qw==
X-Gm-Message-State: APjAAAVzz8XUTUIGsIQF4YgCDojrhPsNbw6DRARWiY+1iAgj2RfsN+qW
        iCuwQCUh/iKVjbCq5SbjnyAU5+QtkLfa80GpZD6RAw==
X-Google-Smtp-Source: APXvYqyUOIzHYz/8PeDHDmutqDTbsdz6JmG9r6ffbt/iJkYum0RVw6Yw9WXmxMjrKnhI7JqrhZbpQmGOmcnwC0iAXnc=
X-Received: by 2002:a9d:518b:: with SMTP id y11mr518858otg.349.1581101085289;
 Fri, 07 Feb 2020 10:44:45 -0800 (PST)
MIME-Version: 1.0
References: <20200203232248.104733-1-almasrymina@google.com>
 <20200203232248.104733-7-almasrymina@google.com> <2541c294-9f61-083b-9a0d-0dfdc3dcac68@oracle.com>
In-Reply-To: <2541c294-9f61-083b-9a0d-0dfdc3dcac68@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 7 Feb 2020 10:44:34 -0800
Message-ID: <CAHS8izOi6H+BdheSLP0ShW9ugvQzFd3LxdTSNKOBAb2SHLr6YA@mail.gmail.com>
Subject: Re: [PATCH v11 7/9] hugetlb: support file_region coalescing again
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 6, 2020 at 4:17 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 2/3/20 3:22 PM, Mina Almasry wrote:
> > An earlier patch in this series disabled file_region coalescing in order
> > to hang the hugetlb_cgroup uncharge info on the file_region entries.
> >
> > This patch re-adds support for coalescing of file_region entries.
> > Essentially everytime we add an entry, we check to see if the
> > hugetlb_cgroup uncharge info is the same as any adjacent entries. If it
> > is, instead of adding an entry we simply extend the appropriate entry.
> >
> > This is an important performance optimization as private mappings add
> > their entries page by page, and we could incur big performance costs for
> > large mappings with lots of file_region entries in their resv_map.
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >  mm/hugetlb.c | 62 +++++++++++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 52 insertions(+), 10 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index ec0b55ea1506e..058dd9c8269cf 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -272,6 +272,22 @@ static void record_hugetlb_cgroup_uncharge_info(struct hugetlb_cgroup *h_cg,
> >  #endif
> >  }
> >
> > +static bool has_same_uncharge_info(struct file_region *rg,
> > +                                struct hugetlb_cgroup *h_cg,
> > +                                struct hstate *h)
> > +{
> > +#ifdef CONFIG_CGROUP_HUGETLB
> > +     return rg &&
> > +            rg->reservation_counter ==
> > +                    &h_cg->rsvd_hugepage[hstate_index(h)] &&
> > +            rg->pages_per_hpage == pages_per_huge_page(h) &&
> > +            rg->css == &h_cg->css;
> > +
> > +#else
> > +     return true;
> > +#endif
> > +}
> > +
> >  /* Must be called with resv->lock held. Calling this with count_only == true
> >   * will count the number of pages to be added but will not modify the linked
> >   * list. If regions_needed != NULL and count_only == true, then regions_needed
> > @@ -286,7 +302,7 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
> >       long add = 0;
> >       struct list_head *head = &resv->regions;
> >       long last_accounted_offset = f;
> > -     struct file_region *rg = NULL, *trg = NULL, *nrg = NULL;
> > +     struct file_region *rg = NULL, *trg = NULL, *nrg = NULL, *prg = NULL;
> >
> >       if (regions_needed)
> >               *regions_needed = 0;
> > @@ -318,16 +334,34 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
>
> I seem to be missing something.  For context, here is the beginning of that
> loop:
>
>         /* In this loop, we essentially handle an entry for the range
>          * [last_accounted_offset, rg->from), at every iteration, with some
>          * bounds checking.
>          */
>         list_for_each_entry_safe(rg, trg, head, link) {
>                 /* Skip irrelevant regions that start before our range. */
>                 if (rg->from < f) {
>                         /* If this region ends after the last accounted offset,
>                          * then we need to update last_accounted_offset.
>                          */
>                         if (rg->to > last_accounted_offset)
>                                 last_accounted_offset = rg->to;
>                         continue;
>                 }
>
>                 /* When we find a region that starts beyond our range, we've
>                  * finished.
>                  */
>                 if (rg->from > t)
>                         break;
>
> Suppose the resv_map contains one entry [0,2) and we are going to add
> [2,4).  Will we not 'continue' after the first entry and then exit loop
> without setting prg?  So, there is no chance for coalescing?
>

I think you're right; prg needs to be set on all loop exits, including
the continue and break. I'm thinking with that added, the logic should
work, but I need to find a good way to test this. I thought I had good
test coverage but apparently not. I'll fix this in the next iteration.


> --
> Mike Kravetz
>
> >               if (rg->from > last_accounted_offset) {
> >                       add += rg->from - last_accounted_offset;
> >                       if (!count_only) {
> > -                             nrg = get_file_region_entry_from_cache(
> > -                                     resv, last_accounted_offset, rg->from);
> > -                             record_hugetlb_cgroup_uncharge_info(h_cg, nrg,
> > -                                                                 h);
> > -                             list_add(&nrg->link, rg->link.prev);
> > +                             /* Check if the last region can be extended. */
> > +                             if (prg && prg->to == last_accounted_offset &&
> > +                                 has_same_uncharge_info(prg, h_cg, h)) {
> > +                                     prg->to = rg->from;
> > +                             /* Check if the next region can be extended. */
> > +                             } else if (has_same_uncharge_info(rg, h_cg,
> > +                                                               h)) {
> > +                                     rg->from = last_accounted_offset;
> > +                             /* If neither of the regions can be extended,
> > +                              * add a region.
> > +                              */
> > +                             } else {
> > +                                     nrg = get_file_region_entry_from_cache(
> > +                                             resv, last_accounted_offset,
> > +                                             rg->from);
> > +                                     record_hugetlb_cgroup_uncharge_info(
> > +                                             h_cg, nrg, h);
> > +                                     list_add(&nrg->link, rg->link.prev);
> > +                             }
> >                       } else if (regions_needed)
> >                               *regions_needed += 1;
> >               }
> >
> >               last_accounted_offset = rg->to;
> > +             /* Record rg as the 'previous file region' incase we need it
> > +              * for the next iteration.
> > +              */
> > +             prg = rg;
> >       }
> >
> >       /* Handle the case where our range extends beyond
> > @@ -336,10 +370,18 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
> >       if (last_accounted_offset < t) {
> >               add += t - last_accounted_offset;
> >               if (!count_only) {
> > -                     nrg = get_file_region_entry_from_cache(
> > -                             resv, last_accounted_offset, t);
> > -                     record_hugetlb_cgroup_uncharge_info(h_cg, nrg, h);
> > -                     list_add(&nrg->link, rg->link.prev);
> > +                     /* Check if the last region can be extended. */
> > +                     if (prg && prg->to == last_accounted_offset &&
> > +                         has_same_uncharge_info(prg, h_cg, h)) {
> > +                             prg->to = last_accounted_offset;
> > +                     } else {
> > +                             /* If not, just create a new region. */
> > +                             nrg = get_file_region_entry_from_cache(
> > +                                     resv, last_accounted_offset, t);
> > +                             record_hugetlb_cgroup_uncharge_info(h_cg, nrg,
> > +                                                                 h);
> > +                             list_add(&nrg->link, rg->link.prev);
> > +                     }
> >               } else if (regions_needed)
> >                       *regions_needed += 1;
> >       }
> > --
> > 2.25.0.341.g760bfbb309-goog
> >
