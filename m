Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78DB1C0970
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2019 18:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbfI0QSz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Sep 2019 12:18:55 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:44374 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbfI0QSz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Sep 2019 12:18:55 -0400
Received: by mail-pl1-f201.google.com with SMTP id h11so1919460plt.11
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2019 09:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=C/rLQ2oLxQZ983DbhcEAy72g3EkcETZ71g/BHgzPdAU=;
        b=ChscLEp6Cu0mCQ2/3RDNDu6iH98Sw0MtOVYiFyVU4EJx+qZ9PpyXUq6XBSWfHuu9e4
         Ad0cjMFGKM1faTZpcM5azpZIHA9Ss04p//bfGegrKJ+Rvg1bL7unYnuvFT0l68x0oRZD
         O4zNHl0B/boPaKQpawVm88YGaZ1hQLAJBsK0TLCjEPIk/nHOnAgG8B154EGt/Evyu/rB
         wHYcQOcPfRZV8pYBrty83vrnm4y4XgKn2ICHBs7i+XyxxkAKPdxMGWNasVaogJ9STIz+
         UtnY2qAewarn6dYBY/wtY8wT8dkVRu/9xFZxDRB/MpSPHVQxmmBj0XGlefHbtHQ5rmIV
         Oy5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C/rLQ2oLxQZ983DbhcEAy72g3EkcETZ71g/BHgzPdAU=;
        b=Fs6En2KqzVm5pM6BD1GWA67hSUKBmRd2sTH+Se9Tmbl/AFYeIgbsi1PN3C18rVcEXo
         X+b+gK46Lqi2qtVBopwIv9J8rXuV5oqogG1JJg//LQ0gjWAK2YTgGBERI4iCAqANfRq8
         BtP0U8kvA0DLHQ/sStz9dxudBJ+cVDWRxvCdJj0mTFAGlOQAKrg1aMZTndF+jXfaaT27
         weXmZakN9yaKoMH1REEum3yj4kfFHFyTPobHOdGexIBW+P6XyjEBdj5johgB2dqWw61Y
         TxNtiGHwL1vwEN8xTYRC8FWfs6pBLHuou8II5oETF8LqBlvTOy08qgJhuJvgu7QL1yU1
         VUKg==
X-Gm-Message-State: APjAAAXqis66UA+jTKZsTVj+Nha6o/W90JlNWYPBGbgzVjRp8JJ3fNg4
        yP/4wWA6oxPMgULUW2Z6GY9uN0/5VJPn
X-Google-Smtp-Source: APXvYqymTqH8N/cLnvS3L6AraOtT0i46rIrImcA3aoerq63TlsU+tzJKMz8xFImPcxs4ac1jk6EguCqqUkhz
X-Received: by 2002:a63:dd05:: with SMTP id t5mr9961353pgg.16.1569601132992;
 Fri, 27 Sep 2019 09:18:52 -0700 (PDT)
Date:   Fri, 27 Sep 2019 09:18:34 -0700
In-Reply-To: <20190927161836.57978-1-bgardon@google.com>
Message-Id: <20190927161836.57978-7-bgardon@google.com>
Mime-Version: 1.0
References: <20190927161836.57978-1-bgardon@google.com>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
Subject: [PATCH 6/9] KVM: selftests: Time guest demand paging
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

In order to quantify demand paging performance, time guest execution
during demand paging.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 .../selftests/kvm/demand_paging_test.c        | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index f8afc0683c346..fe6c5a4f8b8c2 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -34,6 +34,12 @@
 
 #define __NR_userfaultfd 323
 
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
 /*
  * Continuously write to the first 8 bytes of each page in the demand paging
  * memory region.
@@ -98,11 +124,15 @@ static void *vcpu_worker(void *data)
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
@@ -112,6 +142,11 @@ static void *vcpu_worker(void *data)
 			    exit_reason_str(run->exit_reason));
 	}
 
+	clock_gettime(CLOCK_MONOTONIC, &end);
+	PER_VCPU_DEBUG("vCPU %d execution time: %lld.%.9lds\n", vcpu_id,
+		       (long long)(diff(start, end).tv_sec),
+		       diff(start, end).tv_nsec);
+
 	return NULL;
 }
 
@@ -147,6 +182,8 @@ static struct kvm_vm *create_vm(enum vm_guest_mode mode, int vcpus,
 static int handle_uffd_page_request(int uffd, uint64_t addr)
 {
 	pid_t tid;
+	struct timespec start;
+	struct timespec end;
 	struct uffdio_copy copy;
 	int r;
 
@@ -157,6 +194,8 @@ static int handle_uffd_page_request(int uffd, uint64_t addr)
 	copy.len = host_page_size;
 	copy.mode = 0;
 
+	clock_gettime(CLOCK_MONOTONIC, &start);
+
 	r = ioctl(uffd, UFFDIO_COPY, &copy);
 	if (r == -1) {
 		DEBUG("Failed Paged in 0x%lx from thread %d with errno: %d\n",
@@ -164,6 +203,13 @@ static int handle_uffd_page_request(int uffd, uint64_t addr)
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
 	struct uffd_handler_args *uffd_args = (struct uffd_handler_args *)arg;
 	int uffd = uffd_args->uffd;
 	int64_t pages = 0;
+	struct timespec start;
+	struct timespec end;
 
+	clock_gettime(CLOCK_MONOTONIC, &start);
 	while (!quit_uffd_thread) {
 		struct uffd_msg msg;
 		struct pollfd pollfd[1];
@@ -234,6 +283,13 @@ static void *uffd_handler_thread_fn(void *arg)
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
 
@@ -293,6 +349,8 @@ static void run_test(enum vm_guest_mode mode, int vcpus, uint64_t vcpu_wss)
 	uint64_t guest_num_pages;
 	int vcpu_id;
 	int r;
+	struct timespec start;
+	struct timespec end;
 
 	vm = create_vm(mode, vcpus, vcpu_wss);
 
@@ -402,6 +460,8 @@ static void run_test(enum vm_guest_mode mode, int vcpus, uint64_t vcpu_wss)
 
 	DEBUG("Finished creating vCPUs and starting uffd threads\n");
 
+	clock_gettime(CLOCK_MONOTONIC, &start);
+
 	for (vcpu_id = 0; vcpu_id < vcpus; vcpu_id++) {
 		pthread_create(&vcpu_threads[vcpu_id], NULL, vcpu_worker,
 			       &vcpu_args[vcpu_id]);
@@ -417,11 +477,19 @@ static void run_test(enum vm_guest_mode mode, int vcpus, uint64_t vcpu_wss)
 
 	DEBUG("All vCPU threads joined\n");
 
+	clock_gettime(CLOCK_MONOTONIC, &end);
+
 	/* Tell the user fault fd handler thread to quit */
 	quit_uffd_thread = true;
 	for (vcpu_id = 0; vcpu_id < vcpus; vcpu_id++)
 		pthread_join(uffd_handler_threads[vcpu_id], NULL);
 
+	DEBUG("Total guest execution time: %lld.%.9lds\n",
+	      (long long)(diff(start, end).tv_sec), diff(start, end).tv_nsec);
+	DEBUG("Overall demand paging rate: %f pgs/sec\n",
+	      guest_num_pages / ((double)diff(start, end).tv_sec +
+	      (double)diff(start, end).tv_nsec / 100000000.0));
+
 	ucall_uninit(vm);
 	kvm_vm_free(vm);
 
-- 
2.23.0.444.g18eeb5a265-goog

