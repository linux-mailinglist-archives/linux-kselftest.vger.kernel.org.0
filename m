Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8622418B78
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Sep 2021 00:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhIZWfN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 Sep 2021 18:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhIZWfM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 Sep 2021 18:35:12 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4381C061575
        for <linux-kselftest@vger.kernel.org>; Sun, 26 Sep 2021 15:33:35 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id r16so15002454qtw.11
        for <linux-kselftest@vger.kernel.org>; Sun, 26 Sep 2021 15:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kUt5TY5jxoR7/B2VCpvqew1CInyRkLUynHuODPcVSWc=;
        b=bBK1mOCCuF0ojCMOPOET0V7fdi818uz01r6p+LePmuKT9t2TGV7e+PMGeIG9Sas86O
         rol4fyJtuZ2AaLA8e5QyZT4/J5sIpSjv7l4BVkVmeyqNPNDNFj65ShzTnH6vnc2XziIM
         oeqhyo3ujd4f+9v8BvOqO+3KRtGwyhJlSK/tHSfYZBTku9GmUcKWzGwewMHU0R+BAJah
         UFaJZJQiac/m5LkI9cH/EalifrnyMhLUba7Hrqxy1r9otnPn2PIMTRbc5+77b5547WjP
         w5Zbbg9vPgjkhkFPgWy5TGQ74g/353Y82o4ZDuKZgPLEtW8yyYEkPN1F0ouMmUOerHd3
         ur4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kUt5TY5jxoR7/B2VCpvqew1CInyRkLUynHuODPcVSWc=;
        b=eFEUnu9X/oGG+G2sTocj0QSJYIw3xEWLNsOdP5VyY0B0d5EylOE8LIeKLpIvw955aA
         hZ7yrNNBnMjAcCBO0b/k/3CSQvKZIbJ5EQyVRRhoSOObREa6YdWiY18QRxFtIr3yPTxA
         MTzGmTia0jx4HF9MVW9kB0IHVmBIhP/n9EPzMyzvFOh5LVI6ywX5uVehBH/E8eQRBY/G
         ZTh7BJwHFCKyhBp14nLTufr5Gq/T9glseOW2jN1Ml9MGZKkw/TKcGPBX4f2nPKw8CaoL
         8JM4t+tntoYzV/FGFlMX8gwftLJt9fRfshbzxcBjxrXBaD5DR+8mys0yCujryAtouY+m
         8J0Q==
X-Gm-Message-State: AOAM533g0LGfbmkCbH4uVF//n/Gi5rFEekg8VYSOMkSFKx7eUR4OMdA8
        p74T0rW8jyIMRSWytqZ9k7XBSA==
X-Google-Smtp-Source: ABdhPJzRi7N+ZiAGSZlIVaM4SqwBQxiuNoAmGO4UcTMRGleEiMd63IVnCo83DeIACvJ8V2LvtBY05A==
X-Received: by 2002:ac8:146:: with SMTP id f6mr8682544qtg.46.1632695614965;
        Sun, 26 Sep 2021 15:33:34 -0700 (PDT)
Received: from aehse.localdomain ([2804:d41:bd1c:9100:f2e1:f671:7a83:1eb8])
        by smtp.gmail.com with ESMTPSA id x6sm7244151qts.79.2021.09.26.15.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 15:33:34 -0700 (PDT)
From:   Isabella Basso <isabellabdoamaral@usp.br>
To:     geert@linux-m68k.org
Cc:     ferreiraenzoa@gmail.com, augusto.duraes33@gmail.com,
        brendanhiggins@google.com, dlatypov@google.com,
        davidgow@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        ~lkcamp/patches@lists.sr.ht, rodrigosiqueiramelo@gmail.com,
        Isabella Basso <isabellabdoamaral@usp.br>
Subject: [PATCH v2 2/5] test_hash.c: split test_int_hash into arch-specific functions
Date:   Sun, 26 Sep 2021 19:33:19 -0300
Message-Id: <20210926223322.848641-3-isabellabdoamaral@usp.br>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210926223322.848641-1-isabellabdoamaral@usp.br>
References: <20210926223322.848641-1-isabellabdoamaral@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Split the test_int_hash function to keep its mainloop separate from
arch-specific chunks, which are only compiled as needed. This aims at
improving readability.

Tested-by: David Gow <davidgow@google.com>
Signed-off-by: Isabella Basso <isabellabdoamaral@usp.br>
---
 lib/test_hash.c | 86 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 57 insertions(+), 29 deletions(-)

diff --git a/lib/test_hash.c b/lib/test_hash.c
index d4b0cfdb0377..08fe63776c4f 100644
--- a/lib/test_hash.c
+++ b/lib/test_hash.c
@@ -56,6 +56,53 @@ fill_buf(char *buf, size_t len, u32 seed)
 	}
 }
 
+/* Holds most testing variables for the int test */
+struct test_hash_params {
+	unsigned long long *h64;
+	u32 h0;
+	u32 h1;
+	u32 h2;
+	u32 (*hash_or)[33];
+};
+
+#ifdef HAVE_ARCH__HASH_32
+static bool __init
+test_int__hash_32(struct test_hash_params *params)
+{
+	params->hash_or[1][0] |= params->h2 = __hash_32_generic(params->h0);
+#if HAVE_ARCH__HASH_32 == 1
+	if (params->h1 != params->h2) {
+		pr_err("__hash_32(%#x) = %#x != __hash_32_generic() = %#x",
+		       params->h0, params->h1, params->h2);
+		return false;
+	}
+#endif
+	return true;
+}
+#endif
+
+#ifdef HAVE_ARCH_HASH_64
+static bool __init
+test_int_hash_64(struct test_hash_params *params, u32 const *m, int *k)
+{
+	params->h2 = hash_64_generic(*params->h64, *k);
+#if HAVE_ARCH_HASH_64 == 1
+	if (params->h1 != params->h2) {
+		pr_err("hash_64(%#llx, %d) = %#x != hash_64_generic() = %#x",
+		       *params->h64, *k, params->h1, params->h2);
+		return false;
+	}
+#else
+	if (params->h2 > *m) {
+		pr_err("hash_64_generic(%#llx, %d) = %#x > %#x",
+		       *params->h64, *k, params->h1, *m);
+		return false;
+	}
+#endif
+	return true;
+}
+#endif
+
 /*
  * Test the various integer hash functions.  h64 (or its low-order bits)
  * is the integer to hash.  hash_or accumulates the OR of the hash values,
@@ -69,19 +116,13 @@ static bool __init
 test_int_hash(unsigned long long h64, u32 hash_or[2][33])
 {
 	int k;
-	u32 h0 = (u32)h64, h1, h2;
+	struct test_hash_params params = { &h64, (u32)h64, 0, 0, hash_or };
 
 	/* Test __hash32 */
-	hash_or[0][0] |= h1 = __hash_32(h0);
+	hash_or[0][0] |= params.h1 = __hash_32(params.h0);
 #ifdef HAVE_ARCH__HASH_32
-	hash_or[1][0] |= h2 = __hash_32_generic(h0);
-#if HAVE_ARCH__HASH_32 == 1
-	if (h1 != h2) {
-		pr_err("__hash_32(%#x) = %#x != __hash_32_generic() = %#x",
-			h0, h1, h2);
+	if (!test_int__hash_32(&params))
 		return false;
-	}
-#endif
 #endif
 
 	/* Test k = 1..32 bits */
@@ -89,37 +130,24 @@ test_int_hash(unsigned long long h64, u32 hash_or[2][33])
 		u32 const m = ((u32)2 << (k-1)) - 1;	/* Low k bits set */
 
 		/* Test hash_32 */
-		hash_or[0][k] |= h1 = hash_32(h0, k);
-		if (h1 > m) {
-			pr_err("hash_32(%#x, %d) = %#x > %#x", h0, k, h1, m);
+		hash_or[0][k] |= params.h1 = hash_32(params.h0, k);
+		if (params.h1 > m) {
+			pr_err("hash_32(%#x, %d) = %#x > %#x", params.h0, k, params.h1, m);
 			return false;
 		}
 
 		/* Test hash_64 */
-		hash_or[1][k] |= h1 = hash_64(h64, k);
-		if (h1 > m) {
-			pr_err("hash_64(%#llx, %d) = %#x > %#x", h64, k, h1, m);
+		hash_or[1][k] |= params.h1 = hash_64(h64, k);
+		if (params.h1 > m) {
+			pr_err("hash_64(%#llx, %d) = %#x > %#x", h64, k, params.h1, m);
 			return false;
 		}
 #ifdef HAVE_ARCH_HASH_64
-		h2 = hash_64_generic(h64, k);
-#if HAVE_ARCH_HASH_64 == 1
-		if (h1 != h2) {
-			pr_err("hash_64(%#llx, %d) = %#x != hash_64_generic() "
-				"= %#x", h64, k, h1, h2);
+		if (!test_int_hash_64(&params, &m, &k))
 			return false;
-		}
-#else
-		if (h2 > m) {
-			pr_err("hash_64_generic(%#llx, %d) = %#x > %#x",
-				h64, k, h1, m);
-			return false;
-		}
-#endif
 #endif
 	}
 
-	(void)h2;	/* Suppress unused variable warning */
 	return true;
 }
 
-- 
2.33.0

