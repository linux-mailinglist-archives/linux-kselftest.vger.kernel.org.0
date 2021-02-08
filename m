Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22081312CE7
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Feb 2021 10:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhBHJMF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Feb 2021 04:12:05 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12487 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbhBHJJt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Feb 2021 04:09:49 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DZ0Xf3KJhzjL2G;
        Mon,  8 Feb 2021 17:07:30 +0800 (CST)
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.187.128) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Mon, 8 Feb 2021 17:08:43 +0800
From:   Yanan Wang <wangyanan55@huawei.com>
To:     <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        "Andrew Jones" <drjones@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Ben Gardon <bgardon@google.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        <wanghaibin.wang@huawei.com>, <yuzenghui@huawei.com>,
        Yanan Wang <wangyanan55@huawei.com>
Subject: [RFC PATCH 0/2] Add a test for kvm page table code
Date:   Mon, 8 Feb 2021 17:08:39 +0800
Message-ID: <20210208090841.333724-1-wangyanan55@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.187.128]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

This test is added to serve as a performance tester and a bug reproducer
for kvm page table code (GPA->HPA mappings), it gives guidance for the
people trying to make some improvement for kvm.

The following explains what we can exactly do through this test.
And a RFC is sent for comments, thanks.

The function guest_code() is designed to cover conditions where a single vcpu
or multiple vcpus access guest pages within the same memory range, in three
VM stages(before dirty-logging, during dirty-logging, after dirty-logging).
Besides, the backing source memory type(ANONYMOUS/THP/HUGETLB) of the tested
memory region can be specified by users, which means normal page mappings or
block mappings can be chosen by users to be created in the test.

If use of ANONYMOUS memory is specified, kvm will create page mappings for the
tested memory region before dirty-logging, and update attributes of the page
mappings from RO to RW during dirty-logging. If use of THP/HUGETLB memory is
specified, kvm will create block mappings for the tested memory region before
dirty-logging, and split the blcok mappings into page mappings during
dirty-logging, and coalesce the page mappings back into block mappings after
dirty-logging is stopped.

So in summary, as a performance tester, this test can present the performance
of kvm creating/updating normal page mappings, or the performance of kvm
creating/splitting/recovering block mappings, through execution time.

When we need to coalesce the page mappings back to block mappings after dirty
logging is stopped, we have to firstly invalidate *all* the TLB entries for the
page mappings right before installation of the block entry, because a TLB conflict
abort error could occur if we can't invalidate the TLB entries fully. We have
hit this TLB conflict twice on aarch64 software implementation and fixed it.
As this test can imulate process from dirty-logging enabled to dirty-logging
stopped of a VM with block mappings, so it can also reproduce this TLB conflict
abort due to inadequate TLB invalidation when coalescing tables.

Links about the TLB conflict abort:
https://lore.kernel.org/lkml/20201201201034.116760-3-wangyanan55@huawei.com/

---

Here are some test examples of this test:
platform: HiSilicon Kunpeng920 (aarch64, FWB not supported)
host kernel: Linux mainline

(1) Based on v5.11-rc6

cmdline: ./kvm_page_table_test -m 4 -t 0 -g 4K -s 1G -v 1
	   (1 vcpu, 1G memory, page mappings(granule 4K))
KVM_CREATE_MAPPINGS: 0.8196s 0.8260s 0.8258s 0.8169s 0.8190s
KVM_UPDATE_MAPPINGS: 1.1930s 1.1949s 1.1940s 1.1934s 1.1946s

cmdline: ./kvm_page_table_test -m 4 -t 0 -g 4K -s 1G -v 20
	   (20 vcpus, 1G memory, page mappings(granule 4K))
KVM_CREATE_MAPPINGS: 23.4028s 23.8015s 23.6702s 23.9437s 22.1646s
KVM_UPDATE_MAPPINGS: 16.9550s 16.4734s 16.8300s 16.9621s 16.9402s

cmdline: ./kvm_page_table_test -m 4 -t 2 -g 1G -s 20G -v 1
	   (1 vcpu, 20G memory, block mappings(granule 1G))
KVM_CREATE_MAPPINGS: 3.7040s 3.7053s 3.7047s 3.7061s 3.7068s
KVM_ADJUST_MAPPINGS: 2.8264s 2.8266s 2.8272s 2.8259s 2.8283s

cmdline: ./kvm_page_table_test -m 4 -t 2 -g 1G -s 20G -v 20
	   (20 vcpus, 20G memory, block mappings(granule 1G))
KVM_CREATE_MAPPINGS: 52.8338s 52.8327s 52.8336s 52.8255s 52.8303s
KVM_ADJUST_MAPPINGS: 52.0466s 52.0473s 52.0550s 52.0518s 52.0467s

(2) I have post a patch series to improve efficiency of stage2 page table code,
    so test the performance changes.

cmdline: ./kvm_page_table_test -m 4 -t 2 -g 1G -s 20G -v 20
 	   (20 vcpus, 20G memory, block mappings(granule 1G))
Before patch: KVM_CREATE_MAPPINGS: 52.8338s 52.8327s 52.8336s 52.8255s 52.8303s
After  patch: KVM_CREATE_MAPPINGS:  3.7022s  3.7031s  3.7028s  3.7012s  3.7024s

Before patch: KVM_ADJUST_MAPPINGS: 52.0466s 52.0473s 52.0550s 52.0518s 52.0467s
After  patch: KVM_ADJUST_MAPPINGS:  0.3008s  0.3004s  0.2974s  0.2917s  0.2900s

cmdline: ./kvm_page_table_test -m 4 -t 2 -g 1G -s 20G -v 40
	   (40 vcpus, 20G memory, block mappings(granule 1G))
Before patch: KVM_CREATE_MAPPINGS: 104.560s 104.556s 104.554s 104.556s 104.550s
After  patch: KVM_CREATE_MAPPINGS:  3.7011s  3.7103s  3.7005s  3.7024s  3.7106s

Before patch: KVM_ADJUST_MAPPINGS: 103.931s 103.936s 103.927s 103.942s 103.927s
After  patch: KVM_ADJUST_MAPPINGS:  0.3541s  0.3694s  0.3656s  0.3693s  0.3687s

---

Yanan Wang (2):
  KVM: selftests: Add a macro to get string of vm_mem_backing_src_type
  KVM: selftests: Add a test for kvm page table code

 tools/testing/selftests/kvm/Makefile          |   3 +
 .../testing/selftests/kvm/include/kvm_util.h  |   3 +
 .../selftests/kvm/kvm_page_table_test.c       | 518 ++++++++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c    |   8 +
 4 files changed, 532 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/kvm_page_table_test.c

-- 
2.23.0

