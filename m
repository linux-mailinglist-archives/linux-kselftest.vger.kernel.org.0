Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A40239EFCB
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 09:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhFHHjo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Jun 2021 03:39:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:17020 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230401AbhFHHjn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Jun 2021 03:39:43 -0400
IronPort-SDR: 2BqlBuHgEapVFq6cwNdTWqdokmGEWk7F3AROyjNr5pyGxvRrO9s6WurVeNReu1lfoSalQL7FUs
 VNpQdwgNmmVA==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="185164461"
X-IronPort-AV: E=Sophos;i="5.83,257,1616482800"; 
   d="scan'208";a="185164461"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 00:37:30 -0700
IronPort-SDR: oYajHQDZ22VDow9JVoiWIac01w+Dg4YYSNPuiCx0z6gpkf6Ykk//w40KibUN+1oYOSd3ru2heu
 r3v77OhmNF5w==
X-IronPort-AV: E=Sophos;i="5.83,257,1616482800"; 
   d="scan'208";a="481846557"
Received: from duan-client-optiplex-7080.bj.intel.com ([10.238.156.114])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 00:37:28 -0700
From:   Zhenzhong Duan <zhenzhong.duan@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        maciej.szmigiero@oracle.com, drjones@redhat.com,
        pbonzini@redhat.com, shuah@kernel.org,
        Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 3/3] selftests: kvm: Add support for customized slot0 memory size
Date:   Wed,  9 Jun 2021 07:38:16 +0800
Message-Id: <20210608233816.423958-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210608233816.423958-1-zhenzhong.duan@intel.com>
References: <20210608233816.423958-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Current implementatiion only create VM with slot0 memory size
of fixed 512 pages plus page tables and per-cpu memory.

Add a new parameter slot0_mem_pages to vm_create_with_vcpus() and
some comments to clarify the meaning of slot0_mem_pages and
extra_mem_pages.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  7 +--
 .../selftests/kvm/kvm_page_table_test.c       |  2 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    | 47 +++++++++++++++----
 .../selftests/kvm/lib/perf_test_util.c        |  2 +-
 4 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index fcd8e3855111..8bcadfa8cea5 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -285,10 +285,11 @@ struct kvm_vm *vm_create_default_with_vcpus(uint32_t nr_vcpus, uint64_t extra_me
 					    uint32_t num_percpu_pages, void *guest_code,
 					    uint32_t vcpuids[]);
 
-/* Like vm_create_default_with_vcpus, but accepts mode as a parameter */
+/* Like vm_create_default_with_vcpus, but accepts mode and slot0 memory as a parameter */
 struct kvm_vm *vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
-				    uint64_t extra_mem_pages, uint32_t num_percpu_pages,
-				    void *guest_code, uint32_t vcpuids[]);
+				    uint64_t slot0_mem_pages, uint64_t extra_mem_pages,
+				    uint32_t num_percpu_pages, void *guest_code,
+				    uint32_t vcpuids[]);
 
 /*
  * Adds a vCPU with reasonable defaults (e.g. a stack)
diff --git a/tools/testing/selftests/kvm/kvm_page_table_test.c b/tools/testing/selftests/kvm/kvm_page_table_test.c
index 1c4753fff19e..82171f17c1d7 100644
--- a/tools/testing/selftests/kvm/kvm_page_table_test.c
+++ b/tools/testing/selftests/kvm/kvm_page_table_test.c
@@ -268,7 +268,7 @@ static struct kvm_vm *pre_init_before_test(enum vm_guest_mode mode, void *arg)
 
 	/* Create a VM with enough guest pages */
 	guest_num_pages = test_mem_size / guest_page_size;
-	vm = vm_create_with_vcpus(mode, nr_vcpus,
+	vm = vm_create_with_vcpus(mode, nr_vcpus, DEFAULT_GUEST_PHY_PAGES,
 				  guest_num_pages, 0, guest_code, NULL);
 
 	/* Align down GPA of the testing memslot */
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 63418df921f0..d86422a119fd 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -308,21 +308,50 @@ struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
 	return vm;
 }
 
+/*
+ * VM Create with customized parameters
+ *
+ * Input Args:
+ *   mode - VM Mode (e.g. VM_MODE_P52V48_4K)
+ *   nr_vcpus - VCPU count
+ *   slot0_mem_pages - Slot0 physical memory size
+ *   extra_mem_pages - Non-slot0 physical memory total size
+ *   num_percpu_pages - Per-cpu physical memory pages
+ *   guest_code - Guest entry point
+ *   vcpuids - VCPU IDs
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   Pointer to opaque structure that describes the created VM.
+ *
+ * Creates a VM with the mode specified by mode (e.g. VM_MODE_P52V48_4K),
+ * with customized slot0 memory size, at least 512 pages currently.
+ * extra_mem_pages is only used to calculate the maximum page table size,
+ * no real memory allocation for non-slot0 memory in this function.
+ */
 struct kvm_vm *vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
-				    uint64_t extra_mem_pages, uint32_t num_percpu_pages,
-				    void *guest_code, uint32_t vcpuids[])
+				    uint64_t slot0_mem_pages, uint64_t extra_mem_pages,
+				    uint32_t num_percpu_pages, void *guest_code,
+				    uint32_t vcpuids[])
 {
+	uint64_t vcpu_pages, extra_pg_pages, pages;
+	struct kvm_vm *vm;
+	int i;
+
+	/* Force slot0 memory size not small than DEFAULT_GUEST_PHY_PAGES */
+	if (slot0_mem_pages < DEFAULT_GUEST_PHY_PAGES)
+		slot0_mem_pages = DEFAULT_GUEST_PHY_PAGES;
+
 	/* The maximum page table size for a memory region will be when the
 	 * smallest pages are used. Considering each page contains x page
 	 * table descriptors, the total extra size for page tables (for extra
 	 * N pages) will be: N/x+N/x^2+N/x^3+... which is definitely smaller
 	 * than N/x*2.
 	 */
-	uint64_t vcpu_pages = (DEFAULT_STACK_PGS + num_percpu_pages) * nr_vcpus;
-	uint64_t extra_pg_pages = (extra_mem_pages + vcpu_pages) / PTES_PER_MIN_PAGE * 2;
-	uint64_t pages = DEFAULT_GUEST_PHY_PAGES + vcpu_pages + extra_pg_pages;
-	struct kvm_vm *vm;
-	int i;
+	vcpu_pages = (DEFAULT_STACK_PGS + num_percpu_pages) * nr_vcpus;
+	extra_pg_pages = (slot0_mem_pages + extra_mem_pages + vcpu_pages) / PTES_PER_MIN_PAGE * 2;
+	pages = slot0_mem_pages + vcpu_pages + extra_pg_pages;
 
 	TEST_ASSERT(nr_vcpus <= kvm_check_cap(KVM_CAP_MAX_VCPUS),
 		    "nr_vcpus = %d too large for host, max-vcpus = %d",
@@ -354,8 +383,8 @@ struct kvm_vm *vm_create_default_with_vcpus(uint32_t nr_vcpus, uint64_t extra_me
 					    uint32_t num_percpu_pages, void *guest_code,
 					    uint32_t vcpuids[])
 {
-	return vm_create_with_vcpus(VM_MODE_DEFAULT, nr_vcpus, extra_mem_pages,
-				    num_percpu_pages, guest_code, vcpuids);
+	return vm_create_with_vcpus(VM_MODE_DEFAULT, nr_vcpus, DEFAULT_GUEST_PHY_PAGES,
+				    extra_mem_pages, num_percpu_pages, guest_code, vcpuids);
 }
 
 struct kvm_vm *vm_create_default(uint32_t vcpuid, uint64_t extra_mem_pages,
diff --git a/tools/testing/selftests/kvm/lib/perf_test_util.c b/tools/testing/selftests/kvm/lib/perf_test_util.c
index abf381800a59..7397ca299835 100644
--- a/tools/testing/selftests/kvm/lib/perf_test_util.c
+++ b/tools/testing/selftests/kvm/lib/perf_test_util.c
@@ -69,7 +69,7 @@ struct kvm_vm *perf_test_create_vm(enum vm_guest_mode mode, int vcpus,
 	TEST_ASSERT(vcpu_memory_bytes % perf_test_args.guest_page_size == 0,
 		    "Guest memory size is not guest page size aligned.");
 
-	vm = vm_create_with_vcpus(mode, vcpus,
+	vm = vm_create_with_vcpus(mode, vcpus, DEFAULT_GUEST_PHY_PAGES,
 				  (vcpus * vcpu_memory_bytes) / perf_test_args.guest_page_size,
 				  0, guest_code, NULL);
 
-- 
2.25.1

