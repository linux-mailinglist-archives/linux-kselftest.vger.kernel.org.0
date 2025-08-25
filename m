Return-Path: <linux-kselftest+bounces-39837-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEE2B344C7
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 16:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FE2A3AAE2D
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 14:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA232FD1D5;
	Mon, 25 Aug 2025 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lV46seuQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300842FC86A
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133864; cv=none; b=nqkTcbco+EuqGuc1rDNvYhjfNPMViqTi3U7y8bzEaS5k6iqi+5qRe3jSpBzZ1D1uVFsxHU2GaC3v9sScDYME/RrS4vJd3OrqqFVFlWAm8mp2yD9Zd2j6qbxJfQgMjMrH0as2PUzdvZxLc+ClNBsvXmwziLTbvFdxA6aa8eN5aa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133864; c=relaxed/simple;
	bh=Bmr1lemeGceCOOCpFzJX8MKVUDGl1j63D1/ZGEXinik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SyNknOCUZn2aEAameGVYcfpat5T+LVDAr0V831KxWk4g5oaeYFRa+0KUq2B4bwNiV7KLvHiK+hwtlC/cTjA2Fc6RnYQf9JFTxe+noEbwYCBz1EHcZoeBoTBk4Gjov84VcUriRLIvNIdff7rJeDEBISfY997XENnlSZwF7TiVkpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lV46seuQ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-771eecebb09so559556b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 07:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756133861; x=1756738661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPfCdUbCeDFsUsPpoXasJyGte3SUGn6gCviPu/g9Nmk=;
        b=lV46seuQSOteOzYdvjsMw2K5m2Y2K1oAfc939qst9Ubd5u4AhU0Msve4zgskYqApYZ
         oOfYs4losACAvl9+mgCho9hoh/e1qpF0HawBQI7tq+fSHttN1TkV/1ROsf9aXB/RsdUh
         1M7TVzWeWOd3rep0Msd6KczohqezdGJF4zekRqTaJGP9ivY8hvTVLYjFmZ6cPGfudb3L
         UdtmqIkigh+Ojx/S8xrpfwmRj1GptVZu2brD96hxaf2ojGnPridPsSKJOpdUGO9/JNAz
         gSIaoCM6UOVa7rPa6HHbXPPKT74CChKMAWGO3zqk8SzLg9EqNpGAPoXkY1rOJp0RICah
         4Eqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133861; x=1756738661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPfCdUbCeDFsUsPpoXasJyGte3SUGn6gCviPu/g9Nmk=;
        b=ZW9LAL0EFpz8fXcmMii2ol85Tj1FRIvjRhDzWb52v/OR3C30lJYoLf9TdnMiyAyg5I
         cPle7lV8QCGyngYM0Wh5CsxOrEXsSeJouFvUhHftt5T4XgAymn+hUbacx4E5ISEd3Xat
         cj20As4X9fzUEAbYATwk7eXPEgSWcxJmuAHmbP3+thazExYuu5FswYiAfRk/UrtoYCSE
         GE9RhqvWNfM7f7TM2LIJHb3psmWwFoSHGmlDAF+kOsEtupriXzZKlOifXU9pwVqoknaB
         SjQbzEtFF7jfqmKGRi+DToLc6Rxnyt2lKa7Z419F7wwYX/v4LhtEMoo+O5smiNGkd4xY
         j9Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUVaJcNvrU0ydNvV+ddbFhFcu8aJBSyZZiPISgrkVTfPnwgUPUQkIvhVbxNLTpRRidZBJdfSTf+qMQ0wN7g74o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVWZqlFMQGHSqHdiwBbeJHXLHbpGXGYJvzWxaiK0eHLPe4XuHC
	CcEV9Fr3zadFsQlPiI3x8JQjUEEAVigJZt2fjV9uvPNmxA1dkUEEqsbV8nICRbc5DDE=
X-Gm-Gg: ASbGncsToktLCFEytjI7xQnuPM/AIRphwkAcrMTM3eDbYUw8pTysZF0Sq8d1jTyo0mH
	jbm/UAh/hD9FDdY3KCUua2GCxDKLjQW0PNYFYhP3rkDSC9K6OjQv1pUT0Q/9xAQJ3VxDT4kHN8g
	HCa1hjeEeJaElVXRZLDNzb3XJs7YjYpshiBZZz3oD2gaUV2pa7f/gEO/OEzLRjDyUx0zDgMotw2
	aRm5APlFVB5cdlytJqOdUKOXiLh0FHPcqIJtnubyh3GvYKbt32QNX8k6AmVJ8DeiF8NxR8yZKBO
	/SKvdQ2hX8SXASXNnP1z4WIFDsfRZ+yYvXTGupgeZwqovCmFkd4qDyrudeJAah+UKAH1c8oqLJz
	thicbJimZBWs8fiWkVBd0V05TXFr9Nh8iohpcCRg3e+XGqQElBz66w4IwojZ/n3SbN7whC5k=
X-Google-Smtp-Source: AGHT+IGi8AlmioEDn8F5OEJC9Uwl85Px8BWcJiffXHL00QHD0rhIGgqp+SRRXzN7jCPLWKMu1CF5lg==
X-Received: by 2002:a05:6a20:3ca1:b0:240:1204:dd5 with SMTP id adf61e73a8af0-24340c2b7ccmr16679364637.8.1756133861321;
        Mon, 25 Aug 2025 07:57:41 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401b190asm7803436b3a.74.2025.08.25.07.57.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Aug 2025 07:57:40 -0700 (PDT)
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
Date: Mon, 25 Aug 2025 22:57:06 +0800
Message-Id: <20250825145719.29455-4-linyongting@bytedance.com>
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


