Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDA0BD509
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2019 00:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410943AbfIXWmT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Sep 2019 18:42:19 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45240 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394329AbfIXWmS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Sep 2019 18:42:18 -0400
Received: by mail-oi1-f196.google.com with SMTP id o205so3151994oib.12
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2019 15:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tLGshlxIGKhLcXUM0uB8QvsR7iqHi3kS/y0xfRKm0lM=;
        b=lyFd6NKLnJffQTtK5uJBQQ7012wiEa8kfPQp3MvPsNG1KoPM+uZ5DOeXAsSVsHhhYl
         9PhbUGy760gbP3AbAI0haHWUjXeqJuV1Ff6KFLenze+pOgXpQNk/UUV6EMPzIh6GiERb
         hkPoXs3KywobQJyS6dJIKtYbMWX+dcH1Z9IqG+y7mMINZC/6+WIH/ikyRo5vCTeBGtMw
         +z5T43aRRTA4BWjxL/E1O6WpxSwYPEa0ucXaZC+shiZ3dJlTMl4CE/iJfpZYB6WvXsEA
         dzUlZYOtCRyM+9PG+UnhpzsvSPW1o0SPzIAUOOhO0g+8rLEeXQY32mKBSxJefjDb4Fqr
         01+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tLGshlxIGKhLcXUM0uB8QvsR7iqHi3kS/y0xfRKm0lM=;
        b=O7yqAdbBanwi+0J/eSLLwGTJ4ClZM1IfDCYM6l6sHwe6xeQh3GJOYEJ7coD46vHv+z
         t44uSGiE0iHWPetuSzbeE5UKfj2nHUcQASPxlrePu0xxlfVvRoTJPOjWh/p3G41qlMoR
         88dzouGYRxqDvsEzJ33wiF9ZAY3RrVQw8YTXi+nEtDycLUJcnVHCsxWJAWprbNL66OFK
         /fpV3OtiMJzmv7tRylm3jYVXj1b8C77cD1U+Srojajr/y2sBTO/2a70Bcjw/8m/0vuMF
         QAUot8ZUecnwCZp0JVcHq8GA+Ij85rsBROMD4nKgI9uJk0pSMVJvNWISYhb1Cl8MeWEB
         5T0A==
X-Gm-Message-State: APjAAAUoD6QQTTHkSjUIzsdv/6drEto9BLK36T5bojuu7N7CWphYsdpU
        PaDGUeQvTjO3FyCMIMUx+FdiDMaUXsbLl3bB4Jc1lQ==
X-Google-Smtp-Source: APXvYqxZVGBQ9fz0kE/sF2k3P1ldR0v+pdangCAO2sUHr3CUBMWxeLaBd7YBg+8LTTLq4F/kNZH0k88J0CYWN/h5nSs=
X-Received: by 2002:aca:3954:: with SMTP id g81mr2235308oia.65.1569364937133;
 Tue, 24 Sep 2019 15:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190919222421.27408-1-almasrymina@google.com>
 <3c73d2b7-f8d0-16bf-b0f0-86673c3e9ce3@oracle.com> <CAHS8izOj2AT4tX-+Hcb8LB2TOUKJDHScDtJ80u4M6OWpwktq0g@mail.gmail.com>
 <a8e9c533-1593-35ee-e65d-1f2fc2b0fb48@oracle.com>
In-Reply-To: <a8e9c533-1593-35ee-e65d-1f2fc2b0fb48@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 24 Sep 2019 15:42:06 -0700
Message-ID: <CAHS8izPfKQA8qTndyzWSm9fR_xJ=X-xmE+4P4K+ZFdxrYNuLBA@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] hugetlb_cgroup: Add hugetlb_cgroup reservation limits
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Rientjes <rientjes@google.com>
Cc:     Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
        shuah <shuah@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        khalid.aziz@oracle.com, open list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 23, 2019 at 2:27 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 9/23/19 12:18 PM, Mina Almasry wrote:
> > On Mon, Sep 23, 2019 at 10:47 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >>
> >> On 9/19/19 3:24 PM, Mina Almasry wrote:
> >>> Patch series implements hugetlb_cgroup reservation usage and limits, which
> >>> track hugetlb reservations rather than hugetlb memory faulted in. Details of
> >>> the approach is 1/7.
> >>
> >> Thanks for your continued efforts Mina.
> >>
> >
> > And thanks for your reviews so far.
> >
> >> One thing that has bothered me with this approach from the beginning is that
> >> hugetlb reservations are related to, but somewhat distinct from hugetlb
> >> allocations.  The original (existing) huegtlb cgroup implementation does not
> >> take reservations into account.  This is an issue you are trying to address
> >> by adding a cgroup support for hugetlb reservations.  However, this new
> >> reservation cgroup ignores hugetlb allocations at fault time.
> >>
> >> I 'think' the whole purpose of any hugetlb cgroup is to manage the allocation
> >> of hugetlb pages.  Both the existing cgroup code and the reservation approach
> >> have what I think are some serious flaws.  Consider a system with 100 hugetlb
> >> pages available.  A sysadmin, has two groups A and B and wants to limit hugetlb
> >> usage to 50 pages each.
> >>
> >> With the existing implementation, a task in group A could create a mmap of
> >> 100 pages in size and reserve all 100 pages.  Since the pages are 'reserved',
> >> nobody in group B can allocate ANY huge pages.  This is true even though
> >> no pages have been allocated in A (or B).
> >>
> >> With the reservation implementation, a task in group A could use MAP_NORESERVE
> >> and allocate all 100 pages without taking any reservations.
> >>
> >> As mentioned in your documentation, it would be possible to use both the
> >> existing (allocation) and new reservation cgroups together.  Perhaps if both
> >> are setup for the 50/50 split things would work a little better.
> >>
> >> However, instead of creating a new reservation crgoup how about adding
> >> reservation support to the existing allocation cgroup support.  One could
> >> even argue that a reservation is an allocation as it sets aside huge pages
> >> that can only be used for a specific purpose.  Here is something that
> >> may work.
> >>
> >> Starting with the existing allocation cgroup.
> >> - When hugetlb pages are reserved, the cgroup of the task making the
> >>   reservations is charged.  Tracking for the charged cgroup is done in the
> >>   reservation map in the same way proposed by this patch set.
> >> - At page fault time,
> >>   - If a reservation already exists for that specific area do not charge the
> >>     faulting task.  No tracking in page, just the reservation map.
> >>   - If no reservation exists, charge the group of the faulting task.  Tracking
> >>     of this information is in the page itself as implemented today.
> >> - When the hugetlb object is removed, compare the reservation map with any
> >>   allocated pages.  If cgroup tracking information exists in page, uncharge
> >>   that group.  Otherwise, unharge the group (if any) in the reservation map.
> >>
> >> One of the advantages of a separate reservation cgroup is that the existing
> >> code is unmodified.  Combining the two provides a more complete/accurate
> >> solution IMO.  But, it has the potential to break existing users.
> >>
> >> I really would like to get feedback from anyone that knows how the existing
> >> hugetlb cgroup controller may be used today.  Comments from Aneesh would
> >> be very welcome to know if reservations were considered in development of the
> >> existing code.
> >> --
> >
> > FWIW, I'm aware of the interaction with NORESERVE and my thoughts are:
> >
> > AFAICT, the 2 counter approach we have here is strictly superior to
> > the 1 upgraded counter approach. Consider these points:
> >
> > - From what I can tell so far, everything you can do with the 1
> > counter approach, you can do with the two counter approach by setting
> > both limit_in_bytes and reservation_limit_in_bytes to the limit value.
> > That will limit both reservations and at fault allocations.
> >
> > - The 2 counter approach preserves existing usage of hugetlb cgroups,
> > so no need to muck around with reverting the feature some time from
> > now because of broken users. No existing users of hugetlb cgroups need
> > to worry about the effect of this on their usage.
> >
> > - Users that use hugetlb memory strictly through reservations can use
> > only reservation_limit_in_bytes and enjoy cgroup limits that never
> > SIGBUS the application. This is our usage for example.
> >
> > - The 2 counter approach provides more info to the sysadmin. The
> > sysadmin knows exactly how much reserved bytes there are via
> > reservation_usage_in_bytes, and how much actually in use bytes there
> > are via usage_in_bytes. They can even detect NORESERVE usage if
> > usage_in_bytes > reservation_usage_in_bytes. failcnt shows failed
> > reservations *and* failed allocations at fault, etc. All around better
> > debuggability when things go wrong. I think this is particularly
> > troubling for the 1 upgraded counter approach. That counter's
> > usage_in_bytes doesn't tell you if the usage came from reservations or
> > allocations at fault time.
> >
> > - Honestly, I think the 2 counter approach is easier to document and
> > understand by the userspace? 1 counter that vaguely tracks both the
> > reservations and usage and decides whether or not to charge at fault
> > time seems hard to understand what really happened after something
> > goes wrong. 1 counter that tracks reservations and 1 counter that
> > tracks actual usage seem much simpler to digest, and provide better
> > visibility to what the cgroup is doing as I mentioned above.
> >
> > I think it may be better if I keep the 2 counter approach but
> > thoroughly document the interaction between the existing counters and
> > NORESERVE. What do you think?
>
> I personally prefer the one counter approach only for the reason that it
> exposes less information about hugetlb reservations.  I was not around
> for the introduction of hugetlb reservations, but I have fixed several
> issues having to do with reservations.  IMO, reservations should be hidden
> from users as much as possible.  Others may disagree.
>
> I really hope that Aneesh will comment.  He added the existing hugetlb
> cgroup code.  I was not involved in that effort, but it looks like there
> might have been some thought given to reservations in early versions of
> that code.  It would be interesting to get his perspective.
>
> Changes included in patch 4 (disable region_add file_region coalescing)
> would be needed in a one counter approach as well, so I do plan to
> review those changes.

OK, FWIW, the 1 counter approach should be sufficient for us, so I'm
not really opposed. David, maybe chime in if you see a problem here?
From the perspective of hiding reservations from the user as much as
possible, it is an improvement.

I'm only wary about changing the behavior of the current and having
that regress applications. I'm hoping you and Aneesh can shed light on
this.

> --
> Mike Kravetz
