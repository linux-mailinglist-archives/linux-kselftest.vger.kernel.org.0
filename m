Return-Path: <linux-kselftest+bounces-2715-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD3C82748D
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 16:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAAF4284A21
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 15:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B0E5103E;
	Mon,  8 Jan 2024 15:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="PvdeB1hS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA5352F71
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Jan 2024 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1704729115;
	bh=Ij+3Ix3Kb6+ZSZanXqYqNIh8zHKZtPuZeycz8V73gG4=;
	h=From:To:Cc:Subject:Date;
	b=PvdeB1hS3Pq86PKeL3eqV0KaQ8w9LtY4b6x0pxUgWm8Q6klkGgEBcitmiPnzq6o8G
	 ATHiURZKKv5NugiRAKCABcPVMlYAqvnLNNd+2W2dTZyoRVhYRAvSeicy6v3ndnPvj+
	 fVud2jR4kDQ9ggXQG21zXfcB0D90E4LTyZnSY/FU=
Received: from localhost.localdomain ([2409:8a60:2a63:2f30:4bcb:13ed:5b05:9ecd])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id CF306402; Mon, 08 Jan 2024 23:51:51 +0800
X-QQ-mid: xmsmtpt1704729111trkm971hy
Message-ID: <tencent_3C9A298878D22B5D8F79DC2FEE99BB4A8F05@qq.com>
X-QQ-XMAILINFO: NhUkPfKlCtQwYYTj5BM41Da47XdYIN0Aqf80Ha1rwlfNNQbfTlo7hvwJnDp3S2
	 5u0vTsM1Xcyjon9qX2Oh6+svAepkkKNenUt/ZuyFnG+8h9zZUu1eSHUs1JCtQc/angeMNJyqlexP
	 xKlFBe7jCcW4RAhRjSiugTkUyqWJ11omvsCQ/Cx2hY1tuQm952qfNsy2mY7mpjz+M9UXncT/nPsd
	 n36lM6L+pKWL62RMCOjhEpw/ZDx/dToGm38h19a7rKTi0GdAtZ86d/rEaeiZMKBsA1G323LckkyX
	 i7XO80lhIHI4dL5ThOYauj7PEOjrWKo11QZ6y6+zOAZN8hp/qXQeNmlY+IMVu4Gs0xyMvGAJ7VYf
	 EcNdcZsbjZQ0HEziNxbVw7DNvBgwG1lgixuZ8LeAGRZR8FFQlrApWlrfM5Xp2SagYEm30towE1BU
	 6F5xpYJeJNBw/y7IFNoKKN4NIWqU7KifN+vnJUE6QC3g50yys/Yhd/cZ0Te1deWJeZc9Rdtl/SHb
	 EU1Iwqzxy8Kf8Yf7jQ7uY5vMUALKktLathT9hFd3lJq1BVKwL3h9PVyot0WIAl8UevrDj+awHiXe
	 S1vwNtx3wieN37sGVVdZtR0SUwCngB71htTTXNFqgjVvWAFYLNfL0aLUavya0xLfdY4LAipctSFd
	 hWebDNQ93flcH8rhR5UANgeG6ATdTnpDDdDvptkR1iAvrTU/uOCcvzkBTfn3jQJnlU4lvpkSrgDI
	 UD5wTgYwfb+PL7vRTWlB4jxB6YcxBiqhZUiB9SfyfCqwMeVaVPNX/h8AlTeUEwCWNrAccBoSOiqf
	 HaGHL51JBrg98AGzWinqYtnB1IiO13MIHD0eZgawxIegsd11blQJgyv1lewBnrKgpqhhC9MANQVW
	 YaEegcWIsbn/jsZcKoimIdM0kmgyGTW6/70gUk1N8SlixZWJxz+mUUz+IPnk7EKv6tiJ5x3SNlSH
	 M3Q34vIaXk1a6BGLcViyah7I7Vo2P3aqbpQ2jKiArM0o8/hnaB/xVla9YQSoztgkS51nIynVGzvS
	 ZdEBd+YftEAn3kPnzAYxZL/bp6CLWDiI0FlQ9As6CVDMmvU45g
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: wenyang.linux@foxmail.com
To: Shuah Khan <skhan@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Wen Yang <wenyang.linux@foxmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Pengfei Xu <pengfei.xu@intel.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Andrei Vagin <avagin@google.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: add eventfd selftests
Date: Mon,  8 Jan 2024 23:51:32 +0800
X-OQ-MSGID: <20240108155132.9153-1-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wenyang.linux@foxmail.com>

This adds the promised selftest for eventfd. It will verify the flags
of eventfd2, including EFD_CLOEXEC,  EFD_NONBLOCK and EFD_SEMAPHORE.

Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Pengfei Xu <pengfei.xu@intel.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Andrei Vagin <avagin@google.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 .../selftests/filesystems/eventfd/.gitignore  |   2 +
 .../selftests/filesystems/eventfd/Makefile    |   7 +
 .../filesystems/eventfd/eventfd_test.c        | 186 ++++++++++++++++++
 3 files changed, 195 insertions(+)
 create mode 100644 tools/testing/selftests/filesystems/eventfd/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/eventfd/Makefile
 create mode 100644 tools/testing/selftests/filesystems/eventfd/eventfd_test.c

diff --git a/tools/testing/selftests/filesystems/eventfd/.gitignore b/tools/testing/selftests/filesystems/eventfd/.gitignore
new file mode 100644
index 000000000000..483faf59fe4a
--- /dev/null
+++ b/tools/testing/selftests/filesystems/eventfd/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+eventfd_test
diff --git a/tools/testing/selftests/filesystems/eventfd/Makefile b/tools/testing/selftests/filesystems/eventfd/Makefile
new file mode 100644
index 000000000000..0a8e3910df15
--- /dev/null
+++ b/tools/testing/selftests/filesystems/eventfd/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CFLAGS += $(KHDR_INCLUDES)
+LDLIBS += -lpthread
+TEST_GEN_PROGS := eventfd_test
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/filesystems/eventfd/eventfd_test.c b/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
new file mode 100644
index 000000000000..f142a137526c
--- /dev/null
+++ b/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <asm/unistd.h>
+#include <linux/time_types.h>
+#include <unistd.h>
+#include <assert.h>
+#include <signal.h>
+#include <pthread.h>
+#include <sys/epoll.h>
+#include <sys/eventfd.h>
+#include "../../kselftest_harness.h"
+
+struct error {
+	int  code;
+	char msg[512];
+};
+
+static int error_set(struct error *err, int code, const char *fmt, ...)
+{
+	va_list args;
+	int r;
+
+	if (code == 0 || !err || err->code != 0)
+		return code;
+
+	err->code = code;
+	va_start(args, fmt);
+	r = vsnprintf(err->msg, sizeof(err->msg), fmt, args);
+	assert((size_t)r < sizeof(err->msg));
+	va_end(args);
+
+	return code;
+}
+
+static inline int sys_eventfd2(unsigned int count, int flags)
+{
+	return syscall(__NR_eventfd2, count, flags);
+}
+
+TEST(eventfd01)
+{
+	int fd, flags;
+
+	fd = sys_eventfd2(0, 0);
+	ASSERT_GE(fd, 0);
+
+	flags = fcntl(fd, F_GETFL);
+	// since the kernel automatically added O_RDWR.
+	EXPECT_EQ(flags, O_RDWR);
+
+	close(fd);
+}
+
+TEST(eventfd02)
+{
+	int fd, flags;
+
+	fd = sys_eventfd2(0, EFD_CLOEXEC);
+	ASSERT_GE(fd, 0);
+
+	flags = fcntl(fd, F_GETFD);
+	ASSERT_GT(flags, -1);
+	EXPECT_EQ(flags, FD_CLOEXEC);
+
+	close(fd);
+}
+
+TEST(eventfd03)
+{
+	int fd, flags;
+
+	fd = sys_eventfd2(0, EFD_NONBLOCK);
+	ASSERT_GE(fd, 0);
+
+	flags = fcntl(fd, F_GETFL);
+	ASSERT_GT(flags, -1);
+	EXPECT_EQ(flags & EFD_NONBLOCK, EFD_NONBLOCK);
+	EXPECT_EQ(flags & O_RDWR, O_RDWR);
+
+	close(fd);
+}
+
+TEST(eventfd04)
+{
+	int fd, flags;
+
+	fd = sys_eventfd2(0, EFD_CLOEXEC|EFD_NONBLOCK);
+	ASSERT_GE(fd, 0);
+
+	flags = fcntl(fd, F_GETFL);
+	ASSERT_GT(flags, -1);
+	EXPECT_EQ(flags & EFD_NONBLOCK, EFD_NONBLOCK);
+	EXPECT_EQ(flags & O_RDWR, O_RDWR);
+
+	flags = fcntl(fd, F_GETFD);
+	ASSERT_GT(flags, -1);
+	EXPECT_EQ(flags, FD_CLOEXEC);
+
+	close(fd);
+}
+
+static inline void trim_newline(char *str)
+{
+	char *pos = strrchr(str, '\n');
+
+	if (pos)
+		*pos = '\0';
+}
+
+static int verify_fdinfo(int fd, struct error *err, const char *prefix,
+		size_t prefix_len, const char *expect, ...)
+{
+	char buffer[512] = {0, };
+	char path[512] = {0, };
+	va_list args;
+	FILE *f;
+	char *line = NULL;
+	size_t n = 0;
+	int found = 0;
+	int r;
+
+	va_start(args, expect);
+	r = vsnprintf(buffer, sizeof(buffer), expect, args);
+	assert((size_t)r < sizeof(buffer));
+	va_end(args);
+
+	snprintf(path, sizeof(path), "/proc/self/fdinfo/%d", fd);
+	f = fopen(path, "re");
+	if (!f)
+		return error_set(err, -1, "fdinfo open failed for %d", fd);
+
+	while (getline(&line, &n, f) != -1) {
+		char *val;
+
+		if (strncmp(line, prefix, prefix_len))
+			continue;
+
+		found = 1;
+
+		val = line + prefix_len;
+		r = strcmp(val, buffer);
+		if (r != 0) {
+			trim_newline(line);
+			trim_newline(buffer);
+			error_set(err, -1, "%s '%s' != '%s'",
+				  prefix, val, buffer);
+		}
+		break;
+	}
+
+	free(line);
+	fclose(f);
+
+	if (found == 0)
+		return error_set(err, -1, "%s not found for fd %d",
+				 prefix, fd);
+
+	return 0;
+}
+
+TEST(eventfd05)
+{
+	struct error err = {0};
+	int fd, ret;
+
+	fd = sys_eventfd2(0, EFD_SEMAPHORE);
+	ASSERT_GE(fd, 0);
+
+	ret = fcntl(fd, F_GETFL);
+	ASSERT_GT(ret, -1);
+	EXPECT_EQ(ret & O_RDWR, O_RDWR);
+
+	// The semaphore could only be obtained from fdinfo.
+	ret = verify_fdinfo(fd, &err, "eventfd-semaphore: ", 19, "1\n");
+	if (ret != 0)
+		ksft_print_msg("eventfd-semaphore check failed, msg: %s\n",
+				err.msg);
+	EXPECT_EQ(ret, 0);
+
+	close(fd);
+}
+
+TEST_HARNESS_MAIN
-- 
2.25.1


