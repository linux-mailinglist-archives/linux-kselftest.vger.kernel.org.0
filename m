Return-Path: <linux-kselftest+bounces-35785-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92907AE8935
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 18:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA04E3ADF31
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 16:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AB12BF00E;
	Wed, 25 Jun 2025 16:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OkFQk0Ue"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518F629E0FA;
	Wed, 25 Jun 2025 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867636; cv=fail; b=fI+U63HdgzMnEPtZOUJaMDflklIP6892hWVZIQ+xMD8J48PNvIxWeRLoGkaNKMpbF3YbCikbqBOs9TkLqwFJaopjkf6j3hMde6cSl2ybAMpcjUCCegLnRpTCz/BC9Q52HNn+VXtGBLiKHU1SVGV/ymelIToaNq7xo8MzL3zYZlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867636; c=relaxed/simple;
	bh=DUd8Y4ShlMgeYweIoWv7SUeLUNS90GPtR14QBNvHxOU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZ2mp/ePo9jQojiBQeLRJeF2jBzWc5OOjNVKvyyxjtsoXRfO4o2zELGxp9nWoQrj3RI5zJJM+WegLA1+q/kROIZf03obYSdWC2rtVkikI+lAk8LG7PIOGjxP7MPgtsu5EZG8HALJlWYM3/2TORgP+q4w36OrwDK/GAzqNjrCjJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OkFQk0Ue; arc=fail smtp.client-ip=40.107.101.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2S7SPSOAYVF51EePsbEeaPHfIOOuoPgpRs7FBQ6hcI45kuxLc2SGks2tkEyUMNGmDlVmNW2kSIbuBwiIEWqGdX/Sd8JvX21+ktfheLGCE9z9t9jBhS52mzaJPmfFN5geUpCqjgRsHJ1TUNe20wNyWPoe5KH5khE965JTb3DDyCNlXa6bJIzTiJ/HJkzAMyDWxzuJZEmugTF5vD6Nr4534L/iK9ff4KR9A8mr8neMWoCQU5/EaTlCQIbOR6nOjx8fEYhy7i7//Mupuiqfh4WJItWKbsnCFLAPhE22Q3Zw95sJxoNRneCgh5Zsc29FeWu7YgwArq71vQEEI+xbv2DJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UC2mbc7JZe7O60f/VwMDCqefneEOePUwQNU7lAytoyk=;
 b=A8YRD3HnkR32EBNlUCkXN3cJi/DB7FilfEZ4NoelD9X6lJcIFiS8DyHUXEg+n5mLnp4LQD+aOw6BSu7EgOrxgaUCqlxzgI0BSAtL+5oauPDftmxi64CwOZSTGRu5ZMN056IZDqLEM7hffC6INfTL0oBaUtu/JYVcKRSDgrt9aZNKCbD3/ePoS4RZnqvkFfwKgimgQij0JuNiU5+mVA9zlMYNSLmjAu9GR1ajQviUIvuFrPA7I8C9bjQTdhAe5zctp1MEZNHTQR/sSWmTv4/+/yjnGms6XscwsH+2tkqLpj1m3I1+k5Q+RhhKl/UjIYrb1Wd2x9CrLUNBkpaxUGqxjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UC2mbc7JZe7O60f/VwMDCqefneEOePUwQNU7lAytoyk=;
 b=OkFQk0UehXHR9wvG/7Bomxne3gqmvQ+bulEGT/gLAJlzEBWFRqkKEZBQqPTUeoE7wcn+d93/2G6zjVNnKkSRx1TY2em5d40HTGW3se2jru99WX2pd+zv58sif4GWp7M00LabjHoL26T4gj1gyQ/ZaEOzFfiMsq8c/JcdeLgka+Ht7EsSMmJiKHmgxxoX3OPgaeJVPCVSgFu+MxGsWFaxvq28y2JJ4eDTFyk6FbXzi4yZ5ksYDsSN7pfYQECkhzMxJ6n9OKO4rceLHJnKmBm3AGqEOqPQU4Q1ir8175B09rt2dGOQfLDqD6nn2rvIQ/WSiPfzv9XYWm+hCAYcedWNGg==
Received: from CH0PR03CA0033.namprd03.prod.outlook.com (2603:10b6:610:b3::8)
 by PH7PR12MB8108.namprd12.prod.outlook.com (2603:10b6:510:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Wed, 25 Jun
 2025 16:07:11 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::e3) by CH0PR03CA0033.outlook.office365.com
 (2603:10b6:610:b3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Wed,
 25 Jun 2025 16:07:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 16:07:11 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 25 Jun
 2025 09:06:57 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 25 Jun 2025 09:06:56 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 25 Jun 2025 09:06:54 -0700
Date: Wed, 25 Jun 2025 09:06:53 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "will@kernel.org" <will@kernel.org>,
	"bagasdotme@gmail.com" <bagasdotme@gmail.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, "vdumpa@nvidia.com"
	<vdumpa@nvidia.com>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "jsnitsel@redhat.com"
	<jsnitsel@redhat.com>, "nathan@kernel.org" <nathan@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "mshavit@google.com" <mshavit@google.com>,
	"praan@google.com" <praan@google.com>, "zhangzekun11@huawei.com"
	<zhangzekun11@huawei.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>
Subject: Re: [PATCH v6 10/25] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Message-ID: <aFwenQwrKz8rHY9T@Asurada-Nvidia>
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <7dfb002613f224f57a069d27e7bf2b306b0a5ba0.1749884998.git.nicolinc@nvidia.com>
 <1ab8030b-8d2f-4ebe-a280-6d0e4e1d17c7@linux.intel.com>
 <aE+976F9zPsjtfry@nvidia.com>
 <BN9PR11MB5276002043AF3D0970C7AEF58C7BA@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR11MB5276002043AF3D0970C7AEF58C7BA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|PH7PR12MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e2b7c5-ecc8-4e75-6152-08ddb40257e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmhwRWJ4QjZENXRUQ0M5NE5FY2N4OElSbmtLVithaEc5MXVkLzdQS3kzQ1pn?=
 =?utf-8?B?WUcvVnZHNGtsVU5ZblY2SHk3NjIzRnptVnhRTlUrVFdXR3lRL0tkNmlxUDFu?=
 =?utf-8?B?SEZ0SEhsTXR5c01GSWtKS29rVHBpU29wNVJ4ckFmTEpldGs2QzZWUFJzNHlm?=
 =?utf-8?B?eGFXNDM1eEZ2aTJwMi90QTNNcHpLY01wOFBHZmhHTTltV2IyYTZHZ3M0RmpF?=
 =?utf-8?B?R21ZNlZHZGYyQUx4ZmNMLzhxNjRvdUhKSzRJeG51RGpuQjJtaVAxVmJmZlJN?=
 =?utf-8?B?TngrZGRMWWRpUlNrRmw5SE1UN05Wa1JmWnBwMG5VNVYvR04rNy9pcTFhdGVT?=
 =?utf-8?B?andJdStPamdPWWgwMWJ0SlNoWG45NWdheGw4NU5zYnV2NUxrcmRSWGhra0NU?=
 =?utf-8?B?YXM1WlBoSlBVV1hRazE5RXh1M1l6Z1pMVW93b2Vmd3JIOEJSL010S01XaFNS?=
 =?utf-8?B?TG92eUdhOXFFcUV0cEkxZHFLSUltUnJ0bDNXK2JYK0Z1MjFVdkZ1ZjF2OFNP?=
 =?utf-8?B?MWlLaDQ5YVQyTThmbjF2L1U4WFBJb0piVWVPOG96dENiUTY3aDAvTklsb0l2?=
 =?utf-8?B?eEpBSTVoQUt4STVoS3ZDWXdyS0NwQU5vei80NXJJZmZvZ3ZYUXJpaG9oV2FS?=
 =?utf-8?B?T2RhWUNqVm8rd2pTcWtPaG5NVCtFV2YxbWxsVVpNZDNmMGpoNkhCOUNjS1hP?=
 =?utf-8?B?c0ZUZWM2S2krSEJ1N2pEVUZwd0MxZHZ3bUpxVTRPR0NNdmxpeTlxU3krSklY?=
 =?utf-8?B?SSszY1JtbTBEalF6OTFldEI3dGxScHcxUVRxRFZoMjJhZEtLQUNVTFpKRkF3?=
 =?utf-8?B?N3ViblFtZUNVQVQzbVFObkRBeEpkSW52ejh5d1ZLZ2FHNkVZSWlaSFhuazM0?=
 =?utf-8?B?V0Z6WEVUck9UQm44VktMd0xyUjBicUJUL1hWQjlmVnFGTWc5cDZsNXJqVHIx?=
 =?utf-8?B?dUNpR2FUeWZqS2hBNkJlRWhMOHcveHFKYjdYNkFHQzBXc1luTDNaYzdyU3Zw?=
 =?utf-8?B?V255RzFWZ0U5em9iOHNTK255ano3VHlFQkR6NWV2TVhQWGluQXFSUk9WNklJ?=
 =?utf-8?B?YTQ5YnFsUmZLcUJQVlc4c1lUZnlKVFM3VGV0ZXVBQWVnSDFwWVlmQVl5WXZq?=
 =?utf-8?B?SmRMcllId3AwMlFQSzdiUW9OUmtuSmNxbFVvZzV6UVR3QjZ4RjZNaHJDSTlz?=
 =?utf-8?B?VUNZdVc4ZVE5RFU2TTZDbTJhU3BGRWk3T1ovbkJYZzlmaG9NanRYZ3FrRDJD?=
 =?utf-8?B?T2hWQzh1WjhqaDAvVG5pa0dHYzkyWTBDb3dnZ0JKVk52ZkFPM0gxQklGZW5v?=
 =?utf-8?B?SHRRRmtJbFIwRWhQQVduRmMxVnRkaE5CNmpZSkFpV3lYSE5NV3VKWTVUQ01y?=
 =?utf-8?B?bVR0aHpyR3BoS2RPbVpORkRNcGt1VkJYUGRIL2NMUWZUTko0V3cwbmhlekdG?=
 =?utf-8?B?WEZmaXo2YU03Z0J1V2ZXbUlrVyt0bEt5eDRMUkxmMXpjWXdWRXN5ZlI5M05P?=
 =?utf-8?B?NjlIdmVTU1U5cjZVZnZiYUU5LzFCRlRWZkMreHRVckRkcWRxcTljOEx0alJE?=
 =?utf-8?B?eEhqclZxT2tzOUI2Mk1OYXVkM050STZxanhPQUgwOGF4Q0R4NWJUMFZmMEJ1?=
 =?utf-8?B?S29lYzIrblAyQWlSNEVVeE1oWmRIb2w4dk41Q1RuYmFmQnNtS3V6VHZiZUEz?=
 =?utf-8?B?RThiYlJrejBWejBFczJMWUY1azJCTlBGQi9NZm50QW16SGt6d2ZoTU5GRFFs?=
 =?utf-8?B?YWJ2ekpQU0J1Qlp3Y2E4L0JnZUtkeFZQSVZURk8vVmhObmxHcnljbEVZRnhG?=
 =?utf-8?B?OWlMaUJPa3hkVXN1aDNqeHliTHFSVDdRdTd4ZGc3eFQ2VXdodEN2MGxwZFB6?=
 =?utf-8?B?a0FZK3poMjVIeDE1bzV6Umk5RG5zWkZUOEViRjQ3aG9SamYxNVQ5Yks2eE53?=
 =?utf-8?B?V1EzV254WHRhMEhqR0ZmVE9rby90UE1MUk1TdkhVeWN3WCs5Mkxqa1V4TWx3?=
 =?utf-8?B?V0VJNDIxV2d0NlpWYmNEeVBUZDhNSEl1TERTQ0w2MFVHQWp2SzRod2YrOVda?=
 =?utf-8?Q?P5FBcu?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 16:07:11.2153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e2b7c5-ecc8-4e75-6152-08ddb40257e0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8108

On Wed, Jun 25, 2025 at 03:43:08AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Monday, June 16, 2025 2:47 PM
> > > Leave other logics to the patches that introduce
> > > ops->hw_queue_init? I guess that would make this patch more readible.
> > 
> > The patch is doing in the way to support the hw_queue_init_phys
> > case only. It is just adding some extra FIXMEs as the guideline
> > for the future patch adding hw_queue_init op.
> > 
> > I personally don't feel these are confusing. Maybe you can help
> > point out what specific wording feels odd here? Maybe "FIXME"s
> > should be "TODO"s?
> > 
> > I could also drop all of these guideline if they are considered
> > very unnecessary.
> > 
> 
> Probably you can put some info in the function comment instead
> of being scattered in the code? anyway when the 2nd method
> is added in future we'll review and make sure it aligned with the
> caveat here. 😊

Yea, probably can drop them. I think AMD will figure it out easily :)

Thanks
Nicolin

