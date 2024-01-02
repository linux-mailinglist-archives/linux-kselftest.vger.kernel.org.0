Return-Path: <linux-kselftest+bounces-2569-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F9E821DD0
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 15:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E3F52836B8
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 14:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F368111727;
	Tue,  2 Jan 2024 14:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hI6CwoeN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E8112E6A;
	Tue,  2 Jan 2024 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704206318; x=1735742318;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PNnHZWpu80Ev+jF1xRGdvfH/feR0YuAyKcmPZJfkpJ8=;
  b=hI6CwoeNlAoohD/EhWeqw1/2X5uCw2s4w9Lo0OP8GOwWI2Ly/S4N81ON
   LYzQ8SnaFh/hYkbcjqZZxGHPZMhXG+H1VMtX8McaYzq40k9/ZJT5fZuL9
   BZJYpFTpVGdl3xHNmunkqZb/pIedGCHXIhMEVq/N18LR0IEBtYaW+Yrji
   F9OIm99w6bSKswqi1DTcrK19xk/c/Irgexep4aYVu+lIqhUhnyW14i9Ep
   3bSFDlt4GLIsKX6+9w8SO6BXaP5gVAgrSHXTXl1ehcG2TJZYbssXEAAzQ
   7gCl8TqEWxvVrjjimPH+sxpvYtEqMbnMtaA8Mjx9tBHZd8AZ0hQmSi5js
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="10270405"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="10270405"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 06:38:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="923234240"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="923234240"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga001.fm.intel.com with ESMTP; 02 Jan 2024 06:38:35 -0800
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
	yan.y.zhao@intel.com,
	j.granados@samsung.com
Subject: [PATCH v10 00/10] Add iommufd nesting (part 2/2)
Date: Tue,  2 Jan 2024 06:38:24 -0800
Message-Id: <20240102143834.146165-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nested translation is a hardware feature that is supported by many modern
IOMMU hardwares. It has two stages (stage-1, stage-2) address translation
to get access to the physical address. stage-1 translation table is owned
by userspace (e.g. by a guest OS), while stage-2 is owned by kernel. Changes
to stage-1 translation table should be followed by an IOTLB invalidation.

Take Intel VT-d as an example, the stage-1 translation table is I/O page
table. As the below diagram shows, guest I/O page table pointer in GPA
(guest physical address) is passed to host and be used to perform the stage-1
address translation. Along with it, modifications to present mappings in the
guest I/O page table should be followed with an IOTLB invalidation.

    .-------------.  .---------------------------.
    |   vIOMMU    |  | Guest I/O page table      |
    |             |  '---------------------------'
    .----------------/
    | PASID Entry |--- PASID cache flush --+
    '-------------'                        |
    |             |                        V
    |             |           I/O page table pointer in GPA
    '-------------'
Guest
------| Shadow |---------------------------|--------
      v        v                           v
Host
    .-------------.  .------------------------.
    |   pIOMMU    |  |  FS for GIOVA->GPA     |
    |             |  '------------------------'
    .----------------/  |
    | PASID Entry |     V (Nested xlate)
    '----------------\.----------------------------------.
    |             |   | SS for GPA->HPA, unmanaged domain|
    |             |   '----------------------------------'
    '-------------'
Where:
 - FS = First stage page tables
 - SS = Second stage page tables
<Intel VT-d Nested translation>

This series is based on the first part which was merged [1], this series is to
add the cache invalidation interface or the userspace to invalidate cache after
modifying the stage-1 page table. This includes both the iommufd changes and the
VT-d driver changes.

Complete code can be found in [2], QEMU could can be found in [3].

At last, this is a team work together with Nicolin Chen, Lu Baolu. Thanks
them for the help. ^_^. Look forward to your feedbacks.

[1] https://lore.kernel.org/linux-iommu/20231026044216.64964-1-yi.l.liu@intel.com/ - merged
[2] https://github.com/yiliu1765/iommufd/tree/iommufd_nesting
[3] https://github.com/yiliu1765/qemu/tree/zhenzhong/wip/iommufd_nesting_rfcv1

Change log:

v10:
 - Minor tweak to patch 07 (Kevin)
 - Rebase on top of 6.7-rc8

v9: https://lore.kernel.org/linux-iommu/20231228150629.13149-1-yi.l.liu@intel.com/
 - Add a test case which sets both IOMMU_TEST_INVALIDATE_FLAG_ALL and
   IOMMU_TEST_INVALIDATE_FLAG_TRIGGER_ERROR in flags, and expect to succeed
   and see an 'error'. (Kevin)
 - Returns -ETIMEOUT in qi_check_fault() if caller is interested with the
   fault when timeout happens. If not, the qi_submit_sync() will keep retry
   hence unable to report the error back to user. For now, only the user cache
   invalidation path has interest on the time out error. So this change only
   affects the user cache invalidation path. Other path will still hang in
   qi_submit_sync() when timeout happens. (Kevin)

v8: https://lore.kernel.org/linux-iommu/20231227161354.67701-1-yi.l.liu@intel.com/
 - Pass invalidation hint to the cache invalidation helper in the cache_invalidate_user
   op path (Kevin)
 - Move the devTLB invalidation out of info->iommu loop (Kevin, Weijiang)
 - Clear *fault per restart in qi_submit_sync() to avoid acroos submission error
   accumulation. (Kevin)
 - Define the vtd cache invalidation uapi structure in separate patch (Kevin)
 - Rename inv_error to be hw_error (Kevin)
 - Rename 'reqs_uptr', 'req_type', 'req_len' and 'req_num' to be 'data_uptr',
   'data_type', "entry_len' and 'entry_num" (Kevin)
 - Allow user to set IOMMU_TEST_INVALIDATE_FLAG_ALL and IOMMU_TEST_INVALIDATE_FLAG_TRIGGER_ERROR
   in the same time (Kevin)

v7: https://lore.kernel.org/linux-iommu/20231221153948.119007-1-yi.l.liu@intel.com/
 - Remove domain->ops->cache_invalidate_user check in hwpt alloc path due
   to failure in bisect (Baolu)
 - Remove out_driver_error_code from struct iommu_hwpt_invalidate after
   discussion in v6. Should expect per-entry error code.
 - Rework the selftest cache invalidation part to report a per-entry error
 - Allow user to pass in an empty array to have a try-and-fail mechanism for
   user to check if a given req_type is supported by the kernel (Jason)
 - Define a separate enum type for cache invalidation data (Jason)
 - Fix the IOMMU_HWPT_INVALIDATE to always update the req_num field before
   returning (Nicolin)
 - Merge the VT-d nesting part 2/2
   https://lore.kernel.org/linux-iommu/20231117131816.24359-1-yi.l.liu@intel.com/
   into this series to avoid defining empty enum in the middle of the series.
   The major difference is adding the VT-d related invalidation uapi structures
   together with the generic data structures in patch 02 of this series.
 - VT-d driver was refined to report ICE/ITE error from the bottom cache
   invalidation submit helpers, hence the cache_invalidate_user op could
   report such errors via the per-entry error field to user. VT-d driver
   will not stop the invalidation array walking due to the ICE/ITE errors
   as such errors are defined by VT-d spec, userspace should be able to
   handle it and let the real user (say Virtual Machine) know about it.
   But for other errors like invalid uapi data structure configuration,
   memory copy failure, such errors should stop the array walking as it
   may have more issues if go on.
 - Minor fixes per Jason and Kevin's review comments

v6: https://lore.kernel.org/linux-iommu/20231117130717.19875-1-yi.l.liu@intel.com/
 - No much change, just rebase on top of 6.7-rc1 as part 1/2 is merged

v5: https://lore.kernel.org/linux-iommu/20231020092426.13907-1-yi.l.liu@intel.com/#t
 - Split the iommufd nesting series into two parts of alloc_user and
   invalidation (Jason)
 - Split IOMMUFD_OBJ_HW_PAGETABLE to IOMMUFD_OBJ_HWPT_PAGING/_NESTED, and
   do the same with the structures/alloc()/abort()/destroy(). Reworked the
   selftest accordingly too. (Jason)
 - Move hwpt/data_type into struct iommu_user_data from standalone op
   arguments. (Jason)
 - Rename hwpt_type to be data_type, the HWPT_TYPE to be HWPT_ALLOC_DATA,
   _TYPE_DEFAULT to be _ALLOC_DATA_NONE (Jason, Kevin)
 - Rename iommu_copy_user_data() to iommu_copy_struct_from_user() (Kevin)
 - Add macro to the iommu_copy_struct_from_user() to calculate min_size
   (Jason)
 - Fix two bugs spotted by ZhaoYan

v4: https://lore.kernel.org/linux-iommu/20230921075138.124099-1-yi.l.liu@intel.com/
 - Separate HWPT alloc/destroy/abort functions between user-managed HWPTs
   and kernel-managed HWPTs
 - Rework invalidate uAPI to be a multi-request array-based design
 - Add a struct iommu_user_data_array and a helper for driver to sanitize
   and copy the entry data from user space invalidation array
 - Add a patch fixing TEST_LENGTH() in selftest program
 - Drop IOMMU_RESV_IOVA_RANGES patches
 - Update kdoc and inline comments
 - Drop the code to add IOMMU_RESV_SW_MSI to kernel-managed HWPT in nested translation,
   this does not change the rule that resv regions should only be added to the
   kernel-managed HWPT. The IOMMU_RESV_SW_MSI stuff will be added in later series
   as it is needed only by SMMU so far.

v3: https://lore.kernel.org/linux-iommu/20230724110406.107212-1-yi.l.liu@intel.com/
 - Add new uAPI things in alphabetical order
 - Pass in "enum iommu_hwpt_type hwpt_type" to op->domain_alloc_user for
   sanity, replacing the previous op->domain_alloc_user_data_len solution
 - Return ERR_PTR from domain_alloc_user instead of NULL
 - Only add IOMMU_RESV_SW_MSI to kernel-managed HWPT in nested translation (Kevin)
 - Add IOMMU_RESV_IOVA_RANGES to report resv iova ranges to userspace hence
   userspace is able to exclude the ranges in the stage-1 HWPT (e.g. guest I/O
   page table). (Kevin)
 - Add selftest coverage for the new IOMMU_RESV_IOVA_RANGES ioctl
 - Minor changes per Kevin's inputs

v2: https://lore.kernel.org/linux-iommu/20230511143844.22693-1-yi.l.liu@intel.com/
 - Add union iommu_domain_user_data to include all user data structures to avoid
   passing void * in kernel APIs.
 - Add iommu op to return user data length for user domain allocation
 - Rename struct iommu_hwpt_alloc::data_type to be hwpt_type
 - Store the invalidation data length in iommu_domain_ops::cache_invalidate_user_data_len
 - Convert cache_invalidate_user op to be int instead of void
 - Remove @data_type in struct iommu_hwpt_invalidate
 - Remove out_hwpt_type_bitmap in struct iommu_hw_info hence drop patch 08 of v1

v1: https://lore.kernel.org/linux-iommu/20230309080910.607396-1-yi.l.liu@intel.com/

Thanks,
	Yi Liu

Lu Baolu (4):
  iommu: Add cache_invalidate_user op
  iommu/vt-d: Allow qi_submit_sync() to return the QI faults
  iommu/vt-d: Convert stage-1 cache invalidation to return QI fault
  iommu/vt-d: Add iotlb flush for nested domain

Nicolin Chen (4):
  iommu: Add iommu_copy_struct_from_user_array helper
  iommufd/selftest: Add mock_domain_cache_invalidate_user support
  iommufd/selftest: Add IOMMU_TEST_OP_MD_CHECK_IOTLB test op
  iommufd/selftest: Add coverage for IOMMU_HWPT_INVALIDATE ioctl

Yi Liu (2):
  iommufd: Add IOMMU_HWPT_INVALIDATE
  iommufd: Add data structure for Intel VT-d stage-1 cache invalidation

 drivers/iommu/intel/dmar.c                    |  42 ++--
 drivers/iommu/intel/iommu.c                   |  12 +-
 drivers/iommu/intel/iommu.h                   |   8 +-
 drivers/iommu/intel/irq_remapping.c           |   2 +-
 drivers/iommu/intel/nested.c                  | 107 ++++++++++
 drivers/iommu/intel/pasid.c                   |  14 +-
 drivers/iommu/intel/svm.c                     |  14 +-
 drivers/iommu/iommufd/hw_pagetable.c          |  41 ++++
 drivers/iommu/iommufd/iommufd_private.h       |  10 +
 drivers/iommu/iommufd/iommufd_test.h          |  39 ++++
 drivers/iommu/iommufd/main.c                  |   3 +
 drivers/iommu/iommufd/selftest.c              |  86 ++++++++
 include/linux/iommu.h                         | 100 +++++++++
 include/uapi/linux/iommufd.h                  | 101 ++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 190 ++++++++++++++++++
 tools/testing/selftests/iommu/iommufd_utils.h |  57 ++++++
 16 files changed, 787 insertions(+), 39 deletions(-)

-- 
2.34.1


