Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E417BA72D
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Oct 2023 18:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjJEQ5G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Oct 2023 12:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjJEQ4E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Oct 2023 12:56:04 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E72A6709;
        Thu,  5 Oct 2023 09:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1696524324;
        bh=Wc1ok2Vt/Cz1nLVIzQ7UVMt9OEsxSir8ZCwThJY4DII=;
        h=From:Date:Subject:To:Cc:From;
        b=pf6MI9w02YAqmeQoh5kTBhBv1hZ+Nx2heGQD+43k8y0+++2HopB7ZHD4gTa5c8GLB
         Msuu5LS7U36v41vTIgkiLTnWvUaMPtdYq2ybR5OIpLTTc68tATr2M0hjlMj3OPBgbK
         WVHS41sgn38d/ze/FIrvAOLJEcAjGzhagVvzjjC8=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Thu, 05 Oct 2023 18:45:07 +0200
Subject: [PATCH RFC] tools/nolibc: add support for constructors and
 destructors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231005-nolibc-constructors-v1-1-776d56bbe917@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIABLoHmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDAwNT3bz8nMykZN3k/LzikqLS5JL8omLdJKPE1KS0tFTLJDNTJaDOgqL
 UtMwKsKnRSkFuzkqxtbUAg2H1n2oAAAA=
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696524324; l=4282;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Wc1ok2Vt/Cz1nLVIzQ7UVMt9OEsxSir8ZCwThJY4DII=;
 b=vdgrOYquQea5IRXxwz7Ybi5UIa6ZR7BpUl/sKN4wBErVSIS/mB/R+TMRG/F4lDRMRlcnlDofg
 DbzWTbul1utBj9Y4hk++QZoxOPWCrI0nmDzXb1vRi9eHJpHHvZ0G05W
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Note:

This is only an RFC as I'm not 100% sure it belong into nolibc.
But at least the code is visible as an example.

Also it is one prerequisite for full ksefltest_harness.h support in
nolibc, should we want that.
---
 tools/include/nolibc/crt.h                   | 23 ++++++++++++++++++++++-
 tools/testing/selftests/nolibc/nolibc-test.c | 16 ++++++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
index a5f33fef1672..c1176611d9a9 100644
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
+	for (func = __fini_array_end - 1; func >= __fini_array_start; func--)
+		(*func)();
+
+	exit(exitcode);
 }
 
 #endif /* _NOLIBC_CRT_H */
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index a3ee4496bf0a..f166b425613a 100644
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
@@ -594,6 +597,18 @@ int expect_strne(const char *expr, int llen, const char *cmp)
 #define CASE_TEST(name) \
 	case __LINE__: llen += printf("%d %s", test, #name);
 
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
@@ -631,6 +646,7 @@ int run_startup(int min, int max)
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

