Return-Path: <linux-kselftest+bounces-24243-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FBAA09D76
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 22:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2CFC7A05B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 21:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CA62101BD;
	Fri, 10 Jan 2025 21:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F0OocaJC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D6B206F38;
	Fri, 10 Jan 2025 21:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736546115; cv=fail; b=l9JOw+sI1P5yQcZFq5l2zYHGzORy1wgLv1u78a20tm92xliEnMYvPvSEgdgDwkGWT9EGdEAms1wKpF476AB6CnsuzTsnIavlcCJdWyI/IaXx67RetPu5AhjztL+9m0IITCZv0AxtDAvyw9E3EQ7G3GxVJ8AEgZT2qGD4RJerjyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736546115; c=relaxed/simple;
	bh=+TbpgjZxInqaXnDmYuwG5EkRODI1WmSiMqcu7GcT3P8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=axPVPieYV0ldwztVyKGmu6Q4OmZF9JttTEW7o1TT2HCI8ddQyF4CzwEbfN54TSpc5ELcEVA64FC0d7XwQB93XazE5BKZYHQ+FTi/0ZwpKkgBw0uVjJM+TBqCyDYD0iOt1dwIpUf7Ws9w9IVd9JqZRSFzal0Ui37VuFeLFfdymW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F0OocaJC; arc=fail smtp.client-ip=40.107.92.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FXjGV5S7No/e2GOc8DCr54wZwsTiyUsS0HBi4khokWIXGyCCSBkSe2kMvXzb7mQrCX2byY/n/FAviKyLksgR/dpS3fMxtwt7wbuIApH5W03g8z8mU7gRDnOMbPh/GCRDVPtMTInmTOqiGkx23jRDhbZNKbd929MaFQUlU/ZT0tZx7FSDdaGmowP3G9QPl92edSg7nC0r3PZKANnicU8mRnqFAgEf/gxBsgScIfFD4Fg698XlA/FMo6ra2aLebe4mnCEnHGokwSHMpWWrZxfoKAQyysQAesVNUJV2ws36b8VEnz2EQyG4UAo9TlF3rfdwRkRTC1FzRGXwLKNUdFNgww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=js6GTtlLRjMaq5OQ8QY5xvvyYaaL4/Fi/YVIsgJf9Os=;
 b=ppWV0G/1EFhO9Afqqr7jL0LRnJR8FfsBrjvDatJk6IjeUzNNAmNMCIiiGKeBZsjqs1K8qswFzUemmxHHvd3YpRFl9RBp2P3Gecw2917q30DKKHHvvWdasZCi1mrk8l/3WgaHkGPoWjU4mlqv2zPq/tg3khw22pabmtVTZw1LHjafHE/SIdagGX2P2Eb04hY+XMHpwN5UiYLZLfC01UTVrQu/pttkbhLXDtsM6QVfWFUQEbN00aGc3XkpGeMZ2nZUr5Z4sUj224DUE6EbK6i36YsA6zpAuYy38BBJZ4YEtptWt4sQrmn1oNVqx1VkLAEhqg3S9kM5vc6V+llgLszBhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=js6GTtlLRjMaq5OQ8QY5xvvyYaaL4/Fi/YVIsgJf9Os=;
 b=F0OocaJCXIyd/MGXUX7TWyEoz3Wx2X4sKn0ZU7FCtleSThYQLwqu0rlP2O2eXpTj8/6BM0a7jpg/Q+xQTCH65JHo40tUP1QpOiXVbzkyTD+e8lRYqodMq9YIuhz00Ufyro/K+xIRdxynkp8FqvNrCexE49AB2rLl6fWadXhzQTs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB7087.namprd12.prod.outlook.com (2603:10b6:303:238::14)
 by CY8PR12MB8361.namprd12.prod.outlook.com (2603:10b6:930:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 21:55:11 +0000
Received: from MW6PR12MB7087.namprd12.prod.outlook.com
 ([fe80::41ae:52ce:aaf4:eda]) by MW6PR12MB7087.namprd12.prod.outlook.com
 ([fe80::41ae:52ce:aaf4:eda%5]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 21:55:11 +0000
Message-ID: <a420bcb4-4979-4143-83cc-1f8f1f38dcc7@amd.com>
Date: Fri, 10 Jan 2025 15:55:09 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [sos-linux-ext-patches] [PATCH v4 2/8] KVM: selftests: SEV-SNP
 test for KVM_SEV_INIT2
To: "Nikunj A. Dadhania" <nikunj@amd.com>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, pgonda@google.com,
 thomas.lendacky@amd.com, michael.roth@amd.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241114234104.128532-1-pratikrajesh.sampat@amd.com>
 <20241114234104.128532-3-pratikrajesh.sampat@amd.com>
 <bc5650c3-e759-42d7-b993-1af838fd6a80@amd.com>
Content-Language: en-US
From: Pratik Rajesh Sampat <prsampat@amd.com>
In-Reply-To: <bc5650c3-e759-42d7-b993-1af838fd6a80@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0011.namprd05.prod.outlook.com
 (2603:10b6:803:40::24) To MW6PR12MB7087.namprd12.prod.outlook.com
 (2603:10b6:303:238::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB7087:EE_|CY8PR12MB8361:EE_
X-MS-Office365-Filtering-Correlation-Id: b7386681-b438-4663-b0d0-08dd31c174d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekdsZzB4enY5c0lhaEtUbXk1cHVxaVZobkNmVkM4S0R1OU5NdFBEV1kycmpZ?=
 =?utf-8?B?T1lwWmRBYWNHOFF1a05EcFBKeTJlZzRIUEZYcUhYaFNiWGpHZ0tjbXlTUmU3?=
 =?utf-8?B?WmlkbC9MOFdFQXpOckdqMkVlcmYyWUhSSVBFRENRMzJLdWpXR0RYb005bHJS?=
 =?utf-8?B?RVpjSFV3eFdTY1lsS3lyaVVKZGQrWWNPVVdldFZYTlBsME5PZ2ppcHFLL2Zr?=
 =?utf-8?B?d0NlaDI4ZHFaRHlGMnZQNkxKeHVaMEFPa3M5TGowVmVZWmNvSmlFTXFTdSs0?=
 =?utf-8?B?aXJScE5mWlF0WWFoYUZybnVqako1aWhZVWdaTE55REorb3J5YlFFMjdzQjlq?=
 =?utf-8?B?RE85cFpHeEp4Q1hWMWxKU3BvNVVISkdaUDVsemxNY0dBdWJkS0JzZE13TlNm?=
 =?utf-8?B?M0swOGFaNWVBcFRMYkhDUGtpSzdFWDEzdnRZRmpaTDhQb0N4NCt1SHN2ZTNK?=
 =?utf-8?B?REpxTEtoa1F3a2JBdEFTVmdVOHBxcmlXcnVwY3U3U0dUMm5qdjluMWIvRUgr?=
 =?utf-8?B?TGNXSUp1OTdZYTd5MmpmR0lqMEFWOGRuYUpGTTlDVWM5MUplMVE2QkM0NTc1?=
 =?utf-8?B?S2FmK2VSRUdkWWdDQTBqNUZEblJWY0hUL3RhZitOWXlZM2UybVBZeFZDUHRX?=
 =?utf-8?B?bjZJZS9MdnpNc3N5M0RicUo4OHNadFk5T3d2SmZsVTRaWndpRUNQYlFPM1oy?=
 =?utf-8?B?U21kUUV2NE11Zngzc3VTa2luNnhpeVZydUJOSFpRRU90MkRZeHZqcFdGYVVG?=
 =?utf-8?B?VlYxYlZYVW95bURNOEtJQ3FPdkNvdUdsdXUxRmdPMUptZXpwWkxTSG90cytS?=
 =?utf-8?B?M2RYVzlCTlNXY2s0SHFpYlZLVkFQWnlGcmlLL1FDNFdzdEs5NmVVZ2xoeURI?=
 =?utf-8?B?NWdlVjBPWGdxaHJNUnhzSzRxUiswaTRMbXduR0JUeVI2aTYzWDJxOHZDLzhQ?=
 =?utf-8?B?M0JzalQzckdYcEs3enlpRVQ0bmIxc0U4QkN4NU9vNHdlZmYwaEFiSjFYUm54?=
 =?utf-8?B?eWczZUFYWktoOVBMcEZDT2dXTVhhTWJ6TEdESlRUYWlqbmpKQ2laNTFzMllS?=
 =?utf-8?B?ZDZzK1lVNERhT3dCVHA3ZjdXSnp0RjZ3ZlByZ0V3RUhvSGRTNVpoRHpqeTVB?=
 =?utf-8?B?R2dwUzFxVVNYK2RNNXVuNEZaaERuK2pud0RTNFZjVTNxbG9naTd6ZHZHK3dx?=
 =?utf-8?B?TEJQdVU3Zm0ybmYxQ0k3V1V6cWV0YmJwaUNmNGNFdEpwUHFJREtJcDdQY2R4?=
 =?utf-8?B?NjRlTWZDZEpKc0RMZ0Q4OWh3VWhvMzNUWXlCVVlobmxBSGlCUG9TRldhT0I2?=
 =?utf-8?B?YXdyVmlJWHhWY1JQYWJ3MHR0V002d2pVa3NONDhEQWIxeHR0bm1OUG8rZ1RW?=
 =?utf-8?B?N25BYTRubmVvbFJTdnY5MmVVdmErSEdtOGpXQXkrM2Rla1Zsdkp2OWVGYVVW?=
 =?utf-8?B?RCtZLzEzUWpMVHVDWWNwT1hwVGt1QnlpZDdwTXpYRHpYcmFpOEdvQWpJYTNL?=
 =?utf-8?B?WDNidU1IejVVWjl5WWd0Vkd2VUlrYkt5TEgxTS95Tm1aOEFweFFkZk8zdms2?=
 =?utf-8?B?WExNdnZkODYwMGFrOUoxWklmWEZqYjdES1hPeW1hd1BYaERJdjdEcUViQ25O?=
 =?utf-8?B?eGQyT1dvcVl1SUxRVkl3RXRDMVF1VXRHYjA5QWZZY0tTK3kvZEd1RkFKOFA2?=
 =?utf-8?B?Q0VDOUFtcGhwcjNyMnlOQWp4eE5Gc2lZWlRIWXhJblRqRERqYnlRekJNUUl1?=
 =?utf-8?B?bDhMc3Z0RTJIN0lXTGxpWkdRK2d1NWpTUDR1RytUN0VsZGlTaVM2ZHVlcVVV?=
 =?utf-8?B?NjI5MUV5ZWtlS2tJU3kvbEJ5a0xlOFJ2ZFFCV0F0K3MrV1pseWlWS3p5SnZI?=
 =?utf-8?Q?Eyi3fFKWJxuPE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB7087.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RU40dW5XUzdvQ0dyNFlOQmxkYjBMUW5YbkNkLzQ0czN4TUI4TjhEQlh2UEds?=
 =?utf-8?B?VUtmVVQzeGVZOHp2Mi9DUGtpZ1hXNll1aUpybjBrUFlsUmtxL1h3QW9CMzFn?=
 =?utf-8?B?cWRqeCsyWnFrZ0NHVEtwRHE3WjQ1ajVCallSY2J5dVdTc3lVWkp0aWNVMUhi?=
 =?utf-8?B?UisrdjBVelhaZHl2KzJIWDhMTGdXR2FodlBVWENMOTlWd0piak1hWi9jT2E4?=
 =?utf-8?B?ZEFXaDgvV2h0bzlYL1diWGhIYVFXTVpvOC9WUXpVZDNjaVZUQk1xUGtHUUhK?=
 =?utf-8?B?bXZtaGRxQXFjY0VSVkhJaXlKQVVQMnZYZUFJN1VoKzdkYWoyRis2NXhQcWJP?=
 =?utf-8?B?cktGSm5TRjA4TXJlcnV2cXZHWXdQWW0rTVdwRWV6dlRrU21yZ1lqcGtzOGov?=
 =?utf-8?B?ZjU2WjZwUWJ3V0xxV3NvQzl5ZG9jL1NFaDl4WGN0bzVRQ0JoRE5NdmNZZ0Jn?=
 =?utf-8?B?K0hFZGd3Q0IydG83QmlyeE9yVlc0VFZiZVNqT21UcUphUnZwMzlEbmRUeHd2?=
 =?utf-8?B?Rm5KZHQ4alhkdzFGRnVRbzVaYzZPTjI0WGhYWCtlYysya1BNM2p2VytkbDgw?=
 =?utf-8?B?N1hjT0svcWlmWE5TOU5zUG84dlBqNDZhV09pazhKL1Fid1crdjBJVlN3VDlD?=
 =?utf-8?B?OCtmTVRkWTdCa0w1VkVuQWpkRDltVjduay9VZk12L3UyL0lEUmtIYSt0UU9y?=
 =?utf-8?B?UFg2OXM1eTA5eXdqcENWZlZzVmJqT1VjUm5sVTJ4T0k3bzBXWm5nVDVPTURw?=
 =?utf-8?B?T3ppUkRwK2gvQ0xYekZHVXRwTUUwN0UvMUp3eFYwaU9zRG5nQ2ZGT0dNL0Ry?=
 =?utf-8?B?aWk4aUplSUhZdnhmR0FSekVRbkJ5ZXFUT3YrSGR4RmlMcXRPSGFmL1ZBeVFs?=
 =?utf-8?B?YVEva0tzb1VnTkdNVjI0bEx4OG1mQjU3REZ6U1hrdGNWM3ZVY0U3ckhwZlZ5?=
 =?utf-8?B?U1R2L1ZFcm5KZm1xdjVOZkphTkZwZlJyTVRsUUZXWDE3VkVTTzlMaWV0MGpm?=
 =?utf-8?B?UGVhV2k0c0RMUWhSVUFBQlg2YzhLK1VwMmFBeDc5Q3dxZEFrL3p5aWpNY0N0?=
 =?utf-8?B?YWVEdEFGckxTK3owU1RJRlhZUjBJbmFnVHhSUE4yS2pCN25KWGgvSlZWRm5l?=
 =?utf-8?B?YmxkL0NmZmRGK2V4cjh4VFFXanRiZFRyVHRjS1A5TWdxMXBVcEpTZjhTaGtQ?=
 =?utf-8?B?cFJrcXdid2V3WURHMEdKSjJkWVVTZVlMNWFQdi9KMlkvWUJLN2N2SXNiT09i?=
 =?utf-8?B?U1h1eGI3TjE4VVB0ZE9jWmVXdEtXRHRaRS9mclliUXpNVXJTanozaVAxR1ZY?=
 =?utf-8?B?M0QweWlqNktPMktWdWhQTmp5VnJsMWsxRDJ6ZWxFeTRZajFWSlZsWm80eXoy?=
 =?utf-8?B?RDBDNlJkSUM2NTJLTHE0dEhTQnplSVhmSkN3ZFE4Nk9GT2VBTkpLMG5NWWJy?=
 =?utf-8?B?WlpnSEFhTGFPaU9Ya2F6WWJBMW9OekhnSWNXRXZXUjRNUmRkdnFJaVl6RU02?=
 =?utf-8?B?TllyOVY2Ni9IWTBiMGVkOWVVZ1dKRm9wRmR1S2JZU2JjTXJxOGJKOEYwdXJQ?=
 =?utf-8?B?MEoxUnJobEI1NkdkU0ZiS3Q3a2doSyt1bXJESzFyK3FUaXF5VU85T3dSQklQ?=
 =?utf-8?B?S016Z3h1Y1F3bVhVc3pxYlNJOWN6Rm96QUsvVVkxTmU5YjNUd0I5d0Q3ZmR4?=
 =?utf-8?B?eFh4ZDd3WG45REh4YmE2YkVlK2NyclUvNG5na0JCWXc4VmI0ZDRaVU8vNEFQ?=
 =?utf-8?B?TnhnMUk2c01LT0k1QWpaaVd4TVY1cGt2TXQvRWtqTmNlNjJjR0IwcVRjd1pV?=
 =?utf-8?B?RU0reXh3R0dPOElKTGtnUk1mdjYrOWVOMkgwQUEwaTI5WjRQQ0xwN1Qyb09p?=
 =?utf-8?B?c0RZZ1AxSzNQTmRFRlBVcEM1K2pTaHZLWm1XQzJ5NGlKVmk2N0Nwb3g2Ym5R?=
 =?utf-8?B?NGgyQU9aTEQ0K1hYSFBzUWJNcDZxNDZpZGpRSzJpT1hmNkJkeGxzeXI4azM5?=
 =?utf-8?B?Um5mZjlkWGJ0d1hxdGFEb2huVXFDbldab04zem5lTjNUcVlBQVdSdEd3K3VS?=
 =?utf-8?B?bjMyRStQNzZ2OWt2R2twVmFsMkxGQzBrZURoZmN2WVM3RnJFVDllKy95ZnFM?=
 =?utf-8?Q?e/0dCWNd6KiLJDgNSWQzwJXgf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7386681-b438-4663-b0d0-08dd31c174d6
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB7087.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 21:55:11.6907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sk4fnaBuWQDmrYXkDh6VVpq4rk+IeJzSzI4dwU0kyj/X4ZOYPtdmMNeZygb/N5YQuvYELQ1UFMdW0tYxBQIqNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8361



On 1/9/25 11:52 PM, Nikunj A. Dadhania wrote:
> 
> 
> On 11/15/2024 5:10 AM, Pratik R. Sampat wrote:
>> Add the X86_FEATURE_SNP CPU feature to the architectural definition for
>> the SEV-SNP VM type to exercise the KVM_SEV_INIT2 call. Ensure that the
>> SNP test is skipped in scenarios where CPUID supports it but KVM does
>> not, so that a failure is not reported in such cases.
>>
>> Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
>> ---
>>  #define X86_FEATURE_SEV_ES		KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 3)
>> +#define X86_FEATURE_SNP			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 4)
> 
> Additionally, please add KVM_X86_SNP_VM to the Documentation/virt/kvm/api.rst
> 

Ack, will add that.

Thanks for your review!
Pratik

