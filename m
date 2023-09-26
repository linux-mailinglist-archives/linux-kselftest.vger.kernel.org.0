Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D3B7AE94C
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 11:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbjIZJfV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 05:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbjIZJfT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 05:35:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D9DEB;
        Tue, 26 Sep 2023 02:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695720913; x=1727256913;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TNdNMjdyY903iNYTtJMXeD069ihbZWkt8cAbuDlkz7w=;
  b=SYJIkBZYATV5PD2z9Y6q1I9kQXywGBUNlsYCawofz+aw7Yq2DSPpHGeY
   8BvcTYd2CvEL0Vm+BNXOHMR/C4FLwFgc4Ijd0FC2M9ZmMh2ZXSacqTXzb
   /8q/8OOHp7xIIOaFycY7Yx1Ir3E+0vyib1NPNMaTuZysSODmgzSMdzhhn
   Nwuwbpps90FzODzcw9m50RkOO51w68VH1AX/mlxRQbIDdnkXP+0+1lezA
   cE7lW/Cy8yRaZu+rQrIgiwABhoHPNpq3RFFDOhDaj3iAAfR/9199cNMdy
   sOfIsv4nJGHx0fTC51FsukqLWlMxD03t+CgfIpIdKhugUp7aQ8+7jCJbU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="412442877"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="412442877"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 02:31:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="725372986"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="725372986"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 26 Sep 2023 02:31:22 -0700
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
Subject: [RFC 0/3] vfio-pci support pasid attach/detach
Date:   Tue, 26 Sep 2023 02:31:18 -0700
Message-Id: <20230926093121.18676-1-yi.l.liu@intel.com>
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

This adds the pasid attach/detach uAPIs for userspace to attach/detach
a PASID of a device to/from a given ioas/hwpt. Only vfio-pci driver is
enabled in this series. After this series, PASID-capable devices bound
with vfio-pci can report PASID capability to userspace and VM to enable
PASID usages like Shared Virtual Addressing (SVA).

This series first adds the helpers for pasid attach in vfio core and then
add the device cdev ioctls for pasid attach/detach, finally exposes the
device PASID capability to user. It depends on iommufd pasid attach/detach
series [1].

Complete code can be found at [2]

[1] https://lore.kernel.org/linux-iommu/20230926092651.17041-1-yi.l.liu@intel.com/
[2] https://github.com/yiliu1765/iommufd/tree/iommufd_pasid

Regards,
	Yi Liu

Kevin Tian (1):
  vfio-iommufd: Support pasid [at|de]tach for physical VFIO devices

Yi Liu (2):
  vfio: Add VFIO_DEVICE_PASID_[AT|DE]TACH_IOMMUFD_PT
  vfio/pci: Expose PCIe PASID capability to userspace

 drivers/vfio/device_cdev.c         | 45 ++++++++++++++++++++++++
 drivers/vfio/iommufd.c             | 48 ++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci.c        |  2 ++
 drivers/vfio/pci/vfio_pci_config.c |  2 +-
 drivers/vfio/vfio.h                |  4 +++
 drivers/vfio/vfio_main.c           |  8 +++++
 include/linux/vfio.h               | 11 ++++++
 include/uapi/linux/vfio.h          | 55 ++++++++++++++++++++++++++++++
 8 files changed, 174 insertions(+), 1 deletion(-)

-- 
2.34.1

