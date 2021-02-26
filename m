Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13C53268FB
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Feb 2021 22:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhBZUy4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Feb 2021 15:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhBZUyz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Feb 2021 15:54:55 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91FCC06174A;
        Fri, 26 Feb 2021 12:54:14 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id k5so5181324qvu.2;
        Fri, 26 Feb 2021 12:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=lprh19f9DdU1Ukj+xhNEllV46kCwHQGRCuKxdl6/+6M=;
        b=ZrnDnY8JHtIY76Qv42WAiZCTV7omWkz585QFZ7WFheTDlgFCLXk2k6kR+XFXLWCW8O
         in5GfXsyPD+uQeIrckBOQSjS6LxOguCxqsDWVglDA7orSRjGJF6GcDv+r0Yr61vV0lvl
         7k9kWrvUaMxjKWMPgaqcI1W1X7zMFqOyFHr+8yEAq7lkK71OwzpypO0fevpcJDbA7eih
         n1/lKXGyqTk5+B9JjtUNJLlXf9axKhqLRvBd1xe7pwpAvMAkKV3MuE5M5+J2YluAlBm5
         hvIUfZPfftvS5L3mWHzEEMxb5xKfG3BuxIq1podIxiB6a030X8YbvSca/scPZUm9kRuj
         byyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=lprh19f9DdU1Ukj+xhNEllV46kCwHQGRCuKxdl6/+6M=;
        b=tyoRyRoL2q5ePthGZr+6K8UBT4X0lvy3aNAiqe6755RG7qd2bjGxKCy9oAfFqt2zKe
         INxl2ej/5Aw/+rkWe05pl1DU5aQ7yWhjFwI2ieOK7KCRdhC2O0X7DsEOsgfVDOOoe38t
         4459DcyB6wSvnU7bw9OsTc/8DP+oFO/htF4qRiMQGc4oY31g0h1DrqvV1gLomBuLUQja
         P/fKI6Md5rfF9iprx9k5yug/Enpds04vAhDEiyTHxEt4z4rRMqy8WPNjChi0d49N4SlL
         vwKVqqw2/5ocT7lJ7BhXf2eNrmVy0sic8tep+cSL3K8Vu4W+hEhlwSyFiWxDTxf+kFWT
         pVHw==
X-Gm-Message-State: AOAM5319vfGX2SI6ibiGqTMrAKWA0h9B+cd6NGI6/EYq/pRkq5MepxZ9
        Tuf+Ac2m/2wuK1IcQ/JsV4I=
X-Google-Smtp-Source: ABdhPJxTv7Tbc++eYs+AYN1gu06PSyF50S8J/LEP4jvknCJRTSsWtTXQf5CuxlCodaKu5kolYc3jvg==
X-Received: by 2002:ad4:4c83:: with SMTP id bs3mr3160700qvb.41.1614372854181;
        Fri, 26 Feb 2021 12:54:14 -0800 (PST)
Received: from smtp.gmail.com ([2804:14c:73:9e91:8b8:81b4:5ef9:821d])
        by smtp.gmail.com with ESMTPSA id h27sm7168705qkk.49.2021.02.26.12.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 12:54:13 -0800 (PST)
Date:   Fri, 26 Feb 2021 17:54:10 -0300
From:   Lucas Pires Stankus <lucas.p.stankus@gmail.com>
To:     brendanhiggins@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kunit: fix checkpatch warning
Message-ID: <20210226205410.nnwstno5xrsb5ci3@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Tidy up code by fixing the following checkpatch warnings:
CHECK: Alignment should match open parenthesis
CHECK: Lines should not end with a '('

Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
---
 lib/kunit/assert.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index 33acdaa28a7d..309f49d70b2f 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -25,7 +25,7 @@ void kunit_base_assert_format(const struct kunit_assert *assert,
 	}
 
 	string_stream_add(stream, "%s FAILED at %s:%d\n",
-			 expect_or_assert, assert->file, assert->line);
+			  expect_or_assert, assert->file, assert->line);
 }
 EXPORT_SYMBOL_GPL(kunit_base_assert_format);
 
@@ -48,8 +48,9 @@ EXPORT_SYMBOL_GPL(kunit_fail_assert_format);
 void kunit_unary_assert_format(const struct kunit_assert *assert,
 			       struct string_stream *stream)
 {
-	struct kunit_unary_assert *unary_assert = container_of(
-			assert, struct kunit_unary_assert, assert);
+	struct kunit_unary_assert *unary_assert;
+
+	unary_assert = container_of(assert, struct kunit_unary_assert, assert);
 
 	kunit_base_assert_format(assert, stream);
 	if (unary_assert->expected_true)
@@ -67,8 +68,10 @@ EXPORT_SYMBOL_GPL(kunit_unary_assert_format);
 void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
 				     struct string_stream *stream)
 {
-	struct kunit_ptr_not_err_assert *ptr_assert = container_of(
-			assert, struct kunit_ptr_not_err_assert, assert);
+	struct kunit_ptr_not_err_assert *ptr_assert;
+
+	ptr_assert = container_of(assert, struct kunit_ptr_not_err_assert,
+				  assert);
 
 	kunit_base_assert_format(assert, stream);
 	if (!ptr_assert->value) {
@@ -88,8 +91,10 @@ EXPORT_SYMBOL_GPL(kunit_ptr_not_err_assert_format);
 void kunit_binary_assert_format(const struct kunit_assert *assert,
 				struct string_stream *stream)
 {
-	struct kunit_binary_assert *binary_assert = container_of(
-			assert, struct kunit_binary_assert, assert);
+	struct kunit_binary_assert *binary_assert;
+
+	binary_assert = container_of(assert, struct kunit_binary_assert,
+				     assert);
 
 	kunit_base_assert_format(assert, stream);
 	string_stream_add(stream,
@@ -110,8 +115,10 @@ EXPORT_SYMBOL_GPL(kunit_binary_assert_format);
 void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
 				    struct string_stream *stream)
 {
-	struct kunit_binary_ptr_assert *binary_assert = container_of(
-			assert, struct kunit_binary_ptr_assert, assert);
+	struct kunit_binary_ptr_assert *binary_assert;
+
+	binary_assert = container_of(assert, struct kunit_binary_ptr_assert,
+				     assert);
 
 	kunit_base_assert_format(assert, stream);
 	string_stream_add(stream,
@@ -132,8 +139,10 @@ EXPORT_SYMBOL_GPL(kunit_binary_ptr_assert_format);
 void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 				    struct string_stream *stream)
 {
-	struct kunit_binary_str_assert *binary_assert = container_of(
-			assert, struct kunit_binary_str_assert, assert);
+	struct kunit_binary_str_assert *binary_assert;
+
+	binary_assert = container_of(assert, struct kunit_binary_str_assert,
+				     assert);
 
 	kunit_base_assert_format(assert, stream);
 	string_stream_add(stream,
-- 
2.30.1

