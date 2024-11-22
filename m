Return-Path: <linux-kselftest+bounces-22446-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D9E9D5DCA
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 12:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89F2AB242A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 11:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FBE1DE2A3;
	Fri, 22 Nov 2024 11:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lRAKobkE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5AC1D7996;
	Fri, 22 Nov 2024 11:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732273778; cv=fail; b=krm2a0Bgl8y8cRXvTsMb4KuNfZojigdSLbAwrJxk8jJTb/MxiZYGbtrBxcbkdvr+Dagt+2r2AQr23HccNrhvV3MQGIS1+BC72Rg/CrMjvsYglCnGgpMfSjzunMK5IQM4YMWEa+uUKcthuYnmiWGTnLUzQ4mGVXhgSeu7y5Qmd3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732273778; c=relaxed/simple;
	bh=+d40PEe2A553FI9Q72rwp0zNcg3GEmK56gF/EJl5AV8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=odd1KKQFYxJ+km5OCbvvda9b1XCLBhHCDbFKctpadJeDMc6VEheAKabqym9VV0xCKNz6bRIpEuGzm/NQSSrpLRBg5jbx3/ZVzyvM6SMrk8Q/lDcQhzIzvWid6rTu/aXjS3PBQqJ4bm1eGKC2MN2LyGZlPnbKu6R79npoKo0mECQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lRAKobkE; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732273776; x=1763809776;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=+d40PEe2A553FI9Q72rwp0zNcg3GEmK56gF/EJl5AV8=;
  b=lRAKobkERXfc/FictfGp4zGyVdnNHw+0qIwG9MzD7+/JfsvcazFYh5LR
   bT479on1nx1RTzPdF6MRxZAd1ImIGSvn9lh/DPgKu/y6N/DAxfkkhroSI
   F7OA4IqCNEWH49CeH8jG5QZDeElX6K/xCPCfmXERJI2bqplWCMWYuQcQk
   zHile6m+4Cf1wnHZsykkBJlR9XNOwj5XhnIVad9XjcMz+YHFbXgr+56ri
   hUJvVSEBFUYCBMpeKrZyI39FFh2r+JNdWw9la4PzWAMBRUmAZZ8DaQ5+5
   5jXOx5xrG2qUaqDIpsc5ZNBxyNOZsW0dgFCNciDHxhXK81wBSDQgyjPW3
   Q==;
X-CSE-ConnectionGUID: G0Y4pUDASEa9sLZldyM3SA==
X-CSE-MsgGUID: 2xujODRBTB2/p81UMD6Ktw==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="49845876"
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="49845876"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 03:09:36 -0800
X-CSE-ConnectionGUID: yJ2LCjndSdy7nc4AdEpIuA==
X-CSE-MsgGUID: ZWBL7y74QR6cHtKm4eQC5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="121418139"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2024 03:09:36 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 22 Nov 2024 03:09:35 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 22 Nov 2024 03:09:35 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 22 Nov 2024 03:09:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhnuoH9RkaJstHEkfK7N/E11dGTvAvvwd7qWlANHS9eBOmZYGXz0sPdG50egajWuxW4Dx39iKajjZYajNPfePyx8Qz4pyMyyydxtKZYA+RknynK8q4NHWebEbHOqK53EMrLW2YZKHxaEXowc+zicRaw04ak81x0VXtbC7bT4BB3hV592ckmZg8RgkgAiBiq3MeSbPrP5XiVLaQr7txV5eqYNf4GHZyV6V9/BTkgIOewD932iL8a/cM14YJajvajarif6FVfhZoflpRGF+LSRASFwoAdDsEUyxVaxbswnXHptN3rZmw8CwseOfiaYyiqyoehF+sykIUmO0mKBx0LDgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7YsK3eps0cODquGfaYLV/WSqw9c/OURlLJ2Ig56KHU=;
 b=XBEJTg7brFfRKZUpVcS+8pIW1gFB6SzybwTquA5lmOzs05fxQxoQyoR48I78dD89bkOpKILbmm12P9UjzdHz0CXeXBw1WAIhKs9VTcUZhUwnaPno8GPx28UR6LfpkDhwZgZWBZZ+7HzNg49keSJVRGAPpzDfRswof79wFEo8reIy/E+DAJjqJ9Y6RTo/wdrXZ/S9k2h8W0D9gE+G6H8UE4HHE1cCND+funnXxch9aYjJC0N+HfXT7aIdm2vjm/GPbNlanPLvJr4aWdvVFYg+vvaljhZ/Dgjb2pUizGIiMzRdRml7KpbJGSQrsWatxdVss6jUHBjDjENEVHMXejuIKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SJ0PR11MB4878.namprd11.prod.outlook.com (2603:10b6:a03:2d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Fri, 22 Nov
 2024 11:09:33 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%3]) with mapi id 15.20.8158.019; Fri, 22 Nov 2024
 11:09:31 +0000
Date: Fri, 22 Nov 2024 12:09:10 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v3] selftests/lam: Test get_user() LAM pointer handling
Message-ID: <jqvqvnx4shpubflb3xrkplefkmjicaqrg2mut3kc7ijgq3i3op@poafl6jo3t7p>
References: <20241122085521.270802-1-maciej.wieczor-retman@intel.com>
 <kabcughnduiak2ipmzujq5gmsqu4ugfwxpd23gbic2hcinirb4@r3quhedtuvms>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <kabcughnduiak2ipmzujq5gmsqu4ugfwxpd23gbic2hcinirb4@r3quhedtuvms>
X-ClientProxiedBy: DU7P191CA0030.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::15) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|SJ0PR11MB4878:EE_
X-MS-Office365-Filtering-Correlation-Id: cd390a06-11e7-4edf-4d41-08dd0ae623a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?LpM5CsxNuQek0XEAZCRI70t/hVFgtAk2X9Zfx1QxgyPrlOsDS89bwP5PBr?=
 =?iso-8859-1?Q?3xcgp47fS0vWHDhrz59tLvbQjBTfOzLS+XIB0q7Z7S6MNYMhstlWbuih0j?=
 =?iso-8859-1?Q?EB59qB5iG14Y0ZRO6lqbwZPbkDmAvjFuleBaTNN//xUPl+f1317qTrW99I?=
 =?iso-8859-1?Q?nb7EenlaeKfbp531QienfrkPyqTralC+LGcC/RlBUT9Y5TKCSEHmmxf2Wy?=
 =?iso-8859-1?Q?BULEm289AOEc1YDcKCLqNhSqAcES+NyBE725DUj8KhtermorEz5DndJJfq?=
 =?iso-8859-1?Q?cH3uj/ToJNWKfuzldImrOsmuq3JH2oKtGl01S9H33ym5J1q9mC632xPC30?=
 =?iso-8859-1?Q?E9UnGTQ3LzHAfp7Tnkvcw5lpMZvRyLZe6VLiR+RgK86PmKTlVBqIP4YMZI?=
 =?iso-8859-1?Q?XpgLTu2hdg72VyyYV6KYiOx+lgZblfz+bVXRrEwGyyyPsXdm4ZrfmHYS69?=
 =?iso-8859-1?Q?3ublRoOjX66J+GVZMLT5E4Y/YAZMXWRdGmg9xcX+zv0aYh8UKICY4TeLf2?=
 =?iso-8859-1?Q?txX7wAPMRrj12C+DOhFvAizN7Gus1gSk7NVA75XLM0WsY/9KGto380MjyX?=
 =?iso-8859-1?Q?7TOMb6Mjv9BxdU7kn4BcWixw6ESJyQZQdzK5RZ5vAMEDIFzGj1EMCWfRuv?=
 =?iso-8859-1?Q?5mzulBA6+WiEWWpl6xHUNQDWumC7B7Ygrt4iAXA4w7c9xTvy1dY+hfKnUB?=
 =?iso-8859-1?Q?i5smCS32/vtke7Br8ePSuG6cAr1bVew3DGFyQ9aOBT7S3lDm5ZQr5DFNCT?=
 =?iso-8859-1?Q?dpgINdWSuJkBz4VXZbaDZXgtm+24hEWWSdvgdQEVeeYdt6PaVIhgrRSL41?=
 =?iso-8859-1?Q?rMCm8GKYCTmywOFHSNuEORDRJqv0a0RG1S4byAo6WjeDU7YoZRbH5vmXzq?=
 =?iso-8859-1?Q?oPfU/9X89HivIYU818zOS6AWocUDCbLO7nKikuJrnE54FI4ah7GqfnuVQu?=
 =?iso-8859-1?Q?VEDn0VHL96Y1vdnBWxiBIa6L8LfCv4MUCt9OiSb35V6Cu0Il09JBhojLuY?=
 =?iso-8859-1?Q?OdtqFWp7tAtecUv8YBIGbPFhdvwXT0n9TD6zroQbuoTJJAnbIywAVucqYa?=
 =?iso-8859-1?Q?OEpZCgGyW/sjslpDJ5zxqJiwE+FQEPlqtnT6ph+0gL5S9/DTuCeUfKmFyv?=
 =?iso-8859-1?Q?3i4ok5YgZJNtgN9uq9pbjcND42td2MV6oKZ5hEpdtl69JHetofwjp3RE49?=
 =?iso-8859-1?Q?O4tZYnmjt7mz98OqbYln9GMgeElV015GM4ZVw4OnK0lVxOEabwe1hswePh?=
 =?iso-8859-1?Q?t727ASFa4D8VMqOnzVL1j3c1PNcUoZTBg02Ok+LvRRSWFBRhDQTTnZrghG?=
 =?iso-8859-1?Q?USjZhBxBoBlgLHMgafWj2u93dw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?oYqP5hHbnBmpcyOYibrN4aaClgGheCaagAwBUvmlcLGyYdBTAmrSTWEf9d?=
 =?iso-8859-1?Q?gRhi/z+lt9Hfm+dvnHQBH3m9jgykEwlSz9ZPhpgWKdcIel5v/i6xZ8jBRJ?=
 =?iso-8859-1?Q?cDmQpEet3FqFkizWTqKNx11uo9XNDHtlkw9aCMkXuOEppsjNfhSqv067WU?=
 =?iso-8859-1?Q?qlY2iQjXv5ysQo62BsjhSGn5v95hCYauVuysUAgzeKxi2DIYJWAXsjVniR?=
 =?iso-8859-1?Q?j9slILKHFFs96gm7wg5q5NVPg4bnIyRcu5WPfvQAg4+mG/0kk5cxi9+VIx?=
 =?iso-8859-1?Q?SaZAOCOpHS+Eyifcss5Be9L3UOHAMSFPC7q/oB0rrDKfTnRNWkzHCawGs8?=
 =?iso-8859-1?Q?LKySiy6AO3CBMdl4lGwPZwwbOxkTL1E27PxB1PT5OU/y6rP9O18jOhxz1G?=
 =?iso-8859-1?Q?oo9m/WqYm98iYadKctCwE8e1wS7cXvOTH2pVt2yrcdBg68SsXVQtaDsxFW?=
 =?iso-8859-1?Q?+Y88DOUb54yiAwHm4hSxxQMjPdoiCZlyBpm48EuNQLbpKIvIYJaoezS3YU?=
 =?iso-8859-1?Q?4a/7OO3aE10KR3ghpWFDE7xt1PMyZIouO5+reGw0uFxD096Ssr8dhk6wkg?=
 =?iso-8859-1?Q?uHXj/+GOu9VZca4X1+glq1Aeq6Mq6nvno+LOOM4yiZ01pZbncFsxMuxjmP?=
 =?iso-8859-1?Q?N8or7eVusZd39XS0+r2wL418gDAV/vut5/R33DEqrMHITNDE9oSAdAAcqD?=
 =?iso-8859-1?Q?iUSCZXZ8jQs8vS9xUS3NE0a0hnoDBs33wkSHDJsTrKM76JZUcTcJW2z9+z?=
 =?iso-8859-1?Q?v8wPZkE4eUyke60/Kb5aZz6MXA/NddiprwxwWccI5Dq08KfWKMHVc4uoFD?=
 =?iso-8859-1?Q?N1bjjbgem78mYQxP7lttTTuejsoV4eiwteSgf5TAu6WZOx3Yt2sLosJNUD?=
 =?iso-8859-1?Q?qb9asy1Zl1MSvcAtohNxK+E866rYkGHeEk+8tREyxvJdwwxze5uNSjqAYz?=
 =?iso-8859-1?Q?3SvdWgYIjpP0fwp9p7A1aKt0obPJMtasBs6dQ0249s7Af6zfIAm3+OJvmY?=
 =?iso-8859-1?Q?iKeJ20y0mqjptDk+0E9B8qoxEAzZyaA8qDZ1i00Si2n9LtPrCMMA4k3PJ7?=
 =?iso-8859-1?Q?Icfz7me7vngUVB+LCJpgRHIq1Iwsyz+VAu6o3kVP+pDCF7M6xngRHlEgA3?=
 =?iso-8859-1?Q?mGHT8Cbb+XQaytp7wXCwwM2cCXQx5qshP5B1Uz/ekhwBn71pVWTzaNhJ70?=
 =?iso-8859-1?Q?h12/Z4FvureOHXOsHS0msD6lmA0yVC/KbyX8whNmTDVNuRfqPqyLUHWrFI?=
 =?iso-8859-1?Q?CXJZ8MSzn2EEyaEYocsNND/e4cP5isn9RJy5p2Hch0lhnATibPqAfqqDTr?=
 =?iso-8859-1?Q?fF//kSH8dcjcxNHxLD7l2RDqUfg4P/kfpcjoZ8sl20J4pT8SGrRkjLEI1W?=
 =?iso-8859-1?Q?tG5LVB4fsRoE0+x5ujL1xVb4IHqb3Ho2+Gr61377tU/rklMoaADvPbDRIs?=
 =?iso-8859-1?Q?CcKU88Nfb2acFNy+Uz8w/rnKQuEHU7jRrzzb+9e+8wwHMYHpsuq8w495cX?=
 =?iso-8859-1?Q?5rzMcgTxSntTojJbAStRKjRfjGgGbUEX4hsjcPYSys/J7BkzGkhvA9sURb?=
 =?iso-8859-1?Q?fjRk68kmiSixu4RSMjQrql3jSXVfBrwKOXovoCsYR4l052u+50Ce4ArvCV?=
 =?iso-8859-1?Q?wWvYm+5GbhNH0DGy7i/r9quO2f17hYki2Z5g3xh3Hy/wQn/YpBfCpk8hC/?=
 =?iso-8859-1?Q?sif1pZLT9qvYLhmiiG0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd390a06-11e7-4edf-4d41-08dd0ae623a0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 11:09:31.5004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H+GoOdHU23SH+KZbu5ZPx9jHnpACPnGJ2qAI1FevUMIU5iMI7y+9JK8sEGwbmDOau7ARdiK6vTnVhrQv6yw2YPG9msOaBhSes4/CHSlnLss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4878
X-OriginatorOrg: intel.com

On 2024-11-22 at 11:13:44 +0200, Kirill A. Shutemov wrote:
>On Fri, Nov 22, 2024 at 09:55:20AM +0100, Maciej Wieczor-Retman wrote:
>> Recent change in how get_user() handles pointers [1] has a specific case
>> for LAM. It assigns a different bitmask that's later used to check
>> whether a pointer comes from userland in get_user().
>> 
>> While currently commented out (until LASS [2] is merged into the kernel)
>> it's worth making changes to the LAM selftest ahead of time.
>> 
>> Add test case to LAM that utilizes a ioctl (FIOASYNC) syscall which uses
>> get_user() in its implementation. Execute the syscall with differently
>> tagged pointers to verify that valid user pointers are passing through
>> and invalid kernel/non-canonical pointers are not.
>> 
>> Code was tested on a Sierra Forest Xeon machine that's LAM capable. The
>> test was ran without issues with both the LAM lines from [1] untouched
>> and commented out. The test was also ran without issues with LAM_SUP
>> both enabled and disabled.
>> 
>> 4/5 level pagetables code paths were also successfully tested in Simics
>> on a 5-level capable machine.
>> 
>> [1] https://lore.kernel.org/all/20241024013214.129639-1-torvalds@linux-foundation.org/
>> [2] https://lore.kernel.org/all/20240710160655.3402786-1-alexander.shishkin@linux.intel.com/
>> 
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> ---
>> Changelog v3:
>> - mmap the pointer passed to get_user to high address if 5 level paging
>>   is enabled and to low address if 4 level paging is enabled.
>> 
>> Changelog v2:
>> - Use mmap with HIGH_ADDR to check if we're in 5 or 4 level pagetables.
>> 
>>  tools/testing/selftests/x86/lam.c | 110 ++++++++++++++++++++++++++++++
>>  1 file changed, 110 insertions(+)
>> 
>> diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
>> index 0ea4f6813930..616a523c3262 100644
>> --- a/tools/testing/selftests/x86/lam.c
>> +++ b/tools/testing/selftests/x86/lam.c
>> @@ -4,6 +4,7 @@
>>  #include <stdlib.h>
>>  #include <string.h>
>>  #include <sys/syscall.h>
>> +#include <sys/ioctl.h>
>>  #include <time.h>
>>  #include <signal.h>
>>  #include <setjmp.h>
>> @@ -43,7 +44,15 @@
>>  #define FUNC_INHERITE           0x20
>>  #define FUNC_PASID              0x40
>>  
>> +/* get_user() pointer test cases */
>> +#define GET_USER_USER           0
>> +#define GET_USER_KERNEL_TOP     1
>> +#define GET_USER_KERNEL_BOT     2
>> +#define GET_USER_KERNEL         3
>> +
>>  #define TEST_MASK               0x7f
>> +#define L5_SIGN_EXT_MASK        (0xFFUL << 56)
>> +#define L4_SIGN_EXT_MASK        (0x1FFFFUL << 47)
>>  
>>  #define LOW_ADDR                (0x1UL << 30)
>>  #define HIGH_ADDR               (0x3UL << 48)
>> @@ -370,6 +379,80 @@ static int handle_syscall(struct testcases *test)
>>  	return ret;
>>  }
>>  
>> +static int get_user_syscall(struct testcases *test)
>> +{
>> +	uint64_t ptr_address, bitmask;
>> +	void *p, *ptr;
>> +	int ret = 0;
>> +	int fd;
>> +
>> +	p = mmap((void *)HIGH_ADDR, 1, PROT_READ | PROT_WRITE,
>> +		 MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
>> +
>> +	if (p == MAP_FAILED) {
>> +		bitmask = L4_SIGN_EXT_MASK;
>> +		ptr_address = LOW_ADDR;
>> +
>> +	} else {
>> +		bitmask = L5_SIGN_EXT_MASK;
>> +		ptr_address = HIGH_ADDR;
>> +	}
>
>Hm. Why not use cpu_has_lam() for the paging check?

cpu_has_lam() seems to return what the cpuid reports about LAM being available
on the system.

The problem I was trying to solve here was to determine what pagetable level is
used currently so I can setup the bitmask to create fake kernel pointers below.
Can cpu_has_lam() achieve that? I didn't see any correlation between the cpuid
and active paging mode.

>
>> +
>> +	munmap(p, 1);
>> +
>> +	ptr = mmap((void *)ptr_address, 1, PROT_READ | PROT_WRITE,
>> +		   MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
>
>Mapping sizer of 1 byte looks odd. It is not wrong, but looks strange.
>Maybe use PAGE_SIZE instead?

Okay, I'll try that.

>
>> +
>> +	if (ptr == MAP_FAILED) {
>> +		perror("failed to map byte to pass into get_user");
>> +		return 1;
>> +	}
>> +
>> +	if (test->lam != 0) {
>
>It is always true, right?

Right, I forgot to remove it.

>
>> +		if (set_lam(test->lam) != 0) {
>> +			ret = 2;
>> +			goto error;
>> +		}
>> +	}
>> +
>> +	fd = memfd_create("lam_ioctl", 0);
>> +	if (fd == -1) {
>> +		munmap(ptr, 1);
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +	switch (test->later) {
>> +	case GET_USER_USER:
>> +		/* Control group - properly tagger user pointer */
>> +		ptr = (void *)set_metadata((uint64_t)ptr, test->lam);
>> +		break;
>> +	case GET_USER_KERNEL_TOP:
>> +		/* Kernel address with top bit cleared */
>> +		bitmask &= (bitmask >> 1);
>> +		ptr = (void *)((uint64_t)ptr | bitmask);
>> +		break;
>> +	case GET_USER_KERNEL_BOT:
>> +		/* Kernel address with bottom sign-extension bit cleared */
>> +		bitmask &= (bitmask << 1);
>> +		ptr = (void *)((uint64_t)ptr | bitmask);
>> +		break;
>> +	case GET_USER_KERNEL:
>> +		/* Try to pass a kernel address */
>> +		ptr = (void *)((uint64_t)ptr | bitmask);
>> +		break;
>> +	default:
>> +		printf("Invalid test case value passed!\n");
>> +		break;
>> +	}
>> +
>> +	if (ioctl(fd, FIOASYNC, ptr) != 0)
>> +		ret = 1;
>> +
>> +error:
>> +	munmap(ptr, 1);
>
>	close(fd);

Thanks :)

>
>> +	return ret;
>> +}
>> +
>>  int sys_uring_setup(unsigned int entries, struct io_uring_params *p)
>>  {
>>  	return (int)syscall(__NR_io_uring_setup, entries, p);
>> @@ -883,6 +966,33 @@ static struct testcases syscall_cases[] = {
>>  		.test_func = handle_syscall,
>>  		.msg = "SYSCALL:[Negative] Disable LAM. Dereferencing pointer with metadata.\n",
>>  	},
>> +	{
>> +		.later = GET_USER_USER,
>> +		.lam = LAM_U57_BITS,
>> +		.test_func = get_user_syscall,
>> +		.msg = "GET_USER: get_user() and pass a properly tagged user pointer.\n",
>> +	},
>> +	{
>> +		.later = GET_USER_KERNEL_TOP,
>> +		.expected = 1,
>> +		.lam = LAM_U57_BITS,
>> +		.test_func = get_user_syscall,
>> +		.msg = "GET_USER:[Negative] get_user() with a kernel pointer and the top bit cleared.\n",
>> +	},
>> +	{
>> +		.later = GET_USER_KERNEL_BOT,
>> +		.expected = 1,
>> +		.lam = LAM_U57_BITS,
>> +		.test_func = get_user_syscall,
>> +		.msg = "GET_USER:[Negative] get_user() with a kernel pointer and the bottom sign-extension bit cleared.\n",
>> +	},
>> +	{
>> +		.later = GET_USER_KERNEL,
>> +		.expected = 1,
>> +		.lam = LAM_U57_BITS,
>> +		.test_func = get_user_syscall,
>> +		.msg = "GET_USER:[Negative] get_user() and pass a kernel pointer.\n",
>> +	},
>>  };
>>  
>>  static struct testcases mmap_cases[] = {
>> -- 
>> 2.46.2
>> 
>
>-- 
>  Kiryl Shutsemau / Kirill A. Shutemov

-- 
Kind regards
Maciej Wieczór-Retman

