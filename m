Return-Path: <linux-kselftest+bounces-6449-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64A588105F
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Mar 2024 12:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A4FA284F5E
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Mar 2024 11:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324323B289;
	Wed, 20 Mar 2024 11:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Uel/B3yz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A941DDD6;
	Wed, 20 Mar 2024 11:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710932480; cv=fail; b=GUFUYA80otyQLNZ7VU5A6BUjJ8mmcuCwoKBfEWsC3ri//TXQWxB09MFI6uq4ykHgyuq4oLXZncnolHp2KmLy/pGbqfu3ZFgPW4uxvEf8iKO0pqgg5NIEZ9BWd//aDVbsM7LYSN5v16L+L3lmYFddQtCZ5RZQdS+WT9PMj6XkJog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710932480; c=relaxed/simple;
	bh=oKLpjf68PVqSOe5cNkrMmqfyReW++PIJOisL6Xbb1/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YtKyNNe9E9wgdwU/EcZkCBxVSnWPLt+je/gsw1V/fAXJcd56+eJ3+MC0lBQiJBXnqIKGWQ3O2qUlY1gKsh1PJf3PDvHd/+js6BrIfzcr38a1+nev02S+PM6TjRnnmSyweLTSDaa6F/oRM8r7d+DS51QrYLbNTSHX5P6wepJtA1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Uel/B3yz; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKShoa3crwB7RU8FzvlBqyqW7EwQRv4J0Yts6buSWORT9/qvNg4LaBCL3UvJKW1I0l2U3b0dHHazCD+2Vs7Vq9CiEhZGuuQEy3rajisf7oAxJ3EyVEL+n5a5/xcHC0c9xWxnBc0IytlW2p+ScAzp/sopOjNamqV4RaxbnWpad0JT4Vlf1AGIO6QwLIdrafYbj2hy6DpQ0d1SKtzswWhP//dhIEQdlIakIXby4PscHD8A0PzAOFglQh97LJr9BcVlMnUeKmKjMhrEycvz8GBhqmfO2trs8pVOctoeAP++oEjkIBJGreYFochgJpBkxYhDnV/B7uigVvo/MxSeDsHVxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xh30GvViQ2tJzus0LJ/fu4xsIdkd/QBbi+T93beerLI=;
 b=awGRks9HEnOZRHBuVdEPw87VzkBtGQIgm09WyV7IIhKIi/EUZEt4QFi59PNpF8QZYFj71Nr6WSa+ffcAY361NNoNMw6clC0e+W2Ncd11BMbH5kj6cR/5NiTTdgOGq8SMMkXh+Mf+civwJib7ZEEOoXE9h/XixWI3JCMMEhnw8NiBtrsbG8caRxC4c6/HaaKUIUnK1Qr5LuSQ6Mgd/SAyBZWsjiXy3JXwB95MWZy8yVYOREfvL2iMigGWc0ahgcPMmkcUsn6da0fiKSgXjcZ4PZ5eFIbz43d9SLoLRLQu9pi4CgA+l1iGrSVtWnA36HK2ujmsbxJVuxXZzOTqkEoFAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xh30GvViQ2tJzus0LJ/fu4xsIdkd/QBbi+T93beerLI=;
 b=Uel/B3yzxiEaXujU2VVq6nygFxCtvVhEopQGZR8WKHJczlAstEC4Z0iTnFjnp/5PBu8GR1ApPtYxHlOQiy6I/oZ4uowo8rK6NED5wVT8J+dEsI3nDIFvBW15C9ywZmPXpyDdxLX50eN4Mm49bPbWjky9InKnxQpOh2XM03JwyT+bo6l4HVybLvkXVi0/Jp/+MV1c2cr4jMopMnejA/TcsCM0RyNje0+9fczgkPwNTd2RO1LQRU37XaWZBKaGR9gh5tpGITjHi1aPGBr/mDPrk0jzT9eL2UVmdqb7fLshLwCNO8UsXZTq2PB1Ch/6EgCCderHn6NnGWPD41DGPFjDxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by CH3PR12MB9028.namprd12.prod.outlook.com (2603:10b6:610:123::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Wed, 20 Mar
 2024 11:01:07 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543%4]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 11:01:07 +0000
Date: Wed, 20 Mar 2024 13:01:02 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] selftests/net: test_vxlan_mdb.sh: 84 out of 642 tests
 [FAIL]
Message-ID: <ZfrB7hATyOcl4RSy@shredder>
References: <5bb50349-196d-4892-8ed2-f37543aa863f@alu.unizg.hr>
 <Zfe2cGv_EWFAZXAJ@Laptop-X1>
 <f005453c-c7cf-4e1d-b266-ffe1cf8fc79e@alu.unizg.hr>
 <ZfmgdVUmy-DgNklu@shredder>
 <87634afb-d14b-42ce-be25-1000591ee57c@alu.unizg.hr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87634afb-d14b-42ce-be25-1000591ee57c@alu.unizg.hr>
X-ClientProxiedBy: FR0P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::8) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|CH3PR12MB9028:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b186e0e-b28f-4edd-2c9c-08dc48cd0b44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nAHTxNg12ZgOwjG1p0K8sLuF6GBKCLbMSUivi9iRL8AxjPY4y6GC4ta+aPkGNeco3giWnrxD/tr1qDhkljdGGO8UaePRFHjjaHXq9SbnleP6fTXxb+FF3tmHgzxPJMOh98Q6jN11v9T/1RSjHTJEFhepUeSOGn4Fx+p1E7V+Jr3tfy0yc5AxTANC3hyJUIL+lW3lzvZzzOdBtnuEbVmIjOA88M2CxEdhBrJVGVPmLjJWmGrm+lpXl6NdEbvp0s9xcJWuZmgf5yeiTpm+NSgojO1p3y0m8jf48mPy/4rY/w6Bozev+4YwgRl8yaadmeFsAXkpNwORaD8UqDcdBIwkjyIVbLY7clhzk2xpAVnQzPqAvaPOnz19n7jD6yHUnJBxRQgYFxXCWFLXoxV9PZF9Za1nJ7VoKo+Z8Lw4M3Zv76skIQGXjavFJv4kppAg9qBtdWKlUP8OdkvaxOd//PPTrGwDviDwwD9Fezzh/Aj3rDQt/rwUzqDv1kqa5tYiyiFSFbo7dMqPeIxHAKdvy88jfi9z9ctRfZ5/dtRXSSurB1VX+NLIygkoZXVsFKK6PoqX+wJKwyhLoso1HBoRUBzOwDzHLLbzCpwSnyIHlQMEfjvvSHs37aVpcevofBIVthejW/LwWnigHjdvyEODI2wdbdMeOIvwKboNiRaqMdFwEp8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EpQDp7g5ORZHEaJiZOXKkd9ghsRF0gKsDuTuwE1qRCqSfnHZhPLEFQt0VHXN?=
 =?us-ascii?Q?stM1XGnZ/2qdOnfrlR6PmHuXUeW1xfu0vI0HY2fOU7S5sqtu7BLuJxsm219N?=
 =?us-ascii?Q?rGbwi5J87bitIAA/peCZ5R2g3rksSDEq8GSG9Kr710xNp9qk/l2SzxL8eixN?=
 =?us-ascii?Q?dY8Fmb1OT7HZ1DtgfMZQmFMpciuHjjV8/O1SThGuwBA2KzxFuWcRUy5uPf4b?=
 =?us-ascii?Q?/ezd/1qbsj7rNk5+tOqRwnOQw5m366zy4XojQmOkMlsWQTAHNH5MimkeT6kY?=
 =?us-ascii?Q?9mrvlMoSz85r4JhkOF/8CXgq23mZtN5QHb4yP8APJfBpC7BboAzYIrx8eMz1?=
 =?us-ascii?Q?HDXEs8+M+CgC4P7ouKQMsdftDP+JxlxxJDmFsNPLjzX2b4tFpnkCroxy2UVY?=
 =?us-ascii?Q?iex62MZAchJBZOlsUVesrzwS33HUHCPK0E7k5Sq3dGagNn51EhRTbhS/tY2k?=
 =?us-ascii?Q?w7qUwnFpxIt8j/igayllCN6lC/SyfZW0gxHqD88rIWhunqP21fVce9YNhTGC?=
 =?us-ascii?Q?dHBEVlYq1QQfdq/9QyKt565D4S4p+9hgzUy3mOiturQ/Ma7j/+b2snGpI8Bu?=
 =?us-ascii?Q?lnfgFp1No3VlnDtHcYZrOVK6XqGUHVmbexWidegKUFCWZSdV8c7QpP4p9oVY?=
 =?us-ascii?Q?oqWkzOd7/PH3O9YoNkiRfRWKgxMpM8UzoE8oW/26nJbh/TflhBcvANhf45+m?=
 =?us-ascii?Q?k47i7faneQB8EAjTHdUUeTx8YKf3wXlopkvz6D0zgAVCDzFcujolZBpj7q0G?=
 =?us-ascii?Q?qcxs4Ltm5vTBi1EwMKzKfAUy5NSBzXPRuEse19Kte3S7seAtIY6DcQh5IU2d?=
 =?us-ascii?Q?QSR/QfeAkbaV14uev1jlHiT1YexiAaBCErdzuRgqnQssT3hhy5QOr3BtJ8Hz?=
 =?us-ascii?Q?Egr1UAnf0fkllOnu4ODci02FS3yn6RMW3N/U9lJ24hzyB4z63GlbaI9kbkpJ?=
 =?us-ascii?Q?sDByVwWcX123fZJYaBI0tdXsk+2WoYCs2JBiWtXtvFnTnAEgrv5eYg+/kaCv?=
 =?us-ascii?Q?XKR6eS1OsEXQj/J5vqB4jqIjTyefiQWDn017x3BzOY+oi7JWhvtbQxqOQjaN?=
 =?us-ascii?Q?S2FyLZjOYgJj1gfrWpMkYV4wCeaMgGmmdb5wSJvlezS7Rm5BhCMIWBmvVruI?=
 =?us-ascii?Q?c9cfLXggUBoniyWPlwiY7rBktMSrzzAh4+63fRew4K+iR1PL+ke++FbZUFNd?=
 =?us-ascii?Q?SRBE2LnLN/nU+RzCyKJvazaFLG8pKWnsJ8cHeykiZYnySpuT1SFb3KH/5jkw?=
 =?us-ascii?Q?oejoY5gmO7oBpsCvqGVUeETC5EZ0egdxnBu7eANQ6hrvJFZKWyIOJp9c1Yo3?=
 =?us-ascii?Q?kj35+Yu74flrb5w+E3MltVeujIr0EkATEwUefeAtg8whDQR1XSfijhEmvh//?=
 =?us-ascii?Q?FZHjtnBsCJnpIdAg6hITx5rQVGdq6LFHtXjTl9YlsFWaKZZL+JIQlJD5gnTD?=
 =?us-ascii?Q?+5g/F/jdqQrsxm8MwdQGdVBOw+uOVzvHGbBm46jC0Ut58a2Jqaw7VQS/3Q8b?=
 =?us-ascii?Q?UOA1fEsZOBY38EClZq62nzrP2tZSIDBg9VSI5BF9z/5y2Hgh6nkdSTQAqfxn?=
 =?us-ascii?Q?41YwjkPw2kci1+MaCAFAZne4WrUoE/qQ+IcehP4H?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b186e0e-b28f-4edd-2c9c-08dc48cd0b44
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 11:01:07.5840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3Yb97FPbeJx/MPFm2ICRfljVt9+guw8rBqFVvvcYVcdzIuGrG6aSkA5XqnTsOoiGyC6jAwMdq7NSkQ2MVMHVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9028

On Wed, Mar 20, 2024 at 01:47:36AM +0100, Mirsad Todorovac wrote:
> On 3/19/24 15:25, Ido Schimmel wrote:
> > Will look into it today or later this week.
> 
> Thank you for considering this.

Can you please try the following patch?

https://github.com/idosch/linux/commit/58f25dd8766dbe9ac50c76b44f9ba92350ebb5c6.patch

