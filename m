Return-Path: <linux-kselftest+bounces-46591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDC9C8C589
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 00:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 191623B769E
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 23:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4CF34B197;
	Wed, 26 Nov 2025 23:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XLURi8/z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040A134AAE0
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 23:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764199089; cv=none; b=KFrSVzbeOj+y/PtSWoNkNPh1HLOpakWZa2lzaPwTgdHz8kuDmZAzv7ct5055hgV5IQx/xvGbIzkIzflYLhSWVdJUbj+5jBcImuUOAM9uuJPqgP3pl4YknOx7+SZDGL7zBRlzzi7TlfcielxmfxOxl5BUzX4ZDZZDgSYvXK77hAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764199089; c=relaxed/simple;
	bh=mHWkVELCLixotZVit8t/1VqG3neOYudLJ7M3gFcDoEo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H9pxhMiXOQxDvZggkQi+X2XJeZPftBUPvxwIhrdZ4OTaKr7EripaGza+iYadjj8lXdznOSpxPKKEcichd+KcDxw6089oXVvabk5gntLM9ReeiVfrtgx9UcOjKDcRWlxPE7t1aNkYvFJzX7V4MvYBsBx5HqpaPa2CYKvDfIuMoCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XLURi8/z; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7aa9f595688so311507b3a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 15:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764199085; x=1764803885; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6reQFbvrUZJXcTjumNZF0meA3bbLjKU7IXXVzkqzCAw=;
        b=XLURi8/zPB3bIqhjlaNNF/2i43TMBb0vdST9yXVz3m2BtumjKOII8bk5ck8EzzphYz
         4OC1HRaqaDw8qilQtMqPFyRXf39kgkcNKdQBmEtVd2whPcHORDso5XpmlgalBgEGiYkm
         bGpfqJj5+Azes3qMM4TvGFugbr9AEGB708VFu7qBJqTrIFn8A+BSPda/9S/r5HeizLpe
         OpaDwZtNLlDrStKEEd5+ZDLfbx8+HnVNVO32Ej7i6ccs5XFPfqb9t7T2pT7NXuqql+me
         kx/CfJibs5Eg5NOwmd8Rcz58yPi1xFkEdZ4y/U5WOUV3nqagdeP97//xj30bZIzm5+LV
         JKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764199085; x=1764803885;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6reQFbvrUZJXcTjumNZF0meA3bbLjKU7IXXVzkqzCAw=;
        b=WqKDK+XubTt/LtSIjMQkhoew3Yutf565TvcDU09h24HJO7TCtPJF5cS8hwvcIMHh15
         WXLEWLYf8vyVLg2fAzOzX5nKKBuLaclTLvoqjP+hWCd8mco6cRUefP1yCpraAQ7NaotK
         IB9b3i0uLknL76Km9FD3E2QbEE1bIPQ3CKK+ISwgia1eT9TZ/d9uYM/ihFLctZ1BWPkC
         HAJWEFri3DA3HeXZ3AfpHxWcHLs2ucDfSeC0VjRukqDFOhYLPsnPH7EK+enxJo233uvy
         oO5M7xYXC/SxYVY1+tIf88OHNuweWgB0W7e6bcy9dao1ardhyKTudCrIDhxo8JRyaPf+
         V/PA==
X-Forwarded-Encrypted: i=1; AJvYcCUP1Tve+FQ5jHFSeAH9Y7WHjcL7I9R7hyBjB3XNDUmJJUtlMFWJyaTLiZyqT1jamtL4Uol6aUikbLJq9C4qa9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbbBzgMJlsV/inMoP6z5Chw4MNJwqjb3nC9ReRfs6OJswUa9d3
	KSBckhUAkh99C5jApYjxi1GbQI1+7H2xTDpxiqGHIBm/YKgXY3YlH7fW3o8uyMBH4D/5uuWk6Xo
	i+ub/DLZR7KUdiA==
X-Google-Smtp-Source: AGHT+IG3GxAKkWHj5AWb96zXVeX3HY/XVBXQ75qdWHAYcJ4/MKD78Ict7QBDsMZ6sYSSwfs3VrSNhRFYjzx5fw==
X-Received: from pfcy27.prod.google.com ([2002:a05:6a00:93db:b0:7b8:642b:1d94])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:9508:b0:7aa:9ca5:da9c with SMTP id d2e1a72fcca58-7c58e50cc8dmr21906021b3a.22.1764199085213;
 Wed, 26 Nov 2025 15:18:05 -0800 (PST)
Date: Wed, 26 Nov 2025 23:17:30 +0000
In-Reply-To: <20251126231733.3302983-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126231733.3302983-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126231733.3302983-16-dmatlack@google.com>
Subject: [PATCH v4 15/18] vfio: selftests: Move vfio_selftests_*() helpers
 into libvfio.c
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Alex Mastro <amastro@fb.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Move the vfio_selftests_*() helpers into their own file libvfio.c. These
helpers have nothing to do with struct vfio_pci_device, so they don't
make sense in vfio_pci_device.c.

No functional change intended.

Reviewed-by: Alex Mastro <amastro@fb.com>
Tested-by: Alex Mastro <amastro@fb.com>
Reviewed-by: Raghavendra Rao Ananta <rananta@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/lib/libvfio.c    | 78 +++++++++++++++++++
 tools/testing/selftests/vfio/lib/libvfio.mk   |  1 +
 .../selftests/vfio/lib/vfio_pci_device.c      | 71 -----------------
 3 files changed, 79 insertions(+), 71 deletions(-)
 create mode 100644 tools/testing/selftests/vfio/lib/libvfio.c

diff --git a/tools/testing/selftests/vfio/lib/libvfio.c b/tools/testing/selftests/vfio/lib/libvfio.c
new file mode 100644
index 000000000000..a23a3cc5be69
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/libvfio.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "../../../kselftest.h"
+#include <libvfio.h>
+
+static bool is_bdf(const char *str)
+{
+	unsigned int s, b, d, f;
+	int length, count;
+
+	count = sscanf(str, "%4x:%2x:%2x.%2x%n", &s, &b, &d, &f, &length);
+	return count == 4 && length == strlen(str);
+}
+
+static char **get_bdfs_cmdline(int *argc, char *argv[], int *nr_bdfs)
+{
+	int i;
+
+	for (i = *argc - 1; i > 0 && is_bdf(argv[i]); i--)
+		continue;
+
+	i++;
+	*nr_bdfs = *argc - i;
+	*argc -= *nr_bdfs;
+
+	return *nr_bdfs ? &argv[i] : NULL;
+}
+
+static char *get_bdf_env(void)
+{
+	char *bdf;
+
+	bdf = getenv("VFIO_SELFTESTS_BDF");
+	if (!bdf)
+		return NULL;
+
+	VFIO_ASSERT_TRUE(is_bdf(bdf), "Invalid BDF: %s\n", bdf);
+	return bdf;
+}
+
+char **vfio_selftests_get_bdfs(int *argc, char *argv[], int *nr_bdfs)
+{
+	static char *env_bdf;
+	char **bdfs;
+
+	bdfs = get_bdfs_cmdline(argc, argv, nr_bdfs);
+	if (bdfs)
+		return bdfs;
+
+	env_bdf = get_bdf_env();
+	if (env_bdf) {
+		*nr_bdfs = 1;
+		return &env_bdf;
+	}
+
+	fprintf(stderr, "Unable to determine which device(s) to use, skipping test.\n");
+	fprintf(stderr, "\n");
+	fprintf(stderr, "To pass the device address via environment variable:\n");
+	fprintf(stderr, "\n");
+	fprintf(stderr, "    export VFIO_SELFTESTS_BDF=\"segment:bus:device.function\"\n");
+	fprintf(stderr, "    %s [options]\n", argv[0]);
+	fprintf(stderr, "\n");
+	fprintf(stderr, "To pass the device address(es) via argv:\n");
+	fprintf(stderr, "\n");
+	fprintf(stderr, "    %s [options] segment:bus:device.function ...\n", argv[0]);
+	fprintf(stderr, "\n");
+	exit(KSFT_SKIP);
+}
+
+const char *vfio_selftests_get_bdf(int *argc, char *argv[])
+{
+	int nr_bdfs;
+
+	return vfio_selftests_get_bdfs(argc, argv, &nr_bdfs)[0];
+}
diff --git a/tools/testing/selftests/vfio/lib/libvfio.mk b/tools/testing/selftests/vfio/lib/libvfio.mk
index f15b966877e9..9f47bceed16f 100644
--- a/tools/testing/selftests/vfio/lib/libvfio.mk
+++ b/tools/testing/selftests/vfio/lib/libvfio.mk
@@ -5,6 +5,7 @@ LIBVFIO_SRCDIR := $(selfdir)/vfio/lib
 
 LIBVFIO_C := iommu.c
 LIBVFIO_C += iova_allocator.c
+LIBVFIO_C += libvfio.c
 LIBVFIO_C += vfio_pci_device.c
 LIBVFIO_C += vfio_pci_driver.c
 
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 847e27e1166c..13fdb4b0b10f 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -376,74 +376,3 @@ void vfio_pci_device_cleanup(struct vfio_pci_device *device)
 
 	free(device);
 }
-
-static bool is_bdf(const char *str)
-{
-	unsigned int s, b, d, f;
-	int length, count;
-
-	count = sscanf(str, "%4x:%2x:%2x.%2x%n", &s, &b, &d, &f, &length);
-	return count == 4 && length == strlen(str);
-}
-
-static char **get_bdfs_cmdline(int *argc, char *argv[], int *nr_bdfs)
-{
-	int i;
-
-	for (i = *argc - 1; i > 0 && is_bdf(argv[i]); i--)
-		continue;
-
-	i++;
-	*nr_bdfs = *argc - i;
-	*argc -= *nr_bdfs;
-
-	return *nr_bdfs ? &argv[i] : NULL;
-}
-
-static char *get_bdf_env(void)
-{
-	char *bdf;
-
-	bdf = getenv("VFIO_SELFTESTS_BDF");
-	if (!bdf)
-		return NULL;
-
-	VFIO_ASSERT_TRUE(is_bdf(bdf), "Invalid BDF: %s\n", bdf);
-	return bdf;
-}
-
-char **vfio_selftests_get_bdfs(int *argc, char *argv[], int *nr_bdfs)
-{
-	static char *env_bdf;
-	char **bdfs;
-
-	bdfs = get_bdfs_cmdline(argc, argv, nr_bdfs);
-	if (bdfs)
-		return bdfs;
-
-	env_bdf = get_bdf_env();
-	if (env_bdf) {
-		*nr_bdfs = 1;
-		return &env_bdf;
-	}
-
-	fprintf(stderr, "Unable to determine which device(s) to use, skipping test.\n");
-	fprintf(stderr, "\n");
-	fprintf(stderr, "To pass the device address via environment variable:\n");
-	fprintf(stderr, "\n");
-	fprintf(stderr, "    export VFIO_SELFTESTS_BDF=\"segment:bus:device.function\"\n");
-	fprintf(stderr, "    %s [options]\n", argv[0]);
-	fprintf(stderr, "\n");
-	fprintf(stderr, "To pass the device address(es) via argv:\n");
-	fprintf(stderr, "\n");
-	fprintf(stderr, "    %s [options] segment:bus:device.function ...\n", argv[0]);
-	fprintf(stderr, "\n");
-	exit(KSFT_SKIP);
-}
-
-const char *vfio_selftests_get_bdf(int *argc, char *argv[])
-{
-	int nr_bdfs;
-
-	return vfio_selftests_get_bdfs(argc, argv, &nr_bdfs)[0];
-}
-- 
2.52.0.487.g5c8c507ade-goog


