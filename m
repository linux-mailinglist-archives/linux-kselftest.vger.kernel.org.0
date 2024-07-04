Return-Path: <linux-kselftest+bounces-13162-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 720F0926E3A
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 06:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948681C21461
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 04:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254BA19BA6;
	Thu,  4 Jul 2024 04:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mswy82BG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1DC3A8F0;
	Thu,  4 Jul 2024 04:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720066172; cv=fail; b=nZXMAZUlnnnPzx8icw6ozH9WppdsprMteB8l8XJS3IlF6FHhi5Y+mor2jMrgQp/qqiO2yubXb6IYleTFKaYYgwTkEpHOPxdVx8qp5k+35dz6q44/Ve9YfGT4bqhESs6kpShnhpvpdBGY0pNyRFSAECP0tbF1YUM4TsXKD1LUYfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720066172; c=relaxed/simple;
	bh=MNpftNCdS8KiiHU0unWJ8kxq1jZGgh4xu89Dc+XYYsE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IuvT6o1o82M6bSmcWbWB9PjTAKq/KO8AEw20nMGKaNTNVMRK42G5hqs7l1W1OZwn8I98kaaohSbWFRCrb4p94+IpK1G6drx+Y8pRpvj0sCEkRh1qZkyBsMRIbyHy1offt7Q7MO5aDOVPByJA7R6x2uPQ61yyTKC7aqnGwuBUoug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mswy82BG; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPw0PkxKzG4+S0l2f3VBoyszBY7eNTprTBqKcbZqWKDsCb7HQgurq3d1ubpIyN0IEvV1doaXVtiGl0HpQ/gG/LyFXFw3eKzYL9w6DVv5jXneRDxbkjUm9AaVzPIAtNt/bgP2QzJQ0biXVkn9jgwdXCbKCrzhQZsDxxXB5wyhWR67WmvTrSNIZAoHu3WOwb2vANMZF++gfYL93qJBmLgAkIEWcORJs4sTSFII0kp8TRTBPeXjJdiYIUp5PTGz6Wk2H3x4tfM5ibhYNEBqUQGv1SIaWNK43B7JW23ZR8dp2nVAtRk5K1lc8Lhk6M2jzXYAGwNRqGYeBo9wtJPfN3CBtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIisbWw4qGwpszlkiZKNsAyqdvwqg10tIYXTvC1OjUo=;
 b=M8+RdPYRNYvpxVPKezeiVGneq0vfcyW3jYW3yfshBgMvln8O9jJt6lIv1myD4nHOX52QYqHxPCAMlNgIpNjwI07g/d0OcLPTXNvOi1ZZSvHZ9Z6oBoCT4HmswE6ax4yx+7yZoOx90k/SJR0N74DnvshjwcZfxqoKesVafYLLr5/cLjbl+zAj4cKWjkLyJcAcVN1KNDfcVPTvtyDWVmj4BoLMgX01tgtScK+iWvy4dGreNH7HOqeCJEiA2DMlll2W0N+4Tvw97wHPM5MNQ20SoY3/LrTTF19P2YPG954S1n1fvl4wPvJWhsMYo2TRw2RxQYe4EmLIVizkAw+Ia2FVRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIisbWw4qGwpszlkiZKNsAyqdvwqg10tIYXTvC1OjUo=;
 b=mswy82BGGaPY68oXfSBQJECZ+sWE+OIGx0SaC+TWnEvF2MnVQESiQYk7u5J+aNT+wbjCzGtEQjddMCLPl2iYXLwaZ1nc1uenRQvkvdPizb1veWgLfAYo3iYcP4SY/PoN0nrnKOExjyDnQpf8S5hISDtqedhOZAMuboywWs/FWIuS/Ve6umVHf8Q9croRwkeRGPL2kEOqRqZQ5vLU0TlbgUOQCTOo5e5v869wX4mrtDENf+ubhsNadBRJC1ltG1B0r3hZEdlAR8MylQ7YYpQSeCjCoJh3kE8jIRKJme5Gs06qcBlwziSirPKiqsxIro2/ukLIwqyQJVztHxrvduEYNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BL3PR12MB6524.namprd12.prod.outlook.com (2603:10b6:208:38c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 04:09:26 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%6]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 04:09:26 +0000
Message-ID: <46fe5a3c-6bbc-48b9-9f85-4b0897bac371@nvidia.com>
Date: Wed, 3 Jul 2024 21:08:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] selftests: introduce and use SELFTESTS_CC_IS_CLANG
 instead of LLVM
To: Shuah Khan <shuah@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Justin Stitt <justinstitt@google.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
 LKML <linux-kernel@vger.kernel.org>
References: <20240704030452.88793-1-jhubbard@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240704030452.88793-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0031.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::44) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|BL3PR12MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: f2a10e1a-a601-42ef-491c-08dc9bdf183a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1NZOHpyREk5V0w4K1pYbnNza3crWjhubE5SeUluY2I0MDVGbjF3NGhsVWlh?=
 =?utf-8?B?RVNOZGticUZnN0FXVFl0b1ZpYnRuWU1GaTJlRXdDSEE5OFhlRVBGVVpRQ0Fy?=
 =?utf-8?B?SEQ5R3RReUdKTjYzZ2E2VU1tRjYya1RSUnczcnFzOVdnajFYZjhDQzZlQWZY?=
 =?utf-8?B?TDZXR0RIQk8yOU9mT0grRUIvS1BlNVk2Y04rKzlBd2srT2MwdXlPcjIrVnFQ?=
 =?utf-8?B?Yk5OUHZjV055Nkdwc3lzaXo2VHpVZms2OWQ3d0h4c21BandXL0t0dFRJU2V1?=
 =?utf-8?B?VnBlaXpKdUtFSFQ0OEtOWE44ZnpNdzNQVDArakh0bXAxRy9IVmFuMzUzemlU?=
 =?utf-8?B?amxMb3VlbFJzemtSemE4NW1XT2RQSWRDMXJYUmo0dW5NTXNqcUVZemVRRDlT?=
 =?utf-8?B?a0VOL25zWUNERlVyaGlaOFNQY0VwM2tidXFvWWZLWlBJVlQvRVZoeFhxVEtj?=
 =?utf-8?B?dS9RTFdCQUM3ZDk0dHpNQ2twVUluaVQ1cERPZVhzZjFjcXAvOHhLelN2TnVm?=
 =?utf-8?B?ajFwbldXRDAzL0dtdEFHN2JCK2tBZmlFb0hneEMrTVBTWlM2aTBGcytLY2xh?=
 =?utf-8?B?RWkwdzhibEUxV0dmajQ1M1NrdDUvVXlnRnFIZVlHL2l2a283UVBCbzhkU3Q4?=
 =?utf-8?B?T3lxZmo2RHJGZUpjTVBtdkt1b1hxYU1PM1NxcVo5WjY4bytpSllnZm5sWkhy?=
 =?utf-8?B?RW5sMVhaMXZ3dUdoY01OT3dkV1MyRU5HMloxTVA5Yk9SU3lubXhSOCtUQm5Y?=
 =?utf-8?B?SE50NnlKcVF5VWlRTm5hSWIvVFNyd2xQc0YzTE9wWUJwMVc5N3p2dzhGUmlH?=
 =?utf-8?B?UGdqSHdUY0hIdDBJWXFackRxanpKRC93aHBnZHFZM0hvZkIwZWJIbFFtME8x?=
 =?utf-8?B?dzhEanpkZWFkMW5aM0VPeEw0S0dWbzI4clNHYlZZc0ljWW1vWlNrblpuNTk2?=
 =?utf-8?B?a3pQREtZWktma09qVy9JMkk2S0xhMndwOFBHbklYYk5GMi9NZE5raDVKKzZn?=
 =?utf-8?B?TWdZM3BlODljNStQenZSQnNLSk4xWmxTVHJNRmtXUEhvQlBBRC9YY3JCZGd5?=
 =?utf-8?B?L0grcmFRUGFwUXRXVFlNakEwZVVOK25lUE4xS2hiWnhaak5ZMXVGaHBEMlEv?=
 =?utf-8?B?bTBDMy9aejh4U1ljS0tTZGNtWkozU2hFTmhhQVdiNDBoSk9tcDVBZVlVODlL?=
 =?utf-8?B?amlFVU1DT3cwcHZwaVRRTkJQSkNJZ29CNWZWQy9FbkE4QkNWMERqWVRhdWVy?=
 =?utf-8?B?T0lPREw0bkpjdjU3K3pMMWpYWnp2U3Fib3hYTlIvRFczOW9zQjlsdFlxNDFw?=
 =?utf-8?B?T0FFTlBLVXh1SFV0WFRkZkxna2lsZ0J2T3ZIL3ZielVhYmJuSC9SNHk0RWds?=
 =?utf-8?B?YzZxaU1WTDNQT0R6b0RCUHJ6bGdHRlhabndTLzc5SGtDM1ZaTWI3RTJQYi9y?=
 =?utf-8?B?UlJuN2xpSnkzdHk2TitHa250MHIyMWpEVG1RclFLL0huVzA4MUV2Ym5Fc1U0?=
 =?utf-8?B?c21YQnpPUThMd3JVK3A0QkRXT0lhUytreG5wNTQra29HQXJDdzdKZUFBR2Qw?=
 =?utf-8?B?cG9ETzZUVXJFbm5uWWdkd3VPcVV3VXloUFMyeXV4OGxicFdlbXFRZXY5ODc4?=
 =?utf-8?B?VjdqaCs5cm1BNGxBdjI4elFEeTlYSEJqa3FJM3BYMUR5UjgrYmNVcGhmV3dk?=
 =?utf-8?B?V3RXeFRSd0l6Wlo1MkRYVnBKZXUzWlpZWEJCM1MwK2drVHVZZFRQWjNUY24x?=
 =?utf-8?B?c0FJdnRtdmFBZVVHQTNMajhMVFd0dVhJb3EvOCtjVWY4a3dMVDNwRmthS3ZQ?=
 =?utf-8?B?STlqOXR0aThNRFgvQit1Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1ZuYjVlZ21TK0Vtdk1jeDdRVnBNaGhuZWQyc1B3WFlEdy9DVW9MWEFzY3Nk?=
 =?utf-8?B?VkVhZ0EwL2NIdjRzcjNvZFJFeTV0Mjd0cXI3WGFpY051bnNPdHhCMVgzcUhh?=
 =?utf-8?B?MDcxQkFTM0MvNHNZbHA4TVpZRTBZd2tiTGV2elIvQWM4NEMwUHl4c1JBd0Zn?=
 =?utf-8?B?Y2xyOUxIcVlXVFRNWE1hWkM2bG9reFN3R0tjY3JMK3RRaDBId21YS01mVTFu?=
 =?utf-8?B?K2Z5SmRnS2w3dHVFMTR2ZWVyN291R0RUVUFXYm5tZUhaK3hEOGxJUlBIU0g5?=
 =?utf-8?B?K1R5WDg4TE8xcVR0V1NIdlpuM2JkVlprakEvWmZuSzA4d1RRQ2JSbDR5SzZS?=
 =?utf-8?B?WVlTV2p3WmhtbVcvMmsvazkza2d0dTMzN2F6ZHA5cHhTZU9LbHZXZjJHZWNW?=
 =?utf-8?B?dVhSSTluNHNhZGpoakdmeSs5RVEzTlRrUGhaZFVJM3lkQ0paUGY1K2xraUZF?=
 =?utf-8?B?Z1IvbWJSNEN5alpqSnZFWWUvUXBGL0swcHdkcFVZa0QxSFA3VEg3RXBwbk4y?=
 =?utf-8?B?bHpnY3BIaEFtSGVSQWZMMVZUeng0TU5GNVQ0aTgzcUJubXRlVHR3WEZub2VS?=
 =?utf-8?B?ekpoUkRlQ0hPcDhITGw4Vi9YbUl0L0l2T2IwNWt2TzB1SE9VZGQxeHJKMy9P?=
 =?utf-8?B?YlduMmJYRG9vQVNuNzlQNVZqMjZLdzRvd3I5dC9vY1FWL09sUTgwZUF1SCtm?=
 =?utf-8?B?NjhJcjlLa3hROGZnZEN5K3ZJRndwRytXRWllTmk0S3Y5WnlFK1JTZVhtbFps?=
 =?utf-8?B?a2Q1NmN2dE1rdlM1S3FZYTVndWhDdnFHNks5c3N5UUIzVGpCTG9VM2U3Wmxu?=
 =?utf-8?B?aGNWbGNFZm9TY1ovWk9EMjRjREIzMDBySm1uUmxOUk5WRTlLbXl2ZlJBVXdj?=
 =?utf-8?B?SmpBcVpsRllNYkZNRHowQmR0djVHOExwa2R5OWhhUTNsK1NmS0h3c0grSjZ1?=
 =?utf-8?B?TE5EUE0wYmx3MXRCL29lWFVYM1dIbm5GRWdaakg1MGZIQjllQzhnUzA3YVF0?=
 =?utf-8?B?SEx2NkJQelhsTERvaWkyd0xuMTR2cnA3b0V1OWR0NDJ4cU9zVWFxVWJUSGI1?=
 =?utf-8?B?SGlRRjhIM0tqRXRtY0xpbVJhN1pILytIaDY5ZFZTQ0IzenV1NWNWeGtRZ2JO?=
 =?utf-8?B?eXJUUll0MHlDN3hzYnFOeU1WV29OZWZlM3RlU3RhazBpQUFpRXdnem8ySjdi?=
 =?utf-8?B?eEdId1ZEdFVIWU9lKy9mUmNvbnRWd05jaFVNM0ZDZjRwUkE3UzE2bEh3RXdK?=
 =?utf-8?B?OXFTV01Rb1N6c0Y4MWpKRGp2dFFGbHExaSsybm9YSG95VjlRNDBPSm0wMDR3?=
 =?utf-8?B?eWhxUVM2YzBwUGJuZWlCRVZBa0ZZNHJldU8vTmt6Y0xxYVV4K3p3dVRDcnkx?=
 =?utf-8?B?eEIrWWxnVlVLc2pxUXdoanN5dDBhRjY1K0U0b0s4elpnNWZOL3pwckd5SEZR?=
 =?utf-8?B?NDRDeVhSRVc0UkFnckVXcU1mSGxWSGlnVUJVTCtidU10NzM4WmpCZ3c1eW9q?=
 =?utf-8?B?TlJ5L2NGdGpRc3ZNWHZxQnFPbFVScnNWbGxuNlV0Sit0NFlaTDhidG5yUW52?=
 =?utf-8?B?Qmw0Skh5aVk4WU9xNGc4OXFvcTFCQTZvRXFlQXdLZUp4bXRpTWJHWkJ3amQr?=
 =?utf-8?B?ODhQSWhJbkNaV1NjUndNL3BnMFlIdkFvYzMzZm54TXJMWXYyczJGSTZ1QnJa?=
 =?utf-8?B?aTM0anZOSUJLem11M0xIaHVVOFZpbExyU3dEOWlGVG9XVStwV1JMQVh0S0JN?=
 =?utf-8?B?TUpmQ2k0cS8yeXdjc04vWW8wTXRBczIycUFodi9LYzdEMjBkVzMrQUNPTis4?=
 =?utf-8?B?WFBKa2hKWGtWcWM4Wi9abDcwZVorL1VCRWY4c2tLQWg5eldCU0NRcSt1czgr?=
 =?utf-8?B?azVHOUF6Rk1jZCtudHpRTjU0bUJBSHNtQzZBbGFKNlU1WEpmVXBxYjlheW1w?=
 =?utf-8?B?ZlpaWGNENmJtaVhkVHlDeDFPd1ZIaUVJSmdOcWozYjZ1TlJrd3B3bGFYWUdD?=
 =?utf-8?B?VEE0UTBFejlYMmJvMlF1TjZ4Q0ZCc05nLy94cWcvdjFsOGpkSUhDRE9nTG9E?=
 =?utf-8?B?WnZJTXdhZjIwQ1FHSjdmbEdaaEJmaERseDFnc0xFWVhzUExubWc0NFhUdCs0?=
 =?utf-8?B?Q1lTYXdkZkJnZkl3RXVkaUlKQ3BybXJiUjRaYWZDQTUwYTVWQTByZXZKU2dp?=
 =?utf-8?B?bkE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a10e1a-a601-42ef-491c-08dc9bdf183a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 04:09:26.7043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f1bF6av1wiyytSSVNy9q7zMUWNNYKt1hERQcXbQ/ty2BdiUvHB+njmfX9p/yvuUKzOANj2MrGcmFE6ZBpdiB4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6524

On 7/3/24 8:04 PM, John Hubbard wrote:
> Current practice in the selftests Makefiles is to use $(LLVM) as a way
> to decide if clang is being used as the compiler (and/or the linker
> front end). Unfortunately, this does not cover all of the use cases:
> 
> 1) CC could have been set within selftests/lib.mk, by inferring it from
> LLVM==1, or
> 
> 2) CC could have been set externally, such as when cross compiling.
> 
> Solution: In order to allow subsystem selftests to more accurately
> control clang-specific behavior, such as compiler options, provide a new
> Makefile variable: SELFTESTS_CC_IS_CLANG. If $(CC) contains an
> invocation of clang in any form, then SELFTESTS_CC_IS_CLANG will be
> non-empty.
> 
> SELFTESTS_CC_IS_CLANG does not specify which linker is being used.
> However, it can still help with linker options, because $(CC) is often
> used to do both the compile and link steps (often in the same step).
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
> 
> Hi,
> 
> If this looks reasonable, I'll break it up into separate patches and
> post it as a non-RFC.
> 
> thanks,
> John Hubbard
> 
>   tools/testing/selftests/bpf/Makefile       |  2 +-
>   tools/testing/selftests/fchmodat2/Makefile | 12 +++++++-----
>   tools/testing/selftests/hid/Makefile       |  2 +-
>   tools/testing/selftests/lib.mk             | 15 +++++++++++++++
>   tools/testing/selftests/openat2/Makefile   | 16 +++++++++-------
>   5 files changed, 33 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index dd49c1d23a60..6b924297ab71 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -55,7 +55,7 @@ progs/test_sk_lookup.c-CFLAGS := -fno-strict-aliasing
>   progs/timer_crash.c-CFLAGS := -fno-strict-aliasing
>   progs/test_global_func9.c-CFLAGS := -fno-strict-aliasing
>   
> -ifneq ($(LLVM),)
> +ifeq ($(SELFTESTS_CC_IS_CLANG),)

It looks like I got the polarity of these checks wrong, after all. sigh :)

>   # Silence some warnings when compiled with clang
>   CFLAGS += -Wno-unused-command-line-argument
>   endif
> diff --git a/tools/testing/selftests/fchmodat2/Makefile b/tools/testing/selftests/fchmodat2/Makefile
> index 4373cea79b79..d00b01be5d96 100644
> --- a/tools/testing/selftests/fchmodat2/Makefile
> +++ b/tools/testing/selftests/fchmodat2/Makefile
> @@ -2,14 +2,16 @@
>   
>   CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined $(KHDR_INCLUDES)
>   
> +TEST_GEN_PROGS := fchmodat2_test
> +
> +include ../lib.mk
> +
>   # gcc requires -static-libasan in order to ensure that Address Sanitizer's
>   # library is the first one loaded. However, clang already statically links the
>   # Address Sanitizer if -fsanitize is specified. Therefore, simply omit
>   # -static-libasan for clang builds.
> -ifeq ($(LLVM),)
> +# This check must be done after including ../lib.mk, in order to pick up the
> +# correct value of SELFTESTS_CC_IS_CLANG.
> +ifeq ($(SELFTESTS_CC_IS_CLANG),)
>       CFLAGS += -static-libasan
>   endif
> -
> -TEST_GEN_PROGS := fchmodat2_test
> -
> -include ../lib.mk
> diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
> index 2b5ea18bde38..734a53dc8ad9 100644
> --- a/tools/testing/selftests/hid/Makefile
> +++ b/tools/testing/selftests/hid/Makefile
> @@ -27,7 +27,7 @@ CFLAGS += -I$(OUTPUT)/tools/include
>   LDLIBS += -lelf -lz -lrt -lpthread
>   
>   # Silence some warnings when compiled with clang
> -ifneq ($(LLVM),)
> +ifeq ($(SELFTESTS_CC_IS_CLANG),)
>   CFLAGS += -Wno-unused-command-line-argument
>   endif
>   
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 429535816dbd..f321ad5a1d0c 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -43,6 +43,21 @@ else
>   CC := $(CROSS_COMPILE)gcc
>   endif # LLVM
>   
> +# SELFTESTS_CC_IS_CLANG allows subsystem selftests to more accurately control
> +# clang-specific behavior, such as compiler options. If CC is an invocation of
> +# clang in any form, then SELFTESTS_CC_IS_CLANG will be non-empty. Notes:
> +#
> +# 1) CC could have been set above, by inferring it from LLVM==1, or externally,
> +# from the CC shell environment variable.
> +#
> +# 2) SELFTESTS_CC_IS_CLANG does not specify which linker is being used. However,
> +#    it can still help with linker options, if clang or gcc is used for the
> +#    linker front end.
> +SELFTESTS_CC_IS_CLANG :=
> +ifeq ($(findstring clang,$(CC)),clang)
> +    SELFTESTS_CC_IS_CLANG := 1
> +endif
> +
>   ifeq (0,$(MAKELEVEL))
>       ifeq ($(OUTPUT),)
>   	OUTPUT := $(shell pwd)
> diff --git a/tools/testing/selftests/openat2/Makefile b/tools/testing/selftests/openat2/Makefile
> index 185dc76ebb5f..7acb85a8f2ac 100644
> --- a/tools/testing/selftests/openat2/Makefile
> +++ b/tools/testing/selftests/openat2/Makefile
> @@ -3,16 +3,18 @@
>   CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined
>   TEST_GEN_PROGS := openat2_test resolve_test rename_attack_test
>   
> +LOCAL_HDRS += helpers.h
> +
> +include ../lib.mk
> +
> +$(TEST_GEN_PROGS): helpers.c
> +
>   # gcc requires -static-libasan in order to ensure that Address Sanitizer's
>   # library is the first one loaded. However, clang already statically links the
>   # Address Sanitizer if -fsanitize is specified. Therefore, simply omit
>   # -static-libasan for clang builds.
> -ifeq ($(LLVM),)
> +# This check must be done after including ../lib.mk, in order to pick up the
> +# correct value of SELFTESTS_CC_IS_CLANG.
> +ifeq ($(SELFTESTS_CC_IS_CLANG),)
>       CFLAGS += -static-libasan
>   endif
> -
> -LOCAL_HDRS += helpers.h
> -
> -include ../lib.mk
> -
> -$(TEST_GEN_PROGS): helpers.c
> 
> base-commit: 9a5cd459be8a425d70cda1fa1c89af7875a35d17

thanks,
-- 
John Hubbard
NVIDIA


