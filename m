Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A064758830
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 00:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjGRWGS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 18:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjGRWGP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 18:06:15 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46951BF0;
        Tue, 18 Jul 2023 15:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1689717870;
        bh=n5xdrpXeznyuCE7mSG3Ebft0BriBP+01pglPR/8sL2I=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=fXmwJwizASNAM6mEBJEdpCnzy27ei/zjSleHHHPcRvFOJgTXpijOru0Ek4OhJLoHS
         13LaD5Vthd3HCTGUSe+L1gA0dGORMT2oQXgNuUeMiYHqbQi0ZM4Xq5eVWQozmTx2cx
         5CrKfyPm8NMlLLM5Xd6HM5nTxjHIlr8EtPt+Dq/8=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Wed, 19 Jul 2023 00:00:44 +0200
Subject: [PATCH RFC 6/7] kselftest: support skipping tests with testname
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230719-nolibc-ktap-tmp-v1-6-930bd0c52ff1@weissschuh.net>
References: <20230719-nolibc-ktap-tmp-v1-0-930bd0c52ff1@weissschuh.net>
In-Reply-To: <20230719-nolibc-ktap-tmp-v1-0-930bd0c52ff1@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689717869; l=1122;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=n5xdrpXeznyuCE7mSG3Ebft0BriBP+01pglPR/8sL2I=;
 b=4vAZFZKM8Ci22et/DmKgd0sLHEKdvXcU1n0xEOxws/408WmQBhmwPv4b8y1gWVR9tjrYi2Fb1
 avm6PU6beIYAlszszL2ixKFZIXML3KRYN1r59KSQGk0HApXvLnPCBEv
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The TAP parser at tools/testing/kunit/kunit.py requires a testname to
properly parse skipped tests.
The current kselftest APIs do not provide this functionality so add it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/kselftest.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 811d720d50dd..0206287de5b8 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -219,6 +219,21 @@ static inline void ksft_test_result_skip(const char *msg, ...)
 	va_end(args);
 }
 
+static inline void ksft_test_result_skip2(const char *name, const char *msg, ...)
+{
+	int saved_errno = errno;
+	va_list args;
+
+	ksft_cnt.ksft_xskip++;
+
+	va_start(args, msg);
+	printf("ok %d %s # SKIP ", ksft_test_num(), name);
+	errno = saved_errno;
+	vprintf(msg, args);
+	va_end(args);
+}
+
+
 /* TODO: how does "error" differ from "fail" or "skip"? */
 static inline void ksft_test_result_error(const char *msg, ...)
 {

-- 
2.41.0

