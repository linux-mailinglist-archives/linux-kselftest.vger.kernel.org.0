Return-Path: <linux-kselftest+bounces-16362-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C64295FF93
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 05:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE815B22415
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 03:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5E01422C7;
	Tue, 27 Aug 2024 03:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IczrbT6R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0241613DB99;
	Tue, 27 Aug 2024 03:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724727832; cv=none; b=p3LYoDrZSQgngfVGpi8i4L2D9CgVxIp0L4GNcTRw54HJyIkIGhlXja5L5e74dJ3j3Rq0xNsctc7X6TZkzbgiaS2t+KRuXavd4uSydigRu3sSZvwqs8Z5NaHgvKf7yVjnvbLDAvnrSAEBKvlxjKwzfFBAxS3f6jux/lwyw7GQELI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724727832; c=relaxed/simple;
	bh=JEhQGi/c3/4g839WuUytPNlve2LqyXNGTGf1ZogtfsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h0+MFILNSQb1zZnlEoRmQvq6+EH1jq3ADW4zmpZ5AqS+4GF3cj7XWANI5Fl2AygYdVlzgKQCmVgOC6eL0a6g8mSSxkDCdfuNj4IKELXSlV1VQiIrHHgUOhXlQN6l85j0stCcyIVAUnV7I3JvdKd3rgEIhQE4EHIE/g8jEBAA8Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IczrbT6R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC5BC8B7A6;
	Tue, 27 Aug 2024 03:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724727831;
	bh=JEhQGi/c3/4g839WuUytPNlve2LqyXNGTGf1ZogtfsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IczrbT6R+LHP3ZBa3JKJtLLiR6WHgbj/C9Dboh6+GCb+92z9+N24+xktUiYK6dYqi
	 25HkOqFpJRytB/Apso5kbvD3+Lv1RuFa/jXhFTg7ezFuIl6OJyW8RCUB2VDncsmIq+
	 UPArIf1ELVzUZo31/xUklNdSlYz4Yi1XVT6wU83ASR+T/fiiDMntcItT9CeZotzia0
	 h0FQaXZq02txTzXKE1V5lA0nN0pZkTIp2o99e6ZMMex/oG+S2iHjMc7bIcXSYoJtdQ
	 kB6YyrTdtUCUB9SlI0c+PTFKumZSx+n0ZPkm2SuBNdnFP2cM2xH83hJZ0HV3NIcCxR
	 T+4iHExScOahw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] mm/damon: move kunit tests to tests/ subdirectory with _kunit suffix
Date: Mon, 26 Aug 2024 20:03:35 -0700
Message-Id: <20240827030336.7930-9-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240827030336.7930-1-sj@kernel.org>
References: <20240827030336.7930-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a discussion about better places for kunit test code[1] and
test file name suffix[2].  Folowwing the conclusion, move kunit tests
for DAMON to mm/damon/tests/ subdirectory and rename those.

[1] https://lore.kernel.org/CABVgOS=pUdWb6NDHszuwb1HYws4a1-b1UmN=i8U_ED7HbDT0mg@mail.gmail.com
[2] https://lore.kernel.org/CABVgOSmKwPq7JEpHfS6sbOwsR0B-DBDk_JP-ZD9s9ZizvpUjbQ@mail.gmail.com

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c                                | 2 +-
 mm/damon/dbgfs.c                               | 2 +-
 mm/damon/sysfs.c                               | 2 +-
 mm/damon/{core-test.h => tests/core-kunit.h}   | 0
 mm/damon/{dbgfs-test.h => tests/dbgfs-kunit.h} | 0
 mm/damon/{sysfs-test.h => tests/sysfs-kunit.h} | 0
 mm/damon/{vaddr-test.h => tests/vaddr-kunit.h} | 0
 mm/damon/vaddr.c                               | 2 +-
 8 files changed, 4 insertions(+), 4 deletions(-)
 rename mm/damon/{core-test.h => tests/core-kunit.h} (100%)
 rename mm/damon/{dbgfs-test.h => tests/dbgfs-kunit.h} (100%)
 rename mm/damon/{sysfs-test.h => tests/sysfs-kunit.h} (100%)
 rename mm/damon/{vaddr-test.h => tests/vaddr-kunit.h} (100%)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index a1c32becfc73..1d2c4daef157 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2275,4 +2275,4 @@ static int __init damon_init(void)
 
 subsys_initcall(damon_init);
 
-#include "core-test.h"
+#include "tests/core-kunit.h"
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 51a6f1cac385..b4213bc47e44 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -1145,4 +1145,4 @@ static int __init damon_dbgfs_init(void)
 
 module_init(damon_dbgfs_init);
 
-#include "dbgfs-test.h"
+#include "tests/dbgfs-kunit.h"
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index ecf0835e34b8..4daac92be30b 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1908,4 +1908,4 @@ static int __init damon_sysfs_init(void)
 }
 subsys_initcall(damon_sysfs_init);
 
-#include "sysfs-test.h"
+#include "tests/sysfs-kunit.h"
diff --git a/mm/damon/core-test.h b/mm/damon/tests/core-kunit.h
similarity index 100%
rename from mm/damon/core-test.h
rename to mm/damon/tests/core-kunit.h
diff --git a/mm/damon/dbgfs-test.h b/mm/damon/tests/dbgfs-kunit.h
similarity index 100%
rename from mm/damon/dbgfs-test.h
rename to mm/damon/tests/dbgfs-kunit.h
diff --git a/mm/damon/sysfs-test.h b/mm/damon/tests/sysfs-kunit.h
similarity index 100%
rename from mm/damon/sysfs-test.h
rename to mm/damon/tests/sysfs-kunit.h
diff --git a/mm/damon/vaddr-test.h b/mm/damon/tests/vaddr-kunit.h
similarity index 100%
rename from mm/damon/vaddr-test.h
rename to mm/damon/tests/vaddr-kunit.h
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 58829baf8b5d..b0e8b361891d 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -730,4 +730,4 @@ static int __init damon_va_initcall(void)
 
 subsys_initcall(damon_va_initcall);
 
-#include "vaddr-test.h"
+#include "tests/vaddr-kunit.h"
-- 
2.39.2


