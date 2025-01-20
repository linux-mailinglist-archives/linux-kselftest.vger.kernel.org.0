Return-Path: <linux-kselftest+bounces-24765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DB8A1666C
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 06:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899093A8C86
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 05:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACD817BB16;
	Mon, 20 Jan 2025 05:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CIhh0sSL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DFE155C83;
	Mon, 20 Jan 2025 05:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737352533; cv=fail; b=bjjxm25qqpPoG59UWEGOH7+I+dAxXGso1XHNecWytYdbdmeJ0W8CBa9RMwLUqS9PtcvFnqBNx8wWCSUJJxvqYQo7NzEyA/yDkDKj7kL7/dIFfHMnA81QmWafL97yXrY1mphnzyoLyVMqgdqs4zBHBEwTqngg0V3VYtPDrvdRjgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737352533; c=relaxed/simple;
	bh=ON51j9ulIUvD1GZZlcRfQBRXITNUzjIN1YShiorszKo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/DbY1//1rsRTyVgl8K0tEmrtmTIKruTrfcwj4hlR7Ft/v9V4rEylZw6rGF3YITTfVIE+Sw0Vtw4RF6SfG8Hux9/o/a/YVX4vl1HNYA3D9JnS+005HqKfoep//c+RuE7U/yxt3molPIFVaS5JittNiimcvnm05H9k84DZv2T4Fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CIhh0sSL; arc=fail smtp.client-ip=40.107.237.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inBLfce6oU4rKAspCxbI4L8wb+y1ciaShQMRYIFVBdTCC81ymUTKf41FUF+FcvGl1RT28FZJ9JBXa7XYcpRCsBtg36ieiPjx2NhklDvd/4pM8RIDyVpS/NxeRZXELmM+a9oJBSOKEgdTrqNPpKmc4eJjGxB4YErUNVjH3iZ3BcywMpxzWzaL2FFcCLj1CFl6c2ElwYX5FWDVC3NClGwjYvzUUEVgB9hWsn4Fk/M0VxKWJHxIz9THhXxtE9zf9TrXswOULpZgJwBXExoeVYh2EWKVBvFBg9Qgrgr1eAC4bcCLdhnl6XOBcf7BBXHY4vjpIg/EWUrS5p73u4TX1ie3gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoOy3iAiHkY88Q5MUtIDKvNfkDheg6dy4glGY61L6Vo=;
 b=Tnpc5UmDVWN/bspQj6H0+a/EqN/8OfhAJ+kEh1+b9uShW9MH+JL1LBQyLG1BJKU1PCsuixGq+ZJ676aO+R00cOAs6RjlWD3CDVc3hUD/o4nJej7nzhdlNRWMIg+xgADg/z1Bf8HHXI5N6PYENiAXsKa5iHX3ivGM5/VBPfA+47xi4xEINx9bz+Ha4C4alxHfuzrq7hIOrJkg7Dx5Ey5uxtf10PZEfWW2ytTaGwf9MvL5FcKFkflM6iiBV77vR4f7g6CT1AVbsJ7/OsjDc8ZMJjzRi5BTadQRLu4T1rCXZMgOVU5FW0Rh9u2ogWQqy8SVst4UeiGxF4lUtDCut2bm4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoOy3iAiHkY88Q5MUtIDKvNfkDheg6dy4glGY61L6Vo=;
 b=CIhh0sSLwZp/uvCk4RfL9VBdJLtw/6KWHM7MsIC5aZ7sbQQlLVdCiFu+ihYCQYqIMH9I23S7g0y+9sN0hiOXT7CDE27nNuy37eHmYVxpS/RCGpUn0XuXxmUHm8TaPqZWtppI/ieKgsSmJyjSjXM74LL873rgVVAY94qahy0A39mHtYnLqyJwvvBhxojdTb4e+FwBbbp429lFbRw0hdAskuhiBN6b43WtMblx/jaUaWqJLbcXq8/x44VmULRPIISj3nYW2ooNBbiU8ixaugBfzxpVuQXA4wLdl8k1brTEFDV1gupYXGBV2vtCqGukamKep/1MOGQoZxHh9siVc3vHXQ==
Received: from BLAPR03CA0175.namprd03.prod.outlook.com (2603:10b6:208:32f::14)
 by PH7PR12MB7819.namprd12.prod.outlook.com (2603:10b6:510:27f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Mon, 20 Jan
 2025 05:55:26 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::72) by BLAPR03CA0175.outlook.office365.com
 (2603:10b6:208:32f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Mon,
 20 Jan 2025 05:55:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Mon, 20 Jan 2025 05:55:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 19 Jan
 2025 21:55:09 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 19 Jan
 2025 21:55:09 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Sun, 19 Jan 2025 21:55:01 -0800
Date: Sun, 19 Jan 2025 21:54:58 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<kevin.tian@intel.com>, <tglx@linutronix.de>, <maz@kernel.org>,
	<alex.williamson@redhat.com>, <joro@8bytes.org>, <shuah@kernel.org>,
	<reinette.chatre@intel.com>, <eric.auger@redhat.com>, <yebin10@huawei.com>,
	<apatel@ventanamicro.com>, <shivamurthy.shastri@linutronix.de>,
	<bhelgaas@google.com>, <anna-maria@linutronix.de>, <yury.norov@gmail.com>,
	<nipun.gupta@amd.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<patches@lists.linux.dev>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <ddutile@redhat.com>
Subject: Re: [PATCH RFCv2 06/13] iommufd: Make attach_handle generic
Message-ID: <Z43lMrJDdFEDaArW@nvidia.com>
References: <cover.1736550979.git.nicolinc@nvidia.com>
 <c708aedc678c63e2466b43ab9d4f8ac876e49aa1.1736550979.git.nicolinc@nvidia.com>
 <62ccc75d-3f30-4167-b9e1-21dd95a6631d@intel.com>
 <Z4wP8ad/4Q5wMryd@nvidia.com>
 <2b6c52f6-037f-43d9-8384-7b48764a3e81@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2b6c52f6-037f-43d9-8384-7b48764a3e81@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|PH7PR12MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: 07d86d34-844b-4bf7-a430-08dd39170933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dL3Gd1pK+S9fAQmPASNJ5mD30ornr4/usCchP0Fyckg4LBzTANOMVnzekveG?=
 =?us-ascii?Q?aZ5uh1Vmgm81tyL3cyDfvrekvfHuq5twkG1C7Pioq3P0mTIUuBiIkRUQJuDL?=
 =?us-ascii?Q?3lWptGQ2oHF7Fdyr6xn81mYf/YS5+ilr7Ik9KMMy77eAPmpA9z5Z1QraVNcZ?=
 =?us-ascii?Q?GAOQ6Z6FUXZfH7sO8km2WTHdtUlUt+JrtxJk9wD9yrh86TbIVJNPdbHoeQM0?=
 =?us-ascii?Q?BHjRhAERoRxsN1D8leEoEHnpP5LRAXKbQ99kkAErOi7pOhvjVQBPEt6HGjja?=
 =?us-ascii?Q?/SAODRgVuUgXLfM0jd6ISl8/tbb3bPKVEuF5QxkYMshQQuf6nP7jApudoOo6?=
 =?us-ascii?Q?oXN+q1U72M259L+zi8XDgQ2G+upr+zes4lADTI69E/KfzOOlvwy7DscZm8rR?=
 =?us-ascii?Q?kX0CL8Sa/CqdTV0IZSZUAkeAp536bj9HMBRGnw31ZqZeuw6yUh9DjS5HtWYm?=
 =?us-ascii?Q?S0lTYRQOxunXU8LYKkFt4JXct/ULl0SIe0yBpAabrCZBWHKjLfLdxPcBmKS0?=
 =?us-ascii?Q?ab/cIJw3WAEhX9mDEfEzIjewk8ssfhDjdLitt0nKxTbPWX5OTQGrrAVilvp1?=
 =?us-ascii?Q?uKiEd3V2inaO4iWy7bECPFn/XaGexSFTPaLtSRwyd0LtjDpKhRFiQ1ZXLLfx?=
 =?us-ascii?Q?jMWYOTsl1vGyE5qxoGSgCqed6zA5ULVVMjla2d37GILXiMCHjtJNEF69J9sf?=
 =?us-ascii?Q?JDnMEnv/1hbiNQ0J1Q8pKWbQ/4yaxqFB2BQvQlIao+aQOsXE0QP+GSjjen1h?=
 =?us-ascii?Q?vJIHMcJqBIP+YNAd1jXxr81Ve5gRSGhIoYdZIi5EnuP1q40fCBnV2fgTzknD?=
 =?us-ascii?Q?vR8DjHpVKjO2gT7lvr3TqmJenF2/rcV4AjBot/Lw7QlS3OL74kCu3tJzjszt?=
 =?us-ascii?Q?zXxRnhzif03trpgUgzuFytIUMMqi1c7aepClqoGGaLi8J42IQiH6QdO4XpNq?=
 =?us-ascii?Q?2G3B/29w+n+iOM7AM2bz1Nqxm0tg1RROohu5WPQ98ussXtT2W8KBln3SkVvu?=
 =?us-ascii?Q?3r8cekhUOKZ+pUzZMPtMBX1YFcTP+/Nm2IQLQiXVWutKOoIB5bB8DxOGN6wQ?=
 =?us-ascii?Q?n9CtMLfxoYcm7Rd/qWwR9VZv54ucgyASTmxQ22QVJxt2dc59x0q0i0OyI+wi?=
 =?us-ascii?Q?5hZhESOhXL0GTgfcfRn7LqSOeuiMqIRoYFexREMZgjg5D6Ju7PAoA98Nl9G4?=
 =?us-ascii?Q?MCH2erUAoKWB3B2gm9ipOwxe3IqXQPG0YFadC/TvFS737lmsSpMhgonBjMFo?=
 =?us-ascii?Q?FZa+7iIvi7XyluTTsc5zPrI6Q8TFAIvzLMQbQZyvbIsi3JuZABRIaVo0Gc+9?=
 =?us-ascii?Q?FGvhMofbexU+wud43hDmYnxFe3AwhRiWJ8BBNB149exRj4Vw5iNWMgBLjmlB?=
 =?us-ascii?Q?C3bsVJQe1UZICe8DBqNTKR9Fq9b7AaP4JkocDZ+DDrQOzxjWqpHPOJwpa3Zu?=
 =?us-ascii?Q?LL0Nn3l3eyJ6nMONP9HSbZlslLEiAzBipIPnTjeY7OrC74v8+2TjVhTJDc4v?=
 =?us-ascii?Q?iPmwVOagbeZq5Jc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 05:55:25.6170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d86d34-844b-4bf7-a430-08dd39170933
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7819

On Sun, Jan 19, 2025 at 06:40:57PM +0800, Yi Liu wrote:
> On 2025/1/19 04:32, Nicolin Chen wrote:
> > On Sat, Jan 18, 2025 at 04:23:22PM +0800, Yi Liu wrote:
> > > On 2025/1/11 11:32, Nicolin Chen wrote:
> > > > +static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
> > > > +				      struct iommufd_device *idev)
> > > > +{
> > > > +	struct iommufd_attach_handle *handle;
> > > > +	int rc;
> > > > +
> > > > +	if (hwpt->fault) {
> > > > +		rc = iommufd_fault_domain_attach_dev(hwpt, idev, true);
> > > > +		if (rc)
> > > > +			return rc;
> > > > +	}
> > > > +
> > > > +	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
> > > > +	if (!handle) {
> > > > +		rc = -ENOMEM;
> > > > +		goto out_fault_detach;
> > > > +	}
> > > > +
> > > > +	handle->idev = idev;
> > > > +	rc = iommu_attach_group_handle(hwpt->domain, idev->igroup->group,
> > > > +				       &handle->handle);
> > > > +	if (rc)
> > > > +		goto out_free_handle;
> > > > +
> > > > +	return 0;
> > > > +
> > > > +out_free_handle:
> > > > +	kfree(handle);
> > > > +	handle = NULL;
> > > > +out_fault_detach:
> > > > +	if (hwpt->fault)
> > > > +		iommufd_fault_domain_detach_dev(hwpt, idev, handle, true);
> > > > +	return rc;
> > > > +}
> > 
> > Here the revert path passes in a handle=NULL..
> 
> aha. got it. Perhaps we can allocate handle first. In the below thread, it
> is possible that a failed domain may have pending PRIs, it would require
> the caller to call the auto response. Although, we are likely to swap the
> order, but it is nice to have for the caller to do it.
> 
> https://lore.kernel.org/linux-iommu/f685daca-081a-4ede-b1e1-559009fa9ebc@intel.com/

Hmm, I don't really see a point in letting the detach flow to
scan the two lists in hwpt->fault against a zero-ed handle...
which feels like a waste of CPU cycles?

And I am not sure how that xa_insert part is realted?

Thanks
Nic

