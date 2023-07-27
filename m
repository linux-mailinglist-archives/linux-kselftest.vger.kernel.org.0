Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA3376603B
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 01:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjG0X1L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 19:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjG0X1K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 19:27:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BC62D40
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jul 2023 16:27:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07BBC61F8F
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jul 2023 23:27:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0ADC43395;
        Thu, 27 Jul 2023 23:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690500428;
        bh=9k3w2GBcBAqmmGMPcYLsGGGPHhPVChgtpgxlIPZIOJc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=E0t01Qv+n6eKa+pxbIMDfoirGbEwAEgWccJu5vrJYO2FEgtdWqw47uCHBxvhGNGNj
         Q/JYRe8HhOcXyS9FfQqEjnqABMLh39l+SR1JH40f9IZN9/D9VjBn3AdQ+34booim9c
         9uTGIW0mP8Uw1C0e5Wsz2wXKVhFnYe0ITOOQ+4qsmQGlXYIwoNWFah0Ia1zn9cHP1d
         UoM+YS/Y6jFzeGxOCQWlwzcyPIMgTcPuonNfG/htvQqm3JZL4Zuw3TltJ7wbRiTCK/
         OjH+xIm8ZDtkEK061340hDNO/nzKfwddY5d+C0tdEOgSY2NeT6I0APhTof/NLfC7Gg
         Wpi4GsJmvvWzw==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 28 Jul 2023 00:26:17 +0100
Subject: [PATCH v4 6/6] kselftest/arm64: Use the tools/include compiler.h
 rather than our own
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230728-arm64-signal-memcpy-fix-v4-6-0c1290db5d46@kernel.org>
References: <20230728-arm64-signal-memcpy-fix-v4-0-0c1290db5d46@kernel.org>
In-Reply-To: <20230728-arm64-signal-memcpy-fix-v4-0-0c1290db5d46@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=3009; i=broonie@kernel.org;
 h=from:subject:message-id; bh=9k3w2GBcBAqmmGMPcYLsGGGPHhPVChgtpgxlIPZIOJc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkwv09LNwFQCF4CRRL0scso9UK+3zOt7IV4CbSxiXS
 1PHiYZ+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZML9PQAKCRAk1otyXVSH0JSjB/
 40eJ999zzsbI5ThnpILemnJjHqCswwKHRtduJHlB0FLL12fQX4/zXt7TK9eK8/uiLzsWi//nwQObtt
 WsamOENoa3zfgCaBFzj4j+F/sFkjN0mr/t56ZzINLHZhWO6rSzVbzD5a+9C3n4rzAQhHdKFxRGksj0
 1aH020PnCSz1I43wDX8UoFB86XkxMOKERLAOkRy8rROErcI6XJ8ktqw7GDmGJvGjKlzHmEx8n1oDm0
 l9uFG/Kp4Fk4A3JWK4I7XVe3gIZOiJtI2SV74q7GqJV6lhu61gqgIWmef6ZWRHg585uGx93nE+ChDF
 +VYwf+d1XSdaMaRA8rtxEZCLX7FuJp
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The BTI test program started life as standalone programs outside the
kselftest suite so provided it's own compiler.h. Now that we have updated
the tools/include compiler.h to have all the definitions that we are using
and the arm64 selftsets pull in tools/includes let's drop our custom
version.

__unreachable() is named unreachable() there requiring an update in the
code.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/bti/compiler.h | 21 ---------------------
 tools/testing/selftests/arm64/bti/system.c   |  4 +---
 tools/testing/selftests/arm64/bti/system.h   |  4 ++--
 tools/testing/selftests/arm64/bti/test.c     |  1 -
 4 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/arm64/bti/compiler.h b/tools/testing/selftests/arm64/bti/compiler.h
deleted file mode 100644
index ebb6204f447a..000000000000
--- a/tools/testing/selftests/arm64/bti/compiler.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2019  Arm Limited
- * Original author: Dave Martin <Dave.Martin@arm.com>
- */
-
-#ifndef COMPILER_H
-#define COMPILER_H
-
-#define __always_unused __attribute__((__unused__))
-#define __noreturn __attribute__((__noreturn__))
-#define __unreachable() __builtin_unreachable()
-
-/* curse(e) has value e, but the compiler cannot assume so */
-#define curse(e) ({				\
-	__typeof__(e) __curse_e = (e);		\
-	asm ("" : "+r" (__curse_e));		\
-	__curse_e;				\
-})
-
-#endif /* ! COMPILER_H */
diff --git a/tools/testing/selftests/arm64/bti/system.c b/tools/testing/selftests/arm64/bti/system.c
index 6385d8d4973b..93d772b00bfe 100644
--- a/tools/testing/selftests/arm64/bti/system.c
+++ b/tools/testing/selftests/arm64/bti/system.c
@@ -8,12 +8,10 @@
 
 #include <asm/unistd.h>
 
-#include "compiler.h"
-
 void __noreturn exit(int n)
 {
 	syscall(__NR_exit, n);
-	__unreachable();
+	unreachable();
 }
 
 ssize_t write(int fd, const void *buf, size_t size)
diff --git a/tools/testing/selftests/arm64/bti/system.h b/tools/testing/selftests/arm64/bti/system.h
index aca118589705..2e9ee1284a0c 100644
--- a/tools/testing/selftests/arm64/bti/system.h
+++ b/tools/testing/selftests/arm64/bti/system.h
@@ -14,12 +14,12 @@ typedef __kernel_size_t size_t;
 typedef __kernel_ssize_t ssize_t;
 
 #include <linux/errno.h>
+#include <linux/compiler.h>
+
 #include <asm/hwcap.h>
 #include <asm/ptrace.h>
 #include <asm/unistd.h>
 
-#include "compiler.h"
-
 long syscall(int nr, ...);
 
 void __noreturn exit(int n);
diff --git a/tools/testing/selftests/arm64/bti/test.c b/tools/testing/selftests/arm64/bti/test.c
index 2cd8dcee5aec..28a8e8a28a84 100644
--- a/tools/testing/selftests/arm64/bti/test.c
+++ b/tools/testing/selftests/arm64/bti/test.c
@@ -17,7 +17,6 @@
 typedef struct ucontext ucontext_t;
 
 #include "btitest.h"
-#include "compiler.h"
 #include "signal.h"
 
 #define EXPECTED_TESTS 18

-- 
2.30.2

