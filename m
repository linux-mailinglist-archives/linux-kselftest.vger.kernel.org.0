Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3797C661560
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Jan 2023 14:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbjAHNJL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Jan 2023 08:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbjAHNJH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Jan 2023 08:09:07 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98614E0DB;
        Sun,  8 Jan 2023 05:09:06 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id 983C37E628;
        Sun,  8 Jan 2023 13:09:03 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1673183346;
        bh=wcpOgJmHUqHilg+MA55c94wnAlyf9zHTIyYePnjiqNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mx/Xe7FhOkcuArrKQHu6u/K/TjrZoxtV4AR+gBCpIGXKcfnZJHJpd2DmIq9rTkOlJ
         RqhTS4k4aZBBeX6ADB4YEVp4986EGTbRBSSqqVf4zGpVRd6JNrFytLDDbvzf8qCDg5
         8lbpzqw2lUNsIMI/hKKfSAyfBduTAGhvFMehg6y25k9nta+4pjdMFWn1pAWinkhaNv
         oLY5uBb1AfYrGZ49vWE25Pld8EuTL9wueKlETlwNGDh1i782vFyB/jkJBSK2QAXjZg
         RrDmba4jpQdT8mT+wg7FgI2aInbMT21yIzldX1kgSJ/jpliABapUBGH3FqLtpLHnTa
         qb2e5OBnzhJOw==
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
Subject: [PATCH v1 2/3] nolibc/sys: Implement `getpagesize(2)` function
Date:   Sun,  8 Jan 2023 20:08:51 +0700
Message-Id: <20230108130853.840948-3-ammar.faizi@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230108130853.840948-1-ammar.faizi@intel.com>
References: <20221222035134.3467659-1-ammar.faizi@intel.com> <20221222043452.GB29086@1wt.eu> <20221222134615.3535422-1-ammar.faizi@intel.com> <20221227062640.GA5337@1wt.eu> <00eee75f-59fa-83b2-c7e1-f0da347b2dde@gnuweeb.org> <20221227184902.GA6287@1wt.eu> <23e84c59-4f2c-01b4-5b8a-80af39a1d761@gnuweeb.org> <20221228133513.GA7457@1wt.eu> <39d68044-2641-75da-929a-f5e852f0a3d0@gnuweeb.org> <CAOG64qOT6wa+ShCuV3wM0QYy6TBOYap8xoAbUBU5DM_bhdafYg@mail.gmail.com> <20230103035427.GA4474@1wt.eu> <086ff43d-2647-0459-d993-6fc90d7ae779@gnuweeb.org>
 <20230108130853.840948-1-ammar.faizi@intel.com>
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

