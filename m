Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D629133582
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2019 18:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbfFCQ43 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jun 2019 12:56:29 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:57138 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729735AbfFCQ4R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jun 2019 12:56:17 -0400
Received: by mail-qk1-f202.google.com with SMTP id q17so960045qkc.23
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Jun 2019 09:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=v9MzlIb7HY1yKtXIqdaDnLUOCgnoLYityVGh+V+FCFI=;
        b=E8Ist5LC6WVHrU8hj11VtWQb5rjU7iBORWjaptcqcX3l9oPWYIMo05KmXzzCVgt3cu
         lYJ4Yvl8mbNlJpJWSEYMIryL5scHXmPmVUqUSjI9X7Fuxa39wo8rzDRZFWMAkoj3uwjY
         mqiCqrBWPtOVkiL+4ZV5H/HhzxJmpTR97uHC/IdXM4tljhuvgYTiLw3741mzKX8NYLUt
         uc6Aqh8uuXDuaxHP4yeJ0XLPpMovyAE85DGwVCzioR0Gt6moVfBUOYshZAWVCnGUBbU4
         06NzOvSR4tkaeqT9+eniQMZF90V1u65K6kkbFscWsH7pqN+ptT1wb5JpdkKVZRneJwoH
         CGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=v9MzlIb7HY1yKtXIqdaDnLUOCgnoLYityVGh+V+FCFI=;
        b=bPZRPehbM0ALLz3IE7ywncHSxabpX6yZo5QU7nxRuW2l3j5IKelIAcddP07mbfo3Up
         79RmXns6zxWyOTaUtTkoy3PwnsrGkR1Xn0AnDhTyrylgQsDW3YiEuiEbkr7NL8nXIISv
         eh4QXxSbhU2vYoVOojG3mXsAaf2Mue26Hn/q0amPilOk+utyk12+IKbnmS21s/VN6MmE
         sVhOrOCC+bZqZYYuiXVmBsfqkMO+h7DGlDTwdFpt8gJYJKUIfegVTDBRjQJdmnzbQbkJ
         1UOjbZwzRdfkK0+qbKvYupL4Uq4R8Zf4zruMYRVsF7cM6sVMb6Chd14k1apXkAWpaHV4
         Cu1Q==
X-Gm-Message-State: APjAAAVx/SFqw9DdaBy//85hkKrRChQAmFb1hvNtmDhkHuxdyz0+k1st
        drYJNIIpohVO8G5kgW49wq6TludqSzJxg0Dj
X-Google-Smtp-Source: APXvYqyupRnjjQO94efnTljbt6p9DxywyyDuZaQUfwBf3Y405Fl40dWCznelJThhDpEIkj52c6mVbKSb6DjD/rvF
X-Received: by 2002:a37:de06:: with SMTP id h6mr3881914qkj.322.1559580976267;
 Mon, 03 Jun 2019 09:56:16 -0700 (PDT)
Date:   Mon,  3 Jun 2019 18:55:18 +0200
In-Reply-To: <cover.1559580831.git.andreyknvl@google.com>
Message-Id: <9e1b5998a28f82b16076fc85ab4f88af5381cf74.1559580831.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1559580831.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH v16 16/16] selftests, arm64: add a selftest for passing tagged
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

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 tools/testing/selftests/arm64/.gitignore      |  1 +
 tools/testing/selftests/arm64/Makefile        | 22 ++++++++++
 .../testing/selftests/arm64/run_tags_test.sh  | 12 ++++++
 tools/testing/selftests/arm64/tags_lib.c      | 42 +++++++++++++++++++
 tools/testing/selftests/arm64/tags_test.c     | 18 ++++++++
 5 files changed, 95 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/.gitignore
 create mode 100644 tools/testing/selftests/arm64/Makefile
 create mode 100755 tools/testing/selftests/arm64/run_tags_test.sh
 create mode 100644 tools/testing/selftests/arm64/tags_lib.c
 create mode 100644 tools/testing/selftests/arm64/tags_test.c

diff --git a/tools/testing/selftests/arm64/.gitignore b/tools/testing/selftests/arm64/.gitignore
new file mode 100644
index 000000000000..e8fae8d61ed6
--- /dev/null
+++ b/tools/testing/selftests/arm64/.gitignore
@@ -0,0 +1 @@
+tags_test
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
index 000000000000..8a674509216e
--- /dev/null
+++ b/tools/testing/selftests/arm64/tags_lib.c
@@ -0,0 +1,42 @@
+#include <stdlib.h>
+
+#define TAG_SHIFT	(56)
+#define TAG_MASK	(0xffUL << TAG_SHIFT)
+
+void *__libc_malloc(size_t size);
+void __libc_free(void *ptr);
+void *__libc_realloc(void *ptr, size_t size);
+void *__libc_calloc(size_t nmemb, size_t size);
+
+static void *tag_ptr(void *ptr)
+{
+	unsigned long tag = rand() & 0xff;
+	if (!ptr)
+		return ptr;
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
2.22.0.rc1.311.g5d7573a151-goog

