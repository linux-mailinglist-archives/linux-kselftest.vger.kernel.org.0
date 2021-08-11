Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5503E9152
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Aug 2021 14:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhHKMch (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Aug 2021 08:32:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38060 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229685AbhHKMcW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Aug 2021 08:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628685118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B3KINp9sJXHMx11mNGO2VKuCz+lk1/b/SrY8FybMbTQ=;
        b=ZZQ93Bi2ZCqoKcurQhFFgFrICvN1CtKMVjXj+NT7SRkOIoLmB6ji1hu3E41fJZPgbssBiD
        kQfpVAffogC7MrWox6M4XLSen3FjC/Cf8/fBxiygIFXRbeQuoeQlu+tCJ9fFGToWerQk4o
        pYDA5+BwA7b+IJgQgBxo+8GdB3AaBTE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-fwJw_Al-OcqEIO14FfxxRQ-1; Wed, 11 Aug 2021 08:29:44 -0400
X-MC-Unique: fwJw_Al-OcqEIO14FfxxRQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E7F6192D788;
        Wed, 11 Aug 2021 12:29:42 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4CDF45D9C6;
        Wed, 11 Aug 2021 12:29:35 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Andrew Jones <drjones@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Johannes Berg <johannes.berg@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jessica Yu <jeyu@kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Yang Weijiang <weijiang.yang@intel.com>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 1/6] KVM: SVM: split svm_handle_invalid_exit
Date:   Wed, 11 Aug 2021 15:29:22 +0300
Message-Id: <20210811122927.900604-2-mlevitsk@redhat.com>
In-Reply-To: <20210811122927.900604-1-mlevitsk@redhat.com>
References: <20210811122927.900604-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Split the check for having a vmexit handler to svm_check_exit_valid,
and make svm_handle_invalid_exit only handle a vmexit that is
already not valid.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/svm/svm.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 7b58e445a967..e45259177009 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3236,12 +3236,14 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
 	       "excp_to:", save->last_excp_to);
 }
 
-static int svm_handle_invalid_exit(struct kvm_vcpu *vcpu, u64 exit_code)
+static bool svm_check_exit_valid(struct kvm_vcpu *vcpu, u64 exit_code)
 {
-	if (exit_code < ARRAY_SIZE(svm_exit_handlers) &&
-	    svm_exit_handlers[exit_code])
-		return 0;
+	return (exit_code < ARRAY_SIZE(svm_exit_handlers) &&
+		svm_exit_handlers[exit_code]);
+}
 
+static int svm_handle_invalid_exit(struct kvm_vcpu *vcpu, u64 exit_code)
+{
 	vcpu_unimpl(vcpu, "svm: unexpected exit reason 0x%llx\n", exit_code);
 	dump_vmcb(vcpu);
 	vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
@@ -3249,14 +3251,13 @@ static int svm_handle_invalid_exit(struct kvm_vcpu *vcpu, u64 exit_code)
 	vcpu->run->internal.ndata = 2;
 	vcpu->run->internal.data[0] = exit_code;
 	vcpu->run->internal.data[1] = vcpu->arch.last_vmentry_cpu;
-
-	return -EINVAL;
+	return 0;
 }
 
 int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u64 exit_code)
 {
-	if (svm_handle_invalid_exit(vcpu, exit_code))
-		return 0;
+	if (!svm_check_exit_valid(vcpu, exit_code))
+		return svm_handle_invalid_exit(vcpu, exit_code);
 
 #ifdef CONFIG_RETPOLINE
 	if (exit_code == SVM_EXIT_MSR)
-- 
2.26.3

