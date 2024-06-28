Return-Path: <linux-kselftest+bounces-12922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A2091BAEA
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 11:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 885AA1F22602
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 09:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A05155352;
	Fri, 28 Jun 2024 09:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y9FaQTDd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD9F154C00;
	Fri, 28 Jun 2024 09:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565566; cv=none; b=pSeoBXdqc8P/vNbqqUUhHdQZL4WARHMKDivibGLOvrIH4nEGOKO1H/iXivFJ2uGNmSRCZHbVyuG3k3ZMCSXxU1z0fgIiPOHyU0uqL1qfHsc00bJZE+TeJ+/Lm8aIauwlZbuKmCaBrdEn4T/b33YOvvOCpgEJQ09bhdi8ZN3PrM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565566; c=relaxed/simple;
	bh=RUEo9u6o9LXvLktG43EX4v4hmtY7q/UgdWFkflod43I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XkB5c+ZcqxBIx3qHClDr27iBGhywTqajSI8WmewzlUwE6eDfStWGGyyjHSRkw96nz7OAE/YWUqOtcHrgCJQzvtdWQmq/D86xMJUXGCaE7qDu0rt8WO759lwYDnAM76jn7xas47VNGQIBEj9DjHERorcmwJ6eLDr9nnQtmKrShBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y9FaQTDd; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719565565; x=1751101565;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RUEo9u6o9LXvLktG43EX4v4hmtY7q/UgdWFkflod43I=;
  b=Y9FaQTDd0bCHyF8AyJpQB5CtVipzRPfC+INNbWihBdlMzb5P5VN9/H9/
   /MCUS1nbKiEdyibXh4VTalBQsJMStzEU3Dv1sPkQFiA/FC9O7HUzZjMnr
   e109G9Qad+VnSQF1MPGKImnYDVtzO5IxcOhTaaTRoWEY/7geNrhKyyvlB
   YtSKXoAtmb6kMb4lkpDgDKlgT0NnExns9FEb7ZDCwgq8HPk/id7TMMu/c
   +C9fmxh//b00fRVrqTFkfSeODIMh6Z52rD7hHg7VVkDkpp0rqfe/Q1sdv
   ob8WE7UoQTNmGZTQCIniS36u+SaCDCFtkIsBR+qFnyNdtnOScOdTui0E2
   g==;
X-CSE-ConnectionGUID: MR9BnB7yQ7avDuzJmoN8bQ==
X-CSE-MsgGUID: b+XVCsJ4QYSLbPPRFOcrvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="20613703"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="20613703"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 02:06:04 -0700
X-CSE-ConnectionGUID: AjsqOAxlTbWVm1Jbhc2gOQ==
X-CSE-MsgGUID: 0lxiI8clRlWahcGZee95fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="44517081"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa006.fm.intel.com with ESMTP; 28 Jun 2024 02:06:03 -0700
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
Subject: [PATCH v3 6/7] iommufd/selftest: Add test ops to test pasid attach/detach
Date: Fri, 28 Jun 2024 02:05:56 -0700
Message-Id: <20240628090557.50898-7-yi.l.liu@intel.com>
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

This adds 4 test ops for pasid attach/replace/detach testing. There are
ops to attach/detach pasid, and also op to check the attached domain of
a pasid.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/iommufd_test.h |  30 ++++++
 drivers/iommu/iommufd/selftest.c     | 135 +++++++++++++++++++++++++++
 2 files changed, 165 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index e854d3f67205..ee6310f07749 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -22,6 +22,10 @@ enum {
 	IOMMU_TEST_OP_MOCK_DOMAIN_FLAGS,
 	IOMMU_TEST_OP_DIRTY,
 	IOMMU_TEST_OP_MD_CHECK_IOTLB,
+	IOMMU_TEST_OP_PASID_ATTACH,
+	IOMMU_TEST_OP_PASID_REPLACE,
+	IOMMU_TEST_OP_PASID_DETACH,
+	IOMMU_TEST_OP_PASID_CHECK_DOMAIN,
 };
 
 enum {
@@ -127,6 +131,32 @@ struct iommu_test_cmd {
 			__u32 id;
 			__u32 iotlb;
 		} check_iotlb;
+		struct {
+			__u32 pasid;
+			__u32 pt_id;
+			/* @id is stdev_id for IOMMU_TEST_OP_PASID_ATTACH
+			 * pasid#1024 is for special test, avoid use it
+			 * in normal case.
+			 */
+		} pasid_attach;
+		struct {
+			__u32 pasid;
+			__u32 pt_id;
+			/* @id is stdev_id for IOMMU_TEST_OP_PASID_ATTACH
+			 * pasid#1024 is for special test, avoid use it
+			 * in normal case.
+			 */
+		} pasid_replace;
+		struct {
+			__u32 pasid;
+			/* @id is stdev_id for IOMMU_TEST_OP_PASID_DETACH */
+		} pasid_detach;
+		struct {
+			__u32 pasid;
+			__u32 hwpt_id;
+			__u64 out_result_ptr;
+			/* @id is stdev_id for IOMMU_TEST_OP_HWPT_GET_DOMAIN */
+		} pasid_check;
 	};
 	__u32 last;
 };
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 782e3c469530..b44d56118e90 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -514,6 +514,8 @@ static struct iommu_device *mock_probe_device(struct device *dev)
 	return &mock_iommu_device;
 }
 
+static bool pasid_1024_attached;
+
 static void mock_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 					struct iommu_domain *domain)
 {
@@ -522,6 +524,8 @@ static void mock_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 		switch (domain->type) {
 		case IOMMU_DOMAIN_NESTED:
 		case IOMMU_DOMAIN_UNMANAGED:
+			if (pasid == 1024)
+				pasid_1024_attached = false;
 			break;
 		default:
 			/* should never reach here */
@@ -535,6 +539,20 @@ static int mock_domain_set_dev_pasid_nop(struct iommu_domain *domain,
 					 struct device *dev, ioasid_t pasid,
 					 struct iommu_domain *old)
 {
+	/*
+	 * First attach with pasid 1024 succ, second attach would fail,
+	 * and so on. This is helpful to test the case in which the iommu
+	 * layer needs to rollback to old domain due to driver failure.
+	 */
+	if (pasid == 1024) {
+		if (pasid_1024_attached) {
+			pasid_1024_attached = false;
+			// Fake an error to fail the replacement
+			return -ENOMEM;
+		}
+		pasid_1024_attached = true;
+	}
+
 	return 0;
 }
 
@@ -1422,6 +1440,114 @@ static int iommufd_test_dirty(struct iommufd_ucmd *ucmd, unsigned int mockpt_id,
 	return rc;
 }
 
+static int iommufd_test_pasid_attach(struct iommufd_ucmd *ucmd,
+				     struct iommu_test_cmd *cmd)
+{
+	struct selftest_obj *sobj;
+	int rc;
+
+	sobj = iommufd_test_get_self_test_device(ucmd->ictx, cmd->id);
+	if (IS_ERR(sobj))
+		return PTR_ERR(sobj);
+
+	rc = iommufd_device_pasid_attach(sobj->idev.idev,
+					 cmd->pasid_attach.pasid,
+					 &cmd->pasid_attach.pt_id);
+	iommufd_put_object(ucmd->ictx, &sobj->obj);
+	return rc;
+}
+
+static int iommufd_test_pasid_replace(struct iommufd_ucmd *ucmd,
+				      struct iommu_test_cmd *cmd)
+{
+	struct selftest_obj *sobj;
+	int rc;
+
+	sobj = iommufd_test_get_self_test_device(ucmd->ictx, cmd->id);
+	if (IS_ERR(sobj))
+		return PTR_ERR(sobj);
+
+	rc = iommufd_device_pasid_replace(sobj->idev.idev,
+					  cmd->pasid_attach.pasid,
+					  &cmd->pasid_attach.pt_id);
+	iommufd_put_object(ucmd->ictx, &sobj->obj);
+	return rc;
+}
+
+static int iommufd_test_pasid_detach(struct iommufd_ucmd *ucmd,
+				     struct iommu_test_cmd *cmd)
+{
+	struct selftest_obj *sobj;
+
+	sobj = iommufd_test_get_self_test_device(ucmd->ictx, cmd->id);
+	if (IS_ERR(sobj))
+		return PTR_ERR(sobj);
+
+	iommufd_device_pasid_detach(sobj->idev.idev,
+				    cmd->pasid_detach.pasid);
+	iommufd_put_object(ucmd->ictx, &sobj->obj);
+	return 0;
+}
+
+static inline struct iommufd_hw_pagetable *
+iommufd_get_hwpt(struct iommufd_ucmd *ucmd, u32 id)
+{
+	struct iommufd_object *pt_obj;
+
+	pt_obj = iommufd_get_object(ucmd->ictx, id, IOMMUFD_OBJ_ANY);
+	if (IS_ERR(pt_obj))
+		return ERR_CAST(pt_obj);
+
+	if (pt_obj->type != IOMMUFD_OBJ_HWPT_NESTED &&
+	    pt_obj->type != IOMMUFD_OBJ_HWPT_PAGING) {
+		iommufd_put_object(ucmd->ictx, pt_obj);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return container_of(pt_obj, struct iommufd_hw_pagetable, obj);
+}
+
+static int iommufd_test_pasid_check_domain(struct iommufd_ucmd *ucmd,
+					   struct iommu_test_cmd *cmd)
+{
+	struct iommu_domain *attached_domain, *expect_domain = NULL;
+	struct iommufd_hw_pagetable *hwpt = NULL;
+	struct selftest_obj *sobj;
+	struct mock_dev *mdev;
+	bool result;
+	int rc = 0;
+
+	sobj = iommufd_test_get_self_test_device(ucmd->ictx, cmd->id);
+	if (IS_ERR(sobj))
+		return PTR_ERR(sobj);
+
+	mdev = sobj->idev.mock_dev;
+
+	attached_domain = iommu_get_domain_for_dev_pasid(&mdev->dev,
+							 cmd->pasid_check.pasid, 0);
+	if (IS_ERR(attached_domain))
+		attached_domain = NULL;
+
+	if (cmd->pasid_check.hwpt_id) {
+		hwpt = iommufd_get_hwpt(ucmd, cmd->pasid_check.hwpt_id);
+		if (IS_ERR(hwpt)) {
+			rc = PTR_ERR(hwpt);
+			goto out_put_dev;
+		}
+		expect_domain = hwpt->domain;
+	}
+
+	result = (attached_domain == expect_domain) ? 1 : 0;
+	if (copy_to_user(u64_to_user_ptr(cmd->pasid_check.out_result_ptr),
+			 &result, sizeof(result)))
+		rc = -EFAULT;
+	if (hwpt)
+		iommufd_put_object(ucmd->ictx, &hwpt->obj);
+out_put_dev:
+	iommufd_put_object(ucmd->ictx, &sobj->obj);
+	return rc;
+}
+
 void iommufd_selftest_destroy(struct iommufd_object *obj)
 {
 	struct selftest_obj *sobj = container_of(obj, struct selftest_obj, obj);
@@ -1497,6 +1623,14 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 					  cmd->dirty.page_size,
 					  u64_to_user_ptr(cmd->dirty.uptr),
 					  cmd->dirty.flags);
+	case IOMMU_TEST_OP_PASID_ATTACH:
+		return iommufd_test_pasid_attach(ucmd, cmd);
+	case IOMMU_TEST_OP_PASID_REPLACE:
+		return iommufd_test_pasid_replace(ucmd, cmd);
+	case IOMMU_TEST_OP_PASID_DETACH:
+		return iommufd_test_pasid_detach(ucmd, cmd);
+	case IOMMU_TEST_OP_PASID_CHECK_DOMAIN:
+		return iommufd_test_pasid_check_domain(ucmd, cmd);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -1540,6 +1674,7 @@ int __init iommufd_test_init(void)
 		goto err_sysfs;
 
 	mock_iommu_device.max_pasids = (1 << 20);
+	pasid_1024_attached = false;
 	return 0;
 
 err_sysfs:
-- 
2.34.1


