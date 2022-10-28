Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111EA6106D0
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Oct 2022 02:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbiJ1A2v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Oct 2022 20:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbiJ1A2u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Oct 2022 20:28:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6047DA23C9;
        Thu, 27 Oct 2022 17:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666916929; x=1698452929;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E/px89SlN8R/Q6i8x8L/Ox07Fnsic7ucBa7xkZ8zshE=;
  b=aCPmThjTe2jfP8n/yvT6WdHDMFvqASk5BEgW0YopfC8ew2Ohdx3qPBAL
   IDnIzJ8XKroiGvdRheVg4oJBwSsEfsadHWi37P4LPOfxdtzGy2khxgqfB
   pKuWtZ2v0xTNUiH497imBaQIHNeTz8gSpGUV995DlUKgXGgfisjRIFiIy
   IFlv+zdK0QhAyVl+Ty0B7g49Bor711e2MHaO+dHfujwrQ0fm/1mWsGaVh
   bhq6CkvSvDwPQWRPTsltHPTkkDo89Em0NSxt9qRCXp6MvAVcFwLNPAXXG
   Qr+y5pSCMnEh/G4bMVfh/A2IV4t8wXy40HU23tUlNF31GTmWvDRF6FdCm
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="288091258"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="288091258"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 17:28:48 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="627356156"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="627356156"
Received: from ortizseb-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.212.153.115])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 17:28:48 -0700
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
Subject: [PATCH v16 1/3] x86/tdx: Add a wrapper to get TDREPORT from the TDX Module
Date:   Thu, 27 Oct 2022 17:28:18 -0700
Message-Id: <20221028002820.3303030-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221028002820.3303030-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20221028002820.3303030-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
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

Changes since v15:
 * None

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

