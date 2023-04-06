Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB5A6DA4F4
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 23:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjDFVy7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 17:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjDFVy5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 17:54:57 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863C0AD02;
        Thu,  6 Apr 2023 14:54:55 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1680818092;
        bh=OcgnK0Ms7iKUc3TQe2cs92M6mnXoTMxMYhUD6BUEzjE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Al7o5EBhk9fVdcBzYPZEdaPJHwKO2ORtiubgQZ+/zeKtZH6A0vekJi37Qe1qWNhcX
         BWroDIsn/txxYpbjETqAP/Ac7n8RyicjGXxEpnC9/6ey/4FNmPKbKEsvX/Mt1bHOkK
         0p8qAjfC4Opqv6OzMwTji3UZvGD7bwYMUnH2b1uw=
Date:   Thu, 06 Apr 2023 21:54:47 +0000
Subject: [PATCH v2 01/11] tools/nolibc: use standard __asm__ statements
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230328-nolibc-c99-v2-1-c989f2289222@weissschuh.net>
References: <20230328-nolibc-c99-v2-0-c989f2289222@weissschuh.net>
In-Reply-To: <20230328-nolibc-c99-v2-0-c989f2289222@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680818091; l=1491;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=OcgnK0Ms7iKUc3TQe2cs92M6mnXoTMxMYhUD6BUEzjE=;
 b=/tLhsCm0o1ql7hDEB3NMPFg2Mw9aY+TDPxcepfXwZ3cfGVm7hLaY7Gftn6wrO02BFbkXeIaOh
 4A+bOEa+Bq1BrgsxG2EClk9aWzQio0erKF1n/E6RFFmCOx/zDQXvZu/
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

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/string.h                | 4 ++--
 tools/testing/selftests/nolibc/nolibc-test.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

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
 
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 888da60eb5ba..e692be98973a 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -984,7 +984,7 @@ int main(int argc, char **argv, char **envp)
 #else
 		else if (ioperm(0x501, 1, 1) == 0)
 #endif
-			asm volatile ("outb %%al, %%dx" :: "d"(0x501), "a"(0));
+			__asm__ volatile ("outb %%al, %%dx" :: "d"(0x501), "a"(0));
 		/* if it does nothing, fall back to the regular panic */
 #endif
 	}

-- 
2.40.0

