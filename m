Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56E96AF888
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 23:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjCGWXb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 17:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjCGWW6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 17:22:58 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6ECA42F0;
        Tue,  7 Mar 2023 14:22:44 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1678227761;
        bh=9ijO2FgEHSBXBbzWygiIEip5jvfy9mMUKI8xVpKX8BU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=HQMapmLZu3DFMo3y2aAxN0oKW0JLnjw6MjMyhg+HpedyX6XmT7FwQI1NbyYTv3kos
         6dFGhbVW9aRs6omR5vboOXCWZQaw4+EIy1ee9YR9VwKLAGTFuNahcK3KVB/qaPrhyL
         dz2d0kenZMzp33kBwsMixgy0SITa5GKMNHbhsg6c=
Date:   Tue, 07 Mar 2023 22:22:31 +0000
Subject: [PATCH RFC 2/5] tools/nolibc: add helpers for wait() signal exits
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230223-nolibc-stackprotector-v1-2-3e74d81b3f21@weissschuh.net>
References: <20230223-nolibc-stackprotector-v1-0-3e74d81b3f21@weissschuh.net>
In-Reply-To: <20230223-nolibc-stackprotector-v1-0-3e74d81b3f21@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678227756; l=748;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=9ijO2FgEHSBXBbzWygiIEip5jvfy9mMUKI8xVpKX8BU=;
 b=vpKWsWajl/M7+0KFiw/baQYH4JP520fwnOaEho9N3dVnA2bY6euCdM2YAibch+hdm5UuCnlSI
 NEL1+U1CvsUC7oz2VyQIj6NWZEyD1oxW5NgmB8IqRIldGbbHZ6RgNzz
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
 tools/include/nolibc/types.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 10823e5ac44b..aedd7d9e3f64 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -97,6 +97,8 @@
 /* Macros used on waitpid()'s return status */
 #define WEXITSTATUS(status) (((status) & 0xff00) >> 8)
 #define WIFEXITED(status)   (((status) & 0x7f) == 0)
+#define WTERMSIG(status)    ((status) & 0x7f)
+#define WIFSIGNALED(status) ((status) - 1 < 0xff)
 
 /* waitpid() flags */
 #define WNOHANG      1

-- 
2.39.2

