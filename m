Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D85743F2BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Oct 2021 00:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhJ1Wec (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Oct 2021 18:34:32 -0400
Received: from mx1.riseup.net ([198.252.153.129]:55034 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231298AbhJ1Wec (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Oct 2021 18:34:32 -0400
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4HgKry0gw5zF2qM;
        Thu, 28 Oct 2021 15:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1635459954; bh=1jvLTlqGRu0TJnki2C8LiadfnqaSajWb0fYooId00EA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YIfX07socbns0LVFCjSfMo6A77IVxaXeMXqknPi/qUTNZYibFT4YT8rH7ZEZA1cg8
         IHYKISketkNNhrUZXT9l7pEGX9+Bi7eteMhXMW94caLnNBmIWn2Dt4/FbT8r4rtZ/C
         dN6hSqnex3pyaPYJjZwD+TBNGAB0kBVnORAiAY2w=
X-Riseup-User-ID: A94EC2BC6246647A26E5BC4558F50C76D4C007D1060112DAB446E745C22724EA
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4HgKrt11XWz5vvd;
        Thu, 28 Oct 2021 15:25:49 -0700 (PDT)
From:   Isabella Basso <isabbasso@riseup.net>
To:     geert@linux-m68k.org
Cc:     ferreiraenzoa@gmail.com, augusto.duraes33@gmail.com,
        brendanhiggins@google.com, dlatypov@google.com,
        davidgow@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        ~lkcamp/patches@lists.sr.ht, rodrigosiqueiramelo@gmail.com,
        akpm@linux-foundation.org, skhan@linuxfoundation.org,
        Isabella Basso <isabellabdoamaral@usp.br>,
        Isabella Basso <isabbasso@riseup.net>
Subject: [PATCH v3 3/5] test_hash.c: split test_hash_init
Date:   Thu, 28 Oct 2021 19:25:31 -0300
Message-Id: <20211028222533.432641-4-isabbasso@riseup.net>
In-Reply-To: <20211028222533.432641-1-isabbasso@riseup.net>
References: <20211028222533.432641-1-isabbasso@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Isabella Basso <isabellabdoamaral@usp.br>

Split up test_hash_init so that it calls each test more explicitly
insofar it is possible without rewriting the entire file. This aims at
improving readability.

Split tests performed on string_or as they don't interfere with those
performed in hash_or. Also separate pr_info calls about skipped tests as
they're not part of the tests themselves, but only warn about
(un)defined arch-specific hash functions.

Reviewed-by: David Gow <davidgow@google.com>
Tested-by: David Gow <davidgow@google.com>
Signed-off-by: Isabella Basso <isabbasso@riseup.net>
---
Changes since v1:
- As suggested by David Gow:
  1. Rename arch-specific test functions.
  2. Remove spare whitespace changes.

 lib/test_hash.c | 66 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 54 insertions(+), 12 deletions(-)

diff --git a/lib/test_hash.c b/lib/test_hash.c
index 2b4fe4976cc4..032849a48da7 100644
--- a/lib/test_hash.c
+++ b/lib/test_hash.c
@@ -158,11 +158,39 @@ test_int_hash(unsigned long long h64, u32 hash_or[2][33])

 #define SIZE 256	/* Run time is cubic in SIZE */

-static int __init
-test_hash_init(void)
+static int __init test_string_or(void)
 {
 	char buf[SIZE+1];
-	u32 string_or = 0, hash_or[2][33] = { { 0, } };
+	u32 string_or = 0;
+	int i, j;
+
+	fill_buf(buf, SIZE, 1);
+
+	/* Test every possible non-empty substring in the buffer. */
+	for (j = SIZE; j > 0; --j) {
+		buf[j] = '\0';
+
+		for (i = 0; i <= j; i++) {
+			u32 h0 = full_name_hash(buf+i, buf+i, j-i);
+
+			string_or |= h0;
+		} /* i */
+	} /* j */
+
+	/* The OR of all the hash values should cover all the bits */
+	if (~string_or) {
+		pr_err("OR of all string hash results = %#x != %#x",
+		       string_or, -1u);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int __init test_hash_or(void)
+{
+	char buf[SIZE+1];
+	u32 hash_or[2][33] = { { 0, } };
 	unsigned tests = 0;
 	unsigned long long h64 = 0;
 	int i, j;
@@ -192,7 +220,6 @@ test_hash_init(void)
 				return -EINVAL;
 			}

-			string_or |= h0;
 			h64 = h64 << 32 | h0;	/* For use with hash_64 */
 			if (!test_int_hash(h64, hash_or))
 				return -EINVAL;
@@ -200,12 +227,6 @@ test_hash_init(void)
 		} /* i */
 	} /* j */

-	/* The OR of all the hash values should cover all the bits */
-	if (~string_or) {
-		pr_err("OR of all string hash results = %#x != %#x",
-			string_or, -1u);
-		return -EINVAL;
-	}
 	if (~hash_or[0][0]) {
 		pr_err("OR of all __hash_32 results = %#x != %#x",
 			hash_or[0][0], -1u);
@@ -237,6 +258,13 @@ test_hash_init(void)
 		}
 	}

+	pr_notice("%u tests passed.", tests);
+
+	return 0;
+}
+
+static void __init notice_skipped_tests(void)
+{
 	/* Issue notices about skipped tests. */
 #ifdef HAVE_ARCH__HASH_32
 #if HAVE_ARCH__HASH_32 != 1
@@ -252,10 +280,24 @@ test_hash_init(void)
 #else
 	pr_info("hash_64() has no arch implementation to test.");
 #endif
+}

-	pr_notice("%u tests passed.", tests);
+static int __init
+test_hash_init(void)
+{
+	int ret;

-	return 0;
+	ret = test_string_or();
+	if (ret < 0)
+		return ret;
+
+	ret = test_hash_or();
+	if (ret < 0)
+		return ret;
+
+	notice_skipped_tests();
+
+	return ret;
 }

 static void __exit test_hash_exit(void)
--
2.33.1

