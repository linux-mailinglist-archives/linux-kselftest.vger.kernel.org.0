Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249016C1A4D
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Mar 2023 16:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjCTPud (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Mar 2023 11:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbjCTPtq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Mar 2023 11:49:46 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A7018B2E;
        Mon, 20 Mar 2023 08:41:22 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1679326880;
        bh=xDSjSascpesmgYZoOnKeZCwVvAZAUVs1JwzaeHlI+NA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Jf0ZSaLKTLUuhpDms909S2dyE0kwa5jMwuPDEE8OAtZ3FWHz8Yzzjs3kqtK/6KJk9
         8FwfTH/Hp53ATcS0Sx/1VL8QKhauW2TjTiLUHr+wO8t6mIxY2F6HBjy6BfQFAp3R8s
         R3RszYh9AwSFcBN0COT55mM1O3erj2O1KXq2CoFM=
Date:   Mon, 20 Mar 2023 15:41:01 +0000
Subject: [PATCH v2 1/8] tools/nolibc: add definitions for standard fds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230223-nolibc-stackprotector-v2-1-4c938e098d67@weissschuh.net>
References: <20230223-nolibc-stackprotector-v2-0-4c938e098d67@weissschuh.net>
In-Reply-To: <20230223-nolibc-stackprotector-v2-0-4c938e098d67@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1679326877; l=623;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=xDSjSascpesmgYZoOnKeZCwVvAZAUVs1JwzaeHlI+NA=;
 b=I6y1pduG9zTlWy+fGjussRCl8YSaD3MtbMYd9dIJFX/jUULKfAjFdYAwjL213kqIP1OJ/a+5T
 /jlT5ioSOXtAAGannMTNat/uBhM5w1+WgYLl1nXMAttBvnUh/1+48bj
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These are useful for users and will also be used in an upcoming
testcase.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/unistd.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/include/nolibc/unistd.h b/tools/include/nolibc/unistd.h
index 1cfcd52106a4..ac7d53d986cd 100644
--- a/tools/include/nolibc/unistd.h
+++ b/tools/include/nolibc/unistd.h
@@ -13,6 +13,11 @@
 #include "sys.h"
 
 
+#define STDIN_FILENO  0
+#define STDOUT_FILENO 1
+#define STDERR_FILENO 2
+
+
 static __attribute__((unused))
 int msleep(unsigned int msecs)
 {

-- 
2.40.0

