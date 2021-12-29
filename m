Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC01E48131C
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Dec 2021 14:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239966AbhL2NNg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Dec 2021 08:13:36 -0500
Received: from mga07.intel.com ([134.134.136.100]:28046 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239822AbhL2NNe (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Dec 2021 08:13:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640783614; x=1672319614;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HzpDgJrqU5D4rzU2IRDpuXTztYTcAKUoEU+ftjLu6EI=;
  b=D3wVuuRXnlyRlZtDqSyyOklWr+1cc4RdZR16/z8YhaPfkWBPq4RwEaRY
   +Nr7W2F3eBu2VkxkcRpRwMxTJRGD1zmpirz9iwTVPAUeIcuHrDYxBvzwV
   0CGsVMUXPVsl3TgudGDZ0PPUowA/w3TYYhtFSoa4WiZvrffzOKkeOexpk
   funE72OkY+enUxEbYDH1abhBkpdnlAMwdrYarudc3YoTCb3zjyaq/k8FG
   +0KPPVrEDtARmEpmlnaLg1B4tOkEyeBkvFWruLLHR98TXFrFalgFyM430
   qkxdjxqvsVZaMwWE7mPMk4kCxlvBe7Y8AL+55pA4E/OgrWL0BfKqAxh/5
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="304876119"
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="304876119"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 05:13:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="666281161"
Received: from 984fee00bf64.jf.intel.com ([10.165.54.77])
  by fmsmga001.fm.intel.com with ESMTP; 29 Dec 2021 05:13:33 -0800
From:   Yang Zhong <yang.zhong@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org
Cc:     seanjc@google.com, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v4 05/21] x86/fpu: Make XFD initialization in __fpstate_reset() a function argument
Date:   Wed, 29 Dec 2021 05:13:12 -0800
Message-Id: <20211229131328.12283-6-yang.zhong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211229131328.12283-1-yang.zhong@intel.com>
References: <20211229131328.12283-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jing Liu <jing2.liu@intel.com>

vCPU threads are different from native tasks regarding to the initial XFD
value. While all native tasks follow a fixed value (init_fpstate::xfd)
established by the FPU core at boot, vCPU threads need to obey the reset
value (i.e. ZERO) defined by the specification, to meet the expectation of
the guest.

Let the caller supply an argument and adjust the host and guest related
invocations accordingly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 arch/x86/kernel/fpu/core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index eddeeb4ed2f5..a78bc547fc03 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -199,7 +199,7 @@ void fpu_reset_from_exception_fixup(void)
 }
 
 #if IS_ENABLED(CONFIG_KVM)
-static void __fpstate_reset(struct fpstate *fpstate);
+static void __fpstate_reset(struct fpstate *fpstate, u64 xfd);
 
 static void fpu_init_guest_permissions(struct fpu_guest *gfpu)
 {
@@ -231,7 +231,8 @@ bool fpu_alloc_guest_fpstate(struct fpu_guest *gfpu)
 	if (!fpstate)
 		return false;
 
-	__fpstate_reset(fpstate);
+	/* Leave xfd to 0 (the reset value defined by spec) */
+	__fpstate_reset(fpstate, 0);
 	fpstate_init_user(fpstate);
 	fpstate->is_valloc	= true;
 	fpstate->is_guest	= true;
@@ -454,21 +455,21 @@ void fpstate_init_user(struct fpstate *fpstate)
 		fpstate_init_fstate(fpstate);
 }
 
-static void __fpstate_reset(struct fpstate *fpstate)
+static void __fpstate_reset(struct fpstate *fpstate, u64 xfd)
 {
 	/* Initialize sizes and feature masks */
 	fpstate->size		= fpu_kernel_cfg.default_size;
 	fpstate->user_size	= fpu_user_cfg.default_size;
 	fpstate->xfeatures	= fpu_kernel_cfg.default_features;
 	fpstate->user_xfeatures	= fpu_user_cfg.default_features;
-	fpstate->xfd		= init_fpstate.xfd;
+	fpstate->xfd		= xfd;
 }
 
 void fpstate_reset(struct fpu *fpu)
 {
 	/* Set the fpstate pointer to the default fpstate */
 	fpu->fpstate = &fpu->__fpstate;
-	__fpstate_reset(fpu->fpstate);
+	__fpstate_reset(fpu->fpstate, init_fpstate.xfd);
 
 	/* Initialize the permission related info in fpu */
 	fpu->perm.__state_perm		= fpu_kernel_cfg.default_features;
