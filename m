Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA70B3F7FD9
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Aug 2021 03:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbhHZB1a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Aug 2021 21:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236644AbhHZB13 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Aug 2021 21:27:29 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FACC0613C1
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Aug 2021 18:26:43 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id c10so1579457qko.11
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Aug 2021 18:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hDuUPantBA5RaLY4chr+boj+alaUK90TOLcT8GmDFog=;
        b=xUDBsaZhosklBFsDMllxdJ1Q26GXuAW0BjjO05dH7OLOQ+RGuXZZ/EVLO8aUiDtRPr
         aaKGrjzokz6zBfJzWr8GXkX0ztaQwn51TQ5o6Tkx/D6xCmsfOgvHYlIXAm5tGQbbD52u
         7dfBn3OOgA0Q8AYGaoy25OSC5YELbHCTXr1DBnseakkBcWFL4A9Is9PaUBMbLePupTlQ
         Au8uNHPI3pVZJzCeqwlF8MUXRrdDxwMIOJkYdYW0Nm12YOg+w8G8kOyy6u8O0NNKd5Bn
         K2lyZpXmBpYYyMSjcNlCzNh/bo4AgubB+gqcXl44q1MzPNHYBbqJAZer1E/f8V2gi13q
         hM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hDuUPantBA5RaLY4chr+boj+alaUK90TOLcT8GmDFog=;
        b=UU8hAk9sLNkJP9T9CURdLa0ii/0rXYS7pqllPWtpe1QRx9mKfP5quAwtGO4DXcvSMO
         pvc34YLhxDupbZB7kK6Nxlxt4aYCPQ/xio8Ix13vTLHcbckGMXH1dwJjXhXBxdFjGmSl
         hGYgzuB0d/0qKO9DPyG6Vze93g4MkjEm26TAMdO8qaajxug/y3j240YLGNS9+BdT5xwt
         jydSn0vNPDjkqjXDxIEh0A3RQAXskCRXXiputlgEtlhV7/InqWXq/MgG5IUkPaiTV3wE
         mCA3sKmYBnp1Xwnyo1/KotL0MpzP0bDcbLWGSyRpT09jOBVGgbvj2NZqLN5XEoIAbrud
         MMsQ==
X-Gm-Message-State: AOAM530CkgSm+HB9wEgsgM5JCkhieqT/LtKf8qtmYAGz6GehrOtpW2GM
        TyPDao3nOFg55yhpLgIBowBYfw==
X-Google-Smtp-Source: ABdhPJwqTbJbzCjOHPPOzcZvtSF1x/eVVApq71pKqGyGJ+LPxko/qgdrJcm3zVtAoKzhv0rWSdr3Zw==
X-Received: by 2002:a37:2f47:: with SMTP id v68mr1485643qkh.190.1629941202408;
        Wed, 25 Aug 2021 18:26:42 -0700 (PDT)
Received: from aehse.localdomain (177-209-76-11.user3p.veloxzone.com.br. [177.209.76.11])
        by smtp.gmail.com with ESMTPSA id p123sm1375053qke.94.2021.08.25.18.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 18:26:42 -0700 (PDT)
From:   Isabella Basso <isabellabdoamaral@usp.br>
To:     linux@sciencehorizons.net, geert@linux-m68k.org
Cc:     ferreiraenzoa@gmail.com, augusto.duraes33@gmail.com,
        brendanhiggins@google.com, dlatypov@google.com,
        davidgow@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        ~lkcamp/patches@lists.sr.ht, rodrigosiqueiramelo@gmail.com,
        Isabella Basso <isabellabdoamaral@usp.br>
Subject: [PATCH 2/6] test_hash.c: move common definitions to top of file
Date:   Wed, 25 Aug 2021 22:26:22 -0300
Message-Id: <20210826012626.1163705-3-isabellabdoamaral@usp.br>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210826012626.1163705-1-isabellabdoamaral@usp.br>
References: <20210826012626.1163705-1-isabellabdoamaral@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Keep function signatures minimal by making common definitions static.
This does not change any behavior.

Signed-off-by: Isabella Basso <isabellabdoamaral@usp.br>
---
 lib/test_hash.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/lib/test_hash.c b/lib/test_hash.c
index d4b0cfdb0377..8bcc645a7294 100644
--- a/lib/test_hash.c
+++ b/lib/test_hash.c
@@ -23,6 +23,11 @@
 #include <linux/stringhash.h>
 #include <linux/printk.h>
 
+#define SIZE 256 /* Run time is cubic in SIZE */
+
+static u32 string_or; /* stores or-ed string output */
+static u32 hash_or[2][33] = { { 0, } }; /* stores or-ed hash output */
+
 /* 32-bit XORSHIFT generator.  Seed must not be zero. */
 static u32 __init __attribute_const__
 xorshift(u32 seed)
@@ -66,7 +71,7 @@ fill_buf(char *buf, size_t len, u32 seed)
  * recompile and re-test the module without rebooting.
  */
 static bool __init
-test_int_hash(unsigned long long h64, u32 hash_or[2][33])
+test_int_hash(unsigned long long h64)
 {
 	int k;
 	u32 h0 = (u32)h64, h1, h2;
@@ -123,17 +128,15 @@ test_int_hash(unsigned long long h64, u32 hash_or[2][33])
 	return true;
 }
 
-#define SIZE 256	/* Run time is cubic in SIZE */
-
 static int __init
 test_hash_init(void)
 {
 	char buf[SIZE+1];
-	u32 string_or = 0, hash_or[2][33] = { { 0, } };
 	unsigned tests = 0;
 	unsigned long long h64 = 0;
 	int i, j;
 
+	string_or = 0;
 	fill_buf(buf, SIZE, 1);
 
 	/* Test every possible non-empty substring in the buffer. */
@@ -161,7 +164,7 @@ test_hash_init(void)
 
 			string_or |= h0;
 			h64 = h64 << 32 | h0;	/* For use with hash_64 */
-			if (!test_int_hash(h64, hash_or))
+			if (!test_int_hash(h64))
 				return -EINVAL;
 			tests++;
 		} /* i */
-- 
2.33.0

