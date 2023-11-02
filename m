Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281337DF7B8
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Nov 2023 17:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376921AbjKBQdc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Nov 2023 12:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376952AbjKBQdb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Nov 2023 12:33:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E6213A;
        Thu,  2 Nov 2023 09:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698942808; x=1730478808;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=WxHy+lyqLdvpJ5ob22qLT8DuRUFaYkwxGfUFQQncCmI=;
  b=R0TWpNISgYoTfhV9Wgl5YAyUAwfEOykKVhoBJiUc4V2mX/ANavjPw3jP
   OUvCISwqqtTQ1WIw0PR2PuOeRE51qM2ip7CgC1Qz02WYk8pQgpwyPEkTk
   BMkVcEIXwFzcG+d5rwBBfZ4eOvJ4CbYEkmiT0m6dEWNmCR2Fz6l0vA3a7
   wMNcGYa1CDroebj7DvIubZVNO2DeTZrZywhQQrMWZJMuKWvYfFWbBm8I6
   Il+ntINBFyrSxcT/c/p60zl6mb2vEnN7wc3xcCClCPj9LW1VosgSuic6N
   /Wd4xV4EIhldOmvuczYpKrx6Xny08hf4TGTYi3FJitRclgu0mtwsRoRlT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="388570992"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="388570992"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 09:33:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="9448507"
Received: from arthur-vostro-3668.sh.intel.com ([10.239.159.65])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 09:33:23 -0700
From:   Zeng Guang <guang.zeng@intel.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        David Hildenbrand <david@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, Zeng Guang <guang.zeng@intel.com>
Subject: [RFC PATCH v1 5/8] KVM: selftests: x86: Prepare setup for user mode support
Date:   Thu,  2 Nov 2023 23:51:08 +0800
Message-Id: <20231102155111.28821-6-guang.zeng@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231102155111.28821-1-guang.zeng@intel.com>
References: <20231102155111.28821-1-guang.zeng@intel.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Extend the page size of stack memory that can be shared for user mode.
And configure the canonical linear address of the stack point(RSP0) for
privilege level 0 in TSS segment which processor will use to switch task,
e.g. from user mode back to supervisor mode triggered by interrupt.

Refactor KVM segment set API to support user mode setup.

No functional change intended.

Signed-off-by: Zeng Guang <guang.zeng@intel.com>
---
 .../selftests/kvm/include/kvm_util_base.h     |  3 +-
 .../selftests/kvm/include/x86_64/processor.h  | 18 +++++++++
 .../selftests/kvm/lib/x86_64/processor.c      | 37 +++++++++++++------
 3 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index dbaa2cf83c1c..6f580bc519f4 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -71,6 +71,7 @@ struct kvm_vcpu {
 	struct kvm_dirty_gfn *dirty_gfns;
 	uint32_t fetch_index;
 	uint32_t dirty_gfns_count;
+	uint64_t stack_vaddr;
 };
 
 struct userspace_mem_regions {
@@ -167,7 +168,7 @@ static inline struct userspace_mem_region *vm_get_mem_region(struct kvm_vm *vm,
 #define KVM_GUEST_PAGE_TABLE_MIN_PADDR	0x180000
 
 #define DEFAULT_GUEST_STACK_VADDR_MIN	0xab6000
-#define DEFAULT_STACK_PGS		5
+#define DEFAULT_STACK_PGS		10
 
 enum vm_guest_mode {
 	VM_MODE_P52V48_4K,
diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 00f7337a520a..4b167e3e0370 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -1072,6 +1072,24 @@ struct ex_regs {
 	uint64_t rflags;
 };
 
+struct tss64_t {
+	uint32_t res1;
+	uint64_t rsp0;
+	uint64_t rsp1;
+	uint64_t rsp2;
+	uint64_t res2;
+	uint64_t ist1;
+	uint64_t ist2;
+	uint64_t ist3;
+	uint64_t ist4;
+	uint64_t ist5;
+	uint64_t ist6;
+	uint64_t ist7;
+	uint64_t res3;
+	uint16_t res4;
+	uint16_t iomap_base;
+} __attribute__((packed));
+
 struct idt_entry {
 	uint16_t offset0;
 	uint16_t selector;
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 525b714ee13c..487e1f829031 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -16,6 +16,9 @@
 
 #define DEFAULT_CODE_SELECTOR 0x8
 #define DEFAULT_DATA_SELECTOR 0x10
+#define DEFAULT_TSS_SELECTOR 0x18
+#define USER_CODE_SELECTOR 0x23
+#define USER_DATA_SELECTOR 0x2B
 
 #define MAX_NR_CPUID_ENTRIES 100
 
@@ -442,7 +445,7 @@ static void kvm_seg_fill_gdt_64bit(struct kvm_vm *vm, struct kvm_segment *segp)
 
 
 /*
- * Set Long Mode Flat Kernel Code Segment
+ * Set Long Mode Flat Code Segment
  *
  * Input Args:
  *   vm - VM whose GDT is being filled, or NULL to only write segp
@@ -454,14 +457,16 @@ static void kvm_seg_fill_gdt_64bit(struct kvm_vm *vm, struct kvm_segment *segp)
  * Return: None
  *
  * Sets up the KVM segment pointed to by @segp, to be a code segment
- * with the selector value given by @selector.
+ * with the selector value given by @selector. The @selector.dpl
+ * decides the descriptor privilege level, user or kernel.
  */
-static void kvm_seg_set_kernel_code_64bit(struct kvm_vm *vm, uint16_t selector,
+static void kvm_seg_set_code_64bit(struct kvm_vm *vm, uint16_t selector,
 	struct kvm_segment *segp)
 {
 	memset(segp, 0, sizeof(*segp));
 	segp->selector = selector;
 	segp->limit = 0xFFFFFFFFu;
+	segp->dpl = selector & 0x3;
 	segp->s = 0x1; /* kTypeCodeData */
 	segp->type = 0x08 | 0x01 | 0x02; /* kFlagCode | kFlagCodeAccessed
 					  * | kFlagCodeReadable
@@ -474,7 +479,7 @@ static void kvm_seg_set_kernel_code_64bit(struct kvm_vm *vm, uint16_t selector,
 }
 
 /*
- * Set Long Mode Flat Kernel Data Segment
+ * Set Long Mode Flat Data Segment
  *
  * Input Args:
  *   vm - VM whose GDT is being filled, or NULL to only write segp
@@ -486,14 +491,16 @@ static void kvm_seg_set_kernel_code_64bit(struct kvm_vm *vm, uint16_t selector,
  * Return: None
  *
  * Sets up the KVM segment pointed to by @segp, to be a data segment
- * with the selector value given by @selector.
+ * with the selector value given by @selector. The @selector.dpl
+ * decides the descriptor privilege level, user or kernel.
  */
-static void kvm_seg_set_kernel_data_64bit(struct kvm_vm *vm, uint16_t selector,
+static void kvm_seg_set_data_64bit(struct kvm_vm *vm, uint16_t selector,
 	struct kvm_segment *segp)
 {
 	memset(segp, 0, sizeof(*segp));
 	segp->selector = selector;
 	segp->limit = 0xFFFFFFFFu;
+	segp->dpl = selector & 0x3;
 	segp->s = 0x1; /* kTypeCodeData */
 	segp->type = 0x00 | 0x01 | 0x02; /* kFlagData | kFlagDataAccessed
 					  * | kFlagDataWritable
@@ -561,10 +568,10 @@ static void vcpu_setup(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 		sregs.efer |= (EFER_LME | EFER_LMA | EFER_NX);
 
 		kvm_seg_set_unusable(&sregs.ldt);
-		kvm_seg_set_kernel_code_64bit(vm, DEFAULT_CODE_SELECTOR, &sregs.cs);
-		kvm_seg_set_kernel_data_64bit(vm, DEFAULT_DATA_SELECTOR, &sregs.ds);
-		kvm_seg_set_kernel_data_64bit(vm, DEFAULT_DATA_SELECTOR, &sregs.es);
-		kvm_setup_tss_64bit(vm, &sregs.tr, 0x18);
+		kvm_seg_set_code_64bit(vm, DEFAULT_CODE_SELECTOR, &sregs.cs);
+		kvm_seg_set_data_64bit(vm, DEFAULT_DATA_SELECTOR, &sregs.ds);
+		kvm_seg_set_data_64bit(vm, DEFAULT_DATA_SELECTOR, &sregs.es);
+		kvm_setup_tss_64bit(vm, &sregs.tr, DEFAULT_TSS_SELECTOR);
 		break;
 
 	default:
@@ -589,6 +596,7 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
 	struct kvm_regs regs;
 	vm_vaddr_t stack_vaddr;
 	struct kvm_vcpu *vcpu;
+	struct tss64_t *tss_hva;
 
 	stack_vaddr = __vm_vaddr_alloc(vm, DEFAULT_STACK_PGS * getpagesize(),
 				       DEFAULT_GUEST_STACK_VADDR_MIN,
@@ -613,6 +621,13 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
 	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
 	vcpu_setup(vm, vcpu);
 
+	/* Save address of stack pool used for vCPU */
+	vcpu->stack_vaddr = stack_vaddr;
+
+	/* Setup canonical linear address form of the RSP0 for task switch */
+	tss_hva = (struct tss64_t *)addr_gva2hva(vm, vm->tss);
+	tss_hva->rsp0 = (uint64_t)KERNEL_ADDR(stack_vaddr);
+
 	/* Setup guest general purpose registers */
 	vcpu_regs_get(vcpu, &regs);
 	regs.rflags = regs.rflags | 0x2;
@@ -1137,7 +1152,7 @@ void vcpu_init_descriptor_tables(struct kvm_vcpu *vcpu)
 	sregs.idt.limit = NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
 	sregs.gdt.base = (unsigned long)KERNEL_ADDR(vm->gdt);
 	sregs.gdt.limit = getpagesize() - 1;
-	kvm_seg_set_kernel_data_64bit(NULL, DEFAULT_DATA_SELECTOR, &sregs.gs);
+	kvm_seg_set_data_64bit(NULL, DEFAULT_DATA_SELECTOR, &sregs.gs);
 	vcpu_sregs_set(vcpu, &sregs);
 	*(vm_vaddr_t *)addr_gva2hva(vm, (vm_vaddr_t)(&exception_handlers)) = (vm_vaddr_t)KERNEL_ADDR(vm->handlers);
 }
-- 
2.21.3

