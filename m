Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C1075869C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 23:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjGRVL5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 17:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjGRVLy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 17:11:54 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14711198D;
        Tue, 18 Jul 2023 14:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689714713; x=1721250713;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VqCLuF6+Bx4Auyc0wAAAKOAjCrnRB30KAZm7eJddByA=;
  b=jwqKRkE7HhrTu7FparjZwQUPbpFkbKVmIxz5AqrV3l+1HIKfwhJ5LAvg
   eN4Xd5esP5ONPU3MNtW/OUmgNbIPVwmqC8pOgoS1KKLxrHZAGLLooWDgq
   D7G0+SP8zOc/b7HPqpksSFWnzyD10x7Ri81pzhjkkH6OQnuumVncpgEFT
   e6ShWoXChIkSEYU4qLkoCfVCGDH38SX0d0KsTZXnrx3HYUgwhyUapfbxC
   t/ElpWzaJgScvduqFGuwi3FSB6e/bh+2yoxsce4LK06NpcX/fxFyghG8d
   OlMC/0Ho2Xd0Fs3oUQAIj0roV/eT4lDtoibfGxMCFTJ29dKenKCVrIv3s
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="432495861"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="432495861"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 14:11:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="753469037"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="753469037"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 18 Jul 2023 14:11:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BDADD33B; Wed, 19 Jul 2023 00:11:49 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 2/4] x86/asm: Replace custom COUNT_ARGS() & CONCATENATE() implementations
Date:   Wed, 19 Jul 2023 00:11:45 +0300
Message-Id: <20230718211147.18647-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230718211147.18647-1-andriy.shevchenko@linux.intel.com>
References: <20230718211147.18647-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Replace custom implementation of the macros from args.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/include/asm/rmwcc.h | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/rmwcc.h b/arch/x86/include/asm/rmwcc.h
index 7fa611216417..4b081e0d3306 100644
--- a/arch/x86/include/asm/rmwcc.h
+++ b/arch/x86/include/asm/rmwcc.h
@@ -2,12 +2,7 @@
 #ifndef _ASM_X86_RMWcc
 #define _ASM_X86_RMWcc
 
-/* This counts to 12. Any more, it will return 13th argument. */
-#define __RMWcc_ARGS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _n, X...) _n
-#define RMWcc_ARGS(X...) __RMWcc_ARGS(, ##X, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
-
-#define __RMWcc_CONCAT(a, b) a ## b
-#define RMWcc_CONCAT(a, b) __RMWcc_CONCAT(a, b)
+#include <linux/args.h>
 
 #define __CLOBBERS_MEM(clb...)	"memory", ## clb
 
@@ -48,7 +43,7 @@ cc_label:	c = true;						\
 #define GEN_UNARY_RMWcc_3(op, var, cc)					\
 	GEN_UNARY_RMWcc_4(op, var, cc, "%[var]")
 
-#define GEN_UNARY_RMWcc(X...) RMWcc_CONCAT(GEN_UNARY_RMWcc_, RMWcc_ARGS(X))(X)
+#define GEN_UNARY_RMWcc(X...)	CONCATENATE(GEN_UNARY_RMWcc_, COUNT_ARGS(X))(X)
 
 #define GEN_BINARY_RMWcc_6(op, var, cc, vcon, _val, arg0)		\
 	__GEN_RMWcc(op " %[val], " arg0, var, cc,			\
@@ -57,7 +52,7 @@ cc_label:	c = true;						\
 #define GEN_BINARY_RMWcc_5(op, var, cc, vcon, val)			\
 	GEN_BINARY_RMWcc_6(op, var, cc, vcon, val, "%[var]")
 
-#define GEN_BINARY_RMWcc(X...) RMWcc_CONCAT(GEN_BINARY_RMWcc_, RMWcc_ARGS(X))(X)
+#define GEN_BINARY_RMWcc(X...)	CONCATENATE(GEN_BINARY_RMWcc_, COUNT_ARGS(X))(X)
 
 #define GEN_UNARY_SUFFIXED_RMWcc(op, suffix, var, cc, clobbers...)	\
 	__GEN_RMWcc(op " %[var]\n\t" suffix, var, cc,			\
-- 
2.40.0.1.gaa8946217a0b

