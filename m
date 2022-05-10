Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EBF52236B
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 20:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348587AbiEJSNZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 14:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348547AbiEJSNV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 14:13:21 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8433135F;
        Tue, 10 May 2022 11:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652206163; x=1683742163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RKR84hyb2OBRUeltCfRFkDfdXpiMdP+4MgXOQxnqJrI=;
  b=WCcSBFWV1gFjvIx1lAjObv/PjoZeyVmb/kMTTQzZvU19eLZYijiJNu8B
   WPDNFi6KE9ebeNtWgaqgAVRioFx/jrat+2bMtvyS746gX4+p21g8Zbwi8
   MSu160Vi6N645jCFjlR0fOvQugAGTb3fpBi+U/sarwXcn6a/uT1VZm3UD
   RSpRypByeLD6q7NobfkKnXaMFnrhWqn7ctY3qZbhAviKPthUWtrNJdUfM
   JGHCO1N3UUwiawfJFrBByfUvZTrptkW06hwJsnosJ94nTNKMKib94EjZs
   WH6D8x7E0MG8sdXx4+ybZJU1pg7A47IIby+o6G26S4HFczAF2NL1BHlvE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="330057518"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="330057518"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 11:09:16 -0700
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="541908773"
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
Subject: [PATCH V5 10/31] x86/sgx: Create utility to validate user provided offset and length
Date:   Tue, 10 May 2022 11:08:46 -0700
Message-Id: <767147bc100047abed47fe27c592901adfbb93a2.1652137848.git.reinette.chatre@intel.com>
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

User provided offset and length is validated when parsing the parameters
of the SGX_IOC_ENCLAVE_ADD_PAGES ioctl(). Extract this validation
(with consistent use of IS_ALIGNED) into a utility that can be used
by the SGX2 ioctl()s that will also provide these values.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
No changes since V4.

Changes since V3:
- Add Jarkko's Reviewed-by tag.
- Consistently use IS_ALIGNED(). (Jarkko)

Changes since V1:
- New patch

 arch/x86/kernel/cpu/sgx/ioctl.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 83df20e3e633..a66795e0b685 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -372,6 +372,26 @@ static int sgx_encl_add_page(struct sgx_encl *encl, unsigned long src,
 	return ret;
 }
 
+/*
+ * Ensure user provided offset and length values are valid for
+ * an enclave.
+ */
+static int sgx_validate_offset_length(struct sgx_encl *encl,
+				      unsigned long offset,
+				      unsigned long length)
+{
+	if (!IS_ALIGNED(offset, PAGE_SIZE))
+		return -EINVAL;
+
+	if (!length || !IS_ALIGNED(length, PAGE_SIZE))
+		return -EINVAL;
+
+	if (offset + length - PAGE_SIZE >= encl->size)
+		return -EINVAL;
+
+	return 0;
+}
+
 /**
  * sgx_ioc_enclave_add_pages() - The handler for %SGX_IOC_ENCLAVE_ADD_PAGES
  * @encl:       an enclave pointer
@@ -425,14 +445,10 @@ static long sgx_ioc_enclave_add_pages(struct sgx_encl *encl, void __user *arg)
 	if (copy_from_user(&add_arg, arg, sizeof(add_arg)))
 		return -EFAULT;
 
-	if (!IS_ALIGNED(add_arg.offset, PAGE_SIZE) ||
-	    !IS_ALIGNED(add_arg.src, PAGE_SIZE))
-		return -EINVAL;
-
-	if (!add_arg.length || add_arg.length & (PAGE_SIZE - 1))
+	if (!IS_ALIGNED(add_arg.src, PAGE_SIZE))
 		return -EINVAL;
 
-	if (add_arg.offset + add_arg.length - PAGE_SIZE >= encl->size)
+	if (sgx_validate_offset_length(encl, add_arg.offset, add_arg.length))
 		return -EINVAL;
 
 	if (copy_from_user(&secinfo, (void __user *)add_arg.secinfo,
-- 
2.25.1

