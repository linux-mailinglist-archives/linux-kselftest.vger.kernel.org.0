Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE9D77E13E
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 14:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244997AbjHPMPG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 08:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244998AbjHPMOd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 08:14:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03EE26BB;
        Wed, 16 Aug 2023 05:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692188056; x=1723724056;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6lZ8JOEKOYC3b0U/4VDDKZlYi9r5dshaRIs3eUATwiA=;
  b=FZILb+qG14f38xshEJeLCzQwFyJIS9beRJgz7SpcV67XwLY08MSoGu8c
   HkOYaW+tTR4Q8rnAFHwp5WFN3F6aU5piW5zVkMDYsnUumcxTVzShTzm1m
   yjyQaBXGR/gSXosnr/td054IttAZL6Emqj8/GDTNZZRQOTdXCbjgwHfL3
   7blKt06kDPvY5tMHPsCoU3nNWICBRRRmimc0OzrfI4afvqeOrX3B/EPOf
   pB6bWFUJiMd4hMAIwE3hca0+8KgmaFmgN8NH/3PxOm5up5IyFkIiSbq6F
   3WutCpoCKKsjuzwlVWNvFT0RA7qxFGi1C5eDA5ZjhXl+2bEAely564s+1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="436411601"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="436411601"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 05:14:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="727730748"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="727730748"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga007.jf.intel.com with ESMTP; 16 Aug 2023 05:14:05 -0700
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
Subject: [PATCH v8 0/5] iommufd: Add iommu hardware info reporting
Date:   Wed, 16 Aug 2023 05:13:44 -0700
Message-Id: <20230816121349.104436-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

iommufd gives userspace the capability to manipulate iommu subsytem.
e.g. DMA map/unmap etc. In the near future, it will support iommu nested
translation. Different platform vendors have different implementations for
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
info reported to user hence user can decode them. This series adds the
framework for iommu hw info reporting, and adds the vtd implementation. The
complete code is available in [1].

[1] https://github.com/yiliu1765/iommufd/tree/iommufd_hw_info-v8

Change log:

v8:
 - Updated the uAPI by allowing a 0 value at the input @data_len
 - Changed to always report the kernel supported data length instead of the
   length that kernel filled in the user space buffer
 - Updated uAPI doc accordingly
 - Add one more selftest for 0 value @data_len and also check the output @data_len
   with the size kernel supports
 - Fix the usage of clear_user()
 - Rebase on top of Jason's for-next branch (base: 65aaca1 iommufd: Remove iommufd_ref_to_users())
 - Include the vtd hw_info implementation from vtd nesting series
   https://lore.kernel.org/r/20230724111335.107427-12-yi.l.liu@intel.com

v7: https://lore.kernel.org/linux-iommu/20230811071501.4126-1-yi.l.liu@intel.com/
 - Use clear_user() (Jason)
 - Add fail_nth for hw_ifo (Jason)

v6: https://lore.kernel.org/linux-iommu/20230808153510.4170-1-yi.l.liu@intel.com/
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

Yi Liu (3):
  iommu: Move dev_iommu_ops() to private header
  iommufd: Add IOMMU_GET_HW_INFO
  iommu/vt-d: Implement hw_info for iommu capability query

 drivers/iommu/intel/iommu.c                   | 19 +++++
 drivers/iommu/iommu-priv.h                    | 11 +++
 drivers/iommu/iommufd/device.c                | 73 ++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h       |  1 +
 drivers/iommu/iommufd/iommufd_test.h          |  9 +++
 drivers/iommu/iommufd/main.c                  |  3 +
 drivers/iommu/iommufd/selftest.c              | 16 ++++
 include/linux/iommu.h                         | 20 +++--
 include/uapi/linux/iommufd.h                  | 74 +++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 30 +++++++-
 .../selftests/iommu/iommufd_fail_nth.c        |  4 +
 tools/testing/selftests/iommu/iommufd_utils.h | 56 ++++++++++++++
 12 files changed, 304 insertions(+), 12 deletions(-)

-- 
2.34.1

