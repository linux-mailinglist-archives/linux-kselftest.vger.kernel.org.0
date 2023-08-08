Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B430774065
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 19:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjHHRCh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 13:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbjHHRBl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 13:01:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AD78692;
        Tue,  8 Aug 2023 09:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691510469; x=1723046469;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C/p/UlsErt6IGhM1ajayheMt/yvaha/yxJzT6j1NczA=;
  b=OO/nDBtgbNMLjyfBOpg+rfi9160OrKvaIQ8bnnWAoxkSWWr/IMgFBP0J
   owwn03zFZGtaopSBA+LNGbr6XJinSavz+lXZJWFHYQ1FyN4+Ea/SKlRPB
   RVyKjX9AHcFab2PTy6R/RYyIpQwP+6a67OSY48/5UFn0QxwVChlbIRb5l
   khobzH2eL7dlPGcWKpjd/EQUYhZYzhDGnWJKqDdXY1Bo2Je5lobKeSJAQ
   HwjPjBxgUe0Aaf7P9na1Ft0amS3Wc/6ccNwOxmOQdFXDc2FtLcudOiP/R
   Bt/y2wPPgVRzTQlv0PByStxggYJTBOkwbTV4psT6DZh2potqM7Dfd4zI2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="350449280"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="350449280"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 08:35:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="855126966"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="855126966"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga004.jf.intel.com with ESMTP; 08 Aug 2023 08:35:11 -0700
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
Subject: [PATCH v6 0/4] iommufd: Add iommu hardware info reporting
Date:   Tue,  8 Aug 2023 08:35:06 -0700
Message-Id: <20230808153510.4170-1-yi.l.liu@intel.com>
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

iommufd gives userspace the capability to manipulate iommu subsytem.
e.g. DMA map/unmap etc. In the near future, it will support iommu nested
translation. Different platform vendors have different implementation for
the nested translation. For example, Intel VT-d supports using guest I/O
page table as the stage-1 translation table. This requires guest I/O page
table be compatible with hardware IOMMU. So before set up nested translation,
userspace needs to know the hardware iommu information to understand the
nested translation requirements.

This series reports the iommu hardware information for a given device
which has been bound to iommufd. It is preparation work for userspace to
allocate hwpt for given device. Like the nested translation support[1].

This series introduces an iommu op to report the iommu hardware info,
and an ioctl IOMMU_GET_HW_INFO is added to report such hardware info to
user. enum iommu_hw_info_type is defined to differentiate the iommu hardware
info reported to user hence user can decode them. This series only adds the
framework for iommu hw info reporting, the complete reporting path needs vendor
specific definition and driver support. The full code is available in [1]
as well.

[1] https://github.com/yiliu1765/iommufd/tree/wip/iommufd_nesting_08082023-yi
(only the hw_info report path is the latest, other parts is wip)

Change log:

v6:
 - Add Jingqi's comment on patch 02
 - Add Baolu's r-b to patch 03
 - Address Jason's comment on patch 03

v5: https://lore.kernel.org/linux-iommu/20230803143144.200945-1-yi.l.liu@intel.com/
 - Return hw_info_type in the .hw_info op, hence drop hw_info_type field in iommu_ops (Kevin)
 - Add Jason's r-b for patch 01
 - Address coding style comments from Jason and Kevin w.r.t. patch 02, 03 and 04

v4: https://lore.kernel.org/linux-iommu/20230724105936.107042-1-yi.l.liu@intel.com/
 - Rename ioctl to IOMMU_GET_HW_INFO and structure to iommu_hw_info
 - Move the iommufd_get_hw_info handler to main.c
 - Place iommu_hw_info prior to iommu_hwpt_alloc
 - Update the function namings accordingly
 - Update uapi kdocs

v3: https://lore.kernel.org/linux-iommu/20230511143024.19542-1-yi.l.liu@intel.com/#t
 - Add r-b from Baolu
 - Rename IOMMU_HW_INFO_TYPE_DEFAULT to be IOMMU_HW_INFO_TYPE_NONE to
   better suit what it means
 - Let IOMMU_DEVICE_GET_HW_INFO succeed even the underlying iommu driver
   does not have driver-specific data to report per below remark.
   https://lore.kernel.org/kvm/ZAcwJSK%2F9UVI9LXu@nvidia.com/

v2: https://lore.kernel.org/linux-iommu/20230309075358.571567-1-yi.l.liu@intel.com/
 - Drop patch 05 of v1 as it is already covered by other series
 - Rename the capability info to be iommu hardware info

v1: https://lore.kernel.org/linux-iommu/20230209041642.9346-1-yi.l.liu@intel.com/

Regards,
	Yi Liu

Lu Baolu (1):
  iommu: Add new iommu op to get iommu hardware information

Nicolin Chen (1):
  iommufd/selftest: Add coverage for IOMMU_GET_HW_INFO ioctl

Yi Liu (2):
  iommu: Move dev_iommu_ops() to private header
  iommufd: Add IOMMU_GET_HW_INFO

 drivers/iommu/iommu-priv.h                    | 11 +++
 drivers/iommu/iommufd/iommufd_test.h          |  9 ++
 drivers/iommu/iommufd/main.c                  | 97 +++++++++++++++++++
 drivers/iommu/iommufd/selftest.c              | 16 +++
 include/linux/iommu.h                         | 20 ++--
 include/uapi/linux/iommufd.h                  | 45 +++++++++
 tools/testing/selftests/iommu/iommufd.c       | 17 +++-
 tools/testing/selftests/iommu/iommufd_utils.h | 26 +++++
 8 files changed, 229 insertions(+), 12 deletions(-)

-- 
2.34.1

