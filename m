Return-Path: <linux-kselftest+bounces-31488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B2DA9A29D
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 08:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1DEE443070
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 06:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88011E7640;
	Thu, 24 Apr 2025 06:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bQLL87y1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B30684FAD;
	Thu, 24 Apr 2025 06:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745477538; cv=fail; b=Us2fmayn8OOgPnk7tdziyjYMUyjNicXv8voO6/RMWYy7FQW7El4UYMhvr8G5THRCcNi3Go0WGRgvewDmgUl5EYO/Y/DZD+FSd1qK8ns1Ni0ZogsCfgBAg094gwvBpZdzlZmb0OQ4OP1OKEY+UynQd1sUkjE2WaWDi1Uxj2NbAcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745477538; c=relaxed/simple;
	bh=u/K/caKSaKc0qfCt3GWjSPFw+NbSErWzIbwhLyQzp+8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t46CUbHB1RrgD/8HDp4JT7FQXeZ9YHvzwffV48PqAPPVVR+j1On/u2zDH9DASi3q6RK8p2d++RR83KPAA6R9c5CVrefVq2uHfdE0FnotJ5UenEMpXJykF5g06eN6duPkEfNe/Nk+YJlzJBKFkCX7TkE4aWpoNUK/a1P/nOMly+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bQLL87y1; arc=fail smtp.client-ip=40.107.94.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KyhsJhTTYU+N9ueieWnMOyDd1DdY0CmhSk+2k4Rl3ogJOj3zF/VgngmPFj3eQyhgMftovY2aLOjtW4cV/jd1hV32Wwnj9jpFBlkA3ovEvgMr9Rt8ILn6Gy+qsPCSYsrHWee62erfrM4ceDWLHydarxm2dSyQcbaOTt/5EqMl5VHH04a6ZOM5TFhUIJTD+DISpARqZC+ngWirTvx653o29w44TtbMvLO2KgowcaiTMvO6B6CjfZd5CMeuluhflIxXFrDbqJMdGOMLbmKiKpXZoy41LvUO91YY7BneipvU+Og2/JorelLk+seIY2au1EVXpvJdfLlaAowz8scloqy8pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wbk7rB7UpI8AqeYqKYVoHwZs2BGssI08bBCVv6twIIo=;
 b=N/8kpzrVR5wPXH+2bzNyzx+Dzx2O2HlA/En+1v5UGzPQReQiVnlZBP8tyesFOhzJgwSHbwECt4KR4QqTIoDIhlNC/pAjVyMsRb6ofWuL6LrdIybUJclzpxTnH2wDxlqqWp23Rjcce12tt6tKOvv0+bMKRmmFsLAyYVWIVFyYzyRH5kkoMieFZMF9vTBjBb4mxo7n/GXO5qY72BiJL4zTLClGfWZZxOseQFzE9Y3j6lDzs4GUIVSgqUYL512UDdYj7UgX5a0wBdmOGKE7XSRRadOTR/r9RudeHOdSeO9Bqn4MejNAA7s4L6ZAMmnXLifsywTHjQSussXrDXFrhtT5Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wbk7rB7UpI8AqeYqKYVoHwZs2BGssI08bBCVv6twIIo=;
 b=bQLL87y1IY2J1ZUGU94XUct/ngFHdnRB11Rz9sw9TGrtN79Xi63KsCnfxZgt19FZhM1xxWttdrB95Lf3meJz+qI2cWGRna163ef8BqaF22V/9rmeg8cJqSiIIEU8EMlyXPeNGjGnPjjSLGUuE/+DBTizA1r4300bksEOAORySMEJpRtFwVlLsHdX3qCUBUIGjQC5DGZbRlXuzva0r4EuRtMaIe6ayhKqstU+b7AzhlAGXX1ZYROPU2SqXEhv3+EhaaHawsMcvtNo8+kKWrRz1rvHOJs29jaXbSf2z1Vf31waHni2apdmjK3CGPbJB/J7ibz1A1mRWL8jh20R7ByEGg==
Received: from BL1PR13CA0184.namprd13.prod.outlook.com (2603:10b6:208:2be::9)
 by SA1PR12MB6948.namprd12.prod.outlook.com (2603:10b6:806:24f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 06:52:10 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:208:2be:cafe::68) by BL1PR13CA0184.outlook.office365.com
 (2603:10b6:208:2be::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.23 via Frontend Transport; Thu,
 24 Apr 2025 06:52:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Thu, 24 Apr 2025 06:52:09 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Apr
 2025 23:51:57 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 23:51:57 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 23 Apr 2025 23:51:55 -0700
Date: Wed, 23 Apr 2025 23:51:53 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "corbet@lwn.net" <corbet@lwn.net>,
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
Subject: Re: [PATCH v1 15/16] iommu/tegra241-cmdqv: Add user-space use support
Message-ID: <aAnfiUk1TTlkpkRE@Asurada-Nvidia>
References: <cover.1744353300.git.nicolinc@nvidia.com>
 <30c7aff68c35040ee637629cb9fc2b6e7f83f76c.1744353300.git.nicolinc@nvidia.com>
 <BN9PR11MB52768197516FB895146A12078CB82@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aAaY+f2/jw9NaIWF@Asurada-Nvidia>
 <BN9PR11MB5276220C7B2C5743DC8364CB8CBA2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250423115551.GC1648741@nvidia.com>
 <aAkyAbO5UQRySizN@Asurada-Nvidia>
 <20250423231333.GN1648741@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250423231333.GN1648741@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|SA1PR12MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e81c9d3-316c-4a84-7860-08dd82fc8909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XXOe1aoA0VRYgsPZQsqk3PShGc+BzpdYlnBCZIhRh/DeK5n7qFgOnR61v0jj?=
 =?us-ascii?Q?hSlZPcipmRAq+F/W3oQfFd++lnahifTZsIhwAPqK87z6fjATAVBxtCz/n5W/?=
 =?us-ascii?Q?wFyj6LUR+tJW0UW31YvLMMI5lq8vYbAoLJ9ZQa7apzZW2CqFmbJSakxHd4l5?=
 =?us-ascii?Q?LeAQmhl+2H7wNPHDQXtl+aAY70MlTdXLscRwjBZn5EOB5+Qq/R1nqyqnhbfX?=
 =?us-ascii?Q?o+OX3nZJ1vUhstnMlfWW9fMCvu2TD8e0OqLWgWorCqaB366MpA/7hLjiz+lX?=
 =?us-ascii?Q?sXFr4jQllTDxWf2EdaczxWqtiYOos4azuW3cujIGpW7D943dj0Gfx8ShGSzk?=
 =?us-ascii?Q?l8S4A0u6j5zr4uFPGfroOPlxLlWQa8YjraGKtRq4nZ7+xfi55jUlhS4uKHWu?=
 =?us-ascii?Q?PNE1m2u3kezRBZtI9JQ2WRn+ElmhDwQnnkCT9M0fVw7wLOwyLxzn1kq6h9Gs?=
 =?us-ascii?Q?KUTI7yzW5VoF8w+uYL0WrmWQ9/f2YR3YodljliiA1lHD9qp0JE5U3XVptcGf?=
 =?us-ascii?Q?xr8SFzlZrK1WltfDDQKjNrIwoddtVTkDLHZWpvVJy6NKl08V/bFMioc5zZKf?=
 =?us-ascii?Q?cByB07486yEVthBQocFoXI778Zqb1/zpWAWcTdTqrm3BabC9jK5XgZFbT78+?=
 =?us-ascii?Q?I/NnIuuUB0ss0QRRibX3/h6bsbTuxKlkRmf2jw0G8Z0sTe30zvXo8zM2khpQ?=
 =?us-ascii?Q?+cH3IiMQhoc9qQ2M4oOvGgi2/z9FmnxUsic36lZV0F+K+12IgXcj7okSaliO?=
 =?us-ascii?Q?rdqYVHX4IuTQJ2B4DVe2+tszrvbJhmrgW1EYW02eI+NvogtL0aMgrzeq8Et6?=
 =?us-ascii?Q?r84H9RQOlPqQUzO5lOPBSZS583Mg26aaa23VHcmLN7RXED3fkDfg622YHa/S?=
 =?us-ascii?Q?A1pwBz/bzC7P47ood+C7Rvn8aqGFw91IsfOk5wLVh+zw+KcYG52weZZxP+Wr?=
 =?us-ascii?Q?aFpN2OChb3zTw4NC/RBAEun8LBL9RlIr5AmyD9rau3SR1rZAJLj+Y3VFq4xz?=
 =?us-ascii?Q?xvbAwFZTSndH1Yh8qdFN0EJD34ev6oOCaL5nrtN8sXUD1LM61ylhBfbuCBTE?=
 =?us-ascii?Q?rLKGetCrErq3zOKBxIT4KKV4k3cbRInH9U6LqRslejmhRQhImfjrKk5BV9VE?=
 =?us-ascii?Q?n1fUtsHqowz85U3S8pRTm7seyG5SHEsbS+daRMAHi9rYgIMRTVFnKqwDlbry?=
 =?us-ascii?Q?rMj2b+sI3e60e4yuvnO1ocPjW8pIQum7ESlITmA4X59nTsyGyAz9HV54km38?=
 =?us-ascii?Q?lQ+njN1kxo5Og5OHzB0zOBwGauagHBJnE5IsN1k+pj1CPE/xojfyPzJ9Nu2Z?=
 =?us-ascii?Q?JTr/LXPk5D+NlJKnSRGIsOzHxTpmaWUJPEdYWhSA2K++SAjzKa7hzovTlwy9?=
 =?us-ascii?Q?5N4Gjw/REEXMwymdEbJ+34W6B9FMw61r6JGL52PDqI+nI8Jdo+Utl12WJG6i?=
 =?us-ascii?Q?wBv9hUuZ9IBeJTvyitbusOdUKqFpCcbx0+N7Aw1tQz5e6hmYCghukYmeenxg?=
 =?us-ascii?Q?cOj1iI0KWnpI/oI1D55kV2AyL5R4fHXPbnp8?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 06:52:09.7072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e81c9d3-316c-4a84-7860-08dd82fc8909
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6948

On Wed, Apr 23, 2025 at 08:13:33PM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 23, 2025 at 11:31:29AM -0700, Nicolin Chen wrote:
> 
> > > It also needs to act like a mdev and lock down the part of the IOAS
> > > that provides that memory so the pin can't be released and UAF things.
> > 
> > If I capture this correctly, the GPA->PA mapping is already done
> > at the IOAS level for the S2 HWPT/domain, i.e. pages are already
> > pinned. So we just need to a pair of for-driver APIs to validate
> > the contiguity and refcount pages calling iopt_area_add_access().
> 
> Yes, adding an access is the key thing, the access will give you a
> page list which you can validate, but it also provides a way to
> synchronize if a hostile userspace does an unmap.

The new APIs are very like iommufd_access_pin/unpin_pages(). But
to reduce the amount of code that we have to share with driver.o,
I added a smaller iopt_area_get/put_access() that gets an access
and increases/decreases the refcounts only.

Yet, this still inevitably doubled (-ish) the size of driver.o:
   text	   data	    bss	    dec	    hex	filename
   4429	    296	      0	   4725	   1275	drivers/iommu/iommufd/driver.o
   text	   data	    bss	    dec	    hex	filename
   8430	    783	      0	   9213	   23fd	drivers/iommu/iommufd/driver.o

Meanwhile, I am thinking if we could use the known S2 domain to
translate the GPAs to PAs for the contiguity test, which feels a
little cleaner to do in an IOMMU driver v.s. with a page list?

Thanks
Nicolin

