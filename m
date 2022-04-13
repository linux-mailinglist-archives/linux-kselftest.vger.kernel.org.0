Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9375000DA
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Apr 2022 23:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239064AbiDMVNZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Apr 2022 17:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239016AbiDMVNI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Apr 2022 17:13:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA20B44A33;
        Wed, 13 Apr 2022 14:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649884245; x=1681420245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AG6HQ4kB97od1maoqQHJCA/lJ05JBa4Z0R1kc99zw8s=;
  b=QPxH4aI0LgVTwK6eQeTMdv2ITsWPgS7cdFRo5FDAzvizLFC7dMLBiBKO
   4k1tm7tuavb9wMFei5XuZxoBlxpKu/HSlvvZTp8Ji4IeitEwXAHcSd3UJ
   sYJiTgmEC0lISe/32d6ocy0+f2xhWz9KkPkf/K2qbdYXGMkEsU2ZrjLrO
   FvXX+SoRQcVrYxRxNOEjj+n9C6VoM42VTfL9/aVusdMXHf/mMH7L/DvDz
   OgeQT43g8b87TKNDOilN92y9VS0N/mcvEB7RE8oevObK198CDV3HWka1i
   heLxpijH2aMBZ0Par9PNGVqwauKR2yielsr2Pn+PVYbO4aGRcBbjyrTnH
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="323219018"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="323219018"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:10:43 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="725054265"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:10:42 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, vijay.dhanraj@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 10/31] x86/sgx: Create utility to validate user provided offset and length
Date:   Wed, 13 Apr 2022 14:10:10 -0700
Message-Id: <4db3422a6b6f04191a50584a9ae5de0a2dd96b4f.1649878359.git.reinette.chatre@intel.com>
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

User provided offset and length is validated when parsing the parameters
of the SGX_IOC_ENCLAVE_ADD_PAGES ioctl(). Extract this validation
(with consistent use of IS_ALIGNED) into a utility that can be used
by the SGX2 ioctl()s that will also provide these values.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
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

