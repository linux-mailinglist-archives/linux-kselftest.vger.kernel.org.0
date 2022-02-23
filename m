Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E774C168B
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Feb 2022 16:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241940AbiBWPWL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Feb 2022 10:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241885AbiBWPWH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Feb 2022 10:22:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2C511141;
        Wed, 23 Feb 2022 07:21:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6912DB8207C;
        Wed, 23 Feb 2022 15:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44345C340F8;
        Wed, 23 Feb 2022 15:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645629693;
        bh=5yg9/nCZ41ziXpzo6YFkfA3p9CjNAp5ve/V1Y984iqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YZUnKFGfmz8Dm7RSQkftf28cNHZa3uG97m0sRjNM5sG0CDEvHYVWHNWFacOZWdrTE
         k54gVYWz4L1rYtySYV9tryBRE8u3QG2T8KDgMb2xmsiNjE9UAEaPOXM3YtUv4golYf
         Z2tTk1butdX6yoBkItQtuNJ6FcNFeXPPy1WMV7AQl0r7UssXBQD226Fa1QHBYyIyHX
         pug6r/a+gPELGBHGnEqfPlLihCa1dOec4EUhDcE5yU+E4qco6hKYWhhmVPyWxvSYMS
         LPTiIb0l7U5wipJLU7Wc1nM89UQ2mvbk2ps7uSRaSuZj78SAE4lagtCEtz1DiDuth1
         cRbwwWi61VzFg==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, skhan@linuxfoundation.org, rientjes@google.com,
        xhao@linux.alibaba.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 11/12] selftests/damon: Add a test for DAMON sysfs interface
Date:   Wed, 23 Feb 2022 15:20:50 +0000
Message-Id: <20220223152051.22936-12-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220223152051.22936-1-sj@kernel.org>
References: <20220223152051.22936-1-sj@kernel.org>
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
index 000000000000..38a06a2845b5
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
+	ensure_file "$weights_dir/sz" "exist" "600"
+	ensure_file "$weights_dir/nr_accesses" "exist" "600"
+	ensure_file "$weights_dir/age" "exist" "600"
+}
+
+test_quotas()
+{
+	quotas_dir=$1
+	ensure_dir "$quotas_dir" "exist"
+	ensure_file "$quotas_dir/ms" "exist" 600
+	ensure_file "$quotas_dir/sz" "exist" 600
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
+	ensure_file "$schemes_dir/nr" "exist" 600
+
+	ensure_write_succ  "$schemes_dir/nr" "1" "valid input"
+	test_scheme "$schemes_dir/0"
+
+	ensure_write_succ  "$schemes_dir/nr" "2" "valid input"
+	test_scheme "$schemes_dir/0"
+	test_scheme "$schemes_dir/1"
+
+	ensure_write_succ "$schemes_dir/nr" "0" "valid input"
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
+	ensure_file "$regions_dir/nr" "exist" 600
+
+	ensure_write_succ  "$regions_dir/nr" "1" "valid input"
+	test_region "$regions_dir/0"
+
+	ensure_write_succ  "$regions_dir/nr" "2" "valid input"
+	test_region "$regions_dir/0"
+	test_region "$regions_dir/1"
+
+	ensure_write_succ "$regions_dir/nr" "0" "valid input"
+	ensure_dir "$regions_dir/0" "not_exist"
+	ensure_dir "$regions_dir/1" "not_exist"
+}
+
+test_target()
+{
+	target_dir=$1
+	ensure_dir "$target_dir" "exist"
+	ensure_file "$target_dir/pid" "exist" "600"
+	test_regions "$target_dir/regions"
+}
+
+test_targets()
+{
+	targets_dir=$1
+	ensure_dir "$targets_dir" "exist"
+	ensure_file "$targets_dir/nr" "exist" 600
+
+	ensure_write_succ  "$targets_dir/nr" "1" "valid input"
+	test_target "$targets_dir/0"
+
+	ensure_write_succ  "$targets_dir/nr" "2" "valid input"
+	test_target "$targets_dir/0"
+	test_target "$targets_dir/1"
+
+	ensure_write_succ "$targets_dir/nr" "0" "valid input"
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
+	ensure_file "$contexts_dir/nr" "exist" 600
+
+	ensure_write_succ  "$contexts_dir/nr" "1" "valid input"
+	test_context "$contexts_dir/0"
+
+	ensure_write_fail "$contexts_dir/nr" "2" "only 0/1 are supported"
+	test_context "$contexts_dir/0"
+
+	ensure_write_succ "$contexts_dir/nr" "0" "valid input"
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
+	ensure_file "$kdamonds_dir/nr" "exist" "600"
+
+	ensure_write_succ  "$kdamonds_dir/nr" "1" "valid input"
+	test_kdamond "$kdamonds_dir/0"
+
+	ensure_write_succ  "$kdamonds_dir/nr" "2" "valid input"
+	test_kdamond "$kdamonds_dir/0"
+	test_kdamond "$kdamonds_dir/1"
+
+	ensure_write_succ "$kdamonds_dir/nr" "0" "valid input"
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

