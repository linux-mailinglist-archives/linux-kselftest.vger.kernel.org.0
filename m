Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3F475009B
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 10:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjGLIAd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 04:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjGLIAO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 04:00:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D579E199E
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jul 2023 00:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689148761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mKok55NQXTBLtHIZMbzGllTUQixFBx5xs4F6rwMNPAg=;
        b=Y5O0keqdVXFUUy63RPkIrDWs96PYfUFXs2gN/K5QTUjJl5ieOyM4NYw22/lUswH/KIKTJI
        h8I/ypTy5Nzrd0ZEu9jNwUrnplIHQpNwKG9kUv6uiYxqwxTBz8a3M/TyIU0oIGFVJqpgnf
        /dFST+3N5saGKvfFrRyca7Fze9tdMm0=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-nlLPEfVMMKuYfMHIWyplrw-1; Wed, 12 Jul 2023 03:59:17 -0400
X-MC-Unique: nlLPEfVMMKuYfMHIWyplrw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D2601C07259;
        Wed, 12 Jul 2023 07:59:17 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31E74492C13;
        Wed, 12 Jul 2023 07:59:15 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     linux-kselftest@vger.kernel.org,
        David Matlack <dmatlack@google.com>
Subject: [PATCH 2/4] KVM: selftests: x86: Use TAP interface in the sync_regs test
Date:   Wed, 12 Jul 2023 09:59:08 +0200
Message-Id: <20230712075910.22480-3-thuth@redhat.com>
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

The sync_regs test currently does not have any output (unless one
of the TEST_ASSERT statement fails), so it's hard to say for a user
whether a certain new sub-test has been included in the binary or
not. Let's make this a little bit more user-friendly and include
some TAP output via the kselftest_harness.h interface.
To be able to use the interface, we have to break up the huge main()
function here in more fine grained parts - then we can use the
TEST_F() macro to define the individual tests. Since these are run
with a separate VM now, we have also to make sure to create the
expected state at the beginning of each test, so some parts grow
a little bit - which should be OK considering that the individual
tests are more self-contained now.

Suggested-by: David Matlack <dmatlack@google.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .../selftests/kvm/x86_64/sync_regs_test.c     | 113 +++++++++++++++---
 1 file changed, 98 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/sync_regs_test.c b/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
index 2da89fdc2471a..e1359a4a07fea 100644
--- a/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/sync_regs_test.c
@@ -16,6 +16,7 @@
 #include <string.h>
 #include <sys/ioctl.h>
 
+#include "kselftest_harness.h"
 #include "test_util.h"
 #include "kvm_util.h"
 #include "processor.h"
@@ -80,23 +81,24 @@ static void compare_vcpu_events(struct kvm_vcpu_events *left,
 #define TEST_SYNC_FIELDS   (KVM_SYNC_X86_REGS|KVM_SYNC_X86_SREGS|KVM_SYNC_X86_EVENTS)
 #define INVALID_SYNC_FIELD 0x80000000
 
-int main(int argc, char *argv[])
-{
-	struct kvm_vcpu *vcpu;
+FIXTURE(sync_regs_test) {
 	struct kvm_vm *vm;
-	struct kvm_run *run;
-	struct kvm_regs regs;
-	struct kvm_sregs sregs;
-	struct kvm_vcpu_events events;
-	int rv, cap;
+	struct kvm_vcpu *vcpu;
+};
 
-	cap = kvm_check_cap(KVM_CAP_SYNC_REGS);
-	TEST_REQUIRE((cap & TEST_SYNC_FIELDS) == TEST_SYNC_FIELDS);
-	TEST_REQUIRE(!(cap & INVALID_SYNC_FIELD));
+FIXTURE_SETUP(sync_regs_test) {
+	self->vm = vm_create_with_one_vcpu(&self->vcpu, guest_code);
+}
 
-	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+FIXTURE_TEARDOWN(sync_regs_test) {
+	kvm_vm_free(self->vm);
+}
 
-	run = vcpu->run;
+TEST_F(sync_regs_test, read_invalid)
+{
+	struct kvm_vcpu *vcpu = self->vcpu;
+	struct kvm_run *run = vcpu->run;
+	int rv;
 
 	/* Request reading invalid register set from VCPU. */
 	run->kvm_valid_regs = INVALID_SYNC_FIELD;
@@ -112,6 +114,13 @@ int main(int argc, char *argv[])
 		    "Invalid kvm_valid_regs did not cause expected KVM_RUN error: %d\n",
 		    rv);
 	run->kvm_valid_regs = 0;
+}
+
+TEST_F(sync_regs_test, set_invalid)
+{
+	struct kvm_vcpu *vcpu = self->vcpu;
+	struct kvm_run *run = vcpu->run;
+	int rv;
 
 	/* Request setting invalid register set into VCPU. */
 	run->kvm_dirty_regs = INVALID_SYNC_FIELD;
@@ -127,11 +136,22 @@ int main(int argc, char *argv[])
 		    "Invalid kvm_dirty_regs did not cause expected KVM_RUN error: %d\n",
 		    rv);
 	run->kvm_dirty_regs = 0;
+}
+
+TEST_F(sync_regs_test, req_and_verify_all_valid)
+{
+	struct kvm_vcpu *vcpu = self->vcpu;
+	struct kvm_run *run = vcpu->run;
+	struct kvm_vcpu_events events;
+	struct kvm_sregs sregs;
+	struct kvm_regs regs;
+	int rv;
 
 	/* Request and verify all valid register sets. */
 	/* TODO: BUILD TIME CHECK: TEST_ASSERT(KVM_SYNC_X86_NUM_FIELDS != 3); */
 	run->kvm_valid_regs = TEST_SYNC_FIELDS;
 	rv = _vcpu_run(vcpu);
+	TEST_ASSERT(rv == 0, "vcpu_run failed: %d\n", rv);
 	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
 
 	vcpu_regs_get(vcpu, &regs);
@@ -142,6 +162,22 @@ int main(int argc, char *argv[])
 
 	vcpu_events_get(vcpu, &events);
 	compare_vcpu_events(&events, &run->s.regs.events);
+}
+
+TEST_F(sync_regs_test, set_and_verify_various)
+{
+	struct kvm_vcpu *vcpu = self->vcpu;
+	struct kvm_run *run = vcpu->run;
+	struct kvm_vcpu_events events;
+	struct kvm_sregs sregs;
+	struct kvm_regs regs;
+	int rv;
+
+	/* Run once to get register set */
+	run->kvm_valid_regs = TEST_SYNC_FIELDS;
+	rv = _vcpu_run(vcpu);
+	TEST_ASSERT(rv == 0, "vcpu_run failed: %d\n", rv);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
 
 	/* Set and verify various register values. */
 	run->s.regs.regs.rbx = 0xBAD1DEA;
@@ -151,6 +187,7 @@ int main(int argc, char *argv[])
 	run->kvm_valid_regs = TEST_SYNC_FIELDS;
 	run->kvm_dirty_regs = KVM_SYNC_X86_REGS | KVM_SYNC_X86_SREGS;
 	rv = _vcpu_run(vcpu);
+	TEST_ASSERT(rv == 0, "vcpu_run failed: %d\n", rv);
 	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
 	TEST_ASSERT(run->s.regs.regs.rbx == 0xBAD1DEA + 1,
 		    "rbx sync regs value incorrect 0x%llx.",
@@ -167,6 +204,13 @@ int main(int argc, char *argv[])
 
 	vcpu_events_get(vcpu, &events);
 	compare_vcpu_events(&events, &run->s.regs.events);
+}
+
+TEST_F(sync_regs_test, clear_kvm_dirty_regs_bits)
+{
+	struct kvm_vcpu *vcpu = self->vcpu;
+	struct kvm_run *run = vcpu->run;
+	int rv;
 
 	/* Clear kvm_dirty_regs bits, verify new s.regs values are
 	 * overwritten with existing guest values.
@@ -175,10 +219,25 @@ int main(int argc, char *argv[])
 	run->kvm_dirty_regs = 0;
 	run->s.regs.regs.rbx = 0xDEADBEEF;
 	rv = _vcpu_run(vcpu);
+	TEST_ASSERT(rv == 0, "vcpu_run failed: %d\n", rv);
 	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
 	TEST_ASSERT(run->s.regs.regs.rbx != 0xDEADBEEF,
 		    "rbx sync regs value incorrect 0x%llx.",
 		    run->s.regs.regs.rbx);
+}
+
+TEST_F(sync_regs_test, clear_kvm_valid_and_dirty_regs)
+{
+	struct kvm_vcpu *vcpu = self->vcpu;
+	struct kvm_run *run = vcpu->run;
+	struct kvm_regs regs;
+	int rv;
+
+	/* Run once to get register set */
+	run->kvm_valid_regs = TEST_SYNC_FIELDS;
+	rv = _vcpu_run(vcpu);
+	TEST_ASSERT(rv == 0, "vcpu_run failed: %d\n", rv);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
 
 	/* Clear kvm_valid_regs bits and kvm_dirty_bits.
 	 * Verify s.regs values are not overwritten with existing guest values
@@ -187,9 +246,11 @@ int main(int argc, char *argv[])
 	run->kvm_valid_regs = 0;
 	run->kvm_dirty_regs = 0;
 	run->s.regs.regs.rbx = 0xAAAA;
+	vcpu_regs_get(vcpu, &regs);
 	regs.rbx = 0xBAC0;
 	vcpu_regs_set(vcpu, &regs);
 	rv = _vcpu_run(vcpu);
+	TEST_ASSERT(rv == 0, "vcpu_run failed: %d\n", rv);
 	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
 	TEST_ASSERT(run->s.regs.regs.rbx == 0xAAAA,
 		    "rbx sync regs value incorrect 0x%llx.",
@@ -198,6 +259,20 @@ int main(int argc, char *argv[])
 	TEST_ASSERT(regs.rbx == 0xBAC0 + 1,
 		    "rbx guest value incorrect 0x%llx.",
 		    regs.rbx);
+}
+
+TEST_F(sync_regs_test, clear_kvm_valid_regs_bits)
+{
+	struct kvm_vcpu *vcpu = self->vcpu;
+	struct kvm_run *run = vcpu->run;
+	struct kvm_regs regs;
+	int rv;
+
+	/* Run once to get register set */
+	run->kvm_valid_regs = TEST_SYNC_FIELDS;
+	rv = _vcpu_run(vcpu);
+	TEST_ASSERT(rv == 0, "vcpu_run failed: %d\n", rv);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
 
 	/* Clear kvm_valid_regs bits. Verify s.regs values are not overwritten
 	 * with existing guest values but that guest values are overwritten
@@ -207,6 +282,7 @@ int main(int argc, char *argv[])
 	run->kvm_dirty_regs = TEST_SYNC_FIELDS;
 	run->s.regs.regs.rbx = 0xBBBB;
 	rv = _vcpu_run(vcpu);
+	TEST_ASSERT(rv == 0, "vcpu_run failed: %d\n", rv);
 	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
 	TEST_ASSERT(run->s.regs.regs.rbx == 0xBBBB,
 		    "rbx sync regs value incorrect 0x%llx.",
@@ -215,8 +291,15 @@ int main(int argc, char *argv[])
 	TEST_ASSERT(regs.rbx == 0xBBBB + 1,
 		    "rbx guest value incorrect 0x%llx.",
 		    regs.rbx);
+}
+
+int main(int argc, char *argv[])
+{
+	int cap;
 
-	kvm_vm_free(vm);
+	cap = kvm_check_cap(KVM_CAP_SYNC_REGS);
+	TEST_REQUIRE((cap & TEST_SYNC_FIELDS) == TEST_SYNC_FIELDS);
+	TEST_REQUIRE(!(cap & INVALID_SYNC_FIELD));
 
-	return 0;
+	return test_harness_run(argc, argv);
 }
-- 
2.39.3

