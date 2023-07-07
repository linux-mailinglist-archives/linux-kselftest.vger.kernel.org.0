Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F43F74B632
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 20:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjGGSYV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 14:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjGGSYU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 14:24:20 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DFD2126;
        Fri,  7 Jul 2023 11:24:18 -0700 (PDT)
X-QQ-mid: bizesmtp82t1688754249t623xsi4
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 08 Jul 2023 02:24:07 +0800 (CST)
X-QQ-SSF: 00200000000000D0W000000A0000000
X-QQ-FEAT: 3+QwQJFiZ1m2Ploce0hyNTg1J83yb786TJK2GyCTBRIg7tzl3nHVtx+YUkoDw
        wUqgOD9XgSC9h8wF341Dd5ODgw8WdqB5CmFg2clJVnxtyVpKabaxf7uHI1fz7gKRZ9CaGuR
        92mUPSY4EqdGtr+Zkgr3eNmHU1woh0EcRMad5poTkOVBaLPNxwb4guaZ9u6Yna0QmhT+vEA
        5hJ9RpbORV0m5lK2XkqMf06LiuKws1gcCfS/TAI68wy7bVOivdy3RP1vTEgV0IGAGfG7XDv
        hU1Ebppi/WE2kSzDuzNYIFXrNQjI09JXU4/Id2uwsYL9NKXCYfHJMj9vDRblNup0tIkB3wu
        bfVRx2vnKhWpjNqimF0tqXHsJh6uJni2Ju4apqVlfql8m4fOP8=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1607707009084266309
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v4 02/18] selftests/nolibc: stat_fault: silence NULL argument warning with glibc
Date:   Sat,  8 Jul 2023 02:23:45 +0800
Message-Id: <b64b6d59107661500755c683c98245b1dfcd8b3d.1688750763.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688750763.git.falcon@tinylab.org>
References: <cover.1688750763.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use another invalid address (void *)1 instead of NULL to silence this
compile warning with glibc:

    $ make libc-test
      CC      libc-test
    nolibc-test.c: In function ‘run_syscall’:
    nolibc-test.c:622:49: warning: null argument where non-null required (argument 1) [-Wnonnull]
      622 |   CASE_TEST(stat_fault);        EXPECT_SYSER(1, stat(NULL, &stat_buf), -1, EFAULT); break;
          |                                                 ^~~~
    nolibc-test.c:304:79: note: in definition of macro ‘EXPECT_SYSER2’
      304 |  do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_syserr2(expr, expret, experr1, experr2, llen); } while (0)
          |                                                                               ^~~~
    nolibc-test.c:622:33: note: in expansion of macro ‘EXPECT_SYSER’
      622 |   CASE_TEST(stat_fault);        EXPECT_SYSER(1, stat(NULL, &stat_buf), -1, EFAULT); break;

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 06c561c4b09d..b4b64125d418 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -742,7 +742,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(select_stdout);     EXPECT_SYSNE(1, ({ fd_set fds; FD_ZERO(&fds); FD_SET(1, &fds); select(2, NULL, &fds, NULL, NULL); }), -1); break;
 		CASE_TEST(select_fault);      EXPECT_SYSER(1, select(1, (void *)1, NULL, NULL, 0), -1, EFAULT); break;
 		CASE_TEST(stat_blah);         EXPECT_SYSER(1, stat("/proc/self/blah", &stat_buf), -1, ENOENT); break;
-		CASE_TEST(stat_fault);        EXPECT_SYSER(1, stat(NULL, &stat_buf), -1, EFAULT); break;
+		CASE_TEST(stat_fault);        EXPECT_SYSER(1, stat((void *)1, &stat_buf), -1, EFAULT); break;
 		CASE_TEST(stat_timestamps);   EXPECT_SYSZR(1, test_stat_timestamps()); break;
 		CASE_TEST(symlink_root);      EXPECT_SYSER(1, symlink("/", "/"), -1, EEXIST); break;
 		CASE_TEST(unlink_root);       EXPECT_SYSER(1, unlink("/"), -1, EISDIR); break;
-- 
2.25.1

