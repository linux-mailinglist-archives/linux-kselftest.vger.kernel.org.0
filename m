Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3444852DD
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jan 2022 13:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236760AbiAEMhQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jan 2022 07:37:16 -0500
Received: from mga04.intel.com ([192.55.52.120]:6467 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236633AbiAEMgG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jan 2022 07:36:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641386166; x=1672922166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4Km+1u8gv0GrnaFADo3akRB9aJiL4ECFCOJMGCFW73g=;
  b=J6o35RFFkUize287CCXJjO3NsuVVldUYvvsqjgS4Fq+sP8qcRWiP5+0e
   rW2eNemPAfdDp91kFPBXaIho80yudTfsqleD/WtSgJeJAUqJKaXFYewLA
   gvyNr5Yxw2qMhsrrtiZ1hPEejVmc/791icv3pP1s16MDQuaaHeY6/f/Um
   KPWykoSdOmrXDIrqfgvZv6UDiC1c2ApXIcardnvtjLrXmbZ1GcVDXrhpk
   J0WcRpvcbhCSK6SJMpQ6kAkWWMNvxP9LlcFXUaV1lDzWEbIPSQMy8/sh2
   gwZz/OnD7rhHJd5k8j9BKV7YukQolgDBcJ8/DLjp3ns6Cl9Tuosnk7Hr4
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="241249362"
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="241249362"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 04:35:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="591004819"
Received: from 984fee00bf64.jf.intel.com ([10.165.54.77])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jan 2022 04:35:34 -0800
From:   Yang Zhong <yang.zhong@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org, seanjc@google.com
Cc:     jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v5 04/21] kvm: x86: Exclude unpermitted xfeatures at KVM_GET_SUPPORTED_CPUID
Date:   Wed,  5 Jan 2022 04:35:15 -0800
Message-Id: <20220105123532.12586-5-yang.zhong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220105123532.12586-1-yang.zhong@intel.com>
References: <20220105123532.12586-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jing Liu <jing2.liu@intel.com>

KVM_GET_SUPPORTED_CPUID should not include any dynamic xstates in
CPUID[0xD] if they have not been requested with prctl. Otherwise
a process which directly passes KVM_GET_SUPPORTED_CPUID to
KVM_SET_CPUID2 would now fail even if it doesn't intend to use a
dynamically enabled feature. Userspace must know that prctl is
required and allocate >4K xstate buffer before setting any dynamic
bit.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 Documentation/virt/kvm/api.rst | 4 ++++
 arch/x86/kvm/cpuid.c           | 9 ++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 6b683dfea8f2..f4ea5e41a4d0 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -1687,6 +1687,10 @@ userspace capabilities, and with user requirements (for example, the
 user may wish to constrain cpuid to emulate older hardware, or for
 feature consistency across a cluster).
 
+Dynamically-enabled feature bits need to be requested with
+``arch_prctl()`` before calling this ioctl. Feature bits that have not
+been requested are excluded from the result.
+
 Note that certain capabilities, such as KVM_CAP_X86_DISABLE_EXITS, may
 expose cpuid features (e.g. MONITOR) which are not supported by kvm in
 its default configuration. If userspace enables such capabilities, it
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index f3e6fda6b858..eb52dde5deec 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -815,11 +815,13 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 				goto out;
 		}
 		break;
-	case 0xd:
-		entry->eax &= supported_xcr0;
+	case 0xd: {
+		u64 guest_perm = xstate_get_guest_group_perm();
+
+		entry->eax &= supported_xcr0 & guest_perm;
 		entry->ebx = xstate_required_size(supported_xcr0, false);
 		entry->ecx = entry->ebx;
-		entry->edx &= supported_xcr0 >> 32;
+		entry->edx &= (supported_xcr0 & guest_perm) >> 32;
 		if (!supported_xcr0)
 			break;
 
@@ -866,6 +868,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 			entry->edx = 0;
 		}
 		break;
+	}
 	case 0x12:
 		/* Intel SGX */
 		if (!kvm_cpu_cap_has(X86_FEATURE_SGX)) {
