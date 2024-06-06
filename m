Return-Path: <linux-kselftest+bounces-11299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8204A8FF102
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 17:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C7B1F273A8
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 15:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47642197533;
	Thu,  6 Jun 2024 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="bgFJKe5R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6A319751B;
	Thu,  6 Jun 2024 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688681; cv=none; b=juBrSkbv3K3Tncip8ZesNQC2TkGaZmZshhUYXnTPt/BQWYIRyCvhuDK/DcmTKN9eSNcoWMmA47a4Uz/8yzSCzgch5uZ9+HX8O6T/D80qH6PRjWbBSqD3OjWCQXgtZlvwDYDUjpBS0T+HTs5eNaGiyReoy0xkwPyYh82PqRd3Tv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688681; c=relaxed/simple;
	bh=p3+HcpSv7KTH1ay6GWfjRUjkVsJ8ZSafrdi9MyeRX6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WdZi8u9HHx6+xVLlfO/ckwiRoV+1NEy8JAX5XYL2B6IhkUP0DEmmo5wVET6MrxVKqH34nNxkJEIaoJy2kRzBVRXkkJsDmyYHd90DtR4vKm3LF7ILtqS2W7AOcZrmd2M4/9AYvu9ClPIHa7Y6qr4BtGo61UmQ0QByPiYFObglnAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=bgFJKe5R; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Vw7tW20YWz9sp2;
	Thu,  6 Jun 2024 17:44:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1717688675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QZa52MMCmXYplUj6krZ/HIOPht+wCpFtBELuCgPO92c=;
	b=bgFJKe5RQ9IuY8O2Z+SUI1nDjmdpsIDw2Nb50qS2PsLJ+LOwn7ApW5s1ky5g6Zgws/gLtB
	eI+GIZcEL1LMTGmT5dJCmABS/CiEKj/reeZTElDZ2GXagdunszv95XA8vn51cvzfmWWIUl
	XEi2NdOt19+9R27wXfaxkQtlAMTV8Va4tabVAfdLqfqfXEQ7b2zIS4KdD6VbFBEpmBwR00
	GHj18TX3CK6gIjnYpHiW9AH2WkKl9Q/+qN6IeZ8Do/dFhnK3G7oqxAtLfUJYUU1LgngaOy
	agd+/reIa7GtDAv6o0aodN0bjRZQkLqJ+YyX2rcuAhpvOK9+rR6llodljOYAFg==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Zi Yan <zi.yan@sent.com>,
	linux-mm@kvack.org,
	gost.dev@samsung.com,
	mcgrof@kernel.org,
	willy@infradead.org,
	kernel@pankajraghav.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2] selftests/mm: use global variable to not optimize mmap read variable
Date: Thu,  6 Jun 2024 15:44:28 +0000
Message-ID: <20240606154428.672643-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Vw7tW20YWz9sp2

From: Pankaj Raghav <p.raghav@samsung.com>

create_pagecache_thp_and_fd() in split_huge_page_test.c used the
variable dummy to perform mmap read.

However, this test was skipped even on XFS which has large folio
support. The issue was compiler (gcc 13.2.0) was optimizing out the
dummy variable, therefore, not creating huge page in the page cache.

Make it as a global variable to force the compiler not to optimize out
the loop where we read from the mmaped addr.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
Changes since v1:
- Make the dummy variable as a global variable(willy).

 tools/testing/selftests/mm/split_huge_page_test.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index d3c7f5fb3e7b..c4857de2c042 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -23,6 +23,11 @@
 uint64_t pagesize;
 unsigned int pageshift;
 uint64_t pmd_pagesize;
+/*
+ * Used by create_pagecache_thp_and_fd() to do mmap read.
+ * Made it as global to avoid compiler optimizing out the variable.
+ */
+int dummy;
 
 #define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages"
 #define SMAP_PATH "/proc/self/smaps"
@@ -300,7 +305,6 @@ int create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, int *fd,
 		char **addr)
 {
 	size_t i;
-	int __attribute__((unused)) dummy = 0;
 
 	srand(time(NULL));
 

base-commit: d97496ca23a2d4ee80b7302849404859d9058bcd
-- 
2.44.1


