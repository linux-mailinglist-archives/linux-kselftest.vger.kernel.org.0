Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462BD756364
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 14:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjGQMzb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 08:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjGQMz1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 08:55:27 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5501B0;
        Mon, 17 Jul 2023 05:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689598526; x=1721134526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VqCLuF6+Bx4Auyc0wAAAKOAjCrnRB30KAZm7eJddByA=;
  b=A/8xH1mduUSXiRwXaJutZJN9Nrdf/MDIfnUkkpC5UbjYNzOkPu9vdlrn
   +4MZt4zoICdX8XLTiAuHOOn4ei1eJsXs7/Ly2WsJoeznJQuEn/nH9dnyC
   uUtewIaQB1SDfJmkMH++j30ffJI9oEi6mHBkvILr3CqqeAuLIi1yruhYO
   3dLDTCWrbXDadGk6vmCMBFlWRW0eP4q0TawuFhw0xXMtdMuUR4g63YjPT
   oqWjQwGsONNuq/RV8RIXmUFMzBBOAE03w2Wr5UHQQN6almP5v0oVEYApQ
   vreW83qepjMu6SDDgZVtGu3BVtMKw9tS4WgX6lfNtAnv7gxCq/FHhGrnJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="429680675"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="429680675"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 05:55:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="793234537"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="793234537"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jul 2023 05:55:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DC6B0370; Mon, 17 Jul 2023 15:55:23 +0300 (EEST)
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
Subject: [PATCH v3 2/4] x86/asm: Replace custom COUNT_ARGS() & CONCATENATE() implementations
Date:   Mon, 17 Jul 2023 15:55:19 +0300
Message-Id: <20230717125521.43176-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230717125521.43176-1-andriy.shevchenko@linux.intel.com>
References: <20230717125521.43176-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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

