Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65275613D49
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Oct 2022 19:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiJaS0M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Oct 2022 14:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiJaS0L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Oct 2022 14:26:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C4813D51;
        Mon, 31 Oct 2022 11:26:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41BB3B815FB;
        Mon, 31 Oct 2022 18:26:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E6AC433D7;
        Mon, 31 Oct 2022 18:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667240764;
        bh=9HGMZvb82sypIRoPvUis/kF/0CFkMhQKBGHkFijQToc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gT3GFkLLYhjvWGz4OnEzIQ5xNeOb0lzsOAgIYeEe7IjZwKsqzCokjPYnlWESuDvXl
         2qG2q7qyueHS+IPqYNIEkESAg6fXUCs9M3QgBkGE7KR0s8K4k+s9mqzhQ9NkZGAxas
         LQgPVn8K+JQJr614faMtd5JgZj7JWOAtQmNNV1dtfnjGXPMJ4RiWpXeNvpz58csDg0
         4AIUFwxdOW6MGu4NJVnN13Zzjb9XaB089VAq0MOxHaLzf9Tfr7ZeD64HPgQizuf6uv
         zqSsF0FAzGME9XV5BG3uOVx5b15/VwkaauVO94yF9rEpLEX+rk9Pz8Rd+iq2usdmDw
         09fAQmbBMDi6Q==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shuah Khan <shuah@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 2/2] selftests/damon: test non-context inputs to rm_contexts file
Date:   Mon, 31 Oct 2022 18:25:54 +0000
Message-Id: <20221031182554.7882-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031182554.7882-1-sj@kernel.org>
References: <20221031182554.7882-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There was a bug[1] that triggered by writing non-context DAMON debugfs
file names to the 'rm_contexts' DAMON debugfs file.  Add a selftest for
the bug to avoid it happen again.

[1] https://lore.kernel.org/damon/000000000000ede3ac05ec4abf8e@google.com/

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/Makefile        |  1 +
 .../damon/debugfs_rm_non_contexts.sh          | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100755 tools/testing/selftests/damon/debugfs_rm_non_contexts.sh

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index af490acc5348..838a8e49f77b 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -7,6 +7,7 @@ TEST_FILES = _chk_dependency.sh _debugfs_common.sh
 TEST_PROGS = debugfs_attrs.sh debugfs_schemes.sh debugfs_target_ids.sh
 TEST_PROGS += debugfs_empty_targets.sh debugfs_huge_count_read_write.sh
 TEST_PROGS += debugfs_duplicate_context_creation.sh
+TEST_PROGS += debugfs_rm_non_contexts.sh
 TEST_PROGS += sysfs.sh
 TEST_PROGS += reclaim.sh lru_sort.sh
 
diff --git a/tools/testing/selftests/damon/debugfs_rm_non_contexts.sh b/tools/testing/selftests/damon/debugfs_rm_non_contexts.sh
new file mode 100755
index 000000000000..48b7af6b022c
--- /dev/null
+++ b/tools/testing/selftests/damon/debugfs_rm_non_contexts.sh
@@ -0,0 +1,19 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source _debugfs_common.sh
+
+# Test putting non-ctx files/dirs to rm_contexts file
+# ===================================================
+
+dmesg -C
+
+for file in "$DBGFS/"*
+do
+	echo "$(basename "$f")" > "$DBGFS/rm_contexts"
+	if dmesg | grep -q BUG
+	then
+		dmesg
+		exit 1
+	fi
+done
-- 
2.25.1

