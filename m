Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEB04852B3
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jan 2022 13:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240184AbiAEMgT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jan 2022 07:36:19 -0500
Received: from mga04.intel.com ([192.55.52.120]:6467 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240124AbiAEMgL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jan 2022 07:36:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641386171; x=1672922171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6XGEF09iaJJizD+ujGZgf1ul6fJRMqZsLGNZt5cjLRw=;
  b=mIa9zfAOCD2CpbgWw9CdUGECtexXMjmZXgt1L6ky/8TRCjC3TxwYy+cv
   VLykWQ6+cQGHfoYHq29feGtBP8TcfpnMu5QTqKGunjJ9MmeHkzUR1jQ2p
   By7RI4uYqW4TvYEcXF0rGupqw8EVK9ZxkhhNmsk/g97+mZgpmLCdmdK2I
   dreIdjgvETkSPHjh461VTeIPKLVbT8jcjvOnp/bBiG7197oFHUvNduQO7
   07gaYJsc6RsuVM8SMozWUhQ/MDvYdwrSBfKoL8ZTylMdBWzmAnPacot1u
   Vu6dh4jCujojw5OJ4qMgbnGyVpdceHgMvlWwnV2aQVSeizUhw+pQHh972
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="241249385"
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="241249385"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 04:35:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="591004877"
Received: from 984fee00bf64.jf.intel.com ([10.165.54.77])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jan 2022 04:35:40 -0800
From:   Yang Zhong <yang.zhong@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org, seanjc@google.com
Cc:     jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v5 15/21] kvm: x86: Add XCR0 support for Intel AMX
Date:   Wed,  5 Jan 2022 04:35:26 -0800
Message-Id: <20220105123532.12586-16-yang.zhong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220105123532.12586-1-yang.zhong@intel.com>
References: <20220105123532.12586-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jing Liu <jing2.liu@intel.com>

Two XCR0 bits are defined for AMX to support XSAVE mechanism. Bit 17
is for tilecfg and bit 18 is for tiledata.

The value of XCR0[17:18] is always either 00b or 11b. Also, SDM
recommends that only 64-bit operating systems enable Intel AMX by
setting XCR0[18:17]. 32-bit host kernel never sets the tile bits in
vcpu->arch.guest_supported_xcr0.

Signed-off-by: Jing Liu <jing2.liu@intel.com>
Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 arch/x86/kvm/x86.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 434986928552..553e4af12edc 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -211,7 +211,7 @@ static struct kvm_user_return_msrs __percpu *user_return_msrs;
 #define KVM_SUPPORTED_XCR0     (XFEATURE_MASK_FP | XFEATURE_MASK_SSE \
 				| XFEATURE_MASK_YMM | XFEATURE_MASK_BNDREGS \
 				| XFEATURE_MASK_BNDCSR | XFEATURE_MASK_AVX512 \
-				| XFEATURE_MASK_PKRU)
+				| XFEATURE_MASK_PKRU | XFEATURE_MASK_XTILE)
 
 u64 __read_mostly host_efer;
 EXPORT_SYMBOL_GPL(host_efer);
@@ -1010,6 +1010,11 @@ static int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr)
 		if ((xcr0 & XFEATURE_MASK_AVX512) != XFEATURE_MASK_AVX512)
 			return 1;
 	}
+
+	if ((xcr0 & XFEATURE_MASK_XTILE) &&
+	    ((xcr0 & XFEATURE_MASK_XTILE) != XFEATURE_MASK_XTILE))
+		return 1;
+
 	vcpu->arch.xcr0 = xcr0;
 
 	if ((xcr0 ^ old_xcr0) & XFEATURE_MASK_EXTEND)
