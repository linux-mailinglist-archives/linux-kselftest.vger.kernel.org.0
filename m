Return-Path: <linux-kselftest+bounces-26135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D31A2DFFA
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 19:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 724887A13A3
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 18:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DEC1DFDAB;
	Sun,  9 Feb 2025 18:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ufsq3LGV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C26A1D47C7;
	Sun,  9 Feb 2025 18:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739126519; cv=fail; b=qstIllpr6Bc3g1k1uKTH0nvcwv5PNV5d6lLZbe6XUT+XXDIyMRDbxvp7iIX9B/ZzyU0rBMyCTbsJBHi6JG255bWGvuCrkyFJ03EUvwktDddge3pft+2YAsSoAbWBAx8BI+GfZVnq8jotqgWQohnMbP5y/UVGwLW5/6QMxRHqaiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739126519; c=relaxed/simple;
	bh=ZrVbVpGZl0catAjAl7a0F24jdSNm16nB7+Dmg5ew/p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R7RBRZOsN8X7RFTzTaECGSs4B7cBvRGCV9ePBQE/vXowte/2p0cH8nNTYqQOOd3dLuJR+taCepdncCuFBZcvdLxoptUpl1lhyM2eiiCi1hOQa0M6GYR6pGwhiwk/f10zoMrZfztfGZUZj59KBfqOWNt9AtNjLf0U1W7PkLFy7X4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ufsq3LGV; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhGBnZd6nJzREi4Ijsht3rJmSFdici9A26ln9GJympZM2lN6H8kO6B/21GRsJOvHQcL5mVR9FwczfpKY62tA0TlBs7JiB5kRwqz1y1sBIf/5a6gMy9m8IS4PUs5y+Ggaa//88ir6F7Z3xpswnxAox/+PwR2ybaYv5tqUS0Xp+a3dls4ovpTygsblJFbY2I8aBAYwKjaJrIcPlbQPWmP/GLwpHx2WbHWPNKM2N6Lk+r6uPy7+P8TIYpxaGRgfxzW/EXsVPqxKI0j4ERe0oi3g73aqdnOKd/noY+Zheyi0VloRPyJ86KaPVWLH6NkzeDEwo6GUb5YbRK1L2nnOxb08XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYgvy+MD8CqRbk0HLU+Ru14+ghRBhoi6cWdRho+2nuc=;
 b=xjILkZrhtvRTBBxhMwo6KthzNFBNmlc/5ZcVbXgDq7UAwxRFX8hlWPE9KMj/7TeLpH9C00KX45v8kQFvKgffXsm3mgnnxEiy21/OOsyj0fvqn+HVxsDAaFMweGMbxzv+RxSn+vWjjO+dbPpqy3v6aCZvVbkZVyHWwYH1RxvSSbDsGNDQ992MaZHEUpiTSLoxp7m0cUaejpfuTYFILIuNzppeS3zrbkOYqY8b6Txk7KFGo6BgYMu/bayenQp6luv/dWxUlIT785hx6NfHTguyYH76ZcsWwY+9D8TBedXPW+9gUFTFwIKd7TMLXpCmjrA4HYQptAha+ioBekeQQyvmIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYgvy+MD8CqRbk0HLU+Ru14+ghRBhoi6cWdRho+2nuc=;
 b=Ufsq3LGVBh4JIwrBQ6J0D0F+P9QN3RQK84Ih+fHc+DRy30PkuP4rqyZjy06Gs5xGfRDu8tTUznfKT6wdo8S0NjKHFWcOPMIp6FaENxtEdPqKLr9xqLb+s+nMSL8AK09f/K01s1awQckELeRnhUcDgMunXrk9HMoIT8Sr92P8mtIcaTZjxoKDWFd2CLaQakhV5Z/FYlste+6+xO4FS0O1wErcROSbYmBgYz3HAeXMODWOd6NjEXS0LL4O5deN0cAZiQ+8KPE0Inffl87UFHJP4fIY0nkf8DfcGZHKapkN1y7wvnfIr4vmM9o6mAC80e0dcPHnEq49is0LJIu8UzQQoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Sun, 9 Feb
 2025 18:41:55 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8422.015; Sun, 9 Feb 2025
 18:41:53 +0000
Date: Sun, 9 Feb 2025 14:41:52 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, tglx@linutronix.de, maz@kernel.org,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	shuah@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	baolu.lu@linux.intel.com, yi.l.liu@intel.com, yury.norov@gmail.com,
	jacob.pan@linux.microsoft.com, patches@lists.linux.dev
Subject: Re: [PATCH v1 08/13] iommufd/device: Move sw_msi_start from igroup
 to idev
Message-ID: <20250209184152.GM3660748@nvidia.com>
References: <cover.1739005085.git.nicolinc@nvidia.com>
 <550f103125805461491b87bb6018293ce9b888b7.1739005085.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <550f103125805461491b87bb6018293ce9b888b7.1739005085.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN7PR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:408:20::39) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN2PR12MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: db479a77-61b4-4b39-1e89-08dd49396c44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IavNkmEvMPVAroMC2DGafKcPorFTCuqoX61bJQJ1vf2XBBgiKgivRKonIgx7?=
 =?us-ascii?Q?LEm99ONqIubTLEintXrBm59Rrl4nkEb95tAnD9W9gjeXoRzARdYSyvfBDPlh?=
 =?us-ascii?Q?FrMMx9Xd2i/EMJJrA5V+YZPeYvJ0ZQhwVkm5m0bYDm8PbvTGAgpk5Qu//t8K?=
 =?us-ascii?Q?aZEfnhKCiSNSMGlQS+rLDsvXKhBUXKNTsup+1ixnHBTCjcuXDn5EjLf8Xwjm?=
 =?us-ascii?Q?PNTUvVxv1bbiZ5zVcLFcll5r5MmPEX0Qz/mNLhFboM7nPwvY92pIE/T5Z8/z?=
 =?us-ascii?Q?FM6SPpnsFt0/iXeGAU4fyiKym+kRqXjPjJVohU+rO61vQIrwe3RRyqTNL2oJ?=
 =?us-ascii?Q?PM2I4PI4NHk3++r8QM+cQSP320ip0wHri5E3CyBfuw7LwAHsFlcPzrPzXmEH?=
 =?us-ascii?Q?pRKO0glQwp3y2nJ56aCo0073/C1pjkXwtjNq0sMqFF2Zul+32vbUYxcfV0LK?=
 =?us-ascii?Q?8aHkCw16fCb6zU692IOPNr90UU17JP9tXIT04pMBCXeY0ZmMJFoBiROvFT54?=
 =?us-ascii?Q?1kgONvxpbY+2iHdYArD2rHB7HeOztN8gb6yxz29kp7cmkXv9kDiivQ2z43st?=
 =?us-ascii?Q?7T8hgUpgoXv4m+lc6oKALUT384t2SFzUYonlxxJt6y8dby8pao/eTkUyPln9?=
 =?us-ascii?Q?Hmgoz+6G0nxWHDs1YMHQOHtzSGNCAhnD54LN2o22N/yvEvbbg4sEJc+prI9p?=
 =?us-ascii?Q?a5vleFbjGI3YEiJ55o3P/t/dOJ+6qE7lnaKKgPEgyjY8H7/BkoJ0F/+6dLtk?=
 =?us-ascii?Q?TJBg2//2AIjqNKqzj866QEVsyo6s6kjc6NIh9/pwKkg1Wrf/0yVrvOfnDxLe?=
 =?us-ascii?Q?QgZZt0uWfqx3JaQM1HBC3P36rs+lR3Q9SDwUNYBP4mmeWrIqDHkcmlNNKiJI?=
 =?us-ascii?Q?qR29fHYokLnGZ5c7Gu0RAu2JcEFvsMX5tGkDEt1Qge9ytG7c2CyI7yRhT0L0?=
 =?us-ascii?Q?NLl0UnbU8vSL35ztgSanp0bSSK40AU/A+guTinlNFKMJOCz3OIARyxLuCQW/?=
 =?us-ascii?Q?lQUwEWBL9hc3tTV6YoV741D96cD8w1wBS1Q8NrnwDGPO3yZxeB/COHbBK7PI?=
 =?us-ascii?Q?oIb5f9psU+WjmJmewlPSA2JLfkDEe4S4nVh6izriRiwbUf6tVqvrjKkv7rj3?=
 =?us-ascii?Q?Yetgf2PW+C3yO6Um41GlY6OG3Et+7b/9T0KWJ3TineCOXNHm3GtgY6Aa0AJa?=
 =?us-ascii?Q?9PGYZ08ibwjXUVGJzykAh07xnhxeBCQkw1ZeZWXO4sb6lmcRxWM2wWmsbdxu?=
 =?us-ascii?Q?k+RZsEtM2xJM/bTmsg8I73QLe8RPb/iiLm9xIy1rEY+2FicfosutvxooE0KJ?=
 =?us-ascii?Q?t5Gr7pOmF3MgbR0ob4vGlz7uEDWmLnv/IBNrluCZuUonRkcQCD7PhJ2vpyMY?=
 =?us-ascii?Q?oq5KjFLgdT6gTWtsvlViVdcWjpbb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2f7IZn1yNVbnqEFLY4HHWuPWITnqC00MOwhNBnxMOXC1XMZlYF90EJq011I9?=
 =?us-ascii?Q?7Yb0bU4I91C4Y2ImKSZ40EjdSWqu48oy50wW5AnP4TgKCwFXlwwf5YVxJFtL?=
 =?us-ascii?Q?topp2VLXr1Zao9EsZAxZ1FVg7+u3le+9avR20itfbIEsRb9JS3UIC8ZysvHw?=
 =?us-ascii?Q?oQ1+/ANGkMrj6uxNxHclDx/+UW+G8DuvhQY0utbB5BeSv2CM0UuzdbQ5tJyl?=
 =?us-ascii?Q?PK91hzbmAn4n92/UNU7uhj4jBhUUaasQ+A2oBUW+cWhLC6uCwlGroY/HL9dw?=
 =?us-ascii?Q?HiE5/pyq50hLvUS2pNATWWSonpTmf9aeo0IcZqCi/4hqZEV377OCbp2hoC7y?=
 =?us-ascii?Q?jajmsogCeeZVgxP4OG5zXYssawD39fpysBrD+TGH9JbvfB3ov0GNkWZBzhAj?=
 =?us-ascii?Q?bKRRJGhIv1RhNJHrbwf4CDCNNhaDjUwoaj4LQ+5zrnCxUP78VBvrrJmN6iJa?=
 =?us-ascii?Q?cUG/Jx415R37NnXsGG2Tt1BvSthO1avIGnRc5XJ5hs15qQIoxjARuoR3P7eC?=
 =?us-ascii?Q?HQ6l79VkBAQ+dblf54AM7w1JyVyXNUkjijnghb4sX/R40INUxjRVaaMyS6E5?=
 =?us-ascii?Q?inXdwvSRnWrE/bHHAzFI/68sSqOKjF/K/kVyAPaRyOLklW7Pi+OL+tx6wxT0?=
 =?us-ascii?Q?uFnFoJijiGlmRGda4tAdltMprfp9Kj0zp38l9kWA2Zb4HsExrj3ne+OGpsTV?=
 =?us-ascii?Q?3hg6SU9Rza5/4XqAZqBZuPUmmVq52m4exg+TWAIOW8Ykp8deN0ooKL3XS/Yh?=
 =?us-ascii?Q?10X7EpgZsoZPp74kft4/kCuVigopgSP8xvuOdDiDWCHF+7IyBpw8rNk8pg58?=
 =?us-ascii?Q?SC1vGBbZIL6LTe0p2HahLdHtP5gukppoTSRGjs67QjEYrg1V3NXyXeq6Pod2?=
 =?us-ascii?Q?iqBco0Pm7tO1sZoGk5bVMKu1dlxvRRJrHW+6SvAQWyol66L0Cl54vysNhstX?=
 =?us-ascii?Q?ArBGcOvZ3b+iXZtCEntGHLFMHN4Tra8mfXrGl28anUjAhFEDwBp6mJH5IqYN?=
 =?us-ascii?Q?dZAtsv7WKwutwXoPbsTjRjHhoruh8GRJLZM8OXohLzr1zyRhq+Ea8oXWT48U?=
 =?us-ascii?Q?/tQUn81w5IiTGUoP5pFyLUOJ1BRBvO4RtwaWAfF8mOU8vuQZjwiTHGsfU4pK?=
 =?us-ascii?Q?WzpmVNKkEI2j4YJQ4K5OH2JVAuXXwg2qlh1qrjLkWYj2vw7JOJglApsCTkCf?=
 =?us-ascii?Q?bAdRI3J1BsF/BbGICAY6czTVtrdeWXhQ4ZkOilXBcEZPXP6DBxOdstBlau5p?=
 =?us-ascii?Q?xKZlFIlwiRujhm/AFei9LU3gFqSnBIX6BkbuYEVBljsTnOJq4TLgtFVLNFjv?=
 =?us-ascii?Q?Gv+YgimToLs7w/d4TpEnwxupMDyhjivk9jClS2SgvEWwlrG+H6N5arwOLeMd?=
 =?us-ascii?Q?SFYyWaNbF7CHXnWQKthja5M8ghb3yUS5TpFLD46f0doa92LKZrTqbIaBaqx9?=
 =?us-ascii?Q?wEScL7Z0X7cAJwyaYneRuKAPqMk2sti9T7kmzZ3nWFHNM1GXkPwT4rVqffzy?=
 =?us-ascii?Q?ZXWKndK1kEYZq4gLKmUIO2C/pGdP380x8D8B1mzum+EcrZnBNMn9h4o49YRX?=
 =?us-ascii?Q?dw9U31yLFYkImiVgoiI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db479a77-61b4-4b39-1e89-08dd49396c44
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 18:41:53.6403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iDi4N5359AiI2A3jSmuHf5hiCNIkouF1y2+fjAY4gVyBNF/I94JLLf3xol19y45i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302

On Sat, Feb 08, 2025 at 01:02:41AM -0800, Nicolin Chen wrote:
> @@ -433,8 +433,8 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
>  	list_for_each_entry(cur, &ictx->sw_msi_list, sw_msi_item) {
>  		int rc;
>  
> -		if (cur->sw_msi_start != igroup->sw_msi_start ||
> -		    !test_bit(cur->id, igroup->required_sw_msi.bitmap))
> +		if (cur->sw_msi_start != idev->sw_msi_start ||
> +		    !test_bit(cur->id, idev->igroup->required_sw_msi.bitmap))
>  			continue;

So we end up creating seperate sw_msi_list items with unique IDs for
every sw_msi_start?

That indeed might work well, I will try to check it and think about
this harder.

Jason

