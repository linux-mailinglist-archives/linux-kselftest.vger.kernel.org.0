Return-Path: <linux-kselftest+bounces-16756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5D09656CA
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 07:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C6BD285AC5
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 05:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CBA13C672;
	Fri, 30 Aug 2024 05:16:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1505FEEB7;
	Fri, 30 Aug 2024 05:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724994993; cv=none; b=tRQGqkxm4cpm6fkf8sSSeaxQOEgECmDJHIkQHJzwTCaSxHS3as9bul59F+ysJjCebJv0/oibAqWJpKCmTQiIXH09bw11ZCQyD+2dybZpbuylTFIRjWfaZ6dOD+mKl/ZZH5qHHWLND9a/vLmLi/xw28m76t1kcy89aWAJGrhu4qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724994993; c=relaxed/simple;
	bh=KijCHr4lbm49o3SgoZp2sxJkChsaExW/zVUnh4L+WmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uowQbw/QVq7M+1oBcBG+pQFrqPam2mKlQDNG8iXk0W71/Qq4xz3QynXUrr0DwJvrWMspwkhJSXhdAgtkNEx/CEnrKFqx02FQ4LzJsjBurZnlPC4k1Cwt4MNt9maWtWrrS+eCf3TTCUPqa9xm7pCic4Cn96OymPOQ13/yqMbSV2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 270A51063;
	Thu, 29 Aug 2024 22:16:56 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.40.24])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 855F83F66E;
	Thu, 29 Aug 2024 22:16:19 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	shuah@kernel.org,
	david@redhat.com,
	willy@infradead.org
Cc: ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	cl@gentwo.org,
	vbabka@suse.cz,
	mhocko@suse.com,
	apopple@nvidia.com,
	osalvador@suse.de,
	baolin.wang@linux.alibaba.com,
	dave.hansen@linux.intel.com,
	will@kernel.org,
	baohua@kernel.org,
	ioworker0@gmail.com,
	gshan@redhat.com,
	mark.rutland@arm.com,
	kirill.shutemov@linux.intel.com,
	hughd@google.com,
	aneesh.kumar@kernel.org,
	yang@os.amperecomputing.com,
	peterx@redhat.com,
	broonie@kernel.org,
	mgorman@techsingularity.net,
	ying.huang@intel.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH] selftests/mm: Relax test to fail after 100 migration failures
Date: Fri, 30 Aug 2024 10:46:09 +0530
Message-Id: <20240830051609.4037834-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was recently observed at [1] that during the folio unmapping stage
of migration, when the PTEs are cleared, a racing thread faulting on that
folio may increase the refcount of the folio, sleep on the folio lock
(the migration path has the lock), and migration ultimately fails
when asserting the actual refcount against the expected. Thereby,
the migration selftest fails on shared-anon mappings.
The above enforces the fact that migration is a best-effort service,
therefore, it is wrong to fail the test for just a single failure;
hence, fail the test after 100 consecutive failures (where 100 is
still a subjective choice). Note that, this has no effect on the
execution time of the test since that is controlled by a timeout.

[1] https://lore.kernel.org/all/20240801081657.1386743-1-dev.jain@arm.com/

Signed-off-by: Dev Jain <dev.jain@arm.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Tested-by: Ryan Roberts <ryan.roberts@arm.com>
---
The above patch was part of the following:
https://lore.kernel.org/all/20240809103129.365029-1-dev.jain@arm.com/
I decided to send it separately since it should be applied
nevertheless.

 tools/testing/selftests/mm/migration.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/mm/migration.c b/tools/testing/selftests/mm/migration.c
index 6908569ef406..64bcbb7151cf 100644
--- a/tools/testing/selftests/mm/migration.c
+++ b/tools/testing/selftests/mm/migration.c
@@ -15,10 +15,10 @@
 #include <signal.h>
 #include <time.h>
 
-#define TWOMEG (2<<20)
-#define RUNTIME (20)
-
-#define ALIGN(x, a) (((x) + (a - 1)) & (~((a) - 1)))
+#define TWOMEG		(2<<20)
+#define RUNTIME		(20)
+#define MAX_RETRIES	100
+#define ALIGN(x, a)	(((x) + (a - 1)) & (~((a) - 1)))
 
 FIXTURE(migration)
 {
@@ -65,6 +65,7 @@ int migrate(uint64_t *ptr, int n1, int n2)
 	int ret, tmp;
 	int status = 0;
 	struct timespec ts1, ts2;
+	int failures = 0;
 
 	if (clock_gettime(CLOCK_MONOTONIC, &ts1))
 		return -1;
@@ -79,13 +80,17 @@ int migrate(uint64_t *ptr, int n1, int n2)
 		ret = move_pages(0, 1, (void **) &ptr, &n2, &status,
 				MPOL_MF_MOVE_ALL);
 		if (ret) {
-			if (ret > 0)
+			if (ret > 0) {
+				/* Migration is best effort; try again */
+				if (++failures < MAX_RETRIES)
+					continue;
 				printf("Didn't migrate %d pages\n", ret);
+			}
 			else
 				perror("Couldn't migrate pages");
 			return -2;
 		}
-
+		failures = 0;
 		tmp = n2;
 		n2 = n1;
 		n1 = tmp;
-- 
2.30.2


