Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFFF3389775
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 May 2021 22:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhESUGC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 May 2021 16:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbhESUFa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 May 2021 16:05:30 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC38EC061344
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 13:04:09 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id x19-20020ac87a930000b02901f6125bcda0so5178540qtr.19
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 13:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xXgCU6klz4Kb+YHqzC+5neYZZ9NaeqBCOsxs5FJ97FE=;
        b=vNqIyxQ+FUKJ7FHgc8qfhecfMaZ7eQQApBy7O2IY+PqnuavcPnWHadRtHk+dAV7JfZ
         CwoQwViWE+q2peiegAVLSVoWdqiLmIRElRxXB57LPtx00HYnsfggHb9TdtcQHIxx4krV
         u9ZgD4eWrJ8JOwWyTxpHWcfPxulK/phsbPSZ0qm6Ob8RA24wxe7oXGiU6KiiVSEgNOeb
         NT8P0HJqM3BBHva7j1I5y/jmsycOZLnvI8hK+JnTo26HXhtd8P3UsJE/Dxylx6IeNiW0
         9rJOW3Vi8kLup5smn7lkxC/TRAACXFnun5C4JnhwCMjxjQiZC4WHYXvEh1loDwzfFEkw
         qKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xXgCU6klz4Kb+YHqzC+5neYZZ9NaeqBCOsxs5FJ97FE=;
        b=uPk46ttzgsLdPegLWFBFt8vLgeoKBwcdB/tkxrVb82QskKySxGKW8vcqhECG8oKLKx
         6kONRRu8kuxokzOjj9s+cT9XsKflad50rXqC8V6leSf0j206nWQUWuL3ruJF8GbPzOrC
         RfsJ1M+CJCULLDlDyLE0vumPWFiFtId2qAxoTFzgDyuJBAw0+7bIP86RGwuulwQrwl8V
         ObsAR8BQhdDuZyNeg23qG1gcMam9go+yPVxCJjxRHotT3+Mm5TEobvPz+d4C/Dhdvpi5
         2n/N2/qGPrEXBHGw65QIDDo5pGvwX8sj9q6k7jaeAsF7c4c385IoPnitp9mbpI+4Mcx8
         Mzqg==
X-Gm-Message-State: AOAM531G9QnOIwa45f/7IFz3lD8mCgEbEgcKziyTIo/hGUiy8UdYWuVL
        Y/6chEZUn1xYNLz5zSSt1LqvTJBLomtOseZtCiZv
X-Google-Smtp-Source: ABdhPJzKHNQQn4LgvSahjCmXI6WhdQgg4jsjKQSHm5wuUrz8cVOL1mmBYsQDpM9l3K/De0ndbUgjeya2eUhs8js/4F0y
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:7eb5:10bb:834a:d5ec])
 (user=axelrasmussen job=sendgmr) by 2002:ad4:5ecc:: with SMTP id
 jm12mr1301475qvb.5.1621454645877; Wed, 19 May 2021 13:04:05 -0700 (PDT)
Date:   Wed, 19 May 2021 13:03:38 -0700
In-Reply-To: <20210519200339.829146-1-axelrasmussen@google.com>
Message-Id: <20210519200339.829146-10-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210519200339.829146-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v2 09/10] KVM: selftests: allow using UFFD minor faults for
 demand paging
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
 .../selftests/kvm/demand_paging_test.c        | 112 ++++++++++++------
 1 file changed, 79 insertions(+), 33 deletions(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 01890a7b0155..df7190261923 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -74,33 +74,48 @@ static void *vcpu_worker(void *data)
 	return NULL;
 }
 
-static int handle_uffd_page_request(int uffd, uint64_t addr)
+static int handle_uffd_page_request(int uffd_mode, int uffd, uint64_t addr)
 {
-	pid_t tid;
+	pid_t tid = syscall(__NR_gettid);
 	struct timespec start;
 	struct timespec ts_diff;
-	struct uffdio_copy copy;
 	int r;
 
-	tid = syscall(__NR_gettid);
+	clock_gettime(CLOCK_MONOTONIC, &start);
 
-	copy.src = (uint64_t)guest_data_prototype;
-	copy.dst = addr;
-	copy.len = demand_paging_size;
-	copy.mode = 0;
+	if (uffd_mode == UFFDIO_REGISTER_MODE_MISSING) {
+		struct uffdio_copy copy;
 
-	clock_gettime(CLOCK_MONOTONIC, &start);
+		copy.src = (uint64_t)guest_data_prototype;
+		copy.dst = addr;
+		copy.len = demand_paging_size;
+		copy.mode = 0;
+
+		r = ioctl(uffd, UFFDIO_COPY, &copy);
+		if (r == -1) {
+			pr_info("Failed UFFDIO_COPY in 0x%lx from thread %d with errno: %d\n",
+				addr, tid, errno);
+			return r;
+		}
+	} else if (uffd_mode == UFFDIO_REGISTER_MODE_MINOR) {
+		struct uffdio_continue cont = {0};
+
+		cont.range.start = addr;
+		cont.range.len = demand_paging_size;
 
-	r = ioctl(uffd, UFFDIO_COPY, &copy);
-	if (r == -1) {
-		pr_info("Failed Paged in 0x%lx from thread %d with errno: %d\n",
-			addr, tid, errno);
-		return r;
+		r = ioctl(uffd, UFFDIO_CONTINUE, &cont);
+		if (r == -1) {
+			pr_info("Failed UFFDIO_CONTINUE in 0x%lx from thread %d with errno: %d\n",
+				addr, tid, errno);
+			return r;
+		}
+	} else {
+		TEST_FAIL("Invalid uffd mode %d", uffd_mode);
 	}
 
 	ts_diff = timespec_elapsed(start);
 
-	PER_PAGE_DEBUG("UFFDIO_COPY %d \t%ld ns\n", tid,
+	PER_PAGE_DEBUG("UFFD page-in %d \t%ld ns\n", tid,
 		       timespec_to_ns(ts_diff));
 	PER_PAGE_DEBUG("Paged in %ld bytes at 0x%lx from thread %d\n",
 		       demand_paging_size, addr, tid);
@@ -111,6 +126,7 @@ static int handle_uffd_page_request(int uffd, uint64_t addr)
 bool quit_uffd_thread;
 
 struct uffd_handler_args {
+	int uffd_mode;
 	int uffd;
 	int pipefd;
 	useconds_t delay;
@@ -187,7 +203,7 @@ static void *uffd_handler_thread_fn(void *arg)
 		if (delay)
 			usleep(delay);
 		addr =  msg.arg.pagefault.address;
-		r = handle_uffd_page_request(uffd, addr);
+		r = handle_uffd_page_request(uffd_args->uffd_mode, uffd, addr);
 		if (r < 0)
 			return NULL;
 		pages++;
@@ -203,13 +219,32 @@ static void *uffd_handler_thread_fn(void *arg)
 
 static void setup_demand_paging(struct kvm_vm *vm,
 				pthread_t *uffd_handler_thread, int pipefd,
-				useconds_t uffd_delay,
+				int uffd_mode, useconds_t uffd_delay,
 				struct uffd_handler_args *uffd_args,
-				void *hva, uint64_t len)
+				void *hva, void *alias, uint64_t len)
 {
+	bool is_minor = (uffd_mode == UFFDIO_REGISTER_MODE_MINOR);
 	int uffd;
 	struct uffdio_api uffdio_api;
 	struct uffdio_register uffdio_register;
+	uint64_t expected_ioctls = ((uint64_t) 1) << _UFFDIO_COPY;
+
+	PER_PAGE_DEBUG("Userfaultfd %s mode, faults resolved with %s\n",
+		       is_minor ? "MINOR" : "MISSING",
+		       is_minor ? "UFFDIO_CONINUE" : "UFFDIO_COPY");
+
+	/* In order to get minor faults, prefault via the alias. */
+	if (is_minor) {
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
 	TEST_ASSERT(uffd >= 0, "uffd creation failed, errno: %d", errno);
@@ -222,12 +257,13 @@ static void setup_demand_paging(struct kvm_vm *vm,
 
 	uffdio_register.range.start = (uint64_t)hva;
 	uffdio_register.range.len = len;
-	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
+	uffdio_register.mode = uffd_mode;
 	TEST_ASSERT(ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) != -1,
 		    "ioctl UFFDIO_REGISTER failed");
-	TEST_ASSERT((uffdio_register.ioctls & UFFD_API_RANGE_IOCTLS) ==
-		    UFFD_API_RANGE_IOCTLS, "unexpected userfaultfd ioctl set");
+	TEST_ASSERT((uffdio_register.ioctls & expected_ioctls) ==
+		    expected_ioctls, "missing userfaultfd ioctls");
 
+	uffd_args->uffd_mode = uffd_mode;
 	uffd_args->uffd = uffd;
 	uffd_args->pipefd = pipefd;
 	uffd_args->delay = uffd_delay;
@@ -239,7 +275,7 @@ static void setup_demand_paging(struct kvm_vm *vm,
 }
 
 struct test_params {
-	bool use_uffd;
+	int uffd_mode;
 	useconds_t uffd_delay;
 	enum vm_mem_backing_src_type src_type;
 	bool partition_vcpu_memory_access;
@@ -276,7 +312,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	perf_test_setup_vcpus(vm, nr_vcpus, guest_percpu_mem_size,
 			      p->partition_vcpu_memory_access);
 
-	if (p->use_uffd) {
+	if (p->uffd_mode) {
 		uffd_handler_threads =
 			malloc(nr_vcpus * sizeof(*uffd_handler_threads));
 		TEST_ASSERT(uffd_handler_threads, "Memory allocation failed");
@@ -290,6 +326,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 		for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++) {
 			vm_paddr_t vcpu_gpa;
 			void *vcpu_hva;
+			void *vcpu_alias;
 			uint64_t vcpu_mem_size;
 
 
@@ -304,8 +341,9 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 			PER_VCPU_DEBUG("Added VCPU %d with test mem gpa [%lx, %lx)\n",
 				       vcpu_id, vcpu_gpa, vcpu_gpa + vcpu_mem_size);
 
-			/* Cache the HVA pointer of the region */
+			/* Cache the host addresses of the region */
 			vcpu_hva = addr_gpa2hva(vm, vcpu_gpa);
+			vcpu_alias = addr_gpa2alias(vm, vcpu_gpa);
 
 			/*
 			 * Set up user fault fd to handle demand paging
@@ -316,8 +354,9 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 			TEST_ASSERT(!r, "Failed to set up pipefd");
 
 			setup_demand_paging(vm, &uffd_handler_threads[vcpu_id],
-					    pipefds[vcpu_id * 2], p->uffd_delay,
-					    &uffd_args[vcpu_id], vcpu_hva,
+					    pipefds[vcpu_id * 2], p->uffd_mode,
+					    p->uffd_delay, &uffd_args[vcpu_id],
+					    vcpu_hva, vcpu_alias,
 					    vcpu_mem_size);
 		}
 	}
@@ -346,7 +385,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 
 	pr_info("All vCPU threads joined\n");
 
-	if (p->use_uffd) {
+	if (p->uffd_mode) {
 		char c;
 
 		/* Tell the user fault fd handler threads to quit */
@@ -368,7 +407,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 
 	free(guest_data_prototype);
 	free(vcpu_threads);
-	if (p->use_uffd) {
+	if (p->uffd_mode) {
 		free(uffd_handler_threads);
 		free(uffd_args);
 		free(pipefds);
@@ -378,11 +417,11 @@ static void run_test(enum vm_guest_mode mode, void *arg)
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
@@ -409,13 +448,17 @@ int main(int argc, char *argv[])
 
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
@@ -442,6 +485,9 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	TEST_ASSERT(p.uffd_mode != UFFDIO_REGISTER_MODE_MINOR || p.src_type == VM_MEM_SRC_SHMEM,
+		    "userfaultfd MINOR mode requires shared memory; pick a different -t");
+
 	for_each_guest_mode(run_test, &p);
 
 	return 0;
-- 
2.31.1.751.gd2f1c929bd-goog

