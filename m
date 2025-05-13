Return-Path: <linux-kselftest+bounces-32891-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D40AB4A9D
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 06:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 194D33AE360
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 04:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855A21DDC21;
	Tue, 13 May 2025 04:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Mut+sQDH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C19195;
	Tue, 13 May 2025 04:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747111590; cv=fail; b=AgaMQPLcyTG6QHr++f57Q32fgETlTn+iZFFfSOFfL38FJmhRniJxSsGvmaS1sxJUNGjXxjcgsHR353MuJfkeMG2P7RHoXs/wBBBMLU2LKcmkZCHQy/PWD3LiGn8fHrS9Nm612tOAWnsECwf6E0QM+3MBPEOeCzDfLnTbZWamNtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747111590; c=relaxed/simple;
	bh=u2Tm9tM5fu/GJdy8DfLPQsc9BiRJ6KnbHmSy6VbCgNE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tYWmuopmH2YhhOOrmZ5aDr0Y3gNq4UAuJyF4mBioRotLPuqP9spMV4+6kE75enIEwv4sWIQDApi5z4RMA5BHtI8JRyQw2h7La+vVRy+Y72ApzCd1ysV110wmo8gu0JnKLp5av3KVKtXmW9UclS5bKnViEYpSMErRjmGqCMNdwfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Mut+sQDH; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xpg9Z3nA9gRGDqRyRyFEPsN7Ga0Z4qR7Rcs8w7pWX85nMPae1ErkuSbQ7Kj/YkLrMqrUzg+jtMtx4gheDyVEYFZKJzvITHQuwVOzCAsJ+ylVidR7StN0SkH7iDiHIYW3GCZfUeocj9AQJM+k6KvvNKa4rQkTyGfce9bMY533iSuCZ4KqgEzCQMc7Yqx7ghqxqX2oWPgAD7pBNYZocEyvKai7cv4mJikycW5rWiZGG7bt3jrE0o+GGGJ68XcG3qiNtWRQJAXN+6xO3P+8cD7+JqVNFqyUeMA2ZbgC3OFv4XgG3Pk8FLfskoBszNPo09VXaC6lregQEHzblsoADhTMDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88Gg+bAjse+24EWgwIgPEjhYKAuzdcAk+ZfKATHVE+U=;
 b=p/mM3H6npY1URn+ZsP+GUn1X8SE/5gIp8ZH4j/A6xG7QtHYY+16pUm8fKTvdZVNUJvmvY/ycnGsPMGWLwv99cIdWm9FBmsym01MIxfJPdQ9cMw1N00C3Tuhf1+7nDg4c3OSJhJxJqj7VvJ+X0CTLnB0vj9E7iANHmujmACnSlvT5Yi4aJTRWMQm/LMeopLRcXr148TVCW4TR1sooYyUFgjH9wiBDz1f/sHMiHSKl9fG683GLxeijN99pfBuWKEK+ujqdt/Ok/R88mY9yvqis+ED6+9q5UTf+JSJu804m2gJdP187nuw+GgVCwtkOjvTP4g/R+j/5WjXngY9HIx/ouA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88Gg+bAjse+24EWgwIgPEjhYKAuzdcAk+ZfKATHVE+U=;
 b=Mut+sQDHqleUO2dxgemprSYjo4W8DllTQxZRLSvBJTdCw03xuSMQs/YOd5cFwqKbsnH3/YYdPAzcniENAyJRWzYAqcoi51rx4f0sufdEudsx0IIzNvw/y9PxiigcK0K13w8moxVBiH4yIIqBTi2gF/L+ra1P2RtSUbu0R1oP1Fw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13)
 by BL1PR12MB5948.namprd12.prod.outlook.com (2603:10b6:208:39b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 04:46:23 +0000
Received: from IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48]) by IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48%3]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 04:46:23 +0000
Message-ID: <25fbb9a5-496a-4c70-bd54-2a285391fca5@amd.com>
Date: Tue, 13 May 2025 06:46:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] KVM: SEV: Disable SEV-SNP support on initialization
 failure
To: Ashish Kalra <Ashish.Kalra@amd.com>, seanjc@google.com,
 pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, thomas.lendacky@amd.com, shuah@kernel.org,
 prsampat@amd.com
Cc: pgonda@google.com, nikunj@amd.com, michael.roth@amd.com,
 sraithal@amd.com, linux-kernel@vger.kernel.org, x86@kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-coco@lists.linux.dev
References: <20250512221634.12045-1-Ashish.Kalra@amd.com>
Content-Language: en-US
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20250512221634.12045-1-Ashish.Kalra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::20) To IA1PR12MB8189.namprd12.prod.outlook.com
 (2603:10b6:208:3f0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8189:EE_|BL1PR12MB5948:EE_
X-MS-Office365-Filtering-Correlation-Id: d54ece97-ebcb-4402-ac5c-08dd91d91c9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWROTm1zbUJ4RzIydktvZWRtaVBsTUEvRE9xZGhkTFhZSWlyRTB4SG1hSEhm?=
 =?utf-8?B?SzBtNlpWTS9JSUpuZXZ3aCt5eW9NakNaWm0ybkorczkzT0ZTbS90T1J1SS9F?=
 =?utf-8?B?b2xUaXM5SnVZSEVHdWRzb1ljRGUzN05TYytRNTc0SWdkck9NU0EybGdIZUwz?=
 =?utf-8?B?K1ZWRmo0T0JBNU5MbUZZRjdCK21DbTB6TlA2c2x2Y1hPVVJXUURkcWMxUEh2?=
 =?utf-8?B?U3dmWU50ejBheUNKaHlHaU5DUXovci9qR0NWalh5byt0Z3FJK1QxeTB5NlRG?=
 =?utf-8?B?MU1QS3NURlZXdXEvdzZHZ2prN213eVpONmRhZjluOWJ6OFhDSW9aYVA1WFE4?=
 =?utf-8?B?UTYxSVhJanpId0hpcDg1bmkreHpyUys3SEREN2ppcFlMNnV0eTdtOUQzV0E1?=
 =?utf-8?B?cU9TQytxd0VsbFZFcy9GRjZjREhWY1RtdDh0L2xURVhzelJudGhlbkFBQUpO?=
 =?utf-8?B?L3ZrTXBNNTN3VXRNQ3pUOWpiODVxTk9YNnY0WVdPOEdZVnE5ZUREK1ZGQ1J0?=
 =?utf-8?B?am1DbnlOYkZtWGg4dkVhVVczTVQwSnNqeHdORnRXei92Q1djK2JlNnR3Tktv?=
 =?utf-8?B?NGZmZnJiWnVNblFLK2libFJPTS8wWVF5dVJOTEpXcHFaRXFUbnVRL3hoVWxx?=
 =?utf-8?B?akxvRDhFbWt4ZmkvdFZvVjFhTDNMRnJvcUJiWkdGc3d6YXNiT04rbkFaRDJ4?=
 =?utf-8?B?OWUyNDZyMllNRVdoSTJycmd6Mnd1aVlSek5NYkFlNzhIVm5vVkFIZFAxM01W?=
 =?utf-8?B?TXFORE9aaG5hV0V0SytYajJNeFU1QkRoOXNFcmdQaVd3S3l2TWJWTG9pMmNk?=
 =?utf-8?B?b2pONEZoeG4xRE85b2xUL0pmL2pqOGt1djlYazBaSEF4U0FhUmNITVc0TkVs?=
 =?utf-8?B?OUVnR2xic2puT2phZExUd3dYZXFGREk5YjV6ZHd4Y0p6dmp3OWwxR2xxVXZC?=
 =?utf-8?B?VVFrT09ySTVsbytrWE1KOU9UeDVjSFdNdjNkZ2VURk1HRVQvU0JGWXJRREE4?=
 =?utf-8?B?OFhvcGRUNlVLdDJxT2g0bjR2RDE2MWltQjZMaExhdXdFcFltVG43ZXlvZWN2?=
 =?utf-8?B?ZG4zRERHcTVJbUVpYWJjaFJjT1ZDMzVDTzBoU1UrT3doSXZaaDNTSzE4YmNq?=
 =?utf-8?B?RHN6blpWaXBxV1JvYVY5eW5oQ00wVEVyOTBwalNxMktab2IzZXdiSFVsQXVV?=
 =?utf-8?B?T3BtL3BEdG9QbzdSSHd0b1QweEREcUxTZmo2Y25IeE85SWpRNUhIYmplaGFa?=
 =?utf-8?B?UDN3VTg3bG5BS2paS0V6Yks4MkZKL0ZiWDJ3R0NDWWN0enNWbTZjMmxpSmQ4?=
 =?utf-8?B?Q3BNcE5ZQVU0bGl4TytFVXQ1ZFNVR3BNVEJKT1BHOXRKQ3ljbDIxNksra1Vj?=
 =?utf-8?B?anZmcUE1WFc4dFNSeVBid2FPanpuSjkxNHhHVHY0YlMxdFA0d1pjN0lYN2hU?=
 =?utf-8?B?ZlBwODVza3dyMGVxaWZUOU9YMVBsSWdLcU1kT1pycmhUbEdxUHBnRDBqSVZq?=
 =?utf-8?B?TXpDZWhvSm9EWGlpaDhoeHJxckJkZ3VUdjZlNHYxQXBuOUVjZDQvLzRsR1Vu?=
 =?utf-8?B?c3VtWmFzQW9iRXdMbjBBK3ZxV2tIWEhsY1lRZ1ZHdFd4aFZlbktScFVuOVlR?=
 =?utf-8?B?OE5HR296L29IdktrbG5MTGNYQ2JGZCtFVmpJUGJtT0g0MFpIR3YwQzdTTk9V?=
 =?utf-8?B?eHFaSUFoQVlNU0xhc2VodlRla3F3WDhuNGFhS0dvZ0o5VGN1QU0yVTQ5VWZu?=
 =?utf-8?B?Z1ArTXUvS3pHWGNCZ1RldGlBdVBoSVZueXNIaVM0d1gyUFhHOS9nOG9rRXFv?=
 =?utf-8?B?NjdaVVU4eWJHWHdqdlZ3S2JmYU1LMHRMS0V3V1hEa3hZT2h1bnRLdGdQK3U2?=
 =?utf-8?B?aVpSd2VxeTkrYTZCRmloTUdMSmNOd2FJcFRIQS85SlF3TzVlSHk4WFYyUU1R?=
 =?utf-8?B?QjVnUmZTT3IybllJejF4YjgxTGRJRW5LNkh4QWh3RkFyY014V1QxT1Q5MmVZ?=
 =?utf-8?B?RXpYNEFmUjBRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB8189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVNsMVJnSkk0TTN0Ulg2aDNZbXUwaHpXbFB4akpLQWtiQng1WUY4anZhQ2pH?=
 =?utf-8?B?WG9VOTBodXd5S1Vob1JFeDhEM2RZNFNFelBkVWsxWGtlRFMxck9HVEkzajJW?=
 =?utf-8?B?Tjk2aHBhWmRQT0UxYXZoNkIzYkxKdklRTzU1dEtNdW1jZzNncjZjWWdjY29t?=
 =?utf-8?B?VkpqN29hdWR0NlBYQ20rMndCRFVDbjNEOExuclRyMkdVcFVNYjJpM0svbHpF?=
 =?utf-8?B?T2VmRFZHMVdZRlh4VmJidWplb3phWWIrWkhjbFhYOUFQeE9OUDd2MHk0d0F6?=
 =?utf-8?B?eDBZV2ZlNXA4SUgvUE5ubGRxcG9iK2ZvK2V3ZSt0N0pYU2xKVEpYSFlaeXlS?=
 =?utf-8?B?TGZJZ09EL3MxbHFqTHYvdFFjMjdmNCtVWHNGVmRXcFF4TjB3VDdibDRRSkE1?=
 =?utf-8?B?UU5oWWhua3V6NGFnVEk5bFYvcjJaQWxlNlYvaUhibkYrZmZCTEt4ZWdnVi9w?=
 =?utf-8?B?Vi9ZTzB5TU14eGFBTlBtbVBBbndTN0kvMDBudm81ck55bms3d2RDaURkREFs?=
 =?utf-8?B?ck00c015aW03L3J0bU1DNzJ5c3hPbnZrSVNMVGExQW4xT1JVU1dxM0VnL1M4?=
 =?utf-8?B?RWlCdHlaWnpFc1ZYZ1ZhMm0xVG1lZ0FXdTVMNjVNUXJ0bTFwa0RlQkZkV1E1?=
 =?utf-8?B?UXpvVURUUWhFaytDakowejVmZTU1Q043SllVNHcxNnpvenRWYnhvM3NXSW91?=
 =?utf-8?B?ZThyT3lPcWx3TnhHNFZqZXlTM0w5Z3NBMWoxczFXSUIrUE9FaFYzSHBZY2lt?=
 =?utf-8?B?SVNtS0pyWE5qQzlsdnZ4MEtKRlB2amM1akNDVUNneFhBVDVqTHB6L2U1QzVl?=
 =?utf-8?B?YzcyVWw3bjFnRW96TTMzcE5uWlI0cXNzc3F2a3FPNDNMYnVBUkd5TmRpN3hR?=
 =?utf-8?B?eGtOOGd3eURkRFhqV1JwbllyTk5vSUtZTjh6c2NMZ3NqMW4rRmlZUjdVY0lx?=
 =?utf-8?B?OElpMHM2a0FlRVpWWjJFdzQ1SkFydGJaZllocno0dlNTNFBRV0p3NVZJaFdl?=
 =?utf-8?B?bEpBUXlFNGNTS0pMWHU0VEVQa0duWFlEdEMyaW5tLzFCSlF4SGQ0Ry9yNU9N?=
 =?utf-8?B?Rkdyd2VlVWN2Vm54VVRtQS90TThkQjZSSWFwdUp3Q3hlbUpNWTd0amZjL215?=
 =?utf-8?B?NEFQSUxWUWg2aTlWenFXbjJjVmFjclltZGtJQnhhVHZLdGEya2twZ3ZUL3NV?=
 =?utf-8?B?RzhXY05IQ3Aza3F2WGYwWDdMNkJESzhTTUR0clUvcTY4N3NVUWQ1TEtOQ1dq?=
 =?utf-8?B?YVpFaXVINWNaY21yemJ6ck1MUVRjb2hOK3VCY3VaVlJMRXI5S2swOXNsOHJK?=
 =?utf-8?B?TjdUNU04bmF6NVMrci85Z3VYcmNFaDI1dGxOS0JneDhQbStHSDJwbkk2Y0Nl?=
 =?utf-8?B?RDdTOU1WeW50TmhMRnZtYk92ZzllazdxYXQ5MjZ5ZlU1L0lENnl5ZzhvNXVZ?=
 =?utf-8?B?ekN5ZXdoK0hOU0M2VHZRVmduK2Y2UUY3a0xVNG9HdFhOWXQxdkVpbEhQOUdz?=
 =?utf-8?B?R0hJUnpHZFdwNHQxeU1ZNldNcHg4SjBiNTcrSXpNV0dLVFg0SjFjOVRqSzdn?=
 =?utf-8?B?cEVNekRTekswZXNSUm94a0xBeGV0WStjL3loVE5FRkNhdk5HU2RWVkx0bTlp?=
 =?utf-8?B?eXNTN1RSUlRsaUUxOFRvdVlTdC9idjZJWHFuNzErZ2prWHFyYWdqU0JTZDhD?=
 =?utf-8?B?WWVZNUFDMVhnOU1XM3BjdUg2VjNkTGtnajlzUVFmVmJIMm50ZDJxbTZucDNp?=
 =?utf-8?B?a1p3Wjl6Z3BVZ0sxSDMramp0U1dmb01na0tSOHoyRFpLZzZkQXdySWhPVlZn?=
 =?utf-8?B?ZmRReUNVWkwwbGlMMXVlcDRkRlBjYnZuZURrYTFEZlR6eElaVk5GdklaNzdN?=
 =?utf-8?B?TSs0K1lyQkNBNndCQWpPVnBNWHk5RWJJcytZcTFhMUcva05BaFp2c3c1N2h6?=
 =?utf-8?B?MlRiZnF5c0hvYmZDNnNhTzRJcEtqcHFTVHhnQ0JsbVhpWmFCK2pvVWwyTFFu?=
 =?utf-8?B?bUszaHg1TldGU09RQ0ZsZC9Fd2lSeWRSOVdCUUxrSEZqMlpteEJ3dXJpckdw?=
 =?utf-8?B?T2ZscUhQU3lsZ1ZzeFNUQTRlSUpGeVRseDJ4VmxlRENvejRIcXl3UGZRSXNj?=
 =?utf-8?Q?9eAXqSPykBu/t1f58/ccrcWog?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d54ece97-ebcb-4402-ac5c-08dd91d91c9a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 04:46:23.3159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMrd5aUaCNbPJzpqzuMlmh7X1v9HQbn3tOQnpAasd4OickIsLtIBWkJ8e1soyT2lIoEBbOqojR4ARyyuxOclCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5948

On 5/13/2025 12:16 AM, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> During platform init, SNP initialization may fail for several reasons,
> such as firmware command failures and incompatible versions. However,
> the KVM capability may continue to advertise support for it.
> 
> The platform may have SNP enabled but if SNP_INIT fails then SNP is
> not supported by KVM.
> 
> During KVM module initialization query the SNP platform status to obtain
> the SNP initialization state and use it as an additional condition to
> determine support for SEV-SNP.
> 
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Pratik R. Sampat <prsampat@amd.com>
> Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>

LGTM

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>

> ---
>   arch/x86/kvm/svm/sev.c | 44 +++++++++++++++++++++++++++++++++---------
>   1 file changed, 35 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index dea9480b9ff6..8c3b12e3de8c 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2935,6 +2935,33 @@ void __init sev_set_cpu_caps(void)
>   	}
>   }
>   
> +static bool is_sev_snp_initialized(void)
> +{
> +	struct sev_user_data_snp_status *status;
> +	struct sev_data_snp_addr buf;
> +	bool initialized = false;
> +	int ret, error = 0;
> +
> +	status = snp_alloc_firmware_page(GFP_KERNEL | __GFP_ZERO);
> +	if (!status)
> +		return false;
> +
> +	buf.address = __psp_pa(status);
> +	ret = sev_do_cmd(SEV_CMD_SNP_PLATFORM_STATUS, &buf, &error);
> +	if (ret) {
> +		pr_err("SEV: SNP_PLATFORM_STATUS failed ret=%d, fw_error=%d (%#x)\n",
> +		       ret, error, error);
> +		goto out;
> +	}
> +
> +	initialized = !!status->state;
> +
> +out:
> +	snp_free_firmware_page(status);
> +
> +	return initialized;
> +}
> +
>   void __init sev_hardware_setup(void)
>   {
>   	unsigned int eax, ebx, ecx, edx, sev_asid_count, sev_es_asid_count;
> @@ -3039,6 +3066,14 @@ void __init sev_hardware_setup(void)
>   	sev_snp_supported = sev_snp_enabled && cc_platform_has(CC_ATTR_HOST_SEV_SNP);
>   
>   out:
> +	if (sev_enabled) {
> +		init_args.probe = true;
> +		if (sev_platform_init(&init_args))
> +			sev_supported = sev_es_supported = sev_snp_supported = false;
> +		else if (sev_snp_supported)
> +			sev_snp_supported = is_sev_snp_initialized();
> +	}
> +
>   	if (boot_cpu_has(X86_FEATURE_SEV))
>   		pr_info("SEV %s (ASIDs %u - %u)\n",
>   			sev_supported ? min_sev_asid <= max_sev_asid ? "enabled" :
> @@ -3065,15 +3100,6 @@ void __init sev_hardware_setup(void)
>   	sev_supported_vmsa_features = 0;
>   	if (sev_es_debug_swap_enabled)
>   		sev_supported_vmsa_features |= SVM_SEV_FEAT_DEBUG_SWAP;
> -
> -	if (!sev_enabled)
> -		return;
> -
> -	/*
> -	 * Do both SNP and SEV initialization at KVM module load.
> -	 */
> -	init_args.probe = true;
> -	sev_platform_init(&init_args);
>   }
>   
>   void sev_hardware_unsetup(void)


