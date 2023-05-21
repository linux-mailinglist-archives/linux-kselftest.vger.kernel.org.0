Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB33670AD49
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 May 2023 11:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjEUJhW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 May 2023 05:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjEUJhH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 May 2023 05:37:07 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B753E10E;
        Sun, 21 May 2023 02:36:46 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1684661803;
        bh=LZiWAVpExLBqMgeJqjse39jIjxB9mRmhb4XKNlxTTGk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=aKPzR6j+3huZtpSLF6YDH0fFJla9wIq7qHOrQgL4kdykhoBWitzclVVYMTjGIXhRY
         YEKn2pRpmzaX5O0q1ghuQU1KLWWBq3Wyp6KM4a3KVPPSviZSSyWLWA65gBFhBV+eWA
         gWQLFyPVd6E2w2q7BGEJP+igoKeNHubZX97EpE1Y=
Date:   Sun, 21 May 2023 11:36:31 +0200
Subject: [PATCH 3/7] tools/nolibc: ensure stack protector guard is never
 zero
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230521-nolibc-automatic-stack-protector-v1-3-dad6c80c51c1@weissschuh.net>
References: <20230521-nolibc-automatic-stack-protector-v1-0-dad6c80c51c1@weissschuh.net>
In-Reply-To: <20230521-nolibc-automatic-stack-protector-v1-0-dad6c80c51c1@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684661802; l=1200;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=LZiWAVpExLBqMgeJqjse39jIjxB9mRmhb4XKNlxTTGk=;
 b=sO8HDPN/K4znD0QaY3SiD7iD6F2CEv31bBVfF6lPq1g8WZhC0+3FhV31SKjCcBcefvKdmKPMR
 u0UkQrt0A7sCyn8icIX+chE7SpWFl/tZHzoxx5uxcXyRtJCO35gOzf4
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The all-zero pattern is one of the more probable out-of-bound writes so
add a special case to not accidentally accept it.

Also it enables the reliable detection of stack protector initialization
during testing.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/stackprotector.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/stackprotector.h b/tools/include/nolibc/stackprotector.h
index 77e5251c4490..b0156fc077a0 100644
--- a/tools/include/nolibc/stackprotector.h
+++ b/tools/include/nolibc/stackprotector.h
@@ -45,8 +45,9 @@ __attribute__((weak,no_stack_protector,section(".text.nolibc_stack_chk")))
 void __stack_chk_init(void)
 {
 	my_syscall3(__NR_getrandom, &__stack_chk_guard, sizeof(__stack_chk_guard), 0);
-	/* a bit more randomness in case getrandom() fails */
-	__stack_chk_guard ^= (uintptr_t) &__stack_chk_guard;
+	/* a bit more randomness in case getrandom() fails, ensure the guard is never 0 */
+	if (__stack_chk_guard != (uintptr_t) &__stack_chk_guard)
+		__stack_chk_guard ^= (uintptr_t) &__stack_chk_guard;
 }
 #endif /* defined(NOLIBC_STACKPROTECTOR) */
 

-- 
2.40.1

