Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDEDE60CC29
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 14:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbiJYMnS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 08:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbiJYMmv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 08:42:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0AE18C402
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 05:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666701767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/7EmJTXzQv4pnITPnpEfTf/QYoiVRjnASdrISGBMxx0=;
        b=HA2ErfIM3xIpamAmID5n1tNfN48j0ZZwzyXcyQKWaV5j66fWkz7PbB6/eViCBi14uh3q0b
        FaQCXzkxSQt0S+Is6cCy9eZLtb3kpoQ2TlxnzICuZScFhf0jZSFOqPvFETmIzIyAsUBVxM
        OUC+Dol8F7/rqy7oTP6xykUV6yl7nFs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-dTjfrd5APPijGwZKhSNqQQ-1; Tue, 25 Oct 2022 08:42:44 -0400
X-MC-Unique: dTjfrd5APPijGwZKhSNqQQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 92AFF380671E;
        Tue, 25 Oct 2022 12:42:42 +0000 (UTC)
Received: from amdlaptop.tlv.redhat.com (dhcp-4-238.tlv.redhat.com [10.35.4.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40DE720290A2;
        Tue, 25 Oct 2022 12:42:39 +0000 (UTC)
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
Subject: [PATCH v4 04/23] KVM: x86: do not go through ctxt->ops when emulating rsm
Date:   Tue, 25 Oct 2022 15:42:04 +0300
Message-Id: <20221025124223.227577-5-mlevitsk@redhat.com>
In-Reply-To: <20221025124223.227577-1-mlevitsk@redhat.com>
References: <20221025124223.227577-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

Now that RSM is implemented in a single emulator callback, there is no
point in going through other callbacks for the sake of modifying
processor state.  Just invoke KVM's own internal functions directly,
and remove the callbacks that were only used by em_rsm; the only
substantial difference is in the handling of the segment registers
and descriptor cache, which have to be parsed into a struct kvm_segment
instead of a struct desc_struct.

This also fixes a bug where emulator_set_segment was shifting the
limit left by 12 if the G bit is set, but the limit had not been
shifted right upon entry to SMM.

The emulator context is still used to restore EIP and the general
purpose registers.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/kvm_emulate.h |  13 ---
 arch/x86/kvm/smm.c         | 177 +++++++++++++++++--------------------
 arch/x86/kvm/x86.c         |  33 -------
 3 files changed, 81 insertions(+), 142 deletions(-)

diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index d7afbc448dd245..84b1f266146305 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -116,16 +116,6 @@ struct x86_emulate_ops {
 			unsigned int bytes,
 			struct x86_exception *fault, bool system);
 
-	/*
-	 * read_phys: Read bytes of standard (non-emulated/special) memory.
-	 *            Used for descriptor reading.
-	 *  @addr:  [IN ] Physical address from which to read.
-	 *  @val:   [OUT] Value read from memory.
-	 *  @bytes: [IN ] Number of bytes to read from memory.
-	 */
-	int (*read_phys)(struct x86_emulate_ctxt *ctxt, unsigned long addr,
-			void *val, unsigned int bytes);
-
 	/*
 	 * write_std: Write bytes of standard (non-emulated/special) memory.
 	 *            Used for descriptor writing.
@@ -209,11 +199,8 @@ struct x86_emulate_ops {
 	int (*cpl)(struct x86_emulate_ctxt *ctxt);
 	void (*get_dr)(struct x86_emulate_ctxt *ctxt, int dr, ulong *dest);
 	int (*set_dr)(struct x86_emulate_ctxt *ctxt, int dr, ulong value);
-	u64 (*get_smbase)(struct x86_emulate_ctxt *ctxt);
-	void (*set_smbase)(struct x86_emulate_ctxt *ctxt, u64 smbase);
 	int (*set_msr_with_filter)(struct x86_emulate_ctxt *ctxt, u32 msr_index, u64 data);
 	int (*get_msr_with_filter)(struct x86_emulate_ctxt *ctxt, u32 msr_index, u64 *pdata);
-	int (*set_msr)(struct x86_emulate_ctxt *ctxt, u32 msr_index, u64 data);
 	int (*get_msr)(struct x86_emulate_ctxt *ctxt, u32 msr_index, u64 *pdata);
 	int (*check_pmc)(struct x86_emulate_ctxt *ctxt, u32 pmc);
 	int (*read_pmc)(struct x86_emulate_ctxt *ctxt, u32 pmc, u64 *pdata);
diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
index 773e07b6397df0..41ca128478fcd4 100644
--- a/arch/x86/kvm/smm.c
+++ b/arch/x86/kvm/smm.c
@@ -271,71 +271,59 @@ void enter_smm(struct kvm_vcpu *vcpu)
 	kvm_mmu_reset_context(vcpu);
 }
 
-static int emulator_has_longmode(struct x86_emulate_ctxt *ctxt)
-{
-#ifdef CONFIG_X86_64
-	return ctxt->ops->guest_has_long_mode(ctxt);
-#else
-	return false;
-#endif
-}
-
-static void rsm_set_desc_flags(struct desc_struct *desc, u32 flags)
+static void rsm_set_desc_flags(struct kvm_segment *desc, u32 flags)
 {
 	desc->g    = (flags >> 23) & 1;
-	desc->d    = (flags >> 22) & 1;
+	desc->db   = (flags >> 22) & 1;
 	desc->l    = (flags >> 21) & 1;
 	desc->avl  = (flags >> 20) & 1;
-	desc->p    = (flags >> 15) & 1;
+	desc->present = (flags >> 15) & 1;
 	desc->dpl  = (flags >> 13) & 3;
 	desc->s    = (flags >> 12) & 1;
 	desc->type = (flags >>  8) & 15;
+
+	desc->unusable = !desc->present;
+	desc->padding = 0;
 }
 
-static int rsm_load_seg_32(struct x86_emulate_ctxt *ctxt, const char *smstate,
+static int rsm_load_seg_32(struct kvm_vcpu *vcpu, const char *smstate,
 			   int n)
 {
-	struct desc_struct desc;
+	struct kvm_segment desc;
 	int offset;
-	u16 selector;
-
-	selector = GET_SMSTATE(u32, smstate, 0x7fa8 + n * 4);
 
 	if (n < 3)
 		offset = 0x7f84 + n * 12;
 	else
 		offset = 0x7f2c + (n - 3) * 12;
 
-	set_desc_base(&desc,      GET_SMSTATE(u32, smstate, offset + 8));
-	set_desc_limit(&desc,     GET_SMSTATE(u32, smstate, offset + 4));
+	desc.selector =           GET_SMSTATE(u32, smstate, 0x7fa8 + n * 4);
+	desc.base =               GET_SMSTATE(u32, smstate, offset + 8);
+	desc.limit =              GET_SMSTATE(u32, smstate, offset + 4);
 	rsm_set_desc_flags(&desc, GET_SMSTATE(u32, smstate, offset));
-	ctxt->ops->set_segment(ctxt, selector, &desc, 0, n);
+	kvm_set_segment(vcpu, &desc, n);
 	return X86EMUL_CONTINUE;
 }
 
 #ifdef CONFIG_X86_64
-static int rsm_load_seg_64(struct x86_emulate_ctxt *ctxt, const char *smstate,
+static int rsm_load_seg_64(struct kvm_vcpu *vcpu, const char *smstate,
 			   int n)
 {
-	struct desc_struct desc;
+	struct kvm_segment desc;
 	int offset;
-	u16 selector;
-	u32 base3;
 
 	offset = 0x7e00 + n * 16;
 
-	selector =                GET_SMSTATE(u16, smstate, offset);
+	desc.selector =           GET_SMSTATE(u16, smstate, offset);
 	rsm_set_desc_flags(&desc, GET_SMSTATE(u16, smstate, offset + 2) << 8);
-	set_desc_limit(&desc,     GET_SMSTATE(u32, smstate, offset + 4));
-	set_desc_base(&desc,      GET_SMSTATE(u32, smstate, offset + 8));
-	base3 =                   GET_SMSTATE(u32, smstate, offset + 12);
-
-	ctxt->ops->set_segment(ctxt, selector, &desc, base3, n);
+	desc.limit =              GET_SMSTATE(u32, smstate, offset + 4);
+	desc.base =               GET_SMSTATE(u64, smstate, offset + 8);
+	kvm_set_segment(vcpu, &desc, n);
 	return X86EMUL_CONTINUE;
 }
 #endif
 
-static int rsm_enter_protected_mode(struct x86_emulate_ctxt *ctxt,
+static int rsm_enter_protected_mode(struct kvm_vcpu *vcpu,
 				    u64 cr0, u64 cr3, u64 cr4)
 {
 	int bad;
@@ -348,7 +336,7 @@ static int rsm_enter_protected_mode(struct x86_emulate_ctxt *ctxt,
 		cr3 &= ~0xfff;
 	}
 
-	bad = ctxt->ops->set_cr(ctxt, 3, cr3);
+	bad = kvm_set_cr3(vcpu, cr3);
 	if (bad)
 		return X86EMUL_UNHANDLEABLE;
 
@@ -357,20 +345,20 @@ static int rsm_enter_protected_mode(struct x86_emulate_ctxt *ctxt,
 	 * Then enable protected mode.	However, PCID cannot be enabled
 	 * if EFER.LMA=0, so set it separately.
 	 */
-	bad = ctxt->ops->set_cr(ctxt, 4, cr4 & ~X86_CR4_PCIDE);
+	bad = kvm_set_cr4(vcpu, cr4 & ~X86_CR4_PCIDE);
 	if (bad)
 		return X86EMUL_UNHANDLEABLE;
 
-	bad = ctxt->ops->set_cr(ctxt, 0, cr0);
+	bad = kvm_set_cr0(vcpu, cr0);
 	if (bad)
 		return X86EMUL_UNHANDLEABLE;
 
 	if (cr4 & X86_CR4_PCIDE) {
-		bad = ctxt->ops->set_cr(ctxt, 4, cr4);
+		bad = kvm_set_cr4(vcpu, cr4);
 		if (bad)
 			return X86EMUL_UNHANDLEABLE;
 		if (pcid) {
-			bad = ctxt->ops->set_cr(ctxt, 3, cr3 | pcid);
+			bad = kvm_set_cr3(vcpu, cr3 | pcid);
 			if (bad)
 				return X86EMUL_UNHANDLEABLE;
 		}
@@ -383,9 +371,9 @@ static int rsm_enter_protected_mode(struct x86_emulate_ctxt *ctxt,
 static int rsm_load_state_32(struct x86_emulate_ctxt *ctxt,
 			     const char *smstate)
 {
-	struct desc_struct desc;
+	struct kvm_vcpu *vcpu = ctxt->vcpu;
+	struct kvm_segment desc;
 	struct desc_ptr dt;
-	u16 selector;
 	u32 val, cr0, cr3, cr4;
 	int i;
 
@@ -399,56 +387,55 @@ static int rsm_load_state_32(struct x86_emulate_ctxt *ctxt,
 
 	val = GET_SMSTATE(u32, smstate, 0x7fcc);
 
-	if (ctxt->ops->set_dr(ctxt, 6, val))
+	if (kvm_set_dr(vcpu, 6, val))
 		return X86EMUL_UNHANDLEABLE;
 
 	val = GET_SMSTATE(u32, smstate, 0x7fc8);
 
-	if (ctxt->ops->set_dr(ctxt, 7, val))
+	if (kvm_set_dr(vcpu, 7, val))
 		return X86EMUL_UNHANDLEABLE;
 
-	selector =                 GET_SMSTATE(u32, smstate, 0x7fc4);
-	set_desc_base(&desc,       GET_SMSTATE(u32, smstate, 0x7f64));
-	set_desc_limit(&desc,      GET_SMSTATE(u32, smstate, 0x7f60));
+	desc.selector =            GET_SMSTATE(u32, smstate, 0x7fc4);
+	desc.base =                GET_SMSTATE(u32, smstate, 0x7f64);
+	desc.limit =               GET_SMSTATE(u32, smstate, 0x7f60);
 	rsm_set_desc_flags(&desc,  GET_SMSTATE(u32, smstate, 0x7f5c));
-	ctxt->ops->set_segment(ctxt, selector, &desc, 0, VCPU_SREG_TR);
+	kvm_set_segment(vcpu, &desc, VCPU_SREG_TR);
 
-	selector =                 GET_SMSTATE(u32, smstate, 0x7fc0);
-	set_desc_base(&desc,       GET_SMSTATE(u32, smstate, 0x7f80));
-	set_desc_limit(&desc,      GET_SMSTATE(u32, smstate, 0x7f7c));
+	desc.selector =            GET_SMSTATE(u32, smstate, 0x7fc0);
+	desc.base =                GET_SMSTATE(u32, smstate, 0x7f80);
+	desc.limit =               GET_SMSTATE(u32, smstate, 0x7f7c);
 	rsm_set_desc_flags(&desc,  GET_SMSTATE(u32, smstate, 0x7f78));
-	ctxt->ops->set_segment(ctxt, selector, &desc, 0, VCPU_SREG_LDTR);
+	kvm_set_segment(vcpu, &desc, VCPU_SREG_LDTR);
 
 	dt.address =               GET_SMSTATE(u32, smstate, 0x7f74);
 	dt.size =                  GET_SMSTATE(u32, smstate, 0x7f70);
-	ctxt->ops->set_gdt(ctxt, &dt);
+	static_call(kvm_x86_set_gdt)(vcpu, &dt);
 
 	dt.address =               GET_SMSTATE(u32, smstate, 0x7f58);
 	dt.size =                  GET_SMSTATE(u32, smstate, 0x7f54);
-	ctxt->ops->set_idt(ctxt, &dt);
+	static_call(kvm_x86_set_idt)(vcpu, &dt);
 
 	for (i = 0; i < 6; i++) {
-		int r = rsm_load_seg_32(ctxt, smstate, i);
+		int r = rsm_load_seg_32(vcpu, smstate, i);
 		if (r != X86EMUL_CONTINUE)
 			return r;
 	}
 
 	cr4 = GET_SMSTATE(u32, smstate, 0x7f14);
 
-	ctxt->ops->set_smbase(ctxt, GET_SMSTATE(u32, smstate, 0x7ef8));
+	vcpu->arch.smbase = GET_SMSTATE(u32, smstate, 0x7ef8);
 
-	return rsm_enter_protected_mode(ctxt, cr0, cr3, cr4);
+	return rsm_enter_protected_mode(vcpu, cr0, cr3, cr4);
 }
 
 #ifdef CONFIG_X86_64
 static int rsm_load_state_64(struct x86_emulate_ctxt *ctxt,
 			     const char *smstate)
 {
-	struct desc_struct desc;
+	struct kvm_vcpu *vcpu = ctxt->vcpu;
+	struct kvm_segment desc;
 	struct desc_ptr dt;
 	u64 val, cr0, cr3, cr4;
-	u32 base3;
-	u16 selector;
 	int i, r;
 
 	for (i = 0; i < NR_EMULATOR_GPRS; i++)
@@ -459,51 +446,49 @@ static int rsm_load_state_64(struct x86_emulate_ctxt *ctxt,
 
 	val = GET_SMSTATE(u64, smstate, 0x7f68);
 
-	if (ctxt->ops->set_dr(ctxt, 6, val))
+	if (kvm_set_dr(vcpu, 6, val))
 		return X86EMUL_UNHANDLEABLE;
 
 	val = GET_SMSTATE(u64, smstate, 0x7f60);
 
-	if (ctxt->ops->set_dr(ctxt, 7, val))
+	if (kvm_set_dr(vcpu, 7, val))
 		return X86EMUL_UNHANDLEABLE;
 
 	cr0 =                       GET_SMSTATE(u64, smstate, 0x7f58);
 	cr3 =                       GET_SMSTATE(u64, smstate, 0x7f50);
 	cr4 =                       GET_SMSTATE(u64, smstate, 0x7f48);
-	ctxt->ops->set_smbase(ctxt, GET_SMSTATE(u32, smstate, 0x7f00));
+	vcpu->arch.smbase =         GET_SMSTATE(u32, smstate, 0x7f00);
 	val =                       GET_SMSTATE(u64, smstate, 0x7ed0);
 
-	if (ctxt->ops->set_msr(ctxt, MSR_EFER, val & ~EFER_LMA))
+	if (kvm_set_msr(vcpu, MSR_EFER, val & ~EFER_LMA))
 		return X86EMUL_UNHANDLEABLE;
 
-	selector =                  GET_SMSTATE(u32, smstate, 0x7e90);
+	desc.selector =             GET_SMSTATE(u32, smstate, 0x7e90);
 	rsm_set_desc_flags(&desc,   GET_SMSTATE(u32, smstate, 0x7e92) << 8);
-	set_desc_limit(&desc,       GET_SMSTATE(u32, smstate, 0x7e94));
-	set_desc_base(&desc,        GET_SMSTATE(u32, smstate, 0x7e98));
-	base3 =                     GET_SMSTATE(u32, smstate, 0x7e9c);
-	ctxt->ops->set_segment(ctxt, selector, &desc, base3, VCPU_SREG_TR);
+	desc.limit =                GET_SMSTATE(u32, smstate, 0x7e94);
+	desc.base =                 GET_SMSTATE(u64, smstate, 0x7e98);
+	kvm_set_segment(vcpu, &desc, VCPU_SREG_TR);
 
 	dt.size =                   GET_SMSTATE(u32, smstate, 0x7e84);
 	dt.address =                GET_SMSTATE(u64, smstate, 0x7e88);
-	ctxt->ops->set_idt(ctxt, &dt);
+	static_call(kvm_x86_set_idt)(vcpu, &dt);
 
-	selector =                  GET_SMSTATE(u32, smstate, 0x7e70);
+	desc.selector =             GET_SMSTATE(u32, smstate, 0x7e70);
 	rsm_set_desc_flags(&desc,   GET_SMSTATE(u32, smstate, 0x7e72) << 8);
-	set_desc_limit(&desc,       GET_SMSTATE(u32, smstate, 0x7e74));
-	set_desc_base(&desc,        GET_SMSTATE(u32, smstate, 0x7e78));
-	base3 =                     GET_SMSTATE(u32, smstate, 0x7e7c);
-	ctxt->ops->set_segment(ctxt, selector, &desc, base3, VCPU_SREG_LDTR);
+	desc.limit =                GET_SMSTATE(u32, smstate, 0x7e74);
+	desc.base =                 GET_SMSTATE(u64, smstate, 0x7e78);
+	kvm_set_segment(vcpu, &desc, VCPU_SREG_LDTR);
 
 	dt.size =                   GET_SMSTATE(u32, smstate, 0x7e64);
 	dt.address =                GET_SMSTATE(u64, smstate, 0x7e68);
-	ctxt->ops->set_gdt(ctxt, &dt);
+	static_call(kvm_x86_set_gdt)(vcpu, &dt);
 
-	r = rsm_enter_protected_mode(ctxt, cr0, cr3, cr4);
+	r = rsm_enter_protected_mode(vcpu, cr0, cr3, cr4);
 	if (r != X86EMUL_CONTINUE)
 		return r;
 
 	for (i = 0; i < 6; i++) {
-		r = rsm_load_seg_64(ctxt, smstate, i);
+		r = rsm_load_seg_64(vcpu, smstate, i);
 		if (r != X86EMUL_CONTINUE)
 			return r;
 	}
@@ -520,14 +505,14 @@ int emulator_leave_smm(struct x86_emulate_ctxt *ctxt)
 	u64 smbase;
 	int ret;
 
-	smbase = ctxt->ops->get_smbase(ctxt);
+	smbase = vcpu->arch.smbase;
 
-	ret = ctxt->ops->read_phys(ctxt, smbase + 0xfe00, buf, sizeof(buf));
-	if (ret != X86EMUL_CONTINUE)
+	ret = kvm_vcpu_read_guest(vcpu, smbase + 0xfe00, buf, sizeof(buf));
+	if (ret < 0)
 		return X86EMUL_UNHANDLEABLE;
 
-	if ((ctxt->ops->get_hflags(ctxt) & X86EMUL_SMM_INSIDE_NMI_MASK) == 0)
-		ctxt->ops->set_nmi_mask(ctxt, false);
+	if ((vcpu->arch.hflags & HF_SMM_INSIDE_NMI_MASK) == 0)
+		static_call(kvm_x86_set_nmi_mask)(vcpu, false);
 
 	kvm_smm_changed(vcpu, false);
 
@@ -535,41 +520,41 @@ int emulator_leave_smm(struct x86_emulate_ctxt *ctxt)
 	 * Get back to real mode, to prepare a safe state in which to load
 	 * CR0/CR3/CR4/EFER.  It's all a bit more complicated if the vCPU
 	 * supports long mode.
-	 *
-	 * The ctxt->ops callbacks will handle all side effects when writing
-	 * writing MSRs and CRs, e.g. MMU context resets, CPUID
-	 * runtime updates, etc.
 	 */
-	if (emulator_has_longmode(ctxt)) {
-		struct desc_struct cs_desc;
+#ifdef CONFIG_X86_64
+	if (guest_cpuid_has(vcpu, X86_FEATURE_LM)) {
+		struct kvm_segment cs_desc;
 
 		/* Zero CR4.PCIDE before CR0.PG.  */
-		cr4 = ctxt->ops->get_cr(ctxt, 4);
+		cr4 = kvm_read_cr4(vcpu);
 		if (cr4 & X86_CR4_PCIDE)
-			ctxt->ops->set_cr(ctxt, 4, cr4 & ~X86_CR4_PCIDE);
+			kvm_set_cr4(vcpu, cr4 & ~X86_CR4_PCIDE);
 
 		/* A 32-bit code segment is required to clear EFER.LMA.  */
 		memset(&cs_desc, 0, sizeof(cs_desc));
 		cs_desc.type = 0xb;
-		cs_desc.s = cs_desc.g = cs_desc.p = 1;
-		ctxt->ops->set_segment(ctxt, 0, &cs_desc, 0, VCPU_SREG_CS);
+		cs_desc.s = cs_desc.g = cs_desc.present = 1;
+		kvm_set_segment(vcpu, &cs_desc, VCPU_SREG_CS);
 	}
+#endif
 
 	/* For the 64-bit case, this will clear EFER.LMA.  */
-	cr0 = ctxt->ops->get_cr(ctxt, 0);
+	cr0 = kvm_read_cr0(vcpu);
 	if (cr0 & X86_CR0_PE)
-		ctxt->ops->set_cr(ctxt, 0, cr0 & ~(X86_CR0_PG | X86_CR0_PE));
+		kvm_set_cr0(vcpu, cr0 & ~(X86_CR0_PG | X86_CR0_PE));
 
-	if (emulator_has_longmode(ctxt)) {
+#ifdef CONFIG_X86_64
+	if (guest_cpuid_has(vcpu, X86_FEATURE_LM)) {
 		/* Clear CR4.PAE before clearing EFER.LME. */
-		cr4 = ctxt->ops->get_cr(ctxt, 4);
+		cr4 = kvm_read_cr4(vcpu);
 		if (cr4 & X86_CR4_PAE)
-			ctxt->ops->set_cr(ctxt, 4, cr4 & ~X86_CR4_PAE);
+			kvm_set_cr4(vcpu, cr4 & ~X86_CR4_PAE);
 
 		/* And finally go back to 32-bit mode.  */
 		efer = 0;
-		ctxt->ops->set_msr(ctxt, MSR_EFER, efer);
+		kvm_set_msr(vcpu, MSR_EFER, efer);
 	}
+#endif
 
 	/*
 	 * Give leave_smm() a chance to make ISA-specific changes to the vCPU
@@ -580,7 +565,7 @@ int emulator_leave_smm(struct x86_emulate_ctxt *ctxt)
 		return X86EMUL_UNHANDLEABLE;
 
 #ifdef CONFIG_X86_64
-	if (emulator_has_longmode(ctxt))
+	if (guest_cpuid_has(vcpu, X86_FEATURE_LM))
 		return rsm_load_state_64(ctxt, buf);
 	else
 #endif
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a1e524c2c39df2..2ae8ac525fc324 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7214,15 +7214,6 @@ static int emulator_read_std(struct x86_emulate_ctxt *ctxt,
 	return kvm_read_guest_virt_helper(addr, val, bytes, vcpu, access, exception);
 }
 
-static int kvm_read_guest_phys_system(struct x86_emulate_ctxt *ctxt,
-		unsigned long addr, void *val, unsigned int bytes)
-{
-	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
-	int r = kvm_vcpu_read_guest(vcpu, addr, val, bytes);
-
-	return r < 0 ? X86EMUL_IO_NEEDED : X86EMUL_CONTINUE;
-}
-
 static int kvm_write_guest_virt_helper(gva_t addr, void *val, unsigned int bytes,
 				      struct kvm_vcpu *vcpu, u64 access,
 				      struct x86_exception *exception)
@@ -8014,26 +8005,6 @@ static int emulator_get_msr(struct x86_emulate_ctxt *ctxt,
 	return kvm_get_msr(emul_to_vcpu(ctxt), msr_index, pdata);
 }
 
-static int emulator_set_msr(struct x86_emulate_ctxt *ctxt,
-			    u32 msr_index, u64 data)
-{
-	return kvm_set_msr(emul_to_vcpu(ctxt), msr_index, data);
-}
-
-static u64 emulator_get_smbase(struct x86_emulate_ctxt *ctxt)
-{
-	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
-
-	return vcpu->arch.smbase;
-}
-
-static void emulator_set_smbase(struct x86_emulate_ctxt *ctxt, u64 smbase)
-{
-	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
-
-	vcpu->arch.smbase = smbase;
-}
-
 static int emulator_check_pmc(struct x86_emulate_ctxt *ctxt,
 			      u32 pmc)
 {
@@ -8132,7 +8103,6 @@ static const struct x86_emulate_ops emulate_ops = {
 	.write_gpr           = emulator_write_gpr,
 	.read_std            = emulator_read_std,
 	.write_std           = emulator_write_std,
-	.read_phys           = kvm_read_guest_phys_system,
 	.fetch               = kvm_fetch_guest_virt,
 	.read_emulated       = emulator_read_emulated,
 	.write_emulated      = emulator_write_emulated,
@@ -8152,11 +8122,8 @@ static const struct x86_emulate_ops emulate_ops = {
 	.cpl                 = emulator_get_cpl,
 	.get_dr              = emulator_get_dr,
 	.set_dr              = emulator_set_dr,
-	.get_smbase          = emulator_get_smbase,
-	.set_smbase          = emulator_set_smbase,
 	.set_msr_with_filter = emulator_set_msr_with_filter,
 	.get_msr_with_filter = emulator_get_msr_with_filter,
-	.set_msr             = emulator_set_msr,
 	.get_msr             = emulator_get_msr,
 	.check_pmc	     = emulator_check_pmc,
 	.read_pmc            = emulator_read_pmc,
-- 
2.34.3

