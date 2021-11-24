Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78DA45BA42
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Nov 2021 13:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242375AbhKXMJS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Nov 2021 07:09:18 -0500
Received: from mail.jv-coder.de ([5.9.79.73]:46308 "EHLO mail.jv-coder.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241539AbhKXMHi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Nov 2021 07:07:38 -0500
X-Greylist: delayed 315 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Nov 2021 07:07:37 EST
Received: from ubuntu.localdomain (unknown [188.192.64.76])
        by mail.jv-coder.de (Postfix) with ESMTPSA id 11B609FBCD;
        Wed, 24 Nov 2021 11:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
        t=1637755151; bh=nk79e0vtWG5vI5W6jbeeDTH7jdjOKA8eHaJw9BLhy7c=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=l8HJP1PqqOeL13co0fnbRlmAPGiHa6lvpIGR6E08xuWA7JOF18LP7zL2WTsxitsxt
         ScjzbANczh/TBR+PkHbf8GYmzgMRpFIti7v2Yx7EK3nX+HaFfeu9wYBr9FxY+Ti1fc
         EO92CSi7LyVVah54D6f5NtSlvMhmXpBUNBf0/4lY=
From:   Joerg Vehlow <lkml@jv-coder.de>
To:     linux-kselftest@vger.kernel.org, keescook@chromium.org,
        shuah@kernel.org
Cc:     Joerg Vehlow <joerg.vehlow@aox-tech.de>
Subject: [PATCH] selftests/exec: Fix build
Date:   Wed, 24 Nov 2021 12:59:03 +0100
Message-Id: <20211124115903.1197830-1-lkml@jv-coder.de>
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

This fixes
make: *** No rule to make target 'tools/testing/selftests/exec/pipe', needed by 'all'. Stop.

Targets defined in TEST_DEN_FILES must exist as targets in the makefile,
but pipe is only created by the test at runtime, so it should be cleaned only.

Fixes: 61016db15b8e ("selftests/exec: Verify execve of non-regular files fail")
Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 tools/testing/selftests/exec/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index dd61118df66e..ac8acca7a942 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -5,14 +5,14 @@ CFLAGS += -D_GNU_SOURCE
 
 TEST_PROGS := binfmt_script non-regular
 TEST_GEN_PROGS := execveat load_address_4096 load_address_2097152 load_address_16777216
-TEST_GEN_FILES := execveat.symlink execveat.denatured script subdir pipe
+TEST_GEN_FILES := execveat.symlink execveat.denatured script subdir
 # Makefile is a run-time dependency, since it's accessed by the execveat test
 TEST_FILES := Makefile
 
 TEST_GEN_PROGS += recursion-depth
 
 EXTRA_CLEAN := $(OUTPUT)/subdir.moved $(OUTPUT)/execveat.moved $(OUTPUT)/xxxxx*	\
-	       $(OUTPUT)/S_I*.test
+	       $(OUTPUT)/S_I*.test $(OUTPUT)/pipe
 
 include ../lib.mk
 
-- 
2.25.1

