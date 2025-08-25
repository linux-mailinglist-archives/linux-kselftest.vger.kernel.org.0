Return-Path: <linux-kselftest+bounces-39845-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1F9B344E5
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 17:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ADB91884519
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 15:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD3C301039;
	Mon, 25 Aug 2025 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PP6Oil4z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E6D30101B
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133894; cv=none; b=u6HuRVzfORxiGSDAattMDrXUVRlQfHyoZv91btKzojyfrwFS0uQoxM+LCK+MKKO7MgFvIusMnWI7ikWz3CIyLVOoytTW7Jh/pJhe+I4wfV7hRKE91JyhwOQt9PmRPkNZY6bZOoYdIkLZzwdbOGvKbOqt/f3JmdJmnGkUDeXTEZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133894; c=relaxed/simple;
	bh=Bmr1lemeGceCOOCpFzJX8MKVUDGl1j63D1/ZGEXinik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eb0HnpEsrs/w/IZma6CGzDaIJH1AX/bOgc+UMC8TUe/lMpEAB0LEoPDzmOob1W3cQMwfALdkzIMxsFTg5qlnweENdbMZjFm2+BHynXyM4ucFQNb1pewEaxom676QnRWvQyHBtf0SXdaPO4hDVwO3PQFixzMD3jKnAlS8a3XO9MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PP6Oil4z; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77033293ed8so2398352b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 07:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756133892; x=1756738692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPfCdUbCeDFsUsPpoXasJyGte3SUGn6gCviPu/g9Nmk=;
        b=PP6Oil4zIqysVocqfrtBRegOgW7bqAGScXZ39WdNSleRSGQT5j1rVyDUG6h3I5w6GU
         V+hvB9y7OjZ6TG6QHRZDDq4qE8rZIFErtnWzObDG7HwVb7v3s1W52xk+YBRe9JO+ItfH
         e+DNOiMB2s8I1YKLzIAJBdQyKaxaxymkxjngrRKpWVRv2wMrsAGBbCl5w3iX+RgseuEx
         Ya4v9igjCMrUZRGLYcXl/FgVf3bSFJB6RqdJWRRcpEgbFaq5O0jzN0ISZtumiv0fhNrr
         gu61mMVm/w5dlpP7JXZKEV9r/rrHj57w+xCyUC2g+p+7XA1twKtv0wCgvktv09i+59Yx
         pTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133892; x=1756738692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPfCdUbCeDFsUsPpoXasJyGte3SUGn6gCviPu/g9Nmk=;
        b=f7dHe+BDDR7/WMd481bXQlAiomPOpJq547q2W/oUF3cNp4GnRc3/a43yps+ax3ec3b
         fSJrRKnNkSfgq0vlHMWSvBZBs4uwKLKU/EzmxqtfiNsrresmZ74Wog/oNzjf1wYXX01P
         wPlJ6FxCV21L4VKpubOBo4YjCIJ+HuxaEb7oCD6c2ajOvKXQ2qUbmK4M+V2ZUgI9IWgJ
         /jtgrzz4rAoYjPjwMcdKyuPyKD1sHSsyf9vA9OD3fsn6bh94/P5VkaRKUydpk/hXe/lH
         AGJhH7T/yLozK90SH5LZRMv27CSvK4U86yc6XaHMz0IX0jE7lSEYWcZC6KuvAtaYYIUi
         KFpA==
X-Forwarded-Encrypted: i=1; AJvYcCXliDhaWPCfE+8OQDHQvtSNj5IkqCmiYBK3AC2L+f76dD1fE/nd+aDRtR0FmNa9fGMQymm1klIVas7XnEQGqSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxphLrWJlpvfhdO78gZqphMwILGQ6IgLtBi0FWnXbhZcfzUE8Fx
	XnF/tCKUDBfzxYAoXwg+ruW4CYnxixXyLJEwN3fVF8zZanejE6q/UkIgfK+7HiNev0M=
X-Gm-Gg: ASbGncu+cs5E6jspKhZDLbnViBAnUewKnE9R3tyFMFAvufKwk/T8iECgpHZcO2x549b
	R6+e1fS+xG6u7UuwrE6Gi0FmYWiedVLutCV8O1WDLr+gcVV/Oxm7FPFaPmrOkkhvUomJi49ac6V
	blEFmmWIgtnVx4hgxjzGXTTJ7zTV8fIo+rQ7Q29qdD5Z4CWtf+eDoOaztN8PfBOMuRjJo3PuIH/
	FwxtxLyLmFvJjhYNFRy3IkGSDJ10CuaKfr+VaCv+X04cYnleSPlLzPVdaf+V462GGOhrx0QfFgk
	55DmQHc5oKGmW/eD3q2ZPPKThqoO6sUxi30izlqwBtpEHO/EzBtoksv8BWK6f9JxtzvYXxmChk/
	OiFOUN+K5O77PsC9MhiFFuLxFy7MIRwWemlfdrujMZItD27xYx5K4QZQpAIUjJUzXwI2jM3E=
X-Google-Smtp-Source: AGHT+IGf78VLrhzAmAq66Bf02kLMtH0Tbf7x+AP9+PSfFDcxdQBxs5I/UoUt+CpNFiVAJcIVaIt3dg==
X-Received: by 2002:a05:6a00:13aa:b0:771:edda:1b9c with SMTP id d2e1a72fcca58-771edda1de7mr1932159b3a.14.1756133891940;
        Mon, 25 Aug 2025 07:58:11 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401b190asm7803436b3a.74.2025.08.25.07.58.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Aug 2025 07:58:11 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	khalid@kernel.org,
	shuah@kernel.org,
	linyongting@bytedance.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: [PATCH 3/8] mshare: selftests: Add some helper function for mshare filesystem
Date: Mon, 25 Aug 2025 22:57:14 +0800
Message-Id: <20250825145719.29455-12-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250825145719.29455-1-linyongting@bytedance.com>
References: <20250825145719.29455-1-linyongting@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before create basic test cases, we need to have some helper functions
to help setup the tests.

These helper functions consist of:
  Mount and unmount the mshare filesystem
  Create a temporary file which be performed test on it later
  Map and unmap mshare region via the ioctl syscall

Signed-off-by: Yongting Lin <linyongting@bytedance.com>
---
 tools/testing/selftests/mshare/basic.c |   1 +
 tools/testing/selftests/mshare/util.c  | 123 +++++++++++++++++++++++++
 2 files changed, 124 insertions(+)
 create mode 100644 tools/testing/selftests/mshare/util.c

diff --git a/tools/testing/selftests/mshare/basic.c b/tools/testing/selftests/mshare/basic.c
index 482af948878d..35739b1133f7 100644
--- a/tools/testing/selftests/mshare/basic.c
+++ b/tools/testing/selftests/mshare/basic.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include "../kselftest_harness.h"
+#include "util.c"
 
 TEST(basic)
 {
diff --git a/tools/testing/selftests/mshare/util.c b/tools/testing/selftests/mshare/util.c
new file mode 100644
index 000000000000..75f6ff25aa2c
--- /dev/null
+++ b/tools/testing/selftests/mshare/util.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/msharefs.h>
+#include <stdio.h>
+#include <mntent.h>
+#include <sys/mount.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+
+/*
+ *  Helper functions for mounting msharefs
+ */
+
+#define MOUNT_POINT "/sys/fs/mshare"
+#define FS_TYPE     "msharefs"
+
+bool is_msharefs_mounted(void)
+{
+	FILE *fp;
+	struct mntent *ent;
+	bool found = false;
+
+	fp = setmntent("/proc/mounts", "r");
+	if (!fp) {
+		perror("setmntent");
+		exit(1);
+	}
+
+	while ((ent = getmntent(fp)) != NULL) {
+		if (strcmp(ent->mnt_dir, MOUNT_POINT) == 0 &&
+			strcmp(ent->mnt_type, FS_TYPE) == 0) {
+			found = true;
+			break;
+		}
+	}
+
+	endmntent(fp);
+	return found;
+}
+
+bool msharefs_premounted;
+
+__attribute__((constructor))
+void mount_sharefs(void)
+{
+	msharefs_premounted = is_msharefs_mounted();
+	if (msharefs_premounted)
+		return;
+
+	if (mount(FS_TYPE, MOUNT_POINT, FS_TYPE, 0, NULL) != 0) {
+		perror("mount");
+		exit(1);
+	}
+}
+
+__attribute__((destructor))
+void umount_sharefs(void)
+{
+	if (!msharefs_premounted && umount(MOUNT_POINT) != 0) {
+		perror("umount");
+		exit(1);
+	}
+}
+
+/*
+ *  Helper functions for mshare files
+ */
+
+#define MSHARE_INFO MOUNT_POINT "/mshare_info"
+#define MSHARE_TEST MOUNT_POINT "/mshare-test-XXXXXX"
+
+size_t mshare_get_info(void)
+{
+	char req[128];
+	size_t size;
+	int fd;
+
+	fd = open(MSHARE_INFO, O_RDONLY);
+	if (fd == -1)
+		return -1;
+
+	read(fd, req, sizeof(req));
+	size = atoll(req);
+	close(fd);
+
+	return size;
+}
+
+int create_mshare_file(char *filename, size_t len)
+{
+	int fd;
+
+	strncpy(filename, MSHARE_TEST, len - 1);
+	fd = mkstemp(filename);
+
+	return fd;
+}
+
+
+int mshare_ioctl_mapping(int fd, size_t size, int flags)
+{
+	struct mshare_create mcreate;
+
+	mcreate.region_offset = 0;
+	mcreate.size = size;
+	mcreate.offset = 0;
+	mcreate.prot = PROT_READ | PROT_WRITE;
+	mcreate.flags = flags;
+	mcreate.fd = -1;
+
+	return ioctl(fd, MSHAREFS_CREATE_MAPPING, &mcreate);
+}
+
+int mshare_ioctl_munmap(int fd, size_t size)
+{
+	struct mshare_unmap munmap;
+
+	munmap.region_offset = 0;
+	munmap.size = size;
+
+	return ioctl(fd, MSHAREFS_UNMAP, &munmap);
+}
-- 
2.20.1


