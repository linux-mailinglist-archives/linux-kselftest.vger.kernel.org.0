Return-Path: <linux-kselftest+bounces-21072-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AED29B5A6F
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 04:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB3291F245E2
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 03:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7058E1C4603;
	Wed, 30 Oct 2024 03:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QfxcA08N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7D61991D4
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2024 03:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730259325; cv=none; b=E9xe9ckU93V/2KLO7c1neTCNq5BRePSz7DnFOICRBowVd0wNPemUrxdNqkJpNAsQTRn5X7Shq9HDUNfri2e0P7QsKeSwoCHDSjK05Iovh2xWLA8/f3wmBbRroPrjmrZ4/nuAeqAbznQV1HrcyGyGKnx4utX/9xS3QNJbKbzSRss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730259325; c=relaxed/simple;
	bh=Kgs+eWx7o2g2fh3PL6R26a4Wy9eDpiLIOtdgqULaC2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ld5lN4z1GcARKYsrd6UtU6dDUIVwy06usiG7Im+MrOc6kfP+k9LiOZkPrbO1vcJa9O0V9k8kEabaplx5pOSWfS9aiyN3yObYwSyDO0K553KWiEN5Q3OS2xX4PUxZwMNgN+rzuoQ8XxZl6VAbZKNBox21mnaWivuOQ7N1gbzCgLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QfxcA08N; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-460ace055d8so42902581cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 20:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730259321; x=1730864121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3GKYnVa/shm5to0559XXaPhB1/FWLLgFQ/uN05I12o=;
        b=QfxcA08NC0NnIPbqn9DVA/38nFNZzTKKpKCKt8Emp9n/FKloM2jTvqKc26Csu2p61k
         IL4irsUiyk/cR/HhtuOIyrpnph4+XeCUPfQfYuArPbuZe9lF5CRvcnb9fQzT+C+p2XAk
         2vBV6EyTXPWKmQ0TS8AdRjpDoYFgP2a2/XrfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730259321; x=1730864121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3GKYnVa/shm5to0559XXaPhB1/FWLLgFQ/uN05I12o=;
        b=KY7gJm1tzPlp6yLWEZ2/YSfeFUT4rymxis1jgMawBJjbp2mS0q0YXNTTzziDdQJwIN
         3IJQFqnyumzHhWGaoAig31faOnukHhWD4QCDDti4SNPursoP8W+PfDvFT1+5KWTK+C8f
         0/I+picNWHipHS3u2E5saQP9IaHWFPJg2wBkaZKn0QdhNHlV+jcYKazVfCI65J7Z6oyY
         kKCYlkC+0dHkd2USB77e0aVgOz5gvFvqTB90kgCX7ehHDL0ucV68EYv81hqtxz3e3rZw
         2C4sTXr+waCnZlRcRWSfiDcpMOLdbPEI+117ok1sbMD7vLGXf+vnLUaHFWIDZ4FFRvt6
         f5Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVBcOAOXJcfTuTT53b93wTqtfRiFz7l1YYKz9RZrEn6FlpNHyWOJpiZjvHCpTWZ1ScVGu3gnGmk3+e/XBVwh3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfE8QMvhn4yER+H9EUvp5cHJBNZu3wK3FNcpaqijno7CPknzeV
	u+Z945lD61KoAzsQtzOspfNNrlSLzduLEGOOPPRUlwUyIf0s09kmMs6K8KYl1Q==
X-Google-Smtp-Source: AGHT+IEem11ygHxVK51cRhrQxNiN0xVSQYe3RjjvoZI4dUIf0yRjgNEKPfSjst7O5GbzSQBBOQwR/g==
X-Received: by 2002:a05:622a:1184:b0:45f:bc9e:c69c with SMTP id d75a77b69052e-4613bfd417dmr199820411cf.7.1730259320884;
        Tue, 29 Oct 2024 20:35:20 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-461323a4840sm51015561cf.86.2024.10.29.20.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 20:35:20 -0700 (PDT)
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
Subject: [PATCH 2/3] KVM: x86: Add support for VMware guest specific hypercalls
Date: Tue, 29 Oct 2024 23:34:08 -0400
Message-ID: <20241030033514.1728937-3-zack.rusin@broadcom.com>
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

VMware products handle hypercalls in userspace. Give KVM the ability
to run VMware guests unmodified by fowarding all hypercalls to the
userspace.

Enabling of the KVM_CAP_X86_VMWARE_HYPERCALL_ENABLE capability turns
the feature on - it's off by default. This allows vmx's built on top
of KVM to support VMware specific hypercalls.

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
 Documentation/virt/kvm/api.rst  | 41 +++++++++++++++++++++++++++++----
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/x86.c              | 33 ++++++++++++++++++++++++++
 include/uapi/linux/kvm.h        |  1 +
 4 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 33ef3cc785e4..5a8c7922f64f 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6601,10 +6601,11 @@ to the byte array.
 .. note::
 
       For KVM_EXIT_IO, KVM_EXIT_MMIO, KVM_EXIT_OSI, KVM_EXIT_PAPR, KVM_EXIT_XEN,
-      KVM_EXIT_EPR, KVM_EXIT_X86_RDMSR and KVM_EXIT_X86_WRMSR the corresponding
-      operations are complete (and guest state is consistent) only after userspace
-      has re-entered the kernel with KVM_RUN.  The kernel side will first finish
-      incomplete operations and then check for pending signals.
+      KVM_EXIT_EPR, KVM_EXIT_HYPERCALL, KVM_EXIT_X86_RDMSR and KVM_EXIT_X86_WRMSR
+      the corresponding operations are complete (and guest state is consistent)
+      only after userspace has re-entered the kernel with KVM_RUN. The kernel
+      side will first finish incomplete operations and then check for pending
+      signals.
 
       The pending state of the operation is not preserved in state which is
       visible to userspace, thus userspace should ensure that the operation is
@@ -8201,6 +8202,38 @@ default value for it is set via the kvm.enable_vmware_backdoor
 kernel parameter (false when not set). Must be set before any
 VCPUs have been created.
 
+7.38 KVM_CAP_X86_VMWARE_HYPERCALL
+---------------------------------
+
+:Architectures: x86
+:Parameters: args[0] whether the feature should be enabled or not
+:Returns: 0 on success.
+
+Capability allows userspace to handle hypercalls. When enabled
+whenever the vcpu has executed a VMCALL(Intel) or a VMMCALL(AMD)
+instruction kvm will exit to userspace with KVM_EXIT_HYPERCALL.
+
+On exit the hypercall structure of the kvm_run structure will
+look as follows:
+
+::
+   /* KVM_EXIT_HYPERCALL */
+   struct {
+      __u64 nr;      // rax
+      __u64 args[6]; // rbx, rcx, rdx, rsi, rdi, rbp
+      __u64 ret;     // cpl, whatever userspace
+                     // sets this to on return will be
+                     // written to the rax
+      __u64 flags;   // KVM_EXIT_HYPERCALL_LONG_MODE if
+                     // the hypercall was executed in
+                     // 64bit mode, 0 otherwise
+   } hypercall;
+
+Except when running in compatibility mode with VMware hypervisors
+userspace handling of hypercalls is discouraged. To implement
+such functionality, use KVM_EXIT_IO (x86) or KVM_EXIT_MMIO
+(all except s390).
+
 8. Other capabilities.
 ======================
 
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 7fcf185e337f..7fbb11682517 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1404,6 +1404,7 @@ struct kvm_arch {
 	struct kvm_xen xen;
 #endif
 	bool vmware_backdoor_enabled;
+	bool vmware_hypercall_enabled;
 
 	bool backwards_tsc_observed;
 	bool boot_vcpu_runs_old_kvmclock;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d7071907d6a5..b676c54266e7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4689,6 +4689,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_MEMORY_FAULT_INFO:
 	case KVM_CAP_X86_GUEST_MODE:
 	case KVM_CAP_X86_VMWARE_BACKDOOR:
+	case KVM_CAP_X86_VMWARE_HYPERCALL:
 		r = 1;
 		break;
 	case KVM_CAP_PRE_FAULT_MEMORY:
@@ -6784,6 +6785,13 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		}
 		mutex_unlock(&kvm->lock);
 		break;
+	case KVM_CAP_X86_VMWARE_HYPERCALL:
+		r = -EINVAL;
+		if (cap->args[0] & ~1)
+			break;
+		kvm->arch.vmware_hypercall_enabled = cap->args[0];
+		r = 0;
+		break;
 	default:
 		r = -EINVAL;
 		break;
@@ -10127,6 +10135,28 @@ static int complete_hypercall_exit(struct kvm_vcpu *vcpu)
 	return kvm_skip_emulated_instruction(vcpu);
 }
 
+static int kvm_vmware_hypercall(struct kvm_vcpu *vcpu)
+{
+	struct kvm_run *run = vcpu->run;
+	bool is_64_bit = is_64_bit_hypercall(vcpu);
+	u64 mask = is_64_bit ? U64_MAX : U32_MAX;
+
+	vcpu->run->hypercall.flags = is_64_bit ? KVM_EXIT_HYPERCALL_LONG_MODE : 0;
+	run->hypercall.nr = kvm_rax_read(vcpu) & mask;
+	run->hypercall.args[0] = kvm_rbx_read(vcpu) & mask;
+	run->hypercall.args[1] = kvm_rcx_read(vcpu) & mask;
+	run->hypercall.args[2] = kvm_rdx_read(vcpu) & mask;
+	run->hypercall.args[3] = kvm_rsi_read(vcpu) & mask;
+	run->hypercall.args[4] = kvm_rdi_read(vcpu) & mask;
+	run->hypercall.args[5] = kvm_rbp_read(vcpu) & mask;
+	run->hypercall.ret = kvm_x86_call(get_cpl)(vcpu);
+
+	run->exit_reason = KVM_EXIT_HYPERCALL;
+	vcpu->arch.complete_userspace_io = complete_hypercall_exit;
+
+	return 0;
+}
+
 unsigned long __kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
 				      unsigned long a0, unsigned long a1,
 				      unsigned long a2, unsigned long a3,
@@ -10225,6 +10255,9 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
 	int op_64_bit;
 	int cpl;
 
+	if (vcpu->kvm->arch.vmware_hypercall_enabled)
+		return kvm_vmware_hypercall(vcpu);
+
 	if (kvm_xen_hypercall_enabled(vcpu->kvm))
 		return kvm_xen_hypercall(vcpu);
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index c7b5f1c2ee1c..4c2cc6ed29a0 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -934,6 +934,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_X86_APIC_BUS_CYCLES_NS 237
 #define KVM_CAP_X86_GUEST_MODE 238
 #define KVM_CAP_X86_VMWARE_BACKDOOR 239
+#define KVM_CAP_X86_VMWARE_HYPERCALL 240
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.43.0


