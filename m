Return-Path: <linux-kselftest+bounces-23782-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 745FE9FE31C
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Dec 2024 08:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F8ED1881E91
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Dec 2024 07:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F11E19E83E;
	Mon, 30 Dec 2024 07:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mBjVfUYt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696392F44;
	Mon, 30 Dec 2024 07:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735542352; cv=fail; b=U6F5us5Cm4499pMyYrkghqzPlFKpi6rEFqtY09eVzBeS1FFv8Dhe8DQzQf/t6XGN0dW6Qhp3DDB7JDMfyTkXVY3fyUx4cAjQ76OmJrl67i+3OCehzbgPNhrao4m+GuvCQnZOCaGmRivla9kMj6HNbgT2Nmn5jEOGk4vv2Uoq0WE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735542352; c=relaxed/simple;
	bh=VKXKSoM0ZyKS15s0raINdxXOTNEmsiZPZd3bTmoWSLU=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kaZxfsvS1TS1ujE2Hs60NlLFWG6KFz1lvlgATaK2guLjXW7X4/BIIwe38TcAJQq8Gftm034iprGvuho+1xFMkKunRykEb8ovNAuiuvJ/Pta++C3/wtMCW/Gt4Hml0F7+BzvIGfLc40OSPIGANaElqLYl3wqnDVF08945N0aOfW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mBjVfUYt; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRwHV/kamNjh+lijh2MYf86jBro6HK6BVF7MQw0h4rY006EsJ+GWo66X79O8RDe1JKo/wGcfqTHLcH9A6ckTGsTUDVJZFWAetqFSbdWK+NnhzS1mZKHz/OXs8dNFTIOgCHl6xznBCt2k9BnKtqEgopYTyM+YT4+w1a9lZr9vY/IhL2JcdFbTPonlGUHaN6LSADAFivOtIKkOwSOSK6k5yqrjEV/j8EaLKG4S7+tOr8bdIJcWrtQH3W1jMmy3SfbKqdMMf25+02HEPWUpshmO+Zxq9OvSdwdEQBkpbmr7W5SPYIb9HSu3iq7nFASzPQ0ZlfY+kBJT3TDhg8TIrezT6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kps982/FxyH/3kuujZ6ICT4A+Ja/J4vpjicZL4uD/XI=;
 b=fnme0FE4R3XKlQUQufv4LhtiH6KfUYJ3AsLGb5ocIlbdo2ep97M53W7szkZdr6GpgR7KP0PDrFXQ1DLPLnqraLE/bNDclcZdFdlVQQZMF9VmKauCr0dQINoB4L7PhwjKJDGz4dy5PoYadSs5wNUXaXvZW78TyiJRs6ablCLiJ/LZfXgSaGU5U1ikKqdnmQpQvoNglaiBcHxqTBieZaGMUUl37tSh/pwXNZIf9i5MV4JK/77UACDkte9JPwUGC4/TFQ8cFqUC0iGcd+V4Ap0GgKnuL11HrBZRRdFZ4nUjfgVL5nVuRHrN1sVD7PlcwbO4K68Ajy+El+HYdT7I3Adonw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kps982/FxyH/3kuujZ6ICT4A+Ja/J4vpjicZL4uD/XI=;
 b=mBjVfUYtGUhDKX9d8JR4ejkhYAQBfU5RxZPEUvrWx1+flLPkykElVd+fqUw6QDTTe13lKAanx+PROSdLtrTg5ggHeopL0fEVlQFhja9i7wa7ERQ/qoDHjb2T5Ga09C7dAPZd4VRzXf2cl6dvX6bRIa7Ry8gjoTs1mCo1MgK4rHY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 SJ0PR12MB6832.namprd12.prod.outlook.com (2603:10b6:a03:47e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Mon, 30 Dec
 2024 07:05:43 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%4]) with mapi id 15.20.8293.000; Mon, 30 Dec 2024
 07:05:43 +0000
Message-ID: <c43cd283-554f-4d1d-8ce7-e786a137ed33@amd.com>
Date: Mon, 30 Dec 2024 12:35:34 +0530
User-Agent: Mozilla Thunderbird
From: Manali Shukla <manali.shukla@amd.com>
Subject: Re: [PATCH v4 3/4] KVM: nSVM: implement the nested idle halt
 intercept
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 babu.moger@amd.com
References: <20241022054810.23369-1-manali.shukla@amd.com>
 <20241022054810.23369-4-manali.shukla@amd.com> <Z2TB94Ux5mOlds3b@google.com>
Content-Language: en-US
In-Reply-To: <Z2TB94Ux5mOlds3b@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0187.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::14) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|SJ0PR12MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ebb0893-e19d-491d-d618-08dd28a0601f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZG16TEN3L1dhSWhrT0s0cFNTR090a0p2a1V6RGs4dklTc3Qxdm5CdXZ1VCtz?=
 =?utf-8?B?UG1hMDQwMVJrMndiWmd3NFl1T3pjRTRJQmxXWENNOVh6NDJ2WDRabmJlYVAr?=
 =?utf-8?B?dHNXNTNSMEwrZzZKaVY5Uk5ROGFWZzA2SU1lODkvV2g5Syt6L1JHbjF6QWhS?=
 =?utf-8?B?cFVtTTBFVkN0UzRCeHV2SFAyU1d4a3Y3OEhnZlJGVVY1K0t5YUk5MXhlbDY0?=
 =?utf-8?B?Z1BNWnhrVDFxQnZ1aE1JTVFNV3ZVVjhKUjNTeFBqMnE3Nm9yMmVRTFUwYThk?=
 =?utf-8?B?Nm9uSHd4RFVqUGdFcVRUZ1lGQkY3UzFIVyt5dWJxNEtEa0FWeXVrVzdhSUs2?=
 =?utf-8?B?Y08xTFYvR1czYXI1SWVHVUFTRFFoNVR3ZHlEcEJWUGMxNkV4WG1NdUdQbmNK?=
 =?utf-8?B?YS9VUUx5NkJ5T0UyUWhjSnE1Qk1UZC9VZDZ0K3RzNnpsdzEvM1V1R1JRUTIz?=
 =?utf-8?B?bWZsTVJoWWRwQmRNZW9FTVh2dlZadWRRZGpNbXNxdVB2SFYwdUlmNVYxc2Fv?=
 =?utf-8?B?ODNSZmJJMWg4NmhhRFdMdWVLdFZZN0NtcFJzajZGRHJGamFWTUcvK3VsaEts?=
 =?utf-8?B?enY5cmw4bVZYdDljZmJVVzZpYXBJeG1WK2RFL0o1MzE2NjYzcWR0SHRXQ2VI?=
 =?utf-8?B?WHRsQXFtUG9WT3ZkNmNpdEZpNW1rcFhlNG1mejZnVnNrbGVRUzZpOURYWmpD?=
 =?utf-8?B?QndKWi9FTmhhTTBzNTFsaXlxMFU2bGFSVVV3S0I0dytBSTdXYjNRZlBYTFpp?=
 =?utf-8?B?WGlZU3E1TG4zVzhoUFNQVE5UYjlpMVh4QnZqcXJlQjc0LzVpNHZiZEptdnJW?=
 =?utf-8?B?cS9MK3A0MDhkOVpZU1k2eC9XUFlyZHc3M0dVWjVBZUc0OU1oVWZpZWo3enZS?=
 =?utf-8?B?MEZFZk1UdGNJeXdHemJJaUROWmM0TkhMaUVrRmdGNndMb1BSWHdPME5PMnE1?=
 =?utf-8?B?dXp4K09LTVhXcnpGbjlUU0VMUUgxcXR5bW50MnlNaGgya0VpdExWaTI1ZFFY?=
 =?utf-8?B?YWQ3ODlkL2ttdGNuNXZFU0hIV1hBRDQ3T3ExcTNnU0UyN05HaXk1WEYvTmZL?=
 =?utf-8?B?OG56dEt6cStpaytSSU1Id3JOOHM1c3crbEM4dFpGc3hlR3dkSjBSajN6T2ph?=
 =?utf-8?B?VWxJOHovTjNPNW1weFoxakg1Uk5MV0NHSVl6WnhyQndLQ0hkbG5IKzZpWDBL?=
 =?utf-8?B?NUQxY0p0L3B1bHJjQW1WTlN6OGVpS2tOdHpGQVNkcG9tempSK1lkZ2RnbE5H?=
 =?utf-8?B?RlgxbWRCRENjZUNqTkxQTVN4Yk9PRkl3MDhXRTFTRTdaU0UyTy9mZGJlcDRE?=
 =?utf-8?B?REhLMllwWjlROW16WXJYdy8wSnI5QmhyNUhXdWI0RExCTGRUNy9yTGxOTEhm?=
 =?utf-8?B?aGpjZGhsZWZpY0VlODVvNUpPMjUwUjFLVHBhZ3ZFdEdYZDg0ZXdoVUVsdCtj?=
 =?utf-8?B?V0ErM2JCTkRjNlMxbFpWVEZFc0pteVB4ZnhVSTlyQlJLNmhLREVRUFYvYkpS?=
 =?utf-8?B?ZXpTOHBnT0Q1OVdYb3A1clpjSjFseEVUd2RCU2V6RU80bW5nYnhvWm9TelF1?=
 =?utf-8?B?QkFQQmo2T1UwZ3V6NnVpalQ3ZUs4dXBKSm0wMGRzN1VGNzJKYnRJNTdIKzk0?=
 =?utf-8?B?cjdMdGVzY2lFZTlTSlRCbm51QTdwQW5MbEQ1SU9hZjRtSnQ1aFpuTWdyWE8w?=
 =?utf-8?B?d2NXK0tvUzcvQ1FYTmRjb0hxbVI4MysrMlhudzAwWWZDcVZHS2Q3a29HOTBQ?=
 =?utf-8?B?aVRReHM4bzEwWmlPUVY5MmJiYUprSnNFdWRXQmJlLzZuRU1OWE5Ma1lDUjZV?=
 =?utf-8?B?NkFPU1A4L2hBV2haR0N1R01ZMnBVblRtSm5yTmJJeHZpYW80V0FCc1M1ZFFo?=
 =?utf-8?Q?DSs6ynkvEEIgU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzVJS3FVdmlJYnVLQk5LbXZDSmI4KzlLbEVvajRiRHBPcU9RdXBWZnJNMC9Q?=
 =?utf-8?B?VkZTWGJhQUdpZzI1UUVtR1JWQ1V4TFRxK0lnM0N6NmZiY3pKemg4cVhPZjQ4?=
 =?utf-8?B?cFZFVVhRTkVPOCsraENFaS9ia1FMeFdNWm40aFRWTDF6UlFXWVRldWVLcFpR?=
 =?utf-8?B?UlQwaUpydVFOWElHQTR6OS9NNWdvQ1NiaDZPRDlyWEU2V0hRMFdTdVFSTWJY?=
 =?utf-8?B?Y3pOL1NteTE1OEl0N2E5SXNTNzdCZjMrbS85b0M0VGVPT3JDRklIckhBbUhH?=
 =?utf-8?B?WGc5enBuTXZta2lKYVBFYUxsMTYxTWk1bCsrVFVCaHg2Q01YSkk2WmErMUhh?=
 =?utf-8?B?bTJ1U0dwSjR0bFVYM0JQRkd5a3lMU2w1c2FmRndnUFNWNUpUM2tUSGJuNGVC?=
 =?utf-8?B?Mmx1SFdTcmh0ODU2VnpQN1ZtS3dBNzNtaE45WWp0bEpFSVZ3cUhuTElnL1o4?=
 =?utf-8?B?L0d6c1c5TFhpckN1Qm41N29wR0hwdHExRjRsbWxweHZuemFKamszZkI4RHNk?=
 =?utf-8?B?cmU1K2NQeHY1RkJQL0RobWxVbmRWai9wdEFlSG0wcEZjRXcveXRwQ0xrZk85?=
 =?utf-8?B?NzlVYWR5VzZnOCtXbXdhdVlLSnM3T0JWb1IrR0gwNWNwUDB6bVEwMC9WSWVk?=
 =?utf-8?B?TFg4Z2pQRlNMY0J5NUJyaUhORnR4RGF6YTRZSzNKdTRwU01pdHgwcVJCVE50?=
 =?utf-8?B?L0krQm1vOHJKU1lhS3l1Z2hoNHJpaUxhbUlpU3VtMnVVVzFRNjBtcHFCUFhy?=
 =?utf-8?B?S3RTazRQS2FUY0JDaWtTUUdsbjFxcUlwTmM2ZjdJWDNSdTFYZWlZZlRkMjVh?=
 =?utf-8?B?ZlNuUWZlTlZwL1ovTll5Z2VaYUZacUVvTjQwSVo3alRtazRnQitLNkxmeWhj?=
 =?utf-8?B?dHlVM0FnSTg3TVoxWmFhalNFVG5TMWpMMzJYNWlSZzNiRzZUVk9rL3QrYzBV?=
 =?utf-8?B?Ry9OZTdCTUhxQkJ2YlpLSmZabW1HOVRPQ0ZhK3I2akNUc1RPM0ttMU5peUUr?=
 =?utf-8?B?RzNVbHAyaXk4STZPSjRUZS9BODREWTZlb0R3UzFzZjBpNHYybXAvaGtSUUlW?=
 =?utf-8?B?dEdBVzhVaWhCdTkzY21UQUJoWU9McVBWYW1lbXJqTXBvNFh0OGJWUHJrdXBW?=
 =?utf-8?B?MFl3OEZlRjNLWFF0OUxrU1hzeWMwREFaUHQyUjFPeUljOC9OL2hEbUJ4Qk5m?=
 =?utf-8?B?QjF4WGQ4amRjYS9xYzFOWVhCa0M0Z2JEVUhUSEtLR1lIZ0tRZXJkNWx3RlVX?=
 =?utf-8?B?bFd1R1MwNWJ1MUJNaWMvUDZ6RTJQY1JpQkM3MnpBR2t4elAzeWhzSk9PV1hX?=
 =?utf-8?B?emIwSmZaM0J1aWlBM2RvRk4waElKcVFKSUNUS3kxQkNXa2Y1Y3I2eXgrVUV5?=
 =?utf-8?B?YmpLYjBoZjRPKzE5K0VadmNSZDRRODNUbjlTN2hQSmRxeXZHMlhYN1R0NlNE?=
 =?utf-8?B?ZGpiUk10OHhsQkl5QmdNMmxLanMyUnVyNW9QMmU4L0VTSk84ODltMVBrNHBp?=
 =?utf-8?B?SGM3eTVIMjdNTTE4YTg0bVdKdEJLRUhXQ0VrWTlRbGExTUI2c2xNdUc4ZFFK?=
 =?utf-8?B?UGdTTFY5c3JqbG1pbGtkOXhIdVg2OU1NUFpHVXRRN2RrSWl4NWZZUFZ1V0lE?=
 =?utf-8?B?cThnMlZNYVI5OFcvS3M3bUVzU2hiS25lb0NhOHFsZGhvUU5kWEE3T2wrYWNv?=
 =?utf-8?B?NzlNNkxqU3lmM0Z3c0E3YllwWi8ycTFLbFVmcGZZL3MzNGlrdi9XWkRJRkpX?=
 =?utf-8?B?VTREODI0dmxWTjh5RTRjZFVxTjA0RmpxZ1pqRWpvV0J1QnhsS0I5UlNpSGha?=
 =?utf-8?B?ZWx5UDgySHoyeFh6K0dmazhRMlVPa0UyTDNtcjJ1d2JQVG5VZGJubWc5Qi9Y?=
 =?utf-8?B?aG1pSHNLZE5GVGpvQUZQTVpUTVlFcURCa1J1bmgvYnB2WXJWK1dwb2hIQzha?=
 =?utf-8?B?K2xZSlpwdzdVTUlINXMraE1wSzBvenFKSG1pcndqUHhHWE1FRHB3b1IvbE1K?=
 =?utf-8?B?MGJ4MytQU2hSUXVGL0ZtaWFWQ2NFVVBQUzRUTHdjQW52aDkwamhraVJZNzI3?=
 =?utf-8?B?TUNyMk16MmZZd0p6RnV2OFVFeHBuZkZucVZDQVdVK2FML3hRT2hHNmlaV0lo?=
 =?utf-8?Q?JoAkH9IVa4TWQsmAnMx7apOZi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ebb0893-e19d-491d-d618-08dd28a0601f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 07:05:43.3253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X41bQoCMcVK5qIKmOR1Wz7Prd4S6yU7jazJM11YcOLfA9rW+y1A+v6WD0qrLjyPqdZX95jGmzs6zZ8VUB/tQnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6832

Hi Sean,

Thank you for reviewing my patches.

On 12/20/2024 6:31 AM, Sean Christopherson wrote:
> On Tue, Oct 22, 2024, Manali Shukla wrote:
>> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
>> index d5314cb7dff4..feb241110f1a 100644
>> --- a/arch/x86/kvm/svm/nested.c
>> +++ b/arch/x86/kvm/svm/nested.c
>> @@ -178,6 +178,14 @@ void recalc_intercepts(struct vcpu_svm *svm)
>>  	} else {
>>  		WARN_ON(!(c->virt_ext & VIRTUAL_VMLOAD_VMSAVE_ENABLE_MASK));
>>  	}
>> +
>> +	/*
>> +	 * Clear the HLT intercept for L2 guest when the Idle HLT intercept feature
>> +	 * is enabled on the platform and the guest can use the Idle HLT intercept
>> +	 * feature.
>> +	 */
>> +	if (guest_can_use(&svm->vcpu, X86_FEATURE_IDLE_HLT))
>> +		vmcb_clr_intercept(c, INTERCEPT_HLT);
> 
> This is wrong.  KVM needs to honor the intercept of vmcb12.  If L1 wants to
> intercept HLT, then KVM needs to configure vmcb02 to intercept HLT, regradless
> of whether or not L1 is utilizing INTERCEPT_IDLE_HLT.
> 
> Given how KVM currently handles intercepts for nested SVM, I'm pretty sure you
> can simply do nothing.  recalc_intercepts() starts with KVM's intercepts (from
> vmcb01), and adds in L1's intercepts.  So unless there is a special case, the
> default behavior should Just Work.
> 
> 	for (i = 0; i < MAX_INTERCEPT; i++)
> 		c->intercepts[i] = h->intercepts[i];
> 
> 	...
> 
> 	for (i = 0; i < MAX_INTERCEPT; i++)
> 		c->intercepts[i] |= g->intercepts[i];
> 
> KVM's approach creates all kinds of virtualization holes, e.g. L1 can utilize
> IDLE_HLT even if the feature isn't advertised to L1.  But that's true for quite
> literally all feature-based intercepts, so for better or worse, I don't think
> it makes sense to try and change that approach for this feature.
> 

Yeah. Makes sense. I will remove the above condition from V5, so that intercept of
vmcb12 is honored.

>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index e86b79e975d3..38d546788fc6 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
>> @@ -4425,6 +4425,7 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>>  	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_PFTHRESHOLD);
>>  	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_VGIF);
>>  	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_VNMI);
>> +	kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_IDLE_HLT);
>>  
>>  	svm_recalc_instruction_intercepts(vcpu, svm);
>>  
>> @@ -5228,6 +5229,9 @@ static __init void svm_set_cpu_caps(void)
>>  		if (vnmi)
>>  			kvm_cpu_cap_set(X86_FEATURE_VNMI);
>>  
>> +		if (cpu_feature_enabled(X86_FEATURE_IDLE_HLT))
>> +			kvm_cpu_cap_set(X86_FEATURE_IDLE_HLT);
> 
> kvm_cpu_cap_check_and_set() does this for you.
> 
>> +
>>  		/* Nested VM can receive #VMEXIT instead of triggering #GP */
>>  		kvm_cpu_cap_set(X86_FEATURE_SVME_ADDR_CHK);
>>  	}
>> -- 
>> 2.34.1
>>
- Manali

