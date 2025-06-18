Return-Path: <linux-kselftest+bounces-35283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D958ADEAA0
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 13:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EB2D189E9C5
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 11:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2248225B1DA;
	Wed, 18 Jun 2025 11:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="izds4XEX";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="izds4XEX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012067.outbound.protection.outlook.com [52.101.71.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55681C84A2;
	Wed, 18 Jun 2025 11:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.67
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750247201; cv=fail; b=M7NJ1T3RZZDihGggRhoI5m1v97mS2Mj1VuirGaAiEnnDJEgvgbwCn5Y24mm7P6tA63v5WUXuLDA9K9XfZhhvM4HepOZ9jrAaj8UL2FPoWCM1IvJ8zxIyL0MhMtXy1PtN0zI8JMP0PTqDGgVkaYUJnBCWL0U47+fzBgsYKJsXVxw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750247201; c=relaxed/simple;
	bh=HFKrr80bR5tFi7gERIL5uFLP03mIW2wYiyPdR7JTiHY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JSQO3CbWTO/Q54ygxhsiupD4z3b4RXBF7n3PR6e0NIFIW7qCQLbhfxSztuM4HSS+EsSHRdoXiXSkN9qyZOv9S1KwHcW+fQ8/jEDpBNXOCIlVPtfCuVCwujC9kha8H8OxwYwwDQmf3lSMBmCibKuApSLU1/DmCy95GvzONQ5gji8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=izds4XEX; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=izds4XEX; arc=fail smtp.client-ip=52.101.71.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=vfH8p9Ai8i4yb2jINI2sszcql48PLglW5lNoMF7cpIwBiNhPwVHwFz/UbtyvMiFR/6YnG2YoMhMXSLA++Q1yk4BEJwDAVsNEC9yQMhmaJSmW4bp/ooqBCTwcP47KitekH/FDU837LOguPYM6rRaeCyCP0QlL/e57/kX1j8ZDIvqdTwqfyPeJk1kbzjRPsQTvhtSZGoqNBx6qg1DCOF5sRAEOy0Ih11ACBIWWmcY1lmslolC8y1azBVZsvy/PmvX7MjIBBE0EMxQdxmXnRUUvsj7vdhuyQprt3e037Gvzq1ADYO8xEdJKxZL6Dvro0PNLuJeNVTjEzWm3Cj3giD4qvw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFKrr80bR5tFi7gERIL5uFLP03mIW2wYiyPdR7JTiHY=;
 b=jtB139GuxwNVZ/TX6ECh8vS09pLJk8SXyUR3J08udO0F94LKeEB6a6PyLdx68xXNBY7L3PiCPc2sOR5znE07JMD+rJ91qzo+ZmV0FAYto/TJpwi/iCwO6mGz5EesHklpObkMgCz7BGlk1KEcJzhMbaRn56pzIFyn690nteQRb5nZ5TvjIP6XmKzCtWWVmr00drvQcNfmTJ2uSO22ciQ/C9VLWWMLs2WRqBk5BMS+29wAk7tviBfmxx0IQ+74g9Fe7JzM4/daalRmUJYpNYeiZ4m11PjZGWouNfsdQhyXmN+QckJoen4GAJSRGkSu2hOKl07fTdPjbSsb1MXga724Rg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oracle.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFKrr80bR5tFi7gERIL5uFLP03mIW2wYiyPdR7JTiHY=;
 b=izds4XEXJPaXIAhujm0iJdJjjBsUlgESmkK/mq7jZgyMudGWKDfQJMBM8Du1nKsd2myvHMfmJgmyiVggJL93P2VbpFHir7lzveCkE0YlztI+uH+xOdieNODY07I/SNqSkaJM+BOvuv2Xozj4XS832y8gfhNHj5DB/WmMq8BX7nI=
Received: from PA7P264CA0129.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36e::17)
 by DBBPR08MB10626.eurprd08.prod.outlook.com (2603:10a6:10:531::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 18 Jun
 2025 11:46:33 +0000
Received: from AMS1EPF0000004B.eurprd04.prod.outlook.com
 (2603:10a6:102:36e:cafe::bb) by PA7P264CA0129.outlook.office365.com
 (2603:10a6:102:36e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.33 via Frontend Transport; Wed,
 18 Jun 2025 11:46:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF0000004B.mail.protection.outlook.com (10.167.16.136) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.21
 via Frontend Transport; Wed, 18 Jun 2025 11:46:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVujlei9GuLFM6PrhhFSDenr3kcaG97W6doNqflhWBIyO4eNf5BEkHMtyC9q4h3yabk4i9LER4jrU6qe37cDxeF81+SLPldpauSNCxDqNAruytSPCUoPGcaFeK0fPnFaBPPPGu1XD7no11DzKhc8mCDycFx5WiLqzaB9qkXiTNY85HVeLpY/RSFFJMHSphTCreCe7cYwvg3lAh49yj/loAt+wdg+zdXdNvXGBUBFlNEU/GmAB8ITEfxXjwdKpNgzs5UKmPIthreP/TENrChf2CbLlCdqNDBz+RF4vYZ7A/WKO42FJOnKraqj835slu6UqXqjJ/WVcQd9zi4aMiDM1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFKrr80bR5tFi7gERIL5uFLP03mIW2wYiyPdR7JTiHY=;
 b=nKKfavQcZfBkvTsPLcpQT8QxxG+CFRmdNACBUbdzxX4D+XZ181yGlRKZ9gEzh6tMAbkij6TBpSsbW+ILR2L3PXANGBtmpYrCg+ktViJPA4/ge9U84qfqsjBgEKzE4AhHmb6uyyrDO1ASO+iIIfQXwKkYdLkrTa3n0PxhmSKbiCQnhdi9IbN6zpZqj2l10lmlzZu9JLwEo5/qhS4WO7DDaLsiXh7Mu7B57X+s7VIkpwASYgPLTp8LDo7lFNldgUebfpClz9LHz5EqZ7cA9S6QESJW0EnunMpw+1bVNgZRGHdA18lI8X1K1hbi8lphI8kWqaguH421PkQQFCwqNbAR9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFKrr80bR5tFi7gERIL5uFLP03mIW2wYiyPdR7JTiHY=;
 b=izds4XEXJPaXIAhujm0iJdJjjBsUlgESmkK/mq7jZgyMudGWKDfQJMBM8Du1nKsd2myvHMfmJgmyiVggJL93P2VbpFHir7lzveCkE0YlztI+uH+xOdieNODY07I/SNqSkaJM+BOvuv2Xozj4XS832y8gfhNHj5DB/WmMq8BX7nI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AS8PR08MB9978.eurprd08.prod.outlook.com (2603:10a6:20b:631::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Wed, 18 Jun
 2025 11:45:56 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%4]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 11:45:56 +0000
Message-ID: <aaddfd0b-216e-48fe-b48f-35c78eabcf9a@arm.com>
Date: Wed, 18 Jun 2025 17:15:50 +0530
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
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <79bdd993-0e9c-4d7d-b42c-4b5750eff140@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0069.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::10) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AS8PR08MB9978:EE_|AMS1EPF0000004B:EE_|DBBPR08MB10626:EE_
X-MS-Office365-Filtering-Correlation-Id: ca418c36-d15c-4a18-9cbe-08ddae5dc535
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?cVpZZURPNDRyc1BybXN5Z0FaMDdDZDBURmRTWXNvSnQ4UDM0aUY1NitUL254?=
 =?utf-8?B?TVhQV0dTdEdzaXdEWHdWNG1sano4d25YUDFnK3lQeWlpOUx5K0VJMWoyUjlS?=
 =?utf-8?B?UUlMNzZ1eDBUR1pPa1FMVldlcU9kUkNuQm9PL0xKYWpkcFkxQUlPYzA0amRu?=
 =?utf-8?B?MnNDNkhkTmRUMDJVRmVGc0VzQXdSdWNxNnlzN0ZmV1AwZmZORTMzays2MlFl?=
 =?utf-8?B?TEZyWGZwUUgzakROVHd4WVVERzRrQ1lVODV0aHAzdk40RUovUDJ5QnBUbEdJ?=
 =?utf-8?B?MDlEUDNtZ3Jwa0hBWWFxcVhzNCt3WXp5cTVoV3cxMXA5Sjd1UytCWHlDdHVT?=
 =?utf-8?B?b1RqakgyWHdPSDBBZEpOSVpQTndVKzdoR290VlN4bWZHd2poM1phdktYLzh5?=
 =?utf-8?B?NGFLNW15anR6ZG5DTXd1d3dHVFZqRnFFRzRrT2NHc1Y2NVhVSCt3TlRWMVBW?=
 =?utf-8?B?aVBVWGdsV0tZVlhscUlnblhRVHkzVmUzQUs1UkFvMWhOMG11UmVNbmFXb0Ni?=
 =?utf-8?B?aE9UME1hYUhWWXp6dzNvKzYzRjRtTkVzWStVd09uNWhxKys3MkUzRDFYcHUv?=
 =?utf-8?B?RGdzS2YwVzNFZ2diMHpwUC9sOFlLbWh4OGg5aTVnQjc1cElqYkZOVjBmZ0F3?=
 =?utf-8?B?WHVNalI4dU5DbEtWNU83V2kwWWN0cERqT2xRZGdjKzJkTlo2alNzZE5Mc2wy?=
 =?utf-8?B?Vm9hRU9RdkV5VkdCSlRSVUVrYVE0b1pNLzB0emR0amdpbFFBbSs3VDZHT3FZ?=
 =?utf-8?B?OHVsVmZZYURvWXJoRks3bm90TmREaldUWnpXbU1yUkRWTlBXQkNFVUd4bzFW?=
 =?utf-8?B?cmswK05hbHZYOEludllNbzlIckJJSC9aVjNrQnlaSUFUK05BcTNqelQvUk1N?=
 =?utf-8?B?dUQ3MjJ3UGwrSHJPalhLdDZhZHlBbDdPOE51ZE1Iak1iVkdVWXJ6MXFIRW1Q?=
 =?utf-8?B?QmpOVkZWWjZOMmhIeFRFNWRXYjZoV2NlaVRYeXJRNHNNSzVGWXNSVnRXL0xv?=
 =?utf-8?B?VjVsb2xZTzJmMHJTRStBRWdIcCtCNkphZWhqdTJHa1ByV2JNRWovMzFyNjNt?=
 =?utf-8?B?RjVwRGc4K2FiV2tSTCtXd2RnSSthMmZPNy9LeVI5dVpsT2RzUWEwdUhkZFFJ?=
 =?utf-8?B?Vld4Mm91b2J6aWo2K1NFUmdtc2VmOHV3WmNQQm94RFA3SUtKNjBWOUdKbDFE?=
 =?utf-8?B?NEltR0tXb3dqS1JQeUVDUGhMWGlzUHFrN3dyZExEOWNPVWRGZnhIb1huQnM1?=
 =?utf-8?B?ck0vUlVHcjRaYkp3TFljcFE0dk5RTDcvLys0ejg5bEtjOGxGYTQ4LzdUeXZw?=
 =?utf-8?B?ZDQyMXUvalkzSWdJa205Ym1VUFViQkpVTVczSk40UlVtejdtblB1VjdWdlpr?=
 =?utf-8?B?TmR1U3Z1Zm5NWldJaVVITnQwUXdRY0NlSDJTZ3U4RitCTjJaUzVibzYybVZq?=
 =?utf-8?B?elZQY1JzYTVBb1dtSkNFQ2xITGJXb0xpSGttRE1PazhzbW5SRVRobXpkK2pu?=
 =?utf-8?B?dUhtcTczWndBRSsyZktGZTdOdkhvOXBxd3JPM3d2MFlmY0VPTVY0ZkMya3JH?=
 =?utf-8?B?T25IS1V5aUpZMUQ5OWY2U09qRGN1aUtzdlBSazBLK3doN29yYWFtdzJZSDEx?=
 =?utf-8?B?bzVscjdySlpPaHltdXR5bTZuSTdLM2hHelNwT2tqdDdkRnZQM09OVzYwcGJW?=
 =?utf-8?B?cDlmZTVPUHY2N0Y5TzN3SUc3ZG4rS0VTOVBiZEUyRmFMOWJpYWlMNGpsWjJu?=
 =?utf-8?B?SFZFck9lMExwalVzL2RPTGd0cHI0eTZ2dHFVYmpkZWl3ZExZd1hDaWVTbmNJ?=
 =?utf-8?B?eUZkaVpCRnlTRUJZSE1IamVnNWlPNlJsSk9mWmZSN2F1QkoxaFVRR3hFSTdH?=
 =?utf-8?B?SXp2YU9vR0Z0Qm43L0xNLzhYd2g4bzZ3cSs2WUlGbkRIaWVMdi9QRG9zRmxn?=
 =?utf-8?Q?grGkpGw4RBE=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9978
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF0000004B.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	17d4497f-9f4d-4af6-0c49-08ddae5db010
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|35042699022|1800799024|82310400026|36860700013|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGh1WlVicFdMMzhiY0V2QmR3SFlnMGRVSDF3SjJZTjd1Q3FycWhFQnNPQVcv?=
 =?utf-8?B?UDVEMUVOWWljUktHbGNPMGJUTHdSdnpvaXhlaVFma2ZyOGoyUktFQjdvTE9Y?=
 =?utf-8?B?enVKWDV1c05USnU1Z0IyU0dub1ptS2QwaFdXck9CbUl2TFJiMFpPdjdUQnZE?=
 =?utf-8?B?VlR6R2M1Smc3WW05TkFORTJiWS9uc1pkbTN0ZjFPWGdyNG03RW4vRUNuKzVJ?=
 =?utf-8?B?cm5FSm5ONlZ0RFZ4b1hlYWVMaElwQWtmK2Rld0pwRWkzUEt4R2ZMdXp0YXhC?=
 =?utf-8?B?NFUrdE9EaDV4Z2pYRmtjb3hQMFVHazg1UVh5UHkrVkc2VUtUSDJGenFuS1hJ?=
 =?utf-8?B?NG1WdDB1YUVhTTdXNG1hMmdjQmUrVTdaUjM1MmowbGJpREIvZnMxc2VzSXZS?=
 =?utf-8?B?bHljZ25BNVRBQ3E4SGFBK0lNWmpHYWtYV1Jmc0VBSC85MHRRcGdLeGVjaW5K?=
 =?utf-8?B?RzdaSC9jNTBvZEpFY3ZETVZYLzU2MFRoNjNYT2VaT1kxRUZ4L3RQRlRuVUpu?=
 =?utf-8?B?cGZQUWovWkRNRU5FVGxHbVRtb0FXSjRqeGxqaEExZ09PUU1qazF6V0tvUm82?=
 =?utf-8?B?RjNWNk9wK3YxeG9vQnhwWTB4UmVSbnluVzdhamNmZFkzcjdMWllTdngySTJR?=
 =?utf-8?B?Z1ovV1JNckpGb2wzR3lxR3BnU1ZtQnIxdStUbzcxdmF0K2ZKTlk1Y3dtaVFv?=
 =?utf-8?B?K21wdUxQaGt3OHVmclk0eUVXNHI4SEJQMFVMbTI2OGlTN0FJK0dMVXJ3UUFY?=
 =?utf-8?B?RStZcHNHWVBwbzJlRGt1SVByc3pqVUZ6MWhtZ0s0QXVaaXZsNVRtRzVwQ1JN?=
 =?utf-8?B?cTV6eWdNVlpyend3cXEzR3FSdGJFWEhvYk5KZ3VqRzdXTk1xS1h2ZHRNclE3?=
 =?utf-8?B?KzJkblBaSUNlYUNRS2F6eW9ud1h6SCtCQVZNcWsyMXBla2RuOHVrZVBQYTdz?=
 =?utf-8?B?dStJdXdpdTNlSFNqSkNCSStGUUFWcG5UMUljUExwZEVBUVM4dm55RGl3amht?=
 =?utf-8?B?SGhGcjd2Q096dTdpM045NlcyVjNnT1JHYkkrRWlvNmNMdVB4YjZRTGZrZk45?=
 =?utf-8?B?MEFFTmlYQVdhZVFJOTczc1hvN1VJcnd5TXNyUnJqNk5la2EyMGRUdEJTQk54?=
 =?utf-8?B?MmdCRm52WUN6WmZlWjJ0RUhocHZGWFduUEVybW4vY2pVQkpNSGJ2ZVhIbE5w?=
 =?utf-8?B?Y2IxWHFlUFJRZk4rSHN3cEpaRzJMU1JtbXI5cC9pVmg3MlYvLzIzdnlUTXo3?=
 =?utf-8?B?TURDQk1FZlB0ZGVmT01qdFlGREFhRERoRUh1WkdsbHdmYXlCMzhFZDNMaE9q?=
 =?utf-8?B?RkUyVjdNQ3IzSy9QRkNoYU1SRVMzNDBoSHdzOHBScjkvbFYxeU5DN1djVmxm?=
 =?utf-8?B?eElNMkMzcERyNlZWZ1JhQTZHWHFDdzNwVFZDdi9qVkhHelVJZTFiTzZ1Tzk4?=
 =?utf-8?B?eFd2dlBsQ2lqSnkzRjRDMzhjUHJoVG0vOGZmaUdpUlhsNXJWWHBzYnROSGpF?=
 =?utf-8?B?N1pUVnRTMWpJeDZnSWNYMnNCT2paaWhjRUI5ZTcvaEc2ajFYcnlnSk1mZjVq?=
 =?utf-8?B?RkdYaFhtRUVNYThIR09tb3paSzgwL3AxQVdsWWIxQWJyenhVQ0hEUCtIbm8x?=
 =?utf-8?B?SjB5ell3K0JKeGpPYzQ4TjdkYnlGKzI4RExhMjZHeDdJemZoWjUvRkliZ25B?=
 =?utf-8?B?V2oxUDVIT0JpYmVnUlBVUnd4NG5HWFVLOXhQSTBxUjJLNzBKOG01YVdXR2t1?=
 =?utf-8?B?eHF2V3dFRHZ6aUNrMXZ1aEhJdkpFZk1kNjZRMEFYei9nMXY0RitlVFMyM3dF?=
 =?utf-8?B?ZDh6S2tSQmFueUd5Rm9CWG9Pak9SUFE1ZW1FeEVOSkIvMWFodFh0MXA1N0RS?=
 =?utf-8?B?ZlNvbkt2MWhjOTFMUkJXQUhwaTN2L2cxb3RMekxHREdTTFIrRXBCbEhDT1R4?=
 =?utf-8?B?cG1MV3lSNkFSZy9HdTF3QVVkMEppVFB3dDZ1dWpZK2JpcC9yNUhDM25wVUUx?=
 =?utf-8?B?ZXZrNFAvZzFySnllV291Y2RDKzd6TGZpbjFsZnNjVDc1SEtsSXhqTzJKS2NF?=
 =?utf-8?Q?quHl5E?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(35042699022)(1800799024)(82310400026)(36860700013)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 11:46:31.9317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca418c36-d15c-4a18-9cbe-08ddae5dc535
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10626


On 18/06/25 5:07 pm, Lorenzo Stoakes wrote:
> On Wed, Jun 18, 2025 at 04:58:56PM +0530, Dev Jain wrote:
>> MAP_CHUNK_SIZE was chosen randomly. Good to see it translates into something logical : )
>>
>> So I guess I am correct, if we can find two VMAs (except at the edge of the high addr boundary)
>> with a gap of greater than MAP_CHUNK_SIZE then there is a bug in mmap().
> No haha, not at all!! Firstly fixed addressed override a lot of this, secondly
> the 256 page gap (which is configurable btw) is only applicable for mappings
> below a stack (in stack grow down arch).

Sorry, I was making that assertion w.r.t this specific selftest. What the test
is doing is exhausting VA space without passing a hint or MAP_FIXED. With this
context, where does this assertion fail? One of them will be if the stack guard
gap is more than 256 pages.

Also, note that the test hasn't reported frequent failures post my change, so
in general settings, w.r.t this test, the assertion experimentally seems to
be true : )

>
> This assumption is totally incorrect, sorry. I'd suggest making assertions about
> this is really not all that useful, as things vary by arch and kernel
> configuration.

