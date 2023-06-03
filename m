Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C8E720EB4
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 10:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjFCIRy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 3 Jun 2023 04:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjFCIRx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 3 Jun 2023 04:17:53 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE5AE56;
        Sat,  3 Jun 2023 01:17:50 -0700 (PDT)
X-QQ-mid: bizesmtp77t1685780261tx6oj29b
Received: from linux-lab-host.localdomain ( [119.123.130.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 03 Jun 2023 16:17:40 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: E5K4RXiq5f16O7Lg/ibaIwDGJ/dBM+SgASgVWJNrZJ0DycLMa61F85p3zn/s0
        pmVP+uUxVO+uRq/qEVaGBrw6dy5nIj47egVC3sA8D6LyXOmfE2qgnjJAplThr2LHojLED11
        dN48gvX6BDj+6ZskNGLKC05GNgBi/1WsGLb1E+3d17NhlPgK0/LzJRM0pb94DuYlP0Nmb59
        w/YBaNODEaG8SfvzKEIj3lR1qDDwBvXpe5afs1A1FBfiTrIN0OgVeJJbKuaREYCdlovpmwR
        TbYhxWH70C7N9rrtU2bVFSPPjUczDufHPnteLBOjhwo549unG3iUV5HoN68eGMNqiD9QnOE
        Mbf4IaVts3z35QJQ2XUbnjfxanJ+JTJpIGiU/3+zwyVM15wQhyWDL98jOVCeDUWXeWyrFpD
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11015261677064545706
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v3 12/12] selftests/nolibc: test_fork: fix up duplicated print
Date:   Sat,  3 Jun 2023 16:17:25 +0800
Message-Id: <4e090aff64abeca598d1bb6ee54b40ee4ce52858.1685777982.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685777982.git.falcon@tinylab.org>
References: <cover.1685777982.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

running nolibc-test with glibc on x86_64 got such print issue:

    29 execve_root = -1 EACCES                                       [OK]
    30 fork30 fork = 0                                                      [OK]
    31 getdents64_root = 712                                         [OK]

The fork test case has three printf calls:

    (1) llen += printf("%d %s", test, #name);
    (2) llen += printf(" = %d %s ", expr, errorname(errno));
    (3) llen += pad_spc(llen, 64, "[FAIL]\n"); --> vfprintf()

In the following scene, the above issue happens:

    (a) The parent calls (1)
    (b) The parent calls fork()
    (c) The child runs and shares the print buffer of (1)
    (d) The child exits, flushs the print buffer and closes its own stdout/stderr
        * "30 fork" is printed at the first time.
    (e) The parent calls (2) and (3), with "\n" in (3), it flushs the whole buffer
        * "30 fork = 0 ..." is printed

Therefore, there are two "30 fork" in the stdout.

Between (a) and (b), if flush the stdout (and the sterr), the child in
stage (c) will not be able to 'see' the print buffer.

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index e68c5692ec54..7dd950879161 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -490,7 +490,13 @@ static int test_getpagesize(void)
 static int test_fork(void)
 {
 	int status;
-	pid_t pid = fork();
+	pid_t pid;
+
+	/* flush the printf buffer to avoid child flush it */
+	fflush(stdout);
+	fflush(stderr);
+
+	pid = fork();
 
 	switch (pid) {
 	case -1:
-- 
2.25.1

