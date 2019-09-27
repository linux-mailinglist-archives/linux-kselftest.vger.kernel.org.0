Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E14B2C0968
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2019 18:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfI0QSp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Sep 2019 12:18:45 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:56055 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbfI0QSp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Sep 2019 12:18:45 -0400
Received: by mail-pf1-f202.google.com with SMTP id w126so2209466pfd.22
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2019 09:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KRRNMBZSZfudRxMD3ki/8HmxF4NewIGO5CQovFCGAFw=;
        b=BoQSFogswf4NHK3zeC4wzHD1xjedFY2kKmVET1Qe9/OpxdZyp3SQR2fSEuDfJuj6FE
         rMIVUJqLyPbEn2kaQZe9RVR7a1sW8vU8k+7pz4qHXe0s1jWs6QYXHl0Y+RteFHFJh9Vv
         kPYhXFqcqC8LbthxGWN1LGfYbUnYTp4rGbFs2+APTGmlRc/mam7daLtMlyhsg03QX7kh
         umlNCLdFEkNjtTwj/1L1XEXwyrB9Devnp+GVvcw1XAGjiv/aXt9JuKHhE/EmH5TprwQA
         rxTavAuIgt1yCPWj4gxX78XP8roXbzpq+/mkcXeRHj7Y0duhiHczqCNB1Kr3xTfPcldp
         CwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KRRNMBZSZfudRxMD3ki/8HmxF4NewIGO5CQovFCGAFw=;
        b=To595ytExieWqtmlRcwBJc+5F1dwRZbkcIXZJcIk5+dKJcz8vgJCRuN+LiaSJBP8Zu
         1D0EXbtxytFJE2KQttFX+A2YkTewsPy3X3Mpmn0HUzqmEHnd8hrubl6rsHbBBdc1SHOQ
         n5LtO7IXFcNJAyrv1Iiz2cOu9q9t3Kqu7Cj1kZ1YTqIsLtERuoNgKAJux2pNXgJamxml
         hT5+wkvJb3/ZEi28OSlb1X+aznmXLmCptceJ8ObYUwAcI8i8g+oyr92jbudSTtRtAIeo
         Aw4IJcxXoJHl1dOY5z+D39A/EQo3nk3WhXMY46UZz6fVdHCelPGhTfEykN06aAkaYHgH
         d6ZA==
X-Gm-Message-State: APjAAAWDl9vAK1dzh9QGt3D1+XfcC+DHytEkn3RYUoQS8uBa5J4IR8Sa
        be630wranWHiGoTQcC8Ehw+eTaqM7B6S
X-Google-Smtp-Source: APXvYqxKYn9C55/O+SOEWKGe2kH9Q2HGNjbYtu8yk2cDDGBnwvXYYPTteTUN3QOV4XUOY/xyHtWiQsn2htck
X-Received: by 2002:a63:31c6:: with SMTP id x189mr10097980pgx.240.1569601124201;
 Fri, 27 Sep 2019 09:18:44 -0700 (PDT)
Date:   Fri, 27 Sep 2019 09:18:30 -0700
In-Reply-To: <20190927161836.57978-1-bgardon@google.com>
Message-Id: <20190927161836.57978-3-bgardon@google.com>
Mime-Version: 1.0
References: <20190927161836.57978-1-bgardon@google.com>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
Subject: [PATCH 2/9] KVM: selftests: Add demand paging content to the demand
 paging test
From:   Ben Gardon <bgardon@google.com>
To:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
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
 .../selftests/kvm/demand_paging_test.c        | 157 ++++++++++++++++++
 1 file changed, 157 insertions(+)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 5f214517ba1de..61ba4e6a8214a 100644
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
@@ -29,6 +32,8 @@
 /* Default guest test virtual memory offset */
 #define DEFAULT_GUEST_TEST_MEM		0xc0000000
 
+#define __NR_userfaultfd 323
+
 /*
  * Guest/Host shared variables. Ensure addr_gva2hva() and/or
  * sync_global_to/from_guest() are used when accessing from
@@ -39,6 +44,8 @@ static uint64_t host_page_size;
 static uint64_t guest_page_size;
 static uint64_t guest_num_pages;
 
+static char *guest_data_prototype;
+
 /*
  * Guest physical memory offset of the testing memory slot.
  * This will be set to the topmost valid physical address minus
@@ -110,13 +117,153 @@ static struct kvm_vm *create_vm(enum vm_guest_mode mode, uint32_t vcpuid,
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
+		r = poll(pollfd, 1, 2000);
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
 
 static void run_test(enum vm_guest_mode mode)
 {
 	pthread_t vcpu_thread;
+	pthread_t uffd_handler_thread;
 	struct kvm_vm *vm;
+	int r;
 
 	/*
 	 * We reserve page table for 2 times of extra dirty mem which
@@ -173,6 +320,12 @@ static void run_test(enum vm_guest_mode mode)
 	/* Cache the HVA pointer of the region */
 	host_test_mem = addr_gpa2hva(vm, (vm_paddr_t)guest_test_phys_mem);
 
+	/* Set up user fault fd to handle demand paging requests. */
+	quit_uffd_thread = false;
+	r = setup_demand_paging(vm, &uffd_handler_thread);
+	if (r < 0)
+		exit(-r);
+
 #ifdef __x86_64__
 	vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
 #endif
@@ -191,6 +344,10 @@ static void run_test(enum vm_guest_mode mode)
 	/* Wait for the vcpu thread to quit */
 	pthread_join(vcpu_thread, NULL);
 
+	/* Tell the user fault fd handler thread to quit */
+	quit_uffd_thread = true;
+	pthread_join(uffd_handler_thread, NULL);
+
 	ucall_uninit(vm);
 	kvm_vm_free(vm);
 }
-- 
2.23.0.444.g18eeb5a265-goog

