Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8D17B862A
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 19:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243645AbjJDRMR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Oct 2023 13:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243627AbjJDRMR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Oct 2023 13:12:17 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48B69E;
        Wed,  4 Oct 2023 10:12:13 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-533d6a8d6b6so4526286a12.2;
        Wed, 04 Oct 2023 10:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696439532; x=1697044332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8ih6B2Rlcxp81srnkWek1jGwJ1l7RM9hd1ykDQtxDA=;
        b=aY4OAPMk7QKIAcgujy1hvKphtahUrxQ3db6f4doHZDcErMnLwDIweCWgsM+dyS2vJt
         Qn/6RJ63LHEH2tQHB4mBLs1SdrZ6o62iKwqCl514aMQzyQhy7dpf+ikMzvZzZpY8JSHA
         WCSNLshvBEKbUXtu7vcBUcj0UktN986TogNh6bl+4GKZMatKKTQ0AQ1tj9YtAp1wWvHV
         9Z9AR1c8jHfzFrjfZ6R8vF5hiyi9KAfZcxkQQiNbcnPUWRqGsn90Do87z49L+Ucn+pqI
         I5Zw1skzwsmC1Zc+szeGs8o/gsQB0S06WeSKzFLmhEdqOIsUb23ttzmfPtzmbJamiTEc
         FKNA==
X-Gm-Message-State: AOJu0Yw6BQQmW6iX7YkB9zuz/Lsh/QxeGuh+2fWGwynNX4pdD6uMbDuC
        Q1ug+61HnyZ9d7DrKGsb/1Y=
X-Google-Smtp-Source: AGHT+IGBToqvNL/hEcJArvik0DADNV1zdswIJEVmop94ejSDsVbBAfm79zjk87sbIoIzygWd/MmBMQ==
X-Received: by 2002:a17:906:309a:b0:9b7:1e26:e2de with SMTP id 26-20020a170906309a00b009b71e26e2demr2388918ejv.21.1696439532120;
        Wed, 04 Oct 2023 10:12:12 -0700 (PDT)
Received: from localhost (fwdproxy-cln-025.fbsv.net. [2a03:2880:31ff:19::face:b00c])
        by smtp.gmail.com with ESMTPSA id g10-20020a170906348a00b0099bd0b5a2bcsm3108543ejb.101.2023.10.04.10.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 10:12:11 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     mike.kravetz@oracle.com, muchun.song@linux.dev,
        akpm@linux-foundation.org, Shuah Khan <shuah@kernel.org>
Cc:     linux-mm@kvack.org, riel@surriel.com,
        linux-kernel@vger.kernel.org (open list),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH 2/2] selftests/mm: Add a new test for madv and hugetlb
Date:   Wed,  4 Oct 2023 10:11:26 -0700
Message-Id: <20231004171127.106056-2-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004171127.106056-1-leitao@debian.org>
References: <20231004171127.106056-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Create a selftest that exercises the conflict between page faults and
madvise(MADV_DONTNEED) in the same huge page. Do it by running two
threads that touches the huge page and madvise(MADV_DONTNEED) at the same
time.

In case of a SIGBUS coming at pagefault, the test should fail, since we
hit the bug.

The test doesn't have a signal handler, and if it fails, it fails like
the following

  ----------------------------------
  running ./hugetlb_fault_after_madv
  ----------------------------------
  ./run_vmtests.sh: line 186: 595563 Bus error    (core dumped) "$@"
  [FAIL]

This selftest goes together with the fix of the bug[1] itself.

[1] https://lore.kernel.org/all/20231001005659.2185316-1-riel@surriel.com/#r

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/mm/Makefile           |  1 +
 .../selftests/mm/hugetlb_fault_after_madv.c   | 82 +++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh     |  4 +
 3 files changed, 87 insertions(+)
 create mode 100644 tools/testing/selftests/mm/hugetlb_fault_after_madv.c

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 6a9fc5693145..e71ec9910c62 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -68,6 +68,7 @@ TEST_GEN_FILES += split_huge_page_test
 TEST_GEN_FILES += ksm_tests
 TEST_GEN_FILES += ksm_functional_tests
 TEST_GEN_FILES += mdwe_test
+TEST_GEN_FILES += hugetlb_fault_after_madv
 
 ifneq ($(ARCH),arm64)
 TEST_GEN_PROGS += soft-dirty
diff --git a/tools/testing/selftests/mm/hugetlb_fault_after_madv.c b/tools/testing/selftests/mm/hugetlb_fault_after_madv.c
new file mode 100644
index 000000000000..d6d38d443840
--- /dev/null
+++ b/tools/testing/selftests/mm/hugetlb_fault_after_madv.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <pthread.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include "vm_util.h"
+
+#define MMAP_SIZE (1 << 21)
+#define INLOOP_ITER 100
+
+char *huge_ptr;
+
+/* Touch the memory while it is being madvised() */
+void *touch(void *unused)
+{
+	char *ptr = (char *)huge_ptr;
+
+	if (!ptr) {
+		fprintf(stderr, "Failed to allocate memory\n");
+		perror("");
+	}
+
+	for (int i = 0; i < INLOOP_ITER; i++)
+		ptr[0] = '.';
+
+	return NULL;
+}
+
+void *madv(void *unused)
+{
+	usleep(rand() % 10);
+	if (!huge_ptr)
+		return NULL;
+
+	for (int i = 0; i < INLOOP_ITER; i++)
+		madvise(huge_ptr, MMAP_SIZE, MADV_DONTNEED);
+
+	return NULL;
+}
+
+int main(void)
+{
+	unsigned long free_hugepages;
+	pthread_t thread1, thread2;
+	/*
+	 * On kernel 6.4, we are able to reproduce the problem with ~1000
+	 * interactions
+	 */
+	int max = 10000;
+
+	srand(getpid());
+
+	free_hugepages = get_free_hugepages();
+	if (free_hugepages != 1) {
+		fprintf(stderr,
+			"This test needs one and only one page to execute. Got %lu\n",
+			free_hugepages);
+		exit(1);
+	}
+
+	while (max--) {
+		huge_ptr = mmap(NULL, MMAP_SIZE, PROT_READ | PROT_WRITE,
+				MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
+
+		if ((unsigned long)huge_ptr == -1) {
+			perror("Failed to allocate\n");
+			continue;
+		}
+
+		pthread_create(&thread1, NULL, madv, NULL);
+		pthread_create(&thread2, NULL, touch, NULL);
+
+		pthread_join(thread1, NULL);
+		pthread_join(thread2, NULL);
+		munmap(huge_ptr, MMAP_SIZE);
+	}
+
+	return 0;
+}
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 3e2bc818d566..9f53f7318a38 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -221,6 +221,10 @@ CATEGORY="hugetlb" run_test ./hugepage-mremap
 CATEGORY="hugetlb" run_test ./hugepage-vmemmap
 CATEGORY="hugetlb" run_test ./hugetlb-madvise
 
+# For this test, we need one and just one huge page
+echo 1 > /proc/sys/vm/nr_hugepages
+CATEGORY="hugetlb" run_test ./hugetlb_fault_after_madv
+
 if test_selected "hugetlb"; then
 	echo "NOTE: These hugetlb tests provide minimal coverage.  Use"
 	echo "      https://github.com/libhugetlbfs/libhugetlbfs.git for"
-- 
2.34.1

