Return-Path: <linux-kselftest+bounces-31254-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8E6A9539C
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 17:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19BEB18943D2
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 15:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A55B1DE884;
	Mon, 21 Apr 2025 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HRiawwqX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC6717BED0;
	Mon, 21 Apr 2025 15:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745249748; cv=fail; b=homMO7lamVTXwMTFGm4JZmlbLKYCSwZCjr6uzhpOMfZYf+0PgZbMwqU2GWH9vFwyesFz02GghO8Uv5cEOXC2N+ZkjkJ1FJzZTh8q2JlQuC3l+8Oow06fDH7ZPnWYcb12PhojxD+zPHGicTBr4q1kj9vFlwm/kX8A4qbz4vfBIqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745249748; c=relaxed/simple;
	bh=3U7hTai5GTf1DjAVci1hN2rdLGzXDWVLtbFBLzm20v4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEAxzHgmog3uXBKWog3hz/bMuFlO0pmGm9tKeW6o7UtKXQJKJkZ8ppDIgwlHVY7rNv4KjrXtFYNEclFeqhKaEFMrf4KM5hc7XsINyjxew8Oxcrpjll7vooGcYi3KgdVBUh8+BQbvBp3fQc0CtLlorW9egZQrBauIendPzgHG4Jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HRiawwqX; arc=fail smtp.client-ip=40.107.243.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dItxkxNKVmuHRQ1bBcV/Laj221VDBvABRNMxgjwRvu/ThE7ZesQ5egjEejbbF8fHvn3RBHK+hbTkAF3Kl0863NAd0d03Ex3XEsFjPyS4MCs73ij/njHxA1mrQEVDEb1Zjpi+IyopMApTwyQb+5jI+Z2ws8mzTlVTg/oDBw9Z+xiSHccsafZnOwijIHY+urX4ZoTDptY/MtMeEq1CLIcdqpQayusc3UUsK6BnwytbGjyIUMEWEyS5mAnFFlf3/SXcCGvwxJ4/5ODVKUq2u3nsZxQ0csjIC0mJMy/8/9gyQ7oailAFXDfrFYJ4RsfbSVRgQ7vxtNP+jmptIvz3ka0/0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=791sBgmIT+uduGOfqfpR1zr8F1ItDoJKK66A+LoQjUg=;
 b=aRcrL92vZU3j9PGiOZdRw6mlpJEgZadcsVcBuBxMAe9ItdgjqhYnFAmaFMmvieRhvq3jihDAJquPsIaU4LQzQvGlCbhlDW6c8jdFaLYvBrDchqUdU9CqZwhTDhdXy//xSxgPC0qKpTZcXqxBTSS5Mbnnzmwfz1alCsytU0RXcwtC+dOXWFwPhDiUFS+KaExmYdckXgjnUOtZB8MVHcNdzJaty4VrSwWfLDanySW5UR1kvpH1n77o8Dve8qfrSsQWc2YuJl/f1j/AEr5yquEgS5l8P3ixQIQeNSdljtQ6avyaeclmUsVi0s4M60nDBoboBoga7eg0CUpRlLr1fLcDuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=791sBgmIT+uduGOfqfpR1zr8F1ItDoJKK66A+LoQjUg=;
 b=HRiawwqXC/BqYKnttojPT54R46PGDQuk5z8i8bNrmj6OFObM3ylbRXhRyIUYplyFEdvB6cjv66Q6t/+PRaxRWOZdUoJEWzYvow2mud17dA17Z3csCRu8brdtjwp+XubxrHHHi0g1UDW/ALYKK3/Ey4k8b6oAibSeG4d6uZWYpbVZEGKP0RAGLf/0YjIQTfWrRezZIsD+0v5AwcDjqjjbwNJRf7+IAnXer+V5k2xnhtdJgYQxs5skNC7ZVm/bvRgI0XPKqyvG+Wy6iDzTs63z8MR+QaXlFitTt9MIdH2he8/KGl8RVRuJe/ztN8t/H3DJOmZDNM76svuh6OEq4oerNg==
Received: from BN0PR04CA0043.namprd04.prod.outlook.com (2603:10b6:408:e8::18)
 by BN7PPF9507C739C.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6da) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 15:35:42 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:408:e8:cafe::1a) by BN0PR04CA0043.outlook.office365.com
 (2603:10b6:408:e8::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Mon,
 21 Apr 2025 15:35:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Mon, 21 Apr 2025 15:35:42 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Apr
 2025 08:35:26 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 21 Apr
 2025 08:35:25 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 21 Apr 2025 08:35:23 -0700
Date: Mon, 21 Apr 2025 08:35:22 -0700
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
Subject: Re: [PATCH v1 07/16] iommufd/viommu: Add driver-allocated vDEVICE
 support
Message-ID: <aAZlujUAJ6tWekEA@Asurada-Nvidia>
References: <cover.1744353300.git.nicolinc@nvidia.com>
 <349fa2c4c291488bb5bae6e4a8bc0dcbd0c51fd4.1744353300.git.nicolinc@nvidia.com>
 <BN9PR11MB527601845E1E55D02F57F04E8CB82@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527601845E1E55D02F57F04E8CB82@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|BN7PPF9507C739C:EE_
X-MS-Office365-Filtering-Correlation-Id: 68e2e686-c355-464b-16af-08dd80ea2d05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MHI9K6smse2zuYgIVdnidc0HVxj7On1I+5OItlDU9/TqpcngQZUi8bTxlKGj?=
 =?us-ascii?Q?XNI73ksDQS41OF3mYARjni/Av2u/RwSG2sHq/uih8duMB43fgL2c3+o6Lnp3?=
 =?us-ascii?Q?5A5KCfNomwxkywWSv2iyX0U9d5Q8KuhaUapBJjm4mU4p7tfuOZB6yj55TyMG?=
 =?us-ascii?Q?W2JSlRWk3KCAPMbkqppFLDKnK/fKTBw4Qzhj/orXRCn9pC5/G/C3zQz/fThO?=
 =?us-ascii?Q?WiVeRt5SoxKjj/Tn+rLEmIZ3wWBXZh8Qnc+6BeYQjj+sMhiGrqKqoJmTPdQm?=
 =?us-ascii?Q?j4bgDGjis85z2hR8buXYBecFGcP+Arvb/Uhv3nuFCu96gdfwP1diSwL8u234?=
 =?us-ascii?Q?ItOq9+8lJiCHJ0XWNfEWXBZaJXTGDRwMqR8cDeR0/aug+J78WLJkvpIQnJmX?=
 =?us-ascii?Q?2tFljYWNR9p8TNhif9SsY3TogvLX0JurIr7syzQEUqKPzCEr3A0z/NxYwvHR?=
 =?us-ascii?Q?7hNefwpmgDMmuFQsjLcGuAvKsaDusIgeHLSal+3wWG890D3d9RKMV3TZKa5x?=
 =?us-ascii?Q?6pBCzc+ERIG8wxi73o6DAgAB3atCW3W0DKaLFd6YIv+Qfw2n8wM/QGZnYnRJ?=
 =?us-ascii?Q?oCNhEYhbwB969hqkxh8aWRzRyiZq9sDj8ANF4FKzUYWu4Dgs+Q3Q+DPsbXvS?=
 =?us-ascii?Q?h7UQ72uODBfh6BaM8/4AOuN2qSXZ6701+oBvHiSUE7EAUfcZBTALhdg933Bd?=
 =?us-ascii?Q?g0c0IjidmMRkZQE6UZPorX+dvigePbs2HKQDGGZTjRGYdPi33VpeaLv4y/5c?=
 =?us-ascii?Q?EWP0T3wD/Zy5Tcm9/9haGS6lcMYJda0SRZNkpNDT3OUOxVR8sS5uxksryxeN?=
 =?us-ascii?Q?KD+bLqUZ/z/p8Cyd/KuiHClx8PHb8Mq891Ru/z+sfCEho6tNoJo+4HXxoZQL?=
 =?us-ascii?Q?A5gep6GmktXgam0pgKmJAZwQaVENlEl1+1X/1A5OgRHsnIpT+4yfuiSTQ8aI?=
 =?us-ascii?Q?Big1y4pN8dJT+c2TcKVas2s8kLFvh1uqA6MZFIDsywbz/lEV62RZHTaOp/IY?=
 =?us-ascii?Q?GEFdc0m2BM+rj67o0t01j6U6vIdWnKIWTxUh8bwV5rDFofevgtQkxH+gSRLs?=
 =?us-ascii?Q?E6S+E7vR3IhDsSYj+3n1Smol/0jy7vLvWQwENa1UKIe75sqTYINTTwlX6Fbj?=
 =?us-ascii?Q?zEyyFQtHjN1YbYOenT5/XhMR/6Q0mcV4GiAjenZcs4HfoCZcoUfk/Dq8wd+Q?=
 =?us-ascii?Q?ED3S+GaXJrfrtqlqiZBeuYGAFnUp629e0fVoAoKtA01ZOfCRArhsebQFDkZf?=
 =?us-ascii?Q?CQxXTIoV03H/Tn5jthi0J7OUoL2C4EnqG06iuX39NexH7K6TA53CF8q3L06Q?=
 =?us-ascii?Q?2wAJbcEdF88ti2AnLnbDdkZniNYPmjlnWgZ47JZmIKY8dW45ihXWNuWM79bD?=
 =?us-ascii?Q?IXDBePKoiFWt3YWoaMUDlCRRyB8MHrY/WFW7FpdegzAxyQCN0PAGJLyA5WpB?=
 =?us-ascii?Q?WHSD3GELRQdnfoPBytA9OaOWY+LsmwfY/7ZjTP2ALKN6NxIVySzKyxwqzDpF?=
 =?us-ascii?Q?tK8+78CMrEwl6hvqX0nYOlfT/uVsSMeZN/W3?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 15:35:42.0614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e2e686-c355-464b-16af-08dd80ea2d05
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9507C739C

On Mon, Apr 21, 2025 at 08:00:37AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, April 11, 2025 2:38 PM
> > 
> > @@ -128,6 +142,9 @@ struct iommufd_viommu_ops {
> >  		const struct iommu_user_data *user_data);
> >  	int (*cache_invalidate)(struct iommufd_viommu *viommu,
> >  				struct iommu_user_data_array *array);
> > +	struct iommufd_vdevice *(*vdevice_alloc)(struct iommufd_viommu
> > *viommu,
> > +						 struct device *dev, u64 id);
> 
> s/id/virt_id/ would be clearer.

OK.

@@ -143,7 +143,8 @@ struct iommufd_viommu_ops {
        int (*cache_invalidate)(struct iommufd_viommu *viommu,
                                struct iommu_user_data_array *array);
        struct iommufd_vdevice *(*vdevice_alloc)(struct iommufd_viommu *viommu,
-                                                struct device *dev, u64 id);
+                                                struct device *dev,
+                                                u64 virt_id);
        void (*vdevice_destroy)(struct iommufd_vdevice *vdev);
 };


Thanks
Nicolin

