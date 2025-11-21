Return-Path: <linux-kselftest+bounces-46254-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2375EC7AA71
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 16:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 793733A19F0
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 15:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B385834F486;
	Fri, 21 Nov 2025 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C0fdFTRO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C596E34DB5D;
	Fri, 21 Nov 2025 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763740288; cv=fail; b=dTyjrhokmSrKfsLCqNjoylf6aMEsVyTKrlB6dpy7JTelM8O/xc4nLDaQK2sYLUUKl0v5ubgmQ09+YRRLyz+4ZspZpH5vj+SxRlUt0PVH09totXW1qqplm0ZAQjyDoL3Od5wzNCYUDywW/Zm3CBsOEYaYR68WyQfECaVpghkVEvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763740288; c=relaxed/simple;
	bh=DbvKVqY0wbDY/7iuuCkBb8DlqhsyQRrgbavme6K6WOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uyvej2dqSwL2UMbbLTMs9hr4LCGtGD+VmMGznAuurCyHHphqIOTLaQyC68kF+1SdNfXBcx63BtqI23gmuqrbYfVmf9AOVI/n29lM9cAx6oQ+hmz6wSgi6B79cM7JFf7DSCrq0EPfTURvl72+Ib/JNqBBe+mnGbrPaIlftfSBR4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C0fdFTRO; arc=fail smtp.client-ip=52.101.52.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xt9CGUlV/DrLTwClEpZtRNCHBrH9RCloEasUvl6NswNcsxaQ8sg8NWQfrqebZyQSl+7VaWALCUH9n3Tj+gdQ3vOqo7eK9O1/qbmOEE//JgAHzYuF05run3n8Zfv6Luey/U1qKGvl8hZmI+F3piN84nUjMAljGqwH0mBMWX6SONsQdA2K1JgoRJZ0RJ1gXyvvN16CHta1yCM3HAFly3jcu5WEwXA2l9JdCzlbtEpwv+R8DNLX1tHTKUl/sjAlJchSjmfDXnMu0tmVJvRyBNU7RObZxikCRmeE67xtF6b+unN68JdV1+oDGYnx6oA9JstZoFnaYN7dyOd04fbV09N9FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRxbboggifttdf/Sy3dWL5Gy7+JWiITkwQTpLF6w6/8=;
 b=hacXf+cAR9ABPTQJ0/60UeMQr65t5xwL7NzKeuYecX8dt77XDSlPgXXH3vwzSm3FiWaP9fs3+ZBoyNtBQ+CY/rensvr6XUKzboFq3NQJ35BiUSipiU3vIemicz7DgT2nKoZt/9iC9xg1+T74Mrhd4SGwntvppPsbo0vkpnS+pm3Oe4BBdpX9MvMP3KXl/JWg8u52SsmOvD6T8XxfClaXHyyqMpFwHeHO2/YM95oF5MPwTRKMLGzhkXmCojI51EEv912bk23J5jojUopRYU54f0X6zo1FwFq/EpWFG7qig7IbMX8iEeVmmTmNkIdbcQDSRYMpZxlz0Ix10CEySvUYTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRxbboggifttdf/Sy3dWL5Gy7+JWiITkwQTpLF6w6/8=;
 b=C0fdFTROTSbWkAHF1iI9n6PF+xWRHvA5E6NG9rDuYhCOCSLCrefMONrrcxAauXplbCEpfjyIRqm0Y9FrRhZCkD40N+f+X0a11Eo/TbFzGK0XvHRCyoEB1JegcF9kwNEIVkaQORaqZG7o3uFP0VyLO5vbL4v8gUVa/oe77Cw//HQDmnmTtruxyk760L/rDA4OCbcm8C1+RPzBz5bfZXweAY4Nf4aIT1Gh8xsZMxlzmZDfH4SjcRW0bHmdvvq1hjC/ZVEGTm7rDf2/OojYIbWLbWkx+YnhHMJffjDvVolaQl5cihAf49lsnNCNLdnkDAaMOoGlm6JO1ykr2jnK+C73Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DS0PR12MB6439.namprd12.prod.outlook.com (2603:10b6:8:c9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.15; Fri, 21 Nov 2025 15:51:12 +0000
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
Subject: [PATCH v2 2/9] iommufd: Add DMABUF to iopt_pages
Date: Fri, 21 Nov 2025 11:50:59 -0400
Message-ID: <2-v2-b2c110338e3f+5c2-iommufd_dmabuf_jgg@nvidia.com>
In-Reply-To: <0-v2-b2c110338e3f+5c2-iommufd_dmabuf_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF00013DF7.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:9) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DS0PR12MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: 65251a55-a510-4685-3635-08de2915c989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?742dP4zRN+f4ys+9OuR335phEoC5Ii9yefD2WfYVycYPOl2Sz2cRQtJdjWKL?=
 =?us-ascii?Q?g5kbs9kLSM1sAGU23onr8UQBU9i+E+V7VgDumF+i+f0OHXduC/ZA5mnxD6nB?=
 =?us-ascii?Q?DWLt7ILXMX1r9EZorCeGMnSWSNMCgx4yZsWtxH+DGOS3tKy5x198lUjVOhO8?=
 =?us-ascii?Q?eXbYBTWoRB5xtp0J9s9BYSwWVv2ARAZ8hXE5bmjR6YuyBSs6kj0kz0RBDcJA?=
 =?us-ascii?Q?Y+hz4O+lQzuv2IeVG0OL6fVVZvLNDR60zFSziZBB4yUSgrm4pTiLAD/Rui1i?=
 =?us-ascii?Q?7pj5v0t/BOMI03qgXkrmbSP56JG2ey8dRVTW3hanQ/kdCz8MBDCVCnPWyz4d?=
 =?us-ascii?Q?cB35Rpl142kFVoVyPDSSPAwhAQEMGzvh4mKcPKvsDwZ0LVlAhcRPlt2dMMpu?=
 =?us-ascii?Q?pOL4YY7veu5NFu6ZvYcOlqOfWhXYbCDSykYbcz3xu00B1Tvs5rz12//6xfzZ?=
 =?us-ascii?Q?yXaoeWkxK1DRVGbV6HpQxN7LY5jxqgJ6CrFD3bwbJE1oLPtW7xRM2aKGyGKF?=
 =?us-ascii?Q?zVWdeMqn2BEdZO5ZT608k4vxVtazzeHlRztabrbExLTwPzwyhLXgqvxhwTKK?=
 =?us-ascii?Q?/iWNY/guje5c7UbSNUYTkNScdz5TGGN3k9YCZJm+jwfdCG8G7THYkUOQJQ5i?=
 =?us-ascii?Q?Lq1MFGcYVA3KOnFJWmKKnPVan/2SAO4rhNEfrJr7+kZXPlvW5HQehyVIjBED?=
 =?us-ascii?Q?iX3LprxcSDGR/Zqc6GzRiP3FXb8nfZPWSgaxTDiagcrOQ2Vq75hOpkHQIOfx?=
 =?us-ascii?Q?08RSDROWgAq0bQWD80GHba1mMuS/newCeh1pq6op8NUF4d+UICXNXVVpTYja?=
 =?us-ascii?Q?/KENg7iruM8To1peCgxCPvdbXsYLcji1TDumeBrKxO/t1Ry5J7yI29O9Z0kt?=
 =?us-ascii?Q?+liDfTmjEf5L69/7XFb/AT0gbhBQVZfNwjyjtvHYJGfVwSf8MJXMxWnM6Z4e?=
 =?us-ascii?Q?V+yCeFkoGjE1UBI8/ikfq+rBCYzGdUQS5WuQl8EopGKWPEHUE+RP2w/zoomy?=
 =?us-ascii?Q?tzV9BpQFQ/DMU/8I9DDr927mWrGhGIXQa5/kV+2gdc8OCE3CrurxIxZ7Eemf?=
 =?us-ascii?Q?pWV7p1wp7EJ4lJdIfHIGG2c/KCmOIhPNYFK8At7CLtxu5cOrRpYIbExF0FSD?=
 =?us-ascii?Q?bul8DYNyaTRKSXi4NWKwP0Z4Xh4LUWS71OK7EIHszq7rL2GqE37z6QstCamW?=
 =?us-ascii?Q?NoW2oQQJOKeuDy5onrvBgEqpODDr7Q+iCHoFqAvmxAzORVwQq+ZblAO9TPWp?=
 =?us-ascii?Q?HOz1FAh2BT2/ufImRgLS712lTWAg8+H902sISAHdVETx110iVVgib5eSg+1S?=
 =?us-ascii?Q?coyIf/21cQrv4av655lWOaxNNUovVUzjx6fQx2W9Gm+FiACOg/NPYIro8Myu?=
 =?us-ascii?Q?G5A6LO/LqB+a086FySqoaoLMvlcaMXMUQqLe89NMOz1ECOoNpyr2yFsGSBQi?=
 =?us-ascii?Q?DF7lyfHxLL3GkHDYjc8WZNZp1tIene5iOxUE6oQKfL+Yrzykna0gm014aPOJ?=
 =?us-ascii?Q?oPF2xKO+6ftfA0Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2rFfa5TAR/Wy/mKBGKK5pANDS7l+4XDidJvYMdK080fu6yxuDvJMHdJrj7SY?=
 =?us-ascii?Q?MhMK8KWhi+RSmnrZ7HrlJYvXiLiM9x9OT+cl9JbWAHwf46JPJgEKzgfVz7qw?=
 =?us-ascii?Q?w74slUqoAk4cHccNW6YHqFno9UBZ0x0Rj9TpQXyIIVcaQ8B9VpWAh4uEOpnd?=
 =?us-ascii?Q?c9cYewv6u7vq1IupfA0BaEgysniMI2K787UYVDHxDaK5TtG8h4JrK1Daui9t?=
 =?us-ascii?Q?tCTiG4ZZEE6YEyPxQddLyppdq2DmmfERhgAlXFSv90TRgqHlRNPp8QDkyPp8?=
 =?us-ascii?Q?I2uJJnE8slWmws5+eh/+3QlzqRg+oCKH+i/B7A8AgDmb0leqKZpGbW9ClsUX?=
 =?us-ascii?Q?7S4shfqFFT91B3TgOmzIQTfUvBnmotYnFxMtjFKKkNGL3PeYIG7Fdv79ON0Q?=
 =?us-ascii?Q?oJPA8hj/2bDmsCHkK3NHcpCL4PMZZSZirIg6pCRCKtuVRaj+gUsbNFvt1ypE?=
 =?us-ascii?Q?GDV7o5meZQRKmIHsdy0VyxTUEz3vmbL+hwa/5izrDYe0Xz3KdIVFNpC9E3ql?=
 =?us-ascii?Q?CSef9g4gkJ++hl9BB7QnOwMdZzD2HkMKjTo/rAHML/uCTUGIR9sRkTi0m0Ks?=
 =?us-ascii?Q?CAAnV8sRNu7SIifWNJn5CZy+5STQPdXpRi6zAoOvor5qTh1VCRZAqTr6LuFw?=
 =?us-ascii?Q?wB2+BZnoOv0Vo8cKOHjMAT1d7IKax4K32dPVrueYCkm2KUhOaWBpJiGAaQYq?=
 =?us-ascii?Q?F25uoRQO6Gp8XXAOsFrg8VkAiMZM7eDH+LK/vXc6dVIQBt73mVR8oD46+/C0?=
 =?us-ascii?Q?a6zSBuDc/lD8p1uQMH1C2oFh+wTTJ59xfzUIcuWZXQZo0kyUkTjS0R8+ALLJ?=
 =?us-ascii?Q?suEFihk+bsab6Uc54yUNYZQ3DhXed/R9ncNEaPEyoW6P1ACcNfcweAADZi5Y?=
 =?us-ascii?Q?o+f0nr3h8dxDQ6zb3kELxZoH2kd1oudl++x4Qf0rlJZfda2GVyG6qxwLK6gd?=
 =?us-ascii?Q?ZNmF8Il4kJTJsfsrXnvbQn3h7L+Ko8b5+i8lbW/Yod7LWARlqkD8Ls1IO/Vv?=
 =?us-ascii?Q?F1itMPaphIrk7sk05iofyYRbN1ziyvK/GoaKeIJI877x4dsir+kL84bJZZmY?=
 =?us-ascii?Q?wRTJ7sdBemX6xj8gpnft3SioEmuAxUQ4LGUn78z/OzvIiPwKGfpG4+fy50oa?=
 =?us-ascii?Q?i9AGM4p/fzonUY3sOrlpzcxYvlBTOAHGmy3RglZYgPov9W3OCeDLnnEE0QXY?=
 =?us-ascii?Q?MD7bjQ1mZ2rlzLeJPSLgOaW3hc0MjfIa8z37IsDo5cT0q7OiDHHn0skbC33A?=
 =?us-ascii?Q?bto6PhSfSMOY9Q9TEIU3g+pAk1O1b7DiwHBtu9HXMyqqh0qRewLRgu6Gi3pC?=
 =?us-ascii?Q?dvck8f3y+VFZF5CfHqRZPm8XxsNpTXj7SDR66khX0Mv0GhSewHX49jlcYXOD?=
 =?us-ascii?Q?VbqqfzrF5TuxiZ50YUIqGJt/D2iBZw8V2kHnlG1xNylwvoJO30JH1f/H3UXs?=
 =?us-ascii?Q?msVo9Y/WnM9fsopsIcyRkvbMUTvoymNY7ba739omhwoBjZ4FhmkQm/c+kDIA?=
 =?us-ascii?Q?A3HOIWZjiWQ2+2uPbPn6tLGmsp2GFq8z6DtHyzHaqDsEJ1dBjcf8NFcx3srL?=
 =?us-ascii?Q?riO1LQaefuX8WGoJBwk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65251a55-a510-4685-3635-08de2915c989
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 15:51:08.6815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wt4zF6Kf8f0mDogCIcy7x6+L+QBeVlQRHx7egkYB6sgz2cyPqhd51x6FbdmposxN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6439

Add IOPT_ADDRESS_DMABUF to the iopt_pages and the basic infrastructure to
create an iopt_pages from a struct dma_buf *.

DMABUF pages are not supported for accesses, and for now can only be used
with the VFIO DMABUF exporter.

The overall flow will be similar to memfd where the user can pass in a
DMABUF file descriptor to IOMMU_IOAS_MAP_FILE and create an area and
pages. Like other areas it can be copied and otherwise manipulated, though
there is little point in doing so.

There is no pinned page accounting done for DMABUF maps.

The DMABUF attachment exists so long as the dmabuf is mapped into an IOAS,
even if the IOAS is not mapped to any domains.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.c    |   3 +
 drivers/iommu/iommufd/io_pagetable.h    |  25 ++++-
 drivers/iommu/iommufd/iommufd_private.h |   2 +
 drivers/iommu/iommufd/main.c            |  10 ++
 drivers/iommu/iommufd/pages.c           | 137 ++++++++++++++++++++++--
 5 files changed, 169 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index c0360c450880b8..b3cf3825a88c7f 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -284,6 +284,9 @@ static int iopt_alloc_area_pages(struct io_pagetable *iopt,
 		case IOPT_ADDRESS_FILE:
 			start = elm->start_byte + elm->pages->start;
 			break;
+		case IOPT_ADDRESS_DMABUF:
+			start = elm->start_byte + elm->pages->dmabuf.start;
+			break;
 		}
 		rc = iopt_alloc_iova(iopt, dst_iova, start, length);
 		if (rc)
diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index b6064f4ce4af91..08b6bfb6b14489 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -5,6 +5,7 @@
 #ifndef __IO_PAGETABLE_H
 #define __IO_PAGETABLE_H
 
+#include <linux/dma-buf.h>
 #include <linux/interval_tree.h>
 #include <linux/kref.h>
 #include <linux/mutex.h>
@@ -179,7 +180,15 @@ enum {
 
 enum iopt_address_type {
 	IOPT_ADDRESS_USER = 0,
-	IOPT_ADDRESS_FILE = 1,
+	IOPT_ADDRESS_FILE,
+	IOPT_ADDRESS_DMABUF,
+};
+
+struct iopt_pages_dmabuf {
+	struct dma_buf_attachment *attach;
+	struct dma_buf_phys_vec phys;
+	/* Always PAGE_SIZE aligned */
+	unsigned long start;
 };
 
 /*
@@ -209,6 +218,8 @@ struct iopt_pages {
 			struct file *file;
 			unsigned long start;
 		};
+		/* IOPT_ADDRESS_DMABUF */
+		struct iopt_pages_dmabuf dmabuf;
 	};
 	bool writable:1;
 	u8 account_mode;
@@ -220,10 +231,22 @@ struct iopt_pages {
 	struct rb_root_cached domains_itree;
 };
 
+static inline bool iopt_is_dmabuf(struct iopt_pages *pages)
+{
+	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
+		return false;
+	return pages->type == IOPT_ADDRESS_DMABUF;
+}
+
 struct iopt_pages *iopt_alloc_user_pages(void __user *uptr,
 					 unsigned long length, bool writable);
 struct iopt_pages *iopt_alloc_file_pages(struct file *file, unsigned long start,
 					 unsigned long length, bool writable);
+struct iopt_pages *iopt_alloc_dmabuf_pages(struct iommufd_ctx *ictx,
+					   struct dma_buf *dmabuf,
+					   unsigned long start_byte,
+					   unsigned long start,
+					   unsigned long length, bool writable);
 void iopt_release_pages(struct kref *kref);
 static inline void iopt_put_pages(struct iopt_pages *pages)
 {
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 627f9b78483a0e..10ee3510312132 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -504,6 +504,8 @@ void iommufd_device_pre_destroy(struct iommufd_object *obj);
 void iommufd_device_destroy(struct iommufd_object *obj);
 int iommufd_get_hw_info(struct iommufd_ucmd *ucmd);
 
+struct device *iommufd_global_device(void);
+
 struct iommufd_access {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index ce775fbbae94e7..5cc4b08c25f585 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -751,6 +751,15 @@ static struct miscdevice vfio_misc_dev = {
 	.mode = 0666,
 };
 
+/*
+ * Used only by DMABUF, returns a valid struct device to use as a dummy struct
+ * device for attachment.
+ */
+struct device *iommufd_global_device(void)
+{
+	return iommu_misc_dev.this_device;
+}
+
 static int __init iommufd_init(void)
 {
 	int ret;
@@ -794,5 +803,6 @@ MODULE_ALIAS("devname:vfio/vfio");
 #endif
 MODULE_IMPORT_NS("IOMMUFD_INTERNAL");
 MODULE_IMPORT_NS("IOMMUFD");
+MODULE_IMPORT_NS("DMA_BUF");
 MODULE_DESCRIPTION("I/O Address Space Management for passthrough devices");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index c3433b84556172..89a5c999e3a2d4 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -45,6 +45,8 @@
  * last_iova + 1 can overflow. An iopt_pages index will always be much less than
  * ULONG_MAX so last_index + 1 cannot overflow.
  */
+#include <linux/dma-buf.h>
+#include <linux/dma-resv.h>
 #include <linux/file.h>
 #include <linux/highmem.h>
 #include <linux/iommu.h>
@@ -53,6 +55,7 @@
 #include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/sched/mm.h>
+#include <linux/vfio_pci_core.h>
 
 #include "double_span.h"
 #include "io_pagetable.h"
@@ -272,6 +275,7 @@ struct pfn_batch {
 	unsigned int end;
 	unsigned int total_pfns;
 };
+enum { MAX_NPFNS = type_max(typeof(((struct pfn_batch *)0)->npfns[0])) };
 
 static void batch_clear(struct pfn_batch *batch)
 {
@@ -350,7 +354,6 @@ static void batch_destroy(struct pfn_batch *batch, void *backup)
 static bool batch_add_pfn_num(struct pfn_batch *batch, unsigned long pfn,
 			      u32 nr)
 {
-	const unsigned int MAX_NPFNS = type_max(typeof(*batch->npfns));
 	unsigned int end = batch->end;
 
 	if (end && pfn == batch->pfns[end - 1] + batch->npfns[end - 1] &&
@@ -1360,6 +1363,121 @@ struct iopt_pages *iopt_alloc_file_pages(struct file *file, unsigned long start,
 	return pages;
 }
 
+static void iopt_revoke_notify(struct dma_buf_attachment *attach)
+{
+	struct iopt_pages *pages = attach->importer_priv;
+
+	guard(mutex)(&pages->mutex);
+	pages->dmabuf.phys.len = 0;
+}
+
+static struct dma_buf_attach_ops iopt_dmabuf_attach_revoke_ops = {
+	.allow_peer2peer = true,
+	.move_notify = iopt_revoke_notify,
+};
+
+/*
+ * iommufd and vfio have a circular dependency. Future work for a phys
+ * based private interconnect will remove this.
+ */
+static int
+sym_vfio_pci_dma_buf_iommufd_map(struct dma_buf_attachment *attachment,
+				 struct dma_buf_phys_vec *phys)
+{
+	typeof(&vfio_pci_dma_buf_iommufd_map) fn;
+	int rc;
+
+	if (!IS_ENABLED(CONFIG_VFIO_PCI_DMABUF))
+		return -EOPNOTSUPP;
+
+	fn = symbol_get(vfio_pci_dma_buf_iommufd_map);
+	if (!fn)
+		return -EOPNOTSUPP;
+	rc = fn(attachment, phys);
+	symbol_put(vfio_pci_dma_buf_iommufd_map);
+	return rc;
+}
+
+static int iopt_map_dmabuf(struct iommufd_ctx *ictx, struct iopt_pages *pages,
+			   struct dma_buf *dmabuf)
+{
+	struct dma_buf_attachment *attach;
+	int rc;
+
+	attach = dma_buf_dynamic_attach(dmabuf, iommufd_global_device(),
+					&iopt_dmabuf_attach_revoke_ops, pages);
+	if (IS_ERR(attach))
+		return PTR_ERR(attach);
+
+	dma_resv_lock(dmabuf->resv, NULL);
+	/*
+	 * Lock ordering requires the mutex to be taken inside the reservation,
+	 * make sure lockdep sees this.
+	 */
+	if (IS_ENABLED(CONFIG_LOCKDEP)) {
+		mutex_lock(&pages->mutex);
+		mutex_unlock(&pages->mutex);
+	}
+
+	rc = sym_vfio_pci_dma_buf_iommufd_map(attach, &pages->dmabuf.phys);
+	if (rc)
+		goto err_detach;
+
+	dma_resv_unlock(dmabuf->resv);
+
+	/* On success iopt_release_pages() will detach and put the dmabuf. */
+	pages->dmabuf.attach = attach;
+	return 0;
+
+err_detach:
+	dma_resv_unlock(dmabuf->resv);
+	dma_buf_detach(dmabuf, attach);
+	return rc;
+}
+
+struct iopt_pages *iopt_alloc_dmabuf_pages(struct iommufd_ctx *ictx,
+					   struct dma_buf *dmabuf,
+					   unsigned long start_byte,
+					   unsigned long start,
+					   unsigned long length, bool writable)
+{
+	static struct lock_class_key pages_dmabuf_mutex_key;
+	struct iopt_pages *pages;
+	int rc;
+
+	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	if (dmabuf->size <= (start + length - 1) ||
+	    length / PAGE_SIZE >= MAX_NPFNS)
+		return ERR_PTR(-EINVAL);
+
+	pages = iopt_alloc_pages(start_byte, length, writable);
+	if (IS_ERR(pages))
+		return pages;
+
+	/*
+	 * The mmap_lock can be held when obtaining the dmabuf reservation lock
+	 * which creates a locking cycle with the pages mutex which is held
+	 * while obtaining the mmap_lock. This locking path is not present for
+	 * IOPT_ADDRESS_DMABUF so split the lock class.
+	 */
+	lockdep_set_class(&pages->mutex, &pages_dmabuf_mutex_key);
+
+	/* dmabuf does not use pinned page accounting. */
+	pages->account_mode = IOPT_PAGES_ACCOUNT_NONE;
+	pages->type = IOPT_ADDRESS_DMABUF;
+	pages->dmabuf.start = start - start_byte;
+
+	rc = iopt_map_dmabuf(ictx, pages, dmabuf);
+	if (rc) {
+		iopt_put_pages(pages);
+		return ERR_PTR(rc);
+	}
+
+	return pages;
+}
+
 void iopt_release_pages(struct kref *kref)
 {
 	struct iopt_pages *pages = container_of(kref, struct iopt_pages, kref);
@@ -1372,8 +1490,14 @@ void iopt_release_pages(struct kref *kref)
 	mutex_destroy(&pages->mutex);
 	put_task_struct(pages->source_task);
 	free_uid(pages->source_user);
-	if (pages->type == IOPT_ADDRESS_FILE)
+	if (iopt_is_dmabuf(pages) && pages->dmabuf.attach) {
+		struct dma_buf *dmabuf = pages->dmabuf.attach->dmabuf;
+
+		dma_buf_detach(dmabuf, pages->dmabuf.attach);
+		dma_buf_put(dmabuf);
+	} else if (pages->type == IOPT_ADDRESS_FILE) {
 		fput(pages->file);
+	}
 	kfree(pages);
 }
 
@@ -2031,15 +2155,14 @@ int iopt_pages_rw_access(struct iopt_pages *pages, unsigned long start_byte,
 	if ((flags & IOMMUFD_ACCESS_RW_WRITE) && !pages->writable)
 		return -EPERM;
 
-	if (pages->type == IOPT_ADDRESS_FILE)
+	if (iopt_is_dmabuf(pages))
+		return -EINVAL;
+
+	if (pages->type != IOPT_ADDRESS_USER)
 		return iopt_pages_rw_slow(pages, start_index, last_index,
 					  start_byte % PAGE_SIZE, data, length,
 					  flags);
 
-	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
-	    WARN_ON(pages->type != IOPT_ADDRESS_USER))
-		return -EINVAL;
-
 	if (!(flags & IOMMUFD_ACCESS_RW_KTHREAD) && change_mm) {
 		if (start_index == last_index)
 			return iopt_pages_rw_page(pages, start_index,
-- 
2.43.0


