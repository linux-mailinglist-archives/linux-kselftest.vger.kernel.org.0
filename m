Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234E3485294
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jan 2022 13:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbiAEMgJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jan 2022 07:36:09 -0500
Received: from mga04.intel.com ([192.55.52.120]:6474 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240060AbiAEMff (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jan 2022 07:35:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641386135; x=1672922135;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=06UZPspZMjpZ2LW6CbS3zV2Qj9jO0N3Dh9+Q4r5Uso4=;
  b=YjyrROEqwdXHevPRfIRBYVibP6oOaslBTi5Ys3X2cKk+xNREPWhxs6sA
   b3P/LEOBWc1HJIM5YQCMjDuq6bClSy7ZEdbQEYb6IPwJfQzaI3YZNZ81L
   2iHMJxrYRkLwCEwZ8ZJd5WFznPjN7pq8ETYOUfE0L1LsKbElP+XpZPcXx
   psXBvYdccuswxBIv+dXF7eZVMeTIgHONHpaKXAOhVlJwp91eYCVNcFcIT
   9ijJo35UqqL75LYIxj9DxqPwwSiCrGpTFHuF2xN+g8MWmTnawhVhbsylW
   zjgTfrC1zsnHUfeoQF/FlBuG+ZYnKW0sFvIEJLmUVRFoweSxW3XCyRa4t
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="241249355"
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="241249355"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 04:35:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="591004809"
Received: from 984fee00bf64.jf.intel.com ([10.165.54.77])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jan 2022 04:35:33 -0800
From:   Yang Zhong <yang.zhong@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org, seanjc@google.com
Cc:     jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v5 02/21] x86/fpu: Prepare guest FPU for dynamically enabled FPU features
Date:   Wed,  5 Jan 2022 04:35:13 -0800
Message-Id: <20220105123532.12586-3-yang.zhong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220105123532.12586-1-yang.zhong@intel.com>
References: <20220105123532.12586-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

To support dynamically enabled FPU features for guests prepare the guest
pseudo FPU container to keep track of the currently enabled xfeatures and
the guest permissions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 arch/x86/include/asm/fpu/types.h | 13 +++++++++++++
 arch/x86/kernel/fpu/core.c       | 26 +++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 6ddf80637697..c752d0aa23a4 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -504,6 +504,19 @@ struct fpu {
  * Guest pseudo FPU container
  */
 struct fpu_guest {
+	/*
+	 * @xfeatures:			xfeature bitmap of features which are
+	 *				currently enabled for the guest vCPU.
+	 */
+	u64				xfeatures;
+
+	/*
+	 * @perm:			xfeature bitmap of features which are
+	 *				permitted to be enabled for the guest
+	 *				vCPU.
+	 */
+	u64				perm;
+
 	/*
 	 * @fpstate:			Pointer to the allocated guest fpstate
 	 */
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index ab19b3d8b2f7..eddeeb4ed2f5 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -201,6 +201,26 @@ void fpu_reset_from_exception_fixup(void)
 #if IS_ENABLED(CONFIG_KVM)
 static void __fpstate_reset(struct fpstate *fpstate);
 
+static void fpu_init_guest_permissions(struct fpu_guest *gfpu)
+{
+	struct fpu_state_perm *fpuperm;
+	u64 perm;
+
+	if (!IS_ENABLED(CONFIG_X86_64))
+		return;
+
+	spin_lock_irq(&current->sighand->siglock);
+	fpuperm = &current->group_leader->thread.fpu.guest_perm;
+	perm = fpuperm->__state_perm;
+
+	/* First fpstate allocation locks down permissions. */
+	WRITE_ONCE(fpuperm->__state_perm, perm | FPU_GUEST_PERM_LOCKED);
+
+	spin_unlock_irq(&current->sighand->siglock);
+
+	gfpu->perm = perm & ~FPU_GUEST_PERM_LOCKED;
+}
+
 bool fpu_alloc_guest_fpstate(struct fpu_guest *gfpu)
 {
 	struct fpstate *fpstate;
@@ -216,7 +236,11 @@ bool fpu_alloc_guest_fpstate(struct fpu_guest *gfpu)
 	fpstate->is_valloc	= true;
 	fpstate->is_guest	= true;
 
-	gfpu->fpstate = fpstate;
+	gfpu->fpstate		= fpstate;
+	gfpu->xfeatures		= fpu_user_cfg.default_features;
+	gfpu->perm		= fpu_user_cfg.default_features;
+	fpu_init_guest_permissions(gfpu);
+
 	return true;
 }
 EXPORT_SYMBOL_GPL(fpu_alloc_guest_fpstate);
