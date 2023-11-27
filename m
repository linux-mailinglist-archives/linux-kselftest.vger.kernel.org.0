Return-Path: <linux-kselftest+bounces-636-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 579F87F9A16
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 07:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9101B20C24
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 06:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2A9D535;
	Mon, 27 Nov 2023 06:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OOSCoSZT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD8F136;
	Sun, 26 Nov 2023 22:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701067156; x=1732603156;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VAys2T6SYXa/EbFErLKF/Vbg/PfRt/6DnDP8hziF19c=;
  b=OOSCoSZTdDSPEWC49nnn90Ol1aQymW75sry2QEoTTGpXoj/WfGsmwQod
   ulSGvt9qTHqo7Op5GOEeFzpFqVVtqpXkqPPnj3n1be4RGeYVWYYIJLcSw
   tKmYTizdgbD72mkWfI51Fw/YKqd+hFFPa8s1y1YjebXik49pX7RhDZJPM
   IHLT4/vxNzw3pXqnybmwOSAqFVDHkloRDZkP4UwT9evLfER6EU6lJTI8e
   Xb6nOZ4afzfFL6e8U+d6IUPok+RpgFe6ZhzBhKjc7wCYI2z5EOEXVSMwU
   KkN3pUQ0nljO4wTo2R5ovSOTNYtjYpQ2NtC+u2tNOwLvDH4YrsnHXbDnB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="392397770"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="392397770"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 22:39:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="717940819"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="717940819"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga003.jf.intel.com with ESMTP; 26 Nov 2023 22:39:12 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	robin.murphy@arm.com,
	baolu.lu@linux.intel.com
Cc: cohuck@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	mjrosato@linux.ibm.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	yi.y.sun@linux.intel.com,
	peterx@redhat.com,
	jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com,
	lulu@redhat.com,
	suravee.suthikulpanit@amd.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhenzhong.duan@intel.com,
	joao.m.martins@oracle.com,
	xin.zeng@intel.com,
	yan.y.zhao@intel.com
Subject: [PATCH 3/3] vfio: Report PASID capability via VFIO_DEVICE_FEATURE ioctl
Date: Sun, 26 Nov 2023 22:39:09 -0800
Message-Id: <20231127063909.129153-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127063909.129153-1-yi.l.liu@intel.com>
References: <20231127063909.129153-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reports the PASID capability data to userspace via VFIO_DEVICE_FEATURE,
hence userspace could probe PASID capability by it. This is a bit different
with other capabilities which are reported to userspace when the user reads
the device's PCI configuration space. There are two reasons for this.

 - First, Qemu by default exposes all available PCI capabilities in vfio-pci
   config space to the guest as read-only, so adding PASID capability in the
   vfio-pci config space will make it exposed to the guest automatically while
   an old Qemu doesn't really support it.

 - Second, PASID capability does not exit on VFs (instead shares the cap of
   the PF). Creating a virtual PASID capability in vfio-pci config space needs
   to find a hole to place it, but doing so may require device specific
   knowledge to avoid potential conflict with device specific registers like
   hiden bits in VF config space. It's simpler by moving this burden to the
   VMM instead of maintaining a quirk system in the kernel.

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 47 ++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h        | 13 +++++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 1929103ee59a..8038aa45500e 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1495,6 +1495,51 @@ static int vfio_pci_core_feature_token(struct vfio_device *device, u32 flags,
 	return 0;
 }
 
+static int vfio_pci_core_feature_pasid(struct vfio_device *device, u32 flags,
+				       struct vfio_device_feature_pasid __user *arg,
+				       size_t argsz)
+{
+	struct vfio_pci_core_device *vdev =
+		container_of(device, struct vfio_pci_core_device, vdev);
+	struct vfio_device_feature_pasid pasid = { 0 };
+	struct pci_dev *pdev = vdev->pdev;
+	u32 capabilities = 0;
+	int ret;
+
+	/* We do not support SET of the PASID capability */
+	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET,
+				 sizeof(pasid));
+	if (ret != 1)
+		return ret;
+
+	/*
+	 * Needs go to PF if the device is VF as VF shares its PF's
+	 * PASID Capability.
+	 */
+	if (pdev->is_virtfn)
+		pdev = pci_physfn(pdev);
+
+	if (!pdev->pasid_enabled)
+		goto out;
+
+#ifdef CONFIG_PCI_PASID
+	pci_read_config_dword(pdev, pdev->pasid_cap + PCI_PASID_CAP,
+			      &capabilities);
+#endif
+
+	if (capabilities & PCI_PASID_CAP_EXEC)
+		pasid.capabilities |= VFIO_DEVICE_PASID_CAP_EXEC;
+	if (capabilities & PCI_PASID_CAP_PRIV)
+		pasid.capabilities |= VFIO_DEVICE_PASID_CAP_PRIV;
+
+	pasid.width = (capabilities >> 8) & 0x1f;
+
+out:
+	if (copy_to_user(arg, &pasid, sizeof(pasid)))
+		return -EFAULT;
+	return 0;
+}
+
 int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 				void __user *arg, size_t argsz)
 {
@@ -1508,6 +1553,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
 		return vfio_pci_core_pm_exit(device, flags, arg, argsz);
 	case VFIO_DEVICE_FEATURE_PCI_VF_TOKEN:
 		return vfio_pci_core_feature_token(device, flags, arg, argsz);
+	case VFIO_DEVICE_FEATURE_PASID:
+		return vfio_pci_core_feature_pasid(device, flags, arg, argsz);
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 495193629029..8326faf8622b 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1512,6 +1512,19 @@ struct vfio_device_feature_bus_master {
 };
 #define VFIO_DEVICE_FEATURE_BUS_MASTER 10
 
+/**
+ * Upon VFIO_DEVICE_FEATURE_GET, return the PASID capability for the device.
+ * Zero width means no support for PASID.
+ */
+struct vfio_device_feature_pasid {
+	__u16 capabilities;
+#define VFIO_DEVICE_PASID_CAP_EXEC	(1 << 0)
+#define VFIO_DEVICE_PASID_CAP_PRIV	(1 << 1)
+	__u8 width;
+	__u8 __reserved;
+};
+#define VFIO_DEVICE_FEATURE_PASID 11
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.34.1


