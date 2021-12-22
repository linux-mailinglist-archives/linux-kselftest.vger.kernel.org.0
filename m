Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DFD47D22D
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 13:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245196AbhLVMmN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Dec 2021 07:42:13 -0500
Received: from mga14.intel.com ([192.55.52.115]:11440 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245138AbhLVMlk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Dec 2021 07:41:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640176900; x=1671712900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ta2Eqb4PNg89gDFRCNYN06qBp8rwWdB7g3PLouU0Wug=;
  b=FPDTALE9qttzuLTOLFTFHoWDMmtFAfNFIIEeY4gbRYUPi0zc0B+gbUie
   ZTpbIF+EhF31siqZwVQ6GRlnrU6S/F8lSkw8g8Y4dTy+sage9P/uYbQmZ
   oih0CehJ2MxHHMQv6nQFCmpyjgeKhqjiWsGkozd7kuJrgJMAPpkhtbviH
   XEKEt7OaAZZargtZo8Wi6da+kb/agioj8eAx2RuSzL7eZp5l7APbDdoiS
   N5qSuZPFb9NquopKFjcOGAkM6MsH9ORMssNuJBeFNTg1iWEhjoVb4B93i
   SRa5oTuLlZ+pVcgrkbWUneCNLtTIrP7bjsqLE+HaDVkM8IedUHTk8e7Oe
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240833438"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="240833438"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 04:41:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="587002788"
Received: from 984fee00a228.jf.intel.com ([10.165.56.59])
  by fmsmga004.fm.intel.com with ESMTP; 22 Dec 2021 04:41:09 -0800
From:   Jing Liu <jing2.liu@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org
Cc:     seanjc@google.com, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v3 21/22] x86/fpu: Provide fpu_sync_guest_vmexit_xfd_state()
Date:   Wed, 22 Dec 2021 04:40:51 -0800
Message-Id: <20211222124052.644626-22-jing2.liu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211222124052.644626-1-jing2.liu@intel.com>
References: <20211222124052.644626-1-jing2.liu@intel.com>
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
---
 arch/x86/include/asm/fpu/api.h |  2 ++
 arch/x86/kernel/fpu/core.c     | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 100b535cd3de..dc51809f0e4a 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -142,8 +142,10 @@ extern int fpu_update_guest_perm_features(struct fpu_guest *guest_fpu);
 
 #ifdef CONFIG_X86_64
 extern void fpu_update_guest_xfd(struct fpu_guest *guest_fpu, u64 xfd);
+extern void fpu_sync_guest_vmexit_xfd_state(void);
 #else
 static inline void fpu_update_guest_xfd(struct fpu_guest *guest_fpu, u64 xfd) { }
+static inline void fpu_sync_guest_vmexit_xfd_state(void) { }
 #endif
 
 extern void fpu_copy_guest_fpstate_to_uabi(struct fpu_guest *gfpu, void *buf, unsigned int size, u32 pkru);
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 89d679cc819b..42a195a6b2ce 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -299,6 +299,30 @@ void fpu_update_guest_xfd(struct fpu_guest *guest_fpu, u64 xfd)
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
-- 
2.27.0

