Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A1D60CC36
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 14:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbiJYMnt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 08:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbiJYMnS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 08:43:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F7318F0EE
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 05:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666701782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zVCaW6lEEBFNmdMv7F/qs/utrwfJnH2v1kJUVNJMX6M=;
        b=F0AsWdTkf+OmP1yVhTsj+2jAB3wu1gQsdTQEAKW0osesmhTKRXTWMD4wEn4d37ktW+QI+z
        K0MluIyvT3pHTM8goi2L8+zXmQIFTyZ6c7e9JvR0jH33SED9LpJARYvZ07GPUQ9GSWwvR/
        L415ftoHOheYzSLvWxAMmK9SVTSwTSU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-262-3KknvcArPDSo5DbzuUs2LQ-1; Tue, 25 Oct 2022 08:42:58 -0400
X-MC-Unique: 3KknvcArPDSo5DbzuUs2LQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 260C43833287;
        Tue, 25 Oct 2022 12:42:57 +0000 (UTC)
Received: from amdlaptop.tlv.redhat.com (dhcp-4-238.tlv.redhat.com [10.35.4.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4FEF2017DF0;
        Tue, 25 Oct 2022 12:42:53 +0000 (UTC)
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
Subject: [PATCH v4 08/23] KVM: x86: do not define KVM_REQ_SMI if SMM disabled
Date:   Tue, 25 Oct 2022 15:42:08 +0300
Message-Id: <20221025124223.227577-9-mlevitsk@redhat.com>
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

From: Paolo Bonzini <pbonzini@redhat.com>

This ensures that all the relevant code is compiled out, in fact
the process_smi stub can be removed too.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 2 ++
 arch/x86/kvm/smm.h              | 1 -
 arch/x86/kvm/x86.c              | 6 ++++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 28e41926027e7a..0b0a82c0bb5cbd 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -81,7 +81,9 @@
 #define KVM_REQ_NMI			KVM_ARCH_REQ(9)
 #define KVM_REQ_PMU			KVM_ARCH_REQ(10)
 #define KVM_REQ_PMI			KVM_ARCH_REQ(11)
+#ifdef CONFIG_KVM_SMM
 #define KVM_REQ_SMI			KVM_ARCH_REQ(12)
+#endif
 #define KVM_REQ_MASTERCLOCK_UPDATE	KVM_ARCH_REQ(13)
 #define KVM_REQ_MCLOCK_INPROGRESS \
 	KVM_ARCH_REQ_FLAGS(14, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
diff --git a/arch/x86/kvm/smm.h b/arch/x86/kvm/smm.h
index 7ccce6b655cacf..a6795b93ba3002 100644
--- a/arch/x86/kvm/smm.h
+++ b/arch/x86/kvm/smm.h
@@ -28,7 +28,6 @@ void process_smi(struct kvm_vcpu *vcpu);
 static inline int kvm_inject_smi(struct kvm_vcpu *vcpu) { return -ENOTTY; }
 static inline bool is_smm(struct kvm_vcpu *vcpu) { return false; }
 static inline void kvm_smm_changed(struct kvm_vcpu *vcpu, bool in_smm) { WARN_ON_ONCE(1); }
-static inline void process_smi(struct kvm_vcpu *vcpu) { WARN_ON_ONCE(1); }
 
 /*
  * emulator_leave_smm is used as a function pointer, so the
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8394cd62c2854c..56004890a71742 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5033,8 +5033,10 @@ static void kvm_vcpu_ioctl_x86_get_vcpu_events(struct kvm_vcpu *vcpu,
 
 	process_nmi(vcpu);
 
+#ifdef CONFIG_KVM_SMM
 	if (kvm_check_request(KVM_REQ_SMI, vcpu))
 		process_smi(vcpu);
+#endif
 
 	/*
 	 * KVM's ABI only allows for one exception to be migrated.  Luckily,
@@ -10207,8 +10209,10 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		}
 		if (kvm_check_request(KVM_REQ_STEAL_UPDATE, vcpu))
 			record_steal_time(vcpu);
+#ifdef CONFIG_KVM_SMM
 		if (kvm_check_request(KVM_REQ_SMI, vcpu))
 			process_smi(vcpu);
+#endif
 		if (kvm_check_request(KVM_REQ_NMI, vcpu))
 			process_nmi(vcpu);
 		if (kvm_check_request(KVM_REQ_PMU, vcpu))
@@ -12565,7 +12569,9 @@ bool kvm_arch_dy_runnable(struct kvm_vcpu *vcpu)
 		return true;
 
 	if (kvm_test_request(KVM_REQ_NMI, vcpu) ||
+#ifdef CONFIG_KVM_SMM
 		kvm_test_request(KVM_REQ_SMI, vcpu) ||
+#endif
 		 kvm_test_request(KVM_REQ_EVENT, vcpu))
 		return true;
 
-- 
2.34.3

