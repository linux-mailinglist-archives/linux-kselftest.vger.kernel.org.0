Return-Path: <linux-kselftest+bounces-33116-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DD7AB8F64
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 20:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17E891BC0F56
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 18:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F27927FD6E;
	Thu, 15 May 2025 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Td0E4XqW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AAA27A477;
	Thu, 15 May 2025 18:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747335225; cv=fail; b=Zvz8vrn1HzZZEOCDBGnYC7Cq/iZMM275x1zmqAdyeclC8xrws8UE0dohSRXgBwd9LkGNlMTb7l7fUPRB5BSZ51Y7ApBuW+HYzXZWi0Em5yBmQQkg0XWNT3APcoqnPfdFtcgsbxnmUjO37rV/oB51mJgIspfUbmSZHO2v8vKxov4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747335225; c=relaxed/simple;
	bh=1oWZJikm4vqohrGqVXU+/p+hO84u6Wjy8S+QW+vZiIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F7/GQXTJLUI3KgxW12EWEdmezlvMqB10kLxDWIzO0xgImG4bzaORuKyxQY+AkJ7hrA57jo00iJTPcJur8feLPvc4fUaPcjRI+cRDkMPsknebZckWjjOJ5jZjB1cVUJ0YdhcDQJm49sWmZg8VeNr8UwP06Q45QBoTEo7f+n9LeYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Td0E4XqW; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAGRqCI/BPI435pOegaLTsFds9YafWA4WDpd4o7HUzaOn1rvuAxy/2+PnQhcsrqGOcsdW61OGivmSjNNLXbuwB9t9IRm+M+gNIgDFqy4C/lBVN9CKuwgPJb8Dka8Li5vFYWUQhqCoL0ZzDwUAroR0mNKYiYtRdtkkOSHKXV6tndNw506FITJWZ0cqjhS2MubAk6Apt/7EYL/mQttDJtsNiheD4t2n477j8FrW4vG+sry138H0+JbH7HVqJ2EDDzfz2H3hn9to3Rf05GUhzkvp7e5TPJBBoGCPYUXAtr7o7Eiy/8HA3ERgmIMXc21h2sFY0pH7mDyOb5+7whKf272YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKHyUeGjspUktJy9RdGym42gPQbKROSK9DASBhgepnY=;
 b=U/lj37eWbc5oyKG4JCOqiDHARfBuYR1P91EGU2V38SUaMazhICInj/ZoLdOkDOdLKd//oQol3IThR3vnuhclVam1V8gg54ZDtQElHL/e5xHHf15uhunvJF3KeUA5oUBvWJbjjDB7gF7Od3XdC/CInPwKdyUr5DIECaNyBH7tV/+sI5VQeCvC5MTYKXN7GJ+w68PfAlIsqyDkPw+/YNqHxk4id+T5yY1QtqaHCaBMHoD99i+4Nn5JYQUUPmHnEAvHuzgrmsvd+a8+HZHi6Aj1k4eoIGnWcZAKIKAEyPkIb7bFKYOmKInnEu1xxr5ahsX/U9OPPQ5yHtn1Xj9e/lN2pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKHyUeGjspUktJy9RdGym42gPQbKROSK9DASBhgepnY=;
 b=Td0E4XqWaAhxkGk51zFXo/UyerO0zXJ3dmbjKo2iCHGP2aiuAewKoxsNbwe1u5SH5MZx/FKyBs/0HPV6Hk5dkFEhAGYnmJUPsDDW374/+Y7IeVIYFbvATadO54oXKnrVc+svqeXTbtRJ2n5q7RMxfKWiwiEIfj5UHt3V+Pph0qf3op1+fod+eOpVm125OD0ZS0yOQV81MIUSIaNd8mLxlOQcokZD1440U9NkSNdSiLHjkJWdKBImJ87yFHOmQ7EVLZSuTTrOb+Wn983tl976q2w6aAd+OEK7rNsqTD3VTJu13l0iYFkKH/gOjfOI2ffrKp847tY0OwuBZeauV2lb4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB7547.namprd12.prod.outlook.com (2603:10b6:610:147::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.31; Thu, 15 May 2025 18:53:38 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 18:53:38 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Pedro Falcato <pfalcato@suse.de>, Adam Sindelar <adam@wowsignal.io>,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests/mm: skip uffd tests in madv_guard if uffd
 is not present.
Date: Thu, 15 May 2025 14:53:36 -0400
X-Mailer: MailMate (2.0r6255)
Message-ID: <05A8161C-ABF0-49D4-BEA0-8746C78570D6@nvidia.com>
In-Reply-To: <21c39cf1-6c8f-44a3-8bea-b0c8e6eac2c1@lucifer.local>
References: <20250515182333.346587-1-ziy@nvidia.com>
 <ec648245-c771-4e4a-b355-a86c99ad8143@lucifer.local>
 <6601AD88-C2B7-47DA-B75C-46AFEE1BD2AC@nvidia.com>
 <21c39cf1-6c8f-44a3-8bea-b0c8e6eac2c1@lucifer.local>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BLAPR03CA0046.namprd03.prod.outlook.com
 (2603:10b6:208:32d::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB7547:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b7d5e34-be96-4d4b-da14-08dd93e1cd86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0YPLnpNrmpsE+E9693LhUypapOBurMJ/RHkTj3y/L5GWZT8l8mi/Erl1PL40?=
 =?us-ascii?Q?z34X4Im9cXWZhHqtU394Cf9sSUeuywUAQZn1wWdJZjI4RhUTrgrwpJDGczYf?=
 =?us-ascii?Q?ME2PZl1DUIiXMQ8MfYXcImOXBGk8n+ytlsFstMuoBDjPdmUeS/Bj20e8ptYj?=
 =?us-ascii?Q?2jn+0mTC4y0bgSZ4rY4/YxlWuInjHxX9Xq84TkAOX4HnzVTrRQ3RMezhOWCc?=
 =?us-ascii?Q?a4xWMpjbR6dVPgSyq7Bp6JYExSVVyi+/YYvtrGFhwpeiEjwGNg1+ffmkotTT?=
 =?us-ascii?Q?YB1O+t7abQR7rNtdXxiiA1xaHeHnTutS247npuaXWbodXoKnkHJrJr+odMXj?=
 =?us-ascii?Q?eDoXjy74U/oXOuQ8mPpVYRTxIbN4coaAov70dtkn/g32zFkRKFwe4yKGbtVp?=
 =?us-ascii?Q?SzGS+cJTrgwYk+Nv8XQ6vZOH5OyStH+Qz8eY9r/DMJdUZq5NLQZsExtIB1RR?=
 =?us-ascii?Q?N5AUxEoj+HWL5kQAhzfp3bjAhptK4XSGZHIal2hxAlbTnAe1fQAJ3/wklXNX?=
 =?us-ascii?Q?GZiWGkR34y3K/vlXT7yN/G71D8RNXXzPweAALb87TTBx7DV8jWj8b17urRUG?=
 =?us-ascii?Q?zYE+OyJHIh8cIl28YzG791jjQ8GaHGhzXq2mq7rLJm5KH+WMr9osAQIBhyX2?=
 =?us-ascii?Q?x3tzNsgNm6aV2PjtfPQiWKpKJJiU+rKbTaHMF3u5fQJYdaBH02FhwMcWOwLC?=
 =?us-ascii?Q?WfrvyItfQ6iWpyUckIiJ/eJbZR15wbAzlQoOnbRecrCmqYYs4gHXbsQxKwdq?=
 =?us-ascii?Q?lDbk1wUg+ZdwEQVo3UoPy9KFTDSUvCae5LysIRQUFzPMaVqSRK75/vgrWGXj?=
 =?us-ascii?Q?4JBNG5/zatKxfjpd1zCDYU6/wYySOPqJdi9EtaUnXRXtbW8FOSIrsY1uHCLz?=
 =?us-ascii?Q?Be6RdPyzkMICePRiEnod56Mt+LNZ4LPF0MGE4bD5wRbxFxF0lxrxlh9etwox?=
 =?us-ascii?Q?FS/sc1NJZxU1/UD0QOFaeXK8Xr31l/n2Y4ObbFogfDOGk+74fdIPIlX7hMyF?=
 =?us-ascii?Q?CxFCCnlXDVQ4/thWt+S7Bu/zS4dXn+bFjcZgS/+lKgOtywBxAq8ENA/idEKX?=
 =?us-ascii?Q?RhecaujoJ+ZB76TxKcTmlb+jNKrfZincYhm8fG1a+WRzOTTBWGKKiSLhCuXv?=
 =?us-ascii?Q?Nk+Wq2OsK6aMXARMN7joI3AheMB0XSr8/lz2HqZR+nUO1DHQmSy63WNbQgZZ?=
 =?us-ascii?Q?6AdueTnc76mGpBInl/BRmuA4+LNZgXHtA4D3CxN+YVc2Pnimaz1y67aJOUBx?=
 =?us-ascii?Q?d6qn8Zd84nFoyj0Zw7rLkeQPxg4fPumy9KnM+KsV1PuHIR4cCRc+iUnLEqy3?=
 =?us-ascii?Q?IdZcWhaRbYqTwbwMabLjmXldSj7NcnvpNRYL64uoiqQohH5APqgTHdV6yNfF?=
 =?us-ascii?Q?Dlq/41ZItQTdHVBXhhFE7TpzzCO3fBxvQUEAeu8qVtggcY8wmkeNipJbmYCS?=
 =?us-ascii?Q?+cW+l2qtoUQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J/9AN5536aj8XgXQtfUHpCZVfg6dnyKD6Z0T7ToRr6lsDBci80RH5BttDyE2?=
 =?us-ascii?Q?ZjUWptIXoI56NVn6oP9X4Ss1H3NON4V+hnUstOLa8PLjR6jd8JtHm/pFMtwJ?=
 =?us-ascii?Q?PijdzdoF3Y/7aPPQZOIwLFWefrbZ/YmoCyi6KMpHe87sLG2bflsGPBcs+woB?=
 =?us-ascii?Q?J2z0d9n1SuYBf7lLuAx4XD6XGpS9xpcCnUiYBb9j3SxBcM5dNTD9nGpis6Qy?=
 =?us-ascii?Q?DohS3G1NdQd1uab6lIy2ZVUcKyZywWh12xzeYjdUS6Druv2V2Y0zBAu8Z1xi?=
 =?us-ascii?Q?YngbhOnBQDBNeXQyfto6pXVquF7S6VS6yAaE/WJlZwI+LeZtPFMaT3x9ecaE?=
 =?us-ascii?Q?Yk1OWzn6D//L1P68AmdYvKuuxgeTgsQuLbIDl0VmBqAM0PtEq6j5rSUb0+98?=
 =?us-ascii?Q?QHYaYGEoWxkp6i7I3oY2ylQuY7E2f95erx76xarAxIO7d0PABk8R0rarbgmr?=
 =?us-ascii?Q?/llhBv0q1nt/dtxDRMHsPklbIB5/EC6oqfK6p5Z3RqY3LduLwKj40nCYpA9v?=
 =?us-ascii?Q?l3w+Suj1V3AhRRJ53MXl4HgCPaCuEbp/s9pV5Tom7vgPATM9EfYMMChHmwgv?=
 =?us-ascii?Q?6E1izERxR8LUGuo4kqRkf49H6PjQxawtVHLkqWmDgr2unO+CH2xQTyTUzttz?=
 =?us-ascii?Q?3C60ibLthjwii/qoBkw1WFSpQvAzbruajzFD4Gt2mU11QzGOQgps4EVgL3Nn?=
 =?us-ascii?Q?nmroNZfs1RJHZkhQzh0TZaSSwwIjriEYM3wj65JjNPWVOvz+Ir8J+iCypGsO?=
 =?us-ascii?Q?Mvf09mPYcSY4GMF5JpWsKVZt6omZmm9rdB+53ED58yeqGyiJ+CILHuXMqZpl?=
 =?us-ascii?Q?0TRQb+/mJ08n1tAb+8ReLhDi/D1jN+gxP6rR+keK5lQuGY0G4sgAXVKpC/7x?=
 =?us-ascii?Q?DdwyjAjimQCQyYCWjLnaT+WNr1RBe8VLJ7kI2KIt5mXIekwTRnva72NB3wC6?=
 =?us-ascii?Q?LHU3GT7okiv2KaPtia7oZJsM3Wa9MiDtdjwQ0mwyyf+AMqSX91PnfEVYH/8A?=
 =?us-ascii?Q?I7PZkLzzK7XvSYnmlaoWdW0/WsCbQFmE5Scp40P04HUdPLmq3P1eNxuTWXrg?=
 =?us-ascii?Q?gOb7ypFd9EGHXPyB1f8wnbrUHRa8ZgcECNlt0gcH0e6kU9nNtdPTTWeeqvj1?=
 =?us-ascii?Q?XZfa/nhfFH6+QE7avmtEMxpVRvI+CehG9V51vVpka1LDxzn5EnU5DnsM3zmL?=
 =?us-ascii?Q?HEYgyBhX8kjWyugAT+BIktu57QeRmnxkoIfSKT8NLWFBydGaxf9MLDyRH1xL?=
 =?us-ascii?Q?csXXNadxh2/DTMmdnCTbwxYIVkwaOMv/PicRpjiZq4PYE6qtJry6kHRoQiHV?=
 =?us-ascii?Q?AmS0FgQJlxG5AlVtNZ/TBfXTYvQlZXoP2VI34Tt7hRE+QGg2NuxVBKOu7RWo?=
 =?us-ascii?Q?qb3PYb2epJe3U/cfR5HuSR57m+lsZknxvgKwiBlqSDrwxFp75KpGdWz9hFcc?=
 =?us-ascii?Q?jb+0nVBy/0Kx3qe5AJZWAlZ1ODn7ZUP0xj4nxrcr7GzoHTg8Tz4orixtmJJi?=
 =?us-ascii?Q?lsvJIJ2nm7fLyhutAGHSnOnPIwAoWl2f6mcBvCw4IjejaSYLTc017lC16ns+?=
 =?us-ascii?Q?tyJco2AoPolqAZ9nlluipaWLexu6nstN0mopKpkJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7d5e34-be96-4d4b-da14-08dd93e1cd86
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 18:53:38.2666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7nLBulYnkyIFgtQHDnm/Qb1pQxGQk6MXfakWDMP897VwUx6MpM3xQowQJLFNRGdB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7547

On 15 May 2025, at 14:49, Lorenzo Stoakes wrote:

> On Thu, May 15, 2025 at 02:46:41PM -0400, Zi Yan wrote:
>> On 15 May 2025, at 14:41, Lorenzo Stoakes wrote:
>>
>>> Ah you got to this first :) thanks!
>>>
>>> Could you do this with a cover letter though? It's really weird to ha=
ve 2/2
>>> reply to 1/2, I know sometimes people do that, but it's just odd, and=
 it'd be
>>> good to have an overview, thanks!
>>>
>>> On Thu, May 15, 2025 at 02:23:32PM -0400, Zi Yan wrote:
>>>> When userfaultfd is not compiled into kernel, userfaultfd() returns =
-1,
>>>> causing uffd tests in madv_guard fail. Skip the tests instead.
>>>
>>> 'madv_guard'? I'd just say the guard_regions.uffd test to fail.
>>
>> Sure. Will change it.
>>>
>>>>
>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>
> Given I was being an idiot below, now the patch is fine as-is, just res=
end
> with the nitty commit message change and cover letter as a v2 and we sh=
ould
> be good :)

Sure. I am also waiting for Adam's feedback on patch2 and will resend lat=
er.

>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
>>>> ---
>>>>  tools/testing/selftests/mm/guard-regions.c | 17 +++++++++++++++--
>>>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/test=
ing/selftests/mm/guard-regions.c
>>>> index 0cd9d236649d..93af3d3760f9 100644
>>>> --- a/tools/testing/selftests/mm/guard-regions.c
>>>> +++ b/tools/testing/selftests/mm/guard-regions.c
>>>> @@ -1453,8 +1453,21 @@ TEST_F(guard_regions, uffd)
>>>>
>>>>  	/* Set up uffd. */
>>>>  	uffd =3D userfaultfd(0);
>>>> -	if (uffd =3D=3D -1 && errno =3D=3D EPERM)
>>>> -		ksft_exit_skip("No userfaultfd permissions, try running as root.\=
n");
>>>
>>> Let's just make this all part of the same switch please!
>>
>> What do you mean? EPERM is handled in the switch-case below.
>
> Oh man, I'm the biggest idiot on Earth haha!
>
> For some reason I read these '-'s as '+'s :))))
>
> Yes please ignore the above, I therefore - like your approach - and am =
good
> with it.
>

Yeah, I kinda figured when I read your message, but wanted to double chec=
k
with you.

>>
>>>
>>> And while I originally used ksft_exit_skip(), I think we can just use=
 the
>>> SKIP(return, ...) form here just fine to keep it consistent.
>>
>> Right. I am using SKIP below, since when I ran it, ksft_exit_skip()
>> makes the whole test message inconsistent.
>
> Yes, your confusion is warranted, I apparently can't read... :>) and
> indeed, agreed.
>
> Thanks for doing this!
>

Thank you for the review. :)

>>
>>>
>>>> +	if (uffd =3D=3D -1) {
>>>> +		switch (errno) {
>>>> +		case EPERM:
>>>> +			SKIP(return, "No userfaultfd permissions, try running as root.")=
;
>>>> +			break;
>>>> +		case ENOSYS:
>>>> +			SKIP(return, "userfaultfd is not supported/not enabled.");
>>>> +			break;
>>>> +		default:
>>>> +			ksft_exit_fail_msg("userfaultfd failed with %s\n",
>>>> +					   strerror(errno));
>>>> +			break;
>>>> +		}
>>>> +	}
>>>> +
>>>>  	ASSERT_NE(uffd, -1);
>>>>
>>>>  	ASSERT_EQ(ioctl(uffd, UFFDIO_API, &api), 0);
>>>> --
>>>> 2.47.2
>>>>
>>>
>>> Thanks!
>>
>>
>> --
>> Best Regards,
>> Yan, Zi


--
Best Regards,
Yan, Zi

