Return-Path: <linux-kselftest+bounces-12164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B9290DA3C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 19:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B4521F23BF0
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 17:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B1714BF92;
	Tue, 18 Jun 2024 17:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2hriqAl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A84143876;
	Tue, 18 Jun 2024 17:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718730229; cv=none; b=rVHcp+3d+6+PiaHDZgsgaoaCo+FbFuUvi9psI6LU9pU8qjuyw031fNG0Nlm+vsGMD2lEsR6D5nhLm3OMOQtWRRC4ZqP57Hu3m70Hl8U7GI6KbDqujkG8Rtm+fzGef8fi0KfikYV6El6L/aWKpog1q5O7KvYezj+Xbk/R/spiphc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718730229; c=relaxed/simple;
	bh=F2uEhNlsy5YIRZK9ZVblnA3E9w/pv0OCIQm4LWWyRDo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bdJmo9pY7d5uPcJub2VBDl28cvkq11m1HU8CYfZfSsanE0vi6YE+bNOaM84pzdb1n+kYCP8bh3z7rzct9LA3n6hl9XDsdD0hk8lxQh7ch0za6Zl/qIBASNXyrq5SHClpM2R17Hqjy1aST3q/n0RJunwdbThKV4j6Vd4rPMzbCs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2hriqAl; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42111cf2706so5362415e9.0;
        Tue, 18 Jun 2024 10:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718730225; x=1719335025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdNuCp1avXNV72JRE5N66bN0h+CLuvMTPgfqEEBLPy0=;
        b=H2hriqAlPg8r1RhiEg4FX25f3xnqk9lidX4J89kyNJJZtAfYkU1pya03O4sMhF9wst
         YweOnBhiYgyZqiwGMgVt2IyKc2cWD6dTnUJNyPl59fqveU5ozwuBUWfeiLtFvi8Jpdz3
         +ehzebfxW7rbOJZzoOyAPOLtBARELw+fnBoeiQuHm1vS7Xwv6Vpb1R6zTXQXiXQGWAIM
         WOkRPXS3cfd4WwvVk1bSquMZQq00x7CU6Q8U3y23cThVknXid+qavOKL0l6Ml/rAR6xJ
         2Mlw3p+c/9AZ8kOK2SAdtyCn6zz0klhw5MxTpLM7emvFBamyR2SuOaPZBsA8lL9goiyM
         AB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718730225; x=1719335025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdNuCp1avXNV72JRE5N66bN0h+CLuvMTPgfqEEBLPy0=;
        b=dIwWm4/ZYC8aNtpP+H1bH3PlbL1BEbKQknet5bdNevHN1eqL9wIc7YtWBPvTieThVT
         MjmXXKrHMs8CtD6DxbaBIClWryoaRyK2r/q8q1LfYYfvJe8T+thFqCWzoWTPaL5ZOucJ
         hJac68JOsRUgT7YDfEFnkL+6rmQW33m86Eo8t5xNnxLxE1Ir/juJPSRkTGxumeSiHlIg
         3LxdRMxGZNgw4iJZyr/5/xqlxco9ela+fZ0pO8Y0FjAyAuutWz9ujfhoyJ/gWqsy5KgY
         pzH9cncWdCv8xj+qN273uWpgKXYDMqUUxx3Dsym40w2V/Fyiwuv8b0XKH6n5hQY8FbW5
         AHMA==
X-Forwarded-Encrypted: i=1; AJvYcCVl5Jb75nL0lNMXWJTRBLqKC3ZoDX65gOgmnpNmH4KgcFUR/615Zoh3Ervxmx0M1nX0NqYt66FQQ41jg8VozKa2CMo7xLaDN4nw4bwZqI+dUk7b5zyBNo8TjPn+QninUm6zOlZfOFt+gyryC/LJ
X-Gm-Message-State: AOJu0YzUm+IyKCj78QT5MJ4oGE9lohMuIdiCCQQDxJBoUnxlftjQs6MS
	Mtsq/fdV2VjlKzzrfvtqXQN4+ED+FAgmZE0WZka/pIV4vx8wpl6s
X-Google-Smtp-Source: AGHT+IHcjyXxJro0gnWzVD1STXuPlWBNbJK2+dmczV2MV0rrbszdDHcweQX3PQCp5KIiN/du9AY6Lw==
X-Received: by 2002:a05:6000:2c3:b0:35f:1b2f:8697 with SMTP id ffacd0b85a97d-363170ed553mr156216f8f.1.1718730225462;
        Tue, 18 Jun 2024 10:03:45 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:9a30:967d:12af:741a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075114dcfsm14526163f8f.114.2024.06.18.10.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 10:03:45 -0700 (PDT)
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: brendan.higgins@linux.dev,
	davidgow@google.com,
	rmoar@google.com
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH v2 4/5] kunit: assert_test: Prepare to be merged into kunit-test.c
Date: Tue, 18 Jun 2024 18:03:30 +0100
Message-Id: <20240618170331.264851-5-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618170331.264851-1-ivan.orlov0322@gmail.com>
References: <20240618170331.264851-1-ivan.orlov0322@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 'kunit_assert_' prefix for 'is_literal' and 'is_str_literal'
functions. This way we will be sure that we are not exporting ambiguous
symbols into the KUnit namespace.

Export these (and other) functions from assert into the KUnit namespace,
so we could use them in the tests (and cover them as well).

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
V1 -> V2:
- Besides exporting the non-static functions from assert.c into the
KUnit namespace, rename some of them as well (add kunit_assert_ prefix
to make their names less ambiguous).

 include/kunit/assert.h  |  4 ++--
 lib/kunit/assert.c      | 19 +++++++++++++------
 lib/kunit/assert_test.c | 40 ++++++++++++++++++++--------------------
 3 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/include/kunit/assert.h b/include/kunit/assert.h
index 7e7490a74b13..3994acc520ae 100644
--- a/include/kunit/assert.h
+++ b/include/kunit/assert.h
@@ -221,8 +221,8 @@ void kunit_mem_assert_format(const struct kunit_assert *assert,
 #if IS_ENABLED(CONFIG_KUNIT)
 void kunit_assert_print_msg(const struct va_format *message,
 			    struct string_stream *stream);
-bool is_literal(const char *text, long long value);
-bool is_str_literal(const char *text, const char *value);
+bool kunit_assert_is_literal(const char *text, long long value);
+bool kunit_assert_is_str_literal(const char *text, const char *value);
 void kunit_assert_hexdump(struct string_stream *stream,
 			  const void *buf,
 			  const void *compared_buf,
diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index 867aa5c4bccf..62b86bf5603e 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -38,6 +38,7 @@ void kunit_assert_print_msg(const struct va_format *message,
 	if (message->fmt)
 		string_stream_add(stream, "\n%pV", message);
 }
+EXPORT_SYMBOL_IF_KUNIT(kunit_assert_print_msg);
 
 void kunit_fail_assert_format(const struct kunit_assert *assert,
 			      const struct va_format *message,
@@ -91,7 +92,8 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
 EXPORT_SYMBOL_GPL(kunit_ptr_not_err_assert_format);
 
 /* Checks if `text` is a literal representing `value`, e.g. "5" and 5 */
-VISIBLE_IF_KUNIT bool is_literal(const char *text, long long value)
+VISIBLE_IF_KUNIT
+bool kunit_assert_is_literal(const char *text, long long value)
 {
 	char *buffer;
 	int len;
@@ -112,6 +114,7 @@ VISIBLE_IF_KUNIT bool is_literal(const char *text, long long value)
 
 	return ret;
 }
+EXPORT_SYMBOL_IF_KUNIT(kunit_assert_is_literal);
 
 void kunit_binary_assert_format(const struct kunit_assert *assert,
 				const struct va_format *message,
@@ -127,12 +130,12 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
 			  binary_assert->text->left_text,
 			  binary_assert->text->operation,
 			  binary_assert->text->right_text);
-	if (!is_literal(binary_assert->text->left_text, binary_assert->left_value))
+	if (!kunit_assert_is_literal(binary_assert->text->left_text, binary_assert->left_value))
 		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld (0x%llx)\n",
 				  binary_assert->text->left_text,
 				  binary_assert->left_value,
 				  binary_assert->left_value);
-	if (!is_literal(binary_assert->text->right_text, binary_assert->right_value))
+	if (!kunit_assert_is_literal(binary_assert->text->right_text, binary_assert->right_value))
 		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld (0x%llx)",
 				  binary_assert->text->right_text,
 				  binary_assert->right_value,
@@ -168,7 +171,8 @@ EXPORT_SYMBOL_GPL(kunit_binary_ptr_assert_format);
 /* Checks if KUNIT_EXPECT_STREQ() args were string literals.
  * Note: `text` will have ""s where as `value` will not.
  */
-VISIBLE_IF_KUNIT bool is_str_literal(const char *text, const char *value)
+VISIBLE_IF_KUNIT
+bool kunit_assert_is_str_literal(const char *text, const char *value)
 {
 	int len;
 
@@ -180,6 +184,7 @@ VISIBLE_IF_KUNIT bool is_str_literal(const char *text, const char *value)
 
 	return strncmp(text + 1, value, len - 2) == 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(kunit_assert_is_str_literal);
 
 void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 				    const struct va_format *message,
@@ -195,11 +200,12 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 			  binary_assert->text->left_text,
 			  binary_assert->text->operation,
 			  binary_assert->text->right_text);
-	if (!is_str_literal(binary_assert->text->left_text, binary_assert->left_value))
+	if (!kunit_assert_is_str_literal(binary_assert->text->left_text, binary_assert->left_value))
 		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == \"%s\"\n",
 				  binary_assert->text->left_text,
 				  binary_assert->left_value);
-	if (!is_str_literal(binary_assert->text->right_text, binary_assert->right_value))
+	if (!kunit_assert_is_str_literal(binary_assert->text->right_text,
+					 binary_assert->right_value))
 		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == \"%s\"",
 				  binary_assert->text->right_text,
 				  binary_assert->right_value);
@@ -232,6 +238,7 @@ void kunit_assert_hexdump(struct string_stream *stream,
 			string_stream_add(stream, " %02x ", buf1[i]);
 	}
 }
+EXPORT_SYMBOL_IF_KUNIT(kunit_assert_hexdump);
 
 void kunit_mem_assert_format(const struct kunit_assert *assert,
 			     const struct va_format *message,
diff --git a/lib/kunit/assert_test.c b/lib/kunit/assert_test.c
index 4a5967712186..4999233180d6 100644
--- a/lib/kunit/assert_test.c
+++ b/lib/kunit/assert_test.c
@@ -11,28 +11,28 @@
 #define ASSERT_TEST_EXPECT_CONTAIN(test, str, substr) KUNIT_EXPECT_TRUE(test, strstr(str, substr))
 #define ASSERT_TEST_EXPECT_NCONTAIN(test, str, substr) KUNIT_EXPECT_FALSE(test, strstr(str, substr))
 
-static void kunit_test_is_literal(struct kunit *test)
+static void kunit_test_assert_is_literal(struct kunit *test)
 {
-	KUNIT_EXPECT_TRUE(test, is_literal("5", 5));
-	KUNIT_EXPECT_TRUE(test, is_literal("0", 0));
-	KUNIT_EXPECT_TRUE(test, is_literal("1234567890", 1234567890));
-	KUNIT_EXPECT_TRUE(test, is_literal("-1234567890", -1234567890));
-	KUNIT_EXPECT_FALSE(test, is_literal("05", 5));
-	KUNIT_EXPECT_FALSE(test, is_literal("", 0));
-	KUNIT_EXPECT_FALSE(test, is_literal("-0", 0));
-	KUNIT_EXPECT_FALSE(test, is_literal("12#45", 1245));
+	KUNIT_EXPECT_TRUE(test, kunit_assert_is_literal("5", 5));
+	KUNIT_EXPECT_TRUE(test, kunit_assert_is_literal("0", 0));
+	KUNIT_EXPECT_TRUE(test, kunit_assert_is_literal("1234567890", 1234567890));
+	KUNIT_EXPECT_TRUE(test, kunit_assert_is_literal("-1234567890", -1234567890));
+	KUNIT_EXPECT_FALSE(test, kunit_assert_is_literal("05", 5));
+	KUNIT_EXPECT_FALSE(test, kunit_assert_is_literal("", 0));
+	KUNIT_EXPECT_FALSE(test, kunit_assert_is_literal("-0", 0));
+	KUNIT_EXPECT_FALSE(test, kunit_assert_is_literal("12#45", 1245));
 }
 
-static void kunit_test_is_str_literal(struct kunit *test)
+static void kunit_test_assert_is_str_literal(struct kunit *test)
 {
-	KUNIT_EXPECT_TRUE(test, is_str_literal("\"Hello, World!\"", "Hello, World!"));
-	KUNIT_EXPECT_TRUE(test, is_str_literal("\"\"", ""));
-	KUNIT_EXPECT_TRUE(test, is_str_literal("\"\"\"", "\""));
-	KUNIT_EXPECT_FALSE(test, is_str_literal("", ""));
-	KUNIT_EXPECT_FALSE(test, is_str_literal("\"", "\""));
-	KUNIT_EXPECT_FALSE(test, is_str_literal("\"Abacaba", "Abacaba"));
-	KUNIT_EXPECT_FALSE(test, is_str_literal("Abacaba\"", "Abacaba"));
-	KUNIT_EXPECT_FALSE(test, is_str_literal("\"Abacaba\"", "\"Abacaba\""));
+	KUNIT_EXPECT_TRUE(test, kunit_assert_is_str_literal("\"Hello, World!\"", "Hello, World!"));
+	KUNIT_EXPECT_TRUE(test, kunit_assert_is_str_literal("\"\"", ""));
+	KUNIT_EXPECT_TRUE(test, kunit_assert_is_str_literal("\"\"\"", "\""));
+	KUNIT_EXPECT_FALSE(test, kunit_assert_is_str_literal("", ""));
+	KUNIT_EXPECT_FALSE(test, kunit_assert_is_str_literal("\"", "\""));
+	KUNIT_EXPECT_FALSE(test, kunit_assert_is_str_literal("\"Abacaba", "Abacaba"));
+	KUNIT_EXPECT_FALSE(test, kunit_assert_is_str_literal("Abacaba\"", "Abacaba"));
+	KUNIT_EXPECT_FALSE(test, kunit_assert_is_str_literal("\"Abacaba\"", "\"Abacaba\""));
 }
 
 KUNIT_DEFINE_ACTION_WRAPPER(kfree_wrapper, kfree, const void *);
@@ -366,8 +366,8 @@ static void kunit_test_mem_assert_format(struct kunit *test)
 }
 
 static struct kunit_case assert_test_cases[] = {
-	KUNIT_CASE(kunit_test_is_literal),
-	KUNIT_CASE(kunit_test_is_str_literal),
+	KUNIT_CASE(kunit_test_assert_is_literal),
+	KUNIT_CASE(kunit_test_assert_is_str_literal),
 	KUNIT_CASE(kunit_test_assert_prologue),
 	KUNIT_CASE(kunit_test_assert_print_msg),
 	KUNIT_CASE(kunit_test_unary_assert_format),
-- 
2.34.1


