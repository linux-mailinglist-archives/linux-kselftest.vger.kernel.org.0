Return-Path: <linux-kselftest+bounces-46277-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 39176C7B445
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 19:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2498F35BF74
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 18:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CBC34EF1C;
	Fri, 21 Nov 2025 18:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xtP5+IVV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA19352939
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 18:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748910; cv=none; b=FrA4pcmyIYisGyLRFbbCN3KwcITwpgu/fkDrtav72zVCRrAJd7vQCFDRIezb/X/IpocHibUiw30qxApMeM74wtaiEv1ozGUnsF6sIj3llF79iePhF9YRjNeAvToTbCCAsnOqt9QQviUNV/KA7/0Kfm7QMvSJ9QftwaoH1hWJNHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748910; c=relaxed/simple;
	bh=84mHi93ZLQ9k4F8REV9zDyggwTKGzmB23eWY4/3qtAM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eBrX9rOjLu0tY3h51Q8MxVhjeOwPH3tasEVHxbpc2g1oeYy5Yl+UD5+P1AU/4YHpUIJYQB13nys8Ukgt4J7SduOsGb06bKVSZ85kdWH67im6xC7UkLCM7uv8UgbTDRQNAtxCt/1yz471VJhATI9fUIfZ8JC8wYcIBpr3m/EN958=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xtP5+IVV; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7b6b194cf71so5440202b3a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 10:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763748901; x=1764353701; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=khWHJ2LqkboVnevDsr7KLbtVmUyuMR4Ct+IijuBDu4o=;
        b=xtP5+IVVpdNDAyHiwxVw803PsID3UCtDllsEK/sn8WGpUciofoaiJi9e36waHFPg19
         NCJdQBW3aR5fQ1YS8tn0V/eXQ61n5WO/AuQJ8AY7+ViXlhgQyXuv+d/r/NOe/vEzvmA3
         wyOhiZdSU8xtcE50ULDWXfOSEQvpL4uthntDjNHDqp63u6zKbVp/FIA867+I/l4o8eU9
         Es3+06b4PNJXmAUAk6Bz/fYcsNVTrpaU/9ImfQEYeFcr6y4AIGML1CZn1H9R4PKpmseY
         vMPDfQkD5kfEvb2SaXNjMv45nK9m4wT2xKFthc53025Mlr/P/u2807Op39M1w/iOi6GT
         mt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763748901; x=1764353701;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=khWHJ2LqkboVnevDsr7KLbtVmUyuMR4Ct+IijuBDu4o=;
        b=ejYYr84Th8aU2L5MSxYiPQtbEPDv7op6HdbT3dklJYBGXiQQujptFcM5yv5ri+e2SJ
         F4A67KYuxk0kLdftHCnSVRYxAA9XKr9Adgzb+cPW/R2C8YdeionBO3gWXWSaDSglS1LG
         LZU1WVnWiw5FZKEodWfz0scl9qliYWIRIK6/Y2Y853JCqlXUhkhyyeJMHp7evwstTgcA
         62FoCXHGnShRGvyI9RtAUuFQNgmDfgfoivqiYkX+WPY2HolYJqFE3Zr/XFG9XBCtBcVx
         tVk5VefzoBJcMPxPpyLPh17JBTSFsnQIq3m4UKsZwCeJtsTpAnJ1gpaLkWhxvh4GaGL3
         HKUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyW/lTnOmmuLES8zvdTwgd+vyhfR0o2fcL8JJ3R2yD9m13axixbTP/vtKobJbSOnYPqWmRFzefkkD6nLqcZtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YymyVvTqVspsEw7xnohnbrzrbJPWQGY75+GU+jtzdXTZ0ITaXgE
	Q2dD2o3XuvV6YbWmhmSdboFCzYAe6SlnqIvBH5xXlITS4VyLWXip2xkRq5a/tCFFBMq1BD9/b4n
	9vPKrwBVaNhpoDQ==
X-Google-Smtp-Source: AGHT+IE/sHqE5MkpF8u8+JSG/iUFG5dj9YeY9VIe7VGm8jPm/U4UHClcjsJ7KBiMY42D4TImrYBUs9DQx8sl0Q==
X-Received: from pfvb14.prod.google.com ([2002:a05:6a00:cce:b0:76b:f0d4:ac71])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:a17:b0:77f:2efb:11d5 with SMTP id d2e1a72fcca58-7c58c2ac1bdmr3705759b3a.1.1763748901475;
 Fri, 21 Nov 2025 10:15:01 -0800 (PST)
Date: Fri, 21 Nov 2025 18:14:25 +0000
In-Reply-To: <20251121181429.1421717-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251121181429.1421717-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251121181429.1421717-15-dmatlack@google.com>
Subject: [PATCH v3 14/18] vfio: selftests: Rename vfio_util.h to libvfio.h
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Alex Mastro <amastro@fb.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename vfio_util.h to libvfio.h to match the name of libvfio.mk.

No functional change intended.

Reviewed-by: Alex Mastro <amastro@fb.com>
Tested-by: Alex Mastro <amastro@fb.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c          | 2 +-
 tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c        | 2 +-
 .../selftests/vfio/lib/include/{vfio_util.h => libvfio.h}   | 6 +++---
 tools/testing/selftests/vfio/lib/iommu.c                    | 2 +-
 tools/testing/selftests/vfio/lib/iova_allocator.c           | 2 +-
 tools/testing/selftests/vfio/lib/vfio_pci_device.c          | 2 +-
 tools/testing/selftests/vfio/lib/vfio_pci_driver.c          | 2 +-
 tools/testing/selftests/vfio/vfio_dma_mapping_test.c        | 2 +-
 tools/testing/selftests/vfio/vfio_iommufd_setup_test.c      | 2 +-
 tools/testing/selftests/vfio/vfio_pci_device_test.c         | 2 +-
 tools/testing/selftests/vfio/vfio_pci_driver_test.c         | 2 +-
 11 files changed, 13 insertions(+), 13 deletions(-)
 rename tools/testing/selftests/vfio/lib/include/{vfio_util.h => libvfio.h} (98%)

diff --git a/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c b/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
index 0afbab0d82de..c75045bcab79 100644
--- a/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
+++ b/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
@@ -9,7 +9,7 @@
 #include <linux/pci_ids.h>
 #include <linux/sizes.h>
 
-#include <vfio_util.h>
+#include <libvfio.h>
 
 #include "registers.h"
 
diff --git a/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c b/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c
index c6db311ce64d..a871b935542b 100644
--- a/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c
+++ b/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c
@@ -7,7 +7,7 @@
 #include <linux/pci_ids.h>
 #include <linux/sizes.h>
 
-#include <vfio_util.h>
+#include <libvfio.h>
 
 #include "hw.h"
 #include "registers.h"
diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/libvfio.h
similarity index 98%
rename from tools/testing/selftests/vfio/lib/include/vfio_util.h
rename to tools/testing/selftests/vfio/lib/include/libvfio.h
index 5224808201fe..3027af15e316 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-#ifndef SELFTESTS_VFIO_LIB_INCLUDE_VFIO_UTIL_H
-#define SELFTESTS_VFIO_LIB_INCLUDE_VFIO_UTIL_H
+#ifndef SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_H
+#define SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_H
 
 #include <fcntl.h>
 #include <string.h>
@@ -352,4 +352,4 @@ void vfio_pci_driver_memcpy_start(struct vfio_pci_device *device,
 int vfio_pci_driver_memcpy_wait(struct vfio_pci_device *device);
 void vfio_pci_driver_send_msi(struct vfio_pci_device *device);
 
-#endif /* SELFTESTS_VFIO_LIB_INCLUDE_VFIO_UTIL_H */
+#endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_H */
diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
index 3933079fc419..52f9cdf5f171 100644
--- a/tools/testing/selftests/vfio/lib/iommu.c
+++ b/tools/testing/selftests/vfio/lib/iommu.c
@@ -19,7 +19,7 @@
 #include <linux/iommufd.h>
 
 #include "../../../kselftest.h"
-#include <vfio_util.h>
+#include <libvfio.h>
 
 const char *default_iommu_mode = "iommufd";
 
diff --git a/tools/testing/selftests/vfio/lib/iova_allocator.c b/tools/testing/selftests/vfio/lib/iova_allocator.c
index b3b6b27f5d1e..a12b0a51e9e6 100644
--- a/tools/testing/selftests/vfio/lib/iova_allocator.c
+++ b/tools/testing/selftests/vfio/lib/iova_allocator.c
@@ -19,7 +19,7 @@
 #include <linux/types.h>
 #include <linux/vfio.h>
 
-#include <vfio_util.h>
+#include <libvfio.h>
 
 struct iova_allocator *iova_allocator_init(struct iommu *iommu)
 {
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index a59c86797897..282c14bbdd00 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -20,7 +20,7 @@
 #include <linux/vfio.h>
 
 #include "../../../kselftest.h"
-#include <vfio_util.h>
+#include <libvfio.h>
 
 #define PCI_SYSFS_PATH	"/sys/bus/pci/devices"
 
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
index abb7a62a03ea..ca0e25efbfa1 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include "../../../kselftest.h"
-#include <vfio_util.h>
+#include <libvfio.h>
 
 #ifdef __x86_64__
 extern struct vfio_pci_driver_ops dsa_ops;
diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index c4c2fc36c7b3..213fcd8dcc79 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -10,7 +10,7 @@
 #include <linux/sizes.h>
 #include <linux/vfio.h>
 
-#include <vfio_util.h>
+#include <libvfio.h>
 
 #include "../kselftest_harness.h"
 
diff --git a/tools/testing/selftests/vfio/vfio_iommufd_setup_test.c b/tools/testing/selftests/vfio/vfio_iommufd_setup_test.c
index 3655106b912d..caf1c6291f3d 100644
--- a/tools/testing/selftests/vfio/vfio_iommufd_setup_test.c
+++ b/tools/testing/selftests/vfio/vfio_iommufd_setup_test.c
@@ -10,7 +10,7 @@
 #include <sys/ioctl.h>
 #include <unistd.h>
 
-#include <vfio_util.h>
+#include <libvfio.h>
 #include "../kselftest_harness.h"
 
 static const char iommu_dev_path[] = "/dev/iommu";
diff --git a/tools/testing/selftests/vfio/vfio_pci_device_test.c b/tools/testing/selftests/vfio/vfio_pci_device_test.c
index e95217933c6b..ecbb669b3765 100644
--- a/tools/testing/selftests/vfio/vfio_pci_device_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_device_test.c
@@ -10,7 +10,7 @@
 #include <linux/sizes.h>
 #include <linux/vfio.h>
 
-#include <vfio_util.h>
+#include <libvfio.h>
 
 #include "../kselftest_harness.h"
 
diff --git a/tools/testing/selftests/vfio/vfio_pci_driver_test.c b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
index 229e932a06f8..f0ca8310d6a8 100644
--- a/tools/testing/selftests/vfio/vfio_pci_driver_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
@@ -5,7 +5,7 @@
 #include <linux/sizes.h>
 #include <linux/vfio.h>
 
-#include <vfio_util.h>
+#include <libvfio.h>
 
 #include "../kselftest_harness.h"
 
-- 
2.52.0.rc2.455.g230fcf2819-goog


