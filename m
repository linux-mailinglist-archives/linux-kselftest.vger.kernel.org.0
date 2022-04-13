Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506F35000D1
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Apr 2022 23:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239075AbiDMVN1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Apr 2022 17:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239018AbiDMVNI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Apr 2022 17:13:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219153AA77;
        Wed, 13 Apr 2022 14:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649884246; x=1681420246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dr0rPmNIvTEmoBEEvtFon9uc0xlRJ5V7ke7jaykZJQc=;
  b=CXcRqgq4Wf/aejcCn+Bec67lNYvProiRBSSnB8nvA6kEqUc9xkody6Xm
   xQHkJPWHR/bMenE3qw9nfnXAg1FUw60p1CIUxc1DpIDqy2+Oa5T6v3V8Y
   HuhvSt/bwM0mXrLHfzvCR1IVjO/wjUWp30+UvRAItQPsmprm+cJZbQQub
   2tphb1widd1qkQU4bx9GBjgrGcTGYAiMs8B/VZggr0GYSUyhvzpDutzdP
   PmVSWTJrfztc5ePKvwsckHlnBUsTsjlkyF5uNBuQw2bGqHP5lJMAiPGov
   84noDycp4pnVTy+/v84HbEICO0tPiiDios0UAvV3kt4SVcHEg+SMeUfmh
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="323219021"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="323219021"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:10:43 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="725054270"
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
Subject: [PATCH V4 11/31] x86/sgx: Keep record of SGX page type
Date:   Wed, 13 Apr 2022 14:10:11 -0700
Message-Id: <9978af37f51fa45c8878a3c05ceaf44f35806bb8.1649878359.git.reinette.chatre@intel.com>
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

SGX2 functions are not allowed on all page types. For example,
ENCLS[EMODPR] is only allowed on regular SGX enclave pages and
ENCLS[EMODPT] is only allowed on TCS and regular pages. If these
functions are attempted on another type of page the hardware would
trigger a fault.

Keep a record of the SGX page type so that there is more
certainty whether an SGX2 instruction can succeed and faults
can be treated as real failures.

The page type is a property of struct sgx_encl_page
and thus does not cover the VA page type. VA pages are maintained
in separate structures and their type can be determined in
a different way. The SGX2 instructions needing the page type do not
operate on VA pages and this is thus not a scenario needing to
be covered at this time.

struct sgx_encl_page hosting this information is maintained for each
enclave page so the space consumed by the struct is important.
The existing sgx_encl_page->vm_max_prot_bits is already unsigned long
while only using three bits. Transition to a bitfield for the two
members to support the additional information without increasing
the space consumed by the struct.

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V3:
- Add Jarkko's Reviewed-by tag.

Changes since V2:
- Update changelog to motivate transition to bitfield that
  was previously done when (now removed) vm_run_prot_bits was
  added.

Changes since V1:
- Add Acked-by from Jarkko.

 arch/x86/include/asm/sgx.h      | 3 +++
 arch/x86/kernel/cpu/sgx/encl.h  | 3 ++-
 arch/x86/kernel/cpu/sgx/ioctl.c | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
index d67810b50a81..eae20fa52b93 100644
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -239,6 +239,9 @@ struct sgx_pageinfo {
  * %SGX_PAGE_TYPE_REG:	a regular page
  * %SGX_PAGE_TYPE_VA:	a VA page
  * %SGX_PAGE_TYPE_TRIM:	a page in trimmed state
+ *
+ * Make sure when making changes to this enum that its values can still fit
+ * in the bitfield within &struct sgx_encl_page
  */
 enum sgx_page_type {
 	SGX_PAGE_TYPE_SECS,
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index 1b15d22f6757..07abfc70c8e3 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -27,7 +27,8 @@
 
 struct sgx_encl_page {
 	unsigned long desc;
-	unsigned long vm_max_prot_bits;
+	unsigned long vm_max_prot_bits:8;
+	enum sgx_page_type type:16;
 	struct sgx_epc_page *epc_page;
 	struct sgx_encl *encl;
 	struct sgx_va_page *va_page;
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index a66795e0b685..21078c6643f7 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -107,6 +107,7 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 		set_bit(SGX_ENCL_DEBUG, &encl->flags);
 
 	encl->secs.encl = encl;
+	encl->secs.type = SGX_PAGE_TYPE_SECS;
 	encl->base = secs->base;
 	encl->size = secs->size;
 	encl->attributes = secs->attributes;
@@ -344,6 +345,7 @@ static int sgx_encl_add_page(struct sgx_encl *encl, unsigned long src,
 	 */
 	encl_page->encl = encl;
 	encl_page->epc_page = epc_page;
+	encl_page->type = (secinfo->flags & SGX_SECINFO_PAGE_TYPE_MASK) >> 8;
 	encl->secs_child_cnt++;
 
 	if (flags & SGX_PAGE_MEASURE) {
-- 
2.25.1

