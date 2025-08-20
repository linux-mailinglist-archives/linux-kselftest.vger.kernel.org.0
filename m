Return-Path: <linux-kselftest+bounces-39373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FDAB2DE5C
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 15:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E26593B6F07
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 13:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6081A9FB2;
	Wed, 20 Aug 2025 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="as3QrdPJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2076.outbound.protection.outlook.com [40.107.101.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC35119DF62;
	Wed, 20 Aug 2025 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755697794; cv=fail; b=GL1EtslmJNa4VA4zYboaVOaKvKmcb7CM/vyTkvFesJvhwDQ0U7dTNLymNdaf373pBcjour7B59i1Kx7oLbl2B2t3OFVG1zV3IbWj1QugOYL6cMLwAM0F/p2ctjKg1WnpaMzX2a7caxmT0nsfwKKuIX6J3N7MKDKVx3bQVs7WjhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755697794; c=relaxed/simple;
	bh=v+k0526FxsenShZQTx9VzCchBz7lY82OHA0GXPYPTcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PzLCWndm1TJNAtNwqNUcFOjBeHBAOzta1wTg6YF8iPgcVlVkZ377yUn2MLCdplvsLmB51SmjBkK/+60gF6GE3+pmIWrp2XdUByWF1AGHasKvNpuv+r2L1DPv01EHlzFHcVDiNsnjXc6DhBgXgyPMHPAbvZfYLQ+g7WGm0/nYOfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=as3QrdPJ; arc=fail smtp.client-ip=40.107.101.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQLORERPqzMtM5X9kFCYWYaDAhmQsLvH56TR3IxJs8Lt30CHPkMK+OHzYOwERvvVZFSF08IHPfaXtX9woPiQkAmu79ZHc9D6gvZBPfRUtIM6DnqWX1UHUvwcxYh1fBgivlvKKnd9Iw/qLYe5qOqh2unVRJsyWpAqy4cGy6BoC/OV/BsCxvmg0EHZUIyfEyOr1LlHiKhbCj2jVC75ZE++icPnnjpARiSsU2zKGXnKCAGobgDu6a1qn3KF4i6/Oya9/JfZHgaOzNV+Iqdl407Oo39nw5BihnoueAKLHc4QKxTFryyWrDTxXAGGu9TiLPI3TATxU4a31mHN+Abixb0FeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+k0526FxsenShZQTx9VzCchBz7lY82OHA0GXPYPTcI=;
 b=a7+l+WoZt7J+/S19yA2Rx/oow0l+uwHqEWb4WaueDUeu6z8Y14l4+sIj1hSEs6vxcUDNu+QxnQosJgO8B9EL2jYEn9ihpS9n1CksaSqWU9M5VHD5ch5dyytaFo86pjl/4lrdWOc6u75NAYpxK69GurOmGYIBHvknuYqj45ESgSQdHTyDc+Ef6MdH2M+7Pvt1X8bp4ucWOR5iCRLCe5rUHgCcac9gIeKB9CfJrX2Y6OHtxlne2tjikCDQWtzCMpk5bIxUrFnyViBgIC5ZBzI9FgxqEDj9nAeYiPBixCaT0eeFKoJWpfhcm3d0xwmM9f/fnwSFdrZL1UcgnLOaFUSi2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+k0526FxsenShZQTx9VzCchBz7lY82OHA0GXPYPTcI=;
 b=as3QrdPJEPosdjWyPg0OSQkm+Hk5LG3OOnikqjIGBe/6bd9Os0famInldaNFryXofkLNmF9Iw4gkU84Crqaw5apayhDuav7NP349mhPivDHhFetTE0ZORFcGCLLPojziUdJpRnTjOTvAgppA7wQygoQ1BiwJ7vdfUymO/R+Y7zZblNuvN6+gHkA8mTimYDOXI5XFncWj9LA5//ZzwSx5HlwZuYUJWnlcgHxd/nsnW71I3ps64tqiFKzKqw+u2yVopNaPxq82dcxF5GSpU4RVOyijSdwsyHoWifcdeSgE1TEQjieUOZ/J5L8wTka4O9wBMJjDrbYMS7k3xsKfaBK0aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN0PR12MB5905.namprd12.prod.outlook.com (2603:10b6:208:379::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 13:49:48 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9031.014; Wed, 20 Aug 2025
 13:49:48 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, wang lian <lianux.mm@gmail.com>,
 David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 4/5] selftests/mm: add check_after_split_folio_orders()
 helper.
Date: Wed, 20 Aug 2025 09:49:45 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <A5A3C9E5-7E90-4EB4-878F-D5143FE0F349@nvidia.com>
In-Reply-To: <a81b7fd3-c466-45c9-9374-361b780ce09b@linux.alibaba.com>
References: <20250818184622.1521620-1-ziy@nvidia.com>
 <20250818184622.1521620-5-ziy@nvidia.com>
 <a81b7fd3-c466-45c9-9374-361b780ce09b@linux.alibaba.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:208:23d::28) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN0PR12MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: 149aaa17-0fac-4869-47f3-08dddff06dca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?usWYsLSkDI7a6xOde6tFRjHMSHnPuEbInbt0abZwwZCXWV4mNKQwbp1++1/p?=
 =?us-ascii?Q?Z296avrYndnXEokP4lovct6ZpzSYkHB7fVMQjArrsbwO4VnIZXCSCw/yeWbL?=
 =?us-ascii?Q?uhBHCNE7yn9J/yz9d0K+83dIVYqueIV89+iBewqWWk0P7JIH4wKNayZbx23/?=
 =?us-ascii?Q?RLFXCAQwiXI0ycneWYkuXdPoQfbN/ApUfr6doi9opC7WaE42Ozzh1orxd8CS?=
 =?us-ascii?Q?40qyoMh09UBvhcNXc0ZE6fhgESK1MRWJMmd+MzF/xK2yXT2YeL/CCSQy/8O3?=
 =?us-ascii?Q?JAPEODNtPvmbHn7pSfI5YQc+Ywq2rO6e/UwqhZ23jtqXNMJl37OQBnD4eXyl?=
 =?us-ascii?Q?WaXP+DVc/J8rYTn3nDzV6vrRCt4rhpGDCuoSkyCfNvrJUFGF1GWvsM3f5Cme?=
 =?us-ascii?Q?4CI+fU28jb3tAswPQfBwVTO7cooxxma9686cGvBXDKVmO+LbawAhWCjgwKXN?=
 =?us-ascii?Q?vojQHhzwPkx9uh3MTnDI2ZTCMtZr0LAOP1viYuonU6DqLE9UFlctOXX84Jfh?=
 =?us-ascii?Q?GJJ48PUwS4+rafZsMNKC3gcX0+duyUjl5ce8xj6iH6BFN+iAeC5nGhrz3fhb?=
 =?us-ascii?Q?oB/RVhuxYY7DCF0mFzfF/1UuQM2bidURcHZYXJDM0/Q8N+5tKy5DwKShu6jK?=
 =?us-ascii?Q?MEpOZGHXcBwwl+3s6v5LiCBSsacz+FYbMFVtPirhvtBcyFfMgGk18QAYlcu9?=
 =?us-ascii?Q?thPVD9cY4AuH+cpCRO8Th3oSA1BRaYLbF0wWAAuiXlh9oEeSssnEJV5X8uYZ?=
 =?us-ascii?Q?t5uNsGG691aZboHPsxGngfjy6uzg23PWLT46mI2P8E5205R09uvpfhtGWI8T?=
 =?us-ascii?Q?UPSOoDO71XmRNZQZzxWXddKYiUddv/4QuJQInk9abIaSE2bQ0qXlTHdUhR0i?=
 =?us-ascii?Q?e1tUhaxiszDJ05LD5MDmRHdsFMvyfStW6/C/pjLkaj3NqucRrSUu7GCT2RaM?=
 =?us-ascii?Q?wUzBICDpBtRZ9jLf4gD7UdCnUKr3j99kX8qSGm8lavbS48giCQCwJnT5iuTl?=
 =?us-ascii?Q?bupCAkuCza5sR9vQkKx9+7JlRNhYoErwosEb0Jfa7wtsUjonPM6zI9Q1QrGU?=
 =?us-ascii?Q?5ptco0QnRWcHAQlBiyMLjPv+vUyxe466bc4qWmTmjx+y4ZfsbPSuPog+6DRa?=
 =?us-ascii?Q?4rEn9GtnoDDJosu8V9uews1Tw5jABmpjwO87S5nez69fipkwGAxikTdRd9yJ?=
 =?us-ascii?Q?KbFvZKKGCzu3S4jFymMZEgUsdiD+MbIN1SSYq4OiiaxNId4IOaTds5Oeln6z?=
 =?us-ascii?Q?3Dqzpm9bAx5sRi0iaUT+xndOEW2ayrx+Ysot2i5Aym5whzkKDfO4291XscXo?=
 =?us-ascii?Q?fh5e2mRjbREcLHbDbekBPKE9WJRqqvV1L6zfOgOgo9CEY3AAS8ckxFkh2WqG?=
 =?us-ascii?Q?ftBRf6vsT9HamZ95rInxsHWszEHKExWXTaPx14l3g3iCYkhUInxbT9za4BUT?=
 =?us-ascii?Q?wE0YN+Y/c4E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G6TcBlLUxC6sX8pzjZG+TaSIQkqKEPBxm/pzWeNvTu17KXVVXsKLXa1ojsst?=
 =?us-ascii?Q?o+ulAjQBb+2LlNNNFWsSAquBqobjoAkKyKAajr/ARF+Aj7SxGbnD4jKSvTwP?=
 =?us-ascii?Q?h2rmAvYLYEJmQDsKTor3Ul4Hp9Yo7sWE2FbP08kVTNTR7DH0JBcMF/bAsfS9?=
 =?us-ascii?Q?91J+QaAuD5PiflDjp3poduuOI2BqC7KFWErBocJMbUHrojNttDOng0on1Cms?=
 =?us-ascii?Q?ukq8CvgtLiFd9Mv6Q7MAs/BjBnheQ+/bapVijFhzoxgGcaDa8RJFcPcXV3Z/?=
 =?us-ascii?Q?6rukaQxac375RdIjvQEjuX5BKHVWhwJvat7bhnVJoC5JdA7v0AqgfVStHJ5c?=
 =?us-ascii?Q?VO6xd8dnvk4jA8Qli7SW/64snkqbwGs8EV/wUXOdapRYuGj71v34q4nQTvfr?=
 =?us-ascii?Q?7wDSzR0FyZH708l8g9GAc8qpiwmF2RleqMktOPEmldMumEnEbKKlEcEs5AyD?=
 =?us-ascii?Q?fbr1y//M3LgKCCHcNRenCEGlGyuM3oBCchGrcBSNhnVFrfuQM6Tmi3rPL0us?=
 =?us-ascii?Q?YkvJupC7JjbiYPqzGxpxAJgEkgBQY/SevwRLcneB/7qBkqbiafi7RLaqOB6L?=
 =?us-ascii?Q?AtRQU+j4f4CdFr+3UThed7Bwfe7gITzpyteBbdUg2/CEiIRuNuH0F9KJKGY7?=
 =?us-ascii?Q?BDpEtPsT5Y0E/1Z/5aozdThhXw5gi/1V0hJw4jbzOG6N55ofjVMAVZ6OaPXt?=
 =?us-ascii?Q?uzd36y227Ixf6ZmQJUhj5JDuDACWvHvnXUOIe0PFETevDDJp+6jsYq5IKEdw?=
 =?us-ascii?Q?5QyYBmvfiDeCzyxDHqvySOBCJmRXemZC3QCwLbF5WJC//f2IrqR2+e48Vi2G?=
 =?us-ascii?Q?cINWW8PG5EFUMJ6nuU4EmcQde2UL1feXG/vMX4eoZLmNKAcv9CGPKDV4Ur2c?=
 =?us-ascii?Q?r2Uyx6mKbTQBKUiOfkuGVRbOrTi1XaEG/RyD134CeUlU8MiLU0JavwxtDrpt?=
 =?us-ascii?Q?0gBTO4lZ5aqfkSNQxpdhrkSj2mGra+VZqCjUP0A/9+W/AxgfR6P5d17qxjFw?=
 =?us-ascii?Q?o390VO2o9JsliIw6/pXc7/M5m/rQ3Cq24govkbm/rr6eZFF27mtPTo0v6JXI?=
 =?us-ascii?Q?MceuDViRcMU5wb9X98hVYjb9DdGA0vpM22Rrv/CnIkQhi9ST5rZzS7m4ajRn?=
 =?us-ascii?Q?e5Z0sDmRtYboxQrNQwInw4SoO+BWe+f7fVH3QscCvjEU5j5EGhHHi3cW/xPI?=
 =?us-ascii?Q?+f1VzwJ6dscwFob5+Cq5s3PdFmZydHDoLfEYd5Ce3guFI1hYRVPpW40BouNX?=
 =?us-ascii?Q?w9D6POnarPYsGj2yE9P6pJB2ItFLjB67WLAnI8KwREWW+bzBuw1QkikM1aMS?=
 =?us-ascii?Q?vqHj6z8SBc+C6ElOnRmLa3fhaoYoihNjrlpNwk3Ti1Hg/IZ3OufdrioQtXDY?=
 =?us-ascii?Q?QFBjH4II3v1rg/ecBA9+CmYcqfK5dOatfOScelby8aDf6oJ/oX2CxMHEIHxY?=
 =?us-ascii?Q?oTCO+mWiHGRrRmbb+W/QEV1P4Y99/n4E7WOFQSAiOwnGnypJ5tPOS3FCcnAk?=
 =?us-ascii?Q?vTTmOpazE4JJQwq9XJgDdiPk5wgWrlbh9hTrpb7nmVhjiIXjYjEDuikrYttk?=
 =?us-ascii?Q?C5OvDM7oMNFlQWgpddJCJwzXlqT7DGeA/ag4HN2I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 149aaa17-0fac-4869-47f3-08dddff06dca
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 13:49:48.4637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GOOOh9aJO9G5mb9tJg3ekLwTxnwBOGdS/jkFEVAjmH2lXh7+nS/qwwpHRhShgFRF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5905

On 20 Aug 2025, at 5:22, Baolin Wang wrote:

> On 2025/8/19 02:46, Zi Yan wrote:
>> The helper gathers a folio order statistics of folios within a virtual=

>> address range and checks it against a given order list. It aims to pro=
vide
>> a more precise folio order check instead of just checking the existenc=
e of
>> PMD folios.
>>
>> The helper will be used the upcoming commit.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>
> I tested this patch, and it works for me.
> Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Thanks.

>
> By the way, I moved gather_after_split_folio_orders() to the vm_util.c =
file as a helper for mTHP collapse checks in my patchset[1]. I'm not sure=
 whether you need to move gather_after_split_folio_orders() to vm_util.c =
in this patch, or if I should move it in my patchset.

Feel free to move it in your patchset. My initial version has it in vm_ut=
il.c, but
I realized that its implementation is very limited to folio split check a=
nd moved
it to split_huge_page_test.c. If you find it suitable for your test cases=
, feel
free to move it. Just note that the code does not handle memremapped THP,=
 since
it only checks page flags without checking the PFN. So when a vaddr range=
 is mapped
to a THP/mTHP head page and some other THP/mTHP tail pages, the code just=
 treats
the whole vaddr range as if it is mapped to a single THP/mTHP and gets a =
wrong
order. After-split folios do not have this concern, so
gather_after_split_folio_orders() is simplified to not handle such cases.=


>
> [1] https://lore.kernel.org/all/955e0b9682b1746c528a043f0ca530b54ee2253=
6.1755677674.git.baolin.wang@linux.alibaba.com/


--
Best Regards,
Yan, Zi

