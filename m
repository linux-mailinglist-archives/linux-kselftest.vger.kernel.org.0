Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDD5662688
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jan 2023 14:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234796AbjAINJ1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Jan 2023 08:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbjAINJF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Jan 2023 08:09:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD7CE9F
        for <linux-kselftest@vger.kernel.org>; Mon,  9 Jan 2023 05:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673269574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=luPXsS+ks9CN356IQwEOn1IqYG8Q1VUr1O3bLDCB5Co=;
        b=D1XEZSzTf0JChpNGXGgt5Q4d5r4Niv5EXligY8MqILNCIku2v4jHgUPEc81cL3HC4+Bv/1
        jMhWAM6RWyFf8yXjF0cciQLHthZvqazSezNIekua7r73FDKAKxkOY2AB6xeuUZryGUitCI
        9vXUi+beLeUDItVMbjiJlYTTasVvdFY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-2oUJb9aVOYKsK2CZI1NtXQ-1; Mon, 09 Jan 2023 08:06:10 -0500
X-MC-Unique: 2oUJb9aVOYKsK2CZI1NtXQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88BFB80D0EB;
        Mon,  9 Jan 2023 13:06:09 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24BF9175AD;
        Mon,  9 Jan 2023 13:06:09 +0000 (UTC)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        Gautam Menghani <gautammenghani201@gmail.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Zeng Guang <guang.zeng@intel.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 1/2] KVM: x86: update APIC_ID also when disabling x2APIC in kvm_lapic_set_base
Date:   Mon,  9 Jan 2023 08:06:04 -0500
Message-Id: <20230109130605.2013555-2-eesposit@redhat.com>
In-Reply-To: <20230109130605.2013555-1-eesposit@redhat.com>
References: <20230109130605.2013555-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If KVM_SET_MSR firstly enables and then disables x2APIC, make sure
APIC_ID is actually updated correctly, since bits and offset differ from
xAPIC and x2APIC.

Currently this is not handled correctly, as kvm_set_apic_base() will
have msr_info->host_initiated, so switching from x2APIC to xAPIC won't
fail, but kvm_lapic_set_base() does not handle the case.

Fixes: 8d860bbeedef ("kvm: vmx: Basic APIC virtualization controls have three settings")
Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 arch/x86/kvm/lapic.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 4efdb4a4d72c..df0a50099aa2 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2394,8 +2394,12 @@ void kvm_lapic_set_base(struct kvm_vcpu *vcpu, u64 value)
 		}
 	}
 
-	if (((old_value ^ value) & X2APIC_ENABLE) && (value & X2APIC_ENABLE))
-		kvm_apic_set_x2apic_id(apic, vcpu->vcpu_id);
+	if ((old_value ^ value) & X2APIC_ENABLE) {
+		if (value & X2APIC_ENABLE)
+			kvm_apic_set_x2apic_id(apic, vcpu->vcpu_id);
+		else
+			kvm_apic_set_xapic_id(apic, vcpu->vcpu_id);
+	}
 
 	if ((old_value ^ value) & (MSR_IA32_APICBASE_ENABLE | X2APIC_ENABLE)) {
 		kvm_vcpu_update_apicv(vcpu);
-- 
2.31.1

