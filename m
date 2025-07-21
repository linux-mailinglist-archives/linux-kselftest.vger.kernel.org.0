Return-Path: <linux-kselftest+bounces-37768-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9824AB0CA9B
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 20:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB38F17E58C
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 18:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC54528D840;
	Mon, 21 Jul 2025 18:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J7bZlhBO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B781FE44B;
	Mon, 21 Jul 2025 18:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753122860; cv=fail; b=IewVIZTOmyAVSRbzK3PUzNZDOBP79edR9Clrkpq9PvdQDkQevPBkiqtt4ptlojKle/NH48qtNukRAsQvlyAcGDZVjDoJERT6aSMfW+RyzfM2RrvZdeZmDFDtlDMrrvagNxsl/XuoBTiOEFpWaTzhm0MqMG7i4Ay1kQTAhImz7bE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753122860; c=relaxed/simple;
	bh=ZHWZMdZYqB5ZhFIT/FK0RpE92jxfkvy6UFTOG5CZX7A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kX8gukat/wxaqS+8cuKMscQ/5YdpfaJm7+46AM2K7OZFJiRFbRjRx8dJQ4qREJ6HiJ3lbpwhzAgaWjqiUGlkOdGdeVtVSH+jT/nc6+SWgR6eqYyiVZrKvgcI6XZV0knnwoaycdyJ1be5PofVziEjo5P2kb9ax1uQxqe+UTe0bvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J7bZlhBO; arc=fail smtp.client-ip=40.107.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=roGt6yZQIka3rVpuWlmjO5WEgHo5wp7RFuo7QqhcnIrmQ47UnMhYRj9/HgD+N1PP232oRzYCrsX4KJJUbRBoxfbkH4rHzefcSNVqtAvtIWNLmNicDuKzL4DvvFNzlC/R34bhjXCCsxPx64W+BEJ3TBlC9DlbsREvrFpSJkMSWe4GQtkF1my9BYrS3xflMap6FvzsuOF8FCfgf6PsP5JzLmzcLzxJBYdXltcy6sAKjj/oN4YQYCatgcpsawXcNUOYl9bJNC25UIYkY/pnV+iVfTub92qJuUvkxVxkqPYxJRh27544fcck2wtRAmRFqL+HICOjZL0TjtHxHh86R9Tuxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHZpxWc47/fPKtrx8v5CsxOXSjnJ0cQJbjY5gz30YLw=;
 b=yiIhidnXAxjEvCBu4oQA6r2kL6E16J7NNWdEHe0qaMZ937r33Sy3y2bbjVhcJnCd8hR8kY8euAFGSaz7rkFkUmRj9PaLR+1pG6Go45eIKehX+4iT3L4l3IJVHh3g1+yoPVkT3lXBScmo1Y63OIP0HuYoOIzeocIzV8EXyiyTfsORJa74s2dQo297lT/Q3CsywNF5u8LgCwCD/a/Ve5q7C4oAN7F7F6oFuw2CLnXxcz1WqtutJRFwrv5TrJGmFuxs+1BExQYcSnLDUhwSqfH41MqrWcDLxAs1xbG4mEB43ubz1oN8IwuI8hdXgWjvgMZD4T44OrLVJ54orx9SFHoYuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHZpxWc47/fPKtrx8v5CsxOXSjnJ0cQJbjY5gz30YLw=;
 b=J7bZlhBOJ3pZ9gwJzmY/PK+G/HnKP8NQykVOVHs1Ab8NGQiHwAQ8Q8qydLPeRvjEqDBItseDBdrchH0ovegdj0TCnLluQKBWtQoADNob1vOn5pK9TqP57MhMhicSDvow1XF1ve0/dxHPyeF2mjjOzoymaSKE47E9SOYuYuD/buJ9kCdOyK/rp57huQLGSeRFg+O5m/6nxG5RGpK4z70x4rR49E5SnvNgMbz9HuQzJN1AuQZYloDVdGqBk3bqfbKBVbaTSH55Ifw827VGuS0o/BZp7bDB7bm0h4KI6AWOu8LMjFMg7dshE8mTEmBZaVvnU/simtuvlQ4Tn98eMtBeow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by IA0PPFF4B476A86.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bea) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Mon, 21 Jul
 2025 18:34:14 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 18:34:14 +0000
Message-ID: <eaca90db-897c-45a0-8eed-92c36dbec825@nvidia.com>
Date: Mon, 21 Jul 2025 21:34:05 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V6 2/5] selftests: drv-net: Test XDP_PASS/DROP
 support
To: Jakub Kicinski <kuba@kernel.org>, Nimrod Oren <noren@nvidia.com>
Cc: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, horms@kernel.org, cratiu@nvidia.com,
 cjubran@nvidia.com, mbloch@nvidia.com, jdamato@fastly.com, sdf@fomichev.me,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
 tariqt@nvidia.com, thoiland@redhat.com
References: <20250719083059.3209169-1-mohsin.bashr@gmail.com>
 <20250719083059.3209169-3-mohsin.bashr@gmail.com>
 <ab65545f-c79c-492b-a699-39f7afa984ea@nvidia.com>
 <20250721084046.5659971c@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250721084046.5659971c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::7)
 To CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|IA0PPFF4B476A86:EE_
X-MS-Office365-Filtering-Correlation-Id: fe273949-874d-46ca-3c32-08ddc8853158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ek1GRzNnelRNYytobDI3SDBWSHBqYVpGTGVGN1dXLzc4OWJTeHdPYlNUSmFG?=
 =?utf-8?B?MFZaTGVvbTNXNjdEVUsvVnZyUlladWlKY3pZSDVFeU5XMUZLS0hXdDhxUksr?=
 =?utf-8?B?c2hyN0JCcDg4bWg1SS9Ld3A5RlpXOHBkR0N5OHNiRDVWM1VDNlQ1Qko5Y0JE?=
 =?utf-8?B?a05qWWlidjRHc0pXOFA4OEJMcm1QSUpVT2R2N0pnV0NISmF5bklJZ29zeW1R?=
 =?utf-8?B?QUtlU010WVA5WUNRelVYNUJsSjRtT2JXRUtRbnZBdDNkUW1SRTBxTTFNeUh0?=
 =?utf-8?B?SVlxUml2L2ZuWExvZ0VTUTdKVHRtK2s4bEJmbURsbkJjR1dZWDlTREF6SFl6?=
 =?utf-8?B?VWVqNlFPMkdUU1p6MU56OWFRSThwdzRZS3NqbDRDOEZhMFkrZXJCd1JtM0Jx?=
 =?utf-8?B?bHhpQi83ZWlybFJSV01WeUpBVjVsZ1RCZVRiRC96RzMzdjlSOUZGaG9hT0kv?=
 =?utf-8?B?ZHJkZjdLYkRwVG4xb2J3Q1hhK21UMi91WjU2akJsRXhQeklCVVJaMlRwNzlV?=
 =?utf-8?B?Z0xMNSt2aGxaRi9CYkxmRlNtemhSNzJOVjNHK29zVW9ZbXFiYy95bjMwajRR?=
 =?utf-8?B?ZnZ6NzRRMG1pWk1lQVpPWWF4NG1abjZ3TE9VRGtrRFZ2YjRRNm1TcjNVN2Vw?=
 =?utf-8?B?YktCd2VFTmZWVndhVFRDSFRpdVlVa2J4TDErdzc2bUlVRUgwUy9yMzNacExB?=
 =?utf-8?B?L3h3dGIzbFhMTnRVaUNuZzJKNnJkRE5HQnJydnloc2VJZTUrNllNSXowbk10?=
 =?utf-8?B?a0xRMUxzdTAxRTlJVVphTkNlR3cyUFVQVVh2VUNpV1pveDZXNVVtSG9vQ1Rz?=
 =?utf-8?B?S2tSMm03L1h0bTRvMGRFVHFybG43VEcwK0lHR3lNNUl0OGM1RXlwWDZheHNK?=
 =?utf-8?B?WU0rVGtKL2JOa2V1eGtUeW9aYmZmTVRLQTJzdHU5VGhmMDh5VFFMUURvRDlG?=
 =?utf-8?B?OGRDYWdFQ3FGTnVNYmYvMFBMbnBRTkNtWmhIb3FzcTY0ZTloWnJsQVpkT2JN?=
 =?utf-8?B?eGxOenRuK3hITkFIUHpOSU4wVzhSbmRPQkdjZDlLZ21oWkFkcitEN2pvMHln?=
 =?utf-8?B?eWNhcXp0ZVRjMXhSb3VSOE9WZ0VTOFN6Z3FWdm5rRXg5QmdDbldUMUh5VFQ5?=
 =?utf-8?B?SS91VUFQSUs2aXNldWMzWE1YTXQ4eW8zOXdyQ2kxZW41ZytmTG1FL1lrZkxX?=
 =?utf-8?B?TDZwcUJKQndWWUNzRGE4TmdFZGdweFZWYVB1M2NucUVjQkx3MUE1WmJhdmlH?=
 =?utf-8?B?TXlOTE84cFhsdTJhYTg5L1RldTBVSUw2ZWJqSDZuUVdUL1FZUEE3ZHlvMUxV?=
 =?utf-8?B?MUQxRjNSNVl2RUJ2MngvU0htZFZWOG5hMzNmQ1JEUXB6NGpUUTdYK1ZSNFdp?=
 =?utf-8?B?aTdvdllLYUhrWUhRRjdDMmVOQnlUc1NWbHcxYWhZTDd1eHF6ZHlvTUFyalBX?=
 =?utf-8?B?YWFNVUpzSTFMdzI5aENPQVpPZE1BRTFDNWVTQUNydUVscUk3R2svdzJ2UEVi?=
 =?utf-8?B?YnVjT29SODNzby9iYWlpOGF2c0xBUCtBNFJXampoT1NEdWZMS1M0MllGS3ZZ?=
 =?utf-8?B?dVJEbnhyV0pad2gwQTdzTWxmT3Y3bGZ5T25DeVBhNHJjazdqVG5MbFZ4bmd0?=
 =?utf-8?B?TXBQaU91Mkd6Vk9JaU5UbmpQSUwzTTJ1ZVlSZmdMM2lxNysyRDdRUHdTc2hk?=
 =?utf-8?B?b1BaczlVSTZBVHg4UlRxNlIveCtkS2JZWmdHV2lEdEVYV1pUM1BGdHRDb2J3?=
 =?utf-8?B?ci9jVmJHcjVXWjAvL0h1MUtnV2N1QmovempIZk5vd0R2eXpMR3pZL1orYS8y?=
 =?utf-8?B?OWUvQkhCZmFsUi8xY1h1NVdKYXFTQWdHYUpWbTBvS1FHY1NRU08yMWNnN1lo?=
 =?utf-8?B?U0VSSWNObEhzY3V4bGZKVVJ1TnBPdTBVRE9zeGxaTFpPbUt2U2JzR1dQeHhU?=
 =?utf-8?Q?S9DZtqoD6Z8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3N5anB0K1A3cHFkck5nU0M5WUJqc1U0NlpNY2tCZEwzVmMxczlEb1BvYTVi?=
 =?utf-8?B?TDdTdHpON3Vpd1JoS2pUcG1KU2hCQWVFUDhZc095UDA5aEtqblVTS1JnbnFl?=
 =?utf-8?B?SnJ2MDdRK0ZIdE80TFRZUVNlUGpBRE85NlRvRmtWOVdjZUtpc0dQVTZGQ0xh?=
 =?utf-8?B?Vm1lclpPTUFjSnlWTTc1YyszaWNWcXcrV29oNmNQS1Faclhib1hHdS9TZXo3?=
 =?utf-8?B?SVBKVWM0a2t2ZEdXOHFJWUJWTXpla2EydS9zMUNIdWlYZzAwNlNpRzROdVQz?=
 =?utf-8?B?OTBCOGpJcEtTUEpSRkM3Q0RDd3NjbkxIdVhCSUZKQ01qWkhiUnRIZVBrMUUy?=
 =?utf-8?B?STZCTEtOL0RBS3BNYmVtTkh5TUowV1BsTmo3cXVuS2pxVHhBci90UHZ4Qmsz?=
 =?utf-8?B?UDczUEVvdlBSem1sZTlZUjJCb3ZqUWxFOFdqRnpOTWRKK2ZLb0dYSEF0eWVK?=
 =?utf-8?B?TUh1L0hFVzgwbUZqbkNrTi9mTlRINEtJSDFHMGpvQmZBQzlFdEFLSHdhc1NU?=
 =?utf-8?B?MjdpamIzeVJRby9oQ0NIYVZ4K1JHdlMyK3lCSmNnU0xiMEVuR0ZWMTZvWnpW?=
 =?utf-8?B?Mnh5emJnZmdxQ3daM2tsbktyaXdWUUhoUWxpUTJBTExVZCtkSDFmbFBoRVV4?=
 =?utf-8?B?QmZYU3JLZ25rVEJlaFZKcTVMa1lQWHhyMHBhZFhhQWRsWWRHcnAyS0Uwd2d2?=
 =?utf-8?B?bDF5cVoyRmdKOWNqMlpralNqYUsvOGRVMm5DS2xkRzJGRjQrRXo2Y1hRb0k0?=
 =?utf-8?B?S0N2U0F4dDd0SnZTaUlFMUUvQm5uZ1ZJdHM4TDg3ckd6N3FNN2VjcmtrMVBV?=
 =?utf-8?B?L2U0SzJPK1VpS0hMT0c3bDcrcVJDdXdkWDFOYmtmRmtKSUNvL2M0UGdHU0FB?=
 =?utf-8?B?YWtFZUZkQTFtZlBWZFJ4UDI5Q2FyV0wrNy9aejF0aHhVMmtyVE1rVVROMitP?=
 =?utf-8?B?YTB1Y0ducVd3TlppUnZqbjNzdjJFRU12ZXFUQW9ZYkV2YVFnbUFvOXJlNHBi?=
 =?utf-8?B?ekl1cUk3N0pKSG9RSklhT3AvaWNOSW9zbHR4bWJyc0w4RVFtWk8wT09Jb1Fy?=
 =?utf-8?B?TWlqK1NDN3paMUorU2JDRnZzd0l0Zkx2ZTBUWnpyMUV4ZTVyRVloWDRWU1lX?=
 =?utf-8?B?YXVsbVJ1MTFWQ0QxeXVxeGJzTXlaeWRJd3BxL2FFMmNCTEtNY0liMjEySkpi?=
 =?utf-8?B?MklkRVh1RXBGaGp1RWVxU2xLaWlXZWMzUWI5S0psNFFoVm9kSVpLUmVHOGJW?=
 =?utf-8?B?UW9HSmREV2V3VnhFOWVVZkhxTEIyR3pDNWpyVXEzQVd3cVRoQkxVU0FQT2gy?=
 =?utf-8?B?UEFDRHZqOVZUK1dTaGNtQWRsSFdUQjFjUjVJZXdlalIvTGxtSStmVjI5TVo0?=
 =?utf-8?B?eFJrbFNuUWR4cklBTUQyVXJ4R0RpUW1xNlZ2TjFqYkx2NFl2WDZkOUl4Mmt6?=
 =?utf-8?B?Z05NaDE3U056OEtHL2ZOV0Q2cWExNzZmdUp3VmR1M0NlM1hINDUzYmhwV2Fh?=
 =?utf-8?B?RzQxcjFxUGh6ZEc2eUVwL0NycWxlbXdBcG50bmNVYzQxYjNYaUV0dmY2a2xT?=
 =?utf-8?B?Y1VSUUcxcGpybHNYQm9mOWpsVVVkaFRTRmlyZElySWZoTDZVQ1ludVl3T2ZN?=
 =?utf-8?B?dVBUd1V3bDEzNW9VUkJldSs0bnlpRUlMUHA3OG5Ddmpya1JESk9OVTZsVTRr?=
 =?utf-8?B?L1ZCRnJybDZwNjFoVTcvYUYvdnpvRGhXcGprZ1BSRDNDS0ovNk91N2tlMlBR?=
 =?utf-8?B?VzgybkRjTVREN3F4UGpnQm9JWEZTTUQ1YXFrblQ5bWtvZ3crMHRBOFpPT0Za?=
 =?utf-8?B?VGNBOVFjVnhPa3g2blgvL2ZKN080K09WejAwMlExT3lkNy9FeXI2eEZOTXdZ?=
 =?utf-8?B?aTR6TGs1c3c5U3Z5UnFORVQ1N1ZRQlh1aEFMc3FlOUtkNktERnB0SVRwU2Fa?=
 =?utf-8?B?endDMC9WZFB1VERrN3dBZGNzNEZtNitndUxla0srTXBhK0pNQWhPb1ZsdDNE?=
 =?utf-8?B?UWpEV3d0Z3R6UDJidVdGSXRFVmZ2alpPU1BJMzNyemltdkcrUDhDMEI0SmFu?=
 =?utf-8?B?dFk3KzRCZGJ2WEJFSC9lbFI1VEp1dmdhNENGazNHcE9rTmVMSlRzN0RtNXhW?=
 =?utf-8?Q?T1zc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe273949-874d-46ca-3c32-08ddc8853158
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 18:34:14.4440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbjGXXVjcOQURz569EN38pzT63caEXtakORTCp8DBHnR4KhN4Kej5JLIX36Svx9i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFF4B476A86

On 21/07/2025 18:40, Jakub Kicinski wrote:
> On Mon, 21 Jul 2025 14:43:15 +0300 Nimrod Oren wrote:
>>> +static struct udphdr *filter_udphdr(struct xdp_md *ctx, __u16 port)
>>> +{
>>> +	void *data_end = (void *)(long)ctx->data_end;
>>> +	void *data = (void *)(long)ctx->data;
>>> +	struct udphdr *udph = NULL;
>>> +	struct ethhdr *eth = data;
>>> +
>>> +	if (data + sizeof(*eth) > data_end)
>>> +		return NULL;
>>> +  
>>
>> This check assumes that the packet headers reside in the linear part of
>> the xdp_buff. However, this assumption does not hold across all drivers.
>> For example, in mlx5, the linear part is empty when using multi-buffer
>> mode with striding rq configuration. This causes all multi-buffer test
>> cases to fail over mlx5.
>>
>> To ensure correctness across all drivers, all direct accesses to packet
>> data should use these safer helper functions instead:
>> bpf_xdp_load_bytes() and bpf_xdp_store_bytes().
>>
>> Related discussion and context can be found here:
>> https://github.com/xdp-project/xdp-tools/pull/409
> 
> That's a reasonable way to modify the test. But I'm not sure it's
> something that should be blocking merging the patches.
> Or for that matter whether it's Mohsin's responsibility to make the
> test cater to quirks of mlx5, 

Definitely not a quirk, you cannot assume the headers are in the linear
part, especially if you're going to put this program as reference in the
kernel tree.

This issue has nothing to do with mlx5, but a buggy XDP program.

> which is not even part of NIPA testing -
> we have no way of knowing what passes for mlx5, what regresses it etc.

People have been developing XDP code that runs on mlx5 long before NIPA
even existed 🤷‍♂️..
And as you know, we run these selftests on mlx5 hardware, as evident by
Nimrod's mail, and others you've seen on the list. You know what regresses.

