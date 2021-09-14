Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2EB440B398
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Sep 2021 17:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbhINPv1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Sep 2021 11:51:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37763 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235342AbhINPvF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Sep 2021 11:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631634588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=245jQK827gv9pORp/HoiEjyYDnHYg74f716xJlQFbt0=;
        b=M5W1dRzOU44Dt+7RjGOBdH9T9Wpfj1/7MXyXhHVTPdytUqrTB8UR3x+vpdYw2URiF73anF
        dZkoRNDfMBKJ7rJemBgywVSefnaqHZ5UD8AWQ8fLqxkXc3OKBfthqZPSopCy0vQotx3xhT
        fZE4GzndZ3N/1534Acu4PACS291UDAA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-4gGChjZqOIycN4nwhAkovg-1; Tue, 14 Sep 2021 11:49:44 -0400
X-MC-Unique: 4gGChjZqOIycN4nwhAkovg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE91F1084685;
        Tue, 14 Sep 2021 15:49:42 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 44B445C261;
        Tue, 14 Sep 2021 15:49:28 +0000 (UTC)
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
Subject: [PATCH 07/14] KVM: x86: SVM: add warning for CVE-2021-3656
Date:   Tue, 14 Sep 2021 18:48:18 +0300
Message-Id: <20210914154825.104886-8-mlevitsk@redhat.com>
In-Reply-To: <20210914154825.104886-1-mlevitsk@redhat.com>
References: <20210914154825.104886-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Just in case, add a warning ensuring that on guest entry,
either both VMLOAD and VMSAVE intercept is enabled or
vVMLOAD/VMSAVE is enabled.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/svm/svm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 861ac9f74331..deeebd05f682 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3784,6 +3784,12 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
 
 	WARN_ON_ONCE(kvm_apicv_activated(vcpu->kvm) != kvm_vcpu_apicv_active(vcpu));
 
+	/* Check that CVE-2021-3656 can't happen again */
+	if (!svm_is_intercept(svm, INTERCEPT_VMSAVE) ||
+	    !svm_is_intercept(svm, INTERCEPT_VMSAVE))
+		WARN_ON(!(svm->vmcb->control.virt_ext &
+			  VIRTUAL_VMLOAD_VMSAVE_ENABLE_MASK));
+
 	sync_lapic_to_cr8(vcpu);
 
 	if (unlikely(svm->asid != svm->vmcb->control.asid)) {
-- 
2.26.3

