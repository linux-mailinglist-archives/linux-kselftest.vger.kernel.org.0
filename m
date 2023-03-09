Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917116B1D57
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Mar 2023 09:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjCIIJd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Mar 2023 03:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjCIIJc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Mar 2023 03:09:32 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1807470413;
        Thu,  9 Mar 2023 00:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678349371; x=1709885371;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/8raoNhMd+SESRUlTXuY9peWL59EaHh54ZI3hcXgobg=;
  b=YW11kP5H2qVhtYL3kRNgj29u0wqkvHfsjyTaRsTUuFCwK2AMNPqg4Q1Q
   +pw534w/U7NGGQhrIlsUEFYRK37h+IK8F91Atq3DMr7ZL/wYuYpaz1rEQ
   h3SSdv0yfOtk1JRs3YstnPEw+APwR0WU25m39YNv1NIA1Ns5hewn09POH
   P+xV7Nhbr9ZkY+Yv+8H8c09MByokpVH7DXwGhCD689vGY0GoRu5ZRRyRF
   b/gfF83calFz7mEQw/yGJD+eQSGcHqkWAc5FWpU4un0ovSZeIvbHU07F1
   ncTEzSySzCjDkDilcrcSdBwpmaBZV5mwsxVSjPU41toa2qSHFiTMFOkWQ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="364023004"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="364023004"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:09:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="787471341"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="787471341"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 09 Mar 2023 00:09:18 -0800
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
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 00/12] iommufd: Add nesting infrastructure
Date:   Thu,  9 Mar 2023 00:08:58 -0800
Message-Id: <20230309080910.607396-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
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
for user-managed hwpts. ioctl IOMMU_DEVICE_GET_HW_INFO is extended to report
the supported hwpt types bitmap to user. Selftest is added as well to cover
the new ioctls.

Complete code can be found in [2], QEMU could can be found in [3].

At last, this is a team work together with Nicolin Chen, Lu Baolu. Thanks
them for the help. ^_^. Look forward to your feedbacks.

base-commit: 3dfe670c94c7fc4af42e5c08cdd8a110b594e18e

[1] https://lore.kernel.org/linux-iommu/20230309075358.571567-1-yi.l.liu@intel.com/
[2] https://github.com/yiliu1765/iommufd/tree/iommufd_nesting
[3] https://github.com/yiliu1765/qemu/tree/wip/iommufd_rfcv3%2Bnesting

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

Yi Liu (5):
  iommufd/hw_pagetable: Use domain_alloc_user op for domain allocation
  iommufd: Pass parent hwpt and user_data to
    iommufd_hw_pagetable_alloc()
  iommufd: IOMMU_HWPT_ALLOC allocation with user data
  iommufd: Add IOMMU_HWPT_INVALIDATE
  iommufd/device: Report supported hwpt_types

 drivers/iommu/iommufd/device.c                |   9 +-
 drivers/iommu/iommufd/hw_pagetable.c          | 242 +++++++++++++++++-
 drivers/iommu/iommufd/iommufd_private.h       |  16 +-
 drivers/iommu/iommufd/iommufd_test.h          |  30 +++
 drivers/iommu/iommufd/main.c                  |   7 +-
 drivers/iommu/iommufd/selftest.c              | 104 +++++++-
 include/linux/iommu.h                         |  11 +
 include/uapi/linux/iommufd.h                  |  65 +++++
 tools/testing/selftests/iommu/iommufd.c       | 126 ++++++++-
 tools/testing/selftests/iommu/iommufd_utils.h |  71 +++++
 10 files changed, 654 insertions(+), 27 deletions(-)

-- 
2.34.1

