Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38AE147D236
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 13:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245047AbhLVMm2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Dec 2021 07:42:28 -0500
Received: from mga14.intel.com ([192.55.52.115]:11439 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244957AbhLVMlA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Dec 2021 07:41:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640176860; x=1671712860;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hmd3JMrGuvPk8nW+50F0FEqWA4XJ5Ir3VcVEv3+Cyrg=;
  b=SHEI1c4/j4sFtURN2JEubUu09O0Jqi3ra2NLR6LtJwIHI+cigMaiTlO9
   45OcWvB/BzKC3zHnBeUoV2xpgJA/h/VICgFYWwrs0caF8Be/NDM58di0B
   pCbZDlHZwDwWvd4yP87OipnvfWDhGeEOxf41uf0Em++SDb9wzRAkDPpQN
   GrYRNQZSKzdtMzQgiCjk+i1ZGTC2gl/MA6m8fwE6LGsW4vK3DI9BtetZJ
   HzzcbteECmD2+KIoZaMvOgbT/NXmBvSzWjoc5p8zOU0JjKmMBs0UKZvlI
   UkPUPAwc/nfHWqLgUYOMjzarDeYJObSNZXDQ6g2w9237O5rEvYq7Jx2Yk
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240833412"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="240833412"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 04:40:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="587002728"
Received: from 984fee00a228.jf.intel.com ([10.165.56.59])
  by fmsmga004.fm.intel.com with ESMTP; 22 Dec 2021 04:40:59 -0800
From:   Jing Liu <jing2.liu@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org
Cc:     seanjc@google.com, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v3 08/22] x86/fpu: Provide fpu_update_guest_perm_features() for guest
Date:   Wed, 22 Dec 2021 04:40:38 -0800
Message-Id: <20211222124052.644626-9-jing2.liu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211222124052.644626-1-jing2.liu@intel.com>
References: <20211222124052.644626-1-jing2.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Kevin Tian <kevin.tian@intel.com>

KVM can require fpstate expansion in two approaches:

  1) Dynamic expansion when intercepting guest updates to XCR0 and
     XFD MSR;

  2) Static expansion e.g. at KVM_SET_CPUID2;

The first option doesn't waste memory for legacy guest if it doesn't
support XFD. However doing so introduces more complexity and also
imposes an order requirement in the restoring path, i.e. XCR0/XFD
must be restored before XSTATE.

Given that the agreement is to do the static approach. This is
considered a better tradeoff though it does waste 8K memory for
legacy guest if its CPUID includes XFD features.

Provide a wrapper to allow expanding the fpstate buffer to what
guest perm allows. Once completed, both emulation and restore path
don't need to worry about the buffer size.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/fpu/api.h |  1 +
 arch/x86/kernel/fpu/core.c     | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index d8c222290e68..8e934e571273 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -138,6 +138,7 @@ extern inline u64 xstate_get_guest_group_perm(void);
 extern bool fpu_alloc_guest_fpstate(struct fpu_guest *gfpu);
 extern void fpu_free_guest_fpstate(struct fpu_guest *gfpu);
 extern int fpu_swap_kvm_fpstate(struct fpu_guest *gfpu, bool enter_guest);
+extern int fpu_update_guest_perm_features(struct fpu_guest *guest_fpu);
 
 extern void fpu_copy_guest_fpstate_to_uabi(struct fpu_guest *gfpu, void *buf, unsigned int size, u32 pkru);
 extern int fpu_copy_uabi_to_guest_fpstate(struct fpu_guest *gfpu, const void *buf, u64 xcr0, u32 *vpkru);
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index a78bc547fc03..2560a95980aa 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -261,6 +261,33 @@ void fpu_free_guest_fpstate(struct fpu_guest *gfpu)
 }
 EXPORT_SYMBOL_GPL(fpu_free_guest_fpstate);
 
+/*
+ * fpu_update_guest_perm_features - Enable xfeatures according to guest perm
+ * @guest_fpu:		Pointer to the guest FPU container
+ *
+ * Enable all dynamic xfeatures according to guest perm. Invoked if the
+ * caller wants to conservatively expand fpstate buffer instead of waiting
+ * until XCR0 or XFD MSR is written.
+ *
+ * Return: 0 on success, error code otherwise
+ */
+int fpu_update_guest_perm_features(struct fpu_guest *guest_fpu)
+{
+	u64 expand;
+
+	lockdep_assert_preemption_enabled();
+
+	if (!IS_ENABLED(CONFIG_X86_64))
+		return 0;
+
+	expand = guest_fpu->perm & ~guest_fpu->xfeatures;
+	if (!expand)
+		return 0;
+
+	return __xfd_enable_feature(expand, guest_fpu);
+}
+EXPORT_SYMBOL_GPL(fpu_update_guest_perm_features);
+
 int fpu_swap_kvm_fpstate(struct fpu_guest *guest_fpu, bool enter_guest)
 {
 	struct fpstate *guest_fps = guest_fpu->fpstate;
-- 
2.27.0

