Return-Path: <linux-kselftest+bounces-49221-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE333D38B6F
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 03:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72AB53045CEE
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 02:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4587E3126CD;
	Sat, 17 Jan 2026 02:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7GLeKDj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AA131159C;
	Sat, 17 Jan 2026 02:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768615660; cv=none; b=tT7D13dL7Zmy4cOAnXfoulZsjTeEu5YERKjwqGo8JF9J1utdsh2qkT4sQS9Fhbk7k1TeJt29nfNtIfIQ/kiUHMTSsJe9D4cJ6B6I+hZtuKVYrNU9kCs9/2kkRltC76EKat5itvQOnDQJEqqRTC5+TZrEYfoFmyXeOcXNebHbey0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768615660; c=relaxed/simple;
	bh=KPSyHpwr1RZ1sL9zrIc+8C+fgY9V82SnKK8ITdn75rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMItpn75CBCSnohcmvgCaVFMR2EONyeLqShx7w/3Ue8v1ePzbiE1aI6DYIaucQDZfJDSyou5NQqKPWIgIk/xPkiU7xdszw5WcTEdpJGikm6OrxbEEj3+FIYu6aQnUT9z4E3y9aCts4M+8wnQO/tYQikkK0Zv40QYzysEPqSF7BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7GLeKDj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE44BC4AF0B;
	Sat, 17 Jan 2026 02:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768615659;
	bh=KPSyHpwr1RZ1sL9zrIc+8C+fgY9V82SnKK8ITdn75rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j7GLeKDjUJJag3xHYuo20Q9Oy/4IhpeJCwFSEsIEGhkJM4UAHZMtMrpDLcX7K4DU5
	 YvAv2YJEt6QyQmWxut7nZLrZe1Y+ClVlt7RlSET69B8PIq05SLwghW3kkb0Ir4VB1W
	 mXI0rwNWHK8nJqReNPQquSZo9W/iW89hWsM5rZR3lgakkdQBdUmSTl7eNmRjX7M6iH
	 g1Bi06uJVvP7tjK5tt9m4+WFC+MBU8ZpCCmX/PmnYTDjSK2Y9WO8ovN2v0JByO9btG
	 8BvDnVDYG1cyzjZTSSFWgxGq0rvUUqC9i25b5L6XAE2gwcJruZHChbLVaq4x6l5B2P
	 6Genz80mDUS9g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/5] selftests/damon/access_memory: add repeat mode
Date: Fri, 16 Jan 2026 18:07:26 -0800
Message-ID: <20260117020731.226785-4-sj@kernel.org>
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

'access_memory' is an artificial memory access generator program that is
used for a few DAMON selftests.  It accesses a given number of regions
one by one only once, and exits.  Depending on systems, the test
workload may exit faster than expected, making the tests unreliable.
For reliable control of the artificial memory access pattern, add a mode
to make it repeat running.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/access_memory.c | 29 ++++++++++++++-----
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/damon/access_memory.c b/tools/testing/selftests/damon/access_memory.c
index 56b17e8fe1be..567793b11107 100644
--- a/tools/testing/selftests/damon/access_memory.c
+++ b/tools/testing/selftests/damon/access_memory.c
@@ -8,6 +8,11 @@
 #include <string.h>
 #include <time.h>
 
+enum access_mode {
+	ACCESS_MODE_ONCE,
+	ACCESS_MODE_REPEAT,
+};
+
 int main(int argc, char *argv[])
 {
 	char **regions;
@@ -15,10 +20,12 @@ int main(int argc, char *argv[])
 	int nr_regions;
 	int sz_region;
 	int access_time_ms;
+	enum access_mode mode = ACCESS_MODE_ONCE;
+
 	int i;
 
-	if (argc != 4) {
-		printf("Usage: %s <number> <size (bytes)> <time (ms)>\n",
+	if (argc < 4) {
+		printf("Usage: %s <number> <size (bytes)> <time (ms)> [mode]\n",
 				argv[0]);
 		return -1;
 	}
@@ -27,15 +34,21 @@ int main(int argc, char *argv[])
 	sz_region = atoi(argv[2]);
 	access_time_ms = atoi(argv[3]);
 
+	if (argc > 4 && !strcmp(argv[4], "repeat"))
+		mode = ACCESS_MODE_REPEAT;
+
 	regions = malloc(sizeof(*regions) * nr_regions);
 	for (i = 0; i < nr_regions; i++)
 		regions[i] = malloc(sz_region);
 
-	for (i = 0; i < nr_regions; i++) {
-		start_clock = clock();
-		while ((clock() - start_clock) * 1000 / CLOCKS_PER_SEC <
-				access_time_ms)
-			memset(regions[i], i, sz_region);
-	}
+	do {
+		for (i = 0; i < nr_regions; i++) {
+			start_clock = clock();
+			while ((clock() - start_clock) * 1000 / CLOCKS_PER_SEC
+					< access_time_ms)
+				memset(regions[i], i, sz_region);
+		}
+	} while (mode == ACCESS_MODE_REPEAT);
+
 	return 0;
 }
-- 
2.47.3

