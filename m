Return-Path: <linux-kselftest+bounces-24447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A48BAA1089B
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 15:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DCF91884AA4
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 14:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C07149C4D;
	Tue, 14 Jan 2025 14:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="A4y1RP1Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020130.outbound.protection.outlook.com [52.101.189.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6B7148FE4;
	Tue, 14 Jan 2025 14:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736863647; cv=fail; b=Fbu4Ss7bzqU4MHKOOk3C5IgJBB5Nj7ryAPn1asGN5KkTVhfuYp8hJ/sYIrefxeXar0LUmB3xqW92mYh5CS4vFIfQLrgKVuwb36uXXbIk4QqZxoNkyg2XtyN0Tw3Jjn8wD/MkmI7CBcuz3Kr3Pi+Qv7pv0Fuxz7oS6IxRQyz+QCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736863647; c=relaxed/simple;
	bh=VNZbXEoJ+u3CKMJrySOsIYH83GVEyeUhE1tAq59bnS8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hf5K5DQXX2qfo/1uOpiS5RNJkVDk2s64KpYQhe6FR8cY3wieWKM1IIgEpK5FVNuHcav7lk9l8Sk4G1EQqTGIgohcvKgYrEE+OL5zrVPuc8rnhpA22hqI7FbAbNiUHkg0KdAVTlPAxu/Rcnwquaw8PrehOPMZNancQCarWSyiYB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=A4y1RP1Z; arc=fail smtp.client-ip=52.101.189.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CkLpdZaEYFwwbZNNNC7Iz7FMUbtake9c8rLjlZ75ZtHYF5npv0xb3otR88Mc7wPqFEq+mTYk15mQHKM42EQI9KCyx+VWD0e3lKa7ORR1iX/cR0lqDQHoiyaQRUzAo3nDy/++0IehAU1UADkTDCaJ8H5l58HEKiU/GRUxpNDJLj2Fpf8m8JxXo7uIrIW82a3lNXn+np9ujIttMalMMBeIaAul2FOb66UB5xYyMrbcPCUWpiNubrKDhmoE71cdisWKRNENUkBW6Nf205h6a5O2zPO7SzUKKLVe2me7mVf1f3isnHDI498UJMi18u8D065hBaql1BK8L9MLbo/pVNd8/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycODzSQ5BL+CKXmaAgEz94QJuyFswoZJoo70zS3RKz4=;
 b=jHx/K/1Me5Z2xATVhWQ+rTnyPAXUt6bVFEJB+ztYcgSQ/RSCq8y0qZyJsVWLdWZXzuyvcjAgM7fCZtyb3TzbEo8T9fMUAVZZ2CgBgyqkUYX46Zkrwbq3muKSOz71gOBFnDNPX/+2Jdl7qDmjv+28vBEOZwOfdnWNZxXjmmtdD4Yg+JzEdqhwVl4a/MFm7LEJrpP4hzmDlPLX60kecnXYySiFmVUbealzM3a5DKWbvLn2eu35Yom8fFCslHzlS68QdvaHVPRzCVI0TJ80XGTPe3hy66S3FAglj5JSs2mJG+FlvM9P6tcWki4i0qk8UNR+qIiygS6GTXxG6s8ugqs/yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycODzSQ5BL+CKXmaAgEz94QJuyFswoZJoo70zS3RKz4=;
 b=A4y1RP1Zdvs7wRxKZ4LZXHIN1WnsplDg8GzEt8gaOe+w5YVBo1zK7ccVGpEHHGxx9SQshhqjlh7Xm0rz9ZbovrBP0w+ri2b4D2Cgcm5b00ztbTeFog/kA+UX/E6yUCzKDMRtUMf1pDbLbH4roRdRsX24cA4pEKqRQHdsbpSct+ZTEhEqEbqvGRdRu14Bn4nPWlPnhPB3FwG9TxIb11+YBawy2zro1Xkefx3wQHXigmbqTR/ZOEfQkq8+xd8IqJuLKjymNjUU0SwCnhDIMsS7sIO9ZVvevleJivAXcRdl4fK2TrRPnz1NMVf2KTLkpOw1bQE7/EPOgIYBrKh+BCwZ4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB5387.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:52::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Tue, 14 Jan
 2025 14:07:22 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8356.010; Tue, 14 Jan 2025
 14:07:22 +0000
Message-ID: <291b5c9a-af51-4b7a-91de-8408a33f8390@efficios.com>
Date: Tue, 14 Jan 2025 09:07:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/rseq: Fix rseq for cases without glibc support
To: Shuah Khan <skhan@linuxfoundation.org>,
 Raghavendra Rao Ananta <rananta@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org
References: <20241210224435.15206-1-rananta@google.com>
 <15339541-8912-4a1f-b5ca-26dd825dfb88@linuxfoundation.org>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <15339541-8912-4a1f-b5ca-26dd825dfb88@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0108.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::11) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB5387:EE_
X-MS-Office365-Filtering-Correlation-Id: 77dd5421-7307-4682-ac07-08dd34a4c3df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZThsYllMMTFrR1lUMEpkWHdlSEkySFVGcWZ5RFpKVXc0SXRrL2o2QnZROUZl?=
 =?utf-8?B?N0FRUE5FYm9CRnJEcGgrTHgvUXVFTGttV1BzTXdTN2VmV2cwc2lEZi9rYXE1?=
 =?utf-8?B?NzB1RW5lRjhlRXk1U3NCRTN2NjN2SERXdkxGZHF0N21MYzZ5QWlYN2c5VEJy?=
 =?utf-8?B?eWhYem80SWxhT3p4cThhZjZ6SlVkTlVuNklyUUNNYVJIMlYxMllYeTNoNU03?=
 =?utf-8?B?cmdDY1lHQmczb1diM1pHbyttMHFBRWZvZHZ5QVVreWlWdDFCQ2IrbDNsNjl6?=
 =?utf-8?B?NnJQUmFGeXRtOSsxd1QySmw5WjZuMEdraDFYaUpMVnV1bEo4VVFWckVLL3R3?=
 =?utf-8?B?S0pLNEYrS0s4Zjlzekc4TjFnZUpEY0l6Z0VxVXlTSEY4UHhWcWVoYUw3UHo1?=
 =?utf-8?B?YzRiQ3Y2MmJlRmgwUi9NVzlxYlh0RFNEZjNtcmN0cjFaeTU3QnRkcCtpbCtq?=
 =?utf-8?B?OURxT0Iybkd1RGlqcmZJOGhFNjhaUWZCamdMVUZ3cEtqUlJSUStXSGc0UjMy?=
 =?utf-8?B?bkpyQ09Lek90dFlrcVJnSnp6MzcyQVhlVVhzUklGZnVmRU1PMVEzSUVkcG1v?=
 =?utf-8?B?VGdyTnphYjMyb3h2WFJETmozZjFuUUloQ1FKWlFYU05rUlJreHIrcFpSVjY3?=
 =?utf-8?B?aFZJTFRCMGtocStIZUJwQmlrZWFXZVJhMnFNRkJ3NjdLL2lOQTA2OThrbkFF?=
 =?utf-8?B?c2ZHMDdMTnBDeE0vbGhDV1NSellBV1ZFWFBZZWYzczlxTUlSbThOVnJCWTBI?=
 =?utf-8?B?cXYxQUFZajIxTlZ2eFYzWUp1UTlldDROSzlrU2xwUjcxUXF4WXNYenRTTWlV?=
 =?utf-8?B?a0FVYS9GUzVOcmtWY1R6a2hDdDVJdEh1K0JTcTEyc29aMzRsbUtFSW0veGJn?=
 =?utf-8?B?NUkrTEdjQzZuaUZ2L2xIVUxWeGtkZElhU25xNXdXUDlNMkF3V3h5K1h3R1ZL?=
 =?utf-8?B?SlJDRU9scWgxQW1GRjgrMURBYUovMFBHdVBsUjlxOEN6OVVxQTNoVGs0TlBR?=
 =?utf-8?B?NFFKdytVaVNOcm1iUlBTenFUVHc2WDZ4WmIzeFZVdjhPV3A5VWZ6Z0F0TEJm?=
 =?utf-8?B?NTQ0N3Bma1d1MFFWYmpMTTJubWs0UFo0NHF6ZGFHSXVnMlg4MFkrdUc5YUdj?=
 =?utf-8?B?Q1F1dWtIcnZhQkFIV0FPQmZkS3pLK0pTeVpIaitHemVEUVZmTmhRMUFqaDdL?=
 =?utf-8?B?eHR5QUJXbWxBMlRka0NpUU1PYmsxTmlhbmgzVVNWMGhud25PWm5hM1J1czR6?=
 =?utf-8?B?MG1oTjJQMVZhWXBPTDFhR3IwSnJmdG9Od3RDZTlYSVUxQ2JvQWt1NkdhV2Fk?=
 =?utf-8?B?UGp0VFkrOTI0eVBrZ3E4ZzZxNlpyeFI1OThBT3pMa0lSNVUzN3RRMGoyWWU4?=
 =?utf-8?B?MTVPN2hEcGNyUGYzZ2pZU0ZHelNEeFl1SU9DT0tqTy9XdnFYR21CdkdkSTVy?=
 =?utf-8?B?MS95Tm5HN1J5UXhJYUVaTjRlaG9xeTIrRkQvK21CdWNwWU1jRlpOaVBQdlpZ?=
 =?utf-8?B?VGY0T2NTaTFNT09PZlEwdmZvOTZaRGNBaVJPVVlZdFFUcm9YbUVDV2lrRHdB?=
 =?utf-8?B?Ui9XQUdacXNnQlhtd0JWd2hjWWw4cFRqNFNwRE1VMU1CcCt0K3FRb003Q09i?=
 =?utf-8?B?eHNMbE0wOWJKaFdPZVhXZ21xbms0WTgvUDdmT3NOVVZxRmJkc1pjN2JhUThk?=
 =?utf-8?B?ZGFlNmtvY0dpQTZmVXhyTnlyUkVkdzRBMHNqYzVuekNsZzViR2lMQitFZ0py?=
 =?utf-8?Q?fNlIAwUnQil20SZNqkyWuxaUQ9vP4DlcyzmL9r1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3JDaW5TcFNOOU1YTlpDelYyaTk2Q0VCdUp4RWd6WUlJWkR1QVRTbWNlOHk2?=
 =?utf-8?B?MEorQUdhS1krSEZYWFE1aG1iUzZUZlRIMnhKT0Z5cFRvL0d3bUhlci9JNzh2?=
 =?utf-8?B?SWpSaFF1YU42blV2MjhwaTI1bUxXK0gzdE1pbzlkcGdRZStMWGRFSTh6WUpo?=
 =?utf-8?B?dGFBWkgrb2ZLTVE2V0FyVGtycU9EL1JZckNSbkFyaHVMNWVyMkVWY3cxLzQ1?=
 =?utf-8?B?ZHcwbnlNcnR2NzNnSzdZTkYzYnp3aUlpd3d5SVhtTGVKbTVJK3F6NVBHMVlP?=
 =?utf-8?B?ZG9UaVNHMjlmdlQzQU5YY3QrMzk3YlcyZVBoYzRGd1dWSDJOZVlKWjQ2K2My?=
 =?utf-8?B?eDdxR3FTQlVWSEYyc3hEVHloRUJHb1lOR0gwZlRoZkl2SUhYLzRJRGM5R2J3?=
 =?utf-8?B?dWtkWlJsWVJ0UExsbTZMb2FQK0FKc1BTK05jL3BteGhxZG9hSFdyWG1leUVV?=
 =?utf-8?B?QkcxSmhEd3hsaW5KVXdIaFM2YzlIMUtkUzJvRFg2aHovQmNURVNCT2crWTNV?=
 =?utf-8?B?TVZNa3RGOTZmRFBEQmJuVHJ6elVYc3JoWnd4R1RTRkg5djdOc09DcW41NnJz?=
 =?utf-8?B?Tkhpc09RYi93ZjFGbEMvWHhCWEg4NEhlcU9Va1R0ZUdMWmFsZEZ5Z0c2TEJx?=
 =?utf-8?B?ZEswWHBzYWEzRDh4b2tOcG0yZEQ3MGpqNUNHRG9Gd0ZTRXN5a3JzWDg3REpT?=
 =?utf-8?B?UXMrem5pYWV3QjB6Um5jZkZLa3pjUWwwM1ZwbmdtVG1aMFYwRWhzc0RvYWxP?=
 =?utf-8?B?UlQ3R0xZd0VJVXgyS0tzK3lnU252VG9pZTIwYlNhZnlPeFhDVFB6MjY1RDYv?=
 =?utf-8?B?RjJiaE9MVUhFd3phUDhtM3dRd1VFWjNSc3pRR1hPcXNSUUJUMjVsSzdIanN4?=
 =?utf-8?B?b1lDRHQ5UTZmbDZ5WmJ1ZE9wb1ZpVmZxdUpQYmNha3FVREVSSnczd0pNUm9Q?=
 =?utf-8?B?dFNUME9wWTh2ZEErMk83SXdwV3Rid0VPMUtyT1VRbWtIV3BXdlRXWFpwUFJP?=
 =?utf-8?B?VmdWM0pIcGdyU292c1RmcjI5Z1FZTkt5N1lYNWYrV1JoR0lLOUd2RzcrWXlW?=
 =?utf-8?B?cUJEUmx0WUp6L1Y5MnBRUDRvMUhoYzhBa0RoYkxzS0w5dVcyblZ3TkJYS1dZ?=
 =?utf-8?B?ZVVxTXgvQlhFVDl3WS9ZQzdkU1hISmZEU2lMVU5YNmhYYWhKOWpKM0xTbVd1?=
 =?utf-8?B?cU5WOGdEV0s4SDEwTkdBUVkveFArNVBXaVQyNmMwcTdJZmxVWGpZMHZmNEpw?=
 =?utf-8?B?QStoYXpyMVZPNnB4RFpnTjBwVkRwSVo5QjVCZWc5L1RNMjlWMVlNckxUeDRS?=
 =?utf-8?B?SFR6VHlXak9vR05pM1pmR3FyTDVlaGJPaUdESWRCb2s5Um8zSGdrSHZXTmJL?=
 =?utf-8?B?bU1Nd2hISUJYMWM5MkVyM3N4YUE0bEQyVG5RRkd3VldmWHJ4R1J6d1VnME9y?=
 =?utf-8?B?RWMzTXo0cHNlNXh1YTNwMDdEN2V4Z2V5ME54ajE5YU03MUpCQmNISUxyZ1lD?=
 =?utf-8?B?Sm5mdHZXRk1wUnhaNzZkZGxpKzBwRzgwUHZqRFZtaERldzE4V0VoQmMzZTRh?=
 =?utf-8?B?L0VGbHN2VGg1MzMzYS95ZzN6QlFvYk5kNDBKRHNQZFh6Uy9jcjhiRGtiL1BQ?=
 =?utf-8?B?emZhNkJ1eDZOdkgzVUMvcmxMVzRsL05zMWhYY25VMSs1ZTZ3dzRES1FMM0Rt?=
 =?utf-8?B?YXFjU2hReHp6VCtGcXdLSWdRb1lsSHZNd09ZWEhHa0F6ZDFQQVY0b0Z6cDBG?=
 =?utf-8?B?dmZVaTVuNFpVZXY0V3EyRHRSWklzbkJPQzVzMEk4NmU3MGowTFdCSUNVbmZ3?=
 =?utf-8?B?MExpYUFBZHVDalNrWjFySFRxSVNJSzA3YWtIcElWdXN6SW9hWDI0Zjk5bWhE?=
 =?utf-8?B?Tm5CaHZPNEV4a283VVk1SXN2SlVSL3pZakc1ZkpMaTBEaTg3bXkrUThteWhL?=
 =?utf-8?B?eHphUmcvLzUvRFNwbC9XUmJpcFVGOVhFcTBBT2E4dDF2MUtwUDYyR0ZtWHVM?=
 =?utf-8?B?aGt2TFhiSkp6VFRyQlA0WWNKeENOOS9HVjI1cjU1anNmMFJ5N01WWGtUU3dB?=
 =?utf-8?B?VG4zbE84OS9XMmloTkhJb0NDYXlXd3NLWTlLQ2FJNXlIZ1Bmb3BCY3dxRFR2?=
 =?utf-8?B?eFQ5SWxDNlZ0R0VpaEYzZElnUktETWNocG51UkJXTkJUd1hkdGMvVytId1ZV?=
 =?utf-8?Q?O4wgM6u3pdYr6tL7y7BpcpM=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77dd5421-7307-4682-ac07-08dd34a4c3df
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 14:07:22.3473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WMb2d4vIQOrfXre108Hx6UGKj/CQ1t7+12I0bdFvFXl45JYd+LfMVYUutwJCAFf9wiMZ6221oAxB5b7kIhA+l9nGduhZnhFE7Fcre+EyWhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB5387

On 2025-01-13 18:06, Shuah Khan wrote:
> On 12/10/24 15:44, Raghavendra Rao Ananta wrote:
>> Currently the rseq constructor, rseq_init(), assumes that glibc always
>> has the support for rseq symbols (__rseq_size for instance). However,
>> glibc supports rseq from version 2.35 onwards. As a result, for the
>> systems that run glibc less than 2.35, the global rseq_size remains
>> initialized to -1U. When a thread then tries to register for rseq,
>> get_rseq_min_alloc_size() would end up returning -1U, which is
>> incorrect. Hence, initialize rseq_size for the cases where glibc doesn't
>> have the support for rseq symbols.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 73a4f5a704a2 ("selftests/rseq: Fix mm_cid test failure")
>> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
>> ---
> 
> Applied to linux_kselftest next for Linux 6.14-rc1 after fixing the
> commit if for Fixes tag

Hi Shuah,

I did not review nor ack this patch. I need to review it carefully
to make sure it does not break anything else moving forward.

Please wait before merging.

Thanks,

Mathieu

> 
> thanks,
> -- Shuah

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


