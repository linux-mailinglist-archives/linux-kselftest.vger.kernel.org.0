Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920637A9BEA
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Sep 2023 21:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjIUTFP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Sep 2023 15:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjIUTEa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Sep 2023 15:04:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899C510187;
        Thu, 21 Sep 2023 10:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318582; x=1726854582;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H+jaTZB/vzjOivp0Kos2FJEautJ0EWBq4jUgudwxXBQ=;
  b=DVv4/8Ui1y9til1EKXZrxka6/40y8BjkirNc7pFR3FQuculceI98bPXF
   5F4GmpYgQdPvOdFuGinhAF2TH7HJsD60saB/A3OmF4yIzMskqR2Dg5Yeo
   vGkGo0WPydL/WiXsAOQv6GFjWok057pDrWcpMILRYlnzGrpuiBQoE+tpx
   Zi2zkUsnRJRnq2XF7m+WSFNvc6MCxvJvb8A4lW0+qmT7H5ms9pv/ypTH+
   8eKBf/3DjauLOvDiotw99WFYlHi+quh5BdHCN96a0tA65bTgBdSUnvUDZ
   ZBtc9Hw2JXxdUgszwxfsPM3+FWXEO6v+bVz5AL5U64JvejN/wRP9gDdL/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="359832793"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="359832793"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 00:52:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723649481"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="723649481"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 21 Sep 2023 00:52:06 -0700
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
Subject: [PATCH v4 00/17] iommufd: Add nesting infrastructure
Date:   Thu, 21 Sep 2023 00:51:21 -0700
Message-Id: <20230921075138.124099-1-yi.l.liu@intel.com>
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
extends domain_alloc_user to allocate domains with user data and adds new
op for invalidate stage-1 IOTLB for user-managed domains, then extends the
IOMMUFD internal infrastructure to accept user_data and parent hwpt, relay
the user_data/parent to iommu core to allocate user-managed iommu_domain.
After it, extends the ioctl IOMMU_HWPT_ALLOC to accept user data and stage-2
hwpt ID. Along with it, ioctl IOMMU_HWPT_INVALIDATE is added to invalidate
stage-1 IOTLB. This is needed for user-managed hwpts. Selftest is added as
well to cover the new ioctls.

Complete code can be found in [2], QEMU could can be found in [3].

At last, this is a team work together with Nicolin Chen, Lu Baolu. Thanks
them for the help. ^_^. Look forward to your feedbacks.

[1] https://lore.kernel.org/linux-iommu/20230818101033.4100-1-yi.l.liu@intel.com/#r - merged
[2] https://github.com/yiliu1765/iommufd/tree/iommufd_nesting
[3] https://github.com/yiliu1765/qemu/tree/zhenzhong/wip/iommufd_nesting_rfcv1

Change log:

v4:
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

Lu Baolu (1):
  iommu: Add nested domain support

Nicolin Chen (12):
  iommufd: Unite all kernel-managed members into a struct
  iommufd: Separate kernel-managed HWPT alloc/destroy/abort functions
  iommufd: Add shared alloc_fn function pointer and mutex pointer
  iommufd: Add user-managed hw_pagetable support
  iommufd: Always setup MSI and anforce cc on kernel-managed domains
  iommufd/device: Add helpers to enforce/remove device reserved regions
  iommufd/selftest: Rework TEST_LENGTH to test min_size explicitly
  iommufd/selftest: Add nested domain allocation for mock domain
  iommufd/selftest: Add coverage for IOMMU_HWPT_ALLOC with nested HWPTs
  iommufd/selftest: Add mock_domain_cache_invalidate_user support
  iommufd/selftest: Add IOMMU_TEST_OP_MD_CHECK_IOTLB test op
  iommufd/selftest: Add coverage for IOMMU_HWPT_INVALIDATE ioctl

Yi Liu (4):
  iommu: Add hwpt_type with user_data for domain_alloc_user op
  iommufd: Pass in hwpt_type/user_data to iommufd_hw_pagetable_alloc()
  iommufd: Support IOMMU_HWPT_ALLOC allocation with user data
  iommufd: Add IOMMU_HWPT_INVALIDATE

 drivers/iommu/intel/iommu.c                   |   5 +-
 drivers/iommu/iommufd/device.c                |  51 +++-
 drivers/iommu/iommufd/hw_pagetable.c          | 257 ++++++++++++++++--
 drivers/iommu/iommufd/iommufd_private.h       |  59 +++-
 drivers/iommu/iommufd/iommufd_test.h          |  40 +++
 drivers/iommu/iommufd/main.c                  |   3 +
 drivers/iommu/iommufd/selftest.c              | 184 ++++++++++++-
 include/linux/iommu.h                         | 110 +++++++-
 include/uapi/linux/iommufd.h                  |  60 +++-
 tools/testing/selftests/iommu/iommufd.c       | 209 +++++++++++++-
 .../selftests/iommu/iommufd_fail_nth.c        |   3 +-
 tools/testing/selftests/iommu/iommufd_utils.h |  91 ++++++-
 12 files changed, 998 insertions(+), 74 deletions(-)

-- 
2.34.1

