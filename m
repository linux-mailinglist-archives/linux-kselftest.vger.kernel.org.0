Return-Path: <linux-kselftest+bounces-39323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1863B2C9FA
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 18:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED655E80AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 16:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D772BD5BD;
	Tue, 19 Aug 2025 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ku+TfVbw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4440427F758;
	Tue, 19 Aug 2025 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755622223; cv=fail; b=Ls+faIHRmnU4soltE7r4yciF6FQ3RZmEQhWTyNGemiUm+oWXHrhxO0ugFAHioBLVt05+1JpCjfQfIkrciAEISliDcnt1GHxuUarai5iLxLSB7B+Yv4q8r8HYTnLNp4R5ByQjIPShDZKypmZxxyqJp1TIVD4amTexZ7g9HkzzpOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755622223; c=relaxed/simple;
	bh=P1yKfyb+2hyyugoW9n3DV8zE3nMA2Y3yZDTRAg9unMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ocbBFwhVCg8YoskaBkWQ290Qd2UmUnGCSN8Sgn8bKR0RLkuB+kfKKdc+R21N0V6Fdrlk174BZo3Fv1RrTruk4SKtfZNza2dyeAFigQgn0b4w8MjwCnqEe1yohlpQcsHCgFILquw52UUx14PY1LfYLgYK1Xlrj2Cr+N3gg2V+XrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ku+TfVbw; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkwrlXGhFeUgDlWQi539VohC8PiaHlXIf14jCaR1yqQ9xT0uUK+adjoj+drbG3azVVhfOKp+LigR+AmE9lEliSTJ77nyltWIPI9Cjfu+lLCCxv2O5l0sz0D8AP4dJF42AANYOfXHe5RmJwUwmQKnnSUeVNCh1jM74BTZqLNcGjYumD7l/CvenJJQeNMr+nFf02ZLVGz3yS8yEVusEJbLJdb9dthkvsANTmcbIS2RM8oMShN/+S/iVPykywoUdMzXCl5gvRpTRhrhfrFuxErMY/5mxYHqS0I8Z8FbH6lqWd2Owh4xEHiLIQf8FViAGzSoliG3NM9s/93O5IPKaS8Y+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptzlT3jakUHu5a4CfkCLYXyMg1O90uPR+yEpgp2emHw=;
 b=cf/Sb8NyPycR6ge8b55THVK4N0mLv4jl8ihdQA6ApU9mnIerNmQMy07033j+wKgYZb0XvWSMQM/lqCyAg1FbkVgyNgGiUU8Fa15jWzymbxCmt0o7ezuYEWadUEeEU/6QO0rxkGvFVbRZcpnVXtUUYMFH05Q5N8H+Xg4tNHnL0Z99XTDc1aExj5C8N8AtK9+du1pF/SvEf3PcsEk8y1+QryEKHfcz2WmeJrCI7Br7XQXTjJ57fE/LVZpVVBxtcRr+hwNSj13TfIFNdUaI9ahAbMDxNRwQFXPDy3KyczCi5Ter5r0T+MbiJ2Cs9HX4Jz2lAOLtj/UqhMQ1EEqj7ivTOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptzlT3jakUHu5a4CfkCLYXyMg1O90uPR+yEpgp2emHw=;
 b=ku+TfVbw5ZMSSWO6RSQtcgoQJnM/U8CcoxPxtQ6lGE34aldRGz+AC4xcl7lbQPwbLAIA4GSca6vlggsOEIFHyWB57Bz/i6A5ADaaFMNIVwMCXpWmYS2oB0Su/opfoUxA7+vpR5NZJHCaUG+vlbFxJFvyvljMu/9QeL9qoBzPKpCu2B3lJUogXv3ykCkigryAJKvum0I21SHdhoTIBSzy5MlL9JozlDiLwX3STssad1IHL30HTHDYQFQrwaSfdxP0qEhD31U+Vx+m5pliWd1b7lAlrdaqxsTmoKulFURx/S7vSPyz0kAADhu9leyTmrldFTPCdP5VNlRh6D9HUy27KQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB7295.namprd12.prod.outlook.com (2603:10b6:806:2b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 16:50:18 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9031.014; Tue, 19 Aug 2025
 16:50:18 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, wang lian <lianux.mm@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 3/5] selftests/mm: reimplement is_backed_by_thp() with
 more precise check
Date: Tue, 19 Aug 2025 12:50:15 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <B8ADCDEA-DB05-4843-983E-A66DE78AD1D6@nvidia.com>
In-Reply-To: <268d9c9b-4c48-449c-97c7-33534fb23fa3@redhat.com>
References: <20250818184622.1521620-1-ziy@nvidia.com>
 <20250818184622.1521620-4-ziy@nvidia.com>
 <268d9c9b-4c48-449c-97c7-33534fb23fa3@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0422.namprd03.prod.outlook.com
 (2603:10b6:408:113::7) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: f79e0e69-bd01-4814-670c-08dddf407ac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G75zKlIrm0Ms/V1mesgVgctDULu1fQFbrRY56GHsqdAdxOju+oFMFSGsxJjV?=
 =?us-ascii?Q?J3uSaUr5fUrNxnwwWrCFS16CWBRADoikv7upnd4s1t1eNyrih/A/x5PHtvId?=
 =?us-ascii?Q?jMVwA4noXNdVTt68dBhmb2zkG62WUMOlBc+5PCrJ/N2igAeakbqJsER6nU86?=
 =?us-ascii?Q?tVHBqP2vTzHfzplnLihFQEkJ63m9wSHSfWDjEoHroslf5EejRXoXglbnVS45?=
 =?us-ascii?Q?mpIdYOv65/EfMMhquwOyiIVHRNyA8Yj9AqLoSFE1Dkmyko8ujhLPKCn5IZOy?=
 =?us-ascii?Q?5sKRX7wWpa6DOgoaTps1xhUHjZrkSFuK8nXEVSAuZ7OG8XU586gZvDqRAPUT?=
 =?us-ascii?Q?fbjPKXOk7djjRuarVPOYUKLPxQxegbp3nMmSZmyxCmhesnZ8uD8CtvxvmWcl?=
 =?us-ascii?Q?QVV9SwlhNAjZMBJZMpUoqbbjVbaqR88/fM5emFRLAbwyh2a54Xx7Obmh6C5f?=
 =?us-ascii?Q?WlW4VLAxBX0yjULAA0UDILXXRxNZMYeimXaqhNivg4v1+JBGq0SRRNuDjkV9?=
 =?us-ascii?Q?0dWzYZQ6OTOY7ZlS4S2ez45wR7A3WHks6EJSAFB7N6w5QhKTk9oIgEUtlVpi?=
 =?us-ascii?Q?GSHLZg12/+DdrUWYL2XTGggK4Win5C5nqKKZLWMOxdpvVNnnittQZKhWimEg?=
 =?us-ascii?Q?apvQ6KJ+9in/Sg/lZ5desAOdaS52p7DGGIyFCgT6O56oaf6VxUev68hYjJKy?=
 =?us-ascii?Q?519XwerYDwliOt7KzKAJgA2ByfuK0/EKpybkKVMLylJtDRTdb35v+nEh9cdl?=
 =?us-ascii?Q?6HZKMBaXxW8MXmzuukol8Jerykorv5IbGuhmjx1fyie7NCkcbEi9eQS1AnGP?=
 =?us-ascii?Q?RUgg3xEgHIIG981HqQHLpBJ459pQaH8gwq/pjV+xzhfLVDKp0jnsa6he4wI8?=
 =?us-ascii?Q?eaoFD7BKGTlyM9Fp7AmxI3BtAtBKagmK/dN659pkSR7rUeJ6/0gWQy+a+mlj?=
 =?us-ascii?Q?205xVvMyLRFaobDUIoi3IqeSoCUNaEPNtjkxzuxNVPwfXZCAbiFPTUb2Y0xN?=
 =?us-ascii?Q?CogyysigLQ6mG4pc7kl5smCxG/o3oquAfwOoyp91X1/dJ3W44TM6GzZIfKup?=
 =?us-ascii?Q?W2x1gxsPPtMLNyOiJhiXY9JiOly9Cqj4ho8kSW/klqP5Zys+ONLfYAS0RdK7?=
 =?us-ascii?Q?JsUNe7pRxrtrKO39RohajGk5HvNZqPOoAI1q3DHaVQaUhmmHxVnmGiTE4tUr?=
 =?us-ascii?Q?R4c7lpZ/8qw5AYm7DgLPMwt2N3nLtYy5Aokz8lieZUgjwTFn5axYHdFQ8GCj?=
 =?us-ascii?Q?Jp+v98X6yGA+ltZiIISLiMObwwuEnpoppAjIuTU0JjoGWRRd+/WJTHbdXZSn?=
 =?us-ascii?Q?2XjWG0VL/fZ+0JhgWHE98iI2LNIlHmTFVQdIMyYaFY+1F44NwbvhUJcG+xNS?=
 =?us-ascii?Q?oQKXSadqyVR3Vl2x9g5U0EiXki937f4da7mZ0vPlpPWjMvjKRyhiYUu0c5Wq?=
 =?us-ascii?Q?uhKMGAjX4mE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DLRp+8m+Y5EVNaeDOZR8GgSY9+/t/eBmR/wdW5CAJZlG+dD4xoQK4hFmLqms?=
 =?us-ascii?Q?zf816dAi+zfyztcVn1XqqkdsslVR07tyVE3P4fLVREfLTuihSHihd0KCnbV1?=
 =?us-ascii?Q?eDub+iA7to3RAlCYwSqCJuFREEBE1DQ9uStnsFvyJBUR+bKs3GgIrmIpn7Gf?=
 =?us-ascii?Q?t4zkb0zqZRGEZ3Sqsy1CPHfumHqDc4lErs+s2s2mqPbtjVUFrIKc9LXNc89q?=
 =?us-ascii?Q?1yJgXytLyNTZ4d7XicwZUtaqDYrAIpFnt3hLV+WiEL5CIbxYy/5sRLKoJ5a+?=
 =?us-ascii?Q?V3nxTAIw42OoR7VNKOCzXzqQqmBJ+a/5f/tKkjAegdAISJuRVcZXwWUl4ORI?=
 =?us-ascii?Q?lrWA8GxV0xWldL9KJ/JLdiN0TxM+67abTBY+lMqI3dqi/8UFonIV6mOUpnRY?=
 =?us-ascii?Q?JSu4hxshVgKLQ4JvYVJS3to+/GZwS4JXagYvBrybRzkC6Q6TloWeNGyOULdh?=
 =?us-ascii?Q?308NtOfmllQERz7T3wzzYc+XKk7ixyjljdMlYRQ5ahf0BIcAO9TiZmftI3mn?=
 =?us-ascii?Q?xbo1Pl/uM7AP1ZKl6StohdqG+UE6VEuM56ewjcImzWgdeHFl0/DnZs3wOXiY?=
 =?us-ascii?Q?GBQxKA1CSLO/Mprmtvh6QfUt0OAmFeOD0DmyH0QcVF3JfkBT4y+9TaVAhbTt?=
 =?us-ascii?Q?v7Hxepnfx3WfMN0FM+nLreZ2Y4x4QC+bJL6kL/elMeLCXeOkBBDqzsGKhuIh?=
 =?us-ascii?Q?UUZFpaOBi+DtFW2QF3gzMkHcDuLbSP8KxfnBlGUCIN63TwXjHR8q6w4I5Dwg?=
 =?us-ascii?Q?KJY6pTGpUM+jOcvvuQSDxNrLVQaY77Fj7YmJisl/nyS3D5ib6ZzMZYFXHPlT?=
 =?us-ascii?Q?5ICVV34Hc7DkEoRN9qOO9hCeuFMl3Sx7TKwsh2OPF3KJEQyTkFSseBwMacmM?=
 =?us-ascii?Q?MAwYZHhtLIMKbfR3zCERfGVyxnUwnevZX9L/UqYVfT37osrV0qlK2Af5gQxc?=
 =?us-ascii?Q?rWD3cokPXD0Nm6b3pir03EsyXvtajMf9JQq/2yEwEReTpOKvu+haw4HueaLg?=
 =?us-ascii?Q?PFHMX/kB6lTwIrqc+ACw7EtQpps82QAZKBf6jHMNQW1niAmvaBJJgE6Thigq?=
 =?us-ascii?Q?dLS9v9fUGRXCqN24DYxL7GWkz/q+KtOmBz5PgHytQlSRIWFA8DrSzOtyugSO?=
 =?us-ascii?Q?M8m+yEF664F8yz99k3Xl55bnqXm2lgqvizuoCPM32G9gC962tCQ/xsH7YeFv?=
 =?us-ascii?Q?VzmJEjKDSU0RaLvGM4+5iGzL6Vf2r1jAipk4S1QJxOX+U+4DY3zHwudx3lG3?=
 =?us-ascii?Q?py+pl342whxZAKu4PlVeRHAvxr9FOS0TlGhhGlLazur75E92dANe485zNkp2?=
 =?us-ascii?Q?XSMHtmRYbWQwKWZGFeNU95deWue/ALO5mnYBzoaL2u9zWozs9gau6d1ygpQD?=
 =?us-ascii?Q?Z+BF9FcQLg0qRaz8Rp0n4BralIM+XNs1qbDFeEVn1Jce4Uw/9ryiv/x2mUll?=
 =?us-ascii?Q?iZTt6JL9z2GxsA8lPSbTRblwIfZnhGd6uGZGNJVFGfkmdKlqD93Tl6Jntw6D?=
 =?us-ascii?Q?hr5IzernT9zKnONPefZdBRb/GVaY7S4VHwpVVBEqYSJRLO3iEn7gYdytz2lp?=
 =?us-ascii?Q?/YgrGiWJi/0q7W5OKSv6qxNR3lixOXHL22MtBY54?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f79e0e69-bd01-4814-670c-08dddf407ac2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 16:50:18.8199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pnOdPZtrqdPaZTfj3ygaSJAAH1uaKoXnduPnofGYpDqBIgsCbpXI76mqN1TH4BEI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7295

On 19 Aug 2025, at 4:54, David Hildenbrand wrote:

> On 18.08.25 20:46, Zi Yan wrote:
>> and rename it to is_backed_by_folio().
>>
>> is_backed_by_folio() checks if the given vaddr is backed a folio with
>> a given order. It does so by:
>> 1. getting the pfn of the vaddr;
>> 2. checking kpageflags of the pfn;
>>
>> if order is greater than 0:
>> 3. checking kpageflags of the head pfn;
>> 4. checking kpageflags of all tail pfns.
>>
>> pmd_order is added to split_huge_page_test.c and replaces max_order.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
>> Reviewed-by: wang lian <lianux.mm@gmail.com>
>> ---
>>   .../selftests/mm/split_huge_page_test.c       | 88 ++++++++++++++---=
--
>>   tools/testing/selftests/mm/vm_util.c          | 13 +++
>>   tools/testing/selftests/mm/vm_util.h          |  4 +
>>   3 files changed, 81 insertions(+), 24 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools=
/testing/selftests/mm/split_huge_page_test.c
>> index 089e146efeab..56d1eaf9a860 100644
>> --- a/tools/testing/selftests/mm/split_huge_page_test.c
>> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
>> @@ -25,6 +25,7 @@
>>   uint64_t pagesize;
>>   unsigned int pageshift;
>>   uint64_t pmd_pagesize;
>> +unsigned int pmd_order;
>>    #define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages"
>>   #define SMAP_PATH "/proc/self/smaps"
>> @@ -34,26 +35,66 @@ uint64_t pmd_pagesize;
>>   #define PID_FMT_OFFSET "%d,0x%lx,0x%lx,%d,%d"
>>   #define PATH_FMT "%s,0x%lx,0x%lx,%d"
>>  -#define PFN_MASK     ((1UL<<55)-1)
>> -#define KPF_THP      (1UL<<22)
>> -
>> -static int is_backed_by_thp(char *vaddr, int pagemap_file, int kpagef=
lags_file)
>> +static bool is_backed_by_folio(char *vaddr, int order, int pagemap_fd=
,
>> +		int kpageflags_fd)
>>   {
>> -	uint64_t paddr;
>> -	uint64_t page_flags;
>> +	unsigned long pfn_head;
>> +	uint64_t pfn_flags;
>> +	unsigned long pfn;
>> +	unsigned long i;
>
> Final nit (sorry!) :)
>
> const unsigned long nr_pages =3D 1ul << order;
>
> so you can make some of the code below easier to read.

Sure. Will send a fixup.

>
> Acked-by: David Hildenbrand <david@redhat.com>
>
Thanks.


--
Best Regards,
Yan, Zi

