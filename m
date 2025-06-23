Return-Path: <linux-kselftest+bounces-35611-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE627AE3CE7
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 12:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 296EA3B996A
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 10:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5389323AB81;
	Mon, 23 Jun 2025 10:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="iXbOT6zH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2101.outbound.protection.outlook.com [40.107.93.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699B6182D2;
	Mon, 23 Jun 2025 10:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750674716; cv=fail; b=tDnwogtfJNaM1FweoviaANGYk/c36sA20mc8ZM+P8p8LA2qO8TolcvhuIxwTytGXK7hYYOuLcxBUF267IFFwkW4iO3FMA6JTTa9pRNLt9gsY7hjGdG07o7ITWT0zWlX6EwFUHD3zQk2uqCT+lUSEYZx0ZSFWj13e9Ex4vR6Ykak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750674716; c=relaxed/simple;
	bh=c5vozeJYVAdKtzrgRkAtPUe47ggxz9CD7y+PtCBtgj4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nO2t5/EkxmhdfFZ/tsIBkpDcWwJ/AH9QSNxNO65A56vAbqIdtP81/uupjfvcvoalI2o9FSeUG86+ZF6tvCJ0Ews/TVJCWnmux15vT/lJcj3kLjmZ4VzBqkMQlUi3oGbr2KHJ4ThlTe0BLrH4we9+apyIbFQz3P50dwmeauj1DEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=iXbOT6zH; arc=fail smtp.client-ip=40.107.93.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vcw4sFXJdC7bl4w1pKMQMcEz5mCGWJQtnqCPcM4cCcxOk0yfPdA+hkNCtMgUEWqgl6ASnFQeKA9PCEfDlokcxaYv+QjHZuKCIs9YSFmD01BhIEjRP7zlA0ZGtiMwjDeHi/+eg97oI/TKckQ5OwLSIoF91b4ykfOR4OuaJ2soylFd0n2mHfn/JRJxmVm+rHagIHDjU3ZEoutz0QLe5Z+XDqX6H+7wDnrFtPWUf40jbeWwl8+FJtAcGEWr0IviF6ef7vknDkZhf3/nKgjOL3TKExY68cFHJ9nR4pRYOEILBd18vk0WKbNlK82IkK3qyOFYwlZ4FpD15taxmURhIV5qSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vj2JHtiUqD0TmEQV+F3D/1KJoVBluNUGJGxw/fTcwQ=;
 b=AUCoX5H0xCAMtGBL/IZgC0a1uBAuixtKZR2zHgu/Bq2+pFqng1W8ut7dGMZcntFHVydRC75i0gPOTF4RwF0P+Qop66T3oz+NIUiJNBgbzBqyYLGyaBsN93U9coD7EaBK93MJPAK+7X6KV8dwGw42JmU/xS0ziv3sWlUfjCb+2mUEsjcX4ekYtk4elbFibCCS5b4C7w3qClA96yTQkx8buQpSJWn6IQCDAZhOKoM5DD4xPSIgOI129/Ldm9LZJXjDFWly9gk99Z0IaRfw2kZD4NLWUE5Qq9fsDZtotl6EoO0mk6lYAgrsFIsI5OvWa1wlQifiURbIj0bu2DC1t65vWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vj2JHtiUqD0TmEQV+F3D/1KJoVBluNUGJGxw/fTcwQ=;
 b=iXbOT6zHR/GEtCJmpBk6NGQtDY6pLPirAr+xiN851LdlPCDZ2CSksnw/PfeENBTlk8BK8LnfwQO9lhWHSlbjlItyjQAiY/+ffShffF0/fMWhL/wMJe/A8Cbt+hKe+xR19zoLJuCT3cMLxiJ7lvK52gxyPjAR9KgA9VDjqKtJHAI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 SA6PR01MB8808.prod.exchangelabs.com (2603:10b6:806:42e::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.26; Mon, 23 Jun 2025 10:31:51 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%6]) with mapi id 15.20.8722.027; Mon, 23 Jun 2025
 10:31:51 +0000
Message-ID: <9d5d82f1-b488-4b0a-98c2-27e95d63fc5c@os.amperecomputing.com>
Date: Mon, 23 Jun 2025 16:01:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/9] KVM: Enable Nested Virt selftests
To: Marc Zyngier <maz@kernel.org>
Cc: Eric Auger <eauger@redhat.com>, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
 suzuki.poulose@arm.com, yuzenghui@huawei.com, seanjc@google.com,
 darren@os.amperecomputing.com
References: <20250512105251.577874-1-gankulkarni@os.amperecomputing.com>
 <92c7e99c-5574-422c-92f1-62d5cde58fec@redhat.com>
 <7bf7bd52-7553-42a7-afdb-a5e95f8699b5@os.amperecomputing.com>
 <86a56veiyy.wl-maz@kernel.org>
 <3be548bf-aee4-46ab-bcbf-15bf629b24da@os.amperecomputing.com>
 <86jz58c5ut.wl-maz@kernel.org>
Content-Language: en-US
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <86jz58c5ut.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|SA6PR01MB8808:EE_
X-MS-Office365-Filtering-Correlation-Id: 33b01b89-c3cc-406f-360d-08ddb2412a3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2dITWZKcWxFbDFhMU5pWlhWRFdPVWYwbjNGbUdRSXVIWHhGeEp3TituNm80?=
 =?utf-8?B?Z0k4UWdwRFNHSUxIRVJmbUZZeGVMSnBabnNuWHk5ZmpwYzV3N2pZdjlCUDlB?=
 =?utf-8?B?TnZtQUZ6bVFsMkw4UnMxZkNlV253U3AycDJCNGlYUDZ6NlRPd0xYL0U0UDYx?=
 =?utf-8?B?d1ZaSVAvZGxrQTJTMTZIMEZlZkJGK1Q3dlpVU0lLcmtkTzBUWWZyOUJJR1ZM?=
 =?utf-8?B?N1Y1cE5vTWxJQWlBMmM1ZFEwTHN5cDhNRXVMUXRNYzJmMHgwcmx2dUVGbXFR?=
 =?utf-8?B?Q2F2ei9yU1pQcmlTNDc1em4yeDhUeVgxQnZqYU4rMEpHRldtdW53L0pidHY2?=
 =?utf-8?B?TExkNmFrQ1VpdHA3NlVSaUE4eDlXSmhBTzJkbTA0QlpzMW84QWV5NXpkbUFx?=
 =?utf-8?B?WmsrNEJVRmdFM0phem9INmpaNEpEMFdFenJWVm05QVJPRnNnYUxuZFRDYU01?=
 =?utf-8?B?OGNHSTBEdWxYSzJsRXdJMmN0SGNZNncyamZyM202cTI1NjJLQTFnR3BNOVlN?=
 =?utf-8?B?U2tCVDN4cjFaZ2ZtbVRmNE1oWEFnOTVwSmtpd1dlcWFzZnBVVlZpdUg0R0s4?=
 =?utf-8?B?VGxDMFp1RmJBamxGVThYR0JKSmxheVY1RnptaDhGYUZnWEpiS3piT2VOZ1Rj?=
 =?utf-8?B?SFFaT01SdjBKMlRidVJXM3VPRzlHTUQySWd4OWRUR0xDc0lDVjFZckRzcVRJ?=
 =?utf-8?B?eFJLU0tMUmZPaXN0VVd3OUlIK1E5cmJsci9iRGZLbXNwOXlwOUtuQWQwSVo1?=
 =?utf-8?B?WGRpMU0vN1hzY2lkVko4UGtZRitWVUpnVVg4SlN3S2w2aTYweGdqcEVleGcz?=
 =?utf-8?B?dnB6d2ZwOG9vS0JyQTUxa0dpbkZZUmJ5RW5lNlRHSFpZSis1QkZFaVpCQ1lX?=
 =?utf-8?B?OWdxWG02VkhLN2RhU1RDcDR4RnBudUx0ai9ZVCtIWGpyOUkzN0ZpNzJlNkpx?=
 =?utf-8?B?Mmk3d1RaemZZL0o5K2VoQkp1WlFDK3pVSnE2T0d6MFdFZEdzWHNON2lUdks4?=
 =?utf-8?B?bFByQ0ZXdmROeUFrUDRITjhCRUc3dzhwRnhMeHRVbTNva2VhKzg3a2xlRUFV?=
 =?utf-8?B?bys0S056TkV0bi9ERG5VcFJDZk90ZThxRzRVUVhOQURuZmUrRWxUOEF3RzJa?=
 =?utf-8?B?UFJiUGtabkU1S1lXOE9rL0JYcXVNb3J6UEl2SkhYN0xraWlqQVRTc3ZMYzBR?=
 =?utf-8?B?U3BkZWczZ1l2SnNKYy9XTkJzd0lZV04xekw0MXhnODlJekRJSHpqQmhnYTVk?=
 =?utf-8?B?bnUzYVpFMnN5SEJUaFYrM2QzaXN4OGFrUDUxcEJhOVhXdGNNTlNPQ0RqK0g5?=
 =?utf-8?B?NlZOalRYL1pDUm82WVArZ1ZtS21uTlpkRDlFS3dnUU1LcG1BNThVSktzWTJU?=
 =?utf-8?B?VjlEQlRad1lPNi9BY1RBTlpNcDlsRDNuWkF2MjBUOXp2MkFPSjZRN1loOEh0?=
 =?utf-8?B?aTVGbUZFOWlHaXRDb2lzZDFTUzVPM2IyVzk4aFp1ZEZXd2pqS3VRRU9rMDVF?=
 =?utf-8?B?RlJBNWZ1WkdGYzJMSUQzZFZzUSsvaG9WK0ZnM2FINmQ5S2ZOOEFndTNXVXhv?=
 =?utf-8?B?S1JSTk0rWUhzU0E2dlFUZGp6NE14ZjM5VjJ1Ykg0TEFqdmE3ODhUVTZnSVBE?=
 =?utf-8?B?NmJ3WURVMTU0SGg5bHhNN3RyemxNTkRDQzlXQnVGaVRwSFFIbTVpZjlzZTFG?=
 =?utf-8?B?NHNjVG05aWQ0UzVhdXEvcnA2QjlmOStTbHRhUXJLT2RtVm9pck45U2ZvWU8x?=
 =?utf-8?B?Rjh2NmhxUFduTnFQZHRGbTRSTFFTbGJ2MTZKNU50YzgvWVBFTDlLZ0JYMTJI?=
 =?utf-8?B?cEhDUGpyNTUyaUtEbFhtTGhhemdmQmxSS0FGVG4xN25zWVB5VHJ6MEV2WlZS?=
 =?utf-8?B?Rjd2QlBUTk01NWwwdlgxakhZcTRxcHNHRTd3OExuTTAxUFQ3bHpCa1cxckZo?=
 =?utf-8?Q?7rypgTDbicw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWp2MWJKaGlRMURXQU1BZ0R0eVhqM2lNZmc3Vk1nUkFLUXFiM29Vc2NLR1VW?=
 =?utf-8?B?cU5QS2FiZGtqbDBoY2ViNUF1Q3lVQ1cvK3JDMTVnY2xJTE5aTi94V1E2UVFQ?=
 =?utf-8?B?K21JZXhJQ25aS29xVVJ6YnZBOGp2Sk9YRXV3TGpPQnF5K2V4ZytTUHlqZGRK?=
 =?utf-8?B?N1lXRnJPUzdMUmEyZThLNXptMDMvK2VxNmVacmExckV2c1BDUytDRUJVdzQz?=
 =?utf-8?B?aTlQYWN6aElxeDlHY05BSXpERjcwSVROZ2VMSDFYcnNnc0ttMkJQTytEamZU?=
 =?utf-8?B?L0xNaG0zS1N1ZHRXc0RKdm9mWlljMlBPVmgxRkJyVHhvRzl4VTJjM2R2TVBK?=
 =?utf-8?B?ZDhydDJVdVNMZjZmSzBGc3NRNjRuVnN2QS9oTmxEZnNMeFM0WjR5NStRTlMv?=
 =?utf-8?B?a3h5Y3V1Mm1pcy9KeHUxUWNTQllXcXYxUmp2VEhaMStZeWFybGlCekZ1bUhv?=
 =?utf-8?B?bXJ1ZTFqaVBnbEhPVG1zaEtWd0ttUm0wNzFjM1NhMUdkeU85V2pydHFHVGpu?=
 =?utf-8?B?U09hTGlPZjFzeFY3N3JaYWNxVVQrSHdTSDBoUS9wbkh6Ty9OTWZsbnZqVVBh?=
 =?utf-8?B?TWF0U1h5cU9UUHdIMlBXbENjTlc0UVRHN0NZM2xtelhISit5U3dXdjJEU3d5?=
 =?utf-8?B?SmkwYWQraXIzZjFrTThGTGEvRmI0QzhLWjJESDd4RU5SNk80S1NkVlJ3M2h4?=
 =?utf-8?B?NXVlakpYY0lhS09yWnBNdFNVaUw1UVRPN0RBMWhjNTVqWlVwOXpXVEViWjVu?=
 =?utf-8?B?Qm1lNDh1UmVhZnBNQWFtMkc3K0R6dFhsd3NuSnhaOVBmdENxZEthQkFXNCtI?=
 =?utf-8?B?aHoxTklOb2tQeW55dWt3RVdmSHYzK2JDVG1IOThhV3pEOXZGTDlBdDVid3cy?=
 =?utf-8?B?QjJHcXkvNWI5ai9NbzVISVY1anhIOWlIVndjUnk5Wk95M3AzekYzTFZveE5u?=
 =?utf-8?B?R3dWWUR2elpkbFU2bnZEaUFGSHZPbTgrVjRzamtGbmluTjBRQk1IOUYxV3RC?=
 =?utf-8?B?bk1ndjNmYURKNzJKUmhiZWRlSFBWSEp4ZjdhL08zUExtL0IyUy9rbDhoRE9r?=
 =?utf-8?B?UHV1aDFXamFORUFjV3hMU09xWTd1RWxaYTB0NWF2c2ttOUwvMVlPdE1UWTg5?=
 =?utf-8?B?aWlaR0dRRklFUG5DL0o0dHB3MDZIMUNhUW1xa1BDNG0zMmgyZ21sZmI4S0cv?=
 =?utf-8?B?LzRVbzYvOHAzbTJ5ZVNPeXY5b3VYemMwYzIwNVY1RkN3RmR4WTg1YTNzbVdC?=
 =?utf-8?B?MnNtSzA5WXFrUXl0OFlZam9yekRvcnRBT1RxWUlad0hxS1VPdDRDVGR0YU15?=
 =?utf-8?B?UFZzRWQ0ZGVDOW5CSXhMcE15YWtLY3lSbVB2YVJKditHUDNQTThjTzB4Wkli?=
 =?utf-8?B?SDFINFMwK1ZMeU93SWFJN3BWNVdBM1lqUURxRU4zZFNzdGtycXFqbkJXOXVl?=
 =?utf-8?B?OGpmN0xXM3Q5dDFNdlB6ZmFKeTlPeGkxSzhyb2lrU3lPenlVV0xRZFk2K0dJ?=
 =?utf-8?B?SEsySTBJajVlZjNqb082SC9xTGhRUllWeWtIL05xNXRxa1JLOWU5N29KbWYw?=
 =?utf-8?B?dWpxOWtlZ2pNY0dvOXFIR3NSR25iRDVRZHRSaWFuQWtwVWxXbjJpbXFjb3Fr?=
 =?utf-8?B?MXJYYjBPcjludGg1TEV2S1M1SlhMRlZMYjJZVHBiWlhsbUFMbzM0SXJRa280?=
 =?utf-8?B?QzNBTVpMRTR3TkpjYVdBOVpib2g1eFUzQTlYSFRpT1Zyd2o4cis5UnN6c05x?=
 =?utf-8?B?eG14UFZVRXdHZjZpZGNjdGdTZ0NLWTNHSXZrVkQ1ZmpSTWh5cy96MWYyNXMx?=
 =?utf-8?B?NTJtRCsrempTYXBJeWhBOHZXeXRIWmZmRTg1cUFpblgvWnJqcFRhenhXZHBr?=
 =?utf-8?B?QmtyVFpjeEx0YkszN085U3Z3cmVVakw4RVBTWXE3NEtHQnlWUEFLcGk0bVFC?=
 =?utf-8?B?eFdiVkdZRW84enZqbmRNNDd1d0JMT3BXNXNGUUlZTWVrSmVaZVYvd3FmSmFk?=
 =?utf-8?B?Um9KQzdMVWRJa0NUTER2QWNwNWRmeHJVSjc2TEtjM0Q0Vk9TckkrRlUvUUNE?=
 =?utf-8?B?Rzg2SGYrVUpQU2EzVmdsOW5zaW5SNVpPSVdHMGpCK2ZkNm53eExkOEliSnRj?=
 =?utf-8?B?YzNkTm1nNWI1UFNxL2x5L3l1YVF2M0dEL2ljNFRJK1IvenJNaUY4Z2RqaEtG?=
 =?utf-8?Q?n8cWC1fdE8IoNWeoJje3ibo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b01b89-c3cc-406f-360d-08ddb2412a3a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 10:31:50.8775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xLVOFzQP26tSslH4INOlhnTbah83aVeQMufI4uPd1yJvFoTHjeI2KJRSVtNHQ4qvtIDVfC277lGSis5Vw9iXmG4orvKQOo45S44feUIzhNqQ6q2YZ89MYlJcPYw1VvUL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR01MB8808

On 6/19/2025 5:15 PM, Marc Zyngier wrote:
>>   >
>>> Also, running EL2 is the least of our worries, because that's pretty
>>> easy to deal with. It is running at EL1/0 when EL2 is present that is
>>> interesting, and I see no coverage on that front.
>>
>> Sorry, I did not get this comment fully.
>> When we run selftest on Host with -g option, the guest code will run in vEL2 as L1.
>> This is implemented as per comment in V1.
>>
>> When we run same selftest from L1 shell, then guest_code will be running in EL0/1 like running from L0.
> 
> What good does this bring us if we need to boot a full guest OS to run
> tests? What we need is synthetic tests that implement the whole stack:
> 
> - L1 guest hypervisor
> - L2 guest hypervisor
> - L2 guest
> - L3 guest hypervisor
> - L3 guest
> - [...]

IIUC, selftest leverages host OS support and uses various IOCTLs to support the guest_code run. Are you saying to implement all this again (without OS help) in guest_code to run it as hypervisor and launch guest_code2 as NestedVM?. It seems to be complicated, doesn't it?

> 
> This is *one* test. Not a test that runs in a guest. That's what I've
> been asking since day one.
-- 
Thanks,
Gk

