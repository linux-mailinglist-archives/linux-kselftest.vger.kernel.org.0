Return-Path: <linux-kselftest+bounces-21213-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575029B7B7B
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 14:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 775C91C20C8A
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 13:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB44919E985;
	Thu, 31 Oct 2024 13:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TnA5rl6p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDF319DF7D;
	Thu, 31 Oct 2024 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730380505; cv=fail; b=VPhQMssdCWX5eD2AjfuAJin5n9flmOsKgF3tmTZh8jUVj7w3oizl4YXNRWK5rYW/RbSl66aY9OAWxT+cgtEJVZqa7klfufM2IuC1KPYuaHFff2jUD8371azlRNJZAyJWoHw8YQ/CVm4x+3iYvj2VVVv1TfzRnezSaDKRPKYVIMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730380505; c=relaxed/simple;
	bh=1FfLI/wVoS6pOghXFdAV+UTTmltVsk8WUbiav7SVvaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bBbZ0b4w6O+H4OQmwVHv3YRDBkfduHEuCqZ0Ql6PZT8aHsSiP/txfdU6Ywm2W04uVv3qDsbPWoZZdSaF4Czrgmt2WjQ8eL7EwNjO8k0z7ZpIPh4iY4qkyQfDPZs9FuY846IGQEDOjDrVyoFjaT+81Bc5YXj+pQQbG37rTR7YuWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TnA5rl6p; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNUdkQFIWdOZXtwFk3He5lTpmFjRSxCyTNGYtlyHGB6JVtA/L+zmsi9gJCIvla8rsOCnnKbruaUzghVxhT7qDA+VTB4BWT1uYplew7vqYxpRF8n0JT+NokSaxt5WLus8y1gTIUYzeKpE/TYcHKv0zJY7bX89k0SRZIG7i7v4/xfmxCSxAU7fZ6tYV3BdaUqP2jn7KS9GD0hB2MlJMLv9s+clTqidUT/l8+FQLucpB16FyaXBd6biQlz1NOSbzg+vakrfnqMCVMBhFnlx3ubZRfalLIKyKmBBNTEZbu9Vca222jDGMg35qri1vyILotJ41kTk+LTacSG9z7OUd3ECHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2wE8+F9DZO+rnZx2bpQfbH3BWdhT8X2BcIUKYsUtx8=;
 b=GrJiP6RXzGpfqu0YZoPO95YAwwmJxTbQOUtWjwQmcl4n5LBwTFK5xh7lMTqkFA8VCMYQ1LgVLOhO1Pj1tZJQBsfR6bxXLGyFDZ2ElwsfeFE4wKoabrL6kUH1F6IcRNef+p/VqN12Rd+KTpU3JUg7V5rsttLJxUoj6H35Y71a7xwiwSO1wOm7hkXkLawxtSoyab9B2eoJuZMuVu9sq3CX9EQwTaUzPzajjeF+vVxGlHyJx8Yp9wQBxjAu/AoeH6Em1FtJbRlwazvsFcWyngE52Jtx7a2opIBsBZivBggQBBABUC9ldL/WEwmnvm88hKwna2sMEPAguH5Xob6BC7Y2WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2wE8+F9DZO+rnZx2bpQfbH3BWdhT8X2BcIUKYsUtx8=;
 b=TnA5rl6pGVDsphASGJv1zeKZzavY19VtY5ZVXcv7gtL9riHUkzVjVczhgh6sI9BxJdu5V/k4vwryrovTE9T/308voPfk2Sk4CffE0UCF6pUzeMJeOfcuWavYnddrsLb+jHdJolqXnbD9Gelti8IdfaJ6ZLT0bT4HLKnNuP0TrhMe/PwQC08WduhcLmSRCxlTayseV0OJFIJtGhJRYCNrZIZ6Xy1PEncYrEqZMHe7RuKErVlBK0wIM82Ff+yA73e73xd7OOjIkBk/DE5CX9fImY23HChZvFlrKoiBbOo1KcqtbCvBlWq4ZA+gevobZ6g4pmr1w1Gjezx+wi4M3po3/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB8423.namprd12.prod.outlook.com (2603:10b6:208:3dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Thu, 31 Oct
 2024 13:15:00 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Thu, 31 Oct 2024
 13:15:00 +0000
Date: Thu, 31 Oct 2024 10:14:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, will@kernel.org,
	robin.murphy@arm.com, dwmw2@infradead.org, shuah@kernel.org,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	baolu.lu@linux.intel.com, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, zhangfei.gao@linaro.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v6 07/13] iommufd: Allow pt_id to carry viommu_id for
 IOMMU_HWPT_ALLOC
Message-ID: <20241031131459.GJ10193@nvidia.com>
References: <cover.1730313237.git.nicolinc@nvidia.com>
 <41800674501340c4503cc3ad79affd19449a9ee1.1730313237.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41800674501340c4503cc3ad79affd19449a9ee1.1730313237.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0561.namprd03.prod.outlook.com
 (2603:10b6:408:138::26) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d4f6bff-cb02-4722-e70a-08dcf9ae0611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PsXOBEtejquM5x7RXHYx6JinrYsCHx8icMjIbxoX4+PWKOCCvRpAfn3jU+5b?=
 =?us-ascii?Q?iumAjRhu1Qm3XNl8AJE0UUU1rma7amG5wdaKFiM2MT6MrTacbr4+39QFl7hG?=
 =?us-ascii?Q?QSVnivKQKbX1IZzcxk1kmbCBuThasTtK+SyDHT2/QLx1SyNQHKNdZSy0A+H4?=
 =?us-ascii?Q?MnaAYbpUjakjWZf1ZKuZm9+5P39r4XbXA96zjLcmfEpOp6D3by6cj5sVy6xp?=
 =?us-ascii?Q?ssbFRwkh+GY7mV1XFFXCk2uOASR3eXtH2ZCuMbLf1vVHEgevcCQe37mOzJqw?=
 =?us-ascii?Q?bT/xAdDK3diz7at+W7UOuGXSR+neX2NUPiLal6CP8xfCQKVsKui3A22HFv5O?=
 =?us-ascii?Q?YlzBaRL5CG+Ln1JUv0zO149rFkNBwJBlx3bqNE61cAYTuR8SOPAiaKyHh+9y?=
 =?us-ascii?Q?4EJh/g1RyJCsGUMGubyb2FzPLdFE4FCJ5dHZHyvagngLsEIKrodqOIA0iKNK?=
 =?us-ascii?Q?yZ6SDtip+PwDYTscWeElIxFRro3mHOLvlL7/YLxOHTH/6PHZiJMZpuRbHGR+?=
 =?us-ascii?Q?+r5Lzv0rYeZOBqeme/SFewGKInDAUUH8xUcMpqG4mJeYnSx2aIvl15t2w4lR?=
 =?us-ascii?Q?Gx2yFKm8Q2vZysiDFO0A/xleKd+gw0hRVfLIVeBir3XPUo2eUYnGEU6s04Op?=
 =?us-ascii?Q?ojMz8nTiOx9XASwsZmfEGygqjhmG3MlKpdgJWVGp6UdohquZQ0Z3T9UBVAUK?=
 =?us-ascii?Q?SK6/Xc4NhgqlVVzk7HXbHVHun6AWsIp0eYFzL3RxNR+wxvjWh86Citw7jVFI?=
 =?us-ascii?Q?HZcVqL5Zpg1Grx7opRNtlZh+t0CBXgXRbahPJ88Sq1xdc/ClCNVF3Y/ZJNXj?=
 =?us-ascii?Q?/+nwUzMCFHabbA1JYFFKcbiXjeF3hq/vfF4+HaNXKC0XQFtbkGnZmhesNf4O?=
 =?us-ascii?Q?XBweJINN6krnf1OTLdjO/Bg0MeAkcTZsfUnvsyOW9hJeKMO4MeYMTb6ntkXE?=
 =?us-ascii?Q?HobF64WPntY2xkgkXNTBsy+7uNJF7F7CkvQjRuZdpU2lyinazhy8UOAHCcuo?=
 =?us-ascii?Q?n9clbYXdHF3j+HspPxWe6Hp+ZGphFLCe2SGfB6kg4Mtx7MYmilLWEn8xfOIM?=
 =?us-ascii?Q?+ChxcV0GBkOCyBQDDn/YUtOliz2/3d8AftwKi9CO1W3EueulksQ9YPOWm/wY?=
 =?us-ascii?Q?nG3tSj2ouhWl3L/RUqzaudGBVQ0sNnl5HXriIPN8O1d74QIVV+Tb4c2Xakub?=
 =?us-ascii?Q?CbK/VLoO5vEccAcmh6iZKOOpltpFV4zDKPBce4j8BbtNR6p2TTSKyGHbB5+8?=
 =?us-ascii?Q?4C81kNjIcwzODLOGYtwhg9/pVXyYPtNYSgFmsgOhRhJH/DSDKCwZOPxyQmUf?=
 =?us-ascii?Q?vHI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+l7H+pRN1mCAAlfGvp3C9jF0+Xlouq9aq3qw2yuhhroeqaffwjm0V73nKpRC?=
 =?us-ascii?Q?91WXayOI+bD3o/f2rCqT1BCUBYR7MfEW2JAaLj3uNWkOXyTATGRjL2XQHUQN?=
 =?us-ascii?Q?afaPPxPpxIsqhyuUBTe2v0ocBcEr4XyCo5iLmULMP4+yoHYgqajS8t27dhDw?=
 =?us-ascii?Q?ti97IXO1qcbukj1NuJ5X8I2TxqFfeGQ/YmB0kiroFjz6w4qZkrhjdlWyzK6l?=
 =?us-ascii?Q?125u6+sjeTup+6hlGMCYV7lLA4fF8Tb4pLMWw10ehZRiE6U/kgW2gz27C36H?=
 =?us-ascii?Q?v94R9qLvXxY84ojqotWX3R7Fvm+1IoMkOpoKjKl1MmjPYFryncxmb0uGhe+Z?=
 =?us-ascii?Q?mI1NDPDWo1z2ZHBpiIgf9e2XVLzeBGtQButZG4zhBZ1hXlGaESdHGcFFXfqD?=
 =?us-ascii?Q?4hyfK7+69jbyc1arcEzo+IFTqSQyunuArXLm5wKv9M4dFWHkyMq6fTLN0XqI?=
 =?us-ascii?Q?VkJKhRvXMLT/BJ7NHnYVcTmnSVy87z+tNwszMX/vKQ/LFtgOR/snMU7m5I87?=
 =?us-ascii?Q?HRryd9qrX12Jmen8kZajr1G0o8v++ORul/1rrJ3LNyVdLb6atxRHi5/eV3qQ?=
 =?us-ascii?Q?xsU+DgaNSU+rf/aKLn+j0XOe2h8OZ5rMooHjoIiT9pqHC1DaX6DXnxIp7jDr?=
 =?us-ascii?Q?NwKin8b6oNCo7cR2tnZIvkcfuoM+zxJ836ijeCEt+xbD62YSAz4fEgYRGVpQ?=
 =?us-ascii?Q?PlN/35KFSEo6SL08ZTm3MPnOAnrrqCifow5NrJA/jgjhzda9+CK60m7iYWEE?=
 =?us-ascii?Q?FuxBR68FDt1h8yOY6FmxP5ZY6gCVJisILeJQgHTJFCg/lXs1pxpJ5MN8EYdv?=
 =?us-ascii?Q?NzsUJ/bslcGYKO8cMvJ2tddoz7lLAoe+0uuuRwVleglupaDrXyQfJZ5gn+zo?=
 =?us-ascii?Q?y05umxFZbNpkp6KiF9Pk3gNb07YuvsgyTjrgTG9dtSzzPL21I6SpA81wteT/?=
 =?us-ascii?Q?45p1X2/Qqk8b2ZeOC78ltZWinI6SCMmNGo/fQ0nCwNLEN+4ilpx+gDPjN+tw?=
 =?us-ascii?Q?ezmH4Hsd3eGfgDpfCXt6rv4Yagie6a8BIIBJuYmGr1Oyer3c/+sxkn633X0v?=
 =?us-ascii?Q?vbSSPu/qnmUtc7jpM4g4f4n0cURxMT8Z/JaWB0hTVB3s8tFYWmxes9fBgH98?=
 =?us-ascii?Q?qQV3yd60n0crbpnOg4MCQXctu5z0hRKTUJIreycJLdJ6LokXgNOh3jtr+l7R?=
 =?us-ascii?Q?Eu9mzyzDxOyzgkSzYafF66AAn2Fqtb8dIXgQ+8xfzbnESqRudKWuSov9zHUx?=
 =?us-ascii?Q?w4bzX/wNbizX9e6nT1R6NnccdFSC9aIyfUk/IzMKZ2f11v/NHM5+EiLlWpiM?=
 =?us-ascii?Q?QCgszVc5FFWEpGZt4AJ+nKzxnBgIzMY6c0SjWhsziHWJsRasq7rb1GBD2M68?=
 =?us-ascii?Q?HUK1oLanyviWFR833ZchvQHfWDR0JsQlvPmaCNIYXqROeR7HJGPY1o02wF7v?=
 =?us-ascii?Q?t98Gl+TjAIYhvZdAETyBtXiTUtdn5s6SyXBtrjTLR/TVTcykEIAjjtPSlVHO?=
 =?us-ascii?Q?B8g9yzmMqJDnczExBhzI70YeTsTBnAhAB7nDNdEN7yyVDFr5kJw74eilFW6p?=
 =?us-ascii?Q?xfUPWdFCuGAYIPye7pE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4f6bff-cb02-4722-e70a-08dcf9ae0611
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 13:15:00.2720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 53HSdF/ahKeGysnjsQbJFM5l4TK7uNne7nuomUwOoWoQAqWks4xHHrp+/8o9hrkM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8423

On Wed, Oct 30, 2024 at 02:34:33PM -0700, Nicolin Chen wrote:
> +static struct iommufd_hwpt_nested *
> +iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
> +				 const struct iommu_user_data *user_data)
> +{
> +	struct iommufd_hwpt_nested *hwpt_nested;
> +	struct iommufd_hw_pagetable *hwpt;
> +	int rc;
> +
> +	if ((flags & ~IOMMU_HWPT_FAULT_ID_VALID) || !user_data->len)
> +		return ERR_PTR(-EOPNOTSUPP);

Now that flags exists we are expecting the driver to validate it, so
this check on flags should be dropped?

Or we go back to hiding FAULT_ID_VALID from the driver (and keep the flags)?

Jason

