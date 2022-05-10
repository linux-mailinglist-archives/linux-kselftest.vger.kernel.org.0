Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B674522369
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 20:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348621AbiEJSN2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 14:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348541AbiEJSNT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 14:13:19 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DC129C8B;
        Tue, 10 May 2022 11:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652206161; x=1683742161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B0KUtzhdPV9j7URFLi7gBgZGctuhFZQXMtJCJ0bOjjc=;
  b=i+k5NK5pH5UNGfahK/5i+uclAh60LR1nXQWrjebpTtXsrqF+RvtJOrLe
   6KzcIRzYZUXiWWLR+06Trw3yKcABpuspQFNgUR7Ab2M8TJOfb3vl8Zh5h
   yHY7JHMpwYCpWTG19+VdzC8ip95XP1NeBhh7u9cGWslvZu+VECE6YmOk5
   FLbdoy3HHzTSQEU28JNdKinI0cPqrqhAOm4MZgYCiGFREBE/K+eulNbdK
   ZGw5qtEs+B5VYTjnV8aqqG8t7BVLhTmN8zAOzWZ30bjLoiSFwdAoMlOnS
   VA743NMYSarAv00GqGCrqn3/G33lv5mO9SO0GEXyrTCeyBQWWH2YamHxn
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="330057507"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="330057507"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 11:09:16 -0700
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="541908754"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 11:09:16 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, vijay.dhanraj@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 05/31] x86/sgx: Support loading enclave page without VMA permissions check
Date:   Tue, 10 May 2022 11:08:41 -0700
Message-Id: <d4393513c1f18987c14a490bcf133bfb71a5dc43.1652137848.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1652137848.git.reinette.chatre@intel.com>
References: <cover.1652137848.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

sgx_encl_load_page() is used to find and load an enclave page into
enclave (EPC) memory, potentially loading it from the backing storage.
Both usages of sgx_encl_load_page() are during an access to the
enclave page from a VMA and thus the permissions of the VMA are
considered before the enclave page is loaded.

SGX2 functions operating on enclave pages belonging to an initialized
enclave requiring the page to be in EPC. It is thus required to
support loading enclave pages into the EPC independent from a VMA.

Split the current sgx_encl_load_page() to support the two usages:
A new call, sgx_encl_load_page_in_vma(), behaves exactly like the
current sgx_encl_load_page() that takes VMA permissions into account,
while sgx_encl_load_page() just loads an enclave page into EPC.

VMA, PTE, and EPCM permissions continue to dictate whether
the pages can be accessed from within an enclave.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
No changes since V4.

Changes since V3:
- Add Jarkko's Reviewed-by tag.

Changes since V2:
- New patch

 arch/x86/kernel/cpu/sgx/encl.c | 57 ++++++++++++++++++++++------------
 arch/x86/kernel/cpu/sgx/encl.h |  2 ++
 2 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index af972dbad965..7217c492e103 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -227,25 +227,10 @@ static struct sgx_epc_page *sgx_encl_eldu(struct sgx_encl_page *encl_page,
 	return epc_page;
 }
 
-static struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
-						unsigned long addr,
-						unsigned long vm_flags)
+static struct sgx_encl_page *__sgx_encl_load_page(struct sgx_encl *encl,
+						  struct sgx_encl_page *entry)
 {
-	unsigned long vm_prot_bits = vm_flags & (VM_READ | VM_WRITE | VM_EXEC);
 	struct sgx_epc_page *epc_page;
-	struct sgx_encl_page *entry;
-
-	entry = xa_load(&encl->page_array, PFN_DOWN(addr));
-	if (!entry)
-		return ERR_PTR(-EFAULT);
-
-	/*
-	 * Verify that the faulted page has equal or higher build time
-	 * permissions than the VMA permissions (i.e. the subset of {VM_READ,
-	 * VM_WRITE, VM_EXECUTE} in vma->vm_flags).
-	 */
-	if ((entry->vm_max_prot_bits & vm_prot_bits) != vm_prot_bits)
-		return ERR_PTR(-EFAULT);
 
 	/* Entry successfully located. */
 	if (entry->epc_page) {
@@ -271,6 +256,40 @@ static struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
 	return entry;
 }
 
+static struct sgx_encl_page *sgx_encl_load_page_in_vma(struct sgx_encl *encl,
+						       unsigned long addr,
+						       unsigned long vm_flags)
+{
+	unsigned long vm_prot_bits = vm_flags & (VM_READ | VM_WRITE | VM_EXEC);
+	struct sgx_encl_page *entry;
+
+	entry = xa_load(&encl->page_array, PFN_DOWN(addr));
+	if (!entry)
+		return ERR_PTR(-EFAULT);
+
+	/*
+	 * Verify that the page has equal or higher build time
+	 * permissions than the VMA permissions (i.e. the subset of {VM_READ,
+	 * VM_WRITE, VM_EXECUTE} in vma->vm_flags).
+	 */
+	if ((entry->vm_max_prot_bits & vm_prot_bits) != vm_prot_bits)
+		return ERR_PTR(-EFAULT);
+
+	return __sgx_encl_load_page(encl, entry);
+}
+
+struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
+					 unsigned long addr)
+{
+	struct sgx_encl_page *entry;
+
+	entry = xa_load(&encl->page_array, PFN_DOWN(addr));
+	if (!entry)
+		return ERR_PTR(-EFAULT);
+
+	return __sgx_encl_load_page(encl, entry);
+}
+
 static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
 {
 	unsigned long addr = (unsigned long)vmf->address;
@@ -292,7 +311,7 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
 
 	mutex_lock(&encl->lock);
 
-	entry = sgx_encl_load_page(encl, addr, vma->vm_flags);
+	entry = sgx_encl_load_page_in_vma(encl, addr, vma->vm_flags);
 	if (IS_ERR(entry)) {
 		mutex_unlock(&encl->lock);
 
@@ -440,7 +459,7 @@ static struct sgx_encl_page *sgx_encl_reserve_page(struct sgx_encl *encl,
 	for ( ; ; ) {
 		mutex_lock(&encl->lock);
 
-		entry = sgx_encl_load_page(encl, addr, vm_flags);
+		entry = sgx_encl_load_page_in_vma(encl, addr, vm_flags);
 		if (PTR_ERR(entry) != -EBUSY)
 			break;
 
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index d44e7372151f..522a17e4fd2d 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -116,5 +116,7 @@ unsigned int sgx_alloc_va_slot(struct sgx_va_page *va_page);
 void sgx_free_va_slot(struct sgx_va_page *va_page, unsigned int offset);
 bool sgx_va_page_full(struct sgx_va_page *va_page);
 void sgx_encl_free_epc_page(struct sgx_epc_page *page);
+struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
+					 unsigned long addr);
 
 #endif /* _X86_ENCL_H */
-- 
2.25.1

