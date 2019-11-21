Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71EF0105D67
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2019 00:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfKUXvn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Nov 2019 18:51:43 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:55970 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfKUXvm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Nov 2019 18:51:42 -0500
Received: by mail-pl1-f201.google.com with SMTP id q1so2572530pll.22
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2019 15:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1T1UpCeydKo8c69iE696L0TyG6TBO0S0rujCmrpRiXc=;
        b=wT/BEegA59gkz+IDqsv8EwP2H4rvwnrvlBG8zAXZ25M2YldyjfigLKYpyqHpT379WL
         Lopo5fVUW4NUMEEZrrIc4kJeyzURU5YrHZm4wHyOV7h8d44mADXqmM9htGMNvN1JZq7B
         I5PejRWhV4WPrJ+0sw979iln17jtBT/UcYKtU/Fl4JAM0jx9rOsvwYJ5jzVdPtsKLyB4
         EjtaMD2RQBx7xP5P9W3o9M0dZ/r+dy06zNVYGLiRw1EUrBx6q/NSvJgIdQYjWlPXmLYi
         s3LJHQrg3JQzvedPtiLScLol2lPo09BNNGKBxLy6+zAlEKyEaPD4NFgrHRdo24Lt3jni
         ezJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1T1UpCeydKo8c69iE696L0TyG6TBO0S0rujCmrpRiXc=;
        b=eNIYjJ+6uevDYqa8Dd4zGNrB7yAQuCu+yvQ89yVpjHjLsHYg1wTZvvP5kMbRW7O26q
         eJ39yzGdt9qe/9QaWNvGbBNFJjE9EGdh9iBoy7fOl+rph4CVnkMnDv2qmhUfN1cTdGVz
         huceiZlWDmdlqV09AZZFEkGF44tAQ4aPtJc8j3hjW70SZ8Or6UMlH5MArOCYyt7m0Ycc
         leov8C3zWBaCxIgiKSgM57uYh6f0CXpk7gXiv6hQX9QGG3oLt59UkTj4dSYnvYPpXfQL
         lcn00AoXJgQCyp1HWuVSYIkP4Dvv2mVHWhHZvfnbQwujhf4d9O7MMuQ91qM0qPHX3Fnc
         sJfQ==
X-Gm-Message-State: APjAAAU/oXuoLpRxuYdYCAgXlt1oscggmS2QJKnEDqMsYp7475G5D0Zb
        yQmGi25OcZPzi3smVfA0u6CWBnKAurcuAA==
X-Google-Smtp-Source: APXvYqxqDObiKuAtQd6VNMB5jJg4dvQfChOpJvo0SZqGPpVKts3oLqyq/Kj/rY6/KKnc3g5dRMYeF9eD/qV48Q==
X-Received: by 2002:a63:6cc8:: with SMTP id h191mr12813226pgc.345.1574380301840;
 Thu, 21 Nov 2019 15:51:41 -0800 (PST)
Date:   Thu, 21 Nov 2019 15:50:58 -0800
Message-Id: <20191121235058.21653-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH kselftest/test] kunit: Always print actual pointer values in asserts
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

KUnit assertions and expectations will print the values being tested. If
these are pointers (e.g., KUNIT_EXPECT_PTR_EQ(test, a, b)), these
pointers are currently printed with the %pK format specifier, which -- to
prevent information leaks which may compromise, e.g., ASLR -- are often
either hashed or replaced with ____ptrval____ or similar, making debugging
tests difficult.

By replacing %pK with %px as Documentation/core-api/printk-formats.rst
suggests, we disable this security feature for KUnit assertions and
expectations, allowing the actual pointer values to be printed. Given
that KUnit is not intended for use in production kernels, and the
pointers are only printed on failing tests, this seems like a worthwhile
tradeoff.

Signed-off-by: David Gow <davidgow@google.com>
---
This seems like the best way of solving this problem to me, but if
anyone has a better solution I'd love to hear it.

Note also that this does trigger two checkpatch.pl warnings, which warn
that the change will potentially cause the kernel memory layout to be
exposed. Since that's the whole point of the change, they probably
sohuld stay there.

 lib/kunit/assert.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index 86013d4cf891..a87960409bd4 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -110,10 +110,10 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
 			 binary_assert->left_text,
 			 binary_assert->operation,
 			 binary_assert->right_text);
-	string_stream_add(stream, "\t\t%s == %pK\n",
+	string_stream_add(stream, "\t\t%s == %px\n",
 			 binary_assert->left_text,
 			 binary_assert->left_value);
-	string_stream_add(stream, "\t\t%s == %pK",
+	string_stream_add(stream, "\t\t%s == %px",
 			 binary_assert->right_text,
 			 binary_assert->right_value);
 	kunit_assert_print_msg(assert, stream);
-- 
2.24.0.432.g9d3f5f5b63-goog

