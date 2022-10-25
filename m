Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C2060CC5A
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 14:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbiJYMqa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 08:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiJYMpx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 08:45:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530D218F93C
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 05:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666701850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M1g7fz6KB/sbYm3Ds1BFDi+lUou8XyaUx6Re1h9B+aQ=;
        b=K4d6qNBweDUX+Gv6JQxtc4oGJYYGcsw98ObCzdCDdbISGEklKZL8B8eJ0jg+zLzI6/gywF
        Rb4SB8aokBwaxASvVEPbSx+ok/ROBiwSvColm0HhOTzdKbGa83fdGX0gYu2dtzk3dK/YSk
        sZHz1biO+XkJe+jOslEU49p+QHn1J+g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-kV2X2ZD4M1uhtNn3-gxnJA-1; Tue, 25 Oct 2022 08:44:06 -0400
X-MC-Unique: kV2X2ZD4M1uhtNn3-gxnJA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6BB8185651D;
        Tue, 25 Oct 2022 12:43:41 +0000 (UTC)
Received: from amdlaptop.tlv.redhat.com (dhcp-4-238.tlv.redhat.com [10.35.4.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D9D7200BBD2;
        Tue, 25 Oct 2022 12:43:32 +0000 (UTC)
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
Subject: [PATCH v4 15/23] KVM: x86: smm: check for failures on smm entry
Date:   Tue, 25 Oct 2022 15:42:15 +0300
Message-Id: <20221025124223.227577-16-mlevitsk@redhat.com>
In-Reply-To: <20221025124223.227577-1-mlevitsk@redhat.com>
References: <20221025124223.227577-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

