Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9668360CC6D
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 14:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbiJYMuY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 08:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbiJYMt7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 08:49:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0431974E6
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 05:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666702082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dELdUtEMFXaxyo0aOSAdhg8VM0SwHd6mw3Ub4VUavmM=;
        b=NREBXj2NZippY9wSOIUcF4mbIeXGEEYg5kJT8ruTRYZL69ll0yH+gfqgIYnfgH8/UQz8yM
        44IG7i9SwJvpUwhdgmCNCXMd+0uetcu6OKJ4mZFuStbAd3dqlVj0s0fzBQCmiBTLvf1tU/
        wq0SwLFenROHFuW05tUl2lgvisvLwDo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-VT4HDKtsOBONQoX2Ifs_Kw-1; Tue, 25 Oct 2022 08:47:58 -0400
X-MC-Unique: VT4HDKtsOBONQoX2Ifs_Kw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 622E51C0BC66;
        Tue, 25 Oct 2022 12:47:57 +0000 (UTC)
Received: from amdlaptop.tlv.redhat.com (dhcp-4-238.tlv.redhat.com [10.35.4.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0ED5A40C6EC6;
        Tue, 25 Oct 2022 12:47:53 +0000 (UTC)
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
Subject: [PATCH RESEND v4 03/23] KVM: x86: move SMM exit to a new file
Date:   Tue, 25 Oct 2022 15:47:21 +0300
Message-Id: <20221025124741.228045-4-mlevitsk@redhat.com>
In-Reply-To: <20221025124741.228045-1-mlevitsk@redhat.com>
References: <20221025124741.228045-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

Some users of KVM implement the UEFI variable store through a paravirtual
device that does not require the "SMM lockbox" component of edk2, and
would like to compile out system management mode.  In preparation for
that, move the SMM exit code out of emulate.c and into a new file.

The code is still written as a series of invocations of the emulator
callbacks, but the two exiting_smm and leave_smm callbacks are merged
into one, and all the code from em_rsm is now part of the callback.
This removes all knowledge of the format of the SMM save state area
from the emulator.  Further patches will clean up the code and
invoke KVM's own functions to access control registers, descriptor
caches, etc.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/emulate.c     | 356 +------------------------------------
 arch/x86/kvm/kvm_emulate.h |  34 +++-
 arch/x86/kvm/smm.c         | 316 ++++++++++++++++++++++++++++++++
 arch/x86/kvm/smm.h         |   1 +
 arch/x86/kvm/x86.c         |  14 --
 5 files changed, 351 insertions(+), 370 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index de09660a61e522..671f7e5871ff70 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -30,7 +30,6 @@
 #include "tss.h"
 #include "mmu.h"
 #include "pmu.h"
-#include "smm.h"
 
 /*
  * Operand types
@@ -243,37 +242,6 @@ enum x86_transfer_type {
 	X86_TRANSFER_TASK_SWITCH,
 };
 
-static ulong reg_read(struct x86_emulate_ctxt *ctxt, unsigned nr)
-{
-	if (KVM_EMULATOR_BUG_ON(nr >= NR_EMULATOR_GPRS, ctxt))
-		nr &= NR_EMULATOR_GPRS - 1;
-
-	if (!(ctxt->regs_valid & (1 << nr))) {
-		ctxt->regs_valid |= 1 << nr;
-		ctxt->_regs[nr] = ctxt->ops->read_gpr(ctxt, nr);
-	}
-	return ctxt->_regs[nr];
-}
-
-static ulong *reg_write(struct x86_emulate_ctxt *ctxt, unsigned nr)
-{
-	if (KVM_EMULATOR_BUG_ON(nr >= NR_EMULATOR_GPRS, ctxt))
-		nr &= NR_EMULATOR_GPRS - 1;
-
-	BUILD_BUG_ON(sizeof(ctxt->regs_dirty) * BITS_PER_BYTE < NR_EMULATOR_GPRS);
-	BUILD_BUG_ON(sizeof(ctxt->regs_valid) * BITS_PER_BYTE < NR_EMULATOR_GPRS);
-
-	ctxt->regs_valid |= 1 << nr;
-	ctxt->regs_dirty |= 1 << nr;
-	return &ctxt->_regs[nr];
-}
-
-static ulong *reg_rmw(struct x86_emulate_ctxt *ctxt, unsigned nr)
-{
-	reg_read(ctxt, nr);
-	return reg_write(ctxt, nr);
-}
-
 static void writeback_registers(struct x86_emulate_ctxt *ctxt)
 {
 	unsigned long dirty = ctxt->regs_dirty;
@@ -2310,334 +2278,14 @@ static int em_lseg(struct x86_emulate_ctxt *ctxt)
 	return rc;
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
-{
-	desc->g    = (flags >> 23) & 1;
-	desc->d    = (flags >> 22) & 1;
-	desc->l    = (flags >> 21) & 1;
-	desc->avl  = (flags >> 20) & 1;
-	desc->p    = (flags >> 15) & 1;
-	desc->dpl  = (flags >> 13) & 3;
-	desc->s    = (flags >> 12) & 1;
-	desc->type = (flags >>  8) & 15;
-}
-
-static int rsm_load_seg_32(struct x86_emulate_ctxt *ctxt, const char *smstate,
-			   int n)
-{
-	struct desc_struct desc;
-	int offset;
-	u16 selector;
-
-	selector = GET_SMSTATE(u32, smstate, 0x7fa8 + n * 4);
-
-	if (n < 3)
-		offset = 0x7f84 + n * 12;
-	else
-		offset = 0x7f2c + (n - 3) * 12;
-
-	set_desc_base(&desc,      GET_SMSTATE(u32, smstate, offset + 8));
-	set_desc_limit(&desc,     GET_SMSTATE(u32, smstate, offset + 4));
-	rsm_set_desc_flags(&desc, GET_SMSTATE(u32, smstate, offset));
-	ctxt->ops->set_segment(ctxt, selector, &desc, 0, n);
-	return X86EMUL_CONTINUE;
-}
-
-#ifdef CONFIG_X86_64
-static int rsm_load_seg_64(struct x86_emulate_ctxt *ctxt, const char *smstate,
-			   int n)
-{
-	struct desc_struct desc;
-	int offset;
-	u16 selector;
-	u32 base3;
-
-	offset = 0x7e00 + n * 16;
-
-	selector =                GET_SMSTATE(u16, smstate, offset);
-	rsm_set_desc_flags(&desc, GET_SMSTATE(u16, smstate, offset + 2) << 8);
-	set_desc_limit(&desc,     GET_SMSTATE(u32, smstate, offset + 4));
-	set_desc_base(&desc,      GET_SMSTATE(u32, smstate, offset + 8));
-	base3 =                   GET_SMSTATE(u32, smstate, offset + 12);
-
-	ctxt->ops->set_segment(ctxt, selector, &desc, base3, n);
-	return X86EMUL_CONTINUE;
-}
-#endif
-
-static int rsm_enter_protected_mode(struct x86_emulate_ctxt *ctxt,
-				    u64 cr0, u64 cr3, u64 cr4)
-{
-	int bad;
-	u64 pcid;
-
-	/* In order to later set CR4.PCIDE, CR3[11:0] must be zero.  */
-	pcid = 0;
-	if (cr4 & X86_CR4_PCIDE) {
-		pcid = cr3 & 0xfff;
-		cr3 &= ~0xfff;
-	}
-
-	bad = ctxt->ops->set_cr(ctxt, 3, cr3);
-	if (bad)
-		return X86EMUL_UNHANDLEABLE;
-
-	/*
-	 * First enable PAE, long mode needs it before CR0.PG = 1 is set.
-	 * Then enable protected mode.	However, PCID cannot be enabled
-	 * if EFER.LMA=0, so set it separately.
-	 */
-	bad = ctxt->ops->set_cr(ctxt, 4, cr4 & ~X86_CR4_PCIDE);
-	if (bad)
-		return X86EMUL_UNHANDLEABLE;
-
-	bad = ctxt->ops->set_cr(ctxt, 0, cr0);
-	if (bad)
-		return X86EMUL_UNHANDLEABLE;
-
-	if (cr4 & X86_CR4_PCIDE) {
-		bad = ctxt->ops->set_cr(ctxt, 4, cr4);
-		if (bad)
-			return X86EMUL_UNHANDLEABLE;
-		if (pcid) {
-			bad = ctxt->ops->set_cr(ctxt, 3, cr3 | pcid);
-			if (bad)
-				return X86EMUL_UNHANDLEABLE;
-		}
-
-	}
-
-	return X86EMUL_CONTINUE;
-}
-
-static int rsm_load_state_32(struct x86_emulate_ctxt *ctxt,
-			     const char *smstate)
-{
-	struct desc_struct desc;
-	struct desc_ptr dt;
-	u16 selector;
-	u32 val, cr0, cr3, cr4;
-	int i;
-
-	cr0 =                      GET_SMSTATE(u32, smstate, 0x7ffc);
-	cr3 =                      GET_SMSTATE(u32, smstate, 0x7ff8);
-	ctxt->eflags =             GET_SMSTATE(u32, smstate, 0x7ff4) | X86_EFLAGS_FIXED;
-	ctxt->_eip =               GET_SMSTATE(u32, smstate, 0x7ff0);
-
-	for (i = 0; i < NR_EMULATOR_GPRS; i++)
-		*reg_write(ctxt, i) = GET_SMSTATE(u32, smstate, 0x7fd0 + i * 4);
-
-	val = GET_SMSTATE(u32, smstate, 0x7fcc);
-
-	if (ctxt->ops->set_dr(ctxt, 6, val))
-		return X86EMUL_UNHANDLEABLE;
-
-	val = GET_SMSTATE(u32, smstate, 0x7fc8);
-
-	if (ctxt->ops->set_dr(ctxt, 7, val))
-		return X86EMUL_UNHANDLEABLE;
-
-	selector =                 GET_SMSTATE(u32, smstate, 0x7fc4);
-	set_desc_base(&desc,       GET_SMSTATE(u32, smstate, 0x7f64));
-	set_desc_limit(&desc,      GET_SMSTATE(u32, smstate, 0x7f60));
-	rsm_set_desc_flags(&desc,  GET_SMSTATE(u32, smstate, 0x7f5c));
-	ctxt->ops->set_segment(ctxt, selector, &desc, 0, VCPU_SREG_TR);
-
-	selector =                 GET_SMSTATE(u32, smstate, 0x7fc0);
-	set_desc_base(&desc,       GET_SMSTATE(u32, smstate, 0x7f80));
-	set_desc_limit(&desc,      GET_SMSTATE(u32, smstate, 0x7f7c));
-	rsm_set_desc_flags(&desc,  GET_SMSTATE(u32, smstate, 0x7f78));
-	ctxt->ops->set_segment(ctxt, selector, &desc, 0, VCPU_SREG_LDTR);
-
-	dt.address =               GET_SMSTATE(u32, smstate, 0x7f74);
-	dt.size =                  GET_SMSTATE(u32, smstate, 0x7f70);
-	ctxt->ops->set_gdt(ctxt, &dt);
-
-	dt.address =               GET_SMSTATE(u32, smstate, 0x7f58);
-	dt.size =                  GET_SMSTATE(u32, smstate, 0x7f54);
-	ctxt->ops->set_idt(ctxt, &dt);
-
-	for (i = 0; i < 6; i++) {
-		int r = rsm_load_seg_32(ctxt, smstate, i);
-		if (r != X86EMUL_CONTINUE)
-			return r;
-	}
-
-	cr4 = GET_SMSTATE(u32, smstate, 0x7f14);
-
-	ctxt->ops->set_smbase(ctxt, GET_SMSTATE(u32, smstate, 0x7ef8));
-
-	return rsm_enter_protected_mode(ctxt, cr0, cr3, cr4);
-}
-
-#ifdef CONFIG_X86_64
-static int rsm_load_state_64(struct x86_emulate_ctxt *ctxt,
-			     const char *smstate)
-{
-	struct desc_struct desc;
-	struct desc_ptr dt;
-	u64 val, cr0, cr3, cr4;
-	u32 base3;
-	u16 selector;
-	int i, r;
-
-	for (i = 0; i < NR_EMULATOR_GPRS; i++)
-		*reg_write(ctxt, i) = GET_SMSTATE(u64, smstate, 0x7ff8 - i * 8);
-
-	ctxt->_eip   = GET_SMSTATE(u64, smstate, 0x7f78);
-	ctxt->eflags = GET_SMSTATE(u32, smstate, 0x7f70) | X86_EFLAGS_FIXED;
-
-	val = GET_SMSTATE(u64, smstate, 0x7f68);
-
-	if (ctxt->ops->set_dr(ctxt, 6, val))
-		return X86EMUL_UNHANDLEABLE;
-
-	val = GET_SMSTATE(u64, smstate, 0x7f60);
-
-	if (ctxt->ops->set_dr(ctxt, 7, val))
-		return X86EMUL_UNHANDLEABLE;
-
-	cr0 =                       GET_SMSTATE(u64, smstate, 0x7f58);
-	cr3 =                       GET_SMSTATE(u64, smstate, 0x7f50);
-	cr4 =                       GET_SMSTATE(u64, smstate, 0x7f48);
-	ctxt->ops->set_smbase(ctxt, GET_SMSTATE(u32, smstate, 0x7f00));
-	val =                       GET_SMSTATE(u64, smstate, 0x7ed0);
-
-	if (ctxt->ops->set_msr(ctxt, MSR_EFER, val & ~EFER_LMA))
-		return X86EMUL_UNHANDLEABLE;
-
-	selector =                  GET_SMSTATE(u32, smstate, 0x7e90);
-	rsm_set_desc_flags(&desc,   GET_SMSTATE(u32, smstate, 0x7e92) << 8);
-	set_desc_limit(&desc,       GET_SMSTATE(u32, smstate, 0x7e94));
-	set_desc_base(&desc,        GET_SMSTATE(u32, smstate, 0x7e98));
-	base3 =                     GET_SMSTATE(u32, smstate, 0x7e9c);
-	ctxt->ops->set_segment(ctxt, selector, &desc, base3, VCPU_SREG_TR);
-
-	dt.size =                   GET_SMSTATE(u32, smstate, 0x7e84);
-	dt.address =                GET_SMSTATE(u64, smstate, 0x7e88);
-	ctxt->ops->set_idt(ctxt, &dt);
-
-	selector =                  GET_SMSTATE(u32, smstate, 0x7e70);
-	rsm_set_desc_flags(&desc,   GET_SMSTATE(u32, smstate, 0x7e72) << 8);
-	set_desc_limit(&desc,       GET_SMSTATE(u32, smstate, 0x7e74));
-	set_desc_base(&desc,        GET_SMSTATE(u32, smstate, 0x7e78));
-	base3 =                     GET_SMSTATE(u32, smstate, 0x7e7c);
-	ctxt->ops->set_segment(ctxt, selector, &desc, base3, VCPU_SREG_LDTR);
-
-	dt.size =                   GET_SMSTATE(u32, smstate, 0x7e64);
-	dt.address =                GET_SMSTATE(u64, smstate, 0x7e68);
-	ctxt->ops->set_gdt(ctxt, &dt);
-
-	r = rsm_enter_protected_mode(ctxt, cr0, cr3, cr4);
-	if (r != X86EMUL_CONTINUE)
-		return r;
-
-	for (i = 0; i < 6; i++) {
-		r = rsm_load_seg_64(ctxt, smstate, i);
-		if (r != X86EMUL_CONTINUE)
-			return r;
-	}
-
-	return X86EMUL_CONTINUE;
-}
-#endif
-
 static int em_rsm(struct x86_emulate_ctxt *ctxt)
 {
-	unsigned long cr0, cr4, efer;
-	char buf[512];
-	u64 smbase;
-	int ret;
-
 	if ((ctxt->ops->get_hflags(ctxt) & X86EMUL_SMM_MASK) == 0)
 		return emulate_ud(ctxt);
 
-	smbase = ctxt->ops->get_smbase(ctxt);
-
-	ret = ctxt->ops->read_phys(ctxt, smbase + 0xfe00, buf, sizeof(buf));
-	if (ret != X86EMUL_CONTINUE)
-		return X86EMUL_UNHANDLEABLE;
-
-	if ((ctxt->ops->get_hflags(ctxt) & X86EMUL_SMM_INSIDE_NMI_MASK) == 0)
-		ctxt->ops->set_nmi_mask(ctxt, false);
-
-	ctxt->ops->exiting_smm(ctxt);
-
-	/*
-	 * Get back to real mode, to prepare a safe state in which to load
-	 * CR0/CR3/CR4/EFER.  It's all a bit more complicated if the vCPU
-	 * supports long mode.
-	 */
-	if (emulator_has_longmode(ctxt)) {
-		struct desc_struct cs_desc;
-
-		/* Zero CR4.PCIDE before CR0.PG.  */
-		cr4 = ctxt->ops->get_cr(ctxt, 4);
-		if (cr4 & X86_CR4_PCIDE)
-			ctxt->ops->set_cr(ctxt, 4, cr4 & ~X86_CR4_PCIDE);
-
-		/* A 32-bit code segment is required to clear EFER.LMA.  */
-		memset(&cs_desc, 0, sizeof(cs_desc));
-		cs_desc.type = 0xb;
-		cs_desc.s = cs_desc.g = cs_desc.p = 1;
-		ctxt->ops->set_segment(ctxt, 0, &cs_desc, 0, VCPU_SREG_CS);
-	}
-
-	/* For the 64-bit case, this will clear EFER.LMA.  */
-	cr0 = ctxt->ops->get_cr(ctxt, 0);
-	if (cr0 & X86_CR0_PE)
-		ctxt->ops->set_cr(ctxt, 0, cr0 & ~(X86_CR0_PG | X86_CR0_PE));
-
-	if (emulator_has_longmode(ctxt)) {
-		/* Clear CR4.PAE before clearing EFER.LME. */
-		cr4 = ctxt->ops->get_cr(ctxt, 4);
-		if (cr4 & X86_CR4_PAE)
-			ctxt->ops->set_cr(ctxt, 4, cr4 & ~X86_CR4_PAE);
-
-		/* And finally go back to 32-bit mode.  */
-		efer = 0;
-		ctxt->ops->set_msr(ctxt, MSR_EFER, efer);
-	}
-
-	/*
-	 * Give leave_smm() a chance to make ISA-specific changes to the vCPU
-	 * state (e.g. enter guest mode) before loading state from the SMM
-	 * state-save area.
-	 */
-	if (ctxt->ops->leave_smm(ctxt, buf))
-		goto emulate_shutdown;
-
-#ifdef CONFIG_X86_64
-	if (emulator_has_longmode(ctxt))
-		ret = rsm_load_state_64(ctxt, buf);
-	else
-#endif
-		ret = rsm_load_state_32(ctxt, buf);
-
-	if (ret != X86EMUL_CONTINUE)
-		goto emulate_shutdown;
-
-	/*
-	 * Note, the ctxt->ops callbacks are responsible for handling side
-	 * effects when writing MSRs and CRs, e.g. MMU context resets, CPUID
-	 * runtime updates, etc...  If that changes, e.g. this flow is moved
-	 * out of the emulator to make it look more like enter_smm(), then
-	 * those side effects need to be explicitly handled for both success
-	 * and shutdown.
-	 */
-	return X86EMUL_CONTINUE;
+	if (ctxt->ops->leave_smm(ctxt))
+		ctxt->ops->triple_fault(ctxt);
 
-emulate_shutdown:
-	ctxt->ops->triple_fault(ctxt);
 	return X86EMUL_CONTINUE;
 }
 
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 89246446d6aa9d..d7afbc448dd245 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -234,8 +234,7 @@ struct x86_emulate_ops {
 	void (*set_nmi_mask)(struct x86_emulate_ctxt *ctxt, bool masked);
 
 	unsigned (*get_hflags)(struct x86_emulate_ctxt *ctxt);
-	void (*exiting_smm)(struct x86_emulate_ctxt *ctxt);
-	int (*leave_smm)(struct x86_emulate_ctxt *ctxt, const char *smstate);
+	int (*leave_smm)(struct x86_emulate_ctxt *ctxt);
 	void (*triple_fault)(struct x86_emulate_ctxt *ctxt);
 	int (*set_xcr)(struct x86_emulate_ctxt *ctxt, u32 index, u64 xcr);
 };
@@ -526,4 +525,35 @@ void emulator_invalidate_register_cache(struct x86_emulate_ctxt *ctxt);
 void emulator_writeback_register_cache(struct x86_emulate_ctxt *ctxt);
 bool emulator_can_use_gpa(struct x86_emulate_ctxt *ctxt);
 
+static inline ulong reg_read(struct x86_emulate_ctxt *ctxt, unsigned nr)
+{
+	if (KVM_EMULATOR_BUG_ON(nr >= NR_EMULATOR_GPRS, ctxt))
+		nr &= NR_EMULATOR_GPRS - 1;
+
+	if (!(ctxt->regs_valid & (1 << nr))) {
+		ctxt->regs_valid |= 1 << nr;
+		ctxt->_regs[nr] = ctxt->ops->read_gpr(ctxt, nr);
+	}
+	return ctxt->_regs[nr];
+}
+
+static inline ulong *reg_write(struct x86_emulate_ctxt *ctxt, unsigned nr)
+{
+	if (KVM_EMULATOR_BUG_ON(nr >= NR_EMULATOR_GPRS, ctxt))
+		nr &= NR_EMULATOR_GPRS - 1;
+
+	BUILD_BUG_ON(sizeof(ctxt->regs_dirty) * BITS_PER_BYTE < NR_EMULATOR_GPRS);
+	BUILD_BUG_ON(sizeof(ctxt->regs_valid) * BITS_PER_BYTE < NR_EMULATOR_GPRS);
+
+	ctxt->regs_valid |= 1 << nr;
+	ctxt->regs_dirty |= 1 << nr;
+	return &ctxt->_regs[nr];
+}
+
+static inline ulong *reg_rmw(struct x86_emulate_ctxt *ctxt, unsigned nr)
+{
+	reg_read(ctxt, nr);
+	return reg_write(ctxt, nr);
+}
+
 #endif /* _ASM_X86_KVM_X86_EMULATE_H */
diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
index 26a6859e421fe1..773e07b6397df0 100644
--- a/arch/x86/kvm/smm.c
+++ b/arch/x86/kvm/smm.c
@@ -270,3 +270,319 @@ void enter_smm(struct kvm_vcpu *vcpu)
 	kvm_update_cpuid_runtime(vcpu);
 	kvm_mmu_reset_context(vcpu);
 }
+
+static int emulator_has_longmode(struct x86_emulate_ctxt *ctxt)
+{
+#ifdef CONFIG_X86_64
+	return ctxt->ops->guest_has_long_mode(ctxt);
+#else
+	return false;
+#endif
+}
+
+static void rsm_set_desc_flags(struct desc_struct *desc, u32 flags)
+{
+	desc->g    = (flags >> 23) & 1;
+	desc->d    = (flags >> 22) & 1;
+	desc->l    = (flags >> 21) & 1;
+	desc->avl  = (flags >> 20) & 1;
+	desc->p    = (flags >> 15) & 1;
+	desc->dpl  = (flags >> 13) & 3;
+	desc->s    = (flags >> 12) & 1;
+	desc->type = (flags >>  8) & 15;
+}
+
+static int rsm_load_seg_32(struct x86_emulate_ctxt *ctxt, const char *smstate,
+			   int n)
+{
+	struct desc_struct desc;
+	int offset;
+	u16 selector;
+
+	selector = GET_SMSTATE(u32, smstate, 0x7fa8 + n * 4);
+
+	if (n < 3)
+		offset = 0x7f84 + n * 12;
+	else
+		offset = 0x7f2c + (n - 3) * 12;
+
+	set_desc_base(&desc,      GET_SMSTATE(u32, smstate, offset + 8));
+	set_desc_limit(&desc,     GET_SMSTATE(u32, smstate, offset + 4));
+	rsm_set_desc_flags(&desc, GET_SMSTATE(u32, smstate, offset));
+	ctxt->ops->set_segment(ctxt, selector, &desc, 0, n);
+	return X86EMUL_CONTINUE;
+}
+
+#ifdef CONFIG_X86_64
+static int rsm_load_seg_64(struct x86_emulate_ctxt *ctxt, const char *smstate,
+			   int n)
+{
+	struct desc_struct desc;
+	int offset;
+	u16 selector;
+	u32 base3;
+
+	offset = 0x7e00 + n * 16;
+
+	selector =                GET_SMSTATE(u16, smstate, offset);
+	rsm_set_desc_flags(&desc, GET_SMSTATE(u16, smstate, offset + 2) << 8);
+	set_desc_limit(&desc,     GET_SMSTATE(u32, smstate, offset + 4));
+	set_desc_base(&desc,      GET_SMSTATE(u32, smstate, offset + 8));
+	base3 =                   GET_SMSTATE(u32, smstate, offset + 12);
+
+	ctxt->ops->set_segment(ctxt, selector, &desc, base3, n);
+	return X86EMUL_CONTINUE;
+}
+#endif
+
+static int rsm_enter_protected_mode(struct x86_emulate_ctxt *ctxt,
+				    u64 cr0, u64 cr3, u64 cr4)
+{
+	int bad;
+	u64 pcid;
+
+	/* In order to later set CR4.PCIDE, CR3[11:0] must be zero.  */
+	pcid = 0;
+	if (cr4 & X86_CR4_PCIDE) {
+		pcid = cr3 & 0xfff;
+		cr3 &= ~0xfff;
+	}
+
+	bad = ctxt->ops->set_cr(ctxt, 3, cr3);
+	if (bad)
+		return X86EMUL_UNHANDLEABLE;
+
+	/*
+	 * First enable PAE, long mode needs it before CR0.PG = 1 is set.
+	 * Then enable protected mode.	However, PCID cannot be enabled
+	 * if EFER.LMA=0, so set it separately.
+	 */
+	bad = ctxt->ops->set_cr(ctxt, 4, cr4 & ~X86_CR4_PCIDE);
+	if (bad)
+		return X86EMUL_UNHANDLEABLE;
+
+	bad = ctxt->ops->set_cr(ctxt, 0, cr0);
+	if (bad)
+		return X86EMUL_UNHANDLEABLE;
+
+	if (cr4 & X86_CR4_PCIDE) {
+		bad = ctxt->ops->set_cr(ctxt, 4, cr4);
+		if (bad)
+			return X86EMUL_UNHANDLEABLE;
+		if (pcid) {
+			bad = ctxt->ops->set_cr(ctxt, 3, cr3 | pcid);
+			if (bad)
+				return X86EMUL_UNHANDLEABLE;
+		}
+
+	}
+
+	return X86EMUL_CONTINUE;
+}
+
+static int rsm_load_state_32(struct x86_emulate_ctxt *ctxt,
+			     const char *smstate)
+{
+	struct desc_struct desc;
+	struct desc_ptr dt;
+	u16 selector;
+	u32 val, cr0, cr3, cr4;
+	int i;
+
+	cr0 =                      GET_SMSTATE(u32, smstate, 0x7ffc);
+	cr3 =                      GET_SMSTATE(u32, smstate, 0x7ff8);
+	ctxt->eflags =             GET_SMSTATE(u32, smstate, 0x7ff4) | X86_EFLAGS_FIXED;
+	ctxt->_eip =               GET_SMSTATE(u32, smstate, 0x7ff0);
+
+	for (i = 0; i < NR_EMULATOR_GPRS; i++)
+		*reg_write(ctxt, i) = GET_SMSTATE(u32, smstate, 0x7fd0 + i * 4);
+
+	val = GET_SMSTATE(u32, smstate, 0x7fcc);
+
+	if (ctxt->ops->set_dr(ctxt, 6, val))
+		return X86EMUL_UNHANDLEABLE;
+
+	val = GET_SMSTATE(u32, smstate, 0x7fc8);
+
+	if (ctxt->ops->set_dr(ctxt, 7, val))
+		return X86EMUL_UNHANDLEABLE;
+
+	selector =                 GET_SMSTATE(u32, smstate, 0x7fc4);
+	set_desc_base(&desc,       GET_SMSTATE(u32, smstate, 0x7f64));
+	set_desc_limit(&desc,      GET_SMSTATE(u32, smstate, 0x7f60));
+	rsm_set_desc_flags(&desc,  GET_SMSTATE(u32, smstate, 0x7f5c));
+	ctxt->ops->set_segment(ctxt, selector, &desc, 0, VCPU_SREG_TR);
+
+	selector =                 GET_SMSTATE(u32, smstate, 0x7fc0);
+	set_desc_base(&desc,       GET_SMSTATE(u32, smstate, 0x7f80));
+	set_desc_limit(&desc,      GET_SMSTATE(u32, smstate, 0x7f7c));
+	rsm_set_desc_flags(&desc,  GET_SMSTATE(u32, smstate, 0x7f78));
+	ctxt->ops->set_segment(ctxt, selector, &desc, 0, VCPU_SREG_LDTR);
+
+	dt.address =               GET_SMSTATE(u32, smstate, 0x7f74);
+	dt.size =                  GET_SMSTATE(u32, smstate, 0x7f70);
+	ctxt->ops->set_gdt(ctxt, &dt);
+
+	dt.address =               GET_SMSTATE(u32, smstate, 0x7f58);
+	dt.size =                  GET_SMSTATE(u32, smstate, 0x7f54);
+	ctxt->ops->set_idt(ctxt, &dt);
+
+	for (i = 0; i < 6; i++) {
+		int r = rsm_load_seg_32(ctxt, smstate, i);
+		if (r != X86EMUL_CONTINUE)
+			return r;
+	}
+
+	cr4 = GET_SMSTATE(u32, smstate, 0x7f14);
+
+	ctxt->ops->set_smbase(ctxt, GET_SMSTATE(u32, smstate, 0x7ef8));
+
+	return rsm_enter_protected_mode(ctxt, cr0, cr3, cr4);
+}
+
+#ifdef CONFIG_X86_64
+static int rsm_load_state_64(struct x86_emulate_ctxt *ctxt,
+			     const char *smstate)
+{
+	struct desc_struct desc;
+	struct desc_ptr dt;
+	u64 val, cr0, cr3, cr4;
+	u32 base3;
+	u16 selector;
+	int i, r;
+
+	for (i = 0; i < NR_EMULATOR_GPRS; i++)
+		*reg_write(ctxt, i) = GET_SMSTATE(u64, smstate, 0x7ff8 - i * 8);
+
+	ctxt->_eip   = GET_SMSTATE(u64, smstate, 0x7f78);
+	ctxt->eflags = GET_SMSTATE(u32, smstate, 0x7f70) | X86_EFLAGS_FIXED;
+
+	val = GET_SMSTATE(u64, smstate, 0x7f68);
+
+	if (ctxt->ops->set_dr(ctxt, 6, val))
+		return X86EMUL_UNHANDLEABLE;
+
+	val = GET_SMSTATE(u64, smstate, 0x7f60);
+
+	if (ctxt->ops->set_dr(ctxt, 7, val))
+		return X86EMUL_UNHANDLEABLE;
+
+	cr0 =                       GET_SMSTATE(u64, smstate, 0x7f58);
+	cr3 =                       GET_SMSTATE(u64, smstate, 0x7f50);
+	cr4 =                       GET_SMSTATE(u64, smstate, 0x7f48);
+	ctxt->ops->set_smbase(ctxt, GET_SMSTATE(u32, smstate, 0x7f00));
+	val =                       GET_SMSTATE(u64, smstate, 0x7ed0);
+
+	if (ctxt->ops->set_msr(ctxt, MSR_EFER, val & ~EFER_LMA))
+		return X86EMUL_UNHANDLEABLE;
+
+	selector =                  GET_SMSTATE(u32, smstate, 0x7e90);
+	rsm_set_desc_flags(&desc,   GET_SMSTATE(u32, smstate, 0x7e92) << 8);
+	set_desc_limit(&desc,       GET_SMSTATE(u32, smstate, 0x7e94));
+	set_desc_base(&desc,        GET_SMSTATE(u32, smstate, 0x7e98));
+	base3 =                     GET_SMSTATE(u32, smstate, 0x7e9c);
+	ctxt->ops->set_segment(ctxt, selector, &desc, base3, VCPU_SREG_TR);
+
+	dt.size =                   GET_SMSTATE(u32, smstate, 0x7e84);
+	dt.address =                GET_SMSTATE(u64, smstate, 0x7e88);
+	ctxt->ops->set_idt(ctxt, &dt);
+
+	selector =                  GET_SMSTATE(u32, smstate, 0x7e70);
+	rsm_set_desc_flags(&desc,   GET_SMSTATE(u32, smstate, 0x7e72) << 8);
+	set_desc_limit(&desc,       GET_SMSTATE(u32, smstate, 0x7e74));
+	set_desc_base(&desc,        GET_SMSTATE(u32, smstate, 0x7e78));
+	base3 =                     GET_SMSTATE(u32, smstate, 0x7e7c);
+	ctxt->ops->set_segment(ctxt, selector, &desc, base3, VCPU_SREG_LDTR);
+
+	dt.size =                   GET_SMSTATE(u32, smstate, 0x7e64);
+	dt.address =                GET_SMSTATE(u64, smstate, 0x7e68);
+	ctxt->ops->set_gdt(ctxt, &dt);
+
+	r = rsm_enter_protected_mode(ctxt, cr0, cr3, cr4);
+	if (r != X86EMUL_CONTINUE)
+		return r;
+
+	for (i = 0; i < 6; i++) {
+		r = rsm_load_seg_64(ctxt, smstate, i);
+		if (r != X86EMUL_CONTINUE)
+			return r;
+	}
+
+	return X86EMUL_CONTINUE;
+}
+#endif
+
+int emulator_leave_smm(struct x86_emulate_ctxt *ctxt)
+{
+	struct kvm_vcpu *vcpu = ctxt->vcpu;
+	unsigned long cr0, cr4, efer;
+	char buf[512];
+	u64 smbase;
+	int ret;
+
+	smbase = ctxt->ops->get_smbase(ctxt);
+
+	ret = ctxt->ops->read_phys(ctxt, smbase + 0xfe00, buf, sizeof(buf));
+	if (ret != X86EMUL_CONTINUE)
+		return X86EMUL_UNHANDLEABLE;
+
+	if ((ctxt->ops->get_hflags(ctxt) & X86EMUL_SMM_INSIDE_NMI_MASK) == 0)
+		ctxt->ops->set_nmi_mask(ctxt, false);
+
+	kvm_smm_changed(vcpu, false);
+
+	/*
+	 * Get back to real mode, to prepare a safe state in which to load
+	 * CR0/CR3/CR4/EFER.  It's all a bit more complicated if the vCPU
+	 * supports long mode.
+	 *
+	 * The ctxt->ops callbacks will handle all side effects when writing
+	 * writing MSRs and CRs, e.g. MMU context resets, CPUID
+	 * runtime updates, etc.
+	 */
+	if (emulator_has_longmode(ctxt)) {
+		struct desc_struct cs_desc;
+
+		/* Zero CR4.PCIDE before CR0.PG.  */
+		cr4 = ctxt->ops->get_cr(ctxt, 4);
+		if (cr4 & X86_CR4_PCIDE)
+			ctxt->ops->set_cr(ctxt, 4, cr4 & ~X86_CR4_PCIDE);
+
+		/* A 32-bit code segment is required to clear EFER.LMA.  */
+		memset(&cs_desc, 0, sizeof(cs_desc));
+		cs_desc.type = 0xb;
+		cs_desc.s = cs_desc.g = cs_desc.p = 1;
+		ctxt->ops->set_segment(ctxt, 0, &cs_desc, 0, VCPU_SREG_CS);
+	}
+
+	/* For the 64-bit case, this will clear EFER.LMA.  */
+	cr0 = ctxt->ops->get_cr(ctxt, 0);
+	if (cr0 & X86_CR0_PE)
+		ctxt->ops->set_cr(ctxt, 0, cr0 & ~(X86_CR0_PG | X86_CR0_PE));
+
+	if (emulator_has_longmode(ctxt)) {
+		/* Clear CR4.PAE before clearing EFER.LME. */
+		cr4 = ctxt->ops->get_cr(ctxt, 4);
+		if (cr4 & X86_CR4_PAE)
+			ctxt->ops->set_cr(ctxt, 4, cr4 & ~X86_CR4_PAE);
+
+		/* And finally go back to 32-bit mode.  */
+		efer = 0;
+		ctxt->ops->set_msr(ctxt, MSR_EFER, efer);
+	}
+
+	/*
+	 * Give leave_smm() a chance to make ISA-specific changes to the vCPU
+	 * state (e.g. enter guest mode) before loading state from the SMM
+	 * state-save area.
+	 */
+	if (static_call(kvm_x86_leave_smm)(vcpu, buf))
+		return X86EMUL_UNHANDLEABLE;
+
+#ifdef CONFIG_X86_64
+	if (emulator_has_longmode(ctxt))
+		return rsm_load_state_64(ctxt, buf);
+	else
+#endif
+		return rsm_load_state_32(ctxt, buf);
+}
diff --git a/arch/x86/kvm/smm.h b/arch/x86/kvm/smm.h
index aacc6dac2c99a1..b0602a92e511e1 100644
--- a/arch/x86/kvm/smm.h
+++ b/arch/x86/kvm/smm.h
@@ -21,6 +21,7 @@ static inline bool is_smm(struct kvm_vcpu *vcpu)
 
 void kvm_smm_changed(struct kvm_vcpu *vcpu, bool in_smm);
 void enter_smm(struct kvm_vcpu *vcpu);
+int emulator_leave_smm(struct x86_emulate_ctxt *ctxt);
 void process_smi(struct kvm_vcpu *vcpu);
 
 #endif
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1f69f54d1dbc82..a1e524c2c39df2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8108,19 +8108,6 @@ static unsigned emulator_get_hflags(struct x86_emulate_ctxt *ctxt)
 	return emul_to_vcpu(ctxt)->arch.hflags;
 }
 
-static void emulator_exiting_smm(struct x86_emulate_ctxt *ctxt)
-{
-	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
-
-	kvm_smm_changed(vcpu, false);
-}
-
-static int emulator_leave_smm(struct x86_emulate_ctxt *ctxt,
-				  const char *smstate)
-{
-	return static_call(kvm_x86_leave_smm)(emul_to_vcpu(ctxt), smstate);
-}
-
 static void emulator_triple_fault(struct x86_emulate_ctxt *ctxt)
 {
 	kvm_make_request(KVM_REQ_TRIPLE_FAULT, emul_to_vcpu(ctxt));
@@ -8184,7 +8171,6 @@ static const struct x86_emulate_ops emulate_ops = {
 	.guest_has_rdpid     = emulator_guest_has_rdpid,
 	.set_nmi_mask        = emulator_set_nmi_mask,
 	.get_hflags          = emulator_get_hflags,
-	.exiting_smm         = emulator_exiting_smm,
 	.leave_smm           = emulator_leave_smm,
 	.triple_fault        = emulator_triple_fault,
 	.set_xcr             = emulator_set_xcr,
-- 
2.34.3

