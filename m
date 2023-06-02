Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161B17206E8
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 18:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbjFBQJ6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 12:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236351AbjFBQJn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 12:09:43 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510DCE54
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Jun 2023 09:09:30 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-53f6e194e7bso2085890a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jun 2023 09:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685722169; x=1688314169;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TCZIk7VgxCOZOGj9BrulapCebBiXjQ5+VJfBT1Ieq9g=;
        b=48Jv9Ndg6W2FWtv0TNF+EvHQkuzevnf0de3wNHQhiINnd1y+TJ3ZHZNsYvgiBjl6lh
         9WUrwiuBOv0A4GYPSawEV6yVx5LbPQL0U+gQGnFWAFVUnyrF1z1qm1xlbl6HRjy6NNwE
         8XB2SVK1dbUaEeLrM/H8JHaqBSIup+A6xNFpzpaufkcVOP+VAaTUukUdmKNrTQcISuZt
         yTtWhk1kuZr3BXzyN9NP6mKp7IAXkKM1nK9WQaTXO/PtqFm7I9EIaNt4fcwETtWcECAj
         9ktEJ+8oLB8jJgpGPXgzImfVTKXWHcOIgbQS6xiesRZonieLTn89FjSta0ZVX6QUoqee
         mZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685722169; x=1688314169;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TCZIk7VgxCOZOGj9BrulapCebBiXjQ5+VJfBT1Ieq9g=;
        b=OVma14NIQr6GjK3wLGXufRAaqzlygT5/jk/nIzMZ03RA/Vjo/Y/rZ1xyiXveOqYw8V
         3WjIHGo8jjrVHbQxcy+u4Iy3II72hpt/ZMnSNQC9M+i9NVTI0HJXgzxC+05ar0PwbEAx
         cREHNzqNP60DqyLHLRfFyt3FF5RELdJhf5ZX9Z8kGeioEMlA8Qr2Fo1EEP83Fel1vlJ0
         FNpGkb6ufGXNOafcI3z/pXTmOwtZJ4oNnDdDM17PARJORXQ6FGW986IeqLj/ou22oGLy
         BzVO3hsForurhcXX8nKJW9+E4DBofgdh4oQeZX61MGNfD8lX1xDZDA0wWTJpgFSunvEm
         BVcw==
X-Gm-Message-State: AC+VfDyoahYt5mLQF1og7zWQ8jFa5/M2zfjY5b38N/Wx4Zqy5YoCz+tG
        8io9n5FI+qk9WPHst+8M5tr+Ma1AF1Ap
X-Google-Smtp-Source: ACHHUZ5eYF/RV9lQrAgLH67VBGXqFnNNXk0G34PjM3lxGa6/KnJxp9P54a/FAO5X5SRVmoZXvlFdh+lSImCS
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a63:d044:0:b0:53f:32cf:bcd1 with SMTP id
 s4-20020a63d044000000b0053f32cfbcd1mr2492124pgi.5.1685722169678; Fri, 02 Jun
 2023 09:09:29 -0700 (PDT)
Date:   Fri,  2 Jun 2023 09:09:03 -0700
In-Reply-To: <20230602160914.4011728-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20230602160914.4011728-1-vipinsh@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230602160914.4011728-6-vipinsh@google.com>
Subject: [PATCH v2 05/16] KVM: selftests: Allow independent execution of vCPUs
 in dirty_log_perf_test
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Give users command line option (-j) to execute vCPUs independently of
dirty log iterations after initialization is complete.

This change makes dirty_log_perf_test behave like real world workflows
where guest vCPUs keep on executing while VMM collects and clear dirty
logs. Total pages touched during execution of test will give good
estimate of how vCPUs are performing while dirty logging is enabled.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 .../selftests/kvm/dirty_log_perf_test.c       | 64 +++++++++++++------
 1 file changed, 44 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
index 14b012a0dcb1..fbf973d6cc66 100644
--- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
@@ -69,6 +69,7 @@ static int iteration;
 static int vcpu_last_completed_iteration[KVM_MAX_VCPUS];
 static atomic_ullong total_reads;
 static atomic_ullong total_writes;
+static bool lockstep_iterations;
 
 static void vcpu_worker(struct memstress_vcpu_args *vcpu_args)
 {
@@ -83,12 +84,16 @@ static void vcpu_worker(struct memstress_vcpu_args *vcpu_args)
 	struct timespec total = (struct timespec){0};
 	struct timespec avg;
 	struct ucall uc = {};
+	int current_iteration = -1;
 	int ret;
 
 	run = vcpu->run;
 
 	while (!READ_ONCE(host_quit)) {
-		int current_iteration = READ_ONCE(iteration);
+		if (lockstep_iterations)
+			current_iteration = READ_ONCE(iteration);
+		else
+			current_iteration++;
 
 		clock_gettime(CLOCK_MONOTONIC, &start);
 		ret = _vcpu_run(vcpu);
@@ -118,13 +123,19 @@ static void vcpu_worker(struct memstress_vcpu_args *vcpu_args)
 				ts_diff.tv_nsec);
 		}
 
-		/*
-		 * Keep running the guest while dirty logging is being disabled
-		 * (iteration is negative) so that vCPUs are accessing memory
-		 * for the entire duration of zapping collapsible SPTEs.
-		 */
-		while (current_iteration == READ_ONCE(iteration) &&
-		       READ_ONCE(iteration) >= 0 && !READ_ONCE(host_quit)) {}
+		if (lockstep_iterations) {
+			/*
+			 * Keep running the guest while dirty logging is being disabled
+			 * (iteration is negative) so that vCPUs are accessing memory
+			 * for the entire duration of zapping collapsible SPTEs.
+			 */
+			while (current_iteration == READ_ONCE(iteration) &&
+			       READ_ONCE(iteration) >= 0 && !READ_ONCE(host_quit))
+				;
+		} else {
+			while (!READ_ONCE(iteration) && !READ_ONCE(host_quit))
+				;
+		}
 	}
 
 	avg = timespec_div(total, vcpu_last_completed_iteration[vcpu_idx]);
@@ -332,18 +343,20 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 		clock_gettime(CLOCK_MONOTONIC, &start);
 		iteration++;
 
-		pr_debug("Starting iteration %d\n", iteration);
-		for (i = 0; i < nr_vcpus; i++) {
-			while (READ_ONCE(vcpu_last_completed_iteration[i])
-			       != iteration)
-				;
+		if (lockstep_iterations) {
+			pr_debug("Starting iteration %d\n", iteration);
+			for (i = 0; i < nr_vcpus; i++) {
+				while (READ_ONCE(vcpu_last_completed_iteration[i])
+				       != iteration)
+					;
+			}
+
+			ts_diff = timespec_elapsed(start);
+			vcpu_dirty_total = timespec_add(vcpu_dirty_total, ts_diff);
+			pr_info("Iteration %d dirty memory time: %ld.%.9lds\n",
+				iteration, ts_diff.tv_sec, ts_diff.tv_nsec);
 		}
 
-		ts_diff = timespec_elapsed(start);
-		vcpu_dirty_total = timespec_add(vcpu_dirty_total, ts_diff);
-		pr_info("Iteration %d dirty memory time: %ld.%.9lds\n",
-			iteration, ts_diff.tv_sec, ts_diff.tv_nsec);
-
 		clock_gettime(CLOCK_MONOTONIC, &start);
 		get_dirty_log(vm, bitmaps, p->slots);
 		ts_diff = timespec_elapsed(start);
@@ -365,6 +378,10 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 		}
 	}
 
+	/* Block further vCPUs execution */
+	if (!lockstep_iterations)
+		WRITE_ONCE(iteration, 0);
+
 	/*
 	 * Run vCPUs while dirty logging is being disabled to stress disabling
 	 * in terms of both performance and correctness.  Opt-in via command
@@ -458,6 +475,10 @@ static void help(char *name)
 	       "     To leave the application task unpinned, drop the final entry:\n\n"
 	       "         ./dirty_log_perf_test -v 3 -c 22,23,24\n\n"
 	       "     (default: no pinning)\n");
+	printf(" -j: Execute vCPUs independent of dirty log iterations\n"
+	       "     Independent vCPUs execution will allow them to continuously\n"
+	       "     dirty memory while main thread is collecting and clearing\n"
+	       "     dirty logs in each iteration.\n");
 	printf(" -k: Specify the chunk size in which dirty memory gets cleared\n"
 	       "     in memslots in each iteration. If the size is bigger than\n"
 	       "     the memslot size then whole memslot is cleared in one call.\n"
@@ -492,10 +513,10 @@ int main(int argc, char *argv[])
 		kvm_check_cap(KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2);
 	dirty_log_manual_caps &= (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE |
 				  KVM_DIRTY_LOG_INITIALLY_SET);
-
+	lockstep_iterations = true;
 	guest_modes_append_default();
 
-	while ((opt = getopt(argc, argv, "ab:c:eghi:k:l:m:nop:r:s:v:x:w:")) != -1) {
+	while ((opt = getopt(argc, argv, "ab:c:eghi:jk:l:m:nop:r:s:v:x:w:")) != -1) {
 		switch (opt) {
 		case 'a':
 			p.random_access = true;
@@ -519,6 +540,9 @@ int main(int argc, char *argv[])
 		case 'i':
 			p.iterations = atoi_positive("Number of iterations", optarg);
 			break;
+		case 'j':
+			lockstep_iterations = false;
+			break;
 		case 'k':
 			p.clear_chunk_size = parse_size(optarg);
 			break;
-- 
2.41.0.rc0.172.g3f132b7071-goog

