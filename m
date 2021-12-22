Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E3047D1EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 13:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244991AbhLVMlD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Dec 2021 07:41:03 -0500
Received: from mga14.intel.com ([192.55.52.115]:11431 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244942AbhLVMk4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Dec 2021 07:40:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640176856; x=1671712856;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LPHOJNcJOVDQ0nYxMFW72nlmZ9GdEfRTxGjhRqIVxKw=;
  b=UWDMfwK3rnD5Bqd4EhgC3apYSKxYamNZ2OdJYwCQJ/M3GtqaVtGeojZ1
   b/nIMyphAc9OxgLKQbNQMky5pr1PvcreXKLDDOaJhmGz0VGow9tdDaCw4
   ojFFfiPogxMy2dRBtjlVE+4OxL02PZDs8kh9vwv5a5jsfcFnz1WpxJTUT
   MAPOpT+9D0r0TIpRv1BK2JuXIHmGZ12cC4di2DA05C15oFbPbUkwP+VqZ
   aSaGDu3rPa/nCeJQKyH7YiYfpHBvkMFtyTvWbOyuRTYAOwrrKyhEOVC5m
   e6wC/0w+OBKyO+XryaNqW5q3Skw8qLxwg4ctw/uoku4LmhiuUls54x0u4
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240833407"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="240833407"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 04:40:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="587002711"
Received: from 984fee00a228.jf.intel.com ([10.165.56.59])
  by fmsmga004.fm.intel.com with ESMTP; 22 Dec 2021 04:40:55 -0800
From:   Jing Liu <jing2.liu@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org
Cc:     seanjc@google.com, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v3 04/22] kvm: x86: Exclude unpermitted xfeatures at KVM_GET_SUPPORTED_CPUID
Date:   Wed, 22 Dec 2021 04:40:34 -0800
Message-Id: <20211222124052.644626-5-jing2.liu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211222124052.644626-1-jing2.liu@intel.com>
References: <20211222124052.644626-1-jing2.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

KVM_GET_SUPPORTED_CPUID should not include any dynamic xstates in
CPUID[0xD] if they have not been requested with prctl. Otherwise
a process which directly passes KVM_GET_SUPPORTED_CPUID to
KVM_SET_CPUID2 would now fail even if it doesn't intend to use a
dynamically enabled feature. Userspace must know that prctl is
required and allocate >4K xstate buffer before setting any dynamic
bit.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
---
 Documentation/virt/kvm/api.rst | 4 ++++
 arch/x86/kvm/cpuid.c           | 9 ++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index aeeb071c7688..1cf2483246cd 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -1684,6 +1684,10 @@ userspace capabilities, and with user requirements (for example, the
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
index 148003e26cbb..4855344091b8 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -812,11 +812,13 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
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
 
@@ -863,6 +865,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 			entry->edx = 0;
 		}
 		break;
+	}
 	case 0x12:
 		/* Intel SGX */
 		if (!kvm_cpu_cap_has(X86_FEATURE_SGX)) {
-- 
2.27.0

