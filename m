Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28022F3D92
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jan 2021 01:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732892AbhALVoC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Jan 2021 16:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733146AbhALVn6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Jan 2021 16:43:58 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92121C0617BE
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Jan 2021 13:43:03 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id x64so67307yba.23
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Jan 2021 13:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=QesXjU8b1dHyvLy/TubleiHBc9h4FBDuAQnl/uZ5MtQ=;
        b=kbYf2CU35PRWQho9pYs5dH+xvLWBEOhB+l+RXMA6rL2UwKnFHlFdPahz6Et8cbS4EO
         AApERsLHBYn9nyVPLvgrdkoJjNZlfWR/PF9MBgTvs6eH4PYfZM89O/LR8R8stzy4YyHu
         /AwOKH3pkP3F6epxE0ZzhzkQpgq+UnOHiIJqYgFz7VZvjFCnxiV02ndnxyRkgJdQQTVx
         ngPiLN97VsnKkQUa+0tXlawzxFHfFTKnpFlubO17fDagV1Mj1Nl8EJeAkeF7ARrKmnmZ
         IEIwVzjZhSTTJLeCW/lxoWf83OFoR57KhuZrYCUUr5lU945ysFpiUJwNd2Hho1zApzJ9
         dcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QesXjU8b1dHyvLy/TubleiHBc9h4FBDuAQnl/uZ5MtQ=;
        b=tgJUd/GUKYN8qhIPYoYoRClJHA08/Fi+fx0swdEhHFf/q+PQYI1qAqoOXkAirB02k7
         Yczup4YPbNoSz7y1zeOUePT1QvtfZQY/VKUN0WYzvZpXtl40vFuGGyYU16RLpGoaK2ry
         xTfO3rec4cOi2L4olfCyb8ByMeB5IXzXV1uuR/L+nODOzvj/CSZxukvl9QUhTUjY7IL8
         gWaICM7DaZlLgBf8ZzcwKNCtzVcpPVj6EiJjKUt3KMh8P/bOHS7GK/RUkt21z86Am8Kt
         nluYnAnfzM/9XcV8bpJTik0ek3+UQBA4bygWt7ehZStkiEw/BPPzGMXanNe3hPl2v+KQ
         mgiA==
X-Gm-Message-State: AOAM530knhoAo27RcWqjp3nXRW5EyWBFnDizAq/eTwOJzGSD+9h7LSwk
        eZL/e5LFvlRFxqRkF+A9ezqdbOOJHYdM
X-Google-Smtp-Source: ABdhPJxM/RMdfYC4s6KuwnYuG2v9RBQprCahhsWA2zJ3lBz3mnKteeAAsA6CHiFsY/USr4csAyrs9HlEMIg8
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:a25:1241:: with SMTP id
 62mr2347892ybs.366.1610487782652; Tue, 12 Jan 2021 13:43:02 -0800 (PST)
Date:   Tue, 12 Jan 2021 13:42:50 -0800
In-Reply-To: <20210112214253.463999-1-bgardon@google.com>
Message-Id: <20210112214253.463999-4-bgardon@google.com>
Mime-Version: 1.0
References: <20210112214253.463999-1-bgardon@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 3/6] KVM: selftests: Convert iterations to int in dirty_log_perf_test
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Huth <thuth@redhat.com>, Jacob Xu <jacobhxu@google.com>,
        Makarand Sonare <makarandsonare@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In order to add an iteration -1 to indicate that the memory population
phase has not yet completed, convert the interations counters to ints.

No functional change intended.

Reviewed-by: Jacob Xu <jacobhxu@google.com>

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 .../selftests/kvm/dirty_log_perf_test.c       | 26 +++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
index 15a9c45bdb5f..3875f22d7283 100644
--- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
@@ -28,8 +28,8 @@ static uint64_t guest_percpu_mem_size = DEFAULT_PER_VCPU_MEM_SIZE;
 /* Host variables */
 static u64 dirty_log_manual_caps;
 static bool host_quit;
-static uint64_t iteration;
-static uint64_t vcpu_last_completed_iteration[KVM_MAX_VCPUS];
+static int iteration;
+static int vcpu_last_completed_iteration[KVM_MAX_VCPUS];
 
 static void *vcpu_worker(void *data)
 {
@@ -48,7 +48,7 @@ static void *vcpu_worker(void *data)
 	run = vcpu_state(vm, vcpu_id);
 
 	while (!READ_ONCE(host_quit)) {
-		uint64_t current_iteration = READ_ONCE(iteration);
+		int current_iteration = READ_ONCE(iteration);
 
 		clock_gettime(CLOCK_MONOTONIC, &start);
 		ret = _vcpu_run(vm, vcpu_id);
@@ -61,17 +61,17 @@ static void *vcpu_worker(void *data)
 
 		pr_debug("Got sync event from vCPU %d\n", vcpu_id);
 		vcpu_last_completed_iteration[vcpu_id] = current_iteration;
-		pr_debug("vCPU %d updated last completed iteration to %lu\n",
+		pr_debug("vCPU %d updated last completed iteration to %d\n",
 			 vcpu_id, vcpu_last_completed_iteration[vcpu_id]);
 
 		if (current_iteration) {
 			pages_count += vcpu_args->pages;
 			total = timespec_add(total, ts_diff);
-			pr_debug("vCPU %d iteration %lu dirty memory time: %ld.%.9lds\n",
+			pr_debug("vCPU %d iteration %d dirty memory time: %ld.%.9lds\n",
 				vcpu_id, current_iteration, ts_diff.tv_sec,
 				ts_diff.tv_nsec);
 		} else {
-			pr_debug("vCPU %d iteration %lu populate memory time: %ld.%.9lds\n",
+			pr_debug("vCPU %d iteration %d populate memory time: %ld.%.9lds\n",
 				vcpu_id, current_iteration, ts_diff.tv_sec,
 				ts_diff.tv_nsec);
 		}
@@ -81,7 +81,7 @@ static void *vcpu_worker(void *data)
 	}
 
 	avg = timespec_div(total, vcpu_last_completed_iteration[vcpu_id]);
-	pr_debug("\nvCPU %d dirtied 0x%lx pages over %lu iterations in %ld.%.9lds. (Avg %ld.%.9lds/iteration)\n",
+	pr_debug("\nvCPU %d dirtied 0x%lx pages over %d iterations in %ld.%.9lds. (Avg %ld.%.9lds/iteration)\n",
 		vcpu_id, pages_count, vcpu_last_completed_iteration[vcpu_id],
 		total.tv_sec, total.tv_nsec, avg.tv_sec, avg.tv_nsec);
 
@@ -144,7 +144,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	}
 
 	/* Allow the vCPU to populate memory */
-	pr_debug("Starting iteration %lu - Populating\n", iteration);
+	pr_debug("Starting iteration %d - Populating\n", iteration);
 	while (READ_ONCE(vcpu_last_completed_iteration[vcpu_id]) != iteration)
 		;
 
@@ -168,7 +168,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 		clock_gettime(CLOCK_MONOTONIC, &start);
 		iteration++;
 
-		pr_debug("Starting iteration %lu\n", iteration);
+		pr_debug("Starting iteration %d\n", iteration);
 		for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++) {
 			while (READ_ONCE(vcpu_last_completed_iteration[vcpu_id])
 			       != iteration)
@@ -177,7 +177,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 
 		ts_diff = timespec_elapsed(start);
 		vcpu_dirty_total = timespec_add(vcpu_dirty_total, ts_diff);
-		pr_info("Iteration %lu dirty memory time: %ld.%.9lds\n",
+		pr_info("Iteration %d dirty memory time: %ld.%.9lds\n",
 			iteration, ts_diff.tv_sec, ts_diff.tv_nsec);
 
 		clock_gettime(CLOCK_MONOTONIC, &start);
@@ -186,7 +186,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 		ts_diff = timespec_elapsed(start);
 		get_dirty_log_total = timespec_add(get_dirty_log_total,
 						   ts_diff);
-		pr_info("Iteration %lu get dirty log time: %ld.%.9lds\n",
+		pr_info("Iteration %d get dirty log time: %ld.%.9lds\n",
 			iteration, ts_diff.tv_sec, ts_diff.tv_nsec);
 
 		if (dirty_log_manual_caps) {
@@ -197,7 +197,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 			ts_diff = timespec_elapsed(start);
 			clear_dirty_log_total = timespec_add(clear_dirty_log_total,
 							     ts_diff);
-			pr_info("Iteration %lu clear dirty log time: %ld.%.9lds\n",
+			pr_info("Iteration %d clear dirty log time: %ld.%.9lds\n",
 				iteration, ts_diff.tv_sec, ts_diff.tv_nsec);
 		}
 	}
@@ -273,7 +273,7 @@ int main(int argc, char *argv[])
 	while ((opt = getopt(argc, argv, "hi:p:m:b:f:v:")) != -1) {
 		switch (opt) {
 		case 'i':
-			p.iterations = strtol(optarg, NULL, 10);
+			p.iterations = atoi(optarg);
 			break;
 		case 'p':
 			p.phys_offset = strtoull(optarg, NULL, 0);
-- 
2.30.0.284.gd98b1dd5eaa7-goog

