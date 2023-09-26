Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C927C7AE94F
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 11:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbjIZJfW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 05:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjIZJfT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 05:35:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035FEF3;
        Tue, 26 Sep 2023 02:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695720913; x=1727256913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bZj72hwk6aGVHqUfVsQNiXvoc1GB8ZJ+RY64a2dEVnk=;
  b=CsFHfwDjUPio3TMeQ2KS9igb5wWbW/08xnYhqcUybO0NggZHh19kwHyS
   zfDr9YI0ht/JkwU0sUIZkmzL/dz3nLYJkZ4wIc47evQ6z8tA2v1zhUc5t
   uOfB7Khf9qO5+w0fGR4A/6N+HDM9qkxrjpvJ+1M80GXqZVEZQ4QSNxm+m
   30lC/HqCC9+K8kv6MZcJw/TNjs5E2YmweYPrjJQzuzW9y6o4fCzJfPmKz
   A6T2NGk1UwqBmYDlKdv2LIv1flPwHNfxsHTAMqY9KdR9CIbwb7ELoTalM
   Bp2FZgH+OggPdYuwpW4kUhQgVMGPOg50lLIjgbwIq+xeadLWGUVZcNihI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="412442921"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="412442921"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 02:31:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="725373049"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="725373049"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 26 Sep 2023 02:31:26 -0700
From:   Yi Liu <yi.l.liu@intel.com>
To:     alex.williamson@redhat.com, jgg@nvidia.com, kevin.tian@intel.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com
Cc:     joro@8bytes.org, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.l.liu@intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: [RFC 3/3] vfio/pci: Expose PCIe PASID capability to userspace
Date:   Tue, 26 Sep 2023 02:31:21 -0700
Message-Id: <20230926093121.18676-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926093121.18676-1-yi.l.liu@intel.com>
References: <20230926093121.18676-1-yi.l.liu@intel.com>
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

This exposes PCIe PASID capability to userspace and where to emulate this
capability if wants to further expose it to VM.

And this only exposes PASID capability for devices which has PCIe PASID
extended struture in its configuration space. While for VFs, userspace
is still unable to see this capability as SR-IOV spec forbides VF to
implement PASID capability extended structure. It is a TODO in future.
Related discussion can be found in below links:

https://lore.kernel.org/kvm/20200407095801.648b1371@w520.home/
https://lore.kernel.org/kvm/BL1PR11MB5271A60035EF591A5BE8AC878C01A@BL1PR11MB5271.namprd11.prod.outlook.com/

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/vfio/pci/vfio_pci_config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 7e2e62ab0869..dfae5ad5ebc0 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -95,7 +95,7 @@ static const u16 pci_ext_cap_length[PCI_EXT_CAP_ID_MAX + 1] = {
 	[PCI_EXT_CAP_ID_LTR]	=	PCI_EXT_CAP_LTR_SIZEOF,
 	[PCI_EXT_CAP_ID_SECPCI]	=	0,	/* not yet */
 	[PCI_EXT_CAP_ID_PMUX]	=	0,	/* not yet */
-	[PCI_EXT_CAP_ID_PASID]	=	0,	/* not yet */
+	[PCI_EXT_CAP_ID_PASID]	=	PCI_EXT_CAP_PASID_SIZEOF,
 	[PCI_EXT_CAP_ID_DVSEC]	=	0xFF,
 };
 
-- 
2.34.1

