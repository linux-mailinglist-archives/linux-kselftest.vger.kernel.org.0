Return-Path: <linux-kselftest+bounces-33093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70132AB8CFA
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 18:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07993175027
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 16:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE70253F17;
	Thu, 15 May 2025 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GBadFvV/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6C419D07E;
	Thu, 15 May 2025 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747328302; cv=fail; b=S8S4fx/4bY8Txz7K5ADRCHO6B18OC5mRf2aH8RWzTc/TniBlCgsl3VytIOmWKxyB+ZaI4vHFEJjPgs90ABc8I8wgYB1o17ZXQ0sfUqbzd0btJpciNN4wOzkb6bWwk1bpF8ESWIefyAtEKERIh5BVN6mQIxsrNe90QB2kg3BdwIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747328302; c=relaxed/simple;
	bh=BpZCbCZbCbJ/I8bHVhcmnvZC5mBK4iPUUonGrPcOqJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I5+mky1LKNDc0yVKWnxcqSskfubWrduQjnQUbqB1+C2pPbk7xDhpKYQD8SpfUVl7sltKPcysTfvUHg5bJ9ul8pmzJKRX+GzfQ3CinZgxylOv/LJXUhywNjNcewRi2aultcfg1X4Z8SCk1Z3RNCiiwH5byDXKbvHEeU6vKqjbO6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GBadFvV/; arc=fail smtp.client-ip=40.107.95.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knEv6gNAAQQWnVjzYBdu08OdUY7LDrys6CwzlrHBC7GqKTfPiNzsjAj9Si/Fedt9tyLL/iRzVDF6U3Z556o6c2wA/9kDrW3GwHxlaSP46pyaM6nV2ul2ZceYmDbVmvhlWxg9unGQjVCuKDvsj3nJgR2XcrWgF4cRypPRF8zf3HGqfcP4Mo7CMaqJriPoZW+DIWcOlamYF+wr6tNPHvNrmGu/PMLXdPEtL4LwRCsL2L8sMadqkKKGOjADRawSM6YcmYR7jZFk3W9Vjz6L3SydJozZTduhk/Q9gjVvi5qrposaPn/4jsuxu82IXgzc782FQse8rhOKnI4+rCUBoyAyUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0tMGBblWPBoiGpU/qm2noQALlqxxWIYIe6ChIBHDNE=;
 b=D1OgeYAHpA/RD5mie7vL8su5+cpVbQW5MYC7vi4EcjP45KDPiTyNuIPt5CEb3kY+KeuKqkDTffnOeQnxJyWAkLELAYFkikCqHXqsRgO/YpiE+HgnPz5YH8+Ued3i2hU1HfqtxDDwylooY+S4gOAZWBgx26kZS0GppJaRLVw94MYBEMC9RZ+OLGcPi9FIrjDxWhQe0xnAaDbx10mTS74E8tN4zl+jkJWllFd+JeeQek+IGmbVmVhevJYvSJJlnEc26OXDR9i21G9AcRDc7durGe80hW1eiixcB27+LAolakq0Jqn7hSgdIZ6EoUXW9bN7fs7L3s3m5+TxMcdbjyeFnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0tMGBblWPBoiGpU/qm2noQALlqxxWIYIe6ChIBHDNE=;
 b=GBadFvV/50hIfaKxHk9ZRAFxgOtZ8gDCRQRDUw3/yD6l2FS/e1ro3zG1hf7kTvVejGqpSCY3/ZeMtsae9JMK9RoVPrIH03MCu6IxRF/+4xoAGYPkx3voHXNEGAqrt7DmDy6TmFMtWEbw7ie9qrLeEgX7VHzx5n4rAaMdsfmzmHoMiLoPysbr5PdMFZw14P6U1+/wJdlc5FfITzg33SqSDcS4p8MSp0vHvKe5/Z5kuZU5o/Dj9laG2Zcss8lS8e1hMmGsKIIVSl6YrWvYB37gOdg4RRX3zHbkUNeVuJDgSX9shk7ng2iACrky6DvNFLUgBrpeEfeN45JV8LbJpdYkLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH0PR12MB7984.namprd12.prod.outlook.com (2603:10b6:510:26f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Thu, 15 May
 2025 16:58:18 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 16:58:18 +0000
Date: Thu, 15 May 2025 13:58:16 -0300
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
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v4 16/23] Documentation: userspace-api: iommufd: Update
 HW QUEUE
Message-ID: <20250515165816.GM382960@nvidia.com>
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <06b52408c31858e39a2fb557fd35f80db965f646.1746757630.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06b52408c31858e39a2fb557fd35f80db965f646.1746757630.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YQBPR0101CA0263.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::17) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH0PR12MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: 951229e4-8331-4183-64e2-08dd93d1b0b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PEA2KwZ76qupiv4D8oG6fTOst6eq4uyOWHgTHb73+QANpHFyA+6XTG9ryAtV?=
 =?us-ascii?Q?a3NjkrLovWMQxysNxGtynWsaFmO+je/Weu137zXZl2XOrzK4BAI+Zdwfs9u1?=
 =?us-ascii?Q?CXcsxbMXBfRjZLN6K54LKEN3+trgfNYnqy0ohS/lynp3actcxwr+rPZPSdhk?=
 =?us-ascii?Q?a1SUXzwxg7YDIPwNM4inLCQGTRqFajbiqNKRSSfyQjUCR05rkjzhyTk/0piS?=
 =?us-ascii?Q?gDXy2g1mYHtJ4r+ud1wxcqdiPmGfeNkOn3uKIkBoH4ST7LfO7CmrzYl5viyT?=
 =?us-ascii?Q?HT8N+8SiE7GwxP6Fr07F3w8kQokrMz7UPks6Hr84KpDQb+6eL5qUeH+qZcpw?=
 =?us-ascii?Q?m4C+L6DBqsUXxY2BYE7Wfkxgs17ZGbmeo+Pg7WB6MIXK/w/rZZF5YomoQaBq?=
 =?us-ascii?Q?4ZIGNX1rA5L6wg4tHV+SxHRkT8SsQxk6M055gOxJqkf5mUG59ZthuvvSIBcg?=
 =?us-ascii?Q?8YCDFhN521p2dZ/t8ednZCcYvqTJdQ/8iNAaEjcuAQob70FEO5acCUzoSQOw?=
 =?us-ascii?Q?EhfQTUtNf+4jcuLqO17QyR4C5gIp0ydoXQRr5n8NAcjH9/ZjjfKvuOKiKwzS?=
 =?us-ascii?Q?oYXfOHqv+Udyc0en2aBOzNH7eKShaYY0mFVEw8OSK0HqX+bJYrCyA01BfUwP?=
 =?us-ascii?Q?1w7EIbmRC/kEUZOQVVoZsmBK93towGLNXu7jYfoy0xDl9AUVYq7Lzy84Fv92?=
 =?us-ascii?Q?R4VQre4PKFryZZDvOOKcBHdPkJKAb7qZFzZAZJZjn7nyKUzqHfaLnjxK2cKg?=
 =?us-ascii?Q?2pW6GS5kvDjSHCxP2PJHlnwwKdIkzMv4+E888zF9EjbaQohXNSdGV9aVmFLy?=
 =?us-ascii?Q?uaBZXcep5WnkqaDo8N24T0wVz1+/w5jZnA3tgPJeoaqB1UsjNWJsaa06krR/?=
 =?us-ascii?Q?lcUzRzANcTOO1jzbvH3tDdVDUg1XgXMIpG7OaJkusZ3o4UX/sv/A7+Go2tvl?=
 =?us-ascii?Q?lhi0qgsCJG69wWJSJY1clC+Rt7JUKs/68DaBbgv3z34j8fcAhztAImNdGn4T?=
 =?us-ascii?Q?Ypqd2K2kfme12wC9hNq63PTD4TiYtcZxt2NhFIQM5tjf1F770ldyM7+R2TRu?=
 =?us-ascii?Q?b3SBUid/kiEi7C5mZojTkq6iSUVPCyUmoQRplnj+ptrIZlzWSw1i6wLCRHxm?=
 =?us-ascii?Q?9SVXT2z/hn436fg0uEYwSjLEN+TGSyYjjjs9YO3GdzmpmwfTh/7lJVHzwX+M?=
 =?us-ascii?Q?lUWnLEqqDA9s6ET2P8KOBrX9PHqHG8F3T5Y3y3S0WpxZsqansz1v8JeyhdF3?=
 =?us-ascii?Q?5ZybuyU5KjV8oFsiStmrjCzZVJFh0GFhVaxPBVUxZZr3TP3Gv65m0C5URgsc?=
 =?us-ascii?Q?tFIESPTZw6j9AL8UJTtlB6p9EVS14t4elG5i7ZSs31GKtyO0n3oLxYqQrNe5?=
 =?us-ascii?Q?v3AQUNYjDRfbg+4XTyd0m0n/oj92IQVz0sgHTJWImFha/s8WFZbA2SsMprWq?=
 =?us-ascii?Q?LSwjXaexwSA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iirftHGRoT3lg7pk4IuvdUccxLxKQx8KbF37C67Vyf+O/SeENJhTd1O7fZ5o?=
 =?us-ascii?Q?8irQjDjSt0SFZ/t21uso82CVtBfhK8ltI8GyE97mfdWJa9sfUFs8ECniq0n1?=
 =?us-ascii?Q?H+gyzg+87jh19cjqmWluQDeqdkNg67rbBPB8MmtRBp+aFyBITe+5stwXSyts?=
 =?us-ascii?Q?rPtK8s2V2BnBPR5MbtMD04GhAh5Nhn+87R6WpcxoYRbDv1elnw6BeZGLTGmR?=
 =?us-ascii?Q?ITAMEK+eoeaQLLgMAK4ffY28L1CXsbh7izxZDfkzdj7bjQC+gPNhDtxMgCKI?=
 =?us-ascii?Q?HE/fjTFDnqqCJzZfsebjLaqL+ZiYuhqJu8pyZqnzvkmkVeKUu/J25RHFz1Hr?=
 =?us-ascii?Q?12kNDQ85FN0hF1WTJC9w/it+bDPnqvSEBrn/dxurSzw6LnxPzaPza0TExjOH?=
 =?us-ascii?Q?ox2NQpANub5nmW95ml+Qxd4VQesHl78c4ROJGBKLl9Y1XHvHqcrA4A8lnzid?=
 =?us-ascii?Q?KDTHaPnOL4AkmceK6anJGPi24sXo0pFJdhV7YYaHs0wsraleBybStDmtN0mg?=
 =?us-ascii?Q?pFYMC6BN1j50K67KDJ+7EMzpWA0f8VE1p1b5pMRtQ2sDOF2D6hR6RptshpxW?=
 =?us-ascii?Q?X3+coHDCjEkHGk2PhCffZAQ2aT7kF32Uf0mjHKW3fTs/VXBUqq7KOsrYzNvJ?=
 =?us-ascii?Q?cDMwEl/jTMO7/4aLtP2zJfKF9eicL4WFObkkVaOI5Pnl8pRHOUVPHDs1DLQ3?=
 =?us-ascii?Q?L8dWjSbbKCekmZk/b8hqUmvO0dXfy9tWWPe08UVok/WpcF8BT6clPgzsWttE?=
 =?us-ascii?Q?mfk0KSSWW1WtexCBYFad6rgA+u44BKzZbVRmV3c6x9HE8exRijQMKiVFKbvc?=
 =?us-ascii?Q?UXo5yZimDypgdJBR0zuMYT8mh3Lta9b5s2AUTKuW4Jz2jo+5PrcbU0Imiez2?=
 =?us-ascii?Q?O+uJ5Kcz1VwvrQ2KuMkwEWyzWeSoIJgHI+SCLqqSVmwV9sEcsfd3BFd4sfMJ?=
 =?us-ascii?Q?IMXuGWCcmNd45aaDgvMhd07ClsshWTBqJBiqRk5me+oLrhAXqYY6K38rg/Ke?=
 =?us-ascii?Q?orebY7pQIkST8mgJJpInhHCOwTYdnHgimbrfQx/15lNUaMmc5shDYApPB/H6?=
 =?us-ascii?Q?FkEuvvC8Hog0+FAYEH6UZqcG7IAx9dqbG7TsEdMEBXLVoIeNkC4BfIs9hd+q?=
 =?us-ascii?Q?1MSYqnVuK0ZLZJq5jps73qyWpiDMLj8zlkaGEEWHOC7uWmAVQw/B0sehkr17?=
 =?us-ascii?Q?ODZUtyoKv8Taenms5oXGw7dmxCtd+KuUTQu83kjXAM9sGBMW0xP0WHL8yfu0?=
 =?us-ascii?Q?A7mu6/EufbuqU7OKpJVfhn3A3e3fw6FV1mx8Y8zxFmAcgk2O6CGpBPBhB58j?=
 =?us-ascii?Q?/nR+UNpMN0iputkqqNFHE49yx66B2b0xEEag3Z8m8pqDv3uAJsiSFUgScGI1?=
 =?us-ascii?Q?Z3Mdgy5Mb0GiLHBUXM8a/zW6OYvhxHCrJaDJPflX84bLFJbpTUB53CzEixhF?=
 =?us-ascii?Q?OVeMNykYq5IF1pi00CGB7uuSVAReUYrHmnM6D3rG/c3tAYTFYKGkSBVtIWO1?=
 =?us-ascii?Q?Gm2UTGPssGbwNy6Og0Fr7GhtRI12578TuhhHZYDZDUAJ/D45O6FAmRckTJ8N?=
 =?us-ascii?Q?C5BKyjTHprF4yBVT+gX5gQksZd6FiHmxjEMfiko4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 951229e4-8331-4183-64e2-08dd93d1b0b9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 16:58:18.1112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZanWuQnkJGU9tlhdp7A70aC4xYlpa31l0y95E1uJi8SdRNgvSU8aRScD/p0ROhl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7984

On Thu, May 08, 2025 at 08:02:37PM -0700, Nicolin Chen wrote:
> With the introduction of the new object and its infrastructure, update the
> doc to reflect that.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  Documentation/userspace-api/iommufd.rst | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

