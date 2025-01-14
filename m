Return-Path: <linux-kselftest+bounces-24448-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E92BA1093C
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 15:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDEFE7A4C1D
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 14:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301171459FD;
	Tue, 14 Jan 2025 14:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="qknHJVHa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021111.outbound.protection.outlook.com [40.107.192.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3523623244C;
	Tue, 14 Jan 2025 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736864836; cv=fail; b=EN6fTQ9qSY4Vvqp0Nbyin4yYfbaHFG+CIe3efxy+weMSXddTeaAYpM/S6SprAD9CjRXh/bCWFjFsmTfbuTpK/htD3LBL4FD8WvgWmggwHYd99reUbBL4rSM+MdfQcUiZLVS7ZtIIyfQstNHF1OY49IkmcsRRNfAjB7vyc6zVAHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736864836; c=relaxed/simple;
	bh=CZauzPepOAwA+bsEFyQZktVT7y0BZbYWkCXeqX6u0Qs=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sF1Xtb6pzLF3qrW8kcIR5iuA5fIT3fdyCBTrWHTkkAUhpAFl7sypozLMWGDnF5KgabftnFRtSRYfAz4WSILSQWMKLgwEa8wo43/BCYjGmcAw8QlT21k5L+/lphJT5XS7OrCn0bHp7IWwH4vx3bbUBFCqqEH2g6wXzZsODzqnGl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=qknHJVHa; arc=fail smtp.client-ip=40.107.192.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LaTL3DsZc18QtKitS/XSfJPNkNX5YQ+AE8Q/5iQ+9zFMreqlwLeW9I35ZicGakDr222ZM5wbaRHDak39kVvdaQpqomI1NKyJWG6PMz0G96F/BY3R1v63qzkw7gVhisNob72/TxSgaht0EKSAhx2jWKfvsECAcfP6YOlI7BD5MWtvKKmJM9P+UM1ReehnQnc/3crwP9KKFGPypzADu5MCWniz8eoNKyKiDZNihH8qSmIKngtgl93Z3BKzC2fTWF/qpi3gMVzBmGdmnyVXZE7+r36+UH9m8w0rFKIG8K01sgJg/Fhd4dqHzc50C90jBJSET0h2EcKgAOBztPVf3Svo1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1c2WdGaPGTdIBK7tkwt/E5fvFcnmF0Zw9KijNoYQUsU=;
 b=pBqy17yeTiZ7QHBzXOOMGpjmxelUqZxmBcIxvBFHdXTufNmhoF+dY7AFslRYFNuJI89SpU3A68mqi3T6cO16HPD1Jbl2Kyjxsh+Y0/sjQ2ZCczZA3fA4oTkB4ZHjHic9pzTPkOTjPVNZJkd1O10UMpihlkSV5iIyVL0x91rE/smYj7ms/4/tcvRkzOdrrL7niRuG/IqT2wJKCto2TBIarXmcV1wccxAaZo+W1RZK0RHBeRvDendHgsVB1cI97amG4Ga/ExwyPucwmsO2MbfRu49tiXp+BpOtbf6OVN5XbOuApxSqzIEWwDUYecu2aLXQ90U4Zvm/XY2LnNMvlw0uIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1c2WdGaPGTdIBK7tkwt/E5fvFcnmF0Zw9KijNoYQUsU=;
 b=qknHJVHaho/G6SOXkzSUpWOUOBMVVKiOUHqRJCYhzKCfEl6whJzVXOf+VjYxE30M7YPKUxctaFHA2xKFb5rsnck+cxXoRliSMK93olrGat6LxLNC58dZ0Q6der0h/F+D3SOwUEox9cLi05aruJcUQu5gdhowE79+dpzFBJfBHfrqUShXQcZ0K9Uo4X0fQhjriT1++8pS0pL0bsCUkxTNGWe1Tiihh0ckSIW0kiHqHevELiXwgCqgv8h7W5oFbCZOLybtyEkFiadR5RnpnxX/qIYZNMH5/QABxi62evlrYT4Fx293aJiX1ILYhhAB00bO/aXDOsFVyvSdCe0/1dhZjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by TO1PPF55F13247B.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::646) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Tue, 14 Jan
 2025 14:27:11 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8356.010; Tue, 14 Jan 2025
 14:27:11 +0000
Message-ID: <fbfe56d9-863b-4bf4-868c-bc64e0d3e93a@efficios.com>
Date: Tue, 14 Jan 2025 09:27:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/rseq: Fix rseq for cases without glibc support
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Shuah Khan <skhan@linuxfoundation.org>,
 Raghavendra Rao Ananta <rananta@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org
References: <20241210224435.15206-1-rananta@google.com>
 <15339541-8912-4a1f-b5ca-26dd825dfb88@linuxfoundation.org>
 <291b5c9a-af51-4b7a-91de-8408a33f8390@efficios.com>
Content-Language: en-US
In-Reply-To: <291b5c9a-af51-4b7a-91de-8408a33f8390@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0004.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::17) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|TO1PPF55F13247B:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e356723-7f95-4dd4-d78a-08dd34a78891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Uk5pUmRLUE9Nd2JKWlh1YjBKVFBrTThOeXprMUhOR1VlVk5ZRWwzMmh5N3d1?=
 =?utf-8?B?RTJOTUc2WndQY1lOUWZUM1M0TG0rNjl4aFNrWHFlck1BYkExY3RLTmN1amtM?=
 =?utf-8?B?MnpvaW9FdTFWYWRPTkxyOEluZDZrZnRNYjlXU240TlZIcGh3U1FiQkJsblBw?=
 =?utf-8?B?QjQrd2VtWkpWQXJMR1ZvMDFDbFN6L0ZNSjQvV3pGTVR5Rm8wNUUvU0pqZDA0?=
 =?utf-8?B?TTN1SDV2R28weDFhL1pabjdET3pXSWhqb3FYa2RGVU1keGJQc0dkeGpPYmVT?=
 =?utf-8?B?eVBwQy9FblVHc2Exd1A4TkhpMmdsdk5MRlRscWtXS2orSU8yc2ZELzdRZFZa?=
 =?utf-8?B?UXQ3NDQybVNTa1FBdjl6Rjc1UktlNU84cjBQaVBmd1cvRkF4WVUvejd3TXNV?=
 =?utf-8?B?eEJLMFJzNGdrMEdaOVhTV2s1bjhkUTBSc2MvS2RYNU5DbU54T0ZPdzFRY01V?=
 =?utf-8?B?Uk5LSnNOWGp6ZkpGTUQwV082eG9TanNZQjYvVytGWUdZSi84RDFhQUxETnNO?=
 =?utf-8?B?SUFqdGpreGVrdTQyRHpJWk9NNHFUMWZTa1B0NXRlS2FvMzJJYzdVbFFaY0xR?=
 =?utf-8?B?cGpqczU0ek1ONEVMaWNCZENxMUZYSXlDcXZXQ08vK3I2OEJHZVhMaWpnb3pi?=
 =?utf-8?B?aVZXVkRZVklzaithZURzMFF4UGJ0U1IwazF0VC9JN0hSc21SdmlZckl6OG5H?=
 =?utf-8?B?S2kyWWhaSFoyblJhRlUvVkd4NmltcExrL1hpYXdMaTZNekM5TDZFTE8vVjc4?=
 =?utf-8?B?dmVkQ09qbU9YUGgyZmNlRzBHaWhVRlhzU1NVZ3ZnVjR6MnpQcDhvckJxYzlr?=
 =?utf-8?B?VGhVK01Fd2Q3cmkvOWtDRHd2YTNxRFBRc08wdnA2MFJ2b0hFYkt6QXVyN2d4?=
 =?utf-8?B?WlhsOHdpSWFwb24zVWdldWxYM2tGcnBLZzRkNktUUzdCYWJpenRzdUc2UFB3?=
 =?utf-8?B?anA1L3NZVjdyaktxQUM1KytJSE1MWTlyRnZBME03MDlOZkUvdTFMTTR4ejkv?=
 =?utf-8?B?NVZTVjByV1VLV2lyeC9HallBOEJhS1MwV0xVNENFVTc4TkRTNWZpY2dZSEdl?=
 =?utf-8?B?bldOOHhxTzNyTUpDY2tOQnJPWXR4cEJ3ZHRtbm1mK0dhTytsejRJRVJIYmd1?=
 =?utf-8?B?ZVhEQUdNU0pHSVhOM1BCVXgvMW13Y1ZBYVF4aDVhalhxdUlaY2p1cU9mQlFG?=
 =?utf-8?B?alU4Wnp4VVpPQTQ2K3QvKzJSdCtaT2MyM3hnNlFQMDI4NEpHM09CcVRseGlB?=
 =?utf-8?B?Z09wUFRadWtRUzFQVGxrNmNhUXJpZGZjU3pzK0R6OUI3VzlYM2Y1SWdyRFB2?=
 =?utf-8?B?SkFUY1RYRElrcmtZMmIzUDd4Q0hRMEZxZHJxb0t3b0FOcDRRVnFZQnNiOEQ2?=
 =?utf-8?B?ZGNnYUFoS3NOdnZIemE4OElJa2FCdkUrUlNvRnV3bmFzU0oxRnlJNmcxeFA1?=
 =?utf-8?B?VmEyRVJnTkJzMVhXN0JDSVdNaEtNb3c4KzFxTWJNU0JYYzNueXJTUytaK3Vy?=
 =?utf-8?B?RUxkTTFDc21xSndDS1hySjYwMlBsMFdDYkVkVEQ2U0JuU0pKMm9VZWQ1Ynhw?=
 =?utf-8?B?c1dqRWhIYWJGWW5uenVYc0dQM2JOTW1mYW5qRzRBNjY3NVo0ZHBGMG5PTWpL?=
 =?utf-8?B?OWdNaGRKYkxTL3p5UlBKb2tmeHk5QzRBU2oydFg2dVdtNWNTTGE4N0dlbmFq?=
 =?utf-8?B?WmJ6YUMvM0hnYnFTMHlYTnN0SDJBdlFsVTM4NC93RjR1bEcvYnpZTEtMaTdx?=
 =?utf-8?Q?QnVoy5EEO0a4leUsA41wuspIC6dN4IC9ZNfLxWi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TE9VZldzSE1tZjRrOHJRN2NERjRIUE55RkUrK3llS20rNFI1OVh2OXRULzk2?=
 =?utf-8?B?VytZSnBOQVJsU1pJaHlNZDFpQ0xpTnpObzhGbk81NGloNU0rQmtOR0R6WCtw?=
 =?utf-8?B?dENpK1JjVmdIa0pIN21xK3NQZi8wOEtpbzB3ak1RdnliOTdYT25lT3daRUJX?=
 =?utf-8?B?Y1YwTnZ0RS9ZRmVGanV1REFkczQxNU1GTE10WjMwMit4T09laWdHYzR2TVh5?=
 =?utf-8?B?dkJyVzZ1ZDJlK2hKd3BNYTZ4VStnd2xiRDh1MDhmVlRVN2x1Q1EwRzdoTnlu?=
 =?utf-8?B?T0lRbkVVakU0Y29LNHVwb2xQY2JXb0NuaG5qWDJ2U05EMXJldDVJUldWaWc1?=
 =?utf-8?B?OElncXNpZUEwdFZwWEw4SUEwdUNaNHhGR1pjSXo1eDZzVVowdXBMM0JiWTYw?=
 =?utf-8?B?UVk5QjVoMFVlN0k3VFc1TTdtZmtSaHg3YUNWaUU3SkI3QzRMQzZycHUvTEJt?=
 =?utf-8?B?bXJhQ2NSRWRTcmMzTm9xb3R0aVlFdkdIR1lOL3FscDhlNFN3NE1uRlh6YUNY?=
 =?utf-8?B?c3duMytSRit5Ky9vbmJCQXJtVFNmUUh0ei9IYTByRG50a2xVQ3ozS05QaUND?=
 =?utf-8?B?WnNISm1xeS9paitFRWFaNFY2K2o1YmNxWE5zekVPWjkrcjZXYzI0SlBNLzJB?=
 =?utf-8?B?YXpmTkdPMXo1b1RqaEh1cWdZb3Bvc3dGYll3SmxzejhKQ3lBNmN2SEJLTjEv?=
 =?utf-8?B?ZkxCdHBXS3NGTWR2SC9zSFhKbFZkbVFiVGRSRkNmcnZralN6NlUrVC9jamF2?=
 =?utf-8?B?R2hkbzFydWNJcVJER25PK2FHMGlUbmh0S0ZHb0tWUnFHNHM2K3FYejhvd285?=
 =?utf-8?B?bnRQNVBqQVhwNkNOVFRCb0l0N01qRU5VWDRFNS9RVW82MFp4dDNrUTdtcENK?=
 =?utf-8?B?ZGo4a2RrRmRvamtqRWdLYmFKWG1LY05oMTVQQmNENkNicWFWYnN0SHpGOWlw?=
 =?utf-8?B?RDJ6WSsrWHIydjZEK3cxbVBvUmJYLzdYMTBWTHg3R083bm9KUzVzRG9HRjRG?=
 =?utf-8?B?eEtXY01vOS9sR2NlNmF6aDlOaDFnbjZmZHQvc2w0RWc1UThHODNQemdHTFhn?=
 =?utf-8?B?bjdTeUFxdjFUbkZmQjRFbmlMek0yb1hzRUlqQWlVMlRnRkh3TWRYOWhNU3ho?=
 =?utf-8?B?QW9KL0pBZHRJRDhxeXhQMHZsdTJldmxLRlVZTVpUcVNyV2dMeEw5SmpyNFJB?=
 =?utf-8?B?eXc0MmFpazFabnE5bUNOWmFjTGlJMTk4N3ZIK3hHa2RhdEJyNjdsV1pHN3k1?=
 =?utf-8?B?a0dNMUhTUTlhMzRwZFEwU0htY01MUGtQQ0RzT2xxUTMxVHd5dm9JQlJtQnI1?=
 =?utf-8?B?Q3V3SEcvRlFIMGs3bjJiU3pJd1lyazh4UWxGRUNCaXB1NkNzc2tiSW9zWTJm?=
 =?utf-8?B?ci9tcVBkdWdnb1hrUGx1MG9NWHB2UjVUM1pwVTVad1lBcytkM0lvTDV5c253?=
 =?utf-8?B?S3FiT0ljSU9HMUdReFoxRVRMSVZOZkI5S0pvQUdxRGdpcEwxZXJtQURKYmJE?=
 =?utf-8?B?SW1iMXZhN3ZIK1o1dWVvZFBvUWdqVVJNQ2IrLzd2K09kSlNFOXRpOWxCRGVJ?=
 =?utf-8?B?eVZKdXV4Nk8rRlB5OUYzNXN4QmhGVUFoN0xFQlUwNE1ENTBjMFJ3dTl3b1Ru?=
 =?utf-8?B?Y3MzaVl3cXV4NWMrREtsSURsWkVHbStUeUtoYkxGak9WYnNZMXhVdjBSWUdp?=
 =?utf-8?B?dGVZZmZ4a2FTa2dDL0pWZVl0RkExN2h1dmpLd1Jhb1FXYUNnRHA4YUc0QmZ3?=
 =?utf-8?B?Q3IxYnIyM3YwekhsZGd1ZGdJTDAyTVdvSEdpQWNRUEdVMFF5QnRVYlNqVDZ6?=
 =?utf-8?B?OHZ5emVjN0wraUVsK1dDdFBXUXZnZjVvdjRFME96SEVNMDJkaTJLTU1OMzZl?=
 =?utf-8?B?QmtjQkF0VU13Y09EeWtTMUV6aFN4aGgvMlBTL2RYOVhzS3Q5ODFuRGRmNEc5?=
 =?utf-8?B?eEMzWDRtLzY5bjduOWZXc2lTUmdGS0dlVnJqamN3VnJMMS9PTjFSSzFaR2ZV?=
 =?utf-8?B?SVZNNXEwQ3hGc0IvSlh4OGR6Q2xJQUVKdUFxN01vQWlYeEQ4cU8rSDZnbVFw?=
 =?utf-8?B?R3NYUUtLQkVVT0RIS1lVa2c2aXRkV3RMT0xEZXJUbGdDYnN6N3VpVFRmck90?=
 =?utf-8?B?ZkRuOXBsMFpDV0xRbnZFWjduaWJNVFR2R0psTmxuT05YS2ovdGsxZVRhYnFH?=
 =?utf-8?Q?+VzoWsNIf0/uhUXih/oPfoY=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e356723-7f95-4dd4-d78a-08dd34a78891
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 14:27:11.3273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SHw6Uh7MNqnXvu6LuNRbI2z1jvC9Mjv8nXrsIKSyf98K18DucQSt738BHA9p+o72vNNMQH7OiACU1GSi4JI3pfn6bASTm7PoQpgRrWvKgsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TO1PPF55F13247B

On 2025-01-14 09:07, Mathieu Desnoyers wrote:
> On 2025-01-13 18:06, Shuah Khan wrote:
>> On 12/10/24 15:44, Raghavendra Rao Ananta wrote:
>>> Currently the rseq constructor, rseq_init(), assumes that glibc always
>>> has the support for rseq symbols (__rseq_size for instance). However,
>>> glibc supports rseq from version 2.35 onwards. As a result, for the
>>> systems that run glibc less than 2.35, the global rseq_size remains
>>> initialized to -1U. When a thread then tries to register for rseq,
>>> get_rseq_min_alloc_size() would end up returning -1U, which is
>>> incorrect. Hence, initialize rseq_size for the cases where glibc doesn't
>>> have the support for rseq symbols.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 73a4f5a704a2 ("selftests/rseq: Fix mm_cid test failure")
>>> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
>>> ---
>>
>> Applied to linux_kselftest next for Linux 6.14-rc1 after fixing the
>> commit if for Fixes tag
> 
> Hi Shuah,
> 
> I did not review nor ack this patch. I need to review it carefully
> to make sure it does not break anything else moving forward.
> 
> Please wait before merging.

I am preparing an alternative fix which keeps the selftests
code in sync with librseq.

Thanks,

Mathieu

> 
> Thanks,
> 
> Mathieu
> 
>>
>> thanks,
>> -- Shuah
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


