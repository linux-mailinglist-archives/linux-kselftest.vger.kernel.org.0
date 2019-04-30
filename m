Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5B07FA0F
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2019 15:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbfD3N0T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Apr 2019 09:26:19 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:51140 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbfD3N0M (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Apr 2019 09:26:12 -0400
Received: by mail-qk1-f201.google.com with SMTP id u65so11730925qkd.17
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2019 06:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CUfyrLNe/T3EcKv5qduPdE7e3xDRgpU9AlrvCv3qwqI=;
        b=ACzTueebTGZuzKKoCgKBIgO56T+v/kmKwHjurWtS7UbHoL/8XDJlDb5ck/BSEBSEkL
         L/cpQLHEpHyLmFxTqXzMv0MYxpPJ/tdSuF6iSO5LSNmbylvOUvYffcEQgPGf+AHIVemF
         X7c/hUL69n/uOjY+uNJSNPAVfbcNbVaSMzD0uei9BaIXpxtVKCRwsIlHAcYOHL9EFavB
         iCJAtq03WGCgnaX+tP7fN2qD5Hnfneud42YH1gQK4xFPHVYPeqPOAqGnfhU4Bvx5JZ4h
         WVQJpJkjflxIoXEbOmqcqlW6kZy64vV5a1g9LW1u4aQq8hQq2UTluPLfVENOwe2MSfHQ
         GaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CUfyrLNe/T3EcKv5qduPdE7e3xDRgpU9AlrvCv3qwqI=;
        b=eqBcpq7EsNnJk/lnDyzQnMBCliZVLqeWtmV4TaFtsdsG7eLYcgI3jOG2Dq3e622htg
         9ev1/9iMbymL/1TG5lbQpvCWHphGuLuQVRbdGfFwKzD597bpYe2mr1uw4a7w+mLac4A7
         Nu5tH/iGBemhW2r3RrloTwZwztnjKz3DZEXrvu0lEbbwgCpDkh9koL3NGGJrSK3XnBAn
         pyOX4lLnm0+ZRGRHmXuIzVQbp9yxLf1RL3YqZ4sArYt9/ASSa+wTTwgSdc8RbTDHvRp8
         SSlWTqiEDfzweAaUBHnFpoFC6hlkVBdbSCOnR5ze3OxnlSiA5+P2+K6oqSJBPmggnAi/
         CcLA==
X-Gm-Message-State: APjAAAUYN2iz86GFozRaFmWFw3c0YCVCJOwAH8l2avIlEHQIm55jZPKY
        HvDci4z9KVJYKoq4bLw+sf90XYXsCn1lv2yC
X-Google-Smtp-Source: APXvYqysB3GTYMj0WGj5xIZkllIRnPABiLNbQUXAXOCL1Y4t6SI5ksxcGzuX1TZYAhDJVUrbxfYKc2E7kTYKjt+4
X-Received: by 2002:a05:620a:482:: with SMTP id 2mr43219855qkr.323.1556630770597;
 Tue, 30 Apr 2019 06:26:10 -0700 (PDT)
Date:   Tue, 30 Apr 2019 15:25:13 +0200
In-Reply-To: <cover.1556630205.git.andreyknvl@google.com>
Message-Id: <d8f017e7ab36f698d05e6cc775115730c917ca77.1556630205.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1556630205.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH v14 17/17] selftests, arm64: add a selftest for passing tagged
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
        Yishai Hadas <yishaih@mellanox.com>, Kuehling@google.com,
        Felix <Felix.Kuehling@amd.com>, Deucher@google.com,
        Alexander <Alexander.Deucher@amd.com>, Koenig@google.com,
        Christian <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
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
 tools/testing/selftests/arm64/Makefile        | 11 ++++++++++
 .../testing/selftests/arm64/run_tags_test.sh  | 12 +++++++++++
 tools/testing/selftests/arm64/tags_test.c     | 21 +++++++++++++++++++
 4 files changed, 45 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/.gitignore
 create mode 100644 tools/testing/selftests/arm64/Makefile
 create mode 100755 tools/testing/selftests/arm64/run_tags_test.sh
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
index 000000000000..a61b2e743e99
--- /dev/null
+++ b/tools/testing/selftests/arm64/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# ARCH can be overridden by the user for cross compiling
+ARCH ?= $(shell uname -m 2>/dev/null || echo not)
+
+ifneq (,$(filter $(ARCH),aarch64 arm64))
+TEST_GEN_PROGS := tags_test
+TEST_PROGS := run_tags_test.sh
+endif
+
+include ../lib.mk
diff --git a/tools/testing/selftests/arm64/run_tags_test.sh b/tools/testing/selftests/arm64/run_tags_test.sh
new file mode 100755
index 000000000000..745f11379930
--- /dev/null
+++ b/tools/testing/selftests/arm64/run_tags_test.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+echo "--------------------"
+echo "running tags test"
+echo "--------------------"
+./tags_test
+if [ $? -ne 0 ]; then
+	echo "[FAIL]"
+else
+	echo "[PASS]"
+fi
diff --git a/tools/testing/selftests/arm64/tags_test.c b/tools/testing/selftests/arm64/tags_test.c
new file mode 100644
index 000000000000..2bd1830a7ebe
--- /dev/null
+++ b/tools/testing/selftests/arm64/tags_test.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <stdint.h>
+#include <sys/utsname.h>
+
+#define SHIFT_TAG(tag)		((uint64_t)(tag) << 56)
+#define SET_TAG(ptr, tag)	(((uint64_t)(ptr) & ~SHIFT_TAG(0xff)) | \
+					SHIFT_TAG(tag))
+
+int main(void)
+{
+	struct utsname *ptr = (struct utsname *)malloc(sizeof(*ptr));
+	void *tagged_ptr = (void *)SET_TAG(ptr, 0x42);
+	int err = uname(tagged_ptr);
+
+	free(ptr);
+	return err;
+}
-- 
2.21.0.593.g511ec345e18-goog

