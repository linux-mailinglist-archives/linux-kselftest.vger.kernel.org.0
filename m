Return-Path: <linux-kselftest+bounces-40918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 369C8B48479
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 08:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D123D169A3F
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 06:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEBD2E2299;
	Mon,  8 Sep 2025 06:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QOcGh+1n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405B12DE6E3;
	Mon,  8 Sep 2025 06:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757314359; cv=fail; b=n3crDJncTlKQxVwYC7YqWHWuHJTTLiSKIKjNBX34jriSLGyALjdz1R9HU/wctSV1jVHLWRNdpUEHEfXWAq8rc64Vy0m3Zoaqe+dSKBT2UjdkQIQ4SPrvasRux3xy9Dssj6835/gThugA5iAUXv1qNht1ZosQfnVs2kuu5ZjvLQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757314359; c=relaxed/simple;
	bh=P1aDOixcwT2INOYdsq0zWf4jUVPrC1jvx+WyW0xq6QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WUuvgy30QL4wmS1kzUjc6RwGDrbzWsZnABL3gZiu+/jyHlSeVEKPzHePpm6gnbq02JX8ILzUYA/kL625UafPVJSi0+BwfvkOBZPErzN9AcBWFMKAg0O/tlsuCu819XZTfFD/RNnu+2r/YU1mSjb0aU83c6PKJfhUcOUmViyEy0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QOcGh+1n; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4XAKHLC7o2rhBV4Ang9zNCcltGHQ0uUN/rRE5H+5zPheiDZ3fENUgFIDGknMZJYrd615OcwAtWjHNZrWlOzWG40QpGSOP3OvwLWr5c0VcLSQKu1zH3GJvYmtGePW/XwQmNQJqSiFl7djfRgKnlAorvmwOqjz2j4PwwnFlg+MdsZEMkQwCN1NUyhVh0P8sKEbxtXnAvUn4xUAegHfq2SNo1zgFhFXpYiAE9Tbn9j0Zv0O7MgZv+/DENBgtWZDlg7fSQP336lCbAOfaM2C1MMXqOz1qFhOf4tny06YnC45c27F4yRNXWTA+IOgcsuWvAwIOHsw2pJMzjfFA5TPWlzMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9x5FfoPfuqrTepdX6Uu+nTG1+nuQpo7GxJXoVJc7+E=;
 b=aZVD+YmU845Hs/vVE136GIPgFs+qdzBK6U6sVn/eGf20tNYpPs7LxJVtGe/+vJxndatEYvavy9f+PUFFcSbuHvF6EZsj/hh79j5j4kbKBpytbWS3BBMs34H9ue9wmTxvImrjPNC/cuEcKLqZwOZ8Xk59hu7Kuvuxfgg/tHKpPpUEbPPJII4lr9SH+085WWahJSYR/+xjdw8Do2i/KTtHd6BvP4tXmNQ5b477TQ5jMba/MKY/6PkVP1Fcin/PWtlNVN4Kven7YRmpruVEnZWBY3x/3xNwJav7QrGSxfk3dCemL5VLM4fRjic5lkTMgM6T0jI9JAV5tGw4Kf0ONIN6Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9x5FfoPfuqrTepdX6Uu+nTG1+nuQpo7GxJXoVJc7+E=;
 b=QOcGh+1nqSnPD3zDGs2f3AJefvoiNk7YPrRptALU4mzHLi4QVUhqdB1Ouqj1WP41LNDQ2AVrIBf5OKtFY/D+NLEzQPa6pebGqelC9MgW5VeQDMqKmXS2tBfQpR+xvcX+z8ju6MHWZK7v5p6CVNAX8Ft32WVfaQ5jlTuVYZqnmW5ETwwNvjM/vhw9SqpswjJl84ilRE6WNbO+h6CA/rCwmUpUnZnu8hfid+I/cobRZtPXd5GiyVe9QAGKN1gIlnWmSJX8iGizmMGnDjuekpbVcRKx4fnDDGra7ABMWEPS03D5h10LEsrD9+0s9NRdbN1ZivsjJUksDZrGZjc/90iYlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 06:52:35 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%7]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 06:52:35 +0000
Date: Mon, 8 Sep 2025 09:52:22 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Andy Roulin <aroulin@nvidia.com>, Yong Wang <yongwang@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Amit Cohen <amcohen@nvidia.com>, Li Shuang <shuali@redhat.com>,
	Alessandro Zanni <alessandro.zanni87@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] selftests: forwarding: Reorder arguments to
 obey POSIX getopt
Message-ID: <aL59Jl5p6bEtCAxo@shredder>
References: <20250906170440.3513399-1-mmyangfl@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906170440.3513399-1-mmyangfl@gmail.com>
X-ClientProxiedBy: TLZP290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MW4PR12MB7142:EE_
X-MS-Office365-Filtering-Correlation-Id: 174f52a7-f2fc-4bf7-0c96-08ddeea44a88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dESi7sh4JsjINeWTEOlrMjfUTRVSacEJqSjynqjtQt1Zxu2h0/hLpTfx5dFP?=
 =?us-ascii?Q?nx5sR6B5REvUXUazn/mGN1oMIWJpfNAN1gscPH7P1NBxMJitDgOu/kL2jDDA?=
 =?us-ascii?Q?3wVkQvCb24d7af1t1+oIWso3PkJkHa7LvGV0MSaH8FtErKE0FyeO4dXm+nu0?=
 =?us-ascii?Q?NByixslU2JIrVApieAnNKO+4PBPLaI6GO29R96TGKlJU17U3lvDFePxKJ5ZG?=
 =?us-ascii?Q?6ps/G3wLJyTcX7knELrMb54NyM7H/PHFE7WugOUP8no1Sj/BepW2r/7/NcNw?=
 =?us-ascii?Q?xNJYdRhNohnDZ9BuYoIq/gLueBkza9ao69wq+SomCEO3tb5oC99aEE+qIxQh?=
 =?us-ascii?Q?HiDsNDdUdHDdj4lM1v6p3pFbGcu1nCsbMIGsXUrM4EHw1fiEeVzBE+1LTFqY?=
 =?us-ascii?Q?c5vUfeO1pvoLuelinRjeRbFKEqsXMuPL512kAUv/LOXmiNp9UO2CO5sOel4f?=
 =?us-ascii?Q?TmTp5Mmi5MFcBIXI0CBYpiCyRAtCd0kfkEanfe1jdm6Acv3VEgGrlxBlsWkF?=
 =?us-ascii?Q?2as0lixh1MDsT/fhFroMWWwxEQ+2Tq/O0cdxJL0RmrHMX0cT9XcZoLUUkixr?=
 =?us-ascii?Q?9xYN/vJpjw3yJqV+dUHA7nUharfWidj2i2CyzkNctRErWgKc4Qkg8YLWCwoG?=
 =?us-ascii?Q?f/bg3AwUE1/igkDZjveEA893bn6+tAXuV9co7oUX83/BdeBA+7105SZflV9p?=
 =?us-ascii?Q?hh5wih471T7HXXOxbFe8O3v59WKMMXEt0X3uU72I2ZHMdA07CL1gUNHRkUA7?=
 =?us-ascii?Q?BD7wqQlWbIb/CCWyVw2UaAZOJZLqu5fpbnG2znzoK5sI6eWpf2Y/UPuYCT4d?=
 =?us-ascii?Q?Rtn7d06uRpdE3pw1Xnv2CUeGumoMbAJlcpImfV4djy6dmJp1W++q/RWERY1q?=
 =?us-ascii?Q?/PUTq4v0PNtHGib4UfHrRnporzT9F4rFE8aX3pTUlanv47AOMAXjdoYaQkBT?=
 =?us-ascii?Q?0SFkvLw2CvYi2PILI/EisbWkeYmra+6boUJWlCTiJSX4ZT/Sk/5sZYiBB4Jn?=
 =?us-ascii?Q?y2YGjJ3LY5qfnUBRgJwTd7YdXtO+sqyQd7gXbVCn9qGTMVDBgbXEq6VqMzjs?=
 =?us-ascii?Q?x7/4LOmybf20+kTJhT/mE1J+n7fuKnUt035PuFE70VBnqaHAA0wAGTiTDVsP?=
 =?us-ascii?Q?jJvkAo1aqE2YFvJv7SxWGu46SERotRqTlZzD8pb9wMJbnv+fljvTH7xlSphb?=
 =?us-ascii?Q?Dh7v+j1DSprMTD5glBgYbaw92tdX+9d48GOKVigbxOEgxWYI94X2pQTBDHuy?=
 =?us-ascii?Q?gSgsJActx40KJlE2XIN5mvuSeLuORBccHzfMRFQC3OfVvx/dmWSv5ZoQSCEp?=
 =?us-ascii?Q?TomO3S/zqV8WJJ031cNS590Y4svkka4fQ1DV2mQ9+4Ip+zacfllizhmD8mWy?=
 =?us-ascii?Q?/yABaYVsbR+5bGvrAH1fKEiz7OD4znkD2hjcg29jm1XaWhIoj8kXP69n5LkN?=
 =?us-ascii?Q?FtJbk7w9bW4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ykPosZy6IHHPddqxD4AnckrQGsJFBOUMg9p9Vlmr0RIYx/yU1To1uKGSWuMQ?=
 =?us-ascii?Q?ClaxlUKYnnBOsAF6i60QltHWvH3MjB+5rdaGUpL/CctCZsyn4arCefxMjtmJ?=
 =?us-ascii?Q?Ro2gvy/g6zFKwPu9OSUXT8QgrtiktwLKVzTtb9seno8i/lF0xHonZqiBGUY+?=
 =?us-ascii?Q?MrG1e7zDYCQ8uJCNksKDaQEL1Esko5hlzGAocsGs1nx9EFpjwrLNr4VoyC0R?=
 =?us-ascii?Q?TYizGieLiu3JAqcWqFDkZ1gB6OTwxTidATIXSnnFfzwpolvATGk+MdlRuIZR?=
 =?us-ascii?Q?QykU7NUeWWGJzOYXO+leYzz403U4CR/ubfUSf3uHuyroTN+9Cxh0jiZA75lq?=
 =?us-ascii?Q?dUDo/6T+o8/sXP8ZzRyqZ2A+FWGXs1bZPTi+t9a0zy6McqoccCLPhvVAhJRo?=
 =?us-ascii?Q?hbBiSZaVn73yTVQq+1CYQd/3a1u/Ng8Zz/3q7XPcoqx0lyy6iWUPXhsoS90E?=
 =?us-ascii?Q?n7yDO7fI9CZBHIhvhG9HT7gM98B22SHcy7xUGMO2hZc4338ZWQZDau9K6L0O?=
 =?us-ascii?Q?1Z0/Jz0CFAIyr+SfZBl0/bPopZYNCSC+kBfG1RLwFNpzwk9gGiGoJCkyoFFS?=
 =?us-ascii?Q?xpy7kTTcm0koUN4Jb/tsQfFHCtq8KdRka+z5bCJCPDjOs/Jct6tzx/IazYJT?=
 =?us-ascii?Q?b7s2KqkygxZ9nNXAvdelTaWiX9aL9hjfzBgA2uhOGTxmLy2satvWaJNo1+gS?=
 =?us-ascii?Q?/C3yflJLLimu9CcMSBKqQJZdFLl7F0GMrrB1MzQB7SQa4XQW5T9inBrwt9bz?=
 =?us-ascii?Q?DQKYxDUc6yEvlr7o9a/cuqN0fcSG4gSe26xMG/boTGEnzV7gsIZtnZc3SLoZ?=
 =?us-ascii?Q?6XIS0NlLvZ/CguvL6qeDB+AuegVyUmjhHp/BbjgiZQe/SHhozS6tQb1pRYDB?=
 =?us-ascii?Q?HQSXz4kwHeoCimL9fxq+ehd5uLFG7rG8MfFc4JNxB6PIYFoWI/v5PJt4oIi+?=
 =?us-ascii?Q?OvrwCCrQPTDUBKFn2/kMfRbXFdUZ851UGShu/ECrT4Wpn/bKxT8zwHGbfI3A?=
 =?us-ascii?Q?1U3FfCRl6sgewBq7YWPnTpTULlqmUM8pmV23zZ4+7G3tt4IL9sV9EtPDYT7+?=
 =?us-ascii?Q?o0OguOGQS7ncl4SeXUWPZXZjDDS/OSug9QxXcqEoFTCIcbOiXMHxbT+orvaX?=
 =?us-ascii?Q?jxxqkxrNKlTfMINdnO6IBFfrA4RssxKGTLX2xddou4DOVvcs//SqdPGqlyPI?=
 =?us-ascii?Q?7md1IhkXVByzuEsEciw6+xRdd9E5iYRo+0SkrdD/DNlrw3WuwC1RT86/766w?=
 =?us-ascii?Q?KqVj+5H22ANeN7dI4ponGVCSRJUcNfMxXTTcnudMvc59Zei/0Y7pNPJjuzR3?=
 =?us-ascii?Q?dRvfSCSsUVBnxKNwnTLJCPP5E+e+iSJc0NK2CAX3pLxB+w7LkojWNLH3YnqV?=
 =?us-ascii?Q?+vvR0Q8cvEn3xyW0nPUgWofNszOkY8ObIljtXlAt0h0Y/SSNTPmuAzE/0QWQ?=
 =?us-ascii?Q?LhDOFgl6bsIqwKNtSp7OaCGqb0vRUVkRgLwcgu1Krka5/dKQSTVIKbzh9aqh?=
 =?us-ascii?Q?8mqWY/sAA2+PWvzb8On5NIPBfazZaGReb96bsRuHPGdAPXAZ38LpZjbq5ZqO?=
 =?us-ascii?Q?Kg1vkEjtT9HXN1H+qtlZ/qzRxHlOtPwBJR/atY77?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 174f52a7-f2fc-4bf7-0c96-08ddeea44a88
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 06:52:35.0825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q55YPaxaunDGtYYzEjiblcpdzus+F8gJlBj6h0MJwTg1Sehv84KSMBqsC6j+GcrwTUHxnJkxfD4w99XtpJNsvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7142

On Sun, Sep 07, 2025 at 01:04:35AM +0800, David Yang wrote:
> Quoted from musl wiki:
> 
>   GNU getopt permutes argv to pull options to the front, ahead of
>   non-option arguments. musl and the POSIX standard getopt stop
>   processing options at the first non-option argument with no
>   permutation.
> 
> Thus these scripts stop working on musl since non-option arguments do
> not always come last. Fix it by reordering arguments.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> 
> v1: https://lore.kernel.org/r/20250905173947.3164807-1-mmyangfl@gmail.com
>   - fix CI errors
> ---

A few comments:

1. You should have "---" under your SoB so that the changelog is not
part of the commit message. Another option is to use "git notes" and
passing "--notes" to "git format-patch".

2. Did you try a newer version of mausezahn? Seems the issue was fixed
2.5 years ago:
https://github.com/netsniff-ng/netsniff-ng/pull/237/commits/f5dce56e74b005daec72c771d27d55964aa8efd7

I feel like this change is fragile since current usage is in accordance
with mausezahn man page.

