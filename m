Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515206AF88A
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 23:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjCGWXe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 17:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjCGWW6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 17:22:58 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCE0A2F03;
        Tue,  7 Mar 2023 14:22:44 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1678227762;
        bh=8vpJp3oAEKODLAv9t1dEXsETCFI+gjgH/LM0SQtKvyk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=rHPQbbi/2Nz+LU7UGTHNps/xBxZ7er/WEsarwmW8dH65goVja+uqW9IbmTJGXjR9o
         anJouWbHU+PIS+F4KrGxVkkNdz4+UJKWQGvUP1KXBDtiGFDrWgqwCSvZFNuOwEvaM6
         E+35vj0hkYTnK6887gZFxmZs1BCtnoqsMDATT9+4=
Date:   Tue, 07 Mar 2023 22:22:32 +0000
Subject: [PATCH RFC 3/5] tools/nolibc: tests: constify test_names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230223-nolibc-stackprotector-v1-3-3e74d81b3f21@weissschuh.net>
References: <20230223-nolibc-stackprotector-v1-0-3e74d81b3f21@weissschuh.net>
In-Reply-To: <20230223-nolibc-stackprotector-v1-0-3e74d81b3f21@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678227756; l=802;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=8vpJp3oAEKODLAv9t1dEXsETCFI+gjgH/LM0SQtKvyk=;
 b=c7rCOUMg7N5z4JyASccazgTh924VO7kz0NQvFm/NngjdZMPE4U+IzbfsTF7Si1APsNZ9Sjpe2
 96IDa8n7DtJCs+RqXAfwNpEQHFgSZ80TespqkD3+3kNowBb56iOFbwt
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Nothing ever modifies this structure.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 6a7c13f0cd61..fb2d4872fac9 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -717,7 +717,7 @@ int prepare(void)
 }
 
 /* This is the definition of known test names, with their functions */
-static struct test test_names[] = {
+static const struct test test_names[] = {
 	/* add new tests here */
 	{ .name = "syscall",   .func = run_syscall  },
 	{ .name = "stdlib",    .func = run_stdlib   },

-- 
2.39.2

