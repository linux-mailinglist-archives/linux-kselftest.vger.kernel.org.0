Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45D170AD4A
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 May 2023 11:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjEUJh0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 May 2023 05:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjEUJhH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 May 2023 05:37:07 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B740710D;
        Sun, 21 May 2023 02:36:46 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1684661803;
        bh=oLTaTevv3k80SApzPl3sC5k69tzfv/sUdDz9hEu9AXU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=EVIsm97U6hspOISLz9ZkoZ//yLstU5Paxq2AbGwXTOMqrQbGKyFY0AH9JSYJPwldQ
         4RGacL4K8+kn2z5fmBIN0ip99iQ/Kz5Pturk+/Of9nX1yVmMXX91Xv1Zz15tgi9oY6
         3qo9uvtT7IdogZqQbFO5ZQrxu4Quvu8oCON6CzjE=
Date:   Sun, 21 May 2023 11:36:32 +0200
Subject: [PATCH 4/7] tools/nolibc: add test for __stack_chk_guard
 initialization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230521-nolibc-automatic-stack-protector-v1-4-dad6c80c51c1@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684661802; l=737;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=oLTaTevv3k80SApzPl3sC5k69tzfv/sUdDz9hEu9AXU=;
 b=8XeDn2bNa5olwhqFKmuOVv/Y2l1qpUlcqMMKVlNWL29/GDmokGkH5PtrMdPY2qmVkaOW+rQMG
 ukmwfsiBBjjBGSgBiSPqAT5uQqfU3LNeeObcPPkOlh4tTWg/TZJiFcq
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

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index d8b59c8f6c03..995dc39a177e 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -808,6 +808,14 @@ static int run_protection(int min, int max)
 	return 0;
 #endif
 
+#if defined(NOLIBC_STACKPROTECTOR)
+	if (!__stack_chk_guard) {
+		llen += printf("__stack_chk_guard not initialized");
+		pad_spc(llen, 64, "[FAIL]\n");
+		return 1;
+	}
+#endif
+
 	pid = -1;
 	pid = fork();
 

-- 
2.40.1

