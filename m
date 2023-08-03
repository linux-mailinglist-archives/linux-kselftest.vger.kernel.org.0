Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A340C76E15F
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 09:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjHCH26 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 03:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjHCH2w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 03:28:52 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354302D6A;
        Thu,  3 Aug 2023 00:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1691047728;
        bh=iyNHuyFIri0jOYpPmNaXlYmA/yRvazXiYVqNbQvn0aU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=E5yZKMaXfMDcQ/MX0pRsZBQWf6pZojYuI1Pwm4z6w7hhVsVENXrH8a1+Ql5rNZR0m
         bfRAuZ/hwFedoX0F2vuLwV9GNziF3rkJLk9wijv89ehEts6l574XX6RxK4hO8bFdq4
         vFyrf1ykG59kT3PVcHZ/PasLqvG8ZaRyKwDwKz0Y=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Thu, 03 Aug 2023 09:28:48 +0200
Subject: [PATCH v3 04/14] tools/nolibc: sys: avoid implicit sign cast
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230803-nolibc-warnings-v3-4-bcc1a096ae02@weissschuh.net>
References: <20230803-nolibc-warnings-v3-0-bcc1a096ae02@weissschuh.net>
In-Reply-To: <20230803-nolibc-warnings-v3-0-bcc1a096ae02@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691047727; l=702;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=iyNHuyFIri0jOYpPmNaXlYmA/yRvazXiYVqNbQvn0aU=;
 b=SdXAr1nPJemUkaNkDtnvzdItVrwOJcTSgFgDli3ZAyQlj1UF07hIZH3b5znuC4sOs+HytEHEL
 e3r3dEQzSeVDGMN3vbUKh7fFprXjSduqd+F2TbnPDKo5jBq03UZCaOY
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index c151533ba8e9..833d6c5e86dc 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -466,7 +466,7 @@ static unsigned long getauxval(unsigned long key);
 static __attribute__((unused))
 int getpagesize(void)
 {
-	return __sysret(getauxval(AT_PAGESZ) ?: -ENOENT);
+	return __sysret((int)getauxval(AT_PAGESZ) ?: -ENOENT);
 }
 
 

-- 
2.41.0

