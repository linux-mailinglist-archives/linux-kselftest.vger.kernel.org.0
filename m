Return-Path: <linux-kselftest+bounces-45145-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3F9C41752
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 20:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 829174E3F15
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 19:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDED831A07F;
	Fri,  7 Nov 2025 19:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hxrvf/qt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013041.outbound.protection.outlook.com [40.93.196.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F67727D77D;
	Fri,  7 Nov 2025 19:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762544662; cv=fail; b=RgkKPBDG2KqBvto9Sa/qWaFhFB5O714YhqIrh+CRnqb+QjaBBZGgWNqPe2I9m3H+kZKDaSKvLslJbp9Asea/OdVo/cxMkppvEy4HsGvhKBDgEvGtAHtxKPA1yWz4OFxFcq9yVxkz3aDHv9FtSXW7N4i9vwMZL9Ht0P3xXGd/0u8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762544662; c=relaxed/simple;
	bh=f+8fkiXJ5COUUR3oG4GRMnse4/Y0EZN70+lZ9H4WCOA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnybWK0rn+E4SUajSOalmMyAQZzFIVcqr4kFytQZaseA0UGUjOIWl/COELuqIxXE6d97oE7qnc4pKNlWaJUSg6G5binI7+ILL0WRLDdmOx1HGKpeJuxdBpt9hmxqBfNEDYNojD+drIrGgz4hsmnD+LR5NOnDWqMhWkVnK5BQKKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hxrvf/qt; arc=fail smtp.client-ip=40.93.196.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IsPbLyAkPYdZJ2Y/NZQAxcr64JWaWUbbu7cr4cDxUlcOZBWIuPnHRsEzHHm1obv1StGJKqvqWzKmfca8UWTuE7arSHmM3gZ8/gcYLLQZGaEzYNvR/G8vc0mUC3mdfIKL7CGxGXi1772V8GpTYvPjtrcXi3eNVV9YD15gyEY6XS0/8op6CZa1WBibpXsBYdTsKflHHFGaXY14oCJdFaB8DoDkQ6WXRJnKPR/Qp4TKa358QAJN6jjWqsKWJzDHjwHpJDkh12jRP/KNs9jn7co7tn0/duSF0g2NQgYJLFni+ZY1kKdkcWaqk35KZ07MEfzU5Ac8mZfFrxmcuCev8/FH8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGFpBUsbjy/THko9FXd2tawYqCuRGpFlX+SGLB0LePI=;
 b=EvZFjpuuoGX62rQofYkhskt0I+t+MTJgIp7ZbTa8wGp5f/vZsJOc8tGejoqi4FawcuO51jwCFscsp5ItZR5AvSwecxcXJRW4sEtkkWjHo6ITFE5SPDWP/j6xLh0zO8pr5ka8gsZMU2uZG0Y1RiQWfY4G7eAPDjogARIQZlfgl/9z1vhTt1HSBRA+xUqTA4CGd4LuDU7DrHrKjxo0DzEYYukx4e4/fyNILs1WXalRkqraIiuK+Esm38M0HzIAOK1z9PX4O2s5uqyoAplGtV6YVDttIbqXh4pbmkYWg1di/hQ5Whm10oGJQJb05W2HIbn2At3LtINHY1Vt4cXKKuWe1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGFpBUsbjy/THko9FXd2tawYqCuRGpFlX+SGLB0LePI=;
 b=Hxrvf/qtu9RnrN4nwH74Gac1nxYDsIVylQvs1QVmcGO522TNzoJjJnYUxLRIo2sjNJpqqOdrcJWtL40vRrhQ+5NJ+DA84zNxVFo2U2e1HX9IVF0BOT3m4ZjTxgfhRWw5ER995fZ+sV+VngYZrKD04i5ydZarprb1SN6ZKIMQzz8f+Znn3ILlJUWuv3VXi2I2vakByujKM02Z2uI7VFQYV+5JiTUgRdAzPdxuqGmrLetyJLnoKebebmSYWpZB7Xa+vsC72bF8bEv1oB5A5jFfKZK7zLphLnBkW5Cy31iZj29zm4b/7T9oI4JQOdHwjSiOOxmP2EDioBu7SqUwTVxFYQ==
Received: from SJ0PR05CA0139.namprd05.prod.outlook.com (2603:10b6:a03:33d::24)
 by IA4PR12MB9764.namprd12.prod.outlook.com (2603:10b6:208:5d0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 19:44:17 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:33d:cafe::6e) by SJ0PR05CA0139.outlook.office365.com
 (2603:10b6:a03:33d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.8 via Frontend Transport; Fri, 7
 Nov 2025 19:44:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 19:44:17 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 7 Nov
 2025 11:43:59 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 7 Nov
 2025 11:43:59 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 7 Nov 2025 11:43:57 -0800
Date: Fri, 7 Nov 2025 11:43:56 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Alex Williamson <alex@shazbot.org>, Christian =?iso-8859-1?Q?K=F6nig?=
	<christian.koenig@amd.com>, <dri-devel@lists.freedesktop.org>,
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Kevin Tian
	<kevin.tian@intel.com>, <kvm@vger.kernel.org>,
	<linaro-mm-sig@lists.linaro.org>, <linux-kselftest@vger.kernel.org>,
	<linux-media@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Shuah
 Khan" <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Will Deacon
	<will@kernel.org>, Krishnakant Jaju <kjaju@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Matt Ochs <mochs@nvidia.com>, <patches@lists.linux.dev>,
	Simona Vetter <simona.vetter@ffwll.ch>, Vivek Kasireddy
	<vivek.kasireddy@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH 9/9] iommufd/selftest: Add some tests for the dmabuf flow
Message-ID: <aQ5L/NXA+pYfK9zf@Asurada-Nvidia>
References: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
 <9-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|IA4PR12MB9764:EE_
X-MS-Office365-Filtering-Correlation-Id: f7917bcb-4518-4d0e-c9d1-08de1e3609ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zue1yWPcUuKEsAgL+cCEIfMxtP87nUV7pf43dzweM8RA5Oy5eOI6k3EYJLwW?=
 =?us-ascii?Q?nO3tlPdlUR989TftlbJXYXyB0vTXSmxapO0nCclGrQVHTdvu91t7ebrJNJRl?=
 =?us-ascii?Q?tfDM8uxx5qOPEfUxWt+ZsgWinPj9b86ahgFn2vNhJ2XJz2kYo5HIdLvOsIo4?=
 =?us-ascii?Q?OP/QTpQm936A0cSK1eAUVyH/K/+4AqLAIzZdgN9xg1exkKqKtmmZZ+cwA9Bm?=
 =?us-ascii?Q?NU/EjR1Qq1QP9pG93tS5ssNAFz4Lp6giXOu18Rqv5ScrcSsiQTaeELe0nO8o?=
 =?us-ascii?Q?MRaCeiN+JNjX8dJIKAZc8wBlTgEsen4nlddjYSmrEDIrLQSO+w8PNCfn+fGe?=
 =?us-ascii?Q?xLQxxUuSkr6dc4lGOuNCnrDC3+n+BfDyoDlE3lgn2QQuEKAL2Vg3NWf3fgiF?=
 =?us-ascii?Q?3iAdcwJSfPq6jAPtlPJyUqYwGkUtsYnyfQVMGR7sbnlde7OxOPF1xtbnbbWS?=
 =?us-ascii?Q?J76eRrA8uasI40erHpZbX77FmetevpBfw0UWfRVtLVAW44d5MbcgHUb4f7zH?=
 =?us-ascii?Q?FaNELoB1MmwVRXAXVdAIepu6lHgDTTEEmWzhMpFmHXxojuxaiJHrBtLCvNMC?=
 =?us-ascii?Q?NbJv42AqaLZKjKPLSapp8Srjx7URA9bvIVmTfpf/weqNm7/qxjSJ4b1cL7Wg?=
 =?us-ascii?Q?wkmErmn0utUlD/mSywj8b4VmpBI+pxz3WxVptF36wA5KmNwNJvz6DECrK3YA?=
 =?us-ascii?Q?Iii4iwNPaL6FpeHwlbjVIND2N6Q+M7hP2fzinJKDnQIZFhlPqq/Qb7x/aFV0?=
 =?us-ascii?Q?cJtuv2qEGOq3D3p1zRVrOVLsgiFtRGfxZUWuhwjMIAzsfKka9yRGgjhuKtse?=
 =?us-ascii?Q?8uoIfcK9uIVK9gR/oApnS4hqZkvtesIQtvvAqxLgFB5JjEdo0o8lJlJDfcrd?=
 =?us-ascii?Q?xFmZTX9kXDZOfVF27uo2e81XoMtkn9Z5zdSGo3Cvt9tqFz7z9psBUhuvdkIj?=
 =?us-ascii?Q?TacxxAWiayAWTEliHIXkDhwKNnMGJjzJGIi1fCJJYZBL/rRykSxqocp2FS0q?=
 =?us-ascii?Q?NeC3PEbtj/vVosWGAQne/pYgNuSt6gZFR8GxSmMgmnntzwh/pBDo5PZ6UHMi?=
 =?us-ascii?Q?PuyF6buNTv4QqmsQhv2B6CNe5RT/T/FH8lNi7d9o6gfJoGRHIHG6GK3CGnRs?=
 =?us-ascii?Q?Djcnd0S0tb6atufW6NSZmT5e3YBv1JfoKWkd36xKZubAXSQ73zf9vGsbERBZ?=
 =?us-ascii?Q?X3kUBrok0LVv+dgGkHe0w+uQc6ZoJT7mRWDGx5LCfGTA4EnDzv3dpVVzBfd3?=
 =?us-ascii?Q?L5Di+EimCFc2bCmrWmnyjgawD/jHMgo4wHJlHzmofdAtTmVfYNYyT2cbAEm5?=
 =?us-ascii?Q?FkDKUWtj2NgZFWOtz49G8p3FWBtzxqO1uI15xh1jS9KVhVXytIR5iQTovxC0?=
 =?us-ascii?Q?J+U79KUCDyZrOG43VqpuZIMGZUMoEq8UklipIJSVSnpGSAOllE40p0DSRl93?=
 =?us-ascii?Q?B8SxpCj60hl1JEok1mTl0Q+YLbHT9K1aR5kjWvnE9TnjSxRAOsuTdFGsgPh0?=
 =?us-ascii?Q?LcZffR4kepHLr5tnxO3GMyFQ553Bsr6hD2hpgdMJ0AZ1JOrr7tWy4wVbrNp/?=
 =?us-ascii?Q?XRm8fi535DmqqiFcY2A=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 19:44:17.2172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7917bcb-4518-4d0e-c9d1-08de1e3609ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9764

On Fri, Nov 07, 2025 at 12:49:41PM -0400, Jason Gunthorpe wrote:
> Basic tests of establishing a dmabuf and revoking it. The selftest kernel
> side provides a basic small dmabuf for this testing.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

> +static void iommufd_test_dma_buf_release(struct dma_buf *dmabuf)
> +{
> +	struct iommufd_test_dma_buf *priv = dmabuf->priv;
> +
> +	kfree(priv);
> +}

Missing
	kfree(priv->memory);
?

