Return-Path: <linux-kselftest+bounces-45456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E283FC5426D
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 20:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB3FF3BC66A
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 19:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17460354AE1;
	Wed, 12 Nov 2025 19:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1DMRTDyZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FA73538BD
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 19:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975390; cv=none; b=KIu0JUW1Ztth2JpXDje9zSmCP1KIbUkuSlReIdKRcqbg7GPzAVQ9Wd94wh40KwOO7YOFQJYXs6JF/Gqu+6gIxAfG8hCTwOB0Cu7E/LG7YAn4nH8vgg+Pe+sPUJpYq681/BpuLAa33HfTYyHHP4SyAH8T7d4X2rI7klLLX/zrx6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975390; c=relaxed/simple;
	bh=Rdjv74PUZl0xOdoDyaNF9pHG4jFNpAG6vGjvds5GMjY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kMLlLaWqI/UbTHdKKuGnbI01+6siXwawrzoxxADdx8sNErGe8uNIyeCHND/7cmQCJq3vW5y0b2rF60zSmP7jKJA9oKNRzHwaRqFaEbGYWqkM7/9LHHpCjIyeaFjwD95OjVfcFVCMq0tYgt5xfIhiJ/QnHbMIaIbLDNrMPSLJJVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1DMRTDyZ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-297df52c960so27056045ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 11:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762975387; x=1763580187; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sJH3wdS9hE71Au7KE8+soqhHI3UwfGlKjMtxt+SoduY=;
        b=1DMRTDyZ61nBQtqhiKnR8Qke8uTnOcsIdbxg+ngyjYZenhviNfpeb728VAdAWfkUA8
         9Dfp8xZMvGEeWFXG7sL/hSLZBexBPb6mt1vwbnoamvKhQA8Ql9kJrrZ+w4mmAvzcVQNC
         kA+oYcd3RGilRlX91m8aevI0Zw64K4psUk41PxNCyMdLyNmT1wzxHTviYTBv8n7tjpui
         qo+BZFwfgRDzH4Kh1pOI7mdi9SuxfnTb2+G4ezDQjUEkmC0huvXTRl1dHZpw9vueDp+9
         cSQ/Fvji7AZoxUZrdkwqN8h26q3C8Pmfod+hRyHapsn1K9kTEUcaezNIO3PkA4aLctlr
         z5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975387; x=1763580187;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJH3wdS9hE71Au7KE8+soqhHI3UwfGlKjMtxt+SoduY=;
        b=H3GDcs1ODtJX2eiSvENZhbV9QZiM0oPfj1z/oNI3lGAvxRFdW65GRGvC/X4FOSA1a6
         bXx3lm89uxDlUvARRYOwUkUERFRIS9ehph3y1rJOjxdjoUBjJ7YKiREm0mjcWqVXO0uC
         6Jp9pSwcQhu7cucp2rmQ/jMdqfLYRgxUeBQanbM5izPmRVIx6AqJnN8dM9InH3HpjcW7
         8o4kSobp2Dt5MbiiLsg4oVu+Ts7EHbJgbsSWgDCXwomzxlRDz2fBweN85pBszjzGC99W
         L7tAh2nsfTPRAMpxhsg1WvcpUfnDQd/GDzgQq3E11RuDnGeI2lRK6ZXgheauq0ds59yg
         3a8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXtK0suV7KQnUoPe+Bnpi9tiyq0oPudwO4B1I6L2mr4zGkknj39h6EHD3Ge4js15KIJj6vNIGUgzXXF3bjH9d4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzknVTgB4JgD18xcDMO4UYCFI5nSIxgcC127TVO2XpPxjw9Th2U
	jC8/FzjXD9lAHYMNQeDSVLPWuEzlAnkMhB0Z6Sm1v72Rxhvv6j3Hd3stH7RwA2icdSZw+ukYJcn
	+tZD+BKIavvAzYw==
X-Google-Smtp-Source: AGHT+IE880kIu+pp+tiLqIhvPDZIlY4YUq4eTXnOUsrY4PIHOZ9hOWXDYVMh8sA1Xz2ntVKcURODVdOqUyedwA==
X-Received: from ploy7.prod.google.com ([2002:a17:903:1b27:b0:298:57bf:b76e])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:18b:b0:296:4d61:6cdb with SMTP id d9443c01a7336-2984eda429dmr56375075ad.27.1762975387352;
 Wed, 12 Nov 2025 11:23:07 -0800 (PST)
Date: Wed, 12 Nov 2025 19:22:29 +0000
In-Reply-To: <20251112192232.442761-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112192232.442761-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251112192232.442761-16-dmatlack@google.com>
Subject: [PATCH v2 15/18] vfio: selftests: Move vfio_selftests_*() helpers
 into libvfio.c
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>, 
	David Matlack <dmatlack@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Raghavendra Rao Ananta <rananta@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Move the vfio_selftests_*() helpers into their own file libvfio.c. These
helpers have nothing to do with struct vfio_pci_device, so they don't
make sense in vfio_pci_device.c.

No functional change intended.

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
index 282c14bbdd00..3c21f48907b9 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -375,74 +375,3 @@ void vfio_pci_device_cleanup(struct vfio_pci_device *device)
 
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
2.52.0.rc1.455.g30608eb744-goog


