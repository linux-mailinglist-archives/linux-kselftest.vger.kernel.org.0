Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F25F522363
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 20:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348560AbiEJSNW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 14:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348545AbiEJSNU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 14:13:20 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AAB2C130;
        Tue, 10 May 2022 11:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652206162; x=1683742162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wKBgr3I8WWwlSR/JY9rIj6Ik+VxXF/dCZYbKYpfkFYk=;
  b=cXMR0tZsxH+Y5kIfGhrX5FpiE7pusrTFJ2RYZs1PjXn9r6TM+xcL/IwE
   gjIuAkzJqkokuuu9AbwQrcLmPl+Vpf44J8xkefL4lbbK3Z0csqPjz9guV
   dwedYS+rd+UR23KcLgaqSKlq8VJudBOnGy8H8ZANG10OOMWL2W2Ye+rW6
   /o2My/4EWFHeFgX7wifevogE/sCLQvHsmdLgFoq+eTgl43j0b868B62bv
   lRg4V8sTyoSA1mmFLMEGDN8TwuOT7P2L4LkyCs5E/2FXwanTZ1/osIEgJ
   iI1INNQ9bxg9D+LfPBiY7c0pYsk7XprLRPGVZxxanRN4HlaIfoIUGdtCu
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="330057509"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="330057509"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 11:09:16 -0700
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="541908758"
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
Subject: [PATCH V5 06/31] x86/sgx: Export sgx_encl_ewb_cpumask()
Date:   Tue, 10 May 2022 11:08:42 -0700
Message-Id: <05b60747fd45130cf9fc6edb1c373a69a18a22c5.1652137848.git.reinette.chatre@intel.com>
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

Using sgx_encl_ewb_cpumask() to learn which CPUs might have executed
an enclave is useful to ensure that TLBs are cleared when changes are
made to enclave pages.

sgx_encl_ewb_cpumask() is used within the reclaimer when an enclave
page is evicted. The upcoming SGX2 support enables changes to be
made to enclave pages and will require TLBs to not refer to the
changed pages and thus will be needing sgx_encl_ewb_cpumask().

Relocate sgx_encl_ewb_cpumask() to be with the rest of the enclave
code in encl.c now that it is no longer unique to the reclaimer.

Take care to ensure that any future usage maintains the
current context requirement that ETRACK has been called first.
Expand the existing comments to highlight this while moving them
to a more prominent location before the function.

No functional change.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
No changes since V4.

Changes since V3:
- Add Jarkko's Reviewed-by tag.

Changes since V1:
- New patch split from original "x86/sgx: Use more generic name for
  enclave cpumask function" (Jarkko).
- Change subject line (Jarkko).
- Fixup kernel-doc to use brackets in function name.

 arch/x86/kernel/cpu/sgx/encl.c | 67 ++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/encl.h |  1 +
 arch/x86/kernel/cpu/sgx/main.c | 29 ---------------
 3 files changed, 68 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 7217c492e103..04d8212ce400 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -709,6 +709,73 @@ int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm)
 	return 0;
 }
 
+/**
+ * sgx_encl_ewb_cpumask() - Query which CPUs might be accessing the enclave
+ * @encl: the enclave
+ *
+ * Some SGX functions require that no cached linear-to-physical address
+ * mappings are present before they can succeed. For example, ENCLS[EWB]
+ * copies a page from the enclave page cache to regular main memory but
+ * it fails if it cannot ensure that there are no cached
+ * linear-to-physical address mappings referring to the page.
+ *
+ * SGX hardware flushes all cached linear-to-physical mappings on a CPU
+ * when an enclave is exited via ENCLU[EEXIT] or an Asynchronous Enclave
+ * Exit (AEX). Exiting an enclave will thus ensure cached linear-to-physical
+ * address mappings are cleared but coordination with the tracking done within
+ * the SGX hardware is needed to support the SGX functions that depend on this
+ * cache clearing.
+ *
+ * When the ENCLS[ETRACK] function is issued on an enclave the hardware
+ * tracks threads operating inside the enclave at that time. The SGX
+ * hardware tracking require that all the identified threads must have
+ * exited the enclave in order to flush the mappings before a function such
+ * as ENCLS[EWB] will be permitted
+ *
+ * The following flow is used to support SGX functions that require that
+ * no cached linear-to-physical address mappings are present:
+ * 1) Execute ENCLS[ETRACK] to initiate hardware tracking.
+ * 2) Use this function (sgx_encl_ewb_cpumask()) to query which CPUs might be
+ *    accessing the enclave.
+ * 3) Send IPI to identified CPUs, kicking them out of the enclave and
+ *    thus flushing all locally cached linear-to-physical address mappings.
+ * 4) Execute SGX function.
+ *
+ * Context: It is required to call this function after ENCLS[ETRACK].
+ *          This will ensure that if any new mm appears (racing with
+ *          sgx_encl_mm_add()) then the new mm will enter into the
+ *          enclave with fresh linear-to-physical address mappings.
+ *
+ *          It is required that all IPIs are completed before a new
+ *          ENCLS[ETRACK] is issued so be sure to protect steps 1 to 3
+ *          of the above flow with the enclave's mutex.
+ *
+ * Return: cpumask of CPUs that might be accessing @encl
+ */
+const cpumask_t *sgx_encl_ewb_cpumask(struct sgx_encl *encl)
+{
+	cpumask_t *cpumask = &encl->cpumask;
+	struct sgx_encl_mm *encl_mm;
+	int idx;
+
+	cpumask_clear(cpumask);
+
+	idx = srcu_read_lock(&encl->srcu);
+
+	list_for_each_entry_rcu(encl_mm, &encl->mm_list, list) {
+		if (!mmget_not_zero(encl_mm->mm))
+			continue;
+
+		cpumask_or(cpumask, cpumask, mm_cpumask(encl_mm->mm));
+
+		mmput_async(encl_mm->mm);
+	}
+
+	srcu_read_unlock(&encl->srcu, idx);
+
+	return cpumask;
+}
+
 static struct page *sgx_encl_get_backing_page(struct sgx_encl *encl,
 					      pgoff_t index)
 {
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index 522a17e4fd2d..c6afa58ea3e6 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -105,6 +105,7 @@ int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
 
 void sgx_encl_release(struct kref *ref);
 int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm);
+const cpumask_t *sgx_encl_ewb_cpumask(struct sgx_encl *encl);
 int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
 			 struct sgx_backing *backing);
 void sgx_encl_put_backing(struct sgx_backing *backing);
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index a60f8b2780fb..d1af5828635d 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -205,35 +205,6 @@ static void sgx_ipi_cb(void *info)
 {
 }
 
-static const cpumask_t *sgx_encl_ewb_cpumask(struct sgx_encl *encl)
-{
-	cpumask_t *cpumask = &encl->cpumask;
-	struct sgx_encl_mm *encl_mm;
-	int idx;
-
-	/*
-	 * Can race with sgx_encl_mm_add(), but ETRACK has already been
-	 * executed, which means that the CPUs running in the new mm will enter
-	 * into the enclave with a fresh epoch.
-	 */
-	cpumask_clear(cpumask);
-
-	idx = srcu_read_lock(&encl->srcu);
-
-	list_for_each_entry_rcu(encl_mm, &encl->mm_list, list) {
-		if (!mmget_not_zero(encl_mm->mm))
-			continue;
-
-		cpumask_or(cpumask, cpumask, mm_cpumask(encl_mm->mm));
-
-		mmput_async(encl_mm->mm);
-	}
-
-	srcu_read_unlock(&encl->srcu, idx);
-
-	return cpumask;
-}
-
 /*
  * Swap page to the regular memory transformed to the blocked state by using
  * EBLOCK, which means that it can no longer be referenced (no new TLB entries).
-- 
2.25.1

