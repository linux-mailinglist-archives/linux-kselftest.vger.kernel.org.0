Return-Path: <linux-kselftest+bounces-35348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD79AE011E
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 11:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 689CC7AEF55
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 09:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED1D280CE8;
	Thu, 19 Jun 2025 09:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Xi784kJF";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Xi784kJF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011013.outbound.protection.outlook.com [52.101.70.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3F2280A32;
	Thu, 19 Jun 2025 09:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.13
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323789; cv=fail; b=dIBqfxkUVY7GQbQOBiiiEPIeuVvmFx2hQ33OqNn45DkWmgEEhDL5QLnZQodJ2BPetu834oNOj+sZROYxd1YjJx95xmW8hyPn+Dh86fAYijAJgkVd/m6dn/QkuZ+cSLBI+tFDeoknvcA1M7pJFJLkxBZQqrPc3eDdAXYNHS1t23w=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323789; c=relaxed/simple;
	bh=O8VZo++OY7iXP/H4Hu+xc0DdkConSYM8nxcOkn4m/ic=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rscl6ZWiFgK7DnyvoFf38G5K0RHyltCsKVEmP6dh2KtH4LlWGHKtVql+R3/oDwn310w+0YPgIAxlZh7gRmLxvyxWM4XwcxekIXs/iJ7nB91x5KtQFpu+jKRc5IyQvuMvWBjw6nqyOpqu+fsPdOyhzYIAVJC7SUsg0BIpG6OokMA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Xi784kJF; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Xi784kJF; arc=fail smtp.client-ip=52.101.70.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=n4CrhDJcU8qKJCIXh98Oej78MMGWgNJAbQsXZC3rRki/YAo/FOYByTifXlwEe+hO+MdRtsgVSCRq0e0TQfQnTDKQ02HGu6wLZD114kko+7T599IzRZK63pvHs+nZaFX+hJWzy3+yh5CLw1uMFC00zGSDm3fSJNQ6tug1JUkF9PFrQ5EMvM0XraTrFo8SFiL+0D4K3OG2Qiu6KWOoKQIe1rTxGxCM70UTmmcEgdiU+9MNPRGC0k27Ggx5KwORs9tFq7BNGPZXhqcHpvwbvNKxVpJr9BfWPpgo8kfSMduypswm/+v2WVtB3PbUr6VokYq2bv01G4a6NXEjk6AyBXC9Qw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rie6VVdoCLs/2b6Zgepptlh3W/D0uG6OEQFb+5wSk18=;
 b=KLtg194rcUx8J6LmRQD7YPiOKcTSJ2ax47AbEis7oYjuhBf6MyXLl/LA5ySK87iJVgFkQPMyS+vMQPCeqAp0ZTjRxQYHH5NW62ip0ni129H5C5Xj+pTQ2i87TbawcqDe0rztqVNr+r3tMe2ZGx4gFpMPyKP3pOMAxf1xUY9M9RgU0tFw6N0DPd9GECCl5KTzKtE6uqsV1Mh+F9Po1pbhG4qGxgHiprLeLQ5t0bBi3aglHDuI4887J23FFSsky1mV0vE0EHRDAPAWo3WYsjeHBxECc6bT1o6er7pzzSlInSsIIptQK07wFiWYRwsYGjAxXtIq9YK9gW9AWdJPLqeoig==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rie6VVdoCLs/2b6Zgepptlh3W/D0uG6OEQFb+5wSk18=;
 b=Xi784kJFdeoU0oKJKs8RLkkmNga33zOFMBosPXjGcUcNqOXWkRtZXeysal6fHNjNCt6Ojh5AI5CtTjvEhhnrLtMZctajskFw20AzCVsDHUojw14YXhBdgXE9flOFIiy59OyvOoemVgqZsZHpVuDetqc1n2SxTDqNFJTqvTKXDbU=
Received: from PA7P264CA0171.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36f::20)
 by AS8PR08MB8013.eurprd08.prod.outlook.com (2603:10a6:20b:572::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.38; Thu, 19 Jun
 2025 09:03:03 +0000
Received: from AMS0EPF000001B0.eurprd05.prod.outlook.com
 (2603:10a6:102:36f:cafe::c7) by PA7P264CA0171.outlook.office365.com
 (2603:10a6:102:36f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.35 via Frontend Transport; Thu,
 19 Jun 2025 09:03:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001B0.mail.protection.outlook.com (10.167.16.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.21
 via Frontend Transport; Thu, 19 Jun 2025 09:03:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xSAxWvepMPGcSAwcCecTEMVC9LshhXanhalsvzsSx8DNZWKkQZyUmgBNCG5MUP3tHavbTKWZdYGTmEgxCm5QmQECeEh8uKt2+UrJUlRM6RzMlMMCIF3ZQoB5LCiLkKZg/xHnLVXC4SCgGWFfijMTKO8330rmWqZgC3R8rnCrFe+g7GwbezMjjlhM6PQUTuP7nJPMWRqq3rORhaPFyNtnzZuoLQx6Dp7Ph8fBTLjn7AhABnrL+sCeD1E18+hrsK8Tt3k8mmoh41oEBl5EepfmwBkMU+784k1TVLIX0hksggucIpFCNG4e7ICdjPYz9RWFzFLq7qlRa9iCLqqu3i6JtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rie6VVdoCLs/2b6Zgepptlh3W/D0uG6OEQFb+5wSk18=;
 b=ezJktBuEebW9HKCPtbgZyRBwdzDJ1yVN9sAXoo+J0/357o4D7i7mgDUbZcj98aUeVWnl79YpEPKLxojwLIH72eHa5GKT3jqYfdyuLb6Q0X9YqkpxrYHRAKo7+y+M9U3eQ/gNAQywcRAQdKnHrnbLGOSCQ4THnVHsevkmdiMy2aQ53+Dd9WD7rpEFvBe2JwGjNVGHLTw2HDxLMIXzi88N5ziMna7vv+YSXNWDS00JcN4LYjvcDg04sDY2ZDyfSj6sfzzSDzALWU6firyp9ongaiKwkvFqx3rE6aSsOMNTSzrzboHpJek3BPEpSuDglG1KCaOxhoH2r72vfNgOrZTdZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rie6VVdoCLs/2b6Zgepptlh3W/D0uG6OEQFb+5wSk18=;
 b=Xi784kJFdeoU0oKJKs8RLkkmNga33zOFMBosPXjGcUcNqOXWkRtZXeysal6fHNjNCt6Ojh5AI5CtTjvEhhnrLtMZctajskFw20AzCVsDHUojw14YXhBdgXE9flOFIiy59OyvOoemVgqZsZHpVuDetqc1n2SxTDqNFJTqvTKXDbU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DU0PR08MB7519.eurprd08.prod.outlook.com (2603:10a6:10:321::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Thu, 19 Jun
 2025 09:02:27 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%4]) with mapi id 15.20.8857.020; Thu, 19 Jun 2025
 09:02:27 +0000
Message-ID: <af2618dc-b778-45e6-867e-9ba3a79398c7@arm.com>
Date: Thu, 19 Jun 2025 14:32:19 +0530
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
References: <159f6939-e7c8-492c-8195-b7e8787a08f1@lucifer.local>
 <f8730d2d-41bf-407a-b44b-6cb9c1e5d4b3@arm.com>
 <79bdd993-0e9c-4d7d-b42c-4b5750eff140@lucifer.local>
 <aaddfd0b-216e-48fe-b48f-35c78eabcf9a@arm.com>
 <8e23c5d3-6ce3-4fe8-b6fe-69658d5d0727@lucifer.local>
 <fc5c8193-2642-49f7-9f2a-00ad33353773@arm.com>
 <c93110a4-19e4-4a1d-b044-6b7f521eaa0d@lucifer.local>
 <815793f1-6800-4b9a-852e-f13d6308f50f@arm.com>
 <2756fa2b-e8bf-4c66-bf9b-c85dc63dfc33@lucifer.local>
 <41d9a70d-9791-4212-af23-5b13d8e4a47d@arm.com>
 <aFPI_blZGhvKSbNJ@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <aFPI_blZGhvKSbNJ@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::19) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DU0PR08MB7519:EE_|AMS0EPF000001B0:EE_|AS8PR08MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: f546b397-35e2-4629-1393-08ddaf1018fa
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?eDJtZ0V0ZnJuME8wQ1dMMmVzNytzVWNXc1pibTdwR01kNEtOOWNxdDhWUm1w?=
 =?utf-8?B?SGVTd1daazVka2lPakFWZ1BSaTRVTUIzOWJhRldBaDR6Zm9CeW9jMlVSZDE2?=
 =?utf-8?B?aG5oWjBuclRYd1lpNW5qSkFLYkRRVm1oSG9hNWZ4VTc3cEFJTkxQSzVxKzg5?=
 =?utf-8?B?Mk1WTDdvY2xjRm9WYmFjS2JZZGtkeGNXM0VHOTREZS9hREdRcEN5d0xVbE01?=
 =?utf-8?B?MGx4cjBlaDMxZVhnU1QwaytaVWhSSFJBbFhHRHlTTDN6WlN4bE93SGR0QmUy?=
 =?utf-8?B?eWtkRXNsT0JLZTJTYW03UXNJZVY5cjlmYklBN2xOYVFSRkRvdnFiZitaMVFk?=
 =?utf-8?B?dVNFUjRrSTRaNEVwc0JOWHY4UGd5TDFUemJCR21BRmFYdFBJSElrUzRuOWJp?=
 =?utf-8?B?Umgva2cvOUpzZE4rUm9WdFdtcVJWQjNoT251SWg4aC9qbzdEMU92ZDZsMExB?=
 =?utf-8?B?bU13eENXZHJmNEFqbHVqRVFNNlh1cXp4QVJrUHBJMEc5Z1lnMjlIRmZCUXBS?=
 =?utf-8?B?aWovVThyYjFUbW9PU0RQM0ZMMWROU3B4N2xNY1NkY040WlBSaFV1RDJENm84?=
 =?utf-8?B?Zm1lQzdadHNTVEhCb01UcGtRcDBiWEhUNURNVDdtdGdFSEFQRlBkbUhpamNJ?=
 =?utf-8?B?NFB5aE5BcC93MXk4MXA1UGlwY3ZpYlJJdDdOZmFrR3RtU001YXp1eVpFQzZm?=
 =?utf-8?B?NnR0Y2c2dlROZkFaUFk5ekg3UzFxMFJ1cm56RWpyVStyejI4Z3YyalNPcU5h?=
 =?utf-8?B?MmhIWlVGcGJ1b1lZY3pSd2lkQTQvL3pQOWFQV29sMVF0MnprSTZ3SXBVMGdq?=
 =?utf-8?B?TDJpbHA1Q003ZVZJb3IvbVNBVW91OUdvbk92c3pUNUdKaXpLSklpMmhXR0M2?=
 =?utf-8?B?MGhKYWFKc2hVVFFvS3hBVi96SnFLQitLdnNsWHQyYisrbHFMcndUcEExSWIz?=
 =?utf-8?B?U1ZzTzJ2clNDQUJYcy9kRlltSlFDcXZaa2JXSTVEaGNUMm5DLytRZ0FaZGll?=
 =?utf-8?B?ckNDSFBwRnZlbEhzRlVFMDFtVjRwRG1OcE1EbVA2QXl6M3Rwb3RCdlBaUjMv?=
 =?utf-8?B?ZWUvdmVSSXNITlpwVGdXYUgwUU9ubVVHd0s0cVE2N1JxT2Z3VDRTNXF2K20w?=
 =?utf-8?B?MDBlL3pIQmFRTFNUWCtiOU1WREd2VHJCNDlNUnRWL0RzdGk4V0o4VHJ6TFly?=
 =?utf-8?B?L3lER0Nkd0dXeWlLdWtHeFd1a0JpVDUwQ3RNU1pobmpjZFpDOEFJUjNkbDZx?=
 =?utf-8?B?VmpxRGVvVTZFQVlLN21wbTdvaGk4aDJ6QkJUS1dHK0NNZmFqOC9MK3A5TVBN?=
 =?utf-8?B?eVpRL3VsalJrVTFtb091UXA0TEVGZGU4TnYxNkRwWmZUR1psY0RmdDlMdVgv?=
 =?utf-8?B?RmVrSS9oVE1qQjk5bStuazgwYkZYRndKbUVQOWZCZFBMc1FHMjhxcGk3cnJt?=
 =?utf-8?B?dWgvOTJDZGJVcDdNc3RRRG1lVDQvdm5HWDIvVWdBNWhxZ215TjBwT3N3Rldj?=
 =?utf-8?B?M3orSEpTUnVYTjdlZWFGRjRGR1JKUmxpN2k5WXJRZitpclMzdEhQL3JBdCt2?=
 =?utf-8?B?SHErd3R1TGlJc284NTJveDhXNWEydUxOTHVmbzl2dUdmYkJwUHBhRE40VVhw?=
 =?utf-8?B?L1pLVUZQUkhHUE43VHBmdFlOVSs3SUR1TkZ5TDU3TXE4SldtaGNycEdjWWRO?=
 =?utf-8?B?NENxUWV2UnRBL3A1SmJpbjRaWnkxaGFkSDUxcExyZXQ0b3JxUjQrWkV1ZUVU?=
 =?utf-8?B?Rmw1Z3AxeFVjMW5icjBZem5jTGhUZGp1TktEUjRUY0JGWHhNeXhkMDVzYnpK?=
 =?utf-8?B?UmZhK01HTXlqRUxuRzM5TEJ4N0dlUnNUeG5rdVdOM0VUbURQZlZxNnBNTmNm?=
 =?utf-8?B?Rk5ZbzE3WGY1S2VqbU82S1FUTExySkFGTXIwMlB2ZjNDajZIUm9KN3IxS2RR?=
 =?utf-8?Q?JUrbhGHjweo=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7519
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B0.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	dc27f3f3-7d50-46c8-91c4-08ddaf1002ec
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|14060799003|1800799024|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1FTZHkwSDA1dEpWZkREQ2hXeEl4Ti90eTBzUUVKV1V0ellrMUlGaW9KZWdr?=
 =?utf-8?B?S1cyR0N1SGh0SG9NbmxmczR2ejF5WmFOb3RsaGY2UkZlME5va09wcTJVTXVN?=
 =?utf-8?B?KzhuMGdzRmo3c2dMNDZ5Sm1NRUtsTW5JQjRsaXhoSWk5Qmh3QXFXQVFZMTFD?=
 =?utf-8?B?SkNCYjkvbHB5VnlBdnNkZUl4Mm5YT1U3M0Jqa1VDQUZlV2NHb05jdVV6bG5V?=
 =?utf-8?B?TjAzRHg1V3pBNkFSZ0U2d3lHbDN3bG5BWlh3VEQ5amdla2VHWk9NQ3EwdkpX?=
 =?utf-8?B?MTFMd2RlUmJ5SmdHOEdtUzRLSG9hYWhKSDY3azRoWkc3dUtJT1hoSVpTZTJ3?=
 =?utf-8?B?OGNDL0NQOEY1djQrbDN2MFQwTFpJZVRscHFJT1RTcmJ6MEs3c0VYeEszcW9N?=
 =?utf-8?B?N0xWUVNYZ0Z3UE1XU1ErbHJuaUNzK0ZUWjBReFpKRlF6MEJ4OExOSGwvcGov?=
 =?utf-8?B?b0NyWWVTblpPUFUwMGpvZjQwQUtPNlphbW9rOUxPWjVXZDF3ZUVremFCSXZP?=
 =?utf-8?B?LzRLdXk0Q0ZjQnE2amY4L01QeVdVSjJUZzJqM01FSjc1Y0dnTGl2T2xXK3Zk?=
 =?utf-8?B?YWtnS3RnbjY2amx6bW5VMVFodVZKMElsMWhEcElyTjBacjBYSFByT05FSFoy?=
 =?utf-8?B?a1FiamkxclN3clhMaTgySllMcDI1TVpQWVR4ZXRRSGpvR2VRcmt1L3hURXRJ?=
 =?utf-8?B?L29XVjF2NFp1ZjNXZlNsRjAvaW44NlZEU0I5andRWUUrOE1KWVN4bUlFc3U3?=
 =?utf-8?B?VTZzbmtXWFNPWmhFVENUWnp3cXA2MS9pSFg3RkpoeEFDR0xWVmRiWFNoQnFG?=
 =?utf-8?B?ejducVJCMy9aN00rTFZXakdoblprQmZ3YklmdHFJbFZ4bUcveWJCSGJuODR5?=
 =?utf-8?B?TTRvN3p0M2dybU50a1ZLNEowaEtqWXllN3p5am5oT3c3elFNcEpiMXBHUmRs?=
 =?utf-8?B?UTFtRlBuLzl5TklUOG9kYk03YzhqY2tOTmpzZWl3c3JnSkx4ak5IVWlGWGRy?=
 =?utf-8?B?VFRsYm40RTF0enRhZ1kxWXEvTURzWVYzcU15WG5VOTdVNmkyRjRhOTdacndF?=
 =?utf-8?B?Q0dUU2dCOHcxUkFUTTNNS0hsTTBDeVdnUHBGOEI3OUhIT3VSVHc1UHhveFAz?=
 =?utf-8?B?U1FZZ0ZabS8wVDl6aUJSN05RYnA2RWhqZTdnYVlRcTZwRlU0OTZGYXpLMUIv?=
 =?utf-8?B?NEFqbTArWXBaYkNQWE00djJSNGlsTlJMcUtvZGx1SW9LRlRiSjRmT0lmdksw?=
 =?utf-8?B?cHQ3MFBndWNzQ1ZNL041KzZQNkNibnNoYVpyL3RkV1k4U05JSWFIQjRXbmwy?=
 =?utf-8?B?VFNNK2N5WHY3VldQN0dtSUpzRi9lcmNGbDNkK21zNTZNMDNUSHJndVZFZnhm?=
 =?utf-8?B?S2xpblFLSG9qS29MOEpYNVRPY1VvLzNnKzRNMGZHSWIwRDA0c3IxWngrZW1k?=
 =?utf-8?B?ODd3U0NqNDFNUFl1RXZHU3RTa3B2SXhZN21wOG0yUnNlYUF0dFgyVUhnZUtt?=
 =?utf-8?B?TGpTUGFvMGwwTGZCRTVFUW5ydStXWnhTUXh0ZlNYNzdJWHlUcmY0cVRsbmt3?=
 =?utf-8?B?TEpNeWcwYzdIWkhpRHRMNlZVTDdiOWxYTWNyQ3dYSFRBOXRLSXJCakI5K0Fx?=
 =?utf-8?B?Q2M3WExaaFBPbU1rc2JjYUVlTGw1ZDNXUXo2cGtnL3pPN0s3Z1p6VzNhbyt6?=
 =?utf-8?B?VjY3MjkzZ0YvczdmVWwvSnQzRHNMeWxEYjdTZE9PSUZvSmY2SDJyQ0ZUNGdt?=
 =?utf-8?B?QmFwTnhTTVF1alJiTE5DYXllUitOenM0UzQ1WUxEZVNUSjg2WjRETlFXVUt1?=
 =?utf-8?B?YTVwZFc2a3RPSFZlT0xoVzVOaWdPSnNXbGVkcm0zV1hTWU16cldWZHp4UURo?=
 =?utf-8?B?bnF4NUhESURYb2JsYWhncDNEVjZZNnR2ZU1MZGFUZ3kvSGtOQ1Z4V1dVVHJX?=
 =?utf-8?B?bzhJYVhJUVRXQjByYUZFbVBPN3V0ZE5ieWpmTE12NTBKb3U3RGFIR3ZwR2Iv?=
 =?utf-8?B?RVkyV1pCTEIrYjY2em1XWm85VzVac3Z3U0E3S0xOdWpOSXZmRnpXMHQya2Zj?=
 =?utf-8?Q?KglERW?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(14060799003)(1800799024)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 09:03:02.8764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f546b397-35e2-4629-1393-08ddaf1018fa
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8013


On 19/06/25 1:53 pm, Donet Tom wrote:
> On Wed, Jun 18, 2025 at 08:13:54PM +0530, Dev Jain wrote:
>> On 18/06/25 8:05 pm, Lorenzo Stoakes wrote:
>>> On Wed, Jun 18, 2025 at 07:47:18PM +0530, Dev Jain wrote:
>>>> On 18/06/25 7:37 pm, Lorenzo Stoakes wrote:
>>>>> On Wed, Jun 18, 2025 at 07:28:16PM +0530, Dev Jain wrote:
>>>>>> On 18/06/25 5:27 pm, Lorenzo Stoakes wrote:
>>>>>>> On Wed, Jun 18, 2025 at 05:15:50PM +0530, Dev Jain wrote:
>>>>>>> Are you accounting for sys.max_map_count? If not, then you'll be hitting that
>>>>>>> first.
>>>>>> run_vmtests.sh will run the test in overcommit mode so that won't be an issue.
>>>>> Umm, what? You mean overcommit all mode, and that has no bearing on the max
>>>>> mapping count check.
>>>>>
>>>>> In do_mmap():
>>>>>
>>>>> 	/* Too many mappings? */
>>>>> 	if (mm->map_count > sysctl_max_map_count)
>>>>> 		return -ENOMEM;
>>>>>
>>>>>
>>>>> As well as numerous other checks in mm/vma.c.
>>>> Ah sorry, didn't look at the code properly just assumed that overcommit_always meant overriding
>>>> this.
>>> No problem! It's hard to be aware of everything in mm :)
>>>
>>>>> I'm not sure why an overcommit toggle is even necessary when you could use
>>>>> MAP_NORESERVE or simply map PROT_NONE to avoid the OVERCOMMIT_GUESS limits?
>>>>>
>>>>> I'm pretty confused as to what this test is really achieving honestly. This
>>>>> isn't a useful way of asserting mmap() behaviour as far as I can tell.
>>>> Well, seems like a useful way to me at least : ) Not sure if you are in the mood
>>>> to discuss that but if you'd like me to explain from start to end what the test
>>>> is doing, I can do that : )
>>>>
>>> I just don't have time right now, I guess I'll have to come back to it
>>> later... it's not the end of the world for it to be iffy in my view as long as
>>> it passes, but it might just not be of great value.
>>>
>>> Philosophically I'd rather we didn't assert internal implementation details like
>>> where we place mappings in userland memory. At no point do we promise to not
>>> leave larger gaps if we feel like it :)
>> You have a fair point. Anyhow a debate for another day.
>>
>>> I'm guessing, reading more, the _real_ test here is some mathematical assertion
>>> about layout from HIGH_ADDR_SHIFT -> end of address space when using hints.
>>>
>>> But again I'm not sure that achieves much and again also is asserting internal
>>> implementation details.
>>>
>>> Correct behaviour of this kind of thing probably better belongs to tests in the
>>> userland VMA testing I'd say.
>>>
>>> Sorry I don't mean to do down work you've done before, just giving an honest
>>> technical appraisal!
>> Nah, it will be rather hilarious to see it all go down the drain xD
>>
>>> Anyway don't let this block work to fix the test if it's failing. We can revisit
>>> this later.
>> Sure. @Aboorva and Donet, I still believe that the correct approach is to elide
>> the gap check at the crossing boundary. What do you think?
>>
> One problem I am seeing with this approach is that, since the hint address
> is generated randomly, the VMAs are also being created at randomly based on
> the hint address.So, for the VMAs created at high addresses, we cannot guarantee
> that the gaps between them will be aligned to MAP_CHUNK_SIZE.
>
> High address VMAs
> -----------------
> 1000000000000-1000040000000 r--p 00000000 00:00 0
> 2000000000000-2000040000000 r--p 00000000 00:00 0
> 4000000000000-4000040000000 r--p 00000000 00:00 0
> 8000000000000-8000040000000 r--p 00000000 00:00 0
> e80009d260000-fffff9d260000 r--p 00000000 00:00 0

Just confirming, the correct way to test this will be, put a sleep
after the VA gets exhausted by the test, and then examine /proc/pid/maps -
are you doing something similar?

The random generation of the hint addr should not be a problem - if we
cannot satisfy the request at addr, then the algorithm falls back to
the original approach.

FYI in arch/x86/kernel/sys_x86_64.c :

    * If hint address is above DEFAULT_MAP_WINDOW, look for unmapped area
          * in the full address space.

Same happens for arm64; if we give a high addr hint, and the high VA space
has been exhausted, then we look for free space in the low VA space.

The only thing I am not sure about is the border. I remember witnessing weird
behaviour when I used to test with 16K page config on arm64, across the
border.
  

>
> I have a different approach to solve this issue.
>
>  From 0 to 128TB, we map memory directly without using any hint. For the range above
> 256TB up to 512TB, we perform the mapping using hint addresses. In the current test,
> we use random hint addresses, but I have modified it to generate hint addresses linearly
> starting from 128TB.
>
> With this change:
>
> The 0–128TB range is mapped without hints and verified accordingly.
>
> The 128TB–512TB range is mapped using linear hint addresses and then verified.
>
> Below are the VMAs obtained with this approach:
>
> 10000000-10010000 r-xp 00000000 fd:05 135019531
> 10010000-10020000 r--p 00000000 fd:05 135019531
> 10020000-10030000 rw-p 00010000 fd:05 135019531
> 20000000-10020000000 r--p 00000000 00:00 0
> 10020800000-10020830000 rw-p 00000000 00:00 0
> 1004bcf0000-1004c000000 rw-p 00000000 00:00 0
> 1004c000000-7fff8c000000 r--p 00000000 00:00 0
> 7fff8c130000-7fff8c360000 r-xp 00000000 fd:00 792355
> 7fff8c360000-7fff8c370000 r--p 00230000 fd:00 792355
> 7fff8c370000-7fff8c380000 rw-p 00240000 fd:00 792355
> 7fff8c380000-7fff8c460000 r-xp 00000000 fd:00 792358
> 7fff8c460000-7fff8c470000 r--p 000d0000 fd:00 792358
> 7fff8c470000-7fff8c480000 rw-p 000e0000 fd:00 792358
> 7fff8c490000-7fff8c4d0000 r--p 00000000 00:00 0
> 7fff8c4d0000-7fff8c4e0000 r-xp 00000000 00:00 0
> 7fff8c4e0000-7fff8c530000 r-xp 00000000 fd:00 792351
> 7fff8c530000-7fff8c540000 r--p 00040000 fd:00 792351
> 7fff8c540000-7fff8c550000 rw-p 00050000 fd:00 792351
> 7fff8d000000-7fffcd000000 r--p 00000000 00:00 0
> 7fffe9c80000-7fffe9d90000 rw-p 00000000 00:00 0
> 800000000000-2000000000000 r--p 00000000 00:00 0    -> High Address (128TB to 512TB)
>
> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
> index 4c4c35eac15e..0be008cba4b0 100644
> --- a/tools/testing/selftests/mm/virtual_address_range.c
> +++ b/tools/testing/selftests/mm/virtual_address_range.c
> @@ -56,21 +56,21 @@
>   
>   #ifdef __aarch64__
>   #define HIGH_ADDR_MARK  ADDR_MARK_256TB
> -#define HIGH_ADDR_SHIFT 49
> +#define HIGH_ADDR_SHIFT 48
>   #define NR_CHUNKS_LOW   NR_CHUNKS_256TB
>   #define NR_CHUNKS_HIGH  NR_CHUNKS_3840TB
>   #else
>   #define HIGH_ADDR_MARK  ADDR_MARK_128TB
> -#define HIGH_ADDR_SHIFT 48
> +#define HIGH_ADDR_SHIFT 47
>   #define NR_CHUNKS_LOW   NR_CHUNKS_128TB
>   #define NR_CHUNKS_HIGH  NR_CHUNKS_384TB
>   #endif
>   
> -static char *hint_addr(void)
> +static char *hint_addr(int hint)
>   {
> -       int bits = HIGH_ADDR_SHIFT + rand() % (63 - HIGH_ADDR_SHIFT);
> +       unsigned long addr = ((1UL << HIGH_ADDR_SHIFT) + (hint * MAP_CHUNK_SIZE));
>   
> -       return (char *) (1UL << bits);
> +       return (char *) (addr);
>   }
>   
>   static void validate_addr(char *ptr, int high_addr)
> @@ -217,7 +217,7 @@ int main(int argc, char *argv[])
>          }
>   
>          for (i = 0; i < NR_CHUNKS_HIGH; i++) {
> -               hint = hint_addr();
> +               hint = hint_addr(i);
>                  hptr[i] = mmap(hint, MAP_CHUNK_SIZE, PROT_READ,
>                                 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>
>
>
> Can we fix it this way?
>   

