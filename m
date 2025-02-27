Return-Path: <linux-kselftest+bounces-27782-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F250EA4846A
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 17:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DCD97A24AC
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 16:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4495326FA5C;
	Thu, 27 Feb 2025 16:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HSEcgOMH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF5C26FA73;
	Thu, 27 Feb 2025 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672370; cv=fail; b=UtWOWGYAx5i+QSx6MRyoq348p3PTfYJH7ekC8ihFS5mk0T+1tVs2s4L1aXZn0QLUHkS39AshB324KYkF7qXBbrb3FBXawww5ldlcbO/zKGoa4LW7vXnkGTJr/m5Tc+GbcYnMM9/w+Tw+6I3Q+JqWFJ2rwOoolxhZWCL4nYQCWsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672370; c=relaxed/simple;
	bh=IJAeFmAuhwoQZdTyna9ZbyYzJMigmxVjRlZgWPX6WUk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fv8IPu8WfyEXikJvf3FDcaf1St2yHkFatd7t2N8L01Qg0smzToBReZSuyQNBZHJAeMLzgvn/1hAPE4sd2B6LIraPTNA+hXLE6ZdolZHR6oU37JDdXOzMnPrKHqVAoWGnft2tMyjXTgsSdaAq5c5oaemf8XNhnDEqUiLI1jcAoQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HSEcgOMH; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vguG+nBVysomhSmhb1wmVjJLYf4SKvakOy8Ig/e6oJILb7k9Gk1yR3PAvsBkhwAI2uC+MFIb0TIZt5xtLMx7DYPBUWzRVKv6U5pFh0teOxS15RkHOc+b8o11fUgD7SydGNbs4SZJvMEaDRVt1d8zRIbwL7KJW7z7nqwTgHqwDFYI/k/JYhzamaeKekgifYyYy4vGC7rKM+EHOU2gjdXPxtKpt9t4SNSuJIXvq1bEcvG15HE4hAL+vrfmlMzhbCWRBl69k8nxvkVN7VFPrd6RLNaM1j7CnXV5/YtIxN9jy+wPXk03PD955OlTfDGnsxxu+nb39kSH4heIW2MB3y+JEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4TuNsNYXSDyCCPvk0IpCO93IWs08Z77P3pdxhTtwYw=;
 b=lwYh7/RYWQvCF0v4pQQIVYBHtOBj8tb6EiNaeMBGS3IAFul59gaf+zXrG11KGol75u6ZCJrkid8i5FqB4HA95aEPnnhk9Bcu5lIV82gXxWP+JHp2W+Ta6RaSTr1KT5JezSG79YURRyhXLoPzoZo9uUusfZzBY/jshW6D0ybWaLp3C8Sz3px7IVaoZWat10Etzv0ZwZ9Q6fZB2NjyvNrAnPAyszvX0qImpJZnVdsBY0fyqPUr9eaZL4a2UZ/n2Grj1BO1GK8USFE0WJNWBZvz+mpQZJf3R67tWWKlS39FV14wKIqGNOZeI4SMF4nsG7eBQxP6hLcS4BZhZyZliWUEWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4TuNsNYXSDyCCPvk0IpCO93IWs08Z77P3pdxhTtwYw=;
 b=HSEcgOMH+Zf3iL0NhuZrifuXsi2aCZ6h6bts8BWf2HqNw2otfOWxhu87pbEykPH2oa8g0FnirQu1Eg52GNq/KtT/DUlxUD4obBQ940Ur84VMV2ylk1HpVIAuamJzj2zmVTn+OTJf01vnQTQyfDLatqe9AJahN7Nd4uwQO9QSNV0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 DM6PR12MB4060.namprd12.prod.outlook.com (2603:10b6:5:216::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.19; Thu, 27 Feb 2025 16:06:06 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%3]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 16:06:06 +0000
Message-ID: <9e35b27f-affe-4345-8a87-07f4f285b63f@amd.com>
Date: Thu, 27 Feb 2025 21:35:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] KVM: SVM: Add Idle HLT intercept support
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 babu.moger@amd.com, neeraj.upadhyay@amd.com,
 Manali Shukla <manali.shukla@amd.com>
References: <20250128124812.7324-1-manali.shukla@amd.com>
 <20250128124812.7324-3-manali.shukla@amd.com> <Z74_HQaQ1jY4eKBB@google.com>
 <454ba4ae-4be7-49ae-a9b9-3b25cad8433a@amd.com> <Z8B3l8VGA2RHRI1j@google.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <Z8B3l8VGA2RHRI1j@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0136.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::23) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|DM6PR12MB4060:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d405d98-a15f-474e-1840-08dd5748a400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkFrNkp2UzNvM1Uzb1hzYjJTelNmbTRBMEpMdVRKdkRsUm15ZlVLTEIrbzFG?=
 =?utf-8?B?VGlwM0hia2t1VzVVVjdNeGFaNTdUQXBRQXBFa0Q4WWtITzdRbTB2Z2VNZHk5?=
 =?utf-8?B?aVdXdlk4RnFJTXlxcUNsY3hDMWhHNzlTYWVxVk10OE9wYTlRVlpYQ2JMNXdo?=
 =?utf-8?B?bDEzVkxSSzNJK0Y1N0V5dHMzZVk1QWZkYVVleDJEQmFqMDE3VkxxNU50U1Zr?=
 =?utf-8?B?cFJJa2dtWHVLRmRzWTZlcGRiVDdrekVreFVPZ1lxb20rQW52d3pobjFWcDhh?=
 =?utf-8?B?cGxVZ3JZcVMxVktXYkcvNW1rT0pJWThzMmtUNjlqRGU2d1Fwc2d5dms1c0s0?=
 =?utf-8?B?MVJVTHpGUzVGSU85TzNTWkF5dGd3SEIzSFZLejRJZkRlcCtZcXRVRExZWjQx?=
 =?utf-8?B?QS9IdlNQS3djc3dGb0JoR2lya3cyWms4OGxpMmZlRUc2WVpab1hnMU04d3Zt?=
 =?utf-8?B?YXZUNm83WGpTVHdmRVoyUGRHN3hrQlU0N0lEVHd2UFFmeHFCMEVrOHN6M01S?=
 =?utf-8?B?VlBYZHR5UkdaeWZwMlhFemFFRmxlcTM5MW1ta2c1TStrZ2t2N1cyZEJvbDhj?=
 =?utf-8?B?ZDluYWpXQ2VVbTJhUHBCR2JpMitRT3BtdWJjajdKMG5KQ2h0WGllNHpJdjJu?=
 =?utf-8?B?R0JVazRySDZFeHpDdGhNNzZQMHR3U0pKQWMzU1FadElRNGUwcERLZS9UNkt1?=
 =?utf-8?B?TmpDWlVuTWxKSWVsc1g3RzJIVTNCeC9qZytPV3FwLzJIbDBLdVZ4dkxXMkxM?=
 =?utf-8?B?WmxzV2RyVmJuS2pEVHQ4eEJOVUZCcGlBVW9DUTZmWHVFMDI3OC9BM2ZTZjRB?=
 =?utf-8?B?RWdSS2djaGNJU0ZVS1l4ZlpSWVVpVnZDaUZ0N3JZRWRUQWNNTENVanR1c0l0?=
 =?utf-8?B?VGMvT0ZvY2RmV3Z1aVYzZ3NxaHZKRDBvSEhocGp0MnVEeXMyTStZemhPN25Q?=
 =?utf-8?B?ZU1SOUZiUnVUakU4WmVnSnpzZlFKRGtlL0luQVQ5ajk0Y2MxYXZ2WmxyTnBJ?=
 =?utf-8?B?WVZOQ0J0OTVLN2l1OEkyNGVFMUtRSG9XSDBGN2FCbEdGRmIrMjZxdXR0bEp2?=
 =?utf-8?B?RHhXNW0wMUxTOFVqSkRKN2ovRVFZV0ZCMjJvSDdKY1NaYnAvZmtIMkQxR0RJ?=
 =?utf-8?B?NGZqT1F5ZXlsR0toTzZndDVyeG1KNjVMVWdZRGVBWkN5VWYzUW81cUIzWEVF?=
 =?utf-8?B?TFgxSWRHRHQ2YlBBTSsydU1HUnQ1Vk1YaklxUXZFQ0F4RjNKRmFOWDJCMmdQ?=
 =?utf-8?B?aG85UXN5Um53KzUwa21hZGVDOEgrMjVOMzFmRVcxTE9sRTRlMUczTkhCUUFX?=
 =?utf-8?B?VVNzcmlVOGt6MjBvUWd3bHpoWDNhZjJlWVNSVGZlUTJQdDB1S0lLL09RVmY1?=
 =?utf-8?B?SXc1eEFGVHN4OWUzUzN5UlJyWVNBcDVDVURXeGdwU2tLRmx1ZlJpUFB2MGts?=
 =?utf-8?B?dzZIUFZsQVRtSTQ5dmpwZUhlSGcvaVEzZmhDUzdPYURRcGlYRUcrQlU3WjV1?=
 =?utf-8?B?Q3JNWmIxUHlzTno5bHFhdUZ1V3JORW5nUTMxaCsydDdrcnlBd2VVNFRpMEU3?=
 =?utf-8?B?azg3Ti95RGhyZTcwTDBNYk02WGNXM3d2YlVoZVl0cUd3ZmlTRmxLaFN2OXVw?=
 =?utf-8?B?dmNCNWxaRHdaLzVQTTg5VUhrVzh1Nlh0ZVE4MzNwaXNyMHJaaHZZWXYzdnZx?=
 =?utf-8?B?NzZwMDRmNjllWldXR2xSMmwrU0lZRk5KQVpLZFJtVWJzWitJV0NEYVNWb1Ez?=
 =?utf-8?B?aGJCR2liN2ZTVW1RLy8yRkd0NzRUamVyUFJxeUo1RHlsaFpxaU5LdmNsSzI2?=
 =?utf-8?B?ZVB0WXA2Y2VoZEZEYXUzWTJieGZWbU5lbjQxZDB3U3VWNm5ReTNleUVNbGc2?=
 =?utf-8?Q?gtcY6nFEFLnEb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHVVVHRMU3lwMEx3RFpSSmtJeWRZdDY1MUxhQkFZdjE4S1ZWU0JSR25WU3Jm?=
 =?utf-8?B?M0tOdTNUd2wwaERtc3BCNE5jYzNXaDQ2UXc0Mkd5N2g5QzNEZ1RZZkhqajFn?=
 =?utf-8?B?L1lrdWpzbWVtVVRXNnBqUG5aT1RVU0xib0MxWDR2UUVXNUVSb3YxRnVWUlBW?=
 =?utf-8?B?Nkpvb1hnYUZIeGlvYi9TT3JnSUNQWTRyak0zb1QxcUIwSFJsejBuTVJPemxr?=
 =?utf-8?B?eTBqWklTVlRoOE1CdzMwU3E5YVdBNU5pem1tckYzcDFIL1NjWTJvWGJNU1hV?=
 =?utf-8?B?OWZ5UkxTbnQ4SG9hdHhJMlpUTlZuYWlJdi9qdUtZWm5JTDVMWjZVbXgwWVJs?=
 =?utf-8?B?KzFYM3NXZU9hMFJuR2h3dHZOd2lKaGdzazl3ZnhuY05Sd1FPcFBzK3pPaUli?=
 =?utf-8?B?VklFRU00bkFvdEo3WjAzWUlteFN1UjZXZVZTUjE3VXo3aUhkZUJaaU9Zalh6?=
 =?utf-8?B?VTZqdXdPb0RTUWgyWk9yanB4Ukg5YlgwUXU0L0JxU3ZQaVZITXNkd0cvWjRm?=
 =?utf-8?B?R0gzOEhIUHFRRWRFelpZRzJ0VVQ2cG51aEZ6RE13Z0RXalRRWXo5VStoM0l6?=
 =?utf-8?B?MXFMMG4wSTBYaVB0ditDaGpHWjR0S3l6WnRtc0ZoanlLb0ZuUHU5bGFPN0Vw?=
 =?utf-8?B?QndrcFBnV2NvaHJpWTBwQXp1UkxrWW1FcEVDNVNTMi81TmI5L1hhU2ViQ2xK?=
 =?utf-8?B?ZlcwVlFhMVJrOWU3Ulp3eEpKbE5hTGxpbk5GWTlxTk1xWVMraE9od3NDcWJL?=
 =?utf-8?B?WUViYUJINmFxUU82SHRTYzhWL2Joa2JsMHVYdWx4YkN2alJ0a21JWUpTemdH?=
 =?utf-8?B?STNGNjFUZk5Tc2pHZ3JrbWEzSHU5VTIzYTRpTkNNTW5TaUViNFdNWjJYaEpX?=
 =?utf-8?B?R3REY3Blb0srbWJlbDdRczI0UW56S0VheDEwVFZaajRXY0hocmtaYURaTnJy?=
 =?utf-8?B?SnhuMy9QSFJPTGU0aUdaZTkwazlhRHh2b0JHU1g2K1NoUzhxUkFyY3BJUVo1?=
 =?utf-8?B?dHpWY1BYZmNzaFNacVVnZnhVM21sRnF4bkc0dFhvU3V0Y2FzS0hoRHJiOUtl?=
 =?utf-8?B?L1lZUnBLdFlld3dSR1BOTjdpU1lFUGxGd3YzeGNPOWlaU0FBVzliaFV4ZytW?=
 =?utf-8?B?NC8xN2lZUUoyVHJ6Z2F4TnoyMktZRGtNdmhnY21vWC84WENva0tTMGlzcExx?=
 =?utf-8?B?bDloSVg0MzIxWWZZbmhhRmxVaFBxTW1OMUREUUdocnplby9uT0JGa25PNUxX?=
 =?utf-8?B?c0tTZHNxdUlLZUdTSGNmREY4WERvM3FjOXdta3FxSUZ3S2p4UC85Y0ZIODIv?=
 =?utf-8?B?cDhFcHZIc1FXeXBDL2Qxc0g1MXlBT0ovcVlvOTNpYmdjb051djd2cnZndzZv?=
 =?utf-8?B?bjVia2xWUGYzcmZabU9Bd20zLzZ0dDY3eE9HWndtRmN3UFlETzlQdVRncm5n?=
 =?utf-8?B?cnp0Tm05K0xLN043SVJsMURSVG8vMmpTS3V3NStsY1plNXJDRHJZc001Y1U2?=
 =?utf-8?B?cy9DbHc4czhhMlFFa0src2tUaDcxR1I2SkVqQUZOcXM3c3h4MXVSZlVTcU1s?=
 =?utf-8?B?eTFYaVBLa3JoNTVvTVdqUDFIWmRnUHZ4b2hTOFQyUjVUamZhQnBjMnNXWkg2?=
 =?utf-8?B?UnN2Qlc1Qm9ySU9mQlBHOHNma3N6dlB5NHFDb2kvYkRKUUJaNWVuekl6RnFH?=
 =?utf-8?B?K2RubmQvbmwydUxFNUwrMjJiSENFMFFTK0tlSWxvWXYrVkIvMmNJY3lwOS9q?=
 =?utf-8?B?dzJJbDJ5L2tFSG1VNlJyR1FPNkdIUUNDWW1aeFZRWit4WDliQUIzc0p2Qytn?=
 =?utf-8?B?cFV3OXhPbTdvckV4NFoyZGVDQjV4M3dWR3krTmJRMkxsRGRzRmxkQjgvWHZE?=
 =?utf-8?B?UDRNaE1abFlBZ1ZKUzFtQ0JiM0cwUUoza2N1dXpOUWFzbEh1am9DcjJSSVJ0?=
 =?utf-8?B?WHRIcjBYdWtnUEZ2ME5HT2dHdno4cUZuNVRjRDZWNWRPelNMY1QwNisrdTd0?=
 =?utf-8?B?N1NYZjdiK2RWTzdmcGFLbkM4bEozMkJDbFlmbFRieXQ0MWJkM3ljdUJqSmky?=
 =?utf-8?B?cStSNlhqSFlIbHRabmtLOFhWOFFpemlPRm9SeFJLR2sraVdqK0J4UEl3U1I3?=
 =?utf-8?Q?DXhZejAi1cEQX9CGBoqtTB5fY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d405d98-a15f-474e-1840-08dd5748a400
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 16:06:06.1474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H02xrJEO++TgyAIVc9TH9ZhcpJGIiErQEguCIEQlZxeZMpaWXVHUkdlxGSvSw+M17Og1HiFyKeZbOIy+WjRPSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4060

On 2/27/2025 8:02 PM, Sean Christopherson wrote:
> On Thu, Feb 27, 2025, Manali Shukla wrote:
>> On 2/26/2025 3:37 AM, Sean Christopherson wrote:
>>>> @@ -5225,6 +5230,8 @@ static __init void svm_set_cpu_caps(void)
>>>>  		if (vnmi)
>>>>  			kvm_cpu_cap_set(X86_FEATURE_VNMI);
>>>>  
>>>> +		kvm_cpu_cap_check_and_set(X86_FEATURE_IDLE_HLT);
>>>
>>> I am 99% certain this is wrong.  Or at the very least, severly lacking an
>>> explanation of why it's correct.  If L1 enables Idle HLT but not HLT interception,
>>> then it is KVM's responsibility to NOT exit to L1 if there is a pending V_IRQ or
>>> V_NMI.
>>>
>>> Yeah, it's buggy.  But, it's buggy in part because *existing* KVM support is buggy.
>>> If L1 disables HLT exiting, but it's enabled in KVM, then KVM will run L2 with
>>> HLT exiting and so it becomes KVM's responsibility to check for valid L2 wake events
>>> prior to scheduling out the vCPU if L2 executes HLT.  E.g. nVMX handles this by
>>> reading vmcs02.GUEST_INTERRUPT_STATUS.RVI as part of vmx_has_nested_events().  I
>>> don't see the equivalent in nSVM.
>>>
>>> Amusingly, that means Idle HLT is actually a bug fix to some extent.  E.g. if there
>>> is a pending V_IRQ/V_NMI in vmcb02, then running with Idle HLT will naturally do
>>> the right thing, i.e. not hang the vCPU.
>>>
>>> Anyways, for now, I think the easiest and best option is to simply skip full nested
>>> support for the moment.
>>>
>>
>> Got it, I see the issue you're talking about. I'll need to look into it a bit more to
>> fully understand it. So yeah, we can hold off on full nested support for idle HLT 
>> intercept for now.
>>
>> Since we are planning to disable Idle HLT support on nested guests, should we do
>> something like this ?
>>
>> @@ -167,10 +167,15 @@ void recalc_intercepts(struct vcpu_svm *svm)
>>         if (!nested_svm_l2_tlb_flush_enabled(&svm->vcpu))
>>                 vmcb_clr_intercept(c, INTERCEPT_VMMCALL);
>>
>> +       if (!guest_cpu_cap_has(&svm->vcpu, X86_FEATURE_IDLE_HLT))
>> +               vmcb_clr_intercept(c, INTERCEPT_IDLE_HLT);
>> +
>>
>> When recalc_intercepts copies the intercept values from vmc01 to vmcb02, it also copies
>> the IDLE HLT intercept bit, which is set to 1 in vmcb01. Normally, this isn't a problem 
>> because the HLT intercept takes priority when it's on. But if the HLT intercept gets 
>> turned off for some reason, the IDLE HLT intercept will stay on, which is not what we
>> want.
> 
> Why don't we want that?

The idle-HLT intercept remains '1' for the L2 guest. Now, when L2 executes HLT and there
is no pending event available, it will still do idle-HLT exit, although Idle HLT
was never explicitly enabled on L2 guest.

I found this behavior by modifying the ipi_hlt_test a bit.

static void l2_guest_code(void)
{
        uint64_t icr_val;
        int i;

        x2apic_enable();

        icr_val = (APIC_DEST_SELF | APIC_INT_ASSERT | INTR_VECTOR);

        for (i = 0; i < NUM_ITERATIONS; i++) {
                cli();
                x2apic_write_reg(APIC_ICR, icr_val);
                safe_halt();
                GUEST_ASSERT(READ_ONCE(irq_received));
                WRITE_ONCE(irq_received, false);
                asm volatile("hlt");
        }
        GUEST_DONE();
}
static void l1_svm_code(struct svm_test_data *svm)
{
        unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
        struct vmcb *vmcb = svm->vmcb;

        generic_svm_setup(svm, l2_guest_code,
                          &l2_guest_stack[L2_GUEST_STACK_SIZE]);
        vmcb->control.intercept &= ~BIT(INTERCEPT_HLT);

        run_guest(vmcb, svm->vmcb_gpa);
        GUEST_DONE();
}  

Let me know if I am missing something.

-Manali


