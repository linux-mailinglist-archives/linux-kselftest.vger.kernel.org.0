Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9FA60CC9C
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 14:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbiJYMw3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 08:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbiJYMvm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 08:51:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1B020374
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 05:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666702136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wpEwGNfqbEqDVN2HPeR/hA2yISpF3GfgtXWKMNYfiSM=;
        b=eYSo7sFTY9U5tjK640KFrSW8jDQ8EUtpdG4vk8SdY7+PKyTPJ1PG96hXV71Lbw6rxPq3RY
        sTzk3Dm9oycMa230tN8s3bR+hoPVoCJTYNryB2O7A4vwENR47uO32nufw/KrXyCm/lSX30
        OHdwSjZTeE/ewv+3MQ95kSe0fqx4i1g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-N8lXtFmKP9u-IiKmbfBepA-1; Tue, 25 Oct 2022 08:48:51 -0400
X-MC-Unique: N8lXtFmKP9u-IiKmbfBepA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95AFD29DD987;
        Tue, 25 Oct 2022 12:48:50 +0000 (UTC)
Received: from amdlaptop.tlv.redhat.com (dhcp-4-238.tlv.redhat.com [10.35.4.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 42C5940C6EC6;
        Tue, 25 Oct 2022 12:48:47 +0000 (UTC)
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
Subject: [PATCH RESEND v4 16/23] KVM: x86: smm: add structs for KVM's smram layout
Date:   Tue, 25 Oct 2022 15:47:34 +0300
Message-Id: <20221025124741.228045-17-mlevitsk@redhat.com>
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

Add structs that will be used to define and read/write the KVM's
SMRAM layout, instead of reading/writing to raw offsets.

Also document the differences between KVM's SMRAM layout and SMRAM
layout that is used by real Intel/AMD cpus.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/smm.c |  94 +++++++++++++++++++++++++++++++++
 arch/x86/kvm/smm.h | 127 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 221 insertions(+)

diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
index 1191a79cf027e5..01dab9fc3ab4b7 100644
--- a/arch/x86/kvm/smm.c
+++ b/arch/x86/kvm/smm.c
@@ -8,6 +8,97 @@
 #include "cpuid.h"
 #include "trace.h"
 
+#define CHECK_SMRAM32_OFFSET(field, offset) \
+	ASSERT_STRUCT_OFFSET(struct kvm_smram_state_32, field, offset - 0xFE00)
+
+#define CHECK_SMRAM64_OFFSET(field, offset) \
+	ASSERT_STRUCT_OFFSET(struct kvm_smram_state_64, field, offset - 0xFE00)
+
+static void check_smram_offsets(void)
+{
+	/* 32 bit SMRAM image */
+	CHECK_SMRAM32_OFFSET(reserved1,			0xFE00);
+	CHECK_SMRAM32_OFFSET(smbase,			0xFEF8);
+	CHECK_SMRAM32_OFFSET(smm_revision,		0xFEFC);
+	CHECK_SMRAM32_OFFSET(reserved2,			0xFF00);
+	CHECK_SMRAM32_OFFSET(cr4,			0xFF14);
+	CHECK_SMRAM32_OFFSET(reserved3,			0xFF18);
+	CHECK_SMRAM32_OFFSET(ds,			0xFF2C);
+	CHECK_SMRAM32_OFFSET(fs,			0xFF38);
+	CHECK_SMRAM32_OFFSET(gs,			0xFF44);
+	CHECK_SMRAM32_OFFSET(idtr,			0xFF50);
+	CHECK_SMRAM32_OFFSET(tr,			0xFF5C);
+	CHECK_SMRAM32_OFFSET(gdtr,			0xFF6C);
+	CHECK_SMRAM32_OFFSET(ldtr,			0xFF78);
+	CHECK_SMRAM32_OFFSET(es,			0xFF84);
+	CHECK_SMRAM32_OFFSET(cs,			0xFF90);
+	CHECK_SMRAM32_OFFSET(ss,			0xFF9C);
+	CHECK_SMRAM32_OFFSET(es_sel,			0xFFA8);
+	CHECK_SMRAM32_OFFSET(cs_sel,			0xFFAC);
+	CHECK_SMRAM32_OFFSET(ss_sel,			0xFFB0);
+	CHECK_SMRAM32_OFFSET(ds_sel,			0xFFB4);
+	CHECK_SMRAM32_OFFSET(fs_sel,			0xFFB8);
+	CHECK_SMRAM32_OFFSET(gs_sel,			0xFFBC);
+	CHECK_SMRAM32_OFFSET(ldtr_sel,			0xFFC0);
+	CHECK_SMRAM32_OFFSET(tr_sel,			0xFFC4);
+	CHECK_SMRAM32_OFFSET(dr7,			0xFFC8);
+	CHECK_SMRAM32_OFFSET(dr6,			0xFFCC);
+	CHECK_SMRAM32_OFFSET(gprs,			0xFFD0);
+	CHECK_SMRAM32_OFFSET(eip,			0xFFF0);
+	CHECK_SMRAM32_OFFSET(eflags,			0xFFF4);
+	CHECK_SMRAM32_OFFSET(cr3,			0xFFF8);
+	CHECK_SMRAM32_OFFSET(cr0,			0xFFFC);
+
+	/* 64 bit SMRAM image */
+	CHECK_SMRAM64_OFFSET(es,			0xFE00);
+	CHECK_SMRAM64_OFFSET(cs,			0xFE10);
+	CHECK_SMRAM64_OFFSET(ss,			0xFE20);
+	CHECK_SMRAM64_OFFSET(ds,			0xFE30);
+	CHECK_SMRAM64_OFFSET(fs,			0xFE40);
+	CHECK_SMRAM64_OFFSET(gs,			0xFE50);
+	CHECK_SMRAM64_OFFSET(gdtr,			0xFE60);
+	CHECK_SMRAM64_OFFSET(ldtr,			0xFE70);
+	CHECK_SMRAM64_OFFSET(idtr,			0xFE80);
+	CHECK_SMRAM64_OFFSET(tr,			0xFE90);
+	CHECK_SMRAM64_OFFSET(io_restart_rip,		0xFEA0);
+	CHECK_SMRAM64_OFFSET(io_restart_rcx,		0xFEA8);
+	CHECK_SMRAM64_OFFSET(io_restart_rsi,		0xFEB0);
+	CHECK_SMRAM64_OFFSET(io_restart_rdi,		0xFEB8);
+	CHECK_SMRAM64_OFFSET(io_restart_dword,		0xFEC0);
+	CHECK_SMRAM64_OFFSET(reserved1,			0xFEC4);
+	CHECK_SMRAM64_OFFSET(io_inst_restart,		0xFEC8);
+	CHECK_SMRAM64_OFFSET(auto_hlt_restart,		0xFEC9);
+	CHECK_SMRAM64_OFFSET(reserved2,			0xFECA);
+	CHECK_SMRAM64_OFFSET(efer,			0xFED0);
+	CHECK_SMRAM64_OFFSET(svm_guest_flag,		0xFED8);
+	CHECK_SMRAM64_OFFSET(svm_guest_vmcb_gpa,	0xFEE0);
+	CHECK_SMRAM64_OFFSET(svm_guest_virtual_int,	0xFEE8);
+	CHECK_SMRAM64_OFFSET(reserved3,			0xFEF0);
+	CHECK_SMRAM64_OFFSET(smm_revison,		0xFEFC);
+	CHECK_SMRAM64_OFFSET(smbase,			0xFF00);
+	CHECK_SMRAM64_OFFSET(reserved4,			0xFF04);
+	CHECK_SMRAM64_OFFSET(ssp,			0xFF18);
+	CHECK_SMRAM64_OFFSET(svm_guest_pat,		0xFF20);
+	CHECK_SMRAM64_OFFSET(svm_host_efer,		0xFF28);
+	CHECK_SMRAM64_OFFSET(svm_host_cr4,		0xFF30);
+	CHECK_SMRAM64_OFFSET(svm_host_cr3,		0xFF38);
+	CHECK_SMRAM64_OFFSET(svm_host_cr0,		0xFF40);
+	CHECK_SMRAM64_OFFSET(cr4,			0xFF48);
+	CHECK_SMRAM64_OFFSET(cr3,			0xFF50);
+	CHECK_SMRAM64_OFFSET(cr0,			0xFF58);
+	CHECK_SMRAM64_OFFSET(dr7,			0xFF60);
+	CHECK_SMRAM64_OFFSET(dr6,			0xFF68);
+	CHECK_SMRAM64_OFFSET(rflags,			0xFF70);
+	CHECK_SMRAM64_OFFSET(rip,			0xFF78);
+	CHECK_SMRAM64_OFFSET(gprs,			0xFF80);
+
+	BUILD_BUG_ON(sizeof(union kvm_smram) != 512);
+}
+
+#undef CHECK_SMRAM64_OFFSET
+#undef CHECK_SMRAM32_OFFSET
+
+
 void kvm_smm_changed(struct kvm_vcpu *vcpu, bool entering_smm)
 {
 	trace_kvm_smm_transition(vcpu->vcpu_id, vcpu->arch.smbase, entering_smm);
@@ -199,6 +290,8 @@ void enter_smm(struct kvm_vcpu *vcpu)
 	unsigned long cr0;
 	char buf[512];
 
+	check_smram_offsets();
+
 	memset(buf, 0, 512);
 #ifdef CONFIG_X86_64
 	if (guest_cpuid_has(vcpu, X86_FEATURE_LM))
@@ -449,6 +542,7 @@ static int rsm_load_state_64(struct x86_emulate_ctxt *ctxt,
 	u64 val, cr0, cr3, cr4;
 	int i, r;
 
+
 	for (i = 0; i < 16; i++)
 		*reg_write(ctxt, i) = GET_SMSTATE(u64, smstate, 0x7ff8 - i * 8);
 
diff --git a/arch/x86/kvm/smm.h b/arch/x86/kvm/smm.h
index a6795b93ba3002..bf5c7ffeb11efc 100644
--- a/arch/x86/kvm/smm.h
+++ b/arch/x86/kvm/smm.h
@@ -2,6 +2,8 @@
 #ifndef ASM_KVM_SMM_H
 #define ASM_KVM_SMM_H
 
+#include <linux/build_bug.h>
+
 #define GET_SMSTATE(type, buf, offset)		\
 	(*(type *)((buf) + (offset) - 0x7e00))
 
@@ -9,6 +11,131 @@
 	*(type *)((buf) + (offset) - 0x7e00) = val
 
 #ifdef CONFIG_KVM_SMM
+
+
+/* 32 bit KVM's emulated SMM layout. Loosely based on Intel's layout */
+
+struct kvm_smm_seg_state_32 {
+	u32 flags;
+	u32 limit;
+	u32 base;
+} __packed;
+
+struct kvm_smram_state_32 {
+	u32 reserved1[62];
+	u32 smbase;
+	u32 smm_revision;
+	u32 reserved2[5];
+	u32 cr4; /* CR4 is not present in Intel/AMD SMRAM image */
+	u32 reserved3[5];
+
+	/*
+	 * Segment state is not present/documented in the Intel/AMD SMRAM image
+	 * Instead this area on Intel/AMD contains IO/HLT restart flags.
+	 */
+	struct kvm_smm_seg_state_32 ds;
+	struct kvm_smm_seg_state_32 fs;
+	struct kvm_smm_seg_state_32 gs;
+	struct kvm_smm_seg_state_32 idtr; /* IDTR has only base and limit */
+	struct kvm_smm_seg_state_32 tr;
+	u32 reserved;
+	struct kvm_smm_seg_state_32 gdtr; /* GDTR has only base and limit */
+	struct kvm_smm_seg_state_32 ldtr;
+	struct kvm_smm_seg_state_32 es;
+	struct kvm_smm_seg_state_32 cs;
+	struct kvm_smm_seg_state_32 ss;
+
+	u32 es_sel;
+	u32 cs_sel;
+	u32 ss_sel;
+	u32 ds_sel;
+	u32 fs_sel;
+	u32 gs_sel;
+	u32 ldtr_sel;
+	u32 tr_sel;
+
+	u32 dr7;
+	u32 dr6;
+	u32 gprs[8]; /* GPRS in the "natural" X86 order (EAX/ECX/EDX.../EDI) */
+	u32 eip;
+	u32 eflags;
+	u32 cr3;
+	u32 cr0;
+} __packed;
+
+
+/* 64 bit KVM's emulated SMM layout. Based on AMD64 layout */
+
+struct kvm_smm_seg_state_64 {
+	u16 selector;
+	u16 attributes;
+	u32 limit;
+	u64 base;
+};
+
+struct kvm_smram_state_64 {
+
+	struct kvm_smm_seg_state_64 es;
+	struct kvm_smm_seg_state_64 cs;
+	struct kvm_smm_seg_state_64 ss;
+	struct kvm_smm_seg_state_64 ds;
+	struct kvm_smm_seg_state_64 fs;
+	struct kvm_smm_seg_state_64 gs;
+	struct kvm_smm_seg_state_64 gdtr; /* GDTR has only base and limit*/
+	struct kvm_smm_seg_state_64 ldtr;
+	struct kvm_smm_seg_state_64 idtr; /* IDTR has only base and limit*/
+	struct kvm_smm_seg_state_64 tr;
+
+	/* I/O restart and auto halt restart are not implemented by KVM */
+	u64 io_restart_rip;
+	u64 io_restart_rcx;
+	u64 io_restart_rsi;
+	u64 io_restart_rdi;
+	u32 io_restart_dword;
+	u32 reserved1;
+	u8 io_inst_restart;
+	u8 auto_hlt_restart;
+	u8 reserved2[6];
+
+	u64 efer;
+
+	/*
+	 * Two fields below are implemented on AMD only, to store
+	 * SVM guest vmcb address if the #SMI was received while in the guest mode.
+	 */
+	u64 svm_guest_flag;
+	u64 svm_guest_vmcb_gpa;
+	u64 svm_guest_virtual_int; /* unknown purpose, not implemented */
+
+	u32 reserved3[3];
+	u32 smm_revison;
+	u32 smbase;
+	u32 reserved4[5];
+
+	/* ssp and svm_* fields below are not implemented by KVM */
+	u64 ssp;
+	u64 svm_guest_pat;
+	u64 svm_host_efer;
+	u64 svm_host_cr4;
+	u64 svm_host_cr3;
+	u64 svm_host_cr0;
+
+	u64 cr4;
+	u64 cr3;
+	u64 cr0;
+	u64 dr7;
+	u64 dr6;
+	u64 rflags;
+	u64 rip;
+	u64 gprs[16]; /* GPRS in a reversed "natural" X86 order (R15/R14/../RCX/RAX.) */
+};
+
+union kvm_smram {
+	struct kvm_smram_state_64 smram64;
+	struct kvm_smram_state_32 smram32;
+	u8 bytes[512];
+};
+
 static inline int kvm_inject_smi(struct kvm_vcpu *vcpu)
 {
 	kvm_make_request(KVM_REQ_SMI, vcpu);
-- 
2.34.3

