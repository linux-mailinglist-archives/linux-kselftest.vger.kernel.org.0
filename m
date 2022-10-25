Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDAC60CCB1
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 14:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJYMxE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 08:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbiJYMwC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 08:52:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B760A11C3F
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 05:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666702160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mCA4Do0tiMgEdMpQsmntRao/qg+7vUX+Fj7hqfX+/kI=;
        b=BlbbhpccLJfeHBPLLtu+5KMxCjwDF8nJyA+4KKIlFcWbjls656jtTDYo6RSc0yUieRnWeg
        Hoxz1hRKjdPWDMFt3R8YH2PKphkZAhhCTgTYCKWemS8u6DrSP6ct0a0l5xW7jxHuv3oFB6
        afr/Nee5kUMA2bBgsxe/cRjPXMp7PZk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-212-zqzZbjGpOrGulRdIimA3DQ-1; Tue, 25 Oct 2022 08:49:13 -0400
X-MC-Unique: zqzZbjGpOrGulRdIimA3DQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 600AD802527;
        Tue, 25 Oct 2022 12:49:12 +0000 (UTC)
Received: from amdlaptop.tlv.redhat.com (dhcp-4-238.tlv.redhat.com [10.35.4.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CE8640C6E13;
        Tue, 25 Oct 2022 12:49:08 +0000 (UTC)
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
Subject: [PATCH RESEND v4 22/23] KVM: x86: SVM: don't save SVM state to SMRAM when VM is not long mode capable
Date:   Tue, 25 Oct 2022 15:47:40 +0300
Message-Id: <20221025124741.228045-23-mlevitsk@redhat.com>
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

When the guest CPUID doesn't have support for long mode, 32 bit SMRAM
layout is used and it has no support for preserving EFER and/or SVM
state.

Note that this isn't relevant to running 32 bit guests on VM which is
long mode capable - such VM can still run 32 bit guests in compatibility
mode.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/svm/svm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 3004a5ff3fbf79..d22a809d923339 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4445,6 +4445,14 @@ static int svm_enter_smm(struct kvm_vcpu *vcpu, union kvm_smram *smram)
 	if (!is_guest_mode(vcpu))
 		return 0;
 
+	/*
+	 * 32-bit SMRAM format doesn't preserve EFER and SVM state.  Userspace is
+	 * responsible for ensuring nested SVM and SMIs are mutually exclusive.
+	 */
+
+	if (!guest_cpuid_has(vcpu, X86_FEATURE_LM))
+		return 1;
+
 	smram->smram64.svm_guest_flag = 1;
 	smram->smram64.svm_guest_vmcb_gpa = svm->nested.vmcb12_gpa;
 
-- 
2.34.3

