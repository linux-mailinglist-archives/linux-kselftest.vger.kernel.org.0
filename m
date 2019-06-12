Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80B6F42487
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2019 13:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438552AbfFLLoh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jun 2019 07:44:37 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:52215 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438516AbfFLLoY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jun 2019 07:44:24 -0400
Received: by mail-yw1-f73.google.com with SMTP id k10so16997909ywb.18
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2019 04:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gGgZ3a6eTnEUj++uQZqNg8ohQ9SAhJYSqDRRhc7mNEI=;
        b=IyYT4UbafS5twM0xOLKRaXywnDFDdbDqJgnUILJhttHP1uH2L+NNxbnxVgYAee8lTj
         qqRpjg9Px1/VzqAAM6upfA449si21/4lJ1XkboyBr77Ub0YTrQLbJn5sOIwz1IVA69V5
         Ap8ARpNEkRP6VF2Emm63QaD9Cx3fvDSKZaN/HHC/Xocn6hv1419HlST6JCQQ1Z5EHlL/
         CiJ+tHOg0rDi38FsnXC87324szrGfxAi8RWcHgDsH+2gfi2ulhbLZaNJ0gAKDJ3X8Gkg
         JxyfovuFPvVfND0iTfX5ByU+bmOloPTC5uiR6JL5swcvm2UzXNQY3tCHhrlAltKj98wk
         GeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gGgZ3a6eTnEUj++uQZqNg8ohQ9SAhJYSqDRRhc7mNEI=;
        b=U/N0EJ5TwAbwpPOoQTq36a5sY3sa/OBDhFpDNDUm6nVWtV+N60WKLGZVhVSw/WbRVU
         nXtgsfyOni258flZjN8Y+MylOwG4DY7dDeGVgolfrxRqEICVk+ZIcRhw+LGCRpijfh7k
         lNQJLeTRkgQcautnnMZg9tJed/UQVgxVInnqYMHIJR+f3YbUfX/k8PWOvUsPvrJd3PQx
         +aeDxEJFoAnSPE02lIV713aB1PtLfegnLxkISyvf0upb19j1b/bUzcRsezaCUvsv9kn8
         DPz4qADUy3DTJXVpNHuEWXYaRr9h4PSotlhMNyB8b9qvjOKpIXQrGSf61zoYr0FJZ9OT
         h+qw==
X-Gm-Message-State: APjAAAUkF0VtfWuSXifpKzW2VJMdDF3vsvLxXDllwFxJjpWP9jKqalNE
        HrcW7HnZwUcWqOIlJxOK3KbkiD2jEQ8olbpQ
X-Google-Smtp-Source: APXvYqw2mEWzgJjQoV5VS4+2oS4fV2R/NqpuRE12+fqx+o9WDuiIlBB+xhQmG1zgiCj0aRJhgLJNrenJlX6SsR3w
X-Received: by 2002:a81:6d46:: with SMTP id i67mr906534ywc.103.1560339863971;
 Wed, 12 Jun 2019 04:44:23 -0700 (PDT)
Date:   Wed, 12 Jun 2019 13:43:32 +0200
In-Reply-To: <cover.1560339705.git.andreyknvl@google.com>
Message-Id: <e024234e652f23be4d76d63227de114e7def5dff.1560339705.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1560339705.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v17 15/15] selftests, arm64: add a selftest for passing tagged
 pointers to kernel
From:   Andrey Konovalov <andreyknvl@google.com>
To:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch is a part of a series that extends arm64 kernel ABI to allow to
pass tagged user pointers (with the top byte set to something else other
than 0x00) as syscall arguments.

This patch adds a simple test, that calls the uname syscall with a
tagged user pointer as an argument. Without the kernel accepting tagged
user pointers the test fails with EFAULT.

Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 tools/testing/selftests/arm64/.gitignore      |  2 +
 tools/testing/selftests/arm64/Makefile        | 22 +++++++
 .../testing/selftests/arm64/run_tags_test.sh  | 12 ++++
 tools/testing/selftests/arm64/tags_lib.c      | 62 +++++++++++++++++++
 tools/testing/selftests/arm64/tags_test.c     | 18 ++++++
 5 files changed, 116 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/.gitignore
 create mode 100644 tools/testing/selftests/arm64/Makefile
 create mode 100755 tools/testing/selftests/arm64/run_tags_test.sh
 create mode 100644 tools/testing/selftests/arm64/tags_lib.c
 create mode 100644 tools/testing/selftests/arm64/tags_test.c

diff --git a/tools/testing/selftests/arm64/.gitignore b/tools/testing/selftests/arm64/.gitignore
new file mode 100644
index 000000000000..9b6a568de17f
--- /dev/null
+++ b/tools/testing/selftests/arm64/.gitignore
@@ -0,0 +1,2 @@
+tags_test
+tags_lib.so
diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
new file mode 100644
index 000000000000..9dee18727923
--- /dev/null
+++ b/tools/testing/selftests/arm64/Makefile
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0
+
+include ../lib.mk
+
+# ARCH can be overridden by the user for cross compiling
+ARCH ?= $(shell uname -m 2>/dev/null || echo not)
+
+ifneq (,$(filter $(ARCH),aarch64 arm64))
+
+TEST_CUSTOM_PROGS := $(OUTPUT)/tags_test
+
+$(OUTPUT)/tags_test: tags_test.c $(OUTPUT)/tags_lib.so
+	$(CC) -o $@ $(CFLAGS) $(LDFLAGS) $<
+
+$(OUTPUT)/tags_lib.so: tags_lib.c
+	$(CC) -o $@ -shared $(CFLAGS) $(LDFLAGS) $^
+
+TEST_PROGS := run_tags_test.sh
+
+all: $(TEST_CUSTOM_PROGS)
+
+endif
diff --git a/tools/testing/selftests/arm64/run_tags_test.sh b/tools/testing/selftests/arm64/run_tags_test.sh
new file mode 100755
index 000000000000..2bbe0cd4220b
--- /dev/null
+++ b/tools/testing/selftests/arm64/run_tags_test.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+echo "--------------------"
+echo "running tags test"
+echo "--------------------"
+LD_PRELOAD=./tags_lib.so ./tags_test
+if [ $? -ne 0 ]; then
+	echo "[FAIL]"
+else
+	echo "[PASS]"
+fi
diff --git a/tools/testing/selftests/arm64/tags_lib.c b/tools/testing/selftests/arm64/tags_lib.c
new file mode 100644
index 000000000000..55f64fc1aae6
--- /dev/null
+++ b/tools/testing/selftests/arm64/tags_lib.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdlib.h>
+#include <sys/prctl.h>
+
+#define TAG_SHIFT	(56)
+#define TAG_MASK	(0xffUL << TAG_SHIFT)
+
+#define PR_SET_TAGGED_ADDR_CTRL	55
+#define PR_GET_TAGGED_ADDR_CTRL	56
+#define PR_TAGGED_ADDR_ENABLE	(1UL << 0)
+
+void *__libc_malloc(size_t size);
+void __libc_free(void *ptr);
+void *__libc_realloc(void *ptr, size_t size);
+void *__libc_calloc(size_t nmemb, size_t size);
+
+static void *tag_ptr(void *ptr)
+{
+	static int tagged_addr_err = 1;
+	unsigned long tag = 0;
+
+	/*
+	 * Note that this code is racy. We only use it as a part of a single
+	 * threaded test application. Beware of using in multithreaded ones.
+	 */
+	if (tagged_addr_err == 1)
+		tagged_addr_err = prctl(PR_SET_TAGGED_ADDR_CTRL,
+				PR_TAGGED_ADDR_ENABLE, 0, 0, 0);
+
+	if (!ptr)
+		return ptr;
+	if (!tagged_addr_err)
+		tag = rand() & 0xff;
+
+	return (void *)((unsigned long)ptr | (tag << TAG_SHIFT));
+}
+
+static void *untag_ptr(void *ptr)
+{
+	return (void *)((unsigned long)ptr & ~TAG_MASK);
+}
+
+void *malloc(size_t size)
+{
+	return tag_ptr(__libc_malloc(size));
+}
+
+void free(void *ptr)
+{
+	__libc_free(untag_ptr(ptr));
+}
+
+void *realloc(void *ptr, size_t size)
+{
+	return tag_ptr(__libc_realloc(untag_ptr(ptr), size));
+}
+
+void *calloc(size_t nmemb, size_t size)
+{
+	return tag_ptr(__libc_calloc(nmemb, size));
+}
diff --git a/tools/testing/selftests/arm64/tags_test.c b/tools/testing/selftests/arm64/tags_test.c
new file mode 100644
index 000000000000..263b302874ed
--- /dev/null
+++ b/tools/testing/selftests/arm64/tags_test.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <stdint.h>
+#include <sys/utsname.h>
+
+int main(void)
+{
+	struct utsname *ptr;
+	int err;
+
+	ptr = (struct utsname *)malloc(sizeof(*ptr));
+	err = uname(ptr);
+	free(ptr);
+	return err;
+}
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

