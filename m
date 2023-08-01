Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872C976A840
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 07:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjHAFaT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 01:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjHAFaS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 01:30:18 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656171FC9;
        Mon, 31 Jul 2023 22:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1690867812;
        bh=LvmZQIdIvROwNs8BBjCvj4x9lJTSLnFE4blB41Pgq2w=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=YsSJpqZ2f/fuBOe5XDdxzjkeIbjaFCdpFWaAu5aP0JM1Si7mfcjWZfrWbsLy/RwkE
         IqQbfH5hv6EuqnFt1Vjn/qfWgkIZ3BKmJjTb1aRzu6vZmecUEiYGoSdhmWleRCM0hP
         dcemk/ArZ0C72K/RL43mX2eoBpZZr2Ktas9VEDeg=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Tue, 01 Aug 2023 07:30:08 +0200
Subject: [PATCH v2 01/10] tools/nolibc: drop unused variables
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230801-nolibc-warnings-v2-1-1ba5ca57bd9b@weissschuh.net>
References: <20230801-nolibc-warnings-v2-0-1ba5ca57bd9b@weissschuh.net>
In-Reply-To: <20230801-nolibc-warnings-v2-0-1ba5ca57bd9b@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690867811; l=540;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=LvmZQIdIvROwNs8BBjCvj4x9lJTSLnFE4blB41Pgq2w=;
 b=ptgAfvbtUCQspRY5LLdaICU9RvnVqt3pjEXxvYG8xyULrsdoSM0Affxkp6csANNKE7RmW659D
 skYac7bVfXmBbbdEyqrDJoUF6P0IRr+6/wl87piN8r0AphhAFb5BvnD
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

