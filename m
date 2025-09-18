Return-Path: <linux-kselftest+bounces-41802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7659BB82F19
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 07:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3114B3A7378
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 05:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859A4242D8C;
	Thu, 18 Sep 2025 05:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WOJQYG1V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010002.outbound.protection.outlook.com [40.93.198.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F3034BA43
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 05:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758172082; cv=fail; b=YzLGxoBlcA5Y17cKncHSMwy0dRPgmeNF32So60KWqIYrMy/7uUarIbEydWNDXGZi8C51CUYWDOVW0xL+Usq19yiEnxZcejL7qOAlB8wRcPDInKzSz2iSfeDZRZL4pZXjnzFTP50IVWo28+yEobAcjSKbAZT6nne36HlS+hiIKnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758172082; c=relaxed/simple;
	bh=r5bNBvzKBTkIpQ6TZ1cCk2cdjQEP0Ymcca6MTMyuMuM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpyuLF1DH+itIGBA4wB+6ckZoVOzz9ToUIUqqSPGSaru3ui3pgmK5fBWK0ng/P1oWrG7VDm5G5ZIyn/ScJkrDFr9AFFGCLgeVks2vdZrEaSmZRXXYLo4EyOtVUFzadIsGyMKuNwn7HoYYsC+ioujrqGwVZI//qLGrL2gtL3Ry1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WOJQYG1V; arc=fail smtp.client-ip=40.93.198.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lb2uKUfnS3C9EwAumbOzZaLRhlbZ9NKVRCKYJ4f1pB2mCtfFggp8U610L52HC+uSf1aH+zorj1v6nvXpfaS21m9lcP8yWin6BzCuggtvaRJLU/iDnTi9O74HtPNjQBlTepSQBAMhn05ypH2lLdNkQkFcEzmyZlAw15AEWxY1S3DGL4GF4mcZBgEcwgjATluMwCoM7SRaAcYMgnwuzMleoOkfASCWS/QXK4T7nbF5RRDdho7E8C+2PgDZYC9ayzVWYfiyXleEWjyIKROmsTcHDHHBAs2+jxPUcXPwjGb4pzy38xHsmKpEs6IEB8OYkVL/ZX2miDoFwMBT5LWHKwp4CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYapbWjkp7+/2/LaR/0oh1/2U8/MapQ9OEL7YyKMHJc=;
 b=cFFJ7MoVrp5v9rkqUaetI5m5dZxj+FeOEUPSgbiVrHwTl3sVezXLVrRzjd9XSssM/H4NZHpHOTUAkVDKmbMI1cV8e+0+HU/rKhjOIaSCDHCsHz/OwUf+LYBnxYFtXwXjW4wGkdHI8hvIrGuO68vPCYTEM0zavtJzAr9CWVeBIIEXRQgVUENT+yw1Hl19AFJnK3fejRVCVWUenJnCfBaL8WW6jGmFzITlqpz6bub8Lu48gC14F9+U+wEyc+9tyCSSouC98iv7lCU30rHEAo/RnSscdQ16WYBxBIQgPY6XMKWQfyIiyQIvv9Dq1zdu/RbPUuKI79qtPqNwE/0fxWgXfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYapbWjkp7+/2/LaR/0oh1/2U8/MapQ9OEL7YyKMHJc=;
 b=WOJQYG1Vb3xaMFy3TvmFYvidfkUeCjC1RmpHWtxGqhgrR/bSdvuyOuIbs1CLZwWqUJ4xgR2Kqw1O3/XQsHGQwjo7J13LI4383x+08aqroNsibjvJjVyeTE83GSA39ebSBbZKtqHz1qqm7KQXqopVI8w3KBq9dqUOIeXGkctAPTx4s+owTAQ6aOIP3R3oyqLb2+fZ1KTjotXOocgL2RDKyoDUdfspMzv1Po0YAXpd49SpvQOc1NscIsGiVVoA6LygOy6i3ZQ6hne2ihGBD8idc8xaw/Z9UdJBxUq2auaFvmK5+XzqRZgdkE/8mNTFTFcuNha++iImF2HvafkFPYImzA==
Received: from CH2PR02CA0007.namprd02.prod.outlook.com (2603:10b6:610:4e::17)
 by CH3PR12MB8186.namprd12.prod.outlook.com (2603:10b6:610:129::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Thu, 18 Sep
 2025 05:07:54 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::25) by CH2PR02CA0007.outlook.office365.com
 (2603:10b6:610:4e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 05:07:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 05:07:54 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 17 Sep
 2025 22:07:41 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 17 Sep
 2025 22:07:40 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 17 Sep 2025 22:07:40 -0700
Date: Wed, 17 Sep 2025 22:07:38 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Kevin Tian
	<kevin.tian@intel.com>, <linux-kselftest@vger.kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, Will Deacon
	<will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	<patches@lists.linux.dev>,
	<syzbot+80620e2d0d0a33b09f93@syzkaller.appspotmail.com>
Subject: Re: [PATCH 1/3] iommufd: Fix race during abort for file descriptors
Message-ID: <aMuTmuBKd9aU7ngO@Asurada-Nvidia>
References: <0-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
 <1-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|CH3PR12MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: 818f5c02-647c-42a6-cdd7-08ddf6715337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ppN3DSyUCD1nyG9DKxzqLU8Z3Kpf3Ux17RJ+7lqZYhKaNOpsQ1SotdcxQJEh?=
 =?us-ascii?Q?v5GGEq8AxaF3xQSKrg26EPr6lEc2iect0OlHI1eX1prMxccH22Pan63/JrKd?=
 =?us-ascii?Q?Z7fpNcVpFHP5IdoNlwJIlcaMx3oZ5njSAyKvAgruZvf2O6Rwxz4qZTIjELTw?=
 =?us-ascii?Q?3aSf2+CdW560GNjm2lKTMfHugsgIaxs+XOvBowy8bpqkz6e+ZyMTf4fMSo1M?=
 =?us-ascii?Q?nhLbRnz+40EjW4OZrIS41TMmWWTMbm/HgHQBED/uUPlKMTGI02HnzuMoms+D?=
 =?us-ascii?Q?4sGnvjjEQVKo1wRbmupNrpcanHAdUDEBz0dHcjIIPqiFCzlXvIxk47q3E2xV?=
 =?us-ascii?Q?5/gpSROHDS5LzoYIfXF1u0qGC7H6S+BLmPMXJNACFTD0+qNEo7WVbi1n22Uo?=
 =?us-ascii?Q?hkIgUmdHk5JF8xiknnE2xTQOtS6tddwFW4mZuhAhUet7cS20xKSoK83pobDE?=
 =?us-ascii?Q?rIh2Hs+IdDrONIT8CFKOENAPFlaNyA4jmBBX9vCDNP0sv0JgRUnmawPEGHnY?=
 =?us-ascii?Q?saryD4fAkZ/qlY38m3s5/P3zTwfUJBGGuZHG7sTiIJXYt8Qj8a8Ns5ka1Vvf?=
 =?us-ascii?Q?3sjosgFC1ZvCd5DyQFgpZOsA5tUAx5xKKDnsKBgzdVAWEs/Wv+GjR3icDjUa?=
 =?us-ascii?Q?DHSjzN+U5fvDkMGoTS7+9RkDqDO8oPWk7E1pGaTZmCeVrRlXIdWxyNxJ5x9C?=
 =?us-ascii?Q?zPJj2b+QifwVD2CrCkWvuY3XgMGdNOa/7Do7BtTUsT94gDNs0d17pkwbq4cq?=
 =?us-ascii?Q?XzE2ps61sAStlj/22gfMUshNjqCSe08CAXT7v5oWT1Wi0iqB4IlRmgw9wEZo?=
 =?us-ascii?Q?m8hXyzC3BSyXa1cV+XPJO3SIjsV/mk7GQ+CU/2hgLPNGl+KFeF5ehIC80Gh+?=
 =?us-ascii?Q?fxboDq2poaILZkHz8pgv6IpPZnBuxycjiGeM1EGvAf+8wlUoEb40dELX0MDC?=
 =?us-ascii?Q?vs6c0OuiMjDDYHvCmomdMepiCaNKqp37EJ3gIhSlaXbOfkQ1sA694CxfCuD/?=
 =?us-ascii?Q?cScJyvkeuQz35ebwy5WRBJui8tasjzbH8pPHJVIMbjXxo2dnWhqGgvDIk4L0?=
 =?us-ascii?Q?AEW+tc0SjJqguBLFt+qMrEGNBGtvE7EbfpA7w9Pc0rasCFjdH1Amniwv3DsQ?=
 =?us-ascii?Q?EUd7fovgoMaH57SRDC12ANY8t41/w7KiMsTGqUHtNOQIvEPtf1QIuhplPzBg?=
 =?us-ascii?Q?sIJAjUeRV09KjwESscndMeB4xZwP3T4vaDY1nki5nLStUt5zgiabumxIvXT2?=
 =?us-ascii?Q?GP1lZ4rBP6LTUzTeA0XrnydCsaKSjo93ld310aVB2vXumCIrrBphBl2jBP89?=
 =?us-ascii?Q?Os1nz0MhKJOmbstHoz1YHhLO7c63C/5gCoIfosm/E45EHtUO54mluL6ZgUZu?=
 =?us-ascii?Q?0C3bTvX8/yriWBsCr5S6Y4SLKWO0KiPb/juLFS0ZXTuR+tLgsRYRRKcus7L9?=
 =?us-ascii?Q?Bs8jIVatZQJCBPVd9CMGAJD/eHbWd6ryAtmCxZ9/NI5j+jUgzwdH1Xd1tw4k?=
 =?us-ascii?Q?jADu0FPzY8Znu1eLde3lKIe6nzSgXiSfTuZd?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 05:07:54.2883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 818f5c02-647c-42a6-cdd7-08ddf6715337
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8186

On Wed, Sep 17, 2025 at 05:01:47PM -0300, Jason Gunthorpe wrote:
> Fix this by putting the core code in charge of the file lifetime, and call
> __fput_sync() during abort to ensure that release() is called before
> kfree. __fput_sync() is a bit too tricky to open code in all the object
> implementations

Mind elaborating this "too tricky"? I thought that we're supposed
to use __fput_sync(), instead of fput(), in the alloc function in
the first place?

> Cc: stable@vger.kernel.org
> Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
> Reported-by: syzbot+80620e2d0d0a33b09f93@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/r/68c8583d.050a0220.2ff435.03a2.GAE@google.com
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

The patch looks good to me though:

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

> @@ -131,10 +132,30 @@ void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj)
>  void iommufd_object_abort_and_destroy(struct iommufd_ctx *ictx,
>  				      struct iommufd_object *obj)
>  {
> -	if (iommufd_object_ops[obj->type].abort)
> -		iommufd_object_ops[obj->type].abort(obj);
> +	const struct iommufd_object_ops *ops = &iommufd_object_ops[obj->type];
> +
> +	if (ops->file_offset) {
> +		struct file **filep = ((void *)obj) + ops->file_offset;
> +
> +		/*
> +		 * files should hold a users refcount while the file is open and
> +		 * put it back in their release. They should hold a pointer to
> +		 * obj in their private data. Normal fput() is deferred to a

Nit: there is only one file_offset per obj, so it should be "file"
and "it/its"?

> +		 * workqueue and can get out of order with the following
> +		 * kfree(obj). Using the sync version ensures the release
> +		 * happens immediately. During abort we require the file
> +		 * refcount is one at this point - meaning the object alloc
> +		 * function cannot do anything to allow another thread to take a
> +		 * refcount prior to a guaranteed success.
> +		 */

Thanks
Nicolin

