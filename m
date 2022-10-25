Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFADA60CCA7
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 14:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbiJYMws (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 08:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbiJYMv6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 08:51:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80F91863E7
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 05:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666702147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H6ylXknAsoEq5dIGj7qOfx5BAsXiIG3cOZpseTssG5Q=;
        b=PTjFniCIpRdWECHsFufVI3pmmhZjgNFyoDxJXj8LtdUtRfNSSOMAxrdXDnt4+TNqDwp2he
        dHr8FgqP6bhXRdfIqVygth6bZn96LrhxvCgeW5ql+/7mW5tgdBP0CZBNyvcFzJaqoXWX9g
        Rtp2z/vmGscvjUKEeEIlC5MXAynjlxI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-221-FBcqRqaPNHaEJXvD1jzPRA-1; Tue, 25 Oct 2022 08:49:03 -0400
X-MC-Unique: FBcqRqaPNHaEJXvD1jzPRA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 77FAC29DD98A;
        Tue, 25 Oct 2022 12:49:01 +0000 (UTC)
Received: from amdlaptop.tlv.redhat.com (dhcp-4-238.tlv.redhat.com [10.35.4.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 262BD40C6EC6;
        Tue, 25 Oct 2022 12:48:58 +0000 (UTC)
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
Subject: [PATCH RESEND v4 19/23] KVM: x86: smm: use smram struct for 64 bit smram load/restore
Date:   Tue, 25 Oct 2022 15:47:37 +0300
Message-Id: <20221025124741.228045-20-mlevitsk@redhat.com>
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

Use kvm_smram_state_64 struct to save/restore the 64 bit SMM state
(used when X86_FEATURE_LM is present in the guest CPUID,
regardless of 32-bitness of the guest).

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/smm.c | 153 +++++++++++++++++++--------------------------
 1 file changed, 63 insertions(+), 90 deletions(-)

diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
index 2635f6b1d81a3c..82761384a8664d 100644
--- a/arch/x86/kvm/smm.c
+++ b/arch/x86/kvm/smm.c
@@ -156,20 +156,17 @@ static void enter_smm_save_seg_32(struct kvm_vcpu *vcpu,
 }
 
 #ifdef CONFIG_X86_64
-static void enter_smm_save_seg_64(struct kvm_vcpu *vcpu, char *buf, int n)
+static void enter_smm_save_seg_64(struct kvm_vcpu *vcpu,
+				  struct kvm_smm_seg_state_64 *state,
+				  int n)
 {
 	struct kvm_segment seg;
-	int offset;
-	u16 flags;
 
 	kvm_get_segment(vcpu, &seg, n);
-	offset = 0x7e00 + n * 16;
-
-	flags = enter_smm_get_segment_flags(&seg) >> 8;
-	PUT_SMSTATE(u16, buf, offset, seg.selector);
-	PUT_SMSTATE(u16, buf, offset + 2, flags);
-	PUT_SMSTATE(u32, buf, offset + 4, seg.limit);
-	PUT_SMSTATE(u64, buf, offset + 8, seg.base);
+	state->selector = seg.selector;
+	state->attributes = enter_smm_get_segment_flags(&seg) >> 8;
+	state->limit = seg.limit;
+	state->base = seg.base;
 }
 #endif
 
@@ -218,57 +215,52 @@ static void enter_smm_save_state_32(struct kvm_vcpu *vcpu,
 }
 
 #ifdef CONFIG_X86_64
-static void enter_smm_save_state_64(struct kvm_vcpu *vcpu, char *buf)
+static void enter_smm_save_state_64(struct kvm_vcpu *vcpu,
+				    struct kvm_smram_state_64 *smram)
 {
 	struct desc_ptr dt;
-	struct kvm_segment seg;
 	unsigned long val;
 	int i;
 
 	for (i = 0; i < 16; i++)
-		PUT_SMSTATE(u64, buf, 0x7ff8 - i * 8, kvm_register_read_raw(vcpu, i));
+		smram->gprs[15 - i] = kvm_register_read_raw(vcpu, i);
+
+	smram->rip    = kvm_rip_read(vcpu);
+	smram->rflags = kvm_get_rflags(vcpu);
 
-	PUT_SMSTATE(u64, buf, 0x7f78, kvm_rip_read(vcpu));
-	PUT_SMSTATE(u32, buf, 0x7f70, kvm_get_rflags(vcpu));
 
 	kvm_get_dr(vcpu, 6, &val);
-	PUT_SMSTATE(u64, buf, 0x7f68, val);
+	smram->dr6 = val;
 	kvm_get_dr(vcpu, 7, &val);
-	PUT_SMSTATE(u64, buf, 0x7f60, val);
-
-	PUT_SMSTATE(u64, buf, 0x7f58, kvm_read_cr0(vcpu));
-	PUT_SMSTATE(u64, buf, 0x7f50, kvm_read_cr3(vcpu));
-	PUT_SMSTATE(u64, buf, 0x7f48, kvm_read_cr4(vcpu));
+	smram->dr7 = val;
 
-	PUT_SMSTATE(u32, buf, 0x7f00, vcpu->arch.smbase);
+	smram->cr0 = kvm_read_cr0(vcpu);
+	smram->cr3 = kvm_read_cr3(vcpu);
+	smram->cr4 = kvm_read_cr4(vcpu);
 
-	/* revision id */
-	PUT_SMSTATE(u32, buf, 0x7efc, 0x00020064);
+	smram->smbase = vcpu->arch.smbase;
+	smram->smm_revison = 0x00020064;
 
-	PUT_SMSTATE(u64, buf, 0x7ed0, vcpu->arch.efer);
+	smram->efer = vcpu->arch.efer;
 
-	kvm_get_segment(vcpu, &seg, VCPU_SREG_TR);
-	PUT_SMSTATE(u16, buf, 0x7e90, seg.selector);
-	PUT_SMSTATE(u16, buf, 0x7e92, enter_smm_get_segment_flags(&seg) >> 8);
-	PUT_SMSTATE(u32, buf, 0x7e94, seg.limit);
-	PUT_SMSTATE(u64, buf, 0x7e98, seg.base);
+	enter_smm_save_seg_64(vcpu, &smram->tr, VCPU_SREG_TR);
 
 	static_call(kvm_x86_get_idt)(vcpu, &dt);
-	PUT_SMSTATE(u32, buf, 0x7e84, dt.size);
-	PUT_SMSTATE(u64, buf, 0x7e88, dt.address);
+	smram->idtr.limit = dt.size;
+	smram->idtr.base = dt.address;
 
-	kvm_get_segment(vcpu, &seg, VCPU_SREG_LDTR);
-	PUT_SMSTATE(u16, buf, 0x7e70, seg.selector);
-	PUT_SMSTATE(u16, buf, 0x7e72, enter_smm_get_segment_flags(&seg) >> 8);
-	PUT_SMSTATE(u32, buf, 0x7e74, seg.limit);
-	PUT_SMSTATE(u64, buf, 0x7e78, seg.base);
+	enter_smm_save_seg_64(vcpu, &smram->ldtr, VCPU_SREG_LDTR);
 
 	static_call(kvm_x86_get_gdt)(vcpu, &dt);
-	PUT_SMSTATE(u32, buf, 0x7e64, dt.size);
-	PUT_SMSTATE(u64, buf, 0x7e68, dt.address);
+	smram->gdtr.limit = dt.size;
+	smram->gdtr.base = dt.address;
 
-	for (i = 0; i < 6; i++)
-		enter_smm_save_seg_64(vcpu, buf, i);
+	enter_smm_save_seg_64(vcpu, &smram->es, VCPU_SREG_ES);
+	enter_smm_save_seg_64(vcpu, &smram->cs, VCPU_SREG_CS);
+	enter_smm_save_seg_64(vcpu, &smram->ss, VCPU_SREG_SS);
+	enter_smm_save_seg_64(vcpu, &smram->ds, VCPU_SREG_DS);
+	enter_smm_save_seg_64(vcpu, &smram->fs, VCPU_SREG_FS);
+	enter_smm_save_seg_64(vcpu, &smram->gs, VCPU_SREG_GS);
 }
 #endif
 
@@ -285,7 +277,7 @@ void enter_smm(struct kvm_vcpu *vcpu)
 
 #ifdef CONFIG_X86_64
 	if (guest_cpuid_has(vcpu, X86_FEATURE_LM))
-		enter_smm_save_state_64(vcpu, smram.bytes);
+		enter_smm_save_state_64(vcpu, &smram.smram64);
 	else
 #endif
 		enter_smm_save_state_32(vcpu, &smram.smram32);
@@ -395,18 +387,17 @@ static int rsm_load_seg_32(struct kvm_vcpu *vcpu,
 }
 
 #ifdef CONFIG_X86_64
-static int rsm_load_seg_64(struct kvm_vcpu *vcpu, const char *smstate,
+
+static int rsm_load_seg_64(struct kvm_vcpu *vcpu,
+			   const struct kvm_smm_seg_state_64 *state,
 			   int n)
 {
 	struct kvm_segment desc;
-	int offset;
-
-	offset = 0x7e00 + n * 16;
 
-	desc.selector =           GET_SMSTATE(u16, smstate, offset);
-	rsm_set_desc_flags(&desc, GET_SMSTATE(u16, smstate, offset + 2) << 8);
-	desc.limit =              GET_SMSTATE(u32, smstate, offset + 4);
-	desc.base =               GET_SMSTATE(u64, smstate, offset + 8);
+	desc.selector =           state->selector;
+	rsm_set_desc_flags(&desc, state->attributes << 8);
+	desc.limit =              state->limit;
+	desc.base =               state->base;
 	kvm_set_segment(vcpu, &desc, n);
 	return X86EMUL_CONTINUE;
 }
@@ -502,69 +493,51 @@ static int rsm_load_state_32(struct x86_emulate_ctxt *ctxt,
 
 #ifdef CONFIG_X86_64
 static int rsm_load_state_64(struct x86_emulate_ctxt *ctxt,
-			     u8 *smstate)
+			     const struct kvm_smram_state_64 *smstate)
 {
 	struct kvm_vcpu *vcpu = ctxt->vcpu;
-	struct kvm_segment desc;
 	struct desc_ptr dt;
-	u64 val, cr0, cr3, cr4;
 	int i, r;
 
 
 	for (i = 0; i < 16; i++)
-		*reg_write(ctxt, i) = GET_SMSTATE(u64, smstate, 0x7ff8 - i * 8);
-
-	ctxt->_eip   = GET_SMSTATE(u64, smstate, 0x7f78);
-	ctxt->eflags = GET_SMSTATE(u32, smstate, 0x7f70) | X86_EFLAGS_FIXED;
+		*reg_write(ctxt, i) = smstate->gprs[15 - i];
 
-	val = GET_SMSTATE(u64, smstate, 0x7f68);
+	ctxt->_eip   = smstate->rip;
+	ctxt->eflags = smstate->rflags | X86_EFLAGS_FIXED;
 
-	if (kvm_set_dr(vcpu, 6, val))
+	if (kvm_set_dr(vcpu, 6, smstate->dr6))
 		return X86EMUL_UNHANDLEABLE;
-
-	val = GET_SMSTATE(u64, smstate, 0x7f60);
-
-	if (kvm_set_dr(vcpu, 7, val))
+	if (kvm_set_dr(vcpu, 7, smstate->dr7))
 		return X86EMUL_UNHANDLEABLE;
 
-	cr0 =                       GET_SMSTATE(u64, smstate, 0x7f58);
-	cr3 =                       GET_SMSTATE(u64, smstate, 0x7f50);
-	cr4 =                       GET_SMSTATE(u64, smstate, 0x7f48);
-	vcpu->arch.smbase =         GET_SMSTATE(u32, smstate, 0x7f00);
-	val =                       GET_SMSTATE(u64, smstate, 0x7ed0);
+	vcpu->arch.smbase =         smstate->smbase;
 
-	if (kvm_set_msr(vcpu, MSR_EFER, val & ~EFER_LMA))
+	if (kvm_set_msr(vcpu, MSR_EFER, smstate->efer & ~EFER_LMA))
 		return X86EMUL_UNHANDLEABLE;
 
-	desc.selector =             GET_SMSTATE(u32, smstate, 0x7e90);
-	rsm_set_desc_flags(&desc,   GET_SMSTATE(u32, smstate, 0x7e92) << 8);
-	desc.limit =                GET_SMSTATE(u32, smstate, 0x7e94);
-	desc.base =                 GET_SMSTATE(u64, smstate, 0x7e98);
-	kvm_set_segment(vcpu, &desc, VCPU_SREG_TR);
+	rsm_load_seg_64(vcpu, &smstate->tr, VCPU_SREG_TR);
 
-	dt.size =                   GET_SMSTATE(u32, smstate, 0x7e84);
-	dt.address =                GET_SMSTATE(u64, smstate, 0x7e88);
+	dt.size =                   smstate->idtr.limit;
+	dt.address =                smstate->idtr.base;
 	static_call(kvm_x86_set_idt)(vcpu, &dt);
 
-	desc.selector =             GET_SMSTATE(u32, smstate, 0x7e70);
-	rsm_set_desc_flags(&desc,   GET_SMSTATE(u32, smstate, 0x7e72) << 8);
-	desc.limit =                GET_SMSTATE(u32, smstate, 0x7e74);
-	desc.base =                 GET_SMSTATE(u64, smstate, 0x7e78);
-	kvm_set_segment(vcpu, &desc, VCPU_SREG_LDTR);
+	rsm_load_seg_64(vcpu, &smstate->ldtr, VCPU_SREG_LDTR);
 
-	dt.size =                   GET_SMSTATE(u32, smstate, 0x7e64);
-	dt.address =                GET_SMSTATE(u64, smstate, 0x7e68);
+	dt.size =                   smstate->gdtr.limit;
+	dt.address =                smstate->gdtr.base;
 	static_call(kvm_x86_set_gdt)(vcpu, &dt);
 
-	r = rsm_enter_protected_mode(vcpu, cr0, cr3, cr4);
+	r = rsm_enter_protected_mode(vcpu, smstate->cr0, smstate->cr3, smstate->cr4);
 	if (r != X86EMUL_CONTINUE)
 		return r;
 
-	for (i = 0; i < 6; i++) {
-		r = rsm_load_seg_64(vcpu, smstate, i);
-		if (r != X86EMUL_CONTINUE)
-			return r;
-	}
+	rsm_load_seg_64(vcpu, &smstate->es, VCPU_SREG_ES);
+	rsm_load_seg_64(vcpu, &smstate->cs, VCPU_SREG_CS);
+	rsm_load_seg_64(vcpu, &smstate->ss, VCPU_SREG_SS);
+	rsm_load_seg_64(vcpu, &smstate->ds, VCPU_SREG_DS);
+	rsm_load_seg_64(vcpu, &smstate->fs, VCPU_SREG_FS);
+	rsm_load_seg_64(vcpu, &smstate->gs, VCPU_SREG_GS);
 
 	return X86EMUL_CONTINUE;
 }
@@ -639,7 +612,7 @@ int emulator_leave_smm(struct x86_emulate_ctxt *ctxt)
 
 #ifdef CONFIG_X86_64
 	if (guest_cpuid_has(vcpu, X86_FEATURE_LM))
-		return rsm_load_state_64(ctxt, smram.bytes);
+		return rsm_load_state_64(ctxt, &smram.smram64);
 	else
 #endif
 		return rsm_load_state_32(ctxt, &smram.smram32);
-- 
2.34.3

