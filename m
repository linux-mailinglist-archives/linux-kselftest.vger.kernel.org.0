Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61CEB14705C
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2020 19:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbgAWSFQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jan 2020 13:05:16 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:43879 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729273AbgAWSE7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jan 2020 13:04:59 -0500
Received: by mail-pg1-f201.google.com with SMTP id d9so2231508pgd.10
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2020 10:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zQsk+O6KeZ1NWUkCto7Wkzwr5mCAi8+GMe3pWZCtfx8=;
        b=D3gvjm8Hkjs/fWfSh6hd6ba41HjLwDycYiddKOlsYEF6zj+FGkMXQJQc0JmNr6VTUz
         NGK3/iIJEQyCffEaFO+BW+BxznvvpQs7Lu2JWgirdMxaptDvO+csVJpsebDPQNV6BAqC
         a6SLSg9LMxrJlf+nW4uQ4WC2+1Pu1W0R0tgrhvvVSpRmOuL7QywtaevwMvMu4mHojDm0
         OCGNRT1lVxP2RXK2JXBDucXxizNqM3wiWr5de2ivVUfxLZsqolidtIFuV2vY/PB1bK9z
         73vedQ2wKGzIS770ADhiR6jVpPx/ERuhasYk/QkZm9ZkrPBGJifPNf57ZHs+5ihmGESF
         6XpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zQsk+O6KeZ1NWUkCto7Wkzwr5mCAi8+GMe3pWZCtfx8=;
        b=FPucLJIXe3BwMGeUnnLBmETAspaVsjkM4SYAu9nityRiFizUQ1TzPonqN6pD+wWx+4
         HL8A2kntXp6XTZ/8Tzo8lNNa3V9NuipH1Mvin1r76w5f2xQmxALJeoT+/G6T0oIo6M7F
         ktSmuU7lc+WG5JMmoxK6djUkbUjs1FCRVQyAREi5Uwst6DxwzCcVpRjLiHGDlxoqbbqq
         yENsJgf75LQ2HaZILSct3EyN3J8x7YDCzZ0LK5LxQbzjkGyfdq+uUWhHYXi9P+hY3v7k
         7KAseKoZkYzvzbpPkcH6/fZZKEEfbB42FFQ7CQzejYRDGyDz/SAueybuNWTBjV/WBD1H
         XqdQ==
X-Gm-Message-State: APjAAAVMCIXG2lRqHnLa63f69Db9hozl5+tioUGhFS0tU8XFZn2Y7ziF
        I6kXQz8+KDEngbgLuAvjHL8r9hj9wUtL
X-Google-Smtp-Source: APXvYqybxeibSo2GtbUigxYXRUWl5nVrUrZ2sWGnT63r8bM/diDvzZiwn87GrhTSWXC/GK8UOe4Z/8U1Lpgn
X-Received: by 2002:a63:6d0e:: with SMTP id i14mr34255pgc.12.1579802698334;
 Thu, 23 Jan 2020 10:04:58 -0800 (PST)
Date:   Thu, 23 Jan 2020 10:04:34 -0800
In-Reply-To: <20200123180436.99487-1-bgardon@google.com>
Message-Id: <20200123180436.99487-9-bgardon@google.com>
Mime-Version: 1.0
References: <20200123180436.99487-1-bgardon@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v4 08/10] KVM: selftests: Time guest demand paging
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
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
index 2002032df32cc..0dc5d04718678 100644
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
@@ -64,6 +70,26 @@ static uint64_t guest_test_phys_mem;
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
 struct vcpu_args {
 	uint64_t gva;
 	uint64_t pages;
@@ -109,10 +135,14 @@ static void *vcpu_worker(void *data)
 	struct kvm_vm *vm = args->vm;
 	int vcpu_id = args->vcpu_id;
 	struct kvm_run *run;
+	struct timespec start;
+	struct timespec end;
 
 	vcpu_args_set(vm, vcpu_id, 1, vcpu_id);
 	run = vcpu_state(vm, vcpu_id);
 
+	clock_gettime(CLOCK_MONOTONIC, &start);
+
 	/* Let the guest access its memory */
 	ret = _vcpu_run(vm, vcpu_id);
 	TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);
@@ -122,6 +152,11 @@ static void *vcpu_worker(void *data)
 			    exit_reason_str(run->exit_reason));
 	}
 
+	clock_gettime(CLOCK_MONOTONIC, &end);
+	PER_VCPU_DEBUG("vCPU %d execution time: %lld.%.9lds\n", vcpu_id,
+		       (long long)(diff(start, end).tv_sec),
+		       diff(start, end).tv_nsec);
+
 	return NULL;
 }
 
@@ -158,6 +193,8 @@ static struct kvm_vm *create_vm(enum vm_guest_mode mode, int vcpus,
 static int handle_uffd_page_request(int uffd, uint64_t addr)
 {
 	pid_t tid;
+	struct timespec start;
+	struct timespec end;
 	struct uffdio_copy copy;
 	int r;
 
@@ -168,6 +205,8 @@ static int handle_uffd_page_request(int uffd, uint64_t addr)
 	copy.len = host_page_size;
 	copy.mode = 0;
 
+	clock_gettime(CLOCK_MONOTONIC, &start);
+
 	r = ioctl(uffd, UFFDIO_COPY, &copy);
 	if (r == -1) {
 		DEBUG("Failed Paged in 0x%lx from thread %d with errno: %d\n",
@@ -175,6 +214,13 @@ static int handle_uffd_page_request(int uffd, uint64_t addr)
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
 
@@ -193,7 +239,10 @@ static void *uffd_handler_thread_fn(void *arg)
 	int pipefd = uffd_args->pipefd;
 	useconds_t delay = uffd_args->delay;
 	int64_t pages = 0;
+	struct timespec start;
+	struct timespec end;
 
+	clock_gettime(CLOCK_MONOTONIC, &start);
 	while (!quit_uffd_thread) {
 		struct uffd_msg msg;
 		struct pollfd pollfd[2];
@@ -261,6 +310,13 @@ static void *uffd_handler_thread_fn(void *arg)
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
 
@@ -325,6 +381,8 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
 	uint64_t guest_num_pages;
 	int vcpu_id;
 	int r;
+	struct timespec start;
+	struct timespec end;
 
 	vm = create_vm(mode, vcpus, vcpu_memory_bytes);
 
@@ -449,6 +507,8 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
 
 	DEBUG("Finished creating vCPUs and starting uffd threads\n");
 
+	clock_gettime(CLOCK_MONOTONIC, &start);
+
 	for (vcpu_id = 0; vcpu_id < vcpus; vcpu_id++) {
 		pthread_create(&vcpu_threads[vcpu_id], NULL, vcpu_worker,
 			       &vcpu_args[vcpu_id]);
@@ -464,6 +524,8 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
 
 	DEBUG("All vCPU threads joined\n");
 
+	clock_gettime(CLOCK_MONOTONIC, &end);
+
 	if (use_uffd) {
 		char c;
 
@@ -476,6 +538,12 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
 		}
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
2.25.0.341.g760bfbb309-goog

