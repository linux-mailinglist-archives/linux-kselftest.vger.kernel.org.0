Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59676121BFA
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2019 22:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfLPVjW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Dec 2019 16:39:22 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:45741 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbfLPVjV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Dec 2019 16:39:21 -0500
Received: by mail-pl1-f201.google.com with SMTP id b8so6277195plz.12
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Dec 2019 13:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=12xMY3S0k192hVkbotc53c72N/aodHQMjhfnDBGydPE=;
        b=T5biqIImkGRBkPX18/PrkrCxeDe93szhNMnb+3D0JNgeESLimO1xkTIPBsUyD57Ks9
         bPlWnegoJ2yGzjz7cD6hYo+gG3l1HRE6COccXQRZJuswHnC1Mncv3n8bOTZXTZElaFJO
         HqhYzy9prsndpUCnAwtNnq3NWrpKoXFuT2fcmD8IDkmIroM0pm4gFWHpXPbtMb4iEQQS
         GAIKxWppVywzbiLBmIvgtOVim9E1IlIAZy/J8PawRzee1gY2jRY95mtWvgtYzkW20zeW
         JAlMs4vNqqg/bk9HOJ+ueZ0d+h2uD2HDERcHNBu10cOxwumiA98zNbAIcY+lwL6uEHf4
         S8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=12xMY3S0k192hVkbotc53c72N/aodHQMjhfnDBGydPE=;
        b=Xkk/hDKYhe4Ds2pUp6VvSwDGiyQsLQiA4j+z1R1VZOi5VwZM0C19jS1anxQASPEfZE
         0CDr4Hpx1rhX1tuOheymVz1a074nB8a6e2XqLcnaa55svVxg4SnUiGqITfL4tbmVg3k3
         Bvt5y/4Jd1aFy10a8j4yoUNV1K3wrBRP0Y9bBqL0D49xNGmXk0bB0sEcS+ZJpy1IeLEU
         ri4VhKvnYhL7iFHnevsIbImUiPQs7+trkMCxsuKB1kULn5RucAvvXl35XVGolzrgCTQg
         nvkUeg5sMB+iW3X13OjD4VQq0y+0TVn6XDtDIPG0XsICCS3oE4umF4nlnHBSPYrwUd12
         W7ug==
X-Gm-Message-State: APjAAAVynex5Vzgh7EQhLo/Wh5/yKaqk/mkii8/+lWNQlD7j65Wz6AGu
        7lmnvXbrITUaXzgS+VqCOTr6O8fHzOOB
X-Google-Smtp-Source: APXvYqxu8EWj4aSN0HVlcfGqbsI23bzO4+co41jlCYLgSXYCGQAcDG2owM/AowODQb+ety9Od899WWR2Roav
X-Received: by 2002:a63:f910:: with SMTP id h16mr21432184pgi.148.1576532360444;
 Mon, 16 Dec 2019 13:39:20 -0800 (PST)
Date:   Mon, 16 Dec 2019 13:39:00 -0800
In-Reply-To: <20191216213901.106941-1-bgardon@google.com>
Message-Id: <20191216213901.106941-8-bgardon@google.com>
Mime-Version: 1.0
References: <20191216213901.106941-1-bgardon@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v3 7/8] KVM: selftests: Time guest demand paging
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In order to quantify demand paging performance, time guest execution
during demand paging.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 .../selftests/kvm/demand_paging_test.c        | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 2b80f614dd537..d93d72bdea4a3 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -32,6 +32,12 @@
 
 #define DEFAULT_GUEST_TEST_MEM_SIZE (1 << 30) /* 1G */
 
+#ifdef PRINT_PER_PAGE_UPDATES
+#define PER_PAGE_DEBUG(...) DEBUG(__VA_ARGS__)
+#else
+#define PER_PAGE_DEBUG(...)
+#endif
+
 #ifdef PRINT_PER_VCPU_UPDATES
 #define PER_VCPU_DEBUG(...) DEBUG(__VA_ARGS__)
 #else
@@ -62,6 +68,26 @@ static uint64_t guest_test_phys_mem;
  */
 static uint64_t guest_test_virt_mem = DEFAULT_GUEST_TEST_MEM;
 
+int64_t to_ns(struct timespec ts)
+{
+	return (int64_t)ts.tv_nsec + 1000000000LL * (int64_t)ts.tv_sec;
+}
+
+struct timespec diff(struct timespec start, struct  timespec end)
+{
+	struct   timespec temp;
+
+	if ((end.tv_nsec-start.tv_nsec) < 0) {
+		temp.tv_sec = end.tv_sec - start.tv_sec - 1;
+		temp.tv_nsec = 1000000000 + end.tv_nsec - start.tv_nsec;
+	} else {
+		temp.tv_sec = end.tv_sec - start.tv_sec;
+		temp.tv_nsec = end.tv_nsec - start.tv_nsec;
+	}
+
+	return temp;
+}
+
 /*
  * Continuously write to the first 8 bytes of each page in the demand paging
  * memory region.
@@ -96,11 +122,15 @@ static void *vcpu_worker(void *data)
 	uint64_t gva = args->gva;
 	uint64_t pages = args->pages;
 	struct kvm_run *run;
+	struct timespec start;
+	struct timespec end;
 
 	vcpu_args_set(vm, vcpu_id, 2, gva, pages);
 
 	run = vcpu_state(vm, vcpu_id);
 
+	clock_gettime(CLOCK_MONOTONIC, &start);
+
 	/* Let the guest access its memory */
 	ret = _vcpu_run(vm, vcpu_id);
 	TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);
@@ -110,6 +140,11 @@ static void *vcpu_worker(void *data)
 			    exit_reason_str(run->exit_reason));
 	}
 
+	clock_gettime(CLOCK_MONOTONIC, &end);
+	PER_VCPU_DEBUG("vCPU %d execution time: %lld.%.9lds\n", vcpu_id,
+		       (long long)(diff(start, end).tv_sec),
+		       diff(start, end).tv_nsec);
+
 	return NULL;
 }
 
@@ -145,6 +180,8 @@ static struct kvm_vm *create_vm(enum vm_guest_mode mode, int vcpus,
 static int handle_uffd_page_request(int uffd, uint64_t addr)
 {
 	pid_t tid;
+	struct timespec start;
+	struct timespec end;
 	struct uffdio_copy copy;
 	int r;
 
@@ -155,6 +192,8 @@ static int handle_uffd_page_request(int uffd, uint64_t addr)
 	copy.len = host_page_size;
 	copy.mode = 0;
 
+	clock_gettime(CLOCK_MONOTONIC, &start);
+
 	r = ioctl(uffd, UFFDIO_COPY, &copy);
 	if (r == -1) {
 		DEBUG("Failed Paged in 0x%lx from thread %d with errno: %d\n",
@@ -162,6 +201,13 @@ static int handle_uffd_page_request(int uffd, uint64_t addr)
 		return r;
 	}
 
+	clock_gettime(CLOCK_MONOTONIC, &end);
+
+	PER_PAGE_DEBUG("UFFDIO_COPY %d \t%lld ns\n", tid,
+		       (long long)to_ns(diff(start, end)));
+	PER_PAGE_DEBUG("Paged in %ld bytes at 0x%lx from thread %d\n",
+		       host_page_size, addr, tid);
+
 	return 0;
 }
 
@@ -178,7 +224,10 @@ static void *uffd_handler_thread_fn(void *arg)
 	int uffd = uffd_args->uffd;
 	useconds_t delay = uffd_args->delay;
 	int64_t pages = 0;
+	struct timespec start;
+	struct timespec end;
 
+	clock_gettime(CLOCK_MONOTONIC, &start);
 	while (!quit_uffd_thread) {
 		struct uffd_msg msg;
 		struct pollfd pollfd[1];
@@ -241,6 +290,13 @@ static void *uffd_handler_thread_fn(void *arg)
 		pages++;
 	}
 
+	clock_gettime(CLOCK_MONOTONIC, &end);
+	PER_VCPU_DEBUG("userfaulted %ld pages over %lld.%.9lds. (%f/sec)\n",
+		       pages, (long long)(diff(start, end).tv_sec),
+		       diff(start, end).tv_nsec, pages /
+		       ((double)diff(start, end).tv_sec +
+			(double)diff(start, end).tv_nsec / 100000000.0));
+
 	return NULL;
 }
 
@@ -303,6 +359,8 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
 	uint64_t guest_num_pages;
 	int vcpu_id;
 	int r;
+	struct timespec start;
+	struct timespec end;
 
 	vm = create_vm(mode, vcpus, vcpu_wss);
 
@@ -417,6 +475,8 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
 
 	DEBUG("Finished creating vCPUs and starting uffd threads\n");
 
+	clock_gettime(CLOCK_MONOTONIC, &start);
+
 	for (vcpu_id = 0; vcpu_id < vcpus; vcpu_id++) {
 		pthread_create(&vcpu_threads[vcpu_id], NULL, vcpu_worker,
 			       &vcpu_args[vcpu_id]);
@@ -432,6 +492,8 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
 
 	DEBUG("All vCPU threads joined\n");
 
+	clock_gettime(CLOCK_MONOTONIC, &end);
+
 	if (use_uffd) {
 		/* Tell the user fault fd handler threads to quit */
 		quit_uffd_thread = true;
@@ -439,6 +501,12 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
 			pthread_join(uffd_handler_threads[vcpu_id], NULL);
 	}
 
+	DEBUG("Total guest execution time: %lld.%.9lds\n",
+	      (long long)(diff(start, end).tv_sec), diff(start, end).tv_nsec);
+	DEBUG("Overall demand paging rate: %f pgs/sec\n",
+	      guest_num_pages / ((double)diff(start, end).tv_sec +
+	      (double)diff(start, end).tv_nsec / 100000000.0));
+
 	ucall_uninit(vm);
 	kvm_vm_free(vm);
 
-- 
2.24.1.735.g03f4e72817-goog

