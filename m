Return-Path: <linux-kselftest+bounces-46269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A050CC7B448
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 19:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4123A63E2
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 18:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8F0354AC1;
	Fri, 21 Nov 2025 18:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bR+LWki1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E73534F248
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748892; cv=none; b=IRoeNUJgnHfiwpsiWA6fQquh+KplSQMzJFA6SgupWgRey/7qKI5y0Joj0ljrff8vLw4DPaWnGQWvDPCSrdEnQP3t9UTXqXy/hqBrvTa73xtZcZ7dzBOkQRVqUdToTP/tf7yFsKtwwPUL9fYhI0T8Fl1/KzFt0Dlk1zED7hBB3iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748892; c=relaxed/simple;
	bh=sVQ426YvnoY5iDxUNhuIYEZEVmIjttH0GnYN/e26wNE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aM9wDTpfplgWcL2vFWoYVzItqOaLC1WheER89OlLkPq+o+lTNVk+Po+X5xi/fY14qa6WMjqJmKVyOGo4bYt0FT5QBVu48VZ/Vu5eg+5jCYTLXeoIkP7bAXF8nUgab9EQd/i1mFdP8pZhzMQLs+i3fSUCQqEwQXCaStRuGgtOiVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bR+LWki1; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7bad1cef9bcso5319236b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 10:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763748890; x=1764353690; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N3IoouEAfOFQFuW4LZTJBHs1EfAd8fQ12WV4kcywblU=;
        b=bR+LWki1xCvlVWPn4/9fmPoia/QLUJ5wSSAnBEdogtDrglq7sJ1Fivs6+CVlGzMfKu
         F3a5X94z+/ZVVMw9DJ8prwrJXWiF0oNGnpmwFcOPtttnAT4PvnQTgr064uSOZpPlb4AC
         uU+SRa1ndd8ZGX+yJpZmDus7WuQKPJOzkslOBRlxSdwuroPGAhLEz3cC2zkzQBl6aPZI
         L2VpGB5pUcLD6GMUBk+lx9zCFKbhHw7Fkb0HG0zFG13V89fSwcnvsDm09j17Z/ZwrzbR
         gjw+zlNGoO+yJnhR0UmzhjJ2WqbVq90nBNDBuxKTnbw4S2rT1eJCZ8NtoMo+bduXlX8S
         8cnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763748890; x=1764353690;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N3IoouEAfOFQFuW4LZTJBHs1EfAd8fQ12WV4kcywblU=;
        b=Ax7tkofbe9LmNnu/yI8gWNoIKXcfa2ONmIdU8TnSgJ73Aj9xdIYQ6aImGAp9rZeavc
         RwG7cealMK3Kc4xDOCxMeczbeBeJJVLr+U2OGySgOHrRlO7TfUC6/S3cz2fKwLiD4aMT
         K0lDrQdPWBKBlNgG4XLY423LGpNjHOv9Kcd+vbRAMnCtMhEXTRndmRx+jayDAIlSCZee
         wF1f4+167EyxrGkisbmtqNv+vMTYOv2tXGMk2MZDN9Vx6DqHDsZI+y0KSGZC5a17vzWr
         FBaRBVapbQdeex5WnWSpDHSerbdXsn9P1ZfdG3McPvXMt3vtlDN7Pdjp3MMS6wYlvgMy
         eALQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvC1ZbXY1b/JCIEVYKTi+j17WSejzy+QR/AQO++YShAtQNZgGqt+Z66efVjiZE3J68+73Kc2sY/wbSJfI3BrY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw/qLEugUQywgPtIt4LbUQEQtig3wcUKiqci28jHlyuwMxDcND
	vGYu8VV26Q3HKig+IoeXHx1Hvj74VrcRro5AIkJHf9YYNyrZk2PLEebsWTimS1DTGlJ8EaeJG2U
	W86OTASRnqdsUMw==
X-Google-Smtp-Source: AGHT+IE1NvJoMtgdX995mQE53G6pC/BzIkZeaThQXnuZo4WTCvgAe0hcSsMC2aMiqLO8tnbxslTiVRPshpSVCw==
X-Received: from pfbjc15.prod.google.com ([2002:a05:6a00:6c8f:b0:7a9:968d:6b38])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1482:b0:7b6:1c9b:28c with SMTP id d2e1a72fcca58-7c58c2ab14fmr3419317b3a.5.1763748889705;
 Fri, 21 Nov 2025 10:14:49 -0800 (PST)
Date: Fri, 21 Nov 2025 18:14:18 +0000
In-Reply-To: <20251121181429.1421717-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251121181429.1421717-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251121181429.1421717-8-dmatlack@google.com>
Subject: [PATCH v3 07/18] vfio: selftests: Eliminate overly chatty logging
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Alex Mastro <amastro@fb.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Eliminate overly chatty logs that are printed during almost every test.
These logs are adding more noise than value. If a test cares about this
information it can log it itself. This is especially true as the VFIO
selftests gains support for multiple devices in a single test (which
multiplies all these logs).

Reviewed-by: Alex Mastro <amastro@fb.com>
Tested-by: Alex Mastro <amastro@fb.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/lib/vfio_pci_driver.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
index e5e8723ecb41..abb7a62a03ea 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#include <stdio.h>
-
 #include "../../../kselftest.h"
 #include <vfio_util.h>
 
@@ -29,7 +27,6 @@ void vfio_pci_driver_probe(struct vfio_pci_device *device)
 		if (ops->probe(device))
 			continue;
 
-		printf("Driver found: %s\n", ops->name);
 		device->driver.ops = ops;
 	}
 }
@@ -58,17 +55,6 @@ void vfio_pci_driver_init(struct vfio_pci_device *device)
 	driver->ops->init(device);
 
 	driver->initialized = true;
-
-	printf("%s: region: vaddr %p, iova 0x%lx, size 0x%lx\n",
-	       driver->ops->name,
-	       driver->region.vaddr,
-	       driver->region.iova,
-	       driver->region.size);
-
-	printf("%s: max_memcpy_size 0x%lx, max_memcpy_count 0x%lx\n",
-	       driver->ops->name,
-	       driver->max_memcpy_size,
-	       driver->max_memcpy_count);
 }
 
 void vfio_pci_driver_remove(struct vfio_pci_device *device)
-- 
2.52.0.rc2.455.g230fcf2819-goog


