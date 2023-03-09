Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7C96B1D05
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Mar 2023 08:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjCIHyn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Mar 2023 02:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjCIHyZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Mar 2023 02:54:25 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB43ADBB55;
        Wed,  8 Mar 2023 23:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678348441; x=1709884441;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RubhDtHOvvhIgkBGxFBQdeW6R2z9yWM3cIPSs3aY9iw=;
  b=nkkGstrxwwtqJoCvoxxS+n+y2H+PssOy3NbrLqz9PGikjwBmtzwxjF8Q
   r5MCqrmI0FHjCDUYXLudUSyrSEHmG8th6RLPQPxfgf/a6V8KYTPEB2hlP
   0ZjflleKo7RHk2pLlSNZYYfP/WW6ftCWB9PFdXLnRO12LHZoA8Cj3Egpb
   SfJb1bF83F7jakg6zFBU8mAuve0CHwVqWwj/IT3xH1IZD02qurjAdg2gc
   4CfR0naz8EmOprmdCa+q9ooKdeu2gEu1jqLIYagib51lmIEk/s16to5EP
   O2B0EJjqlVonULNm/S729k64HTnJTMY5pMjd8rob36hAmtb/5wSLJ2U1x
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="422652827"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="422652827"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 23:54:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="851432734"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="851432734"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga005.jf.intel.com with ESMTP; 08 Mar 2023 23:54:00 -0800
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
Subject: [PATCH v2 0/4] iommufd: Add iommu hardware info reporting
Date:   Wed,  8 Mar 2023 23:53:54 -0800
Message-Id: <20230309075358.571567-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

base-commit: 4c7e97cb6e65eab02991f60a5cc7a4fed5498c7a

[1] https://github.com/yiliu1765/iommufd/tree/iommufd_nesting

Change log:

v2:
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
 drivers/iommu/iommufd/device.c                | 75 +++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h       |  1 +
 drivers/iommu/iommufd/iommufd_test.h          | 15 ++++
 drivers/iommu/iommufd/main.c                  |  3 +
 drivers/iommu/iommufd/selftest.c              | 16 ++++
 include/linux/iommu.h                         | 24 +++---
 include/uapi/linux/iommufd.h                  | 47 ++++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 17 ++++-
 tools/testing/selftests/iommu/iommufd_utils.h | 26 +++++++
 11 files changed, 225 insertions(+), 12 deletions(-)

-- 
2.34.1

