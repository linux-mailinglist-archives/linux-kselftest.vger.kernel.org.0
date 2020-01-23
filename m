Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA7C147067
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2020 19:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgAWSEx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jan 2020 13:04:53 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:34178 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbgAWSEw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jan 2020 13:04:52 -0500
Received: by mail-pj1-f73.google.com with SMTP id c67so1508800pje.1
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2020 10:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ii0SHfgzZYUwZb7/pvTlYqckx+NQoa62QNzOVUMGLgE=;
        b=PLyp6z0CAVfybtr5KJdK4BBfI+xCS6iijTEsVuy8dz1EF81cfVUm4jiBXsFCTUknHo
         PQcVYi9HFjlQ5LQF3cJuh3cErtPPBfqEOtl80cfSmYoh6giejP2Xkeq55zSVbOmvAN5c
         8k0WJW1tSCXKy6+3lSxlXbHecJrTCsrfCfi0xHnYWCcovJUUbkNozPqdX0W6PNALccJq
         jIl8iyp/gVfDlvYKWBhGVu7CU958B2XFlDQTIyeGJM1aTQZknxXggjEn6RRpB9A0BTJK
         LfB+OWKCtg9PDadtPS5KLpFsWhsJ7RvAWYpuz5CYl2wZLcS0n/uJcp4haojwUTA5E/Ig
         iH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ii0SHfgzZYUwZb7/pvTlYqckx+NQoa62QNzOVUMGLgE=;
        b=T1mJViIJzGv+Bv0Wzdl4T9V2JHM9a5tUZZt7qndFKkbvOvAdkwJWwqJfmkRCtlCKrq
         a8Aj+e/LbEGGCTo0rUQ8Moof68peynhoTtVRc0Yy23zFDUTy6rUhMcMKYHCn0pvKwZD6
         Y97npY0wmLnMX23Li8dcNa0h59bysbRXrUSd/qoHnnAW2YoPXZSN/rJnn9mIo8+ooJTI
         FWD4CCp65XLIEDCrlzvE7M3VSuI1HPiev+SIZ+6q11DEZZk5MKAnWmksFJyFm23Ld93X
         wq+340JPXMFToDtkVsiG/Ztsuz/GGbHrUtI+8JO0crb8noiX0N5UVOB7HCt5Ok/Bx1d/
         vOvQ==
X-Gm-Message-State: APjAAAVVArxcqZL9SFk3kUV1/F3KNVNnzMDKmNNSVTf/DbaSXQ9ii0EP
        DOZdMTTbkxHTSjbeMROCuR22NgY9R0Oq
X-Google-Smtp-Source: APXvYqzoG885PQKUB+5r9e3ERU5dNsON806PZLYtG3pHCaY+uutcjNNjYcphpDoZq+MA1e7JH20yRhKI/XzA
X-Received: by 2002:a63:5fca:: with SMTP id t193mr33015pgb.28.1579802691847;
 Thu, 23 Jan 2020 10:04:51 -0800 (PST)
Date:   Thu, 23 Jan 2020 10:04:31 -0800
In-Reply-To: <20200123180436.99487-1-bgardon@google.com>
Message-Id: <20200123180436.99487-6-bgardon@google.com>
Mime-Version: 1.0
References: <20200123180436.99487-1-bgardon@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v4 05/10] KVM: selftests: Pass args to vCPU in global vCPU
 args struct
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

In preparation for supporting multiple vCPUs in the demand paging test,
pass arguments to the vCPU in a consolidated global struct instead of
syncing multiple globals.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 .../selftests/kvm/demand_paging_test.c        | 38 +++++++++++++------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 9d7514e96a639..9e2a5f7dfa140 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -42,7 +42,6 @@
  */
 static uint64_t host_page_size;
 static uint64_t guest_page_size;
-static uint64_t guest_num_pages;
 
 static char *guest_data_prototype;
 
@@ -59,18 +58,30 @@ static uint64_t guest_test_phys_mem;
  */
 static uint64_t guest_test_virt_mem = DEFAULT_GUEST_TEST_MEM;
 
+struct vcpu_args {
+	uint64_t gva;
+	uint64_t pages;
+
+	/* Only used by the host userspace part of the vCPU thread */
+	int vcpu_id;
+	struct kvm_vm *vm;
+};
+
+static struct vcpu_args vcpu_args;
+
 /*
  * Continuously write to the first 8 bytes of each page in the demand paging
  * memory region.
  */
 static void guest_code(void)
 {
+	uint64_t gva = vcpu_args.gva;
+	uint64_t pages = vcpu_args.pages;
 	int i;
 
-	for (i = 0; i < guest_num_pages; i++) {
-		uint64_t addr = guest_test_virt_mem;
+	for (i = 0; i < pages; i++) {
+		uint64_t addr = gva + (i * guest_page_size);
 
-		addr += i * guest_page_size;
 		addr &= ~(host_page_size - 1);
 		*(uint64_t *)addr = 0x0123456789ABCDEF;
 	}
@@ -85,15 +96,16 @@ static uint64_t host_num_pages;
 static void *vcpu_worker(void *data)
 {
 	int ret;
-	struct kvm_vm *vm = data;
+	struct kvm_vm *vm = vcpu_args.vm;
+	int vcpu_id = vcpu_args.vcpu_id;
 	struct kvm_run *run;
 
-	run = vcpu_state(vm, VCPU_ID);
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
@@ -285,6 +297,7 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
 	pthread_t uffd_handler_thread;
 	int pipefd[2];
 	struct kvm_vm *vm;
+	uint64_t guest_num_pages;
 	int r;
 
 	/*
@@ -370,10 +383,13 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
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
+	sync_global_to_guest(vm, vcpu_args);
+	pthread_create(&vcpu_thread, NULL, vcpu_worker, &vcpu_args);
 
 	/* Wait for the vcpu thread to quit */
 	pthread_join(vcpu_thread, NULL);
-- 
2.25.0.341.g760bfbb309-goog

