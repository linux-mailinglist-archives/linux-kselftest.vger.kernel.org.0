Return-Path: <linux-kselftest+bounces-46257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F69C7AAB0
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 16:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 65B3036354B
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 15:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46AC350A19;
	Fri, 21 Nov 2025 15:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a2/Cj54F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39A534F487;
	Fri, 21 Nov 2025 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763740291; cv=fail; b=D4qiS2dcGFK3uFSVZpQG0mHLqXxFVSUUvnqHFBxevX7J7q4wlbTGaNMvjCcdYjqAyqWYc8PyOxW+vWYzMom2zBIfiniAPRerby0lri6hfC6/k/S2498k2VC4OuE/dVTXQSiIc8KDvf2hm9eRI4G+s7MBbQDKdO8bhQ3Q9oE0iNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763740291; c=relaxed/simple;
	bh=qhFDAgLt00OmZuTl2AMKD1cOV7ISqm0n4TZqlQuj+Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ULL8ImI/IakImRiwpfayzvCPfQzQmRD6O1x/0bWNitpcLz/lIIuW3tYaqIJ+Gln0vWEiwb/U1PVURjXpa7Se0lqkph20AzH8ZWCP8LJRC3561RrOF1yM+QeNOEi0LTLIro1sHKmkDCJIEe9oVp6ACrq35nMf6RwiTvZG6wr0bC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a2/Cj54F; arc=fail smtp.client-ip=52.101.52.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0Fa6KiIcdyjnJCoE8S25BL6Q3pVNXypExX8D6F3Nmpgo0wZr+2D+8vSdTpeXaP0D5TNbeZcg+j4a9BV4yOfd0idCn+PoFzVI3bv3jcygvi/IgE/W2fISCiFGGbvpvx8+Xp8LRFFxzPhEWajYUEhv55FVWMdHIH++OYf2CYPUTlJlQqpXPgJwSCpivlMrwWE4RFAFLTg1nzc+YRhtYPnUy5GzaDdleILw2RhBXZaSMhI9HARr3Oa8+uPNT0Tjanhc6qIB7tTq1l7ec5nu/TviR0PDxBMGy9NWuT5kuEPXwHsGJPLGzwvv9O1vAqXTmmDeoiVC68aBwETns5ArhYB0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laX0qkpAABKLh4Yd2eblpgnAOux+u3A9FJf582iLN+o=;
 b=tw0iJvmZesN0rBZXFjHD2AOaOCPr+cGBRCn5yR8+0gRW0y1E/5DK1XCI+1V9ylPCB1FZNDbPSuNQbA5S3TIE4AXKRKfW8sJvuzmRzlD6g991GRQnY66zktuCABkjah5U7QM4IJ0vYaSU3Hio4tIvghRYPDFu55VThY+G+rpPiudtWmFgY0jv9OXLTyBryPCvkp2RJKCcIRXx2Iq0vJiLsw8y8ciW0doaU6MieQ7SbN5Bi7VBAXIKF/X1nu4rYaa70mxBlroYJD4uksbguk9Ulz5R14it06tKPsML/G0rhDBP0XJ0RHX2JaP5ihVCkuFgjQOcGWhA8iO9EHgW8Kmmqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laX0qkpAABKLh4Yd2eblpgnAOux+u3A9FJf582iLN+o=;
 b=a2/Cj54FqfIIit2xrw0iivV6XQGCfYHluxH6D33k7OBQ/YrveVhXQjQj/sdZqgrjSefQmB9kO0EKjcTbFGImklo9bdvbK0wOc4RSPm+vMpZNYeEIhKWdEKBbGCXev/xH59G3yi23QlAinXwFDITydpcMa3B9RJnggdeOIfSXVZZf6NFf3CDi0dpWgH+ZowOKWwTA89U3BRU5xXs36JfBcb6x4/E6PUc/cTyHVFve1oHqF6gtqWkn7nd3vW01MYqH6h8yFuN0bK2cw4eowbLFZlj/hD3WVaJ4Djs/96oz1tQmwtNoYGmZBdpV+QL36e9W4h+vpU0Kz21uIo59SFYEMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DS0PR12MB6439.namprd12.prod.outlook.com (2603:10b6:8:c9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.15; Fri, 21 Nov 2025 15:51:13 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 15:51:12 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	=?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	kvm@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Will Deacon <will@kernel.org>
Cc: Kevin Tian <kevin.tian@intel.com>,
	Krishnakant Jaju <kjaju@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Matt Ochs <mochs@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	patches@lists.linux.dev,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH v2 8/9] iommufd: Accept a DMABUF through IOMMU_IOAS_MAP_FILE
Date: Fri, 21 Nov 2025 11:51:05 -0400
Message-ID: <8-v2-b2c110338e3f+5c2-iommufd_dmabuf_jgg@nvidia.com>
In-Reply-To: <0-v2-b2c110338e3f+5c2-iommufd_dmabuf_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0194.namprd13.prod.outlook.com
 (2603:10b6:208:2be::19) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DS0PR12MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: e6c59537-c008-4951-0292-08de2915c9e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uv077FIqBDi4mcQtD3/gq9NeCzyB8vr2GV++kHrGO22lnAgVFrNOuqpn1Mfy?=
 =?us-ascii?Q?JcQIAkJc/NvTdJqxyhUQ9F/uwiygXpOY1NmZWZJEgeMrd2vsMdlssgASLnfZ?=
 =?us-ascii?Q?QIN9Z/0FmHuq6todV3QGM1ajMEMhKUe7i55A1tROP0QfgYCH/IrXEyzCxWuF?=
 =?us-ascii?Q?aQFomVXLD51YsxJa6zSFxra0rWFUUf9bIR0U38jEOhw6LI6ZAcxQhbxCESVC?=
 =?us-ascii?Q?2kF3tsuJ/k4miyonKztSVY0TIz0r6qR/oyjlba4gemGuNQwspGCuwXeoFpJS?=
 =?us-ascii?Q?zTm+TNdK7wXgi9vTs2DadMcUUlKgH7KaI/B6N1/zWyR/U9k+pbc6mY4Fnywq?=
 =?us-ascii?Q?YmUMNHTxrfoI+Y9LJhQyKxXpbPH4URXp+6nzcJjbUprlBlUGEzEB0ZAZaknh?=
 =?us-ascii?Q?V2eE+tj1V6vrAmSTgnhQJ14XNJROIw/3fqI1WFouyqSs5fjmTXm5gdw7eozV?=
 =?us-ascii?Q?CQp1ceOPBsVeFEaWa2UL10/COXJjQtCkYcuLJztEzARwnRTJSKDykT8m361X?=
 =?us-ascii?Q?HJP+Wcp8aKLd8d1Z6ysb5t9Q3Tm9nrc7UyYroG1Gz9sHmLZlSAF8PQW9KH1N?=
 =?us-ascii?Q?Kiy8DeoYxWzKS8OAjagboJTVutJu4I67lgLbiyHt0eIvpbS4TvSDTcWCAzIk?=
 =?us-ascii?Q?iM3bBAG0xP5Wbm4RWX2jRm18cnczPAnRtzIGx+BtCEo4bUFDBVL7hBgewnCL?=
 =?us-ascii?Q?R38cdVWduUZp3QLJ8XJjHTG7bLbPAMxKcw19EqdDVHUcwzheHxSYyWM8q5wN?=
 =?us-ascii?Q?yllRBTdODJFTHfz/iYZzLOCNzIkPEOPw19gLAzgDrRE38aurosMBdiV5jnlz?=
 =?us-ascii?Q?su2Ic2aykyqa3pXv2SJLI+NnF8Ep+NVH958sSnHfnbKca4uFP2N2trA/xOlP?=
 =?us-ascii?Q?OE109V+XIpTecpQ9J6i9U0p7qJS197kwV1UVlWPJULqjbF7ZeANUrF9Qc5+w?=
 =?us-ascii?Q?T5qvdXqSAONeoc8eX9DqMjTjtpaxSHzm39TYfQfZxnqvIvcqd5iJIsA0GOhW?=
 =?us-ascii?Q?qStFrRVvCnOGZ5RajADdPRNjYdjfk3L0MFMrqTXwdzIbL+dMpAtQhbPD7DDW?=
 =?us-ascii?Q?ZWhlnlAcGBVnIfao59zzcfIkSdD4kXKj/zsGXOW6G18ExuFroNteewOs2+HT?=
 =?us-ascii?Q?fTuVJ9v5otD54eHK5WgZlaNBnmfy8mrHemK8NLwt2A8GXAEFdlCv0mZgDyJ4?=
 =?us-ascii?Q?GPChJjq+HSWupAvXqHih72mcmZjQ74RJoyPPvtrowQPmovNQQ0vKuBppHZ3S?=
 =?us-ascii?Q?sAJkAF01kxC9HoGjW36ELkcmg7eOgni+aLF5gcdnIVc0i8J2ltivNp2wfdjZ?=
 =?us-ascii?Q?tpQSg+6Ai7cUymvb4pf+v9Zdg6JTiEWVvNrUfQamGZ1X4Nd0MDhP1MX4K2SL?=
 =?us-ascii?Q?fQtskbIqmyHDbs1HV84LKx7TX10lRgxGnpRyz7ICPn1cYOCDiOE3080/Q4vd?=
 =?us-ascii?Q?pDqBQP1sRPMS9TFX8jILP/nBJfIa0PUTpYFUIGPUQPfQnvJkXTOkNUEWr9kL?=
 =?us-ascii?Q?WEZMUqzz7aYc5D8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?In/PC5QSPQlNWWyXd4U8FGiyOKaM4AAfskoS7//hqMhg3o+q7Wk8M8ijbrJA?=
 =?us-ascii?Q?ZYuP+Qb0/g7Lln7deTJgXoVnS49ikK33PiVyjyAt/aAcDpGVkrC+QgTTcRRl?=
 =?us-ascii?Q?pvOxnTOv720wRITK0GSGXU5xJVdtoo17LhAt6B8vMLKfvQljU2nLhgZT44zN?=
 =?us-ascii?Q?9NPMhog6bkZ5MSJ0uTgT/iOYNawy7rYczO1oFRf9+LoAMzdX5lNS3AeMpcZ6?=
 =?us-ascii?Q?P/WHjfHWn9ZtGNN7MuTyj7KfcNHESknp4b4hJ9ku3VlAwCLu0ifxv+sTDigS?=
 =?us-ascii?Q?nfCH56mfs6K/A1k7s0rP1usNnFEUmZu8Y8PdUcWf1b6meNEmk/r+5v0CXuW2?=
 =?us-ascii?Q?p4q8GXcge5OBq8mI/+1JfWAkRDADUMVAFLQ7a8cFK+CiIohwIJApA56qobUT?=
 =?us-ascii?Q?6qGO9l2xIK3AZHgjUJQSgZH/eFOwVdPeF8O0o77VG9GReqHbywRtzzTcwEYp?=
 =?us-ascii?Q?FYqQhRWdfYxz4+MM4KCF5WR07THKlkM+q3SnxXsZoLQvUrRwMGoYTmu5cc3a?=
 =?us-ascii?Q?rIhbQyyP2jCf3mgeVH8Mfejsb+vAJXWAK0edEyCRp2sIL4fGcl41L39t2551?=
 =?us-ascii?Q?sfWX80gGQExZFRlIE4J7ylEuMSak9E4m4pQxihuObFfZxOJG7vQoeqStvDA4?=
 =?us-ascii?Q?mmSs1bfSfnKgqgQ7/7aQhi3X0lYperf+Pjgp2gTyT1lAqIFOtfrAhLQhAXmH?=
 =?us-ascii?Q?XPIGB3b7ME4tCBTmSQa78fjU4RY0+RXVvBEa+I9UT2Vu0D/Z2z5jWbNY/aZJ?=
 =?us-ascii?Q?j6r+N3dsM9qWc1tZw/dyRVUg5EyQStqkwW7L1bYO4AvQZxK+BdHHWET60mka?=
 =?us-ascii?Q?FJYw1qkRWU9FLbiXGsieQGeexL82r7dL+Zl4Psytrs94OgbPFtX70eKHHRSc?=
 =?us-ascii?Q?cBj8j8CNhj2UHlg7AcuOkcKlKRqZ1ZP2ZK1ETfqXjADVokTdBgsB3HFFXv9w?=
 =?us-ascii?Q?vZG7RlSbRmat+bzNM8gIt/O0UhXbrfGhX0NvLCLN1o5dt1hgUbMnaXyTXf8c?=
 =?us-ascii?Q?yg5DkUuDnGPbpi7PY2VpjnHuqam5x2pGGXU5M1mCCv0duP7cWyC6SvS3sygW?=
 =?us-ascii?Q?iz0lLNLtWsFpjUOQNKcu3mo3IPZM5WZHGCeTDisrsoGmROFieGi0a5awCxaG?=
 =?us-ascii?Q?VgrspQh4IxQkPvHpTtoiRXVDY5hazQfdG5g/mWYY+5BbOGAcG+uWtOhD/Bp7?=
 =?us-ascii?Q?++EVZtRv0xvash7a7DaInLCqNyfWm4Mcju5pL+raWw2HwEWke2HecS0ue3hJ?=
 =?us-ascii?Q?11omSKo/l0bNLmAMu/XYPZ0SctSlFmnt63xoLPAorIC15OFK6n6A4ADpD4g+?=
 =?us-ascii?Q?R2gV9PyjYgNLRjFsc5V+rI30dyvGlkg6zY0wOmRPpcva3lGaxpqdWuDTQVPO?=
 =?us-ascii?Q?SUMZOd/e7pXhc309xdggs+XHOogU8sUMrIeQIlkWCO3yuJTatmDwVoRFzbA3?=
 =?us-ascii?Q?CQL0C/kqr4hgMV4PoPbPIabibdpTizKUR8C7D7eJ9fm/mykXuz/9yX9rCHC2?=
 =?us-ascii?Q?6yzv3gZb8CjMkP1OO9yALDKKXUUM6+Y2FHd0MnsWFIWFUITdNutEy7hiQZ93?=
 =?us-ascii?Q?pgO+QmcHarb82+nNPrE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c59537-c008-4951-0292-08de2915c9e9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 15:51:09.2784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0HBVxN8v7Tv1DRext7vkNbTR/HCC9kyQ22Raeu+oSXyewHgS5GkMGZD2yTHu1AF7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6439

Finally call iopt_alloc_dmabuf_pages() if the user passed in a DMABUF
through IOMMU_IOAS_MAP_FILE. This makes the feature visible to userspace.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.c | 43 +++++++++++++++++++++-------
 drivers/iommu/iommufd/io_pagetable.h |  4 ++-
 drivers/iommu/iommufd/pages.c        | 13 ++++-----
 3 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 0bf6ca77888c0f..44a0a7c79388d8 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -8,6 +8,7 @@
  * The datastructure uses the iopt_pages to optimize the storage of the PFNs
  * between the domains and xarray.
  */
+#include <linux/dma-buf.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/file.h>
@@ -484,19 +485,41 @@ int iopt_map_file_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
 			unsigned int flags)
 {
 	struct iopt_pages *pages;
-	struct file *file;
+	struct dma_buf *dmabuf;
+	unsigned long start_byte;
+	unsigned long last;
 
-	file = fget(fd);
-	if (!file)
-		return -EBADF;
+	if (!length)
+		return -EINVAL;
+	if (check_add_overflow(start, length - 1, &last))
+		return -EOVERFLOW;
+
+	start_byte = start - ALIGN_DOWN(start, PAGE_SIZE);
+	dmabuf = dma_buf_get(fd);
+	if (!IS_ERR(dmabuf)) {
+		pages = iopt_alloc_dmabuf_pages(ictx, dmabuf, start_byte, start,
+						length,
+						iommu_prot & IOMMU_WRITE);
+		if (IS_ERR(pages)) {
+			dma_buf_put(dmabuf);
+			return PTR_ERR(pages);
+		}
+	} else {
+		struct file *file;
+
+		file = fget(fd);
+		if (!file)
+			return -EBADF;
+
+		pages = iopt_alloc_file_pages(file, start_byte, start, length,
+					      iommu_prot & IOMMU_WRITE);
+		fput(file);
+		if (IS_ERR(pages))
+			return PTR_ERR(pages);
+	}
 
-	pages = iopt_alloc_file_pages(file, start, length,
-				      iommu_prot & IOMMU_WRITE);
-	fput(file);
-	if (IS_ERR(pages))
-		return PTR_ERR(pages);
 	return iopt_map_common(ictx, iopt, pages, iova, length,
-			       start - pages->start, iommu_prot, flags);
+			       start_byte, iommu_prot, flags);
 }
 
 struct iova_bitmap_fn_arg {
diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index 8f8d583e024376..14cd052fd3204e 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -265,7 +265,9 @@ static inline bool iopt_dmabuf_revoked(struct iopt_pages *pages)
 
 struct iopt_pages *iopt_alloc_user_pages(void __user *uptr,
 					 unsigned long length, bool writable);
-struct iopt_pages *iopt_alloc_file_pages(struct file *file, unsigned long start,
+struct iopt_pages *iopt_alloc_file_pages(struct file *file,
+					 unsigned long start_byte,
+					 unsigned long start,
 					 unsigned long length, bool writable);
 struct iopt_pages *iopt_alloc_dmabuf_pages(struct iommufd_ctx *ictx,
 					   struct dma_buf *dmabuf,
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index a2574eabb93df1..c73456833d04d6 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1413,22 +1413,19 @@ struct iopt_pages *iopt_alloc_user_pages(void __user *uptr,
 	return pages;
 }
 
-struct iopt_pages *iopt_alloc_file_pages(struct file *file, unsigned long start,
+struct iopt_pages *iopt_alloc_file_pages(struct file *file,
+					 unsigned long start_byte,
+					 unsigned long start,
 					 unsigned long length, bool writable)
 
 {
 	struct iopt_pages *pages;
-	unsigned long start_down = ALIGN_DOWN(start, PAGE_SIZE);
-	unsigned long end;
 
-	if (length && check_add_overflow(start, length - 1, &end))
-		return ERR_PTR(-EOVERFLOW);
-
-	pages = iopt_alloc_pages(start - start_down, length, writable);
+	pages = iopt_alloc_pages(start_byte, length, writable);
 	if (IS_ERR(pages))
 		return pages;
 	pages->file = get_file(file);
-	pages->start = start_down;
+	pages->start = start - start_byte;
 	pages->type = IOPT_ADDRESS_FILE;
 	return pages;
 }
-- 
2.43.0


