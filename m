Return-Path: <linux-kselftest+bounces-19724-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAC999E4E7
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 13:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09EB1B249F7
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 11:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A301D2F40;
	Tue, 15 Oct 2024 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XK1hrJZl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABD9140E50;
	Tue, 15 Oct 2024 11:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990069; cv=none; b=Zr07S2Ybqqfk1/ndoUHjnrGkQ4+CjOnxz8GyJPUFCzXyz4hJrQ+UrzEq81wbu2wYCVQZmSn3fagslI6eUygSgLLRhidFTU7bNsqszkYm/I85VN6SCQ7oNHAH5eapHifdUV/D2ieF6Ak6ZRmYB3M06q7v1WLVtP5rPMw/hIKlx+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990069; c=relaxed/simple;
	bh=WB6mgSkA81g3/KEMsbSRyW2k533ipwlnb4WNkoNtomQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eQstQua2tUHjmPqNQPEAjyk3TZzHMV0WJy0hemgcQp24yrRfHtcpbLf0iZMZmbHejVy1XGE0XlXCi2tVFRM9TukJS05SOIvf2L/9SoYMsz8ZfQaCiiLssU/IjMzlcv5vPHCaH9rneOOPPK4XmIc4SI117fumpX0pCOyHj8GBODM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XK1hrJZl; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=cKk7J
	UQzl8vCMU2KIrJzQardE31VHcQXn8CelcJsQsc=; b=XK1hrJZlt9+w3WlkkdJPL
	+8imNMUKJ2WDpj9XaMG8m4rRcJffRN22Z1CZNl6uzhKJ+6hOgXznoZN8gjwsfIaA
	ruuTrVOT1nSIjI5F/2Q/Tmlw1+IehBgVnGRFNBvWcQLNodRzkaQGatBUK9Zp7BQd
	AqbxEI88O/zWTTSzj434CI=
Received: from localhost.localdomain (unknown [111.48.69.246])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3n+pgSw5nWa8pBQ--.29774S2;
	Tue, 15 Oct 2024 19:00:50 +0800 (CST)
From: zhouyuhang <zhouyuhang1010@163.com>
To: brauner@kernel.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhouyuhang <zhouyuhang@kylinos.cn>
Subject: [PATCH v2] selftests: clone3: Use the capget and capset syscall directly
Date: Tue, 15 Oct 2024 18:59:54 +0800
Message-Id: <20241015105955.126994-1-zhouyuhang1010@163.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n+pgSw5nWa8pBQ--.29774S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw4kWr4kGFW3AFykCw4rZrb_yoWruFyfpa
	48Zr45KFs5Wr1xGFW8AwsruF1rKF4kXF48Jr1UJw1j9r13Krn2yr4IkFykK3W2g3yDu3y5
	ua10gF4SvF1kJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bjpndUUUUU=
X-CM-SenderInfo: 52kr35xxkd0warqriqqrwthudrp/1tbiLwd5JmcOLWIswAABs8

From: zhouyuhang <zhouyuhang@kylinos.cn>

The libcap commit aca076443591 ("Make cap_t operations thread safe.")
added a __u8 mutex at the beginning of the struct _cap_struct, it changes
the offset of the members in the structure that breaks the assumption
made in the "struct libcap" definition in clone3_cap_checkpoint_restore.c.
This will make the test fail. So use the capget and capset syscall
directly and remove the libcap library dependency like the
commit 663af70aabb7 ("bpf: selftests: Add helpers to directly use
the capget and capset syscall") does.

Signed-off-by: zhouyuhang <zhouyuhang@kylinos.cn>
---
 tools/testing/selftests/clone3/Makefile       |  1 -
 .../clone3/clone3_cap_checkpoint_restore.c    | 53 ++++++++-----------
 .../selftests/clone3/clone3_cap_helpers.h     | 23 ++++++++
 3 files changed, 44 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/clone3/clone3_cap_helpers.h

diff --git a/tools/testing/selftests/clone3/Makefile b/tools/testing/selftests/clone3/Makefile
index 84832c369a2e..59d26e8da8d2 100644
--- a/tools/testing/selftests/clone3/Makefile
+++ b/tools/testing/selftests/clone3/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS += -g -std=gnu99 $(KHDR_INCLUDES)
-LDLIBS += -lcap
 
 TEST_GEN_PROGS := clone3 clone3_clear_sighand clone3_set_tid \
 	clone3_cap_checkpoint_restore
diff --git a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
index 3c196fa86c99..242088eeec88 100644
--- a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
+++ b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
@@ -15,7 +15,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdbool.h>
-#include <sys/capability.h>
 #include <sys/prctl.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
@@ -26,6 +25,7 @@
 
 #include "../kselftest_harness.h"
 #include "clone3_selftests.h"
+#include "clone3_cap_helpers.h"
 
 static void child_exit(int ret)
 {
@@ -87,47 +87,36 @@ static int test_clone3_set_tid(struct __test_metadata *_metadata,
 	return ret;
 }
 
-struct libcap {
-	struct __user_cap_header_struct hdr;
-	struct __user_cap_data_struct data[2];
-};
-
 static int set_capability(void)
 {
-	cap_value_t cap_values[] = { CAP_SETUID, CAP_SETGID };
-	struct libcap *cap;
-	int ret = -1;
-	cap_t caps;
-
-	caps = cap_get_proc();
-	if (!caps) {
-		perror("cap_get_proc");
+	struct __user_cap_data_struct data[2];
+	struct __user_cap_header_struct hdr = {
+		.version = _LINUX_CAPABILITY_VERSION_3,
+	};
+	__u32 cap0 = 1 << CAP_SETUID | 1 << CAP_SETGID;
+	__u32 cap1 = 1 << (CAP_CHECKPOINT_RESTORE - 32);
+	int ret;
+
+	ret = capget(&hdr, data);
+	if (ret) {
+		perror("capget");
 		return -1;
 	}
 
 	/* Drop all capabilities */
-	if (cap_clear(caps)) {
-		perror("cap_clear");
-		goto out;
-	}
+	memset(&data, 0, sizeof(data));
 
-	cap_set_flag(caps, CAP_EFFECTIVE, 2, cap_values, CAP_SET);
-	cap_set_flag(caps, CAP_PERMITTED, 2, cap_values, CAP_SET);
+	data[0].effective |= cap0;
+	data[0].permitted |= cap0;
 
-	cap = (struct libcap *) caps;
+	data[1].effective |= cap1;
+	data[1].permitted |= cap1;
 
-	/* 40 -> CAP_CHECKPOINT_RESTORE */
-	cap->data[1].effective |= 1 << (40 - 32);
-	cap->data[1].permitted |= 1 << (40 - 32);
-
-	if (cap_set_proc(caps)) {
-		perror("cap_set_proc");
-		goto out;
+	ret = capset(&hdr, data);
+	if (ret) {
+		perror("capset");
+		return -1;
 	}
-	ret = 0;
-out:
-	if (cap_free(caps))
-		perror("cap_free");
 	return ret;
 }
 
diff --git a/tools/testing/selftests/clone3/clone3_cap_helpers.h b/tools/testing/selftests/clone3/clone3_cap_helpers.h
new file mode 100644
index 000000000000..3fa59ef68fb8
--- /dev/null
+++ b/tools/testing/selftests/clone3/clone3_cap_helpers.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __CLONE3_CAP_HELPERS_H
+#define __CLONE3_CAP_HELPERS_H
+
+#include <linux/capability.h>
+
+/*
+ * Compatible with older version
+ * header file without defined
+ * CAP_CHECKPOINT_RESTORE.
+ */
+#ifndef CAP_CHECKPOINT_RESTORE
+#define CAP_CHECKPOINT_RESTORE 40
+#endif
+
+/*
+ * Removed the libcap library dependency.
+ * So declare them here directly.
+ */
+int capget(cap_user_header_t header, cap_user_data_t data);
+int capset(cap_user_header_t header, const cap_user_data_t data);
+
+#endif
-- 
2.27.0


