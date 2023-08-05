Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F7C770E86
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 09:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjHEHj2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Aug 2023 03:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjHEHjH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Aug 2023 03:39:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C565592;
        Sat,  5 Aug 2023 00:38:45 -0700 (PDT)
Received: from localhost.localdomain (unknown [59.103.216.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 321B166071AB;
        Sat,  5 Aug 2023 08:38:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691221123;
        bh=4K168XhtWURZ6JEq6/gnWN5amqD8CeZn6UF+Ktx7Q20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A74+WQJ/WMODJfBalTyPaAa6GodeMw339LFqEmP4CeJ/6BboV/8J+rpjplbyYsiJZ
         1Za/TOXWRIumCHlFWFQmaqlGWGBwu0ay2UmP314XlpovQfG06uTA3qbpR40YEa4Ryn
         BU4u8JuSkLgg5QaMOTM6J6NazqR9rznUe6Xc2jhHYFx9GdxmMs30scpV35XlZ5nnhK
         K7giYk+HzPm758h83+syov82tH52Hs8qx/oV/M6x3RaHMzFFc7X2rsuMIB5Z9hhY1X
         KPZY/NxOx4lmxiBtMfNJhH28b2O0SSWd9r4KYI/f4trW/iXj4OtJ0BpGoKFk1It1vY
         waW74pbtMBiLg==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
        Shuah Khan <shuah@kernel.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 6/6] selftests: futex: remove duplicate unneeded defines
Date:   Sat,  5 Aug 2023 12:38:04 +0500
Message-Id: <20230805073809.1753462-6-usama.anjum@collabora.com>
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

Kselftests are kernel tests and must be build with kernel headers from
same source version. These duplicate defines should automatically
picked up from kernel headers. Use KHDR_INCLUDES to add kernel header
files.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 .../selftests/futex/include/futextest.h       | 22 -------------------
 1 file changed, 22 deletions(-)

diff --git a/tools/testing/selftests/futex/include/futextest.h b/tools/testing/selftests/futex/include/futextest.h
index ddbcfc9b7bac4..59f66af3a6d10 100644
--- a/tools/testing/selftests/futex/include/futextest.h
+++ b/tools/testing/selftests/futex/include/futextest.h
@@ -25,28 +25,6 @@
 typedef volatile u_int32_t futex_t;
 #define FUTEX_INITIALIZER 0
 
-/* Define the newer op codes if the system header file is not up to date. */
-#ifndef FUTEX_WAIT_BITSET
-#define FUTEX_WAIT_BITSET		9
-#endif
-#ifndef FUTEX_WAKE_BITSET
-#define FUTEX_WAKE_BITSET		10
-#endif
-#ifndef FUTEX_WAIT_REQUEUE_PI
-#define FUTEX_WAIT_REQUEUE_PI		11
-#endif
-#ifndef FUTEX_CMP_REQUEUE_PI
-#define FUTEX_CMP_REQUEUE_PI		12
-#endif
-#ifndef FUTEX_WAIT_REQUEUE_PI_PRIVATE
-#define FUTEX_WAIT_REQUEUE_PI_PRIVATE	(FUTEX_WAIT_REQUEUE_PI | \
-					 FUTEX_PRIVATE_FLAG)
-#endif
-#ifndef FUTEX_REQUEUE_PI_PRIVATE
-#define FUTEX_CMP_REQUEUE_PI_PRIVATE	(FUTEX_CMP_REQUEUE_PI | \
-					 FUTEX_PRIVATE_FLAG)
-#endif
-
 /**
  * futex() - SYS_futex syscall wrapper
  * @uaddr:	address of first futex
-- 
2.39.2

