Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142DC28C4A8
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Oct 2020 00:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388941AbgJLWV1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Oct 2020 18:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388883AbgJLWVW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Oct 2020 18:21:22 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21220C0613D0
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Oct 2020 15:21:21 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z27so9073146ybi.17
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Oct 2020 15:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=s4/aCAy0gkB7fEnOHtnGOn6EzeGugxBihpSoxVben5o=;
        b=I64Q6ZYIzkaQ/aXhpEEUNRxnyQOvIoYx+vu0OanAISVg2LGW3fUQBxub42taCj22As
         AzEwooUcmSdD0fUEiVbEleTrgpbzqvsLxMHK/AhyYmEy1iJ32EMv+vWNKCkBXBTJAMY8
         tFALtF5NxuL0bVgqZLsDL1Nd49jCiqL1R0vaX91ttowzpwFlQgQvunJYdRoyl41KZWfo
         pszPbBt/0LGQg5OWQMnm3qIPeyQ8Z6pHYfBMJ3lnnvqVcrDX0KYfCxc7BS2Qcx4EM3jQ
         zoNwaXmr90ISMz8KLqeCNVTNHAVO5C+lm/oM5GdAYrti2ITx7KsY0oPm98zNXAnNQnT4
         mTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s4/aCAy0gkB7fEnOHtnGOn6EzeGugxBihpSoxVben5o=;
        b=LRs15MEPNvCFmEgqv2Xrav9EbekYklF99Eotn/j9Cv75IEG4Q8tUr4pG5q8+eEHy6Z
         j7VSEK7fYx04+d6foLo9LyTpHd+maqc07fzVOMMyB1N3pGMxU8cwyXlNgRF+hrvLs3RW
         PVSMDLt7MxxQZaCAnRTPhpa8IMy93xV2sWWajNhh15xKay3VQu3txNCP2Suh5DC8C3AM
         FijrQjsFY9/YOmiyz5phMVKNDNvxscjNOnZFPW8oqGgaa0eZLw7tbTGGi226wN6/rM8E
         FDZNvo2gKsTMZkhUeuszptvoTjfGEsnQw/+uRD62OTAozB+4GXTQzd1RrxBA2pwdBdV5
         QtaQ==
X-Gm-Message-State: AOAM531YA/g+JFDcXClwhjxacgL1RUMAHfSvCgKwAP2aSs7oNz7jx7RD
        lNiQbK1Zu2goTm2h/kISYdJ4ImYnJvwfQg==
X-Google-Smtp-Source: ABdhPJzod1mdhkOJQpB9loDPpaYuWs/JBFphf2ZFLjAcvhVRrOPDjTwguPLfuDtJXvxtyY60nQRvEo7wTfz0Zg==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a25:6ec3:: with SMTP id
 j186mr12997260ybc.165.1602541280289; Mon, 12 Oct 2020 15:21:20 -0700 (PDT)
Date:   Mon, 12 Oct 2020 15:20:40 -0700
In-Reply-To: <20201012222050.999431-1-dlatypov@google.com>
Message-Id: <20201012222050.999431-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20201012222050.999431-1-dlatypov@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [RFC v2 02/12] kunit: test: add kunit_stream a std::stream like logger
From:   Daniel Latypov <dlatypov@google.com>
To:     dlatypov@google.com
Cc:     alan.maguire@oracle.com, brendanhiggins@google.com,
        davidgow@google.com, keescook@chromium.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, mcgrof@kernel.org,
        sboyd@kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Brendan Higgins <brendanhiggins@google.com>

A lot of the expectation and assertion infrastructure prints out fairly
complicated test failure messages, so add a C++ style log library for
for logging test results called `struct kunit_stream`.

kunit_stream allows us to construct a message before we know whether we
want to print it out; this can be extremely handy if there is
information you might need for a failure message that is easiest to
collect in the steps leading up to the actual check.

Note that kunit_stream is distinct from string_stream: whereas
string_stream is really just a string builder, kunit_stream is
specifically used for constructing expectation/assertion (introduced
later in this series) messages to a user of KUnit.

Patch was previously reviewed at
https://lore.kernel.org/linux-fsdevel/20190712081744.87097-5-brendanhiggins@google.com/
Primary differences are
* kunit/ => lib/kunit/
* re-expose string_stream_clear(), which was made static since then

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
Cc: Stephen Boyd <sboyd@kernel.org>
---
 include/kunit/kunit-stream.h  |  94 +++++++++++++++++++++++++++++
 include/kunit/string-stream.h |   2 +
 include/kunit/test.h          |   1 +
 lib/kunit/Makefile            |   1 +
 lib/kunit/kunit-stream.c      | 110 ++++++++++++++++++++++++++++++++++
 lib/kunit/string-stream.c     |   2 +-
 6 files changed, 209 insertions(+), 1 deletion(-)
 create mode 100644 include/kunit/kunit-stream.h
 create mode 100644 lib/kunit/kunit-stream.c

diff --git a/include/kunit/kunit-stream.h b/include/kunit/kunit-stream.h
new file mode 100644
index 000000000000..9a768732a04b
--- /dev/null
+++ b/include/kunit/kunit-stream.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * C++ stream style string formatter and printer used in KUnit for outputting
+ * KUnit messages.
+ *
+ * Copyright (C) 2020, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#ifndef _KUNIT_KUNIT_STREAM_H
+#define _KUNIT_KUNIT_STREAM_H
+
+#include <linux/types.h>
+#include <kunit/string-stream.h>
+
+struct kunit;
+
+/**
+ * struct kunit_stream - a std::stream style string builder.
+ *
+ * A std::stream style string builder. Allows messages to be built up and
+ * printed all at once. Note that the intention is to only use
+ * &struct kunit_stream to communicate with a user of KUnit, most often to
+ * communicate something about an expectation or an assertion to the user. If
+ * you want a similar interface, but aren't sure if this is the right class for
+ * you to use, you probably want to use the related string_stream class, which
+ * is allowed for generic string construction in a similar manner. This class is
+ * really only for the KUnit library to communicate certain kinds of information
+ * to KUnit users and should not be used by anyone else.
+ *
+ * A note on &struct kunit_stream's usage: a kunit_stream will generally
+ * accompany *one* expectation or assertion. Multiple expectations/assertions
+ * may be validated concurrently at any given time, even within a single test
+ * case, so sharing a kunit_stream between expectations/assertions may result in
+ * unintended consequences.
+ */
+struct kunit_stream {
+	/* private: internal use only. */
+	struct kunit *test;
+	struct string_stream *internal_stream;
+};
+
+/**
+ * alloc_kunit_stream() - constructs a new &struct kunit_stream.
+ * @test: The test context object.
+ * @gfp: The GFP flags to use for internal allocations.
+ *
+ * Constructs a new test managed &struct kunit_stream.
+ */
+struct kunit_stream *alloc_kunit_stream(struct kunit *test,
+					gfp_t gfp);
+
+/**
+ * kunit_stream_add(): adds the formatted input to the internal buffer.
+ * @kstream: the stream being operated on.
+ * @fmt: printf style format string to append to stream.
+ *
+ * Appends the formatted string, @fmt, to the internal buffer.
+ */
+void __printf(2, 3) kunit_stream_add(struct kunit_stream *kstream,
+				     const char *fmt, ...);
+
+/**
+ * kunit_stream_append(): appends the contents of @other to @kstream.
+ * @kstream: the stream to which @other is appended.
+ * @other: the stream whose contents are appended to @kstream.
+ *
+ * Appends the contents of @other to @kstream.
+ */
+void kunit_stream_append(struct kunit_stream *kstream,
+			 struct kunit_stream *other);
+
+/**
+ * kunit_stream_commit(): prints out the internal buffer to the user.
+ * @kstream: the stream being operated on.
+ *
+ * Outputs the contents of the internal buffer as a kunit_printk formatted
+ * output. KUNIT_STREAM ONLY OUTPUTS ITS BUFFER TO THE USER IF COMMIT IS
+ * CALLED!!! The reason for this is that it allows us to construct a message
+ * before we know whether we want to print it out; this can be extremely handy
+ * if there is information you might need for a failure message that is easiest
+ * to collect in the steps leading up to the actual check.
+ */
+void kunit_stream_commit(struct kunit_stream *kstream);
+
+/**
+ * kunit_stream_clear(): clears the internal buffer.
+ * @kstream: the stream being operated on.
+ *
+ * Clears the contents of the internal buffer.
+ */
+void kunit_stream_clear(struct kunit_stream *kstream);
+
+#endif /* _KUNIT_KUNIT_STREAM_H */
diff --git a/include/kunit/string-stream.h b/include/kunit/string-stream.h
index fe98a00b75a9..44677c386890 100644
--- a/include/kunit/string-stream.h
+++ b/include/kunit/string-stream.h
@@ -46,6 +46,8 @@ int string_stream_append(struct string_stream *stream,
 
 bool string_stream_is_empty(struct string_stream *stream);
 
+void string_stream_clear(struct string_stream *stream);
+
 int string_stream_destroy(struct string_stream *stream);
 
 #endif /* _KUNIT_STRING_STREAM_H */
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 59f3144f009a..687782fa44d9 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -10,6 +10,7 @@
 #define _KUNIT_TEST_H
 
 #include <kunit/assert.h>
+#include <kunit/kunit-stream.h>
 #include <kunit/try-catch.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 724b94311ca3..523a7b0f9783 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_KUNIT) +=			kunit.o
 kunit-objs +=				test.o \
 					string-stream.o \
 					assert.o \
+					kunit-stream.o \
 					try-catch.o
 
 ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
diff --git a/lib/kunit/kunit-stream.c b/lib/kunit/kunit-stream.c
new file mode 100644
index 000000000000..744798693f39
--- /dev/null
+++ b/lib/kunit/kunit-stream.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * C++ stream style string formatter and printer used in KUnit for outputting
+ * KUnit messages.
+ *
+ * Copyright (C) 2020, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <kunit/test.h>
+#include <kunit/kunit-stream.h>
+#include <kunit/string-stream.h>
+
+void kunit_stream_add(struct kunit_stream *kstream, const char *fmt, ...)
+{
+	va_list args;
+	struct string_stream *stream = kstream->internal_stream;
+
+	va_start(args, fmt);
+
+	if (string_stream_vadd(stream, fmt, args))
+		kunit_err(kstream->test,
+			  "Failed to allocate fragment: %s\n",
+			  fmt);
+
+	va_end(args);
+}
+
+void kunit_stream_append(struct kunit_stream *kstream,
+			 struct kunit_stream *other)
+{
+	int ret;
+
+	ret = string_stream_append(kstream->internal_stream,
+				   other->internal_stream);
+
+	if (ret)
+		kunit_err(kstream->test,
+			  "Failed to append other stream: %d\n", ret);
+}
+
+void kunit_stream_clear(struct kunit_stream *kstream)
+{
+	string_stream_clear(kstream->internal_stream);
+}
+
+void kunit_stream_commit(struct kunit_stream *kstream)
+{
+	struct string_stream *stream = kstream->internal_stream;
+	struct string_stream_fragment *fragment;
+	struct kunit *test = kstream->test;
+	char *buf;
+
+	buf = string_stream_get_string(stream);
+	if (!buf) {
+		kunit_err(test,
+			  "Could not allocate buffer, dumping stream:\n");
+		list_for_each_entry(fragment, &stream->fragments, node) {
+			kunit_err(test, "%s", fragment->fragment);
+		}
+		kunit_err(test, "\n");
+	} else {
+		kunit_err(test, "%s", buf);
+	}
+
+	kunit_stream_clear(kstream);
+}
+
+struct kunit_stream_alloc_context {
+	struct kunit *test;
+	gfp_t gfp;
+};
+
+static int kunit_stream_init(struct kunit_resource *res, void *context)
+{
+	struct kunit_stream_alloc_context *ctx = context;
+	struct kunit_stream *stream;
+
+	stream = kunit_kzalloc(ctx->test, sizeof(*stream), ctx->gfp);
+	if (!stream)
+		return -ENOMEM;
+
+	stream->test = ctx->test;
+	stream->internal_stream = alloc_string_stream(ctx->test, ctx->gfp);
+	if (!stream->internal_stream)
+		return -ENOMEM;
+
+	res->data = stream;
+	return 0;
+}
+
+static void kunit_stream_free(struct kunit_resource *res)
+{
+	/* Do nothing because cleanup is handled by KUnit managed resources */
+}
+
+struct kunit_stream *alloc_kunit_stream(struct kunit *test,
+					gfp_t gfp)
+{
+	struct kunit_stream_alloc_context ctx = {
+		.test = test,
+		.gfp = gfp
+	};
+
+	return kunit_alloc_resource(test,
+				    kunit_stream_init,
+				    kunit_stream_free,
+				    gfp,
+				    &ctx);
+}
diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
index 151a0e7ac349..a94004134928 100644
--- a/lib/kunit/string-stream.c
+++ b/lib/kunit/string-stream.c
@@ -112,7 +112,7 @@ int string_stream_add(struct string_stream *stream, const char *fmt, ...)
 	return result;
 }
 
-static void string_stream_clear(struct string_stream *stream)
+void string_stream_clear(struct string_stream *stream)
 {
 	struct string_stream_fragment *frag_container, *frag_container_safe;
 
-- 
2.28.0.1011.ga647a8990f-goog

