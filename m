Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD1460CCB4
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 14:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbiJYMxF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 08:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbiJYMwC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 08:52:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA682F38C
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 05:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666702153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6XIV1duGsHRLFQBOC75+bp4A+Ap8BBETzdKM8HqPsZ0=;
        b=HF+GjjhqyXKn3N4Ec68aooUz7XiLZnyIOQyuodUsDLfZkqIu7FEN0lWJvRElA+qRJoph4U
        RqoW/XbSE/L+kw0QseU7rpYQqrDT8mEvNhDVplL89M9DpdeTCNEOOsIcTL8GhEpqU+zlhH
        ebf/l89p+5YKg7Vpnarl9XvDkswrOh4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-292-pJm1eYbyNWKwJi37SakTWw-1; Tue, 25 Oct 2022 08:49:09 -0400
X-MC-Unique: pJm1eYbyNWKwJi37SakTWw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BADEC38164C5;
        Tue, 25 Oct 2022 12:49:08 +0000 (UTC)
Received: from amdlaptop.tlv.redhat.com (dhcp-4-238.tlv.redhat.com [10.35.4.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6528840C6EC6;
        Tue, 25 Oct 2022 12:49:05 +0000 (UTC)
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
Subject: [PATCH RESEND v4 21/23] KVM: x86: SVM: use smram structs
Date:   Tue, 25 Oct 2022 15:47:39 +0300
Message-Id: <20221025124741.228045-22-mlevitsk@redhat.com>
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

Use SMM structs in the SVM code as well, which removes the last user of
put_smstate/GET_SMSTATE so remove these macros as well.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/smm.h     |  6 ------
 arch/x86/kvm/svm/svm.c | 21 +++++++--------------
 2 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/smm.h b/arch/x86/kvm/smm.h
index bf5c7ffeb11efc..8d96bff3f4d54f 100644
--- a/arch/x86/kvm/smm.h
+++ b/arch/x86/kvm/smm.h
@@ -4,12 +4,6 @@
 
 #include <linux/build_bug.h>
 
-#define GET_SMSTATE(type, buf, offset)		\
-	(*(type *)((buf) + (offset) - 0x7e00))
-
-#define PUT_SMSTATE(type, buf, offset, val)                      \
-	*(type *)((buf) + (offset) - 0x7e00) = val
-
 #ifdef CONFIG_KVM_SMM
 
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index b49e3f5c921c99..3004a5ff3fbf79 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4442,15 +4442,11 @@ static int svm_enter_smm(struct kvm_vcpu *vcpu, union kvm_smram *smram)
 	struct kvm_host_map map_save;
 	int ret;
 
-	char *smstate = (char *)smram;
-
 	if (!is_guest_mode(vcpu))
 		return 0;
 
-	/* FED8h - SVM Guest */
-	PUT_SMSTATE(u64, smstate, 0x7ed8, 1);
-	/* FEE0h - SVM Guest VMCB Physical Address */
-	PUT_SMSTATE(u64, smstate, 0x7ee0, svm->nested.vmcb12_gpa);
+	smram->smram64.svm_guest_flag = 1;
+	smram->smram64.svm_guest_vmcb_gpa = svm->nested.vmcb12_gpa;
 
 	svm->vmcb->save.rax = vcpu->arch.regs[VCPU_REGS_RAX];
 	svm->vmcb->save.rsp = vcpu->arch.regs[VCPU_REGS_RSP];
@@ -4488,28 +4484,25 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct kvm_host_map map, map_save;
-	u64 saved_efer, vmcb12_gpa;
 	struct vmcb *vmcb12;
 	int ret;
 
-	const char *smstate = (const char *)smram;
+	const struct kvm_smram_state_64 *smram64 = &smram->smram64;
 
 	if (!guest_cpuid_has(vcpu, X86_FEATURE_LM))
 		return 0;
 
 	/* Non-zero if SMI arrived while vCPU was in guest mode. */
-	if (!GET_SMSTATE(u64, smstate, 0x7ed8))
+	if (!smram64->svm_guest_flag)
 		return 0;
 
 	if (!guest_cpuid_has(vcpu, X86_FEATURE_SVM))
 		return 1;
 
-	saved_efer = GET_SMSTATE(u64, smstate, 0x7ed0);
-	if (!(saved_efer & EFER_SVME))
+	if (!(smram64->efer & EFER_SVME))
 		return 1;
 
-	vmcb12_gpa = GET_SMSTATE(u64, smstate, 0x7ee0);
-	if (kvm_vcpu_map(vcpu, gpa_to_gfn(vmcb12_gpa), &map))
+	if (kvm_vcpu_map(vcpu, gpa_to_gfn(smram64->svm_guest_vmcb_gpa), &map))
 		return 1;
 
 	ret = 1;
@@ -4535,7 +4528,7 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 	vmcb12 = map.hva;
 	nested_copy_vmcb_control_to_cache(svm, &vmcb12->control);
 	nested_copy_vmcb_save_to_cache(svm, &vmcb12->save);
-	ret = enter_svm_guest_mode(vcpu, vmcb12_gpa, vmcb12, false);
+	ret = enter_svm_guest_mode(vcpu, smram64->svm_guest_vmcb_gpa, vmcb12, false);
 
 	if (ret)
 		goto unmap_save;
-- 
2.34.3

