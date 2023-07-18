Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42610758827
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 00:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjGRWFo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 18:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjGRWFk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 18:05:40 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844EF1BCD;
        Tue, 18 Jul 2023 15:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1689717869;
        bh=kF605graM0o+JyxoXxBa0/owm9OEnH5LILzEVA9RPjE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Bepf/DTqe6xA4OOkGtCWzuKntBtMJbF2cW1JQ8cJtbGWI8o1xtGQfJMsV+/Hy49tL
         HKaura92v9iXxSxU2L17hdOvMjuYI/JyyryD0EoQvNYb9DiJ+zppiE4Xu66Tmzg5zq
         f+NJUtTszxSpaNC9v/xVBGX8rSpSfOSzs1sPp2Hk=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Wed, 19 Jul 2023 00:00:40 +0200
Subject: [PATCH RFC 2/7] selftests/nolibc: use unsigned indices for
 testcases
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230719-nolibc-ktap-tmp-v1-2-930bd0c52ff1@weissschuh.net>
References: <20230719-nolibc-ktap-tmp-v1-0-930bd0c52ff1@weissschuh.net>
In-Reply-To: <20230719-nolibc-ktap-tmp-v1-0-930bd0c52ff1@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689717869; l=2050;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=kF605graM0o+JyxoXxBa0/owm9OEnH5LILzEVA9RPjE=;
 b=MYxbOcmYGkZfCi/TwDUHZJZAbPsTxgMczMwDMD83xNXDoUu01R67udQhf3NOLApmXd2XnB+Nq
 vYhFfGkJEGHAEPSthqSQOPBCLSsdOF+HGEJ69dbA6+vhjeRa9CHkX38
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

They should never be negative.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 698af242d3e4..1bd99e0fab4d 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -62,7 +62,7 @@ static const char *argv0;
 /* definition of a series of tests */
 struct test {
 	const char *name;              /* test name */
-	int (*func)(int min, int max); /* handler */
+	int (*func)(unsigned int min, unsigned int max); /* handler */
 };
 
 #ifndef _NOLIBC_STDLIB_H
@@ -570,7 +570,7 @@ static int expect_strne(const char *expr, int llen, const char *cmp)
 #define CASE_TEST(name) \
 	case __LINE__: llen += printf("%d %s", test, #name);
 
-int run_startup(int min, int max)
+int run_startup(unsigned int min, unsigned int max)
 {
 	int test;
 	int ret = 0;
@@ -773,7 +773,7 @@ int test_mmap_munmap(void)
 /* Run syscall tests between IDs <min> and <max>.
  * Return 0 on success, non-zero on failure.
  */
-int run_syscall(int min, int max)
+int run_syscall(unsigned int min, unsigned int max)
 {
 	struct timeval tv;
 	struct timezone tz;
@@ -884,7 +884,7 @@ int run_syscall(int min, int max)
 	return ret;
 }
 
-int run_stdlib(int min, int max)
+int run_stdlib(unsigned int min, unsigned int max)
 {
 	int test;
 	int tmp;
@@ -1027,7 +1027,7 @@ static int expect_vfprintf(int llen, size_t c, const char *expected, const char
 	return ret;
 }
 
-static int run_vfprintf(int min, int max)
+static int run_vfprintf(unsigned int min, unsigned int max)
 {
 	int test;
 	int tmp;
@@ -1070,7 +1070,7 @@ static int smash_stack(void)
 	return 1;
 }
 
-static int run_protection(int min, int max)
+static int run_protection(unsigned int min, unsigned int max)
 {
 	pid_t pid;
 	int llen = 0, status;

-- 
2.41.0

