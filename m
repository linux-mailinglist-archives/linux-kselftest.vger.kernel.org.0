Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E713E5000BE
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Apr 2022 23:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237765AbiDMVN1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Apr 2022 17:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239017AbiDMVNI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Apr 2022 17:13:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29007403DD;
        Wed, 13 Apr 2022 14:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649884246; x=1681420246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jmqAQwuCUmDetLsAl9v02bXs5ro0p8fy3L9oNgVQF4E=;
  b=IBM8ULSiXI5RifXlZCrJo1RZj7azTBjLLqrc0QsiiRBWJFYlTi6P+VwN
   5KJ7+aY+1bNk6axsQ9nWoXxEv55zJC2FMEinsAacr2T4AWmIYh+oj0vQW
   ntVv81JTSiY8EDU8MzQFvCdTII9yOb/opYWByZJdptMEt6qIUY5/R+HGg
   4KL9/pP7JGR65NYO0kVVVRpAwaCWLBz0+a2a3ANaHLWz1GoB34WgHi7Ce
   YxibFtT3npa+SU+py+FdjHLRi6bIxg2RPO03FaCWEoWwisfh/ocz9FKPw
   L4s05hB7qDs8CfRmnrLicFPHAa/WeLAiKzFFNDmiOqK6ShThLBUWYoIWP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="323219024"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="323219024"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:10:43 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="725054273"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:10:43 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, vijay.dhanraj@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 12/31] x86/sgx: Export sgx_encl_{grow,shrink}()
Date:   Wed, 13 Apr 2022 14:10:12 -0700
Message-Id: <8d33cff2a2c4e23ff9745dd78935582fd0053cd8.1649878359.git.reinette.chatre@intel.com>
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

In order to use sgx_encl_{grow,shrink}() in the page augmentation code
located in encl.c, export these functions.

Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V3:
- Add Jarkko's Reviewed-by tag.

Changes since V2:
- New patch.

 arch/x86/kernel/cpu/sgx/encl.h  | 2 ++
 arch/x86/kernel/cpu/sgx/ioctl.c | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index 07abfc70c8e3..9d673d9531f0 100644
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

