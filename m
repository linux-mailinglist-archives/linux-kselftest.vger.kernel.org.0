Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6927BA74A
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Oct 2023 19:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjJERHp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Oct 2023 13:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjJERGl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Oct 2023 13:06:41 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BA0207B;
        Thu,  5 Oct 2023 09:39:36 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-99bdcade7fbso211219866b.1;
        Thu, 05 Oct 2023 09:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696523975; x=1697128775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aeCkyhaoVtwv2wfDF/uieHTmRe6erji0RQ2H7V1G/pc=;
        b=CLw9XcKUTcoR9FNDESw3k0ELvfHePCiAn9UfPvIdrswW7yHR321+2KywQNGU6uEAob
         Rb4BeWafDXt2gR2ruaF+KiT0FuxHBSjO7R/TNIeKx5GaKwAKWORgd4JbmImr2bkxCef8
         S2WGjkl1xXomCnysijRtoPiXupaH5D6/YkoDP2oqZWSeGdb19AFPt6T5ylzEyl0RoWKb
         P83cElJkGVFbhrE9mNhEVF3WF+ZItEvyesmvaLEK0aYqTBUeUVRCJ5iqAS726kJOGLBn
         0WpSu7rkyWFVPFxAOhyR043PtNFf9eSH8n2I0yl2UfozBfgBhNQdGYxA4mobJh/Hg8+9
         ytDQ==
X-Gm-Message-State: AOJu0Yzh7735sb/9Y4uNpdwlqVtbhgW5a0mcvSdM8p6knfJLodH7B+11
        A59KqAkcI8865ikCUF2inis=
X-Google-Smtp-Source: AGHT+IFXpAGpAAJi5gJLJd/ylndngGVZYM9m0IP6Ma0EXz8nnBppGgbm8KmKKvk2XKyTTj6Y5Uz/ww==
X-Received: by 2002:a17:906:cc2:b0:9ae:5db5:149 with SMTP id l2-20020a1709060cc200b009ae5db50149mr5073326ejh.35.1696523974869;
        Thu, 05 Oct 2023 09:39:34 -0700 (PDT)
Received: from localhost (fwdproxy-cln-021.fbsv.net. [2a03:2880:31ff:15::face:b00c])
        by smtp.gmail.com with ESMTPSA id w13-20020a170906480d00b0099b76c3041csm1447289ejq.7.2023.10.05.09.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 09:39:34 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     mike.kravetz@oracle.com, muchun.song@linux.dev,
        akpm@linux-foundation.org, Shuah Khan <shuah@kernel.org>
Cc:     linux-mm@kvack.org, riel@surriel.com,
        linux-kernel@vger.kernel.org (open list),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH v2 2/2] selftests/mm: Add a new test for madv and hugetlb
Date:   Thu,  5 Oct 2023 09:39:22 -0700
Message-Id: <20231005163922.87568-3-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005163922.87568-1-leitao@debian.org>
References: <20231005163922.87568-1-leitao@debian.org>
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

Create a selftest that exercises the race between page faults and
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
 .../selftests/mm/hugetlb_fault_after_madv.c   | 73 +++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh     |  4 +
 3 files changed, 78 insertions(+)
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
index 000000000000..73b81c632366
--- /dev/null
+++ b/tools/testing/selftests/mm/hugetlb_fault_after_madv.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <pthread.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include "vm_util.h"
+#include "../kselftest.h"
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
+	for (int i = 0; i < INLOOP_ITER; i++)
+		ptr[0] = '.';
+
+	return NULL;
+}
+
+void *madv(void *unused)
+{
+	usleep(rand() % 10);
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
+		ksft_exit_skip("This test needs one and only one page to execute. Got %lu\n",
+			       free_hugepages);
+	}
+
+	while (max--) {
+		huge_ptr = mmap(NULL, MMAP_SIZE, PROT_READ | PROT_WRITE,
+				MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
+				-1, 0);
+
+		if ((unsigned long)huge_ptr == -1)
+			ksft_exit_skip("Failed to allocated huge page\n");
+
+		pthread_create(&thread1, NULL, madv, NULL);
+		pthread_create(&thread2, NULL, touch, NULL);
+
+		pthread_join(thread1, NULL);
+		pthread_join(thread2, NULL);
+		munmap(huge_ptr, MMAP_SIZE);
+	}
+
+	return KSFT_PASS;
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

