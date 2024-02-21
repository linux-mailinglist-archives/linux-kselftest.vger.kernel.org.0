Return-Path: <linux-kselftest+bounces-5156-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C6885D5F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 11:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A8861C21C71
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 10:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8E63A1CB;
	Wed, 21 Feb 2024 10:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I8pyMAlR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2070.outbound.protection.outlook.com [40.107.95.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF40381A8;
	Wed, 21 Feb 2024 10:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708512318; cv=fail; b=rX8+CHP1v5K0+lnSzporZL4lV8rSaOFXSeC7vZ1GTn6Y6Si68FF57dsldJUpMgtHDiP6gIQOomp1DoJOk7UvweOHhVt9Zw1vKAvmoN1xVRwdoWK9b5nkV+dlwm42CRI+/gI/FuRINpMYwaWHkWJ+E32QP0OM3iyz0sSFKuWymfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708512318; c=relaxed/simple;
	bh=Qgx2pkfCAGE9qrdCEIExV6dWOStupx4KTxBmJl2cQN4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CJd68pWO8Y6wigerD6e53fmm6etxzgqNGz33TlDqqQhR0pcV7drkccIayFD7m0NDWuuY62hxyPZ6f9vo5bSGSBMGjoe6l+F7F+NFt4/8Nu6sSuTq20NRWzbyIpl97qUa08zu7iV7a6FsL3STx5rD1mD2Krz0eayifg6xpQnxNK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I8pyMAlR; arc=fail smtp.client-ip=40.107.95.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXTOBG4SOlzWTAx0cvbN8SvBgRet3Nfp03tcHib9dGKoDCh59iBvOFVqgCQoxMNr6IDWjk3/uaMbUWnLzqvPc0D/fM2cYyLWtSbJoSyB9snYwReHUrNoBcxBGb4vXg/KhYECJcwBP9TVrJPKIzIztTVmlVT1R1oq0rK46CFR0V8GNd9ozZ+1kOHTwwE5lZI9K/m94C1vTydCXDG3QLc4TxD2qHD9i4pXVxwU2S2p17lX12ozsXTGpXTdCzhgF88DIqY6tEbyaCBY4VWQqAa7yVoJffEBNPhfF/AUdPY1ZVAm56P45k4YWTVXFZzKuAF9EGTH7bVCAvg1UvgExkXV9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECEiAhgJe4uEd3KUV8RzIDtJSySEvaPuh0AYo5xLhS0=;
 b=aQeAYRrPMf+LLnsor1hFZ0u87bPh7h8QXUjOU/ZOqBAo+BF+0a4vCwFsOjRfEtqN84D+am8jwYhxwU06ZcqwnJK+CHFqQprWZOnCJKwNmbtOeqbQhOLRKIZ1IFTicWzEdRceTPXqxciPFUh5Ms+A9xXqmzKT6w872UgvHh403tScVslrnanwS9pEta/7Chyqd6mXKZ0CfvnRTMxkgkP4Y9JSzTk8vLeWOpT1NkbXU5alhuJlC2URqbRQRWUOaJ3HeWz78xxKea9Cc7FE41AMs77t81ygESEVd1dnpW2PZpiJHXxIcfWPLzTPpqlJmO1jgZgld75aaxc8ljzayW+AUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECEiAhgJe4uEd3KUV8RzIDtJSySEvaPuh0AYo5xLhS0=;
 b=I8pyMAlR7ZEEP0yCTqhrnCK8jpWUCFVMifEiECVxj6FSbdZDhL/vIikdCXefUeMYCF8TdsdBEMcNFW4IIRel1VvjTwYM2jSFo8yZ/9BdsZlZkRshn/PLYJhVbvhzJShmy8+qDduHd+z3L/h3wjnKuOxsaNt3tiZetVaTqHQ2dRI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4583.namprd12.prod.outlook.com (2603:10b6:208:26e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 10:45:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 10:45:13 +0000
Message-ID: <65fc62ec-269a-4225-9252-127531179bb0@amd.com>
Date: Wed, 21 Feb 2024 11:45:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] drm: tests: Fix invalid printf format specifiers in
 KUnit tests
Content-Language: en-US
To: David Gow <davidgow@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>,
 Rae Moar <rmoar@google.com>, Matthew Auld <matthew.auld@intel.com>,
 Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 Kees Cook <keescook@chromium.org>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Willem de Bruijn <willemb@google.com>, Florian Westphal <fw@strlen.de>,
 Cassio Neri <cassio.neri@gmail.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Arthur Grillo <arthur.grillo@usp.br>
Cc: Brendan Higgins <brendan.higgins@linux.dev>,
 Daniel Latypov <dlatypov@google.com>, Stephen Boyd <sboyd@kernel.org>,
 David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
 linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-hardening@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240221092728.1281499-1-davidgow@google.com>
 <20240221092728.1281499-8-davidgow@google.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240221092728.1281499-8-davidgow@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4583:EE_
X-MS-Office365-Filtering-Correlation-Id: b8132ef7-3e94-4e72-cb29-08dc32ca2ee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZV4h/p1sF7zUqURY+Tg+nYZLQ5MKTbiKGPZzrvnZb9J0fO3pc8rOFtUk+gF6YdBltFeCOwmXieYjLJxkcRjsDi7erMRi5802TcOOTHBEDQVetrJxecNFq/p3i/Uoaczc9FD5UuXvQ6EA2Fz4X8U+qtjD/p7jvMFZdCu+mbLr8qN09JRXXnsLt3peGCJeGEq16uzblkw1jiK8vzePMCzY7DaB2dRfNVgNFzeH3PfMdS1ROpiME7avSO4FNYTo7OWxCRYC/2refA0R2OnH6Awt8ax5SH2WbR1oBctDOGHOiT4HBXkaozs/ybIxXK4x4m3kxp52Gtpsc8au9wI3X03f3d22Doo8C57s91LpGBZO1vDeEbuYckcTjwyC2XO6b4VBdx/BOdji9+j1ybcXbx/5CIZwrz0dczwKGQ2t5LYHGWX0ArLeee67bZ2vnIHEWVgKFYM33cGskkm4hrv071MOdkwv42gD7m9Ouf6e9YSXKQuZctQjBfkF/QghNMPcjPiSwVg7qtkiSCik5BMVpPVuw1VjrBZb6MGAsfwHLiJgKf2cHPBNs1VMXakiwf/R1jtFn1/+lja9UXziPdbQiVtyIm8ppzbIEGR3xB0lMRHtyUo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V01Day9PSmIzbW9JdmNtclZHMVhwcnBPQWJ5aTdjeFlLZUVRU21ZYWtmTkpZ?=
 =?utf-8?B?dk8zcW1XVWRqNmVldVBuamFucjNyUjg4emt0SVhhSzBXZEp4QUthQTQvYUwr?=
 =?utf-8?B?cDlQUVJPdHVWRDlFVEpEd29Vb3l0MVYwd0RWTnhWWDEvY3V1OVBuMkQ0bWRp?=
 =?utf-8?B?SHhQWWtiTk5uRk5kSUNDSzVhem96VkFkT2JnYlA1SUgrMGlCQWN6bHFZanZ0?=
 =?utf-8?B?R0Z6MGxsTk5xUXpZMHNmUFhhTXJhTzM4VE9zSHVJaGlKZ1dDamx3OXJNYk5v?=
 =?utf-8?B?Q2UrV3ZtaFRJbzV2N0tlVG1PQXVydE9kdWowb3o4Q3pGQ21lY1dPM0hidU5l?=
 =?utf-8?B?TThKcEZwSHE3Um5TVkZQYk5QR0MzaTFoRDVJWXNLQkhFT2d6S0xHOFFEUXhH?=
 =?utf-8?B?WXk5ZGY5amFNaVM4c1VlcnV2REFIU1dsdlRKVEdjcysvRWRRNkVKK25RcFdU?=
 =?utf-8?B?VXpjeEt1dU5HZkYzV2JVUWx4dFhIajMwTVhvSEdPUGlQdnNEemE1elVQWUFt?=
 =?utf-8?B?S0QzWUJ3UXppWEpQd1duWTdtMEhiUWgya3djTld2ZW5BSGNIVDUvYkQyS28y?=
 =?utf-8?B?SENuS3hiRGtaWnJ4cHBnM3QxR0VBb3FzbWxiVlJrS0hQOVFOSGMxOGYyeTNr?=
 =?utf-8?B?MjcyOWtNMUk4ODBRakZwWVFBQW9oc1ZtMGd5QmRpRTRrbHhvaWtUa0xOY0dv?=
 =?utf-8?B?dlZkTDd2MTFBYTJsdDZQT2o3U3daZFF1UmhKZlJyMHZaMTMzNXBYclh5dXJt?=
 =?utf-8?B?byt4Zlp1cmR3bkhHeXBudkdLdXFLRjJMVjA4T3FxUzFXT1NzTWdMWmRRMWM2?=
 =?utf-8?B?MlRZeEhrUTN0aVlrWHcybWZkRmdDaDRvd2xvMTRlWGtYc0E0QjlDRFMyVE1Y?=
 =?utf-8?B?ZktIMWRCUjVqcDVYTVkrS1UrRGwrOVZkMEttVmZ2bDhOZC9LS1pwdjd3Q0t3?=
 =?utf-8?B?dEREMUpPaGdrbFV6c2ZsN09xQVJiQnpWWHpoVE5TN0VQMmplMHBNV09UZHZi?=
 =?utf-8?B?K1BvWlh1WndxWCtBMGVRbVlOVEx2ejlRclRwcXB3WS9mNXhYK1pHM0Y3SGN4?=
 =?utf-8?B?REpUeFpYL2tqYmtFSVp2dlF5L3JMbU5PVmtQdkR5WGZZaWhMa0NtTFowS054?=
 =?utf-8?B?Z1d0NUwrRG51dVA0eVM1Wm5WcExLMlM3WWJTNjZHdEN3QmtYbEpxQS9yMXBM?=
 =?utf-8?B?ZEdYVHRXbVp3ZkpXSEdCU3ZJMER3VnBOTnM3Z3JDeW4rT25YTU9UTG8ydkZU?=
 =?utf-8?B?azdGVlZxNHQ5VjVWaW5LS0ZrSWhMNGx3QnhHb0ZnL2J5bmx3NFNqRzQwSThh?=
 =?utf-8?B?cFpoQjNSYzFaclRFQWhTSmtYbWRxQzZxbUxhZmFwQnNoTk5tajNUVjdiYTda?=
 =?utf-8?B?eWVkZG9xeDBkd2RXa3B5cEpMQ3dmTFZzdnRINTBNTEpneVJBalhlbVNmZSti?=
 =?utf-8?B?NVN1cVcwWHU1MnhDWDZHa1llV25lcnRSMmM1MER5Z3NNZTVlYWRMV2V2YUQ5?=
 =?utf-8?B?ajluUGx5N1VLcElhWkFRYUtZZjIyYWhxZ3MxZTVxdktIZ0lWNlJYVGdxQUda?=
 =?utf-8?B?VEJKejVTNTFBdVJaeHhQdnhlUFJRQk5LcFVnZDlkMFNsZG9zOTRTVjhsdUxJ?=
 =?utf-8?B?YTgzaC9CM21QaHRvb0JmNEJPbm15SHdiUGZkQ25zbUFyTityQ1RSdTd5VXZR?=
 =?utf-8?B?dlk3WUxFMzhrVG8yTWx3M01OTlVQaXl3TTdlUG90Nml1L2pnRVAwQklpUEkz?=
 =?utf-8?B?OG05OEdCUUQvSzVCQWE3UzlJSTM5d1gyODVueXhkb0hIekk4cEk2MC95QjNq?=
 =?utf-8?B?Yi9XN281ZFJiZ05NT2JPUlFoK3FkM09NdXN6SWJEQzhiRVhPYjZXS05TRkxk?=
 =?utf-8?B?Q09sMEQzaDhtRWxOYk5DcTR2YmZFUmFvanVtZU5JYWpqdkdyak9wejNHWllQ?=
 =?utf-8?B?NlYxNXdhUURHaDZJdmIwWG40WUFWVXpTbXRzUHdSeFB5UTJiR1RCSlc3UjRl?=
 =?utf-8?B?eVB4UEcrcnZNWHJPUWFheEFnMWczdUdHOWdNS2pJeUNRWVh1emhLaTgxOWNY?=
 =?utf-8?B?YUtSaGFZUlJKYkY2dWdvRGlqemZjT3NtcUx6d2V5SlhnWkxHK0VPQXZSVUh1?=
 =?utf-8?Q?FjrZRoxx5dhaAl5JqbsWSccvl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8132ef7-3e94-4e72-cb29-08dc32ca2ee0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 10:45:13.3431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AU9DDliXe7JpWfvgO5QVRQ6+uJKJ0c0l/ejOh1gBfG+7uPwW3b3ZLWsCrb9hbfVe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4583

Am 21.02.24 um 10:27 schrieb David Gow:
> The drm_buddy_test's alloc_contiguous test used a u64 for the page size,
> which was then updated to be an 'unsigned long' to avoid 64-bit
> multiplication division helpers.
>
> However, the variable is logged by some KUNIT_ASSERT_EQ_MSG() using the
> '%d' or '%llu' format specifiers, the former of which is always wrong,
> and the latter is no longer correct now that ps is no longer a u64. Fix
> these to all use '%lu'.
>
> Also, drm_mm_test calls KUNIT_FAIL() with an empty string as the
> message. gcc warns if a printf format string is empty (apparently), so
> give these some more detailed error messages, which should be more
> useful anyway.
>
> Fixes: a64056bb5a32 ("drm/tests/drm_buddy: add alloc_contiguous test")
> Fixes: fca7526b7d89 ("drm/tests/drm_buddy: fix build failure on 32-bit targets")
> Fixes: fc8d29e298cf ("drm: selftest: convert drm_mm selftest to KUnit")
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Christian König <christian.koenig@amd.com>

Ping me if you want this patch pushed upstream through the DRM tree.

Christian.

> ---
>   drivers/gpu/drm/tests/drm_buddy_test.c | 14 +++++++-------
>   drivers/gpu/drm/tests/drm_mm_test.c    |  6 +++---
>   2 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/tests/drm_buddy_test.c b/drivers/gpu/drm/tests/drm_buddy_test.c
> index 8a464f7f4c61..3dbfa3078449 100644
> --- a/drivers/gpu/drm/tests/drm_buddy_test.c
> +++ b/drivers/gpu/drm/tests/drm_buddy_test.c
> @@ -55,30 +55,30 @@ static void drm_test_buddy_alloc_contiguous(struct kunit *test)
>   		KUNIT_ASSERT_FALSE_MSG(test,
>   				       drm_buddy_alloc_blocks(&mm, 0, mm_size,
>   							      ps, ps, list, 0),
> -				       "buddy_alloc hit an error size=%d\n",
> +				       "buddy_alloc hit an error size=%lu\n",
>   				       ps);
>   	} while (++i < n_pages);
>   
>   	KUNIT_ASSERT_TRUE_MSG(test, drm_buddy_alloc_blocks(&mm, 0, mm_size,
>   							   3 * ps, ps, &allocated,
>   							   DRM_BUDDY_CONTIGUOUS_ALLOCATION),
> -			       "buddy_alloc didn't error size=%d\n", 3 * ps);
> +			       "buddy_alloc didn't error size=%lu\n", 3 * ps);
>   
>   	drm_buddy_free_list(&mm, &middle);
>   	KUNIT_ASSERT_TRUE_MSG(test, drm_buddy_alloc_blocks(&mm, 0, mm_size,
>   							   3 * ps, ps, &allocated,
>   							   DRM_BUDDY_CONTIGUOUS_ALLOCATION),
> -			       "buddy_alloc didn't error size=%llu\n", 3 * ps);
> +			       "buddy_alloc didn't error size=%lu\n", 3 * ps);
>   	KUNIT_ASSERT_TRUE_MSG(test, drm_buddy_alloc_blocks(&mm, 0, mm_size,
>   							   2 * ps, ps, &allocated,
>   							   DRM_BUDDY_CONTIGUOUS_ALLOCATION),
> -			       "buddy_alloc didn't error size=%llu\n", 2 * ps);
> +			       "buddy_alloc didn't error size=%lu\n", 2 * ps);
>   
>   	drm_buddy_free_list(&mm, &right);
>   	KUNIT_ASSERT_TRUE_MSG(test, drm_buddy_alloc_blocks(&mm, 0, mm_size,
>   							   3 * ps, ps, &allocated,
>   							   DRM_BUDDY_CONTIGUOUS_ALLOCATION),
> -			       "buddy_alloc didn't error size=%llu\n", 3 * ps);
> +			       "buddy_alloc didn't error size=%lu\n", 3 * ps);
>   	/*
>   	 * At this point we should have enough contiguous space for 2 blocks,
>   	 * however they are never buddies (since we freed middle and right) so
> @@ -87,13 +87,13 @@ static void drm_test_buddy_alloc_contiguous(struct kunit *test)
>   	KUNIT_ASSERT_FALSE_MSG(test, drm_buddy_alloc_blocks(&mm, 0, mm_size,
>   							    2 * ps, ps, &allocated,
>   							    DRM_BUDDY_CONTIGUOUS_ALLOCATION),
> -			       "buddy_alloc hit an error size=%d\n", 2 * ps);
> +			       "buddy_alloc hit an error size=%lu\n", 2 * ps);
>   
>   	drm_buddy_free_list(&mm, &left);
>   	KUNIT_ASSERT_FALSE_MSG(test, drm_buddy_alloc_blocks(&mm, 0, mm_size,
>   							    3 * ps, ps, &allocated,
>   							    DRM_BUDDY_CONTIGUOUS_ALLOCATION),
> -			       "buddy_alloc hit an error size=%d\n", 3 * ps);
> +			       "buddy_alloc hit an error size=%lu\n", 3 * ps);
>   
>   	total = 0;
>   	list_for_each_entry(block, &allocated, link)
> diff --git a/drivers/gpu/drm/tests/drm_mm_test.c b/drivers/gpu/drm/tests/drm_mm_test.c
> index 1eb0c304f960..f37c0d765865 100644
> --- a/drivers/gpu/drm/tests/drm_mm_test.c
> +++ b/drivers/gpu/drm/tests/drm_mm_test.c
> @@ -157,7 +157,7 @@ static void drm_test_mm_init(struct kunit *test)
>   
>   	/* After creation, it should all be one massive hole */
>   	if (!assert_one_hole(test, &mm, 0, size)) {
> -		KUNIT_FAIL(test, "");
> +		KUNIT_FAIL(test, "mm not one hole on creation");
>   		goto out;
>   	}
>   
> @@ -171,14 +171,14 @@ static void drm_test_mm_init(struct kunit *test)
>   
>   	/* After filling the range entirely, there should be no holes */
>   	if (!assert_no_holes(test, &mm)) {
> -		KUNIT_FAIL(test, "");
> +		KUNIT_FAIL(test, "mm has holes when filled");
>   		goto out;
>   	}
>   
>   	/* And then after emptying it again, the massive hole should be back */
>   	drm_mm_remove_node(&tmp);
>   	if (!assert_one_hole(test, &mm, 0, size)) {
> -		KUNIT_FAIL(test, "");
> +		KUNIT_FAIL(test, "mm does not have single hole after emptying");
>   		goto out;
>   	}
>   


