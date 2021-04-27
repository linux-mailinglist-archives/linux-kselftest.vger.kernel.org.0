Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD3F36CEEC
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Apr 2021 00:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbhD0WyA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Apr 2021 18:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237144AbhD0Wx7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Apr 2021 18:53:59 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E7CC061574
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Apr 2021 15:53:12 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id p8-20020a17090a74c8b02901558c0dbcd5so4355067pjl.2
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Apr 2021 15:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=u1gk9aiwDmv6+SRZ0ft4k2Rli22/pgCpQ8yAo+qVnNA=;
        b=WhttcOh6OlYlGtQYO3hqYvxXeiYuKV+rWQSt5GADJGax/zVklA+4aVWY6Vth1HSH3X
         jwqi4xlCmJmF2uk4C3mUlO9dXP5GKLMafa/YYpnFpCz7vDawNizmXlGB6yjOLRbWnnjs
         zUKKD0pPXPMq+GNf9mgcyCiC+JYB1W0gdtCctKXlHEeJk0mX+xU28z2b6gRtk8Yu85nl
         2JjUUN+ND3iO+ubDxIVQYc87lZwqiydAQ90ZMWi5SimqntNNm/EZWf8oo0PfH30L05ai
         eXKCJjGA7iP4ZQy64cNZRCZh9nqI8vq5hUhkIc2nfyfHUBlBdiVJlltPIDFueWEmrOik
         S4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u1gk9aiwDmv6+SRZ0ft4k2Rli22/pgCpQ8yAo+qVnNA=;
        b=WcaRBi088EvetXQSABOfk+U1T0dpxN3fiWKeehxcT9uTlFA1Tp4VGRu0gssOYKGiK2
         gw53ln8VxzkQeZCUlDvdvclfj1x9Nuc/jgsg2WP1JHwyRxFQwkTAmLlZqnVvGkT5uNHL
         yo7GWI+U3ssfCzm3bSF98+Hd4RRFFZ4flj2SiisurK7RXsOzD5XtmW7/DZBfogkhfi8i
         QxlkwgYmivyIOi8hnY/ERvSzaVNo9rnC8E3QYNscOZYp0jYW4TvGMmD8mF+KJiw6s/q4
         xUW8CU5hLPZYCLKnutbygLfSa+j2pIF+/e6TYt/r8+z6NhEeo45hdmAXnFslm0kIZUn8
         LyyQ==
X-Gm-Message-State: AOAM531/iev4YJxkO6nmPwEUe5lFKqQPWXNIi24A6NyK4oY20ejz2h2+
        LFysz0wKPsphqBdxkLDv0uaRtVkmaHiDxX7bGaQr
X-Google-Smtp-Source: ABdhPJwiDFSleswhpJEUOz8lD3obBc43FvS6xslLfDjp1Gi5RYfDgRHiZ7zkrRDES+WQD/M44l98muWb/GGEwvLSrFN1
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:c423:570b:b823:c33e])
 (user=axelrasmussen job=sendgmr) by 2002:a0c:fcc8:: with SMTP id
 i8mr14211207qvq.31.1619563981243; Tue, 27 Apr 2021 15:53:01 -0700 (PDT)
Date:   Tue, 27 Apr 2021 15:52:41 -0700
In-Reply-To: <20210427225244.4326-1-axelrasmussen@google.com>
Message-Id: <20210427225244.4326-8-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210427225244.4326-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH v5 07/10] userfaultfd/selftests: use memfd_create for shmem
 test type
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Axel Rasmussen <axelrasmussen@google.com>,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a preparatory commit. In the future, we want to be able to setup
alias mappings for area_src and area_dst in the shmem test, like we do
in the hugetlb_shared test. With a VMA obtained via
mmap(MAP_ANONYMOUS | MAP_SHARED), it isn't clear how to do this.

So, mmap() with an fd, so we can create alias mappings. Use memfd_create
instead of actually passing in a tmpfs path like hugetlb does, since
it's more convenient / simpler to run, and works just as well.

Future commits will:

1. Setup the alias mappings.
2. Extend our tests to actually take advantage of this, to test new
   userfaultfd behavior being introduced in this series.

Also, a small fix in the area we're changing: when the hugetlb setup
fails in main(), pass in the right argv[] so we actually print out the
hugetlb file path.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 6339aeaeeff8..fc40831f818f 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -85,6 +85,7 @@ static bool test_uffdio_wp = false;
 static bool test_uffdio_minor = false;
 
 static bool map_shared;
+static int shm_fd;
 static int huge_fd;
 static char *huge_fd_off0;
 static unsigned long long *count_verify;
@@ -277,8 +278,11 @@ static void shmem_release_pages(char *rel_area)
 
 static void shmem_allocate_area(void **alloc_area)
 {
+	unsigned long offset =
+		alloc_area == (void **)&area_src ? 0 : nr_pages * page_size;
+
 	*alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
-			   MAP_ANONYMOUS | MAP_SHARED, -1, 0);
+			   MAP_SHARED, shm_fd, offset);
 	if (*alloc_area == MAP_FAILED)
 		err("mmap of memfd failed");
 }
@@ -1448,6 +1452,16 @@ int main(int argc, char **argv)
 			err("Open of %s failed", argv[4]);
 		if (ftruncate(huge_fd, 0))
 			err("ftruncate %s to size 0 failed", argv[4]);
+	} else if (test_type == TEST_SHMEM) {
+		shm_fd = memfd_create(argv[0], 0);
+		if (shm_fd < 0)
+			err("memfd_create");
+		if (ftruncate(shm_fd, nr_pages * page_size * 2))
+			err("ftruncate");
+		if (fallocate(shm_fd,
+			      FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0,
+			      nr_pages * page_size * 2))
+			err("fallocate");
 	}
 	printf("nr_pages: %lu, nr_pages_per_cpu: %lu\n",
 	       nr_pages, nr_pages_per_cpu);
-- 
2.31.1.498.g6c1eba8ee3d-goog

