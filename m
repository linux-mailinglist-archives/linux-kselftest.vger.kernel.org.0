Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF91752236D
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 20:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348612AbiEJSN1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 14:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348558AbiEJSNW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 14:13:22 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6CE27FC5;
        Tue, 10 May 2022 11:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652206164; x=1683742164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=liX14RO11qPxHWGdkwtlSoaP9ZZ9mvHk1X4XM7mnSPY=;
  b=BjTq6q6FAi/lvwpixqVEo9OBz3bjC/BivTpet6p4MvB+qABimLqL5YRW
   3mCnXebqhQDslTy48Y/X0jEoS4Hl5kT2vHmwj4PTJEK4v85940C57Biy3
   GBRMrsbFnFiEvSwTQM9IDEeaS9DsGfKkQImt/wrRLDy8xhj+hX4mB+TFI
   kswhZHZ8rrMxfTu7BZ3bv5iY747lBqRwv3FUtJKZoewIz+J+gncBnPpk+
   pM2vjc7P+04oLTfjCzgmRYC9RCi3Z9noIJdv+xZMGJdULZFVLwS5Ssrb5
   xv9Qe1m1YUKsW8h0uvdAYod370PcCEAXjLqd51avFQ2wtOO0nBDta4dFI
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="330057523"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="330057523"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 11:09:17 -0700
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="541908779"
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
Subject: [PATCH V5 12/31] x86/sgx: Export sgx_encl_{grow,shrink}()
Date:   Tue, 10 May 2022 11:08:48 -0700
Message-Id: <d51730acf54b6565710b2261b3099517b38c2ec4.1652137848.git.reinette.chatre@intel.com>
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

In order to use sgx_encl_{grow,shrink}() in the page augmentation code
located in encl.c, export these functions.

Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
No changes since V4.

Changes since V3:
- Add Jarkko's Reviewed-by tag.

Changes since V2:
- New patch.

 arch/x86/kernel/cpu/sgx/encl.h  | 2 ++
 arch/x86/kernel/cpu/sgx/ioctl.c | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index 799d4cdb12d5..b6b53c0346ad 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -120,5 +120,7 @@ bool sgx_va_page_full(struct sgx_va_page *va_page);
 void sgx_encl_free_epc_page(struct sgx_epc_page *page);
 struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
 					 unsigned long addr);
+struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl);
+void sgx_encl_shrink(struct sgx_encl *encl, struct sgx_va_page *va_page);
 
 #endif /* _X86_ENCL_H */
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 21078c6643f7..2df27dd8b30d 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -17,7 +17,7 @@
 #include "encl.h"
 #include "encls.h"
 
-static struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl)
+struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl)
 {
 	struct sgx_va_page *va_page = NULL;
 	void *err;
@@ -43,7 +43,7 @@ static struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl)
 	return va_page;
 }
 
-static void sgx_encl_shrink(struct sgx_encl *encl, struct sgx_va_page *va_page)
+void sgx_encl_shrink(struct sgx_encl *encl, struct sgx_va_page *va_page)
 {
 	encl->page_cnt--;
 
-- 
2.25.1

