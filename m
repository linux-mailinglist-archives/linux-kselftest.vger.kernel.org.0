Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7802B74BE31
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jul 2023 17:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjGHPaM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 8 Jul 2023 11:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjGHPaL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 8 Jul 2023 11:30:11 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DFF90;
        Sat,  8 Jul 2023 08:30:09 -0700 (PDT)
X-QQ-mid: bizesmtp90t1688830199tddli4lm
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 08 Jul 2023 23:29:58 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: eSZ1CZgv+JDNSYVWcvAqpj0rMV65FuCWvkiqEsX0QCaJ3cmGvGHwqt4FW1NPz
        xtLYKx4fWntTwjgdLuKBjSAmdBqltgnFcnpV0Gg+dSUFOBuhWgGtMIVtlDJuRSOakTaDPyf
        DteElzUduQbDJaKPkaiv65kbJIwnbKHkk9XhbF7riP1SVSVYoxY855+ZD2A+7Kyh5RALGtG
        zeeesVIfP5H0OAey6/2Pp+ARRSKgkAwVv0n0wkl3AZDqzEyuojwi0WP8cSU2snSHpbwpFMf
        C/QtfST4aIERx7pL/R9uECvdoTwV9p5F2Zo/LtJSLRMdjKmijl9YEoGocgpClxQWlw6II3G
        0TZNWf1ltkWlZULHAwSeTkDHf2JIuhfDfKj0rx2TIG3R52KWmXc2oQ7zS748Q==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10107616674853176489
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v2 04/12] tools/nolibc: crt.h: add _start_c
Date:   Sat,  8 Jul 2023 23:29:58 +0800
Message-Id: <ccc8c9b850c03ef236ab05e919fea2bf9af2556a.1688828139.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688828139.git.falcon@tinylab.org>
References: <cover.1688828139.git.falcon@tinylab.org>
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

As the environ and _auxv support added for nolibc, the assembly _start
function becomes more and more complex and therefore makes the porting
of nolibc to new architectures harder and harder.

To simplify portability, this c version of _start_c() is added to do
most of the assembly start operations in C, which reduces the complexity
a lot and will eventually simplify the porting of nolibc to the new
architectures.

The new _start_c() only requires a stack pointer argument, it will find
argv, envp and _auxv for us, and then call main(), finally, it exit()
with main's return status. With this new _start_c(), the future new
architectures only require to add very few assembly instructions.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/crt.h | 44 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
index 221b7c5346ca..b269294e9664 100644
--- a/tools/include/nolibc/crt.h
+++ b/tools/include/nolibc/crt.h
@@ -13,4 +13,48 @@
 char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
+int main(int argc, char *argv[], char **envp);
+static void exit(int);
+
+void _start_c(long *sp)
+{
+	int argc, i;
+	char **argv;
+	char **envp;
+
+	/*
+	 * sp  :  argc          <-- argument count, required by main()
+	 * argv:  argv[0]       <-- argument vector, required by main()
+	 *        argv[1]
+	 *        ...
+	 *        argv[argc-1]
+	 *        null
+	 * envp:  envp[0]       <-- environment variables, required by main() and getenv()
+	 *        envp[1]
+	 *        ...
+	 *        null
+	 * _auxv: auxv[0]       <-- auxiliary vector, required by getauxval()
+	 *        auxv[1]
+	 *        ...
+	 *        null
+	 */
+
+	/* assign argc and argv */
+	argc = sp[0];
+	argv = (void *)(sp + 1);
+
+	/* find envp */
+	envp = argv + argc + 1;
+	environ = envp;
+
+	/* find auxv */
+	i = 0;
+	while (envp[i])
+		i++;
+	_auxv = (void *)(envp + i + 1);
+
+	/* go to application */
+	exit(main(argc, argv, envp));
+}
+
 #endif /* _NOLIBC_CRT_H */
-- 
2.25.1

