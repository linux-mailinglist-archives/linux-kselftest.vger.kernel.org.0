Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA1311011BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2019 04:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfKSDM7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Nov 2019 22:12:59 -0500
Received: from mga02.intel.com ([134.134.136.20]:21257 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727634AbfKSDM6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Nov 2019 22:12:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 19:12:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,322,1569308400"; 
   d="scan'208";a="218105748"
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
Subject: [PATCH v3 16/19] KVM: VMX: Use VMX_FEATURE_* flags to define VMCS control bits
Date:   Mon, 18 Nov 2019 19:12:37 -0800
Message-Id: <20191119031240.7779-17-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119031240.7779-1-sean.j.christopherson@intel.com>
References: <20191119031240.7779-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Define the VMCS execution control flags (consumed by KVM) using their
associated VMX_FEATURE_* to provide a strong hint that new VMX features
are expected to be added to VMX_FEATURE and considered for reporting via
/proc/cpuinfo.

No functional change intended.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/include/asm/vmx.h | 105 +++++++++++++++++++------------------
 1 file changed, 55 insertions(+), 50 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 1835767aa335..9fbba31be825 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -15,67 +15,70 @@
 #include <linux/bitops.h>
 #include <linux/types.h>
 #include <uapi/asm/vmx.h>
+#include <asm/vmxfeatures.h>
+
+#define VMCS_CONTROL_BIT(x)	BIT(VMX_FEATURE_##x & 0x1f)
 
 /*
  * Definitions of Primary Processor-Based VM-Execution Controls.
  */
-#define CPU_BASED_VIRTUAL_INTR_PENDING          0x00000004
-#define CPU_BASED_USE_TSC_OFFSETING             0x00000008
-#define CPU_BASED_HLT_EXITING                   0x00000080
-#define CPU_BASED_INVLPG_EXITING                0x00000200
-#define CPU_BASED_MWAIT_EXITING                 0x00000400
-#define CPU_BASED_RDPMC_EXITING                 0x00000800
-#define CPU_BASED_RDTSC_EXITING                 0x00001000
-#define CPU_BASED_CR3_LOAD_EXITING		0x00008000
-#define CPU_BASED_CR3_STORE_EXITING		0x00010000
-#define CPU_BASED_CR8_LOAD_EXITING              0x00080000
-#define CPU_BASED_CR8_STORE_EXITING             0x00100000
-#define CPU_BASED_TPR_SHADOW                    0x00200000
-#define CPU_BASED_VIRTUAL_NMI_PENDING		0x00400000
-#define CPU_BASED_MOV_DR_EXITING                0x00800000
-#define CPU_BASED_UNCOND_IO_EXITING             0x01000000
-#define CPU_BASED_USE_IO_BITMAPS                0x02000000
-#define CPU_BASED_MONITOR_TRAP_FLAG             0x08000000
-#define CPU_BASED_USE_MSR_BITMAPS               0x10000000
-#define CPU_BASED_MONITOR_EXITING               0x20000000
-#define CPU_BASED_PAUSE_EXITING                 0x40000000
-#define CPU_BASED_ACTIVATE_SECONDARY_CONTROLS   0x80000000
+#define CPU_BASED_VIRTUAL_INTR_PENDING          VMCS_CONTROL_BIT(VIRTUAL_INTR_PENDING)
+#define CPU_BASED_USE_TSC_OFFSETING             VMCS_CONTROL_BIT(TSC_OFFSETTING)
+#define CPU_BASED_HLT_EXITING                   VMCS_CONTROL_BIT(HLT_EXITING)
+#define CPU_BASED_INVLPG_EXITING                VMCS_CONTROL_BIT(INVLPG_EXITING)
+#define CPU_BASED_MWAIT_EXITING                 VMCS_CONTROL_BIT(MWAIT_EXITING)
+#define CPU_BASED_RDPMC_EXITING                 VMCS_CONTROL_BIT(RDPMC_EXITING)
+#define CPU_BASED_RDTSC_EXITING                 VMCS_CONTROL_BIT(RDTSC_EXITING)
+#define CPU_BASED_CR3_LOAD_EXITING		VMCS_CONTROL_BIT(CR3_LOAD_EXITING)
+#define CPU_BASED_CR3_STORE_EXITING		VMCS_CONTROL_BIT(CR3_STORE_EXITING)
+#define CPU_BASED_CR8_LOAD_EXITING              VMCS_CONTROL_BIT(CR8_LOAD_EXITING)
+#define CPU_BASED_CR8_STORE_EXITING             VMCS_CONTROL_BIT(CR8_STORE_EXITING)
+#define CPU_BASED_TPR_SHADOW                    VMCS_CONTROL_BIT(VIRTUAL_TPR)
+#define CPU_BASED_VIRTUAL_NMI_PENDING		VMCS_CONTROL_BIT(VIRTUAL_NMI_PENDING)
+#define CPU_BASED_MOV_DR_EXITING                VMCS_CONTROL_BIT(MOV_DR_EXITING)
+#define CPU_BASED_UNCOND_IO_EXITING             VMCS_CONTROL_BIT(UNCOND_IO_EXITING)
+#define CPU_BASED_USE_IO_BITMAPS                VMCS_CONTROL_BIT(USE_IO_BITMAPS)
+#define CPU_BASED_MONITOR_TRAP_FLAG             VMCS_CONTROL_BIT(MONITOR_TRAP_FLAG)
+#define CPU_BASED_USE_MSR_BITMAPS               VMCS_CONTROL_BIT(USE_MSR_BITMAPS)
+#define CPU_BASED_MONITOR_EXITING               VMCS_CONTROL_BIT(MONITOR_EXITING)
+#define CPU_BASED_PAUSE_EXITING                 VMCS_CONTROL_BIT(PAUSE_EXITING)
+#define CPU_BASED_ACTIVATE_SECONDARY_CONTROLS   VMCS_CONTROL_BIT(SEC_CONTROLS)
 
 #define CPU_BASED_ALWAYSON_WITHOUT_TRUE_MSR	0x0401e172
 
 /*
  * Definitions of Secondary Processor-Based VM-Execution Controls.
  */
-#define SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES 0x00000001
-#define SECONDARY_EXEC_ENABLE_EPT               0x00000002
-#define SECONDARY_EXEC_DESC			0x00000004
-#define SECONDARY_EXEC_RDTSCP			0x00000008
-#define SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE   0x00000010
-#define SECONDARY_EXEC_ENABLE_VPID              0x00000020
-#define SECONDARY_EXEC_WBINVD_EXITING		0x00000040
-#define SECONDARY_EXEC_UNRESTRICTED_GUEST	0x00000080
-#define SECONDARY_EXEC_APIC_REGISTER_VIRT       0x00000100
-#define SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY    0x00000200
-#define SECONDARY_EXEC_PAUSE_LOOP_EXITING	0x00000400
-#define SECONDARY_EXEC_RDRAND_EXITING		0x00000800
-#define SECONDARY_EXEC_ENABLE_INVPCID		0x00001000
-#define SECONDARY_EXEC_ENABLE_VMFUNC            0x00002000
-#define SECONDARY_EXEC_SHADOW_VMCS              0x00004000
-#define SECONDARY_EXEC_ENCLS_EXITING		0x00008000
-#define SECONDARY_EXEC_RDSEED_EXITING		0x00010000
-#define SECONDARY_EXEC_ENABLE_PML               0x00020000
-#define SECONDARY_EXEC_PT_CONCEAL_VMX		0x00080000
-#define SECONDARY_EXEC_XSAVES			0x00100000
-#define SECONDARY_EXEC_PT_USE_GPA		0x01000000
-#define SECONDARY_EXEC_MODE_BASED_EPT_EXEC	0x00400000
-#define SECONDARY_EXEC_TSC_SCALING              0x02000000
+#define SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES VMCS_CONTROL_BIT(VIRT_APIC_ACCESSES)
+#define SECONDARY_EXEC_ENABLE_EPT               VMCS_CONTROL_BIT(EPT)
+#define SECONDARY_EXEC_DESC			VMCS_CONTROL_BIT(DESC_EXITING)
+#define SECONDARY_EXEC_RDTSCP			VMCS_CONTROL_BIT(RDTSCP)
+#define SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE   VMCS_CONTROL_BIT(VIRTUAL_X2APIC)
+#define SECONDARY_EXEC_ENABLE_VPID              VMCS_CONTROL_BIT(VPID)
+#define SECONDARY_EXEC_WBINVD_EXITING		VMCS_CONTROL_BIT(WBINVD_EXITING)
+#define SECONDARY_EXEC_UNRESTRICTED_GUEST	VMCS_CONTROL_BIT(UNRESTRICTED_GUEST)
+#define SECONDARY_EXEC_APIC_REGISTER_VIRT       VMCS_CONTROL_BIT(APIC_REGISTER_VIRT)
+#define SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY    VMCS_CONTROL_BIT(VIRT_INTR_DELIVERY)
+#define SECONDARY_EXEC_PAUSE_LOOP_EXITING	VMCS_CONTROL_BIT(PAUSE_LOOP_EXITING)
+#define SECONDARY_EXEC_RDRAND_EXITING		VMCS_CONTROL_BIT(RDRAND_EXITING)
+#define SECONDARY_EXEC_ENABLE_INVPCID		VMCS_CONTROL_BIT(INVPCID)
+#define SECONDARY_EXEC_ENABLE_VMFUNC            VMCS_CONTROL_BIT(VMFUNC)
+#define SECONDARY_EXEC_SHADOW_VMCS              VMCS_CONTROL_BIT(SHADOW_VMCS)
+#define SECONDARY_EXEC_ENCLS_EXITING		VMCS_CONTROL_BIT(ENCLS_EXITING)
+#define SECONDARY_EXEC_RDSEED_EXITING		VMCS_CONTROL_BIT(RDSEED_EXITING)
+#define SECONDARY_EXEC_ENABLE_PML               VMCS_CONTROL_BIT(PAGE_MOD_LOGGING)
+#define SECONDARY_EXEC_PT_CONCEAL_VMX		VMCS_CONTROL_BIT(PT_CONCEAL_VMX)
+#define SECONDARY_EXEC_XSAVES			VMCS_CONTROL_BIT(XSAVES)
+#define SECONDARY_EXEC_MODE_BASED_EPT_EXEC	VMCS_CONTROL_BIT(MODE_BASED_EPT_EXEC)
+#define SECONDARY_EXEC_PT_USE_GPA		VMCS_CONTROL_BIT(PT_USE_GPA)
+#define SECONDARY_EXEC_TSC_SCALING              VMCS_CONTROL_BIT(TSC_SCALING)
 #define SECONDARY_EXEC_ENABLE_USR_WAIT_PAUSE	0x04000000
 
-#define PIN_BASED_EXT_INTR_MASK                 0x00000001
-#define PIN_BASED_NMI_EXITING                   0x00000008
-#define PIN_BASED_VIRTUAL_NMIS                  0x00000020
-#define PIN_BASED_VMX_PREEMPTION_TIMER          0x00000040
-#define PIN_BASED_POSTED_INTR                   0x00000080
+#define PIN_BASED_EXT_INTR_MASK                 VMCS_CONTROL_BIT(INTR_EXITING)
+#define PIN_BASED_NMI_EXITING                   VMCS_CONTROL_BIT(NMI_EXITING)
+#define PIN_BASED_VIRTUAL_NMIS                  VMCS_CONTROL_BIT(VIRTUAL_NMIS)
+#define PIN_BASED_VMX_PREEMPTION_TIMER          VMCS_CONTROL_BIT(PREEMPTION_TIMER)
+#define PIN_BASED_POSTED_INTR                   VMCS_CONTROL_BIT(POSTED_INTR)
 
 #define PIN_BASED_ALWAYSON_WITHOUT_TRUE_MSR	0x00000016
 
@@ -114,7 +117,9 @@
 #define VMX_MISC_MSR_LIST_MULTIPLIER		512
 
 /* VMFUNC functions */
-#define VMX_VMFUNC_EPTP_SWITCHING               0x00000001
+#define VMFUNC_CONTROL_BIT(x)	BIT((VMX_FEATURE_##x & 0x1f) - 28)
+
+#define VMX_VMFUNC_EPTP_SWITCHING               VMFUNC_CONTROL_BIT(EPTP_SWITCHING)
 #define VMFUNC_EPTP_ENTRIES  512
 
 static inline u32 vmx_basic_vmcs_revision_id(u64 vmx_basic)
-- 
2.24.0

