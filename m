Return-Path: <linux-kselftest+bounces-18808-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D517D98C58C
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 20:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4980CB2245D
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 18:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2C51CCEDF;
	Tue,  1 Oct 2024 18:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e3tMCIJb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7707D1CCECE;
	Tue,  1 Oct 2024 18:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727808343; cv=fail; b=WJsy9rduiXd8yJopmb+abf+9WGD+7XDxbaY2dgKQ4y1Mu6ayu/BH4XiLAMK9H+Q7vVZq62vQNpgneLFEQNhXPlG3OMnn5v+S8Kk/UaPhG+HiSLVubXavejNPLmieQboxrJGkpnh00/s1XhqE/FoYJoko384L3oVwIcwS5B+rzuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727808343; c=relaxed/simple;
	bh=jQOo+z66wXT2BJ8v4QDGsKoXW1UU+AD+n8KLIaHrMZ4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWITefD2mVVMNAUWXx996XAIn/mJ40wKS0OboYPKPbgDIvjL6/FMZrMR+41a3Q28XSzhZYt+8lo7nHWB8V+SQtiJFRjd50Yka397oKc1NpJCiMr6kV2waJyQ52gHMJOSPNXgPF3YbTdmGX4xTC3Ls/5o+xUNga+28jiCAhMUZ/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e3tMCIJb; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBjIpcr5T3ogFhFwFOEx3X0opIsivpgGmtW7YxnJdCPehKcZpRrKHdABDiHSYfxqjyBEj1+g1/mR8IZHiOXFiB1O3pv/JCgiHWEXs8uoUY/nNQmQTbn4sHKLQfjIDWiMEC3nfLYVqcI85flahfAJII7SdwkcG26ErOqCU4XxfT4/02K369mIkMm66lBBFvP7AZo9mV7vWfzoHaIAS703F/3WpezAg7X3NhLJxYokC8k1OepUWxPNDIyxST3AhTUYl/zunq7g3iA4SOh4DbE+IW34cl5P8lXVYKBZUjss6T8MTGyXPP7y+h3eSvzWXbE7vUZ+QWF/eJuyuiAr9rYvjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjup1uv5tTHEviNkNCIwZeokX/pMTkvqBt+7yC8Wa1Q=;
 b=X15cXKxW6v6d5hSqpGZ6fZlgELm+hQ7TtjGfJqhsbxtAX2EhlaFigG4ay5isXemMoUre/0ve9WlId4ULBoSdY9/ApDvnZrRkN/ku0LOcCTEbH17+Do6un8B4i8UzQVR+IYulR7LlbeMZNaBBw3kgQaaekiElEjtFaIvSCNpqnyJ4b3SudE0MFpHoA7LO7Jal7FMIWKYMB7An5Doipsg5PgFJOTVO2Uot9DoIhzGxfMcFhvomk5VeAu0nqthLLl/tp+a0yRTkSx4O++8sH+wsEraU/7rOHNqXrIjxCYA7mcX7BWKaQtjkwzVneLDCxoaEYTRdvQR3rkLstVdb98jGXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjup1uv5tTHEviNkNCIwZeokX/pMTkvqBt+7yC8Wa1Q=;
 b=e3tMCIJb335jLAJRY6u/+cRhLGMoRK5ZNSL1ld22WrPg/2ioZr7gxdV3T1yRInQtJAjYpJNKUBKCCe7LElGZGw8CTev/TJ4F+IixvhJK8pupZxie2GMAeYgZkPd08GiXCUIn9g1sp6B4N+d5nemK7eMPj0dFEWF6GbdrwjBl3Z/Ldb4V6zqDZMPkK+krLq3ZFX29wnLdBD/pnRBR+IPNDiXQ9gscGUXTMzjZKsqTDAufE6Ob5okpWg3Ud7m60zj1xLEPL6MDfqewBBkPlCk4M3zOxxQeJblVduSAGA1L7pR2BEjrURjPFFbqQwC9TRd2MhWjMjLYhUZS2yhQ5oRKcQ==
Received: from SJ0PR13CA0029.namprd13.prod.outlook.com (2603:10b6:a03:2c0::34)
 by IA1PR12MB6140.namprd12.prod.outlook.com (2603:10b6:208:3e8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Tue, 1 Oct
 2024 18:45:39 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::7b) by SJ0PR13CA0029.outlook.office365.com
 (2603:10b6:a03:2c0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15 via Frontend
 Transport; Tue, 1 Oct 2024 18:45:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 18:45:36 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Oct 2024
 11:45:17 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Oct 2024
 11:45:16 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 1 Oct 2024 11:45:15 -0700
Date: Tue, 1 Oct 2024 11:45:13 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Dan Williams <dan.j.williams@intel.com>, <kevin.tian@intel.com>,
	<will@kernel.org>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 06/19] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Message-ID: <ZvxDOfPEbot1HUkU@Asurada-Nvidia>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
 <20240905160353.GP1358970@nvidia.com>
 <ZtnsaWgeuuy7+cJG@nvidia.com>
 <Zvu4rZosYFjCuEC/@Asurada-Nvidia>
 <20241001134620.GF1365916@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241001134620.GF1365916@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|IA1PR12MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: b96c1f9b-6b84-4df8-52fb-08dce2493d43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7ZQIfkhloIo+beduMPch7A7bgmxSvYYECSMGmUtCAqPvuME7fQYDSFsVKhO7?=
 =?us-ascii?Q?QstMoaBE7SuHTfmKEN8oj2A+WzwOzLzzs7VvzIpUt4j0kzGCk8FM5+a3X+z0?=
 =?us-ascii?Q?O3uSQDzPo+8kcbnpzcRFpdUr6fmn6bZfCA5bIV66DLEoCCSGLzYz6Jwzm28j?=
 =?us-ascii?Q?YfLEx01gwHHhTlkQ8KNOUdB0mxkHTOHb5Keuc3Wt3aXdT072U7IVjgJuCqyf?=
 =?us-ascii?Q?Z/GoyJVIpzlNkDpmBF095tQ6kq+4E525597cDtlsFCNyzS0EJtO+hzlG85Uf?=
 =?us-ascii?Q?HiDUlSAuQWIim48F36bbaRIT1Ve4H9inABM9N0ZODol7iXlZIZKCM4aZoh0h?=
 =?us-ascii?Q?ObcmZLnx9fbHlQpg+3JMIgOhWhGIkP5eKZkdYmIDvvE4+1BhUGDHodQtvzwC?=
 =?us-ascii?Q?jMWrpkX62CDby/Rx87K8dhg7H+t3El8xbIvhll33XAzp9cHH51dmcuD2k1BN?=
 =?us-ascii?Q?Oeoany/mVBKqxc19Qeb2Mb4i73kAHOsNFLverjMYwiWFVs8z09cd7R9ZAbOv?=
 =?us-ascii?Q?WFryjpyAsT8Vddxp81ia5M8R3qcdubRI36VmhUVc0AzZ8Mjr0WW2oo61FQmz?=
 =?us-ascii?Q?5tJLfsWf26kaPnSeln1Sk1iFvKsQKtUTCppXabab3rEpD9W1fMFGG+dVxhBJ?=
 =?us-ascii?Q?yqFgN5WgfzZOl7TlEaFU/TfuTrZFJE8X7DH51Lv5M9k61p6lRuViTATcgQV+?=
 =?us-ascii?Q?cbxq+G3cyhO8LzGXBbRmXBq8wXjFW8uuJVuBPV9I4jSpYazkNbQOGoqMkDnk?=
 =?us-ascii?Q?wCp52shCVPTYj9e7zlHljONoRw7tmyhM8N4QnuQbktxPvQt5iQA+3EebE9H8?=
 =?us-ascii?Q?9/oL4Kf9zEeWbXQ+AatBBn06Kcs9hmMjLoRIymZ6hPwgmrBCaqwDLvr30EEL?=
 =?us-ascii?Q?HfrHQLay1hTN+/oLlEv0v7jileGtMKZAwh+TZA9oByMbIC7Y3R78xas9sPKh?=
 =?us-ascii?Q?ZuP2JBMV1gY8X+cTzGyxE7aBMstbf2EOtmesIoeHDv4VPiK9TvyHTv9EdA7F?=
 =?us-ascii?Q?i4pNx7sDjhQqR6xyKNgvEHMqBUCQ8Td2YVldkBKu0CdOK2hbQHeUHlUMZBgu?=
 =?us-ascii?Q?rcklDA0HwcixN2u6nkjiHGsE2wBawy4R45mxK5UfRcCKNvBTbETnfvVloBZV?=
 =?us-ascii?Q?VUVWxrdgGO3FHmz7CS7KAtHLRTGCEF1b7P5gHziuPcEwiY3QiWhnlzFxXqWv?=
 =?us-ascii?Q?5U2ot2GwigAz6AM39pVMqHWPshTBbYy+wQvlTTp7FusoEM7w/nkWuVt4fko5?=
 =?us-ascii?Q?JNKF1Ve7FlSNXOIefmfYSkdlCCPTVIo0BgMxq6G+3Hu1bctjdhKdNN1rzxQR?=
 =?us-ascii?Q?kNn7urt0dV7xHuNB71SA7Q97Gf16OHUasRkdR3bSifr8SYFd9pfccCIZIlOj?=
 =?us-ascii?Q?OQKug9Nw54Dz9b9P0H4mbYxsRiYwyLmzf31wXXcCiDEYYnRkQVxraRCS16Qu?=
 =?us-ascii?Q?dZee4qtbIj9BeiSdVJfJYi4TWsdaaVXP?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:45:36.7142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b96c1f9b-6b84-4df8-52fb-08dce2493d43
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6140

On Tue, Oct 01, 2024 at 10:46:20AM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 01, 2024 at 01:54:05AM -0700, Nicolin Chen wrote:
> > On Thu, Sep 05, 2024 at 10:38:23AM -0700, Nicolin Chen wrote:
> > > On Thu, Sep 05, 2024 at 01:03:53PM -0300, Jason Gunthorpe wrote:
> > > > On Tue, Aug 27, 2024 at 09:59:43AM -0700, Nicolin Chen wrote:
> > > > > Introduce a pair of new ioctls to set/unset a per-viommu virtual device id
> > > > > that should be linked to a physical device id via an idev pointer.
> > > > 
> > > > Given some of the other discussions around CC I suspect we should
> > > > rename these to 'create/destroy virtual device' with an eye that
> > > > eventually they would be extended like other ops with per-CC platform
> > > > data.
> > > > 
> > > > ie this would be the interface to tell the CC trusted world that a
> > > > secure device is being added to a VM with some additional flags..
> > > > 
> > > > Right now it only conveys the vRID parameter of the virtual device
> > > > being created.
> > > >
> > > > A following question is if these objects should have their own IDs in
> > > > the iommufd space too, and then unset is not unset but just a normal
> > > > destroy object. If so then the thing you put in the ids xarray would
> > > > also just be a normal object struct.
> > 
> > I found that adding it as a new object makes things a lot of easier
> > since a vdevice can take refcounts of both viommu and idev. So both
> > destroy() callbacks wouldn't be bothered.
> > 
> > While confirming if I am missing something from the review comments,
> > I am not quite sure what is "the thing you put in the ids xarray"..
> > I only added a vRID xarray per viommu, yet that doesn't seem to be
> > able to merge into the normal object struct. Mind elaborating?
> 
> I would think to point the vRID xarray directly to the new iommufd
> vdevice object

Oh, I think I already have that then:
ictx->xarray: objIds <-> { IOAS|HWPT|VIOMMU|VDEVICE|.. }->objs
viommu->xarray: vRids <-> { VDEVICE } pointers

Thanks
Nicolin

