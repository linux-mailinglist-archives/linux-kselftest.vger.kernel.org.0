Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F845F3FF2
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Oct 2022 11:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiJDJjL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Oct 2022 05:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiJDJim (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Oct 2022 05:38:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8670B13F2C
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Oct 2022 02:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664876100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7EwjtAnCSSogBERoUZ3lJ8M5cI4G7abMk9q+5QMG9rM=;
        b=VxncabA7wx6lCkUx5jhdlqmwmoGPM2B/wx84qHl2HpSUiTTuk9TiP31ARB0XXFKsS1Pgo2
        WTd+1lg9YD5rwV+7Omu63p7bgco8WRTumoWhYCl7XMhJOA6sGLF1EQ4lcr5jIDYrQXfYDj
        xe40/8yrg3MPlEiUzmE9LTnm6UKOmaM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-347-kFDnajenPauDs4F2uTW4HQ-1; Tue, 04 Oct 2022 05:31:38 -0400
X-MC-Unique: kFDnajenPauDs4F2uTW4HQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B0ED185A7AB;
        Tue,  4 Oct 2022 09:31:38 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93F172166B26;
        Tue,  4 Oct 2022 09:31:36 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] KVM: selftests: Use TAP interface in the kvm_binary_stats_test
Date:   Tue,  4 Oct 2022 11:31:29 +0200
Message-Id: <20221004093131.40392-2-thuth@redhat.com>
In-Reply-To: <20221004093131.40392-1-thuth@redhat.com>
References: <20221004093131.40392-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The kvm_binary_stats_test test currently does not have any output (unless
one of the TEST_ASSERT statement fails), so it's hard to say for a user
how far it did proceed already. Thus let's make this a little bit more
user-friendly and include some TAP output via the kselftest.h interface.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tools/testing/selftests/kvm/kvm_binary_stats_test.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/kvm_binary_stats_test.c b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
index 0b45ac593387..894417c96f70 100644
--- a/tools/testing/selftests/kvm/kvm_binary_stats_test.c
+++ b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
@@ -19,6 +19,7 @@
 #include "kvm_util.h"
 #include "asm/kvm.h"
 #include "linux/kvm.h"
+#include "kselftest.h"
 
 static void stats_test(int stats_fd)
 {
@@ -51,7 +52,7 @@ static void stats_test(int stats_fd)
 
 	/* Sanity check for other fields in header */
 	if (header.num_desc == 0) {
-		printf("No KVM stats defined!");
+		ksft_print_msg("No KVM stats defined!\n");
 		return;
 	}
 	/*
@@ -224,9 +225,13 @@ int main(int argc, char *argv[])
 			max_vcpu = DEFAULT_NUM_VCPU;
 	}
 
+	ksft_print_header();
+
 	/* Check the extension for binary stats */
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_BINARY_STATS_FD));
 
+	ksft_set_plan(max_vm);
+
 	/* Create VMs and VCPUs */
 	vms = malloc(sizeof(vms[0]) * max_vm);
 	TEST_ASSERT(vms, "Allocate memory for storing VM pointers");
@@ -245,10 +250,12 @@ int main(int argc, char *argv[])
 		vm_stats_test(vms[i]);
 		for (j = 0; j < max_vcpu; ++j)
 			vcpu_stats_test(vcpus[i * max_vcpu + j]);
+		ksft_test_result_pass("vm%i\n", i);
 	}
 
 	for (i = 0; i < max_vm; ++i)
 		kvm_vm_free(vms[i]);
 	free(vms);
-	return 0;
+
+	ksft_finished();	/* Print results and exit() accordingly */
 }
-- 
2.31.1

