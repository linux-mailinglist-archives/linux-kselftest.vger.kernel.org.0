Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC816D3803
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Apr 2023 15:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjDBNCy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Apr 2023 09:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjDBNCx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Apr 2023 09:02:53 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8E811151;
        Sun,  2 Apr 2023 06:02:52 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1680440570;
        bh=WpL7AHZ/RVZDepQeqXUZNCLzamt9+Jfw6eToN9dbdkk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=pqdHX2/ysrjGil1F8CJvU3kSvvN0g51gBI/jMf8KQ4eq3O07Q8BlWw5rQbWTK1s5M
         3mAp4bMylFffDG/R2qBr/qyl+k4BxdsIPiizR1qawC3fxjPIWrmYdmz+Kef8gdziqB
         +N8jnnbecQC/IkFE2c1eKXoNQDh/T0qFoBwromJQ=
Date:   Sun, 02 Apr 2023 13:02:45 +0000
Subject: [PATCH v2 1/3] tools/nolibc: add wrapper for memfd_create
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230328-nolibc-printf-test-v2-1-f72bdf210190@weissschuh.net>
References: <20230328-nolibc-printf-test-v2-0-f72bdf210190@weissschuh.net>
In-Reply-To: <20230328-nolibc-printf-test-v2-0-f72bdf210190@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680440570; l=1058;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=WpL7AHZ/RVZDepQeqXUZNCLzamt9+Jfw6eToN9dbdkk=;
 b=fZuToNS5fW3RpPlq3PQshf/DvtoGs9y00jV2XPNuT/mGd1z22og9U2HDGMtjzWtGJ6g3OOfdY
 DdkW1Gy8q4WDjOB5w5x31JvvBmMvRSbTf+Ks9TVWkkiFA1yUAoF/WXp
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is useful for users and will also be used by a future testcase.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/sys.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 5d624dc63a42..bea9760dbd16 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -1365,6 +1365,29 @@ ssize_t write(int fd, const void *buf, size_t count)
 	return ret;
 }
 
+
+/*
+ * int memfd_create(const char *name, unsigned int flags);
+ */
+
+static __attribute__((unused))
+int sys_memfd_create(const char *name, unsigned int flags)
+{
+	return my_syscall2(__NR_memfd_create, name, flags);
+}
+
+static __attribute__((unused))
+int memfd_create(const char *name, unsigned int flags)
+{
+	ssize_t ret = sys_memfd_create(name, flags);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
 /* make sure to include all global symbols */
 #include "nolibc.h"
 

-- 
2.40.0

