Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACB5522364
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 20:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348555AbiEJSNV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 14:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348537AbiEJSNS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 14:13:18 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1002BB3E;
        Tue, 10 May 2022 11:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652206160; x=1683742160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BBK674xpsQYaqK7Nn5zzSRFMWOkW0xjewMYukjgYANk=;
  b=mVNnFLH+WCowRj6QbsP5nl/Veriiox8QBy2vjQhFHejW5XnZc8sfYzDu
   k6fR5hPgluMW81+N8LzzNWHWS9SCi6jUF0J2LHI5QWLEknoz8oz8Z3ouO
   18IbzQDUObtma7sGb6Qo2+1BZAPLnNNcUy9787fsyLGvwoohwJcDL1tne
   H2Mc8DOrLkGmd42KU6JeyOKO4V8l2iHswt4sOMjES/jVmQpE+xlwyOxgl
   3aNqgHUiqOWQ7X9vy7ctlF6jXebFBh4veptDrdTq6O/K2UI+A7Jmn7VBA
   S+I78P2QcO53tqtVXgKnQu/DBrPNMX3A45aW9yBBVf0IbT+VYBCuuyqvp
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="330057501"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="330057501"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 11:09:16 -0700
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="541908745"
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
Subject: [PATCH V5 02/31] x86/sgx: Add wrapper for SGX2 EMODPR function
Date:   Tue, 10 May 2022 11:08:38 -0700
Message-Id: <d15e7a769e13e4ca671fa2d0a0d3e3aec5aedbd4.1652137848.git.reinette.chatre@intel.com>
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

Add a wrapper for the EMODPR ENCLS leaf function used to
restrict enclave page permissions as maintained in the
SGX hardware's Enclave Page Cache Map (EPCM).

EMODPR:
1) Updates the EPCM permissions of an enclave page by treating
   the new permissions as a mask. Supplying a value that attempts
   to relax EPCM permissions has no effect on EPCM permissions
   (PR bit, see below, is changed).
2) Sets the PR bit in the EPCM entry of the enclave page to
   indicate that permission restriction is in progress. The bit
   is reset by the enclave by invoking ENCLU leaf function
   EACCEPT or EACCEPTCOPY.

The enclave may access the page throughout the entire process
if conforming to the EPCM permissions for the enclave page.

After performing the permission restriction by issuing EMODPR
the kernel needs to collaborate with the hardware to ensure that
all logical processors sees the new restricted permissions. This
is required for the enclave's EACCEPT/EACCEPTCOPY to succeed and
is accomplished with the ETRACK flow.

Expand enum sgx_return_code with the possible EMODPR return
values.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
No changes since V4.

Changes since V3:
- Add Jarkko's Reviewed-by tag.

Changes since V2:
- Add detail to changelog that PR bit is set when EPCM permissions
  not changed when relaxing of permissions using EMODPR attempted.

Changes since V1:
- Split original patch ("x86/sgx: Add wrappers for SGX2 functions")
  in three to introduce the SGX2 functions separately (Jarkko).
- Rewrite commit message to include how the EPCM within the hardware
  is changed by the SGX2 function as well as the calling
  conditions (Jarkko).
- Make short description more specific to which permissions (EPCM
  permissions) the function modifies.

 arch/x86/include/asm/sgx.h      | 5 +++++
 arch/x86/kernel/cpu/sgx/encls.h | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
index 3f9334ef67cd..d67810b50a81 100644
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -65,17 +65,22 @@ enum sgx_encls_function {
 
 /**
  * enum sgx_return_code - The return code type for ENCLS, ENCLU and ENCLV
+ * %SGX_EPC_PAGE_CONFLICT:	Page is being written by other ENCLS function.
  * %SGX_NOT_TRACKED:		Previous ETRACK's shootdown sequence has not
  *				been completed yet.
  * %SGX_CHILD_PRESENT		SECS has child pages present in the EPC.
  * %SGX_INVALID_EINITTOKEN:	EINITTOKEN is invalid and enclave signer's
  *				public key does not match IA32_SGXLEPUBKEYHASH.
+ * %SGX_PAGE_NOT_MODIFIABLE:	The EPC page cannot be modified because it
+ *				is in the PENDING or MODIFIED state.
  * %SGX_UNMASKED_EVENT:		An unmasked event, e.g. INTR, was received
  */
 enum sgx_return_code {
+	SGX_EPC_PAGE_CONFLICT		= 7,
 	SGX_NOT_TRACKED			= 11,
 	SGX_CHILD_PRESENT		= 13,
 	SGX_INVALID_EINITTOKEN		= 16,
+	SGX_PAGE_NOT_MODIFIABLE		= 20,
 	SGX_UNMASKED_EVENT		= 128,
 };
 
diff --git a/arch/x86/kernel/cpu/sgx/encls.h b/arch/x86/kernel/cpu/sgx/encls.h
index 0e22fa8f77c5..2b091912f038 100644
--- a/arch/x86/kernel/cpu/sgx/encls.h
+++ b/arch/x86/kernel/cpu/sgx/encls.h
@@ -215,4 +215,10 @@ static inline int __ewb(struct sgx_pageinfo *pginfo, void *addr,
 	return __encls_ret_3(EWB, pginfo, addr, va);
 }
 
+/* Restrict the EPCM permissions of an EPC page. */
+static inline int __emodpr(struct sgx_secinfo *secinfo, void *addr)
+{
+	return __encls_ret_2(EMODPR, secinfo, addr);
+}
+
 #endif /* _X86_ENCLS_H */
-- 
2.25.1

