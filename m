Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADF06121BEC
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2019 22:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfLPVgf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Dec 2019 16:36:35 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:44809 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbfLPVf5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Dec 2019 16:35:57 -0500
Received: by mail-pg1-f202.google.com with SMTP id o21so4746150pgm.11
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Dec 2019 13:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Mr7NGohfKIO/0LLJHqW5UMZVsaNn5FVbb/vWY+9rP5E=;
        b=A2sDWiv0ldMYscBiHQh9dHQ5MUEBID6HNSMCZKrSzSBHe5IP+x2QVF9pvCTy0Mb8vZ
         5Ucs8s2vK3fbogLXC0Ic2aeI6Fd4RWV8xtSym8CFQpUcZP9JU6RXnDr6mDoG9MfKxkF5
         sOuYpCTCURyIn1E5+y/Tp7nHWEDPlz+b1uEhw3tvBpJsiHqlvz4d3D0fGrOqwLwciawL
         dYhiY/Mj8s3TJbo3kkRVHlFrbAh0FuUigZcxB5guESxALZymb+UViRMBtJLB1fKZdvod
         fqXmmv1HZ7NP3Q8+HLC6OuPvHSSq7W9tpWdOOBgdn6R7OJV2HtLmJACC0AHw8LG/DhWZ
         Lc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Mr7NGohfKIO/0LLJHqW5UMZVsaNn5FVbb/vWY+9rP5E=;
        b=tbA99qPA7Gr2lj0VXnOMsE/qTw/8k1JU5RCvSoNvceekQDkaF1Jjs2TDe3ujv30RwS
         3OnM0G429nLyguVCwC5QYpb90sx6Pvbfohy/59uv2Pm75CClh4uYnkQyvXTbQmSvBJkh
         tF4OUe34WeuBYkMydEoCLcggjB3FWxfHDM1Mqt835+qCcXUqtT8demsH2yprjAVz7VET
         yKoJRh2gmPdWXs2BIE+NljtjHx929HkGC2kU3M8yk1JSuDwHCTdkMmrshp9D4wzQ1Ain
         oHvUPFoVxD5YL7ZxU8ltIhe+0CNoc6/Joaykdt+Zvb9wPWmJvjJrxO8WQsWlHcRgAfGR
         /CTw==
X-Gm-Message-State: APjAAAUqCuBV9E6hMg1UdZxwmRR3tVPUnCIo7/ttAM9vZf3En3YiMcYJ
        iFCOrQkjvzXegRzZKUUf9wPSKqG6uvce
X-Google-Smtp-Source: APXvYqw06kZ9cCSs/wZsgCwXIpnr8tBG5tdX40Y0wfTxdez3/oaBkHCMDceobXs3YzHahMBMa1bvCejSDNxw
X-Received: by 2002:a65:5809:: with SMTP id g9mr21313875pgr.146.1576532155836;
 Mon, 16 Dec 2019 13:35:55 -0800 (PST)
Date:   Mon, 16 Dec 2019 13:35:26 -0800
In-Reply-To: <20191216213532.91237-1-bgardon@google.com>
Message-Id: <20191216213532.91237-4-bgardon@google.com>
Mime-Version: 1.0
References: <20191216213532.91237-1-bgardon@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v2 3/8] KVM: selftests: Add configurable demand paging delay
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

