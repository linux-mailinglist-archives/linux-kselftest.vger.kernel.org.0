Return-Path: <linux-kselftest+bounces-23975-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97017A0378F
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 07:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C7F33A3027
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 06:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C536D1DA634;
	Tue,  7 Jan 2025 06:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cnRqlWFV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077A01D95A3;
	Tue,  7 Jan 2025 06:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736229668; cv=fail; b=nOep9IcIG/+yK3tlDxx5jqMEBGdhCkq61s973PJ31E/PIfAehpVh0xHIRD7q7pugIj0i095xbqjirHZhtbYJwmUmqn2GbnDsqQ76fCNPzuBDCgPhQ/5PEbDFW0ktyWrr836iSrTTdwAXxW1cMPzdGJODWpMf+TvW/GD1ipUAwAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736229668; c=relaxed/simple;
	bh=JL3o9EyjE+ip/21wB9Wuq8WSY35L13QQXId96WGXd1A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmuqbBZwTRNdvPmH252ldQ7nwkMkaUt9fXStz0MGPyCQCdHGC2o+QO6uuNOQoTT8eE2pMglnD5deqbbQAABQGBAPPcAgEJyLHf/D4i8mkkMUyV85wELrLJqHoy6Pc10IEmDxqcxMhn7Q3FatoHyy6vbRCclO82BKChQrtm1XXfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cnRqlWFV; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/uzvSzrgzFBeRLpJu0ZxMMBqn1mn+5KTdbamMqiqs2ulprj29JY0cGI3Dm5SyRAduacWGR2e5q0YFAZEkr80WjHNTS7VVA6AHMaBWi2XkOiUCq5DmrZHsoZJpK9x8wSaMcRJ87QK82mep+26x4mX7nEOE0xZxh5oGiO9QVqFDs/qpVfaBiCRYnEr18LCHPVdEnn73mY6PU4pwhvQqjcUYFq0PdBYI89CEdGOzKURCh3lA113mwh6mjxwqPaGseP3QbRnAio9KgwymsD/TEnlvRLyh0LEvLJ1kBG73D+f7U1LTXWu1Nal35EPaDPVLARtWgPsKoZ7F08y2gTksFcBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xN1rSDIOtE4a2+r6ElLHHcu4KVTk3T5lTG+NsVGy5DI=;
 b=gthsEqM93CTJFujY5wOMiND4w2IZRBBkA3JnJeall1IuaFUlmUHdR/B/Pon+H8AuWnrZLHraNCNpwbfzzKBmxDUvco4oqDJOo+PKlnTuebiIYHzM4f1mettNvi7TsA89yg398DVXU1pdTNOYfbGgGigNnp9Ub1fpcC8Y2H+hYmeC841EjQdERQJ7LIVh3mmdyJfIxKc5Lhc4wj9oHoFRwbFncSpU4FZ+W7kvTDL295y5VkdHWDKN5GzUv8z2GUXGK0DImjkmApbNRNf2P1hH0XLZggdcj2Mb0vhV/sEDwVn6Srj8Ao5cMSiwDpK534VszRQXHX2DibjB+0LFUaBDbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xN1rSDIOtE4a2+r6ElLHHcu4KVTk3T5lTG+NsVGy5DI=;
 b=cnRqlWFVrH354nBZEgqUxtKVVK2xCC6x842prd0ihjEnEd6VL/3/N6IGM5KY3KfXkN3QV0rrdAq+Qyt4BLTL70vvunIuuUaQnV8MC29+tWGzy/cAeD/IlMBU33zbUQHJkRiidhVCZZl7CgDa5Zg/nkqlgiltsdnhtYwQSD8w75L9R6zO0SVJxRYY3Xh90nxGSOT5FCXxLr/kh5jlfmN55/0+veYVsgSLT4rS93glxoknpED6TrCHYNHjew9k8Hm/nvGAIDS33rRFHTTA27fg7WnJ3nTmbdjIqJYy1Z6aNRTV5mRAVekpBbP7MfuDa48amBCrZzGKfVVCjZnhlxPhZA==
Received: from CH0PR04CA0105.namprd04.prod.outlook.com (2603:10b6:610:75::20)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 06:01:00 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::31) by CH0PR04CA0105.outlook.office365.com
 (2603:10b6:610:75::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 06:00:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 06:00:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 22:00:39 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 22:00:39 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 6 Jan 2025 22:00:37 -0800
Date: Mon, 6 Jan 2025 22:00:35 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v4 14/14] iommu/arm-smmu-v3: Report events that belong to
 devices attached to vIOMMU
Message-ID: <Z3zDA3xx6w6dSQY+@Asurada-Nvidia>
References: <cover.1735933254.git.nicolinc@nvidia.com>
 <69a46c72e43ed086840be462eef731167d90a9d8.1735933254.git.nicolinc@nvidia.com>
 <585fc99f-c2dc-459c-929a-c7c7631b9caf@linux.intel.com>
 <Z3wk9TvmUhB3/zlk@Asurada-Nvidia>
 <Z3yvZsq77bpnaoAb@Asurada-Nvidia>
 <75456867-8993-4be4-bcdf-14df28fe92cc@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <75456867-8993-4be4-bcdf-14df28fe92cc@linux.intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|SA0PR12MB4430:EE_
X-MS-Office365-Filtering-Correlation-Id: 72b9c086-db9b-45bd-ba89-08dd2ee0a8e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wZ6pvNx9+p+nqytPaAO8IoGubhr0SBGnBM3AL2I19g+J2q3AqY9eYmzzqysT?=
 =?us-ascii?Q?wmNoVe6xSHKShGFH3b76B/XxLFNemov2Ir4LzvaGbiUBsZX4PDg3/mix9xMp?=
 =?us-ascii?Q?sqOTw4lJTeVjeWg/vE4QWuttElHRuyPDrq22/42zXkC2gDpl4i9iSOgiIh7S?=
 =?us-ascii?Q?J+HxAXXAjHr74HPc7Y0kllPVnGiJjWTe9SzwIkLfjSUo/2mVEgNHlUCLyFoB?=
 =?us-ascii?Q?rufOBewvVW8LhbtGhBZN/WbXFAZSd01A3nlznwB4g8FnmDto9V4EdB2vmYyL?=
 =?us-ascii?Q?0f3VJdBgCwskQccVXUgYFiRzBJx4OpMFNEssfozHyxKHfEAGpDhF89VyjTeh?=
 =?us-ascii?Q?d1W8u3iou2LEcsh9TfVSIEp0vevipl1fJXs6rj8n0Ehq/41w+zQB82wACt/K?=
 =?us-ascii?Q?ms1owHJ/bKvS7ov8PGSJnnDZKTDVJVozRkT6qC29tirMWdyG3aHFAW7haFHl?=
 =?us-ascii?Q?1hNXLkW9NKsvl8L6MVNhaeix+kS+imtyybegcthjSXwqs4REAX90jfFc+OJD?=
 =?us-ascii?Q?ihEmrZUP+kRx9p3Bc1jKqV5/GqIoB61Y74WNARcqlpbSTpgH1F/6q4NFawQD?=
 =?us-ascii?Q?go5MIzrgX1c9yjaWFNcObWMX8N5oXMKJqQVvGeLKgYGe5skAWn1uVkthwh+G?=
 =?us-ascii?Q?zv1SC8EGrYVCSy1UJ5fqXqWXba0ZhslU88iCZ90E0hrrSopUZlfEcUtTjBlB?=
 =?us-ascii?Q?7OaXKvzCvDM/kxigUkRVZJxOFrIT5+EuiDNV5SEzyh8bQEaPDmvlbzXTwEbs?=
 =?us-ascii?Q?08mSGx60o5ohy4ESyZ00J7FoeJz7CbwekPh6zhoMMgUOfPV9O5JZw0or77GW?=
 =?us-ascii?Q?REsEc/w2tySKDKcXIt1DktGFZKjGIUBcr9NS4vD0WFpZc+OUho9ExjpXvgIL?=
 =?us-ascii?Q?qGpSVSpcm2zvEW7oE6wOWmrzIoaHRFjqvH83rOMpvVDIwFFKiG2doZWG/UN4?=
 =?us-ascii?Q?yfSKk/imsY8IxzYRgAgNsHQizoppAwcq1cenbrkJ4qOQluo5vW6VtOmhwLKZ?=
 =?us-ascii?Q?QwJry4H3HcVVC1wNxGmkyRsUUFVyn6h/e5BiCLw427RZDDu7urYhc7v69+R+?=
 =?us-ascii?Q?N28G63dQ0VIxD4hYnZZmfcR2sLK5IxENGavxdlYpH/WOcT2Po9z14I1dsmaG?=
 =?us-ascii?Q?J3Ecd7nPYGVTjXcbsK4EdKcTuMmNLdGpbPzSeFRXGB5lpkuEasOG2UbErfbG?=
 =?us-ascii?Q?mrU4/+3r9SCbv006gcAeVRKxZGV67gP7uIDxVDzauA8k+9hCHu6mrlGGiqnX?=
 =?us-ascii?Q?SA/sMMbdvQyO5KIGzybIGjnbkMRw/ViyEhSIJccYd1lIzRIEPVOA+3M24I3M?=
 =?us-ascii?Q?Cj3DywapFyKI8Eq3tfVBJcWj7zxTfg7GO/rSwtJRXPYN3kMFK9oDEMsfTZbO?=
 =?us-ascii?Q?ViH6a2pc7keAbP+MY49bouLFG/tsiA7KdKjvdhpCPXqdN1Egwi3eZiw77qym?=
 =?us-ascii?Q?tyf2jCtk7ovZOQjD86oF9VgYlBDy138XkNaewMaoDf3nob2WeUqjzdtWm/ep?=
 =?us-ascii?Q?NrPnUEm6+QyLHxw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 06:00:59.5768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b9c086-db9b-45bd-ba89-08dd2ee0a8e0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430

On Tue, Jan 07, 2025 at 01:54:00PM +0800, Baolu Lu wrote:
> On 1/7/25 12:36, Nicolin Chen wrote:
> > +static bool arm_vsmmu_supports_veventq(unsigned int type)
> > +{
> > +	return type == IOMMU_VIOMMU_TYPE_ARM_SMMUV3;
> 
> Do you need to check the hardware capabilities before reporting this? I
> am not familiar with the ARM architecture, but typically it's better to
> make it like this,
> 
> static bool arm_vsmmu_supports_veventq(struct iommufd_viommu *viommu,
>                                        enum iommu_veventq_type type)
> {
> 	if (type != IOMMU_VEVENTQ_TYPE_ARM_SMMUV3)
> 		return false;
> 
> 	if (hardware_not_capable(viommu))
> 		return false;

I think the ARM version of viommu_alloc op has already implemented
enough capability checks and rejected any of hardware_not_capable.
So, viommu shouldn't be a thing that the driver could actually use
to call this helper :)

Thanks
Nicolin

