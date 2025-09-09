Return-Path: <linux-kselftest+bounces-41019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2B1B4A1DD
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 08:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44AD87B2EED
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 06:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CEA303A04;
	Tue,  9 Sep 2025 06:16:01 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48383302CC0;
	Tue,  9 Sep 2025 06:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757398561; cv=none; b=VbFQKQFkXwyjr23akRan2lC+cBNxfx/CV5ti575MuNc6YMlpB0t1c9fJWhyLJmk9BEGt+jJcWvqiw90y3ONVS52P1KfLOz/aiKNfY8eMGiWEKXgCG2+xUniNnBYOUig3whlEi1nSfG+Z/j6wNM7cH3bivPSNBgic8tvMLuKFF9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757398561; c=relaxed/simple;
	bh=z4K6mlpcGA/petTg/EQeQXUcaK1NsAyf146RE5Um/VA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ekVQsQGR9+/4mXjWEsyFYBF2kZeyeTVL6Pi7qFdoscwqDlh43vZAuBh2ZYY/PqZGjzmAlhNpJB0kkOACW0BwVSZXAIaR0uPSsapTtBWBLAOGJsfdPIj0Kh/yuShmKATQcUtC0dDXL97aVi2nAfx81eODYcfdQrBb76dgERrI9Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32773168F;
	Mon,  8 Sep 2025 23:15:51 -0700 (PDT)
Received: from MacBook-Pro.blr.arm.com (MacBook-Pro.blr.arm.com [10.164.18.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6B1CE3F66E;
	Mon,  8 Sep 2025 23:15:55 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	shuah@kernel.org
Cc: lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v2 2/2] selftests/mm/uffd-stress: stricten constraint on free hugepages needed before the test
Date: Tue,  9 Sep 2025 11:45:30 +0530
Message-Id: <20250909061531.57272-3-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250909061531.57272-1-dev.jain@arm.com>
References: <20250909061531.57272-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test requires at least 2 * (bytes/page_size) hugetlb memory, since
we require identical number of hugepages for src and dst location. Fix
this.

Along with the above, as explained in patch "selftests/mm/uffd-stress:
Make test operate on less hugetlb memory", the racy nature of the test
requires that we have some extra number of hugepages left beyond what is
required. Therefore, stricten this constraint.

Fixes: 5a6aa60d1823 ("selftests/mm: skip uffd hugetlb tests with insufficient hugepages")
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 tools/testing/selftests/mm/uffd-stress.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index 40af7f67c407..3f6213ae0dd5 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -448,12 +448,6 @@ int main(int argc, char **argv)
 	parse_test_type_arg(argv[1]);
 	bytes = atol(argv[2]) * 1024 * 1024;
 
-	if (test_type == TEST_HUGETLB &&
-	   get_free_hugepages() < bytes / page_size) {
-		printf("skip: Skipping userfaultfd... not enough hugepages\n");
-		return KSFT_SKIP;
-	}
-
 	nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
 	if (nr_cpus > 32) {
 		/* Don't let calculation below go to zero. */
@@ -464,6 +458,17 @@ int main(int argc, char **argv)
 		nr_parallel = nr_cpus;
 	}
 
+	/*
+	 * src and dst each require bytes / page_size number of hugepages.
+	 * Ensure nr_parallel - 1 hugepages on top of that to account
+	 * for racy extra reservation of hugepages.
+	 */
+	if (test_type == TEST_HUGETLB &&
+	   get_free_hugepages() < 2 * (bytes / page_size) + nr_parallel - 1) {
+		printf("skip: Skipping userfaultfd... not enough hugepages\n");
+		return KSFT_SKIP;
+	}
+
 	nr_pages_per_cpu = bytes / page_size / nr_parallel;
 	if (!nr_pages_per_cpu) {
 		_err("pages_per_cpu = 0, cannot test (%lu / %lu / %lu)",
-- 
2.30.2


