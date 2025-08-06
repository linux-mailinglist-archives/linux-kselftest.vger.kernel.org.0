Return-Path: <linux-kselftest+bounces-38377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2DBB1C79B
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 16:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E8003B32C9
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 14:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CF828C5BF;
	Wed,  6 Aug 2025 14:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FbKfDW/9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFDEC8EB;
	Wed,  6 Aug 2025 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754490573; cv=fail; b=gZIexBudmAUvboTGV4bRAwWB0FB0g3O3Fn8XUyK9VYAmTXb+zZ0OujDc3zHgmR873CI/72fZI5QYLlmcPZltsmbRyPRv1loSrsqfL2D4d1D45a1WM+arhv9qMLoQichq7+OkXqLFykYqZLZDpfHfI4gdbjhyk9/2nGtQ+O4W07M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754490573; c=relaxed/simple;
	bh=enXazQoPKDr5lGmLFMgqPHRJae+BFjd6W3KcWvJVAfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ilZZ3xaU9ZainIWLCw4A0m+z/TTm0370Zg7dWxuMe2wOZKJVBCLnf+fgP8BHHTmLHyjQdPKLd1CK+0mw3OZ0pvmdZK7yUjmXdRX7LaX941CYx8oBOUBTwaIlbmHx4SSXYrtY0sBS9E+Nf/4vc3e9Pvqv1iORVIXl94S7773dMY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FbKfDW/9; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqqCLNyRJoJ+57C6QrtyJo1jUA8e0sZ8Z9VEzd6I/HJGsm5mJyLU1D/XcHj7Pf9x+g7GtZHknh8aiQfb2hU2WlI6rsxZHFrHi6Bhjhx1qsneHqNPXw5tFcLBAzZRiN3vmy79m5Iyv6qaEWmvG+Yo4VAekgLUWNPrFPID13UaWwoWf/62grcC+n662OUI9xYIqSJbenplfN4Eycm8dX7JHBKKSg4o1Rv47VeRBeUDNjhqZvqgApcmMdL7tlVSxeqOHAxeDzWJRXkukfO0ebK3g0j5PsN6ALytLmnjz4u8IHgpcWTYFnYnAZzaDkqWD6rVPH4IAq9gv4xEjGOmMr+5gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5nokKLSKvQaO+OVEv5lwLReUQo18ediOrfd4kcViq8=;
 b=HjkmPnQTHXYwFKG+clpE+CeAxGHAvQLZd9BkMfHCskk4yqrVY9WjW1G0AgCu9lycM0C5gaJLDLt6ukzvGSvIq4FFdQmgB9eetOn4aOA/01efSnSDwNI4QZVElBALZHY++wB/GI4dtdHODUzl4AZaEn/dHKwEeJDMHiGsdm8fWhjkDUT5bMBD0qd1LEODrp/oDB8VzIiOdYBQttKj1ddxE5dWrrLgdVzDVkLRl0DOvl4kZOHwQ6OgQyyvkHVba0cph+Rf/WYbcMezL9bhM0opZ5YzxEnCpbtu/yfesw68JsCbn+jTVRrcXrnH1bPIVaNMZrv7wDdbkMk+bv8TNv8y4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5nokKLSKvQaO+OVEv5lwLReUQo18ediOrfd4kcViq8=;
 b=FbKfDW/95ZVMsJcR+FumzRcUI1lOJRvnwfi/DZLDU9HWvxeptpAGbq2r6fdLYfQUUT9XWA4LY5loIIZHUPY+Sj/pbbonG8gysZyRlazVkFt4TQ9IOxPm83DTzPCQsyQVLebRdO6ewN3C78lELvNctB5jjyl9aMU4jUa6ORswA5KN+fpQVHjqKHGmF37/UEg03G2NdepbNsRm+h7dHRRxHZw1rHTXWvFIVmwufWrt6T6L9gUXwB1FnI4sRJHGJQb/mWSB4PTU1kLGL3WTEB98Lv0g+ML/0gLT9jJIgfZYnkwGpg273JWlnBE1g0G2SQO61JOVpIUwg+daH59o+CK2yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH8PR12MB7304.namprd12.prod.outlook.com (2603:10b6:510:217::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Wed, 6 Aug
 2025 14:29:28 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 14:29:27 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/4] mm/huge_memory: move to next folio after
 folio_split() succeeds.
Date: Wed, 06 Aug 2025 10:29:25 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <87B76D39-9673-4C3C-9B0E-375A677205C4@nvidia.com>
In-Reply-To: <60b6c458-e3d0-4123-9815-44e8e8ae0e60@redhat.com>
References: <20250806022045.342824-1-ziy@nvidia.com>
 <20250806022045.342824-3-ziy@nvidia.com>
 <60b6c458-e3d0-4123-9815-44e8e8ae0e60@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL6PEPF00013DFC.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH8PR12MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: 86de2f6f-a0db-4a96-043e-08ddd4f5a625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ANKLMo6DRiP0VY8wpiq6hYSTDXYrxNtNguKlnnx67gg2bUIl/JVQlR9+XFk2?=
 =?us-ascii?Q?exxiPqdF9Cio0ahKVMITPUYj/ahrijckPrOMPx+12Ba3hzdV3GGVdPuVI+fA?=
 =?us-ascii?Q?5F/yrOslChTb3/WR5rpWGA34aU1uEIMstXfA+WYq1CRUv78EQzg0a1D50DJn?=
 =?us-ascii?Q?TOrAyz7vzrpw42cKk5LrjHBkRYYnX28RnCS+c0GKYwvlusbAi6RDajDxv8ks?=
 =?us-ascii?Q?ObIrLHdjQZeNIgb1XqOQAaNxvDuToZNQw5pw9M2lfl2W2fs9eF+5/TdiMG40?=
 =?us-ascii?Q?OA3equEy+cZgNND1sKKT5qqc9VaRWCVftsvGdUFJ/CDv9lDSkJGOEhV8p2q2?=
 =?us-ascii?Q?KiUDrlqDw+RrWF8UUXeGPG+JwpIFEKqu3ynWlfQ/n7hfI1EPLDn8LmIEhGQi?=
 =?us-ascii?Q?sxGbtWrkJGiMrQc0hd45mDQNoOSw0OJCoAa++EUClxzz79FI3ZvXrhzdhnzi?=
 =?us-ascii?Q?fdML453F/6XY/W5yFszYRFfcurJr3inX1bPcvYln0B/s+DtsaLzuZKFTn5D5?=
 =?us-ascii?Q?Wh44ImRKFSoEWL3G+7G1yrKkq6kuai65s8fnd0yBItX5auxi2zFGSYJxmaul?=
 =?us-ascii?Q?Z0cXZjjZ3oMBH8GqAf+p/cqrUqrliCUyNRwrj6lYDBbDAHlpl27otF/DledN?=
 =?us-ascii?Q?Ilkvv0DoPb5WZ7ua9Jgbqt2fHhlqS8RJUVOMgrJhKlBZK3F618cEi69WsWVn?=
 =?us-ascii?Q?sHIXnl+N/1XB4qChIQqHfRl3cSEUuh38A7hPswe5S99ULuzclAMxsp+lnnho?=
 =?us-ascii?Q?SYa+Vna3xcB3mnKeBzjJ2kyiyjGHj1m/KAVVc8orCdIAHBlfMtlQ+073GG+6?=
 =?us-ascii?Q?Xgms/qUNx3K4ZtAnx80t84dHPNuL76awFq8nuYQT3HWxv+N1Bil5b2GKcqYA?=
 =?us-ascii?Q?n6t+hF0mcbuAJ+G/lkZ0t1O56z4vvSpQ+gKlMyIphgcIetGCYE/0EdG6CrR0?=
 =?us-ascii?Q?69Dwnnaj49Ay8Ppw1X+1feL7WoDwgfM5F61XOM3MzEwT7or9/uCOYRezvkli?=
 =?us-ascii?Q?NIRQTPOdymz4aguvxWIRF2udSgS+QFz+l8cgtTFslW+q1ARY3Sn6aGNDXgbz?=
 =?us-ascii?Q?a7eIYmQp7aVnTJFGrAoFkgHiUVyYbOZIRv9M2jEOB9KiVg0aw+WxBQZKmx2X?=
 =?us-ascii?Q?ZNDgEzeXsuyAetGmg9NVQQy+bbgqBYThwZeab0Q8tQ8M916WpSF9Ze6b6nTv?=
 =?us-ascii?Q?h9BXQNDNBrjqQ02njE5CQsePE0ChIJ2lP8VzTBMMlaZ4PNllnMiXbdRm6rnh?=
 =?us-ascii?Q?q6m8ewGJuLhCpV8rAEqVjSwBW550CgbsXF+re9vfe2/CIquGoyNo82Pw7ffz?=
 =?us-ascii?Q?2rDIBWKYRLmwrjlgWXhfDxJLhvm534UMGubUlnuPddQDrXPFmiiOE9nv99H8?=
 =?us-ascii?Q?UCsBrE86ydlcBBIVR2jrGlRDGvn+XJKl/2XXJMbMOG9ADTxcoa1wdmOh+SVa?=
 =?us-ascii?Q?SQU5bAHtc78=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?raTqxp5naUNMU760sizWcFGbjTGcRx9wedQ7lQh9IVRMIkrBVlmqmsH4vblS?=
 =?us-ascii?Q?e2XF/cZf8J92Qw3gOdBMwL3m4Si/7yAcM+3qvV/zEZjN/ENkP/4qFusT5pn0?=
 =?us-ascii?Q?4AhWPotpii0YdvAoe3tsudtrLVZVUFR+7q8KiuLOeSk3S08VnedyVAhI5sKx?=
 =?us-ascii?Q?m5Q0+OI8C6TKnEHDquICFRYkcceLUpEgBWhX1N8l+k0sZI2NV2rltRnMnpHw?=
 =?us-ascii?Q?jNdmsfFYKzam6uQsRuGC/AlcfAJOIp/F+a+qdND7n+dRMA8r79rJIvirZ2Rh?=
 =?us-ascii?Q?yQ3D/cAOqKLS3AAWAcGwctJ7npQRe91lfHqIy4s7EiTxqcFM/jRqaVFhqAor?=
 =?us-ascii?Q?GioER/aVft16WU/QPouFwZ/H7y3uyMqfg6EoPdzvBromIYL+fcI8kEbfacrL?=
 =?us-ascii?Q?ob/VWovUcEawFEhYNv0WsnfbQzpPI7SVsazH1oJ3i+aq2uay3D+Xr5ZAzbSu?=
 =?us-ascii?Q?yX91BV/q//Kn+onk7FtClSDlGzhaGIqV7CeD91G72QaMNOFA2rjfy5F/sxx5?=
 =?us-ascii?Q?xTi4aG3NF10EF23ZaFUmN9xqUfQAw9R2UnM0TAhrmyYJo0nVUORTA2A1QM8F?=
 =?us-ascii?Q?+Hy0W37oDBR9CHyEyxpvKF98gUq/QMNkGfqrMdy/F4uDiOHbxBspWKCx/3Ol?=
 =?us-ascii?Q?rdbd91yQKmo3k7pDKemk+HEETjhVsE5EVh2MxYmy/qWAeO+a9a2BfA5ttVgP?=
 =?us-ascii?Q?OcsMwm0MaPrALlKoKKhWNro4ldT8WAb305p2y/hOF0Jw3gcYvN2hRvz/YIkU?=
 =?us-ascii?Q?4F7p386yeDDnJlTDhRs2mfpwjcoSaV2OMOI+kz7QyzYQY5CoInMYZvIpeqrD?=
 =?us-ascii?Q?eGcQlAxtnQEGmPhy0avzSynlrvmaQN/8O+RdBnvoXirW+Yc0AKafwy7K11a+?=
 =?us-ascii?Q?aav8IjEDi7WLwXdh3bAJbcHB4arQSHol45e/owr3Z50SnWb3PXkOaOgvAYje?=
 =?us-ascii?Q?Cdb7QJFwtFoQUXYKUy1uAwkPly0ZvQBHCqMDsENDUScgu9LZNp30VpLCsZOr?=
 =?us-ascii?Q?BynSmaRM4v78iHT2i+YXuxV6VVxvqjMCNMLpGdB2OfsQnGBwoCov/yNBtQaP?=
 =?us-ascii?Q?nb4pGTfR06zro5lpSNZc5jWXktVWuerdCb2cOWOdJ7N8JisT5689NlFPvMGR?=
 =?us-ascii?Q?jXd66uFArajnG15tm+fHuvPoM4Z6J+q/kTH5uMvtuAAGkfRCLrFRwJmpPKLt?=
 =?us-ascii?Q?hs46hQvJsL9yBEyrs2QRI8GHalcp+tlcLhxMhqAYrrLjirGyrDb5vPVbaGPO?=
 =?us-ascii?Q?5zEY9KD0YnzIK3IA3lcgBww3YS7w2/PB3hRGpcMoQAtx7p2P0+t4JLCCe2kD?=
 =?us-ascii?Q?PmfNBRUxeaYT4KfagIVCSHaoqVBZjsZQeRe+N+WF9G/JLRZ/Op6GRpJbvtif?=
 =?us-ascii?Q?kxK6eA/q5unDfE87dwWL8auqOpAgtjwYD9JEphQrMtKhSbg8md3HY7Vm7acP?=
 =?us-ascii?Q?PQmMd/jfv+lZ09h69WXGuQfwDGEBFIyKQF66WHvDjHGvJzPHeEfxz25p5HmH?=
 =?us-ascii?Q?TRj4F0fiOkHSa+1dtEM3ijySUM+BumAD0wbvI8VTaAtyB3CSmZFvMtSGkoDs?=
 =?us-ascii?Q?Xl4J/rK27uTeS7ixYaruTR3Er07skgAC0MNocJWT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86de2f6f-a0db-4a96-043e-08ddd4f5a625
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 14:29:27.7148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Str24LBYMlQ743mzQ1vDuqFEtfqq2iUH7JjoM1iZSJ9j4XtqOJ+D6gTkHF8iy6O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7304

On 6 Aug 2025, at 8:47, David Hildenbrand wrote:

> On 06.08.25 04:20, Zi Yan wrote:
>> Current behavior is to move to next PAGE_SIZE and split, but that make=
s it
>> hard to check after-split folio orders. This is a preparation patch to=

>> allow more precise split_huge_page_test check in an upcoming commit.
>>
>> split_folio_to_order() part is not changed, since split_pte_mapped_thp=
 test
>> relies on its current behavior.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>
> [...]
>
>>  +		nr_pages =3D folio_nr_pages(folio);
>> +
>>   		if (!folio_test_anon(folio)) {
>>   			mapping =3D folio->mapping;
>>   			target_order =3D max(new_order,
>> @@ -4385,15 +4388,16 @@ static int split_huge_pages_pid(int pid, unsig=
ned long vaddr_start,
>>   		if (!folio_test_anon(folio) && folio->mapping !=3D mapping)
>>   			goto unlock;
>>  -		if (in_folio_offset < 0 ||
>> -		    in_folio_offset >=3D folio_nr_pages(folio)) {
>> +		if (in_folio_offset < 0 || in_folio_offset >=3D nr_pages) {
>>   			if (!split_folio_to_order(folio, target_order))
>>   				split++;
>>   		} else {
>> -			struct page *split_at =3D folio_page(folio,
>> -							   in_folio_offset);
>> -			if (!folio_split(folio, target_order, split_at, NULL))
>> +			struct page *split_at =3D
>> +				folio_page(folio, in_folio_offset);
>
> Can we add an empty line here, and just have this in a single line, ple=
ase (feel free to exceed 80chars if it makes the code look less ugly).

Sure.

>
>> +			if (!folio_split(folio, target_order, split_at, NULL)) {
>>   				split++;
>> +				addr +=3D PAGE_SIZE * nr_pages;
>
> Hm, but won't we do another "addr +=3D PAGE_SIZE" in the for loop?

You are right. Will fix it with addr +=3D PAGE_SIZE * (nr_pages - 1);

Thanks.

Best Regards,
Yan, Zi

