Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBEB75F439
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 13:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbjGXLEL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 07:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbjGXLEK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 07:04:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00DD12E;
        Mon, 24 Jul 2023 04:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690196649; x=1721732649;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Jt6M8sUWV3u8Y+MFDb2Z6bVVr18T0wsHPHfO6KI1CTs=;
  b=S+m2PETYR+SyhHOiMwLr3vJlhsj0FxPS7qDF6u2yFIL9Pxca/kQKny4l
   +89duZzafp1Cp0P6pp2Xg7Lp4c3iXF3ifeOXWRnPRbcw1yDRQ/LGIy11l
   USennes5oLNVPt6lAwJlUEjFqpEOkKT8w8mMvTC8bAZPee+KMJaU/Xej8
   ro99UHvYZE4NFbNgIMchkr0+WD3Gq8206oBPO5XNc6f296JV/+6TyDjO0
   ByOQ48sZt4WNKBqpYqBwDroFIFvnl9OVqcWJug0CgfNHLpi8OuOan4gts
   LbJTwg/440w8Q4bsbreF/EaPe84jDmH+yGIxhuIhMUuYtfShlX+zyGZhI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="366301775"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="366301775"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:04:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="815775737"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="815775737"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jul 2023 04:04:08 -0700
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
Subject: [PATCH v3 00/17] iommufd: Add nesting infrastructure
Date:   Mon, 24 Jul 2023 04:03:49 -0700
Message-Id: <20230724110406.107212-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
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

In IOMMUFD, all the translation tables are tracked by hw_pagetable (hwpt)
and each has an iommu_domain allocated from iommu driver. So in this series
hw_pagetable and iommu_domain means the same thing if no special note.
IOMMUFD has already supported allocating hw_pagetable that is linked with
an IOAS. However, nesting requires IOMMUFD to allow allocating hw_pagetable
with driver specific parameters and interface to sync stage-1 IOTLB as user
owns the stage-1 translation table.

This series is based on the iommu hw info reporting series [1]. It first
introduces new iommu op for allocating domains with user data and the op
for invalidate stage-1 IOTLB, and then extend the IOMMUFD internal infrastructure
to accept user_data and parent hwpt, then relay the data to iommu core to
allocate user iommu_domain. After it, extends the ioctl IOMMU_HWPT_ALLOC to
accept user data and stage-2 hwpt ID to allocate hwpt. Along with it, ioctl
IOMMU_HWPT_INVALIDATE is added to invalidate stage-1 IOTLB. This is needed
for user-managed hwpts. Selftest is added as well to cover the new ioctls.

Complete code can be found in [2], QEMU could can be found in [3].

At last, this is a team work together with Nicolin Chen, Lu Baolu. Thanks
them for the help. ^_^. Look forward to your feedbacks.

[1] https://lore.kernel.org/linux-iommu/20230724105936.107042-1-yi.l.liu@intel.com/
[2] https://github.com/yiliu1765/iommufd/tree/iommufd_nesting
[3] https://github.com/yiliu1765/qemu/tree/wip/iommufd_rfcv4_nesting

Change log:

v3:
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

Lu Baolu (2):
  iommu: Add new iommu op to create domains owned by userspace
  iommu: Add nested domain support

Nicolin Chen (6):
  iommufd/hw_pagetable: Do not populate user-managed hw_pagetables
  iommufd: Only enforce IOMMU_RESV_SW_MSI when attaching user-managed
    HWPT
  iommufd/selftest: Add domain_alloc_user() support in iommu mock
  iommufd/selftest: Add coverage for IOMMU_HWPT_ALLOC with user data
  iommufd/selftest: Add IOMMU_TEST_OP_MD_CHECK_IOTLB test op
  iommufd/selftest: Add coverage for IOMMU_HWPT_INVALIDATE ioctl

Yi Liu (9):
  iommufd/hw_pagetable: Use domain_alloc_user op for domain allocation
  iommufd: Pass in hwpt_type/parent/user_data to
    iommufd_hw_pagetable_alloc()
  iommufd: Add IOMMU_RESV_IOVA_RANGES
  iommufd: IOMMU_HWPT_ALLOC allocation with user data
  iommufd: Add IOMMU_HWPT_INVALIDATE
  iommufd/selftest: Add a helper to get test device
  iommufd/selftest: Add IOMMU_TEST_OP_DEV_[ADD|DEL]_RESERVED to add/del
    reserved regions to selftest device
  iommufd/selftest: Add .get_resv_regions() for mock_dev
  iommufd/selftest: Add coverage for IOMMU_RESV_IOVA_RANGES

 drivers/iommu/iommufd/device.c                |   9 +-
 drivers/iommu/iommufd/hw_pagetable.c          | 181 +++++++++++-
 drivers/iommu/iommufd/io_pagetable.c          |   5 +-
 drivers/iommu/iommufd/iommufd_private.h       |  20 +-
 drivers/iommu/iommufd/iommufd_test.h          |  36 +++
 drivers/iommu/iommufd/main.c                  |  59 +++-
 drivers/iommu/iommufd/selftest.c              | 266 ++++++++++++++++--
 include/linux/iommu.h                         |  34 +++
 include/uapi/linux/iommufd.h                  |  96 ++++++-
 tools/testing/selftests/iommu/iommufd.c       | 224 ++++++++++++++-
 tools/testing/selftests/iommu/iommufd_utils.h |  70 +++++
 11 files changed, 958 insertions(+), 42 deletions(-)

-- 
2.34.1

