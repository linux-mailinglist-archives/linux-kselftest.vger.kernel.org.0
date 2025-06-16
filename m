Return-Path: <linux-kselftest+bounces-35114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAD0ADB6E7
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 18:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB69166A03
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 16:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B872874FB;
	Mon, 16 Jun 2025 16:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hP+Ag+76";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hP+Ag+76"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011066.outbound.protection.outlook.com [40.107.130.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0063286D74;
	Mon, 16 Jun 2025 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.66
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750091363; cv=fail; b=JpF8fQh6HplXtS6W9/6Aa6LcgDRUvm8dAkg7AF5eOcFwyH0GK5PhktmS45c2+bObgwoNxKLsfS0KRc4yRveQqIwPWGrTWQ6Ua03UeSYhoac14geDEdfEIwPqejegRgOPs6pCu2CH5AS/NtXfb63DjdNyDVCoKQ40gmMg2bl39nI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750091363; c=relaxed/simple;
	bh=2VQ7qdX7lxOis6RXZJtIe0/RZ5pFvXwJ8SaVDUZ34jc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nrED/KxMm3VM2GknbWkFgpCJi7QESfQqPSeDr1uJtbOmOlC2SEajuFqXHzqk0JSPL3ZbvDctJekwdAY4AdrsLS1vp1VtfUaGjVh9zX+n54zA/FxnlRUec5cv4GRlhsBpvlRbbUHnmbXuGL2hs1mXZPUKR520+RmOkmQ/nxlyG8Q=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hP+Ag+76; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hP+Ag+76; arc=fail smtp.client-ip=40.107.130.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=QDELY28PeYDsDiE2X5ocXV89tg3DcagZzEM2c/ry0ntvptRt+TlMYnCXc1z8oHZyboifGmwKw3FpFou7Kt5/uF2Z0YbMgskTXTzKzfGVwuYqG4G+LEKgRwTCzio2PqpXZJSQtDwAY1EzQp9J54uVeCy8OwchHtopvDCjqCpFE2yqjv2U9zhKmh+gSSonAu7Wg7jvzVZ/U6eQ9Yzufk2H+lXuI0zJxXJP9Kzduj0p5jpP9JIhpBKYfw0OfEmggnO5d2MzArfXoGsIcq+XM5EkOqwdtZM6SQMLw0C+hVqY7RDsMTRpNJaK9QPdsFDNnpFqAgI6p+xKa+3ZrTQcbX+9gw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvWcKNVFIsWyBeu0jaF/wI/AHAgeJ6YiBvmkBnuYy/w=;
 b=v6tnKQM739cbytDDwgdqiHhdwNOPKEwAWwgjHIerSxbJZ7CycRjAM5kiFq5FCqaEfKODBOzTXm8hOYYuv2m9/qnMjQ8Ludt2L+c2i9oZ66eWGd9DyNt52A/J2wSiSrdhLDuSb+LwBzZdwgSmDKh7yLuGX5XI9NGlJYeOOF+dC3Uv3ZGzoXxr7f5xwz9Mq6FGZs/yJyX6f8+ByCBwpGar10pn2tCEl7xVcu6/Tl7y3+woLzt7seOgFJc8VLeFqacYr/cj5SeRiNMNIYb8J/k6erlsYewR6zFV0Y7SmZQjnUj8Fc8Ypg2ygwfEsTTsE9G00ViL/ESbvEe3CpMzQLnOxA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvWcKNVFIsWyBeu0jaF/wI/AHAgeJ6YiBvmkBnuYy/w=;
 b=hP+Ag+765Z2+JK7TWpA1hQmHEua96X4Mt7xnEerhR/oTUGvIm8j2Raqy1ZmaMAE37rPYWu5T3FTyGMSKU3FUDBPpryHqGquHxkCZJtQcs76Xq2uYfga3n17qZN9vokG2ctVv2ThZLkBDm3Cul8RxAC1iwGqSVbIV6OIpmm47Emw=
Received: from DU2PR04CA0087.eurprd04.prod.outlook.com (2603:10a6:10:232::32)
 by DB4PR08MB9310.eurprd08.prod.outlook.com (2603:10a6:10:3f6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 16:29:16 +0000
Received: from DB1PEPF000509E6.eurprd03.prod.outlook.com
 (2603:10a6:10:232:cafe::1a) by DU2PR04CA0087.outlook.office365.com
 (2603:10a6:10:232::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.29 via Frontend Transport; Mon,
 16 Jun 2025 16:29:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E6.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Mon, 16 Jun 2025 16:29:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NibinJQ6gc70dwExB1udIjxdxMf2zYbNf6sLbadWqfTWjJSoJUXkS5spo2ypoGEknLhZBUIQMpXDe7ZWvrX9kR8Dma/oszRR+rcyaRyDf0VqWP1nMLDQwimC8xODmIf/lMZhtlTwIL/5/VZSNkJr6CNQMnT5xDoKczn3hkfGwMpo0V1gyx9eMDOXnnlwAcvpgp621t5ttVcCEnbZu6kPcPYcfN61a6jhUCU7E7OAnL1WiwcN0+KNZSlkse9ItUmG2CiqGlCjeXPd412vARyDKN9cfcqVvK0Pwzkk0UjSTkcl4jbDm1FLYsnB6EbYeYpGMBSakuWeg06Nc+1CWf1TJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvWcKNVFIsWyBeu0jaF/wI/AHAgeJ6YiBvmkBnuYy/w=;
 b=SNpQBIbaYnTpOF33i5WMRNY71s9T4cl8ig78XNlpOcIEI/nRIXUpAPdj66Zfu21mqBpcP2mj4brHK1RZMyV7nryXu/G/vtMzrIiPL6ZrVAmyu2uQqqirSkEFXsqNGjgbrhwXc3TadgKDM9M7IW9PwZ23efrTAfiPeuaJj76Far4Pu42TYdGDopRZVbVYHV4b8e4LtnBQIJ7mp54T5x4bVONxrjz1sNARS9NIFi11In8+MEbsJuVe3J7intTq+hsQKRmTBv/anAAAbNv+sVKCcK7kApvt+u3JGsJxOhGV8pntQ+UBojwqkqWmt8Phj5ssvOq1VLfJQv8D4czAX3FkXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvWcKNVFIsWyBeu0jaF/wI/AHAgeJ6YiBvmkBnuYy/w=;
 b=hP+Ag+765Z2+JK7TWpA1hQmHEua96X4Mt7xnEerhR/oTUGvIm8j2Raqy1ZmaMAE37rPYWu5T3FTyGMSKU3FUDBPpryHqGquHxkCZJtQcs76Xq2uYfga3n17qZN9vokG2ctVv2ThZLkBDm3Cul8RxAC1iwGqSVbIV6OIpmm47Emw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by GVXPR08MB10575.eurprd08.prod.outlook.com (2603:10a6:150:15a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 16:28:42 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%4]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 16:28:42 +0000
Message-ID: <063206d1-9f60-44b0-a8e6-77b49ba4a871@arm.com>
Date: Mon, 16 Jun 2025 21:58:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] selftests/mm : fix test_prctl_fork_exec failure
To: Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, shuah@kernel.org,
 pfalcato@suse.de, david@redhat.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com,
 baohua@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, donettom@linux.ibm.com, ritesh.list@gmail.com
References: <20250616160632.35250-1-aboorvad@linux.ibm.com>
 <20250616160632.35250-4-aboorvad@linux.ibm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250616160632.35250-4-aboorvad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0162.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::17) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|GVXPR08MB10575:EE_|DB1PEPF000509E6:EE_|DB4PR08MB9310:EE_
X-MS-Office365-Filtering-Correlation-Id: db0d1c0b-0426-4923-21da-08ddacf2ef23
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?QWppN3Z2amlOWFM1cUVIc1dKNGROYmFtd295eUVNL1NNWjhqak1FQVIxY1JN?=
 =?utf-8?B?cWI3M1FuSHNic1UwVnQ4RUx4ak9ValUxSFg4dGpGOU5TSVUwdFhmQ2I2YzVy?=
 =?utf-8?B?V3dDcmlWTzkyaTVlK09icGYwY2hRMlJlN0FVVDBNRFFWNlk4UUtrdWJkK0NT?=
 =?utf-8?B?Q2k2bHlCaWFwZklGSVNQT2krdVNoNzlIQjNpNGU2dTF6cjVYWk9ISDlzdW5x?=
 =?utf-8?B?Vy9jMnR6YXRleCtXM1pORkFmOXNlaUtVa25OakkvNmxuVlF3T1NQdXN3UDY4?=
 =?utf-8?B?NmdLMW95TDIxR2kxWHFhRkNEMlVqS0FFWmFUTzIwMXVkNmRCWmZyTGpSSFg4?=
 =?utf-8?B?RmpXK1p6eWxWN1c0akF2OVkwSVV4UjVVVnJpbG5RbU1OeUVzSm5oa0NEc1Fj?=
 =?utf-8?B?dWFnQUQzbTZQS2NTQzVZbXd3Y3VON0VaSGdmVEVJS3V2S1F4UElEa3pGUk9W?=
 =?utf-8?B?ZjliMDBuL0ZkZStWa2sxZ3lSTElUUlhJZUppM2VBVzY4OTBJMzZDblpUQkZw?=
 =?utf-8?B?eTVicEFRcGhLSmRJOFNxaVV2R1FDcUExdjc3TzlEQlJDREpNWnFZZ1AwRHNv?=
 =?utf-8?B?ZmJLM254OWtmemorNnF2dHJSa3BGWVRWMlpJcWpFQ0JtVm9iQm8wNE9yeHRn?=
 =?utf-8?B?aVFieHBPZE5WRUxyLytkcElHa21iS2RUeWhDTW9Dd296ajZuZm5aMURXSGRH?=
 =?utf-8?B?V2pYUG9DTUhKZHFGeEF5cXUxU0tJS1g5WWdzL09YSXdWUTl2M1QvNkNyeVp6?=
 =?utf-8?B?MGlLV05SZ0J6TE5aMk1menN3UVFacHByZWxQTjFtdFIvUlJjWGdFUnVXSVpt?=
 =?utf-8?B?aTFpUTFiK1A0UXRVUitIMktRUS81K1o5cVRSVXdTUU95d3RCWU9xQkp2SWth?=
 =?utf-8?B?dHl3THlLeGFNeDRoNU1VdTIvTVJsMmFLaTR6bmdyMFZUQTdGdUwxYXRRWXM2?=
 =?utf-8?B?emx0QUxYcjZKdHFLTTdJV0ZlZ2VobUJKSDBnQ1FWYWtVK3FBVWRJMEVMQ1d5?=
 =?utf-8?B?Qi9hL3dtSlNkazR6VjhlYkl6bGxtMVpqa1V4a0JKNS8rbzdzWDZGNm1qei83?=
 =?utf-8?B?SmhqWlV1b2szZnBIdFJlQ0RaVUZkbHBXNysxWFVjVVFlVHBRazgweVd1ZU8x?=
 =?utf-8?B?RGxQRkJlQy9KOUx6MDNJUkpDYy9QQzIxeFJSbElERG42aTlrYmJsNjVabjZZ?=
 =?utf-8?B?QU9QQkhUU0hHeFlsT2xTMXMrYXpWUDlSN3Q4REhVM3JIRTRmVnpRT3ZxRW4z?=
 =?utf-8?B?eHgxVFRaYm1yNXlrb3VqUWV1d25UUU9xRnh4cVluekorM1B0QndNdk9TL0Ny?=
 =?utf-8?B?c0VaZU9qVmpoUmJMc2VheTYwQklHWWR2b1BNNFRhelN6TDRqVHAySjd1V2gz?=
 =?utf-8?B?MXorZjNaWU9rYy9pdDN2Q29IZldXcjdLcWFTRHVUQVBNTW54USs2dDZKZGYw?=
 =?utf-8?B?dFdRYW5BYSt3L0J6cWl6YmYraWNEb09ub0pQRUFaVTVsWTBLMUdzb252VWpD?=
 =?utf-8?B?UXRYM0wvS2k4c1Jma0FZUmE1TzNzWEpoZXErUm1FamNYNmw0MldJTmx2QXFG?=
 =?utf-8?B?Qys4c0sxR2F5ZFVEY1JRQkVPRTZrNnAzYWJudTRZRTVHT2Focmc3S1RLQzBq?=
 =?utf-8?B?TEtlUFptZTAwWUhIem1SdVR2SHlyakhCb05DVTR1SEhyMGlKNjA3aldYemQz?=
 =?utf-8?B?bWZXZThRdFV1ZmlySUtFYnZQQTZpdFNJSHFvUGFnVkNXS3VmTXVZZFlXV09q?=
 =?utf-8?B?REhnVWdITXhjOXVBL0VjTkZnb0dhMXNISjRnS3Q0TkNkNkFIYk5SUzBVMjdD?=
 =?utf-8?B?S3FQVFlTdnJKT2cxVHhKMzdlRXFOZGlSU0prU0huMjlud0tWa01XT2t0ZU5Y?=
 =?utf-8?B?TGVPdjYyMzM3Q1daajJJVDQrQmp5ZHFyWkpkY1BrWmNYeDFLV0xXNWY3ODFM?=
 =?utf-8?B?T1VBYU5ZWWxVa2tScnE2cWtRL1FUdjFrNFdVWloxQnVkU2paa3ovSDVzekZl?=
 =?utf-8?B?eStxQnpTMW13PT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10575
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E6.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	39b0e56c-83ca-4ba3-7ff3-08ddacf2dba0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|35042699022|1800799024|82310400026|14060799003|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjhxcDdCVENoeEx6cDRNeEdKaDgzeHQrNENBL2JSaVdsTW96UWozcjhIazZa?=
 =?utf-8?B?THE5czBTVjJSZERRd2ZraVdpRmt4OE9Od1VNY2RTS09kbEJQNHg0NFlZc0lY?=
 =?utf-8?B?QVBBRkhjTDN5OW9OYkRUczVsRlkyTWMyaTFxVFpiNHV3N1BVUExOYWJOS2ZC?=
 =?utf-8?B?Q3YyQkFocnplUE9hVVQ0bnIwVmgrUjA2b202bnl2RTFYeDBiQi9sVzB1Lzd6?=
 =?utf-8?B?VHFMeFhxZkxiQUcxUUhIYjd1SEpKalhkTkVmVEVtcjRVeXVzR25JeGJKcFlI?=
 =?utf-8?B?OGY0MUw0NlMxYW9pNFR4MFdvSytQOUhLN25zclJZSG15amd0NUg3TE1yZmJO?=
 =?utf-8?B?Nk82VkFqTC9BcDI2UDNFRmFCRWt4YzBsbHhESFByTGRWdjVuMGc3TjF5UFRX?=
 =?utf-8?B?aFQ1bGdHZittN1VibVlxd3hIMm1NaFZZT0Z3R1F6cGxuWUlodWx2NmpwUXdR?=
 =?utf-8?B?akFtODRPMHc1VW50amJlSVJZdFZZbGZ6RXdvTTdISFU2azhaMXhaUlkzRkg3?=
 =?utf-8?B?UFc3dVJtOFhReERodHY3c3lJdmpEb21VOTFNdHk2b1Vaa2hqYXFEVnpzZ1N5?=
 =?utf-8?B?SmNtNU01Q2I1S2dkb1J1VFplNi8yU3FraDcyU1ZlM1RUSkoyNEcyeUlmcEtM?=
 =?utf-8?B?TnRiYlArWEc1M0t5dFhpNjBlSm5RTjZ4L25MakZNYUhCbTVxd1hMWXE1bHFt?=
 =?utf-8?B?bCsxYW8zQVFCalJzZTdSd3pVeUo2NzY5c2dXMWdWWW9qRDhlUDZYbldDdDhE?=
 =?utf-8?B?S1lHSThGYW5FdG10NDF4NGl6bFNMZGpQSUJwSmhWZTBlT0hXZWZJUmhqOFl6?=
 =?utf-8?B?UmcxZVRNRkV5RDBRRFlqR0VOQzBnY2ZaeXgvUjZ1c2dmQTBPTHZxZDVnQ0Zs?=
 =?utf-8?B?S0txdzM2anp4WHIyUXQ3TU9tdHVnMFlKN2kyQlduR2hpWTVhdXJMTjVlN2tC?=
 =?utf-8?B?TElSWUdRemZnSjA2cGRqZVBQa013THNseDdsQzBMUVpVMTdhYWQwTHVXTE1m?=
 =?utf-8?B?YVhtQ3pJZWsybTJVaU9ObDVtbGZNY0FwZXBiY1dLNXNZbjJ1SXhaVmtGVEFV?=
 =?utf-8?B?eEZnVHR1VTVDaE9uR0JwZVo0eXRVajRKUWg3ZkhBUUlYelhVUmVlcmwyWXFU?=
 =?utf-8?B?ZUZySDZhL1h2d3liZDJsWnhWT3MvWXdJSlgxOGQ0VlV6TkFSNkRWWWlRblVY?=
 =?utf-8?B?U0xQU3U2dmlYeld2eSt2aVQwYlNUTXRybmZHWi9MNnovcnp1UjBXcGF6S01R?=
 =?utf-8?B?VXNLUHJ1K1h2R3lTd0RxNHFETGxvWDR3ejRmT0dXY1FjeitLUzFEWHliUklV?=
 =?utf-8?B?eFZpRGhEU1d5YnJEeVRYNWY2Nml2dTREckFoNS9sbXlLaFk5QTVEdDdKV1R5?=
 =?utf-8?B?aWl1NW5zcXJIdmZ3SzdLMnJPT0lhTHZ5bmFYMmZxSDJUQWJrMEhQZHFiOThE?=
 =?utf-8?B?Y0tpNkZ1dXZCbTdjd0d2eWdTWE1zNTFZdGVyaVpxMnp2dXpUUEcrUGVZQVpJ?=
 =?utf-8?B?TlJmdFRnV1FBU251RDlGdUhtTnl3TXUxZzIzSXJiTWo3T0NFTjU4VkxHOUU1?=
 =?utf-8?B?WjgyOW5jM0U2WDREOWJpMDFnaUlLZCtHandrdWZCT3pDdzBjTjhBRnB4emsw?=
 =?utf-8?B?aFRSaU5mQWdNVy9GN1p3d3hQOFNUbFE0c2lOeVh4U3BOU0FiZXVubjZVUElJ?=
 =?utf-8?B?TTVzRm93SmxPamxUeVhkQTMyUzBUMnpkbDFKc21abU80NGZ5UHplMEZNZFo2?=
 =?utf-8?B?N3AxeVBqQW1jTFR4TEs5TlY0OEpDUHRFeW82eG9WR2ozY1NVN09nVHV5NnBx?=
 =?utf-8?B?NmtUTmJpVFdmRU1sNlp0RXd5YUhCaWZYSDAzZHRqZlJsbnRSUEYyQ1lERlBV?=
 =?utf-8?B?YmhGbUpLcU85RlZiU0xmTFVaU0toK2cvKzhkRWdOSFR2ZDZUSzlXbGhBVGF1?=
 =?utf-8?B?M2dyS2xZZmhPZ1NtNzVaa21LamNYTXpoSmQ3QncxUzdHSmkybmlWdjRxNi9X?=
 =?utf-8?B?anVHclU4S043dnoxSFlKZ011QjFoR1lBZCtFcHRmdGIxSmZVL3QrWThsZTFl?=
 =?utf-8?B?YVpLZTRzQWgwY1hzNnZBUUNocTh2NHl2Uk1MQT09?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(35042699022)(1800799024)(82310400026)(14060799003)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 16:29:14.9616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db0d1c0b-0426-4923-21da-08ddacf2ef23
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E6.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9310


On 16/06/25 9:36 pm, Aboorva Devarajan wrote:
> From: Donet Tom <donettom@linux.ibm.com>
>
> execv argument is an array of pointers to null-terminated strings.
> In this patch we added NULL in the execv argument to fix the test
> failure.

Just a comment, how did this test suddenly start failing now? Also is a
fixes tag required? Clearly I am missing something.

> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---
>   tools/testing/selftests/mm/ksm_functional_tests.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
> index d7d3c22c077a..6ea50272a0ba 100644
> --- a/tools/testing/selftests/mm/ksm_functional_tests.c
> +++ b/tools/testing/selftests/mm/ksm_functional_tests.c
> @@ -579,7 +579,7 @@ static void test_prctl_fork_exec(void)
>   		return;
>   	} else if (child_pid == 0) {
>   		char *prg_name = "./ksm_functional_tests";
> -		char *argv_for_program[] = { prg_name, FORK_EXEC_CHILD_PRG_NAME };
> +		char *argv_for_program[] = { prg_name, FORK_EXEC_CHILD_PRG_NAME, NULL };
>   
>   		execv(prg_name, argv_for_program);
>   		return;

