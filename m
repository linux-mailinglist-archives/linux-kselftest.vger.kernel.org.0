Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E20389765
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 May 2021 22:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbhESUFX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 May 2021 16:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbhESUFR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 May 2021 16:05:17 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384B7C0613ED
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 13:03:57 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id l19-20020a0ce0930000b02901efdf1c21ecso8522718qvk.10
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 13:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pxqIK5GbpJxk8YmWf75fUOWsmXD3unOxy6kd0FXK5W0=;
        b=OF22+AuJmQNe/K+Mxj2Nyykz9DEdysYmqL4MHTbZyk0pc3gP2qQWZsA2w09gz8rOYO
         LTP7/INkbJXUmYFEtweFanIqC3TaJ/wikdkjMvnG7o6x9vIqmye8gYXYCsjrraJjRi3y
         lwJ+tgY+0PxeBjJQ+7RMSHYQ3QN4uhsHTG4/AVpfxmUnCJsRXDJu90bMPhXULkG68Te0
         rpZWQIkpWijBi2hvu6GPWgmv5l5kYElaNOYto3MXmKMPMl0YhxvOUuhnliO59NhDqBFm
         WfESqDv+PTEWG7eMFHtakXyvb1JV2I67IGW/FI4MjRCel6vdxuf8tjaHlBBMs4UO6ula
         OgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pxqIK5GbpJxk8YmWf75fUOWsmXD3unOxy6kd0FXK5W0=;
        b=KEAxLkjUm5azThSMVgFJewAQ8FxbxiJBZ3Kbyk5J1C875WUydwRp0F0Y6OCoX9XyVh
         AKTskrCsaayPE2UK6wMXzpiBXfir37AMHRY9+u/1gMouQJ7ZV1Ch2XsVRrgNkoCu2ECn
         AHm+5Xn60n6zeiIArG5TdHlFENC+tvkUpJQZT0ahwkDhwvMy0QwgBUlsRufPOSATPqjD
         d6bZ9wtY9qPlKFZ0rdgTQs2Jy6/I2kiYk1wDyWX1qF37PLKvASTfZUMXE383wB/ZhnlB
         V9CAGFDWjwQEAagETRHxJ8eXXnm8AGne2S6cl8pbeEfrkrcRmpYAUHTPVGnSpeanndY/
         v6cw==
X-Gm-Message-State: AOAM532HOror5Jsc7JEn4ROtOlwNYlfpwPIGjiKwdxBNTHxjmClSrfOE
        YE2i+lNaDGHOr6ZSxxH5/b/dbCOYMy2KPTckBjt1
X-Google-Smtp-Source: ABdhPJzqaEXTf/Jpwf88eR4yvVct5tPFpLqO1v8Dd9klagumFJxHeJpveSx8v9yl5oUqcEsQyF/npcsmE/YFrkBBHLOT
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:7eb5:10bb:834a:d5ec])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6214:11a3:: with SMTP id
 u3mr1487447qvv.6.1621454636342; Wed, 19 May 2021 13:03:56 -0700 (PDT)
Date:   Wed, 19 May 2021 13:03:33 -0700
In-Reply-To: <20210519200339.829146-1-axelrasmussen@google.com>
Message-Id: <20210519200339.829146-5-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210519200339.829146-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v2 04/10] KVM: selftests: compute correct demand paging size
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

This is a preparatory commit needed before we can use different kinds of
backing pages for guest memory.

Previously, we used perf_test_args.host_page_size, which is the host's
native page size (commonly 4K). For VM_MEM_SRC_ANONYMOUS this turns out
to be okay, but in a follow-up commit we want to allow using different
kinds of backing memory.

Take VM_MEM_SRC_ANONYMOUS_HUGETLB for example. Without this change, if
we used that backing page type, when we issued a UFFDIO_COPY ioctl we'd
only do so with 4K, rather than the full 2M of a backing hugepage. In
this case, UFFDIO_COPY returns -EINVAL (__mcopy_atomic_hugetlb checks
the size).

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/kvm/demand_paging_test.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 601a1df24dd2..94cf047358d5 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -40,6 +40,7 @@
 
 static int nr_vcpus = 1;
 static uint64_t guest_percpu_mem_size = DEFAULT_PER_VCPU_MEM_SIZE;
+static size_t demand_paging_size;
 static char *guest_data_prototype;
 
 static void *vcpu_worker(void *data)
@@ -85,7 +86,7 @@ static int handle_uffd_page_request(int uffd, uint64_t addr)
 
 	copy.src = (uint64_t)guest_data_prototype;
 	copy.dst = addr;
-	copy.len = perf_test_args.host_page_size;
+	copy.len = demand_paging_size;
 	copy.mode = 0;
 
 	clock_gettime(CLOCK_MONOTONIC, &start);
@@ -102,7 +103,7 @@ static int handle_uffd_page_request(int uffd, uint64_t addr)
 	PER_PAGE_DEBUG("UFFDIO_COPY %d \t%ld ns\n", tid,
 		       timespec_to_ns(ts_diff));
 	PER_PAGE_DEBUG("Paged in %ld bytes at 0x%lx from thread %d\n",
-		       perf_test_args.host_page_size, addr, tid);
+		       demand_paging_size, addr, tid);
 
 	return 0;
 }
@@ -261,10 +262,12 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 
 	perf_test_args.wr_fract = 1;
 
-	guest_data_prototype = malloc(perf_test_args.host_page_size);
+	demand_paging_size = get_backing_src_pagesz(VM_MEM_SRC_ANONYMOUS);
+
+	guest_data_prototype = malloc(demand_paging_size);
 	TEST_ASSERT(guest_data_prototype,
 		    "Failed to allocate buffer for guest data pattern");
-	memset(guest_data_prototype, 0xAB, perf_test_args.host_page_size);
+	memset(guest_data_prototype, 0xAB, demand_paging_size);
 
 	vcpu_threads = malloc(nr_vcpus * sizeof(*vcpu_threads));
 	TEST_ASSERT(vcpu_threads, "Memory allocation failed");
-- 
2.31.1.751.gd2f1c929bd-goog

