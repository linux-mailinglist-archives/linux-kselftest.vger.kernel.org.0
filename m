Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3AB5EE8BF
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Sep 2022 23:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbiI1V4T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Sep 2022 17:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbiI1V4R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Sep 2022 17:56:17 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB27870B2;
        Wed, 28 Sep 2022 14:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664402177; x=1695938177;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RtPINx+oQBut00jsinEziQIc2A8YqCByTG069MvBxfs=;
  b=aSKoIsbgoJuf37VA4NJDxJxi5SYn1Ec+aLigw798GaLKtPXNjdANbmhY
   1FlPXuclqIPaukJ2m1K3elmzc3TogtwpzWLobVU2Dn+7iEvU2BJu4mZ4Y
   Jw2+Yd5DqhLIkRztmC/eTbxhJ+9B+Be7PX12xs9Hknh+1/7QGZukqLOZP
   NBXhoJxO7Lk81OOjgVfLjSGj64gCr4GBPRArcQWe4qBFJEWR8eHESje32
   Si3H1q9G+f7t0L2XtUPvNja0nrYP733AzF0ZHrvI2d5i4NQdp26FMiwkB
   E20u924fZF9x28Cuc3sweqeCgigjwCdbHoqThwz2etlz0MXghOnL0GGzs
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="363566931"
X-IronPort-AV: E=Sophos;i="5.93,353,1654585200"; 
   d="scan'208";a="363566931"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 14:56:15 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="652848695"
X-IronPort-AV: E=Sophos;i="5.93,353,1654585200"; 
   d="scan'208";a="652848695"
Received: from mjpaul-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.209.66.23])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 14:56:15 -0700
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
Subject: [PATCH v14 1/3] x86/tdx: Make __tdx_module_call() usable in driver module
Date:   Wed, 28 Sep 2022 14:55:33 -0700
Message-Id: <20220928215535.26527-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220928215535.26527-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20220928215535.26527-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To support TDX attestation, the TDX guest user interface driver must
use the __tdx module_call() function in the driver to allow the user to
obtain the TDREPORT.

So export the __tdx_module_call() and move the TDX Module IDs to
asm/tdx.h.

This is a preparatory patch for adding attestation support.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v13:
 * None

 arch/x86/coco/tdx/tdcall.S | 2 ++
 arch/x86/coco/tdx/tdx.c    | 5 -----
 arch/x86/include/asm/tdx.h | 5 +++++
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index f9eb1134f22d..47a1534946c8 100644
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -3,6 +3,7 @@
 #include <asm/asm.h>
 #include <asm/frame.h>
 #include <asm/unwind_hints.h>
+#include <asm/export.h>
 
 #include <linux/linkage.h>
 #include <linux/bits.h>
@@ -75,6 +76,7 @@ SYM_FUNC_START(__tdx_module_call)
 	FRAME_END
 	RET
 SYM_FUNC_END(__tdx_module_call)
+EXPORT_SYMBOL_GPL(__tdx_module_call);
 
 /*
  * __tdx_hypercall() - Make hypercalls to a TDX VMM using TDVMCALL leaf
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 928dcf7a20d9..2dcc6021aa43 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -12,11 +12,6 @@
 #include <asm/insn-eval.h>
 #include <asm/pgtable.h>
 
-/* TDX module Call Leaf IDs */
-#define TDX_GET_INFO			1
-#define TDX_GET_VEINFO			3
-#define TDX_ACCEPT_PAGE			6
-
 /* TDX hypercall Leaf IDs */
 #define TDVMCALL_MAP_GPA		0x10001
 
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 020c81a7c729..34c00d8a5263 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -18,6 +18,11 @@
 #define TDX_SW_ERROR			(TDX_ERROR | GENMASK_ULL(47, 40))
 #define TDX_SEAMCALL_VMFAILINVALID	(TDX_SW_ERROR | _UL(0xFFFF0000))
 
+/* TDX module Call Leaf IDs */
+#define TDX_GET_INFO			1
+#define TDX_GET_VEINFO			3
+#define TDX_ACCEPT_PAGE			6
+
 #ifndef __ASSEMBLY__
 
 /*
-- 
2.34.1

