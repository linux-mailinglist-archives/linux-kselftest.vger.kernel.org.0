Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DB575009D
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 10:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjGLIAg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 04:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjGLIAQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 04:00:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646441BC0
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jul 2023 00:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689148764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hgo9YuUU2jqiHTi7UEl9pw/Cu7nUbHUeFZMun2ueh0k=;
        b=dCTXQAHVKTAN8vKrOZsRFuYWkOcUF7Dz0fj3apxzeQMNksAJEH/kFiOcaVMyfQgTUE4oQQ
        R6TPVIAWEm9aryHcmOy6hZu8D/7CY589aX+MNOq1P00DpWk6Ek9MVBoQYEsuvsOo9P2qY7
        eUoSnEZTfCxzJYC3QVyTv1BFGguJu4I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-178-7NJDwfmRMBCQ48jNY0ihQQ-1; Wed, 12 Jul 2023 03:59:19 -0400
X-MC-Unique: 7NJDwfmRMBCQ48jNY0ihQQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4E8358EBBA6;
        Wed, 12 Jul 2023 07:59:19 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA7B4492C13;
        Wed, 12 Jul 2023 07:59:17 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     linux-kselftest@vger.kernel.org,
        David Matlack <dmatlack@google.com>
Subject: [PATCH 3/4] KVM: selftests: x86: Use TAP interface in the fix_hypercall test
Date:   Wed, 12 Jul 2023 09:59:09 +0200
Message-Id: <20230712075910.22480-4-thuth@redhat.com>
In-Reply-To: <20230712075910.22480-1-thuth@redhat.com>
References: <20230712075910.22480-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use the kselftest_harness.h interface in this test to get TAP
output, so that it is easier for the user to see what the test
is doing.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .../selftests/kvm/x86_64/fix_hypercall_test.c    | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c b/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
index 0f728f05ea82f..7621942a072ec 100644
--- a/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
+++ b/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
@@ -9,6 +9,7 @@
 #include <linux/stringify.h>
 #include <stdint.h>
 
+#include "kselftest_harness.h"
 #include "apic.h"
 #include "test_util.h"
 #include "kvm_util.h"
@@ -126,10 +127,19 @@ static void test_fix_hypercall(bool disable_quirk)
 	enter_guest(vcpu);
 }
 
-int main(void)
+TEST(fix_hypercall)
 {
-	TEST_REQUIRE(kvm_check_cap(KVM_CAP_DISABLE_QUIRKS2) & KVM_X86_QUIRK_FIX_HYPERCALL_INSN);
-
 	test_fix_hypercall(false);
+}
+
+TEST(fix_hypercall_disable_quirk)
+{
 	test_fix_hypercall(true);
 }
+
+int main(int argc, char *argv[])
+{
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_DISABLE_QUIRKS2) & KVM_X86_QUIRK_FIX_HYPERCALL_INSN);
+
+	return test_harness_run(argc, argv);
+}
-- 
2.39.3

