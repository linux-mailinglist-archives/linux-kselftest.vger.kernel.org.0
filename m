Return-Path: <linux-kselftest+bounces-35387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FCFAE0D47
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 21:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918093B2B3A
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 19:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8990D1A23B0;
	Thu, 19 Jun 2025 19:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ei5SOnlY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E402F2417FA;
	Thu, 19 Jun 2025 19:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750359667; cv=fail; b=AJ9F0TlmZ+vsOLMGcH9UH0G6Rud8DDo/WB8K85yRdJDIIBNcRJvi/aTU9eTUNRaPy0VcPdsjlpLRKOaom2qOm4HwRVn7bX2t82fuLUzh5Ad62+IMJgYoKL1ouEZY+Wtj150QZQNq8ku1soSLX43JG/fKoyV17JmJgGdlSGnjJbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750359667; c=relaxed/simple;
	bh=mBoaqfyCJOKRxsKc8l1nfl4APIdoW/PGbQsd4iAL1Qs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R9dsUpMea1l9/EdVxP43927ZOZ5qq137Poej/wKIcWLZfXiWQg/5fuHj/FQW1c22a9iZQ7KqQ4iNatEDuJK9kpuXBLswHjEctVoZBMmb3ML28yzQGsgA4eIy1RnLnUIss55JCXLlL2wb5oBLLHi9hrVQsCW/KXoFcYt4xMd+0Pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ei5SOnlY; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXJNg3Ry+VX2dZunZe0wYdrEmcGUeoEByjfw7PzJjYCsHkLcFervLZ7HwCA6RpyBBMOwacNcO84nQUH8PetpYs4zxKo0RPJUKYL5N1YuLKczNmgiz07xAvG0ixCkX/IheGanBPlRmcUlHkllNvDcHtFBsGslu/5l2CTlKpuTvPbLNeeCQ3odV4xoEAilMshoDhaPBOmKbm+9i2KWRjGeaFoH8twUSvKI0AJ6rDaxrx+pF5+gimZKxVpKWcxRC9v0rvsEVgWc/nn5TQ3ZHyiw1NawLC9y2opZ2k6O33Fub1yiOCYhrjDRiBAHETBJoR8lhCyrqlmDiy5hodqWXftkag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ju437qpXTkiZSsIrJll5PRkMY6K2Wsm8XanZYojfEsw=;
 b=EK0ki89Z/LxuBzEXanSSdC7zhNl9O18B02SbLjYMW/v0v2MlopS/y0nY2pS0bFfmoFQMMCPh/8M0KUEWnUPRjRD69FutUirgZ/199HcCWch0if6iFs2kF9rmwo9wgGIMirv3+3RVWX48Q+RWopF0vfb2Oh/RJFzyEZhFgr8lOiPX3qLfvdeDlimAb8dy3qR7mttg97a3WOM4I+sJBt1wchS03Haat1838RoCymzUWKobQXlA9lxbQkW2G1O9z/EAOEKWyeFJ/mq4bxG04aNpFBYH4qt+fWBZCRgrY7POmwDZzzBYc1P6bOfd6g4nzgSNHNNVZ31hx12zh+Qdl0Mvrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ju437qpXTkiZSsIrJll5PRkMY6K2Wsm8XanZYojfEsw=;
 b=ei5SOnlY6fiu1XM13IPHxAEmPVTLfTBprtLIOyC83tD3OeCf1nNk/s4flbDiRGK/2Lu0bJ6z6ECPnz9I2AAZUJdVd/GS7B2NH1/Xcp8NE3K+gxmXR6anUAcKihtc5rsavPnoR5BHEQhzBdwwPdnDVYXijm0xlE/ycMev+5JXInV/aomOshIbj12cMMgaNuhSnSTBOKk4wBlGkVgBoInWEFLPf6922RnNEIDmTzQphA2EG7/OYggvLRbTNM6o38CMdjHD+8+mJv2NmvzfG51llhJRHrvsy6XsxBZPZLZIdBfMV6Yr/TipCnZpHU84aFLgDcQfrbRT8xufm2bu1dv8Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by IA1PR12MB6355.namprd12.prod.outlook.com (2603:10b6:208:3e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Thu, 19 Jun
 2025 19:01:01 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%4]) with mapi id 15.20.8857.020; Thu, 19 Jun 2025
 19:01:01 +0000
Message-ID: <91817e12-54c4-4241-b895-2e452a00e0c4@nvidia.com>
Date: Thu, 19 Jun 2025 12:00:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] selftests: Suppress unused variable warning
To: Shuah Khan <skhan@linuxfoundation.org>,
 Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <mszeredi@redhat.com>,
 Jan Kara <jack@suse.cz>, zhanjun@uniontech.com, niecheng1@uniontech.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250610020758.2798787-2-chenlinxuan@uniontech.com>
 <6972404e-0237-47b9-8e3e-15551bea3440@linuxfoundation.org>
 <CAC1kPDPg0AN9Ft3SNM6JDcZf=XD1oinqeAMzuRpZF3nzemZ=Kg@mail.gmail.com>
 <265ebc1f-b0c0-4c57-92b2-41714469c7f5@linuxfoundation.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <265ebc1f-b0c0-4c57-92b2-41714469c7f5@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::42) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|IA1PR12MB6355:EE_
X-MS-Office365-Filtering-Correlation-Id: 39ec0127-924f-4712-204d-08ddaf63a200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUxvZlpKVnVwUVVuRzV5aWt0ZlZyVE9jbWdCbmsrd1pTbTBsdk9DRGphVGRr?=
 =?utf-8?B?RVRwM2xuR1hPZjFQZWU2ckVTQkdvWEg5MWk0cVFRQllkN0xpS1VHUzVGbGJI?=
 =?utf-8?B?SlpSR09HU2JCVjVPL2tyNW14WjYyTGpNVmo1azU3VTZ3dCt6clI3cVFsLzZZ?=
 =?utf-8?B?QXVKVVArZXZqL25XWXlvZlZmVm5wb010d1k5ME5UL3o4WWtaVmd6dGN2a3pk?=
 =?utf-8?B?M3JRTnpWVkt6WEsrK2JlY2s5LzNsMHJQTmtlTFhBbEtoL0hwRXRlUHZxS2ZS?=
 =?utf-8?B?SzByWjcrdVgyT2M1ZElMbG82WmJRTkdCS0pWQng0bVAwNU5Ba1JWYUYzQmVa?=
 =?utf-8?B?L3RVcExJUkRUc290bzlFTHZsRzJ5aDZucGdyQ2hzMHZ1WVQwbnFlaWFxcnBQ?=
 =?utf-8?B?b0hRckJUYVhyaTRhRVQ3b25iMWZnZHZsekdYRDNUMm1KSW1SUmtvNCtGcUtZ?=
 =?utf-8?B?YzAzUDV3YzJUOWNQSmxrRDVoNkVUYXhsbzBsSXNUWEtBYTl1c0JFTEFoVzZI?=
 =?utf-8?B?QzZKWDlDNloxMC93MXBWbVZ5R09OdTNWbEFjUXUyY3VwU2RhNFFkVGxjOHo0?=
 =?utf-8?B?Y3hYSFJNcTNNclhjdFRQYzhUWmdyc2V3RzliZUNDS3hzSWQ5QzdwZ2Y5WTVp?=
 =?utf-8?B?NEVYRzlxaFNRVjFZUGUxWUtidG9nNENHMDk0Zi9Qa0p2eWlxbWxSQXVQSCtJ?=
 =?utf-8?B?S0lpblp1dXAya1ZlZnN0RGdDMUpmeUVITXRUZDVZQ2FlQmFtTVRJSGRWODcy?=
 =?utf-8?B?ZmdramdKbmhPRUdYVUh6RzdTWUF6bEs3SVRTbG95TDV2THczbndycVVTS3Z3?=
 =?utf-8?B?bzJGRVpuczN3U0dieUpKRllmNEhqLytpNlZ2d1FLVFdTanhzR290SEFrRWNa?=
 =?utf-8?B?MVhJdXhtNldnNkpnQzdGZTYxbTNhbVFsNWxWa2d0dVJmS2drSWZlSTVub3lz?=
 =?utf-8?B?cC9mUEZJUHhZaDNaMkFwZmNQZWVuMWZyZkZTaFdJMUNLT003OHBxVlVsaS9j?=
 =?utf-8?B?Yk84QS9ML1N4bEFXdjZia1JlSWhldlV0dFFNRDdWaUxzUmp2LzFsd2diajN4?=
 =?utf-8?B?NVJjSmw0bEZaS2FHOTV4azg3empQRlN0cjF0bjhwUngyTGRLMW9mOS8rMGxB?=
 =?utf-8?B?Y2VSZVZyR3RZYWhhbU82R2dPaytxWFI0UkszUDdYUXBpUjZBSkh5ajU4T3FI?=
 =?utf-8?B?OHRGYnkvSExqMmpWWU5NVWxWYkFLWTk5NWFOYlpCMGFWc3ZHd3VKb09UOSt3?=
 =?utf-8?B?eUljWmQ4bzRoUUxrQTczdDJkVVZ0b3lINEJmcDZ3TlJLdEIwQVV0Ulk4V2dE?=
 =?utf-8?B?dk5KYWgwSXg4VmxSTjhITHJ6bHh4dW5tZTZDN0VZMkx2VVNUMllHWTNtcDBZ?=
 =?utf-8?B?aXpnejFwMGp3U3g5TjBIMFNzRnF0WFhQZFlJbnM1WDBXNVBkR1doMDJYZVpq?=
 =?utf-8?B?VmlEUThzZWJCbUtoQXRtaGZMTmhFU3FDZmRacXBhN25iRHBBZk8xNllkdm9Q?=
 =?utf-8?B?YnBadGdNVmZQV1lhSTQyaVBmTy9POTVPblFaOERJQ0hIc1BYMTBKSU15QjdR?=
 =?utf-8?B?VTExd2p0ZGp2K0hCcGVzMnkzK213ZHpBU201Vm9vU3d5N2ZEdDArdEkxV3NP?=
 =?utf-8?B?RFM1MndlNGx2T3Znc3RQdWhLL0FHdkdjRGFFdVZQVUdXYk9QVjg1UUxlOEVC?=
 =?utf-8?B?SjZuamZLTWNROElNV0trZWRMVzNjOEY3UnkxZW9iRUJKTlBua3huOGhXOXFV?=
 =?utf-8?B?czhrMXVlLzBweUl0cHZjLzlPcWFJY3VoMngwd1l6cEZxalp6aGV0ZEVISi9s?=
 =?utf-8?B?SnBkYjI0RW1TN2wzQTZ3MXFDZXNldHB5d2hWeGdISnJZTDNyeDZYRHlDT0Fj?=
 =?utf-8?B?SUJKdUtDOTZoR0FUb0YzWlkxVTVHR2ZIZHhEVk9OWTBJTjJ0bEZEaUlFa253?=
 =?utf-8?Q?OIqXYl4T4G8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTJrM3l1b2VvMnNQdzN3Y2RZeHFkU2h5MW9HaFFDR2dWVk9WbFp1WHlKd20x?=
 =?utf-8?B?ajRCelNxb05QYTB5RWJoMUN2dFh4bTkweHU4cFVtc3QzeUpWd3ZrQ0J4SkR1?=
 =?utf-8?B?VlhUbFZKT3hoTmxlbFdraklTb2QrRG1jdU94NkVQVG9vTElwd0VYWG8zSysx?=
 =?utf-8?B?MC8wMVZtSVRTV0FLNGpmenpFL1lXaG1Qam5VQ2VRVWZ4QjFhNEVjNUVBdmVm?=
 =?utf-8?B?YjVhM0Zqd24vWk1RTHdIenllZkVYNmlDTEw5U2lQRlptaUwwNlZNaG85MnhZ?=
 =?utf-8?B?VWt1SXBzY2xLdGJ0MzhJcE5SQzVsZnU0bkEwNDlGVDlzdG0zcDlKeUUxL3I4?=
 =?utf-8?B?NXZUVVJqT0FlNFJSdEJ6UkZ1d2UxRGJnRlBZeWhrZ2hNUXhRck5TdFFieEE2?=
 =?utf-8?B?SjQ4WW9EanVBVzRsSnZ4ZUtQTVR6Nng1MVJYM3huVHdiT0FjdVBKSDFENlJL?=
 =?utf-8?B?SmI5MzZQUUdka29LVnVTS1NBV2w1WWRXRnFoREVPMDdkZzNDc0dMYmxLWS9C?=
 =?utf-8?B?S3NGVUdLc0NJeksvZGJNS3FwVFlyTmdEWnZaN3Y1SE90YnVHZmtXQ3Iyblli?=
 =?utf-8?B?bm1oZzBMc00yZGd0NlJYajEzeTdpaHI2SEhsRmcrd0J6dTRNN2VFL051OUdw?=
 =?utf-8?B?VWdNYmtCSzV5MExqS1NYZWM5VDBKNXA5bzc1clB0N1NHNmFzS1BMeERKenVw?=
 =?utf-8?B?NzEyMDN6WXhPcGRvZm1HbTcyK3phc0VLR2lBUmFYRWNrQUJObkRrRzBCWkNq?=
 =?utf-8?B?OG8vR3V2WlJ1SDVjdHZiVEtrSUg2NjRibC9YMkY5NzNCNFBEKzNHV1NoY3Rm?=
 =?utf-8?B?cXFGRVNUWjN4dWEwQ3BBWlpSa3F5bU53RUlSdnlTY0w4S2lwcWhIQUt6UURF?=
 =?utf-8?B?UG10dFNzVXFqMFlOUXVZbFlIRXEwWmFnSHVNbE1uaHdGenE5M0RPUlVwOEYv?=
 =?utf-8?B?SEFEaTNkSFlpZm5XeCtlRS9FdHZaY0FJNHpWcWF1QWt5TDY0UUtGZU9xYysz?=
 =?utf-8?B?MWVuWGxaMDY3eE55YUZjZ0hDMDNvRXppTVdzVGhkQzNoN2V4Z3lLQWpSQ2tq?=
 =?utf-8?B?ME95VUhUVUZJM0IrOUREQWdIRzJvRTB1aFZwOHpYcFM5SUIycHhrRTVCTE1v?=
 =?utf-8?B?ZDZqLzZRc2tBd3VpUnVqT1hXS2UwV1hqZ1VwSHEvTDBVUEE2ZFJJSUF1bDlE?=
 =?utf-8?B?RWhhMlBXZnprc0ZOcFlnUTZHV2o0M2JHYlRaaGFUa3Y3R0JKMzdaQzg0Wkcz?=
 =?utf-8?B?UkZWMm5qQ3Nyb1FHTjZiRGxlWVJ6Q1ZDMTBBQU5qcGdPeHJ1VE43T3ZqK29r?=
 =?utf-8?B?L2M3TjBNS2J0WU5JUERlVFJWeDFTV2hOREM1TkFLTGdabVlTUU14TWUwN3dy?=
 =?utf-8?B?MVhQbFd5c0VkSUcwaVl2UlFrekt6eGVJayt1MDkxdXB1N215dFNGMTJyeG56?=
 =?utf-8?B?bE45anhnWFZkUDZocFMzT2swRkJzbWJUay9McHphbU4zTXIvVWVxMnlMZFVn?=
 =?utf-8?B?K0NjZlJnOStlVnlVbHpacklNbmJlVnJuc2hNMTRrUHlnbHg4dDdvcTNyVjFy?=
 =?utf-8?B?bjVyTE5ra3pKUmFTL1ltb3dENmVMeG1KYjNnV1E2VldwVEgrazhqaEhjWWxv?=
 =?utf-8?B?d0l4TTNuWW50QzZLSXBaeFZiYUdhOGtsMVFQN1NkZHc3MUZPNkxORy95UWR5?=
 =?utf-8?B?UmtDY0RtWlg2SGNSczVoUVQydmZCa0RWd0dCSXNXcXZ3RmlJWUxBRnY5K25T?=
 =?utf-8?B?eGNMOE1rZnF4OG8zOUZpK29UNTRYajVPVWozbW16R0g5K20wbE5scmx3d0FU?=
 =?utf-8?B?UkwrdVNVcHRydkdPWHhya3Q4dVhXaVJCdG9YWTc4Um14dGxyLzRGdDVodW5h?=
 =?utf-8?B?b3BQNHI4d1Zlek9qenNQdU8zWXVpbDdWQXljNzN2Yi92WUhIYk5uVVJzZHY1?=
 =?utf-8?B?YWxoMWF6T2ZHUmFrdnhzN3ZLV0J1WVQrNUtWSUd0TTRZdHdqTzVXQ2lRNytr?=
 =?utf-8?B?SFp1UjV2WXVEK3ZlcnZ5QzNpR3RXSlBtOW1yTndSUjlhMjNwZ0pmTHh2L0d4?=
 =?utf-8?B?amZMY0t2VzhyTmIwVkdWVE1GQjI3OTRnalJGOFhnSVMxam9IWjh4WUVSZURJ?=
 =?utf-8?B?cUNLemc1UTZDcmRVRGszUjY5c09XNmtaaFV6REloUlJUQkpXNXREdUt1WmVB?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ec0127-924f-4712-204d-08ddaf63a200
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 19:01:01.2674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zG9ORpdcUnSNABlIksfTcR4MJ9vDBaXFft/PLWUrwHlREpOHrFFm+ocIjtqvn6mW2dZvfj0HVv2CBn4c7G+tKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6355

On 6/19/25 10:00 AM, Shuah Khan wrote:
> On 6/19/25 01:46, Chen Linxuan wrote:
>> On Thu, Jun 19, 2025 at 5:23 AM Shuah Khan <skhan@linuxfoundation.org> 
>> wrote:
>>> On 6/9/25 20:07, Chen Linxuan wrote:
...
>>>> diff --git a/tools/testing/selftests/filesystems/mount-notify/mount- 
>>>> notify_test.c b/tools/testing/selftests/filesystems/mount-notify/ 
>>>> mount-notify_test.c
>>>> index 63ce708d93ed0..34afe27b7978f 100644
>>>> --- a/tools/testing/selftests/filesystems/mount-notify/mount- 
>>>> notify_test.c
>>>> +++ b/tools/testing/selftests/filesystems/mount-notify/mount- 
>>>> notify_test.c
>>>> @@ -465,7 +465,9 @@ TEST_F(fanotify, rmdir)
>>>>        ASSERT_GE(ret, 0);
>>>>
>>>>        if (ret == 0) {
>>>> -             chdir("/");
>>>> +             // Suppress -Wunused-result
>>>> +             // Ref: https://gcc.gnu.org/bugzilla/show_bug.cgi? 
>>>> id=66425#c34
>>>> +             (void) !chdir("/");

This is quite ugly. :)

>>>>> Why not fix the problem the right way by checking the return value.
>>> Suppressing the error isn't useful.
>>
>> The code is already handling cleanup in error cases,
>> and I don't think checking the result of chdir would be useful here.
> 

Why not just fail with the appropriate test result, if chdir() fails
here, instead of making a bit of a mess with odd void casts to a
negated return value, and a reference to a compiler bug report?

Really, Shuah is putting you on the right path here.

> We check for chdir() in several tools in the kernel. Add a check for
> it instead of suppressing the [-Wunused-result] - suppressing doesn't
> do any good.
> 
> thanks,
> -- Shuah
> 
> 

thanks,
-- 
John Hubbard


