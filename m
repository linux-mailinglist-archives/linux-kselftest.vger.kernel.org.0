Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3413D71E56
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2019 20:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391440AbfGWR75 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Jul 2019 13:59:57 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:41190 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391434AbfGWR74 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Jul 2019 13:59:56 -0400
Received: by mail-pg1-f202.google.com with SMTP id b18so26447255pgg.8
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jul 2019 10:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jOShWl3tVsknYDB/YoUvrUIV3eQMt6LYV5d/jQUs6fk=;
        b=h3Kq7We2lcnT64/ZTs7I4tdBthajlqrQq0s3uG0rcdUUGUvc4KeWtl8Lap+IaEU0xC
         yYJQXzHFT7D2Jqscee4HDCwPCbx8Wu4vGwr8iHjoxORK9KGqLusafVkNZ/vi+rdiyHeG
         jdIKwPH4OSoAMEvF/wL6dPzkou8jWXYcRntfsmvla/c6SEeJlZfF2ghZPEbGkeY9ptz1
         cvZXKirYuxY3KSRTfpbbshoiYk3G2vA59VITNzPxXSGn8hhh7sloFpM7Eqe6wa8z0eYK
         HPQ0vNQ1FWKABTpWUeLw9Zvt3IMDsn825fB13HkZ/3l6+zJgRTNpYSRvvg1VGXgpvW9L
         /8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jOShWl3tVsknYDB/YoUvrUIV3eQMt6LYV5d/jQUs6fk=;
        b=VQfcoYlJlpXyEloj3SO/IkrfZ8Fa46c1qmuU2a/ayZZAn+9SEWlkZwnxgVlgx/MX6K
         rqgNDpKEP6FaQuI2X2Mfm+SvTj9LY0L4LaxY+Fy1hmV9tAS0I8MRT25Qm+HOKVX56aWS
         UX7+n+LGsKg+RPyAd3rYW+ZahgdbNKRtrfmRrklT79WaMPyaDfiVxBPfYukVhD3SlcJY
         aAQJZYF1VLlY/pBDpeiROPTrDBGvDpSMDFsY/3BTkkvlFmR2jNpHDs6AKmhSyG7uqj7N
         i9Hq7txdmhZ+VxAFhil8UnWKt+8qIiKu6lqkG84v3tDNbFg6hTd9h8Gq4Ygz8Y8rSMQq
         jnWA==
X-Gm-Message-State: APjAAAW58HabIjI8Uyh/ooli59bBpiDNOTFihj/0eRzPn0PgO3Pcz2dF
        2+dw/C6Hg4ZCOz3jrhR9vbjyI6qWNT7TPoJm
X-Google-Smtp-Source: APXvYqxAti31RDws7lqydpjpU2QNSIYIBexpp6X7xTgogP1B1IYuH3vnzKrv44nIChFaGEFwrbMkdTHOIZSmLzhz
X-Received: by 2002:a65:5a44:: with SMTP id z4mr77715645pgs.41.1563904795339;
 Tue, 23 Jul 2019 10:59:55 -0700 (PDT)
Date:   Tue, 23 Jul 2019 19:58:52 +0200
In-Reply-To: <cover.1563904656.git.andreyknvl@google.com>
Message-Id: <c1e6aad230658bc175b42d92daeff2e30050302a.1563904656.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1563904656.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v19 15/15] selftests, arm64: add a selftest for passing tagged
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

This patch is a part of a series that extends kernel ABI to allow to pass
tagged user pointers (with the top byte set to something else other than
0x00) as syscall arguments.

This patch adds a simple test, that calls the uname syscall with a
tagged user pointer as an argument. Without the kernel accepting tagged
user pointers the test fails with EFAULT.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 tools/testing/selftests/arm64/.gitignore      |  1 +
 tools/testing/selftests/arm64/Makefile        | 11 +++++++
 .../testing/selftests/arm64/run_tags_test.sh  | 12 ++++++++
 tools/testing/selftests/arm64/tags_test.c     | 29 +++++++++++++++++++
 4 files changed, 53 insertions(+)
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
index 000000000000..22a1b266e373
--- /dev/null
+++ b/tools/testing/selftests/arm64/tags_test.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <stdint.h>
+#include <sys/prctl.h>
+#include <sys/utsname.h>
+
+#define SHIFT_TAG(tag)		((uint64_t)(tag) << 56)
+#define SET_TAG(ptr, tag)	(((uint64_t)(ptr) & ~SHIFT_TAG(0xff)) | \
+					SHIFT_TAG(tag))
+
+int main(void)
+{
+	static int tbi_enabled = 0;
+	struct utsname *ptr, *tagged_ptr;
+	int err;
+
+	if (prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE, 0, 0, 0) == 0)
+		tbi_enabled = 1;
+	ptr = (struct utsname *)malloc(sizeof(*ptr));
+	if (tbi_enabled)
+		tagged_ptr = (struct utsname *)SET_TAG(ptr, 0x42);
+	err = uname(tagged_ptr);
+	free(ptr);
+
+	return err;
+}
-- 
2.22.0.709.g102302147b-goog

