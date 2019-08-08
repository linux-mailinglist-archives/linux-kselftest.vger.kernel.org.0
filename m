Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79EB286B6E
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2019 22:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404450AbfHHUXL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Aug 2019 16:23:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404588AbfHHUXL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Aug 2019 16:23:11 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DE1C2173C;
        Thu,  8 Aug 2019 20:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565295790;
        bh=RHraHwfrbwkREg74Xy9SOBTOzh4EzmM+GX9f7LiI4tg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Sv3ezScU40/zyzSwPkXgXdl2Zfpk274kLgsFqRrBhADRQrvgV8spmG+hFWG1IoYWT
         Pbp2ldUVK7N9APpheUobyrSNhYkO7tImql2TTefGzCTJJ5SKTkMgTlB32mCMLnkk8a
         RywI5Y4D5/UX4eBw5YX0L4x6Q7BQPy92DbnCOaC8=
Subject: Re: [RFC PATCH] hugetlbfs: Add hugetlb_cgroup reservation limits
To:     Mina Almasry <almasrymina@google.com>, mike.kravetz@oracle.com
Cc:     rientjes@google.com, shakeelb@google.com, gthelen@google.com,
        akpm@linux-foundation.org, khalid.aziz@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190808194002.226688-1-almasrymina@google.com>
From:   shuah <shuah@kernel.org>
Message-ID: <528b37c6-3e7a-c6fc-a322-beecb89011a5@kernel.org>
Date:   Thu, 8 Aug 2019 14:23:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808194002.226688-1-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/8/19 1:40 PM, Mina Almasry wrote:
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
> reservation_usage_in_bytes tracks all *reserved* hugetlb memory.
> 
> - If a task attempts to reserve more memory than limit_in_bytes allows,
> the kernel will allow it to do so. But if a task attempts to reserve
> more memory than reservation_limit_in_bytes, the kernel will fail this
> reservation.
> 
> This proposal is implemented in this patch, with tests to verify
> functionality and show the usage.
> 
> Alternatives considered:
> 1. A new cgroup, instead of only a new page_counter attached to
>     the existing hugetlb_cgroup. Adding a new cgroup seemed like a lot of code
>     duplication with hugetlb_cgroup. Keeping hugetlb related page counters under
>     hugetlb_cgroup seemed cleaner as well.
> 
> 2. Instead of adding a new counter, we considered adding a sysctl that modifies
>     the behavior of hugetlb.xMB.[limit|usage]_in_bytes, to do accounting at
>     reservation time rather than fault time. Adding a new page_counter seems
>     better as userspace could, if it wants, choose to enforce different cgroups
>     differently: one via limit_in_bytes, and another via
>     reservation_limit_in_bytes. This could be very useful if you're
>     transitioning how hugetlb memory is partitioned on your system one
>     cgroup at a time, for example. Also, someone may find usage for both
>     limit_in_bytes and reservation_limit_in_bytes concurrently, and this
>     approach gives them the option to do so.
> 
> Caveats:
> 1. This support is implemented for cgroups-v1. I have not tried
>     hugetlb_cgroups with cgroups v2, and AFAICT it's not supported yet.
>     This is largely because we use cgroups-v1 for now. If required, I
>     can add hugetlb_cgroup support to cgroups v2 in this patch or
>     a follow up.
> 2. Most complicated bit of this patch I believe is: where to store the
>     pointer to the hugetlb_cgroup to uncharge at unreservation time?
>     Normally the cgroup pointers hang off the struct page. But, with
>     hugetlb_cgroup reservations, one task can reserve a specific page and another
>     task may fault it in (I believe), so storing the pointer in struct
>     page is not appropriate. Proposed approach here is to store the pointer in
>     the resv_map. See patch for details.
> 
> [1]: https://www.kernel.org/doc/html/latest/vm/hugetlbfs_reserv.html
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>   include/linux/hugetlb.h                       |  10 +-
>   include/linux/hugetlb_cgroup.h                |  19 +-
>   mm/hugetlb.c                                  | 256 ++++++++--
>   mm/hugetlb_cgroup.c                           | 153 +++++-

Is there a reason why all these changes are in a single patch?
I can see these split in at least 2 or 3 patches with the test
as a separate patch.

Makes it lot easier to review.

thanks,
-- Shuah
