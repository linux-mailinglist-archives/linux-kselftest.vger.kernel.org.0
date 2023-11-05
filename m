Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A3E7E1323
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Nov 2023 12:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjKELfL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Nov 2023 06:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjKELfJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Nov 2023 06:35:09 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB05EB;
        Sun,  5 Nov 2023 03:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1699184102;
        bh=bfoswv7ncWkCUqW4AE0EZoLtlErB+6knnnYOlA24mFg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ggObUooOsP16O4x6BewBPKt6dbJAKMDPCMukaNrJQ4tPmNjjhReY/M/3h2igCqr9e
         8QDP9goT7oeZIGARnHqLn5ovBLbsZDsGMGdu0gdHzujocpCrT2c2D4SvmTm8BtFWmq
         HZob2QtRpfTDqOfB4RWC1qBbqcLoN1DTldflgf14=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Sun, 05 Nov 2023 12:34:58 +0100
Subject: [PATCH v2 1/6] tools/nolibc: error out on unsupported architecture
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231105-nolibc-mips-be-v2-1-4ec993cb5407@weissschuh.net>
References: <20231105-nolibc-mips-be-v2-0-4ec993cb5407@weissschuh.net>
In-Reply-To: <20231105-nolibc-mips-be-v2-0-4ec993cb5407@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699184102; l=839;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=bfoswv7ncWkCUqW4AE0EZoLtlErB+6knnnYOlA24mFg=;
 b=h1P8i1kDOIISeYbFLfzWqMLh6zBFs5DBo7Ec2xs4xRvaX+LTXzcXL3OdniFMrew7OO+bp1Vbg
 4liZd88i89SDABWH8QxgfHjGsWri5e7JtAdVORS/QKYZtWAg8u/Az5q
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When an architecture is unsupported arch.h would silently continue.
This leads to a lot of followup errors because my_syscallX() is not
defined and the startup code is missing.

Avoid these confusing errors and fail the build early with a clear
error message and location.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/arch.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/nolibc/arch.h b/tools/include/nolibc/arch.h
index e276fb0680af..2f72ccac0378 100644
--- a/tools/include/nolibc/arch.h
+++ b/tools/include/nolibc/arch.h
@@ -33,6 +33,8 @@
 #include "arch-s390.h"
 #elif defined(__loongarch__)
 #include "arch-loongarch.h"
+#else
+#error Unsupported Architecture
 #endif
 
 #endif /* _NOLIBC_ARCH_H */

-- 
2.42.1

