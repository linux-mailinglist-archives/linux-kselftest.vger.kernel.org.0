Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28923514307
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Apr 2022 09:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354977AbiD2HPS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Apr 2022 03:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354793AbiD2HPR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Apr 2022 03:15:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB86F192BE
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Apr 2022 00:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651216319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Eeml1NGAG++uLXs/s/HDZYXT+SQjn5HA3mIKGb81Y4o=;
        b=HH+L0rznu1/UeXbQOAQ7zo2r1DZX5+gLdj9u43j9oM3KCRMTqxfk/5rdHxCXqHEEogrcnL
        977b/9+Sb81iB6TcAAzqjBeeVy4EQclYaLVdICtsl8X9AoPvlPjlOtiGfzl6cPnffJJ1+2
        OIXEpByPxFAKxvUk+jo/BHS4ww5pFoU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-156-dRuKLd0tPkin7KSv8IMuaQ-1; Fri, 29 Apr 2022 03:11:55 -0400
X-MC-Unique: dRuKLd0tPkin7KSv8IMuaQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4D3C85A5A8;
        Fri, 29 Apr 2022 07:11:54 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C9E814A5060;
        Fri, 29 Apr 2022 07:11:52 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: selftests: Use TAP interface in the kvm_binary_stats_test
Date:   Fri, 29 Apr 2022 09:11:49 +0200
Message-Id: <20220429071149.488114-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 .../testing/selftests/kvm/kvm_binary_stats_test.c  | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/kvm_binary_stats_test.c b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
index 17f65d514915..aa648834e178 100644
--- a/tools/testing/selftests/kvm/kvm_binary_stats_test.c
+++ b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
@@ -19,6 +19,7 @@
 #include "kvm_util.h"
 #include "asm/kvm.h"
 #include "linux/kvm.h"
+#include "kselftest.h"
 
 static void stats_test(int stats_fd)
 {
@@ -52,7 +53,7 @@ static void stats_test(int stats_fd)
 
 	/* Sanity check for other fields in header */
 	if (header->num_desc == 0) {
-		printf("No KVM stats defined!");
+		ksft_print_msg("No KVM stats defined!\n");
 		return;
 	}
 	/* Check overlap */
@@ -219,12 +220,15 @@ int main(int argc, char *argv[])
 			max_vcpu = DEFAULT_NUM_VCPU;
 	}
 
+	ksft_print_header();
+
 	/* Check the extension for binary stats */
 	if (kvm_check_cap(KVM_CAP_BINARY_STATS_FD) <= 0) {
-		print_skip("Binary form statistics interface is not supported");
-		exit(KSFT_SKIP);
+		ksft_exit_skip("Binary form statistics interface is not supported\n");
 	}
 
+	ksft_set_plan(max_vm);
+
 	/* Create VMs and VCPUs */
 	vms = malloc(sizeof(vms[0]) * max_vm);
 	TEST_ASSERT(vms, "Allocate memory for storing VM pointers");
@@ -240,10 +244,12 @@ int main(int argc, char *argv[])
 		vm_stats_test(vms[i]);
 		for (j = 0; j < max_vcpu; ++j)
 			vcpu_stats_test(vms[i], j);
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
2.27.0

