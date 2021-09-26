Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0786F418B7A
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Sep 2021 00:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhIZWfQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 Sep 2021 18:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhIZWfQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 Sep 2021 18:35:16 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38231C061575
        for <linux-kselftest@vger.kernel.org>; Sun, 26 Sep 2021 15:33:39 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id p4so34958594qki.3
        for <linux-kselftest@vger.kernel.org>; Sun, 26 Sep 2021 15:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=keB75pA8tqWnwI9BXtLybyOviHEmwePg0jqXukti5H0=;
        b=YkNS0cUGVRMRN4pM13cbUzfkfYkN+S5ChWWvDx9U9VzL0puW6p85QqS4nMvhw2K9/8
         GD+38B2lvKd1u/X6Q6dr7pa2IXt9/a+LvIJK/dkb37GdQh5x48/3wiUeIldiBC7J2m7S
         W1S60u65asCW5aSIBjt8koryzI21oZ7k+ppRnT/GRz9E1E9BpIo0T1ciUO82M4OwVRdO
         YVwauef4oPuZ1SFOOVKvK/OlwPx4ZKkv0BA7i9AKXQxEgijpUYCPZR6tRNK8FVhEz5HE
         nxX8LvQGVzkF0lBcIJ+aIqXUQT7pU149pCCNQ3yqBOofuujtF0VFxNl56SjyEKfr42cB
         k6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=keB75pA8tqWnwI9BXtLybyOviHEmwePg0jqXukti5H0=;
        b=vpvAk3Xyz46moekpAmYab0pnXiBo7ix8gKdLkE5Me5Ah+RLbZRJHcDiHUliSXrCUfr
         aT9EJ85RrELIN3imFPlGFjF4NfLSKUUaBj0jmTNJXWlzxcmN2eikfM1GyUZErJDa0iRK
         /RZ1hWKBV2FW21wPW8WkaoWe6bxOptbn9dS4O2DJDQMhbl8s6yxqnNBEC692o5vP7hfv
         ZsbKN1N3duqH9nSlhw5FB88lbJjCaRScQlJrzIoE7ufNF+Fr6f/BxC5LR3pn8TzrTe6L
         s0f6vpJZlR6KYFXuYkTaOI73ihSiowoV0l5nZ+WQiovnIdnO+r6t6t4hmMxXpQv5taG/
         Gq7Q==
X-Gm-Message-State: AOAM533ZrLvIjIc+J7OenJ+IkZGzmWPlm8HCe/FwxVhQ2vaTU0Sm2fPu
        R64dEKpS3pGRKxvUWoRAA5KskA==
X-Google-Smtp-Source: ABdhPJwCEzMCikARt8F/wU9Zl9tIuNx7l/U0w/ossc8f/G7oN3wq7egq/zGtwMdjtF8G6oePDDJO/Q==
X-Received: by 2002:a37:716:: with SMTP id 22mr20662271qkh.99.1632695618422;
        Sun, 26 Sep 2021 15:33:38 -0700 (PDT)
Received: from aehse.localdomain ([2804:d41:bd1c:9100:f2e1:f671:7a83:1eb8])
        by smtp.gmail.com with ESMTPSA id x6sm7244151qts.79.2021.09.26.15.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 15:33:38 -0700 (PDT)
From:   Isabella Basso <isabellabdoamaral@usp.br>
To:     geert@linux-m68k.org
Cc:     ferreiraenzoa@gmail.com, augusto.duraes33@gmail.com,
        brendanhiggins@google.com, dlatypov@google.com,
        davidgow@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        ~lkcamp/patches@lists.sr.ht, rodrigosiqueiramelo@gmail.com,
        Isabella Basso <isabellabdoamaral@usp.br>
Subject: [PATCH v2 3/5] test_hash.c: split test_hash_init
Date:   Sun, 26 Sep 2021 19:33:20 -0300
Message-Id: <20210926223322.848641-4-isabellabdoamaral@usp.br>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210926223322.848641-1-isabellabdoamaral@usp.br>
References: <20210926223322.848641-1-isabellabdoamaral@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Split up test_hash_init so that it calls each test more explicitly
insofar it is possible without rewriting the entire file. This aims at
improving readability.

Split tests performed on string_or as they don't interfere with those
performed in hash_or. Also separate pr_info calls about skipped tests as
they're not part of the tests themselves, but only warn about
(un)defined arch-specific hash functions.

Changes since v1:
- As suggested by David Gow:
  1. Rename arch-specific test functions.
  2. Remove spare whitespace changes.
- As suggested by Marco Elver:
  1. Add struct for carrying test variables.

Tested-by: David Gow <davidgow@google.com>
Signed-off-by: Isabella Basso <isabellabdoamaral@usp.br>
---
 lib/test_hash.c | 66 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 54 insertions(+), 12 deletions(-)

diff --git a/lib/test_hash.c b/lib/test_hash.c
index 08fe63776c4f..db9dd18b4e8b 100644
--- a/lib/test_hash.c
+++ b/lib/test_hash.c
@@ -153,11 +153,39 @@ test_int_hash(unsigned long long h64, u32 hash_or[2][33])
 
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
@@ -187,7 +215,6 @@ test_hash_init(void)
 				return -EINVAL;
 			}
 
-			string_or |= h0;
 			h64 = h64 << 32 | h0;	/* For use with hash_64 */
 			if (!test_int_hash(h64, hash_or))
 				return -EINVAL;
@@ -195,12 +222,6 @@ test_hash_init(void)
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
@@ -232,6 +253,13 @@ test_hash_init(void)
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
@@ -247,10 +275,24 @@ test_hash_init(void)
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
2.33.0

