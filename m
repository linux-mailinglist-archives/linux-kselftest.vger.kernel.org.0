Return-Path: <linux-kselftest+bounces-35458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF981AE20F0
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 19:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C1D7173802
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 17:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7FA2EA14E;
	Fri, 20 Jun 2025 17:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="le4L6/pj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2106.outbound.protection.outlook.com [40.107.116.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030712E3387;
	Fri, 20 Jun 2025 17:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750440564; cv=fail; b=FXv4MJcgCHGs0MUC4My2++QyYMLxJS3rFspDtGoTERNQbm5bdJFicWdjfRchlclgroj2nG3QOVrN+ZF7YyUxlaXcHkt8bZUFgi7HKEWoqOoMi6rt9F75p+p4ubuxJrCwDhf0UrPfBedcOMe55frJyzMINTj0F9sMxtKrM1v7aDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750440564; c=relaxed/simple;
	bh=xAOBdLz0JNgae57YIdBsJ5D9xfBh3Bl37iuuIEJQSSM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LnzMBZ5p00V2i1Dq3TiVyyjqZZKdMxZj73pwX8QEwdkuR8cHSHPJ6osNdP1ZO91pQaFDWVGcA+r0pV2SUOajI49JS/xSsswBja8yGPWUm7vlIClBfC4dXyg9nkpXXXyP51tgIwcXs1sTNBn5p4FGlDNvNB5Ma0de15TIKcQO9eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=le4L6/pj; arc=fail smtp.client-ip=40.107.116.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=etz2nDK1oKhQ5OZA3X3MHOo0gfhOkqp9Ec/iS/pkHUn0/irZ27oX4Xn67vh7t3Vg205n9eZxAGblLe9fZxtYpiTwrbNDsExRy6kXyQvGvd1Vo24XEwkfFQJvUx1YQ8xFxsojAmxcSqv4CZeE6eynTbw3IVz53KddGmrFUjDMyFoLzwzcklB52gMNHJ2lUjezHYxA20Vdhd40Zw5QQOpO88guiCiplbLB+0SeXF8glZRTQZxwuluvSXObY1cMkkRea23nily3oTENwVVqWXAjz9FU2q8T6ofvPez5a7SLiSRlxqqeRHaFIfVcWFFnXx0M5h71NSP33ieBX5vmhzAFWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkihkXxJMh+ssDp07Lm7OWKlalMC5LmmtIa9dWjwFCA=;
 b=uiuT1V14zt8b89OkZ85zU+jqFVM9lW2Yj7cWfEEL46BGch1reTIYc5iFAnF+lYh6jYt5FfYL5zY2D3u7li0ttECAk/h8GCmlE2YgzyCzmic0FapEAqEaTCL7/jWz2zG/efmz11Ms31qEdyd74dm16pBf77gG7cKMo95yMtj025wz8bSlBAhivUJfj1WnYzyCb26ZDePi9KcOWq3VmJ6ViN2jLqHy1j4AR35POwJvt9qwLMadINOrCvnXbuKNPWatLexx+ilz/M8HdnOrMKJBW5JKA+doX8OSYCJaAvp1hV7PKY5vO37KN53fCsMmdIrJFqUpIzPbN6W7sD3aqbufjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkihkXxJMh+ssDp07Lm7OWKlalMC5LmmtIa9dWjwFCA=;
 b=le4L6/pjMe4jo756VY5uYJlVU94KaVoSxVzzyUpD+rTq79COSmrqMkEuk2dZVV4zDvCc6/5mu4RONYKBBpd32azrCv3PFOOpP0kkCdSCrs2rP4U1gcJzh/hGjwFSH/K7N/ND/Ne4O5dZInMPLNthQnnFvq3citcUSMjAAAww+gmJHbI3E22Ckl8cR6x/jFxsk8LCRZeSFENsZ6buvO5+VaeWKYHMBqqEGzzwM1xBiUzxQTHkgNIDHMXyzTHkXDS4wDreRqdOD+CcvEdgIXVNCuf3/cYElFeual6B2QCF59QVyBgrQoMurvjd+Gbw4GlakIHgrZSxWARcwjFsAzccIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB5462.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:45::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 17:29:15 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8857.022; Fri, 20 Jun 2025
 17:29:15 +0000
Message-ID: <20562227-7116-4842-b5ea-f950b615719c@efficios.com>
Date: Fri, 20 Jun 2025 13:29:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v13 3/3] selftests/rseq: Add test for mm_cid
 compaction
To: Gabriele Monaco <gmonaco@redhat.com>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, Ingo Molnar <mingo@redhat.org>
References: <20250613091229.21500-1-gmonaco@redhat.com>
 <20250613091229.21500-4-gmonaco@redhat.com>
 <2606da6a-3a13-4db6-855e-8dcc61c45b45@linuxfoundation.org>
 <70fe4209-4a31-4957-a658-727081f8291a@redhat.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <70fe4209-4a31-4957-a658-727081f8291a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0073.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::6) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB5462:EE_
X-MS-Office365-Filtering-Correlation-Id: 365ad16b-e2ef-42b6-aafe-08ddb01ffac1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnA4eEtGVzdNODR3TkRpeTliTjhFYi84UU0wTWJEYWJnT0p1d2UzMitTZm5X?=
 =?utf-8?B?M2pKcHZhdXoxRG1zaXg0MXRwVVdURXROL3l3WTFtekhSZ21lUU5CTm1tS0Vz?=
 =?utf-8?B?RFNEYUowci9MbnJzOVhRT0VDNDNoSllhOE9lb1I4dlhIZzlwSzA4TmwwVEZJ?=
 =?utf-8?B?NnQ1bWw3VTMwWmxrUk9lQlliSzZjT0Vnb3NIdm9JaDFDdzJDNTlzR01tNnpp?=
 =?utf-8?B?N2JFRGprV3VVZjgyaXR1eEsxYkJvcTF0YThpMnV6dTlUWEU1RlRWbS9oeURo?=
 =?utf-8?B?elN1NDIrWG8wQzJwNWZnL0VIZUVUa2xUN2dHcHRFRi9yOE4rc3BKV1V0eEZB?=
 =?utf-8?B?VFpnRXlxaTZCWVRVdmxndTZzNkxtU29qREVhNEFJYWRpbE9qbmxDK1hkOG81?=
 =?utf-8?B?T1hxRHJlUEtER1V3VnA2TUZ5MEYrK0N1TjlRMzJCL082cGNVN1o1T0VzM0dG?=
 =?utf-8?B?NUNqeW04ckV4M0Ewby9CMGV0VnRIOVp2WDBjUFpZWC9nT05rcFlEWHdjWHFV?=
 =?utf-8?B?NTBwRjNpV1c2emFDT1pUOFgyZEQya3o0RVg2NnBkZldDN2tJTmxMSlpBUElU?=
 =?utf-8?B?ZUVQTFFVTkJXQTRvelg0UjE0VUI2S3NsbjJmeFlmOEx3RUJtZEcwTHFLV0FV?=
 =?utf-8?B?bG15SUFPK0Q5cWxWaXdXbFJnbXhUd2ZpMmtvRWFLSVFqTmdYL2x0eTBIKzQ3?=
 =?utf-8?B?Wmp4dTN3WkNwTzZsaVAwRmk0TGxVL0FmMThmZFJ0c1RtbENLSXF5Ny9pbDM5?=
 =?utf-8?B?a3BPY1BScVhNQWJsVnhqSkY1cjVDMHF2WWpyeHZLNEpMREdxSm9EZ1FtTm0w?=
 =?utf-8?B?YXo5cVVWVElrZ3BJdDhwWDFLbnBqY2kxbkRPMmQ1dmdObFZKMC94eklZV0Zq?=
 =?utf-8?B?RkxvSDljdGJ4N3Y3YUtRM1U0eU1qdmdQakV4eVIvWE5sUi83cFdsb1JkemhN?=
 =?utf-8?B?SE5xaVZmU0NyeVhHcHo1ZVdyeVhvdzAwOWY2eXFyWHZDbzdlWHloNXNjQkxZ?=
 =?utf-8?B?eWNSaFczVzhWSmxPcEY3T3FlUE5ML2lHQXZJRFBqYlRsL2UyTUlCYnNBZ1Ez?=
 =?utf-8?B?OS85MzRtUzNoYVphblZmVk5BZzdaV2VnQzhsTFBNM1BrU0xqcGxGd28rZEUx?=
 =?utf-8?B?NnR3RDNMYitDTFRPeXA5bGEraTN2ejFMdHNobUVsOW55UWpUb3dtajVEei9Q?=
 =?utf-8?B?M0ZmWllvRVJ2bDNEbVEveHVhS3RwMEpVRGUvL1MyZC9GdVNoM1d1N3pXNWVD?=
 =?utf-8?B?ZFV6ZVdyQUVETVlUV011S2g3TDYwTnp3RGhxU1o2SFNnejRqd3JvVys0aGRy?=
 =?utf-8?B?WTY0eXFZQ0hDUFZDYWxra3p4STloSSt6VW0xWkg3cG9NaWxUTWNmc1VmMkNs?=
 =?utf-8?B?UTEzSFMveldzZTA2UVFNYVFEQXZDNWltTmJYQ29KM1cvNlhQM0RXOXFETjF6?=
 =?utf-8?B?cWFEeE5vN0VKOWRPS25PZGJUTFE2R3c3SkRuTm04ay9oblZ3aklEQ1RVNUFL?=
 =?utf-8?B?ZE1tYmFmMjRFazBtTXpJMjZsSXQ0eGdMMjRud0F1QysrS1RGRHRTOGdKM1RR?=
 =?utf-8?B?OEZXMDJrcjZHUTMxTHl4Y1pCcGt1S3ZoRS81OG1hL0JaL3ltakFOT1JENkk0?=
 =?utf-8?B?YURLbTdQYk04U1FlWjMzcm04Q2NIV0duQ0Vha3V3Z3FudG9IdXRBbFJLTnZY?=
 =?utf-8?B?V2VDZS9tQjFuc05lL0ZwZ1J1ejR4WWQ4SjBkRkdKV2tSSnRPN1hCWmphdXVq?=
 =?utf-8?B?UW9uUWNyeFdzU3hjOElUZktBZ3h2Qkx0K1NwWXQyOFlOSVJ0b2Q1WmhVMEtw?=
 =?utf-8?Q?6/2OXSMo0vDF8oJI1pv9diEEpJMLSCbf1rOqY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzVMbTdCQ0JpczVieERSTzBPSUllbG1CVzVaRE5QSlUwbDJpWHoyWDFiejhk?=
 =?utf-8?B?MXZzMTlFNllOQ2xjQmlNUEo1NEpLVllOdjRYZkFqenlqYjA2eWNWSk4xZi91?=
 =?utf-8?B?QS9HQkJHSzdPM3lOUHgyVlltai9XNE10bmNsTmtPc2pRUWhkQldmdlBhQUpi?=
 =?utf-8?B?NW9WVkN4WnBVam4rN0lqUlE2SEF5K04vb3NmdEhQZlNsNkNXb1diVTZkNlNh?=
 =?utf-8?B?Z3dGM2F1a2JBbXEvejNkUDNFLy8vbUMzUXhiRkxzMGFBakRQYVVPM2hMYmVy?=
 =?utf-8?B?dWw3Z21mVU9DbjdCL3RCT2tIZ25ZVGhUS0QwZEUwZ0Uza0ljZ1hSTkJmc2xu?=
 =?utf-8?B?a1VYVnJncU01MDlhUUhuVWl6ZXl1bGlYTWEwQWJXUTNWQVFUaEthYkNLZWJj?=
 =?utf-8?B?RkRSZzJwd21pVUxJYTA2WmJsYWRLOEVPSTJyM3ZRdkZZbWJmRjBHNWxtdDJN?=
 =?utf-8?B?Q1lPczc1NTE4OUVONHNCWDRWMG5ib3FSeGZxMVJPaGxwZWcxZnJVU005WDNz?=
 =?utf-8?B?QWYxUUQxRDc1c1NUOUp2b2pjaEJEbEFyQUdnSk1zTmpxam1YOHVOY2VwM2VX?=
 =?utf-8?B?RTVqTmpaVy9lWTNKOEJIaERHM2NTazMyNVFUbkFLZ01xT0IxSkRuanlVN29k?=
 =?utf-8?B?N2VZc2FPZVVKaER4MEhHZmpUNkJUYzgyd1hsSWdhMFFhT05zK25kN2owUDNz?=
 =?utf-8?B?UFBOUWpxMFZtM3NvL0hKaFNtU2hCeGN0WjdaMEx5eStSSE1NbFhJK3BicWc4?=
 =?utf-8?B?b0NEbytlWW9jcmxHR2xxTWg1d1BXY05jN0gxTXVsVFdIdSsvZHdBWExLWEJ2?=
 =?utf-8?B?RldSczluRDBQLzk1dHhiMjZsR0UxOHQwbStHMlV6NVNwSUR5by9sWDJiZlVT?=
 =?utf-8?B?N0hwckcrdzBsWjhtK0xRRkFlZkRibndrMWl6Umx3aWJjUnp0ZDU2SVRwVHR6?=
 =?utf-8?B?UG1nZ3lyU3dRUkJJdFNaQkxxSTMyeW92dlJFRFMrWFRQZDR0TnNwZVZuSEZ1?=
 =?utf-8?B?dUNiTGpNalBtODJSUVoyRVFDeWxiczZZWis3d3Bqa1VGWE5JTld6bVNPZFRG?=
 =?utf-8?B?Y210b2h2Umpld29HdnB3K0NaTklIUndCS3hFSFpEZUREZTFZSitTZEpNZHp0?=
 =?utf-8?B?WFpqNHJTRDJxa01vMmlPOWErb2hvbVJraUg5RnhMWk5ERXVtOTNhUkN3b2ZV?=
 =?utf-8?B?SHRnMFBsZURJcU9MNE5NaEF2c0hkYTJnK0psVmxRNFhXaytURG1XVlBNcWVl?=
 =?utf-8?B?VURjK25SRDdSSmFhWXMyVDh1Q2VYQWtJTStjemVVMkdUOVAydWRBcFV1L04w?=
 =?utf-8?B?RTkzQTk4VDd1dXZMbFdqR0hnRDc0eWsvcWdORENPRFVGS1AweXVSUUcrN2s5?=
 =?utf-8?B?QUJBQzhFbGZodzVqQXlBelVGeWtDSmV2VWVVTGdhUElseWcxZjE2VFhsMjRL?=
 =?utf-8?B?QStYWUhzc2JVdFFrL3BPTXlQOS9GeC9uQVo5dzZjaW5TMlJMblBIaUROL1g5?=
 =?utf-8?B?aDZCUHB1L0lHMlE0NkpGZ2xETGQ3OUxMMk0ySFQyVmswb25VRjVJSmZXZERl?=
 =?utf-8?B?dG14MHdnbzNGTFJmT1RVUjNyTHp2dllWSWp0bFZKVTBMMTFGcU1lVEpjL09Q?=
 =?utf-8?B?SWU3U1BBWHBFRWZ0MmFOeW4vbUs2OUhPcDQzMElJeU8zbjdWbk9lK1BqNTBv?=
 =?utf-8?B?NWxqVEhkei9aTmRYdUNCcnFYSFQvcGVlNlNrVWwyRXBYMW5PVUlkOUVSYk5H?=
 =?utf-8?B?dzlaNHV5T3VCaldLdTFIcTlOWlpkYnkxeTFHdEJCejRQUjl1dUZCNGJtR0k3?=
 =?utf-8?B?b0pWTWtpWFQ4WCtjOS83VkpybWo4eXhWLzB6am80S1A1MnRvUjVta2N0RGx5?=
 =?utf-8?B?SXpqWGtIOGFYWlpLMkduS1FtV2F0SnRvOGw5UDZscnB3aVpaREZSek81NWNP?=
 =?utf-8?B?UXJnSU1DZ3lJVzJOcktVbDAxTWN1ek0zMkkwZ2FMWjA0YW9QRWc0MnlHbUpK?=
 =?utf-8?B?TEU3dExOMzRhdmJHbDVRM3FPQTJhTDY2ZHdqZTZaVHdQcFJBZTlxa2diU2t3?=
 =?utf-8?B?UW9MMC92UjZ6Wm43bCtuU01mUEJ1YjJwVGVPVlFkajRuVlZuMWREUmdZOC9x?=
 =?utf-8?B?TTM1T0tvZ0FRY3J4cnZVbnFNMWJyanN4QVpjemdsZWV0M1VkNHZZNVR2UTRk?=
 =?utf-8?Q?7nduCq+r0yXOxIakLdmvrNU=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 365ad16b-e2ef-42b6-aafe-08ddb01ffac1
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 17:29:15.5682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hP9qAcoPFvRjmWnQL8q/vr2sJwah+fN6ejwiv2VkZE5uq+GVT04cFdcgG2FfRqqaWlw7C3C2c5UWrP95eHmjIYJ3jGjlMezCamzPbY3g360=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5462

On 2025-06-20 13:20, Gabriele Monaco wrote:
> 2025-06-18T21:04:30Z Shuah Khan <skhan@linuxfoundation.org>:
> 
>> On 6/13/25 03:12, Gabriele Monaco wrote:
>>> A task in the kernel (task_mm_cid_work) runs somewhat periodically to
>>> compact the mm_cid for each process. Add a test to validate that it runs
>>> correctly and timely.
>>> The test spawns 1 thread pinned to each CPU, then each thread, including
>>> the main one, runs in short bursts for some time. During this period, the
>>> mm_cids should be spanning all numbers between 0 and nproc.
>>> At the end of this phase, a thread with high enough mm_cid (>= nproc/2)
>>> is selected to be the new leader, all other threads terminate.
>>> After some time, the only running thread should see 0 as mm_cid, if that
>>> doesn't happen, the compaction mechanism didn't work and the test fails.
>>> The test never fails if only 1 core is available, in which case, we
>>> cannot test anything as the only available mm_cid is 0.
>>> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
>>
>> Mathieu,
>>
>> Let me know if you would like me to take this through my tree.
>>
>> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> Thanks for the Ack, just to add some context: the test is flaky without the previous patches, would it still be alright to pull it before them?

We need Peter Zijlstra to act on merging the fix.

Peter ?

Thanks,

Mathieu

> 
> Thanks,
> Gabriele
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

