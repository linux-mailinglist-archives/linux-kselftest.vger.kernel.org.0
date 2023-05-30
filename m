Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891D371550B
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 07:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjE3FlB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 01:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjE3Fkb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 01:40:31 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C5B102;
        Mon, 29 May 2023 22:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685425216; x=1716961216;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=07iXsgZBQsRNVYOgRRfnTYdWG3SMG8/nVfXEU8dn588=;
  b=UzZ4i+9quFmB847u3opdhv40JjcxnZZMtR5N5S+OmckjoF8h3fmmla9U
   IjNb7K73GUeUe1xUsuYdpql3MMlu8+tmbxevcpkzS8s9pEYRGP8ck9JlP
   +zPDY0pnDwC7Lgs3HLIccpEikf0ZS7pbngF9/izYQeNWAAbbAbn/Esj+P
   /ZMfaNDoN4ucXDLM4PhMFKbtNSbif+ko6Vub5+rHN8XZ5n6wHRVAJedaw
   41NLI19YxS8q491J3aLKiRx+AvrKxg+m6rfJfNtm3RIgEj7a7F3iWeasc
   zSeG829H20VWXUCire9DvS1vY3HXpDvilkbq5/QSsrU6xg32HOFY1ltHn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="420579803"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="420579803"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 22:39:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="739369765"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="739369765"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 29 May 2023 22:38:58 -0700
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
Subject: [RFC PATCHES 10/17] iommufd: Add IOMMU_HWPT_ALLOC_FLAGS_USER_PASID_TABLE for hwpt_alloc
Date:   Tue, 30 May 2023 13:37:17 +0800
Message-Id: <20230530053724.232765-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530053724.232765-1-baolu.lu@linux.intel.com>
References: <20230530053724.232765-1-baolu.lu@linux.intel.com>
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

This flag indicates that the architecture supports assigning the whole
PASID table for a device to userspace. When this flag is set, the host
kernel does not need to be involved in attaching or detaching HWPTs to
any PASID of the device. For such architectures, the fault cookie is
always saved as {device, 0}.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 1 +
 include/uapi/linux/iommufd.h            | 3 +++
 drivers/iommu/iommufd/hw_pagetable.c    | 6 +++++-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 8ff7721ea922..67e5aa0f996e 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -241,6 +241,7 @@ struct hw_pgtable_fault {
 	struct list_head deliver;
 	struct list_head response;
 	struct eventfd_ctx *trigger;
+	bool user_pasid_table;
 };
 
 struct iommufd_fault {
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 2c7c44c00da2..63863e21d043 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -449,6 +449,8 @@ struct iommu_hwpt_arm_smmuv3 {
  *    must be valid once this flag is set. On successful return, user can
  *    listen to @event_fd and retrieve faults by reading @out_fault_fd.
  *    The fault data is encoded in the format defined by iommu_hwpt_pgfault.
+ *  - USER_PASID_TABLE: The architecture supports assigning the whole pasid
+ *    table of a device to user.
  * @dev_id: The device to allocate this HWPT for
  * @pt_id: The IOAS to connect this HWPT to
  * @out_hwpt_id: The ID of the new HWPT
@@ -487,6 +489,7 @@ struct iommu_hwpt_alloc {
 	__u32 size;
 	__u32 flags;
 #define IOMMU_HWPT_ALLOC_FLAGS_IOPF_CAPABLE		(1 << 0)
+#define IOMMU_HWPT_ALLOC_FLAGS_USER_PASID_TABLE		(1 << 1)
 	__u32 dev_id;
 	__u32 pt_id;
 	__u32 out_hwpt_id;
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 4d07c7c0073e..ca3e4d92f2aa 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -304,6 +304,9 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 			goto out_hwpt;
 		}
 
+		if (cmd->flags & IOMMU_HWPT_ALLOC_FLAGS_USER_PASID_TABLE)
+			hwpt->fault->user_pasid_table = true;
+
 		iommu_domain_set_iopf_handler(hwpt->domain,
 					      iommufd_hw_pagetable_iopf_handler,
 					      hwpt);
@@ -401,7 +404,8 @@ iommufd_hw_pagetable_iopf_handler(struct iommu_fault *fault,
 	if (!ifault)
 		return IOMMU_PAGE_RESP_FAILURE;
 
-	cookie = iommu_get_device_fault_cookie(dev, fault->prm.pasid);
+	cookie = iommu_get_device_fault_cookie(dev,
+			hwpt->fault->user_pasid_table ?  0 : fault->prm.pasid);
 	if (!cookie)
 		return IOMMU_PAGE_RESP_FAILURE;
 
-- 
2.34.1

