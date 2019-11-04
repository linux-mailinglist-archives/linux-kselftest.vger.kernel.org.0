Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8A62EEAB8
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2019 22:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfKDVFF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Nov 2019 16:05:05 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34662 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbfKDVFF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Nov 2019 16:05:05 -0500
Received: by mail-oi1-f194.google.com with SMTP id l202so15485620oig.1
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Nov 2019 13:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NJ4yaudKvr0RTLdtAw5Tt6VequZxo8fdMKzieZXYS5E=;
        b=AHv7OCic5wC+7c9+QboI8CBbm7B4lNLsPGFdA+UT7TTXKQ6yL+Sk01wRkY9O9QnV9Q
         Fq2Ta8ibepHOtcgDYvofEeqChfbrVC0qI9OHhx73fcuJZWVcsg0HvTIRDJ4rBqsYGoHT
         8Kxm1xLhSmdkINcxuvc4SIhtyE4mHWjIlHVxT5c4S+2MkxhzYF2BrVhxZLRSA6RVUCKF
         QVRrKItkDYgXjpTQFnMLloM4avCLlEzWTZLN98Kl7Ws23oiK12jy6y8kOAzzM7f+Xfo3
         k0hBlk3XUPdNA4SVixFLUnd9Wrns/k+vhtAX3nx28GZwW+CAO+ZcpU6cUjX/sCvP5z3s
         OF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NJ4yaudKvr0RTLdtAw5Tt6VequZxo8fdMKzieZXYS5E=;
        b=nSQuYB8so2yb/UtA2vBPMgDj7l8a66ecEmexE5WzllH93K2zguRjFphu8WZsjuz4mU
         RdCl/ClGYMOC4BhPLX/eC4JOE/6Dv354rZjFQ0aqt6nWmFMN6fzpou9G2iINUrDgqmKZ
         Y3yy88BQpWBplL66r4ONqdemREmzujt9naKB/7zPH2tvevTqrvbyfT2w/YYU8Ax42IPm
         bSSDasUSVjYsKVH5D87Wd6C2HBnz5htaA91Cbqq+czs4+Bgp+xKnxvnC+Jdc7jnQSse+
         RR5MjbMB/AC+JJWMIUhcvsB7kEvzzDkJng0LiX1LGfSGhtE+o0nR6BdhWYo6xnlexI9a
         qpKQ==
X-Gm-Message-State: APjAAAVHIQm8LgbIsdzkzMdIwL670gnnATjMsgGmUgW/2fsBsSFZBipD
        0ccS55oIyLl7Enkhtafq0VhtM/l3cOQBAslM78pv5w==
X-Google-Smtp-Source: APXvYqzzLSFJguEnH/Po1ehNOcCmv9fnBRFuu/hzx621cjBo/CNiZSKLOelAwUNfT+6L1JKIHeKMOUtlRKTvfO004oY=
X-Received: by 2002:aca:bb89:: with SMTP id l131mr873063oif.65.1572901502297;
 Mon, 04 Nov 2019 13:05:02 -0800 (PST)
MIME-Version: 1.0
References: <20191030013701.39647-1-almasrymina@google.com>
 <20191030013701.39647-5-almasrymina@google.com> <1c060bde-8d44-146c-6d67-a7b145aa1b59@oracle.com>
In-Reply-To: <1c060bde-8d44-146c-6d67-a7b145aa1b59@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 4 Nov 2019 13:04:51 -0800
Message-ID: <CAHS8izPTvybLq9Y9Fn6Z+hSc7gLP+goQ-ixzjxa1XJ-qhWM8ow@mail.gmail.com>
Subject: Re: [PATCH v8 5/9] hugetlb: disable region_add file_region coalescing
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     shuah <shuah@kernel.org>, open list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 1, 2019 at 4:23 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 10/29/19 6:36 PM, Mina Almasry wrote:
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
>
> I think this commit message should also mention that we have changed the
> assumption previously made in the code that region_add after region_chg
> could never fail.  It is described in comments, but would be worth a mention
> here as well.
>

Will fix.

> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
>
> Thanks for the continued updates.  I can not spot any major issues with this
> version of the patch.  There are some questions and suggestions embedded
> below.  With those addressed, you can add:
>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
>
> As mentioned previously, this reservation code is quite fragile.  Changing
> it does make me nervous.  The good thing is that there is not a 'significant'
> change in behavior for the normal/expected code paths.  It is the handling of
> the race conditions and unexpected behavior that mostly makes me nervous.
> I suspect you have not exercised these paths.  One thing we could do is add
> some debug code to force execution of those paths.  For example, make
> add_reservation_in_range(count_only) always return 1 no matter how many
> regions are needed.  This will force region_add more frequently perform
> additional allocations.

Will test this and report back with fixes if I run into issues.

>
> This patch was of greatest concern to me as it impacts all hugetlbfs users,
> not just those using new cgroup functionality.  With it in good shape, I will
> start to look at the others.  However, my cgroup experience/understanding
> is limited.  So, it would be great if others can also review the cgroup
> specific changes.
>

Thanks in advance.

> >
> > ---
> > Changes in v8:
> > - Addressed comments from Mike, especially:
> >   - fixing region_add not allocating enough regions sometimes.
> >   - reverted vma_*_reservation API changes.
> > Changes in v7:
> > - region_chg no longer allocates (t-f) / 2 file_region entries.
> > Changes in v6:
> > - Fix bug in number of region_caches allocated by region_chg
> >
> > ---
> >  mm/hugetlb.c | 315 ++++++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 213 insertions(+), 102 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 8d8aa89a9928e..1162eeaf8d160 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -244,110 +244,178 @@ struct file_region {
> >       long to;
> >  };
> >
> > +/* Helper that removes a struct file_region from the resv_map cache and returns
> > + * it for use.
> > + */
> > +static struct file_region *
> > +get_file_region_entry_from_cache(struct resv_map *resv, long from, long to)
> > +{
> > +     struct file_region *nrg = NULL;
> > +
> > +     VM_BUG_ON(resv->region_cache_count <= 0);
> > +
> > +     resv->region_cache_count--;
> > +     nrg = list_first_entry(&resv->region_cache, struct file_region, link);
> > +     VM_BUG_ON(!nrg);
> > +     list_del(&nrg->link);
> > +
> > +     nrg->from = from;
> > +     nrg->to = to;
> > +
> > +     return nrg;
> > +}
> > +
> >  /* Must be called with resv->lock held. Calling this with count_only == true
> >   * will count the number of pages to be added but will not modify the linked
> > - * list.
> > + * list. If regions_needed != NULL and count_only == true, then regions_needed
> > + * will indicate the number of file_regions needed in the cache to carry out to
> > + * add the regions for this range.
> >   */
> >  static long add_reservation_in_range(struct resv_map *resv, long f, long t,
> > -                                  bool count_only)
> > +                                  long *regions_needed, bool count_only)
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
> > +     if (regions_needed)
> > +             *regions_needed = 0;
> >
> > -     /* Round our left edge to the current segment if it encloses us. */
> > -     if (f > rg->from)
> > -             f = rg->from;
> > -
> > -     chg = t - f;
> > +     /* In this loop, we essentially handle an entry for the range
> > +      * [last_accounted_offset, rg->from), at every iteration, with some
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
> > +                     } else if (regions_needed)
> > +                             *regions_needed += 1;
> >               }
> > -             chg -= rg->to - rg->from;
> >
> > -             if (!count_only && rg != nrg) {
> > -                     list_del(&rg->link);
> > -                     kfree(rg);
> > -             }
> > +             last_accounted_offset = rg->to;
>
> That last assignment is unneeded.  Correct?
>

Not to make you nervous, but this assignment is needed.

The basic idea is that there are 2 loop invariants here:
1. Everything before last_accounted_offset is filled in with file_regions.
2. rg points to the first region past last_account_offset.

Each loop iteration compares rg->from to last_accounted_offset, and if
there is a gap, it creates a new region to fill this gap. Then this
assignment restores loop invariant #2 by assigning
last_accounted_offset to rg->to, since now everything before rg->to is
filled in with file_regions.

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
> > +             } else if (regions_needed)
> > +                     *regions_needed += 1;
> > +             last_accounted_offset = t;
> >       }
> >
> > -     return chg;
> > +     return add;
> >  }
> >
> >  /*
> >   * Add the huge page range represented by [f, t) to the reserve
> > - * map.  Existing regions will be expanded to accommodate the specified
> > - * range, or a region will be taken from the cache.  Sufficient regions
> > - * must exist in the cache due to the previous call to region_chg with
> > - * the same range.
> > + * map.  Regions will be taken from the cache to fill in this range.
> > + * Sufficient regions should exist in the cache due to the previous
> > + * call to region_chg with the same range, but in some cases the cache will not
> > + * have sufficient entries.  The extra needed entries will be allocated.
>
> Let's mention that the reason sufficient entries may not exist is due to
> races with other code doing region_add or region_del.
>

Will fix.

> > + *
> > + * regions_needed is the out value provided by a previous call to region_chg.
> >   *
> > - * Return the number of new huge pages added to the map.  This
> > - * number is greater than or equal to zero.
> > + * Return the number of new huge pages added to the map.  This number is greater
> > + * than or equal to zero.  If file_region entries needed to be allocated for
> > + * this operation and we were not able to allocate, it ruturns -ENOMEM.
> > + * region_add of regions of length 1 never allocate file_regions and cannot
> > + * fail.
>
> Let's add the reason why region_add for regions of length 1 will never fail.
> Specifically, region_chg will always allocate at least 1 entry and a
> region_add for 1 page will only require at most 1 entry.
>
>

Will fix.

> >   */
> > -static long region_add(struct resv_map *resv, long f, long t)
> > +static long region_add(struct resv_map *resv, long f, long t,
> > +                    long in_regions_needed)
> >  {
> > -     struct list_head *head = &resv->regions;
> > -     struct file_region *rg, *nrg;
> > -     long add = 0;
> > +     long add = 0, actual_regions_needed = 0, i = 0;
> > +     struct file_region *trg = NULL, *rg = NULL;
> > +     struct list_head allocated_regions;
> > +
> > +     INIT_LIST_HEAD(&allocated_regions);
> >
> >       spin_lock(&resv->lock);
> > -     /* Locate the region we are either in or before. */
> > -     list_for_each_entry(rg, head, link)
> > -             if (f <= rg->to)
> > -                     break;
> > +retry:
> > +
> > +     /* Count how many regions are actually needed to execute this add. */
> > +     add_reservation_in_range(resv, f, t, &actual_regions_needed, true);
> >
> >       /*
> > -      * If no region exists which can be expanded to include the
> > -      * specified range, pull a region descriptor from the cache
> > -      * and use it for this range.
> > +      * Check for sufficient descriptors in the cache to accommodate
> > +      * this add operation. Note that actual_regions_needed may be greater
> > +      * than in_regions_needed. In this case, we need to make sure that we
> > +      * allocate extra entries, such that we have enough for all the
> > +      * existing adds_in_progress, plus the excess needed for this
> > +      * operation.
> >        */
> > -     if (&rg->link == head || t < rg->from) {
> > -             VM_BUG_ON(resv->region_cache_count <= 0);
> > +     if (resv->region_cache_count <
> > +         resv->adds_in_progress +
> > +                 (actual_regions_needed - in_regions_needed)) {
> > +             /* region_add operation of range 1 should never need to
> > +              * allocate file_region entries.
> > +              */
> > +             VM_BUG_ON(t - f <= 1);
> >
> > -             resv->region_cache_count--;
> > -             nrg = list_first_entry(&resv->region_cache, struct file_region,
> > -                                     link);
> > -             list_del(&nrg->link);
> > +             /* Must drop lock to allocate a new descriptor. */
> > +             spin_unlock(&resv->lock);
> > +             for (i = 0; i < (actual_regions_needed - in_regions_needed);
> > +                  i++) {
> > +                     trg = kmalloc(sizeof(*trg), GFP_KERNEL);
> > +                     if (!trg)
> > +                             goto out_of_memory;
> > +                     list_add(&trg->link, &allocated_regions);
> > +             }
> > +             spin_lock(&resv->lock);
> >
> > -             nrg->from = f;
> > -             nrg->to = t;
> > -             list_add(&nrg->link, rg->link.prev);
> > +             list_for_each_entry_safe(rg, trg, &allocated_regions, link) {
> > +                     list_del(&rg->link);
> > +                     list_add(&rg->link, &resv->region_cache);
> > +                     resv->region_cache_count++;
> > +             }
> >
> > -             add += t - f;
> > -             goto out_locked;
> > +             goto retry;
> >       }
> >
> > -     add = add_reservation_in_range(resv, f, t, false);
> > +     add = add_reservation_in_range(resv, f, t, NULL, false);
> > +
> > +     resv->adds_in_progress -= in_regions_needed;
> >
> > -out_locked:
> > -     resv->adds_in_progress--;
> >       spin_unlock(&resv->lock);
> >       VM_BUG_ON(add < 0);
>
> Does this VM_BUG_ON make sense here?  You are testing if
> add_reservation_in_range() returned a negative value. Right?
> Perhaps this was previously combined with the out_of_memory situation.
>

Yes it tests add_reservation_in_range() returned a negative value,
which indicates something very wrong happened. Doesn't seem critical
but doesn't hurt either.

> >       return add;
> > +
> > +out_of_memory:
> > +     list_for_each_entry_safe(rg, trg, &allocated_regions, link) {
> > +             list_del(&rg->link);
> > +             kfree(rg);
> > +     }
> > +     return -ENOMEM;
> >  }
> >
> >  /*
> > @@ -357,49 +425,72 @@ static long region_add(struct resv_map *resv, long f, long t)
> >   * call to region_add that will actually modify the reserve
> >   * map to add the specified range [f, t).  region_chg does
> >   * not change the number of huge pages represented by the
> > - * map.  A new file_region structure is added to the cache
> > - * as a placeholder, so that the subsequent region_add
> > - * call will have all the regions it needs and will not fail.
> > + * map.  A number of new file_region structures is added to the cache as a
> > + * placeholder, for the subsequent region_add call to use. At least 1
> > + * file_region structure is added.
> > + *
> > + * out_regions_needed is the number of regions added to the
> > + * resv->adds_in_progress.  This value needs to be provided to a follow up call
> > + * to region_add or region_abort for proper accounting.
> >   *
> >   * Returns the number of huge pages that need to be added to the existing
> >   * reservation map for the range [f, t).  This number is greater or equal to
> >   * zero.  -ENOMEM is returned if a new file_region structure or cache entry
> >   * is needed and can not be allocated.
> >   */
> > -static long region_chg(struct resv_map *resv, long f, long t)
> > +static long region_chg(struct resv_map *resv, long f, long t,
> > +                    long *out_regions_needed)
> >  {
> > -     long chg = 0;
> > +     struct file_region *trg = NULL, *rg = NULL;
> > +     long chg = 0, i = 0, to_allocate = 0;
> > +     struct list_head allocated_regions;
> > +
> > +     INIT_LIST_HEAD(&allocated_regions);
> >
> >       spin_lock(&resv->lock);
> > -retry_locked:
> > -     resv->adds_in_progress++;
> > +
> > +     /* Count how many hugepages in this range are NOT respresented. */
> > +     chg = add_reservation_in_range(resv, f, t, out_regions_needed, true);
> > +
> > +     if (*out_regions_needed < 1)
> > +             *out_regions_needed = 1;
>
> Perhaps just me, but I would prefer an explicit check for zero here.
> That is the only possible value less than 1, correct?  Otherwise, on
> a quick read of this code one might think out_regions_needed could be
> a negative number or error code.
>

Will fix.

> > +
> > +     resv->adds_in_progress += *out_regions_needed;
> >
> >       /*
> >        * Check for sufficient descriptors in the cache to accommodate
> >        * the number of in progress add operations.
> >        */
> > -     if (resv->adds_in_progress > resv->region_cache_count) {
> > -             struct file_region *trg;
> > +     while (resv->region_cache_count < resv->adds_in_progress) {
> > +             to_allocate = resv->adds_in_progress - resv->region_cache_count;
>
> When I first looked at this while loop, I thought we would be calling
> add_reservation_in_range again after dropping and reacquiring the lock.
> It took me a minute to realize that that is not required.  We only need
> to get the number of entries that were sugggested by the first call, and
> that number is incorporated in resv->adds_in_progress.  If things have
> changed, the subsequent region_add can deal with it.  It might be a
> good idea to note this in the commnent.
>

Will add.

> --
> Mike Kravetz
>
> >
> > -             VM_BUG_ON(resv->adds_in_progress - resv->region_cache_count > 1);
> >               /* Must drop lock to allocate a new descriptor. */
> > -             resv->adds_in_progress--;
> >               spin_unlock(&resv->lock);
> > -
> > -             trg = kmalloc(sizeof(*trg), GFP_KERNEL);
> > -             if (!trg)
> > -                     return -ENOMEM;
> > +             for (i = 0; i < to_allocate; i++) {
> > +                     trg = kmalloc(sizeof(*trg), GFP_KERNEL);
> > +                     if (!trg)
> > +                             goto out_of_memory;
> > +                     list_add(&trg->link, &allocated_regions);
> > +             }
> >
> >               spin_lock(&resv->lock);
> > -             list_add(&trg->link, &resv->region_cache);
> > -             resv->region_cache_count++;
> > -             goto retry_locked;
> > -     }
> >
> > -     chg = add_reservation_in_range(resv, f, t, true);
> > +             list_for_each_entry_safe(rg, trg, &allocated_regions, link) {
> > +                     list_del(&rg->link);
> > +                     list_add(&rg->link, &resv->region_cache);
> > +                     resv->region_cache_count++;
> > +             }
> > +     }
> >
> >       spin_unlock(&resv->lock);
> >       return chg;
> > +
> > +out_of_memory:
> > +     list_for_each_entry_safe(rg, trg, &allocated_regions, link) {
> > +             list_del(&rg->link);
> > +             kfree(rg);
> > +     }
> > +     return -ENOMEM;
> >  }
> >
> >  /*
> > @@ -407,17 +498,20 @@ static long region_chg(struct resv_map *resv, long f, long t)
> >   * of the resv_map keeps track of the operations in progress between
> >   * calls to region_chg and region_add.  Operations are sometimes
> >   * aborted after the call to region_chg.  In such cases, region_abort
> > - * is called to decrement the adds_in_progress counter.
> > + * is called to decrement the adds_in_progress counter. regions_needed
> > + * is the value returned by the region_chg call, it is used to decrement
> > + * the adds_in_progress counter.
> >   *
> >   * NOTE: The range arguments [f, t) are not needed or used in this
> >   * routine.  They are kept to make reading the calling code easier as
> >   * arguments will match the associated region_chg call.
> >   */
> > -static void region_abort(struct resv_map *resv, long f, long t)
> > +static void region_abort(struct resv_map *resv, long f, long t,
> > +                      long regions_needed)
> >  {
> >       spin_lock(&resv->lock);
> >       VM_BUG_ON(!resv->region_cache_count);
> > -     resv->adds_in_progress--;
> > +     resv->adds_in_progress -= regions_needed;
> >       spin_unlock(&resv->lock);
> >  }
> >
> > @@ -1904,6 +1998,7 @@ static long __vma_reservation_common(struct hstate *h,
> >       struct resv_map *resv;
> >       pgoff_t idx;
> >       long ret;
> > +     long dummy_out_regions_needed;
> >
> >       resv = vma_resv_map(vma);
> >       if (!resv)
> > @@ -1912,20 +2007,29 @@ static long __vma_reservation_common(struct hstate *h,
> >       idx = vma_hugecache_offset(h, vma, addr);
> >       switch (mode) {
> >       case VMA_NEEDS_RESV:
> > -             ret = region_chg(resv, idx, idx + 1);
> > +             ret = region_chg(resv, idx, idx + 1, &dummy_out_regions_needed);
> > +             /* We assume that vma_reservation_* routines always operate on
> > +              * 1 page, and that adding to resv map a 1 page entry can only
> > +              * ever require 1 region.
> > +              */
> > +             VM_BUG_ON(dummy_out_regions_needed != 1);
> >               break;
> >       case VMA_COMMIT_RESV:
> > -             ret = region_add(resv, idx, idx + 1);
> > +             ret = region_add(resv, idx, idx + 1, 1);
> > +             /* region_add calls of range 1 should never fail. */
> > +             VM_BUG_ON(ret < 0);
> >               break;
> >       case VMA_END_RESV:
> > -             region_abort(resv, idx, idx + 1);
> > +             region_abort(resv, idx, idx + 1, 1);
> >               ret = 0;
> >               break;
> >       case VMA_ADD_RESV:
> > -             if (vma->vm_flags & VM_MAYSHARE)
> > -                     ret = region_add(resv, idx, idx + 1);
> > -             else {
> > -                     region_abort(resv, idx, idx + 1);
> > +             if (vma->vm_flags & VM_MAYSHARE) {
> > +                     ret = region_add(resv, idx, idx + 1, 1);
> > +                     /* region_add calls of range 1 should never fail. */
> > +                     VM_BUG_ON(ret < 0);
> > +             } else {
> > +                     region_abort(resv, idx, idx + 1, 1);
> >                       ret = region_del(resv, idx, idx + 1);
> >               }
> >               break;
> > @@ -4578,12 +4682,12 @@ int hugetlb_reserve_pages(struct inode *inode,
> >                                       struct vm_area_struct *vma,
> >                                       vm_flags_t vm_flags)
> >  {
> > -     long ret, chg;
> > +     long ret, chg, add = -1;
> >       struct hstate *h = hstate_inode(inode);
> >       struct hugepage_subpool *spool = subpool_inode(inode);
> >       struct resv_map *resv_map;
> >       struct hugetlb_cgroup *h_cg;
> > -     long gbl_reserve;
> > +     long gbl_reserve, regions_needed = 0;
> >
> >       /* This should never happen */
> >       if (from > to) {
> > @@ -4613,7 +4717,7 @@ int hugetlb_reserve_pages(struct inode *inode,
> >                */
> >               resv_map = inode_resv_map(inode);
> >
> > -             chg = region_chg(resv_map, from, to);
> > +             chg = region_chg(resv_map, from, to, &regions_needed);
> >
> >       } else {
> >               /* Private mapping. */
> > @@ -4683,9 +4787,14 @@ int hugetlb_reserve_pages(struct inode *inode,
> >        * else has to be done for private mappings here
> >        */
> >       if (!vma || vma->vm_flags & VM_MAYSHARE) {
> > -             long add = region_add(resv_map, from, to);
> > -
> > -             if (unlikely(chg > add)) {
> > +             add = region_add(resv_map, from, to, regions_needed);
> > +
> > +             if (unlikely(add < 0)) {
> > +                     hugetlb_acct_memory(h, -gbl_reserve);
> > +                     /* put back original number of pages, chg */
> > +                     (void)hugepage_subpool_put_pages(spool, chg);
> > +                     goto out_err;
> > +             } else if (unlikely(chg > add)) {
> >                       /*
> >                        * pages in this range were added to the reserve
> >                        * map between region_chg and region_add.  This
> > @@ -4703,9 +4812,11 @@ int hugetlb_reserve_pages(struct inode *inode,
> >       return 0;
> >  out_err:
> >       if (!vma || vma->vm_flags & VM_MAYSHARE)
> > -             /* Don't call region_abort if region_chg failed */
> > -             if (chg >= 0)
> > -                     region_abort(resv_map, from, to);
> > +             /* Only call region_abort if the region_chg succeeded but the
> > +              * region_add failed or didn't run.
> > +              */
> > +             if (chg >= 0 && add < 0)
> > +                     region_abort(resv_map, from, to, regions_needed);
> >       if (vma && is_vma_resv_set(vma, HPAGE_RESV_OWNER))
> >               kref_put(&resv_map->refs, resv_map_release);
> >       return ret;
> > --
> > 2.24.0.rc1.363.gb1bccd3e3d-goog
> >
