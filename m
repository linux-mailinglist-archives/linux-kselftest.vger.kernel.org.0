Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1455079BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 21:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239534AbiDSTE1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 15:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357502AbiDSTC0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 15:02:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5ADAC3FBCC
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 11:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650394772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dFH0T0pXpNETbaNFYRkeQO7JMN8WlaRMY9DPSUKwh6Q=;
        b=QFWJGM+vabnL/ZiPd9Np6Ykm8P9O9x7c+cKDxXz+z603LxvKFtYp3XWek3FfbQ5u0BiGYk
        nQuicCB6M5cQy0dMU+cyrjlILdnf7PfJMRD0jWDRdaMZOAJsWOxa5vco3/w9XoO9YH1MJY
        IaVk9Het/ks/MnmshB0Emjph8FA2YMQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-vJUDlclwOgKtzQjnvyfezQ-1; Tue, 19 Apr 2022 14:59:21 -0400
X-MC-Unique: vJUDlclwOgKtzQjnvyfezQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B00486B8A8;
        Tue, 19 Apr 2022 18:59:21 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D3B66572321;
        Tue, 19 Apr 2022 18:59:16 +0000 (UTC)
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
Subject: [PATCH v2 4/4] KVM: s390: selftests: Use TAP interface in the reset test
Date:   Tue, 19 Apr 2022 20:58:57 +0200
Message-Id: <20220419185857.128351-5-thuth@redhat.com>
In-Reply-To: <20220419185857.128351-1-thuth@redhat.com>
References: <20220419185857.128351-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Let's standardize the s390x KVM selftest output to the TAP output
generated via the kselftests.h interface.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tools/testing/selftests/kvm/s390x/resets.c | 38 +++++++++++++++++-----
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/resets.c b/tools/testing/selftests/kvm/s390x/resets.c
index b143db6d8693..1d649ec77260 100644
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
+	ksft_finished();
 }
-- 
2.27.0

