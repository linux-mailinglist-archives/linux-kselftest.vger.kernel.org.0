Return-Path: <linux-kselftest+bounces-23835-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5C9A00133
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 23:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 578E218835CC
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 22:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1653B1BBBCC;
	Thu,  2 Jan 2025 22:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YP+F3I9H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7FE193073;
	Thu,  2 Jan 2025 22:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735857091; cv=fail; b=KubFz3kcZ1ALaCNv1rWF5AlkfGuHcCLmYPocBvvgpBcNQL2NkEe+qytl+EiNeZkM4x5GSaO+umETu3d7+gwHDXKJH+ogcW7axpu2klfxcD2y4ZwURHwZ2PDxx2pvCoZxgdCD10aT6kDp3plgMxDpMI7B2Cng6NVjbDlMCkhE0BM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735857091; c=relaxed/simple;
	bh=uTKUPLOIYsbGYhC4fKjo78IMdEA1EC+6toH8aaittCM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amWcBJDeBO4lFdhY4LCec42U42VhyNx9hf3LqHgLq6W9x0B4RA1OWKNeSIWRokU1xh7tn99hvT3d7C5Nfaay6LRg6ZWA0XMuPclhKX7XcWFPz8TSqH7/lc9Xb5fO7VxRt+0E0HZQtnwH6lnPl1o/dpPSXjtygIf3rKZf/ixmMFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YP+F3I9H; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsZELCejGPfq1MGIM9t5fjHi1rq/uVMdasczidD4iLUdHJGXyMADdL4xYeO32aFtuqrP4Zp8cwTiFMAipcXFNfoNIy5q9CLVbySi/m5MqUE3lAjrguwhEf4JD3P/OVcdRFPfJZIauYqX+DPwZaVo+L91tTkYlMaxBWGXLPMjXB+qtRf0NYEN6Jx18WZFnNwkBKBzKi5qYB8I6E1lwslijdSHF3ITVHiDZ0rt8qOJUwFpeZINWkM9q9ZlyGfQ1bMllU7Mv2M8YY3S4qlDgx1v/mk4B8kp5Cby/SnlzTiAlQd97kdULRsDc4jzHrxpH/eId8tHUgVm46APYniuzhQn3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shwH6aBj6wibVdLZoo0K7B2rHMZbMFS2kL7akYRi74E=;
 b=naydfNi0CuzaDLi5dyCayZT2mnV/zsBIOQv2NSrQhUwKdL9+TL3ML7g3m1oGA4q8PKgrQCUYYpV/bBziuMp9MjO7azD3nHAT3lD45uWP9rcDC7Vezp86m3Tw/iO2Yp3GNZm1ms7YmhelJ2oprgOTz4FT45zWmzezKbNseYxZ1J82m/92o0014hdJ2XRlCew5mMWoCmTX0z1pcOyTrdIIFKtKfYLiPyXKneemNrElAMhUphZ9hfKTayB/W+5JKs1dJhkN4iQO8J0XT0LdielXFx0wluLKvtlfavmzyXTSMYnltZh+oARhQPVxdCKuGAWX1wD7d5XSAJ4Q6WFWrVVCrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shwH6aBj6wibVdLZoo0K7B2rHMZbMFS2kL7akYRi74E=;
 b=YP+F3I9HWOcdj+lWP6RB1+LWCxupYIj3b6Fz/jWRVZblh3sLAr6kj/8NZBhYF7GXYqQLlRV8aGjFCFounDGD9kaG5wJgOwIgWZkF0JYibcRLCn7ILuvJnlLFmp7/BlLGHoy/XOwgC8UAy8iny7gRAW0owOgRffcoCaqWwNAnwymi+k8jQYts9nbeBstYetzT25udd+i1veQX2ih1Q/9x30e0ked6gLsl2Z6TJ+kv8Ou2bDG8t18Zj1xBwiey/syROPvQrc0x4EkuXpBjokNH5uNvtlxUdc3v6TUoxa1o8IOp3rLmsRLMhiHEIS7TibcI4fWmb6ldJikYnTjFvyc0Mg==
Received: from BN9PR03CA0285.namprd03.prod.outlook.com (2603:10b6:408:f5::20)
 by DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 22:31:17 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:f5:cafe::96) by BN9PR03CA0285.outlook.office365.com
 (2603:10b6:408:f5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.15 via Frontend Transport; Thu,
 2 Jan 2025 22:31:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.0 via Frontend Transport; Thu, 2 Jan 2025 22:31:16 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 14:30:59 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 14:30:59 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 2 Jan 2025 14:30:56 -0800
Date: Thu, 2 Jan 2025 14:30:55 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <will@kernel.org>, <corbet@lwn.net>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v3 06/14] iommufd: Add IOMMUFD_OBJ_VIRQ and
 IOMMUFD_CMD_VIRQ_ALLOC
Message-ID: <Z3cTn9nXAh+kKtZd@Asurada-Nvidia>
References: <cover.1734477608.git.nicolinc@nvidia.com>
 <dc1252de7ff06c944cb7d91c91b4f61c25182f91.1734477608.git.nicolinc@nvidia.com>
 <20250102204507.GF5556@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250102204507.GF5556@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|DS7PR12MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: de690a27-de28-411a-c213-08dd2b7d2c14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RZlJJweWizOE+KVkpVB0cftBAkArHYpdt5fK4lsfGKRy8myjMR/6TXH4HcR5?=
 =?us-ascii?Q?4tVNf5zVM0hI8EoCZma2Qr2YWHT30Jk8/i7n4JY9O8Nyn1X2RGwfw/uzOB9b?=
 =?us-ascii?Q?xBS2DlbCauDWBAfyleQQTfjZFEBHNF4DTUM2WNxsgFxssYwxWCcNXv+XV1cx?=
 =?us-ascii?Q?/NuxalUIfkt4J7RxV2dKNcrp80FwLsX09zRzX05kDJTIlqu/nNua4ZZnrZk+?=
 =?us-ascii?Q?q/69ulLjXID14K83ZGsMl0fqC6808ZLBBGjiKzP19ZZvMLU9+biSByy9bIrL?=
 =?us-ascii?Q?F9Odk6utivsIcwY1yYN8ZFxwNR296adGyzz4zsa+luighCudTlkbs+0T/pc8?=
 =?us-ascii?Q?0fC1zGRrb9+AwAdZU4pIw+rxXcPEkC6Sci5EQyGuWOq612JANWGqijlbKj6e?=
 =?us-ascii?Q?T+0fzXdYxSG81yL7I3gB6ixAntrLk/1NQV7dXfZP/HxF9ToqtKA0wYAIxvVk?=
 =?us-ascii?Q?8H+Q1KmaLxWvKiYz9rZhZ/EswTN0nLd+npXmf1asQtWFxXxryf+flyyl/xF0?=
 =?us-ascii?Q?O8WnIpoFTdL87oom+Uyu8B6uZcdqbyEWb/rcc3uCKbh/jswJJINylqqKhkls?=
 =?us-ascii?Q?Hok14OkgPVg0k9RY72Vd5MgvQWDPGOjmVGrs5KEreFq+svGAoL1SfWQEWiv1?=
 =?us-ascii?Q?2M7apCG801rvIbXhRlhXDeKzg/T4vI9KkUdh6564pWXFDBlnK6YXVEmvIbU9?=
 =?us-ascii?Q?Ezsn/cVDRm3TG6aM0QMyYyXpid0av3KYRve8w0Fwgm9lU77OMw+inKAAzKxj?=
 =?us-ascii?Q?PytxZnvNQvPJrdulOHjfDQR151t/0uquFSxhpYsogvcMLPYhmEzR3bk/NAIN?=
 =?us-ascii?Q?mqiW99+HkuniYeI64VZJeeWcrqfsmbZrCecqz4tnxlycfR8RkTnO3pW9yzhZ?=
 =?us-ascii?Q?V0eI9YyixeposzKOJ/2pYO1yQjOLgXsJOFKvKwfLCInXpDfTludlUzWJCah8?=
 =?us-ascii?Q?Xjoilb63+c8/m/sWse1kRfipJfQXWJEfOFCL3+f0BiRnaGc6EyOUv/4JbNZa?=
 =?us-ascii?Q?3tFD7uBkr0FTx7HhWLGOJr8JCaNCHzEvBBvTjYY20H/2D16dwziiM+3Ks8oP?=
 =?us-ascii?Q?2yBQqNTvk85hu5fckYVRAtnWWu6iLDYo6IC/AYgT0pXUHXfZtkJaq4n6M6y4?=
 =?us-ascii?Q?WRB3JwgF8WDkaQX+JIjN/F/N4aWEMCEx4MJmCW1BFcyjOl+x9sRXUVgOoRmq?=
 =?us-ascii?Q?jqYtrrDYiXegGLR9E835R1J2RzxnGkhrPsT0v9gfjZGf9Lhkv6lVz6LBodsA?=
 =?us-ascii?Q?vw3mGNkk4X5VQ0n2US9Qpt7+BOJcnCjqANRVf6qoobsCVq7Rgt0ryfxI4mAj?=
 =?us-ascii?Q?jnZItzpEsK59vE9l+8qf7f0Z2IKlbw4C9QsDgP8vMosn2WenftHX5GJ/wViJ?=
 =?us-ascii?Q?M2KYEUBzSIR3oQHNgf7Alzaegxq5oC5KQN3J+ov4b2jYpX9QrDmxgZAn79Ld?=
 =?us-ascii?Q?yZX1Gx2C7j87gqCDTUjOm/L+PH25JXjuzmuZgkXKIR0ih5wdpt0SSgXTA2LC?=
 =?us-ascii?Q?zTG0W+Ct395CYZQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 22:31:16.4911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de690a27-de28-411a-c213-08dd2b7d2c14
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6309

On Thu, Jan 02, 2025 at 04:45:07PM -0400, Jason Gunthorpe wrote:
> On Tue, Dec 17, 2024 at 09:00:19PM -0800, Nicolin Chen wrote:
> > Allow a vIOMMU object to allocate vIRQ Event Queues, with a condition that
> > each vIOMMU can only have one single vIRQ event queue per type.
> 
> I suggest you should tend to use the eventq as the primary naming not
> vIRQ, I think that will be a bit clearer.
> 
> The virq in the VM is edge triggered by an event queue FD becoming
> readable, but the event queue is the file descriptor that reports a
> batch of events on read().
> 
> The virq name evokes similarities to the virq in vfio which is purely
> about conveying if an IRQ edge has happened through an eventfd and has
> no event queue associated with it.

Ack. By doing the "Part-3: vEVENTQ" specifying one type of queue,
I think the Part-4 then should be "vCMDQ" likewise v.s. "vQUEUE".

Thanks
Nicolin

