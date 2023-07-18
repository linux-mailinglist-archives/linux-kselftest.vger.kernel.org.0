Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBCF75882C
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 00:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjGRWGF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 18:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjGRWGE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 18:06:04 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB871998;
        Tue, 18 Jul 2023 15:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1689717870;
        bh=YqZjg8FJSrMkBkCofVYWpCEZm+a1T8K7Shk7yEsIFhk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=NPeS/3iYy+jey15HonR2ocm81ly6VV/WH7+0MM9aTdPSvy8ZAw8kLsM8dB1tVi+Es
         AgaTQbFkkhLx4pGOh5iAbGKOjIYD0k+/mWw7frw30Oiuuwt3ZPbXyivjlq+dRKIu62
         Pr9nDVliPXk0gkyousMuoJ5nqH8hAAKRXN18XXL0=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Wed, 19 Jul 2023 00:00:43 +0200
Subject: [PATCH RFC 5/7] kselftest: support KTAP format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230719-nolibc-ktap-tmp-v1-5-930bd0c52ff1@weissschuh.net>
References: <20230719-nolibc-ktap-tmp-v1-0-930bd0c52ff1@weissschuh.net>
In-Reply-To: <20230719-nolibc-ktap-tmp-v1-0-930bd0c52ff1@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689717869; l=831;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=YqZjg8FJSrMkBkCofVYWpCEZm+a1T8K7Shk7yEsIFhk=;
 b=hB2BE0mFLdkCFJKShYDy6EPP2LB0tt6wHpWoT2KvdNGGKgEDYRpl305L7NC3YXuiwwbLs68cB
 crzHnhCEyrSD1sh+t1ly7VPJJMRPm6i9IGP72eVLTCb3GzCgWQgxLni
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

KTAP supports nested suites which we want to use for nolibc tests.
The TAP parser at tools/testing/kunit/kunit.py requires the header
"KTAP version 1" to parse nested suites.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/kselftest.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 829be379545a..811d720d50dd 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -117,6 +117,11 @@ static inline void ksft_print_header(void)
 		printf("TAP version 13\n");
 }
 
+static inline void ksft_print_header_ktap(void)
+{
+	printf("KTAP version 1\n");
+}
+
 static inline void ksft_set_plan(unsigned int plan)
 {
 	ksft_plan = plan;

-- 
2.41.0

