Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AB374B38C
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 17:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjGGPCt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 11:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjGGPCs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 11:02:48 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F5F210A;
        Fri,  7 Jul 2023 08:02:37 -0700 (PDT)
X-QQ-mid: bizesmtp63t1688742143tn8jl0ih
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 07 Jul 2023 23:02:22 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: hoArX50alxFmsJ0atZjqbzHeVuse8MtD4x3pgHfFnxe1hIjs3zsPJJljILwPP
        cZOCtJq2GFFmaWMlBnT7xIijoHajHOWxCVCyUgsrmQJI4aJwBx1j1G0/nT9v816H4crLevD
        b2wqhPOTx2jJXGPA0XEf1e4cXnpNe+Ho6HRdAYwOKiwGrv3+FsrXaYQXFnirspceOYnrj5d
        2gD2Mwc5hrF7Tk82JzkwT9vRE8qLrIbfJAFlgLQxBAVjmuqj1HFPF+meU0LnlvFzYUHVQsU
        ALHr5zeDk8O8oofQT+qDeXFlCZuVx8tWjuBG0NsEHzSMmIGDxTHm1aGJR5nGRksKAQw62x2
        856wxltVV+JT2VWIZNTh1T+Ecuwb/jyN6hRoodt577DibVw0p0ypooL8P7v34K9lg6uY0Ni
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7535638931028319636
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, thomas@t-8ch.de
Subject: [PATCH v6 10/15] selftests/nolibc: prepare: create /dev/zero
Date:   Fri,  7 Jul 2023 23:02:16 +0800
Message-Id: <589b6a374e604b6289eb00890cd63e2b7d2ce86f.1688739492.git.falcon@tinylab.org>
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

/dev/zero is commonly used to allocate anonymous memory, it is a very
good file for tests, let's prepare it.

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/lkml/20230702193306.GK16233@1wt.eu/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 88b840f86f52..b759fb25d375 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -894,11 +894,13 @@ int prepare(void)
 	 */
 	if (stat("/dev/.", &stat_buf) == 0 || mkdir("/dev", 0755) == 0) {
 		if (stat("/dev/console", &stat_buf) != 0 ||
-		    stat("/dev/null", &stat_buf) != 0) {
+		    stat("/dev/null", &stat_buf) != 0 ||
+		    stat("/dev/zero", &stat_buf) != 0) {
 			/* try devtmpfs first, otherwise fall back to manual creation */
 			if (mount("/dev", "/dev", "devtmpfs", 0, 0) != 0) {
 				mknod("/dev/console", 0600 | S_IFCHR, makedev(5, 1));
 				mknod("/dev/null",    0666 | S_IFCHR, makedev(1, 3));
+				mknod("/dev/zero",    0666 | S_IFCHR, makedev(1, 5));
 			}
 		}
 	}
-- 
2.25.1

