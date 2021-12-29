Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB2D481334
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Dec 2021 14:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240286AbhL2NOB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Dec 2021 08:14:01 -0500
Received: from mga07.intel.com ([134.134.136.100]:28047 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239862AbhL2NNf (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Dec 2021 08:13:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640783615; x=1672319615;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jLUnxHVvvJWKoR8/tErtDvVgMXBOB2fuv98AdUAsrfo=;
  b=Q8QOqwWwXnmvHYtLVlKaWil7RR7zbkEXXiiovNJ1kKJFl6d6GvCMwG3t
   BFNpFo1zLixRTi0D8c2Sp0NFlmfwWdFApU0FhX77U4arn5g5v12Qss2Bt
   5S2NHZ26PP9RXnQNwL6QqNU9Jjm/9vlrHTZBHdqKZDf+B53k/WpIW680Q
   H5CO4tNG7YExpnr2biUZeJmVzHh8XB6CL8mlHIQxpG/kOsTGBkOgY3iz+
   w+LEyCxhcouRwpV0ALcsTLm2HsnAZ8wIlfgIhVF4UxKzd7f3yMqzu57pD
   YIU3STs27R1gdtgfChCZrXgKUgse5zLcTG1QG2B4b7rPvTRHxxCRqOG+Q
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="304876120"
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="304876120"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 05:13:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="666281164"
Received: from 984fee00bf64.jf.intel.com ([10.165.54.77])
  by fmsmga001.fm.intel.com with ESMTP; 29 Dec 2021 05:13:34 -0800
From:   Yang Zhong <yang.zhong@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org
Cc:     seanjc@google.com, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v4 06/21] x86/fpu: Add guest support to xfd_enable_feature()
Date:   Wed, 29 Dec 2021 05:13:13 -0800
Message-Id: <20211229131328.12283-7-yang.zhong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211229131328.12283-1-yang.zhong@intel.com>
References: <20211229131328.12283-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Guest support for dynamically enabled FPU features requires a few
modifications to the enablement function which is currently invoked from
the #NM handler:

  1) Use guest permissions and sizes for the update

  2) Update fpu_guest state accordingly

  3) Take into account that the enabling can be triggered either from a
     running guest via XSETBV and MSR_IA32_XFD write emulation or from
     a guest restore. In the latter case the guests fpstate is not the
     current tasks active fpstate.

Split the function and implement the guest mechanics throughout the
callchain.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 arch/x86/kernel/fpu/xstate.c | 93 +++++++++++++++++++++---------------
 arch/x86/kernel/fpu/xstate.h |  2 +
 2 files changed, 56 insertions(+), 39 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 5f01d463859d..0c0b2323cdec 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1499,29 +1499,6 @@ void fpstate_free(struct fpu *fpu)
 		vfree(fpu->fpstate);
 }
 
-/**
- * fpu_install_fpstate - Update the active fpstate in the FPU
- *
- * @fpu:	A struct fpu * pointer
- * @newfps:	A struct fpstate * pointer
- *
- * Returns:	A null pointer if the last active fpstate is the embedded
- *		one or the new fpstate is already installed;
- *		otherwise, a pointer to the old fpstate which has to
- *		be freed by the caller.
- */
-static struct fpstate *fpu_install_fpstate(struct fpu *fpu,
-					   struct fpstate *newfps)
-{
-	struct fpstate *oldfps = fpu->fpstate;
-
-	if (fpu->fpstate == newfps)
-		return NULL;
-
-	fpu->fpstate = newfps;
-	return oldfps != &fpu->__fpstate ? oldfps : NULL;
-}
-
 /**
  * fpstate_realloc - Reallocate struct fpstate for the requested new features
  *
@@ -1529,6 +1506,7 @@ static struct fpstate *fpu_install_fpstate(struct fpu *fpu,
  *		of that task
  * @ksize:	The required size for the kernel buffer
  * @usize:	The required size for user space buffers
+ * @guest_fpu:	Pointer to a guest FPU container. NULL for host allocations
  *
  * Note vs. vmalloc(): If the task with a vzalloc()-allocated buffer
  * terminates quickly, vfree()-induced IPIs may be a concern, but tasks
@@ -1537,13 +1515,13 @@ static struct fpstate *fpu_install_fpstate(struct fpu *fpu,
  * Returns: 0 on success, -ENOMEM on allocation error.
  */
 static int fpstate_realloc(u64 xfeatures, unsigned int ksize,
-			   unsigned int usize)
+			   unsigned int usize, struct fpu_guest *guest_fpu)
 {
 	struct fpu *fpu = &current->thread.fpu;
 	struct fpstate *curfps, *newfps = NULL;
 	unsigned int fpsize;
+	bool in_use;
 
-	curfps = fpu->fpstate;
 	fpsize = ksize + ALIGN(offsetof(struct fpstate, regs), 64);
 
 	newfps = vzalloc(fpsize);
@@ -1553,28 +1531,55 @@ static int fpstate_realloc(u64 xfeatures, unsigned int ksize,
 	newfps->user_size = usize;
 	newfps->is_valloc = true;
 
+	/*
+	 * When a guest FPU is supplied, use @guest_fpu->fpstate
+	 * as reference independent whether it is in use or not.
+	 */
+	curfps = guest_fpu ? guest_fpu->fpstate : fpu->fpstate;
+
+	/* Determine whether @curfps is the active fpstate */
+	in_use = fpu->fpstate == curfps;
+
+	if (guest_fpu) {
+		newfps->is_guest = true;
+		newfps->is_confidential = curfps->is_confidential;
+		newfps->in_use = curfps->in_use;
+		guest_fpu->xfeatures |= xfeatures;
+	}
+
 	fpregs_lock();
 	/*
-	 * Ensure that the current state is in the registers before
-	 * swapping fpstate as that might invalidate it due to layout
-	 * changes.
+	 * If @curfps is in use, ensure that the current state is in the
+	 * registers before swapping fpstate as that might invalidate it
+	 * due to layout changes.
 	 */
-	if (test_thread_flag(TIF_NEED_FPU_LOAD))
+	if (in_use && test_thread_flag(TIF_NEED_FPU_LOAD))
 		fpregs_restore_userregs();
 
 	newfps->xfeatures = curfps->xfeatures | xfeatures;
 	newfps->user_xfeatures = curfps->user_xfeatures | xfeatures;
 	newfps->xfd = curfps->xfd & ~xfeatures;
 
-	curfps = fpu_install_fpstate(fpu, newfps);
-
 	/* Do the final updates within the locked region */
 	xstate_init_xcomp_bv(&newfps->regs.xsave, newfps->xfeatures);
-	xfd_update_state(newfps);
 
+	if (guest_fpu) {
+		guest_fpu->fpstate = newfps;
+		/* If curfps is active, update the FPU fpstate pointer */
+		if (in_use)
+			fpu->fpstate = newfps;
+	} else {
+		fpu->fpstate = newfps;
+	}
+
+	if (in_use)
+		xfd_update_state(fpu->fpstate);
 	fpregs_unlock();
 
-	vfree(curfps);
+	/* Only free valloc'ed state */
+	if (curfps && curfps->is_valloc)
+		vfree(curfps);
+
 	return 0;
 }
 
@@ -1682,14 +1687,16 @@ static int xstate_request_perm(unsigned long idx, bool guest)
 	return ret;
 }
 
-int xfd_enable_feature(u64 xfd_err)
+int __xfd_enable_feature(u64 xfd_err, struct fpu_guest *guest_fpu)
 {
 	u64 xfd_event = xfd_err & XFEATURE_MASK_USER_DYNAMIC;
+	struct fpu_state_perm *perm;
 	unsigned int ksize, usize;
 	struct fpu *fpu;
 
 	if (!xfd_event) {
-		pr_err_once("XFD: Invalid xfd error: %016llx\n", xfd_err);
+		if (!guest_fpu)
+			pr_err_once("XFD: Invalid xfd error: %016llx\n", xfd_err);
 		return 0;
 	}
 
@@ -1697,14 +1704,16 @@ int xfd_enable_feature(u64 xfd_err)
 	spin_lock_irq(&current->sighand->siglock);
 
 	/* If not permitted let it die */
-	if ((xstate_get_host_group_perm() & xfd_event) != xfd_event) {
+	if ((xstate_get_group_perm(!!guest_fpu) & xfd_event) != xfd_event) {
 		spin_unlock_irq(&current->sighand->siglock);
 		return -EPERM;
 	}
 
 	fpu = &current->group_leader->thread.fpu;
-	ksize = fpu->perm.__state_size;
-	usize = fpu->perm.__user_state_size;
+	perm = guest_fpu ? &fpu->guest_perm : &fpu->perm;
+	ksize = perm->__state_size;
+	usize = perm->__user_state_size;
+
 	/*
 	 * The feature is permitted. State size is sufficient.  Dropping
 	 * the lock is safe here even if more features are added from
@@ -1717,10 +1726,16 @@ int xfd_enable_feature(u64 xfd_err)
 	 * Try to allocate a new fpstate. If that fails there is no way
 	 * out.
 	 */
-	if (fpstate_realloc(xfd_event, ksize, usize))
+	if (fpstate_realloc(xfd_event, ksize, usize, guest_fpu))
 		return -EFAULT;
 	return 0;
 }
+
+int xfd_enable_feature(u64 xfd_err)
+{
+	return __xfd_enable_feature(xfd_err, NULL);
+}
+
 #else /* CONFIG_X86_64 */
 static inline int xstate_request_perm(unsigned long idx, bool guest)
 {
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 98a472775c97..3e63f723525b 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -55,6 +55,8 @@ extern void fpu__init_system_xstate(unsigned int legacy_size);
 
 extern void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
 
+extern int __xfd_enable_feature(u64 which, struct fpu_guest *guest_fpu);
+
 static inline u64 xfeatures_mask_supervisor(void)
 {
 	return fpu_kernel_cfg.max_features & XFEATURE_MASK_SUPERVISOR_SUPPORTED;
