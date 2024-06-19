Return-Path: <linux-kselftest+bounces-12241-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0666590EA0E
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 13:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 072EB1C2190D
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 11:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211F313DB92;
	Wed, 19 Jun 2024 11:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nBs1qTUM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C14418C3D;
	Wed, 19 Jun 2024 11:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718797904; cv=fail; b=YZ4wqaU07ifAp9R6zOusadeRbsOk2fZEQ+xOAgtxu2dLUCTcIgjnasp30S97ZPDjfpbR1ByxxoEV9F3D+BPdbJdAAz1sCqwOg56mmjbJ2OevjrD/NDnROoyGeaSBaql97gmcTcN/dN/a7GE+X3Cn+7mvN0dfdqtsggnSWgLzcjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718797904; c=relaxed/simple;
	bh=P13/ES8NO9Fd0O2awZU7dPeH7A5Tig67/gZ6mTg39DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ji7mAuJc7tKnsTGobUAWBVu+J2z4/NcAgk4gDJbF62NOBCssPGA57A6tI+6MYOC2fvGQJWcEBexgqHZSksKnJ0d+RzbtoETFkDysRrHgT92NAqQWLBPwz5y1zyDHtsD3XQOUW359OdQ5AUgGjpv8C63rz3Ti6H3ra6gIEuIIsKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nBs1qTUM; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Db96CXhQcWsWwgMIy8pK8LJJDgYxjNDJ8NEuSjDXAB0XZut1QVrbpysnfRCBTVSctLZfLKctBvieeA0czl80msHAZ6Sfz+qamSf1W2Cuq55JMpqCzNu/7yIJSSPfDNup93fzRvWUqIFOx2CF0ve8k8BgH24a5RL+QwDvzS8mt4Z/EsOuc/Rv6e69zRdvMTm49GjHv8Kh8+3bkNVpqHsA1lM9p0TlqtVcKUell1Ss1rNNKT7tyxfjXRauFNvLEkX1k3m9IhidcIm6asUPe0AioSaYCO+by5qB4ICd7BC5u4F0EjZP4/Jn8lN8zIleBkBzk1LzH7n+BUFsD85PyyupiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VnvmEBejcXoYf6AThnxR/QA3g0j/e32c+aWuwDVhdQ=;
 b=mow0K4IvWwwUo59fIdp7GpXK4al4X25j4aha/bbVeq42FGqwW/YCLU1q9eV7pHyDyPpg9kpNQuW8nUbHku2jbSYmSUgdahBmNtGgFLKpPzzua6Lni9GzAuEqdJGeOTj+u90YlSHy7t1QfPpJ5eQr78InvzC0vGYBzyfKfPd698bKPUmSkxa7VCBqTaWChp0OvDd3zuUFeJVRXCX7ABol6DBRQ0EN6nWRs1DyTMELWYPv8OnvV7UArUK90vpUl6rqqf9LOE04XO6+JdgrSar8LNTHHyZpj0b1IW4rPDpUUMgqRkwEnZLK9eZWANkQSzUxnNUrWzEAEnYW8GHdE16YHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VnvmEBejcXoYf6AThnxR/QA3g0j/e32c+aWuwDVhdQ=;
 b=nBs1qTUMDijYx0k86O226cJZuthkrz2a3HaDQg/d1ulS8GnQJvlooakCMxLn5Qi8ot+dK9D+eF36K7iGkhmkFMLMXSKCJwTTcLZgp7dPCN5PS8ZTtmGaHClHQjXiS0863Z1KaB1Bp0BPmpVrVtdnxJU92Brfs4c7cZtiTg7FC+JPHAIKAa6P9NgglU7kfEWygGu4IXi7FU2czZYFf+0hbPNutig7GsrVU5rzDJioS7e5SqPsl7iy2eowwzQ3sUMkURRfQHJgNw3ftVAgXhuOQ/2/Ie9GvgcoKSRlN/RcBtM14urE04dNkqOH6tqqhoTWj+F0VNMZhniWlBQs0yefHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SA1PR12MB7318.namprd12.prod.outlook.com (2603:10b6:806:2b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 11:51:37 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%5]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 11:51:37 +0000
Date: Wed, 19 Jun 2024 08:51:35 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Fuad Tabba <tabba@google.com>
Cc: David Hildenbrand <david@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	maz@kernel.org, kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, pbonzini@redhat.com
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
Message-ID: <20240619115135.GE2494510@nvidia.com>
References: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
 <7fb8cc2c-916a-43e1-9edf-23ed35e42f51@nvidia.com>
 <14bd145a-039f-4fb9-8598-384d6a051737@redhat.com>
 <CA+EHjTxWWEHfjZ9LJqZy+VCk43qd3SMKiPF7uvAwmDdPeVhrvQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTxWWEHfjZ9LJqZy+VCk43qd3SMKiPF7uvAwmDdPeVhrvQ@mail.gmail.com>
X-ClientProxiedBy: MN2PR15CA0052.namprd15.prod.outlook.com
 (2603:10b6:208:237::21) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SA1PR12MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: f71f0a4c-274a-429d-07bf-08dc90562c94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013|7416011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vsoiR+QhNJ6ioRKB+LxkcoA1TZ/R/IOSr7ppVnEi1ykoI0pFYXXlpCDxulhr?=
 =?us-ascii?Q?cP78JvW06YGHigEXO8oNUpgWpWIwZWqWW7hqEDkCReNzST6GDwse3e0LQE5l?=
 =?us-ascii?Q?ZpuEdXTP6zTo+37RUVUrj7SZG9iMEsMYOOHI3SSgI8L42RAhej2m9QA4WkTW?=
 =?us-ascii?Q?nQkP9mTdsJtPu5tr8pa9gDWwvTLA6VJ83JIpKjyeYQz/W3H66gFTTqtQBDUV?=
 =?us-ascii?Q?Bj2yKeZTIUPJERN4Kz+WYtfSfvpzQUYZS37Z+MiENVw03cmu/TMJJ/rDXgOC?=
 =?us-ascii?Q?EJmkgTAQr5pXws4y/IFruJenHEBOaso9uaDnF3Pc9qh3lN+U/bP/pUsB4Gml?=
 =?us-ascii?Q?/1BpqqNVFwxnIRfC6FJmzCsNZXw+fIvq30RYVuBOHRGhs2L/0BHWjE+cBMMd?=
 =?us-ascii?Q?TWqXpzQmlYKeXbmRdSTWMftG2/P1avUR6sX88ZQnzntlQbZBuRPLMKrCj69R?=
 =?us-ascii?Q?TrV3P6tKkWWAzFSj4Hm7vw5i0SD0+LGUrgcHcBsF0oAP3ky1KccOL2EAc6LU?=
 =?us-ascii?Q?hDc+xjZ+dzoo15UYKSltw8veSy/qv2D/3bHq/molxpSgxZFVhzRexlqn0pkb?=
 =?us-ascii?Q?/+5f3HA0qPbGkW/3cp3LqW+eZ1xroAV8cgwnvOFyvMOhiqZ5aZDNpdSXJhsJ?=
 =?us-ascii?Q?98iwxW3SlNaolL+k97NSU1xUCtsFJfmErKeq6Gze99u2HA85YhQYYcmZ/4HM?=
 =?us-ascii?Q?sO4orKkCdrxBBEkisDy+9YND7aE41Mjhl1VtQS5BYjAuMim8+IDIlamvEv+f?=
 =?us-ascii?Q?QpcQQwYP6pLRy/+ilCVowrBkzdWiFD+W/5v/F0oseWWadEdyZbuD1b05Isrq?=
 =?us-ascii?Q?0ghTZNDKJ5n6x5ZVQf1vaDzzRQ08fiHMOrtQN7/NkW9sY/BxmuvRuJ9FesU2?=
 =?us-ascii?Q?e35yEw/CtfSlcX+p19MXOiX5aOmG+ES9iVF6MSYz2dXQZsOBp13swmijTOpQ?=
 =?us-ascii?Q?p6Dc70KWZLjxy13WgUg11gnq+T74HcCFc2ZMwHgVuIC/II4gPMRpoEzfqrE9?=
 =?us-ascii?Q?h7foLJTLXYwQkKs6H2Ufoo6/D9El0JhnxjLrA46nP3Uzyn932YnFMf7wRvaA?=
 =?us-ascii?Q?CmwXeVDXEfQ9mpt9V6TDDekes16C07N2CeP6rasG4JWWLfsYNxJD/6sluoFx?=
 =?us-ascii?Q?Y+5mz5Y53KlXTXf+NqM4XC208IFQqqMuW8HREZJe3j8To+sWWlEUJienLnFE?=
 =?us-ascii?Q?qKloUZB57sN8+VKD9aZQL/N3MWvGif05qv/95qchEF/WFm1Mx4p+GR4LuGJw?=
 =?us-ascii?Q?9Z73IlCbHbaX9MklTkHy2r5qjhqWdlb8bF31dAb56XiirEyych/h63++Mk2i?=
 =?us-ascii?Q?7w2xnonfE5Xx1wgX0YJ3StBD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(7416011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cndcAtldLk2J4tEIpzu80bSG9jpRyZ9BHFLd1WXyYdcj+M8909NjK5t8m2SU?=
 =?us-ascii?Q?2+7KNGUAtpZqynewh51jAhIsEHSlHbdRe3Ytt/aKMTbLDe5UjO8rxxkspOBY?=
 =?us-ascii?Q?yFGu+OOwIgnGNd8Aoc5Ukve4MzAvEo/VGmYNvEGatVkafHcNG0ugpt3vdEd0?=
 =?us-ascii?Q?+JDPM20cfsoJGA+quIrRSya9k64/Nf90bI8RfqSc688dyMnoa2kLytq09xNp?=
 =?us-ascii?Q?FlYWegh7Jq5t5m2e3EJddEdY6775+wVTzYdsdmYHNpFrpBuFNxdSnIpjNAiu?=
 =?us-ascii?Q?5+jjotRcjmYfGSWwxnzdz5mwJphq3+BXMtSLG7F9FE4zRp3IdGVlKnCxgLpQ?=
 =?us-ascii?Q?pzlzE9FmD/pzkMmPaOFKg5UAKQRBeiWJ6de1wwSqtvqMdCP5HVg0qcNZZcjo?=
 =?us-ascii?Q?Kr+uZqrkwdQyGx+R4txHezqfmqbeQLF4VqiewdX6KVzIvL0CqTPfJ79c5mWE?=
 =?us-ascii?Q?C2Ec2j8I/h34s0LntI8S/OEitRlSdy/M8tqUyUD7GmOXMn1An3xZ/JxD5Sdq?=
 =?us-ascii?Q?yfy98DvDG72J6gAKK3ltHuD1J6rfBtVIz94KPYGu5UQXpjyG3ISOnXba9WQp?=
 =?us-ascii?Q?MvPrNSS3YKeZZZj18u0ZIEk+/8ngrDBRN1FIdTYJ/+5iyVMK14Cgv6+S5/Ga?=
 =?us-ascii?Q?WxiIwk+cho3XVwp0XS6mjXaoI9ZSHG8OgjGIl2nsNvvXOTY/J4EN+gyupMxP?=
 =?us-ascii?Q?v6HndO37VOSCSSefxspLMcR8oHeMW/sY043Uh1eerNZYE2xftYj0uRXyC0wU?=
 =?us-ascii?Q?wMyZ9by35CFVx6z0IAG+gB2b3obqDNFQpcZmOvUi89CGQxcWKCXAbTYTB6l+?=
 =?us-ascii?Q?u0mFAPg9Bz5Rtj5eOEmvCIEVGDaCTTWWUgpl4iXmuPrRLsxve2X/XM6ugeHv?=
 =?us-ascii?Q?QZdKrWiOjskZFaUEwAgEnOQq6628DvjDZtV+FYMOBk2p9+FaaD2+vMLOh56K?=
 =?us-ascii?Q?OBONqFykqhMlpZ8NdOn3luV54e+ygO70vI48io9+iXcu/ywz5P7j6gqQDBs2?=
 =?us-ascii?Q?NMwXKmcJA4QHLuoF3/WCUowtVndvZVrMfJyX1XlAGwRAsgBZspPzvxWHXcZo?=
 =?us-ascii?Q?orZtCy+gxbh6On/AbnMEkC2dl9KcFlxnLDgdR1Ni5uYLeFRcRHlZADQTZL4v?=
 =?us-ascii?Q?hRjZIJpPDj6UQIrAlQ9GIAUsa5Zfwqzu+0CP9vQP2jSMwWyUI/+AuC3iBstj?=
 =?us-ascii?Q?FYVUbkIfDU2zzwTh1ctYtJJtUHZLwsfWP5yVp23trUcloFesoLbFGyIiBord?=
 =?us-ascii?Q?7CzKtQkTaKdEJ9A0V0Z8PULagFajY0A3BV6yRjTWwCT000JkWSm1ILajcWfS?=
 =?us-ascii?Q?NkHl/Oyi05ApZuJ5PPg9PALyZVb59RIgdspniQlftdGFnjxR3xxZmqGPotjv?=
 =?us-ascii?Q?X1Olhz4iHYYeiq1Ug+/a1idcoSLy+5/t56vhA6OiXUJonySYVq/E02gDbxon?=
 =?us-ascii?Q?OSm6WL5g7f20989lHKKo4MoGBB4m3F03Pu8tIHpbsIyuNrSGsTWFigtBu2wn?=
 =?us-ascii?Q?sAfOhiemEw+XvbVE9ev4PZIP6B2AjQXT8iwxpz8wH5dkJ3fFJvNJSt0/AdQe?=
 =?us-ascii?Q?HIbFzIInSClOpLmgCgJkqdAGUvENYcqSuVY0GJsO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f71f0a4c-274a-429d-07bf-08dc90562c94
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 11:51:37.0230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TU8oq25NI7LD54OJodTTIYcPKfP7RFQLRHgEBAEN0jwuB+TFmP9hFAD8ITeTQOwV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7318

On Wed, Jun 19, 2024 at 10:11:35AM +0100, Fuad Tabba wrote:

> To be honest, personally (speaking only for myself, not necessarily
> for Elliot and not for anyone else in the pKVM team), I still would
> prefer to use guest_memfd(). I think that having one solution for
> confidential computing that rules them all would be best. But we do
> need to be able to share memory in place, have a plan for supporting
> huge pages in the near future, and migration in the not-too-distant
> future.

I think using a FD to control this special lifetime stuff is
dramatically better than trying to force the MM to do it with struct
page hacks.

If you can't agree with the guest_memfd people on how to get there
then maybe you need a guest_memfd2 for this slightly different special
stuff instead of intruding on the core mm so much. (though that would
be sad)

We really need to be thinking more about containing these special
things and not just sprinkling them everywhere.

> The approach we're taking with this proposal is to instead restrict
> the pinning of protected memory. If the host kernel can't pin the
> memory, then a misbehaving process can't trick the host into accessing
> it.

If the memory can't be accessed by the CPU then it shouldn't be mapped
into a PTE in the first place. The fact you made userspace faults
(only) work is nifty but still an ugly hack to get around the fact you
shouldn't be mapping in the first place.

We already have ZONE_DEVICE/DEVICE_PRIVATE to handle exactly this
scenario. "memory" that cannot be touched by the CPU but can still be
specially accessed by enlightened components.

guest_memfd, and more broadly memfd based instead of VMA based, memory
mapping in KVM is a similar outcome to DEVICE_PRIVATE.

I think you need to stay in the world of not mapping the memory, one
way or another.

> > 3) How can we be sure we don't need other long-term pins (IOMMUs?) in
> >     the future?
> 
> I can't :)

AFAICT in the pKVM model the IOMMU has to be managed by the
hypervisor..

> We are gating it behind a CONFIG flag :)
> 
> Also, since pin is already overloading the refcount, having the
> exclusive pin there helps in ensuring atomic accesses and avoiding
> races.

Yeah, but every time someone does this and then links it to a uAPI it
becomes utterly baked in concrete for the MM forever.

Jason

