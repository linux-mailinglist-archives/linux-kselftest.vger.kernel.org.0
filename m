Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F4F743173
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 02:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjF3AGS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 20:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjF3AGR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 20:06:17 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724C3199B;
        Thu, 29 Jun 2023 17:06:15 -0700 (PDT)
X-QQ-mid: bizesmtp71t1688083565twklsj26
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Jun 2023 08:06:04 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: RFp2QSjOiS7beTcSYXt1iawYE5VBFE+qfrFikOGIrZGU78FGQ//+XBNHlkTeb
        TF9bjq4tqANTGj/eXrmZuqrAjBtKHg7Qp+Y5VIjCUePqDup95utpa2bac+We01QQ5iHPhta
        /zN6i6ZKv9IPOPTajq6hPE+XEVU+Lc/QRz7szyfrDSQ+kksByTKk20N1o8F2uxrCJJgmE8O
        5hVrAJvv3KqNUx9SLoQ8ngwmbNGFK5DTN0cZ+Pps0q5ox1rTJREprqRx/RBPItazmUbDH6I
        DiikY/83T+T6cmW/kAnmW8Lt1Q+wE8q+79BlUAdoStWwD1jLD+RDCQ49SpArKwT3WIn1hz4
        1yCFJtTzqJcQzfMvymdKAYqjfJxUixP6hjv/1KgL7SqVmysltewh2BBbP4TtbvBUY+HKAA3
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 527216731131771503
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 15/15] selftests/nolibc: vfprintf: remove MEMFD_CREATE dependency
Date:   Fri, 30 Jun 2023 08:03:14 +0800
Message-Id: <2438cf7e4ecb2444a79f838437c149dd7d5bdde6.1688078605.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688078604.git.falcon@tinylab.org>
References: <cover.1688078604.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The vfprintf test case require to open a temporary file to write, the
old memfd_create() method is perfect but has strong dependency on
MEMFD_CREATE and also TMPFS or HUGETLBFS (see fs/Kconfig):

    config MEMFD_CREATE
	def_bool TMPFS || HUGETLBFS

And from v6.2, MFD_NOEXEC_SEAL must be passed for the non-executable
memfd, otherwise, The kernel warning will be output to the test result
like this:

        Running test 'vfprintf'
        0 emptymemfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=1 'init'
         "" = ""                                                  [OK]

To avoid such warning and also to remove the MEMFD_CREATE dependency,
let's open a file from tmpfs directly.

The /tmp directory is used to detect the existing of tmpfs, if not
there, skip instead of fail.

And further, for pid == 1, the initramfs is loaded as ramfs, which can
be used as tmpfs, so, it is able to further remove TMPFS dependency too.

Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/lkml/9ad51430-b7c0-47dc-80af-20c86539498d@t-8ch.de
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 0ca7d011765a..0847813d756c 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -888,10 +888,10 @@ static int expect_vfprintf(int llen, size_t c, const char *expected, const char
 	FILE *memfile;
 	va_list args;
 
-	fd = memfd_create("vfprintf", 0);
+	fd = open("/tmp", O_TMPFILE | O_EXCL | O_RDWR, 0600);
 	if (fd == -1) {
-		pad_spc(llen, 64, "[FAIL]\n");
-		return 1;
+		pad_spc(llen, 64, "[SKIPPED]\n");
+		return 0;
 	}
 
 	memfile = fdopen(fd, "w+");
-- 
2.25.1

