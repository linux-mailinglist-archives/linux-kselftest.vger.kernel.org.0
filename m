Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B307050798B
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 21:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357423AbiDSTCB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 15:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357408AbiDSTCA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 15:02:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98D313EF3B
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 11:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650394755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ELtoXXeW9W3sa5L6e75RvzP3qWFgsuywLqkGXhoRaQo=;
        b=AJPPHGWHptsgoiBZiLGHevtevS25icKNAgNgF0NEntMsga16QTPE797eNUhMP2BZ9XRYS5
        OlulkFhO/4eLdvsZmxhGwtmp3t7uiizk7GWypOeHCGkaKvGnEzHzx6uVdE4Kv2Kg1BHYcj
        Eg1065YEELVpW1LhFWrxh0gPyWyUqu8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-bv87OnwtOPWLjqg6aY2pVA-1; Tue, 19 Apr 2022 14:59:12 -0400
X-MC-Unique: bv87OnwtOPWLjqg6aY2pVA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB37918E5341;
        Tue, 19 Apr 2022 18:59:11 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 396D057232E;
        Tue, 19 Apr 2022 18:59:07 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH v2 2/4] KVM: s390: selftests: Use TAP interface in the sync_regs test
Date:   Tue, 19 Apr 2022 20:58:55 +0200
Message-Id: <20220419185857.128351-3-thuth@redhat.com>
In-Reply-To: <20220419185857.128351-1-thuth@redhat.com>
References: <20220419185857.128351-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The sync_regs test currently does not have any output (unless one
of the TEST_ASSERT statement fails), so it's hard to say for a user
whether a certain new sub-test has been included in the binary or
not. Let's make this a little bit more user-friendly and include
some TAP output via the kselftests.h interface.
To be able to distinguish the different sub-tests more easily, we
also break up the huge main() function here in more fine grained
parts.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .../selftests/kvm/s390x/sync_regs_test.c      | 87 ++++++++++++++-----
 1 file changed, 66 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/sync_regs_test.c b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
index caf7b8859a94..c3719c92f4e8 100644
--- a/tools/testing/selftests/kvm/s390x/sync_regs_test.c
+++ b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
@@ -21,6 +21,7 @@
 #include "test_util.h"
 #include "kvm_util.h"
 #include "diag318_test_handler.h"
+#include "kselftest.h"
 
 #define VCPU_ID 5
 
@@ -74,27 +75,9 @@ static void compare_sregs(struct kvm_sregs *left, struct kvm_sync_regs *right)
 #define TEST_SYNC_FIELDS   (KVM_SYNC_GPRS|KVM_SYNC_ACRS|KVM_SYNC_CRS|KVM_SYNC_DIAG318)
 #define INVALID_SYNC_FIELD 0x80000000
 
-int main(int argc, char *argv[])
+void test_read_invalid(struct kvm_vm *vm, struct kvm_run *run)
 {
-	struct kvm_vm *vm;
-	struct kvm_run *run;
-	struct kvm_regs regs;
-	struct kvm_sregs sregs;
-	int rv, cap;
-
-	/* Tell stdout not to buffer its content */
-	setbuf(stdout, NULL);
-
-	cap = kvm_check_cap(KVM_CAP_SYNC_REGS);
-	if (!cap) {
-		print_skip("CAP_SYNC_REGS not supported");
-		exit(KSFT_SKIP);
-	}
-
-	/* Create VM */
-	vm = vm_create_default(VCPU_ID, 0, guest_code);
-
-	run = vcpu_state(vm, VCPU_ID);
+	int rv;
 
 	/* Request reading invalid register set from VCPU. */
 	run->kvm_valid_regs = INVALID_SYNC_FIELD;
@@ -110,6 +93,11 @@ int main(int argc, char *argv[])
 		    "Invalid kvm_valid_regs did not cause expected KVM_RUN error: %d\n",
 		    rv);
 	vcpu_state(vm, VCPU_ID)->kvm_valid_regs = 0;
+}
+
+void test_set_invalid(struct kvm_vm *vm, struct kvm_run *run)
+{
+	int rv;
 
 	/* Request setting invalid register set into VCPU. */
 	run->kvm_dirty_regs = INVALID_SYNC_FIELD;
@@ -125,6 +113,13 @@ int main(int argc, char *argv[])
 		    "Invalid kvm_dirty_regs did not cause expected KVM_RUN error: %d\n",
 		    rv);
 	vcpu_state(vm, VCPU_ID)->kvm_dirty_regs = 0;
+}
+
+void test_req_and_verify_all_valid_regs(struct kvm_vm *vm, struct kvm_run *run)
+{
+	struct kvm_sregs sregs;
+	struct kvm_regs regs;
+	int rv;
 
 	/* Request and verify all valid register sets. */
 	run->kvm_valid_regs = TEST_SYNC_FIELDS;
@@ -146,6 +141,13 @@ int main(int argc, char *argv[])
 
 	vcpu_sregs_get(vm, VCPU_ID, &sregs);
 	compare_sregs(&sregs, &run->s.regs);
+}
+
+void test_set_and_verify_various_reg_values(struct kvm_vm *vm, struct kvm_run *run)
+{
+	struct kvm_sregs sregs;
+	struct kvm_regs regs;
+	int rv;
 
 	/* Set and verify various register values */
 	run->s.regs.gprs[11] = 0xBAD1DEA;
@@ -180,6 +182,11 @@ int main(int argc, char *argv[])
 
 	vcpu_sregs_get(vm, VCPU_ID, &sregs);
 	compare_sregs(&sregs, &run->s.regs);
+}
+
+void test_clear_kvm_dirty_regs_bits(struct kvm_vm *vm, struct kvm_run *run)
+{
+	int rv;
 
 	/* Clear kvm_dirty_regs bits, verify new s.regs values are
 	 * overwritten with existing guest values.
@@ -200,8 +207,46 @@ int main(int argc, char *argv[])
 	TEST_ASSERT(run->s.regs.diag318 != 0x4B1D,
 		    "diag318 sync regs value incorrect 0x%llx.",
 		    run->s.regs.diag318);
+}
+
+struct testdef {
+	const char *name;
+	void (*test)(struct kvm_vm *vm, struct kvm_run *run);
+} testlist[] = {
+	{ "read invalid", test_read_invalid },
+	{ "set invalid", test_set_invalid },
+	{ "request+verify all valid regs", test_req_and_verify_all_valid_regs },
+	{ "set+verify various regs", test_set_and_verify_various_reg_values },
+	{ "clear kvm_dirty_regs bits", test_clear_kvm_dirty_regs_bits },
+};
+
+int main(int argc, char *argv[])
+{
+	static struct kvm_run *run;
+	static struct kvm_vm *vm;
+	int idx;
+
+	/* Tell stdout not to buffer its content */
+	setbuf(stdout, NULL);
+
+	ksft_print_header();
+
+	if (!kvm_check_cap(KVM_CAP_SYNC_REGS))
+		ksft_exit_skip("CAP_SYNC_REGS not supported");
+
+	ksft_set_plan(ARRAY_SIZE(testlist));
+
+	/* Create VM */
+	vm = vm_create_default(VCPU_ID, 0, guest_code);
+
+	run = vcpu_state(vm, VCPU_ID);
+
+	for (idx = 0; idx < ARRAY_SIZE(testlist); idx++) {
+		testlist[idx].test(vm, run);
+		ksft_test_result_pass("%s\n", testlist[idx].name);
+	}
 
 	kvm_vm_free(vm);
 
-	return 0;
+	ksft_finished();
 }
-- 
2.27.0

