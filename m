Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26184650D1
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Dec 2021 16:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350368AbhLAPIa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Dec 2021 10:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350342AbhLAPI2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Dec 2021 10:08:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9691C061574;
        Wed,  1 Dec 2021 07:05:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 917D3B82013;
        Wed,  1 Dec 2021 15:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FACC58327;
        Wed,  1 Dec 2021 15:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638371105;
        bh=ZLNKsQlFSLqYMsBCfb792+tzS72UfrLFubOGm2kx3Lw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pj7KV7zpySualdRJt4DuoXFbR0fal4UOQ6kG2NVd9hSzWzHfLomHVhgfrvswswnsG
         t6ZfSC6Ak87/YTuQrFpJoYmdlLRc40NdTzACd42zzmsH4BEJqcTAFH7ITOf6ZKtUSS
         xEIVNeqpqWZe9zXDTNVihpVXQQsTXhUW+L5P8XKZQBp5b9Bc/rBeu0m09kY1mj9h/E
         Inp7g6vLvHSiD+wjLWnprxWV3jOgdBnAlb3C+p4k0tyBNhsSmNZKPvbOB29YcL1ZyP
         sne6CTWbmrBreJvXBWRcJ3Gxs3NSCR8SyI5BpJXEDJhm3uKkjlVfeIiiTzbQlAy6DS
         /39oY+HQ0BGCQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     shuah@kernel.org, brendanhiggins@google.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 08/11] selftests/damon: Test DAMON enabling with empty target_ids case
Date:   Wed,  1 Dec 2021 15:04:37 +0000
Message-Id: <20211201150440.1088-9-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211201150440.1088-1-sj@kernel.org>
References: <20211201150440.1088-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DAMON debugfs didn't check empty targets when starting monitoring, and
the issue is fixed with commit b5ca3e83ddb0 ("mm/damon/dbgfs: add
adaptive_targets list check before enable monitor_on").  To avoid future
regression, this commit adds a test case for that in DAMON selftests.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/debugfs_attrs.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/damon/debugfs_attrs.sh b/tools/testing/selftests/damon/debugfs_attrs.sh
index fc80380c59f0..d0916373f310 100644
--- a/tools/testing/selftests/damon/debugfs_attrs.sh
+++ b/tools/testing/selftests/damon/debugfs_attrs.sh
@@ -94,4 +94,13 @@ test_write_succ "$file" "" "$orig_content" "empty input"
 test_content "$file" "$orig_content" "" "empty input written"
 echo "$orig_content" > "$file"
 
+# Test empty targets case
+# =======================
+
+orig_target_ids=$(cat "$DBGFS/target_ids")
+echo "" > "$DBGFS/target_ids"
+orig_monitor_on=$(cat "$DBGFS/monitor_on")
+test_write_fail "$DBGFS/monitor_on" "on" "orig_monitor_on" "empty target ids"
+echo "$orig_target_ids" > "$DBGFS/target_ids"
+
 echo "PASS"
-- 
2.17.1

