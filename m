Return-Path: <linux-kselftest+bounces-34376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CC1ACF2CC
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 17:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 117C416229D
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 15:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2CE19CC27;
	Thu,  5 Jun 2025 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mZy55hG8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618821E519;
	Thu,  5 Jun 2025 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749136614; cv=fail; b=t2GK/kkN454tw8fyYRNBXcNqIMsq+ZFNEqz32xa6t7E/0qKp7MQ2EkUacoub41n5lkkJgSbU3VOWhZpY8H/WYcgmBSKE4fOJQflI9dIeSunYzgXk0tMG13GHaK2lzbXEIqApKf8cs/SAPFP9WpQERjQjCSB96uHT7xDi2DVVI7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749136614; c=relaxed/simple;
	bh=11J9or7hHFx01bYmpXGNJjW3c3Top5SfI1lRpMng1dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Dn8rQ1AgATUb0QrIQ9QNuzz6Xdrt4QeUZeXa0v0lKgKhjg8bshQHuPUEzRHv58sja1f666n6XyoPsqaeDJCHDlLoCIxyhD6lXlHGWncT2WO3WabK0RoA1q0qQplq/wT0bKdLEjyLXoU/GYPffS7G2UAFfZMzJ2p+PgDMCi+38ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mZy55hG8; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWw003qsCO/67PFq8xE0dHV4h+EfJu/DFi1CfyT78LDGG5j7/nMFNWOnifXr6oLJLSasrmkh6BW3bgpSbMKQ+nXWt4lzbEG5Lt1AfyAhL6bvplrH58pa1GvYmWjKsHuw7F/4C9c4ytjtN8UeCuIDnkdy8ZqPWFRmaTEjOpPmU9ukhAMKCmLhVBycXi42Gg5Qp++pzDDjjG6fOPEBsgcTpU8qzrw6EOmWZdcLE7aNTXJ3DDx0y4IYrEgD2yEccb/HKWJzwbT/0guIHFAJm4rRBIFLQIRoPKZEOjIJD4jqIumg8Mcvg+f1wum987FohpV02Gh+LV3uG0eAEzSSSz+Hvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11J9or7hHFx01bYmpXGNJjW3c3Top5SfI1lRpMng1dQ=;
 b=BkeCSZd0pPaBq5sSdN0RizoW3GXylCTBZ8j4mRn+5a9haK+l71A5Vo37xHp/zNKqvd739bX59s5dHP1/+mAqzZE+FT0zwTbTL08mtczLVZmOLWJbYaD2z9LxReywKMjtvQgKCeXWtp8EQV0+3CZs/5TtV+tZKHe0whDsv1q/amJG0eRYlMK52MSE2qy4koLEW0vKIlharC4h3GL1rQt9adcJsJHeYIsO0o8dzDc45H8LA4WhxrSZIB2Zq+mcbCqI/8SBLRs5xnwEEIatv9fWvP9YNg4szys2AU1sZz6rCj9jSKJL4Kjqz02BDUD20fqYUbYLqnEjzJouncJBsg6N3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11J9or7hHFx01bYmpXGNJjW3c3Top5SfI1lRpMng1dQ=;
 b=mZy55hG8mMKu3KMKFebKA8tDCcf7o2r7H2bU4WuWXMph7b720sXF+ke1FpvuBtsUxXt4AzJYmlT3IrUJcNgCB8f7vAJwS3kTdG9t70quOpWvvQbi5eIlVn0aSqwFS1bIlHNb/I/cXEiAo3qnpeFl410yv49Nj9ZFUOweV2KsIjhkrlS2B+wJ2eTEcNMXKWSJb/NEjRx8yr3gqrk7xDEcP1wFyo71WWBUzH3pPX8ee2T5z7QJk3ipRriWiEvSDGUEb3zoqz19j4xFIsjH42CX1tOxpe6JPGXFBSUTW+YeSDPz8uMBgSa3OcxxUGspNWgYsH6a/hQ6RAS8mepw/ePoWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB7751.namprd12.prod.outlook.com (2603:10b6:208:430::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Thu, 5 Jun
 2025 15:16:50 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.034; Thu, 5 Jun 2025
 15:16:50 +0000
Date: Thu, 5 Jun 2025 12:16:48 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v5 10/29] iommufd: Abstract iopt_pin_pages and
 iopt_unpin_pages helpers
Message-ID: <20250605151648.GD19710@nvidia.com>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <49f7143c1b513049fd8158278a11d9f8b6c837d3.1747537752.git.nicolinc@nvidia.com>
 <20250528171754.GY61950@nvidia.com>
 <aEEY28ZXH+NqiE+T@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEEY28ZXH+NqiE+T@Asurada-Nvidia>
X-ClientProxiedBy: YT3PR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB7751:EE_
X-MS-Office365-Filtering-Correlation-Id: 3393bb65-45b8-40e7-e34d-08dda443feb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kWQsQNkQ5OGSeLTcX+XjsNWIxWoDvYKbrAazf3CgJKwz3EA4Cl/9eUV8O+AJ?=
 =?us-ascii?Q?CGNGCwwLmEKRjn7thVRoeeqEr4rTCXzSgD5Wh4dzwjdzpGMqdDfwPehSl3Ma?=
 =?us-ascii?Q?2nn21HOFmSdQRq3Fg52RZvZNTJBhGGzAsOlfA0lW/gS4g5C8vkTvUusuYIrP?=
 =?us-ascii?Q?pwxRhuR4PI0ZMctL9PAtGD4eL1OZjxO5BnFqVpqhwwNH0D4wtNfJ6ZlT9sFM?=
 =?us-ascii?Q?YlQOpaZTSY7hnfH9FA/NQeemDtcmSPeZGII+62NPioLL6A9ny8IwOCwcispB?=
 =?us-ascii?Q?BODZS1PDaidQA3fN7rId+q9JGx4wgUESplK3ZgbQFavYImbzCgq4emTwtJ2j?=
 =?us-ascii?Q?5b3owQkcw6S8TfDcqFaSY2fkXJEnhaHG7Vnbmx33yU4BRIQ5QuH9KottmEdb?=
 =?us-ascii?Q?HfHKhUGrPVDj7uJSaggv16hkB33OZXJJ4KpyhRE9MR1EGtJM+SKyDiaSTVxX?=
 =?us-ascii?Q?f0dcuikzGHfw0ZMYCHebO03TSGFobKhtMHwB/5TiQYB/zwxeLuHAVM8mYbjm?=
 =?us-ascii?Q?33caVmyRD3sAakmNTFoA+xOveR3mnSoDu7oBTRmHPjQC9VNTyq6AxjvFYEvk?=
 =?us-ascii?Q?3g4KwdasEH0/PESwUTrkMiWUFDvSNPW8JdOOrDIWc0VVh69HHf96ICyatKW4?=
 =?us-ascii?Q?+rEvnTUrCzqmYW2M2MhTBYAwMh7QU0oY6MnmJvnr6ebNveXxyr/pk3BucTTr?=
 =?us-ascii?Q?jXZWDdfGi6QoO4hFWVMOSqigcXc73cxZFh8G1sJXh8ajtgz8BSXnB8JONx8N?=
 =?us-ascii?Q?6AeTSlTCxEg1D3I3HXdl6G906qVDHf8V1+geUXcU5EN779vbZnUU4H+rNUtT?=
 =?us-ascii?Q?i///AERaWRJ4QBB5QOofNGtzpAAYuVRGGSFJYtZDN4iE3C9T8VaMDKQLbJ6V?=
 =?us-ascii?Q?GzfFMJa7dFr6YNbHGcNOMNMPeKCUjrUbEs5cMmPK+6Y8RutL75AaInBRRZDI?=
 =?us-ascii?Q?21dJak4IPr4Kx9uNt6thtFD0tMj2bUyHZ/HftecX/+5w+52ZpGWluAu9V/S7?=
 =?us-ascii?Q?W09ESxuyZEiVnmM+haYNnMI34qnjBCFsKpA+AGLMrjI4WLcxS2pEnrM1F1fK?=
 =?us-ascii?Q?ERpr3JJBLK5T/ng1LSCHxvND8AkO7nzo0XC4kOWenQtwYMhrZKPI2uS98F+h?=
 =?us-ascii?Q?/KXmFTXewIsXnoYr26R81+tvUCbCQTn8nzU0iZhCFmMXqcw2PwP3WKS5OA5U?=
 =?us-ascii?Q?C6HrEarewEZWCnu/yUaEDARxwjncu25kky7LzfoWDyeSg0j2ewjQVq3PF/eP?=
 =?us-ascii?Q?i8+9m+shDI0f5RpXJyej6X5MO4C3gHqiIeZn6R/LXEP9wIKrCX4QdaV3nhRe?=
 =?us-ascii?Q?R5AC9oeyQYK3SR8IO4hDUeeKEk+rb1XdYBpJELkIaadtsiPzU8F2iRPaSzxg?=
 =?us-ascii?Q?lOXDZx9xyJKiGg62jFaHBh3KDhKgzm12ITC3UV5r44+ML474zg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?creKiw5NBnXxD6HwBRM8uPDhEIk+DLNEPhdDzo/lFxmo2D4j1VniDY2yUA/r?=
 =?us-ascii?Q?OjZYDOPrEl6gc5If58I7biFjHGzF2XZMaex5twZV0ylwkj3OXF3b+kTgdv8+?=
 =?us-ascii?Q?RZ0wCNzy+cQMbW6XIbGmPwntCBt4AraHvptq2JrCV2m37NE4RhJN4TnccjEx?=
 =?us-ascii?Q?vVGsnsGyAUtwdqdMnK/N/uYpjXBc9vGhT8ccFlrmJd/v3/dlxncvlvov/JjN?=
 =?us-ascii?Q?HK1NClkq6V/1VbaGKhTotbnbDg+huOI0jOSu1YjlVotTnN2W/44K2+Mjbphe?=
 =?us-ascii?Q?zOe1js1kgBLI8R29z6QVL0tAz8hfwz+UAgfn7qLoyfTUuXIsNiRfKDvmlT/k?=
 =?us-ascii?Q?2XLTE8Nay6Xh+XOj749SnxGBarORZo/0as/JlphcGLSqlU3Os1G6QJidEmWc?=
 =?us-ascii?Q?NeGHQ4duPrpXY9sC6LSjsi1HplQ1FLAATI4bQeO87r98lBPcoxFNEUibbUxz?=
 =?us-ascii?Q?tABTvRKCePtXO++Cgqtrsk/s3ie5OPHXjk32gK56GfxM/DCw1l28xoGLc/EA?=
 =?us-ascii?Q?RwZopQhEHlAI5Lg67U+nhwWxZlLqH4hkkb6ZWDhWufx8x/ATp0g2VI7U8PG/?=
 =?us-ascii?Q?V1rSXUcBvlb7bIydJDMe0NPZv9dK8YzbyUsK7/SsvkYWe3yT9+W+/ZgavVn9?=
 =?us-ascii?Q?IiPJ3x5baZfdGgu6L0chf2RRVecMXrXm/Z8Yfv1e8oAy1I0Mj1thQjZ8+8SM?=
 =?us-ascii?Q?O1borBchEmemvxacopLJ7r8QgELDvUNMyW3sYJySFfWKP0slckgY8Gufy0ea?=
 =?us-ascii?Q?7MwSiXorV1H1LRhWw+rSS1XjbmmrWBq5u8y13R3oKw82ctdQbFiu72wZyMxR?=
 =?us-ascii?Q?HwQUjTwx5BnhAiARPwr1KA6FwXZcD8nFzDgH7BZipLrUV8AMeO9o/JOvdBqD?=
 =?us-ascii?Q?+s6/8mJ3IJ1eyA5GkLUNYCg4d/UIl/noEY7yZWJ/haS4ngjS1GUOMBMx5qF9?=
 =?us-ascii?Q?OTmR89SzBbxRTc2jjeEVugVfcBQ/NYj303D4XXIEYadh193luGKFhGODCEnD?=
 =?us-ascii?Q?ZpIDfIT3qp7WC2eOs7BfbFTZgR3F84G8tauKoOAlheVeCyIx5cgPW/Ux2bcp?=
 =?us-ascii?Q?ZBxqMLDN/XjNLiceV0LkuYUFslcBXx14/Uqra8Yo0CgTwFrYJVxaBDFYNdl7?=
 =?us-ascii?Q?akBT5IMI5oy+BqYHu22BrtYsLilzn6+UWD1GPnwDISV1J6+R0DXK1WcmisMl?=
 =?us-ascii?Q?+YQ3yj9zqLe6sArtcV5VFGsG2kaivmrNAVDUy1Z48ZD8jAC62fwBZ49LsSFi?=
 =?us-ascii?Q?+OfnQGN2+6IKRHNklQC3t9DSu4RnrPyLpCFGTBVIZ6r7d9/w2UXcl9W34qxR?=
 =?us-ascii?Q?NseClqQxEIDKbqQHgow2ORqc+UDPEg+u6kz07a5nunzrUfo9/aCciojofyCb?=
 =?us-ascii?Q?KeOXTCsc6OIAjuY14ucEwIi2eznfW2/vJumrUXCgSht9BT1O0uZPGkPK+BEi?=
 =?us-ascii?Q?/L+bkBAiw9IrsSp7P3SULQqrkTk+3H5sj60SC+TmTrO6i3iilOK9EAuVSKa9?=
 =?us-ascii?Q?l//lhYWfQ1HUiKeOBTt7BUACA0iU4pzcTddVo+XO4+rR8ISOlZg8GRiWSdYb?=
 =?us-ascii?Q?/W1fRGrFUx3fpsm+cXYitvrbfiiV2VJzKZyASWYd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3393bb65-45b8-40e7-e34d-08dda443feb2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 15:16:50.1431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W99+bT0L43ksdcNTYMPoqGO1MpYOjz2rcwbjzfgC1C9+uZykJt7hGwrEltMI2gsv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7751

On Wed, Jun 04, 2025 at 09:11:07PM -0700, Nicolin Chen wrote:

> I found the entire ictx would be locked by iommufd_access_create(),
> then the release fop couldn't even get invoked to destroy objects.

Yes, that makes sense..

It looks to me like you can safely leave ictx as NULL instead of
adding a flag? That would be nicer than leaving a unrefcounted
pointer floating around..

Jason

