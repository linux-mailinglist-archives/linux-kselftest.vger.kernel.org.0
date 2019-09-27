Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3007BC0E0C
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Sep 2019 00:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfI0WeG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Sep 2019 18:34:06 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44617 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfI0WeG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Sep 2019 18:34:06 -0400
Received: by mail-oi1-f193.google.com with SMTP id w6so6502714oie.11
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2019 15:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V6x0Ikw2R3kAk/v4L8H8ZAaVb4qruu1+b3nEFzMZR/g=;
        b=CPC5ip+nLF3n5s4Vr9Pf2oUZ+9xfp1MvpNPvrIqmKStkwuruZp5naPx6gn3vjFY8hs
         wMMVLadJvYB6j0/9U0Fb0az6rXlf1OtVKS5K0pI1d5IG8k0slnaryNcwmq74xPCarW0J
         sKrWdieOj1l4Umt5qfIqT/jXrxpU+X+27/MoiV33tCpCz/pBvrWfHBw2QCK5hT5kipFN
         t1SnHOFGx6Kzdl36NuMj68P2cyh7k638MP58WPdGGEvoPSCsbNofqlfxBMxDGwdxdXL9
         dqysNEjOjqlbdu85/ktRFVDZuO+PP3SfcpIo9JbfL+VGHJTXRyIxzt0dpUoKWC/V4X7s
         I8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V6x0Ikw2R3kAk/v4L8H8ZAaVb4qruu1+b3nEFzMZR/g=;
        b=C1TaQivPeJd5SOZLMHrkfNHw79Uo9ML5zXacHEGznT9TNyiEXJFb7wPZEwpD9DH80D
         mT/qVG9r1MsMP7aCISZT3D3ph5iyTFbH0j5iMcMUnqdliYNVeFgkQUCtXMnT0c8qkiu9
         qyjuXpMUikiwbtn1P8HcUSRLqHvYS1WYjS9vGG2Plc5Rw51ojnfdIp6ekmANiq6NntTT
         B4QqK6K6cCIW1/6t8p5lB8qR92GdBuezQc6SBGAW6h5DUZJh9td0qT2pR/eObu28S8Wz
         So0aK5SyPJ//Tz3q72HlFsSlIV0p1qlKmCAKLi7WjAE7L8AFfA53vslszwIKA+MtfeEa
         EkaA==
X-Gm-Message-State: APjAAAWstz5RfitKMxIKWgoqyhZ1ZBu8+blo5OZyH9F8ZtNeytrzVZ9H
        jkkuaC00LYPvX7LZrdsTPXsGCJWgjuBuUtjVE3hnWA==
X-Google-Smtp-Source: APXvYqwPeFSUBHWRmITp/bW/QMB5ozo6b+nE/ttjFKz6mWytxdEIhvuG6ke3hk+4GsCOslEUT1zDml+NG440GEhWJvk=
X-Received: by 2002:aca:ed08:: with SMTP id l8mr8525559oih.151.1569623644458;
 Fri, 27 Sep 2019 15:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190919222421.27408-1-almasrymina@google.com>
 <20190919222421.27408-5-almasrymina@google.com> <62a2a742-1735-7272-3c6c-213efc7adb9f@oracle.com>
In-Reply-To: <62a2a742-1735-7272-3c6c-213efc7adb9f@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 27 Sep 2019 15:33:53 -0700
Message-ID: <CAHS8izPqTDF57TLx-ZtVWWiMVFX91BOy-oP=V68Xu_QP7RW++g@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] hugetlb: disable region_add file_region coalescing
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        khalid.aziz@oracle.com, open list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 27, 2019 at 2:44 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 9/19/19 3:24 PM, Mina Almasry wrote:
> > A follow up patch in this series adds hugetlb cgroup uncharge info the
> > file_region entries in resv->regions. The cgroup uncharge info may
> > differ for different regions, so they can no longer be coalesced at
> > region_add time. So, disable region coalescing in region_add in this
> > patch.
> >
> > Behavior change:
> >
> > Say a resv_map exists like this [0->1], [2->3], and [5->6].
> >
> > Then a region_chg/add call comes in region_chg/add(f=0, t=5).
> >
> > Old code would generate resv->regions: [0->5], [5->6].
> > New code would generate resv->regions: [0->1], [1->2], [2->3], [3->5],
> > [5->6].
> >
> > Special care needs to be taken to handle the resv->adds_in_progress
> > variable correctly. In the past, only 1 region would be added for every
> > region_chg and region_add call. But now, each call may add multiple
> > regions, so we can no longer increment adds_in_progress by 1 in region_chg,
> > or decrement adds_in_progress by 1 after region_add or region_abort. Instead,
> > region_chg calls add_reservation_in_range() to count the number of regions
> > needed and allocates those, and that info is passed to region_add and
> > region_abort to decrement adds_in_progress correctly.
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >  mm/hugetlb.c | 273 +++++++++++++++++++++++++++++----------------------
> >  1 file changed, 158 insertions(+), 115 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index bac1cbdd027c..d03b048084a3 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -244,6 +244,12 @@ struct file_region {
> >       long to;
> >  };
> >
> > +/* Helper that removes a struct file_region from the resv_map cache and returns
> > + * it for use.
> > + */
> > +static struct file_region *
> > +get_file_region_entry_from_cache(struct resv_map *resv, long from, long to);
> > +
>
> Instead of the forward declaration, just put the function here.
>
> >  /* Must be called with resv->lock held. Calling this with count_only == true
> >   * will count the number of pages to be added but will not modify the linked
> >   * list.
> > @@ -251,51 +257,61 @@ struct file_region {
> >  static long add_reservation_in_range(struct resv_map *resv, long f, long t,
> >                                    bool count_only)
> >  {
> > -     long chg = 0;
> > +     long add = 0;
> >       struct list_head *head = &resv->regions;
> > +     long last_accounted_offset = f;
> >       struct file_region *rg = NULL, *trg = NULL, *nrg = NULL;
> >
> > -     /* Locate the region we are before or in. */
> > -     list_for_each_entry (rg, head, link)
> > -             if (f <= rg->to)
> > -                     break;
> > -
> > -     /* Round our left edge to the current segment if it encloses us. */
> > -     if (f > rg->from)
> > -             f = rg->from;
> > -
> > -     chg = t - f;
> > +     /* In this loop, we essentially handle an entry for the range
> > +      * last_accounted_offset -> rg->from, at every iteration, with some
> > +      * bounds checking.
> > +      */
> > +     list_for_each_entry_safe(rg, trg, head, link) {
> > +             /* Skip irrelevant regions that start before our range. */
> > +             if (rg->from < f) {
> > +                     /* If this region ends after the last accounted offset,
> > +                      * then we need to update last_accounted_offset.
> > +                      */
> > +                     if (rg->to > last_accounted_offset)
> > +                             last_accounted_offset = rg->to;
> > +                     continue;
> > +             }
> >
> > -     /* Check for and consume any regions we now overlap with. */
> > -     nrg = rg;
> > -     list_for_each_entry_safe (rg, trg, rg->link.prev, link) {
> > -             if (&rg->link == head)
> > -                     break;
> > +             /* When we find a region that starts beyond our range, we've
> > +              * finished.
> > +              */
> >               if (rg->from > t)
> >                       break;
> >
> > -             /* We overlap with this area, if it extends further than
> > -              * us then we must extend ourselves.  Account for its
> > -              * existing reservation.
> > +             /* Add an entry for last_accounted_offset -> rg->from, and
> > +              * update last_accounted_offset.
> >                */
> > -             if (rg->to > t) {
> > -                     chg += rg->to - t;
> > -                     t = rg->to;
> > +             if (rg->from > last_accounted_offset) {
> > +                     add += rg->from - last_accounted_offset;
> > +                     if (!count_only) {
> > +                             nrg = get_file_region_entry_from_cache(
> > +                                     resv, last_accounted_offset, rg->from);
> > +                             list_add(&nrg->link, rg->link.prev);
> > +                     }
> >               }
> > -             chg -= rg->to - rg->from;
> >
> > -             if (!count_only && rg != nrg) {
> > -                     list_del(&rg->link);
> > -                     kfree(rg);
> > -             }
> > +             last_accounted_offset = rg->to;
> >       }
> >
> > -     if (!count_only) {
> > -             nrg->from = f;
> > -             nrg->to = t;
> > +     /* Handle the case where our range extends beyond
> > +      * last_accounted_offset.
> > +      */
> > +     if (last_accounted_offset < t) {
> > +             add += t - last_accounted_offset;
> > +             if (!count_only) {
> > +                     nrg = get_file_region_entry_from_cache(
> > +                             resv, last_accounted_offset, t);
> > +                     list_add(&nrg->link, rg->link.prev);
> > +             }
> > +             last_accounted_offset = t;
> >       }
> >
> > -     return chg;
> > +     return add;
> >  }
> >
> >  /*
> > @@ -305,46 +321,24 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
>
> The start of this comment block says,
>
> /*
>  * Add the huge page range represented by [f, t) to the reserve
>  * map.  Existing regions will be expanded to accommodate the specified
>  * range, or a region will be taken from the cache.
>
> We are no longer expanding existing regions.  Correct?
> As an optimization, I guess we could coalesce/combine reion entries as
> long as they are for the same cgroup.  However, it may not be worth the
> effort.
>
> >   * must exist in the cache due to the previous call to region_chg with
> >   * the same range.
> >   *
> > + * regions_needed is the out value provided by a previous
> > + * call to region_chg.
> > + *
> >   * Return the number of new huge pages added to the map.  This
> >   * number is greater than or equal to zero.
> >   */
> > -static long region_add(struct resv_map *resv, long f, long t)
> > +static long region_add(struct resv_map *resv, long f, long t,
> > +                    long regions_needed)
> >  {
> > -     struct list_head *head = &resv->regions;
> > -     struct file_region *rg, *nrg;
> >       long add = 0;
> >
> >       spin_lock(&resv->lock);
> > -     /* Locate the region we are either in or before. */
> > -     list_for_each_entry(rg, head, link)
> > -             if (f <= rg->to)
> > -                     break;
> >
> > -     /*
> > -      * If no region exists which can be expanded to include the
> > -      * specified range, pull a region descriptor from the cache
> > -      * and use it for this range.
> > -      */
> > -     if (&rg->link == head || t < rg->from) {
> > -             VM_BUG_ON(resv->region_cache_count <= 0);
> > -
> > -             resv->region_cache_count--;
> > -             nrg = list_first_entry(&resv->region_cache, struct file_region,
> > -                                     link);
> > -             list_del(&nrg->link);
> > -
> > -             nrg->from = f;
> > -             nrg->to = t;
> > -             list_add(&nrg->link, rg->link.prev);
> > -
> > -             add += t - f;
> > -             goto out_locked;
> > -     }
> > +     VM_BUG_ON(resv->region_cache_count < regions_needed);
> >
> >       add = add_reservation_in_range(resv, f, t, false);
> > +     resv->adds_in_progress -= regions_needed;
>
> Consider this example,
>
> - region_chg(1,2)
>         adds_in_progress = 1
>         cache entries 1
> - region_chg(3,4)
>         adds_in_progress = 2
>         cache entries 2
> - region_chg(5,6)
>         adds_in_progress = 3
>         cache entries 3
>
> At this point, no region descriptors are in the map because only
> region_chg has been called.
>
> - region_chg(0,6)
>         adds_in_progress = 4
>         cache entries 4
>
> Is that correct so far?
>
> Then the following sequence happens,
>
> - region_add(1,2)
>         adds_in_progress = 3
>         cache entries 3
> - region_add(3,4)
>         adds_in_progress = 2
>         cache entries 2
> - region_add(5,6)
>         adds_in_progress = 1
>         cache entries 1
>
> list of region descriptors is:
> [1->2] [3->4] [5->6]
>
> - region_add(0,6)
> This is going to require 3 cache entries but only one is in the cache.
> I think we are going to BUG in get_file_region_entry_from_cache() the
> second time it is called from add_reservation_in_range().
>
> I stopped looking at the code here as things will need to change if this
> is a real issue.

You're right. I had been assuming that some higher level sync causes
to ban a sequence of region_chg calls without a region_add or
region_abort to resolve each region_chg call, but seems that is not
the case. I'll fix and upload another version of the patch.

> --
> Mike Kravetz
