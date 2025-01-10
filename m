Return-Path: <linux-kselftest+bounces-24222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C050A09725
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 17:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 842603A1674
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 16:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9F7212FA4;
	Fri, 10 Jan 2025 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="J7TNS8SC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021104.outbound.protection.outlook.com [40.107.192.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704BD212F9B;
	Fri, 10 Jan 2025 16:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736526142; cv=fail; b=p/MZMdwnDdD5SykVgpC+1Q90n154OY4Ad7ODQ2ib0CslHklKXZ4abSVFrkEJurvebfB5F7iZJ16g8AXPjzwTWcl1L4LndBH4ALW46ZtyFuNeBp3CZlftlHX7QLTjbp2b0c7zN+yHBCJLqoX/PXMTxgms8WIChiwRd3upFHoM45E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736526142; c=relaxed/simple;
	bh=wQ7OTz2xg87TseDrKmaRNeks91jpk8A+5AvB2u0A2U0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QPp4rn88pc4vO6GOyKt5tR0NPuI/MVNAZfLvVNVChtz5I1LAn850BnTOwsjtlGxttNMSDYYOCniXsf88b9/7OjvSN5/T4i4G7qSVV8exzhyDK2E7Aed/2ddeqd8EHisyehL+SUW8hNQQX9nTfDuU9lswJVY3e85U9RfCBqy7d98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=J7TNS8SC; arc=fail smtp.client-ip=40.107.192.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rj/922Am6slUimaxzNe4AqmpFvLdAXs1lE2xdbZjzxLMjrSUq3AYxrC/S+1pu/Tu5EjkvkPJ7TKFoHLmiumYYm9ucqomriB5MrIEoVt3O45EmfmiiOTjiwmM9aoInPhdngJW+MLSY+rT8eYlCJneTftfVAmf/hKl5XJIts0LeXaoItPyI1WnbJvBDlKzBZXESmuO+gZkH0FA9mZ7sa61RtQ72CW0FQVZKi0+5goAK7LaKOzA1q9gr9w2zAqgAOeI1k/4Bg6HIQE27e8xOI07/6CQ8TrzBwax29J/TW8AL669BgRus/tVM62YgNicbMHNRKxS89mupyyS8W4Xzn56TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y68KN96gz4kdhNMOVKfmABiZjpirH3g5dowwjTJve5w=;
 b=t+Kgu9aPJ18TUSe2eGA3QPN3L/02eCA1cChq+HC9vIkyVpjmZZY5JfCqfVJinxqPdsbRDk/2fDTl2diY+S3Nz+lLdWic/GXCSpMJukke5HKJuJzUVMRS/ExblCZunATA81QoM8LEeZJ3Pm+43RUgPkqlyLQKSTGscfPxdN4KkbhcwFBHi9h0g6ZC3M2xNJWc+Hi75t3neqyoCyb76coemAz4Yy0/74KF+rTS4TWZMnWYyqiDoaPmQ3APHSxSGvhfEs6Xdd8bwUTSnPBwBCUQCmHFq8ElxO1RwkF+367I6Sl6wpOgfuPbsBlRYySbs6JKPveeddFsQckRnzvf5iESnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y68KN96gz4kdhNMOVKfmABiZjpirH3g5dowwjTJve5w=;
 b=J7TNS8SCICghsx0MAlG67RqGaiFt3semDNJLJgCLbDJmmcvRcDGtpwbOaC0fNsXFQcbwiemPSrsjTkPbXMk7WYVRNLPw6oToGZ5R7XbhFZ5tzdQJYbJoUOmloQBOzeEqEyFp34kVWluFIjZ5NEnsZMFcGwSSW+mBEBuCnsRUqaoq7tj8BT0ZxMpC43aPtc4Py2tQcwId+mPi1VVOoXG5PCD+e8dweGsJeyy4kTaXMD+//xwRv34DigtWkSxj7anc9UH7dpcPtqKc+PgK5r25zt2YYi8Cu37ID+tSEzXGuc29laDakaDJFdR5V1IVJZQIsVXkIqAtAJ0wCeZsOiYhrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB8611.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:78::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 16:22:18 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 16:22:18 +0000
Message-ID: <44f202e8-dc35-40aa-8dc3-2f2e4c28feda@efficios.com>
Date: Fri, 10 Jan 2025 11:22:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rseq/selftests: Fix riscv rseq_offset_deref_addv inline
 asm
To: Stafford Horne <shorne@gmail.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20250103040326.2603734-1-shorne@gmail.com>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20250103040326.2603734-1-shorne@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::12) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB8611:EE_
X-MS-Office365-Filtering-Correlation-Id: ff9f796d-5227-45ff-d795-08dd3192f3cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REYzMm1TRm4zT3VVQ1F1Q09jdWlGUlU4blNFRERNU0NmSzA4OHB4MU94T2RB?=
 =?utf-8?B?RURGTXQ1dWU3d2lCRUZoNUkxVEdUd1VnWitpUHNpbExqemRqRVNUVCtKeWxp?=
 =?utf-8?B?VkpuNmJkMUZ2RDgxalBzRml6b2JtYkRkZWJaLzBjZEQ3aXY3SHNsYVQ5cFZC?=
 =?utf-8?B?YXBBaGZ6UXNGWXhLWVVVME01REtnems4azBLa0J4elEwb1Y0NXlzcmxGT0ox?=
 =?utf-8?B?cG12ajI1RDk5c0pBdDNxNnAwY2JlbEZQbkROaWQxUTdWdWJRWVljQStXNFNB?=
 =?utf-8?B?WXdmMVdld3M1eGtEL1VIbDVNNFpQWnovWUlzallpakNVaitGUE1NMGE5c0tm?=
 =?utf-8?B?QWZyNWE0bDZ6ajJOdS82dWJiYlF5YkZ3bjN5d3ppTTg5emo0SG9VRGNlWkhl?=
 =?utf-8?B?UTk4ZExuSlI3S3JMOXQxbEJIaFFqZHpzR2RBdGc2MXhwN202YjEvRkN3T3Vi?=
 =?utf-8?B?ZFFlbHJQUTYxWHUyQmZVUHA3THNnV0hOeW5lQmgyY09CV2plSWVKeldMNUMv?=
 =?utf-8?B?cVRYRzNHeVkraGVjbXZPZGt6emtsVWUrcDVlQlhUN3RGQmNPQTI3bzRuY3dU?=
 =?utf-8?B?WmZ6U3dSODN6bE1RNFpPN3VUNGVPWE41Z2hoVTlWY3BZYm1HbTNtTEoyakt3?=
 =?utf-8?B?dk1QM1VsZVZ2N21aTnBxTGp3THZtMUIvTXRHVDRyYjlrbm8rU3dZVndRbCtO?=
 =?utf-8?B?RXJNbkpLK1dVK1g2VUZIWDZwSFp1a3IxVTNZRXVvVHNhZXNyeWxHSmUvYTVs?=
 =?utf-8?B?amtxckdrQktJOXo4LzBEcHplNjRhcS8xbHkrTEtTbFlCS1l2Lzk0aFRiK0NT?=
 =?utf-8?B?NjhNMkZ5UG0xdlRjU1ZEQy9BdGZ0aVB3R3lPd0dUbThXZTNOeWU0c1lnbFdm?=
 =?utf-8?B?eFZod3NZdkg3R0w5Q1IrMndTc3NONFc5bnlXYjNDVDlZVmVHK2YveHBFTWpI?=
 =?utf-8?B?UHVQQmdWaStxTVYybmxBQk5OODlvcEpuRjZ3ZkJvTklobHpCRHhPNGxlSy9Y?=
 =?utf-8?B?aStDRG4xaFN4Y0p1YVVRM0d2NGdIT0Zua3o5ekhWVDBvTms2b3ZISThnamRk?=
 =?utf-8?B?ZElXdmpOVmxhWDBGNWJlRFJxQnA3ZzJyKzJobEUxUmduNTFRL28xYXphbjZ1?=
 =?utf-8?B?Rm5CSjhSbHZ6VFg1eDVjS3pFYVVWU200U0JXczQrUHFIMXloZTBYaGdJaGMx?=
 =?utf-8?B?NzcxQXZ6eGh2Zi9SVnB5MWwzZDNMbjJTQXovRzFnNDNDWUtnVjRmYWNrMGtw?=
 =?utf-8?B?WFBNb3BQSGFkcW9nZkEwcGFoV0FJN2lTQ3NPa3F4cnJHU3ZYWnJCYkM4cXVn?=
 =?utf-8?B?SnVqQVFMTTQ0NFZxTEErRlNBWFlVbGhxdVhYeGVQSDgxTHc3aGtTbTA2dkNZ?=
 =?utf-8?B?V0R2bTJhS1hWN1FjWEduUVp0aTZLUnhGYWlpazRBb0hIL0xlNC9HK0tvYkds?=
 =?utf-8?B?YmROd1RjM2RwUjJPTG1QY1hjSTlhYmVlTStZY3J1U2Y5SVBHbVhmdVNhWkdr?=
 =?utf-8?B?SlZJNkdxaWs5TXhUVGNaMEFCaUIvaVJMTExrNCtYQlFPbzVwRnphSE1SV2sv?=
 =?utf-8?B?Q2pjQ2xiYmN2ckQ4Y2tPYWZVVllDMnEzUjh3ekRydWRBQW1FRE1wQkY4RWky?=
 =?utf-8?B?RzBHUGFSUmgvKzcrcndBN0x3Z0RnZFZGNFFHUlVVRDVMMHpYR3FOWHU5QUtv?=
 =?utf-8?B?OFhnQ0FVMWx4SS9SelRhSWFud2Yra3I3U0RqaFhRZGlKN2lnbzRaQWViVzln?=
 =?utf-8?Q?BAYTVSdWUclh4HdntaCdLQZYl0WJ8IbvrtTolyx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzRycldlKy9OcXJHejVJb2VJQWVTbXNsWHFaZ09tc1V6QUxVUCtvY2tadXdh?=
 =?utf-8?B?cldDdEJ5SXdtUmpNY1d2L1BKdHM5R2k5U1ZsbEREd1M2SGFJb0tvdU5abWdJ?=
 =?utf-8?B?SWM0VHRndUl5TGR2RG9tUGtrWW1zeHQyeFV3bkRwVXh3S3VNWkZNbWE2QVZp?=
 =?utf-8?B?NG53TjduSW5NeW1NWER4djE4NkZMbDdSUkdINW9HWkVraXRuWEcvNk9QaEFG?=
 =?utf-8?B?cDgrYi9tOXdERElnWVBoSjBMZWhyL2g2UnV2SnFqb1F0bHdmSDVEUXZXcW1L?=
 =?utf-8?B?SFIzL0JTSjhGMU13RkNlOFkweHZVS2RyeFhkODFiOHQ4YXF6MFdZYVIvZHhw?=
 =?utf-8?B?bndmQU9kcWphWW1hSlNHUTc1VUw0RW5tRmhNcHVXc0FhZFFSaEZlV01sME1W?=
 =?utf-8?B?OWs5amo2dUlpL3hXazdvVEM2NDY0SWRhaXU4eC82WGJQZHhwQUxtSDhOcUNi?=
 =?utf-8?B?MGdIdWJ4c1k0SWdWS1h2V3p4aVRoTVlrMDRPUk85cFN0UWFrMjVxaHFrZjJt?=
 =?utf-8?B?bEtSYmU3S3BwUklpZGZVYkVaNStVdnpPTGhGSE1JcE1QdDFPTTRuSDFoK1ky?=
 =?utf-8?B?VnY5UGNCcGJ4MlRWVHhzWFpWeWZTMGpxbWVHU2pSdW9Uem04bC9FcGVVdjRN?=
 =?utf-8?B?N1hMUXNiZmtFL2V1dHIyVDNJeWNzRUFieW11bTRWWG50SDJITGNnTmpPS0to?=
 =?utf-8?B?c3VhUnRySjFodVNRKzB0NUtjWFEwNmNKam1vdktFRjFCVndWTkJOU1VjaFlX?=
 =?utf-8?B?VUkwNmh1T2lTSmxXNTdodmRzWWJYelhFMnhXVFUwTVRKREJOTHp2UFhXSUtw?=
 =?utf-8?B?eGRBNVluQk1vbVBrTjVkUGVlQTh6V3AreWl6VSs1UE1xVlB4Mm94Y2F0elYv?=
 =?utf-8?B?L2FFVFYyUnF3cXp3UU5scVNWR1VuNmZqaVJ0cmZPN3c5Y0doU2huRGZPWlcx?=
 =?utf-8?B?bk1ja1hQWUhzVzJENXRDdEMvQkg1R3R1d0VQenFldEtVU0dlTXZheHhSMlMx?=
 =?utf-8?B?clVpcjVlSndZMmVvNDBCeXNpcWhNcFFtRUdPS3FjV0FVR3o2N3NqdzdpUDFx?=
 =?utf-8?B?aVNmMjNMUiszVmRXRDFiM2hKcXdxKzczWSsrYXlyM1NnS2RWRkNxYTUwMnRG?=
 =?utf-8?B?Syt3UlZsanBjOVI5b1lEUDRGQVExdkFsMlN2T1B2NWFjZFdxUHZ3V1IvR3Np?=
 =?utf-8?B?ZlhvVzdUaFhmQy9mTzFZbm9RVVNDMlIwMTZoZkZxL2FLMFVRcXlJR0x4T2gv?=
 =?utf-8?B?TzJBNkdMdGRTRzhDRXQxU3QzQ2JQQUY4NmdXNnd3ZEVsM1h4cWNMMmdKM0RX?=
 =?utf-8?B?YVNad1Y2bmhZalpmVnJBUXQ0SjR0QkJpNUs3Qm01bWxaMVVqdDBoRmtSckZS?=
 =?utf-8?B?RW5OaHQ1MndUY1VxUlpKQnJLTnp2dlNNZkNYWTVJQlJLNmpBM2xNc3M5NURq?=
 =?utf-8?B?bkVySCtGYWFJZ2d3SGx3L2ozYjRKRkxDRHRsRVRUSUN2Z2Jxa0VhVThQY1Qv?=
 =?utf-8?B?ZlFGWno4cTJndnZKZHBIY0Z3dG5HS3VBeFAvbVEyZi80TEgwTEpaT3diUGJo?=
 =?utf-8?B?SGswK3ZmODM2RFA3UEdQMzNRSDFSdTlVY3FNbC83eXVJZllla1NjWjFlRDJ4?=
 =?utf-8?B?TDVBZStldjIvSW9ueFU2c0I0c3FjL01sYS9vN1N5NGpvRnRYUW8rVHA5bDBx?=
 =?utf-8?B?MkpSVlpadWp0TFhSUm00Y1V6ZHg1ZjBGangzc1BFWkpYcnNYQU5PeGVvNzBq?=
 =?utf-8?B?YnJZSmE1Rjd0ZFBXcDVQNElhSkNGcDZ6U1I4eFVUbkhJMjdRNlVzRFpwdXk5?=
 =?utf-8?B?ZWhDQU0vZWp1dndrK2JWZmdZVnlwYmkrNWg2ZlhlVFJIRHVJNUJVWmJpYkIr?=
 =?utf-8?B?SW1NNGg3c285a0ZrQUd0WXB5ckxlQjVoeGttTUNRVzdwWGdXdFA3Q25FS05r?=
 =?utf-8?B?ZHh0eUZyRjhtOHVIK2ZZdlU3dU5yRmFlTGxrc3FaNERJWCt0dSsyVStaOG9J?=
 =?utf-8?B?VGZvMlBNYUYzNC9GRUF1QjRWMmd3b3BEWFU5RXlsb3JnbzEzYXh3d0I4S0p4?=
 =?utf-8?B?RDhvNmIvNTVTWGhxQUQrcGtxQXhHSmliUDI1WTFWU0FOUnBtNGJOYXRTQmxO?=
 =?utf-8?B?T3FjSzVFVWx3RjlocjM0ZDJxUHMxRXJPQkhlcmZUd0FVTnZzL0p5WHF1ck9v?=
 =?utf-8?Q?rwZUT7ecXfq0hlcJaRMkTLw=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff9f796d-5227-45ff-d795-08dd3192f3cb
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 16:22:18.2623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1cp1B/O5OWYkuC1qfAV3zcasojNkOKy6ANPklwuUKh0omVTJRuFN7Tt4gaD39ZZVox/0ypAScyuH9TxGIdO+iVtAWDc+kMs5B8vjptmm2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8611

On 2025-01-02 23:03, Stafford Horne wrote:
> When working on OpenRISC support for restartable sequences I noticed
> and fixed these two issues with the riscv support bits.
> 
>   1 The 'inc' argument to RSEQ_ASM_OP_R_DEREF_ADDV was being implicitly
>     passed to the macro.  Fix this by adding 'inc' to the list of macro
>     arguments.
>   2 The inline asm input constraints for 'inc' and 'off' use "er",  The
>     riscv gcc port does not have an "e" constraint, this looks to be
>     copied from the x86 port.  Fix this by just using an "r" constraint.
> 
> I have compile tested this only for riscv.  However, the same fixes I
> use in the OpenRISC rseq selftests and everything passes with no issues.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> ---
>   tools/testing/selftests/rseq/rseq-riscv-bits.h | 6 +++---
>   tools/testing/selftests/rseq/rseq-riscv.h      | 2 +-
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/rseq/rseq-riscv-bits.h b/tools/testing/selftests/rseq/rseq-riscv-bits.h
> index de31a0143139..f02f411d550d 100644
> --- a/tools/testing/selftests/rseq/rseq-riscv-bits.h
> +++ b/tools/testing/selftests/rseq/rseq-riscv-bits.h
> @@ -243,7 +243,7 @@ int RSEQ_TEMPLATE_IDENTIFIER(rseq_offset_deref_addv)(intptr_t *ptr, off_t off, i
>   #ifdef RSEQ_COMPARE_TWICE
>   				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
>   #endif
> -				  RSEQ_ASM_OP_R_DEREF_ADDV(ptr, off, 3)
> +				  RSEQ_ASM_OP_R_DEREF_ADDV(ptr, off, inc, 3)
>   				  RSEQ_INJECT_ASM(4)
>   				  RSEQ_ASM_DEFINE_ABORT(4, abort)
>   				  : /* gcc asm goto does not allow outputs */
> @@ -251,8 +251,8 @@ int RSEQ_TEMPLATE_IDENTIFIER(rseq_offset_deref_addv)(intptr_t *ptr, off_t off, i
>   				    [current_cpu_id]		"m" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
>   				    [rseq_cs]			"m" (rseq_get_abi()->rseq_cs.arch.ptr),
>   				    [ptr]			"r" (ptr),
> -				    [off]			"er" (off),
> -				    [inc]			"er" (inc)
> +				    [off]			"r" (off),
> +				    [inc]			"r" (inc)
>   				    RSEQ_INJECT_INPUT
>   				  : "memory", RSEQ_ASM_TMP_REG_1
>   				    RSEQ_INJECT_CLOBBER
> diff --git a/tools/testing/selftests/rseq/rseq-riscv.h b/tools/testing/selftests/rseq/rseq-riscv.h
> index 37e598d0a365..67d544aaa9a3 100644
> --- a/tools/testing/selftests/rseq/rseq-riscv.h
> +++ b/tools/testing/selftests/rseq/rseq-riscv.h
> @@ -158,7 +158,7 @@ do {									\
>   	"bnez	" RSEQ_ASM_TMP_REG_1 ", 222b\n"				\
>   	"333:\n"
>   
> -#define RSEQ_ASM_OP_R_DEREF_ADDV(ptr, off, post_commit_label)		\
> +#define RSEQ_ASM_OP_R_DEREF_ADDV(ptr, off, inc, post_commit_label)	\
>   	"mv	" RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(ptr) "]\n"	\
>   	RSEQ_ASM_OP_R_ADD(off)						\
>   	REG_L	  RSEQ_ASM_TMP_REG_1 ", 0(" RSEQ_ASM_TMP_REG_1 ")\n"	\

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


