Return-Path: <linux-kselftest+bounces-35272-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1649BADE9F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 13:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7052E179B79
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 11:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596C52BDC2D;
	Wed, 18 Jun 2025 11:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jY7dQwOJ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jY7dQwOJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011025.outbound.protection.outlook.com [52.101.65.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9770129B8FE;
	Wed, 18 Jun 2025 11:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.25
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750246183; cv=fail; b=ti34Mle7sjbdTswV4jdoxaWoYt6Cv1aFjyaIddQrBPV0KH5xOeyW+adt06/cGJS1JKZUOoEQEC+4lCZ3B2QNGnbfJQvSElNmiD1a+61QnN0Wwb1d7U5SDACCAJIxY9uXEsWEUbg0OZJZRX1DZvueF2LqDGbUEJqXDfHEuCpRTiI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750246183; c=relaxed/simple;
	bh=w89yxt3wonFuLo5GVCqnpiSPD2gJQXrUUsV8Ef3NV4U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZPgTAdJzi0SbcnxYrhwOHM5qUeQ4GkFdnSiuRGzeg+8Sjd6SEJI6+kJ4GU1UNVX16/N1QuUA+szDy/SrUgBReUjzMjn2eWoMqu8Q0fiiorJrIWmYlYFBzPSxb6mCU6E92mfZLvfkPoNdbivz0v8DP/hUqXi94lN3gEYlKSBGmVQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jY7dQwOJ; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jY7dQwOJ; arc=fail smtp.client-ip=52.101.65.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=fuGaZ/yK2ZOVJpwTGUHIorRd3Sy38hu0h7k88wPQg23nxF7Ik1UYHuTrYhvWlt8I6hTAYsakto/yPsOQpzNI9YDrmR3Ko5b3/dsXaPCtrP7QdE2cLAcrbvZUVevIHB3exTnydq9IdwxPew5Tr5TkvRhElLQdnJuV66OE498wmSTd7eNhaRn1+fDzDwuZQ+lVCUtYOhSdFakWp6l9Ffcop9IJBaE5VeQN9/I94H8pPuE/oIA9PdwWV6tYA3JzMNYb04Rp9ozOpRzQHr2W8+TIz8iaSUZvsRWnRpXh2GiADFaXcZ1AJT0AZdjLCPNDs+nRdLg0Q9GOe5zTcyv/aW5IbA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w89yxt3wonFuLo5GVCqnpiSPD2gJQXrUUsV8Ef3NV4U=;
 b=lGGwv07foEWqXuu2kVUTlwDxoXTV0/fOs3zrEbR6mvN7Nkel0mzTl7wuzPQcPKFYbhUpc7IA1IjX6F5Qp0HdlaGRI5dP223lUFSPqQ1QVsCThhEnkj9CEXt2uH654r5Ws7TCDlfPV8XLAWYLl5wcIbr9164YUmC0agCBYXJGj2yJwAFye0o20l7VG50PgmsDhX6QQ0nAWPcd+8Hg5w2OHH1lGyGogPzpxhitQa5bnKzZ91P7aitEbvQeIk20YuY6Lo0ustSoPeo/jLDODd+oWvPAtaVr9k62b9g2YJeI/Yq/NbMPDXswsb4eoPpLInCPSdE9leA09/6+FaYxWVeoRw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oracle.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w89yxt3wonFuLo5GVCqnpiSPD2gJQXrUUsV8Ef3NV4U=;
 b=jY7dQwOJ0nRV9H2mv4bJ2a59GICPxD2d4xZ2ZGzidweTXx0+OMpFA+LZvn1bsAwPHLZHmNi+wGJ/20v+MBdRty4nDCMF2lydoiTMBvK/73Ch5MBNl/z1FV7kH8d77+138dfvEyZnzOgkIhtxDVrbeeaG41H71ClSkxYODM5q9f0=
Received: from AM0PR08CA0004.eurprd08.prod.outlook.com (2603:10a6:208:d2::17)
 by AS8PR08MB10071.eurprd08.prod.outlook.com (2603:10a6:20b:633::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 11:29:35 +0000
Received: from AM2PEPF0001C709.eurprd05.prod.outlook.com
 (2603:10a6:208:d2:cafe::d6) by AM0PR08CA0004.outlook.office365.com
 (2603:10a6:208:d2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.33 via Frontend Transport; Wed,
 18 Jun 2025 11:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF0001C709.mail.protection.outlook.com (10.167.16.197) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.21
 via Frontend Transport; Wed, 18 Jun 2025 11:29:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mknIUHrCOC4A1ulbZBrKVHvLJWS+kLQNSjSBvyNvw9SjdUG9563oKzZjmAfnwZjWvoSBVZ76wzrs93vf+sPfB/EZJkWkLJ2wwsm2qTVrbAOW6bwSI9vKhxKaO4VaSb60jLki+36wVfCDoy69zLmFm1/Fh0wdA5LbAi9OPvMZ0PMy7dvxUa7vHf45pdxgzl8/JXUZidiqB10hnpyEmckNfNttdBP++ICRK3ya4regEw/ueBCAPz17otY6wd1U/WWb2S1K5sUTMnxY7IULGMKpTCTsrGuXtL7cN/SWy83rBJg9G0uyG988SOFhZ2g8UqhtaR7754EQEJVyG+ujzdEEnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w89yxt3wonFuLo5GVCqnpiSPD2gJQXrUUsV8Ef3NV4U=;
 b=i7ouub0F2piSP3Ieh0dICwrJBM4jj0K5SnhVjPdOJCVH9Zu9pXF8waUAsunmSRVuqTvNT4mi8LZw5V8/JzeUSjxBDMTLnigX9A40zJN6Gd5aDRFAU4ZizjeprBwBt5xZ6EWXoje89paV8HtPyZGIQ5wunqzf08t1FpP6+9nnhtQD6lnn+FRRv6gGpCr3wyPeW9ot6tnae0YWSTSeTwW6t8MgKRPyCYl5uPN6py5u78N69qAFN4yDU9HbAC9B3MT5Uko9CXrj2klKaLVoQOp44HhugznLxipKPSbpWTNhhos/yic+woKq2Lh65RustKL+qEJ8CbWeFoKzble7wCtXPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w89yxt3wonFuLo5GVCqnpiSPD2gJQXrUUsV8Ef3NV4U=;
 b=jY7dQwOJ0nRV9H2mv4bJ2a59GICPxD2d4xZ2ZGzidweTXx0+OMpFA+LZvn1bsAwPHLZHmNi+wGJ/20v+MBdRty4nDCMF2lydoiTMBvK/73Ch5MBNl/z1FV7kH8d77+138dfvEyZnzOgkIhtxDVrbeeaG41H71ClSkxYODM5q9f0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by GV2PR08MB8704.eurprd08.prod.outlook.com (2603:10a6:150:b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Wed, 18 Jun
 2025 11:29:02 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%4]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 11:29:02 +0000
Message-ID: <f8730d2d-41bf-407a-b44b-6cb9c1e5d4b3@arm.com>
Date: Wed, 18 Jun 2025 16:58:56 +0530
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
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <159f6939-e7c8-492c-8195-b7e8787a08f1@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::10) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|GV2PR08MB8704:EE_|AM2PEPF0001C709:EE_|AS8PR08MB10071:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ccc41bf-642a-40d1-67ef-08ddae5b670a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?U0JXaTlHWWR2T0NOcEtSYldKcTB6ZkJyVEZJWmQyNUtRRlU4VnF0bWIvMElx?=
 =?utf-8?B?Znc5YjhFYnhlVmZ0QXRqMlVnSXdiK1ZTK1k0bGJadDlCRnp0Ymwra1FBbTVn?=
 =?utf-8?B?OGJ4bmVTbTZUNlA5cXJIUzFuMlo5TmVvUFZJQy82YTVwU1IxZHRhL21qa2Na?=
 =?utf-8?B?ems5dFY0eFRlUWo4SnN6ODFMZW5YS3Zsb29RU2REc1NzMmk4eVFad1NwaUk3?=
 =?utf-8?B?SllGRFhDUmFlSVRFMFZDZE5yUzNFTHFKd2tkUUpGN0lPOWFqOTlPV1h5bE1j?=
 =?utf-8?B?TVgwRXpDTEhLUUxFWlRwZkJpNVNqOVN3cUhhTmRWRVJsM3ZmK0FIYXNPZjM3?=
 =?utf-8?B?TkhWU2hHcDJwYS90SUp3WGs3RTVvNTAxRXpjak5Jc2FReEVuZXllQWd0YkY4?=
 =?utf-8?B?clJsMGVvRDJVTnNYV21Id2NEemdOcWU0eDcwLzVTUnlYV2xpVGo0V2M0TENi?=
 =?utf-8?B?V2I5cGVRNkoxVGxNekdPcFZjUzNSb1JSTXhYc3FIWEZGNmxMMnlsc2pOL3Bv?=
 =?utf-8?B?MzZxU2pVbkxFMFJyT2tXMCt1clFIVW5na2xBVEdGSmtReWFKSDNzeWNyTmdh?=
 =?utf-8?B?Y080SGtMZndRdi9uc1QrZ3ZmYWcrVFFPbFBpY2t1RVRub0tLNE1VaHVPM09E?=
 =?utf-8?B?MGdWWEw3YVFhQ2Z6LzRUalJwNmEzREI0a1E5MVhsVzBWWXBBcmd6QjYzQ3F6?=
 =?utf-8?B?dldaTk54T2dlMkhKWDVuTHNJSzQrZmd0a0NTcFZadHpYaldBY0Q4MENGc3kx?=
 =?utf-8?B?aUxONkE0ZUNNVURqNU82NTRkQ1ZvOHpMemFuUVhqamJCWHBQUmRqZlcyS05O?=
 =?utf-8?B?bUd1ZDZhZDgveDNQdDhlV0ZUWkRRWWlHZHk2dTY4dE90TDZOVUtZWTE5OTJz?=
 =?utf-8?B?VGl2MUxFRXdFbFZRRnFxUVVrQS85ek9NRStkYTVNN0JIWEdtRnF5WTBNUHpU?=
 =?utf-8?B?eXdRWnlzTStWMHF3c3BQYTQ3YzhxWlk2Y2ExbDZmalE2Zzh0UkpMRUhXeUFy?=
 =?utf-8?B?aFRndnBNTlZScDFQR0pqKzUrNExDb0MxS0haQzlGMEc3ZWVQdGVYZjNaV0o3?=
 =?utf-8?B?bWkrazJJbDlLMUJubG8rZWdyd0c1dXo5N2NwSkxOQkZjdkpMNVhXRUVNTmVW?=
 =?utf-8?B?MnBBQmFjV2Q2Ly9vWkNDY1ExZi8vWDdrdVdvWktUZXJQSDlRZlA4eVRSOTJW?=
 =?utf-8?B?Qm53YXVWMGQwN3ZMUDF0cEpSeWxnVENHZ053aUJ3YkV5NG1HSEVwdVdtcnFU?=
 =?utf-8?B?ZklyV3c1SDFjM0RLOEtqeHh1WVM5djRHakE0RUFZdkMraWI1NnFaTlp2QTZs?=
 =?utf-8?B?K1dSeWdndGVSVjRwTnZLbGtiVXJWNWwvd1U0bFFKOEdlajFZMWdhc2tXK3R6?=
 =?utf-8?B?RFJJazZvS3pWRmFXOTRjWjIrREc1cG9WQ1JnZXFJNDBnMjA1VkdNc0djUHEr?=
 =?utf-8?B?eWpPNHYxY094b3pGRlVrL2RDTDRQZGZnVGFtSXkxNmlHRkZXNk5RcTBNbjJu?=
 =?utf-8?B?S1gray9VRjZTUEhjeGovQ0l4eW5EbXlueC9GUFNobFhtSjh3c1IzY2sveWR4?=
 =?utf-8?B?NnFlWEgyamV1ZVZSM3dGT1FzMnIycVRWTHYwQTEwdFplZkVUa1lGbzVJcGFJ?=
 =?utf-8?B?QTNGOW9kV3dYK1JaVkxkS29pMEw5NzF1cWxTQXVQeUN0ZEJ3Z3UzcUU4VUlI?=
 =?utf-8?B?WjNXdTFYTUU1SUhuN2dQMzQrSTEzRFBGZHJyaFFhYVovWXFjRGh2aGNQNFkz?=
 =?utf-8?B?N3FsNWRuUkRoWGM3SEtqc3pidmtuMWVYOGJtS1IyN1Vwem5GT0crVkRZVGs1?=
 =?utf-8?B?QUlDNjE5MWUzL0IvRkwxekdlWXhvMjBFbnJGU3dUbU1rSDN1S2Nab01kb29M?=
 =?utf-8?B?RWQzaEVDS1l4YUZiVEErWUxZZ1dNQlJRT2wzVUJFUUxVMzZKdkNTV2tLRytw?=
 =?utf-8?Q?Q23Z32SHtCQ=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8704
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C709.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	93d690ec-0ead-4b28-9a29-08ddae5b5370
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|14060799003|36860700013|35042699022|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mk5YdWJnM0hla0F6bFQyVExQeUNuMnJndGU0TmxmTHN4N20zTEFWVDJ1cC9x?=
 =?utf-8?B?SitTRGpkSzhwekpXTGw3bzVNdWNncTdadlNlMGU1aGl1S3lkenl4d21zTGhQ?=
 =?utf-8?B?SXpxUjEyRmtLYjBScDl2Ulk0RTFmOGU5Q21ZU1A3T2g0NXRYeVN6dndUOVB2?=
 =?utf-8?B?S1dTbS95bFMycUVpMzBUMElkdWZaNXBtZUV1V1ZjeHp0dGNHczFkbS9JR1Ew?=
 =?utf-8?B?dFZWT3lkSlhodDNUU3c0OHJVTXlKYTREQmRzendmRlV0RlhucFdLS25qbXIx?=
 =?utf-8?B?UXJmTW5WV3BMWkwwK0lnYktlSXhrMzBhbzczKzl1OFFpS29HdkV2MWFrSi9X?=
 =?utf-8?B?ZmNrbjlwWitza0tHaTVKL3g4YlFCeElKZmR4ZnV1SlIrQ055OUlzVUJjbmxa?=
 =?utf-8?B?ZCtGcE9BM0FSbWJBOTRWRVUrRFEyOVJ2YWwrL0Y1OHV4MmJOUENtTmV4aklB?=
 =?utf-8?B?ZzZ5anFGRmlXUjRYMkVIR05oRlg4OEZWRW1QcmowZXhacUVOOFA5dlowTTZi?=
 =?utf-8?B?dVY5b1FQcTFWdTBDenhBTTZtN1BaRlpkR3hCK3h2aVJDZGZ3eCtVNDJLczgw?=
 =?utf-8?B?KzFFYmM1cXBIbEFMUDQ4TGt1aFVrMUFHQndkRmZ4V2IyRW9aVXdlYkpUUjI5?=
 =?utf-8?B?ZjNnaWttSzlKZHJvWXhxMVNHY2tDSCtMSzVLN0dueTJHUDg2d04vYUdaUHl5?=
 =?utf-8?B?anhMQ0hHRHZneG8wYUd6NnM5WjJXcThXZDNBc093ZGo2NGMvbytKMjNaVFRQ?=
 =?utf-8?B?cEpaM3FjZURORnlaWXJXZmdoWXRDcXl0STJZSUFQZ29ocHRlZFc5RVNENFJt?=
 =?utf-8?B?eGlKSk9vdVVWVjJNZUpLQ0VDTFpJK1VuV1ErQk5yN252SjZjMzUvWFN4WCsw?=
 =?utf-8?B?SHhwS24xaUJEdlhZOFF6ZG56Zyt1bUVxb3ZJeDIvcVFyNTE4RE52UGp2MjR5?=
 =?utf-8?B?a00xdjZLaDRxTlRMdlc3S0lqaHVibGFjNWNSRlRxS21idkRHL2xOYkNtUzla?=
 =?utf-8?B?eGQ4Y1A3c045eE5jTGtZWXJMOTNZUXFYRkxHZWZvdzNBRVBDZDlHcFJSOURV?=
 =?utf-8?B?aDJ3WU12ei81WGIvVS9Zc1FkTWFmSmVFUi9ib0NWcjRxVmN0QTFFZFlRVTMw?=
 =?utf-8?B?NVdDMVhEVUc3M2Q5a2hVOUowMW4ybUxGTUVlTFRmbnhOblI1ZUhaYTF5MWRX?=
 =?utf-8?B?R1lnWjhWVkFUTCtSeENIS3J0UHREbmsycmxrVnZLVEYzNmZaLzdSUTdUT2Q4?=
 =?utf-8?B?bEZQZ000bGVTMGlvRTZvL2pTSk9iS3lLMHg3TGlGYzdCbGwveXNZUHQrMHlr?=
 =?utf-8?B?MU9PckxsUW1mbjJFeS84ZDdWQ25SUWRyREJqeEtIZjg0aHk3QnhiSEtGSEZO?=
 =?utf-8?B?TFUycEVMblJ3YUg0SDZtV2ZHRVFWOUsrc0NQMUc4MmYvSVZ4UjlFR3IydjFU?=
 =?utf-8?B?a1NvTzFRRW91RlIxc2x0bjhlYWtIQnhCa0xVM2xUR01KT0swUG0vUno4Z0hi?=
 =?utf-8?B?czhtSEpVWnlleTJsWW1FZENZOHU5UENvaU5CMDBKVjhjdExrQ0JaZUtIWHlR?=
 =?utf-8?B?bmVyWThtZGdiajlRc2F0R3hoTlRKMkhzSk05MzRGNFYyVlV6eEdna1dIWDhM?=
 =?utf-8?B?ams0ank0UzZzMnNEMFdtb0JOODI4U2xraTZ4L29weUZXOE8rcTNHWGV3MEhN?=
 =?utf-8?B?dWZNeGpkVGVodktBMVdvNFA4TFMrczJTNVplSTdSNnBBM3VleTRQV0NUSkxX?=
 =?utf-8?B?WDNZdlNkN0s4bTBhQURoMklxellOLzcxMEtQUUpSZ2xaNjljR01yNk9HRzht?=
 =?utf-8?B?cWtnOG5LWmVxSlljQ3dxalF2WWcwYnNqeHI4YkMxMUFHZXBRZEM3NmxrN3VB?=
 =?utf-8?B?cTk1T2JsaWZQN2djQmJoc2RrNmZaOWR1ZjV1UWI1d2ZoZm9xQzNmK0JWRVAz?=
 =?utf-8?B?VGF0UFE0NmoyWEFBUXdibWdOd3drZ1BNWnRuT0VUMkgzWTJuNlVBUVFtVHpV?=
 =?utf-8?B?eFJ5dFU5NW90eTNYSGVzU2JyMlRpckdwNFB2Wk9wcENBSUhVZ2JFc3EwNU5M?=
 =?utf-8?B?bUJUSHQ2K29meHlIWDZnYU0vUGpUZFFnaWUzdz09?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(14060799003)(36860700013)(35042699022)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 11:29:34.9514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ccc41bf-642a-40d1-67ef-08ddae5b670a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C709.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10071


On 18/06/25 4:52 pm, Lorenzo Stoakes wrote:
> On Mon, Jun 16, 2025 at 09:57:10PM +0530, Dev Jain wrote:
>> On 16/06/25 9:36 pm, Aboorva Devarajan wrote:
>>> From: Donet Tom <donettom@linux.ibm.com>
>>> 3./proc/self/maps may not always have gaps smaller than MAP_CHUNK_SIZE.
>>> The gap between the first high address mapping and the previous mapping
>>> is not smaller than MAP_CHUNK_SIZE.
>> For this, can't we just elide the check when we cross the high boundary?
>> As I see it you are essentially nullifying the purpose of validate_complete_va_space;
>> I had written that function so as to have an alternate way of checking VA exhaustion
>> without relying on mmap correctness in a circular way.
>>
>> Btw @Lorenzo, validate_complete_va_space was written by me as my first patch ever for
>> the Linux kernel : ) from the limited knowledge I have of VMA stuff, I guess the
> :)
>
> Mine was this utter triviality, but got me started :>)
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e1da1d573f67d11c2f80ffaf38d3cdd3fee97d4b
>
>> only requirement for VMA alignment is PAGE_SIZE in this test, therefore, the only
>> check required is that the gap between two VMAs should be at least MAP_CHUNK_SIZE?
>> Or can such a gap still exist even when the VA has been exhausted?
> VMAs are mapped at page granularity, the logic as to placement is determined by
> the get unmapped area logic, for instance mm_get_unmapped_area_vmflags().
>
> Unless a compatibility flag is set it'll be determined top-down.
>
> I try to avoid thinking about 32-bit kernels at all so meh to all that :)
>
> You get arch-specific stuff in arch_get_unmapped_area_topdown().
>
> But the generic shared stuff is in vm_unmapped_area(), typically,
> unmapped_area_topdown().
>
> TL;DR, aside from arch stuff, the stack guard gap is the main additional
> requirement, which puts (by default) 256 pages between an expanding stack and
> the start of a new mapping. Which is 1 GB :) which maybe is why you chose this
> value for MAP_CHUNK_SIZE?

MAP_CHUNK_SIZE was chosen randomly. Good to see it translates into something logical : )

So I guess I am correct, if we can find two VMAs (except at the edge of the high addr boundary)
with a gap of greater than MAP_CHUNK_SIZE then there is a bug in mmap().

>
> For shadow stack we also have a 4 KB requirement. But only on x86-64 :)
>
> Anyway I'm not sure there's huge value in sort of writing a test that too
> closely mimics the code it is testing. Setting broad expections (which I presume
> this test does) is better.

