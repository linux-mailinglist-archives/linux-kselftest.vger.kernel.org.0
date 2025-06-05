Return-Path: <linux-kselftest+bounces-34356-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF91DACE8FE
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 06:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0302E1896ACF
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 04:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC854146D6A;
	Thu,  5 Jun 2025 04:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nxmIL+2L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E13D530;
	Thu,  5 Jun 2025 04:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749097869; cv=fail; b=kYd1m+3WtMWqGtmKXKExT1L3KmkkTf9Phkdzrwc0pOt9Sdvn7VoS+KwfvuHTjTNaBImRCA/2bDa7fdsVn4XOi9NVQRlsLfMVE9egWR1OobI3w8QDq1zkY9OOp9Qa+ZHVydUrECAf2sP5vSPWgLm/kF0d1c67DLWpWmFJSn5+i/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749097869; c=relaxed/simple;
	bh=hNTqxbvVnAOkXmqbK79/9J3JOTwFDOwJ6ynQwiLqQjk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7AHe5KrFAKBO95DR/Phemg32tQL9HkQ0kd0nEbFo1vn8EnrmajiYXct3oTsb3OaTfe2AYx4NDy4VPwkqlhoTuLCQt+V3gJ0WHni6tAN14ir4poCr5dHVpDx8LUMJOCn7YcH33RDZ/ZACxeJQQU5TT14Z1ld4QMSLOWY42bR4kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nxmIL+2L; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GmVN105MMbiHb6TetFj11SAxmrt5WIIjRxvpEbEblVdBexJQPaQwXDsD8CG41oVbzqTL/T9F0NgY+mYA8Et06jqFioOat8NWQUHKBPW2LQ59TnQBBC214o5RlkpmJk/q6tH6jukjyAu6RiIEee4DjPMEjJvrxy/p8GQG4z0kPzzG/MeIuU2Hksm3pBEMoT/zcuIq6JqSXvZltegvF4ruBpDX/KPVM5Z3GfWdHqq+woVFQ0YlKWpZK0yT9A5LRJbbe8QZQkA0lTLQ1lFQbG2/Swz+67Sp3leWlXDKbZ547aJx1pNyeSbPxqOywZL8nerRwE2WDWMeT17pI+TIelYmjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Graq5oPHM/ZTYuWvaLkdJcd+VeT0j4xdlqa4jEASiQU=;
 b=GIjAtyybcCIwON6LBM4+6V1RAahO7kp0GVHDCYcf9yF6K9t8R/igfk0XTiXkVenoN4SBQ+K2LwtHSoKAt1znT5leOsnb0cQjZ0sL2Ep/9hGA/zSRJzzhhAxfKXXaKWedFMhUn+bEfFhJlgTtmeUQGd9SiDdSF0sP7BhHVaw5w9PbOcb3nm8gdqtB2uVL36Bz/6+7SgdX4QGcxUOQSWpVu6o9oGUL0os/qhslUFR1Kn78NHdCE7K5zSQQJtQ+Suz9iyzkrDtvJqBEzovMdqpuo4sPf0pHwqZQbAeIfWNweSYWY/Df2DijlFGdSQaVSv1yoUV9pNMJ0NKlmoGj+v6IEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Graq5oPHM/ZTYuWvaLkdJcd+VeT0j4xdlqa4jEASiQU=;
 b=nxmIL+2LS70BbUbBaQED1AtNuYgfXruLYnxtxORyd3gMj7tnzyDfIdFqGG/d7KxS69lpwlu1paHwWPG8OvW2zH5P7ueoSpz5vT7g3QZgC01BVEs0jcCNzf4RASoFLUTVT6m9NmIO7JyQSJ07o7931ePWI0cCi1NGXuxe/w8m5oU7M5uXtJXuw198D+A5BxVW2ec2tBAA5ha4Ymt5TOw5jX0RrdLiL7oiqYstHgYzq57H9zW8Y9x0s/CgLYL8HKYzoYtv1VaysYS0ob7dddmx8QPd/cs+rDJt1FhEVG8wc9TXYUOx9belA2QfMsY2PZftcx5kNwkQPH+we4NDob30kQ==
Received: from SJ0PR13CA0055.namprd13.prod.outlook.com (2603:10b6:a03:2c2::30)
 by LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Thu, 5 Jun
 2025 04:31:02 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::c5) by SJ0PR13CA0055.outlook.office365.com
 (2603:10b6:a03:2c2::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.15 via Frontend Transport; Thu,
 5 Jun 2025 04:31:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 04:31:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Jun 2025
 21:30:42 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 4 Jun
 2025 21:30:41 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 4 Jun 2025 21:30:40 -0700
Date: Wed, 4 Jun 2025 21:30:38 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <will@kernel.org>,
	<bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 09/29] iommufd: Do not unmap an owned iopt_area
Message-ID: <aEEdbha8TNCUtTgQ@Asurada-Nvidia>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <3ddc8c678406772a8358a265912bb1c064f4c796.1747537752.git.nicolinc@nvidia.com>
 <20250528170845.GX61950@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250528170845.GX61950@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|LV2PR12MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7dfe08-f8cc-4a15-239b-08dda3e9c6ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k6PWESUSbdvB68j3UHO2RXSMnMciwn8KuWN9ZzoNeo1GiQxifUtOrUhzN/Mp?=
 =?us-ascii?Q?aYS/BRNokUMrAs1Dfyf6tpMB8ywR2Pydd83PdFSAr5gcjdxL+v9LX6SsMmwM?=
 =?us-ascii?Q?eE+WRmJt4/FDNVRPc3buoTKPAyhl0hMAMw0vElt76qG8xDtV6z/KoUGqd6Lq?=
 =?us-ascii?Q?GYL68yt7cp4Vxg5LrqYlPWvpHqknDJiTUgoFko+g34KM3JzDiy6tdLxwDtR4?=
 =?us-ascii?Q?iMXW3Le+rtPHhoesnVRC9xt84zrGo2JEwB9wJjt4yLHslfSvMJ/HzvMEpiOz?=
 =?us-ascii?Q?zd3A6LPiDpPKZ6hD5+Oj0dBEYCC+UOPwGtR1mdYJCLBhvS/7cLWYU5UWFrpA?=
 =?us-ascii?Q?k0GRIiWfJfhjY/VViTmzdpAuBa8uRT2VdB1kPFAn8HjVq8WdxKlOsulfAVqb?=
 =?us-ascii?Q?PwwMwoXXW2MS591YzGkmBKD/vqsD0ysLw/eSzRPGMX4yskCY9dYUvpE6ZW1c?=
 =?us-ascii?Q?8qib+26jTUxsCKF3agg+Xh5NxiFvxzECd0EvPIfiWckhicO0V87/c/ZuT0yM?=
 =?us-ascii?Q?xiGVG81sVOoAui3szHDVz7VK/HQfFg5OjRlDx4hSZ3dMeH7vYlf4hKiijkJ9?=
 =?us-ascii?Q?T4c0IeQ159H/e1V4LZl9bUcakePbZHDQLyFTZ3zYMEStQtXYcx+3Y9/if3tk?=
 =?us-ascii?Q?rtqu8iHb8WCryhWlpJbXMervoCE51hwv8PIht/fF9MyfURKJG3U3YV7uLTeU?=
 =?us-ascii?Q?Mh7e5v/gv/MUgyPPkGxpfjiqxfvJWlgMxtApnLr6kfwFIx6zyGOh57kBKHzz?=
 =?us-ascii?Q?zLXUoAVLFooKAlpYMIBbmE683NwlubWB5HlS5ulY1IUpbNuJrcTehDAc8kS4?=
 =?us-ascii?Q?ilEFsTaPffbQJBKnwtUmPQE9GHweM1jSA3VgJd3tc9VSIFhbUdjMqfF0Mjvz?=
 =?us-ascii?Q?q2WS1FDDuM2kFYcrlYMKKZlw+vR1yJ67dpn+4Nt7hJbJx7VODNdXSCgTIXRZ?=
 =?us-ascii?Q?8GxhtJ/XRwtL6dVqUbQRywjHd2D1equBSMJV5q1kYn8ETh49Qf9qngV+s44m?=
 =?us-ascii?Q?ygXcvkeNvFnl0Klt4/TnCYa2ls9GCD3osJQJX6Xw3FDj3yAfgwwOn1kkQ1Yl?=
 =?us-ascii?Q?UPqlPJNs32EFepxgMFYaqpTAdXqEyASMgMAavvGlv9DNVvffQUvQTWSGEUh7?=
 =?us-ascii?Q?YTdEELe8dqbAA/o1zfkFF3saXLiI91olCNDXDRYxWMY4A9xLIZJ8P/lyW0Ga?=
 =?us-ascii?Q?6SEvRSQeQbKRB8v/0A7e+Ddcd0X16kYGaLAOpf64KolO4ZP0943EkBHUjdxK?=
 =?us-ascii?Q?1tftlcTQUit5EnLiBfFLrJnWo7l071sJyL676lajpvAJedg7Pz7vMltXZvMq?=
 =?us-ascii?Q?Ct7bymMnjGdAMPfP3I8MGijW6KerqqfpJOfYQsylc5+Jd5ZaQELr+6a8JGqg?=
 =?us-ascii?Q?SXI0vVA7AiwpgdGDfXR42U1yyPj6vqkf5EbVvQXbBpa/n8FkJeIhK/Z5ZotF?=
 =?us-ascii?Q?qp23vsnqeLRJn9IMEyQbhHxWFLM0MtDCR38/5fPAM72ycWQg8zbc4bQVIkwD?=
 =?us-ascii?Q?PHXDZ1E4r0So6PHHd3p6T+z8m1B4DBLF86Q2?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 04:31:01.5167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7dfe08-f8cc-4a15-239b-08dda3e9c6ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5990

On Wed, May 28, 2025 at 02:08:45PM -0300, Jason Gunthorpe wrote:
> @@ -740,11 +740,16 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
>  			up_write(&iopt->iova_rwsem);
>  			up_read(&iopt->domains_rwsem);
>  
> -			iommufd_access_notify_unmap(iopt, area_first, length);
> +			rc = iommufd_access_notify_unmap(iopt, area_first, length);
> +			if (rc)
> +				goto out_unmapped;
> +

I found that we have to re-take those rwsems to unset a flag:

			rc = iommufd_access_notify_unmap(iopt, area_first, length);
			if (rc) {
				down_read(&iopt->domains_rwsem);
  				down_write(&iopt->iova_rwsem);
				area->prevent_access = false;
				goto out_unlock_iova;
			}

Will include this in the patch.

Thanks
Nicolin

