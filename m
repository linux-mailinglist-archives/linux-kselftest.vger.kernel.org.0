Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A7376A846
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 07:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjHAFa1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 01:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjHAFaX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 01:30:23 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B7F1FC6;
        Mon, 31 Jul 2023 22:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1690867813;
        bh=IgjLrXapLUyrHe3QIhxAoxZT1uWllcSWJz1V8L+G1yU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Yq19FH/D4gFvCvGG+FLJ4e8m7mSmbZMJ8oKL0JPgpzl8mMmJTMYt4GMH5LzJ08fRu
         gvWH+zBimOttLfS/OICkpHz/kWyYfnr4CfvSyOjodkKhDIX2GD9xvdUbv31e2QoTIm
         WY/QDcQ2bkSoeaJ59lnWGPRYMTKXKGIjTka6iyn0=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Tue, 01 Aug 2023 07:30:13 +0200
Subject: [PATCH v2 06/10] selftests/nolibc: make functions static if
 possible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230801-nolibc-warnings-v2-6-1ba5ca57bd9b@weissschuh.net>
References: <20230801-nolibc-warnings-v2-0-1ba5ca57bd9b@weissschuh.net>
In-Reply-To: <20230801-nolibc-warnings-v2-0-1ba5ca57bd9b@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690867811; l=2423;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=IgjLrXapLUyrHe3QIhxAoxZT1uWllcSWJz1V8L+G1yU=;
 b=w25nddOU5uOwRkjgP9UtA/ejR4rshXc6sRpWgDkm3xvpc8I6XGN03VoEMhM41hQIZbGjb+4tK
 rAFxCxanxBhDQC7u9ejvxT0uvqDNylbialOlKhWUnS1xzy2WsNCLmsW
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This allows the compiler to generate warnings if they go unused.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 1555759bb164..53a3773c7790 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -80,7 +80,7 @@ char *itoa(int i)
 /* returns the error name (e.g. "ENOENT") for common errors, "SUCCESS" for 0,
  * or the decimal value for less common ones.
  */
-const char *errorname(int err)
+static const char *errorname(int err)
 {
 	switch (err) {
 	case 0: return "SUCCESS";
@@ -593,7 +593,7 @@ int expect_strne(const char *expr, int llen, const char *cmp)
 #define CASE_TEST(name) \
 	case __LINE__: llen += printf("%d %s", test, #name);
 
-int run_startup(int min, int max)
+static int run_startup(int min, int max)
 {
 	int test;
 	int ret = 0;
@@ -640,7 +640,7 @@ int run_startup(int min, int max)
 
 
 /* used by some syscall tests below */
-int test_getdents64(const char *dir)
+static int test_getdents64(const char *dir)
 {
 	char buffer[4096];
 	int fd, ret;
@@ -734,7 +734,7 @@ static int test_stat_timestamps(void)
 	return 0;
 }
 
-int test_mmap_munmap(void)
+static int test_mmap_munmap(void)
 {
 	int ret, fd, i;
 	void *mem;
@@ -796,7 +796,7 @@ int test_mmap_munmap(void)
 /* Run syscall tests between IDs <min> and <max>.
  * Return 0 on success, non-zero on failure.
  */
-int run_syscall(int min, int max)
+static int run_syscall(int min, int max)
 {
 	struct timeval tv;
 	struct timezone tz;
@@ -907,7 +907,7 @@ int run_syscall(int min, int max)
 	return ret;
 }
 
-int run_stdlib(int min, int max)
+static int run_stdlib(int min, int max)
 {
 	int test;
 	int ret = 0;
@@ -1141,7 +1141,7 @@ static int run_protection(int min, int max)
 }
 
 /* prepare what needs to be prepared for pid 1 (stdio, /dev, /proc, etc) */
-int prepare(void)
+static int prepare(void)
 {
 	struct stat stat_buf;
 
@@ -1208,7 +1208,7 @@ static const struct test test_names[] = {
 	{ 0 }
 };
 
-int is_setting_valid(char *test)
+static int is_setting_valid(char *test)
 {
 	int idx, len, test_len, valid = 0;
 	char delimiter;

-- 
2.41.0

