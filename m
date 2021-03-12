Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391CE3384D0
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Mar 2021 06:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbhCLFDo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Mar 2021 00:03:44 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:3360 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhCLFDe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Mar 2021 00:03:34 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4DxYYY6x8gz5T4V;
        Fri, 12 Mar 2021 13:01:05 +0800 (CST)
Received: from dggpemm500023.china.huawei.com (7.185.36.83) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 12 Mar 2021 13:03:23 +0800
Received: from [10.174.187.128] (10.174.187.128) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Fri, 12 Mar 2021 13:03:22 +0800
Subject: Re: [RFC PATCH v4 0/9] KVM: selftests: some improvement and a new
 test for kvm page table
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ben Gardon <bgardon@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <wanghaibin.wang@huawei.com>, <yezengruan@huawei.com>,
        <yuzenghui@huawei.com>
References: <20210302125751.19080-1-wangyanan55@huawei.com>
From:   "wangyanan (Y)" <wangyanan55@huawei.com>
Message-ID: <086dfadc-70c5-1a90-e7ff-e1f1095733bb@huawei.com>
Date:   Fri, 12 Mar 2021 13:03:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210302125751.19080-1-wangyanan55@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.187.128]
X-ClientProxiedBy: dggeme714-chm.china.huawei.com (10.1.199.110) To
 dggpemm500023.china.huawei.com (7.185.36.83)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi all,

Kindly ping :)!

Are there any further comments for this v4 series? Please let me know if 
there
is still something that needs fixing.

Or is this v4 series fine enough to be queued? Most of the patches have been
added with Reviewed-by. If there are merge conflicts with the newest branch,
please also let me know and I will send a new version fixed.

Regards,
Yanan

On 2021/3/2 20:57, Yanan Wang wrote:
> Hi,
> This v4 series can mainly include two parts.
> Based on kvm queue branch: https://git.kernel.org/pub/scm/virt/kvm/kvm.git/log/?h=queue
> Links of v1: https://lore.kernel.org/lkml/20210208090841.333724-1-wangyanan55@huawei.com/
> Links of v2: https://lore.kernel.org/lkml/20210225055940.18748-1-wangyanan55@huawei.com/
> Links of v3: https://lore.kernel.org/lkml/20210301065916.11484-1-wangyanan55@huawei.com/
>
> In the first part, all the known hugetlb backing src types specified
> with different hugepage sizes are listed, so that we can specify use
> of hugetlb source of the exact granularity that we want, instead of
> the system default ones. And as all the known hugetlb page sizes are
> listed, it's appropriate for all architectures. Besides, a helper that
> can get granularity of different backing src types(anonumous/thp/hugetlb)
> is added, so that we can use the accurate backing src granularity for
> kinds of alignment or guest memory accessing of vcpus.
>
> In the second part, a new test is added:
> This test is added to serve as a performance tester and a bug reproducer
> for kvm page table code (GPA->HPA mappings), it gives guidance for the
> people trying to make some improvement for kvm. And the following explains
> what we can exactly do through this test.
>
> The function guest_code() can cover the conditions where a single vcpu or
> multiple vcpus access guest pages within the same memory region, in three
> VM stages(before dirty logging, during dirty logging, after dirty logging).
> Besides, the backing src memory type(ANONYMOUS/THP/HUGETLB) of the tested
> memory region can be specified by users, which means normal page mappings
> or block mappings can be chosen by users to be created in the test.
>
> If ANONYMOUS memory is specified, kvm will create normal page mappings
> for the tested memory region before dirty logging, and update attributes
> of the page mappings from RO to RW during dirty logging. If THP/HUGETLB
> memory is specified, kvm will create block mappings for the tested memory
> region before dirty logging, and split the blcok mappings into normal page
> mappings during dirty logging, and coalesce the page mappings back into
> block mappings after dirty logging is stopped.
>
> So in summary, as a performance tester, this test can present the
> performance of kvm creating/updating normal page mappings, or the
> performance of kvm creating/splitting/recovering block mappings,
> through execution time.
>
> When we need to coalesce the page mappings back to block mappings after
> dirty logging is stopped, we have to firstly invalidate *all* the TLB
> entries for the page mappings right before installation of the block entry,
> because a TLB conflict abort error could occur if we can't invalidate the
> TLB entries fully. We have hit this TLB conflict twice on aarch64 software
> implementation and fixed it. As this test can imulate process from dirty
> logging enabled to dirty logging stopped of a VM with block mappings,
> so it can also reproduce this TLB conflict abort due to inadequate TLB
> invalidation when coalescing tables.
>
> Links about the TLB conflict abort:
> https://lore.kernel.org/lkml/20201201201034.116760-3-wangyanan55@huawei.com/
>
> ---
>
> Change logs:
>
> v3->v4:
> - Add a helper to get system default hugetlb page size
> - Add tags of Reviewed-by of Ben in the patches
>
> v2->v3:
> - Add tags of Suggested-by, Reviewed-by in the patches
> - Add a generic micro to get hugetlb page sizes
> - Some changes for suggestions about v2 series
>
> v1->v2:
> - Add a patch to sync header files
> - Add helpers to get granularity of different backing src types
> - Some changes for suggestions about v1 series
>
> ---
>
> Yanan Wang (9):
>    tools headers: sync headers of asm-generic/hugetlb_encode.h
>    tools headers: Add a macro to get HUGETLB page sizes for mmap
>    KVM: selftests: Use flag CLOCK_MONOTONIC_RAW for timing
>    KVM: selftests: Make a generic helper to get vm guest mode strings
>    KVM: selftests: Add a helper to get system configured THP page size
>    KVM: selftests: Add a helper to get system default hugetlb page size
>    KVM: selftests: List all hugetlb src types specified with page sizes
>    KVM: selftests: Adapt vm_userspace_mem_region_add to new helpers
>    KVM: selftests: Add a test for kvm page table code
>
>   include/uapi/linux/mman.h                     |   2 +
>   tools/include/asm-generic/hugetlb_encode.h    |   3 +
>   tools/include/uapi/linux/mman.h               |   2 +
>   tools/testing/selftests/kvm/Makefile          |   3 +
>   .../selftests/kvm/demand_paging_test.c        |   8 +-
>   .../selftests/kvm/dirty_log_perf_test.c       |  14 +-
>   .../testing/selftests/kvm/include/kvm_util.h  |   4 +-
>   .../testing/selftests/kvm/include/test_util.h |  21 +-
>   .../selftests/kvm/kvm_page_table_test.c       | 476 ++++++++++++++++++
>   tools/testing/selftests/kvm/lib/kvm_util.c    |  59 ++-
>   tools/testing/selftests/kvm/lib/test_util.c   | 122 ++++-
>   tools/testing/selftests/kvm/steal_time.c      |   4 +-
>   12 files changed, 659 insertions(+), 59 deletions(-)
>   create mode 100644 tools/testing/selftests/kvm/kvm_page_table_test.c
>
