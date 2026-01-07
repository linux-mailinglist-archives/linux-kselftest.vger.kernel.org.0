Return-Path: <linux-kselftest+bounces-48427-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD64ACFF022
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 18:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 57A8B30034A1
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 17:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CB43596F0;
	Wed,  7 Jan 2026 16:49:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8279234D917;
	Wed,  7 Jan 2026 16:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767804556; cv=none; b=DHXHSrTiiP0yF1i4ZC2c1D/J8t6XOZqTSrpvQ6Tu8kbcggy+T+pgtyfiKIeFjmCyRGeB0HxmkVpZONXs+hmQEsnqOSoOkOKcQQ+jHdOdDQr7A827VpjTgIDO3/rEr0UvG5QTxdH+LpwwNN/LxttF3p/Y9YqiiDCo3p83NNr10wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767804556; c=relaxed/simple;
	bh=JThi7RLwAirOPVgwT2JD5p1WRyNKU85M6QrfMprXfB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPV8YHXGx9B6ybrwATot2O25NCDjMA9W7/xNYeaFhx4Iz4EJXmLP85MGBXkMi9vORU8xS8LpazTCHOc/208YWDcYVamScOh0zSCOVg+MOExH6ugABNoPSTUcshMMk7wl6EYruQVxU5TLw4t3EoeZ8INJ4MrJe83/74FloI9zaOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98B71168F;
	Wed,  7 Jan 2026 08:48:53 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19AA43F5A1;
	Wed,  7 Jan 2026 08:48:58 -0800 (PST)
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
Subject: [PATCH v2 6/8] selftests/mm: fix faulting-in code in pagemap_ioctl test
Date: Wed,  7 Jan 2026 16:48:40 +0000
Message-ID: <20260107164842.3289559-7-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260107164842.3289559-1-kevin.brodsky@arm.com>
References: <20260107164842.3289559-1-kevin.brodsky@arm.com>
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
page.

Cc: Usama Anjum <Usama.Anjum@arm.com>
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 tools/testing/selftests/mm/pagemap_ioctl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
index 2cb5441f29c7..80d7c391f8f5 100644
--- a/tools/testing/selftests/mm/pagemap_ioctl.c
+++ b/tools/testing/selftests/mm/pagemap_ioctl.c
@@ -1056,7 +1056,6 @@ int sanity_tests(void)
 	struct page_region *vec;
 	char *mem, *fmem;
 	struct stat sbuf;
-	char *tmp_buf;
 
 	/* 1. wrong operation */
 	mem_size = 10 * page_size;
@@ -1167,8 +1166,7 @@ int sanity_tests(void)
 	if (fmem == MAP_FAILED)
 		ksft_exit_fail_msg("error nomem %d %s\n", errno, strerror(errno));
 
-	tmp_buf = malloc(sbuf.st_size);
-	memcpy(tmp_buf, fmem, sbuf.st_size);
+	force_read_pages_in_range(fmem, sbuf.st_size);
 
 	ret = pagemap_ioctl(fmem, sbuf.st_size, vec, vec_size, 0, 0,
 			    0, PAGEMAP_NON_WRITTEN_BITS, 0, PAGEMAP_NON_WRITTEN_BITS);
-- 
2.51.2


