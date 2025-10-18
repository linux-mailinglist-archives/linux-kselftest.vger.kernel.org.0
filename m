Return-Path: <linux-kselftest+bounces-43465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4EABEC23E
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 02:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 752BC6E747A
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 00:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2935B2288E3;
	Sat, 18 Oct 2025 00:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2t7dpM7x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F969223323
	for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 00:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760746069; cv=none; b=sFZfVS9lWytyWs0/T7WXN0ManX/Oafl6JePtCIoC+GAXqUHLZnQdJnLMKWX4gHSYa1btR9XuBlZpwolD6FDxZh9KNBAM74BdrmXOw/uzblVI1s49Qd6XTjInqo4PpowBW+wUsaQ/adHoB2PaXhiZKaIQiZjw1wPAbZ0IMkC3aZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760746069; c=relaxed/simple;
	bh=MFgRpcmSvyiNW2ycsfOMqpytwYLNdswjkflUzJbVBqM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ktFXoXfu294K4c0fz4PX+r4rZe5vWhoau1widDaKbAPxSyjwoJczgGB+dh0795PvAx274W6xHAWF4ghv7RQw/VzOsrxduG5qk4HZIqVXtun6ghjoUT3uEiZcHMrEmv77s/CF2mO2+YQ04HeK1dW2PN6Ar/aOPxqPBkJCq/54t6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2t7dpM7x; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-27c62320f16so25882645ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 17:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760746067; x=1761350867; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KHCY6sFzZWLKuVo4O6MQDE+yc4FJeSrGIRkXpfAjMjg=;
        b=2t7dpM7xT5sRj2dzjCC8tHWBvbeIYM/D6BaPLa0/AOxR9uvIiAtcnb5rnAbini1hg/
         26rgE89UsuEuSf1DfU/RLE9E6xE/RK/sb37FddbHPk7cfRvnhP7HDuwpTUCa4yDfKIXS
         vXid0/Rp+MuN6zN/mYhVAKIsz8kFYCyU/3UvvCR1Csc97mnOEJCaIA4J6jwrckWfIny7
         3ErNQRSnXAP8QfQdTTL/4dMBpGQaRA0f0yodX6ffxoF2LSsD/Fp4cCNBuNqhNFSrGtwi
         YW4suCx+CdutDtj8oRUVL00xfHWKRSJtmCB/6sr5pVPxrufxwz4V8khpmWENSCJc2XWH
         cWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760746067; x=1761350867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KHCY6sFzZWLKuVo4O6MQDE+yc4FJeSrGIRkXpfAjMjg=;
        b=q7BLB81Amr2tFJZmTRNhXHXsuu2KQag2A4PBn9KCQKfhlaDIEzr1Ol8kkDKf3G6CTr
         Q2rgiS7qJN0F5vTLryCvqOkpFmjK54QorSNxoZBnM/OL7b58WjYXxSNzAm+79h+oBMxg
         pNJC30yuK/D6FJEeg6/+k4NDGWRb4aWWdCoLJu6onKqzfpBGNhI1/FRdCvvzh8vGGbJD
         1GTdYYdGDmPqsDkXf0dUe3Z082xDqLdU9TvIwAmaW0PaRBSsUtzSbrO5wr65u9fR8gPy
         ptg9HTWyqFnkWiY7qBr6LKwPNn1KzlqCXslfc21cKN0WtUCP/wKKV8ehqOW5aLvLzunF
         jfAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2XWSD/ueceUWcVUgmksFd3qf90ZK+845HPEMIpAtUseHwHg8sxjzNF0vTegk+EYuB1C7W84JY2S+Cso51YYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ZDgVoGpUxT8Qzo7kijw3bFYpfQ/4+P9/2zwBLl5ksGlvz34Z
	1MLqz6F648PrtVNpcunbO4FKAg634iYdri/CRnhd8ucBdcp7dg+LI2DwuOqmiFel9JDktkinTQl
	vrjECmX7YKw==
X-Google-Smtp-Source: AGHT+IHm9Bkb4nNH3Rfeek7ZAO48gSccBg2tRk1yFiUzJut212ExP9VQ22QXBuOVaPaAWO2qNwfDgLkRrWNJ
X-Received: from pjff13.prod.google.com ([2002:a17:90b:562d:b0:33d:69cf:1f82])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f64f:b0:248:e3fb:4dc8
 with SMTP id d9443c01a7336-290ca8d04f4mr63505285ad.39.1760746067402; Fri, 17
 Oct 2025 17:07:47 -0700 (PDT)
Date: Fri, 17 Oct 2025 17:07:06 -0700
In-Reply-To: <20251018000713.677779-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251018000713.677779-1-vipinsh@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251018000713.677779-15-vipinsh@google.com>
Subject: [RFC PATCH 14/21] vfio/pci: Skip device reset on live update restored device.
From: Vipin Sharma <vipinsh@google.com>
To: bhelgaas@google.com, alex.williamson@redhat.com, pasha.tatashin@soleen.com, 
	dmatlack@google.com, jgg@ziepe.ca, graf@amazon.com
Cc: pratyush@kernel.org, gregkh@linuxfoundation.org, chrisl@kernel.org, 
	rppt@kernel.org, skhawaja@google.com, parav@nvidia.com, saeedm@nvidia.com, 
	kevin.tian@intel.com, jrhilke@google.com, david@redhat.com, 
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de, 
	junaids@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Do not reset the device when a live update preserved VFIO PCI device is
opened for the first time after kexec.

Save 'reset_works' to the device serialized state. If not saved then
this value can only be restored by performing an actual reset, which is
not desired during live update. If a device can be reset before live
update then most likely it can be reset after live update unless some
reset methods have been removed. In that case when actual reset is tried
it will return an error.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/pci/vfio_pci_core.c       | 15 ++++++++++-----
 drivers/vfio/pci/vfio_pci_liveupdate.c |  9 +++++++++
 drivers/vfio/pci/vfio_pci_priv.h       |  2 ++
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 29236b015242..186a669b68a4 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -486,12 +486,17 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 	if (ret)
 		goto out_power;
 
-	/* If reset fails because of the device lock, fail this path entirely */
-	ret = pci_try_reset_function(pdev);
-	if (ret == -EAGAIN)
-		goto out_disable_device;
+	if (vdev->liveupdate_restore) {
+		vfio_pci_liveupdate_restore_device(vdev);
+	} else {
+		/* If reset fails because of the device lock, fail this path entirely */
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
index 824dba2750fe..82ff9f178fdc 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -22,6 +22,7 @@ struct vfio_pci_core_device_ser {
 	u8 pci_config_map[PCI_CFG_SPACE_EXP_SIZE];
 	u8 vconfig[PCI_CFG_SPACE_EXP_SIZE];
 	u32 rbar[7];
+	u8 reset_works;
 } __packed;
 
 static int vfio_pci_liveupdate_deserialize_config(struct vfio_pci_core_device *vdev,
@@ -55,6 +56,7 @@ static int vfio_pci_lu_serialize(struct vfio_pci_core_device *vdev,
 {
 	ser->bdf = pci_dev_id(vdev->pdev);
 	vfio_pci_liveupdate_serialize_config(vdev, ser);
+	ser->reset_works = vdev->reset_works;
 	return 0;
 }
 
@@ -259,3 +261,10 @@ int vfio_pci_liveupdate_restore_config(struct vfio_pci_core_device *vdev)
 
 	return vfio_pci_liveupdate_deserialize_config(vdev, ser);
 }
+
+void vfio_pci_liveupdate_restore_device(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_pci_core_device_ser *ser = vdev->liveupdate_restore;
+
+	vdev->reset_works = ser->reset_works;
+}
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 0d5aca6c2471..ee1c7c229020 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -110,12 +110,14 @@ static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
 #ifdef CONFIG_LIVEUPDATE
 void vfio_pci_liveupdate_init(void);
 int vfio_pci_liveupdate_restore_config(struct vfio_pci_core_device *vdev);
+void vfio_pci_liveupdate_restore_device(struct vfio_pci_core_device *vdev);
 #else
 static inline void vfio_pci_liveupdate_init(void) { }
 int vfio_pci_liveupdate_restore_config(struct vfio_pci_core_device *vdev)
 {
 	return -EINVAL;
 }
+void vfio_pci_liveupdate_restore_device(struct vfio_pci_core_device *vdev) { }
 #endif /* CONFIG_LIVEUPDATE */
 
 #endif
-- 
2.51.0.858.gf9c4a03a3a-goog


