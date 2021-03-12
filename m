Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2346339735
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Mar 2021 20:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbhCLTLw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Mar 2021 14:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbhCLTLc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Mar 2021 14:11:32 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E6DC061574;
        Fri, 12 Mar 2021 11:11:31 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id j7so4641627qtx.5;
        Fri, 12 Mar 2021 11:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=3spcjLnhIpaEQlSYfpU6eWeK3w4rxh6LR0E+tlT/L6A=;
        b=K6OufaR3nEHrexoMEkun94rplT0Ja3LnBaUefbMhKYdNS3Xig506cl7vZ8YQWMRbjX
         0udR7/PfCfjZPTK9I5Zr3jAPsmzzQfH5u7uOilyBt1rvNyAxuheqMu4W3O6DLVHDj/OQ
         GWvBu2F2+OXKzYt2dbbenXWt9igLatGk88wwqaTomMpJWacRiBnSLOUwunJyurceay4D
         yZyNVwBepXgyeJjTY1CXiG4THIMrs8aDABow6hwZx/XQQbnwVuqKqRXauK0d7wj3apiw
         rVQi4NCu/L7xSlKbHAqnagIIfbuKzop3CGwXybmt/5Mx+42w5W8U4VDn20z1pxjl0aO4
         9ixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3spcjLnhIpaEQlSYfpU6eWeK3w4rxh6LR0E+tlT/L6A=;
        b=NJWn9Almt/NWP16jrdPIqqd6ipEDf9i7bLbVS2+C5laScxM/eIwRxjLbXo2YxxtlI5
         AmboGXwHPiVTQ8zNoRp/BSNzNTjHCbZiQN/p4o1+ZJY298cbikvZhAF9yKXO19tQn07J
         WUVh5Qyy7BwKm/oqYbBaYrQyKzvE457ydjKJYLmRt/AtH2dW+wgpWoop3IXa5LO2gPGx
         5X6ZqO0blzOOaJv7pWziVlGyxix8usiO3qHkwinPUGvBSQZiXJoa4UToc4i7po/3N3yd
         2pxl7cN38+TMVlM34lT9nXd3ocs7daX9FZn+Dy+bbv/8U6dVQ3ko7E3Oyh1BcCrI1Gno
         UD9A==
X-Gm-Message-State: AOAM5311FM9SWXr1Xdks1ulOTI3KuWU9gcsmwMNZflDTI5VFYdq31PkC
        w+c0kKSOy/QCwsR4FvzOezk=
X-Google-Smtp-Source: ABdhPJy+JfzQdXS8xDC6PZGIZUJhE65Nez6qo6aMx9DrRGxbuPrNvpgPvtBqukuJWgSWOL6VwneCzQ==
X-Received: by 2002:a05:622a:2c6:: with SMTP id a6mr13284749qtx.375.1615576290507;
        Fri, 12 Mar 2021 11:11:30 -0800 (PST)
Received: from smtp.gmail.com ([2804:14c:73:9e91:8b8:81b4:5ef9:821d])
        by smtp.gmail.com with ESMTPSA id t5sm1657514qkt.66.2021.03.12.11.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 11:11:30 -0800 (PST)
Date:   Fri, 12 Mar 2021 16:11:26 -0300
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
To:     brendanhiggins@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] kunit: Match parenthesis alignment to improve code
 readability
Message-ID: <20210312191126.azj2uorelxzxdnbe@smtp.gmail.com>
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
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---

Changelog v2 -> v3:
    Reword subject line

 lib/kunit/assert.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index e0ec7d6fed6f..acfbf86bddd6 100644
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
@@ -111,8 +114,10 @@ static bool is_literal(struct kunit *test, const char *text, long long value,
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
@@ -137,8 +142,10 @@ EXPORT_SYMBOL_GPL(kunit_binary_assert_format);
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
@@ -159,8 +166,10 @@ EXPORT_SYMBOL_GPL(kunit_binary_ptr_assert_format);
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
2.30.2

