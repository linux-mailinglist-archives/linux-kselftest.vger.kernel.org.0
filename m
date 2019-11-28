Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E745510C1A2
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2019 02:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfK1Bl1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Nov 2019 20:41:27 -0500
Received: from mga02.intel.com ([134.134.136.20]:10954 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727724AbfK1BkY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Nov 2019 20:40:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2019 17:40:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,251,1571727600"; 
   d="scan'208";a="221166505"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
  by orsmga002.jf.intel.com with ESMTP; 27 Nov 2019 17:40:19 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tony Luck <tony.luck@intel.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        Len Brown <lenb@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v4 13/19] x86/cpufeatures: Add flag to track whether MSR IA32_FEAT_CTL is configured
Date:   Wed, 27 Nov 2019 17:40:10 -0800
Message-Id: <20191128014016.4389-14-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191128014016.4389-1-sean.j.christopherson@intel.com>
References: <20191128014016.4389-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a new feature flag, X86_FEATURE_MSR_IA32_FEAT_CTL, to track whether
IA32_FEAT_CTL has been initialized.  This will allow KVM, and any future
subsystems that depend on IA32_FEAT_CTL, to rely purely on cpufeatures
to query platform support, e.g. allows a future patch to remove KVM's
manual IA32_FEAT_CTL MSR checks.

Various features (on platforms that support IA32_FEAT_CTL) are dependent
on IA32_FEAT_CTL being configured and locked, e.g. VMX and LMCE.  The
MSR is always configured during boot, but only if the CPU vendor is
recognized by the kernel.  Because CPUID doesn't incorporate the current
IA32_FEAT_CTL value in its reporting of relevant features, it's possible
for a feature to be reported as supported in cpufeatures but not truly
enabled, e.g. if the CPU supports VMX but the kernel doesn't recognize
the CPU.

As a result, without the flag, KVM would see VMX as supported even if
IA32_FEAT_CTL hasn't been initialized, and so would need to manually
read the MSR and check the various enabling bits to avoid taking an
unexpected #GP on VMXON.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---

I tried darn hard to avoid this patch, but couldn't come up with a less
crappy alternative.  Arguably, letting KVM #GP in the above scenario is
acceptable because it means the user is doing something silly.  But, KVM
currently handles this scenario gracefully, and I think we'll have the
same conundrum for SGX.  Requiring KVM and SGX to check the MSR sort of
defeats the purpose of this series.

Another option I thought of was to call init_ia32_feat_ctl() from common
code, but that would mean taking a #GP on the RDMSR on AMD and company,
which seems far worse than adding a synthetic feature flag.

The last option I tried was to clear the VMX flag in default_init(), but
then we'd have to do the same for SGX and any other new features that get
dumped into IA32_FEAT_CTL, which again seems worse than adding a synthetic
flag.

 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/feat_ctl.c     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index e9b62498fe75..67d21b25ff78 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -220,6 +220,7 @@
 #define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU is AMD family 0x17 (Zen) */
 #define X86_FEATURE_L1TF_PTEINV		( 7*32+29) /* "" L1TF workaround PTE inversion */
 #define X86_FEATURE_IBRS_ENHANCED	( 7*32+30) /* Enhanced IBRS */
+#define X86_FEATURE_MSR_IA32_FEAT_CTL	( 7*32+31) /* "" MSR IA32_FEAT_CTL configured */
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* Intel TPR Shadow */
diff --git a/arch/x86/kernel/cpu/feat_ctl.c b/arch/x86/kernel/cpu/feat_ctl.c
index 9435d82be623..c3782c13c3f9 100644
--- a/arch/x86/kernel/cpu/feat_ctl.c
+++ b/arch/x86/kernel/cpu/feat_ctl.c
@@ -122,6 +122,8 @@ void init_ia32_feat_ctl(struct cpuinfo_x86 *c)
 	wrmsrl(MSR_IA32_FEAT_CTL, msr);
 
 update_caps:
+	set_cpu_cap(c, X86_FEATURE_MSR_IA32_FEAT_CTL);
+
 	if (!cpu_has(c, X86_FEATURE_VMX))
 		return;
 
-- 
2.24.0

