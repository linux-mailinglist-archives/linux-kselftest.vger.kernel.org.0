Return-Path: <linux-kselftest+bounces-30219-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE67EA7D50E
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 09:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F053B1480
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 07:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44BB227E97;
	Mon,  7 Apr 2025 07:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="mCe9e4bn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011016.outbound.protection.outlook.com [52.101.129.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5543D226D1D;
	Mon,  7 Apr 2025 07:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744009775; cv=fail; b=lngFuz10d2vPc92jze2XBqsCKUvT76q5/HeFeuDutGJn3aCggEewCeY0sq2o3RcP109py3p3NpwY9pg4dvxjQLkwN8pPsDfnJWiXAA5yAgwTlcH+OxN76I8GT6NOffQAn1MnmnY86gVTYg/6Dm65Hxsra1BVeC0yQctFC+b3s3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744009775; c=relaxed/simple;
	bh=mV65HbmWubJhSxwnu2K8LQtNG+WbeJM5PLToRwLNlUM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DQUXAPuFb1L6uu+c7QbxZgEpMt5vzAlt/mDPhys8bmqLU4OwiaPVWrexCPhdwVFYzGWp9ygEybfS6RWcR9oS7BN2MtX+hHiXJIUrNFry6Wb8r3L3DGJC/bda48m59qexUGIL/t/ydhicWtJAke6Ff8ezCNxLDbYY7rVzAs8SWWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=mCe9e4bn; arc=fail smtp.client-ip=52.101.129.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4CqZMl4wUzfXPoDbm9VzCC+KN9DvpM6x/0Tnhwx7yvR/AhnW7yS3XQVYzFn9fAaehw1xbvFDsNKSqmUqnRX//yAGA0Lx7RJ/owblxXLJ9vtCm0jWasQemAL8iI2ip4iDkpqMMT9Q6A+anZdfuWu6NZipDlbZkaJTpc7Pnw9GIYur3mdx6wno7yuhq5+5rAlOECLYzI+t4H7zXJxv9ORo1mzl0WDZBSjSFElGBCbH/OM5FsrWERAr4chsqBU27vXwxpij50GxIrWHmtwnhN5Fa3KU3+P5SKcHrqVFGODV1aqqTPbYzZui/WwOYLgYfFababyI8mRsq68Nhasj1Huag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzellQTPpv0iXdujIdL0gzBn9Iws+Oa76U/6nYoHqcU=;
 b=MrsXQr9ZODTxDYfY9QPL5Nkax9L4e/EerrlFV1ohg1DQYFvmYU/LRKbrhGTPSnc3hedGyeEtC0Vkp/RnfQe4stjgdb54iw1BmeNnqnDv5Z8dmDDnwMIc+i5edNKhQRfP0JrI+dtu6cTXZNwDICBBuxAL0O1KVu5CplI8x13Ny0S0mOOaTSf3mryV+CxlIGhIGYeLwomZ+VmByokeF+4FOJ7bQMSlZ62cqqgn4LFNu2j5wNTC6/Nj48HmUZh6KSMxXz0Tu88Zpx7Uh+Bj28Tjx0Xnu8kVinVxrmzA8XHJpM3cc7gxwd0XQP0bI3tOCfKGsBSSSrFce4/W/JPknwAnxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzellQTPpv0iXdujIdL0gzBn9Iws+Oa76U/6nYoHqcU=;
 b=mCe9e4bn7azJXHTFC3djzTMZYjXAAWqhKAzK62qnZYM69Kk8+0m4wCZmYIJfQRbaarIkZBWKEOAKgu8ju1oda6+7IxffTkjLnzmiypICbwS2a4CFpakUsu+DqMJxpRWzhsTlcIMplQ8TyeR4RBLHj36EO2NxIO0/r7GXZw3mq+aDoNDdOVtXOxxSoc6yqhMQGIKsdspvTJ76ESyd2dxwDVdlJ/3v4OespaQwnInFk/mMPXzxytY0RovjPG6ckfs9MP3ernLWCZNUcvv2NZKKo9HFoV0bajpEGLdezlyVd755p9LDe5DgrZH0pGVpIlC+Y5DZH+CZ7qOR+ZJsXsozsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by OSQPR06MB7250.apcprd06.prod.outlook.com (2603:1096:604:2a1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Mon, 7 Apr
 2025 07:09:29 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%4]) with mapi id 15.20.8583.043; Mon, 7 Apr 2025
 07:09:28 +0000
Message-ID: <55306631-8421-455a-9d03-709ebee97d76@vivo.com>
Date: Mon, 7 Apr 2025 15:09:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP is broken, was Re: [RFC
 PATCH 0/6] Deep talk about folio vmap
To: Muchun Song <muchun.song@linux.dev>
Cc: bingbu.cao@linux.intel.com, Christoph Hellwig <hch@lst.de>,
 Matthew Wilcox <willy@infradead.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 opensource.kernel@vivo.com
References: <20250327092922.536-1-link@vivo.com>
 <20250404090111.GB11105@lst.de>
 <9A899641-BDED-4773-B349-56AF1DD58B21@linux.dev>
 <43DD699A-5C5D-429B-A2B5-61FBEAE2E252@linux.dev>
 <e9f44d16-fd9a-4d82-b40e-c173d068676a@vivo.com>
 <E4D6E02F-BC82-4630-8CB8-CD1A0163ABCF@linux.dev>
 <6f76a497-248b-4f92-9448-755006c732c8@vivo.com>
 <FDB7F930-8537-4B79-BAA6-AA782B39943A@linux.dev>
 <35D26C00-952F-481C-8345-E339F0ED770B@linux.dev>
From: Huan Yang <link@vivo.com>
In-Reply-To: <35D26C00-952F-481C-8345-E339F0ED770B@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYBP286CA0033.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::21) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|OSQPR06MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: b9784c8b-7857-40bd-6ac0-08dd75a3231b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXhITEcxR09nbjdka2djU2h0OEFlbzE0eTJBT1A0ZWdCTjlqbXRET3hTeFQ2?=
 =?utf-8?B?TjAxLzhvQ3Y3QXFVdGg2ZW9tZ25mUmUvY2F2R1NRM1ViNUpvRk1neDNZcUlV?=
 =?utf-8?B?YzJMVXA1SmxXSlYweWI2YTdHeVJCendXT0g0Z3dsMzJjdEoweFpxR3FBTEVl?=
 =?utf-8?B?ekNLQmkvOGdtYmdFdXJPeTNxMnpGY28vZVJpeW9jNDNFR21DdmhXb0wvQXZq?=
 =?utf-8?B?Ujc1OVcyR3FvdDBxRndkSmhqVWN1QitRUkxYK0phVmoxbS9sRDdHZWxnOTBR?=
 =?utf-8?B?TWhXY3g0bUNtUFlKNkJYTWNxOFZqTXJiTGxCRWE4TktnMnJKRUdlcmlqczJD?=
 =?utf-8?B?YXdVTzNzL053YXRsWVI4cFFWSUlxQTBxT1NKcGlqSXNRZ0JEdjhVb291dUd6?=
 =?utf-8?B?MENHclM0ZS9lUkVXMDJtVWt0VDB1S2Vqckp4UmtRaHdUTVpISjZsV1JmYTVW?=
 =?utf-8?B?RFBHMnFNOW9XUmptZS9pQXY0T0JGMXduZk44QVFiRXVTMjZybm4zUEVGeUVV?=
 =?utf-8?B?VFlTaEpFOXRCdGlUUGJqQUdSTmVoVXN2R1dKUkpxb3NCOCtwY2FjNXFranV1?=
 =?utf-8?B?YmtHYllIWHczSHZESDVBRG1tWlRnRnBqQ1N6Qk01clB3cG4wSFNjL2svbU80?=
 =?utf-8?B?UEk1aSsyQ0RnNC9jaHdpV0JieU1CelZic3JxNEdyUlQ4N25jdFE4bCtJOTUv?=
 =?utf-8?B?b1dqdDRjVU9NZ0dxNGtkZWgxTmtSMDY5NG1mTXFYVnBURVZlUWprK0RZdG9Q?=
 =?utf-8?B?aE8rcVg2bUQ4NXN3Rys0UzlsdmdWdnZtWGpXTXRCck1QMHFIUzFsUGxuOGhL?=
 =?utf-8?B?cFFOa0VoVnhlQlZzczFaejRFU081THBKclJ1aVY1dXFUQXIyZ1hRR25oT2px?=
 =?utf-8?B?bndNdUJWMFRqYlNkVGJnOHp0TmpwUDJrMDEycjlyK1BjSVlieU10d3ZVVmJa?=
 =?utf-8?B?N1dVUE1qQlY5bmJPMVU2eGhJSkdNaXRMdWRmVkZxVlo4emJKYkxPL3ZZTUVz?=
 =?utf-8?B?bzFxdkZubHVWVkZnQlQ4Y1VPNFJDa21Qdkg4Zjlnb1JBN1h3VnZsNit5U0oy?=
 =?utf-8?B?cTRGa0N6elJWLzVFTncwRUVJWFV6OGZaU0lKVy9iWi9UZXFWVTZrSDB0amFP?=
 =?utf-8?B?N2FXblBRRVp0L2hTbzAvSkxuUW9KbUx2cGl3VmhkaVBNVG5odjQycDZCZmNU?=
 =?utf-8?B?YjIvL1NvSXpzcFBXZHF2V3pDN211cTBLbVNmcWdPYlloVXJnZTFKM1JqVk5v?=
 =?utf-8?B?M1M4ZW9KN0s2a2VZZTZFWU85ZkNUR0NHZFhsdmRoM05QeGdPOFZUWDQ5N09Y?=
 =?utf-8?B?ZTlYaS90UWlMc01ETWhaM1BpSHI2TWluWjZsR2pGOFkzdm1XNVowVXZPQ3N5?=
 =?utf-8?B?a0ZBUE4zR2FGNmxkWTZqMGwzS3NhZWtReGdzWUNMSU9LNFU4SHRXdEhMZ00v?=
 =?utf-8?B?eW9GQ1pocWlWK0FNSUpSUXNYMUN4KzZpZzJYZnJ6eU1uWDg3L1FkQUo2OWtN?=
 =?utf-8?B?SGFVbnhKZkxmZlVOMWZnVEVzK3ZSRHd2VWdpblJqaTAzRkd5clo5aDUyYVBE?=
 =?utf-8?B?SFJONURsSnZiTFlMcmRFQ3JSRFpuZ25LWWgzczZ2VWkzNzV4Q3hvc1BFcGdN?=
 =?utf-8?B?NjhsR2tDRStRMTYweVpDNUlOVWJLRHJmZmN5Q1VLR3FKU3RBVkZWMkJhL2l6?=
 =?utf-8?B?QnNBc2ZOVmNpUmVhTWZ6NG9sQ1I5bjVnZXF0a09FUTRyWXZuTk0zckFKMVVO?=
 =?utf-8?B?MXJOeENWUXZiNUJkVTRQcWlPVmpGOFU2dzVQczFhbjBLVmxBNGhpM0xNUHY2?=
 =?utf-8?B?Um9BazRGMC9iTkZCanBqdTZ6YkRHWFAxQnNQM1lmL1F1K09mWlNSYU5VZm11?=
 =?utf-8?B?ZDFYclNmT0JRRHJGVDhCM1FpZ0M2cWdqcTlBSEVOM0ExUENZYm1uV0F2VW9G?=
 =?utf-8?Q?hg6cnnMZ5un1CVSbITFLdrQH2VOd5XoR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjVnVjZpTDJEWjRLVjJnOGRiUTNZeVc0QlZuVGJHVVRaQTVTY1BUYXdrVVBh?=
 =?utf-8?B?QVpBYVdmOHJIRnhMdktCdGhHcTBoTlBoK1lnQS8rTTVURlR6OWpyUGdtWGxQ?=
 =?utf-8?B?WmRVNmRpMHpVdVhOMGlQYVE0bWl2M2tCWjBqTXgyenpRZDRUQmVRYlFXS2N3?=
 =?utf-8?B?bGtsRm5rVkEwc3l1Yi9YM2RWN3BWNExpOWtsUGw1Ylk1bWhxVEo1ZEF4REZK?=
 =?utf-8?B?U2tBRkFoeVJoUDZKbVoraSszZTFlTktFMEY2N2hUeDlydkh0V0JQWjJWeU9o?=
 =?utf-8?B?dlp3QUczVmRTcDZ2aEZMN0dSR0JXbEpEOFhOenpTdXpGZDFlTkN3Y2RsSU5s?=
 =?utf-8?B?YU9tMDhPbmVUc0ltQ2ZSdE52TjU5VUVyQVhHbHZDNnRQU2ZmSCtoRGRjaWVu?=
 =?utf-8?B?SDRBTE1aNGY0dDgyY2ZTTDhmNXcyZ0FpMUZwTkJ6N3lqd2oxOEZLdURyRVNJ?=
 =?utf-8?B?dThNNkZNcUtBK2RvdytkTXFzQ0dna1VXWnpWQTZ0SlArK3R6Ulp4NUZJNDhZ?=
 =?utf-8?B?ZGNNTERmdXlFR2VKY2VTR0txd2VaMG9kbEVBSkFTNFZrdTdPeHVBejc2T1JF?=
 =?utf-8?B?eWtPNTNkbzlESnA4R2E0M0xFK3ZtSlJIU0Nja0ZCdjJadmJLalJxZW5CcnFn?=
 =?utf-8?B?R3lOOXhRTmFyeTh4N05ROHMwTGNjQWVRUTE4TEVlZjBMZ3QwdC9XV20zb25C?=
 =?utf-8?B?Qi9GYkRjbC9iNlg1L1h5dUF6YTVIR1lHdVlKRFNRWHdpek9Md2swTTFJUnAx?=
 =?utf-8?B?YnkwYVBRZkxuRWxHdFAyRUkwMjlYMGRYdzNIM05NNU9TbkRWS3RzVjlJWDhX?=
 =?utf-8?B?M1hiZTRVU0J3QmIwMzFTajNCWEd4V3hCelZnbC9PRGM3ZC9NT3NHTFlDQWVo?=
 =?utf-8?B?eW5pRVFvU3VMV2FxUUM1WnIxbTRPcG1JeUlmeTdITEVoMW9HdjBMcm5CVFE4?=
 =?utf-8?B?S01VbWU4eDVCSjNQeFVUWkNrWjhVTEZIVURQUmw4azJhd21RUVFPVTlkN3Jj?=
 =?utf-8?B?Q21jQmVLYlBrTDRjRGpvS0pZcHNLRk9ZNE9DUlM5d09NNEpjc0xqZzY4ZW1v?=
 =?utf-8?B?VFpzT0JYamRoKzZ0dm5GcExTTkxhaGIzajZzWmZqc2h1U21rZkJkSFMvNHRv?=
 =?utf-8?B?eWhiZ1FKMU5uQWdDYWIxWGd1dnJXQ0Znc1JITjAzZ0h4a0FZbGdxdlVYOFFW?=
 =?utf-8?B?Z2ZBRW5KK2EzaGx0cEJaS0JvYU9IU0o3azB2VFBVcWJOMlVkQjRoT3NqajVQ?=
 =?utf-8?B?R0NHTjQwWDBQNzkzK2wyc25nYzB2d3l0QStLLzdYaU5Wb00wa09sM1d5TGdn?=
 =?utf-8?B?dXlTZVRWUGRQNlhBZDlJZFp3K1NIVWNpTzhuZmk0V3RUSnh0WmVEdTZ0cjZW?=
 =?utf-8?B?OFdKbnY4RkI0NzFobnNmRnZER0FUNHdldmt5Y0hLSG9IYWhtN0Vaajl5a2Iw?=
 =?utf-8?B?aStxaUdXYWpqU2pPa1dQeWJyODZjdlZnUXI3ZDdUcm5DYmJ1aGh5YTZ3ZGNz?=
 =?utf-8?B?YUNjMGNkNzU1T3FMTUFrSXBKanF2eWJ0TkcxaVJkc1ZJcE1WaHMvem5Ka25I?=
 =?utf-8?B?N1VCV25aV2xpWEtuYnMvV3IvbjFkdWtTNVN5dkNiV0dPcXhnODRzelNwMk0v?=
 =?utf-8?B?dWJzaFc5bElWR28yQmhpQ0FQc3ZmNFVtQ2xpTnE3UFBiUFdCaWxuR0FEVlNm?=
 =?utf-8?B?cXF5NnNvM1BRVUM0Mldwc1ZKcUxRQTlRV1lmWlJzeEVOUW5IUmVsaGVRbGVr?=
 =?utf-8?B?YU5TcFA1MFo1N05pZGFWMUlUNVBUbkUyM2QxSGFSR3Q2Qk0ySTBMa3M5Z01G?=
 =?utf-8?B?ZnpPUGFWWmY2SGVrNnk1aFBwdUlUOEk1aWs0ak5UZUMwdlhMb21NTG9pby9s?=
 =?utf-8?B?Mlp3NWROZnYrSDUrbHhveVFMTjFaanZ3TllyaWdXOU01bEFnTENuL0NWZjFh?=
 =?utf-8?B?ZENjWUE2UzNUZHBOMWRUcE5icURsdE9DbHlFemhKaTBVWjRRVTRtUzdCemhR?=
 =?utf-8?B?ZVJ0dzQ4dnFFaXRYUEpNY0xmTDMzVExjWDNCd1dqZmFzSWlhMXo4UzFXWFQ0?=
 =?utf-8?B?T0w4RnYwdDArRHp3TFFCTksrcVMyWFFHOVlTUnBvNWFvOUFadHFUNjR4Ykdm?=
 =?utf-8?Q?2j3MyrvML5T/o83gd27afS4Z6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9784c8b-7857-40bd-6ac0-08dd75a3231b
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 07:09:28.7473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8O8Uhw2aNa0gfVHSGNx2yPOFYTSaI+7qgliMkXAlxR9A9jiEGKfHzhMOGmeooMxS2MMBPpq3iB6kvXdRsmJ4eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7250


在 2025/4/7 14:43, Muchun Song 写道:
>
>> On Apr 7, 2025, at 11:37, Muchun Song <muchun.song@linux.dev> wrote:
>>
>>
>>
>>> On Apr 7, 2025, at 11:21, Huan Yang <link@vivo.com> wrote:
>>>
>>>
>>> 在 2025/4/7 10:57, Muchun Song 写道:
>>>>> On Apr 7, 2025, at 09:59, Huan Yang <link@vivo.com> wrote:
>>>>>
>>>>>
>>>>> 在 2025/4/4 18:07, Muchun Song 写道:
>>>>>>> On Apr 4, 2025, at 17:38, Muchun Song <muchun.song@linux.dev> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>> On Apr 4, 2025, at 17:01, Christoph Hellwig <hch@lst.de> wrote:
>>>>>>>>
>>>>>>>> After the btrfs compressed bio discussion I think the hugetlb changes that
>>>>>>>> skip the tail pages are fundamentally unsafe in the current kernel.
>>>>>>>>
>>>>>>>> That is because the bio_vec representation assumes tail pages do exist, so
>>>>>>>> as soon as you are doing direct I/O that generates a bvec starting beyond
>>>>>>>> the present head page things will blow up.  Other users of bio_vecs might
>>>>>>>> do the same, but the way the block bio_vecs are generated are very suspect
>>>>>>>> to that.  So we'll first need to sort that out and a few other things
>>>>>>>> before we can even think of enabling such a feature.
>>>>>>>>
>>>>>>> I would like to express my gratitude to Christoph for including me in the
>>>>>>> thread. I have carefully read the cover letter in [1], which indicates
>>>>>>> that an issue has arisen due to the improper use of `vmap_pfn()`. I'm
>>>>>>> wondering if we could consider using `vmap()` instead. In the HVO scenario,
>>>>>>> the tail struct pages do **exist**, but they are read-only. I've examined
>>>>>>> the code of `vmap()`, and it appears that it only reads the struct page.
>>>>>>> Therefore, it seems feasible for us to use `vmap()` (I am not a expert in
>>>>>>> udmabuf.). Right?
>>>>>> I believe my stance is correct. I've also reviewed another thread in [2].
>>>>>> Allow me to clarify and correct the viewpoints you presented. You stated:
>>>>>>   "
>>>>>>    So by HVO, it also not backed by pages, only contains folio head, each
>>>>>>    tail pfn's page struct go away.
>>>>>>   "
>>>>>> This statement is entirely inaccurate. The tail pages do not cease to exist;
>>>>>> rather, they are read-only. For your specific use-case, please use `vmap()`
>>>>>> to resolve the issue at hand. If you wish to gain a comprehensive understanding
>>>>> I see the document give a simple graph to point:
>>>>>
>>>>> +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
>>>>> |           |                                     |     0     | -------------> |     0     |
>>>>> |           | +-----------+                +-----------+
>>>>> |           |                                      |     1     | -------------> |     1     |
>>>>> |           | +-----------+                +-----------+
>>>>> |           |                                      |     2     | ----------------^ ^ ^ ^ ^ ^
>>>>> |           | +-----------+                      | | | | |
>>>>> |           |                                      |     3     | ------------------+ | | | |
>>>>> |           | +-----------+                        | | | |
>>>>> |           |                                      |     4     | --------------------+ | | |
>>>>> |    PMD    | +-----------+                          | | |
>>>>> |   level   |                                   |     5     | ----------------------+ | |
>>>>> |  mapping  | +-----------+                             | |
>>>>> |           |                                     |     6     | ------------------------+ |
>>>>> |           | +-----------+                              |
>>>>> |           |                                     |     7     | --------------------------+
>>>>> |           |                                    +-----------+
>>>>> |           |
>>>>> |           |
>>>>> |           |
>>>>> +-----------+
>>>>>
>>>>> If I understand correct, each 2-7 tail's page struct is freed, so if I just need map page 2-7, can we use vmap do
>>>>>
>>>>> something correctly?
>>>> The answer is you can. It is essential to distinguish between virtual
>>> Thanks for your reply, but I still can't understand it. For example, I need vmap a hugetlb HVO folio's
>>>
>>> 2-7 page:
>>>
>>> struct page **pages = kvmalloc(sizeof(*pages), 6, GFP_KENREL);
>>>
>>> for (i = 2; i < 8; ++i)
>>>
>>>     pages[i] = folio_page(folio, i);    //set 2-7 range page into pages,
>>>
>>> void *vaddr = vmap(pages, 6, 0, PAGE_KERNEL);
>>>
>>> For no HVO pages, this can work. If HVO enabled, do "pages[i] = folio_page(folio, i);" just
>>>
>>> got the head page? and how vmap can correctly map each page?
>> Why do you think folio_page(folio, i) (i ≠ 0) returns the head page?
>> Is it speculation or tested? Please base it on the actual situation
>> instead of indulging in wild thoughts.
> By the way, in case you truly struggle to comprehend the fundamental
> aspects of HVO, I would like to summarize for you the user-visible
> behaviors in comparison to the situation where HVO is disabled.
>
> HVO Status		Tail Page Structures	Head Page Structures
> Enabled			Read-Only (RO)		Read-Write (RW)
> Disabled		Read-Write (RW)		Read-Write (RW)
>
> The sole distinction between the two scenarios lies in whether the
> tail page structures are allowed to be written or not. Please refrain
> from getting bogged down in the details of the implementation of HVO.

Thanks, I do a test, an figure out that I'm totally misunderstand it.

Even if HVO enabled, tail page struct freed and point to head, linear mapping still exist, so that any page_to_pfn,

page_to_virt(also folio's version), if start from head page can compute each need page like folio_page, can still work:

hvo head 0xfffff9de849d0000, pfn=0x127400, wish offset_pfn 0x1275f1, idx 497 is 0xfffff9de849d7c40, pfn=0x1275f1.

When vmap, we no need to touch actually page's content, just turn to pfn, so, work well.

BTW, even if we need to touch actually input page struct, it point to head page, I guess will effect nothing.

If anything still misunderstand, please corrent me. :)

Muchun, thank you for your patience,

Huan Yang

>
> Thanks,
> Muchun.
>
>> Thanks,
>> Muchun.
>>
>>> Please correct me. :)
>>>
>>> Thanks,
>>>
>>> Huan Yang
>>>
>>>> address (VA) and physical address (PA). The VAs of tail struct pages
>>>> aren't freed but remapped to the physical page mapped by the VA of the
>>>> head struct page (since contents of those tail physical pages are the
>>>> same). Thus, the freed pages are the physical pages mapped by original
>>>> tail struct pages, not their virtual addresses. Moreover, while it
>>>> is possible to read the virtual addresses of these tail struct pages,
>>>> any write operations are prohibited since it is within the realm of
>>>> acceptability that the kernel is expected to perform write operations
>>>> solely on the head struct page of a compound head and conduct read
>>>> operations only on the tail struct pages. BTW, folio infrastructure
>>>> is also based on this assumption.
>>>>
>>>> Thanks,
>>>> Muchun.
>>>>
>>>>> Or something I still misunderstand, please correct me.
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Huan Yang
>>>>>
>>>>>> of the fundamentals of HVO, I kindly suggest a thorough review of the document
>>>>>> in [3].
>>>>>>
>>>>>> [2] https://lore.kernel.org/lkml/5229b24f-1984-4225-ae03-8b952de56e3b@vivo.com/#t
>>>>>> [3] Documentation/mm/vmemmap_dedup.rst
>>>>>>
>>>>>>> [1] https://lore.kernel.org/linux-mm/20250327092922.536-1-link@vivo.com/T/#m055b34978cf882fd44d2d08d929b50292d8502b4
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Muchun.
>
>

