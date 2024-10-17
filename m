Return-Path: <linux-kselftest+bounces-20036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04759A2D7C
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 21:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29AE1C22C45
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 19:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06D721D2AC;
	Thu, 17 Oct 2024 19:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MKgKwngS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AF321D2A3;
	Thu, 17 Oct 2024 19:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729192337; cv=fail; b=i1fRMp5cCefdHIJjlj3uXwpYjpVhdV6gWTjZsjS+0iROFpcOFbvSXDYRbZE78phbgaFC1BLPlsU79zTxwKOV0iWU/do3AKK6ytI/f+LlxxJ7PXbvEebm/FlYEC+eaSpl/sc+4M/5Gz013gB6iFx43yqCucEQP9QsVcTBZaugEc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729192337; c=relaxed/simple;
	bh=QlgANp07h5Xn6B8YFSDo9XLQM3eYYOc+oHZXDc1/zsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eUI1fNqCDw1k6hpI365Wr03sD7VqUX3PB8t1EYcJr2Dz9rHViyfOZdRqHGWbjO04GxHnpjMPm8lr78Lo8ERxgrymSPLxbm6XLWz0X4husyG+/QvEHDjuqWkoiAqQ1tMn2KvyIrbk1vMgmsy7ERscKfDT4QEfW+psz6mLRtPBOKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MKgKwngS; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qh0a92bM406IlYXGpNGKP12bWcl1RfP9ukHf0DDvsIJB/X2ZojmTRIKWaPfAkJ+9aoyKa65uZT1VQFfP45lvGvq2H6JtTbvv/qAVBy5aczMM3YBoHGQSj/yKrv76YtPD6Y+nNtRQvYbimzVeSsVpPWmYvGiDKFr+GM/rD/fpX4Wy+HRCxMBbloirjk2xnIah9sMzfIqg9Jrtd7v1s3/rKg2oj2cOJWTk5Ts/wnm26B2DRG6kfUn0TTTsI+ejmXONKpQyvTtWU3zqOCDY6Slp6g/I6XfOG4EFzbKstYUaBUin7uUF+FaeG4U6llbjH7DidzQYq1QY/7IDGpq81LjrHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMFJXtW9csoaqE++BgoLbp8PB0zpWdswAhmZYYLh4k0=;
 b=Kf+IGT8J2ze9lrjeOgzitpTI6S97ARkxU7zosyujkBY51bW/7xLTP/qhS3RItY1sVSpVYc9BjkykhF9+rrMfidcqhJS5zFq1x0J2ij8NExQlDjR5MDBt8PzRuFud5PGcc+wZsfMZKePIYbuSiWH+9xmnaCRWZ7MZU/RztSvr8XhV3+jfLrpnzskSJJcxGbYLW/IDpKx0MI/VyG+ne69WGrzUC9B4QYK7Jfq69ERQZ7baUhyIrM46YQE6GWzBXjxUZH6GFkOHkNnRKeO/v2rwa3xdKTjMTq5PoFBLPRllsmK6JskK5SZ0YtOovpLAj8tgRnUH4cXaxJXLoaWtA3CYHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMFJXtW9csoaqE++BgoLbp8PB0zpWdswAhmZYYLh4k0=;
 b=MKgKwngSfywDrqLPm9P77uLobBmYh91TD85vuSovIc21ZoY9ZD50mzD8s44icIkbBH3jPm2vNUcziyV7OYZuEgFafSfzDF48AbmXFlLGpQ8dEzDCZYMDTWbqHraye67g2fxRAtBkBD5TbSq2Xg0soPS1T8st1X/wGP7CT5eNUUvLXe6NZjQJ2aG992EYYgVio/omvivJY+/prKOn3VFfwi5g8sqGt4Cnvp7W2paOTJjnUMi6K993032sdDRq9CHtlh5eK16nFq2gZOAFbnAee0dI1INR+oe42PtAymQ557Y208kHipA1JmpwPjybR4ZMGsnymwY0NZ2u4/60uHMkPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV8PR12MB9335.namprd12.prod.outlook.com (2603:10b6:408:1fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 19:12:09 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 19:12:08 +0000
Date: Thu, 17 Oct 2024 16:12:07 -0300
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
Subject: Re: [PATCH v3 13/16] Documentation: userspace-api: iommufd: Update
 vDEVICE
Message-ID: <20241017191207.GX3559746@nvidia.com>
References: <cover.1728491532.git.nicolinc@nvidia.com>
 <d00b9f9e4af1c656ad18d74d40f397d7459e2c68.1728491532.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d00b9f9e4af1c656ad18d74d40f397d7459e2c68.1728491532.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0307.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::12) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV8PR12MB9335:EE_
X-MS-Office365-Filtering-Correlation-Id: cd1fea41-064f-4699-422e-08dceedf98b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C/zvxi7BIEaHhwlFOxRIjlypTbffeDxV07AgRhOfrWwqdqQ6qbMxkLpwgQf+?=
 =?us-ascii?Q?h3peAMyh8AxByuqyKfJe5+50htXHBwgiESx3y5ZHVNWMPQh0/Iu6hu65Re9r?=
 =?us-ascii?Q?9U5meIAuw3l24bgfynlW8ObdrngARUvvXbf09eqh9Ym3MDAN+XJ6N5QKtSpl?=
 =?us-ascii?Q?tj4wMCMQVzIKJs0Vjp8wxNpsm+EDlHF5ehahMHTHnJriyfMOFjKJyzUTn950?=
 =?us-ascii?Q?Fz5/NFomJft3xjFHrWZkKKWi9WzfNZpeQosDQrwAgcdxCusj1mPYX52+jAJ5?=
 =?us-ascii?Q?lVKtPsB82Ov870VpdoDV9NoyVm9FwoyiuakhxlvZIl4YnB0SA52aHGEaMuHN?=
 =?us-ascii?Q?vWOYQvDWz8dz+MjzJEh2/+zmi5+BNCtijiYZRqNH2lAee+a9gkdHjG0ayzPV?=
 =?us-ascii?Q?StxleSj2qCXsw5JUF9VHTBf9viy3cxuKbHl7wRm9LYP05tZYNnRwnPWK8ZLP?=
 =?us-ascii?Q?K0Hs6NSNkpZq8gLxQWGqFy1YTfHjAJDZ7DmZgFAaCKELvFMN9Nf1Z/L6Vyfa?=
 =?us-ascii?Q?fLK6uFngwhKG0spkMaGu+AFLJaus9rwH+HpmaJ6C9yZ0U503oAKbqAxH6loa?=
 =?us-ascii?Q?qH/Q39gz0DaH/VHxhal4Q/OjfRdC+U4ZcOXjgzStneziw0QKVrx26P/G3jyA?=
 =?us-ascii?Q?RdTOm8zWxhDt/cDFrWOD1tHfq1DoPz78c1qOfX394uTLGx9W7hU2slZTCjok?=
 =?us-ascii?Q?rQzo2bzY9NW13evJUNXsb+UWx2ggngWU83Hhp57+12iARWPyuzPb3EAHa8LI?=
 =?us-ascii?Q?aIxzc0blpsVV+lXWNcGhwwQauXzC4lWGZSsqfq8nwPvT6Es7Jn7Yx9F6rte0?=
 =?us-ascii?Q?wE2I5fsx4mow3O3XI0PEWPR4qz1yXHF/iE0NrXc5w0MhnCN72zzGjnUBfvIg?=
 =?us-ascii?Q?0Ospb7FWoJkp6NXdJOZTLhan5nRI+GG7E38NAZb4KNrCKDwTf73K6IVHMyFT?=
 =?us-ascii?Q?pfcLZ7Hn8GheuSxoSrdLzzbOVmFTtJctQKjzRjgmqWXxweJUf7L7I68MC5XM?=
 =?us-ascii?Q?yDs/vUM7IulSvGf+od/mtW5MG5B8f+W9G3b2KzXHECurOEHvcO/QR0nFEqxO?=
 =?us-ascii?Q?pv754M2GB+btTXNs/TIabe6P0i9ip9XEkavwyOJKPdK6nMCwXs5BL6OHC+Vp?=
 =?us-ascii?Q?Oh01XOWNbPwgCbXO3QwBwqDF91xpKaznAug8pfXB9iwUp2HzZ3PSvhzFS6Bs?=
 =?us-ascii?Q?5UefQkMawOg/DWSkX4Yx3YQECoYrfIJNl+V6tptTlAieYwMiUTyFKg33Ed1a?=
 =?us-ascii?Q?iKLbzkdzcnr+0LQ0+mrDQD0FDnCFSxF9F35bALXyIzvRCM+Ej29HNYg9SQVQ?=
 =?us-ascii?Q?LbnI/A5WFwehDWdg/50Zlmok?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iSxMQA5bRrCA/YpcOy9ny9jtCJHBxQa6L3u9yrPws4qpSJ3StlUopmE6LBYW?=
 =?us-ascii?Q?pl56BTT86YScuEUPtueR3kcQWYSttbdeYGuIXQKUmjCKYBdzFQ9gxTEuicDc?=
 =?us-ascii?Q?t9IMqMdf4sWiwrbM/O1Pn+VX+JAfxw0BhK9AF+ZU4gq5HzK37fRKnajEPwod?=
 =?us-ascii?Q?itcrDwjsmfSsJweg47T/IUcZifH5L96dIVDZ6TCgn/QPsZ0Xf9TlZiPl8z1y?=
 =?us-ascii?Q?Phzqg+OvK5StMstbMxiCX/b2RVR4NEYNIUSyO4EBkh3Fozpu11OcdmsU4Cov?=
 =?us-ascii?Q?GicTBCtqAyEBC5o2Q7N9oeyA03l1opDbnRJ6qaLRJ/HEKBKlUdkC3JFaPJeI?=
 =?us-ascii?Q?pTtlvMAvKYHMoUlkgqyiFuCr76byveBioURnIQQqrAP4VcB8EW7jd5bd3keD?=
 =?us-ascii?Q?s/wvbeo4TgQGllGiaKd7+ZaXXpbqTx8mFmKzU7PZz7AU3PUJWQq0zAGyJPEa?=
 =?us-ascii?Q?AwZG5l6CyNitvQyRdWnIpbxRXxVu1iYfPKtY0MllBz0GF4R+P7IMFI/zqDJL?=
 =?us-ascii?Q?m3Yk4moP2IqJ6Q/T8gqEAQ+Iy/OSuAuuXtDvFDaJFYKRHtlkJXH8/1j785O9?=
 =?us-ascii?Q?tEUDA3cTFQcDKR5Dv4FI2ss/gU2VF6reLuBFy+mqOVDoNHR+p7rTnNTe8Z2j?=
 =?us-ascii?Q?uq38KP/aWRz6yTOHcF0dvzQVUyyJLCrJXtyIwu9KQLiS6JAajXu70jo/QZIi?=
 =?us-ascii?Q?GiwsDY8Djzwvckk54ogtqRV+abSl1XwfB9vunXcy3IpkvgnNaEQ7rBFrONH3?=
 =?us-ascii?Q?XufO/lEaGXb677F60za2UvEAmLZs9EJ8hx6iN2iYVck7aS3xb8hr2X1aTDy7?=
 =?us-ascii?Q?wOidLRUGqyKU/85O+XN+YslON1b6AhPsLBbkh0cHJroODB+G3CTGJy6N9PS9?=
 =?us-ascii?Q?D5Im41QXqtFAXnBohXTkB/hFKJKOP6ViqXsam6Rv6OE3b5GmxJp7m3gbmUPA?=
 =?us-ascii?Q?3DUtV3T9nWRdqcAaZP5QwkMoYrX6uQz6R2XJE+rpZrs++deiPmWSPftZe6vN?=
 =?us-ascii?Q?QWvBWicUuapkerqEOFKpcJQlrd7NMvLtKJ6CEd/TuPNssVd/l3EIvBeeD+Iz?=
 =?us-ascii?Q?E0LHchF74a/MO7Kryjt15uPI/yGyXG5e7a9rEQbg4Kug2whG4z0If9sfZM7d?=
 =?us-ascii?Q?18oYOKJojZGV5ud5HD4TRRe5jwxqgXG6gLlKJb0a1b+bhdOPgabaln9ykqMK?=
 =?us-ascii?Q?nMwyp8N/KexUs/aIrdXFpd8MfCpI9QRAJv/UowqYjuDsLS5ZIPpFAvEFQSZ0?=
 =?us-ascii?Q?UgFvTFjIWT8WL7VRa0Kcqw+ANQeGfHpCYBmDhyA83UUhUTP0g6sNfdLLIUtU?=
 =?us-ascii?Q?Zf0/aTxkq6Q9uZVF6dUHiGDbXkbVyqNPRXCQJ+mwGqhvvalKKseErsfKFedy?=
 =?us-ascii?Q?dek2KBlmXRtshxm2Ly0Xfwy39YMkmp09LeJYATE3nJtGKx9NAJepdxQ4vk/9?=
 =?us-ascii?Q?G8d4/Vl9FZsh/8u7z/ff3IT+kHQamDwYEUaIeGEx8STwsOtBDXQ4jIesjNkQ?=
 =?us-ascii?Q?bCLieFkV91jCdvYqzhCV/MmHyq0jmXmoBcIhd7oQzZ226hnGwQFtTNbKfmnM?=
 =?us-ascii?Q?QUFz7gPqYP6J5gpDm7g=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd1fea41-064f-4699-422e-08dceedf98b8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 19:12:08.8588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aaR91gCtyBN1bspwhehvEgDXP5j0pirVFIHyXBv3JWkmCQhegKhDSscisM8owKpV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9335

On Wed, Oct 09, 2024 at 09:38:25AM -0700, Nicolin Chen wrote:
> With the introduction of the new object and its infrastructure, update the
> doc and the vIOMMU graph to reflect that.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  Documentation/userspace-api/iommufd.rst | 58 ++++++++++++++++++-------
>  1 file changed, 42 insertions(+), 16 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

