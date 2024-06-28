Return-Path: <linux-kselftest+bounces-12917-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A457791BADB
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 11:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597D4284999
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 09:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5301814EC7D;
	Fri, 28 Jun 2024 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PmlGRuHL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B260315099D;
	Fri, 28 Jun 2024 09:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565563; cv=none; b=p/YkjzuEnTFj6tccEr0rdecMdBhxe2lXAaPwilHywJ0mB7Tao7pVHim93WHhJ5sp/AwSZVpYRM1MjwdxDVXzZz6xNn+8Xilt3ZVNV9/rlR/jlwFsS0Q6qPVWMuxnuFSly3fLiSmoCDzjoeeEsaO6VrqnKvBqmxgBML8Yesy/yyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565563; c=relaxed/simple;
	bh=CwiYoVY+4opnvOlWCx/nZGteoxnrqoLWq2IwhViW33I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xy/7YihFheaoJmcDCBP6iQBD3cQz2RFMwFxkyy5W1xtYZyUUBe694sUecFnZEJGkdj9/ztCVp9XZ6Y4tPvATs1EHcB+ZGAh6ChXxo9hqPDyjxWE1jY/3Ip4GfJTXBgFfhv0TIppVT7GjMlq+O4l1nYEKupS7GW7H13MKB7RqZd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PmlGRuHL; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719565561; x=1751101561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CwiYoVY+4opnvOlWCx/nZGteoxnrqoLWq2IwhViW33I=;
  b=PmlGRuHLT4tptk6YygSk9s3gsmtPjVJbZ9/KXbojohncp/YFm8X0lYH0
   xB/riquFqEKMayBCZFsTdRy0/OlwQIUzvxNiHwO9lb03youSLPJhfMeSJ
   7q1oT5ZyspHYv1uShcfdGLJiByNGdGLqYP+V4aI/qdcMa2feWjJnwX8u9
   iy22QvObamrR5Ubh1nLenMIR8tl2jZ7xtrO4W7ZU+/yoltGHTUs8DRFel
   2+Pl+4H9Vm9FwlB8csYxemtMoRGpY/GJNdE5fRIbVYDuXjeigY2kNgfoJ
   i0vwMvFI6OkgPvyI8Vhdh/9fXmZiQjV+WJ6BCLVNGfW+gLFlxjhISyz9h
   g==;
X-CSE-ConnectionGUID: Qs4WTClTSfaumETZptxg3g==
X-CSE-MsgGUID: uEL4OMmwQVyEccdOyRJasg==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="20613669"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="20613669"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 02:06:00 -0700
X-CSE-ConnectionGUID: fdKEQNbZTi6Xe6oljT2kLg==
X-CSE-MsgGUID: aJ8+1hlQTJOOVEucDuUvPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="44517042"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa006.fm.intel.com with ESMTP; 28 Jun 2024 02:06:00 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	robin.murphy@arm.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 1/7] iommu: Introduce a replace API for device pasid
Date: Fri, 28 Jun 2024 02:05:51 -0700
Message-Id: <20240628090557.50898-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628090557.50898-1-yi.l.liu@intel.com>
References: <20240628090557.50898-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide a high-level API to allow replacements of one domain with
another for specific pasid of a device. This is similar to
iommu_group_replace_domain() and it is expected to be used only by
IOMMUFD.

Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu-priv.h |  3 ++
 drivers/iommu/iommu.c      | 80 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 79 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index 5f731d994803..0949c02cee93 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -20,6 +20,9 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
 int iommu_group_replace_domain(struct iommu_group *group,
 			       struct iommu_domain *new_domain);
 
+int iommu_replace_device_pasid(struct iommu_domain *domain,
+			       struct device *dev, ioasid_t pasid);
+
 int iommu_device_register_bus(struct iommu_device *iommu,
 			      const struct iommu_ops *ops,
 			      const struct bus_type *bus,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b3a1dabed2dd..2d64582b7c43 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3268,14 +3268,15 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
 EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
 
 static int __iommu_set_group_pasid(struct iommu_domain *domain,
-				   struct iommu_group *group, ioasid_t pasid)
+				   struct iommu_group *group, ioasid_t pasid,
+				   struct iommu_domain *old)
 {
 	struct group_device *device, *last_gdev;
 	int ret;
 
 	for_each_group_device(group, device) {
 		ret = domain->ops->set_dev_pasid(domain, device->dev,
-						 pasid, NULL);
+						 pasid, old);
 		if (ret)
 			goto err_revert;
 	}
@@ -3289,7 +3290,20 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
 
 		if (device == last_gdev)
 			break;
-		ops->remove_dev_pasid(device->dev, pasid, domain);
+		/* If no old domain, undo the succeeded devices/pasid */
+		if (!old) {
+			ops->remove_dev_pasid(device->dev, pasid, domain);
+			continue;
+		}
+
+		/*
+		 * Rollback the succeeded devices/pasid to the old domain.
+		 * And it is a driver bug to fail attaching with a previously
+		 * good domain.
+		 */
+		if (WARN_ON(old->ops->set_dev_pasid(old, device->dev,
+						    pasid, domain)))
+			ops->remove_dev_pasid(device->dev, pasid, domain);
 	}
 	return ret;
 }
@@ -3348,7 +3362,7 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 		goto out_unlock;
 	}
 
-	ret = __iommu_set_group_pasid(domain, group, pasid);
+	ret = __iommu_set_group_pasid(domain, group, pasid, NULL);
 	if (ret)
 		xa_erase(&group->pasid_array, pasid);
 out_unlock:
@@ -3357,6 +3371,64 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_attach_device_pasid);
 
+/**
+ * iommu_replace_device_pasid - Replace the domain that a pasid is attached to
+ * @domain: the new iommu domain
+ * @dev: the attached device.
+ * @pasid: the pasid of the device.
+ *
+ * This API allows the pasid to switch domains. Return 0 on success, or an
+ * error. The pasid will keep the old configuration if replacement failed.
+ */
+int iommu_replace_device_pasid(struct iommu_domain *domain,
+			       struct device *dev, ioasid_t pasid)
+{
+	/* Caller must be a probed driver on dev */
+	struct iommu_group *group = dev->iommu_group;
+	void *curr;
+	int ret;
+
+	if (!domain->ops->set_dev_pasid)
+		return -EOPNOTSUPP;
+
+	if (!group)
+		return -ENODEV;
+
+	if (!dev_has_iommu(dev) || dev_iommu_ops(dev) != domain->owner ||
+	    pasid == IOMMU_NO_PASID)
+		return -EINVAL;
+
+	mutex_lock(&group->mutex);
+	/*
+	 * The recorded domain is inconsistent with the domain pasid is
+	 * actually attached until pasid is attached to the new domain.
+	 * This has race condition with the paths that do not hold
+	 * group->mutex. E.g. the Page Request forwarding.
+	 */
+	curr = xa_store(&group->pasid_array, pasid, domain, GFP_KERNEL);
+	if (!curr) {
+		xa_erase(&group->pasid_array, pasid);
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	ret = xa_err(curr);
+	if (ret)
+		goto out_unlock;
+
+	if (curr == domain)
+		goto out_unlock;
+
+	ret = __iommu_set_group_pasid(domain, group, pasid, curr);
+	if (ret)
+		WARN_ON(domain != xa_store(&group->pasid_array, pasid,
+					   curr, GFP_KERNEL));
+out_unlock:
+	mutex_unlock(&group->mutex);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(iommu_replace_device_pasid, IOMMUFD_INTERNAL);
+
 /*
  * iommu_detach_device_pasid() - Detach the domain from pasid of device
  * @domain: the iommu domain.
-- 
2.34.1


