Return-Path: <linux-kselftest+bounces-17827-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5C1976A20
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 15:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEEB2B20FBE
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 13:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408B81A7AF1;
	Thu, 12 Sep 2024 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a4iyCYzN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8961A1A4E7A
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 13:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146780; cv=none; b=O/dIil186JyX1kgLnhZ3Z+FCFesWuTRcR6j3S6PjGbGcJMgkQWJ49luHyiOKk8xi8eA+T6s2dlEwfgiuw/lDpQYLZKHlt3jlBGFQKujy6NrOhktuPEFZPU12Gol4PilBEgMDNw/bbCn4o3S2JS3uXryb2+yOvRxNod6/Jmg5Tuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146780; c=relaxed/simple;
	bh=D3nmEDtPL40OglMz8u3l9jkUYnVegC07vCvW9CD6vL8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g216kB0sCqaZWrtP0tNlJZpdh0NEjDtUrbp2v36nUzYh3uP4MY6Aveq1h+bWCKYa8wAu+PFt0cKWfNym+MqxWnAPfpQ5Fs4j0tTq0pgzuBS1rfRD+XV5aXg9fTLZ+xua37GL0NXYLeFQ5EeLMW8SHbGfmIwwLNCzmDCgDtre8N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a4iyCYzN; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726146777; x=1757682777;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D3nmEDtPL40OglMz8u3l9jkUYnVegC07vCvW9CD6vL8=;
  b=a4iyCYzN6G+rvAmt1tUB1ZpbsPd/OhtDc6vcXfd9Ybir+ofpx4PXwdxK
   9wH46NUXsqoHcWg9553k1satmHyIKXi7bIbNoRhr3HVMpTu+y+7VBUVWd
   EmFnthrlN5dXxdKXTwp9A5gUh+mbLjD5OYdOx6xykC8azTyDTiWfp9Zpk
   j3PViPE3KAM3g7+kMK/46V5aU7jW59v2WsdtrMV7W5tjPXtc1sg9xKC4E
   UnL4E2vDYtgbpVQ8OOWwoxvdIMHOBNjzHtEeJP0FKGqC781v4+9V8hZ7o
   pXVXL5r4jTbGlIx51Bc6FQziCYyGhp26/37J5qJqu+tKbRhdL5N96I9TP
   A==;
X-CSE-ConnectionGUID: Kztc+tLrSG6GkaPV77yXvA==
X-CSE-MsgGUID: wOvZVrvXSh6bsNDlKh/gpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="27911195"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="27911195"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 06:12:57 -0700
X-CSE-ConnectionGUID: kpiAJfFFTmWP4WiPAvs7qg==
X-CSE-MsgGUID: NHsTynhURMmkXgu8cgxvqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67996534"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa006.jf.intel.com with ESMTP; 12 Sep 2024 06:12:57 -0700
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
Subject: [PATCH v4 00/10] iommufd support pasid attach/replace
Date: Thu, 12 Sep 2024 06:12:45 -0700
Message-Id: <20240912131255.13305-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PASID (Process Address Space ID) is a PCIe extension to tag the DMA
transactions out of a physical device, and most modern IOMMU hardware
have supported PASID granular address translation. So a PASID-capable
device can be attached to multiple hwpts (a.k.a. domains), and each
attachment is tagged with a pasid.

This series is based on the preparation series [1] [2], it first adds a
missing iommu API to replace the domain for a pasid. Based on the iommu
pasid attach/ replace/detach APIs, this series adds iommufd APIs for device
drivers to attach/replace/detach pasid to/from hwpt per userspace's request,
and adds selftest to validate the iommufd APIs.

While this series has a missing part which is to enforce the domain
allocation with special flag if it will be used by PASID [3]. This is due
to special requirements by AMD. Since it is still in mailing discussion [4],
so let's mark it here. Once it's finalized, this series needs to enforce
the domain flag check to ensure the AMD pasid support is not broken from
day-1.

The completed code can be found in the below link [5]. Heads up! The existing
iommufd selftest was broken, there was a fix [6] to it, but not been
upstreamed yet. If want to run the iommufd selftest, please apply that fix.
Sorry for the inconvenience.

[1] https://lore.kernel.org/linux-iommu/20240912130427.10119-1-yi.l.liu@intel.com/
[2] https://lore.kernel.org/linux-iommu/20240912130653.11028-1-yi.l.liu@intel.com/
[3] https://lore.kernel.org/linux-iommu/20240822124433.GD3468552@ziepe.ca/
[4] https://lore.kernel.org/linux-iommu/20240911101911.6269-3-vasant.hegde@amd.com/
[5] https://github.com/yiliu1765/iommufd/tree/iommufd_pasid
[6] https://lore.kernel.org/linux-iommu/20240111073213.180020-1-baolu.lu@linux.intel.com/

Change log:

v4:
 - Replace remove_dev_pasid() by supporting set_dev_pasid() for blocking domain (Kevin)
	- This is done by the preparation series "Support attaching PASID to the blocked_domain"
 - Misc tweaks to foil the merging of the iommufd iopf series. Three new patches are added:
	- iommufd: Always pass iommu_attach_handle to iommu core
	- iommufd: Move the iommufd_handle helpers to iommufd_private.h
	- iommufd: Refactor __fault_domain_replace_dev() to be a wrapper of iommu_replace_group_handle()
 - Renmae patch 03 of v3 to be "iommufd: Support pasid attach/replace"
 - Add test case for attaching/replacing iopf-capable hwpt to pasid

v3: https://lore.kernel.org/kvm/20240628090557.50898-1-yi.l.liu@intel.com/
 - Split the set_dev_pasid op enhancements for domain replacement to be a
   separate series "Make set_dev_pasid op supportting domain replacement" [1].
   The below changes are made in the separate series.
   *) set_dev_pasid() callback should keep the old config if failed to attach to
      a domain. This simplifies the caller a lot as caller does not need to attach
      it back to old domain explicitly. This also avoids some corner cases in which
      the core may do duplicated domain attachment as described in below link (Jason)
      https://lore.kernel.org/linux-iommu/BN9PR11MB52768C98314A95AFCD2FA6478C0F2@BN9PR11MB5276.namprd11.prod.outlook.com/
   *) Drop patch 10 of v2 as it's a bug fix and can be submitted separately (Kevin)
   *) Rebase on top of Baolu's domain_alloc_paging refactor series (Jason)
 - Drop the attach_data which includes attach_fn and pasid, insteadly passing the
   pasid through the device attach path. (Jason)
 - Add a pasid-num-bits property to mock dev to make pasid selftest work (Kevin)

v2: https://lore.kernel.org/linux-iommu/20240412081516.31168-1-yi.l.liu@intel.com/
 - Domain replace for pasid should be handled in set_dev_pasid() callbacks
   instead of remove_dev_pasid and call set_dev_pasid afteward in iommu
   layer (Jason)
 - Make xarray operations more self-contained in iommufd pasid attach/replace/detach
   (Jason)
 - Tweak the dev_iommu_get_max_pasids() to allow iommu driver to populate the
   max_pasids. This makes the iommufd selftest simpler to meet the max_pasids
   check in iommu_attach_device_pasid()  (Jason)

v1: https://lore.kernel.org/kvm/20231127063428.127436-1-yi.l.liu@intel.com/#r
 - Implemnet iommu_replace_device_pasid() to fall back to the original domain
   if this replacement failed (Kevin)
 - Add check in do_attach() to check corressponding attach_fn per the pasid value.

rfc: https://lore.kernel.org/linux-iommu/20230926092651.17041-1-yi.l.liu@intel.com/

Regards,
	Yi Liu

Yi Liu (10):
  iommu: Introduce a replace API for device pasid
  iommufd: Refactor __fault_domain_replace_dev() to be a wrapper of
    iommu_replace_group_handle()
  iommufd: Move the iommufd_handle helpers to iommufd_private.h
  iommufd: Always pass iommu_attach_handle to iommu core
  iommufd: Pass pasid through the device attach/replace path
  iommufd: Support pasid attach/replace
  iommufd/selftest: Add set_dev_pasid and remove_dev_pasid in mock iommu
  iommufd/selftest: Add a helper to get test device
  iommufd/selftest: Add test ops to test pasid attach/detach
  iommufd/selftest: Add coverage for iommufd pasid attach/detach

 drivers/iommu/iommu-priv.h                    |   4 +
 drivers/iommu/iommu.c                         |  90 +++++-
 drivers/iommu/iommufd/Makefile                |   1 +
 drivers/iommu/iommufd/device.c                |  46 ++--
 drivers/iommu/iommufd/fault.c                 |  90 ++----
 drivers/iommu/iommufd/hw_pagetable.c          |   5 +-
 drivers/iommu/iommufd/iommufd_private.h       | 129 ++++++++-
 drivers/iommu/iommufd/iommufd_test.h          |  30 ++
 drivers/iommu/iommufd/pasid.c                 | 157 +++++++++++
 drivers/iommu/iommufd/selftest.c              | 208 +++++++++++++-
 include/linux/iommufd.h                       |   7 +
 tools/testing/selftests/iommu/iommufd.c       | 256 ++++++++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  29 +-
 tools/testing/selftests/iommu/iommufd_utils.h |  78 ++++++
 14 files changed, 1005 insertions(+), 125 deletions(-)
 create mode 100644 drivers/iommu/iommufd/pasid.c

-- 
2.34.1


