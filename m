Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16A6088EA3
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Aug 2019 00:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfHJWBO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 10 Aug 2019 18:01:14 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:32991 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfHJWBO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 10 Aug 2019 18:01:14 -0400
Received: by mail-ot1-f66.google.com with SMTP id q20so145999866otl.0
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Aug 2019 15:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CKSBDb3n2Zw/j8kWgy95XapjnDr9kx+5JJx/IJIa8C8=;
        b=NUcrHdVOutsZBY/9WFTG0qmyK4Pv+ynw61exCRXGPu4QidGG4QRnMuzfvhUu4CTm5+
         LBz0d2+yyKpuXU/u8m58dPJXV2KpiikkKgNrk8yy5Kmgq+wXhz9UU7aU3uPtKXzrFPl4
         Uu49ni8D5+tQwgLiVAZ7tIN2GsoxkxtYVSDWeGaim9N80nxj3cpnVNFWTUINaec9HC2w
         sZIG+ZnSKDOwLQ44s4Fx7hqoFAOqHPCHKUSGuypcc88/J9Cuh0bOK5RjjClR4OYtXXX1
         XNTB//O3ZxXOb8ugK43J+tV03Ay3CYIoqDeLg2wTgRn14F/4Mrz1bSvxeIKsvExmUbXQ
         rvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CKSBDb3n2Zw/j8kWgy95XapjnDr9kx+5JJx/IJIa8C8=;
        b=KJXxnzXKDofdnI8figSpv3anyDHC6ppn9naNnDT8JFmUrS6HKtCflgxK6LrZBZVavm
         531hZUNE78vkZCbaO25Th2y12BmmIeCn4UnDWol6TFYA0FBtgt4YHDfR+y7tQO5E9kV9
         GXeq0yHPReKYe1klyL55mMrt/WFHGS6k54M0wD9OsGXoCNV9gLe3AeLqyDxXGXJpUusE
         kUgbskQ1LYZUWqxyr8XFDe69uTHvPkJYRf4liwILbDlzJlpz93VUgPua00oZybxYwvnI
         kJBv7Yl8o7SO2w383EPr6D4aCHkCn07s2p/ab06I94g+XYU7C/KtBeLwQTZRtI2NXZvN
         xH6Q==
X-Gm-Message-State: APjAAAUVDKAHCK5HonBgtqP8TwPhhv3Z106IbwDPzM2+epTHeXMO8cj7
        9gspXWyqKNxfH6IHw7AQuj6RFVYqJ7Eua5PfnNVyFg==
X-Google-Smtp-Source: APXvYqz0uGRd+OhDQQzhvps5/ie3QYUxGJ4pkAuGl0z6CDhEr4NK2GSI4SjZWju6OEg2EGL2jIXdS1whMQ9aB6RYVjA=
X-Received: by 2002:aca:190b:: with SMTP id l11mr11116656oii.67.1565474472697;
 Sat, 10 Aug 2019 15:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190808231340.53601-1-almasrymina@google.com>
 <f0a5afe9-2586-38c9-9a6d-8a2b7b288b50@oracle.com> <CAHS8izOKmaOETBd_545Zex=KFNjYOvf3dCzcMRUEXnnhYCK5bw@mail.gmail.com>
 <71a29844-7367-44c4-23be-eff26ac80467@oracle.com>
In-Reply-To: <71a29844-7367-44c4-23be-eff26ac80467@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Sat, 10 Aug 2019 15:01:01 -0700
Message-ID: <CAHS8izPGhHS+=qnf7Vy=C8kXQ=7v7XH3uEVitrW6ARRYU6iDdg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] hugetlb_cgroup: Add hugetlb_cgroup reservation limits
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, open list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Aug 10, 2019 at 11:58 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 8/9/19 12:42 PM, Mina Almasry wrote:
> > On Fri, Aug 9, 2019 at 10:54 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >> On 8/8/19 4:13 PM, Mina Almasry wrote:
> >>> Problem:
> >>> Currently tasks attempting to allocate more hugetlb memory than is available get
> >>> a failure at mmap/shmget time. This is thanks to Hugetlbfs Reservations [1].
> >>> However, if a task attempts to allocate hugetlb memory only more than its
> >>> hugetlb_cgroup limit allows, the kernel will allow the mmap/shmget call,
> >>> but will SIGBUS the task when it attempts to fault the memory in.
> <snip>
> >> I believe tracking reservations for shared mappings can get quite complicated.
> >> The hugetlbfs reservation code around shared mappings 'works' on the basis
> >> that shared mapping reservations are global.  As a result, reservations are
> >> more associated with the inode than with the task making the reservation.
> >
> > FWIW, I found it not too bad. And my tests at least don't detect an
> > anomaly around shared mappings. The key I think is that I'm tracking
> > cgroup to uncharge on the file_region entry inside the resv_map, so we
> > know who allocated each file_region entry exactly and we can uncharge
> > them when the entry is region_del'd.
> >
> >> For example, consider a file of size 4 hugetlb pages.
> >> Task A maps the first 2 pages, and 2 reservations are taken.  Task B maps
> >> all 4 pages, and 2 additional reservations are taken.  I am not really sure
> >> of the desired semantics here for reservation limits if A and B are in separate
> >> cgroups.  Should B be charged for 4 or 2 reservations?
> >
> > Task A's cgroup is charged 2 pages to its reservation usage.
> > Task B's cgroup is charged 2 pages to its reservation usage.
>
> OK,
> Suppose Task B's cgroup allowed 2 huge pages reservation and 2 huge pages
> allocation.  The mmap would succeed, but Task B could potentially need to
> allocate more than 2 huge pages.  So, when faulting in more than 2 huge
> pages B would get a SIGBUS.  Correct?  Or, am I missing something?
>
> Perhaps reservation charge should always be the same as map size/maximum
> allocation size?

I'm thinking this would work similar to how other shared memory like
tmpfs is accounted for right now. I.e. if a task conducts an operation
that causes memory to be allocated then that task is charged for that
memory, and if another task uses memory that has already been
allocated and charged by another task, then it can use the memory
without being charged.

So in case of hugetlb memory, if a task is mmaping memory that causes
a new reservation to be made, and new entries to be created in the
resv_map for the shared mapping, then that task gets charged. If the
task is mmaping memory that is already reserved or faulted, then it
reserves or faults it without getting charged.

In the example above, in chronological order:
- Task A mmaps 2 hugetlb pages, gets charged 2 hugetlb reservations.
- Task B mmaps 4 hugetlb pages, gets charged only 2 hugetlb
reservations because the first 2 are charged already and can be used
without incurring a charge.
- Task B accesses 4 hugetlb pages, gets charged *4* hugetlb faults,
since none of the 4 pages are faulted in yet. If the task is only
allowed 2 hugetlb page faults then it will actually get a SIGBUS.
- Task A accesses 4 hugetlb pages, gets charged no faults, since all
the hugetlb faults is charged to Task B.

So, yes, I can see a scenario where userspace still gets SIGBUS'd, but
I think that's fine because:
1. Notice that the SIGBUS is due to the faulting limit, and not the
reservation limit, so we're not regressing the status quo per say.
Folks using the fault limit today understand the SIGBUS risk.
2. the way I expect folks to use this is to use 'reservation limits'
to partition the available hugetlb memory on the machine using it and
forgo using the existing fault limits. Using both at the same time I
think would be a superuser feature for folks that really know what
they are doing, and understand the risk of SIGBUS that comes with
using the existing fault limits.
3. I expect userspace to in general handle this correctly because
there are similar challenges with all shared memory and accounting of
it, even in tmpfs, I think.

I would not like to charge the full reservation to every process that
does the mmap. Think of this, much more common scenario: Task A and B
are supposed to collaborate on a 10 hugetlb pages of data. Task B
should not access any hugetlb memory other than the memory it is
working on with Task A, so:

1. Task A is put in a cgroup with 10 hugetlb pages reservation limit.
2. Task B is put in a cgroup with 0 hugetlb pages of reservation limit.
3. Task A mmaps 10 hugetlb pages of hugetlb memory, and notifies Task
B that it is done.
4. Task B, due to programmer error, tries to mmap hugetlb memory
beyond what Task A set up for it, it gets denied at mmap time by the
cgroup reservation limit.
5. Task B mmaps the same 10 hugetlb pages of memory and starts working
on them. The mmap succeeds because Task B is not charged anything.

If we were charging the full reservation to both Tasks A and B, then
both A and B would have be in cgroups that allow 10 pages of hugetlb
reservations, and the mmap in step 4 would succeed, and we
accidentally overcommitted the amount of hugetlb memory available.

> --
> Mike Kravetz
