Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F396C1A4F
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Mar 2023 16:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjCTPuf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Mar 2023 11:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbjCTPtq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Mar 2023 11:49:46 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DFF17CC2;
        Mon, 20 Mar 2023 08:41:22 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1679326880;
        bh=kDTA/21oI749eXgqkTICe/hP0ZrhsZxLs1p4SViVcik=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=IHMVRtWuNIrMjPv+fPIaRco5Zvkm46iZEMI6ff032Rx7DVn3JcRHkI40aVEhiUpsy
         agcXLWUHKr36lnpyCVx1+LYWzWdWQ9LFM7N10AAAvnJueOB77lj6m8qrMbBO23XECS
         8AJ1byM4MDVDKet325db7VjMOdhmzX/dPHJPuXyg=
Date:   Mon, 20 Mar 2023 15:41:02 +0000
Subject: [PATCH v2 2/8] tools/nolibc: add helpers for wait() signal exits
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230223-nolibc-stackprotector-v2-2-4c938e098d67@weissschuh.net>
References: <20230223-nolibc-stackprotector-v2-0-4c938e098d67@weissschuh.net>
In-Reply-To: <20230223-nolibc-stackprotector-v2-0-4c938e098d67@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1679326878; l=748;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=kDTA/21oI749eXgqkTICe/hP0ZrhsZxLs1p4SViVcik=;
 b=7SZUc64snn7Oyq0C6XQf38MIzZwpIuEH3UWa7OMnKFv93KjtsDh0KApaaF2mWdMJT1SQxXq3t
 aao0zmzVnoqBwWiEy8lAX2FS61kHwgkQPySInAqZn+/Z9f20VQ7UHUB
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
2.40.0

