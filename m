Return-Path: <linux-kselftest+bounces-6708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E0188DCB5
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 12:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B07297EE3
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 11:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DEB126F1C;
	Wed, 27 Mar 2024 11:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jqWV1w4J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713E886AF1;
	Wed, 27 Mar 2024 11:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711539637; cv=fail; b=bOUvl7yvOzgAmigjBPWCm0sQsSCcMb9OeRfxR72Bb9Uo4FMZulltLq+8zdaeekH2C1kALTauudejdS8YmI39qLN9zWpJo7YPRrsiR3rMflDRhAGCUndOFf4js04+Psb4jyZAgedhx8CDzKLurHMKY2C26Pc+1cKNXvF++iAyySU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711539637; c=relaxed/simple;
	bh=L8yM5bAEnoLa/uofoKOojU1hXsPHn0RfVeE9Tq+7NGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AZN4UQ/inFXI9NLX8D88lTk7Cg4tgeK9i7rJ4JnScY7ykGkEgK87KhKuvY9NsGuFZcoTpbUlTjxi+pZG0mkE3xo5ll+qGXUEGUvDaDysFzxOcCB3bQ/iNKQMP+uRGpNpFcQTONcxLqBqjGvMzjCjDLwf90THXFONXkoS3dk/d/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jqWV1w4J; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kd7rTmid0K5CZIJmj9r/c4LunDxUotws3o1MVsFymJaDGoc+zbGKn1MXVzKUFbjj7RXo4jQudwYj63l9MoXXCcNA4i9emtY9ahD2x2hBwUqmfFXgJ3AU5CLv1cEICeUX1r6VztjgCJ1sOZoXXUVr9sL6cOTFR9k/LtGrH07w4vvo5YfZq+m+WYVHGQdIunB/o4t0nZhnNMn2fUm5miuPjBPEy5Y5FH1nZUv5VmcRw+34W7QG/J+Lt6+ItG7+NzOml3a0MSW9UfrJ7FnbyoyLb3ahnjVI/8vysLH5AuTrb1uZVqx/r7v0HzY0PK4iCFABc4UMN7H+UPlH0PeBreGtNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LJ6byHNF2VmlVFbuwoPHuGJEgZtn0FpoRv+NiVeSrs=;
 b=erqALgy9DDALJVsum21YEo4uRizWOHalNDgM33DQT/5Za6TCWoAvebSY/oPwnAySlX0P0oo3HSkGIbrOC1oS6SwdNP9xnUuXhi6wKPpWlvFTVJjxtzie/992KwxL/ZBXoOF32fKd2KJv4FbZ8DxgKPResxOe/5nGQcW/ch62FRJpL/9KOMxrVCEK/OewRdi5eJBNtqEoK8WrxFE4fAE0a3YQPo61TeL5B1q0iSKACbkPFMVkdg/69VZH2HsEYTo2TOEg2Rklgujp0VUrnsBIwlABK+dRw6XFUOg37Yyd48S0UYYAiz7kjOTkMjA5kOO93TQ4sLgJiPZVpubbeCTUqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LJ6byHNF2VmlVFbuwoPHuGJEgZtn0FpoRv+NiVeSrs=;
 b=jqWV1w4JQ2IuM/0an+pIsZ+oSlh4dLwFvXdO34GisL5RXVNjT+tnFY9FoHvIAZ+QpW6ORcIht/q5AcNWQXArFHNSzBayi+yWSNaItAJwnSvsZOJTRNDydCU9QBl0jy5Kf86nJ5jz3thWt8bq+O+1ofp9iweJAWnahHCi2QIxEnml69Qm5ao85kOtAgHWSZ8tgEnGQC3mjkJPdmaNgz+84QfQS5PgEuk2ctJLsrarUDTDFbOrgela8xmlf7OoA6QkeMJxmHOldDNXhwR91tlIsmLej3xpVDbcM6OLuCkpPd/k5hvN6WT8nma3qA40BBuPg84f1kVy42NEbcxl926xnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DM4PR12MB5938.namprd12.prod.outlook.com (2603:10b6:8:69::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.32; Wed, 27 Mar 2024 11:40:30 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 11:40:30 +0000
Date: Wed, 27 Mar 2024 08:40:29 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>, iommu@lists.linux.dev,
	Kevin Tian <kevin.tian@intel.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] seltests/iommu: runaway ./iommufd consuming 99% CPU after
 a failed assert()
Message-ID: <20240327114029.GC946323@nvidia.com>
References: <0d5c3b29-fc5b-41d9-9556-5ce94262dac8@alu.unizg.hr>
 <20240319135852.GA393211@nvidia.com>
 <a692d5d7-11d5-4c1b-9abc-208d2194ccde@alu.unizg.hr>
 <cdc9c46b-1bad-41cd-8f98-38cc2171186a@oracle.com>
 <20240325135207.GC6245@nvidia.com>
 <f8e03425-98cf-4076-8959-d85eda846bab@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8e03425-98cf-4076-8959-d85eda846bab@oracle.com>
X-ClientProxiedBy: MN2PR20CA0041.namprd20.prod.outlook.com
 (2603:10b6:208:235::10) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DM4PR12MB5938:EE_
X-MS-Office365-Filtering-Correlation-Id: 59516d3f-030f-4cc9-6380-08dc4e52b462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rVcKwg8gjjji47c7h4So5wJ2ZOBFH97R4+FyLTr92TI+34crpMpMFh0nvRFLlchRB4ZLofJgR1gn1BFmrio81geHO8rTvTKuinUa/q89YXXArhvPGw6uqXnxinLWqOkeefaPEl6xBplnrgDMm0thmGDe8gpiPTm5YKP3TGZUgv1FLUzJiiK+wCkY4dIeL8wfbJoO/PmvN7cvEa1lolL9VeuYucW+KUH0gHl2fw+WCVu8TdFvYkC8N0YIvDUn8Kwwqkbvg03hVESBtc9jaTQeZGA4aBIvG73zStJcF0E+pXYnKejtC3gMgguE0e6MLSq0B1FHav7XUB83A0aeNY6syVZ6spRWiU8gU2+aXzGsYs6w21cU7Og2OW02WGoPWSkulUZbEB1XsDziM1G+lh/NH01nBm4gOqoBB/z9flgl1ORtYnmzCW2iaR7nMIpPOkuzZSEfj1JjP754aMPeOke+Exp9CqvCIzANdC40fzwhyM3hQQyXgEdA1dRiNsk/DWsR5O16qVvKbBL7l+egcuaNhTfi//ZPZBbNoUwtw/tgXVn4SeqNYv744BoE6mtWWBRXHMv03isTAlc7D+LsJlxxjk4i9RbX+WwM31j3a5IetZjaJaUaqHLV+z8IabtbAy+7IcFTh7C9BaGHqCbyVJy+CVuRxpFhBtmoEXT3cliuDVE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzN5UkRvSzdnUEtFQ3V4N3djTlArbmRySXBtQlNwL1M2UDYyTkVSM056V3pZ?=
 =?utf-8?B?N3JNQVZBNllkcUNDdVdQaVFiY2RYTktFc2ZVdnYxc0JxOXZTbDQybkR0YWtB?=
 =?utf-8?B?VlBXUnFJMEYxbC9oTG1MLzBrZ2RwZ0NjWVJNYnFpRnNQK3g5YitJVnRFbHBa?=
 =?utf-8?B?YjR0LzJES3RMRVlPT3Y0TnlaS3NXNDZTaSs2alBCN1RST3JwVnVlNjlCVU9i?=
 =?utf-8?B?MWdacE5rUHFkdDR1L3hHeXh3dC9mN0trR2J6TWNuUlFlOVh1aHI4Z2laKzF1?=
 =?utf-8?B?bG1scTRobUROZlZjTlFDckZMTUFLaVR5dzJBbUNZeWVCUEE4Y1VnV240TWs2?=
 =?utf-8?B?SWd3SXJUVEdIT1JEZ050aWxUVmVyREsyVjgxeWQ0eWZ6enB0OEJYSUkzTVlm?=
 =?utf-8?B?UCtudndRSGdoYlBVUllBNHIvUFZEZFVZNDVzSTRUY0RLemlYYUZ3cktoeW1p?=
 =?utf-8?B?bU5SVG1LYWdWKzJHNnFTbEJ4RHROWmRlWkxUZ3JYb1Uyd2N6WkxTYmttRHBZ?=
 =?utf-8?B?NHlPVzF2YWFwSTFNbFNjT2ZxSzQ2cWU5Z2J4cVVnS1JYMUNNNGpIUmFMMitw?=
 =?utf-8?B?NFJtc0ttWENnZk5ZMnNiUjZreWdudGNlS2tIYXRqMkthVEZKTVhNSTBwcVZK?=
 =?utf-8?B?SUJublUrd0dQeXAxY04wdHZyTXR3SUZibC91QTNSMGI4L3lodTRkNDBnUG5D?=
 =?utf-8?B?VlNoVk52dTN4UTh1Q01lTlcyNEZLYzBlc2h5eUNLZ2QvakFrelpVS1kxZDEr?=
 =?utf-8?B?aStxWTNyaVY0Sm5jaHExYlI2TVpOeUhWNVg4dkVJZFBUWGNnTTdqTnd4T0Mr?=
 =?utf-8?B?ak1ubWdMYUVHNFlwdC82N2RBMXlhSDJrTE9pQjl4cThlTWp6QVRtalhWSUl4?=
 =?utf-8?B?UTVFbkp6ZldtKzNwVUpLeGQrcUI4WHhydE92bUVWejBYcndiSXZnRFlXZ2lG?=
 =?utf-8?B?ZktzSWRxQU5KN2psZ09MQW9WNEZ3SFZGbDVBS016eUprRmhVaHA0c1lmYU55?=
 =?utf-8?B?VzNnQ2lKd0VIY0FYbkVvS3NuRTlDRGZwb0RjWG9OYmRMNUhrQ0xyTlc5ZGRr?=
 =?utf-8?B?VW13N0ZKb29CcWkxQ3VicG9LbWpMSjBsYWFuMGw4RGJldkZ5NE5oM3kzaktG?=
 =?utf-8?B?VytFT3RCZWU4VDBDbmFmY1VMdHZhTHB4Z1F4MTVmVEg1R1ZKczhGaXFndU5v?=
 =?utf-8?B?SXdaSHE5dFNyNFZrQ0hqUVZOY2tJSnNDRXlSWVhPRGpINXFMcGJlYkZ2Q3Nm?=
 =?utf-8?B?dzZadXYwYXAwMW9pRHk5WXloOGpHWkNBazVkeGxQcjJoTEVDNFE4K1NEUlJl?=
 =?utf-8?B?b1dTUHlVakFSNWdIR2Fna2E5MGtoaWVoeG52R0huR2xKVWtQYnV2S0FJcXN2?=
 =?utf-8?B?a1AvZXZBcWVlV25ickkyNmVldExDbWhNM1RLRHBlOWNyQjk3TkM3T09YTFQr?=
 =?utf-8?B?V1pKRzQ4V3lBbjRuaHExSlhGemE4Ykt2azRpSDZIR3dOZ1FWbWZwcitzSkhh?=
 =?utf-8?B?UFZETDhjbkY4ckRkNDM5Ym1HRk5lSmhPV28wUTc0Y0N4ZzZyUklQME5hVjNm?=
 =?utf-8?B?T0tjUTJ6VmdhbndkSzM3NzB1dHRZQlF3dGJqK0VzYVhtUjQxRmE2K0dhbE12?=
 =?utf-8?B?cTNnS2pLNE0wZERBVTlINDVaTzA3Tng1eGhmRHBTYTFLdnFtZ0ZXTWE4SVBU?=
 =?utf-8?B?SWd5U0FKdXczZ2VvTTNCZ0JJbFZlcmdHNW0vSVZ0STdPalgxZnV6VWVWd3p5?=
 =?utf-8?B?Mll5c0Q0R0NlOUw2WEpabXZabUt0Z2FQWitDc2hiT3pvV3RsTWlyVC9CL09m?=
 =?utf-8?B?aWZQcFA1WS8xb2wzZXhxZVpDLzZuMFZhMmtibnM2VWlTalg2SUViWGVPa1RY?=
 =?utf-8?B?OWs1eFFOemN4WTgvTDdaeUxpNm4xYzFrdmFRUExqdFIyTGNjcll1a281eUVN?=
 =?utf-8?B?WEI0V2cwRkNSYitWeE1PYUxVeDlNNGRZb09rOENMNXBkM3BIcjZLMmw1RWNF?=
 =?utf-8?B?L1lXZ2I4U1NaYW1GWVVTaEdBcVNRcEhGbnpySEdpNnFUSXdNN0hlS2RuLzcv?=
 =?utf-8?B?aklNUm5STmFRL05uQlRVWHBEVjNTQTl5YWYyZk1EQTNVbVNsT21TdVphc0VO?=
 =?utf-8?Q?eWgeS/WkodgJKZIuE/MMefn32?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59516d3f-030f-4cc9-6380-08dc4e52b462
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 11:40:30.1619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Khe17rxqiZFNdR/GsO+pQSbfkmCHzeI61k0dwN8CGDhyw4EItiCcn6CS68WV5Hd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5938

On Wed, Mar 27, 2024 at 10:41:52AM +0000, Joao Martins wrote:
> On 25/03/2024 13:52, Jason Gunthorpe wrote:
> > On Mon, Mar 25, 2024 at 12:17:28PM +0000, Joao Martins wrote:
> >>> However, I am not smart enough to figure out why ...
> >>>
> >>> Apparently, from the source, mmap() fails to allocate pages on the desired address:
> >>>
> >>>   1746         assert((uintptr_t)self->buffer % HUGEPAGE_SIZE == 0);
> >>>   1747         vrc = mmap(self->buffer, variant->buffer_size, PROT_READ |
> >>> PROT_WRITE,
> >>>   1748                    mmap_flags, -1, 0);
> >>> → 1749         assert(vrc == self->buffer);
> >>>   1750
> >>>
> >>> But I am not that deep into the source to figure our what was intended and what
> >>> went
> >>> wrong :-/
> >>
> >> I can SKIP() the test rather assert() in here if it helps. Though there are
> >> other tests that fail if no hugetlb pages are reserved.
> >>
> >> But I am not sure if this is problem here as the initial bug email had an
> >> enterily different set of failures? Maybe all you need is an assert() and it
> >> gets into this state?
> > 
> > I feel like there is something wrong with the kselftest framework,
> > there should be some way to fail the setup/teardown operations without
> > triggering an infinite loop :(
> 
> I am now wondering if the problem is the fact that we have an assert() in the
> middle of FIXTURE_{TEST,SETUP} whereby we should be having ASSERT_TRUE() (or any
> other kselftest macro that). The expect/assert macros from kselftest() don't do
> asserts and it looks like we are failing mid tests in the assert().

Those ASSERT_TRUE cause infinite loops when used within the setup
context, I removed them and switched to assert because of this - which
did work OK in my testing at least.

Jason

