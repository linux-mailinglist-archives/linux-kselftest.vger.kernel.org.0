Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05A8412591B
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2019 02:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfLSBM4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Dec 2019 20:12:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:39382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbfLSBM4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Dec 2019 20:12:56 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E2C52176D;
        Thu, 19 Dec 2019 01:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576717975;
        bh=EnDbUNs/vALEvcA8Z9IMx3LTjG39IibUT3Ww5yvhwFY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Vt7ZmhZL4/z+GEPYZsGwvLn9s0Enyv8//u9UmcZY0C7jMBx40N5FHa7TnUecE/lUS
         3CkvMLNFZ7D13BfI9AeDbJK8xptCUiHyeApiQsLcjvk2ZKhKTmC6HdRP1msxv00ol5
         /W+nVAbaoumyeUvxDFGy4GSPw4QXqEnoA7n2e90w=
Date:   Wed, 18 Dec 2019 17:12:54 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     mike.kravetz@oracle.com, shuah@kernel.org, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        aneesh.kumar@linux.vnet.ibm.com, mkoutny@suse.com,
        Hillf Danton <hdanton@sina.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v9 1/8] hugetlb_cgroup: Add hugetlb_cgroup reservation
 counter
Message-Id: <20191218171254.79664a964c0c61e6054dff64@linux-foundation.org>
In-Reply-To: <20191217231615.164161-1-almasrymina@google.com>
References: <20191217231615.164161-1-almasrymina@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 17 Dec 2019 15:16:08 -0800 Mina Almasry <almasrymina@google.com> wrote:

> These counters will track hugetlb reservations rather than hugetlb
> memory faulted in. This patch only adds the counter, following patches
> add the charging and uncharging of the counter.
> 
> This is patch 1 of an 8 patch series.
> 
> Problem:
> Currently tasks attempting to allocate more hugetlb memory than is available get
> a failure at mmap/shmget time. This is thanks to Hugetlbfs Reservations [1].
> However, if a task attempts to allocate hugetlb memory only more than its
> hugetlb_cgroup limit allows, the kernel will allow the mmap/shmget call,
> but will SIGBUS the task when it attempts to fault the memory in.
> 
> We have developers interested in using hugetlb_cgroups, and they have expressed
> dissatisfaction regarding this behavior. We'd like to improve this
> behavior such that tasks violating the hugetlb_cgroup limits get an error on
> mmap/shmget time, rather than getting SIGBUS'd when they try to fault
> the excess memory in.
> 
> The underlying problem is that today's hugetlb_cgroup accounting happens
> at hugetlb memory *fault* time, rather than at *reservation* time.
> Thus, enforcing the hugetlb_cgroup limit only happens at fault time, and
> the offending task gets SIGBUS'd.
> 
> Proposed Solution:
> A new page counter named hugetlb.xMB.reservation_[limit|usage]_in_bytes. This
> counter has slightly different semantics than
> hugetlb.xMB.[limit|usage]_in_bytes:
> 
> - While usage_in_bytes tracks all *faulted* hugetlb memory,
> reservation_usage_in_bytes tracks all *reserved* hugetlb memory and
> hugetlb memory faulted in without a prior reservation.
> 
> - If a task attempts to reserve more memory than limit_in_bytes allows,
> the kernel will allow it to do so. But if a task attempts to reserve
> more memory than reservation_limit_in_bytes, the kernel will fail this
> reservation.
> 
> This proposal is implemented in this patch series, with tests to verify
> functionality and show the usage. We also added cgroup-v2 support to
> hugetlb_cgroup so that the new use cases can be extended to v2.

This would make
http://lkml.kernel.org/r/20191216193831.540953-1-gscrivan@redhat.com
obsolete?


> Alternatives considered:
> 1. A new cgroup, instead of only a new page_counter attached to
>    the existing hugetlb_cgroup. Adding a new cgroup seemed like a lot of code
>    duplication with hugetlb_cgroup. Keeping hugetlb related page counters under
>    hugetlb_cgroup seemed cleaner as well.
> 
> 2. Instead of adding a new counter, we considered adding a sysctl that modifies
>    the behavior of hugetlb.xMB.[limit|usage]_in_bytes, to do accounting at
>    reservation time rather than fault time. Adding a new page_counter seems
>    better as userspace could, if it wants, choose to enforce different cgroups
>    differently: one via limit_in_bytes, and another via
>    reservation_limit_in_bytes. This could be very useful if you're
>    transitioning how hugetlb memory is partitioned on your system one
>    cgroup at a time, for example. Also, someone may find usage for both
>    limit_in_bytes and reservation_limit_in_bytes concurrently, and this
>    approach gives them the option to do so.
> 

