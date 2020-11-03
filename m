Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE892A5AB7
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Nov 2020 00:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbgKCXuC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Nov 2020 18:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729713AbgKCXuC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Nov 2020 18:50:02 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AA0C061A48
        for <linux-kselftest@vger.kernel.org>; Tue,  3 Nov 2020 15:50:00 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id z125so13300089pfc.12
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Nov 2020 15:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=uBW2auPdOSAwZzADRtRwCWhLPOMkXY0uNAUgQvk02uA=;
        b=b0DIsj90UDtjq840xCjQLXmOn25ylqJ1klVR6pqkQ77hT+gWuDxjMIqcUbQ8qxr2kh
         Jw9EkemE5BqiweolIHhRF759Kn9Jucxo4M71JHf1eM+H/6LR8ZVuUQKR/MozHIi1xEEB
         Oef5Hqxy0OQ+BFeqLJ7JiflD0g/+h5skop6owPUJII23uIb1o8mElmWl9Rjjt+GYl8Xf
         c5FqY3/ICgZlunoC8FNnOMPIubHUVm07xFOWdx2PqsqzN2gwV1hnN7vGtNyIKlhRpiUO
         /IIH86sanyoCE0e+CeHWVhPIVSgL38mu/BWmE45sA62LusY4Y+fMuQ2zbjCROddvpZnb
         sCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uBW2auPdOSAwZzADRtRwCWhLPOMkXY0uNAUgQvk02uA=;
        b=RiTIhC0yGCM0Uo4MzrPBY3SJ1X4AMJHIYFfGT7ilcoUaxgC9kFsC2hjNx1TLpQvBDx
         pfwB3zeaBfSoCSWOvPglVF/Np+4foih8OdITpWzsS77O7md8ozdgNFwig3yhpQ0irrA8
         R1zpsZQo4Xg8xZfWKVB3PlSQPPjl/Hw7s6yyqGlcpoDkuJNwamigjDMiZFmvbbXL3tQT
         rFyjvMUsQHp494UfXdgwS5WjWmejvyQ3AIOIK1KsXob8Me+EyZRL2e0IhdXbG8U/5yMT
         BDE6vmnuuU4E8yvhhqEXF17pYOWa7Kn3sbGXtRNLVDc/wjuxNMHAGUs0YTxW/C8DvkQt
         CeRA==
X-Gm-Message-State: AOAM532QkClNV0NWWAUSbzVSbVHvedfRMVQ5h1W4Q+GYJNZZZjlNcFHA
        YnXLudmXY6t8sdOya+GQJNX8T4ndAneE
X-Google-Smtp-Source: ABdhPJz6c8hN9i6+sRwrj1TJ3rPbr1ZQTIqftoxqlKm+19gjFAsdjn/Uy8AYCRf3tOUYD/5CtX7OLx717ftT
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:a17:902:6f10:b029:d6:e6f5:1dab with SMTP
 id w16-20020a1709026f10b02900d6e6f51dabmr2581693plk.1.1604447400164; Tue, 03
 Nov 2020 15:50:00 -0800 (PST)
Date:   Tue,  3 Nov 2020 15:49:50 -0800
In-Reply-To: <20201103234952.1626730-1-bgardon@google.com>
Message-Id: <20201103234952.1626730-4-bgardon@google.com>
Mime-Version: 1.0
References: <20201103234952.1626730-1-bgardon@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v2 3/5] KVM: selftests: Simplify demand_paging_test with timespec_diff_now
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Huth <thuth@redhat.com>,
        Peter Feiner <pfeiner@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a helper function to get the current time and return the time since
a given start time. Use that function to simplify the timekeeping in the
demand paging test.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 .../selftests/kvm/demand_paging_test.c        | 26 +++++++++----------
 .../testing/selftests/kvm/include/test_util.h |  1 +
 tools/testing/selftests/kvm/lib/test_util.c   | 15 +++++++++--
 3 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 682805dd8c2ac..63ea7c06e1141 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -50,7 +50,8 @@ static void *vcpu_worker(void *data)
 	int vcpu_id = vcpu_args->vcpu_id;
 	struct kvm_vm *vm = perf_test_args.vm;
 	struct kvm_run *run;
-	struct timespec start, end, ts_diff;
+	struct timespec start;
+	struct timespec ts_diff;
 
 	vcpu_args_set(vm, vcpu_id, 1, vcpu_id);
 	run = vcpu_state(vm, vcpu_id);
@@ -66,8 +67,7 @@ static void *vcpu_worker(void *data)
 			    exit_reason_str(run->exit_reason));
 	}
 
-	clock_gettime(CLOCK_MONOTONIC, &end);
-	ts_diff = timespec_sub(end, start);
+	ts_diff = timespec_elapsed(start);
 	PER_VCPU_DEBUG("vCPU %d execution time: %ld.%.9lds\n", vcpu_id,
 		       ts_diff.tv_sec, ts_diff.tv_nsec);
 
@@ -78,7 +78,7 @@ static int handle_uffd_page_request(int uffd, uint64_t addr)
 {
 	pid_t tid;
 	struct timespec start;
-	struct timespec end;
+	struct timespec ts_diff;
 	struct uffdio_copy copy;
 	int r;
 
@@ -98,10 +98,10 @@ static int handle_uffd_page_request(int uffd, uint64_t addr)
 		return r;
 	}
 
-	clock_gettime(CLOCK_MONOTONIC, &end);
+	ts_diff = timespec_elapsed(start);
 
 	PER_PAGE_DEBUG("UFFDIO_COPY %d \t%ld ns\n", tid,
-		       timespec_to_ns(timespec_sub(end, start)));
+		       timespec_to_ns(ts_diff));
 	PER_PAGE_DEBUG("Paged in %ld bytes at 0x%lx from thread %d\n",
 		       perf_test_args.host_page_size, addr, tid);
 
@@ -123,7 +123,8 @@ static void *uffd_handler_thread_fn(void *arg)
 	int pipefd = uffd_args->pipefd;
 	useconds_t delay = uffd_args->delay;
 	int64_t pages = 0;
-	struct timespec start, end, ts_diff;
+	struct timespec start;
+	struct timespec ts_diff;
 
 	clock_gettime(CLOCK_MONOTONIC, &start);
 	while (!quit_uffd_thread) {
@@ -192,8 +193,7 @@ static void *uffd_handler_thread_fn(void *arg)
 		pages++;
 	}
 
-	clock_gettime(CLOCK_MONOTONIC, &end);
-	ts_diff = timespec_sub(end, start);
+	ts_diff = timespec_elapsed(start);
 	PER_VCPU_DEBUG("userfaulted %ld pages over %ld.%.9lds. (%f/sec)\n",
 		       pages, ts_diff.tv_sec, ts_diff.tv_nsec,
 		       pages / ((double)ts_diff.tv_sec + (double)ts_diff.tv_nsec / 100000000.0));
@@ -257,7 +257,8 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
 	pthread_t *vcpu_threads;
 	pthread_t *uffd_handler_threads = NULL;
 	struct uffd_handler_args *uffd_args = NULL;
-	struct timespec start, end, ts_diff;
+	struct timespec start;
+	struct timespec ts_diff;
 	int *pipefds = NULL;
 	struct kvm_vm *vm;
 	int vcpu_id;
@@ -330,9 +331,9 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
 		PER_VCPU_DEBUG("Joined thread for vCPU %d\n", vcpu_id);
 	}
 
-	pr_info("All vCPU threads joined\n");
+	ts_diff = timespec_elapsed(start);
 
-	clock_gettime(CLOCK_MONOTONIC, &end);
+	pr_info("All vCPU threads joined\n");
 
 	if (use_uffd) {
 		char c;
@@ -346,7 +347,6 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
 		}
 	}
 
-	ts_diff = timespec_sub(end, start);
 	pr_info("Total guest execution time: %ld.%.9lds\n",
 		ts_diff.tv_sec, ts_diff.tv_nsec);
 	pr_info("Overall demand paging rate: %f pgs/sec\n",
diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index 5eb01bf51b86f..a1564f98223d9 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -64,5 +64,6 @@ int64_t timespec_to_ns(struct timespec ts);
 struct timespec timespec_add_ns(struct timespec ts, int64_t ns);
 struct timespec timespec_add(struct timespec ts1, struct timespec ts2);
 struct timespec timespec_sub(struct timespec ts1, struct timespec ts2);
+struct timespec timespec_elapsed(struct timespec start);
 
 #endif /* SELFTEST_KVM_TEST_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index 689e97c27ee24..c2cee1ea20a31 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -4,10 +4,13 @@
  *
  * Copyright (C) 2020, Google LLC.
  */
-#include <stdlib.h>
+
+#include <assert.h>
 #include <ctype.h>
 #include <limits.h>
-#include <assert.h>
+#include <stdlib.h>
+#include <time.h>
+
 #include "test_util.h"
 
 /*
@@ -81,6 +84,14 @@ struct timespec timespec_sub(struct timespec ts1, struct timespec ts2)
 	return timespec_add_ns((struct timespec){0}, ns1 - ns2);
 }
 
+struct timespec timespec_elapsed(struct timespec start)
+{
+	struct timespec end;
+
+	clock_gettime(CLOCK_MONOTONIC, &end);
+	return timespec_sub(end, start);
+}
+
 void print_skip(const char *fmt, ...)
 {
 	va_list ap;
-- 
2.29.1.341.ge80a0c044ae-goog

