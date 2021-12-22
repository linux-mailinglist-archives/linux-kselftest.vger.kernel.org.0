Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83D947D1F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 13:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244996AbhLVMlE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Dec 2021 07:41:04 -0500
Received: from mga14.intel.com ([192.55.52.115]:11437 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244949AbhLVMk6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Dec 2021 07:40:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640176858; x=1671712858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7dXZPVEDoLzyZy2Pl21Dl3pKMjJYI7sq2Em4vBDIQI4=;
  b=VuwfOyiJ2S6x1w232vI6TyjhOoOcRYhqRX/eGcczTscxQ/qYdGRZYS3T
   GQXcdd37YB3OC5yeMSPn/HJsy7CDp3syNBP48fkcqjRZ6tDblnN7IG99N
   94N8NtAlZyzobe4Wm3WNA+OeC7KROp0jHEnD6Q7c+6VuTQJgCU6DG8/4L
   DSZp62u/so5HRBCvX42xXqZTvp5qeriG+Yp97+xyrLLPO6dvqPMwb1VA7
   TG2EHCdtzTbae5drkj/nYPBxKOFbxxWaWI1Fy7kB0UwInLjuqiHKwfxuM
   8vzeZrFH96Ch5v2G/Vyw/ICKHHuF1f1ZVtXhkEMhw8wr2N7o6IVha/CDd
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240833410"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="240833410"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 04:40:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="587002718"
Received: from 984fee00a228.jf.intel.com ([10.165.56.59])
  by fmsmga004.fm.intel.com with ESMTP; 22 Dec 2021 04:40:57 -0800
From:   Jing Liu <jing2.liu@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org
Cc:     seanjc@google.com, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v3 06/22] x86/fpu: Make XFD initialization in __fpstate_reset() a function argument
Date:   Wed, 22 Dec 2021 04:40:36 -0800
Message-Id: <20211222124052.644626-7-jing2.liu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211222124052.644626-1-jing2.liu@intel.com>
References: <20211222124052.644626-1-jing2.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

vCPU threads are different from native tasks regarding to the initial XFD
value. While all native tasks follow a fixed value (init_fpstate::xfd)
established by the FPU core at boot, vCPU threads need to obey the reset
value (i.e. ZERO) defined by the specification, to meet the expectation of
the guest.

Let the caller supply an argument and adjust the host and guest related
invocations accordingly.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
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
-- 
2.27.0

