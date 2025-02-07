Return-Path: <linux-kselftest+bounces-25998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C98DA2C50E
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 15:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 765563AD37B
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 14:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BD41F7575;
	Fri,  7 Feb 2025 14:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sproWXJQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45641F1509;
	Fri,  7 Feb 2025 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738937508; cv=fail; b=BWJIseIDWhSdHUWf3c+VckoCOfd2LkmUsyekZ78kVOde//mWR/gY0PICJAkozyxYEo/+5wlk2aYOQ1VY5aGsXv2tnWXLTY70UcFpYMpMG9FL/2FeKo7b1HZvZfJqzzOsitF49ks1Yi5IVphGPeANspK8g6ipXfB/zDnyt8RYzcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738937508; c=relaxed/simple;
	bh=+bxhiaF7bFrKrgDKEOsvDBerqICeFxwsxv9hsUvazdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LRWMqzJgIG24HO+mu5f3fivy2ZYt48fYe6wNXvV3QjZIzkVbsG0lDRmF0zrsy7bad9O7DrxWntIh3eugwCgW/LnxkAoFMtSbKs0u/mUF/pVKyNMzemTdnKioOnT7c21+IEb0i75grmyn4QkcW0o9ZWjzFnCeVCc7s3MZoGsVb0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sproWXJQ; arc=fail smtp.client-ip=40.107.95.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyDdbr8srFSuH/2ynWZfzyubECCJcOTOWXR586DLJpHp8YgO5OGTsZDugOmzFwTnUbFNCCMhqYU/9gCsADoJg+EPib8L8XiDe6g2qDulWIfQedU1bq+b8wzAmHvVv0PIdPS436145OyIk+bmHyPG892OqJB6/B1lyyYbs0Q2af6cmWFMZ7hQRfELeyOe0M30SzYg5mEVHfWF4N/UdqCKpIEQ4juvWnCzi49YIA+Kg+bpqhRP0DImhPz/z/N6GhnnHxTezzG6gLGiysBJmyChpgKdHz0wlTRStwTItJFhOFDH3u8UAfpnkeiBdcQBwr9L5Hf9I+mc2l7AXMqu0uuPEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNF9t1H1iylBGp9kfoFugSOoJ0egJZ2N/VVJ4zrcz6k=;
 b=E5QQWaWOZ92yY1VwZGYAUNubHD/2c9KKcGT5dmbDAno7nPS57+p3BEYcwTYjG5UxF0dk3u821JPZ6uIFr4MNj5lX8mD4XNfKvKC95jf4SAF8Ci/WEGyio8LA0FTb8q7ziYCUIp7zZj8zFLOdFWMKT8qA467xyplXlFv6NwZRxGuJGedapGajlafGCaJISnkcuFgxrsv2ow458sQ/pTHzf5YSK8LzBACIlvrm1mZws/UhdHR5G/RcgfBbZ543OYs6WHE5QrxgPQuw6IYJ48w84+vYywGguAL1angFx4jixFRN7J/mX504taQxrzhiHDjBz+APAxFcpPcupoLysG5mqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNF9t1H1iylBGp9kfoFugSOoJ0egJZ2N/VVJ4zrcz6k=;
 b=sproWXJQ/RPT8DHXlitoK7Ak/OrEj1U+P7sfTayt1eL84FVcZrSCHJMLzh0V9tQfB3SRAZs2Gtx9e2jYwh5084/RUYh9gFd8CDEq1fhf4JYXY6aFF/XhvVyQaIgaCcvYoGEgCBk61tAm3tC+W6lUGT+b8nGVID8HvLIVzx9HB+shbOiQXOGrL5h1CKnEwfsShCGAFgwDspucInsGLJw2bC1muFFKuvLgjzxxYZC5ZMRz/uKgtWOCyMT6xeH78GbD9/+3VVjZ/TcjcSKJNr7qnsX2gOvHcZotLW5PC8knBmFtvMiOJbwEPYkyRmmZYZ8vbc7PHRVZXP+TfmnPFf0yZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MW4PR12MB7312.namprd12.prod.outlook.com (2603:10b6:303:21a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Fri, 7 Feb
 2025 14:11:42 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 14:11:42 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-mm@kvack.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>,
 David Hildenbrand <david@redhat.com>, Yang Shi <yang@os.amperecomputing.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Yu Zhao <yuzhao@google.com>, John Hubbard <jhubbard@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/7] Buddy allocator like (or non-uniform) folio split
Date: Fri, 07 Feb 2025 09:11:39 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <019EB6CA-0F4B-496A-B2AE-A3A553585281@nvidia.com>
In-Reply-To: <20250206000111.6c54e67d1933f8bbc01a46cd@linux-foundation.org>
References: <20250205031417.1771278-1-ziy@nvidia.com>
 <20250206000111.6c54e67d1933f8bbc01a46cd@linux-foundation.org>
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0420.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::35) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MW4PR12MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: 11adc471-c64c-4090-9fa5-08dd478158a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wNBNfR8DWIGBmUJDaoob4pVClYGkfhSdNAjsAtoKh46hsS1Q25v5yPocf6bo?=
 =?us-ascii?Q?ETP1e09vLKX1/D2GB4IXGVE2kYd3GhlOIB39wIXZBWpdXMfPf+bVmJjbNACz?=
 =?us-ascii?Q?xfwojERmiRUKO45wzscjJPMSsu+Kg2txJb+zMq3/FwUEOALPdPDybBq5wJcd?=
 =?us-ascii?Q?gmKIzSYHlrlBHhHnfiFi3YmgYAz3DY90oRN0GUHv0fBN3u+M4BqHrw2vonM6?=
 =?us-ascii?Q?k/F1tkAzvanzwFJmdQHwspOwYAhQLXagNd6c2MTcIA9BKc8HdTU6IEugW7cc?=
 =?us-ascii?Q?KoqqeL+mL37HGby8XmuJWfR9F4XO8i0gKcIEp8TpVLfrANwj4DFlGMDC4198?=
 =?us-ascii?Q?cDQymmJPqVFofW1FIf10D6BMqGDUDkziWuY74KpK2BCmFHt81oUX/M6zwl/Z?=
 =?us-ascii?Q?Ocd3uRXdzfn6awVRIuS2NzI+ClVyUWkvzYWlH1PjVsTvO0Ct4oLwcuG2BmRP?=
 =?us-ascii?Q?9D2Pme7QFOztfwcmG4EKsXuSWQpUXqQ+9clntPBPNmL26HMR01sFBTxkWEOa?=
 =?us-ascii?Q?mOtBp1Vban9vZrFVXkgsgA7h/4kR7pSlbJfXCNVTi3p/JWvyXcl7pJyyT05r?=
 =?us-ascii?Q?pCV7hvPIn9Qzmc7ts/Inps3eQBoPBBbFIEjPoGeUjZAT57YnadPhLjxfHv3t?=
 =?us-ascii?Q?OxqJD9uuEU1TaKL6uZObsX+HTPwprIg9/o0BwLbNpEjS1siGBVPE8CLFQTo3?=
 =?us-ascii?Q?okSUPVwxSY/HeBvs9P0sWNLRkfjCGK7/4EJX7d5lB46OJCEtiwNngzj9E9Cd?=
 =?us-ascii?Q?sreqRSP7k7sF/bOPzMK1AZZb7+20VVmEtammk5REGFi82UGDrZXOxuP8wetA?=
 =?us-ascii?Q?Wg9+0XBskpsZ70rZCITkEfG4srEc1iNXZ5015OmPiG+PdlNOVAx0EQjWLe+A?=
 =?us-ascii?Q?auh9EUYOIQsjqy2tHtaZnIrD7QNqzrii70p0MhFHjLv3CIziRu5FUlz+ixrh?=
 =?us-ascii?Q?JtD9NOr0RVMY9TztDWKQOM2uO7Ryw5+zaTpRciQIFYcGMUVNsw7SUdLzjQu3?=
 =?us-ascii?Q?t7y+GCPqZnDP3wevudkL3pb4hEuN6OYbd+6Z1aO/LCVvEqVI36I/BgVRI+Un?=
 =?us-ascii?Q?36PeKfSgJgtI/k17jdVfk2hwhKImIVcDJH8cz09svTnNwYc2AQwtPXrLNQcO?=
 =?us-ascii?Q?rHl1EIPErAonpX7HC45CvoDYkSwLO9aIGz1xfAs+MgML85KlNIqNK5e+ofX1?=
 =?us-ascii?Q?2e/tDZnxhdtEq5nhHLn1w2TZwAYaNjw5vDV9NowC2AXSd4B8UFHq6Zvo+N97?=
 =?us-ascii?Q?o56WCBxO81BPVbEf9x12jXeMYLPigPYcfB5MmfrNKXehSJRMRNcQ1l5o/rC1?=
 =?us-ascii?Q?9NZAQsZ+XLIYA+qCOPtIt7DcnWyz8ng4bp4C8iqSniKldKq1eiQo9iRrf5Zs?=
 =?us-ascii?Q?OWhmlRw+eeCd2cfEhsPCxVpJrrT7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?siWhneEoqq3weNy1LOQd5C2QhldlhI2W6MAF86HhI3TQLDhXSlr2ytOvni6T?=
 =?us-ascii?Q?2KP03u63N87lcwBUFDznErigvXkQi1UTyfUqh/pfgD0J92b3y4diDZRZDkVo?=
 =?us-ascii?Q?v3QqWhMtZf9vmOLO0HxZNssLC++mppDe+PvvwjICfVCMyKXAih2e/HkHLsAe?=
 =?us-ascii?Q?T+KQXB5oOTT7T7omtO8F8u57hwCylJgpo84yNz2AYHW9vZsvtoE7w6zr2Nrm?=
 =?us-ascii?Q?cT8b6j7k3bNwt1VHT0QQKly/4DSoSup3XV/ggzsTwOi2lmipsWJ8E2croaLt?=
 =?us-ascii?Q?a1Qi2P3PX0Mk2nWLlTTuyH9ir2Z+oN3o6CMYdeBjkn/jTsrDJkRVR+wurvnn?=
 =?us-ascii?Q?rU++hG1lhRY3Zjl/NR4NAUyJjBV7knAx71lwm6aqSNZokkfXS17k9nBuzpLt?=
 =?us-ascii?Q?j4P1flqFnuKG7VCuJqowemnEmOvpcZT7ZiA+Px6xolvRuFJxJfMb2Zm/EHnd?=
 =?us-ascii?Q?s4p4iaJT5LQ3WQgfl1ggWUCeBrLgcMELOqc7AZgGQZDoGphatfaRuLbddGeE?=
 =?us-ascii?Q?OBAM8iC9HvbGYqOSyCgfe2ghEpWc4XmRuSMYxJxVJ0UyjDwY9kem3D4rkboE?=
 =?us-ascii?Q?/Naww5xvNY5z+URwHYPEN9jKRZ6ksqgGo79lVT0qR8YgSRUOHyElAIprJfED?=
 =?us-ascii?Q?lYw6gfpW0eUBbXgz9w5xwWK07a1D0dGr7WJWQyp1WgXVovtar174sS96SHmB?=
 =?us-ascii?Q?r6PVZn+Jkyyp7yN6yhB7Gc0FhrCmbIeYsWLw4BXjAvDcehNSc3QEuQUc5HXK?=
 =?us-ascii?Q?oTfb9GDoMbBdDNb8eLii5I/rF2qt/O508pA46Km0SpDEiXM08CI17d0a1Tmp?=
 =?us-ascii?Q?wySQYVwJ/G9N8DNkhvQPHj6VDwWig1pj4M3qVBi5JSk1GQ83IGxVCgsq1RDs?=
 =?us-ascii?Q?+4aXAf85J4JlQRYS+JUACkwG75VfwTB5YRXj8f4tBntEKTd8KuDU37xCQmXt?=
 =?us-ascii?Q?DVhkp9JGbr2GxiS62qT90YUpjhTLL04hkZeZ6SzxaqdF0cjrBigeebpI8I+6?=
 =?us-ascii?Q?/he0/UPJ3Byxfjz8gU9zjOy7Vq3bGQy36JNP8rd9q3WT9fQlq3K/k6WXrnAn?=
 =?us-ascii?Q?3zrS3xciv7IfFVKxHEFVNGwZJ696X03j59xvMSX0UOCP8HmuYImsfYpBeznt?=
 =?us-ascii?Q?KEAHX+rzdm6nfJYxF0LyV169TOmLYi5ZcxgozXqLbOS0rh5idCOdYN+rT+4z?=
 =?us-ascii?Q?yIs8efBRfU5DmhydaknUMeRyUBeo9FFhjDgPbzlFqXk6h6+M818Dfur2/Xif?=
 =?us-ascii?Q?DDY2Y2Q5a3SuUgidZp5oNcyvBRDgqj4RtTBAP3w5s86dFQ2DPlmH+tWIK+WO?=
 =?us-ascii?Q?ZnF7iOEBf56a6Aj5duQhy9pBnBc+pPx7D2IXkx7bmJbO5uANP6kGTCqr8YXl?=
 =?us-ascii?Q?xsE54V6Q9OKMCsnnp6tRU8kwZ8TKjU1waFXXrHPgB3A9sXLfr/n6X72DVqMh?=
 =?us-ascii?Q?PzoUBMEjf/32taYKBcuyn3KPHlXJceSWtpUU9x7ljRR0B6cg+DEkm26tRqom?=
 =?us-ascii?Q?JfUDihcJNPveBDSnbSP/S6L7VXVWUzjKEeNTODXgdIwiDXlo6vswlXAbBUmw?=
 =?us-ascii?Q?yJosexvByCL6ylfsO2pP42zfvAw9tg56qwh0rr8k?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11adc471-c64c-4090-9fa5-08dd478158a5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 14:11:42.1208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NkYclZKLdjYC2mE/oWhOi2voY7DgZoxc6H4GgAhyI+nXrauQBax42D2i1imj4f27
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7312

On 6 Feb 2025, at 3:01, Andrew Morton wrote:

> On Tue,  4 Feb 2025 22:14:10 -0500 Zi Yan <ziy@nvidia.com> wrote:
>
>> This patchset adds a new buddy allocator like (or non-uniform) large folio
>> split to reduce the total number of after-split folios, the amount of memory
>> needed for multi-index xarray split, and keep more large folios after a split.
>
> It would be useful (vital, really) to provide some measurements which
> help others understand the magnitude of these resource savings, please.

Hi Andrew,

Can you please drop this series for now? I find that, after your above request,
I misunderstood how xas_split_alloc() and xas_split() works in xarray, thus,
my current implementation allocates more than enough xa_node during non-uniform
split, although the excessive ones are freed at the end. It defeats the purpose
of reducing memory consumption of multi-index xarray split, even if
folio_split() has no function issue AFAICT. I am working on a better
implementation that might require new xarray operations. I will post it as v7
later. I really appreciate that you asked about more info above. :)

More details on memory saving for multi-index xarray split during non-uniform
split compared to existing uniform split (I will add this to commit log in the
next version):

Existing uniform split requires 2^(order % XA_CHUNK_SHIFT) xa_node allocations
during split, when the folio needs to be split to order-0. But non-uniform split
only requires at most 1 xa_node allocation. For example, to split an order-9
folio, 8 xa_nodes are needed for uniform split, since the folio takes 8
multi-index slots in the xarray. But for non-uniform split, only the slot
containing the given struct page needs a xa_node after the split. There will be
a 7 xa_node saving.

Hi Matthew,

Do you mind checking my statement above on xarray memory saving? And correct me
if I miss anything. Thanks.

Best Regards,
Yan, Zi

