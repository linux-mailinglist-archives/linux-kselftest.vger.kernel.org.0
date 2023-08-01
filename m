Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DC376B8D6
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 17:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjHAPko (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 11:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjHAPkm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 11:40:42 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C058C18B;
        Tue,  1 Aug 2023 08:40:32 -0700 (PDT)
X-QQ-mid: bizesmtp66t1690904426thfpaxec
Received: from dslab-main2-ubuntu.tail147f4.ts ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 01 Aug 2023 23:40:25 +0800 (CST)
X-QQ-SSF: 01200000000000705000000A0000000
X-QQ-FEAT: kN2ypXZVqgwk/qBTNkd/iwlu662yQb25L197c9fZh4f02d1PhBEH9w+ZHw7Rb
        DlkUdXFYyspKmDSuSJXiIMbzbjgNRqkjqijFmGNyFtwdsRFrG3oMJnQ3J/4XtKc7ShV2PFG
        ek1MKLByFcQbrt2zsxytHpsxf5xa1Mh6V9Qi9uAsdEe+9DjTp8LxeiGbEN4fHAUQsvn4rAh
        NNFDpDG8gVDnEmmNOadR+qCTMNf5yOmt9dZ4LJTR27ApvzJ4uD+M32A451Sft4YN76apPBu
        vixRcPOdbDHBHVCwLXMuPi04EZOue08fwYz28/EdyooUDGcLljWKfoPUqMlumGAeFHTt8yv
        QhhuSvEqMsfTJo1HmVLY8qxjQEBjBlQ1WS9Hhyh/iL4x6rNwzyB6ty1JVK3MQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5494693937254520093
From:   Yuan Tan <tanyuan@tinylab.org>
To:     w@1wt.eu, thomas@t-8ch.de
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Yuan Tan <tanyuan@tinylab.org>
Subject: [PATCH v3 2/2] selftests/nolibc: add testcase for pipe
Date:   Tue,  1 Aug 2023 23:40:23 +0800
Message-Id: <508ed252b8f60494d70cd211debbb297ee916325.1690903601.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1690903601.git.tanyuan@tinylab.org>
References: <cover.1690903601.git.tanyuan@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a test case of pipe that sends and receives message in a single
process.

Suggested-by: Thomas Weißschuh <thomas@t-8ch.de>
Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/all/c5de2d13-3752-4e1b-90d9-f58cca99c702@t-8ch.de/
Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 22 ++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 03b1d30f5507..e5667fa3cf0a 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -767,6 +767,27 @@ int test_mmap_munmap(void)
 	return ret;
 }
 
+static int test_pipe(void)
+{
+	const char *const msg = "hello, nolibc";
+	int pipefd[2];
+	char buf[32];
+	ssize_t len;
+
+	if (pipe(pipefd) == -1)
+		return 1;
+
+	write(pipefd[1], msg, strlen(msg));
+	close(pipefd[1]);
+	len = read(pipefd[0], buf, sizeof(buf));
+	close(pipefd[0]);
+
+	if (len != strlen(msg))
+		return 1;
+
+	return !!memcmp(buf, msg, len);
+}
+
 
 /* Run syscall tests between IDs <min> and <max>.
  * Return 0 on success, non-zero on failure.
@@ -851,6 +872,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(mmap_munmap_good);  EXPECT_SYSZR(1, test_mmap_munmap()); break;
 		CASE_TEST(open_tty);          EXPECT_SYSNE(1, tmp = open("/dev/null", 0), -1); if (tmp != -1) close(tmp); break;
 		CASE_TEST(open_blah);         EXPECT_SYSER(1, tmp = open("/proc/self/blah", 0), -1, ENOENT); if (tmp != -1) close(tmp); break;
+		CASE_TEST(pipe);              EXPECT_SYSZR(1, test_pipe()); break;
 		CASE_TEST(poll_null);         EXPECT_SYSZR(1, poll(NULL, 0, 0)); break;
 		CASE_TEST(poll_stdout);       EXPECT_SYSNE(1, ({ struct pollfd fds = { 1, POLLOUT, 0}; poll(&fds, 1, 0); }), -1); break;
 		CASE_TEST(poll_fault);        EXPECT_SYSER(1, poll((void *)1, 1, 0), -1, EFAULT); break;
-- 
2.34.1

