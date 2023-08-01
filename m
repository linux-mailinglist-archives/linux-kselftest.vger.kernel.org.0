Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2E676A841
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 07:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjHAFaU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 01:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjHAFaS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 01:30:18 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC7E1FC8;
        Mon, 31 Jul 2023 22:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1690867812;
        bh=9JcxE/sRcogPp0X3mpqUzzaMeZv7ua9TZds5/yNngTc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=bxqjKiZq2c9Jtsp+M1m02PFTibkb0pfk/Kp2mOnDkA0C9DQG7xI0hO3umOgBwTgo1
         Xebk3FyJsTz6vrYb4/PZJPxGpDHWI5XlHkt7GVNTUMPJsyilyYr+Q4zt+sUneBCbSW
         fTW+3q/Ntk2am8fnyWjDSTsDYu//KGf7ZrFHMDQk=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Tue, 01 Aug 2023 07:30:09 +0200
Subject: [PATCH v2 02/10] tools/nolibc: sys: avoid implicit sign cast
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230801-nolibc-warnings-v2-2-1ba5ca57bd9b@weissschuh.net>
References: <20230801-nolibc-warnings-v2-0-1ba5ca57bd9b@weissschuh.net>
In-Reply-To: <20230801-nolibc-warnings-v2-0-1ba5ca57bd9b@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690867811; l=704;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=9JcxE/sRcogPp0X3mpqUzzaMeZv7ua9TZds5/yNngTc=;
 b=pDCw8ZJtjbVkmrXmNV1kxMUun7xzLlpXVsSxJJLeAbQtZE/iBEkEZgIPjqXWPbJC49X9Or75F
 SGWD4IbaZcKBAq5SY9G6Uam5wrMHWvW0QOPmRsSL8w8Gg5odi2eS61h
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

getauxval() returns an unsigned long but the overall type of the ternary
operator needs to be signed.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/sys.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 889ccf5f0d56..2c5d9b06acf5 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -466,7 +466,7 @@ static unsigned long getauxval(unsigned long key);
 static __attribute__((unused))
 long getpagesize(void)
 {
-	return __sysret(getauxval(AT_PAGESZ) ?: -ENOENT);
+	return __sysret((long)getauxval(AT_PAGESZ) ?: -ENOENT);
 }
 
 

-- 
2.41.0

