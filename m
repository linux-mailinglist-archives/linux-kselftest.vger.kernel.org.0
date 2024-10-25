Return-Path: <linux-kselftest+bounces-20603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8B99AF84C
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 05:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D1BBB214FA
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 03:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DE618C01F;
	Fri, 25 Oct 2024 03:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c48m7iJk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7447F18BC30;
	Fri, 25 Oct 2024 03:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729827599; cv=fail; b=Ehrh7JzqwOn+ALLWHb3zm1FuFaa3ovpqsIchj7fg27vUsLRPhqkjhbYoJbtXFLwRyd0ozsYGoXYcTiMc1un7tUsW86HvVtgBGmWFMO6BZSo4ydmbBFfEyoFKPuij6ZY8qnBZll/qGFYD9iY0fTtQqgum8Fq3eXtBrtpvi0SIa5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729827599; c=relaxed/simple;
	bh=MQiUqUnSoQHyi5HjMEsi2TOcXNKzXSKYQTY85UR+x98=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUuR4kka80jTC8wJNRGk0zXS/YhR3Nm47LgjhcvQitO4O4GSpysdMNJwRVk7eP6Bc+6uW7MJNpvvJXeg5kNAJVSHxmonJW4Z1zKyRqk5Ym0bopHtA1u2ON5ZGniJqOmZLY/oQCpVbFXYSOM1W/VtVqIJwd2q0y68LVKbc4NOZ4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c48m7iJk; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3avpoMbImPQNtYnR8G/L2xJcyVMu/qo9npAWzeyB/sBI8ZXQZ3CvIK6nBr1MCsLdK1UXUNHH5SXaKSffKeSPJh70dPFiXjJU+c6WZPl1sHOOIXpF0Q8xlhHKYLt/3djeEAxZqOOEOt4IApgmiJRH3hSIV7H9j5GEZ0py5Gfdiyfik7T+qE+Lr1bFQjbJa2h4sagTKCWRDFfWTi6rsRAonIPr6DP7xZ+arTTQJwRLTQ9IABcnn67kHB2YkgogbR5VeRJwPvgw2pm77QN33g4Ig3s9uxso9LbF2BG7ExLsXX2owjM4KNjlu2tFG1Etvc60vehffNqiY9DE/9Na1SyAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/c147P0IZLSkfgkga72naJX72VTGe00ZOJAM0Gn/fsQ=;
 b=FOrdTQeoIv7RIxCRaHSAPxJNrILp/Ugwsyk1vQMhV3Oldnc76ZDErouPQ9R/mVYEjEWsOHXSbZ0LG0RqVZhvzqVGsf1egoRdZwV2JZkvNP0ujUVTwHRrCJx2mGRiGwovkrWkvPh74IrwIDEUBQ7e/1JhsEDcRbThQ3nMgRzhwrMlpESY7emDDgpgwTxWvae7qEpbGVk9kNx+x5dGKw6FuURUYeSk7z1s2zbgXbIhHKo0PzP6CyKMElQhkvuSlJ7yky9NIXQ4swliCFeXfePZeJhAxMHu3Cz9qZcLPgxMAivbiuR0BttjKKi7fP20TU3U0eyljW5tbnXafFwwsLWUiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/c147P0IZLSkfgkga72naJX72VTGe00ZOJAM0Gn/fsQ=;
 b=c48m7iJkhIOUqB6a0KQUuEBVR6m8isQce4i29Tp3KY8VaJcrzV5c0adViDMI59eLfy20gSSuOm71cdowkoXj3Bo9QwcxZnaukXyX2JdPEx8Aym7cgm+KtXqv24LLT9WLgJ3A0RyV1LtBzBoBNkuNvz9Tj+4qFxk6iY7raAw7g7n5uzO9EkRoKMxexmkLWPQHHxjb/Xaw89hDSX6cMmKxSk5D+K8FccDLZlj7ZWVKj0XbjdzUOPk5t/8SO9DFFpgdWlILDwYLpqbnxv3F+bi3veF2hRYIljJdA/DKQdPfwyQM+lGxS8fvBTJQRaKipS6+fci/nZKLw6U2adz63pS15A==
Received: from BL1PR13CA0145.namprd13.prod.outlook.com (2603:10b6:208:2bb::30)
 by SA1PR12MB7223.namprd12.prod.outlook.com (2603:10b6:806:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Fri, 25 Oct
 2024 03:39:52 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:208:2bb:cafe::74) by BL1PR13CA0145.outlook.office365.com
 (2603:10b6:208:2bb::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.8 via Frontend
 Transport; Fri, 25 Oct 2024 03:39:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 03:39:52 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 20:39:47 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 24 Oct 2024 20:39:46 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 24 Oct 2024 20:39:45 -0700
Date: Thu, 24 Oct 2024 20:39:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH v4 08/14] iommufd/viommu: Add vdev_to_dev helper
Message-ID: <ZxsTAANTTuQzQ9HR@Asurada-Nvidia>
References: <cover.1729555967.git.nicolinc@nvidia.com>
 <3eae567a6d674cae144c5fd36cc8eafe84d6a24d.1729555967.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3eae567a6d674cae144c5fd36cc8eafe84d6a24d.1729555967.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|SA1PR12MB7223:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b966a1-f103-448a-2f29-08dcf4a6af73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dX+1x6Q/DcQCD1HkR/OdRBDEgIiY5s8mflE5smHzXiwfE0GjAtqYFXBvb6B9?=
 =?us-ascii?Q?p26S9OXi22vBcgfdIBWv+TKzOauioqV/kZZRd7hoBEw+BWQHyLrHhRhUwG1s?=
 =?us-ascii?Q?K8t6dYnczXE0F8/5WZPkzP4+M2Q43qUiynXvpusg88k0p2fwVZPzbKHucVGG?=
 =?us-ascii?Q?tOniNnWF9zKXYJQQwojy61W5btc7sL/6ySV3q0FfPgbhsqGLJokb8PQEhzHy?=
 =?us-ascii?Q?S7gVpH/wiFCLcBL7ES0AtwyRL9ZsRbBLo8oRla95xTf9AmgHOPA0qOnj7YZc?=
 =?us-ascii?Q?TujNGnl4hWlWsyJiNx86pvYQXAZnI5xN5+BZ7Pp0OdvmZJ6OeCtDVhh1eP0N?=
 =?us-ascii?Q?Ku9LukBbpStEDZPsABH0mcN1fvqYtZIxe5i+KtH8FRg0I7ChNTDH9j4TVKvE?=
 =?us-ascii?Q?KK7F8dAhkN8si1t2+okYiI+C/3jjmS8wx3KnTM0YcVX7LTxyhGMSr2c/u2xA?=
 =?us-ascii?Q?NV6DMaTR54BrLzMt3qgCH70sN5k4hnleEb/6fU6wGf/04hPT10oIB5PK+cVb?=
 =?us-ascii?Q?Jy6id1GhRUg6bRGdOJK/gyB2eAeHnuGC/NKE1JFGKhBDbn3oSgmrGeKW0uAL?=
 =?us-ascii?Q?3UI9TEw7qZimEEukDd2Cl0RXOcrPArTQWcBpcOMer9kXxEg7ilGHq+LAKWF1?=
 =?us-ascii?Q?ztXTqLlpV/o1wDQCjP9bIWg9v624SCAek85V3qHuOADBt8m3B/NBSRiew/j7?=
 =?us-ascii?Q?m/JRwQpvK+4/pRUMWa/DUYDn6F/z3PWDsFK33tqEH2Bh7SSyK/rypR+gC8ag?=
 =?us-ascii?Q?bb1pp75+q/Gc0Ts7gQr/wi18MMxY23q6PdRj9WQzCe/jVxPqzAf0S1NdR6+X?=
 =?us-ascii?Q?0cT5hY1jmz/7611PKovyGKzLeYQqJmzrglO+VoHqGC4WdJwDoa4AJ39kEgjk?=
 =?us-ascii?Q?pYbprmkByz5oHfHl8adC1D0tHDaB3jHcoypgvoIOZRJ1oJzvREBNUZcaZyaE?=
 =?us-ascii?Q?2GHCJWyvzBezxiO74Fu8OIHvPIdKVuFi1poSx4oyYmG+y39SyzPd5BDkUREG?=
 =?us-ascii?Q?RAsJduDB/7BAZBvqq1c9NvG5RjcXE8VZgeMpyomf270Nvj0tnzft7VOBCm3u?=
 =?us-ascii?Q?yTpx1eT9aq/A0WsGN8sexcLoamEBJMu6LG65mTiRV2JXO6EZxUz23tlQ+WZ1?=
 =?us-ascii?Q?8bjX8CToq95djiehgENi0vWXqebZp8VcuJQb1z/Cs0NoE94Rjzgp0tLaPb6t?=
 =?us-ascii?Q?y+etPeDOyz8z2e8wj1gh50Ewq9ev4L3ea7iUJ+d+8/JKa8kd6C0Abq9uIOp2?=
 =?us-ascii?Q?ldmr3xiQyRb0LIJIO/EZCj8s1Mq8PbyqRvyP9bEhJ7oLOA2RRh5A1yB2qQA9?=
 =?us-ascii?Q?+vMAHYX9w4FvmWOWGwn+TPhk+3rtHEOf4BfQRP9mPDTbE9dWcelhoWsZxF/M?=
 =?us-ascii?Q?Su4ywdXN9M1A+lR75hAAN1kq5r9XdEXsuErpku5+6CY7jHmAyw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 03:39:52.3202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b966a1-f103-448a-2f29-08dcf4a6af73
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7223

On Mon, Oct 21, 2024 at 05:20:17PM -0700, Nicolin Chen wrote:
> +/* Caller should xa_lock(&viommu->vdevs) to protect the return value */
> +struct device *vdev_to_dev(struct iommufd_vdevice *vdev)
> +{
> +       return vdev ? vdev->idev->dev : NULL;
> +}
> +EXPORT_SYMBOL_NS_GPL(vdev_to_dev, IOMMUFD);

Changing to not exposing the iommufd_vdevice structure, I reworked
this helper to a vIOMMU-based one:

+/* Caller should xa_lock(&viommu->vdevs) to protect the return value */
+struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
+                                      unsigned long vdev_id)
+{
+       struct iommufd_vdevice *vdev;
+
+       lockdep_is_held(&viommu->vdevs.xa_lock);
+
+       vdev = xa_load(&viommu->vdevs, vdev_id);
+       return vdev ? vdev->idev->dev : NULL;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_viommu_find_dev, IOMMUFD);

Nicolin

