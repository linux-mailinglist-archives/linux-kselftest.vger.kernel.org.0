Return-Path: <linux-kselftest+bounces-23278-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9725F9EFE24
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 22:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0F7C168207
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 21:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7B71D6182;
	Thu, 12 Dec 2024 21:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ehZ67AqS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC621AAE28;
	Thu, 12 Dec 2024 21:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734038499; cv=fail; b=KCFPHbWh8qzSQveBTh/5CQZyhwDc7XGwbbsyB+RWyuaPX1Z/6652dxsr3bGKGF4moG/dfNu+7jBFusF4Mam/ZEA2i+j+xWzr0EpQaU3OrVIiAjLRGobwJxVhNhYu7Yv+IwNuxZpz/X/aCbeoNVdTbk9uteIIEu/ihnH4OF2ocP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734038499; c=relaxed/simple;
	bh=rtIDxLCgrgW44Nn4CXBlDlWKGfgoTVJAnbejhJZMYFc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czHqW1nH87rCydO9J6yxtvH97PZ2EKtEGIKb3VJ4SfwEdK2Ckk757cEU9Xibzdm8PhIj49rVl3k+t61QnTjcHEUljoO5WAsEzIooNlvu8DW7qCEaCdQnYCOvpylOIc0Gn8TLn/j9zERuGmcLJbDAzXuvjAyo9qANKdB/Fu1VEIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ehZ67AqS; arc=fail smtp.client-ip=40.107.95.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8OMuCKejX8eSEji2wiwQlArqoFi8pJ4lftch1KzbWzZREWBjagTnlb/2varnmFihQ95wozMoLV8IjEYkgmdChvW7Q0ca4MSMTGBrhrag78v4b7M+koxyWUl1GYzQAzYhV5jh7z54ddrzgq8a+cGJfjCQyGdturQvNECQt4nU6Ra62hL59bZgXzbW9/3yB75hW/e0SJ8a5Qd90cWdO5E0gtwRF6FjPPecs6rL38YH+txSfcjXjrqFH3er0r/k4SwskrVkYqyzb/XT7o4TcSzRL5IaVt4qPHgvsNTdOhqQ4WcNaYy19/zyHoOkD5ttRX7AKUxUM3E4Er9K7yDfOWGpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxYWH1xn+vsvHjJ5+8Gsm7h5aTPQtWOBOP0KudCxM+w=;
 b=eiLL0anDzmhAd8zlVVkoZytLDRursfh4RKlAH9wJSBVWfuq4RlTJPB70RMghMi93RWVz74KxGKzczMa9m57U5Tzh0HM5MLcBoLRpEUjnx2JBOWzR3KG6bIl/IIUVzj/OQUD4qycvCkVWdAFOIjihX0q7f6wJKZ2weKN4H5LLogiri7HvY2DENCPtShcRbld8rf9j+d6uYUHz20zW5EXyaTveeqPiAadPkEHEnYLyzdODztHre+jUJHLOrwCLjh49x7ejjc+X/mlqz4mBl/Kq9k9KqqiyEKaLIa+md5Uh8uOXGi0l5xGIa+8qD4+FnE2DzTD3VjpR/KMK00AzEiFA7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxYWH1xn+vsvHjJ5+8Gsm7h5aTPQtWOBOP0KudCxM+w=;
 b=ehZ67AqSsdxryticw16cKi6xMaPy23n/MgIinWahWKsvZ8llmKJt+h6cWH9wFcNNcB7leCEN5XE2us4etU6JoDKAkLyMEMYYtJBgK6X9ybbPWFSLneQ6wNdx1Dppg5HCltzvmvz6dh+WWKf+5mmS6pTNteHfyQEmS8ScRRsekDZFQZBc6GEpnsUV1WnIKIT6iS9qcJJ4UGNoGlbxl55C7KsUYe5V72RvEOBSx0Qd4TDUwdsAjvuZv2qSpPvQH8jasiwLrsrU1hM91AjkbtmMkc3Y+iFJPpSfEs2U5XAkzB8dioWNWM89iZcMqOX/4d7C4h5Qa6MToHAOjFDaCi6ROA==
Received: from SJ0PR03CA0005.namprd03.prod.outlook.com (2603:10b6:a03:33a::10)
 by IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 21:21:33 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::d5) by SJ0PR03CA0005.outlook.office365.com
 (2603:10b6:a03:33a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.21 via Frontend Transport; Thu,
 12 Dec 2024 21:21:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 21:21:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Dec
 2024 13:21:13 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Dec
 2024 13:21:13 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 12 Dec 2024 13:21:11 -0800
Date: Thu, 12 Dec 2024 13:21:10 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>, "joro@8bytes.org" <joro@8bytes.org>,
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
	<yi.l.liu@intel.com>
Subject: Re: [PATCH v2 06/13] iommufd/viommu: Add iommufd_viommu_get_vdev_id
 helper
Message-ID: <Z1tTxmgLhIQkAyTj@Asurada-Nvidia>
References: <cover.1733263737.git.nicolinc@nvidia.com>
 <d1e5f16d2fa4e9950e9caa93c5f98a5115c1580f.1733263737.git.nicolinc@nvidia.com>
 <BN9PR11MB52769AB45C92A820CC5233068C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52769AB45C92A820CC5233068C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|IA1PR12MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: cd6274e6-7870-43a4-5a1b-08dd1af2f34b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MMnfvng99kcl3SUXovpqrycrV4C96iQJUHD6mxh7Isn+PefA3c8NdwxFqGdo?=
 =?us-ascii?Q?VAm4URHCysYBTQ5NkZ/5bLQsPrYFqdcxO7qoaEmN3XQPAOgiepZCffEHcgR2?=
 =?us-ascii?Q?Ib23YBpRr5vrNx4hJOpFG+lvuCk7A1s1TMJ/Q2a4dD1hIgLY4/1KE/X9q0sf?=
 =?us-ascii?Q?M1JBh7GuWjylro+wTHelX8ww3rO+l/MkhGMW2hVR7IAazMCd0uwQ8dXl1Klf?=
 =?us-ascii?Q?i+LVAN89MFD/WJBs2WYj3TiA2xH6+ySkkJT5smWS0rEkUx79JppGAwwDO7tF?=
 =?us-ascii?Q?J14k6oEFin23PAlQ+DLMIDISvEfUfRV88ErU20waBLu16Aohyux4aT6GxqSG?=
 =?us-ascii?Q?94pkLZKGLVpkkSYWwsXj4Ag2mtnK80JNHNGpuUPH/fUqMAhSL/oUjTm9ZOFB?=
 =?us-ascii?Q?xrqSU4uFm4HeFobVZo1dzish4rdX0zoZJuM/gBZX7xDdQ5jvG8in17cK7qyK?=
 =?us-ascii?Q?Gsk0FYLSTVT+p0ljuuvcmhVzX05JLOZvSS3lfh1sV6WvL/NdOHHqyH61qebF?=
 =?us-ascii?Q?X3K9bpQZSSqyPztn1RAbHBtjZp5xfxiJIfCNAc14j/j3DT+fMtuG6Kcn1k58?=
 =?us-ascii?Q?fL/QhtcKCjOhHc+agFeIiExECzuUqnPd8o+9ocKd6IPLXsFHBi+Y7JMUoGL5?=
 =?us-ascii?Q?q0BT/qPdi/gIfxP90ujzdAu9uuOo1+yf3iOi1qjHtNt6Z6etYUQ/HwWsy7k1?=
 =?us-ascii?Q?FYwCZt0bXDdfjYPHfDsNxE+u8SxQxwx3WytCOuC37t8DWIuuxtS0X0uFVjRL?=
 =?us-ascii?Q?m0zNO/2/EOZo3GzgpRdReYR2THwEl/xmCd97VPNUeGUS2/cnJ41qspFYZ8MW?=
 =?us-ascii?Q?kcCvH3O+rnqVqn2Q6WVGX9WWAp+wxGLv68HF27RFuzmqChaA76yH53eKIN0G?=
 =?us-ascii?Q?vYiIdVG2lLuAsFh1j3ALabydrtteZNjDYU5C53YOXMlY1gOZWsS/ZaG64C6p?=
 =?us-ascii?Q?+VrvgpHWtngShy/qTu62x2d4IyDFJfcR9KnJ1js9Ro4fbSxyt+dL1n8fiJQ8?=
 =?us-ascii?Q?lJKDMyfA+xeAU/WDPlhaC5jKKIlm4xjdREPwC+df/vhFIQCC5QIDb9DdRdAq?=
 =?us-ascii?Q?ngcwbH/gT7AUKKcOrtqANzrJ3Hq8Iw/COBrtPZ3297p/deA6h/S5rW6hNLx8?=
 =?us-ascii?Q?sbloSu1+Cu3ClfZB594oeT5ZyDPJ0LsV5opDV+j11VbIqCcN0MjxYE91eLeT?=
 =?us-ascii?Q?ZUQ3sOen+t2d9gZgmRYPkuQkLYD9rLVfr0kImjBcOd6DibiePVBINwUCyijj?=
 =?us-ascii?Q?2L0sTvcRP1BF44j1jqorCa4K/SvAc1j3cGTEVOJRMkcewybL9/a2VBgirh+q?=
 =?us-ascii?Q?gjh+6qHVrLqGKjDKB+g/ZhygTZBhb/K1zp9nVZ5S1Ry6k+Ge8YNZpGe1+nTZ?=
 =?us-ascii?Q?vA2EXGaoS7PLZM/XvSa956zXlU26I+oV/lscUu3UF6IfR8hsR5okbqcjXMEG?=
 =?us-ascii?Q?naZo2u9SV2lxw9BKKKsZS7pkaiecuGNl?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 21:21:32.1281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6274e6-7870-43a4-5a1b-08dd1af2f34b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6043

On Wed, Dec 11, 2024 at 08:02:48AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, December 4, 2024 6:10 AM
> > 
> > +/* Return 0 if device is not associated to the vIOMMU */
> > +unsigned long iommufd_viommu_get_vdev_id(struct iommufd_viommu
> > *viommu,
> > +					 struct device *dev)
> > +{
> > +	struct iommufd_vdevice *vdev;
> > +	unsigned long vdev_id = 0;
> > +	unsigned long index;
> > +
> > +	xa_lock(&viommu->vdevs);
> > +	xa_for_each(&viommu->vdevs, index, vdev) {
> > +		if (vdev && vdev->dev == dev)
> 
> xa_for_each only find valid entries, so if (vdev) is redundant?
> 
> > +			vdev_id = (unsigned long)vdev->id;
> 
> break out of the loop if hit.

Yea, missed that.

Thanks!
Nic

