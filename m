Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503644A9FDF
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Feb 2022 20:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbiBDTSC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Feb 2022 14:18:02 -0500
Received: from mga11.intel.com ([192.55.52.93]:61194 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232259AbiBDTSC (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Feb 2022 14:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644002282; x=1675538282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hSJGQlS3PL8jbOVhKeoI5KEQF3vEjiDdnv98cafGarE=;
  b=P2vOAFdX0BEzzPmO6u5f3hqQzAxFW1FA8piav8dZ6zVLXXuYdmUlZL6E
   35XndsdzkeOKEVwAoEpBi1mrJD6J1eMh/YFGMYYCtXU0rn6TK91TkyiIl
   FfpCNTVSq5/3qAUTkw4yU0Be/s1CPMHqLd4lnPKgkEZvvX46aFBW7CurX
   k4rLgNs3rMxR0jyI0O1zVV8c8e/zPx4onHvWhBRqC+8nkXA2tVQ+0FN88
   7ScmN7eHxovF00wx2zs+5pGzth83p8GEPUkqdSFKkSDOLrsGbq3jaylL+
   yonF10znT+Il/TPo8dSCLReYjT6hNGzai5C+GA0LwK1XTtKKq0IOuGjUq
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="246017070"
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="246017070"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 11:18:00 -0800
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="524412819"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 11:18:00 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH 3/3] selftests/x86/corrupt_xstate_header: Use existing __cpuid_count() macro
Date:   Fri,  4 Feb 2022 11:17:11 -0800
Message-Id: <6bc87ebe3a62ad2ee31a5e5952897c48a8ef2d77.1644000145.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1644000145.git.reinette.chatre@intel.com>
References: <cover.1644000145.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

gcc as well as clang makes the __cpuid_count() macro available
via cpuid.h to conveniently call the CPUID instruction.

Below is a copy of the macro as found in cpuid.h:

 #define __cpuid_count(level, count, a, b, c, d)         \
   __asm__ ("cpuid\n\t"                                  \
            : "=a" (a), "=b" (b), "=c" (c), "=d" (d)     \
            : "0" (level), "2" (count))

The corrupt_xstate_header test contains a local function
used as wrapper to the CPUID instruction. One difference between
the corrupt_xstate_header implementation and the macro from cpuid.h
is that the corrupt_xstate_header implementation provides the
"volatile" qualifier to the asm() call. The "volatile" qualifier
is necessary when CPUID has side effects and thus any
optimizations should be avoided. CPUID is used in the
corrupt_xstate_header test to query the system for its
XSAVE/XRSTOR support, a query without side effect, the
"volatile" qualifier is thus not required and the macro from
cpuid.h can be used instead.

Remove the duplicated wrapper to CPUID and use __cpuid_count()
from cpuid.h instead.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 .../selftests/x86/corrupt_xstate_header.c       | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/x86/corrupt_xstate_header.c b/tools/testing/selftests/x86/corrupt_xstate_header.c
index ab8599c10ce5..7a877612bc98 100644
--- a/tools/testing/selftests/x86/corrupt_xstate_header.c
+++ b/tools/testing/selftests/x86/corrupt_xstate_header.c
@@ -7,6 +7,7 @@
 
 #define _GNU_SOURCE
 
+#include <cpuid.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
@@ -17,25 +18,11 @@
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
-
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

