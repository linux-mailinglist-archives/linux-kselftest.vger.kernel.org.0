Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0963268FE55
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 05:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjBIETW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 23:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjBIETU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 23:19:20 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208427AA9;
        Wed,  8 Feb 2023 20:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675916305; x=1707452305;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xI4jwcAkfh2lcTA8rQSFT0GKdDkIDlByxF+6Yr7jRrA=;
  b=P/Jq5DdjI1/PxcJXX6pQBN/kK5Zj4NZagXvpbai3rkOHxWY0ngAwcNIb
   +ZH4Xy7Muw7Vp+SouIDu1fd5c9ySBIUnPCqSQFE2eboETkfle129t3UZf
   r46055MP+NUhayCaVP9erG7eBJw+xNeu55KzYS3yJp2MbPnNP7bO2NFnY
   E3likTZXxeRKJYtXW54L/08NT4QFytGUYvR0ICmqQKLIjONVgsYVSvsy1
   LjpvDxspNZP5Y59NaoA+OIAuDCJxfhN/yTxdDs4EqW+tz/+TSbZ8SUzFw
   FF9nChi+8OaB07QGzjO7GYGEZpKHvSzQLhXIZ2lrucLtCHvfMN0kBOUj+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="394600685"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="394600685"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:16:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="912982071"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="912982071"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga006.fm.intel.com with ESMTP; 08 Feb 2023 20:16:44 -0800
From:   Yi Liu <yi.l.liu@intel.com>
To:     joro@8bytes.org, alex.williamson@redhat.com, jgg@nvidia.com,
        kevin.tian@intel.com, robin.murphy@arm.com
Cc:     cohuck@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
        kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.l.liu@intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        baolu.lu@linux.intel.com
Subject: [PATCH 0/6] iommufd: Add iommu capability reporting
Date:   Wed,  8 Feb 2023 20:16:36 -0800
Message-Id: <20230209041642.9346-1-yi.l.liu@intel.com>
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

iommufd gives userspace the capabilty to manipulating iommu subsytem.
e.g. DMA map/unmap etc. In the near future, it will also support iommu
nested translation. Different platform vendors have different implementation
for the nested translation. So before set up nested translation, userspace
needs to know the hardware iommu capabilities. For example, Intel platform
supports guest I/O page table to be the first stage translation structure.

This series reports the iommu capability for a given iommufd_device which
has been bound to iommufd. It is a preparation work for nested translation
support[1]. In this series, Intel VT-d capability reporting is added. Other
vendors may add their own reporting based on this series.

[1] https://github.com/yiliu1765/iommufd/tree/iommufd_nesting_vtd_v1

Regards,
	Yi Liu

Lu Baolu (2):
  iommu: Add new iommu op to get iommu hardware information
  iommu/vt-d: Implement hw_info for iommu capability query

Nicolin Chen (2):
  iommufd/selftest: Set iommu_device for mock_device
  iommufd/selftest: Add coverage for IOMMU_DEVICE_GET_INFO ioctl

Yi Liu (2):
  iommufd: Add IOMMU_DEVICE_GET_INFO
  iommufd/device: Add mock_device support in iommufd_device_get_info()

 drivers/iommu/intel/iommu.c                   | 19 ++++
 drivers/iommu/intel/iommu.h                   |  1 +
 drivers/iommu/iommufd/device.c                | 91 +++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h       |  2 +
 drivers/iommu/iommufd/iommufd_test.h          | 15 +++
 drivers/iommu/iommufd/main.c                  |  3 +
 drivers/iommu/iommufd/selftest.c              | 26 ++++++
 include/linux/iommu.h                         |  8 ++
 include/uapi/linux/iommufd.h                  | 63 +++++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 18 +++-
 tools/testing/selftests/iommu/iommufd_utils.h | 26 ++++++
 11 files changed, 271 insertions(+), 1 deletion(-)

-- 
2.34.1

