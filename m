Return-Path: <linux-kselftest+bounces-26504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E238A33996
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 09:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CE08188C32F
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 08:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20735206F11;
	Thu, 13 Feb 2025 08:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GpeLmG0k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B54204F7F;
	Thu, 13 Feb 2025 08:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739433878; cv=fail; b=nOOhCNxuVGM7wKovQxhyTPAO0b8c0VQ6NtGPNucyNZIvjSkwqeVaRfrywMc2nLo/ttR3qlUEQi5OJKp3l5Y7PWfLsMGecvd7Mi6CiT/Ho+ti5uoZpP0yuSgEbsZ6ANCEqG4XYZ7eClardgiOhltRfK2CACyEfXteSJvuNW2NGNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739433878; c=relaxed/simple;
	bh=MKk37X+Byukk/GhpvVtyk9ArWtLG105EruYKs3oHE7Y=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=Bpv0PEvROLk/bmnaGpYAo//gy4LyJiw7+/K8I+geSBH/kUARbly8nB9P5J5lS28A8sfQUpw4oZAOgLm97pqgGaf4ohquBhX/lORiZOPGWKY3wsaXZFGJC8MjTRBVCiDFmuGsZ+S1OEg+d423IKCIfYdJxcA7QLs6VT4eA+QAbHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GpeLmG0k; arc=fail smtp.client-ip=40.107.96.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=waCgnK5EMK7ofb56Qw2E7LhwYXWXGEBpCy1lhOBAvpAXE+maPvSPudvJ6H3b+xCZJI8Luq7/plz+ZcJDoHUESHVM0Zoqoh3cVa7zZVlukgst3SN2/2WZ/myf8mspcuF83c5yyIM0emOAGMQ5MAWG6S/aj3olSLWpkiQT2WLmnwwpXacGjNScqKeAKobZZ2EDd4uSEKSwXiu0pGqxfsQVjUnLD5GcylgW7K8QtKZOeFQUrjXTTHhhFFQTRt3V6Ior6UbobYPzC/GOm3Ylin2jVHKR9xdnY5FTS0Lg4rTnzKpm6Ja83dC5LW0XpBpeSjmDYsQKsiVjdM1gBlEDbA/tpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHfcdag33tN9SAgX3s85O1FDjZKfjcV6BoGC+0E6aoo=;
 b=saYoeGcjt+XPnQcK41DXlXfRya4Bk/yDkqcJEBRcCuqJWUhNW42zz4k6SC3AYj5xoJJiGGjDrzBKQP6shYkKSIaIZy4I6gSFJ01jbJIiKgd/P5f+0YTIJ9eWw9xgD/3ffEL/mKnk5qseIgTy8MFOgTvtKHNu9ATOyQkn0cK8WEWctwy3VU7Xhy9Yc5lVSKhMjHqMN2vWDdQ89ycYb8BEr8LY7KPLKQ3liYAM4GMbexSn6guZWCBh2/i0Eb7U9c7KDh9XLngiqj+W2Gk/jAm8nX4i6dL4f7BlD2oPedeh5iKr3Ui0Ekq2Szc0rJ5tBD1lyvnCD0K63URplF38Xi71OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHfcdag33tN9SAgX3s85O1FDjZKfjcV6BoGC+0E6aoo=;
 b=GpeLmG0kdQAEU1JKM9lKkqmdx7MQd3oQXKrarYorw7yNZrdo6tREL7bUcf5me8gq3N/XHVVNQBihFWnqXNpj61lU7npGPRbfA+1ttIZvyvR/4JDmSx1nZ0AdGR6Y7ox+ihVwnhSpiZp/AxfAmc6zgQ0iiJ/ZP4RB/GbhDvu2TKvfvWvydBLSjzOf0dASe/+2oeUuQjsCxDCnOPDdS50CaNKvE34lYgkHkuXeBa/jy4ntyzfkk+VCC2+WRfd7qFf8lp8apFuN6fh2jFPKqWjA+dHBs2BqyRGOoYtSmnnWihOSqWyZ6ZDH2DsNU55zMBou5fsCpiTWTnoylX0R38qeDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 08:04:33 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%5]) with mapi id 15.20.8445.015; Thu, 13 Feb 2025
 08:04:33 +0000
Content-Type: multipart/mixed; boundary="------------PYAAtAZkxT9BPGCu56ENHaPF"
Message-ID: <76770ce2-f6a6-4af0-b29c-0070933a1dfb@nvidia.com>
Date: Thu, 13 Feb 2025 00:04:30 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] selftests/mm: remove local __NR_* definitions
To: Dave Hansen <dave.hansen@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jeff Xu <jeffxu@chromium.org>,
 Shuah Khan <shuah@kernel.org>
Cc: Andrei Vagin <avagin@google.com>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Christian Brauner <brauner@kernel.org>, David Hildenbrand
 <david@redhat.com>, Kees Cook <kees@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Peter Xu <peterx@redhat.com>, Rich Felker <dalias@libc.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240614023009.221547-1-jhubbard@nvidia.com>
 <20240614023009.221547-7-jhubbard@nvidia.com>
 <dc585017-6740-4cab-a536-b12b37a7582d@intel.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <dc585017-6740-4cab-a536-b12b37a7582d@intel.com>
X-ClientProxiedBy: BYAPR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::22) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|LV3PR12MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: fa8f3b00-d970-437c-2ee4-08dd4c050ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|366016|4053099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a29MYU9RVlJnVFVuTG1JVE9tWDQxdEx2RHgzV09TYTc1a2RJdVQ3VTE5Vm1w?=
 =?utf-8?B?aTFIZlh3Q0RqbFJjdFpWTHF3ZEhEZWd6MVlXT0ErU3pXWENsRENrcVNDVTRP?=
 =?utf-8?B?bXhMYksvZDdHdTBYTWFkTlF3MEVoMDY4bVFHVVlGNnpYUU5nNXppRVV5cUt4?=
 =?utf-8?B?TVZmWXNHSkFVVGR5ejJyZ0RuanVYWHJKY1h3SXJ2UHlTOFlKenI2d0FPeU00?=
 =?utf-8?B?Unl2d29hY3p4dXRBOUxCOGFaaERndjBKWnBmNEdYSzJzOVA5ZTJLT0J5eWpU?=
 =?utf-8?B?YUtqWURiTUVrangweUdoZHN0UXhMYnE2SitON1JsSU1McmRHYmdlcHRHaE9q?=
 =?utf-8?B?alRaTklobXZ5aC8rbkpEcEl5eCtHai9WenJhZXhrSDZBZmRvWmxYSDRlSHNW?=
 =?utf-8?B?ZXBGR0Fxb3N3MVNTM3J2V292Z0c3TDA0MDAyZERLaGpVTTV6Z0xVaDdmMXI1?=
 =?utf-8?B?TE02Z0VGemZMZW9ZVG5Xam5GRitlQkxWS2NGOFlaME5vMkM3ZHBXNkIySUMx?=
 =?utf-8?B?V1RlVVYwV2ZFWVk4ckNNZklSOE5CYUdXc0tQd2R4b2xzZGpkWmtQZlR0ZHp1?=
 =?utf-8?B?SDZjTklVLzVFVDBZZFdSb0RzeDlwblhHQWlGb25mYVAvcEJhQjRqQVdTRWxx?=
 =?utf-8?B?TmJpMFF6eWhvVlZPNGFlRXp1TE85ZWcvemFtbytxdnEvNmV3d1J4dXVhMnly?=
 =?utf-8?B?NFVYWFVDd084bVBOM2l4TkZFS1E2cTMzUVA4TmNDV0IxbitiKzlTS0Z1R1hX?=
 =?utf-8?B?aGFTR3pwaVMyVVZWTmpJalhNdW5MWGRhNlF6eW9yL1RXMElnRmNLVkR4K1h3?=
 =?utf-8?B?dXdCOVFNVFlHRFkvcjVNc3FjS01zVTNKeDZIVzd4V3F1Y3pBNjV6RFNYWDVB?=
 =?utf-8?B?NW1sVHRNS1REb3JrS1pZZFZKcVVBaHF1a3RrM1pHNEpiZzZYMmdleFVJT3Np?=
 =?utf-8?B?QUNrOXBHOXdIcTZhSXFGMUlVYkhkNG84TEg0bC9SRktCWjEycmgxaklvc21G?=
 =?utf-8?B?NGJwc2l1bytzSzVPMlVDWEM3VVNMbEFsQjJnSjFRMEFrcWJTWmI5TVFKOW43?=
 =?utf-8?B?cmF0MC8vM1NOdlk3NjkzTU1KaUFkbXJyeUlMbzl3UUFiUERUY2NvM3FIelNF?=
 =?utf-8?B?RExJcTZGUERqSTBIdi9icVpqODlxa3RvNlNGc3RyRFluSWFuTENzQi9mVVJl?=
 =?utf-8?B?bzlGcFlkazJyYnRPWVNGeWJBeUg5VXFGTXRXUWZhWFN2UHVNUmtWekdVQzF6?=
 =?utf-8?B?R1BhT2RZbXZnRWh0ZytFY1pJY2dJSk9hQzRQMGRLck9OSW5DSkpaRXZYb2Vl?=
 =?utf-8?B?cVJlblhZRjJGSWZISDJOUUNkRjhBWk16M2V0NTU3V1pUTTlpOEFCUThtTHZC?=
 =?utf-8?B?MHIyOWs0aWh6Slg5VWxiVVU0QWpYY2FyYlcvdUlyUm0vaW52OFlnWXVzRHh5?=
 =?utf-8?B?WUhXc2lyc3lhakpCM0tsYmE3SVVMbnl0elJZTVRYS0VwRGQzQjYzRkJ1MzB4?=
 =?utf-8?B?MDVsbmFDa3J5TmZrZUo0dmwrb1VyOHc4WHNXdmYvS1RoZnlaU2pWenRrS0kr?=
 =?utf-8?B?STZyeXZBYkpnMklYeXlHcGlHa2ptd3Bqc2F4TExnNm5nMzlFR3pQMjcyNXBP?=
 =?utf-8?B?TzJyQjN1SVhyMVNqYXUyTmpkd2didjRzZ05YVE5lV01yK001eTE3UmNwWVBm?=
 =?utf-8?B?eTJtRHRLMzBCclJTM3B3cXJDVjM3VXc1WEs1NnB2clRtM3hqUVI4NlIwUXhy?=
 =?utf-8?B?dGJDV3hvdEJqNEs1RXJNYmswUEpzOE40TVVodGZGV0NZcHduMGh4VkJONERV?=
 =?utf-8?B?QkF6TDJyaEdBcG9nMU1WOEF2UEtkKzFRV3RWV21mVUptWEdCbmRXV09FdkdW?=
 =?utf-8?Q?CklRuWZZIX0IJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ym5sYUVNMzh6TW9qVkMvdGFmbmQzYitLUGpWNmN6QmpMcW9HcnlpRXFqcDNn?=
 =?utf-8?B?SFNNVHhSKzBlaTlqazFzK3FrejJNQVJ4NnoyTytiTGdpUmVmREZQdzU3UG14?=
 =?utf-8?B?bVVDRW1UNi9iMVB4TVl3NENwQ3hVQW52b3NzOXUwbHJDeUxnSDFpb3VEOVht?=
 =?utf-8?B?VHI5S2NUTWtZNk1XNVZNeUExYnVkM2NRSFhxUldwTWpUejZ0Z1JQQ0VlRG9N?=
 =?utf-8?B?K2hIVnVsNERSWk1sZU1rRTVsdU9IQ3VkVDNCZ1FUeU1oSVk2RHgreS9aeUdK?=
 =?utf-8?B?cDkwZTFoUDNKdlRKTmpSSC82dWVBdEpTY3h0MEt3MndaNnFMTXllT25tNFdD?=
 =?utf-8?B?WHUzYVVzR0NrTDJ0K0NQRGJZQ2lrck9EMDBhZGw0K2xkVDNNTTRGVmFKNFJN?=
 =?utf-8?B?WWdMNzdaTndNK08rQ3J3V3FQMWhUMEN0TkRibDc3K0RqeWorU0xrYjVUTlVI?=
 =?utf-8?B?SnpyQjNreCtIeThNdmMvdk9hVzJRMk0yMHZPQ0gyd1Q5S3VrejRiOGl1N0N0?=
 =?utf-8?B?L1Fabm9FOEt1RjJwTmZBOTdKTDRRWmdoMjBXYmdHUEhjOFBjdE5ZL3FrbURP?=
 =?utf-8?B?Kys5dTNEa012YUxQcU92cmk3d3A5dHlyUDZKKzc1aU9jOUJLWnkwYndlZ0dR?=
 =?utf-8?B?a1VJbXRDSmFMZUt0c3ZmSy9OTExrWGZ0N3RFck9Ec3Juc1VtYnVNVlkzUTB4?=
 =?utf-8?B?UmZweXFGOW10VWI0Rkp0NmVRSjMyVVV3cHZTMWpOdFZqZUUxVVRSS3YxUy8v?=
 =?utf-8?B?akdEdG1TSnMzSEhSRDJUV0RHMlpxc2xHRWVpUVBuZHl0ZDg0eEF0cmRyRDFN?=
 =?utf-8?B?UFAyc1BoRHQwMDMyVmluVlJHTVg2S2pzaU8rK2JwVGNSQ3pmOVFJL2V3bnlD?=
 =?utf-8?B?aVZiRGRxeFBoSnQ5ZWE5clhocWVZT1lPTWtoQzY4dkR0MjcrTVExZWNVNllK?=
 =?utf-8?B?MHA3akZiKy91dmFuRVZKVVVhdElScVFvSmN3VEpiTi9Razl1RVE5Q0FMbTdV?=
 =?utf-8?B?cGNQdkZTQktsS0s2LzlWTnN1bHRmRldxeVhISDRDQm50aUhIUS9yeWFZenEr?=
 =?utf-8?B?ZXhDL1hTYUhsYURXbVlpVnpIUHZpTHhkOHNtdlJFQUptd3JtdXJkbDhlUFRI?=
 =?utf-8?B?eWJNRkVPWkNoc0RmcmJTdSthaWN6eWFHNlNZa1pBRTAwRzJUSGNjb1hPcnF2?=
 =?utf-8?B?ZXZScWpCaVN6cUdnM3FxSThZeTB0Ti9VbmNUZnd4ZmY1RGloZ3duOWRvckJZ?=
 =?utf-8?B?ZTBSbnYxaW95NGJQMjRxQmNVMVF2ZUdzQnN0VVFPQUNYL3o0TThvZVN5cHdp?=
 =?utf-8?B?bmpSSGlJd0k1cU94SHdyRmZRTjFFSVBUWjFvMlZNNWJUOGFzM1J3SE9IK0dO?=
 =?utf-8?B?YThuTlQ1Y0IwZjJOVTRHdW1kNjlOU0pPS3QzNWZWcjNJL3ZPVVp6K2lmamNC?=
 =?utf-8?B?ZWdCYVNQc0MxbHo1Z3A2WXdxeDFRWTJ0TXgxenEvVU84MkhpTmtOZ0hidW96?=
 =?utf-8?B?d2NNRGxPSERZejFVRURVNzRIWUl0WE9kREx2ejJ1WVBtMEpicDJEcVNhMGRY?=
 =?utf-8?B?RElPZnlwTDVWTlM2Q3BQZk9WUmRDSjZmWXc2T2VkdDdueXMyZ1JvQ0dXWXhF?=
 =?utf-8?B?M0ViMkE4eWY0WkFvYThsRUVISE8rQ2xHWVNNQXBEZ1l3UUl4OWpSVTZNUlpt?=
 =?utf-8?B?bld6SG9QcjhCZ21UYWIzNHltVlZsbS8wNzlDTlZmdmkyNEhNMExsRjNTNEdM?=
 =?utf-8?B?ZVYvNTd4aWllcGtTT3kzc0liNGdpd2NsRlJhUU85bkNIYzFQZTk4VnMyZkRy?=
 =?utf-8?B?ZTFZWHd5TWFFd2VOZHJnQlIvemE5M3YvYkc2bVFwbUNramxqbVR5eEdoSEdl?=
 =?utf-8?B?ZXRja21xWExNTU8yVFV6TlY1cTY4QTdudXY2YWZ5MS9rVUNsekR2Rmw0aG1V?=
 =?utf-8?B?aHMwTkRhZjQ1bG0yemd0QTNBQW04SmFoaE44MUQ4dzNscDV0NXZ1dDhOUHNC?=
 =?utf-8?B?MHcvdGRPZW92RUF2MUJsS2NIcUZ1SnNoYVRneFNiRTVTSmkyMC9uanFRSDBw?=
 =?utf-8?B?V0NOMWpKM0ZHYjA1MDRiVlZ0ZCtUNWQwM2JuYmFYUUVsYXVxYkRoQ2VKZkFU?=
 =?utf-8?B?ckRxeU9uejdBWkhwZ0RUdTRaL3k5VDRBMEFxZ1lBcHJWTDJLM3d2Q2FiZHEr?=
 =?utf-8?B?L1E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8f3b00-d970-437c-2ee4-08dd4c050ca5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 08:04:32.8826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rz5UpdjxRdZt3s4DpoIzD1lpjmwq9bHd/StXbZdjvNjgfyaxeCe7/TFz7qi8/XF9rpEZbrRfD9Ggf4l8RWYp2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9260

--------------PYAAtAZkxT9BPGCu56ENHaPF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/12/25 12:34 PM, Dave Hansen wrote:
> Hi John,
> 
> On 6/13/24 19:30, John Hubbard wrote:
>> --- a/tools/testing/selftests/mm/protection_keys.c
>> +++ b/tools/testing/selftests/mm/protection_keys.c
>> @@ -42,7 +42,7 @@
>>   #include <sys/wait.h>
>>   #include <sys/stat.h>
>>   #include <fcntl.h>
>> -#include <unistd.h>
>> +#include <linux/unistd.h>
>>   #include <sys/ptrace.h>
>>   #include <setjmp.h>
> 
> I'm not quite sure how but this broke the protection_keys.c selftest for
> me. Before this commit (a5c6bc590094a1a73cf6fa3f505e1945d2bf2461) things
> are fine.  But after, I get:
> 
> 	running PKEY tests for unsupported CPU/OS
> 
> The "unsupported" test just makes a pkey_alloc() syscall. It's probably
> calling the wrong syscall number or something.
> 
> I think it's still broken in mainline. What's the right fix?

A couple of thoughts:

1) I now think that that commit was a bad idea, because it turns out
kselftests doesn't make it easy to set up an asm/header.h approach.
And this partial approach seems like it won't work at all for syscalls
in particular.

I think reverting the commit is appropriate. It doesn't revert cleanly
at top of tree, but a very small fix allows a revert.

I'm attaching a patch that does that.

2) I'm unable to reproduce what you saw, because in ALL cases (before
or after the commit, and with or without a revert), I get the same
results on my Intel test machine:

     $ ./protection_keys_64
     has pkeys: 0
     running PKEY tests for unsupported CPU/OS

...so that's why I'm attaching a patch, in case you can verify that a
revert fixes it.


thanks,
-- 
John Hubbard

--------------PYAAtAZkxT9BPGCu56ENHaPF
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-Revert-selftests-mm-remove-local-__NR_-definitions.patch"
Content-Disposition: attachment;
 filename*0="0001-Revert-selftests-mm-remove-local-__NR_-definitions.patc";
 filename*1="h"
Content-Transfer-Encoding: base64

RnJvbSA3ZjI0Mjc0Y2NmM2RmZTdjNjZmNGI1MGUzNTMyMTFiYTNhZGU4ZjM0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2huIEh1YmJhcmQgPGpodWJiYXJkQG52aWRpYS5jb20+CkRh
dGU6IFdlZCwgMTIgRmViIDIwMjUgMjM6Mzg6MjEgLTA4MDAKU3ViamVjdDogW1BBVENIXSBSZXZl
cnQgInNlbGZ0ZXN0cy9tbTogcmVtb3ZlIGxvY2FsIF9fTlJfKiBkZWZpbml0aW9ucyIKWC1OVkNv
bmZpZGVudGlhbGl0eTogcHVibGljCkNjOiBKb2huIEh1YmJhcmQgPGpodWJiYXJkQG52aWRpYS5j
b20+CgpUaGlzIHJldmVydHMgY29tbWl0IGE1YzZiYzU5MDA5NGExYTczY2Y2ZmEzZjUwNWUxOTQ1
ZDJiZjI0NjEgLgoKRGV0YWlscyB0byBmb2xsb3csIGlmIHRoaXMgd29ya3MuIC0tamh1YmJhcmQK
ClNpZ25lZC1vZmYtYnk6IEpvaG4gSHViYmFyZCA8amh1YmJhcmRAbnZpZGlhLmNvbT4KLS0tCiB0
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tbS9odWdlcGFnZS1tcmVtYXAuYyAgICAgIHwgIDIgKy0K
IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21tL2tzbV9mdW5jdGlvbmFsX3Rlc3RzLmMgfCAgOCAr
KysrKysrLQogdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbW0vbWVtZmRfc2VjcmV0LmMgICAgICAg
ICB8IDE0ICsrKysrKysrKysrKystCiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tbS9ta2RpcnR5
LmMgICAgICAgICAgICAgIHwgIDggKysrKysrKy0KIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21t
L21sb2NrMi5oICAgICAgICAgICAgICAgfCAgMSAtCiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9t
bS9wcm90ZWN0aW9uX2tleXMuYyAgICAgIHwgIDIgKy0KIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L21tL3VmZmQtY29tbW9uLmMgICAgICAgICAgfCAgNCArKysrCiB0b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9tbS91ZmZkLXN0cmVzcy5jICAgICAgICAgIHwgMTUgKysrKysrKysrKysrKystCiB0b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9tbS91ZmZkLXVuaXQtdGVzdHMuYyAgICAgIHwgMTQgKysrKysr
KysrKysrKy0KIDkgZmlsZXMgY2hhbmdlZCwgNjAgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tbS9odWdlcGFnZS1tcmVt
YXAuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21tL2h1Z2VwYWdlLW1yZW1hcC5jCmluZGV4
IGFkYTkxNTZjYzQ5Ny4uYzQ2M2QxYzA5YzliIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9tbS9odWdlcGFnZS1tcmVtYXAuYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9tbS9odWdlcGFnZS1tcmVtYXAuYwpAQCAtMTUsNyArMTUsNyBAQAogI2RlZmluZSBfR05VX1NP
VVJDRQogI2luY2x1ZGUgPHN0ZGxpYi5oPgogI2luY2x1ZGUgPHN0ZGlvLmg+Ci0jaW5jbHVkZSA8
YXNtLWdlbmVyaWMvdW5pc3RkLmg+CisjaW5jbHVkZSA8dW5pc3RkLmg+CiAjaW5jbHVkZSA8c3lz
L21tYW4uaD4KICNpbmNsdWRlIDxlcnJuby5oPgogI2luY2x1ZGUgPGZjbnRsLmg+IC8qIERlZmlu
aXRpb24gb2YgT18qIGNvbnN0YW50cyAqLwpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvbW0va3NtX2Z1bmN0aW9uYWxfdGVzdHMuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L21tL2tzbV9mdW5jdGlvbmFsX3Rlc3RzLmMKaW5kZXggNjZiNGUxMTFiNWEyLi5iNjE4MDNlMzZk
MWMgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21tL2tzbV9mdW5jdGlvbmFs
X3Rlc3RzLmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbW0va3NtX2Z1bmN0aW9uYWxf
dGVzdHMuYwpAQCAtMTEsNyArMTEsNyBAQAogI2luY2x1ZGUgPHN0cmluZy5oPgogI2luY2x1ZGUg
PHN0ZGJvb2wuaD4KICNpbmNsdWRlIDxzdGRpbnQuaD4KLSNpbmNsdWRlIDxhc20tZ2VuZXJpYy91
bmlzdGQuaD4KKyNpbmNsdWRlIDx1bmlzdGQuaD4KICNpbmNsdWRlIDxlcnJuby5oPgogI2luY2x1
ZGUgPGZjbnRsLmg+CiAjaW5jbHVkZSA8c3lzL21tYW4uaD4KQEAgLTM2OSw2ICszNjksNyBAQCBz
dGF0aWMgdm9pZCB0ZXN0X3VubWVyZ2VfZGlzY2FyZGVkKHZvaWQpCiAJbXVubWFwKG1hcCwgc2l6
ZSk7CiB9CiAKKyNpZmRlZiBfX05SX3VzZXJmYXVsdGZkCiBzdGF0aWMgdm9pZCB0ZXN0X3VubWVy
Z2VfdWZmZF93cCh2b2lkKQogewogCXN0cnVjdCB1ZmZkaW9fd3JpdGVwcm90ZWN0IHVmZmRfd3Jp
dGVwcm90ZWN0OwpAQCAtNDI5LDYgKzQzMCw3IEBAIHN0YXRpYyB2b2lkIHRlc3RfdW5tZXJnZV91
ZmZkX3dwKHZvaWQpCiB1bm1hcDoKIAltdW5tYXAobWFwLCBzaXplKTsKIH0KKyNlbmRpZgogCiAv
KiBWZXJpZnkgdGhhdCBLU00gY2FuIGJlIGVuYWJsZWQgLyBxdWVyaWVkIHdpdGggcHJjdGwuICov
CiBzdGF0aWMgdm9pZCB0ZXN0X3ByY3RsKHZvaWQpCkBAIC02ODQsNyArNjg2LDkgQEAgaW50IG1h
aW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQogCQlleGl0KHRlc3RfY2hpbGRfa3NtKCkpOwogCX0K
IAorI2lmZGVmIF9fTlJfdXNlcmZhdWx0ZmQKIAl0ZXN0cysrOworI2VuZGlmCiAKIAlrc2Z0X3By
aW50X2hlYWRlcigpOwogCWtzZnRfc2V0X3BsYW4odGVzdHMpOwpAQCAtNjk2LDcgKzcwMCw5IEBA
IGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikKIAl0ZXN0X3VubWVyZ2UoKTsKIAl0ZXN0
X3VubWVyZ2VfemVyb19wYWdlcygpOwogCXRlc3RfdW5tZXJnZV9kaXNjYXJkZWQoKTsKKyNpZmRl
ZiBfX05SX3VzZXJmYXVsdGZkCiAJdGVzdF91bm1lcmdlX3VmZmRfd3AoKTsKKyNlbmRpZgogCiAJ
dGVzdF9wcm90X25vbmUoKTsKIApkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
bW0vbWVtZmRfc2VjcmV0LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tbS9tZW1mZF9zZWNy
ZXQuYwppbmRleCA3NGM5MTFhYTNhZWEuLjlhMDU5NzMxMGE3NiAxMDA2NDQKLS0tIGEvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvbW0vbWVtZmRfc2VjcmV0LmMKKysrIGIvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvbW0vbWVtZmRfc2VjcmV0LmMKQEAgLTE3LDcgKzE3LDcgQEAKIAogI2luY2x1ZGUg
PHN0ZGxpYi5oPgogI2luY2x1ZGUgPHN0cmluZy5oPgotI2luY2x1ZGUgPGFzbS1nZW5lcmljL3Vu
aXN0ZC5oPgorI2luY2x1ZGUgPHVuaXN0ZC5oPgogI2luY2x1ZGUgPGVycm5vLmg+CiAjaW5jbHVk
ZSA8c3RkaW8uaD4KICNpbmNsdWRlIDxmY250bC5oPgpAQCAtMjgsNiArMjgsOCBAQAogI2RlZmlu
ZSBwYXNzKGZtdCwgLi4uKSBrc2Z0X3Rlc3RfcmVzdWx0X3Bhc3MoZm10LCAjI19fVkFfQVJHU19f
KQogI2RlZmluZSBza2lwKGZtdCwgLi4uKSBrc2Z0X3Rlc3RfcmVzdWx0X3NraXAoZm10LCAjI19f
VkFfQVJHU19fKQogCisjaWZkZWYgX19OUl9tZW1mZF9zZWNyZXQKKwogI2RlZmluZSBQQVRURVJO
CTB4NTUKIAogc3RhdGljIGNvbnN0IGludCBwcm90ID0gUFJPVF9SRUFEIHwgUFJPVF9XUklURTsK
QEAgLTMzMiwzICszMzQsMTMgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIAog
CWtzZnRfZmluaXNoZWQoKTsKIH0KKworI2Vsc2UgLyogX19OUl9tZW1mZF9zZWNyZXQgKi8KKwor
aW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKK3sKKwlwcmludGYoInNraXA6IHNraXBw
aW5nIG1lbWZkX3NlY3JldCB0ZXN0IChtaXNzaW5nIF9fTlJfbWVtZmRfc2VjcmV0KVxuIik7CisJ
cmV0dXJuIEtTRlRfU0tJUDsKK30KKworI2VuZGlmIC8qIF9fTlJfbWVtZmRfc2VjcmV0ICovCmRp
ZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tbS9ta2RpcnR5LmMgYi90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9tbS9ta2RpcnR5LmMKaW5kZXggYWYyZmNlNDk2OTEyLi4wOWZlZWI0
NTM2NDYgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21tL21rZGlydHkuYwor
KysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tbS9ta2RpcnR5LmMKQEAgLTksNyArOSw3IEBA
CiAgKi8KICNpbmNsdWRlIDxmY250bC5oPgogI2luY2x1ZGUgPHNpZ25hbC5oPgotI2luY2x1ZGUg
PGFzbS1nZW5lcmljL3VuaXN0ZC5oPgorI2luY2x1ZGUgPHVuaXN0ZC5oPgogI2luY2x1ZGUgPHN0
cmluZy5oPgogI2luY2x1ZGUgPGVycm5vLmg+CiAjaW5jbHVkZSA8c3RkbGliLmg+CkBAIC0yNjUs
NiArMjY1LDcgQEAgc3RhdGljIHZvaWQgdGVzdF9wdGVfbWFwcGVkX3RocCh2b2lkKQogCW11bm1h
cChtbWFwX21lbSwgbW1hcF9zaXplKTsKIH0KIAorI2lmZGVmIF9fTlJfdXNlcmZhdWx0ZmQKIHN0
YXRpYyB2b2lkIHRlc3RfdWZmZGlvX2NvcHkodm9pZCkKIHsKIAlzdHJ1Y3QgdWZmZGlvX3JlZ2lz
dGVyIHVmZmRpb19yZWdpc3RlcjsKQEAgLTMyMiw2ICszMjMsNyBAQCBzdGF0aWMgdm9pZCB0ZXN0
X3VmZmRpb19jb3B5KHZvaWQpCiAJbXVubWFwKGRzdCwgcGFnZXNpemUpOwogCWZyZWUoc3JjKTsK
IH0KKyNlbmRpZiAvKiBfX05SX3VzZXJmYXVsdGZkICovCiAKIGludCBtYWluKHZvaWQpCiB7CkBA
IC0zMzQsNyArMzM2LDkgQEAgaW50IG1haW4odm9pZCkKIAkJCSAgICAgICB0aHBzaXplIC8gMTAy
NCk7CiAJCXRlc3RzICs9IDM7CiAJfQorI2lmZGVmIF9fTlJfdXNlcmZhdWx0ZmQKIAl0ZXN0cyAr
PSAxOworI2VuZGlmIC8qIF9fTlJfdXNlcmZhdWx0ZmQgKi8KIAogCWtzZnRfcHJpbnRfaGVhZGVy
KCk7CiAJa3NmdF9zZXRfcGxhbih0ZXN0cyk7CkBAIC0zNjQsNyArMzY4LDkgQEAgaW50IG1haW4o
dm9pZCkKIAlpZiAodGhwc2l6ZSkKIAkJdGVzdF9wdGVfbWFwcGVkX3RocCgpOwogCS8qIFBsYWNp
bmcgYSBmcmVzaCBwYWdlIHZpYSB1c2VyZmF1bHRmZCBtYXkgc2V0IHRoZSBQVEUgZGlydHkuICov
CisjaWZkZWYgX19OUl91c2VyZmF1bHRmZAogCXRlc3RfdWZmZGlvX2NvcHkoKTsKKyNlbmRpZiAv
KiBfX05SX3VzZXJmYXVsdGZkICovCiAKIAllcnIgPSBrc2Z0X2dldF9mYWlsX2NudCgpOwogCWlm
IChlcnIpCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tbS9tbG9jazIuaCBi
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21tL21sb2NrMi5oCmluZGV4IDFlNTczMWJhYjQ5OS4u
NDQxN2VhYTVjZmI3IDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tbS9tbG9j
azIuaAorKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tbS9tbG9jazIuaApAQCAtMyw3ICsz
LDYgQEAKICNpbmNsdWRlIDxlcnJuby5oPgogI2luY2x1ZGUgPHN0ZGlvLmg+CiAjaW5jbHVkZSA8
c3RkbGliLmg+Ci0jaW5jbHVkZSA8YXNtLWdlbmVyaWMvdW5pc3RkLmg+CiAKIHN0YXRpYyBpbnQg
bWxvY2syXyh2b2lkICpzdGFydCwgc2l6ZV90IGxlbiwgaW50IGZsYWdzKQogewpkaWZmIC0tZ2l0
IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbW0vcHJvdGVjdGlvbl9rZXlzLmMgYi90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9tbS9wcm90ZWN0aW9uX2tleXMuYwppbmRleCBhNDY4M2YyNDc2ZjIu
LjM1NTY1YWYzMDhhZiAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbW0vcHJv
dGVjdGlvbl9rZXlzLmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbW0vcHJvdGVjdGlv
bl9rZXlzLmMKQEAgLTQyLDcgKzQyLDcgQEAKICNpbmNsdWRlIDxzeXMvd2FpdC5oPgogI2luY2x1
ZGUgPHN5cy9zdGF0Lmg+CiAjaW5jbHVkZSA8ZmNudGwuaD4KLSNpbmNsdWRlIDxhc20tZ2VuZXJp
Yy91bmlzdGQuaD4KKyNpbmNsdWRlIDx1bmlzdGQuaD4KICNpbmNsdWRlIDxzeXMvcHRyYWNlLmg+
CiAjaW5jbHVkZSA8c2V0am1wLmg+CiAKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL21tL3VmZmQtY29tbW9uLmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tbS91ZmZkLWNv
bW1vbi5jCmluZGV4IDcxNzUzOWVkZGY5OC4uN2FkNmJhNjYwYzdkIDEwMDY0NAotLS0gYS90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9tbS91ZmZkLWNvbW1vbi5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL21tL3VmZmQtY29tbW9uLmMKQEAgLTY3Myw3ICs2NzMsMTEgQEAgaW50IHVmZmRf
b3Blbl9kZXYodW5zaWduZWQgaW50IGZsYWdzKQogCiBpbnQgdWZmZF9vcGVuX3N5cyh1bnNpZ25l
ZCBpbnQgZmxhZ3MpCiB7CisjaWZkZWYgX19OUl91c2VyZmF1bHRmZAogCXJldHVybiBzeXNjYWxs
KF9fTlJfdXNlcmZhdWx0ZmQsIGZsYWdzKTsKKyNlbHNlCisJcmV0dXJuIC0xOworI2VuZGlmCiB9
CiAKIGludCB1ZmZkX29wZW4odW5zaWduZWQgaW50IGZsYWdzKQpkaWZmIC0tZ2l0IGEvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvbW0vdWZmZC1zdHJlc3MuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL21tL3VmZmQtc3RyZXNzLmMKaW5kZXggYTRiODMyODA5OThhLi45NDRkNTU5YWRlMjEgMTAw
NjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21tL3VmZmQtc3RyZXNzLmMKKysrIGIv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbW0vdWZmZC1zdHJlc3MuYwpAQCAtMzMsMTAgKzMzLDEx
IEBACiAgKiBwdGhyZWFkX211dGV4X2xvY2sgd2lsbCBhbHNvIHZlcmlmeSB0aGUgYXRvbWljaXR5
IG9mIHRoZSBtZW1vcnkKICAqIHRyYW5zZmVyIChVRkZESU9fQ09QWSkuCiAgKi8KLSNpbmNsdWRl
IDxhc20tZ2VuZXJpYy91bmlzdGQuaD4KKwogI2luY2x1ZGUgInVmZmQtY29tbW9uLmgiCiAKIHVp
bnQ2NF90IGZlYXR1cmVzOworI2lmZGVmIF9fTlJfdXNlcmZhdWx0ZmQKIAogI2RlZmluZSBCT1VO
Q0VfUkFORE9NCQkoMTw8MCkKICNkZWZpbmUgQk9VTkNFX1JBQ0lOR0ZBVUxUUwkoMTw8MSkKQEAg
LTQ3MSwzICs0NzIsMTUgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQogCSAgICAg
ICBucl9wYWdlcywgbnJfcGFnZXNfcGVyX2NwdSk7CiAJcmV0dXJuIHVzZXJmYXVsdGZkX3N0cmVz
cygpOwogfQorCisjZWxzZSAvKiBfX05SX3VzZXJmYXVsdGZkICovCisKKyN3YXJuaW5nICJtaXNz
aW5nIF9fTlJfdXNlcmZhdWx0ZmQgZGVmaW5pdGlvbiIKKworaW50IG1haW4odm9pZCkKK3sKKwlw
cmludGYoInNraXA6IFNraXBwaW5nIHVzZXJmYXVsdGZkIHRlc3QgKG1pc3NpbmcgX19OUl91c2Vy
ZmF1bHRmZClcbiIpOworCXJldHVybiBLU0ZUX1NLSVA7Cit9CisKKyNlbmRpZiAvKiBfX05SX3Vz
ZXJmYXVsdGZkICovCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tbS91ZmZk
LXVuaXQtdGVzdHMuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL21tL3VmZmQtdW5pdC10ZXN0
cy5jCmluZGV4IDlmZjcxZmExZjliZi4uNzRjOGJjMDJiNTA2IDEwMDY0NAotLS0gYS90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9tbS91ZmZkLXVuaXQtdGVzdHMuYworKysgYi90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9tbS91ZmZkLXVuaXQtdGVzdHMuYwpAQCAtNSwxMSArNSwxMiBAQAogICogIENv
cHlyaWdodCAoQykgMjAxNS0yMDIzICBSZWQgSGF0LCBJbmMuCiAgKi8KIAotI2luY2x1ZGUgPGFz
bS1nZW5lcmljL3VuaXN0ZC5oPgogI2luY2x1ZGUgInVmZmQtY29tbW9uLmgiCiAKICNpbmNsdWRl
ICIuLi8uLi8uLi8uLi9tbS9ndXBfdGVzdC5oIgogCisjaWZkZWYgX19OUl91c2VyZmF1bHRmZAor
CiAvKiBUaGUgdW5pdCB0ZXN0IGRvZXNuJ3QgbmVlZCBhIGxhcmdlIG9yIHJhbmRvbSBzaXplLCBt
YWtlIGl0IDMyTUIgZm9yIG5vdyAqLwogI2RlZmluZSAgVUZGRF9URVNUX01FTV9TSVpFICAgICAg
ICAgICAgICAgKDMyVUwgPDwgMjApCiAKQEAgLTE1NTgsMyArMTU1OSwxNCBAQCBpbnQgbWFpbihp
bnQgYXJnYywgY2hhciAqYXJndltdKQogCXJldHVybiBrc2Z0X2dldF9mYWlsX2NudCgpID8gS1NG
VF9GQUlMIDogS1NGVF9QQVNTOwogfQogCisjZWxzZSAvKiBfX05SX3VzZXJmYXVsdGZkICovCisK
KyN3YXJuaW5nICJtaXNzaW5nIF9fTlJfdXNlcmZhdWx0ZmQgZGVmaW5pdGlvbiIKKworaW50IG1h
aW4odm9pZCkKK3sKKwlwcmludGYoIlNraXBwaW5nICVzIChtaXNzaW5nIF9fTlJfdXNlcmZhdWx0
ZmQpXG4iLCBfX2ZpbGVfXyk7CisJcmV0dXJuIEtTRlRfU0tJUDsKK30KKworI2VuZGlmIC8qIF9f
TlJfdXNlcmZhdWx0ZmQgKi8KLS0gCjIuNDguMQoK

--------------PYAAtAZkxT9BPGCu56ENHaPF--

