Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1863F538EAC
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 May 2022 12:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245631AbiEaKQe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 May 2022 06:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245641AbiEaKQX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 May 2022 06:16:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBB6F99800
        for <linux-kselftest@vger.kernel.org>; Tue, 31 May 2022 03:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653992174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jehKCSInS36gCpA16c238tEQWb8YXZCabSijheknWPA=;
        b=DhPiUnQJol7Mlo6jyrinOauu5UBDSch7pcshNXDQFRRS62FHsSNOpbjOsP530SlhGmoL03
        serd7mmAiOHi2HZE1yBv0QUel8a2Xnzhh9nFjWFbs+R3iXmkpgNINTpD6/CA462rhSHflB
        nQ6ijF6M+MY80tX7l6pTsRPddZQ4PWI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-mwTtiX52Ph-WZqYcT0uExQ-1; Tue, 31 May 2022 06:16:11 -0400
X-MC-Unique: mwTtiX52Ph-WZqYcT0uExQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB48A811E7A;
        Tue, 31 May 2022 10:16:10 +0000 (UTC)
Received: from thuth.com (unknown [10.39.194.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1903C492C3B;
        Tue, 31 May 2022 10:16:07 +0000 (UTC)
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
Subject: [PATCH v4 4/4] KVM: s390: selftests: Use TAP interface in the reset test
Date:   Tue, 31 May 2022 12:15:54 +0200
Message-Id: <20220531101554.36844-5-thuth@redhat.com>
In-Reply-To: <20220531101554.36844-1-thuth@redhat.com>
References: <20220531101554.36844-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Let's standardize the s390x KVM selftest output to the TAP output
generated via the kselftests.h interface.

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tools/testing/selftests/kvm/s390x/resets.c | 38 +++++++++++++++++-----
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/resets.c b/tools/testing/selftests/kvm/s390x/resets.c
index b143db6d8693..889449a22e7a 100644
--- a/tools/testing/selftests/kvm/s390x/resets.c
+++ b/tools/testing/selftests/kvm/s390x/resets.c
@@ -12,6 +12,7 @@
 
 #include "test_util.h"
 #include "kvm_util.h"
+#include "kselftest.h"
 
 #define VCPU_ID 3
 #define LOCAL_IRQS 32
@@ -202,7 +203,7 @@ static void inject_irq(int cpu_id)
 
 static void test_normal(void)
 {
-	pr_info("Testing normal reset\n");
+	ksft_print_msg("Testing normal reset\n");
 	/* Create VM */
 	vm = vm_create_default(VCPU_ID, 0, guest_code_initial);
 	run = vcpu_state(vm, VCPU_ID);
@@ -225,7 +226,7 @@ static void test_normal(void)
 
 static void test_initial(void)
 {
-	pr_info("Testing initial reset\n");
+	ksft_print_msg("Testing initial reset\n");
 	vm = vm_create_default(VCPU_ID, 0, guest_code_initial);
 	run = vcpu_state(vm, VCPU_ID);
 	sync_regs = &run->s.regs;
@@ -247,7 +248,7 @@ static void test_initial(void)
 
 static void test_clear(void)
 {
-	pr_info("Testing clear reset\n");
+	ksft_print_msg("Testing clear reset\n");
 	vm = vm_create_default(VCPU_ID, 0, guest_code_initial);
 	run = vcpu_state(vm, VCPU_ID);
 	sync_regs = &run->s.regs;
@@ -266,14 +267,35 @@ static void test_clear(void)
 	kvm_vm_free(vm);
 }
 
+struct testdef {
+	const char *name;
+	void (*test)(void);
+	bool needs_cap;
+} testlist[] = {
+	{ "initial", test_initial, false },
+	{ "normal", test_normal, true },
+	{ "clear", test_clear, true },
+};
+
 int main(int argc, char *argv[])
 {
+	bool has_s390_vcpu_resets = kvm_check_cap(KVM_CAP_S390_VCPU_RESETS);
+	int idx;
+
 	setbuf(stdout, NULL);	/* Tell stdout not to buffer its content */
 
-	test_initial();
-	if (kvm_check_cap(KVM_CAP_S390_VCPU_RESETS)) {
-		test_normal();
-		test_clear();
+	ksft_print_header();
+	ksft_set_plan(ARRAY_SIZE(testlist));
+
+	for (idx = 0; idx < ARRAY_SIZE(testlist); idx++) {
+		if (!testlist[idx].needs_cap || has_s390_vcpu_resets) {
+			testlist[idx].test();
+			ksft_test_result_pass("%s\n", testlist[idx].name);
+		} else {
+			ksft_test_result_skip("%s - no VCPU_RESETS capability\n",
+					      testlist[idx].name);
+		}
 	}
-	return 0;
+
+	ksft_finished();	/* Print results and exit() accordingly */
 }
-- 
2.31.1

