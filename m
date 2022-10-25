Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DD260CC9A
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 14:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbiJYMwZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 08:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbiJYMvl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 08:51:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457C1196ED1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 05:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666702133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M1g7fz6KB/sbYm3Ds1BFDi+lUou8XyaUx6Re1h9B+aQ=;
        b=US9o1xRoEx4mk3s6D0QLSEeMGdrXv6IAVQ9MLytTICdT1NBFWU8+un/l/zhZNzOjrkShxH
        pJlHFvCzG2r4r4bc8THkUs2z4lEKWp2WC7DZ/ipy8BV9WiEXQWKKw3WoqINOsaE5DrDfXy
        I5PsD6Ha7/O7y/IzVpsbvZLwbGITJfg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-S61zWHIoNvWu-M5yG3Z1vQ-1; Tue, 25 Oct 2022 08:48:48 -0400
X-MC-Unique: S61zWHIoNvWu-M5yG3Z1vQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F04F0101E148;
        Tue, 25 Oct 2022 12:48:46 +0000 (UTC)
Received: from amdlaptop.tlv.redhat.com (dhcp-4-238.tlv.redhat.com [10.35.4.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E23C40C6EC6;
        Tue, 25 Oct 2022 12:48:43 +0000 (UTC)
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
Subject: [PATCH RESEND v4 15/23] KVM: x86: smm: check for failures on smm entry
Date:   Tue, 25 Oct 2022 15:47:33 +0300
Message-Id: <20221025124741.228045-16-mlevitsk@redhat.com>
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

In the rare case of the failure on SMM entry, the KVM should at
least terminate the VM instead of going south.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/smm.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
index b290ad14070f72..1191a79cf027e5 100644
--- a/arch/x86/kvm/smm.c
+++ b/arch/x86/kvm/smm.c
@@ -211,11 +211,17 @@ void enter_smm(struct kvm_vcpu *vcpu)
 	 * Give enter_smm() a chance to make ISA-specific changes to the vCPU
 	 * state (e.g. leave guest mode) after we've saved the state into the
 	 * SMM state-save area.
+	 *
+	 * Kill the VM in the unlikely case of failure, because the VM
+	 * can be in undefined state in this case.
 	 */
-	static_call(kvm_x86_enter_smm)(vcpu, buf);
+	if (static_call(kvm_x86_enter_smm)(vcpu, buf))
+		goto error;
 
 	kvm_smm_changed(vcpu, true);
-	kvm_vcpu_write_guest(vcpu, vcpu->arch.smbase + 0xfe00, buf, sizeof(buf));
+
+	if (kvm_vcpu_write_guest(vcpu, vcpu->arch.smbase + 0xfe00, buf, sizeof(buf)))
+		goto error;
 
 	if (static_call(kvm_x86_get_nmi_mask)(vcpu))
 		vcpu->arch.hflags |= HF_SMM_INSIDE_NMI_MASK;
@@ -235,7 +241,8 @@ void enter_smm(struct kvm_vcpu *vcpu)
 	dt.address = dt.size = 0;
 	static_call(kvm_x86_set_idt)(vcpu, &dt);
 
-	kvm_set_dr(vcpu, 7, DR7_FIXED_1);
+	if (WARN_ON_ONCE(kvm_set_dr(vcpu, 7, DR7_FIXED_1)))
+		goto error;
 
 	cs.selector = (vcpu->arch.smbase >> 4) & 0xffff;
 	cs.base = vcpu->arch.smbase;
@@ -264,11 +271,15 @@ void enter_smm(struct kvm_vcpu *vcpu)
 
 #ifdef CONFIG_X86_64
 	if (guest_cpuid_has(vcpu, X86_FEATURE_LM))
-		static_call(kvm_x86_set_efer)(vcpu, 0);
+		if (static_call(kvm_x86_set_efer)(vcpu, 0))
+			goto error;
 #endif
 
 	kvm_update_cpuid_runtime(vcpu);
 	kvm_mmu_reset_context(vcpu);
+	return;
+error:
+	kvm_vm_dead(vcpu->kvm);
 }
 
 static void rsm_set_desc_flags(struct kvm_segment *desc, u32 flags)
-- 
2.34.3

