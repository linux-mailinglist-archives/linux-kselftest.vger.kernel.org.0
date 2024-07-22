Return-Path: <linux-kselftest+bounces-14025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A2093971D
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 01:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50CE41F22147
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 23:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F625A4E9;
	Mon, 22 Jul 2024 23:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q3XvYOAa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B998417BCD;
	Mon, 22 Jul 2024 23:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721692198; cv=fail; b=HNxCc4QwaPMonc0JMUengK/OzuSz580DSCvSkVpTZcEchgIotefuWzw5vQUwlIkEjfVrebFSUQmcgHTY+2sL5075e7EelyKN2IkC3yuleNkIuXpfIm+OXdnTD6+msv5dFEURmPQUPQ7cyrXJ3I+991N5ycFWghEa51ICaQpDgSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721692198; c=relaxed/simple;
	bh=3mJqeuo57AB+XYTC1Ut7MxxXv0UJN7yxvdXBnVZzaTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rRNR3MMSxXGd3R6EUfWyuZoQiZtQBFik3a5/kvLz/o8st7LRW49U+AL23Cj7B9PdAgitZKarDBZdqVqzYVdPj9By4+3qAPzTSqmysz1gKM3HT4/fWqd+I06a0PiQQmKoQovPJCa2ZcdqAwMXmhPappd+1PHLbqhFWsfDg3YbBck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q3XvYOAa; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CSPvSqcI0L1tBEM7GmO5Di1RsiHQeuFdRUJ7OfhThanirLlIvvoHmVnbZ4d1AV7VENk9wUEG9X1In+kjoDEY1p2OtLKr6726ga0grV71+HPKx43Vh4BPtkLW4dhD64aUxZhORxxGRGR7rp6IAoIkqyXJK6z3YZsPR5ekEphN4L8tzgpPW7zTtd0NkWddo0pli/C+fmlNt9RmxMboOmytxWLjJ5yn/rISKgb6+deXJWA8fEup3jJU/72lKPvon6TSRNQpjvLNb5UH0BrNWqEW2h9sgKHYbKCbBz+kr/WKTXzZ6YwPwclvW6oYQ1Q1qQuwIjXvjnTEZjgMNV3OjgdCvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTb0VBh2l5KyNbfQXO5J0dcduBA9qTcnCOE6hvP/aZ0=;
 b=V3CMDLQ+apA0317NSTOWKAbppe4In9GR6B83t4ttp9A25rnQk9H1aVxbTXS7NqI5TxHVNwpZvGUxeldHZws/Xdkm2h0+I0koM2DuKM0Kl7CMuGpWawfSunfgQEzdLiwf8OinfDQdYL0GiRou/qW8C5b+NUGHSuO72S9E2IFk4pCg8Eq3Ykcjaw+HJx6n2Z73W7pmd8nr4LMGj6FPtmi8GdWDPUk01TWEVFWT2GRNpZcDCYG2EbASprx85HjsYEIRlJ55O56kSl+9f1oFu27eIsAYoOFFPMLbAzXCL6aMOfik/eFS+xq731DjZx/ipxEhSIRLQ+StL8I65Ejmk+zCYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTb0VBh2l5KyNbfQXO5J0dcduBA9qTcnCOE6hvP/aZ0=;
 b=q3XvYOAa8Oh4dFDi7F1K3j/D+J2zBp+rqjMeo44KrdbtmCxa9Ceb17vs2II/76RrgRSlgCHfy0HCGKh6BDEQMnpEUHbqM//lsp/nBbG1sjJ8BNcMRjnYnreFqN32+sn1yk+0ZcME9qv/8+1617r4caCTsc/HyPfdCXO/3D9O6ZsXXvyu7u4IJPxWeo7vQOC2NWYEd1k70gzRLZmoGWJe3moRVjqE4/e0hnLmZWSEEQW1DIIckw8J2Pjwh07lrN5xltZF0eM++M4uEBtx3cFL0hdGrs4iYe+8Jg4JScKQh1u+QO3exx1xfpeSNGD/CMp6uR7x0eVCtQYQtAHrVzOI2w==
Received: from BL6PEPF0001641B.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:10) by DS7PR12MB8276.namprd12.prod.outlook.com
 (2603:10b6:8:da::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Mon, 22 Jul
 2024 23:49:50 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2a01:111:f403:f909::) by BL6PEPF0001641B.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Mon, 22 Jul 2024 23:49:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Mon, 22 Jul 2024 23:49:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Jul
 2024 16:49:36 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Jul
 2024 16:49:35 -0700
Message-ID: <d91ed522-9df6-4a83-9cc4-9f71f160f3e4@nvidia.com>
Date: Mon, 22 Jul 2024 16:49:35 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Documentation: KUnit: Update filename best practices
To: Marco Elver <elver@google.com>, Kees Cook <kees@kernel.org>
CC: David Gow <davidgow@google.com>, Brendan Higgins
	<brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, Jonathan Corbet
	<corbet@lwn.net>, Linus Torvalds <torvalds@linux-foundation.org>,
	<linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>
References: <20240720165441.it.320-kees@kernel.org>
 <Zp4spjsaqQ85fVuk@elver.google.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Zp4spjsaqQ85fVuk@elver.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|DS7PR12MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d0d4c7a-01d5-47c0-186f-08dcaaa8f9da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTZndFkrSVFmbzAwbjhsK3EwUkFDQlorUnNhakhHNDF6TDlxN2ZtUm9XazZv?=
 =?utf-8?B?NFBoLytkVkk4Z1FwNnltNUxWZTNQY1JpWjRTNGFJNE9aVnYvYll1Z0I0bXhU?=
 =?utf-8?B?RHdGcUZkNUtZRndVN1pVdkxuYnNSL0VZS0l2QVUzNnphdzI2MkFzM3lnSjBI?=
 =?utf-8?B?bXFIWnFDQ0I4UVd3eHE5SWRId1U0V0xiQUJ0WEZ0UjJJbEVqaDhIcnFrN1Vw?=
 =?utf-8?B?dlhtWVUvV2p4ZEJMZTVmUTVFZEdqMHljWmc4RXNIdXdNM3NtZzgxaU54RldV?=
 =?utf-8?B?UEFudWF3Y3FLbWNRTmF0TUI3RmR1eDBpeTNHRktnQWQ5Sk1NM0V2TVRtTnpW?=
 =?utf-8?B?S2gwZjlNNWNkZG5ydGJWWjNMWSsxUi9ob2N3S1Q3dkJ5QW1qOGE3NjJIR1k0?=
 =?utf-8?B?RHlIdDJkMGRvS1oxampFQndzcnVRbEFSUVR6d3BMUE5CWFJkYkNQdUlrNldz?=
 =?utf-8?B?dkgxTFVLbkVYRHNyVDFTUWoyOTJrV2loY2tFdXhFSHlieVBmSzNPeDRJYktk?=
 =?utf-8?B?WHdNWEZjenF6UEVhNzV3MlBHNExQL0l1a0hnRzlRUlQwNkVpb2hXclRVZ2I3?=
 =?utf-8?B?ODVwbHYxTUdzanBaejVhOTNwaWlITkVtWE1Hc1I4VXd1QXNNVHFBditSLzBw?=
 =?utf-8?B?T1hKendHdlNpSFNkUVUveDF3cU1KZURBNlNJZ2grdTJLY0VqTTBMcVdHcVYr?=
 =?utf-8?B?SWxqeFpHTE1IV3IyRndzRWEyMWtKdzRFU0Q3MjEvZEhibUwxRTlFOFZ3MUFw?=
 =?utf-8?B?Y05COUs0SDdmV1l6aktGMERZN25SaXpmNlcxcEtIcm1xcENkY1JEZXg0ck9m?=
 =?utf-8?B?a1VNUk4xQTNEaitBMklabEJqeW9jSE0raUk5c2ZpWGM5OVl1Vk5rT0Y1djVZ?=
 =?utf-8?B?WGozVG50QjNXOWpGdU04RmU3L1VYbE9NWmlka2h2SUg5OHFwdm1LRXVISXhH?=
 =?utf-8?B?b1RGdHB4REU2NzRwSVF2WDZjR3dVUjRoK0NOWUFXMmFQZUUvOHpBc0NOTUxz?=
 =?utf-8?B?MTJyQS9FN3JWYiswbENRY0Z4eXNPSHgzMy95cXNlamVRVlo2OTdaS2JVcy8v?=
 =?utf-8?B?L0FIaFVEVElvcURHNGtVNDg3MFgyVHNHSWFtUzNvTjVPMGZxcGx2Y2xZaERE?=
 =?utf-8?B?eUFDaUUvbGZ2WXRqb1pEOUdCR0IwUDN5TnBudllzTlA5eGxYeXZhK2phMnJD?=
 =?utf-8?B?d25HbTJCTlh2WVk3ZFR4dHJ0NWxMODhpZVordy9JaXJaQ2N5WXBsZXNnSmJw?=
 =?utf-8?B?MHZtbFBueGY3b3BzQjk2RGc4a3pKM3k2clp4bTRPR29UYnBYb053Z0VXSDFv?=
 =?utf-8?B?S1h6eDZYVXNKcldRVm5DUmo5bzVZb0o1U0cxd00yVitJVXZ5NFhMa0RLUE9P?=
 =?utf-8?B?SXdrdGNTRkNqZkErakJMZWxCcWt3Mis0bGowSEMrVTR1TVRSNEpYdXdMaG1l?=
 =?utf-8?B?K0ZVc3dwOGRMQklsVHN5L1E3amovZ0tZOUlQcm5rbmJhUFBkOG4wSnlOWlJ3?=
 =?utf-8?B?UERmUDRWVE5RT3pRWThXRGVKZnJPTjJ1bXRqR0VHa2QzOHBBdUlvUTBIRStj?=
 =?utf-8?B?Rmc2YkdvMEVpY0xpaWNwSEV2UDRwdEJkdjA2QlV3STJnMXkvMjJoaHJmRGQr?=
 =?utf-8?B?Z0JWdzdTMnkxS0E2Q0dRZFgrOGtTNzlpVTdobHJRTE5KaXZGOWhCQ2tycm0r?=
 =?utf-8?B?RkVIZHBJUDdjMFlBQ28zZ2xWc2hVVUpBU2hIUFFlajcxUnppY1VDL0lVOU1y?=
 =?utf-8?B?RGJGVTFyOEN1bnNrUVJRUnpuK25jckZUclJhY1QvblR2ZTlKcUtESE83SDV2?=
 =?utf-8?B?cXg2SlJKck5NYnEveW5sSTFqZ1F3ZjVhWEp5bXVOU3FwY3Brc2tadmFlRDNo?=
 =?utf-8?B?V3pudHF3am1jdWlhNDNKOEhqMUtaRlcwZzU5THR4RjR2aUZqSlZTQjhJdWo5?=
 =?utf-8?Q?2rnYxSqgrAua6EfmSgXR2e9bI4A6odMn?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 23:49:50.0784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0d4c7a-01d5-47c0-186f-08dcaaa8f9da
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8276

On 7/22/24 2:55 AM, Marco Elver wrote:
> On Sat, Jul 20, 2024 at 09:54AM -0700, Kees Cook wrote:
...
> I'm more confused now. This is just moving tests further away from what
> they are testing for no good reason. If there's a directory "foo", then
> moving things to "tests/foo" is unclear. It's unclear if "tests" is
> inside parent of "foo" or actually a subdir of "foo". Per the paragraph
> above, I inferred it's "foo/tests/foo/...", which is horrible. If it's
> "../tests/foo/..." it's also bad because it's just moving tests further
> away from what they are testing.
> 
> And keeping tests close to the source files under test is generally
> considered good practice, as it avoids the friction required to discover
> where tests live. Moving tests to "../tests" or "../../*/tests" in the
> majority of cases is counterproductive.
> 
> It is more important for people to quickly discover tests nearby and
> actually run them, vs. having them stashed away somewhere so they don't
> bother us.
> 
> While we can apply common sense, all too often someone follows these
> rules blindly and we end up with a mess.
> 

Here, you've actually made a good argument for "blindly" following the
new naming/location conventions: it's easier to find things if a
standard naming and location convention is in place. Especially if
we document it. Now if only someone would post a patch with such
documentation... :)

I would add that the "_kunit" part of the name is especially helpful,
because (as I mentioned earlier) these tests really are different enough
that it's worth calling out. You can run them simply by loading the
kernel module.

So if I want to quickly run kunit tests, searching for "*_kunit.c" does
help with that.


thanks,
-- 
John Hubbard
NVIDIA


