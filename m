Return-Path: <linux-kselftest+bounces-24618-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4738FA13195
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 03:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 011DE7A2287
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 02:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB7C78F40;
	Thu, 16 Jan 2025 02:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ccqDaRUY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F094345948;
	Thu, 16 Jan 2025 02:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736996286; cv=fail; b=aB64czARAjnw8ufgdyv/U7msqIbSgTJDy0yxHwG/RCpYGnV/19MSBhQwM5FwxwT0CHbOFDjk0wSbQYkahtW4CLHeZenegMlvwjcZFuBb41i3JZy0FKSWHo2K0Tq9k2Wyn/HcEE/6KQfO2y1qihNmePRDzHuY7vvHmjQNtDALR5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736996286; c=relaxed/simple;
	bh=Ft9N7sWMmORRWgM220/q8gdvcMZRmpQVtSl35wYkXI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gla+1MXFaQAs+bE77lAmFZ6ojf7ri5Zs6dy22pG7Oult1wy+RZbLnQtIJsQh5EndroSCvHP/ZOBn7JxrVkRikoYuBWqJCguslnmfp6UpodJwTWM6IBboU+/H4spG0xLA2O6MBzWFuVN0Jaa12yZX3FNl3Ert1g0pRc3kOt745vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ccqDaRUY; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dh23r7iSRBUWzgv7Td15ehUb1z6h0KXdj3xJgJwFofqhc5IX2brPzBTBNDjpH7bfzzmtUaehc6PXvLzV+BLHYcszFPFV83i7q7a0DCoc0ssyFHlxz9sAGQOMhjnlJPIWokYDdSQHdfEefY5YPXJYKpdjYrC1/vK2fPhFPq6+j/z+vUqMWyvoyTZpJabkfYOw3xK3hQ3T7sIEXRWMki6ORRUkbZ9FJAgdfUOJOB+FZRvWh8owXSSngp8bmAsggdklTN7+iBCuHQbNlQgPmgwhjLYyuJjT9iZeQ823VpiKE2Z/b6TpXOoNN9i2RLCPWNvxO99QCe4faTAkWiengM0jFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scRUC7AEr5hm8LQ+EeVh9iTMu0/Wman5gbFzB57HUH4=;
 b=KTZBqCwCNBzc1mRKJgObhcFvm9q5NVtpQbCZk8mzigJGMMEs8knDUSHCLQZud5ZGsZRdQYAvd6BakNNirgVCDo1BW1kirX5/dihDGKNyr3+aW/CnR5+Fr8yg+ulq+oPxIl1OHihMLN2XsMsa8I7dXuNMPAx4Mqgdf9SQzVtNDYNAvjjp3tsFEZHW7lxQRyiAoEINublJKlQriyrLB+TFV3R2qzaxjBvnheZ5pjrkZrfLiBCKkb53uMf7Q/uGFcaweHgrF+IM9tVss0qMuoEBuBdTUC+d9ZNEmXDHeGUANAMotNcnNP9JVSyyUr7AxI5Wuq4v+teRNC0Xa+QVuVaCwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scRUC7AEr5hm8LQ+EeVh9iTMu0/Wman5gbFzB57HUH4=;
 b=ccqDaRUYVLDRHVPaHYuLB+lSLg3KN1C/KPPcXlxPpf1Zx+k8Fe9tFfIdktdvTmpplamRJWLyNISg+IyHjza0jt37KS1tBgf1CEs4x4xUrYu6UgbroAIc4JRRlR6Y2qKGZGaF185AwBJq/CgY0aQdy+lJE/lp//abKGZvdl/w9h6GbCxHWiCgG18yZ3179+pYPB51lWe+DpcsQQtjCBuiBvWZhJW+HUosuXuCTP07FvsXc1fce3fZfv3V/QN8paI8ipplz1qTn2BwbWVH0D49jx6aLEMAAsF9+D0Icz4rFF825duaq1pOj2Vr8GvC7+16ux5OFgnDtiax5QLdp+AuoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS7PR12MB6285.namprd12.prod.outlook.com (2603:10b6:8:96::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.13; Thu, 16 Jan 2025 02:58:02 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 02:58:02 +0000
From: Zi Yan <ziy@nvidia.com>
To: <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>, Rik van Riel <riel@surriel.com>,
 Alexander Zhu <alexlzhu@fb.com>, Usama Arif <usamaarif642@gmail.com>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH 2/2] selftests/mm: add tests for splitting pmd THPs to all
 lower orders.
Date: Wed, 15 Jan 2025 21:57:59 -0500
X-Mailer: MailMate (2.0r6208)
Message-ID: <DDA202EA-4664-4F50-A7FD-B00CBB7A624B@nvidia.com>
In-Reply-To: <4B01C0D2-CB4B-4A9B-A69D-7C1357543FB3@nvidia.com>
References: <20250110235028.96824-1-ziy@nvidia.com>
 <20250110235028.96824-2-ziy@nvidia.com>
 <4B01C0D2-CB4B-4A9B-A69D-7C1357543FB3@nvidia.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SA0PR11CA0171.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::26) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS7PR12MB6285:EE_
X-MS-Office365-Filtering-Correlation-Id: 51fab19a-06d7-42af-4416-08dd35d997b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8gb6AunRJGaC4VhBQHpJi0Et7DFjv6/zGnQtmlUXk6o9BO2uJdccvRskT6/D?=
 =?us-ascii?Q?JVtsCLoD2V4ZuDl4TE+R1QrZA491Y0jrTQcaT0T/sXyDZvBZHIpTjgraEWun?=
 =?us-ascii?Q?Q+pPmP7Bcsje3L7sGNt2yBbkvdAyoY4Is1sjFpSKIsezpFfa4beF6fWOQ031?=
 =?us-ascii?Q?pdTNx+XKeY/L9N3wHUviyaEnZx7jnkGFc0Co2xCRMFZBGqNgGcsZpaMC3uoe?=
 =?us-ascii?Q?Zk7lmlsLwuPTiXGVBNTspJbhWsujKiazf6W7CWT03Oh6Dmz79oOWmgHnDbCc?=
 =?us-ascii?Q?hzaB/gYDKRakv96yN9rOK+fHwETsa1vYPAgDprQ5sxfIjqJEAq1Dyx4rtDLb?=
 =?us-ascii?Q?E9p/zYZND9ND8cTSmA7xb/9uhXglMQnC4AHway+VCDaFtHq348/CW3/XMFin?=
 =?us-ascii?Q?RpGONo7wj8uIopd77/u+RpiqLhOLaGcNT1wak2x0MGuq/F++N50Fi4EG54Hw?=
 =?us-ascii?Q?Qkn25iIvGiOS8KWlp2SOSCOIa4/2nqHMj79fw2Ukh9uJg4vozqmNy25dcQJE?=
 =?us-ascii?Q?XzD7rFBYVA8rVdnnu3H/iOHbkCGiyJpALtP87NV2QUb2dVzcLCPK36stZEr1?=
 =?us-ascii?Q?31VFj0wEuP1H+xI/DzcEG2NWXiSvwYADeI7BBDKLIw9VABdGVwRO1dBajk/L?=
 =?us-ascii?Q?MKYLvCKJ+iGqr+jjZch1HYeGuX7KMVfYf7D2R24DoQe5QooZfwcz6cI702xb?=
 =?us-ascii?Q?EiMXPivo6wCXC+822rIOrLPSXRCGU0GN7xH4u1bZ3RVRsRdLL+YTdU3SqZ97?=
 =?us-ascii?Q?5hVMVG0Teno9QKa8/cFDXXcQLX6IGKJFblwrjfDHVPMALofwC5DPbWyE30+9?=
 =?us-ascii?Q?fZ6us/LWWpOu6tOsvj1wivEhZ7PPYW/EpNQYJScV6simx5g9R1rbnMyRbLEa?=
 =?us-ascii?Q?ZCYxom/0/cK3hMJbkkxKVzWAuwl8oZWmEfjGVY3/4KG018DRit9O4s4RK+D+?=
 =?us-ascii?Q?lncruoXWZ2tROKeJG0cZnz9yRtB0+Huim+M1ZA60g6WZlGjgUxrK0cJ5u0AV?=
 =?us-ascii?Q?xlGFcA8V9mYZQ2OYG5UdKCmJl7dpKDJRmnZbhBnDM0VcSHR3ZjTUV2an3ELL?=
 =?us-ascii?Q?zFtDH7hSVpviOssbTr+jiRqR93WGmpmL6fZJN10/2tUrEE3Te4mWiiQK9T/L?=
 =?us-ascii?Q?jryQtwXJ53qU3kYtaEEd83l07hElTxdYuxKpOLiWTkFLwOVltj/+Q8ch9uqp?=
 =?us-ascii?Q?oSAaXprobGrMa1GPDb2jRdICSVDuYhRRT7qgN0YAEvDXAaWlwyCocg4S8ATd?=
 =?us-ascii?Q?NQSPPvzWKY6/xDEdlj5PGZgJi5r1j6sbtymYqlcN6Flg+HYggU45h+H31Uul?=
 =?us-ascii?Q?QI6tMfuMxNXhFTVfdH78te6nB93PXlsQ0jT0B/5trBOnENhXWB6edQoggU+B?=
 =?us-ascii?Q?ljTibeuZS3y++bU2EKkT1ubTjV4p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?slbZRHn/mn5riTBW/zkefhdae/oQD4m+TGoAc7t2Rv/pdsvKIiAalTOSRYog?=
 =?us-ascii?Q?HqsHY4fD4np2QE8bzyMzPZa+S0vuh480Kug5GRjBPd6Nn8DKECSKCMIWgDjw?=
 =?us-ascii?Q?Jx3N2lR3W71cUuT8M/bStq9Nv3aTZZO6ELTtNkS06edwJtaueP6uOz1jpAa7?=
 =?us-ascii?Q?Pk/BwF+ByJjXQhAvbBvYLGB8kmdEeDDwQUhVOJ/OxsbSlbruxCPa8w14fK9p?=
 =?us-ascii?Q?3EcIFMLW12lGC1MBVUCyoqs882C4p9sT7lOqAWls6RfEyBL6fY0DkYHIv73A?=
 =?us-ascii?Q?e1uSzIXoqtIsmJ0Tkp7wYTwWOXnImUdt5EQ5XejsIqt1y/tFDI1qG4jj2pIb?=
 =?us-ascii?Q?8EpUOOU6WXPZ/GfTcObdjL6QSJNrlDbzjwcf3HxHaXKXydwv9OnmUS/CVPqt?=
 =?us-ascii?Q?eIK8HHmetr5wjuW8b50fMRFm91qf2GsDXVn6T+nFy1N8q8yIMGHcgV3M7CO7?=
 =?us-ascii?Q?ETJxO7p6AMndKPNfCtj0p5IKwT1UqZ5cyF9c/cWDJV+2SDLW0vySWkxbbHSt?=
 =?us-ascii?Q?uzNc+czQ5cfaSwq0wxZ29eju3tr8ugffSiRFldrmmQlJsJdbIOpHd3ILbh6j?=
 =?us-ascii?Q?j21syZ/z1RhfWY+vcGkH1NQN4x1Glcwt+iyCbcHg9nUasvQWQJa7HFgyFxz6?=
 =?us-ascii?Q?prQ36ja3jQCKi2bWceBL/OjCXhoGRCzFmKZ4sM+sBT1mdVo4ZWLCQ12B2QiL?=
 =?us-ascii?Q?hNcR/wkmvTAfIqvHrIuGe0fNlkgprdnSW7wJrLRnPM0O9dyL86F3iOaBpL37?=
 =?us-ascii?Q?EUYCD+9uk86Icy989rIvwz6pdkgIPv7IctJCLrdR+IMAC1ClgOs3UzxMmlFP?=
 =?us-ascii?Q?Eob3ctRolN22t6Cgd3+vtT/6stM54j7tqlpZGrEQfqRhE3u2m6GAjrDxPt10?=
 =?us-ascii?Q?prYJno5rFOVrgTNPjExb2Axf3jd3TGLz9sVMrKdiCiOVVvWdQE5UBuMn6Q1V?=
 =?us-ascii?Q?A6XlsMfVX4mGFSqb8TYPqlUalOlC+9FC7akx4TCMl4ryn5P23SdZJybiuDGz?=
 =?us-ascii?Q?TJdPoq/iC9mho9xv+D2Jg3Pe7W9xeaTjvvUkFBKPuEjrX517PcBxPalQx/wv?=
 =?us-ascii?Q?MUZk5XMCn1OqH8oOXtn2y7TRr3HcBh/vaoaf8DOl3qhXS4p6Nc04Y1Rx/AZ+?=
 =?us-ascii?Q?Ha/2SXXos0xX3jljkOEgDpa9sgvQke32QtAIaxdppRfupIQpeVEqKdzAa7w6?=
 =?us-ascii?Q?ESxIoa7gmaN7BA3zxzg1cZao9t978bSAnjcB0J6fKMz/XhzFEX0JvyuftC8L?=
 =?us-ascii?Q?zjRIa6sxPGZinz5D3i9lSmgJaJ91k8I2jHhc0C7LcggOa9xjJ2ASQS+853x9?=
 =?us-ascii?Q?7Pevsk7jBvzzszXbTOYZXvaQH4UequkfjpMr49hVULXJUlG01vsi90Gmj+j+?=
 =?us-ascii?Q?oDrJrCufWJ0lWuyCBstLhySWur2AcsVCtzphq9ZCqiGdYw4GzmYIGcipmHF7?=
 =?us-ascii?Q?o7T0ni7RqSh1zOVDWi26lJVB+DuDzPFow+UAkB+wxF6N6+ZFHrhkkCMrCZZp?=
 =?us-ascii?Q?7kBAHfckmm9cO5SY1NsYy7JaxrC1uDr514qEq0l4OblPn1xtd6CLtCMQnfoo?=
 =?us-ascii?Q?5vks+koV9sEAGcyU4BperoJ2t94r+sulymPh9E0I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51fab19a-06d7-42af-4416-08dd35d997b2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 02:58:02.6445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LaMdE6HspOaeyS6zPZS1ItlW8kS1M6MtcTwYC0H77ssH8JikXKjTj+miehZCohnQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6285

On 15 Jan 2025, at 21:52, Zi Yan wrote:

> On 10 Jan 2025, at 18:50, Zi Yan wrote:
>
>> Kernel already supports splitting a folio to any lower order. Test it.=

>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  tools/testing/selftests/mm/split_huge_page_test.c | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools=
/testing/selftests/mm/split_huge_page_test.c
>> index 128004308233..3d3bc40a268b 100644
>> --- a/tools/testing/selftests/mm/split_huge_page_test.c
>> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
>> @@ -144,7 +144,7 @@ void split_pmd_zero_pages(void)
>>  	free(one_page);
>>  }
>>
>> -void split_pmd_thp(void)
>> +void split_pmd_thp_to_order(int order)
>>  {
>>  	char *one_page;
>>  	size_t len =3D 4 * pmd_pagesize;
>> @@ -164,7 +164,7 @@ void split_pmd_thp(void)
>>
>>  	/* split all THPs */
>>  	write_debugfs(PID_FMT, getpid(), (uint64_t)one_page,
>> -		(uint64_t)one_page + len, 0);
>> +		(uint64_t)one_page + len, order);
>>
>>  	for (i =3D 0; i < len; i++)
>>  		if (one_page[i] !=3D (char)i)
>> @@ -174,7 +174,7 @@ void split_pmd_thp(void)
>>  	if (!check_huge_anon(one_page, 0, pmd_pagesize))
>>  		ksft_exit_fail_msg("Still AnonHugePages not split\n");
>>
>> -	ksft_test_result_pass("Split huge pages successful\n");
>> +	ksft_test_result_pass("Split huge pages to order %d successful\n", o=
rder);
>>  	free(one_page);
>>  }
>>
>> @@ -481,7 +481,7 @@ int main(int argc, char **argv)
>>  	if (argc > 1)
>>  		optional_xfs_path =3D argv[1];
>>
>> -	ksft_set_plan(4+9);
>> +	ksft_set_plan(1+9+2+9);
>>
>>  	pagesize =3D getpagesize();
>>  	pageshift =3D ffs(pagesize) - 1;
>> @@ -492,7 +492,10 @@ int main(int argc, char **argv)
>>  	fd_size =3D 2 * pmd_pagesize;
>>
>>  	split_pmd_zero_pages();
>> -	split_pmd_thp();
>> +
>> +	for (i =3D 0; i < 9; i++)
>> +		split_pmd_thp_to_order(i);
>> +
>>  	split_pte_mapped_thp();
>>  	split_file_backed_thp();
>>
>
> Hi Andrew,
>
> Can you fold the patch below into this one? Anonymous memory does not
> support order-1 folio, so there is no need to test splitting to order-1=
=2E
> Kernel will WARN_ONCE for split_pmd_thp_to_order(1) test and the whole
> test will fail at that point.

Please use the one below, since the number of total tests should be adjus=
ted
as well. Sorry about the noise.


diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/te=
sting/selftests/mm/split_huge_page_test.c
index 3d3bc40a268b..dedab4059c4c 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -481,7 +481,7 @@ int main(int argc, char **argv)
 	if (argc > 1)
 		optional_xfs_path =3D argv[1];

-	ksft_set_plan(1+9+2+9);
+	ksft_set_plan(1+8+2+9);

 	pagesize =3D getpagesize();
 	pageshift =3D ffs(pagesize) - 1;
@@ -494,7 +494,8 @@ int main(int argc, char **argv)
 	split_pmd_zero_pages();

 	for (i =3D 0; i < 9; i++)
-		split_pmd_thp_to_order(i);
+		if (i !=3D 1)
+			split_pmd_thp_to_order(i);

 	split_pte_mapped_thp();
 	split_file_backed_thp();



--
Best Regards,
Yan, Zi

