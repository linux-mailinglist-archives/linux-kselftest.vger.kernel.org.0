Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692FF481353
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Dec 2021 14:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240241AbhL2NPD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Dec 2021 08:15:03 -0500
Received: from mga07.intel.com ([134.134.136.100]:28047 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240101AbhL2NOV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Dec 2021 08:14:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640783661; x=1672319661;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l+unk1SjgYvBRWnT75U63PDCsoOq0XBUMRh0enPT5Z0=;
  b=EDn0ANklK71YitG2SKnKTGvhYgLL7lmlf6hhftAO+ZYHeH9XLxGhndWM
   JEGXx4NzsgzTVzIBzRwYuySSUmC1ha0WsMtBxNWiFtgiNMDneKQCHv3BM
   kA0DTG90mC2MsxPLlwP7ldbDiEn5Oxhx5ztTQGZqCKUeq6yFKbDMMJgsF
   BNOUB4E9Rb03aQq/YRQ70xyU4+SmVGTKwoIUWOdmBdOCeKo6R6afo4Z/3
   rfQo8vmumIYrY5iZnkbwABQ8nQ0CEjRZ7d901G1iiKKOEpVTaWbNkDete
   0ZGeg3O/PNT/iDkTaDtghmgPtT7H9WHWvkcWks1kmy8bZk0HzaqEJpg3b
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="304876150"
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="304876150"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 05:13:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="666281204"
Received: from 984fee00bf64.jf.intel.com ([10.165.54.77])
  by fmsmga001.fm.intel.com with ESMTP; 29 Dec 2021 05:13:40 -0800
From:   Yang Zhong <yang.zhong@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org
Cc:     seanjc@google.com, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v4 15/21] kvm: x86: Add XCR0 support for Intel AMX
Date:   Wed, 29 Dec 2021 05:13:22 -0800
Message-Id: <20211229131328.12283-16-yang.zhong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211229131328.12283-1-yang.zhong@intel.com>
References: <20211229131328.12283-1-yang.zhong@intel.com>
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
index a48a89f73027..bdf89c28d2ce 100644
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
@@ -990,6 +990,11 @@ static int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr)
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
