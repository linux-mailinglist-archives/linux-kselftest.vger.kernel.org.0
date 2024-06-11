Return-Path: <linux-kselftest+bounces-11651-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB1F903285
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 08:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 201C3B25C19
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 06:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C5F171647;
	Tue, 11 Jun 2024 06:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BAWP6DKC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467F16116;
	Tue, 11 Jun 2024 06:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718087174; cv=fail; b=h5b6S+ckfNkdNnls4W59DY3j8JKCLy0mrSYl0vUjXYonLuHxqzNFUvbQRQjEmud2IvuRe9IO/wwzNdxtv2WKKyuECnRxDzO8ezlaTZYXDAi9BnLRRBB2A1LxbCOlQ0mQNJGayECQ9wMUc92EKzwxst4ER5+5b9wEGRDkbdU90bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718087174; c=relaxed/simple;
	bh=K1vUVBA6OVN23D+To9JDGozuTSOqmzhO2gqePEIOHCI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X/B8DXJiqTN7aFAtrWP4DIzsixMcuYsEGyU04yUcE+heBxy2NU5m21JnHrgkaArc1le8fdn8PUBQPsgbSsdxRrNZP6CB7+5Ey+4taE/tHAPGOGW5+AHzlL7lqat0ttxicrcXjpb5mTCM5wIuC1QiHqbGmpbSeE5rnuOGWlcyDdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BAWP6DKC; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayDHiu2ivYpp1ClaNrFdrA1G6bW9A4qrVsKp1es7q1lyfazxF5YjZu7hJLVvyyU1VuJ67ocbdtb1EnH2+iaZnrZOXKcMkOjrIg/r9dJWKkmz9EyHGE1Rg/irIPgZDtbeTdp8zjz3pkXaGBBqWdx1DG7mkrsUWpP7drKlXxjF6waN3OXMmubH/bHLYfGGx34ARcEQVaSWspmIgFeZorVH4IeQBZy464qNGR4Uca+MzdWOzsx1ktJv7n/6XySL1/QDtowVMwFXLysHalzP/jb0hoHl+DIOi9IwpmQM3PLSN3pGfGM0lXbQAoGHPJ9Nup7liG9VGXWxk6TRVYTl3aUXvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AZ38o6CLcOKwfaJtzyojIEkME17/IdfbspxnLof9Ac=;
 b=NDXGKGusUD2q5Hk83zMAMPmtQgSwKH6Z6XbSh8YB3PQbpC8P7ZYGEG0dAlJMyQq/rJNv+wQ7YAv355yHl41mczWzI8oMZrp/3bsK2ZNClV4UNyCfKJ62Xy1LYVfCCa2fn9oUblR1b6jvEi3Oty45zEVZjNqb8pPuEh1++bQ5OB6s1s4KOaj+szhKdZyWhsGieVdymIGMszO3cVK/VibKh3OW3VM1xZ33EtqdO95C8pn+kPtM3MYRYrcjsT/kFbiwTM3MCMgLtFWQMo7sGsO5OuoifCVKl3PO1RidI1OxV21JKFv++qAmHpZ4TdR9Z+Ifi9scPMDUChzxBcMMzimDFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AZ38o6CLcOKwfaJtzyojIEkME17/IdfbspxnLof9Ac=;
 b=BAWP6DKC3FTKkggifrwi6H6dWhF38ukYjyUK1gMHlrFUoiWUA8nCJcCSDOvfNKCld+XJTxtT9+VWjV41s5yDjP7N3/rx3wyKpAJu8rOWPtlkwbDuuG0+QazLCsJ8YtpUnT9Z5jvZwfdCwoxl13ssMJ+fx1Rw6Pobgp2lUxaJeXYA0eCYewKysj4oGlhQfsqvilx8Io2sJNNy4cWUV5g6XiKBYTkHPuUKl5+2nETSPHY1Kkq+7sjSipvE9eN1wG+5oy4B/xiUKirjqoopZTlnkQwBvByN134ucyU5wl5SqvfMeS2NNr+Lwbfz0jpPDyT80BZQi2yx2rWTmkTVMYEReg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by LV3PR12MB9119.namprd12.prod.outlook.com (2603:10b6:408:1a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 06:26:10 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.037; Tue, 11 Jun 2024
 06:26:10 +0000
Message-ID: <95005e7c-3705-48c5-8ee2-3d9b0688fcbc@nvidia.com>
Date: Mon, 10 Jun 2024 23:25:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] cleanups, fixes, and progress towards avoiding "make
 headers"
To: Jeff Xu <jeffxu@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Andrei Vagin <avagin@google.com>, Axel Rasmussen <axelrasmussen@google.com>,
 Christian Brauner <brauner@kernel.org>, David Hildenbrand
 <david@redhat.com>, Kees Cook <kees@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Peter Xu <peterx@redhat.com>, Rich Felker <dalias@libc.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240608021023.176027-1-jhubbard@nvidia.com>
 <CABi2SkVoNyXLrfU71gnv1qVUAADpUmFXiDoKKPc54MLb5JpB+Q@mail.gmail.com>
 <a8f9d4e2-8a12-4e5d-bd22-9c92955135f4@nvidia.com>
 <CABi2SkU8=tjWhD-e=OdiVr+YeU+BZZLB_vMfkNb-VWpbP2xcng@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CABi2SkU8=tjWhD-e=OdiVr+YeU+BZZLB_vMfkNb-VWpbP2xcng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::16) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|LV3PR12MB9119:EE_
X-MS-Office365-Filtering-Correlation-Id: a10cef8e-ebb3-4788-74ac-08dc89df6280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGU2dVlwYzNXZXlQMDFMNDlpRW9jQWg3cnc5UXMyVVZrb0VNVTl3NWFLUTd5?=
 =?utf-8?B?TzNtNUx5RExONXZOSUtsVVRPUGxTTzdSYUp3WWRLRk4rcTM3VWdPN29PNE5R?=
 =?utf-8?B?NUJ5czd5eHFycmdYbWFKMlEwRk9MTW04akdZTVlSaFgvVVZKRkZ3VklJQXpC?=
 =?utf-8?B?dDBPZVNoTHZDNVJtd0gzRWUvaXI4MU81aE1GQjY3YVZQUElNTUZUcEJwTzgy?=
 =?utf-8?B?YXErRGY2WmhoZUY5VG51QXBtL0RhcmhUaktka3JlWDhod3B6Nm9QTWtmcndZ?=
 =?utf-8?B?b29kZGlYQlRtTFc2VCtPaHd5YVBmeFJaMHMyaDVXSzZSenlUYmxjM0RLaFJD?=
 =?utf-8?B?MnZPS01FTWQxRXFyQzlsSzZ4dmR2bFI4KzRyQzlIUUZDN0lXOWFTWjN1UjBY?=
 =?utf-8?B?Y0RIYmR3VTlNQTlHKzB0dGMyZnlaNk9KSTRqZ0JTYnU2VEZuMVBuRzdaaEY2?=
 =?utf-8?B?VlM4QWE3ajk2Yk8xS28zRktrYiszR0p2cWpvV3hFdlJUQ0htelVGWGVYeGdX?=
 =?utf-8?B?M05KSmN0ejVVVWJNQ0RTNWNieDBXalllL2ZIMEN2dEl5bDRWK2dtL0VWVW5F?=
 =?utf-8?B?RU1FSkl2MnhzS2NzNGVDTFQvSEJmZmZ0akJFanZQT2VnTEpPWmNHcFJMVnBY?=
 =?utf-8?B?OWJwZ0V0TTFPOHA1Uk1PYUhEK2dXVTBXMXg3cUQ1ZEFkMGNPWjlwMGUraEFR?=
 =?utf-8?B?ZnRJdkRvUTNYM3dtd0JrMlJEU1ZIZXU2cFJUbTRYV2VNclBrZFZmK0YxbDl0?=
 =?utf-8?B?T3BmS1NWTDBicE5sWTBCNW55ZjkxTklNb0U0YXpGNkJySVQ1OVQ2d3dka1RE?=
 =?utf-8?B?aEh2MVhjNVROWHI4UTYrVjlQWWFBMnUxcHBLd3RDSUpaK3ZDVTg5ei9Qc3pv?=
 =?utf-8?B?elBWenc2bmVFSGRSTE5kY1p0N3llbDA5ZzFLQ3d2OG91YjBqSjNsRGdHL2xN?=
 =?utf-8?B?eXhXVGpSc2xXcjNSZHRnWjJKT1B6WVlWOURWWGp0T3ZEZk5QYkE4ZkpoeEVF?=
 =?utf-8?B?NkE1Q0g4SUZ5MFljZFNQdE4vSkdEdFNYSTVkcVZpWW5xOVp2Syt1Z2VHUFpt?=
 =?utf-8?B?YjhIWXVWeXNoSHkzMjR4a3V2NENDazZZZEZCekhJZ2EvSFM0S0RrajMxb1ZO?=
 =?utf-8?B?WW02ZmVsNkdubUR0a0M1eGNQMEtKVUw1MkhVdlJqTVlwQytFMUxESWJyTHZp?=
 =?utf-8?B?RmpEeFp5Y3lHQmtITjhZL1ZGdjhDbUtaQkpQYXcxUHBPTWpiZEZnWWpwbHpx?=
 =?utf-8?B?NUJ5YWN0VkdxS0dFT0dqUkh3V1gzRHBCYWplK1k4cU9kL1JzcU5pSzByQ091?=
 =?utf-8?B?UDhMaHRodzRnUGFCa0hVOXhYd1A1S3hTUzBCQ0ZHTFl6bnBCaDIyWnE5K21U?=
 =?utf-8?B?YkNnTUFDK0VTbzlFaGwxajV4cWpCb1d0bWNKQ0R5bmlzekpXbk1UZG5WR0VW?=
 =?utf-8?B?NmE2MEkyNmFqb1FvWlI1NU1vUDdUem9jS2lNYTJqYlhRdXRQdkJqMGRSd21T?=
 =?utf-8?B?USt5ZkdmWVFJSVl3QzVCYXh3VGhtOWlrdEt3QzhNZWpBeVY4M1QrWlIwWHEr?=
 =?utf-8?B?NDA0V2cyc2lWNWU1VHdvTlFQM1hEM3hJRXR2SGl5NVJqbGJ4K0ZFMFlPMk95?=
 =?utf-8?B?TWIxelVDTFFpOWZCRUMwOGZlUmNTaUpmVnByTUdERFU3cFh3R2hxbzMyd0RE?=
 =?utf-8?B?MHVPWGdLbWk0aHlqL0Q4UUZwb1V0VlJ3VFlVQ0NPRVN3NVkxVGM3SWk3d0dq?=
 =?utf-8?Q?lEFJgiFS5UuFiCUI64fM8MJ3ibq9VuiVws9V15D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0s2R3pzZU1oMHVqNHB3eXBoaTNLTXZwRjVFekdWeWZpVmgrMmZkRWFjL3BD?=
 =?utf-8?B?RWQ0ckc0dWthSkVVZU5hanBJRlFEa1ZmbmgzbVhxaTlMZFBabjRpNExwa21O?=
 =?utf-8?B?V2pzM2tPaXN1bVZvcm1yWm1rTXdwNTVmK2hQS04za2lVZkpYMHkybmlHNld4?=
 =?utf-8?B?SzVKY2tzcEdhTG1DRndsZnRHYkljREdNQzkxb3hhZVkxeGVwZy92a1FNMG5R?=
 =?utf-8?B?dmNoSHhCMFdRWmlub2JraTgrWWFHSGg4NG5LWUExWkE0TlI3cC9Zd3FIcGpy?=
 =?utf-8?B?RW5ybU4zSHdxeTcwR20vQ3UycVJObEhoVFphYzhhQW1EbEFrb0ZnSE95dU5S?=
 =?utf-8?B?aWpMNC9HTnBqNlk0cUFvbFNSbkRTVnZnTWRBbDNNVHdMVUFvVDdsUFo1U2w2?=
 =?utf-8?B?dCt2Wk9iSEhBMHNjTmNGMlAzRXZlbWd3Vkx4ZXpZUGRDQzViWkFYN0NYZ1d1?=
 =?utf-8?B?cU0rYVF1YlQ2YTZOYnVXeE9kVzVUSElwK2JhcS9hMnVsZitDLzVXakE4cThL?=
 =?utf-8?B?a0ZQSGtDNHFaVEdRVDFCbm1RV0ZHUk5Sa1dwaHpodW1SMU1LZjc2djdURHcw?=
 =?utf-8?B?K3dNUE41Zm94RGY4SmdlOWl2a1ozSnFPN1dpUWlNaVpHSC81NjVabmk0U1NI?=
 =?utf-8?B?dXFSWjU0bnZmNWlRZVU0R1hueHdTTGpsckxwWnp2TmRsTWhoL3pQMUhHMHVH?=
 =?utf-8?B?OTZDZkwrd3N5N3ByR1Q5SVJZRjN0NG45VXBJV3lXaFhTVnNSZlpBTVI4bVJH?=
 =?utf-8?B?U1VERTBCVnU3N2k3NFRpNUE4dUV5d0ZuQVZqVGlocXdlVkNNdDhEaDdYY2da?=
 =?utf-8?B?Qi9tVFV4VXQwalJJZ0NqWEpDTFVsR0ZUdWhXU2ZEaVNQTUpoVlhOekZXWERJ?=
 =?utf-8?B?MGdkN1U1MUdpajFkcW1hc1NKR2VjZkkzaXE3MzhSUDlIbFVJR250ZTlpNk03?=
 =?utf-8?B?NTlpaEVqcEdSck1WWHFTbXA2ZVlRdWlvUERDUnVZc2Z6VmQyNWNIcnBRYkNO?=
 =?utf-8?B?ajVWUUY1QzBsTjlMcktCbzBqcDFGUTJvTldtYXJiTk9CWmg0NzVkT1BRZnMv?=
 =?utf-8?B?Mk9FZHdncEJFVEZCVDhzVThnVUdyd1g1K0ZsZ3BMRkM0N2lHVjU3Vit1cHhy?=
 =?utf-8?B?VWFPMUorQWhUSFQySTNwdEVlcWw2UkdTSmtQTlQzZzBNcFdJVk5BSVE0emxt?=
 =?utf-8?B?di85K1pPVXA1UWxOWXA3aVJ0SDNCUFVFZ3N5WjNJVWFzcjFUeDlRdlZQTHdL?=
 =?utf-8?B?NkdHcXJ2eE9rVU96TUpXZi84b0NXYktXcEhzcVVzQXVEL1BYK0ZmalgwU0lv?=
 =?utf-8?B?T2tPVEtQZWJVeW0xUm5iRGNOYTFLcmtCeEVKQkp0UHR2N2tVOGdjbDlIT0xm?=
 =?utf-8?B?dDZwZlpTMXlHd3RNR0JrcWFwNmY3Wk5FcXM2anNQWC9PK25NTm4xb3Q4VHFY?=
 =?utf-8?B?ZGlaamtIc2ZBNFhkM1dhTlBDZEliV0loTDZzM3IzUDBib1BEdGpuQ3lwTXV0?=
 =?utf-8?B?MTE1THRiQ1RlTk9HMFh0ZjhabHpBeXNoOWg1b0loYy9KRklWbUo0OWZ0M3Jh?=
 =?utf-8?B?eEVPa2sxUlRNeU9nNldsV1BONzNnd0VSMkJXZ2hLbUd0Tmxpbnp5VjhJUEc4?=
 =?utf-8?B?S0U1bjVwRjlMRGlVYmF4ekxRYTRhVFNTbUdPSWg1dFE1Z25XTkh3eDM1MFh5?=
 =?utf-8?B?bER0czArM1ZLd1ZMZGp6bUIyOGxLVE9qSmh0bFMzZmxhVG50eFN4WTllNU5S?=
 =?utf-8?B?L21FeklVdDRLNklNMGlJOTg2WW5SN2d6Um0wa1dpWXByTHVVdjhnUkpmM1Ra?=
 =?utf-8?B?bkZ3U0huMU1KTWNTeGlVWmdJZldMUitkb0h0dy9KL3JFV2VhZFYxclZwUDJY?=
 =?utf-8?B?dFVpV0V6dllpeUxLc0k4OUtQTTNNek9zSysvMXNSSnI5WUE4blBiUFE2c0xo?=
 =?utf-8?B?anN0Mys2MFF0UytqaDdSOEQzb3I4NEFOcDZrLzFjL2l3MG1MTzdBNWN3NmpU?=
 =?utf-8?B?MkV5QXFKSHNpVGxOV1lpQ29FVER3eWxIbUZGS2VieFZLWFJjeDBIQlM2alpC?=
 =?utf-8?B?NXVWOHo3cnFEd3k2K1NuaG10eVlPMG1VMk9jT0xrZTI5NzVsalRibU1KRDBF?=
 =?utf-8?B?Mm5wcS9OWllhS1U0Nm13cGZmOFBuRndhMW9HS3VmVUZOQTllQXl4dlVzMXI2?=
 =?utf-8?B?MVE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a10cef8e-ebb3-4788-74ac-08dc89df6280
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 06:26:10.3887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OswYvcYkM5mHMpLzGO9xi+pO8216rS+xG0GcbKGM1SqkvCQo3+V5Alfwcp5K4xqIbq1VQv/3tKW4d7BfjisalA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9119

On 6/10/24 9:45 PM, Jeff Xu wrote:
> On Mon, Jun 10, 2024 at 9:34 PM John Hubbard <jhubbard@nvidia.com> wrote:
>> On 6/10/24 9:21 PM, Jeff Xu wrote:
>>> Hi
>>>
>>>
>>> On Fri, Jun 7, 2024 at 7:10 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>>>
>>>> Eventually, once the build succeeds on a sufficiently old distro, the
>>>> idea is to delete $(KHDR_INCLUDES) from the selftests/mm build, and then
>>>> after that, from selftests/lib.mk and all of the other selftest builds.
>>>>
>>>> For now, this series merely achieves a clean build of selftests/mm on a
>>>> not-so-old distro: Ubuntu 23.04:
>>>>
>>>> 1. Add __NR_mseal.
>>>>
>>>> 2. Add fs.h, taken as usual from a snapshot of ./usr/include/linux/fs.h
>>>> after running "make headers". This is how we have agreed to do this sort
>>>> of thing, see [1].
>>>>
>>> What is the "official" way to build selftests/mm ?
>>
>>   From Documentation/dev-tools/kselftest.rst, it is:
>>
>>     $ make headers
>>     $ make -C tools/testing/selftests
>>
>>> I tried a few ways, but it never worked, i.e. due to head missing.
>>
>> You are correct. Today's rules require "make headers" first. But
>> I'm working on getting rid of that requirement, because it causes
>> problems for some people and situations.
>>
>> (Even worse is the follow-up rule, in today's documentation,
>> that tells us to *run* the selftests from within Make! This
>> is just madness.
> 
> That is hilarious! :)

:)

> 
>>   Because the tests need to run as root in
>> many cases. And Make will try to rebuild if necessary...thus
>> filling your tree full of root-owned files...but that's for
>> another time.)
>>
>>>
>>> 1>
>>> cd tools/testing/selftests/mm
>>> make
>>>
>>> migration.c:10:10: fatal error: numa.h: No such file or directory
>>>      10 | #include <numa.h>
>>>         |          ^~~~~~~~
>>> compilation terminated.
>>>
>>> 2>
>>> make headers
>>> make -C tools/testing/selftests
>>>
>>> make[1]: Entering directory
>>> '/usr/local/google/home/jeffxu/mm/tools/testing/selftests/mm'
>>>     CC       migration
>>> migration.c:10:10: fatal error: numa.h: No such file or directory
>>>      10 | #include <numa.h>
>>>
>>
>> Well, actually, for these, one should install libnuma-dev and
>> numactl (those are Ubuntu package names. Arch Linux would be:
>> numactl).
>>
>> I think. The idea is: use system headers if they are there, and
>> local kernel tree header files if the items are so new that they
>> haven't made it to $OLDEST_DISTO_REASONABLE.
>>
>> Something like that.
>>
> But I don't want to install random packages if possible.

Well...keep in mind that it's not really random. If a test program
requires numa.h, it's typically because it also links against libnuma,
which *must* be supplied by the distro if you want to build. Because
it doesn't come with the kernel, of course.

So what you're really saying is that you'd like to build and run
whatever you can at the moment--the build should soldier on past
failures as much as possible.

> 
> Can makefile rule continue to the next target in case of failure though ?

That could be done, in general. The question is if that's really what
we want, or should want. Maybe...

> right now it stopped  at migration.c , if it continues to the next target, then
> I don't  need to use gcc to manually build mseal_test.

Let me take a peek at it in the morning.



thanks,
-- 
John Hubbard
NVIDIA


