Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91CF57D2ED
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Jul 2022 20:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiGUSCY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jul 2022 14:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbiGUSCY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jul 2022 14:02:24 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A258B4B6
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jul 2022 11:02:22 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k64-20020a253d43000000b0067080eb57fdso1792163yba.5
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jul 2022 11:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bwyvk3adYUmO9nGXEI3CWcvpdi62CKirSTxuhR6/nsw=;
        b=bGIgau+M3Z6by2t8ZG1mDNv/rfxHg71VJ6r02h86mtLkjz3yz7kPA5bRFH/aHFWZKm
         hDQqHQvSdAhyNgesiCx+I1PS3tUFyNkk28CN3M+KnbO66yRNYW463e4QFLtj+fr97xPr
         FF6bIMcqjAnvG4x/RD9SJzN/zcisqr/4bMDx5zHsxDi95n0mVEQ190mZiONKTBjW3Uv0
         QYZvQ6j+dKUlPqpp+XwHjou1cG9ZInz6JCwezLIaUR3306FDHrZvZoVC0EMhmbbeanJ7
         bIEk7krx/STdj54NTcu+aFHQwzNZFISF/KD3it0WGedpyPnh4YUk6ew4ssLb1wpYDvWz
         v36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bwyvk3adYUmO9nGXEI3CWcvpdi62CKirSTxuhR6/nsw=;
        b=G3vlKw0bhMEBGfy+zgX4qsalVx0hnl/aVK3w7kFAk7Fnl6sXeWb/Bvpxr4b/m3bejm
         f7zXprM8DhQ3bVu2Ba/g/BHyXloqSZsu2hcVtG8u8pxoMxcB9zXrl3yUCatXSW0i2eDh
         jbirKLxp+3WI5xbzseyEdtT6g/sSA48JLQzCHuFne39GACH+X5SI2zynvXcPpcfSzr8y
         h6PGD4Ye5VwtvIVJFQRduGUDonsehsv9Rd5N826Lf3NquGHb+O9Di+LNoqdfYiXa9I4B
         XTFi0ChBX2wJYCZ3hceoB3zYbMNq1qY8kSwARKBbk05+YPvYzhJqi4SeJjUrs65b2YJx
         Qu0w==
X-Gm-Message-State: AJIora9fWYRn6c0RJKuW/FdmFfUmRYF17hQUJ4zVt5YfHBEG+2qXx6PL
        qk9OMHw6tKYFx2vrGZTpXeJFgTERO4XtNQ==
X-Google-Smtp-Source: AGRyM1uTOq1N3ksSuvvL7kgVik3r3sJYoVQHO/NLbxfRpEl0mgzzQXgZIDXp9dkO+rAvi+Z4KpB9DvPXFdnyxQ==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a81:9acd:0:b0:31d:2fd7:3331 with SMTP id
 r196-20020a819acd000000b0031d2fd73331mr47250554ywg.145.1658426542076; Thu, 21
 Jul 2022 11:02:22 -0700 (PDT)
Date:   Thu, 21 Jul 2022 18:02:11 +0000
Message-Id: <20220721180214.3223778-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH 1/4] kunit: string-stream: Simplify resource use
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: David Gow <davidgow@google.com>

Currently, KUnit's string streams are themselves "KUnit resources".
This is redundant since the stream itself is already allocated with
kunit_kzalloc() and will thus be freed automatically at the end of the
test.

string-stream is only used internally within KUnit, and isn't using the
extra features that resources provide like reference counting, being
able to locate them dynamically as "test-local variables", etc.

Indeed, the resource's refcount is never incremented when the
pointer is returned. The fact that it's always manually destroyed is
more evidence that the reference counting is unused.

Signed-off-by: David Gow <davidgow@google.com>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 lib/kunit/string-stream.c | 90 +++++++--------------------------------
 lib/kunit/string-stream.h |  2 +-
 lib/kunit/test.c          |  2 +-
 3 files changed, 18 insertions(+), 76 deletions(-)

diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
index 141789ca8949..a2496abef152 100644
--- a/lib/kunit/string-stream.c
+++ b/lib/kunit/string-stream.c
@@ -12,64 +12,31 @@
 
 #include "string-stream.h"
 
-struct string_stream_fragment_alloc_context {
-	struct kunit *test;
-	int len;
-	gfp_t gfp;
-};
 
-static int string_stream_fragment_init(struct kunit_resource *res,
-				       void *context)
+static struct string_stream_fragment *alloc_string_stream_fragment(
+		struct kunit *test, int len, gfp_t gfp)
 {
-	struct string_stream_fragment_alloc_context *ctx = context;
 	struct string_stream_fragment *frag;
 
-	frag = kunit_kzalloc(ctx->test, sizeof(*frag), ctx->gfp);
+	frag = kunit_kzalloc(test, sizeof(*frag), gfp);
 	if (!frag)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
-	frag->test = ctx->test;
-	frag->fragment = kunit_kmalloc(ctx->test, ctx->len, ctx->gfp);
+	frag->test = test;
+	frag->fragment = kunit_kmalloc(test, len, gfp);
 	if (!frag->fragment)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
-	res->data = frag;
-
-	return 0;
+	return frag;
 }
 
-static void string_stream_fragment_free(struct kunit_resource *res)
+static void string_stream_fragment_destroy(struct string_stream_fragment *frag)
 {
-	struct string_stream_fragment *frag = res->data;
-
 	list_del(&frag->node);
 	kunit_kfree(frag->test, frag->fragment);
 	kunit_kfree(frag->test, frag);
 }
 
-static struct string_stream_fragment *alloc_string_stream_fragment(
-		struct kunit *test, int len, gfp_t gfp)
-{
-	struct string_stream_fragment_alloc_context context = {
-		.test = test,
-		.len = len,
-		.gfp = gfp
-	};
-
-	return kunit_alloc_resource(test,
-				    string_stream_fragment_init,
-				    string_stream_fragment_free,
-				    gfp,
-				    &context);
-}
-
-static int string_stream_fragment_destroy(struct string_stream_fragment *frag)
-{
-	return kunit_destroy_resource(frag->test,
-				      kunit_resource_instance_match,
-				      frag);
-}
-
 int string_stream_vadd(struct string_stream *stream,
 		       const char *fmt,
 		       va_list args)
@@ -169,48 +136,23 @@ struct string_stream_alloc_context {
 	gfp_t gfp;
 };
 
-static int string_stream_init(struct kunit_resource *res, void *context)
+struct string_stream *alloc_string_stream(struct kunit *test, gfp_t gfp)
 {
 	struct string_stream *stream;
-	struct string_stream_alloc_context *ctx = context;
 
-	stream = kunit_kzalloc(ctx->test, sizeof(*stream), ctx->gfp);
+	stream = kunit_kzalloc(test, sizeof(*stream), gfp);
 	if (!stream)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
-	res->data = stream;
-	stream->gfp = ctx->gfp;
-	stream->test = ctx->test;
+	stream->gfp = gfp;
+	stream->test = test;
 	INIT_LIST_HEAD(&stream->fragments);
 	spin_lock_init(&stream->lock);
 
-	return 0;
+	return stream;
 }
 
-static void string_stream_free(struct kunit_resource *res)
+void string_stream_destroy(struct string_stream *stream)
 {
-	struct string_stream *stream = res->data;
-
 	string_stream_clear(stream);
 }
-
-struct string_stream *alloc_string_stream(struct kunit *test, gfp_t gfp)
-{
-	struct string_stream_alloc_context context = {
-		.test = test,
-		.gfp = gfp
-	};
-
-	return kunit_alloc_resource(test,
-				    string_stream_init,
-				    string_stream_free,
-				    gfp,
-				    &context);
-}
-
-int string_stream_destroy(struct string_stream *stream)
-{
-	return kunit_destroy_resource(stream->test,
-				      kunit_resource_instance_match,
-				      stream);
-}
diff --git a/lib/kunit/string-stream.h b/lib/kunit/string-stream.h
index 43f9508a55b4..494dee0f24bd 100644
--- a/lib/kunit/string-stream.h
+++ b/lib/kunit/string-stream.h
@@ -46,6 +46,6 @@ int string_stream_append(struct string_stream *stream,
 
 bool string_stream_is_empty(struct string_stream *stream);
 
-int string_stream_destroy(struct string_stream *stream);
+void string_stream_destroy(struct string_stream *stream);
 
 #endif /* _KUNIT_STRING_STREAM_H */
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index b73d5bb5c473..0fb2771ca03e 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -267,7 +267,7 @@ static void kunit_fail(struct kunit *test, const struct kunit_loc *loc,
 
 	kunit_print_string_stream(test, stream);
 
-	WARN_ON(string_stream_destroy(stream));
+	string_stream_destroy(stream);
 }
 
 static void __noreturn kunit_abort(struct kunit *test)

base-commit: 94681e289bf5d10c9db9db143d1a22d8717205c5
-- 
2.37.1.359.gd136c6c3e2-goog

