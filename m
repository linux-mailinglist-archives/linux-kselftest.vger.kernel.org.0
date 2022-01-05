Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E2C485298
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jan 2022 13:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240138AbiAEMgM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jan 2022 07:36:12 -0500
Received: from mga04.intel.com ([192.55.52.120]:6467 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240116AbiAEMgK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jan 2022 07:36:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641386170; x=1672922170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ge0BTlnpCjiQmZGsfpSwm7WW4/Ispa3drltAGv8CXNo=;
  b=d5ZnGbA6cB4RMYculfeZnLw18KOLPSGPpYJCmEKnJKtcwfzmMGFa2suZ
   gZFeaml66lVDrfXsw+tQqpkTMdi+QxFTGiO4yogq1XvySARzt0eKpMEIv
   VJm3stw8gjxFDRnY/ysWE/mG07xBAuVv8IbiH85M7YhkpMrsDbG8xVWnG
   IpwVoujA6lf5pLCMJYhCCXMMS6yj2s8HKiwHMUWyWmCoon4uirlzvQNKv
   df3P6M0IQNGhvgezgZmrF211QePJoykBmpFDqUNCkrVTqMH36iFYgdpTg
   iOTCY250XV7Wu1Z1ghK+V9Cx4315SulgxODDQq1V4bkb0HtXZvszsUqLn
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="241249375"
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="241249375"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 04:35:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="591004848"
Received: from 984fee00bf64.jf.intel.com ([10.165.54.77])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jan 2022 04:35:37 -0800
From:   Yang Zhong <yang.zhong@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org, seanjc@google.com
Cc:     jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v5 09/21] x86/fpu: Provide fpu_update_guest_xfd() for IA32_XFD emulation
Date:   Wed,  5 Jan 2022 04:35:20 -0800
Message-Id: <20220105123532.12586-10-yang.zhong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220105123532.12586-1-yang.zhong@intel.com>
References: <20220105123532.12586-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Kevin Tian <kevin.tian@intel.com>

Guest XFD can be updated either in the emulation path or in the
restore path.

Provide a wrapper to update guest_fpu::fpstate::xfd. If the guest
fpstate is currently in-use, also update the per-cpu xfd cache and
the actual MSR.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 arch/x86/include/asm/fpu/api.h |  6 ++++++
 arch/x86/kernel/fpu/core.c     | 12 ++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 1ed2a247a84e..e4d10155290b 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -140,6 +140,12 @@ extern void fpu_free_guest_fpstate(struct fpu_guest *gfpu);
 extern int fpu_swap_kvm_fpstate(struct fpu_guest *gfpu, bool enter_guest);
 extern int fpu_enable_guest_xfd_features(struct fpu_guest *guest_fpu, u64 xfeatures);
 
+#ifdef CONFIG_X86_64
+extern void fpu_update_guest_xfd(struct fpu_guest *guest_fpu, u64 xfd);
+#else
+static inline void fpu_update_guest_xfd(struct fpu_guest *guest_fpu, u64 xfd) { }
+#endif
+
 extern void fpu_copy_guest_fpstate_to_uabi(struct fpu_guest *gfpu, void *buf, unsigned int size, u32 pkru);
 extern int fpu_copy_uabi_to_guest_fpstate(struct fpu_guest *gfpu, const void *buf, u64 xcr0, u32 *vpkru);
 
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 5b08d20a4005..8f7f9bfc2506 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -278,6 +278,18 @@ int fpu_enable_guest_xfd_features(struct fpu_guest *guest_fpu, u64 xfeatures)
 }
 EXPORT_SYMBOL_GPL(fpu_enable_guest_xfd_features);
 
+#ifdef CONFIG_X86_64
+void fpu_update_guest_xfd(struct fpu_guest *guest_fpu, u64 xfd)
+{
+	fpregs_lock();
+	guest_fpu->fpstate->xfd = xfd;
+	if (guest_fpu->fpstate->in_use)
+		xfd_update_state(guest_fpu->fpstate);
+	fpregs_unlock();
+}
+EXPORT_SYMBOL_GPL(fpu_update_guest_xfd);
+#endif /* CONFIG_X86_64 */
+
 int fpu_swap_kvm_fpstate(struct fpu_guest *guest_fpu, bool enter_guest)
 {
 	struct fpstate *guest_fps = guest_fpu->fpstate;
