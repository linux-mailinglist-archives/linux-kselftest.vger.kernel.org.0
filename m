Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDD57A364B
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Sep 2023 17:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbjIQPqK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 17 Sep 2023 11:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239228AbjIQPg0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 17 Sep 2023 11:36:26 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312A7F7;
        Sun, 17 Sep 2023 08:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1694964978;
        bh=CFKO2pFyHSsA2SAs6y1PywroFir3M35jZ1f8rQL8DIY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=grweBFpqOzzFodwt9bLiUu+iq1fDMCCV2KbU7oR61uO2DmX1YY996TpBvk7O55JWO
         xmpwXzKtSjaPDyNqHTfld80fPCdkamOBDhFuxIwsU0gseEI5uHVIi3hKI4fjxAn6l9
         e/vQ3wCQOrQmVcPn0IvSKP6+XmhT/h0A/DjEXF/M=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Sun, 17 Sep 2023 17:36:16 +0200
Subject: [PATCH v2 1/4] selftests/nolibc: allow building i386 with
 multiarch compiler
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230917-nolibc-syscall-nr-v2-1-03863d509b9a@weissschuh.net>
References: <20230917-nolibc-syscall-nr-v2-0-03863d509b9a@weissschuh.net>
In-Reply-To: <20230917-nolibc-syscall-nr-v2-0-03863d509b9a@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694964977; l=951;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=CFKO2pFyHSsA2SAs6y1PywroFir3M35jZ1f8rQL8DIY=;
 b=VsixQu3g8WzopT9PImr31pRBaIq13lYqmy67LYfor/qIj3rHz5UPsZREaLxJr7ILn1LXxrUI/
 IpcQwNaSusPDo9KxxDvHj6wODfe0BMy1Lf52vkb0+30THRM1jrRkwrJ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When building with a multiarch-capable compiler, like those provided by
common distributions the -m32 argument is required to build 32bit code.

Wrap it in cc-option in case the compiler is not multiarch-capable.

Acked-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 689658f81a19..19096a9ded55 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -113,6 +113,7 @@ else
 Q=@
 endif
 
+CFLAGS_i386 = $(call cc-option,-m32)
 CFLAGS_ppc = -m32 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
 CFLAGS_ppc64 = -m64 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
 CFLAGS_ppc64le = -m64 -mlittle-endian -mno-vsx $(call cc-option,-mabi=elfv2)

-- 
2.42.0

