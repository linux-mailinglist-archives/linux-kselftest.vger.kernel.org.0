Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341367DF7BB
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Nov 2023 17:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347530AbjKBQeC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Nov 2023 12:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347613AbjKBQeB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Nov 2023 12:34:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4323112D;
        Thu,  2 Nov 2023 09:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698942836; x=1730478836;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=GNhPW88MPkib21AmFUv5fnJN41E4w62qwPpqIsA6MqA=;
  b=EsmSVOSoDB5EgNt+BATFkiFm5WztaGU14qzrvpJD6VrBgRQYRUNZybiU
   8wjthNK9E0ecvAZPf/fEt53Gql6itAkhy4xLSRSPdlSDEdiOebQZ2Wmp1
   Le88PJ/IgwAF8oUFLn2rH3vbbLQQI6OmjGfWePL3VoIUmHbLBuser4x0b
   rjYYBkKtCAzSTca+k2fj24AWukKCVKTmNUK2IP9pKVVfu41/1Ls6QAUio
   KTb+E1HwSR4fSoIznwUNb8gm2GoaBui+pnLotATtkzZueWum+AsjCzIPz
   ri9V5qrSr3G+/5ajYpeJwssqcjGgdhhvmpUvqLxsyp1WwxxmgK+I6xNHV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="388571041"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="388571041"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 09:33:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="9448518"
Received: from arthur-vostro-3668.sh.intel.com ([10.239.159.65])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 09:33:27 -0700
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
Subject: [RFC PATCH v1 6/8] KVM: selftests: x86: Allow user to access user-mode address and I/O address space
Date:   Thu,  2 Nov 2023 23:51:09 +0800
Message-Id: <20231102155111.28821-7-guang.zeng@intel.com>
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

Configure the U/S bit in paging-structure entries according to operation
mode and delimit user has user-mode access only to user-mode address
space.

Similarly set I/O privilege level as ring 3 in EFLAGS register to allow
user to access the I/O address space.

Signed-off-by: Zeng Guang <guang.zeng@intel.com>
---
 .../selftests/kvm/include/x86_64/processor.h   |  3 ++-
 .../selftests/kvm/lib/x86_64/processor.c       | 18 +++++++++++++++---
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 4b167e3e0370..9c8224c80664 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -24,7 +24,8 @@ extern bool host_cpu_is_amd;
 
 #define NMI_VECTOR		0x02
 
-#define X86_EFLAGS_FIXED	 (1u << 1)
+#define X86_EFLAGS_FIXED	(1u << 1)
+#define X86_EFLAGS_IOPL		(3u << 12)
 
 #define X86_CR4_VME		(1ul << 0)
 #define X86_CR4_PVI		(1ul << 1)
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 487e1f829031..7647c3755ca2 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -117,6 +117,14 @@ static void sregs_dump(FILE *stream, struct kvm_sregs *sregs, uint8_t indent)
 	}
 }
 
+static bool gva_is_kernel_addr(uint64_t gva)
+{
+	if (gva & BIT_ULL(63))
+		return true;
+
+	return false;
+}
+
 bool kvm_is_tdp_enabled(void)
 {
 	if (host_cpu_is_intel)
@@ -161,7 +169,8 @@ static uint64_t *virt_create_upper_pte(struct kvm_vm *vm,
 	uint64_t *pte = virt_get_pte(vm, parent_pte, vaddr, current_level);
 
 	if (!(*pte & PTE_PRESENT_MASK)) {
-		*pte = PTE_PRESENT_MASK | PTE_WRITABLE_MASK;
+		*pte = PTE_PRESENT_MASK | PTE_WRITABLE_MASK |
+		       (gva_is_kernel_addr(vaddr) ? 0 : PTE_USER_MASK);
 		if (current_level == target_level)
 			*pte |= PTE_LARGE_MASK | (paddr & PHYSICAL_PAGE_MASK);
 		else
@@ -224,7 +233,8 @@ void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr, int level)
 	pte = virt_get_pte(vm, pde, vaddr, PG_LEVEL_4K);
 	TEST_ASSERT(!(*pte & PTE_PRESENT_MASK),
 		    "PTE already present for 4k page at vaddr: 0x%lx\n", vaddr);
-	*pte = PTE_PRESENT_MASK | PTE_WRITABLE_MASK | (paddr & PHYSICAL_PAGE_MASK);
+	*pte = PTE_PRESENT_MASK | PTE_WRITABLE_MASK | (paddr & PHYSICAL_PAGE_MASK) |
+	       (gva_is_kernel_addr(vaddr) ? 0 : PTE_USER_MASK);
 }
 
 void virt_arch_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr)
@@ -630,7 +640,9 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
 
 	/* Setup guest general purpose registers */
 	vcpu_regs_get(vcpu, &regs);
-	regs.rflags = regs.rflags | 0x2;
+
+	/* Allow user privilege to access the I/O address space */
+	regs.rflags = regs.rflags | X86_EFLAGS_FIXED | X86_EFLAGS_IOPL;
 	regs.rsp = (unsigned long)KERNEL_ADDR(stack_vaddr);
 	regs.rip = (unsigned long)KERNEL_ADDR(guest_code);
 	vcpu_regs_set(vcpu, &regs);
-- 
2.21.3

