Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D799374B3AE
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 17:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjGGPHf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 11:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbjGGPHd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 11:07:33 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00092210A;
        Fri,  7 Jul 2023 08:07:31 -0700 (PDT)
X-QQ-mid: bizesmtp90t1688742437tcr8anue
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 07 Jul 2023 23:07:15 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: mRz6/7wsmIg+4CzfesqpnlhD9XXjDu45isJCglf5hPCGD0jR5QLXdzjRlVIQ6
        mmO6/WeU/h56+WwaqGBPYOWFEc03dMive8tkSFGo2uxhES+B9CjOOsEhcE2pm2tY4S7XXgx
        KPEaV+tS3ZY9PhO+3cnptxVVAUVvYyqXhMMkuyz2BhX5oVg9mGBm47uw9hyskv+N3FA+SBD
        uG4zoMJdLVJmaGMdPBTXDzLCa3Mkn26Y0pWBYeUUJRJXnc/gVcI12s9A9VxyEeanAfwO/qp
        zdHFwTe+Hz/74ftL/dLu1jF8T0e1MB9uPDRgfvzfwEgTYME2ad3zS6KJ5nSPzVOOAlyQFm1
        P8Voz8E8sHZJbgQwFA0JqWED7G59t0HcpmvyivohPpIt1rnSgx7CB9PAtd31Q==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7592088167357566417
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, thomas@t-8ch.de
Subject: [PATCH v6 14/15] selftests/nolibc: add munmap_bad test case
Date:   Fri,  7 Jul 2023 23:07:13 +0800
Message-Id: <f8e3ef34125baea1503ea037da09d5105b964be8.1688739493.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688739492.git.falcon@tinylab.org>
References: <cover.1688739492.git.falcon@tinylab.org>
MIME-Version: 1.0
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

The addr argument of munmap() must be a multiple of the page size,
passing invalid (void *)1 addr expects failure with -EINVAL.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 4026772ed4c5..8644e415cb66 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -670,6 +670,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(lseek_0);           EXPECT_SYSER(1, lseek(0, 0, SEEK_SET), -1, ESPIPE); break;
 		CASE_TEST(mkdir_root);        EXPECT_SYSER(1, mkdir("/", 0755), -1, EEXIST); break;
 		CASE_TEST(mmap_bad);          EXPECT_PTRER(1, mmap(NULL, 0, PROT_READ, MAP_PRIVATE, 0, 0), MAP_FAILED, EINVAL); break;
+		CASE_TEST(munmap_bad);        EXPECT_SYSER(1, munmap((void *)1, 0), -1, EINVAL); break;
 		CASE_TEST(open_tty);          EXPECT_SYSNE(1, tmp = open("/dev/null", 0), -1); if (tmp != -1) close(tmp); break;
 		CASE_TEST(open_blah);         EXPECT_SYSER(1, tmp = open("/proc/self/blah", 0), -1, ENOENT); if (tmp != -1) close(tmp); break;
 		CASE_TEST(poll_null);         EXPECT_SYSZR(1, poll(NULL, 0, 0)); break;
-- 
2.25.1

