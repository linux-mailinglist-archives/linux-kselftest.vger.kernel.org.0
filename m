Return-Path: <linux-kselftest+bounces-36401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2571BAF6C67
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 10:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FB287A7B77
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 08:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F542BF011;
	Thu,  3 Jul 2025 08:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SRWUCPId";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SRWUCPId"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012063.outbound.protection.outlook.com [52.101.66.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC84B293C6D;
	Thu,  3 Jul 2025 08:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.63
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751529974; cv=fail; b=ENESJVP652Rwizi5vqAicXpBccXCkr1R2pKdIAVyNHYzVL9vRD7pUVRMpj2VammYqyTOSwwZ7u0z9s0Yk0bFsfiLxIQzbp/ZkOEtLOkpvcNp+RBaPbCVW6iE6uMdsSaxrLkESYaD46ny944LvTML7QQQbKBdK8ZDPzdhTBAhlU8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751529974; c=relaxed/simple;
	bh=/ZD3jP/wWmiD2aYbe/Hld/yWdoBsQODwh04j7gnZYgE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZppE6qCjlTyTJhi/o8FyCEdU7d6/I4tOCaxt6ZE7UpcKn9+k5V8yoQcIDnIDExmGBB62USZNc1CDw4syPa1Cf5AVkCsNKP4SDk2XT+Hkk+pNSxcdr1UGVBaOFzfgQcW4f+fJKhpNPKRVOEm1ON5xCPsnfRR+14d9UkKWqFQdaFE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SRWUCPId; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SRWUCPId; arc=fail smtp.client-ip=52.101.66.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=H2EG3HRb18+JYM+wG8Er6EJHRBQhfO7zKhwkWHnFgkILjuW13vys3STimARdoHmJWm9yrIdtMdJ6FwQueG0vACt1yCtq5KAPklXySmSy9dpbtcK0puzg6IX7XfDIZwjhV0WSgQJ8j929uHVDDxGYveJMPRJV3S3SgJH2Qg98Gz1tiQv++pWfX6r8Am+3qEQg/UH0pLxQxv/0pZ9BiuGFRi9B1lpNkNN7lmrAlUGmSqNwPAIEVcKXEyy5q3ojh/B08/3lWmNo+L0KyOnVUbSsykmG1ZuFzoIHOL1nUA2wVBgTbBXP3tbRdcsznhMsFbawz47KD8lxrjAMRyj5cUsDhg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZD3jP/wWmiD2aYbe/Hld/yWdoBsQODwh04j7gnZYgE=;
 b=MdirfmLsOUNflBHdSKn1tLQzOXyrDiKmSpOiOx29j/d/FrWXRk1tM87bp0rBa65lUh3ZbhQkKVsrvvagZ6VBZq+8goq87CTBm8RF+JDT9Y38RSwDDk3ON3mTQnhtlRNXMNmPxiP/OmTIg5/oZzm0ZASNrl/Qztvlrjy5TUfYzSyu5nQFC+Fw5+qOS35C0QUrTvueGvbFoMmz//WfMPaKqJp18hcFEJeSFisPEJRgcta07gJcoDN8EwzMxy1Rv3boEXVqwiNYikx2xYO3CcYiV48o1FlCoiRcAg56Q+xca4+MqzNSPUogiTn+rfglXj67Kqch0lwuAq3WDPOc+nK34w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZD3jP/wWmiD2aYbe/Hld/yWdoBsQODwh04j7gnZYgE=;
 b=SRWUCPIdQazfga15uo12/gTuBWIDUCq5ehVnMA6uc+eAdP4cwGjVjcUk+aqeIHRKXpGVrbY3tqmsBVsF1CYo8WCTiGrRpI+3n9RtF1LYz2uf13hn9un8yjgxxH2vfxFDMr5AK175Eso+PoqK481VeNEUQ3S0096pu2s0FdIxPOg=
Received: from DUZPR01CA0330.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::26) by DBBPR08MB10650.eurprd08.prod.outlook.com
 (2603:10a6:10:52d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 08:06:09 +0000
Received: from DU6PEPF0000A7E1.eurprd02.prod.outlook.com
 (2603:10a6:10:4ba:cafe::2e) by DUZPR01CA0330.outlook.office365.com
 (2603:10a6:10:4ba::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21 via Frontend Transport; Thu,
 3 Jul 2025 08:06:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7E1.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15 via
 Frontend Transport; Thu, 3 Jul 2025 08:06:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjKPI9gWhWOBbJIX8vBDe6QMe1vnz/VnO5ax0vYKZyzVRl8RdtE02qAc47XtjmPTpeKeJJEiUopqcjUm4bmL7R7KWkAuE5aym3h5llJD36UCIwgT79/Z840ug/ABdN5l9foLNupLNsurv6zplR/LNVRy3YHQFI3C0rYehSkfCKa7KGROnWzOJsY2YijWVd7hJxjZb0pjPwN7YAqRFURa50x6fPr1A86FZ8BmKgImnHjql6mklg4UMCBTyx6Ydt2+800a8bKKNnqzkXYmyFhy2McmEI3XK38fZvDLqS5HYseHMDB1rTuRuLVccNhjaxz3OEDrJFGO5wvabwondmUrjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZD3jP/wWmiD2aYbe/Hld/yWdoBsQODwh04j7gnZYgE=;
 b=wCBLmDg1Y+ut6kWbBGBRWnvEly0Sy9mx4nkcVkvIkU802NxdrbQdfnA2dltQTwWdzehVem2MFu9mqOEfYbEismdE/8n1Uu725CwVSZVjox6DW8GEZlpDtQmXrD1V42k+umshZ0l1vMlwP13Cn+cGglp5Z/GTJ2sWBTCIfsF4NZuN/5ajry9anqERn/ERbZ/KXWtmYR+nVNrXhGrJTjeEiRm+7CGX71VaFU2purjPuJ2sLdo8a8nas0FlD8dg6RDZI/9HBqSdKTcRt7ffYdcEAO1UVuHLYsV9CdLR91Bc4HtpHkallzPw5BbLTfUiWZvav0a3iJDhud5no4qJh2UCcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZD3jP/wWmiD2aYbe/Hld/yWdoBsQODwh04j7gnZYgE=;
 b=SRWUCPIdQazfga15uo12/gTuBWIDUCq5ehVnMA6uc+eAdP4cwGjVjcUk+aqeIHRKXpGVrbY3tqmsBVsF1CYo8WCTiGrRpI+3n9RtF1LYz2uf13hn9un8yjgxxH2vfxFDMr5AK175Eso+PoqK481VeNEUQ3S0096pu2s0FdIxPOg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AS8PR08MB6470.eurprd08.prod.outlook.com (2603:10a6:20b:33a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 08:05:36 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%3]) with mapi id 15.20.8901.021; Thu, 3 Jul 2025
 08:05:36 +0000
Message-ID: <fa2da701-d2ba-4a27-9d9c-c8e1434edb9b@arm.com>
Date: Thu, 3 Jul 2025 13:35:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] selftests/mm: Add support to test 4PB VA on PPC64
To: Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, shuah@kernel.org,
 pfalcato@suse.de, david@redhat.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com,
 baohua@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, donettom@linux.ibm.com, ritesh.list@gmail.com
References: <20250703060656.54345-1-aboorvad@linux.ibm.com>
 <20250703060656.54345-3-aboorvad@linux.ibm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250703060656.54345-3-aboorvad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::18) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AS8PR08MB6470:EE_|DU6PEPF0000A7E1:EE_|DBBPR08MB10650:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bb10e84-e220-40cb-6f4c-08ddba0877e3
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?VkNuU0phK0E0bmxQSm1LTVJqNVIwM0o0TmJlZUNJV1BqZk53OThsTU5NK3B1?=
 =?utf-8?B?ay83YlVWMW5GN09OcG93cUlpZHRvejg5dElYNmFEK1NZVDRPUEJCdTZJb1px?=
 =?utf-8?B?M3lHaElKU0ZxeWZ4Y25XTVI0N1pSWWNuZDlTaWVjUnFvV25Ib3Z2NVE1SW54?=
 =?utf-8?B?cm5VOFB1RGNLSTJIVHZrMmM0bEhDUXZhN2l0LzVtUG9XN3BYNm85YmMvSHpB?=
 =?utf-8?B?bkV3RzdBZ2V3bTlFZVlTc0JiZ2c3L0o5TkZPU1hFRldlazQvVncwRnFjR2NK?=
 =?utf-8?B?UFNmVmRQNUdsL1QxT2lXQS9LSGJKN3J3SStQTWlVSVVBalgrN29YOEZ4SlhG?=
 =?utf-8?B?NENWY25qSnRMWS9ySWNkd3N0bFltK3JMQ0crRldnWURvUzNRbG5mTUxBNU16?=
 =?utf-8?B?eEtKS1VLN1JJazl1NlVKMHVhVlVmQUk1SnVmallhTHBhSzVZZEZIaERxZ0Zj?=
 =?utf-8?B?aHVDTlBSVHFKN1JoK3ZvSUVQY21FSHd6QXc3NWQ4UzhFclg3TzFzR1ZGTnlu?=
 =?utf-8?B?RWJKbmZ5cFZ5ZVpQZEttWCs3RzNoNGEycDlzd3hzOU5BaURzRzdXUXYrcVFW?=
 =?utf-8?B?RXUzV2FPOHI2MzBORTBwc2NJZTN5alNucndkRS9JNHM4djBYL1hkK00vb0FT?=
 =?utf-8?B?OExDQnRrQ2dNdzhOT3VXT3RibVI1Ym85Z3dNaEZreU1zWWg1dGxSRGJrdWt5?=
 =?utf-8?B?Y0FEV244VHM5bHJzYVpPQXExRWFiQ1FrdkxrTy9ubis0elM4b05BaCs1dDVT?=
 =?utf-8?B?dmt0SGQ2eTFjc2h0bGIvMXpnck9waG9sOEFZT1ZLbWtSZFE4QzZpUVJBWWxw?=
 =?utf-8?B?NG1NdkFVYVk0UlFqa1JVM2Z3THF0WG1iRXZDSGpzN0hiRFlNSEV3Q2h2Zmpr?=
 =?utf-8?B?Z1hINnA5YUdPWVpvUmJZYU44U3lXSU44SW1oZmdBMlhScWc1V09IMzlKb1kr?=
 =?utf-8?B?VHhyc2NuQ3JXRWN4bHptblpoRXEzNG5SWjY2QklML1ZsaEVsOG51U3psclhz?=
 =?utf-8?B?RVR3Vjlmb244R0lRN1VCemZzbDF4NTFqS3R5Z0NLWk04Nm5tYmtqU0x5U0xN?=
 =?utf-8?B?N3VWZFVOZFcwOFdlOUw2RHFLdkhoWWc2SS9ZTXRQZi9lOThtV3pNYmU0Y1NU?=
 =?utf-8?B?M0xZRUxoS2QzUVVTaUl5bEdPMmVwVUxZSDdDQzNkZitGMDNkZ2tSSHZnWjJx?=
 =?utf-8?B?NHJQdUN3NDBMb2RaamlVT25tcS81OXRidGdxMy9JNXZuUlBuWkN2WUQ1c1p1?=
 =?utf-8?B?SWZhSFo0NmpOQ0xENjZYZW9kM3l6MS9KcmFKRjY5Y0lnZ1dPbnJ2ekUyenlv?=
 =?utf-8?B?RVhIWlpiU1YwQmJhcjBCem9TRnVaSFB2eWpPcTIrSVhSRGR5R0NWSm1uRjdN?=
 =?utf-8?B?WnNZR05BOWxzc1M4U0hndWFXcy9meElocGdoejJ5b2xNNE0zK2tKTlJBSmkw?=
 =?utf-8?B?eUtRbkJ3SU9iNjBhNWVBL3NhMUJrdi9kZ2hNQmtZL3lQcDY1NGxDdkFjSXBn?=
 =?utf-8?B?MG1MOEN6UDBOQ3B6RWhIYXVKOGRzYlN6R3lROVc3RnFJSi9zVmVuZ2R2ZExu?=
 =?utf-8?B?Zi9nMWUzcG1LdkFYVkpCMEdNWGo0amtWVTBIcFlRVDJ5SDlHZkVkUGpHdW5r?=
 =?utf-8?B?NUx2RUljVFFXNHFLeWpvRStDdGFkRHoyYmhVd3NTanl6TjRyTFFtOUFFK0hk?=
 =?utf-8?B?U0RaempSdUpsYmNTWTRTS21CQTJCaHRoUTlHMDFvSWh1Yytub2Z5cXh3TXBS?=
 =?utf-8?B?YXVpejNWOG45RWpZdkVrTkxhWkxVQytzK1VjbExYdW45QjlmaEFUMVMyODAx?=
 =?utf-8?B?Mll3QjNzeXl2OVRpVWJyZk8zbjMydzIva09xSGRDeERLTHYvcnk4c254anhU?=
 =?utf-8?B?ajdCaFFXNnJKV3E5OW8vMEJ5YW5xa3pCa1AwZnVmZkRRREwvbnRxamFCV0N0?=
 =?utf-8?B?OUpZblNUeTlMcnpXTzBGWkwydWpxL2Y3MVdFYU5Ec2IvNWp4UHdseFVyYklO?=
 =?utf-8?B?M05qMVpsYWpnPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6470
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	cbf3a541-2ae2-4826-508d-08ddba08641c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|35042699022|1800799024|14060799003|36860700013|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y09KU1pVRVNyWXJZWnJLbmFPVHowSW9PMUVGbmZCbmN6Q004b1hKbS9kZG1a?=
 =?utf-8?B?NThRcXdrZFc0aHJRaElGa2FiNU1CVHdyV1RleFY2M0MweGJvQjRJbXhHOE5X?=
 =?utf-8?B?SnVIWm1lVXdPSFBXcHZmTk0zZHJxVEsrSE5lVG55MVJiRHZWdUt0bUF4dGdR?=
 =?utf-8?B?eGtlejdma2JJTFVDOTJKNXN2V29nYVhGNmQ1ZHVKTFh3NUhJSTlVTGhVb0tN?=
 =?utf-8?B?WmV3U0tQM0N6Zmdrd0ZCeHAybkNqVXczS3RWZ0dTT241d2VZeHJxWjh1OXJn?=
 =?utf-8?B?bU5DeDgyZVN4RVFrUWI5bm9rdmxEVU4yYklxYnNPNTI5NVNLMVh4a3BFNXd3?=
 =?utf-8?B?a1lUbWF0V0xKKzVWUEhMWjlidFBsUERDUUt5UklVTkswcnZhZDMyeEZjV1Q4?=
 =?utf-8?B?RkMzV3Q0UHdvZGd6dU1PS21VQ1BSb1ZoMStQelR1a2hLL3d0am0rcmNkbXVj?=
 =?utf-8?B?SjM0WWF2dUJ6MzFTdGdZTnY2MjhPSEtybGhPc0F3c3F2T1ZXUmRSQTRSRmQ4?=
 =?utf-8?B?Z0RjWWxrakd4VUpqRHplNExGZU01N04xaU1DWnVkZmxyNnJUMU1UM2pNYlRF?=
 =?utf-8?B?ZG5ycmtyLzVLYzV0QTlyVG5JeTlNbEgxNDVYSHI1aDVXTlp2Um1ucHNqOUtw?=
 =?utf-8?B?bDIyamtqeHBsUGI4cWZ2ZTF3eDVNYUpTaTJjVnhLYndCOTc4ajZBSktkWTJ4?=
 =?utf-8?B?NUFhd0xJSXN2Y2tsamRHRmRDL2EyTE15cVVSOEJaN1ZlQkxDTDF2ck1ZY0h4?=
 =?utf-8?B?NE0yYUIvTEhlV0ZZa0xSd0lFUVdhNGJ1K0g4eTA1c1kwRnRhNGc2elhzcnJs?=
 =?utf-8?B?ZWRPQ1NHbkpEMHRPYzQ1b2pyRy9uclRtVHY2QUcrK0h4dGpmdXltaXhBak5h?=
 =?utf-8?B?ajc2MkdlVTZHaHB3QmJjOE9IR201SC9ESFFDNEZ1K2duQTVmZ2Y5b0FWNjlt?=
 =?utf-8?B?UWdjcGxWbjB1b2RuV2g2MitCaHZGcWZUTHBaOW5ZRSsrdkxpMjdnT3JKSE11?=
 =?utf-8?B?R2dKTmQ1STJKczRJVkZFcUlMck92WFI4WWxBT3VMdEg1QXhrNmwrcVhzUWhF?=
 =?utf-8?B?VzFuN2JPaGZBTHVuQUZRaEdkRjkrK0tPTkFVeUNsQ3pnZjZtRTFmempFSC82?=
 =?utf-8?B?eVplR2V0WXlsMDl2N3U0TUZPeWFaVEYzTmM4OUFhQjIrSm9CYVkyZm9xSTJa?=
 =?utf-8?B?YU8ycWJWSmlsdlJwOVd1eXhUZjkyU1FCK2Ivc1IyMnI5dnNIaDBrU2FrMzN0?=
 =?utf-8?B?enNUWWNoQy84SlJGVEloRk5vZWRPWEhVVmF6N3V3bkNEemNuQk4rUGhEYkxE?=
 =?utf-8?B?V1F4YjQ4RUd6RXNzaHZuZHFLU2NRVTJrK3E3N0J2YUtSbTcxOFc1UDY0N0M4?=
 =?utf-8?B?M0t1WXJjVHNpM1hzemZRV0o0OE00UTJlUjI3TmhKUXJEMGZMWnJ5azNVWm55?=
 =?utf-8?B?WDN0TmF1K29UR0tHQU95cVF5RnBZODJtOWJDSmllQlRJMklSRWsvcGZESGQ1?=
 =?utf-8?B?T0lNYkVPMXFtZWlDOW1iSDY4V295VkhnWXFNTEtEajNvU1BUakxiT25VK3Fz?=
 =?utf-8?B?SUlucWkwMHFzbmhTdjJQTXEyU2JDRldTRjRZWFhLZnQwWXR6Vk4ybVlaa1FG?=
 =?utf-8?B?dWhBTnhDTmtZNDFBaXFzM1FZYVdydUVLcURCQ25URFZ1WktnMk52ZXNUUCtj?=
 =?utf-8?B?dGs2UUJqRmgrSHlCUUM0RFVZUldVQW9TdGM3eTAxN1oveWx6NUw4SFlsVDZM?=
 =?utf-8?B?c0wyR205NmlCcXpRQy9sYUNiU29TaGdwWm5SNHF1U2k2dUducDdnTmxSejRv?=
 =?utf-8?B?Y3FNQXJodzZXRkRhU2QvU09SQURBNHNsandTVVFGOS94OTNzV3RxL1ZLWVR2?=
 =?utf-8?B?K3pheXlCQmVLZ2w4TWpSMi9PamZjaHpiWng1dGZoa2U5cWZsSXdMQkxNRksv?=
 =?utf-8?B?NnM0VCt0M3dXNzMwNnJvcU50RzRvK3liaWdRZUF6aktaUlEzVEQwUGVqT2Jq?=
 =?utf-8?B?c3pZYksyOXdvVTFFNjVlRWVob2FEQnEzaFVoak9FQ25US2RFUll2clBNdE1W?=
 =?utf-8?B?dFhoWHd2Q1lVVTdDNmZRSnlzTXN5Mit3U0RPQT09?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(35042699022)(1800799024)(14060799003)(36860700013)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 08:06:08.9270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb10e84-e220-40cb-6f4c-08ddba0877e3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10650


On 03/07/25 11:36 am, Aboorva Devarajan wrote:
> From: Donet Tom <donettom@linux.ibm.com>
>
> PowerPC64 supports a 4PB virtual address space, but this test was
> previously limited to 512TB. This patch extends the coverage up to
> the full 4PB VA range on PowerPC64.
>
> Memory from 0 to 128TB is allocated without an address hint, while
> allocations from 128TB to 4PB use a hint address.
>
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---

Would have saved us a lot of time if we had figured out that
the problem wasn't the gap logic but the large VA space support,
anyhow digging down that rabbit hole gave me some knowledge
on VMA allocation stuff : )

Reviewed-by: Dev Jain <dev.jain@arm.com>


