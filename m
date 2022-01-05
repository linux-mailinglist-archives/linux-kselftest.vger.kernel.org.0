Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3AA64852C7
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jan 2022 13:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240352AbiAEMgy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jan 2022 07:36:54 -0500
Received: from mga04.intel.com ([192.55.52.120]:6468 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240132AbiAEMgM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jan 2022 07:36:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641386172; x=1672922172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uwB8Do+UvWSqh1uXxIm79BiFywBVJAvYlaqDQK4oaUs=;
  b=nmf7sKGD3g/BxZxpP3Zu/VkqIekJ0+VLK2044WeojgMKV1J4OFhcYR3a
   QHyMruUbKPXiXvyVjNWvFc9lsX4W6bds06OW1iIz31VmprPQsXd07vmZp
   ij0jZ1VUA+owV4Xk80Kiq1V0i4ymsMiUaGLd6fuXl+kuHzfyNkrKRbEwY
   DRrfzoFhE2sCGF8rYHN3YWTW50Nf0NVNdnux1waZmN90zcBUZThZqy9Yc
   rLHbrD3PgL56sjPr/NeVL81ENcdObTsh6tly9NrMLeU1cgz5O5XV8FCi2
   VEmq4m+gp9CKVnUuJOp61mDRI1XDJkBuEprRsgM2xR0wmiueBWmu6mKge
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="241249394"
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="241249394"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 04:35:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="591004900"
Received: from 984fee00bf64.jf.intel.com ([10.165.54.77])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jan 2022 04:35:43 -0800
From:   Yang Zhong <yang.zhong@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org, seanjc@google.com
Cc:     jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v5 20/21] x86/fpu: Provide fpu_sync_guest_vmexit_xfd_state()
Date:   Wed,  5 Jan 2022 04:35:31 -0800
Message-Id: <20220105123532.12586-21-yang.zhong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220105123532.12586-1-yang.zhong@intel.com>
References: <20220105123532.12586-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

KVM can disable the write emulation for the XFD MSR when the vCPU's fpstate
is already correctly sized to reduce the overhead.

When write emulation is disabled the XFD MSR state after a VMEXIT is
unknown and therefore not in sync with the software states in fpstate and
the per CPU XFD cache.

Provide fpu_sync_guest_vmexit_xfd_state() which has to be invoked after a
VMEXIT before enabling interrupts when write emulation is disabled for the
XFD MSR.

It could be invoked unconditionally even when write emulation is enabled
for the price of a pointless MSR read.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 arch/x86/include/asm/fpu/api.h |  2 ++
 arch/x86/kernel/fpu/core.c     | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index e4d10155290b..a467eb80f9ed 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -142,8 +142,10 @@ extern int fpu_enable_guest_xfd_features(struct fpu_guest *guest_fpu, u64 xfeatu
 
 #ifdef CONFIG_X86_64
 extern void fpu_update_guest_xfd(struct fpu_guest *guest_fpu, u64 xfd);
+extern void fpu_sync_guest_vmexit_xfd_state(void);
 #else
 static inline void fpu_update_guest_xfd(struct fpu_guest *guest_fpu, u64 xfd) { }
+static inline void fpu_sync_guest_vmexit_xfd_state(void) { }
 #endif
 
 extern void fpu_copy_guest_fpstate_to_uabi(struct fpu_guest *gfpu, void *buf, unsigned int size, u32 pkru);
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 5e7de79c1fe1..e5dfd8b9825a 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -289,6 +289,30 @@ void fpu_update_guest_xfd(struct fpu_guest *guest_fpu, u64 xfd)
 	fpregs_unlock();
 }
 EXPORT_SYMBOL_GPL(fpu_update_guest_xfd);
+
+/**
+ * fpu_sync_guest_vmexit_xfd_state - Synchronize XFD MSR and software state
+ *
+ * Must be invoked from KVM after a VMEXIT before enabling interrupts when
+ * XFD write emulation is disabled. This is required because the guest can
+ * freely modify XFD and the state at VMEXIT is not guaranteed to be the
+ * same as the state on VMENTER. So software state has to be udpated before
+ * any operation which depends on it can take place.
+ *
+ * Note: It can be invoked unconditionally even when write emulation is
+ * enabled for the price of a then pointless MSR read.
+ */
+void fpu_sync_guest_vmexit_xfd_state(void)
+{
+	struct fpstate *fps = current->thread.fpu.fpstate;
+
+	lockdep_assert_irqs_disabled();
+	if (fpu_state_size_dynamic()) {
+		rdmsrl(MSR_IA32_XFD, fps->xfd);
+		__this_cpu_write(xfd_state, fps->xfd);
+	}
+}
+EXPORT_SYMBOL_GPL(fpu_sync_guest_vmexit_xfd_state);
 #endif /* CONFIG_X86_64 */
 
 int fpu_swap_kvm_fpstate(struct fpu_guest *guest_fpu, bool enter_guest)
