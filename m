Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3416763F5F1
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Dec 2022 18:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiLARIj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 12:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiLARIi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 12:08:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9C6A8964;
        Thu,  1 Dec 2022 09:08:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07F2462088;
        Thu,  1 Dec 2022 17:08:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FF8C433D6;
        Thu,  1 Dec 2022 17:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669914516;
        bh=bb/+qN0VW/7RqIAk2UofMX4wZlBJKhvkATUkAKF4jKA=;
        h=From:To:Cc:Subject:Date:From;
        b=JEPpDNsnVhCGYyiDJ5cDyhqXikEiT0RcB4yxn/jMZ7fv7AVfeTgAjru54z8nLIWlj
         lAIyUaV6PZMy+5Fv1lWEovXj6GTs93W4HzojUbUR0BYPYIXKR/vOReNYf1/0CZPmIQ
         wuew5xRVU2m+sUCpgV5WNv6G6Z2J3jlGc7qcmprjxBuInSBhHRGP32eJYY7aF4Za2G
         56suK4RbGZLd6mmSwWIYwg9qyB8O9M7lyENITC6vpJF6FRwJjPg8sma5TjMtdt7aKZ
         7yqSitWsMo3wz5nKU6bvay1ypJPdwz4tqPzRDey44MYfHRMkmEwm5QPg6FyAu80ysJ
         jxkhtpTDpBUSw==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/damon: test removed scheme sysfs dir access bug
Date:   Thu,  1 Dec 2022 17:08:34 +0000
Message-Id: <20221201170834.62823-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A DAMON sysfs user could start DAMON with a scheme, remove the sysfs
directory for the scheme, and then ask stats or schemes tried regions
update.  The related logic were not aware of the already removed
directory situation, so it was able to results in invalid memory
accesses.  The fix has made with commit 8468b486612c
("mm/damon/sysfs-schemes: skip stats update if the scheme directory is
removed"), though.  Add a selftest to avoid such kind of bugs be
introduced again.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/Makefile        |  2 +-
 .../damon/sysfs_update_removed_scheme_dir.sh  | 58 +++++++++++++++++++
 2 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/damon/sysfs_update_removed_scheme_dir.sh

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index 838a8e49f77b..b71247ba7196 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -8,7 +8,7 @@ TEST_PROGS = debugfs_attrs.sh debugfs_schemes.sh debugfs_target_ids.sh
 TEST_PROGS += debugfs_empty_targets.sh debugfs_huge_count_read_write.sh
 TEST_PROGS += debugfs_duplicate_context_creation.sh
 TEST_PROGS += debugfs_rm_non_contexts.sh
-TEST_PROGS += sysfs.sh
+TEST_PROGS += sysfs.sh sysfs_update_removed_scheme_dir.sh
 TEST_PROGS += reclaim.sh lru_sort.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/damon/sysfs_update_removed_scheme_dir.sh b/tools/testing/selftests/damon/sysfs_update_removed_scheme_dir.sh
new file mode 100644
index 000000000000..ade35576e748
--- /dev/null
+++ b/tools/testing/selftests/damon/sysfs_update_removed_scheme_dir.sh
@@ -0,0 +1,58 @@
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
+damon_sysfs="/sys/kernel/mm/damon/admin"
+if [ ! -d "$damon_sysfs" ]
+then
+	echo "damon sysfs not found"
+	exit $ksft_skip
+fi
+
+# clear log
+dmesg -C
+
+# start DAMON with a scheme
+echo 1 > "$damon_sysfs/kdamonds/nr_kdamonds"
+echo 1 > "$damon_sysfs/kdamonds/0/contexts/nr_contexts"
+echo "vaddr" > "$damon_sysfs/kdamonds/0/contexts/0/operations"
+echo 1 > "$damon_sysfs/kdamonds/0/contexts/0/targets/nr_targets"
+echo $$ > "$damon_sysfs/kdamonds/0/contexts/0/targets/0/pid_target"
+echo 1 > "$damon_sysfs/kdamonds/0/contexts/0/schemes/nr_schemes"
+scheme_dir="$damon_sysfs/kdamonds/0/contexts/0/schemes/0"
+echo 4096000 > "$scheme_dir/access_pattern/sz/max"
+echo 20 > "$scheme_dir/access_pattern/nr_accesses/max"
+echo 1024 > "$scheme_dir/access_pattern/age/max"
+echo "on" > "$damon_sysfs/kdamonds/0/state"
+sleep 0.3
+
+# remove scheme sysfs dir
+echo 0 > "$damon_sysfs/kdamonds/0/contexts/0/schemes/nr_schemes"
+
+# try to update stat of already removed scheme sysfs dir
+echo "update_schemes_stats" > "$damon_sysfs/kdamonds/0/state"
+if dmesg | grep -q BUG
+then
+	echo "update_schemes_stats triggers a kernel bug"
+	dmesg
+	exit 1
+fi
+
+# try to update tried regions of already removed scheme sysfs dir
+echo "update_schemes_tried_regions" > "$damon_sysfs/kdamonds/0/state"
+if dmesg | grep -q BUG
+then
+	echo "update_schemes_tried_regions triggers a kernel bug"
+	dmesg
+	exit 1
+fi
+
+echo "off" > "$damon_sysfs/kdamonds/0/state"
-- 
2.25.1

