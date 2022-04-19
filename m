Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFFA50798A
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 21:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357372AbiDSTB5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 15:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343505AbiDSTB4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 15:01:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C0E03EF35
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 11:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650394752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b6TJcLIz+PLFCqxxbKdWxXuszexJOjQzXUcB5qmATSg=;
        b=e38ruspE/OQvd4t+JsFnxdS+7f6qSONXDPgRx/F5MQISXQN+Gy4XBR0aSwLuhAYP4Pcp0Y
        E6Ysn044g07Zdml4ruZfve9GflUizNvedX5e0pX0Xf6wYJPa3lx1N15/y3WON5n1Z26g6+
        MLiue+QoP7kaM+6IZhMwA0CqT3/vr70=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-vO6CQVmpOBWxGc2LPeQMjA-1; Tue, 19 Apr 2022 14:59:08 -0400
X-MC-Unique: vO6CQVmpOBWxGc2LPeQMjA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7988438025EE;
        Tue, 19 Apr 2022 18:59:07 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 532C9572321;
        Tue, 19 Apr 2022 18:59:04 +0000 (UTC)
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
Subject: [PATCH v2 1/4] KVM: s390: selftests: Use TAP interface in the memop test
Date:   Tue, 19 Apr 2022 20:58:54 +0200
Message-Id: <20220419185857.128351-2-thuth@redhat.com>
In-Reply-To: <20220419185857.128351-1-thuth@redhat.com>
References: <20220419185857.128351-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The memop test currently does not have any output (unless one of the
TEST_ASSERT statement fails), so it's hard to say for a user whether
a certain new sub-test has been included in the binary or not. Let's
make this a little bit more user-friendly and include some TAP output
via the kselftests.h interface.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tools/testing/selftests/kvm/s390x/memop.c | 90 ++++++++++++++++++-----
 1 file changed, 73 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index b04c2c1b3c30..ad9fe86c0592 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -12,6 +12,7 @@
 
 #include "test_util.h"
 #include "kvm_util.h"
+#include "kselftest.h"
 
 enum mop_target {
 	LOGICAL,
@@ -648,33 +649,88 @@ static void test_errors(void)
 	kvm_vm_free(t.kvm_vm);
 }
 
+struct testdef {
+	const char *name;
+	void (*test)(void);
+	int cap;
+} testlist[] = {
+	{
+		.name = "simple copy",
+		.test = test_copy,
+	},
+	{
+		.name = "generic error checks",
+		.test = test_errors,
+	},
+	{
+		.name = "copy with storage keys",
+		.test = test_copy_key,
+		.cap = KVM_CAP_S390_MEM_OP_EXTENSION,
+	},
+	{
+		.name = "copy with key storage protection override",
+		.test = test_copy_key_storage_prot_override,
+		.cap = KVM_CAP_S390_MEM_OP_EXTENSION,
+	},
+	{
+		.name = "copy with key fetch protection",
+		.test = test_copy_key_fetch_prot,
+		.cap = KVM_CAP_S390_MEM_OP_EXTENSION,
+	},
+	{
+		.name = "copy with key fetch protection override",
+		.test = test_copy_key_fetch_prot_override,
+		.cap = KVM_CAP_S390_MEM_OP_EXTENSION,
+	},
+	{
+		.name = "error checks with key",
+		.test = test_errors_key,
+		.cap = KVM_CAP_S390_MEM_OP_EXTENSION,
+	},
+	{
+		.name = "error checks with key storage protection override",
+		.test = test_errors_key_storage_prot_override,
+		.cap = KVM_CAP_S390_MEM_OP_EXTENSION,
+	},
+	{
+		.name = "error checks without key fetch prot override",
+		.test = test_errors_key_fetch_prot_override_not_enabled,
+		.cap = KVM_CAP_S390_MEM_OP_EXTENSION,
+	},
+	{
+		.name = "error checks with key fetch prot override",
+		.test = test_errors_key_fetch_prot_override_enabled,
+		.cap = KVM_CAP_S390_MEM_OP_EXTENSION,
+	},
+};
+
 int main(int argc, char *argv[])
 {
-	int memop_cap, extension_cap;
+	int memop_cap, extension_cap, idx;
 
 	setbuf(stdout, NULL);	/* Tell stdout not to buffer its content */
 
+	ksft_print_header();
+
 	memop_cap = kvm_check_cap(KVM_CAP_S390_MEM_OP);
 	extension_cap = kvm_check_cap(KVM_CAP_S390_MEM_OP_EXTENSION);
 	if (!memop_cap) {
-		print_skip("CAP_S390_MEM_OP not supported");
-		exit(KSFT_SKIP);
+		ksft_exit_skip("CAP_S390_MEM_OP not supported.\n");
 	}
 
-	test_copy();
-	if (extension_cap > 0) {
-		test_copy_key();
-		test_copy_key_storage_prot_override();
-		test_copy_key_fetch_prot();
-		test_copy_key_fetch_prot_override();
-		test_errors_key();
-		test_errors_key_storage_prot_override();
-		test_errors_key_fetch_prot_override_not_enabled();
-		test_errors_key_fetch_prot_override_enabled();
-	} else {
-		print_skip("storage key memop extension not supported");
+	ksft_set_plan(ARRAY_SIZE(testlist));
+
+	for (idx = 0; idx < ARRAY_SIZE(testlist); idx++) {
+		if (!testlist[idx].cap || (extension_cap &&
+		    testlist[idx].cap == KVM_CAP_S390_MEM_OP_EXTENSION)) {
+			testlist[idx].test();
+			ksft_test_result_pass("%s\n", testlist[idx].name);
+		} else {
+			ksft_test_result_skip("%s - capability %d not supported\n",
+					      testlist[idx].name,
+					      testlist[idx].cap);
+		}
 	}
-	test_errors();
 
-	return 0;
+	ksft_finished();
 }
-- 
2.27.0

