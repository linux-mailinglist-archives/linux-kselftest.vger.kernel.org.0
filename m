Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F0D7BB4CB
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Oct 2023 12:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjJFKIM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Oct 2023 06:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjJFKIK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Oct 2023 06:08:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D069F;
        Fri,  6 Oct 2023 03:08:08 -0700 (PDT)
Received: from localhost.localdomain (unknown [39.34.184.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 195576612668;
        Fri,  6 Oct 2023 11:08:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696586887;
        bh=4T9UXJjURToNqR+AwgGUF57UmbiY2XyHR2+7wjgiYfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PSdpbnTzRpB4wSE1JUUgxic4WBB0M4IDzSoUqPM1e0KtnWHcUcLoyTN1bBRqaRjEv
         xBCwLaXzupFElpWgiiErGmMiTEoiPGS0NRVaH2uthzINxw524gQg1NJpmA8IYurv5b
         eZdtw+YuF2tR44ThgTxB9d2Y2w1KLo/tFcv8g8vq7JyvwYyl4ebOB1WL7Qao/vANHq
         wnW7W6tM1zJMYKeBpvL7nnEmjxx6/HcxLS649Wj8ZEre7nTZP4AfXcS+OPOxHtpvpB
         sk1bgObTiuDxNeuhO3bPDG/yYhbmrISyimblMQkFdqz2iem4D0FYb87kmUGD19mgq4
         sQqAS8/7puwZg==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Shuah Khan <shuah@kernel.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     kernel@collabora.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] selftests: core: remove duplicate defines
Date:   Fri,  6 Oct 2023 15:07:37 +0500
Message-Id: <20231006100743.1631334-3-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231006100743.1631334-1-usama.anjum@collabora.com>
References: <20231006100743.1631334-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Remove duplicate defines which are already defined in kernel headers and
re-definition isn't required.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 .../testing/selftests/core/close_range_test.c | 28 -------------------
 1 file changed, 28 deletions(-)

diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index 749239930ca83..534576f06df1c 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -16,34 +16,6 @@
 #include "../kselftest_harness.h"
 #include "../clone3/clone3_selftests.h"
 
-#ifndef __NR_close_range
-	#if defined __alpha__
-		#define __NR_close_range 546
-	#elif defined _MIPS_SIM
-		#if _MIPS_SIM == _MIPS_SIM_ABI32	/* o32 */
-			#define __NR_close_range (436 + 4000)
-		#endif
-		#if _MIPS_SIM == _MIPS_SIM_NABI32	/* n32 */
-			#define __NR_close_range (436 + 6000)
-		#endif
-		#if _MIPS_SIM == _MIPS_SIM_ABI64	/* n64 */
-			#define __NR_close_range (436 + 5000)
-		#endif
-	#elif defined __ia64__
-		#define __NR_close_range (436 + 1024)
-	#else
-		#define __NR_close_range 436
-	#endif
-#endif
-
-#ifndef CLOSE_RANGE_UNSHARE
-#define CLOSE_RANGE_UNSHARE	(1U << 1)
-#endif
-
-#ifndef CLOSE_RANGE_CLOEXEC
-#define CLOSE_RANGE_CLOEXEC	(1U << 2)
-#endif
-
 static inline int sys_close_range(unsigned int fd, unsigned int max_fd,
 				  unsigned int flags)
 {
-- 
2.40.1

