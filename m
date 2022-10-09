Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B0C5F8D26
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Oct 2022 20:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiJISaL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 9 Oct 2022 14:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJISaK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 9 Oct 2022 14:30:10 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B3E9167DB;
        Sun,  9 Oct 2022 11:30:08 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 299ITsUH029168;
        Sun, 9 Oct 2022 20:29:54 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        kernel test robot <lkp@intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH v2] tools/nolibc: fix missing strlen() definition and infinite loop with gcc-12
Date:   Sun,  9 Oct 2022 20:29:36 +0200
Message-Id: <20221009182936.29125-1-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20221009151939.28270-1-w@1wt.eu>
References: <20221009151939.28270-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When built at -Os, gcc-12 recognizes an strlen() pattern in nolibc_strlen()
and replaces it with a jump to strlen(), which is not defined as a symbol
and breaks compilation. Worse, when the function is called strlen(), the
function is simply replaced with a jump to itself, hence becomes an
infinite loop.

One way to avoid this is to always set -ffreestanding, but the calling
code doesn't know this and there's no way (either via attributes or
pragmas) to globally enable it from include files, effectively leaving
a painful situation for the caller.

Alexey suggested to place an empty asm() statement inside the loop to
stop gcc from recognizing a well-known pattern, which happens to work
pretty fine. At least it allows us to make sure our local definition
is not replaced with a self jump.

The function only needs to be renamed back to strlen() so that the symbol
exists, which implies that nolibc_strlen() which is used on variable
strings has to be declared as a macro that points back to it before the
strlen() macro is redifined.

It was verified to produce valid code with gcc 3.4 to 12.1 at different
optimization levels, and both with constant and variable strings.

In case this problem surfaces again in the future, an alternate approach
consisting in adding an optimize("no-tree-loop-distribute-patterns")
function attribute for gcc>=12 worked as well but is less pretty.

Reported-by: kernel test robot <yujie.liu@intel.com>
Link: https://lore.kernel.org/r/202210081618.754a77db-yujie.liu@intel.com
Fixes: 66b6f755ad45 ("rcutorture: Import a copy of nolibc")
Fixes: 96980b833a21 ("tools/nolibc/string: do not use __builtin_strlen() at -O0")
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
v2: dropped the attribute(optimize) in favor of an empty asm() statement

---
 tools/include/nolibc/string.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index bef35bee9c44..718a405ffbc3 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -125,14 +125,18 @@ char *strcpy(char *dst, const char *src)
 }
 
 /* this function is only used with arguments that are not constants or when
- * it's not known because optimizations are disabled.
+ * it's not known because optimizations are disabled. Note that gcc 12
+ * recognizes an strlen() pattern and replaces it with a jump to strlen(),
+ * thus itself, hence the asm() statement below that's meant to disable this
+ * confusing practice.
  */
 static __attribute__((unused))
-size_t nolibc_strlen(const char *str)
+size_t strlen(const char *str)
 {
 	size_t len;
 
-	for (len = 0; str[len]; len++);
+	for (len = 0; str[len]; len++)
+		asm("");
 	return len;
 }
 
@@ -140,13 +144,12 @@ size_t nolibc_strlen(const char *str)
  * the two branches, then will rely on an external definition of strlen().
  */
 #if defined(__OPTIMIZE__)
+#define nolibc_strlen(x) strlen(x)
 #define strlen(str) ({                          \
 	__builtin_constant_p((str)) ?           \
 		__builtin_strlen((str)) :       \
 		nolibc_strlen((str));           \
 })
-#else
-#define strlen(str) nolibc_strlen((str))
 #endif
 
 static __attribute__((unused))
-- 
2.35.3

