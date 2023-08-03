Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC8576E169
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 09:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjHCH3F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 03:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjHCH2y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 03:28:54 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74CC30DA;
        Thu,  3 Aug 2023 00:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1691047729;
        bh=Bsog0Mf6TrXFPK5NCHSwt3Qj4UKD19LdkghQ5BZEmxg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=LXyQLw5NM/Oe9Xu12DPpC769c6UF3r50FEMf0cdoLRblw0DhqzHGWRuHqi3XK50w+
         2EmfvwP97/YzHoyvAFDei/E+3a9ApLZFVH3gAySn//QBID7aVm/psgrO3qUXZAbwLj
         +M7+XGO9B+GjsjPLXmAUgDGYzxpioi81vJXcPDu8=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Thu, 03 Aug 2023 09:28:52 +0200
Subject: [PATCH v3 08/14] selftests/nolibc: make functions static if
 possible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230803-nolibc-warnings-v3-8-bcc1a096ae02@weissschuh.net>
References: <20230803-nolibc-warnings-v3-0-bcc1a096ae02@weissschuh.net>
In-Reply-To: <20230803-nolibc-warnings-v3-0-bcc1a096ae02@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691047727; l=1835;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Bsog0Mf6TrXFPK5NCHSwt3Qj4UKD19LdkghQ5BZEmxg=;
 b=6bN7cO3nPs3BnEWlMB22XPWZvlNXbV6YYCr1ADIkFpYMKeskTrlYAiPgsG0Hvx83/fMhS4PFA
 8/f1DrEBKcmDIFpU5gdml9rFlW+ibQ4LzIZOimZdANh+Mu98XuXkHSq
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This allows the compiler to generate warnings if they go unused.

Functions that are supposed to be used as breakpoints should not be
static, so un-statify those if necessary.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 154ec4787e8d..ea420c794536 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -80,7 +80,7 @@ char *itoa(int i)
 /* returns the error name (e.g. "ENOENT") for common errors, "SUCCESS" for 0,
  * or the decimal value for less common ones.
  */
-const char *errorname(int err)
+static const char *errorname(int err)
 {
 	switch (err) {
 	case 0: return "SUCCESS";
@@ -659,7 +659,7 @@ int test_getdents64(const char *dir)
 	return ret;
 }
 
-static int test_getpagesize(void)
+int test_getpagesize(void)
 {
 	int x = getpagesize();
 	int c;
@@ -688,7 +688,7 @@ static int test_getpagesize(void)
 	return !c;
 }
 
-static int test_fork(void)
+int test_fork(void)
 {
 	int status;
 	pid_t pid;
@@ -713,7 +713,7 @@ static int test_fork(void)
 	}
 }
 
-static int test_stat_timestamps(void)
+int test_stat_timestamps(void)
 {
 	struct stat st;
 
@@ -793,7 +793,7 @@ int test_mmap_munmap(void)
 	return !!ret;
 }
 
-static int test_pipe(void)
+int test_pipe(void)
 {
 	const char *const msg = "hello, nolibc";
 	int pipefd[2];
@@ -1231,7 +1231,7 @@ static const struct test test_names[] = {
 	{ 0 }
 };
 
-int is_setting_valid(char *test)
+static int is_setting_valid(char *test)
 {
 	int idx, len, test_len, valid = 0;
 	char delimiter;

-- 
2.41.0

