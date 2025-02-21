Return-Path: <linux-kselftest+bounces-27175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E86ABA3F7B5
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 15:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE455422177
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 14:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E821D9688;
	Fri, 21 Feb 2025 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="suE7yiPc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C91A1BD9E3;
	Fri, 21 Feb 2025 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149320; cv=fail; b=u1PPfvNY4qkFByLamGXZ8tKTFgppLqXCxT24OL9+pBY5UeQRAvcIsCB90/v3PJQxku+t1L1qjxwn3xZAWT+Lc6QFEqx90Rofed6FE3VIWCa1E9xQry1xTBvwmJrA8hUGIf7863u9dLDLNjWoNGIYIeQyymp6fi1XPldTAWfAPbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149320; c=relaxed/simple;
	bh=pakDMmdIbVrZ8rtUbnzO74PnckkOyPlKvsZFH8nbs5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lxSYRj/SLHdjJnyacSlPXL9y2NBSkP6ff1JSL50868fIZhvxBoUkyDtD4AkSiPws+yZ/IythBZnKnkxgOXG0n08KdE9YsMA2kxNr+1pl2SngvaJfaTyHDKmIy+fo7rbglnA76kz9emGVI96UlNlpO9pizg161SlCCsLiBZRILgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=suE7yiPc; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDT/mk8M/gwaJEkLjX9NAcbq7y/2gM9w5jtNRFiClmXtkFGmckNeA/9oVIk5s7BSX4vxq9JrG2nCr+bwGDehQvqZ0diTJiBlG9ORv4lm0kap5IwvrSe9gmBMOwlkN4/c8SPIYkmBifqpb/Cm9xQrXQwmMHXEbBvgcNN6sJT5IUR6XtIvCKd+P/Zo1ThGWfrNWPyl3CJADemqUMBWeI0NXkc7x7roxEgxeE5AvjMf6goV1qXA47EGQ7RiePR316GyoDEed6/x9EgBRCUHX+N60QMYJktLgUEa98seSH3iE76KUg+ag7ns5aqG5UJ/Nrgsdv/Wi7r0vNyFsU4LJ/g+Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWEIoKJ2dPR4FvssoT4qNeWkE4q9+iZvxeZwnrzE71Q=;
 b=mTfD3bq5Yl0vFwLqdi0J+m0lT79O3I2BwRAVxFbbmNVfprxuv7GVUMIJKS+lK2kOxU0edllw9ZWpGpw2WIqASt5dUAgLwqs5LiZprQ9eP7rh6eI3h5UcJomJJTDnWvjcso3+HhGuT65Tff+UE8ca5BM+t2nAR/GCSSTXUnYxVE54a6aOzLcWNXmikmb3RtG56C/7Lzp3tYaQhrZ0uOTcYv2Rhduaj0tIRwe5b5KjWzFlu2H6vCqhYP1MOGlCR5H8yarG3iyucyth1Cxt+bkaIpOZFYrjbkrlElHN6H+mbYcfLJ6/KzXlTxrmfUxf6V7Wq72fKwyK9ma31wURTQqi2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWEIoKJ2dPR4FvssoT4qNeWkE4q9+iZvxeZwnrzE71Q=;
 b=suE7yiPcGBHJEXSgTtbNXi1SlzBg/404qE2Zq1iUXGZEsIbbBNfP90kZN4so5CqsZGxpsu5dmqDfKGox67hxp3Mw2Q/oP1TU445jWfWmZtcJn7gpOE+MQn7y+6yvIxRZ8svFBWaliQ+T6rInt9HZQpAyz4dHbXZiMnbNUK7Vt6FqYg94OXF+xOixfVWfU0Fze2wonK9C0pu63lzCR68It704BlFJn/uk2haOnRPrY6uUCbPAr5Yk4/NTIDPunt94z6zkHL7cPu8/CnwP69o89LXhFwV9yJcyoGV9zdBsnXB+fYMvMi93Sgxuk/BLslHWuMQ13BtO4zRO/n/HaOCd6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY5PR12MB6550.namprd12.prod.outlook.com (2603:10b6:930:42::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 14:48:31 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 14:48:31 +0000
Date: Fri, 21 Feb 2025 10:48:30 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, tglx@linutronix.de, maz@kernel.org,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	shuah@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	baolu.lu@linux.intel.com, yi.l.liu@intel.com, yury.norov@gmail.com,
	jacob.pan@linux.microsoft.com, patches@lists.linux.dev
Subject: Re: [PATCH v2 4/7] irqchip: Have CONFIG_IRQ_MSI_IOMMU be selected by
 irqchips that need it
Message-ID: <20250221144830.GA285356@nvidia.com>
References: <cover.1740014950.git.nicolinc@nvidia.com>
 <a2620f67002c5cdf974e89ca3bf905f5c0817be6.1740014950.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2620f67002c5cdf974e89ca3bf905f5c0817be6.1740014950.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL0PR0102CA0029.prod.exchangelabs.com
 (2603:10b6:207:18::42) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY5PR12MB6550:EE_
X-MS-Office365-Filtering-Correlation-Id: bd995de0-784c-45b3-fa2e-08dd5286cf43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9vfzPfUsMh7fnqIjrjyTVMwuLawjamsx0xz+vfRoAx5UryVg4V9l51qesZW2?=
 =?us-ascii?Q?4Z9d8l1HZ8LMjwKmQfx9cnOBCvsJffHKiSd5Ln8GjL3T6ec97vnV9Jcv6PUX?=
 =?us-ascii?Q?PNdbxEGTNBd3E1FRaTcqlVeOA7ZBFllqsMbWdCbUPZvug05RVFWnjfFhxxA1?=
 =?us-ascii?Q?hrN3+S5nkBa8iw+X92kuVJxDMXFwzN+b9tcaxgzYNgS+bLM0xKn3doaU3RhF?=
 =?us-ascii?Q?j7YQG9P6Z4Potr4hhlJs5S+hJSMb09lqkG3QQ8M9+zONQbXhqPnzVHzgkthD?=
 =?us-ascii?Q?/UGbTslLLIXXH53jdX8UK0Q+lt+Oq831b0EQEPpyxFMzlgdcWuFoTLkc/ZWq?=
 =?us-ascii?Q?cIQgRh66HbUuj/d8bMpKm/upprKY/Ba2ZyXDzwg9ypYlqVLD/CHoP4gHKY6r?=
 =?us-ascii?Q?4KD2GeNMlW0IwGiRDZNjOxaOgIODCy6k5//QpiI92f4hnMaXAEvLMPSVCbHa?=
 =?us-ascii?Q?2koVbFc4J1YJttg0Y9hJ/oceugPkZAhwkAm3IH1nGZ5tryShPFH/Uj3eWSFg?=
 =?us-ascii?Q?0srCZ40mUUOQaUzpWUk5g+AhRHYFwg29IfzhzciTvDfE9ytlgOwE1fH2Eh5i?=
 =?us-ascii?Q?u4xkewMtx6/+mTEPKJSWFU+5JberJwlbdR+fG/QlJ52LmHSLC2yZjh/+VEku?=
 =?us-ascii?Q?cXAGf0JQrCdcXAsEr8bIw0ToBAsueoGfU7aRSrqLtKOxZnsayo91Zxnlo7ls?=
 =?us-ascii?Q?CL4gqKRZjytHnJlJLR+Qyw6CSHXeJDz67cPqJhYvaZn7WXyMC5q9K/N92bgd?=
 =?us-ascii?Q?ZJk+uJiOU7Tzg0rpbWyzkTcV/dvhfGO8Msl374xbXRXU4uR7ALBghg0HrQAS?=
 =?us-ascii?Q?vB2GyVlkQy/MfXPgolllrgalDpAVM80sOMY2nPDigbjfUiDsh8VGNn4kod7N?=
 =?us-ascii?Q?53lBYIM/ygsADt2MDsAwjRE9wQLzuvm0bTZi3BXRtopoiVuFnJOpHKGA/IfD?=
 =?us-ascii?Q?yusaCNptFMk/IqDmBb4Tpz3WNVIM8xchGBXPwrmluSZcu1YIHF0zLaQDNusU?=
 =?us-ascii?Q?dI2VuEs5bLTmipHvl4dz/ei8mrgmJjzqHG106x8OlxlG5jxaAsmLBVfGfcWz?=
 =?us-ascii?Q?CAMT3sn+n0bwlSv2Xk3MzJSSxYhr2IDCn8cRPWnUcz08/RTvT09WkTpHaCDO?=
 =?us-ascii?Q?APXg/SUjPut0Af6Vl1aAO8tI8SLGWaS8i09zHGUMZE3+ZNp+mrGKDZxDlTzZ?=
 =?us-ascii?Q?6cXvYtlOjzMgtFqNZYBqqpSaAt1fM/QVbcWsFdU9JkGuN+21FYUOyzgS++bN?=
 =?us-ascii?Q?f09vyTSTMLFfMqsIVEompO7EdZDU8b13IVGocEzQ8vDcH0lq/ePVe7z3N2Np?=
 =?us-ascii?Q?vdZKRJ1iodGsV0AfZQ80hMCLbiWSF9JsUQohpJz+yFxwwE1iBJ7Bfma5hzos?=
 =?us-ascii?Q?WQz9a8svCEqbRL+pXEFq5CvXxsZc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oHGPSzDn3vqVQuuWGCc3QGn6DhLhaJMv7syE4kPztxZhbXiXZkDL4kv7uVWv?=
 =?us-ascii?Q?Dtu4InQVArcasayxGOHe8T9DxhIxRdkTqAUrODgRTxSV7QYJYS2SyJ6L+8te?=
 =?us-ascii?Q?uASh2S/MqWaDPpXVUz3zU87eaR+7iyY7/NYpVyYvJqWDHeJsMTg+50/oB0On?=
 =?us-ascii?Q?gef5vfUcVwXHBBJxBJufuJRD/Tmd9lYBZKPLLfL7BGfdyilxdv+axW6kqTdB?=
 =?us-ascii?Q?a5e+mzDZXjfCy6T7YsGfjAbE7qryQzC7ZGm6VT6E+vWSE0/IfAbh9i0P71OS?=
 =?us-ascii?Q?cc74WRjXjGk4j4YYd79oPPbR7l5pfbqlXNpA77lWoW2uqS4AzwfpnRm/Sdz4?=
 =?us-ascii?Q?f7nOnbtmYeufLMj6WLZ5KrSb80nhZGcD9g0hQDHKO5t05kZlFWU4mOVVIMUN?=
 =?us-ascii?Q?rM1n+KZipZ6zRUpe4AMD2EPD/d6+uICcTLLrf5vCUe2oLncBUx3kbYvStE6X?=
 =?us-ascii?Q?wBbmQ1w/nGXvjiToK8XnbnGVt2OUjtSzY0X7Z5U8DmaHG/zr8velnCquAP8u?=
 =?us-ascii?Q?vR6IibRny4pO9NXlWtsAlRChpes4BQ4qbxV+dSaYW8Ns7batAb1gUCFaOlZM?=
 =?us-ascii?Q?IVioTkNcU0BkdAiAeGr0pLmvNJTkSHrsnVzZgGnXIzaEB9omoSEwtimZtPlx?=
 =?us-ascii?Q?fxXf4X31EB6jZCXNusClHSW32lhR6n/ywk23vYt4epAZFaiWxWaKljH96ME3?=
 =?us-ascii?Q?AYT+zkyenSInL5PVTpqd87WxaEDoCyAWjtCB4jzIb4bKWdS9BOtCYqy6DcN4?=
 =?us-ascii?Q?OVsHtYK5SQSseWtD73orgcQx78zvnrrsezsi3ieZOI3yGj8Ka/stmko076Pk?=
 =?us-ascii?Q?d9NDFu9uskFcr4ffC867+0OcLSaX8KB6MTOqjfLcpink79KZP70zbNJr0R3e?=
 =?us-ascii?Q?JyJN8bzUJY/+QHsrsPSe9xD2u35WnqMkRK3euxVHEwSsGDLePO4LXX7aERRQ?=
 =?us-ascii?Q?xUQooF1vQ22b4eDgRLf/HhIJhPaOF9TvtkohS7BY3kJHj+9eSvxm/bi/UxyB?=
 =?us-ascii?Q?sDwO71gd09usVvnBQSyrB2+/zNjLdUFwWMyhwmUp+MFmCuEk+GhwO8TzKIoQ?=
 =?us-ascii?Q?NXOfrjz/MBZeuzYblPkOM7ZYSSX1YKDc8byhaNXcqKfm1RkR/uQpCaXZ+8uh?=
 =?us-ascii?Q?YYwVyetVktEY0ucwDHHniMHFQXppq3kv0V9i3aoRyxp8nB46MLo4XoRYV55T?=
 =?us-ascii?Q?QhqtSwZC5F/5V+l5XZazXeo45QKQffTaRdDrpYXiqu/rxK/VTCEz9Xw6eI8E?=
 =?us-ascii?Q?UVJgrFeAHFVhfA6ZB1hUnoW6hV6W2YYkZ6e9FCtSSsnJ0oy8CwagwYfQaVB+?=
 =?us-ascii?Q?J9YRpSJs1wNhT63KBUwLTx8s/3TE/HV9CduH6128T97CXpp1xr2OEBhuNM9O?=
 =?us-ascii?Q?uqGsTO7VDn4sH9WGtHAKZ0S77d3T6kYYSKUMD2zwT5++W3xf2xS0iyjDb4DP?=
 =?us-ascii?Q?eZ0r6nAA/39pMiDEkIv2jwdkrJcIxwtFXY8d/ww90tWTFt8Qt635Yifj19qU?=
 =?us-ascii?Q?PcEtD97bOYpr+yNfIapNnrxFirXof+Y+DW1n9lzmbAMBP8iPb2hzOR1qmpC2?=
 =?us-ascii?Q?8qs7k+AhMHEmtXQkdiSnDE8u2vAkvn3KYdmNZTKB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd995de0-784c-45b3-fa2e-08dd5286cf43
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 14:48:31.5243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rr0zExZ4kno0g+fEwmLbjTgWOmQLTTuTnkT70E+K2kZ4HLyT2xh1GWBjEbUJnpvK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6550

> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -154,7 +154,6 @@ config IOMMU_DMA
>  	select DMA_OPS_HELPERS
>  	select IOMMU_API
>  	select IOMMU_IOVA
> -	select IRQ_MSI_IOMMU
>  	select NEED_SG_DMA_LENGTH
>  	select NEED_SG_DMA_FLAGS if SWIOTLB

Because of the above this patch needs to add:

--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -449,8 +449,10 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
        struct iommu_dma_cookie *cookie = domain->iova_cookie;
        struct iommu_dma_msi_page *msi, *tmp;
 
+#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
        if (domain->sw_msi != iommu_dma_sw_msi)
                return;
+#endif
 
        if (!cookie)
                return;

I fixed it up

I think the above if can be deleted with the sketch I showed in the
last email since the put_dma_cookie will only ever be called on the
default domain or on the vfio domain which guarantees it is not
iommufd or something else using the union.

Jason

