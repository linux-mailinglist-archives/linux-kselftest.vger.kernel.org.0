Return-Path: <linux-kselftest+bounces-35885-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A4FAEA5D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 20:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A383ADEE7
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 18:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440732EF655;
	Thu, 26 Jun 2025 18:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ly6si8sA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73C32EF2B7;
	Thu, 26 Jun 2025 18:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750963894; cv=fail; b=XlPq3+jieDI0LM8LDj8j/X57rm7WtxhYsGQDvTIJXuLAbALkvlMkpYYfccKgqxR9ZpApjojHsvJZuoIW73IVwCuvM5F5jpwKeTS/92XY+wx3DuG6F4KLnN7j6jLsJSfxXCiyiBeDIvd4v1/zclfB38edbvwTEWKT85SjSbW1+G8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750963894; c=relaxed/simple;
	bh=MQBYYfFBYc0icLNa+m4vTEd1OauDVVYR5oCNE6HdISU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUjwKCgZKMWF8cwi3tFZRySzUGdEdZxKzzx2XGn/AjShJs7m4uJGEdlwJjop8u0Kd04oE3VFm5iLk6UjdDJ4gHN9cbykldy24WLXFV1mFuuOZFWuD988pFr+SgDIGFZplKFBbl3sGhh4FgL/I7O5LNT32hGE7x3LZi41XcX/M6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ly6si8sA; arc=fail smtp.client-ip=40.107.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXJAxzTZjsw8+6Z56j/ElJ1lWlq5LVgEXvm/X/2sWCmUaIhJ9kOfsupzwy9DA5C5xICoPDXzet7gRgin0OZvpmcs2eolqq27RbTTYB6ayycHX/79UI94Qdqsg1c758HpIJw+JAFverJFo9khneB/tCUk1GgrkL960kCIxhMiao5WuTxRz7c+W+lvXZnddboLKOjHsrVGvG5lF2NIoj0YyK7WEtC6m2hVRLcEEVJ3tqS19+6+/CqNSskfj5sKW4DtpPkeqHp9xRNyZ/aFrgDzykCGLultut0IUe9fiqqq1DQjqgOtaULpCiNh3QaM6PSDDlkvoCxAbmGsz7qXiaJimA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c72Z9O9saelQ2PiTas1hlBTIi4z5XrASYFmkl69P1b8=;
 b=P87uEi7A/7JboegqCLf5uDuZdWf/02OwOt4Y+WQ05e8mcNETgbDufqn2VuvqDQO6pNdobS6g50kQKFge6/gyLq+LfIuyVuYP2x9CiQKIghl9xPj5rjYkpGYRXOdO6y9nJ4MrBG0F5CahLQLVi3OgR6KAqbGPYJpUGiC/T/YeWt1avsJd3R5nRtiUVvMM0N3rlEzWlDBF2INjEbtYcD8Ga8TiHxCUxiUWxR1cYiwqzkbF3aC/cRlllE96KS/n6eEbMqx30WpdNDd8brutE+W1W0sXXnxPBUB2K93ONS7xX3wXAWarCMWL+My9ReqZnAYD6KbuHfegAlW/ItIy+icQJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c72Z9O9saelQ2PiTas1hlBTIi4z5XrASYFmkl69P1b8=;
 b=Ly6si8sAZWy4NLqovXIlNwBvTpw7CwI5xA8xPLu5u+KZ3kphq1eJ29OW62pmoDsALEneUoRQzCTwA7PBoqy/f9fhqzj+UkR10RCLsOSms6ZcdGnBZC2S5dK0ZjHl0uyT3ZQ99xzlJyoLKBvNBU88gX0lgA4mFT0BCp2v9OAIaiUGLCIejZx7zR5bGOgOOTBZVDnnA3wRh/lbzz2P7AvIer1sSY4hgmIDM4twm+zJun7Z0Zf2p7Sj5dn7Aq4122IXk+Z2HrPJ5lk8Pm+WX3vL9ohtschVlaYXcaMWDIp+M6KWtBh3sGSdQcyz6FqG9xWqiReT6kYaqzfMXIdyzUo2rQ==
Received: from DS7PR03CA0083.namprd03.prod.outlook.com (2603:10b6:5:3bb::28)
 by PH8PR12MB7181.namprd12.prod.outlook.com (2603:10b6:510:22a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.33; Thu, 26 Jun
 2025 18:51:29 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::3b) by DS7PR03CA0083.outlook.office365.com
 (2603:10b6:5:3bb::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Thu,
 26 Jun 2025 18:51:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 18:51:29 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 11:51:16 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 26 Jun 2025 11:51:15 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 26 Jun 2025 11:51:14 -0700
Date: Thu, 26 Jun 2025 11:51:13 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>
CC: <bagasdotme@gmail.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<shuah@kernel.org>, <jsnitsel@redhat.com>, <nathan@kernel.org>,
	<peterz@infradead.org>, <yi.l.liu@intel.com>, <mshavit@google.com>,
	<praan@google.com>, <zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, <vasant.hegde@amd.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v6 24/25] iommu/tegra241-cmdqv: Add user-space use support
Message-ID: <aF2WoRtkhCMw4Nut@Asurada-Nvidia>
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <f13ad49a67774edd3578b8dccb9f363faa2f1df8.1749884998.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f13ad49a67774edd3578b8dccb9f363faa2f1df8.1749884998.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|PH8PR12MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: a518ae83-7768-4082-46c3-08ddb4e2761e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cQtAq2u/2m5DzWtVIrjppZq4S29bDmQhdJidlFnXp1s0xBtjEwLNCfteCg4X?=
 =?us-ascii?Q?gUytKLph04XIWkhFLn2DgL1VQrOBYcL6AgGk0T34hDozQa5SDOd6w1vSPo7e?=
 =?us-ascii?Q?fGSMqi65LyEtEub4VbRSN7Py0S2kk81A6ycfa5a+ROUz85EgGRbtRQXj0M51?=
 =?us-ascii?Q?bHP02/y4VbBKP/ERAIg2/nR7kUWkSIWWZz/UBFGqo6yCwXGgz+UcQg53+UGZ?=
 =?us-ascii?Q?c4sYZ0SInCKTDUwtwXbMkNZKv37gohq2SvW6uJAkCTxGfsQY/ERoNQmsvRve?=
 =?us-ascii?Q?khx/CGXz4ewWdaxA+WuQYwni4bt7gVXAcZndgmnjJA1l/VNKOTnWyi0Ji5+i?=
 =?us-ascii?Q?wTNbDQUe7s0j8GCXsnbA6ZLCQ5qvR1bNhr0WP/WVv39Z5KASW8qQJKvYmFMF?=
 =?us-ascii?Q?g21u0UnMX1AIhrYyscFNcv4pHU9US3NVfEGv4KZEZVuMyPhQR1s7xkv6K1x1?=
 =?us-ascii?Q?HDWc1I6m+S3FQUhKEX0IvEmSKd+CG+0mB6CyxXE20iJu8QH3VqLs8fCVS5b0?=
 =?us-ascii?Q?yiCDTCoq0h6sPIgjR8x3j64gfWhE33f1aT6JOCA/1rD4vXacuhFZeiL32KAB?=
 =?us-ascii?Q?XSSC6elhHf0tuAnBU9IG4PHzJp89/0d/lHNllWC60vxLKEgrq0rZG+2RuSKD?=
 =?us-ascii?Q?kcgr6fUoexQTeBxnd6cdkbPvQBifCmWAIF3/sSwGkRsKmENW6J9IGsKx/L0q?=
 =?us-ascii?Q?Py+HYhJPFmUUcDwpJaBhlgLZgWZ0cU2E6jjidN2rvH916U8JwiHwfYJ9hSnt?=
 =?us-ascii?Q?HkcbpqTrSF8xQaQiCrWz1gYC/N2SE6vajPTezeo8xlL01Nzsb/oPGh1erYVp?=
 =?us-ascii?Q?yL46DXTC37CsKHuNQVDOPRcdyJwPLmbiSJBgpVjDvPCYRCwryHX6WJdP8dvg?=
 =?us-ascii?Q?l0GR3MY8EdHe1OB9HPTjOqq4EE/Kd5Itf0JXqLzQ7Nhj8+1i2Gy9DmZXX1L7?=
 =?us-ascii?Q?xIPOE7Llku0ekQm8ceZhXEs0HYUtX7d4NhGcZfkDLrwWn9KzTy9yCzJNLcwd?=
 =?us-ascii?Q?ZjWmc760gU1tiqbVrBxAaQb+LGdg0WfD1TKF++NcXt7AAo7OadKXDsjTYStE?=
 =?us-ascii?Q?946x6GVH4HoeRdykeWWhInA7RNE10t83YG5v+EkUfjXAmgLGcyOt7EnKHiaF?=
 =?us-ascii?Q?u8lk0U1vF4AE1qo1rJI8/pzLAItBNMrnp5IJ9KfnIWRzH+zmqphr951VjLJG?=
 =?us-ascii?Q?vGkGgs6cTzp0wTEr89WUUNwjpvFUua29kYlGnVZ2swEpcWyWIjoOMsNpx3N/?=
 =?us-ascii?Q?ZC3I81COxWJzj9DtqT3U34cU3vubgf2Q6E7pM4x1pNoNaQ2X/tSCA7IIK+ba?=
 =?us-ascii?Q?iTnV3ZidKYhpj8vD1en3uL5T8CxLtq0XWAR6Sr7dk4xM9GN+hZHGv9PZXEsD?=
 =?us-ascii?Q?225F5TmgjtWrW9qe33cjo2DwoH84KP2PSTNNkMj3xWYfTbhv1a/s8BLMdTKs?=
 =?us-ascii?Q?6UmoliutnF8gQj/efEuUxDr+kYw+ZVYbd9LcmpSIWZECMsOraSRfbLR2J8zq?=
 =?us-ascii?Q?l2qzbLB5YW3e/m/Oh5wzuDUMREnSMp+OYuCd?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 18:51:29.2763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a518ae83-7768-4082-46c3-08ddb4e2761e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7181

On Sat, Jun 14, 2025 at 12:14:49AM -0700, Nicolin Chen wrote:

I made some small changes:

>  /**
>   * struct tegra241_vintf - Virtual Interface
> + * @vsmmu: Embedded arm_vsmmu structure
>   * @idx: Global index in the CMDQV
>   * @enabled: Enable status
>   * @hyp_own: Owned by hypervisor (in-kernel)
>   * @cmdqv: Parent CMDQV pointer
>   * @lvcmdqs: List of logical VCMDQ pointers

Added:
+ * @lvcmdq_mutex: Lock to serialize user-allocated lvcmdq

for the following change:

> @@ -154,19 +172,41 @@ struct tegra241_vintf {
>  
>  	struct tegra241_cmdqv *cmdqv;
>  	struct tegra241_vcmdq **lvcmdqs;
> +	struct mutex lvcmdq_mutex; /* user space race */
[...]

> +static void
> +tegra241_vintf_destroy_lvcmdq_user(struct iommufd_hw_queue *hw_queue)
> +{
> +	struct tegra241_vcmdq *vcmdq = hw_queue_to_vcmdq(hw_queue);
> +
> +	tegra241_vcmdq_hw_deinit(vcmdq);
> +	tegra241_vcmdq_unmap_lvcmdq(vcmdq);
> +	tegra241_vintf_free_lvcmdq(vcmdq->vintf, vcmdq->lidx);
> +	if (vcmdq->prev)
> +		iommufd_hw_queue_undepend(vcmdq, vcmdq->prev, core);

Added mutex to pair with tegra241_vintf_alloc_lvcmdq_user():

mutex_lock(&vcmdq->vintf->lvcmdq_mutex);
...
mutex_unlock(&vcmdq->vintf->lvcmdq_mutex);

> +	/*
> +	 * Initialize the user-owned VINTF without a LVCMDQ, because it has to
> +	 * wait for the allocation of a user-owned LVCMDQ, for security reason.
> +	 * It is different than the kernel-owned VINTF0, which had pre-assigned
> +	 * and pre-allocated global VCMDQs that would be mapped to the LVCMDQs
> +	 * by the tegra241_vintf_hw_init() call.
> +	 */
> +	ret = tegra241_vintf_hw_init(vintf, false);

Revised a bit:
+	/*                                                                                                                                                                              
+	 * Initialize the user-owned VINTF without a LVCMDQ, as it cannot pre-                                                                                                          
+	 * allocate a LVCMDQ until user space wants one, for security reasons.                                                                                                          
[...]

Thanks
Nicolin

