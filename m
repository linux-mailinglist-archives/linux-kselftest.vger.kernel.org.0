Return-Path: <linux-kselftest+bounces-12379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 733E991165B
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 01:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0187328315F
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 23:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27301422B6;
	Thu, 20 Jun 2024 23:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IXIi6924"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCC7143737;
	Thu, 20 Jun 2024 23:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718924921; cv=fail; b=Wga68DLlp/1K9A2LjvMqq/JF1jjvuH8ipvMCAUlqDB/6RQhl2BMXCoHj0el+3D/xmVym3EpKwJtsyotpx/ECwKVRaq8J2gYwp0SyOC4SgyDYjVH3bin+p9a/WqqadqD9cFAZscwy2DCVIeIDGITF5SkVrcZWX+m/DDJ5ANyXI5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718924921; c=relaxed/simple;
	bh=zUuKcowhGZ4tJFDF86DbDZeUi7gVbM6SFtMA16Q0S7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aSP0LSNczaT/o9Gohpg+CLZMrQtTUTmrjwarmPY0MEdRi0C8tC6+UC82cpYbrWJwVTwB2ZU3nkvFamGqKLe4/rA6n/0lBBCQd1vcp/hHEAgjS3t2ELtxp6r4pZEMSKRrs2fbMMq8fnpWUGhmBUhMliWLPRVDzhOasWwhiEZptPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IXIi6924; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGVR6ewj0YTKjCBDdRq5zTMEcfkwC/iMcJiUxApZCehI8Bk6bxDL+eVSGQ/36WI2HWRfR0LHUUiTQCOjIfqXVhZ4dtW3arHlTqNVaHBCHRZSe8/3XtxVtC2TeEHTdvdGKE0lFKD8NV7FSjOejhY0fbjecYdUR6gxbwLauiEsnJSuOLFM3csRFXziAeNYFJnM0e0P2mz4L3b3wGrTkiSP5cYSknTksh6af7iOA5hK2I1D1U6l4Uwp24VeaUELEZyFDLa4FLreitiUfremHdG9UsHNQaHVOsEeg6ykzibI1ifipQu8ofF/sm2CdFrexuAPiKzCssVAhMsp68KKmKknNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dx/xakVctcrBGkjo+7LphDIIeuaGSXmfGXb0hIePI58=;
 b=fO/K4snYJhk6w0ITYmJ57PQ/+KPeLIJYsFUMWq5PE+3DmnJCc7EYk38KynxTG9QQVhlETLZwMnG792L7+drvEi2LkvG4UbNPAHbYEAy3CgXiHCm9HhKf77NAIM0my/6KpO7V9aRlWEUwM1EGWG5TY3MrFpDa6Tfoih7vAbHQjdS/BlBh6wuXmPSe7J/M3lJ9aBuUu5WmzQq1hBzt2L50Ded9ZesFNfH4X+K60WJzFfauz+Un/24aNsevG24aS6iJ6LIOTiaHh+brqcqzeYOYGWtGjvx4CyPDnkhJ65XgbSS/M2gl/GDqQ3cc8/3PON6hCVGSP5YRtAFn7SuKHoOouw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dx/xakVctcrBGkjo+7LphDIIeuaGSXmfGXb0hIePI58=;
 b=IXIi6924qbrPIxRp6JWfTPrvWyXHiYL2+4BwEHLw7lCuFqM/zTJal1en+doz/2UWWpUY+2071LaislF1hum10neDleTUNcNauTztAy6h5fYsJ6+6z1FPRKT20mGXR4mKdbcd7n34vh/GAJyl3JVoGH+rXKiJAOI+VzRGVRVrWvrw2+6ctRQln/TXuxccSu/9qRm6e3Q1zcuRhj445meDHQqa20gZZL8PUOfQ9nn27ur9pudnzeA75iZes2JdOSy20BXMLnXhYnprjnm0YyqHHaU919hmAYlR54bVUn+n40VXaimV6u93poOPuGDNb21zTkG2fGA+swT0HWJ/Fxl1mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH7PR12MB6884.namprd12.prod.outlook.com (2603:10b6:510:1ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Thu, 20 Jun
 2024 23:08:33 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%5]) with mapi id 15.20.7677.030; Thu, 20 Jun 2024
 23:08:33 +0000
Date: Thu, 20 Jun 2024 20:08:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Fuad Tabba <tabba@google.com>, Christoph Hellwig <hch@infradead.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	maz@kernel.org, kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, pbonzini@redhat.com
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
Message-ID: <20240620230832.GM2494510@nvidia.com>
References: <CA+EHjTxWWEHfjZ9LJqZy+VCk43qd3SMKiPF7uvAwmDdPeVhrvQ@mail.gmail.com>
 <20240619115135.GE2494510@nvidia.com>
 <ZnOsAEV3GycCcqSX@infradead.org>
 <CA+EHjTxaCxibvGOMPk9Oj5TfQV3J3ZLwXk83oVHuwf8H0Q47sA@mail.gmail.com>
 <20240620135540.GG2494510@nvidia.com>
 <6d7b180a-9f80-43a4-a4cc-fd79a45d7571@redhat.com>
 <20240620142956.GI2494510@nvidia.com>
 <385a5692-ffc8-455e-b371-0449b828b637@redhat.com>
 <20240620163626.GK2494510@nvidia.com>
 <66a285fc-e54e-4247-8801-e7e17ad795a6@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66a285fc-e54e-4247-8801-e7e17ad795a6@redhat.com>
X-ClientProxiedBy: MN2PR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:208:239::14) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH7PR12MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: c79613b7-bec0-433d-6f33-08dc917de856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rosQlgw4FI3h8LE755ToAZInWqsowSXeWV1JbfdJZp2NolXAXyfnC9tCsT9c?=
 =?us-ascii?Q?oja4UTpJqqcfXy90CZR2OvRfdkrFLvDbEJ7/MrU5ItEZ2kQ4SxKttRrhreUw?=
 =?us-ascii?Q?BCHavzZMVuWcx754HNi+6MpdWPLTmGwt8D8y9B2XqFSlJRBsfNb1KwFLa4MB?=
 =?us-ascii?Q?/Hp7vYzPk5UsNufsGX59X+1ouv4K66jyJ/aFDZDgDRfgPr69zVOmNrKrK0rh?=
 =?us-ascii?Q?khU7WUsMFFfj4vTmeg94/epcwTKeVELIfT39F6uPQgWzMd7iOYMpYsuHpoCg?=
 =?us-ascii?Q?Pkb+Nhu38uUaPKUrLcz9wQBGkzKPXbrT7cINSrnxQEYzXaw5ppndBpbbDuBZ?=
 =?us-ascii?Q?obK295eIR1k8TUzZfKq79RJLV4KnZ8NDq8FVJIPkCaKrfBHzHkJTA21w+s7/?=
 =?us-ascii?Q?aENgbEW4bwPYeoIPdFrx0DkozsW5mvoJRhBFnp/rn8JVN8lAlBTl0m8Ktcl+?=
 =?us-ascii?Q?96HlR1AUnh8ZtNdpUgA3bFotU9KpDVrQOccsCri1a+IQL6H+8uzcFKBtIgwd?=
 =?us-ascii?Q?s1olOhYqdBnN0ax4MozPiiBbvPpG0hlHmnauXV+Zw/Su/ZIhiqQhQ2n9YGuH?=
 =?us-ascii?Q?0M9bKbQfSWKogd+oXUM92j+n8nfCjwJsV9Umdie5shSbdXW5U/Vxaok7VUIK?=
 =?us-ascii?Q?kvq63E9opbftfLBj9NXR6g3A+Li8JPcKeiAp+k+TUVIolt5mHBUmF+jNMXGT?=
 =?us-ascii?Q?/x3VPkiCn2H6mdcLwW8OjA9D3c1H8C/msRpbBZI/JDn1el96NMySBn+SJ6if?=
 =?us-ascii?Q?5VAaf69Xj/y3OZfIy6aLfYffGNsEdVB1jWQLbx5DYfzSd0OafRmdz+Ivm30/?=
 =?us-ascii?Q?C3UPwTfbsUs7WU14R+E2eWQmN2Yy9/v1rOFmo01X4ISLpSeG2NhpO2qkiqIy?=
 =?us-ascii?Q?h2Yb+w3dgTQrPAwM3qmw3drzMBYLvc0QO3pBu9cZdIBT2q6FgE9QAjUx9c3F?=
 =?us-ascii?Q?U02+alviun0/rYknRSVknBcM+1rfYD8RNX+gdHPOXnNlnlvqxAIn0+BvmHAa?=
 =?us-ascii?Q?53NkHRtiLQjTTI7C9/H5vAYbFCbGPs4D0IwfEEFPG8KENbttCLW/QI6tj889?=
 =?us-ascii?Q?j0naMwYE4JOdxQlpZ3lWlJG+zRxzKZwovHqahX7+yj2TH60X7Svh9h9nB86P?=
 =?us-ascii?Q?tayyrwt+oVCb6aQLxELXOttMaRwyeXxu3H5k8YOe7fW7LYGiQb5iwyuFfTV8?=
 =?us-ascii?Q?nvyaa/AMOiUGVwEsRCd5hgARvalmr7DMiLu4vyfQB8ccv0qy9Z2lJL0Y71cx?=
 =?us-ascii?Q?g37ug6DbSb3QhvbUrkTmc4xFQkNuWXwZYaHkNp+fGfQUpqPISDIu4fO5IWDl?=
 =?us-ascii?Q?bn8e9bZjCD1WRFH+A15f0V49?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+1toM56qq4JNKmzXvnbZXnDi7etjUJl/tpiR5wEapvpShRlHxJuZ7xetC2HX?=
 =?us-ascii?Q?LSI6DLWq9XK2aZu17VbTRlhtkHrNKFjyIgjDSrkPvaCgHUAjG0wPJupxjC3N?=
 =?us-ascii?Q?Y3vTdMjvAWiBQmd/ssGSvxHGst8D9ETWoIQtNo7EPny2rfsYvaKFmA7aUQJk?=
 =?us-ascii?Q?d6JmRiRl2me+jo+7bsynasU7+WbaPMX1DFoWCdrj1+maPpBrUKITxtPvh+0d?=
 =?us-ascii?Q?ucTrAQrsxAAb5SAAMlYSWex/xy022OvKyHSpVV8bEje9TGwWJZxpqKuYfDZt?=
 =?us-ascii?Q?okSncuBmF9iG4l1JcOBxCJunWImvr/IUTUh7aQ83n4Tbv0vrmI+x0038evaA?=
 =?us-ascii?Q?IqqvIqkTcmsNlELewOsm97bfBi8IBH2uHkoeKSUbOQ8XhlsvOX91iuGFB8fF?=
 =?us-ascii?Q?7YNotIgO6hfM+QCEQod9FAQNK0NPweQ9N7qZ0kMnRLDZmxaBKFrfPFEW4khV?=
 =?us-ascii?Q?ec7DyXIry652AD6TdMI61fhbEwBlVX0cZDvHYDbkqYrDQ4JkbN1PFAxV6hhe?=
 =?us-ascii?Q?5bKB5GbbeANerjOwjqJujSPokqYOOPJ0DRZ93QQmP+l6HV+qZy3mwEF7FEDD?=
 =?us-ascii?Q?QQMcWRocKgmLuOsMXqWpWcqlHg54CjtlP5We9Cm7P/+o6sXasm+SMOdyZH7a?=
 =?us-ascii?Q?URblrzAEsAlqeOuCehnybnZmvm769DtzL1BAbTC/T1RrIvUhCKWM0yDu81po?=
 =?us-ascii?Q?qnky+IGeT9RTM4OVKvzyHoIM2iPGrnCLL9XxFYfATydPxjmaTv0f9fiwahNM?=
 =?us-ascii?Q?M0sMbjOqdmUYSad6jn4V05qftQ/JtXYmuoblmCi2VLlPRBc22TxviHMQBrgE?=
 =?us-ascii?Q?Z+S3UdlGeotwH/kHyZo9AL2re0g/H0mXWElUZF8kJBTESmpXXVL+ZwAbq2Ut?=
 =?us-ascii?Q?Jk+lXzJrziygawIwKOIYGL/6MOYTZTuOgcYtwuuJj7uiJdbOXYh/xIp1Gifc?=
 =?us-ascii?Q?vfNKadmtUPNlWNd/7KLdGwHIKIR6d4Ftqr37H4um7k7/ZI2QV4Wn+yDTP0W9?=
 =?us-ascii?Q?lYN1Khln/5X6bpwO2Hxz7pPzBjvpO71VlHXP8xdpn78w6OhYropnz0SgFkFt?=
 =?us-ascii?Q?snmESjwN3VGo61kU3AOeuJxRD6romSKBmAQ7qB3gishsHgUFIunuFLyBA136?=
 =?us-ascii?Q?NcDfRPNgThFLJdm5nCMudG/KL0mO9Dm7uwZ2TVVPV5famoekDKjsIsjYa+bD?=
 =?us-ascii?Q?ss18gUqff22/bfA6dn0N4iNBu+AboAJMsrzV/lgVrVZ7WuyGKW+5qgVaDkPd?=
 =?us-ascii?Q?DA6Gew6uHbCeAgjeoPKQI7pMvu8OcIIaj5nJCDb3DNntQAWr79t2YVkN7G3V?=
 =?us-ascii?Q?hS7/q0W0neJBlFf90la43pJe3oHhK0bVgYkxPTqmjNktjv9AJBjo021y+819?=
 =?us-ascii?Q?5OJjqTZAfaQzkFKJjLWkskn6OdigvHZA4nZQqGqp1uxw2JLKX6+/+FBmg07U?=
 =?us-ascii?Q?JNWkAYpEkoUNlSlaB3zVgoat1dQyD8/yv8PmLJzl/ltvk0rNkEqvLeMly3QR?=
 =?us-ascii?Q?NpjN+7sUBPC32iktmE+FZlIoGUU0w/H8qbI0CUKQYzCRD/6MxaqNUl8r+6Kh?=
 =?us-ascii?Q?MJ5oA9RVdG2JNONJ/plUhEh1o6Jhj1y43B9PCJeC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c79613b7-bec0-433d-6f33-08dc917de856
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 23:08:33.5766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqli60Mp2Sc4zBPbetNR8oETEdAtoH6j6Blw3UadouE835NI7KhgRxCDpbDhFjFn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6884

On Thu, Jun 20, 2024 at 08:53:07PM +0200, David Hildenbrand wrote:
> On 20.06.24 18:36, Jason Gunthorpe wrote:
> > On Thu, Jun 20, 2024 at 04:45:08PM +0200, David Hildenbrand wrote:
> > 
> > > If we could disallow pinning any shared pages, that would make life a lot
> > > easier, but I think there were reasons for why we might require it. To
> > > convert shared->private, simply unmap that folio (only the shared parts
> > > could possibly be mapped) from all user page tables.
> > 
> > IMHO it should be reasonable to make it work like ZONE_MOVABLE and
> > FOLL_LONGTERM. Making a shared page private is really no different
> > from moving it.
> > 
> > And if you have built a VMM that uses VMA mapped shared pages and
> > short-term pinning then you should really also ensure that the VM is
> > aware when the pins go away. For instance if you are doing some virtio
> > thing with O_DIRECT pinning then the guest will know the pins are gone
> > when it observes virtio completions.
> > 
> > In this way making private is just like moving, we unmap the page and
> > then drive the refcount to zero, then move it.
> Yes, but here is the catch: what if a single shared subpage of a large folio
> is (validly) longterm pinned and you want to convert another shared subpage
> to private?

When I wrote the above I was assuming option b was the choice.

> a) Disallow long-term pinning. That means, we can, with a bit of wait,
>    always convert subpages shared->private after unmapping them and
>    waiting for the short-term pin to go away. Not too bad, and we
>    already have other mechanisms disallow long-term pinnings (especially
>    writable fs ones!).

This seems reasonable, but you are trading off a big hit to IO
performance while doing shared/private operations

> b) Expose the large folio as multiple 4k folios to the core-mm.

And this trades off more VMM memory usage and micro-slower
copy_to/from_user. I think this is probably the better choice

IMHO the VMA does not need to map at a high granularity for these
cases. The IO path on these VM types is already disastrously slow,
optimizing with 1GB huge pages in the VMM to make copy_to/from_user
very slightly faster doesn't seem worthwhile.

> b) would look as follows: we allocate a gigantic page from the (hugetlb)
> reserve into guest_memfd. Then, we break it down into individual 4k folios
> by splitting/demoting the folio. We make sure that all 4k folios are
> unmovable (raised refcount). We keep tracking internally that these 4k
> folios comprise a single large gigantic page.

Yes, something like this. Or maybe they get converted to ZONE_DEVICE
pages so that freeing them goes back to pgmap callback in the the
guest_memfd or something simple like that.

> The downside is that we won't benefit from vmemmap optimizations for large
> folios from hugetlb, and have more tracking overhead when mapping individual
> pages into user page tables.

Yes, that too, but you are going to have some kind of per 4k tracking
overhead anyhow in guest_memfd no matter what you do. It would
probably be less than the struct pages though.

There is also the interesting option to use a PFNMAP VMA so there is
no refcounting and we don't need to mess with the struct pages. The
downside is that you totally lose GUP. So no O_DIRECT..

Jason

