Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0849675F408
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 12:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbjGXK7p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 06:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjGXK7n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 06:59:43 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0E1120;
        Mon, 24 Jul 2023 03:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690196379; x=1721732379;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xO88BGppNsOOGrLE9oWJosFPDbrRTt2P1G2mxcE66FY=;
  b=P7g+vBSv6NRDAnnZFvVcGhAq+sEMmlGxLovTKI1/25BB+dt6pqQt8WK/
   Lcl7OZzAotvm1Keu9jsLxEQiZGE+smtsQzXx0SSBOzwHthNcD+smOx/4m
   PdYD66jBxSXzvw/e0GIxUL2gkHtGnjGXlcOeNHkCJcyfT7SyPgTYTsKie
   FZ9nrellnFngAzQy3l6+kJ4bqmXLIj8AhmlJ9C82VojrzKy2+XGDXtQzr
   jDTyVXny1F9d8u/6lUCQszdRUZL0IsQPBqP8yJPRcjZRuPDYFeOoqMKCy
   vI575aYA3TF21iEjc+ZV0FoWMsk8i4omHEIyEZDlJW/vw3ZMj8RroUJJn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="347012203"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347012203"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 03:59:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="839409009"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="839409009"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jul 2023 03:59:37 -0700
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
Subject: [PATCH v4 0/4] iommufd: Add iommu hardware info reporting
Date:   Mon, 24 Jul 2023 03:59:32 -0700
Message-Id: <20230724105936.107042-1-yi.l.liu@intel.com>
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

[1] https://github.com/yiliu1765/iommufd/tree/iommufd_nesting

Change log:

v4:
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
 drivers/iommu/iommufd/device.c                |  1 +
 drivers/iommu/iommufd/iommufd_test.h          |  9 +++
 drivers/iommu/iommufd/main.c                  | 76 +++++++++++++++++++
 drivers/iommu/iommufd/selftest.c              | 16 ++++
 include/linux/iommu.h                         | 27 ++++---
 include/uapi/linux/iommufd.h                  | 44 +++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 17 ++++-
 tools/testing/selftests/iommu/iommufd_utils.h | 26 +++++++
 9 files changed, 215 insertions(+), 12 deletions(-)

-- 
2.34.1

