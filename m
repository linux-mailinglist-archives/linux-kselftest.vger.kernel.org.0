Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5727162A0
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 15:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjE3NvB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 09:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjE3Nuv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 09:50:51 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED81C7;
        Tue, 30 May 2023 06:50:48 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1685454646;
        bh=ewKaB6L/DOQhgS1mAFK+x7nHWfw99pCSgv44oWr0O2s=;
        h=From:Date:Subject:To:Cc:From;
        b=f/ainB77OmlT/tnhTcCJlKECpiK3d5BaPjznu6BchuIkeJvxudG70JXwPvjm5dOK8
         wrp9iPEMnGvr1K1RidZDiPjfZTsXpDXiZ4xzgJLkI3exuF9jv+WnaSJNpL/oxfk8Uo
         CfNCJzDaTaALHxAjVZ9Yg8aMyRs7Bq2CAwuzG/I8=
Date:   Tue, 30 May 2023 15:48:48 +0200
Subject: [PATCH] selftests/nolibc: remove test gettimeofday_null
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230530-nolibc-gettimeofday-v1-1-7307441a002b@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAL/+dWQC/x2NywrCMBAAf6Xs2YU8UMFfEQ+bdNsuxI0krSil/
 +7icQaG2aFzE+5wG3Zo/JYuVQ38aYC8kM6MMhpDcCG6c3SotUjKOPO6ypPrNNIXL/kayLtEniJ
 YmagzpkaaF2t1K8Xkq/Ekn//q/jiOH+pRPy16AAAA
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     Zhangjin Wu <falcon@tinylab.org>, arnd@arndb.de,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685454646; l=1443;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ewKaB6L/DOQhgS1mAFK+x7nHWfw99pCSgv44oWr0O2s=;
 b=Z8MDlQoaPcLC133hYM9Us5kfgdVZVL3gf6AOJU1IEB7PatMjliQbZmD5Q70/c/iXG0sX/0uRj
 vZrEPWB6rQ7A35JVulyxB+2rJrbcqI0DfMoEMddcFEyTVAaFXCvAfMw
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

gettimeofday() is not guaranteed by posix to handle a NULL value as first
argument gracefully.
On glibc for example it crashes. (When not going through the vdso)

Link: https://lore.kernel.org/lkml/96f1134d-ce6e-4d82-ae00-1cd4038809c4@t-8ch.de/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 7de46305f419..0fe615ebb086 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -583,7 +583,6 @@ int run_syscall(int min, int max)
 		CASE_TEST(fork);              EXPECT_SYSZR(1, test_fork()); break;
 		CASE_TEST(getdents64_root);   EXPECT_SYSNE(1, test_getdents64("/"), -1); break;
 		CASE_TEST(getdents64_null);   EXPECT_SYSER(1, test_getdents64("/dev/null"), -1, ENOTDIR); break;
-		CASE_TEST(gettimeofday_null); EXPECT_SYSZR(1, gettimeofday(NULL, NULL)); break;
 #ifdef NOLIBC
 		CASE_TEST(gettimeofday_bad1); EXPECT_SYSER(1, gettimeofday((void *)1, NULL), -1, EFAULT); break;
 		CASE_TEST(gettimeofday_bad2); EXPECT_SYSER(1, gettimeofday(NULL, (void *)1), -1, EFAULT); break;

---
base-commit: 5b21219d67d3483144d10332709d0c04f733ab93
change-id: 20230530-nolibc-gettimeofday-6c72a10ba1a3

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

