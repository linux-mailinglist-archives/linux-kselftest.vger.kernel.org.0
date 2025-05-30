Return-Path: <linux-kselftest+bounces-34044-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0009BAC8A19
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 10:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C21551BA5FE4
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 08:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D5521517C;
	Fri, 30 May 2025 08:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NUyr/C87"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4F0202981;
	Fri, 30 May 2025 08:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748594723; cv=fail; b=swenskiMn5jLrK5pciZIPKwYPEFuh7/D1p8NYZ5GE3beEx9L4jygStwe0ZBBKSb3+jJ4xb9n3SIjDTH2cNMd8KJzmP3Bk/2HrAT2fYUMHcwTDy8mXEwCJ0pG/QnSSd8QS8B/O3bf2OR1Ubu6RmVXPnOfl5NKysvZwbG5v5GRYto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748594723; c=relaxed/simple;
	bh=gvSwIdKhxUfX0QsllPkgAKUbeM2UvYlJJLE9XARdlAk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nkrP2OXWpQGBwkJNZjQcOWuY/nBtx6VFKClJji9ycSeN/lCGeFaoVpetCFNm9VDdkY78vmHEjJPKIfazDh4u+92khApHZIL/eGp2blhLyY86vt6tRgWIXV/dPj+dy2pDwmQj9K/GUxet28Vy5LGnUrNp22HwORTMqamhXA1mg0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NUyr/C87; arc=fail smtp.client-ip=40.107.101.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G65CawLKlkmTAWs4ATPRuktivlLtj6UIXy7rGJ1eWNBfi1u7YPLZ6NpOBg7PtKjux095x/2w/6iQPoUwD8EDg1YXvjFK9eT3XctsyTeFPwctcSW8EsjFS0obPtYnDayHJZZIqMOJ5I7IgZ6BIlCPEmHTL4tAQlvozgMiMt6WHIdr5KJwjZ+efiaZmltoKVoyT96oSVBK2n10TGjxg1KmGpIeDcPKheMO2Y0Sn20LOSMzSpwsYdOvaXuswndTy85bfFiUPz+JwMVY7ogYMSdxnJ70eULgZoC5hYRwNVynoKvsfoWsgAIybSTfg8qWLsJsGAD2TqMQedzWwuYOHwU9vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMP7gSJSsWqHr1SBIYZPTVQ/6RbTbRWAcWpitNSmsIQ=;
 b=uT1bg+cxOEadHOOonlS0Qgaqyn/atXL/rOez94sOiveCGx9K4Hb94JPJ2kRuZN0pxsrwDGzNLrCTsvIGZLrPbSPwRcqCfPLkrPcR1XMoX4F0uPFtBK8auIV8tiHffseylYqukwe+dLlURWmf2c5gbsv6piLmAFbVnO8LgZWvphjM6lZA8cy7VSz7zVEQNuMDZKoPMaYIgwCsv31+uT64SVbkKluPEdT4rCK6PmQTGhSAZCJxbw9iLC2+V3bd9QdUqsezf6aVIo4TPdCvT+FUwRMmuOpAsQ7GPeNdwdMmZYijE/QGx12G6Mdy2QNLgHZG8PIKe5GpJxZ2GNTZ7L3cpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMP7gSJSsWqHr1SBIYZPTVQ/6RbTbRWAcWpitNSmsIQ=;
 b=NUyr/C871gFE0aK10Di/yrataN5P3Al7IoZjBthOYP9ubgF+xcDExbTr/jgSdKC5N7fuxS9Nbe1vaMhq4RmDap2v7YxcH5Y/FDstnBX0pWsoyhaNjfsOB3m19c+uxb5bCiqL1w77gKvjRIQGo3vVSBqoaUYE7Vvi463ixUH/rxw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8)
 by SA3PR12MB9131.namprd12.prod.outlook.com (2603:10b6:806:395::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Fri, 30 May
 2025 08:45:19 +0000
Received: from CH3PR12MB8658.namprd12.prod.outlook.com
 ([fe80::d5cc:cc84:5e00:2f42]) by CH3PR12MB8658.namprd12.prod.outlook.com
 ([fe80::d5cc:cc84:5e00:2f42%7]) with mapi id 15.20.8769.022; Fri, 30 May 2025
 08:45:19 +0000
Message-ID: <fbe816ac-8fe2-430e-aa68-15737da98ec5@amd.com>
Date: Fri, 30 May 2025 14:15:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/13] sched/wait: Add a waitqueue helper for fully
 exclusive priority waiters
To: Sean Christopherson <seanjc@google.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Shuah Khan <shuah@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, David Matlack <dmatlack@google.com>
References: <20250522235223.3178519-1-seanjc@google.com>
 <20250522235223.3178519-9-seanjc@google.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250522235223.3178519-9-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::18) To CH3PR12MB8658.namprd12.prod.outlook.com
 (2603:10b6:610:175::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8658:EE_|SA3PR12MB9131:EE_
X-MS-Office365-Filtering-Correlation-Id: 56852ec3-8af5-467f-d3cf-08dd9f564e76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czMzbnZMVzJMaW9pRHBmRUU0QnN5Nm5XcWFSS0pFeDVDcWZjbSsvbGhURUlO?=
 =?utf-8?B?RWdySEI2UUpOMS92RzNRU1lVU1JxOW9GcDh2anZsUWo4SE0vQ3NUMWUwR0da?=
 =?utf-8?B?dXRvYWFyZ1cvMDJ1VUpqR2NSSFd0TmlHZlA0TW5renhqUlU3Q1ZBb24raUQ2?=
 =?utf-8?B?NnFBRWQ4cEFQYVFNdnp4STVBZ2Y0MnUyRVJCaG9zOFFPVlMrN3FhNjhZU2s4?=
 =?utf-8?B?ZGpQdkFlRzhVdnY1R2poMlBqODR1Z0RxbXJrQjFvVUIrQXpPWDJTN3pUNVVv?=
 =?utf-8?B?UjBNRXcrS0tXY2VDdS9GcnJxZGV5MExuS2RRT1ZCVHhPckkwT2QvRHlIalJ5?=
 =?utf-8?B?SG1EdmFyUkNrT1FOMytmN1kyY3QwWXJvbXZ3cE5tYTNWWkY0dHdUc1dRaFRI?=
 =?utf-8?B?VmlIZzZLRitCWFVOOXp3akIvd29CZnZHazFxMENOSm1yUWtsb1hIdWVKVjlo?=
 =?utf-8?B?TFp5U0lMVFFsOXdVMWNHRDVlSkJxTFhRR2M4VUxzWjJXb3pvTkJmY2h5NFVl?=
 =?utf-8?B?eUZtT2twaXhOVW5CeUpTT1pXbXo2dUFHa0VRcWxsc1RCSHlBYXcxWVh1QmtC?=
 =?utf-8?B?blEvbVlrUjdRYWVsdnV1L3hWdzZ3bTJRdGgwYitwRHlQS2htK1hSK1BONFNm?=
 =?utf-8?B?VEoxaXRmVFZBSEswdjJEYnppaS9hZFRnUFppU3lWMDNGRVB4TUE0N2dQMWVj?=
 =?utf-8?B?NzJGaFpMaXAxWUVkL2p0a0NtLzFFc3o4SGFzK09vUlpVMElFUGx0eURUcjZW?=
 =?utf-8?B?a0ZuMXRTRUJ0aEEvYUJhMnpld0xEbmZSdGpRQVZWR0JuNUZkUkUxUVRBWUhK?=
 =?utf-8?B?NUtSMkdIV285OVdjMjAxUit1c2NydkJkcTlPUjBPYndZTkh1cHFMWjFRcFcr?=
 =?utf-8?B?V1JmR2l1QWF0WGkva2U1K0ZLQlBpelpLYU1NYlBoVzJ1VERGbzhhOEpPTFVn?=
 =?utf-8?B?ZFV5eDcwcWh2Y1VxRDZqc0ROZDEzWEJNWUREc3hSME5PMkdDRjVHdzdjZGRl?=
 =?utf-8?B?Rk1TNGFhbm1BZGloK1FNbld3RUFBcHNjTjFEeXZhZithb1NxTlpxK1hCUTJR?=
 =?utf-8?B?YUR3OXh6MHFjazZCZURoRzljNjliajBzQnpDL0NydFpVR2l4aS9VUmZGNEg4?=
 =?utf-8?B?b3I0b1hWS3lSL0RYYUlVMHZHMERNbGl0VFNiVHhSSjFqVmtOMS9pbDI4TlpP?=
 =?utf-8?B?YTJpQ2tlQVAxSlFGV2diYjVPQW5JK2JrNFlCQWQxa0VwMVZWOWtZT000TzBx?=
 =?utf-8?B?YkYra0RiZndsTVVodWQyTjBrVFBxVUkwd016bVlUYzkxQ29RSW9mV3pTdDRX?=
 =?utf-8?B?WVVnczJWRE96OU1XVW9tVzdVYTNuRDk4Tjc4eCt2emdVT2k0bkdzL3pwZisz?=
 =?utf-8?B?MUhTeWdqYStqTERPaU1zaVI3ZXNLZEJHd05PSGtzZzllYnFqS2Z3QU5sMnBl?=
 =?utf-8?B?ZEorSnpTbzVqaWVxSWM0bkQxSWRza1hvVWtuM04vUHlXNk81Szl4cFY3Y3lj?=
 =?utf-8?B?RlhVNm9PNDZYSE5PMzJzMS96QXFKeXhrR3hNS3ltMHhIMi90eG9FTUVZUG5T?=
 =?utf-8?B?VUNWRTVudlFZakJGOXRhdzIwYmw0ejVkTjN3NyttYS9Bc0hDMW5QU2x6VGQ3?=
 =?utf-8?B?Zlc2TGtJdmVGK3VPYmJtc3N2Y2VXS3dFekJCd3hhK0JQQ05jS2hoL28vYU5i?=
 =?utf-8?B?dVp6MUw1L3dwRDdQSlJmT3F2YzJ2STZZc05PaFNRYWV0WHEwOWNVSkRVWGdJ?=
 =?utf-8?B?SmNERHhkdzlQQVZWQkVTaitYZmYzRFVkeE15ZWJOQWkyeHNSSDhCZGNCbHJr?=
 =?utf-8?B?QmxhMHJVUnM2Tkx1bWtOWFBlcDdWMkYvTXZVTFZBZ2I0S0RPdlppSXlUR1d3?=
 =?utf-8?B?VkFZZ2dVblk3cENHSFlMc21aWmEwSWJTTzZwbVFwS09yWEMwV3U2N1kxY3gv?=
 =?utf-8?B?WFc4czJuT0hzaWswMWpTRkVWRFl5b01ZYUJOQTJvUDJOa1FPemsreXk2Zm5O?=
 =?utf-8?B?aFJIQm5aVk1BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8658.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFFLTUJhT0ZBbWhyV1UwWHRPWTZMY0RIb0IveWlPR2hKWmxINDNtbCtoZk9t?=
 =?utf-8?B?Wm91c280bTdtL2M2bnNtc1JhRURxd3FpSDVPU2ZuMUJPM254QlJxOUIwSEVj?=
 =?utf-8?B?amlIRDhPWHlRUTJQSnRkOWZac2FqS3VXNGJuUE1tcXRHejk3MlUwUSttL1ZP?=
 =?utf-8?B?a2FPbG9CZTRLaDFLUXNDN2FBNWk1UXdkbWZRUEdYenFYSnA1c0VQNkNTbllX?=
 =?utf-8?B?SktldDdFeGc1QVdzeXA0TzZ6clI3L1VXSGpZdjZQVHdJTHpUQjNKMUhsRVRo?=
 =?utf-8?B?SE54V0twRzRSOFJ1Z1VpVlYxdDI2L0FOcVFvMXVHbTlhK081MlVRenZkNFYy?=
 =?utf-8?B?MHVuNWhzdzVPN0YrVERBMlFZUDErN2xoaGEzcGh3Uko5UGc0RUMreW1uN0F3?=
 =?utf-8?B?MFdjR25adUt0R2U2OTJrM3ZtSVpNSzRTMWJCTzliazFtT0V0KzNXOWZkRHlz?=
 =?utf-8?B?WTNjUlNqT2lsRGVwcEg5Q29MVDcxY3R4bFg3cG1ZZnI3VGNmeUI1WHd4Nk5F?=
 =?utf-8?B?YWY0bWY3RndYMmw3SDFtbTJlbURhWU1aOEQ3eWpqM2VMVVExMEh1RmlHT0JH?=
 =?utf-8?B?QlU3ekFhaHpxNm5RTkJmdDZVY1pUNTJDb3dZUkRvdkhpYnZzd0lmRE9Tc1ph?=
 =?utf-8?B?VTJyUnE5YlcwTmVQM1l1L0NzUFU3aGd6R3N3Y1RiSGxKL0djVzVvT29pdVF5?=
 =?utf-8?B?aFA1RldBMmdBUWg2MmVkdDN3aG0vN2Zzc1hMeWxJUlhWLzdCNlZGTTdmZWh0?=
 =?utf-8?B?WnF4MmFXS0NyOUhtUWl1SUVySEdVWEZtZHUvOFcvMk9wSDV2UE9YYlJGWDFk?=
 =?utf-8?B?Y29kaUtYVnlUSmd1NEF4KzZvbExRWU4ycUVDZXdMeWIvUTVKNE5QcXRwSUYv?=
 =?utf-8?B?Z1hhTHV1eTB2Z0hHVlk4clgwYkwzR3RJL2xkdE1GQ1NMdTF1T011OTR2ekJT?=
 =?utf-8?B?K0U3MEQwNWhIc0ZRdHhJT2dwMC9SdlpaV21zakpDU3lScmZJWWJYYTgwYWxY?=
 =?utf-8?B?RmJXeHhHNXJCVWtyWW12UWswWW45VTVQSkRQTTBZV3ptTXlmMnc1SHNYOURv?=
 =?utf-8?B?MjJrekFOT2pKSlZPK0h5d3F5Unh1aERrc1RIZzFzSVpDeWtTaGJxVGV4d2Ji?=
 =?utf-8?B?MDVPbTVNTE5TUUFMSHlpaWtJdTdMMlRPQnNJMXA5VGJZVUlxRExCZmhCZGFU?=
 =?utf-8?B?TDVVZncyWGlzVXlkbDJ4VUNMSUpBMTMva1BMTEdTOEgraWRLQ1lLcWpMb052?=
 =?utf-8?B?MnNkUFRiU1BHOEoxU2FCendTMDFOcWVaemF5U2RoYjMwMThhUnZ1QjBIdUdC?=
 =?utf-8?B?NE1yOHUzL2loVUpoN24zMjJyeDRwR0xWTisxaERrZHczak5Ja01lckRlUnFt?=
 =?utf-8?B?Skh3OFM5ODRURWI4YlcvOXJjZy9oRjdFR1dxNmY3OHJSa05wUWhsRHJPQTZ6?=
 =?utf-8?B?RXFRSHYzNGV6bW8vbFlaQlArS1pFenJUdWc4QmhlSllmdU50R2QvVDE2Mnl3?=
 =?utf-8?B?RzR6ZDhLNXl6dXdkbWNGME9Sb0wvWE83LzlVRmRtRC85b1FQY2VKK29mWGFa?=
 =?utf-8?B?SXQwSjNrZmVEbVpIS3F1T0pmYWNDbmJoNGUrQmZSbm5sMjEwU0crN24wQzBK?=
 =?utf-8?B?TGxQWktGVTlOQURpdEh0Um5iWWJvUi9Ud2tYVEVmanc3KzJaVVhqMFBxTS9Q?=
 =?utf-8?B?QW1RYlBvbk1lV1pzMEY2UHhnSlRrUUk3cklYNjBnUlFEZXNzUExwRXYwNGdB?=
 =?utf-8?B?cy93QWYrdlBzd3VBZWJkUXBMcGhtS3d3c3kzYlRpZDVldytXNllMRkM3dngv?=
 =?utf-8?B?bE5Hb0l5V3Q3S0pyLzNENnBqUkEyemlqLytUdjRDbWVYazQ2RlJlRmRYdlFi?=
 =?utf-8?B?clFPMkNSbHNKbTVYNWZ0eTFkQ2htZEw5L1lmTURsNzhOVlJJMUdoT1pVcjB0?=
 =?utf-8?B?cUFhTWtoUGcwY0FPZEQxT3F1ZWVCNnE5bHl6eXdQbHdtd2M3Ukx3YW9mNGZH?=
 =?utf-8?B?d0tQU3RhZ3AycDRMRWp0cmFwK1JXWFpZUlhJSURBM0pEQTV2Q2JoKzRqYTdZ?=
 =?utf-8?B?ZVdEM09yOVhHNnlaVEx4MjNkK0ZMM1pSdnRUVVNia0cyaW0vSVlLMVNia1dO?=
 =?utf-8?Q?vH5FtqQfxQ9V8Ov0mSYkhqVy6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56852ec3-8af5-467f-d3cf-08dd9f564e76
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8658.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 08:45:19.2735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6n2535z9vp3dMWkFTucuYD+obMnbYTuQ9MZFLHZeIIwDp6qO9dfg2n0euE1pQuMpyqqdvIwY5EZpIJrUzT/2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9131

Hello Sean,

On 5/23/2025 5:22 AM, Sean Christopherson wrote:
> Add a waitqueue helper to add a priority waiter that requires exclusive
> wakeups, i.e. that requires that it be the _only_ priority waiter.  The
> API will be used by KVM to ensure that at most one of KVM's irqfds is
> bound to a single eventfd (across the entire kernel).
> 
> Open code the helper instead of using __add_wait_queue() so that the
> common path doesn't need to "handle" impossible failures.
> 
> Cc: K Prateek Nayak <kprateek.nayak@amd.com>

Feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   include/linux/wait.h |  2 ++
>   kernel/sched/wait.c  | 18 ++++++++++++++++++
>   2 files changed, 20 insertions(+)
> [..snip..]


