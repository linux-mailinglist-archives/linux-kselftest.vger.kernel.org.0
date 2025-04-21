Return-Path: <linux-kselftest+bounces-31255-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D61BA953A0
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 17:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A39B7A3C39
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 15:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579471DE3A0;
	Mon, 21 Apr 2025 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PD/WRtVR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFED1D5CF2;
	Mon, 21 Apr 2025 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745249933; cv=fail; b=AwOnL42syC0f6EQmDWZexAn69pF1Z/4zGhxbd31Wqyp78ugjefBgc5VMOoCkDoLTgpgg3G6+9zZFieKqUbfASf1PaYH86tx/dNX6tW/oZdXpFUMU/y0YK3TpPlsVu8fCnrrBY7R9uiV401YYJ3HlCNIY0JeTycazNBTM5lBfC/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745249933; c=relaxed/simple;
	bh=fBCWriSVk30TSuNYY916jNjU+GKY7rXFK3Mgx79kh5I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bojZPZMR2Bw5sc/WHh0TgqGNEGdCjNuOCvw1VL+0gLmIkdkMeu9tlPYSnssDVH5O8dXBxKBnb+sq4QzCBSikHW8ueTJDov3FUc5qouKJIhQV7tzKR8Bm6+q2S7qnymSrKLW3f4GCUDZe0b62NR8EXIeRxAK4MzYyYy2YVUbrjAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PD/WRtVR; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OCe+PEIsJ5y/t9EvTXlk7Z3z03VwYH51+MoN/GPFybybAdhhr0fSPK2ZC3d54GjChbkjsYaH83XaNROWLbsWeRna60blIPg48HUyH2aJT7dGqutL32XdrWQ7ht854Evs6VrILIvjhYp6QIigp1EoA8W3ie5ssJcMA0vxxWUV8q3L94bBUzSUg9FO5EH6YK92eJHFC7UOjKFGkIlSaYNJjuSPPUtbJZk8kIOSRAKpuh9pJus6cah0IrKEuC3Iht1HOnV/uZuQ4HvPrfjeJE7CPWOYzWUTxhJ8jeHEsGGPNuOYRGWTGkrXmSsUid93+Qv0Kk+6O7p7EU7y3qwBwbZIeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9kku1LfB0Al5Gh4TT1Vi/bOvGvlWSoT7VeD0UGEjKs=;
 b=lpWSlRGPz5TRwaLCRiXfzf7a7mq2zdYq9J7m7TfCWucbgLwpCd9JG40vrrLWY7nyCKs7GDmtW/ouGbQ7X/uQtuV9HoQVVrMxqkHVi2DeBgkyY8p75qW873IpUNwYb/aJAd6mrfO91B0HtcaBEPnh0s1COHY0AKsOoa5sCUuijtZx1OTJgsRmQhuK9s5JmuADPQ8IdX/mFRlubv9UoifvvluWUk6lsOP5fLVulrkHEjW9ChPMxe2Fvp4NB4RgiwSR1qEvLIbtCtHe0le1tnGzmAMl/UylyyyV2WogsD7Issip9y3r73KLErfCr2t0GCqyOOS1KEjmLjNSNWdm5W0i7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9kku1LfB0Al5Gh4TT1Vi/bOvGvlWSoT7VeD0UGEjKs=;
 b=PD/WRtVR8CT5Y5Dcrkyx1qxs72quSyOeqznViFXNGIUtX8q89Nl91xXqCe7KZXauG/haf3M8veGG+dYaw8pIl4iX1kpCxK5QFIrXPv+5ACqaUeFvNSwKrIOfuHUdCXagr7sR4EFXys+y2OsQAgT+AnP4/xGxI2QM21FIxkS7tMsQT8bbThC8C/7TZaodTNQhJizH+U4EkEVCic9lDncDJQW6pMNGjKI3TLImmpc33xxnpxEP4yShHpzapwPnMg8eY4kGjgyMYXanFQBctj6fROuTmQrQAqIvzCszBrZX0GROg84TbYXCwth3gS7a+GYwREEy+DqXvoaEnYf5AZau0w==
Received: from SN7PR04CA0034.namprd04.prod.outlook.com (2603:10b6:806:120::9)
 by IA1PR12MB8336.namprd12.prod.outlook.com (2603:10b6:208:3fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 15:38:49 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:120:cafe::73) by SN7PR04CA0034.outlook.office365.com
 (2603:10b6:806:120::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.34 via Frontend Transport; Mon,
 21 Apr 2025 15:38:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Mon, 21 Apr 2025 15:38:48 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Apr
 2025 08:38:30 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 21 Apr 2025 08:38:29 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 21 Apr 2025 08:38:28 -0700
Date: Mon, 21 Apr 2025 08:38:26 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, "vdumpa@nvidia.com"
	<vdumpa@nvidia.com>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "praan@google.com" <praan@google.com>,
	"nathan@kernel.org" <nathan@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>, "mshavit@google.com"
	<mshavit@google.com>, "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: Re: [PATCH v1 08/16] iommufd/viommu: Introduce IOMMUFD_OBJ_VCMDQ and
 its related struct
Message-ID: <aAZmcpXygg51Gwt1@Asurada-Nvidia>
References: <cover.1744353300.git.nicolinc@nvidia.com>
 <db035b1fad8987558b5c435ad7f9350ffa34aa1e.1744353300.git.nicolinc@nvidia.com>
 <BN9PR11MB527607DFB6B66CB9B502B2648CB82@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527607DFB6B66CB9B502B2648CB82@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|IA1PR12MB8336:EE_
X-MS-Office365-Filtering-Correlation-Id: 18da25bc-a5e5-4529-8f15-08dd80ea9bd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4GmsrmWzPvDEZXAiBP9Z6s6jhgHLQSNtUblUkz46vk5kdh/V1FdhG+DEO8jm?=
 =?us-ascii?Q?mxVLvh3VEJ6pscDOD2gi1G++EYjBUw0K6/OlKK5ELW6qpoFZddRlXBycim7q?=
 =?us-ascii?Q?Ps8Cj3HjF0MFHxaxmMU+rmb9CNWsNT9LFHN90jeBkg7I/mBjZeFhJBgFGoSQ?=
 =?us-ascii?Q?LyAMLfzG16AgQr5QauLYDVP38jbrYeqWO06HAjDTewHh82iynggbTgH5nNqW?=
 =?us-ascii?Q?g5Mx1CJZp4hvQeu9l/ynd20Vdp6wR9+cuNJy0xD8pg7jk61hZuGUQhuIL3FO?=
 =?us-ascii?Q?LB9GWbRJ2C1FPUEnUnFxBZK/WgeMNqDyQDDKyryUfedmYcmlBsMZsBeLl1d4?=
 =?us-ascii?Q?QFSPlWacnrcl/93AISndpcQn+oLqHUBu7ga1QP4dIua8CQrjIrn7kXNPFXij?=
 =?us-ascii?Q?I06KOazYWF/TumM0wWXYfCSC81F4FAvlkD0Vr485poOaPHkdW//Bpve8oTVK?=
 =?us-ascii?Q?5WOH1T+zpJ4ecO25+P3QZORQH+9GKkudZfweDLCUIgCxLbBPbc3iH9DBjSsH?=
 =?us-ascii?Q?n9lIxFvz+9JfjzvzZLPXtuPSUDJ2dH/32C+5OrtqH7QUx3DZBntDnjwvMpyp?=
 =?us-ascii?Q?WzhqB7DuGWP05nlwAg+Wd724sTzCV9nLQNQ8Wyh+5i9LuZw8+AYm993lZ1df?=
 =?us-ascii?Q?v8sIUX5+OAflWw/5MBqfCuC1Tz9n7Ru2+zF/WRrwrdvBrNoRvNX7lExZMSLs?=
 =?us-ascii?Q?8zeR38Yhfy3fLvAzP0BheLYdJvHdsXjvFxafj+7BkLaGBwRzyLjpKb5fmTWG?=
 =?us-ascii?Q?YHevI8VepSocJhHt7n1kCMPDOOcyoiKG1kg+YzHm7DGjIg1WT/b3I8AFVbDV?=
 =?us-ascii?Q?ZnXaHs5Xu6SGS6X6bV2s5olWw/ut28d3b8BjvKPewJ332L6pQ5x8mJc9tHr8?=
 =?us-ascii?Q?EPOaBwRE2RnP96rbv0t6soV7hawQIb6e2q+Xcx6mUVI5rHhI+RDxUpP4L7nE?=
 =?us-ascii?Q?yQxJPLB2+Qq4+N9ydqL1PFx9vzFLTc6CxNfoTAXK8zNwmz2RzSvXVDiW+e9S?=
 =?us-ascii?Q?i7448cWWIpDuKA4UVPz51YzOPrnKBTnSnEXkk6ZiIjAKYXZGnJIq/b4lZEPA?=
 =?us-ascii?Q?0yh1+/wAA1a85fP6j5bETYxv1EaX2sOEdNDzjebF4R5PzqC/JKKNC4r94uB1?=
 =?us-ascii?Q?XFVmSpo4A6lzSF6D9tCH6BCu2n6jy7YtwcZc/5Z/lRlpn1m8cnL4Srwdj3MV?=
 =?us-ascii?Q?mvwSAtBjIZFmGGmrzCpWbGNqckB0VDBaygcqEPQwev5Ecp0XFDu352T/cw/Z?=
 =?us-ascii?Q?ARUT+hWvtwWZWU5i6AslGAuZJquXpyrTrTHqx3I5naNRl7xnCIlRvZQdLe3d?=
 =?us-ascii?Q?UOueEzLi2wDHoDd2CY78VEWg6fXt/zDG7C22an/ZWKnQCj57rjBCEzdpSbB+?=
 =?us-ascii?Q?yc49V/jLDoRGNlNGimjZnaRkPLLnug22loC6Yu2DL31/wQ4cjDYT9J02lbZB?=
 =?us-ascii?Q?NAXjrgd2TDfZpKu8WaaMCJTF1LwIux8MzxGpl/LtKoVXQPbJRG1WlczNQYm/?=
 =?us-ascii?Q?KPw4gQRM903o6HVt41mgfd3vDt2M5C1FpLCg?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 15:38:48.0617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18da25bc-a5e5-4529-8f15-08dd80ea9bd6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8336

On Mon, Apr 21, 2025 at 08:03:01AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, April 11, 2025 2:38 PM
> > 
> > Add a new IOMMUFD_OBJ_VCMDQ with an iommufd_vcmdq structure,
> > representing
> > a command queue type of physical HW passed to or shared with a user
> > space
> > VM. 
> 
> what is the implication of "or shared with"? Do you intend to support
> an usage in which a CMDQ is coordinated by both guest and host (which
> sounds insane)?

No. It should have been removed. Was for "vQUEUE" previously for
a potential wider use case. Will fix this.

Thanks
Nicolin

