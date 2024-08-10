Return-Path: <linux-kselftest+bounces-15118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8916194DEA4
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 23:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0452D1F216C6
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 21:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC83E13D243;
	Sat, 10 Aug 2024 21:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TEZbfHWB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22653AC36;
	Sat, 10 Aug 2024 21:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723323942; cv=fail; b=E+m99lbZw5/mbS2yTtMmQlQoShB6JpjO69AhAo8nM6PKnVRWSJv+ncYYKPbyUQikaMSE9k7wURrSlNb+ClXexI8UQsJzJp7QJ/jf/RQGIfneR+gq/+C+ELtX0r0QBXDXoj96lotEWTQzSqeFNW4j5ZrJEoXITv/FDYl4/Boc9S0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723323942; c=relaxed/simple;
	bh=uVK31Tpn+2/8m1C/Z7/XzwFH9ROY5/E+5yR1POsKJTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tcswAIJ9bUik8ojCnMH5pmbBgJrHv5C9i9CHfz/eGTU3DheQz4SKoHfn0Fb1ba67srIbIJRoceaHm/O7N7CmNCnLwXByJLHzeHKoe7HvmjNMZS19a9qbu/LM0WXz/92tiiwYuVmYijXzET/r1g6q4g8n+0gArISbCqtOecpEH+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TEZbfHWB; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jWt2uFO68kCuAyp07dJ6/BQ96eMNkGy/GnqHWKuV6XCD0G9+yBxtAVfdVsnPhB0UpKBfg3+c4CB95ep33N+4M95Yv32k188kRiWQFazOBimX3sYpyDpw6wcUGwyC5V4WB1N/4ZpgBrhcSV5U4/uuZKUPgKz/caexKTbLZGvRfGWhjh9D3RAIeQKMK1Qm2o0Oofc7WtiqVGDQmc3dLORvuWHWzpsX9+xb/VJzDFxJo/ecq23P4+9FpWHrG1/bxmBmuvklJrDVbWvIp/VaRRjJpGr+RuZH0hOmI6jDqCu8r/xBrSv94Yg5pDFmH5gOOByJdYCyftoQd/raYFAIAQwKxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8LzUzg2DvUYErN11v80jm1vDjlRQj4dqDiTQaEJkjg=;
 b=F3tnDGXrl+tUzKuE9DeJ1fyA+JWCvSLZVOecTj+R4OZWOKFMmBGkBXula10OZc46IP/CwIxxgeF5Ol4h567ObRAzelws9dcKUUdhadX/CBYvgQw4qgEZ8XOULaHvIcdyO6QVQsGKSJNR1AgVC5PXUg+3LvQgD82i3Z2t2Nw7PjaIqXfW0BzfVsQNjA5gYHme1rQ0BgZgK0J/N9YiKcqn0YmDrQj36emHbzE0P6Aux6789+5XAcXkYqtcoP9JRfr4vuAvCDFVDxR/ULWdBlAOgDeYzuF8dqWUgMG2LdB0GRfNB784S2EiYid/wJ2qIvBfOQ+pmfuJm+xuE5g/BytGMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8LzUzg2DvUYErN11v80jm1vDjlRQj4dqDiTQaEJkjg=;
 b=TEZbfHWB59PbHzrg/5+49CXnMM8rphUOmem/lp3qRYghnrM1XH4P3WCNV+Z87IlNBeQqpYyYAromiUpJ+SH0larXH1foGyj8VoJ+h1HpxvvWVdgb5a+dBZV1wkps3VVrOKvSyENhDA/xPteVa3ts+VygButWNt9oR2IbdLcSTr1Zk6rybyFerMyI48IcWSywjTeyU7pfFQaolrjPfmUArrUsS3rnD5EUGnrPmF6bfUoQ8NxyFIe7UradeXAJXHDBF4YAOsDDgArZNs/cTxta4ZIsVxlLe3v8DeV9XX3S4z/m1wu84IFZK58LyDrx1o0eQqs7iRmUs5n1MH7P5cA/oA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.17; Sat, 10 Aug
 2024 21:05:37 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%3]) with mapi id 15.20.7849.018; Sat, 10 Aug 2024
 21:05:37 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, shuah@kernel.org,
 willy@infradead.org, ryan.roberts@arm.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com,
 apopple@nvidia.com, osalvador@suse.de, baolin.wang@linux.alibaba.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 ioworker0@gmail.com, gshan@redhat.com, mark.rutland@arm.com,
 kirill.shutemov@linux.intel.com, hughd@google.com, aneesh.kumar@kernel.org,
 yang@os.amperecomputing.com, peterx@redhat.com, broonie@kernel.org,
 mgorman@techsingularity.net, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH 1/2] mm: Retry migration earlier upon refcount mismatch
Date: Sat, 10 Aug 2024 17:05:33 -0400
X-Mailer: MailMate (1.14r6052)
Message-ID: <148A7C69-F204-47EE-8F2E-E963E6D9CCCE@nvidia.com>
In-Reply-To: <761ba58e-9d6f-4a14-a513-dcc098c2aa94@redhat.com>
References: <20240809103129.365029-1-dev.jain@arm.com>
 <20240809103129.365029-2-dev.jain@arm.com>
 <761ba58e-9d6f-4a14-a513-dcc098c2aa94@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_2C05B843-5503-44FA-9F02-56D664616CA1_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BN0PR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:408:141::35) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|MN0PR12MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: a3d46da2-ac72-4b90-f366-08dcb9802ef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HwwnNBtriF+hCd21eXa3JYpWJW0th9XbgSaPrSQes4NdCxC+SlCVfa4p/vgc?=
 =?us-ascii?Q?kzTgDhUyyF4o2S/yQ87H9vXF0MbQPkb6pKkXJ8ScA0dVc83JsFGAg4Jfro9+?=
 =?us-ascii?Q?5kvbEL5dWuSiBdFary2cU9rwiWq3wIx6CbzY13D16ZytCSDvglMoWPmDnywi?=
 =?us-ascii?Q?FeY/ImGdXAu1m/ADtCx4xjM8AMY01jjltcOSaE5G8CXETRYOXB1dxi+9+tnS?=
 =?us-ascii?Q?WQl2NOxSGEma1+Dw5mxiUqdjYBWv7ayStqOb/83wh2ksyJ17u9kdGwjM44QE?=
 =?us-ascii?Q?p7rNyjVKEHkaIxK7F7bUqGktHVM5XzXEJu6cuJf265JQ0bnSUfgcKY3oqow8?=
 =?us-ascii?Q?fpRjI2jIn6cA7YoNBzAqlKVCkFNFG9K2iGfKo7SOrgwwjLiZ4g0OXhe2aCFx?=
 =?us-ascii?Q?XSHIUaIOXAGCeMijHtqUOScJBbJoGd/WDgbiyJ9W6r7ZSHA5RvueWRp1oLR9?=
 =?us-ascii?Q?kXmUeW7iLnVYVf5mRFVSX8mhEPP/fqlryN1QwkVXF0tIRrqC34ehqw7w3zY5?=
 =?us-ascii?Q?J4emikLHgAM38UG0Ee/84dVeEXXY7HbPGl9yR3aEAbyyXDRTxaTuaYe8Lupv?=
 =?us-ascii?Q?r/GXn+LTMn5pGoraTt8QNBIWqLKVTHwfZYpdZw8Ei2Rj7bmDucvADBY77yUL?=
 =?us-ascii?Q?/gduEm+IFWqUEEIYiOKd7Nho22B/ma6nvDwtk1fZpnKV+aJYIKdJTLtZlmD3?=
 =?us-ascii?Q?HHNBWwxk50A7+GeQXNevwDSRKLJwBAJyPh9nRcu3CEKh6ykvdzfya2suHncP?=
 =?us-ascii?Q?ui8kOqjfQRtJmipOC8nU3WpCleS5uhlrLrOhRw4dUwQJggYw2RQunWnPswti?=
 =?us-ascii?Q?z1A4Rw+jzcycEP2d4FbVqDhrlxc3FpSycTcs8DGkHl5BZXxVmCTKGezchTRy?=
 =?us-ascii?Q?0rJb2PIfCIwjHagCcIy1g1tqx7goCKkCTDK9gzUhopRcqixt1FL9kCpeWJP0?=
 =?us-ascii?Q?cl0I2+TyF+KDrj6MmnUine43+0Wzdz9FCCduhWtldLOYi1C3bgm9mfD/H+V9?=
 =?us-ascii?Q?jox2NXExZkKNO0x8bmwTMc9hJAwwl9/LqTrzV9MVPhzwYXu7brMCVU7HXFvG?=
 =?us-ascii?Q?oMgQ2GfwMPvRSIULG8iN8ad1xVbN0UrKyn/gTI4VvlxPijiJrDMBDj2D33Fk?=
 =?us-ascii?Q?P9n40a0qFjtMvB59P/ne8FIdOrKrkI6YEXamGryzmPsEzaQeLRjfXP04Oziv?=
 =?us-ascii?Q?c30AHvtw1aaMLmRbLx75U9j/ofvML5mOj+nAM3uTQU0E7u+o7nZ+IdrHqLoq?=
 =?us-ascii?Q?3YSwFLWTi3akCIXeP4g+riUX0VI12NlQp16Lxuia+N7IBDPKLDrkk1lJXtpG?=
 =?us-ascii?Q?PW2Q8tDBpzh1enJq327luSgYv4Cfk9I1RfU0In9pYlUPYg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZqgPEQ/9sqJELZOJfcxXo98Q+pQOsZitY5dIVMsIdtvQyaeKJWepFfn2dwBy?=
 =?us-ascii?Q?6lfDNx58LFpF+Qw1rHc8dIYRfJHwRAvNHWXdQT7t7TSpkMAb6MSFzBcWiORk?=
 =?us-ascii?Q?2hg7hrcZE/qdzJ0ZSq6wCj9cOE5AJOHzUNEc2D09zP1RpASU5pX/ViLw5bZV?=
 =?us-ascii?Q?EP/mjPR86J8mhOgJsm5YqduR1zmzqB57OyVDi39ZwpbY4oRPkpBwX5XF1rGI?=
 =?us-ascii?Q?QVuw8aHBSyzaodV1N+NoX3SyccCBil52gWQJb+7HEKl/8Bp3s6eap9VuQuXb?=
 =?us-ascii?Q?eK/S15uWA56sdXQ4b+lVFD/N5pZ2ZlU5IFdABxe5JU6dJy5S5YJGClBWcPOf?=
 =?us-ascii?Q?MDSfQaNZk5ALBNZQ1JMz6vwYIWEelskBXKYCK5lvlOxFNPmQecfvYhdhE0Cb?=
 =?us-ascii?Q?2xJsJAl8Suzpy8TahNdgpacdZAT5l9umoD934Ilc8yrvEOOBBLNsbufwEoT1?=
 =?us-ascii?Q?l+zLM+zDrVzlslwqXi4qMFuSP3QqCM+2BsginEVO1CHP+g2eSxc6Vm0LjDfy?=
 =?us-ascii?Q?jkpDZC1DXuXKQgpAhwBvkEkAffD4nwUfYmfyKcJASXqcXlG8Dw2IXyyQVTcR?=
 =?us-ascii?Q?P4ImS5eZ48zZKf0B7132w2KWCDT2yKvd1CVegbxkepwYdCIHOrhH9SfdAX7V?=
 =?us-ascii?Q?a24pLXE9VNEaf5FVy9WAcJP2Kat4OqMeH9rhNvZSvhbLIsuElN+HmhT9royN?=
 =?us-ascii?Q?wcC379UbUkI8id2Hl9gtu/YAC1BUzhKzOrHNRUfz5CuP/vVhu9/JoUqxn5E7?=
 =?us-ascii?Q?MHFNPygikZ4eNZTjMjtdA95P3uuUOKBBcYuWt4Elpc3Y1ohpVeD4SvpMjQVJ?=
 =?us-ascii?Q?bWLi7+gcVrFOAaR6hiFImuqA3dOEY+1DMgVUGYsAYAHkfLQxVgMW7mX7tRxz?=
 =?us-ascii?Q?GibBFsRY/uBJO2fAqfs5CqnK8DbRlyrqK//+qWg3A80vy3sT0X231+DA/P0y?=
 =?us-ascii?Q?YuiGXB58wcOnMOXFPd9oER4cN8h3XfpoeyETrtTAu/hM8hN9oAngsuz4bdzc?=
 =?us-ascii?Q?LbYjnYEPKOLFxolKS1IFYpHx+25QO1+FgdGWGZMM4zYWqc5GxpGwdWS9xFEZ?=
 =?us-ascii?Q?k4Dbx4erlLa5DwpiEqrXpwz+ZCdj1A+UHNekTondtHKkR8DrSUZA35A0t4Y2?=
 =?us-ascii?Q?X+MRlYalZRrNRLpO7tE1a/51OtcSuinbRnYvX8+WeL2WhAWnJPND/TbBDbhM?=
 =?us-ascii?Q?uVonYTTWN8KGiJg3jZZcLBEFNSL/IKPEt0u5oW6bsN2XlGYaHQ5MYpOUrMlQ?=
 =?us-ascii?Q?M7duHoKU/mN8JYdjr10Zf8DmK3UH5QfJ+aIvm3+9ENeIlCUQ9mgzjulVSP4H?=
 =?us-ascii?Q?Ldd+uIamud1gV8jKaMlzt9JM4J5fg8RhKSxbImI3v1g9xKmPJpkKiujdQEDd?=
 =?us-ascii?Q?6OfP6iNy0FyMKatAFgs+fwnocxLwGjQaCWCtEDO+e2MU34v/Ik/lwzWUk87F?=
 =?us-ascii?Q?/93vFBbJhv2jryZ5b9Shcputx1ekIFWUMxEdu3kPhooVdtdvEJmgZf2TyI5M?=
 =?us-ascii?Q?y2P35dUIS4I//X8gZb8KBkDud6Z9ppzuy+a+Sd43yVFiB26KAxtgPkH0UFsG?=
 =?us-ascii?Q?oiKP/fWQ8KRqcfIsSUo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d46da2-ac72-4b90-f366-08dcb9802ef3
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 21:05:37.5797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tUMz1O3saR3szjP6Sps9YWQ47eND/1p2r1/9meIoEHP1gfrgd63V1DBVX7cMUxLk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764

--=_MailMate_2C05B843-5503-44FA-9F02-56D664616CA1_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 9 Aug 2024, at 9:47, David Hildenbrand wrote:

> On 09.08.24 12:31, Dev Jain wrote:
>> As already being done in __migrate_folio(), wherein we backoff if the
>> folio refcount is wrong, make this check during the unmapping phase, u=
pon
>> the failure of which, the original state of the PTEs will be restored =
and
>> the folio lock will be dropped via migrate_folio_undo_src(), any racin=
g
>> thread will make progress and migration will be retried.
>>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>>   mm/migrate.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index e7296c0fb5d5..477acf996951 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1250,6 +1250,15 @@ static int migrate_folio_unmap(new_folio_t get_=
new_folio,
>>   	}
>>    	if (!folio_mapped(src)) {
>> +		/*
>> +		 * Someone may have changed the refcount and maybe sleeping
>> +		 * on the folio lock. In case of refcount mismatch, bail out,
>> +		 * let the system make progress and retry.
>> +		 */
>> +		struct address_space *mapping =3D folio_mapping(src);
>> +
>> +		if (folio_ref_count(src) !=3D folio_expected_refs(mapping, src))
>> +			goto out;
>
> This really seems to be the latest point where we can "easily" back off=
 and unlock the source folio -- in this function :)
>
> I wonder if we should be smarter in the migrate_pages_batch() loop when=
 we start the actual migrations via migrate_folio_move(): if we detect th=
at a folio has unexpected references *and* it has waiters (PG_waiters), b=
ack off then and retry the folio later. If it only has unexpected referen=
ces, just keep retrying: no waiters -> nobody is waiting for the lock to =
make progress.
>
> For example, when migrate_folio_move() fails with -EAGAIN, check if the=
re are waiters (PG_waiter?) and undo+unlock to try again later.
>
> But I'm not really a migration expert, so only my 2 cents :)

Sounds reasonable to me. Also add Ying (the author of batch page migratio=
n).

--
Best Regards,
Yan, Zi

--=_MailMate_2C05B843-5503-44FA-9F02-56D664616CA1_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAma31h4PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUUoMP/0eSbxgNB6BlaHRPwVre0ey0G7X9q2dpr8yN
j4oiudiwcP14krla+kPnvzTGtxKMQO4gnBmBAqCSBLrvZXuX2t07U7U9WTlUmhwm
KvgK3FewZ7pLV3Bj7AFAOEPDURSbc3DGR4fz96feAhKV2+QUxbTpuWUeIQe5uiVB
gwsRdo8qpgB/xHqTQ+reU/wgwDqUwV9owgKUBiw25rX9JzPX15SVbwKpAC8UoqbN
6RCCBxRPww8ZwPymhoF/KLh5KWeSEG2txx64w0CZQF1Q5yFnVdFvh3KqUwU18aZQ
xJ4+v9NxOh/QqPDL/2+6Mn3NwbRHqEc09mq6693/MCWqC0E3uvfTVobIDkIzvPhY
bNSmn8V+YdA2PUh2GDQ/sdICbpZFP+17zxGvtVz+Ffa45LdYI3q6ROhcy3SXSqXp
aIs6dvFFs9XCU+POz7ZskF8Gh9QCXBULPBNicFTVkTxnjA8xACyPRsDAieqF82VV
vsalMTd6BvMznfDKya+4SI6QxWculNg0zusWKsBlNhmhze0HtrrTZDflWE1aIWxq
d2r4/beYT/lmaDGBnqxOCnuf4LarQUk0hZ13td2DQJDLGcAB3q0sue1128ZNkeGE
hamZUHQLNeUiDfIrc4Opj+YVxQXHgnGyAK0JECCvodDvgyAZunRui87pQa3Uz8sI
WsT0NGgs
=EbOb
-----END PGP SIGNATURE-----

--=_MailMate_2C05B843-5503-44FA-9F02-56D664616CA1_=--

