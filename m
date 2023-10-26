Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABACB7D7B8F
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 06:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjJZEjo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 00:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZEjo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 00:39:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC5B186;
        Wed, 25 Oct 2023 21:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698295182; x=1729831182;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m3fDRvRi7HmJsxb65MG5Rl+yHHn52+1i5R9VJ2QphWI=;
  b=gAk3oqO9Rp8C7dPHJKK0/zBFcPeW9PX3xIv/H9KRhxneWkLGdB01ypYl
   S7fdM6kPMs7SaYHk92mrKaMsJ2se7Qq9MqgZJEXB9zFK8CbwJXiFXslIb
   vJCBa9KMwDjSVfNF3JQk2gNybp6HFROtg0TdNM3OaAcBLW1WI0nKubzOQ
   157UZW43fkNFZenkWg8tqXMEcTlfQjsohfrSwK6KJNlFoW0N2PqKY9ZLI
   uoQ1Kcy6W9plwCnB3ViQPSWuuK+bcIVl/GH9AFIPki+4YNnFwATw1lvW3
   PwYIiV0mdyzWWQMBv6CqDEz+5cpQAnxZoZRCKZJ9wTHOUMdhQh4ibInGr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="9014394"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="9014394"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 21:39:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="708931211"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="708931211"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga003.jf.intel.com with ESMTP; 25 Oct 2023 21:39:39 -0700
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
Subject: [PATCH v7 00/10] iommufd: Add nesting infrastructure (part 1/2)
Date:   Wed, 25 Oct 2023 21:39:28 -0700
Message-Id: <20231026043938.63898-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Complete code can be found in [3], it is on top of Joao's dirty page tracking
v6 series and fix patches. QEMU could can be found in [4].

At last, this is a team work together with Nicolin Chen, Lu Baolu. Thanks
them for the help. ^_^. Look forward to your feedbacks.

[1] https://lore.kernel.org/linux-iommu/20230818101033.4100-1-yi.l.liu@intel.com/#r - merged
[2] https://lore.kernel.org/linux-iommu/20230928071528.26258-1-yi.l.liu@intel.com/ - merged
[3] https://github.com/yiliu1765/iommufd/tree/iommufd_nesting
[4] https://github.com/yiliu1765/qemu/tree/zhenzhong/wip/iommufd_nesting_rfcv1

Change log:

v7:
 - Fix a bug from Kevin
 - Add r-b from Kevin
 - Adopt Jason's suggestion to plumb user_data pointer to hwpt_paging allocation
   https://lore.kernel.org/linux-iommu/20231024173009.GQ3952@nvidia.com/
 - Select bit 6 for __IOMMU_DOMAIN_NESTED (Jason)
 - Other compiling fixes per linux-next integration (Jason/Joao)
 - Move patch "iommu: Pass in parent domain with user_data to domain_alloc_user op"
   right before "iommufd: Add a nested HW pagetable object" (Jason)

v6: https://lore.kernel.org/linux-iommu/20231024150609.46884-1-yi.l.liu@intel.com/
 - Rebase on top of Joao's dirty tracking series:
   https://lore.kernel.org/linux-iommu/20231024135109.73787-1-joao.m.martins@oracle.com/
 - Rebase on top of the enforce_cache_coherency removal patch:
   https://lore.kernel.org/linux-iommu/ZTcAhwYjjzqM0A5M@Asurada-Nvidia/
 - Add parent and user_data check in iommu driver before the driver actually
   supports the two input. This can make better bisect support, the change is
   in patch 02.

v5: https://lore.kernel.org/linux-iommu/20231020091946.12173-1-yi.l.liu@intel.com/
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

 drivers/iommu/amd/iommu.c                     |   9 +-
 drivers/iommu/intel/iommu.c                   |   7 +-
 drivers/iommu/iommufd/device.c                | 156 ++++++++---
 drivers/iommu/iommufd/hw_pagetable.c          | 265 +++++++++++++-----
 drivers/iommu/iommufd/iommufd_private.h       |  70 +++--
 drivers/iommu/iommufd/iommufd_test.h          |  18 ++
 drivers/iommu/iommufd/main.c                  |  10 +-
 drivers/iommu/iommufd/selftest.c              | 153 ++++++++--
 drivers/iommu/iommufd/vfio_compat.c           |   6 +-
 include/linux/iommu.h                         |  71 ++++-
 include/uapi/linux/iommufd.h                  |  31 +-
 tools/testing/selftests/iommu/iommufd.c       | 115 ++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |   3 +-
 tools/testing/selftests/iommu/iommufd_utils.h |  30 +-
 14 files changed, 758 insertions(+), 186 deletions(-)

-- 
2.34.1

