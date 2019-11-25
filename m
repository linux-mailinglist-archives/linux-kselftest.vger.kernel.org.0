Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 724F51094A2
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2019 21:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbfKYU0R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Nov 2019 15:26:17 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38867 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfKYU0R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Nov 2019 15:26:17 -0500
Received: by mail-oi1-f196.google.com with SMTP id a14so14403517oid.5
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Nov 2019 12:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DKKdY/q3lNftQghtZeAaOsYK6znTtzTrgTi/w5h+tow=;
        b=TlytCtiMUHVpaQyaQIuS+rZUry8rmKjF69OSJud5A0h2Wr9KYlctd0s43Ead2AEqNp
         X6V6cB54kskX1GRqSX3ve28ajyhml9zHZCf7uy5D06qcjHyFFGD1hsrXkJQA0m16bsog
         N/Wwv9aYcvmUjT2XkiYdGFxY0Hma59mOFL8O3d44Uw3A0z/gz6fmvbKA0sx/FIP28OLU
         utPxVKdL5V9bpE7zZ5KBuFf3Lg2Ee/xdg0IZUoJf0kpu62dJ5uG7ifmtfUVFJ08OSvof
         oqrHPhZroXZVM/1tpIwFSwtQyH/OmZc4VfeuCk8Ky8Mx4XPkF5b8yO6YhQ5sIQA9S4r5
         RglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DKKdY/q3lNftQghtZeAaOsYK6znTtzTrgTi/w5h+tow=;
        b=UU3ueZjcVcoYJAvhGiJqKfcV+nvQzDzp4LRM71X1c9TXZvi4r7cyJ+IzQRIQuKd4JN
         YYfHPv8Hs2NGBStbloPEg7jJAI9zXZIJkR2lzDDfH51djlL7LxR7AXEONrA2WspIQW8X
         rmsF74dhiCSIjnzAqUVE9v5PTl3XcCZvd48jmgBuTl10ffCBxGfMy5AwfwU1dicu2Gai
         qQ0Nuu5pxzwDISIHY2M9+/cIfm96uibmc493H+4QxpODrcaHEuzoMsxRDoz/LT03Jlbz
         F1BaytNIfTHCuBjHZpt/ZWo8QU/cShuyM0WJY1Vml6kYjrV6BvKV+yVkYm4/b41eO2HI
         tcog==
X-Gm-Message-State: APjAAAXm4s3v3u56Ls930iJ3Kpy0rJ3q88/hoKKKCDA6Z70izt0ZvdZY
        JofSDRH+E2r7n4JtAuWzQAPEVCyp5Cq0m0SYyVDJeA==
X-Google-Smtp-Source: APXvYqzc2860jizXkOUCI7yrri9CcJoPhft26y04wmGjBbbm36O8nDjFxY8Ik9f83CDi+0tUYVYoxWiiRcUP3MwNyP0=
X-Received: by 2002:a05:6808:352:: with SMTP id j18mr603682oie.67.1574713575912;
 Mon, 25 Nov 2019 12:26:15 -0800 (PST)
MIME-Version: 1.0
References: <20191030013701.39647-1-almasrymina@google.com>
 <20191030013701.39647-2-almasrymina@google.com> <9e10c273-f0ab-4173-570e-26c314b989fb@oracle.com>
 <CAHS8izMMK2cQMSmnteXA7YTFp2ZoZEm5kUwf8=+6nA+BC49XAQ@mail.gmail.com>
 <3f30658c-0e3d-7d5c-4de9-1526b9bac3ce@oracle.com> <CAHS8izNgRZxJKgOfAkDAG9j_=TB=2v0hQyYpQQKCf8xb3rQkVg@mail.gmail.com>
 <d94501f3-66cf-95b1-1159-e003207e3969@oracle.com>
In-Reply-To: <d94501f3-66cf-95b1-1159-e003207e3969@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 25 Nov 2019 12:26:04 -0800
Message-ID: <CAHS8izMFAYTgxym-Hzb_JmkTK1N_S9tGN71uS6MFV+R7swYu5A@mail.gmail.com>
Subject: Re: [PATCH v8 2/9] hugetlb_cgroup: add interface for charge/uncharge
 hugetlb reservations
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>
Cc:     shuah <shuah@kernel.org>, open list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 8, 2019 at 4:46 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 11/8/19 4:40 PM, Mina Almasry wrote:
> > On Fri, Nov 8, 2019 at 4:01 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >>
> >> On 11/8/19 3:48 PM, Mina Almasry wrote:
> >>> On Thu, Nov 7, 2019 at 4:57 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >>>>
> >>>> On 10/29/19 6:36 PM, Mina Almasry wrote:
> >>>>> @@ -22,27 +22,35 @@ struct hugetlb_cgroup;
> >>>>>   * Minimum page order trackable by hugetlb cgroup.
> >>>>>   * At least 3 pages are necessary for all the tracking information.
> >>>>>   */
> >>>>> -#define HUGETLB_CGROUP_MIN_ORDER     2
> >>>>> +#define HUGETLB_CGROUP_MIN_ORDER 3
> >>>>
> >>>> Correct me if misremembering, but I think the reson you changed this was
> >>>> so that you could use page[3].private.  Correct?
> >>>> In that case isn't page[3] the last page of an order 2 allocation?
> >>>> If my understanding is correct, then leave HUGETLB_CGROUP_MIN_ORDER as is
> >>>> and update the preceding comment to say that at least 4 pages are necessary.
> >>>>
> >>>
> >>> Yes, I just misunderstood what MIN_ORDER means. I'll revert the code change.
> >>
> >> But, do update the comment please.
> >>
> >
> > Will do.
> >
> >> <snip>
> >>>>> @@ -85,18 +89,32 @@ static void hugetlb_cgroup_init(struct hugetlb_cgroup *h_cgroup,
> >>>>>       int idx;
> >>>>>
> >>>>>       for (idx = 0; idx < HUGE_MAX_HSTATE; idx++) {
> >>>>> -             struct page_counter *counter = &h_cgroup->hugepage[idx];
> >>>>>               struct page_counter *parent = NULL;
> >>>>
> >>>> Should we perhaps rename 'parent' to 'fault_parent' to be consistent?
> >>>
> >>> Yes that makes sense; will do.
> >>>
> >>>> That makes me think if perhaps the naming in the previous patch should
> >>>> be more explicit.  Make the existing names explicitly contin 'fault' as
> >>>> the new names contain 'reservation'.
> >>>> Just a thought.
> >>>>
> >>>
> >>> You mean change the names of the actual user-facing files? I'm all for
> >>> better names but that would break existing users that read/write the
> >>> hugetlb_cgroup.2MB.usage_in_bytes/limit_in_bytes users, and so I would
> >>> assume is a no-go.
> >>>
> >>
> >> I was thinking about internal variables/definitions such as:
> >>
> >> +enum {
> >> + /* Tracks hugetlb memory faulted in. */
> >> + HUGETLB_RES_USAGE,
> >> + /* Tracks hugetlb memory reserved. */
> >> + HUGETLB_RES_RESERVATION_USAGE,
> >> + /* Limit for hugetlb memory faulted in. */
> >> + HUGETLB_RES_LIMIT,
> >> + /* Limit for hugetlb memory reserved. */
> >> + HUGETLB_RES_RESERVATION_LIMIT,
> >> + /* Max usage for hugetlb memory faulted in. */
> >> + HUGETLB_RES_MAX_USAGE,
> >> + /* Max usage for hugetlb memory reserved. */
> >> + HUGETLB_RES_RESERVATION_MAX_USAGE,
> >> + /* Faulted memory accounting fail count. */
> >> + HUGETLB_RES_FAILCNT,
> >> + /* Reserved memory accounting fail count. */
> >> + HUGETLB_RES_RESERVATION_FAILCNT,
> >> + HUGETLB_RES_NULL,
> >> + HUGETLB_RES_MAX,
> >> +};
> >>
> >> But, I guess the existing definitions (such as HUGETLB_RES_LIMIT) correspond
> >> closely to the externally visible name.  In that case, you should leave them
> >> as is and ignore my comment.
> >>
> >> <ship>
> >>>>> @@ -126,6 +144,26 @@ static void hugetlb_cgroup_css_free(struct cgroup_subsys_state *css)
> >>>>>       kfree(h_cgroup);
> >>>>>  }
> >>>>>
> >>>>> +static void hugetlb_cgroup_move_parent_reservation(int idx,
> >>>>> +                                                struct hugetlb_cgroup *h_cg)
> >>>>> +{
> >>>>> +     struct hugetlb_cgroup *parent = parent_hugetlb_cgroup(h_cg);
> >>>>> +
> >>>>> +     /* Move the reservation counters. */
> >>>>> +     if (!parent_hugetlb_cgroup(h_cg)) {
> >>>>> +             parent = root_h_cgroup;
> >>>>> +             /* root has no limit */
> >>>>> +             page_counter_charge(
> >>>>> +                     &root_h_cgroup->reserved_hugepage[idx],
> >>>>> +                     page_counter_read(
> >>>>> +                             hugetlb_cgroup_get_counter(h_cg, idx, true)));
> >>>>> +     }
> >>>>> +
> >>>>> +     /* Take the pages off the local counter */
> >>>>> +     page_counter_cancel(
> >>>>> +             hugetlb_cgroup_get_counter(h_cg, idx, true),
> >>>>> +             page_counter_read(hugetlb_cgroup_get_counter(h_cg, idx, true)));
> >>>>> +}
> >>>>
> >>>> I know next to nothing about cgroups and am just comparing this to the
> >>>> existing hugetlb_cgroup_move_parent() routine.  hugetlb_cgroup_move_parent
> >>>> updates the cgroup pointer in each page being moved.  Do we need to do
> >>>> something similar for reservations being moved (move pointer in reservation)?
> >>>>
> >>>
> >>> Oh, good catch. Yes I need to be doing that. I should probably
> >>> consolidate those routines so the code doesn't miss things like this.
> >>
> >> This might get a bit ugly/complicated?  Seems like you will need to examine
> >> all hugetlbfs inodes and vma's mapping those inodes.
> >>
> >
> > Hmm yes on closer look it does seem like this is not straightforward.
> > I'll write a test that does this reparenting so I can start running
> > into the issue and poke for solutions. Off the top of my head, I think
> > maybe we can just not reparent the hugetlb reservations - the
> > hugetlb_cgroup stays alive until all its memory is uncharged. That
> > shouldn't be too bad. Today, I think memcg doesn't reparent memory
> > when it gets offlined.
> >
> > I'll poke at this a bit and come back with suggestions, you may want
> > to hold off reviewing the rest of the patches until then.
>
>
> Ok, if we start considering what the correct cgroup reparenting semantics
> should be it would be good to get input from others with more cgroup
> experience.
>

So I looked into this and prototyped a couple of solutions:

1. We could repartent the hugetlb reservation using the same approach
that today we repartent hugetlb faults. Basically today faulted
hugetlb pages live on hstate->hugepage_activelist. When a hugetlb
cgroup gets offlined, this list is transversed and any pages on it
that point to the cgroup being offlined and reparented. hugetlb_lock
is used to make sure cgroup offlining doesn't race with a page being
freed. I can add another list, but one that has pointers to the
reservations made. When the cgroup is being offlined, it transverses
this list, and reparents any reservations (which will need to acquire
the proper resv_map->lock to do the parenting). hugetlb_lock needs
also to be acquired here to make sure that resv_map release doesn't
race with another thread reparenting the memory in that resv map.

Pros: Maintains current parenting behavior, and makes sure that
reparenting of reservations works exactly the same way as reparenting
of hugetlb faults.
Cons: Code is a bit complex. There may be subtle object lifetime bugs,
since I'm not 100% sure acquiring hugetlb_lock removes all races.

2. We could just not reparent hugetlb reservations. I.e. on hugetlb
cgroup offlining, the hugetlb faults get reparented (which maintains
current user facing behavior), but hugetlb reservation charges remain
charged to the hugetlb cgroup. The cgroup lives as a zombie until all
the reservations are uncharged.

Pros: Much easier implementation. Converges behavior of memcg and
hugetlb cgroup, since memcg also doesn't reparent memory charged to
it.
Cons: Behavior change as hugetlb cgroups will become zombies if there
are reservations charged to them. I've discussed offlist with Shakeel,
and AFAICT there are absolutely no user facing behavior change to
zombie cgroups. Only if the user is specifically detecting for
zombies.

I'm torn between these 2 options right now, but leaning towards #2. I
think I will propose #2 in a patch for review, and if anyone is broken
by that (again, my understanding is that is very unlikely), then I
propose a patch that reverts the changes in #2 and implements the
changes in #1.

Any feedback from Shakeel or other people with cgroup expertise
(especially for hugetlb cgroup or memcg)  is very useful here.

> --
> Mike Kravetz
