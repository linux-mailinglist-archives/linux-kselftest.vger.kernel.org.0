Return-Path: <linux-kselftest+bounces-24541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08570A1162F
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 01:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF563A1FDE
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 00:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2286017BD9;
	Wed, 15 Jan 2025 00:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="oS1ZDtys"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020137.outbound.protection.outlook.com [52.101.191.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1F95223;
	Wed, 15 Jan 2025 00:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736901972; cv=fail; b=GB390I8dRSRjNVl8bYQMzxd12LSiSKxfgCRVa+dt39n47jghMgHXMvwSYL3LMndJMMtN0bPj9iwLEX7ipsgi6NzadN2C/Xfn5QGJaWJIIlrRWwkj7JBgIp1ObSKisHeEegrhy/DbuAf6md2ywtS35yfAgasyOFZK4WyV2UEWZwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736901972; c=relaxed/simple;
	bh=89Xt5Ch4jSfnNfJb7i442Yc4qDTHligeMoEtKFm7moI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QDhJHLZqAZGnVQWlMv/8tDTEz9g4nmjvvX+/scc0u1IgTVe/TJCM1DWPLbFfv9GHycHAToR4Wh0SpeN5BHWXjs3AaYrMoKC7tPipdcDntSMxx4ngIK++Nz+n/gzYJhZ0yMb+WVE6WGlOXdysKL56tkMk4CWTX22hUlskIZbP0tY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=oS1ZDtys; arc=fail smtp.client-ip=52.101.191.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dbt6Sd374oVmz9eQBGZys62W9y0KPIzhv3YBQ/eyIhl4cPUV+N1o2knO+SDDn/2u7IDkXDUb5MkWJX5NAurmcrd03u6Qaywggbtc38ChKXPPRokIqa14FA/irYNOuJXTavrlahBo9GOOtosRtGTJHOLazK2R3GtuKx+vLeUPUwC4/xj2+wfiv9ehCgZs2bWwWbExduNXfRhsBOEeENzHnyfwzMZzOdweFnJe4gkkUhAlGo155rs3Xcx2caAUn/0DT2idGtxFanTrGsnc88smLFsCxllP96osz3enszlMetCdg6+CT4TrS5cla/3OQkelh5tUi0mf47FlJYsPC6/g0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jhxg3SsfgX47WRJ3GEU5NmHSMejrOLcReJ9/tX6ex4=;
 b=JmHFBgP45eMcq41XqxQn3c7KC4G1nbx1XpCf3sfBkzArLeNLai86lvClsemmjiqus7rL1Xkw6sPkp7vKTz9SFCYKy6/Uzpm1Ji4bAKh+JZyYop0DjZjhnl1q1XZ/86lAx/CuEtNJBjjyh+vS72jNVeddufrelp7IkWH6DZDQkR2EeJUAXDP9XLuZfXTTJNYWQI9yPs3TSQkE12Enr+vt4KUGHhXHfwgGvPaA3MRuB5RBM6GPKO0Cfz1TBaAYmNXmVIpZft+UwtxL37ruB6UP7bUReC6/+JX5wfcCSGFqSe/Cc7fh7997NQo7e8bWl09BvDYzrHYbNrgUIiBv+TVchQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jhxg3SsfgX47WRJ3GEU5NmHSMejrOLcReJ9/tX6ex4=;
 b=oS1ZDtys1GviiC4JqCViT0FoXd4Q7U0em/WGtZtMHM/5ripoZ7SvwKDAhPt4DHWwNeT+lECqpzz6UP2lmqoXMocrS1Cyrqns3/4E/p67Ly3pFNTAuXmycZKrvTEBwPbJgNmdchVHrUiPKQXCyJwBynp66T177rySn1ybpCdwiW56lVmlkiXZ0IlBOyzHOcEDUBxFZxfTPj2tpvmm4s4/KLzvTb81hr7A5hUmpHPqfWKjMR11emkcpTD+wjtbJj/CdRMatopqr9SGKxa+N1gHC4a8fogtv6mfZj9r8clMrl5ktCCcyQgxIhs2a2E98pnLVkvV1M3iVQ4STHjzBGc3Og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB8950.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 00:46:05 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 00:46:05 +0000
Message-ID: <28c050bb-d844-4b85-a49b-39f2defc20ef@efficios.com>
Date: Tue, 14 Jan 2025 19:45:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/rseq: Fix handling of glibc without rseq
 support
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Raghavendra Rao Ananta
 <rananta@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Carlos O'Donell <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
 Michael Jeanson <mjeanson@efficios.com>, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org
References: <20250114145132.612569-1-mathieu.desnoyers@efficios.com>
 <9b7228cf-29ed-4f35-8b8a-b4f8482c434e@linuxfoundation.org>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <9b7228cf-29ed-4f35-8b8a-b4f8482c434e@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::32) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: ab3bc558-bdf7-4bf2-61a3-08dd34fdfe0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmU4TkFBMm10d1U1S3czbW9ya2EwN2UzUFJzNkQ4d0UxOE9yVzJicWxGanRK?=
 =?utf-8?B?WVpucDQ2STc5Z1hQYUhZMmd5OUYrcmpNVjljWncrRVhHbGRiOHl3eC85azZm?=
 =?utf-8?B?Qkk2dUtFY2Fyb2lUSDViNC9WaFB2S3pvS0pVVU5KN0JlejFqMXR0R01hT2pE?=
 =?utf-8?B?SXZJK1hKNy9ZSktjNS9Rem9yZnFPVTFLTmFKUWxKVVZENm9KOUN1M0Z6OFIr?=
 =?utf-8?B?aWdtZVJwTFYrcENSU0phMzFaRzJYTW1US3VIRlJyMXRNOGU1N1hyM2xDc0xa?=
 =?utf-8?B?aDlhZVlmT2UyQkNxaWNvTHRIaGtWdlkxYjhxcktYWnBXSnc1NVpqR3M4SE9t?=
 =?utf-8?B?SVFiQ3lsWE82NVVpUm0yUkxTRXJibzhpY0h4WnVjRngzbTBtckNienlWRitl?=
 =?utf-8?B?UkdRT293ZFpKTi8xTjRLUk40SXFNL09IT2Z6QW5Zd0dDVXRORmcyVTNFTHpF?=
 =?utf-8?B?YnBFMmpXa3RCQkUvVld3N1lEYkt4M0tUaVFXbis3NDNSdmlBeHQzak03TGlw?=
 =?utf-8?B?VXJ0Zy9BOEJsV3dMeE03SXozZThaZ0ZHb3E1S1huZzJwYUQ5Y3ZPSjVEMFZU?=
 =?utf-8?B?RW5sZDB6YzJjS1E3RVNYdTM0L2VxUzRVWUVyZ0VmSG5YY3FWQ3FGcjE5V0tv?=
 =?utf-8?B?c1d6TDJQUzNVWUxxWGRKTEpmTURueEM4K1ZHamZJbWNldVJWdjJVUGR6VVZF?=
 =?utf-8?B?WHFQbndXajdkUDcyWG1aYXcvUDBhMUdUWHRBNHpVVVhSenRjdkpPZTlBTkQ3?=
 =?utf-8?B?VFlGcEkrRFo5WWdNc00ya0tkekRQY1FLUEtha1RvbjV6TC9OZVEvMGRGMXZZ?=
 =?utf-8?B?eG91U2FDc3JaZjFFOGRtTEZIeCtiWG9GVDYzQ04xckM2ak9hYklJZHlIYUJI?=
 =?utf-8?B?Zm5zekJSV0pwb2NTQ2pFWGUwTzFHVEFhQVpnNllnR2pDYkpNY2dYTDhSRE5Y?=
 =?utf-8?B?a0FjMnhCWEtuTmdDUE02QW5FQ2hkd2tiTlQ0WTRBdmdOVjJzSEE1cDVibkVp?=
 =?utf-8?B?dHBVeTJZWlZHWEFSTm9INS96SndVbjUyODNLS0d0RzBtS3Y2RlVTbjMzS0xQ?=
 =?utf-8?B?THV1YlFja1Z4a0NEWklETm9mMDlyZ3FHQ0szL3RTdkxaSFdFK0RhVUNXTDYw?=
 =?utf-8?B?OHd0cHRuZUhnNFpxMGt4eXRvVlA4L0tNdmxxNlFzcUxRY2NjZWVtSytIeDN4?=
 =?utf-8?B?NGRuYWRqSklSR0N2RThaclNCNHBTclVEQU8rbmgwNzJZMjNPc1BWYlpWcWtZ?=
 =?utf-8?B?L1UvZ1pXdTd5dCtEWWpwdk1BL25xazRRQjU0OWF5Q2orUU43RzYvdXA0ZEtM?=
 =?utf-8?B?THVrSWNEb3NIZ3lucEpJV1dodUw0TGdtbS9qQ05YdGFNOEFFZjJWUlVldXZ3?=
 =?utf-8?B?Z3pObkN2cGRobThiVGY0bnM5d2dVVk02Ymh0ZHhJaXpIU09NVEZFeHdaTWhM?=
 =?utf-8?B?ZVR0RUZDL1htU2JBcXRqLzdUMWFSVm1oVFFtOFFtZnc5T0wwdnJFTTkvOFE1?=
 =?utf-8?B?R2g5TzRqSEd2dkNCMVJKVjVIZU1CQlRXNmZoc3VPT0pPUXZJZlZZaW92NnF4?=
 =?utf-8?B?VXJtK2JzZk81TitDSmR4T002L0U4Z2hoTWZMcm9OZjN2N0dJMi9EM2l0UWJL?=
 =?utf-8?B?aSszUTQzVEJjTnZvR3A4R21jTUNIcmZxVVVqUGgvSm5MWnEyMzVHUFpZdWc0?=
 =?utf-8?B?dXdaem40a08rT2d1Q3plTlU1NmpIR1dvRXlZWUF4cWltZTFDa1ZFeDN0YmpI?=
 =?utf-8?B?S1BIMjl3TjNnbTBIN3prakQzcG5RYWZ4M09ad0ZDNG5seHFvSklYVGNKZnQw?=
 =?utf-8?B?U09tOGpkWE9iZTg4LzhYUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3VXZFNVcTZ2N0IrU2NhTmJibVB3SjlQZFI1S0I1UjIvMG40a01YYmhHNk5H?=
 =?utf-8?B?Z2srVGxNbk5vbE5MeVNNUDQyZFBaZ256VC9tLzJuakd4NDkyOG9NVmpFMytU?=
 =?utf-8?B?bXBPUlZoK3FBeUZJSEhHdHZyQ2gzRnNzaTVXdzRQZ2FyeXBVWFp6Nmo1TUhv?=
 =?utf-8?B?MVhCTXkrSi9FQkVSV2hCN1F4dXdqZ25JYjRWT1BkR3IvUk0wRUZaWC8vNm4z?=
 =?utf-8?B?d0VQNURJdTFkYnNxeUlkWWRKQnoyVHdiYUtqL2FnNWZqc1BSSWZpNzFKZDli?=
 =?utf-8?B?QSszNzhjdlBSSWdLSjZIQldFNDNUaUlMRGtrelNWMzZhaDV4T2NtanlmOFo3?=
 =?utf-8?B?aUVlTHUrLy9qcEhabHpGMXFFdHNQbS83SlBWRVRVdFRBNmt3cVNNSytqN1RL?=
 =?utf-8?B?V09uSTU5dWFJOTVPb1pGOUcrZWMzVzZDeVlvZzhpaG1ma1RkQlZ1Vzc5dlcw?=
 =?utf-8?B?cW9iOWZOZnhOenY4c1kwNEhaTXgyRWJWUTdFNzVDb01pZmQ3K1NFU0xuQVFk?=
 =?utf-8?B?M0pBWHd3YVJmR2tqaGw3RHpMY1ptUEdZS0FnZXBzWUMyQkJML3d0RXRQMHQr?=
 =?utf-8?B?QWhGQXlJQXVwdXFqTXZ0aGVMUk90eU85VXVqYk5FYUpMemNycHBKMHpSQ3F3?=
 =?utf-8?B?UURabk5Cbm5mVWxvd3d1MzJjNVFSK0JLRVoxako2cUk5cXlybXJ5YUtzRGY3?=
 =?utf-8?B?Yk5lT2s4dzZkc2FRbWRuVmtwd0hNdWFDa05sZzRvYmpGSWhkRGpNbHFCcmFR?=
 =?utf-8?B?TTUwOHdqbmlDQnhBVEhpRVhWVUFCOXYrVkNWZ3NxNlJaUXVlQmU5blVxbW5w?=
 =?utf-8?B?RjFrT2FzWG80cHFuWFBOdGxxQUJoZFB6UHVsaEI3ZFR3a3Y0WEpWd0NZeXFr?=
 =?utf-8?B?N2ZySXN5dFN5QWNQVWxJWWZqakVSS1p1cEE5WEhWSTlzMm1zUTI5QW9lbTg0?=
 =?utf-8?B?Z08rL2IvV2pXTEcxRW9DZ3Jad1NCelo3WDRhN2VaS1ZNVEkxZEpuL2NPL3Zj?=
 =?utf-8?B?Wlh0NktIdS9RNFc5U1pwZDFOZzdONkgzU3U1UUl2bFh0c2d4clZVU0ZVQXg4?=
 =?utf-8?B?LytzVE5BM0FBbEhiU3hkeWQyRzhEY1lJY0x4enVzZnM5UUxIRjBYTGtRQjB4?=
 =?utf-8?B?Sml2dmNzZ0pITEJYQk53YXlBSEFEQjdNNmFCZTliYkZXVjBPZ281eVJIbGIr?=
 =?utf-8?B?K1lTbDNFWEZCU25EaFBmVDB0TUFFK0d0RU5uUTdHUWR4ZjlSVlMvZTluM1ZR?=
 =?utf-8?B?WFJidUtNYWpyS2o4alBrRUZTV2VUQkFVODBlalNvajBEdTNyaFM0eS9KMmRp?=
 =?utf-8?B?Wi9OT25ad3Z0OU5mOEUyRlU3TzdXbUp6SGp3bHNwUk1vNzRkbFp1U2tDNDNr?=
 =?utf-8?B?MGpqSG1SUk04bGd4cDJaRmozdnlidUI2SzhaNTlHTzg3KzIvWC82bWwzNWRj?=
 =?utf-8?B?aXJXVTZIdG5hcVV2U2F6WDlBMkxicnJBd2hmT1lMdWpIcEdOSi9GSkF6U1Vr?=
 =?utf-8?B?QklhZmZFZFhzNEIzckgxSkpNYkd3eWMzWlhzakZObDJ1Y2JwWUxXMVBuNUQ4?=
 =?utf-8?B?eHhPK1ZiSHRUc25MWjNUVmpTYmhQT3ZBOVNCNStIRTJnaEo2OENYWTFKaEFQ?=
 =?utf-8?B?T0czNXF4NVE1R2FXZWZROU1uY3lENldwNXQ3cTBRbEgxaVVvV2VGcDU3S1NN?=
 =?utf-8?B?djY4TENIWC8vWGZLRnpSWHp6KzdkZi9OTDFnay9IVlNGbUNaYWZjTXU2VHBQ?=
 =?utf-8?B?V3BCcTZzMEFoWWsrUHFuQ1NBQUVPMTJFZjRuRVpiNXJlWlFiMzgvSUNhOGEx?=
 =?utf-8?B?ZlJMd2VXVlB4cHdaLy9OanVtT3NldUM5Y204N3FkUVNmd2U5SVZXZWt4Uzl0?=
 =?utf-8?B?WE1XTkJsMXR5OWdSK2p6cjh6d1NCbXZlWm5qa0ZxVzUzRWRYdVNZL0pjZkVI?=
 =?utf-8?B?NTU4OTlsQ1FiL3daN1hXRDdHZUFwTkk0aHJKQXFWZHc0bjBvdTJsYTBCMjlt?=
 =?utf-8?B?ZlBVbXd6WHRBeGhlc2VKbXNoQmNiWS94ZGtBV09TN0RFaE1vM2pBQStDSVAy?=
 =?utf-8?B?QzM2dEVKQVU2OThHT1FSSmdQR2ZxbThFaHlsMVpCT1o5bmZKZkVHY3JnYkVx?=
 =?utf-8?B?Y1BSR3ZuWVVHWTZLdzBCUG4yYlN4bnBXVEgwbmI4RTIrQTRyRmNIMEdmTEtM?=
 =?utf-8?Q?NgbkIVKsPPeVFiHq4EA+KiI=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3bc558-bdf7-4bf2-61a3-08dd34fdfe0a
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 00:46:05.1137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XTLkfMw4lyQeXp4VsTlaG7JQ8mbbudcHriLi4VGPAUakPOnNHrncCWMPkLRmTMA9DdwekM/gYgKwFX3Of/kLs4UQX4ocb0nj9NH0wZ21Xuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8950

On 2025-01-14 19:14, Shuah Khan wrote:
> On 1/14/25 07:51, Mathieu Desnoyers wrote:
>> When porting librseq commit:
>>
>> commit c7b45750fa85 ("Adapt to glibc __rseq_size feature detection")
>>
>> from librseq to the kernel selftests, the following line was missed
>> at the end of rseq_init():
>>
>>    rseq_size = get_rseq_kernel_feature_size();
>>
>> which effectively leaves rseq_size initialized to -1U when glibc does not
>> have rseq support. glibc supports rseq from version 2.35 onwards.
>>
>> In a following librseq commit
>>
>> commit c67d198627c2 ("Only set 'rseq_size' on first thread registration")
>>
>> to mimic the libc behavior, a new approach is taken: don't set the
>> feature size in 'rseq_size' until at least one thread has successfully
>> registered. This allows using 'rseq_size' in fast-paths to test for both
>> registration status and available features. The caveat is that on libc
>> either all threads are registered or none are, while with bare librseq
>> it is the responsability of the user to register all threads using rseq.
>>
>> This combines the changes from the following librseq commits:
>>
>> commit c7b45750fa85 ("Adapt to glibc __rseq_size feature detection")
>> commit c67d198627c2 ("Only set 'rseq_size' on first thread registration")
>>
>> Fixes: 73a4f5a704a2 ("selftests/rseq: Fix mm_cid test failure")
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> Hi Mathieu,
> 
> Can you double check these commits and make sure these are right
> ones in the mainline rc7?
> 
> I am seeing "Unknown commit id" warnings on all of these - my
> repo is at 6.13 rc7

This is because those are commits in the librseq project at
https://git.kernel.org/pub/scm/libs/librseq/librseq.git/
which is a different tree from the Linux kernel. I am not
sure what is the preferred approach when citing a
commit ID from a different project ?

I've been keeping both rseq selftests and librseq in
sync since 2018. I plan to eventually add a dependency
of the rseq selftests on librseq, but this cannot
happen until we freeze the API and cut a librseq
release.

This was premature before we reached the major milestone
of having extensible rseq support in glibc.

Now that it's merged into glibc (as of last week),
we can start looking forward to a librseq release,
which should eventually eliminate code duplication
with rseq selftests.

Perhaps we should add a Link: to the librseq
repository ?

> 
> Also would you like to add Reported-by for Raghavendra Rao Ananta?

Yes, please. Can you add it as you merge my patch ?

Thanks,

Mathieu

> 
> thanks,
> -- Shuah

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


