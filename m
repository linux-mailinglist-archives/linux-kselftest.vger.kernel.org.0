Return-Path: <linux-kselftest+bounces-17159-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 515B896C575
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 19:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75C5F1C20A1F
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 17:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633941DEFCD;
	Wed,  4 Sep 2024 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mY2Jpmi8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF201CF7AE;
	Wed,  4 Sep 2024 17:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470991; cv=fail; b=BSyr6YYNkZ4q/FNNTDa8Z3DTP4usjxw/w1SDUJsIEUtkBZ7iVi7jnCv3TyTKomLZ+/HoGFZPiu4rHwbOrTGt8DZXE7qLFe7HVEsxTuwrivTmf5wU5r2R005fz/KCPwxJYuQNntEr2z0+T/8V3LzubE3EOz/54L6mxbpI371wlME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470991; c=relaxed/simple;
	bh=YTh+vDeLWJo36nt14QmlU7aR5PyS5YhhZ6LoW5++eQE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dlu9R21A66b0BhhC30fmbnkz+jPXvdqmT9NhzHi58GPuuP6xzlAzuFAxJxtJr3NgXU5dlLb3pIHG/uTF0JD4EIVentxwhOlJmizrNp0W9kaYpzf4UtTrQiDlF+6YDrAMRq8obLYyyd3rwtWjDH6/UYqXu1j9eAfhdCYEVDFJRig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mY2Jpmi8; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XX7xxQ3OinhKWWOdEc7IN8XmqdIhdpuP3TTWQLoQI2eEfbi7iwZibADlJ9VCDaE86k8BtiVlewwn4gLJOqL2rhLUPxEyfpzJ/WELw6Z5OcsUkjZcJeEUTr8q2f9fTOeB+WsR6jcE3yhA9FdelbxbydDjjbb1q2fW42EDZfLqdaR9s0q52RUPBJ2k3a1rkF8qB5Xi0dnyPcazIuQ8g17pgaBrX9u+Gzv/B6NkA4BopPDHYEEMaCHkog3jP/vxSekdztc7dQq7H9Wv4x25LFccv6q92z5fqOd+DwNTqJ5fBY9lSc6jWzYCwV6NpbIGd+EOb2TYX/F19g3QCw9BLxIJww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiiKi6welKrDNGUdYmp5Jr79wVtHnRZiZDTozkxrJJU=;
 b=uuPFD8MgW8A8QNCNSbMkkxkoEyoppAZWwTxAr6DTJvoFJldfyd62Oa8AqUO5KJ43N/MQkGzEHbEK+0LBeUJOaLf01DQ7t5Yn0oopxTJI44rUioUq3hnzWe/KVbcz7Zx6HZzbnar4oMuymqK/LZ+HNcGPszV3P1VaVvcGY7kAu+q+a6fZY4ifBYJC/e6/YDEt91mjcLRRvqFer1niHIeVWXguiDi0yWwcRH0W+QeQclnQtRtKtKA3Y3nCYBe0WJcBfa913+HeZlgPZwb6w6Zi+bEL6Kmo4WghpJ7jgtse9VTV4K8lIT/969/GyV6XPrwYemWhLwlvfetTipqvnGARjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiiKi6welKrDNGUdYmp5Jr79wVtHnRZiZDTozkxrJJU=;
 b=mY2Jpmi867vGEzvYcxHu2+hpI+8QBB1FyluAKFKiqFFTtYUcqnbcKl/Gtul1BCSQZNKi8bSw+i03HKS3cFGz25aNvcVI7D79EDb5TUpGW8G6nOSUBwR/qhSJcwRF7KOOI8u0ciLqtKx5ZBjmTbFwROXv/L3tPEbOTrti+SdG2U2+grUBbK0bmVCAYBxX4hVH45D9pr/phZ7n7HE0lLaPAD+nYb4ThXYDabil5lFZkljgxOuRX9Rh8Quc1J9TDFTwjYxUh+8WhXYfv0wjbbYm8PYdXNHR68Ie0clcPYMF1IsLcDpU/a9XggJZ6jsm8euwMGT5FBJHgo8qR/N2kxAzdg==
Received: from DS7PR05CA0013.namprd05.prod.outlook.com (2603:10b6:5:3b9::18)
 by DS7PR12MB8201.namprd12.prod.outlook.com (2603:10b6:8:ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 17:29:45 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::ac) by DS7PR05CA0013.outlook.office365.com
 (2603:10b6:5:3b9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Wed, 4 Sep 2024 17:29:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 17:29:44 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 10:29:30 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 10:29:29 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 10:29:28 -0700
Date: Wed, 4 Sep 2024 10:29:26 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<will@kernel.org>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 02/19] iommufd/viommu: Add IOMMUFD_OBJ_VIOMMU and
 IOMMU_VIOMMU_ALLOC ioctl
Message-ID: <ZtiY9gE9YDbgJyRN@Asurada-Nvidia>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <c6ac7dc5031e96abb4634db504a0bf4a0c82ca66.1724776335.git.nicolinc@nvidia.com>
 <55918c41-65c4-435c-860b-b2a177b0d364@linux.intel.com>
 <ZtVMrXXESy/RfWVi@Asurada-Nvidia>
 <20240904162621.GN3915968@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240904162621.GN3915968@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|DS7PR12MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: 08895347-1911-4595-b5a8-08dccd072b0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6m/BjZn8GZufdDC4mDe/5y440Lrh+1oXPxx+EpddM+sGne9FFJOj5SdV8j2L?=
 =?us-ascii?Q?7S4nHLTQR8lRqHSchmJWQYTKug6H+jOkUK3x2AjvN/nk3pHchzEu9933LFly?=
 =?us-ascii?Q?q+0QH8Eec73/L6S+6YPW59QWmLF/WfoGO4MtYWjKJ6EGzKYxqiYFJc/h57vH?=
 =?us-ascii?Q?h4w2Rw/qj4j4Se+DEH5v81l3NOPqzyqUPvz6n7zuj/FEHLED2uznOyG0H1YT?=
 =?us-ascii?Q?N3FiisQN6+IitF4Hmo4GuVZWBPQccfGdIPyw0xilYtsEb/+VBgGkBjWd1aL/?=
 =?us-ascii?Q?p5BPj2WBN+vDDm6Q9ri36DJ/pa20FBzkuzHlyJ0prPjkiGFhk4GGvxwkIjVS?=
 =?us-ascii?Q?086v8C3vJilfDjA8e/RGzbr1bgNK2YqVASWAHuK+KIIbnpFbfgGCsNR3D2uq?=
 =?us-ascii?Q?ZG5pFnAfwaeuIxJtyKkoV2fofw0Kxh9Z6Gj9Te0qBO5At/EWVfu8su97AM8N?=
 =?us-ascii?Q?eKae2ybrwf+Ux6CAEpkvVISvD02IBQbFiEGDWDSkY+7YFMhb8vLABYQxKMIq?=
 =?us-ascii?Q?hXUqutCPYE9UdxWucQ2MjbWmf/1bEoJxnizNUAkGRddNj1AsZEjib9iSiVP3?=
 =?us-ascii?Q?YU9MHpuYAmTmbhDZKDyy9MvKBYpUsNyaIQO10qFJcRERdCTjtgSTQdjUM1eR?=
 =?us-ascii?Q?hQodRq6d9lN+atrLDCPfnFNQsbmDx9jxjQW2Neuy/2c8XVxZgjw6OKFkaoDM?=
 =?us-ascii?Q?LhHtKxk/4Y8sI90y/f5YajyeizCPoAju9iBNxLNdb94z4xCDC4JU2E88RFEQ?=
 =?us-ascii?Q?aXTUU/L8jJO6lvulORHqVdde2KQ5xzNJbZL6zLfBM5kkjaJxL97vrJdmAo6l?=
 =?us-ascii?Q?6AFGBfzFj5698Zfnpj9KrfoyO1fmrj5ZIfeUNgKoFuanOB7232ndKv8KzprQ?=
 =?us-ascii?Q?Qe/NFJDAnOMWM7z7xjX7wjyTthLMWTxN8YNavxt+VkcItq77/OA+kBHEJk8H?=
 =?us-ascii?Q?JbhkX2xOPEYI1BvX1dVuz6Do0Dp85Hbmnyrttq9YaBD99ofAT+EF2E/4vESo?=
 =?us-ascii?Q?x+MWnyVmRiTfNRZs9e8ehVF6owqEBJQhGm/ueXCB2ioTgosqK2nj6E3ZwmvM?=
 =?us-ascii?Q?34HoXPRMxNm4/dqAX4NqUp2gCPKbL/y+hyvuhXa5P/1HxIhs2E2PYd/8tzSU?=
 =?us-ascii?Q?2GN43FgHT0bQiLMreUmPIL+k+6IQKtSXxXZF89MEnUbFn88TpFD3gYefcZmq?=
 =?us-ascii?Q?996+EjrB5zg+jfT/EZpO8VIQfSDFelptLNh0Oza0Lty07yEbxC83DLjKwz7B?=
 =?us-ascii?Q?qk+jjshDt5KbdPz6FRGJSNWPGIBjdSHnn/bZPlV5KsR5zMtsA94HfKHKupKj?=
 =?us-ascii?Q?lYkWQ75NKG+NRlp+hErMzJ3hakqFNw8x5oEIvUHTjDzkmk87tcTxalFkp3L1?=
 =?us-ascii?Q?FR01Iyjc3JXLIf53SbDTWPMm6u0SDJxyOphiXvAIbUrKJk8VcSQz5ilm8xIZ?=
 =?us-ascii?Q?MRRE33XpHKAgucRQX7t/OdFnM0wNMjDT?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 17:29:44.9054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08895347-1911-4595-b5a8-08dccd072b0e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8201

On Wed, Sep 04, 2024 at 01:26:21PM -0300, Jason Gunthorpe wrote:
> On Sun, Sep 01, 2024 at 10:27:09PM -0700, Nicolin Chen wrote:
> > On Sun, Sep 01, 2024 at 10:39:17AM +0800, Baolu Lu wrote:
> > > On 2024/8/28 0:59, Nicolin Chen wrote:
> > > > +int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
> > > > +{
> > > > +     struct iommu_viommu_alloc *cmd = ucmd->cmd;
> > > > +     struct iommufd_hwpt_paging *hwpt_paging;
> > > > +     struct iommufd_viommu *viommu;
> > > > +     struct iommufd_device *idev;
> > > > +     int rc;
> > > > +
> > > > +     if (cmd->flags)
> > > > +             return -EOPNOTSUPP;
> > > > +
> > > > +     idev = iommufd_get_device(ucmd, cmd->dev_id);
> > > 
> > > Why does a device reference count is needed here? When is this reference
> > > count released after the VIOMMU is allocated?
> > 
> > Hmm, it was used to get dev->iommu->iommu_dev to pin the VIOMMU to
> > a physical IOMMU instance (in v1). Jason suggested to remove that,
> > yet I didn't realize that this idev is now completely useless.
> > 
> > With that being said, a parent HWPT could be shared across VIOMUs
> > allocated for the same VM. So, I think we do need a dev pointer to
> > know which physical instance the VIOMMU allocates for, especially
> > for a driver-managed VIOMMU.
> 
> Eventually you need a way to pin the physical iommu, without pinning
> any idevs. Not sure how best to do that

Just trying to clarify "without pinning any idevs", does it mean
we shouldn't pass in an idev_id to get dev->iommu->iommu_dev?

Otherwise, iommu_probe_device_lock and iommu_device_lock in the
iommu.c are good enough to lock dev->iommu and iommu->list. And
I think we just need an iommu helper refcounting the dev_iommu
(or iommu_device) as we previously discussed.

Thanks
Nicolin

