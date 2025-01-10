Return-Path: <linux-kselftest+bounces-24227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEA6A09877
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 18:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DEB916A3A5
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 17:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9A4213E73;
	Fri, 10 Jan 2025 17:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ObMsJKvU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3CC213E6C;
	Fri, 10 Jan 2025 17:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736530002; cv=fail; b=gP7l3q0dpq5DOqb/cFZG2aOJbUusdA/JOpjzBLJKThlERCJ8MDUsoS6XJUrXo6c1VuxZNBoYipJTVlCRzSYxDowuBxFPMeESDb/+i7Vpf1nARhNCDoYnF/f5Xxzf4Z2tf+RhELnQPQJWsODlI5Qyp/XUPy+BiVfoHTwUrLd2oGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736530002; c=relaxed/simple;
	bh=0fyo0Z/xsbfvpGQpXfz5JFoshW3rorKwSQWkWoMEdYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UH3FHFIKVyBPFEY/iPcBom4tan6vlBPG1QUEiSe6NL6yGXKKJ1tDnzduiIIz/Buw2LPgSJpZKtJIaaJ+bCwjZDfWCiSXCj4S0TMQep5gH3IwChwYlrIY6B1HuBQ4iTIkgqDR40Xhigp+s41JVv4K/WIsVArLpC1rTlNSrRcddBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ObMsJKvU; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIyBJUTGy+7iRNH5WkgRUeh6+xMI283w4KniENgFTX9QvrZnOf4AGpvWfUUYeawEZtILu4TpxuZMqgi3I2hdxzKnKAPTipz3PgzFUn//BwSYxo2XF8k596hIXWsZVFtJ3k+mjattwEas/shDIzB9SzMtk1dnctcAGKb6vpH826I6zgVMYJk205AW36844Iy9Yf7tMNeu3NswweTXtSabF95Urwy18/DmsLnnqjFuFM5UVzy14wnVkiyIjQas5DJdxBiWIvo3aV72EXPl0P1a7pzfCkOLJc7ta4GvsEw6YOHj/ptZfiaBn/J1tV0KV2HrV7uHLWDrvQgSEy6//EOuOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LysR+6XUA5bjVZCSVz1vQR9CClM4DBnxm+3+TSuQE0=;
 b=b5CnOdDkdyikvGPCKWEnvUNNDQe3EuWBYY6g8tr72o6J5/llqW12rHXT0QwwLfNCNITpLHQdLM3SExESPYWLuTd1ByuUT0LVH3qEWLll+VyLFs0EMw4nYalHzOBdgnD6s/KiDGCvkNniOXcT2IhW71qZT1WByH5JmVrdCf/DRFKdNWw6odpJZ4WFPeIxRpQpEW/3f5705k4Rxk9Cr65qhwCP8d+4H/v23VTnDRyST2CgYS6zkLoEcGhSI51ZUkrQS/WYHF7+I+xrORmPuwNw6VwyfC8b4qVTcgur2CFHz5Jzf0r25pzpzpBi0AhXE0ZB5d+HQAPcgCNDvR/Ml7w8ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LysR+6XUA5bjVZCSVz1vQR9CClM4DBnxm+3+TSuQE0=;
 b=ObMsJKvUVu4qI3Mx9ZI4TnI1Jk28pQRUtu32JIcfyMzKRz0+brxeu/lb/MhznXESOISE5P3ZmLqUijpjjcfse9ONi6tLDkifT0gnK6O+ENCETg+Tx02SbEtXTySI+jizI0sblC4a0OSg2yhGMw0At0nM58SbjZUmEI+VgJ2NZeWgOuNpnW0H6u5xNvRNJyBUaEI2LRVVTEF+apzPzFh7kw+3MjBCs0TIFWNuu8zi3xKpc6DDGayfkj8RpCCSxuNgtHPUs55vSbBx/CBH59Bq2R8gWFvpoSmQxhEXGs4YfV5ei03EqU/jPlXauIF2y1tvLdkYSP3OsLh/y0AAs0RNyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA3PR12MB7879.namprd12.prod.outlook.com (2603:10b6:806:306::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Fri, 10 Jan
 2025 17:26:38 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8314.015; Fri, 10 Jan 2025
 17:26:38 +0000
Date: Fri, 10 Jan 2025 13:26:37 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v5 04/14] iommufd: Abstract an iommufd_eventq from
 iommufd_fault
Message-ID: <20250110172637.GF396083@nvidia.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <a6490048ab3df78f648e3ef0d217a90b7213d47c.1736237481.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6490048ab3df78f648e3ef0d217a90b7213d47c.1736237481.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN9P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::9) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA3PR12MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: e5a5f485-7bcd-438e-39c6-08dd319bf06c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ymPXIS8BqpnEq+fljO9ysMmVIg8rNbP5wahtmlz80p85JAvA8IQEgdDhgEqT?=
 =?us-ascii?Q?lQApn7vlWS2JKMXxAGqWp2i3gg89CVX7b5NXa8xaNpRZ3JPHuXDlgSY3H8Vd?=
 =?us-ascii?Q?bD8RkKtYb9mloRWlhxtrEW9pcyu5ZW5ySVC6th95j6V+GWBvuMBhhbgrWA6o?=
 =?us-ascii?Q?zN76vasmrLfEQUQUCiPFmGI63C/PBpJ/chPDzc3d1AFnAFbZHU78/GsVoR+W?=
 =?us-ascii?Q?BkSX+fXquF1GuRhWSsNvTV+3bYzoIS20QeiEFdn8BTH9UscsK/e4yFZC3ceD?=
 =?us-ascii?Q?4SCTXNPr1Swqrlxfxsg49P9xVwlGbzzvLjeNgy4sVG7puUD0GQCcpHyEUyJZ?=
 =?us-ascii?Q?6Vgs12rpPUcigtbGMru0KadgAgvljZvUKHMbH60jm7qGguqaz6P5NsaH6i3N?=
 =?us-ascii?Q?eYeVu09F5W/UmY9zbR6gu1Yurni8IR5LyX+UH75FLb41GCjqcpb3LlXzMu88?=
 =?us-ascii?Q?OHcLyTlASM9EwMXw6IRF5RLil71PTu1V3RD74cXPhx1xT8gHs4pyvz6UOjBu?=
 =?us-ascii?Q?0zbZbHnEO7/vuQg5tm35MA37I07Qk3Z63nCqGByYh8UUEOGz4/TCGtkyUOoy?=
 =?us-ascii?Q?1b/qtqh8fiJRajcnG1fX90eYa1prNfsJ2PBbCoWC34/NeDqRZvkOo4VwgDXC?=
 =?us-ascii?Q?Gs4+WxVjiYnqLTL1x+h9atBRoFhpTSB5e7+Di9oLACl1PNhjoIy9UExeY/QO?=
 =?us-ascii?Q?3eeAzu97QMrRXQD513rcZFPmMeApmsQ2CdYxt2ggyLbIFpoxa1/njbDw5gcy?=
 =?us-ascii?Q?qR/6UmMriCX93oW/+YXYTLbxOGjMsJkiESJDPGcwMQXlSi3A86aricnS3r5b?=
 =?us-ascii?Q?bAq8xwkLkG3B8kT0asXmgWHGtRrkIpAe13lqlannZQCQBpMCQhaKvxzefN/a?=
 =?us-ascii?Q?V1rFjCQQWm7WJXwUdz1jGcdNMsz0FQO9R3rL9iur454xjt2LmhZK+GPDmfDn?=
 =?us-ascii?Q?Sg8dD5kRUJbexzRFp2sU3TNwC+rY2YBCrw33n9LnUbqVEKb8wj5Zx6cZT+JJ?=
 =?us-ascii?Q?VODzupxA/PvlkE3DZCpeLFpoSiuZoKi91n84wYkax8nqGPxl9TKEWavd52FX?=
 =?us-ascii?Q?q59z6owI0uGo0Q7PPbKwAb1gUTsxJndTlc6bmP3GTmD37CM/UVXLFQ9M0Ddq?=
 =?us-ascii?Q?HqCG4hkExFmmqLdkclXjyUQJt05z/psXsjlyEfbAhIfOc8FTKBJdgjOi6Sux?=
 =?us-ascii?Q?83xB3ust8kPS7NNwsYWM9aUF0f0e3gLxvA6oHuJLdcUmTqc6moMK3GNL/xYo?=
 =?us-ascii?Q?OsXFcsb5xV9NkykpjX58hGdjjMsTX4gKPiXDvQI36THTn/oV6ISF/JmrZpye?=
 =?us-ascii?Q?VwKxmO2K4XTvX5p59fh9HmfT4geBRu1hqlPFL3Ybbzcmwnf0+4lxmr5Z0gVn?=
 =?us-ascii?Q?SMLXVhkLY8tR4fGA+YeCMKb751t4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V7N+zfRSd86Vt0ixeV7bMwQEsWx/RfWmmRpBdYkZx7KgOBHKyRSaXjCx+j0B?=
 =?us-ascii?Q?HbVSNNH3+cx3jNretlCmLGaUDC+Xjb1N9g0jHmyMyTZkXe4MciNnZxu/imeo?=
 =?us-ascii?Q?qOeseiesS2cQkC81c0G3JX2lR1CX8uVDNgUiE0MhAJWoOkoPKGCBnAsuoIx+?=
 =?us-ascii?Q?fgRAu5b1UsJJ6VBJ9xLrniKSz1Uj9NoWetzhP2UfbpnDqj02wnAqB4775tF0?=
 =?us-ascii?Q?8wWXygS7XnjHP3m7chTAKGfRQScEwI9wyax+f3i62UclJc/fkhbY1757PAEf?=
 =?us-ascii?Q?GZKZkQe/qyZz45nU2rwvO570+8yfbxXCWDsnqZi9OFUnY4vDhGDQGlUYIR3A?=
 =?us-ascii?Q?vMhyWXxiPbcrZ6awpI75Slm7A7mIZbTai7xIYiVU95y04PUorZ5zDP21UHp3?=
 =?us-ascii?Q?pS6S5udnbif6RgkvXwyXmcbCYKYL0s5aHLnP6T76AUjFKhUrHihO5Op1+qxg?=
 =?us-ascii?Q?5iwSBAT99Yp0FWp7YoXrcJSJjc3FcNCO0pNGHvavSjxxnC6mvSUEqiLPk8+M?=
 =?us-ascii?Q?zmtdOG8V2AkmsvXe5AeNn4+B0rxVzzbG/cdcqqL2wbfV/IYI+JQfCO7RLN+H?=
 =?us-ascii?Q?WlXUQQY9/wmwOOxdX4m6y0r8JiX9RqV9mzprVs/zRf3F34iPwFLi8m+wrmpK?=
 =?us-ascii?Q?A/dk2ePxPzQEkAA/g8a4V9vveu87qai5dToKSeLhkcbM+5yzssZWBL+7l5RW?=
 =?us-ascii?Q?4MJDgI783uIxb5/06AqzV603IGw18z4yo0uij6DO55hoZJV9+831UyFChruO?=
 =?us-ascii?Q?TJRlWRk6C5S4vao7Wl4CDT2z93j1qEXJ+i49wS7OsZNZTPQsMw2uyRRqC9yo?=
 =?us-ascii?Q?jMz0oL4Duof7DOujMryuviG/q+fVHwVmctQ0YXVSjGkexUQtvDcs5G95zJCN?=
 =?us-ascii?Q?yH8mm1g57+YpOkCmSgNHNRggz81o0YqItIj0K5de/4sZZBJap9p/gU/F76jR?=
 =?us-ascii?Q?WLk2OjWEHR8oFIjEOOjlHJMly7L+6GkRPAV1+EMJekRI57pIWSoeOpIArm/x?=
 =?us-ascii?Q?5kDf9kc0vRW5Vscq3812d5LrBxR8qOjtUYfWBICC8mE04njxkXBFZE/2eaMs?=
 =?us-ascii?Q?53NjbAHXQF6AiEeHYkEANj/T5zrVY6RYUtixTiKj+EpAZelGJGrpU7OiFvgD?=
 =?us-ascii?Q?KfA9aQzb3oQJ4MlJUO5Yis2lfaUzDxpyNvrVjcP17jGd1UHZcdgNwoty4Xp5?=
 =?us-ascii?Q?H0egOwoZKKhd69r6FUCYSowo3uwhpTvT4/Crbfo1LkMCV5DrGgT/3i5r69/0?=
 =?us-ascii?Q?MuMHHWKnCsc1eWuAHFab7T3FwVGUZjKPuJBesWQW57ilc1v26R8xDvGmzIv1?=
 =?us-ascii?Q?0k9Ly65e3nKLnhytN24zszCvAW5yUG4tdzE7BVOTo2IpNxhfnJfvcH9Tbx62?=
 =?us-ascii?Q?UpeFWafQXBNWBif0i0S+IHzujFUCid+5auaxyxKszfR3Reaszu8qzFnfKW1I?=
 =?us-ascii?Q?WvAEz9ez1QCDCtNJ9zxbVsksn6QWprZwJtn9QSxgLxQrDGkJOZUnZwhUbs8t?=
 =?us-ascii?Q?WkGDf17X/RBPBQoozfthHlwRiWk1wpH8Fe9xgEPl8hJn51tN79iMnxPTOwYl?=
 =?us-ascii?Q?gUZp5rL/RrGX1NJ7MRpYwN4dfzF9YCIRh0fCdemN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a5f485-7bcd-438e-39c6-08dd319bf06c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 17:26:38.1346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Pmr+4nUqKd1Eqh79Ek7IbdKn9yEH5PiT7yZ+vkmBYeYlaCfjmVBxGFLNmGdxAS+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7879

On Tue, Jan 07, 2025 at 09:10:07AM -0800, Nicolin Chen wrote:

> @@ -433,32 +434,35 @@ void iopt_remove_access(struct io_pagetable *iopt,
>  			u32 iopt_access_list_id);
>  void iommufd_access_destroy_object(struct iommufd_object *obj);
>  
> -/*
> - * An iommufd_fault object represents an interface to deliver I/O page faults
> - * to the user space. These objects are created/destroyed by the user space and
> - * associated with hardware page table objects during page-table allocation.
> - */
> -struct iommufd_fault {
> +struct iommufd_eventq_ops {
> +	ssize_t (*read)(struct iommufd_eventq *eventq, char __user *buf,
> +			size_t count, loff_t *ppos); /* Mandatory op */
> +	ssize_t (*write)(struct iommufd_eventq *eventq, const char __user *buf,
> +			 size_t count, loff_t *ppos); /* Optional op */
> +};

I think I recommend to avoid this, more like this:

diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index b5be629f38eda7..73f5e8a6b17f54 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -341,11 +341,6 @@ static ssize_t iommufd_fault_fops_write(struct iommufd_eventq *eventq,
 	return done == 0 ? rc : done;
 }
 
-static const struct iommufd_eventq_ops iommufd_fault_ops = {
-	.read = &iommufd_fault_fops_read,
-	.write = &iommufd_fault_fops_write,
-};
-
 /* IOMMUFD_OBJ_VEVENTQ Functions */
 
 void iommufd_veventq_abort(struct iommufd_object *obj)
@@ -409,31 +404,8 @@ static ssize_t iommufd_veventq_fops_read(struct iommufd_eventq *eventq,
 	return done == 0 ? rc : done;
 }
 
-static const struct iommufd_eventq_ops iommufd_veventq_ops = {
-	.read = &iommufd_veventq_fops_read,
-};
-
 /* Common Event Queue Functions */
 
-static ssize_t iommufd_eventq_fops_read(struct file *filep, char __user *buf,
-					size_t count, loff_t *ppos)
-{
-	struct iommufd_eventq *eventq = filep->private_data;
-
-	return eventq->ops->read(eventq, buf, count, ppos);
-}
-
-static ssize_t iommufd_eventq_fops_write(struct file *filep,
-					 const char __user *buf, size_t count,
-					 loff_t *ppos)
-{
-	struct iommufd_eventq *eventq = filep->private_data;
-
-	if (!eventq->ops->write)
-		return -EOPNOTSUPP;
-	return eventq->ops->write(eventq, buf, count, ppos);
-}
-
 static __poll_t iommufd_eventq_fops_poll(struct file *filep,
 					 struct poll_table_struct *wait)
 {
@@ -458,34 +430,31 @@ static int iommufd_eventq_fops_release(struct inode *inode, struct file *filep)
 	return 0;
 }
 
-static const struct file_operations iommufd_eventq_fops = {
-	.owner		= THIS_MODULE,
-	.open		= nonseekable_open,
-	.read		= iommufd_eventq_fops_read,
-	.write		= iommufd_eventq_fops_write,
-	.poll		= iommufd_eventq_fops_poll,
-	.release	= iommufd_eventq_fops_release,
-};
+#define INIT_EVENTQ_FOPS(read_op, write_op)                     \
+	(struct file_operations){                               \
+		.owner = THIS_MODULE,                           \
+		.open = nonseekable_open,                       \
+		.read = read_op,                                \
+		.write = write_op,                              \
+		.poll = iommufd_eventq_fops_poll,               \
+		.release = iommufd_eventq_fops_release,         \
+	}
 
 static int iommufd_eventq_init(struct iommufd_eventq *eventq, char *name,
 			       struct iommufd_ctx *ictx,
-			       const struct iommufd_eventq_ops *ops)
+			       const struct file_operations *fops)
 {
 	struct file *filep;
 	int fdno;
 
-	if (WARN_ON_ONCE(!ops || !ops->read))
-		return -EINVAL;
-
 	mutex_init(&eventq->mutex);
 	INIT_LIST_HEAD(&eventq->deliver);
 	init_waitqueue_head(&eventq->wait_queue);
 
-	filep = anon_inode_getfile(name, &iommufd_eventq_fops, eventq, O_RDWR);
+	filep = anon_inode_getfile(name, fops, eventq, O_RDWR);
 	if (IS_ERR(filep))
 		return PTR_ERR(filep);
 
-	eventq->ops = ops;
 	eventq->ictx = ictx;
 	iommufd_ctx_get(eventq->ictx);
 	refcount_inc(&eventq->obj.users);
@@ -497,6 +466,9 @@ static int iommufd_eventq_init(struct iommufd_eventq *eventq, char *name,
 	return fdno;
 }
 
+static const struct file_operations iommufd_pgfault_fops =
+	INIT_EVENTQ_FOPS(iommufd_fault_fops_read, iommufd_fault_fops_write);
+
 int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_fault_alloc *cmd = ucmd->cmd;
@@ -515,7 +487,7 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 	xa_init_flags(&fault->response, XA_FLAGS_ALLOC1);
 
 	fdno = iommufd_eventq_init(&fault->common, "[iommufd-pgfault]",
-				   ucmd->ictx, &iommufd_fault_ops);
+				   ucmd->ictx, &iommufd_pgfault_fops);
 	if (fdno < 0) {
 		rc = fdno;
 		goto out_abort;
@@ -541,6 +513,9 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 	return rc;
 }
 
+static const struct file_operations iommufd_viommu_fops =
+	INIT_EVENTQ_FOPS(iommufd_veventq_fops_read, NULL);
+
 int iommufd_veventq_alloc(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_veventq_alloc *cmd = ucmd->cmd;
@@ -580,7 +555,7 @@ int iommufd_veventq_alloc(struct iommufd_ucmd *ucmd)
 	list_add_tail(&veventq->node, &viommu->veventqs);
 
 	fdno = iommufd_eventq_init(&veventq->common, "[iommufd-viommu-event]",
-				   ucmd->ictx, &iommufd_veventq_ops);
+				   ucmd->ictx, &iommufd_viommu_fops);
 	if (fdno < 0) {
 		rc = fdno;
 		goto out_abort;
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 3c0374154a94d3..6c23d5b58901af 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -434,20 +434,11 @@ void iopt_remove_access(struct io_pagetable *iopt,
 			u32 iopt_access_list_id);
 void iommufd_access_destroy_object(struct iommufd_object *obj);
 
-struct iommufd_eventq_ops {
-	ssize_t (*read)(struct iommufd_eventq *eventq, char __user *buf,
-			size_t count, loff_t *ppos); /* Mandatory op */
-	ssize_t (*write)(struct iommufd_eventq *eventq, const char __user *buf,
-			 size_t count, loff_t *ppos); /* Optional op */
-};
-
 struct iommufd_eventq {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
 	struct file *filep;
 
-	const struct iommufd_eventq_ops *ops;
-
 	/* The lists of outstanding events protected by below mutex. */
 	struct mutex mutex;
 	struct list_head deliver;

