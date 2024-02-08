Return-Path: <linux-kselftest+bounces-4369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A082284E9EA
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 21:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5B61F21D52
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 20:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E4950250;
	Thu,  8 Feb 2024 20:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jIvq4bvj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58E34C3BC
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Feb 2024 20:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707425348; cv=none; b=QRcGkRng8yq1h50KAidC3am0UsuF9rb2pd+JVh67KJQkVxbRMHmgfKNgqNnE5oExqK/IU6TI5WgrmXABQFi7XMZwKuxCgAuDbqKsb5lUEBEsRSqSaB89uYiIbQ4a+92HP/IR6Db/BwGIwYqXjylu0XXnZUoUxg7VWraN/tctfJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707425348; c=relaxed/simple;
	bh=tPFXPzxyf6op+Bg5sbQch6VHxDcoO0i2B3MkrzRcVYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mg4DmlrmUAlYCOVAANrGfKfeoiIicl9n/IiQGv8HMapidqCR1+lgv/m3iXqPKN8U0x1nyJT7+x9Pf/nlS33OT53BbrOcGiTIEa5sTs72b/cHLtrMYgwik8XBInApjpb+6HZX/jFD2w2QQwByfRdygrhu/2lVWUz+KrtJOa7g/Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jIvq4bvj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707425345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rppn/T559sVXqiAKdha8Wnm2KRq5boNNLdCJxN0dtoM=;
	b=jIvq4bvjBagwzquR95iVAGfgU1Sm9OXADw15zZMjCtwiWVOCEFv2NMfhE/3eR8NHHmWhV0
	1ifqqVAomxV/eeckwgkItJnv00BjdRceip6B4N/gGst0Nn6cWKfkLoZFJ6sFfNh0IkbSGe
	K86juEcxGWtHNAxIZN0w9fDepaVQe7o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-aOtD-g0tO7SwaoAZdTDXIg-1; Thu, 08 Feb 2024 15:48:59 -0500
X-MC-Unique: aOtD-g0tO7SwaoAZdTDXIg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D73B85A597;
	Thu,  8 Feb 2024 20:48:58 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5BF8D1C10C0E;
	Thu,  8 Feb 2024 20:48:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v3 5/8] KVM: selftests: x86: Use TAP interface in the sync_regs test
Date: Thu,  8 Feb 2024 21:48:41 +0100
Message-ID: <20240208204844.119326-6-thuth@redhat.com>
In-Reply-To: <20240208204844.119326-1-thuth@redhat.com>
References: <20240208204844.119326-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

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
index 1cd19dfa0046c..67f78c0a58a51 100644
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
 
+KVM_ONE_VCPU_TEST_SUITE(sync_regs_test);
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
+KVM_ONE_VCPU_TEST(sync_regs_test, read_invalid, guest_code)
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
+KVM_ONE_VCPU_TEST(sync_regs_test, set_invalid, guest_code)
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
+KVM_ONE_VCPU_TEST(sync_regs_test, req_and_verify_all_valid, guest_code)
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
+KVM_ONE_VCPU_TEST(sync_regs_test, set_and_verify_various, guest_code)
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
+KVM_ONE_VCPU_TEST(sync_regs_test, clear_kvm_dirty_regs_bits, guest_code)
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
+KVM_ONE_VCPU_TEST(sync_regs_test, clear_kvm_valid_and_dirty_regs, guest_code)
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
+KVM_ONE_VCPU_TEST(sync_regs_test, clear_kvm_valid_regs_bits, guest_code)
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
+KVM_ONE_VCPU_TEST(sync_regs_test, race_cr4, guest_code)
+{
+	race_sync_regs(vcpu, race_sregs_cr4);
+}
+
+KVM_ONE_VCPU_TEST(sync_regs_test, race_exc, guest_code)
+{
+	race_sync_regs(vcpu, race_events_exc);
+}
 
-	kvm_vm_free(vm);
+KVM_ONE_VCPU_TEST(sync_regs_test, race_inj_pen, guest_code)
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
2.43.0


