Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82425324A4A
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Feb 2021 07:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbhBYGAc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 Feb 2021 01:00:32 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12648 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbhBYGAc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 Feb 2021 01:00:32 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DmMXM71F5z16CZL;
        Thu, 25 Feb 2021 13:58:11 +0800 (CST)
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.187.128) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Feb 2021 13:59:42 +0800
From:   Yanan Wang <wangyanan55@huawei.com>
To:     <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        Ben Gardon <bgardon@google.com>,
        "Sean Christopherson" <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Peter Xu <peterx@redhat.com>, Marc Zyngier <maz@kernel.org>,
        <wanghaibin.wang@huawei.com>, <yuzenghui@huawei.com>,
        "Yanan Wang" <wangyanan55@huawei.com>
Subject: [RFC PATCH v2 0/7] Some improvement and a new test for kvm page table
Date:   Thu, 25 Feb 2021 13:59:33 +0800
Message-ID: <20210225055940.18748-1-wangyanan55@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.187.128]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,
This v2 series can mainly include two parts.
Based on kvm queue branch: https://git.kernel.org/pub/scm/virt/kvm/kvm.git/log/?h=queue
Links of v1: https://lore.kernel.org/lkml/20210208090841.333724-1-wangyanan55@huawei.com/

In the first part, all the known hugetlb backing src types specified
with different hugepage sizes are listed, so that we can specify use
of hugetlb source of the exact granularity that we want, instead of
the system default ones. And as all the known hugetlb page sizes are
listed, it's appropriate for all architectures. Besides, a helper that
can get granularity of different backing src types(anonumous/thp/hugetlb)
is added, so that we can use the accurate backing src granularity for
kinds of alignment or guest memory accessing of vcpus.

In the second part, a new test is added:
This test is added to serve as a performance tester and a bug reproducer
for kvm page table code (GPA->HPA mappings), it gives guidance for the
people trying to make some improvement for kvm. And the following explains
what we can exactly do through this test.

The function guest_code() can cover the conditions where a single vcpu or
multiple vcpus access guest pages within the same memory region, in three
VM stages(before dirty logging, during dirty logging, after dirty logging).
Besides, the backing src memory type(ANONYMOUS/THP/HUGETLB) of the tested
memory region can be specified by users, which means normal page mappings
or block mappings can be chosen by users to be created in the test.

If ANONYMOUS memory is specified, kvm will create normal page mappings
for the tested memory region before dirty logging, and update attributes
of the page mappings from RO to RW during dirty logging. If THP/HUGETLB
memory is specified, kvm will create block mappings for the tested memory
region before dirty logging, and split the blcok mappings into normal page
mappings during dirty logging, and coalesce the page mappings back into
block mappings after dirty logging is stopped.

So in summary, as a performance tester, this test can present the
performance of kvm creating/updating normal page mappings, or the
performance of kvm creating/splitting/recovering block mappings,
through execution time.

When we need to coalesce the page mappings back to block mappings after
dirty logging is stopped, we have to firstly invalidate *all* the TLB
entries for the page mappings right before installation of the block entry,
because a TLB conflict abort error could occur if we can't invalidate the
TLB entries fully. We have hit this TLB conflict twice on aarch64 software
implementation and fixed it. As this test can imulate process from dirty
logging enabled to dirty logging stopped of a VM with block mappings,
so it can also reproduce this TLB conflict abort due to inadequate TLB
invalidation when coalescing tables.

Links about the TLB conflict abort:
https://lore.kernel.org/lkml/20201201201034.116760-3-wangyanan55@huawei.com/

Yanan Wang (7):
  tools include: sync head files of mmap flag encodings about hugetlb
  KVM: selftests: Use flag CLOCK_MONOTONIC_RAW for timing
  KVM: selftests: Make a generic helper to get vm guest mode strings
  KVM: selftests: Add a helper to get system configured THP page size
  KVM: selftests: List all hugetlb src types specified with page sizes
  KVM: selftests: Adapt vm_userspace_mem_region_add to new helpers
  KVM: selftests: Add a test for kvm page table code

 tools/include/asm-generic/hugetlb_encode.h    |   3 +
 tools/testing/selftests/kvm/Makefile          |   3 +
 .../selftests/kvm/demand_paging_test.c        |   8 +-
 .../selftests/kvm/dirty_log_perf_test.c       |  14 +-
 .../testing/selftests/kvm/include/kvm_util.h  |   4 +-
 .../testing/selftests/kvm/include/test_util.h |  21 +-
 .../selftests/kvm/kvm_page_table_test.c       | 476 ++++++++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  58 +--
 tools/testing/selftests/kvm/lib/test_util.c   |  92 +++-
 tools/testing/selftests/kvm/steal_time.c      |   4 +-
 10 files changed, 623 insertions(+), 60 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/kvm_page_table_test.c

-- 
2.19.1

