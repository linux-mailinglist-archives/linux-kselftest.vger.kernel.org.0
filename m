Return-Path: <linux-kselftest+bounces-45347-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 580CFC4F78F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 19:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389BA189570B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 18:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E648229E101;
	Tue, 11 Nov 2025 18:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idvbzuY3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB75D29CB48;
	Tue, 11 Nov 2025 18:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762886667; cv=none; b=oAAxSVQSuj/qF1M9WqOESMHQkD6nfDseyi3sRJXo5D5LafCU4odebhfGokHQd5fDRp/XExtKAlKXQDBZ7/Unvlc/XXcPPnwjYoW2B9hiWck9gQ5lcwtzIaCErm1+tJQa0mS6mPrAAf1Pwhwdu0y//CAU1Gvdu9itxrV5hMudgRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762886667; c=relaxed/simple;
	bh=zbEUetZe1c1xcRt1OCgTl8LCaIpsolP/79QDN3FVibc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdyDFejiGTsgRaXtRsQRxFGQzFNcf4ypSiKwc80grVE5afO1JqzeCqg8rEEHBMMHqQ0/vM10cnGfQG501TtjYcMgRMMgv1Mqk6RU3PhsHDCqdILIzQnmgUYQmx97mBfzEQm73scT5o/4HA9Qkjp7iPVxmpSgLz9n+HNDroAIxic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idvbzuY3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9BCC4CEF7;
	Tue, 11 Nov 2025 18:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762886667;
	bh=zbEUetZe1c1xcRt1OCgTl8LCaIpsolP/79QDN3FVibc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=idvbzuY3Y/fIkegrqp6zLZHd6RqtUjeLzgaU25symERrWFb9VGucHpztZYkxG8gBX
	 zyj4TMqyKJIPIyOHgGgJ+AIy+//vqUn3UnparLqEoQ6oDLQBYeCjN7fZQCQd/xZ01w
	 MvoCymFWU+ME5cH7oJB0A6sk+8l/1/Uee7OWMNnex3X7C5J117SYwPHVjPFrITdZP1
	 LRE/tyJhCb2Wd28LRm3m7umdl87k+PgjhwDeLjgHOdSQ5sy9th+r56qKMwtK5gnDTr
	 zUvCqLREHKdH04OvAjgLeEZKp+tp5cdoc2zYAFsA8JhzbVis0vEnfmpiRizxwL6iYu
	 Hb6Ovr6IVDIVA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 02/11] mm/damon/tests/core-kunit: split out damos_test_commit_filter() core logic
Date: Tue, 11 Nov 2025 10:44:01 -0800
Message-ID: <20251111184415.141757-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111184415.141757-1-sj@kernel.org>
References: <20251111184415.141757-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_test_commit_filter() is written for only a single test case.
Split out the core logic of damos_test_commit_filter() as a general one
so that it can be reused for multiple test cases.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index ae97886137dc..31f90cfcabf3 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -497,6 +497,15 @@ static void damos_test_new_filter(struct kunit *test)
 	damos_destroy_filter(filter);
 }
 
+static void damos_test_commit_filter_for(struct kunit *test,
+		struct damos_filter *dst, struct damos_filter *src)
+{
+	damos_commit_filter(dst, src);
+	KUNIT_EXPECT_EQ(test, dst->type, src->type);
+	KUNIT_EXPECT_EQ(test, dst->matching, src->matching);
+	KUNIT_EXPECT_EQ(test, dst->allow, src->allow);
+}
+
 static void damos_test_commit_filter(struct kunit *test)
 {
 	struct damos_filter src_filter = {
@@ -509,10 +518,7 @@ static void damos_test_commit_filter(struct kunit *test)
 		.allow = false,
 	};
 
-	damos_commit_filter(&dst_filter, &src_filter);
-	KUNIT_EXPECT_EQ(test, dst_filter.type, src_filter.type);
-	KUNIT_EXPECT_EQ(test, dst_filter.matching, src_filter.matching);
-	KUNIT_EXPECT_EQ(test, dst_filter.allow, src_filter.allow);
+	damos_test_commit_filter_for(test, &dst_filter, &src_filter);
 }
 
 static void damos_test_filter_out(struct kunit *test)
-- 
2.47.3

