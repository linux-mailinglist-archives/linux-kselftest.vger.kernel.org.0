Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C876139B0F
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2020 22:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgAMVEA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jan 2020 16:04:00 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33309 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728755AbgAMVEA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jan 2020 16:04:00 -0500
Received: by mail-ot1-f65.google.com with SMTP id b18so10395406otp.0
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2020 13:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a6fQoWKJePVhPWHTKpI3UfM75sgp66BpFErJzPrrlOw=;
        b=cs4vSMl8h6zduSExyq25DSHp/lH2D9ZZUB2ze/QkMCedj/FoGVuWSqKZL6UJ8UTe3x
         taygDD20N5lqR8w2jR83hzYodnsJEkg3c1Atvk/fLCDExtDwXFMXKWIzlRYeCwRrIu1A
         QKiMKkPj9JNOOvLJvuCQf2px2XyAK4NxLXTv642+m/nl4R5plSBMMCQzFnBPR2CywzdT
         oVB01h9esuzW+eabBVFNvIaVLzMWJx3EBtDGwzTVPHOTrFyxf2QXL3BOqhmh3E996IRd
         bGJ/LyGnfU2A1xuSz/EyJT6le9ylV4hOTDhEHaU8rjagJx6VxrP/bfzR9A3P9srdhxav
         HR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a6fQoWKJePVhPWHTKpI3UfM75sgp66BpFErJzPrrlOw=;
        b=RYOcIjjMBHG79k71Vb590+JWc2iK5Nb6bmKxSI2O1Bg2Yv9Wj9AMf614hxpsQq3ecj
         POlSlOwRt8jjQKSOve6pWD5WTj9Jt2MEO+kYUNUg9cuXUMrWkHfP/wt+j2Fi5SNi3qeg
         dWZ8fLbilVBIylcsmpEZvzqTgwDGcXsl0AUyfTKikfA5xHTjl5+q1ykNtzNabWsWd16O
         uV1OQxkESAfRHLclfPXOWnKVk8lYhcFn5rs0OcxDYiorNDMdumqwFT7SiPgEs1hB8tfI
         IQX+L1rGUfiRULPNyYrSv+4pZauDwGB+LNLb9+SEqY693nN/8JtF5Drf7LPWfplStyZM
         b1Aw==
X-Gm-Message-State: APjAAAVTXgb6MNf8idqhqcfCNkip/Mj903+r5ykI/DWmByOEHHg+akL+
        85klZUAv76aphHmhOzO/LMiMrsmXsCiFYXKZhbateQ==
X-Google-Smtp-Source: APXvYqzSJv0guVRdYaC4Mv//BEhlnnIgzybsKfPL1UpJTSHOQsnlrx7vu2g8YuBGQFU18WK2zQ1Cu/q9zAmUFfmNVZw=
X-Received: by 2002:a9d:2028:: with SMTP id n37mr15039312ota.127.1578949439221;
 Mon, 13 Jan 2020 13:03:59 -0800 (PST)
MIME-Version: 1.0
References: <20191217231615.164161-1-almasrymina@google.com> <817e2c4b-4c72-09f9-22ea-bbaf97584161@oracle.com>
In-Reply-To: <817e2c4b-4c72-09f9-22ea-bbaf97584161@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 13 Jan 2020 13:03:48 -0800
Message-ID: <CAHS8izNs24KOaRuQkVUuZZUh42rvkyBXJEJYrHNf9bLFnZEXCg@mail.gmail.com>
Subject: Re: [PATCH v9 1/8] hugetlb_cgroup: Add hugetlb_cgroup reservation counter
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 13, 2020 at 10:44 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 12/17/19 3:16 PM, Mina Almasry wrote:
> > These counters will track hugetlb reservations rather than hugetlb
> > memory faulted in. This patch only adds the counter, following patches
> > add the charging and uncharging of the counter.
> >
> > This is patch 1 of an 8 patch series.
> >
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
>
> To me, this implies that 'faults without reservations' could cause
> reservation usage to exceed reservation limit?  Or, does the faulting
> process get a SIGBUS because of the reservation limit even though it
> is not using reservations?
>
> We shall see in subsequent patches.
>

The design we went with based on previous discussions is as follows:
hugetlb pages faulted without a prior reservation get accounted at
fault time, rather than reservation time, and if the fault causes the
counter to cross the limit, the charge fails, hence the fault fails,
hence the process gets sigbus'd.

This means that one counter I'm adding here can cover both use cases:
if the userspace uses MAP_NORESERVE, then their memory is accounted at
fault time and they may get sigbus'd. If the userspace does *not* use
MAP_NORESERVE, then their memory is charged at reservation (mmap) time
and should be completely immune to runtime sigbus, unless they do
something really weird like reserve a bunch of memory, punch a hole in
the reserved memory, lower their limit, then fault in memory from the
hole.

> >
> > - If a task attempts to reserve more memory than limit_in_bytes allows,
> > the kernel will allow it to do so. But if a task attempts to reserve
> > more memory than reservation_limit_in_bytes, the kernel will fail this
> > reservation.
> >
> > This proposal is implemented in this patch series, with tests to verify
> > functionality and show the usage. We also added cgroup-v2 support to
> > hugetlb_cgroup so that the new use cases can be extended to v2.
>
> As previously discussed, cgroup-v2 support for hugetlb_cgroup will exist
> before this patch series.
>

Yes, this will be fixed in the next iteration.

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
> > - Added tests passing.
> > - Used libhugetlbfs for regression testing.
> >
> > [1]: https://www.kernel.org/doc/html/latest/vm/hugetlbfs_reserv.html
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > Acked-by: Hillf Danton <hdanton@sina.com>
>
> I think the ACK by Hillf happened some time back.  You may want to check
> to see if it still applies.
>

Yes, will remove the ack in the next iteration. I'll re-add it if Hilf
reviews again.

> >
> > ---
> >  include/linux/hugetlb.h |   4 +-
> >  mm/hugetlb_cgroup.c     | 116 +++++++++++++++++++++++++++++++++++-----
> >  2 files changed, 106 insertions(+), 14 deletions(-)
>
> Only one minor nit in the code.
>
> You made this cleanup,
> @@ -472,7 +519,7 @@ static void __init __hugetlb_cgroup_file_dfl_init(int idx)
>         struct hstate *h = &hstates[idx];
>
>         /* format the size */
> -       mem_fmt(buf, 32, huge_page_size(h));
> +       mem_fmt(buf, sizeof(buf), huge_page_size(h));
>
>         /* Add the limit file */
>         cft = &h->cgroup_files_dfl[0];
>
> But did not make the same cleanup in __hugetlb_cgroup_file_legacy_init()

Will be fixed in the next iteration.

> --
> Mike Kravetz
