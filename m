Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E917660CC31
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 14:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiJYMnh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 08:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbiJYMm5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 08:42:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1895118DAB3
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 05:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666701775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pNwX/yknDypfvbj/Q6qtMYljLDs3Vw2mj3Roo6Y33mY=;
        b=B+hjlWpbH0PKnXtsdfD/1zMUUPpZLGQEg/EFusCRehAaduy2lpxnWRzFT20qipIgaYHp6z
        iIv+kuOJXOcau/bjWa6xrFWHtP34SKY0DxpsYigVVnuz1Yxygr07psEc+yrC83tViwTW62
        VGvGhjmQqzkiz7S+Ds+gqEj55rV7Roo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-LUQjYSxXNJm8xk6qAAVqVg-1; Tue, 25 Oct 2022 08:42:50 -0400
X-MC-Unique: LUQjYSxXNJm8xk6qAAVqVg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE333185A7AB;
        Tue, 25 Oct 2022 12:42:49 +0000 (UTC)
Received: from amdlaptop.tlv.redhat.com (dhcp-4-238.tlv.redhat.com [10.35.4.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D37E20290A2;
        Tue, 25 Oct 2022 12:42:46 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Yang Zhong <yang.zhong@intel.com>,
        linux-kselftest@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        Guang Zeng <guang.zeng@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        Wei Wang <wei.w.wang@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH v4 06/23] KVM: x86: compile out vendor-specific code if SMM is disabled
Date:   Tue, 25 Oct 2022 15:42:06 +0300
Message-Id: <20221025124223.227577-7-mlevitsk@redhat.com>
In-Reply-To: <20221025124223.227577-1-mlevitsk@redhat.com>
References: <20221025124223.227577-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

Vendor-specific code that deals with SMI injection and saving/restoring
SMM state is not needed if CONFIG_KVM_SMM is disabled, so remove the
four callbacks smi_allowed, enter_smm, leave_smm and enable_smi_window.
The users in svm/nested.c and x86.c also have to be compiled out; the
amount of #ifdef'ed code is small and it's not worth moving it to
smm.c.

enter_smm is now used only within #ifdef CONFIG_KVM_SMM, and the stub
can therefore be removed.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm-x86-ops.h | 2 ++
 arch/x86/include/asm/kvm_host.h    | 2 ++
 arch/x86/kvm/smm.h                 | 1 -
 arch/x86/kvm/svm/nested.c          | 2 ++
 arch/x86/kvm/svm/svm.c             | 4 ++++
 arch/x86/kvm/vmx/vmx.c             | 4 ++++
 arch/x86/kvm/x86.c                 | 4 ++++
 7 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 82ba4a564e5875..ea58e67e9a6701 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -110,10 +110,12 @@ KVM_X86_OP_OPTIONAL_RET0(dy_apicv_has_pending_interrupt)
 KVM_X86_OP_OPTIONAL(set_hv_timer)
 KVM_X86_OP_OPTIONAL(cancel_hv_timer)
 KVM_X86_OP(setup_mce)
+#ifdef CONFIG_KVM_SMM
 KVM_X86_OP(smi_allowed)
 KVM_X86_OP(enter_smm)
 KVM_X86_OP(leave_smm)
 KVM_X86_OP(enable_smi_window)
+#endif
 KVM_X86_OP_OPTIONAL(mem_enc_ioctl)
 KVM_X86_OP_OPTIONAL(mem_enc_register_region)
 KVM_X86_OP_OPTIONAL(mem_enc_unregister_region)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 4afed04fcc8241..541ed36cbb82f8 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1607,10 +1607,12 @@ struct kvm_x86_ops {
 
 	void (*setup_mce)(struct kvm_vcpu *vcpu);
 
+#ifdef CONFIG_KVM_SMM
 	int (*smi_allowed)(struct kvm_vcpu *vcpu, bool for_injection);
 	int (*enter_smm)(struct kvm_vcpu *vcpu, char *smstate);
 	int (*leave_smm)(struct kvm_vcpu *vcpu, const char *smstate);
 	void (*enable_smi_window)(struct kvm_vcpu *vcpu);
+#endif
 
 	int (*mem_enc_ioctl)(struct kvm *kvm, void __user *argp);
 	int (*mem_enc_register_region)(struct kvm *kvm, struct kvm_enc_region *argp);
diff --git a/arch/x86/kvm/smm.h b/arch/x86/kvm/smm.h
index 4c699fee449296..7ccce6b655cacf 100644
--- a/arch/x86/kvm/smm.h
+++ b/arch/x86/kvm/smm.h
@@ -28,7 +28,6 @@ void process_smi(struct kvm_vcpu *vcpu);
 static inline int kvm_inject_smi(struct kvm_vcpu *vcpu) { return -ENOTTY; }
 static inline bool is_smm(struct kvm_vcpu *vcpu) { return false; }
 static inline void kvm_smm_changed(struct kvm_vcpu *vcpu, bool in_smm) { WARN_ON_ONCE(1); }
-static inline void enter_smm(struct kvm_vcpu *vcpu) { WARN_ON_ONCE(1); }
 static inline void process_smi(struct kvm_vcpu *vcpu) { WARN_ON_ONCE(1); }
 
 /*
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index cc0fd75f7cbab5..b258d6988f5dde 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1378,6 +1378,7 @@ static int svm_check_nested_events(struct kvm_vcpu *vcpu)
 		return 0;
 	}
 
+#ifdef CONFIG_KVM_SMM
 	if (vcpu->arch.smi_pending && !svm_smi_blocked(vcpu)) {
 		if (block_nested_events)
 			return -EBUSY;
@@ -1386,6 +1387,7 @@ static int svm_check_nested_events(struct kvm_vcpu *vcpu)
 		nested_svm_simple_vmexit(svm, SVM_EXIT_SMI);
 		return 0;
 	}
+#endif
 
 	if (vcpu->arch.nmi_pending && !svm_nmi_blocked(vcpu)) {
 		if (block_nested_events)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 6f7ceb35d2ff08..2200b8aa727398 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4408,6 +4408,7 @@ static void svm_setup_mce(struct kvm_vcpu *vcpu)
 	vcpu->arch.mcg_cap &= 0x1ff;
 }
 
+#ifdef CONFIG_KVM_SMM
 bool svm_smi_blocked(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -4557,6 +4558,7 @@ static void svm_enable_smi_window(struct kvm_vcpu *vcpu)
 		/* We must be in SMM; RSM will cause a vmexit anyway.  */
 	}
 }
+#endif
 
 static bool svm_can_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
 					void *insn, int insn_len)
@@ -4832,10 +4834,12 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.pi_update_irte = avic_pi_update_irte,
 	.setup_mce = svm_setup_mce,
 
+#ifdef CONFIG_KVM_SMM
 	.smi_allowed = svm_smi_allowed,
 	.enter_smm = svm_enter_smm,
 	.leave_smm = svm_leave_smm,
 	.enable_smi_window = svm_enable_smi_window,
+#endif
 
 	.mem_enc_ioctl = sev_mem_enc_ioctl,
 	.mem_enc_register_region = sev_mem_enc_register_region,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b22330a15adb63..107fc035c91b80 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7905,6 +7905,7 @@ static void vmx_setup_mce(struct kvm_vcpu *vcpu)
 			~FEAT_CTL_LMCE_ENABLED;
 }
 
+#ifdef CONFIG_KVM_SMM
 static int vmx_smi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 {
 	/* we need a nested vmexit to enter SMM, postpone if run is pending */
@@ -7959,6 +7960,7 @@ static void vmx_enable_smi_window(struct kvm_vcpu *vcpu)
 {
 	/* RSM will cause a vmexit anyway.  */
 }
+#endif
 
 static bool vmx_apic_init_signal_blocked(struct kvm_vcpu *vcpu)
 {
@@ -8126,10 +8128,12 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 
 	.setup_mce = vmx_setup_mce,
 
+#ifdef CONFIG_KVM_SMM
 	.smi_allowed = vmx_smi_allowed,
 	.enter_smm = vmx_enter_smm,
 	.leave_smm = vmx_leave_smm,
 	.enable_smi_window = vmx_enable_smi_window,
+#endif
 
 	.can_emulate_instruction = vmx_can_emulate_instruction,
 	.apic_init_signal_blocked = vmx_apic_init_signal_blocked,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6c81d3a606e257..8394cd62c2854c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9876,6 +9876,7 @@ static int kvm_check_and_inject_events(struct kvm_vcpu *vcpu,
 	 * in order to make progress and get back here for another iteration.
 	 * The kvm_x86_ops hooks communicate this by returning -EBUSY.
 	 */
+#ifdef CONFIG_KVM_SMM
 	if (vcpu->arch.smi_pending) {
 		r = can_inject ? static_call(kvm_x86_smi_allowed)(vcpu, true) : -EBUSY;
 		if (r < 0)
@@ -9888,6 +9889,7 @@ static int kvm_check_and_inject_events(struct kvm_vcpu *vcpu,
 		} else
 			static_call(kvm_x86_enable_smi_window)(vcpu);
 	}
+#endif
 
 	if (vcpu->arch.nmi_pending) {
 		r = can_inject ? static_call(kvm_x86_nmi_allowed)(vcpu, true) : -EBUSY;
@@ -12517,10 +12519,12 @@ static inline bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
 	     static_call(kvm_x86_nmi_allowed)(vcpu, false)))
 		return true;
 
+#ifdef CONFIG_KVM_SMM
 	if (kvm_test_request(KVM_REQ_SMI, vcpu) ||
 	    (vcpu->arch.smi_pending &&
 	     static_call(kvm_x86_smi_allowed)(vcpu, false)))
 		return true;
+#endif
 
 	if (kvm_arch_interrupt_allowed(vcpu) &&
 	    (kvm_cpu_has_interrupt(vcpu) ||
-- 
2.34.3

