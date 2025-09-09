Return-Path: <linux-kselftest+bounces-41014-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3458B4A03B
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 05:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D2B4E32B5
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 03:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D98256C9F;
	Tue,  9 Sep 2025 03:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Yuc6FiwW";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Yuc6FiwW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013014.outbound.protection.outlook.com [40.107.159.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE04F219ED;
	Tue,  9 Sep 2025 03:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.14
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757389653; cv=fail; b=oaLpH2XPgQ1mFAUlqWwjMQqnXSKKgerd0OhWGc676j0JxLAN9TYM/TodQMaNH1LLvc7kJOz4bhZp5esbgCHJnwaR6vYaKTSnlcanXqM1FHBS2g+H+4NMEfLsC+r7yDapKd6hWmu3Ny1+jOZgrYExB6Q34dVdnfoYzZP2N73Bfbs=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757389653; c=relaxed/simple;
	bh=6/CmQK0kUpzdo5y+76Dg128HUTnM019JMczVdAKCKuw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ah8Y+Git9+xeDQn3GLDb0Mgv5CR+stlLWK+b7xbOCBbI4233OYXE+b25IRxkXT8Uy1+Eik34mcPmNvPwFdNUQdpFZUXNz7AQNVnxmefFEJW/G5RVOuNaAVx8SIhxdSoAZYEmstcS8iMYMM8hVtv5eKA4wOen9LARCAsGX4OcW4A=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Yuc6FiwW; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Yuc6FiwW; arc=fail smtp.client-ip=40.107.159.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=wS32iU4TSKVG+CZHChIHroP/yQRKexyAhozq1cf4TZyBvn7mNr6HFg0Z2K6MSp8i6qW0FtnuAW1ml4OPGvB7FfUSI0UNp/Qqro8IVba9kGxLMIIKkxUWsKsYzitMNSrnjkPHrxaSIIus5gyeoQZidXUSYT247RXI8rta1vbbNeTGcTfGkrZO9N3KJxrTGIuyfYkL1T0jGtdluchKsS/E9dHeZpCCt0vh5uNabEu98DmAXCggh0eqNzI+tAxYf0qGa8aEibV602ml9VAXpEw3HTDyYKQg/SDmoHdh7CtyzAfN7nzbmKFrCTw9Id135uqOYagoATqyXwExHed9SAfFDw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yC3jxfDQdK19Lg0r/CiiKgEftj7vGy7sqYfWIXekeBA=;
 b=aumCoybnl4dF109YGwfzPp7tZCE9m/N9WlUb1fwvI+8sblD9bEMK9ZUF8HvQQDyNPyZWSsZAgwciths6V0AeC3+2swtsdkmXf58sjwc56KJKAXaq6DeD2Y8+8OxOqwJ3h3dq6VucEn1+QQXH+5UO/qVY5qWd8hVo5PYOvAkI+8GLDSDLYaveI9AEju2HEA3c/vwE3eC6F8CMQaE5oOFaaUc/RkB1GwcNHvj+gBP/y6fAsVWgoGy/ZVW6zhZgC8XXGF+o25Ow4HBpZVpBGEEeWDaPoYX+FrnBK9V6VUhj37aQU/+svwqudw1FovTLZz+TAY16FaY1Rb8/4o0CVnsD9w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yC3jxfDQdK19Lg0r/CiiKgEftj7vGy7sqYfWIXekeBA=;
 b=Yuc6FiwWh/ZalpcxflI2fuhHKqrJMFUBvJBzITeFojP2BQXQJPfKev/kJAKu8uo28Aqm9NShM2wuakPCE6IayrxVFhIXCxgj+fgA0E7JAq5edP7iyXBnVFlYdXqOQz0OxnrEnNE6RgfAyPmUWeSrMbAB9iR/8Asc0jvfPnNwrYU=
Received: from DU7P251CA0009.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::29)
 by AM7PR08MB5368.eurprd08.prod.outlook.com (2603:10a6:20b:103::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 03:47:25 +0000
Received: from DB1PEPF000509E9.eurprd03.prod.outlook.com
 (2603:10a6:10:551:cafe::a0) by DU7P251CA0009.outlook.office365.com
 (2603:10a6:10:551::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.23 via Frontend Transport; Tue,
 9 Sep 2025 03:47:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E9.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Tue, 9 Sep 2025 03:47:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AOk9NE41RChMqHcNyrK5/rRNMR2ecorZP+aHCjLCB1Eaj0AUilryTkZGa0cL8osD1HkM2ldKw4zy6/u7bUBQXkNO8AVJrfHC+SfQBfBQeaJNBGsEEpY2gtd4U2JYaB7s7rosHWTRM9TVJZvorydn6OaOF/nHWxcKjwMqoMTK6AgsxWOxYP9m6z27ynqBsRBgeyF7Cx5dx1V3NLPgOrQuk/GDbedd50+1zt/PVyluS2eneCkVl6NU/sFRtAOvlHkijka1eLjIWiwlvV00u1ZUGIL0BZ7btvZVl33YsCCjTQPSfcCd9T+eAwCTLan8Pal1LKLcMctpmXVCgkNQTMkiqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yC3jxfDQdK19Lg0r/CiiKgEftj7vGy7sqYfWIXekeBA=;
 b=wf+wkGknj8ysYWTiF1jy1kz1LCSjElXAxg6GGn6yW6yKkCZWIrBFuUr9Sqb76a0kjiybKVPGoHbBYbpahZcXfCyajbMoIYRU0LRocTZyhMVIQORdNz0Z+LWviU1rP4RJQA1gwDYuwPZSvGB3YpxtFfphZ/OwPcak7Qpas+XMmSFNV9VrLpP+QHcpL7iKgEmX92v7MEfXCbs+QVXiRjHzAMHdkZslXPPwikW/crmMypTFQSkL1TpG5SbNvalntd0gZJmlqS8ADWzutwJGs9sFtq8Renaw1sI0n+ZBNgtj9+fkgTHtILKqOrS0X/4F3C/yD97CF/6sklx3+t1HsfciXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yC3jxfDQdK19Lg0r/CiiKgEftj7vGy7sqYfWIXekeBA=;
 b=Yuc6FiwWh/ZalpcxflI2fuhHKqrJMFUBvJBzITeFojP2BQXQJPfKev/kJAKu8uo28Aqm9NShM2wuakPCE6IayrxVFhIXCxgj+fgA0E7JAq5edP7iyXBnVFlYdXqOQz0OxnrEnNE6RgfAyPmUWeSrMbAB9iR/8Asc0jvfPnNwrYU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by VI0PR08MB11429.eurprd08.prod.outlook.com (2603:10a6:800:2fc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 03:46:53 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 03:46:53 +0000
Message-ID: <1e37a524-030e-4c00-a6df-26a5e3d8e9e7@arm.com>
Date: Tue, 9 Sep 2025 09:16:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] selftests/mm: uffd-stress fixes
To: Andrew Morton <akpm@linux-foundation.org>
Cc: david@redhat.com, shuah@kernel.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, npache@redhat.com, ryan.roberts@arm.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250826070705.53841-1-dev.jain@arm.com>
 <1634f29f-81a6-46f7-86d4-c9eac953d4f1@arm.com>
 <20250908190248.d2d6de27715fefc4e89afb10@linux-foundation.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250908190248.d2d6de27715fefc4e89afb10@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::20)
 To AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|VI0PR08MB11429:EE_|DB1PEPF000509E9:EE_|AM7PR08MB5368:EE_
X-MS-Office365-Filtering-Correlation-Id: bb78b6b9-f07b-4970-318f-08ddef53974d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?Y214Nno0RDQrSnljRmk5b0pCZWQzQzljZERMUXVJVG5DTWdvTXppZlVuTlJp?=
 =?utf-8?B?REZxaUl0NU9HdjQ3ZGdTYWxrN3VDbEQyd3dLNFdGUjZWQUpsR3hsQldzTHlF?=
 =?utf-8?B?QlhJSWcwZHlYY1hJTkEvUnl3NGlZQkhmNFkxNW1YM3NEc21KRUczdzl0ZnE1?=
 =?utf-8?B?VlYvb0xCMXhCV09CcjBJQWVKcXduYS9NMEViRm5Gc09aMDJhTlZQakh4V3Ja?=
 =?utf-8?B?WHZlVFpNME0zOFhSR3FENVlNWkZITjRXRUpQKzREOGoyVTE2eXdXb2hFaitN?=
 =?utf-8?B?M2h0TVkrODZyYzFPdnBWcEVwZTIwQmZYNU4yOHlvWkg2OVdnZGJuZEd5Ynhj?=
 =?utf-8?B?QXdBM0Z4Q2RmSlBVcHFBRDA0ODZ5UnlXNUcrSDMzaHpIV2RrU0IwaTg1K21F?=
 =?utf-8?B?R1RMeWptcEJNbzVxZWl6NGZDRHFXVHNiZmN6YTdjYnA0WVh3bWVrU3pqaGZT?=
 =?utf-8?B?RExPZTFEYTN3U0Fha21Wc0FHY2FHSithaU9xYW5NRGNlZHV5ZWpZZENVY1lB?=
 =?utf-8?B?UEtTODhLY3ExZ1dEWUttSFhYaHU2RGYva1VUTkM4RnFNM3BkV2NReDBXaGlI?=
 =?utf-8?B?Tms5THplOU9wVjZ5QW9DcEU2eHRSbndxd0l1KzFDekM1VmZjUmVSTEVDekZD?=
 =?utf-8?B?MzN2Z2Fjc2hDdkZQVFlpTHVxeExIK2FwdXFqVUlPSUJHZmY4THhFdmFjQS9k?=
 =?utf-8?B?UmJVQjcrQStvTG1MTE9wNTZzYW5mVUhEVnJKSTRNbGdQSXc5NGxMMEN1ODFr?=
 =?utf-8?B?RkJLMW5RMFNhbHdUMmJqZWVmTXdEc1BtR1BTSW1GK3pNbDd1VkxlUnh3emVE?=
 =?utf-8?B?UkhYZTFXUjlEc3RXV1FXMGlrSHdQTkNWY3pxSVRaaENsZGRaRmN2ektQaTUw?=
 =?utf-8?B?dXRqSlJvRWtZQzd2K24wY09KWlozOE5HYU9HTm4xcm1ERzNPdlBhT2cwbFpW?=
 =?utf-8?B?Yk14WFJCdkFlVDI1czdMTnltUnFRaWRwUjhzbkJEYjQ4b0Y4OXJ6aURCcW1P?=
 =?utf-8?B?aWsvRDFUY2VwbU5DUktRc1BNcmxxY1lZQmZMOFp0dEkyMExZMW8vOVYzOFpV?=
 =?utf-8?B?RTl4SDNDY1JpT0RlK2ZiazI3cjc2WE5KUk5kbG9BSDZVYnJ0THdBRktVbkVL?=
 =?utf-8?B?V2xGSGF3dkFtVTNQS0pIN1lQZkxNTEhUbldJTXdEQ2t6MFFJaVJYby9heTBM?=
 =?utf-8?B?WmorSVY5N3F0Z3hXNjM0ODEyck00ekJZRXA5OVdQSGlIbjlzblo4SXlFUm9O?=
 =?utf-8?B?Z2FWMloxaVRmTDlTaXpwWDZ1eWpMWk9WM010V1dEZm02bFZ0SnlOZG1HYVQ3?=
 =?utf-8?B?UExUMUxiSW0zb0ZWb0xJQ29jQzdCN1liTzY3NzdaWlB5YjhTRTYwYW0zeGFF?=
 =?utf-8?B?WmFQcjhQU09rQy9ZQi9RMUFLOVBmRmJmZ1luK2R2VGdMdk9DaHF6cE51NU9z?=
 =?utf-8?B?eVJIQnJtOHZ2aGU0VFBmdlhsRWt1cS94RWVVVDlpbXRGQ0w5dGZnOWpPZ2Rk?=
 =?utf-8?B?VC9RWXoySWM1RGZjM1dQaE9QMjdhdjQwcG9TY29uVTlhbTlvdHhYSzRwTnd1?=
 =?utf-8?B?L2daT2x4cDdlMHhmR2NCc0p4b0puZGJoUnY4NSs5U0V2R3kzeVhtVXZKelVP?=
 =?utf-8?B?dWFNQjVGUWxUaU5IT2dJdVpQVVhFVjZkQ2U3N2FZWGNNK0NqOUxOY1ZoZU0w?=
 =?utf-8?B?OUxvQkQxS2plek83R3JpeEdvZ3dFOFhwWEdsUE0zKzdScE5HaXRVYnNMK0kx?=
 =?utf-8?B?SE4wbG5vcTRRSi9ZYkhmdUk2b1NwNFQzWFI2Mzl3bHExYW5kRVpUcEcvOFJP?=
 =?utf-8?B?STVZaHZwMFlGV0EweWU1ODZhK2VDNzVnK3RmdDF6WWNpNHpkVGhpRDA0ZHZt?=
 =?utf-8?Q?fhu2+vw8wM8+c?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11429
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	190d060e-d732-47fb-5b4c-08ddef5383a3
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|35042699022|82310400026|376014|14060799003|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVRVN0cvK0NHSWpVazBrMjZNOU13dU1qbks1T05DbzlNWDZvRTZxR2VlYmps?=
 =?utf-8?B?RVJ0VmYybk43dmRqckZTOUs0U1REcjJMaUFDUEpwaXphbzNzM2pUa2hrOUkr?=
 =?utf-8?B?QjdUTUFMZDU1U1g0WlhtTHZlMGk5ZEFRN3dyMVNPcXFobnFLeXdxTlowSVJ4?=
 =?utf-8?B?RGN5T1JHYnFaYVhUSzlYaWw4UjdLKzhERFdHZmFHaWNRRzcyM0diN0wzVVI1?=
 =?utf-8?B?MmhISVI1RkdhUlRoelgxZmEyMnBqRVBpR1RJejJzblpQVWxqTXhkNmpvTXBO?=
 =?utf-8?B?dVBOb0lhZzBQU29TNEcrK01zb1FDUUtIZ3pVU2ExR0ZvVnpTWDhKK01FMWUr?=
 =?utf-8?B?QXlZN25YRWVTRVpURTFCaTlOQlZOcmZwRHV6Q1NvSXZvbmxJcmxocHNLb3pL?=
 =?utf-8?B?R1UyQU9jTDUxK0ZxS0ZOK3pibG5iMm5YTjZON0NscVdyaFdpSmVEeHhpU3da?=
 =?utf-8?B?b0o3S285Y1h3d3J5T0RYWG04SmVaMzBYcFJ0RVlOZENKZjBpbHhDNFoxQXF2?=
 =?utf-8?B?MVdDTkEva2QvT2lEZjFza1NDa09hR2MvT1p4aXR1N2NaZmRGc3U5SU9IZEJT?=
 =?utf-8?B?K3hWZGlVNjE2Y0lrUXlWOU1pWGdwOGhRN2htU3JSZTVDdG53cE0yOVhidml2?=
 =?utf-8?B?RVpPbTFKSTFwR2pQQWVLQnA4M1JKWDJvYmRFQzk5KzhqdWpObWRNUmxQTS9N?=
 =?utf-8?B?RTJWeWxMbVVuWGl4QTllVThEbnZBbFpiY05HWkcyVmpMUGZxN0dHQktXTXJU?=
 =?utf-8?B?NWRlTlNvcWtCT3dXZDl6ZlN4LytkVHRxbGM1TXJlQVlHTWk2YmZ6ZkJKNzNC?=
 =?utf-8?B?TllMS3IzRElFWTNEMnRTNmNPQzU2V3JTS1h3N3dvd0U1Z2h0Y3lKT2NMb09F?=
 =?utf-8?B?RWV5K1NVM0VGcm9tZFVibk1ybllFd2g3L3lDZXpwU1kxb1g5ejVGZXB5TXQw?=
 =?utf-8?B?VlR6dER4emkxYVdJUWhSRFBya0NTOUkvaUZQUWpaRW1sVEpydVpJaDByak9l?=
 =?utf-8?B?YnV6NWN1eXFYUzdDM200M2lvb20yVzkvREhNOEhPTzdFYnpqSmUxQ091VjBL?=
 =?utf-8?B?NEpMQzZLaDI2UEVkSEVPRWtrZU82SFcxRDY3dmJBNy83NTBIb3Z0Wm5zNU5M?=
 =?utf-8?B?TDk1S201NTE5NmRlQUM2bW5HV29nS2N3aEVrbjRzYW9HVFhHSXNQTVFvOXd4?=
 =?utf-8?B?b3I3aFoybjJvdDhFTDJ5cGtpMDJSVnpMUnVZcFUxdWMyZlNtTzU2UUNaNDdU?=
 =?utf-8?B?WHlWTjByb3hSaUZza3pRdkxBaUd3UUI3ZndjTEk1dEhBaGtWL09hU2NIZEtv?=
 =?utf-8?B?bVlUMWdaY1dnU05FWnJRcm1yNWhrVUJsc1hjRnlldTg3TDIxL1JESXJ6N3By?=
 =?utf-8?B?Lzk0RnJDakFrUDJuYmh5NW4rWWpOTE1IbmkyaE82MHV1MkdkQkxpZ00yVFZI?=
 =?utf-8?B?OVBtVkh6cEQ3Rm5rMXZzL3BGMjQ0clNJcU05Y241UEpjMHV3TzFtWnZOWmM2?=
 =?utf-8?B?MzZTWU5LcjFPWHArQU1VcDFqSFhQR2I2L1M3WmYzbXVUMU12U3IyVGNMODlW?=
 =?utf-8?B?aWEyRHhmdnhTb0Npb1JGcWJEelFTc0VqVzk4cHdxdndrOUx2YkJXWU8wUlBk?=
 =?utf-8?B?L0I0bVI1UXBDY3ZTMURuZU55UEhPS0RHbVVHdGloV2s3c01MNjc5cVA0VlMv?=
 =?utf-8?B?VW1SOHc0QW5nL0g5YWFzbFJkSFowYmpWVjVlN2JHWVd4M3NqQ240YkVJMVRI?=
 =?utf-8?B?TjdFbjNrZUtBUzZiVURhQW1uaituT2ZCcHhnY2llRldVMkJwQmI2eFRyWVpx?=
 =?utf-8?B?UVJJcEJTUEtBR0tDR0szUkpsSFlUeThRNG1ZeERzdXhXcFdXcjhzdUVObmVQ?=
 =?utf-8?B?YVFXbkQxdFYrZlFva1lWdnFwWXlody80UnEvbUEyNSswMkkrSWlTWmEwRXNi?=
 =?utf-8?B?UzNiN2hGbEIzWGxDd2M3bkhWOW5vQ0h4ZFJDV0VISlhXaHZBWVcrN3BrSzJz?=
 =?utf-8?B?R0xxaDYwMHNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(35042699022)(82310400026)(376014)(14060799003)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 03:47:25.5115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb78b6b9-f07b-4970-318f-08ddef53974d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5368


On 09/09/25 7:32 am, Andrew Morton wrote:
> On Mon, 8 Sep 2025 13:52:05 +0530 Dev Jain <dev.jain@arm.com> wrote:
>
>> On 26/08/25 12:37 pm, Dev Jain wrote:
>>> This patchset ensures that the number of hugepages is correctly set in the
>>> system so that the uffd-stress test does not fail due to the racy nature of
>>> the test. Patch 1 corrects the hugepage constraint in the run_vmtests.sh
>>> script, whereas patch 2 corrects the constraint in the test itself.
>>>
>>> Dev Jain (2):
>>>     selftests/mm/uffd-stress: Make test operate on less hugetlb memory
>>>     selftests/mm/uffd-stress: Stricten constraint on free hugepages before
>>>       the test
>>>
>>>    tools/testing/selftests/mm/run_vmtests.sh | 2 +-
>>>    tools/testing/selftests/mm/uffd-stress.c  | 2 +-
>>>    2 files changed, 2 insertions(+), 2 deletions(-)
>> Hi Andrew,
>>
>> I wanted to make a v2 of this series to replace 10 with min(32, nrcpus - 1)
> That sounds line a one-line change?  Send a one-line change ;)
>
>> (see computation of nr_parallel in uffd-stress.c) but I see that it has
>> been pulled into mm-new, and on top of that, the following patch makes
>> things complicated to just revert my commits in mm-new and make v2 on top of that -
>> https://lore.kernel.org/all/20250830033424.8C44FC4CEF0@smtp.kernel.org/
>>
>> So shall I just send a new separate patch based off mm-new?
> Or just resend the whole series based on mainline or something?

I'll do this, since the change will be more than a line. Thanks.


