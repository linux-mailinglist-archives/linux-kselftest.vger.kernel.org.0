Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E184852D6
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jan 2022 13:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240459AbiAEMhI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jan 2022 07:37:08 -0500
Received: from mga04.intel.com ([192.55.52.120]:6467 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240107AbiAEMgK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jan 2022 07:36:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641386170; x=1672922170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=okbqEE/cMu2JIDE4CqUwUoYRxSF6sf5mcfpLLkmKBaE=;
  b=cE3KtT2xYIHOL+rIrJN3YDJ23VgICXn+Oan5qhMTT8DbUrOCCaXz4S2H
   /UEk37BMf5yCanfn37BEceSVRlAVqpkx4C8M4ld+QevcE8KCNb8UV1CRV
   35QtwMG6njx8X8/ratg22P5LNDHMxT5L1oW9TEKkJUmk/ADVhNPwFBUl/
   MLw1XW0qKZ9pbuWl8PmxIEt6SiQ6BrvD0wiq02snFgmhwGBThyHRSvSh3
   /Xy2A0itwDrd8abUtYdjWFEf+bKwV09Dg37GcKO3Tw5SxW5+ejeEfjlIr
   4h4hhb/u3IIF7MMbjTtt/Mqzrw2hfM1iHBuB+1Vp2e0vszG8IYRZnDdUA
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="241249370"
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="241249370"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 04:35:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="591004838"
Received: from 984fee00bf64.jf.intel.com ([10.165.54.77])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jan 2022 04:35:36 -0800
From:   Yang Zhong <yang.zhong@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org, seanjc@google.com
Cc:     jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v5 07/21] x86/fpu: Provide fpu_enable_guest_xfd_features() for KVM
Date:   Wed,  5 Jan 2022 04:35:18 -0800
Message-Id: <20220105123532.12586-8-yang.zhong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220105123532.12586-1-yang.zhong@intel.com>
References: <20220105123532.12586-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Sean Christopherson <seanjc@google.com>

Provide a wrapper for expanding the guest fpstate buffer according
to requested xfeatures. KVM wants to call this wrapper to manage
any dynamic xstate used by the guest.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 arch/x86/include/asm/fpu/api.h |  1 +
 arch/x86/kernel/fpu/core.c     | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index d8c222290e68..1ed2a247a84e 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -138,6 +138,7 @@ extern inline u64 xstate_get_guest_group_perm(void);
 extern bool fpu_alloc_guest_fpstate(struct fpu_guest *gfpu);
 extern void fpu_free_guest_fpstate(struct fpu_guest *gfpu);
 extern int fpu_swap_kvm_fpstate(struct fpu_guest *gfpu, bool enter_guest);
+extern int fpu_enable_guest_xfd_features(struct fpu_guest *guest_fpu, u64 xfeatures);
 
 extern void fpu_copy_guest_fpstate_to_uabi(struct fpu_guest *gfpu, void *buf, unsigned int size, u32 pkru);
 extern int fpu_copy_uabi_to_guest_fpstate(struct fpu_guest *gfpu, const void *buf, u64 xcr0, u32 *vpkru);
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index a78bc547fc03..5b08d20a4005 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -261,6 +261,23 @@ void fpu_free_guest_fpstate(struct fpu_guest *gfpu)
 }
 EXPORT_SYMBOL_GPL(fpu_free_guest_fpstate);
 
+int fpu_enable_guest_xfd_features(struct fpu_guest *guest_fpu, u64 xfeatures)
+{
+	lockdep_assert_preemption_enabled();
+
+	/* Nothing to do if all requested features are already enabled. */
+	xfeatures &= ~guest_fpu->xfeatures;
+	if (!xfeatures)
+		return 0;
+
+	/* Dynamic xfeatures are not supported with 32-bit kernels. */
+	if (!IS_ENABLED(CONFIG_X86_64))
+		return 0;
+
+	return __xfd_enable_feature(xfeatures, guest_fpu);
+}
+EXPORT_SYMBOL_GPL(fpu_enable_guest_xfd_features);
+
 int fpu_swap_kvm_fpstate(struct fpu_guest *guest_fpu, bool enter_guest)
 {
 	struct fpstate *guest_fps = guest_fpu->fpstate;
