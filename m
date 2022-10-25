Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8A860D295
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 19:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiJYRhB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 13:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbiJYRg7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 13:36:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EC3D64;
        Tue, 25 Oct 2022 10:36:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9D7BB81E5A;
        Tue, 25 Oct 2022 17:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046A2C43141;
        Tue, 25 Oct 2022 17:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666719416;
        bh=4NBEQVWjkZzG2RZ0IZhDEcaAZKCJsWQ5ei6FDrh1eE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D13bipI5+ZFOlmA3P+OZjs7yvhTB1CxtPiSEjR/7eMpoGmFaJlnmC1ahl0M6VzJ2b
         jzRwMLGRPLeeuI1mE/u6kGnFuKsmODPXEkwnOJ2p3h7moHkT+/Is837OF5KYofdczS
         N7NQXo1Sipv9kc4PzBgnOGGPh1ce/xZFIxI83TXJj3DSyT8+z0pkWXOHGdDXNpA7J6
         jyYdXgaYBRg6mtgKKzq22VwxIA76VBnvpnAJEO/j2ps/61WVED1Su5fagGUzlO/mZd
         PvCuTm5s7xP/RTRQPcjCc3+h/+7qY1/4fvqSrOpkUUHcyfFSN3HTT8MO/qpgHGY6tP
         SQ+BW/725/C5Q==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 2/4] selftests/damon: add tests for DAMON_RECLAIM's enabled parameter
Date:   Tue, 25 Oct 2022 17:36:48 +0000
Message-Id: <20221025173650.90624-3-sj@kernel.org>
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

Adds simple test cases for DAMON_RECLAIM's 'enabled' parameter.  Those
tests are focusing on the synchronous behavior of DAMON_RECLAIM enabling
and disabling.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/Makefile   |  1 +
 tools/testing/selftests/damon/reclaim.sh | 42 ++++++++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100755 tools/testing/selftests/damon/reclaim.sh

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index a1fa2eff8192..dbbf18cb3e6b 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -8,5 +8,6 @@ TEST_PROGS = debugfs_attrs.sh debugfs_schemes.sh debugfs_target_ids.sh
 TEST_PROGS += debugfs_empty_targets.sh debugfs_huge_count_read_write.sh
 TEST_PROGS += debugfs_duplicate_context_creation.sh
 TEST_PROGS += sysfs.sh
+TEST_PROGS += reclaim.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/damon/reclaim.sh b/tools/testing/selftests/damon/reclaim.sh
new file mode 100755
index 000000000000..78dbc2334cbe
--- /dev/null
+++ b/tools/testing/selftests/damon/reclaim.sh
@@ -0,0 +1,42 @@
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
+damon_reclaim_enabled="/sys/module/damon_reclaim/parameters/enabled"
+if [ ! -f "$damon_reclaim_enabled" ]
+then
+	echo "No 'enabled' file.  Maybe DAMON_RECLAIM not built"
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
+echo Y > "$damon_reclaim_enabled"
+
+nr_kdamonds=$(pgrep kdamond | wc -l)
+if [ "$nr_kdamonds" -ne 1 ]
+then
+	echo "kdamond is not turned on"
+	exit 1
+fi
+
+echo N > "$damon_reclaim_enabled"
+nr_kdamonds=$(pgrep kdamond | wc -l)
+if [ "$nr_kdamonds" -ne 0 ]
+then
+	echo "kdamond is not turned off"
+	exit 1
+fi
-- 
2.25.1

