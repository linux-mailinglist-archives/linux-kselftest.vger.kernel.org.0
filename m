Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FDC7BA1D3
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Oct 2023 17:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjJEO7k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Oct 2023 10:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjJEO6E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Oct 2023 10:58:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E874510C8
        for <linux-kselftest@vger.kernel.org>; Thu,  5 Oct 2023 07:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696516731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iOPMQ+O8zkPvCQldrm25BT2cWKNHJa32wCRyAB9nIAI=;
        b=UqtMwfAiIP5lHWHgSUU5lahTtGIXMIsDgF6P3rOcDbeWCTlbhsRSXJbaM762fmx/w25uT9
        qeySf2j7EHMR+zKDMycyANPbmzONYlbbfSz94FJvnqUAJWLTNgKYhd3HLU0/lGOMfAKHFq
        /Fug5Xn0KVmCQilGtFRZuQOY8oEEb1Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-450-AwPrNZl6PJKwHq-xa8ZrlQ-1; Thu, 05 Oct 2023 10:38:48 -0400
X-MC-Unique: AwPrNZl6PJKwHq-xa8ZrlQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 464493C1E9D6;
        Thu,  5 Oct 2023 14:38:48 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1142A40C6EA8;
        Thu,  5 Oct 2023 14:38:46 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 4/7] KVM: selftests: x86: Use TAP interface in the sync_regs test
Date:   Thu,  5 Oct 2023 16:38:36 +0200
Message-ID: <20231005143839.365297-5-thuth@redhat.com>
In-Reply-To: <20231005143839.365297-1-thuth@redhat.com>
References: <20231005143839.365297-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The sync_regs test currently does not have any output (unless one
of the TEST_ASSERT statement fails), so it's hard to say for a user
whether a certain new sub-test has been included in the binary or
not. Let's make this a little bit more user-friendly and include
some TAP output via the kselftest_harness.h / kvm_test_harness.h
interface.
To be able to use the interface, we have to break up the huge main()
function here in more fine grained parts - then we can use the new
KVM_ONE_VCPU_TEST() macro to define the individual tests. Since these
are run with a separate VM now, we have also to make sure to create
the expected state at the beginning of each test, so some parts grow
a little bit - which should be OK considering that the individual
tests are more self-contained now.

Suggested-by: David Matlack <dmatlack@google.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .../selftests/kvm/x86_64/sync_regs_test.c     | 110 +++++++++++++-----
 1 file changed, 84 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/sync_regs_test.c b/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
index 1cd19dfa0046c..c857244762bb2 100644
--- a/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
@@ -17,6 +17,7 @@
 #include <sys/ioctl.h>
 #include <pthread.h>
 
+#include "kvm_test_harness.h"
 #include "test_util.h"
 #include "kvm_util.h"
 #include "processor.h"
@@ -41,6 +42,8 @@ void guest_code(void)
 		     : "rax", "rbx");
 }
 
+KVM_ONE_VCPU_TEST_SUITE(sync_regs_test, guest_code);
+
 static void compare_regs(struct kvm_regs *left, struct kvm_regs *right)
 {
 #define REG_COMPARE(reg) \
@@ -152,18 +155,15 @@ static noinline void *race_sregs_cr4(void *arg)
 	return NULL;
 }
 
-static void race_sync_regs(void *racer)
+static void race_sync_regs(struct kvm_vcpu *vcpu, void *racer)
 {
 	const time_t TIMEOUT = 2; /* seconds, roughly */
 	struct kvm_x86_state *state;
 	struct kvm_translation tr;
-	struct kvm_vcpu *vcpu;
 	struct kvm_run *run;
-	struct kvm_vm *vm;
 	pthread_t thread;
 	time_t t;
 
-	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 	run = vcpu->run;
 
 	run->kvm_valid_regs = KVM_SYNC_X86_SREGS;
@@ -205,26 +205,12 @@ static void race_sync_regs(void *racer)
 	TEST_ASSERT_EQ(pthread_join(thread, NULL), 0);
 
 	kvm_x86_state_cleanup(state);
-	kvm_vm_free(vm);
 }
 
-int main(int argc, char *argv[])
+KVM_ONE_VCPU_TEST(sync_regs_test, read_invalid)
 {
-	struct kvm_vcpu *vcpu;
-	struct kvm_vm *vm;
-	struct kvm_run *run;
-	struct kvm_regs regs;
-	struct kvm_sregs sregs;
-	struct kvm_vcpu_events events;
-	int rv, cap;
-
-	cap = kvm_check_cap(KVM_CAP_SYNC_REGS);
-	TEST_REQUIRE((cap & TEST_SYNC_FIELDS) == TEST_SYNC_FIELDS);
-	TEST_REQUIRE(!(cap & INVALID_SYNC_FIELD));
-
-	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
-
-	run = vcpu->run;
+	struct kvm_run *run = vcpu->run;
+	int rv;
 
 	/* Request reading invalid register set from VCPU. */
 	run->kvm_valid_regs = INVALID_SYNC_FIELD;
@@ -240,6 +226,12 @@ int main(int argc, char *argv[])
 		    "Invalid kvm_valid_regs did not cause expected KVM_RUN error: %d\n",
 		    rv);
 	run->kvm_valid_regs = 0;
+}
+
+KVM_ONE_VCPU_TEST(sync_regs_test, set_invalid)
+{
+	struct kvm_run *run = vcpu->run;
+	int rv;
 
 	/* Request setting invalid register set into VCPU. */
 	run->kvm_dirty_regs = INVALID_SYNC_FIELD;
@@ -255,6 +247,14 @@ int main(int argc, char *argv[])
 		    "Invalid kvm_dirty_regs did not cause expected KVM_RUN error: %d\n",
 		    rv);
 	run->kvm_dirty_regs = 0;
+}
+
+KVM_ONE_VCPU_TEST(sync_regs_test, req_and_verify_all_valid)
+{
+	struct kvm_run *run = vcpu->run;
+	struct kvm_vcpu_events events;
+	struct kvm_sregs sregs;
+	struct kvm_regs regs;
 
 	/* Request and verify all valid register sets. */
 	/* TODO: BUILD TIME CHECK: TEST_ASSERT(KVM_SYNC_X86_NUM_FIELDS != 3); */
@@ -270,6 +270,19 @@ int main(int argc, char *argv[])
 
 	vcpu_events_get(vcpu, &events);
 	compare_vcpu_events(&events, &run->s.regs.events);
+}
+
+KVM_ONE_VCPU_TEST(sync_regs_test, set_and_verify_various)
+{
+	struct kvm_run *run = vcpu->run;
+	struct kvm_vcpu_events events;
+	struct kvm_sregs sregs;
+	struct kvm_regs regs;
+
+	/* Run once to get register set */
+	run->kvm_valid_regs = TEST_SYNC_FIELDS;
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
 
 	/* Set and verify various register values. */
 	run->s.regs.regs.rbx = 0xBAD1DEA;
@@ -295,6 +308,11 @@ int main(int argc, char *argv[])
 
 	vcpu_events_get(vcpu, &events);
 	compare_vcpu_events(&events, &run->s.regs.events);
+}
+
+KVM_ONE_VCPU_TEST(sync_regs_test, clear_kvm_dirty_regs_bits)
+{
+	struct kvm_run *run = vcpu->run;
 
 	/* Clear kvm_dirty_regs bits, verify new s.regs values are
 	 * overwritten with existing guest values.
@@ -307,6 +325,17 @@ int main(int argc, char *argv[])
 	TEST_ASSERT(run->s.regs.regs.rbx != 0xDEADBEEF,
 		    "rbx sync regs value incorrect 0x%llx.",
 		    run->s.regs.regs.rbx);
+}
+
+KVM_ONE_VCPU_TEST(sync_regs_test, clear_kvm_valid_and_dirty_regs)
+{
+	struct kvm_run *run = vcpu->run;
+	struct kvm_regs regs;
+
+	/* Run once to get register set */
+	run->kvm_valid_regs = TEST_SYNC_FIELDS;
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
 
 	/* Clear kvm_valid_regs bits and kvm_dirty_bits.
 	 * Verify s.regs values are not overwritten with existing guest values
@@ -327,6 +356,17 @@ int main(int argc, char *argv[])
 	TEST_ASSERT(regs.rbx == 0xBAC0 + 1,
 		    "rbx guest value incorrect 0x%llx.",
 		    regs.rbx);
+}
+
+KVM_ONE_VCPU_TEST(sync_regs_test, clear_kvm_valid_regs_bits)
+{
+	struct kvm_run *run = vcpu->run;
+	struct kvm_regs regs;
+
+	/* Run once to get register set */
+	run->kvm_valid_regs = TEST_SYNC_FIELDS;
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
 
 	/* Clear kvm_valid_regs bits. Verify s.regs values are not overwritten
 	 * with existing guest values but that guest values are overwritten
@@ -344,12 +384,30 @@ int main(int argc, char *argv[])
 	TEST_ASSERT(regs.rbx == 0xBBBB + 1,
 		    "rbx guest value incorrect 0x%llx.",
 		    regs.rbx);
+}
+
+KVM_ONE_VCPU_TEST(sync_regs_test, race_cr4)
+{
+	race_sync_regs(vcpu, race_sregs_cr4);
+}
+
+KVM_ONE_VCPU_TEST(sync_regs_test, race_exc)
+{
+	race_sync_regs(vcpu, race_events_exc);
+}
 
-	kvm_vm_free(vm);
+KVM_ONE_VCPU_TEST(sync_regs_test, race_inj_pen)
+{
+	race_sync_regs(vcpu, race_events_inj_pen);
+}
+
+int main(int argc, char *argv[])
+{
+	int cap;
 
-	race_sync_regs(race_sregs_cr4);
-	race_sync_regs(race_events_exc);
-	race_sync_regs(race_events_inj_pen);
+	cap = kvm_check_cap(KVM_CAP_SYNC_REGS);
+	TEST_REQUIRE((cap & TEST_SYNC_FIELDS) == TEST_SYNC_FIELDS);
+	TEST_REQUIRE(!(cap & INVALID_SYNC_FIELD));
 
-	return 0;
+	return test_harness_run(argc, argv);
 }
-- 
2.41.0

