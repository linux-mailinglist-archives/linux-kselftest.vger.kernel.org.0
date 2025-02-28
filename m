Return-Path: <linux-kselftest+bounces-27914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA70DA49CBF
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 16:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FD7F18864C5
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 15:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5B61EF360;
	Fri, 28 Feb 2025 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jp54H0xV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5D21EF361;
	Fri, 28 Feb 2025 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740755131; cv=fail; b=JDCctXUr4RRA5llhQY6IUR8OKv80lpQ5rblUIqS0g/ZWU5qufoR3jkJJxxBhX8AVlcFsvVIu1nVJ360fNQbhqf5fHTZgANIQcTNXXnHNRGpfqUlh2jLgVLO7w+lHpzj++bGBrx3ZqlBNCDyJnHjKFBHJ+6lItQgRdzXl1DSwgqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740755131; c=relaxed/simple;
	bh=Ra1sATZLxtMkfoHvQngU8+nuHGzjw0HP+EivRcOoBP8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T28wXAZLrtYq+gBSyj7+S5r4l1knD+RpPuuOKoTzUyptAX5rcWfuqvsZxyePKGo6QP2ube9WSNU+8wsY+TCm2NoY2lsMwW86soBjvO4IOHEgUU7rNFkTNECfbhLebOSHqfUU16gjB/Dkpm2piEUbTNEyIvEddo3luMSWL+xtNgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jp54H0xV; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZJsowk3eYawrJcFMQlL8eBRf58syWrFrKFyvmz+aELNzIgXmyS+Ez0Jvm6N87wd08fQP7G+3JRO8ONOVJbQVieSuGBnFtFgscAnAw5SQRu7yNKQBHWD7bmeiJWl944bH9wF4kajv1LFwEiAZBOKxDaXPob6V3IplXw0BTLW6zE7E7PLbAxMe9XlVK7ryW+NDHFkbOECyymTxGkRNEGDY6+QMjHi1Oux6RXgInXaerovZA+l5rlcEAUSX4bkQrnJDPa041s/xzTorrTX3Ge2YgiFvkQM9dPGk2r7qgG3GOeBpVhi14/oL0tNs35Wh25XUXWFJ//W0I2/VCCEk/G0pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZhrcUCvqXID2m7D+pkicoLrQ9nYcV77BkFtQS4762Q=;
 b=OiuTBMq6Sr0sm7Z8jYTtG6tCZIY68t02tGoXlnbkQ3i/ewJtYHIMeq0uY8JcbELT+DHQpjTjxwNLTuVcl53Z8tLCA2nYB2Af51lIbJYpw40AFIHzzjcmu9hMaiBhhJt7pZpu69F3OSX6GMDVL+mu9x0NWfy3EXjs82I6SUgaJ9046GqmNG53YgIZa/wje+aZSucAfkIM5zniSzFOaa8J/S2fPltIXWawzFJwMZr8jtD6VGKv6JrsSq00s9wj0NpUmb5Mq3YjrekZcnjY9PGe6EsRJL7xmV2Q+BMGkFVIDvqvCAKeyBGCR9I/onnjhT09vbDfzKAaYeXJoaqLqq81QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZhrcUCvqXID2m7D+pkicoLrQ9nYcV77BkFtQS4762Q=;
 b=Jp54H0xVTBLuQBeUhXKRbJ9KfmhAe7M6HNe64p4rm6p9pN7PRYc4bfD+ULMRqknVfohGGIHZJCHi4RRGxejsen4YjsB7oJYrSJWmHVoQ3mNQIHFCLMDCz9oyORlCcZZOI1DXtQjX/Pcmo5gUsFc+od96CQogRR8fLEfm1jaRcFI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 BY5PR12MB4163.namprd12.prod.outlook.com (2603:10b6:a03:202::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.24; Fri, 28 Feb
 2025 15:05:27 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%3]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 15:05:27 +0000
Message-ID: <cd574aed-87d7-4ce8-b573-3998bfc788c9@amd.com>
Date: Fri, 28 Feb 2025 20:35:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] KVM: selftests: Add self IPI HLT test
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 babu.moger@amd.com, neeraj.upadhyay@amd.com
References: <20250128124812.7324-1-manali.shukla@amd.com>
 <20250128124812.7324-4-manali.shukla@amd.com> <Z75iePyU3PK01oG7@google.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <Z75iePyU3PK01oG7@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0124.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::9) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|BY5PR12MB4163:EE_
X-MS-Office365-Filtering-Correlation-Id: 30a809bc-214c-497c-4f06-08dd5809555b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eElPamp4clEwZTlMRCtUdVltRDJPeEpTRmxLazF6VjdOU2t3ZlpSemwxSEJF?=
 =?utf-8?B?SE5UTHExc2UvMnJOYkU5SjdQWk9Yc3VzUEh3aFZNU3ZYR0g3RnRJdXo0alIy?=
 =?utf-8?B?Q0NOa0pDTjhvT29FaHBrSDRhUTM2OFR2cHV1dE9xanVTQWFNNEloR1FkdEg5?=
 =?utf-8?B?NVg1S3FGcS92RXdXRTFTSjhiYmRtaXE3Wk1BTjZyckxBYjhNSVhiR09mcXpz?=
 =?utf-8?B?Y1YwRVcyWXlDVG5kVFk3WFM1SEdxWnhiMjYxeEVkUFZYN0pWek1FQk9XREVt?=
 =?utf-8?B?aHNaQlVhYmVXajh3dWNvR3F1cUZsM3Z5cyt6eXRoU3hDdkJkcTRCYzN6MmpW?=
 =?utf-8?B?b0IrS1BvOEh5OWxpRXJBZHJ0NEN2VzQ2OFJSSkRyS3ArMmZBRWExTEFOUGZh?=
 =?utf-8?B?ZXFXVW5lYlJ5RkdzN1FDOXNHc05PdndRMGJQMUl5VGRodVU5TEtjZ0EwQXo0?=
 =?utf-8?B?Y0VFcVcvZktXMGppd1U0L21zN3BzdU0wMmdzMUJtYUk0eTRtWnk5TUF4WEc1?=
 =?utf-8?B?M3lON28weXdnRE1UQVFiaW1MRU9ISyt6Z3BUZExzTGM1WVZMUTJhZUhLbjdl?=
 =?utf-8?B?YWhTUFZzU1FsY0RORFB3c2V6NSsrU2FjaGlsb3Vrck9nV0ttblh0WWdTUVFj?=
 =?utf-8?B?VHVRNDBrT2FaQW44S0ZnZmpNOFRjUHBaRTNOSW5xakxLVmw1b3FoY2o2WFZq?=
 =?utf-8?B?WmRDTDdhaXI0bmovRExIM2N4SmZDcFoybzd1VVdvanl1N0JPR1NVeEJxejRv?=
 =?utf-8?B?T3Z4b2EzTTg3TUVyU3hoNnZLWkpmdmpuU2RaaHdsOGpVT0NUdEcybTY2OGlw?=
 =?utf-8?B?VTRUdkJMYUF6TTNVTlZEOWdZblJaaTkvSFJqdDZlOVpQcVoxcnFYRTh0bkZu?=
 =?utf-8?B?ZDdyOWZPSTJWOTVhTXh2RUlWQW9qQkRoVWNZMEs0N1BGMXUvamV3UDg0anZ1?=
 =?utf-8?B?clZyT0N0U1NvZzNrVVZ5MDhmeWQyMXMwSk50S09YNUlsUVpjeGhWWW9aZ0ov?=
 =?utf-8?B?cUtUUHhyWmh6NDJCckJxemczTCtabFFKaWtua21Nb1pQNEFmNVpPWEJtOTFv?=
 =?utf-8?B?a1laNW1YZmZXQWk2QzNEaE9ybm9FNzR0VE1hVXh6aitHaHFKNW1neU44L2tp?=
 =?utf-8?B?dEYwdXM2TzA1TThPOVNQRm5XTjNqcWxvRENEK0grYm1uMllRWU4yOWtqYVJJ?=
 =?utf-8?B?QlMxcmp1R3ZTeTNQeWFXcTVvaE5sQUhYajJJQ3gwMDB0NjV5TkRiSFFRa3Zy?=
 =?utf-8?B?YUV1a3lyaExlNnBiOXNWSGUybVNWRmMvZitlSFkrWklZZTdCRkxaYjZDMGFv?=
 =?utf-8?B?RUpiR0tORnpNb1hwaFYyUkxzUmZvVXRDV0NnT0JzRVVPWDcwTi9iL1VYNVMv?=
 =?utf-8?B?ZStteitVeWZIbW1nK1dWeUFVRUk1SURjS25nTkVVK1Fxd2gxRUozdDZPTU1s?=
 =?utf-8?B?WllIN1VObDNSUVdyVzBWMWRRM25VYVM2bHQ3NXh2K0pCMHpJd3FRbS92Szlu?=
 =?utf-8?B?Q3Yydy9CN0M5cnpjSTFxSEhsaVVoQUZPNXpHZ29ueVFySTFSNnJrdzdYcnpr?=
 =?utf-8?B?ZTlaWEhGbnFrZDdzQm5ldE5zN0lrbmxoK2dKellrNm1NcmhmUjNNMjNJc21S?=
 =?utf-8?B?T3d4U3lERkM4bmlseVJ6dU5NM0Jsc3JpY3c3MHdMMURIWTZaUHpMZmNlMi93?=
 =?utf-8?B?YWV4Wld2ZVcvY0ExVTFjaDFjN0p5Mk1lSlRCeWRHbDRCQXZaTHJJN0lVcHNI?=
 =?utf-8?B?Q3c2QmxMTmxYNXRrVzZiVmhSYjFRa3RPWnlYMlc2VkhFcm5yb0Rya1NOUEtM?=
 =?utf-8?B?K1VvVEowdGhCM1RkMDlEVW5SS2FyNnBEb0dLUno0ekVDeVFkcVpxdVJWS09s?=
 =?utf-8?Q?atvgtpfgkphS6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SW5TYnN5SlRtTGR6OGNYb2h2Um9IK2JQMC8rVkJ3emdSbVRVN2t6eDN2Nlk2?=
 =?utf-8?B?M1hzUExWZFJCRDhXM3NESC9vSzZWNDg0dHg5bWJxeHlUS2FPZ0xKeWdWZU14?=
 =?utf-8?B?ZVMyd2ZqQjZWOSs4ZmFYVFdNdnNOaklYTmZndmEvSjlsSzdSTForV2NqdFd1?=
 =?utf-8?B?VHBQVGFxaEN0VjZJcGgxdTFYamhuMktSQmVNV215N05sTlVNUmxqYkNKb1ha?=
 =?utf-8?B?K2F3ZGJiem15VEZFOXR5MWtuUitWZU5ZajBDcFQwTUw0ZUZVSVlBWnovSnVV?=
 =?utf-8?B?bjNBVEtDeGIrWkJ4WmdqT2hvQjJ1SklnRERlaFRRQTFaZnhZckFVcHMvQjRJ?=
 =?utf-8?B?QWlUUW1jemdvSW52VFpaRlBSbUVCVXh1dVNiSFpUa2tGZ0NrcXk2SmMzZWRI?=
 =?utf-8?B?dWROSkVSZmtGS1U2ck9WeFJWVUVaTjRlOU9xQ0UyK3k0K004czFFNXZJZ01T?=
 =?utf-8?B?UDNUenNJZjc5eE9pckpDdnV4M3hOZkVYQk43Qkp0TWtBK0U0eU96ZTkxV1B3?=
 =?utf-8?B?bmQ2SFlPSjJYOFkvUWVhMU9aWCttWjFVaWxUeFpuYUlha0h0dE1YQ3JveE0z?=
 =?utf-8?B?NnVYSW1uc0hXYU5MQW1ONTcxYzN0N2tNOWgrL1ErNE5EY09hMWVNT08xS0lj?=
 =?utf-8?B?TlJOQmViaG9CVzRFZkpCRHNkODg2dWJYTmx2ZThQdGdQbDZSQnUxNDNYSmhp?=
 =?utf-8?B?TnFOWUZoaGJnTXp3ekR0clVVbkRqc2NKL2wvTGdIT1p6RVBQSjhOVTVkeUpG?=
 =?utf-8?B?bEI2aVA4NCtzM25NVUUxM1NzUEhmT1N0RUtGbHRMcTIzYlJQbzk4MTMwWk1Q?=
 =?utf-8?B?MUNUdmF3TXUvY0dGV2dBRmxScWhFbnQzMExIeUJZQ2Y3ckFkK0V5QlFsQU5U?=
 =?utf-8?B?S1RBRllKUHZYZGdMc1ZOckc1OUxUeDcwTUpLUytCQ01pZS9tSHVTaVIxSGJo?=
 =?utf-8?B?Q203Q3RKd1pNWlY3SlcrRzljTFY2QnZLYkcwSkYzK1dNaER1eUIxSFRyZHNi?=
 =?utf-8?B?eXNVK3NQM1JSR3QxK1h2NmZMRzI2dDArMXVTTk9NTU4wR0xuWlRMeTVoa2pl?=
 =?utf-8?B?amxZZTVRNk04cXQvdGd0a25NeWFpd3V2OXJOVnoxcFZlMHR1bWZEOHJSQVk3?=
 =?utf-8?B?dUFVVlB4bElSV2xyaHY5SmlyYXNEOXZNU0pRTnZoUG82emJ2bDE1M0U3UDk3?=
 =?utf-8?B?bmVoZUhVRVNpM095b0NmKzlMZmtCNTVHdGxTMnU4YW84N212TDZwRm1MU2Z3?=
 =?utf-8?B?TGllNHozMDk4T2xUUGV0MFJGNFc5Y1d5NmZ0bjJ4QTNLN1IyUXc3dm5aWVpy?=
 =?utf-8?B?MzN6Uks1SDBtNUo5TVpxbXB6azZGdWxoRTVNUzJLYi9nS01ySk04cDRNc05p?=
 =?utf-8?B?NVlhb1pmZ1NrM0JXbXpzU0NwTXQ0OGhXSU9pM0dGVVozSWZERHRyN0NWRkJL?=
 =?utf-8?B?b3prMW1CQ1piVDhQV211VGNhanA0ZkxzWTRlZmREVjQ3elhSTUFndEcrcDg5?=
 =?utf-8?B?VnBWbjQ4ckREaDBOVDR2cUFZM2JKbks2T21jUU1sR3NiQ292azFXcU1pbFVh?=
 =?utf-8?B?Q0tGZ0lIQjRhYWpqUlU3SFJ0bmhVcUxQZm94bE9iaG52RHUzS2phSWtkcEJl?=
 =?utf-8?B?Z1dxZzFoQTVEVytBcEpRZGFLa1BTZEhoZlg5UFpkajNjbDhNdzRCTFkrbXN2?=
 =?utf-8?B?dlMvRGZPUVBaVXBpeFFydGpyVVVKbzBRZFBraW1qNWhDa1pnak5NNEdiZzhQ?=
 =?utf-8?B?MEQydUNrMnlSLy81UmpiY201cGJZM2VDTUwxN1Fpa293OWtMUVNyeC9Jd2Fs?=
 =?utf-8?B?SUVSQ3pQMEMvNWZwSGlmci9mcU5xSlhDUFR5bWVQS29vSVB6QlYwNC85WlY1?=
 =?utf-8?B?N1FQdDFtSDFRVElsTmROWDdjbDdPSjlkekkzenBqdGpDb1NTVUo0TE9RcVda?=
 =?utf-8?B?ZG82NDBPUzROOGZibHp6R3k3bElSb3Fha1AreXEyL3ovWTlBVk1pWTNBa0JG?=
 =?utf-8?B?bGJHVnlseWdJKy9hSHVjdTFrYWdYdXNkSUVvUk1FSWd1ZmVNT1U3K3NLNlNn?=
 =?utf-8?B?V25qTWNCZWxnSFdqZGMzNHAwM3JtOEF3ZVd5Y2ZTOUgwQjF1MzA3RGdmOXFD?=
 =?utf-8?Q?bxpQI3uAuHPaUKJs54Y6bvdqF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a809bc-214c-497c-4f06-08dd5809555b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 15:05:27.3816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cOsMdIRKbMojoaU7NxbIUUqHyIUJ6d2UnCIcVzxSIG/Rj+GOipFrLnDyCHAN4ZtZgKhkq6OBDgg50KBicgdfvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4163

Hi Sean,

Thank you for reviewing my patches.

On 2/26/2025 6:08 AM, Sean Christopherson wrote:
> On Tue, Jan 28, 2025, Manali Shukla wrote:
>> +	if (kvm_cpu_has(X86_FEATURE_IDLE_HLT))
> 
> Well, shoot.  I gave you bad input, and we're stuck.
> 
> this_cpu_has() isn't correct, because the part of my previous feedback about
> needing to check *KVM* support was 100% correct.  But kvm_cpu_has() isn't right
> either, because that checks what KVM supports exposing to the guest, not what
> KVM itself supports/uses.  E.g. even if we add full nested support, the test would
> fail if nested=0 due to KVM not "supporting" Idle HLT despite using it under the
> hood.
> 
> The lack of a way for KVM to communicate support to the user has come up in the
> past, e.g. in discussion around /proc/cpuinfo.  Sadly, AFAIK there are no (good)
> ideas on what that should look like.
> 
> For now, I'll just skip this patch, even though doing so makes me quite sad.

I understand your point.

-Manali

