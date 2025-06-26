Return-Path: <linux-kselftest+bounces-35831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04541AE9660
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 08:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6195176063
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 06:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B677235072;
	Thu, 26 Jun 2025 06:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FFTvhfhJ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FFTvhfhJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABED235362;
	Thu, 26 Jun 2025 06:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750919761; cv=fail; b=mh/NYyqXd/enLhElWW5tVCNdoQJVG9uYIAVyuBZwB69m0MqLva2nEmHSMS8+GY4xhdhCitub0/21W23oI7qLPrjH7uREf5YBKOthMwd7v4F8Km9uAgDBlQE5b817pP/RYUKdqmgp6upKXrMV1nbrelCcNf85q1VZvn0IjiLevuY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750919761; c=relaxed/simple;
	bh=SRSZvV0d8ZbU5F3h8hbt7mgAA9pDapUSF9CpEWhCiCo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IpBYEbqGycPXwLNac4eVkBoWbBvOLcGuT+ML/GLQZvadGncvDnO4qjnbQ0mxbFEIzV/kS63PAFkZjqDNwGq8iUa2HdTiy3+vf0gNqx69fOWY4oVZhUAHBQ7XOdrPdeNDhAayKJbQHSCP+PjVgggwVSyHGQnmvi2AUuNWnhmVgzg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FFTvhfhJ; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FFTvhfhJ; arc=fail smtp.client-ip=52.101.70.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=yjTW9duyYBjY1zWNagujcflt1eAKSom5xrj9gf6MhlntNHj+Pns7R1rY6kuURsocJqsEn5j19SPaXZvC3pF2q/DXzpjIC8w38LkGBUsrkbPnLxaYJD29Lncf3xfTi8ph5DLv3gt2HTvBKWCLJ44wn+bfIuquQBMEMouYfEoIX4jYtW/rcX/Fg0YbT5jk8xHXSqNctYkGdwEqvAWaKR7mt50QkJPHcwLN6R+EsHftAAuA8/CEatxMeEZPeSq3KYaDem7TKU4ksGW++4ZVJEwhTrb65WsHc7Vq7nXPwgJvm5mlHbonNzj0ht5cZ8ppswlKQEzu5o/6sDT/+CYyyX5hpQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/n8BgWanqAN+/s1x9bnYQOPYdLm32hcYNY3/HB9ZwI=;
 b=N6vyXj0V87/jiz85qY6oKSXO2rY01TyhynX/IHpNQudC8XoPou8TU2Cdl7KwCO07gr8n6+nMKDsoPF2ux+iI0MmZmC66hqk/5whjI5t1IkrKWeYwIzAgmw89xpc0T1BMIE7wW1FIhmkeTWTjqsOvDC9SNzCyIbUtiocVNPI/KMpDHmuTqwTeFacxZTbYj9Dm/MD548tH9XXHxLMNNnjXs4uVNEh4v3zPhBpwxTZuxdkfXmAk2HVepv3l7IDbEODb9iZ/HOG1G6tt3N1VFh6CMLClJamCOSKnsdtJ3nKtoFcHv5dS6UZP9ideBqgF9Zv0loYE3tah/rc5fhqgF+GCnQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/n8BgWanqAN+/s1x9bnYQOPYdLm32hcYNY3/HB9ZwI=;
 b=FFTvhfhJuExDALyuvG+j+oSjeFL8O05VPM/2ZmhAViqfWDlV6fyEzvcSxzVMIr+bxwWkNiPhUApfitGYUsyiJTALXJQ+LvDGZXOp/YuSVzbQNkMR3e7PbdtnOETElU0/kzZzuRTAEiDC6on9ZfpjRRDJVX9X90/I9lC/D5T38nc=
Received: from DU6P191CA0026.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::17)
 by PR3PR08MB5851.eurprd08.prod.outlook.com (2603:10a6:102:85::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Thu, 26 Jun
 2025 06:35:52 +0000
Received: from DB1PEPF000509E9.eurprd03.prod.outlook.com
 (2603:10a6:10:53f:cafe::13) by DU6P191CA0026.outlook.office365.com
 (2603:10a6:10:53f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.21 via Frontend Transport; Thu,
 26 Jun 2025 06:35:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E9.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.21
 via Frontend Transport; Thu, 26 Jun 2025 06:35:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIg3d4XYtJDG6xvkvlJ0kLpTVuzhK/DwK7+ewDKH5vBJR4v1YmkpUUAWi5IQXiA68kTvtWQguVCu3rDJY7aKF0bUBQ3gR/6F6COsKjvM37KS2HVGpNhLIV6412Vfi15tWFllSqLaHKS6IgBcg/hdDbtpdBySzb3mejoF2H5+dNoJa+7oPliaKkObRRQhEqR1HvUSu+u6m7G99Rad/lRjxWxM6cnBX0EqGGK5bb8RWa1VPWm7rfyeICjrTUpk4oipPl2cZAtYLXRVrcjoR/S6AUq86yDhzUXQtnyaH1lAp9XuPKXw9Coz7PAabSLT8ekWcqXMhhbId/JiV795CRxtrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/n8BgWanqAN+/s1x9bnYQOPYdLm32hcYNY3/HB9ZwI=;
 b=q0fKSUIvYHIwH52IOsgsaTn/wrvdEri9QP/QuAwVSGoGVXSDXak0eM/DSA7n1greih1a0jsKxcN1Gdh4DV1fwDCV5aoZjY0Fs4juJxsHZubM8lbP1pCilkysGrOGdLwynMYePufBQcESUOjz725n8iBOszUgti7GJEpxPYDsHVJh9sIFSRiJ+EfMzq+q9YDZxCivI7730X1lGHyQNHeBm6ATPWY907kxfoZJBgFB/yhr2yvv0eTOgpW7KY+oq13EHydJ2V9rfgRVHYaFrfp75P+8nPhbJLuteBrZgVE3/9S/dZFVC8x3li/XPZPNjALZcWh1JPnlIPV90YXy2c5uLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/n8BgWanqAN+/s1x9bnYQOPYdLm32hcYNY3/HB9ZwI=;
 b=FFTvhfhJuExDALyuvG+j+oSjeFL8O05VPM/2ZmhAViqfWDlV6fyEzvcSxzVMIr+bxwWkNiPhUApfitGYUsyiJTALXJQ+LvDGZXOp/YuSVzbQNkMR3e7PbdtnOETElU0/kzZzuRTAEiDC6on9ZfpjRRDJVX9X90/I9lC/D5T38nc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AM8PR08MB5587.eurprd08.prod.outlook.com (2603:10a6:20b:1dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Thu, 26 Jun
 2025 06:35:17 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%3]) with mapi id 15.20.8880.015; Thu, 26 Jun 2025
 06:35:17 +0000
Message-ID: <f9b4f688-f498-48cf-b08c-25477bd7fc7d@arm.com>
Date: Thu, 26 Jun 2025 12:05:11 +0530
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
References: <8e23c5d3-6ce3-4fe8-b6fe-69658d5d0727@lucifer.local>
 <fc5c8193-2642-49f7-9f2a-00ad33353773@arm.com>
 <c93110a4-19e4-4a1d-b044-6b7f521eaa0d@lucifer.local>
 <815793f1-6800-4b9a-852e-f13d6308f50f@arm.com>
 <2756fa2b-e8bf-4c66-bf9b-c85dc63dfc33@lucifer.local>
 <41d9a70d-9791-4212-af23-5b13d8e4a47d@arm.com>
 <aFPI_blZGhvKSbNJ@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
 <16fff6e9-98f5-4004-9906-feac49f0bbb4@arm.com>
 <aFwvPj5AlCgTZsh2@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
 <3bc08930-06f3-443e-a267-ff02c2c053f6@arm.com>
 <aFzdu8YGN_jDxV1u@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <aFzdu8YGN_jDxV1u@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0P287CA0006.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::12) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AM8PR08MB5587:EE_|DB1PEPF000509E9:EE_|PR3PR08MB5851:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fda6e45-4cc4-4d00-f57a-08ddb47bb1c5
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?RE1VOVdHNnNMYmwwYUdsTHltUmpHaE5HZ3Fvcy80WnJCaE9veHRDZGdjLzFR?=
 =?utf-8?B?b2VSbDVmWDBLTUw0dUloYzlxU3Y1YVV2aUVtZ0xHeVZ3SUlwZFp6Q3hDZXhR?=
 =?utf-8?B?WXdpRDNCRmtSTXlpTjBCLzFYOVBVK0lvREdYVDlTWm1LNTVLcUUyZFErd0hX?=
 =?utf-8?B?akFaeW1oTDU5a3ZEWmlHcVZmTld2SE5ycjFzNUpGTTI3ZUc5SUp5Q0ovV0Y3?=
 =?utf-8?B?UUtwMzVMZTVOaXVHUitLN2loYzNUMG9pK2Z1NWZrcDAwYndJSXNHTXYvQUln?=
 =?utf-8?B?MkJ3MFFQQTloNVdLc3UvajBNOTl1Q1JIbndmRFlUV1RQVDY4SGZDdlRsSFpp?=
 =?utf-8?B?ODZ3Q3FhaTZ4KzdSQjhpdzhaRDBDYjBaQ1NoSTQyQitkU1RUOWh3WGVndTR3?=
 =?utf-8?B?N3RLTHM2TzVBbmdHSFE2Mm84cjdqOW52aTdBY3Jybmtock84cUZ6clJsc0hp?=
 =?utf-8?B?SXVucE4vdFdKTlV6TGxSQzBHSVFqOWIwSUMrNkg0RzRnNHg1ZWIvVFZnY2Vw?=
 =?utf-8?B?d0RrUDRBS1UybS9hRzRUc01CTGUrZDFsRHAyV0RKaklQZndTbjJhbVdKOVZ6?=
 =?utf-8?B?bWc1SDBCcHdiQWVjMUlXZWJtZ1Z0WDA3dDRPOUlQbUpkdTJyQjRJcmUvQnBl?=
 =?utf-8?B?QzRYVTZ1c3JreU42LzBnaFBWUE5KYVlQUzlRR3MzQkNxdnpPb0h4L3JiRnBC?=
 =?utf-8?B?UzNYOXZyVEFpSFhkem10cXBsYnZvdm9XMnhpWE9GQVFMYm83WTh4L2U5d2N1?=
 =?utf-8?B?TGNiYjRWajBNYTlVTkFPTGNOZGFPcW4wSFJJSHdxczI4RHRmbGljTHZ2Vis0?=
 =?utf-8?B?M3lZb2VFLy9qQjBoeU5OdnVhQ0JWTmFaUzQ5V1NIb252YmJMeHEwanYzdXJO?=
 =?utf-8?B?QjJDMTVvaHc5ZXRPRmF3M1oyMVgzdTQ0aVpuQjZGRCt5bEJ5d3QzVlh4SzFV?=
 =?utf-8?B?KzhzRGp6d0J6NXRmeWVoRmY0ejJLaVFPQmJFYmlZcXhCOURqYjZnK1gvVDNJ?=
 =?utf-8?B?bXFleGF6b3JoWTRrNjR3SlJzWG1sRitQdlBWTEYwTVl1aTY0RmpDbFkybXJz?=
 =?utf-8?B?b2RxRWE5b09JNVNTSzFoVWhrZi9EVmExT3g5THFqcHZsS2NWblM2MTZvTzBm?=
 =?utf-8?B?OFN2MEYyRHNCZjJjbGVhNDEyQkdvSEZhMnpXT0M5MGFYMjdNNVMwbHZLTlF5?=
 =?utf-8?B?NHFRVFVENTVFZTBVYWtSS2pqQmxwVVAvbWoyWUJZZlZRalJhUXVpWXdjMW5p?=
 =?utf-8?B?MElmd3dBSm5pT0U2dHBjWS9ZNHlaalR4RU1OQVpoZTVqN1RXMDdKK1g0YkVW?=
 =?utf-8?B?SnpSRGoxdVIrSEhHZDlCNUlURWRQdXJURGJTcEVROFFSdlJDL1JwSit5blRZ?=
 =?utf-8?B?UkVmK3Y3WUZzOE9VU2R2U0o5Z2o1TmlrS0phR05Wa1pPRTZwVHIweXpMSitV?=
 =?utf-8?B?WXpOVGZkWXJJaFkxRWNsajhOb25pODN4ZzMrVUpLR3UrMTVHRXYwZ1J3ME9l?=
 =?utf-8?B?bUxuTEdmUW82akcwR0RpK3VoWXNJcFVpdmtueDFaT0JNSkVhZTM3ZzZyVDhE?=
 =?utf-8?B?R3dBTTdvUmg3NEpGU2kySlJxWXp6MHVjQmJuWWF2TXdQMHhZbU9qQURlQ0ZS?=
 =?utf-8?B?ZzFaeW4zMlpRSnpKTWd1aVBWMmx4cURtclZqNFhXZHE0WXM5ZFFwcTZucnVi?=
 =?utf-8?B?YSsrTTY3V1laSXpSUzE3aTM3cGxkSjJibTR2SXdpaUM0eVF0K0xsdXFJV1NE?=
 =?utf-8?B?a0NGUUN5RmVza1U5N0c2UjNWN2hXeXZpMk44ZWpPUmNLSTBtdFhUMk5KVHBY?=
 =?utf-8?B?Q2JpMXU4RzB1RXVobEUxNmdrSExTR0o0UHNXWEZ6Qy9aUFpteTdONTdqODRj?=
 =?utf-8?B?WmlIRFUxQlQrSTV2UnM2ZldXQTYzYklITGYrZWVnalF2YkNZcGlmbzRuQTNh?=
 =?utf-8?Q?dDoCXV2Emtw=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5587
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	742f002a-dfcb-4344-0e51-08ddb47b9d87
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|14060799003|376014|7416014|36860700013|1800799024|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVl3bFdnYmtPYjdqODdycVMzMS82TTNpOVJZT1FXNGRTRWZZd0MyamNvU1FV?=
 =?utf-8?B?TmNKa2V0cEgycHViY3Z0WXB6Z2p0RGRoWldUYTZ2LzRjeEIwZkh5MUttZnc1?=
 =?utf-8?B?akVQdDhsckFmTVlMbXVtSG83dVZlOXQ1ZC9Qc3JFUU1qczhmZUdjTVpsTFRX?=
 =?utf-8?B?Qk9IOGx1MnVFOEFmUkxzT0JSanNJMFZJQ2Y1Rm16am5hcElkWVZnWjZxZmU2?=
 =?utf-8?B?T3lGZXdtUDRXaEpoekdhODlVRjc0dDBsdHdXTTFjQ2wxaXJ1VU5vVjdVVmtj?=
 =?utf-8?B?Y2ZVaEdIc0xZVDUvQzFPYW0rUWFHcStPOU15UEpGdzV0eFg1MS85bngrOHhM?=
 =?utf-8?B?Vll2MTFWQ2M3cnNPWnF2WUdhRkJYdld3REFhSzB3eGdnak1XTzZsM21sZ3k1?=
 =?utf-8?B?aWZWeGxnZ0ZDcm52c1I3Y3B0THVnQiszWXoxSnI2bWJqZ1d3WUJxUFR5T3hE?=
 =?utf-8?B?dTk4b2FkQ2RhOVYzUkZpU1g1eDhlaC9UYmplT0tNY0ZJRlNtSkJMc1l2QXR5?=
 =?utf-8?B?Z3dMZGZFcnVESnN4enZST3JnaXNxMzZXSDhJM1RFZVY2WGJzTEMxNkpuTTV4?=
 =?utf-8?B?NTJCNjRtMnZFUkpabjdjNUgzNWd6dG9hMjMyN3JXczBDaEpFUDY0dnhJWGZs?=
 =?utf-8?B?Qno4azBIbStkQXFlLy9iM2d4bjluTkhBazlZY1JBR21ocDZhdzhXa2YxODg5?=
 =?utf-8?B?aENFUnNpRWhIUWVyZDE5WHhENGtLdVNiaFpPME1jRk10ZHJjQnpzOG9GQWxz?=
 =?utf-8?B?YjFQYW1FNEhuaE84TnlhTUtjd3ZTNTBQUEhka0grSWNPVVBsZ1AzVEZlRjhq?=
 =?utf-8?B?dldsYThyTmhjOHB6aW41WHJ4VnhkMGZVbnZhK3l2ZHBRbEhxSjdsQlc2TDRq?=
 =?utf-8?B?bndnTkJkaDA0dXcramRYZmpyWm4vZjl1YmJyRVBKQiszb0tHNHpQVzFQL0tl?=
 =?utf-8?B?ZU1jejNMd0ZkKzdXVVkrdEo4elFwZkQ5b3o0KzdqNHVTQVBVNFhtVVBlOEg0?=
 =?utf-8?B?VUphV0FKQkdQSDUxOVA2L3h5ek5EeDh2Z2F2L1lGQURrQmI0TFkybGcrVmxQ?=
 =?utf-8?B?ZGJZcDBuSDhxVWR6Sm40Uk1hZ0dFUDhScDRFc0ljQnNsazlsa0cwRXFxQzlK?=
 =?utf-8?B?RzJBbkxIeHQ1M0Q4azUvVHpiUENZM1NFSzVoa2RidFFzRUtTdm1NY0hLV09W?=
 =?utf-8?B?cTE3azFpbytkTmtFeHhueHpLNGMyZkRpaUlxNi85dno5UzNUZXBhdXA4bk9T?=
 =?utf-8?B?bkNVRHRVSEdscmYvdkZNcnRjWEduanNtdG43eFhRZTM1UkR5M3NXMVNzSUxJ?=
 =?utf-8?B?R2M4Ry80NW11Vk1OYXpsR052TTY4RUFSV1NDRkNaVUpyWlhKZG1oc0dlK3Fs?=
 =?utf-8?B?SVhyM2VvVi9MLzNHVDE1SS9YT1dhZTMra3lqWmtzL2YvNkRhRFhCUlEwSG5m?=
 =?utf-8?B?UzZQSFB2cTNMMDdzVDFOeFlKcGVKV3hkSUZpSTVUcWZ1RHZ1VVhmK1U3Y3lK?=
 =?utf-8?B?SjFsc2lrR1B0WUtCVFJKTnpnVVFHVlBJSjhrZjBZWFd4eGJhVy9TTjAvNWFQ?=
 =?utf-8?B?VjJwSGl2RUUrUkhxV3Nwei9vMHhXcG9rOUVBaUhmY1RYRDYzc3BqdlZKV1lw?=
 =?utf-8?B?VHBKWTF3OU9UenJ3K0JmMHdaMjBNcXpTREZCS2M4eGVtVnpoTytXZHNmTExn?=
 =?utf-8?B?YkZZNC9XS240QkFmazBvNm9rUjB1emVKR0duUEJjb1lEV0RMTDJFeUR1TmJu?=
 =?utf-8?B?eWJUVXM5WXdmY0dqaWxFSmJZU280V0V0L1N1S29iSE9uUVhhSmoxeUdPem5T?=
 =?utf-8?B?c01rNWd2c2toaDdna2xKTmZTNVAwc2VFemFOT1F6bmZIOUNQWE1HUSsrMWZ1?=
 =?utf-8?B?VjBQbkdVbTRPY1AzL28yaTVpVUh6eWpKLzJzWW1WQ1RQYWlTVEpMVnVuN2dp?=
 =?utf-8?B?MGs3QlVaMklKeVpic3hzM2tDRk50djc3UXBrN25EYnNGWFVGek9lbHF4MGxT?=
 =?utf-8?B?VU0reHg2QWx3ckkxSEl0UGV0Uk50TVUvOUQ0bm5Xa1NrZnZBMkp0YnlNSU0z?=
 =?utf-8?Q?Xy3skA?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(14060799003)(376014)(7416014)(36860700013)(1800799024)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 06:35:51.1931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fda6e45-4cc4-4d00-f57a-08ddb47bb1c5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5851


On 26/06/25 11:12 am, Donet Tom wrote:
> On Thu, Jun 26, 2025 at 09:27:30AM +0530, Dev Jain wrote:
>> On 25/06/25 10:47 pm, Donet Tom wrote:
>>> On Wed, Jun 25, 2025 at 06:22:53PM +0530, Dev Jain wrote:
>>>> On 19/06/25 1:53 pm, Donet Tom wrote:
>>>>> On Wed, Jun 18, 2025 at 08:13:54PM +0530, Dev Jain wrote:
>>>>>> On 18/06/25 8:05 pm, Lorenzo Stoakes wrote:
>>>>>>> On Wed, Jun 18, 2025 at 07:47:18PM +0530, Dev Jain wrote:
>>>>>>>> On 18/06/25 7:37 pm, Lorenzo Stoakes wrote:
>>>>>>>>> On Wed, Jun 18, 2025 at 07:28:16PM +0530, Dev Jain wrote:
>>>>>>>>>> On 18/06/25 5:27 pm, Lorenzo Stoakes wrote:
>>>>>>>>>>> On Wed, Jun 18, 2025 at 05:15:50PM +0530, Dev Jain wrote:
>>>>>>>>>>> Are you accounting for sys.max_map_count? If not, then you'll be hitting that
>>>>>>>>>>> first.
>>>>>>>>>> run_vmtests.sh will run the test in overcommit mode so that won't be an issue.
>>>>>>>>> Umm, what? You mean overcommit all mode, and that has no bearing on the max
>>>>>>>>> mapping count check.
>>>>>>>>>
>>>>>>>>> In do_mmap():
>>>>>>>>>
>>>>>>>>> 	/* Too many mappings? */
>>>>>>>>> 	if (mm->map_count > sysctl_max_map_count)
>>>>>>>>> 		return -ENOMEM;
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> As well as numerous other checks in mm/vma.c.
>>>>>>>> Ah sorry, didn't look at the code properly just assumed that overcommit_always meant overriding
>>>>>>>> this.
>>>>>>> No problem! It's hard to be aware of everything in mm :)
>>>>>>>
>>>>>>>>> I'm not sure why an overcommit toggle is even necessary when you could use
>>>>>>>>> MAP_NORESERVE or simply map PROT_NONE to avoid the OVERCOMMIT_GUESS limits?
>>>>>>>>>
>>>>>>>>> I'm pretty confused as to what this test is really achieving honestly. This
>>>>>>>>> isn't a useful way of asserting mmap() behaviour as far as I can tell.
>>>>>>>> Well, seems like a useful way to me at least : ) Not sure if you are in the mood
>>>>>>>> to discuss that but if you'd like me to explain from start to end what the test
>>>>>>>> is doing, I can do that : )
>>>>>>>>
>>>>>>> I just don't have time right now, I guess I'll have to come back to it
>>>>>>> later... it's not the end of the world for it to be iffy in my view as long as
>>>>>>> it passes, but it might just not be of great value.
>>>>>>>
>>>>>>> Philosophically I'd rather we didn't assert internal implementation details like
>>>>>>> where we place mappings in userland memory. At no point do we promise to not
>>>>>>> leave larger gaps if we feel like it :)
>>>>>> You have a fair point. Anyhow a debate for another day.
>>>>>>
>>>>>>> I'm guessing, reading more, the _real_ test here is some mathematical assertion
>>>>>>> about layout from HIGH_ADDR_SHIFT -> end of address space when using hints.
>>>>>>>
>>>>>>> But again I'm not sure that achieves much and again also is asserting internal
>>>>>>> implementation details.
>>>>>>>
>>>>>>> Correct behaviour of this kind of thing probably better belongs to tests in the
>>>>>>> userland VMA testing I'd say.
>>>>>>>
>>>>>>> Sorry I don't mean to do down work you've done before, just giving an honest
>>>>>>> technical appraisal!
>>>>>> Nah, it will be rather hilarious to see it all go down the drain xD
>>>>>>
>>>>>>> Anyway don't let this block work to fix the test if it's failing. We can revisit
>>>>>>> this later.
>>>>>> Sure. @Aboorva and Donet, I still believe that the correct approach is to elide
>>>>>> the gap check at the crossing boundary. What do you think?
>>>>>>
>>>>> One problem I am seeing with this approach is that, since the hint address
>>>>> is generated randomly, the VMAs are also being created at randomly based on
>>>>> the hint address.So, for the VMAs created at high addresses, we cannot guarantee
>>>>> that the gaps between them will be aligned to MAP_CHUNK_SIZE.
>>>>>
>>>>> High address VMAs
>>>>> -----------------
>>>>> 1000000000000-1000040000000 r--p 00000000 00:00 0
>>>>> 2000000000000-2000040000000 r--p 00000000 00:00 0
>>>>> 4000000000000-4000040000000 r--p 00000000 00:00 0
>>>>> 8000000000000-8000040000000 r--p 00000000 00:00 0
>>>>> e80009d260000-fffff9d260000 r--p 00000000 00:00 0
>>>>>
>>>>> I have a different approach to solve this issue.
>>>>>
>>>>>    From 0 to 128TB, we map memory directly without using any hint. For the range above
>>>>> 256TB up to 512TB, we perform the mapping using hint addresses. In the current test,
>>>>> we use random hint addresses, but I have modified it to generate hint addresses linearly
>>>>> starting from 128TB.
>>>>>
>>>>> With this change:
>>>>>
>>>>> The 0–128TB range is mapped without hints and verified accordingly.
>>>>>
>>>>> The 128TB–512TB range is mapped using linear hint addresses and then verified.
>>>>>
>>>>> Below are the VMAs obtained with this approach:
>>>>>
>>>>> 10000000-10010000 r-xp 00000000 fd:05 135019531
>>>>> 10010000-10020000 r--p 00000000 fd:05 135019531
>>>>> 10020000-10030000 rw-p 00010000 fd:05 135019531
>>>>> 20000000-10020000000 r--p 00000000 00:00 0
>>>>> 10020800000-10020830000 rw-p 00000000 00:00 0
>>>>> 1004bcf0000-1004c000000 rw-p 00000000 00:00 0
>>>>> 1004c000000-7fff8c000000 r--p 00000000 00:00 0
>>>>> 7fff8c130000-7fff8c360000 r-xp 00000000 fd:00 792355
>>>>> 7fff8c360000-7fff8c370000 r--p 00230000 fd:00 792355
>>>>> 7fff8c370000-7fff8c380000 rw-p 00240000 fd:00 792355
>>>>> 7fff8c380000-7fff8c460000 r-xp 00000000 fd:00 792358
>>>>> 7fff8c460000-7fff8c470000 r--p 000d0000 fd:00 792358
>>>>> 7fff8c470000-7fff8c480000 rw-p 000e0000 fd:00 792358
>>>>> 7fff8c490000-7fff8c4d0000 r--p 00000000 00:00 0
>>>>> 7fff8c4d0000-7fff8c4e0000 r-xp 00000000 00:00 0
>>>>> 7fff8c4e0000-7fff8c530000 r-xp 00000000 fd:00 792351
>>>>> 7fff8c530000-7fff8c540000 r--p 00040000 fd:00 792351
>>>>> 7fff8c540000-7fff8c550000 rw-p 00050000 fd:00 792351
>>>>> 7fff8d000000-7fffcd000000 r--p 00000000 00:00 0
>>>>> 7fffe9c80000-7fffe9d90000 rw-p 00000000 00:00 0
>>>>> 800000000000-2000000000000 r--p 00000000 00:00 0    -> High Address (128TB to 512TB)
>>>>>
>>>>> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
>>>>> index 4c4c35eac15e..0be008cba4b0 100644
>>>>> --- a/tools/testing/selftests/mm/virtual_address_range.c
>>>>> +++ b/tools/testing/selftests/mm/virtual_address_range.c
>>>>> @@ -56,21 +56,21 @@
>>>>>     #ifdef __aarch64__
>>>>>     #define HIGH_ADDR_MARK  ADDR_MARK_256TB
>>>>> -#define HIGH_ADDR_SHIFT 49
>>>>> +#define HIGH_ADDR_SHIFT 48
>>>>>     #define NR_CHUNKS_LOW   NR_CHUNKS_256TB
>>>>>     #define NR_CHUNKS_HIGH  NR_CHUNKS_3840TB
>>>>>     #else
>>>>>     #define HIGH_ADDR_MARK  ADDR_MARK_128TB
>>>>> -#define HIGH_ADDR_SHIFT 48
>>>>> +#define HIGH_ADDR_SHIFT 47
>>>>>     #define NR_CHUNKS_LOW   NR_CHUNKS_128TB
>>>>>     #define NR_CHUNKS_HIGH  NR_CHUNKS_384TB
>>>>>     #endif
>>>>> -static char *hint_addr(void)
>>>>> +static char *hint_addr(int hint)
>>>>>     {
>>>>> -       int bits = HIGH_ADDR_SHIFT + rand() % (63 - HIGH_ADDR_SHIFT);
>>>>> +       unsigned long addr = ((1UL << HIGH_ADDR_SHIFT) + (hint * MAP_CHUNK_SIZE));
>>>>> -       return (char *) (1UL << bits);
>>>>> +       return (char *) (addr);
>>>>>     }
>>>>>     static void validate_addr(char *ptr, int high_addr)
>>>>> @@ -217,7 +217,7 @@ int main(int argc, char *argv[])
>>>>>            }
>>>>>            for (i = 0; i < NR_CHUNKS_HIGH; i++) {
>>>>> -               hint = hint_addr();
>>>>> +               hint = hint_addr(i);
>>>>>                    hptr[i] = mmap(hint, MAP_CHUNK_SIZE, PROT_READ,
>>>>>                                   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>>>> Ah you sent it here, thanks. This is fine really, but the mystery is
>>>> something else.
>>>>
>>> Thanks Dev
>>>
>>> I can send out v2 with this patch included, right?
>> Sorry not yet :) this patch will just hide the real problem, which
>> is, after the hint addresses get exhausted, why on ppc the kernel
>> cannot find a VMA to install despite having such large gaps between
>> VMAs.
>
> I think there is some confusion here, so let me clarify.
>
> On PowerPC, mmap is able to find VMAs both with and without a hint.
> There is no issue there. If you look at the test, from 0 to 128TB we
> are mapping without any hint, and the VMAs are getting created as
> expected.
>
> Above 256TB, we are mapping with random hint addresses, and with
> those hints, all VMAs are being created above 258TB. No mmap call
> is failing in this case.
>
> The problem is with the test itself: since we are providing random
> hint addresses, the VMAs are also being created at random locations.
>
> Below is the VMAs created with hint addreess
>
> 1. 256TB hint address
>
> 1000000000000-1000040000000 r--p 00000000 00:00 0                        [anon:virtual_address_range]
>
> 2. 512TB hint address
> 2000000000000-2000040000000 r--p 00000000 00:00 0                        [anon:virtual_address_range]
>
> 3. 1024TB Hint address
> 4000000000000-4000040000000 r--p 00000000 00:00 0                        [anon:virtual_address_range]
>
> 4. 2048TB hint Address
> 8000000000000-8000040000000 r--p 00000000 00:00 0                        [anon:virtual_address_range]
>
> 5. above 3096 Hint address
> eb95410220000-fffff90220000 r--p 00000000 00:00 0                        [anon:virtual_address_range].
>
>
> We support up to 4PB, and since the hint addresses are random,
> the VMAs are created at random locations.
>
> With sequential hint addresses from 128TB to 512TB, we provide the
> hint addresses in order, and the VMAs are created at the hinted
> addresses.
>
> Within 512TB, we were able to test both high and low addresses, so
> I thought sequential hinting would be a good approach. Since there
> has been a lot of confusion, I’m considering adding a complete 4PB
> allocation test — from 0 to 128TB we allocate without any hint, and
> from 128TB onward we use sequential hint addresses.
>
> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
> index e24c36a39f22..f2009d23f8b2 100644
> --- a/tools/testing/selftests/mm/virtual_address_range.c
> +++ b/tools/testing/selftests/mm/virtual_address_range.c
> @@ -50,6 +50,7 @@
>   #define NR_CHUNKS_256TB   (NR_CHUNKS_128TB * 2UL)
>   #define NR_CHUNKS_384TB   (NR_CHUNKS_128TB * 3UL)
>   #define NR_CHUNKS_3840TB  (NR_CHUNKS_128TB * 30UL)
> +#define NR_CHUNKS_3968TB  (NR_CHUNKS_128TB * 31UL)
>   
>   #define ADDR_MARK_128TB  (1UL << 47) /* First address beyond 128TB */
>   #define ADDR_MARK_256TB  (1UL << 48) /* First address beyond 256TB */
> @@ -59,6 +60,11 @@
>   #define HIGH_ADDR_SHIFT 49
>   #define NR_CHUNKS_LOW   NR_CHUNKS_256TB
>   #define NR_CHUNKS_HIGH  NR_CHUNKS_3840TB
> +#elif defined(__PPC64__)
> +#define HIGH_ADDR_MARK  ADDR_MARK_128TB
> +#define HIGH_ADDR_SHIFT 47
> +#define NR_CHUNKS_LOW   NR_CHUNKS_128TB
> +#define NR_CHUNKS_HIGH  NR_CHUNKS_3968TB
>   #else
>   #define HIGH_ADDR_MARK  ADDR_MARK_128TB
>   #define HIGH_ADDR_SHIFT 48
>
>
> With this the test is passing.

Ah okay this was the problem, PPC got extended for 52 bits and the
test was not updated. This is the correct fix, you can go ahead
with this one.

>
>
>
>> It should be quite easy to trace which function is failing. Can you
>> please do some debugging for me? Otherwise I will have to go ahead
>> with setting up a PPC VM and testing myself :)
>>
>>>>> Can we fix it this way?

