Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237667154F6
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 07:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjE3Fia (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 01:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjE3Fi3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 01:38:29 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D852EA;
        Mon, 29 May 2023 22:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685425107; x=1716961107;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SlmVU0gCOJtKzGhhoLJtPHVYcv/MzAh06Xb0nC+R2xw=;
  b=eCe/hlL2QJFzeMkcb5OxWRZk4o47Lb1qQ7XYBp1Kh41KfRW/E5gJBZU0
   cgvHvpxuOgu1DNTR9XdXTU02OK26xa+/FXtcDIxvFSTFRVMlqOVDoSH2w
   ubt8ZLVQVsfU4VuGWDn5uXQaJLE8MSApYNf/S5qFrD48WKujGjmN8MDx8
   6MmINFuTepaxFPegwhnZyPzqQzKST/6+6a1NjCxScBa6Sl6SvYOs4DsH3
   2VdjzoiN2qI0nNDezcOb6HZBeBhf4QlARNlwX0GLErN5F3jhwBHJAWgHJ
   2IgpRI0xx3AX+zepaDtjhd76Ypnb7D34xK8iVY9PwEkisvaXs73eT9Bat
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="420579570"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="420579570"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 22:38:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="739369265"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="739369265"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 29 May 2023 22:38:20 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [RFC PATCHES 00/17] IOMMUFD: Deliver IO page faults to user space
Date:   Tue, 30 May 2023 13:37:07 +0800
Message-Id: <20230530053724.232765-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi folks,

This series implements the functionality of delivering IO page faults to
user space through the IOMMUFD framework. The use case is nested
translation, where modern IOMMU hardware supports two-stage translation
tables. The second-stage translation table is managed by the host VMM
while the first-stage translation table is owned by the user space.
Hence, any IO page fault that occurs on the first-stage page table
should be delivered to the user space and handled there. The user space
should respond the page fault handling result to the device top-down
through the IOMMUFD response uAPI.

User space indicates its capablity of handling IO page faults by setting
a user HWPT allocation flag IOMMU_HWPT_ALLOC_FLAGS_IOPF_CAPABLE. IOMMUFD
will then setup its infrastructure for page fault delivery. Together
with the iopf-capable flag, user space should also provide an eventfd
where it will listen on any down-top page fault messages.

On a successful return of the allocation of iopf-capable HWPT, a fault
fd will be returned. User space can open and read fault messages from it
once the eventfd is signaled.

Besides the overall design, I'd like to hear comments about below
designs:

- The IOMMUFD fault message format. It is very similar to that in
  uapi/linux/iommu which has been discussed before and partially used by
  the IOMMU SVA implementation. I'd like to get more comments on the
  format when it comes to IOMMUFD.

- The timeout value for the pending page fault messages. Ideally we
  should determine the timeout value from the device configuration, but
  I failed to find any statement in the PCI specification (version 6.x).
  A default 100 milliseconds is selected in the implementation, but it
  leave the room for grow the code for per-device setting.

This series is only for review comment purpose. I used IOMMUFD selftest
to verify the hwpt allocation, attach/detach and replace. But I didn't
get a chance to run it with real hardware yet. I will do more test in
the subsequent versions when I am confident that I am heading on the
right way.

This series is based on the latest implementation of the nested
translation under discussion. The whole series and related patches are
available on gitbub:

https://github.com/LuBaolu/intel-iommu/commits/iommufd-io-pgfault-delivery-v1

Best regards,
baolu

Lu Baolu (17):
  iommu: Move iommu fault data to linux/iommu.h
  iommu: Support asynchronous I/O page fault response
  iommu: Add helper to set iopf handler for domain
  iommu: Pass device parameter to iopf handler
  iommu: Split IO page fault handling from SVA
  iommu: Add iommu page fault cookie helpers
  iommufd: Add iommu page fault data
  iommufd: IO page fault delivery initialization and release
  iommufd: Add iommufd hwpt iopf handler
  iommufd: Add IOMMU_HWPT_ALLOC_FLAGS_USER_PASID_TABLE for hwpt_alloc
  iommufd: Deliver fault messages to user space
  iommufd: Add io page fault response support
  iommufd: Add a timer for each iommufd fault data
  iommufd: Drain all pending faults when destroying hwpt
  iommufd: Allow new hwpt_alloc flags
  iommufd/selftest: Add IOPF feature for mock devices
  iommufd/selftest: Cover iopf-capable nested hwpt

 include/linux/iommu.h                         | 175 +++++++++-
 drivers/iommu/{iommu-sva.h => io-pgfault.h}   |  25 +-
 drivers/iommu/iommu-priv.h                    |   3 +
 drivers/iommu/iommufd/iommufd_private.h       |  32 ++
 include/uapi/linux/iommu.h                    | 161 ---------
 include/uapi/linux/iommufd.h                  |  73 +++-
 tools/testing/selftests/iommu/iommufd_utils.h |  20 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |   2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   2 +-
 drivers/iommu/intel/iommu.c                   |   2 +-
 drivers/iommu/intel/svm.c                     |   2 +-
 drivers/iommu/io-pgfault.c                    |   7 +-
 drivers/iommu/iommu-sva.c                     |   4 +-
 drivers/iommu/iommu.c                         |  50 ++-
 drivers/iommu/iommufd/device.c                |  64 +++-
 drivers/iommu/iommufd/hw_pagetable.c          | 318 +++++++++++++++++-
 drivers/iommu/iommufd/main.c                  |   3 +
 drivers/iommu/iommufd/selftest.c              |  71 ++++
 tools/testing/selftests/iommu/iommufd.c       |  17 +-
 MAINTAINERS                                   |   1 -
 drivers/iommu/Kconfig                         |   4 +
 drivers/iommu/Makefile                        |   3 +-
 drivers/iommu/intel/Kconfig                   |   1 +
 23 files changed, 837 insertions(+), 203 deletions(-)
 rename drivers/iommu/{iommu-sva.h => io-pgfault.h} (71%)
 delete mode 100644 include/uapi/linux/iommu.h

-- 
2.34.1

