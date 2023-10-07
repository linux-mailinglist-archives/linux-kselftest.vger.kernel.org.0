Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E367BC697
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Oct 2023 12:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343783AbjJGKCH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Oct 2023 06:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbjJGKCF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Oct 2023 06:02:05 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06A7BC;
        Sat,  7 Oct 2023 03:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1696672910;
        bh=SqBaleMyPP1NMIGDa1LEoRzRhH54uSgKOZEmMOvaPQo=;
        h=From:Date:Subject:To:Cc:From;
        b=ex3VigjS0dWzm98IbWKVJJYZfuzztmhqLfqvvUrIydZY4ZnEQfvLS/K9rAJSmX4B6
         su25XwMfnDO/r7WCvn1ne8mmMUbwRPbx1rhtYY1v8XHaGT87+r+uXFnVps/cK3qHwh
         MEOQi8G29QDz7xtt0wPC/wFSErLrAWSuHsPOt1JQ=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Sat, 07 Oct 2023 12:01:39 +0200
Subject: [PATCH v2] tools/nolibc: add support for constructors and
 destructors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231007-nolibc-constructors-v2-1-ef84693efbc1@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAIIsIWUC/32NQQ7CIBBFr9LMWgxgKKkr79F0UeggkxgwTFs1T
 e8u9gAu38//72/AWAgZrs0GBVdiyqmCPjXg45juKGiqDFrqi5LSiJQf5LzwOfFcFj/nwsLpEV0
 I2LnWQF0+CwZ6H9Z+qByJa+9znKzql/73rUooYW07mdY57JS9vZCY2cclnhPOMOz7/gUtE8tOu
 wAAAA==
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696672908; l=4454;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=SqBaleMyPP1NMIGDa1LEoRzRhH54uSgKOZEmMOvaPQo=;
 b=bfmw8tPSb1b+tu1rCrisvN82uPMdqUjW1KDxjZvtkjKrTDCzhyfmSyPR/VURncu5JrZvZxkMs
 THOSHcFvj59Db2ODGblr7mg5nINvRrMKZtO7j7sa5WtZ15nDQeG4u5u
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

With the startup code moved to C, implementing support for
constructors and deconstructors is fairly easy to implement.

Examples for code size impact:

   text	   data	    bss	    dec	    hex	filename
  21837	    104	     88	  22029	   560d	nolibc-test.before
  22135	    120	     88	  22343	   5747	nolibc-test.after
  21970	    104	     88	  22162	   5692 nolibc-test.after-only-crt.h-changes

The sections are defined by [0].

[0] https://refspecs.linuxfoundation.org/elf/gabi4+/ch5.dynamic.html

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Drop RFC status.
- Add comment to constructor test that execution in definition-order is
  expected. (Willy)
- Rework destructor loop to avoid underflow if __fini_array_end is not
  provided by the linker.
- Link to v1: https://lore.kernel.org/r/20231005-nolibc-constructors-v1-1-776d56bbe917@weissschuh.net
---
 tools/include/nolibc/crt.h                   | 23 ++++++++++++++++++++++-
 tools/testing/selftests/nolibc/nolibc-test.c | 17 +++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
index a5f33fef1672..b84f5fbb7b58 100644
--- a/tools/include/nolibc/crt.h
+++ b/tools/include/nolibc/crt.h
@@ -13,11 +13,22 @@ const unsigned long *_auxv __attribute__((weak));
 static void __stack_chk_init(void);
 static void exit(int);
 
+extern void (*const __preinit_array_start[])(void) __attribute__((weak));
+extern void (*const __preinit_array_end[])(void) __attribute__((weak));
+
+extern void (*const __init_array_start[])(void) __attribute__((weak));
+extern void (*const __init_array_end[])(void) __attribute__((weak));
+
+extern void (*const __fini_array_start[])(void) __attribute__((weak));
+extern void (*const __fini_array_end[])(void) __attribute__((weak));
+
 void _start_c(long *sp)
 {
 	long argc;
 	char **argv;
 	char **envp;
+	int exitcode;
+	void (* const *func)(void);
 	const unsigned long *auxv;
 	/* silence potential warning: conflicting types for 'main' */
 	int _nolibc_main(int, char **, char **) __asm__ ("main");
@@ -54,8 +65,18 @@ void _start_c(long *sp)
 		;
 	_auxv = auxv;
 
+	for (func = __preinit_array_start; func < __preinit_array_end; func++)
+		(*func)();
+	for (func = __init_array_start; func < __init_array_end; func++)
+		(*func)();
+
 	/* go to application */
-	exit(_nolibc_main(argc, argv, envp));
+	exitcode = _nolibc_main(argc, argv, envp);
+
+	for (func = __fini_array_end; func > __fini_array_start;)
+		(*--func)();
+
+	exit(exitcode);
 }
 
 #endif /* _NOLIBC_CRT_H */
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index a3ee4496bf0a..88ea8e06e596 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -57,6 +57,9 @@ static int test_argc;
 /* will be used by some test cases as readable file, please don't write it */
 static const char *argv0;
 
+/* will be used by constructor tests */
+static int constructor_test_value;
+
 /* definition of a series of tests */
 struct test {
 	const char *name;              /* test name */
@@ -594,6 +597,19 @@ int expect_strne(const char *expr, int llen, const char *cmp)
 #define CASE_TEST(name) \
 	case __LINE__: llen += printf("%d %s", test, #name);
 
+/* constructors validate that they are executed in definition order */
+__attribute__((constructor))
+static void constructor1(void)
+{
+	constructor_test_value = 1;
+}
+
+__attribute__((constructor))
+static void constructor2(void)
+{
+	constructor_test_value *= 2;
+}
+
 int run_startup(int min, int max)
 {
 	int test;
@@ -631,6 +647,7 @@ int run_startup(int min, int max)
 		CASE_TEST(auxv_addr);        EXPECT_PTRGT(test_auxv != (void *)-1, test_auxv, brk); break;
 		CASE_TEST(auxv_AT_UID);      EXPECT_EQ(1, getauxval(AT_UID), getuid()); break;
 		CASE_TEST(auxv_AT_PAGESZ);   EXPECT_GE(1, getauxval(AT_PAGESZ), 4096); break;
+		CASE_TEST(constructor);      EXPECT_EQ(1, constructor_test_value, 2); break;
 		case __LINE__:
 			return ret; /* must be last */
 		/* note: do not set any defaults so as to permit holes above */

---
base-commit: ab663cc32912914258bc8a2fbd0e753f552ee9d8
change-id: 20231005-nolibc-constructors-b2aebffe9b65

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

