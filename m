Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0A248132C
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Dec 2021 14:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240253AbhL2NN4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Dec 2021 08:13:56 -0500
Received: from mga07.intel.com ([134.134.136.100]:28047 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240103AbhL2NNj (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Dec 2021 08:13:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640783619; x=1672319619;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FqVq6RDtvRtu/YdDCx0wpOw5u0A/Bh9N0d8kEKHkZ9E=;
  b=AjAbkZK4/ZoOEfXZPt6AhZGfm7man4O/QkGlVMgW2QQzqsKJZ2cUpgoq
   TcutcChc9QsvSatHNaK6xZPiuloRGZXFzEFiPeFxp7EpOw+vSRkMDWG/k
   ZQwjgEuA0sapC1Xe/cR0ylOgSDtlSbEunKK9CyF+i4xth9rkejRZ59YMi
   SJDjgd5dZI2i6pzAIMHgWtnqves7Y04WUn4i9bl70oSul07GLOFO4y9fE
   kjFjWK6zCHv5QUeqS9Vlmik57hYpwiWGrKhDSpqS/n8e3wW5EIc8eaum0
   njL4qCMtCd7XyZhRfcMyMQeuFTc4Wkhx0jV+cgb4Tli58wJiinYHeOEhE
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="304876123"
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="304876123"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 05:13:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="666281177"
Received: from 984fee00bf64.jf.intel.com ([10.165.54.77])
  by fmsmga001.fm.intel.com with ESMTP; 29 Dec 2021 05:13:36 -0800
From:   Yang Zhong <yang.zhong@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org
Cc:     seanjc@google.com, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v4 09/21] x86/fpu: Provide fpu_update_guest_xfd() for IA32_XFD emulation
Date:   Wed, 29 Dec 2021 05:13:16 -0800
Message-Id: <20211229131328.12283-10-yang.zhong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211229131328.12283-1-yang.zhong@intel.com>
References: <20211229131328.12283-1-yang.zhong@intel.com>
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
index 8e934e571273..100b535cd3de 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -140,6 +140,12 @@ extern void fpu_free_guest_fpstate(struct fpu_guest *gfpu);
 extern int fpu_swap_kvm_fpstate(struct fpu_guest *gfpu, bool enter_guest);
 extern int fpu_update_guest_perm_features(struct fpu_guest *guest_fpu);
 
+#ifdef CONFIG_X86_64
+extern void fpu_update_guest_xfd(struct fpu_guest *guest_fpu, u64 xfd);
+#else
+static inline void fpu_update_guest_xfd(struct fpu_guest *guest_fpu, u64 xfd) { }
+#endif
+
 extern void fpu_copy_guest_fpstate_to_uabi(struct fpu_guest *gfpu, void *buf, unsigned int size, u32 pkru);
 extern int fpu_copy_uabi_to_guest_fpstate(struct fpu_guest *gfpu, const void *buf, u64 xcr0, u32 *vpkru);
 
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 2560a95980aa..3daea097c618 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -288,6 +288,18 @@ int fpu_update_guest_perm_features(struct fpu_guest *guest_fpu)
 }
 EXPORT_SYMBOL_GPL(fpu_update_guest_perm_features);
 
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
