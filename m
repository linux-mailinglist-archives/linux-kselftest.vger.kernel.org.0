Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A6E352FCF
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Apr 2021 21:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbhDBTeE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Apr 2021 15:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBTeD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Apr 2021 15:34:03 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5F2C06178C
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Apr 2021 12:34:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u128so10219728ybf.12
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Apr 2021 12:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xHF/s8OrsJ15AVPyXpZS6JhdjMJzOcNEyfy3Yu65jhM=;
        b=F5jnbBM8S60mkcOKLrNIh/1usiNy8nXCSLOAvkFrbffVTtzuGf7s1GkpJVClZHu9+b
         O5sJiImx6/aghqJoMrmic2ww+4Eu3aNJYkNUleLts1t1sBZDMZb3LaJHhkRFtlfT8C4H
         2erx3mae675vBf88SV3U35e9t3mY2jw5iz1mMJPsExkQwhiGxPnj5DnzlGAfiyWbYty5
         801b6x/HfynOOBw/UtCf/HvMzFl7k/vZ65/JPfEWlZh75bAWbFmgsVAQs7LNR64WNBU6
         iYni/ErtMtLdz0bfEFk3K5bopY1wM+emq5xteqLxORk0v1HIlMbpybDMg8Y/OaFaYHpR
         qDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xHF/s8OrsJ15AVPyXpZS6JhdjMJzOcNEyfy3Yu65jhM=;
        b=Fr5gXkkKnvtBtbPk2Ih9/OeKIU9J9oXDkFU8U4aJYg3h/9peC7FSIbHq6+nz3W14+O
         4F9rl4L1mNYkQTmfVJDPYU9HfpFNNsN2Q4iBXF6xWYR/lZPaTGB/u8AuOzAWq84Qs6Xe
         mKflt1PA5o0Ky3xdF8bzQI30immkldX22PPv8uEjZhA6cQel8eESoErxzqpNWxcYFepT
         9QAZ5I1XvjnbxzpMvgbcXcvJw1dkhpt0/BGK+L4jwm1jd0e+qFQBYTsRao7L5Jv7Q6ed
         +occQByXx1FoU3EDDHqPQ0ZNaL61wkjgz4VPkmayl652976SF1XsciQrJ06NsltqGEeV
         WOXw==
X-Gm-Message-State: AOAM530STRwE+J0qU/3/1KXvio/GLLtpoY6UfnE7rf0kHH+IVpBfCjYb
        +O+1BZoY/icIIPYveVEIU8j6mD6jDJquYA==
X-Google-Smtp-Source: ABdhPJzvl677q/tL1hgsAsv58gY7gLKBADFdMtZX3Y7B/1EsfpPhZJpKBpJS1hULxnYAS73b6ZxqKE4FPNaULg==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:51c4:ce05:b8c5:b26b])
 (user=dlatypov job=sendgmr) by 2002:a25:dc48:: with SMTP id
 y69mr21464784ybe.18.1617392041409; Fri, 02 Apr 2021 12:34:01 -0700 (PDT)
Date:   Fri,  2 Apr 2021 12:33:57 -0700
Message-Id: <20210402193357.819176-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v2] kunit: make KUNIT_EXPECT_STREQ() quote values, don't print literals
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Before:
>  Expected str == "world", but
>      str == hello
>      "world" == world

After:
>  Expected str == "world", but
>      str == "hello"
<we don't need to tell the user that "world" == "world">

Note: like the literal ellision for integers, this doesn't handle the
case of
  KUNIT_EXPECT_STREQ(test, "hello", "world")
since we don't expect it to realistically happen in checked in tests.
(If you really wanted a test to fail, KUNIT_FAIL("msg") exists)

In that case, you'd get:
>  Expected "hello" == "world", but
<output for next failure>

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 lib/kunit/assert.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index e0ec7d6fed6f..27f95c8dc93f 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -156,6 +156,22 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
 }
 EXPORT_SYMBOL_GPL(kunit_binary_ptr_assert_format);
 
+/* Checks if KUNIT_EXPECT_STREQ() args were string literals.
+ * Note: `text` will have ""s where as `value` will not.
+ */
+static bool is_str_literal(const char *text, const char *value)
+{
+	int len;
+
+	len = strlen(text);
+	if (len < 2)
+		return false;
+	if (text[0] != '\"' || text[len - 1] != '\"')
+		return false;
+
+	return strncmp(text + 1, value, len - 2) == 0;
+}
+
 void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 				    struct string_stream *stream)
 {
@@ -168,12 +184,14 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 			  binary_assert->left_text,
 			  binary_assert->operation,
 			  binary_assert->right_text);
-	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %s\n",
-			  binary_assert->left_text,
-			  binary_assert->left_value);
-	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %s",
-			  binary_assert->right_text,
-			  binary_assert->right_value);
+	if (!is_str_literal(binary_assert->left_text, binary_assert->left_value))
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == \"%s\"\n",
+				  binary_assert->left_text,
+				  binary_assert->left_value);
+	if (!is_str_literal(binary_assert->right_text, binary_assert->right_value))
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == \"%s\"",
+				  binary_assert->right_text,
+				  binary_assert->right_value);
 	kunit_assert_print_msg(assert, stream);
 }
 EXPORT_SYMBOL_GPL(kunit_binary_str_assert_format);

base-commit: 1678e493d530e7977cce34e59a86bb86f3c5631e
-- 
2.31.0.208.g409f899ff0-goog

