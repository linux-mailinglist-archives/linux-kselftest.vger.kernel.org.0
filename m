Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97ACE5000D2
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Apr 2022 23:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239104AbiDMVNs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Apr 2022 17:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239001AbiDMVNF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Apr 2022 17:13:05 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D9D3BBD4;
        Wed, 13 Apr 2022 14:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649884243; x=1681420243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SIjeYNQYehkFATZl0iOzYFq+nO0jvY7dqq8z3tcfXBA=;
  b=ENjpTPRFGZ5429HTVW+UDY6KwL6XtulC2Z67Q5jBIIgJcjkgABCDY/Lf
   CnOI7YoUssJNpDxo7Z77N9+Oar9OWH1Td9S7aGQAgl/e4hT+OZaYazM53
   +GLpf1bSe2BiFv46+d1z7w8qXy5bVwbVTUYWjcCNXOdcDNwxJe7XD9B5H
   l6sJRrBxfCaGdjRjVNN7hxl+WcQ5vQ4l3zDhVmNmWRawJjP4M2/uJzgVf
   p6LGfyqWiK92QSDmtjaRXwb2qaDUd6NCDEmSij5wJdmNlI+/V9AOXI8N/
   VNswEBZpRk6TnTHTpcv2MIABbIlFGSoJ+MgK0tDlJ+2bka6crI9zagYIw
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="323219007"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="323219007"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:10:41 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="725054250"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:10:41 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, vijay.dhanraj@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 05/31] x86/sgx: Support loading enclave page without VMA permissions check
Date:   Wed, 13 Apr 2022 14:10:05 -0700
Message-Id: <db3a14f2d2df7678dec23375d48c96b603f8cfb5.1649878359.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1649878359.git.reinette.chatre@intel.com>
References: <cover.1649878359.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Changes since V3:
- Add Jarkko's Reviewed-by tag.

Changes since V2:
- New patch

 arch/x86/kernel/cpu/sgx/encl.c | 57 ++++++++++++++++++++++------------
 arch/x86/kernel/cpu/sgx/encl.h |  2 ++
 2 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 7c63a1911fae..05ae1168391c 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -131,25 +131,10 @@ static struct sgx_epc_page *sgx_encl_eldu(struct sgx_encl_page *encl_page,
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
@@ -175,6 +160,40 @@ static struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
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
@@ -196,7 +215,7 @@ static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
 
 	mutex_lock(&encl->lock);
 
-	entry = sgx_encl_load_page(encl, addr, vma->vm_flags);
+	entry = sgx_encl_load_page_in_vma(encl, addr, vma->vm_flags);
 	if (IS_ERR(entry)) {
 		mutex_unlock(&encl->lock);
 
@@ -344,7 +363,7 @@ static struct sgx_encl_page *sgx_encl_reserve_page(struct sgx_encl *encl,
 	for ( ; ; ) {
 		mutex_lock(&encl->lock);
 
-		entry = sgx_encl_load_page(encl, addr, vm_flags);
+		entry = sgx_encl_load_page_in_vma(encl, addr, vm_flags);
 		if (PTR_ERR(entry) != -EBUSY)
 			break;
 
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index fec43ca65065..6b34efba1602 100644
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

