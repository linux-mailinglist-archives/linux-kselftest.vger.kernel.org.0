Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AFB522360
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 20:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348550AbiEJSNV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 14:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348536AbiEJSNS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 14:13:18 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E33C29820;
        Tue, 10 May 2022 11:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652206160; x=1683742160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J1dxio/jrdcQWYirsDtrovCCz05E7xe6apx4ehqATxw=;
  b=jhi1SR1rvOP92zjU9OAYti48+L9wgnN8VftELU3CryHUUcxQ2G63G6WG
   5kpkttNJgg8NDhEFwAnK384MPuzYQp0QnkpGeVqHkoCk+24g1VC6gB/Ri
   h8/43N812wWn7u4D9ZL/4+mUyO+kGuv2ExkBZQhPj79MSdiciSUTXsv06
   LAnmFdahYsMa2n+4TWXW6dbzp3Kvbn+WoWuDj/zy9ZqmlFsAv1Nq5AMnB
   uPngTsWRUa3Z4GWrofA+gQWGUbsWAttvw8Dx5RL/yGwUA6o0oexjmCKKm
   ZFupOq7GSQ47/xcL9o+D+EY0avLiNt3NCTpQYxbw7h++gg7po2Ng6o37c
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="330057503"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="330057503"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 11:09:16 -0700
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="541908749"
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
Subject: [PATCH V5 03/31] x86/sgx: Add wrapper for SGX2 EMODT function
Date:   Tue, 10 May 2022 11:08:39 -0700
Message-Id: <dba63a8c0db1d510b940beee1ba2a8207efeb1f1.1652137848.git.reinette.chatre@intel.com>
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

Add a wrapper for the EMODT ENCLS leaf function used to
change the type of an enclave page as maintained in the
SGX hardware's Enclave Page Cache Map (EPCM).

EMODT:
1) Updates the EPCM page type of the enclave page.
2) Sets the MODIFIED bit in the EPCM entry of the enclave page.
   This bit is reset by the enclave by invoking ENCLU leaf
   function EACCEPT or EACCEPTCOPY.

Access from within the enclave to the enclave page is not possible
while the MODIFIED bit is set.

After changing the enclave page type by issuing EMODT the kernel
needs to collaborate with the hardware to ensure that no logical
processor continues to hold a reference to the changed page. This
is required to ensure no required security checks are circumvented
and is required for the enclave's EACCEPT/EACCEPTCOPY to succeed.
Ensuring that no references to the changed page remain is
accomplished with the ETRACK flow.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
No changes since V4.

Changes since V3:
- Add Jarkko's Reviewed-by tag.

Changes since V1:
- Split original patch ("x86/sgx: Add wrappers for SGX2 functions")
  in three to introduce the SGX2 functions separately (Jarkko).
- Rewrite commit message to include how the EPCM within the hardware
  is changed by the SGX2 function as well as the calling
  conditions (Jarkko).

 arch/x86/kernel/cpu/sgx/encls.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/encls.h b/arch/x86/kernel/cpu/sgx/encls.h
index 2b091912f038..7a1ecf704ec1 100644
--- a/arch/x86/kernel/cpu/sgx/encls.h
+++ b/arch/x86/kernel/cpu/sgx/encls.h
@@ -221,4 +221,10 @@ static inline int __emodpr(struct sgx_secinfo *secinfo, void *addr)
 	return __encls_ret_2(EMODPR, secinfo, addr);
 }
 
+/* Change the type of an EPC page. */
+static inline int __emodt(struct sgx_secinfo *secinfo, void *addr)
+{
+	return __encls_ret_2(EMODT, secinfo, addr);
+}
+
 #endif /* _X86_ENCLS_H */
-- 
2.25.1

