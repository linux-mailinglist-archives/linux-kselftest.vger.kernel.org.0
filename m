Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8E4EEAF2
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2019 22:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbfKDVTb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Nov 2019 16:19:31 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34948 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729558AbfKDVTb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Nov 2019 16:19:31 -0500
Received: by mail-ot1-f65.google.com with SMTP id z6so15750303otb.2
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Nov 2019 13:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/8yU3O5k24h9e3PyFN4Dj6MFbBb6JVOj0JoMWY+S3AE=;
        b=D9p5NchbwDhe9mp8NmRpUK2kC/a+iNk7mb4uEiZ8i732RHQD6+tLGJUqQxUtZVO/6E
         cj1d8a4CJKXF8pG7Zq7JEeo0VUK3rLYbIqPfzCn9VAy0MLJ3rg/OY1kog7CQmyv2Amrc
         JcgPRVvZUwSxwpa+ttmnJcoylJD3NkiLLnmjKjCHY/C1g4stQ8Ed1DyQrK1adfzuqzG0
         UtqL7KFhK1ty8dRL3C+GxB04afBz9u4VTY09zYZBWWaqrssMfw3imLZpgVrl9CnzcqC5
         01mxKNlxFe9J0MLshePp0EkD4m82n/DCA8btqZnttBF+d3W3jxDnTftdC5+8WtGvIWYe
         1bqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/8yU3O5k24h9e3PyFN4Dj6MFbBb6JVOj0JoMWY+S3AE=;
        b=t0DginiMHaAR7NjvRmeKXbwCWraVDF2HC/uwWW5JhkBfYNldEBmigGTpkE9dzM1dyT
         fa8nq2M598J2RYG6Fxwt7oPYtIqCrnT60LtzwKPoMOCiBAGdGB7V/zyDojViooT26Izz
         CUgfQhGY3OrKlgdku8IgTjCoaixmteAAVfOWwYehdCsRrol97y8Qc0pFNIQ+t1P/ZtGt
         QVtNsKArirTNneUHoEgW7FdGnOrWO5J/kxjaWwARFOtTRgsNm29wZs4ZmJ5vGO0kfKC3
         sAhEWH5BD4BQ+Hf5uAIoxW/QyalLaudpuU4VRVIx0fainhDgqbD7M+sW1+8tVh218dI0
         us/Q==
X-Gm-Message-State: APjAAAVw8/wgzYDZTprZKKDRPLg2DFND+7EkMFqNurX5SFtMrfvg57vf
        xafOos5lLWrLoJh6xBfKShiuIgUWlskrvLsxIEe+JQ==
X-Google-Smtp-Source: APXvYqwoI3V0DEHS32l9wQXVJE8EeGtjkg4VAjYe1lFrEIq00wE4DXN1gIePuof1MESKaL2zUS9xhTdMaCNp6fuM05o=
X-Received: by 2002:a9d:1c8f:: with SMTP id l15mr16022901ota.313.1572902369377;
 Mon, 04 Nov 2019 13:19:29 -0800 (PST)
MIME-Version: 1.0
References: <20191030013701.39647-1-almasrymina@google.com>
 <20191030013701.39647-5-almasrymina@google.com> <1c060bde-8d44-146c-6d67-a7b145aa1b59@oracle.com>
 <CAHS8izPTvybLq9Y9Fn6Z+hSc7gLP+goQ-ixzjxa1XJ-qhWM8ow@mail.gmail.com> <a5f991c8-3f74-6000-cbd3-09fb8626e3f5@oracle.com>
In-Reply-To: <a5f991c8-3f74-6000-cbd3-09fb8626e3f5@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 4 Nov 2019 13:19:18 -0800
Message-ID: <CAHS8izMYaHf-3zeVcM_73_KSMCpA5vds-NtRjNt0d8VsMfczQw@mail.gmail.com>
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

On Mon, Nov 4, 2019 at 1:15 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 11/4/19 1:04 PM, Mina Almasry wrote:
> > On Fri, Nov 1, 2019 at 4:23 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >>
> >> On 10/29/19 6:36 PM, Mina Almasry wrote:
> >>>  static long add_reservation_in_range(struct resv_map *resv, long f, long t,
> >>> -                                  bool count_only)
> >>> +                                  long *regions_needed, bool count_only)
> >>>  {
> >>> -     long chg = 0;
> >>> +     long add = 0;
> >>>       struct list_head *head = &resv->regions;
> >>> +     long last_accounted_offset = f;
> >>>       struct file_region *rg = NULL, *trg = NULL, *nrg = NULL;
> >>>
> >>> -     /* Locate the region we are before or in. */
> >>> -     list_for_each_entry (rg, head, link)
> >>> -             if (f <= rg->to)
> >>> -                     break;
> >>> +     if (regions_needed)
> >>> +             *regions_needed = 0;
> >>>
> >>> -     /* Round our left edge to the current segment if it encloses us. */
> >>> -     if (f > rg->from)
> >>> -             f = rg->from;
> >>> -
> >>> -     chg = t - f;
> >>> +     /* In this loop, we essentially handle an entry for the range
> >>> +      * [last_accounted_offset, rg->from), at every iteration, with some
> >>> +      * bounds checking.
> >>> +      */
> >>> +     list_for_each_entry_safe(rg, trg, head, link) {
> >>> +             /* Skip irrelevant regions that start before our range. */
> >>> +             if (rg->from < f) {
> >>> +                     /* If this region ends after the last accounted offset,
> >>> +                      * then we need to update last_accounted_offset.
> >>> +                      */
> >>> +                     if (rg->to > last_accounted_offset)
> >>> +                             last_accounted_offset = rg->to;
> >>> +                     continue;
> >>> +             }
> >>>
> >>> -     /* Check for and consume any regions we now overlap with. */
> >>> -     nrg = rg;
> >>> -     list_for_each_entry_safe (rg, trg, rg->link.prev, link) {
> >>> -             if (&rg->link == head)
> >>> -                     break;
> >>> +             /* When we find a region that starts beyond our range, we've
> >>> +              * finished.
> >>> +              */
> >>>               if (rg->from > t)
> >>>                       break;
> >>>
> >>> -             /* We overlap with this area, if it extends further than
> >>> -              * us then we must extend ourselves.  Account for its
> >>> -              * existing reservation.
> >>> +             /* Add an entry for last_accounted_offset -> rg->from, and
> >>> +              * update last_accounted_offset.
> >>>                */
> >>> -             if (rg->to > t) {
> >>> -                     chg += rg->to - t;
> >>> -                     t = rg->to;
> >>> +             if (rg->from > last_accounted_offset) {
> >>> +                     add += rg->from - last_accounted_offset;
> >>> +                     if (!count_only) {
> >>> +                             nrg = get_file_region_entry_from_cache(
> >>> +                                     resv, last_accounted_offset, rg->from);
> >>> +                             list_add(&nrg->link, rg->link.prev);
> >>> +                     } else if (regions_needed)
> >>> +                             *regions_needed += 1;
> >>>               }
> >>> -             chg -= rg->to - rg->from;
> >>>
> >>> -             if (!count_only && rg != nrg) {
> >>> -                     list_del(&rg->link);
> >>> -                     kfree(rg);
> >>> -             }
> >>> +             last_accounted_offset = rg->to;
> >>
> >> That last assignment is unneeded.  Correct?
> >>
> >
> > Not to make you nervous, but this assignment is needed.
> >
> > The basic idea is that there are 2 loop invariants here:
> > 1. Everything before last_accounted_offset is filled in with file_regions.
> > 2. rg points to the first region past last_account_offset.
> >
> > Each loop iteration compares rg->from to last_accounted_offset, and if
> > there is a gap, it creates a new region to fill this gap. Then this
> > assignment restores loop invariant #2 by assigning
> > last_accounted_offset to rg->to, since now everything before rg->to is
> > filled in with file_regions.
> >
>
> My apologies!
>
> >>>       }
> >>>
> >>> -     if (!count_only) {
> >>> -             nrg->from = f;
> >>> -             nrg->to = t;
> >>> +     /* Handle the case where our range extends beyond
> >>> +      * last_accounted_offset.
> >>> +      */
> >>> +     if (last_accounted_offset < t) {
> >>> +             add += t - last_accounted_offset;
> >>> +             if (!count_only) {
> >>> +                     nrg = get_file_region_entry_from_cache(
> >>> +                             resv, last_accounted_offset, t);
> >>> +                     list_add(&nrg->link, rg->link.prev);
> >>> +             } else if (regions_needed)
> >>> +                     *regions_needed += 1;
> >>> +             last_accounted_offset = t;
>
> The question about an unnecessary assignment was supposed to be
> directed at the above line.
>

Oh, yes. That assignment is completely unnecessary; the function just
exits after pretty much. Will remove, thanks!

> --
> Mike Kravetz
>
>
> >>>       }
> >>>
> >>> -     return chg;
> >>> +     return add;
> >>>  }
