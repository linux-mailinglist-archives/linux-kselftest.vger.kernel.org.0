Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C4B6EAFED
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Apr 2023 19:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbjDUQ7n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 12:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbjDUQ7h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 12:59:37 -0400
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADE9167DA
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 09:59:14 -0700 (PDT)
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-517a659f877so1493203a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 09:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682095996; x=1684687996;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QAMadok09XxgFvaDO3J6Lgqv+ZDwnOLb2IYSq9G7u+A=;
        b=5l1CzLumfw4VvnGKs1LekidIOHm6RR2ZhVTA1I+whH2HeXgm2o8PhxoPUQLTHfydb9
         MbBxamdeRZWqIzwIX6cPpq9NGQ3282H+LGUyBZpLlO6iAgfWncKkZnXQevgjEqCzsFvI
         /ie9WS7cdYCl1aCB7+4MGfZNo6IMNnRdfZplWSdxceYc0BIUM6d0gO/blOvoZokSUVGw
         Y1vWnwlcSKtpR4AbEKzTUp+leY3IooaW0MIg6qShyiSd1O990V5j6KZFgnSxmwclrSfF
         iRRS2VvoFH4pfGHIeK5C/wh3ElWiAy4UgpcFTrfc4JtiPWNVC38kZkoYq7eJ04Cn12As
         uI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682095996; x=1684687996;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QAMadok09XxgFvaDO3J6Lgqv+ZDwnOLb2IYSq9G7u+A=;
        b=Fb1gbiUBL1TzJxBtczkg55iSVUgy/XmJTN7/UtwUPq98Cou4Cd4EPaPJnmj6FxPy6V
         AE53DznxfYhxIE5KOnTIRoYEW5LPQX+3Xi1XVw+jE2+9DmEL7QmmgQIloPSLHS+djXtt
         eYK2HsyyHCSp/xRgp5TT49PYrBsS5COaQS7HXv/jHbgnybN+tzmHIzKEbeAsgf+vZTez
         9rXEGtZV0H0iHeQHUKfkCxf4ugKKq/VIUpAaoO1CZ8cAdVD7dJDfj4xRJrQEgBPUjDg5
         4VCEz5BTiy8pfM2HdohF5rbom9t/7G2bqgVM40BatBr1n4gy7OoIhIZIIaBhVJPQMa1Q
         /I9w==
X-Gm-Message-State: AAQBX9fCSpvnfN12dhXeC7sAFLGKaNbV7pknBGlIDqPTMkGEysSuvE2R
        x5cb2llxYY4Ppr5dyvW3qGzvp/NDudFy
X-Google-Smtp-Source: AKy350ZjCHa4QHnHiWhcJq+auFhrVPVMASZyckOmf5zCb6ojNKQ4+uKrop3naLHjd6GRNHOZE2DYdu7UHwlH
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a63:105e:0:b0:520:53fa:9878 with SMTP id
 30-20020a63105e000000b0052053fa9878mr1424111pgq.6.1682095996166; Fri, 21 Apr
 2023 09:53:16 -0700 (PDT)
Date:   Fri, 21 Apr 2023 09:53:00 -0700
In-Reply-To: <20230421165305.804301-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20230421165305.804301-1-vipinsh@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230421165305.804301-5-vipinsh@google.com>
Subject: [PATCH 4/9] KVM: selftests: Print read and write accesses of pages by
 vCPUs in dirty_log_perf_test
From:   Vipin Sharma <vipinsh@google.com>
To:     maz@kernel.org, oliver.upton@linux.dev, james.morse@arm.com,
        suzuki.poulose@arm.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
        aleksandar.qemu.devel@gmail.com, tsbogend@alpha.franken.de,
        anup@brainfault.org, atishp@atishpatra.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, seanjc@google.com, pbonzini@redhat.com,
        dmatlack@google.com, ricarkol@google.com
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fetch read and write accesses of pages from guest code and print count
across all vCPUs in dirty_log_perf_test.

This data provides progress made by vCPUs during dirty logging
operations. Since, vCPUs execute in lockstep with userspace dirty log
iterations, this metric is not very interesting. However, in future
commits when dirty_log_perf_test can execute vCPUs independently from
dirty log iterations then this metric can give good measure of vCPUs
performance during dirty logging.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 .../selftests/kvm/dirty_log_perf_test.c        | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
index 338f03a4a550..0a08a3d21123 100644
--- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
@@ -12,6 +12,7 @@
 #include <stdlib.h>
 #include <time.h>
 #include <pthread.h>
+#include <stdatomic.h>
 #include <linux/bitmap.h>
 
 #include "kvm_util.h"
@@ -66,17 +67,22 @@ static u64 dirty_log_manual_caps;
 static bool host_quit;
 static int iteration;
 static int vcpu_last_completed_iteration[KVM_MAX_VCPUS];
+static atomic_ullong total_reads;
+static atomic_ullong total_writes;
 
 static void vcpu_worker(struct memstress_vcpu_args *vcpu_args)
 {
 	struct kvm_vcpu *vcpu = vcpu_args->vcpu;
 	int vcpu_idx = vcpu_args->vcpu_idx;
 	uint64_t pages_count = 0;
+	uint64_t reads = 0;
+	uint64_t writes = 0;
 	struct kvm_run *run;
 	struct timespec start;
 	struct timespec ts_diff;
 	struct timespec total = (struct timespec){0};
 	struct timespec avg;
+	struct ucall uc = {};
 	int ret;
 
 	run = vcpu->run;
@@ -89,7 +95,7 @@ static void vcpu_worker(struct memstress_vcpu_args *vcpu_args)
 		ts_diff = timespec_elapsed(start);
 
 		TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);
-		TEST_ASSERT(get_ucall(vcpu, NULL) == UCALL_SYNC,
+		TEST_ASSERT(get_ucall(vcpu, &uc) == UCALL_SYNC,
 			    "Invalid guest sync status: exit_reason=%s\n",
 			    exit_reason_str(run->exit_reason));
 
@@ -101,6 +107,8 @@ static void vcpu_worker(struct memstress_vcpu_args *vcpu_args)
 		if (current_iteration) {
 			pages_count += vcpu_args->pages;
 			total = timespec_add(total, ts_diff);
+			reads += uc.args[2];
+			writes += uc.args[3];
 			pr_debug("vCPU %d iteration %d dirty memory time: %ld.%.9lds\n",
 				vcpu_idx, current_iteration, ts_diff.tv_sec,
 				ts_diff.tv_nsec);
@@ -123,6 +131,8 @@ static void vcpu_worker(struct memstress_vcpu_args *vcpu_args)
 	pr_debug("\nvCPU %d dirtied 0x%lx pages over %d iterations in %ld.%.9lds. (Avg %ld.%.9lds/iteration)\n",
 		vcpu_idx, pages_count, vcpu_last_completed_iteration[vcpu_idx],
 		total.tv_sec, total.tv_nsec, avg.tv_sec, avg.tv_nsec);
+	atomic_fetch_add(&total_reads, reads);
+	atomic_fetch_add(&total_writes, writes);
 }
 
 struct test_params {
@@ -176,6 +186,8 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 			      dirty_log_manual_caps);
 
 	arch_setup_vm(vm, nr_vcpus);
+	atomic_store(&total_reads, 0);
+	atomic_store(&total_writes, 0);
 
 	/* Start the iterations */
 	iteration = 0;
@@ -295,6 +307,10 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 			clear_dirty_log_total.tv_nsec, avg.tv_sec, avg.tv_nsec);
 	}
 
+	pr_info("Total pages touched: %llu (Reads: %llu, Writes: %llu)\n",
+		atomic_load(&total_reads) + atomic_load(&total_writes),
+		atomic_load(&total_reads), atomic_load(&total_writes));
+
 	memstress_free_bitmaps(bitmaps, p->slots);
 	arch_cleanup_vm(vm);
 	memstress_destroy_vm(vm);
-- 
2.40.0.634.g4ca3ef3211-goog

