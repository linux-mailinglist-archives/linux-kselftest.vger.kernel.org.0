Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2249440B37B
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Sep 2021 17:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbhINPuU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Sep 2021 11:50:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26854 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234974AbhINPuR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Sep 2021 11:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631634538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sEWAwpmEEJaqmrX1gMRTQPBz4mPei3x4VtshFvs+Gd0=;
        b=jWTpM+sw6h7zH3ukLcZV6qNd+8yMWo8rDSxonh6KPFRghHi6WP+Gv+C2o8w9Wo7MKbqW2s
        ZfOb6O0x7JwxPOtYUGQmbSQQ7qGNN8iOkCEwW30j+NSVaEPNpZgvsdWpw/IpXJz2pdgWYg
        lwdQvpNXCM+GjXttxCH6rgJnzEYhWII=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-gjka4qD3PgW8zeIlo4Xz2Q-1; Tue, 14 Sep 2021 11:48:57 -0400
X-MC-Unique: gjka4qD3PgW8zeIlo4Xz2Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A569519253C2;
        Tue, 14 Sep 2021 15:48:55 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A65355C1BB;
        Tue, 14 Sep 2021 15:48:47 +0000 (UTC)
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
Subject: [PATCH 03/14] KVM: x86: nSVM: test eax for 4K alignment for GP errata workaround
Date:   Tue, 14 Sep 2021 18:48:14 +0300
Message-Id: <20210914154825.104886-4-mlevitsk@redhat.com>
In-Reply-To: <20210914154825.104886-1-mlevitsk@redhat.com>
References: <20210914154825.104886-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

GP SVM errata workaround made the #GP handler always emulate
the SVM instructions.

However these instructions #GP in case the operand is not 4K aligned,
but the workaround code didn't check this and we ended up
emulating these instructions anyway.

This is only an emulation accuracy check bug as there is no harm for
KVM to read/write unaligned vmcb images.

Fixes: 82a11e9c6fa2 ("KVM: SVM: Add emulation support for #GP triggered by SVM instructions")

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/svm/svm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index b2e710a3fff6..6645542df9bd 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2224,6 +2224,10 @@ static int gp_interception(struct kvm_vcpu *vcpu)
 	if (error_code)
 		goto reinject;
 
+	/* All SVM instructions expect page aligned RAX */
+	if (svm->vmcb->save.rax & ~PAGE_MASK)
+		goto reinject;
+
 	/* Decode the instruction for usage later */
 	if (x86_decode_emulated_instruction(vcpu, 0, NULL, 0) != EMULATION_OK)
 		goto reinject;
-- 
2.26.3

