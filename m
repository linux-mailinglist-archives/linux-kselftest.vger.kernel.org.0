Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57BAD46DB3A
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 19:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239056AbhLHSlL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 13:41:11 -0500
Received: from mx1.riseup.net ([198.252.153.129]:43704 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239050AbhLHSlK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 13:41:10 -0500
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4J8Qrf2vZTzF4qj;
        Wed,  8 Dec 2021 10:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1638988658; bh=3uPo6HhcZma+b2SZCE6eGAf6EwLz6zjJ+fjXMwGYMuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C7/ov5/y3PzF9JBX31ZEbg4wEhDxP2bwOgwCb4U42ukcwgwZE39m40LCwDJ6CZtpk
         gkdon5msBCWleqRFYjb97YxQX0Va2JAWtteUZDuhy3CTCsJhl2qeRNwZwE0ygMTMYD
         BOqD9iNTLkLeHjSiwZgWVidPmRGnw/vhU+hwAJoo=
X-Riseup-User-ID: 2E8CD9D22EFAC51EECBE798E6AE4BD83F021D25F07E3FBED6480509EF1CAED56
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4J8QrZ72D6z5vfh;
        Wed,  8 Dec 2021 10:37:34 -0800 (PST)
From:   Isabella Basso <isabbasso@riseup.net>
To:     geert@linux-m68k.org, brendanhiggins@google.com,
        dlatypov@google.com, davidgow@google.com,
        akpm@linux-foundation.org, skhan@linuxfoundation.org
Cc:     ferreiraenzoa@gmail.com, augusto.duraes33@gmail.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, ~lkcamp/patches@lists.sr.ht,
        rodrigosiqueiramelo@gmail.com,
        Isabella Basso <isabbasso@riseup.net>
Subject: [PATCH RESEND v3 2/5] test_hash.c: split test_int_hash into arch-specific functions
Date:   Wed,  8 Dec 2021 15:37:08 -0300
Message-Id: <20211208183711.390454-3-isabbasso@riseup.net>
In-Reply-To: <20211208183711.390454-1-isabbasso@riseup.net>
References: <20211208183711.390454-1-isabbasso@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Split the test_int_hash function to keep its mainloop separate from
arch-specific chunks, which are only compiled as needed. This aims at
improving readability.

Reviewed-by: David Gow <davidgow@google.com>
Tested-by: David Gow <davidgow@google.com>
Signed-off-by: Isabella Basso <isabbasso@riseup.net>
---
Changes since v2:
- As suggested by David Gow:
  1. Add comments to struct elements.
Changes since v1:
- As suggested by Marco Elver:
  1. Add struct for carrying test variables.

 lib/test_hash.c | 91 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 62 insertions(+), 29 deletions(-)

diff --git a/lib/test_hash.c b/lib/test_hash.c
index d4b0cfdb0377..2b4fe4976cc4 100644
--- a/lib/test_hash.c
+++ b/lib/test_hash.c
@@ -56,6 +56,58 @@ fill_buf(char *buf, size_t len, u32 seed)
 	}
 }
 
+/* Holds most testing variables for the int test. */
+struct test_hash_params {
+        /* Pointer to integer to be hashed. */
+	unsigned long long *h64;
+        /* Low 32-bits of integer to be hashed. */
+	u32 h0;
+        /* Arch-specific hash result. */
+	u32 h1;
+        /* Generic hash result. */
+	u32 h2;
+        /* ORed hashes of given size (in bits). */
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
@@ -69,19 +121,13 @@ static bool __init
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
@@ -89,37 +135,24 @@ test_int_hash(unsigned long long h64, u32 hash_or[2][33])
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
2.34.1

