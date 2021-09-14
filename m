Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7D440B38A
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Sep 2021 17:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbhINPuw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Sep 2021 11:50:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31173 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235191AbhINPum (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Sep 2021 11:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631634564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BIMzmTmiJfFMVSajy+y6/ZiL6DW6ca8ffVuSGDu5ZjE=;
        b=BaCyVJNZK1Pg/d4ge6a9KkAA1mSogHfg/OxB1S/28YVX02CoLjoW1UGLw+0QFb8EoIMHqI
        5b4IrkncEcXk9jEVUf8YujDyMTIV3JhKEiaaHGh0fGJAi8kjYa5WI/Os0roaip34gNP1or
        3iWuttHjDMGyahbUhEEzOq+D5vo0GNU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-HgYqKWbQPmWGcVRqPuhrbA-1; Tue, 14 Sep 2021 11:49:23 -0400
X-MC-Unique: HgYqKWbQPmWGcVRqPuhrbA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDC4E1084684;
        Tue, 14 Sep 2021 15:49:21 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C08B25C261;
        Tue, 14 Sep 2021 15:49:03 +0000 (UTC)
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
Subject: [PATCH 05/14] KVM: x86: nSVM: don't copy virt_ext from vmcb12
Date:   Tue, 14 Sep 2021 18:48:16 +0300
Message-Id: <20210914154825.104886-6-mlevitsk@redhat.com>
In-Reply-To: <20210914154825.104886-1-mlevitsk@redhat.com>
References: <20210914154825.104886-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These field correspond to features that we don't expose yet to L2

While currently there are no CVE worthy features in this field,
if AMD adds more features to this field, that could allow guest
escapes similar to CVE-2021-3653 and CVE-2021-3656.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 476e01f98035..4df59d9795b6 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -545,7 +545,6 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 		(svm->nested.ctl.int_ctl & int_ctl_vmcb12_bits) |
 		(svm->vmcb01.ptr->control.int_ctl & int_ctl_vmcb01_bits);
 
-	svm->vmcb->control.virt_ext            = svm->nested.ctl.virt_ext;
 	svm->vmcb->control.int_vector          = svm->nested.ctl.int_vector;
 	svm->vmcb->control.int_state           = svm->nested.ctl.int_state;
 	svm->vmcb->control.event_inj           = svm->nested.ctl.event_inj;
-- 
2.26.3

