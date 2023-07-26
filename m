Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901FA762B1F
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 08:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjGZGI1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 02:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjGZGIV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 02:08:21 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD24F5;
        Tue, 25 Jul 2023 23:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1690351695;
        bh=v6O6SwuFgKs/SoAmzquypRykV9tYHTJm4FpBMJUzSEE=;
        h=From:Date:Subject:To:Cc:From;
        b=mFk3L4cgyTnJpqynGlSNzeDFNoOCUL/3sdUHZ4Rhvu53gpH6h8NI0eTBLvnEL4I0O
         H1Z4MAbVmWA98KZ3ix74euVOo+O264gX8M7xOzgv1nvm8qgKWrUNmnMY/BiIl+qNak
         rEeb2hZXTr3X2lnn7+R7oQ/cc9EIiWwHW4y0knWk=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Wed, 26 Jul 2023 08:08:13 +0200
Subject: [PATCH] selftests/nolibc: avoid buffer underrun in space printing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230726-nolibc-result-width-v1-1-d1d2dc21844e@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAEy4wGQC/x3MTQqAIBBA4avErBswk4KuEi1SxxwIC+0PwrsnL
 b/Fey8kikwJhuqFSBcn3kJBU1dg/BwWQrbFIIVsRS87DNvK2mCkdK4H3mwPj41TWmjlWjMLKOU
 eyfHzX8cp5w+ybX56ZQAAAA==
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
        Zhangjin Wu <falcon@tinylab.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690351694; l=1238;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=v6O6SwuFgKs/SoAmzquypRykV9tYHTJm4FpBMJUzSEE=;
 b=RnPYAT0THCDr3pSIkFnyurroxKZQEZoV6fHlvEF71L/l3netZuAt2yUhzZhUzYBChtfpsy2dl
 whqCv19sqPTDt+DVSrBPtGM5DiopPoKOAJqZU1JRTMV9p3FYslsqPqN
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

If the test description is longer than the status alignment the
parameter 'n' to putcharn() would lead to a signed underflow that then
gets converted to a very large unsigned value.
This in turn leads out-of-bound writes in memset() crashing the
application.

The failure case of EXPECT_PTRER() used in "mmap_bad" exhibits this
exact behavior.

Fixes: 8a27526f49f9 ("selftests/nolibc: add EXPECT_PTREQ, EXPECT_PTRNE and EXPECT_PTRER")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 03b1d30f5507..9b76603e4ce3 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -151,7 +151,8 @@ static void result(int llen, enum RESULT r)
 	else
 		msg = "[FAIL]";
 
-	putcharn(' ', 64 - llen);
+	if (llen < 64)
+		putcharn(' ', 64 - llen);
 	puts(msg);
 }
 

---
base-commit: dfef4fc45d5713eb23d87f0863aff9c33bd4bfaf
change-id: 20230726-nolibc-result-width-1f4b0b4f3ca0

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

