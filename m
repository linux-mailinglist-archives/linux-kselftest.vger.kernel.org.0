Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D07848B786
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jan 2022 20:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237944AbiAKTmt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jan 2022 14:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237988AbiAKTms (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jan 2022 14:42:48 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3432C061756
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jan 2022 11:42:47 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id q80-20020a252a53000000b006108776aa8fso26610183ybq.17
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jan 2022 11:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+6cc3qbI1qJ+oPBhzvsIgEPS0KrWO2CbkJwRjbfjFBc=;
        b=pqjl57YLDSxGbbFCiFxjeg3/lT1sOabF5iw+ncfjzX/F34inIieRLjiOpJj+7tjw9z
         fGcSQ3nCMWXyKQEfxqq0Ap50z8yHpYuFbgHGRFPKrX8Hg4qhJiC9UC8vg+y/cWk9QY0i
         CrdbtwoTHbcwl4rN0b4Ru0qBvEceK85Gb7zs4WmBOxJ63QlQFH7r+wWfaRVmfiTXvGIc
         MIi/GtgwAoEkuxcNkixvtC/hsP02FiWPqfOXLlEagAmqsdATVsMVVVYFUYP/nmFsbRh1
         OPyhasXE+oRbKHGNrnkZa9vAtWEFB5UptIBkF7RuHvMeTVYO7dqmdSAP71dqsV9GwVeE
         SqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+6cc3qbI1qJ+oPBhzvsIgEPS0KrWO2CbkJwRjbfjFBc=;
        b=gBmGMoJuxXITJ0dqV0tzJXEqSBTkmpAWOf2GQxOkRWXNzmUu90TsyRONlh+QCrdhmY
         2/rJ8lchDPQ/yV6pdrbGUtWsJACTnj7jPMEF+b39jQz0G6Q3Q0BmGEAsgNyzpMMSIhOW
         10uI3qI1bIqCm0QWjCut21F55cMDt45tkCys40kNGEa2QUKoQqyrQjO3aEV+JMvJ5JWm
         OrKIxET7vXNZoPill6+z5euQHDSdz2gWYTc5hSmZuox0Zg0mWkEozAWkUoe4W3rXuQCb
         s1bz8oUai3hUZpt/CP2x7JQYnYZkqWmEX+CmxDf9MX33cJtARyfRvxagkAcACp/DTeQ9
         pfDg==
X-Gm-Message-State: AOAM532IeVFIHewlhBxlNwjbCR4iUGJTLjmixrf2nlFGSDG20QwGdUGs
        qh04B/CG6c6ilS/tN+QsOpgkDQCfNqRfAA==
X-Google-Smtp-Source: ABdhPJxKEbHl4KymXCxtimtS0gGONswWeOd5+R8wrSSBDMLJRBxLoPr6xWfpZPipmHxQzS9kp7CtI3Jxom6lOQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:8c76:9de0:1a30:7de8])
 (user=dlatypov job=sendgmr) by 2002:a5b:281:: with SMTP id
 x1mr7792024ybl.41.1641930167213; Tue, 11 Jan 2022 11:42:47 -0800 (PST)
Date:   Tue, 11 Jan 2022 11:42:29 -0800
In-Reply-To: <20220111194231.1797841-1-dlatypov@google.com>
Message-Id: <20220111194231.1797841-5-dlatypov@google.com>
Mime-Version: 1.0
References: <20220111194231.1797841-1-dlatypov@google.com>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
Subject: [PATCH v2 4/6] kunit: factor out kunit_base_assert_format() call into kunit_fail()
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        torvalds@linux-foundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We call this function first thing for all the assertion `format()`
functions.
This is the part that prints the file and line number and assertion type
(EXPECTATION, ASSERTION).

Having it as part of the format functions lets us have the flexibility
to not print that information (or print it differently) for new
assertion types, but I think this we don't need that.

And in the future, we'd like to consider factoring that data (file,
line#, type) out of the kunit_assert struct and into a `static`
variable, as Linus suggested [1], so we'd need to extract it anyways.

[1] https://groups.google.com/g/kunit-dev/c/i3fZXgvBrfA/m/VULQg1z6BAAJ

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
 lib/kunit/assert.c | 6 ------
 lib/kunit/test.c   | 1 +
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index b972bda61c0c..4d9a1295efc7 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -40,7 +40,6 @@ EXPORT_SYMBOL_GPL(kunit_assert_print_msg);
 void kunit_fail_assert_format(const struct kunit_assert *assert,
 			      struct string_stream *stream)
 {
-	kunit_base_assert_format(assert, stream);
 	string_stream_add(stream, "%pV", &assert->message);
 }
 EXPORT_SYMBOL_GPL(kunit_fail_assert_format);
@@ -52,7 +51,6 @@ void kunit_unary_assert_format(const struct kunit_assert *assert,
 
 	unary_assert = container_of(assert, struct kunit_unary_assert, assert);
 
-	kunit_base_assert_format(assert, stream);
 	if (unary_assert->expected_true)
 		string_stream_add(stream,
 				  KUNIT_SUBTEST_INDENT "Expected %s to be true, but is false\n",
@@ -73,7 +71,6 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
 	ptr_assert = container_of(assert, struct kunit_ptr_not_err_assert,
 				  assert);
 
-	kunit_base_assert_format(assert, stream);
 	if (!ptr_assert->value) {
 		string_stream_add(stream,
 				  KUNIT_SUBTEST_INDENT "Expected %s is not null, but is\n",
@@ -119,7 +116,6 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
 	binary_assert = container_of(assert, struct kunit_binary_assert,
 				     assert);
 
-	kunit_base_assert_format(assert, stream);
 	string_stream_add(stream,
 			  KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
 			  binary_assert->left_text,
@@ -147,7 +143,6 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
 	binary_assert = container_of(assert, struct kunit_binary_ptr_assert,
 				     assert);
 
-	kunit_base_assert_format(assert, stream);
 	string_stream_add(stream,
 			  KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
 			  binary_assert->left_text,
@@ -187,7 +182,6 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 	binary_assert = container_of(assert, struct kunit_binary_str_assert,
 				     assert);
 
-	kunit_base_assert_format(assert, stream);
 	string_stream_add(stream,
 			  KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
 			  binary_assert->left_text,
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 3a52c321c280..345a9dd88c27 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -255,6 +255,7 @@ static void kunit_fail(struct kunit *test, struct kunit_assert *assert)
 		return;
 	}
 
+	kunit_base_assert_format(assert, stream);
 	assert->format(assert, stream);
 
 	kunit_print_string_stream(test, stream);
-- 
2.34.1.575.g55b058a8bb-goog

