Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893D17CF48C
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Oct 2023 11:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345162AbjJSJ76 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Oct 2023 05:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345154AbjJSJ76 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Oct 2023 05:59:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC18C115
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Oct 2023 02:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697709551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=o0GKBFmVobxSwwKQNWW2TaS9XDs1vVwJ1OIKQU3bmTQ=;
        b=DnB7VEXxbmSdE5Y1V+EOxyeE/7woYYGW7JGfWtzZEy3ZmvQK69vnPCWx1f1pbGpiOsZ6gd
        3FApt4YN8M9CybSjov5DkeDIo+WtTrzHZkZRyYb8C2ejcWrOgRJ79Z2gy2jSh7EcsoEMIk
        kfHVGtXGsHZPPC2c8b6oRwCaFQDmKvI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-WXWgN8iYMBSDQW7kCX414A-1; Thu, 19 Oct 2023 05:59:02 -0400
X-MC-Unique: WXWgN8iYMBSDQW7kCX414A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 225BB1C068D3;
        Thu, 19 Oct 2023 09:59:02 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 170208AF;
        Thu, 19 Oct 2023 09:59:00 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: selftests: Use TAP in the steal_time test
Date:   Thu, 19 Oct 2023 11:59:00 +0200
Message-ID: <20231019095900.450467-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

For easier use of the tests in automation and for having some
status information for the user while the test is running, let's
provide some TAP output in this test.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 NB: This patch does not use the interface from kselftest_harness.h
     since it is not very suitable for the for-loop in this patch.

 tools/testing/selftests/kvm/steal_time.c | 46 ++++++++++++------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
index 171adfb2a6cb..aa6149eb9ea1 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -81,20 +81,18 @@ static void steal_time_init(struct kvm_vcpu *vcpu, uint32_t i)
 static void steal_time_dump(struct kvm_vm *vm, uint32_t vcpu_idx)
 {
 	struct kvm_steal_time *st = addr_gva2hva(vm, (ulong)st_gva[vcpu_idx]);
-	int i;
 
-	pr_info("VCPU%d:\n", vcpu_idx);
-	pr_info("    steal:     %lld\n", st->steal);
-	pr_info("    version:   %d\n", st->version);
-	pr_info("    flags:     %d\n", st->flags);
-	pr_info("    preempted: %d\n", st->preempted);
-	pr_info("    u8_pad:    ");
-	for (i = 0; i < 3; ++i)
-		pr_info("%d", st->u8_pad[i]);
-	pr_info("\n    pad:       ");
-	for (i = 0; i < 11; ++i)
-		pr_info("%d", st->pad[i]);
-	pr_info("\n");
+	ksft_print_msg("VCPU%d:\n", vcpu_idx);
+	ksft_print_msg("    steal:     %lld\n", st->steal);
+	ksft_print_msg("    version:   %d\n", st->version);
+	ksft_print_msg("    flags:     %d\n", st->flags);
+	ksft_print_msg("    preempted: %d\n", st->preempted);
+	ksft_print_msg("    u8_pad:    %d %d %d\n",
+			st->u8_pad[0], st->u8_pad[1], st->u8_pad[2]);
+	ksft_print_msg("    pad:       %d %d %d %d %d %d %d %d %d %d %d\n",
+			st->pad[0], st->pad[1], st->pad[2], st->pad[3],
+			st->pad[4], st->pad[5], st->pad[6], st->pad[7],
+			st->pad[8], st->pad[9], st->pad[10]);
 }
 
 #elif defined(__aarch64__)
@@ -197,10 +195,10 @@ static void steal_time_dump(struct kvm_vm *vm, uint32_t vcpu_idx)
 {
 	struct st_time *st = addr_gva2hva(vm, (ulong)st_gva[vcpu_idx]);
 
-	pr_info("VCPU%d:\n", vcpu_idx);
-	pr_info("    rev:     %d\n", st->rev);
-	pr_info("    attr:    %d\n", st->attr);
-	pr_info("    st_time: %ld\n", st->st_time);
+	ksft_print_msg("VCPU%d:\n", vcpu_idx);
+	ksft_print_msg("    rev:     %d\n", st->rev);
+	ksft_print_msg("    attr:    %d\n", st->attr);
+	ksft_print_msg("    st_time: %ld\n", st->st_time);
 }
 
 #endif
@@ -267,7 +265,9 @@ int main(int ac, char **av)
 	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, ST_GPA_BASE, 1, gpages, 0);
 	virt_map(vm, ST_GPA_BASE, ST_GPA_BASE, gpages);
 
+	ksft_print_header();
 	TEST_REQUIRE(is_steal_time_supported(vcpus[0]));
+	ksft_set_plan(NR_VCPUS);
 
 	/* Run test on each VCPU */
 	for (i = 0; i < NR_VCPUS; ++i) {
@@ -308,14 +308,14 @@ int main(int ac, char **av)
 			    run_delay, stolen_time);
 
 		if (verbose) {
-			pr_info("VCPU%d: total-stolen-time=%ld test-stolen-time=%ld", i,
-				guest_stolen_time[i], stolen_time);
-			if (stolen_time == run_delay)
-				pr_info(" (BONUS: guest test-stolen-time even exactly matches test-run_delay)");
-			pr_info("\n");
+			ksft_print_msg("VCPU%d: total-stolen-time=%ld test-stolen-time=%ld%s\n",
+				       i, guest_stolen_time[i], stolen_time,
+				       stolen_time == run_delay ?
+				       " (BONUS: guest test-stolen-time even exactly matches test-run_delay)" : "");
 			steal_time_dump(vm, i);
 		}
+		ksft_test_result_pass("vcpu%d\n", i);
 	}
 
-	return 0;
+	ksft_finished();        /* Print results and exit() accordingly */
 }
-- 
2.41.0

