Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF76481366
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Dec 2021 14:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236861AbhL2NPo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Dec 2021 08:15:44 -0500
Received: from mga07.intel.com ([134.134.136.100]:28053 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240427AbhL2NPL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Dec 2021 08:15:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640783711; x=1672319711;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SCKjPPW63mIUiKQ82zQmlY37BU1ztFvuBfN2C/bj1WY=;
  b=TSgxsCZqq8Fl1HOTV4399Oc+4jhy9uogDpCoLqYSrFZkCt1X8PqC0JD2
   v30gqaTaMQpSmoGFaauqwyVjoVS48iz15Cq+FvGZsxsA4GMhyj5njXaaz
   TzVyxINdpjlqfJp1ph/8urkcvf2ke1YBkFl0wwhdYscw8NY4dZt8o46KS
   moWCQwdbz4agF6YDw/1m0j4prVypg9Z2tFVm1eLOgROaLwGBqGtSQjv95
   6IMdpKWo073G652ySuKEIOXk1u6z3W41O61RIqzs/Ezcv8qI9DRjq5wMQ
   f1KfP5pP1G6x11QSixNQPFv8Py68FM1FLUwNuBd/aenagsTpGGlAZ6c01
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="304876169"
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="304876169"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 05:13:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="666281224"
Received: from 984fee00bf64.jf.intel.com ([10.165.54.77])
  by fmsmga001.fm.intel.com with ESMTP; 29 Dec 2021 05:13:44 -0800
From:   Yang Zhong <yang.zhong@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org
Cc:     seanjc@google.com, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v4 20/21] x86/fpu: Provide fpu_sync_guest_vmexit_xfd_state()
Date:   Wed, 29 Dec 2021 05:13:27 -0800
Message-Id: <20211229131328.12283-21-yang.zhong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211229131328.12283-1-yang.zhong@intel.com>
References: <20211229131328.12283-1-yang.zhong@intel.com>
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
