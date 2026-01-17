Return-Path: <linux-kselftest+bounces-49219-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B495CD38B6A
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 03:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB456303D14D
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 02:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3ABE30F808;
	Sat, 17 Jan 2026 02:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJXm0FAm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E13C26E708;
	Sat, 17 Jan 2026 02:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768615659; cv=none; b=WLlww0G7UvlD1g7V8gP+H3PGSiINfQ9POmK/h3DQte/BHeeLDSJBmqc0YW8U+S8mXua8MMT1CFTi7OGjbtf5FXBv5EOx3rwxnMHbp31B60jykWQmsMmQ1HCTxct+EVXgWAvxMgiAwvIShOyZCxbLqIXe7QZblxQM9zStDNUzNt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768615659; c=relaxed/simple;
	bh=C2QHcQZHqTAQDaO9DNebGqZ3A/aRqpTbgJDZ81lxP1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lCjJ2ELhdR2E+uTptDebNzjTtaAVvti9OhyC/ST94IO04Acu2j8/m+k9XMLFJYA4nJy16B2qVO+LGi+O/DMpMiUOpOgPwqYFs5iVVSYXJoSN+NO6N+QBEJETNN76xuVOLmpvHV03FFOvLR4UkkcST6UeLK/EvO9XBft8ivlCXdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJXm0FAm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C06DC16AAE;
	Sat, 17 Jan 2026 02:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768615659;
	bh=C2QHcQZHqTAQDaO9DNebGqZ3A/aRqpTbgJDZ81lxP1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EJXm0FAmw5o7Zyyw0HQ5vmJJXUcfUtEfBgHFoq9+OjGCg59S0H6FkN0JT9lptr+7d
	 0ePzKy/5IaJIzOHvvogDrFClUZEYUmTu0YJXcHrG3lGwiKUC9K2i4af9MCsMlUQFc+
	 RX3vnKMtcB0XTPE0RsZaWxMtbBUa3VsAGhcWNGRBzdRhjpqKE006BZRJnb865ci5Ei
	 PHkOttph3EjUwUtsgx9XLQ6Bvg2TVUieHhuGd7mfm03fFQAGMo8WgEorSrxe06juXV
	 uDdIsESmoRp0InW3CqGrtyzM+R8XWAkVlC7FMgCLfO+fB3/Md8SVqfzO5ErfKX6+aW
	 DoimfPQSCYa9A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/5] selftests/damon/sysfs_memcg_path_leak.sh: use kmemleak
Date: Fri, 16 Jan 2026 18:07:24 -0800
Message-ID: <20260117020731.226785-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260117020731.226785-1-sj@kernel.org>
References: <20260117020731.226785-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysfs_memcg_path_leak.sh determines if the memory leak has happened by
seeing if Slab size on /proc/meminfo increases more than expected after
an action.  Depending on the system and background workloads, the
reasonable expectation varies.  For the reason, the test frequently
shows intermittent failures.  Use kmemleak, which is much more reliable
and correct, instead.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 .../selftests/damon/sysfs_memcg_path_leak.sh  | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/damon/sysfs_memcg_path_leak.sh b/tools/testing/selftests/damon/sysfs_memcg_path_leak.sh
index 64c5d8c518a4..33a7ff43ed6c 100755
--- a/tools/testing/selftests/damon/sysfs_memcg_path_leak.sh
+++ b/tools/testing/selftests/damon/sysfs_memcg_path_leak.sh
@@ -14,6 +14,13 @@ then
 	exit $ksft_skip
 fi
 
+kmemleak="/sys/kernel/debug/kmemleak"
+if [ ! -f "$kmemleak" ]
+then
+	echo "$kmemleak not found"
+	exit $ksft_skip
+fi
+
 # ensure filter directory
 echo 1 > "$damon_sysfs/kdamonds/nr_kdamonds"
 echo 1 > "$damon_sysfs/kdamonds/0/contexts/nr_contexts"
@@ -22,22 +29,17 @@ echo 1 > "$damon_sysfs/kdamonds/0/contexts/0/schemes/0/filters/nr_filters"
 
 filter_dir="$damon_sysfs/kdamonds/0/contexts/0/schemes/0/filters/0"
 
-before_kb=$(grep Slab /proc/meminfo | awk '{print $2}')
-
-# try to leak 3000 KiB
-for i in {1..102400};
+# try to leak 128 times
+for i in {1..128};
 do
 	echo "012345678901234567890123456789" > "$filter_dir/memcg_path"
 done
 
-after_kb=$(grep Slab /proc/meminfo | awk '{print $2}')
-# expect up to 1500 KiB free from other tasks memory
-expected_after_kb_max=$((before_kb + 1500))
-
-if [ "$after_kb" -gt "$expected_after_kb_max" ]
+echo scan > "$kmemleak"
+kmemleak_report=$(cat "$kmemleak")
+if [ "$kmemleak_report" = "" ]
 then
-	echo "maybe memcg_path are leaking: $before_kb -> $after_kb"
-	exit 1
-else
 	exit 0
 fi
+echo "$kmemleak_report"
+exit 1
-- 
2.47.3

