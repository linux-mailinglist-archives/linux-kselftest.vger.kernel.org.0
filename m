Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACB10128727
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2019 05:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfLUErL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Dec 2019 23:47:11 -0500
Received: from mga03.intel.com ([134.134.136.65]:31827 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbfLUEp7 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Dec 2019 23:45:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2019 20:45:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,338,1571727600"; 
   d="scan'208";a="222620090"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by fmsmga001.fm.intel.com with ESMTP; 20 Dec 2019 20:45:58 -0800
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
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v5 08/19] x86/cpu: Clear VMX feature flag if VMX is not fully enabled
Date:   Fri, 20 Dec 2019 20:45:02 -0800
Message-Id: <20191221044513.21680-9-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191221044513.21680-1-sean.j.christopherson@intel.com>
References: <20191221044513.21680-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Now that IA32_FEAT_CTL is always configured and locked for CPUs that are
known to support VMX[*], clear the VMX capability flag if the MSR is
unsupported or BIOS disabled VMX, i.e. locked IA32_FEAT_CTL and didn't
set the appropriate VMX enable bit.

[*] Because init_ia32_feat_ctl() is called from vendors ->c_init(), it's
    still possible for IA32_FEAT_CTL to be left unlocked when VMX is
    supported by the CPU.  This is not fatal, and will be addressed in a
    future patch.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kernel/cpu/feat_ctl.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/feat_ctl.c b/arch/x86/kernel/cpu/feat_ctl.c
index c4f8f767853b..a46c9e46f937 100644
--- a/arch/x86/kernel/cpu/feat_ctl.c
+++ b/arch/x86/kernel/cpu/feat_ctl.c
@@ -5,15 +5,21 @@
 #include <asm/msr-index.h>
 #include <asm/processor.h>
 
+#undef pr_fmt
+#define pr_fmt(fmt)	"x86/cpu: " fmt
+
 void init_ia32_feat_ctl(struct cpuinfo_x86 *c)
 {
+	bool tboot = tboot_enabled();
 	u64 msr;
 
-	if (rdmsrl_safe(MSR_IA32_FEAT_CTL, &msr))
+	if (rdmsrl_safe(MSR_IA32_FEAT_CTL, &msr)) {
+		clear_cpu_cap(c, X86_FEATURE_VMX);
 		return;
+	}
 
 	if (msr & FEAT_CTL_LOCKED)
-		return;
+		goto update_caps;
 
 	/*
 	 * Ignore whatever value BIOS left in the MSR to avoid enabling random
@@ -29,9 +35,20 @@ void init_ia32_feat_ctl(struct cpuinfo_x86 *c)
 	if (cpu_has(c, X86_FEATURE_VMX) && IS_ENABLED(CONFIG_KVM_INTEL)) {
 		msr |= FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX;
 
-		if (tboot_enabled())
+		if (tboot)
 			msr |= FEAT_CTL_VMX_ENABLED_INSIDE_SMX;
 	}
 
 	wrmsrl(MSR_IA32_FEAT_CTL, msr);
+
+update_caps:
+	if (!cpu_has(c, X86_FEATURE_VMX))
+		return;
+
+	if ( (tboot && !(msr & FEAT_CTL_VMX_ENABLED_INSIDE_SMX)) ||
+	    (!tboot && !(msr & FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX))) {
+		pr_err_once("VMX (%s TXT) disabled by BIOS\n",
+			    tboot ? "inside" : "outside");
+		clear_cpu_cap(c, X86_FEATURE_VMX);
+	}
 }
-- 
2.24.1

