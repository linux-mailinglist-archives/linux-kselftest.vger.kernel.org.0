Return-Path: <linux-kselftest+bounces-41731-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B7AB8096E
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 17:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57D5B188EBCB
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 15:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC941333A87;
	Wed, 17 Sep 2025 15:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Suhl82EK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010009.outbound.protection.outlook.com [52.101.46.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4162D2C21E2;
	Wed, 17 Sep 2025 15:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123138; cv=fail; b=kOvUvO9F5wMxPl3Z2cQIgj9ECMi6BB5bfM9nB5/zGTrkYyEfCZtValXA/yy6Y7kSv8/W+BS1YdkVgGVA6mdzEB6CieifFRX+oP6i/Dnd0f94iOWCW8Jw7u8ZlpegAIhbw64ntNQgixkXwoGA+zEyT+iiJbZr+v+L8ZKFj3lcrNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123138; c=relaxed/simple;
	bh=eK29BZ3qddyodD6+Fu3+YAeeetBEbX7PmQyPM5XphPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UTxqnB1UR9n3GZ1+1LtDfscWy66r06Fd5NfiXzKDW6szUKiD7kI4PNm0vBTu/olWFecRBSrpgaC/XvoIZR3QDJT2+tl2EU6pDU19h+4Y6BFqLmSWqXpEKVQc0SOekGDJaHpbDlTWFSiDjSdD4tOwfYSblXU4w4Zup5JOM/ScUUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Suhl82EK; arc=fail smtp.client-ip=52.101.46.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkXp9rRDmfMHI7M0d24da3+ScPfIxRoFXERssGFZ8Khp/lL1rBgRQH1hXxtjeHc3hRLZ84aVjwmZ8BbZwTb88p78V81aSyk9zB+PygjNQHBfS8cUIcBXZ5BZ/Vd++y/l5Ws08XcLOuzr6rDVN65MyJMV6J2iYVN289D9QHL6wzOTGdaqNl6ENukALj6CCK6mtQURhMYGvemtbja4+LLZTJ9YpKAWvsu61c/CJQ0yQsY3PrBAbY+Zcx87zfYwNR3dMLN2e/G5Kk0nN1AgI5JV6j+GBjoJSgMzY8KXmfodk0fvZks4xgsDnNqEuZVsaxET9vb3g+5RdfNz4jMguSAlUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eK29BZ3qddyodD6+Fu3+YAeeetBEbX7PmQyPM5XphPA=;
 b=tG27Lm4qT5lyrS7Z82eNgRbbdVe37haTOCORj4u/r9K1Hwkrl88B8G+gwFIUJUyMywn4aJEe3L5z9DuC+t2bDBOqsdi0k4ua27VYVcmLp0oRHAy1Ka4/xDJ3OsEuwlPHRIE/Wy9CqhVGOuoyIbrHyfJh+0pKGGRoTMQnqUiswMifhBA87mo35VCwA+BZYfRw++uBqN5m8acluG6TjLqX+8IzTSPT8LQWvAK3pMx+9TznE/HUxMXHWoc+xCsFXZ1qNliHmbXr/9YvFK/jXtW37vjt5ln//aBxo6Ew9Q4nZ/BGIl78/wV1te+r8Zy5q5LAAa19J5tU3Qz5YxJE8kDV8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eK29BZ3qddyodD6+Fu3+YAeeetBEbX7PmQyPM5XphPA=;
 b=Suhl82EKlAb8Op1qv27MFceSvBu3viz6KiKtKZ8IdJvptvstHMA2GxaQGwih7zvxiQrl3qG0X96LYtJgkPbyYQyvWZ0V9nvLtHbKX1fAWRVMuomtyzf1b6zcO2ApdrJTAkv00uCtDArOvcLRRRBaU/a8/0KajVZ5FGXrrtEaeQ92FQ4fM5/6pCUVCsSaTe5wthmRfztENrRcyFn1l+dffpV44PnZ3nUv3fYgyHUb9GzjSuPRBUJt96uuCMAhRwoJkUDNdTinqNxLHUjZVv7T3R52B/FBSvGOOxXCoQZ3c5/gkM5uZbsDRaZbGSEboLvpKThkZxQpUDb/chUcw4Z5ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by IA1PR12MB6089.namprd12.prod.outlook.com (2603:10b6:208:3ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 17 Sep
 2025 15:32:11 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 15:32:11 +0000
Date: Wed, 17 Sep 2025 12:32:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Willy Tarreau <w@1wt.eu>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2 16/16] selftests: vDSO: vdso_standalone_test_x86:
 Switch to nolibc
Message-ID: <20250917153209.GA2023406@nvidia.com>
References: <20250226-parse_vdso-nolibc-v2-0-28e14e031ed8@linutronix.de>
 <20250226-parse_vdso-nolibc-v2-16-28e14e031ed8@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250226-parse_vdso-nolibc-v2-16-28e14e031ed8@linutronix.de>
X-ClientProxiedBy: DM6PR11CA0031.namprd11.prod.outlook.com
 (2603:10b6:5:190::44) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|IA1PR12MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 4160a78f-a605-480e-9c90-08ddf5ff5e7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SE4xeFd2L3ZrM0lSSitNY3ZXczBFU0l4OGxqd0tKOWZJUDR6K3Q5YXdYa3Ri?=
 =?utf-8?B?S0MxbGVPWUM0VlRWYi9xUWRCNXRzTHduUXBTZlcweTgvREo1MFZSUks3Undw?=
 =?utf-8?B?OUlZM2t3Zk9aTk9rVXA3Y2lFQ2ZhU2N3VURwTXR2Z1U0RTlMM2VpVTJJcGpM?=
 =?utf-8?B?UFBDTUUrTjBYYWVUaURNZDdTTURiUDhiSnIzcFpuTVF4TFMwU3djQWVpLytU?=
 =?utf-8?B?RllGL1hlN3VXcVBsdmhUdUFLQUorQ3dGWDRIMzdiREk4ZEp1bG5WRmNpUE5s?=
 =?utf-8?B?M1d1OXdjVzdQaDFSUUZQRGN3YWdoYWJYMVQ4OVlYOXVVSktJRWUxbDV2MWxl?=
 =?utf-8?B?MFJsd085ZzJaMlgzYWY5eHA0bHhIWDlZKy9TUzlNdmlFVmxEVlRxbUhTUVhU?=
 =?utf-8?B?MWZaMUxNSitqK2JTNkV5T05TT0FUYkNjdVpEUHhzaHlyT2h1Qi9vNHBEWUIv?=
 =?utf-8?B?VElBcmN1NDBHbXNhK1ZDbTY4N2VxeW1KVjBma29BM2hYcFFZekV0RGJSMDhN?=
 =?utf-8?B?NVU3N0h3TS9mLzdURkVEUU9IZnIxQlZxK2p6MldXQXlYeG4rcGVlQmkvWUxD?=
 =?utf-8?B?eUVLVkxyNHlOSlcwUXJjMmozL3o4cG9PVjU0YlI0cjlsN0M1bFBscDJWTWtI?=
 =?utf-8?B?OCt4L0VtNEhEeXBETEY1V2JUWlE2WG1uVGVlamVkUnhXY2Y4K3RTOGtvKzVk?=
 =?utf-8?B?UGE4Qml5NmhNeHBXakVBdTgzejNxNEREdDNWV2p2V2ZraENmSnlHN0xIckRl?=
 =?utf-8?B?MGliVXhwNWxKSHp5WlBaay9YRmh5aW53OTYzVGUxL2tBZm0rakU0dUN5c1h6?=
 =?utf-8?B?R0l2QThNQWh2MkE3U2JBZ3ZDcnZGU0tKWGVMZHlXUjBqdVA0ZWM5Nk56cjBE?=
 =?utf-8?B?cm5ML1JqcTAyN3MwQWJERklZVW5jeEtGRVlGRm5jeWJ1UDRrM0tjVVY2ckFY?=
 =?utf-8?B?dU5uZGlTREZZb0dCVzN5NUVFakdYY1ZaUTl2Y05rckFvbmdoMmlVU0FVTUpH?=
 =?utf-8?B?VXk1QVJNajVTVy9kNVpLNGlzNVBGQkFMUit4YUZTVlVOdkNYU1EvR0hvN2Ni?=
 =?utf-8?B?dEl5WGUyYVoyOCtWeXJyNm1CWDVIem1xTEZCa2lBcnRHV0pza0JMSFdGTHp3?=
 =?utf-8?B?RktydzZTQnVTMVp2MFlrYUM0eGJST3JsdG1ZKzR1TllicnFrRE9CZU5rWlZI?=
 =?utf-8?B?K2RaQzhKRlJTR0dsRTV3NzRWUjdaQW9rWk9KT3A3Smgwb0swQVBKSkpTb2Qx?=
 =?utf-8?B?bXIwKy9jNVg5eDM3cDU5bDdDaFBSaU5qRDg0YnpXU3AzbE5VU2tteTh5ZVN3?=
 =?utf-8?B?dkQ2N3FVdHBwR1A1YlBzTzNUR1RRTnhSeThtdTNaV1MyZVZCZHlPdmpsVkFN?=
 =?utf-8?B?WnIyb2tYdHhNVTlrYjY1QzFGeXB5SFlIREtuTWJkTjV0T1BLQ3o5NzBtWVg5?=
 =?utf-8?B?OG9xbGdWYVNQMXdUQnk4YlIySE9zUnJpV3h0c3o0UEN5TEJac3dlWXVFTWZK?=
 =?utf-8?B?d2RBeXVkdEh6ZG9NWFY0a2JvTEVkVVYvSldqZWVnQjc3RFQ4YUZlYUlUQllJ?=
 =?utf-8?B?T2EyNVl1ck5ZWFBSR0J2YjBmRUtPTXh0cTlpVUNvTnUxZ3ZvcEROdTZDcU1Y?=
 =?utf-8?B?WUdmeElPYS9VYUYxQ3ZGdE1MeG1BbTdsV09rNG5NWEhpeXhOdTMwQkdUVVFX?=
 =?utf-8?B?eEJMRWVKUXljRUJWUzl5VXJKQm0zT0NvZHlzQ1BreWd6ZTFpNGZDUTJybDZr?=
 =?utf-8?B?eXFtVUc2OFh2dkNKQmNRNlJpRFlEbzhDUDBGY2V5cE1YSXY2bkdQMHE3dnZL?=
 =?utf-8?B?ZzZ0RFNNamZaNXlZcjJEalRsNjI5VzYvTy9JeFFKKzBhZGZGUkI5bEM3WXNt?=
 =?utf-8?B?amxFLzBLNGVwd2diZENPN1VTUWtrYnlBeGNGaHg1MlN2VkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjVOYkJyUm4xQXpGMlUxYmUyeFZBZmRRNkN6VHhqVW1Ta2o4Q0o3N0Y5cE5S?=
 =?utf-8?B?RGF2MzdwVWxoYmxEZlUwWFpjY0N4V3p1cTdmdmE1bXpNekpVdlZDUEhSY1pq?=
 =?utf-8?B?bjduYndXUWhrRENMT1lDWDVobW4yYnpvaVR2Nk02OVJPdDFKeTdSZFF6MTkr?=
 =?utf-8?B?c0pOYlpWdVJrVGkyQmpuaDVzN0xqVk5BZmNRNFhDLy9zZGNXN0YrcEpYMUxi?=
 =?utf-8?B?T2hEM3VBZnlFM2FyTkpOOHcxVjFpeHQ5eUNqVUFzWFU3MlNMOGdpbURXSiti?=
 =?utf-8?B?S2M3VzZDd2c5MnhFQ1lTYzg3aytlaEJtTnUyS2RodWwxeGUyRGhpL3JMZWJs?=
 =?utf-8?B?dzdkOGpoNUJjVVdSTkJCMHptcUdWYkgyRkIwYzA1S0F2b0ExM2FWZGtHMTcy?=
 =?utf-8?B?NFN2cjdJZndFamlpM2RHbFZhWnBPSTNpSHkvUVFiWUpDT0xsMHc1YnlwWEVY?=
 =?utf-8?B?RjNubzlRMThiTjFYRENQN1QvUG05Tm83RTJzYWF2Sm5TRDVNYUxld3BKOFNq?=
 =?utf-8?B?QTh0cXpsTkRSRWVEakZ3U0tNenhXanU0NGJwSGNNZ1ArYTg4ME9YRGwwSVI5?=
 =?utf-8?B?b0Q2amY2a2wrMHYvTE5zL1pUc0phOU5WNXA3U1FGMGlsaWUxT2w1Qzk0UEk3?=
 =?utf-8?B?K1VocittamRxSGMxQUVRYXJXSTFlekZKL0x4UGxMMWdVYmhOYlFMRGwxVjNz?=
 =?utf-8?B?Y0VzOVBNckx4VC95K2I5a08xcWxvRmNGNFZEZkxSbGhaWWF1alNWYnU4cDZk?=
 =?utf-8?B?MGMvMmFYRFBpMWhoam00aE0waVBQd0dDZTg2cExLT3FHWkQzQ3UvVkh4VVgx?=
 =?utf-8?B?QmxBNUZJYkphS09oUXBtUTZaN2JHWTJoTDhjR0I0VGhFYkFvZDB0dklBWmNk?=
 =?utf-8?B?OUlHdC94cVpOYjIxTXdUR3UyRG5TYitSRmlFVmhMVzhZa1doRFZ0YlM3M0Fh?=
 =?utf-8?B?eFNIVmRLNyt5VWZlVkU4dlpSVVhtdlQvbFFGVVQrdGNqUUdaOGlURHdiOGdp?=
 =?utf-8?B?Q1dTNS9qbkdiYVVuajdtSFo2c2RhK0xnNXlTVjNQazlJemRGeVdPbTFlcm5J?=
 =?utf-8?B?OHRocTQ4dU1PTUNFR09UZTZvVU0xOE56cnROb295OEU0SWNFWDJkNWQzUURD?=
 =?utf-8?B?R2ZDRWJDWWZCUkpuVmxtRm45OTBUOXFxd3FseUJrZWNNQnhJZk1rd1FMUWky?=
 =?utf-8?B?WC9KS1pQTDRMTTkyTlBMU3N2WlNlenlJdndGNVJsNkxZN0N5ejJ1a2xsY3Rj?=
 =?utf-8?B?K2lHQVJRbDROY0VseEJVVFdrbXZPSWF6Z0hpYnZBWEc5amx3WjQ1VkQ1a0Zi?=
 =?utf-8?B?bzRYVTZDeEJvSS9KdVZBQkhDSzZGNWlNYkk5NURkK3NGS1liWWxoeE16cUhZ?=
 =?utf-8?B?MVVzQWhGWk9lRGxsL053b2JBand4TzluVHcvc3NGelZ0OFlLSXA5ZXhrY0NK?=
 =?utf-8?B?OVdJL1c3NkRpQlpLdFN6VWFoR1dVZkdnSW9BNmhsTTQ4QmhjZjMzK2xHNUEr?=
 =?utf-8?B?ck1LK1FObTlHa0Yva211SEdZWkZaTUFDWGlQVFB6WExDVlFNREZsdjBPajl3?=
 =?utf-8?B?cFlNQklhaUV2S1ZzbWJQNmxzdW80YjVLb2dpdmROVEhDNloyZmpRY2xzdTZm?=
 =?utf-8?B?MGJ0OEwyYUJFamFvRm9jNnNKak5abnFrZlZJb2g1YUJzUWVBU1ptNHp0SDMy?=
 =?utf-8?B?WEYwcXZScEZST1BndEw2aEVNNVE5cEdac2NXSy9kZHR0RFl1NXRvQk9uNWVh?=
 =?utf-8?B?M0lodmk4NENpUzNYRzVuZGQ4MmpoNmVOd2JsamJiOWViV3c1VUEzME5rNWVK?=
 =?utf-8?B?YWJPc2Q3emZCOEtzYi85cFE0SDVRZEY3UDg0cGZ0Q0dVVStXYzJrMUFDU0k2?=
 =?utf-8?B?OWcyaEN2TWg0OE9XMVVRWWVNU2tLQ0lJZzJoQmI1amNSdGlqWDdET1ppWEZF?=
 =?utf-8?B?THZoaFZZZmgzRmRKdmd1WWk3eE8vM3l1bEVMSnpOUXdtWW9WUFh3b1I2UnU4?=
 =?utf-8?B?aVhidkNFb3h2bDZXOFB4bTFETkRqVWwzQjVjR2FGRWJxSE9KZ1RENWRLd2tP?=
 =?utf-8?B?ZllETG9ENU1HdDdKU0pLVUhvS09aWGM5RWFsb0tVczNRTm1NS3BtQkR2aVJS?=
 =?utf-8?Q?0EE7wGiGAujnS44LfBLkavZ6o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4160a78f-a605-480e-9c90-08ddf5ff5e7c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 15:32:10.9013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5LfRIWfcGJW6nvu/OHBNJfkCkekR5kNQjp4OQ/6ieDc5ri4b4ZgYzdstcLOI98/O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6089

On Wed, Feb 26, 2025 at 12:44:55PM +0100, Thomas Weißschuh wrote:

> -$(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c
> -$(OUTPUT)/vdso_standalone_test_x86: CFLAGS +=-nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector
> +$(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c | headers
> +$(OUTPUT)/vdso_standalone_test_x86: CFLAGS:=$(CFLAGS_NOLIBC) $(CFLAGS)

This addition of "| headers" breaks O=build builds. ie this:

$ make O=build-x86 allnoconfig -s -j 14
$ make O=build-x86 -s -j 14
$ make O=build-x86 kselftest-all -s -j 16 &> /dev/null || true
$ make O=build-x86 -s -j 14

Fails with:

***
*** The source tree is not clean, please run 'make mrproper'
*** in /home/jgg/oss/wip/kselftests_dirty
***

Because the build now spews stuff outside the build directory that it
should not do.. Bisection points to this patch and removing the "|
headers" makes it stop doing that..

Any idea how to fix it?

Thanks,
Jason

