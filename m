Return-Path: <linux-kselftest+bounces-24224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFAFA09867
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 18:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30B9716917E
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 17:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5C02135DB;
	Fri, 10 Jan 2025 17:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NNdVuGei"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C075B2080E7;
	Fri, 10 Jan 2025 17:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736529909; cv=fail; b=kA5tYwylrARGObduziNNtqr2DszXtFIbOk83bcwa4U3slbATTo4OXqY2bWzg/8fumBjelVVsjtbLIjtNv9bC37X8kkJcfQNGxVJWNy/9oKTmvu0pzQZYf7G6fSKsxZniKe7EJS5qOia0DGWHcayI8cuK6BXa17aMvmHnNZeMQnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736529909; c=relaxed/simple;
	bh=HWn3ikczkL+mEMFnCHiMeGLeZDYcvuA+zyEcaf1b8oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LDIyWwbQiWGGH/CNCXgVh/JEgx+GJkNUmb+ptE4OtOrYDSXwj0IXjVsrhBFewtDUIun8qhFTX0Mqd/woWk+mAdqHYYxsuoSrBGxjYK2svPFVY43tC/YmUK4G/471Mp17JbcNrOSryR3aJOOftP0oiHqbKkG2kL7INnBvORlZyHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NNdVuGei; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ocuoA67kwUwI4vnKvTqRl9465WIW4FDinNFpZGNiUduyCx3P7q2ewdUBXvQP+XWZn78MvM/9Gf1TksMOV0GiVoq/QCNDEPqZ3c62Cvb1OtmxcmYsSG5pc6jAPsgUXLJ+wd5L4YBklY6MMLI8Z4QRzFZGtNLd8GluHIUYvN5GdqMTCSe/SvIZZVlKu0pQyvIPXcuMHrg7eK26aq9WU1oJvYALYoV2MphXK0wGV+kvK77G2KSx7sIkk0YgmQkaW9OuLZx8eRZCuTL6fUa1dWilc2OqawXrOpGr27YtYgsXAj4lENHdVB3YSXU48OoHs4lMSxFDbgucs4H6UGx657u6kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiQZxt4MrcyoM1LxSZuV9tiY5aCQoRMlGFdW0GOhWG8=;
 b=hvs2A7dUkJnIsBwWAdeVQ5W+xTvEnPjaYs0rQAmhweE2XvaIbjHoCXeLE6mVmF97A5ebjjkLB38okiMkvMNkRucrk8yoGQxy2c/9C1XOqmuuPYjUoiHa1Om8kPmWdSs/PKam7kcV7W9V0R3BpkDjRJ15mfdPkYar7Fai4/UP7TbyFTLd2dQwKFZpotrxY2+X6fgcKna2UKlZFfJZd7zO5WY4pJypTqz3mEFh7S1WXuOMeQKQiHjgruQ5FO8vmI67SerhixfUWeDlecp20WGbmHErlDR1mRGA8wjkr3Smb8RaVxxd67wb87WkVj6jH8/IRJ25iDvny5Sn9QC9HYV9Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiQZxt4MrcyoM1LxSZuV9tiY5aCQoRMlGFdW0GOhWG8=;
 b=NNdVuGei9oUYGO4LQbtdoazpqCSjdnOeNSr3RUTwvQwf5GHsyXPD2pcO0zVOrL8dnTFLujSeOk8fSndY/kt+dE8k0UOh5GsVKnWzWcgOmSVFsY1Dbs70qNfFK/9zXSq5tJsb4IRI7yuzm1qC3vicQICIC1sFbYpBiXApXvtK1FNGaY7CgroK/mL7aXYaBFBF9kEqnzgyQrlw3sF1NkEsvEl6OXG2uuziMC1DhLRwXeENxsQ0aM0oAs/Dms9X2dpUlFA2y9cO+xkEqjDLPyk9go/fKzGs4d+DLO3y3Pm7IqCv9hb31n+UWQOlXGTkkH0ZB4DAl122fACPeoV+/FV5Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA3PR12MB7879.namprd12.prod.outlook.com (2603:10b6:806:306::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Fri, 10 Jan
 2025 17:25:03 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8314.015; Fri, 10 Jan 2025
 17:25:03 +0000
Date: Fri, 10 Jan 2025 13:25:01 -0400
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
Subject: Re: [PATCH v5 01/14] iommufd: Keep OBJ/IOCTL lists in an
 alphabetical order
Message-ID: <20250110172501.GC396083@nvidia.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <c5e6d6e0a0bb7abc92ad26937fde19c9426bee96.1736237481.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5e6d6e0a0bb7abc92ad26937fde19c9426bee96.1736237481.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN8PR16CA0018.namprd16.prod.outlook.com
 (2603:10b6:408:4c::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA3PR12MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: 31f34c4c-1343-4c3b-209f-08dd319bb7b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mDtSlH/bUo/tvW0G4LGM60tWPZroIKq3riElvnEj1arTpCq44Ae9gXb3N6j3?=
 =?us-ascii?Q?OISBbBOLP9DnKGmr7kabFbWDSpoDHmifbbYFDQgy/6+FP1sxh6wGZ+weXbrL?=
 =?us-ascii?Q?xIfQtovkoAaj25+YmU0rK8G+zummNvutynLrZk+Kc5nw337dITdLQp+Jc7ib?=
 =?us-ascii?Q?CBG04mUxlzs5sOY9GhI2dLWYtWethGP/G2IXq2tmqXvUPA4fpzWdzZvc6Xqc?=
 =?us-ascii?Q?3bCa4fsYgKmYD40axzEufEMVue+qH3pQhV4J8UiWOYSvhQetB8oLlRKuSiwb?=
 =?us-ascii?Q?ulMgqDgSnZdje41PPsPciVJrxoba6oevIY9Yw9HmmC2qTxuuwJZYmIag8lj2?=
 =?us-ascii?Q?buUWi3nB/O3LWSzWFEQGa5XSw4wlIC3kubCEE2hBsLhj5VsFsxmn0aZH3nxa?=
 =?us-ascii?Q?c9kgRKkdnf3bkO49YvJP+/pwjMSPg285ioIKe9+6CR/CW7wwpa9L3XdJjzFV?=
 =?us-ascii?Q?LYU3fL8e/8lGV9kPnGZn0IBYGHmjDxK+EfDMSDotNOCyJnM63pMHUy4Sj4xe?=
 =?us-ascii?Q?lr/2r9i2IgEgy1JXQpn1F6qXJPxYhmyCSYUyFyf0tLAvRFWSRDfdSVkBS0sf?=
 =?us-ascii?Q?cNXnsc2Ps/0GlEjogRnyvukiZxjuATJ8rMjqNoWMuLREOrTj+romSjhzEt1K?=
 =?us-ascii?Q?zZCJdzHxm9ieT7ULPPNVoxIXNfbIu3u0nTJyT2mzbrxQbwj/OawvQIuzH/0m?=
 =?us-ascii?Q?NiCsj+Bs3JUmH6mjikFT7zMEgDhdynaYjBRlwwqPxQ/R0DIl39XZY1NowO2m?=
 =?us-ascii?Q?/KdOnlLfB198+40hn4plC0TR5hXtd9EQydQHKhpOozX+/kSm4VOJ+PY7edLC?=
 =?us-ascii?Q?zuV2eOfyRzik5jv4zLixHGTwv6sBlHHcJS7In159NXAqcD74GzCQ6+pQMFxI?=
 =?us-ascii?Q?VpgNEgBO1ajXI8QF7NhP4Eu6jYI6B6jqEXtBSqf1D/kfKwbLd0eZ/qvA/XOj?=
 =?us-ascii?Q?M2hRbQ/tyTym2cX++h8Hmxf7076rE/XgNmPvSg6HAn76a3fEEq8xOmyfyQMt?=
 =?us-ascii?Q?G8ASb+9kEAUCXCTbPN2v1geqgCGjoD4izNJngtE1Dh3tk0bGiWf/xvyzqR3E?=
 =?us-ascii?Q?GtLxVQtW8AhLgkYH2KgIiN0KwzyeWGNkcvlR1bMwmOYuWN/5DJUlqUIK30ku?=
 =?us-ascii?Q?1W0YQ6XQRX7BQXqJaC6RHkiFM3iQm27hlxcCXj5bGKENBoWbj/r5U7MF28zp?=
 =?us-ascii?Q?fMoKqeTsihSU5oZGzef2UcPUW069/tPcSyp7b0St9ho7ntuq/jXW2i7b40rP?=
 =?us-ascii?Q?xZo9JJczwlzGUiHwgAC+k8i1Zq/9iTc5EBdfU1PpdMV+930tgLtvX5MWryMS?=
 =?us-ascii?Q?zZcFpXE1pBqG8X9wBn3oG8VHGgE4ewHZqL2pDwl9zpuovE0xj1O4ksGGPaMs?=
 =?us-ascii?Q?gKo+2Bq5IUCDRwQCiGQ9tcataKgT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fUgeUeLl0/qzj4Rq9OyDr1YSz3nAJE/2loWdNBA+M5dYKpv2MyjLjZ6iiH19?=
 =?us-ascii?Q?Tn63+YWdM3pUkxuI6jlH5SF47RLECMkEfhs192MDlHSIm1hk90oNKdxxmnDS?=
 =?us-ascii?Q?h4HU+q2zx1qQQVRNyHIQrk2rwUpd4S/ZAggq+ns1uh8uC1sWOOlHiokQdsRu?=
 =?us-ascii?Q?jJj7luMtxdExJVBPtl6S7DdLzBBjZr4grzJD/G9UvRVbDI4FoJ6OUQfQ0cmr?=
 =?us-ascii?Q?qhi9TB/ZkAXG6ZGzdQeQOaekueLO58nlME4KAnMRp1MZ4y/q9NLDJr8E80Hs?=
 =?us-ascii?Q?LIrYCLD9xzkLatyzLsZUYLYtqED+NVgzFrwbChDXF4SaJMg+nT1i7khCNJ9n?=
 =?us-ascii?Q?ZA88A4US93DGiqSRAOpR4QdfmToP7y7dgs1R0ctOlZ26tEOyTSzpR8vmBd28?=
 =?us-ascii?Q?FS3L0EfTYNdN4hQsMxuLjWnnDd3mXSYxWT2FaQCsq3tMCJvF85pXM6mDlwfl?=
 =?us-ascii?Q?IPbhXZGhV6NF26AVQ8SUJdypFvb7JXEFIlqV0RZ6uYFq34ilbDIr5koF106f?=
 =?us-ascii?Q?nMjB+a4P7sEeB3NBDWA38gcrU44cHDprHUZumnb0+ZEhSczeFSGOkKCmU79m?=
 =?us-ascii?Q?yLLuzDMfJT+kqYE9U9Z1ecD3CSuBBMDm04FEZ6Xo891m3xYwvhqqlg5c7YXW?=
 =?us-ascii?Q?5a3RabeurIxYxQPCUbWp7QfZsg7zxCIkU8blm6oYolqeHdFbT4oiVst0fOz6?=
 =?us-ascii?Q?mW79sWYEONS7hKQfhOAG802aLEjYKqful7qd/spHx3+xZoykMgQ7BQqxiwWV?=
 =?us-ascii?Q?H2exE0ZXijK9XYgnN8PLW0qRdqqGxvkH78lOYSyzmnYSVuGM8dpEIVusdmmI?=
 =?us-ascii?Q?vmt35PAsfBPlA/ukcTrJaUv4JcigWmCeq7ZAc87fPabJMF5RKBKBvcZs7UxD?=
 =?us-ascii?Q?WUyAAZteRh5cD6wPSv5fbsOd+O6+i5xiizI/N/lapWotlqHgtJnmJyAOc6t0?=
 =?us-ascii?Q?WyJkAHQ+1UIEIQtWf4IM43uDhBjKXcTXUD6R7PJ3FZSwUujXEU61jvOo0Ak/?=
 =?us-ascii?Q?CBOQErCuJy5e/4kXDhNdbYDN4NV4U0FmI9qoIAEP9Owig8zDMiXqxcfcJEnc?=
 =?us-ascii?Q?p5EGrk3Ebu5wdF5Pr6oX5CavMueb4hwTULeX9GQAArTo2w7b35Z4vVwSY11R?=
 =?us-ascii?Q?hyxWFSTSq4TKmGEXIK/SHdnVDxPLWDGl7mo4WTLgcYKifomombMt713Z0+u9?=
 =?us-ascii?Q?+swOERMRG1flRV/8RH9KQn2n1QHintit1vpWcgLdeBsWYf4W9ZEL21hbQJaR?=
 =?us-ascii?Q?2VS6tTkOdTvumWi6WDDjEm6Z2Ge+ME3HSpbafpDE6cyOxhJdLKet5A+ZTYoa?=
 =?us-ascii?Q?ZEp0iCvBLVIKEggT8UvjgmtbehvR6Wp6F58Du6lgkqDBsXbx4HpZ1Bui2ziA?=
 =?us-ascii?Q?vR4QSg2+dwEDirHKTPCbHfbRb4tjcFr5PBHpALRG09TyFKltklGMwY9KGZqi?=
 =?us-ascii?Q?tL8asq3yj/is0I4oO2xFLejeydEpQWcW4rBQMPvLzQHlJE+W7p7peGDnuvYZ?=
 =?us-ascii?Q?5NkWc5pVZq8op8GGG9GWbpFliysPJ/YSgzylGNMAqwpXYc1bpJivx6PpNpct?=
 =?us-ascii?Q?udbmfV3njKSyVQnkn+w3vkNetrfBUpeI0t2zpWSd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f34c4c-1343-4c3b-209f-08dd319bb7b8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 17:25:03.0408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esQZvDwKhLbr4KCnTIefUuwjq6dYrO+y50sht9cYsW+el7YmuUkGxu5UBmTAiQP8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7879

On Tue, Jan 07, 2025 at 09:10:04AM -0800, Nicolin Chen wrote:
> Reorder the existing OBJ/IOCTL lists.
> 
> Also run clang-format for the same coding style at line wrappings.
> 
> No functional change.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/main.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

