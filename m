Return-Path: <linux-kselftest+bounces-22506-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EE19D879C
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 15:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24171B42B0F
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 14:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDB61B87D9;
	Mon, 25 Nov 2024 14:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bJ6U6MUt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8081B4F1A;
	Mon, 25 Nov 2024 14:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543844; cv=fail; b=JldNszSvq2fSUggWPMI4NAKXJyRpT+fqGcrvWsRdVkx6WihNM7RSvpwTxlX6RGdQIselmcxhzSbFF6T0QioxSxxB5v5CbFdchpC6eJsz2JdIY16cFOcJm6D6W0ZxNAOGqf02BUlnbNSyn0SWBVEc641+S9fTRZ7X2tWrHAyvqns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543844; c=relaxed/simple;
	bh=rXrtbo1nKP7JYhVH/In6bjKla7/5L5HmwF9ULbNJGIQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VNb5hyozw3nPDiqEiVpHCcz0rvM0JsxWavGFIPBDCW4X6ulCMsajIODxC7LYe2gyarw/0smeOZRwXNGc3Zufoo8lm7rt7jo8gbCKfIOCEweBQUSyw20CoyyvGPbE7M/8A1LxMaIBuQP+s9bo6H4JBAnSDEztlqcio2rE2QLAbSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bJ6U6MUt; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qpisTysEIuhzmlIoj9PZYrc6m9lG8HMoCRHpD/7TV+fw1dI+TyFm3us19UGBikMEB2/A25UZ+Xu541m13gA9r6Xv+rHxlGBV9ni3F21zwWoJtkJczMIhNHKiPKqfsXEfsFI4TfoBDPy7W20YnGfBRuCmu3TjUoCHbt32a5eQzq7MCiuwm5A2geovP8i26F0VFez1NOs4oADHgA9opqq9o91RmksO4l2BepDr5FGLYCuj3MWzrIb0D3VB1sik0LHc2jfPBSpZaHzuO7Qp+uPMpDV2tXDABZL1WXgGjRxrLWAkMOCL7xPe+mNxxFwDdHKPw98iJmVM4esrm+hXWQM8fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8z/POO+J3G3UJepN2EnSU2Lkg01F2J4ir7CXbgaOtQ=;
 b=pTmFh5ZPBdrqyne85n4YHsZ4leUBdDkEAqV6BqGMVXVIvT1RQ92c06Lu0nEHRYBrr4//Qpd9QTR+5Ylnc6LRAIJoyXgpRf3CTQPphBcKl93VSfuorgOapqQdsXv9T9dFDB4Rk0WMaYvBPx53COgW/JJk0V9CWe8167c8c6k0pZBmm61u2GFXwqrvpFTIg6vQ0D+5Tmk1BnNOCBR6MrYsFOp8/3rOUO21pajWrmj4d+IFBWEvLTLgdp8Sfpf/Di4HSkbd9sT2TjiGc1msLqhxPbpvdSXaZB8+ovnHY+aJOQenaQXwKEQxDAgbaB1PQOdw33cK2+SVNj+A4hQTvA+srQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8z/POO+J3G3UJepN2EnSU2Lkg01F2J4ir7CXbgaOtQ=;
 b=bJ6U6MUtsIrFnyoLEO33mmhTLAfdx++YI56YrjWpC9rWymR5ftF2aSoOu8nqQEpCOYrkLp02gXo9IMpyWEPj4ypES1yEoMpAItw1pk/yMu5CQbysVuSEhKv7M7O5rijPV9EosCwmmB35AO3m9J+QmzIAQ7upucLKA5h/ybTztaoows83vW8z2Cg2b3/n850PBfRg+CLaE1Kz23OlHpwhEBOUzYTMfWHEjAHdlHncQKuLJgrYXUzmxQjkkTB19yVbpz/dWRRpZRh5o2thSlhAVeoVutWsSrkTzzANlbnZwguhWPBc4OseqHhqBLPoCiILv6ixPOMDAeA+RGZehPs9yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by IA1PR12MB8263.namprd12.prod.outlook.com (2603:10b6:208:3f8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 14:10:40 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%5]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 14:10:39 +0000
Message-ID: <d986d2ad-3ac6-4357-a8dc-e83e3622efb2@nvidia.com>
Date: Mon, 25 Nov 2024 16:10:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] net: ethtool: only allow set_rxnfc with rss
 + ring_cookie if driver opts in
To: Edward Cree <ecree.xilinx@gmail.com>, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, habetsm.xilinx@gmail.com,
 linux-net-drivers@amd.com, horms@kernel.org, andrew+netdev@lunn.ch,
 shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1731499021.git.ecree.xilinx@gmail.com>
 <cc3da0844083b0e301a33092a6299e4042b65221.1731499022.git.ecree.xilinx@gmail.com>
 <871a9ecf-1e14-40dd-bbd7-e90c92f89d47@nvidia.com>
 <b0f84914-c4bf-9071-b72d-cc2cc4a517f9@gmail.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <b0f84914-c4bf-9071-b72d-cc2cc4a517f9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0113.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::13) To DM4PR12MB7504.namprd12.prod.outlook.com
 (2603:10b6:8:110::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|IA1PR12MB8263:EE_
X-MS-Office365-Filtering-Correlation-Id: d81ee63a-df9e-45be-99a6-08dd0d5af0ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlAvVnRid1FocG4zNmVsdUtYcVBJVmtROC95c1UyTVdBL3BlSkZMWExQSUJV?=
 =?utf-8?B?REJmbUJNcU5jdXZwYVlURHJhV2ZrM1J3YzJTcVRlZGFVU3c1dXlza0h0ZHc1?=
 =?utf-8?B?Z1JUdThqTnFtRTRmVjgvd3U1ZGdZN013cWY0RCtGV3FiTGRKR2g1OXFVQ2ZW?=
 =?utf-8?B?UFRiNW5UN01FR0FQZ0lMSGJ3QmJVYnB5S3NhQVZqYm1XSDN0ZUVId3hVVjBU?=
 =?utf-8?B?VkljN0E4di9RdStFUVdCdEFoUVFnU3JFakVmTTF0WFp4Z0NjUVFjbGpUUStS?=
 =?utf-8?B?dnpyd2F4SHpQems3OE5wbmNqMWtRcHI2Z2FlcUcvaHZRSWZkdDJ1dzZRWjBr?=
 =?utf-8?B?cEk3Y3ZDNlNBQm1GUWJyUUdGcDBXMTlZeWlqcWVDUDdJb0ZlSlJraWU2T3h0?=
 =?utf-8?B?Ly91cU1VZXRQbVhzYnFwS1BWV25DSWRMOGpsN2tsMjIveStXRFNYb3hVZU9W?=
 =?utf-8?B?b0ZvQVVGUjNua3poc2FMMDh2Y3Vnb2QzSXBxUjY5OXVVRkpjOXpFa3IvQW1i?=
 =?utf-8?B?b05wclIxMUxMeTdFK2hFbXF0K0dlN0xHZ1hCSVRNOWhTRlhxMDRpNHFFZTA2?=
 =?utf-8?B?MGhaTjlPYmRPeW8rdmxXQXVldkpKa1paWXVONlNjV2NLYzZLY1R0SXJMRFdq?=
 =?utf-8?B?TkJrK2JoTmVkU2k0U29mclBCc0VyVXhqMVNKQXlzd0w2R2VCOVN2dGI4c2dK?=
 =?utf-8?B?TThicENmaUxnMUs4V0o3ZDF3djJDS09KTE54UUt2TXgxdHk5bmlReDRBQVE5?=
 =?utf-8?B?UnFISGlmbmhBUXhkQkFuK3NKNjlYY3NnQXFpQkZYaDh5N3FTM0U1VnV2V1Rv?=
 =?utf-8?B?NldkdXFVWWVLblgvYytSTFpnVjN4RGIyQTQraUZZYmk1eTg5dzhvVm40Qlp2?=
 =?utf-8?B?RkVqZGdUQzRhN242STNaT0pYWFgwVFIyUlFMVHpMN3RqYWZkVy90V3dQVDZH?=
 =?utf-8?B?NUpjOVQ3NEtSSUVPbnFPcFFrdjBNREFoWHNPTTdUcTJQWGVYRFNqMHFGK29y?=
 =?utf-8?B?YVBCOS93MHcvZlZkamhtdnZ3ZkE3eml1aGNQSmcrSXNsbVowcG91V0oraHNl?=
 =?utf-8?B?UFVXVHVRUnhPSDBOTEdQL01PekRYR0oxa1JmblNyQ1BFbzB1ckEwajlBMEFz?=
 =?utf-8?B?U1NWUWNHU2taZFRyeFl1ajZZSnlFR3EzUHVmZVJJTWluMkJ1cGxscG9zUUVB?=
 =?utf-8?B?RnN2cWQ3QndaYXEycFdZTWhtY1hCc0dDaXBkMC9mM1B6a2dlMzluTUFpNU52?=
 =?utf-8?B?UXFrakl3OEhYaGY3dlhya2Z0MHNvRmhVa2xVRHArSlZJdW1xNkh6L3dxRTJS?=
 =?utf-8?B?U1liNEVvM0R0d2gzaWtwcG4wU1Y3dllpbkhvcU9Td1ptZDFlVFdBdVZiSnkz?=
 =?utf-8?B?TlJCb09sRGVLMmN5aGpLNWkxNzFVZUpnUEhSWkRRRER4anBYNmhlRSt6c2lu?=
 =?utf-8?B?SFdrRUR5cDU5cFNWSzc2ME5OeklndFBPdWRsdjJoeUh3K2lySW5hVmZJMTY3?=
 =?utf-8?B?c2dkVklpaWVuOUtCcktzS0hRK0pBRFZUbnllTVFTYkUzYTlwbk8zU3JYTGM2?=
 =?utf-8?B?LzhyVnVIbzJFSllxb2tBcEVZcHZnQzRBQnNTbzB0cno2RGtHUk1VRzJSbENq?=
 =?utf-8?B?bFR4MlgweFQyOHR4WVp1UVVBU3l3MmZOWG01SUI5ZTZsU0NpeGJUaW5FZkpG?=
 =?utf-8?B?RlRHNDh3dkJnVU9XL2NXNGF1dXlkcmIrbmtBRDBRc1dDWjdzM1FvYUV0Uy9a?=
 =?utf-8?B?VVQ3VXM1YlZOaG1CYUtrRFprbDNXaFVuTGJsTkFOaFVtaXg0NDlyRU4rOU10?=
 =?utf-8?B?NXBrcnpGemU3bk1YNSs3UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWsvanMyOWcybWlGRjQ2UUFjTDhiMWZ4eVhtK1RpOEFJems5eTVQSHBodW9x?=
 =?utf-8?B?dVBrVWlDVUhmWEtWVVVhK1VrbFZtRTZJcmVRVXZtMnFxSlNKSkNINktSUDhP?=
 =?utf-8?B?QzB3WkVFWTI3d0hmdzFvUng0MmFRczMrdU93ZzNqMW5PMndzYlBoaFkvTlhT?=
 =?utf-8?B?cVdjZFdJTzE5RnlRTDR3Y2RXTE5iditYdXRmd0pTUTd3dWJJYU85R3cyMzJ2?=
 =?utf-8?B?TTg3Y01HenRQRXJqb3daSlJqS2gxc3R0OGp1RDFYZkJHdkRyelk4NSs1dmhM?=
 =?utf-8?B?THVsYndIY2VoM0RJcEhWQzBUSzBWcko0dy8wZy83Q3Y4NmI1MUlwUStZdWZQ?=
 =?utf-8?B?Q3lkajFoNW5NUHZaL3JuRHJ0UWtwQmkvUTE3SzA0RnIyVkMzUW91QTJNZ1Ix?=
 =?utf-8?B?bHhEMUNMZ3FzUGNtVlByVVJURHhOL0FQeVRxZHVCTy9obnFUUE14c1p3Smhr?=
 =?utf-8?B?aVlSaVc0UldDQWlRcWVNWnRHK1lmMDNmK0JsUlNJSTh1Y0M0N0dOS1JadzFF?=
 =?utf-8?B?Z29ETVJrY0RlSDkySG1TZFdsWE5ZbFlqQlB6YXpNMFJNejl1NkprZ3ZwTUZV?=
 =?utf-8?B?VSt4Zm1oK0VNcGNUZVlxaUhNS2RCNy9BMzlSQkNiL1RNMjNXcFk1SjRoUHZV?=
 =?utf-8?B?VUJQL1JqV0FValBpQU1JbXAxUkE4SWdIaVhNZnFQcm9tWVZObGZRZERmYzZz?=
 =?utf-8?B?V3NRS1puZ1NOOVdOend0T3gwN2tNd0l1WVVHbWtNSnR6UjN5N09taFM4RkRj?=
 =?utf-8?B?WnJuRnBlRFI4bzhVYnI4SWwrcnloNndCWXlxN0QwTm9BL3E3dEV3QkVPZy9W?=
 =?utf-8?B?VytWRzlCUWFBeGhtOFM0VUZoUEJzTU9LZlllZ05iOWZCV01WKzcwdkFxWm5V?=
 =?utf-8?B?NEl3RVRVUnRMUVhCc3huOUNRQ0oxVE1BWUtEYWZKNnNKNmZzRWZmSTNGTGhS?=
 =?utf-8?B?WkZzcVVGRkJsY2JPWGwwNWN3clNQUTV6YlNQQStVRFFUUkM5bjFXTTk1TGts?=
 =?utf-8?B?SzdueUhqY1J0eUpENVEybVFKejBZSVphVFJzTlo1b1B3VkhDcVJqNEQvNVRv?=
 =?utf-8?B?Um9rTHN3eEQwR053U0tTQnE3K1pzTFBET0kzTXJSUmxWTnVCbVkxc2ZOSHRt?=
 =?utf-8?B?T1NKa3N4TVhlbXV1WVpuNHJ2amIwN1hnSXMvbEk1WUNlbGNVeVFvTFY2RXFl?=
 =?utf-8?B?SHBBaGh6R1Z0WS9OUCtWSVlUejRsQXJEK1BjdFdFYmVXVTI3YkNlREdHVG42?=
 =?utf-8?B?NVA4R1JXTGhLeFJwem1HZit6SkZiclpaUVlXcmV4ZHpGcGFvRCtBZlEwY2ZC?=
 =?utf-8?B?MEtITFd5eGhFYkdlVHo5RTVUdmFEdDJwQzJqTEFPMDA1WlIyeUdIekVyQ1gx?=
 =?utf-8?B?bmI0MTVKUmFHRGs4VTBzamFyZyt6OW5VY2FGYUxuejZaK05WbmY1bkJmR2Fv?=
 =?utf-8?B?Mk1vWFRnMWZrbHpPSEFvVFpOT0hySGE4YjcwMVFuM2ZsSG44THpieGlnSlc3?=
 =?utf-8?B?cEFYZHNqSFhPd1VsbEt0aTdFRnRuS0t4TTlsc0VrMWpLM0lPTjMrbXRBZEUr?=
 =?utf-8?B?enZFL2duWlZ5RDk3WEJSYUxobU1pdUhTVWFoU3VQamRseUk3Vm9HTU0zb3F3?=
 =?utf-8?B?YXRCZm1RVi9KdVV5ZDRjWXJGOEhaa0R3dkg5VTQyWjk1djh6UVlTUmxxblor?=
 =?utf-8?B?M3h0WTRLUy9xR0tFeWRxQ3o5bWpOeHNQcWtWdGlneTRCNForaS9sZkdmU0di?=
 =?utf-8?B?d1p5K0VLODRuVHl3cFJqVVREN1Z4bmNRMkM5cEMvNWtIYzBaUHZML3I4b1NI?=
 =?utf-8?B?VnRpbW9JNkNDbnBhZmNBNk9VMGx4dWxBTUFvTTZmaGpvN2tWMEJaSVFCamxx?=
 =?utf-8?B?UkY1RXdKcUN2UGI4aFpydkFsdXpIKzVkVzladFlmRTJlcFN6dmp5aElCQ2Fs?=
 =?utf-8?B?Q3ZUeS83V0MyQm1TTThyaTJNVjVVUEpFRFVpUDFJNUp4YkEyOFBpZjdTTlZJ?=
 =?utf-8?B?Q1Z4NVJuOVpPN3RNWXhGWFBuNE1QZmVrQ1Mzb25hbXpaMGFIbWtWZzRxUm1H?=
 =?utf-8?B?OERnczRMMy9kc3RkZkcxQTMxQ2p4a0l2cVJneXdpZmgyUGM4R01uMzhOczVk?=
 =?utf-8?Q?RK+0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d81ee63a-df9e-45be-99a6-08dd0d5af0ac
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 14:10:39.8403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJTV0TKsKHx8usw9Kzj4rNuFV2W1amHg5cYkehkmkSWe56tzxyFzmSZBm0IXLQck
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8263

On 25/11/2024 15:21, Edward Cree wrote:
> On 25/11/2024 07:11, Gal Pressman wrote:
>> On 13/11/2024 14:13, edward.cree@amd.com wrote:
>>> Ethtool ntuple filters with FLOW_RSS were originally defined as adding
>>>  the base queue ID (ring_cookie) to the value from the indirection table,
>>>  so that the same table could distribute over more than one set of queues
>>>  when used by different filters.
>>
>> TBH, I'm not sure I understand the difference? Perhaps you can share an
>> example?
> 
> Something like this:
> 
> ethtool -X $intf context new equal 2
> # creates context ID 1, table filled with 0s and 1s
> ethtool -N $intf <match fields...> context 1
> # filter distributes traffic to queues 0 and 1
> ethtool -N $intf <match fields...> context 1 action 2
> # filter distributes traffic to queues 2 and 3
> 
> See the selftest in patch 4 for a concrete example of this.
> Some NICs were apparently sending the traffic from both filters to
>  queues 0 and 1, and ignoring the 'action 2' on the second filter.

Thanks, I did not know it works that way, is it actually documented
anywhere?

> 
>>> @@ -992,6 +992,11 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
>>>  	if (rc)
>>>  		return rc;
>>>  
>>> +	/* Nonzero ring with RSS only makes sense if NIC adds them together */
>>> +	if (info.flow_type & FLOW_RSS && !ops->cap_rss_rxnfc_adds &&
>>> +	    ethtool_get_flow_spec_ring(info.fs.ring_cookie))
>>> +		return -EINVAL;
>>
>> I believe this check shouldn't happen when we do ETHTOOL_SRXCLSRLDEL as
>> flow_type is garbage, WDYT?
> 
> Agreed; this check should only apply to ETHTOOL_SRXCLSRLINS.  Do you want
>  to send the fix or shall I?

I will do it.

> 
> Also, the check below it, dealing with sym-xor, looks like it's only
>  relevant to ETHTOOL_SRXFH, since info.data is garbage for other commands.
>  Ahmed, is my understanding correct there?
> 

Speaking of the below check, the sanity check depends on the order of
operations, for example:
1. Enable symmetric xor
2. Request hash on src only
= Error as expected, however:

1. Request hash on src only
2. Enable symmetric xor
= Success :(.

I've been thinking of improving the situation, but that requires
iterating over all flow types on symmetric xor enablement and that feels
quite bad..

