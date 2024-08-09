Return-Path: <linux-kselftest+bounces-15065-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4BB94CEB0
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 12:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE8D31C222A0
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 10:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7493190059;
	Fri,  9 Aug 2024 10:32:37 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0B8190490;
	Fri,  9 Aug 2024 10:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723199557; cv=none; b=XLNhNe/TjyPC4It6R7YnnKb/UK3J1hLeuMiUnOg75sfeX+Gkw0U6vChHjVmFmVh+P7vWRmsqcMugOBpyKqLd0GSxP5kRWDfj4+1fISTbc+TI13llL0iuyheuzVoBorH7JJVH1MGeejC95eux8Woy7Yx17JF7vHp+m77X4o9RcLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723199557; c=relaxed/simple;
	bh=US9OPA3sgFjfqONG9ii/Jz0uPCjcdjDpmydJ7Bqn7SU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RNf8a70Ne3NVkzy5ZZKvj3wxsyX6+VUznn4gHCaYfzO4h5NlXN78y+Z/IwBA2hXd+jk2O2oLFeE6bwvdAAPcoFUUTnhgx91vpF3scfsnsCG6nf7XzvsVfKG+DROTG5xMOnulWj7wbSSLiYL11m4uEadFuvHfquLS6lsH4B/bMZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC37613D5;
	Fri,  9 Aug 2024 03:33:00 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.42.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A366D3F766;
	Fri,  9 Aug 2024 03:32:21 -0700 (PDT)
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
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH 2/2] selftests/mm: Do not fail test for a single migration failure
Date: Fri,  9 Aug 2024 16:01:29 +0530
Message-Id: <20240809103129.365029-3-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809103129.365029-1-dev.jain@arm.com>
References: <20240809103129.365029-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not fail the test for just a single instance of migration failure,
since migration is a best-effort service.

Signed-off-by: Dev Jain <dev.jain@arm.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Tested-by: Ryan Roberts <ryan.roberts@arm.com>
---
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


