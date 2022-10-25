Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCAC60CC57
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 14:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbiJYMq3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 08:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbiJYMpx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 08:45:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEF818F90E
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 05:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666701851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O2KKQqiBuAHVj5vGZFUVxQHEXy/uFmo1yeui9P4vRUI=;
        b=XDbM8RtCghtLG8uSAyAtV0czcJfBdpeNDh58sp0PRbn5rJjEzQ4mVczBAjTqFb6wBsyplg
        9NcydXbN14iyprbBzaree3vlECq4AZ/aRhBXmpmJe/y26Ou8F03/eeDO4gJf6vQBAvgGVO
        u8+wGozxw/TfLWpfbPCLXMLDe3dhRjU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-T1ukjTZdNwKmXisriy3hkA-1; Tue, 25 Oct 2022 08:44:08 -0400
X-MC-Unique: T1ukjTZdNwKmXisriy3hkA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1AEF3833AF4;
        Tue, 25 Oct 2022 12:44:07 +0000 (UTC)
Received: from amdlaptop.tlv.redhat.com (dhcp-4-238.tlv.redhat.com [10.35.4.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 86C35201C0D2;
        Tue, 25 Oct 2022 12:43:51 +0000 (UTC)
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
Subject: [PATCH v4 17/23] KVM: x86: smm: use smram structs in the common code
Date:   Tue, 25 Oct 2022 15:42:17 +0300
Message-Id: <20221025124223.227577-18-mlevitsk@redhat.com>
In-Reply-To: <20221025124223.227577-1-mlevitsk@redhat.com>
References: <20221025124223.227577-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use kvm_smram union instad of raw arrays in the common smm code.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  5 +++--
 arch/x86/kvm/smm.c              | 27 ++++++++++++++-------------
 arch/x86/kvm/svm/svm.c          |  8 ++++++--
 arch/x86/kvm/vmx/vmx.c          |  4 ++--
 4 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0b0a82c0bb5cbd..540ff3122bbf8e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -206,6 +206,7 @@ typedef enum exit_fastpath_completion fastpath_t;
 
 struct x86_emulate_ctxt;
 struct x86_exception;
+union kvm_smram;
 enum x86_intercept;
 enum x86_intercept_stage;
 
@@ -1611,8 +1612,8 @@ struct kvm_x86_ops {
 
 #ifdef CONFIG_KVM_SMM
 	int (*smi_allowed)(struct kvm_vcpu *vcpu, bool for_injection);
-	int (*enter_smm)(struct kvm_vcpu *vcpu, char *smstate);
-	int (*leave_smm)(struct kvm_vcpu *vcpu, const char *smstate);
+	int (*enter_smm)(struct kvm_vcpu *vcpu, union kvm_smram *smram);
+	int (*leave_smm)(struct kvm_vcpu *vcpu, const union kvm_smram *smram);
 	void (*enable_smi_window)(struct kvm_vcpu *vcpu);
 #endif
 
diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
index 01dab9fc3ab4b7..e714d43b746cce 100644
--- a/arch/x86/kvm/smm.c
+++ b/arch/x86/kvm/smm.c
@@ -288,17 +288,18 @@ void enter_smm(struct kvm_vcpu *vcpu)
 	struct kvm_segment cs, ds;
 	struct desc_ptr dt;
 	unsigned long cr0;
-	char buf[512];
+	union kvm_smram smram;
 
 	check_smram_offsets();
 
-	memset(buf, 0, 512);
+	memset(smram.bytes, 0, sizeof(smram.bytes));
+
 #ifdef CONFIG_X86_64
 	if (guest_cpuid_has(vcpu, X86_FEATURE_LM))
-		enter_smm_save_state_64(vcpu, buf);
+		enter_smm_save_state_64(vcpu, smram.bytes);
 	else
 #endif
-		enter_smm_save_state_32(vcpu, buf);
+		enter_smm_save_state_32(vcpu, smram.bytes);
 
 	/*
 	 * Give enter_smm() a chance to make ISA-specific changes to the vCPU
@@ -308,12 +309,12 @@ void enter_smm(struct kvm_vcpu *vcpu)
 	 * Kill the VM in the unlikely case of failure, because the VM
 	 * can be in undefined state in this case.
 	 */
-	if (static_call(kvm_x86_enter_smm)(vcpu, buf))
+	if (static_call(kvm_x86_enter_smm)(vcpu, &smram))
 		goto error;
 
 	kvm_smm_changed(vcpu, true);
 
-	if (kvm_vcpu_write_guest(vcpu, vcpu->arch.smbase + 0xfe00, buf, sizeof(buf)))
+	if (kvm_vcpu_write_guest(vcpu, vcpu->arch.smbase + 0xfe00, &smram, sizeof(smram)))
 		goto error;
 
 	if (static_call(kvm_x86_get_nmi_mask)(vcpu))
@@ -473,7 +474,7 @@ static int rsm_enter_protected_mode(struct kvm_vcpu *vcpu,
 }
 
 static int rsm_load_state_32(struct x86_emulate_ctxt *ctxt,
-			     const char *smstate)
+			     u8 *smstate)
 {
 	struct kvm_vcpu *vcpu = ctxt->vcpu;
 	struct kvm_segment desc;
@@ -534,7 +535,7 @@ static int rsm_load_state_32(struct x86_emulate_ctxt *ctxt,
 
 #ifdef CONFIG_X86_64
 static int rsm_load_state_64(struct x86_emulate_ctxt *ctxt,
-			     const char *smstate)
+			     u8 *smstate)
 {
 	struct kvm_vcpu *vcpu = ctxt->vcpu;
 	struct kvm_segment desc;
@@ -606,13 +607,13 @@ int emulator_leave_smm(struct x86_emulate_ctxt *ctxt)
 {
 	struct kvm_vcpu *vcpu = ctxt->vcpu;
 	unsigned long cr0, cr4, efer;
-	char buf[512];
+	union kvm_smram smram;
 	u64 smbase;
 	int ret;
 
 	smbase = vcpu->arch.smbase;
 
-	ret = kvm_vcpu_read_guest(vcpu, smbase + 0xfe00, buf, sizeof(buf));
+	ret = kvm_vcpu_read_guest(vcpu, smbase + 0xfe00, smram.bytes, sizeof(smram));
 	if (ret < 0)
 		return X86EMUL_UNHANDLEABLE;
 
@@ -666,13 +667,13 @@ int emulator_leave_smm(struct x86_emulate_ctxt *ctxt)
 	 * state (e.g. enter guest mode) before loading state from the SMM
 	 * state-save area.
 	 */
-	if (static_call(kvm_x86_leave_smm)(vcpu, buf))
+	if (static_call(kvm_x86_leave_smm)(vcpu, &smram))
 		return X86EMUL_UNHANDLEABLE;
 
 #ifdef CONFIG_X86_64
 	if (guest_cpuid_has(vcpu, X86_FEATURE_LM))
-		return rsm_load_state_64(ctxt, buf);
+		return rsm_load_state_64(ctxt, smram.bytes);
 	else
 #endif
-		return rsm_load_state_32(ctxt, buf);
+		return rsm_load_state_32(ctxt, smram.bytes);
 }
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 2200b8aa727398..4cbb95796dcd63 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4436,12 +4436,14 @@ static int svm_smi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 	return 1;
 }
 
-static int svm_enter_smm(struct kvm_vcpu *vcpu, char *smstate)
+static int svm_enter_smm(struct kvm_vcpu *vcpu, union kvm_smram *smram)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct kvm_host_map map_save;
 	int ret;
 
+	char *smstate = (char *)smram;
+
 	if (!is_guest_mode(vcpu))
 		return 0;
 
@@ -4483,7 +4485,7 @@ static int svm_enter_smm(struct kvm_vcpu *vcpu, char *smstate)
 	return 0;
 }
 
-static int svm_leave_smm(struct kvm_vcpu *vcpu, const char *smstate)
+static int svm_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct kvm_host_map map, map_save;
@@ -4491,6 +4493,8 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, const char *smstate)
 	struct vmcb *vmcb12;
 	int ret;
 
+	const char *smstate = (const char *)smram;
+
 	if (!guest_cpuid_has(vcpu, X86_FEATURE_LM))
 		return 0;
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 107fc035c91b80..8c7890af11fb21 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7914,7 +7914,7 @@ static int vmx_smi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 	return !is_smm(vcpu);
 }
 
-static int vmx_enter_smm(struct kvm_vcpu *vcpu, char *smstate)
+static int vmx_enter_smm(struct kvm_vcpu *vcpu, union kvm_smram *smram)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -7935,7 +7935,7 @@ static int vmx_enter_smm(struct kvm_vcpu *vcpu, char *smstate)
 	return 0;
 }
 
-static int vmx_leave_smm(struct kvm_vcpu *vcpu, const char *smstate)
+static int vmx_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	int ret;
-- 
2.34.3

