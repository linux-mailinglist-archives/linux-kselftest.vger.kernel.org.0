Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC5C5B40B5
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 22:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiIIUaV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Sep 2022 16:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiIIU34 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Sep 2022 16:29:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DBD12B37E;
        Fri,  9 Sep 2022 13:29:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41749B8263D;
        Fri,  9 Sep 2022 20:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0CDC433D7;
        Fri,  9 Sep 2022 20:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662755345;
        bh=hZYNe4incADQflac8QuxFEY25e1dLUMw1HCGMf1nJPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HVd46DjfyD5K6T5dIhqM++JmCaEKjX2kucCKjE5XWfr29DaoDkrwaAQaQKKt+eUtY
         bq//B5BzvLiLtyLZGF5vHQgZiExTcIhRv58oQgZC2yRQs1OcumuX42jf1i5z8+QRUt
         ekSTZdZnTDrgbjkROJ/FB2TMCCcltd7gnqK30X4xrW5tgUu3wJAMaIBCpPGgutdulR
         SnJUHsMB2E42d/TEFyxDks146Swk7bfDgYxvTZs5WUvkZTLce3SMWVaVBCKy2IovSn
         xL+4MKKQrzpSFuWuSgWC3DQXNxKUOgLwQRLQVKB8T8PCwnK2g1KwrrYZxrX5PDYsxX
         4TZR0hmKuiW7Q==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 1/7] selftest/damon: add a test for duplicate context dirs creation
Date:   Fri,  9 Sep 2022 20:28:55 +0000
Message-Id: <20220909202901.57977-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909202901.57977-1-sj@kernel.org>
References: <20220909202901.57977-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit d26f60703606 ("mm/damon/dbgfs: avoid duplicate context directory
creation") fixes a bug which could result in memory leak and DAMON
disablement.  This commit adds a selftest for verifying the fix and
avoid regression.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/Makefile        |  1 +
 .../debugfs_duplicate_context_creation.sh     | 27 +++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 tools/testing/selftests/damon/debugfs_duplicate_context_creation.sh

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index 0470c5f3e690..a1fa2eff8192 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -6,6 +6,7 @@ TEST_GEN_FILES += huge_count_read_write
 TEST_FILES = _chk_dependency.sh _debugfs_common.sh
 TEST_PROGS = debugfs_attrs.sh debugfs_schemes.sh debugfs_target_ids.sh
 TEST_PROGS += debugfs_empty_targets.sh debugfs_huge_count_read_write.sh
+TEST_PROGS += debugfs_duplicate_context_creation.sh
 TEST_PROGS += sysfs.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/damon/debugfs_duplicate_context_creation.sh b/tools/testing/selftests/damon/debugfs_duplicate_context_creation.sh
new file mode 100644
index 000000000000..4a76e37ef16b
--- /dev/null
+++ b/tools/testing/selftests/damon/debugfs_duplicate_context_creation.sh
@@ -0,0 +1,27 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source _debugfs_common.sh
+
+# Test duplicated context creation
+# ================================
+
+if ! echo foo > "$DBGFS/mk_contexts"
+then
+	echo "context creation failed"
+	exit 1
+fi
+
+if echo foo > "$DBGFS/mk_contexts"
+then
+	echo "duplicate context creation success"
+	exit 1
+fi
+
+if ! echo foo > "$DBGFS/rm_contexts"
+then
+	echo "context deletion failed"
+	exit 1
+fi
+
+exit 0
-- 
2.25.1

