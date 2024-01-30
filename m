Return-Path: <linux-kselftest+bounces-3728-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7CB841867
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 02:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B61D1F2504F
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 01:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FB1364C4;
	Tue, 30 Jan 2024 01:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFP5NFEw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D00374DD;
	Tue, 30 Jan 2024 01:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578561; cv=none; b=VIOLkQFFVNlehqU6c9ExXgbENLVHTJW1gP1ZUE3+IYHB3O87Hzh0ItSPFVlP6wRDV9dVj8d0O8aKmcXf4VW3m1RSlLbDnsq/BipKkPG+wDZ/jL2JgSIYarPOeQFUQbEVcRNH5OeUi63+a5IlSP/35Bhz3JiSHp8cU3NSE9xyWkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578561; c=relaxed/simple;
	bh=TappCEs1QiYT505+DhU0zSdNYL81quzZAEnLH6jY5LM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JWqdDISbKJu3fNwAKYBR/dr2BQvaRVt0pSeITr7NruYJohg6g6N2v8mtjaHWtHKoJQqnJcYrKRdHzcqrdRaBR8jA5X8BHuzaRR3glykD6Y6YhklX2Ai2T74VoiGXM6Ygcc3NdsujHZW3BWi9vRyuMZfn+bGk7GIjC2fI3iFGsVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFP5NFEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFE5C43390;
	Tue, 30 Jan 2024 01:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706578560;
	bh=TappCEs1QiYT505+DhU0zSdNYL81quzZAEnLH6jY5LM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FFP5NFEwwozb08uVo+7nRDp7jigTnADRzHoD+Dy+L61NqdYWr+6phTtrauODwooAb
	 24tlphXSd5ldl6GdqunuS3hAvvajyCkKiYqyMAUnafFNPGzD8RpSmmKEEpedkpMaKb
	 rk95qqTgwffbKqfnE2aiupjub6g61Ew5jAJrhlWW1e19S9dEhv27qrVbFiSO0IHNvc
	 eTR/lirtG9EvJbGftZc5q6DTflhxF/CmWvc9YokRAgPTvwpvkT3YI4gVashAmj7BdP
	 iboBri8jUHSZ9GFXgaMQWViP3epe2I6gYgm35prRmu9psnS7Kar+u0Vnil+VIFEnDI
	 3z4WulC2vtuRQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] selftets/damon: prepare for monitor_on file renaming
Date: Mon, 29 Jan 2024 17:35:45 -0800
Message-Id: <20240130013549.89538-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240130013549.89538-1-sj@kernel.org>
References: <20240130013549.89538-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following change will rename 'monitor_on' DAMON debugfs file to
'monitor_on_DEPRECATED', to make the deprecation unignorable in runtime.
Since it could make DAMON selftests fail and disturb future bisects,
update DAMON selftests to support the change.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_chk_dependency.sh     | 11 +++++++++--
 tools/testing/selftests/damon/_debugfs_common.sh     |  7 +++++++
 .../testing/selftests/damon/debugfs_empty_targets.sh | 12 ++++++++++--
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/damon/_chk_dependency.sh b/tools/testing/selftests/damon/_chk_dependency.sh
index 0328ac0b5a5e..350f8c2b071d 100644
--- a/tools/testing/selftests/damon/_chk_dependency.sh
+++ b/tools/testing/selftests/damon/_chk_dependency.sh
@@ -18,7 +18,14 @@ then
 	exit $ksft_skip
 fi
 
-for f in attrs target_ids monitor_on
+if [ -f "$DBGFS/monitor_on_DEPRECATED" ]
+then
+	monitor_on_file="monitor_on_DEPRECATED"
+else
+	monitor_on_file="monitor_on"
+fi
+
+for f in attrs target_ids "$monitor_on_file"
 do
 	if [ ! -f "$DBGFS/$f" ]
 	then
@@ -28,7 +35,7 @@ do
 done
 
 permission_error="Operation not permitted"
-for f in attrs target_ids monitor_on
+for f in attrs target_ids "$monitor_on_file"
 do
 	status=$( cat "$DBGFS/$f" 2>&1 )
 	if [ "${status#*$permission_error}" != "$status" ]; then
diff --git a/tools/testing/selftests/damon/_debugfs_common.sh b/tools/testing/selftests/damon/_debugfs_common.sh
index 48989d4813ae..aa995516870b 100644
--- a/tools/testing/selftests/damon/_debugfs_common.sh
+++ b/tools/testing/selftests/damon/_debugfs_common.sh
@@ -45,6 +45,13 @@ test_content() {
 source ./_chk_dependency.sh
 
 damon_onoff="$DBGFS/monitor_on"
+if [ -f "$DBGFS/monitor_on_DEPRECATED" ]
+then
+	damon_onoff="$DBGFS/monitor_on_DEPRECATED"
+else
+	damon_onoff="$DBGFS/monitor_on"
+fi
+
 if [ $(cat "$damon_onoff") = "on" ]
 then
 	echo "monitoring is on"
diff --git a/tools/testing/selftests/damon/debugfs_empty_targets.sh b/tools/testing/selftests/damon/debugfs_empty_targets.sh
index 87aff8083822..effbea33dc16 100755
--- a/tools/testing/selftests/damon/debugfs_empty_targets.sh
+++ b/tools/testing/selftests/damon/debugfs_empty_targets.sh
@@ -8,6 +8,14 @@ source _debugfs_common.sh
 
 orig_target_ids=$(cat "$DBGFS/target_ids")
 echo "" > "$DBGFS/target_ids"
-orig_monitor_on=$(cat "$DBGFS/monitor_on")
-test_write_fail "$DBGFS/monitor_on" "on" "orig_monitor_on" "empty target ids"
+
+if [ -f "$DBGFS/monitor_on_DEPRECATED" ]
+then
+	monitor_on_file="$DBGFS/monitor_on_DEPRECATED"
+else
+	monitor_on_file="$DBGFS/monitor_on"
+fi
+
+orig_monitor_on=$(cat "$monitor_on_file")
+test_write_fail "$monitor_on_file" "on" "orig_monitor_on" "empty target ids"
 echo "$orig_target_ids" > "$DBGFS/target_ids"
-- 
2.39.2


