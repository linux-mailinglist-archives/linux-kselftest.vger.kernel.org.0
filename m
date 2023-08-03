Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D7276E158
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 09:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjHCH2y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 03:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjHCH2w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 03:28:52 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70471187;
        Thu,  3 Aug 2023 00:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1691047728;
        bh=Dq8jbZTyhLjjfrXzMVP5XMUcw7zpYJiDlah00ed3ZfA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=KHa0PEaHkP20XujShvLhET41cKqgvBcTEeUXjNBa8W9xU864D9jwX8k8zpM4lloLJ
         r5/aPAG5R6IpbYdNPuTcxm26O04yEo6+fX2ELLcgqxtgCRhBb3/TUafcnJ0JKQHI0C
         Wlwo6qz4SyJKj5d6xwvbM6BDPSz/UivF/GShLT6U=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Thu, 03 Aug 2023 09:28:47 +0200
Subject: [PATCH v3 03/14] tools/nolibc: setvbuf: avoid unused parameter
 warnings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230803-nolibc-warnings-v3-3-bcc1a096ae02@weissschuh.net>
References: <20230803-nolibc-warnings-v3-0-bcc1a096ae02@weissschuh.net>
In-Reply-To: <20230803-nolibc-warnings-v3-0-bcc1a096ae02@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691047727; l=810;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Dq8jbZTyhLjjfrXzMVP5XMUcw7zpYJiDlah00ed3ZfA=;
 b=y/x5UwahV+LCwccwghbOr9hgOU+M1lJT3l4QTOWofdAIStedWSwlXVZEe9082mVNHVjngX1QT
 m1550V64flcD7+j7YdZAfdVtF5nsfMp2kAWLHEJ6HoA5x+0i2Nkhfyy
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

This warning will be enabled later so avoid triggering it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/stdio.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index a3778aff4fa9..cae402c11e57 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -356,7 +356,10 @@ void perror(const char *msg)
 }
 
 static __attribute__((unused))
-int setvbuf(FILE *stream, char *buf, int mode, size_t size)
+int setvbuf(FILE *stream __attribute__((unused)),
+	    char *buf __attribute__((unused)),
+	    int mode,
+	    size_t size __attribute__((unused)))
 {
 	/*
 	 * nolibc does not support buffering so this is a nop. Just check mode

-- 
2.41.0

