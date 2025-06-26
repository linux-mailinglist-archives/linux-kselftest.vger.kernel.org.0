Return-Path: <linux-kselftest+bounces-35868-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 791B9AEA330
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 18:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 185A41C44C46
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 16:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646111E7C03;
	Thu, 26 Jun 2025 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Dd6kQ3Yx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2131.outbound.protection.outlook.com [40.107.115.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D4A8632C;
	Thu, 26 Jun 2025 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750954035; cv=fail; b=moxm3XT0MYkDnz0y+0VEi1Ca0B4dji1ODwm2942fSsvOvXJD8T2phaT+ZNx8H0t49PGXQ3EGJoRNi3hJmo6n8T2MUrXCaXb5CXik0uIqfR6+zZKsgnb4Cs7qR4h9ruNQk5fT0yPelaXPhmM9NFHRTrcQdZ0Uo96sW42K9bradRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750954035; c=relaxed/simple;
	bh=f8CaSw26KdFadEElkDvhfsPF2GjT8Hvh2nH8Xk/pi3U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n7iaLcZ0J5Jqf67wWiJcCwIvIgwpnuShFMcFrce5N3yK8n1mxgv1FD6iZ00Te5p0cjpcahH6b+Z/4yacKKMXa+IW/WMO7zCKoUschlkfVizQAYTnWjL5He0mtNG74hOzXtG0H0nJh/uBMjQIRr4OGgDnjRk0UkDqFYW2tsye7nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Dd6kQ3Yx; arc=fail smtp.client-ip=40.107.115.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7Rn3JUorqbBUZEYDCuF6tYsHcnFwMxa6AJK/EK5GHhmLKRqS7cfzaxq4dXKenZHlj4hDY30MvZEfc2NPXI9PfmnkvF/HzOwhUg2P7W3Ko3p45G0eobgX3bS1qkMezCS6acO3bQzhAvZTH+mXvo0G9yXKKaD6rCdNxon3sGCkoxTFywpFJTuGP4Hd0jZoRc9vt5WT9urb7yjpf9r4ZQmrv32HhSWcBVIjs14/UZswZwd5pMwgEGrwEHYtHxgNNpOFTX9uEC0WOIdLg85+QAx0nSs9nIoW1aDUyNhNwqR3O4a0N3DRCvw2h3+5KUoyRpZ/9gYwKOiuWA2dHAp9rwAlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxzXLX6sHA7VbFXsCloODxzidSUq/+Qfq98JTvI42U0=;
 b=HyYxMe/FCXWEZM9USy0d2/JJ9ovnufwlz139H3yQdORa+5q4O5lHeUNSUUor0Bvq93tS/5qWkcxnrw/yceR7s7S0K/P3H2iTu/eTkPNRO0/bFs+9yrEZt2lAuRmFC44tQimpDCGv8fhTnQNrLZtlkSsRwEythOSE4Ez6DXqyZL+klHmnB75sbOzoJ7koPac1bc6PBO/QbKkYjTNnJRc7r7Tsch1ozLPn+GfQUj5eNYy/icOuoVBgaY/S1Yf8n0uIYPIxGJhhNUHAp6ATa1xZl72xMjydkxlm98Fcqx5AgboI9jjg0LAjpDYKOHDJBHRd1bGzffVN2+o7A7SEZy7jhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxzXLX6sHA7VbFXsCloODxzidSUq/+Qfq98JTvI42U0=;
 b=Dd6kQ3YxYAwiFTg9m8cavVjWFtiGCajiKp/0Ue1UUDI7Ffl19V/jPnFij5I7l4VYKzSb3uQC/fyJcrlXyFV02wmvdQaYr18nZcpQBv4bKU06en5xTDyllbwe/cy6oWnOh1TW1OBt/gwnQj7VCYJ9XjWAkoTzyyRdsu00Cofp5gg3OWupvGAb/L1yqiJypnY2eDcTmOTdq+pFMt1PzQRGNQ5DisDMauyJvCEQ2gw4E2Le3aIgstCmin+IeAIiAw392JmXlyTceCSVwzAyYNYmvSlWOMAboyaMPAPTRzlSn0zwNGYcdrHV8kxrxFLSGEjaJUcJnc6wMNUGRGK4uRDrbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PPF1CC8935A1.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::510) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Thu, 26 Jun
 2025 16:07:09 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8880.021; Thu, 26 Jun 2025
 16:07:08 +0000
Message-ID: <4db5be54-7c27-4aed-b70f-3722a890904a@efficios.com>
Date: Thu, 26 Jun 2025 12:07:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] membarrier: allow cpu_id to be set on more commands
To: Dylan Yudaken <dyudaken@gmail.com>, paulmck@kernel.org
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250626155257.81256-1-dyudaken@gmail.com>
 <20250626155257.81256-2-dyudaken@gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250626155257.81256-2-dyudaken@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0156.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::29) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PPF1CC8935A1:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b544b47-0046-4764-92b4-08ddb4cb809b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWludTVYY0RBZGZONVNHVUU5a1lsTVVTRW1hNGtwTGtMYmhvaFRLUXBJN2Rt?=
 =?utf-8?B?amFkVy91RTN3eUZiaVd0U0JLa2lYdEhDclpFNm1Vbnh1emRqYmhzVWxncENC?=
 =?utf-8?B?V1RZV005cUJPRzdmSkJ2SFpFckZaTkdYMXZ4M0IzZHhlcXgrMVh1ZFRtTFBX?=
 =?utf-8?B?ZEllK2s5d0QxOEM0L3ZYenl3UStHU3c0bW4rb2pwOXpjSlFCeithMlNueWps?=
 =?utf-8?B?NExpaGFQaTRLbys2d2M5NlNVZmJ2V25WWlpxazlBMFBZSE5YUHZ4VVV1bEF1?=
 =?utf-8?B?cmh0Qk8rRE5XVi9VNlo0QWRYSHlmWXdZWUtOZjhHaXNMRy9kWXJxOXpNQ2Ey?=
 =?utf-8?B?MURFT1QxSmhuUlRUd0x4NVZsQTVQNzFEZVJLZ1RVa09qSTh1OHJSbGR6eWdO?=
 =?utf-8?B?WVU0SlpaUlJpREM3N1BUOWdEeTdnYis2TWlOYUdrODJFV0c0WEZ3eWw3aE9M?=
 =?utf-8?B?MlJ1RzgvcEJseGhOY1BvNTVCR2w5eVBrT3pwSXBGQ0R1aFNXR1hoaVZEaXIw?=
 =?utf-8?B?ZnpDaytGSW5aVU9CZ0laWU01UUtvdUNQT01XNnJkelorbzZHL0VXc091MVhB?=
 =?utf-8?B?TzdWamdYNXVYVm9BTlVEbFd2L0hIMTF4WEtwd2dybko3MTF0Z2lrbmcwbjJL?=
 =?utf-8?B?b1NTUWlNbS85eHRKNTBZU0hqQ05JZUZSUVJBTmo3eHZaUG1FK2dKajkzSVJn?=
 =?utf-8?B?STI2YmJHbDZyT0J1cC94R1BNM3U1MC9RbFo4QStQUm9SWitNRnRTREJxbjV1?=
 =?utf-8?B?N3hFcGhVWEMvN3EvUzJxNUhQeGtGdVpmR1ZiZmRzNVpHWHg2cXFFbVlhMFl4?=
 =?utf-8?B?S1NjSGg4OGFvVWxESHU1ZTl1Z3FmN3E1MUMyTEFWcDhlZVF0WWFCc1hhWUxN?=
 =?utf-8?B?QmNnN254Y2FPTlN6Sk9kTEQvY0NBdWZ3NVJUb3NaRUJMK2tpMEkwMDZPdTM0?=
 =?utf-8?B?WDdTR2FuYVJGTVR4dDJxNTdTWnFFUWFCYmFFNytxN3QyY21mQ1cyelhFK0tH?=
 =?utf-8?B?bVRyY0xRbEZaWEhjSWV5a3U5RmdvNFF3ZFVja01sVHZnbXRLUWdGUGhPalVy?=
 =?utf-8?B?Nmc1RmdnRFFJdGh4dWhjT3N6ZXM4QTZYMjVRbjRsOU1MNWU3NElJdjYwTFhy?=
 =?utf-8?B?MHBEeWcwQ09LNHVmRDVJNy9ZbWJsY2RUSHFVMW9qR09IOTJkdHRKbWJPV0la?=
 =?utf-8?B?eHIxNnJFZmE4dGJXUWw2Q0ZjaFBmZ0phc3pCT3c3SEpGVzFuNFpkdUVVeE1t?=
 =?utf-8?B?bllkQWtsMDVNQngwQ2xHdUsrTmMwSnlkcXVDSW5KUTFPL1EwRy9Zc0pQUTdP?=
 =?utf-8?B?U091WW4zLy9tQnpneTVpK0h3MTBHSWYzQjIvZml2aTlDa3dvTTJpalBWZ20y?=
 =?utf-8?B?MXlvVGlkeGttTkRRNmRLS0p1S3UxR2lLZWF1R01KZGY5UmljcHVUVi9IYVZm?=
 =?utf-8?B?eVRDUTNkcW1hL1ltS214QzdQWFpMMzZFMGNiSHZQK2s2MGZMQ3lzNjEzYkNm?=
 =?utf-8?B?NVZGSHhGWTExV3RpUE9kVWpsVUIyK2VmMTZHb2p5Smc2MHU4MFFrZG1laVJN?=
 =?utf-8?B?UmZJRlIrbXBldzlBR2Flc0hRakpsRmpFbExyOGVlVlpZMU5PSW8yK0RBUEdH?=
 =?utf-8?B?WUZ4Tyt4QUNEM1ltR1ovSmNtTlVFaS94c0NJbTdRbWdzUjYrcUZnQXdOQzdY?=
 =?utf-8?B?d3h1aVdGLzFBcXZmNEY5cmNoUjNyaXowMGx3NHZrREdQU002SlFxSDNLTGFo?=
 =?utf-8?B?QzdLb1o3UFhFQVF6VTlZUXBoM3FmaHdqRWN5QmZ1bUlxSlhuZzdYTFBDNGV3?=
 =?utf-8?Q?BsXOF5I0vZMtTBQbPCV0n6MaQ9xflb3fcJdTk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzZFOHlXRmJFTHZzQjZkMExjYnM0amFDN21leXZMcWNBOXZJOE96d1N2MEVa?=
 =?utf-8?B?MzVwYmRSZlBSYnVMLzh3cjd3ZlpGNGJTUEhiODBGRDdmbHpIRmhLZFVEODRC?=
 =?utf-8?B?UHJHRHREMUhOT2pVS2JGWXNOa2s4RkZEL3Y2OStmU0wrdEU4SXRuM0JGUnpa?=
 =?utf-8?B?QWF0T0tCbG5ya2FLelJwTVRRWTYwa2pBZlF3VW0xWFAreU1CNEExNndXaVJF?=
 =?utf-8?B?SmhWVkN1VEt2eHBTUjhlQk1NeCtETmt5RFFFdzg1aDJZOHh2N1NGeWwvOVN6?=
 =?utf-8?B?V2ZTODhmL0w5NGlkSzFGaWNkNmhPUlJsRDJaRlpLL0lXZktUVkhnL1lJbGRY?=
 =?utf-8?B?cnJuWDlFV29LZ2sySzBhT0JZSHZkWWMyVmxxcDd5b00vNENXdkxPRGNBWnpM?=
 =?utf-8?B?R0dDZFlneWgycTk4MGxOTmYycFVCU0JVNVpzRlhjVW8raUIrYVNETjBqNExs?=
 =?utf-8?B?Sm83aHY2K0RIUkVJekZFVnRoZU9NMEFBT1VCbUdGZFJOMHZyR3p2OFVmd2xY?=
 =?utf-8?B?eW03czFmaEVTNVE0RFpTUVhBK2wxbzhFdCtkbGJJOXdlOG45Qmg0ZGxyOFZO?=
 =?utf-8?B?TUpkaXJSeGw4ZXdQMzRsYlBieG9yYVZLRkwxekVuUGJqS1R0OG9GdHdoUSsw?=
 =?utf-8?B?UWNhU29aMk52dVJvbjhhWmF3VXJmd2R5RnJIZm9NTzk4V01UUFhZRjIyY042?=
 =?utf-8?B?NEE3ditIWGpPVXhBQ053R0xZbGNSd3QwR0o3aDh6OHNTMTZScEhRQXU2WmxI?=
 =?utf-8?B?aWptYzhSWnNGNTRHakQ4bDdLYWZqbWtkNS9lSjZKM2ZKS1VsSVZLZjJZK2sz?=
 =?utf-8?B?YlBrRHhjYWJmdUVVQ1p1alkzTjdYNnBTUjFsRXZnL3NKQjZTdmlXUWQzK1lp?=
 =?utf-8?B?N0NDcldqRENkTkNESk04WTQxR2w4K1FYQW9tazlPMVJrNURZOHFkRkpQa240?=
 =?utf-8?B?bFVnVDMySDVuNis3QWFlNVg5b1Z4bFdVV1Z3TjRGKy9UZVdQVEFJUGVhb2Q0?=
 =?utf-8?B?WktnME96QytJeE5wa3pSeUh3MjZzczIwV1gySHdLY2o1UWxFdVF1RmZtOFo5?=
 =?utf-8?B?TW5GWlFJb1VyUWtwaVFoRWtWZDhUNjZCWTVIMFZoS09zUGR4Z25XU25JQ094?=
 =?utf-8?B?dGF2K3QxREx4aHhKSjNuR0pKamN3d3RiV2lJb1p3WUNHVHA2OXV6OFhuS1Fk?=
 =?utf-8?B?ekVtVU1TWkg0Wll2Z3VQZWQ2SmpLQlpqQTVqYXVla2Yza3RPUCtNRVQ3UEFM?=
 =?utf-8?B?aXgwSHNVOEdKRExOSmVyckwwNlBVYmN3Q3NWVDlRejI4WTFQVVRVRjJENXdy?=
 =?utf-8?B?WGN3b0NKZlQ4Z2ZHeVJmL2FSQ0hYeGdqdEZSb0hnMERQRGxybWN3c1JpMmxr?=
 =?utf-8?B?cHYxQzR3dlVmRWUxZTQwL0hDYTZWVEpWOFJoUXBXa3NCRUdTeTArMVFWNVND?=
 =?utf-8?B?L05jakpISzJDMG9xbW5Rd1lhWUl3MlpEa0owTWdkaUM2Vnpsb1lmOXpzT2pE?=
 =?utf-8?B?Z08zVFFGNzREcVVGV3N3WTlHUWRwNHdYeFREVVJZbUwwZ2hTVVQ2Y1dkOUpR?=
 =?utf-8?B?V0k0Ty9ZMG1ZZXpwNGtVQk8xdlI2SUt5ZVczTkVTdDFHS0xkU2ppV2tjQldI?=
 =?utf-8?B?V0FlUkd5MEdRaVB2Sy9Jc2dEaVhaUmRWV1grc2orVzM1NXlXTGM0L1N1QlhB?=
 =?utf-8?B?TWJKMm5iMGN5ODg5bVZiZVpqdXVZK3lxbEtUbHV5NWt0dmNoNkJnc2tMenpS?=
 =?utf-8?B?U3dvMC9IQnExVlkrdjc2ZzIwOU5GVkdPZUlsNU5WRjhEdFBEQjdvWm1LUkF6?=
 =?utf-8?B?cmxXS1JTZTBUV2lIL3B5ZFpUaWpNSmFSQWt1bzI1KzdJVnBFcnBCbGtJN2pv?=
 =?utf-8?B?ZW5NRDNRaFdLRXBoazJNMmNITGFZdFVoQWo5eWo2aXkydUZJbW9jY1FMb2Yv?=
 =?utf-8?B?MXJWdElzYmJCb0hPZUtRVDJQdHBXanExbWpGK0xlR0w1TVVVZzFZR2VhblVq?=
 =?utf-8?B?UWlwenFxRHRIVzIraWVRa3hUUXM2YnFuS3RQY0gwS1VDNWNRNm9vby9nMlow?=
 =?utf-8?B?WlpSS1FscjJXM3NLRDVTcmdCS09rOXRvdXpZWTBOQnBqMmljUE4xRzNja2Zp?=
 =?utf-8?B?K2NUOHpaMmpPSmhDQ0RMaTY0VXJUbUlKeWlHM2NOTzI2Q1gwaVc3bUlVSGg5?=
 =?utf-8?Q?4krR05uwDX8V+iTGi+X9KpM=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b544b47-0046-4764-92b4-08ddb4cb809b
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 16:07:08.6847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VGxpxE3CwkkKLTuV1BfSWOvkNMeQFFf6FTKq8SjEZWD62ZJHkwqHJRk8zwF4Adx0jRA04SPgZjhyqguoxnBhdX7QFt798PCG1aYUe2EALf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PPF1CC8935A1

On 2025-06-26 11:52, Dylan Yudaken wrote:
> No reason to not allow MEMBARRIER_CMD_FLAG_CPU on
> MEMBARRIER_CMD_PRIVATE_EXPEDITED or
> MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE.
> 
> If it is known specifically what cpu you want to interrupt then there
> is a decent efficiency saving in not interrupting all the other ones.
> 
> Also - the code already works as is for them.

Can you elaborate on a concrete use-case justifying adding this ?

Thanks,

Mathieu

> 
> Signed-off-by: Dylan Yudaken <dyudaken@gmail.com>
> ---
>   kernel/sched/membarrier.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
> index 809194cd779f..def6d4094ad6 100644
> --- a/kernel/sched/membarrier.c
> +++ b/kernel/sched/membarrier.c
> @@ -595,7 +595,9 @@ static int membarrier_get_registrations(void)
>    *          contains the CPU on which to interrupt (= restart)
>    *          the RSEQ critical section.
>    * @cpu_id: if @flags == MEMBARRIER_CMD_FLAG_CPU, indicates the cpu on which
> - *          RSEQ CS should be interrupted (@cmd must be
> + *          RSEQ CS should be interrupted (@cmd must be one of
> + *          MEMBARRIER_CMD_PRIVATE_EXPEDITED,
> + *          MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE,
>    *          MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ).
>    *
>    * If this system call is not implemented, -ENOSYS is returned. If the
> @@ -625,6 +627,8 @@ static int membarrier_get_registrations(void)
>   SYSCALL_DEFINE3(membarrier, int, cmd, unsigned int, flags, int, cpu_id)
>   {
>   	switch (cmd) {
> +	case MEMBARRIER_CMD_PRIVATE_EXPEDITED:
> +	case MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE:
>   	case MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ:
>   		if (unlikely(flags && flags != MEMBARRIER_CMD_FLAG_CPU))
>   			return -EINVAL;


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

