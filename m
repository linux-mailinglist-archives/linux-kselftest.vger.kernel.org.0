Return-Path: <linux-kselftest+bounces-34708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B8FAD5602
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 14:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 051537A2BE3
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 12:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34372283121;
	Wed, 11 Jun 2025 12:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="c8dSi4wg";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="c8dSi4wg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011019.outbound.protection.outlook.com [40.107.130.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3E3242D99
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 12:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.19
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749646402; cv=fail; b=g+YdF2ph5J6PuS3B9PZH9fyYjR16OtwsIXN9kvr6OXDX0mIcgqpreU8bHkf2J9q3VD4RSCWdjGSwd+2f3PZ4nP9FIXSOKunskOUSuEyKgO1WH8MxA0E8dyV1++2IuqfNS56a4Hwp1MjIqEzGmLAT6I8PCltVcziK4pieFYaK1po=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749646402; c=relaxed/simple;
	bh=3ZUcIAuw2A40qltMoBLVDpS29HDDHMVOCO/Mgbbkl3g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dS4LxIdfptDydhHpx8Jx6xw9akPIaKT1X2sX0uQxBDl/hc2rBGocGQpQxQ6EkMX22K1gYv89S5mfzmVQUXZuGwebyfeJIdLR8C3excNvyqA4n+p22NZiF59CZkvBKUarcNAMn+NGjYyZfmrN5bymdeTLDWNLU44Yd7oS+8DRhvI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=c8dSi4wg; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=c8dSi4wg; arc=fail smtp.client-ip=40.107.130.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=vCxER1sZ188eP6vKxAr6wX3VQoulMbgv0/gaL8rJv5U7qkZyqFn7C53p+xwDzKYEjteLmR03ck04afAZneIO/rLsvZNCnnspG8MJYJZ+oap+P+X92xyuxVYcuYWNOemZwrgNeu1B5uctsSJA9eXPSTWtAKOJS3xXfbHoAiQs2N15E4IiZZAToYENr0wZ7XqXs7S8q4CLLqyx0dexgUqL8+JwPyuKqwm3bHGS3nN73pJrgH7zZzNILOzY2GlDYWlNsfgNaWTWY65B//TqspgniY3jmTwQYhPd0OhcQ0ABy0J8XDoQzHcR3/yHeBV8un3GyqhvEVq7MZInrgMG4CJ+yQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iheJvn/4iAWL7wgmNpKt/VHsYthfwkBf1sYRqBC9SqE=;
 b=tcTkitrZMGgr4Vj9Fwpke2MJv7BEFCqimnF5aHR6TRcOFh48wqKBlNBAf8ZJKVBNBZuoN5+6vykyXN2uaPJkEPOVYYc6ACpxALM+MUdLIQWJnW8lcPgCnGZhcYyeD3ggSy2SDJriaudAk83gj8k7R8QXqHlNbK0kimx+uDjfam1ylykeEXzwErK4ebGnG7P9AW4O2TNjBnrnrZoyrqhOsSlT3JO7iBLK4vCkhvUjqyuHHuxqfc5P54Vfo9wlEbc6yK32JNHkrq+T8TgXuFNVJ2IaIKwFMz0/74YYaoLZG9njjTom+V/2+LbyD5Bs7HXygfUkjR8dER0G3A4HsBWqPQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=suse.de smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iheJvn/4iAWL7wgmNpKt/VHsYthfwkBf1sYRqBC9SqE=;
 b=c8dSi4wg7xO3QISes3bQiM/Fqk7rxZYQzMAWYj2BzRLlVEir6dXOFDZIP4EMVKxj4J+ki39hGfheHWUofqB1vI1IOhIX9AhcJ40fEGfoLua+yPss3OYvdmRzfZgS7+iw4lKrzVj7btmTQHaGucELe43EQDu7JCZEt09CiOK2KYc=
Received: from DB3PR06CA0001.eurprd06.prod.outlook.com (2603:10a6:8:1::14) by
 AS8PR08MB8566.eurprd08.prod.outlook.com (2603:10a6:20b:567::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 11 Jun
 2025 12:53:15 +0000
Received: from DU6PEPF0000A7E1.eurprd02.prod.outlook.com
 (2603:10a6:8:1:cafe::aa) by DB3PR06CA0001.outlook.office365.com
 (2603:10a6:8:1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.29 via Frontend Transport; Wed,
 11 Jun 2025 12:53:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7E1.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15 via
 Frontend Transport; Wed, 11 Jun 2025 12:53:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVmMgNrTFutZjIlzoAmQ4m6p0VWOcJ4gTti+necPtRQnCDrw06q73cpSDuYCCogQvlgsrgnfjlTJ9etr0JISXnxqgkpCcAQnPJLcocc1P3EJ++0ggZgl/huZJDTpn6wxhtUsyavs45CctYkKWm6RHqDDfb8pWUfEAL+0FW7ZYshZkig55zVNVpBUDqqHYjSB4goASyTh63DaynosDNArX6Is4ygK/KuILAnLHZYw0VaMS8Ikz20k2GUaVxZ9GJ+cg8w4Y3ITlbGG4ZQZAIep7LK7Nqb/T7zEaxQ01Wgb+v/hrGWAgRZYdgthwM3iPDmX/5Wyupz8yje4E5mAuT5xWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iheJvn/4iAWL7wgmNpKt/VHsYthfwkBf1sYRqBC9SqE=;
 b=St5co9Tc/ww6b9ZY64cXiMgGtB02ROeqV3sezj1Fz3bkKgHi+7+xtcOZQHt0oAZkxfqzyLfsMyZwNN3FJn7mxdwQ9QjisCr3jJbbfKgAhcQVyPa1DoP04nOcyk084kcITrcB62lcumbnqkU6noMREjZX0Da6QfKDOd5XlYH8TOLQXK9XUiONSMfaznACTGojGhn3S7OyulVS9+7RK/ie3lhPKfMKK76PQaO/OY+NBUwGLOYGLKecvQX62j8LJCYXW9tRF6fgTZPWTKx7v39kDkBWQZQARPl+45OV+McaAi+BZUbDb6XBPFtP8FQCl6HxoattSk7IsfcHwdNf5dbKHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iheJvn/4iAWL7wgmNpKt/VHsYthfwkBf1sYRqBC9SqE=;
 b=c8dSi4wg7xO3QISes3bQiM/Fqk7rxZYQzMAWYj2BzRLlVEir6dXOFDZIP4EMVKxj4J+ki39hGfheHWUofqB1vI1IOhIX9AhcJ40fEGfoLua+yPss3OYvdmRzfZgS7+iw4lKrzVj7btmTQHaGucELe43EQDu7JCZEt09CiOK2KYc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AS8PR08MB8394.eurprd08.prod.outlook.com (2603:10a6:20b:568::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.28; Wed, 11 Jun
 2025 12:52:40 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%2]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 12:52:40 +0000
Message-ID: <190b0641-8816-4994-bd8d-c2d9e2487e10@arm.com>
Date: Wed, 11 Jun 2025 18:22:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Skip uprobe vma merge test if uprobes are
 not enabled
To: Pedro Falcato <pfalcato@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Shuah Khan <shuah@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pu Lehui <pulehui@huawei.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, Aishwarya <aishwarya.tcv@arm.com>,
 broonie@kernel.org
References: <20250610122209.3177587-1-pfalcato@suse.de>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250610122209.3177587-1-pfalcato@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MA0PR01CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::9) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AS8PR08MB8394:EE_|DU6PEPF0000A7E1:EE_|AS8PR08MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: 9de15979-2b1f-4b36-89ea-08dda8e6edbe
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?bEJPUFdVaS9ud2prQ3hWNWNCWG5mNDdTcXp5OVA3eTgwYk5PTTlpZk9JNzA5?=
 =?utf-8?B?N2xyMTh5MHZMNFRUL3FQTGl4K2doYWpiUDZOeVUvMzU4eFBVa2U0bGFhKzBG?=
 =?utf-8?B?U2V1Ujk4bUY0UG5LeTZ4Z25ISkN2NGowRUswWHlBb3UyMjFVTTM2SVdia21V?=
 =?utf-8?B?NGhOMEFsYWozOXVhNnBjN0dLdmhTVWFsRG1OUWJMc0piOWl1cWRJWkpRQWgy?=
 =?utf-8?B?TVlmTGlrMTkrQ2t0Q1VZQXJvbXBiMlZ4cWJ1dFJxK2ZKcXIxMm5BS1Q1MmFI?=
 =?utf-8?B?bkEwaEIveDRXeExoRjloOEY5RUhOYnhmSnJNN05QNXUvamV2RUg2bm5zeXV5?=
 =?utf-8?B?T0FvU3ZyenE3dFYrVnFCTndWeDZMbjNiSmxvSVBFZllJcklFaStpSWVHNzN2?=
 =?utf-8?B?ZzFyMWYrMFRyOVNSTmdtbEpsZWM1ZGpPbXVXMUpYb00rRjlydVplQWJpUEZl?=
 =?utf-8?B?UUJ1SlBUM0hCVktoZGhxckFWellIUGpnOSs0N3JibER5VndzeTd0bWkxNDNp?=
 =?utf-8?B?alUwYXhnNHMrUGJwODA3cnBWNytNSU1QRDg4N2l6STVPekFKU2c3ajNudUd6?=
 =?utf-8?B?Rm5yZzlIclAxUVFndjFna2lwdWU4L1BVSEZkT0NhMWd3bUFFdzNvUHFlY1lx?=
 =?utf-8?B?SDM0clVTdU81RWNxaEwwYTZFL3BqRFNZVGlBYkRiMGdXZ1dIS3RPSkhlRjls?=
 =?utf-8?B?aWVHbjNJbEc0dkkybVdtR3FyQUxNZGpDWDNYOE5HbFNDcWdjUThpODZ4VnRR?=
 =?utf-8?B?OFFWaHQxbFNtVnExcW9pSzNwNUlZS3JyejFCSmFVOE5LRktZTnkyVCtnbmZM?=
 =?utf-8?B?ZEhjQk5ISmhQcW5vRUdaMHRjWTNUelJHam9DanF5OE5xeDJMZ091bmVZQ28w?=
 =?utf-8?B?QmJuRm9UMzRMczhYUVNxWTJMQW1oaG5YTTNHVmsvekNWQVBjQ1YwaTZPNkN2?=
 =?utf-8?B?c3pZeW5FUDdDY2Ewb0M0Zk9aVU1RYVZ1amhybW1aeGhxZ3BCZXV4K29EbDJP?=
 =?utf-8?B?U2lEWjlGVWlWRTZtNjdFSDJBSFNWQ0RDN09rcUhxNUhrTGJsRGFlOVViZFNH?=
 =?utf-8?B?Y01HS1l3UzNldllEK3A0U0U3RG5NVzN1Z1ZQNC9WQ2V5YXg2MGtjbmlZS0sv?=
 =?utf-8?B?MU1lakdvV2VzOG9RbnJDbVo4TGJTdkdZcXF6bTY0SWt1eGh5WWJGU0dXdzM0?=
 =?utf-8?B?M0VuN1pMQVU5eWZ4T0dDNXBza2tNbG5ZUmpuZ09kaHp0V2Y0QzNkVk92Wmpi?=
 =?utf-8?B?RUlESWRidG83YTM0cEMxZ2I4aEpBeGtoOFFBK2pNaTNTdjAvS3dDcUpnc2Z6?=
 =?utf-8?B?bTF5aThvMXhIZU5xWWJVdnkvUDFnZXdTVEx6OUJ1QzF1S2RBSVNIRjJxUkIx?=
 =?utf-8?B?T1Joblg1U2JSQW82Nmw2OFhJSUxadkNobXNqbmFjTENBaEY0Nmx1cWNWRzVk?=
 =?utf-8?B?K0VXWHJpU2UvMUNNd05makY0dkNITVZ0bW5RQkdhWjZ5RmVYMWYyUnBsdlJj?=
 =?utf-8?B?akcwSVZUTU1Gbmg1ZURUb1lBdjYrY0ZkbWE0WlQ3aTJMbVE5bnJQbmlHZ01t?=
 =?utf-8?B?RmNKZWMzTXFJVzdVS0NmcVFsMVlUY01tMWVMMVRnNENiVDBQdWQyUE5BdXFo?=
 =?utf-8?B?b2FITGpBanZ1SklhMGhmYzZLMEZXN1RJa3d4cFl2U0J6eGQ3UUdocmowRWJp?=
 =?utf-8?B?ZW9zc04yNnErRmREajNRZUtpN090bDJKTUpjSE94UHlLd0dMK3JDK1dCNWhi?=
 =?utf-8?B?TkI5TEgrNStsMjV6ZEhFN0VRdDlRZmhudkdEcnllSFdSZ05tbGhGSWNidU45?=
 =?utf-8?B?MlR4OFRpenhDc3kzUFVrYndZV2lQVVUvYVVpaElHTy83aWlSNXhxc3dUNEo3?=
 =?utf-8?B?dkxtVHRxaEZNMDl2ekx2VWc0bWRVcXV3T0ZNb2Z2MzVqTGlrMUwxVlRhT0xS?=
 =?utf-8?Q?uascUkA2Ryk=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8394
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	726960dd-2b06-4274-1bd5-08dda8e6d991
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|82310400026|35042699022|1800799024|36860700013|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFVOVml0QmhEc215STlNOEdjNXAvdkZiM20rZjMvU3dUbTZHVVI1OHE2OEEw?=
 =?utf-8?B?K254VnpWN1BjUytFS1RoME9FdU1uMGdDcWR0dFFZdHI4bEVlaWwwd1hWU2FP?=
 =?utf-8?B?SFo1RVhBL2l4NXlVcXdhdEpEZzJsR2V0c1p4M0tic1NPQ1hxUXcvbUdTUVdn?=
 =?utf-8?B?a2JGWi9CR1VwTFpwTUt6TkdidzNzTlI4SzIraU5INk9mNVZNMUREcEMyOVVV?=
 =?utf-8?B?SXE5RGhEMGg0OVRqL1Z4SWd5M1hTNEtaeFQ2c1Z2SkNhaThkZUpGSjU0dWZN?=
 =?utf-8?B?Si9IdGNiTTNndG91SFBvczNYdXdJTHpwQms4WklIOGV2OC9rU1VsWmVEakkz?=
 =?utf-8?B?dVd6SlpCS2ltWjdDTlhDY2djZXdONXQrUmwyelBacExBMFhqaEVEcGZXbHNw?=
 =?utf-8?B?ZUdveXo4TXNVaFpqZEZjeTRsUmlSZG44d3RtUVV0dlJIN0xoanhGYVlFdElQ?=
 =?utf-8?B?VUt4THNGN0s4QW5oQU5rZEtrUFFNcUQycmk1WGV3aVZOeXBHVC8ycTVSRVpo?=
 =?utf-8?B?UkJVTzVVUXJDeG5aNEEzeUdyQzNDcnFvWE16MkRERkgwUXpKb0pqeE1EeVBs?=
 =?utf-8?B?MFY1MThoc1QxR213TjU4TmkvcEV5aDlrSGlSVDlJdkZyeW9Ecm5CQm54b3U2?=
 =?utf-8?B?bVFkNzVyNlBPMWU0N2VBMlNKN1c2YktMemFEMmh0d2dPSEs4K0dUd0QyVzht?=
 =?utf-8?B?T1RqdXArdGIrc0N3SlMxTVZzNVVUNmt2RDZ5VnNraW5RYURxeHN6Nmh1WGdL?=
 =?utf-8?B?RnVTQ3ZHWHc5ai9BSFNiSjFyd1NLVDZnTzYvdTFNNEJ4Zmh3OVpBOUU2bHMw?=
 =?utf-8?B?NG9yTmxOR3EwdCt5b1NlZ3lNTlZnaGsyNndKTE5HTmFHQjNhVUFRempoREVQ?=
 =?utf-8?B?TzNVQmtDSVFXR2QvUlR2eTBGakEyUFp6ZVBuVUhnbjJVV0l2b2k1ZmlJMWFy?=
 =?utf-8?B?SUMzTUlTQkNCcm1wUFl4MW9veExyMFNFbXE2aFhvVm1ldDkxbTEwSzRIQ3hq?=
 =?utf-8?B?d3pRZWFKQ04wTnV5ZGpBZzlscmZvaDJPWkI3VXc0MFd0bVQzVDIzZjlyUTRI?=
 =?utf-8?B?aWlSdk82Tzd6TjdCOWJvNi9ZRkR0V2M4RHp0UDRMdlpOMUppdFlRdGp3elVj?=
 =?utf-8?B?RlJxV3V4NGZzUU9wSFdKVllSbTJ1eDRHUThOdkErcDBuZzdqMHRyZFk0SEt4?=
 =?utf-8?B?Vnc2SG5IZjM0RXhZdGZ5cDI5RFpiWjVNMUJlT0ovOVRCc0o3R1NaZlIwdkpF?=
 =?utf-8?B?SXF0amZSZUpEU2VpMDRXRXhzQ2RtSFRxMG8zT0txbGtESkRqaEpjS0ZITnFP?=
 =?utf-8?B?S1hMQjROVlI2UVhyVFJGaUlOK1dHR3dLTG5LeFpybkJ5UnJJTENJTVNKSkhk?=
 =?utf-8?B?empJZzVxYzJTY1YxRjNGTk0xRi9UQUFMZHpiNEFrcHdSdUVoeURsZWwzbm9y?=
 =?utf-8?B?WnhpbEpHdDFoUVhWNzgzUytYd1JTZk9IbmdOWXZXSGM0N0JhZXNHdjZxQU9T?=
 =?utf-8?B?cUx3U3NYTDJKWEZkVjVaQjB1TFZYQUdjRE9zTWZjVk8yOUZqeUl3Uml5OVlG?=
 =?utf-8?B?dEl4OGtSRU9WeTVLQktMSEdpZjZpeW43cTh3L0pKa3hkLzIweEd5Q2NFT1Jj?=
 =?utf-8?B?bHZRbGVkWG15ZUx1ZlBUeURSY2duRlF0aTNWempUV29tSkU3eWtHZFBIYk1L?=
 =?utf-8?B?Vi9YVUV2S3hHS2phckN5STdMMmJhbW9QNytacmowb09kbW45OFpPZkF4amVm?=
 =?utf-8?B?UDRxTmoxRVNlc1BjaEpnSUI1dk1uOUt0b2hZTXY5YlA0bVlhaVVrYklLUTZq?=
 =?utf-8?B?TkZ4T3NidmhWaCtaa1hCQlc3Vng2TnBMa0U5dXgxd0dDdmh0MkV3U3NRZ2s3?=
 =?utf-8?B?Ry9ZVkpYOW9OTk5rUGk0ci9rT1Z3OG5SQkdScDM5R1pvQXZuWTRaWnZnaTk3?=
 =?utf-8?B?NlQxaXdpdUVkNFFya1RHU2ZpRFh1NmFXRmlBa0lmS2E1dDQzT1phREhsOW5z?=
 =?utf-8?B?MjdyNWl0L0gxSVJEVitBWS8rNWJVN1pTdUp3aERPL3owRW8yZXk3OEU5TXh5?=
 =?utf-8?Q?GPk2cF?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(35042699022)(1800799024)(36860700013)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 12:53:14.0090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de15979-2b1f-4b36-89ea-08dda8e6edbe
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8566


On 10/06/25 5:52 pm, Pedro Falcato wrote:
> If uprobes are not enabled, the test currently fails with:
>
> 7151 12:46:54.627936  # # #  RUN           merge.handle_uprobe_upon_merge=
d_vma ...
> 7152 12:46:54.639014  # # f /sys/bus/event_source/devices/uprobe/type
> 7153 12:46:54.639306  # # fopen: No such file or directory
> 7154 12:46:54.650451  # # # merge.c:473:handle_uprobe_upon_merged_vma:Exp=
ected
> read_sysfs("/sys/bus/event_source/devices/uprobe/type", &type) (1) =3D=3D=
 0 (0)
> 7155 12:46:54.650730  # # # handle_uprobe_upon_merged_vma: Test terminate=
d by assertion
> 7156 12:46:54.661750  # # #          FAIL  merge.handle_uprobe_upon_merge=
d_vma
> 7157 12:46:54.662030  # # not ok 8 merge.handle_uprobe_upon_merged_vma
>
> Skipping is a more sane and friendly behavior here.
>
> Fixes: efe99fabeb11b ("selftests/mm: add test about uprobe pte be orphan =
during vma merge")
> Reported-by: Aishwarya <aishwarya.tcv@arm.com>
> Closes: https://lore.kernel.org/linux-mm/20250610103729.72440-1-aishwarya=
.tcv@arm.com/
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> ---
>

Reviewed-by: Dev Jain <dev.jain@arm.com>

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

