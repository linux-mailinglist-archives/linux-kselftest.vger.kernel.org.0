Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28944DA054
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Mar 2022 17:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350169AbiCOQqF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Mar 2022 12:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350160AbiCOQqD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Mar 2022 12:46:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAE157486;
        Tue, 15 Mar 2022 09:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647362691; x=1678898691;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PoCY1b2mtOop0l56GUUK95GUNFxvSin6gRz+vAzCjS0=;
  b=M4/Dv38eZKW2/IpETF0a0W8L3/fpw9Jq9L2NYCKnJMtqWQhdjsF8kMX2
   Tyvjg3QBQv2sf9zSp2ywRfkrz/nXmOFWxYVTOvMlmU6/G36lqP8MYJncv
   knAR6vOMoMBX8A0mkNLyRK2gPmd/X9wH9hPzpQCQJLX8hAwFkI7RAwE97
   45e+ihRuTPxGNNbTpZW9OQxlAekNB++fpGHKZQodvOqE6umYARYxII4eV
   wXn0KOq0VERdN2Ii4vJx+GyG8wt0C3hdfRJnf8x4GYDIBOLoYwcUeZ1ho
   V/i35f/2GJM2wAEHLb0cr95fPktho/Q3m4UbxHHRNbhf8Le0ROKfLvCas
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="342782292"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="342782292"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 09:44:49 -0700
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="714236358"
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
Subject: [PATCH V2 4/4] selftests/x86/corrupt_xstate_header: Use provided __cpuid_count() macro
Date:   Tue, 15 Mar 2022 09:44:28 -0700
Message-Id: <80ebe8386496e4cc266637fe1d84b7f083f8788f.1647360971.git.reinette.chatre@intel.com>
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
from kselftest.h instead.

__cpuid_count() from kselftest.h is used instead of the
macro provided by the compiler since gcc v4.4 (via cpuid.h)
because the selftest needs to be supported with gcc v3.2,
the minimal required version for stable kernels.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V1:
- Update changelog
- No longer include cpuid.h but obtain __cpuid_count() from
  kselftest.h.

 .../selftests/x86/corrupt_xstate_header.c        | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/x86/corrupt_xstate_header.c b/tools/testing/selftests/x86/corrupt_xstate_header.c
index ab8599c10ce5..cf9ce8fbb656 100644
--- a/tools/testing/selftests/x86/corrupt_xstate_header.c
+++ b/tools/testing/selftests/x86/corrupt_xstate_header.c
@@ -17,25 +17,13 @@
 #include <stdint.h>
 #include <sys/wait.h>
 
-static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
-			   unsigned int *ecx, unsigned int *edx)
-{
-	asm volatile(
-		"cpuid;"
-		: "=a" (*eax),
-		  "=b" (*ebx),
-		  "=c" (*ecx),
-		  "=d" (*edx)
-		: "0" (*eax), "2" (*ecx));
-}
+#include "../kselftest.h" /* For __cpuid_count() */
 
 static inline int xsave_enabled(void)
 {
 	unsigned int eax, ebx, ecx, edx;
 
-	eax = 0x1;
-	ecx = 0x0;
-	__cpuid(&eax, &ebx, &ecx, &edx);
+	__cpuid_count(0x1, 0x0, eax, ebx, ecx, edx);
 
 	/* Is CR4.OSXSAVE enabled ? */
 	return ecx & (1U << 27);
-- 
2.25.1

