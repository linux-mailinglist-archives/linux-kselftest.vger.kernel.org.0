Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33DF3128733
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2019 05:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfLUEp5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Dec 2019 23:45:57 -0500
Received: from mga03.intel.com ([134.134.136.65]:31827 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbfLUEpz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Dec 2019 23:45:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2019 20:45:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,338,1571727600"; 
   d="scan'208";a="222620067"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.202])
  by fmsmga001.fm.intel.com with ESMTP; 20 Dec 2019 20:45:53 -0800
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
Subject: [PATCH v5 03/19] tools arch x86: Sync msr-index.h from kernel sources
Date:   Fri, 20 Dec 2019 20:44:57 -0800
Message-Id: <20191221044513.21680-4-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191221044513.21680-1-sean.j.christopherson@intel.com>
References: <20191221044513.21680-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Sync msr-index.h to pull in recent renames of the IA32_FEATURE_CONTROL
MSR definitions.  Update KVM's VMX selftest and turbostat accordingly.
Keep the full name in turbostat's output to avoid breaking someone's
workflow, e.g. if a script is looking for the full name.

While using the renamed defines is by no means necessary, do the sync
now to avoid leaving a landmine that will get stepped on the next time
msr-index.h needs to be refreshed for some other reason.

No functional change intended.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 tools/arch/x86/include/asm/msr-index.h       | 14 ++++++++------
 tools/power/x86/turbostat/turbostat.c        |  4 ++--
 tools/testing/selftests/kvm/lib/x86_64/vmx.c |  8 ++++----
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 084e98da04a7..ebe1685e92dd 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -558,7 +558,14 @@
 #define MSR_IA32_EBL_CR_POWERON		0x0000002a
 #define MSR_EBC_FREQUENCY_ID		0x0000002c
 #define MSR_SMI_COUNT			0x00000034
-#define MSR_IA32_FEATURE_CONTROL        0x0000003a
+
+/* Referred to as IA32_FEATURE_CONTROL in Intel's SDM. */
+#define MSR_IA32_FEAT_CTL		0x0000003a
+#define FEAT_CTL_LOCKED				BIT(0)
+#define FEAT_CTL_VMX_ENABLED_INSIDE_SMX		BIT(1)
+#define FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX	BIT(2)
+#define FEAT_CTL_LMCE_ENABLED			BIT(20)
+
 #define MSR_IA32_TSC_ADJUST             0x0000003b
 #define MSR_IA32_BNDCFGS		0x00000d90
 
@@ -566,11 +573,6 @@
 
 #define MSR_IA32_XSS			0x00000da0
 
-#define FEATURE_CONTROL_LOCKED				(1<<0)
-#define FEATURE_CONTROL_VMXON_ENABLED_INSIDE_SMX	(1<<1)
-#define FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX	(1<<2)
-#define FEATURE_CONTROL_LMCE				(1<<20)
-
 #define MSR_IA32_APICBASE		0x0000001b
 #define MSR_IA32_APICBASE_BSP		(1<<8)
 #define MSR_IA32_APICBASE_ENABLE	(1<<11)
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 5d0fddda842c..31c1ca0bb3ee 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4499,10 +4499,10 @@ void decode_feature_control_msr(void)
 {
 	unsigned long long msr;
 
-	if (!get_msr(base_cpu, MSR_IA32_FEATURE_CONTROL, &msr))
+	if (!get_msr(base_cpu, MSR_IA32_FEAT_CTL, &msr))
 		fprintf(outf, "cpu%d: MSR_IA32_FEATURE_CONTROL: 0x%08llx (%sLocked %s)\n",
 			base_cpu, msr,
-			msr & FEATURE_CONTROL_LOCKED ? "" : "UN-",
+			msr & FEAT_CTL_LOCKED ? "" : "UN-",
 			msr & (1 << 18) ? "SGX" : "");
 }
 
diff --git a/tools/testing/selftests/kvm/lib/x86_64/vmx.c b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
index f6ec97b7eaef..85064baf5e97 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/vmx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
@@ -157,11 +157,11 @@ bool prepare_for_vmx_operation(struct vmx_pages *vmx)
 	 *  Bit 2: Enables VMXON outside of SMX operation. If clear, VMXON
 	 *    outside of SMX causes a #GP.
 	 */
-	required = FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX;
-	required |= FEATURE_CONTROL_LOCKED;
-	feature_control = rdmsr(MSR_IA32_FEATURE_CONTROL);
+	required = FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX;
+	required |= FEAT_CTL_LOCKED;
+	feature_control = rdmsr(MSR_IA32_FEAT_CTL);
 	if ((feature_control & required) != required)
-		wrmsr(MSR_IA32_FEATURE_CONTROL, feature_control | required);
+		wrmsr(MSR_IA32_FEAT_CTL, feature_control | required);
 
 	/* Enter VMX root operation. */
 	*(uint32_t *)(vmx->vmxon) = vmcs_revision();
-- 
2.24.1

