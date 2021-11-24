Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D669945BEE2
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Nov 2021 13:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245640AbhKXMvg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Nov 2021 07:51:36 -0500
Received: from mail.jv-coder.de ([5.9.79.73]:48472 "EHLO mail.jv-coder.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243067AbhKXMtt (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Nov 2021 07:49:49 -0500
Received: from ubuntu.localdomain (unknown [188.192.64.76])
        by mail.jv-coder.de (Postfix) with ESMTPSA id 39F509FBCD;
        Wed, 24 Nov 2021 12:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
        t=1637757996; bh=Gde/gmP4ABEEVNfVXLFQW6FUK9g0BKuPOGBVWeJkN6k=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=LFZvUfyFaZEWizJfEXzn+v6cDa6uHpBPJCFY5X7AzU4k0wEvvqRozKFFxHQbajdcJ
         Bfp36PTniTYiB0xaPlGrYh5ogi6BvyMdlGHdBTOWUZDNqWnwM2hzUqLEJx5K8nDOY0
         ZQz3vjFbiuwBe0bT/e38tkYmzbEq/kkSlU1ILcgo=
From:   Joerg Vehlow <lkml@jv-coder.de>
To:     linux-kselftest@vger.kernel.org, keescook@chromium.org,
        shuah@kernel.org
Cc:     Joerg Vehlow <joerg.vehlow@aox-tech.de>
Subject: [PATCH] selftests/exec: Fix build for non-regular
Date:   Wed, 24 Nov 2021 13:46:29 +0100
Message-Id: <20211124124629.1506208-1-lkml@jv-coder.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.5
X-Spam-Checker-Version: SpamAssassin 3.4.5 (2021-03-20) on mail.jv-coder.de
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

The non-regular binary was not built at all and make install failed with
rsync: link_stat "tools/testing/selftests/exec/non-regular" failed: No such file or directory (2)
rsync error: some files/attrs were not transferred (see previous errors) (code 23) at main.c(1207) [sender=3.1.3]

TEST_PROGS should only be used for shell scripts, not for binaries

Fixes: 0f71241a8e32 ("selftests/exec: add file type errno tests")
Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 tools/testing/selftests/exec/.gitignore | 1 +
 tools/testing/selftests/exec/Makefile   | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/exec/.gitignore b/tools/testing/selftests/exec/.gitignore
index 9e2f00343f15..9141262d14c1 100644
--- a/tools/testing/selftests/exec/.gitignore
+++ b/tools/testing/selftests/exec/.gitignore
@@ -12,3 +12,4 @@ execveat.denatured
 xxxxxxxx*
 pipe
 S_I*.test
+non-regular
diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index dd61118df66e..46a12d6bd06f 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -3,8 +3,8 @@ CFLAGS = -Wall
 CFLAGS += -Wno-nonnull
 CFLAGS += -D_GNU_SOURCE
 
-TEST_PROGS := binfmt_script non-regular
-TEST_GEN_PROGS := execveat load_address_4096 load_address_2097152 load_address_16777216
+TEST_PROGS := binfmt_script
+TEST_GEN_PROGS := execveat load_address_4096 load_address_2097152 load_address_16777216 non-regular
 TEST_GEN_FILES := execveat.symlink execveat.denatured script subdir pipe
 # Makefile is a run-time dependency, since it's accessed by the execveat test
 TEST_FILES := Makefile
-- 
2.25.1

