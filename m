Return-Path: <linux-kselftest+bounces-11234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7E08FC2FE
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 07:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62DDB2859E6
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 05:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DC813AD14;
	Wed,  5 Jun 2024 05:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2Pfd+/Oa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C952F13B28A;
	Wed,  5 Jun 2024 05:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717565029; cv=fail; b=Cf/QLLUrH+GqXXHX8vV9AbiL9IEmCD8jp2aDskP/9RXrKOrAW6u6MaMFIeCESzMtHW6tvvbLznsNKflcG1B0sAcp3NJbzteouSAbM1xY3NPz+1AGC8MXUGFJn6q8CXET2L7OJzOaY42cpEia62uGNoPEVfpP9cUN7FEgDBx57Lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717565029; c=relaxed/simple;
	bh=10W1TcgjetChhkDEstak3tgqnn7MzTuUarv6RIbLq9Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HUqdW77n+Is0i2/g21j9ebAY1yM5Nt5QrbDk+PUy3iFVGTFNZhwidjBccMC4isO032xvQ+BnLhLbkXF6wQ3ELbG3/qinWp4TBmge6dqf+JdCWccKWp8zzKkpAG4r6jYcOA9LhKsFxUsu/+oXdapzzh6KZRu8KZ/HMb4I+ZvK100=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2Pfd+/Oa; arc=fail smtp.client-ip=40.107.236.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RskPAYCPkw6j5DltUHaI9JsMShfPmEYDgU/d05rEixIR7FuAGS5uN1j4SjEHQAGXviy4EuXkjlI5+bdrSl6/gDPg3g5eEYHSUo/wnXmxbWti7Z4MgbjV+q0VdwTLOQmYW+oF/6bWfQYAZwF01LOI4+wICPSmGWR8XvS8PzKmXPLj32y+tGklv77JyZU/Agy2bI2+2Yv0syQLl8ODvtDeSkE3iuIbwWfXvO5FIh3X2L8Kxyw7nZcbITc4XHd7NCCfLSMLWGWFXnXx/Fv5mU8sWOQj904A4SFg5y233aKuh1DUBCC0PabKJC1tjDy6lxcoFrn4D/ZpP9l3eT5BeJ/qvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuAKDl+pZ6anUTnpzrQGmCmJ0+/DC/F9S7qT6iktB+0=;
 b=lvp8ZgZ6qcScZf7JY9uYFdNn8ib28hlZYcXdzM0Vs7ItoCJX9TzwKwVUPVEb2nG5pnA1zN2sl0vx1lCOIkdDGN3g06ftbimPUvCBNbLCm1romBTIdVIDMl1EY90O/0mojl6bUxqrW3Fpey1JtCfrIyJPF8IXxF6J86SHX07YMWtr5nZZHpMMv0Tj7Fd1IGEqBBeRbcPEMurnjk0W8yVpMm96Mx8R8ggZ7gBhrZF6HdBVm2bNT2a2l6WCON+rGQlApGOTFygbmXHWgziki6hQzc2s0tpOB62NKTwGowkPJ8vdHf+gDiH2THNJUvl/oVOXeVdi9f4zoVc5oagGJ9apsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuAKDl+pZ6anUTnpzrQGmCmJ0+/DC/F9S7qT6iktB+0=;
 b=2Pfd+/OapJWoKCifkACbvJZpk4hTeSREcixVMCA9ZHoJIqyEZrgweA2TZ+OrkCVzj3CPLnZL0D3tbGoOg0X42QHiEvzGOy82brn1ntvvwXnaEUS1TOm3k3RYCcYpuVy2RZ4ArC1Od+Myq9gMUqNYqbkgjMb+iRlR+ptuXxbnWa8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 MW4PR12MB7465.namprd12.prod.outlook.com (2603:10b6:303:212::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 05:23:43 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%4]) with mapi id 15.20.7587.035; Wed, 5 Jun 2024
 05:23:42 +0000
Message-ID: <b8a1ec22-b125-45c7-bb09-3ed2c0c4f271@amd.com>
Date: Wed, 5 Jun 2024 10:53:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: selftest: Add family and model check for zen4 in PMU
 filter test
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, manali.shukla@amd.com
References: <20240501152451.4458-1-manali.shukla@amd.com>
 <ZjJghQ25H-ttaV4b@google.com> <7a5ffaa2-9b18-4700-b4b6-da414333d894@amd.com>
 <Zl5A7GuqAKCZ7I5M@google.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <Zl5A7GuqAKCZ7I5M@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0065.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::9) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|MW4PR12MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: 945e9446-9ff8-4965-3028-08dc851fa9f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3A1VGFoWUhILzJVZ0dscDFyU0JZMmNYcXJua1ZsMUIxN0VaaERQN2dPS1g1?=
 =?utf-8?B?NDd5cWhsRHR1UDBpUExXTTBudlhCYXhvd3pTdXNBcUtzWTNuQWt6ZWdlRFJy?=
 =?utf-8?B?dGdyNTBQalhlY0NGV0VPQ2Y0Nk1MdHN3a0srZTJTNHkxYVgxdnpLWmhUcDhr?=
 =?utf-8?B?NUJxd0xNSHM3K0k2RGVsNnpEQ3RLcjNNVjRXSk1oNE42bWVmSVhNU3NDMEc5?=
 =?utf-8?B?a25jRkxtT2k0WTRXREkwalFnWUdwd1Z3WDZjVFZVNTFYTXV0R2Vqem1Ed0pM?=
 =?utf-8?B?U1kzbDlPWXdjUGRUNlFWSHZFYVpPemU1eHIzM2V4V0srbjAzMjVock05WENH?=
 =?utf-8?B?U0FPOGRjSGh3cENKQlJjTTBIbVNmdUtoZFFsLy9LRi80NVRialFocThiWjRj?=
 =?utf-8?B?UENhYjcraHZnYVRhN3p6cjYxa3VCSWtiNDUzQnRFYnpoSnB1c25OekRtd2Yv?=
 =?utf-8?B?aTQwdmdQSGoxcXNyZ0k2QlhWdlV1QzVORDJSSVVYUHdiY2NCYThOTUNBU21x?=
 =?utf-8?B?UW1WY3BtcTJhaEpSZXhXT3FwZ0NpWHZWU0ZRVVVNS01jYTNzanRiL0FIa2p1?=
 =?utf-8?B?T1orYXg5UGZoMzRiS05rZGZzc2VnakNjTnJ2TURiK2UzWHRSRU5MemJ6V1hT?=
 =?utf-8?B?SE5FNkpNUkVQUVZnTXRHc1B1Ym0vR3JmWG5kSmxBKzdLdmdKVEIrSlFaYjJI?=
 =?utf-8?B?ODE3RVZzM3Q3VTBSb1JqUWxzZ3NKY3BGK0FtRFp5V3dXR2RsdXNpeGIwdWhB?=
 =?utf-8?B?elFnOTNLUzRRNStocjlGR1RvQ2dMR25yWU80bVo2UTlNZC9HeHZpUWVsTThs?=
 =?utf-8?B?SzhyNTJFblZYTXhaQi9lYjlGS1VSdHQxdUNvV0swazM3MHpJT0FCcUtNaHNt?=
 =?utf-8?B?L1g1STZkVnNCS0VkTFlLUDRBS2FtQ1ZPNEdRTFg3Wm03MkRVZUZJUHYwY293?=
 =?utf-8?B?S3p6N3crR3U1M1R5ZmNCamFXYk1STU54dTNaNlFBN0dpaW5XbExySjZqZkd4?=
 =?utf-8?B?SE5VTENxekg4dDZ5UGdUdEFicmF3aDVvMktqUDJNZ3EwT3RlZDlIVlpuZzc2?=
 =?utf-8?B?SXh4WE9zemtvVVpYZVNmTEJ3ajZxL0Y5eHVIUnNOL2hldzRaancvM3pjNVR0?=
 =?utf-8?B?T2FpUUxKbVVKVkR3VWtZQk54bnJkYTUxS0Y5dExRa3ZiZTUwU1pud2NqNFZO?=
 =?utf-8?B?b2VvQjYwTk1kR2FldUNkR1UrSGVJNWx6Y1ZiUWRLVExTRXgrZFlsSkN4KzRM?=
 =?utf-8?B?ekxOaXhQZTIwdzZRWi9DNzh1RjAzRW9IMmQwQTRmRDdVaEU2S1dScFk2L1FN?=
 =?utf-8?B?dkZ4d1JWSVJyanlQdUttM2dEOGFrcm83OXJtNHRRZDlSdXFSYUNVYlNIaEFS?=
 =?utf-8?B?akxzZXAxR2pRTm56QWx2OXRmZ1YxV0FTbWJHNVNBdlBrWi9zVVZJOVNnWEZD?=
 =?utf-8?B?QnF6L2xaM1pmUG5XWmY1cHprMEllVFlIZlpzZmNPN1FrWTRSNms0M2YrdzVX?=
 =?utf-8?B?Zm55MldnU3g2OU82N0ViWm5hR1dSNEpxOEg2cTBhRmJ3WUxwOHZ6VTRCQlpV?=
 =?utf-8?B?dlhBbElUa2hpZU9ha1lGTExrc09TOENGSHhoem8zak9kL3ZjMEU5R0ZIRTlU?=
 =?utf-8?Q?ASGmOYL9AHrM31Zkv4fcocsSWO4oo9T9mgvK4bO6DThQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnBiWWVERERnUmhQaHZiandwUVpici96RjNycUM5ekRZc0dvMkRibkMyd3BX?=
 =?utf-8?B?TVYvbDhqYmJpZmJEQzF2dVprWEFmcHU4YW92UGdLb2Y0V1BOZGFPTFVudHpL?=
 =?utf-8?B?R0lLVlFZZ3ZsRFgzME5uM0d1KzZyNlFNNmpYSzBuaGM5cVlsci9QV2doWFF5?=
 =?utf-8?B?SVFwYWdUSDJzQ1ZWK1JXOVJlSHAxb0k0VXlSS2l4ZzBlSW9EZjdRRG5sL1FW?=
 =?utf-8?B?dzZPNzM2VEdQWUgxTGRoNmtYaVFCcU5sSnpoQTJGUzFYRjJnYk1wWDY0ZE4r?=
 =?utf-8?B?MUpuQnlOL2V6NEdldDNKZG5RK3JrL0JqZ3g1d0NNcThmekNJRS9iVjN0VEtN?=
 =?utf-8?B?WXBCbTlpU3RzaGQrTXJoU0JkSVZuVGNlL2dkUDAxODBjZTdDYm5SMHVyQ1Bn?=
 =?utf-8?B?Qll4VkFFbnVmdDljVmJHOU9RdEdlU1lFdHZGUHFkTkV0QVlWVlJFTjU4d2Ri?=
 =?utf-8?B?V0R4TjBnQ0hWZVJuNVIzSjdkcGNsY2VKZFkrQWlnODJYcC9uMHVwVDNYR1F3?=
 =?utf-8?B?bGpibmhoZytBK0ttcUN1a3JOR0Z2RlhRMnVPVEZUVUdPakduZVZ4Q3FySFY3?=
 =?utf-8?B?citqQ0h4RTlJYkpoTkRnaVpWNTdVS0xGWFVVUUNLQ1pabTdUVG9HZExJckpk?=
 =?utf-8?B?Z1NlZ0Z1dVhpd2R5WkUxQk02YlU4ZnRIL292SjNITVZucFNzaGIvNmY0M2kz?=
 =?utf-8?B?bGtRdWVYN3U1ZVZGeUZwQkY4dXBJNnE2d3phaFpxdmpzTDN4eVY3UXlpc0JM?=
 =?utf-8?B?YitsZE0vM2h2cmR3dGliQ1gxM3NsM0RuM05KSGZ0eVRsMDZMdnVyRXNFSWYv?=
 =?utf-8?B?bk5kRHoyOHE2Y1lmQUovU0NQQnNFNE8yc2hSdEFWb0VDWlpCWUkwQWx3ZUFU?=
 =?utf-8?B?Y25JUEN2SW9jOWFzMG1teVNzcWV4ZjJLeXU2OUk4WEM3cHpPYjV0UFlRU3Bq?=
 =?utf-8?B?QTNuc1NEeUsxa1NzaHlNei9BNzFMcng2YTFobXlQS2lKeTJaTlpTeTQxdDVI?=
 =?utf-8?B?NWdSVzRTMC85eEFybGVoaFJnTDlBYUlYOVpUSGk2bXQrQWdFM1pNUTVod1FD?=
 =?utf-8?B?RjJJM3loUkk1eEdHY2tjb01GMDN6aHdjNUgyVnF1TEVSWlZXUC80TldkKzdq?=
 =?utf-8?B?SDVhd2NWUW9ISXFRTE5XcWUrcFgxemJqbUFMREcxVGRmV2lyT1o0QnU0Z05v?=
 =?utf-8?B?OGEvRi9CdGNXZm0xNDVSY3ZKaHRNUlR1Tlk5Zjl5bEtwcWo1eGU3b1hzOEJV?=
 =?utf-8?B?dllXMHQxcWpKdnUvYitVS3FkYnN4Ri9FVTQwbURmZUhjZU4xOThTa3ZZbzVm?=
 =?utf-8?B?Z3ZVcWM2UnlGR0tOUVFnWU5WM2xoV0l2U3Q4SXFNRzZ5UXFhbS9JckloNlU3?=
 =?utf-8?B?bnpWZHlaeDhRZHJsZVFqR0RWejc3aHdrMGhqQ1RMWmhWTVVPbkNoUWh3ckg0?=
 =?utf-8?B?TVlna3lHTC9objhMaFM3TEthT0t2Qm1pZnVqM1VGOVp1NEhJbk9kRnlDeWhF?=
 =?utf-8?B?ejBLd2NMckdETXA4REh3WG92em5wOFhXOVJyNHRaeWtwNmZ0UHMwcE04aURK?=
 =?utf-8?B?clNnR2xMUyswZHVLNlpFZ2dObFBHNllHelpsV0RBNzVwbytqQ0RrSmcxb3Ez?=
 =?utf-8?B?NUhVWDdxNDlETTR3dmlhckpSWkpWNVZKYm9TUWlTT01uLzNzQnlHZU5lMzJr?=
 =?utf-8?B?MGdGTHd0MTRTWDkzTS8zMjl3dkNmVyt1cjIydEwxR1pGVzRtcXdjUWpMTnBF?=
 =?utf-8?B?WktuTm5IVVB4RjJVS1JNdDlFaDBHS3NRT09Rc1Q2UElFUmFKc3d5bGpiWEYz?=
 =?utf-8?B?dFlTdDNERFVramh1SUNSeXM3cGh1RUFHdEtZWDhISVNyc1BRVGhldkU1Z1pJ?=
 =?utf-8?B?ZUpxSjl5c1JWRUkxc3c3QzRaWFhEcUJOS245cG1hVm1HVGN1TUsxUmwzZktp?=
 =?utf-8?B?K25hYkU3M0dVNDRMZDJEYnVZVW40S3hvVGw4SWVZWC9Ld011T3VCM0gwNFNN?=
 =?utf-8?B?cGJRQ1RKb1JYZ1ZsRTcvRFRRYUlNRGkvdzk4VWRhT3JOYzlYUTJHSHRBQWhF?=
 =?utf-8?B?OUJWTlVRRVcyWis0OXJrRWVXY3BDQVZGNW54aU1lT0xUam5NRmsyTFJ1bEVH?=
 =?utf-8?Q?yrK500XqvKjy0idDYchAmKgXA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 945e9446-9ff8-4965-3028-08dc851fa9f7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 05:23:42.5790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5HPwX13AMeVVO7Y/RNLjpI0DkSbkvyY7+w/4GtPCXRVNv2/TfBOdPUA1CPl9QivB/GLtzIjT6IOBrMoo/pd54g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7465

On 6/4/2024 3:47 AM, Sean Christopherson wrote:
> On Tue, May 28, 2024, Manali Shukla wrote:
>> On 5/1/2024 9:02 PM, Sean Christopherson wrote:
>>> On Wed, May 01, 2024, Manali Shukla wrote:
>>>> PMU event filter test fails on zen4 architecture because of
>>>> unavailability of family and model check for zen4 in use_amd_pmu().
>>>> So, add family and model check for zen4 architecture in use_amd_pmu().
>>>
>>> Is there a less ugly way to detect that 0xc2,0 == "branch instructions retired"?
>>> E.g. can we instead check for v2 PMU support, or are there no guarantees going
>>> forward?  Pivoting on FMS is so painful :-(
>>
>> We have confirmed with the hardware team that 0xc2,0 == "branch instructions retired"
>> is always true going forward, we intend to maintain backward compatibility for branch
>> instruction retired. Since event 0xc2 is supported on all currently released F17h+ 
>> processors as branch instructions retired, we can check for "family >= 0x17" for all
>> Zen and its successors instead of checking them individually in pmu_event_filter_test.c.
> 
> Can you send a patch for this?  Please :-)

Sent. 

https://lore.kernel.org/kvm/20240605050835.30491-1-manali.shukla@amd.com/T/#u

-Manali

