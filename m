Return-Path: <linux-kselftest+bounces-9153-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D81A8B7E07
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 19:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61551F2352F
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 17:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8B7194C77;
	Tue, 30 Apr 2024 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RnA2n585"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7119517F39C;
	Tue, 30 Apr 2024 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714496292; cv=fail; b=fCiR9pOZlO1McFIX+WGyMJNfKQY9xyd78RRVFoG9sdgPsyEWFGsZtiKRFyBhu4uMDZsdn9u6Ou7gQ+fD+Sx1CvK8skJKLwfOaTMoolokCBjylUV5TECJSg7FBBfai5MuokEJ1iLYFAyWhESpo2DDl9jxv0BVsytXgoZSqwxW88Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714496292; c=relaxed/simple;
	bh=DCpZFh+2gZdNPgPmCPEGEgeL0Stk8JPrdo87mpuHBGM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e2BzEdjURdUn1a1Ewf4KH4BI3+gj0FbrH5xG63PbjpWWXt61IW0Z1XQN9QUU4RlGAWXn/j/BVKvxQJjyw+j4gjs3sB3pDOxabSTi6Iez8aSoBSQdsZSb/Fg4slRM3z94KP230ANOO+iSEcVbUYpbnxmO+1uo0ix2b8/RGvTqvOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RnA2n585; arc=fail smtp.client-ip=40.107.244.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sk+1WPI3zJdkXCtMBGQMtjID4Oee4esOM0W/Wxol8MxTDf82+ewLr8dVguyZN9V8BNJe7juDzOGCkQXNuaqV+UZ8+D7Kj8bOmm0kS8VK54d6dNqVi5Ug9x+sY8RpTM0zl5aucAa9elaJBNvx5iHB3BvMeZIZ7TycyqbJi1J18eOkZ3jXj5FzRQ68QUXg46LnwNEsrkjvK2+n3NEVTVUIEvmM4AHonb0cGzhCtS7JXr4HPE93WbSFBJOIg7j3p0nWZ+i7gM+EZruLApT9fOb0Z7ZIphj96BOJ/CnuFN7URADKIOsaoZKsndjVb2eKKpPlodyLvR/KNlszV35yD4TyyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOcULztrfcKn7tJMeKT6XoUsVNz47lUDbMYOeEF7VDE=;
 b=LiIBbSyodXdMZk42yb8NEcANMvI/B0NGbCUpJawkAwEqy4UgP94BLVSk3Jl7lP42LquOmJMDD2v0S9BnSA0Kqpipj6iMohj8rqTzjj8GxWjc30R3Ow8N5jmnFhDCU6NE9Gi57A/9vwADMbuhMFE1h3W3R2zEgNbuHLfoUSQmAbqBa5zsvD7qNVdodFobsz6CH2CJSeLCVtlRhqEIavaQYLG+tN2uY/l5PIShQcVX8EW5vPARONoaALe0VVS/CiG44HoeQC00iK1rhyGZgBRyETuNlsiaPzjErMh3y50wi5JIhdcpwJUyy0MRvAlH/qvXVgofsVifg2Lh/qMzsXk8lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOcULztrfcKn7tJMeKT6XoUsVNz47lUDbMYOeEF7VDE=;
 b=RnA2n585zKzRlQNpEYsBt8ofi0Bq2U2+ALrDMfiOwrnUhoS6XE4SZFepVgNroDnP9/VSBHOHgDE6b6badty048iBfC03VfXLatVkiPiDKmnjJVyjLLaETrfAvoN20cqzdNP8W2NUhca8qOIhjJMG8ty1f5NxSorNCfPCdgeleSnh6/MZAG56O1FPAX21NLrhwVOifcIALjyHosVfZUpCte/Xckl/MzGotn6v1oFpXijE1JNOkRcjkvS2LyVjAPMuoMdBJvF2rq6UMznZqOuaYnanJArE7JSFX7q0LMlIQKQlwqLeBRtz7ywg99FBuGYLDAMLwoP7HZOQdHxRxd1AIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CH3PR12MB7643.namprd12.prod.outlook.com (2603:10b6:610:152::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 16:58:08 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 16:58:08 +0000
Message-ID: <e008af14-7222-4796-91d3-d04af463bf40@nvidia.com>
Date: Tue, 30 Apr 2024 09:58:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: default to host arch for LLVM builds
To: Mark Brown <broonie@kernel.org>, Valentin Obst <kernel@valentinobst.de>
Cc: anders.roxell@linaro.org, bpoirier@nvidia.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 mpdesouza@suse.com, nathan@kernel.org, sashal@kernel.org, shuah@kernel.org
References: <b728014e-9e8f-4b65-8d9e-ace0e2f6f18c@nvidia.com>
 <20240430114452.432969-1-kernel@valentinobst.de>
 <ZjEFOj8NXGO72Ocl@finisterre.sirena.org.uk>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ZjEFOj8NXGO72Ocl@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0060.namprd02.prod.outlook.com
 (2603:10b6:a03:54::37) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|CH3PR12MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff8ae9b-8fc2-4fc2-11db-08dc6936b5e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVBCcjhhR0NBbG9aNzI3Sy9wcmlndmc5aVpXVkEzMTVkRTlUQndXUUhMMVZ5?=
 =?utf-8?B?RDJidmNrN1ZVYUI0YVoyaCtmVURic09NRklPaGJzNDUzNTlOOWNGbWVjaFZ3?=
 =?utf-8?B?TjR1RHlRWFM5U0kydEtBN0xLQ0tnY2VZYmpkOGk3V091QnU0OEpsNC9hU1Fq?=
 =?utf-8?B?aWRUdFRoc3owOFZiV1dlNEdyeGh3azJoRDJzL1ZWUWI0Z3JERml3SU5IM0Z0?=
 =?utf-8?B?QzZJcFI0d1grU3M4OGdsQTdKZzF0dTd0bGxIRXplT21la3VkTC81eHpVT3JG?=
 =?utf-8?B?UjdoZFN5U2Z2N2dPTE5HcU4wL1k1VU5BN255dEIrQ012R25WVHJ3OHN1UDhh?=
 =?utf-8?B?SFJwaURVVDl4d2tzK1FTbGtmdjZxSStGRG0ySkZDSjQ1RmlxTWo0cGZYRDVT?=
 =?utf-8?B?clZjNzhJK0VteUU5dDJuUWkvMEhjM0F4MURmaGhTQVpCdlhnTHNDQ1ZpL3Ar?=
 =?utf-8?B?ZlFLSXc1TnV6d1dZR2hRSVFtZ3htb3NwVTk0RUJxUFhXQVpQQTBDVWxvemdK?=
 =?utf-8?B?eTROTGhXS3lYdmJBN0dvdFhQRko5ZUNKWVA5aGNnbmVyUkFzeFowdHNUR1lI?=
 =?utf-8?B?R1hMTnBLNVQrSmZ2RXkrcE5TVURRdXd4NzByQ1VrSmx3SzRDWUhldjJ2cEwz?=
 =?utf-8?B?anV3anVCLzVVdlcxR2FDUWpWSGJFTXlBTDJMWU81YjdpdGgzUEZqOTViTTUr?=
 =?utf-8?B?OVNBK1FFSTA3L0FzNHJaaGZ2VnZWSHpkWUtRVDJUeXB3bitYY3hYT0o0TDBz?=
 =?utf-8?B?K3I0WlVDKytYbUdzSXZaeHl3cEt1alRIM01MN2tIZlNmMW5JeXdEOE5jZGRK?=
 =?utf-8?B?TUlJN0RZNnQ5ZHVqb24vUElPUlErRjYzRWNKZVpMS3lMSTN4LzM5NU9SSnpu?=
 =?utf-8?B?ZHUxSHovSXhyWU1VVEpxSEY0N01BOGl0STUzVFllTGZKVVZvL0JrRzRzQ3BQ?=
 =?utf-8?B?WFB3OWVyL0F1dlEzeHlyM25XRFdHa0t5RCtaNzZLZXNJRWxINEg3S2o5MVpn?=
 =?utf-8?B?VHd3WS95QUxzYnZPQ0VJUTBibDVNK3RabkpMVHM5NTdQT1BUUjZRV21hMVQ1?=
 =?utf-8?B?RVhuNUk5emxMVUQrT3pLYklJM3ZLeG5hZllxOUhTSEpxNE8vS2V3NC8vdlpH?=
 =?utf-8?B?aFg2eW9weTlCVGl3M2NIbGdTVk42MXJSeWtCZkcvQXR5YlJsRDVyd3FVSFhy?=
 =?utf-8?B?cGZ4NEJBRWI2T3hXdmNpTG9sRjdSMjdDTEJTOFhQRWoyYVFWcEJlMlB6Z0l4?=
 =?utf-8?B?eFJ2NzlXNkFzSW9LTHQwSGFJd2JHOFRydjE5NTNCcGtHQWg4eldaT1ZzaXhx?=
 =?utf-8?B?S2t0VENZbmtqWmJKWXdmQXNPUnc2ZHIxc0Z6M1FLeHZuUDZzZVRBMm1nQ3VT?=
 =?utf-8?B?NnFEYi8vazVCSllQeWtFNjFkZWVEdlVWWFVYQ0l0N3JzRkxodDY0SzBoQUFR?=
 =?utf-8?B?WFRUak9RMXhYazJzSDVNVDJIc1E0d0hta2ZWOUFuelFraFk2SmVTRlZlRTBF?=
 =?utf-8?B?WCszWEJzS2E2WE9Mb2lrUXVQM1JFZzNGajkrQ3YyekpCbmNZWkFVSU5Qa3pl?=
 =?utf-8?B?cFoxbGIvUWJTK01YNVlLeVJiQnp4bEZrWHdkaDVqcU16emFSWVU2MmlHMytF?=
 =?utf-8?B?MnVhRXZ6TENFUVd0NGxJT3piR3Z5YndPTkYxcnFrSmNlN3EvcWQxRTFrUWd2?=
 =?utf-8?B?dWNteDZsdGIzZVhaZGtlelQ2Q0ZlaGhVUnNPOWZpNHJtRGgzWUhFTXVnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUF2c2dHV0lzZXJtNlpSaHZWaFJpVjlkYnk4U2pJREI5NFR1b2I1eTBycXBP?=
 =?utf-8?B?ZHFqTzdOVmNDa0Q4bHpCdGEyU09JU2JOK1R0NTZlakl6T21KK2RLeFQvNGpt?=
 =?utf-8?B?aHpZN0FEYm5pdG5malJ2RG9GcGpzZEs5eTJmRzcrVWltbHZtWGlCWUI0cDA2?=
 =?utf-8?B?Mk80dFRSSWRYVDhzcnVqeDhtM01JZE4vVmxRVmtlOGhWV3JtNzRPZW1iSWNo?=
 =?utf-8?B?OXRZMWdTRmFWSkgwRUtYK3VIRVh2UUxrOWZzaEplVnlhbGl4MG0yS2QrT1lM?=
 =?utf-8?B?K3E3cFMyRmdVUnNLYzh6RlNhcW1vNEJOZzBlUHRNWVI2eUEvOGNKU2pkN3dw?=
 =?utf-8?B?SE1ubncvQTJiaGVjZXdoNGp3VlphWm1rTGJqRDNQYmlUcUNUY0JwK1JKKzIy?=
 =?utf-8?B?YjVEZWt1TzM5ODZ2aithK25QUk16Mjl1Zk5Xb3NHZytMTHFHdVVMbmw4UndC?=
 =?utf-8?B?bVI3UVRyb2lyb2d3RlJGRHo0RVZoWXNXV0wrVSszc2xPd1IzWHhRWE1DaHBQ?=
 =?utf-8?B?RmJXakxwdzdUTWJpcGRZeUlOL3pERkFLOXVmWnNEbzFZeWNMb05waldRd0xo?=
 =?utf-8?B?WUFEVysrQlZ5c3EwY2J1YUtXODdoMk5aV3BlclcvaS9GOW9xdDEvV040RWhr?=
 =?utf-8?B?SjlCRWtMNWJRUXRlZ2tHclp3OEh5YjVDRDNBRkliV2dQN0xyMlkxMThPcE9F?=
 =?utf-8?B?Z09oR1BsZ3dvVnRoM3NoUC9FU0x0Y3d4MkM2WEVxWVdyWDBhV040NkVhMmU1?=
 =?utf-8?B?Y1p2NlI4THVUR2ZzVGRPcnp3S0xTTjVTNklqWU9KaW1mUEY5TmJxNVBCQVQv?=
 =?utf-8?B?ejIxOEhiSDVxVzV3Z1IrM2FLdjZpS1hhNk96dXFMejd4K2g1NUxDK2ZOdkkv?=
 =?utf-8?B?aXBWYnJiTTZ2SlBhS2FvU1FKd3ZGbjlPa3JtQ3puelZRajNmNUlXWEJ6Wito?=
 =?utf-8?B?SnVzcS84M0I0c2pyUWFOY2VYaTcxajlZS2dwYUllWFZVaUhQS0NteE5WUU5B?=
 =?utf-8?B?eGpLYm8zZDBoQk1nSjB5MXd4UnBCdTUycGZpaStLS1cxU3cyTHFPdGdzdWZ6?=
 =?utf-8?B?ZEFwM0p3RUVMcjFWRHBpRkhrWVJYK3FFVjVqRzd3eFMvNUl3U0hRdi9hRVAz?=
 =?utf-8?B?TmFwa3VQbHZzVEVwQ0ZQb0NqeXZjUVdjcU5iaHdHTEV6ZFcwbjhzR0FibUwz?=
 =?utf-8?B?d3F4THI2ZjlnNmU0VkFOSWNZNGJSWXVjTUF1VzZZQ2ZyMVU1UzRudS9FWUVN?=
 =?utf-8?B?M1AvSFJLKzU5ZTV0ak9QWWdYYURPUlZGc0RUSEpvUG1OaTZEOFhTcHVzRTRT?=
 =?utf-8?B?WEt6WVpRZmVWVXJGeTZEZHlFeDY1bVF2TkFIYWI3UkZCV1ZjQmZ4M3JkQ2Yv?=
 =?utf-8?B?OWMxYmFBWVEyeXpOUmlUaVc4WTBydFBjbUpYZjdWckRZMVpNQk9qaGg0dWt0?=
 =?utf-8?B?UHZCcENUTHN0Z3NNdm5nTWJ4aGY3VXd4SWM4cTMzTmljZG4yWDFpdXpwYi9j?=
 =?utf-8?B?cmRDTk5nQ3ZHRVV6SUJVOWJkQ3BWaEVXUmhiNndQSnNoZlI3TFRkYlpyMzBt?=
 =?utf-8?B?MmRML0dvYkRKekdBU3pBQmZVTm5wQmNaYloxeGFkK1pWQXRoSktkZ3hqUVpG?=
 =?utf-8?B?QnZqbkFhV0JjYUJ0ZHNBVkRnVnJFeGR3eUhJYS9vTjg3TWZLS1JqWTlqYTJo?=
 =?utf-8?B?OGxLT2Z5KzFjNXhNYUllUEN1Y0RVRUVFTzFqbTg2K0VYYVpYNW5La1FYWmpC?=
 =?utf-8?B?ZEd3c245b2ZVdUp5bXZuTGZ1dDR2N1pDVXpzdTRObUhkUkZlWjBpaitVS2dv?=
 =?utf-8?B?ZjhJQmJwTWVlQXp5NkZWTEYyL3BIdkZYY256aVpQdjNyeDJva1crdnRESVlU?=
 =?utf-8?B?RVUzcVZNMkE4TFZtL3UzOXdabitackpzK3A0OVlHL0FIbFlmN3phNmxpUVZO?=
 =?utf-8?B?MjFTaVY4TzkzenI0QTE2M25ObUViMENhcW51N1p0KytZN25DYi9YaGdibENF?=
 =?utf-8?B?c2xNbFVvSFU1OVJYRTd2T0IrdWM3SThKcTlzTitjaElJWFU0Y3Zwcm1TSWR3?=
 =?utf-8?B?djVuOU1URDViSDQ5RU9pa01TRmcrSUgzSkttSUxBRGJMOHhDdEJaWUhqaDho?=
 =?utf-8?B?S0IxWEJhNXNZeXhIVVh0cTJmRkk4VW9RK20vVm1MbWU5cU5WMGxhV3p5R1A2?=
 =?utf-8?B?WkE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff8ae9b-8fc2-4fc2-11db-08dc6936b5e0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 16:58:08.1521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4uUeo+ggGBdB7TC5jroV55h3hfUNf1p+6nEdHQYnWQKS10w2WB45uwOHr2RoZhqL7EDnDUEGenrfTg2TF4ZOEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7643

On 4/30/24 7:50 AM, Mark Brown wrote:
> On Tue, Apr 30, 2024 at 01:44:52PM +0200, Valentin Obst wrote:
>> On 4/29/24 12:04 AM, John Hubbard wrote:
>> Correct me if I'm wrong, but intuitively 30+ patches that touch selftests
>> from many different subsystems do not sound like something that is going
>> to be merged fast. Since I'm also planning to send a separate series that
> 
> It just seems unhelpful to lump everything into a single series - a
> large portion of the selftests go with the subystems so you'd be
> creating a bunch of cross subsystem issues and large serieses with big
> CC lists tend to be both offputting and noisy.

Thanks for this timely advice! I was on the fence about the best way to
send these out. I'll break it up into subsystem patchsets (that don't
directly include Valentin's patch, but do refer to it) instead, which as
you say, should go *much* more smoothly.

In fact, just yesterday I fixed the last warning, so I'll start posting
some much smaller patchsets later today.


thanks,
-- 
John Hubbard
NVIDIA


