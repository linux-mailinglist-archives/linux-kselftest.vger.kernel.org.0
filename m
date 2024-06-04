Return-Path: <linux-kselftest+bounces-11177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9148FB20F
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 14:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDDB828306C
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 12:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EA2145FEE;
	Tue,  4 Jun 2024 12:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xiDchZWZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ED8BE7F;
	Tue,  4 Jun 2024 12:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717503812; cv=fail; b=rTTfsZH+AqBjiHfsBmYGPhdbtq8uGG9RtOa46X5dHqNLEwQeuNIyTcp/D/+QGJTIjQNxuDRjF/zELB5qkcNvHmxjumh1RiAwnd0zXhVPlpbvuGVq2MscQnX6h06PeaF89KJsUf0LHXqkqyN9OoXKvXLtds1M0PO4Pqurp4hhVQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717503812; c=relaxed/simple;
	bh=UctX4m5Bw2LR7LJSMx0tn0/+JYFKJd21xkOXpPvkfGA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mzOIlDVFZzvTgBdGTGyXe9hdvK+rN2EmYrlPolelGYb2JjloQ9NZLsRs7oDEhkqXoYW/U36a4F/Sq/9ZLXPQlkjS+6+Gq6z/QrY89gpVl20UWJvBrFaYH+qtF6KgCVWdaUEUNem1B6nG/7T3uL97afCznXhTpOZipmEkxIHB1QM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xiDchZWZ; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcKp8H2gTBp/u+I1ZVW/5UE/FgNeLoNSX9m40nieaIW7mHh4ChqD4DeyzNXAzcnvoHe2nBINQMIgUwIvI42B+641KrmiabBK5B6yxp3V2CD3+2ibfgYb/wfIqngFDsi6lR0PEbv/6nimFxBbKnyG6nSfraPlbrpaO38kRTttTwik/rRB9vnG19qY7DCn4oblxjqC19P5lQxRlk4NOgi/PBi+fiMBRvA+QOH9fskFqZkIlwh+83+FYRHo7euGL7DnyfD3R4wlc46iWBj+YoEU3WR9wlBAy3YgAIZolaaqtbxkTbxeylIe9WT/tlk4nvDznrQ1xrgyX/K0+8YR9NlKlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Upx3BeYYo8Jcn8XbEKChH9rY7zNSXqdeF+KKayDecnM=;
 b=BZqPc2wsk/Eoigch9Zo2+z+f+RIjnZcLfkmKmWMeWMLEPv0ANXw0G6VqdkHW7o2zFnqDj0iQSPmCuWlL+D4+ZS/FmAUM3guaxRGRCRfSE7ZFEW8ph7ZDobr7ttY25JX3m/m70bpi0Yv9iCqd2C5n3ma0bSFp8LbHNdvrU1QB7p6FUFrBJfHwpZz11CXQHYjiwM9rdTCWXBeNg4/5Uyjng8JIBsWUAke8V2gZw+1pccDfAPjWciwYWLfgeOlRdh3PHHwwYpPqUTvUr6APtFOQ9MpsBrIeMZe/P8WNPeOGfDWuk8XdkS4sCDgBenplTCpKhDvEM1lqjogIcjeF5oa53g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Upx3BeYYo8Jcn8XbEKChH9rY7zNSXqdeF+KKayDecnM=;
 b=xiDchZWZbZmK2uiZiPhrrs5RwOFO/lPu5mUT1b7ERa6sdGtTE61/AFgJISCd2fut5jLjw7N1wVcpY184bWTXpeFeJpvZ5h6ejnuN2FA6zHHK/9MlS+bCvzJCv4WIOmHp8URfe5FKSaxIckYnHbBE4B79SismOKlp7l9yRy0z52c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 MN0PR12MB6003.namprd12.prod.outlook.com (2603:10b6:208:37f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Tue, 4 Jun
 2024 12:23:27 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%4]) with mapi id 15.20.7587.035; Tue, 4 Jun 2024
 12:23:27 +0000
Message-ID: <009cbe00-dfc3-4a94-b6ab-9d6ec9605473@amd.com>
Date: Tue, 4 Jun 2024 17:53:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Add support for the Idle HLT intercept feature
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, seanjc@google.com,
 shuah@kernel.org, nikunj@amd.com, thomas.lendacky@amd.com,
 vkuznets@redhat.com, bp@alien8.de, ajones@ventanamicro.com,
 manali.shukla@amd.com
References: <20240528041926.3989-1-manali.shukla@amd.com>
 <CABgObfbz5kZZObu9dO=KPu8_mZvGmV1752SQzQckkrj5jPaTQg@mail.gmail.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <CABgObfbz5kZZObu9dO=KPu8_mZvGmV1752SQzQckkrj5jPaTQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXP287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::14) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|MN0PR12MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a46ed7-2cde-4a9a-b131-08dc849122e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUFweFZRMkt5SndBblFUc0tNRTFtKzAwb2crVStZSFdnYUdnZHlyK3ZyWE1a?=
 =?utf-8?B?VDlreExKR3pQWDlNdEJtT0ZnRitOR0lnT3Z4ejJMUFVBclRZSXE3VHpVbThG?=
 =?utf-8?B?cG9wVVlub0NaM1haQ0RVa0ZFaWVFZTRJU0dPQUhjcitJenlBaFozTTVGSlFa?=
 =?utf-8?B?c3J3aHcwR2VRU1FqQjEzUXZGS2xsL0x5SnZzS3lHMU5HUDRjWktzVllvTTNi?=
 =?utf-8?B?UmRWVjRIS0dGVmZBSnRUMVRVRFFHaFJENzlFaTBKRGs1TnlodFA3OTlNS3Ny?=
 =?utf-8?B?NEtZeU50VTQrakxNYWNVaVZCZVR4bmVQUkErTXNyUDRydDByUFhzV3RpcGMz?=
 =?utf-8?B?ZVdOYlFaUTNEWndOclByT3pOb2Y4dUlXWmJoaUdXWFp1R0Y1Ynl1NllZQnZF?=
 =?utf-8?B?UGo4SG1iOGhlMGgzak1BdnVhK29YSEIyVVRlSmc0TU5nMHFzcm9XVjFDWm5F?=
 =?utf-8?B?d29PdlJNSzJ1QjdUT2pIVWxhQmN4bmNiK2x6cjAwTzNPcGRHT3JiMHBUTDJ2?=
 =?utf-8?B?MTYrVlhWSHk2eEdxN21zS2RNR2QrQmhnbW9tUytsd0F3WlYvOU9KNGxaMHI0?=
 =?utf-8?B?YmxnVzk4TG52bDJDeCtTdnRTbUU1SWo5TGFIWktFRXdsQVY5SndDZkh6VWJT?=
 =?utf-8?B?RlgreGNDczNBWUlNWVhVZkMvcWVJdjJxTG5hLy9KTGpLQ1k1eVJJay9MSDU5?=
 =?utf-8?B?c1BWYWQrVXhHRTg0RnVUWW1ReHl1YkNudkFTUE1ob282SFI2aEtjQmhkZTYx?=
 =?utf-8?B?ZTZlVUFHN2kzNHU4Z2IreG1BWXZuMVVsWXBEaHUyMzBCT2pFTnhLb1RXR21i?=
 =?utf-8?B?N09DbHdrT3BReHJRNFdoMDNsTFlHWEZRSXRvS1NjaTJ3YVlEM2dLeFB4SXdw?=
 =?utf-8?B?QUdMZytETDJDbVlYV2NJV2ZrWnBkZTRKajg3STY5eG5CVXVjaDlkeDFSNGd3?=
 =?utf-8?B?NG9wOVk1VTFKY3Y4WVJWeGJaWDB4Ujk2MnZnOEV3Y0ZYUUVSWiswczVKcHd5?=
 =?utf-8?B?SUk0VEY5cjgra1NXZkxvd3lNZ1BmZGJpU1dLZ2l2aE9aNWN4Z3dqd1FXR1V6?=
 =?utf-8?B?S3hhR0hDWFNrdG43WHR4dEhkNExHc3poUWpLZ3JWSnBuRldHcmxqemFydXZV?=
 =?utf-8?B?TTU3RHpnaTVySkRITERSSXgwQmNpY0NjUEl3TlRpaVAvcXJPNW5XUUtXZm9F?=
 =?utf-8?B?QXdiMFd2eWNPaGJObXVsQXNEdzVEUEltQk1sMnhyRkRhWjAwdHo4SEtoNzVK?=
 =?utf-8?B?d3pKREtIUmJrQnFXbXQrWUxKWHhoTVMyVG5FRlQ4d2ZiOXBUd1M4d3VhUGdN?=
 =?utf-8?B?Mm5Kdk5MUHZVWVRDYWxZTnU2dFBiNXdWQU16UDFEMTRDTDJWT0MrNmhPK3VP?=
 =?utf-8?B?LytoTkNBK0tublpRekMxWUJ0dGhJSS9ROTU2U3FncCtwNXVuUmNNTGZpRHQ5?=
 =?utf-8?B?Wmt4M1p6aEllaTE4eThIVENsWFRaMmF3eDh4R2NqWlJLT3FPZ2tQQURqUEow?=
 =?utf-8?B?WGE5c3RsbHR3cllpY0R4dnpaM2FpeDNxRUtqeXlsZmFkYU9jdDNaWlV5eUJ6?=
 =?utf-8?B?dDdKdWNMSjhZcmhvNG9TNmtwMDRZTE9pYnpRUEFCS29YL0tzWVkxMU5ybnRF?=
 =?utf-8?Q?uvAGjbJbbzlZ+toJEYNWcO83PwGFbzv/HGoc3PrRB0FI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmdsdWpaVlRlbkZ2QjdTM0ZtVytyek0zcmpSVlcybXBKN0kvbzZoWmJBbUp1?=
 =?utf-8?B?KzJFK1BsUUNyM0FnOG42SjNRV2dBZHloeW96RG5Mbzc2bVVxOU9BdU9IN2Yy?=
 =?utf-8?B?OGpwTTZPV2tpQXc2SldDNUl2Q0hIaG9reDNySkx4NjV3UjhKbnozMXJnVDBG?=
 =?utf-8?B?VHI4US84NmRSQmVPTGZQYnRsUURPRE5VSjJJU0s3ZGhqRlJJY1kvSkNJOHhp?=
 =?utf-8?B?OGRYTmF4S1BTYWtxVzhIZlNyemtLaFJxVkQxRjhVaitiWkMzZDVXbDQzblZT?=
 =?utf-8?B?YnJ1Z0RlUElZQ2JBUlp0OHNUQ2gxSmk5ZVVmQ3VodkhPd1Uzc0VzZTZHSXlo?=
 =?utf-8?B?Qmo3V0dSSkpnVjhJY00xQUZtUjRTdVBJK2dDbU1wNHJaSGJZUDVzMzE2OUtS?=
 =?utf-8?B?cHBTUmlZVDdzOU0wV3YyQkdxdE1WT1FUWVF4a05PVUJZcGszdi9LMUUwa21s?=
 =?utf-8?B?VHhZMHhxREJoWkU3Nkc1aXNvOTZTSFA0MUJtb0FkT3AxWW1hbDZaRk4vcU8z?=
 =?utf-8?B?aDNJVER5c0hXQ2JyaUxmZjdPeFo2bVJ2SmgwUXBxYTFsek9EeUZJMVhoMGww?=
 =?utf-8?B?cko1TXJRSTNRbHhOSmRVdVQ0OW9odlhMUmorWWpYL1A3L2RidGUrWkVrYVhX?=
 =?utf-8?B?NEUxMDFxYTJrK25DY2RMRDc4ZzNrU2d5NDBqNnJPY0VJSzFLRUpHUlJvVm9B?=
 =?utf-8?B?dHdpc0V3WjNSMnlUVHFLMVFpVmlUbjBLMTE2dEdKbnRaTmZ6UXp1M3hzSlMz?=
 =?utf-8?B?Yk9iOHFMNkRxNk1hdTduRlpjQWtRQlpyYlVMQk9lWjZRditZNVFSYmU1U1RR?=
 =?utf-8?B?TzBXMjhTUVFwelBFSldud1pIVmJ3eHZLMkZDR3RSZnFOKzFhZitzVUxqOVZr?=
 =?utf-8?B?ZXNTd1JUamRvTkFPc1c2ZVQrdlR6d3BFQW90Y1gzY3dXZ0tRYjk2NVVvOFlN?=
 =?utf-8?B?TDdxVWE4eHErU3E2MEpmWjVreFdDU3N4MHhNQ0ZsLzFYanliSUFsclJEbEZ2?=
 =?utf-8?B?MUlhT0kyakJ5eEZQcS84T1l2VmlIWkhhVWFGcXJ6WUp6S0lST2F1MXk1Zk5k?=
 =?utf-8?B?R2JQdHZReXpSb3FUTzdCUlBtbWd5U1AxWEdOcXl2ZVgxQlhtcGlDWUFZMnZD?=
 =?utf-8?B?ZzlOVWgyMHRIdytXSE1JTmh5c01VazQ2RFNyNStUQ3dGdjlBRDlWcFpUdFM4?=
 =?utf-8?B?aU56aEgxY1hIWFY3aXdqb3E3VVpNdFNmV05xY0V5MjdKazlEQzZXMVlpQm5t?=
 =?utf-8?B?cGdwcHZLa1NCZ0N5aDk0cHlZTUczbEt1bW5ObU1MajhzNWdXdDdYZ25DQmFV?=
 =?utf-8?B?TmtQZW14c1VGMkh6N0ZSLzdLZ0JJelVXMG5oalhVdVYyTGZha2Q4eGY3T1dY?=
 =?utf-8?B?YnFXMnpRekN4cFQzVkNtcEVvOFVCVmRoYXZsRkQzZktmMDFwYUNxNXpRVGNN?=
 =?utf-8?B?UTI4ckhhTVhjeTZOWW0yYjhiOVY0Z2R4RlNLQkM2aHl0Mi81b1gvZUlrc0V6?=
 =?utf-8?B?VGl6bFJFTklMUnl1VndPNlhzeFJJWFpmYzRJS2tnUUQ1ckRtNkQ3Z3ozekIv?=
 =?utf-8?B?dHMycWpqYXhZbFAweTJEZ3Q1S3dka3NFNnlydjFkWnVKVlpCaHYwQjZXWlM4?=
 =?utf-8?B?NWJvSEpBMnBaejRrSmR6alJJbWdoeWNFVkJ6b2J2YlNoYysxcXBTZGFZaUVy?=
 =?utf-8?B?R3pVSGtRZDk2QkIvVWpyUjVMbUlaQ0ROSk8vZ0NyR0R0TGk4V2tXV1p4SVlz?=
 =?utf-8?B?V2xpWCtNM2h0RWVqc1FGQm1tOHp5KzFXZzNxZFZpNVJpUnNoaGs2cEkrT1Z5?=
 =?utf-8?B?ckxKeXFDVEM4ZldTdTRwVzVrckJpNUM3UWtoUFovSTh5amxSNGpidHVDc1g5?=
 =?utf-8?B?a05QL3lodmNZN3ErU1dMMk05RG1iSkdUa1hPZjBzcVErQXZtcVYvWHhLR0dF?=
 =?utf-8?B?RzNDWmVpU2NDN0VCMlBHekx6eW1mdE1hSURhdkNoYlZuL2xmRGtPcDVBQU85?=
 =?utf-8?B?T2tNNWZzMFA5K2lUN3FhRGpNZ203L0lWSHVIVU9Cdjk3TEVxeE5pS0R6eldW?=
 =?utf-8?B?WWtFM2J5QW83TVpiNVMzSFVpOWFteHQ3SjlWY1FCZURic1k3YnpreUJxSkY2?=
 =?utf-8?Q?NryP8XuLL0q6uboqHkjhon4mC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a46ed7-2cde-4a9a-b131-08dc849122e0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 12:23:27.4156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DLtrwa4ifyLNjBwvrmRnwsMwwoJgl5rjhnsmaDIaXCRR+uBq5QQ1aD/NB3/zNH9aY+oXTQEnNFCV+iuVoKpepg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6003

Hi Paolo,

Thank you for reviewing my patches.

On 5/28/2024 3:52 PM, Paolo Bonzini wrote:
> On Tue, May 28, 2024 at 6:19 AM Manali Shukla <manali.shukla@amd.com> wrote:
>>
>> The upcoming new Idle HLT Intercept feature allows for the HLT
>> instruction execution by a vCPU to be intercepted by the hypervisor
>> only if there are no pending V_INTR and V_NMI events for the vCPU.
>> When the vCPU is expected to service the pending V_INTR and V_NMI
>> events, the Idle HLT intercept won’t trigger. The feature allows the
>> hypervisor to determine if the vCPU is actually idle and reduces
>> wasteful VMEXITs.
> 
> Does this have an effect on the number of vmexits for KVM, unless AVIC
> is enabled? Can you write a testcase for kvm-unit-tests' vmexit.flat
> that shows an improvement?

I have measured the total numbers of vmexits (using perf kvm stat report), while running the the test case I have
written for the idle halt intercept in vmexit.flat.


Without idle halt
-------------------------------------------------------------------------------------------------
|    Event name      |    Samples        |     Sample%      |      Time (ns)     |     Time%    |
-------------------------------------------------------------------------------------------------
|        msr         |      524213       |       49.00%     |      592573933     |    64.00 %   |
-------------------------------------------------------------------------------------------------
|        hlt         |      262080       |       24.00%     |      154429476     |    16.00%    |
-------------------------------------------------------------------------------------------------
|        vintr       |      262080       |       24.00%     |      163724208     |     16.00%   |
-------------------------------------------------------------------------------------------------

With idle halt

-----------------------------------------------------------------------------------------------
|    Event name      |     Samples       |     Sample%    |      Time (ns)     |     Time%    |
-----------------------------------------------------------------------------------------------  
|       msr          |      524213       |     66.00%     |      502011088     |    75.00 %   |
-----------------------------------------------------------------------------------------------
|      vintr         |      262080       |     33.00%     |      147515295     |    22.00%    |
-----------------------------------------------------------------------------------------------
|       io           |        1879       |      0.00%     |       8784729      |     1.00%    |
-----------------------------------------------------------------------------------------------


Below is data for the average of 10 runs of idle halt test case in vmexit.flat
----------------------------------------------------------------------------------
|  idle halt (on/off)  |   full test run    |   ipi test run   |  eoi test run   |
----------------------------------------------------------------------------------
|          on          |       5048 .4      |     1289.2       |    1140.6       |
----------------------------------------------------------------------------------
|          off         |       4806.1       |     1318.6       |    1165.8       |
----------------------------------------------------------------------------------

The "ipi test run" when the idle halt is enabled, takes less time (~2.28% )to finish as compared to
the  "ipi test run" when the idle halt is disabled. 

The "eoi test run" when the idle halt is enabled, takes less time (~2.20% )to finish as compared to
the  "eoi test run" when the idle halt is disabled. 

The "full test run" when the idle halt is enabled, takes more time (~5.4%) as compared to
the "full test run" when the idle halt is disabled.
(Seems a bit odd, I have not yet begun to investigate this behavior)

Snippet of the Test case:
+static void idle_hlt_test(void)
+{
+       x = 0;
+       cli();
+       apic_self_ipi(IPI_TEST_VECTOR);
+       safe_halt();
+       if (x != 1) printf("%d", x);
+}
+
 
> The reason I am wondering is because KVM does not really use V_INTR
> injection. The "idle HLT" intercept basically differs from the basic
> HLT trigger only in how it handles an STI;HLT sequence, as in that
> case the interrupt can be injected directly and the HLT vmexit is
> suppressed. But in that circumstance KVM would anyway use a V_INTR
> intercept to detect the opening of the interrupt injection window (and
> then the interrupt uses event injection rather than V_INTR). Again,
> this is only true if AVIC is disabled, but that is the default.
> 

I have taken traces to analyze it further.

With idle halt enabled
 220.696238: kvm_apic_ipi: dst b0 vec 176 (Fixed|physical|assert|edge|self)
 220.696238: kvm_apic_accept_irq: apicid 0 vec 176 (Fixed|edge)
 220.696238: kvm_apic: apic_write APIC_ICR = 0xb0000440b0
 220.696238: kvm_msr: msr_write 830 = 0xb0000440b0
 220.696238: kvm_entry: vcpu 0, rip 0x406a89
 220.696239: kvm_exit: vcpu 0 reason vintr rip 0x4004ae info1 0x0000000000000000 info2 0x0000000000000000 intr_info 0x00000000 error_code 0x00000000
 220.696239: kvm_inj_virq: IRQ 0xb0
 220.696240: kvm_entry: vcpu 0, rip 0x4004ae
 220.696240: kvm_exit: vcpu 0 reason msr rip 0x406a74 info1 0x0000000000000001 info2 0x0000000000000000 intr_info 0x00000000 error_code 0x00000000
 220.696240: kvm_apic: apic_write APIC_EOI = 0x0
 220.696240: kvm_eoi: apicid 0 vector 176


Without idle halt enabled
 6204.951631: kvm_apic_ipi: dst b0 vec 176 (Fixed|physical|assert|edge|self)
 6204.951631: kvm_apic_accept_irq: apicid 0 vec 176 (Fixed|edge)
 6204.951631: kvm_apic: apic_write APIC_ICR = 0xb0000440b0
 6204.951631: kvm_msr: msr_write 830 = 0xb0000440b0
 6204.951631: kvm_entry: vcpu 0, rip 0x406a89
 6204.951632: kvm_exit: vcpu 0 reason hlt rip 0x4004ad info1 0x0000000000000000 info2 0x0000000000000000 intr_info 0x00000000 error_code 0x00000000
 6204.951632: kvm_entry: vcpu 0, rip 0x4004ae
 6204.951632: kvm_exit: vcpu 0 reason vintr rip 0x4004ae info1 0x0000000000000000 info2 0x0000000000000000 intr_info 0x00000000 error_code 0x00000000
 6204.951632: kvm_inj_virq: IRQ 0xb0
 6204.951632: kvm_entry: vcpu 0, rip 0x4004ae
 6204.951633: kvm_exit: vcpu 0 reason msr rip 0x406a74 info1 0x0000000000000001 info2 0x0000000000000000 intr_info 0x00000000 error_code 0x00000000
 6204.951633: kvm_apic: apic_write APIC_EOI = 0x0
 6204.951633: kvm_eoi: apicid 0 vector 176

From the traces, it is seen that hlt exit is avoided while the idle halt intercept feature is enabled.

> So unless I'm wrong in my analysis above, I'm not sure this series,
> albeit small, is really worth it. As things stand, it would be more
> interesting to enable this for nested VMs, especially Hyper-V which
> does use V_INTR and V_TPL; even better, _emulating_ it on older
> processors would reduce the L2->L0->L1->L0->L2 path to a
> less-expensive L2->L0->L2 vmexit.
> 

I am yet to try to test the idle halt intercept feature on nested guest.

- Manali
> 
> Paolo
> 
>> Presence of the Idle HLT Intercept feature is indicated via CPUID
>> function Fn8000_000A_EDX[30].
>>
>> Document for the Idle HLT intercept feature is available at [1].
>>
>> [1]: AMD64 Architecture Programmer's Manual Pub. 24593, April 2024,
>>      Vol 2, 15.9 Instruction Intercepts (Table 15-7: IDLE_HLT).
>>      https://bugzilla.kernel.org/attachment.cgi?id=306250
>>
>> Testing Done:
>> - Added a selftest to test the Idle HLT intercept functionality.
>> - Compile and functionality testing for the Idle HLT intercept selftest
>>   are only done for x86_64.
>> - Tested SEV and SEV-ES guest for the Idle HLT intercept functionality.
>>
>> v2 -> v3
>> - Incorporated Andrew's suggestion to structure vcpu_stat_types in
>>   a way that each architecture can share the generic types and also
>>   provide its own.
>>
>> v1 -> v2
>> - Done changes in svm_idle_hlt_test based on the review comments from Sean.
>> - Added an enum based approach to get binary stats in vcpu_get_stat() which
>>   doesn't use string to get stat data based on the comments from Sean.
>> - Added self_halt() and cli() helpers based on the comments from Sean.
>>
>> Manali Shukla (5):
>>   x86/cpufeatures: Add CPUID feature bit for Idle HLT intercept
>>   KVM: SVM: Add Idle HLT intercept support
>>   KVM: selftests: Add safe_halt() and cli() helpers to common code
>>   KVM: selftests: Add an interface to read the data of named vcpu stat
>>   KVM: selftests: KVM: SVM: Add Idle HLT intercept test
>>
>>  arch/x86/include/asm/cpufeatures.h            |  1 +
>>  arch/x86/include/asm/svm.h                    |  1 +
>>  arch/x86/include/uapi/asm/svm.h               |  2 +
>>  arch/x86/kvm/svm/svm.c                        | 11 ++-
>>  tools/testing/selftests/kvm/Makefile          |  1 +
>>  .../testing/selftests/kvm/include/kvm_util.h  | 44 +++++++++
>>  .../kvm/include/x86_64/kvm_util_arch.h        | 40 +++++++++
>>  .../selftests/kvm/include/x86_64/processor.h  | 18 ++++
>>  tools/testing/selftests/kvm/lib/kvm_util.c    | 32 +++++++
>>  .../selftests/kvm/x86_64/svm_idle_hlt_test.c  | 89 +++++++++++++++++++
>>  10 files changed, 236 insertions(+), 3 deletions(-)
>>  create mode 100644 tools/testing/selftests/kvm/x86_64/svm_idle_hlt_test.c
>>
>>
>> base-commit: d91a9cc16417b8247213a0144a1f0fd61dc855dd
>> --
>> 2.34.1
>>
> 


