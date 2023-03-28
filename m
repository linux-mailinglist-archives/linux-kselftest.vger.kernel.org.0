Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8976CC323
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 16:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbjC1Ovg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 10:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbjC1OvX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 10:51:23 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D9FD307;
        Tue, 28 Mar 2023 07:51:01 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1680015059;
        bh=OC20lNQ2kW08aHm+ntfqMtfDoB6968+zaZ8h6wCeC0I=;
        h=From:Date:Subject:To:Cc:From;
        b=Ok2+HEIic10pECRlUIIVtxnPuTAa0eI732lvD25KYFwTpa3fN1bYQWfTcxbZGuQeN
         QgytGstYMtSgu/Sv0dUu28MzGJsh4qrLLT3WzFqgqMn0KOirFlwHF/Vh+7/CRv9BVl
         xShadoIGUho+cxix6dlxYmXayVseA401bFZfGvqs=
Date:   Tue, 28 Mar 2023 14:50:35 +0000
Subject: [PATCH] tools/nolibc: tests: use volatile to force stack smashing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230328-nolibc-smash-stack-volatile-v1-1-2b4aa7563a77@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIALr+ImQC/x2NMQ7CMAwAv1J5xlJIhha+ghic4BKL4KC4rZCq/
 p2I8W6428G4CRtchx0ab2JStcP5NEDKpE9GeXQG73xwwU+otUhMaG+yjLZQeuFWCy1SGB1PI1/
 8GGYm6IVIxhgbacq9oWspXX4az/L9L2/34/gBVdYBkIIAAAA=
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680015056; l=1274;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=OC20lNQ2kW08aHm+ntfqMtfDoB6968+zaZ8h6wCeC0I=;
 b=foXYvQN71ivsHirrXL4/rtYWQt3bVjFIRd7+bVLXr3yfBSrVRpsXh4/ottXX9+xvJjweLVKdJ
 vb/glnJG7LMDyPiGskvss1mIdS6AKkwJ25++TRBYX7F/HJ+xdn04CcT
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

Use a volatile pointer to write outside the buffer so the compiler can't
optimize it away.

Reported-by: Alexey Dobriyan <adobriyan@gmail.com>
Link: https://lore.kernel.org/lkml/c0584807-511c-4496-b062-1263ea38f349@p183/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---

This is based on the "dev" branch of the rcu tree.
---
 tools/testing/selftests/nolibc/nolibc-test.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 21bacc928bf7..47013b78972e 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -667,17 +667,13 @@ int run_stdlib(int min, int max)
 	return ret;
 }
 
-#if defined(__clang__)
-__attribute__((optnone))
-#elif defined(__GNUC__)
-__attribute__((optimize("O0")))
-#endif
 static int smash_stack(void)
 {
 	char buf[100];
+	volatile char *ptr = buf;
 
 	for (size_t i = 0; i < 200; i++)
-		buf[i] = 'P';
+		ptr[i] = 'P';
 
 	return 1;
 }

---
base-commit: 6e7cac3d5b8c77ddedfaa7efad23aa542cde53b2
change-id: 20230328-nolibc-smash-stack-volatile-0e87e9273fea

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

