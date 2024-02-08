Return-Path: <linux-kselftest+bounces-4317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 498F984DB48
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 09:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BC861C25A7F
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 08:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FD06A32F;
	Thu,  8 Feb 2024 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OmvzCBQ8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B286A325;
	Thu,  8 Feb 2024 08:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707380592; cv=none; b=hlGpGg0Imfi4+IkMlrneKMqBCw3khEGOtXkDz3/5/yn4T2+iGbqiqENo7xapA79PY+Kxn3GSL17TzNXgsjaZ+sIMMgsdAo0Yg/CKFYV3wEHW5OF4mmKjB9v1cxN4UjBLoghC2VzA7fwKBF9/SzGP2Hn4YBI6yHMrqrkjDX6AEPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707380592; c=relaxed/simple;
	bh=dw1iWzN0+Odaehn3lAl74xWZ5i8sPOjzK50me6Uozys=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P9FrwFb+L811bFW+wL6FXC/qsCCNsr2a7ZshEkM4twQjqLXmELcKNP6gbI2CPT+9lFGDyEkEw00oaloMcqiezOFNlD5d8bAWFRzrL/BtpE8TPJvwL3jQTqCvqG2dgZ0zTv9Ff308qvCSHfy+XnAsXSovV5vYH9GqbGbCW8E4XIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OmvzCBQ8; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707380591; x=1738916591;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dw1iWzN0+Odaehn3lAl74xWZ5i8sPOjzK50me6Uozys=;
  b=OmvzCBQ83RRQeRHZaQe3x2vAUzlyLTVfMs/gByFiFrMAvj6JO7u5+wdr
   /7DiQ+DAm1L9Sa5jYIeGtxLG8gl1pSlZ2HQ5vQkT6J00S4QqFZgmmD1hy
   +T/81i60ZAIHvVhvTAdjgcnWmN/ECmGmrnYoss3sMOjOdL+ynLKwrKkbE
   QBe/g6r1Pj+ALrbfBV8VtlJHzwFpls7NpPtX8c3iuIYdKXFzfVKUl7Tcq
   VP5mrg5Ei0FlxV9gggrz0kQXGA4AoO671K3xn4Zcr9PTe0qh2l+OvNO8o
   uelUFi18FNwH09L+ne3EB2QVkrVGYn0LVd/CXAD7NZ1bSEE+FYJemEXSs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="5036295"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="5036295"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:23:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="6252080"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa003.jf.intel.com with ESMTP; 08 Feb 2024 00:23:09 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	robin.murphy@arm.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	yi.y.sun@linux.intel.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhenzhong.duan@intel.com,
	joao.m.martins@oracle.com
Subject: [PATCH rc 0/8] Add missing cache flush and dirty tracking set for nested parent domain
Date: Thu,  8 Feb 2024 00:22:59 -0800
Message-Id: <20240208082307.15759-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds the missing cache flush and dirty track set for nested
parent domain (it's s2_domain but used as parent) which has no insight
into devices/DID's under the nested domain (a.k.a s1_domain). This
results in missing cache flush per parent domain change and incomplete
dirty tracking set on the parent domain. There was a discussion about
this in the mailing list [1].

This series adds a s1_domains list in the parent domain to track the nested
domains. Hence, the driver can loop the nested domains and use the DIDs of
the nested domain to flush iotlb. The driver can also loop the nested domains
and nested domain's devices list to flush device iotlb and set the dirty
tracking completely.

This series doesn't touch the pasid iotlb or the pasid devtlb as there is
no support of attaching pasid to nested domain yet. It will be covered when
that feature is enabled.

The complete code can be found at[2], this has been tested with a hacky
Qemu[3] to test the unmap on parent domain and dirty tracking set on parent
domain. This just verifies the new path. So appreciated to see t-b with
regression tests.

This aims to the 6.8 rc#, so your special attention is welcomed.

[1] https://lore.kernel.org/linux-iommu/92f8aaca-093d-4161-b8f2-5ab1680df769@intel.com/
[2] https://github.com/yiliu1765/iommufd/tree/vtd_nesting_fixes
[3] https://github.com/yiliu1765/qemu/tree/tmp/for-testing-unmap-and-dirty-set-on-parent

base commit: 547ab8fc4cb04a1a6b34377dd8fad34cd2c8a8e3

Regards,
	Yi Liu

Yi Liu (8):
  iommu/vt-d: Track nested domains in parent
  iommu/vt-d: Add __iommu_flush_iotlb_psi()
  iommu/vt-d: Add missing iotlb flush for parent domain
  iommu/vt-d: Update iotlb in nested domain attach
  iommu/vt-d: Add missing device iotlb flush for parent domain
  iommu/vt-d: Remove @domain parameter from
    intel_pasid_setup_dirty_tracking()
  iommu/vt-d: Wrap the dirty tracking loop to be a helper
  iommu/vt-d: Add missing dirty tracking set for parent domain

 drivers/iommu/intel/iommu.c  | 213 ++++++++++++++++++++++++++---------
 drivers/iommu/intel/iommu.h  |   7 ++
 drivers/iommu/intel/nested.c |  12 ++
 drivers/iommu/intel/pasid.c  |   3 +-
 drivers/iommu/intel/pasid.h  |   1 -
 5 files changed, 182 insertions(+), 54 deletions(-)

-- 
2.34.1


