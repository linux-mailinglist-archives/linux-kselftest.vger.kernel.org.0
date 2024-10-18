Return-Path: <linux-kselftest+bounces-20102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 694F39A33B6
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 06:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27FE7285A58
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 04:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498AE15FA74;
	Fri, 18 Oct 2024 04:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nzl8A0TK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E86920E32F;
	Fri, 18 Oct 2024 04:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729225133; cv=fail; b=BS8V40K7difGnuA/gAaY8kXf2/V1+7ljRLncLnCPvPQDpg3F2bfV0pS8wR49TEEBChctweKnRtaQjEP582oGPYvZR2SkdTu9QHjD2m4JmgNL1zrFIODu6QfU/fiPYnVhiix02C491M+Zw5eZuBa7UxMIP93E23vEemdMDP65prI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729225133; c=relaxed/simple;
	bh=xbutzlsVSqF/Hc/slqY2weJYyGqqO6SLHK/AG04E1oE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uCxeUUiz+X9A3IVrOFnLAPWDkIYLtpeJSVv9JtuxsKRFmrofuhX0CQEkxBMmh7A7x0vme9TDYOVh0KfS5iKD9TqZei1USCRP2U19CGXmSKUShQWmOWJ6k90bIwWBzYXJcwLvM7XFFtblcXkcF+DbfKwUa5ryEAyn04+EmobM300=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nzl8A0TK; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6LpsRcl9P8brjHx5nmpfIZ/N18DMSrZiKlhDd0mo1HXhf6gy0DUPTRs6QTHRdAKzbnk/wNq9oM7KcbdQgQM9O4dk8S03iR0FqvLX+guHfVkBx6ovU1O+bCywqkybQpguQdjKmnCCC+4rQ9Ppg1w3cOvAtjgSBfd/gIC7MKIRlE0NCTduMb2/YFUQEz8plQ4+QQV8HOxF5+B1irO+yM0ZInbzb3cSj7+/UbY4Ighik6NQZ1tmX5aQlGnuiNFSo/KGKDgI6+r/iHnsAC8pdQt2UhnS9H4aaP8FGBViUYK9xSu5Q4uRO8CyTZq+Q4kH10WgQSdFhv5mxyZVQEAFHILcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Pg5FQ/W9TDxfaupHolsMRTKUV24froQamjqyvPc6R4=;
 b=W1o/iyMIJ8lLEl2duzJossNrIeHZTLRnwbJWDb5FbJlmSrLlpSaeGXwWwhvfi6ICEb2UTBEkEKLMFXlXYyHnU6laSFAypnmZ0PQlLU3FceUbvNzhiNGYtcanwMzmFLccufiIKqrI4U/y78DATalZmeqU+1YZH4qtJ6VPXtC4b8fAHZqRtg4noAntV/3/SZLaAhpIvK9gHezqIb9UOPq4ND88pIo2c4YFFkngpn5dttFYd4gQ1KzNFTZb80bfpFeZyFjdRpT7Sr9kRV1/0xrFZzYc2fViuzxXoWeIL8BC/kqmowuyJBtApooseqVl8rrBU4FKx7w30LjtJZZk4eomxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Pg5FQ/W9TDxfaupHolsMRTKUV24froQamjqyvPc6R4=;
 b=nzl8A0TKl5JMzl1Hn35gDqwkkS931i6cwHmcrudxBQOrnshY/9/J5yXyH4n8lFLfBcXc9qidaynBzC2GuHb/86VGM8tmL3xZFHGeUuDkKqCdVsgiSUOQbjA0Klq1r+6tMvLM4qiXwy4UkSyJNJqZFK5jbxxeN7PQJsuMeWCzlIyTcMxPEf+AD9vEQ9N9LJrs6BMdFZ/G7PzrzFeyyPRb2yR6S65JUF75EFke6S0WsTERflUSXPpTBMTlII1CS4nauxfSrHCaeKncKUbCd1SD3rzD7WdY2Ze0gA6EOqmLQkbdNX4SkNnyK4lddhGRF3Ibabq7/auRLIbeJf7gjQXkUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6580.namprd12.prod.outlook.com (2603:10b6:208:3a0::9)
 by CH3PR12MB9170.namprd12.prod.outlook.com (2603:10b6:610:199::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Fri, 18 Oct
 2024 04:18:47 +0000
Received: from IA1PR12MB6580.namprd12.prod.outlook.com
 ([fe80::789d:39c0:6386:9f12]) by IA1PR12MB6580.namprd12.prod.outlook.com
 ([fe80::789d:39c0:6386:9f12%5]) with mapi id 15.20.8069.019; Fri, 18 Oct 2024
 04:18:47 +0000
Message-ID: <de127207-40ff-4c9d-bed5-37592de4123f@nvidia.com>
Date: Fri, 18 Oct 2024 12:18:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftest: rtc: Check if could access /dev/rtc0 before
 testing
To: Shuah Khan <skhan@linuxfoundation.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: "shuah@kernel.org" <shuah@kernel.org>,
 "avagin@google.com" <avagin@google.com>,
 "amir73il@gmail.com" <amir73il@gmail.com>,
 "brauner@kernel.org" <brauner@kernel.org>, Matt Ochs <mochs@nvidia.com>,
 Koba Ko <kobak@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20240524013807.154338-1-jjang@nvidia.com>
 <20240524013807.154338-3-jjang@nvidia.com>
 <202406201937464fc96b1c@mail.local>
 <8c92ef18-6648-4348-9008-4f646d8b6956@nvidia.com>
 <05f24dbb-cfe6-4a75-9382-273c9c734b22@linuxfoundation.org>
 <202409241931048861ee5b@mail.local>
 <a9e43219-a4a7-4b78-8c03-c8deee36befb@linuxfoundation.org>
Content-Language: en-US
From: Joseph Jang <jjang@nvidia.com>
In-Reply-To: <a9e43219-a4a7-4b78-8c03-c8deee36befb@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0031.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::9)
 To IA1PR12MB6580.namprd12.prod.outlook.com (2603:10b6:208:3a0::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6580:EE_|CH3PR12MB9170:EE_
X-MS-Office365-Filtering-Correlation-Id: a84f8440-0a23-4ab8-6336-08dcef2bf60c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3c5V1IwTmZTWSs1Qk9CbVMyRXpUUksyOUViWHFMRWlJVGVoTDBwWGNnUWtU?=
 =?utf-8?B?Smoxb2kzd00rTDJWU2pVY0t2NE4zcDAxRmMrak1Bd2tNQzd1Wk1rcVJUQXFt?=
 =?utf-8?B?UzVBcFZYSG5iQS9yVWlPRXlaYzl3VEIveU1kSGlRZjkwRTcrYjlTWVFDdlh3?=
 =?utf-8?B?ak80M0N5blNiRUZyQUNoV1h4eVdjZ2o5TXVGYi9uUUVqNnZIenFSR2ZYaDJU?=
 =?utf-8?B?MURVNHkvVTBzSGJ0V1NZN0F0ZzZJcHlQSWpmd1dGS0pmS2I4NmttQWhaemM5?=
 =?utf-8?B?c3Z2eHVuR1NjQUVPQ1ZNb1NUbG1UeTBrWUdKdHp5M0czVWUxM0VNWEc1TWF4?=
 =?utf-8?B?SUZES0c1a0EyVnJQdEFQQWo1NzVPT0xVYjVSNlZLbThPc3VKZklLZWMzejVC?=
 =?utf-8?B?dy9TL2xTV0hPVTUySTkwQ0VTbWtHS3BDejUwV3p4YWpPNmxRUTFtOVpXaWNv?=
 =?utf-8?B?OEVjOVBrSk82SE9SVWpxekpyUWFTa29nekY3aXNEOFREcnpoV2pldTJwOUtl?=
 =?utf-8?B?cnl4eGkwSVEvbXFOMGlFdm1icXNpem04Mm1JMzB3QjRRdWZGNU1Fb215Nm5L?=
 =?utf-8?B?V1RqQlZJaFUvYncrU3lMR3U2cG03dzZ5M0w5N1ZYZGo4UDFBNFdjS2M2K1Vr?=
 =?utf-8?B?WXJ6YjFkTUgyOHN4alNqS0h0Mk16UzNHbGhKdndwczJibk1NbmpsUk1xS1Za?=
 =?utf-8?B?cy9yQUNWY1ZBTlVQNUJSNFY3cjZoVDRNOEF3NXFpMVVFbWVNRDlCREpvUm5W?=
 =?utf-8?B?RlNyajFDa3BQSFlJejNUUGRYQmR2RTVpVkMxTjgrR3NrZDBYR1pEQWk1L2Z0?=
 =?utf-8?B?dmNpUXY3ajJtOEZnaHAzZ1pUWm13TEZ4VWIvVUNDYkxiU0RuN00zWGcxS2Mx?=
 =?utf-8?B?bDhNWFdDM1JyeGdDa3Q1TFQzajhvTjBCd0paN0JZNVpGQ0RCdFBXQW1CTzFB?=
 =?utf-8?B?Q0lmYUtZVGNjTFZSZEJJZ0ZjNnVQbXFDTTg1Z3A0QnFJcFZUYzNjbUlIQzJv?=
 =?utf-8?B?Y2NNRDlQZVdIaDRiMXFSQzk0TXJ4bWJxMVVWUlVjbUQ3RGpiV3h2R3V3QVVX?=
 =?utf-8?B?V1BWZmJHZms5TVBUajhkcWhqbzVzekppNFpMUEwrdzlYcmRzclU0cytTZEky?=
 =?utf-8?B?ODhhRVBSOHBKMlFaK1dpdlU5aVZ4L1BzcklZTWZzekYzSmNHUXRZbldCbFNR?=
 =?utf-8?B?VG0yczgwdmMwcGYvYXN0b2JsZVZ4bEJCeFVrdU1IRkJwYlhtUnpkc2MzcHBC?=
 =?utf-8?B?cXhYQWtpYndSQWdpSkJobkpRS2tZVmh1Q2VMcnhKMXFVRUxjME53MUhiWllW?=
 =?utf-8?B?MW9PdFRRclN5V0pGMUpTYW9rd2RvZnJ0M1ZqSXZ5NXBOS0FLMXl1S052Mklv?=
 =?utf-8?B?WVYxQ2l4c0ZNT1N2ZEIxeG5Lc3dvQ0czY0xsKzVhbmRoYXdhZW9rQWZxb3Jn?=
 =?utf-8?B?ZWFoVmRQc2l0cVQ2TGVLRmRPRFZPQlJIYjZxVkMyNXJITWFWZ0k1VG54RjZm?=
 =?utf-8?B?WGl4ODNwbElGWHV0aW1ubjc3RkJqdkRSL1ZvOWhXOGRxUEphVlJxdUdZMTdC?=
 =?utf-8?B?V2RBTUl2UmpWZTd4cTFMdVJoc0JNWVpvVUFkQjkwMHZadGs5QTdvQ3FpV21K?=
 =?utf-8?B?QmM5N0NCektsYVJ0QkhpUEVzd0kwazZFc0h1LzEvM2JaRUwvYWNqeEErRmxC?=
 =?utf-8?B?eXJ5TzEyTi90cHBVcFVyM1hrMkhHZkxiRGltQVN5V0YzOTVZVktyUisxa285?=
 =?utf-8?Q?GwyMFO/fcM0EkrZfF/cBxEnlrO5WgFlCnf6A47D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6580.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHVEUW94bEh6clpCRnNMaExCK0JnUUx1SzRTSHd6c01pZFlkMFZNNFI5REd0?=
 =?utf-8?B?a2FxZUsxQmNrdGEyeVVRUzVpdDdta044dDJCb0VsakR2NTcvVW41VllLcHNI?=
 =?utf-8?B?dk5tWWdYYWRnMlRtcy9yU2Q0Y2tFYzgzSHdndjhOL2gyYUtscnYyUjkzWTI0?=
 =?utf-8?B?Smx6cGdPWU1hTndJZ0FpdW9zSkxmdU9Jby85MVllUElEY1dIZHNlRW1qcGRp?=
 =?utf-8?B?bGp6ZE0wbFI2MVo0NVdRYXFkY1VsQ09adWVGZWtZRndpQ0Y2eGxqODVTMm1q?=
 =?utf-8?B?d3JjUmZUWjhwdVZPUE9JOVA4ek1iTUVYbnh2ejlYWG9UNFNDdDBEeXFJL2J2?=
 =?utf-8?B?eW0zOGFmNHJzWXd3WUJobWJaZW1DZTVhT01nSnY1MmU2MzY3UndUUEJKNi9L?=
 =?utf-8?B?MjlUWC9SU2UvV09wSFpyWWtzL29yTzJHVS9xOTA3MjNGOC9qSS94NExpaHU4?=
 =?utf-8?B?S3JHSk1QZ2dYTmhCcTl6M0cwUjhPSzY4L0ZhZ2d1NGJLc3VKWlk5eStiS3NF?=
 =?utf-8?B?UVdzcGF2aDluaDJ2bkFmWWtROTBCc0FLd285QXZMZDhFTmZKQ2Vva2c3Y1Rw?=
 =?utf-8?B?ZHlmdzRpcTdQdFZpYmtJbWhJOTJhMEpvUWpsOFBudFYyOEJhRTByMGxWSlF3?=
 =?utf-8?B?VmwwVHlCekZiRnBTNmFGM0hzY05JUFVFV1ZIUFA2WFBPaHM1bVhPd3UrMGlw?=
 =?utf-8?B?MzVhbExaVjFBcDg2VU9WcXIrRmpFZnRvRnE1cG1rZkZMb09JUnIxRHdFcXdH?=
 =?utf-8?B?MWlFVDFHRkh4OExES2VBTVlvNkNvRHJMaWRITXQvNWxmNlpDWlR3NlVwcmlv?=
 =?utf-8?B?Z2VEdmhsdUdwZGVOTHF1RFBWWjFCdU5Tcjh3V0NtZTJXSFdOTFU2aWJnMTMw?=
 =?utf-8?B?S0gwdzNob2lCWStxWlBFVUNaSUM5eTFJditxTUU3Yjdya0NzeUpISU1mb04v?=
 =?utf-8?B?MEU3RTFhQStHZFlrTThPcHhCTXQ3Zjhtd0UzYlEveHNsN1hRT2tvczZEYnlU?=
 =?utf-8?B?S1pPcnBiSVo2TkJwN3dOYXlOQTFrTEVpbTVrWnArSmhSWjBONUsxUXpTUGZ1?=
 =?utf-8?B?Qlg3TGFrUFhsOUlBeVFWSGxKN2w1S0x0djYyaWZHVXV0ODhQdEVIR0g0dFN3?=
 =?utf-8?B?aGdybXhoT3NxOXhiczd4cERWWWpBY0s5YWJnaGFqVkRyZU1Bb0h4bHBjeUt0?=
 =?utf-8?B?MTd1K0dsRk50VURuSGFIZjRWZzhtUEhpeW14U0tLVnhDZHJIMDYwMTEzT3Zo?=
 =?utf-8?B?bTJQL2JnZFNrdkF1dzBmamowcEJYakdnNHZEcGk0ZTc2UHJQZjU5SStYMldH?=
 =?utf-8?B?SEEya3hpRTJZc2EzUUNUWTc0eGNHTithdyttWDFxRDMxN2J4OGhqMGF3eEZh?=
 =?utf-8?B?QTQrTjQvb2szYWJwdmxGbHMyNG55S1ZwWjhXZlRKMEgrWkN2K1I2ZTRNcXpB?=
 =?utf-8?B?ajIvb1grZFlScWRORFpITjhveko5WkRhWStGRjFaVzFVTE55YjlZaHJkbXRU?=
 =?utf-8?B?VGVUQUVkWEMvWjVYSE94N2VJeUhMU3g2L1hIMm9janc3Sklxa3NhMmc3eCtE?=
 =?utf-8?B?cnNRcXJ6NCsxZXUzbVdUR0N3SWFQZTNDK0d0NUlSZFp4ZGhrU1hFV3kxME85?=
 =?utf-8?B?UjJsalVxU3k2dThXYTkvcTdnVVBLcmFjMFRVbHB2RnJkcFU0THlTRkVLempt?=
 =?utf-8?B?VGwybHZQczRBc1k4MlR3NVhuQXZ1S2o0WFRibEZLaTJHOEYxT3lvU3psNnRp?=
 =?utf-8?B?dDZMMVcyRmlXMi9VRWg1cXpoNTdjajJIejRQYUtkWWd5MmYzdW1yRUJ2TC9W?=
 =?utf-8?B?OUVxclJ5eHhWdWNBU0NPa3prWWRZRnBXV1ZSZTV2VHBFT3N6bVpUZ243cmpM?=
 =?utf-8?B?YktUYkxIVi9GVmpHNTIvc0hYU1pudkxmaUV3c29aaDR1bHdHUDlZdWZXOEx4?=
 =?utf-8?B?cXBqNFhzTkMxT3pLSmFZZ3c1MFJleEdxWnlrUVNDOXpyalRYS3YxZHRjcGV3?=
 =?utf-8?B?d1dXZURCOElMTkVLOUNCRDRFbHdDVGxUaEZGZUVWY3FSRkxtZEluMUJPYnF4?=
 =?utf-8?B?eFZ6NDhieDF2bTlzdzhYdzdmNEhxbnFZR2x2N0RMUzVQR2dkc3l6TXB1NTgz?=
 =?utf-8?Q?4t8tSYTB9YoFYabwVTYdrfBCL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a84f8440-0a23-4ab8-6336-08dcef2bf60c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6580.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 04:18:47.4994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bcHEWKrTgohh/rYvE0ecUe0pi6NkGSIM7poR3S5HO4m1UWlHeIGEBCdr/C7q07H2O/8SUN1UOz8JVxNwDgm2mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9170



On 2024/9/25 3:57 AM, Shuah Khan wrote:
> On 9/24/24 13:31, Alexandre Belloni wrote:
>> Hello,
>>
>> On 24/09/2024 10:05:43-0600, Shuah Khan wrote:
>>> On 9/23/24 23:37, Joseph Jang wrote:
>>>> Hi Alexandre,
>>>>
>>>> Thank you for looking at the rtc patch.
>>>> I saw you Acked the [PATCH 2/2], not sure when could we see the patch
>>>> in kernel master or next branch ?
>>>>
>>>> Thank you,
>>>> Joseph.
>>>>
>>>
>>> Please don't top post. It is hard to follow the thread.
>>>
>>>> On 2024/6/21 3:37 AM, Alexandre Belloni wrote:
>>>>> On 23/05/2024 18:38:07-0700, Joseph Jang wrote:
>>>>>> The rtctest requires the read permission on /dev/rtc0. The rtctest 
>>>>>> will
>>>>>> be skipped if the /dev/rtc0 is not readable.
>>>>>>
>>>>>> Reviewed-by: Koba Ko <kobak@nvidia.com>
>>>>>> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
>>>>>> Signed-off-by: Joseph Jang <jjang@nvidia.com>
>>>>>
>>>>> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>>>>>
>>>
>>> Alexandre, I can take this patch through kselftest. Might have
>>> slipped through my Inbox or the assumption that this will go
>>> through rtc tree.
>>
>> I assumed this would go through your tree, this is why I didn't carry
>> it.
>>
> 
> I will take it through my tree then. Sorry for the delay.

Hi Shuah,

Thanks your help.
May I know when can we see the patch on master branch ?

Thank you,
Joseph.

> 
> thanks,
> -- Shuah

