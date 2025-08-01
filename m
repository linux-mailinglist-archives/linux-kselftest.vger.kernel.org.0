Return-Path: <linux-kselftest+bounces-38178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D53B181F1
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 14:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4F31AA6B84
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 12:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7B72472B1;
	Fri,  1 Aug 2025 12:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="Yml94zOf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA5P264CU001.outbound.protection.outlook.com (mail-francecentralazon11010005.outbound.protection.outlook.com [52.101.167.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700121F16B;
	Fri,  1 Aug 2025 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754051999; cv=fail; b=ZZIJmJfaopx5GrHG4N5t3Edte959Mpuz1by1/mzVYkTToQP9oYDGahsCRULLycIgWwbpvlrv1YEiQzYJ/RaQslFhCp0jlBQdugaEmIhdauSV4JsoAt+l1ybrlRRn2Cry+rkKZTldiCl4Uzafg8gqAS4yCfUA0xP5KuIBIdzbtWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754051999; c=relaxed/simple;
	bh=yIpQlNaCjHSEDfJ1RYhVmoPXzUN6Zr5/BvqsczqwrBk=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mzr/7ur6hFEGTaK4PmtnDdc6lU2AwS6iJm+qXoZcol+zVX54wJlROBKS6Pk7paifMTdEneByqx6JBZ9EHkajgrBNh+KR3uLaJ1v34F9fX7FJc9JcpFCWDzxSRtLqura9mVqRg6y5inr5HUQM6Pj1tPHjw6je1j0HLJ5wyPqDOlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softathome.com; spf=pass smtp.mailfrom=softathome.com; dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b=Yml94zOf; arc=fail smtp.client-ip=52.101.167.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJA+iZy3K4C56AmXKCpdMTqN7vEJx6j0i2SrQPOHIhb8UwnxTj2+K2ZubfzI6at84SP3eXqs/+kvQ3Yetm8Wn9+NfqGJuXnca6fREz5tLWSzsIjvmqVLcbOCaifOzz43LL/QJM9V+RQvuhONllCRTmoiLDr0VQ2ncTHNqvd+1vNQZZDFpb26IFzHthyhcUo8ObprwV/JPhtlHZNc67fKb1mCQ6zvX8XEFWuYDpfPYyP2ZvCbWb+ANJpUNvQ7zhhenHTyJV5CpGskvRJryDF8GpecIaxpCuGkddX0EEl1MSLArc0+Dmdn1bv7ZaAAISIfkNmRMiPptzyAq8zPAbjyJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+eRmQMeI849K3yvrpHDrNPQUNV8I+xRrhRuo0ibXe0=;
 b=SLwN3c5laBzwxBdq+dIyFMjKqiwNgYge27i1l0jKzzJli7nfaR+1ypOakipQrIO1nX1W/Oxy3zUmKz3nsXU+30WetG5Pd9KdLTiZL69QF0qJtP1X4ibCPiPhX4WMtdOysP86TV/LrYXAhAHyqF15j30kl5jsLs0qQZg75YeKthBHddeP4Z3m+xNR1AosOHJyP7JcRmJrGKehGJJUvr23zJjioSsenLSFVSZjN87nNpDBlEC6IFLdRV9eOxAN7NJ/rUtt/W7nrMdmLJuOfh8AaDzvyCg1noeJGcaSH+gxNSnulUm9PgLMVa4Tv2zaMZfVQu7EHEODi47bbGTzEXjyqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+eRmQMeI849K3yvrpHDrNPQUNV8I+xRrhRuo0ibXe0=;
 b=Yml94zOfbs2JT5IteN0dxgswa7ij8JLTMMwngj08xxqi+I91482o+1w4n5619qYFTXj65SgtCzI1vu8SI6jOB5at+9BT4KVihBMQj4R4LSL3hz3WVK6kqQ5B0cgaO26xncU7njUXgFlrBN1JcbGXjHF5t2x2moLw8mKp6j0wWTUcxust9ia9+Ts0xQ4HAqDlS56YZCN6LWr9+E5fsE7CkkmTtftEmB5jZzR3n7b6IsxDKOnxqQyv9de1No9AwcMhYQVEdR58+6ONoaD4QO5+5sAfQVJ35XowHIgyI16D7LLTmpOCg3CqKEaaBGfoETMIzsP2aCWqq3rdhVLMaeEEHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PA3PPF4C106CF41.FRAP264.PROD.OUTLOOK.COM (2603:10a6:108:1::63f)
 by PR1P264MB1870.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Fri, 1 Aug
 2025 12:39:51 +0000
Received: from PA3PPF4C106CF41.FRAP264.PROD.OUTLOOK.COM
 ([fe80::5daa:6a62:2542:e8e7]) by PA3PPF4C106CF41.FRAP264.PROD.OUTLOOK.COM
 ([fe80::5daa:6a62:2542:e8e7%2]) with mapi id 15.20.8989.015; Fri, 1 Aug 2025
 12:39:50 +0000
Message-ID: <c6272a2f-e157-485a-ab16-c3610a969a00@softathome.com>
Date: Fri, 1 Aug 2025 14:39:50 +0200
User-Agent: Mozilla Thunderbird
From: Olivier Blin <olivier.blin@softathome.com>
Subject: Re: [PATCH] selftests: breakpoints: use suspend_stats to reliably
 check suspend success
To: Moon Hee Lee <moonhee.lee.ca@gmail.com>, shuah@kernel.org
Cc: yifei.l.liu@oracle.com, zhujun2@cmss.chinamobile.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
References: <20250626191626.36794-1-moonhee.lee.ca@gmail.com>
Content-Language: en-US
Autocrypt: addr=olivier.blin@softathome.com; keydata=
 xsBNBFooBzUBCADN0hSTI9HfQ6N9mWlqoeGKmpJ0UAh0VHYKE9tzUuVHq6rUXK4GS2F9S9KP
 oATwGuihDcIyhNZCg+Te2bDSmB+cfrSx5eaM815b6VmpZeUelWad/IXC42o0uRLvbLPZxdhs
 WD+buNkC0IJs2RtYet5/dUGIJg23JRaUpJNtC46cQmbmDy0yEWokU2wp9he4XQ6QMJbWLdOu
 X2dLzdAhERKa6VIFrRIagFfeVQZHwNG6WIAj2Z+9zdQbanVugA5iD85Ht6qP/VfjN99tLxHd
 TN+lXJMJYzmivyzlqFAZJXkl7M+5HWgFiQo+AiB+WvIg/7rYdQcnryLaSWB48ZzC3V0fABEB
 AAHNKk9saXZpZXIgQmxpbiA8b2xpdmllci5ibGluQHNvZnRhdGhvbWUuY29tPsLAeAQTAQIA
 IgUCWigHNQIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQO0EjVlHGs4mNawf/Wc5F
 qvG6/K1MshtZQ/2gehE6FZpun55Z+zZkxktro6HtVbeGNyRtAwxwZPZOvThDNbsGbHaIrFLu
 6mwyL2Ev/5zvtHgs5U8VNQhErlwZyJ3lEj+1htWBx1BSuL2Rgpo1EdjhM1aczc5JM1MrSlAi
 93wmVE/2bW2FUT/Dtz+1P95LbW87kbY8Nnl0NDIufEjVtsMF0Gk3qeYLTVXXWhopTrUgb4yL
 zHrbdShnCudJ52eenA4ZtGW/6rRakk+ioR//6DF4n/R4OCCHL4ZQCIX8zBadrzdxrLWBYiwy
 0Sb7wJ7ON7i5p+Zg56iwJqBOKsSZuOSWKmyJJf8nnebi3I8lH87ATQRaKAc1AQgA2XlYWqNF
 KMo1BmBCG82fH6ggGAI4Y82rE0zyaefuWAe1dac4OPzKBGfKQRziF7PMTx/lzLWDF+d1stOi
 ALNcMXhRDDzhyCNuOZkyPMpz6LUTMhQ05v4UBw1FujwxbMzaLSHyZWWLDtPpBcO0nwN/598W
 DT1gNKd95KYpAlrJMKaU7TCtvmn/jWpo7jiScLuncZeaBEhzIW4pQfvic/lbo8eG4tdMwkFI
 CChhmgAg1aCvYb2D+mxZfBr2rqtDqm1+YKEAML9D84QyJu8UdYCJrpgi0GHD0qO4+rEhFwO/
 PA60Ia7x0XzPC6M5epBcIPdftv3OhkTTWCC7YYbeRqInrwARAQABwsBfBBgBAgAJBQJaKAc1
 AhsMAAoJEDtBI1ZRxrOJvbkIAKHmOPiu+bZTTl0m52VR/se8nN2ok8u/zs3mlkIMQbkRBP3n
 mJLSdLUcv3WdoDpEypJ7aR4wMQ3NVW6a2Db/xMTtrBY9qON/LrxItgej+bO5+oEeVLzASR/7
 nH+z9JD55+Z0kHigvupXXVJFjwdX3yjldp6/Owf5X2P13OxkORMWGta4Uv3RYQZZUmQpeR2d
 I0IcLpzV2gTiVicFUh2q2kFmttuxaK/zlHqOssfASbGhrpbXig2d8ircZzu9x26UiLBQgs8w
 0u+BwEIXwHRX9W5Kna1r/lqnlNwe+khLPD4WYjossMQf8H5p3gLnX4rxC7oLo8iRaMnYGFd5
 63eCM7I=
In-Reply-To: <20250626191626.36794-1-moonhee.lee.ca@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PA7P264CA0124.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36e::9) To PA3PPF4C106CF41.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:108:1::63f)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PPF4C106CF41:EE_|PR1P264MB1870:EE_
X-MS-Office365-Filtering-Correlation-Id: 6601d851-7754-4d74-322c-08ddd0f88205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlpKM0NuTGtJMVFSajdOMm5kYXZKTkdNeXFmcEhPNVlCdnkxcDFJZXd5ZW5y?=
 =?utf-8?B?M1p2VUVHMzhma0grczM3aW9CbThzYy9sTjVGVUpUYVpFUkJMWDdXMHlHL2E4?=
 =?utf-8?B?UE4vU3paZUU5WktMNFBxZTdlOXQrWHMvMUFRbVNQMzJOL1FaSit4d1BMZWNE?=
 =?utf-8?B?b0ZYUzFKZDJ2blBDWXJ0Z0grM1dMYTIzZi84TTNldjJaZjRVKzJCd3V1THJE?=
 =?utf-8?B?dEFZS2NOTjNWK2Z2cUo4UHJvRnpMQlQ3K1RiTFZuVVJJdUliY1lya0dMYkdW?=
 =?utf-8?B?UjN2UWxQUnVjdEdnaDlyVGFheXNhMEo0d0x6MWMvYWdvZG5pUmw4anB6Z2lT?=
 =?utf-8?B?MVBqSUdhTnBpQnZ2Wk9nQVZqZUVnWkdJTEFXRnk2OTVJRGlhaWFxcHJTT0Rk?=
 =?utf-8?B?RldlQkhkdHF2MDhUSDF2VS8zMUdtRzRRL0Y0UDRTdFJwSXZva3dzaFpNN2hG?=
 =?utf-8?B?cjByM2l0SXJXNkdzZnhpZ0xsMHJ2V250YjhDVzhOd1hxU1F3TzBLUjhvMGxM?=
 =?utf-8?B?YlBFRlpla2puU2hYUmx1WVlUUDJCZUxsaXpjZlhMRUxDSjBnbHVQRlZLM1NP?=
 =?utf-8?B?RmlwSzN0cWJJLzZiSkJFVEtiVEJsdktIaUd2a2FmWG9ST0YwU043c3FRV1kv?=
 =?utf-8?B?eFM2SFIrS01CZEF1U2lPa2tJRmZZS2JhQlNrKzY2Z0pkWC9YaG53ak81QWYz?=
 =?utf-8?B?MDR6bExvMlEyOTRvYkZGRkc4enFiZ1Azd25ydHRGOXBFSTNDMk1ZTjhBQjIx?=
 =?utf-8?B?UzNjeld4NEJDU1czdUtIMk80ZjBiTDhsdFQ3SzcyYkhiTGhnMyt2U1A2MVNT?=
 =?utf-8?B?MlgxUnBrRjAwTEJBR1BLaThMTFJFM2pTeHNOeFErWkVDUHVpVzJtdnRCcFor?=
 =?utf-8?B?TUwzUFlzMWd4Y3FDU3JoWno0eTkvM2lmNnE2VW1rWnVJOGtnWDlGOXc2bUFJ?=
 =?utf-8?B?dm1ia0pIV2p0N1ZiNUpnM2pCRzlleE9UM1QrYy9uYklzT2Viai9SK2RqUUNv?=
 =?utf-8?B?NE54RTZjZlNPWmxoS2I2UlJVZDJmbVE4Z0JuNm5ia2lJMTdtZWxmd2p4MGJF?=
 =?utf-8?B?ZlhJWjV1aFJURHFWYjZUQzdGZXlVbjE2dThnNUxCQVRpelNTUEpDWnBKTXRy?=
 =?utf-8?B?WEt6SFUxczVHc1BTZlhRdEVIVmVDVlN5V3B5WUZnTFVUMVVweTlkN2Z4UGJS?=
 =?utf-8?B?VysrcW1Cd3prNGpvRXdadjhHR3BlcGZ5N2huV3lSTDZMYUFFOWQ0eGJEaXQw?=
 =?utf-8?B?RmI0UGtPWWg3QWtWbStneUFRZkMxVGt2Z2JXb01vMkZoZVhteTAwRk9ERGEz?=
 =?utf-8?B?R1ZPd0FZVjlMU28zbFJrWjUzRENsU0MzR3lUTXQzRVkzK3RhWG5ZZkM1R2J3?=
 =?utf-8?B?ZXRNNnpEbWJpTGxPQjJ5WXJjekNBZ3RJd1Y0bGRONkttb1hlblM5YnphdHJZ?=
 =?utf-8?B?YVpobUxLS1FmQWRVOUJsT0M1T3RmV3NZZEFoWUtCL1A4bmsxL3JaTmI1T0I4?=
 =?utf-8?B?dVBvc0lKV1N2SEo1NXRmL3kyekdxQ1VrSU16Y0R4ajFhUlJMa0taUmpsbmRW?=
 =?utf-8?B?ZGRGRG9rbGFIZW9aaGNkYzlkQUFRODg0S1d3UHhHQS9NVEJjQk9UaTBQZHRo?=
 =?utf-8?B?cWhrVHk5dDdaa2pPYXExeEhpTndZYjVZbFdHdXhpMndJUHBrcElYMkdudGVY?=
 =?utf-8?B?QUYvakIzQXRwVlAxMUxMbHVOYmJ2ZU92Y3BORVFLVkdldmdTQ29ocnRmVUNH?=
 =?utf-8?B?QkVTL3U2cEhiZWZEU0dFM2N6TC9NenNqYTJXblJKbnZIWk9YRUUyR0NVTnZF?=
 =?utf-8?B?blJlblQwazUwVmJ1b05EWXlSU3ZuSU4rcVl0NXBiT0l0czRFR0VWZTF5cUR4?=
 =?utf-8?B?K0Nqa0U0UVZuWVlwbWNmZmVxeUgwUnF2K0VsakhmcEdIWjluaytudEdBY01P?=
 =?utf-8?Q?VTjCGXUVRyw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PPF4C106CF41.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjVSTkZkdTcrajN0ck5tS2NYN0NiVHM5WEZ1VVFxMUt3ZG5ZTC95QXE0eVdH?=
 =?utf-8?B?REVFWVlSZlN5M2h4WTE2ZzJCVWQrWTQvK25VZkVMOHllS293b3NjRkFWVDFx?=
 =?utf-8?B?WXgwTXdqZ1Bsbjk5ZDhaMnZ2dUJEYVQyU3I2dERmVUZTUmhVaVpXeXUxU1BP?=
 =?utf-8?B?aWdRa1gzUFE2Wk1PMzVmV01keXZ0STRwV0ZYRjYvS0sxdlJtOXgxU0dOeDNX?=
 =?utf-8?B?b05LYng2cEpKSzZCTGpPTTlCWVRuNms0OXJ1RnpldC9xaVRnUnNOQ3hlZzZm?=
 =?utf-8?B?YzRUdG16dkZFSU9MdnMyQ0gzM3M0c2N5QTRWbTc0eEJ3cDJSNkExL3grMG13?=
 =?utf-8?B?dlNvaDdsUllCcENDeFUrc2hROUd4bDF2ZXErN2piVUxwdXpRdlgrK3dTTGVE?=
 =?utf-8?B?NjhkWlhzYldiVVZTS1o1NGV2ODZ3YVErbDJEVWd5cjMzUjF2SVFMYTFPcVZQ?=
 =?utf-8?B?VEVvemdadlJSZ3R2TmRESmFkMFFBancxUUVSVjZaWE03L2NKS2tvNnVLL01V?=
 =?utf-8?B?REdsdzFsWWQvVFR5dTVUd2kwUzZzeWdKLzlicGtjaEhlSDVEc1lycDRJWlE5?=
 =?utf-8?B?QkJDNm1EcCt0eENmRUlqMGpsZk5yK1NVVWRiOThkVGd0YTU5dThickN1T2t2?=
 =?utf-8?B?OFZBS3NybkhBZkx6cmhuOU5Xd2JFL2ZVTGtGY0ZQeDQ1SmdoelJxL3NvaUxQ?=
 =?utf-8?B?U3JKbTB5U2djd3FwbXNTUU03cm9CdjJQbHNtMlVXWkpYRndXWEY2TGNLSmVK?=
 =?utf-8?B?RmsySkw5MXgraTVxcTVYakpLUFMvSGV4TGZ4akw1aC9SS2QwSmZFSHE5YnBa?=
 =?utf-8?B?bDB1SUFzRGtKTmxENTlaempDU0QrZ0JuazZiWG0zZXIwREI5cS83NEc2azEr?=
 =?utf-8?B?Tkk3YmRoeUhGbFZBbTFVQ0RJcmkxT1dYVVpMeXBVaWwzMVFGeCtkUEV0MkY2?=
 =?utf-8?B?dGlZMElWbnhuQ0c5R0VCTHo1UmdUUkRza3dtMjNad3FtRVMyMXNNNEp5WTJj?=
 =?utf-8?B?Nzg0L0JYSmcwbDhpRHpHK0s4bEx1dnk3cTh4RTlHeWQvb2VJdzV6eWgwdm9X?=
 =?utf-8?B?c2lNQ0pIbVljeHZJWGRBaVQxQzQ3USszN1FLajBCalBkRklCQWFnSHpENjc5?=
 =?utf-8?B?M25rZU12eXFnTStBbURLR0V4V2Q2NUxWQlF1Y0lZWFZKbUZjeDRCMXVDTU1y?=
 =?utf-8?B?djhydEl1ejIrcVpFVzNJdG8zWWF2UUQrWERiVCtvSlJ2T3lzV1RDaUVHdzNP?=
 =?utf-8?B?K0ZHeXBZM2dLOGhTdE5lNVQ1ak1oVGVUelhHYmxaZ0FCMlRlOEIzdC81YlFx?=
 =?utf-8?B?S0xjQW5PampudWJkVXJRclZtU1RCTm9ycU5JUCtTUmxlN3RSYVNSN0FjRWdE?=
 =?utf-8?B?dzBtYk9KQXhxY0VaYlNsWjVKcW9NWHltZ2JrRjJJc05yRFFNUjVPb2FVaEJo?=
 =?utf-8?B?M1A2UlRtcFpwVzhZQUlJRGhiWWtYYkxrMmdtS1lVcDRZSFlmUGkwdi9XMnJT?=
 =?utf-8?B?RXBXZHRrdkhkendldlpFM1lSaG5yWDF5TkUyRFp1ZUZObFZoVHo4YmM4VVlI?=
 =?utf-8?B?NHprWmExWmRMNHNJbUplbG0wV01aRUFuTUlZWGhoRmpZbzFuMUR3Y3F6d0RM?=
 =?utf-8?B?alJoK1hpYU9IN1c5YTNTTEw1eEUvVU1RdDBoT2hKNWJvQkpGejFqT3JrcW5K?=
 =?utf-8?B?UUV6cjVPenltT3J4VmpQZUk4WWE0aFBKS3hxZGlWdDlzck1waDZ4ODA2WEgz?=
 =?utf-8?B?NEhPdUFONW0vV2ZRSlprZFZQNlMwOHY0aVVGRzJibC9kczEyR1FXVWRWS2xG?=
 =?utf-8?B?aS9Da1lNc2JObG1KMThrbzJLR0lHNzU3d0lyNC9seDRDMDk3NXg3K3c1N0JF?=
 =?utf-8?B?MzZCaVMrY1FySEJDT3RCVE44dHVFTVQ5ZFgvUlp5T2R4ZTdBWHFRNnNMOG9a?=
 =?utf-8?B?aitPNUI2RDZPL2NqcWhQR1d5WXJOeW9YZlVtQnBmc3FlWXk3REM0UDkxMjRK?=
 =?utf-8?B?ZVF0aDhHY3VLYkZhaUNFaFo4MytZVmNuWVllaXlhQVBLS1lPeEgrNm01UEpz?=
 =?utf-8?B?KzhNenVIUTBsMGZiU3JrOFBJYTgxMHJYUXpQeGlCMS91TlFaSmxMWkNFQmtE?=
 =?utf-8?B?VnJtQkFYUVdCN3pZS0ZWNm5xeVpDalgrdDBFNGd2NVJFcHE1Sy9ndkNVR2kx?=
 =?utf-8?B?NVFieGN6MXVQYkM3cmhZeXpveFB1V2RUQmhBNHQ4Q2lQcnFaZExWUUJza3NM?=
 =?utf-8?B?K2hCdnY3ejR6T0dMU21tTHd1TmJBPT0=?=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6601d851-7754-4d74-322c-08ddd0f88205
X-MS-Exchange-CrossTenant-AuthSource: PA3PPF4C106CF41.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 12:39:50.9589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o2FBhg0jhWOmvnbyvt3ryTtcYZr2GTuB1lgp3WWBptxowYjNZTBDg3DVnULQ8vH1tvAVRDEEt7XSUSTbhzu3UlkFpCCXo0hYjzCPS/lZbBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1870

Le 26/06/2025 =C3=A0 21:16, Moon Hee Lee a =C3=A9crit :

[...]

> Replace the timer-based check with a read from
> /sys/power/suspend_stats/success. This counter is incremented only
> after a full suspend/resume cycle, providing a reliable and race-free
> indicator.
>
> Also remove the unused file descriptor for /sys/power/state, which
> remained after switching to a system() call to trigger suspend [1].
>
> [1]https://lore.kernel.org/all/20240930224025.2858767-1-yifei.l.liu@oracl=
e.com/
>
> Fixes: c66be905cda2 ("selftests: breakpoints: use remaining time to check=
 if suspend succeed")
> Signed-off-by: Moon Hee Lee<moonhee.lee.ca@gmail.com>
> ---
>   .../breakpoints/step_after_suspend_test.c     | 41 ++++++++++++++-----
>   1 file changed, 31 insertions(+), 10 deletions(-)

[...]

>   void suspend(void)
>   {
> -     int power_state_fd;
>       int timerfd;
>       int err;
> +     int count_before;
> +     int count_after;
>       struct itimerspec spec =3D {};
>
>       if (getuid() !=3D 0)
>               ksft_exit_skip("Please run the test as root - Exiting.\n");
>
> -     power_state_fd =3D open("/sys/power/state", O_RDWR);
> -     if (power_state_fd < 0)
> -             ksft_exit_fail_msg(
> -                     "open(\"/sys/power/state\") failed %s)\n",
> -                     strerror(errno));
> -
>       timerfd =3D timerfd_create(CLOCK_BOOTTIME_ALARM, 0);
>       if (timerfd < 0)
>               ksft_exit_fail_msg("timerfd_create() failed\n");
> @@ -152,14 +172,15 @@ void suspend(void)
>       if (err < 0)
>               ksft_exit_fail_msg("timerfd_settime() failed\n");
>
> +     count_before =3D get_suspend_success_count_or_fail();
> +
>       system("(echo mem > /sys/power/state) 2> /dev/null");
>
> -     timerfd_gettime(timerfd, &spec);
> -     if (spec.it_value.tv_sec !=3D 0 || spec.it_value.tv_nsec !=3D 0)

Hi,


Shouldn't you also remove the timerfd variable?
It seems to be of no functional use after this change.
-- This message and any attachments herein are, unless otherwise stated, co=
nfidential, intended solely for the addressees and are SoftAtHome=E2=80=99s=
 ownership. Any unauthorized use, reproduction or dissemination is prohibit=
ed unless formaly agreed beforehand by the sender. If you are not the inten=
ded addressee of this message, please immediately delete it and all its att=
achments from your computer system and notify the sender. SoftAtHome reserv=
es the right to monitor all email communications through its networks. Any =
views or opinions presented are solely those of its author and do not neces=
sarily represent those of SoftAtHome. The internet cannot guarantee the int=
egrity of this message. SoftAtHome not shall be liable for the message if a=
ltered, changed or falsified. While we take all reasonable precautions to e=
nsure that viruses are not transmitted via emails, we recommend that you ta=
ke your own measures to prevent viruses from entering your computer system.=
 SoftAtHome is a French Soci=C3=A9t=C3=A9 Anonyme with a Board of Directors=
, having a capital of 6 450 699 Euros having its registered office located =
at 9-11 rue du d=C3=A9barcad=C3=A8re =E2=80=93 92700 =E2=80=93 Colombes =E2=
=80=93 France =E2=80=93 Tel + 33 (0)1 57 66 88 88 =E2=80=93 Fax + 33 (0)1 5=
7 66 88 89 - RCS Nanterre B 500 440 813 =E2=80=93 Intra-Community VAT: FR 0=
4500440813 -- Ce message et toutes les pi=C3=A8ces jointes qui y sont inclu=
ses sont, sauf indication contraire, confidentiels, destin=C3=A9s uniquemen=
t aux destinataires et sont la propri=C3=A9t=C3=A9 de SoftAtHome. Toute uti=
lisation non autoris=C3=A9e, reproduction ou diffusion est interdite, sauf =
accord formel pr=C3=A9alable de l'exp=C3=A9diteur. Si vous n'=C3=AAtes pas =
le destinataire pr=C3=A9vu de ce message, veuillez le supprimer imm=C3=A9di=
atement ainsi que toutes ses pi=C3=A8ces jointes de votre syst=C3=A8me info=
rmatique et en informer l'exp=C3=A9diteur. SoftAtHome se r=C3=A9serve le dr=
oit de surveiller toutes les communications par e-mail via ses r=C3=A9seaux=
. Les opinions exprim=C3=A9es dans ce message sont celles de leur auteur et=
 ne repr=C3=A9sentent pas n=C3=A9cessairement celles de SoftAtHome. L=E2=80=
=99Internet ne permettant pas d=E2=80=99assurer l=E2=80=99int=C3=A9grit=C3=
=A9 de ce message, SoftAtHome d=C3=A9cline toute responsabilit=C3=A9 =C3=A0=
 ce titre, dans l=E2=80=99hypoth=C3=A8se o=C3=B9 il aurait =C3=A9t=C3=A9 al=
t=C3=A9r=C3=A9, d=C3=A9form=C3=A9 ou falsifi=C3=A9. Par ailleurs et malgr=
=C3=A9 toutes les pr=C3=A9cautions prises pour =C3=A9viter la pr=C3=A9sence=
 de virus dans nos envois, nous vous recommandons de prendre, de votre c=C3=
=B4t=C3=A9, les mesures permettant d'assurer la non-introduction de virus d=
ans votre syst=C3=A8me informatique. SoftAtHome est une Soci=C3=A9t=C3=A9 A=
nonyme fran=C3=A7aise =C3=A0 Conseil d=E2=80=99Administration ayant un capi=
tal de 6 450 699 euros, dont le si=C3=A8ge social est situ=C3=A9 au 9-11 ru=
e du d=C3=A9barcad=C3=A8re - 92700 - Colombes - France - Tel + 33 (0)1 57 6=
6 88 88 - Fax + 33 (0)1 57 66 88 89 RCS Nanterre B 500 440 813 - TVA intrac=
ommunautaire : FR 04500440813

