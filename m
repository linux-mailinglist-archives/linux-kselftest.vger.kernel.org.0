Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADB17D0B51
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 11:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376626AbjJTJTv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 05:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376622AbjJTJTv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 05:19:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB47FAB;
        Fri, 20 Oct 2023 02:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697793588; x=1729329588;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GE50E74CDSheuD47WGVg2HwegdOBnmPRyhVaEXylCU0=;
  b=PKGm+RnEfJqX9NXefsi5bdvNOEav1zq85IhddLAZ/2SrOs9+U3WIH0/r
   EBH+DM5umv/Gkh67rotMHDU2PT38iWO1Tdxqp7vmIl6q+Gy4vQYziAkbP
   r6hMLHKPHQT/wjeXwGRpIwxAzWB1YNtFxEWrwcsVV/L/9XXo/kSDlKtuc
   Be3pDMJ0Nopu5iZPETyZCiS9MfUzOWPwTomyU7rwzxRp6ZEbd4zB4X3N/
   POCfLHmj530tfNXZSt0aY9fqvwTS2TiIJZJtOpbh+qKJ4tL9cA5VBIAiG
   FLr5PDwvD+cfRCI4ehpsA9v6a9JfFDEgJMPWBQVYDOYJ5bj6uVq+nr1JA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="366693240"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="366693240"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:19:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="707179354"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="707179354"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga003.jf.intel.com with ESMTP; 20 Oct 2023 02:19:47 -0700
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
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com,
        xin.zeng@intel.com
Subject: [PATCH v5 00/10] iommufd: Add nesting infrastructure (part 1/2)
Date:   Fri, 20 Oct 2023 02:19:36 -0700
Message-Id: <20231020091946.12173-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Nested translation is a hardware feature that is supported by many modern
IOMMU hardwares. It has two stages of address translations to get access
to the physical address. A stage-1 translation table is owned by userspace
(e.g. by a guest OS), while a stage-2 is owned by kernel. Any change to a
stage-1 translation table should be followed by an IOTLB invalidation.

Take Intel VT-d as an example, the stage-1 translation table is guest I/O
page table. As the below diagram shows, the guest I/O page table pointer
in GPA (guest physical address) is passed to host and be used to perform
a stage-1 translation. Along with it, a modification to present mappings
in the guest I/O page table should be followed by an IOTLB invalidation.

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

In IOMMUFD, all the translation tables are tracked by hw_pagetable (hwpt)
and each hwpt is backed by an iommu_domain allocated from an iommu driver.
So in this series hw_pagetable and iommu_domain means the same thing if no
special note. IOMMUFD has already supported allocating hw_pagetable linked
with an IOAS. However, a nesting case requires IOMMUFD to allow allocating
hw_pagetable with driver specific parameters and interface to sync stage-1
IOTLB as user owns the stage-1 translation table.

This series is based on the iommu hw info reporting series [1] and nested
parent domain allocation [2]. It first extends domain_alloc_user to allocate
hwpt with user data by allowing the IOMMUFD internal infrastructure to accept
user_data and parent hwpt, relaying the user_data/parent to the iommu core
to allocate IOMMU_DOMAIN_NESTED. And it then extends the IOMMU_HWPT_ALLOC
ioctl to accept user data and a parent hwpt ID.

Note that this series is the part-1 set of a two-part nesting series. It
does not include the cache invalidation interface, which will be added in
the part 2.

Complete code can be found in [3], QEMU could can be found in [4].

At last, this is a team work together with Nicolin Chen, Lu Baolu. Thanks
them for the help. ^_^. Look forward to your feedbacks.

[1] https://lore.kernel.org/linux-iommu/20230818101033.4100-1-yi.l.liu@intel.com/#r - merged
[2] https://lore.kernel.org/linux-iommu/20230928071528.26258-1-yi.l.liu@intel.com/ - merged
[3] https://github.com/yiliu1765/iommufd/tree/iommufd_nesting
[4] https://github.com/yiliu1765/qemu/tree/zhenzhong/wip/iommufd_nesting_rfcv1

Change log:

v5:
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
 - Drop the code to add IOMMU_RESV_SW_MSI to kernel-managed HWPT in nested
   translation, this does not change the rule that resv regions should only
   be added to the kernel-managed HWPT. The IOMMU_RESV_SW_MSI stuff will be
   added in later series as it is needed only by SMMU so far.

v3: https://lore.kernel.org/linux-iommu/20230724110406.107212-1-yi.l.liu@intel.com/
 - Add new uAPI things in alphabetical order
 - Pass in "enum iommu_hwpt_type hwpt_type" to op->domain_alloc_user for
   sanity, replacing the previous op->domain_alloc_user_data_len solution
 - Return ERR_PTR from domain_alloc_user instead of NULL
 - Only add IOMMU_RESV_SW_MSI to kernel-managed HWPT in nested translation
   (Kevin)
 - Add IOMMU_RESV_IOVA_RANGES to report resv iova ranges to userspace hence
   userspace is able to exclude the ranges in the stage-1 HWPT (e.g. guest
   I/O page table). (Kevin)
 - Add selftest coverage for the new IOMMU_RESV_IOVA_RANGES ioctl
 - Minor changes per Kevin's inputs

v2: https://lore.kernel.org/linux-iommu/20230511143844.22693-1-yi.l.liu@intel.com/
 - Add union iommu_domain_user_data to include all user data structures to
   avoid passing void * in kernel APIs.
 - Add iommu op to return user data length for user domain allocation
 - Rename struct iommu_hwpt_alloc::data_type to be hwpt_type
 - Store the invalidation data length in
   iommu_domain_ops::cache_invalidate_user_data_len
 - Convert cache_invalidate_user op to be int instead of void
 - Remove @data_type in struct iommu_hwpt_invalidate
 - Remove out_hwpt_type_bitmap in struct iommu_hw_info hence drop patch 08
   of v1

v1: https://lore.kernel.org/linux-iommu/20230309080910.607396-1-yi.l.liu@intel.com/

Thanks,
	Yi Liu

Jason Gunthorpe (2):
  iommufd: Rename IOMMUFD_OBJ_HW_PAGETABLE to IOMMUFD_OBJ_HWPT_PAGING
  iommufd/device: Wrap IOMMUFD_OBJ_HWPT_PAGING-only configurations

Lu Baolu (1):
  iommu: Add IOMMU_DOMAIN_NESTED

Nicolin Chen (6):
  iommufd: Derive iommufd_hwpt_paging from iommufd_hw_pagetable
  iommufd: Share iommufd_hwpt_alloc with IOMMUFD_OBJ_HWPT_NESTED
  iommufd: Add a nested HW pagetable object
  iommu: Add iommu_copy_struct_from_user helper
  iommufd/selftest: Add nested domain allocation for mock domain
  iommufd/selftest: Add coverage for IOMMU_HWPT_ALLOC with nested HWPTs

Yi Liu (1):
  iommu: Pass in parent domain with user_data to domain_alloc_user op

 drivers/iommu/intel/iommu.c                   |   4 +-
 drivers/iommu/iommufd/device.c                | 184 +++++++++-----
 drivers/iommu/iommufd/hw_pagetable.c          | 237 ++++++++++++++----
 drivers/iommu/iommufd/iommufd_private.h       |  67 +++--
 drivers/iommu/iommufd/iommufd_test.h          |  18 ++
 drivers/iommu/iommufd/main.c                  |  10 +-
 drivers/iommu/iommufd/selftest.c              | 137 ++++++++--
 drivers/iommu/iommufd/vfio_compat.c           |   6 +-
 include/linux/iommu.h                         |  72 +++++-
 include/uapi/linux/iommufd.h                  |  31 ++-
 tools/testing/selftests/iommu/iommufd.c       | 120 +++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |   3 +-
 tools/testing/selftests/iommu/iommufd_utils.h |  31 ++-
 13 files changed, 752 insertions(+), 168 deletions(-)

-- 
2.34.1

