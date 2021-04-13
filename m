Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD3635D712
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Apr 2021 07:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244523AbhDMFSC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Apr 2021 01:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344468AbhDMFR7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Apr 2021 01:17:59 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02653C06134C
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Apr 2021 22:17:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 10so14981851ybu.18
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Apr 2021 22:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ArLA7VCb9t489S2A8vdExWcG4gs0ZfEI51msDdZxM/g=;
        b=UgWXUdE3GefvJEVOqa3TKqXsCgsdMGB3WMQdPFhHnZNIV4qJbriENFW22vE65M82He
         mBTniwEzW2nTjKQg/dmE56u1lM/vARivE/L7BvQtuFTFR6uaTv736jDv757nPHvgeDe3
         7SHXcFpeL/F9bay6OBw69RxJIJ3xPTBds5lbPHPa8aR5ovSQap6xtDaji4xiyQW4nNmC
         jTTCQK0OCZ39nqsb+PtWmiZnS6stOKExryQwdkAeqMdCgV8c+c+R2j/inFG+grv1Po0U
         KcUJa0HXgn9nr9X1nmqdc6VHP5spZiWd+jDktD8UXCBRYU2idpI5VJvnKNg4tQHzryLI
         6ZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ArLA7VCb9t489S2A8vdExWcG4gs0ZfEI51msDdZxM/g=;
        b=Tyh83HTOySfOfp/xUmzAjh8fe60/sN588Rb79yU4Upb5xIdIYtnqIaPnn3PJ5Y83cV
         IQCXFCHfEEZ+IjINK10ICXhHE31l9nw3M1DvxJ3q82cenhPMW/E3CIcRZR079vJrxHMG
         fWwRwmdMxpE2JqSp94zQ38WBLUfKnFvbjSaDW3OHT++cHnbdYlvmJCXBQThOXXAUy+vB
         ahk7oCKVVnQR+uCFscZ0yDkEe6FVSPCBjNAS3u01qMajZAEILcEuQCZpZ3ZXt7gDhOWK
         NA67LPQqVCmpbzA++M4//i0cqMciF52LqqevQjIb1+GrH4fiXqY8smHF6MfV1zwK3u5Z
         q45Q==
X-Gm-Message-State: AOAM531LNoK5Jvm5gFmucUP+rZE4W1LCS7GvcYOpAxB3tecF39+2VDuo
        jhIy+OHIpwmhXO8uv6yTxYP2DZW6lx7poTgfK+N2
X-Google-Smtp-Source: ABdhPJxlREUlX0akcn/j0mJkL3ThP0Bbbzj8wmNGOxirFNN4Dw+oA8j/af4iTNqKjttH8kXcqbgVCd/MvGWVwUdKrECm
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:d508:eee5:2d57:3e32])
 (user=axelrasmussen job=sendgmr) by 2002:a25:e6c7:: with SMTP id
 d190mr10780764ybh.394.1618291054231; Mon, 12 Apr 2021 22:17:34 -0700 (PDT)
Date:   Mon, 12 Apr 2021 22:17:17 -0700
In-Reply-To: <20210413051721.2896915-1-axelrasmussen@google.com>
Message-Id: <20210413051721.2896915-6-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210413051721.2896915-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v2 5/9] userfaultfd/selftests: use memfd_create for shmem test type
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
2.31.1.295.g9ea45b61b8-goog

