Return-Path: <linux-kselftest+bounces-20031-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 008FB9A2CBB
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 20:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320911C2640C
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 18:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BBD219488;
	Thu, 17 Oct 2024 18:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WRdm+sxo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E001FC7E9;
	Thu, 17 Oct 2024 18:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729191259; cv=fail; b=ExjcBHGXkuZXDqu2XYlf4jDjTVD+Xq6DhqtgkTf2xgCMAuEhm+GMoVqWtz0zW50EOx6Qdi6YBoU84+k4XBKTBTWiu/ZEjLLhgbqQgGvHIMc8o0+1DGRlXfu52eePBAS92DQkP7lqojnk89i69xPal9VavYLQ1Fi0nxVxS06NJ7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729191259; c=relaxed/simple;
	bh=O2UAkbWmwOi8WaakdNCawHb6xCFKl6ALU3nUb25GSdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bzlHUom3vDC45sVu6YGCO2YWRBUGmWRlQBQvF0Z4gj4wfCAWj/TDZ//+R/FEJiY8PSDSmstsWJMcQpKr01b/4Fvl9AfI0laEZ8tYi/xkzIo6Zrm8D52zU6jRCPaprkOnYi0go0ITySgXB+UA+3O2qW0Q35h9WdNFHaUI3fsHcn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WRdm+sxo; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=doEBV04mogEZ05yJw5hsgn9WOE7SjprTEV7f3j5ZnCyCe0Ytq6VnmI0t+5z6VXyg+SMIaAEggKspylxlUhATiartBsTrCuPa75gS1COom3J//gl5d8mSbP95tODHoL+tfs3aRFsWG56SHHVif+kkjAbrQoEVVqQnxGN65JU5076cwF22JwT6yIDrTDMxWD2osmTVb/UJdev/U7wt6xrryeIFelHtprn7k8QgZ5Pf7Gmt999yQ6Qfpf3L5SnDDnKWyPcaOQDEZBipKvm21sMkj8H4uCcrlGa6mnzYWZmGbtv/Zq+MZDWcpoV+63wloxa8owr7winy84nfTfbiU+MeZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSqH0pmkbl7IelhuXNFy0g5TyOFLqqP6etIBrCH9Br0=;
 b=LyHArpWnbAO5KM/oydzIGDsINhq/zzw65XDedxEcny26BczMwtwVZ8NL/RvVTx9V2c5XgIRrL6/+RWsGRsym3rYEnSPKsM+E6J9jlbVY9s2xC9Ya54wwnobMaSvWevP7kjNLfOJsTfdY8y/aomR+KHmgiKsjY7hUcuohMDF35wehbNSD+o0Utl1i6EvwJ2cl2InfJMNly/b8wz6oKnlS7r9YegnZSdpnhjDPBIPOoO2+w0V9MVtfbQ6DS/dGUPos/iJ15+N0vjEHRFV0IYo+tz0LcKP95A6WtWTgLZCUnWGzCxm3yg617Ipz0DSUEDK0mrFehS+USPLzHdymH/ta/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSqH0pmkbl7IelhuXNFy0g5TyOFLqqP6etIBrCH9Br0=;
 b=WRdm+sxoUdDNMmkNPj1gWI3auvEZOwECQ1x7jU5F4wVeGJGFi7lYzO/HMgeikCBRra+44ZdA4T2q/cEDAtszee4vIU8uDp6oA+NPEDVmCyep1aElJgJlSFWM7sYBgetwkwWfLpzuvELz5qogfHWr4vVBKYZNlmUzIPWTbV6ezn+hMqJ9Mt901lC1soa50BaMdiwjtz84O2ya8jGrfag20iL812n4e/n+AQ1tqCtnn2Rx8rlUO92wWnomF+oyPu+LCsmb2wglU0zkuKZ1+R9LKE7QW4Wnuk2Dku/X2h0be1mjQm9UqFZzwMlgWzzQQOOxLSJBxqS+MikejS0ZeIyC4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB6213.namprd12.prod.outlook.com (2603:10b6:8:97::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Thu, 17 Oct
 2024 18:54:10 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 18:54:09 +0000
Date: Thu, 17 Oct 2024 15:54:08 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, patches@lists.linux.dev
Subject: Re: [PATCH v3 06/16] iommufd/hw_pagetable: Allow
 viommu->ops->cache_invalidate for hwpt_nested
Message-ID: <20241017185408.GU3559746@nvidia.com>
References: <cover.1728491532.git.nicolinc@nvidia.com>
 <cba810b86d0597715738b4fb87084eacc734d8fd.1728491532.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cba810b86d0597715738b4fb87084eacc734d8fd.1728491532.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0626.namprd03.prod.outlook.com
 (2603:10b6:408:106::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f44bed0-5216-4fea-acef-08dceedd1518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C9Rqh+yM8t3RNS3QnoP8M8/zUE43YibsTkI9ttpw62IcCpZFXtTF9V/vzvry?=
 =?us-ascii?Q?j0hEdAy7p23aojkUxsGJyC4jNcIPGZnyWWswutls/zqHkgtCTJXFT5nfisHK?=
 =?us-ascii?Q?iipMqmv3YqSCemGpDSS/LohSiSZHD4KIUHv+hkVBJVdatPp1FIfNKhA6j50Q?=
 =?us-ascii?Q?RgIex5/XtzqKpXWdZFqafdRMJ14K6QjAjT4EZ0zrKM6OgPdMnwMIDwSuEyxh?=
 =?us-ascii?Q?ayjbWkU1FqKc05H8c9TNC6eSrcETGRlILhq6rQHEBiAIBZarPDZNuRJDxANz?=
 =?us-ascii?Q?X6M7C0qtMgm90hQLuPztSGue62+sGqVwlkESYrWbeb+Waj+AY1QNsuz74qAp?=
 =?us-ascii?Q?JslV3FfiCWjcF4nG6xfpDG0DswX5NnGLTs9LPrxCLqhG04T8Sywtkd6eREsh?=
 =?us-ascii?Q?4E39KJHJZR/uFJ+qJhtOqcpWHwe5vVUr7auL+A+plNQUFzTthqkxdkCLRPVf?=
 =?us-ascii?Q?MoPnbvUrRVgXCfICiQkHYXj4Uti51TPJynJx8s31OtckHlvtJo/A5WJ5qlkF?=
 =?us-ascii?Q?BmzXh4lsVzT1Zdwy9ulLPJZHn2CSbPl0Br61aOxIT4Tq+hK3MbBbWknxj5LU?=
 =?us-ascii?Q?hMh/sCu90CfUhrbCmMeihqbT4/geaPWWa2SiJBFPDGYitvF6NV7tOCO1SOfD?=
 =?us-ascii?Q?Twbie5wYVe4RLB4Ea2W9ozLHkh2FEqnz1RHBrzzmthbk40RgMj6eDtIaeD6n?=
 =?us-ascii?Q?pHD/FZcCZyWXX3Y5huyhHpbtd6X4XoJfpVk5Z2Dwps4HMWV4mfMc7AKTkeK4?=
 =?us-ascii?Q?6I1UOHyPB7kzPoWq9MKkTz/hLXzvY5QPTn4fLlY3CVzjk2YdFSgMN+mgViA7?=
 =?us-ascii?Q?1M9mvDoHrD+L9aMa7t8nEQEEaZM3OnjBQw+1Ct0fnbrWKClm8Q4xwQPX/In+?=
 =?us-ascii?Q?Uw8xXBm2HftiZIsHFNYe5Qn+VbGb5UGKMQ4azIAj58o+SqbctEfsi+FcIYUn?=
 =?us-ascii?Q?V6Bo8cXQOd+HmDqEMzzJ+0/b5DyAM4M2BbC8XsCLC748WZtV49KXax1LXgyg?=
 =?us-ascii?Q?gTIsc8D1+e6R0UQcRi5L7YG0rGrN7qLNrC7gWC8sZAb7be/9wgUL+HT9MgV8?=
 =?us-ascii?Q?evs8Cxo5WbkZApSrA+tL/rbGyiSRbrq14XYhF6xc36sjWFG7JynA8L3uuczj?=
 =?us-ascii?Q?GA8ISSWER/d5+KGamfkPIlUGxOOHY7akZXsVbNuDUUJ0J5ebwm7FkwmjFqK8?=
 =?us-ascii?Q?16fltKiFp6q1xH2BXO2zjKwtMAf9a2dHPkQwHtgjXK7/K2RJjX0msIzrF7SG?=
 =?us-ascii?Q?/inluZ9UQBQnVCaGV6pyc7XT8ONkoWlK6SO2+RvpTMNzD7SkwoLEVqtJp9/Q?=
 =?us-ascii?Q?55shFhEURTUdzP2okgmuzARi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/59icQAiTYD9UFXt6jTS+gC3cjuD/Jg9+JfPwb89qYVnSiHjKFkvnSHLTK/M?=
 =?us-ascii?Q?22IJmBKx555j/RvfhzWLJpcgBfw5m7/O5rKNeKdOu7XNVBpy+x+smtTPfvVk?=
 =?us-ascii?Q?bdLsSa5dOSHTMttx1ednSS/92DNDBGN9gqpzRLaY3AdjbDocKv80f5jbhkYh?=
 =?us-ascii?Q?b9dZ1QS0tjALUVyVufyxj+OuAIMN6SqSZCru1z7k3jWDxkUQTzPZ5hoJIRNz?=
 =?us-ascii?Q?k46yKKF1zp6Zi9DFBY3S40e4yS3pCyUUkLrEQ/CYf3CBXj1Zau3LEKVc1i+i?=
 =?us-ascii?Q?NzWAB4DNvqB6OvEtP4+vnY26hrzeFStZnfhlAanrMeSeCZFgwHBk3EmUzU/F?=
 =?us-ascii?Q?gXoEowlrXwlZMbEzPkKbX0a4httDRqnSSUaEMCcQ6WirzjiHq/l2RwHUG57Y?=
 =?us-ascii?Q?TcqfhFKPkegS0Px+Go6vKwX0BdLBIsrWZ/OOZzmHnkWdAOV7fmU0AK1gRiiY?=
 =?us-ascii?Q?Ty+VuclCaLV3FWR5xeROEw7rnwKiH0eQ06JXPE135jdhWlf8giqjPFEf1reC?=
 =?us-ascii?Q?k5P/ziN+xAvaw28FmhHMtjm1QG1yhlHLhieEDFv4I+S58+bUUKR0nK5zTjM/?=
 =?us-ascii?Q?eb9SkNZn8LYTB+KqImEYSsiQ973sLBZmk9uBOIkW2eHYJPxQWVqezZT9fzaZ?=
 =?us-ascii?Q?FjgYzcwKHBl+ntXqFyosdZ0ZQc5YOelp+nxQv7HFHHsDVYe5Oz8OVG3r81Jo?=
 =?us-ascii?Q?d/Yh7retkPPhQ/XJqQDmFr+mbdGpiq9Qwe8z3CaPnORUkDaVTtBOm165qHA7?=
 =?us-ascii?Q?IITuhsVfISSYcb5pk3yDttOdnPnvysU2N2SthQv+5HdvCR6wF8sBxikjMh5+?=
 =?us-ascii?Q?1W52GwqghdLjDt4VOX//OgTbqWA09KMMtA4RJnhlnGjFigiL3iScWmEr0ZsX?=
 =?us-ascii?Q?BzZjVq9flrOyvMFgxLhd83/Kk6OCm1vEqxZh0BchkmmQgbq28zN329vdDizn?=
 =?us-ascii?Q?nk0QpJuLgFSswnW41y03biJYc7ovUZxkg/6AzvBlrWOsdKqae/Lh/2ukBO4M?=
 =?us-ascii?Q?ZZw8fUNMYDxzdAq2hcdQ3J5WBsYpCriDBqIGxyuvQn4NsueXmYPjJDNDTvot?=
 =?us-ascii?Q?9Hk0GLqN0JYtbGrTZIMwofYeW60S/XNDdNYf8Nt32ii6cpKP6tMTRAyluK2Z?=
 =?us-ascii?Q?Simzon5IMxj+zNFK/RrG+HVVTPT60gDCRhc9k+e2DPGIQuM7YwtEVYAaeK35?=
 =?us-ascii?Q?O6Cb8o5zu+xID54bfe9Z9XabmE4zshXJ7SkXx3VGFlI5/5ii8r+wigLcmEWX?=
 =?us-ascii?Q?W6JoSmxogHhAmC27/Vgff7dtVr41XyoD5vIUHFuez8zQcXcm7yKt/dTPA/dU?=
 =?us-ascii?Q?eVRANu/lF4BwrteZ6Tn7GUYWGSRd4ISWCXfXRjkBOwpggGzNY8ufjdUZPwK8?=
 =?us-ascii?Q?6PEdZB71jUlwI0WAygfUPGE8tLduUBvg3v2zWVpnUt9fjGyWtQjJk9sZ0g5W?=
 =?us-ascii?Q?nBWSoUO1VVTl3dvGfULqRPror2jBP4h9hNvNLOELD84ZLJVWsEak7GdX6rDg?=
 =?us-ascii?Q?FOOidJJQ8ReBlFM/6zQxXe0i7jU9J0zTuUzpupLomttVu79rjnFYIevCvTeA?=
 =?us-ascii?Q?xWn2KOvh/uFtvkH0Khc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f44bed0-5216-4fea-acef-08dceedd1518
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 18:54:09.8808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75Nuz+x/H7qkAZd+F3X/kRJUpJrhwfBohZ6FSE58svzOgMuchJeu0pD8jzOTvbnM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6213

On Wed, Oct 09, 2024 at 09:38:18AM -0700, Nicolin Chen wrote:
> Now cache entries for hwpt_nested can be invalidated via the vIOMMU's
> cache_invalidate op alternatively. Allow iommufd_hwpt_nested_alloc to
> support such a case.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/hw_pagetable.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

