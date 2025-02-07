Return-Path: <linux-kselftest+bounces-26002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED90DA2C5A0
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 15:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6C8169781
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 14:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BE31DE4DD;
	Fri,  7 Feb 2025 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sc1fNfyz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6887FD;
	Fri,  7 Feb 2025 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738938937; cv=fail; b=j2L6hkXxSi48/cv0gdKApVJ6a6DpL3ddOrqJXAaTSkukNd6j6fIOz+HS2uA1lZkQtVV2noGKIvgG11qXM41JU6XDVJWA3spHD7xxifIry9jaotpe8A9Jy3DpeE5bKCMIz7CT0wk5rg+j41Ul7ebU4UiYFgdTc83HDouqwajouRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738938937; c=relaxed/simple;
	bh=O9qNB+vXEHaVhac7utR9v8G+hdEYwEI1UVCO7ldkyzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YN7FRldlB82NaRqScGDMQOjcoBxM+1fZgIt//G+Y47FxfI2J8q1mKkH/bmVqjt5m4czRGmTp0ffBQH0FRbysmNEgoWB7y1fBJZ7LR6GOqnsnwRXuAeuAUFirYvPmFKVMQQoGGdlbVBGPqyQuSpPOx24LAvEyoBu2Jwr94C+Hiao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sc1fNfyz; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUYLX3DtezJXWbufpMkRHPJq1LVt+2Gt8efRqAecTtWS+HRweM5cve96bgKNNtrdUhCjJeN+pyzuIlTsuJ8JBypaVGysr268uO6YQJZBpnvrwsMp21FNgH78Zyew5hDOUbA7zGqJ2nhq3buF/mSub0KKEIza6uHJwagh08flGFASNvchby/KGYTaNgSE9VQvJEMaoMNHIRt4WFAntV0yEtle97tr9lXVe4Zx+SlszKUrYB9ZAvtzH2nwkW1eUS1Gf/EBmFNPnvHjHieo4n/CsJjOUFHNOJUwjuMKBkNE763FkIwY0VIdLqQg2Br49M9gKb/kFDpXIeNbI7qy7eA6cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkO7u7GwqgsDOEFJVuKabagI0ZloWAE93Pqg1yyIizk=;
 b=PUmgjHaZaovVZJA4wL+v3/CfMdgydtSFNSVx6B9tqeSQ2mDCygIYcIyXSSantE/ROIbqZ3hsx+qDlGpY3rCSsRV7CMPq7GsoV1ZQSRFKy+EVZxlLnK1APF7bzlMJbrxABtOcpi6YXKu5i5hhzjcVNmi/K9WlqOoB2O1TIa09jZuNzcwsvOVTPHiyM2LbiGGVApmIPlDGaC84Y4YUeAg1J2stOghCMGJqvmHjOa4TeScD9Sg3d3kheaQKYLSaB7HEs3khJ8MClqEUafr9ZDN26xJIW+mmb2XaKGGCY7fhyjEWKOOf1tAzqh3uqxQNQZs1B1jmEDRap7Qco8I/v+m1/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkO7u7GwqgsDOEFJVuKabagI0ZloWAE93Pqg1yyIizk=;
 b=sc1fNfyzyVo0a2xxcos5m8UBw4PLZfFHcwkdUHM23VB50Us8a2fbZ2eYL5yt/4IPJEYOFzbNLtUwf0W00n7V7UZRoSWWUUtvHabJKQfH9Qzkb7wb3xhSrHFi/EIyQX6umvx7xYgXOCvJAAWxCRc5heP4IuAlAK+d5GVTaVuG7k/LHMvvZ4WrS9N75zJA2WtTRiMAdNJiVDJ/7TBcW1/KlONCG2vnyfLEb+uxNdNieZgVOLYkwjZF9E+dmRR4Orh1GCCcrRThJkxWTkelFKmq93ryTQMpGim3Dm0LFp1uKammhJ2o3ZUdSp/yz6RCBaUDXZ7lFHiYFJjnw0D9Lp3oEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB5672.namprd12.prod.outlook.com (2603:10b6:806:23c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.12; Fri, 7 Feb 2025 14:35:31 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 14:35:30 +0000
From: Zi Yan <ziy@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>,
 David Hildenbrand <david@redhat.com>, Yang Shi <yang@os.amperecomputing.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Yu Zhao <yuzhao@google.com>, John Hubbard <jhubbard@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/7] Buddy allocator like (or non-uniform) folio split
Date: Fri, 07 Feb 2025 09:35:27 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <E4287DB5-7D0D-41D7-BC0E-F5F404853931@nvidia.com>
In-Reply-To: <Z6YX3RznGLUD07Ao@casper.infradead.org>
References: <20250205031417.1771278-1-ziy@nvidia.com>
 <20250206000111.6c54e67d1933f8bbc01a46cd@linux-foundation.org>
 <019EB6CA-0F4B-496A-B2AE-A3A553585281@nvidia.com>
 <Z6YX3RznGLUD07Ao@casper.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0384.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::29) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB5672:EE_
X-MS-Office365-Filtering-Correlation-Id: b7a05b0e-48be-4191-8189-08dd4784abc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?veQdLSy7G+Q8kuvR7Z447az1VT0S37PSwnjNG+lnDEUMpAMuWtB6E1Xwj0vy?=
 =?us-ascii?Q?aaHTycsNauExmVLtxJpg/c+9wb4Y+yOh9GrOQcAup2VW8XP3EJJoYAfue5Eg?=
 =?us-ascii?Q?+Z7U7UDKLbBAL5zz8hqB1XRU4HX4vpsbp01bw07/b+RgBmjqtheQvbZKWiBQ?=
 =?us-ascii?Q?mmwh0/glqfGkq2xMXuz2l/AZBxePC6ZiNZbHlaYHIVua1N1D6B41ov6t9V2y?=
 =?us-ascii?Q?A6jRucCBLHXOokdZ7FCUduWOXpmzwyYJODZcQ1c/YdGGCPIKar6BSfhZn3py?=
 =?us-ascii?Q?eEEGMOEVuoT2PfAkjc1fgG7GNQJjHWB3dwMu7TKSrvRan+NxaVKzUcfc8h/M?=
 =?us-ascii?Q?BSObPkbCu3/dZBWwoiO9BtNGvvdHEw23niyEIPQlneZ5WkwRxmYp6bdntqhx?=
 =?us-ascii?Q?eFUxY5Gx5W03IqkB2egAyTfhlvmuJxhrWSmS+IMMq8MFDls86vryFbQ9Y9rv?=
 =?us-ascii?Q?Oo0sJ0+w6DoIz5nViUq8F5/ORZpVl8iVUwZNMb41cGPyG9t1/BerPQBL+7q2?=
 =?us-ascii?Q?VARKoBJOB6CzX04b9hFUtlMn0HnH20K0tkuU+MfRlG59QC/0DMP/ikT+by13?=
 =?us-ascii?Q?n0GQs85e/b+h7eEMjnNzqTJM0ipuChxHSsUtzHrglr+kFnWG1PUvNYRNLXEJ?=
 =?us-ascii?Q?xET/hI/604ChV8+7fw3tZjiTVUQKCgALBZlg0Q0LwjUnSt+hAEZaScH1Kcwi?=
 =?us-ascii?Q?sA43cOpwlyC+wq3SZ4ze0a9bqB9TOc5f7FKwnTlXSEObZG2RN/Ci2GUwu8ux?=
 =?us-ascii?Q?cGCfhIWaEFktsZ/Z7C3ygTyYsFrQd7yNjUBBAS/I8Lu8KkxxvRM7BTXiygq2?=
 =?us-ascii?Q?/CdA8SdogTIxs2AsQyddJSvxzVTi5+J03FB3Qao+BtR1YdAeuvSWS6srJ3zk?=
 =?us-ascii?Q?DujtQBTYXg1UoIKdlMPUt1rS/gL1OT5tDHwlJHnp1ZgKtWpBO5np1X87Nin5?=
 =?us-ascii?Q?ks4tmEwSaWRlc90b60D30Pm2bYuC8YgX44Hpte/2Axdxz18EmZ//CCudG6mh?=
 =?us-ascii?Q?ikq/n0Cfj7qLkJV2xi1u7QUD3SWV95PStrN4+mycul9RcHKijOpH9BxyYY1w?=
 =?us-ascii?Q?9+qXGT5aHsQBN54Nu9RxDnsA5D9nm0aBv3eDTldIThBgtXyDrHrQXUL9/E1h?=
 =?us-ascii?Q?gbptx9In0CeVmBiNT90sW1Bcc/RDwZ7s6KcTgV7voJxnQCkPE/MIoqME9vi6?=
 =?us-ascii?Q?SBmiK2kmSxKN3DOk1qTgMAPxu6YuOJJnwXZyjV7qszXcqHkzxap5Tql1qr9s?=
 =?us-ascii?Q?xO1C0/btJ1Nrp488h9yrgx9neye69Ycy8P4HvncMr7Y3e9fEDcdbQDpXCWHr?=
 =?us-ascii?Q?NxBideNeQWhEvNHFTDjeMYPh53dw7X9raZeyG2bLm3QrfwYbEoO+eD0b6jK+?=
 =?us-ascii?Q?L5t8gE0wOLXzjD8Y9InNwPhhCHrD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kaHTq77T+yFIS87DygV8iQVUum0K+8+F0GmHatvKnUV0z9eDyT4qVe0qmK4Z?=
 =?us-ascii?Q?chQopKMiwqISTGEMO1bDvbqzu+NkpmK7rFpr0+0ve3BGaFw3MfRIKkjyCU1E?=
 =?us-ascii?Q?MKFbpyCtNuKPtNnlI4J7QV0lcDhV1mXEND6PPPyDkME9tLBD+gNh4f7IYZm5?=
 =?us-ascii?Q?1T8jbU8k4LD7Kn1GohGO9RgPxd2llDd30+jRvDY1YXINZ3CAgEqzHa/Zsq7s?=
 =?us-ascii?Q?ERw8FuzophlhuW4bWkumwL1fB2CwGVbO2/YT8cKi0wFzTeDJVpg7H+77IMNL?=
 =?us-ascii?Q?hb6qcQo/+ps8f6d1ne5QXxXZuhGJdUvpdT2CJGalDDEmvROzW6p95J7xGj12?=
 =?us-ascii?Q?Q75esrE9JL0ugasVPhHfb2Pn450exr7Epb7tOxx0h42uU9/lScqxmQ1YJnkA?=
 =?us-ascii?Q?5mzojv6JHJHwhU8KDRoCeVkmP9Co8pAPEPpOMvtSAdPS+Tfd0ciITYi95VBy?=
 =?us-ascii?Q?6Yj+32L2xDyinLultBOeM2cU1SlaNvumI3un6Zeuodh+/z9SSfHppQBQ1ZC8?=
 =?us-ascii?Q?ai9j73T81rPL1nDK6vL6i11kkeb9et+GikQOarHwIiDoSMQcjvum+F/9GPQ7?=
 =?us-ascii?Q?flzR8Qaco8jSMmIacLZAjn56mcQPUc7WG34nrxn1Hdd/4ZShqdkwb43p3oF3?=
 =?us-ascii?Q?ZJLiNt0G4gXNr97ouvVJuGOfMscn/NgqWvimnffG6ZXpo8F5Z3lz/tCmp+Xh?=
 =?us-ascii?Q?Jni1IlPgd19gug+01uuWP/8D54+57Y4ABPvUFiRo7atDxxNQCY5g5a2Wy4LC?=
 =?us-ascii?Q?hfJOh5PwaQX2FfXplwzGUocyXuAuZrDuuRKU0+tb8drYT4vRuPnlWf5kGfGL?=
 =?us-ascii?Q?iS21LDCGuc+auZEgPbsRPEEFkiPgiy6k9uItOWj2dUkpAGuzGZKfwhRqp3ba?=
 =?us-ascii?Q?2WlRefbzMt3ig7wbynN5gqx047tVCLD+3hQsvrYgz+XpP0ehZhpjZV0RK98c?=
 =?us-ascii?Q?nNlF2T4hViQLyK0SAAlzFh9aDCurc/TaMGsKhPOXMsnTAJNr05Toix5VfPEB?=
 =?us-ascii?Q?9mCjVb612YavR25HKSqe7BCU94ViqSpZkh0zJRsuEWuQHYj7wF+vJUiHh83V?=
 =?us-ascii?Q?YgdU03Zxa3w8iL0x+WWF1JPWFe5t3pT6RP9r81p+nRyHWT3OYd7RMURS15OW?=
 =?us-ascii?Q?m/0L55iXD/JY88AEaZTLcgt0yU+YadyGAgJ1VVskeWh4jSKwIERAuyQVH0pl?=
 =?us-ascii?Q?R1vdY5dOfTV4okZu51ZUaSlUAD5vPQtkIiW/e8aZtILb5EfhlcKFdlTuHM65?=
 =?us-ascii?Q?SqBE4+7De7OsW+tFRK1jC9GFpAbkS0vJEbZXePhqM96fQpddf61SeSwLB2Qm?=
 =?us-ascii?Q?g5SOjvxQOaITszbzA41+IqZREkX5s3fY5rxfV+ewvneJ0wp7nlToBsAFgkhb?=
 =?us-ascii?Q?e/Ro0SjtfMYJf4gs9zzfvjDW0PBoZ5gsuVz2bnOrGuSepI0DL94W2/uoZZw9?=
 =?us-ascii?Q?EQ3qoxB5rCmqRI+bME3vgXAmUZb7WIs8lV1mwyY+fZ8a4SPc7DNC1gsBc6Vp?=
 =?us-ascii?Q?mtGQQiKVhYNaRACtcY5kFmK17Beu/Yimn3CJtT7pthHzlSnGa3VyZZ48xpXE?=
 =?us-ascii?Q?TLMYJdGHjXjVoqDMP+uBDGx6iUlUSVqwVmjRyNZq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a05b0e-48be-4191-8189-08dd4784abc0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 14:35:30.0287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: saY3WKecrtv64uN3qXDdC/RtLgKEQGbLWlnW7n03vaK5glmPPDqnJItQf38ZbLkB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5672

On 7 Feb 2025, at 9:25, Matthew Wilcox wrote:

> On Fri, Feb 07, 2025 at 09:11:39AM -0500, Zi Yan wrote:
>> Existing uniform split requires 2^(order % XA_CHUNK_SHIFT) xa_node all=
ocations
>> during split, when the folio needs to be split to order-0. But non-uni=
form split
>> only requires at most 1 xa_node allocation. For example, to split an o=
rder-9
>> folio, 8 xa_nodes are needed for uniform split, since the folio takes =
8
>> multi-index slots in the xarray. But for non-uniform split, only the s=
lot
>> containing the given struct page needs a xa_node after the split. Ther=
e will be
>> a 7 xa_node saving.
>>
>> Hi Matthew,
>>
>> Do you mind checking my statement above on xarray memory saving? And c=
orrect me
>> if I miss anything. Thanks.
>
> We currently have a bug where we can't split order-12 (or above) to ord=
er-0 (or anything in the range 0-5) as we'd need to allocate two layers o=
f nodes, and
> the preallocation can't do that.
>
> As part of your series, I'd like to remove that limitation, so we'd nee=
d
> to allocate log_64(n - m) [ok, more complex than that, but ykwim].  So
> it's not quite "only allocate one node", but it's allocate O(log(curren=
t
> number of nodes needed to be allocated)).
>
> Makes sense?

Yes.

To remove that order-12 limitation, do shmem_split_large_entry() and
__filemap_add_folio() need some change as well? Both call xas_split_alloc=
().
But I do not know if they will see splitting order-12 to order-(0 to 5).


Best Regards,
Yan, Zi

