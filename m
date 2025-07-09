Return-Path: <linux-kselftest+bounces-36845-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B187CAFEF76
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 19:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DA2D189DA79
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 17:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A093A223311;
	Wed,  9 Jul 2025 17:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EbHeBavl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CAB21D59F;
	Wed,  9 Jul 2025 17:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752081024; cv=fail; b=p163C1EsY+q8cYr3maUmf3o9WZ/94NlEILOeXb8X8FCHw4KhVpEZW9RB+sJ8WR0tAkfJvtwxCgnNTGwq40Zud0zVSKnAsMr5MKopriheuYREYZuy+Lcesstj94S6jm5IjLvpSNbDui561eloaRIZ+200z5AY8/6+5NVJH3H09m8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752081024; c=relaxed/simple;
	bh=ihPu/BYqKr6OSlP/rst8w8QYNgfpgBK2HXQov21G4NA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m1g8kZumutlvyynS5uKsksFdTGICyFnIoFDWYm8SlNY02oo/BwCCMXDjCocYz5uxbia4DDdwf+IaMoQX7x03Dd9wAD5ftdfa7sIMf2HSrQFP80Cxu+NpS6m8/NMsN3Jwg7QfaasWRDTomwQRNsY7/xD+fzH4uh5n/NSM5a2Ixqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EbHeBavl; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltrVf9tbJQW9O4bfRLl3A/jrGchucYNYs7MD5Txwl8CHYD4mihqzbcSa99tk08i8grr/Q2T/me20I61uXlCIluXgqsfgWWKoIQzT107V/kih0uqPX+jdggnnYvr687JrdxYuBEQaIPlV22/mRMHvrgNDQGkevffs3qQluyAAHuuoHn0CVx4v8+U72lHPfujblk32iDvn0TkJ0aIkQOtjMSOXobE8/XyDhRMSPp/fPbArQgLoBPtuQGtXf16QOfUEcwhxiKr4KTTVH5g+ST7WwT24ht1LPXROk2omRHTkwse5MuD8HqeWB8ihomz5V7B5xFbE3GvMcc1cVZIpQvSUgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwFyC1ZDsGm+pHvL15Xz76IskJeCUTVNc5+uPlRMo44=;
 b=D6382GYkTApC98Id/g1H/5rKNBmVa26iFIyezkhw9v3JRkUgEW3NdGunL44tASwNiHQK1BH58dKhaYtoX3NJ7en89PcUwRTXZPqztIac/qQrvRn5W5/4DUmpsyAyibFASjD8heTqP0pHEhXRU3Hg+0GdnWEXoJWm/O9oECk0nnJRWcW9RXd9SbV8F4u9H792uHdfQIzzDox7ZwGM9IpY+BiqW3Pzrh7+o/sKFGOVjtp9hEymDPkNmnBRjGfGyzynaeEjnMNtHs4QpvFApUpLkIsWoNRgk/PrjqPHvjH3V3wSoIzzjGL6KFKSa5XzzwYTVVURjYFbL7V9Z0Hqm5TOKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwFyC1ZDsGm+pHvL15Xz76IskJeCUTVNc5+uPlRMo44=;
 b=EbHeBavl/Irr8FcjzVS9BB8WihPemloxzCfvNMtb8Sp9UC6j6N7hoOVH7d7ME7bW72DWI49w2ZnpnxpYycO4SAQ+rpJFWVOn/DUe0EELFDjTHbkmvlTxyGlVVC+Ta8YsBM8fn3tOfhcp0DXXnGhT35Gn91neXIFx5S4bnJSnJtVmmrZu1Qkl6pF2Hf+czHjCsApFanUDgDsFahEdDrJfzNEkF2CrahDBg8eD1XR/Om23tTY8ruAkQGKmazgM4CTKCbaAN311/0a+KJqFp49b8YrQWwOKcnb3BBqZSLAPcslZXZigYpqZlBTzq1vi/sHdek/PZKu9AMJRDRayKgjOig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6186.namprd12.prod.outlook.com (2603:10b6:208:3e6::5)
 by IA0PR12MB8304.namprd12.prod.outlook.com (2603:10b6:208:3dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Wed, 9 Jul
 2025 17:10:19 +0000
Received: from IA1PR12MB6186.namprd12.prod.outlook.com
 ([fe80::abec:f9c4:35f7:3d8b]) by IA1PR12MB6186.namprd12.prod.outlook.com
 ([fe80::abec:f9c4:35f7:3d8b%3]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 17:10:19 +0000
Message-ID: <6b8c512d-ced5-4116-9dde-fee081fda850@nvidia.com>
Date: Wed, 9 Jul 2025 20:10:14 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: drv-net: rss_ctx: Add short delay between
 per-context traffic checks
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Carolina Jubran <cjubran@nvidia.com>
References: <20250629111812.644282-1-noren@nvidia.com>
 <20250701172352.5dd42418@kernel.org>
Content-Language: en-US
From: Nimrod Oren <noren@nvidia.com>
In-Reply-To: <20250701172352.5dd42418@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::6)
 To IA1PR12MB6186.namprd12.prod.outlook.com (2603:10b6:208:3e6::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6186:EE_|IA0PR12MB8304:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eb243c1-2ac7-4100-672c-08ddbf0b7b46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2tMRVpCamRzaWFneWVtUTJ0aGhuMW5vTlZQcHJpYU9SSWFERFlFcW56K1Zq?=
 =?utf-8?B?dndBMzQxWWEvTmF2NlgyYkhUeS9LNytISnlOYkZGM3FITnkzOGFHekVXUERO?=
 =?utf-8?B?Rnc3NE9mZVJ1MXBCTVNUQTZ3amczemJtcFBGakZKdk8xVTNpR0l2QTVyWTRl?=
 =?utf-8?B?OE5EeXRIU0NRMkswR1J3MGV0OUdzNC83QnhXV3N5azdyZFhGSGw5RVBMeGFl?=
 =?utf-8?B?MGp1Ti9ZNTJoWFJFSVljTnFRcjlvdks0TkpRbFNDYlhlVU55ZGJrWk9WcDZI?=
 =?utf-8?B?VnJISCtnSWdxd2dTckhOd1NtaklZci9xY0xwRkZjZDl6Z29WUTZmdXhKSmVO?=
 =?utf-8?B?Y2ZqSzB6Q0tVZnBOYi9qd2J6bjQvYXl0Q3hLT3Bub0V0TUNBRFhCZmR0Q3pu?=
 =?utf-8?B?TDU2YXFGVVJpNE80ZFg0bXBTVHdudWt4VUt0TkttZnRQU1JRdkJ5Z2NWOXVH?=
 =?utf-8?B?aUpXWmIySEh1Z1lUd3Jtckx4OCtnVEoydEh0RXh5S1FIV3Y5VHhGaFlTL0wz?=
 =?utf-8?B?OFhnZmlMc084bWt5U3lYTS9PeUdBekJXWEkvLzlTMnNwTHMvNVBQL2V0M1VW?=
 =?utf-8?B?eWo0RlVLRDdBNjluelROcXI1bHA4WjVtWkZ0TWhWRXl5QTlXTGdCU1pNTGlN?=
 =?utf-8?B?eWdiVjNyWDZScngweXU2Ynhic2JxK2toVmhnQXZFK2lOSzRyZ05xUUlSV0V6?=
 =?utf-8?B?RlIxV1JWQTlQL3FmZ2gzM3hLL1lhMWkyR2dFTE9IWGZVSzJibEY2eTMrRDhj?=
 =?utf-8?B?bDN3R2dtOFpLdUhaNVRFUnZDWGZ2TXI5R2ttU3BGV0NvTHVmOERhUVZ3b1hV?=
 =?utf-8?B?R21OZEQvR3htM3ZJVnRCV3QrT0d2L0g1NDV1TFJBL1drcmIzUk1wam9aNm5a?=
 =?utf-8?B?RUFtQjRDUVJWaHArb0V6bXB6MlBqSGhQNkJyVVNJRElGZE1oWmhOcTVnVEtw?=
 =?utf-8?B?NHhuYytneVhzSEdPOUFqMklhbEZQbHhUbE5RNzZ3Vm5xUVl4ODJnaDB0Y2xL?=
 =?utf-8?B?R2tCTkxlNVV2TDdQMWl4ZEF6Y2l0NGQ3R1F5K1B0eElvUW5GcDdiVSs3WkpN?=
 =?utf-8?B?TkNYRlhBT3RwcHViYTAzRTBhN0lHaHpSbUlmQVY4OW5pUVo0WThjbVJzT0NU?=
 =?utf-8?B?d0R1dGo3Z0FETHIzb0xYbk9pSUpLeDM5c3craFFOSEJjQStCQ0hIZmE1TjZK?=
 =?utf-8?B?ZjlEaFNQaGd6UDlid0JEaGM1V3hKTmhwUi9kcXhGVi9ONkRtbVFnK1lFZXZ3?=
 =?utf-8?B?bkFIMzJSakduRmN0K2JEeXIrT25qYUJIZDY5R0xNVm8rZ2R5MUczQ0hSNi9S?=
 =?utf-8?B?UzBPakNGUkxBK0grS2dyL3hHdzBvMW1taWhsekFpalUybWZQaHNjdnFrak5M?=
 =?utf-8?B?VnhlWWljdytRK1ZuWlZUaS9reDFBV3Z5Vm5Xa2FWZkdFZTg4NHZhVWw5UVA5?=
 =?utf-8?B?OU9CVlhGVXhTL3BuNzNsbUgzQnVBYk8zVmgxdjRVWVdmbFgvODNmZlhqeGtx?=
 =?utf-8?B?M2FNZGhGN2NyYXVnRDI1Q0V0bTZ4dFhMeXBTOHFaa2lGZ25lMk4xcWJOWU5j?=
 =?utf-8?B?RU5aeGdVdE1kRXlsVGRlbm9JNEUvTWtwZzRucU5iMjBFdnpVTlV2anhSQVZY?=
 =?utf-8?B?ZEdkZzFCeTM2TjJaTTc5ejJkWWl6eDM5azVqNUNjV3JQZk8xaG1mMkxmaDJI?=
 =?utf-8?B?dVlWbjl4VHpPbGpZNnNOQjFnZFNVc2tSVlozakphVVBVNVFKOUxoNEE5NUdo?=
 =?utf-8?B?TzFrb3MzNUZiR1RXSkRITzBEZXplQ29Gc2ZDc2Z2ckxnblNGTG5adUtYR1F1?=
 =?utf-8?B?cHdCa2R1THpYbmg3YWRUcnlCSkFQbjIzY2poK3ZvZ2hDc3JRdGYveVRzVmRB?=
 =?utf-8?B?Nitqa3BRaEVBdm01R0diTWZTNnZiQjJXejVkeVlUVURjU3J1aEtiVGhJWWlv?=
 =?utf-8?Q?FdQLXKI3lAE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6186.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEM1SWtXaU9SZzRBRjNLKzczZVVUdE5vU3dWb0dOaUJGbGo1TVFIalZYRjVD?=
 =?utf-8?B?bGQva0Fzc3Z4d0ZGQzhWb1JwT1JUeUFoSnl4Z3VJdTNqQTZzNnpaeTlCRWtl?=
 =?utf-8?B?bzVnRSs0a3N0TlJuT1FTZm52Z2E2dFMzaXZLSFFPTmphMzZMVnJVd2UzL1Nx?=
 =?utf-8?B?eXQwenhLS1grcElVTHFZWGdJUUlwZjNGenlTaXNJdktrYTBBanRGUTJKN05L?=
 =?utf-8?B?ZVpMNis0MFUwWEw1SmUxeFkrLzVyMVBIM051dFIwQVpyOTBwNFB4QU5wZlZO?=
 =?utf-8?B?LzhjUDAyOU5rb0dWTE1HZlFGaCs1WWtBVUJPVFVPSXkycDQ5Tkt5SXJkRnZl?=
 =?utf-8?B?bnRhS0NCdU5Za0w2TVdOTlVBOVE1SXUzeVdHeFZvSWVvNkJqb00wR01rbkxP?=
 =?utf-8?B?ZUo4Rzk3UTJxMDFjclRuUy80dGViT1c4alhVTTQwdGU1U1ZpV2E4bHk2R2F2?=
 =?utf-8?B?VTNFcVRDa2M4OVhsNllIN2xOSGx2K1o0aGlwRk9rVTE4MmhzSWI0U3J1YUlr?=
 =?utf-8?B?ZksveDZMRVg0STdBYUJQWHNrZ1YxZ1kyYVBjbmRLL2lLL05jSXBBY0RYd21V?=
 =?utf-8?B?UlE4L2lyMytqaUJmVDNQa3NKMGp4RmZCWXVrdXV5ckdHQitqNEZHU2NqdGtq?=
 =?utf-8?B?WmFDUllNS3BaUmVscy9IOU5US3k1VkVSUXpHRStwQjRtcCtNamdtam9QUGNC?=
 =?utf-8?B?a3VsUnBISHpwdWVKR2lpRkVIS1JGQUlKT0IyTG1kUXJMZ3dNdzJNaVl0bURr?=
 =?utf-8?B?cml6YWo2SkhFT2tkdVNLNFlEWC9jYTh4eXlqUEZhRDZhY2NObEdZQ1U4TmtG?=
 =?utf-8?B?QzRLbG05UUZKdGxxdjNZMm5ZRkRsRTJJSEp1aXl2MU9UREVWbmVVNU52NVp2?=
 =?utf-8?B?SmREUHdCVmV3UEp0YlZtMkY0aS9GZTB0SFl0d2dORnFBam9xT1VMYjZFYmlB?=
 =?utf-8?B?T3NsTWhPQ245ajJqZ2hVeXJvM25CYlFhWHh6bndGMktWeUZHZVRIR0psSVNk?=
 =?utf-8?B?K2ppaFJIeFMxRVRXMFVRMGpmQVFoVGNTd3FnK0kzdHFnTUYrZE8wdTJleVdW?=
 =?utf-8?B?bUlDSGVqT0E1dzIvdnpPOXVtYllBam1kdmVwa0tJdHJndVdxYXBkOUtBd2py?=
 =?utf-8?B?c3FiWmZOWkZJc0VjNmJsMEZCTUJTV0pWY0JmZS93NnZaMzhpWW1veDZsakV1?=
 =?utf-8?B?V25DOTJIamNLbHlZOFduTXpRMjYwbVF0a2NGMndOTFEvVjNySFIwSGFVeHNa?=
 =?utf-8?B?eXFjTGJoaGFLL0FPTU5GanJSNjkrODJCL0xiODl1bnpYM1RmdDNHcENIMlNa?=
 =?utf-8?B?UVY3M0Y3M004SFJJRFFtWTJFWjI1eWhxN2hIWWpORUZ1a1ltdWVmZG0wczJv?=
 =?utf-8?B?M0tDWU9RdjRqeGlLNWhLNE1yTllZZFBXRDVwbWtwTkpGTHZOcmFWMXRFQjFX?=
 =?utf-8?B?V2NYdGhlc0x6MklnWTZ2S0pLdHdkeWpXZ2NYc3NtenUrZ2ZyK0RGVmIvM1BV?=
 =?utf-8?B?NmIvcEZuUHJ4Z1JwWTBhNTlXdmhOK2JGQW1KMGM4UWcrQ00zTVFEME9QbzJM?=
 =?utf-8?B?aDZmN0c0emt0MHpKY1c0NEVyUDFkbjdFam9CRGsxOEc0TkdMK0lGa2ViVG5O?=
 =?utf-8?B?Z1U3eTJoSG9oQ2xRZno3UDVXNHZFQm9FRXhHc1RxTFhRQ1JUaG9JSE9icU1p?=
 =?utf-8?B?ZU9kWS9NczVKYWxqVXMrOTdnZlpwNk93UEpNUGZHRHdrajdRZ3dWN3M4eUpS?=
 =?utf-8?B?bER1SHcyS2g3cFBFLzA2b0xCMEEyc3lwKytzRStVUVZWYURzWUxseE9xRDEx?=
 =?utf-8?B?SlBGdXM0VXlsbTJRblBHaDFDT3VOS3hTelFJZHBybnhiT0lTYzVmU3dBNnVl?=
 =?utf-8?B?L1FTWHNLQlQ3VE1mR21XRjJaK2d3NGlDUm8yaXN5WlVvWHplRDFVazVCQXB4?=
 =?utf-8?B?UXZLNk1xNlZUVmpkamNibDhzTGVNdVBEdWtCcENMcDdRZHc4NHp4SERjMDls?=
 =?utf-8?B?K1RNcmN4amhWZ21qZ2xxWGh5Q3cvc3U4eFpuekIrRGQ4cUhkeGg1MnJWWml5?=
 =?utf-8?B?MTF1aEhzV01ZY3dSYVhiQUJrYUxYZHlNOGtUNlVBUFB5b0phTHQwRi9ZYWx6?=
 =?utf-8?Q?VNZc0hSwESrzCjriouPglgeCt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb243c1-2ac7-4100-672c-08ddbf0b7b46
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6186.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 17:10:19.3537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WOfKRkP9KnsG56tvUFTjPiikHLOCJygDiWFKDMt5Kahu0hTWK/zlBKTDQ0tiMQq+YuKbB8QOdZuoeBaarO51CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8304

On 02/07/2025 3:23, Jakub Kicinski wrote:
> On Sun, 29 Jun 2025 14:18:12 +0300 Nimrod Oren wrote:
>> A few packets may still be sent and received during the termination of
>> the iperf processes. These late packets cause failures when they arrive
>> on queues expected to be empty.
>>
>> Add a one second delay between repeated _send_traffic_check() calls in
>> rss_ctx tests to ensure such packets are processed before the next
>> traffic checks are performed.
> 
> Sprinklings sleeps should be last resort. Is there a way to wait for
> iperf to shut down cleanly, or wait for the socket to be closed fully?
> Like wait_port_listen() ?

The socket may end up in TIME_WAIT state, so waiting for it to be fully
closed can take ~2 mins. We could opt for a single sleep during
GenerateTraffic.stop(), but that would also affect tests that aren't
impacted by late packets. WDYT?

