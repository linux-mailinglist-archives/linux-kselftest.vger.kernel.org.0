Return-Path: <linux-kselftest+bounces-48423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AF5CFF004
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 18:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD66C3007508
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 17:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB78350286;
	Wed,  7 Jan 2026 16:49:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B35344033;
	Wed,  7 Jan 2026 16:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767804551; cv=none; b=oEIBESotvML0mcqE7o3VhvsC+XXltl8lp7u97fnqS/JdCpPT7f8/8epAaYL9Hq2YuCaCK/0JZEYtNL3qwyuCI7u3ycaeMeUrxKJ8S7+glVgGmN9VX82ojoG4mv2KnKQQMwPgYZIf0RkEGsDf8/QCgWGrAZjhPpnowaBbY9t/d8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767804551; c=relaxed/simple;
	bh=csI6Rpb4/mFi1tboLbskie8XKOiTZsT2pE/IHuHLI88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSssuJobAZoR7NumupYmbkkox3IXQTC2CEmo9zYtrc3KnP+FZHJB5P8eSfEs1ClGrYJjxHoJO0OcTsJddGHAUw6b4/M13aFZJEjMkMwEu9belC+7lTu72tw7t/NRXkfwgEWKU8eipHNvACRxr0OiTG+eRjAmnXeeMLW8+n/ioXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85C241682;
	Wed,  7 Jan 2026 08:48:50 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 232CB3F5A1;
	Wed,  7 Jan 2026 08:48:56 -0800 (PST)
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
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH v2 4/8] selftests/mm: fix usage of FORCE_READ() in cow tests
Date: Wed,  7 Jan 2026 16:48:38 +0000
Message-ID: <20260107164842.3289559-5-kevin.brodsky@arm.com>
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

Commit 5bbc2b785e63 ("selftests/mm: fix FORCE_READ to read input
value correctly") modified FORCE_READ() to take a value instead of a
pointer. It also changed most of the call sites accordingly, but
missed many of them in cow.c. In those cases, we ended up with the
pointer itself being read, not the memory it points to.

No failure occurred as a result, so it looks like the tests work
just fine without faulting in. However, the huge_zeropage tests
explicitly check that pages are populated, so those became skipped.

Convert all the remaining FORCE_READ() to fault in the mapped page,
as was originally intended. This allows the huge_zeropage tests to
run again (3 tests in total).

Fixes: 5bbc2b785e63 ("selftests/mm: fix FORCE_READ to read input value correctly")
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 tools/testing/selftests/mm/cow.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index accfd198dbda..83b3563be26b 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -1612,8 +1612,8 @@ static void run_with_huge_zeropage(non_anon_test_fn fn, const char *desc)
 	 * the first sub-page and test if we get another sub-page populated
 	 * automatically.
 	 */
-	FORCE_READ(mem);
-	FORCE_READ(smem);
+	FORCE_READ(*mem);
+	FORCE_READ(*smem);
 	if (!pagemap_is_populated(pagemap_fd, mem + pagesize) ||
 	    !pagemap_is_populated(pagemap_fd, smem + pagesize)) {
 		ksft_test_result_skip("Did not get THPs populated\n");
@@ -1663,8 +1663,8 @@ static void run_with_memfd(non_anon_test_fn fn, const char *desc)
 	}
 
 	/* Fault the page in. */
-	FORCE_READ(mem);
-	FORCE_READ(smem);
+	FORCE_READ(*mem);
+	FORCE_READ(*smem);
 
 	fn(mem, smem, pagesize);
 munmap:
@@ -1719,8 +1719,8 @@ static void run_with_tmpfile(non_anon_test_fn fn, const char *desc)
 	}
 
 	/* Fault the page in. */
-	FORCE_READ(mem);
-	FORCE_READ(smem);
+	FORCE_READ(*mem);
+	FORCE_READ(*smem);
 
 	fn(mem, smem, pagesize);
 munmap:
@@ -1773,8 +1773,8 @@ static void run_with_memfd_hugetlb(non_anon_test_fn fn, const char *desc,
 	}
 
 	/* Fault the page in. */
-	FORCE_READ(mem);
-	FORCE_READ(smem);
+	FORCE_READ(*mem);
+	FORCE_READ(*smem);
 
 	fn(mem, smem, hugetlbsize);
 munmap:
-- 
2.51.2


