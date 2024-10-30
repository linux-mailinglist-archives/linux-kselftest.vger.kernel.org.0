Return-Path: <linux-kselftest+bounces-21071-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A669B5A6B
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 04:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 474F31C2132F
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 03:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01861199FBF;
	Wed, 30 Oct 2024 03:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fhAcneuK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06461194A73
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2024 03:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730259323; cv=none; b=fva623b/Ct8PsKgNnnAXPL8X35OmKvs2xJgNpbn81FEUQfaCgKNl9nWhw8RNg3KkqIezHYp5G5Msrh3AYM6yW0aYx96DZWFw6KeUy8UEDLf7JaRGfOJx8MF+HkJ50b15TnO6z2Io8mVE8xy4THLQwAjFtY06H5H2OTIkudQXfPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730259323; c=relaxed/simple;
	bh=Bf8atWoT1AgbKzljqD4YpHmghXSVbfevIZjTTADfkuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jK7LL4p7sSbQhpZzp0moB39CkxzBTvN1HSypFlXcQDX/kQQ083kYaPNKI5hh595YNA+LiYEn2esjbIS61RR3VAorHVCZF0bwyOPKFzjbF/zKo91EHzOdOUlI+CfSVGX7cMorWx1CtJqeQ8mgLA4camxJy/MkbJU2YaDPoC62iJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fhAcneuK; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4a47d70cd8aso1947135137.1
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 20:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730259320; x=1730864120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXSF2eEHg6CQZsZauUAKPc3+lZzOLUOLy+73Zovk/II=;
        b=fhAcneuK+f0ngG3926ADrrLAQAYOPbg7wlUAZNdUWAZm+X2UrCS17ZEFCcjvdxBLgC
         K8FvoJ33U2ylciSwUFDhm9RuDPnpf5cFZGpJbsMS5HQWTAhfWUTwQpOxIOBPF/ok5rzT
         SHFI9IYDMS1KIu9NLaQ58rZ0uLVjz017eoLo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730259320; x=1730864120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXSF2eEHg6CQZsZauUAKPc3+lZzOLUOLy+73Zovk/II=;
        b=rMyh0cXxTESLblrwOOfMsRcmtHm9kdqtrGLax9oGcwE8Kbs2oJ9dB4GoIsWDh3wliD
         D8ZinHl0z0DHCSoF7rdVFZbx52+tu15RM3DvmOhqsuhy7zKFuVaZLr3m9uK8BwthbZN5
         vKSP2lknsap3B2FAVq1y+ky6C3HoFOX/k+zDfxe5PXoCkrWUdIxMzpcP/3PjFmHQm3dY
         ahgoxP9qTm7tuEu6tRAA+2X+ea3Uq7EPFDb/kUAMZfOI4Q7Y1JjoU1DnMUo1LjycmM9d
         ziS9+anDnnccR/fhEkkvzohY3sekAY6fhs9+LXbz2iMlB+NcgEynPOA/de78hIUvN3zj
         vyPA==
X-Forwarded-Encrypted: i=1; AJvYcCVwcaHZn4sK8c104nI+Tzb0ewwbyfEvF4DRG7yEiKWkgTX/jTl3nmQO9cHK5AJu79ATDYwyHhPKevsYB8PX5Ac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0nsavDRuhkm2UWGFwNE/6hCvR3Ts63MPB0SWXRlRP7ncbVBN2
	IcvTrQjaBA0aUKCYPOx0H0IvvOYc8OFAi7YvteRxUCSuyiI/olKSlSqTgWyRig==
X-Google-Smtp-Source: AGHT+IGZpRhflFNaUw8TMKAPrDYokmZ7cw+TYThiu0Fvr4MS0wJ34OSWBafYUwebIo7ai1SLq3TcAg==
X-Received: by 2002:a05:6102:3a09:b0:4a4:6098:1fec with SMTP id ada2fe7eead31-4a8cfb25a8emr13741342137.2.1730259319648;
        Tue, 29 Oct 2024 20:35:19 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-461323a4840sm51015561cf.86.2024.10.29.20.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 20:35:19 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: kvm@vger.kernel.org
Cc: Zack Rusin <zack.rusin@broadcom.com>,
	Doug Covelli <doug.covelli@broadcom.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	Joel Stanley <joel@jms.id.au>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 1/3] KVM: x86: Allow enabling of the vmware backdoor via a cap
Date: Tue, 29 Oct 2024 23:34:07 -0400
Message-ID: <20241030033514.1728937-2-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241030033514.1728937-1-zack.rusin@broadcom.com>
References: <20241030033514.1728937-1-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow enabling of the vmware backdoor on a per-vm basis. The vmware
backdoor could only be enabled systemwide via the kernel parameter
kvm.enable_vmware_backdoor which required modifying the kernels boot
parameters.

Add the KVM_CAP_X86_VMWARE_BACKDOOR cap that enables the backdoor at the
hypervisor level and allows setting it on a per-vm basis.

The default is whatever kvm.enable_vmware_backdoor was set to, which
by default is false.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Cc: Doug Covelli <doug.covelli@broadcom.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Isaku Yamahata <isaku.yamahata@intel.com>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Zack Rusin <zack.rusin@broadcom.com>
Cc: kvm@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
---
 Documentation/virt/kvm/api.rst  | 15 +++++++++++++++
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/emulate.c          |  5 +++--
 arch/x86/kvm/svm/svm.c          |  6 +++---
 arch/x86/kvm/vmx/vmx.c          |  4 ++--
 arch/x86/kvm/x86.c              | 14 ++++++++++++++
 arch/x86/kvm/x86.h              |  7 +++++--
 include/uapi/linux/kvm.h        |  1 +
 8 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index b3be87489108..33ef3cc785e4 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -8186,6 +8186,21 @@ KVM exits with the register state of either the L1 or L2 guest
 depending on which executed at the time of an exit. Userspace must
 take care to differentiate between these cases.
 
+7.37 KVM_CAP_X86_VMWARE_BACKDOOR
+--------------------------------
+
+:Architectures: x86
+:Parameters: args[0] whether the feature should be enabled or not
+:Returns: 0 on success.
+
+The presence of this capability indicates that KVM supports
+enabling of the VMware backdoor via the enable cap interface.
+
+When enabled KVM will support VMware backdoor PV interface. The
+default value for it is set via the kvm.enable_vmware_backdoor
+kernel parameter (false when not set). Must be set before any
+VCPUs have been created.
+
 8. Other capabilities.
 ======================
 
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 4a68cb3eba78..7fcf185e337f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1403,6 +1403,7 @@ struct kvm_arch {
 #ifdef CONFIG_KVM_XEN
 	struct kvm_xen xen;
 #endif
+	bool vmware_backdoor_enabled;
 
 	bool backwards_tsc_observed;
 	bool boot_vcpu_runs_old_kvmclock;
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index e72aed25d721..8aee73f9a560 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -2563,7 +2563,7 @@ static bool emulator_io_port_access_allowed(struct x86_emulate_ctxt *ctxt,
 	 * VMware allows access to these ports even if denied
 	 * by TSS I/O permission bitmap. Mimic behavior.
 	 */
-	if (enable_vmware_backdoor &&
+	if (kvm_vmware_backdoor_enabled(ctxt->vcpu) &&
 	    ((port == VMWARE_PORT_VMPORT) || (port == VMWARE_PORT_VMRPC)))
 		return true;
 
@@ -3917,7 +3917,8 @@ static int check_rdpmc(struct x86_emulate_ctxt *ctxt)
 	 * VMware allows access to these Pseduo-PMCs even when read via RDPMC
 	 * in Ring3 when CR4.PCE=0.
 	 */
-	if (enable_vmware_backdoor && is_vmware_backdoor_pmc(rcx))
+	if (kvm_vmware_backdoor_enabled(ctxt->vcpu) &&
+	    is_vmware_backdoor_pmc(rcx))
 		return X86EMUL_CONTINUE;
 
 	/*
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 5ab2c92c7331..a55655337cfa 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -314,7 +314,7 @@ int svm_set_efer(struct kvm_vcpu *vcpu, u64 efer)
 			svm_leave_nested(vcpu);
 			svm_set_gif(svm, true);
 			/* #GP intercept is still needed for vmware backdoor */
-			if (!enable_vmware_backdoor)
+			if (!kvm_vmware_backdoor_enabled(vcpu))
 				clr_exception_intercept(svm, GP_VECTOR);
 
 			/*
@@ -1262,7 +1262,7 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
 	 * We intercept those #GP and allow access to them anyway
 	 * as VMware does.
 	 */
-	if (enable_vmware_backdoor)
+	if (kvm_vmware_backdoor_enabled(vcpu))
 		set_exception_intercept(svm, GP_VECTOR);
 
 	svm_set_intercept(svm, INTERCEPT_INTR);
@@ -2401,7 +2401,7 @@ static int gp_interception(struct kvm_vcpu *vcpu)
 	opcode = svm_instr_opcode(vcpu);
 
 	if (opcode == NONE_SVM_INSTR) {
-		if (!enable_vmware_backdoor)
+		if (!kvm_vmware_backdoor_enabled(vcpu))
 			goto reinject;
 
 		/*
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 733a0c45d1a6..6b874c629b82 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -885,7 +885,7 @@ void vmx_update_exception_bitmap(struct kvm_vcpu *vcpu)
 	 * We intercept those #GP and allow access to them anyway
 	 * as VMware does.
 	 */
-	if (enable_vmware_backdoor)
+	if (kvm_vmware_backdoor_enabled(vcpu))
 		eb |= (1u << GP_VECTOR);
 	if ((vcpu->guest_debug &
 	     (KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_SW_BP)) ==
@@ -5249,7 +5249,7 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
 		error_code = vmcs_read32(VM_EXIT_INTR_ERROR_CODE);
 
 	if (!vmx->rmode.vm86_active && is_gp_fault(intr_info)) {
-		WARN_ON_ONCE(!enable_vmware_backdoor);
+		WARN_ON_ONCE(!kvm_vmware_backdoor_enabled(vcpu));
 
 		/*
 		 * VMware backdoor emulation on #GP interception only handles
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c983c8e434b8..d7071907d6a5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4688,6 +4688,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_IRQFD_RESAMPLE:
 	case KVM_CAP_MEMORY_FAULT_INFO:
 	case KVM_CAP_X86_GUEST_MODE:
+	case KVM_CAP_X86_VMWARE_BACKDOOR:
 		r = 1;
 		break;
 	case KVM_CAP_PRE_FAULT_MEMORY:
@@ -6772,6 +6773,17 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		mutex_unlock(&kvm->lock);
 		break;
 	}
+	case KVM_CAP_X86_VMWARE_BACKDOOR:
+		r = -EINVAL;
+		if (cap->args[0] & ~1)
+			break;
+		mutex_lock(&kvm->lock);
+		if (!kvm->created_vcpus) {
+			kvm->arch.vmware_backdoor_enabled = cap->args[0];
+			r = 0;
+		}
+		mutex_unlock(&kvm->lock);
+		break;
 	default:
 		r = -EINVAL;
 		break;
@@ -12685,6 +12697,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	kvm->arch.guest_can_read_msr_platform_info = true;
 	kvm->arch.enable_pmu = enable_pmu;
 
+	kvm->arch.vmware_backdoor_enabled = enable_vmware_backdoor;
+
 #if IS_ENABLED(CONFIG_HYPERV)
 	spin_lock_init(&kvm->arch.hv_root_tdp_lock);
 	kvm->arch.hv_root_tdp = INVALID_PAGE;
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 50596f6f8320..ae278a48566a 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -376,14 +376,17 @@ static inline bool kvm_mpx_supported(void)
 
 extern unsigned int min_timer_period_us;
 
-extern bool enable_vmware_backdoor;
-
 extern int pi_inject_timer;
 
 extern bool report_ignored_msrs;
 
 extern bool eager_page_split;
 
+static inline bool kvm_vmware_backdoor_enabled(struct kvm_vcpu *vcpu)
+{
+	return vcpu->kvm->arch.vmware_backdoor_enabled;
+}
+
 static inline void kvm_pr_unimpl_wrmsr(struct kvm_vcpu *vcpu, u32 msr, u64 data)
 {
 	if (report_ignored_msrs)
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 637efc055145..c7b5f1c2ee1c 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -933,6 +933,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_PRE_FAULT_MEMORY 236
 #define KVM_CAP_X86_APIC_BUS_CYCLES_NS 237
 #define KVM_CAP_X86_GUEST_MODE 238
+#define KVM_CAP_X86_VMWARE_BACKDOOR 239
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.43.0


