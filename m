Return-Path: <linux-kselftest+bounces-35592-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A625AE3467
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 06:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9237216D200
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 04:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903071B87D9;
	Mon, 23 Jun 2025 04:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NXPmFcCV";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NXPmFcCV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012068.outbound.protection.outlook.com [52.101.71.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3992FB2;
	Mon, 23 Jun 2025 04:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.68
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654431; cv=fail; b=OGH2ej3oDVFpljXjI89dOqvHzQSLa+w7Ah8SUOTQzP0TgN6jsqBmb3WZaN16yh1gXnmB/wmTyCYS4Vaja67mz7WtMKWVAGrNh5jYgFTmIwpJ5DB5AbTLe3C/Vxrr1Bva+QzP6AZlhXaGmx0lRPbgRauzOh+kfhnfspcAfUXxIx4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654431; c=relaxed/simple;
	bh=lmLYz3RQ+7tl4c1TZpdPtHElVOAIQAXmotl9QlJHoKw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FaOy6+Awb7+ZttSWEqYMjqhw55C51f0zRyjCd4OhviymI5JquZuz+V6XfaV1woxwy+4EL6xeHRX8GXW6jP7qzvFBoMJYEgF0YsMVJmCJHqqvg/5KAe+xwk9sez3XXnJ7M+xmH401vsQT1jtj6LaWktMoTIXCbzHi6jP/MIIzmt8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NXPmFcCV; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NXPmFcCV; arc=fail smtp.client-ip=52.101.71.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=w/7Ye0ju4ysbfCRtT6IsmR8E2virubV07XIpQxGQt2YjlZm89HoQQLPIez70WFYq0kT7x7Eriw2Tvo9aII5dr1aVOTC54C8eurhbD9w75O+K+63bOFaW19lOnTTO5Jky89znAkWxQ4noigqmaQRC5YyzIWhBq4k4QjF+3IJkArUcdqp57BKkwWia5/j6d2X3ySZXmDh3mfvSXwCwlmVA0pQyWOJzJz9YRm6OEQHkJendrVsuKwYMfPse3vJRfoZLpCM8t/wjNLwBS4xP75NEQ8UXKRiJgmdFT+WCEq0sT1D8FglGkUb9o16/+ph72/vvNRdZB5FSMvo3riumGJ5+Fg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLYFvSZ9MBLOZ3P7a9VHaBAFYGgVWVUwfhE2+wY0Jv0=;
 b=fFaqsP7A5j4g9NMG5naU2Fkc/dX3roqE+1Ob0t+jSz23bQI1bTbTkNXqJgWKRykhbHE4bFWkYery4KrgFq1j2UqZpUewMnlZ94WI7K4T0YVf9k4ocGnZyT41et7mcjHeJszHyUliqW9WKBmQA4bn2iSy+qZnTJT0CMdNsBwNKyhTYz0lJELS43yEftlKMXHUxX0MIrNXT1PrmgAFm81/8BsTDjSCqXAij9p6Z0kXyu26O58txq7rumFrROQQgf+j73ktukN2WNGlw7rrHc6vCuE9kGCHvU28mXbySqhKsIwtDZgDBi0CEUnF5arJkAcoPUZmf9YP6v3GYQ/50mMtNg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLYFvSZ9MBLOZ3P7a9VHaBAFYGgVWVUwfhE2+wY0Jv0=;
 b=NXPmFcCVL/z9TQYT08TqKQb3TZXcFHKvwMf3/fBjhyRvOyagrT3tsUc6mBLy1TTxubHAL388buate9LLZI+7xslCZBpRW0kHCsohArgACaMoPJ3mpoGdwpjjG4fCm50q+2lgq1g0jdnOuoqmqHRs3s2LTaDU3Pp4H6eYUV+Qqt8=
Received: from DB3PR06CA0012.eurprd06.prod.outlook.com (2603:10a6:8:1::25) by
 DB9PR08MB7721.eurprd08.prod.outlook.com (2603:10a6:10:390::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8813.28; Mon, 23 Jun 2025 04:53:42 +0000
Received: from DB5PEPF00014B9D.eurprd02.prod.outlook.com
 (2603:10a6:8:1:cafe::5d) by DB3PR06CA0012.outlook.office365.com
 (2603:10a6:8:1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.27 via Frontend Transport; Mon,
 23 Jun 2025 04:53:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B9D.mail.protection.outlook.com (10.167.8.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.14
 via Frontend Transport; Mon, 23 Jun 2025 04:53:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DX131GLBH3rhbxm2FPfe/zeJ2fwIy2UC8jSIsZh3QdVQuSlCaMxd1TYl8vyAt6H15KK8ovkSy4zh5V0pjcV8V87JsdA063npTR2fJMn/T5iyxvSc/tKJh8F490fxlUcrKpVZPyQJ/+HZHSsUWEoC0hIbpW11ZOLD3dqVazHOQmrE7222IeN79sAximyPW+JeAa+aaopJ4UElmfiOhmQHAAzDs7VWdHO2j/n2yIDP0MNf7+Hrzzd22OrXZgGFqTBTxL/M6G7tLVh7rHviDdEWIgtklpuCaWtTNASJ9HgBYb0hTYXJdWjUjF/SK08Z9xlKj0D0UUc9xLExieSM+zsC3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLYFvSZ9MBLOZ3P7a9VHaBAFYGgVWVUwfhE2+wY0Jv0=;
 b=g3DjQwVr9Fen5+PgyJp0xAdLpk/nIe+ei/zJaMhc5O2cluw7yTMrSqiJEeDiKom0RYvnuHzjjnRTL7vtkd+DosJ1qievDT+Ei6irps8nWLQYh9FsnwKRgm8afrxbS7QfpYT3j9E8og/Nd1ixMil9rwbnu8l6UqBwEMEZV9vujL4TAgr/L3zEf9R9Gg6dedTpNSL+6NEtAD4LvVFXuDMenbTBd4jQKMeTU3123l0sHwau8fahD5qJNbxth/jXW+s/FyP0br0LE/RpP516CTst/Jw9wBsKbnUf6Pfhg6oZm5v6BmpIHm+wowJ2iIFWAuqX8a3QUTCb91FkuQfWTPrbuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLYFvSZ9MBLOZ3P7a9VHaBAFYGgVWVUwfhE2+wY0Jv0=;
 b=NXPmFcCVL/z9TQYT08TqKQb3TZXcFHKvwMf3/fBjhyRvOyagrT3tsUc6mBLy1TTxubHAL388buate9LLZI+7xslCZBpRW0kHCsohArgACaMoPJ3mpoGdwpjjG4fCm50q+2lgq1g0jdnOuoqmqHRs3s2LTaDU3Pp4H6eYUV+Qqt8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB7111.eurprd08.prod.outlook.com (2603:10a6:20b:402::22)
 by DB9PR08MB9923.eurprd08.prod.outlook.com (2603:10a6:10:3d1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Mon, 23 Jun
 2025 04:53:09 +0000
Received: from AS8PR08MB7111.eurprd08.prod.outlook.com
 ([fe80::4ea7:7e71:7dd3:3b45]) by AS8PR08MB7111.eurprd08.prod.outlook.com
 ([fe80::4ea7:7e71:7dd3:3b45%5]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 04:53:08 +0000
Message-ID: <2fc32719-1e38-4bf0-8ec5-5bcb452d939f@arm.com>
Date: Mon, 23 Jun 2025 10:23:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] mm/selftests: Fix virtual_address_range test issues.
To: Donet Tom <donettom@linux.ibm.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org,
 Liam.Howlett@oracle.com, shuah@kernel.org, pfalcato@suse.de,
 david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, ritesh.list@gmail.com
References: <79bdd993-0e9c-4d7d-b42c-4b5750eff140@lucifer.local>
 <aaddfd0b-216e-48fe-b48f-35c78eabcf9a@arm.com>
 <8e23c5d3-6ce3-4fe8-b6fe-69658d5d0727@lucifer.local>
 <fc5c8193-2642-49f7-9f2a-00ad33353773@arm.com>
 <c93110a4-19e4-4a1d-b044-6b7f521eaa0d@lucifer.local>
 <815793f1-6800-4b9a-852e-f13d6308f50f@arm.com>
 <2756fa2b-e8bf-4c66-bf9b-c85dc63dfc33@lucifer.local>
 <41d9a70d-9791-4212-af23-5b13d8e4a47d@arm.com>
 <aFPI_blZGhvKSbNJ@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
 <546d7aa5-9ea3-4fce-a604-b1676a61d6cd@arm.com>
 <aFbyFMjVs9F3KMex@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <aFbyFMjVs9F3KMex@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0158.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::28) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR08MB7111:EE_|DB9PR08MB9923:EE_|DB5PEPF00014B9D:EE_|DB9PR08MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: c681923c-98eb-4f39-94c2-08ddb211ed5e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?YkNtVFhoSHZSQ0ZlenpUMmVIOUxMR1hzTnYrTHZJTkdaM3dNYys2VHVQOW5v?=
 =?utf-8?B?bWpwL1Y5bTlNWHpiRy9QdXp3NEZFQ0JUNCtIZ29NTjdkVFpkNXpxelpNTW82?=
 =?utf-8?B?U0liOExFRzl6TjV0d0FoOU5nc2IxZUx4dnY4TTJseTVEaEhia0V6Y3FxQlB4?=
 =?utf-8?B?N1V2NFJCOVlLc3hrSnRrS1Z0UFVTQUJaVzBnTGx3S0ZwOWNJZVZMbFZPQ3FC?=
 =?utf-8?B?NTIvL01CajQzWjlvVVdIdzZPMnNIT2ZWeDZFUlFDVWk3WGFzSGszWXNOOXY4?=
 =?utf-8?B?TXZsbFBmcERtVDI4eVM0Q3BOWFNBYmYwNHhnZXoxRDJTQ1FHdFJqbnVRMVFW?=
 =?utf-8?B?aUdFeHIyTlp1OU5Tak9POGszb1FJd0daVGxDVEIxY3BwZk52cXU2eDBXUmlq?=
 =?utf-8?B?TTNoZ3RlUFZzQjRORVFKc0MyYUFmVXdVYklNNE82bWs1OUVnL1dSQVhPb21w?=
 =?utf-8?B?Z2I5N3VmYjh3QmNaakpUcXczNE1nUnRJQll3ell1elZSSTVTWmhOeWpacEE1?=
 =?utf-8?B?bk55UWgxU0FYS0o5YlBqQWt1aUZzc3o4R0FtTjRtV01DVTVhRDBPaDNoSzR1?=
 =?utf-8?B?QTEydlNORkNWcWZjZWcvWGdRM1BadUdPVWt3Q1E4c2xzUjFCMXczbmE3anVC?=
 =?utf-8?B?elVNQ05ybXBvMFR0K1poZmtCa1JKald0bW1vNDkySVBQc0oyWUFLeWxQT0RQ?=
 =?utf-8?B?am5hTGdnRHBxVDR6cVhudTdkZ0trQ2g2WjBOVzZ1MGhzUjd2ck5tNHBjTEZF?=
 =?utf-8?B?OElHY2loaFcrc0pxcHZKaU1RbWhzYVNiZno5YTQvVTVrZkhGWk9WMXR3WjdS?=
 =?utf-8?B?dGFSeVY5a2kvK3VINExXTmFVYll0by8zMStxSk52UDhwL3o4ZGxxNEwxWXMy?=
 =?utf-8?B?Z011VEo5dG5yM2Z4K2t5N2JWdkxuREl3MDJCZ00vdk1DUGNnRGtyNjQ2SmJt?=
 =?utf-8?B?Smp3QmFETmFiK0tLaXkrTEpTeE9CMmxveTBuWGxtbGlFNW9YWEZzajNHYUor?=
 =?utf-8?B?SWtwUTlaS2lJZDdiNFB6blhkUjE5R3N4VWh4QUZIbldmVzJsUENNTVZjaGpr?=
 =?utf-8?B?QmFaaDRJREo1SkF6TSs1a1BBZkpUTWw2TEx5ZlBqWFNhTm1Mcld6UnhqYWQ3?=
 =?utf-8?B?bWJjVnNJakw5ZHAzNEtER3NtdlIwWDJNMHY2dTZ3cFNvSk9icXNmMWdCS1hQ?=
 =?utf-8?B?clJ2d0RiNEtSS2NqaEdRdy9XcFFNZGFYeFB1Um00ZHFWWWYwdklQTUJEN3Nr?=
 =?utf-8?B?VzlKVGx4Y3NKT29WRXRwc21hQ3FHemszZnpPMys4RDlZR0R5OUJjdUpmbnc3?=
 =?utf-8?B?d2N0YVdyYTVjWlJMM0ZsMHFPaDJJZ2x2d0dkYWRHaThFeml2NTJpcm9HQ3d6?=
 =?utf-8?B?enpLdURySFV0RmtwWm1CZVAzR3Iwc091cDhNdHRWcGVxbUE1SEkxVU1uenNo?=
 =?utf-8?B?RFl5ay95QmdQMkdpYnI1WE50UnB4dTJmd21nS1BmQW1LRjRZcWJDQzNUSk9C?=
 =?utf-8?B?V3NkZ1dMdG5zM0JnUk5iRVdHUXRwQ08zQWg4WTF4VzhRWmlZV3hQNis3TEU1?=
 =?utf-8?B?S1RKRGtzNFNlUGt3UC9SN0FXV3JjRGZsQ3p0cW80YnRRS3kyZUpvbGZIQlFO?=
 =?utf-8?B?Y29WSjA1S3Nmdm9lQ2ZGWjRMd0lib0xzajNYNHhOd3hDdmRkRXN6MGdna1lB?=
 =?utf-8?B?VkhWdVBFSkg5Z1FKRHZ4b3VXV2hUMTJOU0dHQ3RzMCtHRHJadXJ6dHRQTG1T?=
 =?utf-8?B?RlZmajNnbFpjeVcwVlhhRGEzbW5RVEQwSlRwM3BXS2g5QkhjL3BXbWpVM2FD?=
 =?utf-8?B?dWJBR2ZKRWFpVDFCYk5vK3NDTmRJM2NUYktNMHlOM3ZWS3Zmb3hiQmlVK1pI?=
 =?utf-8?B?U1VzV3NTSGtqaGRySlgzdytqQWJISzFYK2JiWmcyRy9wVjNLRzlNczNYbTAz?=
 =?utf-8?Q?o7dFwvID/C4=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB7111.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9923
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	9aa409b7-2cf1-4006-5b22-08ddb211d8d2
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|14060799003|36860700013|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzh4Z1VYVkZxNWpxWjhJSXNGdXRRQ2wyWTdBazNseDNhdnEvRnFPWnFFaGcv?=
 =?utf-8?B?aE95VmNTZjBZbEFoenBzV0NDU1RHcTA2S2hsSTVNWWZod3dXeEl3R1lBUnZ5?=
 =?utf-8?B?eGRZMHBRSnM1azU0WU9icHd2MTRGOVdCYmVxdG9vK2M3ODlGRzhaM3paQTRo?=
 =?utf-8?B?SHptMFpnampvU3Z6em5oRVRoRWM5VTkrQ1BJMEJLQmZra2tHdU9BU2lCbElK?=
 =?utf-8?B?c1NkWklzc1h3dXdpZkpPTFpDdXliUEJZUTNCVnZhZkZmZGNZWndZQXNiMVVT?=
 =?utf-8?B?Q1hLbGFPcWhiNk5SREpHY0lvVDNVcmQyN3gvQ2NqUDBsdnhrbjVhclkydlN6?=
 =?utf-8?B?d3BDdUVXQ21NZGVEbTB2K1FiWGxiZ29KVXNka1NWUy96Y2JHNmMxeHB4Z2ZQ?=
 =?utf-8?B?Q3lJdmRVNm9YdXBhN3FtK2Q3RTdRdzVmMHJNWW1TTXZJUVlwUUIvN1pnRVBa?=
 =?utf-8?B?d1VNRGNkVTRYK3hRb2xVU1Q2VmlkWDRCanM2SWVpM2M1aTdlQjFlYUVqd0Mx?=
 =?utf-8?B?L1BVOG9Xd0lDdEFzek9VN2d3NU5CdDNkdWc0N1EwbDl5ZnluRUJEeDg3eU8z?=
 =?utf-8?B?RGFPbFVvV3RtSm9rZURwZ21aYjFoK0FLckYxV3VGS0QzTkVicHZsZ0FiSjRN?=
 =?utf-8?B?dXFUUTZydVpuSVNHeXhqSHNFOFpIVXAzOE90Yy9tZFFVRVZLeHJPQ3lkaW9H?=
 =?utf-8?B?RWo0RTREYmxlS0tOQXkrVUZGN1lIWS9sN0krcHBDVHZsdFdMcGgvTThTYmlQ?=
 =?utf-8?B?cTVmNVZhYjVUN2dXRklxZVArZittRDEzdmNuNzRqWDlRYlh5ZCtGS1JYdE85?=
 =?utf-8?B?aXZnY05KMjhtOXhUbllNMTJrbERxNFhDc0NFZ3kwZGV4S2EzdU54SkpRZG1k?=
 =?utf-8?B?cU8vL3FBYjI5d2llRWJ6L2VyclFGTjN5OFZWeGU0VGltaWJqNUhZSFRDSVZC?=
 =?utf-8?B?djFGS0l1VGVHMmkrTWxlTFJQSlltVm1KKzVPZnlpU01HSU5BL2ozM1BaSWxL?=
 =?utf-8?B?R0FEM0pOM3dnT1UrTk1WOFkzQnAwUmw0YVZsQ2R0VTlndU5BZFBMSGhGd1JO?=
 =?utf-8?B?T01wb0JJK2wzMTFtWndjTVR5Y3dCRzN4VmUxVGFQRjU3U3RENXhndUtHalVG?=
 =?utf-8?B?SFowb1AwNm9LNHNEemtob0RCdFluOXBuL3ZVNGFTN0NTbnlPQysrUHRGY09h?=
 =?utf-8?B?Yk42UTIrVFQrZ0trdEQySHRaWXVEalZheklSK2prQk9yWjZRSzlvT1AvTXl0?=
 =?utf-8?B?ZldzcGRnM052Q1krUnRweTcxYWF0T3lOeDBwVXIwaEo4NjFEdVBKN2x1MCtB?=
 =?utf-8?B?SVFHOTJXb284NDZJOEpEN3RDQzM3UnB6REI2TFYranVrc1Z1VzlDV3pIS0Vx?=
 =?utf-8?B?TzJreUhpeXpsVkZwQUhvMmtoTlVHcmJVMHJnVWFYN0VSMEljdnJyKzVzU2Nj?=
 =?utf-8?B?dG1lck54WllUaDh0dmJ1eldjVnVwcjFiQ1hteGtDV2hCSjlXL0pscmdTQlZU?=
 =?utf-8?B?ZzRRNGVrdHFnRkpmKzMyYVVLUzNlaUVaOGZoRE5MbDFLbUhLcnVxNlZVWm1h?=
 =?utf-8?B?MGZuNlh1c0VqbXZnTW9DeXRHcmtlZzlLWnlqeEVyUFh6SFljaDJzNGt5Q0dR?=
 =?utf-8?B?d1p1ZnVuOVNlc3FDWEFQMjdvSzBxNTltYU5tQkwwS3NVamFqQzBwVGJoUDUv?=
 =?utf-8?B?VDF5MGtMTkVCYWVZdTNnQjN2a1hBbDNqVUZkZmdkOUpwaXhHZmJtK1JZUDNm?=
 =?utf-8?B?NzFKekdMN0xPWTh4bFVVVGdYem41d0M5QkJxSjhCNDhJOC9hNHArdWpaUld1?=
 =?utf-8?B?UnNHS014MGluaDFNVHZvM1Q2ZVF3S09oL3FBdW9ER0p3S1A1UjFYb0tmeDhn?=
 =?utf-8?B?V0tsQ2xXdVY3UFhhMW5CRlVnRWNHbVBmMVBJWVcvUUZ4dS84RG5CcXdzUnda?=
 =?utf-8?B?aVNMVHBHNXI3UE1mK1A0OS8zc0RjM0dtRDI1dE1TTmZacjE4amZBRytOMzVl?=
 =?utf-8?B?bEMrTGRYNllLWExYZUZnUC9JOWFQWXlQczRYdlJRcWY2RngzK0tZRWZxMzYy?=
 =?utf-8?Q?XGgQj7?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(14060799003)(36860700013)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 04:53:42.1970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c681923c-98eb-4f39-94c2-08ddb211ed5e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7721


On 21/06/25 11:25 pm, Donet Tom wrote:
> On Fri, Jun 20, 2025 at 08:15:25PM +0530, Dev Jain wrote:
>> On 19/06/25 1:53 pm, Donet Tom wrote:
>>> On Wed, Jun 18, 2025 at 08:13:54PM +0530, Dev Jain wrote:
>>>> On 18/06/25 8:05 pm, Lorenzo Stoakes wrote:
>>>>> On Wed, Jun 18, 2025 at 07:47:18PM +0530, Dev Jain wrote:
>>>>>> On 18/06/25 7:37 pm, Lorenzo Stoakes wrote:
>>>>>>> On Wed, Jun 18, 2025 at 07:28:16PM +0530, Dev Jain wrote:
>>>>>>>> On 18/06/25 5:27 pm, Lorenzo Stoakes wrote:
>>>>>>>>> On Wed, Jun 18, 2025 at 05:15:50PM +0530, Dev Jain wrote:
>>>>>>>>> Are you accounting for sys.max_map_count? If not, then you'll be hitting that
>>>>>>>>> first.
>>>>>>>> run_vmtests.sh will run the test in overcommit mode so that won't be an issue.
>>>>>>> Umm, what? You mean overcommit all mode, and that has no bearing on the max
>>>>>>> mapping count check.
>>>>>>>
>>>>>>> In do_mmap():
>>>>>>>
>>>>>>> 	/* Too many mappings? */
>>>>>>> 	if (mm->map_count > sysctl_max_map_count)
>>>>>>> 		return -ENOMEM;
>>>>>>>
>>>>>>>
>>>>>>> As well as numerous other checks in mm/vma.c.
>>>>>> Ah sorry, didn't look at the code properly just assumed that overcommit_always meant overriding
>>>>>> this.
>>>>> No problem! It's hard to be aware of everything in mm :)
>>>>>
>>>>>>> I'm not sure why an overcommit toggle is even necessary when you could use
>>>>>>> MAP_NORESERVE or simply map PROT_NONE to avoid the OVERCOMMIT_GUESS limits?
>>>>>>>
>>>>>>> I'm pretty confused as to what this test is really achieving honestly. This
>>>>>>> isn't a useful way of asserting mmap() behaviour as far as I can tell.
>>>>>> Well, seems like a useful way to me at least : ) Not sure if you are in the mood
>>>>>> to discuss that but if you'd like me to explain from start to end what the test
>>>>>> is doing, I can do that : )
>>>>>>
>>>>> I just don't have time right now, I guess I'll have to come back to it
>>>>> later... it's not the end of the world for it to be iffy in my view as long as
>>>>> it passes, but it might just not be of great value.
>>>>>
>>>>> Philosophically I'd rather we didn't assert internal implementation details like
>>>>> where we place mappings in userland memory. At no point do we promise to not
>>>>> leave larger gaps if we feel like it :)
>>>> You have a fair point. Anyhow a debate for another day.
>>>>
>>>>> I'm guessing, reading more, the _real_ test here is some mathematical assertion
>>>>> about layout from HIGH_ADDR_SHIFT -> end of address space when using hints.
>>>>>
>>>>> But again I'm not sure that achieves much and again also is asserting internal
>>>>> implementation details.
>>>>>
>>>>> Correct behaviour of this kind of thing probably better belongs to tests in the
>>>>> userland VMA testing I'd say.
>>>>>
>>>>> Sorry I don't mean to do down work you've done before, just giving an honest
>>>>> technical appraisal!
>>>> Nah, it will be rather hilarious to see it all go down the drain xD
>>>>
>>>>> Anyway don't let this block work to fix the test if it's failing. We can revisit
>>>>> this later.
>>>> Sure. @Aboorva and Donet, I still believe that the correct approach is to elide
>>>> the gap check at the crossing boundary. What do you think?
>>>>
>>> One problem I am seeing with this approach is that, since the hint address
>>> is generated randomly, the VMAs are also being created at randomly based on
>>> the hint address.So, for the VMAs created at high addresses, we cannot guarantee
>>> that the gaps between them will be aligned to MAP_CHUNK_SIZE.
>>>
>>> High address VMAs
>>> -----------------
>>> 1000000000000-1000040000000 r--p 00000000 00:00 0
>>> 2000000000000-2000040000000 r--p 00000000 00:00 0
>>> 4000000000000-4000040000000 r--p 00000000 00:00 0
>>> 8000000000000-8000040000000 r--p 00000000 00:00 0
>>> e80009d260000-fffff9d260000 r--p 00000000 00:00 0
>>>
>>> I have a different approach to solve this issue.
>> It is really weird that such a large amount of VA space
>> is left between the two VMAs yet mmap is failing.
>>
>>
>>
>> Can you please do the following:
>> set /proc/sys/vm/max_map_count to the highest value possible.
>> If running without run_vmtests.sh, set /proc/sys/vm/overcommit_memory to 1.
>> In validate_complete_va_space:
>>
>> if (start_addr >= HIGH_ADDR_MARK && found == false) {
>> 	found = true;
>> 	continue;
>> }
>
> Thanks Dev for the suggestion. I set max_map_count and set overcommit
> memory to 1, added this code change as well, and then tried. Still, the
> test is failing
>
>> where found is initialized to false. This will skip the check
>> for the boundary.
>>
>> After this can you tell whether the test is still failing.
>>
>> Also can you give me the complete output of proc/pid/maps
>> after putting a sleep at the end of the test.
>>
>
> on powerpc support DEFAULT_MAP_WINDOW is 128TB and with
> total address space size is 4PB With hint it can map upto
> 4PB. Since the hint addres is random in this test random hing VMAs
> are getting created. IIUC this is expected only.
>
>
> 10000000-10010000 r-xp 00000000 fd:05 134226638                          /home/donet/linux/tools/testing/selftests/mm/virtual_address_range
> 10010000-10020000 r--p 00000000 fd:05 134226638                          /home/donet/linux/tools/testing/selftests/mm/virtual_address_range
> 10020000-10030000 rw-p 00010000 fd:05 134226638                          /home/donet/linux/tools/testing/selftests/mm/virtual_address_range
> 30000000-10030000000 r--p 00000000 00:00 0                               [anon:virtual_address_range]
> 10030770000-100307a0000 rw-p 00000000 00:00 0                            [heap]
> 1004f000000-7fff8f000000 r--p 00000000 00:00 0                           [anon:virtual_address_range]
> 7fff8faf0000-7fff8fe00000 rw-p 00000000 00:00 0
> 7fff8fe00000-7fff90030000 r-xp 00000000 fd:00 792355                     /usr/lib64/libc.so.6
> 7fff90030000-7fff90040000 r--p 00230000 fd:00 792355                     /usr/lib64/libc.so.6
> 7fff90040000-7fff90050000 rw-p 00240000 fd:00 792355                     /usr/lib64/libc.so.6
> 7fff90050000-7fff90130000 r-xp 00000000 fd:00 792358                     /usr/lib64/libm.so.6
> 7fff90130000-7fff90140000 r--p 000d0000 fd:00 792358                     /usr/lib64/libm.so.6
> 7fff90140000-7fff90150000 rw-p 000e0000 fd:00 792358                     /usr/lib64/libm.so.6
> 7fff90160000-7fff901a0000 r--p 00000000 00:00 0                          [vvar]
> 7fff901a0000-7fff901b0000 r-xp 00000000 00:00 0                          [vdso]
> 7fff901b0000-7fff90200000 r-xp 00000000 fd:00 792351                     /usr/lib64/ld64.so.2
> 7fff90200000-7fff90210000 r--p 00040000 fd:00 792351                     /usr/lib64/ld64.so.2
> 7fff90210000-7fff90220000 rw-p 00050000 fd:00 792351                     /usr/lib64/ld64.so.2
> 7fffc9770000-7fffc9880000 rw-p 00000000 00:00 0                          [stack]
> 1000000000000-1000040000000 r--p 00000000 00:00 0                        [anon:virtual_address_range]
> 2000000000000-2000040000000 r--p 00000000 00:00 0                        [anon:virtual_address_range]
> 4000000000000-4000040000000 r--p 00000000 00:00 0                        [anon:virtual_address_range]
> 8000000000000-8000040000000 r--p 00000000 00:00 0                        [anon:virtual_address_range]
> eb95410220000-fffff90220000 r--p 00000000 00:00 0                        [anon:virtual_address_range]
>
>
>
>
> If I give the hint address serially from 128TB then the address
> space is contigous and gap is also MAP_SIZE, the test is passing.
>
> 10000000-10010000 r-xp 00000000 fd:05 134226638                          /home/donet/linux/tools/testing/selftests/mm/virtual_address_range
> 10010000-10020000 r--p 00000000 fd:05 134226638                          /home/donet/linux/tools/testing/selftests/mm/virtual_address_range
> 10020000-10030000 rw-p 00010000 fd:05 134226638                          /home/donet/linux/tools/testing/selftests/mm/virtual_address_range
> 33000000-10033000000 r--p 00000000 00:00 0                               [anon:virtual_address_range]
> 10033380000-100333b0000 rw-p 00000000 00:00 0                            [heap]
> 1006f0f0000-10071000000 rw-p 00000000 00:00 0
> 10071000000-7fffb1000000 r--p 00000000 00:00 0                           [anon:virtual_address_range]
> 7fffb15d0000-7fffb1800000 r-xp 00000000 fd:00 792355                     /usr/lib64/libc.so.6
> 7fffb1800000-7fffb1810000 r--p 00230000 fd:00 792355                     /usr/lib64/libc.so.6
> 7fffb1810000-7fffb1820000 rw-p 00240000 fd:00 792355                     /usr/lib64/libc.so.6
> 7fffb1820000-7fffb1900000 r-xp 00000000 fd:00 792358                     /usr/lib64/libm.so.6
> 7fffb1900000-7fffb1910000 r--p 000d0000 fd:00 792358                     /usr/lib64/libm.so.6
> 7fffb1910000-7fffb1920000 rw-p 000e0000 fd:00 792358                     /usr/lib64/libm.so.6
> 7fffb1930000-7fffb1970000 r--p 00000000 00:00 0                          [vvar]
> 7fffb1970000-7fffb1980000 r-xp 00000000 00:00 0                          [vdso]
> 7fffb1980000-7fffb19d0000 r-xp 00000000 fd:00 792351                     /usr/lib64/ld64.so.2
> 7fffb19d0000-7fffb19e0000 r--p 00040000 fd:00 792351                     /usr/lib64/ld64.so.2
> 7fffb19e0000-7fffb19f0000 rw-p 00050000 fd:00 792351                     /usr/lib64/ld64.so.2
> 7fffc5470000-7fffc5580000 rw-p 00000000 00:00 0                          [stack]
> 800000000000-2aab000000000 r--p 00000000 00:00 0                         [anon:virtual_address_range]
>
>

Thank you for this output. I can't wrap my head around why this behaviour changes
when you generate the hint sequentially. The mmap() syscall is supposed to do the
following (irrespective of high VA space or not) - if the allocation at the hint
addr succeeds, then all is well, otherwise, do a top-down search for a large
enough gap. I am not aware of the nuances in powerpc but I really am suspecting
a bug in powerpc mmap code. Can you try to do some tracing - which function
eventually fails to find the empty gap?

Through my limited code tracing - we should end up in slice_find_area_topdown,
then we ask the generic code to find the gap using vm_unmapped_area. So I
suspect something is happening between this, probably slice_scan_available().

>
>>>   From 0 to 128TB, we map memory directly without using any hint. For the range above
>>> 256TB up to 512TB, we perform the mapping using hint addresses. In the current test,
>>> we use random hint addresses, but I have modified it to generate hint addresses linearly
>>> starting from 128TB.
>>>
>>> With this change:
>>>
>>> The 0–128TB range is mapped without hints and verified accordingly.
>>>
>>> The 128TB–512TB range is mapped using linear hint addresses and then verified.
>>>
>>> Below are the VMAs obtained with this approach:
>>>
>>> 10000000-10010000 r-xp 00000000 fd:05 135019531
>>> 10010000-10020000 r--p 00000000 fd:05 135019531
>>> 10020000-10030000 rw-p 00010000 fd:05 135019531
>>> 20000000-10020000000 r--p 00000000 00:00 0
>>> 10020800000-10020830000 rw-p 00000000 00:00 0
>>> 1004bcf0000-1004c000000 rw-p 00000000 00:00 0
>>> 1004c000000-7fff8c000000 r--p 00000000 00:00 0
>>> 7fff8c130000-7fff8c360000 r-xp 00000000 fd:00 792355
>>> 7fff8c360000-7fff8c370000 r--p 00230000 fd:00 792355
>>> 7fff8c370000-7fff8c380000 rw-p 00240000 fd:00 792355
>>> 7fff8c380000-7fff8c460000 r-xp 00000000 fd:00 792358
>>> 7fff8c460000-7fff8c470000 r--p 000d0000 fd:00 792358
>>> 7fff8c470000-7fff8c480000 rw-p 000e0000 fd:00 792358
>>> 7fff8c490000-7fff8c4d0000 r--p 00000000 00:00 0
>>> 7fff8c4d0000-7fff8c4e0000 r-xp 00000000 00:00 0
>>> 7fff8c4e0000-7fff8c530000 r-xp 00000000 fd:00 792351
>>> 7fff8c530000-7fff8c540000 r--p 00040000 fd:00 792351
>>> 7fff8c540000-7fff8c550000 rw-p 00050000 fd:00 792351
>>> 7fff8d000000-7fffcd000000 r--p 00000000 00:00 0
>>> 7fffe9c80000-7fffe9d90000 rw-p 00000000 00:00 0
>>> 800000000000-2000000000000 r--p 00000000 00:00 0    -> High Address (128TB to 512TB)
>>>
>>> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
>>> index 4c4c35eac15e..0be008cba4b0 100644
>>> --- a/tools/testing/selftests/mm/virtual_address_range.c
>>> +++ b/tools/testing/selftests/mm/virtual_address_range.c
>>> @@ -56,21 +56,21 @@
>>>    #ifdef __aarch64__
>>>    #define HIGH_ADDR_MARK  ADDR_MARK_256TB
>>> -#define HIGH_ADDR_SHIFT 49
>>> +#define HIGH_ADDR_SHIFT 48
>>>    #define NR_CHUNKS_LOW   NR_CHUNKS_256TB
>>>    #define NR_CHUNKS_HIGH  NR_CHUNKS_3840TB
>>>    #else
>>>    #define HIGH_ADDR_MARK  ADDR_MARK_128TB
>>> -#define HIGH_ADDR_SHIFT 48
>>> +#define HIGH_ADDR_SHIFT 47
>>>    #define NR_CHUNKS_LOW   NR_CHUNKS_128TB
>>>    #define NR_CHUNKS_HIGH  NR_CHUNKS_384TB
>>>    #endif
>>> -static char *hint_addr(void)
>>> +static char *hint_addr(int hint)
>>>    {
>>> -       int bits = HIGH_ADDR_SHIFT + rand() % (63 - HIGH_ADDR_SHIFT);
>>> +       unsigned long addr = ((1UL << HIGH_ADDR_SHIFT) + (hint * MAP_CHUNK_SIZE));
>>> -       return (char *) (1UL << bits);
>>> +       return (char *) (addr);
>>>    }
>>>    static void validate_addr(char *ptr, int high_addr)
>>> @@ -217,7 +217,7 @@ int main(int argc, char *argv[])
>>>           }
>>>           for (i = 0; i < NR_CHUNKS_HIGH; i++) {
>>> -               hint = hint_addr();
>>> +               hint = hint_addr(i);
>>>                   hptr[i] = mmap(hint, MAP_CHUNK_SIZE, PROT_READ,
>>>                                  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>>>
>>>
>>>
>>> Can we fix it this way?

