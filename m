Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD03D4962
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2019 22:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbfJKUlv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Oct 2019 16:41:51 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44072 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbfJKUlt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Oct 2019 16:41:49 -0400
Received: by mail-ot1-f68.google.com with SMTP id 21so9071040otj.11
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2019 13:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QCcI0gZx24qP48bYZd6tERlQ1R1wkv8V/GwDJhxA6+4=;
        b=O+quGUL9GaTo+gzYgH53b4VZvt/bBFsOo+HoyW0Wa5cymiVBv3ZBICK2Ab1z8ywiOW
         6UVDcg8sc6Kd9egwHekRJrJLEVqHBAcElTS2vmtilW/W523Gbm1xXC2JdGqy3WcC42zV
         qewmH9LJH5ZfFOhFpCYjQElqSODyKlrLrWR8vZlyS+UHQmC3h1AdXsq/YCnEgPTAhJgV
         qRFKcH01zJTADmivj0w3XEJlAU+KrMMsmZlgI/NUpjIM453sU5iM50jTq8axNxiArMBO
         iErIVWcGoBL9clvTA9iUAnIkCIQjpUW6CTHdEr0lqSvqUBNMxsgd+1SIXCsPFz7cpG6L
         zLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QCcI0gZx24qP48bYZd6tERlQ1R1wkv8V/GwDJhxA6+4=;
        b=bGkAzpHJVy5/WoLi4QELMlraMZq73wVq4zJjPZJgE1BUNYrXAZb1YJag8AhOYfqaxG
         ogo2S+6Y78gAKeP8yngQmPPElMzDIoztnGG8iop71yObiYcjA4dt1l8glLlxbC173vRG
         9QeF5wtXyACDZX6Q52WUAF5Wz8YBzgqgBM3pQt/af5/rkhGFeMKpr+uAdVBh/qekhX5M
         25XRAy7448gLSMOdYAU+MlIfP+lBfepe+otU9SjfUBfcSRkF0VYj8BSTiQV3QIGx9MO3
         23WKyL2izQsfrSF7rFiL25QxwwI8hqk37a+7VydjTfzmK4qBMuh3CMOb2H7DpE59PRWb
         2bzA==
X-Gm-Message-State: APjAAAUegfuNl+qhrRrKAZXeHRfQ3EexRfmfnK5ox6Y2obv+LAXA/OJs
        EtrbuDvN6T5ZH0sCGsvGo9iBtjOFTuTHecoo4XxQMw==
X-Google-Smtp-Source: APXvYqzNjGsf2tP7ZzFAGiWPzmM+QG3u5csg/sFiRGr1eYLK5VU0i/5K52TZlUDNo2IZdUDXQG8XuW+YL+3Hn6n6F34=
X-Received: by 2002:a9d:5c07:: with SMTP id o7mr14443071otk.33.1570826507552;
 Fri, 11 Oct 2019 13:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190919222421.27408-1-almasrymina@google.com>
 <3c73d2b7-f8d0-16bf-b0f0-86673c3e9ce3@oracle.com> <CAHS8izN1Q7XH84Srem_McB+Jz67-fu6KPCMQjzbnPDTPzgwC2A@mail.gmail.com>
In-Reply-To: <CAHS8izN1Q7XH84Srem_McB+Jz67-fu6KPCMQjzbnPDTPzgwC2A@mail.gmail.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 11 Oct 2019 13:41:36 -0700
Message-ID: <CAHS8izNhZc8zsdf=eXU5L_ouKwk9s00S-Q21P=QA+vAF3BsXcg@mail.gmail.com>
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

On Fri, Oct 11, 2019 at 12:10 PM Mina Almasry <almasrymina@google.com> wrote:
>
> On Mon, Sep 23, 2019 at 10:47 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >
> > On 9/19/19 3:24 PM, Mina Almasry wrote:
> > > Patch series implements hugetlb_cgroup reservation usage and limits, which
> > > track hugetlb reservations rather than hugetlb memory faulted in. Details of
> > > the approach is 1/7.
> >
> > Thanks for your continued efforts Mina.
> >
> > One thing that has bothered me with this approach from the beginning is that
> > hugetlb reservations are related to, but somewhat distinct from hugetlb
> > allocations.  The original (existing) huegtlb cgroup implementation does not
> > take reservations into account.  This is an issue you are trying to address
> > by adding a cgroup support for hugetlb reservations.  However, this new
> > reservation cgroup ignores hugetlb allocations at fault time.
> >
> > I 'think' the whole purpose of any hugetlb cgroup is to manage the allocation
> > of hugetlb pages.  Both the existing cgroup code and the reservation approach
> > have what I think are some serious flaws.  Consider a system with 100 hugetlb
> > pages available.  A sysadmin, has two groups A and B and wants to limit hugetlb
> > usage to 50 pages each.
> >
> > With the existing implementation, a task in group A could create a mmap of
> > 100 pages in size and reserve all 100 pages.  Since the pages are 'reserved',
> > nobody in group B can allocate ANY huge pages.  This is true even though
> > no pages have been allocated in A (or B).
> >
> > With the reservation implementation, a task in group A could use MAP_NORESERVE
> > and allocate all 100 pages without taking any reservations.
> >
> > As mentioned in your documentation, it would be possible to use both the
> > existing (allocation) and new reservation cgroups together.  Perhaps if both
> > are setup for the 50/50 split things would work a little better.
> >
> > However, instead of creating a new reservation crgoup how about adding
> > reservation support to the existing allocation cgroup support.  One could
> > even argue that a reservation is an allocation as it sets aside huge pages
> > that can only be used for a specific purpose.  Here is something that
> > may work.
> >
> > Starting with the existing allocation cgroup.
> > - When hugetlb pages are reserved, the cgroup of the task making the
> >   reservations is charged.  Tracking for the charged cgroup is done in the
> >   reservation map in the same way proposed by this patch set.
> > - At page fault time,
> >   - If a reservation already exists for that specific area do not charge the
> >     faulting task.  No tracking in page, just the reservation map.
> >   - If no reservation exists, charge the group of the faulting task.  Tracking
> >     of this information is in the page itself as implemented today.
> > - When the hugetlb object is removed, compare the reservation map with any
> >   allocated pages.  If cgroup tracking information exists in page, uncharge
> >   that group.  Otherwise, unharge the group (if any) in the reservation map.
> >
>
> Sorry for the late response here. I've been prototyping the
> suggestions from this conversation:
>
> 1. Supporting cgroup-v2 on the current controller seems trivial.
> Basically just specifying the dfl files seems to do it, and my tests
> on top of cgroup-v2 don't see any problems so far at least. In light
> of this I'm not sure it's best to create a new controller per say.
> Seems like it would duplicate a lot of code with the current
> controller, so I've tentatively just stuck to the plan in my current
> patchset, a new counter on the existing controller.
>
> 2. I've been working on transitioning the new counter to the behavior
> Mike specified in the email I'm responding to. So far I have a flow
> that works for shared mappings but not private mappings:
>
> - On reservation, charge the new counter and store the info in the
> resv_map. The counter gets uncharged when the resv_map entry gets
> removed (works fine).
> - On alloc_huge_page(), check if there is a reservation for the page
> being allocated. If not, charge the new counter and store the
> information in resv_map. The counter still gets uncharged when the
> resv_map entry gets removed.
>
> The above works for all shared mappings and reserved private mappings,
> but I' having trouble supporting private NORESERVE mappings. Charging
> can work the same as for shared mappings: charge the new counter on
> reservation and on allocations that do not have a reservation. But the
> question still comes up: where to store the counter to uncharge this
> page? I thought of a couple of things that don't seem to work:
>
> 1. I thought of putting the counter in resv_map->reservation_counter,
> so that it gets uncharged on vm_op_close. But, private NORESERVE
> mappings don't even have a resv_map allocated for them.
>
> 2. I thought of detecting on free_huge_page that the page being freed
> belonged to a private NORESERVE mapping, and uncharging the
> hugetlb_cgroup in the page itself, but free_huge_page only gets a
> struct page* and I can't seem to find a way to detect that that the
> page comes from a private NORESERVE mapping from only the struct
> page*.
>
> Mike, note your suggestion above to check if the page hugetlb_cgroup
> is null doesn't work if we want to keep the current counter working
> the same: the page will always have a hugetlb_cgroup that points that
> contains the old counter. Any ideas how to apply this new counter
> behavior to a private NORESERVE mappings? Is there maybe a flag I can
> set on the pages at allocation time that I can read on free time to
> know whether to uncharge the hugetlb_cgroup or not?

Reading the code and asking around a bit, it seems the pointer to the
hugetlb_cgroup is in page[2].private. Is it reasonable to use
page[3].private to store the hugetlb_cgroup to uncharge for the new
counter and increment HUGETLB_CGROUP_MIN_ORDER to 3? I think that
would solve my problem. When allocating a private NORESERVE page, set
page[3].private to the hugetlb_cgroup to uncharge, then on
free_huge_page, check page[3].private, if it is non-NULL, uncharge the
new counter on it.
