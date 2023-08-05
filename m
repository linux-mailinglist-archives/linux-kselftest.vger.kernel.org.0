Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5693B770E81
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 09:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjHEHib (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Aug 2023 03:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjHEHiY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Aug 2023 03:38:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADFB4ECF;
        Sat,  5 Aug 2023 00:38:23 -0700 (PDT)
Received: from localhost.localdomain (unknown [59.103.216.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3EB806607185;
        Sat,  5 Aug 2023 08:38:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691221102;
        bh=UmWF0qHTyv99gRWrKc/RIKIQrxbiZuVbIzpCSN6FSQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=atrGqXMkN+AtgaNplVz8DosvXtTQLxvnPv6S7gEywfe7Yl9DxAHK3eJleCEBTrpxQ
         WcPmdngzo86rHUEOBQDv6pvp10teM/l7wAR/W96KJig68hE+48MdmHmuPzvEWiQ9zd
         QcQUtGMyO4UAX4QKD9mFfXkcaAg5EdTty90hexbeMpO6abnqn1W5xIc4ID5s5ql7xo
         LmFDdOthx5fcw05nnpejQS/WDIqy7/giDdj0cdmypYXLt8Vt0wLNez5ZB1dlZwlq9g
         vAav1GB1G0jiYOgRx9vJ9+UD0f6+F+czLS9P8ao/dXBHmpPa4UYQ7/4DqHrekTmgjM
         7P/tYUZhoUqBg==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Shuah Khan <shuah@kernel.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     kernel@collabora.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] selftests: core: remove duplicate defines
Date:   Sat,  5 Aug 2023 12:38:01 +0500
Message-Id: <20230805073809.1753462-3-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230805073809.1753462-1-usama.anjum@collabora.com>
References: <20230805073809.1753462-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
2.39.2

