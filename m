Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69DE89077A
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2019 20:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfHPSGx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Aug 2019 14:06:53 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45655 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfHPSGw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Aug 2019 14:06:52 -0400
Received: by mail-ot1-f68.google.com with SMTP id m24so10303728otp.12
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2019 11:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PPWBwrTYQiyPgQwYhqsU+jPTEkc43rpRsbunSoEPTXY=;
        b=tHAtUQNoRigMxBjYxcjgeMp0HzqDjLMh774KWtbYJ1LQ5I8/YSZtc6DBKXy7huNkI+
         jFqyWs1eRi1MKaZTXrUrdwzez3KOVu2936JexjJmm8LMfGbwcDOblo5QYEN8fRyjunvC
         Z9kTFWMD+Ni7K84Wzxwq5VexnsJE8/s8Zc4vTbtU1W9N5OOs0z/SUTVtnlnK6yx/SnC9
         WKDufjpb944iFy4o8IWTkPvNfpzfXxEKzvDj0MosYUuOFq0DZHNGCyz/PTPEdh6hSEpc
         w2CaM4qxsJJFyrs/b1443YiKkoxPt85jPxYCC/xxwXbSe5wXfGFzQsH1+aMWzX/mlmjU
         6o5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PPWBwrTYQiyPgQwYhqsU+jPTEkc43rpRsbunSoEPTXY=;
        b=Ml7l/nNvgvffv1+zrCLVVmuktWt6twBUwpDBJM9JsIIzg2ZpRZs3kBm/YAwHCbvICe
         rxpw1S9qeJXvwCAManhBbJqPKdGiEP6xqLxcqwgxQSdBdbCt3IKyRSDN44gzI8Bf8857
         YH0+YMbFbsX1zsBKGhP/2aKAkPcD1kR8NOJtOFx+qeO7ApHbkK6oLV3QMr2LVZVsuBeq
         fln6LWxFtl8FYvdGA6Ey7CM6HlVWA1bm/F2jvjexHOO9dIQYWcMY4BgfnUNHHr6FyPBx
         9dcCOWIUr8YEXa7HFxsor6uQE1tLQkz7cVEpDVqgptYd1bqwmMo/Et2Yc77Hsq/f5GJY
         u7Gg==
X-Gm-Message-State: APjAAAURsFliXPeVzCQ2kB88TjpceXtO7Rsl9aCWl8mht9e0A/EvQaxF
        y1rvWrtOSbAzdMz8jixmeaf0svY39r4/io9GEXumzQ==
X-Google-Smtp-Source: APXvYqxf4xeIU6DFzNAgjmuDV+1QL372RcNMsRPvtUB1Bn4CiSOT/q++7Rgs1rbxreyBn9D9iUu6RJ73UUHVBqbJ7UY=
X-Received: by 2002:a9d:70c6:: with SMTP id w6mr6957681otj.349.1565978811093;
 Fri, 16 Aug 2019 11:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190808231340.53601-1-almasrymina@google.com>
 <20190808231340.53601-5-almasrymina@google.com> <47cfc50d-bea3-0247-247e-888d2942f134@oracle.com>
 <9872cec9-a0fe-cfe0-0df6-90b6dd909f04@oracle.com> <CAHS8izOv3GjKhnzVmksfH0U9xZ6OnC0R-XEZsqVxOvrJ5u_BBw@mail.gmail.com>
 <bfa1cffd-bceb-6f69-419e-3fa173359701@oracle.com>
In-Reply-To: <bfa1cffd-bceb-6f69-419e-3fa173359701@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 16 Aug 2019 11:06:40 -0700
Message-ID: <CAHS8izNwnHDap-2EP3X2775rL+aRj3U4=QgOSnhgO9oJOwi-0w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/5] hugetlb_cgroup: Add accounting for shared mappings
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, open list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 16, 2019 at 9:29 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 8/15/19 4:04 PM, Mina Almasry wrote:
> > On Wed, Aug 14, 2019 at 9:46 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >>
> >> On 8/13/19 4:54 PM, Mike Kravetz wrote:
> >>> On 8/8/19 4:13 PM, Mina Almasry wrote:
> >>>> For shared mappings, the pointer to the hugetlb_cgroup to uncharge lives
> >>>> in the resv_map entries, in file_region->reservation_counter.
> >>>>
> >>>> When a file_region entry is added to the resv_map via region_add, we
> >>>> also charge the appropriate hugetlb_cgroup and put the pointer to that
> >>>> in file_region->reservation_counter. This is slightly delicate since we
> >>>> need to not modify the resv_map until we know that charging the
> >>>> reservation has succeeded. If charging doesn't succeed, we report the
> >>>> error to the caller, so that the kernel fails the reservation.
> >>>
> >>> I wish we did not need to modify these region_() routines as they are
> >>> already difficult to understand.  However, I see no other way with the
> >>> desired semantics.
> >>>
> >>
> >> I suspect you have considered this, but what about using the return value
> >> from region_chg() in hugetlb_reserve_pages() to charge reservation limits?
> >> There is a VERY SMALL race where the value could be too large, but that
> >> can be checked and adjusted at region_add time as is done with normal
> >> accounting today.
> >
> > I have not actually until now; I didn't consider doing stuff with the
> > resv_map while not holding onto the resv_map->lock. I guess that's the
> > small race you're talking about. Seems fine to me, but I'm more
> > worried about hanging off the vma below.
>
> This race is already handled for other 'reservation like' things in
> hugetlb_reserve_pages.  So, I don't think the race is much of an issue.
>
> >> If the question is, where would we store the information
> >> to uncharge?, then we can hang a structure off the vma.  This would be
> >> similar to what is done for private mappings.  In fact, I would suggest
> >> making them both use a new cgroup reserve structure hanging off the vma.
> >>
> >
> > I actually did consider hanging off the info to uncharge off the vma,
> > but I didn't for a couple of reasons:
> >
> > 1. region_del is called from hugetlb_unreserve_pages, and I don't have
> > access to the vma there. Maybe there is a way to query the proper vma
> > I don't know about?
>
> I am still thinking about closely tying cgroup revervation limits/usage
> to existing reservation accounting.  Of most concern (to me) is handling
> shared mappings.  Reservations created for shared mappings are more
> associated with the inode/file than individual mappings.  For example,
> consider a task which mmaps(MAP_SHARED) a hugetlbfs file.  At mmap time
> reservations are created based on the size of the mmap.  Now, if the task
> unmaps and/or exits the reservations still exist as they are associated
> with the file rather than the mapping.
>

I'm aware of this behavior, and IMO it seems fine to me. I believe it
works the same way with tmfs today. I think a task that creates a file
in tmpfs gets charged the memory, and even if the task exits the
memory is still charged to its cgroup, and the memory remains charged
until the tmpfs file is deleted by someone.

Makes sense to me for hugetlb reservations to work the same way. The
memory remains charged until the hugetlbfs file gets deleted. But, if
you think of improvement, I'm happy to oblige :)

> Honesty, I think this existing reservation bevahior is wrong or at least
> not desirable.  Because there are outstanding reservations, the number of
> reserved huge pages can not be used for other purposes.  It is also very
> difficult for a user or admin to determine the source of the reservations.
> No one is currently complaining about this behavior.  This proposal just
> made me think about it.
>
> Tying cgroup reservation limits/usage to existing reservation accounting
> will introduce the same issues there.  We will need to clearly document the
> behavior.
>

Yes, seems we're maybe converging on a solution here, so the next
patchset will include docs for your review.

> > 2. hugetlb_reserve_pages seems to be able to conduct a reservation
> > with a NULL *vma. Not sure what to do in that case.
> >
> > Is there a way to get around these that I'm missing here?
>
> You are correct.  The !vma case is there for System V shared memory such
> as a call to shmget(SHM_HUGETLB).  In this case, reservations for the
> entire shared emmory segment are taken at shmget time.
>
> In your model, the caller of shmget who creates the shared memory segment
> would get charged for all the reservations.  Users, (those calling shmat)
> would not be charged.
>
> > FWIW I think tracking is better in resv_map since the reservations are
> > in resv_map themselves. If I do another structure, then for each
> > reservation there will be an entry in resv_map and an entry in the new
> > structure and they need to be kept in sync and I need to handle errors
> > for when they get out of sync.
>
> I think you may be correct.  However, this implies that we will need to
> change the way we do reservation in the resv_map for shared mappings.
> I will comment on that in reply to patch 4.
>
> --
> Mike Kravetz
