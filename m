Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C1846DB38
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 19:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239047AbhLHSlH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 13:41:07 -0500
Received: from mx1.riseup.net ([198.252.153.129]:40958 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231587AbhLHSlH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 13:41:07 -0500
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4J8QrZ51d9zF4qm;
        Wed,  8 Dec 2021 10:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1638988654; bh=xU85wjMNSEVDkBS9H+XSo4qvu66jZoknNGeh8PXl7tc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mqwSl7EU7HFWo2ZwXp5CkqdeqrvKx5V+zvmZQfP3qBuo6YqXIb9uydOmXI9q85UZp
         Jevn/RNLnOjfgTvaqNdqmbMAuLcgEHqQIObigKFOCxsnSso9REjJh4tEGmkqP8+EwI
         iRZ18Pe0JBcgYWsxlAE/tY4WCMEUQZzdoPmaZsWU=
X-Riseup-User-ID: EB1D1D23A81CC9583BD9D88E19F42ACE50AB4DD4D3C4F24208E57F809CDDE2CE
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4J8QrW27Q9z5vcG;
        Wed,  8 Dec 2021 10:37:31 -0800 (PST)
From:   Isabella Basso <isabbasso@riseup.net>
To:     geert@linux-m68k.org, brendanhiggins@google.com,
        dlatypov@google.com, davidgow@google.com,
        akpm@linux-foundation.org, skhan@linuxfoundation.org
Cc:     ferreiraenzoa@gmail.com, augusto.duraes33@gmail.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, ~lkcamp/patches@lists.sr.ht,
        rodrigosiqueiramelo@gmail.com,
        Isabella Basso <isabbasso@riseup.net>
Subject: [PATCH RESEND v3 1/5] hash.h: remove unused define directive
Date:   Wed,  8 Dec 2021 15:37:07 -0300
Message-Id: <20211208183711.390454-2-isabbasso@riseup.net>
In-Reply-To: <20211208183711.390454-1-isabbasso@riseup.net>
References: <20211208183711.390454-1-isabbasso@riseup.net>
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

Reviewed-by: David Gow <davidgow@google.com>
Tested-by: David Gow <davidgow@google.com>
Co-developed-by: Augusto Durães Camargo <augusto.duraes33@gmail.com>
Signed-off-by: Augusto Durães Camargo <augusto.duraes33@gmail.com>
Co-developed-by: Enzo Ferreira <ferreiraenzoa@gmail.com>
Signed-off-by: Enzo Ferreira <ferreiraenzoa@gmail.com>
Signed-off-by: Isabella Basso <isabbasso@riseup.net>
---
Changes since v1:
- As suggested by David Gow:
  1. Reword commit message.

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
2.34.1

