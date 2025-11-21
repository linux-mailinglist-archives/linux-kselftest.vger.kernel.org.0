Return-Path: <linux-kselftest+bounces-46250-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E85C7AA23
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 16:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92CA83A176A
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 15:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC06346E69;
	Fri, 21 Nov 2025 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kcqJE2a5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010037.outbound.protection.outlook.com [52.101.61.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D01B2E717C;
	Fri, 21 Nov 2025 15:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763740282; cv=fail; b=Of90JSkCm9sj7lL7thurHDc0pA2PsE3bmcaEvvPHn7AQXutBYFJ+yaWTgEeu9RkSoFtXJkpencwASw5TXA/OWBqEqdG512qqNsTqmtSc12dGRR9mtla2Xw2H4xBDWwgNxKMp/xAuiZjoFChC07P1I67gCkMuIt3tLTI2UfEa+2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763740282; c=relaxed/simple;
	bh=XfWjaIw/IWI3tCnysu4HYMExi3/4SJculqhhX9IUL+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D0WDWgbV4UpQV1ihiJZFwJ1epMv1hHACTeDQMeIofQcMERnnpeR1ohtCPgsz79pISSOD0yuQWJJbPFmnnu5R4kG1mhbEWnyV0yxW5Yq2MnVcwZURfKQRQPWV0rOfyTYDvjzFAWe/skYWXhG6nMs5W2RwPzihNQ171wLl0teSfTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kcqJE2a5; arc=fail smtp.client-ip=52.101.61.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CT53EX6ExpbPzzeabPBL1rf7EYYCOyzdpvfzB5lU4JMpePcOQ1NHcczG33wQNlsujXDZUJ0tEhblwREANzU+wMpoc3VAZWRtveQVP9aM0+J/MY17n1uesfEeEU1JHZCp1C8XMQomqbnhCAYa/wNriIVqBh7qHPAiE+8gwboWSfsHjnAwHCFc8XA2eKHo/Rq4KiVu/AICOmDaSaw8jdWLd42wkjjc/1Kt8c5+h4Mos8PrAZCZ4u0dW0gOk8PEjFBMm5qAb/nGkp196kvC1hLhKKwVPNmQrdW5RQ7902qkVTh2y8VA/6xZ8gWIly4bBtlPOTuYn0hU6TMe1H/Or2nS+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msJafzfBvirsQdqDRdFm4cZj4zrjRGnA3F1a3HLGLWE=;
 b=JZeChyUlknom0/npM5jwnrzE5LFZ8ULsATSUle5+S7/BsEBLynhFw6d2nTF2WpCDkVvUBdjrUOfoF8nRzZE3Vqg1DpBpeSvEYqfNSbqoEtqf6rSLOzYXiXmneak3STOUksbYcCjaeXz2iE3pl7WyPl/tVd3GJ0+o/d2LOTnPTco8dauapAW/cuOKGCV9U9qaKjvy7yPTrjtNdDSS+XpAuTF0rjTS9yYVSyEMsL5LlcLMgLC2T8GDwAVZWIkipsL+gMLQn7O0jOptSJVI4kRfsvKmeaQSfmdM8nNgwJcoWBbATvOR+E1rOK55XK/r1DZll73bkRIySbcvf5un4eRpdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msJafzfBvirsQdqDRdFm4cZj4zrjRGnA3F1a3HLGLWE=;
 b=kcqJE2a5w+CSCzMmJcSFK3Dw8PkBMZzfEvDRbP0mRnFoRkCO5wDqSq3dV408ssCXvmMQU4f4Hg6rru5Y2cBOq+eT3ESA/GBaQq/Uuu0U6QUu1JW+Rh2sImLCqL4lIlttsS6z6LEbIOgRStkMSo0V4n+yNU/DuN7U6SWrO6ckDtS3gukR+e5Rk/2AhaiE72nZT5bcso3dWEur/dMSK/95ixsvJUb4Yd7/eeIgLq7Nw+LmgUvF6FTH6LzhXq0V74itFfl70aDX9v6FUxdEYleM0fYX96Z42zh71oNyYrwNwlmuOUJ7lRtgF5Ysl9KZc3m4kZmxHRwdGafypW+nus/s6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DS0PR12MB6439.namprd12.prod.outlook.com (2603:10b6:8:c9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.15; Fri, 21 Nov 2025 15:51:08 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 15:51:08 +0000
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
Subject: [PATCH v2 5/9] iommufd: Allow MMIO pages in a batch
Date: Fri, 21 Nov 2025 11:51:02 -0400
Message-ID: <5-v2-b2c110338e3f+5c2-iommufd_dmabuf_jgg@nvidia.com>
In-Reply-To: <0-v2-b2c110338e3f+5c2-iommufd_dmabuf_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0138.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::23) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DS0PR12MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: 81215f3f-23cb-4f8b-2e43-08de2915c8e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X75Q94XTSR6n+/QBPayUe1ZyV5zxOgIhA9AAcKNBfOehHGIQvLhB7XSWlbJg?=
 =?us-ascii?Q?lxv75pzexHSCNJTQP3LoARAppoKPF9SCO00F8jtgwUkOwsjDx4HXIddq7TXM?=
 =?us-ascii?Q?zOHCC+aeBj3VEjPy9bSTZoih2cZWF2uGR7Inlv8+b198L2zrYFMmnCKq89nS?=
 =?us-ascii?Q?L3y+bDl4W+kr1shzzLUdAIKT8DaDIUVlEzovTA1mX5lhjh5TuPf6Ao0mX7zY?=
 =?us-ascii?Q?FxBsJkBkUsG96/v0Z40t1r4w9HcZijWiFsu1JkJi3Lpq/QpWOBhG17+CwPBJ?=
 =?us-ascii?Q?zgZhni86L2KDdrlU/WhdvJ8cv6w0l74t0ZG+j6iYPpDyeEKw8LAplzmHQt3m?=
 =?us-ascii?Q?ur/iArBaNzmxhhpb92q7qkY3WyXG86m0LehAwV5E2NMab2MSaFCs0+3pkxV1?=
 =?us-ascii?Q?SSEKlF4E1j8P4Nk4/hpJRtdu91B8GzYVTbqfggB/n1Y66megpH5w0C3CafBs?=
 =?us-ascii?Q?P9gFmIYx3VKNDhy0bF7GzKtYS4WZCAn07d2L8mrleqhopCYU16W2s851Bw+s?=
 =?us-ascii?Q?QoRpbbdjCVgP+gnbTBpkBlZ6mxEwbSFaVU6cfanY/Qv+U8I2fmMa4ARqb+89?=
 =?us-ascii?Q?xBiLvQ2WnDhwiPefUmuhW9Ap3WYVG5iyMVCIyob1t+UdBs+yaO3OJb6W/Xue?=
 =?us-ascii?Q?Nhlo0DbMkPBBLeN00O3Y2YH9cbIGeF0gHfLV0SSAtcm0EJZXNcHjLDY4qx14?=
 =?us-ascii?Q?NHTko4NVgTiQytHVm9wLwAd2UtG+RXegZptxAOYS7ZvyJa3Y4+t0Onth0eMJ?=
 =?us-ascii?Q?3Wz6oj1Kx3NBy7kHMRxyPgKRNz0jL0lIsS5WgLU3uSQmoQf1QVNm9fDqYdN1?=
 =?us-ascii?Q?lNo/8PcBVnzsPA1yMZBXPam3KZ/512YoPH4Jx12Wao/p8zqhBNO5B9gYIwwh?=
 =?us-ascii?Q?yweXKtP9iVFvT2rwCvCvIh0tWOmeqYVSfHokty9WbIZ6QyM9WMKiPD4yfKt1?=
 =?us-ascii?Q?Oq6hn+4cOy0bya2HGO1ILYiZIvH3paBr1zpeBWkVD6PjY0GdGd0Sz0qeTIvB?=
 =?us-ascii?Q?ngdAuoCcgtryPFKrKmaR6nyrySNdB1Dqv9xSF5CCU1Byk6zR/ChNgsBrgiUS?=
 =?us-ascii?Q?ZP424kCeTLgFsof+sYn3wihAJKCUP6oAqlyzGNYSI0S1x2yZaYFWIy+01Dep?=
 =?us-ascii?Q?ldnTlN/bNFhkQUwn766lTnpLq1RkAdJnQFUw9DZhOvVejiz6H7ySPOs008JO?=
 =?us-ascii?Q?ac6E9Dwksg3m2MLaLmotsNqrwY46R53ZDW0VroK5Z+JiW5ybxXUe3ZCwuywh?=
 =?us-ascii?Q?3fOEL9YSShlLA5SibDV/PnTA4QeJVoLzBhHRmvbMTligDb4/wAu2lZEmGqSV?=
 =?us-ascii?Q?L/fFMZM52AR+ltkekXL2sbc6YNlgZRXKvRkBw6HWp+/iAZPtPvkO+iKjSF0c?=
 =?us-ascii?Q?LeziWwCQiiROMUIcj8XQd+gH2EFLl65jIK8Qhb0m0hlPdeMhJDnzFl/Acj0C?=
 =?us-ascii?Q?B2HF3Q30in0Vu01yuCMT9Ug8gBZiKTXDkIvKuYZy8BJ9DAmK4PKMw9GvskPn?=
 =?us-ascii?Q?XSJ4DEmdDsEwsc8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SOTX3NGHfCDNHYFPZSFV5oN7rW/1A5qVbz3FvkZzBrR7VnrbW5b0pCsDIhgt?=
 =?us-ascii?Q?S57EWrkFVCi+/RlariPRfX2LYS35iZXpvChiIx0lt3IShwpDlTcv69ANzynt?=
 =?us-ascii?Q?SYJLp6bxDwEMrkx8/GYJnaEeWSp+7VbaudoGhTze7GyiPUCv7CJK0n8/CgOE?=
 =?us-ascii?Q?6syXsIs1dK8CKI21laN8ce4cjUJr1iawQNkNWjskk1SR/tw2q+Dx5NEBg5Sy?=
 =?us-ascii?Q?GmnyL1DfQtZz0Sdc4D9qyetdYrTix+VLEXI8ULaaiX1cv9cHLb8d/zquSsrU?=
 =?us-ascii?Q?nDamH+Ek+N8ieYaHPIJbzDgnSmGYIBWopPlh/GaaPn6CRV6JzHhqQxQt7lIG?=
 =?us-ascii?Q?IR6BNgl+9RnoIAkOg8ONnhjtTJiiT/eOnSx+abcBgyfyEOkGv8cEChZHUCop?=
 =?us-ascii?Q?cDJgt6ACLqqU9wxD3ZZA2poLKiKMaeS4heqhuvUzg8C78Z8dBhiDkimU2q8u?=
 =?us-ascii?Q?9stWuSzIQsif5tkqUcf8zCF28KuNYlKr198ToNjf6SG0kMk07WEKWm6iT3ta?=
 =?us-ascii?Q?0QAwzXjSd/9ef2XXViuvL8/y/BEFGRIFp0wMs8G9UhepKfjAyY7O/SyIMazJ?=
 =?us-ascii?Q?Jc3bJIAS48rJtCkJ08Vi/T998N7ug31hzMNE5kMA4HWF+NhwxulIpU7UMaJR?=
 =?us-ascii?Q?lSduwFMOginqPhX0aTcCxe5pI5CgNimdWPKRdwxTQZconSTgFrSGWiVObFrr?=
 =?us-ascii?Q?yEp0OEyjHrXFIt/p5ZdXptf8EC33hSq1zfrePgXDixFKls5q7trk15kfOHTm?=
 =?us-ascii?Q?2mB2JdTp82p1slUgncp7z+Wm06krWsogecoQsFiNK9E8pKa7qyuxQMf+UATi?=
 =?us-ascii?Q?T8POkSyi8jGoc5K4A3BDCeU3jbDFqh9Xcb0sAnw1Q+NfQCzMJAk9apHLAGTK?=
 =?us-ascii?Q?OfGODR0RS+T3BFuwUwUaKbLwRi7MoWTOKhOu00yQNDEXMDwaxkOxdzLUZ/Ip?=
 =?us-ascii?Q?3c7k8OkmgoLyl2N487biG8/oPWmlV496Q69yLZfjP2qgbi5V+PWw9TmlEtQH?=
 =?us-ascii?Q?z+iH7UJg8UVCuVQMExtElAuq0+wHQUyrR9QF5Y54JU8QB6JaDnI0bvxuQTNY?=
 =?us-ascii?Q?3DimWvj861Dp5EFXtjg8iXE48QA4MmpNbHUP6hjwXKSw0E1CmbP6Au9GL/ht?=
 =?us-ascii?Q?TbOzKWrZrq5UOMvBZnGeuTTTnZhU9xiCdihLajH14l7ggrR8gRNlsn1RYQgv?=
 =?us-ascii?Q?aaeROuA96xd4WXmugZ8mIbvlLFrd51BbRflMJzwy+ZvH++A/b0nxWKUfknwj?=
 =?us-ascii?Q?30G4Y+9I1f1d9E8B5bOKNwHBtlVh0bHKhFuEMuMTWPmbeYCqsBSJ+oFlIaXt?=
 =?us-ascii?Q?JoXungg8CpJoFJiHPcc8IZXXE/HfTrfl0S8p3JKGF9gugnPLvfZS0FNgzZwZ?=
 =?us-ascii?Q?wd/qeNkGxLXeAx8eYpQ88YDiPxwger+H0eoJumf78UvDqCZHRppvHVJWE75x?=
 =?us-ascii?Q?oPNhNWnt5oV4/gCA5PJ1FGMfTGdCr1ovSMtZuBZ8RGS7Tizbb8lcO4FwX6fX?=
 =?us-ascii?Q?6z/gki9Syc4wRSDzdf+xrVubH3dlZZxgf2QYRke9n64wc3mMCX5sEHo4vQ56?=
 =?us-ascii?Q?nPJ7PYqKkQW/9aokXiA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81215f3f-23cb-4f8b-2e43-08de2915c8e8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 15:51:07.6699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SrgvueBXIhQmWcaBNVkoTrnnHbBUrkfV1CXSQLUpf4L5bRyv6XI8z+Lf+KR3UanS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6439

Addresses intended for MMIO should be propagated through to the iommu with
the IOMMU_MMIO flag set.

Keep track in the batch if all the pfns are cachable or mmio and flush the
batch out of it ever needs to be changed. Switch to IOMMU_MMIO if the
batch is MMIO when mapping the iommu.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/pages.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index a6c874d5eda8f4..ef90d086f1ac8d 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -261,6 +261,11 @@ static struct iopt_area *iopt_pages_find_domain_area(struct iopt_pages *pages,
 	return container_of(node, struct iopt_area, pages_node);
 }
 
+enum batch_kind {
+	BATCH_CPU_MEMORY = 0,
+	BATCH_MMIO,
+};
+
 /*
  * A simple datastructure to hold a vector of PFNs, optimized for contiguous
  * PFNs. This is used as a temporary holding memory for shuttling pfns from one
@@ -274,6 +279,7 @@ struct pfn_batch {
 	unsigned int array_size;
 	unsigned int end;
 	unsigned int total_pfns;
+	enum batch_kind kind;
 };
 enum { MAX_NPFNS = type_max(typeof(((struct pfn_batch *)0)->npfns[0])) };
 
@@ -352,10 +358,17 @@ static void batch_destroy(struct pfn_batch *batch, void *backup)
 }
 
 static bool batch_add_pfn_num(struct pfn_batch *batch, unsigned long pfn,
-			      u32 nr)
+			      u32 nr, enum batch_kind kind)
 {
 	unsigned int end = batch->end;
 
+	if (batch->kind != kind) {
+		/* One kind per batch */
+		if (batch->end != 0)
+			return false;
+		batch->kind = kind;
+	}
+
 	if (end && pfn == batch->pfns[end - 1] + batch->npfns[end - 1] &&
 	    nr <= MAX_NPFNS - batch->npfns[end - 1]) {
 		batch->npfns[end - 1] += nr;
@@ -382,7 +395,7 @@ static void batch_remove_pfn_num(struct pfn_batch *batch, unsigned long nr)
 /* true if the pfn was added, false otherwise */
 static bool batch_add_pfn(struct pfn_batch *batch, unsigned long pfn)
 {
-	return batch_add_pfn_num(batch, pfn, 1);
+	return batch_add_pfn_num(batch, pfn, 1, BATCH_CPU_MEMORY);
 }
 
 /*
@@ -495,6 +508,7 @@ static int batch_to_domain(struct pfn_batch *batch, struct iommu_domain *domain,
 {
 	bool disable_large_pages = area->iopt->disable_large_pages;
 	unsigned long last_iova = iopt_area_last_iova(area);
+	int iommu_prot = area->iommu_prot;
 	unsigned int page_offset = 0;
 	unsigned long start_iova;
 	unsigned long next_iova;
@@ -502,6 +516,11 @@ static int batch_to_domain(struct pfn_batch *batch, struct iommu_domain *domain,
 	unsigned long iova;
 	int rc;
 
+	if (batch->kind == BATCH_MMIO) {
+		iommu_prot &= ~IOMMU_CACHE;
+		iommu_prot |= IOMMU_MMIO;
+	}
+
 	/* The first index might be a partial page */
 	if (start_index == iopt_area_index(area))
 		page_offset = area->page_offset;
@@ -515,11 +534,11 @@ static int batch_to_domain(struct pfn_batch *batch, struct iommu_domain *domain,
 			rc = batch_iommu_map_small(
 				domain, iova,
 				PFN_PHYS(batch->pfns[cur]) + page_offset,
-				next_iova - iova, area->iommu_prot);
+				next_iova - iova, iommu_prot);
 		else
 			rc = iommu_map(domain, iova,
 				       PFN_PHYS(batch->pfns[cur]) + page_offset,
-				       next_iova - iova, area->iommu_prot,
+				       next_iova - iova, iommu_prot,
 				       GFP_KERNEL_ACCOUNT);
 		if (rc)
 			goto err_unmap;
@@ -655,7 +674,7 @@ static int batch_from_folios(struct pfn_batch *batch, struct folio ***folios_p,
 		nr = min(nr, npages);
 		npages -= nr;
 
-		if (!batch_add_pfn_num(batch, pfn, nr))
+		if (!batch_add_pfn_num(batch, pfn, nr, BATCH_CPU_MEMORY))
 			break;
 		if (nr > 1) {
 			rc = folio_add_pins(folio, nr - 1);
-- 
2.43.0


