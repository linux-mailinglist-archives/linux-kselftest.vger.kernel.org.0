Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE77347D220
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 13:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240773AbhLVMmA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Dec 2021 07:42:00 -0500
Received: from mga14.intel.com ([192.55.52.115]:11441 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244951AbhLVMlC (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Dec 2021 07:41:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640176862; x=1671712862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k8gT9oB/5YPUMem/eqQOfbKkI8IytJEMqRnBB5pWAb0=;
  b=jt0PEpTOTWzew63wSTuhHKfmTttBYB8B7RROeQaiIag/HCrBxqAGZD3X
   3COn3yjSJIrSnLmGi+YGB0g4u1pfUi3iO7+qzQJyl7/SiRIj3UoxHzezd
   o5gaY1+li0+lhoZN6G9ZweZIoJmj2w8kyrQbfAtPp6uJjDvd7CV9zmwOA
   wttZQPJVJ1WHCfEJl0yGq9lQ0OkTeoPz6hisrAvOiNlOeu2ZhXWbCP/+o
   3jT9lGPNFKRyWLrNAjj7qMNiCbRxnhQtFNBTivq/TVs5BZ7Fqfm0ji48C
   8QTmOPag9LTnig1MuyUdwVOvbOMR2cW6J4FbwA4PJtfp/j+aExSNO1fc+
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240833415"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="240833415"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 04:41:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="587002735"
Received: from 984fee00a228.jf.intel.com ([10.165.56.59])
  by fmsmga004.fm.intel.com with ESMTP; 22 Dec 2021 04:41:00 -0800
From:   Jing Liu <jing2.liu@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org
Cc:     seanjc@google.com, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v3 10/22] x86/fpu: Provide fpu_update_guest_xfd() for IA32_XFD emulation
Date:   Wed, 22 Dec 2021 04:40:40 -0800
Message-Id: <20211222124052.644626-11-jing2.liu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211222124052.644626-1-jing2.liu@intel.com>
References: <20211222124052.644626-1-jing2.liu@intel.com>
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
-- 
2.27.0

