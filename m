Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8C4798C53
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 20:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241356AbjIHSOD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 14:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbjIHSOD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 14:14:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCF9212F;
        Fri,  8 Sep 2023 11:13:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D57C433CC;
        Fri,  8 Sep 2023 18:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694196118;
        bh=ukqUF+v1kN7+x5zDRqQ+dQLLBt3uOBB5B6FX0qlJI6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QwzNqb8/vfpc0Gl8ZKZr+Dp0xxB4LGOUa9btHUvxFIMvu0eCHZWifqEdQtAFsja5f
         uvBD5lBjgW3qwIWJQU5VDvjsHNt5zg/Sqz4/9XjZzkoz6a0VPLox9LqJX8DYN3C7oh
         /po6mgxhoLfKXeOySrbRZkQnavWt6YxQa4gDfi8xKvL7wEAt6pmNvvrSOi/sArzYzZ
         BwV02MDKQO3nvwrw6DLptaxeZ7ZDYNALfseh9ldjdXjF3t6mdW5sEOcRPcRfEgJ6E+
         wPRzlbEDJ8hA0CgM613eKg5PPuzHxwkFJaQl7kGE7l0eJ19ERJ8Blmc1Taf7Jke192
         EtrNqOT5ytvlQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhangjin Wu <falcon@tinylab.org>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>, Sasha Levin <sashal@kernel.org>,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 13/13] selftests/nolibc: fix up kernel parameters support
Date:   Fri,  8 Sep 2023 14:00:59 -0400
Message-Id: <20230908180100.3458151-13-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908180100.3458151-1-sashal@kernel.org>
References: <20230908180100.3458151-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Zhangjin Wu <falcon@tinylab.org>

[ Upstream commit c388c9920da2679f62bec48d00ca9e80e9d0a364 ]

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
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 33 ++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index d37d036876ea9..041f5d16a9d87 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -782,6 +782,35 @@ static const struct test test_names[] = {
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
@@ -807,10 +836,10 @@ int main(int argc, char **argv, char **envp)
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
2.40.1

