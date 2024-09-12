Return-Path: <linux-kselftest+bounces-17823-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8200A9769FF
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 15:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22714282234
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 13:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6662E1A4E8A;
	Thu, 12 Sep 2024 13:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V0xNv0lw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D0E1A2554
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 13:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146417; cv=none; b=Gldhwm/25P5IvVRPC2JJRnyueAYhR24yLZ3Fel5JwB2Bh2fvNT7Inu+kWjWUKmbUqciBSyiL19dPfuhE3xVfAZFQ9m1+PM+LeEtwPDgd2I8Bh5U2qKaQoRG0yvRe355QfBVDffD8EXaZ8SfJ4C4ZdkcWBQTgrumnnQMKrQEZYw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146417; c=relaxed/simple;
	bh=WGNva7lCjkS+Ss6lxS/Wf8hPh3EcDCZagdLFiyY9rAc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MtgsRsK1Ebowl20w6crLm2L4kqEzekvlTsBU7Cvz5LywBRArZjGOy4rJGzKu297ySwP6og3wTLGrlEgzOgqfQrcUjBo9vc7DkbJs2Sjuw4yNZIitR8en2twtdjxMccApYZJvHF8Mp5jAUh4B92nt9ig2s83NHOUBC9XOCEoZ3VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V0xNv0lw; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726146416; x=1757682416;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WGNva7lCjkS+Ss6lxS/Wf8hPh3EcDCZagdLFiyY9rAc=;
  b=V0xNv0lwOPKiC+EYaig+OqpPBkN3IVxP8tLq8zwlvr2PgjHrPdnlZFqf
   jVsL1WtRF3HBH9NfJ29eIGfsusLeMBP5CIlR6VMcwLg2ERmWG5rh/s93e
   48Iqr5F/SQrIvj+osaWiVOnc6RlJVIlABkOmWdR9c0a3dt82Vj9W1chCU
   zQmjGPuc2cLU+J1ef73m66xBs8XhY00eqVK0iybalaiyetRnJoHNa3YRd
   gQyO3ghgSIqJ8jCbcdU6l8O4rAXFSFT0ZATfhp1Ko/hrZfGzjBKEy0RXP
   b8i2Vt8y+i908AlCwWQ0WSUemBtkBK25u80H962stC0xJnWmSEHG94twi
   g==;
X-CSE-ConnectionGUID: KOHBQXiaQkW0oovDgvnFdg==
X-CSE-MsgGUID: AQTTdStzQMufFmfCUhOlaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="35585681"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="35585681"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 06:06:55 -0700
X-CSE-ConnectionGUID: 8VtqP9XbSp2Fq2QTjcSmIg==
X-CSE-MsgGUID: 9Z11/YJCTfuEcLz0TIQKJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="68211605"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa007.jf.intel.com with ESMTP; 12 Sep 2024 06:06:56 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	linux-kselftest@vger.kernel.org,
	vasant.hegde@amd.com
Subject: [PATCH 0/3] Support attaching PASID to the blocked_domain
Date: Thu, 12 Sep 2024 06:06:50 -0700
Message-Id: <20240912130653.11028-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During the review of iommufd pasid series, Kevin and Jason suggested
attaching PASID to the blocked domain hence replacing the usage of
remove_dev_pasid() op [1]. This makes sense as it makes the PASID path
aligned with the RID path which attaches the RID to the blocked_domain
when it is to be blocked. To do it, it requires passing the old domain
to the iommu driver. This has been done in [2].

This series makes the Intel iommu driver and ARM SMMUv3 driver support
attaching PASID to the blocked domain. While the AMD iommu driver does
not have the blocked domain yet, so still uses the remove_dev_pasid() op.

[1] https://lore.kernel.org/linux-iommu/20240816130202.GB2032816@nvidia.com/
[2] https://lore.kernel.org/linux-iommu/20240912130427.10119-1-yi.l.liu@intel.com/

Regards,
	Yi Liu

Jason Gunthorpe (1):
  iommu/arm-smmu-v3: Make smmuv3 blocked domain support PASID

Yi Liu (2):
  iommu/vt-d: Make blocked domain support PASID
  iommu: Add a wrapper for remove_dev_pasid

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 12 ++++-----
 drivers/iommu/intel/iommu.c                 | 17 ++++++++----
 drivers/iommu/iommu.c                       | 30 ++++++++++++++++-----
 3 files changed, 42 insertions(+), 17 deletions(-)

-- 
2.34.1


