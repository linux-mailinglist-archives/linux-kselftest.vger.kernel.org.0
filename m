Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B8A60CC69
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 14:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbiJYMuQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 08:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbiJYMt4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 08:49:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A48198459
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 05:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666702079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g32vYfZmQC/FfC8zdSX48jNbwS+70jujqjXZ+Grg1Hc=;
        b=i4wElXkMRcP5QyEBBCHeAI8w6688QwSWWENf17YsM0lya2pkcLm956s/Vms4QsGXGCpWvg
        VyoUC9nKRpXcUBIouhCY+86S261KNF6EtJcqE2LPlr4EbXQSkT2l1oPApGpxdAv4t7brmI
        uQWfNuwSqawO8Hgsar0zwFD8Ksb/fWI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-m8z2_KFEM3ibxzkuOkqlfQ-1; Tue, 25 Oct 2022 08:47:55 -0400
X-MC-Unique: m8z2_KFEM3ibxzkuOkqlfQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB6488279A7;
        Tue, 25 Oct 2022 12:47:53 +0000 (UTC)
Received: from amdlaptop.tlv.redhat.com (dhcp-4-238.tlv.redhat.com [10.35.4.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3AE6E40C6EC6;
        Tue, 25 Oct 2022 12:47:50 +0000 (UTC)
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
Subject: [PATCH RESEND v4 02/23] KVM: x86: move SMM entry to a new file
Date:   Tue, 25 Oct 2022 15:47:20 +0300
Message-Id: <20221025124741.228045-3-mlevitsk@redhat.com>
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

From: Paolo Bonzini <pbonzini@redhat.com>

Some users of KVM implement the UEFI variable store through a paravirtual
device that does not require the "SMM lockbox" component of edk2, and
would like to compile out system management mode.  In preparation for
that, move the SMM entry code out of x86.c and into a new file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |   1 +
 arch/x86/kvm/smm.c              | 235 +++++++++++++++++++++++++++++++
 arch/x86/kvm/smm.h              |   1 +
 arch/x86/kvm/x86.c              | 239 +-------------------------------
 4 files changed, 239 insertions(+), 237 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index af9798681f88a1..4afed04fcc8241 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1839,6 +1839,7 @@ int kvm_emulate_ap_reset_hold(struct kvm_vcpu *vcpu);
 int kvm_emulate_wbinvd(struct kvm_vcpu *vcpu);
 
 void kvm_get_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg);
+void kvm_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg);
 int kvm_load_segment_descriptor(struct kvm_vcpu *vcpu, u16 selector, int seg);
 void kvm_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector);
 
diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
index b91c48d91f6ed9..26a6859e421fe1 100644
--- a/arch/x86/kvm/smm.c
+++ b/arch/x86/kvm/smm.c
@@ -5,6 +5,7 @@
 #include "kvm_cache_regs.h"
 #include "kvm_emulate.h"
 #include "smm.h"
+#include "cpuid.h"
 #include "trace.h"
 
 void kvm_smm_changed(struct kvm_vcpu *vcpu, bool entering_smm)
@@ -35,3 +36,237 @@ void process_smi(struct kvm_vcpu *vcpu)
 	vcpu->arch.smi_pending = true;
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 }
+
+static u32 enter_smm_get_segment_flags(struct kvm_segment *seg)
+{
+	u32 flags = 0;
+	flags |= seg->g       << 23;
+	flags |= seg->db      << 22;
+	flags |= seg->l       << 21;
+	flags |= seg->avl     << 20;
+	flags |= seg->present << 15;
+	flags |= seg->dpl     << 13;
+	flags |= seg->s       << 12;
+	flags |= seg->type    << 8;
+	return flags;
+}
+
+static void enter_smm_save_seg_32(struct kvm_vcpu *vcpu, char *buf, int n)
+{
+	struct kvm_segment seg;
+	int offset;
+
+	kvm_get_segment(vcpu, &seg, n);
+	PUT_SMSTATE(u32, buf, 0x7fa8 + n * 4, seg.selector);
+
+	if (n < 3)
+		offset = 0x7f84 + n * 12;
+	else
+		offset = 0x7f2c + (n - 3) * 12;
+
+	PUT_SMSTATE(u32, buf, offset + 8, seg.base);
+	PUT_SMSTATE(u32, buf, offset + 4, seg.limit);
+	PUT_SMSTATE(u32, buf, offset, enter_smm_get_segment_flags(&seg));
+}
+
+#ifdef CONFIG_X86_64
+static void enter_smm_save_seg_64(struct kvm_vcpu *vcpu, char *buf, int n)
+{
+	struct kvm_segment seg;
+	int offset;
+	u16 flags;
+
+	kvm_get_segment(vcpu, &seg, n);
+	offset = 0x7e00 + n * 16;
+
+	flags = enter_smm_get_segment_flags(&seg) >> 8;
+	PUT_SMSTATE(u16, buf, offset, seg.selector);
+	PUT_SMSTATE(u16, buf, offset + 2, flags);
+	PUT_SMSTATE(u32, buf, offset + 4, seg.limit);
+	PUT_SMSTATE(u64, buf, offset + 8, seg.base);
+}
+#endif
+
+static void enter_smm_save_state_32(struct kvm_vcpu *vcpu, char *buf)
+{
+	struct desc_ptr dt;
+	struct kvm_segment seg;
+	unsigned long val;
+	int i;
+
+	PUT_SMSTATE(u32, buf, 0x7ffc, kvm_read_cr0(vcpu));
+	PUT_SMSTATE(u32, buf, 0x7ff8, kvm_read_cr3(vcpu));
+	PUT_SMSTATE(u32, buf, 0x7ff4, kvm_get_rflags(vcpu));
+	PUT_SMSTATE(u32, buf, 0x7ff0, kvm_rip_read(vcpu));
+
+	for (i = 0; i < 8; i++)
+		PUT_SMSTATE(u32, buf, 0x7fd0 + i * 4, kvm_register_read_raw(vcpu, i));
+
+	kvm_get_dr(vcpu, 6, &val);
+	PUT_SMSTATE(u32, buf, 0x7fcc, (u32)val);
+	kvm_get_dr(vcpu, 7, &val);
+	PUT_SMSTATE(u32, buf, 0x7fc8, (u32)val);
+
+	kvm_get_segment(vcpu, &seg, VCPU_SREG_TR);
+	PUT_SMSTATE(u32, buf, 0x7fc4, seg.selector);
+	PUT_SMSTATE(u32, buf, 0x7f64, seg.base);
+	PUT_SMSTATE(u32, buf, 0x7f60, seg.limit);
+	PUT_SMSTATE(u32, buf, 0x7f5c, enter_smm_get_segment_flags(&seg));
+
+	kvm_get_segment(vcpu, &seg, VCPU_SREG_LDTR);
+	PUT_SMSTATE(u32, buf, 0x7fc0, seg.selector);
+	PUT_SMSTATE(u32, buf, 0x7f80, seg.base);
+	PUT_SMSTATE(u32, buf, 0x7f7c, seg.limit);
+	PUT_SMSTATE(u32, buf, 0x7f78, enter_smm_get_segment_flags(&seg));
+
+	static_call(kvm_x86_get_gdt)(vcpu, &dt);
+	PUT_SMSTATE(u32, buf, 0x7f74, dt.address);
+	PUT_SMSTATE(u32, buf, 0x7f70, dt.size);
+
+	static_call(kvm_x86_get_idt)(vcpu, &dt);
+	PUT_SMSTATE(u32, buf, 0x7f58, dt.address);
+	PUT_SMSTATE(u32, buf, 0x7f54, dt.size);
+
+	for (i = 0; i < 6; i++)
+		enter_smm_save_seg_32(vcpu, buf, i);
+
+	PUT_SMSTATE(u32, buf, 0x7f14, kvm_read_cr4(vcpu));
+
+	/* revision id */
+	PUT_SMSTATE(u32, buf, 0x7efc, 0x00020000);
+	PUT_SMSTATE(u32, buf, 0x7ef8, vcpu->arch.smbase);
+}
+
+#ifdef CONFIG_X86_64
+static void enter_smm_save_state_64(struct kvm_vcpu *vcpu, char *buf)
+{
+	struct desc_ptr dt;
+	struct kvm_segment seg;
+	unsigned long val;
+	int i;
+
+	for (i = 0; i < 16; i++)
+		PUT_SMSTATE(u64, buf, 0x7ff8 - i * 8, kvm_register_read_raw(vcpu, i));
+
+	PUT_SMSTATE(u64, buf, 0x7f78, kvm_rip_read(vcpu));
+	PUT_SMSTATE(u32, buf, 0x7f70, kvm_get_rflags(vcpu));
+
+	kvm_get_dr(vcpu, 6, &val);
+	PUT_SMSTATE(u64, buf, 0x7f68, val);
+	kvm_get_dr(vcpu, 7, &val);
+	PUT_SMSTATE(u64, buf, 0x7f60, val);
+
+	PUT_SMSTATE(u64, buf, 0x7f58, kvm_read_cr0(vcpu));
+	PUT_SMSTATE(u64, buf, 0x7f50, kvm_read_cr3(vcpu));
+	PUT_SMSTATE(u64, buf, 0x7f48, kvm_read_cr4(vcpu));
+
+	PUT_SMSTATE(u32, buf, 0x7f00, vcpu->arch.smbase);
+
+	/* revision id */
+	PUT_SMSTATE(u32, buf, 0x7efc, 0x00020064);
+
+	PUT_SMSTATE(u64, buf, 0x7ed0, vcpu->arch.efer);
+
+	kvm_get_segment(vcpu, &seg, VCPU_SREG_TR);
+	PUT_SMSTATE(u16, buf, 0x7e90, seg.selector);
+	PUT_SMSTATE(u16, buf, 0x7e92, enter_smm_get_segment_flags(&seg) >> 8);
+	PUT_SMSTATE(u32, buf, 0x7e94, seg.limit);
+	PUT_SMSTATE(u64, buf, 0x7e98, seg.base);
+
+	static_call(kvm_x86_get_idt)(vcpu, &dt);
+	PUT_SMSTATE(u32, buf, 0x7e84, dt.size);
+	PUT_SMSTATE(u64, buf, 0x7e88, dt.address);
+
+	kvm_get_segment(vcpu, &seg, VCPU_SREG_LDTR);
+	PUT_SMSTATE(u16, buf, 0x7e70, seg.selector);
+	PUT_SMSTATE(u16, buf, 0x7e72, enter_smm_get_segment_flags(&seg) >> 8);
+	PUT_SMSTATE(u32, buf, 0x7e74, seg.limit);
+	PUT_SMSTATE(u64, buf, 0x7e78, seg.base);
+
+	static_call(kvm_x86_get_gdt)(vcpu, &dt);
+	PUT_SMSTATE(u32, buf, 0x7e64, dt.size);
+	PUT_SMSTATE(u64, buf, 0x7e68, dt.address);
+
+	for (i = 0; i < 6; i++)
+		enter_smm_save_seg_64(vcpu, buf, i);
+}
+#endif
+
+void enter_smm(struct kvm_vcpu *vcpu)
+{
+	struct kvm_segment cs, ds;
+	struct desc_ptr dt;
+	unsigned long cr0;
+	char buf[512];
+
+	memset(buf, 0, 512);
+#ifdef CONFIG_X86_64
+	if (guest_cpuid_has(vcpu, X86_FEATURE_LM))
+		enter_smm_save_state_64(vcpu, buf);
+	else
+#endif
+		enter_smm_save_state_32(vcpu, buf);
+
+	/*
+	 * Give enter_smm() a chance to make ISA-specific changes to the vCPU
+	 * state (e.g. leave guest mode) after we've saved the state into the
+	 * SMM state-save area.
+	 */
+	static_call(kvm_x86_enter_smm)(vcpu, buf);
+
+	kvm_smm_changed(vcpu, true);
+	kvm_vcpu_write_guest(vcpu, vcpu->arch.smbase + 0xfe00, buf, sizeof(buf));
+
+	if (static_call(kvm_x86_get_nmi_mask)(vcpu))
+		vcpu->arch.hflags |= HF_SMM_INSIDE_NMI_MASK;
+	else
+		static_call(kvm_x86_set_nmi_mask)(vcpu, true);
+
+	kvm_set_rflags(vcpu, X86_EFLAGS_FIXED);
+	kvm_rip_write(vcpu, 0x8000);
+
+	cr0 = vcpu->arch.cr0 & ~(X86_CR0_PE | X86_CR0_EM | X86_CR0_TS | X86_CR0_PG);
+	static_call(kvm_x86_set_cr0)(vcpu, cr0);
+	vcpu->arch.cr0 = cr0;
+
+	static_call(kvm_x86_set_cr4)(vcpu, 0);
+
+	/* Undocumented: IDT limit is set to zero on entry to SMM.  */
+	dt.address = dt.size = 0;
+	static_call(kvm_x86_set_idt)(vcpu, &dt);
+
+	kvm_set_dr(vcpu, 7, DR7_FIXED_1);
+
+	cs.selector = (vcpu->arch.smbase >> 4) & 0xffff;
+	cs.base = vcpu->arch.smbase;
+
+	ds.selector = 0;
+	ds.base = 0;
+
+	cs.limit    = ds.limit = 0xffffffff;
+	cs.type     = ds.type = 0x3;
+	cs.dpl      = ds.dpl = 0;
+	cs.db       = ds.db = 0;
+	cs.s        = ds.s = 1;
+	cs.l        = ds.l = 0;
+	cs.g        = ds.g = 1;
+	cs.avl      = ds.avl = 0;
+	cs.present  = ds.present = 1;
+	cs.unusable = ds.unusable = 0;
+	cs.padding  = ds.padding = 0;
+
+	kvm_set_segment(vcpu, &cs, VCPU_SREG_CS);
+	kvm_set_segment(vcpu, &ds, VCPU_SREG_DS);
+	kvm_set_segment(vcpu, &ds, VCPU_SREG_ES);
+	kvm_set_segment(vcpu, &ds, VCPU_SREG_FS);
+	kvm_set_segment(vcpu, &ds, VCPU_SREG_GS);
+	kvm_set_segment(vcpu, &ds, VCPU_SREG_SS);
+
+#ifdef CONFIG_X86_64
+	if (guest_cpuid_has(vcpu, X86_FEATURE_LM))
+		static_call(kvm_x86_set_efer)(vcpu, 0);
+#endif
+
+	kvm_update_cpuid_runtime(vcpu);
+	kvm_mmu_reset_context(vcpu);
+}
diff --git a/arch/x86/kvm/smm.h b/arch/x86/kvm/smm.h
index d85d4ccd32dd13..aacc6dac2c99a1 100644
--- a/arch/x86/kvm/smm.h
+++ b/arch/x86/kvm/smm.h
@@ -20,6 +20,7 @@ static inline bool is_smm(struct kvm_vcpu *vcpu)
 }
 
 void kvm_smm_changed(struct kvm_vcpu *vcpu, bool in_smm);
+void enter_smm(struct kvm_vcpu *vcpu);
 void process_smi(struct kvm_vcpu *vcpu);
 
 #endif
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6a5cebf7250826..1f69f54d1dbc82 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -120,7 +120,6 @@ static u64 __read_mostly cr4_reserved_bits = CR4_RESERVED_BITS;
 
 static void update_cr8_intercept(struct kvm_vcpu *vcpu);
 static void process_nmi(struct kvm_vcpu *vcpu);
-static void enter_smm(struct kvm_vcpu *vcpu);
 static void __kvm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags);
 static void store_regs(struct kvm_vcpu *vcpu);
 static int sync_regs(struct kvm_vcpu *vcpu);
@@ -7056,8 +7055,8 @@ static int vcpu_mmio_read(struct kvm_vcpu *vcpu, gpa_t addr, int len, void *v)
 	return handled;
 }
 
-static void kvm_set_segment(struct kvm_vcpu *vcpu,
-			struct kvm_segment *var, int seg)
+void kvm_set_segment(struct kvm_vcpu *vcpu,
+		     struct kvm_segment *var, int seg)
 {
 	static_call(kvm_x86_set_segment)(vcpu, var, seg);
 }
@@ -9981,240 +9980,6 @@ static void process_nmi(struct kvm_vcpu *vcpu)
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 }
 
-static u32 enter_smm_get_segment_flags(struct kvm_segment *seg)
-{
-	u32 flags = 0;
-	flags |= seg->g       << 23;
-	flags |= seg->db      << 22;
-	flags |= seg->l       << 21;
-	flags |= seg->avl     << 20;
-	flags |= seg->present << 15;
-	flags |= seg->dpl     << 13;
-	flags |= seg->s       << 12;
-	flags |= seg->type    << 8;
-	return flags;
-}
-
-static void enter_smm_save_seg_32(struct kvm_vcpu *vcpu, char *buf, int n)
-{
-	struct kvm_segment seg;
-	int offset;
-
-	kvm_get_segment(vcpu, &seg, n);
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
-}
-
-#ifdef CONFIG_X86_64
-static void enter_smm_save_seg_64(struct kvm_vcpu *vcpu, char *buf, int n)
-{
-	struct kvm_segment seg;
-	int offset;
-	u16 flags;
-
-	kvm_get_segment(vcpu, &seg, n);
-	offset = 0x7e00 + n * 16;
-
-	flags = enter_smm_get_segment_flags(&seg) >> 8;
-	PUT_SMSTATE(u16, buf, offset, seg.selector);
-	PUT_SMSTATE(u16, buf, offset + 2, flags);
-	PUT_SMSTATE(u32, buf, offset + 4, seg.limit);
-	PUT_SMSTATE(u64, buf, offset + 8, seg.base);
-}
-#endif
-
-static void enter_smm_save_state_32(struct kvm_vcpu *vcpu, char *buf)
-{
-	struct desc_ptr dt;
-	struct kvm_segment seg;
-	unsigned long val;
-	int i;
-
-	PUT_SMSTATE(u32, buf, 0x7ffc, kvm_read_cr0(vcpu));
-	PUT_SMSTATE(u32, buf, 0x7ff8, kvm_read_cr3(vcpu));
-	PUT_SMSTATE(u32, buf, 0x7ff4, kvm_get_rflags(vcpu));
-	PUT_SMSTATE(u32, buf, 0x7ff0, kvm_rip_read(vcpu));
-
-	for (i = 0; i < 8; i++)
-		PUT_SMSTATE(u32, buf, 0x7fd0 + i * 4, kvm_register_read_raw(vcpu, i));
-
-	kvm_get_dr(vcpu, 6, &val);
-	PUT_SMSTATE(u32, buf, 0x7fcc, (u32)val);
-	kvm_get_dr(vcpu, 7, &val);
-	PUT_SMSTATE(u32, buf, 0x7fc8, (u32)val);
-
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
-
-	static_call(kvm_x86_get_gdt)(vcpu, &dt);
-	PUT_SMSTATE(u32, buf, 0x7f74, dt.address);
-	PUT_SMSTATE(u32, buf, 0x7f70, dt.size);
-
-	static_call(kvm_x86_get_idt)(vcpu, &dt);
-	PUT_SMSTATE(u32, buf, 0x7f58, dt.address);
-	PUT_SMSTATE(u32, buf, 0x7f54, dt.size);
-
-	for (i = 0; i < 6; i++)
-		enter_smm_save_seg_32(vcpu, buf, i);
-
-	PUT_SMSTATE(u32, buf, 0x7f14, kvm_read_cr4(vcpu));
-
-	/* revision id */
-	PUT_SMSTATE(u32, buf, 0x7efc, 0x00020000);
-	PUT_SMSTATE(u32, buf, 0x7ef8, vcpu->arch.smbase);
-}
-
-#ifdef CONFIG_X86_64
-static void enter_smm_save_state_64(struct kvm_vcpu *vcpu, char *buf)
-{
-	struct desc_ptr dt;
-	struct kvm_segment seg;
-	unsigned long val;
-	int i;
-
-	for (i = 0; i < 16; i++)
-		PUT_SMSTATE(u64, buf, 0x7ff8 - i * 8, kvm_register_read_raw(vcpu, i));
-
-	PUT_SMSTATE(u64, buf, 0x7f78, kvm_rip_read(vcpu));
-	PUT_SMSTATE(u32, buf, 0x7f70, kvm_get_rflags(vcpu));
-
-	kvm_get_dr(vcpu, 6, &val);
-	PUT_SMSTATE(u64, buf, 0x7f68, val);
-	kvm_get_dr(vcpu, 7, &val);
-	PUT_SMSTATE(u64, buf, 0x7f60, val);
-
-	PUT_SMSTATE(u64, buf, 0x7f58, kvm_read_cr0(vcpu));
-	PUT_SMSTATE(u64, buf, 0x7f50, kvm_read_cr3(vcpu));
-	PUT_SMSTATE(u64, buf, 0x7f48, kvm_read_cr4(vcpu));
-
-	PUT_SMSTATE(u32, buf, 0x7f00, vcpu->arch.smbase);
-
-	/* revision id */
-	PUT_SMSTATE(u32, buf, 0x7efc, 0x00020064);
-
-	PUT_SMSTATE(u64, buf, 0x7ed0, vcpu->arch.efer);
-
-	kvm_get_segment(vcpu, &seg, VCPU_SREG_TR);
-	PUT_SMSTATE(u16, buf, 0x7e90, seg.selector);
-	PUT_SMSTATE(u16, buf, 0x7e92, enter_smm_get_segment_flags(&seg) >> 8);
-	PUT_SMSTATE(u32, buf, 0x7e94, seg.limit);
-	PUT_SMSTATE(u64, buf, 0x7e98, seg.base);
-
-	static_call(kvm_x86_get_idt)(vcpu, &dt);
-	PUT_SMSTATE(u32, buf, 0x7e84, dt.size);
-	PUT_SMSTATE(u64, buf, 0x7e88, dt.address);
-
-	kvm_get_segment(vcpu, &seg, VCPU_SREG_LDTR);
-	PUT_SMSTATE(u16, buf, 0x7e70, seg.selector);
-	PUT_SMSTATE(u16, buf, 0x7e72, enter_smm_get_segment_flags(&seg) >> 8);
-	PUT_SMSTATE(u32, buf, 0x7e74, seg.limit);
-	PUT_SMSTATE(u64, buf, 0x7e78, seg.base);
-
-	static_call(kvm_x86_get_gdt)(vcpu, &dt);
-	PUT_SMSTATE(u32, buf, 0x7e64, dt.size);
-	PUT_SMSTATE(u64, buf, 0x7e68, dt.address);
-
-	for (i = 0; i < 6; i++)
-		enter_smm_save_seg_64(vcpu, buf, i);
-}
-#endif
-
-static void enter_smm(struct kvm_vcpu *vcpu)
-{
-	struct kvm_segment cs, ds;
-	struct desc_ptr dt;
-	unsigned long cr0;
-	char buf[512];
-
-	memset(buf, 0, 512);
-#ifdef CONFIG_X86_64
-	if (guest_cpuid_has(vcpu, X86_FEATURE_LM))
-		enter_smm_save_state_64(vcpu, buf);
-	else
-#endif
-		enter_smm_save_state_32(vcpu, buf);
-
-	/*
-	 * Give enter_smm() a chance to make ISA-specific changes to the vCPU
-	 * state (e.g. leave guest mode) after we've saved the state into the
-	 * SMM state-save area.
-	 */
-	static_call(kvm_x86_enter_smm)(vcpu, buf);
-
-	kvm_smm_changed(vcpu, true);
-	kvm_vcpu_write_guest(vcpu, vcpu->arch.smbase + 0xfe00, buf, sizeof(buf));
-
-	if (static_call(kvm_x86_get_nmi_mask)(vcpu))
-		vcpu->arch.hflags |= HF_SMM_INSIDE_NMI_MASK;
-	else
-		static_call(kvm_x86_set_nmi_mask)(vcpu, true);
-
-	kvm_set_rflags(vcpu, X86_EFLAGS_FIXED);
-	kvm_rip_write(vcpu, 0x8000);
-
-	cr0 = vcpu->arch.cr0 & ~(X86_CR0_PE | X86_CR0_EM | X86_CR0_TS | X86_CR0_PG);
-	static_call(kvm_x86_set_cr0)(vcpu, cr0);
-	vcpu->arch.cr0 = cr0;
-
-	static_call(kvm_x86_set_cr4)(vcpu, 0);
-
-	/* Undocumented: IDT limit is set to zero on entry to SMM.  */
-	dt.address = dt.size = 0;
-	static_call(kvm_x86_set_idt)(vcpu, &dt);
-
-	kvm_set_dr(vcpu, 7, DR7_FIXED_1);
-
-	cs.selector = (vcpu->arch.smbase >> 4) & 0xffff;
-	cs.base = vcpu->arch.smbase;
-
-	ds.selector = 0;
-	ds.base = 0;
-
-	cs.limit    = ds.limit = 0xffffffff;
-	cs.type     = ds.type = 0x3;
-	cs.dpl      = ds.dpl = 0;
-	cs.db       = ds.db = 0;
-	cs.s        = ds.s = 1;
-	cs.l        = ds.l = 0;
-	cs.g        = ds.g = 1;
-	cs.avl      = ds.avl = 0;
-	cs.present  = ds.present = 1;
-	cs.unusable = ds.unusable = 0;
-	cs.padding  = ds.padding = 0;
-
-	kvm_set_segment(vcpu, &cs, VCPU_SREG_CS);
-	kvm_set_segment(vcpu, &ds, VCPU_SREG_DS);
-	kvm_set_segment(vcpu, &ds, VCPU_SREG_ES);
-	kvm_set_segment(vcpu, &ds, VCPU_SREG_FS);
-	kvm_set_segment(vcpu, &ds, VCPU_SREG_GS);
-	kvm_set_segment(vcpu, &ds, VCPU_SREG_SS);
-
-#ifdef CONFIG_X86_64
-	if (guest_cpuid_has(vcpu, X86_FEATURE_LM))
-		static_call(kvm_x86_set_efer)(vcpu, 0);
-#endif
-
-	kvm_update_cpuid_runtime(vcpu);
-	kvm_mmu_reset_context(vcpu);
-}
-
 void kvm_make_scan_ioapic_request_mask(struct kvm *kvm,
 				       unsigned long *vcpu_bitmap)
 {
-- 
2.34.3

