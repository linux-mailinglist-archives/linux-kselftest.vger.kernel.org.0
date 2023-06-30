Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82FF743DD3
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 16:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjF3Ora (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Jun 2023 10:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjF3Ora (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Jun 2023 10:47:30 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF05E4C;
        Fri, 30 Jun 2023 07:47:28 -0700 (PDT)
X-QQ-mid: bizesmtp76t1688136438tbbkfb8i
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Jun 2023 22:47:17 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: rRzgT1OOeLqcsI4HZ6uwZGCFEkc3obYUh18KgobxkZnKI5QUXNZlM728bmyMP
        i/hnfFr8sHQm4/9yZ5VrwNKm6edfJopZXLJxrcEM9j9fyxLNkU2NlUfhvAy9poIx6ODEOWI
        h1eGfNYL8Yo5wUUll7cewmQyOFctAYqTTMIoJrUADsEnq7Xjw/3Ilcziwx3vkKhtyF3TJeN
        FofpwL4gpa622cnxx8dxsqXcWlTc8DW6XsOd7lBkw3yy8ClduzQBCxmQ/OXHlbY/Gy9iV1f
        gs3fZwRNN16EZA7xHBWRmSmxdkYbciqEy9QCuf1AVjV1NDzSXo/JYMIx0WAFy90evipBuL7
        ODEaVw0VKlijmQn44j0fTHCenEmvyJf2U4j+6jnHpBBqtMtCkXpFTSiiN7bK1Xy5F/PDzQg
        +gW1dBxP53E=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16371103090428855131
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v3 05/14] selftests/nolibc: fix up kernel parameters support
Date:   Fri, 30 Jun 2023 22:47:15 +0800
Message-Id: <cfd69d46dbbae6d8b41bafccad8622733281d7c9.1688134400.git.falcon@tinylab.org>
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

kernel parameters allow pass two types of strings, one type is like
'noapic', another type is like 'panic=5', the first type is passed as
arguments of the init program, the second type is passed as environment
variables of the init program.

when users pass kernel parameters like this:

    noapic NOLIBC_TEST=syscall

our nolibc-test program will use the test setting from argv[1] and
ignore the one from NOLIBC_TEST environment variable, and at last, it
will print the following line and ignore the whole test setting.

    Ignoring unknown test name 'noapic'

reversing the parsing order does solve the above issue:

    test = getenv("NOLIBC_TEST");
    if (test)
        test = argv[1];

but it still doesn't work with such kernel parameters (without
NOLIBC_TEST environment variable):

    noapic FOO=bar

To support all of the potential kernel parameters, let's verify the test
setting from both of argv[1] and NOLIBC_TEST environment variable.

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 33 ++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 290b43c7dc72..94801961740a 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1062,6 +1062,35 @@ static const struct test test_names[] = {
 	{ 0 }
 };
 
+int is_setting_valid(char *test)
+{
+	int idx, len, test_len, valid = 0;
+	char delimiter;
+
+	if (!test)
+		return valid;
+
+	test_len = strlen(test);
+
+	for (idx = 0; test_names[idx].name; idx++) {
+		len = strlen(test_names[idx].name);
+		if (test_len < len)
+			continue;
+
+		if (strncmp(test, test_names[idx].name, len) != 0)
+			continue;
+
+		delimiter = test[len];
+		if (delimiter != ':' && delimiter != ',' && delimiter != '\0')
+			continue;
+
+		valid = 1;
+		break;
+	}
+
+	return valid;
+}
+
 int main(int argc, char **argv, char **envp)
 {
 	int min = 0;
@@ -1087,10 +1116,10 @@ int main(int argc, char **argv, char **envp)
 	 *    syscall:5-15[:.*],stdlib:8-10
 	 */
 	test = argv[1];
-	if (!test)
+	if (!is_setting_valid(test))
 		test = getenv("NOLIBC_TEST");
 
-	if (test) {
+	if (is_setting_valid(test)) {
 		char *comma, *colon, *dash, *value;
 
 		do {
-- 
2.25.1

