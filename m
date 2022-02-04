Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0678B4A9FDE
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Feb 2022 20:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbiBDTSB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Feb 2022 14:18:01 -0500
Received: from mga11.intel.com ([192.55.52.93]:61194 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232125AbiBDTSA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Feb 2022 14:18:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644002280; x=1675538280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AMRK/0riEvu7xWjL/b2Vknzv7nHsvl6H7fyafRDpRZ0=;
  b=aFsYfrMEXQYJG/OZG9fmtQV7/CPmkfEPEfQEEPoAQMW+ETZWEqssx8OJ
   l0c9OG+2XMVEa/upU1UNo8umTxUwBeA4CfxnTnMRMJqN4iBoiwXuQGe3L
   +BwOiOWi5fkAK3kR3Ch9FV4UPifbk+U/hkQhqWPRiEPk8UiXPXBGA6mAp
   5ycODpyC8zqBDBqtvGWDBuXZGV0bWm0FmX7yvXPnSlLdV0VXbZqsiLs5T
   vcPhUN9AhWbi/zLqX4SxcyXu0Y+X7KXrI4oDMNCjE9SYnQXCF6SU27Wkl
   KChik7OTfj+e8PSgbCsuk+2N8/WitGQmyllsVVO3/HZPDn4X+i2Bd99lx
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="246017068"
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="246017068"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 11:18:00 -0800
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="524412814"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 11:17:59 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Desnes A. Nunes do Rosario" <desnesn@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Suchanek <msuchanek@suse.de>, linux-mm@kvack.org
Subject: [PATCH 1/3] selftests/vm/pkeys: Use existing __cpuid_count() macro
Date:   Fri,  4 Feb 2022 11:17:09 -0800
Message-Id: <a21d9b718b5dc4a7be28a27571b567877b38d299.1644000145.git.reinette.chatre@intel.com>
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

 #define __cpuid_count(level, count, a, b, c, d)		\
   __asm__ ("cpuid\n\t"						\
            : "=a" (a), "=b" (b), "=c" (c), "=d" (d)		\
            : "0" (level), "2" (count))

The pkeys test contains a local function used as wrapper
of the CPUID instruction. One difference between the pkeys
implementation and the macro from cpuid.h is that the pkeys
implementation provides the "volatile" qualifier to the asm()
call. The "volatile" qualifier is necessary if CPUID has
side effects and thus specifies that any optimizations should
be avoided. The pkeys test uses CPUID to query the system
for its protection keys status and save area properties,
queries without side effect, the "volatile" qualifier
is not required and the macro from cpuid.h can be used instead.

Remove the duplicated wrapper to CPUID and use __cpuid_count()
from cpuid.h instead.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ram Pai <linuxram@us.ibm.com>
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
 tools/testing/selftests/vm/pkey-x86.h | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/vm/pkey-x86.h b/tools/testing/selftests/vm/pkey-x86.h
index e4a4ce2b826d..17b20af8d8f8 100644
--- a/tools/testing/selftests/vm/pkey-x86.h
+++ b/tools/testing/selftests/vm/pkey-x86.h
@@ -2,6 +2,7 @@
 
 #ifndef _PKEYS_X86_H
 #define _PKEYS_X86_H
+#include <cpuid.h>
 
 #ifdef __i386__
 
@@ -80,19 +81,6 @@ static inline void __write_pkey_reg(u64 pkey_reg)
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
@@ -104,9 +92,7 @@ static inline int cpu_has_pkeys(void)
 	unsigned int ecx;
 	unsigned int edx;
 
-	eax = 0x7;
-	ecx = 0x0;
-	__cpuid(&eax, &ebx, &ecx, &edx);
+	__cpuid_count(0x7, 0x0, eax, ebx, ecx, edx);
 
 	if (!(ecx & X86_FEATURE_PKU)) {
 		dprintf2("cpu does not have PKU\n");
@@ -142,9 +128,7 @@ int pkey_reg_xstate_offset(void)
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

