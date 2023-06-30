Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D558743E25
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 17:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjF3PBI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Jun 2023 11:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjF3PBH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Jun 2023 11:01:07 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDF91FF2;
        Fri, 30 Jun 2023 08:01:05 -0700 (PDT)
X-QQ-mid: bizesmtp84t1688137255t2mep54u
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Jun 2023 23:00:54 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: kN2ypXZVqgzWddNeqgphAHxZz9TLgQL4byjbxUc7gzCYE0taS5aYTkz+R184h
        INKYNRLRzmcQCBMr/Z6JGhxrpqO2iyD4O6lQ1aeMXLMDyEdMt3zFBul6o/oO9nBXyhwGSL2
        aC9W0vRwckYxPNBTnyy38DabjTNQyXVqeaKE/XCFVmFY4lTKLfeDzGlRFVBGRp8Tx2Xve0S
        vJGd49DqhqPa8K/0mJYTkCQpFufxxbD6ILKhqYpNmpWp3V1rkkR88y0dW4mDJ2lFpmdEDZo
        zEtyxyBvk2uHjDpz/T6A4GDvNynBnqId0fc0WE2IsG/yp+5NCKvxhRz/fIcnUFlaZIt6l77
        S4brYv5NuyAUKun4HWdS4LDQxxbt6FXGBo+NsHv6z7z/TPKHZEh9n+1aMsGQYLyyh977AfH
        WUrfaZPzOQQ=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 323981673361064231
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v3 14/14] selftests/nolibc: vfprintf: remove MEMFD_CREATE dependency
Date:   Fri, 30 Jun 2023 23:00:35 +0800
Message-Id: <10d0316283b1467a9604d2b170f83e0a50483b48.1688134400.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688134399.git.falcon@tinylab.org>
References: <cover.1688134399.git.falcon@tinylab.org>
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
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index be2a18cd5bd5..714252518595 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -868,10 +868,10 @@ static int expect_vfprintf(int llen, size_t c, const char *expected, const char
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

