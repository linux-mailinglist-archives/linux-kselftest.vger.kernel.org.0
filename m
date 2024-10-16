Return-Path: <linux-kselftest+bounces-19844-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 821A29A08E0
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 13:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D97AAB211D5
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 11:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3649207A0B;
	Wed, 16 Oct 2024 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mdB5JhBB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D893206971;
	Wed, 16 Oct 2024 11:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729079862; cv=fail; b=EEw6M08V6a3mh23+oBjZfBcwHXHI5TOqjdFTAhV7fKJ3Wi9pCSibVfSXFjE/i8+SQS1h1hz8/ls2KRiBr/5827uzJBItPigRppLVNWarh4hgX4JNRnPSWIZ1nlfPjOxN1ouOm/I54yER/VK8V44JSZQIsFl8opGqiHb78Jsa570=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729079862; c=relaxed/simple;
	bh=EaKU5KHtbhevtq1O2jGIwCjNh9LIsxxIfzjLjfewLg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EWZwVqSyKp0pWFO+TkNssV7iwGZD3/QgQBYY2rBn8wtn8zyG+pD/kI8+2aBbX1cQiIX0WpSqoXaMg1Hm2XZ/XDnSmhS8nAPBuWGfo1Tbl35Htrjyliqxcovg2PNDrSrFlb2uz0VjG2GNoX7s3RkyzbrW4OhybglXH1URUcx67Rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mdB5JhBB; arc=fail smtp.client-ip=40.107.101.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MlLE3O87MQdhmEF6Oboco0KrZtkG/JeeySBsFU5E6bSqoGvcjVsjfISzOfVdsjOyQrQhsrL9EOLl/cj2ykZfqlodN8nY0eyAJ+ePN06cL1Gw0tIWwBVQ7lsSuOmgeWS3esXBORe42xUDWv1oUFM0YqrlW+Tix3Hj14/Ff35sFzo08pU0QflkjEef5aKUZXylLsiN86VcCZZRbdxzmR6eWBzJauzsaKBpa8QroSSYlquvk2xEjF1UBPmBwMV7TNGP02x6Jm6toSgK9ynWuLVne93ivE8I7ucHUSNx9V04iM2lTtDxWrQkkzhzsWw7K1H6+PVmicC4oVcrsCrNaMNspA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaKU5KHtbhevtq1O2jGIwCjNh9LIsxxIfzjLjfewLg0=;
 b=yQp5sbnR5Tlp155hltJpInv3kFL8Kvc+xLnWhQMfS3s5ubxJCPZHZhL0xBW5Sfd7JzU9U3XNTZ3u6cH0j9PlHggQrsFt6NLa5VZHtHd0Q7xlfDaU0RL90u9y3I2hw3JEYiZ1V3NtwL6TpKVLR4lKnH6owfuy6GKg3h6y1x+TEwKRIWvmq9EEZNFQytBON6kS1BqYP4/6YBBOaFi8lRTTctb+Do9NW0MceUGrpk45W1PaIDnnUx5lvAxVPlat0LBnJoAjtzUxXLQMr+ocOo+4FbTKGtoIaWCpAeFXK/G7fU91Ue91eGzo/WPSg6RWc5aAlE6SCCE8oYHJjM2LBnY+mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaKU5KHtbhevtq1O2jGIwCjNh9LIsxxIfzjLjfewLg0=;
 b=mdB5JhBBi5UPRAzz+lDY/7WqhxVIoF5FF6jvRbI23hcpa8DVot0c9raOXrJHDE99wRgGZT7wv0eR64yP2FHIq73te8i08Lqd/kHb2x22K/Yr8hgcCpnKmHds3vE1lWhxX0/kM/ODg2eefidRUFLsVihZ1aYnx1rpOSKvWM4p7/5ppkwGocP7uOTWeQP9wL+A5/G/Hs3Qo0h+JRKbWkKw1+IVdNa9REkxhVvge+Xh2P48d/xnTi/afsIb7H/ks7YIEvGEXWt8DSFRYrT0Eefm24nYINmq8E7kpSIG48ODjfYbDmkrCoN3/rq2g2XclpbUCHLTAJWwf0N2jgUd22GzfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB7549.namprd12.prod.outlook.com (2603:10b6:8:10f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 11:57:37 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 11:57:37 +0000
Date: Wed, 16 Oct 2024 08:57:37 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Vishal Annapurve <vannapurve@google.com>,
	Ackerley Tng <ackerleytng@google.com>, Peter Xu <peterx@redhat.com>,
	tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk,
	rientjes@google.com, fvdl@google.com, jthoughton@google.com,
	seanjc@google.com, pbonzini@redhat.com, zhiquan1.li@intel.com,
	fan.du@intel.com, jun.miao@intel.com, isaku.yamahata@intel.com,
	muchun.song@linux.dev, erdemaktas@google.com, qperret@google.com,
	jhubbard@nvidia.com, willy@infradead.org, shuah@kernel.org,
	brauner@kernel.org, bfoster@redhat.com, kent.overstreet@linux.dev,
	pvorel@suse.cz, rppt@kernel.org, richard.weiyang@gmail.com,
	anup@brainfault.org, haibo1.xu@intel.com, ajones@ventanamicro.com,
	vkuznets@redhat.com, maciej.wieczor-retman@intel.com,
	pgonda@google.com, oliver.upton@linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 26/39] KVM: guest_memfd: Track faultability within a
 struct kvm_gmem_private
Message-ID: <20241016115737.GC3559746@nvidia.com>
References: <cover.1726009989.git.ackerleytng@google.com>
 <bd163de3118b626d1005aa88e71ef2fb72f0be0f.1726009989.git.ackerleytng@google.com>
 <Zwf7k1wmPqEEaRxz@x1n>
 <diqz8quunrlw.fsf@ackerleytng-ctop.c.googlers.com>
 <Zw7f3YrzqnH-iWwf@x1n>
 <diqz1q0hndb3.fsf@ackerleytng-ctop.c.googlers.com>
 <9abab5ad-98c0-48bb-b6be-59f2b3d3924a@redhat.com>
 <CAGtprH_AiVJAd4rxKZBC9372swf2hW8kFfWG2y7zBdzCmpLRUw@mail.gmail.com>
 <a31b66f2-1f4d-4826-bd57-2600603d5e0c@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a31b66f2-1f4d-4826-bd57-2600603d5e0c@redhat.com>
X-ClientProxiedBy: MN2PR11CA0003.namprd11.prod.outlook.com
 (2603:10b6:208:23b::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: e48dd598-0d0e-41f3-409f-08dcedd9bab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3arPKAYOB/9UywTfA/T4B7S4VAT0l29x2aFDZUxEYB7KGyPGuigkAtZTB1Jv?=
 =?us-ascii?Q?7NWw5yUoK6QS0N9FBqOEICyDzQ8g0Rz8qUG2LSKb2nJZfQFZSgHknA34Scnp?=
 =?us-ascii?Q?MFjtF0ufoCu3t5tJUOOZVxWyXcylr2tLZrEBpg9crwYo+x0F6/Y0NRhxB1gc?=
 =?us-ascii?Q?8Urkx1dYh7yEm1Mu//dpbYOXnlLIBMN6BalB9g3jte+6JJ9Q1Hcc/89uNMZZ?=
 =?us-ascii?Q?I4NgU3/I6xDftiJly2x6WgwGsGzaEn4eyYMGZci5qtVUm4Gun+mKgBtxKZnV?=
 =?us-ascii?Q?qNWC2A/aV5RwdbPGxrzyBpb3QkHh6+mFJ9esLtnNX35BJo9+mxxScmC4Mtaa?=
 =?us-ascii?Q?4KNW9w1l1DSaMFxO+iCdc3OZ15nEOxVCpirquXrU93S/clml6m5xRBrFrMlW?=
 =?us-ascii?Q?G7UpT4meazxFJVKnMHRU2ftWOz5gRq0iQ2TGTV/fSgDN6Ze13jTEYJ5Z1425?=
 =?us-ascii?Q?wStuHchLHpEyk0UysoJHl4M3diAU2hc1kfdzSxBsvWja31V0pta4TXtNzlE1?=
 =?us-ascii?Q?uqL4IFO00OTC0WLKcXEWnHszwRcSX1vaAWkJu04t34H6NWYmVdyySKRMbrKQ?=
 =?us-ascii?Q?Y5VSMtVN1+ijskm0yemzXqcSerb3EAZemA8Mig1O+XBeQEoUwtQH+ien3z6r?=
 =?us-ascii?Q?kCyu69fd/JNINUz6605Pvu7ugxaH4KC9Tem2VxuqMJblmTBWJhdOStKTUKhy?=
 =?us-ascii?Q?ckydJBOKM4SzEhbdz/j9GhNnU9DUBumPceocI+i/oXFDCd1xqKDChllx0xaR?=
 =?us-ascii?Q?0X0uYQ4yo58LCFY4qekuwsamASmqDfMasNbbjK9LEjFaI1grSLWKVziJveAk?=
 =?us-ascii?Q?OWUvfCCENFm46PDYY/rJJwFo1n5xQSAtglOJFtNu6cgvmSpJa1pdB5cFtQFv?=
 =?us-ascii?Q?A5+Ir/ORkIPKgBpCi3XFeK6BjYvrsvCcRIOhJg7KlKANZXYqPMAwre09864Q?=
 =?us-ascii?Q?dIxfKgSXVWcsobxqMD4fsbFFK1iM1q5MF63HlOIekxFsSzlcjHadAnvt6PPc?=
 =?us-ascii?Q?An0TYJmjHAclF01qc7TkUO7YMQAZxV54NjqcWQAdXsffEW0rP0k9FYi9WikW?=
 =?us-ascii?Q?MShdWECBC9VfAU6OrNeTuky8qMt52tJhORXr+sESB7oHkYE6fv28XXYuyrYE?=
 =?us-ascii?Q?fAL7YXEpI4kTfdX3Z2Ehn00J0Ny1r0x2KosdOClZztMgACXS19qpMy7WQo9H?=
 =?us-ascii?Q?qPRTF8guZRUmrpbAg2IhOXCHvtez28UlAgQUCVpTTmLMXt99x5K41wDX+ve+?=
 =?us-ascii?Q?tyoU/3YBgpYpv8y7ukPMlhEl895H4thbxgBQe0cZng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?byvq3T9QhHLBbPUZ4JlL3gR2qO3/dChP/Jb/FPJCtx7pilNy54opXRvHgHgX?=
 =?us-ascii?Q?k0CsNj7lmRyu1RnHlfV4G3cuw9i52lSAUS5j17xDFFSMeCl/5MPxCR0eEaO3?=
 =?us-ascii?Q?bc2f+TbdsVgcB/ziNwNs0fnpdYM9nloOqANebnfGbrWq0Mh9HQB76MBmN4mo?=
 =?us-ascii?Q?opUCxlZ98Bor7UWuZjKp3UC6577p55t4S/7HDOmRtuUNS2bxjLGvT0ZDGDj2?=
 =?us-ascii?Q?0zYdPi4neWAoGY/we81SAFucBIXzXzmoC3uJqYHJrSBnBn9eY9PUx9kioDLA?=
 =?us-ascii?Q?ZhjYaQazLY0AJUhH3RWQ4ov9sqspkLkMzGAjmziFyJowXUt2E+4gXL7U8LWq?=
 =?us-ascii?Q?OH4kJVI9kYUbJ/leucdQZcENsBLgWzOxDk7bA+QHdTZRv58GPcUG7CTVxe5K?=
 =?us-ascii?Q?q88FMiVfadBl4eFkfmYMUg0jdtBpw0VaQPE4tNZozh7wVwMx4ye6bcDoYhRf?=
 =?us-ascii?Q?/+T/m+9/t4dlC8rgNNWvPTXRvibsQsbt6gTyvW7J+SO+weqJWR39DRxOBkml?=
 =?us-ascii?Q?2RqxlOOdSEZNUn6T0fwDGC72AFx/9d4m5V0QnR5nXbPLfe/CifrsK0iEFnXu?=
 =?us-ascii?Q?WQgEAO+pi2CgpyIkLCoVUFlYIKOYBU4BZaAi8HfzIsU4nadI/bQHax6mYU3+?=
 =?us-ascii?Q?qIABCN2vjxE1b0YK5NgSY64DOsWtiGlkDPAzfvGjRbRMHJmYvwalEWTd+RYW?=
 =?us-ascii?Q?wthTc8aYv6uayWnnGrvhPbrqeLU2AKB6NyYCW0uUyclr6Nno5AEWjbTz1nut?=
 =?us-ascii?Q?cvDn1+apc6U/MH9o+rLIKRdrRpOnRMRcrV6TZl3X/bc6y11L71qYQoEfYYoD?=
 =?us-ascii?Q?dNYRI+YVkZj/Gg1SyD/cYAU0gGrADjgPK1a/0+uTDwmFPlDCj7ROfkDkZc8+?=
 =?us-ascii?Q?M+kVSwNc3NZORFjUuJ1oxLhznnYHLu3iaDMIvvv2wlRla1b+yPJfk9D/INLt?=
 =?us-ascii?Q?uekyN+8vBWE1M3a3Ns1ilK9Zl3uscuJWVzqHf/L1+jr4Me1LJIHri4g56zas?=
 =?us-ascii?Q?eyvxetrOuecYUW/9NSInHoD0gQt1IMWPATVwK3H8mSbOW4E++I7XOHFjsjfA?=
 =?us-ascii?Q?w49Vz16eAFEx67ZP/qb4erYI+Oq9wvTW428WBIHnd9myd5TOi7su1DCs3xMj?=
 =?us-ascii?Q?hVP3gtFJ6zCYR3OAKg7ufVp/YS+ab+rEtLOH6uSIN0BNAnLSDnKQFNSkABSg?=
 =?us-ascii?Q?+qNWWVueljr2c2dVoNwtoKboDEsopLst8Tmf7aRwarICNenTP4Y60vm25ymd?=
 =?us-ascii?Q?1hL7SN4VgsAkTrWvhgsqtzWOK1oiquBiISUfW2CK+I1CxlE3VJ4lrSlWaC/H?=
 =?us-ascii?Q?VD53d5h7hMoQOFenY9BqFEmygcKNOAN0eHP0anPI1H0Pu/SNGD5BxGEchW79?=
 =?us-ascii?Q?KeCPJMIWCBhUhBRZlIaj8+UMJQMxfAR7mPuLae7qs+pVW0pqMMousXsmGcMI?=
 =?us-ascii?Q?ocHmomuI+DZyoZ4HupE+aOAS0Nhgx9NsLC5iXIUb0buZN+j9LUxyzlwl0rm8?=
 =?us-ascii?Q?rzuI3iYi8no42W8DeQKFpaDH7clqo6jnpKdMuXD5tWx5KM1c9EnJ2ihUasmd?=
 =?us-ascii?Q?FFs+PuJgFVDx+YmxQvw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e48dd598-0d0e-41f3-409f-08dcedd9bab5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 11:57:37.7493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kGhDnCB08FObo63D0UxJPfQlHwLh3B4nmqzioPvLatsFH7V7OBV5JQY6/wlyVriP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7549

On Wed, Oct 16, 2024 at 01:54:32PM +0200, David Hildenbrand wrote:

> Likely should be doable. All we need is the generalized concept of a folio
> with HVO, and a way to move these folios between owners (e.g.,
> global<->hugetlb, global<->guest_memfd).

+1

HVO seems to become a sticking point in these discussions, having a
way to make any big folio HVO optimized (and undo it) then put hugetlb
on top of that would be a nice refactoring.

Jason

