Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCD86AF886
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 23:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjCGWX1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 17:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjCGWWz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 17:22:55 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFBF15C81;
        Tue,  7 Mar 2023 14:22:44 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1678227761;
        bh=Q1jPkyZPjmkNR+Jyt/fGKq7/BIdQKHocnxXtbPXnLSw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=lfM6gB7vpnbV7lLlqhIAQvjNfPPsozDIil7qCsXldnF7LPqqzcg+6k9gfyy8OVi5N
         F03kVXkRO5yyxxK6hYFAm0FXxCwRiP2KYL49r3PBOSQ6y4PAVju0czdw/bkWcUIjIG
         FFufZnn/jvclQ1YHa2ZChcz6uyZIkJS+s+qYARXk=
Date:   Tue, 07 Mar 2023 22:22:30 +0000
Subject: [PATCH RFC 1/5] tools/nolibc: add definitions for standard fds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230223-nolibc-stackprotector-v1-1-3e74d81b3f21@weissschuh.net>
References: <20230223-nolibc-stackprotector-v1-0-3e74d81b3f21@weissschuh.net>
In-Reply-To: <20230223-nolibc-stackprotector-v1-0-3e74d81b3f21@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678227756; l=623;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Q1jPkyZPjmkNR+Jyt/fGKq7/BIdQKHocnxXtbPXnLSw=;
 b=k9sQ2zQo0NYNDTEvziF2PQIfuN0V6xMfb7Q1Mjy1kpxg7OsUccF2ZAZUmoqJ0+KzrfoAY2NzZ
 +mLkLpw/h3IAnWIF+tu2OHFTiVb2tr4DISmA/JJGeea/cY4teLpfhYk
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
2.39.2

