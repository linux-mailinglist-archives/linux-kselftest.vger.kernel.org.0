Return-Path: <linux-kselftest+bounces-34065-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC88FAC9336
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 18:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5A74E4502
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 16:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2F4235C14;
	Fri, 30 May 2025 16:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kmAeMTOT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE27228CBC;
	Fri, 30 May 2025 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748621701; cv=fail; b=Il+V8MKA5+PHugo6izcmMpB6ZrN//LiXY0xx8oewtYQtKINduRBc8DbCHUrA91cEJG3jT7J9Wk+XYHfSCgcklwUKB3svqgOV4KvNNJdsuJENak2xtLt5keAphEbAEZZHuikInkqE2QGtgVKsYUvT/brdRmiQRgKa3bqT8C2Ibcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748621701; c=relaxed/simple;
	bh=w70q3Ool4KdBjh/c8/d5HFCU2lOOTaGAjcS842Pe/Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TYkxjPz0K7QTLqXFa58ExZO8FLD6Wv1bBN7hEhszf/RVlAjxf8muXG0XyBYTq4dBt8dcky7o58tqeA3ZAVJXs2N0isQH0C5abOBAwatIPtCWTVxQkySxZr7NqnC1vv4oZarYqsMe1oAxs20F/6zsXOSFLa/8VEfkiV2fwi8SSm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kmAeMTOT; arc=fail smtp.client-ip=40.107.212.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GwnluDTtBdGhgoFnEnd7BeGmCc8NisE1TKt/Zw04NEWoapigjM71Ej8BMmqUjxcYbWbcc4kICucYR9Vb4UZNjgFojguP3bfvz3l2O8hN+yU8ct9nRyfBSGxCCriHdf2zD8NybeaoXNX2ACNNBsul8X/5YQBGW9psntsLWROm8GxgMgzpiL+KFhc1FYA3M0JMYzeTGi+9XN+qELf8BqioEVDVRvL0idiliSxezEs2IG+o1avJ5eD2rtGolJr4gVRjbzUdEQd9awRc6mD4zotQjCeruLr7mCVn1CU5g/jfuawn/1a35DqTj81IyCHqqGhutOnfqh7oJGPuNae9KxNa9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTdepE8kyjLu/HvAo/xjO+pe0c6XiDDailkYku1K28U=;
 b=j2LOYpgw6qAPUCiKwE0+2vmLnCba0rSPms9c8jqiN2t/6Dw7K72R5TDnxiXZA1nWui+ytoAqholslSjWr/KYi1h16BjbGsGfZt5w28obE1ZKA1xWqMyaQ62/d1Ssh1M6fpXXNX/0cEuoE1GUglyGgFbqoPiEn5+c8Y4gKdGkaaP0Yf/ZKsmXlQ3GGn0WJ/KFsXDuySIUs3swLtLtSyKPFrv6t5RujHpPT+7UQGbycyuQwDYZFYx3nmmeTF+MRAaTkIr/4DUrOl+3MWmA4eG/q8ObGy3IQmZCTwVJ5zMal3UmTSn2cyLyAeBhUVT4W5Xhvictx3fO7SoW3J2GLZv3SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTdepE8kyjLu/HvAo/xjO+pe0c6XiDDailkYku1K28U=;
 b=kmAeMTOTTt/UkvaLED2Au3ikyZ07d8uHwSlOIj4LMUN+9+FCdSfhwya8z6oiXbpq+r9ULnz4wUEB5U5MuT7toqOYPkXWwjtk+Jk80DV/eaJ/dRSEua9SxoWLaXngtuXxIu9gFR5udtpFcc+wt1hf5JoqGdo9FEINhRHe0JNy3hAEeTrgJDv85gLyQCEAHGdaKKFwvx+o1P+Ih5BOby0vDpF2Lci3tQExKfDUIhNuGtgaEvmzLOuN8bxgfXwEvT41dF2jiM2xfH9V2nW11hGiAKjFCkLLbw8F9U3sDcTcsy4opmhKIzWlcvxwkZtyhpdnX+qCrO3Qkx6SYwJNv8fpsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB9475.namprd12.prod.outlook.com (2603:10b6:8:251::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Fri, 30 May
 2025 16:14:57 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8769.029; Fri, 30 May 2025
 16:14:56 +0000
Date: Fri, 30 May 2025 13:14:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v5 14/29] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Message-ID: <20250530161455.GE233377@nvidia.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <5c509f092ba61d4c0852ba57b530888ffb864ccb.1747537752.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c509f092ba61d4c0852ba57b530888ffb864ccb.1747537752.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BLAPR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:208:335::17) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB9475:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a9dd3d-b515-4662-e3d5-08dd9f951e68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mDF+jXnPzoXQR+DGcxGHwFvCoh72csw5lMLRlRS1Ch8Av2/AECP9eokpFfbt?=
 =?us-ascii?Q?HCQr4YF+hjBT9yGRuVE4rgpIyHYi3X6tJFQejLObbMuRllmJZmFenCjQl8rl?=
 =?us-ascii?Q?m7BzCP6YPlTn7Fgn6RksLv8hRk1x0knvKAxTLGW+mnECmY9ASx72AApH8Kuc?=
 =?us-ascii?Q?GSssafRlmZX+2AH74Qu1xN0X36E/TKkPQb4wjkNIcbHawPbir2VbzIBQv2tc?=
 =?us-ascii?Q?IN4sWcIakpCn7HiqnYk+DuVWX9zK+m2OOFI7HUKHM1vr2IPcV/PjHc3Bqkpp?=
 =?us-ascii?Q?Q8QPf4rca8pYLfrbiY0h8xG8sYxuK9BEMAjmGQX1YW9Ic84YZbx5jtpo7QIU?=
 =?us-ascii?Q?ySC6RPB6W+IEcSL8orjzwpMZuT6wPtrzL9WHmdutrvibImVNLg6qQNjTqCf7?=
 =?us-ascii?Q?3UumQ/yNNPIB52LjQUR3WRY/PKkiGKrJ5UHaZzIkhtCXTQu3rr4HPolPxOdz?=
 =?us-ascii?Q?oLgtbna6KnY8qIIapI1p8hOxKLEAbk8w5fw4Xn22UAa3tOawvNDW50J6c4Gu?=
 =?us-ascii?Q?c2UIE+RVBn3791ppbVG9s3RMdmNSZkZVrmhhWX4JTvbXTM2FmaXRl/FMUHTo?=
 =?us-ascii?Q?2xHxUWVa3lkYUk9MxHWH3PFx9v2r0C1WCieIX8swGafoBh+Jnw+I+YsWxQWD?=
 =?us-ascii?Q?54tJg7tPeimiECCnE3/9XynwYlFP80UTH1pEQeRopIrcI0fKDOfMdARRzWKg?=
 =?us-ascii?Q?xo71rKRU8/y2pozwxIGOrIVQ1t2fHTFFBT83j5A8Cpl30EooE2G5rDxfzGUd?=
 =?us-ascii?Q?GMw8W80LVGugJxcXOexYzc9955wvzcy/aKvz2KC3gpX+bQsb+GZoPs2WEjJY?=
 =?us-ascii?Q?69MbiuRG8xBR0wjhmEgseZPVOZTxeAPIGyb2DhwW30EdvdFvOalkt+m81I0Y?=
 =?us-ascii?Q?EQZ5x41Em6rbApnxFO53/LNBR3oeKK3i6Dh44/VijC8LpJXlpWBxwYodKDyy?=
 =?us-ascii?Q?tNunz4ASSwFgEcyg0f+YFbZVjjLuLm/OYJKBjqrvtp9fjL8/mwe1ZVhSJsKY?=
 =?us-ascii?Q?T48Ehi1RUHGoLrd6Sl9a/SZkbmhTfRFZVnBilo2/QhU9wRJMmVCuSNBhjnXY?=
 =?us-ascii?Q?yQU5Go3PTFCl+FShNPDgb+u2ZKSnKzuAwuWzXKK6XleMD6IxY0ruOhXPqnKI?=
 =?us-ascii?Q?TSkRMeAiRuIJN/V0oJymfRQVmbR7Qjcx5+XCyX3jKbjDmRurNIdC8ffNPXQX?=
 =?us-ascii?Q?su4nFSgYWEU3paDcG+KTjZmwaLvYRqoG/qhIUYSHBV2XibcyGRI8G9/U0bh6?=
 =?us-ascii?Q?qgMxGldBV/pbcwp+DDLsR92GpfkajF8XZB4MKxSQ7OV/2/yzKPXiq1vTeGfb?=
 =?us-ascii?Q?MDjk1UlU9PILxn5zK5S4v4KbBYcw0ufGwXhs0zkXnJBfzWIXVGRFrU9sYdkf?=
 =?us-ascii?Q?6N5yUN5pPAbVUznATj0iimCNsmaNYJ+M0j5qflo2kyqK9H6Hq5OlBgzBAYXR?=
 =?us-ascii?Q?qBtVT479PM0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f2Gw/px+AqR07OF+UM0jKAyCnFBmCGp0y+rs9q1nia4vUlHMeiehM8dnLf7m?=
 =?us-ascii?Q?Fflfi3vBVhHAWpVT0nSJyLHAO2M7MgCL2itoMKSRwY9hYT0FbS8AL7loLEQp?=
 =?us-ascii?Q?J9fstjslZf8NWAYccQ4l77sugy7D9MIXVgAds2wOjtb78SA0GABR6lJM6tz/?=
 =?us-ascii?Q?6ErG+6a3hymmp2FKxvshN7+O2H/3pB5BSkQV14MXmvoTc7Z41NOtzG5uoAYx?=
 =?us-ascii?Q?q7/wb+Nnvgg/e5YSOYqm+3Td61mBl18CsiC0Y7+JX6XRKirLYAMnfCGeyUbU?=
 =?us-ascii?Q?V/RNlhCqPWyTc5Vn3tJFJStlg0MPbSoNKPmgpmCCjotuFzib7Di8bNhVPUG1?=
 =?us-ascii?Q?9Kcm5OzVf7xXB+N5HUyLPd6uSlKF8wMAamLndEu0K/yCoSF7dzpgx+wy3Lmq?=
 =?us-ascii?Q?M8EB0yFV5ulpCh4BFna2Wi05rYPSXaWA2E3vaBYMu4b3zywj9zHg0HcyOz09?=
 =?us-ascii?Q?d8UDKZGq/GGAag1BSYhJ7x4cIDGj0powLOMlMhCj1TT9kSmJWX7VpP4ZRZt3?=
 =?us-ascii?Q?LAh6s+Zy+3pxRjDnyUNuagE6s9aTrBCevx7WXsymdI2HVU10W7BEoNlRZ+l+?=
 =?us-ascii?Q?5B9yTPP5Wr+/FFOAbVRHbm6xrLFboJiV7fvI/6mgp7g7a+84rCQp0GoGAwCU?=
 =?us-ascii?Q?tN9jiXk8PLFo8s0pr+xN5IPpcP0D9dHg7E/ULlwJ+0lomdWvANlOkKtQovRg?=
 =?us-ascii?Q?oKNekNNh8ZnZ5569nxY6GpOpcYCKy7Cd15Rbbk/kXij3usm6kGGbHbQASkuc?=
 =?us-ascii?Q?z7qJBaw73B4YaQMzTJLJiF1DnG8W7MhBYiMIcEyXunV0OBh2A6r2fIs1fko1?=
 =?us-ascii?Q?5seJUounI3AUwXKk0rr1bCUduCKsNWZBP+pJduP31n+c9s2Dvi06yTPzoTHg?=
 =?us-ascii?Q?+Ug82qC2KVusk/Suk3B4p3gGuI7Z7kSAe6g3F7GiOxbyBZkGb/XHAlho4yP9?=
 =?us-ascii?Q?nEQxsRGG2z39WTStbyXW8/DF/gWkw3o78DYWf/N40SE5AJQ74VAuA5Y8frKX?=
 =?us-ascii?Q?TIYRiK5J8foo1/y9mNFMbq27ADAZjbIIovOei8R9tqZC0rxErn9HMLMyMJXU?=
 =?us-ascii?Q?OREpDul8X0fifWfrcxL8+Ia2VDO4lFjYTeV0dcvOFDNy5CaVY3/uAmKfHjCe?=
 =?us-ascii?Q?HX/mUiU0eijd6+/a3glvPZOCrAtHIbTQMgyOg2iO2N9IoFQAcWLCVGAkInL2?=
 =?us-ascii?Q?H7hTuu/kHrZgCXxjJ1HqjmLLC26hsg9kEYGAUwZ3tPatJzdXuUL4Vx+dpZK2?=
 =?us-ascii?Q?21id5naH+q0upj1nI4eStgU5lD51Uk2rFVgUaX6Sxhwg7SZEPHu3AwoRp0n1?=
 =?us-ascii?Q?lRMhIJd7c/zUC1WOgVd/g4y167+acC51oP+VWLl702iZ1infyV/aprBe2C5X?=
 =?us-ascii?Q?nRgVO/kd/G6b6v/sKOdOk9KvCQJwXbQRrNBaB5P/OU2eGKGFggh/+C/PjWlo?=
 =?us-ascii?Q?PfFQJSGUDWrYEh65vmr7sH1obgCOvZ25DVTL8YRgN40m17H49kob68XRmNp9?=
 =?us-ascii?Q?WunrMOZTom1JzI0sXsaLXEOVc3KyZUoxsq7PVy+ORFxjA9seydyKC60zIcO2?=
 =?us-ascii?Q?1XfRv048PU67jid6pCo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a9dd3d-b515-4662-e3d5-08dd9f951e68
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 16:14:56.7616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Smp63na8PzknjPBqddHbK02HNYZ1N3tXMDiCl0I7P0Mg2S80ZkQlwVEEXCT3auEH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9475

On Sat, May 17, 2025 at 08:21:31PM -0700, Nicolin Chen wrote:
> +int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_hw_queue_alloc *cmd = ucmd->cmd;
> +	struct iommufd_hw_queue *hw_queue;
> +	struct iommufd_viommu *viommu;
> +	struct page **pages;
> +	int max_npages, i;
> +	u64 last, offset;
> +	int rc;
> +
> +	if (cmd->flags || cmd->type == IOMMU_HW_QUEUE_TYPE_DEFAULT)
> +		return -EOPNOTSUPP;
> +	if (!cmd->nesting_parent_iova || !cmd->length)
> +		return -EINVAL;

0 is a legal nesting_parent_iova

> +	if (check_add_overflow(cmd->nesting_parent_iova, cmd->length - 1,
> +			       &last))
> +		return -EOVERFLOW;
> +
> +	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
> +	if (IS_ERR(viommu))
> +		return PTR_ERR(viommu);
> +
> +	if (!viommu->ops || !viommu->ops->hw_queue_alloc) {
> +		rc = -EOPNOTSUPP;
> +		goto out_put_viommu;
> +	}
> +
> +	offset =
> +		cmd->nesting_parent_iova - PAGE_ALIGN(cmd->nesting_parent_iova);
> +	max_npages = DIV_ROUND_UP(offset + cmd->length, PAGE_SIZE);

This should probably be capped to PAGE_SIZE/sizeof(void *), return
EINVAL if not

And we don't need the allocation if we are not doing an access.

> +	hw_queue = viommu->ops->hw_queue_alloc(ucmd, viommu, cmd->type,
> +					       cmd->index,
> +					       cmd->nesting_parent_iova,
> +					       cmd->length);
> +	if (IS_ERR(hw_queue)) {
> +		rc = PTR_ERR(hw_queue);
> +		goto out_unpin;
> +	}
> +
> +	/* The iommufd_hw_queue_alloc helper saves ictx in hw_queue->ictx */
> +	if (WARN_ON_ONCE(hw_queue->ictx != ucmd->ictx)) {
> +		rc = -EINVAL;
> +		goto out_unpin;
> +	}

There is another technique from RDMA which may actually be very
helpful here considering how things are getting split up..

Put a size_t in the driver ops:

 size_t size_viommu;
 size_t size_hw_queue;

Have the driver set it via a macro like INIT_RDMA_OBJ_SIZE

#define INIT_RDMA_OBJ_SIZE(ib_struct, drv_struct, member)                      \
	.size_##ib_struct =                                                    \
		(sizeof(struct drv_struct) +                                   \
		 BUILD_BUG_ON_ZERO(offsetof(struct drv_struct, member)) +      \
		 BUILD_BUG_ON_ZERO(                                            \
			 !__same_type(((struct drv_struct *)NULL)->member,     \
				      struct ib_struct)))

Which proves the core structure is at the front.

Then the core code can allocate the object along with enough space for
the driver and call a driver function to init the driver portion of
the already allocated object.

Then you don't need these dances where the driver helper has to do
things like set uctx, or the core structure is partially initialized:

> +	hw_queue->viommu = viommu;
> +	refcount_inc(&viommu->obj.users);
> +	hw_queue->length = cmd->length;
> +	hw_queue->base_addr = cmd->nesting_parent_iova;

When the driver is running, which can be a source of bugs.

This would be useful for the existing ops too.

May reduce the size of the linked in code.

Jason

