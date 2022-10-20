Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2A160568D
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Oct 2022 06:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJTE7m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Oct 2022 00:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiJTE7k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Oct 2022 00:59:40 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0514B186C0;
        Wed, 19 Oct 2022 21:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666241978; x=1697777978;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J1B+wNI21ZvyF3fkLUngeojjoGkXMov8BLHhgnCy9X4=;
  b=AgP3U6xbZx4C1FStYyt7FYbYqDioMPOmrhSbor5jyR+TruK02ULT57da
   0Ks9BD36Pf1vTcfBRjjyvr3UsDY8QXUKnVLCmYlWzQ0GDgo6Z3b6fAj/U
   iC3GiZGXFIT4i0ADqObFHqXP9NbIQsGC7jBtJqcSkL7gJrnjN3Q6xG9IF
   voQqa7Zvnf9rkDdQSJmVjVM4acrePfpsOtOCQs5902TWzCIdJXxYwMLOC
   KOfPRStdFcFRtFTiMvrX5WQdk5dVGWRp6QgMqRvQ2QoeRRuBq0lm9CF8Q
   Q/vqxj990K/vo/qDOuegXq/tpgRGvbly20jBPrBdoTLllQwCBEq5FlQO1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="293997449"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="293997449"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 21:59:31 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="660690255"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="660690255"
Received: from srnaisha-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.209.25.189])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 21:59:31 -0700
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
Subject: [PATCH v15 1/3] x86/tdx: Add a wrapper to get TDREPORT from the TDX Module
Date:   Wed, 19 Oct 2022 21:58:26 -0700
Message-Id: <20221020045828.2354731-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221020045828.2354731-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20221020045828.2354731-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Changes since v14:
 * Instead of exporting __tdx_module_call(), added a new wrapper.
 * Rebased on top of v6.1-rc1

 arch/x86/coco/tdx/tdx.c    | 31 +++++++++++++++++++++++++++++++
 arch/x86/include/asm/tdx.h |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 928dcf7a20d9..6cae239aee14 100644
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
@@ -98,6 +101,34 @@ static inline void tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
 		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
 }
 
+/**
+ * tdx_mcall_get_report() - Wrapper for TDG.MR.REPORT TDCALL.
+ * @reportdata: Address of the input buffer which contains
+ *              user-defined REPORTDATA to be included into
+ *              TDREPORT.
+ * @tdreport: Address of the output buffer to store TDREPORT.
+ * @subtype: Subtype of TDREPORT.
+ *
+ * Generate TDREPORT using "TDG.MR.REPORT" TDCALL. Refer to section
+ * 22.3.3 TDG.MR.REPORT leaf in the TDX Module 1.0 specification
+ * for detailed information. It is used in the TDX guest driver
+ * module to get the TDREPORT.
+ *
+ * Return 0 on success or -EIO on TDCALL failure.
+ */
+int tdx_mcall_get_report(u8 *reportdata, u8 *tdreport, u8 subtype)
+{
+	u64 ret;
+
+	ret = __tdx_module_call(TDX_GET_REPORT, virt_to_phys(tdreport),
+				virt_to_phys(reportdata), subtype, 0, NULL);
+	if (ret)
+		return -EIO;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tdx_mcall_get_report);
+
 static u64 get_cc_mask(void)
 {
 	struct tdx_module_output out;
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 020c81a7c729..eb979d9b8c37 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -67,6 +67,8 @@ void tdx_safe_halt(void);
 
 bool tdx_early_handle_ve(struct pt_regs *regs);
 
+int tdx_mcall_get_report(u8 *reportdata, u8 *tdreport, u8 subtype);
+
 #else
 
 static inline void tdx_early_init(void) { };
-- 
2.34.1

