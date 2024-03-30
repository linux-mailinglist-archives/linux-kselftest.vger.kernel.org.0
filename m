Return-Path: <linux-kselftest+bounces-6919-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD5B892C2A
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Mar 2024 18:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFAE4282D9D
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Mar 2024 17:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F1342AB3;
	Sat, 30 Mar 2024 17:37:50 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220353BBDB;
	Sat, 30 Mar 2024 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711820270; cv=none; b=jvSKN97r/IYnzf0ttlpExgSNtQbj/P+T9TkjiKJlnG3nfR4I0tLnvtAbddRUg5hlDsH+Fy1l+LHyzjgTvegxARGNxgsWzMAT+C4qOmGNfAXLwa2MslLiUw0DhS2xO1o3orrY3Da5ARwGaN9JYmNqRD5GuIeWjYt9rGBni7Yp/4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711820270; c=relaxed/simple;
	bh=RzPPWq8e3raIWxE/t6eIibmPKorBGYq3+yl5j/39Ods=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gh2A1xidTG80tsBvdFk21C32OM5vjZAf54NziMWUQGdg6UrjFsE0xSxJ0xFbI9OWGfqDGTQFnOiI+yNdACPzeTtLflAVpS+4hx+hUR89ADHQ7G7jqN26ulyQDd75rCKF9269dD6CCshVo29+pmnIYORYuFc0ZDqW2GKNkbekjhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68863106F;
	Sat, 30 Mar 2024 10:38:21 -0700 (PDT)
Received: from e116581.. (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9E2183F7B4;
	Sat, 30 Mar 2024 10:37:44 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org
Cc: shuah@kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kaleshsingh@google.com,
	jhubbard@nvidia.com,
	Anshuman.Khandual@arm.com,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH 3/3] selftests/mm: mremap_test: Use sscanf to parse /proc/self/maps
Date: Sat, 30 Mar 2024 23:05:57 +0530
Message-Id: <20240330173557.2697684-4-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240330173557.2697684-1-dev.jain@arm.com>
References: <20240330173557.2697684-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enforce consistency across files by avoiding two separate functions to parse
/proc/self/maps, replacing them with a simple sscanf().

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 tools/testing/selftests/mm/mremap_test.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index 678c79d5b8ef..1b03bcfaefdf 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -148,19 +148,21 @@ static unsigned long long get_mmap_min_addr(void)
  * Using /proc/self/maps, assert that the specified address range is contained
  * within a single mapping.
  */
-static bool is_range_mapped(FILE *maps_fp, void *start, void *end)
+static bool is_range_mapped(FILE *maps_fp, unsigned long start,
+			    unsigned long end)
 {
 	char *line = NULL;
 	size_t len = 0;
 	bool success = false;
+	unsigned long first_val, second_val;
 
 	rewind(maps_fp);
 
 	while (getline(&line, &len, maps_fp) != -1) {
-		char *first = strtok(line, "- ");
-		void *first_val = (void *)strtol(first, NULL, 16);
-		char *second = strtok(NULL, "- ");
-		void *second_val = (void *) strtol(second, NULL, 16);
+		if (sscanf(line, "%lx-%lx", &first_val, &second_val) != 2) {
+			ksft_exit_fail_msg("cannot parse /proc/self/maps\n");
+			break;
+		}
 
 		if (first_val <= start && second_val >= end) {
 			success = true;
@@ -255,7 +257,8 @@ static void mremap_expand_merge(FILE *maps_fp, unsigned long page_size)
 		goto out;
 	}
 
-	success = is_range_mapped(maps_fp, start, start + 3 * page_size);
+	success = is_range_mapped(maps_fp, (unsigned long)start,
+				  (unsigned long)(start + 3 * page_size));
 	munmap(start, 3 * page_size);
 
 out:
@@ -294,7 +297,8 @@ static void mremap_expand_merge_offset(FILE *maps_fp, unsigned long page_size)
 		goto out;
 	}
 
-	success = is_range_mapped(maps_fp, start, start + 3 * page_size);
+	success = is_range_mapped(maps_fp, (unsigned long)start,
+				  (unsigned long)(start + 3 * page_size));
 	munmap(start, 3 * page_size);
 
 out:
-- 
2.34.1


