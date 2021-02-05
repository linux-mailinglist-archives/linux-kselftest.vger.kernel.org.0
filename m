Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8907F311943
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Feb 2021 04:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbhBFDAW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Feb 2021 22:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbhBFCs3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Feb 2021 21:48:29 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BC6C0698C7
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Feb 2021 14:18:15 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id p22so8623915ybc.18
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Feb 2021 14:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=h1P5+j+r2bLJx1bqqHOaKHRT8j4ftFPbzcum8mBY1zk=;
        b=mcx4H+N3Y96PlBfUpR32o2wa1baEWAPMNaY3XlZY1crmU5fmQCozhESwTjOkU/6szQ
         vb3P1crJn0ZXVSEpm3F8yGi8GYTvIwa3fEqWnP+j1RFjwWRZ0I38oZWMqRgSW28mCgZD
         NvJeEGce11MQaIgEoSO8uJrph/cHXjKG1VqLZ9TdQx9bBLvrlsC45fEKwoRvDG/B9/5W
         0Ql1PUSJdEFqjORTNZOEU1UNqJQu/tRQvReJpr/c3ProqZuGzClh+PWUXQmucdtxv6nG
         3XD5xFJcS34ePMZIsM8GdhiZftCdjl93l6WFfHPY+SHiCN6m/w2bRhJ9PAbNKEoAuz8G
         617w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=h1P5+j+r2bLJx1bqqHOaKHRT8j4ftFPbzcum8mBY1zk=;
        b=jv8ks6eX2ipfnfn2N6YKt+eYvyEbC2h5siLkOZGxRrFEaCgjRqS00VRCDnnOf/02+d
         oh2CnRwPMU59RUBNgqv6PX+i5RpvEf5yj5UjHmjRjpS6LIvsXeXMHIs89Wmyuiia/+bZ
         WcqAwNDd39EnT0S6r+CqLTlBqE/3gZxFtKK+02dV3bYyqub9XWwmlwLv0QXQMJNHsrOp
         t3qvchKf0Czxio/AC/5FShbeZbGNLjFWLmieiZ8uA5Dm0syFhq//NfKKLmzAWZcQCnGp
         PZtf/MJc8TJRySZ/2IYUNp2fbF/vNCP+tZz4I+bHhhRtuPLTzaHRCYDB8fg8I3rxTIEN
         DgtA==
X-Gm-Message-State: AOAM532PA5F/z/rFqqPIqGhNn9CLYsc8PmMI5j0USZUm9wXVZ98Vkc6K
        5yh0I1H7fSPLau87xAbloQ2Modk3hhNWjg==
X-Google-Smtp-Source: ABdhPJzEjw6yfxHwmlTOg2G4YDHFF0J/qsAiQnvNLMuWgD2tsDsoSSd9DtlGAuAgcOdTUfRL6Co12tiFY7WTHA==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a8b1:128a:69fa:86fb])
 (user=dlatypov job=sendgmr) by 2002:a25:d683:: with SMTP id
 n125mr9741087ybg.256.1612563495011; Fri, 05 Feb 2021 14:18:15 -0800 (PST)
Date:   Fri,  5 Feb 2021 14:18:08 -0800
Message-Id: <20210205221808.1966010-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH] kunit: make KUNIT_EXPECT_STREQ() quote values, don't print literals
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
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
---
 lib/kunit/assert.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index e0ec7d6fed6f..176ef547fa94 100644
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
+	if (text[0] != '\"' || text[len-1] != '\"')
+		return false;
+
+	return strncmp(text+1, value, len-2) == 0;
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

base-commit: 1e0d27fce010b0a4a9e595506b6ede75934c31be
prerequisite-patch-id: 290f8022f30763cbfb6aec969b038a6f60a57482
-- 
2.30.0.478.g8a0d178c01-goog

