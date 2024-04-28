Return-Path: <linux-kselftest+bounces-9001-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A948B4E72
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 00:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0860E1C203BF
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Apr 2024 22:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0120C8F4E;
	Sun, 28 Apr 2024 22:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q9WY3KqI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EB0BA2B;
	Sun, 28 Apr 2024 22:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714341897; cv=fail; b=sA5JLEp/BSsb9hDGhEs2Rb9bcm/3O9+cAkcIdLRgE7PpI6KKTFDxrgH/Jn5ZxxCHEv2iES2AzJoLLn3PPgR4ZAeQkRimyJ3EIXCCJ84JjLhfxBSLjKDXWPNY9tI9+nTFto1sTGAA0mgklpt1L5FdH/fYb4c8tnHt60JNFtKyDT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714341897; c=relaxed/simple;
	bh=XVq+SpgctHB8TTtSkrKf4JJdWgK/d+KL5xOL1oxF+D8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bh0p9iA6ZZTq0myZhYEy4hWkFx8yPIVDf8uTX4os2xngRv3mbPM2g4Q91ijY5cn1Qw4bqAl9h/T1t6G5SN2yxJG3yGJWjUxT7eObr3/alL/XvFXaDz2AuAgk2OLzBJsyYU11RtGbA10FwC1A7X2bXf2rjk3D6pr9jexCjyaEGPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q9WY3KqI; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MT0nKm1isM3dXF1xwrj/6ZPSsAsrAjBi8mEGnimxg2Sh81bpMRi3VQUI6rXEgvxjfGmHk92HS+snD7C3F4F7IZpuBfMHvy6DGMNU6PyWvZw7RlYGFpDUn9NjRxr/4IP3p47i43iaJHwMQbC0gWplylcCls4+8KcSv/ltl8gA+ts2snp72mjubOUzC1Llvhs45fR6D6BgB3HvffacfPXC7BBLZOatSO1PE7FW4xupFr+P6zBmou1Q5BsjldiIE53AqY46pr0Gfqg3R94F6Ml/UhHh5XfXkjfQsvx3IzcfmU/r/CpO3XyT/vH/5cU/O289dQhO51kgQXxj2aVtPbdLCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2AzvsZ9U0miaSHKRqeHxskPCLOpU8yX69ACzCBgn2g=;
 b=OCSRnOWLWuVHJ2HtDpenU39Qn34gr+L61ALDSlV5v8K3OHJdlwcch6u7u1NBsVssTQsMSmkCAsVdh3SoHw8g3Dkfd8i3QnaDV69ATOAoMnJHE0VkeMTOI3HhwP6i4k/hSFPPxmZQbRtajI/tCb+Kfi/I1jAx8oEkH5rtssEoDeWp8KKX3dMaaAO7lYbBENQTfwTu3LVoLoa0I3t561SeKdwuW/VZDarnWEmUukLIZ1lmo5eRERUiMS/9uOG+01P/m2GLGgUuhs64awtEHOkJz21pxMSSqi85UIZgS+L54fCxWWDN09Hm2y8562JoBCvJP8xWGv2ge+W3KqGhuPjEFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2AzvsZ9U0miaSHKRqeHxskPCLOpU8yX69ACzCBgn2g=;
 b=q9WY3KqIl/BpPdzR5FpxuF2oSF45yytKZ2q7QUVAGTE/fol1sLDr3C8L7qf4/vW7AWpgGgDKqhmxRkcw3C62I90xByI3iFVSJt73qYjuiW27+UE6WLLz4rqlpLTfZOenUJ3jIOuFkPzqiUEP5SsxpILlkxIM9cQaljISAlW2/BzCJLJLrG97YTlxfY1j/6nVOLh22BBS70qHhO9ssl7MyxjJ24FhtiT8GLV5xwvoOTsn6Wr1JDdhT8Lr0fs8cVxoofpBzLM85uSv/G0jUd2nxbYqL8JPeZ9yhShApfVD5rGo7J/zc9Eo4btU/TzBkbZgeK69B6O8m8+wK4dMxoE/+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CH3PR12MB8852.namprd12.prod.outlook.com (2603:10b6:610:17d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Sun, 28 Apr
 2024 22:04:51 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%7]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 22:04:49 +0000
Message-ID: <b728014e-9e8f-4b65-8d9e-ace0e2f6f18c@nvidia.com>
Date: Sun, 28 Apr 2024 15:04:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: default to host arch for LLVM builds
To: Valentin Obst <kernel@valentinobst.de>
Cc: anders.roxell@linaro.org, bpoirier@nvidia.com, broonie@kernel.org,
 guillaume.tucker@collabora.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, mpdesouza@suse.com, nathan@kernel.org,
 sashal@kernel.org, shuah@kernel.org
References: <6d398f1d-6882-40fb-8ced-7fe6bee2aee7@nvidia.com>
 <20240428120806.19275-1-kernel@valentinobst.de>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240428120806.19275-1-kernel@valentinobst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::11) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|CH3PR12MB8852:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f80a4ad-0d5b-4c66-a339-08dc67cf38ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3c0RmMxMllJVHVWK2FRRGhIV2p3c1JPaUFVdkM4cHB5OWJsaEo2QjJMeVoz?=
 =?utf-8?B?M291Z3N3bC9lVWZmMkhKQTAwM3dmYnFXSVFNM21XcUk2akI1M1Z2eDJEZHAx?=
 =?utf-8?B?V1pRT0kxUW9kOHkrTG5OWlU0WUM2WEZ3TjVYTTBvbzNjZzFzYWliYi9Fb2hV?=
 =?utf-8?B?UnlNckVhNVJmNk9hUGp1RmkzbHorS2txekl2VDFscGVGekF6cWpBdWlUcmho?=
 =?utf-8?B?a0x6TlBNZTR5VTRvd1dBZ1UzRlJ0VnJvaThTRUlLVWlmUDVnT1k5bWpHQnIz?=
 =?utf-8?B?UEdJUWJBbXRMZmFvRFJpcVA4bmk1U2ZpUzF6QWFqOXMzM2kwTFpQR2JJN1or?=
 =?utf-8?B?dTc3MzFtK0lwR29lRkN6TC9QdUVGUXBtRXVsREJ2RkptRU1SM2pGcGYrNENr?=
 =?utf-8?B?WFJPVG13eW9RTWdnRUNUa29hME9GY0tuUmUzdC9ibEJYK01MVWc2bG43TWdv?=
 =?utf-8?B?RE9KZ3hHRmtGL3YvaFlLYSszR0hacXdnN3ZZZWZWREVpWnBicGhYZHVxSTli?=
 =?utf-8?B?SEdFangrU0hqeDhrRWE5TysybWhyTHVZaVRFUjlGYmhhakNxUjhLK0E3UlhK?=
 =?utf-8?B?SlRmRXdXdS9FVGFHYmp0TkxjZEVyMVBENDBlVHBJbDN5OGtXekNUdUM5ZCtQ?=
 =?utf-8?B?ZHdTS053QTZkYXlGQkN3N3dLbUU3WS9SUndLRFBudzhCeXJZclNiRllGdnZ1?=
 =?utf-8?B?MENlVlFObklJT05oR21YVkVIOFpYeUZnU1g2RitDdXFvUXdyV21PMTl1NFBJ?=
 =?utf-8?B?TFVlSWlENjZzVDBMUjJJU2kwS1BDM1RGWG16MEVkSkNhY1BVTG1RaDJkVFAw?=
 =?utf-8?B?UVFpNVQrZGlyR25XWFdWeDRuOXp2RjdFbkJtQlU3dVVOY1NBb216ZldYdE9o?=
 =?utf-8?B?ZzArRWF3ZS80VFZaNWJXMG5Lclk0QXFTRnJLZUYyeUsxYVhSdTUva0puUy8y?=
 =?utf-8?B?cmpWZFpLQ0VBckI5WmdjWk03b0xhK2JhejNSRklDME4zeXV5RlB3QXRlYUs0?=
 =?utf-8?B?WDBiY2pFQWx1aDhBajljMjN4YTI3MHI4dEw4VzhwbThVTHZkeDkzVGlkSG1W?=
 =?utf-8?B?QjFaQ2xxeVRaSXNCQzlFc0tYNk1NNHhaYUNzRi92QWFGTkJtSkVNMkVRaFNU?=
 =?utf-8?B?SElhZUhmWDgrWnlPMUIySEpIc3BoUkR1ajBXc0JvUWVGWndkamVvYWRDQUll?=
 =?utf-8?B?dkthcXdodUdGcVEzVFhqRDNDV3B2TUxTdEFEeGdsV09iWERUbS92Y09hMVBH?=
 =?utf-8?B?UFl0dHA1UDZ5MTcrTzcvQTZybzhZT2c3RXNIZlk3dGZCdlhVUEQzVDRGc0Vy?=
 =?utf-8?B?NnZHaXpGek8zQk11R0QvcUg0dU16NUtIb2tOTzIzVGpSVmJJbzI4Q0lYY282?=
 =?utf-8?B?ZGdFZEIxT25kZWFRSHp1Vm1oem5lc1hUUFRrNXBLSy92NGR1cnRVSU1JWC9E?=
 =?utf-8?B?Qm9oMUN1MTl2MGRreXRUV0ExTmtUUkt6a3lWYXRUVm9TRWM2eWxIVk93SXp0?=
 =?utf-8?B?UWZSNE5CV3ZzYkNKWGphOG9pdi8wd3owc1V0ZDlZNDhjTHBCYVFTZytpSmpJ?=
 =?utf-8?B?bkt5R1FpQzNZY2pHZG9DdDdwRGV0TVpKQzZMM2pvRWcxU0tWdVFaQ0o0S2wy?=
 =?utf-8?B?WUJPbm01NG15QzJvaGtVUFRVWjR4azNjQnltcTlxbUpXRGltNnRhR29mc1JH?=
 =?utf-8?B?bVZJczJTQUd5Q3E4VVpFQ1NQY3dFaE5acEZUaG5NMWxjb0ZHTGxwYkJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFBQQm10d2NRemxURjhONXlqakpTYnhXckhUNFNOSjZMclZ0bHJRWVNCQkRV?=
 =?utf-8?B?WHVKZ1Ewbm9ycWtyZ2RNUzVXdlB4VHpQS054dVFXOGhqd3Y3dnJacUtNUDN4?=
 =?utf-8?B?RFNXR3JoazNuUGNMaUxrSmVXVCtxeW51V1A0Z0NHSXRhNk1oT2ttL2cwZWpH?=
 =?utf-8?B?RTFNZW15MTN2MkdOYlR6bVB3aWUzSzJ1U2c1OTRWV2pUWDFTeXA4eGwzeUxO?=
 =?utf-8?B?T0tmcmFHd0tadm5yU2ZBTnc3d2dqSzVFV296MWRNRGsybHdBVzlkNXJvdDZm?=
 =?utf-8?B?Zmw0VG56OWVMZmlHZURGU3ZDUkkra3pRdkhsSSt1dHhQVXdwNEJYUkZDbFph?=
 =?utf-8?B?ajlubHVudlRPaktNTnE1WVp1UE0vUlI5RXg3bGZWQmlpN2lURlRtL2hQQmp4?=
 =?utf-8?B?R29MZUxLNGtIMnVXR3JmRVJVNEN1K0ptbC9PVS9ZZkFiWG5uNlpHUGVEZzFE?=
 =?utf-8?B?M0Qzek5Malp0dlk1RE83OVFxNFRJQitnVkdkZWVnZlRGMUszRzdGMldCNnBk?=
 =?utf-8?B?eXpHRmRwQVFpalB0QlAxcDJ6dFc3NnJHbE45NlpyQUZXTThTMy9IL1NqV215?=
 =?utf-8?B?TWlaWjFNK0IrYUxWaTR1YlFidFZwRXl5amtieHFUbm9wWFRHa0dCUFJsR2t5?=
 =?utf-8?B?R0l0OVZMLzR3dkdrQ21PbGxUVzd1VFJBUlRvTDVacTZrK1FXYmpHNHNKNEQx?=
 =?utf-8?B?QURaeTZWZXU3K1JucTkvVkJaMWtIeDNZdnkwTzdkbkEvdDllamxhOVJveUdK?=
 =?utf-8?B?WFl3bDhIaWVBcWVqK0Z6SnpkL0NjK3VvZmdUSElBdW9vQXY1Q2d3NnZ3cy95?=
 =?utf-8?B?TWdCcGlTbEl0Q1YrelFoRE9wNHFsaUNHR1J3d09uS2hoTnR1NFA0YkpPS2Rw?=
 =?utf-8?B?VDg5bkFrR3U5ZEJpVSs4MXZuV3pSSVJCK25jVWF0N2hqdWdFZTFRcU5BZkc5?=
 =?utf-8?B?Y21oZCtOeWJ6WHoxMXgzcUFHSlpTbjkzNUw4VEt5YmI4ZUlSS1U1ZEZmR2Jj?=
 =?utf-8?B?S2FsNUIzbUNQQml1bnRSTjFSQnYrOW1aN1k3Z05TV0VMVFZ6U2xTL1NIUEZS?=
 =?utf-8?B?eGxTZTlJM2I0MUpzSmdCTi84RUhkZmdDS244TllQSGNlQmJtS1RubHM5MmtT?=
 =?utf-8?B?MW1jK3hVUG1pVnNWZjZqWElXdzJLNDhFcnp3LytwVk0rMDlDV2M4OVFQS0RR?=
 =?utf-8?B?TExiVHhzL2pYM1NjeWFybkNweVNmZHFoUFd1RHYzcjVXdkFqSW5JamIvRWJV?=
 =?utf-8?B?Rm5rNkRscUwrbE5YZWFmcmRLZ0Y2Nkh1dFBpZ1pYQ0ZCKzNhN2JvZHpxbXJw?=
 =?utf-8?B?UVZLRUtBU0RlQjh5Qm8xR3A5bUEwNzJvL3RrR001T0R1MmlDdG4vSVVlSmtr?=
 =?utf-8?B?RzdHWWMrTDBwZTRrNjhRMzh5RUtEbEZjR3A0ZHdKTEs5QXhQQkRIVjZFcG9D?=
 =?utf-8?B?UENLYVNwQmE5NEhuWVdXeHV3TmRXUzdOZVJRNnRnbXY5V0VBN3B0WnF2T0Yv?=
 =?utf-8?B?ZEtNU3ROem9mOTkzYWo1NUFsYmYwS2JMOXFKRVZYY0E4cHlpYkNKNkJYWTBF?=
 =?utf-8?B?RkJnbzViUklVZmY0T3VVdHZMQUZTcUd3ZHNnaHM4Z0xreGZhenU1WGU5TEFR?=
 =?utf-8?B?ZExmRFJteSticnRjNnVkS1BLd0RyTkFDMTV0RWFSNTVkWDdyR0hCRnBXL3Zn?=
 =?utf-8?B?dG92SHVha3dmc0R0T3BiMHQvdk9ZZlpPcW1WTDJ5MkdkSU9XamgxaVlvNTBZ?=
 =?utf-8?B?NmtaOVhwaVFRbDZBNmJzZGZWU3gyR3dqaTVrTlN4cGpEcHZnVEZQS1VWQkM5?=
 =?utf-8?B?NGVrR0VKdFhkWUtNazJFQ1hGcTE5c3czc3RiWEE4aWRIdnQ5WWlCd0lGNzBy?=
 =?utf-8?B?TCtxUCtlem1FZ3ltd2ZYbEU1dmJ0WHZKL3o3KzdxM3RSUlBRaUZDV2xZZ1R2?=
 =?utf-8?B?TCtLTTBkdFVwY2lXcks1UDE2SE1DblR3WWE2ZHdiOVBJTHc3dkRGUkxyRnA0?=
 =?utf-8?B?NnRMaFIwRUZJZzNSbFltYlVXNE84TUFOVUNRZmRpMnJmUlhNenhIWXNJWlNo?=
 =?utf-8?B?S1NGVnNyYzlMaldqdkVlTE1UaWFqMENLYjZXMkVSSzk3eUNkZ3paYW4zQ1NK?=
 =?utf-8?B?cWhrS00wcUdqR2hlTHBkVUFMT3UyR2tCbzRjKzRYd1ZsR2lINmUva1BrTExj?=
 =?utf-8?B?UUE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f80a4ad-0d5b-4c66-a339-08dc67cf38ea
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2024 22:04:49.1747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eO8fbreSajJeu6UNFO5igiYlDbYWj5Al+Baqtp767WAZxfjtYuMQqZDKGrOBn2DVDSRwqiuQP+BWVB6lVBCf6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8852

On 4/28/24 5:08 AM, Valentin Obst wrote:
...
>> And yes, the selftests "normal" (non-cross-compile) build is *broken*
>> right now, for clang. I didn't realize from the patch title that this is
>> actually a significant fix. Maybe we should change the subject line (patch
>> title) to something like:
>>
>>      [PATCH] selftests: fix the clang build: default to host arch for LLVM builds
> 
> Yes, I agree that the title should contain the word 'fix' somewhere. For
> me its okay if maintainers reword the title when applying the patch,
> alternatively I can send a v2. (Is it still a v2 if I change the title, or
> rather a new patch?).

It would still be a v2, although the cover letter, or the section after the
"---", would need to point to v1 so that people could make the connection.

> 
> Any thoughts on whether this also needs a 'Cc stable'? Its not quite
> clear to me if this fix meets the requirements. As above, no objections if
> maintainers should decide to add it.
> 

Maybe not, because it doesn't seem urgent. But it's a judgment call.

By the way, I've been chipping away at fixing clang selftest build
failures and warnings that are only visible after clang is working again
(due to your fix here), and I'm up to 30+ patches, and probably only a
few more to go to get all of them.

I'm expecting to post the series soon, hopefully this week. And I'm
thinking maybe I should carry your patch as the first one in the series,
in order to ensure it gets picked up. Or, I can just refer to it as a
prerequisite in the cover letter.


thanks,
-- 
John Hubbard
NVIDIA


