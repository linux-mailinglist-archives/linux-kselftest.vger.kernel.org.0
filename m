Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2157AE907
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 11:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbjIZJ1E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 05:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbjIZJ1C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 05:27:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FE419E;
        Tue, 26 Sep 2023 02:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695720415; x=1727256415;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Mlbi+6M1s6U2RPliGYVpXD/JFSTKRRNeoaMCt/HBTTw=;
  b=aAkgK4Mm/ko+Q2Uuo6dl5GrxClYhDiAqBYovZZjmxDPZtVNTbX/XsCnb
   wzjzWV+DsxyxYdWS39MgKXu3wxF0/lHmq35QI2S/o8/iFrCycPV5MT6HS
   w8VWdjlyQtGEb0Ji9G2m9Xt5JpO4xuTj/MorLWMgt32/7AQP8IFb3XWcq
   ECdPK5lF3EXy8QOAx5WBZGqrYLRRJ0vpTTCrfUb4NzsENGvcuKtmZsua7
   GJgFRU8ZxcISQwLHB9DgSgdR4+OZzGufzFtZfaILWuJpPu+OdQ4E2nKoX
   79O6M9eGKxBQPL0CJoVABJcUIpRahOR/I4l6ACRp0LTuU1Hnu1yWnLosj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360905326"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="360905326"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 02:26:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="1079642512"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="1079642512"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga005.fm.intel.com with ESMTP; 26 Sep 2023 02:26:53 -0700
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
Subject: [RFC 0/8] iommufd support pasid attach/replace
Date:   Tue, 26 Sep 2023 02:26:43 -0700
Message-Id: <20230926092651.17041-1-yi.l.liu@intel.com>
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

PASID (Process Address Space ID) is a PCIe extension to tag the DMA
transactions out of a physical device, and most modern IOMMU hardware
have supported PASID granular address translation. So a PASID-capable
devices can be attached to multiple hwpts (a.k.a. domains), each attachment
is tagged with a PASID.

This series first adds a missing iommu API to replace domain for a pasid,
then adds iommufd APIs for device drivers to attach/replace/detach pasid
to/from hwpt per userspace's request, and adds selftest to validate the
iommufd APIs.

pasid attach/replace is mandatory on Intel VT-d given the PASID table
locates in the physical address space hence must be managed by the kernel,
both for supporting vSVA and coming SIOV. But it's optional on ARM/AMD
which allow configuring the PASID/CD table either in host physical address space
or nested on top of an GPA address space. This series only add VT-d support
as the minimal requirement.

Complete code can be found in below link:

https://github.com/yiliu1765/iommufd/tree/iommufd_pasid

Regards,
	Yi Liu

Kevin Tian (1):
  iommufd: Support attach/replace hwpt per pasid

Lu Baolu (2):
  iommu: Introduce a replace API for device pasid
  iommu/vt-d: Add set_dev_pasid callback for nested domain

Yi Liu (5):
  iommufd: replace attach_fn with a structure
  iommufd/selftest: Add set_dev_pasid and remove_dev_pasid in mock iommu
  iommufd/selftest: Add a helper to get test device
  iommufd/selftest: Add test ops to test pasid attach/detach
  iommufd/selftest: Add coverage for iommufd pasid attach/detach

 drivers/iommu/intel/nested.c                  |  47 +++++
 drivers/iommu/iommu-priv.h                    |   2 +
 drivers/iommu/iommu.c                         |  73 ++++++--
 drivers/iommu/iommufd/Makefile                |   1 +
 drivers/iommu/iommufd/device.c                |  42 +++--
 drivers/iommu/iommufd/iommufd_private.h       |  16 ++
 drivers/iommu/iommufd/iommufd_test.h          |  24 +++
 drivers/iommu/iommufd/pasid.c                 | 152 ++++++++++++++++
 drivers/iommu/iommufd/selftest.c              | 158 ++++++++++++++--
 include/linux/iommufd.h                       |   6 +
 tools/testing/selftests/iommu/iommufd.c       | 172 ++++++++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  28 ++-
 tools/testing/selftests/iommu/iommufd_utils.h |  78 ++++++++
 13 files changed, 756 insertions(+), 43 deletions(-)
 create mode 100644 drivers/iommu/iommufd/pasid.c

-- 
2.34.1

