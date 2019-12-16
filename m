Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 095C0121C03
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2019 22:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfLPVjL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Dec 2019 16:39:11 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:49909 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727283AbfLPVjK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Dec 2019 16:39:10 -0500
Received: by mail-pl1-f201.google.com with SMTP id y8so6269873plk.16
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Dec 2019 13:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yO5WXr87Skg8elcGy+aFK+0c/WhLmUDiH+4S7sKXvKU=;
        b=OSbvvLeH8AXNaGEjsltb2SWeU0Wb2C4JtyOykb9hGyt+BmCT0TqtQYGIQKC+knzMP5
         Sb54KhSXMypKgewgpcXTmFxRl5eTzmmxxSNxPamgNpl7Eu4b0atxgqUvxT56EpINHu1L
         Kyw7ETbHEaft8YyVyM70PI4Axe8uz7R0KDoMLzcDfw3YMMCFNwwEmfdFlxjteTU+dXJf
         KklWhBbKGthWG7fo024v2QFMnbJm12two82fn+vcrZb6hSc5mOP/Wrk1lvM/54QheAmh
         Y19GvGPdusGgAeCv4HC424RzExWflOLo0YxoJ6JHnwBk1/v19Bd0KW5+pyUwfW3q+GuK
         3cOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yO5WXr87Skg8elcGy+aFK+0c/WhLmUDiH+4S7sKXvKU=;
        b=P/C2ueqRUBg+Rax9Ppp6tfCpSzMRQKhK4+sDSEXyTy6JPfkMkDFZoOp+gKpSzMxa2w
         5SVgihNzP/55cm+F38Q+mVlJHLLJLisqwsoeBl4fofQMiSY/cNyvVXJwhu17VtnKgBUh
         pxrbIv9TS+nrfZNfJFKEk71v6yWGRwJSJolxHWkyGFDzer0uYJQfa5HgbqJVjU/ghHu7
         D9mDVMhoi2RssfPusnTTGrbciwmfNeq1STXerjkEmP7rJP7S+QhBo47WMOs9PatHaltB
         UDmu/93kyP5+vh2mGzkt+WDcexa3TDTgmoiE3cctIFaSMhjeL6TnW6LRc5C2PiKaX8ri
         bHvw==
X-Gm-Message-State: APjAAAUoIX24lESJYUxUFs4pMQltFVTHG9N5/vn6MPotysRBA9IPzepQ
        yFjcn83nwdraQ+zv5qPMwfFvvI2t87mh
X-Google-Smtp-Source: APXvYqzQs48juYosU3WmzfQmoLou/SFH6VCwt1N1xcW3kPnQFM8uHrRjGLzMBk9Iw+7F7RjMUKftu4TOQjr2
X-Received: by 2002:a65:48cb:: with SMTP id o11mr21116330pgs.313.1576532349464;
 Mon, 16 Dec 2019 13:39:09 -0800 (PST)
Date:   Mon, 16 Dec 2019 13:38:55 -0800
In-Reply-To: <20191216213901.106941-1-bgardon@google.com>
Message-Id: <20191216213901.106941-3-bgardon@google.com>
Mime-Version: 1.0
References: <20191216213901.106941-1-bgardon@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v3 2/8] KVM: selftests: Add demand paging content to the
 demand paging test
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

The demand paging test is currently a simple page access test which, while
potentially useful, doesn't add much versus the existing dirty logging
test. To improve the demand paging test, add a basic userfaultfd demand
paging implementation.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 .../selftests/kvm/demand_paging_test.c        | 177 +++++++++++++++++-
 1 file changed, 173 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 36e12db5da56b..a8f775dab7d4a 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -11,11 +11,14 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <sys/syscall.h>
 #include <unistd.h>
 #include <time.h>
+#include <poll.h>
 #include <pthread.h>
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
+#include <linux/userfaultfd.h>
 
 #include "test_util.h"
 #include "kvm_util.h"
@@ -39,6 +42,8 @@ static uint64_t host_page_size;
 static uint64_t guest_page_size;
 static uint64_t guest_num_pages;
 
+static char *guest_data_prototype;
+
 /*
  * Guest physical memory offset of the testing memory slot.
  * This will be set to the topmost valid physical address minus
@@ -110,13 +115,158 @@ static struct kvm_vm *create_vm(enum vm_guest_mode mode, uint32_t vcpuid,
 	return vm;
 }
 
+static int handle_uffd_page_request(int uffd, uint64_t addr)
+{
+	pid_t tid;
+	struct uffdio_copy copy;
+	int r;
+
+	tid = syscall(__NR_gettid);
+
+	copy.src = (uint64_t)guest_data_prototype;
+	copy.dst = addr;
+	copy.len = host_page_size;
+	copy.mode = 0;
+
+	r = ioctl(uffd, UFFDIO_COPY, &copy);
+	if (r == -1) {
+		DEBUG("Failed Paged in 0x%lx from thread %d with errno: %d\n",
+		      addr, tid, errno);
+		return r;
+	}
+
+	return 0;
+}
+
+bool quit_uffd_thread;
+
+struct uffd_handler_args {
+	int uffd;
+};
+
+static void *uffd_handler_thread_fn(void *arg)
+{
+	struct uffd_handler_args *uffd_args = (struct uffd_handler_args *)arg;
+	int uffd = uffd_args->uffd;
+	int64_t pages = 0;
+
+	while (!quit_uffd_thread) {
+		struct uffd_msg msg;
+		struct pollfd pollfd[1];
+		int r;
+		uint64_t addr;
+
+		pollfd[0].fd = uffd;
+		pollfd[0].events = POLLIN;
+
+		/*
+		 * TODO this introduces a 0.5sec delay at the end of the test.
+		 * Reduce the timeout or eliminate it following the example in
+		 * tools/testing/selftests/vm/userfaultfd.c
+		 */
+		r = poll(pollfd, 1, 500);
+		switch (r) {
+		case -1:
+			DEBUG("poll err");
+			continue;
+		case 0:
+			continue;
+		case 1:
+			break;
+		default:
+			DEBUG("Polling uffd returned %d", r);
+			return NULL;
+		}
+
+		if (pollfd[0].revents & POLLERR) {
+			DEBUG("uffd revents has POLLERR");
+			return NULL;
+		}
+
+		if (!pollfd[0].revents & POLLIN)
+			continue;
+
+		r = read(uffd, &msg, sizeof(msg));
+		if (r == -1) {
+			if (errno == EAGAIN)
+				continue;
+			DEBUG("Read of uffd gor errno %d", errno);
+			return NULL;
+		}
+
+		if (r != sizeof(msg)) {
+			DEBUG("Read on uffd returned unexpected size: %d bytes",
+			      r);
+			return NULL;
+		}
+
+		if (!(msg.event & UFFD_EVENT_PAGEFAULT))
+			continue;
+
+		addr =  msg.arg.pagefault.address;
+		r = handle_uffd_page_request(uffd, addr);
+		if (r < 0)
+			return NULL;
+		pages++;
+	}
+
+	return NULL;
+}
+
+static int setup_demand_paging(struct kvm_vm *vm,
+			       pthread_t *uffd_handler_thread)
+{
+	int uffd;
+	struct uffdio_api uffdio_api;
+	struct uffdio_register uffdio_register;
+	struct uffd_handler_args uffd_args;
+
+	guest_data_prototype = malloc(host_page_size);
+	memset(guest_data_prototype, 0xAB, host_page_size);
+
+	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
+	if (uffd == -1) {
+		DEBUG("uffd creation failed\n");
+		return -1;
+	}
+
+	uffdio_api.api = UFFD_API;
+	uffdio_api.features = 0;
+	if (ioctl(uffd, UFFDIO_API, &uffdio_api) == -1) {
+		DEBUG("ioctl uffdio_api failed\n");
+		return -1;
+	}
+
+	uffdio_register.range.start = (uint64_t)host_test_mem;
+	uffdio_register.range.len = host_num_pages * host_page_size;
+	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
+	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) == -1) {
+		DEBUG("ioctl uffdio_register failed\n");
+		return -1;
+	}
+
+	if ((uffdio_register.ioctls & UFFD_API_RANGE_IOCTLS) !=
+			UFFD_API_RANGE_IOCTLS) {
+		DEBUG("unexpected userfaultfd ioctl set\n");
+		return -1;
+	}
+
+	uffd_args.uffd = uffd;
+	pthread_create(uffd_handler_thread, NULL, uffd_handler_thread_fn,
+		       &uffd_args);
+
+	return 0;
+}
+
 #define GUEST_MEM_SHIFT 30 /* 1G */
 #define PAGE_SHIFT_4K  12
 
-static void run_test(enum vm_guest_mode mode)
+static void run_test(enum vm_guest_mode mode, bool use_uffd)
 {
 	pthread_t vcpu_thread;
+	pthread_t uffd_handler_thread;
 	struct kvm_vm *vm;
+	int r;
 
 	/*
 	 * We reserve page table for 2 times of extra dirty mem which
@@ -173,6 +323,14 @@ static void run_test(enum vm_guest_mode mode)
 	/* Cache the HVA pointer of the region */
 	host_test_mem = addr_gpa2hva(vm, (vm_paddr_t)guest_test_phys_mem);
 
+	if (use_uffd) {
+		/* Set up user fault fd to handle demand paging requests. */
+		quit_uffd_thread = false;
+		r = setup_demand_paging(vm, &uffd_handler_thread);
+		if (r < 0)
+			exit(-r);
+	}
+
 #ifdef __x86_64__
 	vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
 #endif
@@ -188,6 +346,12 @@ static void run_test(enum vm_guest_mode mode)
 	/* Wait for the vcpu thread to quit */
 	pthread_join(vcpu_thread, NULL);
 
+	if (use_uffd) {
+		/* Tell the user fault fd handler thread to quit */
+		quit_uffd_thread = true;
+		pthread_join(uffd_handler_thread, NULL);
+	}
+
 	ucall_uninit(vm);
 	kvm_vm_free(vm);
 }
@@ -209,7 +373,7 @@ static void help(char *name)
 	int i;
 
 	puts("");
-	printf("usage: %s [-h] [-m mode]\n", name);
+	printf("usage: %s [-h] [-m mode] [-u]\n", name);
 	printf(" -m: specify the guest mode ID to test\n"
 	       "     (default: test all supported modes)\n"
 	       "     This option may be used multiple times.\n"
@@ -218,6 +382,7 @@ static void help(char *name)
 		printf("         %d:    %s%s\n", i, vm_guest_mode_string(i),
 		       vm_guest_mode_params[i].supported ? " (supported)" : "");
 	}
+	printf(" -u: Use User Fault FD to handle vCPU page faults.\n");
 	puts("");
 	exit(0);
 }
@@ -227,6 +392,7 @@ int main(int argc, char *argv[])
 	bool mode_selected = false;
 	unsigned int mode;
 	int opt, i;
+	bool use_uffd = false;
 
 #ifdef __x86_64__
 	vm_guest_mode_params_init(VM_MODE_PXXV48_4K, true, true);
@@ -235,7 +401,7 @@ int main(int argc, char *argv[])
 	vm_guest_mode_params_init(VM_MODE_P40V48_4K, true, true);
 #endif
 
-	while ((opt = getopt(argc, argv, "hm:")) != -1) {
+	while ((opt = getopt(argc, argv, "hm:u")) != -1) {
 		switch (opt) {
 		case 'm':
 			if (!mode_selected) {
@@ -248,6 +414,9 @@ int main(int argc, char *argv[])
 				    "Guest mode ID %d too big", mode);
 			vm_guest_mode_params[mode].enabled = true;
 			break;
+		case 'u':
+			use_uffd = true;
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
@@ -261,7 +430,7 @@ int main(int argc, char *argv[])
 		TEST_ASSERT(vm_guest_mode_params[i].supported,
 			    "Guest mode ID %d (%s) not supported.",
 			    i, vm_guest_mode_string(i));
-		run_test(i);
+		run_test(i, use_uffd);
 	}
 
 	return 0;
-- 
2.24.1.735.g03f4e72817-goog

