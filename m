Return-Path: <linux-kselftest+bounces-45131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 267D6C40F04
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 17:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C0618983BC
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 16:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD376335BAC;
	Fri,  7 Nov 2025 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aSeuqrr2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3857335064;
	Fri,  7 Nov 2025 16:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762534195; cv=fail; b=gNk/2kSGcbD4lBqWvgQWig83jS+MBOABKhLtQPEZT6HA9m7Pwl5nmQCX2JLk5qa9sRzA/pCK/3WDiMS2bFIFuGJhkX4ix/XSnK8csBNlqCzd+6nbx8pPCvcIWejKlI+YLzm5rgrFvlJVS/re1a/5hsIOTf0HWeTLNYXVuOyAgM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762534195; c=relaxed/simple;
	bh=uzgR8EC+M3+WE0w+OOpa0Lx8BxhJvC3IFeJrkqkYFyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b2CtnIZb4wx8nn4tFklEVyP6thfXezbpfjR2GpAexs0LRp0paMjV+LJLIvT/WxSE63ivKkekHPfJrqsyr+kMI0HdxC6zulVfxkHXL3pN0o7r8612nwVjXJikUfwMECBKdUaTyi8qQWJC/mY0zQcv+tw+9eFHNPtiG2IQlBlWWB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aSeuqrr2; arc=fail smtp.client-ip=40.107.208.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAe3QsB51LMyn935DrXMH40Mrjg7ybPZNktB5fxGItAKBwrm6CIbJYXDM+TdB2rvQ7vS42rrRNvKJdx4is30J4SKC4vzZAfHCj7E6m1MduRM8Iv4KvggCFL7mBK6J3KuP9AwaATQj1gvT6l3Ue5hftZ8/fyRSOk3p164NNq1tjSKO2deobKekb5kQoYHDIPo+51QMie4xDglKVyb+xu31fkkFms0nOb/fHlcpTZShHGjP7E33pAbsuMHSfWbC9AkbkgIZtVBXYlqcDTsDiaYFvjm4woVsgzt/93DIeabe1RgzfT8pW6aQdR8wqZk/qgEdqSGfYn5cjJst5eH/XMxxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caFwRKL3s2okpUFXhRVV9pFDpA7yEaogjDMcwAPDmbM=;
 b=lJ1fyCnHvh5tv1nnNCueiMIqD24eqwYFwo4XW5R6sXPFzmfNkpLooXjRM/BTSZe8vCJlhLzMsm14Iq/4M1C1lOWUMuD8EXLDWSBIr1CRokCO3zoteL8284RGAaeqQeHSC0dKtxz+AsJ7AHtXFhG5bMcs6CcpQnZNjOa5jtMcliXIxnsg4a12wxpHIJ0LKJchG1mV5yCaJi5rpfDEy9tArYKAA+quZYQPDigLXLN49vhDF5sjS2NvlD6n8soHCs/0XoBGHZpMDGEhjJ+gIk1mkLC4IHUb4VEDE1OhL7c/v1+MfWwmZdU463LYcm/B2ackXoOK0gT+1L1foqFlB92whA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caFwRKL3s2okpUFXhRVV9pFDpA7yEaogjDMcwAPDmbM=;
 b=aSeuqrr2Q5Pb9oS8orhG8K3Pfb6L0BFer6vgc5vUSfSbsvubvaJIG1B7QOKXu1tiIgibpGeQBSwU11sn3vmd3faZplDOE2ULjdsF/O8q1yeHN+1dVX32L357hq1TCvmX6D1nftZ+fMapABJMDoPAInCdndqS+oT0DW4ORmq/4ZKRT2xid9CqHV/DhJGofpb47FMKd1eFcb07CCAP4SjE5srbQ/Gf9/K7c3hPsvduAU0NyYz4HHI68eThj+16hiJEARwIyX57drVcGc49Lgu/5YOCr/ta8UGH+kT0D0pnRg0crNQ0onLPRTYlE8G8FESye5yzGYfhqddDvQSqANKlkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 16:49:45 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Fri, 7 Nov 2025
 16:49:45 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	=?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	kvm@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Will Deacon <will@kernel.org>
Cc: Krishnakant Jaju <kjaju@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Matt Ochs <mochs@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	patches@lists.linux.dev,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH 2/9] iommufd: Add DMABUF to iopt_pages
Date: Fri,  7 Nov 2025 12:49:34 -0400
Message-ID: <2-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
In-Reply-To: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0138.namprd03.prod.outlook.com
 (2603:10b6:208:32e::23) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|BY5PR12MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: b8d963ad-7849-4539-b5d7-08de1e1da64d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?unAFFFbuqbwPlD3BoXHDzp8PdmTn34pqUWh2G9TUcEq7fNd7nYDpKWlAEcQU?=
 =?us-ascii?Q?YrT1aw1/0uCAWKi1taZS2g2TTC7fZuH/ifjmrXyFhfAZe8tqUeRYtnIqUEEA?=
 =?us-ascii?Q?dHm2PnngLefxodR79roWIeHbKenwMWuk3OJX1uJwMbnkY/3VTMyJwhxsztFY?=
 =?us-ascii?Q?iJkvyCATvd4eZdLRTtClh1PCOas+8UmSCt80+LcKSjhgM/ynvHWdMKs1ke32?=
 =?us-ascii?Q?jHpP9mEh71a0W+dg9w9kjreuaR1zGbypRGxPX9LMnEzb2M3O1zf2r/i1hxYJ?=
 =?us-ascii?Q?cn4dRtufStP8Cl4lI0ocm8M05cBQjfE6xatnKs90xx/D48kbQjgkbYYyBBxk?=
 =?us-ascii?Q?XUf4gNoXCagFB4ZO3/2WUdR0/ryeikuJ6VvhV73J56bkMLzdmgLDAod7Bkbb?=
 =?us-ascii?Q?6WC9gdgH8UAvpIEqzS42cLml3o4Hk4vvKaDpHMl11G4FT+3ZnHh/+E5JsL+m?=
 =?us-ascii?Q?D55vd5o199vK6wZwI8uD2ahFTb+JQeqt4sfAYcrAFmZEoWE40RcPSV6a83Sp?=
 =?us-ascii?Q?8EiGgGimZjIDDfOKTI6a+D6/jtj57N0l0xovhie4neGomnKiHzhX6Hy4NT1C?=
 =?us-ascii?Q?Sg+s4D0tihaYRUmRQRSPiIkBmbwWozPW+GPcBQ9rGLQ9FFAArVrrt2523rln?=
 =?us-ascii?Q?IHZ50uUHZupFUL/6mn1orHji7o5qdSagkq1Egh9fMW6eb91bctsw2lY2VmwZ?=
 =?us-ascii?Q?BNgx4TPTQGn34XbO0ql9LVkYMmPu+1t9x5I2QUOUwzVy3omwMWesvJiYKSgg?=
 =?us-ascii?Q?b+jzzS5IUcOXfPO4LlQvJjYnVg3JtRa+0f2fyDFbI+oi+cYNlVj2AsGMpauW?=
 =?us-ascii?Q?yX4b4TAWHyBE5TzVfYQI+bRMOhV5WoSZCtt01IpQ7HwSGJqdiZh+YqQagfP2?=
 =?us-ascii?Q?mi62FFL0Lc9H2luKHJra0o/s96hh+CONW51QP6a2uoS7Cot4LbU88KEWR0nF?=
 =?us-ascii?Q?2CuItEid3pzQlE+SUFax8nrSosSJrA7dRmpZZMhd1ViHSXLBlJzmmlJ7nCnr?=
 =?us-ascii?Q?XqGwT9ovJ6CQw/lECwNCy7ayYORP7Iz9AnfKJUK7lSv+QIgl7+/ORiQWyymX?=
 =?us-ascii?Q?c4Jd9VzMxwOYS0BCWBHo6yGrFdbvLIaUwiyC4RQPwdPoEQoB1dDBp7gijFQk?=
 =?us-ascii?Q?EonKXVhG5HlBk5HJ5UdYNkUiy994CLO7moIufNgDI+44fPgTy97sZtPRGao0?=
 =?us-ascii?Q?h1PHKHO0L+pt4sJPAqKjaEw+S7DLrYaDAVJyY/oBsKFdVdh+UEolCQmAq5Ml?=
 =?us-ascii?Q?tWVJskvtAmN6+U9lOcTKL5TN9VjBeK34YXtovi+pZAFV9OOOE9y5WyRz6od0?=
 =?us-ascii?Q?SEnh6mXGRkKdoGokd/cEHzJ4byZbt9uw1v9y/kkRyZDRLZixrI7T2yaaf9lv?=
 =?us-ascii?Q?+8aDiNn9UtGPF2w04kxMDqudSQMZe6EyYGDszNThluAEqQN8SNRBUDkYjl0H?=
 =?us-ascii?Q?UpStGOc9TcWOhDg/X8fUFtYb8XbhVhS2UQ36F7eUjlAAGQSo7DU4tdXHGNAp?=
 =?us-ascii?Q?4vZvYWm9rHDyVVc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uzCVsv9/p96B3XeCe2KSNKeNIWplFfi3Z4+HBCVljzKIqMIvFi3waztCRfnL?=
 =?us-ascii?Q?hiYHg8b9LMiacRuW6BLzIySo7gIACtEUg+4S+mCiS4Q1A3miUMHplOIMy5xU?=
 =?us-ascii?Q?aoLUnig10qqVPDNgZAXPicS8D4XO3kFX5Cw5whrzJ/r4I/uciAepAo87ucOd?=
 =?us-ascii?Q?2d2+0uQfZtqo5eyrEgVmL8dp+zd1M+ISIvaGMONTCFqheLzHJWDsdRgJfSxi?=
 =?us-ascii?Q?tOQKBb862OeuqR/7sCpwxPD52U9Rl0gA0w/I6tuy5AUn/ARfuvb+RWN2GZFz?=
 =?us-ascii?Q?jWRQv5ZYYEQ+ZtXMfv7sFv6BocmylB6hNW8O0rl6Bi+16i1wlYIP3CZq31Xd?=
 =?us-ascii?Q?d16Zlxq6nL0M9HHX+MKYhzFkez0sOMeM3ustKW3XTZU7vtCaB+Ku9thWNw9i?=
 =?us-ascii?Q?5YVer25YJl81uc8HNAD+DZ0jI2g7uoZzhOSfjpnYY0oWwdBxdgesxKPJBL/C?=
 =?us-ascii?Q?pWX/lMMhgeo2hpUq9YbwPYzbAz+wnss5L0iaRp3n5T8yOLZKCfF91pQYfqn4?=
 =?us-ascii?Q?bPum/WwDCGpopX2pCmmVDb0buprWm/AbomMhbdcID0uhMSPa3dwfzAEP5X5k?=
 =?us-ascii?Q?PK6OMQaLVVVpBk0LHhIUZ4TFWteEe0Ohmcr3MrzulmQwontzLm3z2V3Qg2A3?=
 =?us-ascii?Q?Y9bg51Eb7QgDQBV7Hu4SVoxh+Fx6ZHU+O86yI5qMTtEbRg9KZmh4fC6Wli2x?=
 =?us-ascii?Q?bvOE/qlzQo7KIOz+pPOFoLs8nMTAx8dOkcG2oKkHPNo7ATtcCvjaCN9JFq4V?=
 =?us-ascii?Q?M84ubeTYHeP3CgfBssHf0ISQ5sNW++WJdxGH1FeAAJMV/gIqyl9qN1TykKoA?=
 =?us-ascii?Q?8+wdo2tO2cIRtCyfhkY6wDppHLoBMCGtAU54yDWvgC3CdXytRVsN7OGkG1np?=
 =?us-ascii?Q?9Ct+cSx87zW3QSfw/r+uGC4Lr7d1fKapKitc0C9D/a8aors7qSHBhgVBPirW?=
 =?us-ascii?Q?SJ1cdr3X47Q3qo8jhEWPfMsBjtfjpLXs4SPR7dZwe/IzMdiVFd0RjI5IKRjB?=
 =?us-ascii?Q?Cydmrq646eMUCi6Grm4xEbS82YzqCVVuz+TVx9P42/ve/pxCdXkLpd/NA3sh?=
 =?us-ascii?Q?7G4qpXlQUyi/L7vTiMkAqP3YTck7+iSoEUS/L4A7SFsQj+UD8ZtI9ivVW1bG?=
 =?us-ascii?Q?/is/ZfpB3FF1FwmwM+tTBbCkOQCxM24mVy3t792+uNZrnmNbOPyk97Zj0BrX?=
 =?us-ascii?Q?HPoc1kbIO4/qZOu5QPplDR2Fx2OcZ9hBxZtkQ+Ortm9vsyRiLxbJtS+e8k7B?=
 =?us-ascii?Q?AZ7WWPi+3FuSeB+INiu6sBs9e4Q3KM21EgM1Wo/NTtejaBzxJq4nPIq/ikYS?=
 =?us-ascii?Q?9xkoWcnA8KjlHBioWBETL4zfNQ+/w9qYr4Uy9ghOtgWm7bOXj5vLk0KmM2XY?=
 =?us-ascii?Q?ZIQUDu07R+aYtzCpj16zCA5xfOT3KBpAmC8tw22ZoR2Z7WFzRwTyq1Y4CeWF?=
 =?us-ascii?Q?ZQLuqfxdZlMWfKIl2aWjlu2BJ4i0yzsLm+WuJ+HW+hk86j2XSSgss9b/Idee?=
 =?us-ascii?Q?VGLQ7hcoU/Go5nmpJ0dCSX76FdRv2QAz9DvPjORzES2pZOUaP/5gkkEKgVNX?=
 =?us-ascii?Q?TUH6sU7v8KkKCpm+Jvg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d963ad-7849-4539-b5d7-08de1e1da64d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 16:49:43.7884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfDV4Gwi5xd+GdjmMsXHEodOsjHt4FPwaTMMchRu6hxRZg3zbPdNB0js0o57Hd7L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196

Add IOPT_ADDRESS_DMABUF to the iopt_pages and the basic infrastructure to
create an iopt_pages from a struct dma_buf *.

DMABUF pages are not supported for accesses, and for now can only be used
with the VFIO DMABUF exporter.

The overall flow will be similar to memfd where the user can pass in a
DMABUF file descriptor to IOMMU_IOAS_MAP_FILE and create an area and
pages. Like other areas it can be copied and otherwise manipulated, though
there is little point in doing so.

There is no pinned page accounting done for DMABUF maps.

The DMABUF attachment exists so long as the dmabuf is mapped into an IOAS,
even if the IOAS is not mapped to any domains.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.c    |   3 +
 drivers/iommu/iommufd/io_pagetable.h    |  24 ++++-
 drivers/iommu/iommufd/iommufd_private.h |   2 +
 drivers/iommu/iommufd/main.c            |  10 ++
 drivers/iommu/iommufd/pages.c           | 133 +++++++++++++++++++++++-
 5 files changed, 168 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index c0360c450880b8..b3cf3825a88c7f 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -284,6 +284,9 @@ static int iopt_alloc_area_pages(struct io_pagetable *iopt,
 		case IOPT_ADDRESS_FILE:
 			start = elm->start_byte + elm->pages->start;
 			break;
+		case IOPT_ADDRESS_DMABUF:
+			start = elm->start_byte + elm->pages->dmabuf.start;
+			break;
 		}
 		rc = iopt_alloc_iova(iopt, dst_iova, start, length);
 		if (rc)
diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index b6064f4ce4af91..389e3c3c80f335 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -5,6 +5,7 @@
 #ifndef __IO_PAGETABLE_H
 #define __IO_PAGETABLE_H
 
+#include <linux/dma-buf.h>
 #include <linux/interval_tree.h>
 #include <linux/kref.h>
 #include <linux/mutex.h>
@@ -179,7 +180,14 @@ enum {
 
 enum iopt_address_type {
 	IOPT_ADDRESS_USER = 0,
-	IOPT_ADDRESS_FILE = 1,
+	IOPT_ADDRESS_FILE,
+	IOPT_ADDRESS_DMABUF,
+};
+
+struct iopt_pages_dmabuf {
+	struct dma_buf_attachment *attach;
+	struct dma_buf_phys_vec phys;
+	unsigned long start;
 };
 
 /*
@@ -209,6 +217,8 @@ struct iopt_pages {
 			struct file *file;
 			unsigned long start;
 		};
+		/* IOPT_ADDRESS_DMABUF */
+		struct iopt_pages_dmabuf dmabuf;
 	};
 	bool writable:1;
 	u8 account_mode;
@@ -220,10 +230,22 @@ struct iopt_pages {
 	struct rb_root_cached domains_itree;
 };
 
+static inline bool iopt_is_dmabuf(struct iopt_pages *pages)
+{
+	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
+		return false;
+	return pages->type == IOPT_ADDRESS_DMABUF;
+}
+
 struct iopt_pages *iopt_alloc_user_pages(void __user *uptr,
 					 unsigned long length, bool writable);
 struct iopt_pages *iopt_alloc_file_pages(struct file *file, unsigned long start,
 					 unsigned long length, bool writable);
+struct iopt_pages *iopt_alloc_dmabuf_pages(struct iommufd_ctx *ictx,
+					   struct dma_buf *dmabuf,
+					   unsigned long start_byte,
+					   unsigned long start,
+					   unsigned long length, bool writable);
 void iopt_release_pages(struct kref *kref);
 static inline void iopt_put_pages(struct iopt_pages *pages)
 {
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 627f9b78483a0e..10ee3510312132 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -504,6 +504,8 @@ void iommufd_device_pre_destroy(struct iommufd_object *obj);
 void iommufd_device_destroy(struct iommufd_object *obj);
 int iommufd_get_hw_info(struct iommufd_ucmd *ucmd);
 
+struct device *iommufd_global_device(void);
+
 struct iommufd_access {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index ce775fbbae94e7..5cc4b08c25f585 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -751,6 +751,15 @@ static struct miscdevice vfio_misc_dev = {
 	.mode = 0666,
 };
 
+/*
+ * Used only by DMABUF, returns a valid struct device to use as a dummy struct
+ * device for attachment.
+ */
+struct device *iommufd_global_device(void)
+{
+	return iommu_misc_dev.this_device;
+}
+
 static int __init iommufd_init(void)
 {
 	int ret;
@@ -794,5 +803,6 @@ MODULE_ALIAS("devname:vfio/vfio");
 #endif
 MODULE_IMPORT_NS("IOMMUFD_INTERNAL");
 MODULE_IMPORT_NS("IOMMUFD");
+MODULE_IMPORT_NS("DMA_BUF");
 MODULE_DESCRIPTION("I/O Address Space Management for passthrough devices");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index c3433b84556172..7bc4731501cc21 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -45,6 +45,8 @@
  * last_iova + 1 can overflow. An iopt_pages index will always be much less than
  * ULONG_MAX so last_index + 1 cannot overflow.
  */
+#include <linux/dma-buf.h>
+#include <linux/dma-resv.h>
 #include <linux/file.h>
 #include <linux/highmem.h>
 #include <linux/iommu.h>
@@ -53,6 +55,7 @@
 #include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/sched/mm.h>
+#include <linux/vfio_pci_core.h>
 
 #include "double_span.h"
 #include "io_pagetable.h"
@@ -272,6 +275,7 @@ struct pfn_batch {
 	unsigned int end;
 	unsigned int total_pfns;
 };
+enum { MAX_NPFNS = type_max(typeof(((struct pfn_batch *)0)->npfns[0])) };
 
 static void batch_clear(struct pfn_batch *batch)
 {
@@ -350,7 +354,6 @@ static void batch_destroy(struct pfn_batch *batch, void *backup)
 static bool batch_add_pfn_num(struct pfn_batch *batch, unsigned long pfn,
 			      u32 nr)
 {
-	const unsigned int MAX_NPFNS = type_max(typeof(*batch->npfns));
 	unsigned int end = batch->end;
 
 	if (end && pfn == batch->pfns[end - 1] + batch->npfns[end - 1] &&
@@ -1360,6 +1363,121 @@ struct iopt_pages *iopt_alloc_file_pages(struct file *file, unsigned long start,
 	return pages;
 }
 
+static void iopt_revoke_notify(struct dma_buf_attachment *attach)
+{
+	struct iopt_pages *pages = attach->importer_priv;
+
+	guard(mutex)(&pages->mutex);
+	pages->dmabuf.phys.len = 0;
+}
+
+static struct dma_buf_attach_ops iopt_dmabuf_attach_revoke_ops = {
+	.allow_peer2peer = true,
+	.move_notify = iopt_revoke_notify,
+};
+
+/*
+ * iommufd and vfio have a circular dependency. Future work for a phys
+ * based private interconnect will remove this.
+ */
+static int
+sym_vfio_pci_dma_buf_iommufd_map(struct dma_buf_attachment *attachment,
+				 struct dma_buf_phys_vec *phys)
+{
+	typeof(&vfio_pci_dma_buf_iommufd_map) fn;
+	int rc;
+
+	if (!IS_ENABLED(CONFIG_VFIO_PCI_DMABUF))
+		return -EOPNOTSUPP;
+
+	fn = symbol_get(vfio_pci_dma_buf_iommufd_map);
+	if (!fn)
+		return -EOPNOTSUPP;
+	rc = fn(attachment, phys);
+	symbol_put(vfio_pci_dma_buf_iommufd_map);
+	return rc;
+}
+
+static int iopt_map_dmabuf(struct iommufd_ctx *ictx, struct iopt_pages *pages,
+			   struct dma_buf *dmabuf)
+{
+	struct dma_buf_attachment *attach;
+	int rc;
+
+	attach = dma_buf_dynamic_attach(dmabuf, iommufd_global_device(),
+					&iopt_dmabuf_attach_revoke_ops, pages);
+	if (IS_ERR(attach))
+		return PTR_ERR(attach);
+
+	dma_resv_lock(dmabuf->resv, NULL);
+	/*
+	 * Lock ordering requires the mutex to be taken inside the reservation,
+	 * make sure lockdep sees this.
+	 */
+	if (IS_ENABLED(CONFIG_LOCKDEP)) {
+		mutex_lock(&pages->mutex);
+		mutex_unlock(&pages->mutex);
+	}
+
+	rc = sym_vfio_pci_dma_buf_iommufd_map(attach, &pages->dmabuf.phys);
+	if (rc)
+		goto err_detach;
+
+	dma_resv_unlock(dmabuf->resv);
+
+	/* On success iopt_release_pages() will detach and put the dmabuf. */
+	pages->dmabuf.attach = attach;
+	return 0;
+
+err_detach:
+	dma_resv_unlock(dmabuf->resv);
+	dma_buf_detach(dmabuf, attach);
+	return rc;
+}
+
+struct iopt_pages *iopt_alloc_dmabuf_pages(struct iommufd_ctx *ictx,
+					   struct dma_buf *dmabuf,
+					   unsigned long start_byte,
+					   unsigned long start,
+					   unsigned long length, bool writable)
+{
+	static struct lock_class_key pages_dmabuf_mutex_key;
+	struct iopt_pages *pages;
+	int rc;
+
+	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	if (dmabuf->size <= (start + length - 1) ||
+	    length / PAGE_SIZE >= MAX_NPFNS)
+		return ERR_PTR(-EINVAL);
+
+	pages = iopt_alloc_pages(start_byte, length, writable);
+	if (IS_ERR(pages))
+		return pages;
+
+	/*
+	 * The mmap_lock can be held when obtaining the dmabuf reservation lock
+	 * which creates a locking cycle with the pages mutex which is held
+	 * while obtaining the mmap_lock. This locking path is not present for
+	 * IOPT_ADDRESS_DMABUF so split the lock class.
+	 */
+	lockdep_set_class(&pages->mutex, &pages_dmabuf_mutex_key);
+
+	/* dmabuf does not use pinned page accounting. */
+	pages->account_mode = IOPT_PAGES_ACCOUNT_NONE;
+	pages->type = IOPT_ADDRESS_DMABUF;
+	pages->dmabuf.start = start - start_byte;
+
+	rc = iopt_map_dmabuf(ictx, pages, dmabuf);
+	if (rc) {
+		iopt_put_pages(pages);
+		return ERR_PTR(rc);
+	}
+
+	return pages;
+}
+
 void iopt_release_pages(struct kref *kref)
 {
 	struct iopt_pages *pages = container_of(kref, struct iopt_pages, kref);
@@ -1372,8 +1490,14 @@ void iopt_release_pages(struct kref *kref)
 	mutex_destroy(&pages->mutex);
 	put_task_struct(pages->source_task);
 	free_uid(pages->source_user);
-	if (pages->type == IOPT_ADDRESS_FILE)
+	if (iopt_is_dmabuf(pages) && pages->dmabuf.attach) {
+		struct dma_buf *dmabuf = pages->dmabuf.attach->dmabuf;
+
+		dma_buf_detach(dmabuf, pages->dmabuf.attach);
+		dma_buf_put(dmabuf);
+	} else if (pages->type == IOPT_ADDRESS_FILE) {
 		fput(pages->file);
+	}
 	kfree(pages);
 }
 
@@ -2031,7 +2155,10 @@ int iopt_pages_rw_access(struct iopt_pages *pages, unsigned long start_byte,
 	if ((flags & IOMMUFD_ACCESS_RW_WRITE) && !pages->writable)
 		return -EPERM;
 
-	if (pages->type == IOPT_ADDRESS_FILE)
+	if (iopt_is_dmabuf(pages))
+		return -EINVAL;
+
+	if (pages->type != IOPT_ADDRESS_USER)
 		return iopt_pages_rw_slow(pages, start_index, last_index,
 					  start_byte % PAGE_SIZE, data, length,
 					  flags);
-- 
2.43.0


