Return-Path: <linux-kselftest+bounces-30236-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28743A7D8C8
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 10:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB0E01887053
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 08:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFE022A80D;
	Mon,  7 Apr 2025 08:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="anCgZ2RC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011065.outbound.protection.outlook.com [52.101.129.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6948822A7ED;
	Mon,  7 Apr 2025 08:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744016156; cv=fail; b=c9sYg7MwRXCqKCZeqJCDn6Q2915gTIdGxA8bMjxrUsLOn751mZCyP1sFndpA6nKb1ABXEymoCjKkVeSuhFyQhuZXMkCyx37ieKHi8cbdfcyT6z35x6JFUT/II/5vp/P4OCHXt2dJehPnEcl62PSDkSf0xC3b/DocLgMtnBxGkBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744016156; c=relaxed/simple;
	bh=YvCWzrBKHuRyh+UW9RMAxg/YLxydpbcdq5u14L2hP+E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JJ8GV49dw3GfHCsG1CJJP0dPdplQ10kZ028X5iTOpDq85pev1ui+6WOVEdcK6OzR28nlV76ysXWBjYD5/FJTuAKQ3c6VfzlmCR29bSI0FY4b+le6utLrqwHfwDYX64+r47E+9C78UcRhIG7nuYcxdJq2PAjEPWNdVHOMkOeAUgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=anCgZ2RC; arc=fail smtp.client-ip=52.101.129.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQfKvXJCTcHCuFIaaAsqT4dZgjMKcIay1Fg+kj4Idbi//GnWt6BWz0gT0Ru47xGymnrIvYr/dzZDjCQ5T8T3DGAWFXi4+wsiLFkqCE7pFowLVon9zEwbgnJxzcljTR+6OeM9GHMvDuiG84XbzzuTOxgO3gsFwaCM2nideNBixyZItvTqavM+MZLwqssrkDNEGIgBd0l5zdcrbLFrGV+OIjPN1JtRawP1BlQ3jm/dbhYJhYfigBfeedcB85LeeSVFq+V2Oi8S2k4O1wle9vMeaVMWqLE7MvSzGOsFdzVrG95O6Vx6lVqsWs3FI5q7Ogb5INuVO5CIYXZbt0bpANUkDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBQSN7SB1IuWN2cl0nVtbj365BeYHwnxF+9OpTTrCBI=;
 b=F0oCmfNUW45u79sYM9hVk6evi623dcrxeDTIUCuj223KftOSh0oiEQaIfF/2KWQxaE5ZBFjOqAVrTSWemFsdVDhyLzRmKsdqtRmBfWC3m30nvQ9WxF4jkuRvs/ZUO9eP6P4Rv7/JisRD0CIOxi4xRSYzSGESFLMQ6TuC8kEuMa3x5whbLVpVGogGEPTb0lpNAGRky4wX0yF+KKI63zuhidMAw+YOBSkL+4vNrnP8mOiGvyCnyuGjG9J4yCyJJkLBQlDcRxHXmYqwUoBFHhn71cyW7cTqo7zuIYlyJld3BFjdCWp9FILQmopx4t4fZIipIy8k38oSghs/I0iYww8KRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBQSN7SB1IuWN2cl0nVtbj365BeYHwnxF+9OpTTrCBI=;
 b=anCgZ2RClRLndEKIH4QPDd3dETAtBEMnFLiily0UENUd3nhWLMd9spaGbdU+E1TlAw7VbSJ+jCwlQEkMF7sRb/uLAiCTr23o7kb2c7IxRRgqLI0/gwRrAbgfARE/2QiS1hvpkQKuYqTtdzqozIuWo6wVngKPvTqoKpMudWfRf2xiDz+H7tC/a+PLDWBhoRBN/roR167DyFo4cqzjxBD0bMZXOFKZZMw7F7McvDOPH/xeJdaCXVRRzaKwS4Ze691K7Gkpj45BdgwJw9Pb/LcQ4tS7DectNq10O1mZnD7KdCLO6ik4GsQHqbaih1P6KmvS/QpUXHA9QxH+0lQcAgRPEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by OS8PR06MB7302.apcprd06.prod.outlook.com (2603:1096:604:284::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Mon, 7 Apr
 2025 08:55:47 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%4]) with mapi id 15.20.8583.043; Mon, 7 Apr 2025
 08:55:46 +0000
Message-ID: <276d2b85-0d5a-4bff-a408-604d823efef0@vivo.com>
Date: Mon, 7 Apr 2025 16:55:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP is broken, was Re: [RFC
 PATCH 0/6] Deep talk about folio vmap
To: Muchun Song <muchun.song@linux.dev>
Cc: bingbu.cao@linux.intel.com, Christoph Hellwig <hch@lst.de>,
 Matthew Wilcox <willy@infradead.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 opensource.kernel@vivo.com
References: <20250327092922.536-1-link@vivo.com>
 <20250404090111.GB11105@lst.de>
 <9A899641-BDED-4773-B349-56AF1DD58B21@linux.dev>
 <43DD699A-5C5D-429B-A2B5-61FBEAE2E252@linux.dev>
 <e9f44d16-fd9a-4d82-b40e-c173d068676a@vivo.com>
 <E4D6E02F-BC82-4630-8CB8-CD1A0163ABCF@linux.dev>
 <6f76a497-248b-4f92-9448-755006c732c8@vivo.com>
 <FDB7F930-8537-4B79-BAA6-AA782B39943A@linux.dev>
 <35D26C00-952F-481C-8345-E339F0ED770B@linux.dev>
 <55306631-8421-455a-9d03-709ebee97d76@vivo.com>
 <777BB63E-245D-4027-880A-FFC3717928D7@linux.dev>
From: Huan Yang <link@vivo.com>
In-Reply-To: <777BB63E-245D-4027-880A-FFC3717928D7@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::11) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|OS8PR06MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: 638bd07d-d486-45a7-061b-08dd75b1fc56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUF3MlVhRmlJUGtqaDg5OHZkcWlqS1NiSlhoWHdjalZsN2c2b1gvcXNWVHBn?=
 =?utf-8?B?ckNPWWRUV05qL3NlYlpjaFBXNEZVM3hQZVdER1dISUZpa2FKci9FV2hpRFNC?=
 =?utf-8?B?QkV4RWx0aEZMTkptZzY4SGNCTVRmS2MwRVBXdGRTcU9pMmVaN2U3Tml6di83?=
 =?utf-8?B?S1kwZEZySkRTQ3F6NXFydzZZV1JET1NUUjFHNWg4bExMa080YnEzcGFGcks5?=
 =?utf-8?B?eC95Qmd6MTVzT05BdUQwM3E0amFCZWgrUTgrTVpWMDMyYWZYR29xdnQ0eGpY?=
 =?utf-8?B?QlgzTVNub1NoTitUV1hKMU1rZlNyOUhST0J6czd0Qk1jQkRGeDV4V1VWdjBt?=
 =?utf-8?B?Q0Z3bExqTzZSVUxBVVZUWVBnVStudlRsakRBSEl2ejl1UHdmakRSMXlJQkdl?=
 =?utf-8?B?ZElROG5jZW81bXFXR2Jma3lPb1dyWkZlMGxpNkRkZElSbURKVTBuVzY5UGxC?=
 =?utf-8?B?VVA3TjRmV2VEemhjRjZ6b2JPK01VN1oyZFBGd3VSaXQ5VmFqQk1Ec3E4T2o0?=
 =?utf-8?B?aHNpUFVuMkNwY2c5UHlsRjFsZTlhS3hZdWVNTnpzRFJEdWtMekxWa2JOOW44?=
 =?utf-8?B?Q1J3cmxxdzVrMnRPbUwwVVlaaGFYNkoyZHdyS1ZJQkNBZDdVZzIrcDY4bkF5?=
 =?utf-8?B?MnZlREZ6SVNBTWdabUNXc2JwNUJITFBqMTFpNHZmWVRQb3hCTkJCVTFQcVU4?=
 =?utf-8?B?NmRuVHhxMHJ1cTBwdjZUTDQ5MjBJY09NSGh1UGhCbE01SXh0T29qUEtTSk5j?=
 =?utf-8?B?Q09kQkFTdXkxcVBEOFE2UmM3MnhzTTR2M0YxSmxjWlN4dHpsR1NMYlRob1RJ?=
 =?utf-8?B?MEdvR1Q3WVFJUXlJdjNNdkxUTzZaTWNrOFNBZzdxWXlqazVCc21nMS9ZV0lT?=
 =?utf-8?B?bkpaN0RIemNyRXlDQ0JwNFFOVXBlRkxGbUx2ZURmQVZmUzBGZE1wc25TNzFy?=
 =?utf-8?B?SDQ0bmdpZ2FBZ0M1bDZxVU9yczg1WWYwZERlZUw5SFdJZkFtQ0EwblBJck5N?=
 =?utf-8?B?VXlDM0RDZGYyVWEvQ3daWFliNSs5TjZzR1J4THpWZEJzS1FQQ2tTNkdINHBO?=
 =?utf-8?B?bjhCWkkweTBNd1orbGllMVpobXlUYmtFd1JNYnBRU1MrMithUTFFYTdteDUy?=
 =?utf-8?B?Mkp2MVFsM3drUXd5YVJMSFZwVXZHb015d09QWmtjMXg4VlVjYVJ0OTBWYzE4?=
 =?utf-8?B?QkJ2TTVmcHp2WHF2ZzczVGN3KzB6S2daYytJQmtYWkZBc21HS1FGYjdzZDh5?=
 =?utf-8?B?Z0I1NWJ1MWJCRWVrMHMzVVFhcm82MjMwVHcyZU5YNS9wczBJcGQ2dFpPeWVa?=
 =?utf-8?B?QmlxbVlFWFA3NFBFNDdVTWM2TmVSdFYwLzZLQlJQeGZmM3d3UEZJeDM4Q0JU?=
 =?utf-8?B?VU5QK0pBU0RKeFMvWUltN3BkWXNZM0tmTm15ak1uL3NSWVdsbVh5dUNaU1BY?=
 =?utf-8?B?K3hDK01Eb043MUNsQjFtZUhmMHE2WnRzcVF2c1Z5dDk5WUhkNHU3V3JzVThO?=
 =?utf-8?B?Vm15aG50SzJybFVCR01mem9UMGZtdS9UMWNZMTVaV2FBQ0x5S1kzTGxuT3R0?=
 =?utf-8?B?NGRHZGkzdTlBZElzeW0zUm5nemk3enRhNFRtZzNERldXdDhTOU82NXlCeXJP?=
 =?utf-8?B?NVpTWjQ1cnUydW4wcFFmTkVJcmJ1VTdXTC81MmgwcVk5S0txNDJ2ZEhkTWZZ?=
 =?utf-8?B?OHRFaXR3amZHS0paRWE3aU9ndmhoN3F2a2lZbjNBbW1YSjlISE1NTDN5Tkt6?=
 =?utf-8?B?aGFacDRySC8xaXhKTjZPQ3Uxcm0xL0N4c0E4S3hzajhHeEpLOCtJczg5MFpz?=
 =?utf-8?B?KzBLM1A5RU1WYzVOZGYrdXFUVVJ4MDQwME9TeFpFTU5uK1RCS2VqdWNTUjBY?=
 =?utf-8?B?SmhSemFvWFV5ZkYyOE9RaHVtTHFYeFRhTGZlV2EyZXdIb3dmZDRLN3NJT2l3?=
 =?utf-8?Q?kr+hTzx8NkZQnhG3K76FvV+pdAksg89P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1dkNXpTZXNReEtMWG5YdTd3S2tBcFVOait0RDRYVVdpZGdjMHFMZFFUUldx?=
 =?utf-8?B?K2xEWndJakt4NG5NQXZBYTlvTHkySC9KVWZwYzRiL2s2am5rOU14K29QSTVC?=
 =?utf-8?B?M2E4WFZpeVFjZnowN1ljT1NWNkEzN1JsbUdYOURMOWV0NHpxVzd6Q1B3Q0NY?=
 =?utf-8?B?VVVVcjl2R0xybU5HNGxTeENXdnJKSDdoRUt5ZHAzS1R2YnhROEM4WWcrZStO?=
 =?utf-8?B?QmxoTGlXekkvbXpzZXRBMFltd21iNHo3cmhUd1IwYnFYSTM4Mk1hNE5qcGN1?=
 =?utf-8?B?MjgvOWdHMkFERWtPKzd4REpNYUpHL2Vaa2gweS8wM29TVXNjQ1BqUVlwYTVK?=
 =?utf-8?B?cUJQTjQzeUlmTnZjK0RCd2RxOFYyVEJaY3NjQmxuZzhucm93UHRQNEJHMW5N?=
 =?utf-8?B?c3dxcjZuM3pVdTY0N2VXVkxFYjNUQ3Rpa2JnemFmdEJ0ZDFyaERlOWRXZzl4?=
 =?utf-8?B?NTg1RUJtZTYzbVlIeThFVnFPNVJVWDhYSzlpNEFleDVvY25BVC8yYVc0Nkkw?=
 =?utf-8?B?WEd2SUxIcjRKZ0RlemhaaG1iR3lRRXNXc1BrTk5sK2phNmVIcnN6QXFkWmhS?=
 =?utf-8?B?MFBuK1R1a0dpWFBqT1I4OGNVMWxQRVpkb3liS3pjdXEya2dzSXRWZUdxd3E0?=
 =?utf-8?B?aEgycGxyOURTZlhPSzdQVTRkUmlaYlJLYlFvcU51bEtFMmRSQnZ4aFZxSWJ1?=
 =?utf-8?B?YlRkSHk0YXVBaDBDdEtxQXJxVUFRL1FIUGY4R1kxYTB4Uzlwb1RvcmJYc2lo?=
 =?utf-8?B?Z0t5RWVPZTU3dHoxOHFEUVQ4QjV1aXpyZjNlQmVnSm1OWUxPalhrOERvSWN3?=
 =?utf-8?B?cW51b0hFRTk5SlltcVpWSU5RaHFMajUxazlKeGR3b0hYRXlzcXg0Q3UxYTNW?=
 =?utf-8?B?bldZakY4MStqLzI0SGIrMVJ1ejRNMkJaaWlsMldWbGxHaDBhcnAyR2tjNnZa?=
 =?utf-8?B?VFZjVm1OSHFLbXozSWRhMjhBMnlPa3VybUI2L3FhQ1Y5K1RidHQ5bWlHci92?=
 =?utf-8?B?QWE4M1hiTkdaQVR1Ry9RMDJXSjNlWVZGeVlMeWczdENOS0QzY0lBR1lpNzZN?=
 =?utf-8?B?cy9hR1l3Ymc3NkNObFdST0tRUzN1bTdBdktMdEFVM1BmWHVIM3k5a0tMc3FJ?=
 =?utf-8?B?dGJFaXE2bEZqMEd6blBQTXdJSDFXMEcrRGtrSHBORVZoL0xqVlNUZHdESGVp?=
 =?utf-8?B?RnhzNW9lQjNsdDlocXNIUktWZnFBQndhcXQ2b3FreVdOQzBrMXJMa1l4ZGtV?=
 =?utf-8?B?UW9hQzdKWDFWTFprOHh3TExlNWxTMThIQ0loY25sMXlFeU5INlU2WDN2ckwr?=
 =?utf-8?B?OUF3VDRrMzJyY01Jdys1azhESVdEU2dYM0UvSFUxaDJUdmREWVRDRitjR0lF?=
 =?utf-8?B?Ym12OHEzdG5vQzhtNUdmMlErcit4OXNLc2xUS2VKOWc1dXFrRVJaZmFicUl0?=
 =?utf-8?B?b1NDeVlpNGZZTy9lT3BEZXdjY1Uwdks3NEJjQ3lLM0JmRjVxWTN5anNKSFAy?=
 =?utf-8?B?TThZSnVRUmJ3OWRmWkh6TlRER1hoZVc1eXVJQmY4ZEpKUTNHSTdrMi9pd0M1?=
 =?utf-8?B?UHhXaDQ3MEJSeWg3YnUwUWFkNlBCMERYUlVmREFQd1R0c2NFaE9pMFc4YlJi?=
 =?utf-8?B?WkgzT0srRjI2V1ppcEpZMXptUERtTERvZ2E4b0JHN1pIQ2c3b2xrNHQ4d3BJ?=
 =?utf-8?B?VVhaOGExOElSdFNqRmt2OU5KUDVrSm5leFNpMlRzSmJlZVM5Zi9jczhxWEFv?=
 =?utf-8?B?OWhaYUl2eDAxTnNPYmlsVENzcXF0TDhSOFRNTUFDQ0FRWVFNSmVVRFNLRFVW?=
 =?utf-8?B?c3ZiZVg3T3c1VCtJZGZ0bFc1dm9MYWFrVlNzUDJuOUV3ZUJ0eE4rMDZ6Ujcx?=
 =?utf-8?B?M3VVZmNJN0M2T2JqaUVnRHNmem5hdVVxMkpXbGg5ZkQrMUczbWY2ekxscVBn?=
 =?utf-8?B?aFRuKzBPNlJTM1lTRnJ6L2hlMDJxVW5VTTZKWkhFRFZWNkQ2UlV6dW1MNGhX?=
 =?utf-8?B?em1zenFFYWpJU3Z0TmlQbEMvODRQRWpjaUJvSGxsTmpNbXRYS0NqTWhnVmx6?=
 =?utf-8?B?YUNrQ1Bjc0lOZmhTS3VSY3JkS2ZRamxiV3NhekdzRHp1Q2cxRXpKNHdJZDRw?=
 =?utf-8?Q?Bbf9v/B7yYrmDqX2rqWO0/i2/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 638bd07d-d486-45a7-061b-08dd75b1fc56
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 08:55:46.2163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+BUTSN0Ks7hJkP/cPwoEUT2dSfLaCskAVA16Gf73I5ioMKthV1TGm4lFh/rzBmorqfR+XW0GP3zGLz+e34Alw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR06MB7302


在 2025/4/7 15:22, Muchun Song 写道:
>
>> On Apr 7, 2025, at 15:09, Huan Yang <link@vivo.com> wrote:
>>
>>
>> 在 2025/4/7 14:43, Muchun Song 写道:
>>>> On Apr 7, 2025, at 11:37, Muchun Song <muchun.song@linux.dev> wrote:
>>>>
>>>>
>>>>
>>>>> On Apr 7, 2025, at 11:21, Huan Yang <link@vivo.com> wrote:
>>>>>
>>>>>
>>>>> 在 2025/4/7 10:57, Muchun Song 写道:
>>>>>>> On Apr 7, 2025, at 09:59, Huan Yang <link@vivo.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>> 在 2025/4/4 18:07, Muchun Song 写道:
>>>>>>>>> On Apr 4, 2025, at 17:38, Muchun Song <muchun.song@linux.dev> wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> On Apr 4, 2025, at 17:01, Christoph Hellwig <hch@lst.de> wrote:
>>>>>>>>>>
>>>>>>>>>> After the btrfs compressed bio discussion I think the hugetlb changes that
>>>>>>>>>> skip the tail pages are fundamentally unsafe in the current kernel.
>>>>>>>>>>
>>>>>>>>>> That is because the bio_vec representation assumes tail pages do exist, so
>>>>>>>>>> as soon as you are doing direct I/O that generates a bvec starting beyond
>>>>>>>>>> the present head page things will blow up.  Other users of bio_vecs might
>>>>>>>>>> do the same, but the way the block bio_vecs are generated are very suspect
>>>>>>>>>> to that.  So we'll first need to sort that out and a few other things
>>>>>>>>>> before we can even think of enabling such a feature.
>>>>>>>>>>
>>>>>>>>> I would like to express my gratitude to Christoph for including me in the
>>>>>>>>> thread. I have carefully read the cover letter in [1], which indicates
>>>>>>>>> that an issue has arisen due to the improper use of `vmap_pfn()`. I'm
>>>>>>>>> wondering if we could consider using `vmap()` instead. In the HVO scenario,
>>>>>>>>> the tail struct pages do **exist**, but they are read-only. I've examined
>>>>>>>>> the code of `vmap()`, and it appears that it only reads the struct page.
>>>>>>>>> Therefore, it seems feasible for us to use `vmap()` (I am not a expert in
>>>>>>>>> udmabuf.). Right?
>>>>>>>> I believe my stance is correct. I've also reviewed another thread in [2].
>>>>>>>> Allow me to clarify and correct the viewpoints you presented. You stated:
>>>>>>>>   "
>>>>>>>>    So by HVO, it also not backed by pages, only contains folio head, each
>>>>>>>>    tail pfn's page struct go away.
>>>>>>>>   "
>>>>>>>> This statement is entirely inaccurate. The tail pages do not cease to exist;
>>>>>>>> rather, they are read-only. For your specific use-case, please use `vmap()`
>>>>>>>> to resolve the issue at hand. If you wish to gain a comprehensive understanding
>>>>>>> I see the document give a simple graph to point:
>>>>>>>
>>>>>>> +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
>>>>>>> |           |                                     |     0     | -------------> |     0     |
>>>>>>> |           | +-----------+                +-----------+
>>>>>>> |           |                                      |     1     | -------------> |     1     |
>>>>>>> |           | +-----------+                +-----------+
>>>>>>> |           |                                      |     2     | ----------------^ ^ ^ ^ ^ ^
>>>>>>> |           | +-----------+                      | | | | |
>>>>>>> |           |                                      |     3     | ------------------+ | | | |
>>>>>>> |           | +-----------+                        | | | |
>>>>>>> |           |                                      |     4     | --------------------+ | | |
>>>>>>> |    PMD    | +-----------+                          | | |
>>>>>>> |   level   |                                   |     5     | ----------------------+ | |
>>>>>>> |  mapping  | +-----------+                             | |
>>>>>>> |           |                                     |     6     | ------------------------+ |
>>>>>>> |           | +-----------+                              |
>>>>>>> |           |                                     |     7     | --------------------------+
>>>>>>> |           |                                    +-----------+
>>>>>>> |           |
>>>>>>> |           |
>>>>>>> |           |
>>>>>>> +-----------+
>>>>>>>
>>>>>>> If I understand correct, each 2-7 tail's page struct is freed, so if I just need map page 2-7, can we use vmap do
>>>>>>>
>>>>>>> something correctly?
>>>>>> The answer is you can. It is essential to distinguish between virtual
>>>>> Thanks for your reply, but I still can't understand it. For example, I need vmap a hugetlb HVO folio's
>>>>>
>>>>> 2-7 page:
>>>>>
>>>>> struct page **pages = kvmalloc(sizeof(*pages), 6, GFP_KENREL);
>>>>>
>>>>> for (i = 2; i < 8; ++i)
>>>>>
>>>>>     pages[i] = folio_page(folio, i);    //set 2-7 range page into pages,
>>>>>
>>>>> void *vaddr = vmap(pages, 6, 0, PAGE_KERNEL);
>>>>>
>>>>> For no HVO pages, this can work. If HVO enabled, do "pages[i] = folio_page(folio, i);" just
>>>>>
>>>>> got the head page? and how vmap can correctly map each page?
>>>> Why do you think folio_page(folio, i) (i ≠ 0) returns the head page?
>>>> Is it speculation or tested? Please base it on the actual situation
>>>> instead of indulging in wild thoughts.
>>> By the way, in case you truly struggle to comprehend the fundamental
>>> aspects of HVO, I would like to summarize for you the user-visible
>>> behaviors in comparison to the situation where HVO is disabled.
>>>
>>> HVO Status Tail Page Structures Head Page Structures
>>> Enabled Read-Only (RO) Read-Write (RW)
>>> Disabled Read-Write (RW) Read-Write (RW)
>>>
>>> The sole distinction between the two scenarios lies in whether the
>>> tail page structures are allowed to be written or not. Please refrain
>>> from getting bogged down in the details of the implementation of HVO.
>> Thanks, I do a test, an figure out that I'm totally misunderstand it.
>>
>> Even if HVO enabled, tail page struct freed and point to head, linear mapping still exist, so that any page_to_pfn,
>>
>> page_to_virt(also folio's version), if start from head page can compute each need page like folio_page, can still work:
>>
>> hvo head 0xfffff9de849d0000, pfn=0x127400, wish offset_pfn 0x1275f1, idx 497 is 0xfffff9de849d7c40, pfn=0x1275f1.
>>
>> When vmap, we no need to touch actually page's content, just turn to pfn, so, work well.
> You are able to read those tail page structures. The reason why vmap can
> function is not that it doesn't read those page structures. What I mean
> is that vmap will still work even if it does read the page structures,
> because those tail page structures do indeed exist.
>
>> BTW, even if we need to touch actually input page struct, it point to head page, I guess will effect nothing.
> Allow me to clarify this for you to ensure that we have a shared understanding.
> Those tail page structures (virtual addresses in the vmemmap area) are mapped
> to the same page frame (physical page) to which the head page structures (virtual
> addresses in the vmemmap area) are mapped. It is analogous to the shared-mapping
> mechanism in the user space.

Thank you for your answer.  I may understand it.

HVO do not release vmemmap page struct pointer array, just change it's va point to head page's.(vmemmap_remap_pte)

So:

1. any deal of page struct pointer still work, can get right pfn or something.

2. Any read of this va still work, we can get correct folio info, but can't change it.(PAGE_KERNEL_RO)

What I misunderstand ahead is vmemmap's page struct pointer also freed, what a fool. :(

Thanks,

Huan Yang

>
>> If anything still misunderstand, please corrent me. :)
>>
>> Muchun, thank you for your patience,
>>
>> Huan Yang
>>
>>> Thanks,
>>> Muchun.
>>>
>>>> Thanks,
>>>> Muchun.
>>>>
>>>>> Please correct me. :)
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Huan Yang
>>>>>
>>>>>> address (VA) and physical address (PA). The VAs of tail struct pages
>>>>>> aren't freed but remapped to the physical page mapped by the VA of the
>>>>>> head struct page (since contents of those tail physical pages are the
>>>>>> same). Thus, the freed pages are the physical pages mapped by original
>>>>>> tail struct pages, not their virtual addresses. Moreover, while it
>>>>>> is possible to read the virtual addresses of these tail struct pages,
>>>>>> any write operations are prohibited since it is within the realm of
>>>>>> acceptability that the kernel is expected to perform write operations
>>>>>> solely on the head struct page of a compound head and conduct read
>>>>>> operations only on the tail struct pages. BTW, folio infrastructure
>>>>>> is also based on this assumption.
>>>>>>
>>>>>> Thanks,
>>>>>> Muchun.
>>>>>>
>>>>>>> Or something I still misunderstand, please correct me.
>>>>>>>
>>>>>>> Thanks,
>>>>>>>
>>>>>>> Huan Yang
>>>>>>>
>>>>>>>> of the fundamentals of HVO, I kindly suggest a thorough review of the document
>>>>>>>> in [3].
>>>>>>>>
>>>>>>>> [2] https://lore.kernel.org/lkml/5229b24f-1984-4225-ae03-8b952de56e3b@vivo.com/#t
>>>>>>>> [3] Documentation/mm/vmemmap_dedup.rst
>>>>>>>>
>>>>>>>>> [1] https://lore.kernel.org/linux-mm/20250327092922.536-1-link@vivo.com/T/#m055b34978cf882fd44d2d08d929b50292d8502b4
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Muchun.
>
>

