Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B0A40B38F
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Sep 2021 17:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbhINPvD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Sep 2021 11:51:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49120 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235139AbhINPuv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Sep 2021 11:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631634573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gx7MKOlEUlgIaYAWawWmkyIY/NqMxsny76+oulEPAjA=;
        b=NzLELZiIRu3mT4hH5qczV/ascypxf4umL4oS1vzgMyhfLOsxcrwvY7fBVJSzJKOkC93eYw
        MtNTxJRYX32WW0ac4RqGT0NAUucZqCWSVtX13pS7YcF0U0m3sNjiwvfJdsP8q6KKx+uZuJ
        HAX89k8CyNZYArZJ9Tn+jz9G8me+dH4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-8OI8-DSbNCSsPRlXLJq6Xw-1; Tue, 14 Sep 2021 11:49:29 -0400
X-MC-Unique: 8OI8-DSbNCSsPRlXLJq6Xw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8161CC624;
        Tue, 14 Sep 2021 15:49:27 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 286D75C1BB;
        Tue, 14 Sep 2021 15:49:21 +0000 (UTC)
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
Subject: [PATCH 06/14] KVM: x86: SVM: don't set VMLOAD/VMSAVE intercepts on vCPU reset
Date:   Tue, 14 Sep 2021 18:48:17 +0300
Message-Id: <20210914154825.104886-7-mlevitsk@redhat.com>
In-Reply-To: <20210914154825.104886-1-mlevitsk@redhat.com>
References: <20210914154825.104886-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

commit adc2a23734ac ("KVM: nSVM: improve SYSENTER emulation on AMD"),
made init_vmcb set vmload/vmsave intercepts unconditionally,
and relied on svm_vcpu_after_set_cpuid to clear them when possible.

However init_vmcb is also called when the vCPU is reset, and it is
not followed by another call to svm_vcpu_after_set_cpuid because
the CPUID is already set.

This mistake makes the VMSAVE/VMLOAD intercept to be set when
it is not needed, and harms performance of the nested guest.

Fixes: adc2a23734ac ("KVM: nSVM: improve SYSENTER emulation on AMD")

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/svm/svm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 6645542df9bd..861ac9f74331 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1199,8 +1199,6 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
 	svm_set_intercept(svm, INTERCEPT_SHUTDOWN);
 	svm_set_intercept(svm, INTERCEPT_VMRUN);
 	svm_set_intercept(svm, INTERCEPT_VMMCALL);
-	svm_set_intercept(svm, INTERCEPT_VMLOAD);
-	svm_set_intercept(svm, INTERCEPT_VMSAVE);
 	svm_set_intercept(svm, INTERCEPT_STGI);
 	svm_set_intercept(svm, INTERCEPT_CLGI);
 	svm_set_intercept(svm, INTERCEPT_SKINIT);
@@ -1377,6 +1375,10 @@ static int svm_create_vcpu(struct kvm_vcpu *vcpu)
 	svm->guest_state_loaded = false;
 
 	svm_switch_vmcb(svm, &svm->vmcb01);
+
+	svm_set_intercept(svm, INTERCEPT_VMLOAD);
+	svm_set_intercept(svm, INTERCEPT_VMSAVE);
+
 	init_vmcb(vcpu);
 
 	svm_vcpu_init_msrpm(vcpu, svm->msrpm);
-- 
2.26.3

