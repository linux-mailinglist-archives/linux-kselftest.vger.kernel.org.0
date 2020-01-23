Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE6D147063
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2020 19:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgAWSEu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jan 2020 13:04:50 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:51236 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbgAWSEs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jan 2020 13:04:48 -0500
Received: by mail-pl1-f202.google.com with SMTP id r2so1825482pls.18
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2020 10:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+ajBlD4ZsHzsHJt9G432a6UKIjktZtDyWcSq/QWbHJg=;
        b=E+iKTJppKfOA15AHNg+JNQPSdGCNa5Uim57JFueZ6xE2XII/5MRDURCmW2HDphgv4z
         LKGdN16W71YvHNQtTZhiMUJEKlkk3gQnGLB+AAdgS3DPuhQl5Ro/NcXNPR/vK43uOlHp
         bnXvAW/Y4EcMRojH2fnMUdD8Mt6HPLKAZVV0p86vH/PCc62W5I0dM5DD77tVKV6BFDCF
         ByQOt+sBgOU25p6T9O/J7gw/xNjI9uHh1g76P/D2x86cmhVlZZ/LlNU9B+0lL+CjOp19
         H621VSO0YK5egEusQt9dZUPuZ96hyimPiOr8/Co3HQwFdB/aPAjoDI2RkR0qlM7xifmt
         BpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+ajBlD4ZsHzsHJt9G432a6UKIjktZtDyWcSq/QWbHJg=;
        b=mn5qp+Oa4QO0+78UsBdqTyJ+R6Lkmug6gy58iPPa+1RgpMhQQFq60A1dLJ0pebP+sA
         dFyTYPs2JK67Kd2bKFxJ8I8yI1T30zkwTXXYH7R09ZCXFbZPAANo5E5rBpQkb34+CKjI
         uUa8PaRxjF1SLyPTDMgHWoJqW0DqYWqgBN1Vnt7SWSO6ppTQeOFfjgF5Fc9Th4Rsafgr
         LlTxCjLEaZ8HoeCEDsf6DTJx9OIf2KhyhFSUbNVkICJBVsF4SVDCcITcfXBDkPELz4Mt
         nJCHEfNFVLNC0LtYfznPbcbJ+F0U7aT7lZ8/beJqcW5FhzOwHCk2UV04X0ArYpkvvV9d
         V0vA==
X-Gm-Message-State: APjAAAVc6tT52oSfDFKkuMXB84iOKw4Hh3lWws2FbHNhasSUyoTg8x+f
        68WEZo14pGPmNRz+Z7wNUqemwOOiJ3LQ
X-Google-Smtp-Source: APXvYqznzCF8rkNRgq/SBrtTpV1jgeJBFQ2M2VKjD3QumwjpQ1GXpdc/5kqyqt7Z2jAeQ3iIDZCvgKjQ69Cq
X-Received: by 2002:a63:d306:: with SMTP id b6mr5132435pgg.195.1579802687628;
 Thu, 23 Jan 2020 10:04:47 -0800 (PST)
Date:   Thu, 23 Jan 2020 10:04:29 -0800
In-Reply-To: <20200123180436.99487-1-bgardon@google.com>
Message-Id: <20200123180436.99487-4-bgardon@google.com>
Mime-Version: 1.0
References: <20200123180436.99487-1-bgardon@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v4 03/10] KVM: selftests: Add configurable demand paging delay
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

When running the demand paging test with the -u option, the User Fault
FD handler essentially adds an arbitrary delay to page fault resolution.
To enable better simulation of a real demand paging scenario, add a
configurable delay to the UFFD handler.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Ben Gardon <bgardon@google.com>
---
 .../selftests/kvm/demand_paging_test.c        | 32 +++++++++++++++----
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 6fab4468f97f6..01d2c76ada55d 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -143,6 +143,7 @@ bool quit_uffd_thread;
 struct uffd_handler_args {
 	int uffd;
 	int pipefd;
+	useconds_t delay;
 };
 
 static void *uffd_handler_thread_fn(void *arg)
@@ -150,6 +151,7 @@ static void *uffd_handler_thread_fn(void *arg)
 	struct uffd_handler_args *uffd_args = (struct uffd_handler_args *)arg;
 	int uffd = uffd_args->uffd;
 	int pipefd = uffd_args->pipefd;
+	useconds_t delay = uffd_args->delay;
 	int64_t pages = 0;
 
 	while (!quit_uffd_thread) {
@@ -210,6 +212,8 @@ static void *uffd_handler_thread_fn(void *arg)
 		if (!(msg.event & UFFD_EVENT_PAGEFAULT))
 			continue;
 
+		if (delay)
+			usleep(delay);
 		addr =  msg.arg.pagefault.address;
 		r = handle_uffd_page_request(uffd, addr);
 		if (r < 0)
@@ -221,7 +225,8 @@ static void *uffd_handler_thread_fn(void *arg)
 }
 
 static int setup_demand_paging(struct kvm_vm *vm,
-			       pthread_t *uffd_handler_thread, int pipefd)
+			       pthread_t *uffd_handler_thread, int pipefd,
+			       useconds_t uffd_delay)
 {
 	int uffd;
 	struct uffdio_api uffdio_api;
@@ -262,6 +267,7 @@ static int setup_demand_paging(struct kvm_vm *vm,
 
 	uffd_args.uffd = uffd;
 	uffd_args.pipefd = pipefd;
+	uffd_args.delay = uffd_delay;
 	pthread_create(uffd_handler_thread, NULL, uffd_handler_thread_fn,
 		       &uffd_args);
 
@@ -271,7 +277,8 @@ static int setup_demand_paging(struct kvm_vm *vm,
 #define GUEST_MEM_SHIFT 30 /* 1G */
 #define PAGE_SHIFT_4K  12
 
-static void run_test(enum vm_guest_mode mode, bool use_uffd)
+static void run_test(enum vm_guest_mode mode, bool use_uffd,
+		     useconds_t uffd_delay)
 {
 	pthread_t vcpu_thread;
 	pthread_t uffd_handler_thread;
@@ -339,7 +346,8 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd)
 		r = pipe2(pipefd, O_CLOEXEC | O_NONBLOCK);
 		TEST_ASSERT(!r, "Failed to set up pipefd");
 
-		r = setup_demand_paging(vm, &uffd_handler_thread, pipefd[0]);
+		r = setup_demand_paging(vm, &uffd_handler_thread, pipefd[0],
+					uffd_delay);
 		if (r < 0)
 			exit(-r);
 	}
@@ -395,7 +403,7 @@ static void help(char *name)
 	int i;
 
 	puts("");
-	printf("usage: %s [-h] [-m mode] [-u]\n", name);
+	printf("usage: %s [-h] [-m mode] [-u] [-d uffd_delay_usec]\n", name);
 	printf(" -m: specify the guest mode ID to test\n"
 	       "     (default: test all supported modes)\n"
 	       "     This option may be used multiple times.\n"
@@ -404,7 +412,11 @@ static void help(char *name)
 		printf("         %d:    %s%s\n", i, vm_guest_mode_string(i),
 		       vm_guest_mode_params[i].supported ? " (supported)" : "");
 	}
-	printf(" -u: Use User Fault FD to handle vCPU page faults.\n");
+	printf(" -u: use User Fault FD to handle vCPU page\n"
+	       "     faults.\n");
+	printf(" -d: add a delay in usec to the User Fault\n"
+	       "     FD handler to simulate demand paging\n"
+	       "     overheads. Ignored without -u.\n");
 	puts("");
 	exit(0);
 }
@@ -415,6 +427,7 @@ int main(int argc, char *argv[])
 	unsigned int mode;
 	int opt, i;
 	bool use_uffd = false;
+	useconds_t uffd_delay = 0;
 #ifdef __aarch64__
 	unsigned int host_ipa_limit;
 #endif
@@ -438,7 +451,7 @@ int main(int argc, char *argv[])
 	vm_guest_mode_params_init(VM_MODE_P40V48_4K, true, true);
 #endif
 
-	while ((opt = getopt(argc, argv, "hm:u")) != -1) {
+	while ((opt = getopt(argc, argv, "hm:ud:")) != -1) {
 		switch (opt) {
 		case 'm':
 			if (!mode_selected) {
@@ -454,6 +467,11 @@ int main(int argc, char *argv[])
 		case 'u':
 			use_uffd = true;
 			break;
+		case 'd':
+			uffd_delay = strtoul(optarg, NULL, 0);
+			TEST_ASSERT(uffd_delay >= 0,
+				    "A negative UFFD delay is not supported.");
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
@@ -467,7 +485,7 @@ int main(int argc, char *argv[])
 		TEST_ASSERT(vm_guest_mode_params[i].supported,
 			    "Guest mode ID %d (%s) not supported.",
 			    i, vm_guest_mode_string(i));
-		run_test(i, use_uffd);
+		run_test(i, use_uffd, uffd_delay);
 	}
 
 	return 0;
-- 
2.25.0.341.g760bfbb309-goog

