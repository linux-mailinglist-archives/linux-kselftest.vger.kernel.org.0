Return-Path: <linux-kselftest+bounces-46278-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B53BC7B473
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 19:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5FD3A5CB5
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 18:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2373352FA3;
	Fri, 21 Nov 2025 18:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dL5YZ3x5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5AB3451CB
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 18:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748913; cv=none; b=siYZ/u1Mz2CvEdMShoQe+lvS/ePHh6BzPbuT4gYvCpxTVQbVBvpdfXKByQjbWhabUdJYIO/ZoVMvAVLLOg0x1WMYCvkxByH/tZWBHE8UaGFn8Wm+h45on4VUWvYofUaadFRSNlYLV24n53E8Vb/qohBbl7DOqf542bl1KZ3VM+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748913; c=relaxed/simple;
	bh=O7FYcy0EeK57NXbNCjSJSiTya2snlbNOBcj/IqOunN8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lmetoPOoTaZBcgsXW5p5g28fPVTXKyUvYpcYccnDYRFiWbstLFgkISAzMnT8t5Or4A14HI6MOqB6RrEQdvLH+Vh2bffwoSjTiLYTGfrnEv7NDyV9knmGzdcaAzRC3JlMY/EByiq1EFyMmQe2Gn0s4iibQJgyFUTY+cBs0KfHdWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dL5YZ3x5; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7b9208e1976so5137032b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 10:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763748903; x=1764353703; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HMEvwC8Vf1hNFRxW8gMqcv6dRhd2ZJX53eGoUogab78=;
        b=dL5YZ3x5rJRYegUxbWX/nxb2oyMvi0fp3/rKuqUhWCZ8CPGeCi6+IfyIIC1X4oQq4s
         6Xxt4nSAdlpfItG2g3S3Nl1FvOgng522tMCUuJPr7CdQMFs56rXQ8xNPPqXc58l0VBHC
         a92rhVZd6t9uOTrY3dR8TOwCU+SaAcdEshHerd1zNrF9ikGIfK333nPwfmPAzrHzKW67
         nNBlq+xNHz8fB0XtZAARLY8JqukfidKS4zDPOoFRS/mRgrwrYRlQOJBZ4ouxQ6A6ecTX
         QNMRzeKm3NNdjLfuFBU1PAZ0rFH+YpqjrhqNAIgtPCY++wlFw0hn7XN46ouxg/vr8pgx
         rd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763748903; x=1764353703;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HMEvwC8Vf1hNFRxW8gMqcv6dRhd2ZJX53eGoUogab78=;
        b=NmKIQYwT2XWolDQk9xzwxkzuXWXLYXCojdIbj47KdZNY+xZ9eFQ2Yx9vrSm6FCPzAz
         Tv6oxsqNktoypRIWcriv8wFTAuG9DW48QYKqm5kuYogQDsm7LkKFqm84gXl9PDpHpYwK
         ez/NgmuN6oqWkcFk4GZS+rgF2hhx8JiS5zhEpuZu+0m2neDU60WmGTAKqvPgFSk6BrnK
         3JBwDJpK99fyT2YPpUK9GpQ7I6DY/4j/SMhaXWqH8+20ibSL9bA/mB1T3UgzlFfSADRj
         9BlfZMZMnE8P0jCeeFSTVBe0ENpCzTPz3dz7ps2CN/CSsjAIbBZ9Jt18xqdMv/EjKjOu
         eYPg==
X-Forwarded-Encrypted: i=1; AJvYcCU2k7Jj7gS57yl6nZs2kpTBV5Qr6Mg0uG7azGHau4OCecgAJYej+hRwqOUWhhrkqm85Qe5EFI+0Fnwm7DDvwt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJgRf3A1GGgh8kmHwcIcj+PITJXr2r0ijnJPkUXBuTJO1z1gSl
	JFq+zuutUJqlK176jccfsm0OujsRq1CY8vI2M0RsXwISsEuBh+3N455+nbVDGspgmOS6asQVAv8
	hT2/8JQ7OGBzJtQ==
X-Google-Smtp-Source: AGHT+IFvGRUxxpn2Waw2LILGulaRH1HRzh6C//LRS6tJE+9Uj9HoAkeqFoZldrevGeeOCMb1cfx3h1lq8sEcdg==
X-Received: from pfny8.prod.google.com ([2002:aa7:8548:0:b0:7ae:309d:349])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:bd13:b0:7b8:d791:2609 with SMTP id d2e1a72fcca58-7c58eff684emr3209161b3a.30.1763748903016;
 Fri, 21 Nov 2025 10:15:03 -0800 (PST)
Date: Fri, 21 Nov 2025 18:14:26 +0000
In-Reply-To: <20251121181429.1421717-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251121181429.1421717-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251121181429.1421717-16-dmatlack@google.com>
Subject: [PATCH v3 15/18] vfio: selftests: Move vfio_selftests_*() helpers
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
2.52.0.rc2.455.g230fcf2819-goog


