Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F1232BCF6
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Mar 2021 23:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241113AbhCCPIq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Mar 2021 10:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238038AbhCCCFj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Mar 2021 21:05:39 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDFFC06178C;
        Tue,  2 Mar 2021 18:03:55 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id gi9so10983328qvb.10;
        Tue, 02 Mar 2021 18:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=SWgDl8ZesuDM2NAIYjMPAnyZm1VzAvxJEJ4cGxqrkw4=;
        b=LK9FJeWUjvXOdiWeLfwdbKwClga1/MJA8WveK8zJFsbs/9+qeFyHjjozQSipVX9RCy
         Yg41oIPHCqpB0aRtlLbqsegKEUIQMweECDYdGEbfV08JBYW7VfD2H8MKNSbR+oeUa6L/
         kH2e3eLPgZJAYc3q33ryafRfSHow+2UHYnARebxMAxmEqJmdRRUZ8PC0/97DY6sNZwca
         w8aeBkCkDrzwRS7RKtzwbPJcmO8jBtrOL9aw1mXSBgQ8Ppjdf9Ni2B1pgEiP+ywqV1lC
         wYodvzTZFtgWJONbJ1jeDD9tP4APsO7dMJ7pfN2/dMOorLAijyr6J+XZnoD76RMIZNhZ
         RRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=SWgDl8ZesuDM2NAIYjMPAnyZm1VzAvxJEJ4cGxqrkw4=;
        b=mI1k1HMDMrs3Fcde0viDTQz0dGVadEjjFSO7ElOXPfSb9Nk+hio4zxz0oJSz1hFBI2
         gF6txAwRNeUJ31wNhxLJhtnacj+tIeWX/JIdvXBE5Bw6nt5YcBf11hxve0qE3ahEJIwi
         Ae8X8rtKajb6VPPQ0Msg1oeu/ORR6Xv6YzkL0+wY/Vw23yt+Jh5C2B1gGar0S4kb13N9
         g9gqModqKxb7WNLmsqv6us7KuWkTZ7s64fAc+VNQiujejlPfocVNY6IL910bAYV6hAMc
         ohtXC2dyOxLFro6onJ2Diq/bih3HjD7C06eIecStcUWoF5iJ/AsCyvWQwOz+PlTXkoYD
         aT4w==
X-Gm-Message-State: AOAM531o2n6oXWf4c0coI+GsxhgWHQ6HDIlNzRqQIDO5ylIUfvZ7uac9
        /CbzWGHTE4FYEj17TrBnv90=
X-Google-Smtp-Source: ABdhPJyV6raoRUWcHcdGZB7qD7LCub9i0c1p9J0sY+UwxFtnLB3AmR9NqdBGpWHth0pYjtADGSX+ZQ==
X-Received: by 2002:ad4:4c83:: with SMTP id bs3mr655518qvb.41.1614737034559;
        Tue, 02 Mar 2021 18:03:54 -0800 (PST)
Received: from smtp.gmail.com ([2804:14c:73:9e91::1001])
        by smtp.gmail.com with ESMTPSA id v145sm17069268qka.27.2021.03.02.18.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 18:03:54 -0800 (PST)
Date:   Tue, 2 Mar 2021 23:03:50 -0300
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
To:     brendanhiggins@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] kunit: fix checkpatch warning
Message-ID: <20210303020350.4sahuojkqnkcxquf@smtp.gmail.com>
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
Change log v1 -> v2
fixed signed-off-by tag
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
2.30.1

