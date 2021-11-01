Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7E8441C1F
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Nov 2021 15:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhKAOGh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Nov 2021 10:06:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53429 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232117AbhKAOGh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Nov 2021 10:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635775443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vm64mHgL0IQZZWUDPZzx7p+0Aoc/gsuLe6I2UPyCNOE=;
        b=RmyiTDcDcpIfEa4o2ivSzWKUxRIRjOEh54aDr2R/pqHGP78C6Jw7cgFXTdbgSp5ceAxUiR
        xtPRPbQlZGqcbdrN5il/xH7c3pViWSL3htEPqjN50xfqYKlVRxEPI0cOaBYUxz5WWeTOvx
        AVZdnjEgDNyKJ++QQZ6Tu0PN4apiiNM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-OCzKz-RDNWiFTymbmVmppQ-1; Mon, 01 Nov 2021 10:04:00 -0400
X-MC-Unique: OCzKz-RDNWiFTymbmVmppQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE06981CBDB;
        Mon,  1 Nov 2021 14:03:57 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E386101E59B;
        Mon,  1 Nov 2021 14:03:53 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        Borislav Petkov <bp@alien8.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT)), Joerg Roedel <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Bandan Das <bsd@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Wei Huang <wei.huang2@amd.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v2 1/6] KVM: x86: SVM: add module param to control LBR virtualization
Date:   Mon,  1 Nov 2021 16:03:19 +0200
Message-Id: <20211101140324.197921-2-mlevitsk@redhat.com>
In-Reply-To: <20211101140324.197921-1-mlevitsk@redhat.com>
References: <20211101140324.197921-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is useful for debug and also makes it consistent with
the rest of the SVM optional features.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/svm/svm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 21bb81710e0f6..2b5f8e10d686d 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -186,12 +186,13 @@ module_param(vls, int, 0444);
 static int vgif = true;
 module_param(vgif, int, 0444);
 
+static int tsc_scaling = true;
+module_param(tsc_scaling, int, 0444);
+
 /* enable/disable LBR virtualization */
 static int lbrv = true;
 module_param(lbrv, int, 0444);
 
-static int tsc_scaling = true;
-module_param(tsc_scaling, int, 0444);
 
 /*
  * enable / disable AVIC.  Because the defaults differ for APICv
-- 
2.26.3

