Return-Path: <linux-kselftest+bounces-17715-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB568974B05
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 09:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B624D288D89
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 07:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F4213959D;
	Wed, 11 Sep 2024 07:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fUTapzZC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DFB33086;
	Wed, 11 Sep 2024 07:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726038735; cv=fail; b=msERCGCevLq2iSNKCFFo1SOv0fc5NdK3xLIPz3ae1QqzQHEZCLG3wRYrj9sK1cXNaMZnmidE3FN9u643dq8fg08LLbTvj4Bp/Nz9c6MQwwkthxbuUBqyJX5nZHlBAtyFqhzgZUkagW6jq8mhrp3oBomnzGH5xStBm5lR5VTBhF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726038735; c=relaxed/simple;
	bh=03EFmdXsHa3fshF5CWBTyivY+TPeuwYH+QG+/yATfSo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4rfNuerWYmTbQ5m9ObgARKvaY7iD09pwzrwZG88KRSExbilNBbsvyIZi/IeWF6KVmxJoBU/HcadZPHXFZvm5hvctage8iA0DQJixu57AMPJqG0xTafmGSVizausKRLje02yTARXCNmp2PuUnWmR6Nv61VSF+Wx8u3Xqk2UvUlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fUTapzZC; arc=fail smtp.client-ip=40.107.100.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I54JTIPqUbSSqa+EgkO5W+wnA43xCw+0EMeOVe41I8IaN/iesXIeuYgVRXpH6Ic9UTnSq62ejX1pRzihF0JUSREfUrMJE8te0tS5Ai224nEgSBdkJannWtD4xoi02TkSmpJwjcnNlJqNGQ1y8atRbNye99BCUhRCPHtQmul1U3SE/NFgMwdLQKbPGA8WkqyXqXzbv92V/GWNFJzn1W/pqnOHYttgyUb4Gvjjbq8ukS8YNAiZsDMllFIiFUcpG5/y/ibaj+LQSXhlaQXS9YP5K/2LUdoNeVrQR3TFNTNCtFnLlV/X4uQ1IvJ2lhqjZp/Tv17JKT6fCo/VGw+VfhWmzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XfX+ALkwi1VtU8FSEb/C/LAnUiNAcHpBzmPvvEwCQU=;
 b=kSdPoVZSbjbwKAdEVhk93WZg/AhYzva6gDmJadDSXfXXSds5ZoLHvGjOJGcWAVa8ZnwDcnhUPcd3XYnfBCQ0Ey+llWQcldoG4J8YZKAFr7aclv67UTBMnXUEnkGxvtVt7xUAeBBYDVYNCsr/9iJOtbOseMuscTXm0U5r6usHMsldQkjx0qSiK0ttNUnbIxWOL73MBcA+AOOUie6YAniE4nwIzDmKRh/J9sZbTrFuRjgf0yHbXQCwUGmhR7zH6D7w8WrFB6U5FxvSo/c232ULHtLd8eharO/HFpyWeDYOYX+AaEPLwoYCHb+NVXi6V5G9TgfD0Rrvqqj6qfnw7h13Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XfX+ALkwi1VtU8FSEb/C/LAnUiNAcHpBzmPvvEwCQU=;
 b=fUTapzZChGhamDAGk2hiR2ByE3jxvd7Wej0ZQ5JnPq5DZOgvX13f9cICIml9oMqddgrgzjEW9uW9oADOkwxBkKPkgAokzlCFuZbvJJk7fXf0Mh6pCHtiP3bqnCY9cQRfWdALbNhmTM69h5h5tr1aPk6TFzP5XBlj3Pr48rNqKKMCbWkjUD+3hNR9FJmA/PxebU7X0YWcNBUGm4ClF4TO/aCGJ/l97rb4O2+3Rwt7A2AvijS8EF4m71bpCxngURAivgyfD+Py6bP8qpsd9U/WoNhMeWqevX05hhnjtoJa5Be77To1wVO5DpAMtBmkZWmRIz60iRl9kblGjD0E6dkQfA==
Received: from BN0PR04CA0034.namprd04.prod.outlook.com (2603:10b6:408:e8::9)
 by MW3PR12MB4346.namprd12.prod.outlook.com (2603:10b6:303:58::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 07:12:09 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:408:e8:cafe::33) by BN0PR04CA0034.outlook.office365.com
 (2603:10b6:408:e8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 07:12:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 07:12:08 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Sep
 2024 00:11:56 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 11 Sep 2024 00:11:55 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 11 Sep 2024 00:11:51 -0700
Date: Wed, 11 Sep 2024 00:11:48 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 06/19] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Message-ID: <ZuFCtKoE/xbf6i4y@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
 <20240905160353.GP1358970@nvidia.com>
 <ZtnsaWgeuuy7+cJG@nvidia.com>
 <20240905174326.GW1358970@nvidia.com>
 <ZtoRLlk3hLlP1c9Y@nvidia.com>
 <BL1PR11MB527144A489C069EAB8FB99578C9B2@BL1PR11MB5271.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BL1PR11MB527144A489C069EAB8FB99578C9B2@BL1PR11MB5271.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|MW3PR12MB4346:EE_
X-MS-Office365-Filtering-Correlation-Id: 0af46047-346e-4a2b-5452-08dcd2310c88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U/AHW5O4UhLe+yTFLwt9PdhLCd5M1PWz8HvRXvW/tpt8AuAg7AwkbgdZoeTM?=
 =?us-ascii?Q?VuniMithCGfxX8NVELzUsMYNA+f7SO7T15LGdC4XUQ8DIWRv6qS+ofBgVKBc?=
 =?us-ascii?Q?ds/0zV4ISEJZ4FTRulo+znB5gXfbhHk3dvxyWTOi9sIP1rtKExrVtaV6kzq2?=
 =?us-ascii?Q?yCjV1X/0AhLr1k0AGPzHF4USTxLBvXnwgQLbarAfm/ORXfryxZOufrsU/n9R?=
 =?us-ascii?Q?MmIn2gUtAB62lZXpNpAvSQYBk6/lCTrsQcMs1Nb4BZ/IUKlHJ7F14q9ZsZFH?=
 =?us-ascii?Q?qSZsen4nOfyuCxzpGZml/nKVXTSl6APDsnFn8RUWitAM7XCYcygQu5of/6Zs?=
 =?us-ascii?Q?M74AQUpCe9IvMYHe9nxtyHZYejgzJcb6d0xIGQ1iXxurB/jNGR2gWaelaMUN?=
 =?us-ascii?Q?WdPfNiw4kO/7YsDxk3r5KJUEaFQ5CtdqqCuoR01nu6FnQNzuPwyKT+V9GVfP?=
 =?us-ascii?Q?k7yf4Z2sC6kZfhBz5w6yeEXDxhRGCh6G0JXUw34AnrlOSY/zGSl+jM/9jhSa?=
 =?us-ascii?Q?p2aMOsJyOHDQ5D2vs8Ih7XgetrEcO/oDdSKoqUNBUYkyI7110ccR0qVe7Vj1?=
 =?us-ascii?Q?KmBTQ2EDlkn6WvCP18zCJouE1NiYw5nNcftmrUx6ewtYSXOU2i4e+sM3IewB?=
 =?us-ascii?Q?Qfbxi/ReimfmI4/3jKQDYBdX43x1N0khm0J9foHD+v9PMUaXLdD8Sa10JH3h?=
 =?us-ascii?Q?3vXFNnTKhfWOBgAQxl2AEvmEZhRn5zSzG2cYv+AkRCNvXy+Oe+tdiAbrhLVb?=
 =?us-ascii?Q?SrU/O4Tw993+jTiZCtZ/Mf97T+npTJeP6HI6aIqDB1qO9GXUztTMp2Pm8Ltx?=
 =?us-ascii?Q?p5Tj/IJSsZWitkHmwWyewSJdqu+uCO8WXYfmnPtzAAUIgD8uCuk8JfcBUayX?=
 =?us-ascii?Q?gbMcqedGgzZwJd98agaIM4B+i1b9b77MM0uac8ak61hcvovXlHRXo1SRyfDb?=
 =?us-ascii?Q?4DYW9eYvWuXmzYmxG+M+muEBId4sUkNW7RUMeNSrLwS3DZZIYLln6zVJDlTG?=
 =?us-ascii?Q?rQWAlzMvuCg+b/JP4jrS5NNV415edhJns6d7bUyjD8OJl6FZPjeUKAXbBSEu?=
 =?us-ascii?Q?eBgTkmD9ilKeB9oHSa4VKZ2JfjmuCbG5eh6zuMiKws5lL7ZgGKy3nPII0jRq?=
 =?us-ascii?Q?WPYutwxPtuCaSSIbYMyzV9DIYyDr+9uvPvG+q+tzIsaPHqvl3ZC3J5MDhuDo?=
 =?us-ascii?Q?7LWP+GSijhFBthwPryEuPX08h6TGGQgwqzYHW5jizM2l1WqKNGQJDmNxe3yh?=
 =?us-ascii?Q?lKmvLHVRuzIARUEoeMR5ED/UoIpbt+cZF24NjC1jnKqS9V2kDEteuB2PpyEM?=
 =?us-ascii?Q?ZEutrYEgdJwQiKcpf4Y7+edxY/hYB9A6By+sEWX39BRoxXHc45hznHvses1R?=
 =?us-ascii?Q?EDtwHwutDvGMCrBTO/HWVEiwh6o8/kMXt5q6cCI9FnzjIPN0UtP4BTbaADts?=
 =?us-ascii?Q?kFOSXsuUjkir5mkq5Tdd/n2SIQk58nKr?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 07:12:08.3540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af46047-346e-4a2b-5452-08dcd2310c88
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4346

On Wed, Sep 11, 2024 at 06:19:10AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, September 6, 2024 4:15 AM
> >
> > On Thu, Sep 05, 2024 at 02:43:26PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Sep 05, 2024 at 10:37:45AM -0700, Nicolin Chen wrote:
> > > > That being said, if we have a clear picture that in the long term
> > > > we would extend it to hold more information, I think it could be
> > > > a smart move.
> > > >
> > > > Perhaps virtual device can have its own "attach" to vIOMMU? Or
> > > > would you still prefer attaching via proxy hwpt_nested?
> > >
> > > I was thinking just creating it against a vIOMMU is an effective
> > > "attach" and the virtual device is permanently tied to the vIOMMU at
> > > creation time.
> >
> > Ah, right! The create is per-viommu, so it's being attached.
> >
> 
> presumably we also need check compatibility between the idev
> which the virtual device is created against and the stage-2 pgtable,
> as a normal attach required?

If that's required, it can be a part of "create virtual device",
where idev and viommu (holding s2 hwpt) would be all available?

Thanks
Nicolin

