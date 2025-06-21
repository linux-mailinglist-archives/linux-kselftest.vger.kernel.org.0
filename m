Return-Path: <linux-kselftest+bounces-35531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CECD7AE26BD
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 02:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85C7C17350A
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 00:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F75101EE;
	Sat, 21 Jun 2025 00:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QKHZpPnV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CC1946F
	for <linux-kselftest@vger.kernel.org>; Sat, 21 Jun 2025 00:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750466912; cv=none; b=O2fcdqXEVpL+N3yJeLvsqRW6LrLISadTn7kfdxU4WaPn+l20uE6yVVRAb2xt2smUkWhFu9ZspZNQqBpBugy/dNEvuUbQrQnDlbZUWz+590ap7PhUasCDFD3TqvhsM8U+PYEZXQ9LILlFD5x7FcMz3W0p5XpoUiHtWOiOWwLjN7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750466912; c=relaxed/simple;
	bh=U0JwxxIfwXvGo6vMahD+cNcGsEiy9pwPwz5Y3tqlH2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NmoTbYs+dd4Aiw1o/Zegfh3qLw12FPmR7G2st/N90YpjWw7MavQ3R5JZK1yyZbdPWrdf6XQF7T/PxO4wdqWDpR3tw30vqF3MW+NyL6eX/gL1Jdw/DdnNHYEAgQfXbgLyqogjbTjWK7zECIlwvQTyp2E42jol4JMZ+V4nVYiWjLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QKHZpPnV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750466907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FkU+gPOIhbeinrV8TQvkcE3b9DDKVV+TZ4jA0J9V37s=;
	b=QKHZpPnV/uKWsLaHUJp7wbohnOt14HWbcf65wavpKlnZKk9PA3xxKDN9UDqvYFMn9qMqfP
	h4KPzNrYrKkkqwgWTg1J6tXNlVrL0wzzjwT5nvnNfOrk+XR8EasSlJsIB1/xfXYYPhSZVy
	7QiR8Nd+ImZeHRX6MqA71wldx3yjTK8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-PSBpcU_WONG57eYCaXboZg-1; Fri,
 20 Jun 2025 20:48:23 -0400
X-MC-Unique: PSBpcU_WONG57eYCaXboZg-1
X-Mimecast-MFC-AGG-ID: PSBpcU_WONG57eYCaXboZg_1750466902
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0186E19560AD;
	Sat, 21 Jun 2025 00:48:21 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05352180045B;
	Sat, 21 Jun 2025 00:48:13 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: akpm@linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Keith Lucas <keith.lucas@oracle.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH] ksm_tests: Skip hugepage test when Transparent Hugepages are disabled
Date: Sat, 21 Jun 2025 08:48:08 +0800
Message-ID: <20250621004808.368878-1-liwang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Some systems (e.g. minimal or real-time kernels) may not enable
Transparent Hugepages (THP), causing MADV_HUGEPAGE to return EINVAL.
This patch introduces a runtime check using the existing THP sysfs
interface and skips the hugepage merging test (`-H`) when THP is
not available.

To avoid those failures:

  # -----------------------------
  # running ./ksm_tests -H -s 100
  # -----------------------------
  # ksm_tests: MADV_HUGEPAGE: Invalid argument
  # [FAIL]
  not ok 1 ksm_tests -H -s 100 # exit=2

  # --------------------
  # running ./khugepaged
  # --------------------
  # Reading PMD pagesize failed# [FAIL]
  not ok 1 khugepaged # exit=1

  # --------------------
  # running ./soft-dirty
  # --------------------
  # TAP version 13
  # 1..15
  # ok 1 Test test_simple
  # ok 2 Test test_vma_reuse dirty bit of allocated page
  # ok 3 Test test_vma_reuse dirty bit of reused address page
  # Bail out! Reading PMD pagesize failed# Planned tests != run tests (15 != 3)
  # # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
  # [FAIL]
  not ok 1 soft-dirty # exit=1
  # SUMMARY: PASS=0 SKIP=0 FAIL=1

  # -------------------
  # running ./migration
  # -------------------
  # TAP version 13
  # 1..3
  # # Starting 3 tests from 1 test cases.
  # #  RUN           migration.private_anon ...
  # #            OK  migration.private_anon
  # ok 1 migration.private_anon
  # #  RUN           migration.shared_anon ...
  # #            OK  migration.shared_anon
  # ok 2 migration.shared_anon
  # #  RUN           migration.private_anon_thp ...
  # # migration.c:196:private_anon_thp:Expected madvise(ptr, TWOMEG, MADV_HUGEPAGE) (-1) == 0 (0)
  # # private_anon_thp: Test terminated by assertion
  # #          FAIL  migration.private_anon_thp
  # not ok 3 migration.private_anon_thp
  # # FAILED: 2 / 3 tests passed.
  # # Totals: pass:2 fail:1 xfail:0 xpass:0 skip:0 error:0
  # [FAIL]
  not ok 1 migration # exit=1

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Keith Lucas <keith.lucas@oracle.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
---
 tools/testing/selftests/mm/khugepaged.c   |  5 +++++
 tools/testing/selftests/mm/ksm_tests.c    |  6 ++++++
 tools/testing/selftests/mm/migration.c    |  8 ++++++++
 tools/testing/selftests/mm/soft-dirty.c   |  9 ++++++++-
 tools/testing/selftests/mm/thp_settings.c | 11 +++++++++++
 tools/testing/selftests/mm/thp_settings.h |  2 ++
 6 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
index 8a4d34cce36b..6822eb7ea58e 100644
--- a/tools/testing/selftests/mm/khugepaged.c
+++ b/tools/testing/selftests/mm/khugepaged.c
@@ -1190,6 +1190,11 @@ int main(int argc, char **argv)
 		.read_ahead_kb = 0,
 	};
 
+	if (!thp_is_enabled()) {
+		printf("Transparent Hugepages not available\n");
+		return KSFT_SKIP;
+	}
+
 	parse_test_type(argc, argv);
 
 	setbuf(stdout, NULL);
diff --git a/tools/testing/selftests/mm/ksm_tests.c b/tools/testing/selftests/mm/ksm_tests.c
index dcdd5bb20f3d..1fb2263faa8d 100644
--- a/tools/testing/selftests/mm/ksm_tests.c
+++ b/tools/testing/selftests/mm/ksm_tests.c
@@ -15,6 +15,7 @@
 #include "../kselftest.h"
 #include <include/vdso/time64.h>
 #include "vm_util.h"
+#include "thp_settings.h"
 
 #define KSM_SYSFS_PATH "/sys/kernel/mm/ksm/"
 #define KSM_FP(s) (KSM_SYSFS_PATH s)
@@ -555,6 +556,11 @@ static int ksm_merge_hugepages_time(int merge_type, int mapping, int prot,
 	unsigned long scan_time_ns;
 	int pagemap_fd, n_normal_pages, n_huge_pages;
 
+	if (!thp_is_enabled()) {
+		printf("Transparent Hugepages not available\n");
+		return KSFT_SKIP;
+	}
+
 	map_size *= MB;
 	size_t len = map_size;
 
diff --git a/tools/testing/selftests/mm/migration.c b/tools/testing/selftests/mm/migration.c
index 1e3a595fbf01..a306f8bab087 100644
--- a/tools/testing/selftests/mm/migration.c
+++ b/tools/testing/selftests/mm/migration.c
@@ -5,6 +5,8 @@
  */
 
 #include "../kselftest_harness.h"
+#include "thp_settings.h"
+
 #include <strings.h>
 #include <pthread.h>
 #include <numa.h>
@@ -185,6 +187,9 @@ TEST_F_TIMEOUT(migration, private_anon_thp, 2*RUNTIME)
 	uint64_t *ptr;
 	int i;
 
+	if (!thp_is_enabled())
+		SKIP(return, "Transparent Hugepages not available");
+
 	if (self->nthreads < 2 || self->n1 < 0 || self->n2 < 0)
 		SKIP(return, "Not enough threads or NUMA nodes available");
 
@@ -214,6 +219,9 @@ TEST_F_TIMEOUT(migration, shared_anon_thp, 2*RUNTIME)
 	uint64_t *ptr;
 	int i;
 
+	if (!thp_is_enabled())
+		SKIP(return, "Transparent Hugepages not available");
+
 	if (self->nthreads < 2 || self->n1 < 0 || self->n2 < 0)
 		SKIP(return, "Not enough threads or NUMA nodes available");
 
diff --git a/tools/testing/selftests/mm/soft-dirty.c b/tools/testing/selftests/mm/soft-dirty.c
index 8e1462ce0532..72d8ded87756 100644
--- a/tools/testing/selftests/mm/soft-dirty.c
+++ b/tools/testing/selftests/mm/soft-dirty.c
@@ -6,8 +6,10 @@
 #include <stdint.h>
 #include <malloc.h>
 #include <sys/mman.h>
+
 #include "../kselftest.h"
 #include "vm_util.h"
+#include "thp_settings.h"
 
 #define PAGEMAP_FILE_PATH "/proc/self/pagemap"
 #define TEST_ITERATIONS 10000
@@ -78,8 +80,13 @@ static void test_hugepage(int pagemap_fd, int pagesize)
 {
 	char *map;
 	int i, ret;
-	size_t hpage_len = read_pmd_pagesize();
 
+	if (!thp_is_enabled()) {
+		printf("Skipping test: Transparent Hugepages not available\n");
+		return KSFT_SKIP;
+	}
+
+	size_t hpage_len = read_pmd_pagesize();
 	if (!hpage_len)
 		ksft_exit_fail_msg("Reading PMD pagesize failed");
 
diff --git a/tools/testing/selftests/mm/thp_settings.c b/tools/testing/selftests/mm/thp_settings.c
index ad872af1c81a..bad60ac52874 100644
--- a/tools/testing/selftests/mm/thp_settings.c
+++ b/tools/testing/selftests/mm/thp_settings.c
@@ -381,3 +381,14 @@ unsigned long thp_shmem_supported_orders(void)
 {
 	return __thp_supported_orders(true);
 }
+
+bool thp_is_enabled(void)
+{
+	if (access(THP_SYSFS, F_OK) != 0)
+		return false;
+
+	int mode = thp_read_string("enabled", thp_enabled_strings);
+
+	/* THP is considered enabled if it's either "always" or "madvise" */
+	return mode == 1 || mode == 3;
+}
diff --git a/tools/testing/selftests/mm/thp_settings.h b/tools/testing/selftests/mm/thp_settings.h
index fc131d23d593..6c07f70beee9 100644
--- a/tools/testing/selftests/mm/thp_settings.h
+++ b/tools/testing/selftests/mm/thp_settings.h
@@ -84,4 +84,6 @@ void thp_set_read_ahead_path(char *path);
 unsigned long thp_supported_orders(void);
 unsigned long thp_shmem_supported_orders(void);
 
+bool thp_is_enabled(void);
+
 #endif /* __THP_SETTINGS_H__ */
-- 
2.49.0


