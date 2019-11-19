Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 134561011AD
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2019 04:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfKSDM4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Nov 2019 22:12:56 -0500
Received: from mga02.intel.com ([134.134.136.20]:21246 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727590AbfKSDM4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Nov 2019 22:12:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 19:12:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,322,1569308400"; 
   d="scan'208";a="218105727"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
  by orsmga002.jf.intel.com with ESMTP; 18 Nov 2019 19:12:42 -0800
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
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v3 09/19] x86/cpu: Clear VMX feature flag if VMX is not fully enabled
Date:   Mon, 18 Nov 2019 19:12:30 -0800
Message-Id: <20191119031240.7779-10-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119031240.7779-1-sean.j.christopherson@intel.com>
References: <20191119031240.7779-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Now that the IA32_FEATURE_CONTROL MSR is guaranteed to be configured and
locked, clear the VMX capability flag if the IA32_FEATURE_CONTROL MSR is
not supported or if BIOS disabled VMX, i.e. locked IA32_FEATURE_CONTROL
and did not set the appropriate VMX enable bit.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kernel/cpu/feature_control.c | 28 ++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/feature_control.c b/arch/x86/kernel/cpu/feature_control.c
index 33c9444dda52..2bd1a9e6021a 100644
--- a/arch/x86/kernel/cpu/feature_control.c
+++ b/arch/x86/kernel/cpu/feature_control.c
@@ -5,15 +5,26 @@
 #include <asm/msr-index.h>
 #include <asm/processor.h>
 
+#undef pr_fmt
+#define pr_fmt(fmt)	"x86/cpu: " fmt
+
+#define FEAT_CTL_UNSUPPORTED_MSG "IA32_FEATURE_CONTROL MSR unsupported on VMX capable CPU, suspected hardware or hypervisor issue.\n"
+
 void init_feature_control_msr(struct cpuinfo_x86 *c)
 {
+	bool tboot = tboot_enabled();
 	u64 msr;
 
-	if (rdmsrl_safe(MSR_IA32_FEATURE_CONTROL, &msr))
+	if (rdmsrl_safe(MSR_IA32_FEATURE_CONTROL, &msr)) {
+		if (cpu_has(c, X86_FEATURE_VMX)) {
+			pr_err_once(FEAT_CTL_UNSUPPORTED_MSG);
+			clear_cpu_cap(c, X86_FEATURE_VMX);
+		}
 		return;
+	}
 
 	if (msr & FEAT_CTL_LOCKED)
-		return;
+		goto update_caps;
 
 	/*
 	 * Ignore whatever value BIOS left in the MSR to avoid enabling random
@@ -28,8 +39,19 @@ void init_feature_control_msr(struct cpuinfo_x86 *c)
 	 */
 	if (cpu_has(c, X86_FEATURE_VMX) && IS_ENABLED(CONFIG_KVM)) {
 		msr |= FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX;
-		if (tboot_enabled())
+		if (tboot)
 			msr |= FEAT_CTL_VMX_ENABLED_INSIDE_SMX;
 	}
 	wrmsrl(MSR_IA32_FEATURE_CONTROL, msr);
+
+update_caps:
+	if (!cpu_has(c, X86_FEATURE_VMX))
+		return;
+
+	if ((tboot && !(msr & FEAT_CTL_VMX_ENABLED_INSIDE_SMX)) ||
+	    (!tboot && !(msr & FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX))) {
+		pr_err_once("VMX (%s TXT) disabled by BIOS\n",
+			    tboot ? "inside" : "outside");
+		clear_cpu_cap(c, X86_FEATURE_VMX);
+	}
 }
-- 
2.24.0

