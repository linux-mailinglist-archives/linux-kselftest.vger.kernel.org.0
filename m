Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDDF6CCBE3
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 23:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjC1VHq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 17:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjC1VHp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 17:07:45 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC5E95;
        Tue, 28 Mar 2023 14:07:44 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1680037663;
        bh=8ux9UHqbqpMOlAJI+ZJEgyqwQHWiMyZYCque8yHWZRU=;
        h=From:Date:Subject:To:Cc:From;
        b=FUmw3S4kxf8Zu1dS5Ws4Tp4ii5oEjdIBQ+ojpDYFC2bIa17ajXjBsNZQyJuWs7ux3
         LuzYPEyGZCu+00czxmpthEIcPZrjMG8/aWb0Y3gy3Fk8WvEJCj9y8s2pbenkfMvU8u
         hi8a+FFSZ1oK0qP5wQloXaO15f9VJATiOyh5ZyPU=
Date:   Tue, 28 Mar 2023 21:07:35 +0000
Subject: [PATCH] tools/nolibc: validate C99 compatibility
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230328-nolibc-c99-v1-1-a8302fb19f19@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIABZXI2QC/x2NQQqDMBAAvyJ7dsEmURq/Ih6SdK0LYZWEFkH8u
 4vHGRjmhEqFqcLYnFDoz5U3UXi1DaQ1yJeQP8pgOmM7a94oW+aYMHmPvV+co+D6wQ6gQQyVMJY
 gadVEfjmr3AstfDyHab6uG/jq3HRxAAAA
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680037661; l=2491;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=8ux9UHqbqpMOlAJI+ZJEgyqwQHWiMyZYCque8yHWZRU=;
 b=slWT4JgbJIqg7PxtMlqRH7dZbvh2R8m8ZhplDChXZgWmAzzPJJ4HCLnldGH8XlOUtDDAEFQa9
 3c3lcSWSWAQBnKyD3WrE5bApCjn/4LMzEil0pnOLAo+MJGngGJzuYPV
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Most of the code was migrated to C99-conformant __asm__ statements
before. It seems string.h was missed.

Fix string.h and also validate during build that nolibc stays within
C99.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---

This patch is based on the "dev" branch of the RCU tree.
---
 tools/include/nolibc/string.h                | 4 ++--
 tools/testing/selftests/nolibc/Makefile      | 2 +-
 tools/testing/selftests/nolibc/nolibc-test.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index fffdaf6ff467..0c2e06c7c477 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -90,7 +90,7 @@ void *memset(void *dst, int b, size_t len)
 
 	while (len--) {
 		/* prevent gcc from recognizing memset() here */
-		asm volatile("");
+		__asm__ volatile("");
 		*(p++) = b;
 	}
 	return dst;
@@ -139,7 +139,7 @@ size_t strlen(const char *str)
 	size_t len;
 
 	for (len = 0; str[len]; len++)
-		asm("");
+		__asm__("");
 	return len;
 }
 
diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index bbce57420465..55efcb1011cb 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -83,7 +83,7 @@ CFLAGS_STKP_i386 = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_STKP_x86_64 = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_STKP_x86 = $(CFLAGS_STACKPROTECTOR)
 CFLAGS_s390 = -m64
-CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables \
+CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c99 \
 		$(call cc-option,-fno-stack-protector) \
 		$(CFLAGS_STKP_$(ARCH)) $(CFLAGS_$(ARCH))
 LDFLAGS := -s
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 47013b78972e..932b2c7b0ce3 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -895,7 +895,7 @@ int main(int argc, char **argv, char **envp)
 #else
 		else if (ioperm(0x501, 1, 1) == 0)
 #endif
-			asm volatile ("outb %%al, %%dx" :: "d"(0x501), "a"(0));
+			__asm__ volatile ("outb %%al, %%dx" :: "d"(0x501), "a"(0));
 		/* if it does nothing, fall back to the regular panic */
 #endif
 	}

---
base-commit: a5333c037de823912dd20e933785c63de7679e64
change-id: 20230328-nolibc-c99-59f44ea45636

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

