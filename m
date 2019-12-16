Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9772C121BD9
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2019 22:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfLPVgC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Dec 2019 16:36:02 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:46772 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbfLPVgB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Dec 2019 16:36:01 -0500
Received: by mail-pj1-f73.google.com with SMTP id p5so5232911pjt.13
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Dec 2019 13:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tdjhHaFHTNc8ESXu/zTu/enk0TT4JDIoNFmVjTmEGts=;
        b=IRaWB77s/VGoNr1vSIh63Qx328fBMuda30+mQ4bKVNcz39Bv6dJRNK+QzZ4pD8HySU
         +1PP0Lh3XXqcCT9gJ++1JvNmXEvzt/Pitap67zXTqDQxlUqqEHsl2IyvDnURpl7PDLFq
         vThL7uM7QDEHI7nwFiOTOfl+Pi+JXozrvpAxFTmwGP4njN3q39lMH2/VoXIY01uDNuNw
         6cG4uZ9NsOy0Xx+PRGsgk2w4+4wYUJ0PGAsnEJZkwjoDUqZ+pfCTeG6wsdT8nj5vX/sC
         D4hepItIxBWzeYLM6V8mPophSiSmwQoeZulISLvDeOUfjr98/6HwRyOALEEB2yDK326R
         IKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tdjhHaFHTNc8ESXu/zTu/enk0TT4JDIoNFmVjTmEGts=;
        b=oAAW9AvTh8wBBGxcjebfeeNorVEzjiAFmiRVhjlVxJbWsDzOCVq8CUXkaQu8IWLqMT
         O30li3mEh38xCfrlUUouLqNPhKvpsfOaIHerTlSjRihYcw2h0iNOG1Z5ZxinBM1fKVm7
         6IrCphJ5IJij3paMstOF3HGhif9ErpMO0EY/cFYVmQ3NWIaUhfA6P8uthPsIunnd0DKQ
         Rud5pe8wfJ0qIODL3L2Fl9g8Fht5ibsfpZxlss2WBztdKMVM87/Rg5FZofKDNU9LLK7u
         losEnf6VGSM7CBbcBKYs7SBWVlWGsz3HUiD2jSmRZbUdebO+Z8S9Afikgaac+K+NWHRA
         /32w==
X-Gm-Message-State: APjAAAWyyToeLBmlN28nY1nKU0rnU7zS37+eduhV7GxWRikkQyNz8JD1
        DXEea2Tlsd4Sx1Val0jzA0kZmPcLOzgG
X-Google-Smtp-Source: APXvYqxi3X8qxuLB6h+VvdR1/yBEPcDWFQDFhRZTFFyTIlnY9HAFQxZ1aFFHWN2auQ9Qcuz0olZW5yuz2xUJ
X-Received: by 2002:a63:a54d:: with SMTP id r13mr21029200pgu.138.1576532160089;
 Mon, 16 Dec 2019 13:36:00 -0800 (PST)
Date:   Mon, 16 Dec 2019 13:35:28 -0800
In-Reply-To: <20191216213532.91237-1-bgardon@google.com>
Message-Id: <20191216213532.91237-6-bgardon@google.com>
Mime-Version: 1.0
References: <20191216213532.91237-1-bgardon@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v2 5/8] KVM: selftests: Pass args to vCPU instead of using globals
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

In preparation for supporting multiple vCPUs in the demand paging test,
pass arguments to the vCPU instead of syncing globals to it.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 .../selftests/kvm/demand_paging_test.c        | 61 +++++++++++--------
 1 file changed, 37 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 4aa90a3fce99c..8ede26e088ab6 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -42,7 +42,6 @@
  */
 static uint64_t host_page_size;
 static uint64_t guest_page_size;
-static uint64_t guest_num_pages;
 
 static char *guest_data_prototype;
 
@@ -63,14 +62,13 @@ static uint64_t guest_test_virt_mem = DEFAULT_GUEST_TEST_MEM;
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
@@ -82,18 +80,31 @@ static void guest_code(void)
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
@@ -269,11 +280,13 @@ static int setup_demand_paging(struct kvm_vm *vm,
 #define PAGE_SHIFT_4K  12
 
 static void run_test(enum vm_guest_mode mode, bool use_uffd,
-		     useconds_t uffd_delay, uint64_t guest_memory_bytes)
+		     useconds_t uffd_delay, uint64_t vcpu_wss)
 {
 	pthread_t vcpu_thread;
 	pthread_t uffd_handler_thread;
 	struct kvm_vm *vm;
+	struct vcpu_thread_args vcpu_args;
+	uint64_t guest_num_pages;
 	int r;
 
 	/*
@@ -283,16 +296,15 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
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
@@ -308,9 +320,9 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
 		    guest_num_pages, vm_get_max_gfn(vm));
 
 	host_page_size = getpagesize();
-	TEST_ASSERT(guest_memory_bytes % host_page_size == 0,
+	TEST_ASSERT(vcpu_wss % host_page_size == 0,
 		    "Guest memory size is not host page size aligned.");
-	host_num_pages = guest_memory_bytes / host_page_size;
+	host_num_pages = vcpu_wss / host_page_size;
 
 	guest_test_phys_mem = (vm_get_max_gfn(vm) - guest_num_pages) *
 			      guest_page_size;
@@ -354,10 +366,12 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
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
@@ -404,8 +418,7 @@ static void help(char *name)
 	printf(" -d: add a delay in usec to the User Fault\n"
 	       "     FD handler to simulate demand paging\n"
 	       "     overheads. Ignored without -u.\n");
-	printf(" -b: specify the number of bytes of memory which should be\n"
-	       "     allocated to the guest.\n");
+	printf(" -b: specify the working set size, in bytes for each vCPU.\n");
 	puts("");
 	exit(0);
 }
@@ -413,7 +426,7 @@ static void help(char *name)
 int main(int argc, char *argv[])
 {
 	bool mode_selected = false;
-	uint64_t guest_memory_bytes = DEFAULT_GUEST_TEST_MEM_SIZE;
+	uint64_t vcpu_wss = DEFAULT_GUEST_TEST_MEM_SIZE;
 	unsigned int mode;
 	int opt, i;
 	bool use_uffd = false;
@@ -448,7 +461,7 @@ int main(int argc, char *argv[])
 				    "A negative UFFD delay is not supported.");
 			break;
 		case 'b':
-			guest_memory_bytes = strtoull(optarg, NULL, 0);
+			vcpu_wss = strtoull(optarg, NULL, 0);
 		case 'h':
 		default:
 			help(argv[0]);
@@ -462,7 +475,7 @@ int main(int argc, char *argv[])
 		TEST_ASSERT(vm_guest_mode_params[i].supported,
 			    "Guest mode ID %d (%s) not supported.",
 			    i, vm_guest_mode_string(i));
-		run_test(i, use_uffd, uffd_delay, guest_memory_bytes);
+		run_test(i, use_uffd, uffd_delay, vcpu_wss);
 	}
 
 	return 0;
-- 
2.24.1.735.g03f4e72817-goog

