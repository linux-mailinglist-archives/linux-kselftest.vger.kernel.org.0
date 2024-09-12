Return-Path: <linux-kselftest+bounces-17842-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C275C976A51
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 15:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 015CE1C2338A
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 13:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA88B1AE876;
	Thu, 12 Sep 2024 13:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FRbDFWGm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E63B1AD278;
	Thu, 12 Sep 2024 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726147060; cv=none; b=Q8scJDoCVLQRw5bgs624skpFNrLmN11sEC3QAoQ4i83gL0kUEFw0YEyV2gPEhAOH0oX41k+I0broJotpzmupwHmFmvBzSx2iIty77/cIRKgxoOtehb12g/VXJOMABFP4FtllAOGtR4ANErdHhEOjwGcyM/HDrVRPbWCHOlEDsM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726147060; c=relaxed/simple;
	bh=a/i/zaEvnqcQRFokboQQC+mEQxDbkO09/rSogJwGHKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iwoKqC66d2t6THX3tBZCzf8Xv1XDMEBHDhZQ8ww5cqa2zudkNq0CCADyuI7O6en/G5sr4D89KiW0+N7UbVNGeL28J83n0uZIfMD/FvtHPz0aKgvg1UQ/OF7S+vvTSBVlsSlog7GlB4t+mc09f7f17OYFfDssrqB6Jzr1geiRyCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FRbDFWGm; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726147059; x=1757683059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a/i/zaEvnqcQRFokboQQC+mEQxDbkO09/rSogJwGHKM=;
  b=FRbDFWGmUfB5B3C2TfSfCvw9DXW3y9jhNIaesXdQglIzOr++GIqNYFlJ
   0KIF81Zra+F9KX8ziaBG1eL6IDLFULTqV8eWhLUpqYXByYYVI2TLs2h6x
   bI6k1g80LKJKBp6OX4ebWyRSnAK6bQzfcdAM+YYPua2TZw7cOxrrRx/4m
   LTwdtzdxAJAGRBcxrZ4zsqlbH5fUzkLpppuLtPxSAgeOWxNH341/K/UO9
   3ryYu6YnyCOPTwRGo6EVp3WTDnluANACofG/1EQYVA0LxQWVqz+WNNbM4
   chc/xgixl+ELgN5bus00g2AnQMEyLF90kmGC8L9rLc8FkPSIugDEUImEV
   Q==;
X-CSE-ConnectionGUID: TqEpbY33RVWPLYnWoWjZmg==
X-CSE-MsgGUID: KStnCMpBQB+qsdf7pyOHfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="13493321"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="13493321"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 06:17:33 -0700
X-CSE-ConnectionGUID: scogY7HmTJKRtJqHGEgHbg==
X-CSE-MsgGUID: ju5wAhNCSWiO3tQb5FkHQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="72692541"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 12 Sep 2024 06:17:33 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	linux-kselftest@vger.kernel.org,
	vasant.hegde@amd.com
Subject: [PATCH v3 3/4] vfio: Add VFIO_DEVICE_PASID_[AT|DE]TACH_IOMMUFD_PT
Date: Thu, 12 Sep 2024 06:17:28 -0700
Message-Id: <20240912131729.14951-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912131729.14951-1-yi.l.liu@intel.com>
References: <20240912131729.14951-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds ioctls for the userspace to attach/detach a given pasid of a
vfio device to/from an IOAS/HWPT.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/vfio/device_cdev.c | 51 +++++++++++++++++++++++++++++++++++
 drivers/vfio/vfio.h        |  4 +++
 drivers/vfio/vfio_main.c   |  8 ++++++
 include/uapi/linux/vfio.h  | 55 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 118 insertions(+)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index bb1817bd4ff3..275918275fb0 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -217,6 +217,57 @@ int vfio_df_ioctl_detach_pt(struct vfio_device_file *df,
 	return 0;
 }
 
+int vfio_df_ioctl_pasid_attach_pt(struct vfio_device_file *df,
+				  struct vfio_device_pasid_attach_iommufd_pt __user *arg)
+{
+	struct vfio_device_pasid_attach_iommufd_pt attach;
+	struct vfio_device *device = df->device;
+	unsigned long minsz;
+	int ret;
+
+	minsz = offsetofend(struct vfio_device_pasid_attach_iommufd_pt, pt_id);
+
+	if (copy_from_user(&attach, arg, minsz))
+		return -EFAULT;
+
+	if (attach.argsz < minsz || attach.flags)
+		return -EINVAL;
+
+	if (!device->ops->pasid_attach_ioas)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&device->dev_set->lock);
+	ret = device->ops->pasid_attach_ioas(device, attach.pasid, &attach.pt_id);
+	mutex_unlock(&device->dev_set->lock);
+
+	return ret;
+}
+
+int vfio_df_ioctl_pasid_detach_pt(struct vfio_device_file *df,
+				  struct vfio_device_pasid_detach_iommufd_pt __user *arg)
+{
+	struct vfio_device_pasid_detach_iommufd_pt detach;
+	struct vfio_device *device = df->device;
+	unsigned long minsz;
+
+	minsz = offsetofend(struct vfio_device_pasid_detach_iommufd_pt, pasid);
+
+	if (copy_from_user(&detach, arg, minsz))
+		return -EFAULT;
+
+	if (detach.argsz < minsz || detach.flags)
+		return -EINVAL;
+
+	if (!device->ops->pasid_detach_ioas)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&device->dev_set->lock);
+	device->ops->pasid_detach_ioas(device, detach.pasid);
+	mutex_unlock(&device->dev_set->lock);
+
+	return 0;
+}
+
 static char *vfio_device_devnode(const struct device *dev, umode_t *mode)
 {
 	return kasprintf(GFP_KERNEL, "vfio/devices/%s", dev_name(dev));
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index 50128da18bca..20d3cb283ba0 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -353,6 +353,10 @@ int vfio_df_ioctl_attach_pt(struct vfio_device_file *df,
 			    struct vfio_device_attach_iommufd_pt __user *arg);
 int vfio_df_ioctl_detach_pt(struct vfio_device_file *df,
 			    struct vfio_device_detach_iommufd_pt __user *arg);
+int vfio_df_ioctl_pasid_attach_pt(struct vfio_device_file *df,
+				  struct vfio_device_pasid_attach_iommufd_pt __user *arg);
+int vfio_df_ioctl_pasid_detach_pt(struct vfio_device_file *df,
+				  struct vfio_device_pasid_detach_iommufd_pt __user *arg);
 
 #if IS_ENABLED(CONFIG_VFIO_DEVICE_CDEV)
 void vfio_init_device_cdev(struct vfio_device *device);
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index a5a62d9d963f..577cba9d3a01 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -1286,6 +1286,14 @@ static long vfio_device_fops_unl_ioctl(struct file *filep,
 		case VFIO_DEVICE_DETACH_IOMMUFD_PT:
 			ret = vfio_df_ioctl_detach_pt(df, uptr);
 			goto out;
+
+		case VFIO_DEVICE_PASID_ATTACH_IOMMUFD_PT:
+			ret = vfio_df_ioctl_pasid_attach_pt(df, uptr);
+			goto out;
+
+		case VFIO_DEVICE_PASID_DETACH_IOMMUFD_PT:
+			ret = vfio_df_ioctl_pasid_detach_pt(df, uptr);
+			goto out;
 		}
 	}
 
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 2b68e6cdf190..889702ae12bc 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -977,6 +977,61 @@ struct vfio_device_detach_iommufd_pt {
 
 #define VFIO_DEVICE_DETACH_IOMMUFD_PT		_IO(VFIO_TYPE, VFIO_BASE + 20)
 
+/*
+ * VFIO_DEVICE_PASID_ATTACH_IOMMUFD_PT - _IOW(VFIO_TYPE, VFIO_BASE + 21,
+ *					      struct vfio_device_pasid_attach_iommufd_pt)
+ * @argsz:	User filled size of this data.
+ * @flags:	Must be 0.
+ * @pasid:	The pasid to be attached.
+ * @pt_id:	Input the target id which can represent an ioas or a hwpt
+ *		allocated via iommufd subsystem.
+ *		Output the input ioas id or the attached hwpt id which could
+ *		be the specified hwpt itself or a hwpt automatically created
+ *		for the specified ioas by kernel during the attachment.
+ *
+ * Associate a pasid with an address space within the bound iommufd. Undo by
+ * VFIO_DEVICE_PASID_DETACH_IOMMUFD_PT or device fd close. This is only allowed
+ * on cdev fds.
+ *
+ * If a pasid is currently attached to a valid hwpt, without doing a
+ * VFIO_DEVICE_PASID_DETACH_IOMMUFD_PT, a second
+ * VFIO_DEVICE_PASID_ATTACH_IOMMUFD_PT ioctl passing in another hwpt id is
+ * allowed. This action, also known as a hwpt replacement, will replace the
+ * pasid's currently attached hwpt with a new hwpt corresponding to the given
+ * @pt_id.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+struct vfio_device_pasid_attach_iommufd_pt {
+	__u32	argsz;
+	__u32	flags;
+	__u32	pasid;
+	__u32	pt_id;
+};
+
+#define VFIO_DEVICE_PASID_ATTACH_IOMMUFD_PT	_IO(VFIO_TYPE, VFIO_BASE + 21)
+
+/*
+ * VFIO_DEVICE_PASID_DETACH_IOMMUFD_PT - _IOW(VFIO_TYPE, VFIO_BASE + 22,
+ *					      struct vfio_device_pasid_detach_iommufd_pt)
+ * @argsz:	User filled size of this data.
+ * @flags:	Must be 0.
+ * @pasid:	The pasid to be detached.
+ *
+ * Remove the association of a pasid (of a cdev device) and its current
+ * associated address space.  After it, the pasid of the device should be
+ * in a blocking DMA state.  This is only allowed on cdev fds.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+struct vfio_device_pasid_detach_iommufd_pt {
+	__u32	argsz;
+	__u32	flags;
+	__u32	pasid;
+};
+
+#define VFIO_DEVICE_PASID_DETACH_IOMMUFD_PT	_IO(VFIO_TYPE, VFIO_BASE + 22)
+
 /*
  * Provide support for setting a PCI VF Token, which is used as a shared
  * secret between PF and VF drivers.  This feature may only be set on a
-- 
2.34.1


