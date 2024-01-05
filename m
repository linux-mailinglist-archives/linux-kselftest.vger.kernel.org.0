Return-Path: <linux-kselftest+bounces-2666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2C082573A
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 16:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D32AE1C2323A
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 15:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E55F2E852;
	Fri,  5 Jan 2024 15:54:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA3B2E82B;
	Fri,  5 Jan 2024 15:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55642663ac4so1967260a12.1;
        Fri, 05 Jan 2024 07:54:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704470073; x=1705074873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbaSpzmTDb6aKo/45GWljzrU5ASqXEKi0BCO7IaChNk=;
        b=QLVs0pqIHHmLfKiToMc8wDMRkcg4oA8ESfIhkBOieIQFDE80fQZCGCL+vMaPXMMKP2
         RxA4Xeoew33KpiMfBxAbDGQRqBfGjZALPX6rK652Q1OI9GTRyvNx3y7yOKHhqkFRUC9T
         58AUaHv9PlGgPkMzxMJeGnnms6jGUtAdS0Zvtvm3YqellC49Ut8mt8epWIy7EPNFUD6o
         1uSLGKdb8bnUUR+0E4qEszTfKzwayoNtYGOkYtyYffO92RE2xBdgR8CmoDs8+e/0wfd1
         QPoxxwlTs821XafYznEmt5/gcuoougZE8NSI4HpDFM9Vf7kAdlGVXyN4W+D1SdeVQ0X0
         2Kjg==
X-Gm-Message-State: AOJu0YxkshvPAmH10M4MZhy3SyK7xjShUfQWNc4kyt/PPuRY4X2/MI07
	XtF/6X5ujIZiz/op6Eif+6w=
X-Google-Smtp-Source: AGHT+IE+OteFp3sRNlrDPPup4dAsUX7gWH5CtQwy32Ik6ZXyC6MXvdMZUBr6Hmu7WFNnO4U3tU8cNg==
X-Received: by 2002:a50:8a96:0:b0:557:aff:2de8 with SMTP id j22-20020a508a96000000b005570aff2de8mr1213773edj.19.1704470072702;
        Fri, 05 Jan 2024 07:54:32 -0800 (PST)
Received: from localhost (fwdproxy-cln-007.fbsv.net. [2a03:2880:31ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id fd5-20020a056402388500b0055743d6e9ebsm227571edb.41.2024.01.05.07.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 07:54:32 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: riel@surriel.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	Shuah Khan <shuah@kernel.org>
Cc: vegard.nossum@oracle.com,
	rppt@kernel.org,
	songmuchun@bytedance.com,
	shy828301@gmail.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] selftests/mm: new test that steals pages
Date: Fri,  5 Jan 2024 07:54:19 -0800
Message-Id: <20240105155419.1939484-2-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105155419.1939484-1-leitao@debian.org>
References: <20240105155419.1939484-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test stresses the race between of madvise(DONTNEED), a page fault
and a parallel huge page mmap, which should fail due to lack of
available page available for mapping.

This test case must run on a system with one and only one huge page
available.

	# echo 1 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages

During setup, the test allocates the only available page, and starts
three threads:

  - thread 1:
      * madvise(MADV_DONTNEED) on the allocated huge page
  - thread 2:
      * Write to the allocated huge page
  - thread 3:
      * Tries to allocated (steal) an extra huge page (which is not
        available)

thread 3 should never succeed in the allocation, since the only huge
page was never unmapped, and should be reserved.

Touching the old page after thread3 allocation will raise a SIGBUS.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 .../selftests/mm/hugetlb_madv_vs_map.c        | 124 ++++++++++++++++++
 3 files changed, 126 insertions(+)
 create mode 100644 tools/testing/selftests/mm/hugetlb_madv_vs_map.c

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index 4ff10ea61461..d26e962f2ac4 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -46,3 +46,4 @@ gup_longterm
 mkdirty
 va_high_addr_switch
 hugetlb_fault_after_madv
+hugetlb_madv_vs_map
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index dede0bcf97a3..f6e42a773e1e 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -70,6 +70,7 @@ TEST_GEN_FILES += ksm_tests
 TEST_GEN_FILES += ksm_functional_tests
 TEST_GEN_FILES += mdwe_test
 TEST_GEN_FILES += hugetlb_fault_after_madv
+TEST_GEN_FILES += hugetlb_madv_vs_map
 
 ifneq ($(ARCH),arm64)
 TEST_GEN_FILES += soft-dirty
diff --git a/tools/testing/selftests/mm/hugetlb_madv_vs_map.c b/tools/testing/selftests/mm/hugetlb_madv_vs_map.c
new file mode 100644
index 000000000000..d01e8d4901d0
--- /dev/null
+++ b/tools/testing/selftests/mm/hugetlb_madv_vs_map.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A test case that must run on a system with one and only one huge page available.
+ *	# echo 1 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
+ *
+ * During setup, the test allocates the only available page, and starts three threads:
+ *  - thread1:
+ *	* madvise(MADV_DONTNEED) on the allocated huge page
+ *  - thread 2:
+ *	* Write to the allocated huge page
+ *  - thread 3:
+ *	* Try to allocated an extra huge page (which must not available)
+ *
+ *  The test fails if thread3 is able to allocate a page.
+ *
+ *  Touching the first page after thread3's allocation will raise a SIGBUS
+ *
+ *  Author: Breno Leitao <leitao@debian.org>
+ */
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
+	for (int i = 0; i < INLOOP_ITER; i++)
+		huge_ptr[0] = '.';
+
+	return NULL;
+}
+
+void *madv(void *unused)
+{
+	for (int i = 0; i < INLOOP_ITER; i++)
+		madvise(huge_ptr, MMAP_SIZE, MADV_DONTNEED);
+
+	return NULL;
+}
+
+/*
+ * We got here, and there must be no huge page available for mapping
+ * The other hugepage should be flipping from used <-> reserved, because
+ * of madvise(DONTNEED).
+ */
+void *map_extra(void *unused)
+{
+	void *ptr;
+
+	for (int i = 0; i < INLOOP_ITER; i++) {
+		ptr = mmap(NULL, MMAP_SIZE, PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
+			   -1, 0);
+
+		if ((long)ptr != -1) {
+			/* Touching the other page now will cause a SIGBUG
+			 * huge_ptr[0] = '1';
+			 */
+			return ptr;
+		}
+	}
+
+	return NULL;
+}
+
+int main(void)
+{
+	pthread_t thread1, thread2, thread3;
+	unsigned long free_hugepages;
+	void *ret;
+
+	/*
+	 * On kernel 6.7, we are able to reproduce the problem with ~10
+	 * interactions
+	 */
+	int max = 10;
+
+	free_hugepages = get_free_hugepages();
+
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
+		if ((unsigned long)huge_ptr == -1) {
+			ksft_exit_skip("Failed to allocated huge page\n");
+			return KSFT_SKIP;
+		}
+
+		pthread_create(&thread1, NULL, madv, NULL);
+		pthread_create(&thread2, NULL, touch, NULL);
+		pthread_create(&thread3, NULL, map_extra, NULL);
+
+		pthread_join(thread1, NULL);
+		pthread_join(thread2, NULL);
+		pthread_join(thread3, &ret);
+
+		if (ret) {
+			ksft_test_result_fail("Unexpected huge page allocation\n");
+			return KSFT_FAIL;
+		}
+
+		/* Unmap and restart */
+		munmap(huge_ptr, MMAP_SIZE);
+	}
+
+	return KSFT_PASS;
+}
-- 
2.34.1


