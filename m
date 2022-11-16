Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B1D62CDD2
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 23:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238534AbiKPWia (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 17:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbiKPWi3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 17:38:29 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C8A18E34;
        Wed, 16 Nov 2022 14:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668638308; x=1700174308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b5o9WR4jT1fCIhIPdb6MOF5ebndO3VG5Ctyr72+LfKk=;
  b=lUz+NsiBvg97wIls1GbSL0cqY1KHnpri97i4xUpd6gKoyogDcKiUBAo3
   9yOSx6TKF/XPM2vWVNe66asDsVrfCrmjTzo2lKykVmIGGXI07vsK3EKVd
   c09WKA0vJ9oXgkM8YFhYV57kkgNYrLnW+OZvmqwv6Rpxjd9VCNb0C1VxM
   aC6f5TbdLZm/4q1qJHGZAodUnWRaPXF8Et5H00PqKEThKC33aa2pgxyS5
   /nKLS38NtUSqkGIit4K8VC2Ib1vcaHLgJ5uxC9Mjhty9DtMGRYyU4TXbW
   3rVaskrIpfswDSjWIKfFPMFYvT02Gehv0MqzE5ZOFEB1oV63b1XfCnJ83
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="398972924"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="398972924"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 14:38:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="670675003"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="670675003"
Received: from swetasha-mobl2.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.209.58.91])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 14:38:26 -0800
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
Subject: [PATCH v18 1/3] x86/tdx: Add a wrapper to get TDREPORT0 from the TDX Module
Date:   Wed, 16 Nov 2022 14:38:18 -0800
Message-Id: <20221116223820.819090-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116223820.819090-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20221116223820.819090-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To support TDX attestation, the TDX guest driver exposes an IOCTL
interface to allow userspace to get the TDREPORT0 (a.k.a. TDREPORT
subtype 0) from the TDX module via TDG.MR.TDREPORT TDCALL.

In order to get the TDREPORT0 in the TDX guest driver, instead of using
a low level function like __tdx_module_call(), add a
tdx_mcall_get_report0() wrapper function to handle it.

This is a preparatory patch for adding attestation support.

Acked-by: Wander Lairson Costa <wander@redhat.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v17:
 * Included subtype index to TDREPORT and modified the commit
   logs and comments to align with it.
 * Renamed tdx_mcall_get_report() to tdx_mcall_get_report0()

Changes since v16
 * Added invalid operand error code support.
 * Removed subtype param in tdx_mcall_get_report().

Changes since v15:
 * None

Changes since v14:
 * Instead of exporting __tdx_module_call(), added a new wrapper.
 * Rebased on top of v6.1-rc1

 arch/x86/coco/tdx/tdx.c    | 40 ++++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/tdx.h |  2 ++
 2 files changed, 42 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 928dcf7a20d9..4121c5d296ee 100644
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
@@ -34,6 +37,12 @@
 #define VE_GET_PORT_NUM(e)	((e) >> 16)
 #define VE_IS_IO_STRING(e)	((e) & BIT(4))
 
+/* TDX Module call error codes */
+#define TDCALL_RETURN_CODE(a)	((a) >> 32)
+#define TDCALL_INVALID_OPERAND	0xc0000100
+
+#define TDREPORT_SUBTYPE_0	0
+
 /*
  * Wrapper for standard use of __tdx_hypercall with no output aside from
  * return code.
@@ -98,6 +107,37 @@ static inline void tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
 		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
 }
 
+/**
+ * tdx_mcall_get_report0() - Wrapper to get TDREPORT0 (a.k.a. TDREPORT
+ *                           subtype 0) using TDG.MR.REPORT TDCALL.
+ * @reportdata: Address of the input buffer which contains user-defined
+ *              REPORTDATA to be included into TDREPORT.
+ * @tdreport: Address of the output buffer to store TDREPORT.
+ *
+ * Refer to section titled "TDG.MR.REPORT leaf" in the TDX Module
+ * v1.0 specification for more information on TDG.MR.REPORT TDCALL.
+ * It is used in the TDX guest driver module to get the TDREPORT0.
+ *
+ * Return 0 on success, -EINVAL for invalid operands, or -EIO on
+ * other TDCALL failures.
+ */
+int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport)
+{
+	u64 ret;
+
+	ret = __tdx_module_call(TDX_GET_REPORT, virt_to_phys(tdreport),
+				virt_to_phys(reportdata), TDREPORT_SUBTYPE_0,
+				0, NULL);
+	if (ret) {
+		if (TDCALL_RETURN_CODE(ret) == TDCALL_INVALID_OPERAND)
+			return -EINVAL;
+		return -EIO;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tdx_mcall_get_report0);
+
 static u64 get_cc_mask(void)
 {
 	struct tdx_module_output out;
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 020c81a7c729..28d889c9aa16 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -67,6 +67,8 @@ void tdx_safe_halt(void);
 
 bool tdx_early_handle_ve(struct pt_regs *regs);
 
+int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport);
+
 #else
 
 static inline void tdx_early_init(void) { };
-- 
2.34.1

