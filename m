Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D917D0C04
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 11:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376636AbjJTJhX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 05:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376629AbjJTJhW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 05:37:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDED2E8;
        Fri, 20 Oct 2023 02:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697794640; x=1729330640;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l34rTdAv20yfi641LNZ0X91unwwdKcr1d5qJ7V//mws=;
  b=ElkBRYJVqEsQ7NzM2eUWXVknxz0PvUHx4ZdWnO8pAw0RvaUDxsSQDr1t
   cWYJuxO4e0qqXOeJnGS1p9oBY9YaI2CfPWFiStXpXKwpbMZ/WuoyXK5PK
   Q/94u4ZTag5Smsxcq/zrvTZV4jI+42DKt737XC63HmdYKBXdPU58ndZP2
   IJBXzsyxe/AvxBUC+x8lG2x1OpvKHfF1eMZZGerYrUQeKt/+jVdu2iyho
   dwaw1WuXW3WtEc/c8LjETJxexCHvTWGrKptt4hP07bCVzGpNWfX7zvHbk
   OiP7umfk/gperpDHQLEFoBVsU+h9TGdB509ClKfcIkHi/QRz6yfQXdJpT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="385341706"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="385341706"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:37:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="707181301"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="707181301"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga003.jf.intel.com with ESMTP; 20 Oct 2023 02:37:19 -0700
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
Subject: [PATCH v6 0/3] Add Intel VT-d nested translation (part 2/2)
Date:   Fri, 20 Oct 2023 02:37:15 -0700
Message-Id: <20231020093719.18725-1-yi.l.liu@intel.com>
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

This is the second part to add Intel VT-d nested translation based on IOMMUFD
nesting infrastructure. As the iommufd nesting infrastructure series [1],
iommu core supports new ops to invalidate the cache after the modifictions
in stage-1 page table. So far, the cache invalidation data is vendor specific,
the data_type (IOMMU_HWPT_DATA_VTD_S1) defined for the vendor specific HWPT
allocation is reused in the cache invalidation path. User should provide the
correct data_type that suit with the type used in HWPT allocation.

IOMMU_HWPT_INVALIDATE iotcl returns an error in @out_driver_error_code. However
Intel VT-d does not define error code so far, so it's not easy to pre-define it
in iommufd neither. As a result, this field should just be ignored on VT-d platform.

Complete code can be found in [2], corresponding QEMU could can be found in [3].

[1] https://lore.kernel.org/linux-iommu/20231020092426.13907-1-yi.l.liu@intel.com/
[2] https://github.com/yiliu1765/iommufd/tree/iommufd_nesting
[3] https://github.com/yiliu1765/qemu/tree/zhenzhong/wip/iommufd_nesting_rfcv1

Change log:

v6:
 - Address comments from Kevin
 - Split the VT-d nesting series into two parts (Jason)

v5: https://lore.kernel.org/linux-iommu/20230921075431.125239-1-yi.l.liu@intel.com/
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

Yi Liu (3):
  iommufd: Add data structure for Intel VT-d stage-1 cache invalidation
  iommu/vt-d: Make iotlb flush helpers to be extern
  iommu/vt-d: Add iotlb flush for nested domain

 drivers/iommu/intel/iommu.c  | 10 +++----
 drivers/iommu/intel/iommu.h  |  6 ++++
 drivers/iommu/intel/nested.c | 54 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/iommufd.h | 36 ++++++++++++++++++++++++
 4 files changed, 101 insertions(+), 5 deletions(-)

-- 
2.34.1

