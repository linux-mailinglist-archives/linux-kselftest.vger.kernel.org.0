Return-Path: <linux-kselftest+bounces-47610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43159CC39F5
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 15:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F6D53064119
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 14:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A067234DCC9;
	Tue, 16 Dec 2025 14:26:51 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB2934EEE6;
	Tue, 16 Dec 2025 14:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765895211; cv=none; b=Cw9JnIPkqWy/e/a9RLQlxp99T2OakL721R/7LlLVnueFj4P6ggtHop+yZhOvRkBL5IlwJl7cZF7zKiKtBVtlO+dxKJ7FI4Hg9zGxSbojcjMbSiuPD6iYcrj8ft/XsRp8LjStGzdzxXRGs5mg8/7UhtH/nbGgpXPH+uJOGvkHGAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765895211; c=relaxed/simple;
	bh=z1V8GlOYPhY/gKBIlYErfARVC1g7kXpU/U0qEsxwYok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=goCD6pqHpO4XrD6MgD+R7lq7p6LHVBmgOJwtdsrX8b+xn4PZ7mgEH7s201d35VGeAu6au1FrTrqfNboT/WsUFBLV/5ulsh3sP1JAhSE3tc2lcdirc55BXCZdPMrKFpGC5XwwWqvGZSpgjP3c9aJOsuR3X40AMPZjrnzP8rNHfkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CB851682;
	Tue, 16 Dec 2025 06:26:42 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD66A3F694;
	Tue, 16 Dec 2025 06:26:47 -0800 (PST)
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
Subject: [PATCH 4/4] selftests/mm: fix exit code in pagemap_ioctl
Date: Tue, 16 Dec 2025 14:26:33 +0000
Message-ID: <20251216142633.2401447-5-kevin.brodsky@arm.com>
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

pagemap_ioctl always reports success, whether the tests succeeded or
not. Call ksft_finished() to report the right status.

While at it also fix the exit code in unexpected situations:

- Report SKIP if userfaultfd isn't available (in line with other
  tests)

- Report FAIL if we failed to open /proc/self/pagemap (returning
  -EINVAL from main() is meaningless)

Cc: Usama Anjum <Usama.Anjum@arm.com>
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 tools/testing/selftests/mm/pagemap_ioctl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
index 67a7a3705604..aeedb96dfffb 100644
--- a/tools/testing/selftests/mm/pagemap_ioctl.c
+++ b/tools/testing/selftests/mm/pagemap_ioctl.c
@@ -1553,7 +1553,7 @@ int main(int __attribute__((unused)) argc, char *argv[])
 	ksft_print_header();
 
 	if (init_uffd())
-		ksft_exit_pass();
+		ksft_exit_skip("Failed to initialize userfaultfd\n");
 
 	ksft_set_plan(117);
 
@@ -1562,7 +1562,7 @@ int main(int __attribute__((unused)) argc, char *argv[])
 
 	pagemap_fd = open(PAGEMAP, O_RDONLY);
 	if (pagemap_fd < 0)
-		return -EINVAL;
+		ksft_exit_fail_msg("Failed to open " PAGEMAP "\n");
 
 	/* 1. Sanity testing */
 	sanity_tests_sd();
@@ -1734,5 +1734,5 @@ int main(int __attribute__((unused)) argc, char *argv[])
 	zeropfn_tests();
 
 	close(pagemap_fd);
-	ksft_exit_pass();
+	ksft_finished();
 }
-- 
2.51.2


