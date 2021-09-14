Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB2440B3B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Sep 2021 17:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbhINPwV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Sep 2021 11:52:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45895 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235185AbhINPvx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Sep 2021 11:51:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631634635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9yPLnpJJhUzUT/VjQu5gJbVtoZO+FQcj2iSexaO76k4=;
        b=TWm3nnDUAGYSDzaMyK9Ay+rvwmilaJPgwh4hzYIvMfgvSY33Gf9QCm6NG7JSjU4vfRmHaa
        XwxjWoQjFpsvKnFeLTtxibdgiDac9n2ly5DG2HCUiy5PGnJoC+yWqDiGYz7kWtVvz42cwv
        BfVBd6KrdKBmnDODlF2mgiiLHdymMvw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312--kk8KmQkNAqTxbQ_dKpbGw-1; Tue, 14 Sep 2021 11:50:33 -0400
X-MC-Unique: -kk8KmQkNAqTxbQ_dKpbGw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00C28CC624;
        Tue, 14 Sep 2021 15:50:32 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E99025C1D1;
        Tue, 14 Sep 2021 15:50:23 +0000 (UTC)
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
Subject: [PATCH 14/14] KVM: x86: nSVM: support PAUSE filter threshold and count
Date:   Tue, 14 Sep 2021 18:48:25 +0300
Message-Id: <20210914154825.104886-15-mlevitsk@redhat.com>
In-Reply-To: <20210914154825.104886-1-mlevitsk@redhat.com>
References: <20210914154825.104886-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Allow L1 to use these settings if L0 disables PAUSE interception
(AKA cpu_pm=on)

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/svm/nested.c |  6 ++++++
 arch/x86/kvm/svm/svm.c    | 18 ++++++++++++++++++
 arch/x86/kvm/svm/svm.h    |  2 ++
 3 files changed, 26 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 4c26417f36b8..b47c745ec659 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -602,6 +602,12 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	if (!nested_vmcb_needs_vls_intercept(svm))
 		svm->vmcb->control.virt_ext |= VIRTUAL_VMLOAD_VMSAVE_ENABLE_MASK;
 
+	if (svm->pause_filter_enabled)
+		svm->vmcb->control.pause_filter_count = svm->nested.ctl.pause_filter_count;
+
+	if (svm->pause_threshold_enabled)
+		svm->vmcb->control.pause_filter_thresh = svm->nested.ctl.pause_filter_thresh;
+
 	nested_svm_transition_tlb_flush(vcpu);
 
 	/* Enter Guest-Mode */
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 0b797351cfb9..95125cd2e666 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1026,6 +1026,13 @@ static __init void svm_set_cpu_caps(void)
 		if (tsc_scaling)
 			kvm_cpu_cap_set(X86_FEATURE_TSCRATEMSR);
 
+		if (pause_filter_count)
+			kvm_cpu_cap_set(X86_FEATURE_PAUSEFILTER);
+
+		if (pause_filter_thresh)
+			kvm_cpu_cap_set(X86_FEATURE_PFTHRESHOLD);
+
+
 		/* Nested VM can receive #VMEXIT instead of triggering #GP */
 		kvm_cpu_cap_set(X86_FEATURE_SVME_ADDR_CHK);
 	}
@@ -4133,6 +4140,17 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 
 	svm->tsc_scaling_enabled = tsc_scaling && guest_cpuid_has(vcpu, X86_FEATURE_TSCRATEMSR);
 
+	if (kvm_pause_in_guest(vcpu->kvm)) {
+		svm->pause_filter_enabled = pause_filter_count > 0 &&
+					    guest_cpuid_has(vcpu, X86_FEATURE_PAUSEFILTER);
+
+		svm->pause_threshold_enabled = pause_filter_thresh > 0 &&
+					    guest_cpuid_has(vcpu, X86_FEATURE_PFTHRESHOLD);
+	} else {
+		svm->pause_filter_enabled = false;
+		svm->pause_threshold_enabled = false;
+	}
+
 	svm_recalc_instruction_intercepts(vcpu, svm);
 
 	/* For sev guests, the memory encryption bit is not reserved in CR3.  */
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index c8ea3b14da73..7e679dd7a6e4 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -166,6 +166,8 @@ struct vcpu_svm {
 	bool lbrv_enabled                 : 1;
 	bool v_vmload_vmsave_enabled      : 1;
 	bool tsc_scaling_enabled          : 1;
+	bool pause_filter_enabled         : 1;
+	bool pause_threshold_enabled      : 1;
 
 	u32 ldr_reg;
 	u32 dfr_reg;
-- 
2.26.3

