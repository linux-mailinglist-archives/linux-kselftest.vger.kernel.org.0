Return-Path: <linux-kselftest+bounces-12327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D79910759
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 16:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 041A62853F7
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 14:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B3E1AD4AD;
	Thu, 20 Jun 2024 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rOo+MxgT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B061AE08B;
	Thu, 20 Jun 2024 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718892108; cv=fail; b=OPFtZlGFEcvUP1mBli/IXDu/S0TZw1pJc95OVdoo7+QLlo+xIncEb0LNDiV7p9v11g0wyQlSbhOaZtbM7fwDCjj7xMRL97mSdgTIC+CqJa8fAdtEZlFCRiftZ1uAULLt28RGBXHeES/Xk5+bRiMYzNYQL1ltcm6ZKZMMOwQHwW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718892108; c=relaxed/simple;
	bh=bx9qG41gCbtHD7n9UJBjy7Rl8UuHxDnI2XjDlhXw5dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ifVXiFUvCQmXrtSbcoO+TtDkPeDagwoqCk2bLs5GV6zxZahnLlkQWlUw+S/SounpY46D1UCUZC0YxIqab+kpSNOhWYIpobhK8aBR4v0JjGSMrPUWgdjE0AeHoAATKRT1xUYuuOQtW8fV24knySILu6knpGueEF7gr86PFoMfkfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rOo+MxgT; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDA5duk5hgKFsV6PZF6DFAlNtGjB5X/F08TDMZyFCa73BpDYlwbY6R8aalJ+DXIb0V2pl9nUsH1xQuKtEwbL2oBhkecsxGWSMShQIKWahTR9HchJxT9N2bj3Qe3TukOPn5JAw5x3DQa3H7G2IIhFA9ZBG6Ug+6Oh5LyDUBSLUYkDez3nWNVJb+2/ZwJgBuIpVXeJBiXj59igEljSSLOdXocHB6siOayjmOVBFqMLWWJRMlkB8Or9FTOfK1WSRawbL6C+P5/ZiT7FTRlR/Yf/gdtyrAYb89HQvpJ+VzPg6lQRq/aCbKTiLZnCrs9Vukj9WEUiNUOthJAejWkdxD+IXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfdW4UUszdgDbn9EGYGIc69eLBL6LrND+QEOGZlgKfI=;
 b=R/0LC+fTjIrqvuwayWQ6/DRHAudPFV+TQLHsLBSqC7XjHb1p0ms1QKhIO8pt/rdT5FZmERrafmLN2vQZFciVTUvxDGUOee9ZcsIOIWRrhIbMCjU5a0uCwKoR/7j1xP+fVPiH/MgzUmG0vmP4J4BfEwBHN4Hl+P6zY4MbQSEzZcsIYMXt4WWbh+lzHGyaeWMdX6Psc+xF4fzl4uMbQlFp7bMa8ydl9wBDE5cLb15gy0xqfepEU6SDIYeg2+SPfUy78YG48qBr+brWx8B9mvNT2L3Tql6TN6H24kS/ov4dmPCy4KT++qt1HnIfVZJuCcaWgWbB/oUrrLpgLm/mVnCXxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfdW4UUszdgDbn9EGYGIc69eLBL6LrND+QEOGZlgKfI=;
 b=rOo+MxgTAboOp8114E0HbrhA+hnWbEkBvajP0JW7vSSixLNjvbybqyJtv1golLj+IW3RGVDveorsn9K076hGAm2NdygyxoJwEeYenCwnAdSQTMWSsV4BgQuFKSg+9yZwTI9DbZyBL3ijWbb7z4DY4XX+68zA5i1E7dlfOoFAx1/+r6M+By0E0M3/Gv9smImfknpnta8RKcxeeEtmrLz2e5bPTZ9CWNF75lCUNR0dJmXp4cAg54dWkznKqSmaFLBWes/WY50mlUOi6kBUPjT7K7w2/eB9Cm06sg/XS4eHxn4bY7AMMC5jwOFtyn4/1xwBWmH/CnF+Wy1+1vWoQJh64g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SA3PR12MB9131.namprd12.prod.outlook.com (2603:10b6:806:395::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 14:01:44 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%5]) with mapi id 15.20.7677.030; Thu, 20 Jun 2024
 14:01:43 +0000
Date: Thu, 20 Jun 2024 11:01:42 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Fuad Tabba <tabba@google.com>, John Hubbard <jhubbard@nvidia.com>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	maz@kernel.org, kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, pbonzini@redhat.com
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
Message-ID: <20240620140142.GH2494510@nvidia.com>
References: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
 <7fb8cc2c-916a-43e1-9edf-23ed35e42f51@nvidia.com>
 <14bd145a-039f-4fb9-8598-384d6a051737@redhat.com>
 <CA+EHjTxWWEHfjZ9LJqZy+VCk43qd3SMKiPF7uvAwmDdPeVhrvQ@mail.gmail.com>
 <489d1494-626c-40d9-89ec-4afc4cd0624b@redhat.com>
 <CA+EHjTzuqd5PYdZzAGWTjH+EyhomCeGSaFvDjgZfU7GUAWqu9A@mail.gmail.com>
 <26aa1ad6-fcdd-4fe2-b763-6938555f93db@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26aa1ad6-fcdd-4fe2-b763-6938555f93db@redhat.com>
X-ClientProxiedBy: BLAPR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:208:335::27) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SA3PR12MB9131:EE_
X-MS-Office365-Filtering-Correlation-Id: 65df24ba-4717-4d48-a27f-08dc91318425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7HurHVCbjk0P+Qa4x9PJ9gl7RYfy1ArRPu+IVDXCZuay+ETxuQ+OtkCg1MsV?=
 =?us-ascii?Q?lClQF5yZY8FiSgCQjraONdTq/pelnIRytocROjDfos++uvtkpFl73ERgAGLT?=
 =?us-ascii?Q?d7jK1crASiHXNZRL9H2t0kwVeWQhbiBMTfA9rU5VgAXVEme0jKteJUR+qY7H?=
 =?us-ascii?Q?cCQf0/A5FSZoKDw6Ph2k10QJ6u0ZkrAGa8a22Qsi9/IxpXS7wAOWTTW3tKpz?=
 =?us-ascii?Q?sJ+tBoGU4eLn80Hma/NdFcvO6aZxQm43gFKxWN/XRGbwJEkkGPbewvbDyxS2?=
 =?us-ascii?Q?NIk2XJ9PZ5xJM1KBWO3mpFk67qAHTsc3QPk6Ftn0etOspfqhk9BKUm/LtR+v?=
 =?us-ascii?Q?E2K+98SXGmjwhg2uIkNEx0ygX2JVd/TgZY4mkJRAVXFLJB1wjO0APRwIMAyb?=
 =?us-ascii?Q?Eq27d9FhQ0/WF1r6j3xUmqbXUCM/TqQkiQexfAEDY8rFh2CLnVdX4AerDQg2?=
 =?us-ascii?Q?EQ3N235EDN330ZgE6XmexQvdJYLYEqeUE3od+n0W4t6uFi1rsbGDcyBm1eZL?=
 =?us-ascii?Q?xDeuoh/BYNksKmHkm14JCFkpjcwymkvtnw0j/Mwyjsw1vRLoMWmmeIsjKMa0?=
 =?us-ascii?Q?rq/WIOVBcKTFsDbOk6DEF5K0VxAVK4qxDLjg6mTsIDWGfM1v+KuU7yPK0yCr?=
 =?us-ascii?Q?zPywfLp1/Lino83eql5jHB+P6c4ZRA9evhHWxQRMax3hm36WVuuf/r9KuI9b?=
 =?us-ascii?Q?a50F4hNMGIh3u4+be9tZ77CFc5MIdt4yvO2ZIJKI1wSep6/wuNLNtIucywuq?=
 =?us-ascii?Q?9vNycDYDVsU4BpJpJ9bS1olRKJenFppgQC/C9qlPhrVQ7kzx+bvMGHcA0qml?=
 =?us-ascii?Q?Y+u/N201Cn3qnC/k4U6uOG2PzVUYy16c1p/YRiYSmXZNVHLg3dy/cPp3psOx?=
 =?us-ascii?Q?iW8O0Ntg7qfql4hnnfiDQLuDXPyvGvU+E/mOOr7zIKm6Sv089IFJP3Aj3GHP?=
 =?us-ascii?Q?XBLqOofdEKD27D85TS99amGMoru+7izySgXjr+oYa7tiurUmhKzhKAtukEii?=
 =?us-ascii?Q?sy+4Pp6/roPic8cXhIUpfXl+qdYkekcXqFcI00YmOOYymWxmRxJfLAWw8xlO?=
 =?us-ascii?Q?jw3CsakcNEzAIg6M0XhHF9RFWjGSg3D1BNF8EcSql9EVLfv7I1/zT9xfP16H?=
 =?us-ascii?Q?Kw1dHpMBLXLdmW6mV1G9mT9WzTb6LALX3lhzXX4uJw4eZI9K2IIIXn7mtbVD?=
 =?us-ascii?Q?ANZ/yAgrnRY1RmWm36mbHzmZf+KROX2sZ71UKAEEA8OmoFY9+nPrsNgFEfU3?=
 =?us-ascii?Q?boeSHPlInTlAMf2pUEca3GTg0mkYgPpDg/c2AWCuGcQqaNTJxqVpl1vfcn1/?=
 =?us-ascii?Q?tENh/WNNjAcuzEjhCWGHDHQI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5cQq8dQObMbHvJocPQGGRMl0MF7xs/t7VaV6NbQvNG4zS0696JbO/af9dQ3j?=
 =?us-ascii?Q?9iAYRuIuqYwN59+g/+PIKGT6ayAv6+Y9HEynlPO1zYkNmXrpMQ4ATTiXTLf5?=
 =?us-ascii?Q?iHysaAOnYrVZOPGlncRwYOwXJTLp7HTZoYo6ZUQvIL0Z4o/Ooy6c72lpsNlJ?=
 =?us-ascii?Q?cRm1pDHV6kLeFwzYARfkgX/5uQbMVr54W7boL72d8Ia6qNN4dXcn79vG+mSK?=
 =?us-ascii?Q?iZUk+plBmvvIpCRVBYSguBm2RWHcUeVC0g389AJH7rNm7jrAnU2ToGwORyXA?=
 =?us-ascii?Q?xm2o4wFqDqs7JEtr0N8me5jvMVsVYLIhjkIG5MhAeXBmaD4niybqWO0jOi+N?=
 =?us-ascii?Q?1AYDBMeH+X4xmcHguxicCvrqaP60Uv35fi02N40xJmoqYGy5DHigQLJn09Mk?=
 =?us-ascii?Q?4A6tb4Z1yk5SxSjOmeVllecjJ+zL/CWxfzhYMm2JR+/7xAJZzo8YCYrHoE9h?=
 =?us-ascii?Q?uV3qIAgjjNyJ8Htf1ipircbsots5eU+Zy8BfPhrfiDKeuRR7eaoZoU6sjESp?=
 =?us-ascii?Q?ZA4LnV9C5mkBjYG3tH71yulzRgwcXlSPVmtfiI3sxaFJYeXWYprzP4kE8aqX?=
 =?us-ascii?Q?SACnJR/MNrqij1XnQz13jtiniQqzXjih6ppXFKY3cJfmS3IABzkxRsvL5yKb?=
 =?us-ascii?Q?WevNYMBAYpv6Yfpx1QvvCkmABj6fSoJmdsESAcDoHIkdl8W2YpshiLpWCEvD?=
 =?us-ascii?Q?elFfFrB373TB/6y/u8Syq4ddAa9OITC7D8LCUY+oQWTrWe0wsTuFqOKHgZA6?=
 =?us-ascii?Q?UqfKjoKsb+KSTSCkVf+sxqzBacGAaXLBuxaoQaKlXe7nQc1G+skSjRJxKKOS?=
 =?us-ascii?Q?c05ko0u1myvJzV608O8wavvEDCVMXw5RFAlpZinimyha3Jm3N9yTVcopY0DD?=
 =?us-ascii?Q?KZIocBz33PR1Qdyh1Utei0phEW1/BqQr/p6yhDkH2zl7IhEtQEfNpsvF61wn?=
 =?us-ascii?Q?9gzkdUD0/TFiOOC6o677DHInzHuHx7kLk44qQ1xKQkp1O0w47oSgx8hduwSX?=
 =?us-ascii?Q?nlS3EimqqEkrCSDRc3IS8QCH3x6+IjgfGG0vgCBTAeLZYdjHS2gshzblUQys?=
 =?us-ascii?Q?nq2cTGN9/dA2VmMTbokvr9W5SLYXqCqD/qqG/q3XE5n5WNoJJAIfbTEOVwgs?=
 =?us-ascii?Q?vBX1chALj3PM6IS5IOj0Vo1/SRAnFKmfbvcd1lhbrfhaOKnZNj/3XE5wfnZR?=
 =?us-ascii?Q?+KChu0OnG7SFrjQm6ut08+m5s3AeFrZ+HLkNuZs8BiQRbhaqjiWOtoMy+Uyt?=
 =?us-ascii?Q?50riRP7CzovTFEaSK6SEIL/N+tofw/uJIcowNjRQvJlc+H3Z6/SLYLufNi/+?=
 =?us-ascii?Q?e6lvGsTArivChni8NQKJcgfp7zUIWz6b2t5pzN9vp3Bld/c1f2UfrKjSVV7u?=
 =?us-ascii?Q?N4qFrQ81kkmpIuyn411EDGf7c0owggIpLYYnE4aZb2hKwbTceHuV2HCdlyRK?=
 =?us-ascii?Q?cEGUX0JlTJ7xYbMZ5RvVGOkIErRrlSvUIEl67UF4oJg89uArDIasVDXpTygN?=
 =?us-ascii?Q?vUjhY+IDwIax0LLQ/zj7bu9nCIZHLHJu1O1C89Sm4w+YQPJEpGU0t+qT22X4?=
 =?us-ascii?Q?WJEz6qSmwNfXlectpSkp4FYWQ+KF9EOxtq0IdkbD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65df24ba-4717-4d48-a27f-08dc91318425
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 14:01:43.7387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: osby3QUU1RFCFhSq8hIrU4ZA6zsgs2qqX58GGNrIvv8Qya3yz1boWZVUEfklT8zR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9131

On Thu, Jun 20, 2024 at 11:00:45AM +0200, David Hildenbrand wrote:
> > Not sure if IOMMU + private makes that much sense really, but I think
> > I might not really understand what you mean by this.
> 
> A device might be able to access private memory. In the TDX world, this
> would mean that a device "speaks" encrypted memory.
> 
> At the same time, a device might be able to access shared memory. Maybe
> devices can do both?
> 
> What do do when converting between private and shared? I think it depends on
> various factors (e.g., device capabilities).

The whole thing is complicated once you put the pages into the VMA. We
have hmm_range_fault and IOMMU SVA paths that both obtain the pfns
without any of the checks here.

(and I suspect many of the target HW's for pKVM have/will have SVA
capable GPUs so SVA is an attack vector worth considering)

What happens if someone does DMA to these PFNs? It seems like nothing
good in either scenario..

Really the only way to do it properly is to keep the memory unmapped,
that must be the starting point to any solution. Denying GUP is just
an ugly hack.

Jason

