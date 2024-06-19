Return-Path: <linux-kselftest+bounces-12198-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2A490E1AE
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 04:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8AB1C213F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 02:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAAA4D8DC;
	Wed, 19 Jun 2024 02:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OhHlIt3+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE103EA86;
	Wed, 19 Jun 2024 02:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718765099; cv=fail; b=soc3VU2NeG3UDmnXJZtD1gv0wGQjsolVbjOxIgjzCsqtXpXrn5wSjL21HakzeME+nf7WwZ8dhswSsYOQJSusWAmB5pf2UAJ9pQaq/ijH/JcUVY5bRMjjZulZyAOfGEJ2apZU7GTDrP0Qe+1eEaV0GkkuVTeJNxpHbXeRQQhV0qY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718765099; c=relaxed/simple;
	bh=Zi+o11eOZ7y3D34DOO00cK0UUjyE+oTk6iTXiJ/FZFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BaUqgO5jXjsiuI+g4jrAFDw3e5eqzIAKl+rLL5cBCjC7nX1o+KZptW1O2xnlZOho+ol/vN/0BufjZeCCyL2IDOmHWuNhHy0PIgnEaJQROUK0EqW1C3gIY7KfO0c1p/gbF0Ar/RLRTekHVvZENEro4Z6kCV4fgV9QzdlAPhAvGWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OhHlIt3+; arc=fail smtp.client-ip=40.107.96.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+0PkDwaQmByLaWSiyCPVeC1vGTfIgCoBMRiIAI6zmdHoJOjIGZoCMvFE8RES/OOfF6GujXa1Sxdh2DfHgTKptJRT3vHv+HXZFZkm0NhGQD3iAdzRJa0h6x5vytMLQjwAfnJWbggCHPz3HUA+DSnNOzmn/lYm39/Lec8CbL088Tf2s8NhkC6ec+4EZ8zW6aKjMJha+Ry5lvTJ6ysgTEFj3GKf2kqNsiA8eG95Pasex/a7lLAuAFWees8tJcTG/4SOt/Y4an3rdaCvPrr41YgYm3iEg9OCFDNSK10TA6WqnCClhiL9SuOUlVj5JsTKazjbWdJq9M4emTi/mVo8Ge3Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ad0uKldbHSRdpfrUj0H8hN1yLbTpKQA0NnwI5TmPxs8=;
 b=PcWhY9TdNLeS+DlmQnxPoD8Nd2Koh1jHotUKuLlYBWvCNSkAiGXxlr4d3XjbUelv1mIwyKJ1ghe7buXeiWOvOoy2O7MAij15zM2W125n5DiWRxQxUguAHVRWs2UiE/bT5crF+6izNdqWCu7r5N/A5Juh4qT9xkxVWi5C6uek0bz2OU4iHPq0qox7idQccOnNtsZUKtIsDZ3NMH8wiB3Gy8U65fsbhVY3ygdPeL6LN5yOF32HuWC3OGIR627AkR2uJtxOh7YxzqH9JiGe0/dhRuc/eFq5lDifVyClZwz79Dt30J8WmBVKEM70DyKbmUx348knhzskCyPbILERzbcRjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=quicinc.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ad0uKldbHSRdpfrUj0H8hN1yLbTpKQA0NnwI5TmPxs8=;
 b=OhHlIt3+KHlJ9BBA9xzFY57X3zHGtgBZBFoSh/lB6oPOUTqupE1L7FUfzKbdAQcfAxMoYDl0r3c73pM+4BSTgi1UYtLf//OvZXZary5fB/VDGs8OqnGYFqiay7RO6ft3fCSym6lCxshvJNxwsLJHB5NhtRd0qtozryiXTubSV0B9CR+8xFiI+xciNadfciWXQMW+ensfeBD46zSB3mYPvU3vveNFrlPU/cQ8ltdRfDm+DhGjvaRBPw67bkv7gDbpu2lz7rAV2UnMD5KJTzlx6TF7QqJnfxfP3Z1wAvl4kvdimjAeY7SRvG5dRE9EbOOjAb42pLLgtc3MV23aN3wCaA==
Received: from SJ0PR13CA0021.namprd13.prod.outlook.com (2603:10b6:a03:2c0::26)
 by SA1PR12MB7128.namprd12.prod.outlook.com (2603:10b6:806:29c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.28; Wed, 19 Jun
 2024 02:44:53 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::c5) by SJ0PR13CA0021.outlook.office365.com
 (2603:10b6:a03:2c0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Wed, 19 Jun 2024 02:44:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 02:44:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 19:44:45 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 19:44:45 -0700
Message-ID: <7fb8cc2c-916a-43e1-9edf-23ed35e42f51@nvidia.com>
Date: Tue, 18 Jun 2024 19:44:44 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
To: Elliot Berman <quic_eberman@quicinc.com>, Andrew Morton
	<akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, David Hildenbrand
	<david@redhat.com>, Matthew Wilcox <willy@infradead.org>, <maz@kernel.org>
CC: <kvm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <pbonzini@redhat.com>, Fuad Tabba
	<tabba@google.com>
References: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|SA1PR12MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: 2adedaf9-f419-466f-e9a0-08dc9009cc60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|7416011|376011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3lvc3RwUWVDNE8wQm55UmpuZldvRXZ1a01wTFNKa0xzWnRKbmVkRGVzalor?=
 =?utf-8?B?Nll6SEx4NFgvbXd4Uy9HWDZnQkZCWlRNcUdraElrbE1SeTBVQ2crZmhwTHo1?=
 =?utf-8?B?NXdkVFIwZVZveEVFNXBNd1J3cXppWTVNb0c4M0gyQkwvYVlEODYxMjBLYlE5?=
 =?utf-8?B?amZ0S3laemMxMWZsemhaeENoZEdGeGJSKzNYaEtLSXNLSWpJNEY1Q1BhTzNE?=
 =?utf-8?B?amc0MWRkTmdteWVqN2NaV01ZaXk5Q2VtMytZR3NnTzMvK1YvcmkrVEkyOTdX?=
 =?utf-8?B?dnY1SnlrYkRJU3RQQTJnQVNuekh5QjlZNHZ0MEI2UzFrNVRvckhFOUk4SEwy?=
 =?utf-8?B?eElmRGZGQlljdzd3WmFLVzZKY3FMZ2ZJakF5RjlnMGk5aVdocVB0VVo2aHFV?=
 =?utf-8?B?RFd3aWlWOE9hTmUyUEtCU2xHaGdFK2FEa2RYc2dkWEEvZ2VWdWpKT1VscXh0?=
 =?utf-8?B?cVZNaHlob25QK3Z5eWl6b2FYaDUraUdiNXRIOFJITzVoU3VJNGxGMGt6MC9t?=
 =?utf-8?B?bW5NZWxWTUdJUVpTZ1FocGJCTEJtempPYXV3RXpCREdqdE9zenZjS3M2d1BC?=
 =?utf-8?B?SzNHaEw4bGpSeTcrQnl4YURXTE1ja0tuVFFzcVVwdjN6OUdLSlh3UHNCblBv?=
 =?utf-8?B?RVpSWWsySkNHdHpwSk1BcXkvbkNvaGErYXFJNkt5U0NoNHN4N2NIRjBVTXlp?=
 =?utf-8?B?dTF1dDRPaEdYQ1AzOVc0WTVaT0twWWIycEgyZWVib1BhZzFXYzJ6M2I3YnIw?=
 =?utf-8?B?QWVINVlmaC9LR0ZNTnpOU0p4V0tJVXJSOWF2NWpoQjB2SUNZUmN5dWFLMWFP?=
 =?utf-8?B?TWFiVWd6eUZqdktiVW16OVVzQi9EbldMcU1hYnNTWXdMNTBCRDhIVzlwS3M2?=
 =?utf-8?B?ZDdKeHpJS2llcFlZNWNKTjZkVHZZa3VqS0NhN3loR3NMYjMzR1ZheG11b2Qr?=
 =?utf-8?B?SStuWWZSMjhmRVVrYldmRUlnWlBsMnk1azg1U0NaZmlYVDZwNVNQSjJpeU14?=
 =?utf-8?B?MnlQVUZYNzdqaDZzMjJtdzRBSWUzQXZZRFF4MkZNOHd3SGdNTzljOUhxZ3Z4?=
 =?utf-8?B?aVNPN0xqNDVmZFBZeFlZdzhyemg3TG9oUXFwQ2FRc1dlUVljdENHRFlRODVs?=
 =?utf-8?B?c2dab2Y5TTV1SmllVnZ0ZXlPdk5HUHdlTmRYcmFNU0lwUitYLzFPOCsvc2Jh?=
 =?utf-8?B?TWppbWdiV1FXa1lUOFFISk1PTUcyQWxnWE5hcFlvL0ZjUEZtMDFFTllWQSt5?=
 =?utf-8?B?VGthZUlHc1ZsWFA2dkJ6N2dUWFNFcGJhblNBTHo1ZWZXTHdydVBTcnAzN05U?=
 =?utf-8?B?NkJhVVZscHNzcGx2RkpFUFY1aUtzY0pQSFNnZWx6cVBKL1Y2YU8xdldNaW1G?=
 =?utf-8?B?Z01jVHBkMnpaM2tQd3N6dWxIcXhqQVU3N09GamhJSENNTFMzQmdibHZ0US9Z?=
 =?utf-8?B?UHA0NzhwY29mU1UraXdRMzgrTm5sL3NqL29aMCtTWXJqM0tpd1M0djUvdTRz?=
 =?utf-8?B?NWh2S2M0ODY5dEFhNW5mQXJxSktDdXJmS0FoSGNkRUNmY04yaUJsY1RXaWZZ?=
 =?utf-8?B?TU1PVk9NWmJWaytDclQ5WC9JbWpMWHdrOWxZRDcxbnJiRUlwS25Gcmh1SURW?=
 =?utf-8?B?cjF5ZEt5V0lRMDMvWHpDZ0ZOWHZTVG4zUGlPQ3grSXdVNW9Cdzl2amZWRnVE?=
 =?utf-8?B?WWJ0bldZMTQrbklMVG1uVC9pUHFMRU9OSkJENkhaQWt3cVd6YktTS0JCdm5T?=
 =?utf-8?B?MFZlYjZwcFZKd2ZGOXlsT0NjN0VUdTBjZnRocFg4ZUYyOTRibmszWjJvTkp1?=
 =?utf-8?B?YlZlS3I5VVlWdU4xeXZoN0tNcW9WcWdRbGluMUpxVmxZUlFEajBzcjdZUnVH?=
 =?utf-8?B?RlB1SmFsMk5PTXVucE9Pd2hobnV4UEhvdGNYcnFJc3ZDY1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(7416011)(376011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 02:44:53.7620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2adedaf9-f419-466f-e9a0-08dc9009cc60
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7128

On 6/18/24 5:05 PM, Elliot Berman wrote:
> In arm64 pKVM and QuIC's Gunyah protected VM model, we want to support
> grabbing shmem user pages instead of using KVM's guestmemfd. These
> hypervisors provide a different isolation model than the CoCo
> implementations from x86. KVM's guest_memfd is focused on providing
> memory that is more isolated than AVF requires. Some specific examples
> include ability to pre-load data onto guest-private pages, dynamically
> sharing/isolating guest pages without copy, and (future) migrating
> guest-private pages.  In sum of those differences after a discussion in
> [1] and at PUCK, we want to try to stick with existing shmem and extend
> GUP to support the isolation needs for arm64 pKVM and Gunyah. To that
> end, we introduce the concept of "exclusive GUP pinning", which enforces
> that only one pin of any kind is allowed when using the FOLL_EXCLUSIVE
> flag is set. This behavior doesn't affect FOLL_GET or any other folio
> refcount operations that don't go through the FOLL_PIN path.
> 
> [1]: https://lore.kernel.org/all/20240319143119.GA2736@willie-the-truck/
> 

Hi!

Looking through this, I feel that some intangible threshold of "this is
too much overloading of page->_refcount" has been crossed. This is a very
specific feature, and it is using approximately one more bit than is
really actually "available"...

If we need a bit in struct page/folio, is this really the only way? Willy
is working towards getting us an entirely separate folio->pincount, I
suppose that might take too long? Or not?

This feels like force-fitting a very specific feature (KVM/CoCo handling
of shmem pages) into a more general mechanism that is running low on
bits (gup/pup).

Maybe a good topic for LPC!

thanks,
-- 
John Hubbard
NVIDIA


> Tree with patches at:
> https://git.codelinaro.org/clo/linux-kernel/gunyah-linux/-/tree/sent/exclusive-gup-v1
> 
> 	 anup@brainfault.org, paul.walmsley@sifive.com,
> 	palmer@dabbelt.com,  aou@eecs.berkeley.edu, seanjc@google.com,
> 	viro@zeniv.linux.org.uk,  brauner@kernel.org,
> 	willy@infradead.org, akpm@linux-foundation.org,
> 	 xiaoyao.li@intel.com, yilun.xu@intel.com,
> 	chao.p.peng@linux.intel.com,  jarkko@kernel.org,
> 	amoorthy@google.com, dmatlack@google.com,
> 	 yu.c.zhang@linux.intel.com, isaku.yamahata@intel.com,
> 	mic@digikod.net,  vbabka@suse.cz, vannapurve@google.com,
> 	ackerleytng@google.com,  mail@maciej.szmigiero.name,
> 	david@redhat.com, michael.roth@amd.com,  wei.w.wang@intel.com,
> 	liam.merwick@oracle.com, isaku.yamahata@gmail.com,
> 	 kirill.shutemov@linux.intel.com, suzuki.poulose@arm.com,
> 	steven.price@arm.com,  quic_eberman@quicinc.com,
> 	quic_mnalajal@quicinc.com, quic_tsoni@quicinc.com,
> 	 quic_svaddagi@quicinc.com, quic_cvanscha@quicinc.com,
> 	 quic_pderrin@quicinc.com, quic_pheragu@quicinc.com,
> 	catalin.marinas@arm.com,  james.morse@arm.com,
> 	yuzenghui@huawei.com, oliver.upton@linux.dev,  maz@kernel.org,
> 	will@kernel.org, qperret@google.com, keirf@google.com,
> 	 tabba@google.com
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
> Elliot Berman (2):
>        mm/gup-test: Verify exclusive pinned
>        mm/gup_test: Verify GUP grabs same pages twice
> 
> Fuad Tabba (3):
>        mm/gup: Move GUP_PIN_COUNTING_BIAS to page_ref.h
>        mm/gup: Add an option for obtaining an exclusive pin
>        mm/gup: Add support for re-pinning a normal pinned page as exclusive
> 
>   include/linux/mm.h                    |  57 ++++----
>   include/linux/mm_types.h              |   2 +
>   include/linux/page_ref.h              |  74 ++++++++++
>   mm/Kconfig                            |   5 +
>   mm/gup.c                              | 265 ++++++++++++++++++++++++++++++----
>   mm/gup_test.c                         | 108 ++++++++++++++
>   mm/gup_test.h                         |   1 +
>   tools/testing/selftests/mm/gup_test.c |   5 +-
>   8 files changed, 457 insertions(+), 60 deletions(-)
> ---
> base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
> change-id: 20240509-exclusive-gup-66259138bbff
> 
> Best regards,



