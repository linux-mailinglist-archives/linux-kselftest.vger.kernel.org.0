Return-Path: <linux-kselftest+bounces-35385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF96AE0D0A
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 20:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC7A1C23141
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 18:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B400228CF43;
	Thu, 19 Jun 2025 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQfzEKei"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DF628C86C;
	Thu, 19 Jun 2025 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750358174; cv=none; b=K+bpaAHgbOzenSjRWY0zhQwL+vqlKih5kLe/IphwHiPBhYuiMI5okSMXHm7k+ESAyYD6GLVf4v7GGHalW5KDY0i9WfrVl5rslS9SKOYSY6RSN/Nt3RykaESOBeMoCCTXTo5BhHKrO6/5rVsl/e5naJGaRETk8Q37lXveQipZ+3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750358174; c=relaxed/simple;
	bh=h78HL1yhuRvAVMpXPcUMwO2YijRYqZLpPbhvfJ9cjQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QZN5VvB8Qu/peWivlBKNOu5XFr2P4Jsf3JyWM3G1hYkcyytfdfUqV6mD4waNfjMkniTYaru0DYn6d82cL+m8Lv5ZrIAu8SOzcRBWCIt4EEtBY+mYOW5MLAByT/W0X9UpH/3R6A5dr5IdvdPM+e/7BWrICtNbD7J7KBHUEay9+hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQfzEKei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342A7C4AF09;
	Thu, 19 Jun 2025 18:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750358174;
	bh=h78HL1yhuRvAVMpXPcUMwO2YijRYqZLpPbhvfJ9cjQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GQfzEKei/1zZvyDY1Tb8HPf3vF0y7sqyzYcDjV7tdUQzqJqKIiyuhNH2RL8fj3Zes
	 DCEJOEJGdipAMa/jEHbzOxx5hhpLLlv/H9dPUpBcX+9s5uBCq7IUUr7CwPe7LIBlQN
	 pHF+f7Di90RTr/5Yv74webbgxBPoOZ5aui4Q2hKn9b8kl0EGEC/Hym/MzFsa0ZiUZZ
	 S1uklJjU4bDvLsRK1qt/HHGq3KSQ1cb41oJJp/f/ontLZVZ6yBUgAecGtMyM9/WOVf
	 uo2brww9xsSdNIX04UFXEeAzBF+HTD89CR1vvwdkzwQE9D8sx/Vu3A0eiqdCBnRm2U
	 2alJ/tI7VSwCw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/2] selftets/damon: add a test for memcg_path leak
Date: Thu, 19 Jun 2025 11:36:08 -0700
Message-Id: <20250619183608.6647-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250619183608.6647-1-sj@kernel.org>
References: <20250619183608.6647-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a memory leak bug in DAMOS sysfs memcg_path file.  Add a
selftest to ensure the bug never comes back.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/Makefile        |  1 +
 .../selftests/damon/sysfs_memcg_path_leak.sh  | 43 +++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100755 tools/testing/selftests/damon/sysfs_memcg_path_leak.sh

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index ff21524be458..e888455e3cf8 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -15,6 +15,7 @@ TEST_PROGS += reclaim.sh lru_sort.sh
 # regression tests (reproducers of previously found bugs)
 TEST_PROGS += sysfs_update_removed_scheme_dir.sh
 TEST_PROGS += sysfs_update_schemes_tried_regions_hang.py
+TEST_PROGS += sysfs_memcg_path_leak.sh
 
 EXTRA_CLEAN = __pycache__
 
diff --git a/tools/testing/selftests/damon/sysfs_memcg_path_leak.sh b/tools/testing/selftests/damon/sysfs_memcg_path_leak.sh
new file mode 100755
index 000000000000..64c5d8c518a4
--- /dev/null
+++ b/tools/testing/selftests/damon/sysfs_memcg_path_leak.sh
@@ -0,0 +1,43 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+if [ $EUID -ne 0 ]
+then
+	echo "Run as root"
+	exit $ksft_skip
+fi
+
+damon_sysfs="/sys/kernel/mm/damon/admin"
+if [ ! -d "$damon_sysfs" ]
+then
+	echo "damon sysfs not found"
+	exit $ksft_skip
+fi
+
+# ensure filter directory
+echo 1 > "$damon_sysfs/kdamonds/nr_kdamonds"
+echo 1 > "$damon_sysfs/kdamonds/0/contexts/nr_contexts"
+echo 1 > "$damon_sysfs/kdamonds/0/contexts/0/schemes/nr_schemes"
+echo 1 > "$damon_sysfs/kdamonds/0/contexts/0/schemes/0/filters/nr_filters"
+
+filter_dir="$damon_sysfs/kdamonds/0/contexts/0/schemes/0/filters/0"
+
+before_kb=$(grep Slab /proc/meminfo | awk '{print $2}')
+
+# try to leak 3000 KiB
+for i in {1..102400};
+do
+	echo "012345678901234567890123456789" > "$filter_dir/memcg_path"
+done
+
+after_kb=$(grep Slab /proc/meminfo | awk '{print $2}')
+# expect up to 1500 KiB free from other tasks memory
+expected_after_kb_max=$((before_kb + 1500))
+
+if [ "$after_kb" -gt "$expected_after_kb_max" ]
+then
+	echo "maybe memcg_path are leaking: $before_kb -> $after_kb"
+	exit 1
+else
+	exit 0
+fi
-- 
2.39.5

