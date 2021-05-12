Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E8237EF4E
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 May 2021 01:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347102AbhELXE2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 May 2021 19:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390026AbhELVtV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 May 2021 17:49:21 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F684C061265
        for <linux-kselftest@vger.kernel.org>; Wed, 12 May 2021 14:45:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id l8-20020a25b3080000b02904f8bd69022dso15912838ybj.9
        for <linux-kselftest@vger.kernel.org>; Wed, 12 May 2021 14:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EJQBBbq8T2xij9lh3CFyuCXf5mM7D9L45k9jrUHXiZc=;
        b=YiVzEi6+wA4fBCN/c8v7sDfYnPkF53baryHGg4LmUaTVhveP9MvX7irBGlqwM0xu8K
         C03rWLn/QpT5XV0TbbrilmYx8cvF0PV/NjoZQZKGia4UovN5jCTU+fCy0LiPzWKRwLkp
         paDdLz4/NKyWU8qCT8boymH/VA5VRll0EhEnpoOtS2YvWJZvSoo/lef0Iu0Fbq0SCsVG
         QP6n2m3Hi0BuPlLYMOroTHb/QjJy6o9Gp4g45Rvn1tCxbkD+a2TytSwc2oAF9/sOoH1t
         LzIEjMucrYRhZz8OSMJC7a9EIs86k3JmCR088AnPGpiLD/D+W37PnscfOEqEshLrz2Nf
         LvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EJQBBbq8T2xij9lh3CFyuCXf5mM7D9L45k9jrUHXiZc=;
        b=P2lzZo+ZcGXewcoO8y1SqjyAYxXuQ/V3MCFYLmnsqIO1lDqjN70uaW0A0VFUvVbrD0
         t1kZSwb5s1CWYfHaQDG+D19WNx85wy9eeKGHTLGpBjFiEgD8vyEwpcnpl5+MzicXFNe5
         pWVeVb8KviquckoPJSK+5LXUkGgcxquj9cXn18DRuBUMSazpLRfOk67zn5KP7xLfRPyN
         tDNtdVC5PAw6u76q6QmNUj+gkMtx9z6APGrYcM7ZIRalmt2ScbtTw3QyCUajqrI+iNFg
         h9TQ1INjKRL4XojauoYvDthcX0dOp5PwhM8wj/vQmWp5NsxqK6QqRXVmpAdjIhp4Cbwl
         f+Dw==
X-Gm-Message-State: AOAM530QtNcjhYACsoPgQ44XRvFO/3QarXcm6ERrkTLBAVxnKaXS6BZR
        TvNXma5tgSaUEcLWRQQ5yYFouW1EatIRVIyb1jZ/
X-Google-Smtp-Source: ABdhPJzn6CgTuxWq8M+xnzJR0A/UDuL40gKKVk5BtA8lewE6oBhQJs4WJlYlHQO1ZZl9IMMLNSi2ecvDYOgeJNKRbQpz
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:29e5:10fc:1128:b0c0])
 (user=axelrasmussen job=sendgmr) by 2002:a25:3bc9:: with SMTP id
 i192mr22991429yba.72.1620855913405; Wed, 12 May 2021 14:45:13 -0700 (PDT)
Date:   Wed, 12 May 2021 14:45:01 -0700
In-Reply-To: <20210512214502.2047008-1-axelrasmussen@google.com>
Message-Id: <20210512214502.2047008-5-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210512214502.2047008-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH 4/5] KVM: selftests: allow using UFFD minor faults for demand paging
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Aaron Lewis <aaronlewis@google.com>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Gardon <bgardon@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Xu <jacobhxu@google.com>,
        Makarand Sonare <makarandsonare@google.com>,
        Oliver Upton <oupton@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Yanan Wang <wangyanan55@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

UFFD handling of MINOR faults is a new feature whose use case is to
speed up demand paging (compared to MISSING faults). So, it's
interesting to let this selftest exercise this new mode.

Modify the demand paging test to have the option of using UFFD minor
faults, as opposed to missing faults. Now, when turning on userfaultfd
with '-u', the desired mode has to be specified ("MISSING" or "MINOR").

If we're in minor mode, before registering, prefault via the *alias*.
This way, the guest will trigger minor faults, instead of missing
faults, and we can UFFDIO_CONTINUE to resolve them.

Modify the page fault handler function to use the right ioctl depending
on the mode we're running in. In MINOR mode, use UFFDIO_CONTINUE.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 .../selftests/kvm/demand_paging_test.c        | 124 ++++++++++++------
 1 file changed, 87 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 10c7ba76a9c6..ff29aaea3120 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -72,33 +72,57 @@ static void *vcpu_worker(void *data)
 	return NULL;
 }
 
-static int handle_uffd_page_request(int uffd, uint64_t addr)
+static int handle_uffd_page_request(int uffd_mode, int uffd, uint64_t addr)
 {
-	pid_t tid;
+	const char *ioctl_name;
+	pid_t tid = syscall(__NR_gettid);
 	struct timespec start;
 	struct timespec ts_diff;
-	struct uffdio_copy copy;
 	int r;
 
-	tid = syscall(__NR_gettid);
+	if (uffd_mode == UFFDIO_REGISTER_MODE_MISSING) {
+		struct uffdio_copy copy;
 
-	copy.src = (uint64_t)guest_data_prototype;
-	copy.dst = addr;
-	copy.len = demand_paging_size;
-	copy.mode = 0;
+		ioctl_name = "UFFDIO_COPY";
 
-	clock_gettime(CLOCK_MONOTONIC, &start);
+		copy.src = (uint64_t)guest_data_prototype;
+		copy.dst = addr;
+		copy.len = demand_paging_size;
+		copy.mode = 0;
 
-	r = ioctl(uffd, UFFDIO_COPY, &copy);
-	if (r == -1) {
-		pr_info("Failed Paged in 0x%lx from thread %d with errno: %d\n",
-			addr, tid, errno);
-		return r;
-	}
+		clock_gettime(CLOCK_MONOTONIC, &start);
 
-	ts_diff = timespec_elapsed(start);
+		r = ioctl(uffd, UFFDIO_COPY, &copy);
+		if (r == -1) {
+			pr_info("Failed UFFDIO_COPY in 0x%lx from thread %d with errno: %d\n",
+				addr, tid, errno);
+			return r;
+		}
+
+		ts_diff = timespec_elapsed(start);
+	} else if (uffd_mode == UFFDIO_REGISTER_MODE_MINOR) {
+		struct uffdio_continue cont = {0};
+
+		ioctl_name = "UFFDIO_CONTINUE";
+
+		cont.range.start = addr;
+		cont.range.len = demand_paging_size;
+
+		clock_gettime(CLOCK_MONOTONIC, &start);
+
+		r = ioctl(uffd, UFFDIO_CONTINUE, &cont);
+		if (r == -1) {
+			pr_info("Failed UFFDIO_CONTINUE in 0x%lx from thread %d with errno: %d\n",
+				addr, tid, errno);
+			return r;
+		}
 
-	PER_PAGE_DEBUG("UFFDIO_COPY %d \t%ld ns\n", tid,
+		ts_diff = timespec_elapsed(start);
+	} else {
+		TEST_FAIL("Invalid uffd mode %d", uffd_mode);
+	}
+
+	PER_PAGE_DEBUG("%s %d \t%ld ns\n", ioctl_name, tid,
 		       timespec_to_ns(ts_diff));
 	PER_PAGE_DEBUG("Paged in %ld bytes at 0x%lx from thread %d\n",
 		       demand_paging_size, addr, tid);
@@ -109,6 +133,7 @@ static int handle_uffd_page_request(int uffd, uint64_t addr)
 bool quit_uffd_thread;
 
 struct uffd_handler_args {
+	int uffd_mode;
 	int uffd;
 	int pipefd;
 	useconds_t delay;
@@ -170,7 +195,7 @@ static void *uffd_handler_thread_fn(void *arg)
 		if (r == -1) {
 			if (errno == EAGAIN)
 				continue;
-			pr_info("Read of uffd gor errno %d", errno);
+			pr_info("Read of uffd got errno %d\n", errno);
 			return NULL;
 		}
 
@@ -185,7 +210,7 @@ static void *uffd_handler_thread_fn(void *arg)
 		if (delay)
 			usleep(delay);
 		addr =  msg.arg.pagefault.address;
-		r = handle_uffd_page_request(uffd, addr);
+		r = handle_uffd_page_request(uffd_args->uffd_mode, uffd, addr);
 		if (r < 0)
 			return NULL;
 		pages++;
@@ -201,17 +226,32 @@ static void *uffd_handler_thread_fn(void *arg)
 
 static int setup_demand_paging(struct kvm_vm *vm,
 			       pthread_t *uffd_handler_thread, int pipefd,
+			       int uffd_mode,
 			       useconds_t uffd_delay,
 			       struct uffd_handler_args *uffd_args,
-			       void *hva, uint64_t len)
+			       void *hva, void *alias, uint64_t len)
 {
 	int uffd;
 	struct uffdio_api uffdio_api;
 	struct uffdio_register uffdio_register;
+	uint64_t expected_ioctls = ((uint64_t) 1) << _UFFDIO_COPY;
+
+	/* In order to get minor faults, prefault via the alias. */
+	if (uffd_mode == UFFDIO_REGISTER_MODE_MINOR) {
+		size_t p;
+
+		expected_ioctls = ((uint64_t) 1) << _UFFDIO_CONTINUE;
+
+		TEST_ASSERT(alias != NULL, "Alias required for minor faults");
+		for (p = 0; p < (len / demand_paging_size); ++p) {
+			memcpy(alias + (p * demand_paging_size),
+			       guest_data_prototype, demand_paging_size);
+		}
+	}
 
 	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
 	if (uffd == -1) {
-		pr_info("uffd creation failed\n");
+		pr_info("uffd creation failed, errno: %d\n", errno);
 		return -1;
 	}
 
@@ -224,18 +264,18 @@ static int setup_demand_paging(struct kvm_vm *vm,
 
 	uffdio_register.range.start = (uint64_t)hva;
 	uffdio_register.range.len = len;
-	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
+	uffdio_register.mode = uffd_mode;
 	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) == -1) {
 		pr_info("ioctl uffdio_register failed\n");
 		return -1;
 	}
 
-	if ((uffdio_register.ioctls & UFFD_API_RANGE_IOCTLS) !=
-			UFFD_API_RANGE_IOCTLS) {
-		pr_info("unexpected userfaultfd ioctl set\n");
+	if ((uffdio_register.ioctls & expected_ioctls) != expected_ioctls) {
+		pr_info("missing userfaultfd ioctls\n");
 		return -1;
 	}
 
+	uffd_args->uffd_mode = uffd_mode;
 	uffd_args->uffd = uffd;
 	uffd_args->pipefd = pipefd;
 	uffd_args->delay = uffd_delay;
@@ -249,7 +289,7 @@ static int setup_demand_paging(struct kvm_vm *vm,
 }
 
 struct test_params {
-	bool use_uffd;
+	int uffd_mode;
 	useconds_t uffd_delay;
 	enum vm_mem_backing_src_type src_type;
 	bool partition_vcpu_memory_access;
@@ -286,7 +326,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	perf_test_setup_vcpus(vm, nr_vcpus, guest_percpu_mem_size,
 			      p->partition_vcpu_memory_access);
 
-	if (p->use_uffd) {
+	if (p->uffd_mode) {
 		uffd_handler_threads =
 			malloc(nr_vcpus * sizeof(*uffd_handler_threads));
 		TEST_ASSERT(uffd_handler_threads, "Memory allocation failed");
@@ -300,6 +340,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 		for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++) {
 			vm_paddr_t vcpu_gpa;
 			void *vcpu_hva;
+			void *vcpu_alias;
 			uint64_t vcpu_mem_size;
 
 
@@ -314,8 +355,9 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 			PER_VCPU_DEBUG("Added VCPU %d with test mem gpa [%lx, %lx)\n",
 				       vcpu_id, vcpu_gpa, vcpu_gpa + vcpu_mem_size);
 
-			/* Cache the HVA pointer of the region */
+			/* Cache the host addresses of the region */
 			vcpu_hva = addr_gpa2hva(vm, vcpu_gpa);
+			vcpu_alias = addr_gpa2alias(vm, vcpu_gpa);
 
 			/*
 			 * Set up user fault fd to handle demand paging
@@ -327,9 +369,10 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 
 			r = setup_demand_paging(vm,
 						&uffd_handler_threads[vcpu_id],
-						pipefds[vcpu_id * 2],
+						pipefds[vcpu_id * 2], p->uffd_mode,
 						p->uffd_delay, &uffd_args[vcpu_id],
-						vcpu_hva, vcpu_mem_size);
+						vcpu_hva, vcpu_alias,
+						vcpu_mem_size);
 			if (r < 0)
 				exit(-r);
 		}
@@ -359,7 +402,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 
 	pr_info("All vCPU threads joined\n");
 
-	if (p->use_uffd) {
+	if (p->uffd_mode) {
 		char c;
 
 		/* Tell the user fault fd handler threads to quit */
@@ -381,7 +424,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 
 	free(guest_data_prototype);
 	free(vcpu_threads);
-	if (p->use_uffd) {
+	if (p->uffd_mode) {
 		free(uffd_handler_threads);
 		free(uffd_args);
 		free(pipefds);
@@ -391,11 +434,11 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 static void help(char *name)
 {
 	puts("");
-	printf("usage: %s [-h] [-m mode] [-u] [-d uffd_delay_usec]\n"
+	printf("usage: %s [-h] [-m mode] [-u mode] [-d uffd_delay_usec]\n"
 	       "          [-b memory] [-t type] [-v vcpus] [-o]\n", name);
 	guest_modes_help();
-	printf(" -u: use User Fault FD to handle vCPU page\n"
-	       "     faults.\n");
+	printf(" -u: use userfaultfd to handle vCPU page faults. Mode is a\n"
+	       "     UFFD registration mode: 'MISSING' or 'MINOR'.\n");
 	printf(" -d: add a delay in usec to the User Fault\n"
 	       "     FD handler to simulate demand paging\n"
 	       "     overheads. Ignored without -u.\n");
@@ -422,13 +465,17 @@ int main(int argc, char *argv[])
 
 	guest_modes_append_default();
 
-	while ((opt = getopt(argc, argv, "hm:ud:b:t:v:o")) != -1) {
+	while ((opt = getopt(argc, argv, "hm:u:d:b:t:v:o")) != -1) {
 		switch (opt) {
 		case 'm':
 			guest_modes_cmdline(optarg);
 			break;
 		case 'u':
-			p.use_uffd = true;
+			if (!strcmp("MISSING", optarg))
+				p.uffd_mode = UFFDIO_REGISTER_MODE_MISSING;
+			else if (!strcmp("MINOR", optarg))
+				p.uffd_mode = UFFDIO_REGISTER_MODE_MINOR;
+			TEST_ASSERT(p.uffd_mode, "UFFD mode must be 'MISSING' or 'MINOR'.");
 			break;
 		case 'd':
 			p.uffd_delay = strtoul(optarg, NULL, 0);
@@ -455,6 +502,9 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	TEST_ASSERT(p.uffd_mode != UFFDIO_REGISTER_MODE_MINOR || p.src_type == VM_MEM_SRC_SHMEM,
+		    "userfaultfd MINOR mode requires shared memory; pick a different -t");
+
 	for_each_guest_mode(run_test, &p);
 
 	return 0;
-- 
2.31.1.607.g51e8a6a459-goog

