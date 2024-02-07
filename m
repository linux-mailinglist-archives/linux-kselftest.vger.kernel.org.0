Return-Path: <linux-kselftest+bounces-4272-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B2C84D0C0
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 19:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D4C3B23A4E
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 18:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70BA1386A1;
	Wed,  7 Feb 2024 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="chL9Ufci"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF98713666F;
	Wed,  7 Feb 2024 17:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328769; cv=none; b=I6cVb0ZrSHFCKZphI/Wc5NXta+qs5duu/XT9teNBcT4jbZnxP1AD7GubBnZXEF8PO6jsj22NBfgddfcdaF5x4geJtjaWnMwFQ6FTfrXiLQIvgMCjLlCufuduEFiL8za3LF4vTmdNC1iFNPPW6IbBG0OfVWSVZio76mLDBoxAM8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328769; c=relaxed/simple;
	bh=WIt9o4OjjawnuBTk8GUkaHPSrfrC5St66G3/Ao7RYxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dH2wJurC6EWjhQnfYXovyck33UiMvvLMCqjFfy0EcYBfzr+UF87jv50AatL25z93yB0kUPjHYDFO1WB0bJDqs3hI/gJI09fGyCLX7D7/zInsufuvE8FvBX7kb0XghykObddvgNBhIgByJY40T6dlEswmYyXUy+X0Sk4srv5JQc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=chL9Ufci; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707328764; x=1738864764;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WIt9o4OjjawnuBTk8GUkaHPSrfrC5St66G3/Ao7RYxg=;
  b=chL9UfciYEARhNzX3RpIWqvj6D4+Cnpcafj3AB/BPc3oxcDptRjjl6cu
   guPU1fd9LGA6Cl1RRETA9EmbOf8cXnPE0WvRPyIltZgTMmjcyIXsE9Fe1
   Jr+sT/aJStSvzJQkTtpsOIwktbE5Da2x4cbGthkhLRV+srKU0BpCfwuIq
   Q5eBOoTPKmqGUBoXN+IoOTtpRSN8KgiRnxrCVbHWfpsfewxtYxcs+TA8l
   plkWyXqB7o335G2i7E1kAImTYsjH0GwMp2HyNXx23bXIDT983fN6fPMN1
   lMv7yQ8OHis7KzyhuOgxUfauGSyD4kp7jNWyn/aMqgQS8M/dblou0BKOl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="11622692"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="11622692"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 09:59:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="6020771"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmviesa004.fm.intel.com with ESMTP; 07 Feb 2024 09:58:59 -0800
From: Xin Li <xin3.li@intel.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	corbet@lwn.net,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	shuah@kernel.org,
	vkuznets@redhat.com,
	peterz@infradead.org,
	ravi.v.shankar@intel.com,
	xin@zytor.com
Subject: [PATCH v2 24/25] KVM: selftests: Add a new VM guest mode to run user level code
Date: Wed,  7 Feb 2024 09:26:44 -0800
Message-ID: <20240207172646.3981-25-xin3.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207172646.3981-1-xin3.li@intel.com>
References: <20240207172646.3981-1-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 9e5afc472c14..ea1a585ef6f4 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -187,6 +187,7 @@ enum vm_guest_mode {
 	VM_MODE_P36V48_16K,
 	VM_MODE_P36V48_64K,
 	VM_MODE_P36V47_16K,
+	VM_MODE_PXXV48_4K_USER,	/* For 48bits VA but ANY bits PA with USER bit set */
 	NUM_VM_MODES,
 };
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index e066d584c656..8b4761836b3e 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -163,6 +163,7 @@ const char *vm_guest_mode_string(uint32_t i)
 		[VM_MODE_P36V48_16K]	= "PA-bits:36,  VA-bits:48, 16K pages",
 		[VM_MODE_P36V48_64K]	= "PA-bits:36,  VA-bits:48, 64K pages",
 		[VM_MODE_P36V47_16K]	= "PA-bits:36,  VA-bits:47, 16K pages",
+		[VM_MODE_PXXV48_4K_USER]	= "PA-bits:ANY, VA-bits:48,  4K user pages",
 	};
 	_Static_assert(sizeof(strings)/sizeof(char *) == NUM_VM_MODES,
 		       "Missing new mode strings?");
@@ -189,6 +190,7 @@ const struct vm_guest_mode_params vm_guest_mode_params[] = {
 	[VM_MODE_P36V48_16K]	= { 36, 48,  0x4000, 14 },
 	[VM_MODE_P36V48_64K]	= { 36, 48, 0x10000, 16 },
 	[VM_MODE_P36V47_16K]	= { 36, 47,  0x4000, 14 },
+	[VM_MODE_PXXV48_4K_USER]	= {  0,  0,  0x1000, 12 },
 };
 _Static_assert(sizeof(vm_guest_mode_params)/sizeof(struct vm_guest_mode_params) == NUM_VM_MODES,
 	       "Missing new mode params?");
@@ -263,6 +265,7 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
 		vm->pgtable_levels = 3;
 		break;
 	case VM_MODE_PXXV48_4K:
+	case VM_MODE_PXXV48_4K_USER:
 #ifdef __x86_64__
 		kvm_get_cpu_address_width(&vm->pa_bits, &vm->va_bits);
 		/*
@@ -278,7 +281,7 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
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
2.43.0


