Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBCD71553D
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 08:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjE3GDo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 02:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjE3GDn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 02:03:43 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A5CB0;
        Mon, 29 May 2023 23:03:40 -0700 (PDT)
X-QQ-mid: bizesmtp64t1685426616t6i79jvf
Received: from linux-lab-host.localdomain ( [119.123.130.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 May 2023 14:03:35 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: LE7C6P2vL8TLgV2F0j76Wmms1UUKWbcxXK9RaWGqVHLu+pFIx8EiGjOM3wKRQ
        shwmo4Gsz/AGl71NVfCsxNc9+rc1p5oBNfN5GR3fWjMEDOmo6xVBlAVn/SYsc2yh2+yerBH
        N1F+4j+osjG2kC6gH2jgmO23OHID/6V/1DOg1IwkABmVrjIvDSaanYtJ/Ufbh1R2T3BhLPp
        zAPh/5PWc/Fh6VuzY6EXSGWzny2EbjFwOKfSCZL3WNtdbOFEFpsVZjUDBh6hJ93TBf84GWj
        Xvf677gSaPEbQa7rfxPWAz8rjlfS1yf5PvS9yuKKjvNQ6mrmV/kt8DWbGZ25MPM3gWwXhxc
        +uoslweEIgUDWS5SdNHRBO6cE/lFnHPGY/pKdlIlHeMuXkGxc7JFxnExV+FbQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1020271105133103119
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/nolibc: test_fork: fix up duplicated print
Date:   Tue, 30 May 2023 14:03:33 +0800
Message-Id: <61bdfe7bacebdef8aa9195f6f2550a5b0d33aab3.1685426545.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 7de46305f419..88323a60aa4a 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -486,7 +486,13 @@ static int test_getpagesize(void)
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

