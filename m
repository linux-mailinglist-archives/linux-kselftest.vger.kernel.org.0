Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A184768B64
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 07:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjGaFv3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 01:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjGaFvX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 01:51:23 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61781730;
        Sun, 30 Jul 2023 22:51:11 -0700 (PDT)
X-QQ-mid: bizesmtp75t1690782665t6sax2el
Received: from dslab-main2-ubuntu.tail147f4.ts ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 31 Jul 2023 13:51:03 +0800 (CST)
X-QQ-SSF: 01200000000000704000000A0000000
X-QQ-FEAT: jXjag1m6xl4TUwwOcxAHuSNvjezdnyUkeJyXtjE6BB1LN2sUyINMeltLYijKJ
        UMECH7SIllnAtxMSpIe2wh4MC38HJh6Vjamnwx6HerLMhs4ijK/ySftTd6SmXUXtSgBI6zF
        fdgepgMm9EFt3L9YSC/bFVrBnGow+n8WogQzdxwoXciLOZSmjVtdtnUWdmd3l4n9cOKh7s9
        FitwrNZKDEevJn3RWFS4ficqy+A4GOlYHO3dvlEZkBA+p5n13KQF6lTPIIF6EMZDy+nWUNi
        PoJzti3ZCeUjBV0P90IyLi0sDKCraQ/Hzwrd2oFMoiZ78XlgKImyNU8Ac8D0eeCwTXCiniw
        JLazDYb9coRHXrMul12RLTJ7BMefgZSoqRYPt9kHjU+giphf34TNGRv9foQPw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9840545900577853987
From:   Yuan Tan <tanyuan@tinylab.org>
To:     w@1wt.eu, thomas@t-8ch.de
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Yuan Tan <tanyuan@tinylab.org>
Subject: [PATCH v2 2/2] selftests/nolibc: add testcase for pipe
Date:   Mon, 31 Jul 2023 13:51:00 +0800
Message-Id: <9221753abe0509ef5cbb474a31873012e0e40706.1690733545.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1690733545.git.tanyuan@tinylab.org>
References: <cover.1690733545.git.tanyuan@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a testcase of pipe that child process sends message to parent
process.

Here we use memcmp() to avoid the output buffer issue.

Suggested-by: Thomas Weißschuh <thomas@t-8ch.de>
Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/all/c5de2d13-3752-4e1b-90d9-f58cca99c702@t-8ch.de/
Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 35 ++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 03b1d30f5507..2653ab8d5124 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -767,6 +767,41 @@ int test_mmap_munmap(void)
 	return ret;
 }
 
+int test_pipe(void)
+{
+	const char *const msg = "hello, nolibc";
+	int pipefd[2];
+	char buf[32];
+	pid_t pid;
+	ssize_t len;
+
+	if (pipe(pipefd) == -1)
+		return 1;
+
+	pid = fork();
+
+	switch (pid) {
+	case -1:
+		return 1;
+
+	case 0:
+		close(pipefd[0]);
+		write(pipefd[1], msg, strlen(msg));
+		close(pipefd[1]);
+		exit(EXIT_SUCCESS);
+
+	default:
+		close(pipefd[1]);
+		len = read(pipefd[0], buf, sizeof(buf));
+		close(pipefd[0]);
+		waitpid(pid, NULL, 0);
+
+		if (len != strlen(msg))
+			return 1;
+		return !!memcmp(buf, msg, len);
+	}
+}
+
 
 /* Run syscall tests between IDs <min> and <max>.
  * Return 0 on success, non-zero on failure.
-- 
2.34.1

