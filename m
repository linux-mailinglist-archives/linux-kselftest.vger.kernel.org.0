Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97B67A9D1B
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Sep 2023 21:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjIUT2k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Sep 2023 15:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjIUT2Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Sep 2023 15:28:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4990576B6;
        Thu, 21 Sep 2023 10:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695316220; x=1726852220;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X9BBfgk8l9qrBPqgGMYev0KIhH/OZFgWEJbj0DqM7ps=;
  b=aQOyF2nRK+tn5jfi9VgKf5gncIlneS1E5shoEImI3P8xl+Ox9gECyWTm
   5RfYqOD/gbxVRzS8hXF7RY9DArGFgs9HKqbMMcaauWJN6uiPHmWCo3tqZ
   wQzKOZwCU28scH2FDR+QVpGwNmDX2KMBT5D6rBv2DRtsLx0YWzCZt6xoC
   r2mOGlge/GNDLCS9vcONkJjVxlvXP8T59OaTpJSZg1BA1PWwrgeFzq2QK
   2qTaGRmCXcCM/xdnPm/ko4JB/8wo5LGC9Xp4e0bTDB8HOxImIDc/SN7GI
   nUNqVhYXtAwos0/9Eh0jkuh3FOFEDFvFysZk3spEYt23FG/eZUt+bm42r
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="370764359"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="370764359"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 00:54:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="812522971"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="812522971"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga008.fm.intel.com with ESMTP; 21 Sep 2023 00:54:42 -0700
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
Subject: [PATCH v5 00/11] Add Intel VT-d nested translation
Date:   Thu, 21 Sep 2023 00:54:20 -0700
Message-Id: <20230921075431.125239-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is to add Intel VT-d nested translation based on IOMMUFD nesting
infrastructure. As the iommufd nesting infrastructure series[1], iommu
core supports new ops to report iommu hardware information, allocate
domains with user data and invalidate stage-1 IOTLB when there is mapping
changed in stage-1 page table. The data required in the three paths are
vendor-specific, so

1) IOMMU_HWPT_TYPE_VTD_S1 is defined for the Intel VT-d stage-1 page
   table, it will be used in the stage-1 domain allocation and IOTLB
   syncing path. struct iommu_hwpt_vtd_s1 is defined to pass user_data
   for the Intel VT-d stage-1 domain allocation.
   struct iommu_hwpt_vtd_s1_invalidate is defined to pass the data for
   the Intel VT-d stage-1 IOTLB invalidation.
2) IOMMU_HW_INFO_TYPE_INTEL_VTD and struct iommu_hw_info_vtd are defined
   to report iommu hardware information for Intel VT-d.

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
in patch12 of this series.

Qemu currently does add RO mappings though. The vfio agent in Qemu
simply maps all valid regions in the GPA address space which certainly
includes RO regions e.g. vbios.

In reality we don't know a usage relying on DMA reads from the BIOS
region. Hence finding a way to skip RO regions (e.g. via a discard manager)
in Qemu might be an acceptable tradeoff. The actual change needs more
discussion in Qemu community. For now we just hacked Qemu to test.

Complete code can be found in [3], corresponding QEMU could can be found
in [4].

[1] https://lore.kernel.org/linux-iommu/20230921075138.124099-1-yi.l.liu@intel.com/
[2] https://www.intel.com/content/www/us/en/content-details/772415/content-details.html
[3] https://github.com/yiliu1765/iommufd/tree/iommufd_nesting
[4] https://github.com/yiliu1765/qemu/tree/zhenzhong/wip/iommufd_nesting_rfcv1

Change log:

v5:
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

Lu Baolu (5):
  iommu/vt-d: Extend dmar_domain to support nested domain
  iommu/vt-d: Add helper for nested domain allocation
  iommu/vt-d: Add helper to setup pasid nested translation
  iommu/vt-d: Add nested domain allocation
  iommu/vt-d: Disallow read-only mappings to nest parent domain

Yi Liu (6):
  iommufd: Add data structure for Intel VT-d stage-1 domain allocation
  iommu/vt-d: Make domain attach helpers to be extern
  iommu/vt-d: Set the nested domain to a device
  iommufd: Add data structure for Intel VT-d stage-1 cache invalidation
  iommu/vt-d: Make iotlb flush helpers to be extern
  iommu/vt-d: Add iotlb flush for nested domain

 drivers/iommu/intel/Makefile |   2 +-
 drivers/iommu/intel/iommu.c  |  60 +++++++++----
 drivers/iommu/intel/iommu.h  |  51 +++++++++--
 drivers/iommu/intel/nested.c | 162 +++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/pasid.c  | 125 +++++++++++++++++++++++++++
 drivers/iommu/intel/pasid.h  |   2 +
 include/uapi/linux/iommufd.h |  76 +++++++++++++++-
 7 files changed, 452 insertions(+), 26 deletions(-)
 create mode 100644 drivers/iommu/intel/nested.c

-- 
2.34.1

