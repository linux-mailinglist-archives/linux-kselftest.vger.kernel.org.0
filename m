Return-Path: <linux-kselftest+bounces-40611-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B962B40818
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 16:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 318F07BBF53
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 14:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295B230E0F6;
	Tue,  2 Sep 2025 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UOLL3VA/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4255A217F55
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Sep 2025 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756824996; cv=fail; b=cQmIbws2lRm3eXN8KavVpp/JvnbE9HK6ymQWcNgzeYkpDscXQ3Bbu1O1f6Is8kpIQ56xuOMIdcHwsDtt9Bi8++Sfj0udlvrtdUGHPQKNzAp2nur5JvmzhvGys6CddUQ+KWWT8uhkGOKnzgW2BY43rov2Q695G6BQjD8U8uRexVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756824996; c=relaxed/simple;
	bh=KPuNPy5vMXDlHDWan6COmxqsUmDM41i8fEhn1hRLANo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uF9FNnSTsqRgPV1kcQBwF128CiH2GiPvQfo9wJ1be6jBFotlcMj+A4dX2wmivVg2YBnHsIdBEqiTIJv0dkJ/SHjQopOArAS9IwLKF8yzMf5zRq8icNlAq4WY7aKaZTrH9R+kRWexwKvJjC7XOLIE9anVvWLqnGlkrkJ9JrdPMPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UOLL3VA/; arc=fail smtp.client-ip=40.107.236.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrjJ39rOx4s6MUksGdk3uC8y+r8GttOTtg2d/Ub1c/x6W7HeUzprlLrhCfA0RBj8Ec4ZC1e2cYThuTzFl//15s9fQkRda9ff77rIIOmixouacBlpfy5wZl0Axhkh1AgRoD3t6hUt0lHfeXiwb69oQNSe44TDPin8q8n0BtvXdivxkKDTG4eZqi6zTvAUof/ElpP0x++fGuzBEIjkwVL45CzdeZgNlnOKbldV1mT5+KfdYlaS/nGrCSTxI9A2S0qP7mBx87eFZQtgECUlp1cIcq5Z5RM7esVKhp1O3pRk+M0U26ldXdMk5LqPR4sJWMMdTQOqwce1s/n0/bRRYDBfmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJvlStLxquxwvKpJXUkZvApYXappkqa94EjdbwikDh4=;
 b=sIa7ouf+zo4vpZWsUUmINxxMQ/1yJSDV/j7KV40xwndOLXmHNiBM5gWirwE0qL5yLZ9lVbVhPUO/af3H+TsPGMOihnltlvtbZu44fbv5xde0Y8Ip9txvnYbRXYLsc9Uj/Pf233+iZ6225Eu8i69FJ9AH0gt+8sm3Zs7Q6/dZl+vPTgMU/O746J0eACCxLa8H2c+kLi8KcXqdpnvdwan/N50ewNw5UAMvotMz9y4e+HfE8fFMEnwYMV+9+eCyJJvuGVKvkcwfr9mEp37D0onv1qo1FoJtnv15p23S8ZNYAdnEB5eYqO9RjMuIJ2fUo+uPO3gnNmjpW5KWt7oLXzqgLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJvlStLxquxwvKpJXUkZvApYXappkqa94EjdbwikDh4=;
 b=UOLL3VA/OQMM8iz8Xaju8bmz2eqkVQ5itMQYcJ/He0o7MaIK7bcNxoRLoxz8fxtgrtBW1QebFwnY4fuCy60UBTV/uudo0Y/SODnsaA073TjFS8GWlx8D0fsjklWHJ5UEYshwWyymAbT3wvc/0QGdKmxd7Y7inFmkfbZuQ/kqexUW5WutEDtsaenbJ2PPuWMdwmyKl55tyveVPgZ/GRD0hsL/ScJGBj7oGYThipxzA0r7s3p33lXah/dqkfBGOE/gZaHWGAdRecZtf6gE1bLcyUcEKZL+nrW3vHXM0oJJpjAHZs+fYuMFRq7pInBvwAkrDwhEyuRJbGl94E8/nEpVaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN0PR12MB5811.namprd12.prod.outlook.com (2603:10b6:208:377::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Tue, 2 Sep
 2025 14:56:30 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9073.021; Tue, 2 Sep 2025
 14:56:30 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [Patch v2] selftests/mm: check content to see whether mremap
 corrupt data
Date: Tue, 02 Sep 2025 10:56:28 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <27A308FD-C7D8-4C65-90BA-9B1DC117B014@nvidia.com>
In-Reply-To: <5a796574-0a3c-4040-b0bc-3ff757402759@redhat.com>
References: <20250831022701.2595-1-richard.weiyang@gmail.com>
 <f8e942de-1a50-412e-9020-1bc901b4243b@redhat.com>
 <61E58B7C-23D0-49FE-8D0C-CE0B672114E2@nvidia.com>
 <0a0b0018-9427-4201-bf53-6aeb251bc482@redhat.com>
 <1D88E773-C11E-4F28-A13A-1A681898198B@nvidia.com>
 <5a796574-0a3c-4040-b0bc-3ff757402759@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0514.namprd03.prod.outlook.com
 (2603:10b6:408:131::9) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN0PR12MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: 833cc17e-0a40-4978-0211-08ddea30e68f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z9INWEfMSTXzNvrZ7g4riT4q+MrT5jZF2qe83QNEaB6ijNourCrk66ly7d79?=
 =?us-ascii?Q?edI89zBbscXmEGccFul66ZAWfY589e8OJ69unRpGFp0S8hw6M0wSspwOqMR4?=
 =?us-ascii?Q?JdbRcvPACQ+MU7Wf5lDtvVLwYNoisuM3S9aK+/jJa+VFhLA6jLrbjTdRpdjT?=
 =?us-ascii?Q?lZFquOxZ+XIDHgFA7TwI0RGjKYZ28V2s2cb/hr+it1he5SadwCaCrBX2REjm?=
 =?us-ascii?Q?0n3NQcOO766s112yIfDxztQ6Co7XOuoDq8kJvOFoPythkG9n7moD2GU5NmJW?=
 =?us-ascii?Q?j94mBr7rs9z9ZKzBguFQkrGjd0i5sXazM23cCz5NkwQWAui2l4NO6ZM1SOVU?=
 =?us-ascii?Q?S+RByq6bfB20igvfWDroUP8GdKP+XJH4IB18xoHFVzpBGAQKokQp1d3xjYOI?=
 =?us-ascii?Q?heeioZ+xof3aqigMVL5TKEoXWtHZDdhaTv7aJ7rTPFpwB0alOnq4MoyN3L7I?=
 =?us-ascii?Q?xEuzm96V9KbObNv69ej8U3CEraVPVoyHApJIvj2xo0t9lmuKA0wrtmRz20kz?=
 =?us-ascii?Q?l+vqCyhMUSuZNnWFJ11KhqARzIx4H7nhu/MNaMcRdnfkf0IMA0ncDPyM8wjj?=
 =?us-ascii?Q?urqRn7iWzdYrRVxqomn7XqKTyBPvhDqVC3D/acgEP1kG8BGcGuBjjgxLWSOs?=
 =?us-ascii?Q?ZMQiHnC9no4pN8+Ivsn6eS5B5uuXE22sb2maMdw9sGJxhjLGxIwTpP4omVzu?=
 =?us-ascii?Q?+b1H8bXPxGcOd9hfRWLgjcgBiriMmn5BWDpNyanzm+89xbSu2BoBXCZ+X3QF?=
 =?us-ascii?Q?N4Pmaci6xbxfphbrnd949SJdQ6prNkiH7zDsstDkjWkdqXiSy98JCC1qFou6?=
 =?us-ascii?Q?/VsBnrBlbD5Rn27ym6WbO0SV/mCuC1m8AgAxcjr7amHXJAomRcDXLtewZwx+?=
 =?us-ascii?Q?q6OAmmmSSmyNktrFTmNHBzPjeDfw2uIGQ10nTvaEA9qCzeGRP561I/a+je6l?=
 =?us-ascii?Q?GBgbUkq5PBLXGH8bwORJMdz8vEwwcpDxVzJylyBQnZXuZTe6pJ2OvRMb447y?=
 =?us-ascii?Q?xIueybv7B6xB6Jq/tjzgjR/tJkNLeUG8cHNs/Ipop8m52UU9i5wgKLTtUM9E?=
 =?us-ascii?Q?wAtPU8dFQy8wkEPIZYy6HSfSwGWp7rrbZWQkebrfDvQuVihyHgHQC6u4w2TR?=
 =?us-ascii?Q?Rx661kCDpQTf0YLM3dN7Qdt2xv4TMIMhQduwZQBuvQWpeMhgk2eDOGcMJpuF?=
 =?us-ascii?Q?qbrko6y0zJYSaxmQJ4FSyn6ZVs7ljv+tWq5sMNaLbcz+5Q2KfsalbebSnlfd?=
 =?us-ascii?Q?TYY94vnIyzh/28R6FewWZ0UaacxsHNZ1IBgeBnJfycYFe0Edf2WS0qUx7ZmF?=
 =?us-ascii?Q?tzhXBE85+jPTROBmzOXUV0K5Z5tN41FUAyikS/QEOWHvps7tKDUT5XLTIWdx?=
 =?us-ascii?Q?cEjXXMxXQxPQpGdAdzGIC5Fo7rNDsZP6qk4XNna+SntxZGmXpa/Q8grk2lbZ?=
 =?us-ascii?Q?v431TWm0xms=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XxsoidxfOrfKIRl7Iy9uptpyzrvDUB+frhIyoAIfq/sbDL+fItabs6SzgHVc?=
 =?us-ascii?Q?/WRuXyAZVc7NG3WxzO9A77rF4SBIsNPUg+kto1HQVD2P9aHIx6GAFdJ/5tta?=
 =?us-ascii?Q?GpDJyqj8TVEWFcnedEB5y6u9OUB8UomRzj83h4dTL7EBQ7d8HDQ6gqZ8sf60?=
 =?us-ascii?Q?WoeOI9edjGTJs2SjDaSuxtBVLX9QuXF9NomkfKbvOVn5NIqeXFS5FS3eSH+q?=
 =?us-ascii?Q?m9frTH144dvWt9AwA3QCNAVE79ajSej9WM8PjVK2nd2c0tX38LukvublUw4H?=
 =?us-ascii?Q?M0Y/3WexSxdBd9xCS9k9GWIkuaihgdil4wEyjTgBrzm2abHk89Q/GRg5dv4/?=
 =?us-ascii?Q?Z4XiHiaUFyOYLh/jYhngjxM48geqkZq7wW6CdwsmUq8SL/v187HUcrli3te+?=
 =?us-ascii?Q?/zw7/fhprP4yY+QZ910X6vEv0OHcSQHvjmxCf5PXm8UczarojcQ6k27KCkT+?=
 =?us-ascii?Q?nfOrRDTvH+NnYv3KgwU43AFRWOjOyUcn0OydkODp+HD4caQJh+0Dz9YS23B/?=
 =?us-ascii?Q?1hCn3tTAeNUvTQeqwClQ+tJjs/zArS8/Khl9C4cRT12DuyjR/Y8l1BWSCGqf?=
 =?us-ascii?Q?mnmcc+FeDB76xmqSmvP5pQk1Lb83dLmUbpewrvMV9xBXH4Z1jQ64l0837tta?=
 =?us-ascii?Q?cM+859JZNduv6qJBkLu/XWyvvCOhzCJQ7f8BdpYiVR8RfnzMKN0bNJieEdL/?=
 =?us-ascii?Q?O3jmLWYaJX2ztNDsRrV0YkNrzWTpWizdFkehdzA29PvUwztEz6n9BObqDWUC?=
 =?us-ascii?Q?b4NbF0sNs3uNlLXyMntpPFtfe/2thosunnIsYN8GFHnJWc5YtA9DFIVGvIN/?=
 =?us-ascii?Q?60JblBJUEcBwJe0NITyeRpXhVmsw7YnZlKOZU8OXIhOO/dMJYdFnXf+BmoZD?=
 =?us-ascii?Q?rjEO/DrxgyUNWbB+lueXXeoMbrak8DBc6EXtDgS1kKGx4B3jbbRu8itYCQIS?=
 =?us-ascii?Q?ExnzdzUSKwKSuHY0FKhXxUrtqp/pR8XE3vCveDTRzN8wTRvCBS581NrB7YRq?=
 =?us-ascii?Q?Riam9+zvMXhuTZ/KonocxwKYdNpD62hrUQYzlc71j2BHUgM8AQ3wZ7rRdJhb?=
 =?us-ascii?Q?8cWD+Bd9Y109mjnr9UYq75h/iGJe/s/7l08A57nznEnEMqjgTn9y3sPOPIu9?=
 =?us-ascii?Q?Q8bSYD+B43Btef2QXPAj2vd/wek5UBugdqw88ASnGR7nWKKDp/jOBkMg54bu?=
 =?us-ascii?Q?q2ZzDI53spFOl3yJAnCRieGEElTZAEftpoL+O6OyjUqkJXbCO5UsZSPT7vHM?=
 =?us-ascii?Q?58S0kfXMhVCf4sBDib+R2yPnpdeM9BbzylmRy/A2mOjw+G+PoiSRRTPtv5mS?=
 =?us-ascii?Q?6swyDXxoWyeE6w+/8ZaAGzqYyeuoxeqA4epr4B0iCTsjysHrrKjQPSJpKs1o?=
 =?us-ascii?Q?pPjPNVR0zRvW5uBTEvT1y05yE1wD/gBBJa+Zoh1U4Z9l71qYjgWEO+EOEHjQ?=
 =?us-ascii?Q?K4EUEqxAZQFcwYYRfenwK4LY/RSgPoH1Zdg+YolT/+pDHKCPRBGAzuw2RXVe?=
 =?us-ascii?Q?gEidJ6HTzySGqQVRWmo/NlE7FdJrDHRPqNnHKV7jz4i2DEaD102Ekw8Xxek/?=
 =?us-ascii?Q?IEUZCVfeXTEe3NOXGu5hLAQPErWstZW8QvZeFbaV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 833cc17e-0a40-4978-0211-08ddea30e68f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 14:56:30.5613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+9hPfmg3I9aQwNFdlFZvna47OtSRxzkUcqfEH5R4sLVuVakNKbLylQrzFTJGvPp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5811

On 1 Sep 2025, at 15:10, David Hildenbrand wrote:

>>>>> (a) Will this actually do anything? Also, maybe it does now, but ca=
n't the kernel just optimize that out in the future?
>>>>
>>>> It remaps each subpage of 4 PMD THPs into a contiguous 2MB vaddr ran=
ge and
>>>> perform split on that range.
>>>
>>> I'm afraid I am missing the "why".
>>>
>>> I would have thought that a "split_pte_mapped_thp" test would want to=
 pte-map THPs
>>> to the see if they can be split.
>>>
>>> Why is the mremap required? IOW, what exactly is the test trying to t=
est that
>>> exceeds "split_pte_mapped_thp" ?
>>
>> IMHO, it is an interesting test case for splitting a THP when only a s=
ubpage
>> is mapped into a vaddr range and in a contiguous vaddr each page comes=
 from
>> different THPs.
>
> Right. Slightly similar to just MAV_DONTNEED'ing the other PTEs and try=
ing to
> split the bigger range.
>
> Of course, if you involve more mremap, the RMAP logic of installing mig=
ration
> ptes will get stressed more.
>
> So yes, there are various ways on how to stress the RMAP walk when spli=
tting.
>
>> The mprotect test case you are mentioning would still have all
>> subpages mapped by contiguous vaddrs.
>
> Right, it would not stress RMAP as much.
>
>>
>> But if you think both are just testing PTE-mapped THPs, feel free to r=
eplace the
>> existing one with the mprotect test case. In addition, is_backed_by_fo=
lio()
>> can be reverted back to its prior version, since it no longer needs to=
 handle
>> the case where subpages from different THPs can be mapped into a vaddr=
 range.
>
> Oh, the is_backed_by_folio() change is actually really valuable.
>
>
> I think I was confused by the implementation that works on a single vir=
tual address
> range with multiple different variables, questioning why we mremap at a=
ll.
>
> I tried cleaning up that test myself and ended up with the following (i=
t
> escalated a bit). If that looks cleaner to you as well, I can submit th=
at as a
> patch.
>
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/=
testing/selftests/mm/split_huge_page_test.c
> index 10ae65ea032f6..aa0f0502efa06 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -390,67 +390,88 @@ static void split_pmd_thp_to_order(int order)
>   static void split_pte_mapped_thp(void)
>  {
> -	char *one_page, *pte_mapped, *pte_mapped2;
> -	size_t len =3D 4 * pmd_pagesize;
> -	uint64_t thp_size;
> +	const size_t nr_thps =3D 4;
> +	const size_t thp_area_size =3D nr_thps * pmd_pagesize;
> +	const size_t page_area_size =3D nr_thps * pagesize;
> +	char *thp_area, *page_area =3D NULL, *tmp;
>  	size_t i;
>  -	one_page =3D mmap((void *)(1UL << 30), len, PROT_READ | PROT_WRITE,
> +	thp_area =3D mmap((void *)(1UL << 30), thp_area_size, PROT_READ | PRO=
T_WRITE,
>  			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> -	if (one_page =3D=3D MAP_FAILED)
> -		ksft_exit_fail_msg("Fail to allocate memory: %s\n", strerror(errno))=
;
> +	if (thp_area =3D=3D MAP_FAILED) {
> +		ksft_test_result_fail("Fail to allocate memory: %s\n", strerror(errn=
o));
> +		goto out;

thp_area mmap failed and out label will try to munmap MAP_FAILED, which i=
s
(void *) -1. munmap will fail with -EINVAL.

> +	}
>  -	madvise(one_page, len, MADV_HUGEPAGE);
> +	madvise(thp_area, thp_area_size, MADV_HUGEPAGE);
>  -	for (i =3D 0; i < len; i++)
> -		one_page[i] =3D (char)i;
> +	for (i =3D 0; i < thp_area_size; i++)
> +		thp_area[i] =3D (char)i;
>  -	if (!check_huge_anon(one_page, 4, pmd_pagesize))
> -		ksft_exit_fail_msg("No THP is allocated\n");
> +	if (!check_huge_anon(thp_area, nr_thps, pmd_pagesize)) {
> +		ksft_test_result_skip("Not all THPs allocated\n");
> +		goto out;
> +	}
>  -	/* remap the first pagesize of first THP */
> -	pte_mapped =3D mremap(one_page, pagesize, pagesize, MREMAP_MAYMOVE);
> -
> -	/* remap the Nth pagesize of Nth THP */
> -	for (i =3D 1; i < 4; i++) {
> -		pte_mapped2 =3D mremap(one_page + pmd_pagesize * i + pagesize * i,
> -				     pagesize, pagesize,
> -				     MREMAP_MAYMOVE|MREMAP_FIXED,
> -				     pte_mapped + pagesize * i);
> -		if (pte_mapped2 =3D=3D MAP_FAILED)
> -			ksft_exit_fail_msg("mremap failed: %s\n", strerror(errno));
> -	}
> -
> -	/* smap does not show THPs after mremap, use kpageflags instead */
> -	thp_size =3D 0;
> -	for (i =3D 0; i < pagesize * 4; i++)
> -		if (i % pagesize =3D=3D 0 &&
> -		    is_backed_by_folio(&pte_mapped[i], pmd_order, pagemap_fd, kpagef=
lags_fd))
> -			thp_size++;
> -
> -	if (thp_size !=3D 4)
> -		ksft_exit_fail_msg("Some THPs are missing during mremap\n");
> -
> -	/* split all remapped THPs */
> -	write_debugfs(PID_FMT, getpid(), (uint64_t)pte_mapped,
> -		      (uint64_t)pte_mapped + pagesize * 4, 0);
> -
> -	/* smap does not show THPs after mremap, use kpageflags instead */
> -	thp_size =3D 0;
> -	for (i =3D 0; i < pagesize * 4; i++) {
> -		if (pte_mapped[i] !=3D (char)i)
> -			ksft_exit_fail_msg("%ld byte corrupted\n", i);
> +	/*
> +	 * To challenge spitting code, we will mremap page[x] of the
> +	 * thp[x] into a smaller area, and trigger the split from that
> +	 * smaller area. This will end up replacing the PMD mappings in
> +	 * the thp_area by PTE mappings first, leaving the THPs unsplit.
> +	 */
> +	page_area =3D mmap(NULL, page_area_size, PROT_READ | PROT_WRITE,
> +			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> +	if (page_area =3D=3D MAP_FAILED) {
> +		ksft_test_result_fail("Fail to allocate memory: %s\n", strerror(errn=
o));
> +		goto out;
> +	}
>  -		if (i % pagesize =3D=3D 0 &&
> -		    !is_backed_by_folio(&pte_mapped[i], 0, pagemap_fd, kpageflags_fd=
))
> -			thp_size++;
> +	for (i =3D 0; i < nr_thps; i++) {
> +		tmp =3D mremap(thp_area + pmd_pagesize * i + pagesize * i,
> +			     pagesize, pagesize, MREMAP_MAYMOVE|MREMAP_FIXED,
> +			     page_area + pagesize * i);
> +		if (tmp !=3D MAP_FAILED)
> +			continue;
> +		ksft_test_result_fail("mremap failed: %s\n", strerror(errno));
> +		goto out;
> +	}
> +
> +	/*
> +	 * Verify that our THPs were not split yet. Note that
> +	 * check_huge_anon() cannot be used as it checks for PMD mappings.
> +	 */
> +	for (i =3D 0; i < nr_thps; i++) {
> +		if (is_backed_by_folio(page_area + i * pagesize, pmd_order,
> +				       pagemap_fd, kpageflags_fd))
> +			continue;
> +		ksft_test_result_fail("THP %zu missing after mremap\n", i);
> +		goto out;
>  	}
>  -	if (thp_size)
> -		ksft_exit_fail_msg("Still %ld THPs not split\n", thp_size);
> +	/* Split all THPs through the remapped pages. */
> +	write_debugfs(PID_FMT, getpid(), (uint64_t)page_area,
> +		      (uint64_t)page_area + page_area_size, 0);
> +
> +	/* Corruption during mremap or split? */
> +	for (i =3D 0; i < page_area_size; i++) {
> +		if (page_area[i] =3D=3D (char)i)
> +			continue;
> +		ksft_test_result_fail("%zu byte corrupted\n", i);
> +		goto out;
> +	}
> +
> +	/* Split failed? */
> +	for (i =3D 0; i < nr_thps; i++) {
> +		if (is_backed_by_folio(&page_area[i], 0, pagemap_fd, kpageflags_fd))=

			=

page_area + i * pagesize, like Wei pointed out in another email.

> +			continue;
> +		ksft_test_result_fail("THP %zu not split\n", i);
> +	}
>   	ksft_test_result_pass("Split PTE-mapped huge pages successful\n");
> -	munmap(one_page, len);
> +out:
> +	munmap(thp_area, thp_area_size);
> +	if (page_area)
> +		munmap(page_area, page_area_size);
>  }
>   static void split_file_backed_thp(int order)
> -- =

> 2.50.1

Otherwise, LGTM. With all the changes in this email and other email,
feel free to add Reviewed-by: Zi Yan <ziy@nvidia.com> when you send it
out formally.

Thank you for cleaning this up.

Best Regards,
Yan, Zi

