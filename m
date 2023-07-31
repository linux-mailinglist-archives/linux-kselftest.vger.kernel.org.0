Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596AF768C00
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 08:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjGaG1F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 02:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjGaG1C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 02:27:02 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4895E6F;
        Sun, 30 Jul 2023 23:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1690784818;
        bh=LvmZQIdIvROwNs8BBjCvj4x9lJTSLnFE4blB41Pgq2w=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=gvI2i/X5im2ahZdFvSaVa9KNeP4jeORaiNKeL5hHIKbj7TdHojC0P3yxe27+9vXDB
         IkTpnZnRkODOsuw3JZy/467zaayIKLPq+ri1+h0lrnJykGmn9OVP52+fBpSZCbo0VT
         3p+6pOk8AJc0C73ATLSFkluNZNzF5TstrbFgh8bg=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Mon, 31 Jul 2023 08:26:58 +0200
Subject: [PATCH 3/4] tools/nolibc: drop unused variables
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230731-nolibc-warnings-v1-3-74973d2a52d7@weissschuh.net>
References: <20230731-nolibc-warnings-v1-0-74973d2a52d7@weissschuh.net>
In-Reply-To: <20230731-nolibc-warnings-v1-0-74973d2a52d7@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690784818; l=540;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=LvmZQIdIvROwNs8BBjCvj4x9lJTSLnFE4blB41Pgq2w=;
 b=uwkXwy2v/nU5enWds8bgac9/9EudpZ4Km0p/0z+y//9evIaD0SxhTOxLGiuSv2wbkIpsbPh9+
 VHlsEtREOZeCZrRJUNccRh1kWOpJSaWWSnyyOu+PDxK02XH3+hzR4hg
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

Nobody needs it, get rid of it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/sys.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 8bfe7db20b80..889ccf5f0d56 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -738,7 +738,6 @@ static __attribute__((unused))
 int open(const char *path, int flags, ...)
 {
 	mode_t mode = 0;
-	int ret;
 
 	if (flags & O_CREAT) {
 		va_list args;

-- 
2.41.0

