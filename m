Return-Path: <linux-kselftest+bounces-32452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9391AAAE53
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 04:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758A11892EFB
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 02:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738802D9969;
	Mon,  5 May 2025 22:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QalquyuA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE412D2CC9;
	Mon,  5 May 2025 22:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485206; cv=none; b=pA76rv9dkYPsizr51AtO5EZPSaSJE1M5RBwe9eCupFusJ2WAfCEMEudFbEzFgZaCfSotKTEnl9BVec1Lohu4JGBj2KjCljw35uOZEwkpDKhHHN05eoWQlgDrkJRBYShRQxFnIY9hxcSWPkj1rev9MjM802Osm1jFiiKGnh2Edxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485206; c=relaxed/simple;
	bh=A0ECZnMUiWeftCsE+nQ185HOPp6CNE6a+R7ANaPy6sU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BEvSExaxxG1n8UreNb4mj+d2oPfyoaAzmmdF9OhU0GNhw2mwdjdvNwy++Bh7OgThgjnHdE6gUhwmEgLsHvHZxMHRLfVlUpHhTf69fybqSG2d33TWb3SmSCPYdH4tYeDcjvNEXvIrrx6RTXz5+T6ddcZn+0Z2Pepoyaij9G89W4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QalquyuA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4B2C4CEE4;
	Mon,  5 May 2025 22:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485205;
	bh=A0ECZnMUiWeftCsE+nQ185HOPp6CNE6a+R7ANaPy6sU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QalquyuABOySdnx91yUpYAV6m2Ul8hiZ9qjxuEHr1uvY2C9l121LEHj00g/cdDOkn
	 A7E/JRdQb2iGgv0YTcVNGZXxYu6L003olNmu6VGVoGSlfxZHO4cMQeH44VHugkYN/5
	 YHsGIdA06eIAtaGxcxG08BzrbjKgTl7ARPOxiGJzqqRwEN2mvhHYxFpVdQfVfrFvU5
	 jzSrjkG3vZcmXdtTKKwTgv6U/7V9k9dOk1/Yy4mkmPlA+xTuzFPqkl6QGNXFuTfWTX
	 yWiPNa8xn4RZnYYMGTDUd9tuc3rJJaKgYtdcfcuKB3rESPxgK8LbU3b1GmVM/2nLfo
	 DAz+XhysCFoRw==
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
Subject: [PATCH AUTOSEL 6.12 210/486] iommufd: Disallow allocating nested parent domain with fault ID
Date: Mon,  5 May 2025 18:34:46 -0400
Message-Id: <20250505223922.2682012-210-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index d06bf6e6c19fd..2454627a8b61b 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -122,6 +122,9 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	if ((flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING) &&
 	    !device_iommu_capable(idev->dev, IOMMU_CAP_DIRTY_TRACKING))
 		return ERR_PTR(-EOPNOTSUPP);
+	if ((flags & IOMMU_HWPT_FAULT_ID_VALID) &&
+	    (flags & IOMMU_HWPT_ALLOC_NEST_PARENT))
+		return ERR_PTR(-EOPNOTSUPP);
 
 	hwpt_paging = __iommufd_object_alloc(
 		ictx, hwpt_paging, IOMMUFD_OBJ_HWPT_PAGING, common.obj);
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 4927b9add5add..06f252733660a 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -289,6 +289,10 @@ TEST_F(iommufd_ioas, alloc_hwpt_nested)
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


