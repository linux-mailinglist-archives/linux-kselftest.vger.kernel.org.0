Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7841F522366
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 20:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348575AbiEJSNY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 14:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348548AbiEJSNV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 14:13:21 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEFA2DD5C;
        Tue, 10 May 2022 11:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652206162; x=1683742162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3U0ety0c3pty5CBcCJ42xQXH0MFyBG0NG5jrlLA3NKc=;
  b=UZjCs9gn6UG9PXLQ69XlMYPkiNy6hCIIrPvg3CFnDDK+4XzOqfRSAxM7
   MJJvJMQzPoamElgfpPe114djbuVYH1EjRKf06joZHxKToNoEQvTQCMOT4
   C3S1K9rO9r8eBBePZaqiw9D8MVMTLMWXtf/CigIzEsjq8vEWQERgBojtl
   7xXkJ8Ssm+RUh/2FH1vnLXHb3rThfJdEp4cK1vMF1sQOj8IwFSdUFXuk4
   Vvc8Sor+fUPKcstU124vJ3t/EdRDTLe3+N9OgKykQOin8D1JXPnVvT6iR
   822GS4hRSj9QigVPgSx37hyxWM0A1L0/3EnxlQfccVdkDgYlLsVQlVXqf
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="330057513"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="330057513"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 11:09:16 -0700
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="541908766"
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
Subject: [PATCH V5 08/31] x86/sgx: Move PTE zap code to new sgx_zap_enclave_ptes()
Date:   Tue, 10 May 2022 11:08:44 -0700
Message-Id: <b010cdf01d7ce55dd0f00e883b7ccbd9db57160a.1652137848.git.reinette.chatre@intel.com>
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

The SGX reclaimer removes page table entries pointing to pages that are
moved to swap.

SGX2 enables changes to pages belonging to an initialized enclave, thus
enclave pages may have their permission or type changed while the page
is being accessed by an enclave. Supporting SGX2 requires page table
entries to be removed so that any cached mappings to changed pages
are removed. For example, with the ability to change enclave page types
a regular enclave page may be changed to a Thread Control Structure
(TCS) page that may not be accessed by an enclave.

Factor out the code removing page table entries to a separate function
sgx_zap_enclave_ptes(), fixing accuracy of comments in the process,
and make it available to the upcoming SGX2 code.

Place sgx_zap_enclave_ptes() with the rest of the enclave code in
encl.c interacting with the page table since this code is no longer
unique to the reclaimer.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
No changes since V4.

Changes since V3:
- Add Jarkko's Reviewed-by tag.

Changes since V1:
- Elaborate why SGX2 needs this ability (Jarkko).
- More specific subject.
- Fix kernel-doc to have brackets in function name.

 arch/x86/kernel/cpu/sgx/encl.c | 45 +++++++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/encl.h |  2 +-
 arch/x86/kernel/cpu/sgx/main.c | 31 ++---------------------
 3 files changed, 47 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 1bbd76d91554..91df05c6568f 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -701,7 +701,7 @@ int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm)
 
 	spin_lock(&encl->mm_lock);
 	list_add_rcu(&encl_mm->list, &encl->mm_list);
-	/* Pairs with smp_rmb() in sgx_reclaimer_block(). */
+	/* Pairs with smp_rmb() in sgx_zap_enclave_ptes(). */
 	smp_wmb();
 	encl->mm_list_version++;
 	spin_unlock(&encl->mm_lock);
@@ -882,6 +882,49 @@ int sgx_encl_test_and_clear_young(struct mm_struct *mm,
 	return ret;
 }
 
+/**
+ * sgx_zap_enclave_ptes() - remove PTEs mapping the address from enclave
+ * @encl: the enclave
+ * @addr: page aligned pointer to single page for which PTEs will be removed
+ *
+ * Multiple VMAs may have an enclave page mapped. Remove the PTE mapping
+ * @addr from each VMA. Ensure that page fault handler is ready to handle
+ * new mappings of @addr before calling this function.
+ */
+void sgx_zap_enclave_ptes(struct sgx_encl *encl, unsigned long addr)
+{
+	unsigned long mm_list_version;
+	struct sgx_encl_mm *encl_mm;
+	struct vm_area_struct *vma;
+	int idx, ret;
+
+	do {
+		mm_list_version = encl->mm_list_version;
+
+		/* Pairs with smp_wmb() in sgx_encl_mm_add(). */
+		smp_rmb();
+
+		idx = srcu_read_lock(&encl->srcu);
+
+		list_for_each_entry_rcu(encl_mm, &encl->mm_list, list) {
+			if (!mmget_not_zero(encl_mm->mm))
+				continue;
+
+			mmap_read_lock(encl_mm->mm);
+
+			ret = sgx_encl_find(encl_mm->mm, addr, &vma);
+			if (!ret && encl == vma->vm_private_data)
+				zap_vma_ptes(vma, addr, PAGE_SIZE);
+
+			mmap_read_unlock(encl_mm->mm);
+
+			mmput_async(encl_mm->mm);
+		}
+
+		srcu_read_unlock(&encl->srcu, idx);
+	} while (unlikely(encl->mm_list_version != mm_list_version));
+}
+
 /**
  * sgx_alloc_va_page() - Allocate a Version Array (VA) page
  *
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index ef8cf106904b..f72a674e2605 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -111,7 +111,7 @@ int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
 void sgx_encl_put_backing(struct sgx_backing *backing);
 int sgx_encl_test_and_clear_young(struct mm_struct *mm,
 				  struct sgx_encl_page *page);
-
+void sgx_zap_enclave_ptes(struct sgx_encl *encl, unsigned long addr);
 struct sgx_epc_page *sgx_alloc_va_page(void);
 unsigned int sgx_alloc_va_slot(struct sgx_va_page *va_page);
 void sgx_free_va_slot(struct sgx_va_page *va_page, unsigned int offset);
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 736ca652caab..bb0d5e8905be 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -137,36 +137,9 @@ static void sgx_reclaimer_block(struct sgx_epc_page *epc_page)
 	struct sgx_encl_page *page = epc_page->owner;
 	unsigned long addr = page->desc & PAGE_MASK;
 	struct sgx_encl *encl = page->encl;
-	unsigned long mm_list_version;
-	struct sgx_encl_mm *encl_mm;
-	struct vm_area_struct *vma;
-	int idx, ret;
-
-	do {
-		mm_list_version = encl->mm_list_version;
-
-		/* Pairs with smp_rmb() in sgx_encl_mm_add(). */
-		smp_rmb();
-
-		idx = srcu_read_lock(&encl->srcu);
-
-		list_for_each_entry_rcu(encl_mm, &encl->mm_list, list) {
-			if (!mmget_not_zero(encl_mm->mm))
-				continue;
-
-			mmap_read_lock(encl_mm->mm);
-
-			ret = sgx_encl_find(encl_mm->mm, addr, &vma);
-			if (!ret && encl == vma->vm_private_data)
-				zap_vma_ptes(vma, addr, PAGE_SIZE);
-
-			mmap_read_unlock(encl_mm->mm);
-
-			mmput_async(encl_mm->mm);
-		}
+	int ret;
 
-		srcu_read_unlock(&encl->srcu, idx);
-	} while (unlikely(encl->mm_list_version != mm_list_version));
+	sgx_zap_enclave_ptes(encl, addr);
 
 	mutex_lock(&encl->lock);
 
-- 
2.25.1

