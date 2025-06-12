Return-Path: <linux-kselftest+bounces-34789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D179EAD6726
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 07:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E8737AD369
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 05:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3B119F121;
	Thu, 12 Jun 2025 05:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="D9PBPZw2";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="D9PBPZw2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013037.outbound.protection.outlook.com [40.107.162.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE59D347C7;
	Thu, 12 Jun 2025 05:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.37
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749705319; cv=fail; b=f3B/oiAIqx/mziXQ9LDrfUAcNQF7gnJQFRbxYH9FUlQjenWv1+6zkquphnfdm85Hb25s7LpGhvqPVlBTq/V0OevsEo1MnFpIVNmLRPilJpckY5j43bDmKgIJpcF65EwjkuIjVAfB/6BlgTpJbuQlnieDnbfmf+Zef46fPZJSIwE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749705319; c=relaxed/simple;
	bh=3eEumYJAZ7MCzsWh9kB+OCP81bx3cGm2BbGeil8xqRU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=am2Avzbsl5hQEeejAi6XYrMuQAXmNoz81sE6eQXvy5u4m5URIxdFLvHFtkY4o5Kpq3cc/437ux3AroTMP5Q/ri8ufAAL3KSP8gQS530YKSV+OlU+ICYLfMYUdAGQ65M6DMrudN2R8vLqF3d3phVBIzhHKI8UJjh1DON3s8craxU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=D9PBPZw2; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=D9PBPZw2; arc=fail smtp.client-ip=40.107.162.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ahyY+obyB0AWq5zTKRUDTKPdHzwVdDcPcECoM5Ho3Oxr/idL5OC6KK0ni+fP5Zbp65dj1lKCWQ2HWi+DBSAhegqnpt8b3nFRwZcjhvKNkRZjvo4B+eu0AOALT3Pbi/mgxuMpcPgEgR0PcrSEohOFnsqR5VhTbprnL7+0zDVkAE6oJyPTaWRDPeFHYAlTw/DC8T5JGcbUOf2YCvMo8lirFKZfVdKAPtmoY8RQvljq2FZKTR9/8KPuIRSuk6KllKo53NXOZLb5+5mGv5aH2WHE8+zojccXt0E3D8y+YfTqL0w175t8c6ZvQish7bqeg+0NUDCA2n1X2gUEwObQneOiyA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEmFa2KlXkQixdDFVGyR02I66/wDfXtTNkz22hnnwiE=;
 b=P1fWiLgB4q/I/X9Qa0/WMuYlbFJ6qVc5VVCMfn2epdEYPAu+B2A5o5wBFMVx+YYgmARSPPiTfKklx7EVzi+YZoOmzCcGq0IE0N/2cM3e2LkI2CACOhr8UebtHieCOpkb9uqClb5OF3BLDMWN3XzOv3w/WG+n58f+xtPfu22mskr3F/UjWC67nNWHwQpPr/KUXir+s00aMSR5N9YuwQ4vES3jCR9MSEvBjlsNO+1F49UMOdvt5a/dk53iX56zaXE79pDkgwaxLdgDoVoJcUkpRrJnzYCgPC22lPC2s/gk+lE2iF3LbnrziwLl+SB2syK5BUI0irEDBo2DTjWbO/StwA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.alibaba.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEmFa2KlXkQixdDFVGyR02I66/wDfXtTNkz22hnnwiE=;
 b=D9PBPZw2QkEh4d3zlb3veyg39pIlCiLP023vXYqa7zKwq00dgO/HGjR6u7K8TtkA+f/Ucew9CM+KBWOSAf+dDtAp5FnDDfrEZkOVkgVJY53k6eWooI+Qi/APbR6iJfG0fhnIHhKYvosmTjfJFGGF3jjbRu6fbM+jNJATJKmHnDI=
Received: from DB9PR06CA0009.eurprd06.prod.outlook.com (2603:10a6:10:1db::14)
 by DBBPR08MB6108.eurprd08.prod.outlook.com (2603:10a6:10:1f4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 05:15:14 +0000
Received: from DU6PEPF00009524.eurprd02.prod.outlook.com
 (2603:10a6:10:1db:cafe::c8) by DB9PR06CA0009.outlook.office365.com
 (2603:10a6:10:1db::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29 via Frontend Transport; Thu,
 12 Jun 2025 05:15:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF00009524.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15 via
 Frontend Transport; Thu, 12 Jun 2025 05:15:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4Dhbd0hLl3hiqj0a+oOgYmJCAz9YdWi2jGewEMlZ1KkuxgrULzWyWIGY9qu6rf/COX2cyqCWKG4tGAPkr71U75iOPlAJX8dPEWsdFPdhL9zlPbEcRm3fPi6yIrRWC7rYKXFep1YRy7KHqO0anYJKLyx08OY1RsyYKhIjctgxA1b1i8wsWGAvqOHeAQC90JTn0WlHq1hNfmjgda5leka/PQBksuxnUnYBcs00KTMptsifbxLFrD93zW1M8eXkzqCnjYk8VCMmM6+g2/rEqRXlAW0mPsoTmAEDYfhTGYoyCXYKvMrbj3RWFyIYLPaLEhP9Rvttpme7S8iFaWDJZ277g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEmFa2KlXkQixdDFVGyR02I66/wDfXtTNkz22hnnwiE=;
 b=B4qNLgPFTHSuJXzF9cX9ZxH0JMicupkbV5FVg60k1dALFyZdaodeG9wlIVahWvKioWfHUfhCb0WXpjX12jQ85w6uR2woG52k0vgPphGoDxfrkWbp7Ege+ApWAFj46ZjzkOZR/C2WEs4CCFd27/JA1J3h4fFWcZPnZcbeByM6jhr3Xs4kRf83dVz/YWbLz7cFox6YfxeaN6SNRvxZ5iJKTnqAwGZaaDAf7PCIXStcAtxiJdAXumxKNd2v/c6ZP0X9ANA2bLT1CuwUcZnnFm3D5Vzftjqe605ZprKogpXNC4NDfnqfyGKssMWQU5gPFA4ggQ9qr8d/Sd1w+ONHMaHi6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEmFa2KlXkQixdDFVGyR02I66/wDfXtTNkz22hnnwiE=;
 b=D9PBPZw2QkEh4d3zlb3veyg39pIlCiLP023vXYqa7zKwq00dgO/HGjR6u7K8TtkA+f/Ucew9CM+KBWOSAf+dDtAp5FnDDfrEZkOVkgVJY53k6eWooI+Qi/APbR6iJfG0fhnIHhKYvosmTjfJFGGF3jjbRu6fbM+jNJATJKmHnDI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DU0PR08MB9440.eurprd08.prod.outlook.com (2603:10a6:10:42c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 05:14:39 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%2]) with mapi id 15.20.8835.023; Thu, 12 Jun 2025
 05:14:39 +0000
Message-ID: <06ebdea8-3bb4-48fd-b17a-1e944f85a6c5@arm.com>
Date: Thu, 12 Jun 2025 10:44:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests: mm: add shmem collpase as a default test
 item
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 david@redhat.com
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, baohua@kernel.org, shuah@kernel.org, ziy@nvidia.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <c16d1d452aa876b449324d12df6465677158a711.1749697399.git.baolin.wang@linux.alibaba.com>
 <1352b17c513364164f6231ac32283cbb7093b603.1749697399.git.baolin.wang@linux.alibaba.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <1352b17c513364164f6231ac32283cbb7093b603.1749697399.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::8) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DU0PR08MB9440:EE_|DU6PEPF00009524:EE_|DBBPR08MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: 68a57c05-4c62-4ce5-945c-08dda9701bb4
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?aTQzUkY4c1dDZDZudStHU3NmaW5KK1hReklYZGJ4OVRscmlyQy8ydVE4VTR4?=
 =?utf-8?B?Y2tJMEhuTXBFU2t6V2dCYjh6KzZEMVdMN0kzbFB5bU5Zb0FuZUJ0WDM5Q1JM?=
 =?utf-8?B?dnpBTUcvTzU0aXJDZjFaLzJGZDBBYW9qWHlrVXpzUzVadFNLcEhUOU5zOGR5?=
 =?utf-8?B?dmdYamo3bVhKMmF5Yi9maXZKNEZTVkhMaXErQ0I1NUZzSVdsWEliWklEam9s?=
 =?utf-8?B?RDlnS0ZVeFJXMlZtUTNsVmgwOFlDNDNSdWVJckhualhKQ0dNeXhuZmtvWTE3?=
 =?utf-8?B?NlhxVHByak5rbTVKd0ZJcUFycDJlNVloK3pPUHRkN21BSXpUbmxrZW1NSkJl?=
 =?utf-8?B?U3pRVXFhZGRxOGZSQ0ZHNWFqYW5VZ01ibzU0WHdRQWlIcXU5WjF1ZzM0dG9l?=
 =?utf-8?B?SzRlakExMmwvdk8xcXhrRkluWEFuR21EUVJPcnhrSGtLaWFNRzJIYlJiYmlj?=
 =?utf-8?B?L3pxekViOTIrOXpmUGJhbGhFZ3ZyTEh4K05JY3prMks4TkFYeU9Jbnc4UnRu?=
 =?utf-8?B?Qk1pdjlrU2RYRjdwLzkxWlFyNnVYSS9EQWVzdmpFMTA3STF0SXRmNjVhOFJx?=
 =?utf-8?B?OCtIeVM5OGZmN2ZnUjFOR2FyeTFtUGQ1cDBTcG9QcDIrR1VoNnB1N1dOekZv?=
 =?utf-8?B?enNzSDcwaWVscFZTSWMxMDQwWnZXSHJlMExTVEZ4dWpOVjZ2WUhXdi9VelE0?=
 =?utf-8?B?V1VhMFIyb0ttQm00c1B5bEVGMjBJSGlWb0NCUUVkaDRmRk5PQlI2WHpRcUds?=
 =?utf-8?B?cjloZWhTUlBpck5oM2VWell1dXRjZTlFN3dXWmJHSWpvdERYRDJUVlVSVXJE?=
 =?utf-8?B?SDVpTkxIMDdCRGI3ZzJuN1M4SEF2R0UzcXFyM1d0T0lweGpDYzNmeU5jM2Na?=
 =?utf-8?B?WE5DTk94aXdWOE9ETm1xSmI0UTVveU8xNXZYdWZjRlF5RW0vUHhoOXhmZUdB?=
 =?utf-8?B?N2EwODhISlFLc0RLYS92UUNzanBHNzM1M3U0aXNSRXFJMy9ycm8yVlZ6SnpP?=
 =?utf-8?B?em5QTXNFd3VjMGp0bGNPUSsvRlZJUXRXUTZOcjNxOXgyQWFJNVlMY3hSbjUx?=
 =?utf-8?B?d3dvRWp5UGhRUGh0MHJJT21hMUxQQTkzMjFKRlBWUGQ4WGtjZG5lMmNFcnlq?=
 =?utf-8?B?dkZXZ2xGU1pkWGRkSWFJMVdtZ0xpa3pMb2xFWUVjaU9wamZrMmkwZkUrQk9J?=
 =?utf-8?B?dnBwSFk1MTFIbnhpdllqd1VsOUU5THZHV2ltbU1RTWdFajB0Y1FJL3hMUDEv?=
 =?utf-8?B?MDN5Wk1DcEMyWnZCL0VrVlcvMkRia0xLMmZpMDRkV3ZUR0IrOWtTME9rS2tF?=
 =?utf-8?B?VU9lWE15bXAyTEY0OTR4V1hlSWlKSXQ1Y0dtOGtOeWJ5bncySDNhRUNYSVho?=
 =?utf-8?B?MzFUbGpPS3ZzcU5rZkkyRkpWQmtQTGtwcnlsMTRwc0V2bGN3djJCelJ2YUVR?=
 =?utf-8?B?TnQ4MlZkMWVLRmxvTUJCZjlVdDgza3JDMXMxaFJDZ2Nvc0lZSlFBaVBHTHhG?=
 =?utf-8?B?R1I4Y2hGUUlSRTZaWVNtTVVCR2dyd0NGcTNaVDVpQUhjWG1KVFlSUGVlZVI2?=
 =?utf-8?B?MXZtZDEwSGpnMVVIbE9PS1FpM2dIVjhPN3FrY3VncnNaalJMRE9OYmplTnQ1?=
 =?utf-8?B?dVA0TmZKYnl2bWxoeDJQMGVYL2tuaFVsQ3habUJiTXA4aFFQRjVxeVpWK0lh?=
 =?utf-8?B?SEwzRk1ERit0UzJBQU9NTGFIWFM2dWJ1RUliMnJwT0NUWmVLZHJlSDRld3Rt?=
 =?utf-8?B?ckd0ekJEcXVnSzdNckw3bmtWTE9ocGpEWkFZMGFKaE9ueWcyNkc3Mk1ZbGMr?=
 =?utf-8?B?Z1RWTXlMZ0tOSVBtbSs0NHVZTStsS0FwRTNnR1BTMHppSHRGRzBIMjQ2RWFU?=
 =?utf-8?B?OWIyaU9iSW92akdmeXhla0RhWTVjMXE0NUNnd3pXQlRUU0w3Ym9JVWs5OGZE?=
 =?utf-8?Q?HW0OJSbYbhY=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9440
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF00009524.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	dfb166d8-246f-445c-9224-08dda970081d
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|14060799003|35042699022|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2hObUlCd2tqWW1YZGFPUkZxYytsYkt0aEtuZlgwUS8rbzRndHNTWWtORmhz?=
 =?utf-8?B?d09nMllDaXhiQUJqVzYrUE1oa2tNdXlKUkxhZG9qU0tNTTVldjk4Z21MRWti?=
 =?utf-8?B?ZlJkRDdaL1NkUGZLVy9nV0YvYnFDR0dsZGVWN2tnVkJNYWY4WEo3SzYwL09m?=
 =?utf-8?B?MXg5OGNPQ3JwNElUWDAzeGZ4NlJ3ajUrRFVDR0N0aVorWFlqNW1FQU9EZUJu?=
 =?utf-8?B?OGJJWGV0NUQrUk5BUFNTbG94c3VuaUtmT1RBZDl1cG9YOGVrdTJ0N0tTMXEw?=
 =?utf-8?B?RFpiMmNsZm9OSDVDeldDMjlYZ2kwMHJrM2h3aVN6NG5iMWVpNGwrbFFCcjVJ?=
 =?utf-8?B?eTFTYzhiSmpuZm94WVdpUkY0SFdyZmhxV1A5bXNvTmRzNkZPZHZIb1hDZng5?=
 =?utf-8?B?b0FJSmNaSUdEM3NTeVB0cHVYcjAxSnRTOHVKWnRwbmNhRTdTdXlLZnE3YTEx?=
 =?utf-8?B?VUdSRGc2ek5mRnpPMkZPSGE2S0NhTGs3SlA3QXFRbmpwUmVqN1p1T1Z6eEE0?=
 =?utf-8?B?eVRleTViTjB4MmtRc1lZWEVlLzFFeldycDBia21YZXc2WUNKVlJ0WXJuL3lY?=
 =?utf-8?B?NjliTUNOUzBla1NWNXVVS0VRaGNiK2ljUXRaV1pZUitSNUxrWlczVW1iNStz?=
 =?utf-8?B?NlhpM0V0UmRGdXJPSTJ4SnF5WE5BaTZPTTVWVy8vbDBGa2VjOGZrdCtyMGhX?=
 =?utf-8?B?VFJrMlQrWFZTT3RKZk11NUh4V0p3eHAvWG9yQUhlTHQveWNTVldyYytUNW4w?=
 =?utf-8?B?SWpxSGNjV0xTREF1eHQwN3Q4dTZIczY2Tk9BaTY1SkpKNzlUVElyMVZzdnkw?=
 =?utf-8?B?M3FsdVVtbm8yZTMvR0N1dlVTSEtzS04xV3ZaOU1Eb1NzMUtidldVWXphZW4w?=
 =?utf-8?B?VmVrcUdVMjUzNkN1emQ2cEsvK1VXbXc5Q21mVElobUVEeVUwWGhUQllVZGhz?=
 =?utf-8?B?ZXU5blZZc2xsY2JHUGxKV1JrWFUzaFljNXdEYVU4ZTlwZlFLUXBCdTBOb1Y4?=
 =?utf-8?B?OEZVZUlwZU5oOVVtWm1OWjFDekx3T1doYTdyalZ3ejJwOEM2UXBXNzhVUW5w?=
 =?utf-8?B?TVM1TU9KMlhmK1Nra2NZYnhJTjhwMnRWbEFpd01KRWl6anFVZ3N3OVJRN093?=
 =?utf-8?B?Mm5VK2xDQVVsLzUydkVxaXloZTFBSGl4VGJUU2FIVENhMVBYMWZSeHN6ZG56?=
 =?utf-8?B?MVlFL3BlQVBlSCtUbVJpMXp6LzNmclAwLy9EUXZxRG1ia1Vqc0pwNmNyVGFk?=
 =?utf-8?B?TEZVMENrN3kwblFmQTlWQjdTM1NWaW9aeVJmRExHL3ZVRVQzUi9jdU5iYWdP?=
 =?utf-8?B?QmxsYVkxWGhrcVE5QXlNVXZFZWNpUHkwb2ZaK1NycDI4ZCsyQ1dmZ3l3b3l5?=
 =?utf-8?B?S2dIRFY1dlpUMk1LTFN1R3IzVTU0YmNJZlJBb3QyWlN6bkt3QUMwYmRISjhp?=
 =?utf-8?B?UVFXMTZDdUl5Sk9aSXpUakpBd2pJdjF4SDhUQWRxbDl1S3Mxc3JJZjA3K0wv?=
 =?utf-8?B?WGFJL0xTTVBsYlE1N0pkN2x4NS9UMnYxM0RldHV1TjRCMThzZi9yRnZMcGM4?=
 =?utf-8?B?TnA4L3lsUXdvNDZpZzJuUzlWYUlKVitvVzdsVWJWbVU1Mjg3QzQvZ00zVE1r?=
 =?utf-8?B?cGxtWUk2Sy8wdFhPc0lxNGlVRDM5L3g0UXJQUWd2NlNZY1dNTjlFNFkzaTBh?=
 =?utf-8?B?U3NBb3RZVHYzM1c4NlNWS0VYZjBWdHJ3Nk9TSHJNTXBoRjBvUHgyWk9hK3NR?=
 =?utf-8?B?RHZGNS8wR2prNGxYWWlCeXFEUDVPakcvTklvVTVTTTc2TVpvbURBZklnZFVs?=
 =?utf-8?B?b1pTWnlZZytzVUl6RlZkaG00NjMrWVNEWHFFREIzeklxajV0eEtWbW9NMC93?=
 =?utf-8?B?N25qOE1GZGhVUTRzbmh1Z0hLNWVSMVlZeUtUYWw3ME50TjN6K3dvNGtnWUZH?=
 =?utf-8?B?YzMyay9GdldyM1ZhcW9DZURkUjlvclFsY1I2TC95N0tOZFMwanA2bkJocjFs?=
 =?utf-8?B?Y3oyRnpOYWJuWE5WN0liVTZDdXZlOUk0YWZ5c2tWMnQxWllvWW8vQnFRVHRn?=
 =?utf-8?Q?n856OU?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(14060799003)(35042699022)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 05:15:12.1745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a57c05-4c62-4ce5-945c-08dda9701bb4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009524.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6108


On 12/06/25 9:24 am, Baolin Wang wrote:
> Currently, we only test anonymous memory collapse by default. We should also
> add shmem collapse as a default test item to catch issues that could break
> the test cases.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   tools/testing/selftests/mm/run_vmtests.sh | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index 33fc7fafa8f9..a38c984103ce 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -485,6 +485,10 @@ CATEGORY="thp" run_test ./khugepaged
>   
>   CATEGORY="thp" run_test ./khugepaged -s 2
>   
> +CATEGORY="thp" run_test ./khugepaged all:shmem
> +
> +CATEGORY="thp" run_test ./khugepaged -s 4 all:shmem
> +
>   CATEGORY="thp" run_test ./transhuge-stress -d 20
>   
>   # Try to create XFS if not provided

Reviewed-by: Dev Jain <dev.jain@arm.com>
Tested-by: Dev Jain <dev.jain@arm.com>


