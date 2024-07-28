Return-Path: <linux-kselftest+bounces-14345-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B442993E964
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 22:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67F031F21254
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 20:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DF36F2EB;
	Sun, 28 Jul 2024 20:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="i51DR0FP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDEA6BFA3;
	Sun, 28 Jul 2024 20:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722198865; cv=none; b=PSBExsL3klMYn+1UFmnYMjq7/WKSWvik9a1Fm5CS7fSYOyvxsiT2iAk1fRiRvxK4ieBDpuydidVyJ/Q2M7wghID4xnqD2+mhBJ+ssXZT1URMbFq19rz10tAf6WZbctQKBf2MwIsSfeMqYfRyFEl7+qGOMfyaZZAupt1xxU+v73I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722198865; c=relaxed/simple;
	bh=CeA4ugbXitVgz5NHikDyzwTb7Ve1XT9KHPr0qiXuhG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=O+gkFIw1gjQ/t4HVfJ11s7oyZ3azl9IrG5aQFjzwBXphjn+2Qhs0s7TiugmoAsqRR3GEHmGaBipV4ZAK9ZsLWE7HO5zAyLZepwaii+QVVLC3WhuKZqh7HAE+hO0MSFR5tteg9j6gCxjvalPXYVW+XYpQq3hLawfTZ/XAGM0oBx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=i51DR0FP; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722198854;
	bh=CeA4ugbXitVgz5NHikDyzwTb7Ve1XT9KHPr0qiXuhG4=;
	h=From:Date:Subject:To:Cc:From;
	b=i51DR0FPQkByzeUSne23A+gmvOZsOmnfse9DZfSo3XkML0X6OOXoGo7zdLKMs2NVF
	 6VLEresW+9m+HDUV5X23DjWR68pcUzgF8W/hGRsSh92t5/IUpAGINqCBxOAp3PeSgK
	 lIJVaBeZ9B+4EpKVWaaCcgBI3Whto55AIM601tVM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 28 Jul 2024 22:34:11 +0200
Subject: [PATCH] tools/nolibc: pass argc, argv and envp to constructors
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240728-nolibc-constructor-args-v1-1-36d0bf5cd4c0@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAEKrpmYC/x3MTQqDMBBA4avIrDuQxr/Qq5QuNE50oCRlJhVBc
 neDy2/x3glKwqTwak4Q2lk5xYrnowG/TXEl5KUarLGdGa3DmL48e/Qpapa/z0lwklVxcHPohxD
 GrnVQ659Q4OM+vz+lXGhoFyJpAAAA
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722198853; l=3307;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=CeA4ugbXitVgz5NHikDyzwTb7Ve1XT9KHPr0qiXuhG4=;
 b=fO3ZYdlbhNkNTaSL4xiuL99f6qj4NFfZ1HYJ9fIkuWRbd/5xb7hJqmOdAT9md/YFsJwDtuldr
 jpYvQvjOkjCBsldTMUSns5YtGcEO36M964Cg+SdIvA9IeiCY00y2EnC
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Mirror glibc behavior for compatibility.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/crt.h                   | 23 ++++++++++++-----------
 tools/testing/selftests/nolibc/nolibc-test.c |  5 +++--
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
index 43b551468c2a..ac291574f6c0 100644
--- a/tools/include/nolibc/crt.h
+++ b/tools/include/nolibc/crt.h
@@ -13,11 +13,11 @@ const unsigned long *_auxv __attribute__((weak));
 static void __stack_chk_init(void);
 static void exit(int);
 
-extern void (*const __preinit_array_start[])(void) __attribute__((weak));
-extern void (*const __preinit_array_end[])(void) __attribute__((weak));
+extern void (*const __preinit_array_start[])(int, char **, char**) __attribute__((weak));
+extern void (*const __preinit_array_end[])(int, char **, char**) __attribute__((weak));
 
-extern void (*const __init_array_start[])(void) __attribute__((weak));
-extern void (*const __init_array_end[])(void) __attribute__((weak));
+extern void (*const __init_array_start[])(int, char **, char**) __attribute__((weak));
+extern void (*const __init_array_end[])(int, char **, char**) __attribute__((weak));
 
 extern void (*const __fini_array_start[])(void) __attribute__((weak));
 extern void (*const __fini_array_end[])(void) __attribute__((weak));
@@ -29,7 +29,8 @@ void _start_c(long *sp)
 	char **argv;
 	char **envp;
 	int exitcode;
-	void (* const *func)(void);
+	void (* const *ctor_func)(int, char **, char **);
+	void (* const *dtor_func)(void);
 	const unsigned long *auxv;
 	/* silence potential warning: conflicting types for 'main' */
 	int _nolibc_main(int, char **, char **) __asm__ ("main");
@@ -66,16 +67,16 @@ void _start_c(long *sp)
 		;
 	_auxv = auxv;
 
-	for (func = __preinit_array_start; func < __preinit_array_end; func++)
-		(*func)();
-	for (func = __init_array_start; func < __init_array_end; func++)
-		(*func)();
+	for (ctor_func = __preinit_array_start; ctor_func < __preinit_array_end; ctor_func++)
+		(*ctor_func)(argc, argv, envp);
+	for (ctor_func = __init_array_start; ctor_func < __init_array_end; ctor_func++)
+		(*ctor_func)(argc, argv, envp);
 
 	/* go to application */
 	exitcode = _nolibc_main(argc, argv, envp);
 
-	for (func = __fini_array_end; func > __fini_array_start;)
-		(*--func)();
+	for (dtor_func = __fini_array_end; dtor_func > __fini_array_start;)
+		(*--dtor_func)();
 
 	exit(exitcode);
 }
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 093d0512f4c5..0800b10fc3f7 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -686,9 +686,10 @@ static void constructor1(void)
 }
 
 __attribute__((constructor))
-static void constructor2(void)
+static void constructor2(int argc, char **argv, char **envp)
 {
-	constructor_test_value *= 2;
+	if (argc && argv && envp)
+		constructor_test_value *= 2;
 }
 
 int run_startup(int min, int max)

---
base-commit: 0db287736bc586fcd5a2925518ef09eec6924803
change-id: 20240728-nolibc-constructor-args-68bf56ff7438

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


