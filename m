Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3DA522378
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 20:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348658AbiEJSNd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 14:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348564AbiEJSNW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 14:13:22 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7EC29C8B;
        Tue, 10 May 2022 11:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652206164; x=1683742164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k/lbhsKI1/L2/Dd7QwoHsDf43/J0wohOuxW0wLM/SYQ=;
  b=gTz2izvaZUM+a3rY/444g2eJdSpqR27dhiF3hqcXqwaA1R0IHZ41B1aE
   OTuTWgSEmrwQkkBnMdFjaGP76rEN+zm/Df4ehq4FU+hMpAuf3flN6Hk3V
   Ip3742EK2JoWSqgkgrYasTB82xFcA+Cesb8nud2chC7UyroXC4p6EM2S7
   Jb1gGdQOcdamzMYhO30MLjwBK5HGi1ArHa8WJjjVDeCdmZmi4pMPEwOWQ
   S9aizsIsQ3bbLnsl1d0o4mFJqrNfwr5RIwd04o8MbKcV3lt06o22WjX+Y
   30bkJzFp/acDuaMGQdNCX9YGL79z65reVERC7kVLUV1ZTQM4w0ls3bP8J
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="330057525"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="330057525"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 11:09:17 -0700
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="541908786"
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
Subject: [PATCH V5 14/31] x86/sgx: Support VA page allocation without reclaiming
Date:   Tue, 10 May 2022 11:08:50 -0700
Message-Id: <42c5934c229982ee67982bb97c6ab34bde758620.1652137848.git.reinette.chatre@intel.com>
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

struct sgx_encl should be protected with the mutex
sgx_encl->lock. One exception is sgx_encl->page_cnt that
is incremented (in sgx_encl_grow()) when an enclave page
is added to the enclave. The reason the mutex is not held
is to allow the reclaimer to be called directly if there are
no EPC pages (in support of a new VA page) available at the time.

Incrementing sgx_encl->page_cnt without sgc_encl->lock held
is currently (before SGX2) safe from concurrent updates because
all paths in which sgx_encl_grow() is called occur before
enclave initialization and are protected with an atomic
operation on SGX_ENCL_IOCTL.

SGX2 includes support for dynamically adding pages after
enclave initialization where the protection of SGX_ENCL_IOCTL
is not available.

Make direct reclaim of EPC pages optional when new VA pages
are added to the enclave. Essentially the existing "reclaim"
flag used when regular EPC pages are added to an enclave
becomes available to the caller when used to allocate VA pages
instead of always being "true".

When adding pages without invoking the reclaimer it is possible
to do so with sgx_encl->lock held, gaining its protection against
concurrent updates to sgx_encl->page_cnt after enclave
initialization.

No functional change.

Reported-by: Haitao Huang <haitao.huang@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V4:
- Move Haitao's "Tested-by" tag to "x86/sgx: Support adding of pages
  to an initialized enclave". (Jarkko)
- Add Jarkko's Reviewed-by tag.

Changes since V3:
- New patch prompted by Haitao encountering the
  WARN_ON_ONCE(encl->page_cnt % SGX_VA_SLOT_COUNT)
  within sgx_encl_grow() during his SGX2 multi-threaded
  unit tests.

 arch/x86/kernel/cpu/sgx/encl.c  | 6 ++++--
 arch/x86/kernel/cpu/sgx/encl.h  | 4 ++--
 arch/x86/kernel/cpu/sgx/ioctl.c | 8 ++++----
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 2f053af9ce3e..5b5affe1a538 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -959,6 +959,8 @@ void sgx_zap_enclave_ptes(struct sgx_encl *encl, unsigned long addr)
 
 /**
  * sgx_alloc_va_page() - Allocate a Version Array (VA) page
+ * @reclaim: Reclaim EPC pages directly if none available. Enclave
+ *           mutex should not be held if this is set.
  *
  * Allocate a free EPC page and convert it to a Version Array (VA) page.
  *
@@ -966,12 +968,12 @@ void sgx_zap_enclave_ptes(struct sgx_encl *encl, unsigned long addr)
  *   a VA page,
  *   -errno otherwise
  */
-struct sgx_epc_page *sgx_alloc_va_page(void)
+struct sgx_epc_page *sgx_alloc_va_page(bool reclaim)
 {
 	struct sgx_epc_page *epc_page;
 	int ret;
 
-	epc_page = sgx_alloc_epc_page(NULL, true);
+	epc_page = sgx_alloc_epc_page(NULL, reclaim);
 	if (IS_ERR(epc_page))
 		return ERR_CAST(epc_page);
 
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index 2cb58ab868e5..3d0e0ba3edf5 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -116,14 +116,14 @@ struct sgx_encl_page *sgx_encl_page_alloc(struct sgx_encl *encl,
 					  unsigned long offset,
 					  u64 secinfo_flags);
 void sgx_zap_enclave_ptes(struct sgx_encl *encl, unsigned long addr);
-struct sgx_epc_page *sgx_alloc_va_page(void);
+struct sgx_epc_page *sgx_alloc_va_page(bool reclaim);
 unsigned int sgx_alloc_va_slot(struct sgx_va_page *va_page);
 void sgx_free_va_slot(struct sgx_va_page *va_page, unsigned int offset);
 bool sgx_va_page_full(struct sgx_va_page *va_page);
 void sgx_encl_free_epc_page(struct sgx_epc_page *page);
 struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
 					 unsigned long addr);
-struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl);
+struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl, bool reclaim);
 void sgx_encl_shrink(struct sgx_encl *encl, struct sgx_va_page *va_page);
 
 #endif /* _X86_ENCL_H */
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index bb8cdb2ad0d1..5d41aa204761 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -17,7 +17,7 @@
 #include "encl.h"
 #include "encls.h"
 
-struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl)
+struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl, bool reclaim)
 {
 	struct sgx_va_page *va_page = NULL;
 	void *err;
@@ -30,7 +30,7 @@ struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl)
 		if (!va_page)
 			return ERR_PTR(-ENOMEM);
 
-		va_page->epc_page = sgx_alloc_va_page();
+		va_page->epc_page = sgx_alloc_va_page(reclaim);
 		if (IS_ERR(va_page->epc_page)) {
 			err = ERR_CAST(va_page->epc_page);
 			kfree(va_page);
@@ -64,7 +64,7 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 	struct file *backing;
 	long ret;
 
-	va_page = sgx_encl_grow(encl);
+	va_page = sgx_encl_grow(encl, true);
 	if (IS_ERR(va_page))
 		return PTR_ERR(va_page);
 	else if (va_page)
@@ -275,7 +275,7 @@ static int sgx_encl_add_page(struct sgx_encl *encl, unsigned long src,
 		return PTR_ERR(epc_page);
 	}
 
-	va_page = sgx_encl_grow(encl);
+	va_page = sgx_encl_grow(encl, true);
 	if (IS_ERR(va_page)) {
 		ret = PTR_ERR(va_page);
 		goto err_out_free;
-- 
2.25.1

