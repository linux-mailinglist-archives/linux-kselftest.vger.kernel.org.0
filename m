Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5B375F43B
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 13:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbjGXLEO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 07:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbjGXLEM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 07:04:12 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D4CFF;
        Mon, 24 Jul 2023 04:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690196651; x=1721732651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3GrlJi/a+lAeB3GC1MTYxABhNsVM8smyv4iDkQdAdoU=;
  b=QnDquC3pUlhL8g8YXlCBufINSAsksrjBsibDgaJK0gEW8/4QQupcxHxN
   SlAIlQauqa5mwGiuZOfEstq9iKv06U48CstVlhZf66ACUzNrUJ7VGNgTh
   BqleQjxklew/7OIb1cj/uxjX3tlYcBEwvjLwYu3DrFBA1QecBuYRLY9Cf
   Q0gRii8nISkcJTR1cwaTZ7iS79fzrnakDysvXNNKt56hf+/d726NMHh3W
   qMKXIa8rIKdSrU6BXgkfbG6dzc4RzXo6k9UhbgmifM498U2ZmNVpo4z/I
   B3x1ONWF8vJAHSsxO5iXsl8iI+Tk0zgyGJtAeEmGTOATtvY1g3k/BNrRe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="366301779"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="366301779"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:04:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="815775745"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="815775745"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jul 2023 04:04:09 -0700
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
        zhenzhong.duan@intel.com
Subject: [PATCH v3 01/17] iommu: Add new iommu op to create domains owned by userspace
Date:   Mon, 24 Jul 2023 04:03:50 -0700
Message-Id: <20230724110406.107212-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724110406.107212-1-yi.l.liu@intel.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Lu Baolu <baolu.lu@linux.intel.com>

Introduce a new iommu_domain op to create domains owned by userspace,
e.g. through iommufd. These domains have a few different properties
compares to kernel owned domains:

 - They may be UNMANAGED domains, but created with special parameters.
   For instance aperture size changes/number of levels, different
   IOPTE formats, or other things necessary to make a vIOMMU work

 - We have to track all the memory allocations with GFP_KERNEL_ACCOUNT
   to make the cgroup sandbox stronger

 - Device-specialty domains, such as NESTED domains can be created by
   iommufd.

The new op clearly says the domain is being created by IOMMUFD, that
the domain is intended for userspace use, and it provides a way to pass
a driver specific uAPI structure to customize the created domain to
exactly what the vIOMMU userspace driver requires.

iommu drivers that cannot support VFIO/IOMMUFD should not support this
op. This includes any driver that cannot provide a fully functional
UNMANAGED domain.

This op chooses to make the special parameters opaque to the core. This
suits the current usage model where accessing any of the IOMMU device
special parameters does require a userspace driver that matches the
kernel driver. If a need for common parameters, implemented similarly
by several drivers, arises then there is room in the design to grow a
generic parameter set as well.

This new op for now is only supposed to be used by iommufd, hence no
wrapper for it. iommufd would call the callback directly. As for domain
free, iommufd would use iommu_domain_free().

enum iommu_hwpt_type is defined to differentiate the user parameters use
by different usages. For the allocations that don't require user parameter,
IOMMU_HWPT_TYPE_DEFAULT is defined for backward compatibility. Other types
would be added by future iommu vendor driver extensions.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 include/linux/iommu.h        | 20 ++++++++++++++++++++
 include/uapi/linux/iommufd.h |  8 ++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 4199e13b34e6..ecbec2627b63 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -226,6 +226,15 @@ struct iommu_iotlb_gather {
 	bool			queued;
 };
 
+/*
+ * The user data to allocate a specific type user iommu domain
+ *
+ * This includes the corresponding driver data structures in
+ * include/uapi/linux/iommufd.h.
+ */
+union iommu_domain_user_data {
+};
+
 /**
  * struct iommu_ops - iommu ops and capabilities
  * @capable: check capability
@@ -235,6 +244,13 @@ struct iommu_iotlb_gather {
  *           after use. Return the data buffer if success, or ERR_PTR on
  *           failure.
  * @domain_alloc: allocate iommu domain
+ * @domain_alloc_user: allocate a user iommu domain corresponding to the input
+ *                     @hwpt_type that is defined as enum iommu_hwpt_type in the
+ *                     include/uapi/linux/iommufd.h. A returning domain will be
+ *                     set to an IOMMU_DOMAIN_NESTED type, upon valid @user_data
+ *                     and @parent that is a kernel-managed domain. Otherwise,
+ *                     it will be set to an IOMMU_DOMAIN_UNMANAGED type. Return
+ *                     ERR_PTR on allocation failure.
  * @probe_device: Add device to iommu driver handling
  * @release_device: Remove device from iommu driver handling
  * @probe_finalize: Do final setup work after the device is added to an IOMMU
@@ -275,6 +291,10 @@ struct iommu_ops {
 
 	/* Domain allocation and freeing by the iommu driver */
 	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
+	struct iommu_domain *(*domain_alloc_user)(struct device *dev,
+						  enum iommu_hwpt_type hwpt_type,
+						  struct iommu_domain *parent,
+						  const union iommu_domain_user_data *user_data);
 
 	struct iommu_device *(*probe_device)(struct device *dev);
 	void (*release_device)(struct device *dev);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 4295362e7b44..d38bc54fd5f2 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -347,6 +347,14 @@ struct iommu_vfio_ioas {
 };
 #define IOMMU_VFIO_IOAS _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VFIO_IOAS)
 
+/**
+ * enum iommu_hwpt_type - IOMMU HWPT Type
+ * @IOMMU_HWPT_TYPE_DEFAULT: default
+ */
+enum iommu_hwpt_type {
+	IOMMU_HWPT_TYPE_DEFAULT,
+};
+
 /**
  * struct iommu_hwpt_alloc - ioctl(IOMMU_HWPT_ALLOC)
  * @size: sizeof(struct iommu_hwpt_alloc)
-- 
2.34.1

