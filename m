Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2745A70FB
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 00:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiH3Wnp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 18:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbiH3Wni (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 18:43:38 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D3D80F5C
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:43:28 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id a19-20020aa780d3000000b0052bccd363f8so5177937pfn.22
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=FxpX7DoPE3GMtBbFVyScvJLAhxo3IL8fu/3CfhEaMzM=;
        b=erWtdHITEzoRn+OGEzvo+IuiSJLt5Me15nfx9IkgRhJht9nbPSXu7kj81eibvCHxOT
         8M3ZqpSXqa4NaBg7NigHUZSvPcXHBoADeRVYKq4WEO/UNmBJRFNXVdSTO4ue0ZRuQtaD
         JiAZANlRx8tKA5Ye5zGOIcUn4Q5VLY2za0WwBB/xhwaQ+jJVvnOkIWTivOC3U5prOyh/
         WGPWTkMRkz22EMo1pSMVLroa6Xnfr0I1IfJczL6Prk3f7lk9vDClqGKzUoKFMGqjwEqC
         66QWJbO+YFFfMWVaqpjedTSIejKgWpjppNYV5cP4JqFCSkjB+30XQ+ZVcmXp2EVOkuOr
         gWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=FxpX7DoPE3GMtBbFVyScvJLAhxo3IL8fu/3CfhEaMzM=;
        b=7BlWEqGhKMFV82Xc9GP4FVJT1lviCOLx4UOYPjfI1BD8YCGeLHprM8lvB253OU20t9
         v4hXSUXCiSXlJiCmxz7mwlkXtL7ZVRjrKaZSJiTaNdhvXzTYS1xKRLw7SlQQdY6Lk8Rq
         F+7JhQDaVjEzGLkftVtZfjw2MHo76fy/ugY97XTuOD+oV2NbsOF9pySZUIGP83OXdNar
         415o+YMxp8pSIphQO37RpA4FSUxsqbqt02mbTBDqMrFWfIrNRKLRCR6MIo46OWY/LMpB
         9BFKI+W7av+0w9bvAfUdE5rXzqkhGOySbZulpHAaeNWseR4n5dO4tcYtDzwBdWY0k5kI
         2RYA==
X-Gm-Message-State: ACgBeo3qfZh3952lL+aZGApA+IZZEMWI8hhqEWdKWWWCFikIe7aVpotc
        fjdzjAw/RxgjL41DDiZ2xnPvH6ih7SNzFtR8
X-Google-Smtp-Source: AA6agR4B1IUI8+BUs70F/elePrZ2UGxVCcCeqHEWdmOOw5t10UrnaK5juPiTyW2FEuX0yLwZlQ/8qutIu2KwxlQ1
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with SMTP
 id t9-20020a17090a024900b001e0a8a33c6cmr5346pje.0.1661899406644; Tue, 30 Aug
 2022 15:43:26 -0700 (PDT)
Date:   Tue, 30 Aug 2022 22:42:56 +0000
In-Reply-To: <20220830224259.412342-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20220830224259.412342-1-vannapurve@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220830224259.412342-6-vannapurve@google.com>
Subject: [RFC V2 PATCH 5/8] selftests: kvm: Update usage of private mem lib
 for SEV VMs
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, yang.zhong@intel.com,
        drjones@redhat.com, ricarkol@google.com, aaronlewis@google.com,
        wei.w.wang@intel.com, kirill.shutemov@linux.intel.com,
        corbet@lwn.net, hughd@google.com, jlayton@kernel.org,
        bfields@fieldses.org, akpm@linux-foundation.org,
        chao.p.peng@linux.intel.com, yu.c.zhang@linux.intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com,
        michael.roth@amd.com, qperret@google.com, steven.price@arm.com,
        ak@linux.intel.com, david@redhat.com, luto@kernel.org,
        vbabka@suse.cz, marcorr@google.com, erdemaktas@google.com,
        pgonda@google.com, nikunj@amd.com, seanjc@google.com,
        diviness@google.com, maz@kernel.org, dmatlack@google.com,
        axelrasmussen@google.com, maciej.szmigiero@oracle.com,
        mizhang@google.com, bgardon@google.com,
        Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add/update APIs to allow reusing private mem lib for SEV VMs.
Memory conversion for SEV VMs includes updating guest pagetables
based on virtual addresses to toggle C-bit.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 .../kvm/include/x86_64/private_mem.h          |   9 +-
 .../selftests/kvm/lib/x86_64/private_mem.c    | 103 +++++++++++++-----
 2 files changed, 83 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/private_mem.h b/tools/testing/selftests/kvm/include/x86_64/private_mem.h
index 645bf3f61d1e..183b53b8c486 100644
--- a/tools/testing/selftests/kvm/include/x86_64/private_mem.h
+++ b/tools/testing/selftests/kvm/include/x86_64/private_mem.h
@@ -14,10 +14,10 @@ enum mem_conversion_type {
 	TO_SHARED
 };
 
-void guest_update_mem_access(enum mem_conversion_type type, uint64_t gpa,
-	uint64_t size);
-void guest_update_mem_map(enum mem_conversion_type type, uint64_t gpa,
-	uint64_t size);
+void guest_update_mem_access(enum mem_conversion_type type, uint64_t gva,
+	uint64_t gpa, uint64_t size);
+void guest_update_mem_map(enum mem_conversion_type type, uint64_t gva,
+	uint64_t gpa, uint64_t size);
 
 void guest_map_ucall_page_shared(void);
 
@@ -45,6 +45,7 @@ struct vm_setup_info {
 	struct test_setup_info test_info;
 	guest_code_fn guest_fn;
 	io_exit_handler ioexit_cb;
+	uint32_t policy; /* Used for Sev VMs */
 };
 
 void execute_vm_with_private_mem(struct vm_setup_info *info);
diff --git a/tools/testing/selftests/kvm/lib/x86_64/private_mem.c b/tools/testing/selftests/kvm/lib/x86_64/private_mem.c
index f6dcfa4d353f..28d93754e1f2 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/private_mem.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/private_mem.c
@@ -22,12 +22,45 @@
 #include <kvm_util.h>
 #include <private_mem.h>
 #include <processor.h>
+#include <sev.h>
+
+#define GUEST_PGT_MIN_VADDR	0x10000
+
+/* Variables populated by userspace logic and consumed by guest code */
+static bool is_sev_vm;
+static struct guest_pgt_info *sev_gpgt_info;
+static uint8_t sev_enc_bit;
+
+static void sev_guest_set_clr_pte_bit(uint64_t vaddr_start, uint64_t mem_size,
+	bool set)
+{
+	uint64_t vaddr = vaddr_start;
+	uint32_t guest_page_size = sev_gpgt_info->page_size;
+	uint32_t num_pages;
+
+	GUEST_ASSERT(!(mem_size % guest_page_size) && !(vaddr_start %
+		guest_page_size));
+
+	num_pages = mem_size / guest_page_size;
+	for (uint32_t i = 0; i < num_pages; i++) {
+		uint64_t *pte = guest_code_get_pte(sev_gpgt_info, vaddr);
+
+		GUEST_ASSERT(pte);
+		if (set)
+			*pte |= (1ULL << sev_enc_bit);
+		else
+			*pte &= ~(1ULL << sev_enc_bit);
+		asm volatile("invlpg (%0)" :: "r"(vaddr) : "memory");
+		vaddr += guest_page_size;
+	}
+}
 
 /*
  * Execute KVM hypercall to change memory access type for a given gpa range.
  *
  * Input Args:
  *   type - memory conversion type TO_SHARED/TO_PRIVATE
+ *   gva - starting gva address
  *   gpa - starting gpa address
  *   size - size of the range starting from gpa for which memory access needs
  *     to be changed
@@ -40,9 +73,12 @@
  * for a given gpa range. This API is useful in exercising implicit conversion
  * path.
  */
-void guest_update_mem_access(enum mem_conversion_type type, uint64_t gpa,
-	uint64_t size)
+void guest_update_mem_access(enum mem_conversion_type type, uint64_t gva,
+	uint64_t gpa, uint64_t size)
 {
+	if (is_sev_vm)
+		sev_guest_set_clr_pte_bit(gva, size, type == TO_PRIVATE ? true : false);
+
 	int ret = kvm_hypercall(KVM_HC_MAP_GPA_RANGE, gpa, size >> MIN_PAGE_SHIFT,
 		type == TO_PRIVATE ? KVM_MARK_GPA_RANGE_ENC_ACCESS :
 			KVM_CLR_GPA_RANGE_ENC_ACCESS, 0);
@@ -54,6 +90,7 @@ void guest_update_mem_access(enum mem_conversion_type type, uint64_t gpa,
  *
  * Input Args:
  *   type - memory conversion type TO_SHARED/TO_PRIVATE
+ *   gva - starting gva address
  *   gpa - starting gpa address
  *   size - size of the range starting from gpa for which memory type needs
  *     to be changed
@@ -65,9 +102,12 @@ void guest_update_mem_access(enum mem_conversion_type type, uint64_t gpa,
  * Function called by guest logic in selftests to update the memory type for a
  * given gpa range. This API is useful in exercising explicit conversion path.
  */
-void guest_update_mem_map(enum mem_conversion_type type, uint64_t gpa,
-	uint64_t size)
+void guest_update_mem_map(enum mem_conversion_type type, uint64_t gva,
+	uint64_t gpa, uint64_t size)
 {
+	if (is_sev_vm)
+		sev_guest_set_clr_pte_bit(gva, size, type == TO_PRIVATE ? true : false);
+
 	int ret = kvm_hypercall(KVM_HC_MAP_GPA_RANGE, gpa, size >> MIN_PAGE_SHIFT,
 		type == TO_PRIVATE ? KVM_MAP_GPA_RANGE_ENCRYPTED :
 			KVM_MAP_GPA_RANGE_DECRYPTED, 0);
@@ -90,30 +130,15 @@ void guest_update_mem_map(enum mem_conversion_type type, uint64_t gpa,
 void guest_map_ucall_page_shared(void)
 {
 	vm_paddr_t ucall_paddr = get_ucall_pool_paddr();
+	GUEST_ASSERT(ucall_paddr);
 
-	guest_update_mem_access(TO_SHARED, ucall_paddr, 1 << MIN_PAGE_SHIFT);
+	int ret = kvm_hypercall(KVM_HC_MAP_GPA_RANGE, ucall_paddr, 1,
+		KVM_MAP_GPA_RANGE_DECRYPTED, 0);
+	GUEST_ASSERT_1(!ret, ret);
 }
 
-/*
- * Execute KVM ioctl to back/unback private memory for given gpa range.
- *
- * Input Args:
- *   vm - kvm_vm handle
- *   gpa - starting gpa address
- *   size - size of the gpa range
- *   op - mem_op indicating whether private memory needs to be allocated or
- *     unbacked
- *
- * Output Args: None
- *
- * Return: None
- *
- * Function called by host userspace logic in selftests to back/unback private
- * memory for gpa ranges. This function is useful to setup initial boot private
- * memory and then convert memory during runtime.
- */
-void vm_update_private_mem(struct kvm_vm *vm, uint64_t gpa, uint64_t size,
-	enum mem_op op)
+static void vm_update_private_mem_internal(struct kvm_vm *vm, uint64_t gpa,
+	uint64_t size, enum mem_op op, bool encrypt)
 {
 	int priv_memfd;
 	uint64_t priv_offset, guest_phys_base, fd_offset;
@@ -142,6 +167,10 @@ void vm_update_private_mem(struct kvm_vm *vm, uint64_t gpa, uint64_t size,
 	TEST_ASSERT(ret == 0, "fallocate failed\n");
 	enc_region.addr = gpa;
 	enc_region.size = size;
+
+	if (!encrypt)
+		return;
+
 	if (op == ALLOCATE_MEM) {
 		printf("doing encryption for gpa 0x%lx size 0x%lx\n", gpa, size);
 		vm_ioctl(vm, KVM_MEMORY_ENCRYPT_REG_REGION, &enc_region);
@@ -151,6 +180,30 @@ void vm_update_private_mem(struct kvm_vm *vm, uint64_t gpa, uint64_t size,
 	}
 }
 
+/*
+ * Execute KVM ioctl to back/unback private memory for given gpa range.
+ *
+ * Input Args:
+ *   vm - kvm_vm handle
+ *   gpa - starting gpa address
+ *   size - size of the gpa range
+ *   op - mem_op indicating whether private memory needs to be allocated or
+ *     unbacked
+ *
+ * Output Args: None
+ *
+ * Return: None
+ *
+ * Function called by host userspace logic in selftests to back/unback private
+ * memory for gpa ranges. This function is useful to setup initial boot private
+ * memory and then convert memory during runtime.
+ */
+void vm_update_private_mem(struct kvm_vm *vm, uint64_t gpa, uint64_t size,
+	enum mem_op op)
+{
+	vm_update_private_mem_internal(vm, gpa, size, op, true /* encrypt */);
+}
+
 static void handle_vm_exit_map_gpa_hypercall(struct kvm_vm *vm,
 				volatile struct kvm_run *run)
 {
-- 
2.37.2.672.g94769d06f0-goog

