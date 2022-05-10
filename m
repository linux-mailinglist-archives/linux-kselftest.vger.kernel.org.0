Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AFB522368
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 20:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348584AbiEJSNZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 14:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348546AbiEJSNV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 14:13:21 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36AD2DD79;
        Tue, 10 May 2022 11:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652206162; x=1683742162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FJfKrMjaKbMfb8RS0t6IxubSzc4FXrABp9R8uuhlVVo=;
  b=VaytJpzSrvCOafL2xFPaZYgkQka4nKWvmnzLUfY/DNYjvNmfrvUw355f
   XMKJol+xcKELDxQOI4pe0jVNJln7vXCfVwArwXbWnm+e3QRY4xCn5Y/HA
   5Fk09OTjy41Yu+FT1MvlhDCOphyoQ0LabvKab0YChijjbjTsgTXqaYzmF
   xFVRw2kDCGzu6et03GaZF9ByaZMhU2+5dscoMI2GcAkyiEj/CfZgs6fZV
   yPlrI4jAWmL+NAoLDzLCqEwg+I0M3kXgBsaID00nJvSwY2X9tmRsEK/Mq
   c+hDJGsNLwy+2x9mWR3SSgJgyhi45aVD3rS5H7Z+H/LRWG1UwF35NYOFv
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="330057516"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="330057516"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 11:09:16 -0700
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="541908770"
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
Subject: [PATCH V5 09/31] x86/sgx: Make sgx_ipi_cb() available internally
Date:   Tue, 10 May 2022 11:08:45 -0700
Message-Id: <1179ed4a9c3c1c2abf49d51bfcf2c30b493181cc.1652137848.git.reinette.chatre@intel.com>
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

The ETRACK function followed by an IPI to all CPUs within an enclave
is a common pattern with more frequent use in support of SGX2.

Make the (empty) IPI callback function available internally in
preparation for usage by SGX2.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
No changes since V4.

Changes since V3:
- Add Jarkko's Reviewed-by tag.

Changes since V1:
- Replace "for more usages" by "for usage by SGX2" (Jarkko)

 arch/x86/kernel/cpu/sgx/main.c | 2 +-
 arch/x86/kernel/cpu/sgx/sgx.h  | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index bb0d5e8905be..bab2a2e13c70 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -174,7 +174,7 @@ static int __sgx_encl_ewb(struct sgx_epc_page *epc_page, void *va_slot,
 	return ret;
 }
 
-static void sgx_ipi_cb(void *info)
+void sgx_ipi_cb(void *info)
 {
 }
 
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 0f17def9fe6f..b30cee4de903 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -90,6 +90,8 @@ void sgx_mark_page_reclaimable(struct sgx_epc_page *page);
 int sgx_unmark_page_reclaimable(struct sgx_epc_page *page);
 struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
 
+void sgx_ipi_cb(void *info);
+
 #ifdef CONFIG_X86_SGX_KVM
 int __init sgx_vepc_init(void);
 #else
-- 
2.25.1

