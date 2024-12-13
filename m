Return-Path: <linux-kselftest+bounces-23321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0709F0F1A
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 15:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF36162C4A
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 14:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335C11E0DE3;
	Fri, 13 Dec 2024 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="OnQLFQg5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020099.outbound.protection.outlook.com [52.101.189.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87BD1B6D0F;
	Fri, 13 Dec 2024 14:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100178; cv=fail; b=ro3okvZFiS6cHVmKzinVu7E8x0k0mqUCtT1+1qhr4+sIoR5XcFXG7oBtrbtEd9g4KcqbJV6rDofxGQkn1levzdEt6GsIROr2UqhtmOX2B4F9ok4xFshAEsF8qvsWar+fpyJb6oPmMtTc0RM5kRw7TQp52DtKEQ0J8FvCgh/azGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100178; c=relaxed/simple;
	bh=t8FSQQqFVQGQN4NYB+cefeH/nnsCR92ussz19eGrZvM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HDlGJrbu3w9En7igr9+IWMHzenb/KrxHe3LvF7RFb5/g2gMLgE+gDn0OlcFqZQAjehpuHqeoHXTITexPD0Ed9AePPnTWzFhvD0bakR3AAsRK3UREso0uMCbbd5wjL3kLZ/kRORnmCeMb0O6TLccmPyCmuG3yhxq6V+dG+f5a7j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=OnQLFQg5; arc=fail smtp.client-ip=52.101.189.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZ/yxgLxGTlohlu9Lx4L5esRflaVeCsJAWB8GR4/UZXEdSeaQoUqh+60Rpus6oI9A5L/8OvPQP+YRvYdiKqu+e6sitPyerkGkpyaM5pOytDQ0WYpcbNUvabS/+Sj1Hoa5Ny5Ct6tdHKS4XHtl4stVMDiRIxrDP6c/DPK03f2GlcMsLzxOluB6s5GFFwP/l7JwoVr0es7VTBh7L9BO5vSdrpl+S9vcDMPUGDMUPXhQr3ZNliuK8xXgtj9FLt6UpZdZHF4GLHVrQ83KkNBkJeMI5cp9M7Rkb60VOqNO6nE77WApHq0kJ4kMjTPWGzSYRaEFh5vdzx/F0ehUO0gHFF30A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIaTi5Ib+S48hgdzga8ZXRMu7TGkCxyXwLSB5/M/wGg=;
 b=WwJECz7aT3o7PxWFsC7MoyoRedUoi0PzNmE352qDhuQbrSuQ5JpxNlwKW8NOAa05uWzTUSRes7FbIzd4aWMKZTk4wd3QG2t4QuU5uXjfX4YxuT3Qxoj10VIRHKIsVjgnVi0ZXihxGLQ+eoGrULzeiEcnR1xkfoeUAt12XVOfSkIxxUw8y3/J9wIlii13Esjjl9D7MTx9wbEUKlLMXjPiYmM5UV7wgv8aB2ardWtAGFQbumMLM7tsN4gPanyhY+FG99UYvMFyMsmcuydl2w3Qouy/IxXJEIg3iej6dOgYby+AKb3+08do8RGPRVUBTyuh8FPRjreRA1sV/5dJ/mODvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIaTi5Ib+S48hgdzga8ZXRMu7TGkCxyXwLSB5/M/wGg=;
 b=OnQLFQg58/5DD86ZvNshFzzrHPN4UFbSZ9iyw3hYwawaW6OM2G87DYe8u8oeb9UJk8txAw5s6ojUVcN85fvTvBKMZLFf34UK57MwBQNSfVfRCA5y+NfJ6zmtdoa2AoGmeYk1zcCpVgqaVfcLJcCi9mIkmca0hcmEdzfEE0ezi5b3jfk/nIjZUGOXIOUf3akpvRgMhuVoPSnOM04+KN7o1HrhOPcz6Bv6xPPJ8sK6leTxYqGwlNDUzAGpqUeARpVQ5oU+n5+OOU38OvXITWfH4fP/i92aUzGKPsVnnj/9b2u8Ogtr3mIqzgWLv3JTHSMrvZ1TRm29Hyt1Zs0lb+Q60A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT5PR01MB10897.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:137::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Fri, 13 Dec
 2024 14:29:32 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%5]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 14:29:32 +0000
Message-ID: <d1e64ae2-9a16-44af-afca-a1940f27d4ef@efficios.com>
Date: Fri, 13 Dec 2024 09:29:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] rseq/selftests: Add test for mm_cid compaction
To: Gabriele Monaco <gmonaco@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Mel Gorman <mgorman@suse.de>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
References: <20241213095407.271357-1-gmonaco@redhat.com>
 <20241213095407.271357-5-gmonaco@redhat.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241213095407.271357-5-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::14) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT5PR01MB10897:EE_
X-MS-Office365-Filtering-Correlation-Id: 98dbd9ad-70cf-4335-0a60-08dd1b828f89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFdhOGtVeUx2RmtMT2pGTFErcEVISkdMdDJmY0xIZ2J2U1p5UDJEN01VRUNR?=
 =?utf-8?B?VVJ1Q1B5VGtoV2pjamdZSTlLT01CREdGTmpPeFQxU3hJUVZvUkR0QUJRLzhG?=
 =?utf-8?B?WXdOMklBVk5DeW56MEdURmJCamVueDlBSXRCT0NBeEthWnZ0UWgzNUg3VVpQ?=
 =?utf-8?B?NjV2Q2ltQ3BoUDNuZVptKzcrN1pRL2tFaHoxUGJRMkpBWDR2N1hRMWF6WTlO?=
 =?utf-8?B?TmxHZWRDZmpRd0RqNmZqeTJKbU5QY2psczdlYVU0SXBGSG9EZjQ3WjZlWDBp?=
 =?utf-8?B?c210K3N2NFZPL1pVRG5TTjlTcUU3b3FWOWJIR2RVZFlpSFV6WHJqMC9mTlFZ?=
 =?utf-8?B?NjdoRTNKcHFTck9ycmhyZHdMT0ozN0h0TnludENiNzAvczVZMUYrdWJ6YWFm?=
 =?utf-8?B?Z1pqL3BBRmcyUmpZTlVMY0x6V0poalBEMmhKVjNWUm5zYUxsMkVTbUFsMWFX?=
 =?utf-8?B?akZabEFZNFgrblVzczVnRVdDNEJTRWVsOEQ3TEk2c2o5VDJSZDJic3E5ckpW?=
 =?utf-8?B?R0l1dUc3T291OFFBM0VOVVNWdllhK2ZsbG5TQSs1bk5PdU40NEtLNzA0WFRk?=
 =?utf-8?B?eEJUUEFEZ252blNqeXRkZS93cVRhd3VBYjlTVlRiczVXMjB0ajJGYi95N0Zk?=
 =?utf-8?B?K3RwY3hlU2JCOTVXNXNPQk5Pd2lINDJYMW5YRnhKR3lqVXB2a1pvWkRvb2Va?=
 =?utf-8?B?bVNLWno1NkU2dXBOWlNUdFdxb0xKRWhHY0xyZHJkbGk5aXZUNnIzQVlrQUxF?=
 =?utf-8?B?TDhGVDM0eDNzSWZHL0Rzc1FKUVh1dnpRc2lBaXdpLzNHb3RrZjZwSmprelY0?=
 =?utf-8?B?Q1BEVGRXZTN0MUtIQlhFMGZ2dlpBVXhpM1R0cEdDWVJxNUFDQVNYSmxhdVJP?=
 =?utf-8?B?MVBnSXh0YnFVeS83Y0d0b2Q4djFHUXlGYk1UTUpsR3dIbXU1ZDV4RVZQZk9P?=
 =?utf-8?B?RWQ5OE5mMTZYeU9tdWJCOWt4MlNROVh5MU45WVVnTEtyeXpPVTdMUXFWQ24x?=
 =?utf-8?B?SVhFSXBTbGRKUGlkS1puTEtTU09CWFNkZ0hvZDNseklkWWw5YW5CWGdWUTc2?=
 =?utf-8?B?c2ZrWFdrRC8yUnJGeE5KMnQvdWhFRW1IQmFRc08xUlhMSi9hWGlCa1FPZHFx?=
 =?utf-8?B?aVkwb2pqd2NraFRCL3pWSHJuTzVobVV0VXJEcTVZRk9POVdaTENMellBQnlC?=
 =?utf-8?B?aVRDK3lSNHozbjZMeHQ2ZEUxUmpGU0pHeHZNM3VOekhVVnduUVpnY0Vsb2I2?=
 =?utf-8?B?RWl5KzhMcko2Q0hNRG5uRmhmbG81QVZ3TDZ0a1BpWGo1dXd0dG5Ddkx4VEJQ?=
 =?utf-8?B?YUsrS1hPZW5EUFdldWlvZVhoeittNlIrcWJ5L2ZjVGZHN3loNkkxdURVZXk4?=
 =?utf-8?B?LzJhd3NGSlgrNUs1WXhNdHovNkRicDFHMkI1b2k1SlNqMk9QVEd2dWZWazJM?=
 =?utf-8?B?Yzd4Vnkwb25uTktRZTFRY1hGa3pmKzR6VGduaTF3OFpkTGhQK2pCTGFEbHpR?=
 =?utf-8?B?TU1GU0xNYUc2WjFiY0FBMncyVGxkSG1mZy9wNDRlM01Va2NVUzR1a24xU3VU?=
 =?utf-8?B?VWF5VDRwMXhSaW1OWGNqWk42RHVPSkhNcytYT1ZJdkl5NitqNU9Bd0xqQlFl?=
 =?utf-8?B?QXU1Z1dVQUxuZmFnL0JVODBXMG5tUG9OOEltc1F3M2V1UkFyZ0tRVjJ6MEkr?=
 =?utf-8?B?cVk4MTZvKzdsb2FBVXBwSUlBZFFrckxLVXViVDBOMi9CaDNPYlVOaXAzWlRZ?=
 =?utf-8?Q?RA+BEQi0QkdPzi6koXON0dbQZ9K2VCSo7kS4NHw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmhUTUE1MGFDRHFBTGtRQXM0dTNjQU1tSWhnNHJzV2pTTllwY0Q1MGVGYzFa?=
 =?utf-8?B?Y3NuVzJ2bElvWlhLZnloZGo0N0tIS240aDhmTmVURFVENkJneW4rcllYQURB?=
 =?utf-8?B?aFJDNlV0T2dnSjJBMU5HTEwyZGFNU1lmUGtOWGdIUDYzTWRWb1NpdXJhd3VZ?=
 =?utf-8?B?UldSZVR5U2JlUld0SkZydkVUUHUxWEQvcEFGZGY1M1UydVlJcWl1V2tkSTFj?=
 =?utf-8?B?Y3cxT01pWEJvZDJvTWl0S1dncVp6K3FuaWhacUZYOEY5UlpIZEJ6NThVbXBC?=
 =?utf-8?B?SmxqQnRlS2dJdEZneUsyVFRTL28xSzhzRnh6L09FN1VRV3dwUGw5cEt6MUN2?=
 =?utf-8?B?b1UvY1VTVmIvR2hQbFdYTmkwNW9PNldEMGtEYmVuUGJPaGNhUktIeEVKbDlo?=
 =?utf-8?B?Nzk5ZzIvK1NpanA5QzA0SFB1VjBTUFVFN3RnUkozb0pDMUVJaGQzR0RXRG9W?=
 =?utf-8?B?eStLMC9CRmxpNFVKOSsveStlamRpOTZNZERaK0FDY3Q5cithL3lVQTYyQzRG?=
 =?utf-8?B?WXVqRExycHpnNlFXWEs2aVdzQm9Zekt0djZYcmp1b05nSlZEZkVMSVlTbldJ?=
 =?utf-8?B?aEFoa3UrOUw1VHdNUnBQR1lPamhyWURjUWJNeUVnRHhmRFVsMHBPRUtUakxY?=
 =?utf-8?B?K01OZ2lYUTZoNHNYWnFISlFKN0dBcFp6ZUJGcStzQWFZcDZWbnZTUUJUc1kz?=
 =?utf-8?B?emFPZ0d5VmdPYjdMTFI1ZEhHN015WHpVb2JOMnR0bTR1TVZ6d3pxU0NObzFP?=
 =?utf-8?B?U0hCcWE4eWdGZ1JTUGlUeGh5enhqc1IzeEVibzlVSi9rdHdDVnZDWTBUQ25V?=
 =?utf-8?B?Z1dIUWh2QUhKWW9HZDIzd2NhL0QxbTNuSW42QmJCaWliUm52L3lOSGdTUnRZ?=
 =?utf-8?B?dWQrblRTRXBtQWxKRFNub242MjdrVWV1c0pCZlp0aHV3dEtGSExsNlBXY3pa?=
 =?utf-8?B?ejhMQi9wWlBXdjlpL1J5T0ErZUJLK252MFd3UGprQVYrT2VaZkxxdXViUVhm?=
 =?utf-8?B?NytzSXdnejNrVXYyN240SHMxN28rQjl6OXFRZ2daODhCRG5uM0dvK0duZlZl?=
 =?utf-8?B?WURUemtxNUpkakZQQktKWndMbmRoUjVUUnpEYWF4bXJRTXdrTk9Pazdyd0tX?=
 =?utf-8?B?OHVrdnA0UW1jQjNxOFlYV1lDektFK1ZBZmdxei9vaHhnckJMbC9wSHIxNTQ2?=
 =?utf-8?B?VVFiUnVPaXNGd3YyOW50c1lXVTZNZ1FNWTAvay9CV1MvRWx5bWpMMEMrT0Jy?=
 =?utf-8?B?OU9SNzlxK2luakhRS24wbWV2c1llN2wwRmxwQ2dueUpRaTRvbWtRNiswcWVy?=
 =?utf-8?B?Z0k1SjRNL2tHQ0ZQbWs0b2p2dS9od1lkRWJvT0ZlTFJCRmN4RXhtQ0RvY3lH?=
 =?utf-8?B?VFFRRDYxQ05Nc2MxZUFqUEpqemtPZXdYUGlRemc5eHJhQU5yV2ZNKzU1N0Nj?=
 =?utf-8?B?dTNVL0UyanBCWWhKMTR6czRvaDdpRmJnZFdRYTdSR2txVkw2WmhnclRaWnJw?=
 =?utf-8?B?aDlxSm9MRnF5V1VraHhUaGgra0UvM1VGdlFaRTZYMnVUSUFqa3JOV0pLQ3BU?=
 =?utf-8?B?b1VFRlVKL3IyMmFCdjRScjJ0b0M5alQ4eW9oV2xsWklwd3h4aVZ4MHVNc2V6?=
 =?utf-8?B?UTBCUjdycGRiYXZGQXE5Z1ByNHJpdzFoWEFwUEtTb0x6Z2M1SUttZitWTkV4?=
 =?utf-8?B?YkdiOWN2SEloL2dsNlJsRWYrbHg3VHJnYjhUZjREVDZJb0Q0Ymw0UlBCM2Zr?=
 =?utf-8?B?dDdpamMwc056cE1QWXlxNHU4TzZOTWdVaEthZlR5M240Z09pRzVNdnBIdUxU?=
 =?utf-8?B?V0tsd3l2bjU2TWZRYjhrVmtSKzlpUy9mRHgwazhVUE1nYUxkWVEzeE9UUDJk?=
 =?utf-8?B?UExIVCsrQk9ZS3ZNaFhLamJpL2JVbVo2OTdOWGhaRlZVTTYzUU5sVkdrU1VR?=
 =?utf-8?B?WnY3NTB2Z1RYS09vWmg5WThpVnZVWkhkWlBkQWRManR4ZENJbzZ2S0l0aG8x?=
 =?utf-8?B?UWkyd0g3SXVDM21keDV6UVFxS2g4OHlIRTBJQ3g0Q01pbmo0aDlBQ0I4YTVR?=
 =?utf-8?B?dUEyUHNYR1RDT1JsUll3NTRvZmpqcnAyZ3AwdHBRNWcyL2lxSzZOckUyWXhE?=
 =?utf-8?B?emRBc1lzbU5mMmExYmRROTFKZjdTSDZVVWRYWFd0VGlhZ2tBVGM5YUdVM3NB?=
 =?utf-8?Q?fpCZrQI+/F/Q4mZ+VA4Jq8I=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98dbd9ad-70cf-4335-0a60-08dd1b828f89
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 14:29:32.5513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aMZjTWAtWTf0YauXs5hNjIZKCVxI1t25Ego+vyOTtwl2ZL4r9qHe+hW4wO1w6DHwYLoaT4+KZeVN6xJWpbsmfdRpGSkNp9itZOUArNIOUZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT5PR01MB10897

On 2024-12-13 04:54, Gabriele Monaco wrote:
> A task in the kernel (task_mm_cid_work) runs somewhat periodically to
> compact the mm_cid for each process, this test tries to validate that
> it runs correctly and timely.
> 
> The test spawns 1 thread pinned to each CPU, then each thread, including
> the main one, run in short bursts for some time. During this period, the
> mm_cids should be spanning all numbers between 0 and nproc.
> 
> At the end of this phase, a thread with high enough mm_cid (> nproc/2)
> is selected to be the new leader, all other threads terminate.
> 
> After some time, the only running thread should see 0 as mm_cid, if that
> doesn't happen, the compaction mechanism didn't work and the test fails.
> 
> The test never fails if only 1 core is available, in which case, we
> cannot test anything as the only available mm_cid is 0.
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>   tools/testing/selftests/rseq/.gitignore       |   1 +
>   tools/testing/selftests/rseq/Makefile         |   2 +-
>   .../selftests/rseq/mm_cid_compaction_test.c   | 157 ++++++++++++++++++
>   3 files changed, 159 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/rseq/mm_cid_compaction_test.c
> 
> diff --git a/tools/testing/selftests/rseq/.gitignore b/tools/testing/selftests/rseq/.gitignore
> index 16496de5f6ce..2c89f97e4f73 100644
> --- a/tools/testing/selftests/rseq/.gitignore
> +++ b/tools/testing/selftests/rseq/.gitignore
> @@ -3,6 +3,7 @@ basic_percpu_ops_test
>   basic_percpu_ops_mm_cid_test
>   basic_test
>   basic_rseq_op_test
> +mm_cid_compaction_test
>   param_test
>   param_test_benchmark
>   param_test_compare_twice
> diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
> index 5a3432fceb58..ce1b38f46a35 100644
> --- a/tools/testing/selftests/rseq/Makefile
> +++ b/tools/testing/selftests/rseq/Makefile
> @@ -16,7 +16,7 @@ OVERRIDE_TARGETS = 1
>   
>   TEST_GEN_PROGS = basic_test basic_percpu_ops_test basic_percpu_ops_mm_cid_test param_test \
>   		param_test_benchmark param_test_compare_twice param_test_mm_cid \
> -		param_test_mm_cid_benchmark param_test_mm_cid_compare_twice
> +		param_test_mm_cid_benchmark param_test_mm_cid_compare_twice mm_cid_compaction_test
>   
>   TEST_GEN_PROGS_EXTENDED = librseq.so
>   
> diff --git a/tools/testing/selftests/rseq/mm_cid_compaction_test.c b/tools/testing/selftests/rseq/mm_cid_compaction_test.c
> new file mode 100644
> index 000000000000..9bc7310c3cb5
> --- /dev/null
> +++ b/tools/testing/selftests/rseq/mm_cid_compaction_test.c
> @@ -0,0 +1,157 @@
> +// SPDX-License-Identifier: LGPL-2.1
> +#define _GNU_SOURCE
> +#include <assert.h>
> +#include <pthread.h>
> +#include <sched.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <stddef.h>
> +
> +#include "../kselftest.h"
> +#include "rseq.h"
> +
> +#define VERBOSE 0
> +#define printf_verbose(fmt, ...)                    \
> +	do {                                        \
> +		if (VERBOSE)                        \
> +			printf(fmt, ##__VA_ARGS__); \
> +	} while (0)
> +
> +/* 0.5 s */
> +#define RUNNER_PERIOD 500000
> +/* Number of runs before we terminate or get the token */
> +#define THREAD_RUNS 5
> +
> +/*
> + * Number of times we check that the mm_cid were compacted.
> + * Checks are repeated every RUNNER_PERIOD
> + */
> +#define MM_CID_CLEANUP_TIMEOUT 10
> +
> +struct thread_args {
> +	int num_cpus;
> +	pthread_mutex_t token;
> +	pthread_t *tinfo;
> +};
> +
> +static void *thread_runner(void *arg)
> +{
> +	struct thread_args *args = arg;
> +	int i, ret, curr_mm_cid;
> +
> +	for (i = 0; i < THREAD_RUNS; i++)
> +		usleep(RUNNER_PERIOD);
> +	curr_mm_cid = rseq_current_mm_cid();
> +	/*
> +	 * We select one thread with high enough mm_cid to be the new leader
> +	 * all other threads (including the main thread) will terminate
> +	 * After some time, the mm_cid of the only remaining thread should
> +	 * converge to 0, if not, the test fails
> +	 */
> +	if (curr_mm_cid > args->num_cpus / 2 &&

I think we want  curr_mm_cid >= args->num_cpus / 2   here,
otherwise the case with 2 cpus would not match.

> +	    !pthread_mutex_trylock(&args->token)) {
> +		printf_verbose("cpu%d has %d and will be the new leader\n",
> +			       sched_getcpu(), curr_mm_cid);
> +		for (i = 0; i < args->num_cpus; i++) {
> +			if (args->tinfo[i] == pthread_self())
> +				continue;
> +			ret = pthread_join(args->tinfo[i], NULL);

We'd want a synchronization point to join the main thread. I'm not sure
if the main thread is joinable.

Perhaps we could try calling pthread_self() from the main thread, and
store that in the main thread struct thread_args, and use it to join
the main thread afterwards ?

> +			if (ret) {
> +				fprintf(stderr,
> +					"Error: failed to join thread %d (%d): %s\n",
> +					i, ret, strerror(ret));
> +				assert(ret == 0);
> +			}
> +		}
> +		free(args->tinfo);
> +
> +		for (i = 0; i < MM_CID_CLEANUP_TIMEOUT; i++) {
> +			curr_mm_cid = rseq_current_mm_cid();
> +			printf_verbose("run %d: mm_cid %d on cpu%d\n", i,
> +				       curr_mm_cid, sched_getcpu());
> +			if (curr_mm_cid == 0) {
> +				printf_verbose(
> +					"mm_cids successfully compacted, exiting\n");
> +				pthread_exit(NULL);
> +			}
> +			usleep(RUNNER_PERIOD);
> +		}
> +		assert(false);
> +	}
> +	printf_verbose("cpu%d has %d and is going to terminate\n",
> +		       sched_getcpu(), curr_mm_cid);
> +	pthread_exit(NULL);
> +}
> +
> +void test_mm_cid_compaction(void)
> +{
> +	cpu_set_t affinity, test_affinity;
> +	int i, j, ret, num_threads;
> +	pthread_t *tinfo;
> +	struct thread_args args = { .token = PTHREAD_MUTEX_INITIALIZER };
> +
> +	sched_getaffinity(0, sizeof(affinity), &affinity);
> +	CPU_ZERO(&test_affinity);
> +	num_threads = CPU_COUNT(&affinity);
> +	tinfo = calloc(num_threads, sizeof(*tinfo));
> +	if (!tinfo) {
> +		fprintf(stderr, "Error: failed to allocate tinfo(%d): %s\n",
> +			errno, strerror(errno));
> +		assert(ret == 0);
> +	}
> +	args.num_cpus = num_threads;
> +	args.tinfo = tinfo;
> +	if (num_threads == 1) {
> +		printf_verbose(
> +			"Running on a single cpu, cannot test anything\n");
> +		return;
> +	}
> +	for (i = 0, j = 0; i < CPU_SETSIZE && j < num_threads; i++) {
> +		if (CPU_ISSET(i, &affinity)) {

Including the main thread, we end up creating nr_cpus + 1 threads.
I suspect we want to take the main thread into account here, and create
one less thread.

We could use tinfo[0] to store the main thread info.

> +			ret = pthread_create(&tinfo[j], NULL, thread_runner,
> +					     &args);
> +			if (ret) {
> +				fprintf(stderr,
> +					"Error: failed to create thread(%d): %s\n",
> +					ret, strerror(ret));
> +				assert(ret == 0);
> +			}
> +			CPU_SET(i, &test_affinity);
> +			pthread_setaffinity_np(tinfo[j], sizeof(test_affinity),
> +					       &test_affinity);

It would be better that each thread set their own affinity when
they start rather than having the main thread set each created thread
affinity while they are already running. Otherwise it's racy and
timing-dependent.

And don't forget to set the main thread's affinity.

Thanks,

Mathieu

> +			CPU_CLR(i, &test_affinity);
> +			++j;
> +		}
> +	}
> +	printf_verbose("Started %d threads\n", num_threads);
> +
> +	/* Also main thread will terminate if it is not selected as leader */
> +	thread_runner(&args);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	if (rseq_register_current_thread()) {
> +		fprintf(stderr,
> +			"Error: rseq_register_current_thread(...) failed(%d): %s\n",
> +			errno, strerror(errno));
> +		goto error;
> +	}
> +	if (!rseq_mm_cid_available()) {
> +		fprintf(stderr, "Error: rseq_mm_cid unavailable\n");
> +		goto error;
> +	}
> +	test_mm_cid_compaction();
> +	if (rseq_unregister_current_thread()) {
> +		fprintf(stderr,
> +			"Error: rseq_unregister_current_thread(...) failed(%d): %s\n",
> +			errno, strerror(errno));
> +		goto error;
> +	}
> +	return 0;
> +
> +error:
> +	return -1;
> +}

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


