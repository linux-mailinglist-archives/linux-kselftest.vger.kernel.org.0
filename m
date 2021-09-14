Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A386340B3AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Sep 2021 17:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbhINPwD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Sep 2021 11:52:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27408 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235609AbhINPvj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Sep 2021 11:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631634622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kPW/xRZgG9ba7bqjddBqyr34NV20pn+mK9DAeId5oEY=;
        b=SfjBBmvIUlo/L4LY+xQrPobQEYT4lA14c42/7J59cSM4TFpV9qjvuKT7QRTZFrfDgQ26kK
        CrPHBzJZDCfDiFhEkBShee006wd3+GbEWYAP8hDDue+AhTTEbIeGsFFQOze7zU6WMdNXvp
        ZiecztwI8VZXW8ehCdSBEVtP7BIF5zA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-3pNPXvL6PwOmCdVoq0vR7Q-1; Tue, 14 Sep 2021 11:50:21 -0400
X-MC-Unique: 3pNPXvL6PwOmCdVoq0vR7Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05EE4802B9E;
        Tue, 14 Sep 2021 15:50:19 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D7F195C1BB;
        Tue, 14 Sep 2021 15:50:14 +0000 (UTC)
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
Subject: [PATCH 12/14] KVM: x86: SVM: add module param to control TSC scaling
Date:   Tue, 14 Sep 2021 18:48:23 +0300
Message-Id: <20210914154825.104886-13-mlevitsk@redhat.com>
In-Reply-To: <20210914154825.104886-1-mlevitsk@redhat.com>
References: <20210914154825.104886-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This allows to easily simulate a CPU without this feature.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/svm/svm.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 6504e40e0985..001a5af842ba 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -191,6 +191,9 @@ static int lbrv = true;
 module_param(lbrv, int, 0444);
 
 
+static int tsc_scaling = true;
+module_param(tsc_scaling, int, 0444);
+
 /*
  * enable / disable AVIC.  Because the defaults differ for APICv
  * support between VMX and SVM we cannot use module_param_named.
@@ -471,7 +474,7 @@ static int has_svm(void)
 static void svm_hardware_disable(void)
 {
 	/* Make sure we clean up behind us */
-	if (static_cpu_has(X86_FEATURE_TSCRATEMSR))
+	if (tsc_scaling)
 		wrmsrl(MSR_AMD64_TSC_RATIO, TSC_RATIO_DEFAULT);
 
 	cpu_svm_disable();
@@ -514,6 +517,10 @@ static int svm_hardware_enable(void)
 	wrmsrl(MSR_VM_HSAVE_PA, __sme_page_pa(sd->save_area));
 
 	if (static_cpu_has(X86_FEATURE_TSCRATEMSR)) {
+		/*
+		 * Set the default value, even if we don't use TSC scaling
+		 * to avoid having stale value in the msr
+		 */
 		wrmsrl(MSR_AMD64_TSC_RATIO, TSC_RATIO_DEFAULT);
 		__this_cpu_write(current_tsc_ratio, TSC_RATIO_DEFAULT);
 	}
@@ -1063,10 +1070,15 @@ static __init int svm_hardware_setup(void)
 	if (boot_cpu_has(X86_FEATURE_FXSR_OPT))
 		kvm_enable_efer_bits(EFER_FFXSR);
 
-	if (boot_cpu_has(X86_FEATURE_TSCRATEMSR)) {
-		kvm_has_tsc_control = true;
-		kvm_max_tsc_scaling_ratio = TSC_RATIO_MAX;
-		kvm_tsc_scaling_ratio_frac_bits = 32;
+	if (tsc_scaling) {
+		if (!boot_cpu_has(X86_FEATURE_TSCRATEMSR)) {
+			tsc_scaling = false;
+		} else {
+			pr_info("TSC scaling supported\n");
+			kvm_has_tsc_control = true;
+			kvm_max_tsc_scaling_ratio = TSC_RATIO_MAX;
+			kvm_tsc_scaling_ratio_frac_bits = 32;
+		}
 	}
 
 	tsc_aux_uret_slot = kvm_add_user_return_msr(MSR_TSC_AUX);
@@ -1543,7 +1555,7 @@ static void svm_prepare_guest_switch(struct kvm_vcpu *vcpu)
 		vmsave(__sme_page_pa(sd->save_area));
 	}
 
-	if (static_cpu_has(X86_FEATURE_TSCRATEMSR)) {
+	if (tsc_scaling) {
 		u64 tsc_ratio = vcpu->arch.tsc_scaling_ratio;
 		if (tsc_ratio != __this_cpu_read(current_tsc_ratio)) {
 			__this_cpu_write(current_tsc_ratio, tsc_ratio);
-- 
2.26.3

