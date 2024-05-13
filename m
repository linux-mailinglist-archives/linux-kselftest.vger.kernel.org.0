Return-Path: <linux-kselftest+bounces-10134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B628C3D2B
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 10:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 854471F22034
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 08:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240C41474B2;
	Mon, 13 May 2024 08:29:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBBE1474B8;
	Mon, 13 May 2024 08:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715588988; cv=none; b=QMjF0c3jD18Ghw2fRVo7wDVWAqJRyMYDQcssaezzdLVT0p2eecy100OtGGywcWC7ON0ydhFOXwljSGhtUoqpaK3t5UAkuUyW26PR3T9+R12tNBbqDtBro3F3NDGMjDKYOiEMLuoRfNqpJZYM3a6X5EU/RgulPb8BtjGupLuD758=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715588988; c=relaxed/simple;
	bh=w2OxaGvxyHVfOAWRircL4Fn/3IZtA341il1A/uniA30=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P9bvBP2kb0rTpRZgm5veDMi5hVi2rUIzmB+oIAKx3svbR3tbEFVXu/fUYmKgdBbobkEJueSDaFxE41czbr/ZqYN2Qt8jHV2fBsFknUOHmMl48V4pqEnVdplsH6phcr0NhTgO7ch1sgiXTdx77NCTmIXyH9HfMPE8XVuzwPaYswE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F19F21007;
	Mon, 13 May 2024 01:30:09 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.42.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4A3493F7A6;
	Mon, 13 May 2024 01:29:42 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	shuah@kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anshuman.Khandual@arm.com,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH] selftests/mm: compaction_test: Fix trivial test pass on Aarch64 when nr_hugepages = 0
Date: Mon, 13 May 2024 13:58:42 +0530
Message-Id: <20240513082842.4117782-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, if at runtime we are not able to allocate a huge page, the
test will trivially pass on Aarch64 due to no exception being raised on
division by zero while computing compaction_index. Fix that by checking
for nr_hugepages == 0. Anyways, in general, avoid a division by zero by
exiting the program beforehand. While at it, fix a typo.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 tools/testing/selftests/mm/compaction_test.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
index 533999b6c284..df1b76f9c734 100644
--- a/tools/testing/selftests/mm/compaction_test.c
+++ b/tools/testing/selftests/mm/compaction_test.c
@@ -134,6 +134,10 @@ int check_compaction(unsigned long mem_free, unsigned int hugepage_size)
 
 	/* We should have been able to request at least 1/3 rd of the memory in
 	   huge pages */
+	if (!atoi(nr_hugepages)) {
+		ksft_print_msg("ERROR: No memory is available as huge pages\n");
+		goto close_fd;
+	}
 	compaction_index = mem_free/(atoi(nr_hugepages) * hugepage_size);
 
 	lseek(fd, 0, SEEK_SET);
@@ -149,7 +153,7 @@ int check_compaction(unsigned long mem_free, unsigned int hugepage_size)
 		       atoi(nr_hugepages));
 
 	if (compaction_index > 3) {
-		ksft_print_msg("ERROR: Less that 1/%d of memory is available\n"
+		ksft_print_msg("ERROR: Less than 1/%d of memory is available\n"
 			       "as huge pages\n", compaction_index);
 		goto close_fd;
 	}
-- 
2.39.2


