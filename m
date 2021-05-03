Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD01371F4C
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 May 2021 20:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbhECSJR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 May 2021 14:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbhECSJA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 May 2021 14:09:00 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6176C06138B
        for <linux-kselftest@vger.kernel.org>; Mon,  3 May 2021 11:07:56 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s8-20020a5b04480000b029049fb35700b9so8822767ybp.5
        for <linux-kselftest@vger.kernel.org>; Mon, 03 May 2021 11:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Xac2BuhJWUqyH5WnNjzkjLemK7LFrvUwXp8Wxy1Y0Zs=;
        b=Dp+eYm9V8pZWxqVn9dwHTmOQieeOZFLVSfiZ0cB8hyg/Se1Z0xBe3ZybxDqks2XPjY
         8UY79cMWP+Hjxb01Sw3pTvJ0KocvdaAW7w+lNbr++xYwJ3LBdxqsDvl37hdnwhLcIGkJ
         W901lPAsz24G6F3civKoUw7LlPZyZE85p3LpdSnc9T3I282uaYSz2ZaClGGV2NIuxODx
         s6C6PVVd5L6Y6Fywsuts+SizzKGyGBRgg8Bg2r5IrRM7rkaSxYjci6FH5h1vsPuNYT9G
         a4eaJbsGTfQJyzntteD/+XhOxllNr9eCBVCRyBiHKxy+a0MoZTknH98spga/D0k1x2a7
         VbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Xac2BuhJWUqyH5WnNjzkjLemK7LFrvUwXp8Wxy1Y0Zs=;
        b=Fkk56Nqs3wTmoj3swKkDi/6AUDygm+Zil6IlPgKU8z3zXPJw0jfWKrbFAIqMymvfJB
         41cwj4VhMQNIlnjiXXPmoj4Y7HDUK0KS4jDhf7DMvzbRm3gWf1bNdbCs1dqhiPDGZpW4
         Y93jFGztANIGphSdomluuxx4NQ/BeH3G8XcIYXHWmKiIe7UWzDSkXoUgvNvz4kzOcpW3
         ySCH/G21UHHTYIWaIwnypq+sJmU3TcFKY+ihwd4SAvJvF1AC8azO3XRHVtAcoNzWHz8p
         D59klAMYmqJvJUeO3Qhwy5W0mAIipzADNFM4CJwwIJ0AxkARYUlc+IhkW4T4tyJmfw5t
         KIaA==
X-Gm-Message-State: AOAM53226zTG6/yxVuO+xrG0upkvggeOx6l7+j/5B/kJ7jF4Z0GU/q3u
        ADXwv6JDvryEAipCc6+oOpkRZ5Z8vI2kovxEyQVB
X-Google-Smtp-Source: ABdhPJx+jXbiz0zAjVjFU2FT4iWpi3DJuyrx4MPp0buQPJJtAqRHzn6LRuVX4gpKOL6VG9z3xIXvY7lqv2L1UxWsKKT+
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:3d79:e69a:a4f9:ef0])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6902:4ab:: with SMTP id
 r11mr29737692ybs.70.1620065276077; Mon, 03 May 2021 11:07:56 -0700 (PDT)
Date:   Mon,  3 May 2021 11:07:34 -0700
In-Reply-To: <20210503180737.2487560-1-axelrasmussen@google.com>
Message-Id: <20210503180737.2487560-8-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210503180737.2487560-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH v6 07/10] userfaultfd/selftests: use memfd_create for shmem
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
2.31.1.527.g47e6f16901-goog

