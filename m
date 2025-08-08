Return-Path: <linux-kselftest+bounces-38590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F12B1EC0E
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 17:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02506178D7E
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 15:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE4828689C;
	Fri,  8 Aug 2025 15:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a4WgzNnV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD5628540F;
	Fri,  8 Aug 2025 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666662; cv=fail; b=JmA6VfsWK02K92OqPsqHLeGt/JXbnlJpHX850Ta+kHIYpaTVLpuGBDOrMSvFJjkIQJOyyHo3ijWGu43r+K4iXGCXqJBKL8jhuAk9J5Ptg5bYXCQnVrAIrrlTGh+ZcPujZGmwuuotxTjLV6jT2aBZbEU3SD/5IIRNmnu7kdoduKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666662; c=relaxed/simple;
	bh=eVJixz0LWQrOslzJEloDUrLIsJNikwDKafk8MG2jnW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qZUtrwnt+NipN99HVFZCp4QmkcMV93jQkM6pYRIOgI7aQkLFo6dfchhG5ngcPbpUFd4KM+quG6Q39JQenPuhE8Pt3zqlgCaZy7gIPsqwcXECd5+9gWFy6B3JaR3ZAS3inYAjyuyG2NCUXyT9Nq2Pus5KITHILAAPb+XbdPj47zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a4WgzNnV; arc=fail smtp.client-ip=40.107.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPHWH0fJFcUNVDK7CLlVqUB/zkHQ+yPzYwWvrUcLak/l8ATM5OWwhYxwrhbaBtTGnledcsFeml0FBcVS9K9n+50H985zKISvUZ91f11/L9dNyjrmGBvOUSRtJTgRD4mzpXx6TO86zeJOZk6Q0jGxe/ZQhbPpVtOoCRKR1MM7024L+5bgy8AKzr758MqIHb8Np66Mb2OGn3/uUjki114HeW/hwcl/Ez21zvETLTLzTJSQN7PINAGN/W3FrDVL8ZPcd8ukZXAH1ZpTMCYELPQszVLAHtgbeGlBaIQ6lHU96uenYUsnTT4H20Yib5AjmzurFI/qtqFt6nt3cJmdegXziQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8DEojZtPQbrCElPjOdquyqfki8hgVWQQ3Inm+h1gkA=;
 b=QN23K4ZN3IxGxHXYy1y8vb/CKd+YcUJSxgN+/4EULtri11WhuUIMHccyMp/OpN5/mVduSjDN4rk9VyJwJ6gfkP0Kfya3FFIadqNEFTE4V5msYQ3nV037JnIIZH7X5/ae/YGTADUsnGw4AaKXUvrjYhU18SHW9xR3v8XOOdBO/xLx1mMIGpiK8S2h6n2SNTP7+cuYiGpaiV++imxlBQGZE74E6Cu9owpdvES1dgfo+DF8ia0taWSVC9TaxlOTng72u9l6qVw4imxA6DWLKUfyWCa2LLPZL9DDAGMuzNh81I1TDwGs6YPaQhwD8wbB5rrRFaWTk2Jg0Pb7gE6YV2IjSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8DEojZtPQbrCElPjOdquyqfki8hgVWQQ3Inm+h1gkA=;
 b=a4WgzNnVw3OFz3ZqFHTQ6SgRc/r5BHC5orIfoz+4QwJ7EtGQ+X2c+AT3Y7agCsF6s32IviIsed+gUhg/LZItGxjLPgx4dsQ3PhCTDnumt7POf2rt5V6hG7hU2D25DzSdGSVZinnFsiAWK5ROGtNBXEDiHCC0z8cSoPOrknjlzArmUbq/MMaTBxugH4YQ62/d5aLemrW8VsSL+7GwrCLTPtPdYrr9ZmVXALOGvsshUCvUaZS1olzZIEtgOVYtdr67YI7n7RmAIwZHDdNXJVSMxWWe6YabshRcf5Stlf7DrSZxCbOLJ46vC3p6BEYi6HeEwQDdpuKw5USfNeNZdqKCzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB7271.namprd12.prod.outlook.com (2603:10b6:806:2b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 8 Aug
 2025 15:24:16 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 15:24:15 +0000
From: Zi Yan <ziy@nvidia.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
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
Date: Fri, 08 Aug 2025 11:24:11 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <CD2ECB34-11E2-41F5-B220-860FD2C60821@nvidia.com>
In-Reply-To: <20250808031523.g76tmlghuaorjaoq@master>
References: <20250806022045.342824-1-ziy@nvidia.com>
 <20250806022045.342824-3-ziy@nvidia.com>
 <20250807085521.bhs2o6wk6pe7xf5x@master>
 <30CEAF42-ABC1-4174-8D78-C92B8C8AEB37@nvidia.com>
 <20250808031523.g76tmlghuaorjaoq@master>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0053.namprd16.prod.outlook.com
 (2603:10b6:208:234::22) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c0d57f5-96c6-4be1-3630-08ddd68fa2c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EOhxsiHFdqaKv2QsKhlOVeg+RNUxXgbpKISIz3kIclN7BPOcn2Y/NntyMbEi?=
 =?us-ascii?Q?QCjHpob68dC+qjxDXf0a4AzYVRVSHwF86FM79MJ0iovAUqgN3ohw1Lxf2Jm4?=
 =?us-ascii?Q?NDSQg+ddaioqOOkkCDgFsOGyziTtDf3KewbW/KcMpBWXvt4SLWV/WYC0x8Go?=
 =?us-ascii?Q?KGOt5ZyxakIoVtT0bMui2WH3yZpYOfa5Q2Mp6dWQXLm5qNo+ULh66yQtR8HJ?=
 =?us-ascii?Q?llMI4JR7K9FDPuYY/l1xQ57fFDYhmaZPzSGb6qBNtj99dHPRGyu07oxrSi1N?=
 =?us-ascii?Q?yMQHb0pJVHqsQ89/Xp4ViIZiGr6ngL+CSuyOE65aclWDBXEc9EsuNbajm55A?=
 =?us-ascii?Q?EQMAqA2FnHNUv8UyD2wq6NJCzF6+/ly1z5EaQLVJDB1B0hK+aDq3WFPE7kn2?=
 =?us-ascii?Q?OOJKPQQEYSkSMTrwgTSRHFSQBoJO2fP3n4Nk+Xw5Bds89XOnZqZoSqelLkho?=
 =?us-ascii?Q?gtxEDJs8EWrg/b85RQ1TZr1ub9miFfYz9GZ/yOXT7qdbOfBodOkEmv2pCgyV?=
 =?us-ascii?Q?zj3KZtBXAwPWQxX8ou1gwSPlKb1yp6HJFwrn37eYlBOmIu7Qc7XwbB1ZSDmv?=
 =?us-ascii?Q?DbPcSQWn9T1kWSQCwM2FzkFBpnSBRbQBAwpNUXzvN9aYtvoQpnOVBgzHu68I?=
 =?us-ascii?Q?aEufzk8zq75whSUuVeU6vj79keHxvxzJrgYuA1P+MaoC7uDpMOD8sq4iRgx0?=
 =?us-ascii?Q?GK9R5R0ldUdL3mMYW/AFxj/Ubry4bE9/odcs7CdzY6kXwaPF9MriyQKOUuYD?=
 =?us-ascii?Q?SDJnQ35SeyDv6oXLhon8gBJ0bukwCYAYVmH28qzHnui/rkZaQcApnJJF3YH4?=
 =?us-ascii?Q?HnSO87ZUsiOh6ViNfRDZhrzWav1VthYSq9GB+DmrwnXmNPolQv7sDbqae4Pu?=
 =?us-ascii?Q?RV3KI3gdfe+TBtsGnrwPF3Sy0FpK+lUm2lvgJbhpcsBcSRIRYxhZogbqL3Y7?=
 =?us-ascii?Q?TXBU5fCzrmAHt2AV0vDARtogYwfKFx47dm0O9UMwnwuskaKkz/ZxNrM04yrf?=
 =?us-ascii?Q?NJsC3Q7KzXtyq19EFOnkFV10OEXgiUPsz3+W4rQ/q7JkiixYSrfg+jhJYXp5?=
 =?us-ascii?Q?Ye0bxxug8qV3vj6wf8CkzuFU8RiQPi2bTpHEnyPkKT8tF0XCjY2AnLL6B9p1?=
 =?us-ascii?Q?QJ/YOWJTLn1aUi+RCxrVKz/BgGTuSAE9evnqNnnGVSjuIz4mJDij/T97dDhT?=
 =?us-ascii?Q?Ql9wTeQbPGweICk6ebfoKB84A+zzR+TO+UHUcYnv/IZI7nHAz4hfsCtTWH4M?=
 =?us-ascii?Q?Qk5EVyxOmgWviSOYE04NGjar8b5PhLwSeI6hAZnLcuLHsQlBaL/BhJF9tz+N?=
 =?us-ascii?Q?xYbf6NrwgHGl8qk/mhrckWApfspYB7s8UGZAYZXKX9+xZ4bzDsfDucpnSRnU?=
 =?us-ascii?Q?UjguKvKJ5rFmXUCosLLBnWaqcOVZIA6CpK18TstzPn/WbCMcWWsc4T3XSOMu?=
 =?us-ascii?Q?o4BDuIsN9Ek=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8YD6spOBWWGLB1vpxPwWD6lf78EmrVTAvGyhQAwvM2VdYOCrjyLJNkrUrRol?=
 =?us-ascii?Q?ORDRl7kN9NXaLlBVLYGH6HM86lxw7Ikyv0mlGaWSZBUJwfd2VpZsDpAM9zhc?=
 =?us-ascii?Q?d+QgNMk6+c3gNqckIDQdeprIo8HM3zewmQOIUKaP0p9LXtU+BQGh/S4Dneq1?=
 =?us-ascii?Q?nnJKZA+ReAkeX+M4p6Jhh26QqYWG/AO8dS3CMtP0Qvh9KQqVD/+fJOfbknRW?=
 =?us-ascii?Q?n18QHy14wvMloV299TfCC6b9u5hrDfYkvXcxF9ECeKOCCMpqouu2vjq778H8?=
 =?us-ascii?Q?oBYZF7Q4aPvFolcBY4VA/zf3emYmiktPqyvq72i3XVcPliX6LJO+bob8gq86?=
 =?us-ascii?Q?vtojlSvMmIC8dKuzB6GbwHyWsVEN6bMBr09rBhe4Gt7pcwafE2aQ5EMGCXHd?=
 =?us-ascii?Q?xNZ1xGnB+WxwDkrOVaZN1vfAGoHtv4WIhFpRto55HGyOe8vv44mtGARNp6L/?=
 =?us-ascii?Q?h3rUWMJKSrpz4ISa+GGf9kobhDXJraCCTUJeusPgNQ17Nk5NRIeKwDcroHkD?=
 =?us-ascii?Q?v9Mp/jiXVfFpjy7+xxRmV6OTtTEtHXSA+wbZ6mjjgAtfJDtc4AI1LUhOMdu1?=
 =?us-ascii?Q?pdrTBWIbmpKT444esBrHDDPOsKv1PzsgPmH+abpaY6YI7BoYtKkuoYDqmqe9?=
 =?us-ascii?Q?Q8KeyWgV5rFk1qqFQ3hwQnl9xnj01876HQJ34ZTbgWEd40VoGKq3Etw3e+q6?=
 =?us-ascii?Q?R2xttgAmp4JGtVJVB3VCMYmj39OoLa0HvfTq+EujqC1PHMQW2vpAHh1lL7Tf?=
 =?us-ascii?Q?dqgRQncE6H5QBEstABC2TkJsNY9C5Bim3xHWGnjNnDwpVOM3g2twc0G1GMlj?=
 =?us-ascii?Q?ruvSvNV0oqPSFqH+jsdWpS0iqmmmMpMKHs/dC69LgUuDdDXzTowNAK3PQTHi?=
 =?us-ascii?Q?fpvrJUiqcJPujZt55DveIkuid88Rn2x7EtiYZx3hshuxC7NVhkxP4nPP6vzh?=
 =?us-ascii?Q?HOTGf2GVKoCfSD/N1MwzwX4AQ/dGaI1jrGIHbAVgJ+Ap0vSQLcvlNF2jZejy?=
 =?us-ascii?Q?OAs6awfCSaLXIDqKVPU70Dc9AOQ/uf/liA51ooRhYcDwf/C3O9oIpDwz2L/7?=
 =?us-ascii?Q?cn24kgI90RslevsQi2IjOoYHKsvvbgtRIg5mygdqJSRj37r1u0L1vsKqvA1D?=
 =?us-ascii?Q?dEdh8muJS1ESFm/mDQFGaPaoUdKtSssYrTctMJdt7kdPLaCr7ZXMewbXUdEl?=
 =?us-ascii?Q?8uT/L5x4me0KniW2mXFyrk0Z3baUTruC2KJv6196tQp8JZ8M7lAOIjgJXxRM?=
 =?us-ascii?Q?cfa314S3L16vMRZQh0LIjD9Fsko4dzkk08RCo+jR0tfPS3oKmRMGpItV5XyE?=
 =?us-ascii?Q?vrj8yGMaaAVVB7RKJovbtv1imK8Fweg55uRBfqZjDGH7M/cNvw+z38OI2eQ9?=
 =?us-ascii?Q?yhma5PSvmJ2jYqbllS5R6tXnNppG2yT46LbVZB9ehZrJvuK32FJjb1PiHnEs?=
 =?us-ascii?Q?9J/BBbyaJhrwh/v7kvAH0C4RwP7czyYsXgH7Xp2+21fAK2CYvgRqcPeGbRZ2?=
 =?us-ascii?Q?iz9oxRDeYdsCmv5QIEZzBOeJkL4qdtrBoACceSNjSKZQHu0ecnOuceYSWpOe?=
 =?us-ascii?Q?ixLP9wIFDBTKyxbnRH4T/inNBjfwdF9y84U4e7WD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c0d57f5-96c6-4be1-3630-08ddd68fa2c4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 15:24:15.7276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q34bJydXuCBZmsdXM6s88uyyiqD4I0CB94eI2Mht6PxN53i6j0PKOZQFvehgYVmj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7271

On 7 Aug 2025, at 23:15, Wei Yang wrote:

> On Thu, Aug 07, 2025 at 01:05:09PM -0400, Zi Yan wrote:
>> On 7 Aug 2025, at 4:55, Wei Yang wrote:
>>
>>> On Tue, Aug 05, 2025 at 10:20:43PM -0400, Zi Yan wrote:
>>> [...]
>>>>
>>>> -		if (in_folio_offset < 0 ||
>>>> -		    in_folio_offset >= folio_nr_pages(folio)) {
>>>> +		if (in_folio_offset < 0 || in_folio_offset >= nr_pages) {
>>>> 			if (!split_folio_to_order(folio, target_order))
>>>> 				split++;
>>>> 		} else {
>>>> -			struct page *split_at = folio_page(folio,
>>>> -							   in_folio_offset);
>>>> -			if (!folio_split(folio, target_order, split_at, NULL))
>>>> +			struct page *split_at =
>>>> +				folio_page(folio, in_folio_offset);
>>>> +			if (!folio_split(folio, target_order, split_at, NULL)) {
>>>> 				split++;
>>>> +				addr += PAGE_SIZE * nr_pages;
>>>> +			}
>>>
>>> Are we sure addr points to the folio start?
>>
>> David pointed it out. Will use addr += PAGE_SIZE * (nr_pages - 1).
>>
>
> No, let me be more clear. I am talking about the addr in next iteration. I am
> talking about the addr in this round.
>
> For an addr in the middle of 2M, we still could get the large folio if my
> understanding is correct.  Then (addr + whole folio size) seems wrong.
>
>              addr
> 	     |
> 	     v
>       +-------------------+
>       |                   |
>       +-------------------+
>
> Not sure this would be the case.

Got it. addr should be aligned up to PAGE_SIZE * nr_pages to get to the next
folio. Thanks.

--
Best Regards,
Yan, Zi

