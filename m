Return-Path: <linux-kselftest+bounces-17313-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2399996E170
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 20:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20F21F24450
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 18:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAFE16C84B;
	Thu,  5 Sep 2024 18:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IoK/9T5E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2EA748F;
	Thu,  5 Sep 2024 18:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725559318; cv=fail; b=uCnzJ3C6MN39xZgKf3tZb8/8ZCa/6g4fWpPO+z7ulqqMOoUGpoj1SPP65EW5u0hA6mC6NPJRV93KJbly6xyVxHxtQxp3XkuCK8EPi3g74VmQnzcRtU8DwBtBzYinBdunBGX1/SVLFn1bL0YbYbn+qwg74eZbjJ4JkySU7PibaQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725559318; c=relaxed/simple;
	bh=jUhbFttIFFS0rU+Wel5GmkmPx3ZIhvFy3tuKlUkfcrc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRZ3FESAftTsoJSKA24Mb+CSB12+6vRRLTcaIVuRfgL1AdSx7WBK6Cj9EEbtPEGsrHhw6tfobfES1qBBRJlh5A52/7SEZUKuv2DNagi/A2+sqQNT/SlQpjsXvYIwDplgFBRojDSj0mDuwT/RoJC1CXajJqQE5J3CJrec62UB3yI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IoK/9T5E; arc=fail smtp.client-ip=40.107.93.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QghAAOANnEYpkPqny1I7njxkUq4tyzzXRlirEEZMyOBVhDdtCPgqtoNVyNmfDBYfE59oIhHR1aQ5j1n6+BYD1EDDpmAwrkOu3LrXMZQzM4+nVVHQLWNMxAhQAZ5mehsbZW+jMAuzEBetzID4TiNMET/s5wxS4Xp4m0vZtfKh3wmsAwgaCZczGX3VHHXJtbnQykehjRWZHYctvzkNf8YJFOD+/08nPAb4t/VFQcQWRtyFHwsZBS0i05NnsiS1V3GHlUKRK4fq/OwlQ0J/q3UuZ/8ZxeEx9r7XNWNZRLZdsxpdFIQXpH+vixjhG8oSUAwcq9aUnSgOpS347MBkjDDPoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvnZ8fMNifvMU5T96APpDVAqwPlJM8DyRNlHID77DVg=;
 b=kKtCBEcrYyO5XOU5R1ABI8dkNacYhL8cZ4eWbGbnTyDxQYqISXHtJ4q57e7wjjj5j4YjIZCJiAz73e3z95wVJ2Sii5k3OUeD9bKVQVqT+L2odIXUWCQkelqbfEzDM7e80dNxsW2HYnp8peVptdYZn8Pqx3271ZtB7iCsDeGYQPYAOnOVPoAVWvkOmY5KF2CjpdLhj+ovcuSa5u9CkGfVSw+sxU7xW5Ruw5gpNcQrv9sWc8PTgA59WCsr7MQ5rkquc11EIT/A4BoDvTp5BWn5JRczSEWHkbq+yOa3J+9IfbpCni4KDu7HlXe9AjLGnuYHXHFXvTy8rGi5lJ0QLgMhdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvnZ8fMNifvMU5T96APpDVAqwPlJM8DyRNlHID77DVg=;
 b=IoK/9T5E55ry0WKQrD2NL9bfIvMREWFEKxyEkjoRgN38e6sNdsyp5g4X2GyYCL9xtLLXJ2OVSXh6ByEuwPIaEyrblSBllbfrxQa+QN0rf8U8+LkrHB6y4nPa9UoNQsPbAiWRL9EOWPP4pD9FMFGfK1fvhiTjW/5v85Mxb/111iCTQOQupZdh/i1whLVoJq+7fZurC/rzOwmNZEsr6hN+E4wHQumcgEa0MiuTGLncjAra2LReglUv7Z6Uk+Dbu5mB1iVquDwRnnldy+x/IYhMK+j9KppO3G5+iUqgYuPENEjoOaKh0Tcij5ib+HAWAl2L1w6j4pZMM+CREx6CxI/XGg==
Received: from BN9PR03CA0698.namprd03.prod.outlook.com (2603:10b6:408:ef::13)
 by SA3PR12MB9089.namprd12.prod.outlook.com (2603:10b6:806:39f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 18:01:52 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:ef:cafe::46) by BN9PR03CA0698.outlook.office365.com
 (2603:10b6:408:ef::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Thu, 5 Sep 2024 18:01:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.2 via Frontend Transport; Thu, 5 Sep 2024 18:01:51 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 11:01:29 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 11:01:28 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 5 Sep 2024 11:00:55 -0700
Date: Thu, 5 Sep 2024 11:00:49 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <will@kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 17/19] iommu/arm-smmu-v3: Add
 arm_smmu_viommu_cache_invalidate
Message-ID: <Ztnx0c4BpGt6umrM@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <4b61aba3bc6c1cce628d9db44d5b18ea567a8be1.1724776335.git.nicolinc@nvidia.com>
 <20240905162039.GT1358970@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240905162039.GT1358970@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|SA3PR12MB9089:EE_
X-MS-Office365-Filtering-Correlation-Id: c57dafd8-c438-4f1f-8f31-08dccdd4d1ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Daw36hTkG2K0ckUUUqiR+UuT4S+EMorgZAJ/CnAMhkxw1Au6Fr8LTP3x+07Z?=
 =?us-ascii?Q?qoahZFJRSfiwQaMA/44U8iw2mXi+VAvGnUXDEP2EodiOZ82XwetWFnxtLQ7i?=
 =?us-ascii?Q?0c1XQpX8sDwnqA1SFCFfrfZDOWxRbBjUOItAzpeLtUCpPnAfQFfi1s+ZNnOn?=
 =?us-ascii?Q?ptD19oZ6YdQNjurryam0g7gaiv/WuUcVvw9o/bXWVXWO7sr79RX4dIfljAMB?=
 =?us-ascii?Q?4RDWLoCi+NzB3W4J/7VaHaNnFw7JL2I9IUwVzUyLuydIoSGirAa3736KAo5L?=
 =?us-ascii?Q?t+Q84tV86gFWXjXhx5XRtbASFvloUFemFzYP8ORWSy2u0A9UboOvug4ZPQZe?=
 =?us-ascii?Q?lWz7rsFQhyYKNEZ6GDDRgzWYG2nbkBQG+wCYe8WvmIK7HA5RP+mPlvBeSqHW?=
 =?us-ascii?Q?q6oXuUVyS7Nw/C0dTUz3o6Q9gHCo277uWUkJ8CDxdmnvX3DB86hkt0P/X9pb?=
 =?us-ascii?Q?N7U2lSvxc24N2TCYUl4vx//SwoxITi18HpMAFij/InIZYxUEJn+u4FeQ5YdM?=
 =?us-ascii?Q?ubIO/yAQQr7DF7JWsK/hWMCrAQpLOtlw9yhq2N5GgNX//E+TEsl9r8GIK2hO?=
 =?us-ascii?Q?pzKxZCEQKl4Sd3N1S+8jW0kcurOodRnVf+3/pXqo8JEdFGDz68u/GKsZW2dI?=
 =?us-ascii?Q?kXj45+XF4LKLyfN68WXi0TU43MdH2vVRu4Rifer0MXuDzXulThGCPzvXtD2G?=
 =?us-ascii?Q?mx2muL6yeQwhxsPZj0u60nD1C0P6InhhK0V5avpVGW38hKJf+S4PeIPYPPHv?=
 =?us-ascii?Q?5VspYke6ShRWRoCUZ1kgSYchaKCkPjqwWeQcmEDd3bggBO2bhVN9V81tQZUi?=
 =?us-ascii?Q?b3bTp0cNAkd0Ysg+YCvLeWHy0jJeqpS/9PFYBdFZqP/RtTroAo+BlKxOGeBQ?=
 =?us-ascii?Q?KgqjSgzo0o+6690kNr/mUS5X43XPNotY77JW3N6J3Ufn5rwVMj+7keuKCHX2?=
 =?us-ascii?Q?SzNJ7eBEWOudE44BpA4pTKqaZvB6gw5JUFezM5qL9O77g7hmaNQ32KlSGYzN?=
 =?us-ascii?Q?vdmNapqQObTLSBdnXOfH3X0rYpT0fJKBiYkmBePWvEWbNv05Ie6pitQ/n56D?=
 =?us-ascii?Q?8qFVc5+11tY8fJGkrnT/VACHisdXkGFsc+oJuBDuKiZuWQCjfQi9lfvAFVlB?=
 =?us-ascii?Q?gegBduExYOku4F9JCIOWDM+6Y6j6DjMYjKy9awcaml+dCKSY1KxtBZVn8+bm?=
 =?us-ascii?Q?qXiyJ9DyesSYlYameqpXaQ8b4qbAQ4AhISqJkOzm67fWJ7ddhjgt6g+rZebU?=
 =?us-ascii?Q?91J0KoPYgPKEEuuCBvezXbF0yqj3OdUmGGLfQI8CsJbd+APxNVESCi4bctuq?=
 =?us-ascii?Q?5Y3Lu7sUB4roEGWSCauyBPK0N0Ei9/aczGgOtCr5tIUj+W7Yk/+cC8KcNVea?=
 =?us-ascii?Q?sWL1934yb014dtToXi0KjC+KQWAIIBZxpVyhX0Z7x3Te1Tf1a+iekL6k66pf?=
 =?us-ascii?Q?OMQDIERYyvI+oI3Yf+Lj6Z8J6RrdqGbl?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 18:01:51.4628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c57dafd8-c438-4f1f-8f31-08dccdd4d1ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9089

On Thu, Sep 05, 2024 at 01:20:39PM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 27, 2024 at 09:59:54AM -0700, Nicolin Chen wrote:
> 
> > +static int arm_smmu_viommu_cache_invalidate(struct iommufd_viommu *viommu,
> > +					    struct iommu_user_data_array *array)
> > +{
> > +	struct iommu_domain *domain = iommufd_viommu_to_parent_domain(viommu);
> > +
> > +	return __arm_smmu_cache_invalidate_user(
> > +			to_smmu_domain(domain), viommu, array);
> 
> I'd like to have the viommu struct directly hold the VMID. The nested
> parent should be sharable between multiple viommus, it doesn't make
> any sense that it would hold the vmid.
> 
> This is struggling because it is trying too hard to not have the
> driver allocate the viommu, and I think we should just go ahead and do
> that. Store the vmid, today copied from the nesting parent in the vmid
> private struct. No need for iommufd_viommu_to_parent_domain(), just
> rework the APIs to pass the vmid down not a domain.

OK. When I designed all this stuff, we still haven't made mind
about sharing the s2 domain, i.e. moving the VMID, which might
need a couple of more patches to achieve.

I will try making some change for that.

Thanks
Nicolin

