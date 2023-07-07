Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1F574B37A
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 17:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbjGGPBa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 11:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbjGGPB3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 11:01:29 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726DA1FE2;
        Fri,  7 Jul 2023 08:01:28 -0700 (PDT)
X-QQ-mid: bizesmtp74t1688742074tg81aioz
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 07 Jul 2023 23:01:12 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: +bXiSo2NuBc1Cd2zooPSXRsbPXASdUhmi+9wjNyy/hjCxNCxO5qngS1ViteCu
        ns6FJkzManwTtWB7dHIZA8wXwP40Yky4g0FuLECXFu2Ndeaooo69kfrJoOWpX45uzyTGpAJ
        nPnUC0t4URkUa8//XlfzX4YGN4v3zUMSi9ZV8m6LygSdBTdSgSSjIFILqo/I6i5Wms9ANVE
        aV6qpvXLwzFzaQXY6srvtV54bxf/VqOAHBH4yJvqFIe0HX42Oago3jrel90v8a8ausjvOEk
        FMSau3FWLFNI4aFaEsG+uRScy9Trs8rFpplBRLluEWFJhrWXhZQ+mxR1ecuQeGowyBt7WKS
        7k2Ek8ShyF8kd1sCBdBFi6khn2PoKnT3U+WLKIUxsFoTpGVmTx0RBsy60RaMcVWc+wIOZ5x
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11414460270218283821
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, thomas@t-8ch.de
Subject: [PATCH v6 09/15] selftests/nolibc: export argv0 for some tests
Date:   Fri,  7 Jul 2023 23:01:09 +0800
Message-Id: <a7b5d53a8a27eae67625c5a6aec9b420f1217d4f.1688739492.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688739492.git.falcon@tinylab.org>
References: <cover.1688739492.git.falcon@tinylab.org>
MIME-Version: 1.0
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

argv0 is the path to nolibc-test program itself, which is a very good
always existing readable file for some tests, let's export it.

Note, the path may be absolute or relative, please make sure the tests
work with both of them. If it is relative, we must make sure the current
path is the one specified by the PWD environment variable.

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/lkml/ZKKbS3cwKcHgnGwu@1wt.eu/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 486334981e60..88b840f86f52 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -43,6 +43,9 @@
 /* will be used by nolibc by getenv() */
 char **environ;
 
+/* will be used by some test cases as readable file, please don't write it */
+static const char *argv0;
+
 /* definition of a series of tests */
 struct test {
 	const char *name;              /* test name */
@@ -948,6 +951,7 @@ int main(int argc, char **argv, char **envp)
 	int idx;
 	char *test;
 
+	argv0 = argv[0];
 	environ = envp;
 
 	/* when called as init, it's possible that no console was opened, for
-- 
2.25.1

