Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD7547D207
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 13:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245140AbhLVMl3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Dec 2021 07:41:29 -0500
Received: from mga14.intel.com ([192.55.52.115]:11441 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240679AbhLVMlT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Dec 2021 07:41:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640176878; x=1671712878;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jYMa1Vw64gRNNrvnPgDt/R+8dlO71KNASf7tiONrC9A=;
  b=ZL+5KPyo3fAY9gJTbb/PgpdSwPF7XRhSu4wSyM7ydCBL+uIXKX12f+sK
   80sktDAwO6jSep+crx/UWhvDte3DOgOonDk3zzdRkVupNTyrKXyhxGUjz
   7MlL2mczQ8+83+KcG7sgVXL8jiPtHq4pdbvsjOz613pOrKxxdioSQsu8E
   bMRIFieXk/go/GYD9KFlnfoC9TbYWXdrrEgx7OEnU2LUvTIAsE8/SVNQp
   PVd0CPCja2PAohMXEM+anNmgp+Tn7BL9FRpINnV0VWLItR/Q4i3xZem5o
   FrrnDW+2hOr4bINGD5xOn+O+C54s6HVzZAvL5KwBTxoGBsmoiixpVD0lD
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240833428"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="240833428"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 04:41:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="587002767"
Received: from 984fee00a228.jf.intel.com ([10.165.56.59])
  by fmsmga004.fm.intel.com with ESMTP; 22 Dec 2021 04:41:05 -0800
From:   Jing Liu <jing2.liu@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org
Cc:     seanjc@google.com, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v3 16/22] kvm: x86: Add XCR0 support for Intel AMX
Date:   Wed, 22 Dec 2021 04:40:46 -0800
Message-Id: <20211222124052.644626-17-jing2.liu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211222124052.644626-1-jing2.liu@intel.com>
References: <20211222124052.644626-1-jing2.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Two XCR0 bits are defined for AMX to support XSAVE mechanism. Bit 17
is for tilecfg and bit 18 is for tiledata.

The value of XCR0[17:18] is always either 00b or 11b. Also, SDM
recommends that only 64-bit operating systems enable Intel AMX by
setting XCR0[18:17]. If a 32-bit guest tries to set dynamic bits, it
fails to pass vcpu->arch.guest_supported_xcr0 check and gets a #GP.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
---
 arch/x86/kvm/x86.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a48a89f73027..c558c098979a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -210,7 +210,7 @@ static struct kvm_user_return_msrs __percpu *user_return_msrs;
 #define KVM_SUPPORTED_XCR0     (XFEATURE_MASK_FP | XFEATURE_MASK_SSE \
 				| XFEATURE_MASK_YMM | XFEATURE_MASK_BNDREGS \
 				| XFEATURE_MASK_BNDCSR | XFEATURE_MASK_AVX512 \
-				| XFEATURE_MASK_PKRU)
+				| XFEATURE_MASK_PKRU | XFEATURE_MASK_XTILE)
 
 u64 __read_mostly host_efer;
 EXPORT_SYMBOL_GPL(host_efer);
@@ -990,6 +990,12 @@ static int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr)
 		if ((xcr0 & XFEATURE_MASK_AVX512) != XFEATURE_MASK_AVX512)
 			return 1;
 	}
+
+#ifdef CONFIG_X86_64
+	if ((xcr0 & XFEATURE_MASK_XTILE) &&
+	    ((xcr0 & XFEATURE_MASK_XTILE) != XFEATURE_MASK_XTILE))
+		return 1;
+#endif
 	vcpu->arch.xcr0 = xcr0;
 
 	if ((xcr0 ^ old_xcr0) & XFEATURE_MASK_EXTEND)
-- 
2.27.0

