Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2D66FF4FE
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 May 2023 16:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbjEKOw2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 May 2023 10:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238623AbjEKOwN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 May 2023 10:52:13 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF7A210D;
        Thu, 11 May 2023 07:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683816673; x=1715352673;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gpgGwILXegaPLWgmpXrz68dTXAMClWSGpnD37BPQ7GM=;
  b=WAUU2buVxR8d8oh7JnnPPEjw6NMo5EGTjL+ztpSUKZfJf1FjG7n1rJjt
   hMyvhoRteAJ0H19PEaWjDpW4gnFqwnYHXrEsD8XbFjB0/DXq9j0/k3yqm
   3dRLb8O7rBFF9U3VxCuWtnpDIjUoBBXEhADtQ6CHQmi48S2U7v7ywDjvf
   MTx40MZqVHNuNabbQpfJv9JDYLnmQGkTfLh5KR+GkX98ak9clif6srhOL
   qF5QCYLwY2kQqcMlbqBPxVs5mi/b6AUi0CC5FddzEJ82OF3yib1ifMQYJ
   As81LoYJlEypZycJTfGXv/T2fPQE3fPw2c/QzG4QTWZfcXwtfi/s4Npk3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="335025414"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="335025414"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 07:51:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="769355144"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="769355144"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga004.fm.intel.com with ESMTP; 11 May 2023 07:51:12 -0700
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
Subject: [PATCH v3 00/10] Add Intel VT-d nested translation
Date:   Thu, 11 May 2023 07:51:00 -0700
Message-Id: <20230511145110.27707-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is to add Intel VT-d nested translation based on IOMMUFD nesting
infrastructure. As the iommufd nesting infrastructure series[1], iommu
core supports new ops to report iommu hardware information, allocate
domains with user data and sync stage-1 IOTLB. The data required in
the three paths are vendor-specific, so

1) IOMMU_HW_INFO_TYPE_INTEL_VTD and struct iommu_device_info_vtd are
   defined to report iommu hardware information for Intel VT-d .
2) IOMMU_HWPT_DATA_VTD_S1 is defined for the Intel VT-d stage-1 page
   table, it will be used in the stage-1 domain allocation and IOTLB
   syncing path. struct iommu_hwpt_intel_vtd is defined to pass user_data
   for the Intel VT-d stage-1 domain allocation.
   struct iommu_hwpt_invalidate_intel_vtd is defined to pass the data for
   the Intel VT-d stage-1 IOTLB invalidation.

With above IOMMUFD extensions, the intel iommu driver implements the three
paths to support nested translation.

The first Intel platform supporting nested translation is Sapphire
Rapids which, unfortunately, has a hardware errata [2] requiring special
treatment. This errata happens when a stage-1 page table page (either
level) is located in a stage-2 read-only region. In that case the IOMMU
hardware may ignore the stage-2 RO permission and still set the A/D bit
in stage-1 page table entries during page table walking.

A flag IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17 is introduced to report
this errata to userspace. With that restriction the user should either
disable nested translation to favor RO stage-2 mappings or ensure no
RO stage-2 mapping to enable nested translation.

Intel-iommu driver is armed with necessary checks to prevent such mix
in patch10 of this series.

Qemu currently does add RO mappings though. The vfio agent in Qemu
simply maps all valid regions in the GPA address space which certainly
includes RO regions e.g. vbios.

In reality we don't know a usage relying on DMA reads from the BIOS
region. Hence finding a way to allow user opt-out RO mappings in
Qemu might be an acceptable tradeoff. But how to achieve it cleanly
needs more discussion in Qemu community. For now we just hacked Qemu
to test.

Complete code can be found in [3], QEMU could can be found in [4].

base-commit: ce9b593b1f74ccd090edc5d2ad397da84baa9946

[1] https://lore.kernel.org/linux-iommu/20230511143844.22693-1-yi.l.liu@intel.com/
[2] https://www.intel.com/content/www/us/en/content-details/772415/content-details.html
[3] https://github.com/yiliu1765/iommufd/tree/iommufd_nesting
[4] https://github.com/yiliu1765/qemu/tree/wip/iommufd_rfcv4.mig.reset.v4_var3%2Bnesting

Change log:
v3:
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

Lu Baolu (5):
  iommu/vt-d: Extend dmar_domain to support nested domain
  iommu/vt-d: Add helper for nested domain allocation
  iommu/vt-d: Add helper to setup pasid nested translation
  iommu/vt-d: Add nested domain allocation
  iommu/vt-d: Disallow nesting on domains with read-only mappings

Yi Liu (5):
  iommufd: Add data structure for Intel VT-d stage-1 domain allocation
  iommu/vt-d: Make domain attach helpers to be extern
  iommu/vt-d: Set the nested domain to a device
  iommu/vt-d: Add iotlb flush for nested domain
  iommu/vt-d: Implement hw_info for iommu capability query

 drivers/iommu/intel/Makefile |   2 +-
 drivers/iommu/intel/iommu.c  |  78 ++++++++++++---
 drivers/iommu/intel/iommu.h  |  55 +++++++++--
 drivers/iommu/intel/nested.c | 181 +++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/pasid.c  | 151 +++++++++++++++++++++++++++++
 drivers/iommu/intel/pasid.h  |   2 +
 drivers/iommu/iommufd/main.c |   6 ++
 include/linux/iommu.h        |   1 +
 include/uapi/linux/iommufd.h | 149 ++++++++++++++++++++++++++++
 9 files changed, 603 insertions(+), 22 deletions(-)
 create mode 100644 drivers/iommu/intel/nested.c

-- 
2.34.1

