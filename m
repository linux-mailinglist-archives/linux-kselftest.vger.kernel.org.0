Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E518661598
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Jan 2023 14:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjAHN60 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Jan 2023 08:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbjAHN6Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Jan 2023 08:58:25 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5935D2FF;
        Sun,  8 Jan 2023 05:58:24 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id AF84E7E6D5;
        Sun,  8 Jan 2023 13:58:21 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1673186304;
        bh=wcpOgJmHUqHilg+MA55c94wnAlyf9zHTIyYePnjiqNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EFXZkn/3XD4yXC9/kl1H5fo6KHZ5WXwvEzPwVJRY+oy6THg+LUcgqGZqjedoPNQVP
         TPFcc8x8q2Om7FZ24wCiusqC9yie+y+0U8H9vZ/vsup2nKBvP1DG7gaAwnM7/K8vXO
         ij5BA5kXIugK5sfb40wRTi6DImcbv+1WPBXy2QtfItgEH+JVpnl8xHqYpUay7jldol
         AiTfAO63d2oM311mt9jRi3n9kqlvtGJTMC5s7p5KZBYtgw6HbN6MEMg+LG8V9Ot9jV
         qmyuorbPFE/2C+bFOJz84vybWBitXC3OjpMOwi2TQgx7RHWePH0HxxXEmG/m6BQbQS
         5zs909NZv8c8w==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
Subject: [RESEND PATCH v1 2/3] nolibc/sys: Implement `getpagesize(2)` function
Date:   Sun,  8 Jan 2023 20:58:08 +0700
Message-Id: <20230108135809.850210-3-ammar.faizi@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230108135809.850210-1-ammar.faizi@intel.com>
References: <20230108135809.850210-1-ammar.faizi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

This function returns the page size used by the running kernel. The
page size value is taken from the auxiliary vector at 'AT_PAGESZ' key.

'getpagesize(2)' is assumed as a syscall becuase the manpage placement
of this function is in entry 2 ('man 2 getpagesize') despite there is
no real 'getpagesize(2)' syscall in the Linux syscall table. Define
this function in 'sys.h'.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---

Side note:
This function calls 'getauxval(3)' function that's defined in
'stdlib.h', but since most functions in 'stdlib.h' needs 'sys.h', the
'sys.h' is always included first. Therefore, we need a forward
declaration of 'getauxval(3)' in sys.h.

 tools/include/nolibc/sys.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 3db1dd8c74ee..acf7cf438010 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -18,6 +18,7 @@
 #include <linux/fs.h>
 #include <linux/loop.h>
 #include <linux/time.h>
+#include <linux/auxvec.h>
 
 #include "arch.h"
 #include "errno.h"
@@ -498,6 +499,26 @@ pid_t gettid(void)
 	return sys_gettid();
 }
 
+static unsigned long getauxval(unsigned long key);
+
+/*
+ * long getpagesize(void);
+ */
+
+static __attribute__((unused))
+long getpagesize(void)
+{
+	long ret;
+
+	ret = getauxval(AT_PAGESZ);
+	if (!ret) {
+		SET_ERRNO(ENOENT);
+		return -1;
+	}
+
+	return ret;
+}
+
 
 /*
  * int gettimeofday(struct timeval *tv, struct timezone *tz);
-- 
Ammar Faizi

