Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3227E60CCA4
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 14:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbiJYMwd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 08:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbiJYMv5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 08:51:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C0C18F900
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 05:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666702144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=74gGRO7x1azIVqAg72Iofd8H0W4GE+zT/7jivu7bvas=;
        b=CPodyVpKg382TnKKPVVqpPN/HttbJaJVaMex/i3bn9aOK4H+dNIhvnrju4O/Xz28uVBKA+
        RGDC5JwlYFYXTZO+3dV1y3YcTFaukLgrGoTnh7c+3mAjY4s7jt2E66lZWFxlqjGBKG3KUU
        PGvnQrG6fxiJTbB6BlrQoTJIyZNEEJg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-lXbi0LgPNu2qcN7QXmNEhQ-1; Tue, 25 Oct 2022 08:48:59 -0400
X-MC-Unique: lXbi0LgPNu2qcN7QXmNEhQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D32B1185A7B0;
        Tue, 25 Oct 2022 12:48:57 +0000 (UTC)
Received: from amdlaptop.tlv.redhat.com (dhcp-4-238.tlv.redhat.com [10.35.4.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 80DF440C6EC6;
        Tue, 25 Oct 2022 12:48:54 +0000 (UTC)
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
Subject: [PATCH RESEND v4 18/23] KVM: x86: smm: use smram struct for 32 bit smram load/restore
Date:   Tue, 25 Oct 2022 15:47:36 +0300
Message-Id: <20221025124741.228045-19-mlevitsk@redhat.com>
In-Reply-To: <20221025124741.228045-1-mlevitsk@redhat.com>
References: <20221025124741.228045-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use kvm_smram_state_32 struct to save/restore 32 bit SMM state
(used when X86_FEATURE_LM is not present in the guest CPUID).

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/smm.c | 155 ++++++++++++++++++---------------------------
 1 file changed, 61 insertions(+), 94 deletions(-)

diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
index e714d43b746cce..2635f6b1d81a3c 100644
--- a/arch/x86/kvm/smm.c
+++ b/arch/x86/kvm/smm.c
@@ -142,22 +142,17 @@ static u32 enter_smm_get_segment_flags(struct kvm_segment *seg)
 	return flags;
 }
 
-static void enter_smm_save_seg_32(struct kvm_vcpu *vcpu, char *buf, int n)
+static void enter_smm_save_seg_32(struct kvm_vcpu *vcpu,
+				  struct kvm_smm_seg_state_32 *state,
+				  u32 *selector, int n)
 {
 	struct kvm_segment seg;
-	int offset;
 
 	kvm_get_segment(vcpu, &seg, n);
-	PUT_SMSTATE(u32, buf, 0x7fa8 + n * 4, seg.selector);
-
-	if (n < 3)
-		offset = 0x7f84 + n * 12;
-	else
-		offset = 0x7f2c + (n - 3) * 12;
-
-	PUT_SMSTATE(u32, buf, offset + 8, seg.base);
-	PUT_SMSTATE(u32, buf, offset + 4, seg.limit);
-	PUT_SMSTATE(u32, buf, offset, enter_smm_get_segment_flags(&seg));
+	*selector = seg.selector;
+	state->base = seg.base;
+	state->limit = seg.limit;
+	state->flags = enter_smm_get_segment_flags(&seg);
 }
 
 #ifdef CONFIG_X86_64
@@ -178,54 +173,48 @@ static void enter_smm_save_seg_64(struct kvm_vcpu *vcpu, char *buf, int n)
 }
 #endif
 
-static void enter_smm_save_state_32(struct kvm_vcpu *vcpu, char *buf)
+static void enter_smm_save_state_32(struct kvm_vcpu *vcpu,
+				    struct kvm_smram_state_32 *smram)
 {
 	struct desc_ptr dt;
-	struct kvm_segment seg;
 	unsigned long val;
 	int i;
 
-	PUT_SMSTATE(u32, buf, 0x7ffc, kvm_read_cr0(vcpu));
-	PUT_SMSTATE(u32, buf, 0x7ff8, kvm_read_cr3(vcpu));
-	PUT_SMSTATE(u32, buf, 0x7ff4, kvm_get_rflags(vcpu));
-	PUT_SMSTATE(u32, buf, 0x7ff0, kvm_rip_read(vcpu));
+	smram->cr0     = kvm_read_cr0(vcpu);
+	smram->cr3     = kvm_read_cr3(vcpu);
+	smram->eflags  = kvm_get_rflags(vcpu);
+	smram->eip     = kvm_rip_read(vcpu);
 
 	for (i = 0; i < 8; i++)
-		PUT_SMSTATE(u32, buf, 0x7fd0 + i * 4, kvm_register_read_raw(vcpu, i));
+		smram->gprs[i] = kvm_register_read_raw(vcpu, i);
 
 	kvm_get_dr(vcpu, 6, &val);
-	PUT_SMSTATE(u32, buf, 0x7fcc, (u32)val);
+	smram->dr6     = (u32)val;
 	kvm_get_dr(vcpu, 7, &val);
-	PUT_SMSTATE(u32, buf, 0x7fc8, (u32)val);
+	smram->dr7     = (u32)val;
 
-	kvm_get_segment(vcpu, &seg, VCPU_SREG_TR);
-	PUT_SMSTATE(u32, buf, 0x7fc4, seg.selector);
-	PUT_SMSTATE(u32, buf, 0x7f64, seg.base);
-	PUT_SMSTATE(u32, buf, 0x7f60, seg.limit);
-	PUT_SMSTATE(u32, buf, 0x7f5c, enter_smm_get_segment_flags(&seg));
-
-	kvm_get_segment(vcpu, &seg, VCPU_SREG_LDTR);
-	PUT_SMSTATE(u32, buf, 0x7fc0, seg.selector);
-	PUT_SMSTATE(u32, buf, 0x7f80, seg.base);
-	PUT_SMSTATE(u32, buf, 0x7f7c, seg.limit);
-	PUT_SMSTATE(u32, buf, 0x7f78, enter_smm_get_segment_flags(&seg));
+	enter_smm_save_seg_32(vcpu, &smram->tr, &smram->tr_sel, VCPU_SREG_TR);
+	enter_smm_save_seg_32(vcpu, &smram->ldtr, &smram->ldtr_sel, VCPU_SREG_LDTR);
 
 	static_call(kvm_x86_get_gdt)(vcpu, &dt);
-	PUT_SMSTATE(u32, buf, 0x7f74, dt.address);
-	PUT_SMSTATE(u32, buf, 0x7f70, dt.size);
+	smram->gdtr.base = dt.address;
+	smram->gdtr.limit = dt.size;
 
 	static_call(kvm_x86_get_idt)(vcpu, &dt);
-	PUT_SMSTATE(u32, buf, 0x7f58, dt.address);
-	PUT_SMSTATE(u32, buf, 0x7f54, dt.size);
+	smram->idtr.base = dt.address;
+	smram->idtr.limit = dt.size;
 
-	for (i = 0; i < 6; i++)
-		enter_smm_save_seg_32(vcpu, buf, i);
+	enter_smm_save_seg_32(vcpu, &smram->es, &smram->es_sel, VCPU_SREG_ES);
+	enter_smm_save_seg_32(vcpu, &smram->cs, &smram->cs_sel, VCPU_SREG_CS);
+	enter_smm_save_seg_32(vcpu, &smram->ss, &smram->ss_sel, VCPU_SREG_SS);
 
-	PUT_SMSTATE(u32, buf, 0x7f14, kvm_read_cr4(vcpu));
+	enter_smm_save_seg_32(vcpu, &smram->ds, &smram->ds_sel, VCPU_SREG_DS);
+	enter_smm_save_seg_32(vcpu, &smram->fs, &smram->fs_sel, VCPU_SREG_FS);
+	enter_smm_save_seg_32(vcpu, &smram->gs, &smram->gs_sel, VCPU_SREG_GS);
 
-	/* revision id */
-	PUT_SMSTATE(u32, buf, 0x7efc, 0x00020000);
-	PUT_SMSTATE(u32, buf, 0x7ef8, vcpu->arch.smbase);
+	smram->cr4 = kvm_read_cr4(vcpu);
+	smram->smm_revision = 0x00020000;
+	smram->smbase = vcpu->arch.smbase;
 }
 
 #ifdef CONFIG_X86_64
@@ -299,7 +288,7 @@ void enter_smm(struct kvm_vcpu *vcpu)
 		enter_smm_save_state_64(vcpu, smram.bytes);
 	else
 #endif
-		enter_smm_save_state_32(vcpu, smram.bytes);
+		enter_smm_save_state_32(vcpu, &smram.smram32);
 
 	/*
 	 * Give enter_smm() a chance to make ISA-specific changes to the vCPU
@@ -391,21 +380,16 @@ static void rsm_set_desc_flags(struct kvm_segment *desc, u32 flags)
 	desc->padding = 0;
 }
 
-static int rsm_load_seg_32(struct kvm_vcpu *vcpu, const char *smstate,
-			   int n)
+static int rsm_load_seg_32(struct kvm_vcpu *vcpu,
+			   const struct kvm_smm_seg_state_32 *state,
+			   u16 selector, int n)
 {
 	struct kvm_segment desc;
-	int offset;
-
-	if (n < 3)
-		offset = 0x7f84 + n * 12;
-	else
-		offset = 0x7f2c + (n - 3) * 12;
 
-	desc.selector =           GET_SMSTATE(u32, smstate, 0x7fa8 + n * 4);
-	desc.base =               GET_SMSTATE(u32, smstate, offset + 8);
-	desc.limit =              GET_SMSTATE(u32, smstate, offset + 4);
-	rsm_set_desc_flags(&desc, GET_SMSTATE(u32, smstate, offset));
+	desc.selector =           selector;
+	desc.base =               state->base;
+	desc.limit =              state->limit;
+	rsm_set_desc_flags(&desc, state->flags);
 	kvm_set_segment(vcpu, &desc, n);
 	return X86EMUL_CONTINUE;
 }
@@ -474,63 +458,46 @@ static int rsm_enter_protected_mode(struct kvm_vcpu *vcpu,
 }
 
 static int rsm_load_state_32(struct x86_emulate_ctxt *ctxt,
-			     u8 *smstate)
+			     const struct kvm_smram_state_32 *smstate)
 {
 	struct kvm_vcpu *vcpu = ctxt->vcpu;
-	struct kvm_segment desc;
 	struct desc_ptr dt;
-	u32 val, cr0, cr3, cr4;
 	int i;
 
-	cr0 =                      GET_SMSTATE(u32, smstate, 0x7ffc);
-	cr3 =                      GET_SMSTATE(u32, smstate, 0x7ff8);
-	ctxt->eflags =             GET_SMSTATE(u32, smstate, 0x7ff4) | X86_EFLAGS_FIXED;
-	ctxt->_eip =               GET_SMSTATE(u32, smstate, 0x7ff0);
+	ctxt->eflags =  smstate->eflags | X86_EFLAGS_FIXED;
+	ctxt->_eip =  smstate->eip;
 
 	for (i = 0; i < 8; i++)
-		*reg_write(ctxt, i) = GET_SMSTATE(u32, smstate, 0x7fd0 + i * 4);
-
-	val = GET_SMSTATE(u32, smstate, 0x7fcc);
+		*reg_write(ctxt, i) = smstate->gprs[i];
 
-	if (kvm_set_dr(vcpu, 6, val))
+	if (kvm_set_dr(vcpu, 6, smstate->dr6))
 		return X86EMUL_UNHANDLEABLE;
-
-	val = GET_SMSTATE(u32, smstate, 0x7fc8);
-
-	if (kvm_set_dr(vcpu, 7, val))
+	if (kvm_set_dr(vcpu, 7, smstate->dr7))
 		return X86EMUL_UNHANDLEABLE;
 
-	desc.selector =            GET_SMSTATE(u32, smstate, 0x7fc4);
-	desc.base =                GET_SMSTATE(u32, smstate, 0x7f64);
-	desc.limit =               GET_SMSTATE(u32, smstate, 0x7f60);
-	rsm_set_desc_flags(&desc,  GET_SMSTATE(u32, smstate, 0x7f5c));
-	kvm_set_segment(vcpu, &desc, VCPU_SREG_TR);
-
-	desc.selector =            GET_SMSTATE(u32, smstate, 0x7fc0);
-	desc.base =                GET_SMSTATE(u32, smstate, 0x7f80);
-	desc.limit =               GET_SMSTATE(u32, smstate, 0x7f7c);
-	rsm_set_desc_flags(&desc,  GET_SMSTATE(u32, smstate, 0x7f78));
-	kvm_set_segment(vcpu, &desc, VCPU_SREG_LDTR);
+	rsm_load_seg_32(vcpu, &smstate->tr, smstate->tr_sel, VCPU_SREG_TR);
+	rsm_load_seg_32(vcpu, &smstate->ldtr, smstate->ldtr_sel, VCPU_SREG_LDTR);
 
-	dt.address =               GET_SMSTATE(u32, smstate, 0x7f74);
-	dt.size =                  GET_SMSTATE(u32, smstate, 0x7f70);
+	dt.address =               smstate->gdtr.base;
+	dt.size =                  smstate->gdtr.limit;
 	static_call(kvm_x86_set_gdt)(vcpu, &dt);
 
-	dt.address =               GET_SMSTATE(u32, smstate, 0x7f58);
-	dt.size =                  GET_SMSTATE(u32, smstate, 0x7f54);
+	dt.address =               smstate->idtr.base;
+	dt.size =                  smstate->idtr.limit;
 	static_call(kvm_x86_set_idt)(vcpu, &dt);
 
-	for (i = 0; i < 6; i++) {
-		int r = rsm_load_seg_32(vcpu, smstate, i);
-		if (r != X86EMUL_CONTINUE)
-			return r;
-	}
+	rsm_load_seg_32(vcpu, &smstate->es, smstate->es_sel, VCPU_SREG_ES);
+	rsm_load_seg_32(vcpu, &smstate->cs, smstate->cs_sel, VCPU_SREG_CS);
+	rsm_load_seg_32(vcpu, &smstate->ss, smstate->ss_sel, VCPU_SREG_SS);
 
-	cr4 = GET_SMSTATE(u32, smstate, 0x7f14);
+	rsm_load_seg_32(vcpu, &smstate->ds, smstate->ds_sel, VCPU_SREG_DS);
+	rsm_load_seg_32(vcpu, &smstate->fs, smstate->fs_sel, VCPU_SREG_FS);
+	rsm_load_seg_32(vcpu, &smstate->gs, smstate->gs_sel, VCPU_SREG_GS);
 
-	vcpu->arch.smbase = GET_SMSTATE(u32, smstate, 0x7ef8);
+	vcpu->arch.smbase = smstate->smbase;
 
-	return rsm_enter_protected_mode(vcpu, cr0, cr3, cr4);
+	return rsm_enter_protected_mode(vcpu, smstate->cr0,
+					smstate->cr3, smstate->cr4);
 }
 
 #ifdef CONFIG_X86_64
@@ -675,5 +642,5 @@ int emulator_leave_smm(struct x86_emulate_ctxt *ctxt)
 		return rsm_load_state_64(ctxt, smram.bytes);
 	else
 #endif
-		return rsm_load_state_32(ctxt, smram.bytes);
+		return rsm_load_state_32(ctxt, &smram.smram32);
 }
-- 
2.34.3

