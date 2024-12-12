Return-Path: <linux-kselftest+bounces-23267-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C44B9EF39D
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 18:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759AA16D0E9
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 16:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A0123E6DA;
	Thu, 12 Dec 2024 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kDH6YkVl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCD6217656;
	Thu, 12 Dec 2024 16:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021453; cv=fail; b=XgwAiRKVa9c+aTkJQnXfkAOd0iyQ+m3AdiFxC5C+wDwNzmmhz7HXuS31XP8De1vq1ak7CaC8PYGIkfrjJkuXJOaYw3lWO+JJ44hCK3aRPOM16HqPObWZdbebqjxDkJOtr4huPqUKTydM9Ui6j3QTwWsTWN4kXiZ77w8O9yckcnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021453; c=relaxed/simple;
	bh=CXMhf7jynSWtqHl7dDEsDz+bYur9/D2Bf3yDOcb3gQU=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=taLzNRgjI70XdgBUjE1EdrboqsAp4q5csX8KzlSZCCnq5PuOi+bv+b5YV1PAjxSiK1oF0a02r6Nf0Vm72qdEVTburnXcJwjbkR8ELHMdWA3C912UWUwiR/wBcLuIhSUx9SeA+T7Yy5X5o+GvScFWXDOFmCV8MFbsjmy2fC6PPIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kDH6YkVl; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tgv1GpLtAXr0rwL9I9eME3DTYQHGJS/5TFIR9jU17M85i1TomnOvFVXz+qG33JjaiHiYCyBqZjcEHgxoyFLXBRPu2W4MUSnaRV3Vdf2nwHJ7zy4cdsj7NHM5AeLnDJTmjXqg0ZPf4ZZp1D+Ct1x2vky/nCr7AnQfh9HS/HOIqagM6YU3JLBnUAhBfjN6bmFWnYnaZDPV2nFOB6EPSjJIpi22jVEA7zde/+tzHf2oWweSNPVunfXBv6MelFbSOED/bvQCwQrx/4CVVPSY7D7kVj1zfK/HXNFnkp9lMOxe2Md+HCw937Nx2T1YjASGfiLTc31G5cD7Vd9HNiMvyhwLPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xL6N/IsNSgItq6JP7EPLeq4D4vEHkFhxdelCqG+nfM8=;
 b=gceRanTMs7dDBzQv+OWgEZlHyyNiZjJiNSQrLImxXj8CkOV/zyPP1fKgSfBy/zkYFVj3zBnaS2SV3FtB2RaVUFrRl91UgKe2zKAzy6hY7b/jEup478MGkNmgV2AaFJStqB+1sWIOJUEECirUX3yPK5wo8GJICgAOI23vWFlnGHw2BBFUWk3Vje7XQ4CBrcVwCrWEt65x/ufh/805M/jAz+j/bJX1Kyz5hBJV9qXMSbTNcK8f9kySJwPrx8IUShU6i/vAULi9VyM/IxsmiWvgeil7n2UddTQa0kNsw9vt9rj2A0m1UfeKXeIRYCN+WCKJ7fxgua9+K1O3yOlC1zzsEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xL6N/IsNSgItq6JP7EPLeq4D4vEHkFhxdelCqG+nfM8=;
 b=kDH6YkVlIb3j3wPEECp4Md8kgLHcW5lvTn53N2drBB5BwtWhuHR/zP9EpeN9QTlMjeNJoYD8lZoNge+xuEkrNU9ns15FcjIXLJgW6i7d/M+znOVNJOHx+qD7xtA6ivSA5gVqZjhh4P1PndzKUQdSKm79IooCipgV1jhKvIYL32E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 16:37:27 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%4]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 16:37:23 +0000
Message-ID: <dc3a3dc9-c6d6-449d-a1ec-d6c6879eb8db@amd.com>
Date: Thu, 12 Dec 2024 22:07:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Add support for the Idle HLT intercept feature
From: Manali Shukla <manali.shukla@amd.com>
To: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 babu.moger@amd.com
References: <20241022054810.23369-1-manali.shukla@amd.com>
 <5331cf45-230d-4d27-abc9-e5d92e5a6c11@amd.com>
Content-Language: en-US
In-Reply-To: <5331cf45-230d-4d27-abc9-e5d92e5a6c11@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2P287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::19) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|CH0PR12MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: af467de5-5453-4a16-9495-08dd1acb4131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWhMVHI4SDI1TkwyZisvUjNRRGk5bml3eUxaQ3VxSk9DY1EwMUVBV1ZEaEd1?=
 =?utf-8?B?blRPVjFhMEtqMVE3SzUweFFHTlFBTU4vc2ZRTE9CRTlzN3VBZERvc1RKWEM3?=
 =?utf-8?B?Y0puektJRlp5SUxwNUV6MkdnSzVvdktDVlZoWlpsNkZ0a3RmdnRsK1ZtN2Z2?=
 =?utf-8?B?T0s1TDJtOFdRWEVGdUV1MWw4VmxHenpoUU96UlBsZ25WOTc0ak5HNXhTdWwr?=
 =?utf-8?B?NHBhN25ZY3B4cVhrb1pQSEVoUjhHQUJpeVpLOU0wdS9IZS9xbjhHcVl0MHpv?=
 =?utf-8?B?VndCOCtqUVBRWktWNUVtYmVONmJqVDByRThFQ2JHczVtNWVNOGMxMHJQUzNX?=
 =?utf-8?B?enhkeEl2SW9IM2g3Yk9NWTdmMG93RGFwNUlKTHBDMlVZOFVNRkc2YVhGbXBi?=
 =?utf-8?B?WDVMeXpNUGxGVmlJL0d1VjJhVi9HVE1CMnJDcGJjRkFlNjIyZ2x3NjZnYjhl?=
 =?utf-8?B?TUU0Q2lxdUtIbzBkeWhGWWRkdG5YWDQ2Q05OVTBMT3RmdXk1eWFBc3VVZ3Fl?=
 =?utf-8?B?NUtmUlc2ZmIxdjkvNGRIcFBCTXVPdW5Db0U3TDVJa3hLVjNxak5jcFJqOXhk?=
 =?utf-8?B?VVl2ZDI2Vy9OMUVLSUdZZTlmMzNzVlZtam5HUGZJTFBCeVU1UVR5enlSYWNS?=
 =?utf-8?B?ZXRSWUMxR3BNOFZkYTZYbkhlZHR0MHJTMXpvRWU5bFRVNWxJZUNNY3lQSWZU?=
 =?utf-8?B?bFNuK0N6VkxPcENpUC85WS8vT2FjQUI0OGRRZVlQTWtKazhLK3QvRW5wQlFO?=
 =?utf-8?B?K01oemx5V2NxN1hDSS9abmljZk5ieFFSdEhDK205VTFJY3lzN3g5a3M4b3FK?=
 =?utf-8?B?UFQvY3dxOFdJSXd1bDBCMFlTUEZWSmhPWVlIZ0FKSzJuQStRRHBZT2IrUDVa?=
 =?utf-8?B?QnZSSGFCQ3FMY1psVVpoQVNhU2lSKzE4WTR5M3BuL2JxaDNYVHd0L1NodGF5?=
 =?utf-8?B?Vk9xZ2RJRm5iRGhDVVBVOElHb2p6ZjBQOHF0a0NzVGNRR2gzdjJLcUVaaFBV?=
 =?utf-8?B?YnRMUzZ4aHV3SEJpNFZPaG5vcVpHZk5vcUlGTE93WEN2THp1Y3dSYkp5cFI3?=
 =?utf-8?B?MGxKeEdUV09UT3pyckhkejRaellLU2dsQk8xNG9teDZlM1B6bTVkMytRMXRn?=
 =?utf-8?B?WjFHYkNBQ09EaE9JbUlkQWQ1dHM2NmJ0RFJ6MjJmSEFHSFNDTjZKUWxBN096?=
 =?utf-8?B?b1IxeG9qb1RlS2VqUjgwVGV3VUF3dlExNHBoL09kNFRIL1VqUmZtTjROeURO?=
 =?utf-8?B?cWIwMW1BRThIUExNRytjb0NFTEQ0WFkzQlpKQXZleFVuZWhEakJEa3hIR1RZ?=
 =?utf-8?B?YjdOTG0wN1lUdHFxTFUwejlQNVliT2c3Z1JpWGdIRTJLZmszT0ZORWNBMEZ1?=
 =?utf-8?B?Qm9mMHFjbGpXZW9SV1haWTlYeXpUc3lCZzBYSDNTZC9WYTJCT2UyT1A3Q1Fw?=
 =?utf-8?B?eW1GU1pPNmNkcFVkSGtxQ043OC9Gd2k0Z2VlUlBBU3pJN2tsVGxuaW8zaktp?=
 =?utf-8?B?SXVZOXBuUTdOWWpLbzUxSHpLRW9Jd0l4cXhxL2dnVHdLTVJ0Yzc2THRybEVs?=
 =?utf-8?B?Rk5FRjNHUjVtMy9YNDNIWlZyNVYzU3A2czBaQ25NbjRoUUp2R1BKK1ltMExS?=
 =?utf-8?B?T0loV1lib0h5bmdOZUdnb1hKNHhFRkxZaWJ6b29SMzAyZGYxV3R3TEc3V05a?=
 =?utf-8?B?dnJQVElTY2dvalh2cHVDaFllWFovME5LS2xjbnBPcTFZK1AxR2FYVnJQRUtK?=
 =?utf-8?Q?tllU2yl4aFx27bioeaRxIh3lPILvBkW2jCQKetB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elNqSzlIZGpUbzdraWhYU0l2eVRJUlFTdlMwcitSVitTVlRkUGN5VTh4SzNE?=
 =?utf-8?B?WFkyVEZWaVRFR0ZQWC9IRFBzUjhRbVQ4S2ZXZ0xTNzlxQjBaMDZ0K3YxcTdL?=
 =?utf-8?B?N2MrV0hxK1h0aG5ldVVSV0VnSWVLRHRNN3hvTTIyWHlZc0JkUjNiZDJocGEz?=
 =?utf-8?B?RGRiZmFEVGNWQzRRU1hXbmxqSitSalcwQXFzUEZzZk1aUHQraUxEK3ZyeUxW?=
 =?utf-8?B?MWtoWWlCR2Vvd0dEdG8vbE9YY3NsTVlXWno2ZDhCcFFTbzFDc1NxeHVVSWIy?=
 =?utf-8?B?VjJOTG1iR2crR0hkdUFJZ2ZObWlOcnMzdDlsUlcxam94TmlkN2wyeEpqT284?=
 =?utf-8?B?cm15NGRMUTN6RFFBWEt2ZU1waDJVRlRtTFNwSzZIV3pNenNtc0MxV3VxelNL?=
 =?utf-8?B?clNBdU0wRXgzVWVrRytWaEhVSGk5ajhpNW5uWWJpVWhWUkFWZGtrUjlTYmRv?=
 =?utf-8?B?UDE0V3czVE5xTEoyYnUwVzBOV3Q3bHdld3NweGpVZlV4Z1IwQlhHTkJRMi8v?=
 =?utf-8?B?a2FxWDBoa2FCS2NyNUpjZjhudGs2WldYd0xycXYvSUtSSnpzYS9raXhNRG5p?=
 =?utf-8?B?b0c3b2lUenZJK3hEZm9vdW9OcDJSMGZ3dG5TNkFnM3FWOGtqd3E2WVg2bnJD?=
 =?utf-8?B?azl0YmVRTFZ6RWllMXFYQ2VlWEdIbmk5OG9aTjNaNnNUU3pVVkgxdVhhVDhO?=
 =?utf-8?B?UktXOUx2ZzJYVjJISTRacWVOcGhkekRabmpzOTFsL09GZ1RXMThJZnRkR1ZR?=
 =?utf-8?B?dy9nYzJzZElWSThTZE9Xdm5ZNzk2N010eWJ1TWJVdEM5Wlk4T3JoYTQycWMy?=
 =?utf-8?B?ZXJNUEpFN0NmN1ZKSFpPTEU0T1FxckRZZXlYRkI1a3A5bFBXMVpLOWNSTCtI?=
 =?utf-8?B?MXhoVjJhQjlKZzRYU3dleVpaTUJ5M3FtRFdBVVp0SmRzdWtFWW5tWXR3V0lU?=
 =?utf-8?B?WHRCcXhNekNyRjU1UWxXbGNSajdYWHRMY1d3di9NUk9DcFdGSE93NmtmWnI2?=
 =?utf-8?B?eGg4c0dreUxWeThhbklIM0lHbW1Bb3hxY2c0THdOeTMxR3hMNm80WlN5aWlj?=
 =?utf-8?B?emNIWUowVHVSRGkxSWZjUXlONEs1M1BBOXFIczhwcXdvWDlYWWxERm0wejVS?=
 =?utf-8?B?K0NocmtIVkFwTFRPUlphUHBEWEdMTnArWU5QYXJBY1JGMXVkQ0psMnoyMktL?=
 =?utf-8?B?YWpiSzFGN282aVNxNUMzUk5Na1Y2eUZWK052eTh1NnBMbFBTMUZjelNuNXA0?=
 =?utf-8?B?ZVFCV3JVN3JyTHlaT0pWdGpJRG1tZ2ZObk9XTVRhOTJtT0JGYUN1RkhWSlBw?=
 =?utf-8?B?NXlCbFhpYUxoSkhsMU1zSWFSN21SMDhTOXErc3MzaFQwdTg4SWtYcE56M2p0?=
 =?utf-8?B?S3djZ2JrNlpuZHl1T1QwYkF2eTBscGFjWm5qTkRFY0VId1FHZHpBQmpFKytw?=
 =?utf-8?B?ZG1CeWd1N0pPbFVWUWhvK3EvcWZVbW9oTDZ3NzMzQ0phU1h6YW11WlZOOW55?=
 =?utf-8?B?Vno2clpxdzMrWTZxa2dJLzczaFMyektLeGpXc1RkUkxBYytNKzNRZlpOOUc5?=
 =?utf-8?B?VXFmRjBza1Qvb1lGWDFpYlczdmtscjFJZytNYjk1RUgxNEQ5TFhONlV3SEIw?=
 =?utf-8?B?YW5rUUprdll6R1BzLy9uVGh1T1FFdnl5bDVWWnZrNVNXcTY1SldRV2ZlZHlW?=
 =?utf-8?B?cTJBVzRhNVhhM3ZzZVlZWThKZE9XOER6Y2hoZnpXbzFqdW16TCtvYmRlUnFX?=
 =?utf-8?B?bGRKSWlmRlJHd0xkWjl5bHJSblBvc0hSS0VzcGxVWnlwSFhibWY0VFk4dkhG?=
 =?utf-8?B?dU5tbkZSeVoyaDhVMFhuaklaV3VnMm5yakZ0Uzg3cXZoVDN3VTg1S1BvZERD?=
 =?utf-8?B?OFR0TDFKNW1hS0FyN05aUWxLRTBiVlRQMjVaV1ZDaWxLT1puaHR5WTBMc1Fw?=
 =?utf-8?B?aXlQZzRsMnZxL3Z5SHZyOUttdklRVVlZdERiYTEvTXJYMUdjS0NJV3FkUlpD?=
 =?utf-8?B?eWRyQllwNTV0dGpibTdzL0d4Q2xsTEJaNkFsUDJTL2oyeFdzTjAwbjZPQUpt?=
 =?utf-8?B?VGY5Y0dpMGQwbEVaL2RXVE5FKzJyNmN5bktOVHhtbXQrUEM4TnZEdDM3V3dK?=
 =?utf-8?Q?iwrQSwm32hJRbA3wS/h9cghrl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af467de5-5453-4a16-9495-08dd1acb4131
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 16:37:23.5306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eCtsv1ns6GuoT07EowzcLL4H8A7q2lcDlZ3ivhNG3b/72FF/4bL4hiedLRSjRYzrEwNEO1qb+J+oPDMF9jrSMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488

On 11/28/2024 8:39 PM, Manali Shukla wrote:
> On 10/22/2024 11:18 AM, Manali Shukla wrote:
>> The upcoming new Idle HLT Intercept feature allows for the HLT
>> instruction execution by a vCPU to be intercepted by the hypervisor
>> only if there are no pending V_INTR and V_NMI events for the vCPU.
>> When the vCPU is expected to service the pending V_INTR and V_NMI
>> events, the Idle HLT intercept won’t trigger. The feature allows the
>> hypervisor to determine if the vCPU is actually idle and reduces
>> wasteful VMEXITs.
>>
>> The idle HLT intercept feature is used for enlightened guests who wish
>> to securely handle the events. When an enlightened guest does a HLT
>> while an interrupt is pending, hypervisor will not have a way to
>> figure out whether the guest needs to be re-entered or not. The Idle
>> HLT intercept feature allows the HLT execution only if there are no
>> pending V_INTR and V_NMI events.
>>
>> Presence of the Idle HLT Intercept feature is indicated via CPUID
>> function Fn8000_000A_EDX[30].
>>
>> Document for the Idle HLT intercept feature is available at [1].
>>
>> This series is based on kvm-next/next (64dbb3a771a1) + [2].
>>
>> Experiments done:
>> ----------------
>>
>> kvm_amd.avic is set to '0' for this experiment.
>>
>> The below numbers represent the average of 10 runs.
>>
>> Normal guest (L1)
>> The below netperf command was run on the guest with smp = 1 (pinned).
>>
>> netperf -H <host ip> -t TCP_RR -l 60
>> ----------------------------------------------------------------
>> |with Idle HLT(transactions/Sec)|w/o Idle HLT(transactions/Sec)|
>> ----------------------------------------------------------------
>> |         25645.7136            |        25773.2796            |
>> ----------------------------------------------------------------
>>
>> Number of transactions/sec with and without idle HLT intercept feature
>> are almost same.
>>
>> Nested guest (L2)
>> The below netperf command was run on L2 guest with smp = 1 (pinned).
>>
>> netperf -H <host ip> -t TCP_RR -l 60
>> ----------------------------------------------------------------
>> |with Idle HLT(transactions/Sec)|w/o Idle HLT(transactions/Sec)|
>> ----------------------------------------------------------------
>> |          5655.4468            |          5755.2189           |
>> ----------------------------------------------------------------
>>
>> Number of transactions/sec with and without idle HLT intercept feature
>> are almost same.
>>
>> Testing Done:
>> - Tested the functionality for the Idle HLT intercept feature
>>   using selftest svm_idle_hlt_test.
>> - Tested SEV and SEV-ES guest for the Idle HLT intercept functionality.
>> - Tested the Idle HLT intercept functionality on nested guest.
>>
>> v3 -> v4
>> - Drop the patches to add vcpu_get_stat() into a new series [2].
>> - Added nested Idle HLT intercept support.
>>
>> v2 -> v3
>> - Incorporated Andrew's suggestion to structure vcpu_stat_types in
>>   a way that each architecture can share the generic types and also
>>   provide its own.
>>
>> v1 -> v2
>> - Done changes in svm_idle_hlt_test based on the review comments from Sean.
>> - Added an enum based approach to get binary stats in vcpu_get_stat() which
>>   doesn't use string to get stat data based on the comments from Sean.
>> - Added self_halt() and cli() helpers based on the comments from Sean.
>>
>> [1]: AMD64 Architecture Programmer's Manual Pub. 24593, April 2024,
>>      Vol 2, 15.9 Instruction Intercepts (Table 15-7: IDLE_HLT).
>>      https://bugzilla.kernel.org/attachment.cgi?id=306250
>>
>> [2]: https://lore.kernel.org/kvm/20241021062226.108657-1-manali.shukla@amd.com/T/#t
>>
>> Manali Shukla (4):
>>   x86/cpufeatures: Add CPUID feature bit for Idle HLT intercept
>>   KVM: SVM: Add Idle HLT intercept support
>>   KVM: nSVM: implement the nested idle halt intercept
>>   KVM: selftests: KVM: SVM: Add Idle HLT intercept test
>>
>>  arch/x86/include/asm/cpufeatures.h            |  1 +
>>  arch/x86/include/asm/svm.h                    |  1 +
>>  arch/x86/include/uapi/asm/svm.h               |  2 +
>>  arch/x86/kvm/governed_features.h              |  1 +
>>  arch/x86/kvm/svm/nested.c                     |  7 ++
>>  arch/x86/kvm/svm/svm.c                        | 15 +++-
>>  tools/testing/selftests/kvm/Makefile          |  1 +
>>  .../selftests/kvm/include/x86_64/processor.h  |  1 +
>>  .../selftests/kvm/x86_64/svm_idle_hlt_test.c  | 89 +++++++++++++++++++
>>  9 files changed, 115 insertions(+), 3 deletions(-)
>>  create mode 100644 tools/testing/selftests/kvm/x86_64/svm_idle_hlt_test.c
>>
>>
>> base-commit: c8d430db8eec7d4fd13a6bea27b7086a54eda6da
>> prerequisite-patch-id: ca912571db5c004f77b70843b8dd35517ff1267f
>> prerequisite-patch-id: 164ea3b4346f9e04bc69819278d20f5e1b5df5ed
>> prerequisite-patch-id: 90d870f426ebc2cec43c0dd89b701ee998385455
>> prerequisite-patch-id: 45812b799c517a4521782a1fdbcda881237e1eda
> 
> A gentle reminder.
> 
> -Manali

A Gentle reminder.

-Manali


