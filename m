Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9B6754AA4
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jul 2023 20:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjGOSXf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Jul 2023 14:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGOSXf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Jul 2023 14:23:35 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0FE26AF;
        Sat, 15 Jul 2023 11:23:33 -0700 (PDT)
X-QQ-mid: bizesmtp74t1689445403tdi2n85s
Received: from linux-lab-host.localdomain ( [119.123.131.162])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 16 Jul 2023 02:23:21 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: aRJAvSRewFZh1UoATmMpA0iwFRanbp2F60/aVC49NkfTvP7x0J/z/gdxkXHge
        vY1xI9vDDBjjW77K2GoiDV40/WdGKKXYBmjWQK2QLuCmNdAX1eF6eSeBtQFDpIlkuCxz676
        WRFG3BSpwpOEi4GyAFAONeMD7YxiGjpvAIynYQKjdH1FDY1LfAzSnX2f0y3zz11DSwFvamB
        opIi6gVA62ZlDUHarOihZvXREhPD6vRJfwy5kpmosIq++AVdmwgA4kRrKLIgzVLshHoVINy
        KHnCfmQ0jeV2iEhU7QOS2c/3ddumrHmvWTvx8Qsdz4p9G6xvPMKTTGSg3Iv2xdbdCAfxvn0
        +BmCMGH1MA9ov65bYvh8JIBHgEa2H4MB907Ek/gdhyZCUMTk3zVVHyZ0UvByr6PA8CN+OuL
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3644606421767073713
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v4 06/18] tools/nolibc: crt.h: initialize stack protector
Date:   Sun, 16 Jul 2023 02:23:21 +0800
Message-Id: <2d286a88c325ab7e445029be6ab99eb810003e62.1689444638.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689444638.git.falcon@tinylab.org>
References: <cover.1689444638.git.falcon@tinylab.org>
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

As suggested by Thomas, It is able to move the stackprotector
initialization from the assembly _start to the beginning of the new
_start_c(). Let's call __stack_chk_init() in _start_c() as a
preparation.

Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/lkml/a00284a6-54b1-498c-92aa-44997fa78403@t-8ch.de/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/crt.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
index 92a2a0478cb1..32e128b0fb62 100644
--- a/tools/include/nolibc/crt.h
+++ b/tools/include/nolibc/crt.h
@@ -10,6 +10,7 @@
 char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
+void __stack_chk_init(void);
 static void exit(int);
 
 void _start_c(long *sp)
@@ -21,6 +22,9 @@ void _start_c(long *sp)
 	/* silence potential warning: conflicting types for 'main' */
 	int _nolibc_main(int, char **, char **) __asm__ ("main");
 
+	/* initialize stack protector */
+	__stack_chk_init();
+
 	/*
 	 * sp  :    argc          <-- argument count, required by main()
 	 * argv:    argv[0]       <-- argument vector, required by main()
-- 
2.25.1

