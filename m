Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4E82441A8
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Aug 2020 01:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgHMXRd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Aug 2020 19:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgHMXRd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Aug 2020 19:17:33 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C493C061757
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Aug 2020 16:17:33 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t6so3492954pjr.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Aug 2020 16:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=je3KSpIjI3wvANb9VcFMRGLZNy0cfgXLnoS5OnXYTBM=;
        b=E+mt3KktBCuCw0CsI9AxdLJT/hulhgjpdJnXypAlW5gFncTk1SvR75YudGwrAml8XU
         +NayG/nqwRGS7lRpZUIl0xKi01/jhBSRPNEaa5pd41voyn1oxGEzz4U/GNUno82VmaXd
         uDyA8w1SCHMLF9JlBorNgMqgr9ILbbpM9eTEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=je3KSpIjI3wvANb9VcFMRGLZNy0cfgXLnoS5OnXYTBM=;
        b=sx9IsFnheq6ySelX19PawYh8Nv6cYuv+8KS/54Uyzp29iM56iLlIlK0bzRrXkCtz72
         eGdApvaSp5EQx7Huwebbrqxpaw2f3daZAn0LPTqPxGa4pOPNzDyDyqap6pNah9JYNiky
         8rV5aB8v5GYUBrNUb7IgMONtszhzkFrdvmTliYZsGhKo3urmHjv3K84QhZp22E+Kt4tb
         m8Cr8d1kZBIBRWt1B5cJZHjivI/WxakweFj+tFEI+/iZT5gkEWD47HvSt1+zUGWOIkPp
         1h9x3/haLmGGRXohMJ/ju1C3K+RS0f6HuDDlJ68iPRzidTKMWW1h0QTJO5esjJEvvgKr
         hjzg==
X-Gm-Message-State: AOAM530KvuWPVQzlBDv/sxAD0ofTJfsS2FLUo7p8yyBdl0q4oX0eR17w
        e+10OzyDmvuAXuULK5W9+26Wdw==
X-Google-Smtp-Source: ABdhPJwZ++qumA7ue1MbY4n3tjkb6EbPUT2BCumPlbJqhbAx7/TTn5jEEoLTvAX8bjFpFkPYyLsO1w==
X-Received: by 2002:a17:902:9787:: with SMTP id q7mr100868plp.0.1597360652861;
        Thu, 13 Aug 2020 16:17:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e20sm6259211pjr.28.2020.08.13.16.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 16:17:30 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] selftests/exec: Add file type errno tests
Date:   Thu, 13 Aug 2020 16:17:23 -0700
Message-Id: <20200813231723.2725102-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200813231723.2725102-1-keescook@chromium.org>
References: <20200813231723.2725102-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Make sure execve() returns the expected errno values for non-regular
files.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/exec/.gitignore    |   1 +
 tools/testing/selftests/exec/Makefile      |   5 +-
 tools/testing/selftests/exec/non-regular.c | 196 +++++++++++++++++++++
 3 files changed, 200 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/exec/non-regular.c

diff --git a/tools/testing/selftests/exec/.gitignore b/tools/testing/selftests/exec/.gitignore
index 94b02a18f230..344a99c6da1b 100644
--- a/tools/testing/selftests/exec/.gitignore
+++ b/tools/testing/selftests/exec/.gitignore
@@ -10,3 +10,4 @@ execveat.denatured
 /recursion-depth
 xxxxxxxx*
 pipe
+S_I*.test
diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index 4453b8f8def3..0a13b110c1e6 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -3,7 +3,7 @@ CFLAGS = -Wall
 CFLAGS += -Wno-nonnull
 CFLAGS += -D_GNU_SOURCE
 
-TEST_PROGS := binfmt_script
+TEST_PROGS := binfmt_script non-regular
 TEST_GEN_PROGS := execveat
 TEST_GEN_FILES := execveat.symlink execveat.denatured script subdir pipe
 # Makefile is a run-time dependency, since it's accessed by the execveat test
@@ -11,7 +11,8 @@ TEST_FILES := Makefile
 
 TEST_GEN_PROGS += recursion-depth
 
-EXTRA_CLEAN := $(OUTPUT)/subdir.moved $(OUTPUT)/execveat.moved $(OUTPUT)/xxxxx*
+EXTRA_CLEAN := $(OUTPUT)/subdir.moved $(OUTPUT)/execveat.moved $(OUTPUT)/xxxxx*	\
+	       $(OUTPUT)/S_I*.test
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/exec/non-regular.c b/tools/testing/selftests/exec/non-regular.c
new file mode 100755
index 000000000000..cd3a34aca93e
--- /dev/null
+++ b/tools/testing/selftests/exec/non-regular.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/sysmacros.h>
+#include <sys/types.h>
+
+#include "../kselftest_harness.h"
+
+/* Remove a file, ignoring the result if it didn't exist. */
+void rm(struct __test_metadata *_metadata, const char *pathname,
+	int is_dir)
+{
+	int rc;
+
+	if (is_dir)
+		rc = rmdir(pathname);
+	else
+		rc = unlink(pathname);
+
+	if (rc < 0) {
+		ASSERT_EQ(errno, ENOENT) {
+			TH_LOG("Not ENOENT: %s", pathname);
+		}
+	} else {
+		ASSERT_EQ(rc, 0) {
+			TH_LOG("Failed to remove: %s", pathname);
+		}
+	}
+}
+
+FIXTURE(file) {
+	char *pathname;
+	int is_dir;
+};
+
+FIXTURE_VARIANT(file)
+{
+	const char *name;
+	int expected;
+	int is_dir;
+	void (*setup)(struct __test_metadata *_metadata,
+		      FIXTURE_DATA(file) *self,
+		      const FIXTURE_VARIANT(file) *variant);
+	int major, minor, mode; /* for mknod() */
+};
+
+void setup_link(struct __test_metadata *_metadata,
+		FIXTURE_DATA(file) *self,
+		const FIXTURE_VARIANT(file) *variant)
+{
+	const char * const paths[] = {
+		"/bin/true",
+		"/usr/bin/true",
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(paths); i++) {
+		if (access(paths[i], X_OK) == 0) {
+			ASSERT_EQ(symlink(paths[i], self->pathname), 0);
+			return;
+		}
+	}
+	ASSERT_EQ(1, 0) {
+		TH_LOG("Could not find viable 'true' binary");
+	}
+}
+
+FIXTURE_VARIANT_ADD(file, S_IFLNK)
+{
+	.name = "S_IFLNK",
+	.expected = ELOOP,
+	.setup = setup_link,
+};
+
+void setup_dir(struct __test_metadata *_metadata,
+	       FIXTURE_DATA(file) *self,
+	       const FIXTURE_VARIANT(file) *variant)
+{
+	ASSERT_EQ(mkdir(self->pathname, 0755), 0);
+}
+
+FIXTURE_VARIANT_ADD(file, S_IFDIR)
+{
+	.name = "S_IFDIR",
+	.is_dir = 1,
+	.expected = EACCES,
+	.setup = setup_dir,
+};
+
+void setup_node(struct __test_metadata *_metadata,
+		FIXTURE_DATA(file) *self,
+		const FIXTURE_VARIANT(file) *variant)
+{
+	dev_t dev;
+	int rc;
+
+	dev = makedev(variant->major, variant->minor);
+	rc = mknod(self->pathname, 0755 | variant->mode, dev);
+	ASSERT_EQ(rc, 0) {
+		if (errno == EPERM)
+			SKIP(return, "Please run as root; cannot mknod(%s)",
+				variant->name);
+	}
+}
+
+FIXTURE_VARIANT_ADD(file, S_IFBLK)
+{
+	.name = "S_IFBLK",
+	.expected = EACCES,
+	.setup = setup_node,
+	/* /dev/loop0 */
+	.major = 7,
+	.minor = 0,
+	.mode = S_IFBLK,
+};
+
+FIXTURE_VARIANT_ADD(file, S_IFCHR)
+{
+	.name = "S_IFCHR",
+	.expected = EACCES,
+	.setup = setup_node,
+	/* /dev/zero */
+	.major = 1,
+	.minor = 5,
+	.mode = S_IFCHR,
+};
+
+void setup_fifo(struct __test_metadata *_metadata,
+		FIXTURE_DATA(file) *self,
+		const FIXTURE_VARIANT(file) *variant)
+{
+	ASSERT_EQ(mkfifo(self->pathname, 0755), 0);
+}
+
+FIXTURE_VARIANT_ADD(file, S_IFIFO)
+{
+	.name = "S_IFIFO",
+	.expected = EACCES,
+	.setup = setup_fifo,
+};
+
+FIXTURE_SETUP(file)
+{
+	ASSERT_GT(asprintf(&self->pathname, "%s.test", variant->name), 6);
+	self->is_dir = variant->is_dir;
+
+	rm(_metadata, self->pathname, variant->is_dir);
+	variant->setup(_metadata, self, variant);
+}
+
+FIXTURE_TEARDOWN(file)
+{
+	rm(_metadata, self->pathname, self->is_dir);
+}
+
+TEST_F(file, exec_errno)
+{
+	char * const argv[2] = { (char * const)self->pathname, NULL };
+
+	EXPECT_LT(execv(argv[0], argv), 0);
+	EXPECT_EQ(errno, variant->expected);
+}
+
+/* S_IFSOCK */
+FIXTURE(sock)
+{
+	int fd;
+};
+
+FIXTURE_SETUP(sock)
+{
+	self->fd = socket(AF_INET, SOCK_STREAM, 0);
+	ASSERT_GE(self->fd, 0);
+}
+
+FIXTURE_TEARDOWN(sock)
+{
+	if (self->fd >= 0)
+		ASSERT_EQ(close(self->fd), 0);
+}
+
+TEST_F(sock, exec_errno)
+{
+	char * const argv[2] = { " magic socket ", NULL };
+	char * const envp[1] = { NULL };
+
+	EXPECT_LT(fexecve(self->fd, argv, envp), 0);
+	EXPECT_EQ(errno, EACCES);
+}
+
+TEST_HARNESS_MAIN
-- 
2.25.1

