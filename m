Return-Path: <linux-kselftest+bounces-23318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4639F0E2F
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 15:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE7CB1619E8
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 14:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7601C1DFE34;
	Fri, 13 Dec 2024 14:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Fv2jpfth"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020084.outbound.protection.outlook.com [52.101.191.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C87338DD8;
	Fri, 13 Dec 2024 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734098485; cv=fail; b=oLXwadmW11Ko/M+9KexQOU7xAaVlrrgwEWJog1kz0DbS4gjEPiEM0FLYzM3EhkFBiYb8n0nu5nvJ0YB4bU0xgb124czmTPCGMlB19BoKFd6hUgJL5fV2NRuQE9hPrurYMJC+33R4G1HQs6zV1YrUgVKizAOpmo5ajggcjAjmbAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734098485; c=relaxed/simple;
	bh=rSpgN5mFiCUQBjnRfemAnDKGVWPEgQGCAELHkCfAEB4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gT/vH46J3sskCbQqhJwwVl0IelZJnrjY12ODRD17aKkCeOkhTTdNoCv5fd6Z1IZuFklnFMb6U5IBF24XIDRyo7N/uSLn6YIZh/Wim0s271YREE1K0JejYqU46mw9Xjgc91v2AeFjFzhcuE7iqm/lyusFzpICKwpA/Q91MXsbOnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Fv2jpfth; arc=fail smtp.client-ip=52.101.191.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iX+3NBRMUpqdPt97nH24S/o4UaWLhioJolDRC+2LuC7x+0UCzRRs6CsLi1rV6l3cbZoX5Yjio6fYvjaNQHS1k/CquYJ5aQz6NbOrl9y1USu+IAMK2YWUxg5K4s9ywlgwPwEGYSshs0Lw5C8T0mhei0IDRDMayFrWmbMBSUifclff/nfwqsk07x7vV92r+0en3liIbu1UQmBZ9Q7LBP7OZkL/QiD1nkylWt3wmr0bhTqJNFJYJiUWbwRAeVDerD9gt1WQVrgAW8Knp9Hf0SKCZsrm8mTbEP5aTl/gb/vGSkedBY3Bab7Z0TCVJSPGmphZRbZIm0cFXDIhRVPiPn8B4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lv7uisqRsu8mpO0CtN7Jwcq5uIGjBt2VN4kWeDS6PVE=;
 b=eeYOMHeMHi+jH+1QX+IpEE05cFSCRUNWxuUh6INxb8edfJvJs+8oMjoRJpTnw7Hi/+6m8EJqNKMoqXXUy99oS2Y63H8JY/MfPHHnmeERJpFCFITapehBZjOqG64FTVLshvoc4CeCcIVGsDLyX9Z2AK+jceqTRBcdPkQk/CGmkhIZpuQsw/rRfK75sUu0637sQwvM8Svamc2euCrn9t9rgFRKh5ipDxL1WaZhPo/iAVbp4yO1hON8DPIZ6Jh1M/hlKV0zoiinRQ48p1SIMQQiesFCt04kr25Mtyi5XRBiNvB6n/kDsXwye0F3Bzu0W91hOBUjD9pUK3/lThK7ksipYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lv7uisqRsu8mpO0CtN7Jwcq5uIGjBt2VN4kWeDS6PVE=;
 b=Fv2jpfthkS6qFQzEMvMEidi8e66b7hlp5fD83h5j5iIpyWbzBSMUtVcHZpX+wcgtKXlmElurNWwBYmjnSkx8tW7Ha2QQsFXXCHQ5tc/eQbGBX2GVOURAAwHlYG7kFtLerUAimnFx1R3zMGNmQJKw7sPS4oPeNt4mZd+psHQZH09EvPZ7MYCBGNQIBK28YrDvaXa3EAj+GMoOj9xTx1cazwgdrJ8VWdsmJlXXgxpprt9tOmA6DZEYQj11oexMOSFOLMxfh8M1i9b839jtri1YjSsYnuhq/JD2V7Y7q09RHRKaMLckCOF/ZDRncoutEKU7pzkjzGXMLBi4o0j26lPGuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB6023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:36::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Fri, 13 Dec
 2024 14:01:19 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%5]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 14:01:18 +0000
Message-ID: <a7775eb9-f455-401b-b3c3-c8ebc57fe8e2@efficios.com>
Date: Fri, 13 Dec 2024 09:01:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] sched: Remove mm_cid_next_scan as obsolete
To: Gabriele Monaco <gmonaco@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Mel Gorman <mgorman@suse.de>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
References: <20241213095407.271357-1-gmonaco@redhat.com>
 <20241213095407.271357-3-gmonaco@redhat.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241213095407.271357-3-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::17) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: fe78d1a1-f5b8-49e1-f139-08dd1b7e9dd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dy9kREc4ZmtpaTlxRjNBdlc5L0liV2ZFNWV0TWJyRXlzSC96blMrYkRYamNm?=
 =?utf-8?B?aEo3dzB6RStlQXlRSmJJSUFpMGJ3MlRXOXRHV1J5NlV6WWU5b2xwZk13bys4?=
 =?utf-8?B?RXlOV1lmb1M4WEk1dEYyYmkxTGlkbEJOOWJMMnpJaEpreHBQYWltcjZxM0w1?=
 =?utf-8?B?TUhqOFUxZ3lMQWI0MkhXblRPMDdrZmhGcWFkUmJncHp6U0hnTXlNL3Nva1Qx?=
 =?utf-8?B?a2NTQU5qT2ozNlQxbk95cFNIWi92bWRXMDNxT0VhTEhBR2hCK3BZQW44V0gy?=
 =?utf-8?B?OS9scVR0aUlCM3J0SitnU3JBTThrRFV1WFZlMVpnTHR4RzFmSWl3WS95Tjll?=
 =?utf-8?B?Q1ZmU3V0bmFuWTJnNXZFSVBIYWE1UG5GM2lmWFFMK1IvZEdiS25wTUszZGZs?=
 =?utf-8?B?MG91cE5uWW82MWtpWjZVUFIrbldVZ2k1ZURDdXZCNnZYbnRCMC85TDMrTTdo?=
 =?utf-8?B?aTJJVTZHSkZGSi9USlpUMWNUdHp6b1RrQ3ZYaXZOcExFdFhpZFBpTjdic0li?=
 =?utf-8?B?c0dhQUhhMU4wQTNBTzdsOUI5S2duclNWdDBLWGhBalowUy9kL0FOMHQ4YSth?=
 =?utf-8?B?UUVIUXA0dDFpajJhVXYrb1JtQUd0R05rU3l1REZRdEpSTWxBd25JY1NNaDZH?=
 =?utf-8?B?VWZOVHQ5bGxXcERyMHNFN1N1dXFtSndQYzFQRDZjMERvQ3l0N3NiY25KWVpX?=
 =?utf-8?B?VmVUbEN5M1hDYzNaWUdwc0MvZWhqRjhDd0FESVlnV3ZoZVBYYWNoVHlza0p0?=
 =?utf-8?B?NFdjZnFVTzVZS3I5WHIyNGJKSW1pWUEyYVlQZ0NXZXN6b3I5SlpJM1ZONUhl?=
 =?utf-8?B?S2p1QWczcU1MeUxQT1NEYk81MGNzL1dJbFcwYytqcmR3TEl4cE50bWFpWVAz?=
 =?utf-8?B?RW5Nam5QQW80RDNiNTVuc3lXckZ0bTZBRmlPZVNjbUdGa0c5NTNsb3lyMnhM?=
 =?utf-8?B?dkFHZlBMTlBOdTFUalhkeW9yNHZVZUJMb0huNklLeTYvTTZ4b1hENWNRM0Qr?=
 =?utf-8?B?SXZyOVhETUFYbjNKWVdKTWgvZG9jenprVjk1ZFlybXJkMlB1L08vUHRYRDZF?=
 =?utf-8?B?K0kxN3BLVTRvZFB3bFNTdEkwNS9YVzNFZ0YzM1pSMm9SdWlaUzZLbG5aSUd6?=
 =?utf-8?B?dGpzdC8yWUNPOHNjL3ZwbGZvREVEQ1BUWkNaN0c2d1VNVzdmNHpXWGNZRnNo?=
 =?utf-8?B?K3F3RHEzcXE0Qk1yWjJZb1k3MVBhMGNsRURMU3RGRWxYbVREUi9ENUFhMVZ6?=
 =?utf-8?B?TURHeVJVK0FjeUVIeVBpaWJLckRlTjYrMGF5RmlreFNlbGhyVTdjK2libWx3?=
 =?utf-8?B?UDlyZ1VxZWhkbFRFU29mVExGS0lGRW9Ib3lIV1Uxd0lFanNldjFSNGxQMGEv?=
 =?utf-8?B?SHVuUTFHeTZLQ2M3SGtGYS9ZVGpHYkwvaTdWcVIrUlREMXVvdmMvb1k3UXpa?=
 =?utf-8?B?WUkxWHI0RjBJS3BnakxqVXhMY3F1UmczRG12cmRpMXFYQldrR0JENCtGSFhh?=
 =?utf-8?B?OGhOV1JFYUtpNlZyMVI2R282L3poc052amFaSFJMK3NRZG55bW0wVGY0VHcr?=
 =?utf-8?B?VVB0TW5LRnZrYlN3NFBjZ2hHL0wzNFFaY1VpaEU5VUoycDV1aXVxU2U5RnJu?=
 =?utf-8?B?UVAwa1dhZUZyd3lMY28vcFRBU2laTkgxUytLakVLWmFsdFdQcXRZcmphWFpP?=
 =?utf-8?B?TW41KzZtMTM2L2w0cUtLWGxsVTNvT28yb3lwNUFJU0NvZ0w2NjUzL1E3WDlh?=
 =?utf-8?Q?8dT6n7qmznAcVri3fE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkNrcHcyWEdZU0ZXenlvMy9JTG90ZjhLV2tLeFRobjl2eERsVVhjOTdDNk1T?=
 =?utf-8?B?b2RzcmdmRG9PMGx2bStGV0xyRlYyTVpjaEFnMHRPYmlFS1kweWJxVkh2QTUr?=
 =?utf-8?B?TkVQRFFpbG9LNVo2RXFJSSt0QjZLTnQwcGYyenFacjM1bkpVc052MEpYOVRE?=
 =?utf-8?B?WldSOW5VU1FVTHJwd09HMk5OWXRMZEdJaTRkL3BibWErQVJJQi85elV5bzJt?=
 =?utf-8?B?MkdkRG1WTVkxbWVhSVcxaTdVcThmaHhZdkRhaDhxMm9xWHdFSkxrMFVqNmJK?=
 =?utf-8?B?dGNOSUswRFdYU3ZYTTYzcTZSM0xmM2VMbkVNTTdPZmNmMVM1SE9xbEc3aW1l?=
 =?utf-8?B?RmZlbXJXbVdnMzhCNlNjWTYrZlAyL1UwTlpLS3B1SWtYSndRaElEVEdSRDZV?=
 =?utf-8?B?VnA0WHFEcDNtZWx2T3NwaW5SRkdJRmpFWE1OalkzV0gyUC82R0NYcWhkd1N1?=
 =?utf-8?B?Y2prOVpVS1hhQmtOUXE4SEJSY0VHTE5jN0ZRY1dsbjUwU2Y5OERkMytxWnFE?=
 =?utf-8?B?bW56SkJtQ3dGYmFvSEtiWGt4SzBIUzVjQ2drMTluUnYyNncxV0tMeHNQNEI2?=
 =?utf-8?B?Qm05UUF0Z0J4a2QwcWFLTnJMSmp6OXFlSjFJcmZ5U3hNeFpxWS9yYTBZaDRQ?=
 =?utf-8?B?R254ZTJzeWhuVzVpdzJDeXBBaTB5TXNXMnBwNG9qVS8xTEZMcUJ1MVFnYkRU?=
 =?utf-8?B?eXRtV0dhOG4yWnh1SmNTRGhmUUEzdS82V3VaK1BGK0NsTG42azVrUmRsZm03?=
 =?utf-8?B?RUthRkJEV0FEYU1Fcnh1RmdTaEZBcHdkc0tQWGdVWllONy9xcmwvMzFhcXN5?=
 =?utf-8?B?anN3Y2E3VEF3VWE3VEw3Um5Gc3dpd25LMXRUS3RBVFB4YVMwMVh1N1c4cmI1?=
 =?utf-8?B?L2dMTjVHN2VtZGtvdEFpdjlObU9ScWJUZWV6ZDduU0xtdXllWk5rTmlnVmY2?=
 =?utf-8?B?ZVlKYzlGektQVFBXY1E5aUc1WnFDTW1TQWJNWDFySG9TL1RCMWRrVXJhcmk3?=
 =?utf-8?B?K2U4Vis2R1gwL0tXTFpYYjZjTXFWZUtJY3ZaM1RzY29sU0RidWNod3licmVD?=
 =?utf-8?B?b0ZaZlhndUdDSUNrT1RFK1FzZnpsOVZDQ1JnQVl1RkltN1I0czRtR2dPb1Rv?=
 =?utf-8?B?UlRmOWY3aFV0cDFTelFpNzZPcFpvOEdmZnEyQ3V6VS9iZlBSM3pBcUFoY1RI?=
 =?utf-8?B?M0FuOHE1U3YwaFJPMURidE9wajJITGdRbGYyUmdDa3l5aVo0b3hUVVpIZWJs?=
 =?utf-8?B?b2g1RmJLS1lvamFkYUkyaHdvajdta3dGeisyWG9DdUkwaEgydVVITERidW9P?=
 =?utf-8?B?M3M3M0psOXRpcXZmVGpoeTJpNkVMY01rdFdGbkx6aWpQUjJuUlpEOS82MWJy?=
 =?utf-8?B?YmM4U1BnZk4zNGZYMTJGdVlFcnBrb1FDU09vMkZkK3UydlVHbll4aFpRY0xD?=
 =?utf-8?B?QnFPTXVYSUpsR0MzdWlveFdZV2dubkErcUdlYnMxNFl3bVcwUEozYmY5L29X?=
 =?utf-8?B?aTRtZWdPZndMSlRxQWJOWHUvRklUNmtsczc5cDI5Y3ZKL2wrdmVPVUJmdUIw?=
 =?utf-8?B?bS9qRktUYmFCS2xQRk1DR1BTR3JkZEpMa2F2NkE5T3JUZ08rNmlvdFhvNG1t?=
 =?utf-8?B?dnptR3BTYnhXL1ZqSkpCNGNMbllYWk16WEJuSW1TdEd4QnBEdGNOckFmY3Br?=
 =?utf-8?B?WlYvNThJb3l3bmZFLzU0WnI2TlVGNjM5dFpONGtxU1p2Z3pxaWlZUnM4VllY?=
 =?utf-8?B?aUdlS3A2TnNUTVZlbTdZU2g2WFd0a0MwVjFNd05lQmkwZmhnTW5vNkNrbnB2?=
 =?utf-8?B?dXlnRkhLREJPT1RuUUhTN3FvNVMyb2RBODgydTM3NWV5L3RrTmx2a1BoZVVR?=
 =?utf-8?B?OXcza0p0SmozTHpaeEg4OHJSQlZIUjhyRVFnZlBHblpqUWxZM3FZZWhFSkpN?=
 =?utf-8?B?MzRHS1VSN0lJSUlTcDcraTFrMnplZ0drY1piTUwzYUcyUWhiZmkwRXVrdDFy?=
 =?utf-8?B?V3lPa1dIcmo4QWFJd1c5M0dsMkh1aW5NcjJTaFdrbnRmSEo3djh3Wm5tR2V2?=
 =?utf-8?B?dTVkZ081dFh6OVR4UmZTQXE5WkpwRVhVSkV4M3ZpRGpxSWZCNC9scjFobHk1?=
 =?utf-8?B?UkU1UU5pYXN3YkR3a1F3aS9JY2J4TWhqNVkvRFp5elhVNlZQR3M3dFBCYlZ3?=
 =?utf-8?Q?/m0DUHl4e4PPxmEF5wBQt1w=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe78d1a1-f5b8-49e1-f139-08dd1b7e9dd1
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 14:01:18.7776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYhn8+yTva3Lwz8tYYMG24KoLlB8TGLZoW/7+qcwpbvP+gVk2O5ZAoATzPzlHucEtCO0LZwI4w9/WL3AhOIDuDDyiFHfbUxYB9x/9qIlz1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB6023

On 2024-12-13 04:54, Gabriele Monaco wrote:
> The checks for the scan time in task_mm_cid_work are now superfluous
> since the task runs in a delayed_work and the minimum periodicity is
> already implied.
> 
> This patch removes those checks and the field from the mm_struct.
> 
> Additionally, we include a simple check to quickly terminate the
> function if we have no work to be done (i.e. no mm_cid is allocated).
> This is helpful for tasks that sleep for a long time, but also for
> terminated task. We are no longer following the process' state, hence
> the function continues to run after a process terminates but before its
> mm is freed.

Can you fold it in patch 1/4 ?

Thanks,

Mathieu

> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>   include/linux/mm_types.h |  7 -------
>   kernel/sched/core.c      | 19 +++----------------
>   2 files changed, 3 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 92acb827fee4..8a76a1c09234 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -829,12 +829,6 @@ struct mm_struct {
>   		 * runqueue locks.
>   		 */
>   		struct mm_cid __percpu *pcpu_cid;
> -		/*
> -		 * @mm_cid_next_scan: Next mm_cid scan (in jiffies).
> -		 *
> -		 * When the next mm_cid scan is due (in jiffies).
> -		 */
> -		unsigned long mm_cid_next_scan;
>   		/**
>   		 * @nr_cpus_allowed: Number of CPUs allowed for mm.
>   		 *
> @@ -1228,7 +1222,6 @@ static inline int mm_alloc_cid_noprof(struct mm_struct *mm, struct task_struct *
>   		return -ENOMEM;
>   	mm_init_cid(mm, p);
>   	INIT_DELAYED_WORK(&mm->mm_cid_work, task_mm_cid_work);
> -	mm->mm_cid_next_scan = jiffies + msecs_to_jiffies(MM_CID_SCAN_DELAY);
>   	schedule_delayed_work(&mm->mm_cid_work,
>   			      msecs_to_jiffies(MM_CID_SCAN_DELAY));
>   	return 0;
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e3b27b73301c..30d78fe14eff 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -10520,28 +10520,15 @@ static void sched_mm_cid_remote_clear_weight(struct mm_struct *mm, int cpu,
>   
>   void task_mm_cid_work(struct work_struct *work)
>   {
> -	unsigned long now = jiffies, old_scan, next_scan;
>   	struct cpumask *cidmask;
>   	struct delayed_work *delayed_work = container_of(work, struct delayed_work, work);
>   	struct mm_struct *mm = container_of(delayed_work, struct mm_struct, mm_cid_work);
>   	int weight, cpu;
>   
> -	old_scan = READ_ONCE(mm->mm_cid_next_scan);
> -	next_scan = now + msecs_to_jiffies(MM_CID_SCAN_DELAY);
> -	if (!old_scan) {
> -		unsigned long res;
> -
> -		res = cmpxchg(&mm->mm_cid_next_scan, old_scan, next_scan);
> -		if (res != old_scan)
> -			old_scan = res;
> -		else
> -			old_scan = next_scan;
> -	}
> -	if (time_before(now, old_scan))
> -		goto out;
> -	if (!try_cmpxchg(&mm->mm_cid_next_scan, &old_scan, next_scan))
> -		goto out;
>   	cidmask = mm_cidmask(mm);
> +	/* Nothing to clear for now */
> +	if (cpumask_empty(cidmask))
> +		goto out;
>   	/* Clear cids that were not recently used. */
>   	for_each_possible_cpu(cpu)
>   		sched_mm_cid_remote_clear_old(mm, cpu);

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


