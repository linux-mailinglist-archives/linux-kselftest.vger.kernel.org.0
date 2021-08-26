Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F403F7FDB
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Aug 2021 03:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbhHZB1d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Aug 2021 21:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236929AbhHZB1d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Aug 2021 21:27:33 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8C7C061757
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Aug 2021 18:26:46 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d2so1159450qto.6
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Aug 2021 18:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IxYlFUnO2M/nJ6H1WkLFPoOltR5Vzxqh9iu0B7vvtZA=;
        b=woMw9BiquP1EK/cXNQYpXU0Mb1189T6DikI6OOQ84d8epoIXxt3B4ke5WIKCN5jaEZ
         WnCMAF5N/O7vihOw6ZIwk8UrX2XTEFxLRczUCm6jq5STkkCM8dl5BoQ2kBah4flBqJ5L
         n+KH+o7lAaDVf3zEfplHAdSPVmtegiOpoLThI7y7G0U+GQ82O1ewFWSvvPskwMuNEMXO
         p/sc0e8bXsKDI4HBPuqwz7Tpa9L77ACtMIDHuJ/4r9QVy7hoMfHC2vwj8n5wTJ9JBfu6
         r4eeYDNkfZJz51IQxtFSIxAMh/vfzasczh22JC4yQ3wqgc6tSI6AqFYD4WWxXsHOyr4a
         eGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IxYlFUnO2M/nJ6H1WkLFPoOltR5Vzxqh9iu0B7vvtZA=;
        b=mo2lyT8RnZ1HMuj+x2dQ/VSwOvHDq795s68ND7Pg5vAYiwXD2xggx2AOxhCFyWSj/z
         WxyuhC9P2XjzgJA8asAKIaZNn8NWUV9bfsT7V1fozjUT/LAQ0sOll6UJZ0kRuZGk5ZbY
         aUdlJN9ADPorkuYKyOpEJrG59sqOj7z7RoRRroUCnh7208+JdpTZESKl0YQ+Re1d/MEr
         D+Wi/OpxUzt50b6lfEsMhz1EWnSdAyGGqHl9yRIeBhBOV0rvGuzsOw4kyPeknWo1d9+f
         jASeGaL21UxVg4hA7RpFD+6Y5xfoltCVr6w7rN9xMKpvErHXte1jGN3gFe9+C/tCITyj
         5J1g==
X-Gm-Message-State: AOAM531tbsigYPV3EH8+52kWoShFD5+9fB+YzJPenAaN8Dd7fAnIzTQR
        q7deTD6Wt8XnG0fEqHlOOL3rXw==
X-Google-Smtp-Source: ABdhPJyrBem87bGdjjuLn/kOSVNJnDmrCcbf/Ep2216b7ltoapwkVqmAXevAJ4qlxanFD5lmQnP2Rg==
X-Received: by 2002:ac8:4cca:: with SMTP id l10mr1117500qtv.70.1629941205855;
        Wed, 25 Aug 2021 18:26:45 -0700 (PDT)
Received: from aehse.localdomain (177-209-76-11.user3p.veloxzone.com.br. [177.209.76.11])
        by smtp.gmail.com with ESMTPSA id p123sm1375053qke.94.2021.08.25.18.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 18:26:45 -0700 (PDT)
From:   Isabella Basso <isabellabdoamaral@usp.br>
To:     linux@sciencehorizons.net, geert@linux-m68k.org
Cc:     ferreiraenzoa@gmail.com, augusto.duraes33@gmail.com,
        brendanhiggins@google.com, dlatypov@google.com,
        davidgow@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        ~lkcamp/patches@lists.sr.ht, rodrigosiqueiramelo@gmail.com,
        Isabella Basso <isabellabdoamaral@usp.br>
Subject: [PATCH 3/6] test_hash.c: split test_int_hash into arch-specific functions
Date:   Wed, 25 Aug 2021 22:26:23 -0300
Message-Id: <20210826012626.1163705-4-isabellabdoamaral@usp.br>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210826012626.1163705-1-isabellabdoamaral@usp.br>
References: <20210826012626.1163705-1-isabellabdoamaral@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Split the The test_int_hash function to keep its mainloop separate from
arch-specific chunks, which are only compiled as needed. This aims at
improving readability.

Signed-off-by: Isabella Basso <isabellabdoamaral@usp.br>
---
 lib/test_hash.c | 84 +++++++++++++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 30 deletions(-)

diff --git a/lib/test_hash.c b/lib/test_hash.c
index 8bcc645a7294..ed75c768c231 100644
--- a/lib/test_hash.c
+++ b/lib/test_hash.c
@@ -61,6 +61,45 @@ fill_buf(char *buf, size_t len, u32 seed)
 	}
 }
 
+#ifdef HAVE_ARCH__HASH_32
+static bool __init
+test_int_hash32(u32 *h0, u32 *h1, u32 *h2)
+{
+	hash_or[1][0] |= *h2 = __hash_32_generic(h0);
+#if HAVE_ARCH__HASH_32 == 1
+	if (*h1 != *h2) {
+		pr_err("__hash_32(%#x) = %#x != __hash_32_generic() = %#x",
+		       *h0, *h1, *h2);
+		return false;
+	}
+#endif
+	return true;
+}
+#endif
+
+#ifdef HAVE_ARCH_HASH_64
+static bool __init
+test_int_hash64(unsigned long long h64, u32 *h0, u32 *h1, u32 *h2, u32 const *m, int k)
+{
+	*h2 = hash_64_generic(*h64, *k);
+#if HAVE_ARCH_HASH_64 == 1
+	if (*h1 != *h2) {
+		pr_err("hash_64(%#llx, %d) = %#x != hash_64_generic() = %#x",
+		       *h64, *k, *h1, *h2);
+		return false;
+	}
+#else
+	if (*h2 > *m) {
+		pr_err("hash_64_generic(%#llx, %d) = %#x > %#x",
+		       *h64, *k, *h1, *m);
+		return false;
+	}
+#endif
+	return true;
+
+}
+#endif
+
 /*
  * Test the various integer hash functions.  h64 (or its low-order bits)
  * is the integer to hash.  hash_or accumulates the OR of the hash values,
@@ -74,19 +113,17 @@ static bool __init
 test_int_hash(unsigned long long h64)
 {
 	int k;
-	u32 h0 = (u32)h64, h1, h2;
+	u32 h0 = (u32)h64, h1;
+
+#if defined HAVE_ARCH__HASH_32 || defined HAVE_ARCH_HASH_64
+	u32 h2;
+#endif
 
 	/* Test __hash32 */
 	hash_or[0][0] |= h1 = __hash_32(h0);
 #ifdef HAVE_ARCH__HASH_32
-	hash_or[1][0] |= h2 = __hash_32_generic(h0);
-#if HAVE_ARCH__HASH_32 == 1
-	if (h1 != h2) {
-		pr_err("__hash_32(%#x) = %#x != __hash_32_generic() = %#x",
-			h0, h1, h2);
+	if (!test_int_hash32(&h0, &h1, &h2))
 		return false;
-	}
-#endif
 #endif
 
 	/* Test k = 1..32 bits */
@@ -107,24 +144,11 @@ test_int_hash(unsigned long long h64)
 			return false;
 		}
 #ifdef HAVE_ARCH_HASH_64
-		h2 = hash_64_generic(h64, k);
-#if HAVE_ARCH_HASH_64 == 1
-		if (h1 != h2) {
-			pr_err("hash_64(%#llx, %d) = %#x != hash_64_generic() "
-				"= %#x", h64, k, h1, h2);
+		if (!test_int_hash64(&h64, &h0, &h1, &h2, &m, &k))
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
 
@@ -150,15 +174,15 @@ test_hash_init(void)
 			/* Check that hashlen_string gets the length right */
 			if (hashlen_len(hashlen) != j-i) {
 				pr_err("hashlen_string(%d..%d) returned length"
-					" %u, expected %d",
-					i, j, hashlen_len(hashlen), j-i);
+				       " %u, expected %d",
+				       i, j, hashlen_len(hashlen), j-i);
 				return -EINVAL;
 			}
 			/* Check that the hashes match */
 			if (hashlen_hash(hashlen) != h0) {
 				pr_err("hashlen_string(%d..%d) = %08x != "
-					"full_name_hash() = %08x",
-					i, j, hashlen_hash(hashlen), h0);
+				       "full_name_hash() = %08x",
+				       i, j, hashlen_hash(hashlen), h0);
 				return -EINVAL;
 			}
 
@@ -178,14 +202,14 @@ test_hash_init(void)
 	}
 	if (~hash_or[0][0]) {
 		pr_err("OR of all __hash_32 results = %#x != %#x",
-			hash_or[0][0], -1u);
+		       hash_or[0][0], -1u);
 		return -EINVAL;
 	}
 #ifdef HAVE_ARCH__HASH_32
 #if HAVE_ARCH__HASH_32 != 1	/* Test is pointless if results match */
 	if (~hash_or[1][0]) {
 		pr_err("OR of all __hash_32_generic results = %#x != %#x",
-			hash_or[1][0], -1u);
+		       hash_or[1][0], -1u);
 		return -EINVAL;
 	}
 #endif
@@ -197,12 +221,12 @@ test_hash_init(void)
 
 		if (hash_or[0][i] != m) {
 			pr_err("OR of all hash_32(%d) results = %#x "
-				"(%#x expected)", i, hash_or[0][i], m);
+			       "(%#x expected)", i, hash_or[0][i], m);
 			return -EINVAL;
 		}
 		if (hash_or[1][i] != m) {
 			pr_err("OR of all hash_64(%d) results = %#x "
-				"(%#x expected)", i, hash_or[1][i], m);
+			       "(%#x expected)", i, hash_or[1][i], m);
 			return -EINVAL;
 		}
 	}
-- 
2.33.0

