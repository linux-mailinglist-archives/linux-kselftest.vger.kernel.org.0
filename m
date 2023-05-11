Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2D96FF45D
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 May 2023 16:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238356AbjEKObr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 May 2023 10:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238455AbjEKObR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 May 2023 10:31:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED5D11DA5;
        Thu, 11 May 2023 07:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683815435; x=1715351435;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E0KtwujeglEeF/ZWyb3T3PBoQXAEhfP+ii+zv5qpFkU=;
  b=OTtnqph9skXYxgvp6dA/H1U3TKi+KX4YwLNU5mc5Vn8i/4LgU6aFKv5V
   IBSDQNhUdAetA6bV9Kxu6xeAQOtIP2pQZdanxcJCuFP4/mzzKw2DqAg7c
   Xnoml4SBge8wxueKfgWPdvXY5sOf0SJfJXjPLSyp8rYk+LQNuPFY/EUa/
   kiFqDVvhCBJ/3Cb2SKE5m3H/tjOq/ETYSIH63gWq/oJ7lKIDf7PW67piq
   yeM6Xp0eYPcLkL28dxY4NLMBwybPSkDCldJ1a00szRKb0yojsgyjpdf85
   iAoZ6PCJ08Xe9Pv+/QYZbQpIhCritPEBpzYjBNfh4OTIRlqxYwosqkL8O
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="378639852"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="378639852"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 07:30:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="874004405"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="874004405"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga005.jf.intel.com with ESMTP; 11 May 2023 07:30:25 -0700
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
Subject: [PATCH v3 0/4] iommufd: Add iommu hardware info reporting
Date:   Thu, 11 May 2023 07:30:20 -0700
Message-Id: <20230511143024.19542-1-yi.l.liu@intel.com>
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

iommufd gives userspace the capability to manipulate iommu subsytem.
e.g. DMA map/unmap etc. In the near future, it will support iommu nested
translation. Different platform vendors have different implementation for
the nested translation. So before set up nested translation, userspace
needs to know the hardware iommu information. For example, Intel VT-d
supports using guest I/O page table as the stage-1 translation table. This
requires guest I/O page table be compatible with hardware IOMMU.

This series reports the iommu hardware information for a given iommufd_device
which has been bound to iommufd. It is preparation work for userspace to
allocate hwpt for given device. Like the nested translation support[1].

This series introduces an iommu op to report the iommu hardware info,
and an ioctl IOMMU_DEVICE_GET_HW_INFO is added to report such hardware
info to user. enum iommu_hw_info_type is defined to differentiate the
iommu hardware info reported to user hence user can decode them. This
series only adds the framework for iommu hw info reporting, the complete
reporting path needs vendor specific definition and driver support. The
full picture is available in [1] as well.

base-commit: 35db4f4dac813ffaa987cf633694107fabf3aff5

[1] https://github.com/yiliu1765/iommufd/tree/iommufd_nesting

Change log:

v3:
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
  iommufd/selftest: Add coverage for IOMMU_DEVICE_GET_HW_INFO ioctl

Yi Liu (2):
  iommu: Move dev_iommu_ops() to private header
  iommufd: Add IOMMU_DEVICE_GET_HW_INFO

 drivers/iommu/iommu-priv.h                    | 11 +++
 drivers/iommu/iommu.c                         |  2 +
 drivers/iommu/iommufd/device.c                | 73 +++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h       |  1 +
 drivers/iommu/iommufd/iommufd_test.h          |  9 +++
 drivers/iommu/iommufd/main.c                  |  3 +
 drivers/iommu/iommufd/selftest.c              | 16 ++++
 include/linux/iommu.h                         | 27 ++++---
 include/uapi/linux/iommufd.h                  | 44 +++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 17 ++++-
 tools/testing/selftests/iommu/iommufd_utils.h | 26 +++++++
 11 files changed, 217 insertions(+), 12 deletions(-)

-- 
2.34.1

