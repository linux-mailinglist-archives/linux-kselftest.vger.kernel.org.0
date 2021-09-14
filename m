Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E260540B39A
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Sep 2021 17:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbhINPv3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Sep 2021 11:51:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52905 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235399AbhINPvK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Sep 2021 11:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631634592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=air76GPjqWicilRGvgmhrS4u3L0LPW0f6tGGztJqbug=;
        b=O3wcV//KqiermhWpuqMXTXbtB9yTwE+FwFKIvXuFhROK06acCGiFQrBzYUIHFvr954mFPt
        FbJ6dxdqKqLftcRikbVPMk8ROMuNrsbJiyzJNLvHpgMXZJGLaUsAvvnXpEKnAnE/DIboxm
        +yFOt+uaNHuxBWaEnBWfRR98zhIYxLY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-SOQOF10_Ps6-SVteknt1hg-1; Tue, 14 Sep 2021 11:49:49 -0400
X-MC-Unique: SOQOF10_Ps6-SVteknt1hg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92453CC62E;
        Tue, 14 Sep 2021 15:49:47 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A42C5C1BB;
        Tue, 14 Sep 2021 15:49:43 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Bandan Das <bsd@redhat.com>,
        linux-kernel@vger.kernel.org (open list),
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Wei Huang <wei.huang2@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        Maxim Levitsky <mlevitsk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Shuah Khan <shuah@kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>
Subject: [PATCH 08/14] KVM: x86: SVM: add module param to control LBR virtualization
Date:   Tue, 14 Sep 2021 18:48:19 +0300
Message-Id: <20210914154825.104886-9-mlevitsk@redhat.com>
In-Reply-To: <20210914154825.104886-1-mlevitsk@redhat.com>
References: <20210914154825.104886-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is useful for debug and also makes it consistent with
the rest of the SVM optional features.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/svm/svm.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index deeebd05f682..b08c5d826208 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -186,6 +186,11 @@ module_param(vls, int, 0444);
 static int vgif = true;
 module_param(vgif, int, 0444);
 
+/* enable/disable LBR virtualization */
+static int lbrv = true;
+module_param(lbrv, int, 0444);
+
+
 /*
  * enable / disable AVIC.  Because the defaults differ for APICv
  * support between VMX and SVM we cannot use module_param_named.
@@ -1059,6 +1064,13 @@ static __init int svm_hardware_setup(void)
 			pr_info("Virtual GIF supported\n");
 	}
 
+	if (lbrv) {
+		if (!boot_cpu_has(X86_FEATURE_LBRV))
+			lbrv = false;
+		else
+			pr_info("LBR virtualization supported\n");
+	}
+
 	svm_set_cpu_caps();
 
 	/*
@@ -2920,7 +2932,7 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		svm->tsc_aux = data;
 		break;
 	case MSR_IA32_DEBUGCTLMSR:
-		if (!boot_cpu_has(X86_FEATURE_LBRV)) {
+		if (!lbrv) {
 			vcpu_unimpl(vcpu, "%s: MSR_IA32_DEBUGCTL 0x%llx, nop\n",
 				    __func__, data);
 			break;
-- 
2.26.3

