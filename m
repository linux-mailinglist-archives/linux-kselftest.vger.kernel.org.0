Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CB07E5DB7
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Nov 2023 20:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjKHTAj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 14:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbjKHTAb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 14:00:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8157D2137;
        Wed,  8 Nov 2023 11:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699470027; x=1731006027;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=owKcodjX01Nc+bGT/BhDGevJXqRWWYTr/t4Iq7+49FI=;
  b=E4Rkjg2JGvnRfyZPZE1d+gKxv04E9DhFHOYxXARkVjwuax0bjTctCPXp
   Qv3HcSwqge+YUHymqWGvjnmr+NnNX2N8po/ZtFECWXA5daR40oea1tX68
   4cUP1pxXXAaKjQ+/WCue8vsa5hM6VJ2b4ulq+v5Icjr86SOD/16F1v1HQ
   Rdr572cpodWtd1eE60l/aHDzLPXNByi7RDEYfy7fMAtVY3Kb7LCrb9nmd
   3l+1Sk3RSIP+FrmPE7OVSDta2YJ1qw0pl/1lhxzkjPNqDehAZlK5d0Boi
   p6wajhSu2Fc60lcCq7PH3hWTLlE7COMx9bRA6KRXTJnOuj5rC4NoFvojF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="8486433"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="8486433"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 11:00:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="10892503"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orviesa001.jf.intel.com with ESMTP; 08 Nov 2023 11:00:25 -0800
From:   Xin Li <xin3.li@intel.com>
To:     kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     seanjc@google.com, pbonzini@redhat.com, corbet@lwn.net,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, vkuznets@redhat.com, peterz@infradead.org,
        ravi.v.shankar@intel.com
Subject: [PATCH v1 19/23] KVM: x86: Allow FRED/LKGS/WRMSRNS to be exposed to guests
Date:   Wed,  8 Nov 2023 10:29:59 -0800
Message-ID: <20231108183003.5981-20-xin3.li@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108183003.5981-1-xin3.li@intel.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Allow FRED/LKGS/WRMSRNS to be exposed to guests, thus a guest OS could see
these features when the guest is configured with FRED/LKGS/WRMSRNS in Qemu.

A qemu patch is required to expose FRED/LKGS/WRMSRNS to KVM guests.

Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/kvm/cpuid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index dda6fc4cfae8..aa11b3e394ae 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -670,8 +670,8 @@ void kvm_set_cpu_caps(void)
 
 	kvm_cpu_cap_mask(CPUID_7_1_EAX,
 		F(AVX_VNNI) | F(AVX512_BF16) | F(CMPCCXADD) |
-		F(FZRM) | F(FSRS) | F(FSRC) |
-		F(AMX_FP16) | F(AVX_IFMA)
+		F(FZRM) | F(FSRS) | F(FSRC) | F(FRED) | F(LKGS) |
+		F(WRMSRNS) | F(AMX_FP16) | F(AVX_IFMA)
 	);
 
 	kvm_cpu_cap_init_kvm_defined(CPUID_7_1_EDX,
-- 
2.42.0

