Return-Path: <linux-kselftest+bounces-46590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D350AC8C577
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 00:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB5C3B846C
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 23:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6FA34A78A;
	Wed, 26 Nov 2025 23:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E8esp4t/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D3F349B06
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 23:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764199086; cv=none; b=gMK07eX7fQLUlLxlToHAXoSI/vXRtDpurxkkjkY+40mWadNMM+MYHYkYkPsoiGHBNrJTzTeWVB+MKywQQY9S8ZNZZwUzxoUVqeacr0psbLaTnFnNESml7+M3chGzDonv2MKwS04reVLkxRuw4ZESBfWzlrY8j+TKRnDBIPqqHso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764199086; c=relaxed/simple;
	bh=yDJ+V4vJT+UeNxWHEcNGG5rhGAYPb/61//Lf+3Fvynw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qq+UFpfsyaDRV0ZdpH8tK93mwmztCv0J4DdkyRjPAQly6UTDkovb7kVAsvOaaogDb1Pxzx3C0qhfkkEdKEaQaULf4Qz+eajpvFp6wnkoBmEYuicF4AiliiM0fQap8mVCPjB/fGum6houpgi8DoQHk7FQbWf9Npj6r13G3K4K+lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E8esp4t/; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-299ddb0269eso2930135ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 15:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764199084; x=1764803884; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=msfafFWYaD0dYRGinq2pU9UGptExPeKvxxBVJh+65mA=;
        b=E8esp4t/8msD5EdMmRHDgEoakGzj0w+RB3YVIg/i7+Yg2pR5S0mPTFduGY7LN2mkNo
         kObbb6fGKEMQwEU7TztcSl+ryOkYNKdag2YQAamX8w8aXqFATIW76PrOTCErIzarltSI
         UpkH8wt7Y9GuvggEszXxn5xezr7j4zZH5q1VWo6JXNA33XcLl2WoUTRzLb19CKC0zjQ+
         +PpToX7PjIzRI59QoFqbYdlfAIVk7uDSMBNyhFQxML0TQS256u1Eb4GkvjV+wVqVCCMC
         btr7XdUnIY4iey93TlzpYYZpuPYAe+nOhtvrQfu18rCHryd8tpue2INNj7Zt2T7/9KEx
         wnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764199084; x=1764803884;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=msfafFWYaD0dYRGinq2pU9UGptExPeKvxxBVJh+65mA=;
        b=Jg5OWUJgcNvT37X3/FoeXy4byTTwz49IBNYH9EUzoyWAf6QefogYPYz7wHeUVyp6SS
         129Wr6H5ib8ruOWQ29FuMI0j4AFXRJCc4if+zPQPJyR6+dNx13O4QXG2IQpFLv3Ddu6D
         9vqqNc7AIPfSFTKJBf0GNufrwXn9prr8uf0qZsQbFnD4rb7e6VPRAM9LMueZBcmNHftX
         27flf5S92o5+OJRzBkvy1toIKMEfZPbXzKKd5SiY6R1vsbHqo70ZMp813SpwzVcKYcsR
         2EX9E2sDO+n8ojHT9kC3VN2ftJGOGTS8c6lSTbjoTG/NWw2RxjKzDz1Kw8UsfA+qBP3J
         whmA==
X-Forwarded-Encrypted: i=1; AJvYcCVytWXKDpj9ze9SOowQCECFvGbX9p+fZFb4juCpcI+EP+ImzWRLXwNa+7m2qo2q96sIwlsAnLFASjFdfFQqRyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNnUpZzBSWpsjshhxi9ZSFz+fafAP8h3DgAolpMzsuRZuIWnOa
	laXs6BKUplOVNF34GcckNVeEjrNf18Xak3icsXqKL34h8M8OFSmQUkb4iau4vuMVWVe65CqG47M
	0PQjXHkStSkNzZA==
X-Google-Smtp-Source: AGHT+IH2SGFtadAdgidkvPbG8Lr4OVhZkJrONXr7INvC7eW3177bBHqIiIjpGg++sxybFvac3GuvD4aPQd376Q==
X-Received: from plou3.prod.google.com ([2002:a17:903:1ae3:b0:295:61b:84fa])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2f4f:b0:295:7453:b58b with SMTP id d9443c01a7336-29baae4569fmr100922005ad.4.1764199083808;
 Wed, 26 Nov 2025 15:18:03 -0800 (PST)
Date: Wed, 26 Nov 2025 23:17:29 +0000
In-Reply-To: <20251126231733.3302983-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126231733.3302983-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126231733.3302983-15-dmatlack@google.com>
Subject: [PATCH v4 14/18] vfio: selftests: Rename vfio_util.h to libvfio.h
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
Reviewed-by: Raghavendra Rao Ananta <rananta@google.com>
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
index aa5b45052c77..847e27e1166c 100644
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
2.52.0.487.g5c8c507ade-goog


