Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6467BB49F
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Oct 2023 11:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjJFJ4b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Oct 2023 05:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjJFJ4a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Oct 2023 05:56:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF19AD;
        Fri,  6 Oct 2023 02:56:27 -0700 (PDT)
Received: from localhost.localdomain (unknown [39.34.184.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C78E76612212;
        Fri,  6 Oct 2023 10:56:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696586185;
        bh=cAPdTDO9l0OljwiXmnH2mEX0mLjZo06Oo9SZMhEPWy8=;
        h=From:To:Cc:Subject:Date:From;
        b=id+xbwaR+mi0oM79N7gUk028gNKm6zbI0LnzEC9D9a9zZrVQKy60rY+qf7YhoVVtp
         s5IHS2XvlKSRVaYZCwrqzBnSVCoYgO9aFzN9wadyCL52UXbRol1qRboKogx4OL7LuQ
         fTw2cfFtt1Lw3oERf8lA+P3yesqd5Qf2NAfqBFzJvgdOR9dVUBBd1XthOSoohMCAME
         Xf7bdUN6+ltsEqxNsH6RNEcm4GCMOSxBmY+SY7DFeGCQN1wWmsy3fYECOzu3Eqacof
         II0X9TRVUXpptg3P3cIFSOyQ8O1e1MMMsr60tht9JLRmqKBjhR3os3HphZ3KXqa8Fp
         f+SNBlEPXiyAQ==
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
Subject: [PATCH v2] selftests: futex: remove duplicate unneeded defines
Date:   Fri,  6 Oct 2023 14:55:37 +0500
Message-Id: <20231006095539.1601385-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.40.1
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

Kselftests are kernel tests and must be build with kernel headers from
same source version. The kernel headers are already being included
correctly in futex selftest Makefile with the help of KHDR_INCLUDE. In
this patch, only the dead code is being removed. No functional change is
intended.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v1:
- Make the explanation correct
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
2.40.1

