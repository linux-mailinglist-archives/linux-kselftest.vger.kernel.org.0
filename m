Return-Path: <linux-kselftest+bounces-23319-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216249F0E78
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 15:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BF8D16233F
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 14:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2911E0B9C;
	Fri, 13 Dec 2024 14:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="JyUVGnq6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020091.outbound.protection.outlook.com [52.101.189.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD251E0B66;
	Fri, 13 Dec 2024 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734098712; cv=fail; b=fydpjUW21RAo8q+hoqmVt5K6sPtWLKSziwN00SuCURyKHH3X+SZQzJjhuxfGUj3clUa8R8KMXsyMJMUDysHrtMn9MaOloa0qZF3sCj/bhNVB0/ODCNk9ni1lj18/UYadxyUptXofz3Dg8muY7g5VGQBSu6vsVQyQL+5lUTP7gAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734098712; c=relaxed/simple;
	bh=oWmR3wit0u+3T2jD+p1jHkta5uGPpgefXgEIVusW2x4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BzV93+UtBPLfvMpbNWH1Rb0kVA7tRGssDteiAUuM51L5kTYrRLd8ZuvhD72r0RfwV1VLT3kNMYXOL7Rz0MM+n9MhJOk+BLAh/Vv6Kr6NCcFQrNZFqoFdkUxnCvQid7ojnYr3H/vvxTL1Vy8pdWfxvxrQMnSAkm5sISqwqjeHRFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=JyUVGnq6; arc=fail smtp.client-ip=52.101.189.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E84wOWIvgHqx8c4scuTBJCEX+4Vg+yVoXEbLVuCHgSDIJ4wjKKI017BsFUzWKVezkrJSpLqiYNc0oaUDVmUYL6VdtLrrz6ri/GgsioKiT5y0QKR77p+kNNzBP6G3i2cVsSnypH7Pu9EsJ1RR1vCu+U9FC4GrBR/bnVkYB/R8N7FfpYsP7nsGHWrVChSKnAcxzzRt7SMjxWAbj/OH4NMcpev54XueIg0nOJW8Zo2OVzss6WhvNMTR7YEffD5BHwnQFuvkSmx2DNxPd3+lOc/JEbCtQcEH87frit+0aoo3GKxh2+PKPWCI7Z9C6mOqWSh1nyxkO+HK8HZeZu9lOyaq9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjP29sXazljMDqXANVIs5I7lIGUG4YslB0W9LOzzyGg=;
 b=VB3ugmKq8fUJrllnEw6Xek0eOmAwQhFpUXwInTUdSWx9jP8tV3SoE4gn9K7Sf8xV/C100OSpMANcrO8Z2Oa+OCHZpflHsUHpisop+cQNptKNTlRu64p35LfbmOU/HxVZ7NTVXn/K+mJW+yX23UwxXqDrrm1H7LucwgA5l904mm2Gx7AfUHgXnHwtYNRYPcmwLecIYNWfcIt6ECiQd3WLCb8QQg4EIZsZEvLPswXLcqfiSpC4rUiLISfunEEztkXijmYeDPHmig84y1JLbwz/LWhTOncpfeuUQ2UNAhmR9pjoB/HJcrB5RAdz7qZzLun35BT2RGBtBXX1jG2NrJP+FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjP29sXazljMDqXANVIs5I7lIGUG4YslB0W9LOzzyGg=;
 b=JyUVGnq6IA2FiM9fF8tk/szGINzIq5XLV+HqV4zpSfQDRhjvgJKNNw7sDpdOfqdpsHRvmR1yTo8sGEtpAiHrdNjg/hTPck0htJY833v+M2VQ9HfuWtR5rjWqxlC7zIixEvJtLvmd9SgD0wBao1He3iosfPf2QaYngc23VLUosg0H5Tw+3LmLzZjZ8HydcBuzxIl6ORyRIZr/N31X91yUVge3ZxFX9W9mQSdHHjYoF0HHHqceCf2ATfqBmjJl7UR+nnhr2XNAAAboA3OP0o3KGOoPPNPy0CoYnTxh6lulZARM1xP1kwbKiC3DJVnPps0pVxDLBquFCy1aCAogXbvyLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB6023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:36::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Fri, 13 Dec
 2024 14:05:07 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%5]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 14:05:07 +0000
Message-ID: <b7054475-1dba-48dd-8ded-8e4b1bbec5c5@efficios.com>
Date: Fri, 13 Dec 2024 09:05:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] sched: Compact RSEQ concurrency IDs with reduced
 threads and affinity
To: Gabriele Monaco <gmonaco@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Mel Gorman <mgorman@suse.de>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 Marco Elver <elver@google.com>, Ingo Molnar <mingo@kernel.org>
References: <20241213095407.271357-1-gmonaco@redhat.com>
 <20241213095407.271357-4-gmonaco@redhat.com>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20241213095407.271357-4-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0141.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::10) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: 944b97b9-4455-44f4-d415-08dd1b7f261e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTg3ODloZ243QVVCa2V5bE9QaDM4RE5Oa1JCWnFxK1ZkWHhoMmZlZHZIRXhB?=
 =?utf-8?B?VW1MWFZXZCtSdnllcU05SUhidGZsMW9odmtKQkMyWDByMkVMNzJCZEZPdTgz?=
 =?utf-8?B?Y1NKeDV4TFVZVFNnc2Nhb1FVUVZEd0FIT3JRd2VPVFUxS1lqb3paNUdXR1VE?=
 =?utf-8?B?UUtGR0FlVU4ySjFPK2pzT20yOWdNMHI0Wm1BZkJXeitzUTRocGJVRjRyVlAz?=
 =?utf-8?B?QUVOYlN3K1Z4RXRrQTh6ZlloczN1cVU1SDd5ZzN6UlFrbXRWLzN5TkZsR05s?=
 =?utf-8?B?SHNDeTIvVFhNaGk1ejFKWW15bngxUmcwMWx2U2duQmR0UmJiU05ocFp0MHk1?=
 =?utf-8?B?ZUxNNC9ST1JoTXBiMThxZWoybFRCS0NCVUZtejQ1Z3ZHVjJFV1BmWTR4SEJT?=
 =?utf-8?B?Y0Y3ekFnSTI4M0NHanMyQzMveTRlWnBvaFA3bTcwOFRPRW9mWHpFTzJNbndv?=
 =?utf-8?B?anVGd2s0YzROZnFCdnFjTzBlaHFhdlpodU0ycDhqS0d2ZjBmTnVVN0o1REE5?=
 =?utf-8?B?aThzcW9NQXUwZDhpSmRxTWdJclhvMzFXOWpCTWs3ZUZwdVhtWGcwczR4c1lJ?=
 =?utf-8?B?aVVad2dzSHBUbFpRZ0VRUTVrN2VpMDlkUE1ZKzh3Mjc2SjlzUUNLYlF5Qmpa?=
 =?utf-8?B?OE1DZ0JMWVJGZmlFVnlJZFVWdXRDN2UvTHg5OHhCTnBJSzhLZE9vT2tnTnEv?=
 =?utf-8?B?N1YzRXNRSmNBL1BLVXhhNFAxbmFYZHJKS25IN3N0ZGp0cjAvcExyYmVQUjVw?=
 =?utf-8?B?TWRwU3pzTHJTMEpBSkJMLzdFVitVeGx0Ui83WlppZFl6MUZmVUR0Z3JZZ2g5?=
 =?utf-8?B?M0V1cEtsQ0Q3bWVXcFNKVFgrbHVPNHhZSDN0a0pSYTBjcElLK1lIOEFSSW4y?=
 =?utf-8?B?Yk13eXBoanFEZFFpM1RjZWF0QUZGYUl0RklGMG1ZZVBjU09acUl4blNCclY3?=
 =?utf-8?B?SWFDZlhZazhrbWI4bGR1ZFRUbnljek1oZXpJVGxreFFNNm56UjBWVGVWVHVy?=
 =?utf-8?B?dEFiaUtHZ0JaMTVWcVBWdXdJWE9RYzhUeDZ3bnhLYVNVR3l2Tzkvb1hwb3hl?=
 =?utf-8?B?WGZ3NVBtbVB0N1NLZ013dlFxL3RvT2ZxWjdNNWNqTTVqMkdMYmI0MTFrL0pP?=
 =?utf-8?B?c2xkckhDNWhabnRCNEswU25mMEZkS0s4N2lLUmdTTnNyNWtCSXZ1N2JNbmFV?=
 =?utf-8?B?MmNQZjRydFZ4c3ZuRkJyNk53TVNvVTFxbkhPYTNKdUUvSy8zU1VtV01SWDJT?=
 =?utf-8?B?N2lHMHpGUWFZditad1BqK1d1bjd2YzRnamtjZzJxdi8xTnlVSEVNUVI4WXpa?=
 =?utf-8?B?WXc1MHZFaXhhTHVLOWRhZmg1dzBpa212T0tmUHdJSmxuZFIwRkFYWGpnbytP?=
 =?utf-8?B?dW5SVy9ZV1dGSjhFdU5ncDF1ZTlTSTNEUjhLcm5VcEw0eFFTZU9GTzZhVTVC?=
 =?utf-8?B?OFBzalFTYXJpQ00zc0prZkhjVzZyZ05IU29LNzAydHlQRnNoTnhqcWhtTk9r?=
 =?utf-8?B?cTZKeHJzVUdmdys5c1NJUGxpMkVHQWlqUzRjTUVFZFV2NWFaVFl0NTFkU0Vt?=
 =?utf-8?B?c1FkdGVhZVZYQ3EySllyNVZYQzRSVW5PTWRKbnRrd1RmcHZmTjAwSTM2Ykdq?=
 =?utf-8?B?ZWJpUzFjVUtKZXlYNVdsUUxuMTNVWkdUYmU1a0V0b05VdWkrUnlKdkw0VTRl?=
 =?utf-8?B?R2dRMitxVGtFTHdUZmlwbXQyem5ENG01akt2OCtmNm1rOXBFdHRMbGc0eXZv?=
 =?utf-8?Q?PySgDon75qVe3KU4DE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlZJaFYvOVpKSFd3Q2k2WDZncVdUeGk4dkxneFM1RGZVSWxLK3FvcUx0ZldF?=
 =?utf-8?B?STVUcW9DWkF1N3NTSFpaYkxVS2tveFRTUTlPRlJta3VabHY2c0cyMUhhWk40?=
 =?utf-8?B?SEpRd3E1WlJwUExQTzhueHlNMGJVSk11OG9GLys5OHIwSXpuelB2Q09OT0Zk?=
 =?utf-8?B?MU91NCtzcmlIMWdxZ1JxTmZOYVVwc0FjbXgzZUJmYXdvM0tUeERxZGZZU2E4?=
 =?utf-8?B?dFlGWTdGeE9QMS9QUnFLTmFDOXZGcHVKK3R4d3NNK2plMDNPV1QrQklBdmlD?=
 =?utf-8?B?eWxHbnB6bkFGbWRRcTNlZzI4aEptczJmTk9QNW94K09DbVhzY3E0aUEwVVVR?=
 =?utf-8?B?WFU2SHNVYUdRNW5DblpFU1BOZDBmRTJDU1ptWmtrY2Evc2hmRkEyTlJXUUYz?=
 =?utf-8?B?ZVREcC9VRmdEWTJlNEVESkFkNjRvc3dPMzA0ZkRESE1hOVRwWThpR2ljNWhR?=
 =?utf-8?B?d3loTzJQMXNuTmNycWJIdUp2cUE5UW1JaDhrN25WcnlCRkFVRWVRRm1EOUNv?=
 =?utf-8?B?OE5aVEMwVHJCK3pyaXRXUHlKQ21IWDBlNDVsbHVIS2M1VEJGbmxUVE5MRTdD?=
 =?utf-8?B?WDNEc1NHeTJjS2VsWmVQa3ZDTTkxRml5TTVRRitHaE9PcmN0a0pVZWt0VC9l?=
 =?utf-8?B?UmhmamVrUE5IdzR6bEdzMVNpd2xzVytuZ1hBekh2cWpaVmt2RkFNWnAyNGpz?=
 =?utf-8?B?V2ZkNGthcGQxWVB0TGI0a0ZjYU96dnlta1NjU0JzWWVEdkROck9sbDZURDFT?=
 =?utf-8?B?S2FqVkk5WGhVOFlJTFFHWitQMjBLZExwMm9vVHNNZG9xT21ISXJ4amlrL09T?=
 =?utf-8?B?eHkrSU03QUdqU29NbWpOS0dGQll0ME5aNmVGdUZRcDhrMlRWaEpkUCtaQURE?=
 =?utf-8?B?SHM5dEszOUs0OHNOamxDZWk1eWEveFE1OVNLdnZOOTRvZ2xZRWdtd2RHVWh0?=
 =?utf-8?B?a1E3TERzNy80TU90c05qRWVETTlYSUJuLzc2UjJrbE13cjl2NDZOM0tTa2Vo?=
 =?utf-8?B?R1gzRDJkY3NxaXNLQll1NkN3bzFPemk1VFRpazhzZ0VHSGtOODRPMFVLblFu?=
 =?utf-8?B?dmEwdkg3Mi84b1Eycjh2WW9YTzkyaGVvZ2Izb3d6VXUwWEhrajdjbnlPQWh4?=
 =?utf-8?B?OUkrc1ovc3hJSE1Ia1kzc2ZmWFZJQTdJVUYrWTdkY1lhdS9iaGNBdEM3dDhF?=
 =?utf-8?B?ZVpodmREdmlWYmxUTFN0M09Cc05SQXhiSDBoQ1RHeDAyTHF2L05Ud1F4ejlp?=
 =?utf-8?B?OEFOcEhZMSthaDBqRU9FUHNhZDByek42bVQ1NDVsenlPVnllb1J0YnRLRXdt?=
 =?utf-8?B?QUtPVXAramliVVB3dkcyZXZzaUhKMXVIOTdrTjFFU0dKSUsvOFRCYTdwTmhD?=
 =?utf-8?B?UFJvMUtJbkxzOGcxVEo5Skk1Tmg2RzY3ZjhuMkJjUVo2WUdjR25ZYnpCMFZF?=
 =?utf-8?B?UlZoaS8ybkl3WTkwakl4bWltcmNnSjVkSFV4UnBHREs0S0NHaXNJNzEzVkNw?=
 =?utf-8?B?aCtzVmZwRjRsWVlLR283bXp6K0V6MTN6QzI5U1NnVmo1QXVnMTdFbGhHRzNZ?=
 =?utf-8?B?K0lqVEE5N3plV1BPU0U5bHdLUzIyNmNTemNSemt4T1FQQ2NBK1BybU9FSVBx?=
 =?utf-8?B?RlA0RnJuUXNxRjNqWXB1M3ZwQjA1Q2xQa1FRdFpsVlFqY0F2MGcxQXpuMUN2?=
 =?utf-8?B?ZzM4dE1wZHVIRHplamRRdlVza1R6TGdlZ0NYUUI5UVk5S0d0UWhjaDI4anlS?=
 =?utf-8?B?OWYyNGYyOERNZEptOS9SVHhCeXVXS2o3ZDhRRndhVHRhRE1HOGhnU1FSUzFR?=
 =?utf-8?B?MCtnd1EzWUFGNjFJK3lrdEo5WW5yOTEyUjRobWlnREpmRGwyUkxidlJCTisy?=
 =?utf-8?B?R0k2bC9lS0pnUkVMQzZGMGF0V1FUdWRTenBaOFJhY2Z2eTdOWnA3ZTRBSUZV?=
 =?utf-8?B?b0pPTXlhYzdEL2cwMDF1U3c0RjBIRkd0WjZYSkFJWXQ1R1g0MGxnV0xOOUdv?=
 =?utf-8?B?UTNWK3ZnaGgzQUVmVk1OZmJDYUhFa21STTZoR1VrZ2NzQjlsUWNwSFdCYW02?=
 =?utf-8?B?QTVBbVB5RjZRWjVyeXZESXBZQldnV21BaUdOZ1Rvd0orQXpQeUsvSUV6RVY0?=
 =?utf-8?B?ZFJFYXhmZkV5eVh2QmQ5R0FBK0pBbkRmY05IN1dWcWFVUzNSZEdwNlFKVFBP?=
 =?utf-8?Q?gDS24lAKnwzAH+52Ed6YNkU=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 944b97b9-4455-44f4-d415-08dd1b7f261e
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 14:05:07.2407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owBHr28jOp5aP2L9DDzRb786JAhYhRLra/TX6abf7lPb1hx8JLs4yCXqxga0aRa+oAhkNBEAf8SyQcfIKZjMKbPTtbCNGsKxESSWSLRrY48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB6023

On 2024-12-13 04:54, Gabriele Monaco wrote:
> From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> When a process reduces its number of threads or clears bits in its CPU
> affinity mask, the mm_cid allocation should eventually converge towards
> smaller values.

I target v6.13 for this patch. As it fixes a commit which was
recently introduced in v6.13-rc1, I would be tempted to place
this patch early in your series (first patch).

Then the more elaborate change from task work to mm delayed work
can follow, and then the added selftest.

The reason for placing your change second is because I am not
sure we need to backport it as a fix.

Thanks,

Mathieu


> 
> However, the change introduced by:
> 
> commit 7e019dcc470f ("sched: Improve cache locality of RSEQ concurrency
> IDs for intermittent workloads")
> 
> adds a per-mm/CPU recent_cid which is never unset unless a thread
> migrates.
> 
> This is a tradeoff between:
> 
> A) Preserving cache locality after a transition from many threads to few
>     threads, or after reducing the hamming weight of the allowed CPU mask.
> 
> B) Making the mm_cid upper bounds wrt nr threads and allowed CPU mask
>     easy to document and understand.
> 
> C) Allowing applications to eventually react to mm_cid compaction after
>     reduction of the nr threads or allowed CPU mask, making the tracking
>     of mm_cid compaction easier by shrinking it back towards 0 or not.
> 
> D) Making sure applications that periodically reduce and then increase
>     again the nr threads or allowed CPU mask still benefit from good
>     cache locality with mm_cid.
> 
> Introduce the following changes:
> 
> * After shrinking the number of threads or reducing the number of
>    allowed CPUs, reduce the value of max_nr_cid so expansion of CID
>    allocation will preserve cache locality if the number of threads or
>    allowed CPUs increase again.
> 
> * Only re-use a recent_cid if it is within the max_nr_cid upper bound,
>    else find the first available CID.
> 
> Fixes: 7e019dcc470f ("sched: Improve cache locality of RSEQ concurrency IDs for intermittent workloads")
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Marco Elver <elver@google.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Tested-by: Gabriele Monaco <gmonaco@redhat.com>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>   include/linux/mm_types.h |  7 ++++---
>   kernel/sched/sched.h     | 25 ++++++++++++++++++++++---
>   2 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 8a76a1c09234..16076e70a6b9 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -837,10 +837,11 @@ struct mm_struct {
>   		 */
>   		unsigned int nr_cpus_allowed;
>   		/**
> -		 * @max_nr_cid: Maximum number of concurrency IDs allocated.
> +		 * @max_nr_cid: Maximum number of allowed concurrency
> +		 *              IDs allocated.
>   		 *
> -		 * Track the highest number of concurrency IDs allocated for the
> -		 * mm.
> +		 * Track the highest number of allowed concurrency IDs
> +		 * allocated for the mm.
>   		 */
>   		atomic_t max_nr_cid;
>   		/**
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 21be461ff913..f3b0d1d86622 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3652,10 +3652,28 @@ static inline int __mm_cid_try_get(struct task_struct *t, struct mm_struct *mm)
>   {
>   	struct cpumask *cidmask = mm_cidmask(mm);
>   	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
> -	int cid = __this_cpu_read(pcpu_cid->recent_cid);
> +	int cid, max_nr_cid, allowed_max_nr_cid;
>   
> +	/*
> +	 * After shrinking the number of threads or reducing the number
> +	 * of allowed cpus, reduce the value of max_nr_cid so expansion
> +	 * of cid allocation will preserve cache locality if the number
> +	 * of threads or allowed cpus increase again.
> +	 */
> +	max_nr_cid = atomic_read(&mm->max_nr_cid);
> +	while ((allowed_max_nr_cid = min_t(int, READ_ONCE(mm->nr_cpus_allowed),
> +					   atomic_read(&mm->mm_users))),
> +	       max_nr_cid > allowed_max_nr_cid) {
> +		/* atomic_try_cmpxchg loads previous mm->max_nr_cid into max_nr_cid. */
> +		if (atomic_try_cmpxchg(&mm->max_nr_cid, &max_nr_cid, allowed_max_nr_cid)) {
> +			max_nr_cid = allowed_max_nr_cid;
> +			break;
> +		}
> +	}
>   	/* Try to re-use recent cid. This improves cache locality. */
> -	if (!mm_cid_is_unset(cid) && !cpumask_test_and_set_cpu(cid, cidmask))
> +	cid = __this_cpu_read(pcpu_cid->recent_cid);
> +	if (!mm_cid_is_unset(cid) && cid < max_nr_cid &&
> +	    !cpumask_test_and_set_cpu(cid, cidmask))
>   		return cid;
>   	/*
>   	 * Expand cid allocation if the maximum number of concurrency
> @@ -3663,8 +3681,9 @@ static inline int __mm_cid_try_get(struct task_struct *t, struct mm_struct *mm)
>   	 * and number of threads. Expanding cid allocation as much as
>   	 * possible improves cache locality.
>   	 */
> -	cid = atomic_read(&mm->max_nr_cid);
> +	cid = max_nr_cid;
>   	while (cid < READ_ONCE(mm->nr_cpus_allowed) && cid < atomic_read(&mm->mm_users)) {
> +		/* atomic_try_cmpxchg loads previous mm->max_nr_cid into cid. */
>   		if (!atomic_try_cmpxchg(&mm->max_nr_cid, &cid, cid + 1))
>   			continue;
>   		if (!cpumask_test_and_set_cpu(cid, cidmask))

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


