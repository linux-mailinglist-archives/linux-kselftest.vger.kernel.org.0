Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD525A9B09
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Sep 2022 17:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbiIAPAN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 11:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234445AbiIAPAK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 11:00:10 -0400
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [IPv6:2001:1600:4:17::42aa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD841E3DC
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Sep 2022 07:59:59 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MJPN96nr7zMpypf;
        Thu,  1 Sep 2022 16:59:53 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MJPN93m0Fz11x;
        Thu,  1 Sep 2022 16:59:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1662044393;
        bh=icmwX+VVoTNqIidLHlNyh0r5G9YUWnEjoCgUFnQtQ88=;
        h=From:To:Cc:Subject:Date:From;
        b=fDQLf6jqFu+MDwoeXHxeqeo1ea/YACFpmZOqqSxDuLlSHelWsu6lNPMgyQU/qQj1N
         GFyPv3DqniceNFWKUna0pK797Jo+U5tNBBtvyqiWW4cgcJco/543kqjGsmYrDotSm7
         5pDhc+gMCUzyVptiGi1XGkXSiVqzwc2Ed9NRyC3w=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [RFC PATCH v1] checkpatch: Handle FILE pointer type
Date:   Thu,  1 Sep 2022 16:59:48 +0200
Message-Id: <20220901145948.1456353-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When using a "FILE *" type, checkpatch considers this an error.  Fix
this by explicitly defining "FILE" as a common type.

This is useful for user space patches.

With this patch, we now get:
 static void a(FILE *const b)

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

Another error may be throw when we use FIXTURE_{DATA,VARIANT}() structs,
as defined in kselftest_harness.h .  The commented
$typeKselftestHarnessTypedefs should fix it but such definition is
considered as a function instead, because of the closing parenthesis.
I'd like some help to fix this as well.

With $typeKselftestHarnessTypedefs added to $typeTypedefs, we get:
 static void c(const FIXTURE_VARIANT(d) *const e)

 <E> <E> <_>WS( )
 <E> <E> <_>IDENT(static)
 <E> <V> <_>WS( )
 <E> <V> <_>DECLARE(void )
 <E> <T> <_>FUNC(c)
 <E> <V> <V>PAREN('(')
 <EV> <N> <_>MODIFIER(const)
 <EV> <T> <_>WS( )
 <EV> <T> <_>FUNC(FIXTURE_VARIANT)
 <EV> <V> <V>PAREN('(')
 <EVV> <N> <_>IDENT(d)
 <EVV> <V> <_>PAREN(')') -> V
 <EV> <V> <_>WS( )
 <EV> <V> <_>OPV(*)
 <EV> <N> <_>MODIFIER(const)
 <EV> <T> <_>WS( )
 <EV> <T> <_>IDENT(e)
 <EV> <V> <_>PAREN(')') -> V
 <E> <V> <_>WS(
)
30 > . static void c(const FIXTURE_VARIANT(d) *const e)
30 > EEVVVVVVVTTTTTVNTTTTTTVVVVVVVVVVVVVVVNVVVNTTTTTTVVV
30 >  ________________________________________B_________

Cc: Andy Whitcroft <apw@canonical.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc: Joe Perches <joe@perches.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20220901145948.1456353-1-mic@digikod.net
---
 scripts/checkpatch.pl | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 79e759aac543..016b47c35742 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -576,10 +576,17 @@ our $typeKernelTypedefs = qr{(?x:
 	(?:__)?(?:u|s|be|le)(?:8|16|32|64)|
 	atomic_t
 )};
+our $typeStdioTypedefs = qr{(?x:
+	FILE
+)};
+# our $typeKselftestHarnessTypedefs = qr{(?x:
+# 	FIXTURE_(?:DATA|VARIANT)\($Ident\)
+# )};
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

