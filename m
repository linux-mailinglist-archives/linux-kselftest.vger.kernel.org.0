Return-Path: <linux-kselftest+bounces-12449-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3C09125A5
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 14:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42821F246A5
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 12:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858101534ED;
	Fri, 21 Jun 2024 12:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SHDKBhkz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF12152E0A;
	Fri, 21 Jun 2024 12:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718973562; cv=fail; b=ArtTmHcfh16KPJ9SGb/u2M0ZGw45JNmHPyIS+C7g6AHlDsnbZ1p97hh8DEsFoc63lXnhUnqCYPxU+n0IJRNjtsAZCK/k5qK/hD28SmsemJOJqhYNUZBC26WPSXNgZrbGlE6AL4NNhJ9JDhK/RkcLQ2Nsef5D4J9oG4leJkmrnOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718973562; c=relaxed/simple;
	bh=zWMw7GpQqa01CZzrq1ezJ0/YvZNyCOb14AFHPMbttcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g/QB9X1hShLsW7WL/cGcDsC8WHw+sVfgRVcJlwfx4/RhtQIV2dCnSopI+hXFhfRs5ca43+ihn7FIrZknq2ehFNKVbu0lcF7q1cURLrvns8wUWOLrSaxFwTYhB3zmcdhZfoMwj2/NpnvHeWrWq9uMhJ8MGz87bKRCzCutbPWjwh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SHDKBhkz; arc=fail smtp.client-ip=40.107.95.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZAHSbiGXY6Ipeju00oZ7s7L2ThmNpUiYniB9GvVsNMoC4N8/k1F/TDPWU3Y4ou7Eykxvw1iaiTflIF7DGXEe+GzgCycLG8Jcy0IOEH6DEfRapnJBX17q/vBKYfNoy1evrdLo4mBQNSlllPJApByMWEDWjwAVQ081zik9OlNQrIuW9odDDYnAMbDi3jXqVZRz0UXD3NgmanzlsGbNJD+iHk9h/om2eR+Fu+esxsE3hFJ7dN3AQul5Xw0UDqBow3t7jUeyyDSdmlZgitKGnchBnp3it4WE38yKdbTz0AWkTsh6qxDTpmY4PUcDw77XVnIz82xrYU6FW3HwJY6CoDKdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTEk9i3Qd7K01n3MeQdKUFaV5+05pL4LE6VcxGjn8Cc=;
 b=egIlUYvPcOnsPtgcdybaJlr6xn2qCf6lsEDfSIUGD8aME8h+JkMY53qicjLni/DybAW+ktnr+/ZeTtCVKcEHnUUvzo6AwxgKBZsazTY06G70EUqUc3/TQf+1+SKZ+opIzkrMoGwpsxjgS5qlDvOO0wxerqG5TiK9WGQOzOqUy5yYt3UAstAxUWtBIeqvVaM5C3ppd7uzY8jjKB/TJxY8djbUHI0f4vmwaC/zevTMELS0Zw3u2cTX20WMMto6zYTDcah8GYK6BiBtOnkCAWCQR07wSltqna4UOqvf3K0sQgfVXaPvCQ7lxZrJEcNRnCsflkwYq1WjCJ7eT+3Cen6e9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTEk9i3Qd7K01n3MeQdKUFaV5+05pL4LE6VcxGjn8Cc=;
 b=SHDKBhkz256apBtKpaM8LHYz5kE9JbWcsQI2tuurIDrFo2tR9R13/OplCTAsqSTwyyidMjWawyWaCY59MqAaMEhB/ZrWwqTENCI3e/a3ZM4DtrqoQ+lRgA3FcyktrvlABvmUsjPHH26euzFtF6um3Pae0csS8KybQn4As3IHfDX5tOxmB1hZ3QJrfmxU/IVnOOqd3f9iRhV7Da5xL8XTyZTESUsirq9gZfTiG+wK2m1r5i1zEc1MNhPEY2L2PUncLNcZyK5JYN6WwwwdnnUHOQicQa2YJkfD++rlwH0HWDj8ba4EcDRW2OG+Z4kU6n2O7BQqFMDnEX5PjKRlClmBYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SA1PR12MB8887.namprd12.prod.outlook.com (2603:10b6:806:386::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.22; Fri, 21 Jun
 2024 12:39:17 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%5]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 12:39:17 +0000
Date: Fri, 21 Jun 2024 09:39:16 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sean Christopherson <seanjc@google.com>
Cc: David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>,
	Christoph Hellwig <hch@infradead.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	maz@kernel.org, kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, pbonzini@redhat.com
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
Message-ID: <20240621123916.GQ2494510@nvidia.com>
References: <CA+EHjTxaCxibvGOMPk9Oj5TfQV3J3ZLwXk83oVHuwf8H0Q47sA@mail.gmail.com>
 <20240620135540.GG2494510@nvidia.com>
 <6d7b180a-9f80-43a4-a4cc-fd79a45d7571@redhat.com>
 <20240620142956.GI2494510@nvidia.com>
 <385a5692-ffc8-455e-b371-0449b828b637@redhat.com>
 <20240620163626.GK2494510@nvidia.com>
 <66a285fc-e54e-4247-8801-e7e17ad795a6@redhat.com>
 <ZnSRZcap1dc2_WBV@google.com>
 <20240620231133.GN2494510@nvidia.com>
 <ZnTBGCeSN1u6wzLb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnTBGCeSN1u6wzLb@google.com>
X-ClientProxiedBy: MN2PR16CA0039.namprd16.prod.outlook.com
 (2603:10b6:208:234::8) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SA1PR12MB8887:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c2ef56f-1d50-4615-bd4e-08dc91ef2a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|7416011|366013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DV03B4VV8jUcw4ciWC5h9Z7woVAzEG5f5yHdebWCBe7emoNGP/66GXly8W86?=
 =?us-ascii?Q?TathOIAB+dOwtUWhC97cH4aHRyPm5Ns6YnDieUdiAPeOC5UY4YvQozH8nlv3?=
 =?us-ascii?Q?/aUiWFvrZBz3kXM/kk3tTE7ngJjjSPuIfAYNw1GRcV0aO7eoxUY8yAbip32H?=
 =?us-ascii?Q?ZfWLvkeJleqlPvLhZWPbZu+xtaf+k8m/UaUQD904OFseCNjJsVM8wt2gEDxy?=
 =?us-ascii?Q?BTDSqqEqj2FD8sWJ21FyW/jRdR3Gdl91Bd6X6j/VVjV0tIZIBcnza4EQb8de?=
 =?us-ascii?Q?PV6U9ZT6WThe3V3SayyNm1XV8WivdHaT30s6n9aucXvDRFrMMpmzZvyGn0J1?=
 =?us-ascii?Q?vcfhR2mH3IjFpNF5vN0swH6gXMpXg1P6kLUFTMNWQioK1pXW8pdK2e52IvkP?=
 =?us-ascii?Q?37JKN6S4FJMvNB/6zx8MfqC6WPAysxnn7WW7LUTngRucy8HPSe5KaGGv95sT?=
 =?us-ascii?Q?dLd1XJE/spZRurF645z0yjcVRBCN65X8H+Bl6ZUDL3l+IJPhTNCbwI79zx3x?=
 =?us-ascii?Q?k91JRqVSl9rky2ktWOn+wPCWqUZPe6/QsdnzdFmjmenf/n73TzaljpIP7VtD?=
 =?us-ascii?Q?bkgrlNblVQ5e0QwJG0fJT4Pu3UELLVLdKD2P73g8LTa6oyHsXwyzDui3JJnn?=
 =?us-ascii?Q?PA+yCSgxfrEYPRTBqOHSAZu3/VFeb49ybyxghBB+iZQxxN9Zh3KpkpYo+I+V?=
 =?us-ascii?Q?n393bmAcGF0gEImEfeS2tilK+h3owWJcRu6lW5kO3CkiMABjTT0nOk9M6AQj?=
 =?us-ascii?Q?K8F+p5spHCGuf6beX1p+FlE0ldl+RSqz9YqxqXWToY/agBl/nltsJH6QnW9m?=
 =?us-ascii?Q?EEBu/PRQzusvg1WOyH6nedC5KZ3xZyo0DfQpIOY3zqIs1IZa/qEfIu4lvciN?=
 =?us-ascii?Q?GaFThRAEaM1dLuI4LwPyTpTLetBAKWm1A2i1J9gr8TJBz/TvYmlIu2aH9U8m?=
 =?us-ascii?Q?brMRBm9DVF+DgoP8riG/O/sSOaRPpJq6DWgmoV+QJDOJkALDC9gH825UZuz6?=
 =?us-ascii?Q?y6AGeLfNMviBwg8juuQGhPGb5bX/vNHel8C2x1wNpbADbVV+to8Ob1yn4WDm?=
 =?us-ascii?Q?jbBA9ohxv1QK5bAzodh7jXcbG/VPgvCIa+NsUUkLNE/VEij/xg5G4eleztiw?=
 =?us-ascii?Q?yHkzcgkMa1NBWFMj9/YCG5kODR+6X/BAfD5Q8u1qWfF8ByeR4502T7xD8/VK?=
 =?us-ascii?Q?xuscK9NWJ9dat7W22GE4PKQX/Syw1+NFOw+Mrrk1BATmF9z8hnhFWnT670e+?=
 =?us-ascii?Q?1yfqSupc3hRPY5SRFaiV6ws2Dmlai6BjoFJnkQ6QeOquaYBeyEgzp41JZNxU?=
 =?us-ascii?Q?rblgROa6kuHWW5tzFVfIY+cW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(7416011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TFUJZnHO+JfxvM3k66yftCRjwrHi1eTo4rFqowiWnI6ToCI/RgeX7KtiE04z?=
 =?us-ascii?Q?0cLmo4OZxQZwf4C9RND39Dy5j3xYDzIliSim5nD4aCUqIO8Q5NWEJc5fPhwl?=
 =?us-ascii?Q?KCQli2XRrfdQfBVtUnhm8SSVJhdPH71q2YbQJudzlD62VmoUZp5HLn11gI4G?=
 =?us-ascii?Q?jrT49yiTMFx5uZ2Q2+lIr2qw5kXjIYQtU74z+Sb7Lv9yHY+ceD+zTt8Jie6V?=
 =?us-ascii?Q?mkBmzt/5UsNTz6Mk3ic35JxTMoxFb7Sl8zWfJyjslblxZCMmLAadgU/3VWoa?=
 =?us-ascii?Q?+6c6cG2eCKPARb4ObBVWsxurmLDOU5EDmSe1IsMb8aMo9wjfy5T8XLu8znuz?=
 =?us-ascii?Q?TtTgrqGZuUurEKJMtd4qEfMkdFBlEzebCZNdYfs3QG+IjorLsxwtE2130YnE?=
 =?us-ascii?Q?DJjELS0b96ihCU9AjzHScJNz8p7unyAPoxDyZU6hH7PHr84hQwHKeX8V+2XL?=
 =?us-ascii?Q?uwOV+XNDkGCu5FNDjUvi32c2ZOu1wVuJ/zYlFWJGf7X1Dm/tsJVugnJcAhlE?=
 =?us-ascii?Q?lLhX0SlQrZoN231wU/WkY1g6pR6Aj4FAjAU/36fECUkFNwlj4IQrimtGiQZC?=
 =?us-ascii?Q?Ixatb4YnrNdgUh5TfybRo33qrqsi9/mH7RoMjvv4lvJZWRMymneJOCZMLJyJ?=
 =?us-ascii?Q?qNin2OdRCx7ynmq9umF37+/ACVpK0VISQMy6SabZxIzg7HLqTawxjKo76bMf?=
 =?us-ascii?Q?2n/39zd7nN3UWbh1kUZiUx3bvqL315YpVwCRUoY6GIl6VzmPAnymTy2cotzP?=
 =?us-ascii?Q?ev0zed3B4p2wvymjRhVXI79CM/GepTMrmx/K99ZGLqsd2o1yTjL5rnr+6eeK?=
 =?us-ascii?Q?JNRg+LEF/DPxxZBlPKifKl17EVtTNXYoa5MxhH9gL9mTQ2YGnqoosJoZvFMl?=
 =?us-ascii?Q?gxwxF6HTQO660l6Yn56grNuYgTXyocNlQsWNl8udI0mDfpe8XCmuDwd0Nykl?=
 =?us-ascii?Q?qnRZzQbKZCq5cbFWOuhFzU/J4sZ1+i2vT1iFNvbC1+AbAqhJuIkumcA7fEb5?=
 =?us-ascii?Q?mHEpnQcv/2ZbkIfOdaa/2nNI0Rt5i7hNe1HrAxUE6trv1tauZ4QCIXwyIGrT?=
 =?us-ascii?Q?OLMvimKFRhPBja+B+AwXnGL8Mm1YKkWCc1yvaqToppitS9epU+8sGZLzaVyH?=
 =?us-ascii?Q?hMAxmJIOuUeKFtk2rqcEmpGBO1LZL7GNOaf5kah6eqO6SgJROoJfkhoEi3gZ?=
 =?us-ascii?Q?4LVin7TqG7vhDE0qOOIe8Evmn2Fm+UFVRAc4HvPygxVZ7Xp1WH+T8cmbHVTa?=
 =?us-ascii?Q?F0dWmoejBxgVV7rYlUziLmjwbAFR/f/DESI2HesJ9Gu3yhQDXXxXrt27gSgk?=
 =?us-ascii?Q?fPWN0v8bYN/C/GCAGVuugg5yG7+FJA4d+Qoxda+m9QZzNRRzbekd8AH9hm6e?=
 =?us-ascii?Q?QFUd/e4PYmrGnVZGAWsmEO1HHe2JeKmM/mZHD4wKh5IynjxAWMP6bUXpoEsT?=
 =?us-ascii?Q?C6mcFcy4GeQD0e8H1ZmPvudC3yTsO/3R/NH1FqEAOKzcPl5bG7dAJlJQIAnT?=
 =?us-ascii?Q?VTA5182rJ1If5jUK0FDrCjqXJA9GRtMmlI2MLGx2WVAnag3zAmcpKtLHsZrv?=
 =?us-ascii?Q?YjA56auh2aYNkkThPW0UYzh1vEltwFFgPdFzfnN7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2ef56f-1d50-4615-bd4e-08dc91ef2a6c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 12:39:17.5913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r0fqYaLLp7jBa+xYhohQ7bh57KG46MzkI5PCZq86oc0OfbUpUwF5m2ynrETMC57Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8887

On Thu, Jun 20, 2024 at 04:54:00PM -0700, Sean Christopherson wrote:

> Heh, and then we'd end up turning memfd into guest_memfd.  As I see it, being
> able to safely map TDX/SNP/pKVM private memory is a happy side effect that is
> possible because guest_memfd isn't subordinate to the primary MMU, but private
> memory isn't the core idenity of guest_memfd.

IMHO guest memfd still has a very bright line between it and normal
memfd.

guest mfd is holding all the memory and making it unmovable because it
has donated it to some secure world. Unmovable means the mm can't do
anything with it in normal ways. For things like David's 'b' where we
fragement the pages it also requires guest memfd act as an allocator
and completely own the PFNs, including handling free callbacks like
ZONE_DEVICE does.

memfd on the other hand should always be normal movable allocated
kernel memory with full normal folios and it shouldn't act as an
allocator.

Teaching memfd to hold a huge folio is probably going to be a
different approach than teaching guest memfd, I suspect "a" would be a
more suitable choice there. You give up the kvm side contiguity, but
get full mm integration of the memory.

User gets to choose which is more important..

It is not that different than today where VMMs are using hugetlbfs to
get unmovable memory.

> We could do a subset of those for memfd, but I don't see the point, assuming we
> allow mmap() on shared guest_memfd memory.  Solving mmap() for VMs that do
> private<=>shared conversions is the hard problem to solve.  Once that's done,
> we'll get support for regular VMs along with the other benefits of guest_memfd
> for free (or very close to free).

Yes, but I get the feeling that even in the best case for guest memfd
you still end up with the non-movable memory and less mm features
available.

Like if we do movability in a guest memfd space it would have be with
some op callback to move the memory via the secure world, and guest
memfd would still be pinning all the memory. Quite a different flow
than what memfd should do.

There may still be merit in teaching memfd how to do huge pages too,
though I don't really know.

Jason

