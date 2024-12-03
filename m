Return-Path: <linux-kselftest+bounces-22724-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8739E152B
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 09:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20266280CA9
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 08:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824561DE3B9;
	Tue,  3 Dec 2024 08:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M9W3brKK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2085.outbound.protection.outlook.com [40.107.96.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE93B1ABEB1;
	Tue,  3 Dec 2024 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733213021; cv=fail; b=WwbeuI3TROo+wDAgeCYVH+5C14Gekez2W8nX5y03KVsa4TxJQ9z0ytTpVyYfcKDR2LBzbzifah41Jotp++FV/tH3LvSHWiQrPY9cJFqa31bQDGC8KAWXa59+RxHgIPOZorPpim2mIK3XxigYsQye3KqBe+Adj99q1Ciqmpz628A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733213021; c=relaxed/simple;
	bh=g3nIx4+rr6mKGBrXqx0YloJwBrkWVmK5ryHkucHYRkM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YU7XvussCosVOptv8Q7yCmOcbY1+275h/hsLl3j88YVVT8tP8pYyUnIJmrGITk9SmUmofbqQGB+D5vdoDBbuvBO2+B/AUwvSohggJHSM4/b2Qc9Bm+ZjUsq1ufbpNu3wtaxT/ybc/OQPPmXyfQeju4IlXnCyiKVLUGQNYUbr89c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M9W3brKK; arc=fail smtp.client-ip=40.107.96.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bScEUhw0elKsFtQp+nG9ytRx9ujMu41GzqtatVoTVHJan0NYI93gPO3sRMvqS/iPfq7FvTOK7j1pB5AeBVCaMdnjNT4WgGIskKFICpvh4nhN1KbcqbTWXzxKtkCMO9nvXn10hudANKMgb5CQqRdLUS/8sibd+WlokPXykhoHiAMAWRwlvpSeSFAXIkv7esTNoRtufMjSLHl/mBpDKrXwBV5FmZHr2dYnrubGAOFDyukWpCOmJXtgyQV7hQQwYpeXUpGNQWkgTTg4Uvq+UR8jjPHqxUMLcDwP3GrQU4x98ylZkHkHl5TzeF6tKA5SbJmgqjk/ftqGsIyodgDjC4FHLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4qvIX15P3JgQce1dvfFJISn5kBMiPlrBwIJItemK1E=;
 b=gFSDgPBf6CWxL/vdpaOGO8MOyfDUK/5rWVszJmf5pXFQylDq8qvMK4JMWh+A2dclLsoIpXjOk5z2z1YBFKlCSVU3fdpe+QxCArcp4TsPLkmnBUOMqLh2catnmqKrQnv45ayQYd/oIkcRfZVBV/MvuxiX7gNxVRhQgmTwtm7KhvbPg0YBZH0HEF34CK39F0cYowbyRtPKfVb5NW84WhRMLX1O7Fl8lXW/aw8FSYte8pWTzlAewxihD7SxZkPHgkU0iFqRlhIWryuneQFzMre0sRZvJ+oNzB4K44tExZL1GWFvQ+tUACD/WG/3QQUSrKrgdGet/oLM3qXSLR+S/bzxgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4qvIX15P3JgQce1dvfFJISn5kBMiPlrBwIJItemK1E=;
 b=M9W3brKK8FM4yIoA/1DrDd4bd3+GZDFjdIva+6Z6UXXw3FWg+y2LgDLMMj/uWy4UjMb0xF5DHygEZHd+pJ624A4vXggFJ+03ICy45Z3aBCnzsgdiq6jw3vBs7vZ4OSgEjSpq5z7vMsM71bwWkwPK4w81uyvTcsU0dmFazJEPsEtl3CitK50APBs62bW2VdXxz1Oxzhn9JZYg6/NOVjDh7CnoEOyv8s06F/GnNlMm/puN3laSl2JL2TobuaqoaZsT7Zh0Be6RmWwUW62RHLBQbXs0UL/p4uLdKVHHqul1AUxuE4Hx6AgSfY8GfRLF7gxVnt9W0+jd3jlPwF05m7XqtA==
Received: from MW3PR06CA0021.namprd06.prod.outlook.com (2603:10b6:303:2a::26)
 by DS7PR12MB8419.namprd12.prod.outlook.com (2603:10b6:8:e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 08:03:35 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:303:2a:cafe::11) by MW3PR06CA0021.outlook.office365.com
 (2603:10b6:303:2a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Tue,
 3 Dec 2024 08:03:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 08:03:34 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 00:03:19 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 00:03:19 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Dec 2024 00:03:18 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<shuah@kernel.org>
Subject: [PATCH v1 1/2] iommufd/fault: Fix out_fput in iommufd_fault_alloc()
Date: Tue, 3 Dec 2024 00:02:54 -0800
Message-ID: <b5651beb3a6b1adeef26fffac24607353bf67ba1.1733212723.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733212723.git.nicolinc@nvidia.com>
References: <cover.1733212723.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|DS7PR12MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: 956a9112-119e-4e6b-99eb-08dd1370fc96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9EbnFAp9X+ERbGmXgBHJe/ufeVl/tGHx1rALMKVDaVtTBkbpKBbsKGDImUrY?=
 =?us-ascii?Q?LD/7jlBg/NMFUmDoMRSCAYYWvM+SvZh6j6tohOwsBHT51Vn/KJRZyPOwl3Ox?=
 =?us-ascii?Q?DJQHpMBoLJA3InwQk9EN3X+mn2Ws7VIPSNCE9W9fKFiToizEYsggFWXcq26R?=
 =?us-ascii?Q?7q6ivnJPnSjUJAmOIOjEUu94KpX7JP8NfsCnJ72nlkxOr3V02zE5+/V27y5U?=
 =?us-ascii?Q?WYjyQ3/32Rdfxaok9ARjg3fDMlFvowSQkB5q6bTWh5TCLalULCtM53cDCGkQ?=
 =?us-ascii?Q?77i9LtDi97wvuX9BBHsEhJeeQ0l+sik7wS/4NYhFXySuix//4iEhg+waDL/A?=
 =?us-ascii?Q?iZmpK89pOhWrSOqysjNzV4WdO4Q4nFcsYRn6U39ClZX16N7I5+f/krqFXhnq?=
 =?us-ascii?Q?lK8nJnWzDH0+4wNVQPLwphAB4Q6eIBUD6Kzy4b1m7Ix+yeAPv3O4trNlax2p?=
 =?us-ascii?Q?Z70xPir6Q8xq21MUePH8RF/oeOmGZhZ6P9a/UPhoFMsZ8TEpRByVQCMpCN64?=
 =?us-ascii?Q?dtjpi8XyWP/nn9RPdKvLdIC+XeksM7bPeXnI9905XYdEu8QQDTqdi3uVe4+t?=
 =?us-ascii?Q?oIEnwYPwdQ6e+pDl6CFYypQPNmme0HXJslXFLk3vLdjTfWr4B8gs1Lx2PCWc?=
 =?us-ascii?Q?t1gE0wma7Omj8jvvfGL2lcvsYDsE3cXqI3DUe9xm0QMOtPPBMjCijn229nLo?=
 =?us-ascii?Q?hdy2s+dAAsFp3RZMzF+jUBpssHnto9xgJPO5Ga4idcukBm+AcivTLNuZ7Buv?=
 =?us-ascii?Q?WredrMlZb9/rIWhbBsx7keGEFSU4IvpLNsXiS2eSWDAuqUsAqRQIv66K6XBE?=
 =?us-ascii?Q?qhhYL2Tj0nc6KNuLrhplnIFk5k37l+6lEa/zT5y/LesvpyoyHA7IK5lw7oJh?=
 =?us-ascii?Q?qXbnZq2Ag6ar2bqYeAdmcBu2HTXJK1UZEHBvOSLHkhDjl6GKxzJ/iDAREOPo?=
 =?us-ascii?Q?fQd6f6Ng6V0ZrltQJuQQpw+5ZJjOh+S0+M5bUU2AiZiPd6aRAbuv494ulu8K?=
 =?us-ascii?Q?R3OT4IjKiypqS9DUK+5O/weaRoeFZMOnBTHePw9v/lAfx0U2t3nWxb8BDL5p?=
 =?us-ascii?Q?5hMLNfbQtZ/zesXnDzDATxJQ9Jk1Tc0Fq1iA0X1eKBqDeygknrVPrFvtVSEe?=
 =?us-ascii?Q?ZlP/Oqc/p+BGQen7B8QCuV4Ehl27uh2on/C00p08TgqOffz9qPRNQi3eORMu?=
 =?us-ascii?Q?cDCFHOl+zPbdcq9GTF/RHiTeicMlZuhK457PzeWCBIO4CYCFn6u6N3Ai30H+?=
 =?us-ascii?Q?NyKMTugXVkLqtX0lTQ5ad3k8AHbq5WUsKIwWsun6IFqsbX0cybgnDnV5zdFT?=
 =?us-ascii?Q?yYurcOMUKIaQ/DYFgf8Rsr9MO8RFQHJGw8KRgNOvLngSzzJaXboEqFATkvED?=
 =?us-ascii?Q?sRz+PH7Ad7ytxirzEF9Fs3y8iQ6pB78AVfkH0BzoAq121wMqJ6ZsKsAuanT/?=
 =?us-ascii?Q?ecaTP+bSsHzru7Wv/xtqrnQSsJsFNtDy?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 08:03:34.9596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 956a9112-119e-4e6b-99eb-08dd1370fc96
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8419

As fput() calls the file->f_op->release op, where fault obj and ictx are
getting released, there is no need to release these two after fput() one
more time, which would result in imbalanced refcounts:
  refcount_t: decrement hit 0; leaking memory.
  WARNING: CPU: 48 PID: 2369 at lib/refcount.c:31 refcount_warn_saturate+0x60/0x230
  Call trace:
   refcount_warn_saturate+0x60/0x230 (P)
   refcount_warn_saturate+0x60/0x230 (L)
   iommufd_fault_fops_release+0x9c/0xe0 [iommufd]
  ...
  VFS: Close: file count is 0 (f_op=iommufd_fops [iommufd])
  WARNING: CPU: 48 PID: 2369 at fs/open.c:1507 filp_flush+0x3c/0xf0
  Call trace:
   filp_flush+0x3c/0xf0 (P)
   filp_flush+0x3c/0xf0 (L)
   __arm64_sys_close+0x34/0x98
  ...
  imbalanced put on file reference count
  WARNING: CPU: 48 PID: 2369 at fs/file.c:74 __file_ref_put+0x100/0x138
  Call trace:
   __file_ref_put+0x100/0x138 (P)
   __file_ref_put+0x100/0x138 (L)
   __fput_sync+0x4c/0xd0

Drop those two lines to fix the warnings above.

Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/fault.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 053b0e30f55a..1fe804e28a86 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -420,8 +420,6 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 	put_unused_fd(fdno);
 out_fput:
 	fput(filep);
-	refcount_dec(&fault->obj.users);
-	iommufd_ctx_put(fault->ictx);
 out_abort:
 	iommufd_object_abort_and_destroy(ucmd->ictx, &fault->obj);
 
-- 
2.43.0


