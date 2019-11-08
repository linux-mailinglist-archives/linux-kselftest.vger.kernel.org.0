Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 090F2F5BD7
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2019 00:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfKHXgI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Nov 2019 18:36:08 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34673 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfKHXgI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Nov 2019 18:36:08 -0500
Received: by mail-oi1-f195.google.com with SMTP id l202so6804704oig.1
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Nov 2019 15:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iDoGjHfNdP7CEHEDPPCtVFhc3W4zkYgSKdJEK3JXJd0=;
        b=qRfysVkEgETlDzoUQQSvtUASI7EhYk4fThC5U9CCPg2HA60AvRpiM+eIJuvxwJatts
         Tt29h6e4CWwvEhnG0fQZe40G9jvAXzWnDzTDI64eIgPGJvok2bmvbQfVR9/3sVp9QX9p
         FfCY41q4VHptJUL4iGEQz51Ho4eDYl8fICsTixxXqRpFm8sSEwIGBYgdkaefai/km3QD
         HcYJD51fKf/gyEDlKrnkkWmeUA0hDDJhvA5HE9PoEVdK/raVrX9QAb9kuOIErEQe+T21
         dHIPeBGlWj5RDGkH5INfq9PqIyUVyi/GfcpijHghJlEa2m5M7u0ogxH17Hk9vGJmaSLn
         VgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iDoGjHfNdP7CEHEDPPCtVFhc3W4zkYgSKdJEK3JXJd0=;
        b=FfikWO769pxlF85Ib2Jp+Kqi3/w4ixXfnuErRM78m6nN6SLpsf3oO8emfRzDAimSAP
         AUqUr/IbuVZi1696T2ReGGglgO35gNodCp12zoDZTqojc/VPmyaRMOaiki7xdhpNpH4B
         ykbIDGAOFgArjmrLgbq9WmyZJDjFm2bByddzaRxyKRqQdai5tCVAQQjvPAt+l8YKeVnM
         WXsbAPLFmQ9uOr0gRFBA4LjvGLeAMo+hEA6FUSx8ooRmdLCLZx0gZ76FEqA7LW/VKwyU
         W5nwkxA3CAeyVzu27BAXW6j0e0izvzdmthRslgTvjbby0T1wEKm6W44i/wnyLEwPnca9
         gBaw==
X-Gm-Message-State: APjAAAWBgaeSXLbdzEDwkoHU25HlwNOP6kLpRt2NSzXAOiEpQm57XPu7
        WOGAVIzCaep9JUDWC9sEqS90lnWZsQtb+3TQAxi9Uw==
X-Google-Smtp-Source: APXvYqx5lVByzI30bfOZKF+9P00wWxnRqtrwswlwA7cd4uf7yQSeCTKB5Ykql4XWeoS0urkg89cB/9USVEYDE4mteLw=
X-Received: by 2002:aca:1101:: with SMTP id 1mr12627382oir.103.1573256166162;
 Fri, 08 Nov 2019 15:36:06 -0800 (PST)
MIME-Version: 1.0
References: <20191030013701.39647-1-almasrymina@google.com> <78f07acf-47ba-4fa5-34c2-78a17eb7c16f@oracle.com>
In-Reply-To: <78f07acf-47ba-4fa5-34c2-78a17eb7c16f@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 8 Nov 2019 15:35:55 -0800
Message-ID: <CAHS8izPp9aW=uxA2z6BLmRXgaiDVyKYvAbnrH0rcirN4wTD55g@mail.gmail.com>
Subject: Re: [PATCH v8 1/9] hugetlb_cgroup: Add hugetlb_cgroup reservation counter
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     shuah <shuah@kernel.org>, open list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
        Hillf Danton <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 7, 2019 at 3:42 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> Cc: Andrew
> This series is getting closer to consideration for the mm tree.
> Mina,
> Be sure to cc Andrew with next version of series.
>

Absolutely!

> On 10/29/19 6:36 PM, Mina Almasry wrote:
> > These counters will track hugetlb reservations rather than hugetlb
> > memory faulted in. This patch only adds the counter, following patches
> > add the charging and uncharging of the counter.
>
> I honestly am not sure the preferred method for including the overall
> design in a commit message.  Certainly it should be in the first patch.
> Perhaps, say this is patch 1 of a 9 patch series here.
>

Will do. I read somewhere I can't find right now it's better this way
so that the useful information becomes part of the git log. If anyone
has strong opinions on this I'll just go back to putting it into a
cover letter.

> > Problem:
> > Currently tasks attempting to allocate more hugetlb memory than is available get
> > a failure at mmap/shmget time. This is thanks to Hugetlbfs Reservations [1].
> > However, if a task attempts to allocate hugetlb memory only more than its
> > hugetlb_cgroup limit allows, the kernel will allow the mmap/shmget call,
> > but will SIGBUS the task when it attempts to fault the memory in.
> >
> > We have developers interested in using hugetlb_cgroups, and they have expressed
> > dissatisfaction regarding this behavior. We'd like to improve this
> > behavior such that tasks violating the hugetlb_cgroup limits get an error on
> > mmap/shmget time, rather than getting SIGBUS'd when they try to fault
> > the excess memory in.
> >
> > The underlying problem is that today's hugetlb_cgroup accounting happens
> > at hugetlb memory *fault* time, rather than at *reservation* time.
> > Thus, enforcing the hugetlb_cgroup limit only happens at fault time, and
> > the offending task gets SIGBUS'd.
> >
> > Proposed Solution:
> > A new page counter named hugetlb.xMB.reservation_[limit|usage]_in_bytes. This
> > counter has slightly different semantics than
> > hugetlb.xMB.[limit|usage]_in_bytes:
> >
> > - While usage_in_bytes tracks all *faulted* hugetlb memory,
> > reservation_usage_in_bytes tracks all *reserved* hugetlb memory and
> > hugetlb memory faulted in without a prior reservation.
> >
> > - If a task attempts to reserve more memory than limit_in_bytes allows,
> > the kernel will allow it to do so. But if a task attempts to reserve
> > more memory than reservation_limit_in_bytes, the kernel will fail this
> > reservation.
> >
> > This proposal is implemented in this patch series, with tests to verify
> > functionality and show the usage. We also added cgroup-v2 support to
> > hugetlb_cgroup so that the new use cases can be extended to v2.
> >
> > Alternatives considered:
> > 1. A new cgroup, instead of only a new page_counter attached to
> >    the existing hugetlb_cgroup. Adding a new cgroup seemed like a lot of code
> >    duplication with hugetlb_cgroup. Keeping hugetlb related page counters under
> >    hugetlb_cgroup seemed cleaner as well.
> >
> > 2. Instead of adding a new counter, we considered adding a sysctl that modifies
> >    the behavior of hugetlb.xMB.[limit|usage]_in_bytes, to do accounting at
> >    reservation time rather than fault time. Adding a new page_counter seems
> >    better as userspace could, if it wants, choose to enforce different cgroups
> >    differently: one via limit_in_bytes, and another via
> >    reservation_limit_in_bytes. This could be very useful if you're
> >    transitioning how hugetlb memory is partitioned on your system one
> >    cgroup at a time, for example. Also, someone may find usage for both
> >    limit_in_bytes and reservation_limit_in_bytes concurrently, and this
> >    approach gives them the option to do so.
> >
> > Testing:
>
> I think that simply mentioning the use of hugetlbfs for regression testing
> would be sufficient here.
>

Will do.

> > - Added tests passing.
> > - libhugetlbfs tests mostly passing, but some tests have trouble with and
> >   without this patch series. Seems environment issue rather than code:
> >   - Overall results:
> >     ********** TEST SUMMARY
> >     *                      2M
> >     *                      32-bit 64-bit
> >     *     Total testcases:    84      0
> >     *             Skipped:     0      0
> >     *                PASS:    66      0
> >     *                FAIL:    14      0
> >     *    Killed by signal:     0      0
> >     *   Bad configuration:     4      0
> >     *       Expected FAIL:     0      0
> >     *     Unexpected PASS:     0      0
> >     *    Test not present:     0      0
> >     * Strange test result:     0      0
> >     **********
>
> It is curious that you only ran the tests for 32 bit applications.  Certainly
> the more common case today is 64 bit.  I don't think there are any surprises
> for you as I also have been running hugetlbfs on this series.

I did run them, with similar results. I'll add them.

> --
> Mike Kravetz
>
> >   - Failing tests:
> >     - elflink_rw_and_share_test("linkhuge_rw") segfaults with and without this
> >       patch series.
> >     - LD_PRELOAD=libhugetlbfs.so HUGETLB_MORECORE=yes malloc (2M: 32):
> >       FAIL    Address is not hugepage
> >     - LD_PRELOAD=libhugetlbfs.so HUGETLB_RESTRICT_EXE=unknown:malloc
> >       HUGETLB_MORECORE=yes malloc (2M: 32):
> >       FAIL    Address is not hugepage
> >     - LD_PRELOAD=libhugetlbfs.so HUGETLB_MORECORE=yes malloc_manysmall (2M: 32):
> >       FAIL    Address is not hugepage
> >     - GLIBC_TUNABLES=glibc.malloc.tcache_count=0 LD_PRELOAD=libhugetlbfs.so
> >       HUGETLB_MORECORE=yes heapshrink (2M: 32):
> >       FAIL    Heap not on hugepages
> >     - GLIBC_TUNABLES=glibc.malloc.tcache_count=0 LD_PRELOAD=libhugetlbfs.so
> >       libheapshrink.so HUGETLB_MORECORE=yes heapshrink (2M: 32):
> >       FAIL    Heap not on hugepages
> >     - HUGETLB_ELFMAP=RW linkhuge_rw (2M: 32): FAIL    small_data is not hugepage
> >     - HUGETLB_ELFMAP=RW HUGETLB_MINIMAL_COPY=no linkhuge_rw (2M: 32):
> >       FAIL    small_data is not hugepage
> >     - alloc-instantiate-race shared (2M: 32):
> >       Bad configuration: sched_setaffinity(cpu1): Invalid argument -
> >       FAIL    Child 1 killed by signal Killed
> >     - shmoverride_linked (2M: 32):
> >       FAIL    shmget failed size 2097152 from line 176: Invalid argument
> >     - HUGETLB_SHM=yes shmoverride_linked (2M: 32):
> >       FAIL    shmget failed size 2097152 from line 176: Invalid argument
> >     - shmoverride_linked_static (2M: 32):
> >       FAIL shmget failed size 2097152 from line 176: Invalid argument
> >     - HUGETLB_SHM=yes shmoverride_linked_static (2M: 32):
> >       FAIL shmget failed size 2097152 from line 176: Invalid argument
> >     - LD_PRELOAD=libhugetlbfs.so shmoverride_unlinked (2M: 32):
> >       FAIL shmget failed size 2097152 from line 176: Invalid argument
> >     - LD_PRELOAD=libhugetlbfs.so HUGETLB_SHM=yes shmoverride_unlinked (2M: 32):
> >       FAIL    shmget failed size 2097152 from line 176: Invalid argument
> >
> > [1]: https://www.kernel.org/doc/html/latest/vm/hugetlbfs_reserv.html
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > Acked-by: Hillf Danton <hdanton@sina.com>
