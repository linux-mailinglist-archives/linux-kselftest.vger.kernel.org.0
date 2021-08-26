Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4790F3F7FD7
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Aug 2021 03:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236055AbhHZB11 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Aug 2021 21:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbhHZB10 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Aug 2021 21:27:26 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EFFC061757
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Aug 2021 18:26:39 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id y144so1633015qkb.6
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Aug 2021 18:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2RDPNDoVhpC2D8PS/iTn00/DSRKBuu8x3HruL1SBfjE=;
        b=jRvHoeR/shoYNO7xRWlI+t8hIou6HrapcCtwwbc1lSSeEu67RhBZapTBJ81wNEhja+
         Lw5A+dDRgKLDZSrCINUcByak6nEBEdQUVkuyu2KqAZA/MP5f/8B0+eRsNlI7X9SUJpXH
         hohPqHarST5l2hMM4K0h9dNaTRRhBGkyBFplNBv6NbOABJ2lKURtGMrvDPo3qQF+FS+y
         xKukq7FuKp8/DiQ+nrdak0UHpo67AZOWW8dbcQjbEQ4ZFdDYdLQYAq7pvNWal/xCm54L
         mm5xx4E5lYV7UZ93y9mSqzxsnvicLjN38+f4IG2RP9tDy0HzxgLtBOChEpFjp1ByJdx8
         Z+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2RDPNDoVhpC2D8PS/iTn00/DSRKBuu8x3HruL1SBfjE=;
        b=Ff8HWGAzPaiHw5kF/dbHxwXFu2pCi2tEzXpIL/D/Bz4qD5i6vqF0JBrAF5OqC6DEkK
         4YrU77CqmGcxdVUffddLWg76hdkpDnPmGKVJjeFIDBtqU5GzRQIH2xNfbw6ALP3DJjzS
         8yGb6qkLL6l79D2e+kSvHE7yQPQx4VYpagzXYaP5khhxInxmcL0pNkn17RIQjOi8kdYo
         Kz1qSy/UlJbujSKtvKLFaimTmmnTSiRBzK5capGaCZoX6QajeQXuAc7mbSVR6ONYRYyz
         YOWsVp6puJK0c+/BO8spvVK2DKfsszy0RaLzl5qO/5Q2KlZLEinaNdODtYh46Y3PFwJX
         OVdg==
X-Gm-Message-State: AOAM530HUq5LqOP7ESzRu2aoxl44FxGFBrbc/fUi0P+YoWiNfIILlzXJ
        /aZUP1xei3iZCh7ZVkw/vHSxFVUxoqFbgLDP
X-Google-Smtp-Source: ABdhPJwxv7Mi2+cX2h1K/u8wARE/mAZlTiRGK+681jGMY9EGTqS3PjqyeQYt64cryNKcFdEk1MCVpA==
X-Received: by 2002:a37:81c2:: with SMTP id c185mr1456849qkd.446.1629941198911;
        Wed, 25 Aug 2021 18:26:38 -0700 (PDT)
Received: from aehse.localdomain (177-209-76-11.user3p.veloxzone.com.br. [177.209.76.11])
        by smtp.gmail.com with ESMTPSA id p123sm1375053qke.94.2021.08.25.18.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 18:26:38 -0700 (PDT)
From:   Isabella Basso <isabellabdoamaral@usp.br>
To:     linux@sciencehorizons.net, geert@linux-m68k.org
Cc:     ferreiraenzoa@gmail.com, augusto.duraes33@gmail.com,
        brendanhiggins@google.com, dlatypov@google.com,
        davidgow@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        ~lkcamp/patches@lists.sr.ht, rodrigosiqueiramelo@gmail.com,
        Isabella Basso <isabellabdoamaral@usp.br>
Subject: [PATCH 1/6] hash.h: remove unused define directive
Date:   Wed, 25 Aug 2021 22:26:21 -0300
Message-Id: <20210826012626.1163705-2-isabellabdoamaral@usp.br>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210826012626.1163705-1-isabellabdoamaral@usp.br>
References: <20210826012626.1163705-1-isabellabdoamaral@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The HAVE_ARCH_HASH_32 (single underscore) define hasn't been used for
any known supported architectures that have their own hash function
implementation (i.e. m68k, Microblaze, H8/300, pa-risc) since George's
patch [1], which introduced it.

The supported 32-bit architectures from the list above have only been
making use of the (more general) HAVE_ARCH__HASH_32 define, which only
lacks the right shift operator, that wasn't targeted for optimizations
so far.

[1] https://lore.kernel.org/lkml/20160525073311.5600.qmail@ns.sciencehorizons.net/

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

