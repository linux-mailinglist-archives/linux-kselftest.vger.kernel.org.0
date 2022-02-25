Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BDE4C4573
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 14:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240954AbiBYNIz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 08:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbiBYNIs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 08:08:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6181E7A5F;
        Fri, 25 Feb 2022 05:08:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B57C7B830B5;
        Fri, 25 Feb 2022 13:08:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A71CC340F1;
        Fri, 25 Feb 2022 13:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645794482;
        bh=aFXZs4gJDapIZa98xuTSqwWOnEa7ktOvSyOqX1aA5WI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gjhPAHVIvkQLZmFcpFhNUsVzbvra/ImUq4QSZE+bw0JAE6E/6M9LYvp2HTTxjYBt4
         CJ3qnC1BFaYb10gALlwwjkQUESELRlxQIEFIsT7oL/11V9XV9H2ol8TkDDtqKXHtGn
         nUO27aNKpfJWd9kvdIhAmIqRRoC6WymJjgWwUPo+7PZY1Yq8CU9gwmDTZ0SLgybk+/
         WxwLlqyoBIp+rZrBxBPG98c8zGOB/ItGr8Hwqq5Ht5FMQyXk49koCx7VaJL6UiBAuG
         57q5FY57jvquyShGKpdMLhk/NDWuGKuNQnzL+KURpzJMDGIQB2LidzG44F+1Z4Lrwn
         22Yc1h23GXt0A==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, skhan@linuxfoundation.org, rientjes@google.com,
        xhao@linux.alibaba.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH v2 11/13] selftests/damon: Add a test for DAMON sysfs interface
Date:   Fri, 25 Feb 2022 13:07:10 +0000
Message-Id: <20220225130712.12682-12-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220225130712.12682-1-sj@kernel.org>
References: <20220225130712.12682-1-sj@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This commit adds a selftest for DAMON sysfs interface.  It tests the
functionality of 'nr' files and existence of files in each directory of
the hierarchy.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/Makefile |   1 +
 tools/testing/selftests/damon/sysfs.sh | 306 +++++++++++++++++++++++++
 2 files changed, 307 insertions(+)
 create mode 100755 tools/testing/selftests/damon/sysfs.sh

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index 937d36ae9a69..0470c5f3e690 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -6,5 +6,6 @@ TEST_GEN_FILES += huge_count_read_write
 TEST_FILES = _chk_dependency.sh _debugfs_common.sh
 TEST_PROGS = debugfs_attrs.sh debugfs_schemes.sh debugfs_target_ids.sh
 TEST_PROGS += debugfs_empty_targets.sh debugfs_huge_count_read_write.sh
+TEST_PROGS += sysfs.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
new file mode 100755
index 000000000000..2e3ae77cb6db
--- /dev/null
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -0,0 +1,306 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# Kselftest frmework requirement - SKIP code is 4.
+ksft_skip=4
+
+ensure_write_succ()
+{
+	file=$1
+	content=$2
+	reason=$3
+
+	if ! echo "$content" > "$file"
+	then
+		echo "writing $content to $file failed"
+		echo "expected success because $reason"
+		exit 1
+	fi
+}
+
+ensure_write_fail()
+{
+	file=$1
+	content=$2
+	reason=$3
+
+	if echo "$content" > "$file"
+	then
+		echo "writing $content to $file succeed ($fail_reason)"
+		echo "expected failure because $reason"
+		exit 1
+	fi
+}
+
+ensure_dir()
+{
+	dir=$1
+	to_ensure=$2
+	if [ "$to_ensure" = "exist" ] && [ ! -d "$dir" ]
+	then
+		echo "$dir dir is expected but not found"
+		exit 1
+	elif [ "$to_ensure" = "not_exist" ] && [ -d "$dir" ]
+	then
+		echo "$dir dir is not expected but found"
+		exit 1
+	fi
+}
+
+ensure_file()
+{
+	file=$1
+	to_ensure=$2
+	permission=$3
+	if [ "$to_ensure" = "exist" ]
+	then
+		if [ ! -f "$file" ]
+		then
+			echo "$file is expected but not found"
+			exit 1
+		fi
+		perm=$(stat -c "%a" "$file")
+		if [ ! "$perm" = "$permission" ]
+		then
+			echo "$file permission: expected $permission but $perm"
+			exit 1
+		fi
+	elif [ "$to_ensure" = "not_exist" ] && [ -f "$dir" ]
+	then
+		echo "$file is not expected but found"
+		exit 1
+	fi
+}
+
+test_range()
+{
+	range_dir=$1
+	ensure_dir "$range_dir" "exist"
+	ensure_file "$range_dir/min" "exist" 600
+	ensure_file "$range_dir/max" "exist" 600
+}
+
+test_stats()
+{
+	stats_dir=$1
+	ensure_dir "$stats_dir" "exist"
+	for f in nr_tried sz_tried nr_applied sz_applied qt_exceeds
+	do
+		ensure_file "$stats_dir/$f" "exist" "400"
+	done
+}
+
+test_watermarks()
+{
+	watermarks_dir=$1
+	ensure_dir "$watermarks_dir" "exist"
+	ensure_file "$watermarks_dir/metric" "exist" "600"
+	ensure_file "$watermarks_dir/interval_us" "exist" "600"
+	ensure_file "$watermarks_dir/high" "exist" "600"
+	ensure_file "$watermarks_dir/mid" "exist" "600"
+	ensure_file "$watermarks_dir/low" "exist" "600"
+}
+
+test_weights()
+{
+	weights_dir=$1
+	ensure_dir "$weights_dir" "exist"
+	ensure_file "$weights_dir/sz_permil" "exist" "600"
+	ensure_file "$weights_dir/nr_accesses_permil" "exist" "600"
+	ensure_file "$weights_dir/age_permil" "exist" "600"
+}
+
+test_quotas()
+{
+	quotas_dir=$1
+	ensure_dir "$quotas_dir" "exist"
+	ensure_file "$quotas_dir/ms" "exist" 600
+	ensure_file "$quotas_dir/bytes" "exist" 600
+	ensure_file "$quotas_dir/reset_interval_ms" "exist" 600
+	test_weights "$quotas_dir/weights"
+}
+
+test_access_pattern()
+{
+	access_pattern_dir=$1
+	ensure_dir "$access_pattern_dir" "exist"
+	test_range "$access_pattern_dir/age"
+	test_range "$access_pattern_dir/nr_accesses"
+	test_range "$access_pattern_dir/sz"
+}
+
+test_scheme()
+{
+	scheme_dir=$1
+	ensure_dir "$scheme_dir" "exist"
+	ensure_file "$scheme_dir/action" "exist" "600"
+	test_access_pattern "$scheme_dir/access_pattern"
+	test_quotas "$scheme_dir/quotas"
+	test_watermarks "$scheme_dir/watermarks"
+	test_stats "$scheme_dir/stats"
+}
+
+test_schemes()
+{
+	schemes_dir=$1
+	ensure_dir "$schemes_dir" "exist"
+	ensure_file "$schemes_dir/nr_schemes" "exist" 600
+
+	ensure_write_succ  "$schemes_dir/nr_schemes" "1" "valid input"
+	test_scheme "$schemes_dir/0"
+
+	ensure_write_succ  "$schemes_dir/nr_schemes" "2" "valid input"
+	test_scheme "$schemes_dir/0"
+	test_scheme "$schemes_dir/1"
+
+	ensure_write_succ "$schemes_dir/nr_schemes" "0" "valid input"
+	ensure_dir "$schemes_dir/0" "not_exist"
+	ensure_dir "$schemes_dir/1" "not_exist"
+}
+
+test_region()
+{
+	region_dir=$1
+	ensure_dir "$region_dir" "exist"
+	ensure_file "$region_dir/start" "exist" 600
+	ensure_file "$region_dir/end" "exist" 600
+}
+
+test_regions()
+{
+	regions_dir=$1
+	ensure_dir "$regions_dir" "exist"
+	ensure_file "$regions_dir/nr_regions" "exist" 600
+
+	ensure_write_succ  "$regions_dir/nr_regions" "1" "valid input"
+	test_region "$regions_dir/0"
+
+	ensure_write_succ  "$regions_dir/nr_regions" "2" "valid input"
+	test_region "$regions_dir/0"
+	test_region "$regions_dir/1"
+
+	ensure_write_succ "$regions_dir/nr_regions" "0" "valid input"
+	ensure_dir "$regions_dir/0" "not_exist"
+	ensure_dir "$regions_dir/1" "not_exist"
+}
+
+test_target()
+{
+	target_dir=$1
+	ensure_dir "$target_dir" "exist"
+	ensure_file "$target_dir/pid_target" "exist" "600"
+	test_regions "$target_dir/regions"
+}
+
+test_targets()
+{
+	targets_dir=$1
+	ensure_dir "$targets_dir" "exist"
+	ensure_file "$targets_dir/nr_targets" "exist" 600
+
+	ensure_write_succ  "$targets_dir/nr_targets" "1" "valid input"
+	test_target "$targets_dir/0"
+
+	ensure_write_succ  "$targets_dir/nr_targets" "2" "valid input"
+	test_target "$targets_dir/0"
+	test_target "$targets_dir/1"
+
+	ensure_write_succ "$targets_dir/nr_targets" "0" "valid input"
+	ensure_dir "$targets_dir/0" "not_exist"
+	ensure_dir "$targets_dir/1" "not_exist"
+}
+
+test_intervals()
+{
+	intervals_dir=$1
+	ensure_dir "$intervals_dir" "exist"
+	ensure_file "$intervals_dir/aggr_us" "exist" "600"
+	ensure_file "$intervals_dir/sample_us" "exist" "600"
+	ensure_file "$intervals_dir/update_us" "exist" "600"
+}
+
+test_monitoring_attrs()
+{
+	monitoring_attrs_dir=$1
+	ensure_dir "$monitoring_attrs_dir" "exist"
+	test_intervals "$monitoring_attrs_dir/intervals"
+	test_range "$monitoring_attrs_dir/nr_regions"
+}
+
+test_context()
+{
+	context_dir=$1
+	ensure_dir "$context_dir" "exist"
+	ensure_file "$context_dir/operations" "exist" 600
+	test_monitoring_attrs "$context_dir/monitoring_attrs"
+	test_targets "$context_dir/targets"
+	test_schemes "$context_dir/schemes"
+}
+
+test_contexts()
+{
+	contexts_dir=$1
+	ensure_dir "$contexts_dir" "exist"
+	ensure_file "$contexts_dir/nr_contexts" "exist" 600
+
+	ensure_write_succ  "$contexts_dir/nr_contexts" "1" "valid input"
+	test_context "$contexts_dir/0"
+
+	ensure_write_fail "$contexts_dir/nr_contexts" "2" "only 0/1 are supported"
+	test_context "$contexts_dir/0"
+
+	ensure_write_succ "$contexts_dir/nr_contexts" "0" "valid input"
+	ensure_dir "$contexts_dir/0" "not_exist"
+}
+
+test_kdamond()
+{
+	kdamond_dir=$1
+	ensure_dir "$kdamond_dir" "exist"
+	ensure_file "$kdamond_dir/state" "exist" "600"
+	ensure_file "$kdamond_dir/pid" "exist" 400
+	test_contexts "$kdamond_dir/contexts"
+}
+
+test_kdamonds()
+{
+	kdamonds_dir=$1
+	ensure_dir "$kdamonds_dir" "exist"
+
+	ensure_file "$kdamonds_dir/nr_kdamonds" "exist" "600"
+
+	ensure_write_succ  "$kdamonds_dir/nr_kdamonds" "1" "valid input"
+	test_kdamond "$kdamonds_dir/0"
+
+	ensure_write_succ  "$kdamonds_dir/nr_kdamonds" "2" "valid input"
+	test_kdamond "$kdamonds_dir/0"
+	test_kdamond "$kdamonds_dir/1"
+
+	ensure_write_succ "$kdamonds_dir/nr_kdamonds" "0" "valid input"
+	ensure_dir "$kdamonds_dir/0" "not_exist"
+	ensure_dir "$kdamonds_dir/1" "not_exist"
+}
+
+test_damon_sysfs()
+{
+	damon_sysfs=$1
+	if [ ! -d "$damon_sysfs" ]
+	then
+		echo "$damon_sysfs not found"
+		exit $ksft_skip
+	fi
+
+	test_kdamonds "$damon_sysfs/kdamonds"
+}
+
+check_dependencies()
+{
+	if [ $EUID -ne 0 ]
+	then
+		echo "Run as root"
+		exit $ksft_skip
+	fi
+}
+
+check_dependencies
+test_damon_sysfs "/sys/kernel/mm/damon/admin"
-- 
2.17.1

