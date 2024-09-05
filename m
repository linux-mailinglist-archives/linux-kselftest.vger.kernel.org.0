Return-Path: <linux-kselftest+bounces-17275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F5396DEAC
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 17:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 345251C23815
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 15:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1188119DF70;
	Thu,  5 Sep 2024 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i9N6iGj0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CEB1CFBC;
	Thu,  5 Sep 2024 15:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725551072; cv=fail; b=k0CNP5P1RnasKGVOo1necZvx2ud2lIoPmfN+eNVW9ISVVKiQIWCKHuSI09MYiLvSaLnzNFYpdDUje30gwk9CVJGi+qkz7Bz/C1x0SFTwgJEucNU3LvvjBN556Md9d4tOlsKt3EVK+rzNz3mh60aqHpJUPr99TPJ39gZkomrVlqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725551072; c=relaxed/simple;
	bh=S7fFL8zk9UptGbUnyMpGEer/DzCFcqzB2G1iikzIGJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FgFUDxA7ai0V+zcO48clx5dxzOMYvG5R+GWbWmApQfJxT1eJNIDu4JZuoBMHwxvNi35f370lH7n79duxE1M6exGpG4h0rgcvt/l8yBL6wpZJq5zhnFDPNOh45vWyGYzEFBFP7J+10Ap2jEJgkRw/MLKTC3WTEZrFmgn3W4jeBTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i9N6iGj0; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lawwd/FFd7VTFdjjEpd8GievzQeGUv8oEHUEp/ONrMoipczxXgXA/59LCHsaagv72YpI0sn8xjgpHFhhHBnHoFaF/7+/RA8OP5dl8TY7F0lssPM8OpY7i8Vo5rfauDHgfudICs1aR/kJczjFhAg+psfzmc7rp3HOkhbGxA9XiUn00zB0O9BmWEVAPonc/R9KTEtAmLhLthEFABLA1H4dmrpphQWf+Rtj7Z8167RA4rAqvGG44CEi8oMRcr/cBDFDFWvZM6zOi/sDwdt2DXfxXu/W5ZlTt59kFHAEg7kkHh8wg4FkxBTz1eLK2BgiDyK5Mu0mk9E2DLgl5egCl6qfDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vf45MmFyGd6nTQfpiZRFvJAydByhVYOq/Pz4lkal5Zo=;
 b=o3QtksSClTQHhwA51bfJafA8ORftVrQfeuNy3+yeFJ25z9QNEr8Wqzouzdm/FTsoRN8smEjZ/7/QMLwgVxKK6CAx6F0czUzLzoiDPJR+E5Abi1rHEWQBji+KLK79HBDmrkcI32JArh/eo4FbJFRCMrpwOd2B/9m5WqByGpHHc0d6STJfLN9vqDHwrjQVIrkIAucBzJxQaeOmEP36S9nh3BTI5vdVgfNWCDoULTi87k/NZKNR/sGTEYqhy07tD3yp1aBgtQNCoXrmOuRU6ZBEpHS1PHOmgeH4noyLRhT11J8oJsFYE4CXRUMzkdxRlPYiHVnrlST29Q3WurBom5LuaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vf45MmFyGd6nTQfpiZRFvJAydByhVYOq/Pz4lkal5Zo=;
 b=i9N6iGj0isKUPrlK1WUPX7KHNaX+nx5m8j2V7qi+KA11bhJMTrkA00GQkE34yKQjKxqUaTvLy1wUejll4uNf91p/GYWbItREK/S8Ed2FhpU+V4cuWy+89JspSSFvNHRfskrYcYOXB3pi+czSR75i+kPmaaPGE3Z3557R7OyVr5A+2uHu2ayB33BiojVwx50U/iQYnOPKPn/IuZPTb3/CgT6UrMFKRsg74Y6meBHXyfx9u2DsHnVV+fzQNjnvKm0Z6wc5aHOAyrxCxdz+bJqJsD1c4OTZUqFnp9/nztR7JkCGm6gJUA0MF4iPSKmkAzPjfB8jQm+0ceyN9HigL8Saeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by DS0PR12MB7947.namprd12.prod.outlook.com (2603:10b6:8:150::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Thu, 5 Sep
 2024 15:44:27 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 15:44:27 +0000
Date: Thu, 5 Sep 2024 12:44:26 -0300
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
	yi.l.liu@intel.com
Subject: Re: [PATCH v2 01/19] iommufd: Reorder struct forward declarations
Message-ID: <20240905154426.GL1358970@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <c5dd87100f6f01389b838c63237e28c5dd373358.1724776335.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5dd87100f6f01389b838c63237e28c5dd373358.1724776335.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:408:f8::8) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|DS0PR12MB7947:EE_
X-MS-Office365-Filtering-Correlation-Id: 71333d75-cf0c-4082-61e3-08dccdc19fd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SOybq9ULj1t2R6ZjOEbu17/8neyNTvwjhhd8dDC3zhIH4HiX6OdbEtplO4Bx?=
 =?us-ascii?Q?BRd1o9WUz/BS5JBZiysB7HLgcp6juYzfQeI+T8GYLQd1q+ftqdCgRjqc86gb?=
 =?us-ascii?Q?fuqZkOCsrg2wnlKdgyPWoHHDcGLzGIjJsyrfiRF5guo1VM8D3yK6wm3ayFWn?=
 =?us-ascii?Q?X2DBgGC59TywKBX3aGhxBRtFtgNe7VHoMVlPoVkC0I80jE1LNuGzAjfKeK7f?=
 =?us-ascii?Q?j80iu/BRcu+efRGCuk4532TGFDU4gSlVYbPHxjT/jQlUie1faE5bNzlxTfZN?=
 =?us-ascii?Q?q5h2kXKuilONlsFPhbhZgtatsBdQS/6hrWZjKwfcBqdBleKC/l0RvyWZMm9d?=
 =?us-ascii?Q?VdkwwNC/Pvv/fjDrAXOrmL3ut1jHSOBGOjGKNT2CiH0do+mIZgKDwpuHfNig?=
 =?us-ascii?Q?37Tin8WkupqvZYBQQD6dxsEzTYNwiXGwhNQACAaYnddN2KWBznY13f9SdXj+?=
 =?us-ascii?Q?cJT/4fo74XA84qp88PGUWzMxg53kFbKXb12GreJ1BC2X4RZx3Z7YaX6J6LiM?=
 =?us-ascii?Q?TIcTUs21mXmiXbCFkf3DHHpG933rINnohIwPConT15p9G0B/LqBXdQbKiZ1n?=
 =?us-ascii?Q?cIcNorM0NmDU4ENebqz73oKdX24tvGYttqqezGdmhyXJy9vviY1wKhl5zz9s?=
 =?us-ascii?Q?73NmL8+e8VCShNWBazSVTCWxsIuR9uAAIGRibJselwWMXo2+mHuOBT10sJHr?=
 =?us-ascii?Q?KKDy0+1tQ0JYVHrCTlEvoprG/TmTmMt6PIWL3qArGGZt2toxAGaiCVXyXLcl?=
 =?us-ascii?Q?nlNkXmv4/D6ffen1uN68qpNVgNwvJ1wex1OhI3JewhA4/P1QYvlIIWIAEVdS?=
 =?us-ascii?Q?+DzKwPjNMH0lmW0CNSD17zj0lKyjRm3tcNoYOMrx1fmCXoWjOUl+xMxwxnqq?=
 =?us-ascii?Q?Ozp8939PTHAln2YfaXqRUzSdD++D28eDfYHasLucdmeXlpA9vFkb41eQLSsf?=
 =?us-ascii?Q?sWJF07dtbV3BoD24ZPWioajfViWM/EQrGr4wwlb/aZuFKpnRcU1NAeJWixFp?=
 =?us-ascii?Q?0LmD2mHHo33M1A2gzOx+0gru4P2PHJECHFadwxCfgWUCW/4DsmCpugfd3Lyw?=
 =?us-ascii?Q?AfJwS6Ei28JaQ18hvaBXAoYS6x3MYJLl74GIdEuEslUwzfg3NV4mGmm/6H6j?=
 =?us-ascii?Q?snImhWz5IAz+P0uWSjyt/txhzLt4i3VC6EATXhWkE8jgbeBB19WsCwbq3rKe?=
 =?us-ascii?Q?unAqChUBXgXt7H/6gDlFf4rCitiJTEpdQlep/iueVs1CRh4ge3av8q3ECAAa?=
 =?us-ascii?Q?LKuLzQUaWnKUPu61YlG6uGMoa8GKPHJO5BpxWpuvdplAiuUxse2nW2vIQKKZ?=
 =?us-ascii?Q?8avWqY3BBxoaukSm0MWQPWp8NqohpNmcsGEWUb3oG/KoXg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/pHxcvUjQUup7YEX1wNLEd43/DS/78QZP0v3nj0gpiv9J0bhfdF6vH51aN7P?=
 =?us-ascii?Q?5cLAK3EfChHhoPr3TuS0XEeFJhSQMuwo2Bh4gPtbwvlithWPiN6sagPiMBZv?=
 =?us-ascii?Q?6U4E4Yiqk+VqJdrGs5qLd7gNUdKOPyrN5/cQ5f8ePf08rdlgxlkHDz4MoQ1r?=
 =?us-ascii?Q?V5M6f3Lv+mb8JnXR2uJEGLGHK1BFDSemvQXtZX3Dxuc8WCELb/4YDnsvX+p0?=
 =?us-ascii?Q?tMW8seyUojjcR3SdLbU9177XU3gvr8CjHGuEs4VRfxVitU9vwHsQajeqhE7Q?=
 =?us-ascii?Q?OREg2oKh1jyN2RnumIW+LK8QI8VHTp/HDg8wPexHT3Z8zSYCbohuvL1umIFd?=
 =?us-ascii?Q?qqHx7xlMqGb+WyqDjs5Z9OBLz4X0/YCUszJaEihhZsPgYmGLNYju0L0DfNR5?=
 =?us-ascii?Q?QGJNn7flsw9T4qBB9nI4p7O4O1dJ6ChzQsMBnD1KHBNe65jjR+c7eIqOZzNO?=
 =?us-ascii?Q?VTWwWtzxgcRBf0Vbztcwowidy62L6v9hLg7zJVxcZRzF/mzOq/ULtEp7MrAT?=
 =?us-ascii?Q?74Gv8OiIlA6mQvJFOx+tyw581z+JOGezALLvWu+qjB2/WhH9+X+1F3FzKoWW?=
 =?us-ascii?Q?dki0V9srbDckqnVeGr0uHsrIaMwpFSHkqDd9SLeMKHyrN6Yvx0k+yJ0GPOOg?=
 =?us-ascii?Q?dRsfzc/0lkvXNM90SvoS2nkRNhnreGoXq4MOk/yF7caUxYAergCOEqB0+0tZ?=
 =?us-ascii?Q?2APhNNZOmmS7vYvJqDmyxmgSr0WUTPtIy7aUiptw2hbKlNEDMpf2FRmia8rp?=
 =?us-ascii?Q?IUF/yPassjtkZ+/L/ZKbI2rJgs+Pt5/LXSqN6BtdSFtem39zoCx1Wl8LsrT1?=
 =?us-ascii?Q?yFuXLbU2IZKBc7h0awH52PEHSY+TOmxMzgz4E66iGDYHAdFNuv9mDI6mkgGv?=
 =?us-ascii?Q?9R4b10FFJJkuOC5DB7+AKE4iNLOSoinDdu7ITNM90udANiPJrYHdxTs/Lt0m?=
 =?us-ascii?Q?QQdNUHqhlT6R8iG9Nb0+ubME64Q/Zi2ye2IjJ2nFGZe/foajmm8muwoS6ceG?=
 =?us-ascii?Q?BywOWb+2+8SddbKPAdpYudTxdhTKgHs8K+42iIm4+1Tli+yvongOuR2eUyr9?=
 =?us-ascii?Q?avrFI0LyZUR8eD7im6wnsJmzsrtN8cu713bf73WSi49H4k4OX/xtxFQnEGzJ?=
 =?us-ascii?Q?6on+qRNk0A4RhUEKcIhuhyDHAGKxOp9luwIOE4ZBV5M5Pb8n2mUhB+Y6M9MG?=
 =?us-ascii?Q?bv4r1SDlqI5WyHgnNWpZPbNd6q8JJzm/fSa3hvHMSqs50xDYhHDETdWEsMp0?=
 =?us-ascii?Q?O3vP7ZAR1792ShVVqLwWg1CEa/k3Cbw7FgHfUvvLfSAD1YKz6wF2AEkXagHr?=
 =?us-ascii?Q?6nYpIrwXHKFxOLZLwr6CpsYSUfjzXWYtwGPX3t25p9XJQSMNzJa2ZU/P+4Za?=
 =?us-ascii?Q?hbSu9rjQqvytXBvMz0R9thpxP7Iebv5u+ywoVbS/2I/qk5vdTxB0qfnJmiUz?=
 =?us-ascii?Q?dZ9ItOEeqwJ3FFi0czFnHWUB2YfTiPiRTI2TsolMROP5drOiDCQJMWDqoByg?=
 =?us-ascii?Q?qcYS4JchcDfqjnh67jjxIcdqyPVO9lT9G4cebtPGcMP0vMzGM5Mpfp+j6cvh?=
 =?us-ascii?Q?Q3+bMjYdAhwVF0dz1XyxyIwZlMh3/sv1eV62cVyC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71333d75-cf0c-4082-61e3-08dccdc19fd2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 15:44:27.4794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N2Czk8X+04Rl0EIcd+fWGFnHLdLj9Nwq7spivnleiqftLm+KD5wP1igihgad6q5f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7947

On Tue, Aug 27, 2024 at 09:59:38AM -0700, Nicolin Chen wrote:
> Reorder struct forward declarations to alphabetic order to simplify
> maintenance, as upcoming patches will add more to the list.
> 
> No functional change intended.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/linux/iommufd.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

I picked this one up

Thanks,
Jason

