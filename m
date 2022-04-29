Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A160A51427F
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Apr 2022 08:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbiD2Glv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Apr 2022 02:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354601AbiD2Glc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Apr 2022 02:41:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FE9ABABA3
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Apr 2022 23:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651214288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qh2pYsSv0Jsq4yPSrKOGS/h5dSBWkO2z1DpVXJerATU=;
        b=RE5Z8QL2QmIJn2oEii2m4EqQfxaUPF/0PKfGKp6M+cwyp+AXXUJgaAn4AS8MTMvW/ObrKE
        4G/p1k1YLiwLQeTfbQZrGPrhKUT2dWVqgo7L3pk15gcnUNUetzMbo51IeO8dAasT7eY9Aj
        rPayLyBNFREZHURRhe9uEIJWcAybOSo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-96-g8Utg0-KMFW-Rd9hjjEMvg-1; Fri, 29 Apr 2022 02:38:04 -0400
X-MC-Unique: g8Utg0-KMFW-Rd9hjjEMvg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 87A8E1C07382;
        Fri, 29 Apr 2022 06:38:02 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC86914A5060;
        Fri, 29 Apr 2022 06:37:59 +0000 (UTC)
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
Subject: [PATCH v3 4/4] KVM: s390: selftests: Use TAP interface in the reset test
Date:   Fri, 29 Apr 2022 08:37:24 +0200
Message-Id: <20220429063724.480919-5-thuth@redhat.com>
In-Reply-To: <20220429063724.480919-1-thuth@redhat.com>
References: <20220429063724.480919-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
2.27.0

