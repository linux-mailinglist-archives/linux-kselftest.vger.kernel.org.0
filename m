Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6438860CC35
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 14:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbiJYMnq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 08:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiJYMnD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 08:43:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734F718F0DD
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 05:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666701780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6RVePXqf+ZlRyOqE0ZPUurd+WAhhvI1fNgkZgVZLz8k=;
        b=Y6sRESp3SIwIMFjneiD1zIs39NmQ1MA2kViKxwJyzVol0DiT6DRYgKJwmTR/RxBuRADd5v
        P2PJqsCAddoVXC+7cRSIcXpTDfsieeXdeMy3rDD5gqYu+go1CLcND/TmzRmBrEVSpjLPwT
        6ZMtK3mX40KpCM8YoBBEEkLlxqnTzyY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-269-B1p8k4cYNAKpgU26vx41bQ-1; Tue, 25 Oct 2022 08:42:54 -0400
X-MC-Unique: B1p8k4cYNAKpgU26vx41bQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E63480253F;
        Tue, 25 Oct 2022 12:42:53 +0000 (UTC)
Received: from amdlaptop.tlv.redhat.com (dhcp-4-238.tlv.redhat.com [10.35.4.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 225CD20290A2;
        Tue, 25 Oct 2022 12:42:49 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Yang Zhong <yang.zhong@intel.com>,
        linux-kselftest@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        Guang Zeng <guang.zeng@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        Wei Wang <wei.w.wang@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH v4 07/23] KVM: x86: remove SMRAM address space if SMM is not supported
Date:   Tue, 25 Oct 2022 15:42:07 +0300
Message-Id: <20221025124223.227577-8-mlevitsk@redhat.com>
In-Reply-To: <20221025124223.227577-1-mlevitsk@redhat.com>
References: <20221025124223.227577-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

If CONFIG_KVM_SMM is not defined HF_SMM_MASK will always be zero, and
we can spare userspace the hassle of setting up the SMRAM address space
simply by reporting that only one address space is supported.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 541ed36cbb82f8..28e41926027e7a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1995,11 +1995,14 @@ enum {
 #define HF_SMM_MASK		(1 << 6)
 #define HF_SMM_INSIDE_NMI_MASK	(1 << 7)
 
-#define __KVM_VCPU_MULTIPLE_ADDRESS_SPACE
-#define KVM_ADDRESS_SPACE_NUM 2
-
-#define kvm_arch_vcpu_memslots_id(vcpu) ((vcpu)->arch.hflags & HF_SMM_MASK ? 1 : 0)
-#define kvm_memslots_for_spte_role(kvm, role) __kvm_memslots(kvm, (role).smm)
+#ifdef CONFIG_KVM_SMM
+# define __KVM_VCPU_MULTIPLE_ADDRESS_SPACE
+# define KVM_ADDRESS_SPACE_NUM 2
+# define kvm_arch_vcpu_memslots_id(vcpu) ((vcpu)->arch.hflags & HF_SMM_MASK ? 1 : 0)
+# define kvm_memslots_for_spte_role(kvm, role) __kvm_memslots(kvm, (role).smm)
+#else
+# define kvm_memslots_for_spte_role(kvm, role) __kvm_memslots(kvm, 0)
+#endif
 
 #define KVM_ARCH_WANT_MMU_NOTIFIER
 
-- 
2.34.3

