Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD3F3F7FDD
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Aug 2021 03:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbhHZB1h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Aug 2021 21:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237144AbhHZB1g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Aug 2021 21:27:36 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CC8C0613C1
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Aug 2021 18:26:50 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id a10so1568647qka.12
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Aug 2021 18:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wCMESC09DMuVqDRtZN4Rgv4o7FUGs82VSyG8NO9Wyd0=;
        b=oW/3pp7SXxrXxk6tUWU3MF4PNh3HbPXN91MBLf7YHqTMilELcJW0AbYgnEdo4F2SH/
         XE9ypcl1J0kboAKZY7bXhA/7uLF2G4bds+7skpmZvzAOhPgiZ4nAN91DH5EY6HlJ5qGD
         fpvgP46peWZYDbQ1sRRY8ZQzVnJq8lnnI2vR8OoBZ5hqmujBBIKkdnJs3msabIc1mCNu
         Byhp/RDdaiXn3eyfmnaTU13C9QPCPDPDm5EYpGcs6eXDxq9V0nUei4DsNbKLDC9e++en
         rgSA7fm44/frDY1ufPeIXAnqEXV0HYl2FjpPY/nIU07B3whnqz8k8Z1dmMi82JO1BPrM
         Ttjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wCMESC09DMuVqDRtZN4Rgv4o7FUGs82VSyG8NO9Wyd0=;
        b=IVNO3DG9BTuOhSAIwPuXK6jkMtDcGUf0E88Xph3rtCxO734vHurt0oKNJ1vJ+ena2q
         aG/23YwOK95TG7C8cpR2yo5dYp7cjl40jr1JH8I1LEXofwdYqNH7CfrBO26yVqrMb2a3
         hmaSSv0qFAz70gsiDjk4eo+XjHo2BeRIGPO+WtxnC5eKYISPaCb04DEz0dmTa8DhrR+T
         o/9Z7y/hyCQBkrp8Krl4cgsL9J/hXfhm1fQKhjVuSqV6mkcspCYqQtFhD9a72uuRhocH
         I9eqToUAlsyduiqrLQS4RKihiu+b4O3hLWKnEJRykJlr+A3oQgOXvQfvP3xnujG0tX2+
         vlOA==
X-Gm-Message-State: AOAM531yyRXhj1bDlmGpS5UmftN1Igsu78hf9PMH3tHXL+qPhyvR9hZ4
        i/HoX0UEKf5FGmhbIZfd7/nTmg==
X-Google-Smtp-Source: ABdhPJwMvwKJejA2bQALADkWTdAgTTn5mx5zJKHWPnllMw0ezDOfMmEvx1neARFfMH/DzSToOZoxuA==
X-Received: by 2002:a37:db0a:: with SMTP id e10mr1466514qki.259.1629941209278;
        Wed, 25 Aug 2021 18:26:49 -0700 (PDT)
Received: from aehse.localdomain (177-209-76-11.user3p.veloxzone.com.br. [177.209.76.11])
        by smtp.gmail.com with ESMTPSA id p123sm1375053qke.94.2021.08.25.18.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 18:26:48 -0700 (PDT)
From:   Isabella Basso <isabellabdoamaral@usp.br>
To:     linux@sciencehorizons.net, geert@linux-m68k.org
Cc:     ferreiraenzoa@gmail.com, augusto.duraes33@gmail.com,
        brendanhiggins@google.com, dlatypov@google.com,
        davidgow@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        ~lkcamp/patches@lists.sr.ht, rodrigosiqueiramelo@gmail.com,
        Isabella Basso <isabellabdoamaral@usp.br>
Subject: [PATCH 4/6] test_hash.c: split test_hash_init
Date:   Wed, 25 Aug 2021 22:26:24 -0300
Message-Id: <20210826012626.1163705-5-isabellabdoamaral@usp.br>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210826012626.1163705-1-isabellabdoamaral@usp.br>
References: <20210826012626.1163705-1-isabellabdoamaral@usp.br>
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

Signed-off-by: Isabella Basso <isabellabdoamaral@usp.br>
---
 lib/test_hash.c | 65 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 54 insertions(+), 11 deletions(-)

diff --git a/lib/test_hash.c b/lib/test_hash.c
index ed75c768c231..c168823b0963 100644
--- a/lib/test_hash.c
+++ b/lib/test_hash.c
@@ -152,8 +152,37 @@ test_int_hash(unsigned long long h64)
 	return true;
 }
 
-static int __init
-test_hash_init(void)
+static int __init test_string_or(void)
+{
+	char buf[SIZE+1];
+	int i, j;
+	u32 h0;
+
+	string_or = 0;
+	fill_buf(buf, SIZE, 1);
+
+	/* Test every possible non-empty substring in the buffer. */
+	for (j = SIZE; j > 0; j--) {
+		buf[j] = '\0';
+
+		for (i = 0; i <= j; i++) {
+			h0 = full_name_hash(buf+i, buf+i, j-i);
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
 {
 	char buf[SIZE+1];
 	unsigned tests = 0;
@@ -186,7 +215,6 @@ test_hash_init(void)
 				return -EINVAL;
 			}
 
-			string_or |= h0;
 			h64 = h64 << 32 | h0;	/* For use with hash_64 */
 			if (!test_int_hash(h64))
 				return -EINVAL;
@@ -194,12 +222,6 @@ test_hash_init(void)
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
@@ -231,6 +253,13 @@ test_hash_init(void)
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
@@ -246,10 +275,24 @@ test_hash_init(void)
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

