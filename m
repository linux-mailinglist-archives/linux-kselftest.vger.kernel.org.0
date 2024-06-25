Return-Path: <linux-kselftest+bounces-12720-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D58916FCB
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 20:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659CC1F21F6F
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 18:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4D917BB09;
	Tue, 25 Jun 2024 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sc+31Mqf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F4217B438;
	Tue, 25 Jun 2024 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719338746; cv=none; b=EnBmFdQLlDn9APVGTK0lv0k9D5SejLNhBTYGYpHnGllE+I0MhTPHhajPF+qyczFzKiUXmY/aFRk7Mc5ZChYp0cuuOXmHpPfrPFXnMx8B0wUErx+q6fZYqGm51tVzWecGa7ryzJsiRgE8XuYeUGqzOPYsC3EO0m8LzOXEQ9tvEnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719338746; c=relaxed/simple;
	bh=ywuSH6qCkdeHkBE80ZCaTZoKmSWBRtvzgEieCdzLvOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZB7ajgUJi3SgPwCRQz8e+vZTZKZ///aiQBvnORH0EWp+so3kMNVpRkNF+0FLIZAIYOcPU7LeaGU3fHUD2Lw4zYyDxYTfbiBXNvbThAfgNrUqkQEK9+Tg13Jd2l7OtP39UOLKrWgXb9epAATmfe1TygLM3sEgFvBstdvC4Q61rj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sc+31Mqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE19C4AF0A;
	Tue, 25 Jun 2024 18:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719338746;
	bh=ywuSH6qCkdeHkBE80ZCaTZoKmSWBRtvzgEieCdzLvOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sc+31Mqfm7OWQ/QmyXmPnb6jz1ppHcjAVkVMJ103bsVJhmTZeMfZSEzV0KfD463mE
	 Jfa3Ujynn3hCCArqzfJyoQk0aNGRgAf7QpPtNGn/1JbrBpQXkp/TBfc/VKg5eqi9Bp
	 4pZn6ivEFleWQ08gkTga3GNnGE8dJIqueR/Xu8PYWmAVmda2ZMZPe23GZE8RBO9AvX
	 4GRqw/WU6iEV0kYPjq8Z8oMCo2/COA1yLCqidJZjFsKOt63LyFdZvxEGWCyUElhuFm
	 MUzVwaBzNnFJYumVJC+UaZbqqfLgkonFu9qi5myPcSoQ7P2pjo+A3komKxNcWG3waB
	 ixjwGIK9+g4sg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] selftests/damon: implement a program for even-numbered memory regions access
Date: Tue, 25 Jun 2024 11:05:33 -0700
Message-Id: <20240625180538.73134-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240625180538.73134-1-sj@kernel.org>
References: <20240625180538.73134-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To test schemes_tried_regions feature, we need to have a program having
specific number of regions that having different access pattern.
Existing artificial access pattern generator, 'access_memory', cannot be
used for the purpose, since it accesses only one region at a given time.
Extending it could be an option, but since the purpose and the
implementation are pretty simple, implementing another one from the
scratch is better.

Implement such another artificial memory access program that alloctes
user-defined number/size regions and accesses even-numbered regions.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/Makefile        |  2 +-
 .../selftests/damon/access_memory_even.c      | 42 +++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/damon/access_memory_even.c

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index 29a22f50e762..7b972b5cf487 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -4,7 +4,7 @@
 TEST_GEN_FILES += huge_count_read_write
 TEST_GEN_FILES += debugfs_target_ids_read_before_terminate_race
 TEST_GEN_FILES += debugfs_target_ids_pid_leak
-TEST_GEN_FILES += access_memory
+TEST_GEN_FILES += access_memory access_memory_even
 
 TEST_FILES = _chk_dependency.sh _debugfs_common.sh
 
diff --git a/tools/testing/selftests/damon/access_memory_even.c b/tools/testing/selftests/damon/access_memory_even.c
new file mode 100644
index 000000000000..3be121487432
--- /dev/null
+++ b/tools/testing/selftests/damon/access_memory_even.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Artificial memory access program for testing DAMON.
+ *
+ * Receives number of regions and size of each region from user.  Allocate the
+ * regions and repeatedly access even numbered (starting from zero) regions.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+
+int main(int argc, char *argv[])
+{
+	char **regions;
+	clock_t start_clock;
+	int nr_regions;
+	int sz_region;
+	int access_time_ms;
+	int i;
+
+	if (argc != 3) {
+		printf("Usage: %s <number> <size (bytes)>\n", argv[0]);
+		return -1;
+	}
+
+	nr_regions = atoi(argv[1]);
+	sz_region = atoi(argv[2]);
+
+	regions = malloc(sizeof(*regions) * nr_regions);
+	for (i = 0; i < nr_regions; i++)
+		regions[i] = malloc(sz_region);
+
+	while (1) {
+		for (i = 0; i < nr_regions; i++) {
+			if (i % 2 == 0)
+				memset(regions[i], i, sz_region);
+		}
+	}
+	return 0;
+}
-- 
2.39.2


