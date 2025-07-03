Return-Path: <linux-kselftest+bounces-36399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D40AF6C51
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 10:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857AE1C43571
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 08:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCCF2C030E;
	Thu,  3 Jul 2025 08:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="eOR1zWF2";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="eOR1zWF2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011070.outbound.protection.outlook.com [52.101.65.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A3C2BF3CA;
	Thu,  3 Jul 2025 08:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.70
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751529620; cv=fail; b=hsMn7Q3g8fnlOcQF0UUzvrKetJpW3C7tQV51ZCAzqbSzzkTdWlRb0yMRFiLsrgR8sPn5untAHvRftHnecJxsmzcnxHFThFVK+KaHHiNSpLpb4/8K+nwLU7E18rDjRu4+2P3f39RVw+aYn9SP6Lzzf91+J6jxkARprLid0tMx+l4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751529620; c=relaxed/simple;
	bh=tUUR+45ujFIDEndnVGa79num88a5nekpmji5lmSyM7Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cEjWn2Myl4/zxixR+gZTQ60Rrsh1OXsiqfMsTKyrsNZiRM+fR1ljGr/YBz9c2pMrJRI+0PTv7BiJWxb4Lj+SxMwx234ymNF5ZDn0lw6YNPvJ9R1N7KxX6CJjmlUOY7QJJyuPi7IIw0Hv7/xbyEeuI8pooYj/2RH70BkyShOvgHw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=eOR1zWF2; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=eOR1zWF2; arc=fail smtp.client-ip=52.101.65.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=W8cBp2pdAfJqUzxMQdOxQo0MTue/XDJuLykAENFi+PyGYxXWnvYy0VHd21CFtSlAsBxwJG3zGt2dqDl15nporY93qAU7HylWiQqHabQuCYpcKNkwHl7HPjY1M2CFQA0C7hwysAnVhAQlMEWdqXgl91lY23OitKjyh4gHZNCp4KChEh9cqchehMuTEabEPs7FFQ6Axbel+0Tg4MdR/7vR0aUedeYjbwCTo5GODGBrjCkTP0iE2S4CWX4SEn0U9XlhVtMAQtLyGlPCYYZfpODJ4Nh5hz5i3UGWWNsSNk22zwqrgOB5Lg4IavEtnhf11+DAF7xuoPmu8IvLsc47j4BEVA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2amln+Hvy6lo750RvcRzAolbZzjv8MsfWGWx9z/a7j8=;
 b=td4D6ArOxUWyKtzCdXrUK7FG5pOA4wCDpLRL++SY/4wTotBKApr2REo8TTJ5cbVkCSkNEPksHXW3sdtGSeuntvjkX5K+QUjLdBjw6hSXOZjZICVXnoFBgz8g168YJC4lCqQdTIeqZV249vpxyiwTLZ2eaXBTHdIzp6Z30dys1UZdVTKEzQOZElNbV5M0mDhq5n/Fs45Cp4cHv/wt527jc42eLeVmTHXjt68L+tauu7n5po8YJM+QRlvW7HNi/yqaqodryoYweSWIkvUNa4zWF2Of6U0hd+TU8AVcd4MenncXsw0MMp9OaXXDJtxyC2zLCH7XzHU0Et9aEaAW5w4/PQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2amln+Hvy6lo750RvcRzAolbZzjv8MsfWGWx9z/a7j8=;
 b=eOR1zWF2KvYjNNeH/DntmUbGfGusSB5AlZxBkbqrSGF68SkloQCWglxe/5CPsQcqHNGlzwlfojSGl6qPeUyBYnzk2AZrv7DD+TCIAfjtyUwxOACtfRkHEaPrK7r3ukNIu8e1PqbDeI7FCEK+oUR15dz2HXiGW1gDa6oCQ2zT33o=
Received: from AM0PR01CA0106.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::47) by GVXPR08MB11212.eurprd08.prod.outlook.com
 (2603:10a6:150:1f6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Thu, 3 Jul
 2025 08:00:11 +0000
Received: from AMS0EPF000001AD.eurprd05.prod.outlook.com
 (2603:10a6:208:10e:cafe::be) by AM0PR01CA0106.outlook.office365.com
 (2603:10a6:208:10e::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.22 via Frontend Transport; Thu,
 3 Jul 2025 08:00:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001AD.mail.protection.outlook.com (10.167.16.153) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Thu, 3 Jul 2025 08:00:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uR8IDfUvb+SVlegHnGj+Gdk74oh2pf676vawc4Depu/I2HRxuBPeiyAaVB8HCttE+AGR/mAPoq1ksnR3Wa1AVJXydFpYYw/afbka2daQPpe+HW13ZCYKEhlWJrrsOa2mxZDJQz0s/AfZPjsDKBEmR6xD2qj35z9yL3n/4H+jAVwgDd4FrWmb1oB0U5AcSN2CGPVf6osBiYaV2AxNeZQNVECc//sAmFZit5827/kb9hjQsp7NezFFPPVZ6SITgiAMdpaSEMCRngLhF6p5XMKthX/4/LHdMCiwY5Vug1fD+iy2I7cMcg9K9cb/dVOr7vdFfRVWoJsc30v7ikV/xwjQxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2amln+Hvy6lo750RvcRzAolbZzjv8MsfWGWx9z/a7j8=;
 b=v1kMrMk5kmpm6Y+tMtOP9ciiWsNTsI97tCcykkEPzc0imy5BwAmqE87fCoCQyzg3TX+JQs4KKR3RAvSKn+6rvNQHbEiQHuRy1dWrkKCFBS+WS8vTbWe8B71X9UV6sTsNy7LFS7LhOwtY7qrcqr93vXzT1gA5IgqEpFU1P48e7Sz8ev15hhrwVfC8SlC0blKVwpRHK3kdgKpwHVqd9gDURV82N8eAeaz6GADTpWPL9vDyrZA9HTvqaYsMVkGcy9Bff7viKpeJVHUS8LgYCGurTXZo8484ctEOA4w4v6X3hdIbq7tuJlyEi/0G72aFKi/2v45Eza6dbzjmmSPBYkKQMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2amln+Hvy6lo750RvcRzAolbZzjv8MsfWGWx9z/a7j8=;
 b=eOR1zWF2KvYjNNeH/DntmUbGfGusSB5AlZxBkbqrSGF68SkloQCWglxe/5CPsQcqHNGlzwlfojSGl6qPeUyBYnzk2AZrv7DD+TCIAfjtyUwxOACtfRkHEaPrK7r3ukNIu8e1PqbDeI7FCEK+oUR15dz2HXiGW1gDa6oCQ2zT33o=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AM8PR08MB6577.eurprd08.prod.outlook.com (2603:10a6:20b:355::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Thu, 3 Jul
 2025 07:59:38 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%3]) with mapi id 15.20.8901.021; Thu, 3 Jul 2025
 07:59:38 +0000
Message-ID: <50eda97d-7a21-4ac0-bdff-1012ef273b62@arm.com>
Date: Thu, 3 Jul 2025 13:29:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] mm/selftests: Fix incorrect pointer being passed
 to mark_range()
To: Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, shuah@kernel.org,
 pfalcato@suse.de, david@redhat.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com,
 baohua@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, donettom@linux.ibm.com, ritesh.list@gmail.com
References: <20250703060656.54345-1-aboorvad@linux.ibm.com>
 <20250703060656.54345-2-aboorvad@linux.ibm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250703060656.54345-2-aboorvad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::14) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AM8PR08MB6577:EE_|AMS0EPF000001AD:EE_|GVXPR08MB11212:EE_
X-MS-Office365-Filtering-Correlation-Id: bdfef9d5-252e-4e41-8ae2-08ddba07a28d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?WUozbDRBaEZoaXBtcSsrTnJFL2pTUUIzWmY5N00wZ3NCRSs4MTZJcXB0U1I5?=
 =?utf-8?B?enhJMTNvbDk2T2NDUlFoTG9CdkhUQ2xsdU1ZWlkyVWtMV29NT2MvYmxxUGdh?=
 =?utf-8?B?K0FKbmVyRFNMM2NxYVpxeDd2RE0rdUh3a3NrUWd0MDY0OG1aaHUxbCtmN0xr?=
 =?utf-8?B?NTd1azR2TmVtN09wU0c5MVM2Z2tKUEM3ZGIyVk5qcncvb0x6a0lhMnZtSjQx?=
 =?utf-8?B?UWZ1RGptQTBMSS9Sa2N1eGVwcXFsWDRUdFFtb1N5dkRUOHlIb0JaK3QwSVlp?=
 =?utf-8?B?SUpZeHA2ZFFRQ1BBUE9UYjB5T2t3SmJmbEIzV0tIRXRQUHFrVS92NUhrbi9C?=
 =?utf-8?B?ZUtiTWxZK1E3TGg2bDJNbk5rcWhEd1FkVzZtb2w4SFJXM1Vyd3p3L09OTmk1?=
 =?utf-8?B?ZDQxUmJBbjd2QllsZlY5OEhBVTJZSmNKSThtWkFkUytFV1V0NHp3dlNIdlFq?=
 =?utf-8?B?SmlXSlIxVUROeU9QMVZ3aGpEencxK01XMDdBL1FRTmRGMTY1WStCZnllZXRx?=
 =?utf-8?B?UnhiNE5MVDdxbllqeUlMWCswY295dmM2MGZvNlBiZWVLdG1wUlFKdlp3cy8x?=
 =?utf-8?B?TU1wWURZRkFTWGhlNVRnSENUTExnYkk3cWVmajIyR0YzS2kzKzJkMFl1YTB3?=
 =?utf-8?B?Umsrb21kcDlKNFlZaVo4RUQzK09DNTAxbXFjWW91TVhDekc2aDhzMDRtekcw?=
 =?utf-8?B?R1VLYXB5ZkUwVE14Rm4yc2NzME5CTWFhK25XMlp6bjI3YVdnRWU3SUdYTHd4?=
 =?utf-8?B?Wi95ZEhYYndwTVppeHRiNEUwdDM3eEt5Vkc5S0xEV2l6d1QzV0IvemlITUpn?=
 =?utf-8?B?TTBCd1lMQ1M5cXRpYzY4SnlRMVhUY3VpZGhBSXhWOUFveDZlVVlNWXRoUDdV?=
 =?utf-8?B?V2tGU0ZjSndxeHAzMXdsV3ZxYjZPSG1LQ0h5Ky9EU1pXY0dmODNiRmsvR3l2?=
 =?utf-8?B?dmtuaTZhekFILzNlaGtzek1CT2NKWWlCcWYyLzc4NC91RTJHRG9VbWpkVTc2?=
 =?utf-8?B?TDZRTWg0Q1RUdUNKWGNsbHpUVEYvWGdKdzQ3TU51MVpRUHJOZUFnYU1YUFZj?=
 =?utf-8?B?YnFGc2VXRDg0QVhDRkJJMUpaNDNmOVA0T2pJd2dhWHQ3bjdpL2E1NlRlRm8x?=
 =?utf-8?B?N0ZCTTVqb1EwS2diZWdSZXFjVGMya2V4Q1JmcmZJZkhId0g0ZmpiOGV6Ukpy?=
 =?utf-8?B?blpMV0wyS2tKdjRTL0xQZXJ1dnA2OWxjUFh0d2t4VDhwWDl1am9JMXhVNWJq?=
 =?utf-8?B?cHBXbm9KN1Q3M1FBODBBRmI1RkdoTlk1cVo3MWRXOGJBTG9lMHFBd0ZXZ3lu?=
 =?utf-8?B?QXhEVFJSMFpjR2EyZ2w5SnU3L3VBM0d0dUwxcEVCcjNBOWdnMmxpZjBwZ3pM?=
 =?utf-8?B?a2VjaFJwZFUxam1ONktSb3g4bE1FZEpUUVc2SGtLSjdhRm5LN2pDTW56QUlD?=
 =?utf-8?B?T2NsUk00ZWlYS0piOVFvdk9ycXdXNkRlVmd0enMrNGh2VlBJaHNJSy9KOFgw?=
 =?utf-8?B?aWNFQnRlZm8wMldEdjJPN2pTMlVFUjdGUGVJUHI4aDNSdmhmVVVvbWZTaEpu?=
 =?utf-8?B?aW52dGJuMktVMUtSckRKanEwWHhZOGhLUTR1R3RZNGxMaGhzMllJRFVPQ1R4?=
 =?utf-8?B?NnhGbTNJWEFRRTRpcm55Z3plTURlNnhjbEFFNVRXdld0a215VDBpNkVMYUpw?=
 =?utf-8?B?bmVlMGVPWUNHNUF1L2tzLzN6djk4d2VPWnk5UmMxZ1pqajROSXQ1Z2Vwd29q?=
 =?utf-8?B?MjZBemtERnJoN2pWd0VLNDZTYXE3OWdaUHVkZUlPUUtjNENTZi9qRUs1Misy?=
 =?utf-8?B?UW9kTkFaYXg4WWpBSC9JVHZNZDhkMzVWck1YY3VrbGo0WXBTYTFCM0ZFNTFq?=
 =?utf-8?B?ZENoUnpNS1RVbDRPZlFkei9VRzlweEhPVWVDVU1NYkpuaUI4WGtqeEdWeVFo?=
 =?utf-8?B?TWlGQTVyNlJBSkhBRGNKWW5PMmViTmFZU2hlYTBWSlZ1TmtydDhwYjljeXVP?=
 =?utf-8?B?UThnK0pEbXVnPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6577
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001AD.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	177da7c5-bbee-4e18-c41a-08ddba078ef2
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|35042699022|1800799024|14060799003|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXVSRG1pVGV3MGJoNlRvYTZDZzZQNTh3M1czQ2o3TGxLNThrMXF5SXA3S0Z0?=
 =?utf-8?B?QjdscVVsTE9kVnJkd3pBRHZ6RnltY2c0MnZzZVZQQVlUWnFVdm84cGtMYjU4?=
 =?utf-8?B?UDE4V2RQOU5LRHk1SWR3djR0TG1uUWk1THJpLy9NRTRIK0p6KzdRa0hJQWZq?=
 =?utf-8?B?ZkxKdjZHa0lDU1hlaWgyZVBMNjZPaFZLTWVSejMwaktvUXI5Y1JQVkJaaDRt?=
 =?utf-8?B?TldxY08rYk40V2xIWjEzS2MzZ2crd3FlWE4rZFFWd1A3eDBpejFITDB2RHdz?=
 =?utf-8?B?OU12YjBPSFVOL3hMQmxRcmpPK1pVOWl6eXR2d1dHNTFocDNVS2FyOVM3ZUFk?=
 =?utf-8?B?eVVFOWVFUzRwMWJIdzNaNUJIbHJBaEdwNHB1Lzc3dXVHVVpaQ0F5MDVWTUNx?=
 =?utf-8?B?NUNad095QjcrMjYrQm1DV2FrVGxqeU5ST08yNnNTWXBCQkNmWWVDNmpiZ0Ja?=
 =?utf-8?B?RDZTbk00azZYUE9MaUFQcEZBRDl4ZmszdmZYWUNDbm1JUTFIcEplUXpVR2VX?=
 =?utf-8?B?V0twdUpMUkRwdTRsbndCRm82Z3JvQ3luT2RYNGg0SnZUbi9jWlpKU3lmY3kv?=
 =?utf-8?B?em1welg1ZnBLZXR5R0hGV3huOE5MalhQcGxTZzhkMGZXOXJPT3JGZ0xYMzV6?=
 =?utf-8?B?UG0zVUtmMk1yUXRhNlZwdndVUThGdXRzTk5uUXp6VytWTU9ib01pRHB4OFph?=
 =?utf-8?B?cjRsZWJ2Si84ZlRpaVJsdFFSRjNBcVRyVkorOHZ6Z1oxOUFoeEVsRGVVR0FT?=
 =?utf-8?B?VlJwTER5MitlVnQ5ZS9lblR6MVJ3NENnR25tcllkYzlrcTVZdjRTUzFJbFov?=
 =?utf-8?B?SCs1RFVrZmthVEY0cllWaE9Mdmdub1ZSdmlxL1YrSlNYWDNmTlArTmpLNUc2?=
 =?utf-8?B?eGF4d0dIK2Q4Q0djc0ZQNmwwN2hPMFVTSGdBamF3ZnVQekNuKzl6bVVYUmJK?=
 =?utf-8?B?Q0F3OU5abHFwRTAvREsvRk9maFFvc0t5MFhRVjZMQlNaWHdxeHlLT3lQY080?=
 =?utf-8?B?dGVnZ2lsK0hETkJ5WkJIdXNPMitma3lmaFF6Yml0NGNlVmNHS1VKK1gxYzhO?=
 =?utf-8?B?RUpHVlJySUZ0OG9NQU5UazFZNHBEbk9uRnVZMzluSzNaL2RNVW1CcFNOaXc4?=
 =?utf-8?B?NlEzL1ZSdHpDNE1hNzZPK2h5YnlxSm1FbVVoRElhejFZUDh0RXZuVGVLbFIw?=
 =?utf-8?B?ZHh1dy9ZeUlrRWVrV01kRmgrUENtbUdJRmx5UDZEd3R5NjF0VER3dUU4QTAr?=
 =?utf-8?B?UWZ0L2ZNVzQzOTVQVExMZTNuMEc0SjFDMTRYUHQvTkNIb2hqNDlKWDJrWVcw?=
 =?utf-8?B?WW9QTlZqTFpTU25XUDhhTWZHOGRPWkxJazdoeGliVkF5Wm1LMk0vRm1nZEhh?=
 =?utf-8?B?aTV2MFdWVk4vNm5JTit2TktnSVBkZ0JmclZ2Y09TL2hKem5zYkZLNm9MMy9Q?=
 =?utf-8?B?WDhoc2NLRDJzcDlmMk9oTlI5cldpTi9qdEdRYUhLMHRtVjV1RnNrSSs1Z08z?=
 =?utf-8?B?bWgzY2UyRW9LbVZHZDlYV0FLVHV1eStqWi90NTFTM09mMnlhbkE2WkQ5a0Yv?=
 =?utf-8?B?Q3BYb1lmaWFzbmF6Q3ZDRmpqdGdlSEVKLzRJeXhMT1hKMUk2eVVYWUcyQU55?=
 =?utf-8?B?T0I5eUxFUFo1MGYvYktlL0hReFd4R2hrMkxLaUVhNENpOFo4a3hwZ1JyQW14?=
 =?utf-8?B?VmlaZDNmWHZPcU1LWnBnTzVzYUsrbW96WEN6R29KRUo2dDU0UUlZczAvVVZr?=
 =?utf-8?B?RkRXUmpIdktMcE1ORWptZnM4NkZzVkd0aDJycUpReVFicTVSc3YvL09uR1g5?=
 =?utf-8?B?TFVRZ2VOK1lFT01BNitlZk9qZzFITGx0OWRlaENqdUErS1VudlpHNlQwc0Z4?=
 =?utf-8?B?UnNDMU9FWFJaOGpmcWZzVEpZTkJ4RitVMXc2akVMdjJxWlVQTEM2QWpqeTBE?=
 =?utf-8?B?cEdlME1hR3pyam1rNUNtR0g2QVdQUHcxU012UW5pekpmQ0lOcFBxVXNvei81?=
 =?utf-8?B?ZW43aWlNZmlNMHFDNVlVYkhpRkF1QVhkd1JQaDVwcnRic2hFUUNKbk5YUWlM?=
 =?utf-8?B?RWYwcGI0akd5WHh4c0orTWsyQ1hUQm4yWmpVdz09?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(35042699022)(1800799024)(14060799003)(7053199007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 08:00:11.0248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdfef9d5-252e-4e41-8ae2-08ddba07a28d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AD.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11212


On 03/07/25 11:36 am, Aboorva Devarajan wrote:
> From: Donet Tom <donettom@linux.ibm.com>
>
> In main(), the high address is stored in hptr, but for mark_range(),
> the address passed is ptr, not hptr. Fixed this by changing ptr[i] to
> hptr[i] in mark_range() function call.
>
> Fixes: b2a79f62133a ("selftests/mm: virtual_address_range: unmap chunks after validation")
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---
>   tools/testing/selftests/mm/virtual_address_range.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
> index 169dbd692bf5..e24c36a39f22 100644
> --- a/tools/testing/selftests/mm/virtual_address_range.c
> +++ b/tools/testing/selftests/mm/virtual_address_range.c
> @@ -227,7 +227,7 @@ int main(int argc, char *argv[])
>   		if (hptr[i] == MAP_FAILED)
>   			break;
>   
> -		mark_range(ptr[i], MAP_CHUNK_SIZE);
> +		mark_range(hptr[i], MAP_CHUNK_SIZE);
>   		validate_addr(hptr[i], 1);
>   	}
>   	hchunks = i;

Makes sense.

Reviewed-by: Dev Jain <dev.jain@arm.com>


