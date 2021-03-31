Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F60346045
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Mar 2021 14:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbhCWNw6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Mar 2021 09:52:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:14854 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbhCWNwr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Mar 2021 09:52:47 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F4Xnd6vvQz92yY;
        Tue, 23 Mar 2021 21:50:45 +0800 (CST)
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.187.128) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Tue, 23 Mar 2021 21:52:34 +0800
From:   Yanan Wang <wangyanan55@huawei.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Jones <drjones@redhat.com>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ben Gardon <bgardon@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Xu <peterx@redhat.com>, "Ingo Molnar" <mingo@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <wanghaibin.wang@huawei.com>, <yuzenghui@huawei.com>,
        Yanan Wang <wangyanan55@huawei.com>
Subject: [RFC PATCH v5 00/10] KVM: selftests: some improvement and a new test for kvm page table
Date:   Tue, 23 Mar 2021 21:52:21 +0800
Message-ID: <20210323135231.24948-1-wangyanan55@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.187.128]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,
This v5 series can mainly include two parts.
Based on kvm queue branch: https://git.kernel.org/pub/scm/virt/kvm/kvm.git/log/?h=queue

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

---

Change logs:

v4->v5:
- Use synchronization(sem_wait) for time measurement
- Add a new patch about TEST_ASSERT(patch 4)
- Address Andrew Jones's comments for v4 series
- Add Andrew Jones's R-b tags in some patches
- v4: https://lore.kernel.org/lkml/20210302125751.19080-1-wangyanan55@huawei.com/

v3->v4:
- Add a helper to get system default hugetlb page size
- Add tags of Reviewed-by of Ben in the patches
- v3: https://lore.kernel.org/lkml/20210301065916.11484-1-wangyanan55@huawei.com/

v2->v3:
- Add tags of Suggested-by, Reviewed-by in the patches
- Add a generic micro to get hugetlb page sizes
- Some changes for suggestions about v2 series
- v2: https://lore.kernel.org/lkml/20210225055940.18748-1-wangyanan55@huawei.com/

v1->v2:
- Add a patch to sync header files
- Add helpers to get granularity of different backing src types
- Some changes for suggestions about v1 series
- v1: https://lore.kernel.org/lkml/20210208090841.333724-1-wangyanan55@huawei.com/

---

Yanan Wang (10):
  tools headers: sync headers of asm-generic/hugetlb_encode.h
  tools headers: Add a macro to get HUGETLB page sizes for mmap
  KVM: selftests: Use flag CLOCK_MONOTONIC_RAW for timing
  KVM: selftests: Print the errno besides error-string in TEST_ASSERT
  KVM: selftests: Make a generic helper to get vm guest mode strings
  KVM: selftests: Add a helper to get system configured THP page size
  KVM: selftests: Add a helper to get system default hugetlb page size
  KVM: selftests: List all hugetlb src types specified with page sizes
  KVM: selftests: Adapt vm_userspace_mem_region_add to new helpers
  KVM: selftests: Add a test for kvm page table code

 include/uapi/linux/mman.h                     |   2 +
 tools/include/asm-generic/hugetlb_encode.h    |   3 +
 tools/include/uapi/linux/mman.h               |   2 +
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   3 +
 .../selftests/kvm/demand_paging_test.c        |   8 +-
 .../selftests/kvm/dirty_log_perf_test.c       |  14 +-
 .../testing/selftests/kvm/include/kvm_util.h  |   4 +-
 .../testing/selftests/kvm/include/test_util.h |  21 +-
 .../selftests/kvm/kvm_page_table_test.c       | 512 ++++++++++++++++++
 tools/testing/selftests/kvm/lib/assert.c      |   4 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    |  59 +-
 tools/testing/selftests/kvm/lib/test_util.c   | 163 +++++-
 tools/testing/selftests/kvm/steal_time.c      |   4 +-
 14 files changed, 739 insertions(+), 61 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/kvm_page_table_test.c

-- 
2.23.0

