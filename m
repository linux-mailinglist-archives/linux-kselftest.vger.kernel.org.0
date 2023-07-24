Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D0075F496
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 13:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjGXLNl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 07:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjGXLNi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 07:13:38 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BE6FF;
        Mon, 24 Jul 2023 04:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690197217; x=1721733217;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PJwhRrtzdB7QY89qYvl3D0Ft9KyAHnv2S9x6PDQsCjA=;
  b=VoldE2YgGUfM4lMp/DUqmmxF6DKVAcv9O/lwO6LkmEO89EKKZgVAZreZ
   HDIwNHyQOjEeS533UJ+rZtFXEBCOCbxgfXQ3BGgr516qotyqxNlW9byfp
   l1UuTnWSFcC1S8DeadWWcGDXlkuH3nZf/Icj1qbERKQWbcfr1and5eGdF
   jS6zeAgAz1RMtIAQH67nrA2q6YMr8Q9GR8RcI6NO7A+Gw26vE2fN5Noof
   u2VhI+Lgy0PKdiL9tFC3YbNnoIGndGiSRFuVdvCiowlXgDh5eedO21I+H
   7Qn5y90cmIEtg1SW79OqPqw2eQ+xWMEHkYc7xREJR4ZGjR6A5zTkDUApT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="347014909"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347014909"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:13:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="839415470"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="839415470"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jul 2023 04:13:36 -0700
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
Subject: [PATCH v4 00/12] Add Intel VT-d nested translation
Date:   Mon, 24 Jul 2023 04:13:22 -0700
Message-Id: <20230724111335.107427-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

[1] https://lore.kernel.org/linux-iommu/20230724110406.107212-1-yi.l.liu@intel.com/
[2] https://www.intel.com/content/www/us/en/content-details/772415/content-details.html
[3] https://github.com/yiliu1765/iommufd/tree/iommufd_nesting
[4] https://github.com/yiliu1765/qemu/tree/wip/iommufd_rfcv4_nesting

Change log:
v4:
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
  iommu/vt-d: Disallow nesting on domains with read-only mappings

Yi Liu (7):
  iommufd: Add data structure for Intel VT-d stage-1 domain allocation
  iommu/vt-d: Make domain attach helpers to be extern
  iommu/vt-d: Set the nested domain to a device
  iommufd: Add data structure for Intel VT-d stage-1 cache invalidation
  iommu/vt-d: Make iotlb flush helpers to be extern
  iommu/vt-d: Add iotlb flush for nested domain
  iommu/vt-d: Implement hw_info for iommu capability query

 drivers/iommu/intel/Makefile |   2 +-
 drivers/iommu/intel/iommu.c  |  80 +++++++++++++---
 drivers/iommu/intel/iommu.h  |  55 +++++++++--
 drivers/iommu/intel/nested.c | 174 +++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/pasid.c  | 127 +++++++++++++++++++++++++
 drivers/iommu/intel/pasid.h  |   2 +
 drivers/iommu/iommufd/main.c |   6 ++
 include/linux/iommu.h        |   1 +
 include/uapi/linux/iommufd.h | 124 +++++++++++++++++++++++++
 9 files changed, 549 insertions(+), 22 deletions(-)
 create mode 100644 drivers/iommu/intel/nested.c

-- 
2.34.1

