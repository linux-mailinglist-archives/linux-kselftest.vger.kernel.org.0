Return-Path: <linux-kselftest+bounces-43214-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6573BBDFD4B
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 19:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16CB7405884
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 17:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750472DFF18;
	Wed, 15 Oct 2025 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s2qluxEQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010048.outbound.protection.outlook.com [52.101.85.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9A321B9F5;
	Wed, 15 Oct 2025 17:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760548857; cv=fail; b=RNdxbiKjZ70sMhXCi2Rcd4u1fmWXPAM1GHoQ5W3qQH8JerdOi5mnzmcEQeY/JUENAuT5Iu6Luqqn7pXSrkyFgoXlAnlS/JmujCKy+VWRmmYxR2SsD8gqLZgpnJmU7SqvFk3lk7JXWRpOzCVni0yBFRTiC2VNBRsK8hRuAy0zGn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760548857; c=relaxed/simple;
	bh=6JUf6fPPyJvP5WDbuh+nzHwU0WlRMJbW7w27knrWmu8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRZHJeOK+kUDc0+rHU2UaJKWJccyLrCw1Gosl4K7RV7A0n9Z3/th8PLH2xIn1Bg4D7FIbDWMtLheKDQ5NXIuSiUlWU2N6fedjMELuSpCjDPPg7cHaeGV23qNCRIT/wvDu1a/mOYlulIaXZg9uhpP10etoFuFas094X78PVAMZR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s2qluxEQ; arc=fail smtp.client-ip=52.101.85.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPadPEwNuMoswH7drpp3bcus2IRUZ41/LoAQp4470v4UwnSKojxc37EtE74gdxu/GAgufOOwj1Bgbvnv6Fur0uctTD6EXxWblE7Fo9aaT6CVE0UeI/xaHKC6kZ24//6jld6YyBrG2umA7EqcR7h0GJ/YsgVNhk/W9QI6aYyXgLWTCfFOGrcv0htKhXe7JE8StD1bMgGK34pUWwZ1xjy62xtfFJtfjgSkfvb/5YNYWsHKAMiq4YF4cyaOpZVXuDPMYanWbIYzMrpgiI1P/NG/VXuYCTHk2IDjRwQhOoJfftxIePznFCEO6hSQRhoVG6ZtTxQXnBLSKkZ1R64eAOy2pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zx0LZKQethjKG3IoBB5VjmqLgNO/SGp0XVR5NtYaioo=;
 b=dsRcWOXeKPWBDe/YWm1mY655Lt7NFWYATopedFsG0Jr8lwgxFCMyTalG+JFJVHHNVJj2r4EHLE+Mbp3ppWl0ebkW0rGpiqFPjbJ0hrUHiuifE2taLNYVjA2McBYfOLBGg1Up+TzwvU8/MvnE2qinAMNjCUjs91xyMP8tDXFG6fsVB5fHPDgnLJDcBiKD1eCAW7zCmZbtEDyEZhdVPUWPeOvWGfB18wtcTjgr/d8CoBcl2sdbLMl3XkWe572zaftM8Y3Kou/gFySPMq2S4um4XjQStjxxfU8/Ct14VieTJh7rE/ePi2rlF8Y3KA+trjZ8UfqAaPR85bAXBo74CJJARQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zx0LZKQethjKG3IoBB5VjmqLgNO/SGp0XVR5NtYaioo=;
 b=s2qluxEQdMZ/CkAYSZlfl88etGxc/0UFe9NAcZhhDrYTiZc/cGRYDDckKWO4Bn09o8/3mEtL9HGe1OiWs044sPo4EHvBMsw11Nb0Il++SwjWi/TUx754nwDYGifp3c+5aGghZe3H8AsCWjnNht7+hWADeNYMBKu00o+JVpnIY61Ih+dioVaD4BFeXQEup/0kZnM9nsjVlhqVR5i8sI30jG8wXS6rrWj26nIBRCx7N4QVzsMhTZqVKVeicFtoD7laVuOhMSkOpcwd0FHoqJuOmTPXiOfLUCIPkZjBqwVLVc/QyqWRR6DPrY3lyQ0M0tLIJPQUStFlCzmULTaSkwpFTA==
Received: from SJ0P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::26)
 by SN7PR12MB8771.namprd12.prod.outlook.com (2603:10b6:806:32a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Wed, 15 Oct
 2025 17:20:53 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::f3) by SJ0P220CA0020.outlook.office365.com
 (2603:10b6:a03:41b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Wed,
 15 Oct 2025 17:20:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 17:20:52 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Wed, 15 Oct
 2025 10:20:33 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Oct
 2025 10:20:33 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 10:20:29 -0700
Date: Wed, 15 Oct 2025 10:20:28 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <shyamsaini@linux.microsoft.com>
Subject: Re: [PATCH v2 4/7] iommufd: Add IOMMU_OPTION_SW_MSI_START/SIZE ioctls
Message-ID: <aO/X3EwzRLOj0IL1@Asurada-Nvidia>
References: <cover.1760487869.git.nicolinc@nvidia.com>
 <6c36de14b00a3f06df3a602f18baf6b51fde429f.1760487869.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6c36de14b00a3f06df3a602f18baf6b51fde429f.1760487869.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|SN7PR12MB8771:EE_
X-MS-Office365-Filtering-Correlation-Id: f6aa206a-2d43-4846-f444-08de0c0f319d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2lhKNiqpuWM8BNGdj88jnT9UXAGM3OTDNaSoue/nwhCHqn0buQQdykZiZqx9?=
 =?us-ascii?Q?SRD0liazD0CKkhHndVPNlv/bYBeSeoghF/51iLKJUYR4r7bajKn4CPgihOHA?=
 =?us-ascii?Q?l/rAvR3cykFKlp5BH2keig0rtMB4eoyoD3ZJq8NfXB+7R9eKIZEkyjNiCv+Z?=
 =?us-ascii?Q?5j+pE7nMdphju3MvVdYAlbdnESuUHj1lEEhfEJwQngxa2JbXTI7UQGNlRg2b?=
 =?us-ascii?Q?TMmhYIZI2X/HumcUhQDpcdL5i4NtS8ynyGR/ANl1Qu2PHNHsJiUGSTZ9iI4j?=
 =?us-ascii?Q?7ZvE+p6P+vkaZoPaGfX8wsFElwaVHuXqF0IDXw3U6SlOaEB6yniY3tID6G4Q?=
 =?us-ascii?Q?A5bYyQpbtcENjflTFKFWs2vE1ACHfzZxoYi8mkWFxGL20TYlpOOIOwkfHj+Y?=
 =?us-ascii?Q?Zub2SMWns79Ee5we8QGqpK13LR/O2lqHiGZbvQc3gzcItMRNQjlW8mm/rEvL?=
 =?us-ascii?Q?pWLUc5lkgYpx8TbIXRqIKY+kSAs0jHI0MKEHQ1T07i5BO0/h3Gg1h/jlBa83?=
 =?us-ascii?Q?t6K8e1Ur1eSlRFUWAxm+c8oK0BXgldC6AMqG0BUbEYNMgjd8Is1XNRen0wgh?=
 =?us-ascii?Q?DpC4npNAcur9NvV/OO1iJnNhKf2y45TzlOjATpYpOmf4cMmIrBcbUjsm8vXx?=
 =?us-ascii?Q?HGDIWBV9WpR7iYpmSrQalp7yEno9HZJjWxRMAJwHxg676azu2StfRGr5fW1v?=
 =?us-ascii?Q?roG+ab7zcro4d/JcF8rIFlg4AQ9UdBAPl2WdnRT41U84NeA60RRABMm3DNSw?=
 =?us-ascii?Q?K6BTfX0j+nl1bvelcAxJtNmgpoNk0Vi3vhlx7R9YicpbOhp1chL6NMiIgQfx?=
 =?us-ascii?Q?Lv0QdEyuMcri2W3g8sNA+1kbh7c8KxrWz/V8B8k5gyDdK8CYJKLJsjYzaj9s?=
 =?us-ascii?Q?ythWJbGfu81YIlUr21SqvAg7ri0Nuy5XeZqQBMW9odrOLOCQBsxytVP6SUhz?=
 =?us-ascii?Q?2Jqk9L+w6JK6AkXHxoBdad9ql6arwWQmktb8tKbv138KtQGaytaVlMGJsix0?=
 =?us-ascii?Q?9WXzIAwarw7I1T8jgxePJWchTBZM2W4b93WUTgYZhnDKdyzjoK+ADP0AvEFM?=
 =?us-ascii?Q?oM1SjoBuJtirqTzEuaB7Ez/dV5zsb8HpifVsHgNuCsn3mq1C9pOMa0MY74Af?=
 =?us-ascii?Q?TswW4oEhEK3gIrwmiIMKGuM1m7IXGJAwKDgDS7T3swfs/vCiUGSFdCtT/NL2?=
 =?us-ascii?Q?QGr0x2eQunOyNIpiuc/kH4hJncDj/lgs+F9WSyXNTPYC+GzFAP+RPA7fJBZT?=
 =?us-ascii?Q?a3QllElI2CJUYQfApOBNNIAeCk7KcBMWKs7Zf9ett2oZiyD6Ngcd/cMhJ3/P?=
 =?us-ascii?Q?iW66ujH3uMBBhep5iop32pvI4LUpwnqRshKCNFiZ+pwcTQ7NGdVOJPsuSKWy?=
 =?us-ascii?Q?SVndKvVev6R2Jil2czIGVhGc/KW2zHHXT7yWC3UP1veKUSVPZl+L8OeoHV3+?=
 =?us-ascii?Q?fAdeKrKIdX4qr/req3kIkUL2ht/i4g5avRSJF0G3gAkoZBTRd4+DA562mvXS?=
 =?us-ascii?Q?ZNqs85buv+vWi1QbRAFdUghrXom05cW5ERUIpAgxH3H9Zz0CCZhpxp23adjN?=
 =?us-ascii?Q?mswfzEMmJrmTcpR5pu0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 17:20:52.9319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6aa206a-2d43-4846-f444-08de0c0f319d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8771

On Tue, Oct 14, 2025 at 05:29:36PM -0700, Nicolin Chen wrote:
> @@ -1458,18 +1458,27 @@ int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
>  	iommu_get_resv_regions(dev, &resv_regions);
>  
>  	list_for_each_entry(resv, &resv_regions, list) {
> +		unsigned long start = PHYS_ADDR_MAX, last = 0;

kernel test robot complained. It should be:
		phys_addr_t start = PHYS_ADDR_MAX, last = 0;

Will fix in next version.

Thanks
Nicolin

