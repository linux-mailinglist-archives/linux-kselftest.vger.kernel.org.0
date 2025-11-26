Return-Path: <linux-kselftest+bounces-46552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C00C8BA40
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 20:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7090E3B9E7B
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 19:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F72346A1A;
	Wed, 26 Nov 2025 19:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dwVL6vOD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A844340A6D
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 19:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185789; cv=none; b=sRIqfE9WSxOXmSb2NAv5srGyVuy4Iz1UvK9BYKauhKWZcPzGLlktgsBJaciciU8Vn7fwBcTLsK8JC4k5sTgYViZt5MyAfBFaq+/XJwL2rMc9dS0YHUTyvx4jOTZmclsNIxOUvq/wHBI8YUje6G0hkPwMALvDTFufzd5z5ZVV89w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185789; c=relaxed/simple;
	bh=J7pVIwlaC2a90b7nwtyp8yiJuohGfw3mOEce/82UxtI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qttdLdrJziUikYSdZfGsZqTlVuDIvHuMtUS8+9EaCDfes4mVyozUijMYXZ/DAY2yrb3xf5s7mdYp9fTzkCkHs5zWFhtdPlE9gyAK8vavshXrw9dQozyT1m9fm+qOX9ZQrR46maYauVNcBwCsRwCeiSmyCj86DHpd4HWCRjzi7Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dwVL6vOD; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-340c0604e3dso81654a91.2
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 11:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764185786; x=1764790586; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qxDgVkCfvUIBjknMGYFc0YAO25izn9/Vb7Fr5WcLn8I=;
        b=dwVL6vODunu314pHy+b2J1h+eW4lRroED9tEH94HXDe+9H+ZEr68PVqSE2ZLm9Lo02
         aAggeJRVjcR+sNsP6v5A2InKO889aGBQowHXlyVUtRiBAAkt37Wn3pz4vXAcLk2qzdje
         F9Ziizhs81Cw/8DFC8NJVZFWQjUZ/JWSXMvusLWp7kg+sI4ljYZCbUqSaJ0yPWk0kign
         qi5CB6ugbl4EVTJhtLLHkZGOQEqnt4YsbRPzqe/XXiyqCHNQICn4yALQjo6fSGoj0OH1
         S3vp/Uv2qdT7dpWF26PPBnxXKVLXr4wTKyW4Xm7I+QZfrfwT6CY6OQz9D0xCl+tz3Ith
         Q5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764185786; x=1764790586;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qxDgVkCfvUIBjknMGYFc0YAO25izn9/Vb7Fr5WcLn8I=;
        b=teyY6vK8k2/ar0UQFXMvxy85+KqALnKaB0jSN13M9MXfZuSu0Q0HAIya+C8EB73yCI
         sHOy7V8hndvr9bZ13WrsvEv0C1RO8aez5D1UoRAAqWTsF1bmcOEIXeLhVvyW7GUTBzzs
         ulBFSu2JS36ipXEqUqkuplE50l3z5YruQebcp78yE5GhrtZ9sbSaiIFcgjV8d0H9Mo63
         yLstPVYy1qGaUwgg+/bwPZ74WAkexagsrARD9XhIQkQsUPiJ1v1WqZLcJw9LC2mcM7OA
         W+RPwhpPxqH6yXvk+G4ea5wZ4zIqMvn8e/EJYqMn7tfB5si5mQJukMaq+niik/BZ3sO5
         MPww==
X-Forwarded-Encrypted: i=1; AJvYcCXwc0C+kLDU4v+K0Mcs9bLCibRzdHEVrRR2/GiWsr6tTtVuyO5u/2N253SZAFSRw+POloVWI1LT2cKhy+BIbcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6oVBZgAhQGS1LGZMmVqSCyJR74MnVwZZ6qlGR/Uqt/8DRGf5n
	lhT5wkkiIMydz1npHxBsVc35JIezpj1mIyybTixM3O7dqHcmQA1YyM4tkRXLhIxGto/f0u8Xhan
	9DvHH+0LjJmXpXQ==
X-Google-Smtp-Source: AGHT+IGz6vSeW4fFPlsbH/YbzCbOjEAX4lyHpEhDzDf7WPVwipOugVcvT745U9YgzvArnPjB+ggooe0srOWMJQ==
X-Received: from pjpo2.prod.google.com ([2002:a17:90a:9f82:b0:340:5c38:986c])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:394c:b0:340:54a1:d703 with SMTP id 98e67ed59e1d1-34733f5d318mr22023223a91.35.1764185786500;
 Wed, 26 Nov 2025 11:36:26 -0800 (PST)
Date: Wed, 26 Nov 2025 19:35:57 +0000
In-Reply-To: <20251126193608.2678510-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126193608.2678510-11-dmatlack@google.com>
Subject: [PATCH 10/21] vfio/pci: Skip reset of preserved device after Live Update
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kvm@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Philipp Stanner <pstanner@redhat.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"

From: Vipin Sharma <vipinsh@google.com>

Do not reset the device when a Live Update preserved vfio-pci device is
retrieved and first enabled. vfio_pci_liveupdate_freeze() guarantees the
device is reset prior to Live Update, so there's no reason to reset it
again after Live Update.

Since VFIO normally uses the initial reset to detect if the device
supports function resets, pass that from the previous kernel via
struct vfio_pci_core_dev_ser.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/vfio/pci/vfio_pci_core.c       | 22 +++++++++++++++++-----
 drivers/vfio/pci/vfio_pci_liveupdate.c |  1 +
 include/linux/kho/abi/vfio_pci.h       |  2 ++
 include/linux/vfio_pci_core.h          |  1 +
 4 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index b09fe0993e04..c3b30f08a788 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -482,12 +482,24 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 	if (ret)
 		goto out_power;
 
-	/* If reset fails because of the device lock, fail this path entirely */
-	ret = pci_try_reset_function(pdev);
-	if (ret == -EAGAIN)
-		goto out_disable_device;
+	if (vdev->liveupdate_state) {
+		/*
+		 * This device was handed off by vfio-pci from a previous kernel
+		 * via Live Update, so it does not need to be reset.
+		 */
+		vdev->reset_works = vdev->liveupdate_state->reset_works;
+	} else {
+		/*
+		 * If reset fails because of the device lock, fail this path
+		 * entirely.
+		 */
+		ret = pci_try_reset_function(pdev);
+		if (ret == -EAGAIN)
+			goto out_disable_device;
+
+		vdev->reset_works = !ret;
+	}
 
-	vdev->reset_works = !ret;
 	pci_save_state(pdev);
 	vdev->pci_saved_state = pci_store_saved_state(pdev);
 	if (!vdev->pci_saved_state)
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index 0fb29bd3ae3b..bcaf9de8a823 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -59,6 +59,7 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 
 	ser->bdf = pci_dev_id(pdev);
 	ser->domain = pci_domain_nr(pdev->bus);
+	ser->reset_works = vdev->reset_works;
 
 	err = kho_preserve_folio(folio);
 	if (err)
diff --git a/include/linux/kho/abi/vfio_pci.h b/include/linux/kho/abi/vfio_pci.h
index 9bf58a2f3820..6c3d3c6dfc09 100644
--- a/include/linux/kho/abi/vfio_pci.h
+++ b/include/linux/kho/abi/vfio_pci.h
@@ -34,10 +34,12 @@
  *
  * @bdf: The device's PCI bus, device, and function number.
  * @domain: The device's PCI domain number (segment).
+ * @reset_works: Non-zero if the device supports function resets.
  */
 struct vfio_pci_core_device_ser {
 	u16 bdf;
 	u16 domain;
+	u8 reset_works;
 } __packed;
 
 #endif /* _LINUX_LIVEUPDATE_ABI_VFIO_PCI_H */
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 56ff6452562d..3421721a1615 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -15,6 +15,7 @@
 #include <linux/types.h>
 #include <linux/uuid.h>
 #include <linux/notifier.h>
+#include <linux/kho/abi/vfio_pci.h>
 
 #ifndef VFIO_PCI_CORE_H
 #define VFIO_PCI_CORE_H
-- 
2.52.0.487.g5c8c507ade-goog


