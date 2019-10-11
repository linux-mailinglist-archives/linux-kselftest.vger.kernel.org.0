Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD076D4838
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2019 21:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbfJKTKT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Oct 2019 15:10:19 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40106 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfJKTKS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Oct 2019 15:10:18 -0400
Received: by mail-oi1-f196.google.com with SMTP id k9so8919529oib.7
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2019 12:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eQy6FsVhMeNMB9gB/UP0lH5OqQZ9aItb6uOTcxZNCvo=;
        b=qOmYPAjMmx6jAFQshrjW/rvLdYI8s/aiGo4RRudcwxFjzFObiW0KS+yQ1VoMFj9kmO
         tjWHfsWzeaQrjHq8LK81IxqfP9OGcu/C1ZBJ4fT0CCpbg0rQ8zECtUJmI8BK2SF/GLei
         XWnlf+TPRqB7pp6TbAd8B4IU/zlQYUoP2tsX8p+RAYQaCdZkgWkVcrNjRpAh2fOvePf+
         3VpRoOkKmDnt8Z59pV6kBa7owdhNzb0G8tEpllL8sAYAk8ZlYp88P4XVtZcbfrCUVMuY
         NLjpHLKRpO3/HdyyHJZmvAgAdOuMwLiE/c0VLUhPxP0DglTpYtLOQ+xChg0N7pR+wruq
         lh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eQy6FsVhMeNMB9gB/UP0lH5OqQZ9aItb6uOTcxZNCvo=;
        b=NjAVaHVy+sixakjnnUY7T5/bGN3Ewz2vsxmCbJ5S2FPV0RnzuEjHFjZNO3Tnwl+6y9
         D4ZXXChig4ljSlbaxAp/CpAesa1f7J0V0gg9WBgHGAqmPRXWeKY8sMAfB/n+dlNjltC5
         9uJABB4YccIrTxl8yOvH/BFkKrgOQAA9TgwHgsbpA8Fg/q+fKbrlrHZj5FhY4iUErbxx
         gNBAAowhtJosSX94eKLJRfG3M3gIv6yVi8Fr/u+GXhcL6z22AUVVtc8+4JqYiTep8PXL
         8AvollzWatLCenkg5en22CJmfHG9WVG+cUEM18WGgP+OpfllqOfG4yK1R8CKAi5q/qwe
         BEbQ==
X-Gm-Message-State: APjAAAXA/EcqL0aeEhQZ6y9eLQCgmpsLXCshrtkxHNVuz+A3wJGsvMEN
        NBOCcygyGgYEmr+0Zrug7nR6drZsxpi3O/F6JFWm0A==
X-Google-Smtp-Source: APXvYqz6IpNWyqP9PCrataE61M1YRNjrPgv7UhVlzlr3bEcmtSL41Z/8cYgNGyeV6m8FUTVnjTOlsWw84SkhZ43WOmg=
X-Received: by 2002:aca:c40f:: with SMTP id u15mr14096581oif.67.1570821016911;
 Fri, 11 Oct 2019 12:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190919222421.27408-1-almasrymina@google.com> <3c73d2b7-f8d0-16bf-b0f0-86673c3e9ce3@oracle.com>
In-Reply-To: <3c73d2b7-f8d0-16bf-b0f0-86673c3e9ce3@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 11 Oct 2019 12:10:05 -0700
Message-ID: <CAHS8izN1Q7XH84Srem_McB+Jz67-fu6KPCMQjzbnPDTPzgwC2A@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] hugetlb_cgroup: Add hugetlb_cgroup reservation limits
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
        shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
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

On Mon, Sep 23, 2019 at 10:47 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 9/19/19 3:24 PM, Mina Almasry wrote:
> > Patch series implements hugetlb_cgroup reservation usage and limits, which
> > track hugetlb reservations rather than hugetlb memory faulted in. Details of
> > the approach is 1/7.
>
> Thanks for your continued efforts Mina.
>
> One thing that has bothered me with this approach from the beginning is that
> hugetlb reservations are related to, but somewhat distinct from hugetlb
> allocations.  The original (existing) huegtlb cgroup implementation does not
> take reservations into account.  This is an issue you are trying to address
> by adding a cgroup support for hugetlb reservations.  However, this new
> reservation cgroup ignores hugetlb allocations at fault time.
>
> I 'think' the whole purpose of any hugetlb cgroup is to manage the allocation
> of hugetlb pages.  Both the existing cgroup code and the reservation approach
> have what I think are some serious flaws.  Consider a system with 100 hugetlb
> pages available.  A sysadmin, has two groups A and B and wants to limit hugetlb
> usage to 50 pages each.
>
> With the existing implementation, a task in group A could create a mmap of
> 100 pages in size and reserve all 100 pages.  Since the pages are 'reserved',
> nobody in group B can allocate ANY huge pages.  This is true even though
> no pages have been allocated in A (or B).
>
> With the reservation implementation, a task in group A could use MAP_NORESERVE
> and allocate all 100 pages without taking any reservations.
>
> As mentioned in your documentation, it would be possible to use both the
> existing (allocation) and new reservation cgroups together.  Perhaps if both
> are setup for the 50/50 split things would work a little better.
>
> However, instead of creating a new reservation crgoup how about adding
> reservation support to the existing allocation cgroup support.  One could
> even argue that a reservation is an allocation as it sets aside huge pages
> that can only be used for a specific purpose.  Here is something that
> may work.
>
> Starting with the existing allocation cgroup.
> - When hugetlb pages are reserved, the cgroup of the task making the
>   reservations is charged.  Tracking for the charged cgroup is done in the
>   reservation map in the same way proposed by this patch set.
> - At page fault time,
>   - If a reservation already exists for that specific area do not charge the
>     faulting task.  No tracking in page, just the reservation map.
>   - If no reservation exists, charge the group of the faulting task.  Tracking
>     of this information is in the page itself as implemented today.
> - When the hugetlb object is removed, compare the reservation map with any
>   allocated pages.  If cgroup tracking information exists in page, uncharge
>   that group.  Otherwise, unharge the group (if any) in the reservation map.
>

Sorry for the late response here. I've been prototyping the
suggestions from this conversation:

1. Supporting cgroup-v2 on the current controller seems trivial.
Basically just specifying the dfl files seems to do it, and my tests
on top of cgroup-v2 don't see any problems so far at least. In light
of this I'm not sure it's best to create a new controller per say.
Seems like it would duplicate a lot of code with the current
controller, so I've tentatively just stuck to the plan in my current
patchset, a new counter on the existing controller.

2. I've been working on transitioning the new counter to the behavior
Mike specified in the email I'm responding to. So far I have a flow
that works for shared mappings but not private mappings:

- On reservation, charge the new counter and store the info in the
resv_map. The counter gets uncharged when the resv_map entry gets
removed (works fine).
- On alloc_huge_page(), check if there is a reservation for the page
being allocated. If not, charge the new counter and store the
information in resv_map. The counter still gets uncharged when the
resv_map entry gets removed.

The above works for all shared mappings and reserved private mappings,
but I' having trouble supporting private NORESERVE mappings. Charging
can work the same as for shared mappings: charge the new counter on
reservation and on allocations that do not have a reservation. But the
question still comes up: where to store the counter to uncharge this
page? I thought of a couple of things that don't seem to work:

1. I thought of putting the counter in resv_map->reservation_counter,
so that it gets uncharged on vm_op_close. But, private NORESERVE
mappings don't even have a resv_map allocated for them.

2. I thought of detecting on free_huge_page that the page being freed
belonged to a private NORESERVE mapping, and uncharging the
hugetlb_cgroup in the page itself, but free_huge_page only gets a
struct page* and I can't seem to find a way to detect that that the
page comes from a private NORESERVE mapping from only the struct
page*.

Mike, note your suggestion above to check if the page hugetlb_cgroup
is null doesn't work if we want to keep the current counter working
the same: the page will always have a hugetlb_cgroup that points that
contains the old counter. Any ideas how to apply this new counter
behavior to a private NORESERVE mappings? Is there maybe a flag I can
set on the pages at allocation time that I can read on free time to
know whether to uncharge the hugetlb_cgroup or not?
