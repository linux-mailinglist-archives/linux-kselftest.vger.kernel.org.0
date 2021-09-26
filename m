Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7F0418B76
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Sep 2021 00:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhIZWfK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 Sep 2021 18:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbhIZWfJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 Sep 2021 18:35:09 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A276FC061604
        for <linux-kselftest@vger.kernel.org>; Sun, 26 Sep 2021 15:33:32 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id p4so34958393qki.3
        for <linux-kselftest@vger.kernel.org>; Sun, 26 Sep 2021 15:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Q+Zwc1UmptFHFCp3do8ZAFH6U/asPSa4z2xxfPXQY4=;
        b=RPQAPTY69QTPdzNYdpfCmv5/li8GSQzn4OtxJan3goHFLc0xZJsKPvOHAGZsCE+nVI
         KziNHcKG7dZ/IuS/6Ibe+IyvA1VWHhNSeH/EyuaK5a7LTQPtAlKYraCB5lVFQfU0wgKO
         wzSISW7x/nE/+8e0Lx2cptZcTK2bOX6/vtihW2nQZ4HylJjfMC0dQPSyN8sdEp6VJZQM
         DYugnKhqoFVDgxv1vo2ICnvYia+itJ3qb3l5SoKvE6cVuhx6fGQnFJVemB88EEYgSQiy
         40nxBy6hOikxVSBPj/1RVDZq+tsPcnpKDkpcifvMzjk6hPSNIicBsi3GLj0yHxERt/mz
         qrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Q+Zwc1UmptFHFCp3do8ZAFH6U/asPSa4z2xxfPXQY4=;
        b=J/sa89CHTpd6vqrwxJTUecjKzaCIUxNaE8+qQxtA3dxrX0J/YyUOztho/zgiZFve28
         lek+ZGdo1vRlZaTihHw1kzPN9aDM0c5Uus/rMS2PN6uyGwfKeldy8fieR4QKz1KK+VWh
         nvqGJeo9sSNGWrq56aG2j849QV/fHHoLYhL3B3OAYv//b/1taZY+V2dQvHOtgAOmNdyL
         O9nDMh7VPkFOJe4D2ztjgq7cCf/l/j18c49GQK3vTMhQvO70VTe2M0KeCW/HtlVceUbZ
         8oFeZwIPoSjwLaJAqqKv30PsVdeayncfUJUA41uHzgxALJWTVjHXFpAMX/MzyheSSb9n
         szJw==
X-Gm-Message-State: AOAM533oUvfoaDKyHedaspt3cwIBnrTjdJiGwK+pVVAhbZQ+fKE1qdLk
        +9vg1OztSP7Gt/1Rg1hkkNw8qA==
X-Google-Smtp-Source: ABdhPJxyg/gztpPiYQXGkdPKM6MC9UDiEktCMoFa4x4TSwg8Yevs8V+tb/HIyBuhHaNXwQzXAx/fFQ==
X-Received: by 2002:a37:356:: with SMTP id 83mr20911111qkd.110.1632695611793;
        Sun, 26 Sep 2021 15:33:31 -0700 (PDT)
Received: from aehse.localdomain ([2804:d41:bd1c:9100:f2e1:f671:7a83:1eb8])
        by smtp.gmail.com with ESMTPSA id x6sm7244151qts.79.2021.09.26.15.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 15:33:31 -0700 (PDT)
From:   Isabella Basso <isabellabdoamaral@usp.br>
To:     geert@linux-m68k.org
Cc:     ferreiraenzoa@gmail.com, augusto.duraes33@gmail.com,
        brendanhiggins@google.com, dlatypov@google.com,
        davidgow@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        ~lkcamp/patches@lists.sr.ht, rodrigosiqueiramelo@gmail.com,
        Isabella Basso <isabellabdoamaral@usp.br>
Subject: [PATCH v2 1/5] hash.h: remove unused define directive
Date:   Sun, 26 Sep 2021 19:33:18 -0300
Message-Id: <20210926223322.848641-2-isabellabdoamaral@usp.br>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210926223322.848641-1-isabellabdoamaral@usp.br>
References: <20210926223322.848641-1-isabellabdoamaral@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, there exist hash_32() and __hash_32() functions, which were
introduced in a patch [1] targeting architecture specific optimizations.
These functions can be overridden on a per-architecture basis to achieve
such optimizations. They must set their corresponding define directive
(HAVE_ARCH_HASH_32 and HAVE_ARCH__HASH_32, respectively) so that header
files can deal with these overrides properly.

As the supported 32-bit architectures that have their own hash function
implementation (i.e. m68k, Microblaze, H8/300, pa-risc) have only been
making use of the (more general) __hash_32() function (which only lacks
a right shift operation when compared to the hash_32() function),
remove the define directive corresponding to the arch-specific hash_32()
implementation.

[1] https://lore.kernel.org/lkml/20160525073311.5600.qmail@ns.sciencehorizons.net/

Changes since v1:
- As suggested by David Gow:
  1. Reword commit message.

Tested-by: David Gow <davidgow@google.com>
Co-developed-by: Augusto Durães Camargo <augusto.duraes33@gmail.com>
Signed-off-by: Augusto Durães Camargo <augusto.duraes33@gmail.com>
Co-developed-by: Enzo Ferreira <ferreiraenzoa@gmail.com>
Signed-off-by: Enzo Ferreira <ferreiraenzoa@gmail.com>
Signed-off-by: Isabella Basso <isabellabdoamaral@usp.br>
---
 include/linux/hash.h       |  5 +----
 lib/test_hash.c            | 24 +-----------------------
 tools/include/linux/hash.h |  5 +----
 3 files changed, 3 insertions(+), 31 deletions(-)

diff --git a/include/linux/hash.h b/include/linux/hash.h
index ad6fa21d977b..38edaa08f862 100644
--- a/include/linux/hash.h
+++ b/include/linux/hash.h
@@ -62,10 +62,7 @@ static inline u32 __hash_32_generic(u32 val)
 	return val * GOLDEN_RATIO_32;
 }
 
-#ifndef HAVE_ARCH_HASH_32
-#define hash_32 hash_32_generic
-#endif
-static inline u32 hash_32_generic(u32 val, unsigned int bits)
+static inline u32 hash_32(u32 val, unsigned int bits)
 {
 	/* High bits are more random, so use them. */
 	return __hash_32(val) >> (32 - bits);
diff --git a/lib/test_hash.c b/lib/test_hash.c
index 0ee40b4a56dd..d4b0cfdb0377 100644
--- a/lib/test_hash.c
+++ b/lib/test_hash.c
@@ -94,22 +94,7 @@ test_int_hash(unsigned long long h64, u32 hash_or[2][33])
 			pr_err("hash_32(%#x, %d) = %#x > %#x", h0, k, h1, m);
 			return false;
 		}
-#ifdef HAVE_ARCH_HASH_32
-		h2 = hash_32_generic(h0, k);
-#if HAVE_ARCH_HASH_32 == 1
-		if (h1 != h2) {
-			pr_err("hash_32(%#x, %d) = %#x != hash_32_generic() "
-				" = %#x", h0, k, h1, h2);
-			return false;
-		}
-#else
-		if (h2 > m) {
-			pr_err("hash_32_generic(%#x, %d) = %#x > %#x",
-				h0, k, h1, m);
-			return false;
-		}
-#endif
-#endif
+
 		/* Test hash_64 */
 		hash_or[1][k] |= h1 = hash_64(h64, k);
 		if (h1 > m) {
@@ -227,13 +212,6 @@ test_hash_init(void)
 #else
 	pr_info("__hash_32() has no arch implementation to test.");
 #endif
-#ifdef HAVE_ARCH_HASH_32
-#if HAVE_ARCH_HASH_32 != 1
-	pr_info("hash_32() is arch-specific; not compared to generic.");
-#endif
-#else
-	pr_info("hash_32() has no arch implementation to test.");
-#endif
 #ifdef HAVE_ARCH_HASH_64
 #if HAVE_ARCH_HASH_64 != 1
 	pr_info("hash_64() is arch-specific; not compared to generic.");
diff --git a/tools/include/linux/hash.h b/tools/include/linux/hash.h
index ad6fa21d977b..38edaa08f862 100644
--- a/tools/include/linux/hash.h
+++ b/tools/include/linux/hash.h
@@ -62,10 +62,7 @@ static inline u32 __hash_32_generic(u32 val)
 	return val * GOLDEN_RATIO_32;
 }
 
-#ifndef HAVE_ARCH_HASH_32
-#define hash_32 hash_32_generic
-#endif
-static inline u32 hash_32_generic(u32 val, unsigned int bits)
+static inline u32 hash_32(u32 val, unsigned int bits)
 {
 	/* High bits are more random, so use them. */
 	return __hash_32(val) >> (32 - bits);
-- 
2.33.0

