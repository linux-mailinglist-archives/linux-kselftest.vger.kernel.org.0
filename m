Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2232138975F
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 May 2021 22:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbhESUFN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 May 2021 16:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbhESUFM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 May 2021 16:05:12 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99CBC06175F
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 13:03:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o6-20020a5b06460000b02905004326697dso19340419ybq.22
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 13:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sHWgwzHAJQZkOzZGD0S/vC7GivbM7MzB6QxhNLB7L8s=;
        b=eAWLcMoREerr6JiMc4e3vDB9rwJ6zolGLuNmoO1Cmsw5ZzDFWWSBgaqfMbgcz7xQ2B
         DUKhtpBOvDTkVeqCo7pcEtnDXoM2i4wQjwvAewo9m4Tcb3JwlKnuCRPHYb53ozSnp4H5
         uuMRaCHgN4YzP02t6xES8vhZyVUu5ovT5qFfWIiIRBXPgEh2c+HEqKYZRrwzXtp0qD0W
         kmmMtD01NwiO/aLzQC+yjt4kbN5lZfRPILJsp1wYg/1J0dnpkcjJDs2rWRnQRu+wpmIC
         q1EUG68wIxTOkoAZXRxWW3fB3vbkopB40uuAyq3tO8U+RAumsVJcXnGWyEoXxTshhmgE
         wIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sHWgwzHAJQZkOzZGD0S/vC7GivbM7MzB6QxhNLB7L8s=;
        b=sS6j70ewomS0gKiAnahrJ/4PTciajycB0sQMSIz5pJTvYTIqW+H4hUGFXWREZ5IBC3
         wOLo+auG8X8we64zZssiY99gScwKENr5GsL7Pp3Gd5WpC4DHiaD4keFCe7PvPjl7zJiG
         HO60wGEsN37K7rFZMUhSwJ3ad13HbF5h60ocvwB3uHTeECb5TF/RwS1igPM/yUdKuaRT
         v92vSxAsu58jG652Q0DWJOls20t/qb45x2afvXRUoQIatCyMnC6M0QrhEeVOxIHaD0dV
         m5Txr+twZcoh1/2tXuMvAQkyTsAulj0ItwGMqb+96mBEUrNZyujYgeJvxKrdbSOuaJN7
         1PvA==
X-Gm-Message-State: AOAM532oejffmvGYOI+NIMCta5eaWMGZlApg1sTQSw9NaU/J8Wm6A5Up
        BYR4spKDMks4SL97LnSl4+PWnEuCxLk3DAVyavf4
X-Google-Smtp-Source: ABdhPJy0cO3HArp3/Jz9JVuS6aw8yiMrz/UFrn4Ktuh9ESWzku1GqVH13ey0vZRMeYYPRU2AHf3SrjKlXyJIgTQvgbbc
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:7eb5:10bb:834a:d5ec])
 (user=axelrasmussen job=sendgmr) by 2002:a25:38ca:: with SMTP id
 f193mr1873962yba.422.1621454631109; Wed, 19 May 2021 13:03:51 -0700 (PDT)
Date:   Wed, 19 May 2021 13:03:31 -0700
In-Reply-To: <20210519200339.829146-1-axelrasmussen@google.com>
Message-Id: <20210519200339.829146-3-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210519200339.829146-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v2 02/10] KVM: selftests: simplify setup_demand_paging error handling
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

A small cleanup. Our caller writes:

  r = setup_demand_paging(...);
  if (r < 0) exit(-r);

Since we're just going to exit anyway, instead of returning an error we
can just re-use TEST_ASSERT. This makes the caller simpler, as well as
the function itself - no need to write our branches, etc.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 .../selftests/kvm/demand_paging_test.c        | 51 +++++++------------
 1 file changed, 19 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 9398ba6ef023..601a1df24dd2 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -9,6 +9,8 @@
 
 #define _GNU_SOURCE /* for pipe2 */
 
+#include <inttypes.h>
+#include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
@@ -198,42 +200,32 @@ static void *uffd_handler_thread_fn(void *arg)
 	return NULL;
 }
 
-static int setup_demand_paging(struct kvm_vm *vm,
-			       pthread_t *uffd_handler_thread, int pipefd,
-			       useconds_t uffd_delay,
-			       struct uffd_handler_args *uffd_args,
-			       void *hva, uint64_t len)
+static void setup_demand_paging(struct kvm_vm *vm,
+				pthread_t *uffd_handler_thread, int pipefd,
+				useconds_t uffd_delay,
+				struct uffd_handler_args *uffd_args,
+				void *hva, uint64_t len)
 {
 	int uffd;
 	struct uffdio_api uffdio_api;
 	struct uffdio_register uffdio_register;
 
 	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
-	if (uffd == -1) {
-		pr_info("uffd creation failed\n");
-		return -1;
-	}
+	TEST_ASSERT(uffd >= 0, "uffd creation failed, errno: %d", errno);
 
 	uffdio_api.api = UFFD_API;
 	uffdio_api.features = 0;
-	if (ioctl(uffd, UFFDIO_API, &uffdio_api) == -1) {
-		pr_info("ioctl uffdio_api failed\n");
-		return -1;
-	}
+	TEST_ASSERT(ioctl(uffd, UFFDIO_API, &uffdio_api) != -1,
+		    "ioctl UFFDIO_API failed: %" PRIu64,
+		    (uint64_t)uffdio_api.api);
 
 	uffdio_register.range.start = (uint64_t)hva;
 	uffdio_register.range.len = len;
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
-	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) == -1) {
-		pr_info("ioctl uffdio_register failed\n");
-		return -1;
-	}
-
-	if ((uffdio_register.ioctls & UFFD_API_RANGE_IOCTLS) !=
-			UFFD_API_RANGE_IOCTLS) {
-		pr_info("unexpected userfaultfd ioctl set\n");
-		return -1;
-	}
+	TEST_ASSERT(ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) != -1,
+		    "ioctl UFFDIO_REGISTER failed");
+	TEST_ASSERT((uffdio_register.ioctls & UFFD_API_RANGE_IOCTLS) ==
+		    UFFD_API_RANGE_IOCTLS, "unexpected userfaultfd ioctl set");
 
 	uffd_args->uffd = uffd;
 	uffd_args->pipefd = pipefd;
@@ -243,8 +235,6 @@ static int setup_demand_paging(struct kvm_vm *vm,
 
 	PER_VCPU_DEBUG("Created uffd thread for HVA range [%p, %p)\n",
 		       hva, hva + len);
-
-	return 0;
 }
 
 struct test_params {
@@ -321,13 +311,10 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 				  O_CLOEXEC | O_NONBLOCK);
 			TEST_ASSERT(!r, "Failed to set up pipefd");
 
-			r = setup_demand_paging(vm,
-						&uffd_handler_threads[vcpu_id],
-						pipefds[vcpu_id * 2],
-						p->uffd_delay, &uffd_args[vcpu_id],
-						vcpu_hva, vcpu_mem_size);
-			if (r < 0)
-				exit(-r);
+			setup_demand_paging(vm, &uffd_handler_threads[vcpu_id],
+					    pipefds[vcpu_id * 2], p->uffd_delay,
+					    &uffd_args[vcpu_id], vcpu_hva,
+					    vcpu_mem_size);
 		}
 	}
 
-- 
2.31.1.751.gd2f1c929bd-goog

