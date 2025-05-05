Return-Path: <linux-kselftest+bounces-32446-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0749AAA3C5
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 01:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E67D464F52
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 23:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B1B272E59;
	Mon,  5 May 2025 22:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPUqRfr+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337E1272E50;
	Mon,  5 May 2025 22:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483914; cv=none; b=LYIcEQwtZu31/XnHDbLR5mYYaXhlhoSnCfsI9UcbDzHhmBJ00Q+A2vN5eUevxqIPRQ1CTuGCp+UTjawh72tU+lUw5hpsZREsOWgKf/vdOt4F4ye9jqW8xA2GePaml8Qee4ynmX4wvNKnk1d8AnTU/LPHdGqlDb/LdRSJFHGNtqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483914; c=relaxed/simple;
	bh=7M0ewxZaxFv2r+GXywCow44b2DNjiU/QRAvFkCrH91M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vF3ix1mjVCPTC3gpaW9KpIL61x0HS2Pd9FCkNsxJbtidbVlBlN7WVE0uWGnSRpFFmCDtmH5HQ38zveud4MdhUpsYTSo8VM/ERlm0E6eNTLZkVZqeziCJGQ8OpbxRW3Vfc8Av3LWaXMe55tYci13DpRvs1WPfCoa6vNheM4xx1ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPUqRfr+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF25FC4CEF2;
	Mon,  5 May 2025 22:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483914;
	bh=7M0ewxZaxFv2r+GXywCow44b2DNjiU/QRAvFkCrH91M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MPUqRfr+RPJM2FXj8mqFzdd0kKOW/RWR451RwDhsh0Bbos0FrSZS7WdjbFMJXtSFI
	 tzN8FvHoAFLsbdC/ZR1hhbFlw6qL0E90G/WwqHRbmI3FIOH399ZJaLAMCb7U+hDXh7
	 /3zdgXgUtTXEHTlOyIcRbS4VuZiYSRVVCpHcaZR6CmEgcWkUtokDbaD2haw63ha5dY
	 lut0P52W0+qaVVhcBndOdq1+fHnlxJrmFCWYD/+bx8Xtk/cUVn3nZJZ4fkVjnWFbPd
	 ZDk/yrcJ7t+3VK/0W9x6/yor5cxwvZQrXonwBA/Lk/MzQLR8mP1mQAB3DAwUvnOVsj
	 62TFn6hg09BEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yi Liu <yi.l.liu@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	joro@8bytes.org,
	will@kernel.org,
	shuah@kernel.org,
	iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 266/642] iommufd: Disallow allocating nested parent domain with fault ID
Date: Mon,  5 May 2025 18:08:02 -0400
Message-Id: <20250505221419.2672473-266-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Yi Liu <yi.l.liu@intel.com>

[ Upstream commit 1062d81086156e42878d701b816d2f368b53a77c ]

Allocating a domain with a fault ID indicates that the domain is faultable.
However, there is a gap for the nested parent domain to support PRI. Some
hardware lacks the capability to distinguish whether PRI occurs at stage 1
or stage 2. This limitation may require software-based page table walking
to resolve. Since no in-tree IOMMU driver currently supports this
functionality, it is disallowed. For more details, refer to the related
discussion at [1].

[1] https://lore.kernel.org/linux-iommu/bd1655c6-8b2f-4cfa-adb1-badc00d01811@intel.com/

Link: https://patch.msgid.link/r/20250226104012.82079-1-yi.l.liu@intel.com
Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iommufd/hw_pagetable.c    | 3 +++
 tools/testing/selftests/iommu/iommufd.c | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 598be26a14e28..9b5b0b8522299 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -126,6 +126,9 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	if ((flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING) &&
 	    !device_iommu_capable(idev->dev, IOMMU_CAP_DIRTY_TRACKING))
 		return ERR_PTR(-EOPNOTSUPP);
+	if ((flags & IOMMU_HWPT_FAULT_ID_VALID) &&
+	    (flags & IOMMU_HWPT_ALLOC_NEST_PARENT))
+		return ERR_PTR(-EOPNOTSUPP);
 
 	hwpt_paging = __iommufd_object_alloc(
 		ictx, hwpt_paging, IOMMUFD_OBJ_HWPT_PAGING, common.obj);
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index a1b2b657999dc..618c03bb6509b 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -439,6 +439,10 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
 				    &test_hwpt_id);
 		test_err_hwpt_alloc(EINVAL, self->device_id, self->device_id, 0,
 				    &test_hwpt_id);
+		test_err_hwpt_alloc(EOPNOTSUPP, self->device_id, self->ioas_id,
+				    IOMMU_HWPT_ALLOC_NEST_PARENT |
+						IOMMU_HWPT_FAULT_ID_VALID,
+				    &test_hwpt_id);
 
 		test_cmd_hwpt_alloc(self->device_id, self->ioas_id,
 				    IOMMU_HWPT_ALLOC_NEST_PARENT,
-- 
2.39.5


