Return-Path: <linux-kselftest+bounces-29378-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19400A67B38
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 18:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F84A1733D1
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 17:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0EE211A1D;
	Tue, 18 Mar 2025 17:44:00 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E93821171B
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 17:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742319840; cv=none; b=LtyT0bRgpg1FBu3Y5yCeYI/oM4cvVNWV8zHWVbFJwgsfxPLfDaMZiElnWtczUSwdPy3pchwJRvZqQzpB8qcbaTEdK5OHoechLnPBsIaSyRnBrUkPxUMv5msYf0A18icTzkT/gzBfpOPjKlinixLwfU1pUKMjmomq4fblxSRZv+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742319840; c=relaxed/simple;
	bh=f1UEk6Kt5Obyh4Kzooa98oYbxQS+AbUO9Y396oiytDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWdfpM96uupMZrVuTB08PkU4BXJCFzKrMiGTTke+7er3W7PqcPiLDlIH3iyE6iDETrTVJL8YhhKdKzCtLC5tTAvh0QJkUJEbGuU0th/+j6zSUiWFkrGvhHMyS1AVoLS2KmZsukSpgtsgL7T5Ghpi4znIjJPWpBNeXMc1loYA4ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38425152B;
	Tue, 18 Mar 2025 10:44:06 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8B433F673;
	Tue, 18 Mar 2025 10:43:56 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Peter Xu <peterx@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v1 3/3] selftests/mm: Speed up split_huge_page_test
Date: Tue, 18 Mar 2025 17:43:41 +0000
Message-ID: <20250318174343.243631-3-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318174343.243631-1-ryan.roberts@arm.com>
References: <20250318174343.243631-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

create_pagecache_thp_and_fd() was previously writing a file sized at
twice the PMD size by making a per-byte write syscall. This was quite
slow when the PMD size is 4M, but completely intolerable for 32M (PMD
size for arm64's 16K page size), and 512M (PMD size for arm64's 64K page
size).

The byte pattern has a 256 byte period, so let's create a 1K buffer and
fill it with exactly 4 periods. Then we can write the buffer as many
times as is required to fill the file. This makes things much more
tolerable.

The test now passes for 16K page size. It still fails for 64K page size
because MAX_PAGECACHE_ORDER is too small for 512M folio size (I think).

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 tools/testing/selftests/mm/split_huge_page_test.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 3f353f3d070f..499333d75fff 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -5,6 +5,7 @@
  */
 
 #define _GNU_SOURCE
+#include <assert.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdarg.h>
@@ -361,6 +362,7 @@ int create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, int *fd,
 {
 	size_t i;
 	int dummy = 0;
+	unsigned char buf[1024];
 
 	srand(time(NULL));
 
@@ -368,11 +370,12 @@ int create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, int *fd,
 	if (*fd == -1)
 		ksft_exit_fail_msg("Failed to create a file at %s\n", testfile);
 
-	for (i = 0; i < fd_size; i++) {
-		unsigned char byte = (unsigned char)i;
+	assert(fd_size % sizeof(buf) == 0);
+	for (i = 0; i < sizeof(buf); i++)
+		buf[i] = (unsigned char)i;
+	for (i = 0; i < fd_size; i += sizeof(buf))
+		write(*fd, buf, sizeof(buf));
 
-		write(*fd, &byte, sizeof(byte));
-	}
 	close(*fd);
 	sync();
 	*fd = open("/proc/sys/vm/drop_caches", O_WRONLY);
-- 
2.43.0


