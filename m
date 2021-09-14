Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841C640B37E
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Sep 2021 17:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbhINPu2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Sep 2021 11:50:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28807 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235062AbhINPuZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Sep 2021 11:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631634546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rh6Yn54FVBR9BdmMO2Rm3QRiud0k4fZkr3BdtFwKDlc=;
        b=ejcfe683i4x/Flg56vy3sfsF+ZpRwTHblyxb4iNk1OzRIQEUblHM0OquQ6SkK22CYGsJbc
        8c9k9Z7aRPD77TH62hJWRqVFOo1fWVlBOnhyicOZ5aAEYDXR3WfhTZg7FlJAvBb8WCOG23
        QkZUydJQTjkTsZEwlCtBVLZ28/HD8Io=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-5ZQYaQuiNDGbdA5ibHidqg-1; Tue, 14 Sep 2021 11:49:05 -0400
X-MC-Unique: 5ZQYaQuiNDGbdA5ibHidqg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FFBF802936;
        Tue, 14 Sep 2021 15:49:03 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11C0D5C1BB;
        Tue, 14 Sep 2021 15:48:55 +0000 (UTC)
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
Subject: [PATCH 04/14] KVM: x86: nSVM: don't copy pause related settings
Date:   Tue, 14 Sep 2021 18:48:15 +0300
Message-Id: <20210914154825.104886-5-mlevitsk@redhat.com>
In-Reply-To: <20210914154825.104886-1-mlevitsk@redhat.com>
References: <20210914154825.104886-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

According to the SDM, the CPU never modifies these settings.
It loads them on VM entry and updates an internal copy instead.

Also don't load them from the vmcb12 as we don't expose these
features to the nested guest yet.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 2545d0c61985..476e01f98035 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -551,9 +551,6 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	svm->vmcb->control.event_inj           = svm->nested.ctl.event_inj;
 	svm->vmcb->control.event_inj_err       = svm->nested.ctl.event_inj_err;
 
-	svm->vmcb->control.pause_filter_count  = svm->nested.ctl.pause_filter_count;
-	svm->vmcb->control.pause_filter_thresh = svm->nested.ctl.pause_filter_thresh;
-
 	nested_svm_transition_tlb_flush(vcpu);
 
 	/* Enter Guest-Mode */
@@ -808,11 +805,6 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 	vmcb12->control.event_inj         = svm->nested.ctl.event_inj;
 	vmcb12->control.event_inj_err     = svm->nested.ctl.event_inj_err;
 
-	vmcb12->control.pause_filter_count =
-		svm->vmcb->control.pause_filter_count;
-	vmcb12->control.pause_filter_thresh =
-		svm->vmcb->control.pause_filter_thresh;
-
 	nested_svm_copy_common_state(svm->nested.vmcb02.ptr, svm->vmcb01.ptr);
 
 	svm_switch_vmcb(svm, &svm->vmcb01);
-- 
2.26.3

