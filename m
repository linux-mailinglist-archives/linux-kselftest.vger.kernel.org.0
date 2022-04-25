Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A90650EAEE
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Apr 2022 23:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244397AbiDYVE2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 17:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245413AbiDYVE2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 17:04:28 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2799B18E33
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 14:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650920483; x=1682456483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iSiLdTbg02IHLCZytLXHOYjcwvRsrkoy2ujNkUnkHVM=;
  b=g44QPv7UyThtA1bvl2yFxQWMP3iOp39uoCB2V1UOLM74R/n2P/YKqG9T
   B5OheGhUyy2EiLVlhjIGMO+ZW//IUxjBB6j20ElVu7o7XpTMC+GIkdV0T
   2mJdgBHpmhmPewJ1on3aFE33YJZ3B3E+V1TYi4di7QATZbl3DNQWzMpQ3
   ZIo5yobPWCXq3xNXCbH4+Eck++JRwKhJrv/1i1hHhPxAQMIqsYN6LAh53
   CBRQSrNpBrirME9KrUd+BYSNbHium94ehosJN26aXsMwXPo0aeZjmmyiu
   x+xWjodsWGrC8kpH1utolVYU7xNV2cDOKEBrNvJ9X2IolY1yGvFwmeC1X
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="290502319"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="290502319"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 14:01:20 -0700
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="579499505"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 14:01:19 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, sandipan@linux.ibm.com,
        fweimer@redhat.com, desnesn@linux.vnet.ibm.com, mingo@kernel.org,
        bauerman@linux.ibm.com, mpe@ellerman.id.au, msuchanek@suse.de,
        linux-mm@kvack.org, chang.seok.bae@intel.com, bp@suse.de,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        luto@kernel.org, x86@kernel.org
Subject: [PATCH V3 4/4] selftests/x86/corrupt_xstate_header: Use provided __cpuid_count() macro
Date:   Mon, 25 Apr 2022 14:01:14 -0700
Message-Id: <20f16bc002e1a328cda02a7b003e728b550951b7.1650918160.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1650918160.git.reinette.chatre@intel.com>
References: <cover.1650918160.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
No changes since V2.

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

