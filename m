Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293A460CCAF
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 14:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiJYMxD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 08:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJYMwC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 08:52:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDDE1B9D1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 05:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666702162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gJUNcGxmOJfvfcWZcz/OnVh6Up75cu04sSjAlRoGj2A=;
        b=cjROtV+fGaBLMEkAd9bLfSXWBsAX79ZLckssmwaWKuwYJlCNflCM2GB+28JBJPNpvOc9cs
        l4tl7+2D2U/hjCZGFMBlGCcBIXQhns/6a5wkXCDT8X8MW1H7pCv1s8FqBxxheccRHW06nE
        DyYvWABZtk2TfgozBYqk/g2hj4IYwuA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-vKpvt0yqOzCkZid0jZU0NQ-1; Tue, 25 Oct 2022 08:49:16 -0400
X-MC-Unique: vKpvt0yqOzCkZid0jZU0NQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 066AA857AA0;
        Tue, 25 Oct 2022 12:49:16 +0000 (UTC)
Received: from amdlaptop.tlv.redhat.com (dhcp-4-238.tlv.redhat.com [10.35.4.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A75F940C6EC6;
        Tue, 25 Oct 2022 12:49:12 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Yang Zhong <yang.zhong@intel.com>, x86@kernel.org,
        Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Shuah Khan <shuah@kernel.org>,
        Guang Zeng <guang.zeng@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Wei Wang <wei.w.wang@intel.com>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH RESEND v4 23/23] KVM: x86: smm: preserve interrupt shadow in SMRAM
Date:   Tue, 25 Oct 2022 15:47:41 +0300
Message-Id: <20221025124741.228045-24-mlevitsk@redhat.com>
In-Reply-To: <20221025124741.228045-1-mlevitsk@redhat.com>
References: <20221025124741.228045-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When #SMI is asserted, the CPU can be in interrupt shadow due to sti or
mov ss.

It is not mandatory in  Intel/AMD prm to have the #SMI blocked during the
shadow, and on top of that, since neither SVM nor VMX has true support
for SMI window, waiting for one instruction would mean single stepping
the guest.

Instead, allow #SMI in this case, but both reset the interrupt window and
stash its value in SMRAM to restore it on exit from SMM.

This fixes rare failures seen mostly on windows guests on VMX, when #SMI
falls on the sti instruction which mainfest in VM entry failure due
to EFLAGS.IF not being set, but STI interrupt window still being set
in the VMCS.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/smm.c | 24 +++++++++++++++++++++---
 arch/x86/kvm/smm.h |  5 +++--
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
index 82761384a8664d..46d2656937a71c 100644
--- a/arch/x86/kvm/smm.c
+++ b/arch/x86/kvm/smm.c
@@ -21,6 +21,7 @@ static void check_smram_offsets(void)
 	CHECK_SMRAM32_OFFSET(smbase,			0xFEF8);
 	CHECK_SMRAM32_OFFSET(smm_revision,		0xFEFC);
 	CHECK_SMRAM32_OFFSET(reserved2,			0xFF00);
+	CHECK_SMRAM32_OFFSET(int_shadow,		0xFF10);
 	CHECK_SMRAM32_OFFSET(cr4,			0xFF14);
 	CHECK_SMRAM32_OFFSET(reserved3,			0xFF18);
 	CHECK_SMRAM32_OFFSET(ds,			0xFF2C);
@@ -65,7 +66,7 @@ static void check_smram_offsets(void)
 	CHECK_SMRAM64_OFFSET(io_restart_rsi,		0xFEB0);
 	CHECK_SMRAM64_OFFSET(io_restart_rdi,		0xFEB8);
 	CHECK_SMRAM64_OFFSET(io_restart_dword,		0xFEC0);
-	CHECK_SMRAM64_OFFSET(reserved1,			0xFEC4);
+	CHECK_SMRAM64_OFFSET(int_shadow,		0xFEC4);
 	CHECK_SMRAM64_OFFSET(io_inst_restart,		0xFEC8);
 	CHECK_SMRAM64_OFFSET(auto_hlt_restart,		0xFEC9);
 	CHECK_SMRAM64_OFFSET(reserved2,			0xFECA);
@@ -212,6 +213,8 @@ static void enter_smm_save_state_32(struct kvm_vcpu *vcpu,
 	smram->cr4 = kvm_read_cr4(vcpu);
 	smram->smm_revision = 0x00020000;
 	smram->smbase = vcpu->arch.smbase;
+
+	smram->int_shadow = static_call(kvm_x86_get_interrupt_shadow)(vcpu);
 }
 
 #ifdef CONFIG_X86_64
@@ -261,6 +264,8 @@ static void enter_smm_save_state_64(struct kvm_vcpu *vcpu,
 	enter_smm_save_seg_64(vcpu, &smram->ds, VCPU_SREG_DS);
 	enter_smm_save_seg_64(vcpu, &smram->fs, VCPU_SREG_FS);
 	enter_smm_save_seg_64(vcpu, &smram->gs, VCPU_SREG_GS);
+
+	smram->int_shadow = static_call(kvm_x86_get_interrupt_shadow)(vcpu);
 }
 #endif
 
@@ -306,6 +311,8 @@ void enter_smm(struct kvm_vcpu *vcpu)
 	kvm_set_rflags(vcpu, X86_EFLAGS_FIXED);
 	kvm_rip_write(vcpu, 0x8000);
 
+	static_call(kvm_x86_set_interrupt_shadow)(vcpu, 0);
+
 	cr0 = vcpu->arch.cr0 & ~(X86_CR0_PE | X86_CR0_EM | X86_CR0_TS | X86_CR0_PG);
 	static_call(kvm_x86_set_cr0)(vcpu, cr0);
 	vcpu->arch.cr0 = cr0;
@@ -453,7 +460,7 @@ static int rsm_load_state_32(struct x86_emulate_ctxt *ctxt,
 {
 	struct kvm_vcpu *vcpu = ctxt->vcpu;
 	struct desc_ptr dt;
-	int i;
+	int i, r;
 
 	ctxt->eflags =  smstate->eflags | X86_EFLAGS_FIXED;
 	ctxt->_eip =  smstate->eip;
@@ -487,8 +494,16 @@ static int rsm_load_state_32(struct x86_emulate_ctxt *ctxt,
 
 	vcpu->arch.smbase = smstate->smbase;
 
-	return rsm_enter_protected_mode(vcpu, smstate->cr0,
+	r = rsm_enter_protected_mode(vcpu, smstate->cr0,
 					smstate->cr3, smstate->cr4);
+
+	if (r != X86EMUL_CONTINUE)
+		return r;
+
+	static_call(kvm_x86_set_interrupt_shadow)(vcpu, 0);
+	ctxt->interruptibility = (u8)smstate->int_shadow;
+
+	return r;
 }
 
 #ifdef CONFIG_X86_64
@@ -539,6 +554,9 @@ static int rsm_load_state_64(struct x86_emulate_ctxt *ctxt,
 	rsm_load_seg_64(vcpu, &smstate->fs, VCPU_SREG_FS);
 	rsm_load_seg_64(vcpu, &smstate->gs, VCPU_SREG_GS);
 
+	static_call(kvm_x86_set_interrupt_shadow)(vcpu, 0);
+	ctxt->interruptibility = (u8)smstate->int_shadow;
+
 	return X86EMUL_CONTINUE;
 }
 #endif
diff --git a/arch/x86/kvm/smm.h b/arch/x86/kvm/smm.h
index 8d96bff3f4d54f..2eaec53bcc9504 100644
--- a/arch/x86/kvm/smm.h
+++ b/arch/x86/kvm/smm.h
@@ -19,7 +19,8 @@ struct kvm_smram_state_32 {
 	u32 reserved1[62];
 	u32 smbase;
 	u32 smm_revision;
-	u32 reserved2[5];
+	u32 reserved2[4];
+	u32 int_shadow; /* KVM extension */
 	u32 cr4; /* CR4 is not present in Intel/AMD SMRAM image */
 	u32 reserved3[5];
 
@@ -86,7 +87,7 @@ struct kvm_smram_state_64 {
 	u64 io_restart_rsi;
 	u64 io_restart_rdi;
 	u32 io_restart_dword;
-	u32 reserved1;
+	u32 int_shadow;
 	u8 io_inst_restart;
 	u8 auto_hlt_restart;
 	u8 reserved2[6];
-- 
2.34.3

