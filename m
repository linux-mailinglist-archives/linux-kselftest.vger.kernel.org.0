Return-Path: <linux-kselftest+bounces-39979-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8830B37122
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 19:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BC568E3C57
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 17:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126222F7454;
	Tue, 26 Aug 2025 17:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dnfKmV/U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2A92E62C8;
	Tue, 26 Aug 2025 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756228734; cv=fail; b=tuSkLXKl46gvSmyX/pm85N9GdzBhHIGITZsBGyg2WbTUhzV2SHO2PCowjvyW36Uxdz3OeQ2P/7UEhy7nwWU06r6xDTso7+aY5GgkEv8UaUvG94uOr5J5/7zYgTDWkgPPpZ67XY+L/pla4LuJC5DkW9OugIFEiRB+Y8/nttdMKck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756228734; c=relaxed/simple;
	bh=D1yoPnwj2SYUWsW7TeCYn8GqqC2PE4Dpa+/nPxyqwmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tsaPBhS4Vl6l/a8dfKNVxmwtVFGt60WF8knCGSuVutBmf33u3bprXobEZEDiZLi8smppkSWXi5VhhJNvZgPHMN5sMSlCAUtXRTRsxMdUW3xzWe3CnxNZBYU4EluDrPlK9XD6IdBG3Iv3igKnaFmIv9hQpYrSTWhlRZM51R/h0/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dnfKmV/U; arc=fail smtp.client-ip=40.107.243.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZEmh0eUdMuBWz79JLu7p7vI7PHet0GFr0jatSXI5nRopcnUEpQ5re1WDeDHTEugoLv+2r6xiT4v9+cF0K2e1xoCvEmQvoRshVdcVB6Li3qkxh4E7qDavqAaonPPkksXf5L3sJBXB72WjSgiR5+e/9KSHFVB9xDZU8nrOMmUDxEFJpi7Cc1iLLdOPgJP37dFdZqAs4qSjWpzpv4HJkH5F48T67vRfccyhfPy3ZuzbF0Iwh0c4/UPitVavQHiaX0WUvDc+AHR81kby0y8iQpvK76H711bmwUBWcxR6ap11Z41siqWuJ6fHnQoJo8VrlC3nsalmKw1xJ4OSYm5j6BbRKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zi6uTY+rsHyS9onBIH1hT3NWoVWadmo2PHKh1nfNons=;
 b=Jsm5NpfXlPzAc+w2CdKW2bCvVPlqdhojHj/zEHskTGTTvI7lcwqk4EKO+Gn/FEs8V6SLt7PQ59DrDNOGXKfn1MPErXqhaScHCjgYXlNlSoHtg+FP0kRNrzfRu6A5WbqEPU7vYfUDsCA8QdEZmTn2iOFAy+VTmuox1HYBrB1BUHJAOT9QhqM61adQZStQ59yuY3Raohwlk8wP621nAYA5tbj+4o/bG+CFIkrFZigdTe8YWwRUjtjNcQdVAfB5tiSlRTcoTO+H0hxwvem8cl171TYReROIlTIxm3t6A8lbosgrX5L+nj0vonUHznkHkMoX8R4JvDUTJFEfqCdG7u8AiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zi6uTY+rsHyS9onBIH1hT3NWoVWadmo2PHKh1nfNons=;
 b=dnfKmV/UBkWsm+UJHvvZUGFEmzRItHohOsUKnhKK3BfWjIq6O4Sez0bIP3gmDqMdZRpY2nKk5da/0dp3E/rEF7m6BFrvvFEUrtx3GuER+0iT/vL6aX+WscRrxFnyzL9PZVrC+AmiJxWc1T06fql7XAioU78sXnyp6e7udDgM6xP4zlQlS2NHMi/lV7s/mPBbA93S61WlABiNxC3/40iGxdnl6waujKIJtn7G72sOlic62qdyOj+Ep61d63KcIozQaguskYGadfdtyx79FJufjmsRJ0L93bSkp/YG+RyUYF3IPXjYZGgX7xq3RQz/mRgL4q7W4q+vxudjwsdCTMTizQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18)
 by CH0PR12MB8577.namprd12.prod.outlook.com (2603:10b6:610:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 17:18:42 +0000
Received: from SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0]) by SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0%4]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 17:18:42 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	patches@lists.linux.dev
Subject: [PATCH v4 12/15] iommupt: Add the x86 64 bit page table format
Date: Tue, 26 Aug 2025 14:18:33 -0300
Message-ID: <12-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0163.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::18) To SA1PR12MB8641.namprd12.prod.outlook.com
 (2603:10b6:806:388::18)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB8641:EE_|CH0PR12MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: 35f297d9-f4ce-46af-6331-08dde4c49998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pa87fii0xhcTjM+PbajJriZr8phJEUxg2mxCHd5renAgvs9ZG6U+QIw5kYOh?=
 =?us-ascii?Q?sa4j2c/6CRH3E6ZO0qL4tZlW0aCRHmQTvDElfSKY7o0f1N+NZ/yHtJ2tY/js?=
 =?us-ascii?Q?1XkY+x6Td+Cc2kfKxKN9+/R632mBPDfMed2DibsllY5nIAdaOHQmgmGBjN0Q?=
 =?us-ascii?Q?wMfENL7aRDaKc2L/i78NH/4Z580wZApREXGGohcwJTLWhGc0KqayP6+5ZOeC?=
 =?us-ascii?Q?OHrN2TuDtqwoheBfvT3o+99Texk4F0TYg/Lc0k0fH6PS39p/kakencfUeTzZ?=
 =?us-ascii?Q?JgCG3nCxb4U9IDed5UGBOKuJW+PVu/ksZ8PKLJzF9Q2WeGd0wst7oumzCvxc?=
 =?us-ascii?Q?ago4KUnaB4CF2xE5M2tYPgm2YIdYb9bcAjpc6x/0BS3sPoesr16Dxi7IxQQK?=
 =?us-ascii?Q?aeOe5DsTb0r04sjeP9XBi91SeS8+y3Uf6rqzfF+sd0tvDl8p9kwW57A81Zwo?=
 =?us-ascii?Q?zXmmAs6xunq/jMIW6QbSIqSuCfYWrM9B7r0vI6uPwExNtHlUipgAKHLhd+3n?=
 =?us-ascii?Q?d7i8prh0NNT2G2OEAIZEKYHSRNHTWd6D0td3U2N3nueWso3BkvT6my25Bx6G?=
 =?us-ascii?Q?YKSQGNaaFQyEQDb1sXuo1wPhBRvIQb99tTSS2O10CTeS009p3EVWEdvCBUqr?=
 =?us-ascii?Q?FUZqFZDadtGUucv5d1bMYQl9QZqQZMN3I1WdKmT4nGbcDkPAuxLCjrmHrgET?=
 =?us-ascii?Q?L5Hs3ZNSBwE1HIaYMHm1ygb0ctqjcEM2z071KYHWTE1WcSEqz3sLbmmAtZQ0?=
 =?us-ascii?Q?2qsy8vZEeTlu44ZvIblkHzCkCoAvfhabry/OhbIsBOsV2u48Ndp0CQZFKS5p?=
 =?us-ascii?Q?r/f0NMhLzotFKtWMzfPu+2C72WM+V5f7bsfuWKK+PLGdo1hyQc776InYvaFn?=
 =?us-ascii?Q?q6vYUYJLdPzP5NuSC7SqzGOPZ0wIkZ+G901UaBpzhW6iIkPJW4Qvdoo7m8JL?=
 =?us-ascii?Q?DmA1vPYTC9PmXnJBaXGfCqbDGLIqJPQeoi3ODHQN86KWaqAG3WXeu9ZzH7N0?=
 =?us-ascii?Q?Vmu7n+TN29EYPpjwS0NyEQX/AkfbmEVugO6xQ6fP59A999if35ippWb54Lq8?=
 =?us-ascii?Q?ZmwwNQQkin8ZN4XmJz7MwpHkSQr07rOWXWeEOw4s5AoKOTBn8HxqHi4xt5B+?=
 =?us-ascii?Q?r8xLXx3rnh/tpwj59DFLruU9n3q4/c+9YAy3Pa6SV6QTZygyOJpkhSSNgugw?=
 =?us-ascii?Q?e/aPMmWAB3AlpHBRrVm1XMpCxHxPnbz/DuwkbAIUHQgUs0JTkFd9Se3xGqzC?=
 =?us-ascii?Q?EQY6PEqV4mQ20Aa8527wVU2XvwrqUMngyAluAxBBTb2+oRWWVb1Ozjg7ATx1?=
 =?us-ascii?Q?dowz248EUB2ou1OFg+jUrTUcvN8s5v4mBO/fs8qqLsxi1K0tdwDvPlXpItYS?=
 =?us-ascii?Q?AoPjF0qhJRyn3A1gZq59KoKd5ppMSXquLE8DOAYxM1n4TKXo8ciMy9uemlTy?=
 =?us-ascii?Q?CsnXTS6Izue+Cs7QjNJp68Do9PD37YgfTVfWom5UK5vSz3hh9/Ooag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8641.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UDBaSHTkvjILpL/0Jxh7XSjfAMPd/C+jSJwEPhqXg5s3mFVOeLJ7Q0UZ11yr?=
 =?us-ascii?Q?AqS4xiw2GVySuy/ULtWTcnezTzPXiVV0pB1UTQyOaenkhqOQWwR9wHxVf+ag?=
 =?us-ascii?Q?UZNbO55CcL7dtDDxKtozvOsbjWXtexNX/bDoXcw6YtRQi8YWQnXJpVNxfyH2?=
 =?us-ascii?Q?wzpci3EPBdIdxmnUBz1NQGiA517jaeDT7lt59bgBwH55MQF8oZXh6jMcCEK6?=
 =?us-ascii?Q?sfGUyzl8I/t5O4ESKl/wLhN5Z5Je3JsvdhWXw7lU8o/0IJVdHRHG+MpSe/QR?=
 =?us-ascii?Q?Y/2drAenCcSbj4Gt+dLpFQgHrkEFvuIZ0Vr99XZ1pcEe4A4c6gF7Z4PUtL8Z?=
 =?us-ascii?Q?lYisAz19lIrjOEj8911Fr97mvz8aM4jpvB8TnPEMq91HwjzbCVYYWjcAbj7J?=
 =?us-ascii?Q?OgEQL9EX1+6INMvQJCwkuL6mRIKZPcOEV/6y6Gtg8LCR/IdF0BJ4287Z6gOj?=
 =?us-ascii?Q?PA1KcHwuz0rGURteiilwQDuPtDYF+G/QnBsFXIMRhj6Z9J8JfF3PrL9r4YS5?=
 =?us-ascii?Q?Llr/c/9iPEBf7B5cqo4UUlrNOFrXCIskD7BAagYU+ILXsu+4Wag+URHNmrTM?=
 =?us-ascii?Q?wiPmM83g9QlceYLkWmyvxak89GaAcHTWCtxS9qQdxtzY7WsIqeWaGRXPKOKz?=
 =?us-ascii?Q?beUgAfEV14S0pnS5zQ/DC00Z1B+PmnCdn4FPsxS1alTGWrUWi7jkOs22mMGP?=
 =?us-ascii?Q?ooP5BMmEi2sTZf+IegBUw7+BXKPmkEx1gc8HH7mIExFG+NlwIGz13GYw9OPa?=
 =?us-ascii?Q?CjZ4DlWvoLQYHYK+ytucPzJkOYv8tYSA/LrXKDWTB6SnkPMF5Ji0//Bq43xk?=
 =?us-ascii?Q?DVL6tfen6s2gztQ6Kwxu2B24T6j2YSz/Rr6c6uh6N09sn3kAyLoG32lUvEas?=
 =?us-ascii?Q?30ynrEoGnHHpWqrhrzSDH855kjLieADJwHsqAtTN9TepPHvFdjA5lRojF5mc?=
 =?us-ascii?Q?ev+rhEtzkOo+vqMuD++uy5p0saUblufL9tpizFqA6ykPnZclMtaxMn2uTlfI?=
 =?us-ascii?Q?/t3iuTKZR0Pvop1LlkkI4tNIVmg10ic8yrO3RVt36vvGCaUFgmhMKnYzCpQf?=
 =?us-ascii?Q?bN5+xyGVlmm3sc+oLzOIpsuHW/5tMrc6/GQPMuH6yc8aDdBheJXFDg4tYA+p?=
 =?us-ascii?Q?XOoot6AxGSEMYEMTc99j8Qm0ORgtYoJdMEMXmSyGaVFcTwqM4OF1MrLvCXpo?=
 =?us-ascii?Q?LLcRfj67Yi+KVnq1Sirj0vqhu+HHQG4xwNxoHfdniIhg7tc43nf48AoHzirP?=
 =?us-ascii?Q?5QuxWANLRdNLdfqBIqOL9MGjZ9Z7QiHFhFXRLmK6/0bZNtKTMC+8T4FOXo52?=
 =?us-ascii?Q?Ckv1ss9uj5Y1cMGGHyM5u5Cd2xv8vuOq6eAzTnex1Fhrqo+kpBWM3yZH6iDb?=
 =?us-ascii?Q?DmVgtQmQ0CIqaCLDzmVSuTR1wvNt5f1KZE43EY49eod/it0b6b4k84AiiqHa?=
 =?us-ascii?Q?nqdJ2jjb7jBAJyQt+k9Mb1RwN0t6ZT074GM1VdcBNj8II7iNJpiGuTODWYIm?=
 =?us-ascii?Q?zZm2yyTipFnsfwo8pUqkr1I+QkAZlDwLxeIFf+kO67jBXNedh44OyMOaMpIl?=
 =?us-ascii?Q?mbZux7Twi54+QZ3Z9NeisNNGQlfWcxM88ueuNG9a?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f297d9-f4ce-46af-6331-08dde4c49998
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8641.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 17:18:40.2698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gAxBwt9a7uP/n2Cc//GaaKVfaOYhibBI2+dmzuqpXseE/O0Spx3Q6qyg4qPil6aQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8577

This is used by x86 CPUs and can be used in AMD/VT-D x86 IOMMUs. When a
x86 IOMMU is running SVA it is using this page table format.

This implementation follows the AMD v2 io-pgtable version.

There is nothing remarkable here, the format can have 4 or 5 levels and
limited support for different page sizes. No contiguous pages support.

x86 uses a sign extension mechanism where the top bits of the VA must
match the sign bit. The core code supports this through
PT_FEAT_SIGN_EXTEND which creates and upper and lower VA range. All the
new operations will work correctly in both spaces, however currently there
is no way to report the upper space to other layers. Future patches can
improve that.

In principle this can support 3 page tables levels matching the 32 bit PAE
table format, but no iommu driver needs this. The focus is on the modern
64 bit 4 and 5 level formats.

Comparing the performance of several operations to the existing version:

iommu_map()
   pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
     2^12,     71,61    ,      66,58      , -13.13
     2^21,     66,60    ,      61,55      , -10.10
     2^30,     59,56    ,      56,54      ,  -3.03
 256*2^12,    392,1360  ,     345,1289    ,  73.73
 256*2^21,    383,1159  ,     335,1145    ,  70.70
 256*2^30,    378,965   ,     331,892     ,  62.62

iommu_unmap()
   pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
     2^12,     77,71    ,      73,68      ,  -7.07
     2^21,     76,70    ,      70,66      ,  -6.06
     2^30,     69,66    ,      66,63      ,  -4.04
 256*2^12,    225,899   ,     210,870     ,  75.75
 256*2^21,    262,722   ,     248,710     ,  65.65
 256*2^30,    251,643   ,     244,634     ,  61.61

The small -ve values in the iommu_unmap() are due to the core code calling
iommu_pgsize() before invoking the domain op. This is unncessary with this
implementation. Future work optimizes this and gets to 2%, 4%, 3%.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/.kunitconfig       |   1 +
 drivers/iommu/generic_pt/Kconfig            |  11 +
 drivers/iommu/generic_pt/fmt/Makefile       |   2 +
 drivers/iommu/generic_pt/fmt/defs_x86_64.h  |  21 ++
 drivers/iommu/generic_pt/fmt/iommu_x86_64.c |  11 +
 drivers/iommu/generic_pt/fmt/x86_64.h       | 248 ++++++++++++++++++++
 include/linux/generic_pt/common.h           |  13 +
 include/linux/generic_pt/iommu.h            |  11 +
 8 files changed, 318 insertions(+)
 create mode 100644 drivers/iommu/generic_pt/fmt/defs_x86_64.h
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_x86_64.c
 create mode 100644 drivers/iommu/generic_pt/fmt/x86_64.h

diff --git a/drivers/iommu/generic_pt/.kunitconfig b/drivers/iommu/generic_pt/.kunitconfig
index 936c327f0661cf..2016c5e5ac0fe9 100644
--- a/drivers/iommu/generic_pt/.kunitconfig
+++ b/drivers/iommu/generic_pt/.kunitconfig
@@ -3,6 +3,7 @@ CONFIG_GENERIC_PT=y
 CONFIG_DEBUG_GENERIC_PT=y
 CONFIG_IOMMU_PT=y
 CONFIG_IOMMU_PT_AMDV1=y
+CONFIG_IOMMU_PT_X86_64=y
 CONFIG_IOMMU_PT_KUNIT_TEST=y
 
 CONFIG_IOMMUFD=y
diff --git a/drivers/iommu/generic_pt/Kconfig b/drivers/iommu/generic_pt/Kconfig
index 57dc81060f9f0d..8665a1d4299b7a 100644
--- a/drivers/iommu/generic_pt/Kconfig
+++ b/drivers/iommu/generic_pt/Kconfig
@@ -41,10 +41,21 @@ config IOMMU_PT_AMDV1
 
 	  Selected automatically by an IOMMU driver that uses this format.
 
+config IOMMU_PT_X86_64
+       tristate "IOMMU page table for x86 64 bit, 4/5 levels"
+	depends on !GENERIC_ATOMIC64 # for cmpxchg64
+	help
+	  iommu_domain implementation for the x86 64 bit 4/5 level page table.
+	  It supports 4K/2M/1G page sizes and can decode a sign extended
+	  portion of the 64 bit IOVA space.
+
+	  Selected automatically by an IOMMU driver that uses this format.
+
 config IOMMU_PT_KUNIT_TEST
 	tristate "IOMMU Page Table KUnit Test" if !KUNIT_ALL_TESTS
 	depends on KUNIT
 	depends on IOMMU_PT_AMDV1 || !IOMMU_PT_AMDV1
+	depends on IOMMU_PT_X86_64 || !IOMMU_PT_X86_64
 	default KUNIT_ALL_TESTS
 	help
 	  Enable kunit tests for GENERIC_PT and IOMMU_PT that covers all the
diff --git a/drivers/iommu/generic_pt/fmt/Makefile b/drivers/iommu/generic_pt/fmt/Makefile
index f0c22cf5f7bee6..5a3379107999f5 100644
--- a/drivers/iommu/generic_pt/fmt/Makefile
+++ b/drivers/iommu/generic_pt/fmt/Makefile
@@ -3,6 +3,8 @@
 iommu_pt_fmt-$(CONFIG_IOMMU_PT_AMDV1) += amdv1
 iommu_pt_fmt-$(CONFIG_IOMMUFD_TEST) += mock
 
+iommu_pt_fmt-$(CONFIG_IOMMU_PT_X86_64) += x86_64
+
 IOMMU_PT_KUNIT_TEST :=
 define create_format
 obj-$(2) += iommu_$(1).o
diff --git a/drivers/iommu/generic_pt/fmt/defs_x86_64.h b/drivers/iommu/generic_pt/fmt/defs_x86_64.h
new file mode 100644
index 00000000000000..6f589e1f55d35a
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/defs_x86_64.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ *
+ */
+#ifndef __GENERIC_PT_FMT_DEFS_X86_64_H
+#define __GENERIC_PT_FMT_DEFS_X86_64_H
+
+#include <linux/generic_pt/common.h>
+#include <linux/types.h>
+
+typedef u64 pt_vaddr_t;
+typedef u64 pt_oaddr_t;
+
+struct x86_64_pt_write_attrs {
+	u64 descriptor_bits;
+	gfp_t gfp;
+};
+#define pt_write_attrs x86_64_pt_write_attrs
+
+#endif
diff --git a/drivers/iommu/generic_pt/fmt/iommu_x86_64.c b/drivers/iommu/generic_pt/fmt/iommu_x86_64.c
new file mode 100644
index 00000000000000..5c5960d871a32f
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/iommu_x86_64.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ */
+#define PT_FMT x86_64
+#define PT_SUPPORTED_FEATURES                                  \
+	(BIT(PT_FEAT_SIGN_EXTEND) | BIT(PT_FEAT_FLUSH_RANGE) | \
+	 BIT(PT_FEAT_FLUSH_RANGE_NO_GAPS) |                    \
+	 BIT(PT_FEAT_X86_64_AMD_ENCRYPT_TABLES))
+
+#include "iommu_template.h"
diff --git a/drivers/iommu/generic_pt/fmt/x86_64.h b/drivers/iommu/generic_pt/fmt/x86_64.h
new file mode 100644
index 00000000000000..c01815b6229cce
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/x86_64.h
@@ -0,0 +1,248 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ *
+ * x86 page table. Supports the 4 and 5 level variations.
+ *
+ * The 4 and 5 level version is described in:
+ *   Section "4.4 4-Level Paging and 5-Level Paging" of the Intel Software
+ *   Developer's Manual Volume 3
+ *
+ *   Section "9.7 First-Stage Paging Entries" of the "Intel Virtualization
+ *   Technology for Directed I/O Architecture Specification"
+ *
+ *   Section "2.2.6 I/O Page Tables for Guest Translations" of the "AMD I/O
+ *   Virtualization Technology (IOMMU) Specification"
+ *
+ * It is used by x86 CPUs, AMD and VT-D IOMMU HW.
+ *
+ * Note the 3 level format is very similar and almost implemented here. The
+ * reserved/ignored layout is different and there are functional bit
+ * differences.
+ *
+ * This format uses PT_FEAT_SIGN_EXTEND to have a upper/non-canonical/lower
+ * split. PT_FEAT_SIGN_EXTEND is optional as AMD IOMMU sometimes uses non-sign
+ * extended addressing with this page table format.
+ *
+ * The named levels in the spec map to the pts->level as:
+ *   Table/PTE - 0
+ *   Directory/PDE - 1
+ *   Directory Ptr/PDPTE - 2
+ *   PML4/PML4E - 3
+ *   PML5/PML5E - 4
+ */
+#ifndef __GENERIC_PT_FMT_X86_64_H
+#define __GENERIC_PT_FMT_X86_64_H
+
+#include "defs_x86_64.h"
+#include "../pt_defs.h"
+
+#include <linux/bitfield.h>
+#include <linux/container_of.h>
+#include <linux/log2.h>
+#include <linux/mem_encrypt.h>
+
+enum {
+	PT_MAX_OUTPUT_ADDRESS_LG2 = 52,
+	PT_MAX_VA_ADDRESS_LG2 = 57,
+	PT_ITEM_WORD_SIZE = sizeof(u64),
+	PT_MAX_TOP_LEVEL = 4,
+	PT_GRANULE_LG2SZ = 12,
+	PT_TABLEMEM_LG2SZ = 12,
+
+	/*
+	 * For AMD the GCR3 Base only has these bits. For VT-D FSPTPTR is 4k
+	 * aligned and is limited by the architected HAW
+	 */
+	PT_TOP_PHYS_MASK = GENMASK_ULL(51, 12),
+};
+
+/* Shared descriptor bits */
+enum {
+	X86_64_FMT_P = BIT(0),
+	X86_64_FMT_RW = BIT(1),
+	X86_64_FMT_U = BIT(2),
+	X86_64_FMT_A = BIT(5),
+	X86_64_FMT_D = BIT(6),
+	X86_64_FMT_OA = GENMASK_ULL(51, 12),
+	X86_64_FMT_XD = BIT_ULL(63),
+};
+
+/* PDPTE/PDE */
+enum {
+	X86_64_FMT_PS = BIT(7),
+};
+
+#define common_to_x86_64_pt(common_ptr) \
+	container_of_const(common_ptr, struct pt_x86_64, common)
+#define to_x86_64_pt(pts) common_to_x86_64_pt((pts)->range->common)
+
+static inline pt_oaddr_t x86_64_pt_table_pa(const struct pt_state *pts)
+{
+	return oalog2_mul(FIELD_GET(X86_64_FMT_OA, pts->entry),
+			  PT_TABLEMEM_LG2SZ);
+}
+#define pt_table_pa x86_64_pt_table_pa
+
+static inline pt_oaddr_t x86_64_pt_entry_oa(const struct pt_state *pts)
+{
+	return oalog2_mul(FIELD_GET(X86_64_FMT_OA, pts->entry),
+			  PT_GRANULE_LG2SZ);
+}
+#define pt_entry_oa x86_64_pt_entry_oa
+
+static inline bool x86_64_pt_can_have_leaf(const struct pt_state *pts)
+{
+	return pts->level <= 2;
+}
+#define pt_can_have_leaf x86_64_pt_can_have_leaf
+
+static inline unsigned int x86_64_pt_num_items_lg2(const struct pt_state *pts)
+{
+	return PT_TABLEMEM_LG2SZ - ilog2(sizeof(u64));
+}
+#define pt_num_items_lg2 x86_64_pt_num_items_lg2
+
+static inline enum pt_entry_type x86_64_pt_load_entry_raw(struct pt_state *pts)
+{
+	const u64 *tablep = pt_cur_table(pts, u64);
+	u64 entry;
+
+	pts->entry = entry = READ_ONCE(tablep[pts->index]);
+	if (!(entry & X86_64_FMT_P))
+		return PT_ENTRY_EMPTY;
+	if (pts->level == 0 ||
+	    (x86_64_pt_can_have_leaf(pts) && (entry & X86_64_FMT_PS)))
+		return PT_ENTRY_OA;
+	return PT_ENTRY_TABLE;
+}
+#define pt_load_entry_raw x86_64_pt_load_entry_raw
+
+static inline void
+x86_64_pt_install_leaf_entry(struct pt_state *pts, pt_oaddr_t oa,
+			     unsigned int oasz_lg2,
+			     const struct pt_write_attrs *attrs)
+{
+	u64 *tablep = pt_cur_table(pts, u64);
+	u64 entry;
+
+	entry = X86_64_FMT_P |
+		FIELD_PREP(X86_64_FMT_OA, log2_div(oa, PT_GRANULE_LG2SZ)) |
+		attrs->descriptor_bits;
+	if (pts->level != 0)
+		entry |= X86_64_FMT_PS;
+
+	WRITE_ONCE(tablep[pts->index], entry);
+	pts->entry = entry;
+}
+#define pt_install_leaf_entry x86_64_pt_install_leaf_entry
+
+static inline bool x86_64_pt_install_table(struct pt_state *pts,
+					   pt_oaddr_t table_pa,
+					   const struct pt_write_attrs *attrs)
+{
+	u64 entry;
+
+	entry = X86_64_FMT_P | X86_64_FMT_RW | X86_64_FMT_U | X86_64_FMT_A |
+		FIELD_PREP(X86_64_FMT_OA, log2_div(table_pa, PT_GRANULE_LG2SZ));
+	if (pts_feature(pts, PT_FEAT_X86_64_AMD_ENCRYPT_TABLES))
+		entry = __sme_set(entry);
+	return pt_table_install64(pts, entry);
+}
+#define pt_install_table x86_64_pt_install_table
+
+static inline void x86_64_pt_attr_from_entry(const struct pt_state *pts,
+					     struct pt_write_attrs *attrs)
+{
+	attrs->descriptor_bits = pts->entry &
+				 (X86_64_FMT_RW | X86_64_FMT_U | X86_64_FMT_A |
+				  X86_64_FMT_D | X86_64_FMT_XD);
+}
+#define pt_attr_from_entry x86_64_pt_attr_from_entry
+
+/* --- iommu */
+#include <linux/generic_pt/iommu.h>
+#include <linux/iommu.h>
+
+#define pt_iommu_table pt_iommu_x86_64
+
+/* The common struct is in the per-format common struct */
+static inline struct pt_common *common_from_iommu(struct pt_iommu *iommu_table)
+{
+	return &container_of(iommu_table, struct pt_iommu_table, iommu)
+			->x86_64_pt.common;
+}
+
+static inline struct pt_iommu *iommu_from_common(struct pt_common *common)
+{
+	return &container_of(common, struct pt_iommu_table, x86_64_pt.common)
+			->iommu;
+}
+
+static inline int x86_64_pt_iommu_set_prot(struct pt_common *common,
+					   struct pt_write_attrs *attrs,
+					   unsigned int iommu_prot)
+{
+	u64 pte;
+
+	pte = X86_64_FMT_U | X86_64_FMT_A | X86_64_FMT_D;
+	if (iommu_prot & IOMMU_WRITE)
+		pte |= X86_64_FMT_RW;
+
+	/*
+	 * Ideally we'd have an IOMMU_ENCRYPTED flag set by higher levels to
+	 * control this. For now if the tables use sme_set then so do the ptes.
+	 */
+	if (pt_feature(common, PT_FEAT_X86_64_AMD_ENCRYPT_TABLES))
+		pte = __sme_set(pte);
+
+	attrs->descriptor_bits = pte;
+	return 0;
+}
+#define pt_iommu_set_prot x86_64_pt_iommu_set_prot
+
+static inline int
+x86_64_pt_iommu_fmt_init(struct pt_iommu_x86_64 *iommu_table,
+			 const struct pt_iommu_x86_64_cfg *cfg)
+{
+	struct pt_x86_64 *table = &iommu_table->x86_64_pt;
+
+	if (cfg->common.hw_max_vasz_lg2 < 31 ||
+	    cfg->common.hw_max_vasz_lg2 > 57)
+		return -EINVAL;
+
+	/* Top of 2, 3, 4 */
+	pt_top_set_level(&table->common,
+			 (cfg->common.hw_max_vasz_lg2 - 31) / 9 + 2);
+
+	table->common.max_oasz_lg2 =
+		min(PT_MAX_OUTPUT_ADDRESS_LG2, cfg->common.hw_max_oasz_lg2);
+	return 0;
+}
+#define pt_iommu_fmt_init x86_64_pt_iommu_fmt_init
+
+static inline void
+x86_64_pt_iommu_fmt_hw_info(struct pt_iommu_x86_64 *table,
+			    const struct pt_range *top_range,
+			    struct pt_iommu_x86_64_hw_info *info)
+{
+	info->gcr3_pt = virt_to_phys(top_range->top_table);
+	PT_WARN_ON(info->gcr3_pt & ~PT_TOP_PHYS_MASK);
+	info->levels = top_range->top_level + 1;
+}
+#define pt_iommu_fmt_hw_info x86_64_pt_iommu_fmt_hw_info
+
+#if defined(GENERIC_PT_KUNIT)
+static const struct pt_iommu_x86_64_cfg x86_64_kunit_fmt_cfgs[] = {
+	[0] = { .common.features = BIT(PT_FEAT_SIGN_EXTEND),
+		.common.hw_max_vasz_lg2 = 48 },
+	[1] = { .common.features = BIT(PT_FEAT_SIGN_EXTEND),
+		.common.hw_max_vasz_lg2 = 57 },
+	/* AMD IOMMU PASID 0 formats with no SIGN_EXTEND */
+	[2] = { .common.hw_max_vasz_lg2 = 47 },
+	[3] = { .common.hw_max_vasz_lg2 = 56 },
+};
+#define kunit_fmt_cfgs x86_64_kunit_fmt_cfgs
+enum { KUNIT_FMT_FEATURES =  BIT(PT_FEAT_SIGN_EXTEND)};
+#endif
+#endif
diff --git a/include/linux/generic_pt/common.h b/include/linux/generic_pt/common.h
index b127d8915d48fc..d14919f94a9448 100644
--- a/include/linux/generic_pt/common.h
+++ b/include/linux/generic_pt/common.h
@@ -150,4 +150,17 @@ enum {
 	PT_FEAT_AMDV1_FORCE_COHERENCE,
 };
 
+struct pt_x86_64 {
+	struct pt_common common;
+};
+
+enum {
+	/*
+	 * The memory backing the tables is encrypted. Use __sme_set() to adjust
+	 * the page table pointers in the tree. This only works with
+	 * CONFIG_AMD_MEM_ENCRYPT.
+	 */
+	PT_FEAT_X86_64_AMD_ENCRYPT_TABLES = PT_FEAT_FMT_START,
+};
+
 #endif
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index 58c9fa74fb0701..61fb398377e90e 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -254,6 +254,17 @@ IOMMU_FORMAT(amdv1, amdpt);
 struct pt_iommu_amdv1_mock_hw_info;
 IOMMU_PROTOTYPES(amdv1_mock);
 
+struct pt_iommu_x86_64_cfg {
+	struct pt_iommu_cfg common;
+};
+
+struct pt_iommu_x86_64_hw_info {
+	u64 gcr3_pt;
+	u8 levels;
+};
+
+IOMMU_FORMAT(x86_64, x86_64_pt);
+
 #undef IOMMU_PROTOTYPES
 #undef IOMMU_FORMAT
 #endif
-- 
2.43.0


