Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E947BD5BE
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 10:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345563AbjJIIvx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 04:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345645AbjJIIvm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 04:51:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C7DFD;
        Mon,  9 Oct 2023 01:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696841499; x=1728377499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JSeUpuRex7a51lDX14t/GdpSs0DuR6eKWST5rPe8kAg=;
  b=GVoTCM/ib6Ixolmle+fm37gk7TMAGiMliqYIOeZ6KN0qDmI7LRpj531s
   p6BU4oYCje14RXgR7K/V15lbpieGhQgWoE+OEo7O4xWqmXKXvGif/NUiT
   kXf9TudwMgEu7OEejIV36Tow2UwI0n1AF6qjNkVG3mygQZg0kRYoKBNPK
   BD7IBXRViCyBWhwR/DFP34+xEmiv/24ZHQgas+ZkcI76dpAHLIQeVbhNF
   2sUZ/gpDuizp47y1j49rLXrOKuOXMYayPbj2yF7hxIZLXh7wX+E17PfwE
   /UoF7Bs4PDENBPF2RBD7z9hiB8SHBwCWFIWqlTQVJvnjkzRefDw40vqUs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="364390850"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="364390850"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 01:51:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="818781724"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="818781724"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga008.fm.intel.com with ESMTP; 09 Oct 2023 01:51:38 -0700
From:   Yi Liu <yi.l.liu@intel.com>
To:     joro@8bytes.org, alex.williamson@redhat.com, jgg@nvidia.com,
        kevin.tian@intel.com, robin.murphy@arm.com,
        baolu.lu@linux.intel.com
Cc:     cohuck@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
        kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.l.liu@intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: [RFC 7/7] vfio: Add vfio_register_pasid_iommu_dev()
Date:   Mon,  9 Oct 2023 01:51:23 -0700
Message-Id: <20231009085123.463179-8-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009085123.463179-1-yi.l.liu@intel.com>
References: <20231009085123.463179-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Kevin Tian <kevin.tian@intel.com>

This adds vfio_register_pasid_iommu_dev() for device driver to register
virtual devices which are isolated per PASID in physical IOMMU. The major
usage is for the SIOV devices which allows device driver to tag the DMAs
out of virtual devices within it with different PASIDs.

For a given vfio device, VFIO core creates both group user interface and
device user interface (device cdev) if configured. However, for the virtual
devices backed by PASID of the device, VFIO core shall only create device
user interface as there is no plan to support such devices in the legacy
vfio_iommu drivers which is a must if creating group user interface for
such virtual devices. This introduces a VFIO_PASID_IOMMU group type for
the device driver to register PASID virtual devices, and provides a wrapper
API for it. In particular no iommu group (neither fake group or real group)
exists per PASID, hence no group interface for this type.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/vfio/group.c     | 18 ++++++++++++++++++
 drivers/vfio/vfio.h      |  8 ++++++++
 drivers/vfio/vfio_main.c | 10 ++++++++++
 include/linux/vfio.h     |  1 +
 4 files changed, 37 insertions(+)

diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index 610a429c6191..20771d0feb37 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -407,6 +407,9 @@ int vfio_device_block_group(struct vfio_device *device)
 	struct vfio_group *group = device->group;
 	int ret = 0;
 
+	if (!group)
+		return 0;
+
 	mutex_lock(&group->group_lock);
 	if (group->opened_file) {
 		ret = -EBUSY;
@@ -424,6 +427,8 @@ void vfio_device_unblock_group(struct vfio_device *device)
 {
 	struct vfio_group *group = device->group;
 
+	if (!group)
+		return;
 	mutex_lock(&group->group_lock);
 	group->cdev_device_open_cnt--;
 	mutex_unlock(&group->group_lock);
@@ -704,6 +709,10 @@ int vfio_device_set_group(struct vfio_device *device,
 {
 	struct vfio_group *group;
 
+	/* No group associate with a device with pasid */
+	if (type == VFIO_PASID_IOMMU)
+		return 0;
+
 	if (type == VFIO_IOMMU)
 		group = vfio_group_find_or_alloc(device->dev);
 	else
@@ -722,6 +731,9 @@ void vfio_device_remove_group(struct vfio_device *device)
 	struct vfio_group *group = device->group;
 	struct iommu_group *iommu_group;
 
+	if (!group)
+		return;
+
 	if (group->type == VFIO_NO_IOMMU || group->type == VFIO_EMULATED_IOMMU)
 		iommu_group_remove_device(device->dev);
 
@@ -766,6 +778,9 @@ void vfio_device_remove_group(struct vfio_device *device)
 
 void vfio_device_group_register(struct vfio_device *device)
 {
+	if (!device->group)
+		return;
+
 	mutex_lock(&device->group->device_lock);
 	list_add(&device->group_next, &device->group->device_list);
 	mutex_unlock(&device->group->device_lock);
@@ -773,6 +788,9 @@ void vfio_device_group_register(struct vfio_device *device)
 
 void vfio_device_group_unregister(struct vfio_device *device)
 {
+	if (!device->group)
+		return;
+
 	mutex_lock(&device->group->device_lock);
 	list_del(&device->group_next);
 	mutex_unlock(&device->group->device_lock);
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index d228cdb6b345..1ccc9aba6dc7 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -48,6 +48,14 @@ enum vfio_group_type {
 	 */
 	VFIO_IOMMU,
 
+	/*
+	 * Virtual device with IOMMU backing. The user of these devices can
+	 * trigger DMAs which are all tagged with a pasid. Pasid itself is
+	 * a device resource so there is no group associated. The VFIO core
+	 * doesn't create a vfio_group for such devices.
+	 */
+	VFIO_PASID_IOMMU,
+
 	/*
 	 * Virtual device without IOMMU backing. The VFIO core fakes up an
 	 * iommu_group as the iommu_group sysfs interface is part of the
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 850bbaebdd29..362de0ad36ce 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -334,6 +334,16 @@ int vfio_register_emulated_iommu_dev(struct vfio_device *device)
 }
 EXPORT_SYMBOL_GPL(vfio_register_emulated_iommu_dev);
 
+/*
+ * Register a virtual device with IOMMU pasid protection. The user of
+ * this device can trigger DMA as long as all of its outgoing DMAs are
+ * always tagged with a pasid.
+ */
+int vfio_register_pasid_iommu_dev(struct vfio_device *device)
+{
+	return __vfio_register_dev(device, VFIO_PASID_IOMMU);
+}
+
 /*
  * Decrement the device reference count and wait for the device to be
  * removed.  Open file descriptors for the device... */
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 7b06d1bc7cb3..2662f2ece924 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -281,6 +281,7 @@ static inline void vfio_put_device(struct vfio_device *device)
 
 int vfio_register_group_dev(struct vfio_device *device);
 int vfio_register_emulated_iommu_dev(struct vfio_device *device);
+int vfio_register_pasid_iommu_dev(struct vfio_device *device);
 void vfio_unregister_group_dev(struct vfio_device *device);
 
 int vfio_assign_device_set(struct vfio_device *device, void *set_id);
-- 
2.34.1

