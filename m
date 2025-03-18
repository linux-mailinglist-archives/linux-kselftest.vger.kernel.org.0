Return-Path: <linux-kselftest+bounces-29357-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86219A676E6
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 15:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05B8D177878
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 14:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCA320F061;
	Tue, 18 Mar 2025 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="eYfXbwmI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022086.outbound.protection.outlook.com [40.107.193.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0305C20E715;
	Tue, 18 Mar 2025 14:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309468; cv=fail; b=bwEfClSg0cbpw3OCiJ2ptAy1E2z9N0jNcRbKZ1KuOeJdGFIRgi4XpU4dYV1s6RUmSd8J/oFSKOHYmFNFPFYVCK6lpAleWn/JPpCifhR8TWFlD+Jf3RvLSn5+yQWOl3lNNKecsfqNdmRF3r55gkLjlWvomIQ6+toA214IgcvZSUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309468; c=relaxed/simple;
	bh=bS3nsS1QrGReBXLQxKBiDyOpc61soiLMSztlVxIpcEg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q9eO066ri8hHIR8R9IFGzXj5VHWAmZ8AK4nFx6jv5zmnwnxYzZg1gON8YcSEit5d4w5KtRUafbT3IJlWjiDACM6ZBoutE7yrg70poDuQbJb1U4GeLljIUu8jWEkHJJH3yisb/PsDYZMXFf2tyQCDClnO7bYZr+4IJReDJs7xKqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=eYfXbwmI; arc=fail smtp.client-ip=40.107.193.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWaVPoiuuAiwrUH0fgVeUkdlw7FIW0VTTkFzatp2djZ6kh1nFzTKw3qplv0wnMo7FStWHyhF3txr+f27tgDP+s5HLlbBKsQZAGtvWh0b4Wnr68kuRCPvCvzHalZey8oyLiUEuV/FZZOYlz+R+mPJNYlj2oUC69V7J6SEjdSHeXBlMKUv9g4eem2/1+tW7yyzeD7vcsZekzFbF1NWkVchK4x009hvkqBZvmM1sMtpnEhk2RhzVzAznoQcz33Sl7L6bcQtIhpiloomrmlXTtqRyhIPSRdVVZkkdND1oAiJc2lrUXhQH3l5k2jDizbPBo1sbSD1In1ce3uxJUvh2eF9Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37jUfpkAhlKx/ryOWmEP7mSMo1pHvFzGdrPN+EiAsq0=;
 b=aUvxD4nD9h+spEkg9wkpBskYOuVwjaI1BtVtwC2lpOhfHUoyPu36bNRef0enatmq7IPN3fwbzu/jk7xPBQ2Kd8mC3Di/tlnHYilFVo8dF1xGHzg8ZvJ2Kge/472WWwS0JIJGGLItZa2QXTE5EbRR9R7ISVz9nzAns9SlqJKgTnapb0edxsx9azRURsGnKeDs7h30rCph+O002mAPQwkHyndykl7Vec4vzqgroomrq17+l/CTwq4pZvYdU805COKTvj+N6cpP2vVapL8DM6ry6C5alZNYC4QzjDFBqVEv61XrsYyY4y537tPUwxVcUZuDNVxFe3ZyzvqL5SJ6RgLZnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37jUfpkAhlKx/ryOWmEP7mSMo1pHvFzGdrPN+EiAsq0=;
 b=eYfXbwmIDEH6oApG++TrNKf5fUwKl4iWJSDU7obXPmAbbb1WQh2NDkckx/DjFX249msfaJPepz1U8RZZuO/BWV3NELNPupp6igiG2I5UPUP72M0lkF1H7wc/l9FFU+ArN0bdf+DuEo5ekDWSR93TnWStSwRTY/6TYXH5hC/0YcFh3CsGGldTY1HPgQhrxk0UoKDVXrHhpasb1XZAxz3UJFL9DyvJPzETiZBlC6Er9Lf3fQaTin+z/6R3ifAccVGZdboUiUKFFRwVqJwGygZEUCDW5NPj6XccqlKuRdK+EJlt4BUMQ5cgCcvk7/yDMMd7W4UcInPDafFX5atFVMlbGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:24::5)
 by YT2PR01MB10604.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 14:51:00 +0000
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::be09:e1b:b343:7f9]) by YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::be09:e1b:b343:7f9%4]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 14:51:00 +0000
Message-ID: <f61ded41-b1b8-4d0b-aff0-df7e0f5bab0d@efficios.com>
Date: Tue, 18 Mar 2025 10:50:58 -0400
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] rseq/selftests: ensure the rseq abi TLS is actually 1024
 bytes
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 Aishwarya.TCV@arm.com, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org
References: <20250311192222.323453-1-mjeanson@efficios.com>
 <78518446-083c-4db1-8c96-61fd49eddd8e@sirena.org.uk>
From: Michael Jeanson <mjeanson@efficios.com>
Content-Language: fr
In-Reply-To: <78518446-083c-4db1-8c96-61fd49eddd8e@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: QB1P288CA0036.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::49) To YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:24::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB5080:EE_|YT2PR01MB10604:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f7b5dad-854d-4179-cb6c-08dd662c4c2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGRFL3FneHpFNW8ydG1TOENtRzZIdy85dkFhaXBoVGVjeFhOM1RaVVgxbXRZ?=
 =?utf-8?B?T1oxUWNuSGpVd3VsK0Z3cElvOFJ0OGZ5MWdSQStad3FIZ0RjMUFrL3hlblNt?=
 =?utf-8?B?bXlhQWJQcmZpczZYNnUzMTcreHMyVWk5K0VvaHFKVHMyemtnYzBvQTFUU09r?=
 =?utf-8?B?SUIxY0lsMWV1RFRFb2M4M25mUVBqaEVmeGxWTE9ldjg2Q2JoMHVrdkplUjl3?=
 =?utf-8?B?Nzh0eWMxUDhMeTVpNHp4R0VRQTBYazRUK1l5MEo1cmlSM2ZLU2NyU0wwYm1R?=
 =?utf-8?B?alRFSTZDYlo2UjQ0NTZyMTF5TVBIVlp5aWxGVSt1RnNVTWhLM0ZDa1lTSm83?=
 =?utf-8?B?Tm5uVmU5VGFTWmpoeGt5d2greE80T1BYemwwUFlCSkgrRFJ1NldaQ0hKdEVx?=
 =?utf-8?B?UU1LTTVET2hMV0VKOFRwYkk0NzM0d3RrM0Y1UW1BZWtLaGxWWDRSZFR2VXJo?=
 =?utf-8?B?U0F2c0tjTkhzb05ZY3czaUJ4am9YMm9wbHVOZWNtUFhEMjRDa0g2dG43VTFH?=
 =?utf-8?B?aERJUm1xbFJBZ0lnb1MzNmtSVkJEL1lHM1dHWElnRmc3WXoyRmFBUmhIZnBY?=
 =?utf-8?B?czljWTZybGU2NGJvTlRlUVo1ZnVVZ21vZlZJQ2Z6R0FEeVZrbVFKNlJvMHM0?=
 =?utf-8?B?OEV4N1VadVpGbHJpZ0hrcXhDOHM3WHNWc1laS1pjR3AzUDhocVFRUk5FbFl6?=
 =?utf-8?B?ZnM5Wk9WL0RkdUo2Z1RlbUdEQVpuMkZ5QUZGZFBZODFrNElNU0VtM2hMakxu?=
 =?utf-8?B?NlhRaHJjQWt4TU5EWWxnaVJiaUN0SjcvcVZwOGVFRXJSUWFLOFdyV2QvQS96?=
 =?utf-8?B?aldEemNNOWdBNURFL2tLRXprWktYSm9RUGNZcENyc1RJa2JkNFB6WTQ4cUV3?=
 =?utf-8?B?MUZpN1JUbUJBTU1iQmQxZUZnWmtYampPZ2tudjFDd3dvRm42WDRwV0UxbWhT?=
 =?utf-8?B?Q2d4K05hbzRTWkhWMFZObXYyeUpVcWczdm1PNzd2QmpRWktYR25iT2tIbXRY?=
 =?utf-8?B?ZllPbnVsQjU0NEJrVmJlcVhXcHZ0U2hqK25nSXVEb2YvZ1NOTUNFQ3ZId2U3?=
 =?utf-8?B?bFVpTEtBWFhhd29jZlptbnBrWWJ3b29veXVWRG1Ia1BValBRUGV4c0UzRGlw?=
 =?utf-8?B?SEYzc0xJTXdlc1NEd09KSG1kK250aC8zNWs4MThzeTZJd0tQdmF4SHYybnFv?=
 =?utf-8?B?REd4czk4eGI0c2c1SEtQVFN1VUNEZFhrVzhtRXU3akRtMmM0VktpVXZkRjdT?=
 =?utf-8?B?VWwvTVErRS85clhWZEpmTTI1cWFlSmpZOU9JNlRMSmdob1F4WW1Pam1ZR0xC?=
 =?utf-8?B?V0FZM1gzRUZseXJYRG9mRmc5eVlXVkx2bFlTYVphb2FMZ3JyNEFXRHIwTDBq?=
 =?utf-8?B?SS9FNVE3SFZJNUozdklHYXFTeVd0T09pTURFUzgvdTVkb09UQnpuSnRLSEtJ?=
 =?utf-8?B?eXdNNW5qekFmTkxMMVVVcnBjdjkzaTlPV1RnODJIMmVxd0sxTEgzSWpWUFBT?=
 =?utf-8?B?aW9LeWc3d21vNnpZYVZ3cnZnR3ZNbTlyVG15MWtNMGF0Ukg1RDRVcXB5bDlV?=
 =?utf-8?B?dFJrK3Ara3JpWFdjWlEzZU96S2NmSEkwUWhNTW14cFl3akVEdU5kYjE0V25z?=
 =?utf-8?B?ejZhY3VRUDJ5TGJ2dDVCK2JERmdSN2ZGcWdJVCtNQldhMjl2UVFCSTlWdFBh?=
 =?utf-8?B?ZXAzM0pkTmNYQ2VmZHBYNG9xT056MEMwKzhFRXBrakNieEU0dzJ1eDhzUlM0?=
 =?utf-8?B?L2VYdkxSZ21BaHh3dVBIZGt4VkIzUHBPSVVEVC9tZU1ib1BobDdsNXlNajFP?=
 =?utf-8?B?L0liVlZQSTdQakdldVNFSDJ5OFNCN2xuMVdvSU1QaTRMWWRQT08zTGVEWHNU?=
 =?utf-8?Q?Tiys2Jufo2I27?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2paSWh3all3NHRKN3ZxYmxtTWdudXhtTVRKdzhWTTZyRHUyK0FGK3FIck1O?=
 =?utf-8?B?MjMzSmp1Nk1XcXJrekpTZXRZQU9oY2VMTjI3TTVZb29CWUI1NXY1YlVGNG1H?=
 =?utf-8?B?cVdPYUdyd2JPZ2lSR0MyMTN5MzhKZitOVllKaUZucHRHMjFpU29UQ2hTMko5?=
 =?utf-8?B?RFNYVGdoeStUV0NPZGZrUjJIRVlNVmYvYlFFSmlvUWlLMTB2R2FHMENFU3Y4?=
 =?utf-8?B?dTh2dGNJdUpoMEo3dWF3aEdEaVBOeFNNNHI2Tk92NStHTk84dEdSUXdZUDhB?=
 =?utf-8?B?TlRLWW94MkZyQndUSituUlZFTk1RWEluNTcweWlIVzFZOXlTNElhQWcrd1FB?=
 =?utf-8?B?ODJ2ZlRFSWhXVXFwYnRGVUtQZ1BjWnZBazVrbXM5ZkVWenFSVDVsVXAzcDVy?=
 =?utf-8?B?eVg0a0c3ai9pUDc4TkZrbHJTcm5yUXdSR0RUdThYVDhrZUhVaTJScEFTalJH?=
 =?utf-8?B?WEFrVExCalI1Q3lCYWVWRWhMeHczeU1GY1htRmlKejR6SWRKUko4SXRWVk8x?=
 =?utf-8?B?anJ0V2FRQXVvZXZNblMwT3RtQ09lOUdocGJKZDZ4NXZKME5pazIrY2JwYTNN?=
 =?utf-8?B?Ri9sT28rRERFV0UwMVRPK0NHdkxaZVFMSnl2ZDdEajhCRzl6L2dqTWFjRUZw?=
 =?utf-8?B?VXZOTFp5ZWRNcXlPOE90akE0QXlKTjVxUHFNTVFkd1FwbFB4UUFkaG5uL2s3?=
 =?utf-8?B?dWdSYk81Z3BSSm9LNWg0d1Z0eUFTNGhtUUcrQ3czSWR2N0xRempvVDIyM0M5?=
 =?utf-8?B?TVI4YmhNMmhkbWV3YjFYSTM0S0xQc0g5eks5MUlQUEp6SzhKVlo1T2RNcE1w?=
 =?utf-8?B?R2tvbkFzZ244cGJaZENxM1FYbFNpTWhYZkxoRjhORVpuZldIQ1RnT0FvVFoy?=
 =?utf-8?B?RFgwZzdUU0t0ZXA0OTQ4SFlmQmd3c3ZsZ3dCSFcvUmZxaGswcFUwaFlmRVY0?=
 =?utf-8?B?QU5wbmx0QUpicGQ0anVPczVxMGJudTZ3ZWFUbkE5T1hxUWxEUjNCV1M0UjZV?=
 =?utf-8?B?d3I0WEI3cG1oU09BdnhLdW1yQ3dqVnZ4RzFLZGJON3NTN0k3UjRTRVVVbGdm?=
 =?utf-8?B?Y3pxYkNoMzdzUGNHbmJqcmtQRWQyVjhPL3BvUXE1Zk1WZmFESExNdmJianhZ?=
 =?utf-8?B?ci93ZVpqdFJYNEIrZmFCVWQvT2t1M1c3WVhRbkIwd1RyRHBVRXB4ZWF0djJY?=
 =?utf-8?B?SnY5RURXR1REZjJhQUw2YmpEbDNzakViKy9YOStyK01ISkxVY0NBMFRtNzJy?=
 =?utf-8?B?WG1zYVg3R0kvdHE5RUNKYjBLNEQzd2dYMmZzMHJleUZqMGMyUnN0bGpvRXBN?=
 =?utf-8?B?VEpuTDE5ZzYvQVhDWFdNdVU0ZFIxUkdWWDFNd3ovM0pVWGhyMUQvY3RTbVFX?=
 =?utf-8?B?dEhlSTkya2hBbG9qQW9pMUQrZzE2YzM5YTg1cHNIalN5Q3ZwSEhnbzJQR21h?=
 =?utf-8?B?MXFsUmlEbERFYUJIblhqMWoyT1l4Ni9tcUc5eC9xQ3hoT2s0VWZJclg1ZDNV?=
 =?utf-8?B?MlNDRGZBME9kVTB5VzdHekVOSHU1T0FmRXArY2xodDZ3bFZFSDZrL3paL0Jr?=
 =?utf-8?B?N29aTnVqbzZLYzF5YU9TM2FuQnhyenJhcFFUWXpzQytwUjhVN1NLRy80ZDBY?=
 =?utf-8?B?bnlJVEdCZ3RBYnpFcmwzMmZMTGNmVzEwc25wL09rY3JLcEtFVVUzKzZIVGpE?=
 =?utf-8?B?OEtuSHUwRkdCQ3FqWS9hZ1hWYlZaRmpNSU5jdTFrNVJZRDA2WW8ra3ZuZTQx?=
 =?utf-8?B?UFNPbTlERVY0YzI4L2ZVQ2pieElRS0lEN003VE9jZG41cGRzdUhJWmptYU9n?=
 =?utf-8?B?YW9qOExWcU00UXM1a3piNG5tQng4MWMzblJ0dFQ2dzhzeVNnK3BHZXJnUHVa?=
 =?utf-8?B?K3NjTitFK1JnL2Q0YW1vUnlOcy9JZjF1MDdmbC9lNTArS1YxclUwdHFEYVIv?=
 =?utf-8?B?bTdSWDZzK3hzWGJ1QTJUTU96WE5rNEhydnNBNnhhYldQTEd4czdOdENLNmo2?=
 =?utf-8?B?ZEZ3WVF2V0pjZG44NHBKa2xZK0dSUGhWRTlNQnB3M252KzVSc1k3L1kwaW9O?=
 =?utf-8?B?ODBXaDU1OExwYXlSSTBYT3k5aGM4Qm94LzNiR2pSeW5XWUtpTmlDS1F5TVBJ?=
 =?utf-8?Q?1jQHreBNcSgau72JyWX41IB7W?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7b5dad-854d-4179-cb6c-08dd662c4c2f
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 14:51:00.1573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSHCHaJOzEZJ5+mQOC1/eABUskWmPOx0YZmuA4tcvGwo0KD4BqgYu977NZfgncFHXraYucXMPpsxXsQKm5VH1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB10604

On 2025-03-18 10:01, Mark Brown wrote:
> On Tue, Mar 11, 2025 at 03:21:45PM -0400, Michael Jeanson wrote:
> 
>> Adding the aligned(1024) attribute to the definition of __rseq_abi did
>> not increase its size to 1024, for this attribute to impact the size of
>> __rseq_abi it would need to be added to the declaration of 'struct
>> rseq_abi'. We only want to increase the size of the TLS allocation to
>> ensure registration will succeed with future extended ABI. Use a union
>> with a dummy member to ensure we allocate 1024 bytes.
> 
> This is in today's -next and breaks the build of the KVM selftests:
> 
> In file included from rseq_test.c:24:
> /home/broonie/git/bisect/usr/include/linux/rseq.h:62:1: error: use of 'rseq' with tag type that does not match previous declaration
>     62 | struct rseq {
>        | ^
> ./../rseq/rseq.c:78:7: note: previous use is here
>     78 | union rseq {
>        |       ^
> In file included from rseq_test.c:24:
> /home/broonie/git/bisect/usr/include/linux/rseq.h:62:8: error: redefinition of 'rseq'
>     62 | struct rseq {
>        |        ^
> ./../rseq/rseq.c:78:7: note: previous definition is here
>     78 | union rseq {
>        |       ^
> 
> since unlike the rseq tests the KVM rseq test includes the UAPI header
> for rseq which the padded union conflicts with.

Oh, I missed that, we need a more unique name for the union.

I'm unfamiliar with the workflow of linux-next, should I send a V2 of 
the current patch, or a new one that applies on top?

Thanks,

Michael

