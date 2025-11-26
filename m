Return-Path: <linux-kselftest+bounces-46488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B00C0C888C2
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 09:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FC2D3A99B2
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 08:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B423E2C21C7;
	Wed, 26 Nov 2025 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EnXbDbqA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013023.outbound.protection.outlook.com [40.107.201.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FEE1AAE28;
	Wed, 26 Nov 2025 08:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764144390; cv=fail; b=N/wp1B76CwgYOXOlMmJ/hEZLfpGlhardO0AFkdkxytZy/V9W3dhld09wep54I4o7tW4IJiiS3IcdjINmOM23qIvhcezI67ztJMIifYA8f2/HhrZ4Ft6cmhYFW0KieUD0JthYsLQ37u1rqBWRHUOvdkZINCaCYPQYJ/anZ/kNEJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764144390; c=relaxed/simple;
	bh=UdTDyRO/QlezYYSLHNr+tuOGlfwxfGSPDCLW7S6teEw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UZ7bI+xKJxS8oZ/UFGCFf27wg8mgSTTRSs7d/NU4uxPF2CyaGe06yREkxEIxPGyGhdBm8emwO0zqH43JbACxRKoR8BMHg3Xme6noYLS3AyX9mjTPe/fAKVoX9ozwaVTeLYVZJH/roVlagXpS/wWs9q+nyMajlXj1+x1rpnNIQEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EnXbDbqA; arc=fail smtp.client-ip=40.107.201.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kg/BeNjQIoMtNIX8TyG5auW4m+JNdHJqoDariPI9gSdiRyZ0XlfDEf+DEHSqDTCcwdIyEDULPf5XH9FWXE9wmHmQFIinfTzDSdlfuomh1sc7BMx52mweH5KqzOlzEiVXv8i3jboVHvMcvqQNcQmszTnh3CW7g4qpJg9onlem1WNfTtFrnCrO03J13cWC7lCql+cshMjq3YlEI06TyFKVRBBWRiZqAIKyeqHuVynJ4JDKqBjUq6gvzUlzks2olpLeP/2AujkbAlBevWk2YgBMscFJeAWB7rFGBi8pN1U7aka8tlHSrFfPHp5eZfKcKMXMP7kTyX3MUTWShpu9HivvHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdTDyRO/QlezYYSLHNr+tuOGlfwxfGSPDCLW7S6teEw=;
 b=QQV+FWAGJGXm6nOVJUG7GWwVL3bgP3Babd4uYRDqj/mS6MkjJmjmsKdb/0oKLIqXAPqfdtms9yVDEVHvNawr2TlCeODqx8WEj3pryX4TdcnTyJ9YllVRc3+hzdniy0RRTrY80huukmIHT1ZBscwW7Yz0hTPzoCzddjev+J5b887cYqvWYG9eKwEuLGpL1pRSjkNJlSFhNO9BBOAszkR4mPxvEuf/wfMMt/3YPRS1lsUKbZjO1TJjdL0IeHzcEgZmOLE19EpiYbljucYEviKy5tka2NcotQdJwVwUyxvQN8zWTctUT0FA3bZdWgOAzWGTP6lXCVCTiuuGcUnNha7IsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdTDyRO/QlezYYSLHNr+tuOGlfwxfGSPDCLW7S6teEw=;
 b=EnXbDbqA/K/4SyJlhP+NXVLuxARUgbycYdM2yxb96rQr/5AfSRn8tGo7jQLmPQci/maLqxcY7sRanUFcxuKEZRjPl/X9yGl3ho7nJFUiNQb1u/b/tK+zFrRWZiZ9wAFwv/KTP3iNPPskvS00X9YZAz+OWx/SH+ULXeT0cf61m/e0eYWACnHUWb7Cjmdo7ZjmTlgZtxaihHjKbNEEbaqcEfjEn/DbRO0V2pchcYwBYs+lBuU/i50gfF+Bfg2czqu+gGckaBq6ZGKHcr9BBH02Skhs9YCH9b1VBV7adHjdQGnBukuySf0nw9H6C4gnBBpcRHMmA7t7jILIYWsMvmfyhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by CH3PR12MB8283.namprd12.prod.outlook.com (2603:10b6:610:12a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 08:06:25 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%3]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 08:06:25 +0000
Message-ID: <d81820e1-21e0-4c59-8532-ba55ac47c6fd@nvidia.com>
Date: Wed, 26 Nov 2025 10:06:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 0/6] selftests: drv-net: Fix issues in
 devlink_rate_tc_bw.py
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
References: <20251123171015.3188514-1-cjubran@nvidia.com>
 <20251124191026.1438551c@kernel.org>
Content-Language: en-US
From: Carolina Jubran <cjubran@nvidia.com>
In-Reply-To: <20251124191026.1438551c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::9)
 To MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|CH3PR12MB8283:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dda72a1-e5fa-49e4-4eae-08de2cc2b17c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alVHWnpQUkcyaXBIditPMU1JcnhOUDViNmNBNGs4T1FjT1ZJMTdVZXFzeWxR?=
 =?utf-8?B?OWUrelR5VXFJVlBadllPUXhlR2hHeG90bzlnTFlySFp3OHVudjhsaVBOb2lE?=
 =?utf-8?B?aE96OG1mWlBwcytYd3Q4UU16aHBPcmoxd0hlOGZTVTArZjFqZ01HdFVTS3RN?=
 =?utf-8?B?QVJzajdXT3Y5UCsvSWhKM05SR2RpTDFHQVhZUHAreS9uVnNrczN3TEZNdlNI?=
 =?utf-8?B?Z2VRa2tXMmxkTUtHc1ZrYTE2Umw4QmI0SkFER0lmL2V6ZjliejZEanRvN0RH?=
 =?utf-8?B?YTRKTS90WlR1Um80OHRMKzlnNXhpaGdSTVdsd3YzWmwyRDcxNUlzL0VWVFBM?=
 =?utf-8?B?MW0rWHd3cjI3d2k1bzZMZFJlZVN3MUkwODdud0x0NFljQkxTaVFhWHZjU3ZU?=
 =?utf-8?B?aHh0aG93T1JqY21EakVBZWdjcVUydjdwNWhVcG5vNmlJQ0Q0NTg2T09nMGFt?=
 =?utf-8?B?SENDOFl6Z2JpbHNlaTAvZnNKaG9PR1ZxRnl3aC9wWE5OWVdielk1amNVSEY5?=
 =?utf-8?B?endpY3FNSzhwd2hEVmRDTU5nQkRuNGR2TVVOaUVhazl5T0ttSWF6YUtKOVRz?=
 =?utf-8?B?c3JHKzQyREdZSC9Ddm54VVRnWXMvSVRnTWdRVjV6LzVvK25XU1BmaFo5elM3?=
 =?utf-8?B?L0FhLy9oREtUNmpYTnUvSVBKZG1QM3c3SjJxUW9tTnZYNmZYRFMxVllsWGtF?=
 =?utf-8?B?Wi8yVjNFaWNPY2orcGJ2ZUZDbElXbjFJUWI3UVdiTEdvNDZKNS9SZ1graXd0?=
 =?utf-8?B?alNaNnpyS3pVMnhBNFhyYm9ack9uK0tuQUpVRE44ekduSUpibDNYY1Z0aGYr?=
 =?utf-8?B?TjNieURhQXdDSUJYdFhsSmg0aG9JSFBpNkY0NmZtUDlXcEpKOTdNemFGOVI2?=
 =?utf-8?B?dkFnQTI2bTFMbFBPRXJOMXBFNWFsam8xcDRMVzZabkpianRWdktDTUpWZG9I?=
 =?utf-8?B?Q1pvekgrNzEycGNEYWRVUGRlRExUL3ZpVmZNRWJsZEh0U3dwSFhNa2VIMVlO?=
 =?utf-8?B?YkhobmlvMUlSSzNTUTJ1ejl3WVNGakR3eEVtQllEM3g2dkYrc3JISmRVam1r?=
 =?utf-8?B?a01kaVlweUk3QUZqd3EzRzExZzZXWG1nVzJXcCtpbGpvcmJBT3p0VXIvd3BK?=
 =?utf-8?B?aWJqbWNkVElYdU1YOUJzS2ZKU29ubzZZVDlVYVlURUFwZzVjckF1SVlDc2ow?=
 =?utf-8?B?dlp4SWdLMUF4bmd3UWFjcmd4cWZtVVljMTA0TGNDYUxlS1BtaTFqN2NnakhP?=
 =?utf-8?B?M0ZqWVREU0wzZ0pHak14NG84MStmbjg5UzA2Q2hULzkrWElmckVyUjRRckNV?=
 =?utf-8?B?RjMrNHg4Z3IzWStXSXBLaHNjc0JOamxGbFlCK2RLdWxMT0lFMU5QQXR4anha?=
 =?utf-8?B?RnowemVFa0JSZGYzUk9JZlRLRFE5YmdlWTFySDZ3emJXNmRSU0J3eWdjNGt2?=
 =?utf-8?B?OFNVemdSTlpsM1hYSklNTjZmNUlQanZFbG1IZTNwYWlid3ZVREh0MHA1YkNn?=
 =?utf-8?B?aGpwNkFZbldlVG0xWkZoL291SUk2TGFLamsvR3B3ZUNGY2JqTUlNTGxCZC9z?=
 =?utf-8?B?MHhHVUJzVFdMajVuSW5pZHpoZ0FGNm5nOHFIaG1keEg1Q3Q0VEJxTUpzN0lp?=
 =?utf-8?B?eXFDTS80NUQrRjByQm1rcWp4L21Ib2JxMXVrQ0FGaEwzNkFCNVRUSmR5OGtx?=
 =?utf-8?B?bVN3NGRrSnZGM0c3d1loK0Rldm9vQ0l1V2pRZmFYNWxKS0ptYlNKbGpKVVRP?=
 =?utf-8?B?V2k5YUVCUHowNEVSRUV5Q1lwNmZGVmt4M1BqOVlEc2VvYytvZzkrQkk1UTl5?=
 =?utf-8?B?Tjl4bmg0MzV2MWdtdDAxT2VIR1RHU1IxTmROcEZWRkJxSDBZa0xiN3JnWlZM?=
 =?utf-8?B?aktOZi9aOVF5QnRwaEE0YUgwZ3RKVTVubUZINkhCazJEd2pPQTNnSDBoVEpv?=
 =?utf-8?Q?w4tD7607iWj+QuonBy9PrckKXykiPIhn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlFNM1V5WUFsdGo0THRTNHl5R0lsWEUyeU5hc1luVFZ1VTJxSTVQZUtseVhR?=
 =?utf-8?B?N1R6M0VxanhVME5pV1A5aWNHUVVoT0xxMkNzYmt3RlJQU0J0cTlhVVJYNHFE?=
 =?utf-8?B?SFlaR1lFOWdBTk9xdThQNUhRQW1ERXhnTTBTVnBVUHBZblNhYytjbnFnYkR5?=
 =?utf-8?B?U0RrSzQ3Z2lJNk4xS28xQklKbml3QS9PYitHcTR6TWJTMklHTDBQcEJ5Wm14?=
 =?utf-8?B?dUxSYklYYjFZb3NaQ1FmTTZKNHkxTWZCZHVMaWhZbU5nV2sxM0tnejhUQTdQ?=
 =?utf-8?B?aGxhdGpXWjZCWGJVeklyamdUeVMwY2FqSDRzZ2h2aTczbnJsdm5CaEdDdFFt?=
 =?utf-8?B?WlJpY09iRmI0N0VoOVdHdkVqUitWZ3Z2K211bmhSS08yOWEyNm11dHRSeFkw?=
 =?utf-8?B?Y0FENXZqWmtEWWxVL3lEbk4yZVFQZUdJVnVDWlF1Nm5yOHlLbGxWdzluMUYz?=
 =?utf-8?B?eklJM1lVd1MyU1ZTQkVtQXY1VXZlU2JsTVNEQ1JJbmhORlBoWWMySUdCdkVj?=
 =?utf-8?B?SzV2cHplTTJISVBvWHBsZ3dZTHFoVUdsczBVL3RpZmxOQ1dsQ3lZbEt4cnJm?=
 =?utf-8?B?MGJKbEU3UUloM3pMYnNoYWxOZTcwZEdGV1A5Y3ZPMGFtMzN4cThoZW1HQmhl?=
 =?utf-8?B?M1FxTXVlZnpjQjFhWXNLNUtNT3NYWmNoOWVQR3UzdmtwSjF1M1F5VFhUZmlq?=
 =?utf-8?B?OFFkUWduTmVMS25XVGFZaERpeFBSUmk1M0x2RmpwYU5xWGtocXJteUdQQVlP?=
 =?utf-8?B?bTB1cmpvc05IS1E3U3Q1SE9mdE9PTnVkdERXR3BMaWlMem5UWjF0SzBzTDVL?=
 =?utf-8?B?RkVqTDhYT01oZWN0L0JucFBSMUt3cFlZNDJ5SjhqVnpoMmk1c05TTGFsenor?=
 =?utf-8?B?WjJ3cWFjRnQyQUh3RWVSVmtMMEF5YXpzckMwamVlRkZidDhncllmN1MvZ2VL?=
 =?utf-8?B?aTY0dEN2RjJPdExRVzRTWXlrdnFsc3Rkb0VTbGdPSlV6RFBGV1VHT2M1ODd4?=
 =?utf-8?B?Zi9QVkhPVUNpckJEYXR2MG1HQ0tTU2JMdVlEbzZFU0JML0VrL3E0anQ2TEs5?=
 =?utf-8?B?S0xIZG1oTmdIMTZUS0g3aGprL3lhajBocVBKbG9xQVJGT0ZDQkEyNmhZeHQ1?=
 =?utf-8?B?bmFLUStiTEtBaHBEVURDeFZNWGhKQVNNVWVDZmI0NHRDQUpOVndBcWhMSzRW?=
 =?utf-8?B?SW95MGZMMzFJbHNTVDdtRXJmTnJVT2VjRUNINGxObXhzK3pUNTFtNmQ4b2wz?=
 =?utf-8?B?YXZQT2VGZmlzZXJDclgwc2liV2MxL1dXWTRKUElPMmw2MzNITzdCa2hkMmlm?=
 =?utf-8?B?R0hmdWUrQzFDa2J3d2ZhekxON3BFN2J1TlNkUUgwSVFnc0E0VU01aFFrNGoy?=
 =?utf-8?B?Y3RWa0hZUzZMU2x6REFnVGxHTGVzMmxsbFlOeG1XSTZNV1JkMUVZdGphSloy?=
 =?utf-8?B?WVJRT1hNRCtNWU5iRXdGN2IyeVRWSEQ5VWQ5QjZ5ckYxNWlsSXpjMjEyRm9L?=
 =?utf-8?B?eS9TRVpVRWcrbVIrR3lsS3RTRTE2TXF5eXZOdjlnVjRsVlNZSVVNRWI2cFIy?=
 =?utf-8?B?TnFtcGdrZSszL1gzd2dTSjl1MU1MTHdaa1JXMEVHQXdYRExvTndnL1BubUNB?=
 =?utf-8?B?emlPN0RLVHBod3RHT0tmdUhxanJvTXhSL0FYN1BaamZrdVRzc25hemJCcEFO?=
 =?utf-8?B?TXhtR3BQcU5BV3J0dEVyZHdZWFZJMlpJZzF5clc2UEo0NG1VUkJ0cnpCRkpr?=
 =?utf-8?B?bnYwUzl5TUthY2ovSjd0QmFNaVc0RWd4QWZEcXVSWFVnQUlSZit2ODhqdGl1?=
 =?utf-8?B?M3UvZHpGYTVJRG92T2R6VG4zLzVMa01VRjFMMUtvSVJvcEpsSmphVXFGMzVJ?=
 =?utf-8?B?OGo1ZnhQMjMrUE9tVkpLS2IzZUhRbkh2NmhQaEZPWHlBRC9UMUNwTURhOWxO?=
 =?utf-8?B?Zmpsd3JYQkRwV2JNRCtURVZ1elg2VU1Ncnc1SFZxSHJnZGR1Qi9nMDJYYXdF?=
 =?utf-8?B?N1lHMFVYc3REc1dBV05XUE1zQUNCSXZxaGpJbGFtWXQzQkNQSE1oTVdsYy95?=
 =?utf-8?B?czl6V0FhcGt5Y0M5Y0taMmt6T2ZmVitvZHlRMi9OYmt1U01EbTdqZUYzUEZE?=
 =?utf-8?Q?bSH+Vzlit/N0yqHg6fpOcix5n?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dda72a1-e5fa-49e4-4eae-08de2cc2b17c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 08:06:24.9768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kF3mcKxHBfNOObzn9T2zkHfKTSG69zrmtyvyza+gyxJfFbZmoS0oIgdEo7zqabQQH/3cP5t0UkkYY6HYuvCBIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8283


On 25/11/2025 5:10, Jakub Kicinski wrote:
> On Sun, 23 Nov 2025 19:10:09 +0200 Carolina Jubran wrote:
>> This series fixes issues in the devlink_rate_tc_bw.py selftest and
>> introduces a new Iperf3Runner that helps with measurement handling.
> Sorry to report but patch 2 doesn't apply cleanly.


I am based on top of net-next, and I do not see any issues applying the
series. I rebased on top of commit ab084f0b8d6d2ee4b1c6a28f39a2a7430bdfa7f0
and patch 2 still applies cleanly for me.

I’ll prepare a v3 to fix the new pylint warnings in load.py while I’m at
it.

If you are applying it on a different base, please let me know which
one.


Thanks,
Carolina

