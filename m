Return-Path: <linux-kselftest+bounces-19439-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB459985B5
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 14:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF09D1F24C34
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 12:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC031C3F2E;
	Thu, 10 Oct 2024 12:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dV8gNvvL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2461C1757;
	Thu, 10 Oct 2024 12:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728562610; cv=none; b=qatPeQ4YGBTQnzTuYOEdi2r18iqnjDrtDQEkLzF7NN87AjcP2UtHs44wNczMa0M4gKPGL+5IH6OEa8MOlLw1qottwsO2N00OBu2Mg/Qf7spaza4bqqG2b6A+ZsjPN+2orhU9MFobPwG7dnibCftoaYXbZ4Ss34h44xmHM/dJRyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728562610; c=relaxed/simple;
	bh=JlN+IEE8f60b5rmJlRrq0+QGyCcqd8Nbz8qgQGAtDis=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fpb1tLA27QajygPq0skR+oV/84IBrl1wybHj+2vVJ5tbV/pDzkouZg2fzJkNxZD9b3VkzMSEN5Xq6mvp5ByJuZk96qgZO4BCWznDqJG/pc9ML13srPW66w2MQXy8qJOInHIeWyEiEmVQEMCVA5Q36quuKecW5O3k+9Q4Y7cWi0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dV8gNvvL; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=FwZEo
	Qbh7XIcVq3Cr34Mkf7BD6LjFols82/8TIr1Bas=; b=dV8gNvvL44yT3nR0ZhWn7
	+hWIrSo4pub3hJwdtetI/8gor+7JReK3yF73UiltbW64oTUNjo/KvqS27bQMQ4wC
	jk/1niM0Rjj4YMU/tTcUS+WOWswaU1osxAdZTs3PbX6XumIVVhsSYFmnp6TjdAZy
	VYBRmhWWbiGz/025GK29uE=
Received: from localhost.localdomain (unknown [111.48.69.246])
	by gzsmtp1 (Coremail) with SMTP id sCgvCgDHC0GZxQdntQ3_AA--.42378S2;
	Thu, 10 Oct 2024 20:16:26 +0800 (CST)
From: zhouyuhang <zhouyuhang1010@163.com>
To: brauner@kernel.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhouyuhang <zhouyuhang@kylinos.cn>
Subject: [PATCH] selftests: clone3: Use the capget and capset syscall directly
Date: Thu, 10 Oct 2024 20:16:12 +0800
Message-Id: <20241010121612.2601444-1-zhouyuhang1010@163.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:sCgvCgDHC0GZxQdntQ3_AA--.42378S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw4kWr4kGFW3Wr4fZw1xuFg_yoWrGr1xpa
	4kAr45KFs5Wr1xGFW8C39ruFn5KFWkXw48Xr1UAw1jkr13Krn7tr4IkFyvg3Wj93yDu3y5
	ua10gFWfZFWkJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jMBTOUUUUU=
X-CM-SenderInfo: 52kr35xxkd0warqriqqrwthudrp/1tbiYBB0JmcHuwrGngAAsr

From: zhouyuhang <zhouyuhang@kylinos.cn>

The libcap commit aca076443591 ("Make cap_t operations thread safe.") added a
__u8 mutex at the beginning of the struct _cap_struct,it changes the offset of
the members in the structure that breaks the assumption made in the "struct libcap"
definition in clone3_cap_checkpoint_restore.c.So use the capget and capset syscall
directly and remove the libcap library dependency like the commit 663af70aabb7
("bpf: selftests: Add helpers to directly use the capget and capset syscall") does.

Signed-off-by: zhouyuhang <zhouyuhang@kylinos.cn>
---
 tools/testing/selftests/clone3/Makefile       |  1 -
 .../clone3/clone3_cap_checkpoint_restore.c    | 60 +++++++++----------
 2 files changed, 28 insertions(+), 33 deletions(-)

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
index 3c196fa86c99..111912e2aead 100644
--- a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
+++ b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
@@ -15,7 +15,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdbool.h>
-#include <sys/capability.h>
+#include <linux/capability.h>
 #include <sys/prctl.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
@@ -27,6 +27,13 @@
 #include "../kselftest_harness.h"
 #include "clone3_selftests.h"
 
+#ifndef CAP_CHECKPOINT_RESTORE
+#define CAP_CHECKPOINT_RESTORE 40
+#endif
+
+int capget(cap_user_header_t header, cap_user_data_t data);
+int capset(cap_user_header_t header, const cap_user_data_t data);
+
 static void child_exit(int ret)
 {
 	fflush(stdout);
@@ -87,47 +94,36 @@ static int test_clone3_set_tid(struct __test_metadata *_metadata,
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
 
-- 
2.25.1


