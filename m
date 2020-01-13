Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE78D13994A
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2020 19:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbgAMSw0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jan 2020 13:52:26 -0500
Received: from mail.skyhub.de ([5.9.137.197]:58730 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgAMSw0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jan 2020 13:52:26 -0500
Received: from zn.tnic (p200300EC2F05D30049A87F91DFBF49F4.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:d300:49a8:7f91:dfbf:49f4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 264231EC0CBF;
        Mon, 13 Jan 2020 19:52:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578941544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nroBP1M9a+oDLvFHSrWrc/9Pg86AU7wcX7yapLqPoeI=;
        b=CHuOHTdNpZGOYG47VGt6oBtE5RAxe7d8TvFCYjsAjjFB8fSqH+3OwPexCnHeVJYgCxrKU5
        IHJd/aI68UOL0L5Xxri11CE+Z3Pd/sEcYcACZ/aanHHJVcI9MnRWqznCzy7OzLpZcSTqE7
        gfib7yhDI3gdZFNlUJjJvYXaBq+E0UQ=
Date:   Mon, 13 Jan 2020 19:52:16 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
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
        linux-kselftest@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH] KVM: VMX: Rename define to CPU_BASED_USE_TSC_OFFSETTING
Message-ID: <20200113185216.GQ13310@zn.tnic>
References: <20191221044513.21680-1-sean.j.christopherson@intel.com>
 <20191221044513.21680-18-sean.j.christopherson@intel.com>
 <20200113183228.GO13310@zn.tnic>
 <20200113183705.GL1175@linux.intel.com>
 <20200113183823.GP13310@zn.tnic>
 <20200113184217.GA2216@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200113184217.GA2216@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 13, 2020 at 10:42:17AM -0800, Sean Christopherson wrote:
> > Doesn't bother me, I could do it in a patch ontop. But your call.
> 
> No objection here.

Something like this:

---
From: Borislav Petkov <bp@suse.de>

... so that "offsetting" is spelled the same as the respective VMX feature
bit VMX_FEATURE_TSC_OFFSETTING.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/vmx.h                               | 2 +-
 arch/x86/kvm/vmx/nested.c                                | 8 ++++----
 arch/x86/kvm/vmx/vmx.c                                   | 6 +++---
 tools/testing/selftests/kvm/include/x86_64/vmx.h         | 2 +-
 tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c | 2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 9fbba31be825..6df8b3b94483 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -23,7 +23,7 @@
  * Definitions of Primary Processor-Based VM-Execution Controls.
  */
 #define CPU_BASED_VIRTUAL_INTR_PENDING          VMCS_CONTROL_BIT(VIRTUAL_INTR_PENDING)
-#define CPU_BASED_USE_TSC_OFFSETING             VMCS_CONTROL_BIT(TSC_OFFSETTING)
+#define CPU_BASED_USE_TSC_OFFSETTING             VMCS_CONTROL_BIT(TSC_OFFSETTING)
 #define CPU_BASED_HLT_EXITING                   VMCS_CONTROL_BIT(HLT_EXITING)
 #define CPU_BASED_INVLPG_EXITING                VMCS_CONTROL_BIT(INVLPG_EXITING)
 #define CPU_BASED_MWAIT_EXITING                 VMCS_CONTROL_BIT(MWAIT_EXITING)
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 6879966b7648..d466666b1de9 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3230,7 +3230,7 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 	}
 
 	enter_guest_mode(vcpu);
-	if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING)
+	if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETTING)
 		vcpu->arch.tsc_offset += vmcs12->tsc_offset;
 
 	if (prepare_vmcs02(vcpu, vmcs12, &exit_qual))
@@ -3294,7 +3294,7 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 	 * 26.7 "VM-entry failures during or after loading guest state".
 	 */
 vmentry_fail_vmexit_guest_mode:
-	if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING)
+	if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETTING)
 		vcpu->arch.tsc_offset -= vmcs12->tsc_offset;
 	leave_guest_mode(vcpu);
 
@@ -4209,7 +4209,7 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
 	if (nested_cpu_has_preemption_timer(vmcs12))
 		hrtimer_cancel(&to_vmx(vcpu)->nested.preemption_timer);
 
-	if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING)
+	if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETTING)
 		vcpu->arch.tsc_offset -= vmcs12->tsc_offset;
 
 	if (likely(!vmx->fail)) {
@@ -6016,7 +6016,7 @@ void nested_vmx_setup_ctls_msrs(struct nested_vmx_msrs *msrs, u32 ept_caps,
 		CPU_BASED_ALWAYSON_WITHOUT_TRUE_MSR;
 	msrs->procbased_ctls_high &=
 		CPU_BASED_VIRTUAL_INTR_PENDING |
-		CPU_BASED_VIRTUAL_NMI_PENDING | CPU_BASED_USE_TSC_OFFSETING |
+		CPU_BASED_VIRTUAL_NMI_PENDING | CPU_BASED_USE_TSC_OFFSETTING |
 		CPU_BASED_HLT_EXITING | CPU_BASED_INVLPG_EXITING |
 		CPU_BASED_MWAIT_EXITING | CPU_BASED_CR3_LOAD_EXITING |
 		CPU_BASED_CR3_STORE_EXITING |
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index cdb4bf50ee14..e543232a28b2 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1716,7 +1716,7 @@ static u64 vmx_read_l1_tsc_offset(struct kvm_vcpu *vcpu)
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 
 	if (is_guest_mode(vcpu) &&
-	    (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING))
+	    (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETTING))
 		return vcpu->arch.tsc_offset - vmcs12->tsc_offset;
 
 	return vcpu->arch.tsc_offset;
@@ -1734,7 +1734,7 @@ static u64 vmx_write_l1_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
 	 * to the newly set TSC to get L2's TSC.
 	 */
 	if (is_guest_mode(vcpu) &&
-	    (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING))
+	    (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETTING))
 		g_tsc_offset = vmcs12->tsc_offset;
 
 	trace_kvm_write_tsc_offset(vcpu->vcpu_id,
@@ -2322,7 +2322,7 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 	      CPU_BASED_CR3_STORE_EXITING |
 	      CPU_BASED_UNCOND_IO_EXITING |
 	      CPU_BASED_MOV_DR_EXITING |
-	      CPU_BASED_USE_TSC_OFFSETING |
+	      CPU_BASED_USE_TSC_OFFSETTING |
 	      CPU_BASED_MWAIT_EXITING |
 	      CPU_BASED_MONITOR_EXITING |
 	      CPU_BASED_INVLPG_EXITING |
diff --git a/tools/testing/selftests/kvm/include/x86_64/vmx.h b/tools/testing/selftests/kvm/include/x86_64/vmx.h
index f52e0ba84fed..969a0f0c2ec0 100644
--- a/tools/testing/selftests/kvm/include/x86_64/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/vmx.h
@@ -19,7 +19,7 @@
  * Definitions of Primary Processor-Based VM-Execution Controls.
  */
 #define CPU_BASED_VIRTUAL_INTR_PENDING		0x00000004
-#define CPU_BASED_USE_TSC_OFFSETING		0x00000008
+#define CPU_BASED_USE_TSC_OFFSETTING		0x00000008
 #define CPU_BASED_HLT_EXITING			0x00000080
 #define CPU_BASED_INVLPG_EXITING		0x00000200
 #define CPU_BASED_MWAIT_EXITING			0x00000400
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c b/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
index 5590fd2bcf87..69e482a95c47 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
@@ -98,7 +98,7 @@ static void l1_guest_code(struct vmx_pages *vmx_pages)
 	prepare_vmcs(vmx_pages, l2_guest_code,
 		     &l2_guest_stack[L2_GUEST_STACK_SIZE]);
 	control = vmreadz(CPU_BASED_VM_EXEC_CONTROL);
-	control |= CPU_BASED_USE_MSR_BITMAPS | CPU_BASED_USE_TSC_OFFSETING;
+	control |= CPU_BASED_USE_MSR_BITMAPS | CPU_BASED_USE_TSC_OFFSETTING;
 	vmwrite(CPU_BASED_VM_EXEC_CONTROL, control);
 	vmwrite(TSC_OFFSET, TSC_OFFSET_VALUE);
 
-- 
2.21.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
