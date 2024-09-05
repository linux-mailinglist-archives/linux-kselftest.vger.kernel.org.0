Return-Path: <linux-kselftest+bounces-17289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C34E896DF84
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 18:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832722813DC
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 16:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6DC19D8B5;
	Thu,  5 Sep 2024 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RC361kxC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427917DA92;
	Thu,  5 Sep 2024 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725553475; cv=none; b=qChII8r1j4uG28VS+F9+M+A1EdUlH0Ed9eIU5FM/tDDHOcSzftAGmFcD95u5H1490hclI/pjeyIxHUWcyjbHsjWTiwsnfKFQc127HoWZup5fx3St4hHx8i4vViU2uIMgnpiNuHltkNosJ2B/yNzl/JCcbWp9xP8pYfaXVNCZtKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725553475; c=relaxed/simple;
	bh=fqMbyiPOPWXkEPOx14J7eYz98VVS1VH43XBaqNJ6PmM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vDEOPjrsgVfJSz6dKZ3BSQOGpnmN3Les1bBtapFtMWLizgYSjIrZR+TBhHYONGkvvCL5mkzUoIsJ5beWU/FM+SAcgECHc5QT+FCbkQMk+w9Na/p6AkHRGNVu4fNJth0OV2ZR/syUE9IEsIBQHQq4pBDralr39q76doK/3L22gEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RC361kxC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F3EC4CEC3;
	Thu,  5 Sep 2024 16:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725553474;
	bh=fqMbyiPOPWXkEPOx14J7eYz98VVS1VH43XBaqNJ6PmM=;
	h=From:To:Cc:Subject:Date:From;
	b=RC361kxC4yaIbdnqo4wbAJzrWBPc0e7jPmVDZEoqIJ2y+Dj8Sz6sbt2zMTEyPnQnP
	 4nIg2jqI5mOYmPVYcXgDS7UbKV965aF4ttZEj879KGiXx6kzt7/odkHiZep5/2VQ3J
	 s5SGuEPod5QOzFoUhKK4C3nVBHmA91ksU0Lohvb+7kvbIiwyqMtvidNfTYEtTJqqnm
	 OTxS8G2pYi7Pd2UgfkWRTUwqbr2kbdSrtIk04562i1lsn08SnRJXQUy/RT3GCTPC5A
	 NH/B0ZVFhRJQBA+Dov6aOk6m5cmF0ghp5KK5BNmczUKF9IL2zKcqjgvnujWf3X3QUE
	 J9pI5UtJxaRmw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] mm/damon/tests/core-kunit: skip damon_test_nr_accesses_to_accesses_bp() if aggr_interval is zero
Date: Thu,  5 Sep 2024 09:24:23 -0700
Message-Id: <20240905162423.74053-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The aggregation interval of test purpose damon_attrs for
damon_test_nr_accesses_to_accesses_bp() becomes zero on 32 bit
architecture, since size of int and long types are same.  As a result,
damon_nr_accesses_to_accesses_bp() call with the test data triggers
divide-by-zero exception.  damon_nr_accesses_to_accesses_bp() shouldn't
be called with such data, and the non-test code avoids that by checking
the case on damon_update_monitoring_results().  Skip the test code in
the case, and add an explicit caution of the case on the comment for the
test target function.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/c771b962-a58f-435b-89e4-1211a9323181@roeck-us.net
Fixes: 5e06ad590096 ("mm/damon/core-test: test max_nr_accesses overflow caused divide-by-zero")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c             |  8 +++++++-
 mm/damon/tests/core-kunit.h | 12 ++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 8b99c5a99c38..a83f3b736d51 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -552,7 +552,13 @@ static unsigned int damon_accesses_bp_to_nr_accesses(
 	return accesses_bp * damon_max_nr_accesses(attrs) / 10000;
 }
 
-/* convert nr_accesses to access ratio in bp (per 10,000) */
+/*
+ * Convert nr_accesses to access ratio in bp (per 10,000).
+ *
+ * Callers should ensure attrs.aggr_interval is not zero, like
+ * damon_update_monitoring_results() does .  Otherwise, divide-by-zero would
+ * happen.
+ */
 static unsigned int damon_nr_accesses_to_accesses_bp(
 		unsigned int nr_accesses, struct damon_attrs *attrs)
 {
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index ae03df71737e..cf22e09a3507 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -320,6 +320,18 @@ static void damon_test_nr_accesses_to_accesses_bp(struct kunit *test)
 		.aggr_interval = ((unsigned long)UINT_MAX + 1) * 10
 	};
 
+	/*
+	 * In some cases such as 32bit architectures where UINT_MAX is
+	 * ULONG_MAX, attrs.aggr_interval becomes zero.  Calling
+	 * damon_nr_accesses_to_accesses_bp() in the case will cause
+	 * divide-by-zero.  Such case is prohibited in normal execution since
+	 * the caution is documented on the comment for the function, and
+	 * damon_update_monitoring_results() does the check.  Skip the test in
+	 * the case.
+	 */
+	if (!attrs.aggr_interval)
+		kunit_skip(test, "aggr_interval is zero.");
+
 	KUNIT_EXPECT_EQ(test, damon_nr_accesses_to_accesses_bp(123, &attrs), 0);
 }
 
-- 
2.39.2


