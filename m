Return-Path: <linux-kselftest+bounces-12345-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2FE910D56
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 18:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1B01C21BB2
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 16:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5761B14FB;
	Thu, 20 Jun 2024 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OumW38ra"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAB11AD4B9;
	Thu, 20 Jun 2024 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718901726; cv=fail; b=Lz2K9cKlNQDwiKUAzuvOkcqa4ETynqMD12YZh4o1tq/bESVOxA+D9r9Ur5OawtkfBo7vhE2S21SlU7FKs5Wd0i5CwhEgpVODnfJ1taz2oKOOql/9QGAijUmo6pLNahABusgD2OLSwQMBgYXehFJSolO7L2QuFL8mR093HvSkhS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718901726; c=relaxed/simple;
	bh=ugdQ663L3E/+BeMw381LjLcKz1Y3eBU9Asb+2weZSp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GOnchw4+mW1hVNl5EMpL2SmHbmW8h/q7Mv4Cy5Nj2QYXuoqB06I4AJc9yJS5zSIt74uXW9gThgVs5gMSBH0yUAXz7vIG3RXSTOjC/1oZJw3dFnDnv6MOBbAWEFgpRPw7wvfFI4TW3iRaRwFl7oxmkTdR0oAWWA2Gyc03EcbOtsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OumW38ra; arc=fail smtp.client-ip=40.107.100.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T75SrLJ4f09jDSKuyu8685y+LC6qcV38wlzg1eK98PUKKgz/oJFZiqrmAf58ybZvip9pbg2qgiAjmOw6XdhsLalK2Wsx9Z8RfhT4uIxIrUCXnSneSaDB6py+z22iK7VfkDyDyLT/M7Yxh7g5NHnd/wQlKm6acFN8JN1pGSyOOzF4Afd/sRspvKBko6PDHlHGowSTVVPiDdtGg+B99mz+X/wL95YbBsth3/iPnhb3CQOXyQv+PvSUA3K266DlNYIx/6A5/LSjK5QNVKsihpN8+hbm1jGx79Y0QAHjtkHqwWH1Zhj96AUi11UdMR+l7W1x6bAdGr/PJJDMKquvooKuYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6dAI8WETHw0ZwNTBYH5b/20E8r2nRGwa4h1VAg6/dY=;
 b=YSz7NyNlWdpLb8CSmiNZ4IPjaSM8Rc9msgDsHY2zxr2Sp6ccIjS64kB1QgSYb/OW+hqUF6HnjRa8FZ97ff8jfpB1Xf05c0JIJtV/4Q5pfUr6Qn4ALspY5UM8ux79fE9bxWwqB9zxOP8hIiVtxlLEKlwF0kxfZQIH0/MVyTjKVbXnwStZt8bkU9W0cflTmhISUb2HN8SNkyOXsfXePgD4J9VIvU/aDBDcmwuzq41lBin1GFfGglGTTZLBjeQmrBctw5lb38VjvJ10CkqtoqrKnvvfMLpgf7GRYE/kSx8XZlI8Mx+Tp23KFY6r3aIbuyE6V59KpkqTG69h9y/8tOrFkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6dAI8WETHw0ZwNTBYH5b/20E8r2nRGwa4h1VAg6/dY=;
 b=OumW38ra+AblIVpqBNhMWnjfKPBC27xC+4usoFKFFQlUGVdLhM6EWDw+wYdCP248V21z8AO5dKwtn2Xk+yp4cv0nQlQu+fbyRytoKoOM7Z6bzRy4OJBxgjZ1z0xslkSEFanyXkXk/3ec0pToL06V5kF071tZpnwbIYyK+1m5YqA1XJZUtKvErvPJBLm0P7F7XM543d5Ws2lqHabTQ9+/Fk0VbAeHLkHg+SxL0LsCJCyYByMfY8XXhRSKvZEgPjnedR1we/BumLV6pNT+S6GAckiVGzPnKMJPRLXiMt4wAtsanuDSxshZEeeLIowojBZnoYzpVHBsGMLIyVcl2rJShw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CYXPR12MB9441.namprd12.prod.outlook.com (2603:10b6:930:dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 16:41:59 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%5]) with mapi id 15.20.7677.030; Thu, 20 Jun 2024
 16:41:59 +0000
Date: Thu, 20 Jun 2024 13:36:26 -0300
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
Message-ID: <20240620163626.GK2494510@nvidia.com>
References: <7fb8cc2c-916a-43e1-9edf-23ed35e42f51@nvidia.com>
 <14bd145a-039f-4fb9-8598-384d6a051737@redhat.com>
 <CA+EHjTxWWEHfjZ9LJqZy+VCk43qd3SMKiPF7uvAwmDdPeVhrvQ@mail.gmail.com>
 <20240619115135.GE2494510@nvidia.com>
 <ZnOsAEV3GycCcqSX@infradead.org>
 <CA+EHjTxaCxibvGOMPk9Oj5TfQV3J3ZLwXk83oVHuwf8H0Q47sA@mail.gmail.com>
 <20240620135540.GG2494510@nvidia.com>
 <6d7b180a-9f80-43a4-a4cc-fd79a45d7571@redhat.com>
 <20240620142956.GI2494510@nvidia.com>
 <385a5692-ffc8-455e-b371-0449b828b637@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <385a5692-ffc8-455e-b371-0449b828b637@redhat.com>
X-ClientProxiedBy: MN2PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:208:d4::27) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CYXPR12MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: 845f8f6d-8ca8-4fce-b434-08dc9147e734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021|7416011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5sZ0KeVu4OM6FAJ056yDYXgJSYUPLT5X2HsJZvEgcfrkyIWifH6/Sum/o2ZT?=
 =?us-ascii?Q?Hkfkc9AneQrs87CZx0wiy+9ZSbOqo1Fd7EPSHYv5BAezoNYnblIjFGqUrKzm?=
 =?us-ascii?Q?bXQrQXMTVQGFAaRf9ezVbmHOPej2Ww2jNoqEIBZL8VEdOU2YuYSzQCxJA1rA?=
 =?us-ascii?Q?A6UVqHZSxqQvmpd5g/tI6DFOQ1JIKENagLPaY+fPVS4lu7GPVmbRjl9U071s?=
 =?us-ascii?Q?BIjw2W5lMlEjH6PY/IWSk3ba4KOxkyVi36F3ZxdohX6NZVNGb8NwSA++o+wz?=
 =?us-ascii?Q?gI/GD+VPMjVKOlVDbmyU4GqVkRfzr4Ro3Lm5UDne+8xp81B7YtC8VOzrd3aX?=
 =?us-ascii?Q?NNGYcThuBEX4Bf9Uk1GaJSKQkGkyMDctuwU/s/TemR4oGCtYZ04AbfMcpg1j?=
 =?us-ascii?Q?A4uhwi+muA2PsZdU484NEU2kwYcHPnCld7BGYH4Xus6igdqMVx+q931mVPvG?=
 =?us-ascii?Q?vtWYTLBneDm3253eMAuNfL/LVRW2Zr+olgGukVVSF+nwasdsd9QHbqlkr67F?=
 =?us-ascii?Q?zqaOdZkHHx60fSquEsCEQw5sZsESJzmy8JQgAJi3extiNJGlFqu3rIPLyriI?=
 =?us-ascii?Q?ThjU+UkK0RdoxxaGyI5mwdxMH5G+TyhTBCXtGfk5YeMcVbgXDSbVWN3SgJPv?=
 =?us-ascii?Q?KkV7NP2s9HYxWiUjWXCgcnopTu0SV1oFRHvAb44KP55WhesonsqCS1aLd0VS?=
 =?us-ascii?Q?dVEg3R0p/cPS6hD07tZIeDxfDwXIlFIlEdVsET8MFQut7akyQwbSSqglswPn?=
 =?us-ascii?Q?0fgABsVxohyhQ00/EtgjjpOCyRap0h8kX9FGjObtZhnH37LGjooUVFp0up+/?=
 =?us-ascii?Q?qp4hwlRJBdbQJLuRV1mG4HtZAx8ItCctQAPf8hKoDm1NZCocqKwX1778RM8n?=
 =?us-ascii?Q?kfo7h4MIKr4g3crCOvKsQO1IVa6kz1iOILC4aL3ctlw5/D48LBYxIO1U78O6?=
 =?us-ascii?Q?JdTd2/YoK6IgcKwZGUfjLNdDY/jJNuRJQNz2qzQ7q0Gulk57clPYa5OP0169?=
 =?us-ascii?Q?shKSkAsj5K7X3Nm4BNWkKAaHMiKV8kcwjIe6jbfNj7yRLwxC6XF/1EQhCBqb?=
 =?us-ascii?Q?SLkcjWeUsPMwSRnCPo8Xo0XY9OaIMK+GudQVzYoXjzwluFwpDNT6g/GRmIRg?=
 =?us-ascii?Q?LGCHPUHRXy97waNn7jbTuCU3eh4WWTvxsVNNXUPiRZJrifYN+r/DzbTwoatZ?=
 =?us-ascii?Q?6Z0UK1SnlIq7Z9uqIu/Egb4Y7IGIn1LPqiMOiN63yzTd4/n+gqaOCqQC6iiC?=
 =?us-ascii?Q?JLToH8T8UcAszbVB5nmWqLIxuD8RnISqmF+be0SshhHkqf37O6fmvrraUY+/?=
 =?us-ascii?Q?WqLwGKe72HvB2KhsrzMhnfa9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(7416011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ErMBMD9qfaLI8OeZ83UYHagVsR2O3kK4Aimw1TA6lcFqZpIoXsfAQ5S2aDnO?=
 =?us-ascii?Q?sw3Ey7ZyOFwTcly6ZaJ5CEPY329Z21eewQyKSEs8vn0+R5uLN4DfC8GknGLn?=
 =?us-ascii?Q?G1+I12MTTyiB3hTMss6To1Cj7p8CybSy6aKynL9LhMdpaprr4nUyD6zdcRRs?=
 =?us-ascii?Q?m8kqb/p94p8w9s/LSPDh6XufP5W0SM4ppRvwrw8F2VWoCO9SOsflvlcal6RA?=
 =?us-ascii?Q?W177jyjJOXe61Rnv+TVQdFngKRd+OzrqZ+S1XzkDYhDSwOYRIPrKHeQLekOH?=
 =?us-ascii?Q?oA3XxEMhif0SuyIXw3MKXWPGisJMhn+LotXYYkuMabCCQH+PRrgc9On3Um8n?=
 =?us-ascii?Q?GNlDi4xPYIb4cJKqEQuNVEWHKsheM3GK4UwFktpu/jxBkkvtOhtb1omCWj0F?=
 =?us-ascii?Q?Lg2BAQ20kq327j9KXB2e4lMMBXjOA23C8IbVWApW75BFeo979RuhjT3Mdn3W?=
 =?us-ascii?Q?1E7WGE1VCHpWD7vShd2sH+vdwvuxrnE3ugTQukUqXXNH7fV9k+G9k3Idn2xB?=
 =?us-ascii?Q?gatLJf+JgLnhP0SAXh+nhDpGiwD+s38PwaAEucSOiicCjv9neAJRHKUf9ajC?=
 =?us-ascii?Q?N0EVrH8VVNS7xqtzzEdYaDernrg9lhphnPRh+54Ko4qPibnOsDeaXkHRWwJe?=
 =?us-ascii?Q?TCGU0w8oQputx1AAptTYqCSv29O829bbNWQN2bOb4a57pmQypOCSpkwPszRP?=
 =?us-ascii?Q?ofGGE2Ue0LE79O+NrvsyPp+7FiSw5/JqZ8AiVLKsNy6hhKX+yrjhHa07NFrl?=
 =?us-ascii?Q?cwTEIu9COwZqzzAgfRTay8cXXhb2gb9IF7ULvC6lif3IvBmoGkjZ79U7WdoD?=
 =?us-ascii?Q?IChBGdObGbhRaNQI+k6IixT/TB11+PGPxZaFWxDV7FnK0fQc27xiHJthtbhB?=
 =?us-ascii?Q?iGjgUqkSLJXSAlQsGE7B1dSaTVbORPAGuhzrVBEehPfaOfClOE/MtZlv1tar?=
 =?us-ascii?Q?pwrIvjQ/UXNut7+yVvNrX5EIH4H8Kz9C8pRJwEBAo6QGBI5Acng79Y9DDiDO?=
 =?us-ascii?Q?eLuS1A2RYR0jKts1z6OVdqxrpggKnd6+lH5u367xocMhetRq53fHEERyw+j9?=
 =?us-ascii?Q?FPVNZnZR/20fUvQhHaPNy5gsjUN8w5gM85zm/LYmILXUAsfxMA5hFd6N8V95?=
 =?us-ascii?Q?rTNXpGlH0YIvchkm0KHsckpboLgH72DZpQtNlO6SscNN6lxSt1/t42260u4O?=
 =?us-ascii?Q?+j34sIaI2PC/KU9gAgjBu4S1KvD75FNVt7hU/cVQNmY2BLepH1vBpoz1Fm4Q?=
 =?us-ascii?Q?GZzeYObsqf/E92yNaG3M8S9F5fn3lns0ShRm5loj8jWJW9jbvHWBJho/eNRt?=
 =?us-ascii?Q?IeyswegYtFkMpfb/VmbZvVZn7pWcMzomRVWGOPenuCdGn9lQalkll8cMhTvp?=
 =?us-ascii?Q?waoQYwbSPwSIEwCuAvW3TjjQtBSUrK4AWq6fvPY0ISZKL8z3TxwZEsQn/GTC?=
 =?us-ascii?Q?5C2jDFn0XUyZzWZKCSWr6qM9tAonKPDK1/a2IDusCbZGDM4gg8f+Z/9EWwqN?=
 =?us-ascii?Q?hPClc6NCLa7mHLsA4f2CHq7L7OY3ygdsjDSYy2D08+s9dXhZ1/fFRKkQGHCL?=
 =?us-ascii?Q?HD+uCqRk7Y8v6cj9DtivSf2W2TTR902bUtzM2JbH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 845f8f6d-8ca8-4fce-b434-08dc9147e734
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:41:58.8791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hR0kcfUKGL3H1sb0bSUmEVWKzBjnLTyLf5Db4rXyIeO+1gCD9OLrYG6pci7CUxvM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9441

On Thu, Jun 20, 2024 at 04:45:08PM +0200, David Hildenbrand wrote:

> If we could disallow pinning any shared pages, that would make life a lot
> easier, but I think there were reasons for why we might require it. To
> convert shared->private, simply unmap that folio (only the shared parts
> could possibly be mapped) from all user page tables.

IMHO it should be reasonable to make it work like ZONE_MOVABLE and
FOLL_LONGTERM. Making a shared page private is really no different
from moving it.

And if you have built a VMM that uses VMA mapped shared pages and
short-term pinning then you should really also ensure that the VM is
aware when the pins go away. For instance if you are doing some virtio
thing with O_DIRECT pinning then the guest will know the pins are gone
when it observes virtio completions.

In this way making private is just like moving, we unmap the page and
then drive the refcount to zero, then move it.

> > I'm kind of surprised the CC folks don't want the same thing for
> > exactly the same reason. It is much easier to recover the huge
> > mappings for the S2 in the presence of shared holes if you track it
> > this way. Even CC will have this problem, to some degree, too.
> 
> Precisely! RH (and therefore, me) is primarily interested in existing
> guest_memfd users at this point ("CC"), and I don't see an easy way to get
> that running with huge pages in the existing model reasonably well ...

IMHO it is an important topic so I'm glad you are thinking about it.

There is definately some overlap here where if you do teach
guest_memfd about huge pages then you must also provide a away to map
the fragments of them that have become shared. I think there is little
option here unless you double allocate and/or destroy the performance
properties of the huge pages.

It is just the nature of our system that shared pages must be in VMAs
and must be copy_to/from_user/GUP'able/etc.

Jason

