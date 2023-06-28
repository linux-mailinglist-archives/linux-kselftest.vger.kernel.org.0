Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF08741220
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 15:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjF1NTO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 09:19:14 -0400
Received: from bg4.exmail.qq.com ([43.155.65.254]:32632 "EHLO
        bg4.exmail.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjF1NSp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 09:18:45 -0400
X-QQ-mid: bizesmtp69t1687958310tkm13siq
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 28 Jun 2023 21:18:28 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: 4Vai6KyTH6olGrLgZSh4EBdEiPnKWxX8aNTYUPXg6Lx8/XabB2ORuydqmTx/K
        nWsv/KD90ZFL9r+VXWuXyOoaC4ERWR4sRX4WJGAdhGOcAVvoLQD6ex8moLKIWd4QdG+IQ0D
        j+Eyw8nSFDo7OPg9885wL1pFPE2ySFIKUphzXcdUp2+tx3SCAcbjOBrFZ4dxb56eUSh6pPc
        /BQ3n6GCw3KrPwbZO2/uOtkFe+rxslqi4Gdi42zsHGIqonDvO3UvUWI3MA7r00cqXahGUsa
        6HaNURQHnn3AYs8IQZA5V8bZfJyoZdF+ukP58U08Qu+0XQrbgUdUxGmj+dB65uJm67WdVz/
        Vh7LojKgfFwfn6eZRuXjKUbeiX7LvUBY8mnaXVNcLABVkgiZtjPMU6Obm8yuA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7654508823436994445
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v5 05/14] tools/nolibc: string.h: clean up multiple whitespaces with tab
Date:   Wed, 28 Jun 2023 21:17:18 +0800
Message-Id: <bb93eb9b6684bd72dc62ddbc7a7b09b16eb5bc17.1687957589.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687957589.git.falcon@tinylab.org>
References: <cover.1687957589.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To align with Linux code style and let scripts/checkpatch.pl happy, the
multiple whitespaces in arch-<ARCH>.h files are cleaned up with tab.

It is detected by:

    $ grep '  *\\$' tools/include/nolibc/string.h

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/string.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index 0c2e06c7c477..e8f471ce09f3 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -148,10 +148,10 @@ size_t strlen(const char *str)
  */
 #if defined(__OPTIMIZE__)
 #define nolibc_strlen(x) strlen(x)
-#define strlen(str) ({                          \
-	__builtin_constant_p((str)) ?           \
-		__builtin_strlen((str)) :       \
-		nolibc_strlen((str));           \
+#define strlen(str) ({				\
+	__builtin_constant_p((str)) ?		\
+		__builtin_strlen((str)) :	\
+		nolibc_strlen((str));		\
 })
 #endif
 
-- 
2.25.1

