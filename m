Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9900B38976F
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 May 2021 22:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbhESUFk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 May 2021 16:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbhESUFZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 May 2021 16:05:25 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E035CC06175F
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 13:04:02 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id v3-20020a0cdd830000b02901efe0c3571eso8469286qvk.5
        for <linux-kselftest@vger.kernel.org>; Wed, 19 May 2021 13:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HFkF1APt128Gb87FitaIP1LHWqXE7g4u5TT6f2wQ4F0=;
        b=WOlaU86HU/1wiYQFXxW5ZuNPd81yF5F3h/5AfU4FJMy585nY5GOaPe77m4ekQ2FSrh
         Mv1mHaP6YHLsueVlI1yCyW3fcfmDJhldtTmpq+lMSD2IHAB0XtXNJASRoqZFSYaq57Bp
         wLlitL1XcNBkcfgcuhYX4y1ZgGDdQbuTE9utqumoUpXb5wIOpXGhqsvI//9lOFNnn+VM
         FP1l14uYKc9N56P9Kd4qsiQGMawv//GlPha5iLE5JfkesYSpfIxNEWBndm1rssByWTmT
         AXv1jV99VT+M6wWwBTKZfP4CMQaXW/dzMkmkQQoN5iR3emQbm1JcdnbBNf4k03KUyKEB
         m4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HFkF1APt128Gb87FitaIP1LHWqXE7g4u5TT6f2wQ4F0=;
        b=CUa7I7RFlt2f1d8h9oIxsC3G0aCY5NOd+xi3OsmhcUqYUIJh/x9VtGmTdxIZZ0Bd9i
         LbPCDocdioIA7FY8nfuBQ6kFyduukINI7gxMrWPpTNHOiKJcTz8pT4kHVN+wT/9XNDQW
         /zFHfArTiiXfy6Bfp2LZSxU0tjA8U66sam586kjc8GJR+HTLIUzgbXdX1TOTQ3dAxC9m
         yiQ5GUBvFA6E8XFJcdOYT38YnPIMBVRx7IgomLsolnQyGxR+PMzEmlMH7toRbjnRF/3g
         I9I1/RqKMHFE8B7a4wBUOsjT6SN0/KrjKFcgYbfZTxtSJBm9cYihwCHIUjtR2QBwHxfe
         D8HA==
X-Gm-Message-State: AOAM531oDpjS/dW3dnv2LfZ8KHV9PbK8qclDS6LBUKl3SARVK33l/ZUE
        tMnsejBjMVSC/GxZ1q0V5wwMYjIoXTDNdmJBC4fc
X-Google-Smtp-Source: ABdhPJyiZ+Rq5FjXeCEqxMO3jbjzy8mY/ImH09Brk7H0/NIoihv7vEAq8zEuV/CaXrO+mt4U9hKoVUvSt3ppwkXoaINv
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:7eb5:10bb:834a:d5ec])
 (user=axelrasmussen job=sendgmr) by 2002:a0c:e709:: with SMTP id
 d9mr1270050qvn.19.1621454641916; Wed, 19 May 2021 13:04:01 -0700 (PDT)
Date:   Wed, 19 May 2021 13:03:36 -0700
In-Reply-To: <20210519200339.829146-1-axelrasmussen@google.com>
Message-Id: <20210519200339.829146-8-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210519200339.829146-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v2 07/10] KVM: selftests: add shmem backing source type
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

This lets us run the demand paging test on top of a shmem-backed area.
In follow-up commits, we'll 1) leverage this new capability to create an
alias mapping, and then 2) use the alias mapping to exercise UFFD minor
faults.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/kvm/include/test_util.h |  1 +
 tools/testing/selftests/kvm/lib/kvm_util.c      | 15 +++++++++++++++
 tools/testing/selftests/kvm/lib/test_util.c     |  5 +++++
 3 files changed, 21 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index fade3130eb01..7377f00469ef 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -84,6 +84,7 @@ enum vm_mem_backing_src_type {
 	VM_MEM_SRC_ANONYMOUS_HUGETLB_1GB,
 	VM_MEM_SRC_ANONYMOUS_HUGETLB_2GB,
 	VM_MEM_SRC_ANONYMOUS_HUGETLB_16GB,
+	VM_MEM_SRC_SHMEM,
 	NUM_SRC_TYPES,
 };
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index bc405785ac8b..e4a8d0c43c5e 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -757,6 +757,21 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	if (alignment > 1)
 		region->mmap_size += alignment;
 
+	region->fd = -1;
+	if (src_type == VM_MEM_SRC_SHMEM) {
+		region->fd = memfd_create("kvm_selftest", MFD_CLOEXEC);
+		TEST_ASSERT(region->fd != -1,
+			    "memfd_create failed, errno: %i", errno);
+
+		ret = ftruncate(region->fd, region->mmap_size);
+		TEST_ASSERT(ret == 0, "ftruncate failed, errno: %i", errno);
+
+		ret = fallocate(region->fd,
+				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0,
+				region->mmap_size);
+		TEST_ASSERT(ret == 0, "fallocate failed, errno: %i", errno);
+	}
+
 	region->mmap_start = mmap(NULL, region->mmap_size,
 				  PROT_READ | PROT_WRITE,
 				  vm_mem_backing_src_alias(src_type)->flag,
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index 06ddde068736..c7a265da5090 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -236,6 +236,10 @@ const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i)
 			.name = "anonymous_hugetlb_16gb",
 			.flag = anon_huge_flags | MAP_HUGE_16GB,
 		},
+		[VM_MEM_SRC_SHMEM] = {
+			.name = "shmem",
+			.flag = MAP_SHARED,
+		},
 	};
 	_Static_assert(ARRAY_SIZE(aliases) == NUM_SRC_TYPES,
 		       "Missing new backing src types?");
@@ -253,6 +257,7 @@ size_t get_backing_src_pagesz(uint32_t i)
 
 	switch (i) {
 	case VM_MEM_SRC_ANONYMOUS:
+	case VM_MEM_SRC_SHMEM:
 		return getpagesize();
 	case VM_MEM_SRC_ANONYMOUS_THP:
 		return get_trans_hugepagesz();
-- 
2.31.1.751.gd2f1c929bd-goog

