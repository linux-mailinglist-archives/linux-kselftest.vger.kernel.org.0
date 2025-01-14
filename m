Return-Path: <linux-kselftest+bounces-24510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC72A11130
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 20:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DEC63A1FA1
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 19:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B941FDA73;
	Tue, 14 Jan 2025 19:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="if0GHIRM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CD1205ACE;
	Tue, 14 Jan 2025 19:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736882969; cv=fail; b=VYM3x5JcFE4pqo5vtfaUxDDq+SSjvOyNwVysGhDOQXPAZcmhzW6qs+geavDPyW80zLMH/pPZ35Pvd8+w8RglnkkdhWgwA5beyFmBfd/LCiNu0TA0PbOrlD4NaxLUgEBkgFJvjbpI0UqIdzb0UYtlHIXtCekqjQ2tbMNzk/ZL1m8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736882969; c=relaxed/simple;
	bh=10xcIeplRjwxBtLaF1pkLKAohGy9/iQzaDfLHQzrvaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Li90yZ8RHRVccAMahOgybDgLruk6hIALUyzbasbrVF/Vc0TLAosi4qXwT85iX1gmelZ3EnbsBi4pXNSoycBz5cWJb8JR5SzSmR6a5YsQc0Mahbqgw63YU7GmaUmp5Fj1uvZP58wDTSyoowbzGyHz33pNdpwaJXGOIyBJRA7sCJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=if0GHIRM; arc=fail smtp.client-ip=40.107.212.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITVFBaNs49/UnZGDpEAAiWdasqg1+HmeuN9eVSoegUY18aV+gVBCoLnfR74vPvgCbN5FcKN2VRYRxxDtsDtiJwy9MAPVCW3dctZr976Wj+s2/Q/TxkJq9kckQ6mCmpPj2k0H0cs53qM6z3gFn6gXTaG11ncr4/IRydZGsVtj01DCG2voTKzKOzUPp7PVdtktTrpfG0ReFeSmWdvv21A/iU25l6mrk+iwNrqp+DzdzqLVli6YugYbE9tzhH+qxR+1Kkl+EYd8AD3uY+BAdId1ZKXTwAYXzJhJU3SX3vFFDXkQPcdBgJbA9aQ0HmCzbfAwweZITyjYbTkERVBtBrkg+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSQH8luvZHWK3XmXpx54WI+KjCic9g3q3TJN0ZpiZHY=;
 b=iLHvD4X9rlKvvw6RnaCmkrH/JcNindcWjTB2Yk/iOqWGdUB6I/CNd28kKmgOk67OIOBsgYiOoiRDhqSUyLshlVd7GhNBktSS2MTRM19KxIX+bbagK+PDxqq8wzLx1AvnuUIglViLEXUaM/Ml2BpA7wwCMGufh37YTjc+5Ukdhhr1sCOtQKAnLCoSbCl15Kjd5H54LZq8DOyeKipgF5gbklHcX/8S5Ntb+Go9yhQ6GWG0YRA5pR5Tg+aZtXhYrmw+mDICbkXXxiGPm1oC5eEOTplxyF36Cj+XfTIAEyFVuExMxttOHW4s/bNhOnSFMZjSx67hhlsuwVL/i1rHsRLhcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSQH8luvZHWK3XmXpx54WI+KjCic9g3q3TJN0ZpiZHY=;
 b=if0GHIRMZ8/gPccYus5Rc4IK7N6ebjPf54KlKasu/ybVfSnifqQIE8iVKLfb8rP89NddHN8uflz7oA5tk3o39c349qableshUQvim1R/ziNKnWuUg/QpAq7hm9KpKidhrA3B/7SyLVHdKmN7YisbI9opzTCLc/0LRzn8wpP5hvXQYx8oXbizuAGxRqTjVnxPn9cKwpCvv+AQahX7J2Emgf4lwqsZD8I5WMMVfor7/21/YaIQVwiPRepZyTq4zb0iAggHVEBN9hRHTLnnNV1guuVln9p0haPt/dSJJ6egzeIizUFg0nmRjtn3pHXdA44KDntmCW2ACgdmQdcntJBefQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH0PR12MB5605.namprd12.prod.outlook.com (2603:10b6:510:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Tue, 14 Jan
 2025 19:29:22 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 19:29:22 +0000
Date: Tue, 14 Jan 2025 15:29:20 -0400
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
Message-ID: <20250114192920.GA591693@nvidia.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <c5e6d6e0a0bb7abc92ad26937fde19c9426bee96.1736237481.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5e6d6e0a0bb7abc92ad26937fde19c9426bee96.1736237481.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1P222CA0017.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH0PR12MB5605:EE_
X-MS-Office365-Filtering-Correlation-Id: 52670a7d-2670-46d5-a21f-08dd34d1bf67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U79nyW+0aL0eBONrOKg9AXkjwh61pVl66F+cOKog/6yqcSIf3nZEmMzknKPy?=
 =?us-ascii?Q?kyljYApe7d2/l/iPP9WqRoTSLBTD7x9kM6m4tlkCPBuUogZSoVaWd0ierSBT?=
 =?us-ascii?Q?JM1QnBju2V2JM274ly8dj/Xuj5JDZQ8/bfs8PTbyVTwvJ/NMBdhYpNi/rraZ?=
 =?us-ascii?Q?0zgCxGU5CkbDPyq765cDAxmRcGLGwZy0APWc79oY71y7ga+mCqQClUbXiSk/?=
 =?us-ascii?Q?IuCUVhNLQCTOQyKwF6QZ42xjPoieZw++8e2ROiIIXBwpvwGMF3OZIDYIKauF?=
 =?us-ascii?Q?q28aqdp0UMjQHaWTgGALZAPO/vztzRytXztU5Z6QlEK8rsnMNhosRwL2MunZ?=
 =?us-ascii?Q?qvoMO68deKXTx+4OjEulcgJJPKGjptidSSL9+KESt7nXea5h4YlHt7WnvntP?=
 =?us-ascii?Q?EFs7jb+zMrpF/SRjN/g8zz43BPPQ+iICYYM3PfJcKBUZiiSCO0XEMaeUrGsb?=
 =?us-ascii?Q?lJnsUtHXBbo4PDM5ngq02sQWPev2bstn2PbbmraHCt+LnjJAAAJGQAmXzvhs?=
 =?us-ascii?Q?PQDvqUXBZ7yTybMAdX8DGf+BmCQh76krCDYmEA8CE7rBRm0OlrrbI9J38Q0n?=
 =?us-ascii?Q?5wsF2ty2qJa8P6QIFrhbOoGQ4YsaoK5WUggIuAh7g/qJFc7bYiJrmSG3mVjW?=
 =?us-ascii?Q?ig/zZagjIVe115+wrM1w1ZXqFjW/h0Z/FfZLYuVUufPnLxI4BPnJydudBj5X?=
 =?us-ascii?Q?lkmZa+TduhNTzckOj3pB1plIwSZ7vylzISl/NQ+o1ozlH6iduwp/8WVNRlZ2?=
 =?us-ascii?Q?C16LUFQ+wb0kfxnD3gIP3yexU5L86Iin0M9eYaflf4oaFRaNax6ObwueF7X/?=
 =?us-ascii?Q?ARujDYyY9gYJv6s5NLNX9GtymThxSx5/6WgkzEKcOQxIDVrWCm0aTdNXFLn5?=
 =?us-ascii?Q?9q4RutEXO5HOFt0INLQKUhQ8yNVbAOeFeoInWw/5BFXCUKj8idGQoxiVlZ5Z?=
 =?us-ascii?Q?iA3X5Jnxp6C8qyKZ24H2D/TlCi1Ppp/aCQpwKGFQ4+loE7uH9h4xg4mYaGUR?=
 =?us-ascii?Q?6HwdHnuiV7CEyKMnpZNLVTzm3Q9p5lTQJloM9GjjLcE3m4RiJMi0pTZn68w7?=
 =?us-ascii?Q?aofYNPG7Pu2d4m2YceKE5ZG2K9pceYu/OgGlWT/+xqFgeiKxfwcbPCaimd33?=
 =?us-ascii?Q?vC4K8IP/bxpdGd2q3vuIOejVuZF40LrRn5R9LRNeylZ9Lb1V51ksF5N+hNLx?=
 =?us-ascii?Q?fSSTNijyC2bmbFxfbL0BVzzT6NQ+hEpZotDHKl06aV3JCUdEHQ8AXDNy5iEo?=
 =?us-ascii?Q?jM/Hjd2BHfn4QSeG1WH3XoFgBVVMpvD4MKjZpKLLmj1esuS11RUuSRTIM6Ij?=
 =?us-ascii?Q?3c8x4VVpeewINsFzqL/SXGCfT0IgLguOAScgJM2O1UwIeQdSqYSRDWgfKrvQ?=
 =?us-ascii?Q?DYvHNJaJJseOMUkP2faQ4w2B0qUl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D550avwTjnxEk2mWHPbDFjDvnQLOVXByV3m+C/ZXbyRc5b1W4fcQmpRR8lYg?=
 =?us-ascii?Q?KgYBcvReavFMEmNdxRPokl7+970RC3uZzaDuFVSdA2YoEYb6YckOEcdUWIC8?=
 =?us-ascii?Q?0VKpaZA7zvWhjxzJmv7ZsaX6i2nV9W1GureVHcyk5U6Tb1cyzxr7bvIF5cVK?=
 =?us-ascii?Q?tp9av2NRUcNjMyuT0K16MrBrAUgzDx4sgu2CD0dWk/dRZg3RwfTWGYRgQyHH?=
 =?us-ascii?Q?nmaEqTHqWVR8ETBjkbZ//bmzq04QIztkq1Sqv6m0TCBH29NQ+BYT9RpfSds1?=
 =?us-ascii?Q?i5O/NhoWEjnGbHmzTRB0NtXKGu5MUfE3VTz0RqRXZgJCz7pUlQ/BGcGy07MZ?=
 =?us-ascii?Q?aWFvFQBBKoJMaVH/av3niXTEOqak3Yp5oJ6I1LvpeYTmae3r9GtsqxvS8QM7?=
 =?us-ascii?Q?OjrgXOWDZK1uRAm8TnE3I+n3Q8D5ul1v5nRFmeyZner7yvAmznfR/j+LhmiT?=
 =?us-ascii?Q?9IuvH8LxvVJaY9IqZOCwjHqUKK0vji5/QteBeI1hStJzoKR/W7Omxqc+Itjc?=
 =?us-ascii?Q?CTMwvDKZFITSDpEIBLBMR4LU0SGyrM6/xrbac6J7K3iyNRUH5lN2iEjbBIee?=
 =?us-ascii?Q?W7CvsTK2WVM8KCf98cON2JUUxdVaDK6BsyLgaRDL1jqKenl1xmSwjNm89Y1Q?=
 =?us-ascii?Q?k290pHBakFAbzAe097hMkoSFiH0klo9gO1A2FVKjgrn+8mPHIqrCSMlM2uUV?=
 =?us-ascii?Q?qibXaCTwDeI6cnGP8NSEdQMqcVpHz2ycL3p6Cx3+ZgZ91aH6TptSuWb/bZbB?=
 =?us-ascii?Q?8ZxqFH2pJGoUM0f+fZgrmTjIgdtANmd8XOXoT1qI7XV9XtqouIv5/4RC0Ysz?=
 =?us-ascii?Q?98A2gUcvfFNfetaraC9XsMLPB49ZOLCB6LqfwAaCenTp4DDZKPFaWXPXlP2P?=
 =?us-ascii?Q?T08GYaHrCHUJqJqCUu1trXlXlt7Xn2wcgRU8dDp/pkSK6jg+B3UEiPu1MEoX?=
 =?us-ascii?Q?G1z1EvJDrg2Or5wWJOrPZ0SJ6n67Ob6LYIr5djp1gmamh+WsXO+2Kb7r1+zT?=
 =?us-ascii?Q?GdDtecyGX9Uhn9j1n9JUE4QoQxh5lWpHaeYn+ocgvLN4NMHY9+VW9IZsgofJ?=
 =?us-ascii?Q?FqxIB99b2nVD1plavzAyJSPiRT0yRAGiq6WiCv5fdb04tEA+AizXXCMs0LpJ?=
 =?us-ascii?Q?YgVavdD1yfSMLMEnqQ1pgHhsSJ2rXdDPKWJVx9HsuCDjP52OkqENMFV7mu9/?=
 =?us-ascii?Q?l6KHV2kHLBaLnbDjP/vepl7KS47BexY9t2pSUWT2ZNHYLj7FzIl21q77EYxv?=
 =?us-ascii?Q?cgxb4C9Pnw57vHZQeRDLfsYfEk2IkJzZn/4VzG8//vkxYKh6kBA5aAUdq9Mh?=
 =?us-ascii?Q?Ylxs4h/qUc0sNHp+4T+uomZ16JDWlaJ6Dfvfz4ulpXtOeMpJ6ZiNYvEFxF8v?=
 =?us-ascii?Q?6iXlJa/NC0avStnVtUNt/AtcrnRewMSjZsxOi/1n8UR9/y9V0SacDm5qAgHU?=
 =?us-ascii?Q?8NfJv6HO9+vekhqhKrFkVleIGY/Wax0uCwUZSK14DkKDFWHCklq/iQHYEoI3?=
 =?us-ascii?Q?M4WOlS6dg0tT1pYpRE3aakatlUhUnY/rXU2nDw/BVDU9cSq3gPlHF7GdtWqj?=
 =?us-ascii?Q?gFA+W9ftl24tjS+TCUfbHaKGbI3VfPYCsuoa9glL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52670a7d-2670-46d5-a21f-08dd34d1bf67
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 19:29:22.2549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZpp61efs1TH+oxSzPLUUrO4py7xNGLKDmu5aW9Yx2F17WXJgwbcK6sZQK9k73/8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5605

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

Applied to for-next

Thanks,
Jason

