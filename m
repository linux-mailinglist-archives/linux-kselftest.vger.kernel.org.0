Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D627E88366
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2019 21:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfHITmp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Aug 2019 15:42:45 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46382 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfHITmp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Aug 2019 15:42:45 -0400
Received: by mail-ot1-f67.google.com with SMTP id z17so18513028otk.13
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Aug 2019 12:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qcpdYAxgZIBIFmbMMN32rTklid76j4wSMwVthTygoNA=;
        b=RJyoyNUYqKorBafNZSFufOucWTqHlYU6ePm8PWFu+GIE13hP9XfnH6A+kAksmwCdbe
         vzGT4xozV8azvINAKFqxf4rjaADZ8DZM/wWdLxQvPQeBvwWfz7ggehshQVNaej9Zot+i
         Rt0XvJeFEd3rLDrvyYNVd8sa6JGkDdb53e2aNIO3MksGaCcSm1dpCyXndElMclNsoii6
         hNMrsvjpSCG55N6y4J1ijNIfWOSKA/7ZDT3SG5aHVisGHMqTVkQvdSRaScM1mw2AdFU/
         DcgWng57kp6L4Z0ypwuM4wWXGABlTGCB4fbDdeYhyGdkbTRzY6NrRHleQxDUMXSjH7iy
         FqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qcpdYAxgZIBIFmbMMN32rTklid76j4wSMwVthTygoNA=;
        b=Gj2wxS3usX42QToJSsNDMlqagDn8Bha3tT5SqWgkC1TSJBF6B+Cfvja8Tma13MAgK3
         92UIYmxQRpRhmheVnbPZDdwHqS3RPRPlK3VsZQiM8Y9i15CfUOaDpT03hMnX7hHXq6xl
         RzwkAGOcxCJqAYJTE+PHnDrZIF77Alww3LM/aS8K5BDPQhSTJAtd3ro9+MN15jygsKSr
         jXjiU1Cr7z1DSRIZIuITawnITo7lseVUJXwpLoug0lB77Ouuf7f5USXezQelZisqTp89
         LNslE6U+aDRyI78aR0h/TXhHdIclf/NI3W0meCvThRd47Nlyt6xak+V7lx8oetsEK9HE
         gZYQ==
X-Gm-Message-State: APjAAAXL/ug2pOtf4fYzv+Vyhvg2QfULvq8o5tTN7VWEh+G6Jl0CKKjR
        pCRseIfVn+v7TUovLY81T6JyvhzomcBES/2FLfLwAA==
X-Google-Smtp-Source: APXvYqzeWQV1n/GSsdfXYaqb9RFi8FCT4BwFakpht1LHgGOeLAHZsXnj3/yOPVvlKxSnNUiKVpK80tad3rbeLviNEyw=
X-Received: by 2002:a05:6830:1249:: with SMTP id s9mr20222798otp.33.1565379763678;
 Fri, 09 Aug 2019 12:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190808231340.53601-1-almasrymina@google.com> <f0a5afe9-2586-38c9-9a6d-8a2b7b288b50@oracle.com>
In-Reply-To: <f0a5afe9-2586-38c9-9a6d-8a2b7b288b50@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 9 Aug 2019 12:42:32 -0700
Message-ID: <CAHS8izOKmaOETBd_545Zex=KFNjYOvf3dCzcMRUEXnnhYCK5bw@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 9, 2019 at 10:54 AM Mike Kravetz <mike.kravetz@oracle.com> wrot=
e:
>
> (+CC  Michal Koutn=C3=BD, cgroups@vger.kernel.org, Aneesh Kumar)
>
> On 8/8/19 4:13 PM, Mina Almasry wrote:
> > Problem:
> > Currently tasks attempting to allocate more hugetlb memory than is avai=
lable get
> > a failure at mmap/shmget time. This is thanks to Hugetlbfs Reservations=
 [1].
> > However, if a task attempts to allocate hugetlb memory only more than i=
ts
> > hugetlb_cgroup limit allows, the kernel will allow the mmap/shmget call=
,
> > but will SIGBUS the task when it attempts to fault the memory in.
> >
> > We have developers interested in using hugetlb_cgroups, and they have e=
xpressed
> > dissatisfaction regarding this behavior. We'd like to improve this
> > behavior such that tasks violating the hugetlb_cgroup limits get an err=
or on
> > mmap/shmget time, rather than getting SIGBUS'd when they try to fault
> > the excess memory in.
> >
> > The underlying problem is that today's hugetlb_cgroup accounting happen=
s
> > at hugetlb memory *fault* time, rather than at *reservation* time.
> > Thus, enforcing the hugetlb_cgroup limit only happens at fault time, an=
d
> > the offending task gets SIGBUS'd.
> >
> > Proposed Solution:
> > A new page counter named hugetlb.xMB.reservation_[limit|usage]_in_bytes=
. This
> > counter has slightly different semantics than
> > hugetlb.xMB.[limit|usage]_in_bytes:
> >
> > - While usage_in_bytes tracks all *faulted* hugetlb memory,
> > reservation_usage_in_bytes tracks all *reserved* hugetlb memory.
> >
> > - If a task attempts to reserve more memory than limit_in_bytes allows,
> > the kernel will allow it to do so. But if a task attempts to reserve
> > more memory than reservation_limit_in_bytes, the kernel will fail this
> > reservation.
> >
> > This proposal is implemented in this patch, with tests to verify
> > functionality and show the usage.
>
> Thanks for taking on this effort Mina.
>
No problem! Thanks for reviewing!

> Before looking at the details of the code, it might be helpful to discuss
> the expected semantics of the proposed reservation limits.
>
> I see you took into account the differences between private and shared
> mappings.  This is good, as the reservation behavior is different for eac=
h
> of these cases.  First let's look at private mappings.
>
> For private mappings, the reservation usage will be the size of the mappi=
ng.
> This should be fairly simple.  As reservations are consumed in the hugetl=
bfs
> code, reservations in the resv_map are removed.  I see you have a hook in=
to
> region_del.  So, the expectation is that as reservations are consumed the
> reservation usage will drop for the cgroup.  Correct?

I assume by 'reservations are consumed' you mean when a reservation
goes from just 'reserved' to actually in use (as in the task is
writing to the hugetlb page or something). If so, then the answer is
no, that is not correct. When reservations are consumed, the
reservation usage stays the same. I.e. the reservation usage tracks
hugetlb memory (reserved + used) you could say. This is 100% the
intention, as we want to know on mmap time if there is enough 'free'
(that is unreserved and unused) memory left over in the cgroup to
satisfy the mmap call.

The hooks in region_add and region_del are to account shared mappings
only. There is a check in those code blocks that makes sure the code
is only engaged in shared mappings. The commit messages of patches 3/5
and 4/5 go into more details regarding this.

> The only tricky thing about private mappings is COW because of fork.  Cur=
rent
> reservation semantics specify that all reservations stay with the parent.
> If child faults and can not get page, SIGBUS.  I assume the new reservati=
on
> limits will work the same.
>

Although I did not explicitly try it, yes. It should work the same.
The additional reservation due to the COW will get charged to whatever
cgroup the fork is in. If the task can't get a page it gets SIGBUS'd.
If there is not enough room to charge the cgroup it's in, then the
charge will fail, which I assume will trigger error path that also
leads to SIGBUS.

> I believe tracking reservations for shared mappings can get quite complic=
ated.
> The hugetlbfs reservation code around shared mappings 'works' on the basi=
s
> that shared mapping reservations are global.  As a result, reservations a=
re
> more associated with the inode than with the task making the reservation.

FWIW, I found it not too bad. And my tests at least don't detect an
anomaly around shared mappings. The key I think is that I'm tracking
cgroup to uncharge on the file_region entry inside the resv_map, so we
know who allocated each file_region entry exactly and we can uncharge
them when the entry is region_del'd.

> For example, consider a file of size 4 hugetlb pages.
> Task A maps the first 2 pages, and 2 reservations are taken.  Task B maps
> all 4 pages, and 2 additional reservations are taken.  I am not really su=
re
> of the desired semantics here for reservation limits if A and B are in se=
parate
> cgroups.  Should B be charged for 4 or 2 reservations?

Task A's cgroup is charged 2 pages to its reservation usage.
Task B's cgroup is charged 2 pages to its reservation usage.

This is analogous to how shared memory accounting is done for things
like tmpfs, and I see no strong reason right now to deviate. I.e. the
task that made the reservation is charged with it, and others use it
without getting charged.

> Also in the example above, after both tasks create their mappings suppose
> Task B faults in the first page.  Does the reservation usage of Task A go
> down as it originally had the reservation?
>

Reservation usage never goes down when pages are consumed. Yes, I
would have this problem if I was planning to decrement reservation
usage when pages are put into use, but, the goal is to find out if
there is 'free' memory (unreserved + unused) in the cgroup at mmap
time, so we want a counter that tracks (reserved + used).

> It should also be noted that when hugetlbfs reservations are 'consumed' f=
or
> shared mappings there are no changes to the resv_map.  Rather the unmap c=
ode
> compares the contents of the page cache to the resv_map to determine how
> many reservations were actually consumed.  I did not look close enough to
> determine the code drops reservation usage counts as pages are added to s=
hared
> mappings.

I think this concern also goes away if reservation usage doesn't go
down when pages are consumed, but let me know if you still have
doubts.

Thanks for taking a look so far!
>
> --
> Mike Kravetz
