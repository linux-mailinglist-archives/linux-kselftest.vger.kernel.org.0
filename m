Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECB57BA1D2
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Oct 2023 17:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjJEO7i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Oct 2023 10:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjJEO6M (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Oct 2023 10:58:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2536A26FDC
        for <linux-kselftest@vger.kernel.org>; Thu,  5 Oct 2023 07:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696516733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ftZTUSszjDaBYMwepJocwkUW/juZNz/Q5LGCufgOFs=;
        b=HzngTryzNNCpz1HdXYSBxQ7fAtf3avill/6kwVSbeqGvrrn1lQP1O8QiZ8DFvvs60ifQr6
        OYcZR3NEazDZ5ylgMWBv5Gx6Vtv8LN0T+A8M0KGc43ELtW82375ZHSME703/4WeI6UYS5r
        FcjFmf6JKD+QtWOesEjjVl/IbjcCgks=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-HpW_D5Y1Peequ5SsnYIDUA-1; Thu, 05 Oct 2023 10:38:50 -0400
X-MC-Unique: HpW_D5Y1Peequ5SsnYIDUA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C216981D795;
        Thu,  5 Oct 2023 14:38:49 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8DC9340C6EA8;
        Thu,  5 Oct 2023 14:38:48 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 5/7] KVM: selftests: x86: Use TAP interface in the fix_hypercall test
Date:   Thu,  5 Oct 2023 16:38:37 +0200
Message-ID: <20231005143839.365297-6-thuth@redhat.com>
In-Reply-To: <20231005143839.365297-1-thuth@redhat.com>
References: <20231005143839.365297-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use the kvm_test_harness.h interface in this test to get TAP
output, so that it is easier for the user to see what the test
is doing.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .../selftests/kvm/x86_64/fix_hypercall_test.c | 27 ++++++++++++-------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c b/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
index 0f728f05ea82f..59c389aff3961 100644
--- a/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
+++ b/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
@@ -9,6 +9,7 @@
 #include <linux/stringify.h>
 #include <stdint.h>
 
+#include "kvm_test_harness.h"
 #include "apic.h"
 #include "test_util.h"
 #include "kvm_util.h"
@@ -83,6 +84,8 @@ static void guest_main(void)
 	GUEST_DONE();
 }
 
+KVM_ONE_VCPU_TEST_SUITE(fix_hypercall, guest_main);
+
 static void enter_guest(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
@@ -103,14 +106,11 @@ static void enter_guest(struct kvm_vcpu *vcpu)
 	}
 }
 
-static void test_fix_hypercall(bool disable_quirk)
+static void test_fix_hypercall(struct kvm_vcpu *vcpu, bool disable_quirk)
 {
-	struct kvm_vcpu *vcpu;
-	struct kvm_vm *vm;
-
-	vm = vm_create_with_one_vcpu(&vcpu, guest_main);
+	struct kvm_vm *vm = vcpu->vm;
 
-	vm_init_descriptor_tables(vcpu->vm);
+	vm_init_descriptor_tables(vm);
 	vcpu_init_descriptor_tables(vcpu);
 	vm_install_exception_handler(vcpu->vm, UD_VECTOR, guest_ud_handler);
 
@@ -126,10 +126,19 @@ static void test_fix_hypercall(bool disable_quirk)
 	enter_guest(vcpu);
 }
 
-int main(void)
+KVM_ONE_VCPU_TEST(fix_hypercall, enable_quirk)
+{
+	test_fix_hypercall(vcpu, false);
+}
+
+KVM_ONE_VCPU_TEST(fix_hypercall, disable_quirk)
+{
+	test_fix_hypercall(vcpu, true);
+}
+
+int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_DISABLE_QUIRKS2) & KVM_X86_QUIRK_FIX_HYPERCALL_INSN);
 
-	test_fix_hypercall(false);
-	test_fix_hypercall(true);
+	return test_harness_run(argc, argv);
 }
-- 
2.41.0

