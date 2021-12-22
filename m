Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4048C47D1E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 13:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244952AbhLVMk7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Dec 2021 07:40:59 -0500
Received: from mga14.intel.com ([192.55.52.115]:11431 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244934AbhLVMk4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Dec 2021 07:40:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640176855; x=1671712855;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/l/lzu8ovCU50omqsIU1bkVibRLaW4dJhOXZM0Wu658=;
  b=kcHsJjVr9QGHEFlF3Z81WCUPkOOQVs2CT12iJ4hp1QSMsKnLURLcvHUk
   SNcTGQTF0jTKiaTcXNbErak+ACB9FXLSfY6vJyVT31LU9WwnVsVm50wqX
   /7iLkEXZIti8m1rAHvNel1PaOJbAi7nY9VvmcvS8wVoVtYGkT+1tTusi5
   n6verxne/LWMyy8h2XlYUiVq2qubGFhXhNZidb/uAU/OsSduybE+J2h7O
   XPvoKwLfQ9jYi3J/gp7QVQB7EcdWU78tXPCMQDCCXStfuz/FgPrt1Sqwd
   BKnvjK+OBeQB57iYLwlKjUmChjcvkD0SdVHd7shTSQAylwDy061Ajdnai
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240833406"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="240833406"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 04:40:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="587002705"
Received: from 984fee00a228.jf.intel.com ([10.165.56.59])
  by fmsmga004.fm.intel.com with ESMTP; 22 Dec 2021 04:40:54 -0800
From:   Jing Liu <jing2.liu@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org
Cc:     seanjc@google.com, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v3 03/22] kvm: x86: Fix xstate_required_size() to follow XSTATE alignment rule
Date:   Wed, 22 Dec 2021 04:40:33 -0800
Message-Id: <20211222124052.644626-4-jing2.liu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211222124052.644626-1-jing2.liu@intel.com>
References: <20211222124052.644626-1-jing2.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

CPUID.0xD.1.EBX enumerates the size of the XSAVE area (in compacted
format) required by XSAVES. If CPUID.0xD.i.ECX[1] is set for a state
component (i), this state component should be located on the next
64-bytes boundary following the preceding state component in the
compacted layout.

Fix xstate_required_size() to follow the alignment rule. AMX is the
first state component with 64-bytes alignment to catch this bug.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
---
 arch/x86/kvm/cpuid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 07e9215e911d..148003e26cbb 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -42,7 +42,8 @@ static u32 xstate_required_size(u64 xstate_bv, bool compacted)
 		if (xstate_bv & 0x1) {
 		        u32 eax, ebx, ecx, edx, offset;
 		        cpuid_count(0xD, feature_bit, &eax, &ebx, &ecx, &edx);
-			offset = compacted ? ret : ebx;
+			/* ECX[1]: 64B alignment in compacted form */
+			offset = compacted ? ((ecx & 0x2) ? ALIGN(ret, 64) : ret) : ebx;
 			ret = max(ret, offset + eax);
 		}
 
-- 
2.27.0

