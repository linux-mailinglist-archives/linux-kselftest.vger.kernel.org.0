Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C54B0C096C
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2019 18:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfI0QSu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Sep 2019 12:18:50 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:50914 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbfI0QSt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Sep 2019 12:18:49 -0400
Received: by mail-pf1-f201.google.com with SMTP id q127so2219396pfc.17
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2019 09:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IlvPPwGnMWD1NTIiC8jnPE4YM8+nW7ykOi0JgL0Q+GQ=;
        b=wC4kHt5p9cIRSDgrTzzM9HAVj1PwdCZMdzNGWJmdJ7INFpMh8yjJkuHNR9idmSUYMV
         jpuQyXHtZMCvqJa/pNatma/+SG5BcDFIzBowHoCvUFjsMsx9pknBBbBZhYPQF3V7qB/q
         sh2ISmela0hcmFM0CafxdAldCHJY97pVx634/8jm4u8+MDcS/jweaKJl2Ylx6FwFTPM0
         Fg47eTm1N1A4hFF88rg+J56HSP9PwFn7gst3u4Z8bedKJbnp5E07JZTH9N+gDN8Y7txG
         FRUeuRMcXBED6pDhFMheQeWWo8SddmNJYldmvTEOQl2Iru9jw1Ih57R717YP0ExsV48o
         6MoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IlvPPwGnMWD1NTIiC8jnPE4YM8+nW7ykOi0JgL0Q+GQ=;
        b=R+xCXqZB7JcC3/pL6K2NZo7uRXnfKXbzjKHXKCB/NV2rvZcV92eALnVpTXK9RSXMxl
         wgRTJ8V2KHIN1eCT1OvwoeAydlUDNo7A1DPmuZ9Dlb1/0Mr1Rg8wiBqrYQrLEUSJyeAU
         SMxjL96/gMxs0Z2f85KPT44/XP9w8mDgNPQo4CwnxWUXbPgbSyWTZrfcwif807efGN2B
         rjWi4BWt7w7tj6qDp9cffNsOaWXpSN1FMcA8GMGzaa/yHR6LR8ef6F+vU4j7DBrMdjgk
         pPIwTUL+hcN9XvLKNw/KOrDyc/7XUq1P/Zl9sXhzOC17pj/cBUCaJhJhzX7icL6N0EYZ
         KdTg==
X-Gm-Message-State: APjAAAXc7ZRKX0r7CYgI7oud69gnMi+y/3GpBlOY0mDhI7L3mk4m3wjz
        074L4rBxcQ2T8KFd21SH9hKBrd0dodJH
X-Google-Smtp-Source: APXvYqwCKt4vsu5/A+gyozazO8stNHyGzzddSTGHVfrUWy9VaTguzUhV/cd2QSe0wCXp9obT++vRs4KU0UCx
X-Received: by 2002:a63:ff4a:: with SMTP id s10mr10045451pgk.166.1569601128664;
 Fri, 27 Sep 2019 09:18:48 -0700 (PDT)
Date:   Fri, 27 Sep 2019 09:18:32 -0700
In-Reply-To: <20190927161836.57978-1-bgardon@google.com>
Message-Id: <20190927161836.57978-5-bgardon@google.com>
Mime-Version: 1.0
References: <20190927161836.57978-1-bgardon@google.com>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
Subject: [PATCH 4/9] KVM: selftests: Pass args to vCPU instead of using globals
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

In preparation for supporting multiple vCPUs in the demand paging test,
pass arguments to the vCPU instead of syncing globals to it.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 .../selftests/kvm/demand_paging_test.c        | 61 +++++++++++--------
 1 file changed, 37 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 19982a33a0ca2..8fd46e99d9e30 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -44,7 +44,6 @@
  */
 static uint64_t host_page_size;
 static uint64_t guest_page_size;
-static uint64_t guest_num_pages;
 
 static char *guest_data_prototype;
 
@@ -65,14 +64,13 @@ static uint64_t guest_test_virt_mem = DEFAULT_GUEST_TEST_MEM;
  * Continuously write to the first 8 bytes of each page in the demand paging
  * memory region.
  */
-static void guest_code(void)
+static void guest_code(uint64_t gva, uint64_t pages)
 {
 	int i;
 
-	for (i = 0; i < guest_num_pages; i++) {
-		uint64_t addr = guest_test_virt_mem;
+	for (i = 0; i < pages; i++) {
+		uint64_t addr = gva + (i * guest_page_size);
 
-		addr += i * guest_page_size;
 		addr &= ~(host_page_size - 1);
 		*(uint64_t *)addr = 0x0123456789ABCDEF;
 	}
@@ -84,18 +82,31 @@ static void guest_code(void)
 static void *host_test_mem;
 static uint64_t host_num_pages;
 
+struct vcpu_thread_args {
+	uint64_t gva;
+	uint64_t pages;
+	struct kvm_vm *vm;
+	int vcpu_id;
+};
+
 static void *vcpu_worker(void *data)
 {
 	int ret;
-	struct kvm_vm *vm = data;
+	struct vcpu_thread_args *args = (struct vcpu_thread_args *)data;
+	struct kvm_vm *vm = args->vm;
+	int vcpu_id = args->vcpu_id;
+	uint64_t gva = args->gva;
+	uint64_t pages = args->pages;
 	struct kvm_run *run;
 
-	run = vcpu_state(vm, VCPU_ID);
+	vcpu_args_set(vm, vcpu_id, 2, gva, pages);
+
+	run = vcpu_state(vm, vcpu_id);
 
 	/* Let the guest access its memory */
-	ret = _vcpu_run(vm, VCPU_ID);
+	ret = _vcpu_run(vm, vcpu_id);
 	TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);
-	if (get_ucall(vm, VCPU_ID, NULL) != UCALL_SYNC) {
+	if (get_ucall(vm, vcpu_id, NULL) != UCALL_SYNC) {
 		TEST_ASSERT(false,
 			    "Invalid guest sync status: exit_reason=%s\n",
 			    exit_reason_str(run->exit_reason));
@@ -259,11 +270,13 @@ static int setup_demand_paging(struct kvm_vm *vm,
 
 #define PAGE_SHIFT_4K  12
 
-static void run_test(enum vm_guest_mode mode, uint64_t guest_memory_bytes)
+static void run_test(enum vm_guest_mode mode, uint64_t vcpu_wss)
 {
 	pthread_t vcpu_thread;
 	pthread_t uffd_handler_thread;
 	struct kvm_vm *vm;
+	struct vcpu_thread_args vcpu_args;
+	uint64_t guest_num_pages;
 	int r;
 
 	/*
@@ -273,16 +286,15 @@ static void run_test(enum vm_guest_mode mode, uint64_t guest_memory_bytes)
 	 * number will be enough for all archs. (e.g., 64K page size guest
 	 * will need even less memory for page tables).
 	 */
-	vm = create_vm(mode, VCPU_ID,
-		       (2 * guest_memory_bytes) >> PAGE_SHIFT_4K,
+	vm = create_vm(mode, VCPU_ID, (2 * vcpu_wss) >> PAGE_SHIFT_4K,
 		       guest_code);
 
 	guest_page_size = vm_get_page_size(vm);
 
-	TEST_ASSERT(guest_memory_bytes % guest_page_size == 0,
+	TEST_ASSERT(vcpu_wss % guest_page_size == 0,
 		    "Guest memory size is not guest page size aligned.");
 
-	guest_num_pages = guest_memory_bytes / guest_page_size;
+	guest_num_pages = vcpu_wss / guest_page_size;
 
 #ifdef __s390x__
 	/* Round up to multiple of 1M (segment size) */
@@ -298,9 +310,9 @@ static void run_test(enum vm_guest_mode mode, uint64_t guest_memory_bytes)
 		    guest_num_pages, vm_get_max_gfn(vm));
 
 	host_page_size = getpagesize();
-	TEST_ASSERT(guest_memory_bytes % host_page_size == 0,
+	TEST_ASSERT(vcpu_wss % host_page_size == 0,
 		    "Guest memory size is not host page size aligned.");
-	host_num_pages = guest_memory_bytes / host_page_size;
+	host_num_pages = vcpu_wss / host_page_size;
 
 	guest_test_phys_mem = (vm_get_max_gfn(vm) - guest_num_pages) *
 			      guest_page_size;
@@ -344,10 +356,12 @@ static void run_test(enum vm_guest_mode mode, uint64_t guest_memory_bytes)
 	/* Export the shared variables to the guest */
 	sync_global_to_guest(vm, host_page_size);
 	sync_global_to_guest(vm, guest_page_size);
-	sync_global_to_guest(vm, guest_test_virt_mem);
-	sync_global_to_guest(vm, guest_num_pages);
 
-	pthread_create(&vcpu_thread, NULL, vcpu_worker, vm);
+	vcpu_args.vm = vm;
+	vcpu_args.vcpu_id = VCPU_ID;
+	vcpu_args.gva = guest_test_virt_mem;
+	vcpu_args.pages = guest_num_pages;
+	pthread_create(&vcpu_thread, NULL, vcpu_worker, &vcpu_args);
 
 	/* Wait for the vcpu thread to quit */
 	pthread_join(vcpu_thread, NULL);
@@ -386,8 +400,7 @@ static void help(char *name)
 		printf("         %d:    %s%s\n", i, vm_guest_mode_string(i),
 		       vm_guest_mode_params[i].supported ? " (supported)" : "");
 	}
-	printf(" -b: specify the number of bytes of memory which should be\n"
-	       "     allocated to the guest.\n");
+	printf(" -b: specify the working set size, in bytes for each vCPU.\n");
 	puts("");
 	exit(0);
 }
@@ -395,7 +408,7 @@ static void help(char *name)
 int main(int argc, char *argv[])
 {
 	bool mode_selected = false;
-	uint64_t guest_memory_bytes = DEFAULT_GUEST_TEST_MEM_SIZE;
+	uint64_t vcpu_wss = DEFAULT_GUEST_TEST_MEM_SIZE;
 	unsigned int mode;
 	int opt, i;
 #ifdef __aarch64__
@@ -435,7 +448,7 @@ int main(int argc, char *argv[])
 			vm_guest_mode_params[mode].enabled = true;
 			break;
 		case 'b':
-			guest_memory_bytes = strtoull(optarg, NULL, 0);
+			vcpu_wss = strtoull(optarg, NULL, 0);
 		case 'h':
 		default:
 			help(argv[0]);
@@ -449,7 +462,7 @@ int main(int argc, char *argv[])
 		TEST_ASSERT(vm_guest_mode_params[i].supported,
 			    "Guest mode ID %d (%s) not supported.",
 			    i, vm_guest_mode_string(i));
-		run_test(i, guest_memory_bytes);
+		run_test(i, vcpu_wss);
 	}
 
 	return 0;
-- 
2.23.0.444.g18eeb5a265-goog

