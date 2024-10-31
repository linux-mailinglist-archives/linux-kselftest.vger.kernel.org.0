Return-Path: <linux-kselftest+bounces-21230-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E859B8053
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 17:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBDA91C21D75
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 16:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241691BCA01;
	Thu, 31 Oct 2024 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kmm5GdTp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F2D1BBBE5;
	Thu, 31 Oct 2024 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730392725; cv=fail; b=W26SKuWMEJmaRPBGZWUn5W+7zHuAj1zI68JulsCPKzcPoLUPSGMlGYCk1/ESs6K4FeQT7Tlb4qv0rnrjGZOz4Hk5qG/QwFwbqkO57ar8vOxKsgVLBlZD264E2pnuTgzoeI/IQ6GvvQTSAjI3/m0IJA9XyovTIXA1M+dA0FPzs1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730392725; c=relaxed/simple;
	bh=8LIJMWU4SX69hnIqoJtx6vgebwaEyl6aiSpmA/iIg7Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrG6dUbnqgm0W2LwLGO4LzaatCEdjNgek3bdTvFFP5V6dyEoaNU1N5oL9i0jX9D9ufwBoyopeLXVzJuqA6w4wguCWHVMcHWMdquPJtwRvJCmCW6apammEu1Nj+qdxKOCKT/T9lqGUyj2LlENU/9GM3G6Pw5qh2BNgfuxYHeHzjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kmm5GdTp; arc=fail smtp.client-ip=40.107.93.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVMWfAFEMm509sxLLPQQ0Bj12a3L2+zJ9PKXMxEsJ6UndCi+RC0Jvb4foSq83NW4AYBA/VYYzdFogLH16Yjpa+V0KMFrSd6ku7K99MQ2fPoC4DxtrCET1r5tNEdok26BSlyOP+3ND6lR+u7xWywOEWUCgSW4O7KocfTiw0F055ZQ/EFzemf+sKlR4SOFy1SGD/Dz+oQusEI18ORPT1AuisEFffLZrCotCPvQj7MxZtDNnpHoJ/sQ/Sb4QDdZakmP6NNEESmgrdtWKrFdQdfZDfG8Qhwcm4pT/oOyOhuZuVNM5l+yQuVxGFIdA8CrRULp5cOv5m/6vfITVSe6BnBdTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=al075n3Vi9qXLh6LuiSxnTLGMHFnZoItvekcuM7iQWo=;
 b=b8p+KxDEcy+XjjAkNwqtlz5mHMVt7RME3sYj057P41f2j/+0M4etDqh/yyALI3yaObex+n4waMDegbBa6p5TwLVeRHrTG0j8CR29VOuwQkdpR/acobLnn/Ast5NxJah+ljlwd99d9XgEGMzutm88JE4DkHC4Ip6miYb+/9JmcQOs919RwmXDr9LrAyqVzXrBO0MO/s+5TVEBTVxvEiYI47CERjwghIJTfv1Zl8vAAwrp3IC71btTHRWQ/WSa0/pnbgets3NBA2aPitlsVGikvhizACLHuJQycIcua6jGRnmQ450MDmGt5TrLBN4yB3DdG2rRaeZAg3kaqBrRo3c/JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=al075n3Vi9qXLh6LuiSxnTLGMHFnZoItvekcuM7iQWo=;
 b=Kmm5GdTp91pNLpsfqiJVmiY+9zwlJjF1QXm3yuxGNtVz2lBuPRlqlfub3/vVrDFMflof1KoXbTtKyElhjDy2y85N8bzks7aXuc9b5itVS0741mn7W7FoZZGd0jxadLLNxHZKYx7tH7yVduDLgrsRxrtlCNqYu7FxjFRq6IkizPVdJixebsX7rvD3sl5vvsDeKpV93eCHbqlrqxEfJci4qitsYFFQru/RFBZSdOv8V0mjDR0ksVgn/MdwqAgeT+7jJmaCe+jJEzTxVB5PICWke/qWBSADbr0r72dR1GQyjzITP/mYEPxQAu6JOJ7uPnMDwDyq0N7spIUsFTMdsPIF5Q==
Received: from SJ0PR13CA0161.namprd13.prod.outlook.com (2603:10b6:a03:2c7::16)
 by SJ2PR12MB7896.namprd12.prod.outlook.com (2603:10b6:a03:4c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 16:38:38 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::72) by SJ0PR13CA0161.outlook.office365.com
 (2603:10b6:a03:2c7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.7 via Frontend
 Transport; Thu, 31 Oct 2024 16:38:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 16:38:38 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 31 Oct
 2024 09:38:17 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 31 Oct 2024 09:38:17 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 31 Oct 2024 09:38:15 -0700
Date: Thu, 31 Oct 2024 09:38:14 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <shuah@kernel.org>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <baolu.lu@linux.intel.com>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH v6 12/13] iommufd/selftest: Add IOMMU_VIOMMU_ALLOC test
 coverage
Message-ID: <ZyOydn+/s6enh1jg@Asurada-Nvidia>
References: <cover.1730313237.git.nicolinc@nvidia.com>
 <8188b47bbee49e071907e1df37a3af269bd840b6.1730313237.git.nicolinc@nvidia.com>
 <20241031131637.GK10193@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241031131637.GK10193@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|SJ2PR12MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: f2a14d55-72c5-4e49-13f8-08dcf9ca7905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hNmid6y+ew1qlSKZfMykRnSGj7+sjFQoZaLZ9kgmvhoiuiO73uybjt/8U36i?=
 =?us-ascii?Q?0slf8ekUj57nKX4HxQQjqVMzOhZNRXVKIV7xXbssLBz3cLwNG2+J1D6+yitJ?=
 =?us-ascii?Q?CoCnCsyy69jloUvV4p+XrYWJoa/bYC5Pv2hVp4glWb474WQeLA2DNLI9xwMT?=
 =?us-ascii?Q?SekkAMAvEa7XGYqLKfuCb6aeVX9mYSOElLi4CDL7oZLfq5mfS8PHKZNFsoN9?=
 =?us-ascii?Q?rcXiL6Q73fsSqA6vKjMvyzAQU63aJAIIf0uFkOZy9/G0bFOI7LmSN0L4QZk2?=
 =?us-ascii?Q?8WO1vlMrjofV0PHrD9+qM6oO2D+tUN7u9PO1I6IbV6NJzA38tlyBwM/jfqxf?=
 =?us-ascii?Q?DVh9g962GQ/hWY5BJ6LWsGiwaHTTtFPZZYLGmNUc4676IphjWVUoIIkBddyW?=
 =?us-ascii?Q?Hfdvwu1aqqtFWgvQs0i/maD8oEr4qhA6AKIqNkh8mNri0PQTt7g2WiJKZLNr?=
 =?us-ascii?Q?32nazyIcDDEeC/QMa1JEQdJz/i47GIbH61TmWQBk5oiRe5RLfxJzM2uSKGIN?=
 =?us-ascii?Q?qzJCujJz0GyHnDrusKsM+Qxyv0xOrwyBtBqxju7AfcNhvfROhlandQKeAotl?=
 =?us-ascii?Q?4l7cafn7BAJpdj+N2yeK8m3cTxfZFyGlvu+/DG8KV17Z6Z48/BiNPOELbZPq?=
 =?us-ascii?Q?esAG4NIbvB8+S6dtB2AUx8hOcF5ADhI4gll/ktkSPOBt44KGgIUQ1sCDmRz5?=
 =?us-ascii?Q?M2o8/6161yQEnPVIWSGKyRe0y5gziw98lxfjTIBxIKTpNAgBTY6ug+ijImEP?=
 =?us-ascii?Q?4HzKKyY73aU3Tr81oDKkHlP9NCpwuXXmvAOUTYQOyO5uF4kt9RKgkv4UNl7Q?=
 =?us-ascii?Q?JF+ndDLRr4ZME/xkUYvF8gDmQWo0xGCHJSF0QHqHi3HMMLGLzDivVS+hnOyj?=
 =?us-ascii?Q?AdtrPieTNafloXFMP3HuNXDH7+q3zigR/2HaitkKcYdnnqlSn5YgfcBvx4UG?=
 =?us-ascii?Q?UVm1u0CEk5VDOvc1myV43Z1/YRxYsy1tMEd4q2vTcwAwmgzQ7kbGT/s6qsGf?=
 =?us-ascii?Q?ZwIWWxe17GhqRdIrTy/qUZENBsDI2VzjITJ3eyyqbbeyg6TJBJsx8gNpoeOl?=
 =?us-ascii?Q?hZ5VvhxjHJM9ajLPU4ImOtrXQMJsLTFEkF1gw40aCUT/Egkbmq8Vmyc5+lE7?=
 =?us-ascii?Q?zO2eZulln313Vb+BST8f+h2Hr+i3Dnsk1L+/o5Dtn2+uGIyT3GhhRl0/JyOO?=
 =?us-ascii?Q?JB9p8zJO8e+Q+qWtYD6uCyEfHy1ED8ELvSOk17191/wxo6t5stJykFaw/AfZ?=
 =?us-ascii?Q?erxv8zK1vlcO0BQjwhe99hq4gCyoa+4YOhFWlq3FSHnofUTOvALCav9fyr5N?=
 =?us-ascii?Q?L487vUzDBW6O+soeh1ilc0VUus7sIt4o+CN0n13y5MxB0fY691Z0p390Gl+P?=
 =?us-ascii?Q?w6NmfhF4yvBOmAMOuIvqKvpJxPGL1L746IzhcNu2TGv/TYtEeQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 16:38:38.8541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a14d55-72c5-4e49-13f8-08dcf9ca7905
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7896

On Thu, Oct 31, 2024 at 10:16:37AM -0300, Jason Gunthorpe wrote:
> On Wed, Oct 30, 2024 at 02:34:38PM -0700, Nicolin Chen wrote:
> > +FIXTURE_SETUP(iommufd_viommu)
> > +{
> > +	self->fd = open("/dev/iommu", O_RDWR);
> > +	ASSERT_NE(-1, self->fd);
> > +	test_ioctl_ioas_alloc(&self->ioas_id);
> > +	test_ioctl_set_default_memory_limit();
> > +
> > +	if (variant->viommu) {
> > +		struct iommu_hwpt_selftest data = {
> > +			.iotlb = IOMMU_TEST_IOTLB_DEFAULT,
> > +		};
> > +
> > +		test_cmd_mock_domain(self->ioas_id, &self->stdev_id, NULL,
> > +				     &self->device_id);
> > +
> > +		/* Negative test -- invalid hwpt */
> > +		test_err_viommu_alloc(ENOENT, self->device_id, self->hwpt_id,
> > +				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL);
> > +
> > +		/* Negative test -- not a nesting parent hwpt */
> > +		test_cmd_hwpt_alloc(self->device_id, self->ioas_id, 0,
> > +				    &self->hwpt_id);
> > +		test_err_viommu_alloc(EINVAL, self->device_id, self->hwpt_id,
> > +				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL);
> > +		test_ioctl_destroy(self->hwpt_id);
> > +
> > +		/* Allocate a nesting parent hwpt */
> > +		test_cmd_hwpt_alloc(self->device_id, self->ioas_id,
> > +				    IOMMU_HWPT_ALLOC_NEST_PARENT,
> > +				    &self->hwpt_id);
> > +		/* Negative test -- unsupported viommu type */
> > +		test_err_viommu_alloc(EOPNOTSUPP, self->device_id,
> > +				      self->hwpt_id, 0xdead, NULL);
> > +
> > +		/* Allocate a vIOMMU taking refcount of the parent hwpt */
> > +		test_cmd_viommu_alloc(self->device_id, self->hwpt_id,
> > +				      IOMMU_VIOMMU_TYPE_SELFTEST,
> > +				      &self->viommu_id);
> > +		EXPECT_ERRNO(EBUSY,
> > +			     _test_ioctl_destroy(self->fd, self->hwpt_id));
> 
> There shouldn't be testing in the FIXTURE_SETUP, it should just do
> enough to setup the fixture. negative tests/etc should be in their own
> function

OK. I'll make a change by moving all EXPECT_ERRNOs to a TEST_F.

Thanks
Nicolin

