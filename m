Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97184DA051
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Mar 2022 17:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350166AbiCOQqE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Mar 2022 12:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350157AbiCOQqD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Mar 2022 12:46:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D3057175;
        Tue, 15 Mar 2022 09:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647362690; x=1678898690;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MiECI56S/9YDiazX0GEdDxu5MUFGAQDPH4TCVnzWb8k=;
  b=DhFX2fW9LVqS3GM3qqdOG5dSu+u1YVGeRGUM3jUijbLkXr1toCdyFEUP
   38+0g8jsvDMchDLBCi2YFGmFQ4oUkd7j482vNeBTAF7K688jPR2lynyXN
   +HWlC+gi+Wdm8e1+IVbnMHvYw4l2XFG9zxJSfdVm2owpzs6aQMygGSpEA
   FVUTqotQrSdLiddM5u88vCswqnTiRQcqxjhLrhIGbgoa/A14DIc7vHXuC
   Zf6UntdkZwIAqzEWYRBPc6r1Jk4EZm4v47T7mcL3yRYy5xlOiyzNnhdA3
   vWIjfIXfPJ39B9DBE8f0lUqKszm+wZE/klWF5jefJOghCQ1CDFbTeLDpX
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="342782290"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="342782290"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 09:44:48 -0700
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="714236353"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 09:44:47 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        sandipan@linux.ibm.com, fweimer@redhat.com,
        desnesn@linux.vnet.ibm.com, mingo@kernel.org,
        bauerman@linux.ibm.com, mpe@ellerman.id.au, msuchanek@suse.de,
        linux-mm@kvack.org, chang.seok.bae@intel.com, bp@suse.de,
        tglx@linutronix.de, hpa@zytor.com, x86@kernel.org, luto@kernel.org
Subject: [PATCH V2 2/4] selftests/vm/pkeys: Use provided __cpuid_count() macro
Date:   Tue, 15 Mar 2022 09:44:26 -0700
Message-Id: <66785246406c40e173fe7ce1470dd6d5292d1499.1647360971.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1647360971.git.reinette.chatre@intel.com>
References: <cover.1647360971.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest.h makes the __cpuid_count() macro available
to conveniently call the CPUID instruction.

Remove the local CPUID wrapper and use __cpuid_count()
from already included kselftest.h instead.

__cpuid_count() from kselftest.h is used instead of the
macro provided by the compiler since gcc v4.4 (via cpuid.h)
because the selftest needs to be compiled with gcc v3.2,
the minimal required version for stable kernels.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Sandipan Das <sandipan@linux.ibm.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: "Desnes A. Nunes do Rosario" <desnesn@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michal Suchanek <msuchanek@suse.de>
Cc: linux-mm@kvack.org
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V1:
- Update changelog
- Remove Ram Pai from cc list (email address no longer valid)
- No longer include cpuid.h but obtain __cpuid_count() from
  kselftest.h.

 tools/testing/selftests/vm/pkey-x86.h | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/vm/pkey-x86.h b/tools/testing/selftests/vm/pkey-x86.h
index e4a4ce2b826d..b078ce9c6d2a 100644
--- a/tools/testing/selftests/vm/pkey-x86.h
+++ b/tools/testing/selftests/vm/pkey-x86.h
@@ -80,19 +80,6 @@ static inline void __write_pkey_reg(u64 pkey_reg)
 	assert(pkey_reg == __read_pkey_reg());
 }
 
-static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
-		unsigned int *ecx, unsigned int *edx)
-{
-	/* ecx is often an input as well as an output. */
-	asm volatile(
-		"cpuid;"
-		: "=a" (*eax),
-		  "=b" (*ebx),
-		  "=c" (*ecx),
-		  "=d" (*edx)
-		: "0" (*eax), "2" (*ecx));
-}
-
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (ecx) */
 #define X86_FEATURE_PKU        (1<<3) /* Protection Keys for Userspace */
 #define X86_FEATURE_OSPKE      (1<<4) /* OS Protection Keys Enable */
@@ -104,9 +91,7 @@ static inline int cpu_has_pkeys(void)
 	unsigned int ecx;
 	unsigned int edx;
 
-	eax = 0x7;
-	ecx = 0x0;
-	__cpuid(&eax, &ebx, &ecx, &edx);
+	__cpuid_count(0x7, 0x0, eax, ebx, ecx, edx);
 
 	if (!(ecx & X86_FEATURE_PKU)) {
 		dprintf2("cpu does not have PKU\n");
@@ -142,9 +127,7 @@ int pkey_reg_xstate_offset(void)
 	/* assume that XSTATE_PKEY is set in XCR0 */
 	leaf = XSTATE_PKEY_BIT;
 	{
-		eax = XSTATE_CPUID;
-		ecx = leaf;
-		__cpuid(&eax, &ebx, &ecx, &edx);
+		__cpuid_count(XSTATE_CPUID, leaf, eax, ebx, ecx, edx);
 
 		if (leaf == XSTATE_PKEY_BIT) {
 			xstate_offset = ebx;
-- 
2.25.1

