Return-Path: <linux-kselftest+bounces-35805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BF5AE9190
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 01:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41F881C238B0
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 23:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DA72882AF;
	Wed, 25 Jun 2025 23:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eusxB6Kr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EAE1DE3A4;
	Wed, 25 Jun 2025 23:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750892816; cv=fail; b=gjeOzXoHr7Ou8nEAq64V8mV/MTbu8pwZQywb5iYdfTUID3lUfmkwYMLXkMc7TnqoMAV/AmJ+Fz7Qhx+2hFtYOzKbhqHQ8dg6JM4vCu9g/ssdln/BwQ675BuePFKhzssyI406FKemNXw9KX4m6vdBqQJwhpKNVSuMEkLimuD08+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750892816; c=relaxed/simple;
	bh=h3AiQMbsqUS49429qO7WisZ5+uqsoLroJzjEsMkQPe8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/KOCIW+WnngQ69xDC8aUEUPwEew0F8/L9+gg9nxNunemafALkyDoGNP+7TKRlKDEtAECf5xMllBYFN5OynxSnveWgdZTlfuW2NraGidSbyzi9XkKXF6OPGKbFUWwTsRNTH0KfRiOeIn10VmcGWH46QcmwLhWc1BiGCjiVICQhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eusxB6Kr; arc=fail smtp.client-ip=40.107.237.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdfneLGnE/ZIAURwg9G75sraJtRIPhnMmrv3xIVYtxqURGptP5KAQZJl2aVLBOTQrhaqm+hX3nKy6R66egOVn8OG73Vwj+gYwj4iUpuFn+PnltM2tsRFbG0EMCu7ipcPs6vryJ8Vg3pnimD7vjqE0fXMK7AqgysbhG0m7qmEtmmKU84c/8FtPteSgJOwvxq/8Dznr1ysd2IeteGPIxd1ybZOon9x3fb6+fIirlZoT4VnzeR7P4q7g3mNY9hzVfrdLOpQv/CD+vFeG4P/T8cNNqz/wq/k0WkRADUUqZWyYNvH8jkzclAqp5tBMy+gRzv/5wY6tM7YbPWUBNRla+06ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phh4OKodGMYsUpPWJQe7GkTpUyN1Fr6QxceJrdgSRY4=;
 b=Px7RgKqjF3mFK+rdFbtvZwPBw8wOIL6QceDudz/RhK12w517+gCMMdlK7JWYE8dLqcr7fwh1E8AMZrwXUdTiCqmoOd8tGy2h92MYy/tpi7WCayj+qlBk4UpcLfIZjVtkxo28I0ssPgpgbecaOrfOS+a+3m9X5hII3R5D6laadPXUpWIocIKD3e+yog4q1oNq/odQnG1Impo9OpTDaqIHIYNzbRitWUCkaBKz0f+zreGWZ0URy4Of4bT6Ikl0bUIRiVXcz19vCp/RChsxUiUAgNP5pgxy17At4lM/xNvgADol/geKb3eSebMHdLBoqkNVxBkoCdBm/9i0YqI8Mxl3Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phh4OKodGMYsUpPWJQe7GkTpUyN1Fr6QxceJrdgSRY4=;
 b=eusxB6KrZvg1s5XMKSPvVM1iDfuY2gdjXmrktxAKex+F8YnpWcoVYFw8dL3fTv88PCgoNAFXO3lr4Z8ib7p+C89GQHenzUTWspw9bPF/mJ1BI0nltfAfbbnrNahQctVz1pR/8eYbK/RlQjavTm3zKO9DgaQkSKsvjr2Jwa+1Wv8B0DkLYHoiTpOjuRmGjwg0Ma3R13bYWuxCEvKFPp+iLm2ePyFlOCjMbu9BZs4Byy4MN6YyVLzbgkqp3OD8EhGIzkrJPvfsfjXsH0XQiykTYpHVYWVgwEFSqi8tTOH88yuLQ6sf8SNWM2RgNBTLArNbNSTI5KHH5y8uKr/hpMNHcA==
Received: from BL0PR05CA0013.namprd05.prod.outlook.com (2603:10b6:208:91::23)
 by SA5PPF9BB0D8619.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Wed, 25 Jun
 2025 23:06:49 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:208:91:cafe::13) by BL0PR05CA0013.outlook.office365.com
 (2603:10b6:208:91::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.18 via Frontend Transport; Wed,
 25 Jun 2025 23:06:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 23:06:49 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 25 Jun
 2025 16:06:32 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 25 Jun
 2025 16:06:30 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 25 Jun 2025 16:06:29 -0700
Date: Wed, 25 Jun 2025 16:06:27 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "bagasdotme@gmail.com"
	<bagasdotme@gmail.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"nathan@kernel.org" <nathan@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"mshavit@google.com" <mshavit@google.com>, "praan@google.com"
	<praan@google.com>, "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v6 10/25] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
Message-ID: <aFyA881sUUjxHCFh@Asurada-Nvidia>
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <7dfb002613f224f57a069d27e7bf2b306b0a5ba0.1749884998.git.nicolinc@nvidia.com>
 <BN9PR11MB52763496C4A0066A77FED5B48C7BA@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52763496C4A0066A77FED5B48C7BA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|SA5PPF9BB0D8619:EE_
X-MS-Office365-Filtering-Correlation-Id: cb8a59f8-8666-4583-07f8-08ddb43cf73e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8auYxNS8Bpirza8fm/OjFSPFNimFwtKg3TdooQhsPgbV4iE+/SiHu5c29Qvg?=
 =?us-ascii?Q?JBK3o1tBkoUptpRIoeVaEI/OciGqjiz124VwkRetgLeJQmz8UN6aO6e0KYLb?=
 =?us-ascii?Q?XvHliY6RjpqlUx4zgRA9ETF9c0InFCyCvEoOcT9SLYInAAD91q9uaxsBa8tk?=
 =?us-ascii?Q?sSPYj0YyW/6YuREzRt2z9K7qMGCskvMd6Z1NDqJVKxSuA9rXu+VA0kPdVkGU?=
 =?us-ascii?Q?JEeYldJv92LoGuY9dCsx1xnhbm0jEcgKdfF7nFcevuH5ECcwCdVNENpcmzEC?=
 =?us-ascii?Q?qu8YzRsmRxOyD9nSJRwXRPZ4hFVUqxZMQwT7CwEoM/2q8cOZ0/VJONTsKQWV?=
 =?us-ascii?Q?g0TDEHHQJY+AiI+C94LxL4C62BGwTaB81/hWVALLrPaTCHC0cPHWj0av/Dgv?=
 =?us-ascii?Q?/q85NzGsUCEtJpmz+GnQ2WxLs7UcKv85ia4Ou7x7nBcPLbK2HSI/vAte2LZt?=
 =?us-ascii?Q?HDNXSxuFKcUOHNbd5idvkgoTJsABDSzS96QCaPURqMwgEn1Bt6NSl6eAj7r7?=
 =?us-ascii?Q?1rly3JsuG4EwMj9elpYeLHoC2/3P7HOhmtU+37BuvW0Q+EjQuy/O7+Nw3Obo?=
 =?us-ascii?Q?EhLaP5erf/3vDQf42xy+PcWBboXMDsiC5k4vBCCEptDfPAMR87EmuWRxNdob?=
 =?us-ascii?Q?HYzkHulJjqlw526NeBwHxht+GUspzRYOKCQ9Ezh2q6Z62M0srZgHYqa2CAbU?=
 =?us-ascii?Q?y+7MezcSGj2pjsVZH/6XK+XqCxcQtgpTcjuye/Gi76aH2JWSi3DEzglYkB+A?=
 =?us-ascii?Q?HUj29h95gr3BDPcVpRTZF25sDoSB0Y5hmazvdnTpniPMLO4eqAxvh5zmrrsr?=
 =?us-ascii?Q?zvEgBVx3v68Nih1qiNhRpfjK70llRjHwXqyI//s6fZklo6PeAblzpGSZVL4/?=
 =?us-ascii?Q?qQ7aNIwvUOwu3qauXfSLdHDIJMzeFlvvPEu15nUGgAMmN7tzVlHSKpwQTznd?=
 =?us-ascii?Q?IYY3WPQbD4Nh7g6hkmrte5QAaAhd5aKBXND7AO75DPKfVZTTJrhaJSdmIvy6?=
 =?us-ascii?Q?APhOYXpVHI1sbeim1FJhqLHVefCy/VUgJkR0rOpbtumDnBwliL+bjXyArpTC?=
 =?us-ascii?Q?NlNh15YkMJhQyrXtMNuSRw22thsyxY32qQ4ZyoymjJr3GwjQcff2sBHv91Oe?=
 =?us-ascii?Q?rMI3MxZYL5maxAX7oNPjKFvp30bPjvbWshOW4TzhByhjBhWcFS48whPNfVWM?=
 =?us-ascii?Q?7PzdcbrTcH5B+d/+POu6zIUylsOzpGdd8fBGlfQHOpBXmvoby8FCWCkIY+0X?=
 =?us-ascii?Q?lfaVDZruPMsMjoZ2Q9izeHJVKS0Pn8PkyouICkwI3evPNSDaH9xseZ0UvP6F?=
 =?us-ascii?Q?FrzshiARub6PeMBaXu35n0pzLWkUipgly+Ki//dRdADi0IebZrNldliAjHLX?=
 =?us-ascii?Q?yd9aXB7ml05pII2DPvXBUIfJtHqW+Cg35B5/2e4otF6gEJTAiFfDOxdgKRbr?=
 =?us-ascii?Q?UsVQ+gUL9SV58h0bCr2/ZvEZ27HK3yRv38zMjqxlnlcUObMsg/S7HkQKvjy6?=
 =?us-ascii?Q?4/Yow/ew9urUICCzG7ljWReb+L92z1osAD9C?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 23:06:49.3675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb8a59f8-8666-4583-07f8-08ddb43cf73e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9BB0D8619

On Wed, Jun 25, 2025 at 03:45:08AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Saturday, June 14, 2025 3:15 PM
> > +
> > +	offset =
> > +		cmd->nesting_parent_iova - PAGE_ALIGN(cmd-
> > >nesting_parent_iova);
> > +	max_npages = DIV_ROUND_UP(offset + cmd->length, PAGE_SIZE);
> > +
> > +	/*
> > +	 * FIXME allocation may fail when sizeof(*pages) * max_npages is
> > +	 * larger than PAGE_SIZE. This might need a new API returning a
> > +	 * bio_vec or something more efficient.
> > +	 */
> > +	pages = kcalloc(max_npages, sizeof(*pages), GFP_KERNEL);
> > +	if (!pages)
> > +		return ERR_PTR(-ENOMEM);
> > +
> 
> any allocation may fail... can you elaborate more here? How does
> PAGE_SIZE become a boundary?

Memory fragmentation can be the reason. It's easy to get one page
but not for contiguous pages.

Jason suggested to use kvcalloc, so I am adding this:
@@ -249,11 +249,10 @@ iommufd_hw_queue_alloc_phys(struct iommu_hw_queue_alloc *cmd,
        max_npages = DIV_ROUND_UP(offset + cmd->length, PAGE_SIZE);

        /*
-        * FIXME allocation may fail when sizeof(*pages) * max_npages is
-        * larger than PAGE_SIZE. This might need a new API returning a
-        * bio_vec or something more efficient.
+        * Use kvcalloc() to avoid memory fragmentation for a large page array.
+        * Set __GFP_NOWARN to avoid syzkaller blowups
         */
-       pages = kcalloc(max_npages, sizeof(*pages), GFP_KERNEL);
+       pages = kvcalloc(max_npages, sizeof(*pages), GFP_KERNEL | __GFP_NOWARN);
        if (!pages)
                return ERR_PTR(-ENOMEM);

Thanks
Nicolin

