Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2D0485291
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jan 2022 13:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240063AbiAEMgH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jan 2022 07:36:07 -0500
Received: from mga04.intel.com ([192.55.52.120]:6468 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240080AbiAEMfe (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jan 2022 07:35:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641386134; x=1672922134;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LJfqImceSkmV+BRcf+NBVvZHtyeVO6miAFxq/ksEz+M=;
  b=fs9Z1CMu36U4lNMhNZjrru06bzw+tCGJTbmqIPC8D+sFz9OMMPul5LG3
   djRaWZBrxRmV8bRwLNPQ69miqhnvvamIBb0Cyxb7wY/i3CHBAVDGkUCu8
   r9Nmfbn4eky3N+MWYaTZpdafctA2uMI4bWes1YVVDiC0EwpPVMrW9RpR6
   z+sdDRXXEFVI3VjnvAenu+xAJFfteo8tRnYBk2orXcURyz3O3MwAwewQV
   IUF1+MVA1EQfOmcGax5MVcAPXm/NDxHcxZXaDV2/2qDyXV7YTh5KhF1ld
   xgs3tI+qCJ1sLBQKPoUcGELGhmI9eNlxLOzeNIaDxeznff7b1TU/1ybyz
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="241249350"
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="241249350"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 04:35:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="591004805"
Received: from 984fee00bf64.jf.intel.com ([10.165.54.77])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jan 2022 04:35:32 -0800
From:   Yang Zhong <yang.zhong@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org, seanjc@google.com
Cc:     jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v5 01/21] x86/fpu: Extend fpu_xstate_prctl() with guest permissions
Date:   Wed,  5 Jan 2022 04:35:12 -0800
Message-Id: <20220105123532.12586-2-yang.zhong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220105123532.12586-1-yang.zhong@intel.com>
References: <20220105123532.12586-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

KVM requires a clear separation of host user space and guest permissions
for dynamic XSTATE components.

Add a guest permissions member to struct fpu and a separate set of prctl()
arguments: ARCH_GET_XCOMP_GUEST_PERM and ARCH_REQ_XCOMP_GUEST_PERM.

The semantics are equivalent to the host user space permission control
except for the following constraints:

  1) Permissions have to be requested before the first vCPU is created

  2) Permissions are frozen when the first vCPU is created to ensure
     consistency. Any attempt to expand permissions via the prctl() after
     that point is rejected.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 arch/x86/include/asm/fpu/api.h    |  2 ++
 arch/x86/include/asm/fpu/types.h  |  9 ++++++
 arch/x86/include/uapi/asm/prctl.h | 26 ++++++++-------
 arch/x86/kernel/fpu/core.c        |  3 ++
 arch/x86/kernel/fpu/xstate.c      | 53 +++++++++++++++++++++++--------
 arch/x86/kernel/fpu/xstate.h      | 13 ++++++--
 arch/x86/kernel/process.c         |  2 ++
 7 files changed, 80 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index c2767a6a387e..d8c222290e68 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -132,6 +132,8 @@ static inline void fpstate_free(struct fpu *fpu) { }
 /* fpstate-related functions which are exported to KVM */
 extern void fpstate_clear_xstate_component(struct fpstate *fps, unsigned int xfeature);
 
+extern inline u64 xstate_get_guest_group_perm(void);
+
 /* KVM specific functions */
 extern bool fpu_alloc_guest_fpstate(struct fpu_guest *gfpu);
 extern void fpu_free_guest_fpstate(struct fpu_guest *gfpu);
diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 3c06c82ab355..6ddf80637697 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -387,6 +387,8 @@ struct fpstate {
 	/* @regs is dynamically sized! Don't add anything after @regs! */
 } __aligned(64);
 
+#define FPU_GUEST_PERM_LOCKED		BIT_ULL(63)
+
 struct fpu_state_perm {
 	/*
 	 * @__state_perm:
@@ -476,6 +478,13 @@ struct fpu {
 	 */
 	struct fpu_state_perm		perm;
 
+	/*
+	 * @guest_perm:
+	 *
+	 * Permission related information for guest pseudo FPUs
+	 */
+	struct fpu_state_perm		guest_perm;
+
 	/*
 	 * @__fpstate:
 	 *
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 754a07856817..500b96e71f18 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -2,20 +2,22 @@
 #ifndef _ASM_X86_PRCTL_H
 #define _ASM_X86_PRCTL_H
 
-#define ARCH_SET_GS		0x1001
-#define ARCH_SET_FS		0x1002
-#define ARCH_GET_FS		0x1003
-#define ARCH_GET_GS		0x1004
+#define ARCH_SET_GS			0x1001
+#define ARCH_SET_FS			0x1002
+#define ARCH_GET_FS			0x1003
+#define ARCH_GET_GS			0x1004
 
-#define ARCH_GET_CPUID		0x1011
-#define ARCH_SET_CPUID		0x1012
+#define ARCH_GET_CPUID			0x1011
+#define ARCH_SET_CPUID			0x1012
 
-#define ARCH_GET_XCOMP_SUPP	0x1021
-#define ARCH_GET_XCOMP_PERM	0x1022
-#define ARCH_REQ_XCOMP_PERM	0x1023
+#define ARCH_GET_XCOMP_SUPP		0x1021
+#define ARCH_GET_XCOMP_PERM		0x1022
+#define ARCH_REQ_XCOMP_PERM		0x1023
+#define ARCH_GET_XCOMP_GUEST_PERM	0x1024
+#define ARCH_REQ_XCOMP_GUEST_PERM	0x1025
 
-#define ARCH_MAP_VDSO_X32	0x2001
-#define ARCH_MAP_VDSO_32	0x2002
-#define ARCH_MAP_VDSO_64	0x2003
+#define ARCH_MAP_VDSO_X32		0x2001
+#define ARCH_MAP_VDSO_32		0x2002
+#define ARCH_MAP_VDSO_64		0x2003
 
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 8ea306b1bf8e..ab19b3d8b2f7 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -450,6 +450,8 @@ void fpstate_reset(struct fpu *fpu)
 	fpu->perm.__state_perm		= fpu_kernel_cfg.default_features;
 	fpu->perm.__state_size		= fpu_kernel_cfg.default_size;
 	fpu->perm.__user_state_size	= fpu_user_cfg.default_size;
+	/* Same defaults for guests */
+	fpu->guest_perm = fpu->perm;
 }
 
 static inline void fpu_inherit_perms(struct fpu *dst_fpu)
@@ -460,6 +462,7 @@ static inline void fpu_inherit_perms(struct fpu *dst_fpu)
 		spin_lock_irq(&current->sighand->siglock);
 		/* Fork also inherits the permissions of the parent */
 		dst_fpu->perm = src_fpu->perm;
+		dst_fpu->guest_perm = src_fpu->guest_perm;
 		spin_unlock_irq(&current->sighand->siglock);
 	}
 }
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index d28829403ed0..5f01d463859d 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1595,7 +1595,7 @@ static int validate_sigaltstack(unsigned int usize)
 	return 0;
 }
 
-static int __xstate_request_perm(u64 permitted, u64 requested)
+static int __xstate_request_perm(u64 permitted, u64 requested, bool guest)
 {
 	/*
 	 * This deliberately does not exclude !XSAVES as we still might
@@ -1605,9 +1605,10 @@ static int __xstate_request_perm(u64 permitted, u64 requested)
 	 */
 	bool compacted = cpu_feature_enabled(X86_FEATURE_XSAVES);
 	struct fpu *fpu = &current->group_leader->thread.fpu;
+	struct fpu_state_perm *perm;
 	unsigned int ksize, usize;
 	u64 mask;
-	int ret;
+	int ret = 0;
 
 	/* Check whether fully enabled */
 	if ((permitted & requested) == requested)
@@ -1621,15 +1622,18 @@ static int __xstate_request_perm(u64 permitted, u64 requested)
 	mask &= XFEATURE_MASK_USER_SUPPORTED;
 	usize = xstate_calculate_size(mask, false);
 
-	ret = validate_sigaltstack(usize);
-	if (ret)
-		return ret;
+	if (!guest) {
+		ret = validate_sigaltstack(usize);
+		if (ret)
+			return ret;
+	}
 
+	perm = guest ? &fpu->guest_perm : &fpu->perm;
 	/* Pairs with the READ_ONCE() in xstate_get_group_perm() */
-	WRITE_ONCE(fpu->perm.__state_perm, requested);
+	WRITE_ONCE(perm->__state_perm, requested);
 	/* Protected by sighand lock */
-	fpu->perm.__state_size = ksize;
-	fpu->perm.__user_state_size = usize;
+	perm->__state_size = ksize;
+	perm->__user_state_size = usize;
 	return ret;
 }
 
@@ -1640,7 +1644,7 @@ static const u64 xstate_prctl_req[XFEATURE_MAX] = {
 	[XFEATURE_XTILE_DATA] = XFEATURE_MASK_XTILE_DATA,
 };
 
-static int xstate_request_perm(unsigned long idx)
+static int xstate_request_perm(unsigned long idx, bool guest)
 {
 	u64 permitted, requested;
 	int ret;
@@ -1661,14 +1665,19 @@ static int xstate_request_perm(unsigned long idx)
 		return -EOPNOTSUPP;
 
 	/* Lockless quick check */
-	permitted = xstate_get_host_group_perm();
+	permitted = xstate_get_group_perm(guest);
 	if ((permitted & requested) == requested)
 		return 0;
 
 	/* Protect against concurrent modifications */
 	spin_lock_irq(&current->sighand->siglock);
-	permitted = xstate_get_host_group_perm();
-	ret = __xstate_request_perm(permitted, requested);
+	permitted = xstate_get_group_perm(guest);
+
+	/* First vCPU allocation locks the permissions. */
+	if (guest && (permitted & FPU_GUEST_PERM_LOCKED))
+		ret = -EBUSY;
+	else
+		ret = __xstate_request_perm(permitted, requested, guest);
 	spin_unlock_irq(&current->sighand->siglock);
 	return ret;
 }
@@ -1713,12 +1722,18 @@ int xfd_enable_feature(u64 xfd_err)
 	return 0;
 }
 #else /* CONFIG_X86_64 */
-static inline int xstate_request_perm(unsigned long idx)
+static inline int xstate_request_perm(unsigned long idx, bool guest)
 {
 	return -EPERM;
 }
 #endif  /* !CONFIG_X86_64 */
 
+inline u64 xstate_get_guest_group_perm(void)
+{
+	return xstate_get_group_perm(true);
+}
+EXPORT_SYMBOL_GPL(xstate_get_guest_group_perm);
+
 /**
  * fpu_xstate_prctl - xstate permission operations
  * @tsk:	Redundant pointer to current
@@ -1742,6 +1757,7 @@ long fpu_xstate_prctl(struct task_struct *tsk, int option, unsigned long arg2)
 	u64 __user *uptr = (u64 __user *)arg2;
 	u64 permitted, supported;
 	unsigned long idx = arg2;
+	bool guest = false;
 
 	if (tsk != current)
 		return -EPERM;
@@ -1760,11 +1776,20 @@ long fpu_xstate_prctl(struct task_struct *tsk, int option, unsigned long arg2)
 		permitted &= XFEATURE_MASK_USER_SUPPORTED;
 		return put_user(permitted, uptr);
 
+	case ARCH_GET_XCOMP_GUEST_PERM:
+		permitted = xstate_get_guest_group_perm();
+		permitted &= XFEATURE_MASK_USER_SUPPORTED;
+		return put_user(permitted, uptr);
+
+	case ARCH_REQ_XCOMP_GUEST_PERM:
+		guest = true;
+		fallthrough;
+
 	case ARCH_REQ_XCOMP_PERM:
 		if (!IS_ENABLED(CONFIG_X86_64))
 			return -EOPNOTSUPP;
 
-		return xstate_request_perm(idx);
+		return xstate_request_perm(idx, guest);
 
 	default:
 		return -EINVAL;
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 86ea7c0fa2f6..98a472775c97 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -20,10 +20,19 @@ static inline void xstate_init_xcomp_bv(struct xregs_state *xsave, u64 mask)
 		xsave->header.xcomp_bv = mask | XCOMP_BV_COMPACTED_FORMAT;
 }
 
-static inline u64 xstate_get_host_group_perm(void)
+static inline u64 xstate_get_group_perm(bool guest)
 {
+	struct fpu *fpu = &current->group_leader->thread.fpu;
+	struct fpu_state_perm *perm;
+
 	/* Pairs with WRITE_ONCE() in xstate_request_perm() */
-	return READ_ONCE(current->group_leader->thread.fpu.perm.__state_perm);
+	perm = guest ? &fpu->guest_perm : &fpu->perm;
+	return READ_ONCE(perm->__state_perm);
+}
+
+static inline u64 xstate_get_host_group_perm(void)
+{
+	return xstate_get_group_perm(false);
 }
 
 enum xstate_copy_mode {
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 04143a653a8a..d7bc23589062 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -993,6 +993,8 @@ long do_arch_prctl_common(struct task_struct *task, int option,
 	case ARCH_GET_XCOMP_SUPP:
 	case ARCH_GET_XCOMP_PERM:
 	case ARCH_REQ_XCOMP_PERM:
+	case ARCH_GET_XCOMP_GUEST_PERM:
+	case ARCH_REQ_XCOMP_GUEST_PERM:
 		return fpu_xstate_prctl(task, option, arg2);
 	}
 
