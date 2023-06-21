Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5F873842D
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 14:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjFUM6G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 08:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjFUM6G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 08:58:06 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED4BE72;
        Wed, 21 Jun 2023 05:58:04 -0700 (PDT)
X-QQ-mid: bizesmtp78t1687352274tr2s7sp4
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 21 Jun 2023 20:57:53 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: QityeSR92A3lpCGQzuzSiXYnrZ4Ms2NBo4oH5dQTYOsceoGFTIPlmCJgRv0R+
        s4uzXOz3pXCl4KJPtMgReBObXqC/ju+Gu/brbsuDexhdK9Eo3NLUmlAxcPg1BVViKeVcIjh
        bjO8/XuAMPkegjfs4p8H9ey54mSrtIFLR0eN3N+By+bkUUMJuzawFdgH92uHSh2QaWb1yIZ
        nRs7r8IZInAoySDLFF1ZIEPddk2qWQKDYPdLKJSyrFdZ06BmZ5jfYvB55JTN769R8m3eGVB
        AT9eKVwW88mxy8H0m7WwLaFveZKY1sPCpddc4iXTPjzsPP/ZV8znhNgSY31/rGuKBTDvmIw
        d9Zi+dJo6NCAkeQMLScWh2IoKVaa51OkOXOHPpkbTtDtG69mrS/8wdW42FXtw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8080205378424909828
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v1 04/17] selftests/nolibc: fix up kernel parameters support
Date:   Wed, 21 Jun 2023 20:57:41 +0800
Message-Id: <8e3e44492c986f691a778322e3eaf483e1734e90.1687344643.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687344643.git.falcon@tinylab.org>
References: <cover.1687344643.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kernel parameters allow pass two types of strings, one type is like
'noapic', another type is like 'panic=5', the first type is passed as
arguments of the init program, the second type is passed as environment
variables of the init program.

when users pass kernel parameters like this:

    noapic NOLIBC_TEST=syscall

our nolibc-test program will ignore the NOLIBC_TEST environment
variable.

Let's verify the first type (from arguments), if it is invalid, get the
test setting from NOLIBC_TEST environment variable instead.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index d43116553288..ebec948ec808 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -951,6 +951,7 @@ int main(int argc, char **argv, char **envp)
 	int ret = 0;
 	int err;
 	int idx;
+	int len, valid = 0;
 	char *test;
 
 	environ = envp;
@@ -969,7 +970,19 @@ int main(int argc, char **argv, char **envp)
 	 *    syscall:5-15[:.*],stdlib:8-10
 	 */
 	test = argv[1];
-	if (!test)
+
+	/* verify the test setting from argv[1] */
+	if (test) {
+		for (idx = 0; test_names[idx].name; idx++) {
+			len = strlen(test_names[idx].name);
+			if (strncmp(test, test_names[idx].name, len) == 0) {
+				valid = 1;
+				break;
+			}
+		}
+	}
+
+	if (!valid)
 		test = getenv("NOLIBC_TEST");
 
 	if (test) {
-- 
2.25.1

