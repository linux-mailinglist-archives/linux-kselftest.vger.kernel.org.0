Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38E65BFC8B
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2019 02:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfI0Azn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Sep 2019 20:55:43 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43209 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbfI0Azn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Sep 2019 20:55:43 -0400
Received: by mail-oi1-f195.google.com with SMTP id t84so3768041oih.10
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Sep 2019 17:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w6GtUWD65Sb2e3DNABoXgvvmVNvez3XhNPll/iTmngk=;
        b=mWJcqqxG0yvWUhw/T7tKy9RfvCH7jcGWz8miRGuWvLmTwqKJ3ZfLN2t5FDY/5MGWhf
         ksuRq1AECJHnDrA0xQt+a4UYEbD8UkzPJY+fqn/8NAyINpG17nBfdXvau2HnxCbKLB1Q
         vf3nugrT7CDycCO9Lf4mLAu/WO/MIupOReMgVMjTF7NEWU6zQNqyxdetxF3YH28a1ZE7
         /oE/UleTqIWRhPtcbsdoFfbHxLRkhc4HjmCAKBGLYDpgy3dSsWZK6MjWZWl9GC9MMWmC
         drBPJKlLe2xE4nQfIjgf1D707tvSN6vOQoL8hN1DcuGOl6hhyjnrpkGzuysSkBASGQAo
         R6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w6GtUWD65Sb2e3DNABoXgvvmVNvez3XhNPll/iTmngk=;
        b=snjioolm3cOrnuXHKhTKH+/T6nUyTXHkNI3E8tKKudghC2O2NdLHpcoBEAPAJO7i5P
         KqhlfsXavWAwDMxOY9qe/c57qHDV03Ur2VsDQb1cMZGtx2WaSVlB2HII9oM5C3CzoA6v
         KatFLHikiT9ybjhj4BVmluml/iGRvD6v398p/rNOxeEEq3a/Kv2xe3EuQJ3lEW+FwLXG
         NUc6CcktY3V+RFzH9opFmvLFDZ+VdWcx+7U76SNZbmaGZfY25fjchSrU5cmhMMBYwzVj
         0Fm5qPjM+hYMrKXU21S4FtNfPlTp36bQpDfCmf1GWBkaJzrjBCYke0o0Y5FlBC2IkgjJ
         rPog==
X-Gm-Message-State: APjAAAU+rnHMW+/RBOblaiHohgi00q7g4LuHy4+oJLF3Ltvi37U0OSD6
        YbPDbEYLs1txkT0vfvQYE7NcAPYkB3E57PE+JN0Nuw==
X-Google-Smtp-Source: APXvYqxaOUtFksyd5tFVpugObKeftAVgGeD3PicNGLqGrAfqoaEha1rcj49CSeZUiGTh6XZYzJwpS6/fjcHQVM057qs=
X-Received: by 2002:aca:cf51:: with SMTP id f78mr5004751oig.8.1569545740466;
 Thu, 26 Sep 2019 17:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190919222421.27408-1-almasrymina@google.com>
 <3c73d2b7-f8d0-16bf-b0f0-86673c3e9ce3@oracle.com> <CAHS8izOj2AT4tX-+Hcb8LB2TOUKJDHScDtJ80u4M6OWpwktq0g@mail.gmail.com>
 <a8e9c533-1593-35ee-e65d-1f2fc2b0fb48@oracle.com> <CAHS8izPfKQA8qTndyzWSm9fR_xJ=X-xmE+4P4K+ZFdxrYNuLBA@mail.gmail.com>
 <alpine.DEB.2.21.1909261220150.39830@chino.kir.corp.google.com> <8f7db4f1-9c16-def5-79dc-d38d6b9d150e@oracle.com>
In-Reply-To: <8f7db4f1-9c16-def5-79dc-d38d6b9d150e@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 26 Sep 2019 17:55:29 -0700
Message-ID: <CAHS8izM3=ZDNukx5xhWmeJT+78Ekfff9J4s5Vqkqpx-DtH=C-A@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] hugetlb_cgroup: Add hugetlb_cgroup reservation limits
To:     Mike Kravetz <mike.kravetz@oracle.com>, Tejun Heo <tj@kernel.org>
Cc:     David Rientjes <rientjes@google.com>,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
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

On Thu, Sep 26, 2019 at 2:23 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 9/26/19 12:28 PM, David Rientjes wrote:
> > On Tue, 24 Sep 2019, Mina Almasry wrote:
> >
> >>> I personally prefer the one counter approach only for the reason that it
> >>> exposes less information about hugetlb reservations.  I was not around
> >>> for the introduction of hugetlb reservations, but I have fixed several
> >>> issues having to do with reservations.  IMO, reservations should be hidden
> >>> from users as much as possible.  Others may disagree.
> >>>
> >>> I really hope that Aneesh will comment.  He added the existing hugetlb
> >>> cgroup code.  I was not involved in that effort, but it looks like there
> >>> might have been some thought given to reservations in early versions of
> >>> that code.  It would be interesting to get his perspective.
> >>>
> >>> Changes included in patch 4 (disable region_add file_region coalescing)
> >>> would be needed in a one counter approach as well, so I do plan to
> >>> review those changes.
> >>
> >> OK, FWIW, the 1 counter approach should be sufficient for us, so I'm
> >> not really opposed. David, maybe chime in if you see a problem here?
> >> From the perspective of hiding reservations from the user as much as
> >> possible, it is an improvement.
> >>
> >> I'm only wary about changing the behavior of the current and having
> >> that regress applications. I'm hoping you and Aneesh can shed light on
> >> this.
> >>
> >
> > I think neither Aneesh nor myself are going to be able to provide a
> > complete answer on the use of hugetlb cgroup today, anybody could be using
> > it without our knowledge and that opens up the possibility that combining
> > the limits would adversely affect a real system configuration.
>
> I agree that nobody can provide complete information on hugetlb cgroup usage
> today.  My interest was in anything Aneesh could remember about development
> of the current cgroup code.  It 'appears' that the idea of including
> reservations or mmap ranges was considered or at least discussed.  But, those
> discussions happened more than 7 years old and my searches are not providing
> a complete picture.  My hope was that Aneesh may remember those discussions.
>
> > If that is a possibility, I think we need to do some due diligence and try
> > to deprecate allocation limits if possible.  One of the benefits to
> > separate limits is that we can make reasonable steps to deprecating the
> > actual allocation limits, if possible: we could add warnings about the
> > deprecation of allocation limits and see if anybody complains.
> >
> > That could take the form of two separate limits or a tunable in the root
> > hugetlb cgroup that defines whether the limits are for allocation or
> > reservation.
> >
> > Combining them in the first pass seems to be very risky and could cause
> > pain for users that will not detect this during an rc cycle and will
> > report the issue only when their distro gets it.  Then we are left with no
> > alternative other than stable backports and the separation of the limits
> > anyway.
>
> I agree that changing behavior of the existing controller is too risky.
> Such a change is likely to break someone.

I'm glad we're converging on keeping the existing behavior unchanged.

> The more I think about it, the
> best way forward will be to retain the existing controller and create a
> new controller that satisfies the new use cases.

My guess is that a new controller needs to support cgroups-v2, which
is fine. But can a new controller also support v1? Or is there a
requirement that new controllers support *only* v2? I need whatever
solution here to work on v1. Added Tejun to hopefully comment on this.

>The question remains as
> to what that new controller will be.  Does it control reservations only?
> Is it a combination of reservations and allocations?  If a combined
> controller will work for new use cases, that would be my preference.  Of
> course, I have not prototyped such a controller so there may be issues when
> we get into the details.  For a reservation only or combined controller,
> the region_* changes proposed by Mina would be used.

Provided we keep the existing controller untouched, should the new
controller track:

1. only reservations, or
2. both reservations and allocations for which no reservations exist
(such as the MAP_NORESERVE case)?

I like the 'both' approach. Seems to me a counter like that would work
automatically regardless of whether the application is allocating
hugetlb memory with NORESERVE or not. NORESERVE allocations cannot cut
into reserved hugetlb pages, correct? If so, then applications that
allocate with NORESERVE will get sigbused when they hit their limit,
and applications that allocate without NORESERVE may get an error at
mmap time but will always be within their limits while they access the
mmap'd memory, correct? So the 'both' counter seems like a one size
fits all.

I think the only sticking point left is whether an added controller
can support both cgroup-v2 and cgroup-v1. If I could get confirmation
on that I'll provide a patchset.

> --
> Mike Kravetz
