Return-Path: <linux-kselftest+bounces-44131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D700C0FADB
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 18:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E89464F5A00
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 17:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397713168F7;
	Mon, 27 Oct 2025 17:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QHXJ8Y51"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010016.outbound.protection.outlook.com [52.101.56.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF623164DB;
	Mon, 27 Oct 2025 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586419; cv=fail; b=gLvSlEgywQgrOSUSsBXn0tGaDdbE75bmaOzBQNXY/kMbqj3+o+XRD1DryFvJj9mjSjMpll15mIAP9oDJ7YHihq0z1KRz2VGcagv4JVT0xf6dZTF/SrIgLZQiFDAjvPU9pgih3uhdu0Dmdzfqn3gcvUluv8eNgs5w+KhwzrIGktk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586419; c=relaxed/simple;
	bh=Ph5WA8Xxx5eR+ZWZAEPYF4KblHFBH9Zn4VPimvdfxeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dDD16qMeDI76tUTK+sU8+6iXjVp0G7XayR29Cn/V0mj58MLB/JMYvp8cIV2bTvcSia98g1e/zSc4+B8ODC6hrrw8V7WSbg6PeMds7tRCGfMsmv7jHtLDx+JpBRMOjStGEJts9j6ZIJFB5ijtZMep1p7BUvwPnlVse3LKbbWra88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QHXJ8Y51; arc=fail smtp.client-ip=52.101.56.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnMFvGOjou+3YyYTEUFEdDvgcDBNamUAOeX2NfGtZOdnNqM8GI9I2tLmUNcUHMDM/iyG9UIH4Tx/dn1XBe78me4HW1sk4PDKtKQ8/8Fpxe+G0DjA6grvZLRPt5RtGvYJ/JVr8qz0aJ3sGFB5MGliM/cmephzKRtQb9kXqX+Mrz7jphgD8iYD4YNUmU/0ojoJKJSn6f9wWyh6Paf62ibsY3Gf52EgrM0QbqEv7rM1pn2MqTjDjGZWw3T9BvQguGTfqUMQ002RTeJMU0BNKH11nXAbv37ySantyDAcknMC1T14MX4tfv6lJSWoNCsZWdOBAu/uT2c6NyQZCl3duhxBFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rA6i5WZZ0vXvPBXwavi9FHzIV2TK/4LE5bCeCvaNrlg=;
 b=XdV/yjttHZhafZxZ9FZgOAPRtDoygpscS+/JHx6Y72Ft9WQsSPPKUjQ0tU0TkK5wabh4YpdIMxfKe7Fx6xymBowyhXAbeCOAuopnwm9b+2Um7KlKDwhPH90s3ZP4S5O+D1ebp/nrXiRGF3mDRKzjUFs/V8Qy/7L3ColS+hoAFm26oabvkeh9DRNscnHP9x7JAHnITmBDTyLEJc/k8/51HkMDmL8BMldeABJDLqnLbdt3EiJe4Noe2Rangklx8zdFWfw4pP096Q4oKlMsrrHDktUSQS3llyquz4rX3br0Ybk3esQXKVYLF3d7pubTQMRDZFw3cQE9+Ij65Ql5HjhSYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rA6i5WZZ0vXvPBXwavi9FHzIV2TK/4LE5bCeCvaNrlg=;
 b=QHXJ8Y51odBzlVEiN9j2MCeZkH7ja063djoid4aK0CGf52A2wmIsRqkoakiGz0ne5uxy/2KvilB949fELhLKaJn/kZFSIHuDvkxismiWyLX4jtdIOS+xpZAXGlKfAd2hLCtD6pA6S8K+lgL4B3KOJgOwl+dmo6FyovAc7TxOZ3gpmWi/loUYfx9XhqVKvzOq3VEHYoVZrk0xRHnyBj2474aCB+S+8hn0W8BiitRw/NFG0O3QNhuV0LbWlkoqj6e0GEkcldAG3DzHW5izMKRtQ9Nm/KJdmMo9zx20BUFcdE5Ex/bg3n1m559jzvpzKy2IQOdfh1PV94aALZqeTxn8+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by BN5PR12MB9539.namprd12.prod.outlook.com (2603:10b6:408:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 17:33:31 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 17:33:31 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Will Deacon <will@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	patches@lists.linux.dev,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH 3/8] iommufd: Allow a DMABUF to be revoked
Date: Mon, 27 Oct 2025 14:31:02 -0300
Message-ID: <3-v1-64bed2430cdb+31b-iommufd_dmabuf_jgg@nvidia.com>
In-Reply-To: <0-v1-64bed2430cdb+31b-iommufd_dmabuf_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0054.namprd02.prod.outlook.com
 (2603:10b6:207:3d::31) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|BN5PR12MB9539:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e854b77-0c16-4560-ac86-08de157ef281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G4fVqDtoIjq5mRSCf7haBVcBdnT50/G5r35ULPFnJS7zdaPZ6c9oCRzcPU4J?=
 =?us-ascii?Q?xwv/U2xdqXpX1q1HEunNd5BiXEx/0F62SufHIo/pzxpd4+SDUENLeKmpGnFu?=
 =?us-ascii?Q?mG6dim8XTJKqGXy0x4xt+84AABuZRmpVReWnsYpOEW4le5GwVYDap0qDLvcE?=
 =?us-ascii?Q?Jw7uhDEkysS7T0u4warnd2un9ab8Pm6LyY6tPYyUvTK6q77kDjfA9V1wpuuv?=
 =?us-ascii?Q?7yfyVlB/huiUz9jS8IkR5wFecJi/1CL3/CXd3787ZAKLX6Bx+tio3qX9aEOM?=
 =?us-ascii?Q?Qx8bNbOMCyFdKAIFXfFFZxqnyIGPPvKyQ6UAmqg//8WzWv/OAab4UAcaAcWO?=
 =?us-ascii?Q?L435Mkfy2KBlaTHJjpoVj+o1NBY6BzfJSlNfYE5XtBdRKSB0zvTGaD36M3fR?=
 =?us-ascii?Q?XZTDs2RqGsPC7SK1hLjlOO2RnYeZl9Syax32iUZimUiINI23xJT7VwErU/sh?=
 =?us-ascii?Q?0ioqV/EBzlbaODx2j/cvoj/GB1gBVQm/I5j9VDgzEW0x2Ri9J4lGZIuJRA+H?=
 =?us-ascii?Q?hy4go/gWF/KSu014ZRt4k4IfCZBaebvwp50ykZ/JZtRsG1kTleB9GMIDtz1/?=
 =?us-ascii?Q?syxLeIHBNes/lB/W6kM9YvrUWKyE0On9W/jFWfd/BiMUXgG7Ns4ZchIYDQkx?=
 =?us-ascii?Q?Wc1RArRYM+OJ0wmJ5BEqb3bcoP5b0AiuMzu31HHv9A6Jd1UVh7WyqMujJMZj?=
 =?us-ascii?Q?WZ0PnHvIjgrWx41WGdIMh6jbUQSqVwSH6urFjiBGsyFzJS5CPln4guzDEI7T?=
 =?us-ascii?Q?mwb3BGRrV4h7Qcf5W6WtjH+ekI6LZanRZeK0t6ZCVdk1AQZKh84n0dfd7tmo?=
 =?us-ascii?Q?h6mrgy/8fTqMBf5P8khruLmRqF0S/8pfbPsPxFEXbh4SQQUv5NDInQCi0024?=
 =?us-ascii?Q?9dVPy20lqHl8DRutcL8S4mC1x0E6ZRpTiKd9YiuEoTewk++m3fClwHabvtri?=
 =?us-ascii?Q?dI8nP6U8gupLmK5nFfQB9iTZhbtO5QR3Du5HONWFBVSeGvj5nn+OrXe7dp1Y?=
 =?us-ascii?Q?j7Yazu6SqvUsoNb5r4Vkz9kBjCiRoSV1U6tj7pmTghecbevbKfGGI6ItI2Ci?=
 =?us-ascii?Q?xjXxosEnJ0m90lmejbXsLaM1rKJpJDiKjVEZUHWJ0R9ydH/V3rrpwRQ+1BVz?=
 =?us-ascii?Q?3a42kMfrIo32Jh7aC/abdzFr+57wZKsgPSckR4Agrh9h50syOMf02u5W11ks?=
 =?us-ascii?Q?r3txTJ3z9dm546Era2BMkeKR310GRGzOR8zAj+d4oL0GrffnO9dr/mX27/80?=
 =?us-ascii?Q?E4qPJnKmtlvw9qDPxxJuZ+XU5Q6GN65vbnPDA+za3qw12ndbK2+snxxxBI/3?=
 =?us-ascii?Q?nKK6GyrK3ZkJ9i0TIubz8v/azdaY3zvrGlvkZI6Mcq5mlLsTxoS13G7B5d0Q?=
 =?us-ascii?Q?ez8T5yjTswTikBQ9t5gkqpcL9bpWbYgn5HwAd/A6a4+UFLa3fvP2KInQJWfo?=
 =?us-ascii?Q?wolsWNEwCSmNrAhBDmdMYfK/12rYEhdcqWd/xpM4vwKiaMCB+F2rRyvCELsy?=
 =?us-ascii?Q?a/agItmF2OHC9WE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sEBk4Klpk7ZPdVKnGUNJffXGJwWcnUHZRlWG2/QeAWcB7ooAv5bnbdhM0VJ5?=
 =?us-ascii?Q?soJHqg//4KHwrpFPZHCFVh9z3c1uKaahuHE+kXThj0WvWjeUjftzRrGvw0K+?=
 =?us-ascii?Q?u2fV4EV1uN6jvZt8kd/mKMXhKCd7pzjL9GtWAdQjpsKziT44jvNwejm/PNJJ?=
 =?us-ascii?Q?74jWtSi5kuYQzpGYVm3US3QjSdeScmeeuvIgpTu6o/CbDaLR2kqoo9izM4jD?=
 =?us-ascii?Q?WZBjajsO0cz9qBBGyomsQm6NcXhg/kq/7xuoQI3Pdehu6ykX2UYcwZJ//0l9?=
 =?us-ascii?Q?zKwkcfCZD5as89YIwDyUDCTeE/tepbbun43bDPrUdKZT1lU0SqUhRXg7edTC?=
 =?us-ascii?Q?yo3q94qQzY9qKQX7aQ1awfIvHms98fPsaX+Xdtv+2cciEcvaFAlfsfbmx15w?=
 =?us-ascii?Q?ZxL+xoSCPE8TzHYDQKteCW2N6J7uKGHNGSaHNCw4f+BCb13MzamObhHX3h86?=
 =?us-ascii?Q?vhH5vJXDx400OMqIitohylfvCrlbzr/B4tpiE+4V4QAsH7g7PQg+ym9IZRjp?=
 =?us-ascii?Q?PlO1HD+svtJt9KfFhMJfqdGsfq7xHuia3lSZiQIemhzNq4yV1oeIRlyLBY9D?=
 =?us-ascii?Q?8kYgLAcWKE5fFsFxFuWcmFr7tFY9TqJfo+/BKztSFSXhDlYTt5I/ot3vwW+3?=
 =?us-ascii?Q?FBXy0kgiilU2fxXhKyQR5sjDiYqddVIhupv7l/YuUeMIbV29s/Eq8uToxdvO?=
 =?us-ascii?Q?MFZ8EyjzJpAXZYMm0RyivwtBxOgRTI0691GeGoc4vgXbVXf+erUKeaTLyA/4?=
 =?us-ascii?Q?jCNrpun4Vv+RpK88cKmwTsvK911cMCnkFzrg2cwcPzPGONYivQKqqZAn0dC2?=
 =?us-ascii?Q?kfd0nnu2WlhkTOT95YaplaVrINwYdEAOUB9Ow+gcWWjzkVbkTWQsFZ938H3t?=
 =?us-ascii?Q?0FLM2h95Heo3A7tJ915FFZfZDu6GhkE4UBJZBtjcYyEG/+z9DcdRxCwk8Z4r?=
 =?us-ascii?Q?ijuljHeiua/jlGAemRcDKyOm/L0GQqM+CdeyDJiow3ud38l+RQ0EoVQJKkDj?=
 =?us-ascii?Q?DrEs/ieWrJvpyA1FZrK7nwoWYQLGbrNRKLHZZI1F3rxX+y4QiN+icAUHpgd2?=
 =?us-ascii?Q?7/4pPbo2Z2S2N/4I8qEqcBBJCl21nM+rOGku40nyo+kX789qkVUbHQqhz0jB?=
 =?us-ascii?Q?PpA1PcGPPhNyd2RJzpgIV6y/VkvkumYdpiHRSF4u6/8WAN3OMkoQXeXcXdRP?=
 =?us-ascii?Q?/jP3v9y3QCN896l7g7ZSmZWmaHU+HAXVaa7VVU0YeOXGLCQuU0v/MgIPkHab?=
 =?us-ascii?Q?MZnCDEJdxXGb/pp/+0DcXywQoWYXW5Yt6kbpMNg6JrsAsXnZLTvFnsHNSHU6?=
 =?us-ascii?Q?JjO0FDRojeJVfTeIVrPZAM7Wg3HlT3izWQFVi/UBAtDghBxirNOSN1fOjqrg?=
 =?us-ascii?Q?AO5NOt4r3VnI0jsTVfmddnePB/Yh6MTw7+ewCKc9moU4lGV1W3MkJI3OmP2l?=
 =?us-ascii?Q?ZmUajFxo3A8LHkUQKcI+0VEOTOzr81G31H88kZYTolDuoIDtYSM6qD09Y/M4?=
 =?us-ascii?Q?JSC5fCyrkLF5QbQY5fw4WCATmS4y35VLLd5RIUVeDBnPk9gwMo3EZS9JhbJe?=
 =?us-ascii?Q?kNvw7WwoXBDc1LQU4Jw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e854b77-0c16-4560-ac86-08de157ef281
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 17:33:31.5932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: az7PFpUrwaEUDvK6vLTKX6QSOKxilYBHUeh1T/BrRE+N40dUVSN5VFztvTTIctp6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9539

When connected to VFIO, the only DMABUF exporter that is accepted, the
move_notify callback will be made when VFIO wants to remove access to the
MMIO. This is being called revoke.

Wire up revoke to go through all the iommu_domain's that have mapped the
DMABUF and unmap them.

The locking here is unpleasant, since the existing locking scheme was
designed to come from the iopt through the area to the pages we cannot use
pages as starting point for the locking. There is no way to obtain the
domains_rwsem before obtaining the pages mutex to reliably use the
existing domains_itree.

Solve this problem by adding a new tracking structure just for DMABUF
revoke. Record a linked list of areas and domains inside the pages
mutex. Clean the entries on the list during revoke. The map/unmaps are now
all done under a pages mutex while updating the tracking linked list so
nothing can get out of sync. Only one lock is required for revoke
processing.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.c |  12 +++
 drivers/iommu/iommufd/io_pagetable.h |  17 +++++
 drivers/iommu/iommufd/pages.c        | 106 ++++++++++++++++++++++++++-
 3 files changed, 134 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 38c5fdc6c82128..d0539bbd6771ea 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -973,6 +973,7 @@ static void iopt_unfill_domain(struct io_pagetable *iopt,
 			if (iopt_is_dmabuf(pages)) {
 				if (!iopt_dmabuf_revoked(pages))
 					iopt_area_unmap_domain(area, domain);
+				iopt_dmabuf_untrack_domain(pages, area, domain);
 			}
 			mutex_unlock(&pages->mutex);
 
@@ -994,6 +995,8 @@ static void iopt_unfill_domain(struct io_pagetable *iopt,
 		WARN_ON(area->storage_domain != domain);
 		area->storage_domain = NULL;
 		iopt_area_unfill_domain(area, pages, domain);
+		if (iopt_is_dmabuf(pages))
+			iopt_dmabuf_untrack_domain(pages, area, domain);
 		mutex_unlock(&pages->mutex);
 	}
 }
@@ -1024,8 +1027,15 @@ static int iopt_fill_domain(struct io_pagetable *iopt,
 			continue;
 
 		mutex_lock(&pages->mutex);
+		if (iopt_is_dmabuf(pages)) {
+			rc = iopt_dmabuf_track_domain(pages, area, domain);
+			if (rc)
+				goto out_unfill;
+		}
 		rc = iopt_area_fill_domain(area, domain);
 		if (rc) {
+			if (iopt_is_dmabuf(pages))
+				iopt_dmabuf_untrack_domain(pages, area, domain);
 			mutex_unlock(&pages->mutex);
 			goto out_unfill;
 		}
@@ -1056,6 +1066,8 @@ static int iopt_fill_domain(struct io_pagetable *iopt,
 			area->storage_domain = NULL;
 		}
 		iopt_area_unfill_domain(area, pages, domain);
+		if (iopt_is_dmabuf(pages))
+			iopt_dmabuf_untrack_domain(pages, area, domain);
 		mutex_unlock(&pages->mutex);
 	}
 	return rc;
diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index 759ebf66265df5..2d5b8778735a56 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -70,6 +70,16 @@ void iopt_area_unfill_domain(struct iopt_area *area, struct iopt_pages *pages,
 void iopt_area_unmap_domain(struct iopt_area *area,
 			    struct iommu_domain *domain);
 
+int iopt_dmabuf_track_domain(struct iopt_pages *pages, struct iopt_area *area,
+			     struct iommu_domain *domain);
+void iopt_dmabuf_untrack_domain(struct iopt_pages *pages,
+				struct iopt_area *area,
+				struct iommu_domain *domain);
+int iopt_dmabuf_track_all_domains(struct iopt_area *area,
+				  struct iopt_pages *pages);
+void iopt_dmabuf_untrack_all_domains(struct iopt_area *area,
+				     struct iopt_pages *pages);
+
 static inline unsigned long iopt_area_index(struct iopt_area *area)
 {
 	return area->pages_node.start;
@@ -184,10 +194,17 @@ enum iopt_address_type {
 	IOPT_ADDRESS_DMABUF,
 };
 
+struct iopt_pages_dmabuf_track {
+	struct iommu_domain *domain;
+	struct iopt_area *area;
+	struct list_head elm;
+};
+
 struct iopt_pages_dmabuf {
 	struct dma_buf_attachment *attach;
 	struct phys_vec phys;
 	unsigned long start;
+	struct list_head tracker;
 };
 
 /*
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index ca27ad3a3168e5..463d6340de1dcb 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1366,8 +1366,19 @@ struct iopt_pages *iopt_alloc_file_pages(struct file *file, unsigned long start,
 static void iopt_revoke_notify(struct dma_buf_attachment *attach)
 {
 	struct iopt_pages *pages = attach->importer_priv;
+	struct iopt_pages_dmabuf_track *track;
 
 	guard(mutex)(&pages->mutex);
+	if (iopt_dmabuf_revoked(pages))
+		return;
+
+	list_for_each_entry(track, &pages->dmabuf.tracker, elm) {
+		struct iopt_area *area = track->area;
+
+		iopt_area_unmap_domain_range(area, track->domain,
+					     iopt_area_index(area),
+					     iopt_area_last_index(area));
+	}
 	pages->dmabuf.phys.len = 0;
 }
 
@@ -1468,6 +1479,7 @@ struct iopt_pages *iopt_alloc_dmabuf_pages(struct iommufd_ctx *ictx,
 	pages->account_mode = IOPT_PAGES_ACCOUNT_NONE;
 	pages->type = IOPT_ADDRESS_DMABUF;
 	pages->dmabuf.start = start - start_byte;
+	INIT_LIST_HEAD(&pages->dmabuf.tracker);
 
 	rc = iopt_map_dmabuf(ictx, pages, dmabuf);
 	if (rc) {
@@ -1478,6 +1490,86 @@ struct iopt_pages *iopt_alloc_dmabuf_pages(struct iommufd_ctx *ictx,
 	return pages;
 }
 
+int iopt_dmabuf_track_domain(struct iopt_pages *pages, struct iopt_area *area,
+			     struct iommu_domain *domain)
+{
+	struct iopt_pages_dmabuf_track *track;
+
+	lockdep_assert_held(&pages->mutex);
+	if (WARN_ON(!iopt_is_dmabuf(pages)))
+		return -EINVAL;
+
+	list_for_each_entry(track, &pages->dmabuf.tracker, elm)
+		if (WARN_ON(track->domain == domain && track->area == area))
+			return -EINVAL;
+
+	track = kzalloc(sizeof(*track), GFP_KERNEL);
+	if (!track)
+		return -ENOMEM;
+	track->domain = domain;
+	track->area = area;
+	list_add_tail(&track->elm, &pages->dmabuf.tracker);
+
+	return 0;
+}
+
+void iopt_dmabuf_untrack_domain(struct iopt_pages *pages,
+				struct iopt_area *area,
+				struct iommu_domain *domain)
+{
+	struct iopt_pages_dmabuf_track *track;
+
+	lockdep_assert_held(&pages->mutex);
+	WARN_ON(!iopt_is_dmabuf(pages));
+
+	list_for_each_entry(track, &pages->dmabuf.tracker, elm) {
+		if (track->domain == domain && track->area == area) {
+			list_del(&track->elm);
+			kfree(track);
+			return;
+		}
+	}
+	WARN_ON(true);
+}
+
+int iopt_dmabuf_track_all_domains(struct iopt_area *area,
+				  struct iopt_pages *pages)
+{
+	struct iopt_pages_dmabuf_track *track;
+	struct iommu_domain *domain;
+	unsigned long index;
+	int rc;
+
+	list_for_each_entry(track, &pages->dmabuf.tracker, elm)
+		if (WARN_ON(track->area == area))
+			return -EINVAL;
+
+	xa_for_each(&area->iopt->domains, index, domain) {
+		rc = iopt_dmabuf_track_domain(pages, area, domain);
+		if (rc)
+			goto err_untrack;
+	}
+	return 0;
+err_untrack:
+	iopt_dmabuf_untrack_all_domains(area, pages);
+	return rc;
+}
+
+void iopt_dmabuf_untrack_all_domains(struct iopt_area *area,
+				     struct iopt_pages *pages)
+{
+	struct iopt_pages_dmabuf_track *track;
+	struct iopt_pages_dmabuf_track *tmp;
+
+	list_for_each_entry_safe(track, tmp, &pages->dmabuf.tracker,
+				 elm) {
+		if (track->area == area) {
+			list_del(&track->elm);
+			kfree(track);
+		}
+	}
+}
+
 void iopt_release_pages(struct kref *kref)
 {
 	struct iopt_pages *pages = container_of(kref, struct iopt_pages, kref);
@@ -1495,6 +1587,7 @@ void iopt_release_pages(struct kref *kref)
 
 		dma_buf_detach(dmabuf, pages->dmabuf.attach);
 		dma_buf_put(dmabuf);
+		WARN_ON(!list_empty(&pages->dmabuf.tracker));
 	} else if (pages->type == IOPT_ADDRESS_FILE) {
 		fput(pages->file);
 	}
@@ -1735,11 +1828,17 @@ int iopt_area_fill_domains(struct iopt_area *area, struct iopt_pages *pages)
 		return 0;
 
 	mutex_lock(&pages->mutex);
+	if (iopt_is_dmabuf(pages)) {
+		rc = iopt_dmabuf_track_all_domains(area, pages);
+		if (rc)
+			goto out_unlock;
+	}
+
 	if (!iopt_dmabuf_revoked(pages)) {
 		rc = pfn_reader_first(&pfns, pages, iopt_area_index(area),
 				      iopt_area_last_index(area));
 		if (rc)
-			goto out_unlock;
+			goto out_untrack;
 
 		while (!pfn_reader_done(&pfns)) {
 			done_first_end_index = pfns.batch_end_index;
@@ -1794,6 +1893,9 @@ int iopt_area_fill_domains(struct iopt_area *area, struct iopt_pages *pages)
 		}
 	}
 	pfn_reader_destroy(&pfns);
+out_untrack:
+	if (iopt_is_dmabuf(pages))
+		iopt_dmabuf_untrack_all_domains(area, pages);
 out_unlock:
 	mutex_unlock(&pages->mutex);
 	return rc;
@@ -1833,6 +1935,8 @@ void iopt_area_unfill_domains(struct iopt_area *area, struct iopt_pages *pages)
 		WARN_ON(RB_EMPTY_NODE(&area->pages_node.rb));
 	interval_tree_remove(&area->pages_node, &pages->domains_itree);
 	iopt_area_unfill_domain(area, pages, area->storage_domain);
+	if (iopt_is_dmabuf(pages))
+		iopt_dmabuf_untrack_all_domains(area, pages);
 	area->storage_domain = NULL;
 out_unlock:
 	mutex_unlock(&pages->mutex);
-- 
2.43.0


