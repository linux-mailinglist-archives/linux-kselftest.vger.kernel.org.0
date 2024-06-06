Return-Path: <linux-kselftest+bounces-11300-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F8F8FF11A
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 17:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8488F1F21C09
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 15:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28D8197525;
	Thu,  6 Jun 2024 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JqVMJ4Z5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2BC19750F;
	Thu,  6 Jun 2024 15:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688839; cv=fail; b=eoqlTGTGeROzefyjrxcVuX4SocncWDUuyYpeGrUcn1WZAVEJjNSBmOrHL9GV7aAEgf8H3uy9QpiPEiicX44lWnr6m/UyAIDpkThEEHI8tgQAiaO+MqrPyHYWCaGoP8gwy2/wlvVKkqgHR55vdRZm1Mq5zBUQTXrRUz3T+Uw1siA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688839; c=relaxed/simple;
	bh=BWqbF8nTPOz+VN8Dh9mMUqIUVm3CFMTNzjbpjEJHCEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fhhMey6bxWWlsFMGoiQeMgKIqhv9wU7wnry+zoUW+KQ213VcloJuo8JfcN7DtRGkG8qNfEUnwrLCBniLCgjXiYox2yccBTp74+PCB5upjzCHb2BVj73/vUlA6GiXDsZobNcyy0KksPGC7nVW6aRKIpyUViRFLJHbn9OyghBFnlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JqVMJ4Z5; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbvKE6M4q8+GHUVr83vMM2F5A/5zwVDP+gJFz6qIFn9LCJFj6OSW4FJWabUQq1WMsH6ARd1Xx0HE2nF1Ir4JwHGLoQQPikWND1+VT9sBIg4rrx7l1PpEHDbDf23na+Vm7+bitElhgfiebH/MUCkDDGb2K/b3F9ERKM6ufnUvRGxLSNzum4XP0P33Djwf2Y3UUVvo+7YvrBOhX4mpH3f6Qj+DBdr9UOZ7/iMctt0oyVgrSUgpDPdvfaexM/SvxgkU8dNAP3NCP+NeXhlmeCtx+y1IDVxD1LZwtUlj5W/E0V02HXTeqai8IeKa3No0HVuoguf/yBQLIWZSh+m7j5Vlkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RewaFLtv4QdHev3PzSC77exHoPdolEOk8JTtyK9/Odc=;
 b=ML6PqKfzDS0/gBsZ+DJqmpFvegMmPA3Va9FWAVwuCeUgUjunus0puVy06EiP6Qd2l1GogD6+VAVjEzkBt+lFCdyv7mLOg2Marh7p34MMHV5dk4cwbrmyQgX0zFGEA7O1C4DsbhvSs9xvscdwOg7F+W+rDMBpsM/xN3Soi3tQr3rKkyUYdlDJO5GmVSLNtGesR/TtZGOpNqnCf90uMaTlzlsAuzfxb3xTB7c9tFlRBKMeyEyUiX2582f/axkp8TVJxejON2mMU5iecJjLgdqSMYhT+zL8aa7Ywx/sAwtf/khL2Ixk2+1q5/9bu+A/1cbGhSMhKWUHVSOhUDAqSviiZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RewaFLtv4QdHev3PzSC77exHoPdolEOk8JTtyK9/Odc=;
 b=JqVMJ4Z5GyVQ71XpQjp50p4tX//HjFdsvdSUoX8ZxrwTRdXna3BgfEt2/qEy8QfCXWN0KZD/KgPxGQdamQTwdNiFEckJOGxY0BTCO5UYQOAKTQAGLDLX/GUX598+e9CJR2gUSCyBDPHK22hhKcE8L2faJtkO0glXCxPhMajDavry/wFcEnDuxTHw/hpB6JZfO/xFTuZE8xuR2PenVEds3/vlsB5JrLzIjBbQVESJrXbjhHCTVuBrDTANx3C9Viiy/qARWOuUd4kpGr2qywEt6eo5/eIW+tnvx0VJKikaB45/kwzQmBrM7KiD38/joN2T/0co6C4nBYjj2pSe3uxryQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MW4PR12MB7261.namprd12.prod.outlook.com (2603:10b6:303:229::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Thu, 6 Jun
 2024 15:47:13 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 15:47:13 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Shuah Khan <shuah@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, gost.dev@samsung.com, mcgrof@kernel.org,
 willy@infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2] selftests/mm: use global variable to not optimize mmap
 read variable
Date: Thu, 06 Jun 2024 08:47:08 -0700
X-Mailer: MailMate (1.14r6030)
Message-ID: <744C4689-62F4-4565-988D-010824F4AB86@nvidia.com>
In-Reply-To: <20240606154428.672643-1-kernel@pankajraghav.com>
References: <20240606154428.672643-1-kernel@pankajraghav.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_1A98BCE4-F926-4E16-97A0-2C5DFDD51BEB_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BYAPR21CA0004.namprd21.prod.outlook.com
 (2603:10b6:a03:114::14) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MW4PR12MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: 537fb452-baa4-473e-ef91-08dc863fef05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hNMIbkHv4LFySB5+dNWldDQW9+A/U4GzLPV/5uILd7cS7xtsQQfdNJcJoXqg?=
 =?us-ascii?Q?A/fZymP1yGktki4B1lH3G0zetC9V95s+NjiJPOg0jDvgvLnVEyjMWap0+fKu?=
 =?us-ascii?Q?Uua7kF2li5Wz9GpwOTkz/6PBh/6MufOBCMNgpHAgWA3oaZNysxjxS+a5uyr/?=
 =?us-ascii?Q?H1/+SaTFAC4Lq4K40o3YptfG9PtzheQNPg0ki0c+Brw9kMvab4VgrNlOB3O2?=
 =?us-ascii?Q?DnvSkMn6ry7skx9Ne4mA09XH1QVj6QLpG0HZ+n2OrDjfGKsDUZjDUf+N0JL2?=
 =?us-ascii?Q?Ojci6xVmAYLUC8BdT1X9woO0dYj6IYmCLCtrBq0g065/tZAqO0OYmM5DnYVC?=
 =?us-ascii?Q?XxSmgTf0k0OQp4sZXLU8p67mbSMEzNY96d6lhSgu4xr+cmvRmNjeg28xipeL?=
 =?us-ascii?Q?1n70DrK6zv6lZT6cO+q9zai2lFLICwveK5hksWTwq4Ot3Ek7HYXQquKUO0RX?=
 =?us-ascii?Q?I9B0dpNsffUMV/+dknBLmjaBbv3FO6Bddonotq3vmvmIScC1iOOgxqELSf07?=
 =?us-ascii?Q?LK1TBm9+4Iq7ZvZWwBU+K/QGvki+e1ntEhvZwKYoFAGVKrzk6FtDJ2kI6Cst?=
 =?us-ascii?Q?1uZCyOolQSED8KO0HjDItMEolgivF+GVtkZNWp/9S4B5YlCrmgwNt2NXKIcd?=
 =?us-ascii?Q?n5HvWh3GzzUlxzqYZdivTKmrvjqrX1HRKwVnNrIX6rvSFSEbOR2ajYix+Z4j?=
 =?us-ascii?Q?0cf5Znt6bWKrcfPa1cOM0M6U3MjKyiM1Dx86GqDvCwgmZg79EZHuXQEjsT3A?=
 =?us-ascii?Q?FFAH3lq0HUATwV8TvTmAQg2rzlPIlnq5S3/Zb/rnoVlLwBy2K7msCxAqbDox?=
 =?us-ascii?Q?RkmPMVqIBz9nZZKsY+LuwqEnaHbccp41Iohm2yvBGzF73EJpC7NqJLXqIi/6?=
 =?us-ascii?Q?j31RaW1iUTsulwVGVqVbHifMdpcXf2qmVL5YCrq961AIZrUIg2LCqkv3Kq4T?=
 =?us-ascii?Q?SIhn6MnXST0oW8S5DFwzY8k9MT8+DOZ/61MqdpUUmO675wl/NTRGv+08O1ZW?=
 =?us-ascii?Q?f+kH7hLu/QWnLQdTYf6IdsQO+YpmCycozTq0etN6Z2IeFR0ZGwu9ddiRLzl7?=
 =?us-ascii?Q?AAD3t7OYUIeGCnN9+Hjo6ifYKS/l29/481Z6VTjzcZN3n39z63fb4AVxqfxK?=
 =?us-ascii?Q?b0cjilFY6TFqhF6VRQeqc42swJBr8zJ1vjMlzLjBepggVcqZmmFmcBPL2Slu?=
 =?us-ascii?Q?OFWxAXikjdGo9H1XuQMx1DSHE5t/qFV2MwPnNJRfMjG40sy4DEUw8FtLG3AM?=
 =?us-ascii?Q?Cw+t/x77ZILvxDFlIByGCc+NgfIUUjQdVzsg48FNLnn71Q7KDm5wU0FkKwqr?=
 =?us-ascii?Q?uOhJ53A8e+nkVuD0sVE9W3Fr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kx4Auz9Hr1D3n/aF5dfdaT2tHzyZ5CItqGPnR/24xvstCv+1D2ecT0CkMA/r?=
 =?us-ascii?Q?bXYXcV2TwvQJv64MAfe0wAvJe9g2NZ5a6eD3bI/3Rs4ZVjxq/3iKKsEcM3fT?=
 =?us-ascii?Q?Ogonq5EzNdDvhIv+mrBLVR415ioJYvYRR7yyXZZw32jNkqw2ffiGThimEtcQ?=
 =?us-ascii?Q?HH0/ft2C9sB+2sGTntjSi2yLrrJ21a3G0x8VO1qz8UYBdcHAX9mHNFtdv5a4?=
 =?us-ascii?Q?NGl+VHQnFdOtAT2l9VfW0OpVXvBRIT1N0dBkSYXfkPtsk5cDZj5dAs37Xofk?=
 =?us-ascii?Q?RC1ZZ831mhJJpYmhXx7wmGltVFceYvKUUAthFkq4wumk/DdW94cmjnthB7rh?=
 =?us-ascii?Q?RwPpcJdUIBC7yC7HaXQNjb3L31RC+3wlx7BXDC3KpSSC4SJMyRdK9QFDjyBE?=
 =?us-ascii?Q?IoyLjeKIrcci1idm5Nw79EGu60xH81jixhCs4bC59vt7ADbfpbn/WYcCQZmm?=
 =?us-ascii?Q?DzLvmi4Bb0YHbvsvaddWJqJMeS5/B2Poz9WrF6+eJgTB+Cv5DHjybzszmUXs?=
 =?us-ascii?Q?FWrR8iHmEXvYasbxsoGsrZVE9yccTWFI94eBC0PYOMjIxwaahGnLfPSZtwLy?=
 =?us-ascii?Q?h4Vn3VA87Ych6Kqu3rLqK+OvoQc3Yuyl2EvILB+kIlIs4hxTzfmmoNm9kvxB?=
 =?us-ascii?Q?8JG+w4St4H2EBVMP1Q4DkxlST3K3bcsIMTCMD1lUtnvNzliKwzhu+8M9rAZd?=
 =?us-ascii?Q?1F1IDvd1IRyT+VmSBJNyzKAcc97XcuFmgfkLkwZOXrPEC1Fd0EovqPASKKJT?=
 =?us-ascii?Q?2zTYJlQQzqRX42+u1JV4v0s8MQZyobX1aamSswmfuPnenp3ywW0LvPSzFgBV?=
 =?us-ascii?Q?yZyApWVXFie4nouTJfiT7bd8BN4hjD9//V5UaLDj/D04iaJUmEELb4yPoB6W?=
 =?us-ascii?Q?VbQMvNQ0lxUWXhhU56oDKW9rcyZMG9ggR/9rrI1LdKcDccSmiSMqzOBF0NZO?=
 =?us-ascii?Q?VychM1Xp/TZ/nRxz1C8d8DFbSeDeo83urTJWM+erbcxByj8F6WMc+LCIbHkp?=
 =?us-ascii?Q?LC+ktQE0QaeSot4sOL6cUYPIv1NGkxZignozPf4KLpC64VqY/qR0GaN+NbGV?=
 =?us-ascii?Q?UKgWij5tNbI1qKEbPKLjV8BTbCdEp3phD3lvuJbmVSkprUvWo6VBMzieWt03?=
 =?us-ascii?Q?f77DDlgz5ljaDk6r2hiQbAIU3h7LybUpuiFbBcMfH0KmI71MFCXC7NhmHBrB?=
 =?us-ascii?Q?qQk8DqmvIiS38FiHIY0/9OOotjsvC09MhFkvqwCI7RwtiLJ8iLDwRkp6oXp7?=
 =?us-ascii?Q?6P4ZB3IzI0hcZRdgtBPdmYnBr61PE67qYJVonpyyuzicmf3uwiyP4hHHguc9?=
 =?us-ascii?Q?psuspZFAPkpdy/MJZHF+oF7mMZjgccqA0Tuk83yOVCNiWGv8OP4VZqr7x7SG?=
 =?us-ascii?Q?xhv+/22uqYX1+NzTzvjbRfXjvcHMn+qdiKDsiruXBGajznKpO+eY9cwn0nZu?=
 =?us-ascii?Q?k+eP3/CpsXri60RaSCx5GX+1ZG/eTWplsrlBCaEvxE3h6hra0S8OHek7FTMM?=
 =?us-ascii?Q?OmJaDrL7qDKxruYSuhKolnhY2RBCXCxzTaT6gSAFfhnv73pm+n8aMh++adBa?=
 =?us-ascii?Q?rx2xxu+tluNKIwBTyu4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 537fb452-baa4-473e-ef91-08dc863fef05
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 15:47:13.2097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDn0kDBfLEz1bAhLWjEvgk55gFdWG22w2WCILWDndq1JWtX7xvRWQ5do5IRkvRix
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7261

--=_MailMate_1A98BCE4-F926-4E16-97A0-2C5DFDD51BEB_=
Content-Type: text/plain

On 6 Jun 2024, at 8:44, Pankaj Raghav (Samsung) wrote:

> From: Pankaj Raghav <p.raghav@samsung.com>
>
> create_pagecache_thp_and_fd() in split_huge_page_test.c used the
> variable dummy to perform mmap read.
>
> However, this test was skipped even on XFS which has large folio
> support. The issue was compiler (gcc 13.2.0) was optimizing out the
> dummy variable, therefore, not creating huge page in the page cache.
>
> Make it as a global variable to force the compiler not to optimize out
> the loop where we read from the mmaped addr.
>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
> Changes since v1:
> - Make the dummy variable as a global variable(willy).
>
>  tools/testing/selftests/mm/split_huge_page_test.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>

Reviewed-by: Zi Yan <ziy@nvidia.com>

Thanks.

Best Regards,
Yan, Zi

--=_MailMate_1A98BCE4-F926-4E16-97A0-2C5DFDD51BEB_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmZh2fwPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK3X8P/0cVGw5ksplTjZLQc/UzsKIiGw8yRt0JVX7b
svcjBVXi8Ws1zyshjnwsyK9roLaoPheR7BE5DRcm3yRbsZrhgSAb3JkBK4Bf03Nm
cdUr7TkE/TRe4cLontpGhPS57eWpiwK3pFk3EAawa9AhVCSwO+DR0btauRtEeRcG
rXcpvAfeUixedDyHB+wPATtWI+CvRiuE0HYY2hq7leiBmYiDCt/WmQs/Kh3Y2zqm
X84rK5mouAkkHrcJN6SmP3a7fWfzDH30rdxWnJnUe4wAz24gP9q+MMMZstY9PS89
cWoZx+E/HIQl4j/Mt/92Ww2ulf4pFQUALcQt1QiHvJGVP5xrgN4o3F1sYmu8N0AZ
a+gusMlTa++1d8kmt/UgOcvbho+qluSS5LuC3ImHPmDFS8C0JAYD0aA+JEo3V7RK
vOb5BT936jv3abTWdKv+CbNQqdGypzEBQL1eoly6XLA9J+zUPRhEmqqz6qXSTdVD
zOFRaeiYqJt/1wEh65AIcntDdfLfHByTDxSPON0C5z2JdNuZxhOq6fhEhDOQEObO
W8Gaksk5o/a8mXc7Phr/o3Wtsu0pRr+R0R9T6wG+nA3X5Ku3jKcUkbKF9mJG5bpg
9GhQbD6Gnh0qJWKROCq6ViBXvdxMKVE2L55jzBaA8bcBhX/pAfQqUKfo6foDIRuO
T/466k2D
=+DVO
-----END PGP SIGNATURE-----

--=_MailMate_1A98BCE4-F926-4E16-97A0-2C5DFDD51BEB_=--

