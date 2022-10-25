Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A588760CC3B
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 14:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJYMoT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 08:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbiJYMnm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 08:43:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BB218F90E
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Oct 2022 05:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666701786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k7eb+GFGOU5S7G9TNA6e1VQ8CjmkOXIwTqSDjDKPGFk=;
        b=A2Kg4V4BRKo7fmYR0YBUMfNWVN0f3MUAVkk87ywaOtuziTDU4Yq0M/3mThVmRzGGtP0dVJ
        7IFsgUwlFVDskG/zUFTHh0c19K7F6EUlvdlqXC+cT4CS0gcC3TwjmCq12DE2UbSf77mnhG
        FvDIQ9Hs+SGM+cvI8xV7CQM5LW7/Anw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-78-DlvJ23uJPcKZC5YGkQPVRA-1; Tue, 25 Oct 2022 08:43:02 -0400
X-MC-Unique: DlvJ23uJPcKZC5YGkQPVRA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF74C80252F;
        Tue, 25 Oct 2022 12:43:00 +0000 (UTC)
Received: from amdlaptop.tlv.redhat.com (dhcp-4-238.tlv.redhat.com [10.35.4.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6DA2D2028E98;
        Tue, 25 Oct 2022 12:42:57 +0000 (UTC)
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
Subject: [PATCH v4 09/23] bug: introduce ASSERT_STRUCT_OFFSET
Date:   Tue, 25 Oct 2022 15:42:09 +0300
Message-Id: <20221025124223.227577-10-mlevitsk@redhat.com>
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

ASSERT_STRUCT_OFFSET allows to assert during the build of
the kernel that a field in a struct have an expected offset.

KVM used to have such macro, but there is almost nothing KVM specific
in it so move it to build_bug.h, so that it can be used in other
places in KVM.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/vmx/vmcs12.h | 5 ++---
 include/linux/build_bug.h | 9 +++++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmcs12.h b/arch/x86/kvm/vmx/vmcs12.h
index 746129ddd5ae02..01936013428b5c 100644
--- a/arch/x86/kvm/vmx/vmcs12.h
+++ b/arch/x86/kvm/vmx/vmcs12.h
@@ -208,9 +208,8 @@ struct __packed vmcs12 {
 /*
  * For save/restore compatibility, the vmcs12 field offsets must not change.
  */
-#define CHECK_OFFSET(field, loc)				\
-	BUILD_BUG_ON_MSG(offsetof(struct vmcs12, field) != (loc),	\
-		"Offset of " #field " in struct vmcs12 has changed.")
+#define CHECK_OFFSET(field, loc) \
+	ASSERT_STRUCT_OFFSET(struct vmcs12, field, loc)
 
 static inline void vmx_check_vmcs12_offsets(void)
 {
diff --git a/include/linux/build_bug.h b/include/linux/build_bug.h
index e3a0be2c90ad98..3aa3640f8c181f 100644
--- a/include/linux/build_bug.h
+++ b/include/linux/build_bug.h
@@ -77,4 +77,13 @@
 #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
 #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
 
+
+/*
+ * Compile time check that field has an expected offset
+ */
+#define ASSERT_STRUCT_OFFSET(type, field, expected_offset)	\
+	BUILD_BUG_ON_MSG(offsetof(type, field) != (expected_offset),	\
+		"Offset of " #field " in " #type " has changed.")
+
+
 #endif	/* _LINUX_BUILD_BUG_H */
-- 
2.34.3

