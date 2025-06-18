Return-Path: <linux-kselftest+bounces-35292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F03F8ADEEA2
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 15:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F246188A586
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 13:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968D22EA737;
	Wed, 18 Jun 2025 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="I3f4G6zt";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="I3f4G6zt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010024.outbound.protection.outlook.com [52.101.69.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7141DE4E5;
	Wed, 18 Jun 2025 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.24
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750255145; cv=fail; b=VM2laTHTcn5kGJbbAlWHkdnAJ7N2uSU/umLZEeE4u04b4ikuZIUbJ3V+Fwe442GXZlfnCqpKTZnMuJHPMmCyo6/WJP/n+JYEPu/HQofsUOz32qxSfv8N3WpCKXM+Kw8PrFV7IkU0ThTosEGfTghtfnd0CDWZxfHtlb2+UocvRJU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750255145; c=relaxed/simple;
	bh=xHtxehAwvWGseJSE442llhYN7eNrrnDlZXgPZk2twyU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gx+dWXruz/spXL24S5DCUOFjHW0CjRTFF0oCFMusvDzVDthpKe8wwnObhuxYa9UW8ZHlhDqEUJ61g1/ToKDTxxwQcCgl+listhraHhIgjqkMJqmoMMkAvMVhwbEHkrNYYply9jBnVlL1uJs+EkDW1foWHTqVQAaguWl//oZckQA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=I3f4G6zt; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=I3f4G6zt; arc=fail smtp.client-ip=52.101.69.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=oVVtJXas8vWEHTcnt94/T686UBOEqkXMlJzACOSQQg2lDIGDbObMv7LTa1EQofSZYxBrNdBh/S4NOqqo9S8r/IkcAdcmpyQtCc8AYqomGpXMsv6OPseuTCjoxApExQ92t9czku0M6eveLw3UYtcchT5I5CygGgXPBEbnIy4qj2a6NcC0wUcAfT/8OOENftyP40ffN4mzmjsp5DejIz3SS5SnvV0ngwRAjt74HL/Z4rhxJtnakVPPquawBhavzRWvY12zF2QZYX+eo9NWW0NHUEDA81i28i+8NeORpdnrOg0SpZgm+rBGachHKtq5YjOjE0XJww4vjp/gfM7N3UPVag==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHtxehAwvWGseJSE442llhYN7eNrrnDlZXgPZk2twyU=;
 b=X5fjNIOhwdguCbNvXBjus35Kl3fqNPu8ZS+9cLcIyDHi73+AtgO9V5kgNoC1FL7r1dUtgqXP7GlZGU4+olCzo5GJ9h5u++TloIepoP0bX3ZCgRLehSpai6uf5cZyBT60fv0OQZ0i0N3oFFzz19dbrG0PY4FdLTx/nNHha75nYDFEn4CyHyTEeIuFdkvqkSBSOv3t+abMiYzH7OUq8qAA3Au/zO6NAKYxV0uHoybGJpG5FM97TJjRqDxW4/2oxbHQBjIBTC+v4zeEKlrkXQXXDkTMft3J9AypFh2FBmwfOG070HqGdp+rH2oF+LDPJZrHjvrLw6gH41g/1k2svFOVUA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oracle.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHtxehAwvWGseJSE442llhYN7eNrrnDlZXgPZk2twyU=;
 b=I3f4G6ztEhPKUZo55zJCVGG6yGT64quXglA8LkqbKZdkG6qLZROvRCGD3ci6leS1E9h/3/KdOg0Y39aOAqQgdLFpCz/Wsc7+EyEFqEdayDuXltFgv00/A/8DA5pAwE8JRxcShIYw0RjtCAo2Fp5LBhFAjMx1xWrgU0eShYdCpHY=
Received: from AS4PR10CA0012.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5dc::15)
 by DB9PR08MB9489.eurprd08.prod.outlook.com (2603:10a6:10:458::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 13:58:58 +0000
Received: from AM3PEPF0000A79C.eurprd04.prod.outlook.com
 (2603:10a6:20b:5dc:cafe::b4) by AS4PR10CA0012.outlook.office365.com
 (2603:10a6:20b:5dc::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.33 via Frontend Transport; Wed,
 18 Jun 2025 13:58:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A79C.mail.protection.outlook.com (10.167.16.107) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.21
 via Frontend Transport; Wed, 18 Jun 2025 13:58:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igUtQl1nZjd2707hMoq3EZSd0KN6BjPXmDNkB2c+VSeJSIObmH+ndlTngTdeujC7NOek1grBDIoKPX7zC0ElT+BzssvlrYKfl5KvtGsbQshwHk0nK0KsPh5odcF2rCkNcGE3RKL6J18aua7VYLG0c2VMLiX2EhPWQo3tKPFC2qhvh6R1tYQ43pA8r4XYB6FsIUtJqIZ8SLAWlxLT3IfgK6SH6FM2/hKaIhIz3+Wej7eXzDo5756ovg/aS4qO9jRNlFbyuloqaegQcQkYfre8QtvqNb677TzfOreO8CjQN0lEoREd6OwJTO1JdhBUQYWpEcbEiYxQ3kmJqK4hOY0Akg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHtxehAwvWGseJSE442llhYN7eNrrnDlZXgPZk2twyU=;
 b=yvO+Mh/fuxRokxoz4GiDLw5sk6TQWuRQPTFpJBKkU5gRrowEmrT4b4Jj4zU09FwYF8g8ixWGsdEmRTnnWCCJxxHMXXn2fKfICrd9u9vjWFfW3NVAaxKZuxZx2yw4ntq54iMsGHnIH/QL3deWzDHo3EoN8QrvXsDEUNWWlASLM7zX+F6vSBJijcSd5WCTDh5IPXFLcpgmNHLedB4TzeUwCgjgaEbWmgWQvgJ2gM5+tBiXreeY5QeMTJJTKVKOgpWEJegpVqJnN/k3w+SBFeUSnydAaTbFcVLzoUyhdTi8vuZRLFAvOa4WGwWthsnDVsKAhJ8/uCSVAvB/OA7BlSh2Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHtxehAwvWGseJSE442llhYN7eNrrnDlZXgPZk2twyU=;
 b=I3f4G6ztEhPKUZo55zJCVGG6yGT64quXglA8LkqbKZdkG6qLZROvRCGD3ci6leS1E9h/3/KdOg0Y39aOAqQgdLFpCz/Wsc7+EyEFqEdayDuXltFgv00/A/8DA5pAwE8JRxcShIYw0RjtCAo2Fp5LBhFAjMx1xWrgU0eShYdCpHY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DU0PR08MB10360.eurprd08.prod.outlook.com (2603:10a6:10:417::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 18 Jun
 2025 13:58:24 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%4]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 13:58:24 +0000
Message-ID: <fc5c8193-2642-49f7-9f2a-00ad33353773@arm.com>
Date: Wed, 18 Jun 2025 19:28:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] mm/selftests: Fix virtual_address_range test issues.
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org,
 Liam.Howlett@oracle.com, shuah@kernel.org, pfalcato@suse.de,
 david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, donettom@linux.ibm.com, ritesh.list@gmail.com
References: <20250616160632.35250-1-aboorvad@linux.ibm.com>
 <20250616160632.35250-2-aboorvad@linux.ibm.com>
 <0665a8d3-7094-4732-9518-01ac313959e1@arm.com>
 <159f6939-e7c8-492c-8195-b7e8787a08f1@lucifer.local>
 <f8730d2d-41bf-407a-b44b-6cb9c1e5d4b3@arm.com>
 <79bdd993-0e9c-4d7d-b42c-4b5750eff140@lucifer.local>
 <aaddfd0b-216e-48fe-b48f-35c78eabcf9a@arm.com>
 <8e23c5d3-6ce3-4fe8-b6fe-69658d5d0727@lucifer.local>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <8e23c5d3-6ce3-4fe8-b6fe-69658d5d0727@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0167.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::15) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DU0PR08MB10360:EE_|AM3PEPF0000A79C:EE_|DB9PR08MB9489:EE_
X-MS-Office365-Filtering-Correlation-Id: 844d1206-f691-474b-a496-08ddae70451a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?QnNWbFNpWk53SDJrSG9WaSs0cGZOUXhrVlJZRDB6eDYyRGJPeTVLaXBTcFJM?=
 =?utf-8?B?NUVnSCtBaXBieEhQdGZhNHZyM1ZmRUIrbWVhTjhyS2FFTEpkRGdxY2htUU4z?=
 =?utf-8?B?VUU5WWRFN1hQT0lPamg3NW5RWDRnNlFjWEZKbWhrUmt5SnNsc2FDdDVNaW5i?=
 =?utf-8?B?K2VoWGJRN2RpUFdURE5oa1pObHlVS0wxSi83a1EyQmpYT1I1S2dJK1IwdnZm?=
 =?utf-8?B?TXB2RzNhNDlJeFR4L2NDaUpPOHByNkQweHBUOStEWkI3SmpURGFNYTFiYTdh?=
 =?utf-8?B?Vkt1czRtajEwMVExV01MS0puTkx2eHZETXVyaysrK3ZOYUNGd1NqYjVIWDhy?=
 =?utf-8?B?cUU1SkN2ZEVjRGs3N0s1cW03NGZJaTlaWU42QnlLOVlLQ1l6TjBkVjhneEow?=
 =?utf-8?B?S2Q3TzNDc3BCWkJzWG02dHFhUElmOTE1ZjRnTXI1YWkvL0Myb2VZOEpVaWFp?=
 =?utf-8?B?SmpJOWNiV3A3WFdQRjZRYmFtNlA0clBBdTJWWDVJcFpmb2JibUVvanB1disr?=
 =?utf-8?B?T1lEdkgyWm9Ucnl6Um9XY3R2SGozVE81UnFQbGFRd1YyV1htdEdTT00ra2FM?=
 =?utf-8?B?c1RmeHJUdW9SbWowSTFiOHNacGt6ZDd3ZXdlTkYwTnQ4WlhaNThBa3NrekhK?=
 =?utf-8?B?T0lBSE55UEtOUzRSN3hPbEZsU3RFZkdmT1VBWE9zY0lEeEV1TGZlc3Y5cm1E?=
 =?utf-8?B?TldDMFR5cStqTjZxbFFjMFB2VHh3MUMyV0ljUUhoK1JqaUN5ankwSTYwd1BT?=
 =?utf-8?B?bjZSSkVqWSs4c25SKzRRRnJhSEc1S0xoUnluangraFkyNDcyVHREYmFzUEc5?=
 =?utf-8?B?RjFUWmY2N3ZJRTJ3M1hJeDczdGRCaEVINnRUOXN2aE91RHhRUy8xOWRxT2Fi?=
 =?utf-8?B?RDdXSHEzVWdCOGxvR1Z5MGVsVTN5Mk1PME9NcVR3blZhK3pCR2hKbXpUUFlh?=
 =?utf-8?B?MGNwKzZyTDJSYmdwT1hwenJGcDV6YmNsaW53VGlMZmp1ZENLMlFoUy9iNE8v?=
 =?utf-8?B?RFU1SUZBeUg1WkJQY0Y3NDJkK3dWUDFTaVlMZzRxTFk1TUxZT3l4UDNSZk9u?=
 =?utf-8?B?TUYvejlvZkdTWmYxRHVjT2tiT3J1SUdxZVo5dk05U0NiZGhrK2RCeEYwOWto?=
 =?utf-8?B?Mmw1UnNhcTNBQUR6ak5rM2dnSVJQUWw4RThxdDgwSFl1L08zVERvMGt2ZW12?=
 =?utf-8?B?WTZhS0g1RTVtcllyckh0TUxSUEVQVUhoWWs5eCtMWjRPdEY5dUVyM1Y3SjRX?=
 =?utf-8?B?Q1JmUGVJYWpzTU8zcFZKMkxRRXNVRE92RU9Ka0dIQkxHK3lFVmFpRlpIQ3dn?=
 =?utf-8?B?UDlhaTBlSGdqZGRmQjBmNnhzS3BPUVlQanJiRWI4RitESWYxZ1FSbDNiQXV4?=
 =?utf-8?B?ZkcrbGRubDFYZTBLNEFZK2Qrc1pIMzgxMFQ3a3U5eWhZaFlUejNTU2lzWVdv?=
 =?utf-8?B?WFFyMnRISy9TR3RRVE83T0EwdTJPVFlsbnR2SWhBZ0lNditYUEowcEVZR2g1?=
 =?utf-8?B?U0J5TmJaLzQwaHJ2ZThhN0kwV0RybXFiNWdGTW01ckRqRkw1T2l5Vkk5NXZG?=
 =?utf-8?B?NVZVcjRXYmRjM0Erakg1ZXB0QTMxRVZNNTNmekYxb2NaMk12QWVJQXlzamM5?=
 =?utf-8?B?UUFLR0didXpOUk15L1JTYWhHZG80em83UXJseGxKKzlpbEpGTk42K01vMWIv?=
 =?utf-8?B?NnlWZmVrbS9GZk9aTUZxdW9TcG1WNnVTditHVHBEZDRSbGN2eXd4UmJCZkJ0?=
 =?utf-8?B?WG5IMWdqWEJ2bEZMcjBxNGIvNDFLZlRVTFhFT0FSOVhBcE5qUmpqRXl6bDdX?=
 =?utf-8?B?SHZBdXlLLzBmRWFHTGJpSEUyKzE0VkVmUkVZL2NYWHpOdURzeDA1VVFvbU51?=
 =?utf-8?B?UFBFam05QmE4SmNIbE9zT2NQdEJLN1doRzVOTGlpRG1zME9DdjdqNlBJcEUz?=
 =?utf-8?Q?qPZy3CkoL3s=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB10360
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A79C.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5a4f08f3-23cb-4725-9245-08ddae7030e8
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|14060799003|82310400026|7416014|35042699022|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVFTSk9pekdEMXFtbVdQMCsrNVpzamJqTUJNdGJ0SUxwK1dTNDFaYUN3ODIr?=
 =?utf-8?B?ZGU3Q2dabG1NbTdwa0xFcEVTVVFlblROQXU4NXkrc2hPRGFWVi9FQkZSblRa?=
 =?utf-8?B?U3AyM21RODRCOENvd3VnWWtXV29naDNDeXFxSUdkTXkydmpWSlV3MG9qNlhE?=
 =?utf-8?B?WHJxYUI0bVdLb1FoekZMZlBtaXlidldOVGFoTmZJSnNFZ2JvcUtxTlBkaDVB?=
 =?utf-8?B?UG8yWU93Nys1SjM1TnZERkpwSXlaR093TnNSeVhVck0wbytDYjVua3JHb0FO?=
 =?utf-8?B?TlBFVUN0NWVyLzNHZThsbXJxRHl4ZEF6L3dkZUhoSDl5b0FjY1VMSnhURXZw?=
 =?utf-8?B?MnBqMzduZmt3UnJvOHZTZk1oZ1M2aXFGdGp4UW1VUEYxOElRM25oNzZZbU1h?=
 =?utf-8?B?T053clRTVVVvRFVVTUdMalV4c01TYjN2dXVrSlI2c3NjS1pId25YblF6TFFi?=
 =?utf-8?B?dXhBWW9FanVWSHU4cFBZaWlvNFdZNWtjNFFvdlZ0L1pXK1VURWFMRmdPdkwr?=
 =?utf-8?B?V2R6QzRDd2IxRXErOWRub2lDSDY2QmpHZFRXTnBaVE1pQmtodFFOaDZOeGJP?=
 =?utf-8?B?aXhnM2VGcm1sWEdLakZrUlp3Y0V3Rlp6SlJyL3ZUendRcVNtOElLUldpeVYr?=
 =?utf-8?B?dks4eGNYOUgyNGQvd3AxanE2aWxJMHJXbk9wVHpIdHJpbHNMT2c5ZVVhcHlR?=
 =?utf-8?B?Uk8xNC9tYWx5RyswVEthQ0J2aUcvWnJ0Z053RkJ6NUlqWGdBakpVM1E4elhz?=
 =?utf-8?B?SnJHdDN0TU5MTTVBZmNmZHQ3aXNTZktZUENrQmJrMnh6UHJZb3B0NjhPY0hs?=
 =?utf-8?B?azJYRmpXODk1V2NzVGVhdHBpamk5RVJ4R1BWbnZIRlluaEM2bDZKemdWRDR6?=
 =?utf-8?B?Vjd1Um9KWVpIYy9sb2szTzBEaFJ1VjcvdnozSlZsa1hGZFB6UnFZd1RERHZi?=
 =?utf-8?B?L0U2dXdyMitaTTRVN1ZJMjdGbkNuMlEwMnlFR1dscmdBbkhncWN2ZUpUdzhX?=
 =?utf-8?B?K3U1MkJVd2ZzdEhYdWNvMlYwejI2UEpoZzI3dmNuMThTRXlIcmloa0ZjdVdo?=
 =?utf-8?B?OUxpWkRSUkpvbU5TY2pFbzQxeWRXeVd6TUEwN1U1dUM1c3V4MWo4dDdWWWNP?=
 =?utf-8?B?N290aHdOUllMeTlkK3hoeEVVZWtUbzBKZUk2Q3hJMTNCeE42UUhOUzlwOFVK?=
 =?utf-8?B?ZS83UGFveC8rSTRsdUxEc0t0MUZXd0xiaXRjY3d5LzB4UEhPUU8vaE1IbW9t?=
 =?utf-8?B?MVB4cXBDb2pXOWRuWW0xQWVCOTVGUDhFOWZTUnZvYkUvaEdxUkN3TkllL1Iy?=
 =?utf-8?B?ZE5RZWwxeWp0RUNWamUyMHBoTmpUcmwrcUp1RlZxVitMVTl0Yy9ORU9QSDM1?=
 =?utf-8?B?bCswZ3puVDRFdHh3Zlc1Mm1JLzFoQVprK3NCQXRPZUNHY3h4MUllUVc2bW9i?=
 =?utf-8?B?Vmk2b0wxTmxEZTdRbGQ1M3dvTFlQTWRJTnN3U0I1c0RhYTYxNmczQUVDOTBU?=
 =?utf-8?B?aGtJblZxUjQ0b01TeVdyVVV2WFhiL1lWYU50RlVEdXZhWFNWbjhIb08yQTg2?=
 =?utf-8?B?MnlRanZEUzJDVy9vWEpHOU02SzdTUmRWK3NXOW5BaHFUdTZMS3M2OWJIZmVi?=
 =?utf-8?B?ZHg4TzRCMzBNQk5IRFd3N1EycDNTTXkwTDZXdENQdHJjZXVCUmRiallKZExp?=
 =?utf-8?B?RGlvSitLUUhVbjZVUzdqeHFDZVBYQzFqM2g0TWNYaXRza1FLU1p0RDhEbjVk?=
 =?utf-8?B?U3ZVOHpHbytjcm0xb0VUSDdzR2diTVlISnZYSTMvZFJQckIvbE5oR1pmdjd2?=
 =?utf-8?B?SitIRmJBMGpRNDRSUjBSRFpuQVJPYzFDUkR6ZTQzR0l0NjVRVTJTdDBnTkVI?=
 =?utf-8?B?S05QTTV3WjljOENUWE9yK2czc0dEeFdFZ0hwaE5sMXFDSVpYNzk5YmlQVlFz?=
 =?utf-8?B?eEYxOXl0Y3VJWEFTNVE0cHR6OUxpVWQ2dlJVSEdLQ201UVBCays2RnZqeGxX?=
 =?utf-8?B?L0QrOGEvVW5jTUg2ZTBGV0lnSVg5RW42dlozTThERTVUSEh0NXg0ZFZUakQ3?=
 =?utf-8?Q?mjXeGk?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(14060799003)(82310400026)(7416014)(35042699022)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 13:58:57.4419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 844d1206-f691-474b-a496-08ddae70451a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A79C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9489


On 18/06/25 5:27 pm, Lorenzo Stoakes wrote:
> On Wed, Jun 18, 2025 at 05:15:50PM +0530, Dev Jain wrote:
>> On 18/06/25 5:07 pm, Lorenzo Stoakes wrote:
>>> On Wed, Jun 18, 2025 at 04:58:56PM +0530, Dev Jain wrote:
>>>> MAP_CHUNK_SIZE was chosen randomly. Good to see it translates into something logical : )
>>>>
>>>> So I guess I am correct, if we can find two VMAs (except at the edge of the high addr boundary)
>>>> with a gap of greater than MAP_CHUNK_SIZE then there is a bug in mmap().
>>> No haha, not at all!! Firstly fixed addressed override a lot of this, secondly
>>> the 256 page gap (which is configurable btw) is only applicable for mappings
>>> below a stack (in stack grow down arch).
>> Sorry, I was making that assertion w.r.t this specific selftest. What the test
>> is doing is exhausting VA space without passing a hint or MAP_FIXED. With this
>> context, where does this assertion fail? One of them will be if the stack guard
>> gap is more than 256 pages.
> Are you accounting for sys.max_map_count? If not, then you'll be hitting that
> first.

run_vmtests.sh will run the test in overcommit mode so that won't be an issue.

>
>> Also, note that the test hasn't reported frequent failures post my change, so
>> in general settings, w.r.t this test, the assertion experimentally seems to
>> be true : )
> I don't really have time to dig into the test in detail sorry too much else on
> at the moment.
>
> But it isn't a big problem even if it happened to turn out that this test isn't
> really testing quite what you expected :)

