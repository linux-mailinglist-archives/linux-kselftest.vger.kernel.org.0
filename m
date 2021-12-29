Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A13481328
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Dec 2021 14:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240175AbhL2NNq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Dec 2021 08:13:46 -0500
Received: from mga07.intel.com ([134.134.136.100]:28053 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240091AbhL2NNi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Dec 2021 08:13:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640783618; x=1672319618;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KnClT8w0CXQNI3rFhMClP/D9cRfj8jFwy+3mywffQfY=;
  b=SlHsGxKA+jK3JE5pE0UccvRthGsUKWc3WaU/F6Zrnl365soqtkly4RXD
   v/b6idIYqW6L6Jc8cfkOaYDiQtlmq0UYEkJvMaPVNopkW5YRLf4VrkvG6
   wlAsyJtXyZUmzO/+EDENf5q0Z46HS2iK2s8oV/yO5Y4c397h0cOOZC5Xk
   S+3raRQrXH0sZde5ZGErT+X2hagVxOe13iptgF5UUzAN4N8CrKiW/O75w
   q7hQ99AXCiV8KjsCqqTk88vNYU97CsQ/hIgOH/qFU1xNQqh3BuGO0zUcw
   Yjz99avG2JTgX0rhOrLINjfSzaU7SPCfPjpMTBct0QtD6CtadOHwUWbM5
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="304876122"
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="304876122"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 05:13:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="666281172"
Received: from 984fee00bf64.jf.intel.com ([10.165.54.77])
  by fmsmga001.fm.intel.com with ESMTP; 29 Dec 2021 05:13:35 -0800
From:   Yang Zhong <yang.zhong@intel.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org
Cc:     seanjc@google.com, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com, yang.zhong@intel.com
Subject: [PATCH v4 08/21] kvm: x86: Check and enable permitted dynamic xfeatures at KVM_SET_CPUID2
Date:   Wed, 29 Dec 2021 05:13:15 -0800
Message-Id: <20211229131328.12283-9-yang.zhong@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211229131328.12283-1-yang.zhong@intel.com>
References: <20211229131328.12283-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jing Liu <jing2.liu@intel.com>

Guest xstate permissions should be set by userspace VMM before vcpu
creation. Extend KVM_SET_CPUID2 to verify that every feature reported
in CPUID[0xD] has proper permission set. If permission allows, enable
all xfeatures in guest cpuid with fpstate buffer sized accordingly.

This avoids introducing new KVM exit reason for reporting permission
violation to userspace VMM at run-time and also removes the need of
tricky fpstate buffer expansion in the emulation and restore path of
XCR0 and IA32_XFD MSR.

Signed-off-by: Jing Liu <jing2.liu@intel.com>
Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 arch/x86/kvm/cpuid.c | 62 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 4855344091b8..acbc10db550e 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -81,9 +81,12 @@ static inline struct kvm_cpuid_entry2 *cpuid_entry2_find(
 	return NULL;
 }
 
-static int kvm_check_cpuid(struct kvm_cpuid_entry2 *entries, int nent)
+static int kvm_check_cpuid(struct kvm_vcpu *vcpu,
+			   struct kvm_cpuid_entry2 *entries,
+			   int nent)
 {
 	struct kvm_cpuid_entry2 *best;
+	int r = 0;
 
 	/*
 	 * The existing code assumes virtual address is 48-bit or 57-bit in the
@@ -93,11 +96,40 @@ static int kvm_check_cpuid(struct kvm_cpuid_entry2 *entries, int nent)
 	if (best) {
 		int vaddr_bits = (best->eax & 0xff00) >> 8;
 
-		if (vaddr_bits != 48 && vaddr_bits != 57 && vaddr_bits != 0)
-			return -EINVAL;
+		if (vaddr_bits != 48 && vaddr_bits != 57 && vaddr_bits != 0) {
+			r = -EINVAL;
+			goto out;
+		}
 	}
 
-	return 0;
+	/*
+	 * Check guest permissions for dynamically-enabled xfeatures.
+	 * Userspace VMM is expected to acquire permission before vCPU
+	 * creation. If permission allows, enable all xfeatures with
+	 * fpstate buffer sized accordingly. This avoids complexity of
+	 * run-time expansion in the emulation and restore path of XCR0
+	 * and IA32_XFD MSR.
+	 */
+	best = cpuid_entry2_find(entries, nent, 0xd, 0);
+	if (best) {
+		u64 xfeatures;
+
+		xfeatures = best->eax | ((u64)best->edx << 32);
+		if (xfeatures & ~vcpu->arch.guest_fpu.perm) {
+			r = -ENXIO;
+			goto out;
+		}
+
+		if (xfeatures != vcpu->arch.guest_fpu.xfeatures) {
+			r = fpu_update_guest_perm_features(
+						&vcpu->arch.guest_fpu);
+			if (r)
+				goto out;
+		}
+	}
+
+out:
+	return r;
 }
 
 static void kvm_update_kvm_cpuid_base(struct kvm_vcpu *vcpu)
@@ -277,21 +309,21 @@ u64 kvm_vcpu_reserved_gpa_bits_raw(struct kvm_vcpu *vcpu)
 static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
                         int nent)
 {
-    int r;
+	int r;
 
-    r = kvm_check_cpuid(e2, nent);
-    if (r)
-        return r;
+	r = kvm_check_cpuid(vcpu, e2, nent);
+	if (r)
+		return r;
 
-    kvfree(vcpu->arch.cpuid_entries);
-    vcpu->arch.cpuid_entries = e2;
-    vcpu->arch.cpuid_nent = nent;
+	kvfree(vcpu->arch.cpuid_entries);
+	vcpu->arch.cpuid_entries = e2;
+	vcpu->arch.cpuid_nent = nent;
 
-    kvm_update_kvm_cpuid_base(vcpu);
-    kvm_update_cpuid_runtime(vcpu);
-    kvm_vcpu_after_set_cpuid(vcpu);
+	kvm_update_kvm_cpuid_base(vcpu);
+	kvm_update_cpuid_runtime(vcpu);
+	kvm_vcpu_after_set_cpuid(vcpu);
 
-    return 0;
+	return 0;
 }
 
 /* when an old userspace process fills a new kernel module */
