Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714E66B1DE8
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Mar 2023 09:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjCIIYi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Mar 2023 03:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjCIIYA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Mar 2023 03:24:00 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3C9B8F2B;
        Thu,  9 Mar 2023 00:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678350166; x=1709886166;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1BqCuzwrx1sAGErM7heQwG3PZAKj4z7gGmdrSQhTQJU=;
  b=I9XuFC+/EnuxLXGm6ajJnqm43zcrlXdCM54lMJnDq28fuAjGANyQxqoQ
   q5KmVL69AJn3MAHKpnISU29+sHEP3cPV2ryz7aK6qeRtNK19JCCGBG/sd
   vfL58oXZLi7uYM06OLFTLvxX8bt5bAJ9xp5srhf/P0J2HGvums9V55kOy
   HBAVjYaxQ0+2GOy4rHEbEcqUFwy31eAyynrtKuprnoQc+ABSbQxhBI1IP
   hYXAjZebOhjlhME0etU7F3irU+ABXzwV77wnJLzkhwO/vf+Jy7XjFRFfi
   1ADKEzyxRRmcTSl+DVNj42XlYIVwpsCyeeu/44LOhJAgT2wfKuiXosRNi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="364026161"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="364026161"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:22:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="787474147"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="787474147"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 09 Mar 2023 00:22:10 -0800
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
Subject: [PATCH v2 0/5] Add Intel VT-d nested translation
Date:   Thu,  9 Mar 2023 00:22:02 -0800
Message-Id: <20230309082207.612346-1-yi.l.liu@intel.com>
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
callbacks to support nested translation.

Complete code can be found in [2], QEMU could can be found in [3].

base-commit: f01f1c95684dd18c15dd0e51b4fd6e796a0a2c0e

[1] https://lore.kernel.org/linux-iommu/20230309080910.607396-1-yi.l.liu@intel.com/
[2] https://github.com/yiliu1765/iommufd/tree/iommufd_nesting
[3] https://github.com/yiliu1765/qemu/tree/wip/iommufd_rfcv3%2Bnesting

Change log:
v2:
 - The iommufd infrastructure is split to be separate series.

v1: https://lore.kernel.org/linux-iommu/20230209043153.14964-1-yi.l.liu@intel.com/

Regards,
        Yi Liu

Lu Baolu (4):
  iommu/vt-d: Implement hw_info for iommu capability query
  iommu/vt-d: Extend dmar_domain to support nested domain
  iommu/vt-d: Add helper to setup pasid nested translation
  iommu/vt-d: Add nested domain support

Yi Liu (1):
  iommufd: Add nesting related data structures for Intel VT-d

 drivers/iommu/intel/Makefile         |   2 +-
 drivers/iommu/intel/iommu.c          |  57 ++++++++---
 drivers/iommu/intel/iommu.h          |  51 ++++++++--
 drivers/iommu/intel/nested.c         | 143 +++++++++++++++++++++++++++
 drivers/iommu/intel/pasid.c          | 142 ++++++++++++++++++++++++++
 drivers/iommu/intel/pasid.h          |   2 +
 drivers/iommu/iommufd/hw_pagetable.c |   7 +-
 drivers/iommu/iommufd/main.c         |   5 +
 include/uapi/linux/iommufd.h         | 136 +++++++++++++++++++++++++
 9 files changed, 522 insertions(+), 23 deletions(-)
 create mode 100644 drivers/iommu/intel/nested.c

-- 
2.34.1

