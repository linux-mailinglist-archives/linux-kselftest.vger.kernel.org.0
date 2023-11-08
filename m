Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A077E5DBA
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Nov 2023 20:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbjKHTAt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 14:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbjKHTAc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 14:00:32 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593B1213D;
        Wed,  8 Nov 2023 11:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699470029; x=1731006029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ze9yHJfjDYrnDYjpHoXVOqA9CFbTZQF3q6E6RV+EKNU=;
  b=ajcAuu0GP+h2NuPBedt2fQCQQCy9HCQRcGkijDMQqcfGE5OybX3sPs7p
   nqa0PIUQPg2r4eksHL9L5v+0lTGuHjNUR+1DmGbkAUvlN11L2UJtOAV8u
   ox9I/KyG3yh/mArk18arK7cJKPoOXMsxxfG7xZlVwla/rodddMSskv1/4
   zDE/Eh8iXmSPlG++Jgh+WUzs5TcBeTClwa4EOlHTdKCXJ+LdgXHdY1sYN
   zpivHYgWILHCFqB+/vRYNhwKimetf6T8a47XHqYdlooIlskqvycMFyXGr
   9BwgCvulVL/jaBzboWJm7wmXE2pQ8/+FFVzWvEISelCTuskwK4If4Tyvn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="8486466"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="8486466"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 11:00:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="10892519"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orviesa001.jf.intel.com with ESMTP; 08 Nov 2023 11:00:27 -0800
From:   Xin Li <xin3.li@intel.com>
To:     kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     seanjc@google.com, pbonzini@redhat.com, corbet@lwn.net,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, vkuznets@redhat.com, peterz@infradead.org,
        ravi.v.shankar@intel.com
Subject: [PATCH v1 22/23] KVM: selftests: Add a new VM guest mode to run user level code
Date:   Wed,  8 Nov 2023 10:30:02 -0800
Message-ID: <20231108183003.5981-23-xin3.li@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108183003.5981-1-xin3.li@intel.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a new VM guest mode VM_MODE_PXXV48_4K_USER to set the user bit of
guest page table entries, thus allow user level code to run in guests.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 .../testing/selftests/kvm/include/kvm_util_base.h |  1 +
 tools/testing/selftests/kvm/lib/kvm_util.c        |  5 ++++-
 .../testing/selftests/kvm/lib/x86_64/processor.c  | 15 ++++++++++-----
 tools/testing/selftests/kvm/lib/x86_64/vmx.c      |  4 ++--
 4 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index a18db6a7b3cf..1d2922447978 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -185,6 +185,7 @@ enum vm_guest_mode {
 	VM_MODE_P36V48_16K,
 	VM_MODE_P36V48_64K,
 	VM_MODE_P36V47_16K,
+	VM_MODE_PXXV48_4K_USER,	/* For 48bits VA but ANY bits PA with USER bit set */
 	NUM_VM_MODES,
 };
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 7a8af1821f5d..36f2acb378b6 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -162,6 +162,7 @@ const char *vm_guest_mode_string(uint32_t i)
 		[VM_MODE_P36V48_16K]	= "PA-bits:36,  VA-bits:48, 16K pages",
 		[VM_MODE_P36V48_64K]	= "PA-bits:36,  VA-bits:48, 64K pages",
 		[VM_MODE_P36V47_16K]	= "PA-bits:36,  VA-bits:47, 16K pages",
+		[VM_MODE_PXXV48_4K_USER]	= "PA-bits:ANY, VA-bits:48,  4K user pages",
 	};
 	_Static_assert(sizeof(strings)/sizeof(char *) == NUM_VM_MODES,
 		       "Missing new mode strings?");
@@ -187,6 +188,7 @@ const struct vm_guest_mode_params vm_guest_mode_params[] = {
 	[VM_MODE_P36V48_16K]	= { 36, 48,  0x4000, 14 },
 	[VM_MODE_P36V48_64K]	= { 36, 48, 0x10000, 16 },
 	[VM_MODE_P36V47_16K]	= { 36, 47,  0x4000, 14 },
+	[VM_MODE_PXXV48_4K_USER]	= {  0,  0,  0x1000, 12 },
 };
 _Static_assert(sizeof(vm_guest_mode_params)/sizeof(struct vm_guest_mode_params) == NUM_VM_MODES,
 	       "Missing new mode params?");
@@ -260,6 +262,7 @@ struct kvm_vm *____vm_create(enum vm_guest_mode mode)
 		vm->pgtable_levels = 3;
 		break;
 	case VM_MODE_PXXV48_4K:
+	case VM_MODE_PXXV48_4K_USER:
 #ifdef __x86_64__
 		kvm_get_cpu_address_width(&vm->pa_bits, &vm->va_bits);
 		/*
@@ -275,7 +278,7 @@ struct kvm_vm *____vm_create(enum vm_guest_mode mode)
 		vm->pgtable_levels = 4;
 		vm->va_bits = 48;
 #else
-		TEST_FAIL("VM_MODE_PXXV48_4K not supported on non-x86 platforms");
+		TEST_FAIL("VM_MODE_PXXV48_4K(_USER) not supported on non-x86 platforms");
 #endif
 		break;
 	case VM_MODE_P47V64_4K:
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index d8288374078e..a8e60641df53 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -124,8 +124,8 @@ bool kvm_is_tdp_enabled(void)
 
 void virt_arch_pgd_alloc(struct kvm_vm *vm)
 {
-	TEST_ASSERT(vm->mode == VM_MODE_PXXV48_4K, "Attempt to use "
-		"unknown or unsupported guest mode, mode: 0x%x", vm->mode);
+	TEST_ASSERT((vm->mode == VM_MODE_PXXV48_4K) || (vm->mode == VM_MODE_PXXV48_4K_USER),
+		"Attempt to use unknown or unsupported guest mode, mode: 0x%x", vm->mode);
 
 	/* If needed, create page map l4 table. */
 	if (!vm->pgd_created) {
@@ -159,6 +159,8 @@ static uint64_t *virt_create_upper_pte(struct kvm_vm *vm,
 
 	if (!(*pte & PTE_PRESENT_MASK)) {
 		*pte = PTE_PRESENT_MASK | PTE_WRITABLE_MASK;
+		if (vm->mode == VM_MODE_PXXV48_4K_USER)
+			*pte |= PTE_USER_MASK;
 		if (current_level == target_level)
 			*pte |= PTE_LARGE_MASK | (paddr & PHYSICAL_PAGE_MASK);
 		else
@@ -185,7 +187,7 @@ void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr, int level)
 	uint64_t *pml4e, *pdpe, *pde;
 	uint64_t *pte;
 
-	TEST_ASSERT(vm->mode == VM_MODE_PXXV48_4K,
+	TEST_ASSERT((vm->mode == VM_MODE_PXXV48_4K) || (vm->mode == VM_MODE_PXXV48_4K_USER),
 		    "Unknown or unsupported guest mode, mode: 0x%x", vm->mode);
 
 	TEST_ASSERT((vaddr % pg_size) == 0,
@@ -222,6 +224,8 @@ void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr, int level)
 	TEST_ASSERT(!(*pte & PTE_PRESENT_MASK),
 		    "PTE already present for 4k page at vaddr: 0x%lx\n", vaddr);
 	*pte = PTE_PRESENT_MASK | PTE_WRITABLE_MASK | (paddr & PHYSICAL_PAGE_MASK);
+	if (vm->mode == VM_MODE_PXXV48_4K_USER)
+		*pte |= PTE_USER_MASK;
 }
 
 void virt_arch_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr)
@@ -268,8 +272,8 @@ uint64_t *__vm_get_page_table_entry(struct kvm_vm *vm, uint64_t vaddr,
 	TEST_ASSERT(*level >= PG_LEVEL_NONE && *level < PG_LEVEL_NUM,
 		    "Invalid PG_LEVEL_* '%d'", *level);
 
-	TEST_ASSERT(vm->mode == VM_MODE_PXXV48_4K, "Attempt to use "
-		"unknown or unsupported guest mode, mode: 0x%x", vm->mode);
+	TEST_ASSERT((vm->mode == VM_MODE_PXXV48_4K) || (vm->mode == VM_MODE_PXXV48_4K_USER),
+		"Attempt to use unknown or unsupported guest mode, mode: 0x%x", vm->mode);
 	TEST_ASSERT(sparsebit_is_set(vm->vpages_valid,
 		(vaddr >> vm->page_shift)),
 		"Invalid virtual address, vaddr: 0x%lx",
@@ -536,6 +540,7 @@ static void vcpu_setup(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 
 	switch (vm->mode) {
 	case VM_MODE_PXXV48_4K:
+	case VM_MODE_PXXV48_4K_USER:
 		sregs.cr0 = X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
 		sregs.cr4 |= X86_CR4_PAE | X86_CR4_OSFXSR;
 		sregs.efer |= (EFER_LME | EFER_LMA | EFER_NX);
diff --git a/tools/testing/selftests/kvm/lib/x86_64/vmx.c b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
index 59d97531c9b1..65147de6f9c0 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/vmx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
@@ -403,8 +403,8 @@ void __nested_pg_map(struct vmx_pages *vmx, struct kvm_vm *vm,
 	struct eptPageTableEntry *pt = vmx->eptp_hva, *pte;
 	uint16_t index;
 
-	TEST_ASSERT(vm->mode == VM_MODE_PXXV48_4K, "Attempt to use "
-		    "unknown or unsupported guest mode, mode: 0x%x", vm->mode);
+	TEST_ASSERT((vm->mode == VM_MODE_PXXV48_4K) || (vm->mode == VM_MODE_PXXV48_4K_USER),
+		    "Attempt to use unknown or unsupported guest mode, mode: 0x%x", vm->mode);
 
 	TEST_ASSERT((nested_paddr >> 48) == 0,
 		    "Nested physical address 0x%lx requires 5-level paging",
-- 
2.42.0

