Return-Path: <linux-kselftest+bounces-4283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B9184D30C
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 21:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04FD81C24A28
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 20:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EF612BE95;
	Wed,  7 Feb 2024 20:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZjKuePx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F23512B17F;
	Wed,  7 Feb 2024 20:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707337907; cv=none; b=Ld9jZNUPmjqGaUia2x5O3i7BSZLejcelEe9MRHOibqQVs0VtZgQROFBSZxV9g9BmEjQFar9DQNXqUCWQF4zO0v4okCMOHHyz8IJlMeg0DuYO+xPIvoonZXW4VhXpITWodXkSuRlW7Pipq2qhdo5SVw94iREazeEfTTR2YCm83uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707337907; c=relaxed/simple;
	bh=bo48Sw4QueorxjSh+Ck9B6Mrnc7pi7WnA/Re94O6ZTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UkGcCbrRz3Bmwg9aO8HjpxCS5sKst6esVmfucd2uAw28n3x1loMo05ivyXZzxat9uCOAPgm3W1Ja6aY66E9INT6FMP/3MXBzZ54uUQZPIE9OmVDAsjpF5e80ChL0I1nmop6eBjPnyaby7X2yLGCzReWu8pAXxBCQ1GLrkVNaWIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZjKuePx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA0CC43142;
	Wed,  7 Feb 2024 20:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707337907;
	bh=bo48Sw4QueorxjSh+Ck9B6Mrnc7pi7WnA/Re94O6ZTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bZjKuePxNwzjVi/Qv2DXVeStIOUrZJHJYuqVTzb+TgaleSHCdDc57bdrDp2DxAX3q
	 tRduOaVNfL1p6H56MRwykS5lAAwln08xpqJTJn8U1LGaVj6v8Db2XM9nwyrpve4Yu8
	 zMqsG+ifH1Z5Zo9j7NpyGkqJBhe1nZv2ZrGOSUQxJrqtNZYdBHNOIoDC4yEUOrdBDU
	 TWkYBjx1+scE9tW43zJLFEApIyP2qJQRoBwtAzZMKV3eaqJHrkrFio8N8hlKJTpB4Y
	 2PAJKPUeIiNECiNtD0y1VJ5z3hBfdLm+eqHH24vbuI+smXyAFJaXUuwPzkLoORW1rb
	 vBYeGFwVYMdZg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] selftests/damon/_chk_dependency: get debugfs mount point from /proc/mounts
Date: Wed,  7 Feb 2024 12:31:34 -0800
Message-Id: <20240207203134.69976-9-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240207203134.69976-1-sj@kernel.org>
References: <20240207203134.69976-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON debugfs selftests dependency checker assumes debugfs would be
mounted at /sys/kernel/debug.  That would be ok for many cases, but some
systems might mounted the file system on some different places.  Parse
the real mount point using /proc/mounts file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_chk_dependency.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/damon/_chk_dependency.sh b/tools/testing/selftests/damon/_chk_dependency.sh
index 350f8c2b071d..dda3a87dc00a 100644
--- a/tools/testing/selftests/damon/_chk_dependency.sh
+++ b/tools/testing/selftests/damon/_chk_dependency.sh
@@ -4,7 +4,14 @@
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
-DBGFS=/sys/kernel/debug/damon
+DBGFS=$(grep debugfs /proc/mounts --max-count 1 | awk '{print $2}')
+if [ "$DBGFS" = "" ]
+then
+	echo "debugfs not mounted"
+	exit $ksft_skip
+fi
+
+DBGFS+="/damon"
 
 if [ $EUID -ne 0 ];
 then
-- 
2.39.2


