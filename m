Return-Path: <linux-kselftest+bounces-25940-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76C8A2AE10
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 17:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3766016A550
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 16:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DABD23536D;
	Thu,  6 Feb 2025 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="n2H4sTqu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020104.outbound.protection.outlook.com [52.101.85.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F546235367;
	Thu,  6 Feb 2025 16:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738860336; cv=fail; b=tg32VPVf5tflIyAITx+lO551bqTx2j6DFizNTb/832dDxChTzisM3li+sxJGb2HF0zgaRjkhUU1wp325AhhBqAvXm80sEtSTcL00SgeG7jakrWQics/qHe0CQjimnEeli4lB48Kfyqy1vU7LphIKdEDsX8dQVhgh/az++XhHDDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738860336; c=relaxed/simple;
	bh=9vU8QcuUa5oqI8QxvokQx275MVpdLF8C+wM40CmE/z4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HYtO1SkAjClqUWQtRfNw35iJinwPXCrbX3BrPThpLzd+c6PXivkD7gUQ1UwUyXpQt3OgUBJTtS9p7fmadNjUje5ajTB92Que+a6mMw6ElPeb5nqrRFpUK/86Ftbp5+xYgXVUr6VpXpKtADBvv1I6BCynqAPiNBw40xtxS+n+vUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=n2H4sTqu; arc=fail smtp.client-ip=52.101.85.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVVqQcuR02QR9Aj8OLC7LiAcLI37PgtrcScwECGtTikz5vjHSwRB3Fgb8zaX98eRgZoFBSsh8NE/U/tKbbliGPQdQV52QGoEVLoWhfKeH7feFXdlIaGM8EmVm3ZlBrdUi1u39RoNxo+/nxRR89KW+fzjnQ+GuC9jtt7xPlRaSq5wcu0V4VuwThwTOPwaswJoNC8X+AhwxJOiUSHDnhGeZWjp6niH7y46ppeKS5u4RWKEH/NURKmfelfJWOoy8RVgh0mXEBwTszQyb2Gbs/HGV0ktzdmiAbXnkaVb1r2N5f8FmjUEWS9U0Jl80CDl2hAZbe1+HAiCqb8FxdHY1xaLkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHI2SDvexL558CF8R5g+IicOeC/l/9KRjwi4cjPDcN8=;
 b=nuNoHOlVDHXNnU+BJ0v+CbQ0Dqa6AsYO2XAKVqCeL2e6oBDWorQHBFTxX1L64HvczTkdq4QeOsXhJCUILul9myHGFlmSZXe/uPe3m8p9W4RI0wigl+BetRLNS4I6FykFv7foBxyECJCsYdnwXU1T0f+F0BTDUZwBl0V4CPeOjEyR7LvRYJpuQ2xke9yuZfLNuzzK6YJvT9V1/fcIb5PtZ/uEL+tdpSvkvV5mkjkHejaQlDhUoUAJhy6huPU88RzXPY+yBUX6TfeFFuVZWLdJ7/J/lvuM/NuiPqvSrqS8anIp8YmgLjEmgskiGTVlfFq2rGwNqc34goA/RQ6ssaEbgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHI2SDvexL558CF8R5g+IicOeC/l/9KRjwi4cjPDcN8=;
 b=n2H4sTqucUkRMDuf0S2oeea0BV7gHnjrS5Gen2GX1OVAz/c21W2HQiZbHvIxK6WLPYqEP1dHNGGx6dvidZLeu0g+lhM6dBGDNIV2jztRX5CGj4FjbesRfd37eEIKZqQ5+oUZmPGsjpGwAkTh3/Ef6IYQ+Wd+YpR+L/g9zKgst4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 SJ0PR01MB6478.prod.exchangelabs.com (2603:10b6:a03:298::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.10; Thu, 6 Feb 2025 16:45:31 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%4]) with mapi id 15.20.8445.005; Thu, 6 Feb 2025
 16:45:31 +0000
Message-ID: <d16f9c1f-7788-451d-8f1d-9a068aef7f0d@os.amperecomputing.com>
Date: Thu, 6 Feb 2025 22:15:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] Add NV Selftest cases
To: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
 suzuki.poulose@arm.com, darren@os.amperecomputing.com,
 scott@os.amperecomputing.com
References: <20250206164120.4045569-1-gankulkarni@os.amperecomputing.com>
Content-Language: en-US
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <20250206164120.4045569-1-gankulkarni@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0115.apcprd03.prod.outlook.com
 (2603:1096:4:91::19) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|SJ0PR01MB6478:EE_
X-MS-Office365-Filtering-Correlation-Id: 66382f97-03c6-468e-c32d-08dd46cdab70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SzUwNTNGd3M2SHkwM0FaQlp5S1pwc2YxNXR0cklTU3lJOHRFamxqSVNEUVhT?=
 =?utf-8?B?UjlzVHU3b2lRZmZXYUhGdGZSbHR3RUV0TUpnUmlQekRrVW8xbDd5TlJIS3Vj?=
 =?utf-8?B?bk8zYnl2MkdCQWVEUTV2MEZnNkRSMGlRdWZibXZCWUFpVVQ4WXpndlVGYm50?=
 =?utf-8?B?VTJLNmoxY1o5Njg3Nmlxb2tFd2hsUmRSdzNndW4ramxUcE96VG16QnIrUXdj?=
 =?utf-8?B?OXM5T2p6ZDB1RkJzTkRuRy9VNGNHa0dTUEpXd0ZpRTdFRVJNNUhSbVVWRnRF?=
 =?utf-8?B?Y09LREJGelRvSTVJNU05QTBCVUtlZkFFeUZ4QnZYWXlkb1pteERKUWhuc0lU?=
 =?utf-8?B?TDRHSDIzY0N5UDY5YWluWVNhMHVIZ2xtKzFsUE0xcDZIRm1FS2NzM1FMMURF?=
 =?utf-8?B?Y2JWMTVOdXZiSWJLaUNmcEJHNld4TER3RndwZE4xdzUwM1MwbzhhTjBSN0x1?=
 =?utf-8?B?Nm00RkpuMUVzNzl5M1JsYVVoWUhyNXRtdEpqV1gvTy9hZWl4Y0lzNzZJRDFt?=
 =?utf-8?B?WG5kVm4wWnUwd0RPYVpIV2NHTnZBOTllMWl0QXNPSGJFS0tlZXNVeTJ2WVZv?=
 =?utf-8?B?NmxsWVZVd3N5NHBoNDZzaml3TUdrV1lpVzU2ckxpRzJOQ0tMNUtmSFZ1SEtY?=
 =?utf-8?B?cjhoRzg1QUY3anFsZ0lPMnNiT2szN1VibjBPbVhMVXZWbXBiN3RSUWNYU2ZY?=
 =?utf-8?B?WHBob0o2S2NUMUtvVkp5NFMvVGgzQkVLSUNWYUhacHRDVHhNOXpxWXpGbTBp?=
 =?utf-8?B?M0FnT2lZcytOeUxFRWxJaGkzMTlyOGhBK2NSZEt4c0htTkpCdVdEUGN1cGhK?=
 =?utf-8?B?ZFJwVXc3ZFR3b3BCVi9GYmhOblYweEtMZHZ3dFRPU1oxSHBrSkxhdm5qNHVG?=
 =?utf-8?B?ME43MmxxNzVUUUEvaHZWbERzZWE4S1RWWWVtc2NRMWJ3dDlqUitKVUt0dWoz?=
 =?utf-8?B?enppSmxQV2UyNFBNSHVYcDZzTloxUjlqdUJxV3F6cWtTaWRueTNDd1hXZ04v?=
 =?utf-8?B?TDJUZ3FKUG1DbW5TNTNMV2Y0MXNkNENEaGFaeHN6UVArbUlsTUczcW1URXl3?=
 =?utf-8?B?d2R5MWh5N0MxMDNrWG9mYlNXTlJQT3YzQXh2VmQ3WG11YjZxWHpoQ2grUHFG?=
 =?utf-8?B?Y3BBaUFFQm8yb0Z4QzlxTTkxSFBvYmJXcU9NTnRjcHl5TitrNmlPcHhxSnRO?=
 =?utf-8?B?WnA1Q3R6THNRbmVGcyszdW53WHJCMXAwZHRNZ3pOZ3BXM0xYVkYyR3kvNDEv?=
 =?utf-8?B?Y3l2YmlTRXJoMm5VS08yKzZ0R0hWVW5ZbFl6ZVBVcSs3WTNQVE13cWZnZ1Q2?=
 =?utf-8?B?a0NVbjdCWFUrWXp2elJjVWZuWkMwMUx4NzcyOG04cWxxUnEvNmNQaTBsVkZm?=
 =?utf-8?B?QW9CMEhNUU1oZ3F5OFd6ZXBuQkFjdXFRdVZSbWtDcWdsa2tCNzVkN2gxMENC?=
 =?utf-8?B?WFpodUhXM0lWVllrVmJPcTNWSXdEakJKOU1OQk1DVC96eGUxNDlRMnUxdmJy?=
 =?utf-8?B?N1B5anRzbi9qSi9wSnkycjNSb3hab1pxdklXMDI5dlZ6dGd1NWRqcis1TTJH?=
 =?utf-8?B?emFwN0tSeWdVUTVRejEzSmlEQTdNdHdDQXlGcWI3M2lNS3ljQTRUZUlRM2Fo?=
 =?utf-8?B?aFdNTGZQSDZIMVZTZkpHUTJqcGxQYlNVSmFyLytJVWVGSzl4RldvVEREMXh3?=
 =?utf-8?B?OW5kNHZxVVFyQ1ppWkkxR1FvdkZBdEk3VGJhRmlHV1hCbm1YRjFtVks3VUV3?=
 =?utf-8?B?aUVoeW4rODFBN3B1OGNQdGJKVG5SZllVUjBPUFZXczFRRlBSWHhmKzFBZTNz?=
 =?utf-8?B?KzJLaDVFbE9GTVNkVG1pT1Y0QmRRTC9sOE9pY3ZsSTNoaUNYZkNrdVdQczlJ?=
 =?utf-8?Q?SXw+hieprouSe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWRHVHFVUXgzcy9GTnZWR3JlT3JKYnFkcXUvSWFsa3hYYUNZdDZjUXdLeTZJ?=
 =?utf-8?B?T3Y5dDlBcEN5WFRZb2l1akJ3ZXRPRmZ3eDhHUEp1dnVzZkZVQXE1UjZYa2ZD?=
 =?utf-8?B?eXVtY2k3WlRpdkVNWkprTkd6UEF3VktnR3R0eWlFNGlNT1lYVTRCb2dCck0y?=
 =?utf-8?B?MHk2V0RUaUEyakxlMnVibi83aHcyaDJiV0VBMlBseWVsRjgvcC9tNnpSdVlk?=
 =?utf-8?B?UnNKV0dWNDdqZVd4TkVoOXNXVGlLTVJQdTQ0bXBZOE1GT0R0MmNaRXYyL3Zt?=
 =?utf-8?B?anByam1FMkNPYjdmR09OWlprY3pkSVJnY1orY003bjl0RW1iTE04akE4MU5Z?=
 =?utf-8?B?ejRNVFVCVURvUEpQeVBuNGpuNFpRaldZMlVCcHBiV2QwWnY0LzY0SERjRFZh?=
 =?utf-8?B?VnJkSWVRVUhQa0FyUkRkSFFiQUZRdmx6Ukw3NWRPLzFiM0s2NjBMNjNqUXVh?=
 =?utf-8?B?SnhrNVdlQlNXRWNPWExTSm8rY05hSFhqQTZQQWlCaGFEa3ZwcGRmb1dtMnVh?=
 =?utf-8?B?SGduNmhLc0FabE9NY2RVNVpmWnpHdG03a3VGZE1sR1l3U05vSm1kMk41THhH?=
 =?utf-8?B?Rm5IWm9zc0Q4bytteFdoVm9PNDI2Sy83dW5XdDJBYS8wK3RONXFWc0w3UG1P?=
 =?utf-8?B?SXhhNVhEbUFGMkc2VUJFVUtNbVdGczR0WW5zbnFsNjhacit5b0ZOajBnRFJn?=
 =?utf-8?B?MTFSL2ZoNjd6SXRPa0I3V3BzUzNZTnRLeFZSZktyWlNJc2dBcmZFL0pWeG1w?=
 =?utf-8?B?K2dWOWtpcSt1SzBDWVF1dk1yejlZaDB1M0hSQW1rS3o5UGlHRENucVZ4cXBz?=
 =?utf-8?B?VVNKSExsV2J5bVJXNFBTVUI2dXNhMUc5bDRxUUFnTEd6Y0ZQeTZSenR6VnM4?=
 =?utf-8?B?a1E1Y0Ixa1BrbFN6VHZ6RkZCQStKWS9CMGVjRkxiNHk0dzAwNW52Q0g4b2E4?=
 =?utf-8?B?MWF0US96KzM3UEc4VEwrYi9zQjd0dUVIRkpqNWd1Y0MwWDQ4Q2cxNElaTHRo?=
 =?utf-8?B?ZXlsOXBlYXYzak9lL0t5ZElWZFU5LzN1d2RtRGJXQ3NuaHplRlZkcEIzTHN3?=
 =?utf-8?B?cllxb1NWOWZkVDFvVjBUL3VjSCtDT1ZXdStYUnZMSmllNnI2YWRidnRVa2lZ?=
 =?utf-8?B?NGw2ZjRnWEpvNXUzT0JoTkFJbk9kQjhZakZuaUNlRi9hNE1CQWN0dG04b3Ux?=
 =?utf-8?B?M2hCdU5pRkVxcTBOS085bXBQZHZsbW51Sk9PeXFpZ1RGSk51Z0xLdjlRQnln?=
 =?utf-8?B?RDZuVXZFNlRjRE5kd0JhSmtnZk5iRUljS0FkSW1xMExQSUpzNFNXbDhOWnRT?=
 =?utf-8?B?WVczd3VWYkxkMlVQTWJaZmhreHJPNFVzV2FDOHIxZWtDWFlQUm5lTGRnMFE5?=
 =?utf-8?B?ZXhNa2ozZGxZY0pRbWcxa2owMTd0MGdYSFlHMnlla2hhcUdrblRoQjd4VTY5?=
 =?utf-8?B?eGMwMXN5U2taMDJ5YnU1T1pqZkREcWlTQVpjS2o1NFVBR2VPb0Ixd2lSVDBO?=
 =?utf-8?B?VUVTSjNrbW5zeFNvTUo4TUtKWjRQbDNRSnh0S1QyMnhLQnpRVmFJc2huVUVG?=
 =?utf-8?B?Tjk4RVpDdk9lUURDeEtmeTEzZUYvNjUyMDBLSFlZekdDV3VzWTZFRHQ4MUJD?=
 =?utf-8?B?NWpEbDRhcE0yU213a3E1N25taHdaV3dQUkRzRWF6RmsyU29NR2Rab0dyUEZX?=
 =?utf-8?B?R0dVYld0L0ZUNVVoZEdkUVp6OWRDanBGNXJ6N0ROb3Y0RTY5eUVrdnpRUGhQ?=
 =?utf-8?B?ZmNhOUJxR0ljK3BzZnJmeGFFZjRKUmtHZ1A0V2JnY3BHdDdGSndYaXovSEVx?=
 =?utf-8?B?U28rRnhDWnJBOXNlOUNPNXR1TG5UNkswcnNvRE0xcVgwTWhhZW0yL1NmT0o2?=
 =?utf-8?B?cnRSYTZBcHpXTUR1Y3Joci9nVGdrVVlKZFk0UXFEWXBScm5KbklzaEIzeVVV?=
 =?utf-8?B?dk4wMFM2VG1UM3ozN3c4blNSdGRibDBoUVVBZFhjcTZvQ0orTnlqcXR5NlVl?=
 =?utf-8?B?QU1lWngrWHBKQXhtTU5HOU4reXduaUhha0lJOE5qdks4MVdTNW1CN2Y3SEZ6?=
 =?utf-8?B?Q1BRVzlmRFQ0cHdDRHc5dEg2Rkl3N2JWVGxXZkVHeGE0U053WW8xQW9WRGRk?=
 =?utf-8?B?UHFUZjNXejNlZ3RWMWpmaFNtdHJHb1NiL2xzSUE0SEdsK2hOZ0RYeVNZQnQ5?=
 =?utf-8?Q?An9uptZ1a2FoOLtkLiMLkx5Bxqq4YhsLu8mkW2VrYNgz?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66382f97-03c6-468e-c32d-08dd46cdab70
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 16:45:31.7509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWwhNxKkU7nUUp0zV5XDyl6t50DYYpaxIIgmBTsxzPISD194yN+MmkbhFhGWemePQslCNR+ToSQL36+ZrzqvAePJQYVIfoUeeoFTvIrMd1SQMaIw2LzvO1livLefrT+w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6478



On 06-02-2025 10:11 pm, Ganapatrao Kulkarni wrote:
> In this patch seried, modified kvm selftests code to enable
> guest code to run in vEL2(As guest Hypervisor).
> Also added test cases to test guest code booting in vEL2
> and register access of VNCR mapped registers.
> 
> This patchset is created as per discussions over ml[1].
> Posting RFC patch for the early feedback and to
> further explore requirements and test cases.
> 

[1] https://lore.kernel.org/linux-arm-kernel/871pz2th4b.wl-maz@kernel.org/

> Ganapatrao Kulkarni (2):
>    KVM: arm64: nv: selftests: Add guest hypervisor test
>    KVM: arm64: nv: selftests: Access VNCR mapped registers
> 
>   tools/testing/selftests/kvm/Makefile.kvm      |   2 +
>   .../selftests/kvm/arm64/nv_guest_hypervisor.c |  83 ++++++
>   .../selftests/kvm/arm64/nv_vncr_regs_test.c   | 255 ++++++++++++++++++
>   .../kvm/include/arm64/kvm_util_arch.h         |   3 +
>   .../selftests/kvm/include/arm64/nv_util.h     |  28 ++
>   .../testing/selftests/kvm/include/kvm_util.h  |   1 +
>   .../selftests/kvm/lib/arm64/processor.c       |  59 +++-
>   7 files changed, 417 insertions(+), 14 deletions(-)
>   create mode 100644 tools/testing/selftests/kvm/arm64/nv_guest_hypervisor.c
>   create mode 100644 tools/testing/selftests/kvm/arm64/nv_vncr_regs_test.c
>   create mode 100644 tools/testing/selftests/kvm/include/arm64/nv_util.h
> 

-- 
Thanks,
Ganapat/GK


