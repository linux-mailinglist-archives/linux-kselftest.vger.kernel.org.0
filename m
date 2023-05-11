Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DE76FF4BD
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 May 2023 16:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238637AbjEKOm4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 May 2023 10:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238273AbjEKOma (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 May 2023 10:42:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFB6273E;
        Thu, 11 May 2023 07:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683815927; x=1715351927;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hB7sN8KBNaFlRFygVg+2VFuPkNFm9CNTHJkLgvR0w9I=;
  b=mZmhOWUntaIpdUJddCsiTB/Zx720Yu4OLlzJ1EuLZ5iHHFxIZ2I8JILq
   Apn5EbiIAEByPWS8svXgrM/W/6RjNOkhDsxbUXzDfp5deSYkF7AaQR5ut
   iL63upuZyepefwMK4YJzMFsoD3wt4HofC6a3erYMCBseZWo2aehF4XUxu
   AWJRyABcaNzPjHg06URbyXuO9Tz6zSTYcFLdytjAvlXU+JghDjpK3ZBwN
   OiopBPXtrWSX6rnoHrphyUTAVkh6pO6AV+vAjLMJ3luVcHO+c/kfJw/jL
   XNH8mBWN8F764BYTM6aO0R09OkVduPXQ0o/JOhK7k/MNYn8j91wyAHdVS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="339812829"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="339812829"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 07:38:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="730382587"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="730382587"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga008.jf.intel.com with ESMTP; 11 May 2023 07:38:45 -0700
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
Subject: [PATCH v2 00/11] iommufd: Add nesting infrastructure
Date:   Thu, 11 May 2023 07:38:33 -0700
Message-Id: <20230511143844.22693-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
------| Shadow |--------------------------|--------
      v        v                          v
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
for syncing stage-1 IOTLB, and then extend the IOMMUFD internal infrastructure
to accept user_data and parent hwpt, then relay the data to iommu core to
allocate iommu_domain. After it, extend the ioctl IOMMU_HWPT_ALLOC to accept
user data and stage-2 hwpt ID to allocate hwpt. Along with it, ioctl
IOMMU_HWPT_INVALIDATE is added to invalidate stage-1 IOTLB. This is needed
for user-managed hwpts. Selftest is added as well to cover the new ioctls.

Complete code can be found in [2], QEMU could can be found in [3].

At last, this is a team work together with Nicolin Chen, Lu Baolu. Thanks
them for the help. ^_^. Look forward to your feedbacks.

base-commit: cf905391237ded2331388e75adb5afbabeddc852

[1] https://lore.kernel.org/linux-iommu/20230511143024.19542-1-yi.l.liu@intel.com/
[2] https://github.com/yiliu1765/iommufd/tree/iommufd_nesting
[3] https://github.com/yiliu1765/qemu/tree/wip/iommufd_rfcv4.mig.reset.v4_var3%2Bnesting

Change log:

v2:
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

Nicolin Chen (5):
  iommufd/hw_pagetable: Do not populate user-managed hw_pagetables
  iommufd/selftest: Add domain_alloc_user() support in iommu mock
  iommufd/selftest: Add coverage for IOMMU_HWPT_ALLOC with user data
  iommufd/selftest: Add IOMMU_TEST_OP_MD_CHECK_IOTLB test op
  iommufd/selftest: Add coverage for IOMMU_HWPT_INVALIDATE ioctl

Yi Liu (4):
  iommufd/hw_pagetable: Use domain_alloc_user op for domain allocation
  iommufd: Pass parent hwpt and user_data to
    iommufd_hw_pagetable_alloc()
  iommufd: IOMMU_HWPT_ALLOC allocation with user data
  iommufd: Add IOMMU_HWPT_INVALIDATE

 drivers/iommu/iommufd/device.c                |   2 +-
 drivers/iommu/iommufd/hw_pagetable.c          | 191 +++++++++++++++++-
 drivers/iommu/iommufd/iommufd_private.h       |  16 +-
 drivers/iommu/iommufd/iommufd_test.h          |  30 +++
 drivers/iommu/iommufd/main.c                  |   5 +-
 drivers/iommu/iommufd/selftest.c              | 119 ++++++++++-
 include/linux/iommu.h                         |  36 ++++
 include/uapi/linux/iommufd.h                  |  58 +++++-
 tools/testing/selftests/iommu/iommufd.c       | 126 +++++++++++-
 tools/testing/selftests/iommu/iommufd_utils.h |  70 +++++++
 10 files changed, 629 insertions(+), 24 deletions(-)

-- 
2.34.1

