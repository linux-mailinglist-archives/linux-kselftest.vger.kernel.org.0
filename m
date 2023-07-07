Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29D474B67E
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 20:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjGGSlK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 14:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjGGSlJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 14:41:09 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2292686;
        Fri,  7 Jul 2023 11:41:06 -0700 (PDT)
X-QQ-mid: bizesmtp89t1688755258tl15jmsd
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 08 Jul 2023 02:40:56 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: pMHwdq3i9JMdscoC4rTMu/NiAUoIRiiFj3qeqqHtFAEulmGT9cGyKGZzstgvB
        EuvAHvEWur986HyyMuCngFP7Y9/35QpomwUGhdan4ddVmrh4/z3FyI1kAT+wbbhQqj1wNmY
        lyFDJoSZrwQdG+YhAVAC/1IhLwK2D7jlHutttbAKCXDDU2q6TUCFm3U2bppd+h5FKYR9H0w
        Zm0ga1G4kQSD8wwF57ei8KmUCLA1jiQTrPCoaQMzWqbKo5CtGWWmUYV3RQCPEvixPWIpfks
        VvW3wrSGK6TShyAzvTg2GVs0EowUSjJxDeYvxeN+801tpi3D3QCQ29gHA3DMHlC1tfeOkXG
        fR0VzH8ZEJaQpOBCcABNTa4fjjUvaZ/U54BV4N16uvPkMMTcrQ2XZH4HmN02JVUA9LCDb2p
        VcOV2RIPInI=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6393069016375536476
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v4 14/18] selftests/nolibc: vfprintf: remove MEMFD_CREATE dependency
Date:   Sat,  8 Jul 2023 02:40:08 +0800
Message-Id: <94bdca8d8610e85bb1683bf10a5005ca92c3cb57.1688750763.git.falcon@tinylab.org>
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
index 6b863f7b677c..494195890e4b 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -875,10 +875,10 @@ static int expect_vfprintf(int llen, size_t c, const char *expected, const char
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

