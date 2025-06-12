Return-Path: <linux-kselftest+bounces-34817-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA39AD72CA
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 15:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 751A917A6A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 13:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD4E246BC1;
	Thu, 12 Jun 2025 13:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xj6y3syK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A002441A7;
	Thu, 12 Jun 2025 13:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749736689; cv=fail; b=Ib/n+C/X7yTP8qiYoDDxjTlxdVzaWln4urW+m0q9yXOl8IDlIACg6iMgj6Dhb1DCVm1qbuXgQwHSQN/fTxqUF4of+Dmtp7FKbk07eqoTaVaqCThE3ZYTS+rQckbezCDNFDPk88r6pQLwcpqyi2aP1o0zZ1YM1URbuuUCj9yaAlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749736689; c=relaxed/simple;
	bh=UrE0ZvHCribnAOPJ9pufU2tcxjca42KFalEPVTFUsrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hNLWC1Z62a2ioizoP/MKOgWoqJ6XcDHQASTEmNSkIK4ZAkARYudZVoITOTOnh0m7nLCli5wCKbILvUOGp5gtXhjbwUw8d/kSJdYvRWKZw7m702+Q73SBCA8K8PudDfCHFqCBuglRMDuJo4db3z6WjOQ47ZCo/h8KWAXfz0ddJ88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xj6y3syK; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVKsAEjqmSG+ykUF5jBBoSfklsIPGb7RqbVn1naHrwag2yHfzEJpbmpKxRrpfaVhD7nQbSCgSrKWcBtyKyfpoTOZlKuDuqEelTsiRokkE4uvgJ3533eTcaPcGUGwl9PWb1OQns4ihemNB+Y74C86vjXJpPKtcsGH3q3SuUxYTIi2MLPZ6pBt5m0KTCsnUpiZc9+ZL5cUpgOosU6RFdRjHrbTZwujdQ0gMRTQlfaYYgDUWxqi6TvjuONX/hf6OunQAM3oc0lwBrrhqph9GTJNhD4TqmmEHIoByHmjfV/7NWS6+HKV40Ijo0xmSdEFY+SJOhD8FtdIX7i8XV7/INVlSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lOVsKGmp81BN+QGfOlygoRCHWKqvm82kFxgGhR2RHU=;
 b=OwUO3MMqr7u/ZSNpxSI61i/XDvmpCqRDloRw8Z88e6/wG9J3P4dIxEYTcHjUZoFhSyZt18aPb9LxbWq7jq/Wo6RWI5mY0xOR7NB7uXyvEPy/wyI39dIDmdHApHAkgRl8mR3+MfvSUpBQkb3UrRkkjBBg0qhQvgMCmAGi0tg18kRtN8pJ+V/obZCEzYEBG+cWprpWLe2Q1sMTLKz2p1HtElz3H7se2qm87x1prnEJfXjdS7+yzOmXR6/O9Jlg63ZCEBat36nVR1nIuDSKyayI6bkhAFQzRSyKuCB1QNic9E7mBI1FQO2Ovn4cD44d/SwkDJkwsYLzyVIVP7i7cjZDzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lOVsKGmp81BN+QGfOlygoRCHWKqvm82kFxgGhR2RHU=;
 b=Xj6y3syKvoRGX26KlnwWAXsupewwmWHcW0ypi3MftjvWpqFkiQ3S7/y8+5MCOsRVG7WCMQzkDVmIKpnCF4maYsMRBt4hyQmZs3QIEIJh4Jo3FVPysGvMYFcu31L166UPezyYSqf9s/SPwGRBFi+a+ltAAooJCEO1iUBuGW7LhRcw0zHP62MVQhAnmsHCRYsZ60AyAJwWcLM77CDNdtycylJD1IwzU4hVcUGICJxpLMK/sVQpeiIJbDFZ/Vpb225L8cGeB+0OuhKQRST9ppH206CbCBi2C9kAHaIHk4XH4XxWqBVcE/hVNFVsHgVFyjYjJJL24rE834A/cawwdbZO/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY5PR12MB6347.namprd12.prod.outlook.com (2603:10b6:930:20::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.37; Thu, 12 Jun
 2025 13:58:03 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.038; Thu, 12 Jun 2025
 13:58:03 +0000
Date: Thu, 12 Jun 2025 10:58:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>, Willy Tarreau <w@1wt.eu>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Mark Brown <broonie@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 09/14] selftests: harness: Move teardown conditional
 into test metadata
Message-ID: <20250612135802.GU543171@nvidia.com>
References: <20250610120902.GB543171@nvidia.com>
 <aEh+DNmbZrqg6rHR@nvidia.com>
 <20250610234657.GO543171@nvidia.com>
 <aEkqtfcOJDrxAAcs@nvidia.com>
 <20250611093942-f6c65a06-c72a-4451-aa1e-8cb8de0d69cb@linutronix.de>
 <aEm6tuzy7WK12sMh@nvidia.com>
 <aEn5jmXZbC5hARGv@nvidia.com>
 <aEoUhPYIAizTLADq@nvidia.com>
 <20250611235117.GR543171@nvidia.com>
 <aEp6tGUEFCQz1prh@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEp6tGUEFCQz1prh@nvidia.com>
X-ClientProxiedBy: YT2PR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY5PR12MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: 71a30e3e-f8b0-4ae0-1b32-08dda9b9260d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iaFUEQDa71vkm4WLVXgLTuED76PpRMgNRhlBj08hwT2GwPlrEvcyHH2VLTth?=
 =?us-ascii?Q?L15xFhy5WvXrYLTPsgisPKXPZrRNf+i3E/mey0LC9SEaBWe1443SDibg3zwx?=
 =?us-ascii?Q?hCmFQs6ui1iEoPWttzAX/6G7K2UjJzbW5s+o6vyCp/xtUwd4/kd9Ke6BYHQj?=
 =?us-ascii?Q?dmVoe9ybpVEx0bL3t8ZDOijykqCqVzgzBwIJVdljsbhKPh4NNFGiHX5hwHEF?=
 =?us-ascii?Q?SRgWsopcDedrCIYPmyLqf/rzkxkCCC5DnANVvOSIU3JpIWINZOLayNvD3aTp?=
 =?us-ascii?Q?a9yTbTmI/FUROdqVmoenxyQW3jLsH9rj4jfb3BQPxs0BWZY8H1BUGFI3Dj+O?=
 =?us-ascii?Q?s2XZxBElUXdLtlcd5N2DVGngLd/L2G5Xhc1npFXF9A6mBHw9HQ6bsZd5fhS9?=
 =?us-ascii?Q?YU3BOVDQJWm7neIM1G3JPq8im1UTMUoduYtSR9cqv8M8+MzULte8eIZ4/sEz?=
 =?us-ascii?Q?axT6FXkJuXwgy1jq3tX25WxsGGeSPmZRKcpXVLIWe2YAPJdo5rgcfBGYEIdM?=
 =?us-ascii?Q?Esgml/VAnLeFZiklaISJf6+iGvfXXE1dhyMOPMy9tX+r86uuy4+RV7Enwk7r?=
 =?us-ascii?Q?zA0hU6Xbp0Ns9iA0NNTBQCdg5E7GPEeYUF52GcOAInSMSwL29bmQfMa/NVwJ?=
 =?us-ascii?Q?juQd91XeaEg1uBIFCmPXt2PqnFXP8CYQnanzBPOg2xa++eiWlyCRxWRIHBYt?=
 =?us-ascii?Q?E6OzKgS0KJrRbG3Wv5RXjwmjSxGBOWkXcsqyIBdNs53WWF7j2DuSKbUz0h08?=
 =?us-ascii?Q?rScMF4wBLz13V+DvVWlM1m8XJ6MZgy3cKO9zLl5mNAQsVSCG9WMYh6D9x36R?=
 =?us-ascii?Q?8lVg/urencgYlr9ZpfhzuoP4QZr0MODQ08vnC4S7XMLnP7CV9MH/boAHGLc6?=
 =?us-ascii?Q?9VuRFFnJ/hANS2NgMzmFa+8WPiNc+sjOU17ixeYWnknVUqvCWQG8CombwQr/?=
 =?us-ascii?Q?vHhriXDK150RuAESlut0D7vKLxDd/vL8CTKTYNQxMrt65luxk0m/ZrspX2SW?=
 =?us-ascii?Q?6FEOmAQ40qUUdsWVErbTPuADyabBldtzd45gW86yp7CJ7OCg3Nmp6FVrTUAC?=
 =?us-ascii?Q?2Mmr0oC2ycKtLDFPzUL0gJ1uqmeNDGzw0y3nwKA6tTovzpinZgis4UPBr7lA?=
 =?us-ascii?Q?hzU7r70VWjDt7ZEEMslZdHvOZxQBJ7MgiAJyIgyLLQBUeBwZdnqHRdB3Be/z?=
 =?us-ascii?Q?N/RDsf3a28JoVOVoOaqgJ6TynwQCLR87Czy6zA6cOb5PPupicHI7jmVQLohN?=
 =?us-ascii?Q?vjfbWda5Ij0759x9XJBHUtgC1XtvgXA2IHJFpamcoN0emaNs3d/ikMtIpfPX?=
 =?us-ascii?Q?pKBC/0gOpNEc4lDBkQAW7e95roMFHPXXggK+Au5Kounnzjkna7bAGXhDrbr8?=
 =?us-ascii?Q?rIOXBz77CcGZfmcWl8LLZvWzD79UfjgGKOAvBKn+DDvbuJlx5WA1CB0EGuIA?=
 =?us-ascii?Q?knwijoiEOf8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qVbcUiLQkDDjFVlvsoIoY8hk5x7jxOK5/XBwxX9aYHA84H1Flarx/7yHpipm?=
 =?us-ascii?Q?4kPrYF3xMxeQBTB6qB7NnFljFKvrcmNC0+6de5YThpF4X9emfb/gzZhGLt9w?=
 =?us-ascii?Q?0GPYx0ETUnVgY+/3/KoPQIYZ19HqFs/rjnIKn3ha1iB0ginzrV12gwnKN0J6?=
 =?us-ascii?Q?1Os+0gxEUfRmKxaFLDgBDqw9/Q6GDLaF0bhhwDJAzIDwVBYg9P6i4hgpGr0M?=
 =?us-ascii?Q?4ccXJmKKtxFA2dI7eg1gsfO9h43lS8YCECWOvHr0EgLmH/JZcFtvz9NRfnHB?=
 =?us-ascii?Q?Bc7SdX16YD1S91J27awNYDpWNn15fdbuIdXn4+mndd/h3cjUuo//MBk2TfFZ?=
 =?us-ascii?Q?KlkM0pc3CZpRBYH1tSOl+H6ShTU0q7M4Fp7vaf/O9GgHWEhfl9a7aktRdNwU?=
 =?us-ascii?Q?/zKTNP82bnQEuRx5tQzDBS1HAcfKusxtwZhwnGwNAg/TPET8i/chWzHdFkqV?=
 =?us-ascii?Q?UAyaV+rgLoY56srfDZx1+4zkikicLOQQcgECDG+XvHJtn9J8vCT8YwZtsm1e?=
 =?us-ascii?Q?5ACpqLKZXSw5M4wenuCkyWF77rIjFNMkbk0eKv6kjxn8qiYmbx+FsSzbNA5h?=
 =?us-ascii?Q?WrWyDlhQn6PvvcYxuX6zzQ/pBUp1u0wYJp/khsXRiD10cMpolrPzpC3q7MbR?=
 =?us-ascii?Q?NMPpd/5faEdsz4YX+y6hT3W7ELRgocHmc81EYoLsxAAltLor4iqiMWmwIcnn?=
 =?us-ascii?Q?5+ElsbbSDd37fncTztisG2jLydbwsww+mrGTUZgu+ZNQS5gJbTeocyfQ9any?=
 =?us-ascii?Q?RaZ8qGxVASYRu8lXzhMifRb+ekAWtVFmKkcAhxmtjFY3M29MZaqKmkFmHTBQ?=
 =?us-ascii?Q?ydSaaVRDsqJXONoubApGPHLl9bJRg2hGSBdPS8FcsWxzXAhhpiDf4nLYd1xA?=
 =?us-ascii?Q?zLz8bwUE/v5Qf3CRuW2QzmTd5rqRNTq+4Hgd6t6StY1YfYkdyrajqhQZjsms?=
 =?us-ascii?Q?jwMwwahUHVKJuQdC7wb/5DXXTyjBiIf3atIZ6GH+JuLt5XBCdkrEf7mWhUZu?=
 =?us-ascii?Q?8mPpCZ1gUgFzggQOaugAZFnElcEmQDrWtiA0VARwzR3vBaruwCCppy4Mng+u?=
 =?us-ascii?Q?lH293PBRBNKaPZeC137Ax44pcVAKCKeDVheTSN4GnyKD+2EslPkAGt/3Jrrk?=
 =?us-ascii?Q?KcS3+tU7Vyq4Sd4pvpDBeV8ou2wYXuQw4N2HxOHnTXOgLR7/rg8GShbBqngH?=
 =?us-ascii?Q?IcAGU7Ie8nl090cp8P/zt1FdoZUHlzLd2SUEp/3hJ9oc9Dr0SiB2XHvAqkv+?=
 =?us-ascii?Q?DsnAOoj4qNDMdvlNpNkf0DsKSnN1lhmmbuodpLazKU8fJ6/YzUVxSefpwMMa?=
 =?us-ascii?Q?n4zZM8RScpcuZdMeSlPJCLwxB5TgbqaL/RHlEzHHWr4RNPHjeh2db9CYhdOm?=
 =?us-ascii?Q?DVa8R+mW1fknlR7K9L5R4NLkqKZWMJUyIvC04Duh0JltePOBMhpx4ySDF9Fn?=
 =?us-ascii?Q?7z78n+Sg6VUl9A3zYEHX7QnD/z9c4mUjEh216OKqdJsMTFy4lwFZr7HYvVzi?=
 =?us-ascii?Q?sTEhhGjGtFkV4mKVXuoDxNrOFH8X7bXoR05La+pPSImolzvJdNvFvIqIeUfU?=
 =?us-ascii?Q?Wk9gQXO0nFjDkNPsjJ9qgLuYnMUL+rNogwjltiHl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a30e3e-f8b0-4ae0-1b32-08dda9b9260d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 13:58:03.0947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Ozo+G+XZw3kwv6iw1eqg4qMUHGcCK/iZZysyg4gFbZ8UUsKhFJydLQbMB/4X3EX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6347

On Wed, Jun 11, 2025 at 11:59:00PM -0700, Nicolin Chen wrote:

> We can see the 64MB was rounded up to 512MB by ksys_mmap_pgoff()
> when being passed in to hugetlb_file_setup() at:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/mmap.c?h=v6.16-rc1#n594
> "		len = ALIGN(len, huge_page_size(hs));  "
> 
> By looking at the comments here..:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/hugetlbfs/inode.c#n1521
> "
> /*
>  * Note that size should be aligned to proper hugepage size in caller side,
>  * otherwise hugetlb_reserve_pages reserves one less hugepages than intended.
>  */
> struct file *hugetlb_file_setup(const char *name, size_t size,
> "
> 
> ..I guess this function was supposed to fail the not-a-multiple
> case as you remarked? But it certainly can't do that, when that
> size passed in is already hugepage-aligned..
> 
> It feels like a kernel bug as you suspect :-/

Certainly is
 
> And I just found one more weird thing...
> 
> In iommufd.c selftest code, we have:
> "static __attribute__((constructor)) void setup_sizes(void)"
> where it does another pair of posix_memalign/mmap, although this
> one doesn't flag MAP_HUGETLB and shouldn't impact what is coming
> to the next...

This could all just be more weirdness from the above, it doesn't
really make alot of sense.

I think change things so the MAP_HUGETLB test all skip if
HUGEPAGE_SIZE < buffer_size and move on..

Can't run those tests on ARM64 64k which is unfortunate.. I thought
there were patches to give that config a 2M huge page size option
based on the new contiguous page support though? Maybe it was only THPS..

Jason

