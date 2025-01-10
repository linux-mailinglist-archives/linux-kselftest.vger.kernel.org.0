Return-Path: <linux-kselftest+bounces-24229-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D97A098C4
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 18:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244631884CDE
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 17:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989C52135AA;
	Fri, 10 Jan 2025 17:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r3y/Xgro"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033E32F3E;
	Fri, 10 Jan 2025 17:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736530897; cv=fail; b=R0r79i9qFPU1bvlsRuc5lDe9G2gPADDUVDwttGEy7fcwUHWzulcb5iIbHOuydhyZ1cItLm6WcxN5tc5BvxIBJcxAJxxIBnKSlg05gMxM/Jvnnv9F3je1sWDNPxs+NZ6bQE5cRa4rafCSn151+9Bc6XcrY4e0/Qd9wFAx3Ipxx3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736530897; c=relaxed/simple;
	bh=Gd70/5Gq6gSmnk2MHgN8njQcaW9pItbGADeuB1U++o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HfjnYZSKGE5WhI41Li5vvKPbcyHnAbf4BI/vvZRjaB0/yjMGlvq1H9h0I1cDUHCyLj1/xoODJC3VqiUMU8YDX9TNribFRoik5tHbX8PuZLoqYUvAahDIAoQlSaGhmbK/E2Nltrt8KV1C0b/IE6/r7ZzIyXT0qzasE6zXN1QRAGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r3y/Xgro; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JviiCf+PxUYdWQRiPehLrKarMcJhcUsBtdywiRbCqAA2w3MFb1gcnQ8phJF2cpfP+6PLNwy58P0S+RN7kZPm9CEAfpOIBLclNQrsBHunIfxz17u6FgyhZNPvqnQl3Df7f916NHZ/+T6p8BUrk61ksk2EtW3/CBvQVeIhnbbPR/xdkVUXXlWS3xmQrAKs7tI7hvO9cYPlOnoeIhwPTMnYRD9i1LJtdFSAXu446F5gMDNDDSJDkQOFR3CTUuiEX0F1/MviN5v1gOWx61qv3Y4X8EELSlQ7S3gGXJQ7F9BrwhzMwHpRwXXMew27T6YX/gyTWAUln6jPOgkwQ29VRoqUFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIquuYEaTAdsm90JaESO63BBglitZLQ5m0pxB5L/pKA=;
 b=D+i+W2ib1+HfuN2PTlQB1A/nC/OSeCrs4viCpaLY9h4Ta9L8OzJnM9+2fTA6LM1wriVhXc2SUYt4P9txYLZgXjlx10i/2og1Ovo+HQKA42+7/kNN0Z5M42r/rRhNz1RP4LnTS4OCeMJ8qj4Bl+Ya5ZS/wMBbMyMuj6oS9lKtbN4h2Xz4r8yDWHQlvwm3/WOago1YcuXzYHpTIsKuyf6LgssFHfyhsESGl78Z5aoMlFyEzknXqJLXeHuHw/Ri1jFSBN6z1nQLYZ4GTN7SEnExLimksH2dAKFqZH/ETUcPK35YIuopziN6RO51wi/IOUmai8GFHFodAD7f1kWYmz/jpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIquuYEaTAdsm90JaESO63BBglitZLQ5m0pxB5L/pKA=;
 b=r3y/Xgrou0ci+8et6lCFloEMsR5cUqt+I01sr5TrzGjz2idyex8vZysL00WYkNx8dqbkPR1XXPjR2GvYUo3oZOXiTHGRFoQrlskvRR+LftESGWmTQ5Tzcm1liHBjv7U+vYUMvyFcn5O3U9kgKQPxBe4e+nFTlZqh5prntqy2v4apgLwrskHz4OSzo+qxgAzA/Q5mC9/sRZtvkCIAm+W1/MyXl7Q9iJH/8rIj/sYFJW20bFWNviqBr38pvI255vyCK1PEakV9sYp2HlyAgqmKZjlJeksylsSB44nOI4/KYbgOnMAHiTo7rXomb4YjwWfDmS8nl2p7tZwxYkSosLmCCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB8888.namprd12.prod.outlook.com (2603:10b6:806:38a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 17:41:33 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8314.015; Fri, 10 Jan 2025
 17:41:33 +0000
Date: Fri, 10 Jan 2025 13:41:32 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v5 08/14] iommufd/viommu: Add iommufd_viommu_report_event
 helper
Message-ID: <20250110174132.GH396083@nvidia.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <b9b4f3df990934cb80b2f5e1e49e555e50c1c857.1736237481.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9b4f3df990934cb80b2f5e1e49e555e50c1c857.1736237481.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN1PR10CA0003.namprd10.prod.outlook.com
 (2603:10b6:408:e0::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB8888:EE_
X-MS-Office365-Filtering-Correlation-Id: f78a3ed1-c989-4f44-52f2-08dd319e0617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NxJuAVGEDNBEhknmnoiP/MLE0Qfu5pff6THbUc4IvZStXpIKYlxLz4HhU1rn?=
 =?us-ascii?Q?aaDKHb72ahcyR1z4l7m2YRsUgA6Mtwefk2+DcoqQISBQ9CAMAGQ9qMiABwub?=
 =?us-ascii?Q?2/NyuJB4qbT72cSNmxuWel8YpObspM5sRsSW28Drf8YAkS+A3on6Al4AXx2b?=
 =?us-ascii?Q?U436rFaPvGBjJuGv39UCepZjxubVLAHhZzg8ik3bqEEoBHWlvc3xQZ5L2roO?=
 =?us-ascii?Q?2lmK6/rOD0AFjuvYevIn9cQT1/koNaVCZK6RdPb4dFgoKCUg0VG4fvYWUcIZ?=
 =?us-ascii?Q?IcreOD7MYV34mM3PtXQVirE6K7/x5yafmLU3OsnmJ7ZOSdys9z3EiXZGKavN?=
 =?us-ascii?Q?/5WOzcvpxFkZD+v+RahPhFFuBDvK0941CQ2d0v2vPh3fSxN7sjkPcUd47see?=
 =?us-ascii?Q?X+GSjo1lOTIqMC52JGYzi5cVceItptawSZx0zp91aNT9iNm+LXDoc6kjoJhM?=
 =?us-ascii?Q?SrVTHnsJCJkQu3/GsKRk3oZm6X1MPi9ASYMP9Ez7R5yqX4SXyuzWmm4RQtls?=
 =?us-ascii?Q?wTXiFsm3Nb7mKb178uN1lGssPXmRPrZCyKJKlbnIrV2U4yuui+j23p4rfTjT?=
 =?us-ascii?Q?zvcnMvJ+FVtsaGkP0Zhsi8QJUJ1fJr5YTTCE+HoA8Evu3qiI/2TW/8zGNq7j?=
 =?us-ascii?Q?Lxl9ypZHIpQ3KReKMNgn2lg6Ist3HwKnj2hW5qGVkO8QeQBbj3iHqAG/KTC0?=
 =?us-ascii?Q?uXYNtnqvtYsE68m2MWWiUqM1GyDU3RBgJIDp/tE95NQ3qfAhIyzb7jATqQHE?=
 =?us-ascii?Q?eZcdNGEDQ1G7ITgr58jfDfXfBhwPYJbkiPdfGS8IOAwYMb5JKM8xL1M9JcyM?=
 =?us-ascii?Q?o9WMjhb5CK0xr278Zb5XeCEK1d0GJHNVkQuCuCNkrCCTXdPbm5OKnurqNVY5?=
 =?us-ascii?Q?rj204lCxYIJksUVLXCJO95Q89FrRYg1FbYyuISVfp8jMc2PlElCW8Iwb23q+?=
 =?us-ascii?Q?57h6I2KMA1xo1SLQicKuaigIyj63wKrB2cS+g3FlPm2LSSXGAj5Gal6V8UyX?=
 =?us-ascii?Q?6LkHvBX8ouDgPpOHo3nPstZlazxXMG5vjbRHixofe3BdHkffQjsB77LNWq3h?=
 =?us-ascii?Q?zTr7m3VnBzKXlXPIM27oZd3DnawUNqsSqsYudbNxJaxTSWnVhI+GTt+fKfLu?=
 =?us-ascii?Q?3HFYBin3gr9rlFeratL/jb6b63nAb+Bgxqxytx2SSqGN2i4c52rk8NJVX+Yw?=
 =?us-ascii?Q?jp1P3RUDvi7M7+k+9uBgB0x2U4sd/MImoVYRRtN2I144ZEBSCRZM9alEj5JO?=
 =?us-ascii?Q?vYk9pi4eTBhpQXCG8M2Gwdm+dTDHmfqPAfwbTaFnGFOaGwAgv2swUPT2xNnm?=
 =?us-ascii?Q?8zKlVWY39iaHwLrK048jC3LISNVqJfpNywwNub4mClgyKw1fHf/GKTrB5ebD?=
 =?us-ascii?Q?eqLL/5X2kdclUjM42Cnwg4nrPdtp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dDQcurPWguam5lCU5nr5ryjlP9gpEBBicpR4g9pVGFPViO2seW+Azex2DWX8?=
 =?us-ascii?Q?iAfPjWOh+F3O6GG3HENJGdP8QJskvh90iinoiWWPDBiuLBuFPkTZJBoyNoNZ?=
 =?us-ascii?Q?m2dTCUyPyKVhWtawzLgFvXGwvNZHfH4nR9EXqxpW0WX7qJfpA0NGsJwwUzYD?=
 =?us-ascii?Q?tMo1sWstYFOGxRRQHbAZ9OGICqyUqlOzvex5DpqseAZ/pYpU1dz9ksNSSYrZ?=
 =?us-ascii?Q?MrGpX0W5f96NVm6ilWCrk3AuY9XhR1ECloSw8kPOf+uOkwC34FUC6BxGkMQj?=
 =?us-ascii?Q?fhtRQojvxVo1jKhp8LoeHO8hQ2TAMlCnvruEUExucZJvQQcAmiNBbQ4kjNGV?=
 =?us-ascii?Q?xor3hU7DHjnvTOtVF6/E7lRkkj3PXc5WX6maljz7cy8Z8EK31H6BrHaMmNOp?=
 =?us-ascii?Q?FxPuubdwsr+8G0uy027BVNIeVBaGvQKE6VE4WN+B3+V8rMC892ll4uXOajCS?=
 =?us-ascii?Q?gQj4W54OJJxPrRdJgM2wd1liypXDSjQyPFVNI8kOr250UJpIJt2MduTr3a3Q?=
 =?us-ascii?Q?lxgvk92Kof7/TDha2GQTCbyomcck+BVlB0b34wkt0PHH1zchTjDXzccs3Uop?=
 =?us-ascii?Q?bUdlyf/wBbo3kIyXCk65hwWDBVU909WlBaRPhUqZNp7KVmgxH0TLhh/zKPqP?=
 =?us-ascii?Q?tqVcpPRFgO53BPBM455gTA3SekRJ9uUV9iktPuU7h4sVWUC9d7/kUjNoeNvh?=
 =?us-ascii?Q?pKIxkoPJX6kb8IRp1xKYuus76f53S2kzViGfDQScTtwXAMYh5ANN1k7ddZGA?=
 =?us-ascii?Q?I8DVlbJ6nwz5Rflm2d3fniJNpAeJ4iAq7TGkukmQMFCVvA/AXtp+BEM1isJp?=
 =?us-ascii?Q?SuGhAkaAldM23F6xPuSchMZfQM1gMaZz26VU7ssXAQdQT5mie4n7axZEN1iO?=
 =?us-ascii?Q?AIuztyIGg4W5aAN8TYWMtUO3kSoZbSQdvIJ4XGog0uyUQ8U0E6ooVBOgi+Tk?=
 =?us-ascii?Q?mFUwVOTr8HymvV8ZFVbxKZiB1YIePCQrJ37M1bluzL3DRkt21TOzybnQvPn+?=
 =?us-ascii?Q?rW4T8Zz/8yNcJIX/loH0KvHGyiNXdYU1nCJIUU4Mp1zrl9dxHtUMfu/jH+pH?=
 =?us-ascii?Q?KAd2M5VOEVLWSOeOI44QzU1bizcz+3rM6/dvIT+MEDheMDdN5ZQ0VgtwVZNm?=
 =?us-ascii?Q?c9NXyPt2QwndUDDDY8uTcWRFcSw9kicK4jajXpOFJihsC55pG6oVtxjOXsuO?=
 =?us-ascii?Q?SP8wMHJHJPTUZ/+CpyvUgXp7ZdnIBI0Dl2hXVx7Xqm0+BaD2uk1UN/MxCnAj?=
 =?us-ascii?Q?gQ3m1+/Eq/moy4diC4bmNKe0f054t0KyVLQuRT+6cFm7BHiWWa/v3rG4m7Fw?=
 =?us-ascii?Q?np6wSVHBOi3MeZdpzV2MM1Rpv5pxGVQXI2Jit03PRQG0Kp7d6vAqagpX5fNL?=
 =?us-ascii?Q?+ORDd8VTO2i+8KXyyTkAyx48FoQr1NiCQwCx8bRLBLOxisYMunXFFSQRzBnm?=
 =?us-ascii?Q?ixq6/zHZTi01ybmemox+Bxu47/t8ftDw4enU/T0c4+SWbGXreXCXH5s524ia?=
 =?us-ascii?Q?DSSrVCgTh2NlpZDavglhG9cPuwgt90Fxbj2lRWmw/cFfMg5GmV5CNghiVdl2?=
 =?us-ascii?Q?XFxzEOlQ+dEDA/zK1VQALQIDFpo13V8lGw6O2wYk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f78a3ed1-c989-4f44-52f2-08dd319e0617
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 17:41:33.5348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eNzyJrHBWHDxyTYfLjo33egUpeKS4Gy754kZ0lD9pyQcLduGxfMbnyHxe1ZzVvHk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8888

On Tue, Jan 07, 2025 at 09:10:11AM -0800, Nicolin Chen wrote:
> +/*
> + * Typically called in driver's threaded IRQ handler.
> + * The @type and @event_data must be defined in include/uapi/linux/iommufd.h
> + */
> +int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
> +				enum iommu_veventq_type type, void *event_data,
> +				size_t data_len)
> +{
> +	struct iommufd_veventq *veventq;
> +	struct iommufd_vevent *vevent;
> +	int rc = 0;
> +
> +	if (!viommu)
> +		return -ENODEV;
> +	if (WARN_ON_ONCE(!viommu->ops || !viommu->ops->supports_veventq ||
> +			 !viommu->ops->supports_veventq(type)))
> +		return -EOPNOTSUPP;
> +	if (WARN_ON_ONCE(!data_len || !event_data))
> +		return -EINVAL;
> +
> +	down_read(&viommu->veventqs_rwsem);
> +
> +	veventq = iommufd_viommu_find_veventq(viommu, type);
> +	if (!veventq) {
> +		rc = -EOPNOTSUPP;
> +		goto out_unlock_veventqs;
> +	}
> +
> +	vevent = kmalloc(struct_size(vevent, event_data, data_len), GFP_KERNEL);
> +	if (!vevent) {
> +		rc = -ENOMEM;
> +		goto out_unlock_veventqs;
> +	}
> +	memcpy(vevent->event_data, event_data, data_len);

The page fault path is self limited because end point devices are only
able to issue a certain number of PRI's before they have to stop.

But the async events generated by something like the SMMU are not self
limiting and we can have a huge barrage of them. I think you need to
add some kind of limiting here otherwise we will OOM the kernel and
crash, eg if the VM spams protection errors.

The virtual event queue should behave the same as if the physical
event queue overflows, and that logic should be in the smmu driver -
this should return some Exxx to indicate the queue is filled.

I supposed we will need a way to indicate lost events to userspace on
top of this?

Presumably userspace should specify the max queue size.

Jason

