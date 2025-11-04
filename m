Return-Path: <linux-kselftest+bounces-44731-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B607C329B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 19:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A536546847E
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 18:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212AD341648;
	Tue,  4 Nov 2025 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P6PZFG9h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010044.outbound.protection.outlook.com [52.101.85.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343F933FE03
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Nov 2025 18:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279915; cv=fail; b=mzwENlrU8Ilzg0DHnVm+kwxU9dvzEesw35g6jIGRLoDM22UyWCYYOINIICtqTcxZPjzQa0NJ1u8RSNl7pMRKCICDNM5iYuqR9qIQkB4V7JLfz02tjAVs9ANuEExQU37ko8mFQlv3tkeVbGjyvLMxT5P4YHtQ2bLLhbzs+nvahtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279915; c=relaxed/simple;
	bh=j2Y8gSroBnmwdBKWDr/yQ2+r83/Cho3/bIUCKuxFot0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GH/iZvTIvz/jbIVjm6R1eRb6F0YcY1i+otiswQ8v5MhSFdswYeD0bb+sOJTx+/cr3X6TcRBolt488iE2EKvGbSvuMTzNJ7V3utAaJNujgJ2tQByrqKwkGcuGLbnp8NCztF45Z1G+dMjBtAkgD7TXHo5eeh9V+wiYBG9Qkp3uX1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P6PZFG9h; arc=fail smtp.client-ip=52.101.85.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYw5TOxwk+wnrhDUHi0DG4lrU+KzFAv+paX/4mZUCX4HyCDZ5hJXPzb0Nb5P82kx1e0zxv1w90TET5ga/9OstsOtwddtKCQ/wUiIeYWt8beGkMVo53b+xFz2SuC9AaXx2II614h9s2P1SN47i0azHNLHAy1RAHf1HFRPCCAtb51JYwyq/xIIr5SEwhK8cYgQPhOkRvNATOs6BS6alSDbTMO6zrPzuBoV2SF0QitJdzM9WnMvh77S6AMNzMrPI/jsPOg0/9tN1uFGfhry4H/R97FWMkU6uU8eh/sDV1XQEZoJ2VUjZh7y9TReYejYFLXaoOAeZMqprSm+rrdhf5Ry7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFX5/n2DpvzyWAyAaS4dLCx5xgqRLtsw8cg0nyUJA6I=;
 b=HsYKS0HLFrDcSW37d1LvS8zZgINMiVk2R+cyKMTQW+x4OggeZZL2f5P1wvS0LRyo2iL3ttau9wVphlDnLq/Lrn+NY9nssrcRoNGE2c3ASg338Tw5LV3CKgjnLkP2s8zln8BKx3crg7VYSWog6dc8yupiXG0XGDJfv6WmePsB9RcpNeTpPUzuj72dATu0ck1YklggPhjdqVsX6uBv4oP+iJjfUAguy7DKinf+hUl/aHaq7uvtSZF106p0M0egZwBfVVer0vw1wB+X/6kHio+g83H7T2EsYqOXpfnig84knr5CYDpPuaHTdKqMF3UJQWr1V6IYmTUztlm0shxNgB0CHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFX5/n2DpvzyWAyAaS4dLCx5xgqRLtsw8cg0nyUJA6I=;
 b=P6PZFG9h9Kdnq5Y2JQzc0+40+GL/ZkwMaT2MPLJOStSQ3AXItNXqdY127tUFqRL1ijiLGUdnwq89FJ4KKmQn9HFE9Nzw3P+Szyi4RU5ypD8nSElJtTkINZsbF/ruC2Ks/DjqE9Axc7a/kD7PATITDt/yyttCRvnM9Y0Tu+gTXlwZY5eDGm3wt9VYEpAfqrlhkZNUPBtLSyFvwqsLSBCWU3B7ZciXObtH9euZG/+K8bHK1slIIXJEqBUU5jSzALfHf32GOtF9obH2pbcszfJ98Eogz6znTjfClHaubpd6QxbOcsvKW7kalFp/wHaasA6d1wpgUOxXRMu4C/L9kjt9uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SA3PR12MB8802.namprd12.prod.outlook.com (2603:10b6:806:314::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 18:11:50 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 18:11:50 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-kselftest@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Will Deacon <will@kernel.org>
Cc: Alex Mastro <amastro@fb.com>,
	Eric Auger <eric.auger@redhat.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lixiao Yang <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	patches@lists.linux.dev,
	Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH iommufd] iommufd: Make vfio_compat's unmap succeed if the range is already empty
Date: Tue,  4 Nov 2025 14:11:49 -0400
Message-ID: <0-v1-76be45eff0be+5d-iommufd_unmap_compat_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0359.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::23) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SA3PR12MB8802:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ecaf354-3f37-4899-8391-08de1bcda002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5tjEl9QjySru/TbadoLunUcFyNk1yx8OneWmuPn7TCruBJYx0UZQCHbYXyw9?=
 =?us-ascii?Q?EBlXXB9yatgYXkr5HFWrbBpK5VUhOOxds4e8A44YrBfmfvkFo9DX9BjtTjHQ?=
 =?us-ascii?Q?YSNqEMOwLRnYoxrugCMoxqWwMroKou4H6z/fPdnl6Gb1prmmcle+GWxsR2Yh?=
 =?us-ascii?Q?YWprB5R+VchfBNmWubGDB4/YWa3sB5vyzrBvnqX6Fxt/QZ+/WSjNfgjV8JU9?=
 =?us-ascii?Q?Y/0LVL2LL+SGOoAuYYSnFqPKlZagVNM8sSldHd6PixvW76FIAVm9GYRLOBhm?=
 =?us-ascii?Q?6sGEwA/iFolLHA23CKjsRWe0TK+rwafWn1P968Lt6OyVMyZsGyLML3BpqN96?=
 =?us-ascii?Q?w+srJAmC5ZGkm3LsK4IiqDM71ZAED3toVBLTjZMzht7z6QrwZnmLsH1cyGso?=
 =?us-ascii?Q?19tGpgHtUefb7J7VW+1sTQTWqsUpCWG7IlFmeAwR9iNdzXEm4rka32Bx8EE/?=
 =?us-ascii?Q?1IzGAk/uMoA+g9eY1z9KkjvfJg1oeJAC/nkuZq713kmE5BjqIAVKJpEiLg1d?=
 =?us-ascii?Q?PEjJVb/cKcUots0g5VwZ8oHmSTVcvfIltocYidDIKgTX61/sKvSKJbNnp9J6?=
 =?us-ascii?Q?QSzpuMMnf01He/9JDK6i2J0mvvM13lyxweLd9eQIRkVH6VRgX9/gZiC5L2pA?=
 =?us-ascii?Q?RBykBswsix2N42zGb3EMZQkCkZmIIxTXs0d63wuTpDubaqwSv6ikVkf2ZIsp?=
 =?us-ascii?Q?0wBL1Rn/c9NVJXOxO8ya0U1LZ1FUk6qgR5LBIgwQDCchsGWMpxLfg3tsn8kc?=
 =?us-ascii?Q?EqhECMw9girr9Ch/eTXJvfNLyy+1zbDSdorKz+/IQAMHbVRo3iAUsk/Q+3c3?=
 =?us-ascii?Q?F0eqLx+ozTq8DIWgg1O2zIeQ4BAfe8Jlb5zEJzRvrz3rL9Rj0S6Jz5+AwdYW?=
 =?us-ascii?Q?3zk+hWZyfHZ2JAv5InYF/zKB5nF69Jho/dsLAfOQNcf49iW+ttEPCHjDczIR?=
 =?us-ascii?Q?kgeQvkMga7Cfn8CVpzzPTG7vav5nu0TAyhYtWLC4bxgbuJRip06ErfF+1B5C?=
 =?us-ascii?Q?LzMxhWAsobaR26YPvu6kAhvkDgNl2XnOQhtqe0zsD5NdagHekVlpIJbj24i3?=
 =?us-ascii?Q?fCd2YkvRYQwHqehLzkMzvLQH6WOiD8CCkr0XZMsjPUHLT/HItCOkkHqdUBsl?=
 =?us-ascii?Q?bRYOAUxzLeZuXFqd52OfeokqrbzWazo5ZhEPltLTX+CFvCBCsWquB0ZFdYhB?=
 =?us-ascii?Q?yvghEDKeOjXh+GYplVZ7QelR3CTVz7YDZIOymZ97ntkmAhm1I+ZEtcjQrl66?=
 =?us-ascii?Q?VtLSaHH75tzcuCyiOXW45Nn/2U/fL05LLuRqEihnX/rvNj62ubMm52+jo0V+?=
 =?us-ascii?Q?1j1MHzQAmrDF9znprMIFhLmNV1yhtsH7OBZFxArAEYjaZ+66wXaOj+YwJjsK?=
 =?us-ascii?Q?w6/2qViOy34rw1O4zq/Q0+LymJDWsihZKBky6sNMwEvccUwDdE6Rsk2GMdL7?=
 =?us-ascii?Q?Tt6nyvCFDKBMX9KwGTqMhi0RgmQ5zHr2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YgTnR8EY9VuI4+Ip/c+6oBNCPrGDukqo13hoMbx/kLUKMDBELQ8dA1LvXWZb?=
 =?us-ascii?Q?DOINqf/XTgh6LkQvCxx9B8nD3YW3UXp4b9WShVkASJtmCQ99B9EYaj9le6SB?=
 =?us-ascii?Q?ymp/sTNJzN7jspQF2eZHF61YHW/1Z8GxR981qrMIG+pxrvUkbLel1/tAGd5o?=
 =?us-ascii?Q?vIRX5mrqM9jDkoCk5NuGTE9PTlcfMkbfkW6PuDb3C7ROOmMLgQzF5TNoQW6Q?=
 =?us-ascii?Q?JGBEbrqRynlsGGbd92kU9yhrv9q/e/NG6U5fqsOxz0INugrz9iIsk2EbfCyX?=
 =?us-ascii?Q?fAjYUH728/srk4Ls6nTNUWtEsd8TSmHlZqrHmmq01k+nZqYe7iOMOeC2XEUe?=
 =?us-ascii?Q?9x2g1qkzyZAl/bDa8DbnD7BDW11J2yEDpxdLaal0ydAwIFEfPxAXV52+OnHO?=
 =?us-ascii?Q?PzRdhZ9L4ZOthqSUqLtDcoxNwjnXJ2qgcCfB4s8EtikMoa4jalKd1MsdY2Mz?=
 =?us-ascii?Q?vUzP9mQsau235Lx4yhZ/95Z+EYieshvZeUrkeZmHmEr1aky7chW+HSrgxhfn?=
 =?us-ascii?Q?CHpcI6rFFzi9NC3OzqxBLT+KvgZl/2+QEXClhlx+73dR0yqXfuwP3TI2u0mp?=
 =?us-ascii?Q?Ech3MG0Zwxz1A8GqT/5okKEzfLLS9EkYE9yYdPrUQtl3WCWr/JNy6cyAAbFo?=
 =?us-ascii?Q?e3ppjfdhzwWLsZiv/n88wP28EzepOHFOSyuczo86fAy+sj+RTpS1+TfxXqcH?=
 =?us-ascii?Q?1edXUATnp4FDheDgCQsAn9Nxf81i9CgqM4Hf1Px5KGmBRtx5+uLI24zy01vt?=
 =?us-ascii?Q?/N7WbpHDSsrA+MBvKhhirm0vBpJwbnk7cdoUak1TmTE+jPNGBvHpeqbXqISp?=
 =?us-ascii?Q?CJGA2S6NNbOUccnEET3FYzHH1/Tux7mzIOSHRpk9v29PXQQM9w3VHtGHIQ/k?=
 =?us-ascii?Q?b1MmYrVOeOu8/R7lmsBfP/L/7h2bzoqdVsZ5b4NrapMosAvHTXuv4zDF9QRo?=
 =?us-ascii?Q?HcSiHbOkr4ZdyWJmwRKc/xGEKjgindZGW5coziYvFaHgFY4pmm0b4uQ+8XJn?=
 =?us-ascii?Q?AmU/htnygWozrVtMakt6MCXyIp9WxxX/9Wyac4vRRmFdNAlU8cdwFaG4jDee?=
 =?us-ascii?Q?d52uUnj237mUa6F+ETd5KyV+SDf3BJQYYE/03+duGxCLFEpRG1HFsVEuooeX?=
 =?us-ascii?Q?D0rvoruFNH9JRE7Nfrn5XlfhVIK0pFgetzML8VjIBFbyQKKUkuKZBz/aZP5A?=
 =?us-ascii?Q?FX0WLmnUm0q71RFMSEw4VfZqYsdOlfYi5lAgauvU36A5HXwWpkxOrWW4hze7?=
 =?us-ascii?Q?f8WdfaArQqk62N24TzRGJbPJG+4xHQhWblTedAXMYUFejnyzpCGweMO46+q5?=
 =?us-ascii?Q?+LB9hXW4X03SNvV6/1TUbi/DEF75Cymh09x68MfNo8iRDeVR/elVsORoRYAe?=
 =?us-ascii?Q?HnDoij2N3dT8bArmQisIyB63Fyr7GZQtHO7h0IKDsqvFMDuocgPXd75349hM?=
 =?us-ascii?Q?N9UnZYlPRX8ywYQ/T5SJQCJX3QRDvBFyHYW6Dp6oJuZrOwDTi7CMtrKxQeeF?=
 =?us-ascii?Q?mI4FXoH9xQpzFEK4UqSHiYBidoCS2fHioT3ca+1vBM4l0U9uwGJoHU+kbUm1?=
 =?us-ascii?Q?NNTNjdaLFUgUrK75o8w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ecaf354-3f37-4899-8391-08de1bcda002
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 18:11:50.1105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zw4/hdPPYwUtKNXB84LDjepTZ/fttTmkAMYSflH4Ii0R9ZAn7LXkKInpHJx5D9Lw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8802

iommufd returns ENOENT when attempting to unmap a range that is already
empty, while vfio type1 returns success. Fix vfio_compat to match.

Fixes: d624d6652a65 ("iommufd: vfio container FD ioctl compatibility")
Reported-by: Alex Mastro <amastro@fb.com>
Closes: https://lore.kernel.org/r/aP0S5ZF9l3sWkJ1G@devgpu012.nha5.facebook.com
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.c    | 12 +++---------
 drivers/iommu/iommufd/ioas.c            |  4 ++++
 tools/testing/selftests/iommu/iommufd.c |  2 ++
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index c0360c450880b8..75d60f2ad90082 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -707,7 +707,8 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
 	struct iopt_area *area;
 	unsigned long unmapped_bytes = 0;
 	unsigned int tries = 0;
-	int rc = -ENOENT;
+	/* If there are no mapped entries then success */
+	int rc = 0;
 
 	/*
 	 * The domains_rwsem must be held in read mode any time any area->pages
@@ -777,8 +778,6 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
 
 		down_write(&iopt->iova_rwsem);
 	}
-	if (unmapped_bytes)
-		rc = 0;
 
 out_unlock_iova:
 	up_write(&iopt->iova_rwsem);
@@ -815,13 +814,8 @@ int iopt_unmap_iova(struct io_pagetable *iopt, unsigned long iova,
 
 int iopt_unmap_all(struct io_pagetable *iopt, unsigned long *unmapped)
 {
-	int rc;
-
-	rc = iopt_unmap_iova_range(iopt, 0, ULONG_MAX, unmapped);
 	/* If the IOVAs are empty then unmap all succeeds */
-	if (rc == -ENOENT)
-		return 0;
-	return rc;
+	return iopt_unmap_iova_range(iopt, 0, ULONG_MAX, unmapped);
 }
 
 /* The caller must always free all the nodes in the allowed_iova rb_root. */
diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
index 1542c5fd10a85c..459a7c5169154b 100644
--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -367,6 +367,10 @@ int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd)
 				     &unmapped);
 		if (rc)
 			goto out_put;
+		if (!unmapped) {
+			rc = -ENOENT;
+			goto out_put;
+		}
 	}
 
 	cmd->length = unmapped;
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 3eebf5e3b974f4..bb4d33dde3c899 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2638,6 +2638,8 @@ TEST_F(vfio_compat_mock_domain, map)
 	ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_MAP_DMA, &map_cmd));
 	ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_UNMAP_DMA, &unmap_cmd));
 	ASSERT_EQ(BUFFER_SIZE, unmap_cmd.size);
+	/* Unmap of empty is success */
+	ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_UNMAP_DMA, &unmap_cmd));
 
 	/* UNMAP_FLAG_ALL requires 0 iova/size */
 	ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_MAP_DMA, &map_cmd));

base-commit: b09ed52db1e688eb8205b1939ca1345179ecd515
-- 
2.43.0


