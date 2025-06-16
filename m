Return-Path: <linux-kselftest+bounces-35113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DE1ADB6E3
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 18:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6683A173C
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 16:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE7E286D62;
	Mon, 16 Jun 2025 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hAdXjieu";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hAdXjieu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012052.outbound.protection.outlook.com [52.101.71.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25543264A85;
	Mon, 16 Jun 2025 16:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.52
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750091276; cv=fail; b=BuHpO4Km4mH2z6sS0UKPQKtLvzvuNte4d5FSodLCReNKfx209tiYhx2jb8O9678+gg/4TMxhVQ1B0gXUs5QhlQ4nhjJO9K4+uE765emoIpUr0t6UxO9ExZ22cqdA1H1s4VKLlkUASfq/L7TEvJJPsfNtHL+prco1CxIJoRtfsDM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750091276; c=relaxed/simple;
	bh=5TIazuk8FgKHrDEm0vefZC6d3B6+dHBiazsoqhWGQSY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jObT4j7igagOgFoN7rj0ze+IguvwY+gqDOVsUWLWZoJWQOam7AwJNxNrijsMRI/cimCZ+aBf6AUEeO5qzw/yjUhLlD1FWlMURIcVV0DFaQ9ms99JdgpNVj4P3HvK9SiiuWraWbOFl8c9HgbPzQtW45pwcmV74RCpd8bhWKlKpSg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hAdXjieu; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hAdXjieu; arc=fail smtp.client-ip=52.101.71.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=blA819kwJS/+isUjeD3TAC2LhpQVtr7I+N9bHaC4BG9oZ6dvVq/laGrQ+DoVTqRzGbCqo/rHv0XXxiegZIOn98xPBCmyVTQb6HwSJTdIU+zrdNCT9JGujHBXL9Qo+bOkGjZxrZyjGYRvnGy7tOTJVVaV9z3Bw4n4buimDmyXT9qR/yn1haX6O4zAKyzhqEZVuO0mQfuaa/HZ1KnaMXUjeDmO9CCUUrEBW6mLlHV9nZ7qDh+W/91KUkMqXSeKQ1ezjLCsvu9bFGvqV3BfPjJPZrSNP3Uh70pnlGM6HkK062CVHdKwzwtggUQUbfVnRKMYHfB+mOyuFHp8Vh1EW2trZw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpOccPnOWYRiyolImL0tHeDYi50ULrTku7ed1/hjA7g=;
 b=oCswJF506nflPHQzV8cU/i1IParOCzaa0dnMwXSp9fY5ZBKZg+dvLkv5PPpOyjU4Etfoz/mLoKdF33/8Nxu2ORse09Eq6w6GPaSjTniOqSTqu9EbBedrOFh/LJ2XJ6Wo5cUiZuENf3IxecbXnLHrHEMKIeD0JcmJbU/UZdZWQiJXCrvpEN9liNIjrOy3MHqGG/DF4FdjSM2pkeGZhHaY1/XtTB6Nic1cTx54rDZEkW0rNOO9u1T4cOu9Rrrm1ute6zTljV03454rePGtmBLOAMxE8Tc5akQsZvpweTiwoZ4dYNRMH8Np0Yd/p9MjOg2KZe4cZL9G9ZFdxH2WiMAr+A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpOccPnOWYRiyolImL0tHeDYi50ULrTku7ed1/hjA7g=;
 b=hAdXjieu/ECEbB3QdBtIco2YArU4ZUyuDsavh05Y3//LznIyOAIw7ZvVTEdsJRP6oVDxUDe2Ts3q4VIKXd8zbsL5GaNPliVnQsvdPqVt2uVJtbAryTcOxqdpHV6lrvIpEi4XY2GEPRkThBCsDHRfAtH8DWV+9EHFMklF7hI7mX8=
Received: from DB6PR0301CA0089.eurprd03.prod.outlook.com (2603:10a6:6:30::36)
 by PAWPR08MB10240.eurprd08.prod.outlook.com (2603:10a6:102:366::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 16:27:48 +0000
Received: from DU6PEPF00009524.eurprd02.prod.outlook.com
 (2603:10a6:6:30:cafe::d7) by DB6PR0301CA0089.outlook.office365.com
 (2603:10a6:6:30::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Mon,
 16 Jun 2025 16:27:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF00009524.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15 via
 Frontend Transport; Mon, 16 Jun 2025 16:27:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wY2IltkodJDrq0SAL+RoiuiNS7MCiLabQv/rv5wCgpg5GAvjeRxavhzTOnxkA2jV0hVUVnGQN+OoZ1DK+Nm4FREzkNMaQKnDlPE00IyoG1cuZkTmE/WPcwVKR2d3f/lTC3zeDVofDHgjYKs2zYGkmElIwLI8+gWpiDrDCP3ZtNGsqFVvIZ85PUi+CZEcsqGKzYiH1kN5eOnzF2ADCfDbH1XR/IAosn7y3rtwEZNz8U5TgKF4nlLK1f1xGm74rUk3JBQYD4y2dODe5aX81wHuHZmRJi/y5RfXdgXnNKOvr5R3Q708OGgs4k7/cBUgCK0rx36c0sxiCC2gt3ABbVziXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpOccPnOWYRiyolImL0tHeDYi50ULrTku7ed1/hjA7g=;
 b=Y9J804TqEf70xvwjPfQoaaABGXqgqtOZ9L+W2YE5flgxPLqeEgs7q9szRENfUFnEjLUAh2DVYYvEdqylxWgjB88bVi0RM99NcFwp3bzmqglFmcAEwA9jAA5qspPTGr8snSIkpP3Mf+HfJBBQ40hPyEqN79L1FdMaWXzwB5GrWWkgGQvG8C/qn2qKmaGFPubEUmOW/chZcfDMxD+K+pqkUya4eqvGoMDvLlRd9rd8ThuYQE3piaiV1UQjeweH42mQTRWuApaKMMjJBM7vf3Fsdwkf3NIyF/kMo4pckuKnbBkirtHGyruDMifS8zAQBhhHRqAwN7cpP9XUXAVefd1AOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpOccPnOWYRiyolImL0tHeDYi50ULrTku7ed1/hjA7g=;
 b=hAdXjieu/ECEbB3QdBtIco2YArU4ZUyuDsavh05Y3//LznIyOAIw7ZvVTEdsJRP6oVDxUDe2Ts3q4VIKXd8zbsL5GaNPliVnQsvdPqVt2uVJtbAryTcOxqdpHV6lrvIpEi4XY2GEPRkThBCsDHRfAtH8DWV+9EHFMklF7hI7mX8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DBBPR08MB5962.eurprd08.prod.outlook.com (2603:10a6:10:202::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 16:27:16 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%4]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 16:27:15 +0000
Message-ID: <0665a8d3-7094-4732-9518-01ac313959e1@arm.com>
Date: Mon, 16 Jun 2025 21:57:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] mm/selftests: Fix virtual_address_range test issues.
To: Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, shuah@kernel.org,
 pfalcato@suse.de, david@redhat.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com,
 baohua@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, donettom@linux.ibm.com, ritesh.list@gmail.com
References: <20250616160632.35250-1-aboorvad@linux.ibm.com>
 <20250616160632.35250-2-aboorvad@linux.ibm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250616160632.35250-2-aboorvad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0157.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::12) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DBBPR08MB5962:EE_|DU6PEPF00009524:EE_|PAWPR08MB10240:EE_
X-MS-Office365-Filtering-Correlation-Id: 390369a1-baa0-4c23-46f1-08ddacf2bbae
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?RUZETzhwQmdEcndOR1QvcDVud1FUZFA2OGljZXZwZjdtbVJVQ0N0OEplRmh4?=
 =?utf-8?B?dHZIYmkrRFY3SWtza1paS3dYcnA5U2dCNGl1amY2TGJCcDc2NUdQb3F4dGV2?=
 =?utf-8?B?WDNlZG4vZVN6RUpvc0tlUDF4OWd3Vk82Z3dCWHRGT1NXM251ajR1c0IrazBP?=
 =?utf-8?B?cWNwcjRKSUFVcHY3OSs1YWRHQ1IySk5OaHFsRGwzZ01vODcrOUU2aEdPVDRh?=
 =?utf-8?B?Q3dKSmw5dUxvdXg0OE94WGhpRlhZZTdmdWhIK05NT0gzRzlRTHoyRG1FcHlU?=
 =?utf-8?B?ZStLaWkwc0dOemYzUFlIaTNJSlB5VE10OUZpUHU3ZnFWWlgxK0hCUWV5WGVZ?=
 =?utf-8?B?cURDd3Z4eDgxSXV3VHpoNnl3cFpTVmRPY0F1OFRiNkJUSk5PVW5VUWxFeTha?=
 =?utf-8?B?TW9xNmQrUjF0RHFRUVNGVDNXclFNZnhRUGJ6eGNvdkdKUUZ0a2E3UXJpL3hq?=
 =?utf-8?B?WElrOWtHeHRBNktXKzR6WHNBVDdxaGpqK0hHY3ZCdDh4Z0xXTnk5TjU5cXMx?=
 =?utf-8?B?VzlDeXNTcHhQS29lZlhZdUtpTGZhOURPWUU2VnF3dmYvQU5oNHUzbzlzcHhO?=
 =?utf-8?B?Z0RqbjhQc1RoOU1DYVU2SGZJQkpONTU4NnBFdlFibGNqZ094cndVeHIrYmlu?=
 =?utf-8?B?WGF1a1g0MEVGY21pazhwK2Q2OUJTYm1WQ1dNbWhNdUMzZERIYzcvWGxYNlFq?=
 =?utf-8?B?OVFkdjJHbWJNejVRYTV6TVFzVGFSai9jUXhSSFI1U0wzc0lTODdRYXQ4Y2tL?=
 =?utf-8?B?TDRWMUVMeWdNNDFLbVlqcWQzTXhQT29iTThoQkdSdHdQRVJ1TXVzRDNBUlJl?=
 =?utf-8?B?Rno1SkVDL1RncmVRWDh0MW82bW93UXM0M2lIU2RKa3VWbGUyK0RpVkd1dHdq?=
 =?utf-8?B?enVLaW93V2dBZ2tGK3RUT0swQXdvUDhlN3hYME41U28zZmh3L0V3NE9Wd1RC?=
 =?utf-8?B?Y2tEaWU3S0o3RzNMc3JOSW9xU3lSblIwSFZTRkNHZFg3UEh3czlOVml1amZ5?=
 =?utf-8?B?NmRsZ21OMlF0N2JIN1F6QUhJMkZYbmk0V2dCZXVrRFExT2RrcXFJNnQwa2RL?=
 =?utf-8?B?VVhQcU9VYTljaW1uNVNrMnNlTzFsajBCand2cTNjdGU5cXJJdC9BcWhIaW5k?=
 =?utf-8?B?SUpBN0F6amFYQlEyV24vTWdGNEszSGYrZ0dEclpXNlFJSHBFcjk5RVlwNFd4?=
 =?utf-8?B?d29zckg0ZXRxTVQ2WlBMUmlJSVpSZFVQYjZDNFZHcmlmdllFWVdvSmlwS1dM?=
 =?utf-8?B?TjVqSUdTanZpTm5MRFVwVGtvZGZBR2JudUNMb2pFWE4rVVg2U3lxWE13a2xh?=
 =?utf-8?B?K2dQQzlDSmFWNTZsWmlDK1IvN1BBZ0FJVG1PdlVDVythbUpYNmZ1bmc1QmVJ?=
 =?utf-8?B?ZlNwcUcwMml5Z2FLaWtSaDJEM2dQTjFSOER2TkpibXV6YUY0WDVpRmFkem1V?=
 =?utf-8?B?SlZXblB4MStDTE1jbis5WUg3K2dqY2NTYXN5QkI5Wjh2RUhNOENNTVJ1ZXlo?=
 =?utf-8?B?SlpWT0Q5MzB4Mk1xR0loOFFEa3VySWxoNHVSUlQwQzhPSjNVeCtyd0RQMWRG?=
 =?utf-8?B?S2ZMSW9pM0JMdzlraElnbXYrSGpZVkdoWTJaZ3V0cGlLNkhrSHh5djcxdzEz?=
 =?utf-8?B?YmxLM2Fhd05VN2FRbVFldldSZ0FWVDVOdHlhSTdYZGVpbjA5RGpkNDYxUXpr?=
 =?utf-8?B?UFE3RklQSHpyTkh2YU96MzA5OHgzb1ZOYVlGWktRNDdrOHkzcW1Yc1hMVkVX?=
 =?utf-8?B?N2RvS3hQRXkrS2ZyUy9sYktvRDI0Tzk4SGF2a1l4MVlab3RZL0d1M0RZZjRM?=
 =?utf-8?B?VnNZbnhIQ0sxU3hZT1ZsbUV0WUdabENTRkJtR2VweVNRNHlKUW1xU2I5OXIw?=
 =?utf-8?B?VlUrTFNkeUtpNUpvUVB1NWE0SHBTUFgxOFUrODJJMHJ0UHkvOUwvazZRTlR0?=
 =?utf-8?B?QWFZWGU4Qmhlc2h3RTJ1a1pna0pPY0xvelpxbnR1R0ZjM05GZXRQc2dWRHB5?=
 =?utf-8?B?ODBBQ2plVml3PT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5962
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF00009524.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6baf006d-bd95-4567-9802-08ddacf2a7c6
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|36860700013|1800799024|7416014|376014|14060799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWltZUNtQjF0QXZscEZqQk1EMFhXTVBjM09TZUZWbnpvMkFEMmF1aSs1R0hP?=
 =?utf-8?B?S3RVYmpNVFVFMDJ6TFlBWTZzNHExQXh4RWxnbHdGZlcyOE9VY2QrcUNGbFdL?=
 =?utf-8?B?dVh0SDd2YzFpaTNzdDl4VUZpaUlBYitFSWZpNmVBVHpMTXNpcFlKMDJpMmlD?=
 =?utf-8?B?QmNleEhOVGdKcWZ5SG9LcTE0L1RoanN0bTdpbXpra3RMTGdldDZxcE1sZWpZ?=
 =?utf-8?B?Y0oyMzBDVGxpK2FJWXRlL3piaTA2TnhDQitXTXFqM1AzN01JZ0U2S1JXSGxE?=
 =?utf-8?B?OE1tcTRZSzFiaFlRQzlUWmptSUZ5b25OM3NPa1VPUVpldUVvY2c5UXp0emF1?=
 =?utf-8?B?TjB5VXBaVXJaSEwreWNqRTNLQzFRYkhZeTdnSkt2NG5tdnVpNWk1cHY5VS96?=
 =?utf-8?B?YjMxRzAxU3RmZks2cWpjUFJYOHkyY1JxS1dXRlIyOG9ITU1KeTZLTUtuemln?=
 =?utf-8?B?VTR4alc4TmJzY1ZrSmExUm52QkRzSHQ3TTFhSHNVR3paR1hyWmY0VzRsT05M?=
 =?utf-8?B?Rjd5azE1Skg2WWJmSURBT0hJVTR0NVMrc0tBZGxhem84clpHMEhwK2dHY2J4?=
 =?utf-8?B?OGYyZzJ3M2lHeUU1REp2SjN6b2Ztd0s5Uk0vZHhGc2xYbE5oYlBTMDhYOE1v?=
 =?utf-8?B?OGVLM2hCWmJMdlpzMC9xUTQ5QlpJanRGajFTeTFlNzFWSFFvYzRCQk5XR28z?=
 =?utf-8?B?cHFMbGU4VnByN2gyTG9pTnRFMGdVZ01lK3Y3VS9GTU5Ma3ZoRXgzQzNncHZm?=
 =?utf-8?B?WGl4UHlHRXBIT0RrdDkwcURGNXNZMHZKT0h3L1l6WktTTWVuUjYvam9OR1hJ?=
 =?utf-8?B?c3JnMVhEdFVBY0YrckVMZVBuUzRxclhOdkRvRDUvdnZlRFJhUm1BakN3UWV6?=
 =?utf-8?B?ZzVmREkzMHJ0REFDdFMzMXRneHYvTnA3VCtpcjhhNVpoZDdjSG5GU3B4QWs5?=
 =?utf-8?B?R1pKUnBvcStPUklWalZBY29weTZQQnJSdFVkMFVlZVl6bFBPc0lXLzl4dWQz?=
 =?utf-8?B?YU9idW9rYjZQOXgxakdBQkhKcGROMkpzaXhXRXAwRHVRU1F6NFJndkJONVZB?=
 =?utf-8?B?WlRWMld2a1IvdTgvQUVOUmR2SlB1YlJhVVpUQm5vMzlkd1B4OFVmSFZWNXAy?=
 =?utf-8?B?QnliL3B0Q1JjeDgwUTNYM25OM0hRdkUrOXByR0NkSG90b1MzUGtsUFg2bW5o?=
 =?utf-8?B?TklJYXZLajU3eWNQY003eEYzRTdyakQ3NWhrRWRRV3pESHMxNXIrdjVicC85?=
 =?utf-8?B?Q1pKYk1uVEhtTXVVNTFkcElrdW9xRGVBV1VESkFKdVA2NVBvbFBQc0JCQytK?=
 =?utf-8?B?RnNwalVCQ0lFTW1HZmJWeGRRaGE3TDAvd0RwNjlFQjBGL2pNMUtKU1RxQnFV?=
 =?utf-8?B?NUc3ZGhiK0xRUWRSeFZlb3YrTVVEZ2N4dVFITmUrRXdzeFBGYmdCdktzTkJy?=
 =?utf-8?B?ZGx0Ui9DR1pnSG1vY2E5YUgzZ3NyZDRmb0NyM2hybnBDbmR3eHZ5ak4zWWd4?=
 =?utf-8?B?T3hSZWhQQXpxSXBPaXE4Uk9xRkRGT2FOdXJwWmJlVjBCaEtsZWRDSmRJR1lJ?=
 =?utf-8?B?Y3AxRnIyVGp5TzJkV0VkU00rZ2Q1TExUUTRuL0RvQzhaRWNNV2hOSnNnWHU1?=
 =?utf-8?B?YkVqbzl5Ym0zRmMrZVF3eDVxOWlDSlFGakF1UlJiUFBsdzhHWUlyRk1iSW0x?=
 =?utf-8?B?emM3V2NqZXlNb2lMYzF3elZDMGx0aHZlTDJpN09ORUFMMXlYcmpvazdoYTNK?=
 =?utf-8?B?eGhENUE5WWJjakhrRWdyTnV4dXg5OWxYMWFnVUNySWxrcmVTd3hyMVVKOWtn?=
 =?utf-8?B?U2NnNWtwdGliZXZFZ1YyQTZ5OUFlSk1QK0U4a1ZmZkl1L0p3dGRRai9iRTBi?=
 =?utf-8?B?bGM2VTFvTWJndVhFRjNhMzQrYnBPcjZwQWRtRjMwbHpIUzhPZWFYaE54ZEEr?=
 =?utf-8?B?ekNvZlAybTNjY0pEamhOYkNwb2s1RW5QT2Vrc3VXWENFVlVNVDVJMU9VRWFB?=
 =?utf-8?B?Q0pxZ2ovbTdOWnhuMmNNQk15cDB5a3FQOXRwUDZRdXlFSTlWa2ZYWDJTT3dZ?=
 =?utf-8?B?TmsrSkhKRDZqcmhhZGRJak10Szc4QVBwRklSZz09?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(36860700013)(1800799024)(7416014)(376014)(14060799003)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 16:27:48.6174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 390369a1-baa0-4c23-46f1-08ddacf2bbae
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009524.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10240


On 16/06/25 9:36 pm, Aboorva Devarajan wrote:
> From: Donet Tom <donettom@linux.ibm.com>
>
> In this patch, we are fixing three issues in the virtual_address_range
> test.
>
> 1. validate_addr() checks if the allocated address is within the range.
> In the current implementation, if addr is greater than HIGH_ADDR_MARK,
> the test fails. However, addr will be greater than HIGH_ADDR_MARK if
> high_addr is set. Therefore, if high_addr is set, we should not check
> the (addr > HIGH_ADDR_MARK) condition.
>
> 2.In main(), the high address is stored in hptr, but for mark_range(),
> the address passed is ptr, not hptr. Fixed this by changing ptr[i] to
> hptr[i] in mark_range() function call.
>
> 3./proc/self/maps may not always have gaps smaller than MAP_CHUNK_SIZE.
> The gap between the first high address mapping and the previous mapping
> is not smaller than MAP_CHUNK_SIZE.

For this, can't we just elide the check when we cross the high boundary?
As I see it you are essentially nullifying the purpose of validate_complete_va_space;
I had written that function so as to have an alternate way of checking VA exhaustion
without relying on mmap correctness in a circular way.

Btw @Lorenzo, validate_complete_va_space was written by me as my first patch ever for
the Linux kernel : ) from the limited knowledge I have of VMA stuff, I guess the
only requirement for VMA alignment is PAGE_SIZE in this test, therefore, the only
check required is that the gap between two VMAs should be at least MAP_CHUNK_SIZE?
Or can such a gap still exist even when the VA has been exhausted?

>
> $cat /proc/3713/maps
> 10000000-10010000 r-xp 00000000 fd:00 36140094
> 10010000-10020000 r--p 00000000 fd:00 36140094
> 10020000-10030000 rw-p 00010000 fd:00 36140094
> 4ee80000-4eeb0000 rw-p 00000000 00:00 0
> 578f0000-57c00000 rw-p 00000000 00:00 0
> 57c00000-7fff97c00000 r--p 00000000 00:00 0
> 7fff97c00000-7fff97e20000 r-xp 00000000 fd:00 33558923
> 7fff97e20000-7fff97e30000 r--p 00220000 fd:00 33558923
> 7fff97e30000-7fff97e40000 rw-p 00230000 fd:00 33558923
> 7fff97f40000-7fff98020000 r-xp 00000000 fd:00 33558924
> 7fff98020000-7fff98030000 r--p 000d0000 fd:00 33558924
> 7fff98030000-7fff98040000 rw-p 000e0000 fd:00 33558924
> 7fff98050000-7fff98090000 r--p 00000000 00:00 0
> 7fff98090000-7fff980a0000 r-xp 00000000 00:00 0
> 7fff980a0000-7fff980f0000 r-xp 00000000 fd:00 2634
> 7fff980f0000-7fff98100000 r--p 00040000 fd:00 2634
> 7fff98100000-7fff98110000 rw-p 00050000 fd:00 2634
> 7fffcf8a0000-7fffcf9b0000 rw-p 00000000 00:00 0
> 1000000000000-1000040000000 r--p 00000000 00:00 0   --> High Addr
> 2000000000000-2000040000000 r--p 00000000 00:00 0
> 4000000000000-4000040000000 r--p 00000000 00:00 0
> 8000000000000-8000040000000 r--p 00000000 00:00 0
> e800098110000-fffff98110000 r--p 00000000 00:00 0
> $
>
> In this patch, the condition that checks for gaps smaller than MAP_CHUNK_SIZE has been removed.
>
> Fixes: d1d86ce28d0f ("selftests/mm: virtual_address_range: conform to TAP format output")
> Fixes: b2a79f62133a ("selftests/mm: virtual_address_range: unmap chunks after validation")
> Fixes: 010409649885 ("selftests/mm: confirm VA exhaustion without reliance on correctness of mmap()")
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---
>   tools/testing/selftests/mm/virtual_address_range.c | 14 +++-----------
>   1 file changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
> index b380e102b22f..606e601a8984 100644
> --- a/tools/testing/selftests/mm/virtual_address_range.c
> +++ b/tools/testing/selftests/mm/virtual_address_range.c
> @@ -80,7 +80,7 @@ static void validate_addr(char *ptr, int high_addr)
>   	if (high_addr && addr < HIGH_ADDR_MARK)
>   		ksft_exit_fail_msg("Bad address %lx\n", addr);
>   
> -	if (addr > HIGH_ADDR_MARK)
> +	if (!high_addr && addr > HIGH_ADDR_MARK)
>   		ksft_exit_fail_msg("Bad address %lx\n", addr);
>   }
>   
> @@ -117,7 +117,7 @@ static int validate_lower_address_hint(void)
>   
>   static int validate_complete_va_space(void)
>   {
> -	unsigned long start_addr, end_addr, prev_end_addr;
> +	unsigned long start_addr, end_addr;
>   	char line[400];
>   	char prot[6];
>   	FILE *file;
> @@ -134,7 +134,6 @@ static int validate_complete_va_space(void)
>   	if (file == NULL)
>   		ksft_exit_fail_msg("cannot open /proc/self/maps\n");
>   
> -	prev_end_addr = 0;
>   	while (fgets(line, sizeof(line), file)) {
>   		const char *vma_name = NULL;
>   		int vma_name_start = 0;
> @@ -151,12 +150,6 @@ static int validate_complete_va_space(void)
>   		if (start_addr & (1UL << 63))
>   			return 0;
>   
> -		/* /proc/self/maps must have gaps less than MAP_CHUNK_SIZE */
> -		if (start_addr - prev_end_addr >= MAP_CHUNK_SIZE)
> -			return 1;
> -
> -		prev_end_addr = end_addr;
> -
>   		if (prot[0] != 'r')
>   			continue;
>   
> @@ -223,8 +216,7 @@ int main(int argc, char *argv[])
>   
>   		if (hptr[i] == MAP_FAILED)
>   			break;
> -
> -		mark_range(ptr[i], MAP_CHUNK_SIZE);
> +		mark_range(hptr[i], MAP_CHUNK_SIZE);
>   		validate_addr(hptr[i], 1);
>   	}
>   	hchunks = i;

