Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC23E514276
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Apr 2022 08:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354603AbiD2GlT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Apr 2022 02:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354595AbiD2GlQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Apr 2022 02:41:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C125AB9F39
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Apr 2022 23:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651214277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yIng3JzdUPtQk2EgQVeJ1LDlFP3/mpoZsPdx0fgK9Gw=;
        b=XFrQsFDkDPcJgZhMh8hP/16hICtD8mAAKfVrQ/kFdVsLQ/VhF5C08or2frNDOy8NgegUH5
        8uJZXJXObHTC3hVH0EJuzk7TcmYzSexp4mnv8JYbW854Yq/FD+W80i0eCHgzMTV/VrHDnH
        b96KbnGE0rVVAI70g1WcVCYoVKf0sjY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-C3zT8bG-PVaW5btMnPsgwg-1; Fri, 29 Apr 2022 02:37:54 -0400
X-MC-Unique: C3zT8bG-PVaW5btMnPsgwg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E45DF85A5A8;
        Fri, 29 Apr 2022 06:37:53 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0669514A5060;
        Fri, 29 Apr 2022 06:37:50 +0000 (UTC)
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
Subject: [PATCH v3 1/4] KVM: s390: selftests: Use TAP interface in the memop test
Date:   Fri, 29 Apr 2022 08:37:21 +0200
Message-Id: <20220429063724.480919-2-thuth@redhat.com>
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

The memop test currently does not have any output (unless one of the
TEST_ASSERT statement fails), so it's hard to say for a user whether
a certain new sub-test has been included in the binary or not. Let's
make this a little bit more user-friendly and include some TAP output
via the kselftests.h interface.

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tools/testing/selftests/kvm/s390x/memop.c | 90 ++++++++++++++++++-----
 1 file changed, 73 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index b04c2c1b3c30..79f2ec338161 100644
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
+	ksft_finished();	/* Print results and exit() accordingly */
 }
-- 
2.27.0

