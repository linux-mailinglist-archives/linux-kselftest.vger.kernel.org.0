Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FEC66155F
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Jan 2023 14:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbjAHNJG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Jan 2023 08:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbjAHNJE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Jan 2023 08:09:04 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578C0E0E3;
        Sun,  8 Jan 2023 05:09:03 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id 511CC7E620;
        Sun,  8 Jan 2023 13:09:00 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1673183343;
        bh=BkTOpKaeNmCPtwR5gdbSfSfyuS5UVBZalGi2xnE4O5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eh0Im5rcVgJFsn2ZqWo2DlFB+1XVzMxra2IAlJYERRLmSqhH2kD6xTK8HbjB6BVoq
         nnN6JWRc9C2kuLI/eopi8YCmLv/m5SsSLx8xuykCNibQinJFa1DujMzQfMV1Os/vT1
         77VBdcPucXhcnYczofXccucb54mA612bmJ5AtM+tgCwOZwhk8edTlqXlIVD5Ht47I4
         qTU1PWGYdOy3TBk22UCfca9JUKJXzIEzF06qIGv7tlZmPFSMj8TmeK1sKGXjZ/VbEc
         /ffJSQGD92W6peLuP5V5MZvgtMAPCa4XqbLZWPgiMKfJ2Hp6Ixtet/1zk268+nflvk
         un5+VyWnEviDA==
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
Subject: [PATCH v1 1/3] nolibc/stdlib: Implement `getauxval(3)` function
Date:   Sun,  8 Jan 2023 20:08:50 +0700
Message-Id: <20230108130853.840948-2-ammar.faizi@intel.com>
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

Previous commits save the address of the auxiliary vector into a global
variable @_auxv. This commit creates a new function 'getauxval()' as a
helper function to get the auxv value based on the given key.

The behavior of this function is identic with the function documented
in 'man 3 getauxval'. This function is also needed to implement
'getpagesize()' function that we will wire up in the next patches.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/include/nolibc/stdlib.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index 92378c4b9660..cdca557c4013 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -12,6 +12,7 @@
 #include "types.h"
 #include "sys.h"
 #include "string.h"
+#include <linux/auxvec.h>
 
 struct nolibc_heap {
 	size_t	len;
@@ -108,6 +109,32 @@ char *getenv(const char *name)
 	return _getenv(name, environ);
 }
 
+static __attribute__((unused))
+unsigned long getauxval(unsigned long type)
+{
+	const unsigned long *auxv = _auxv;
+	unsigned long ret;
+
+	if (!auxv)
+		return 0;
+
+	while (1) {
+		if (!auxv[0] && !auxv[1]) {
+			ret = 0;
+			break;
+		}
+
+		if (auxv[0] == type) {
+			ret = auxv[1];
+			break;
+		}
+
+		auxv += 2;
+	}
+
+	return ret;
+}
+
 static __attribute__((unused))
 void *malloc(size_t len)
 {
-- 
Ammar Faizi

