Return-Path: <linux-kselftest+bounces-38222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A81B190E1
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Aug 2025 01:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06E4B3BBE6D
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 23:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A70D2116F6;
	Sat,  2 Aug 2025 23:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o34KiYrZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A770717736;
	Sat,  2 Aug 2025 23:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754177765; cv=fail; b=SyrUlKG0fmEcBy6jHQWNsdbkJ4vNaD9ZOg6JTT642LyT2e+JbTVAn1tcOO7RCaRYF5Ezgh8Elxc1cPekA75OfunKTrcSVzg8U4ORS0AWHVCApnOoMYn96dyd46YY/goZan8IY9HbTNs/l+rFtelp6c2WrtEKeKwscRvmWsA6iUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754177765; c=relaxed/simple;
	bh=iYVEV5neEyTRLSKX4T60p2ZHhniGFU1iIz1VEHHw9M0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NC0Q8HOpQQOMG/ihM424aGEcS0rBumCzPWkKmttdCzQmWDf+SrSXjhuyyl7UjA0YINz55sNvBTQ4mLGfzSn/l+Lxb7dRJedIMpXEVafs12nsWode5cYkr+uIfDYs0c7LQvmxguNlmFTQg5QJrxT3yp9qWefcOM4TfXEiCTFxJwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o34KiYrZ; arc=fail smtp.client-ip=40.107.237.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QV5XeLrq4GQSi1vB4V9BhNgrSeQkqyflVJlOacbxGCFR4tqvV4Ayui7fGUdD0zyWIS0sGULU3+rzvQVkoXCc98pSnti/ZyibdqW06x9WiEmddls7fkmqkK7/UYFSs+ItrykA0hX8cjmZle2wFGMonDlEDW6c4UVqUv75n9nZKbJevghZbeJvQCZGUJKxfNB9PhHa+KUZhXsp4s/obLEZFPgsKnJR+gy/kv8VhiKcB4ruXf/qO3xhkZOGkxLiVhgGi9qPIrKxhRoYFhMocn36M8m8rkAKQ9jDbe/68Hs9GA2R+dHRb8QHJtWOWccgvLtM0Z2wmhnEKSvlNW76L0bR2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mR/ALa54VTUVWVRprPLUXk9xw9Oz5Lxd8cl9Y7R3TQ8=;
 b=WuAYCuGeDhaTEDHEPsGM8lkBF9KUBqn/iuVugCJQdYUT0GXN6ItHQFRORIzWQH9hg9Ph8eSk3N1lLQ4OFDnpe8zFRozl4dxbdFQ9qRxbWqJj9ppebq+hJDyrViH9wKtHxmgM0gx8vPQ39+QLdIgoAvQ6syZoPLq6maT+q50LCr2mTn+2Zn5ut/9cVUKzS7vuK/LEDUK5ljklFS2C0aDpsBaZwJyG0IbF46nDxNKFNaNzmOt+VRtTXTbso6jlp+FT6MjjyXKwO+85I0r5gZC/TkzIyMiZ+uP/JuWS4IsN4CinrM+4l1i6y/Gk5nLsNgbu4T26ZRdREEQhLE2ijW2fwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mR/ALa54VTUVWVRprPLUXk9xw9Oz5Lxd8cl9Y7R3TQ8=;
 b=o34KiYrZzxCv1Wn1C/B0TMTnWAjzXpTQ1CImxk89K4+DroViajf7ljIwfP1Uyva99vl2jViWQ+P3gSkc1wfevAaVf8jVb19hpCm5VFYWUAPaf/LW1oGw0HqH7x0Pu81V6SxK7hM/juQges/8iwyWbOnEujBiCo/DKor1RZeMvBoQM3U5koIw1AW+tZUyDjXU5iNaulDLqQNR+zySW2n2ZFB9XESZ++Ps9CCnCiaV0t9mV95XuUEiifbrxM9Z/4MwWMUJieZoeDSVAuS5sD6QV+efDnPNETpiP8T/Qg7q8m1CEEzBTyYP7SScBcP/I65Qs/rdlFb8ksBHqC2EYPppPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by LV3PR12MB9188.namprd12.prod.outlook.com (2603:10b6:408:19b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Sat, 2 Aug
 2025 23:35:59 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%7]) with mapi id 15.20.8989.017; Sat, 2 Aug 2025
 23:35:59 +0000
Message-ID: <c17610f8-b34c-4abb-8d79-9c1678106add@nvidia.com>
Date: Sat, 2 Aug 2025 16:35:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] selftests: kselftest.h: Add __unused macro
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Peter Xu <peterx@redhat.com>,
 Leon Romanovsky <leon@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com
References: <20250731160132.1795351-1-usama.anjum@collabora.com>
 <20250731160132.1795351-4-usama.anjum@collabora.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20250731160132.1795351-4-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::14) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|LV3PR12MB9188:EE_
X-MS-Office365-Filtering-Correlation-Id: ecc0170f-88bb-41a3-253d-08ddd21d55f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1FaMGlrTER1cDV2dnZGL2FkV05BN1RhWjRzYUFRdk1JSU5wemhMZGxwMjRh?=
 =?utf-8?B?S3BlWWtOSi9DL1BIbmR4OWlacUNrUzNzRmh4ZVRBOEdKSFhhKzdUV2VnMURH?=
 =?utf-8?B?WUhibHNlVTdTQ1FJRFJKUklLUTYwcWxodFYxZ3dnVUFkMCtSVmwxYnVnQWhl?=
 =?utf-8?B?djVYU2NveEVkeGtXeUlrYUY4aE1sYnMzV2xMcXVJYnJDbGxaTHNPWFJMa0RY?=
 =?utf-8?B?QW1aM0ZHenJtT29ybGkwQVlCdG5ESk85eE43cUFaVFN1N1FRVUdRb2Y2Z2NW?=
 =?utf-8?B?alN5UWtLMnRnbmpXRXo0aHpnZW5Ia2djWGM5aDcrK2ZpUjBkbHYxVlJOQyt0?=
 =?utf-8?B?NzBHeUh2Q2JyUVRqczBOdDlUbHBvRnlqMS9ZMzhWbEpVdGlDUnBTd256a0hJ?=
 =?utf-8?B?MTEzdkVvZDJrOG1NNUg3MVVpdUVURHlRWHVGMThobEFPZjBSa2VuSVpTRyt4?=
 =?utf-8?B?UWpHMVR2RzQ0cERSQzZvalJHUkRGTUVIWk1Pc2FSZyszSEErRUU2N1FTenpl?=
 =?utf-8?B?dE5qRkllQ29vTVIwbDJvZk9NSmdvTGpFTWJjME9TK09JS0hEUFRxSElPSGQy?=
 =?utf-8?B?Um1TUkxOeTdLdXpzZExNQWFzUFJqWlJ4OUY2WHpsYVphZG14MkdkM0haVkZR?=
 =?utf-8?B?ODRWMFlqZTZZdUlDV3JIb2I1L2ZFeE10WWlJeDIzaW50dnFKSjRpdWsvVFpO?=
 =?utf-8?B?S1E2Nk11V2NMckV3V1BqZEZVQllpeXV4RkRzRlV3aE5yamJTSVMvMlV6cVhK?=
 =?utf-8?B?anZGOWdyOGhxZXB0VGkyT044N3hxNU5WM1ZJWTlMLzkzVWhTUWI3enNISFRB?=
 =?utf-8?B?Vmo1V2E1eHdyeS94VDk1SFdvY0MwYjBZdHBIRUcvL0tNNUhwZFo5TVBhcXF1?=
 =?utf-8?B?U2dqS2tBNktkUWw1SjRPMkVxajJmRUc5NTlRZkVxckQ4NXY4VUpqQlBuYm1Z?=
 =?utf-8?B?RHkzblNyTDMyK05kTDFsdWtlQm5IdXBqM3htUDgvSEh1Zjcxd3Z6ZlhNbktQ?=
 =?utf-8?B?emJkbm8wQXhXcE9MUGVpVFpYRjFSVFc3N09UQVY3dUdSc1VWWmFFeFZRbENt?=
 =?utf-8?B?S2ZscWcxWWVSajN5bEptV0tDVG5vN1RVaG5XajFNK3BFQlE0L3MzRFV4MGpH?=
 =?utf-8?B?Z2YrTnFVcGVMS3BMVHFxUHJKZkEzT3ZyOU9UdGxPVnNyeEdFdkdoWENSTzhz?=
 =?utf-8?B?R2I4QUpXUzdtR0lDY3ZTZy82K3haVG4reDZ2dUxHdnY2NEFmL25obUNCTWkw?=
 =?utf-8?B?cnlDU2lWUnJTSUE3dWk1RVlvaFQ1amNERWhZVklrS1NKUktrRHl6OUduZmZE?=
 =?utf-8?B?ckNaYkd6MTY4bTltQURLbmx3VVpUc1dMcmJlVTJ5aHpPaHFZQnFXWVJ4Wjd0?=
 =?utf-8?B?L1B5N0FDZTNIZU4wSFhrSFhBRWlJK3NncTFsLzlZU2ZpVE82RmVJbkc3ZUlE?=
 =?utf-8?B?VlNEQnArWGhWeUFyNXBIK0p0S0FGSnl3YXBBOFlpRjdUSGhaTmF3dTl2RWE1?=
 =?utf-8?B?ZzAvWDVrVkJGVi9oY1ZlSlUvNmhqVG5hckJyN2o0Q0dLYmt0aUt4cnlJekVo?=
 =?utf-8?B?STFBbUJ6akgrL2dxTlF0UUJMakQrMURLUG5UVVhJaHNOa2htUGFGNTdlbFN1?=
 =?utf-8?B?R0RqMVNIRFJRNS82eFN2OTZvc3ZIRHBOUTVMajBZaVBuNVlma0lKalFtc1lS?=
 =?utf-8?B?dndmUmdLazVpOHJxZXJXU3dQQTZXOVJZUTVHNHVNUTlFNktxRUZSMkVYbWZo?=
 =?utf-8?B?V2c3VCtrVmplY3RZdUJEY3NxRUZuQXRZQ3U4Z2xTZlRCZCtMZDcydk9aTmdI?=
 =?utf-8?B?bUJnZHpHU0RSSm5FcUltVENvTFlWL3dTVG9FSXRyRGpXaXlrM2hyS3ZUb3pu?=
 =?utf-8?B?a054amFzam1PQTZTcGE3amdQL2R0S3hwbWlEYXNMYUtoNEtrZzRYOTVqWm9K?=
 =?utf-8?B?TG1JczJOK2c0eXcydVR1OEMvdGpGbTQ4M2tKSkFVVTJvbmlCUU1ZVWd2U1dY?=
 =?utf-8?B?QVh6UVAwcG93PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3VFSE00SmhaV0V5OTEvMDJkTStQSm9LUyt0QjljUThOT2VYVXhsMy9lSU85?=
 =?utf-8?B?UW9KcHoyWTVsaTlTQXljc1JXOW1LNlR1b2UweEd6cTFXaThFZlNDK1Brbmoy?=
 =?utf-8?B?SFB4UWZRZUlqS01XdVVYbTljUFd6QnlaR3BrVEpndk85UFZmZU0zVWhyTHZK?=
 =?utf-8?B?bTM3cGFUbmxBUzRwVXFjTUxwdnJNOG9JNjU4dThNUTFzUDNEQXYxWkQxbFM5?=
 =?utf-8?B?ZGczeGVPWEVsMVpPT0FUU1pXN1NkaGFaMGVqZWRHbXV6eHJOVHh2bkx5aEE4?=
 =?utf-8?B?Z0ExazgyV0FkTytkYTFPc3pLTlBTaG55TUN6eEhRZnUrU3plT3dTaXZ6NnA3?=
 =?utf-8?B?MjkxdUN2Q1c2OVRsNXNTOHBaMHVQRmN4YW1BSjQwNUp3TS9URkczRk92U3pI?=
 =?utf-8?B?VGhPdFhXMVFiVlppTEJ3VUlZSy9LeWpMNGRxZndmTGxBb09QaU1UODRnOG5C?=
 =?utf-8?B?RjNINSttN1A5VFp2K0RxaWFnWldzbDNDd3JGMWxuTmI4SEY4VFdDUk1uMG5u?=
 =?utf-8?B?SzlHMDVIZWxWa0J1WW1JcDJTeUJkNmQ3UUJFcHZLbVlsQ0xET1JuS1R2bjNr?=
 =?utf-8?B?R01mcHVNNHZFWjRJUmEwK1BGMGVSdXYwd0Zoci9ZaUNpL0lrSzZwdGhVdE9K?=
 =?utf-8?B?S1NKSXgyWWl6dkY1d2NSaDhhb1FZcUZkN2tnNFJsaFVBdzlxNG1aL0JqWSta?=
 =?utf-8?B?TkwyaXFYNDZ2ZC9kZGxQTVhnSWV4VEE3aUxjSjN5ZHo3TlluVFFNbzFCWFFF?=
 =?utf-8?B?WWtXaDgybVk4bUJHTDBTRE1XLzlzcU9ZMzd3Y0pTN3R5c0N4NjkwcWg1SE1M?=
 =?utf-8?B?RFJxL2s3c1ZkMlVCTldtMWNhQW14ZXJ5azFEejZGd2VwVUNYOU1xWUw2R3Rm?=
 =?utf-8?B?OFNPbUdlaDFBK1A3eGFtOTUrK0NuOCtHQm12KzdaT1dXRTZwUGdKejIvUXNp?=
 =?utf-8?B?U1REa2lUUTlqVTM0Lzl6S09iRlhweExYT0U4RFdKVVFvSytudkQ1QXlGNUZF?=
 =?utf-8?B?emdJbjhDODh1ZTRtVi9PUjNuanEvS3QrNVljOG84S2ZaWkdQSlFTWExjNHE0?=
 =?utf-8?B?KzN2UHg0djN4SXFJQktTelNHV0xJYXZJNlN0K0JTVlorMHQxbC9RTTVrY3hq?=
 =?utf-8?B?cmY4RGRSTFg4U2txb2VLZGR1bXZJN2dHRVdNMVBud083NGduWklxOWhXWUdM?=
 =?utf-8?B?Vm15clhKdmxQOU5kMFZER2FRR01DcVpkYklROE45MEpYMkhkcTVhcXhRa29a?=
 =?utf-8?B?cndLN0hsMmNBNGhreG5LK05Qc2l5RFAweFRrWEUyUFJUSngvUFUxM1NYTTBp?=
 =?utf-8?B?N0xyQVNxcExHK01tQlA2TzdvRFQ4NGdyV24vYXdZengxYXlBT1pFZEhuRzll?=
 =?utf-8?B?NTIxR1N2NnFiVlV5L0NqU2c0K1hueHZhclFCSXQ4bXAzTDN5Z21heVZqeDcv?=
 =?utf-8?B?cXM2ODUyVWpzcU9Qb29qazlEeEtzK210VGcxOFU0TUtnb3ExQTlreU1JTDVD?=
 =?utf-8?B?anJUN1BsSUhXRVNsVElqeGk4WlU0bi9mRitabkhpQ01kTGRDU05uTEE1SDQ2?=
 =?utf-8?B?VWJuUzBHVUUrZXQ1eSthTkhYaGUrZzJYWnQ4WGpLcGRKZHRZMWdNemFLMDJr?=
 =?utf-8?B?TVM3QUFmNXE3Tmx3QjUxb0xiZG9JdXVRRzNTV0JqZDUzR3dZMlFsUi9tL0s4?=
 =?utf-8?B?K1lhcnMvazNsbDU5MklieERrcU5KRkdpTldxSkdaVGJlTVdYcURuTmtoZExj?=
 =?utf-8?B?WjlRNm9Kb1dRRVZVQnhYeXYyOFRqZlVvbUxPaGpEV2pveTNyMlovZTNNbE1D?=
 =?utf-8?B?OXcwZW1wWFVxSlA1anVqQk50R3pZQnYwR0hMaXR6ZmtHNHNhTnNONkhzeHlq?=
 =?utf-8?B?Uy8vM1IwUjcyQlNkVHVSTHQyNmVockdYeFNjK0xpZ05HNjJjTFlkK0kxMDJL?=
 =?utf-8?B?TEUxTEpqakJUbTErb3BrQTVxVjJpbG1reEUyYkpVU2J4TEE0Wk1JVkI2MnAz?=
 =?utf-8?B?b29XYXg0bklJUS96NDdJWUNVUGRUREl2ZDlJSFlTZHBEYmhINktSMmNHbk5O?=
 =?utf-8?B?NXNHUU9Mbld2RE5MRjdQVGdxS3JRTVIycm1yL3l4NDJEZXkrUG5Qbjg1N09D?=
 =?utf-8?Q?jkaihi/HtGMd26Jk9l0nJoBg+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc0170f-88bb-41a3-253d-08ddd21d55f8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2025 23:35:59.6916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8tkLEJTwsYW0n/udKnr6EXF38xhOsk7E+Mvf2Hqx7L6nG7ejh+VeF+h38pUBqonlpzGbTjxbxjNalG82LiUPWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9188

On 7/31/25 9:01 AM, Muhammad Usama Anjum wrote:
...
> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
> index c3b6d2604b1e4..8d17036d88396 100644
> --- a/tools/testing/selftests/kselftest.h
> +++ b/tools/testing/selftests/kselftest.h
> @@ -92,6 +92,10 @@
>  #endif
>  #define __printf(a, b)   __attribute__((format(printf, a, b)))
>  
> +#ifndef __unused
> +#define __unused         __attribute__((__unused__))
> +#endif

Hi Muhammad,

In case you're interested in going slightly deeper on this:

Entertainingly, there are several kselftest dirs that also use this
attribute directly, and I quite enjoyed seeing that the *same* attribute
is now defined as:

    __maybe_unused
    __always_unused
    __unused         # from your patch here

$ git grep -n  '__attribute__((__unused__))'
bpf/prog_tests/sockmap_helpers.h:11:#define __always_unused     __attribute__((__unused__))
landlock/audit.h:28:#define __maybe_unused __attribute__((__unused__))
landlock/common.h:26:#define __maybe_unused __attribute__((__unused__))
mm/pkey-helpers.h:88:# define __maybe_unused __attribute__((__unused__))
mm/protection_keys.c:1307:      __attribute__((__unused__)) int peek_result;
net/ovpn/ovpn-cli.c:37:#define __always_unused __attribute__((__unused__))
perf_events/watermark_signal.c:20:#define __maybe_unused __attribute__((__unused__))



thanks,
-- 
John Hubbard


