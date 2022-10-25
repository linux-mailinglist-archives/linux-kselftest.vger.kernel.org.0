Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A76960D297
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 19:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbiJYRhD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 13:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbiJYRg7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 13:36:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7C8101D2;
        Tue, 25 Oct 2022 10:36:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2647161A94;
        Tue, 25 Oct 2022 17:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D997C433D6;
        Tue, 25 Oct 2022 17:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666719418;
        bh=zeB8cawVzfOV+gbJUOEQJ5p17R71STbXoreipmlZFTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OkdC3Pae44Lo+tzDZU5ZqUGPIRcR8H7h0UL4JIPf3l/+1SJBAIwYIN5kpodxDhGCb
         K4isG0kLPGg82hLpEYWbjZTmiYeMI0X7N9G1AEs8ADtPwpvnYhxUW2YJaPP/R1w7fK
         wWaYIjpO1rxbPbYrSjPMKYsE3RdYeQCvRai7TzKwAQyHzn99okFHcdGOHs2eDE1ubT
         lFpWPXQsz+UUPb8FGDteoPbcjbnidXr8B+aDAgoL9NnPJAWHzJiqNl96M2WWDxQNyi
         /3K09Ik3vPGIfj+mqhw3T5J5bm0PU5jzMpx7Juh+ygmAJTK+xAHl0/a5NR3Ums0Ag6
         6tsQRbsBPUA4Q==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 4/4] selftests/damon: add tests for DAMON_LRU_SORT's enabled parameter
Date:   Tue, 25 Oct 2022 17:36:50 +0000
Message-Id: <20221025173650.90624-5-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025173650.90624-1-sj@kernel.org>
References: <20221025173650.90624-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Adds simple test cases for DAMON_LRU_SORT's 'enabled' parameter.  Those
tests are focusing on the synchronous behavior of DAMON_RECLAIM enabling
and disabling.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/Makefile    |  2 +-
 tools/testing/selftests/damon/lru_sort.sh | 41 +++++++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/damon/lru_sort.sh

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index dbbf18cb3e6b..af490acc5348 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -8,6 +8,6 @@ TEST_PROGS = debugfs_attrs.sh debugfs_schemes.sh debugfs_target_ids.sh
 TEST_PROGS += debugfs_empty_targets.sh debugfs_huge_count_read_write.sh
 TEST_PROGS += debugfs_duplicate_context_creation.sh
 TEST_PROGS += sysfs.sh
-TEST_PROGS += reclaim.sh
+TEST_PROGS += reclaim.sh lru_sort.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/damon/lru_sort.sh b/tools/testing/selftests/damon/lru_sort.sh
new file mode 100755
index 000000000000..61b80197c896
--- /dev/null
+++ b/tools/testing/selftests/damon/lru_sort.sh
@@ -0,0 +1,41 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+if [ $EUID -ne 0 ]
+then
+	echo "Run as root"
+	exit $ksft_skip
+fi
+
+damon_lru_sort_enabled="/sys/module/damon_lru_sort/parameters/enabled"
+if [ ! -f "$damon_lru_sort_enabled" ]
+then
+	echo "No 'enabled' file.  Maybe DAMON_LRU_SORT not built"
+	exit $ksft_skip
+fi
+
+nr_kdamonds=$(pgrep kdamond | wc -l)
+if [ "$nr_kdamonds" -ne 0 ]
+then
+	echo "Another kdamond is running"
+	exit $ksft_skip
+fi
+
+echo Y > "$damon_lru_sort_enabled"
+nr_kdamonds=$(pgrep kdamond | wc -l)
+if [ "$nr_kdamonds" -ne 1 ]
+then
+	echo "kdamond is not turned on"
+	exit 1
+fi
+
+echo N > "$damon_lru_sort_enabled"
+nr_kdamonds=$(pgrep kdamond | wc -l)
+if [ "$nr_kdamonds" -ne 0 ]
+then
+	echo "kdamond is not turned off"
+	exit 1
+fi
-- 
2.25.1

