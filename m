Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E8E7AE949
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 11:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbjIZJfU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 05:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjIZJfS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 05:35:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55AAB3;
        Tue, 26 Sep 2023 02:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695720911; x=1727256911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ThUJ2dgRLVmBBUHWMxUL3UVe0FEzVRO2lU88vuPRrAY=;
  b=QdfmeT1CoH1gicu8n8otNvzmX6o1YYQuNX4L6dxMHtmVxjUpm05YpLeP
   MkSVuEfA4qojEopL3lobHOKAKLSEYAj7P/zO/T2Zc8BPXoaGoK8eQDMyo
   ZB6Icx8CvWgmlo9YjfqMQxc8Cp3Ha4L5x3Nfq8sxvf7RI/BPojlTWgPin
   CvT4jCdXAk91rHkWBwodS+YoUXJNLkPpm1HfvXwEr0sqUKEKVf8KYiPTz
   uMBZ2wQgbkm/NRL4nZ5gwrov53g5D0VhtBszCRSCGgwJc8pxGycxBbj7W
   un05bW8vryJbjdc0y0Bd3ipsvma8kEEGtlJz8U27pYO8MEi8yoC45Cglc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="412442898"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="412442898"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 02:31:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="725373037"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="725373037"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 26 Sep 2023 02:31:25 -0700
From:   Yi Liu <yi.l.liu@intel.com>
To:     alex.williamson@redhat.com, jgg@nvidia.com, kevin.tian@intel.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com
Cc:     joro@8bytes.org, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.l.liu@intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: [RFC 2/3] vfio: Add VFIO_DEVICE_PASID_[AT|DE]TACH_IOMMUFD_PT
Date:   Tue, 26 Sep 2023 02:31:20 -0700
Message-Id: <20230926093121.18676-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926093121.18676-1-yi.l.liu@intel.com>
References: <20230926093121.18676-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This adds ioctls for the userspace to attach a given pasid of a vfio
device to/from an IOAS/HWPT.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/vfio/device_cdev.c | 45 +++++++++++++++++++++++++++++++
 drivers/vfio/vfio.h        |  4 +++
 drivers/vfio/vfio_main.c   |  8 ++++++
 include/uapi/linux/vfio.h  | 55 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 112 insertions(+)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index e75da0a70d1f..c2ac7ed44537 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -210,6 +210,51 @@ int vfio_df_ioctl_detach_pt(struct vfio_device_file *df,
 	return 0;
 }
 
+int vfio_df_ioctl_pasid_attach_pt(struct vfio_device_file *df,
+				  struct vfio_device_pasid_attach_iommufd_pt __user *arg)
+{
+	struct vfio_device *device = df->device;
+	struct vfio_device_pasid_attach_iommufd_pt attach;
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
+	struct vfio_device *device = df->device;
+	struct vfio_device_pasid_detach_iommufd_pt detach;
+	unsigned long minsz;
+
+	minsz = offsetofend(struct vfio_device_pasid_detach_iommufd_pt, flags);
+
+	if (copy_from_user(&detach, arg, minsz))
+		return -EFAULT;
+
+	if (detach.argsz < minsz || detach.flags)
+		return -EINVAL;
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
index 307e3f29b527..d228cdb6b345 100644
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
index 40732e8ed4c6..850bbaebdd29 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -1230,6 +1230,14 @@ static long vfio_device_fops_unl_ioctl(struct file *filep,
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
index 97ab68a175e0..474bb314d135 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -975,6 +975,61 @@ struct vfio_device_detach_iommufd_pt {
 
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
+ * Associate a pasid (of a cdev device) with an address space within the
+ * bound iommufd. Undo by VFIO_DEVICE_PASID_DETACH_IOMMUFD_PT or device fd
+ * close. This is only allowed on cdev fds.
+ *
+ * If a pasid is currently attached to a valid hw_pagetable (hwpt), without
+ * doing a VFIO_DEVICE_PASID_DETACH_IOMMUFD_PT, a second
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
+ * associated address space.  After it, the pasid of the device should be in
+ * a blocking DMA state.  This is only allowed on cdev fds.
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

