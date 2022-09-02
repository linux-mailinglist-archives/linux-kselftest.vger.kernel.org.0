Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD235AAD4A
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Sep 2022 13:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbiIBLTb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Sep 2022 07:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbiIBLTb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Sep 2022 07:19:31 -0400
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [IPv6:2001:1600:3:17::1909])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC408C2F88
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Sep 2022 04:19:29 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MJwRM65DLzMqHNX;
        Fri,  2 Sep 2022 13:19:27 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MJwRM3wNRz14M;
        Fri,  2 Sep 2022 13:19:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1662117567;
        bh=wrXe8tHJ2UTJkif+PtnwYC1aVb7oXwurlcuWuM9Xqto=;
        h=From:To:Cc:Subject:Date:From;
        b=E4at8mYVC88+pzrWe1N+zAeX+4Q3k69MWep6fFn9EjP8ZtbfJYLaC0GmeyIoD6q6e
         naawFvOXMQUddwwcSY19BMa/Fk176n374yvbP2BD7ckLjJxD/dRt+xyQc9wN6DA+Io
         2yiY/pYPeO9+l4AN6xw5XTrYaC1tl8gIWZobHM0o=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2] checkpatch: Handle FILE pointer type
Date:   Fri,  2 Sep 2022 13:19:23 +0200
Message-Id: <20220902111923.1488671-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When using a "FILE *" type, checkpatch considers this an error:
  ERROR: need consistent spacing around '*' (ctx:WxV)
  #32: FILE: f.c:8:
  +static void a(FILE *const b)
                      ^

Fix this by explicitly defining "FILE" as a common type.  This is useful for
user space patches.

With this patch, we now get:
   <E> <E> <_>WS( )
   <E> <E> <_>IDENT(static)
   <E> <V> <_>WS( )
   <E> <V> <_>DECLARE(void )
   <E> <T> <_>FUNC(a)
   <E> <V> <V>PAREN('(')
   <EV> <N> <_>DECLARE(FILE *const )
   <EV> <T> <_>IDENT(b)
   <EV> <V> <_>PAREN(')') -> V
   <E> <V> <_>WS(
  )
  32 > . static void a(FILE *const b)
  32 > EEVVVVVVVTTTTTVNTTTTTTTTTTTTVVV
  32 >  ______________________________

Cc: Andy Whitcroft <apw@canonical.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc: Joe Perches <joe@perches.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20220902111923.1488671-1-mic@digikod.net
---

Changes since v1:
https://lore.kernel.org/r/20220901145948.1456353-1-mic@digikod.net
* Remove the FIXTURE_{DATA,VARIANT}() comments.
* Improve commit description.
---
 scripts/checkpatch.pl | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 79e759aac543..e2175102a354 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -576,10 +576,14 @@ our $typeKernelTypedefs = qr{(?x:
 	(?:__)?(?:u|s|be|le)(?:8|16|32|64)|
 	atomic_t
 )};
+our $typeStdioTypedefs = qr{(?x:
+	FILE
+)};
 our $typeTypedefs = qr{(?x:
 	$typeC99Typedefs\b|
 	$typeOtherOSTypedefs\b|
-	$typeKernelTypedefs\b
+	$typeKernelTypedefs\b|
+	$typeStdioTypedefs\b
 )};
 
 our $zero_initializer = qr{(?:(?:0[xX])?0+$Int_type?|NULL|false)\b};

base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
-- 
2.37.2

