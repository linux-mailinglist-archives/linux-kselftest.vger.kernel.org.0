Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DAB522362
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 20:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348570AbiEJSNX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 14:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348524AbiEJSNU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 14:13:20 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106A71D323;
        Tue, 10 May 2022 11:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652206162; x=1683742162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JahZs61zLhB3ZUGo+ZxUJ028Y8xGFsYNKDsCW43HM5U=;
  b=OegjjtfGn+uJOB/wgcYsKfAnSouGPer8BN9nC7IJrpzvifT0YNVZveoL
   KZOhompSMdn0KRM0zYK+a8Gp9L/sMBka2N/y/mSvp+BpmAoFcOqWWv8eP
   nNSQ5+6zPspdkIqQz85Ayqi/kAyMXvl71gnGtzJogSgYcYwicpksAQUtU
   RdJIHjrs4t9dY9VHuH2WcBds0BVmFyxCyKHvOAIXZg7ZtF8WVD+PFMqRC
   KmlulAhosaYQDeTkOAf5S8hOKZakZXZbCAC/EITzg5Pt87mUmFdIW/Pt3
   MwVoVSIKfKlLwA/2Uz1Wg78ytZqBK6WfRRXHeroKn6F5c1lmVTeBnV0d6
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="330057511"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="330057511"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 11:09:16 -0700
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="541908762"
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
Subject: [PATCH V5 07/31] x86/sgx: Rename sgx_encl_ewb_cpumask() as sgx_encl_cpumask()
Date:   Tue, 10 May 2022 11:08:43 -0700
Message-Id: <d4d08c449450a13d8dd3bb6c2b1af03895586d4f.1652137848.git.reinette.chatre@intel.com>
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

sgx_encl_ewb_cpumask() is no longer unique to the reclaimer where it
is used during the EWB ENCLS leaf function when EPC pages are written
out to main memory and sgx_encl_ewb_cpumask() is used to learn which
CPUs might have executed the enclave to ensure that TLBs are cleared.

Upcoming SGX2 enabling will use sgx_encl_ewb_cpumask() during the
EMODPR and EMODT ENCLS leaf functions that make changes to enclave
pages. The function is needed for the same reason it is used now: to
learn which CPUs might have executed the enclave to ensure that TLBs
no longer point to the changed pages.

Rename sgx_encl_ewb_cpumask() to sgx_encl_cpumask() to reflect the
broader usage.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
No changes since V4.

Changes since V3:
- Add Jarkko's Reviewed-by tag.

Changes since V1:
- New patch split from original "x86/sgx: Use more generic name for
  enclave cpumask function" (Jarkko).

 arch/x86/kernel/cpu/sgx/encl.c | 6 +++---
 arch/x86/kernel/cpu/sgx/encl.h | 2 +-
 arch/x86/kernel/cpu/sgx/main.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 04d8212ce400..1bbd76d91554 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -710,7 +710,7 @@ int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm)
 }
 
 /**
- * sgx_encl_ewb_cpumask() - Query which CPUs might be accessing the enclave
+ * sgx_encl_cpumask() - Query which CPUs might be accessing the enclave
  * @encl: the enclave
  *
  * Some SGX functions require that no cached linear-to-physical address
@@ -735,7 +735,7 @@ int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm)
  * The following flow is used to support SGX functions that require that
  * no cached linear-to-physical address mappings are present:
  * 1) Execute ENCLS[ETRACK] to initiate hardware tracking.
- * 2) Use this function (sgx_encl_ewb_cpumask()) to query which CPUs might be
+ * 2) Use this function (sgx_encl_cpumask()) to query which CPUs might be
  *    accessing the enclave.
  * 3) Send IPI to identified CPUs, kicking them out of the enclave and
  *    thus flushing all locally cached linear-to-physical address mappings.
@@ -752,7 +752,7 @@ int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm)
  *
  * Return: cpumask of CPUs that might be accessing @encl
  */
-const cpumask_t *sgx_encl_ewb_cpumask(struct sgx_encl *encl)
+const cpumask_t *sgx_encl_cpumask(struct sgx_encl *encl)
 {
 	cpumask_t *cpumask = &encl->cpumask;
 	struct sgx_encl_mm *encl_mm;
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index c6afa58ea3e6..ef8cf106904b 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -105,7 +105,7 @@ int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
 
 void sgx_encl_release(struct kref *ref);
 int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm);
-const cpumask_t *sgx_encl_ewb_cpumask(struct sgx_encl *encl);
+const cpumask_t *sgx_encl_cpumask(struct sgx_encl *encl);
 int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
 			 struct sgx_backing *backing);
 void sgx_encl_put_backing(struct sgx_backing *backing);
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index d1af5828635d..736ca652caab 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -251,7 +251,7 @@ static void sgx_encl_ewb(struct sgx_epc_page *epc_page,
 			 * miss cpus that entered the enclave between
 			 * generating the mask and incrementing epoch.
 			 */
-			on_each_cpu_mask(sgx_encl_ewb_cpumask(encl),
+			on_each_cpu_mask(sgx_encl_cpumask(encl),
 					 sgx_ipi_cb, NULL, 1);
 			ret = __sgx_encl_ewb(epc_page, va_slot, backing);
 		}
-- 
2.25.1

