Return-Path: <linux-kselftest+bounces-16285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F197D95F472
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 16:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 216CA1C21EAC
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 14:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F402D18D65B;
	Mon, 26 Aug 2024 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="dzt1yLro"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A100D18D626;
	Mon, 26 Aug 2024 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724684039; cv=none; b=i7Pfie1aF78kyPtuvzNgMI0o1yG4odAJdu8Hs9gY3wiUQjWXbL5wVSgeCQekU+Gmnv35rDlUKGCB6ozRb5oLW6QLjrYtXj/RoLJY6o+dhei6kVIa8PbTduXP5gjakc2QxEeyRobkByNyj4xTBPvz3TZhFQ++7GP/qM/2UkBkjCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724684039; c=relaxed/simple;
	bh=eoPZ1TPOUmuOHotNyP6ujRtIycr/WHEcyRNHgPDR6OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nf/fprXhbcyJWeTDzo4MbjoCE48cVyBYIxkWomKN6KE+nugLxSZ6wZrD2HRCTcribaUMy8Urq5Yv78Mj8He3vCocWFG/gF0Q2erCtnUb1qBPOY26Gk7B0/nmdBBWjDtKCEb0Xb13WpcNIEBAupn70kHnsbpjw5ztr9LlgWgakeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=dzt1yLro; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WstwW6tYFz9sWF;
	Mon, 26 Aug 2024 16:53:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1724684028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1BUU84NCaopG37WJwAhGnNRn9/jXFpZdy15jON8+/EM=;
	b=dzt1yLrodmnTfBTi3WoZgGDVg3UBX+THnChaCmDBi02M8ZETbF9uP3m75N7xQXbauyW32X
	B62UfHa78bSX6JKpHexdH8I6Lno8mEuf2INf4gf4j6reAn/+7MdTEI+7XZCd/3Q0EdtI82
	aqD+0556kofYsW46UmOxbVJlr7ltztrwpkqGbnXQSy1abMtMOBvqGsqTvfJwA1EL8BpaI7
	DiSPpnE+L7UvPIbLMtcdPkfK6ef297omVGGNF+pKt9MrPTpa6U3uYOqzIYFY3qb2vwwcj4
	LsNTJ1v58ts+up3ZncfYD2XO6KaWOXkfncyCkenJf1lTXo8SFrJXRVTqWsNjsA==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	linux-kselftest@vger.kernel.org,
	kernel@pankajraghav.com,
	Zi Yan <ziy@nvidia.com>,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH] selftests/mm: do not try to split below filesystem block size
Date: Mon, 26 Aug 2024 16:53:44 +0200
Message-ID: <20240826145344.33665-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4WstwW6tYFz9sWF

From: Pankaj Raghav <p.raghav@samsung.com>

There is no point trying to split pagecache thp below the blocksize of
the filesystem as that is the minimum order that pagecache needs to
maintain to support blocksizes greater than pagesize [1].

Set the lower limit for the splitting order to be the fs blocksize
order.

As the number of tests will now depend on the minimum splitting order,
move the file preparation before calling ksft_set_plan().

[1] https://lore.kernel.org/linux-fsdevel/20240822135018.1931258-1-kernel@pankajraghav.com/

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 .../selftests/mm/split_huge_page_test.c       | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index e5e8dafc9d94..187fe9107998 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -9,11 +9,13 @@
 #include <stdlib.h>
 #include <stdarg.h>
 #include <unistd.h>
+#include <math.h>
 #include <inttypes.h>
 #include <string.h>
 #include <fcntl.h>
 #include <sys/mman.h>
 #include <sys/mount.h>
+#include <sys/stat.h>
 #include <malloc.h>
 #include <stdbool.h>
 #include <time.h>
@@ -404,9 +406,10 @@ void split_thp_in_pagecache_to_order(size_t fd_size, int order, const char *fs_l
 
 int main(int argc, char **argv)
 {
-	int i;
+	int i, min_split_order = 0;
 	size_t fd_size;
 	char *optional_xfs_path = NULL;
+	struct stat filestat;
 	char fs_loc_template[] = "/tmp/thp_fs_XXXXXX";
 	const char *fs_loc;
 	bool created_tmp;
@@ -421,8 +424,6 @@ int main(int argc, char **argv)
 	if (argc > 1)
 		optional_xfs_path = argv[1];
 
-	ksft_set_plan(3+9);
-
 	pagesize = getpagesize();
 	pageshift = ffs(pagesize) - 1;
 	pmd_pagesize = read_pmd_pagesize();
@@ -431,13 +432,19 @@ int main(int argc, char **argv)
 
 	fd_size = 2 * pmd_pagesize;
 
+	created_tmp = prepare_thp_fs(optional_xfs_path, fs_loc_template,
+			&fs_loc);
+
+	if (!stat(fs_loc, &filestat))
+		min_split_order = log2(filestat.st_blksize) - pageshift;
+
+	ksft_set_plan(3 + 9 - min_split_order);
+
 	split_pmd_thp();
 	split_pte_mapped_thp();
 	split_file_backed_thp();
 
-	created_tmp = prepare_thp_fs(optional_xfs_path, fs_loc_template,
-			&fs_loc);
-	for (i = 8; i >= 0; i--)
+	for (i = 8; i >= min_split_order; i--)
 		split_thp_in_pagecache_to_order(fd_size, i, fs_loc);
 	cleanup_thp_fs(fs_loc, created_tmp);
 

base-commit: 5771112c37523a2344b346d7fe613694a2566df9
-- 
2.44.1


