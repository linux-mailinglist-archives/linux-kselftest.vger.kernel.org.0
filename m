Return-Path: <linux-kselftest+bounces-249-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7487EF39D
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Nov 2023 14:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B958A1F2637D
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Nov 2023 13:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A75E31A9D;
	Fri, 17 Nov 2023 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OiLNxgOL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3C1D4B;
	Fri, 17 Nov 2023 05:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700227098; x=1731763098;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Xlos/TDjJ1TlU8lUh8JteOAv937jkZW/VG6cMFf2KwU=;
  b=OiLNxgOLCddfTQV8DMhPBB+WkvdYzEiFcO55Ngi5kiTI9E/xSf0Z711F
   BwQEHODmsRFe1BCiGF0gmoaMYKGrUVdILVvFlYeFu/hV3eQaK2ldNpsr6
   PB+1pOr4sbbJfK2aEYS7lV8uKkMP2X2I1i4o7buYbUOe36cPoEwVGBP5A
   JT5dDD1IgwsfkOvp8dabwKLDceE+8TZSjXqccghacvm97VLt/b+2DGOkr
   wYHij09QCgXqfg3GfF89H6EssPMAih/QRAu+HJv6ASb/2OWQQsLZXjGKQ
   jRPO0XAfR3D4i5fYX7cUqUZLr151JzFjqXoJ8i9+xl7qkgiG1p2Qfi8ra
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="381685576"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="381685576"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 05:18:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="794831176"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="794831176"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga008.jf.intel.com with ESMTP; 17 Nov 2023 05:18:17 -0800
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
Subject: [PATCH v7 0/3] Add Intel VT-d nested translation (part 2/2)
Date: Fri, 17 Nov 2023 05:18:13 -0800
Message-Id: <20231117131816.24359-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the second part to add Intel VT-d nested translation based on IOMMUFD
nesting infrastructure. As the iommufd nesting infrastructure series [1],
iommu core supports new ops to invalidate the cache after the modifictions
in stage-1 page table. So far, the cache invalidation data is vendor specific,
the data_type (IOMMU_HWPT_DATA_VTD_S1) defined for the vendor specific HWPT
allocation is reused in the cache invalidation path. User should provide the
correct data_type that suit with the type used in HWPT allocation.

IOMMU_HWPT_INVALIDATE iotcl returns an error in @out_driver_error_code. However
Intel VT-d does not define error code so far, so it's not easy to pre-define it
in iommufd neither. As a result, this field should just be ignored on VT-d platform.

Complete code can be found in [2], corresponding QEMU could can be found in [3].

[1] https://lore.kernel.org/linux-iommu/20231117130717.19875-1-yi.l.liu@intel.com/#t
[2] https://github.com/yiliu1765/iommufd/tree/iommufd_nesting
[3] https://github.com/yiliu1765/qemu/tree/zhenzhong/wip/iommufd_nesting_rfcv1

Change log:

v7:
 - No much change, just rebase on top of 6.7-rc1

v6: https://lore.kernel.org/linux-iommu/20231020093719.18725-1-yi.l.liu@intel.com/
 - Address comments from Kevin
 - Split the VT-d nesting series into two parts (Jason)

v5: https://lore.kernel.org/linux-iommu/20230921075431.125239-1-yi.l.liu@intel.com/
 - Add Kevin's r-b for patch 2, 3 ,5 8, 10
 - Drop enforce_cache_coherency callback from the nested type domain ops (Kevin)
 - Remove duplicate agaw check in patch 04 (Kevin)
 - Remove duplicate domain_update_iommu_cap() in patch 06 (Kevin)
 - Check parent's force_snooping to set pgsnp in the pasid entry (Kevin)
 - uapi data structure check (Kevin)
 - Simplify the errata handling as user can allocate nested parent domain

v4: https://lore.kernel.org/linux-iommu/20230724111335.107427-1-yi.l.liu@intel.com/
 - Remove ascii art tables (Jason)
 - Drop EMT (Tina, Jason)
 - Drop MTS and related definitions (Kevin)
 - Rename macro IOMMU_VTD_PGTBL_ to IOMMU_VTD_S1_ (Kevin)
 - Rename struct iommu_hwpt_intel_vtd_ to iommu_hwpt_vtd_ (Kevin)
 - Rename struct iommu_hwpt_intel_vtd to iommu_hwpt_vtd_s1 (Kevin)
 - Put the vendor specific hwpt alloc data structure before enuma iommu_hwpt_type (Kevin)
 - Do not trim the higher page levels of S2 domain in nested domain attachment as the
   S2 domain may have been used independently. (Kevin)
 - Remove the first-stage pgd check against the maximum address of s2_domain as hw
   can check it anyhow. It makes sense to check every pfns used in the stage-1 page
   table. But it cannot make it. So just leave it to hw. (Kevin)
 - Split the iotlb flush part into an order of uapi, helper and callback implementation (Kevin)
 - Change the policy of VT-d nesting errata, disallow RO mapping once a domain is used
   as parent domain of a nested domain. This removes the nested_users counting. (Kevin)
 - Minor fix for "make htmldocs"

v3: https://lore.kernel.org/linux-iommu/20230511145110.27707-1-yi.l.liu@intel.com/
 - Further split the patches into an order of adding helpers for nested
   domain, iotlb flush, nested domain attachment and nested domain allocation
   callback, then report the hw_info to userspace.
 - Add batch support in cache invalidation from userspace
 - Disallow nested translation usage if RO mappings exists in stage-2 domain
   due to errata on readonly mappings on Sapphire Rapids platform.

v2: https://lore.kernel.org/linux-iommu/20230309082207.612346-1-yi.l.liu@intel.com/
 - The iommufd infrastructure is split to be separate series.

v1: https://lore.kernel.org/linux-iommu/20230209043153.14964-1-yi.l.liu@intel.com/

Regards,
	Yi Liu

Yi Liu (3):
  iommufd: Add data structure for Intel VT-d stage-1 cache invalidation
  iommu/vt-d: Make iotlb flush helpers to be extern
  iommu/vt-d: Add iotlb flush for nested domain

 drivers/iommu/intel/iommu.c  | 10 +++----
 drivers/iommu/intel/iommu.h  |  6 ++++
 drivers/iommu/intel/nested.c | 54 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/iommufd.h | 36 ++++++++++++++++++++++++
 4 files changed, 101 insertions(+), 5 deletions(-)

-- 
2.34.1


