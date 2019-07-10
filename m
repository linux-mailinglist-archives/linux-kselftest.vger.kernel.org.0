Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA079641DA
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2019 09:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfGJHPv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Jul 2019 03:15:51 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:38664 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbfGJHPv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Jul 2019 03:15:51 -0400
Received: by mail-qk1-f202.google.com with SMTP id n190so1202620qkd.5
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Jul 2019 00:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ef4x4rIYEjXAUsOwLGAl/ehMOJtbGdS1NNHHbtE3RYE=;
        b=cv0FhaBnT8sIOJX4UO7zyAd38+6SjIeDUMVqdusMiTVgkNsImibP4lJXYN/4Qex6jK
         VF+CiSBjt81zH7Dj8GQys9m5gAtrQYR0IfMqrReIrMG73CRRnf94McSae/SBAD+z3n2m
         fAPNVtZPuFY016upkbT03Klx17TvZgsbkRd2kiOJwJCzfJWerr4zA4UKaj06V/v4V2AU
         lovevOgS4jEUNgRpMjf4oEWfVzDcKUPKQNSDg+JHoKdrtFgHmkafF82uOtBzSpEeUsMw
         iXTCScpyTEQP72TaJPEeGXnBB+gMX+lhlz/srnTpYSajv4HcdVd/oZQ1eX5pt+8nl+RZ
         y61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ef4x4rIYEjXAUsOwLGAl/ehMOJtbGdS1NNHHbtE3RYE=;
        b=MzhT5EVfQn+wwyJypIFuNNnfXQUQy4ADENssOeS90x11bj7QIRR1UecVcjWh+kOLnO
         wco44lLOi8M2rpPOD2L6fuzZTt4R7VudIkvfIkmkD5K4pjkDTMVY7zMpuXSyaDrYI5kr
         Uy4QTLitOTmqi4ZVk1vQ9QHhYaobrc1yzPh3sWX5NxCuYdmm3RZ9foSy1LlYqZMEz3ga
         DCi9aDe6CjvT8x8DpF3PQtHXqup+rTpUB75AjUkpf55MzkUnS9nNd4qNC0iAClvNpjpf
         4IEzmWOkPi/5rL+/apqQXjBeGVlc6j16xqkuZ+xZ5WkNglIhJEB3l2BTJezxTZtH3qcZ
         bV7A==
X-Gm-Message-State: APjAAAXifnlvkdBFnS3R4GjmSerVzBEW6lU+nHH2H9l4M9MMk8EMUynd
        1ML6RStMW8padESTXwiprI5QnncMRvw+l/IrRpi6eg==
X-Google-Smtp-Source: APXvYqyMobJXqnNbAj/cGM/+SnYBhfNoCPG06BYi23WGY/9Bxh6lHiR5/Badoa6Srvlzlc8icohrZ2WuZ/Gsr8+9jH6keQ==
X-Received: by 2002:ac8:2d08:: with SMTP id n8mr21982152qta.383.1562742949599;
 Wed, 10 Jul 2019 00:15:49 -0700 (PDT)
Date:   Wed, 10 Jul 2019 00:14:53 -0700
In-Reply-To: <20190710071508.173491-1-brendanhiggins@google.com>
Message-Id: <20190710071508.173491-4-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190710071508.173491-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v8 03/18] kunit: test: add string_stream a std::stream like
 string builder
From:   Brendan Higgins <brendanhiggins@google.com>
To:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com, Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A number of test features need to do pretty complicated string printing
where it may not be possible to rely on a single preallocated string
with parameters.

So provide a library for constructing the string as you go similar to
C++'s std::string.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/kunit/string-stream.h |  49 ++++++++++++
 kunit/Makefile                |   3 +-
 kunit/string-stream.c         | 147 ++++++++++++++++++++++++++++++++++
 3 files changed, 198 insertions(+), 1 deletion(-)
 create mode 100644 include/kunit/string-stream.h
 create mode 100644 kunit/string-stream.c

diff --git a/include/kunit/string-stream.h b/include/kunit/string-stream.h
new file mode 100644
index 0000000000000..0552a05781afe
--- /dev/null
+++ b/include/kunit/string-stream.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * C++ stream style string builder used in KUnit for building messages.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#ifndef _KUNIT_STRING_STREAM_H
+#define _KUNIT_STRING_STREAM_H
+
+#include <linux/types.h>
+#include <linux/spinlock.h>
+#include <linux/kref.h>
+#include <stdarg.h>
+
+struct string_stream_fragment {
+	struct list_head node;
+	char *fragment;
+};
+
+struct string_stream {
+	size_t length;
+	struct list_head fragments;
+	/* length and fragments are protected by this lock */
+	spinlock_t lock;
+};
+
+struct kunit;
+
+struct string_stream *alloc_string_stream(struct kunit *test);
+
+void string_stream_get(struct string_stream *stream);
+
+int string_stream_put(struct string_stream *stream);
+
+int string_stream_add(struct string_stream *stream, const char *fmt, ...);
+
+int string_stream_vadd(struct string_stream *stream,
+		       const char *fmt,
+		       va_list args);
+
+char *string_stream_get_string(struct string_stream *stream);
+
+void string_stream_clear(struct string_stream *stream);
+
+bool string_stream_is_empty(struct string_stream *stream);
+
+#endif /* _KUNIT_STRING_STREAM_H */
diff --git a/kunit/Makefile b/kunit/Makefile
index 5efdc4dea2c08..275b565a0e81f 100644
--- a/kunit/Makefile
+++ b/kunit/Makefile
@@ -1 +1,2 @@
-obj-$(CONFIG_KUNIT) +=			test.o
+obj-$(CONFIG_KUNIT) +=			test.o \
+					string-stream.o
diff --git a/kunit/string-stream.c b/kunit/string-stream.c
new file mode 100644
index 0000000000000..0463a92dad74b
--- /dev/null
+++ b/kunit/string-stream.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * C++ stream style string builder used in KUnit for building messages.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <kunit/string-stream.h>
+#include <kunit/test.h>
+
+int string_stream_vadd(struct string_stream *stream,
+		       const char *fmt,
+		       va_list args)
+{
+	struct string_stream_fragment *frag_container;
+	int len;
+	va_list args_for_counting;
+	unsigned long flags;
+
+	/* Make a copy because `vsnprintf` could change it */
+	va_copy(args_for_counting, args);
+
+	/* Need space for null byte. */
+	len = vsnprintf(NULL, 0, fmt, args_for_counting) + 1;
+
+	va_end(args_for_counting);
+
+	frag_container = kmalloc(sizeof(*frag_container), GFP_KERNEL);
+	if (!frag_container)
+		return -ENOMEM;
+
+	frag_container->fragment = kmalloc(len, GFP_KERNEL);
+	if (!frag_container->fragment) {
+		kfree(frag_container);
+		return -ENOMEM;
+	}
+
+	len = vsnprintf(frag_container->fragment, len, fmt, args);
+	spin_lock_irqsave(&stream->lock, flags);
+	stream->length += len;
+	list_add_tail(&frag_container->node, &stream->fragments);
+	spin_unlock_irqrestore(&stream->lock, flags);
+
+	return 0;
+}
+
+int string_stream_add(struct string_stream *stream, const char *fmt, ...)
+{
+	va_list args;
+	int result;
+
+	va_start(args, fmt);
+	result = string_stream_vadd(stream, fmt, args);
+	va_end(args);
+
+	return result;
+}
+
+void string_stream_clear(struct string_stream *stream)
+{
+	struct string_stream_fragment *frag_container, *frag_container_safe;
+	unsigned long flags;
+
+	spin_lock_irqsave(&stream->lock, flags);
+	list_for_each_entry_safe(frag_container,
+				 frag_container_safe,
+				 &stream->fragments,
+				 node) {
+		list_del(&frag_container->node);
+		kfree(frag_container->fragment);
+		kfree(frag_container);
+	}
+	stream->length = 0;
+	spin_unlock_irqrestore(&stream->lock, flags);
+}
+
+char *string_stream_get_string(struct string_stream *stream)
+{
+	struct string_stream_fragment *frag_container;
+	size_t buf_len = stream->length + 1; /* +1 for null byte. */
+	char *buf;
+	unsigned long flags;
+
+	buf = kzalloc(buf_len, GFP_KERNEL);
+	if (!buf)
+		return NULL;
+
+	spin_lock_irqsave(&stream->lock, flags);
+	list_for_each_entry(frag_container, &stream->fragments, node)
+		strlcat(buf, frag_container->fragment, buf_len);
+	spin_unlock_irqrestore(&stream->lock, flags);
+
+	return buf;
+}
+
+bool string_stream_is_empty(struct string_stream *stream)
+{
+	bool is_empty;
+	unsigned long flags;
+
+	spin_lock_irqsave(&stream->lock, flags);
+	is_empty = list_empty(&stream->fragments);
+	spin_unlock_irqrestore(&stream->lock, flags);
+
+	return is_empty;
+}
+
+static int string_stream_init(struct kunit_resource *res, void *context)
+{
+	struct string_stream *stream;
+
+	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
+	if (!stream)
+		return -ENOMEM;
+
+	res->allocation = stream;
+	INIT_LIST_HEAD(&stream->fragments);
+	spin_lock_init(&stream->lock);
+
+	return 0;
+}
+
+static void string_stream_free(struct kunit_resource *res)
+{
+	struct string_stream *stream = res->allocation;
+
+	string_stream_clear(stream);
+	kfree(stream);
+}
+
+struct string_stream *alloc_string_stream(struct kunit *test)
+{
+	struct kunit_resource *res;
+
+	res = kunit_alloc_resource(test,
+				   string_stream_init,
+				   string_stream_free,
+				   NULL);
+
+	if (!res)
+		return NULL;
+
+	return res->allocation;
+}
-- 
2.22.0.410.gd8fdbe21b5-goog

