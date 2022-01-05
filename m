Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0531C4852C5
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jan 2022 13:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240337AbiAEMgx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jan 2022 07:36:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:6468 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240128AbiAEMgL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jan 2022 07:36:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641386171; x=1672922171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QuHvW0YqO/n2BCF1LqnS4+H+14xRfzaHWW/msAICXng=;
  b=njUHHpYeGh/CAnkuL07G4Y68iBknhWBTiHU5pESbwK9/R00Mv6YSHRHp
   JXgZIkGmaRA/uePVZpIa/BMNSx+jZ0u2DCjxI7JtlqkLrTvNg1OwzPliw
   EhjYO65voI7BGqoAsJc25t71poV+MgjvaIer5ubFptXXbKjrrEEIW/Nm2
   /AiHTyptXYmPnPx/ZfvwJU0K+F7lvC+KGwruwax2Lxxm2CFhczG10rTL7
   IO5x0lQuqqWLR678kpuk05st+YbOdnYrJGg0S8fMXAGDY3l/ME+9S6Sn/
   FOx5HnSr1/EZVEn83RPLbFBHuhedpcFzaJM/oxP0kttAouAe4tX7Zcl9t
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="241249388"
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="241249388"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 04:35:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="591004884"
Received: from 984fee00bf64.jf.intel.com ([10.165.54.77])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jan 2022 04:35:41 -0800
From:   Yang Zhong <yang.zhong@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org, seanjc@google.com
Cc:     jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v5 17/21] x86/fpu: Add uabi_size to guest_fpu
Date:   Wed,  5 Jan 2022 04:35:28 -0800
Message-Id: <20220105123532.12586-18-yang.zhong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220105123532.12586-1-yang.zhong@intel.com>
References: <20220105123532.12586-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Userspace needs to inquire KVM about the buffer size to work
with the new KVM_SET_XSAVE and KVM_GET_XSAVE2. Add the size info
to guest_fpu for KVM to access.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 arch/x86/include/asm/fpu/types.h | 5 +++++
 arch/x86/kernel/fpu/core.c       | 1 +
 arch/x86/kernel/fpu/xstate.c     | 1 +
 3 files changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 3795d0573773..eb7cd1139d97 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -522,6 +522,11 @@ struct fpu_guest {
 	 */
 	u64				xfd_err;
 
+	/*
+	 * @uabi_size:			Size required for save/restore
+	 */
+	unsigned int			uabi_size;
+
 	/*
 	 * @fpstate:			Pointer to the allocated guest fpstate
 	 */
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 8f7f9bfc2506..5e7de79c1fe1 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -240,6 +240,7 @@ bool fpu_alloc_guest_fpstate(struct fpu_guest *gfpu)
 	gfpu->fpstate		= fpstate;
 	gfpu->xfeatures		= fpu_user_cfg.default_features;
 	gfpu->perm		= fpu_user_cfg.default_features;
+	gfpu->uabi_size		= fpu_user_cfg.default_size;
 	fpu_init_guest_permissions(gfpu);
 
 	return true;
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 0c0b2323cdec..10fe072f1c92 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1545,6 +1545,7 @@ static int fpstate_realloc(u64 xfeatures, unsigned int ksize,
 		newfps->is_confidential = curfps->is_confidential;
 		newfps->in_use = curfps->in_use;
 		guest_fpu->xfeatures |= xfeatures;
+		guest_fpu->uabi_size = usize;
 	}
 
 	fpregs_lock();
