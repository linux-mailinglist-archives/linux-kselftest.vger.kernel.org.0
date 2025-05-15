Return-Path: <linux-kselftest+bounces-33113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD27AB8F4A
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 20:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCDCB3A6EB6
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 18:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DF81F8F04;
	Thu, 15 May 2025 18:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L9fsASRt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D73313CA9C;
	Thu, 15 May 2025 18:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747334809; cv=fail; b=E0dYarno2yR8KQFbmTltjOvjbm68cGyNwTxWdEss/+mDO2ESq3w66wHoKtq8ck+y/ixlBQMdJOIyVp4wWvYxbjWja3adYjeov/B3Rmmk6lqeSYCrzS35xepjf5J6aNfENDcImvV+DUD2hFUwvrEeTtQAVgMDZvbcv0+IFk44u0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747334809; c=relaxed/simple;
	bh=Q2GlEc8y1osB0kQBjlNbZuu9Q3BqH5vHBKOLR+sNcxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DTULlgt5psobRXv8YxhQNx0mv8a6L6nvgbR4qzDk+yiL8qgYCfsblUKRTLjzU1yW5XiffeFqH1084VKbdNyTSnxfygeKGkIyEFHnXszMJw4tp1upunTNHu3mSdV+eC1cUYcCoPZqzlY6oJLpE21xyVKZw93XNtqFwRXkeb+9ONs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L9fsASRt; arc=fail smtp.client-ip=40.107.236.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSopbHw+FeQ1M+DQWmQZR1/dqTEb5YSTqWHvLbEMz3a4LKjc0eLyuG/DCz+1c2YMkoUktsiYrFGIm0LY1ckAyJ99m7eVQdTsC3kN3PA0Lx8UZHHX2rqG4p76C/InZo/GgE7Neva6cnHr9t27S5aTZjd8egK7uWKqnimUq08mkwTbm5Kpi+jgTOPxZYHHbOt978Z9x4qbabTW8qnc9j6IGZ4EZz6kOmgU8Y1NDZnueFsv7e4O3IvK4FwPlWwixuumTK4yIlhu5tWhFNjxRDxDGfttx7KlwcrA4k1svpF5WXejtzowee6/rzK4m7lkyei8IQq1eqB5LfK2Mh12hg/nYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOcNGVUvEDUOlgSulZzW/cMV7td/bKXAmIXmyyE0ctU=;
 b=hiiNrB3DE/7wBPzuVanh9sVlpfA7aY95XlAMTpqxvuY7HM38rK3vPTJxATKjXKMDJE7rglXGSTmDoOhh8aPSoEyR4V28wzdhlx6BBYeAhjE/Qmx8K3/wUoWYG1qvA6WXqBBziZcAcJGIdlbQyrqT3InDBilHqPE0lg9qDSn7DYghrPZr4xwaxBsuAS0EUqQS32oPXZ5M/9Vwb+Vaits2NnbOI4fUbI88gjVexPFT3b03/JlZtl1a9zdJUkVayC2ncJnxLnXygttPcwFbekalcEGahkfWPZbsOAlLng2/k9z/tVcWi2sE8FK2mF9Z4+bcAl3k4lr/DyGaS4y4PucZbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOcNGVUvEDUOlgSulZzW/cMV7td/bKXAmIXmyyE0ctU=;
 b=L9fsASRtTsrNyRtR0lUsitaeSMqd9nAjZ8Uj0FHC5McVdqIHkP405OZIJ9MDz3ynZ/0sSG0smZtOqNpV9zRcvs0cJm3Gt5GUkvHSzzMiohr+9oyk/e2aDQUa7egIaeuUI55/9D7eWwP+s1Cu19BNR8i5uTiHjHR9LgyANiWYaxNwp4fJ5lof6AoTvoVjeYaL/+LKqbwZPqOr0zpmuoSI+F2fQV/3GyvRX4Q4KR3+aP2RY6b6fkphDjepfD6QoDIJbNQX+A5qfdxlHCjJ2IJhHrQ43gkz4iZiqVK15IYIQWct1kmF8vq0I3N4xx5bvVKE5rmaQ/XvFk+LbJPBJ/dqIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB8858.namprd12.prod.outlook.com (2603:10b6:806:385::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.31; Thu, 15 May 2025 18:46:43 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 18:46:42 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Pedro Falcato <pfalcato@suse.de>, Adam Sindelar <adam@wowsignal.io>,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests/mm: skip uffd tests in madv_guard if uffd
 is not present.
Date: Thu, 15 May 2025 14:46:41 -0400
X-Mailer: MailMate (2.0r6255)
Message-ID: <6601AD88-C2B7-47DA-B75C-46AFEE1BD2AC@nvidia.com>
In-Reply-To: <ec648245-c771-4e4a-b355-a86c99ad8143@lucifer.local>
References: <20250515182333.346587-1-ziy@nvidia.com>
 <ec648245-c771-4e4a-b355-a86c99ad8143@lucifer.local>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0353.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::28) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ba2a08f-d654-4f01-b39d-08dd93e0d5f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rxHepewoKiTfknZmxex2U7F3uEAfG4ztWn6kGjM4VwqBY5CV/MZLoUGbOBL5?=
 =?us-ascii?Q?zrVk61vLjpaOFPG2XlJ5QT3JE7G3CDBPakhrzxzEGgJZKRmhpHKvptFwmBMz?=
 =?us-ascii?Q?BIK5Q0Zom6IDoGVVoKd381DPFO4Ku1ptLFzFYNWBhS7tJMavkw5WlOKVJJOY?=
 =?us-ascii?Q?QU3b07IprWRgQz2omxe+42SG4gX4WRCkxdxzWbobrP3Qodp/PHYr0r1PXFcg?=
 =?us-ascii?Q?dm6TtVFcuhrdd3rdiR5Y37j1QPsOwX9c77a3wsPP0vFR8fvrLlx8owdcI2LP?=
 =?us-ascii?Q?hXAVM7PP/vLolXXgRPu47jigLjXahieVFbopNvp8ZUnfWfhlgOK9irLSDw4V?=
 =?us-ascii?Q?RxQ+YQVh1ZEAc4wdhw8zAyNpoAmHOoII6OAv1Nr7wzw0aSqkfKStwqgMkB5w?=
 =?us-ascii?Q?L+zyDQnetSjm6WN2O/IN7fkFY2WeXaf7UWqbHHqPDTyZ+EqF/ODpDys5G3vT?=
 =?us-ascii?Q?SR/CuVLoD+wrXhxoFWcREz8MlcpeSh6EUWPDCULJln2INvRKCVM8EWcw1X3Z?=
 =?us-ascii?Q?TpiJYqLfUwz4ScaeZtWxBuGFrufaLwA9mxyS9hVOldiy5hQIg3G/wgqv3YAB?=
 =?us-ascii?Q?0rEA4wrbOGduSqii2rbTCEJsEYUNaqg1u/0x3TtbuaHvJ+J6wWgEhZOj24Qq?=
 =?us-ascii?Q?MY8IG6M2aDCkzg/y5wvkoY1vky5YjfYsu3FWALEYsRyvGC7wGcxUbKqfjpOM?=
 =?us-ascii?Q?yQlQPQHvede+6PL9k7er96lzB52hivofzNF0dZvE3SxoAf7RPDNjtHMwZyzS?=
 =?us-ascii?Q?8kX/z/aHmbTtpx2f94pwU5e2UEK+6DXvFx1NO3tjBEIgHv0siWLf1xMj051S?=
 =?us-ascii?Q?cKNov9JaMgP6TA4AaF34cQBzhoRK4IgMdaFcrJwWTf31LtdHg5i9UzL63wmq?=
 =?us-ascii?Q?E/P2QJuwCcIjYXEhyFPmEtyYFgV4GeyIE9ygKAG1xcFeeVZETetuFrNhx7Lj?=
 =?us-ascii?Q?iFHyKhYJ1eQAxX2OKj3Mb0fW60V5plGshG1BOZZ/GjmCr2v3z+1WFpMmHePb?=
 =?us-ascii?Q?/4YUX6apZJQAeNNo9LzA+wmSX1+xaGEyKo0+Y33IorAarx1DThUTUQdQYefn?=
 =?us-ascii?Q?xjthF+BeQ1uBr/7HoAdNeRvyEdmxeVM/cE/x8BcwVjtMC6IzLV9IMKHWNVjK?=
 =?us-ascii?Q?PNYzjZCAnxsIVzL3PwPR5H6FsRw14G/YqUVas1Bs4ybXUqDNUkgu7MfgnIRT?=
 =?us-ascii?Q?iaMvqBKu0lksD9nazRT6CCwYBce0Cg22zKSiruo+k7XF5yIU+VynVt98UtoX?=
 =?us-ascii?Q?MFg+2E14JATqfMTE6oz4bSQcYnlmWRqlS635NiAfmV4ZouHt58nSNp013Ogv?=
 =?us-ascii?Q?KbIJLMsBuB5oSVAQsgbN8sLWx4UIFmyacYwv4YrBmBfFCue+7bALYnqtvnY4?=
 =?us-ascii?Q?73SOKg3vR8NzWt4/wN31fzGmRl/+jQn8Wp2aB5HrarmYit5rCUg31y3j4/TL?=
 =?us-ascii?Q?vQKVqpDBJ6I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wh6z2/m90G02kTDygovAGTzzCaQiW/KcRSeZ0KOFSfA8gdIHgqX9c7cewUKw?=
 =?us-ascii?Q?8D1//L1MdANCS6Xd1rfAy2fUZ5Anv4enmdK16U9grf/jEAtGXvB0feu0WxN8?=
 =?us-ascii?Q?rRO6JpYxwVdQ9BOowAF1l6MvVIV0GnIsDNZrB0SY55rgS7l5k9mPcJ+PAY+N?=
 =?us-ascii?Q?+80IPR766NXqsLJopQfShgxMZLWEfPZS1owCAa02ski9pYzPX04T7NLVyyhh?=
 =?us-ascii?Q?kLg9eotbqcnIS4J1XgEQU+KeHeeW61RejobAUouqLHzE58CijntE7r7iUJE9?=
 =?us-ascii?Q?DxQ/N5UL+h/vFS/YXxTFr/JKAYHcDjSdNOQmYJJ/qHmBRRtbpTawtM/Bw6Xf?=
 =?us-ascii?Q?KoppG5jC01BqBmghaRDLdi7jISMxpmmkiHOxK6rphucSh4eXTb7Oqm+NTAE6?=
 =?us-ascii?Q?CuX552jWAUUrVuI15c5XHIui/kq8/JLJHe08zZiFXmDPRFUjnfkFY4je65fF?=
 =?us-ascii?Q?QO1PtK1+Bbp0kJbx7a10HSzBmviq71eb9JBmFtgNKUtrygufoqCtVdDEoEnW?=
 =?us-ascii?Q?3pGCCqDcduQs0dXERyzWS2bkk945nBqbmXgODChHWaVcMebdTnrse4e7IVQq?=
 =?us-ascii?Q?WzzkrZeUznp1eL6G9F9mbc176V/q6nHPWtmQrZqE4MU1l1tIyLKAJsso7wZ4?=
 =?us-ascii?Q?A6KCprISEkXT7dNyKE+OViLb3eZe3MQh30QbOen57+rub2Cz0qDMaVLB/hNL?=
 =?us-ascii?Q?FaP6S/VSw0nz09GEqO1rd6s+zvJAIRaMzbmLNP17sYp2aEEalde4bhD44lCX?=
 =?us-ascii?Q?WXFE3A8U1i9gtuMfzjUEi26ZATyeNgXyDMIDY4h6y84gOKtPm+DSuKjsfiet?=
 =?us-ascii?Q?FGn0zO+kQK1S+QGfIqhah/hw4CmJvQgrBoefnmiC4JDtCJ+ZNsi+xMEBcc9K?=
 =?us-ascii?Q?eNt4i4cDwznAQ6KgxJLc82u1a68r7eEE6eyuvHZ4Xsf6kSb7Q4qqsmEyMBx/?=
 =?us-ascii?Q?PaVk7K1FDW38ibMr1wnFOd/3PF56mju9K+xSZYsXINx94OUzfuS/OfCcA9xN?=
 =?us-ascii?Q?85L4G2QcqodjsoFsNPQ79wdvGDA1dDHmG5Hs5Pt6AdtnneuXHiilt1c6ZuTu?=
 =?us-ascii?Q?Vdt7a/0Af5yPD5ns6Em5l7wfiXpzG7MzKFT+YpUD+/bhmj9+wB79Bv8vVuxF?=
 =?us-ascii?Q?/5CDd14rT9+m893aNyxPBUAXneSS5JYBKHvRjM3JRP333pebMw7RyTSh7Q8w?=
 =?us-ascii?Q?Jb0coUusxIsgTr+lBSb70YOGzC7ciUIcDlsTcJut0x0vFJFkf1yzGPnitZ0r?=
 =?us-ascii?Q?v5ii7BxoEAszTpTHMBQzcV60as6sPo75pggY6sA/dVeJ5nCUWymhOWYELjqL?=
 =?us-ascii?Q?OFi4sL+MqQEqBDz9VGtLpof0hhXaASloicX5qp4BlCMFpjF99cIz1Eie283T?=
 =?us-ascii?Q?Z9+CHuhMrOE832KhZgQiA4t2cPGKgPqYESUJPeTJamQJ+CB/RVW+JPl0jkR2?=
 =?us-ascii?Q?HNG6xyFaTR0vdBVXLEBx7CtlJh+KDfJxTtOBeujVcRiMLzsVA6/GSp/fcQVp?=
 =?us-ascii?Q?ja5tjYi8R97afZIPpV15K3f1S6fPIMP8YKOHAko6SONLTVurPOGFLUQXbSRh?=
 =?us-ascii?Q?j6VZedCvYzQeQMbaSt3iQLF0+631HLG5/or50R3u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba2a08f-d654-4f01-b39d-08dd93e0d5f3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 18:46:42.9281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JqhUrcQABGfvoHDz4wmbkvfpsIB/W73LEBTfJx+mVJddpQKUD55o3hqeDRWxdd2u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8858

On 15 May 2025, at 14:41, Lorenzo Stoakes wrote:

> Ah you got to this first :) thanks!
>
> Could you do this with a cover letter though? It's really weird to have=
 2/2
> reply to 1/2, I know sometimes people do that, but it's just odd, and i=
t'd be
> good to have an overview, thanks!
>
> On Thu, May 15, 2025 at 02:23:32PM -0400, Zi Yan wrote:
>> When userfaultfd is not compiled into kernel, userfaultfd() returns -1=
,
>> causing uffd tests in madv_guard fail. Skip the tests instead.
>
> 'madv_guard'? I'd just say the guard_regions.uffd test to fail.

Sure. Will change it.
>
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  tools/testing/selftests/mm/guard-regions.c | 17 +++++++++++++++--
>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/testin=
g/selftests/mm/guard-regions.c
>> index 0cd9d236649d..93af3d3760f9 100644
>> --- a/tools/testing/selftests/mm/guard-regions.c
>> +++ b/tools/testing/selftests/mm/guard-regions.c
>> @@ -1453,8 +1453,21 @@ TEST_F(guard_regions, uffd)
>>
>>  	/* Set up uffd. */
>>  	uffd =3D userfaultfd(0);
>> -	if (uffd =3D=3D -1 && errno =3D=3D EPERM)
>> -		ksft_exit_skip("No userfaultfd permissions, try running as root.\n"=
);
>
> Let's just make this all part of the same switch please!

What do you mean? EPERM is handled in the switch-case below.

>
> And while I originally used ksft_exit_skip(), I think we can just use t=
he
> SKIP(return, ...) form here just fine to keep it consistent.

Right. I am using SKIP below, since when I ran it, ksft_exit_skip()
makes the whole test message inconsistent.

>
>> +	if (uffd =3D=3D -1) {
>> +		switch (errno) {
>> +		case EPERM:
>> +			SKIP(return, "No userfaultfd permissions, try running as root.");
>> +			break;
>> +		case ENOSYS:
>> +			SKIP(return, "userfaultfd is not supported/not enabled.");
>> +			break;
>> +		default:
>> +			ksft_exit_fail_msg("userfaultfd failed with %s\n",
>> +					   strerror(errno));
>> +			break;
>> +		}
>> +	}
>> +
>>  	ASSERT_NE(uffd, -1);
>>
>>  	ASSERT_EQ(ioctl(uffd, UFFDIO_API, &api), 0);
>> --
>> 2.47.2
>>
>
> Thanks!


--
Best Regards,
Yan, Zi

