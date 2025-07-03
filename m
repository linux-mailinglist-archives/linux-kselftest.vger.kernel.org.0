Return-Path: <linux-kselftest+bounces-36403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1275AF6C96
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 10:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E73B1C21540
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 08:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FD6298CBC;
	Thu,  3 Jul 2025 08:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MwLJ0Ycz";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MwLJ0Ycz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011000.outbound.protection.outlook.com [52.101.70.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B003C22069F;
	Thu,  3 Jul 2025 08:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.0
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751530586; cv=fail; b=ArAzgNB3evh7ytBsAI/P6U+cyBTEZqsynBPsiCWweg3EsjkujvkquVEPk5p6fbWu/oLf6EGvF4tZ4lADn4j3G5hFjC8EjjGXqS+8jpdcc/XtTPyApL0B0+BcajrcYyRnL37nsQqcZj5d+Mh+hLNlkxLa3DYl5rWvj4+mrgrxzLI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751530586; c=relaxed/simple;
	bh=P4VyyKCgWAin6YzpxbYc7fqf0pTNCbYspyGIQ7oFo8g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jKEZtb7nIG0wYArZwl7cvHVooqsXgTqG5/Cj8iuKa5CksnCH6dLosdDWSPC3rpuFwfsVPZoPO3T99kl0pSU7mQGuNdxDRPbZzwyH0m7OLB/zL5QGBniuWVGGGrh6UOkw2UvJIsdvu6RCg7YCcFVkd//P3bNXCo1UhZD6kswW6h4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MwLJ0Ycz; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MwLJ0Ycz; arc=fail smtp.client-ip=52.101.70.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=zG937jkUtaIarauGhafhUJUp4iniB3k2xVUPLiAGf+GpwpLSnG0i7ouQz1oMfwSg9w9Z/hgJTRawsaWtafG/N1L1gyDlMb2u/lJjNmW4Rl1dYxQ2qSNdDlN91/+4kgWZLCmv2edmH/f/aHX+Bwu39dK+iZkBeKN4xd+ZU3ssGCoMb3JoQb9OoTdRudU8ARBXdXrRa3LS/fpI9mUDuQVOiZTFXJj8k3i+qXeSrUfnyNegSGYzEoLYZG+MEeVcdW5xni6tvJgiSolDFLHBPwuXU9TEBMM70tJRcl7c0YaWtc/0Tp/Ipt/EAVkeM0f0W92QcFd5LxFz9i8AJjXhULH2ag==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gr2iVpZlHQ2qnqdlut9eylV17pUxCmQaUlc1oL2KnPU=;
 b=RzvCZ/M4h43AoWXz9E7CDK10JWLkFRtxSCE18kP72/fogSHecBCB93jbrLpfUpihxTysgGOsHrAawJ+TwyVVd+2R+ELV1FcIIaEZ5jBZfzscZyc7qNg5DCcJxapQqWz0NUoCmAYWOY6PZADcCiaVjBZjXAZHu3G7pJfOENEqyFX6U7erMnEedbLIYGYHQV44mKqD/DfnKMi6Hmvzj+vXbIOi5UcRfJ9dMbY7K3qpRyCbPS12tQ7VFDYnyFiGWWxr23uPoSJrUJsZxjFvTO5IstVUyvuvHFUSuzqDIe0+BH5VyFcHuocYMDk2YNsteTA84Wp+dovP3v+MITNzqJ/Bsw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gr2iVpZlHQ2qnqdlut9eylV17pUxCmQaUlc1oL2KnPU=;
 b=MwLJ0Ycz3bc8TZKmYU8UAIgE6qle7756CbtdCI/3HOg34lENvH2yJStmKqfZYCMHjZFom1lqn0q+RbKs2EElwboLuJwZ7DqSOyy5+NY/JrsCy/BLXm+DxGF+NLj8Ro08uwFxgKwGIE6jFelQCTCApcbyiH35l6O1OXgV1jUhM+I=
Received: from DU6P191CA0049.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::8) by
 GV1PR08MB10855.eurprd08.prod.outlook.com (2603:10a6:150:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 08:16:15 +0000
Received: from DU2PEPF00028D06.eurprd03.prod.outlook.com
 (2603:10a6:10:53e:cafe::ec) by DU6P191CA0049.outlook.office365.com
 (2603:10a6:10:53e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21 via Frontend Transport; Thu,
 3 Jul 2025 08:16:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D06.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Thu, 3 Jul 2025 08:16:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJxqKhtabVxPiCiw3u15YQufUPfuv753x3IbqnuD4hqeRAuGPVeLgwYfikBSQPmY0ZXMuo5G8Z7f394m/eX9hGInHnowcAqHW5CSv9PIKB++TsRl6GN8o01pRiROxcXHuOdNUf90IcTd4TNzFJ8aF848L5K7+LxmYk+Goad3pgxeBWwfSHeb0XJE7YH+6tixPhNFpNFH0Woge4J44lwx9xfxlbjTAuQ550rEl016p0np+HnChrqFdxYF1pKptnL11sx4NxxkO4HDKNEzwYonNAKh67ZMZcAVjx+bdw5kURAJsc8j0iPtDzQ8MB/oCLHYjpCRCgwoiwvYKUXf69PPcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gr2iVpZlHQ2qnqdlut9eylV17pUxCmQaUlc1oL2KnPU=;
 b=qtknnDXj+cimYr/rhEdyVkukdZT658P7yAqMTYz32g6SaL82zHVRy6VDVFp9lw1xLke7LGlJr+0brI+Bc38e28Jt3SNx01trmbPzGx3vA8EDRgVOzluwsEch5wJNwuL/PKNKiaWjoA14OvaOpmm1WN0AzWwpedWhVIDWOg+THOH62HOvwjsjTY7bikpJC7a5jfmg1TWkmKi4qaGhtZx4NIM/RBUqVsN56XBBiibxAE9MBysrrbg1L2udV2yUA7J9L+Jfxmox7oZweHwztl8IM6CCezWu6+wRtasFrP+RVgQBl7e7vI/pUP49/py6wVtur902Ncjmx9JNBxNZT1zKYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gr2iVpZlHQ2qnqdlut9eylV17pUxCmQaUlc1oL2KnPU=;
 b=MwLJ0Ycz3bc8TZKmYU8UAIgE6qle7756CbtdCI/3HOg34lENvH2yJStmKqfZYCMHjZFom1lqn0q+RbKs2EElwboLuJwZ7DqSOyy5+NY/JrsCy/BLXm+DxGF+NLj8Ro08uwFxgKwGIE6jFelQCTCApcbyiH35l6O1OXgV1jUhM+I=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DU0PR08MB9347.eurprd08.prod.outlook.com (2603:10a6:10:41f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 08:15:39 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%3]) with mapi id 15.20.8901.021; Thu, 3 Jul 2025
 08:15:39 +0000
Message-ID: <e26b337d-336a-4d2b-a625-881500bd5a3a@arm.com>
Date: Thu, 3 Jul 2025 13:45:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] mm/selftests: Fix split_huge_page_test failure on
 systems with 64KB page size
To: Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, shuah@kernel.org,
 pfalcato@suse.de, david@redhat.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com,
 baohua@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, donettom@linux.ibm.com, ritesh.list@gmail.com
References: <20250703060656.54345-1-aboorvad@linux.ibm.com>
 <20250703060656.54345-5-aboorvad@linux.ibm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250703060656.54345-5-aboorvad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0111.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::17) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DU0PR08MB9347:EE_|DU2PEPF00028D06:EE_|GV1PR08MB10855:EE_
X-MS-Office365-Filtering-Correlation-Id: 57251730-a016-4d2f-ed2e-08ddba09e0ad
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?RmQ4RzU1WmNzaWI1bGhIQk16bGVtV1N1MVcxazhqTlBuSlAvK2tLcmkrVjNZ?=
 =?utf-8?B?SGhBOGJVbWdxZlFlZjBzeTZSN2ZtNTduSVVkclhLTFFENHpMb2VENS9GV3pK?=
 =?utf-8?B?dVl5OHhzQkZqVVloUXhDUTIybTVLUm81VTVOTDZ1Q3FXR0E0UmVsL0cxSXhq?=
 =?utf-8?B?K0pHQndFbDRRU3gyZGQ3cnRmVllLcUQ4MnNocmdtdnlXSEpVTU51NkhzZnhw?=
 =?utf-8?B?WjU3SE1UQUIvcit5SjZXRDc2ZlRQVjdNbXlnSGZFcTdOR3ZGU2tMSUg2MWI2?=
 =?utf-8?B?UkhFVk53cFQxWm00cnJuTkFFZFpnYjM2U2NsMDZXMitrY1R2Vm02UFhyazZz?=
 =?utf-8?B?dGJtcUlyb0RnSHROMy9MZWZnYmRxcUFPa1IyemIrTXdKdjhMYUU2aXJkWlBx?=
 =?utf-8?B?ZGk2RmsvcEFSZUVtdWUyWGExL2tybCsvMGRoOXFuS2F4aFkvaWlHdkNBbFU5?=
 =?utf-8?B?UWpta250L3JueFFEVFhydjY0b0RVRnJ6akZKcjJUL0lsVmgrYUVaY2p1Mlo0?=
 =?utf-8?B?UGQ5VEdrelEvQytURzBMM1U1czhQVkZOZ3NEK1p1MGhZYUhiNzVLSEl3K2Ny?=
 =?utf-8?B?c0k0Yk8xME5mQ095YTVWdkhCREExSVBSQTlWUlNjOUZ6WmUrNklWamFKbVlE?=
 =?utf-8?B?Ris0RFNrYzN0WHJDYTc3NWQxVVhjSytmUzVEYW1NckRDMWVoeHJpYzBqeVpt?=
 =?utf-8?B?bVRzNmNIYUJUYVQ2SUlrNjdmYUtybVdMZWtvSERBUTZ0RHBKaEM3bkFlK0FF?=
 =?utf-8?B?T0VYSVEvbFQ3M3k1SFRDOEZXTEh6eHFvNkU0bFE3aEIzakRGYkVTVTE5enhX?=
 =?utf-8?B?cVA1TmlkVS9Va1JVL1kvSGVJcUZwenhGdEY0aXdqS1g3ejNKSDUvY3JoT25T?=
 =?utf-8?B?MVg5ZGVna0hoYUFBRzZvRnlsUzFsN0xrZXluazJScGxKZTRnN09CU0E4cndJ?=
 =?utf-8?B?OWtjTWlNZDZoUElpNEpCcFR5NGVkTmNmSTJzTjRzb3JIRXJIRVZDTXRMS2JE?=
 =?utf-8?B?N2FjVXc0ZExhL3dmYXFWdkdRenBEN2c2dHhmTk40T3RXNU5CaGhXVlJzem1N?=
 =?utf-8?B?VkQyTUlQRXJGVk1OckxNVXNkYVN1emJZbFNaTVVBQnpydmRoZkc5QmlEY3ZP?=
 =?utf-8?B?QUZpL2Z4SzlBOE9NQWppRWlob0MwVzIxVldscU1jTWw5dnhYYTEwSGxXSXN0?=
 =?utf-8?B?YUZJZkQ0QUNZN0VHa0xIZDk1eTFqdkdZRllJVzE0N1lIR1B6aExOUWxjZEFp?=
 =?utf-8?B?Z1c0TTRoL2V3VEFzMzFCeSt5RWdrQ0RqcVFNZkNYc2M0MlczajVNOXdoUHJh?=
 =?utf-8?B?UmFqOW9TeUdPRmtCVDFQM1NxZXArN1ZYV25RSmNoeHZFZUYwaFgrRHNNY0Jy?=
 =?utf-8?B?QVJmdTgwdXE3WjMrRnZWWG5XT29QV2hHUlRkM3MrWkZUL0J6Vmtra3Vhd2xW?=
 =?utf-8?B?S2thSEt1My9VS3A3SU1vaHZXVllLb2RhSVF6eFFNdGVacThjekMzeVlrckoz?=
 =?utf-8?B?aFFHenJYUGZZbFZFWldDa1lTZVBWRDF3Y0x1UkZMb2dXUVNRQVN4YlMvR3Vm?=
 =?utf-8?B?VHNLT2RmVXRrNVhCMzlQcDlCUGNzenFGSUFPbzJuOFBudjlRN2crdFZWa1o0?=
 =?utf-8?B?TStLTXBmUS9OUE9YUDVzYVBhdkJsM1N3V2NidlVUU29Va2wzV1JNUlVpRVIr?=
 =?utf-8?B?czVhSHl6dXVpbUQrbGUrSlZlVXF4S0R5OUg3bXhacWNBM1RhbEJrQlhWTzc0?=
 =?utf-8?B?NWdoZGtOMFhSbURaRWFxdnkrQkxnbXdaaVJhUU9jUEd4WS83dndIVWorbzRZ?=
 =?utf-8?B?eEpvSnZHQ3RjM1dvRWVJNTUycDgyeFFiZkROWU5tMTdrT2R5LzJrem41ejhk?=
 =?utf-8?B?MUI4VUxkSWJqWXEvbWV1dWV1S085RTRsRm4xNWJGZ0I3Nm9OcU1reGFEQmpo?=
 =?utf-8?B?UXlhcTRaSzBXb1VBUjhQNWFtYmdJY2k4MjRsOEc3dEY2cW1NWkRQVEoweTRm?=
 =?utf-8?B?Z0tLR0lXT1hnPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9347
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D06.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c106ff5d-bc93-4417-592e-08ddba09cbe7
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|14060799003|82310400026|1800799024|35042699022|7416014|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SCsySmtXVkdFSHNTU0JKc2NPMzIxaHkwQWdFbjRZeVF6cit4ZGJLRUZoQ1Y5?=
 =?utf-8?B?RTFUOTVvVDBYVFp4Sk5SaUxIM2s3cEpnVUlMQllXTTBNY1RLbFMrRkYrVjFk?=
 =?utf-8?B?NDJmZms0TGZGeENvMS91QW5LaFVmZ281ell5by9tZzBWY3lNMy80d3pHS1hy?=
 =?utf-8?B?cnpGVk1OdVMxNndJMFd4S2c5RVZ5WkNFOWVhcVRoKzBIWkFGWkNoYUptSzdP?=
 =?utf-8?B?bzMvUVh0d3RlWHBETWJJUUs0dkdHOGh1SldGaWJ0dkg0aVVlMTdBZzhQYlRC?=
 =?utf-8?B?c2tLNWVFYVJqNXJSdHFEbmltcEhJN3c5TFpCYlhjMmFpdWp0YlJZUGFjeTFU?=
 =?utf-8?B?d0pWeDRBdTdQRE1Bck1RZ0xnRnNKMkErczkzQng5MFh5UFNqVXRreFlQVE1s?=
 =?utf-8?B?OThoQ2U4SzdYQzFsSldyMU1Iam53M2ZsOFZneGFBUVZPQzNjbEVraVRIYTYr?=
 =?utf-8?B?U0tkMDRqeExnRk1Eb2wrK0l0dzlTWm9RNGdCcWxuRldScUEzaHpHeDNVU1FS?=
 =?utf-8?B?MHJKTm5EZWRHYmJEc3dKTk1ENERGckdXYndqWDN3NWROSkxVQW45QldjeC9W?=
 =?utf-8?B?bENyRG11RUhmRitDV0g3RENLYVQzT28wMk9zLytlWFoyUzFBVEdJeFNKUnl6?=
 =?utf-8?B?MnZKd2MwTWx2Y2FSc0JwQUxiYVVNRnNDaTFBUXg0TFdITXJFc0hrZU9rOXUx?=
 =?utf-8?B?L1U3NS84bEhXVjlKYnJudXhmaDZSbldlSVBITzVvamJ2OXE3K2xMSVY4V0hP?=
 =?utf-8?B?clEzczE2NUwyeTdMZHdyMWJnRXRBWmFkV1RVcWVUanRLVG8veEVMZmNNY0N5?=
 =?utf-8?B?SHRhVkNJL1dsUEhiL1JVQTNnMXFWRFFOZkRZVWpoUGtuN2VDZGtFaFUrUVFL?=
 =?utf-8?B?dGRNUkQ3ODJyUGlPOUkwTzljL3lwM0pkZWh3STg2ZzRNNCtDelAzVGVOWWFP?=
 =?utf-8?B?YWRabFRWNW96SUZPTmd5TDhpVi9kYlYxUlY3ekxHVjlGekhtaHNidG1oN0tu?=
 =?utf-8?B?MFZFbzFkd3Zsc2xJSVZXRlJ2UkV4UEJxWnI5NnVGK2xyQlV2Z0xSS2pZZlJa?=
 =?utf-8?B?VkdQcUlGbFB6aW02K09WaFZjUERWSThPQXZ6b2N4TmxzanBLSFhlZmh2cWo3?=
 =?utf-8?B?MURrOUdlTHMvdVlUaXFkRXpyOFEzT29lU0lOczJZYnZVd0tqQ3kzN3R3TkY4?=
 =?utf-8?B?VlZBc1Fzd291K3VaajFKbnByMG5FUitCeXRpYTVEaGRUcG1najlpdVlBWHdr?=
 =?utf-8?B?aCt0RHlFdlRvdHREN2duSFNsMkpmd2FNcUltZFhoaTBrMmlZMWdieG5rS1Bm?=
 =?utf-8?B?akZac1hWRVBHYWdmbWp4NFlMb3dmb2IwaWhEN2lpOVFhYlA3dHN5bmcxV0N1?=
 =?utf-8?B?WXFKR3lkVDdFS2NrM3haUlhVajBoRm9LbnhlTmJCSDAvVVlFRXhjUjJxS3dz?=
 =?utf-8?B?bDVURzZUYS9Ua3VrL1hmK0tPbXNhMWJXL0FNQkU4WGlSTnBLVGtSV3ltR0xh?=
 =?utf-8?B?N0tlZkxjL1VpZytzR3hCdkluRlFtUzdnS0xibVJ3c2pJOTEzZXlPUysyNjdm?=
 =?utf-8?B?dEY4QkxOaGVWcGdLTUJNcG9nOHdGY1k4Tzl0RE4ycTVtMXVLUlBGSDN6WW52?=
 =?utf-8?B?YzdKYkw3OExibVEvNllacjJVejZDM3JiMUlKMFpMdEVTYlVZQ3VmVnAxT3Uy?=
 =?utf-8?B?a0FNK2dNVkVMaXZ1VXprclZweWJoQ3BCamhJSXdkUU5BbkFaRytVdSs1Ukph?=
 =?utf-8?B?amJRYVM2aTBGMDVuTXoyWm4yU2xFSWp3eEN0a0NJazNYWXZuNGZVUlBJRkJP?=
 =?utf-8?B?c0tJeVgvZkw1TTdaWUpaZFd0N2w0UmFLdWZnUjMxd1lVaDM1L2xDVFphZlBo?=
 =?utf-8?B?ZEVGdXIrUUw2TEFFSVlDQnYrcVE3RDFDdkRCZnRTeXc3OWhHTTNwMlIxdjYz?=
 =?utf-8?B?RFFqdU1rZzVMNG5TNHRSZ3RWT3ZlTVRRUFlwaXZIa1NDSHBwSStaWGhtbXdH?=
 =?utf-8?B?UVovYldSMEZibzBkSysvSjlXNXI2bjRVbThBNHZrK09qWUNXRlBERTl6bzk3?=
 =?utf-8?B?WEJwWDkyYXVPZSt5ZHMyMkJzdm1mNDFXY0xjQT09?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(14060799003)(82310400026)(1800799024)(35042699022)(7416014)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 08:16:14.2414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57251730-a016-4d2f-ed2e-08ddba09e0ad
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D06.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10855


On 03/07/25 11:36 am, Aboorva Devarajan wrote:
> From: Donet Tom <donettom@linux.ibm.com>
>
> The split_huge_page_test fails on systems with a 64KB base page size.
> This is because the order of a 2MB huge page is different:
>
> On 64KB systems, the order is 5.
>
> On 4KB systems, it's 9.
>
> The test currently assumes a maximum huge page order of 9, which is only
> valid for 4KB base page systems. On systems with 64KB pages, attempting
> to split huge pages beyond their actual order (5) causes the test to fail.
>
> In this patch, we calculate the huge page order based on the system's base
> page size. With this change, the tests now run successfully on both 64KB
> and 4KB page size systems.
>
> Fixes: fa6c02315f745 ("mm: huge_memory: a new debugfs interface for splitting THP tests")
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---
>   

LGTM

Reviewed-by: Dev Jain <dev.jain@arm.com>


