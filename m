Return-Path: <linux-kselftest+bounces-47609-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D16BCC3A1F
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 15:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E42430440FF
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 14:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ED334E76A;
	Tue, 16 Dec 2025 14:26:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EFC34DCC9;
	Tue, 16 Dec 2025 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765895209; cv=none; b=Rmvf1lVmG2B5U9Oao1gxcH/JzwmV55bYd1s/BxP2cnYdYndhGNplh2Q2f4P+rByVhe7Fwj0sB+Qctr1s/Avuj/F42UONyCSDnd/6BU9MJoWQNM4+ycRzuI6pK6H3VyJFRPbFjaf/EBAD/HIJtsdyNhMZ9Qw2x88vKzaXwnee6U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765895209; c=relaxed/simple;
	bh=MEpleqSyHmmuXw4jN3hkUoZ62o9IG0pEB5h1GLOHmfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNmk+vf1NxFDnPfNBacynfPy0IItJ5k3cuej/+3rj1ei8aB+KAL7u9OIvKVEyPeJxuCsYVXGbr+zE2zTxRi6O4HOdcrPyGMplTNo9VTYAHq7C9hIj/UpA3zanlI0G4h6WHN4+Nmb4ZohCG1N5ntm4sFkJggwW1qqV/UplyirW0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F1771655;
	Tue, 16 Dec 2025 06:26:40 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9A833F694;
	Tue, 16 Dec 2025 06:26:45 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mark Brown <broonie@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Usama Anjum <Usama.Anjum@arm.com>
Subject: [PATCH 3/4] selftests/mm: fix faulting-in code in pagemap_ioctl test
Date: Tue, 16 Dec 2025 14:26:32 +0000
Message-ID: <20251216142633.2401447-4-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251216142633.2401447-1-kevin.brodsky@arm.com>
References: <20251216142633.2401447-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One of the pagemap_ioctl tests attempts to fault in pages by
memcpy()'ing them to an unused buffer. This probably worked
originally, but since commit 46036188ea1f ("selftests/mm: build with
-O2") the compiler is free to optimise away that unused buffer and
the memcpy() with it. As a result there might not be any resident
page in the mapping and the test may fail.

We don't need to copy all that memory anyway. Just fault in every
page by forcing the compiler to read the first byte.

Cc: Usama Anjum <Usama.Anjum@arm.com>
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 tools/testing/selftests/mm/pagemap_ioctl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
index 2cb5441f29c7..67a7a3705604 100644
--- a/tools/testing/selftests/mm/pagemap_ioctl.c
+++ b/tools/testing/selftests/mm/pagemap_ioctl.c
@@ -1056,7 +1056,6 @@ int sanity_tests(void)
 	struct page_region *vec;
 	char *mem, *fmem;
 	struct stat sbuf;
-	char *tmp_buf;
 
 	/* 1. wrong operation */
 	mem_size = 10 * page_size;
@@ -1167,8 +1166,9 @@ int sanity_tests(void)
 	if (fmem == MAP_FAILED)
 		ksft_exit_fail_msg("error nomem %d %s\n", errno, strerror(errno));
 
-	tmp_buf = malloc(sbuf.st_size);
-	memcpy(tmp_buf, fmem, sbuf.st_size);
+	/* Fault in every page by reading the first byte */
+	for (i = 0; i < sbuf.st_size; i += page_size)
+		(void)*(volatile char *)(fmem + i);
 
 	ret = pagemap_ioctl(fmem, sbuf.st_size, vec, vec_size, 0, 0,
 			    0, PAGEMAP_NON_WRITTEN_BITS, 0, PAGEMAP_NON_WRITTEN_BITS);
-- 
2.51.2


