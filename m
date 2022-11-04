Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9C9618EE7
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Nov 2022 04:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbiKDD0P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 23:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiKDDZl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 23:25:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775595F5C;
        Thu,  3 Nov 2022 20:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667532242; x=1699068242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lR4IaBvn/83k/t0xwk8WrVqHHlmskFRkxcKwDh4Nfws=;
  b=jMbdE4oNk+4WiMtZ0QWN3fQtyS1a4zRUR22l1mAl1L3yK32mYc59IyCF
   qMgLhfE2qW5rDiCh/aRQMByn1iQw+bLj3oMqMuLgXKwS+2OIsJhFfx684
   RHLawisg+YidyDe21AcfofTa1fAWyZK7OFiq9tox9S/j1knZ64cEV8wLk
   1d/pX4yglZpQhAbNyTqBcDGQcxtx9P4P+FQV2ooDqX+12k//k+P/4af+Z
   vWzy+4WrLvJzuaHL7Ma8VLcfzWk0q5umXi0O2xLp0XGndYZViDTdozDL5
   zN3+n42X4d++V8CAGDiSE9dYJvAe9uSnMciTHZZztrN0UOQgz3h0G9S4Y
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="307491943"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="307491943"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 20:24:01 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="703932015"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="703932015"
Received: from fswhite-mobl3.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.212.196.122])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 20:24:00 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v17 1/3] x86/tdx: Add a wrapper to get TDREPORT from the TDX Module
Date:   Thu,  3 Nov 2022 20:23:53 -0700
Message-Id: <20221104032355.227814-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104032355.227814-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20221104032355.227814-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To support TDX attestation, the TDX guest driver exposes an IOCTL
interface to allow userspace to get the TDREPORT from the TDX module
via TDG.MR.TDREPORT TDCALL.

In order to get the TDREPORT in the TDX guest driver, instead of using
a low level function like __tdx_module_call(), add a
tdx_mcall_get_report() wrapper function to handle it.

This is a preparatory patch for adding attestation support.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v16
 * Added invalid operand error code support.
 * Removed subtype param in tdx_mcall_get_report().

Changes since v15:
 * None

Changes since v14:
 * Instead of exporting __tdx_module_call(), added a new wrapper.
 * Rebased on top of v6.1-rc1

 arch/x86/coco/tdx/tdx.c    | 38 ++++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/tdx.h |  2 ++
 2 files changed, 40 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 928dcf7a20d9..17cf2e9d5849 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -5,6 +5,8 @@
 #define pr_fmt(fmt)     "tdx: " fmt
 
 #include <linux/cpufeature.h>
+#include <linux/export.h>
+#include <linux/io.h>
 #include <asm/coco.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
@@ -15,6 +17,7 @@
 /* TDX module Call Leaf IDs */
 #define TDX_GET_INFO			1
 #define TDX_GET_VEINFO			3
+#define TDX_GET_REPORT			4
 #define TDX_ACCEPT_PAGE			6
 
 /* TDX hypercall Leaf IDs */
@@ -34,6 +37,10 @@
 #define VE_GET_PORT_NUM(e)	((e) >> 16)
 #define VE_IS_IO_STRING(e)	((e) & BIT(4))
 
+/* TDX Module call error codes */
+#define TDCALL_RETURN_CODE(a)	((a) >> 32)
+#define TDCALL_INVALID_OPERAND	0xc0000100
+
 /*
  * Wrapper for standard use of __tdx_hypercall with no output aside from
  * return code.
@@ -98,6 +105,37 @@ static inline void tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
 		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
 }
 
+/**
+ * tdx_mcall_get_report() - Wrapper for TDG.MR.REPORT TDCALL.
+ * @reportdata: Address of the input buffer which contains
+ *              user-defined REPORTDATA to be included into
+ *              TDREPORT.
+ * @tdreport: Address of the output buffer to store TDREPORT.
+ *
+ * Generate TDREPORT using "TDG.MR.REPORT" TDCALL. Refer to section
+ * titled "TDG.MR.REPORT leaf" in the TDX Module 1.0 specification
+ * for detailed information. It is used in the TDX guest driver
+ * module to get the TDREPORT.
+ *
+ * Return 0 on success, -EINVAL for invalid operands, or -EIO on
+ * other TDCALL failures.
+ */
+int tdx_mcall_get_report(u8 *reportdata, u8 *tdreport)
+{
+	u64 ret;
+
+	ret = __tdx_module_call(TDX_GET_REPORT, virt_to_phys(tdreport),
+				virt_to_phys(reportdata), 0, 0, NULL);
+	if (ret) {
+		if (TDCALL_RETURN_CODE(ret) == TDCALL_INVALID_OPERAND)
+			return -EINVAL;
+		return -EIO;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tdx_mcall_get_report);
+
 static u64 get_cc_mask(void)
 {
 	struct tdx_module_output out;
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 020c81a7c729..eef9c0b7880e 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -67,6 +67,8 @@ void tdx_safe_halt(void);
 
 bool tdx_early_handle_ve(struct pt_regs *regs);
 
+int tdx_mcall_get_report(u8 *reportdata, u8 *tdreport);
+
 #else
 
 static inline void tdx_early_init(void) { };
-- 
2.34.1

