Return-Path: <linux-kselftest+bounces-13794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84295932F8B
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 19:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 042FA1F23CAC
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 17:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAE51A01A0;
	Tue, 16 Jul 2024 17:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TlAXJnTh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189A413CA99;
	Tue, 16 Jul 2024 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721152773; cv=fail; b=c2ewD8SNdvVXFSq3hGuUb6/FnzOTKdRIqZYxsMxLjox36f6v/IltvcSVxv9BazCIPEEZxiu2oj+PRF1v/26kcb1IcXsXs/dmoq5FOBoQGrYX83J1kGuWpCqqC8kbeRwIfnUj1s1FDQ8FmlK8BuXebicQOZzwFUshwGKajhC6CIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721152773; c=relaxed/simple;
	bh=Q9MYZqcSkrDG1VUEWQBhLLJ/HeJLOGPTIcc/wMqzGi0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GCUQujQin4eLUFO1bxFZ7Pa3aaI+i0XywtK0ts7w76P0Jay6DHk5QAURIVT/hATwCv6X+im3Rd81EYoqAfQigDivr6sNxLecE5U7fu7/QKSBvzgpIjvrkwLIsFsxhG5JswbkJ5T2Q9iDHBr+a9pDb/fWYKT1kETPPzgNG4lgIXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TlAXJnTh; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ycUfGJZMph5MYFLVe39t0SCoi4UC7KsBo3Si1OFXkou9MpsgdTwup9wfi6ZNu3hOpseshxj5+C6ebzQ/izQc9oxPy9Sv3Wc47meEfJWy8MCQcuEAUAZBPht9gbg3AXTt5ghf8oBVWUyGKuPRnJ5BO9phyGPkjf711oSWjNOjE8XtSPVE0/gf5NBESvZKQ3j0dOVLykb8zpiQOk1dv0fHWRH1PIFXFQ16hJum/W0GNandSNT8OhPnfL9Jnbz1937uM0BPZRJVpMwuRdIAWzA9OXtFOChDGU0JSSVRA4YKSTnNkPT+WcZgpHF5qKpAhDdgaIGZiN7AJfuPperS21Crcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bvkz1ppAenDDsV7gWOEdJXjMWOKVPMBHhGzw9qyPJWg=;
 b=unyCuGIUwtMmFXrXjerLnl4K14uzMKVn62yyXdcQsMzw1OilMDlgY7wtaVinZev8x4rtE0/vYEYSLlichRqLr0OoivFbsZ9A7sMD3XhPNohwn3GBaIUEa6ziZFTGE42HyomlGUOAJf7H4WS22PDk7GGJOcosxwSLLfQ9nyMwC1sP+JgIx3tqsggzENQec5TmNm0n+ahyvsTEBgkNEJN6HEucqkhiJ+muNIToZ4/uDkdTddzlEFrTQv7A5770RcbllfKR95UMW/+JhCITFaZnQLcvGee35DNmU/i+NQrN4pugQjnM0Xg5Y0A0VXTm3vr3hfG2b9FLNkLwjf6mND3osg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bvkz1ppAenDDsV7gWOEdJXjMWOKVPMBHhGzw9qyPJWg=;
 b=TlAXJnThGrbxPonz4EwRwQ9vynmyJ6XhFJE1E56cVB5PPljP4EueK1+kqWNWDp9MxvISfjdoesBfuK48OEkJEFHvntsre0fVe4m6kFuKYWiSw6CPKNp+M8N8sXSjQe2QAFcwHD4LvDNNOV1XFnDti7EuCPt1AxSFgBLS3YxOVuLt1eG21LzoZxgTTXCa51n/2fPbqEybzgm1UfRBiDF9Sgg5yp90aXlHqEHENBtlt76vT3qXjnta7PlRJ9Cm3yBRTkVF/zX5waDv45F/h5Ji6wi5Q87mUaCIB6dr2hESNx/xSiK/hSZAADwq0RovysH+vp8Ma2fW61InrBGDtRZg9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CYXPR12MB9277.namprd12.prod.outlook.com (2603:10b6:930:d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 17:59:27 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%2]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 17:59:27 +0000
Message-ID: <423013a8-3973-402c-b835-543ae6a29546@nvidia.com>
Date: Tue, 16 Jul 2024 10:58:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/rtc:Fix a resource leak
To: Shuah Khan <skhan@linuxfoundation.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rtc@vger.kernel.org, shuah@kernel.org
References: <20240710071650f7265b40@mail.local>
 <20240710074309.6647-1-zhujun2@cmss.chinamobile.com>
 <20240710075513332c564f@mail.local>
 <8e4d88f3-a45b-4d30-bec6-75636c854d43@linuxfoundation.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <8e4d88f3-a45b-4d30-bec6-75636c854d43@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::49) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|CYXPR12MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: 9acb593a-625c-4ddf-e0ec-08dca5c108ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGx3Vk9VVVhtcXJtVDRJbGVhSzNNblBkNm9BSVIzUmo0SHFmU2NaenoyRGds?=
 =?utf-8?B?eG53KzM5YUVRRldmSHQ2OFBNa21iZE0rdUR1VGVYQUVyRnhaVWdYZzhOZm9T?=
 =?utf-8?B?Vm1mNGVkbEY5ZVBvbXFWanc4aERNZUhibFVleVRXYVI4c1hwUjRHbjA2YlVr?=
 =?utf-8?B?VkRFSXBYa1Q4V1FFcGs2a2ZYSnUxdGk5TWlVWjFKL2RaeHpoenRadVYyS1Yy?=
 =?utf-8?B?Titwa2tFOWEwSjE1ZUQ2MzcreGFScGVIUW9qRU5LWWNFUkoweEFoa096SzVR?=
 =?utf-8?B?RE5kazFxbmVxb3hKcUVLSVpNMUdoRWlJZFpCSHpCazZBWEFhcHRxMC96MkhD?=
 =?utf-8?B?UElHZFBLazNZdzNKcGdTMnAzSDY4ZCtZUEhvbFBSckQwNzJZN3BKQ2FRNzUz?=
 =?utf-8?B?TWU2N3hzSCsxWEllMlJjbkhyVmxZcm4wcTJIUDh1Z1lGajhDZGRhOHpHMkJU?=
 =?utf-8?B?amJpVW1iVW5GVTBFdkN3NFZGZ1JrM2sxRU5qRVArd3o1aTJDR2I0MVBuUjRq?=
 =?utf-8?B?NnJpWFQrZGZzSnBtT2lEc2lmR254ZzJuS0x4N3V2RjI3VFpzWGVBTzA0Q2Ju?=
 =?utf-8?B?SnFDWU9HMW1jVGUzeHVjVW13Yk9leWQ1QjlaL0UwbDF6MHZHTVZFb2FKQzI5?=
 =?utf-8?B?QzlLVXc0Q0pkTzk2aWp1TS9QNHRpbHU1R291Vi9UaHA5YWxROGY3em1ZTTVU?=
 =?utf-8?B?VlBJVXgwQVpGWW1wZ0VvcE9UTVFVZStwQVNQTWxWcTdoRitJUkw3NDBFakNi?=
 =?utf-8?B?RWVYSFNvS2ExZ3JvZFhTS2N5eUdnNjhqbUE5dThHWWRqRHhYUVpzc0xha2VY?=
 =?utf-8?B?YzQ5Ly8wSjRGOXNGY2tHWlBvOXExVTd2NTJOMDRkaDJqS3ZpQUZvZDc1N2RZ?=
 =?utf-8?B?aDZRTzRyVHFET1M4eG0rMnRjaURoUGhQZ0N2ODJ6ZGE4cDRYcklrdHZBUXFZ?=
 =?utf-8?B?a1lEMXN5QS9oVm1oc1dCcS82Z2hjUjVLN2JTWE81dmMyUXBjOG1ma1JzMmda?=
 =?utf-8?B?Vmw2OUwxVWRwOXR1YjhPS2dGb3RjQktmNWRpTHFFK2JlaHhXOW5hTkZIVHE4?=
 =?utf-8?B?ZTRwaVFRVFVJWEo2ZWlRMThlV0oyYmNSb2dNVEJvTzRSUU9wYy9hY0pyUFda?=
 =?utf-8?B?QU9GbUc0ejRXSU85bGpUcjNkVnhzZlJJS1kyNExBRDVZUjZxajJwdFgzbUZo?=
 =?utf-8?B?T3VvbEZNRzdZaGRralVtL3J0ZmRYUU5nRDBIaFBjUnZISTUzT2ZGOG1iSlhw?=
 =?utf-8?B?TlRhbnN6akxIejRRRTRuYlY5ekcyK3pGSVJVNGdrcVdTYmJscUVGMXVpbjNC?=
 =?utf-8?B?UlRBWnRORkhQQm1QVG5VT2J1ZEYwazZIRUU0K1NOSTNsbjN6VGg1cFk0WEJu?=
 =?utf-8?B?RHhwMXRUekxrU053VTR3ZEQvamVKQVZWMys0UnljOWJ1MjgwUis0b3lJeGlm?=
 =?utf-8?B?Y2cwc25Ydm05R2xNNkRjcEhCWEZQWHZHNFY5bUxsNEk3bmp4TTF3eXo0ai96?=
 =?utf-8?B?NnRmbEZHS3IrdlpOVDNVMlEwSER6T09WV0xUWGxobG9ENHc1aTJDVjFmZUpT?=
 =?utf-8?B?a3lvUHhvTVAySXpUVjRMT3p3bVIwKzI4VjBRK21KdVhaNkRFVDV3R25XM3B3?=
 =?utf-8?B?cHZrV2FXN2RWZXdOQWZmSVdiaGxIUUlUZU40YWQzNFp1M2NrRFFUN2ZsZ09x?=
 =?utf-8?B?VEl5c2VuZXZUSU9CNXBTNlRWYkNjVm85UXZIeTZFWXRqVTRkUWVJZmQyQUdS?=
 =?utf-8?B?Y0hla3FrdG1sRVZQRkl3NUptWHBneXJxSzNBWGZDWVcxZzZKaldSeWtMc2FZ?=
 =?utf-8?B?RnRnK0NRTTQyVzFDd3BUZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWMrNUJMbW5Bb3E3U2Fpb0ZGQ3ZTU0hMaCtWRzdwUDhNNlJCNUYzQlVZRDA2?=
 =?utf-8?B?RWIzYzdUOVVUd0tHZXJ3QUZBU1kxaVBDRE84NkMzazVxL3FTaTM1MlJqWFph?=
 =?utf-8?B?SWJhOGxsMTFhMmNEOHJZV3lwUUtqQkV3Vk5ZUFhKejEzQ3p6SjRpNVNGQXBB?=
 =?utf-8?B?N1RZVm9SaHN1NU5vUkNlb0ZuRXB2RWk4MTJiWHhrZnJWTVFoRDhRb3B2VTc5?=
 =?utf-8?B?ZGpmYVlLVEFNRFFxWitLL1VHT2k4c1RXR2dTSEZid2FyTmRyUmdPcWZzRkNV?=
 =?utf-8?B?bE8weFpjS000OVpza2JqOEVjZnJaWm1nM0V3SEJWOUx4TjBGQ1diTU11c2tn?=
 =?utf-8?B?M09xNng4VkFrWE56OG9uUDlsd2YxQThObWdQWUxCeGozTmlESUtDU1NCNGN0?=
 =?utf-8?B?Y05RaENsNUkzSnArV2xmREFvNUpKMGtEQm9obHBuWHc2ckdKNzNlUjBxWkVG?=
 =?utf-8?B?YXFIem9XOVFOTlkyQ0ZtS09aSkpTSjAyTkhjcWxBdnM4UTNnVGxEd0FJOU1m?=
 =?utf-8?B?cU1OWmx6T0IxcFFJakRTU0ZjOVF6WGV6Z3VGK1RhdDR6cVdLc3BTUlpGclBw?=
 =?utf-8?B?Z1o2am9uVm4yNHk5NUxET0dwTGJianRJQlI4Y2tBM2IxQmxIR2lrYW01bU0z?=
 =?utf-8?B?VFJzUkUxRkV3TjJ2dGo1NFZVZ2kyZUI4S2JXeE1uaUZYc04wUjYxT3pUMFNU?=
 =?utf-8?B?TU1ISGtDdlVQaXBndTRyb25IaVRGRmFnU3dCOE9ublpCYlJQTmpvRWU1THAr?=
 =?utf-8?B?UXNQek1HdWpjUkdmQnJsZVhadGlQSTU2TDNmc2JNcURBVi9IeUFsUDY0U2dm?=
 =?utf-8?B?M2h3azNXNFloNE1jK08vSU1WN1ZnUHRiTTlDSC9mLzAvR1B6VWtjL0cvSXda?=
 =?utf-8?B?TG5UdG9yRkVVemQ3YjczQjIzaUVWbFV3Y1dGY29iN01zTnZJeEtUT0VVQnpV?=
 =?utf-8?B?OEtxYTVCTW1ZNDdpRUZVVSs5UzFnZ0tBNkZONEtoODZ4VUNBNEFRT2RXblN0?=
 =?utf-8?B?M3FadVRBUmFWUTRPNkREQW04RUFONUtEdlUvdzZWUlUrUDU3QzJvTmxQTDZo?=
 =?utf-8?B?bjN3cjRGeStvVXJFUDZqQ1lOUzNEM0tsVGM5N1NicmN5ZVBTdUpKeFg1R2oz?=
 =?utf-8?B?NWRTbFY4UGtUa1E1Tm9zNzU2c1FmRWVsRDVldEthdm1TUHlsSHJPQkdIS2ND?=
 =?utf-8?B?a052MGtxQkpnMGpCZE1qd0s5MUtDV3lQWFpBQUtUYnAxdy9PekxPdVFsR2N5?=
 =?utf-8?B?cGVNRVhiSHJlU2UweGxsNmkwTmVkWE4weTRUbndCbUlPWEZVWUJUZkVSSW9S?=
 =?utf-8?B?RXUxdUYvblE4WS9YR3lDdTVWSy9ldHhxZmt5VXJkdnRrbVZ3M0M0bVlLZ2hO?=
 =?utf-8?B?enBwZXNxcGs3SXFaZStjNjhHWVgwRXFnOVNrSHgxWXBJZjBkdEFJalpXYjB0?=
 =?utf-8?B?eW1vVkRnb1VwQXZEOEd5UWlMVTdKMllna0x1WkVFd3BUQzRLVGkzYlgrSnlG?=
 =?utf-8?B?b3VhTSsvSDlHR3NrVkxPTVZpVmdVNUhIY1JIN2NNUjVzOVFpc0tGeDR2VGw5?=
 =?utf-8?B?WDh1ZzUwTFluQkthelM2N3FjeGFFcEV0OUwwcnZvcWhqMTR5WDNjRDkrV0Zx?=
 =?utf-8?B?VU9CTjNhNU9lVVUrNlRMa0ZpMEVZUU10STkzOUFLN2NxUUZVWFF2dXYyZzlv?=
 =?utf-8?B?MDBqdE9oWDRmc0diVjI1YU5tdGpaT0p3Zy9mWDNtUEJUT2t6SFlyckg1a2Fq?=
 =?utf-8?B?cEloeGtWQkJkT1M4emsyNEMrNVVQNmxHb0ltUDB6K0kzUGxkNVZ4c2dUVnZy?=
 =?utf-8?B?eHpUZVhZYlBtV21YN1FGSGpGU3ltMXlwRXYybE9KYWRpNVJaOEtHYngyUXdF?=
 =?utf-8?B?TnBnRjZhMlBkbm50bVIrcmRnVThyaFNXblk5ajhrTlZkYVRHaUEzSUlQV2Ft?=
 =?utf-8?B?MEJPZ21tTkwvZ2I3MG5oay80UVlpWlBOK3BNbUs4d0tSVU5vcnl5a2tFVUJF?=
 =?utf-8?B?dTUzRENhQmhjQ1hhVDRIMkUvMVU5aFo2R2hicjVnNENPNWdLREh3emF0S0hm?=
 =?utf-8?B?WjZZWDZsdm54cTAydlowSFNPMEpHTXZUK3owdlFsTWppOEUxdHVoWUkwbmtH?=
 =?utf-8?B?anBSQ1hmL1lkK2htK1pjSjYrL01DUy9FSzFoM0UxOTNwTE9XZHNJQW1IMmUy?=
 =?utf-8?B?eGc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9acb593a-625c-4ddf-e0ec-08dca5c108ec
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 17:59:27.8134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EICXH8pJoklFQFO9pIzCx5qht4oU3U9QSoBGOD3CW2HUWohFeEQetu7SeSSuATalAO3qqaelQfPw6dhF384ITQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9277

On 7/10/24 9:00 AM, Shuah Khan wrote:
> On 7/10/24 01:55, Alexandre Belloni wrote:
>> On 10/07/2024 00:43:09-0700, Zhu Jun wrote:
>>> The opened file should be closed before exit, otherwise resource leak
>>> will occur that this problem was discovered by code reading
>>
>> The question is still why should it be closed before exit as it will be
>> closed on exit?
>>
> 
> Zhu Jun,
> 
> +1 on this. I have responded to your other patches that do the same
> in other tests. There is no need to make such changes.
> 
> thanks,
> -- Shuah
> 

Yes. What Shuah and Alexandre said. And the same reasoning also applies
to memory buffers: they are also released by the kernel at program exit.

This blind adherence to "good programming practices" is not helpful here,
because it turns out that selftests are small, short-running, and simple.
These are all desirable properties, because remember, there are no
tests to verify the selftests, so we rely on keeping them simple and
very easy to quickly read and understand.

"Good programming practices" is not a "one approach to all programs"
thing.

So adding line count to free something a few lines before program exit,
for tiny programs, is actually counter productive in this environment.

Zhu, if you're going to keep working on selftests, I think you would
really benefit from some of the literature that goes into the design
philosophy for unit tests. Google has the best (and most recent) work
IMHO [1], but there are others of course.

[1] Software Engineering at Google (Apr 7, 2020), by Titus Winters

thanks,
-- 
John Hubbard
NVIDIA


