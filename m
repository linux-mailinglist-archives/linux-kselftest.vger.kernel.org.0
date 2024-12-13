Return-Path: <linux-kselftest+bounces-23320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 932389F0EE2
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 15:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF7F188FE72
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 14:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194201E0DE4;
	Fri, 13 Dec 2024 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="YOz02sLZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020077.outbound.protection.outlook.com [52.101.191.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1D41E00B4;
	Fri, 13 Dec 2024 14:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734099261; cv=fail; b=tJea8tVCW51P2417DEfQhaGB6o2f7OVq4WkomRyNN5Hn0uaYMV8rC1oZUERMwMoRydZmk4m36G3fgukNRSTRXntWBm5qWGPt8q+tS363dsGjYrQDD2UZpg4FHAP91FUe9qDSINUV9PKsLFfM3D4rWwruDg5Wh1DOsmOPKaKBiiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734099261; c=relaxed/simple;
	bh=8QGPK4AORhc5ToA2xjd34ZeXeA3DvsXP4HqIxqbuJXg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WL96A3zFF6KA7fQ+2JgE6vI+z8ybaZX4qKYq77Rn/ppBw3mFmG7dwOLyf4E/jkxvr2ZJOM7lPQin17bJPgSHYk3160nQfQSOlakYpqX0IFQjL569G5K1FOzzrUqLp7c8Z8py8fTRhxqDbZ1FXDRmnDIczVYGmUuvWxWgNJF72HA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=YOz02sLZ; arc=fail smtp.client-ip=52.101.191.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1kXZmku1mLAIEWQK3si9hEvT92OMoNOBFLQ3irdV5YHfGV7h7+hmUG2FH3yBqxnMgmAfPPm5y9E1qlhlkfx7JgIpndoEa9pXk3JBAjeHPvPGiul2hT8bkWY+Yuma7lfzpGGMPoqF9VNL/yLjgXnGiovWQSfvoAeiGutheujryBTrUVEyg+ZfFvY6l30H0FRAsmkYY2HZQWQ4FBhrbO6D0JIAnRfz9tL5wpdx671H/IGXYelQ89/lX72AUmghFNQTKOPc+v1Dlu79ZxkfzCsw4oSA+m5REc4QzCKkh3iRWcPd7ItqKUa/+T12N6wOWNqzDRGyYu2xjIPqvMAoJCrGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duCLEeJpptsivnIj3bTO2pUkf0z09ZnhRHYKpVshLIU=;
 b=WHlOfYOXkweVTCsr7nqo9jm0KrA5K6vTwEk0WHWZU/VlgxMPWcsKLQmEI8b3IrsXQdsnlW5VGx18FZEj0jx6ablqMAiGQLnOcnGUy/97Gh33FHWlou46Jkp31Z6//srUbprz87PTYvMvpBwExTVn90Us/o46SvhoBF28tS6UM9M7rMuFC3l/BZmB4KteP/al1NWJGZdnXkrcV56K6unSR1CjlSDeFvYDDx7bRGfPn5j7dGD8vv5rn8lW9q1SykyozafLvzI1yn+cayVf2maxK7NRKyNN1AxDpcDjY8khu0+dBb21wxPKvXWY38QON+iC7tn396oHFP4UbaBnkqP3zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duCLEeJpptsivnIj3bTO2pUkf0z09ZnhRHYKpVshLIU=;
 b=YOz02sLZPDrpsYVukcMnP1wu/AFzbYK+hS3nbTb47vejI4Gnrfst7jBXpyGi0IF/kvNZM7Q8eqHbxK2cn+EQDC0HjIZZ0UM5HjICeabjXpey301uGhK+OLr6GuINUEqSHCLPnBFw13qxFsuQnt4kd8sLDGvqBEq3BPexirNdPKZuwBIKbnpKq6S0jDG0fRjpCMETECptAYNlySU+tB8fOCsV6k31jfZHDZ3LUEKozRAl9nLHhZF5scKPFvXZDvcSgk6Tkk+5GyGXNkXdP014YGnuZYGJWnFQ5Bprjst7owbw203t779pqcCWLulE3xyFn8UJ6838P5nBVUJKH5Hc9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB5666.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:66::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 14:14:15 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%5]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 14:14:15 +0000
Message-ID: <5fe473bd-600e-447a-a321-cae3d838268f@efficios.com>
Date: Fri, 13 Dec 2024 09:14:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] sched: Move task_mm_cid_work to mm delayed work
To: Gabriele Monaco <gmonaco@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Mel Gorman <mgorman@suse.de>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
References: <20241213095407.271357-1-gmonaco@redhat.com>
 <20241213095407.271357-2-gmonaco@redhat.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241213095407.271357-2-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0078.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::14) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB5666:EE_
X-MS-Office365-Filtering-Correlation-Id: aee3afe5-8bfe-4968-2d08-08dd1b806d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajlPN0VOajdYV3ZlUDZvMFV4UHdLc2c5dERrNWFXeUtISlpiQ0dPWXFxbHBi?=
 =?utf-8?B?UEZJNVZpU2tVYkFlQUQ4R29sRi9nNmNEZldyR0tjOGt5YlA5NnlibUlSTmE2?=
 =?utf-8?B?Z3BQdCtsYWZ6TUUxSzROVGxvekVjQVdWVnlVVFk5Nk1vKzdYcG1zWDVpQWlm?=
 =?utf-8?B?N0RuMGNaa0NxUzhHRnRvaHdmamtoeWoxSHNlTVFVM25iSHZ6VitsTUxRRy9Z?=
 =?utf-8?B?T0NTRHNXUG9DME9lbGtaVlRrdUxleXpEbHAvSXhKamJtSzRSNDZVRm9jSWF2?=
 =?utf-8?B?TjZVck93MTR4aXlKb21CdDlnczhmV05HTEZYcWY2QVllMkZTWGFzZkRSTllq?=
 =?utf-8?B?cWo4UkhIT0VJWktTalRHMGp2VVZPTitVeXRBa01zaEhjOXlVcTFWOUpQMEg0?=
 =?utf-8?B?R09nVmRKaTI0azZ2bk41ZnBJQkZjdDFTSHIvWFhTa0VJcjQ1ZG9kNVVlZ3dG?=
 =?utf-8?B?c0N5cUJucEVydExtQW1zN1pqVk5zcklrbmJMS0ozb3VOeis4Y2FvVUZ2dStO?=
 =?utf-8?B?OUlUa0tQQ016bDV1QUF5alM4YmhnTjBQWVIrSWpjNTNyL2F3NzdhTGtzMnNu?=
 =?utf-8?B?R2RsOVJtK0Jmb3V3Uk1ncVRrQ3RRRjFWU0xQQk9kSXhDMlVQcDlGN21FUVB1?=
 =?utf-8?B?eU41dkZ6aUUySEtkY0NMTVdIRDRNLzAzMzQ0RDVCVTFLZ1FJYVdody9uRkZk?=
 =?utf-8?B?VVhjc0VrQXhoRGpLbW8ySUdpT1lUT20yK0JJcHpyVEhEZGJtVWRXSzBTZTcr?=
 =?utf-8?B?MUdyTm5RQWlYTHArTkZTeVRZR0oxajlwdDB0bGx2VFdaY1RPa2k4QTVIUVV4?=
 =?utf-8?B?WXZ2RmJqemc4N0tSN0dwSVVxUzZjOEFWMHFweVBhUHRVN2FBbzU3bmg0c296?=
 =?utf-8?B?anRoZ3hWNkdVdERXOUUzQnF5TnAyeWF2ajVnZG4ralZ3SUFCazcrek1TanVC?=
 =?utf-8?B?ZjNhSk9lYUZKZE9QVFgzZlJ4b2lleXdyOVd0MG82TitNNDF3YVZWOE1LWExL?=
 =?utf-8?B?WFJ4ZEpsV0RsbFQxdEdLMDZUcTA2SmdZdjNGN3N5WTZYMTluL2Y3cko5NC9s?=
 =?utf-8?B?MWdkdG0wZCtSMHd5OEk2SjVnQXEyYmdjVHQ2bldQLzlJSHQvR0IzK3oyTU1H?=
 =?utf-8?B?MnNaSkRLVnZ0QUxTYmJrTllKaVdOV05DUjZOcFFKZmY2aEpOckhqbTQvYU9q?=
 =?utf-8?B?Qlpub0thbkUzaHI1d25velc4WFk3dG1ZY01FYVdjK0R1LzBnOFlJck1sbG41?=
 =?utf-8?B?Y2VSY0ppOVdCSFRUZWJya0NkRXVnOWJzVUhMcS90ckx6SUc5dDRFbUxUQUtE?=
 =?utf-8?B?VzJlbXVqcTdvOHBWcFJVUGl5U0w3ZVNSMUxvZStVOUpid09SMnhVL3lPNGJm?=
 =?utf-8?B?RXZQRzhsdkhrYmdHQ2xEdS8rLzM5UUF0RXo2WEpjblZobVdhL3hTc3FBU0hj?=
 =?utf-8?B?S2dFNmxKUndKVVFPNDNCdGUxVlpzY1hYWDc4OTZFby94cXNnSk1CVUtZa0tK?=
 =?utf-8?B?Zkt4YzJpTUNlRTFobkRkeFdmaGlCUHV2SHNRTXVxNm1EZlRLNVNaVHdHdjRh?=
 =?utf-8?B?L2FSeWdHcGdHRUcxQVJrYVBDOVF5U3ZJUGRuTWhzSWllbk1kclZEaUVzS2hj?=
 =?utf-8?B?aGRUSXdPTGZJVTg3bTVlRTVEUVR0QTN2bCtObWhCcGVqNldianR5MXZPTFJm?=
 =?utf-8?B?ZVRlUWVoY2ZiSCtwcWhNNEY5YkNUdzh6TFZ5ai9oTkZLUElPOFRrRnVwUFRN?=
 =?utf-8?Q?dTb6J3RkTz6Bxu6ulw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VU9ZbXVYNmxBeDlQTWhFcFdsZW5Jc285OTRTdUo3bjAzdWFEbUMxakhXSm5h?=
 =?utf-8?B?RjhJZjFyV0RPYzBVcFd1ME5KeGNqdVhKNm5oeUJod1I0STJ1V0IwRmxFM2RF?=
 =?utf-8?B?V1VLOEV4dHY5QXpScU8zWnpkbWVHM0ZORllFL3AwTFFkcDZuK1hJSmI4US9u?=
 =?utf-8?B?dFVBZkk3NEFQOXMrQmZzQ3dBYzRnQkdhT2hNSW9iV3Mwckp3MUdYenVyOWlX?=
 =?utf-8?B?UTc2bnZkWS92eTVydTVKK29kQmpqZ0krQXlvTWFNdmhLc0xWN0xVb2lBL09i?=
 =?utf-8?B?YnRjL3pTZ3ZGbmFxSXpXYmVSbXBlNjB2NkpsM0F1T1lJNVdJZjBRUW1OWHVn?=
 =?utf-8?B?K2N3bWhIcFVrc1Bnb2ROVXVLYlE1cFJhRDY0QUMvb2tJbC95c3dpQ2JlSzlu?=
 =?utf-8?B?Nk8vd2ZwcHArNXdWaDNuUm1xVC9HM2VQdkdWTlhxZ3lZSVZUNVU4SW1SWGdX?=
 =?utf-8?B?N2RTTUJWa3REQ0l0UmRsMTV1YUpxOEs2OTh5b1VmVm42ZWI2V3JybDF1Lzdx?=
 =?utf-8?B?UDJWSWt3MHdGNWZqeGl0TUNjZE04Mm8xZWMremltaDJDalpOMEoyNVhSNUYx?=
 =?utf-8?B?cGUyN1hvL1dsN1VxcmswMjY3RnhwMlVxZkJmYWJqQWxDZ0R5Y0N0cHJlVGw3?=
 =?utf-8?B?MUdzSXQ5VytMMUlFRWM0R0E4NEN3Y2xxQXgrSDlRS2lQeWFJWjM1QnVYVFBt?=
 =?utf-8?B?Zk1NVGRBeDl3b1hZSzFxOTIzVEFWUERXbzNsYnVSRytrRjZGTTgxUVNhU3hR?=
 =?utf-8?B?ZWQ4YUxHbGVPYmVkN1NaN1U5c2JiK0hXK3Y5WnVNcWFGMGNuU25KN2tpY1Rs?=
 =?utf-8?B?RmxjMVZkSDZoUExIWm9iMnk5ZnI2MWljSVVrdFlFVHJHcnBJL2xpZi85YmN0?=
 =?utf-8?B?K3dHNENIUEcxOEJWTnZiWG9UdUt2NWJ2elJlOUtuNkRkSHY0TERXN3Vrc1ZF?=
 =?utf-8?B?TmRCRkJ4S2dMVDF2TW1kbkJUd0YzcnBiRUN6Tml1dGpRU2VuNnV0TC9PK3Zz?=
 =?utf-8?B?cnIrVEZoclQxRWxiMEVzTXV6VzFhdmNNMW1nM2NHbWJReUdaUTFIc3A2Ty9G?=
 =?utf-8?B?R0ZUTXdrSkRtTEZMZzlka25WNUxYNHl5UHprcXJIQ3I4WGR0NWRGN05vbDhD?=
 =?utf-8?B?dVQ0UUQ4S09VbGZ6NzZBT3F1YmlpWUFuZFBLWUJzSldlYnkwNmcxZmFMdlhm?=
 =?utf-8?B?cWNyYjd4NE1lT1lUZmg5QmhSNEtmeWNvb0N0VUt3VzB2OHdwODFDUUVVbGNO?=
 =?utf-8?B?R0hPT0I3ZnhwdTJ5VWVLZyt1d052dnpUWjNQeDlZUVkvQmtUUGMrRzE0Q2Zv?=
 =?utf-8?B?cmNEeXYvaUZRSkpyZFIvRU56TmdZV2drUWVIcmtsdVJPNktiMWhCRUpDd1I1?=
 =?utf-8?B?MEVoN28xNjZXVEFDcjRVdnhVYUFCNWo3NHdFbWdRWVhsL0hOTjJ6WElFMkZm?=
 =?utf-8?B?eHY0Tk9ianFScmN4VnhJQnAwTHJTVS94dlRhTUhiSnJUOHYvaW1MZ3R3bzNz?=
 =?utf-8?B?cWR6NHY1NFhHblZIL0tLclNpZFIxaVpGRGpuMUp5V3g0NWcrZjFqUVdkR05Q?=
 =?utf-8?B?T09GSTRkekpwZ2tTVSs5MUw1RGg3OFJtcXoxVVJ3RzkveEFqbWpVUEh4T2lM?=
 =?utf-8?B?QjY5UmRabVcrMUd2MmNFcFJHSC9VcXhlcFhtenVTQUlXYVc3UG5sa09FamJk?=
 =?utf-8?B?UjgwUElQaDRMS3pQZHhVaUoyYVlWTU9ReE53YkRqZzVOVFpOb0VqdkY0R2k4?=
 =?utf-8?B?akJjU2Z4dk1abHFKUVFjdEIwVVdEcDhwOXBjcG83bTBwN0plQzEzZUgzUGll?=
 =?utf-8?B?cmoyUm1mSzZTVVFjYmJCbEdwTWg2R0xVMUtQMWNHSTJOdkN2YlZoUFdhVTB1?=
 =?utf-8?B?WmRMWUt3NTEyZHNzQ3ZQdmJnZklaaVA2a0dKNUora3J3YWxiaGpWeTQ3Q0xw?=
 =?utf-8?B?NnY5YjViZ1pmUEdPRWFYNnV0MnZLUmFPd25ybWdDS3dWaE12d01zUGR5THhX?=
 =?utf-8?B?WFY2Q2plMDRFQ3R1MVlPVkNpNHI0cTErN08yMUZJd2VIcDljcWlKTHBIenNJ?=
 =?utf-8?B?S2hzY05NTHkvZ2dDNE44aldNaXFRRG9xbTJ6ZVdQTGhQdkxKNzRxUjJUd2NJ?=
 =?utf-8?B?b3ZFTTh2TmJVajZCMW5xZ3IwT1hwRDQrMTZEVHBxcjlPanFhcUx3YzRuamJ4?=
 =?utf-8?Q?29Dm5Zv1880CqfhJa78r2gs=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aee3afe5-8bfe-4968-2d08-08dd1b806d20
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 14:14:15.8185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OEnDW2HYVC8HoNvw8HtsZp2TnVVp6qpidClNKPCKSaX8LMi4FKB25kGIuFJ+bGOfIZbckfFYr9eKo2DZo5Umg4F392K/RFx3AngA0ytsKfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5666

On 2024-12-13 04:54, Gabriele Monaco wrote:
> Currently, the task_mm_cid_work function is called in a task work
> triggered by a scheduler tick. This can delay the execution of the task
> for the entire duration of the function, negatively affecting the
> response of real time tasks.
> 
> This patch runs the task_mm_cid_work in a new delayed work connected to
> the mm_struct rather than in the task context before returning to
> userspace.
> 
> This delayed work is initialised while allocating the mm and disabled
> before freeing it, its execution is no longer triggered by scheduler
> ticks but run periodically based on the defined MM_CID_SCAN_DELAY.
> 
> The main advantage of this change is that the function can be offloaded
> to a different CPU and even preempted by RT tasks.
> 
> Moreover, this new behaviour could be more predictable in some
> situations since the delayed work is always scheduled with the same
> periodicity for each mm.

This last paragraph could be clarified. AFAIR, the problem with
the preexisting approach based on the scheduler tick is with a mm
consisting of a set of periodic threads, where none happen to run
while the scheduler tick is running.

This would skip mm_cid compaction. So it's not a bug per se, because
the mm_cid allocation will just be slightly less compact than it should
be in that case.

The underlying question here is whether eventual convergence of mm_cid
towards 0 when the number of threads or the allowed CPU mask are reduced
in a mm should be guaranteed or only best effort.

If best effort, then this corner-case is not worthy of a "Fix" tag.
Otherwise, we should identify which commit it fixes and introduce a
"Fix" tag.

Thanks,

Mathieu


> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>   include/linux/mm_types.h | 11 +++++++++
>   include/linux/sched.h    |  1 -
>   kernel/sched/core.c      | 51 ++++++----------------------------------
>   kernel/sched/sched.h     |  7 ------
>   4 files changed, 18 insertions(+), 52 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 7361a8f3ab68..92acb827fee4 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -856,6 +856,7 @@ struct mm_struct {
>   		 * mm nr_cpus_allowed updates.
>   		 */
>   		raw_spinlock_t cpus_allowed_lock;
> +		struct delayed_work mm_cid_work;
>   #endif
>   #ifdef CONFIG_MMU
>   		atomic_long_t pgtables_bytes;	/* size of all page tables */
> @@ -1144,11 +1145,16 @@ static inline void vma_iter_init(struct vma_iterator *vmi,
>   
>   #ifdef CONFIG_SCHED_MM_CID
>   
> +#define SCHED_MM_CID_PERIOD_NS	(100ULL * 1000000)	/* 100ms */
> +#define MM_CID_SCAN_DELAY	100			/* 100ms */
> +
>   enum mm_cid_state {
>   	MM_CID_UNSET = -1U,		/* Unset state has lazy_put flag set. */
>   	MM_CID_LAZY_PUT = (1U << 31),
>   };
>   
> +extern void task_mm_cid_work(struct work_struct *work);
> +
>   static inline bool mm_cid_is_unset(int cid)
>   {
>   	return cid == MM_CID_UNSET;
> @@ -1221,12 +1227,17 @@ static inline int mm_alloc_cid_noprof(struct mm_struct *mm, struct task_struct *
>   	if (!mm->pcpu_cid)
>   		return -ENOMEM;
>   	mm_init_cid(mm, p);
> +	INIT_DELAYED_WORK(&mm->mm_cid_work, task_mm_cid_work);
> +	mm->mm_cid_next_scan = jiffies + msecs_to_jiffies(MM_CID_SCAN_DELAY);
> +	schedule_delayed_work(&mm->mm_cid_work,
> +			      msecs_to_jiffies(MM_CID_SCAN_DELAY));
>   	return 0;
>   }
>   #define mm_alloc_cid(...)	alloc_hooks(mm_alloc_cid_noprof(__VA_ARGS__))
>   
>   static inline void mm_destroy_cid(struct mm_struct *mm)
>   {
> +	disable_delayed_work_sync(&mm->mm_cid_work);
>   	free_percpu(mm->pcpu_cid);
>   	mm->pcpu_cid = NULL;
>   }
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index d380bffee2ef..5d141c310917 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1374,7 +1374,6 @@ struct task_struct {
>   	int				last_mm_cid;	/* Most recent cid in mm */
>   	int				migrate_from_cpu;
>   	int				mm_cid_active;	/* Whether cid bitmap is active */
> -	struct callback_head		cid_work;
>   #endif
>   
>   	struct tlbflush_unmap_batch	tlb_ubc;
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index c6d8232ad9ee..e3b27b73301c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4516,7 +4516,6 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
>   	p->wake_entry.u_flags = CSD_TYPE_TTWU;
>   	p->migration_pending = NULL;
>   #endif
> -	init_sched_mm_cid(p);
>   }
>   
>   DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
> @@ -5654,7 +5653,6 @@ void sched_tick(void)
>   		resched_latency = cpu_resched_latency(rq);
>   	calc_global_load_tick(rq);
>   	sched_core_tick(rq);
> -	task_tick_mm_cid(rq, donor);
>   	scx_tick(rq);
>   
>   	rq_unlock(rq, &rf);
> @@ -10520,22 +10518,14 @@ static void sched_mm_cid_remote_clear_weight(struct mm_struct *mm, int cpu,
>   	sched_mm_cid_remote_clear(mm, pcpu_cid, cpu);
>   }
>   
> -static void task_mm_cid_work(struct callback_head *work)
> +void task_mm_cid_work(struct work_struct *work)
>   {
>   	unsigned long now = jiffies, old_scan, next_scan;
> -	struct task_struct *t = current;
>   	struct cpumask *cidmask;
> -	struct mm_struct *mm;
> +	struct delayed_work *delayed_work = container_of(work, struct delayed_work, work);
> +	struct mm_struct *mm = container_of(delayed_work, struct mm_struct, mm_cid_work);
>   	int weight, cpu;
>   
> -	SCHED_WARN_ON(t != container_of(work, struct task_struct, cid_work));
> -
> -	work->next = work;	/* Prevent double-add */
> -	if (t->flags & PF_EXITING)
> -		return;
> -	mm = t->mm;
> -	if (!mm)
> -		return;
>   	old_scan = READ_ONCE(mm->mm_cid_next_scan);
>   	next_scan = now + msecs_to_jiffies(MM_CID_SCAN_DELAY);
>   	if (!old_scan) {
> @@ -10548,9 +10538,9 @@ static void task_mm_cid_work(struct callback_head *work)
>   			old_scan = next_scan;
>   	}
>   	if (time_before(now, old_scan))
> -		return;
> +		goto out;
>   	if (!try_cmpxchg(&mm->mm_cid_next_scan, &old_scan, next_scan))
> -		return;
> +		goto out;
>   	cidmask = mm_cidmask(mm);
>   	/* Clear cids that were not recently used. */
>   	for_each_possible_cpu(cpu)
> @@ -10562,35 +10552,8 @@ static void task_mm_cid_work(struct callback_head *work)
>   	 */
>   	for_each_possible_cpu(cpu)
>   		sched_mm_cid_remote_clear_weight(mm, cpu, weight);
> -}
> -
> -void init_sched_mm_cid(struct task_struct *t)
> -{
> -	struct mm_struct *mm = t->mm;
> -	int mm_users = 0;
> -
> -	if (mm) {
> -		mm_users = atomic_read(&mm->mm_users);
> -		if (mm_users == 1)
> -			mm->mm_cid_next_scan = jiffies + msecs_to_jiffies(MM_CID_SCAN_DELAY);
> -	}
> -	t->cid_work.next = &t->cid_work;	/* Protect against double add */
> -	init_task_work(&t->cid_work, task_mm_cid_work);
> -}
> -
> -void task_tick_mm_cid(struct rq *rq, struct task_struct *curr)
> -{
> -	struct callback_head *work = &curr->cid_work;
> -	unsigned long now = jiffies;
> -
> -	if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) ||
> -	    work->next != work)
> -		return;
> -	if (time_before(now, READ_ONCE(curr->mm->mm_cid_next_scan)))
> -		return;
> -
> -	/* No page allocation under rq lock */
> -	task_work_add(curr, work, TWA_RESUME | TWAF_NO_ALLOC);
> +out:
> +	schedule_delayed_work(delayed_work, msecs_to_jiffies(MM_CID_SCAN_DELAY));
>   }
>   
>   void sched_mm_cid_exit_signals(struct task_struct *t)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 76f5f53a645f..21be461ff913 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3581,16 +3581,11 @@ extern void sched_dynamic_update(int mode);
>   
>   #ifdef CONFIG_SCHED_MM_CID
>   
> -#define SCHED_MM_CID_PERIOD_NS	(100ULL * 1000000)	/* 100ms */
> -#define MM_CID_SCAN_DELAY	100			/* 100ms */
> -
>   extern raw_spinlock_t cid_lock;
>   extern int use_cid_lock;
>   
>   extern void sched_mm_cid_migrate_from(struct task_struct *t);
>   extern void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t);
> -extern void task_tick_mm_cid(struct rq *rq, struct task_struct *curr);
> -extern void init_sched_mm_cid(struct task_struct *t);
>   
>   static inline void __mm_cid_put(struct mm_struct *mm, int cid)
>   {
> @@ -3839,8 +3834,6 @@ static inline void switch_mm_cid(struct rq *rq,
>   static inline void switch_mm_cid(struct rq *rq, struct task_struct *prev, struct task_struct *next) { }
>   static inline void sched_mm_cid_migrate_from(struct task_struct *t) { }
>   static inline void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t) { }
> -static inline void task_tick_mm_cid(struct rq *rq, struct task_struct *curr) { }
> -static inline void init_sched_mm_cid(struct task_struct *t) { }
>   #endif /* !CONFIG_SCHED_MM_CID */
>   
>   extern u64 avg_vruntime(struct cfs_rq *cfs_rq);

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


