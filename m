Return-Path: <linux-kselftest+bounces-12381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E46D89116A5
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 01:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71D171F2205B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 23:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3748663A;
	Thu, 20 Jun 2024 23:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="soktvMm+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC83C3838A;
	Thu, 20 Jun 2024 23:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718925503; cv=fail; b=d95BurlhGdB/YZkqyjXFtA1/dP4YXiO/sKgquzapunuJhoVlHapR42Eyezj5lA4JYq8Hl2/T/qWsL0QyRZwg0ueNWOyQlNQtpEoxPFmo+JwqFQJtiMbH9QwPmEdZhvIzd9Q2SQ4UJOmHxHRHFQlwl+SwydwK2vmHuSCzsX2GU8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718925503; c=relaxed/simple;
	bh=8JEETYAdS60YO2f4Ie/NnfUuadq6I70NMai3rIv7k2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cq8sUDmD4pnVMP8oMIFralBHzM34d79wqfEdKKXGtML+iqJkT5xqWEMYqgGywnhGl3LhB0foZFT1KMtQjMdjWNmkt2KurzGv4d+uKz1sGp8sfLkeSMpLgrly34R78ROvV0EE48iIhXkhEctrV0suov8fPJbmLvyMq6QYoRcy0nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=soktvMm+; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Azuasez8Tz4iE0kOdCDytO+4dB62J4/Hqe8bwhMEdoA5LU2sMJclyXHyz8dLfFXgodL0gy4JU3JZNpIx6aYm2n+p8KB1S2+tFCuB1qd318Su3pzApL++JZgSmlGC9smtelylJhnAH8/AB7QPN+uuUHsTiOEg/6Zz3jSTnSyXWP9MchxpeWkYn1R89bzkN3dJ78BIKjnH03QpSoHk0H/SNcGX3BoFelQQ1a6Jj0ZmqDv8JOuZf7w2m6ViAHGui4O6Vne3JUsTI7IWWq9qnDWVHP9vsoC6qOD4AhouOOjKTHmIOzAQypWmrB+Je4ij3wsnoeBeO8akQysoL/OtxXTtKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jP5RlNLT2c5iA6sWM+aTPNKb/U5iNVyL4yQ4RUP3xXw=;
 b=g6Gr+v5zwKgAz2djfQ7B97RGfCvQvTEcmyyxUbXezjzVjyT+hvaAlwpaQacRld2b1xm4yg8Q0JGj9hhLUV8RQjZJipAQgpo4MbrGi0ecb6dN6qa4SfsZZZljiykqzhD6rEqvfKmHUpuwA3kYrmu9v8sTgm+zlvCEa0Bph+Om+osVTX1U00Hl7Bw9WwUe5MTO6H4WRNaEyK8Z3PKcjwde39U37/9o4S3Vyyr+FRMNVR7DR4qMNKd2Oupjk0Oje6t2rCLX0eLF20R33eJLucwQMoTGaWUabZJwuMW++bNBBBZM84JTw5zEwK+zgX/QDbKX8IM5/mtIfGiHR/K5vbqldg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jP5RlNLT2c5iA6sWM+aTPNKb/U5iNVyL4yQ4RUP3xXw=;
 b=soktvMm+8io1JEvU81Xnh6N3OooGRN9HAKy6xissurrmMghtMR+8G/ZL+E5rBd1Kyj+x8flJpEKzzGjlu5KuBgiTef6w6lq89P1NycSNsJC4XCHJpQIR8MljAmZdNaCgQO8gffFkwaHRngbCyL777M3bYRCXgMhEkVFDyGu1o5vGmCmULAi7gfzwzhTVlEHOhrziofxXRoi/5NPfpH2PbjFotTQVVPoVKb978zQ53jsLLQ4n/VUPoWRvgh4sJGHvYTv7DUQI8g4QPMj4SH46atT65P0HUDgfq/sYfiviVRwr8YkI5mIhIC/9h7cFubWQwxgiUTxSaUZ/wL6Qp/CfWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MW4PR12MB7310.namprd12.prod.outlook.com (2603:10b6:303:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33; Thu, 20 Jun
 2024 23:18:16 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%5]) with mapi id 15.20.7677.030; Thu, 20 Jun 2024
 23:18:15 +0000
Date: Thu, 20 Jun 2024 20:18:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>,
	Christoph Hellwig <hch@infradead.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	maz@kernel.org, kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, pbonzini@redhat.com
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
Message-ID: <20240620231814.GO2494510@nvidia.com>
References: <7fb8cc2c-916a-43e1-9edf-23ed35e42f51@nvidia.com>
 <14bd145a-039f-4fb9-8598-384d6a051737@redhat.com>
 <CA+EHjTxWWEHfjZ9LJqZy+VCk43qd3SMKiPF7uvAwmDdPeVhrvQ@mail.gmail.com>
 <20240619115135.GE2494510@nvidia.com>
 <ZnOsAEV3GycCcqSX@infradead.org>
 <CA+EHjTxaCxibvGOMPk9Oj5TfQV3J3ZLwXk83oVHuwf8H0Q47sA@mail.gmail.com>
 <20240620135540.GG2494510@nvidia.com>
 <6d7b180a-9f80-43a4-a4cc-fd79a45d7571@redhat.com>
 <20240620142956.GI2494510@nvidia.com>
 <20240620140516768-0700.eberman@hu-eberman-lv.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620140516768-0700.eberman@hu-eberman-lv.qualcomm.com>
X-ClientProxiedBy: BL1PR13CA0166.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::21) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MW4PR12MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: 070151a9-9eb1-4392-d844-08dc917f4356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|7416011|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tJRb1gBsNB67gckDCGSB+JnAmdmBr4fj+g/Ef+xRadhUo8K7lE0wfjJqY24j?=
 =?us-ascii?Q?K+v3OZ2VSaMMbd1RjUfqZctxol6E+o6s7u204VzQSJBPSWFumYSf8hQ66Fpx?=
 =?us-ascii?Q?1CmuAI8F9Xmao3bLCSnWZW9JxZ/AZwJMIz/wLC4660KYSx5KqItR3DMHndse?=
 =?us-ascii?Q?brStZGFZ6z0ETXHtdlm4Nk7RD9M4rfgyo1yhGzOXKFkmG+m45LKjIbZdD31K?=
 =?us-ascii?Q?Qp/iyKxgFLQD4UpzT4dq56npRTw/ZUZRf8hlEW4nuwPajhiJ6YkNYoEb+yB2?=
 =?us-ascii?Q?cRb7zyZNcYs60yn6iyp/p1VHCKl8zRih0IiyRZIuCuDMAFExRxxidc0OQiAR?=
 =?us-ascii?Q?0557wwH4JR2VIHjYBOSznc88HnSfuR5shTO71lkt09H9ha/RRpXlUBGa+gLy?=
 =?us-ascii?Q?29BRpoIXflr1JGeHx1RWGwR7dUOkAPPhnujltixM0uRjPu8kycxVYBye5i1i?=
 =?us-ascii?Q?JmyfayssKPR684zCtGRGlKAt3buXwjDgcqpDhMiApIcbFc7CoWTVRHoUv0Iy?=
 =?us-ascii?Q?EDNJuAfdMXLp1fs4a3P00ftIqYZ4GhJKW++13UVlFlGnJIU+SUjO7ej1r4r6?=
 =?us-ascii?Q?e/G5LNim70IzQGsEcFjQDUFzBYexzj8GHdy85jjtczxSIp7K1QAc0Db97Sny?=
 =?us-ascii?Q?rWmIqdXlJ3j8MQWPk9u8VrO/qfHHK9nqHtgZBpZQ59HAeBal70SH2MqZS9se?=
 =?us-ascii?Q?oZAvN3HGlkfvf6+Xw5+zXol7vRCjXECtScsUEMxDKARf5X/E3cUKcMR0jQCJ?=
 =?us-ascii?Q?bG41cRPQCoYFsF47qUFxDIisXlOZ0AMPXAIC9J0Ep4I2pcXs20inHuae6gaU?=
 =?us-ascii?Q?tdi/XbkKjDmi1P4muoKfufKe53WVroFTkwVMAyKk/aOXIt5kz1zKv6bVUJiI?=
 =?us-ascii?Q?466mBcs0TvW4VXoNgN+XWT8AXsPznlKpZKhnBy/pqWUzx+8ooIt8p9hDWzzT?=
 =?us-ascii?Q?++LVQHnxVFM3lgegf8fLuKmwb6hPUKMVtSRK1HeGBFNsexydFKsU4Qr9GkwJ?=
 =?us-ascii?Q?F4LoLrVgsxSyfdmjeZhaRCi8YqysLUcrfX8SU3fanSc4p0ZKfUqvFYrV7I0A?=
 =?us-ascii?Q?ULXx/EzZ44w1xKVo7B4I+KRe9klTZ5Cleqg934QS8wZ0gXTmDFTkpuBClwKa?=
 =?us-ascii?Q?To4AimGXtuIsQYfGK99/kvxsz4SgqQIw94RQJ4dGUuHMmE/5xNQskd7Wl0Ep?=
 =?us-ascii?Q?a17MZFjPHi+XsRh/Z7OpaubaTIxlBj7zS177efQasW+BiwaD2/r1qOQKevuy?=
 =?us-ascii?Q?6F+8saDXW2+M3Wyn1/O4SBCIgH1LnKS6E1LCjOUNVMlkR2fzYUCmI2nukhEw?=
 =?us-ascii?Q?hy0Pb//tax+BN+CfDepxnLMH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(7416011)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QVwwQuD6axeUkyVGTCacpSzjkSrgtPuWN7GQWhGF5t448KCvUwcLEMFt32DD?=
 =?us-ascii?Q?jYv55XQvfx0kpY3p8wtga9Jfb4nhRP6zwbz9mu/gWsdhoZHiTC+y3eKEYz5n?=
 =?us-ascii?Q?q/DwUmxOHyk+0BWgGUhB0DYI5VaSa1tr4lFH8UTm3a3toyHrndMmbGCKAO23?=
 =?us-ascii?Q?vf8HuuOpuo/kG7kV5ajZoiFfWmNCzLdJStxNUF83GdaMzYERWoiRzPEBzI9E?=
 =?us-ascii?Q?i0b+omr4jZxgfF2pmFBGQS1X1kAtlg265Qcjd9J28hrmibYXpotB7hk/b0aS?=
 =?us-ascii?Q?tIxaqsCje4QfyxIkOnEcp5IBIu99niD/+mBbV14NBw8BdkE8QLykAFiTlpn1?=
 =?us-ascii?Q?fpDjCrtC4IvxMmSH22+8RywMfKS/pw5kH7rDoMfzbMsVpL4Wmy59Zbmdb+y4?=
 =?us-ascii?Q?Xj9oIV+tRci595TSngpmNO01FWzn75jn4pqacJg2y5Uz/nucxY1PEKk4EGh/?=
 =?us-ascii?Q?ez3MkJ5bW4G9ZIWftnU2Ip/tAJOHOnHM0Cl76MhBvQ4QuoqwtEDREbNGZX0p?=
 =?us-ascii?Q?/sd9eEVODQ9OBHs67m1yRbSKrSaMYc9gCc2PJxiAkXycp089g2EZGEBTCd28?=
 =?us-ascii?Q?3Znr4VAnyJFiQQHkgE+iCThALUR3JbMWfKF0KVDen+QsrIn4DfoeP9FjoBK5?=
 =?us-ascii?Q?fNMFmHkBWAiYB6Lz6IMtdvYlqtsaYC+gh6BNIjdxZaXXE4NonyFKkBJukt58?=
 =?us-ascii?Q?XkOTrZG14NhMa/xHh2+IekFSJnR+mknughUZr2JkmQontWqbuiE8VDUErDE/?=
 =?us-ascii?Q?Bdy16uIZScd9mArca0zRh4ji6qEzR1CFai26eGZBqfzGMUDQfn8ZwMhnS3ZO?=
 =?us-ascii?Q?5J39ayL/NMZeO8Z4+sCr5ETTflGFbHhusjIeS8llhk+ffpNK8T3WmSY3g+W3?=
 =?us-ascii?Q?ABVRrpceGVFmByA/RqZlT969qWAzDO0rKZlWRXMTzTZOAfAWFZoZDx89+NTT?=
 =?us-ascii?Q?8aowAsFDb9wQ2BtCNj9xKzcK9ABEEscgH8J92J0f3QdEpcEPFCq/9b94p5tu?=
 =?us-ascii?Q?YLZWYbhhHMc8IaUmFAIQjjuRE1Aqv8Y+qBriYOs2uEn/9oto9ZHQgp54Ftn9?=
 =?us-ascii?Q?WyGiJ4XqwZGPh0PnV2hyJsWMzGX7AlQcfAFjQuvYgW9iLV60UEYRUHOPY1KO?=
 =?us-ascii?Q?e9d1IQWo3f5B9suil4oz09gVs00jmdzfHg2t8zz2lDsC7+w/7q+VRa/n4gcY?=
 =?us-ascii?Q?ue6OcoGrXNj9ehQx2OwC1j2PnC1Xsuu/nJBAKmgGiJ6CZiVh4FfuA3JxX9W6?=
 =?us-ascii?Q?gbjQkJMCCY1o8z0UbjrM7JVbSOgu/xKoWYHKiv5mmjjffH+fYe8NuKJw1f/M?=
 =?us-ascii?Q?YXna3OAnNN0MpxfJplIPO7xYOFJIDxmGFn31pE2VDRtPkQQ18BPvf/xzWAWD?=
 =?us-ascii?Q?JU1UpgnjRY4MrWf6jqh+VH6sjIIndyam8t/lucI2aTANa/GaNtifPxJJIBDS?=
 =?us-ascii?Q?Z9Ym1Cj87F8r0/a1W/EWh6HWs1WQvw41snOou6ZwzOzmOUtCyyp6J+NOg6yP?=
 =?us-ascii?Q?DD+MZsFKPUjZvv1MUYvoYDbJ/ZKrzi8QOoKnuDOuL0VVFynrxSXJmMCtqsPP?=
 =?us-ascii?Q?MvNhEzS+KWurmlQ/SoDM//VKs6M4ICj1hF1gHt/y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 070151a9-9eb1-4392-d844-08dc917f4356
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 23:18:15.7583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5R79aZKEUu8jlujOfBPtXvNJtof4s5IshWEF7AubgBBXsUWbx1uBMa1JEJ+Plpp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7310

On Thu, Jun 20, 2024 at 03:47:23PM -0700, Elliot Berman wrote:
> On Thu, Jun 20, 2024 at 11:29:56AM -0300, Jason Gunthorpe wrote:
> > On Thu, Jun 20, 2024 at 04:01:08PM +0200, David Hildenbrand wrote:
> > > Regarding huge pages: assume the huge page (e.g., 1 GiB hugetlb) is shared,
> > > now the VM requests to make one subpage private. 
> > 
> > I think the general CC model has the shared/private setup earlier on
> > the VM lifecycle with large runs of contiguous pages. It would only
> > become a problem if you intend to to high rate fine granual
> > shared/private switching. Which is why I am asking what the actual
> > "why" is here.
> > 
> 
> I'd let Fuad comment if he's aware of any specific/concrete Anrdoid
> usecases about converting between shared and private. One usecase I can
> think about is host providing large multimedia blobs (e.g. video) to the
> guest. Rather than using swiotlb, the CC guest can share pages back with
> the host so host can copy the blob in, possibly using H/W accel. I
> mention this example because we may not need to support shared/private
> conversions at granularity finer than huge pages. 

I suspect the more useful thing would be to be able to allocate actual
shared memory and use that to shuffle data without a copy, setup much
less frequently. Ie you could allocate a large shared buffer for video
sharing and stream the video frames through that memory without copy.

This is slightly different from converting arbitary memory in-place
into shared memory. The VM may be able to do a better job at
clustering the shared memory allocation requests, ie locate them all
within a 1GB region to further optimize the host side.

> Jason, do you have scenario in mind? I couldn't tell if we now had a
> usecase or are brainstorming a solution to have a solution.

No, I'm interested in what pKVM is doing that needs this to be so much
different than the CC case..

Jason

