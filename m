Return-Path: <linux-kselftest+bounces-24241-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24772A09D45
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 22:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0BE16ABBC
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 21:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A0B20969A;
	Fri, 10 Jan 2025 21:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hWIDM/Pd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A66618C03A;
	Fri, 10 Jan 2025 21:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736544940; cv=fail; b=VIFf7BrlXXekKBicdwVX5oge5uw4+zJ/OZ2U2odXAsrIw1bKk7Mp6hdcLFVetzdXTt2G0W4VNUAwXhEAywgMIwiuUnZFANk0MGJcXmu9KEgg3RO3CPSaTYpWw6cKgvBuZ+fv0Ue0MC8AYVEz1EiOOkC0TCtESRsj+ZzrX7nrbHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736544940; c=relaxed/simple;
	bh=Ha+nbIGQj49hVmmLAOVuTwO+p7quJvbadCXwhqiMsJg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwFsf3KOiXecLuLEYKcmo2Cv+vkhjmrFQQV/gYeZD1lC/vMIIzZE38BlrI/q/Te8ST2t8g3jGGf/Qw3C04kczkLyMjBh4t34QWjpJ4+THXBApEGjjAUC1VJtJ29SyN5CK14e3dwlddTHITfEeENGLvjpfu+jV3gSNP3POWDncC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hWIDM/Pd; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Es9bmdT19DtcyVQQRihEMqmbtf6rBOiJQFtu3dQ/Vr6qrzOUplIYOEgNUV6NrT33BOfLQlgvWGrbSD6uuGNvZbCDAHaSfqnvYmOJGBNQrednyUXgb6PO5p+SqaTOcISJCWkKhxAbhneFE30jzNMDQM0Uck6htFudc9f7gc/6SrKKABYmFBTpxjvCUZ0o0YaAQGKWCOyFdUevGrrR7LBm0XOLL8d5oWJT8vYyCznkQ9C3Bmnb/4dZGKji62Pb0LWkdsMfsmtR4oyAMx+4CE6z7xc6LY/xel0ET+R5qx7A2jrK+khY8s50VQIQHdeWWa/Sw5lwL4bCC4VctLU2x7Pgkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6F4CEX0HCScRS53M2QIKYlRv/30MMJywdF7XjLXNCo=;
 b=sKpoKjHBd665CSKApXHr0/YCBJUkB1xFuNtYDY6Cu/9JZapF9IxkWluaV/gyeeO1VaBGfRbzVS/JoMrXwM2y1rHnNBX7gYDn31/fUTc58ARqw0IIlXlApx3ko0IgojbLAtnhVaJZGM4ZANzwNm7XfviKbJVXVAmbuWyjVLORCzrvjZVLIZrArN9tzxU4L/qQNYSwcdfKs2si/YaZZ1HsW46nxIv08GCLdbCemWliBBM9Wwmz/zCDgp89FHtYuy2xRu0ywh4n1XFvqAEjJmGIazoiVGNkjJFxa4vhvHR3MfWbCeGHb21H6py40QwrsN/XLGkDZHj67gQ6VTpYuFGsRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6F4CEX0HCScRS53M2QIKYlRv/30MMJywdF7XjLXNCo=;
 b=hWIDM/Pd5UQwPY3+4bwCzbbB7V+ex2xFlqeoTU2l/wmAwL4Z4U8xXss4gBaCM7yNwmgD2AXQ0vWNq+Dm5B4D+WUGWY/z0M+ZVU6yM75v61RAVvIiQwauSGbD0Np1UQDVvOnOvpb1mTfqfgICEU3c1QysMJJoq745wvKJcbZ6jcXTPoXRr8jvCbk7YH/NWsW62CFVdAf0Srb/mtq3KFYEECCN+gZhUjQtr5BXUx2I2HFSyFzSxOV7P2/iktEN8/l3GfEIkkMB4fxAVYRRHSjwdOodEJfZkQFkwzoN9uZs4GuR56z6NWfZtvj5a4hlMQnSEx50kTMXXMdKyZ830p2biQ==
Received: from CH0PR03CA0268.namprd03.prod.outlook.com (2603:10b6:610:e5::33)
 by CYYPR12MB8853.namprd12.prod.outlook.com (2603:10b6:930:cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 21:35:33 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::64) by CH0PR03CA0268.outlook.office365.com
 (2603:10b6:610:e5::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.15 via Frontend Transport; Fri,
 10 Jan 2025 21:35:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Fri, 10 Jan 2025 21:35:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 Jan
 2025 13:35:15 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 Jan
 2025 13:35:14 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 10 Jan 2025 13:35:12 -0800
Date: Fri, 10 Jan 2025 13:35:10 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>, "mdf@kernel.org"
	<mdf@kernel.org>, "mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "ddutile@redhat.com" <ddutile@redhat.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v5 07/14] iommufd/viommu: Add iommufd_viommu_get_vdev_id
 helper
Message-ID: <Z4GSjvNIG8WdnAVH@Asurada-Nvidia>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <1dc30375464927950e12a5a52ed0433c3b01b8d6.1736237481.git.nicolinc@nvidia.com>
 <BN9PR11MB5276544E0043A69C66F354488C1C2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276544E0043A69C66F354488C1C2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|CYYPR12MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e78fbd-75e6-402c-50b5-08dd31beb63b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/HFsqrcXNDWifXLUD+rlQu5S/tKA9XJYs35d5v6uFu53g8P67tpp+MUHtdVj?=
 =?us-ascii?Q?vv2LRuSkpO438FgmmrmIZdaRrq679TYr2vTW4bXnof9Zu6jqoWuKTRtLlsiQ?=
 =?us-ascii?Q?k9EzUqKkZ5L/5dfVjhpoTj31oBPJIokRnEfeVoPSyRoQIpIISsLUeglvnsl2?=
 =?us-ascii?Q?2Yumm5/dfLpudGVPkn7pzgnJ0JjhngckKsS5O7d9pDHy/I7DKOgYJRIuuton?=
 =?us-ascii?Q?63qkvEjjMc/EufGCI6mzLG+KdDsWL/fanbexRo1mkCpDyZNfcfduQuxmZ+r6?=
 =?us-ascii?Q?PBgT5+Owrfowpjzit4vTOHk2tppBwpPt67rdUjpJeU+VK99KLFDBcneQXIZF?=
 =?us-ascii?Q?IFHuqYRVJ3G4EFVIL/x68kwz296wV0jgIYCloiEGSILyHIZcWGKbhv6rOcQE?=
 =?us-ascii?Q?QMua2UXdZ9J91msSRKd4YuTO6vZK/e27LSMvBLMpDIb5dnIFFG4opiZzeHW+?=
 =?us-ascii?Q?UHRnJfukEUPMt6t2PukUu2bBjQjojY24oM6Ru91ROP4HvQhSoyFErSrF7Cmd?=
 =?us-ascii?Q?0+S8kzu55Te0i99Ax9af7v4ub43fOAz56z1+G0hoPMB35bEaoL/BwsqqVR4n?=
 =?us-ascii?Q?TR5GZ2B5ZQxhxYqewHe0132xRw0ieNgt/7ODIN6WL3DP5fD7GluBl53iwrN0?=
 =?us-ascii?Q?M/QJAT6fH2dY540VObQ8gc9zIM+ETGf2WEaOnmxWWsjb2x9breOYDqYna5+H?=
 =?us-ascii?Q?Vrs4JUj+gVed7+sZbZoQAfnoYnIuUTtcuQ+unihrBByel/Ale3DRdsfjg74K?=
 =?us-ascii?Q?kJIJFuNeC3ibulwrtao4hBA5AomRGX33cE2xEGKsOc2ZZzFh2whWDBrPGZ44?=
 =?us-ascii?Q?0Bx4Xuy90GyFLVRGpjjTG2/deUTMqlejKxrOXMJ/1muLD9RjTkiy6Asz7qrr?=
 =?us-ascii?Q?k6Ct5bluOLna90fm8sWcC894p9JiO4w52lMXrRrKGcHveU879njbyYNh/FwJ?=
 =?us-ascii?Q?+ml+kwwgw2AejagONbbStiwckTyFxJNCZI/Vg319CMt9Zz1IP+MV6PGDSNJD?=
 =?us-ascii?Q?+Cm4dKzqG1K1T4pXpltW1Lxcu25EYHXqE9BhcmeAIXoejXw9gBKQlr2XeiYv?=
 =?us-ascii?Q?Nj/1NyQJd73tZDh/ewE8caUCiQXLSECW4rKbtrS08gACuYvGCzX2p8E8x+UO?=
 =?us-ascii?Q?CPjEnnLPxKP6fO8TTcgxU0dN6v+riqh6zEoTTx+XxaSgUWhxH7RgCPMSqy+q?=
 =?us-ascii?Q?I7FZYjeuQxBYw/8hAV4awZ++4UhYSYFnmcAbeIimg3EzRa595PhV0M3lYDVV?=
 =?us-ascii?Q?yl5qlFTK7Pfyt9UsG/r/Z2rB8JZwRIQUdf3sgjYFoUmsK6uNrOUeCRSkPFIL?=
 =?us-ascii?Q?RY45PwnuBemWWKrKFzfS37TPBnMp8VFqju5ibZ4JfDXshutTF38qvRU5n7dz?=
 =?us-ascii?Q?ImhzBbtRdvj2/aMJrlxNXpcj5KjkbSJH8nVhN65xwQWPHXEbAqs+Hrel3hLQ?=
 =?us-ascii?Q?ZXH+TJj/kzOc1mI5OK17Lb1XG0jXYd48/W43t+ovTfqFJ+reNHokmTuPl9Pp?=
 =?us-ascii?Q?v1uowJdhgTI/5NE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 21:35:32.5803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e78fbd-75e6-402c-50b5-08dd31beb63b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8853

On Fri, Jan 10, 2025 at 07:07:36AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, January 8, 2025 1:10 AM
> > +
> > +	xa_lock(&viommu->vdevs);
> > +	xa_for_each(&viommu->vdevs, index, vdev) {
> > +		if (vdev && vdev->dev == dev) {
> > +			vdev_id = (unsigned long)vdev->id;
> > +			break;
> > +		}
> > +	}
> 
> Nit. No need to check vdev pointer as commented in last review.

Oh, I missed that. Will drop it.

> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Thanks
Nicolin

