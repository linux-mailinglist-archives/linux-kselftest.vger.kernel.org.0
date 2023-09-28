Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C2E7B146D
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 09:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjI1HPj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 03:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjI1HPd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 03:15:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC041B2;
        Thu, 28 Sep 2023 00:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695885331; x=1727421331;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Wn3wXR37JoGGgItNRNp+OOoXXPlkBH9261CwXM5sCbI=;
  b=jI8IrMhYRBlshiNNQKlu4aWa2NYg4d++uIhmAsDBi0B6EanfrnPaCPje
   d4gaMzQR7+I/3C2aYyI4ppDn/TdaKA/9hywDGI/+MUVhg6MKnVPSRevnx
   /CBJiHGJreHMi8SIZi34E6XgUrNyIIZbTwW+BAXe1a1srZFl73Rzso0WK
   7vc2TfGebw+CnzouT/s3b365CTCQu8qXfimcdWU0MbsGE93SE+lF7Moay
   KJZECdfsOVvtqgEBVfiBX9uBtlrk65qaFX4gKRZzDgGhbEshd0TxvS7Im
   bFBAubR1lS6NDqokWwelF6d3OlNm9Ueoek1LghDLr6tTlSkom6GXGTxnx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="412914813"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="412914813"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 00:15:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="784601954"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="784601954"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga001.jf.intel.com with ESMTP; 28 Sep 2023 00:15:30 -0700
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
Subject: [PATCH v2 0/6] iommufd support allocating nested parent domain
Date:   Thu, 28 Sep 2023 00:15:22 -0700
Message-Id: <20230928071528.26258-1-yi.l.liu@intel.com>
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

IOMMU hardwares that support nested translation would have two stages
address translation (normally mentioned as stage-1 and stage-2). The page
table formats of the stage-1 and stage-2 can be different. e.g., VT-d has
different page table formats for stage-1 and stage-2.

Nested parent domain is the iommu domain used to represent the stage-2
translation. In IOMMUFD, both stage-1 and stage-2 translation are tracked
as HWPT (a.k.a. iommu domain). Stage-2 HWPT is parent of stage-1 HWPT as
stage-1 cannot work alone in nested translation. In the cases of stage-1 and
stage-2 page table format are different, the parent HWPT should use exactly
the stage-2 page table format. However, the existing kernel hides the format
selection in iommu drivers, so the domain allocated via IOMMU_HWPT_ALLOC can
use either stage-1 page table format or stage-2 page table format, there is
no guarantees for it.

To enforce the page table format of the nested parent domain, this series
introduces a new iommu op (domain_alloc_user) which can accept user flags
to allocate domain as userspace requires. It also converts IOMMUFD to use
the new domain_alloc_user op for domain allocation if supported, then extends
the IOMMU_HWPT_ALLOC ioctl to pass down a NEST_PARENT flag to allocate a HWPT
which can be used as parent. This series implements the new op in Intel iommu
driver to have a complete picture. It is a preparation for adding nesting
support in IOMMUFD/IOMMU.

Complete code can be found:
https://github.com/yiliu1765/iommufd/tree/iommufd_alloc_user_v2

Change log:

v2:
 - Require domain_alloc_user op if IOMMU_HWPT_ALLOC passes non-zero flags (Kevin)
 - IOMMUFD core should check kernel known flags while iommu driver needs
   to check supported flags as well (Jason)
 - Minor tweaks per Baolu's comment

v1: https://lore.kernel.org/linux-iommu/20230919092523.39286-1-yi.l.liu@intel.com/

Regards,
	Yi Liu

Yi Liu (6):
  iommu: Add new iommu op to create domains owned by userspace
  iommufd/hw_pagetable: Use domain_alloc_user op for domain allocation
  iommufd/hw_pagetable: Accepts user flags for domain allocation
  iommufd/hw_pagetable: Support allocating nested parent domain
  iommufd/selftest: Add domain_alloc_user() support in iommu mock
  iommu/vt-d: Add domain_alloc_user op

 drivers/iommu/intel/iommu.c                   | 28 +++++++++++++++++
 drivers/iommu/iommufd/device.c                |  2 +-
 drivers/iommu/iommufd/hw_pagetable.c          | 31 ++++++++++++++-----
 drivers/iommu/iommufd/iommufd_private.h       |  3 +-
 drivers/iommu/iommufd/selftest.c              | 19 ++++++++++++
 include/linux/iommu.h                         | 11 ++++++-
 include/uapi/linux/iommufd.h                  | 12 ++++++-
 tools/testing/selftests/iommu/iommufd.c       | 24 +++++++++++---
 .../selftests/iommu/iommufd_fail_nth.c        |  2 +-
 tools/testing/selftests/iommu/iommufd_utils.h | 11 +++++--
 10 files changed, 124 insertions(+), 19 deletions(-)

-- 
2.34.1

