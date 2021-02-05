Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBE63118E9
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Feb 2021 03:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhBFCtr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Feb 2021 21:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbhBFCpz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Feb 2021 21:45:55 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53BAC061A28
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Feb 2021 14:14:19 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id e62so8686425yba.5
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Feb 2021 14:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=d5RIDWJchB5lEhG7XVyqeqKAvmcYq4cH2DHTaZwx5/0=;
        b=FpnhHFz3tKFPWcMnsP3l/yAb+F4xtDN9a+EPKrp039W814ze9LgPS2QUt1bLmcn4Bx
         fjWAOs18xxnAHyRbu5jwp5G1XqxPNDGXsCCvAejg73f5vbMd0k1iKljPB2pOTJL+Wewv
         Fa4Fg2soTqDYR6ReE5M3CvB/4t3V2WiYPdNb8xORG7fNtAwge8iisF7XdNoPn/RN/V/y
         hzJND4ecNGC/Xu5xf21WqIcn8LIHawkKlNXC1NxGZy72QVzNdxCxcyfMfkZ74rg1U29m
         p/OKFrWOrTDBpLVDnLSpY0TxTAfhq+PmRP1rZygdoLUIxCcusgjx687xUkRQiTWOWpe7
         ZL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=d5RIDWJchB5lEhG7XVyqeqKAvmcYq4cH2DHTaZwx5/0=;
        b=VdNwOyBitD2LxJofFmMqHnX/mgTt6PZWYqgb+Ub7si+8I1wRlTQIrTD+s4Gvzdz/n+
         0viuiZzLvGg+PXdvQ+BAc6c/jdPv3HbF14EyVtpZQLM3dDLFVmxCsrGkhFgF1xKbTkEI
         C6DTQ6f+Qo4Yl+am8AEQLTeXEXc3zefh7Grf6kZgOHBfWbSewINo0lInMEP9zzKg52vK
         GJJuAL+9e+7J6Zu6qaf51NVGGUpOQgA96OMyosLLRydIpL229a1gvmoPZTIrE4UXy0go
         3cbWTOvugNhEVS4mGsSPw3sDh5086MGo44MEZRBzLpiq1k5xl6Y5tzr1Y79jAr8gz2M+
         ufmw==
X-Gm-Message-State: AOAM533QzccI+1V2JLZR5WRzXLCHIDLIsqXf+wi7Y0Ks7vgqsmt6lrQS
        lJG/BbUEReAvw1aPTHnE0qpTs6BXVXOaUg==
X-Google-Smtp-Source: ABdhPJwk/6GhpV3JsaR0hXqo38EkN4pxUz/+JPdF8gqRWCLxuGx+icVaRM8CuR2CMOLE7N24F6uDjzSxY4FCFQ==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a8b1:128a:69fa:86fb])
 (user=dlatypov job=sendgmr) by 2002:a25:21d4:: with SMTP id
 h203mr9010706ybh.290.1612563258804; Fri, 05 Feb 2021 14:14:18 -0800 (PST)
Date:   Fri,  5 Feb 2021 14:14:09 -0800
Message-Id: <20210205221409.1962881-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v2] kunit: don't show `1 == 1` in failed assertion messages
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, given something (fairly dystopian) like
> KUNIT_EXPECT_EQ(test, 2 + 2, 5)

KUnit will prints a failure message like this.
>  Expected 2 + 2 == 5, but
>      2 + 2 == 4
>      5 == 5

With this patch, the output just becomes
>  Expected 2 + 2 == 5, but
>      2 + 2 == 4

This patch is slightly hacky, but it's quite common* to compare an
expression to a literal integer value, so this can make KUnit less
chatty in many cases. (This patch also fixes variants like
KUNIT_EXPECT_GT, LE, et al.).

It also allocates an additional string briefly, but given this only
happens on test failures, it doesn't seem too bad a tradeoff.
Also, in most cases it'll realize the lengths are unequal and bail out
before the allocation.

We could save the result of the formatted string to avoid wasting this
extra work, but it felt cleaner to leave it as-is.

Edge case: for something silly and unrealistic like
> KUNIT_EXPECT_EQ(test, 4, 5);

It'll generate this message with a trailing "but"
>  Expected 4 == 5, but
>  <next line of normal output>

It didn't feel worth adding a check up-front to see if both sides are
literals to handle this better.

*A quick grep suggests 100+ comparisons to an integer literal as the
right hand side.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Tested-by: David Gow <davidgow@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 lib/kunit/assert.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index 33acdaa28a7d..e0ec7d6fed6f 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -85,6 +85,29 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
 }
 EXPORT_SYMBOL_GPL(kunit_ptr_not_err_assert_format);
 
+/* Checks if `text` is a literal representing `value`, e.g. "5" and 5 */
+static bool is_literal(struct kunit *test, const char *text, long long value,
+		       gfp_t gfp)
+{
+	char *buffer;
+	int len;
+	bool ret;
+
+	len = snprintf(NULL, 0, "%lld", value);
+	if (strlen(text) != len)
+		return false;
+
+	buffer = kunit_kmalloc(test, len+1, gfp);
+	if (!buffer)
+		return false;
+
+	snprintf(buffer, len+1, "%lld", value);
+	ret = strncmp(buffer, text, len) == 0;
+
+	kunit_kfree(test, buffer);
+	return ret;
+}
+
 void kunit_binary_assert_format(const struct kunit_assert *assert,
 				struct string_stream *stream)
 {
@@ -97,12 +120,16 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
 			  binary_assert->left_text,
 			  binary_assert->operation,
 			  binary_assert->right_text);
-	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld\n",
-			  binary_assert->left_text,
-			  binary_assert->left_value);
-	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld",
-			  binary_assert->right_text,
-			  binary_assert->right_value);
+	if (!is_literal(stream->test, binary_assert->left_text,
+			binary_assert->left_value, stream->gfp))
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld\n",
+				  binary_assert->left_text,
+				  binary_assert->left_value);
+	if (!is_literal(stream->test, binary_assert->right_text,
+			binary_assert->right_value, stream->gfp))
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld",
+				  binary_assert->right_text,
+				  binary_assert->right_value);
 	kunit_assert_print_msg(assert, stream);
 }
 EXPORT_SYMBOL_GPL(kunit_binary_assert_format);

base-commit: 1e0d27fce010b0a4a9e595506b6ede75934c31be
-- 
2.30.0.478.g8a0d178c01-goog

