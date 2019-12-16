Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7B21121C0D
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2019 22:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfLPVjl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Dec 2019 16:39:41 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:44121 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfLPVjO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Dec 2019 16:39:14 -0500
Received: by mail-pj1-f73.google.com with SMTP id gx23so5228944pjb.11
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Dec 2019 13:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Mr7NGohfKIO/0LLJHqW5UMZVsaNn5FVbb/vWY+9rP5E=;
        b=MazzzmjsYA7dwdKZdSYwKxZrKQRfn9Avrp+JQYCAchfbT1fQBoRFwY+UxwJbCP196m
         kBouenURU6NRBeBZeDJW1cxAl1baMicohCNW1TD8fph3Wv8u02vElujG8Jb08v6z/Ku8
         zXYiGLwftnut6Ulq862yC2qCcDEYoaZDL5qbsS39cKTWAhhYn8NF1pJ+OOMFiMpYwvoN
         rtYAI0KMJOYHsTfR9y3/ZV0M9sHUD4UfLT4IdUNYbcKcVod0Mp81m8Mb6omCsivQ0HmD
         YYdOykog5f5dWV6ibeEwK81IWLMgzRktxAwJNsGbra27+U87vjmV+a5dl+Fjcac65XO+
         ANgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Mr7NGohfKIO/0LLJHqW5UMZVsaNn5FVbb/vWY+9rP5E=;
        b=VLkVp9X6fDRm8UBibpl8t6QpeN2ucQjWyLGOBpNFEov+AcVai08kZvZIoLX6S0FIqm
         Nxba7qW0q2x1QPhH/QV+RBkv0Ydfkhn+X2wAkA7Zr1wUpkuvM3jnYC9fxA3sTVSsOJ61
         d1eb8Xsh7UkmZJ8QN9KMEA1MH/u5VrCZ/0tbb3qlR1Mm7d/pJC+cgGgMnd1hM9AZ5h2I
         ucjDs92/Xle1PhHdAcTia2sIvmPeXgB0T6Kl2ffUCb0WGZNJ51FlORNszSmALMAJVxNt
         5Tzr2+5GwMoP4OFxaDBEXCGVwR2g4fM7rY2hnaCJEh1o0SGWib5NipQJ/H2AKWkBbHIg
         kIhw==
X-Gm-Message-State: APjAAAVgcbDuirMRP5OHINy7aB4MzfJSyvEWOn29sMRqEHR75s7G1yJB
        vRyD2dOcaGKfPorUYlcV5f1PFwDIMZrC
X-Google-Smtp-Source: APXvYqxwnGiU6z3dDQuXViiFr6rMTVYb6tKV1KLyBCQcqxDau+svH7GqbaYECyz4BdKVOJ8/Fn4e3p91W3Zf
X-Received: by 2002:a63:c207:: with SMTP id b7mr21145028pgd.422.1576532351536;
 Mon, 16 Dec 2019 13:39:11 -0800 (PST)
Date:   Mon, 16 Dec 2019 13:38:56 -0800
In-Reply-To: <20191216213901.106941-1-bgardon@google.com>
Message-Id: <20191216213901.106941-4-bgardon@google.com>
Mime-Version: 1.0
References: <20191216213901.106941-1-bgardon@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v3 3/8] KVM: selftests: Add configurable demand paging delay
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

When running the demand paging test with the -u option, the User Fault
FD handler essentially adds an arbitrary delay to page fault resolution.
To enable better simulation of a real demand paging scenario, add a
configurable delay to the UFFD handler.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 .../selftests/kvm/demand_paging_test.c        | 32 +++++++++++++++----
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index a8f775dab7d4a..11de5b58995fb 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -142,12 +142,14 @@ bool quit_uffd_thread;
 
 struct uffd_handler_args {
 	int uffd;
+	useconds_t delay;
 };
 
 static void *uffd_handler_thread_fn(void *arg)
 {
 	struct uffd_handler_args *uffd_args = (struct uffd_handler_args *)arg;
 	int uffd = uffd_args->uffd;
+	useconds_t delay = uffd_args->delay;
 	int64_t pages = 0;
 
 	while (!quit_uffd_thread) {
@@ -203,6 +205,8 @@ static void *uffd_handler_thread_fn(void *arg)
 		if (!(msg.event & UFFD_EVENT_PAGEFAULT))
 			continue;
 
+		if (delay)
+			usleep(delay);
 		addr =  msg.arg.pagefault.address;
 		r = handle_uffd_page_request(uffd, addr);
 		if (r < 0)
@@ -214,7 +218,8 @@ static void *uffd_handler_thread_fn(void *arg)
 }
 
 static int setup_demand_paging(struct kvm_vm *vm,
-			       pthread_t *uffd_handler_thread)
+			       pthread_t *uffd_handler_thread,
+			       useconds_t uffd_delay)
 {
 	int uffd;
 	struct uffdio_api uffdio_api;
@@ -252,6 +257,7 @@ static int setup_demand_paging(struct kvm_vm *vm,
 	}
 
 	uffd_args.uffd = uffd;
+	uffd_args.delay = uffd_delay;
 	pthread_create(uffd_handler_thread, NULL, uffd_handler_thread_fn,
 		       &uffd_args);
 
@@ -261,7 +267,8 @@ static int setup_demand_paging(struct kvm_vm *vm,
 #define GUEST_MEM_SHIFT 30 /* 1G */
 #define PAGE_SHIFT_4K  12
 
-static void run_test(enum vm_guest_mode mode, bool use_uffd)
+static void run_test(enum vm_guest_mode mode, bool use_uffd,
+		     useconds_t uffd_delay)
 {
 	pthread_t vcpu_thread;
 	pthread_t uffd_handler_thread;
@@ -326,7 +333,8 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd)
 	if (use_uffd) {
 		/* Set up user fault fd to handle demand paging requests. */
 		quit_uffd_thread = false;
-		r = setup_demand_paging(vm, &uffd_handler_thread);
+		r = setup_demand_paging(vm, &uffd_handler_thread,
+					uffd_delay);
 		if (r < 0)
 			exit(-r);
 	}
@@ -373,7 +381,7 @@ static void help(char *name)
 	int i;
 
 	puts("");
-	printf("usage: %s [-h] [-m mode] [-u]\n", name);
+	printf("usage: %s [-h] [-m mode] [-u] [-d uffd_delay_usec]\n", name);
 	printf(" -m: specify the guest mode ID to test\n"
 	       "     (default: test all supported modes)\n"
 	       "     This option may be used multiple times.\n"
@@ -382,7 +390,11 @@ static void help(char *name)
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
@@ -393,6 +405,7 @@ int main(int argc, char *argv[])
 	unsigned int mode;
 	int opt, i;
 	bool use_uffd = false;
+	useconds_t uffd_delay = 0;
 
 #ifdef __x86_64__
 	vm_guest_mode_params_init(VM_MODE_PXXV48_4K, true, true);
@@ -401,7 +414,7 @@ int main(int argc, char *argv[])
 	vm_guest_mode_params_init(VM_MODE_P40V48_4K, true, true);
 #endif
 
-	while ((opt = getopt(argc, argv, "hm:u")) != -1) {
+	while ((opt = getopt(argc, argv, "hm:ud:")) != -1) {
 		switch (opt) {
 		case 'm':
 			if (!mode_selected) {
@@ -417,6 +430,11 @@ int main(int argc, char *argv[])
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
@@ -430,7 +448,7 @@ int main(int argc, char *argv[])
 		TEST_ASSERT(vm_guest_mode_params[i].supported,
 			    "Guest mode ID %d (%s) not supported.",
 			    i, vm_guest_mode_string(i));
-		run_test(i, use_uffd);
+		run_test(i, use_uffd, uffd_delay);
 	}
 
 	return 0;
-- 
2.24.1.735.g03f4e72817-goog

