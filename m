Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CE7661597
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Jan 2023 14:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjAHN6Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Jan 2023 08:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjAHN6W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Jan 2023 08:58:22 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E49D2FE;
        Sun,  8 Jan 2023 05:58:21 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id 4E6717E6D0;
        Sun,  8 Jan 2023 13:58:18 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1673186301;
        bh=BkTOpKaeNmCPtwR5gdbSfSfyuS5UVBZalGi2xnE4O5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tAlpPOYoyNS07iwYSbr6NMlh3VacCe9dxJ1Kx8fm9C2wzb2FnYGDA3QUVNmH7BbtR
         8VwmBFiui5bP7pVX21V8oleWO1KXGsfzhKObTNVxrfsPpnJmLCjLK3VMAGIqqKUXlT
         YvjIByFKXxIbtQB8lmwb9PeXHYGCOFoT3mgNu5zwoepue9YukyCs8sEPLRb86daKuZ
         WaowmigasH6Rz1WCNxvUjCIsMoO6iT2lVvPWcG5xu/EdV1Qn5OrjBvWF9+ODP1/CT5
         oPt2N46aqGW4aqPqQN8LbvXhxSKDnsyamGF9hG+Cw/QqrK2P9967ah1OZsyNKmdT5P
         gyjVvrEFpHuMA==
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
Subject: [RESEND PATCH v1 1/3] nolibc/stdlib: Implement `getauxval(3)` function
Date:   Sun,  8 Jan 2023 20:58:07 +0700
Message-Id: <20230108135809.850210-2-ammar.faizi@intel.com>
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

