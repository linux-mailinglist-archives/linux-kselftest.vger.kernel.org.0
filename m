Return-Path: <linux-kselftest+bounces-15350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BEC9522EC
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 21:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E0991F26802
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 19:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637011BF310;
	Wed, 14 Aug 2024 19:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H/jdf7q7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WCzhXCB1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7B21AED23;
	Wed, 14 Aug 2024 19:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723665374; cv=fail; b=DfmdvOj4LY3JMRUnYvM+CXsQkKrHrGr1YW89o2d3pUyEpCxNlmxFlyimFIXci6MFnQ6o31K5Z3u1+pThLvKhNBd4W3DiblWPe+U9RkL719s6vbfFbPs0vu4UWE7p/uRxOgKtipoLBV6NY6TKqfctbDKuv05ENDyn6zPD4bzgPRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723665374; c=relaxed/simple;
	bh=yq7aaTRFC3hLtfpMLkU/L3NhhzLEyIJgxCVKTsPOEKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mIlPTViMqnXNZ95GdZYld7qzpGdUF+zUBqvYKOzrm6+rozuPe35g7RnP1XFhRdPISDFgqVi/+Dk3ab98rYyVwlylwCeX110KEvIj1A8eIPdYy3VZeApovks1tYwJEHMbsrMhUGeyYeJeS1ThS/QHYDWHbPorh9bUxrZ62IBwwpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H/jdf7q7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WCzhXCB1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EIYdnN028335;
	Wed, 14 Aug 2024 19:55:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=ZHKdbL+kmW//SPJ/8MfNcR00potmnc+URCvxzfOLbRI=; b=
	H/jdf7q7KlLhmeGZOdR5XVuoaWwkP/LEVJNGY+DkCEarej5EwbVCPRGVPdtUo+lF
	/xUT6wP9E6eQyxv6O9kRTphPBMJbMIwKHHYGtJYYjE9aJ0xeeZA+1gMNOySNqNRd
	901RkqYVAolF4KJ07D7bOTOOF/nefhOqp8tnzpzrRfsMQrlk0r1NRpjkmy6yOhix
	k9hra8JuipR/OiqFO0B6Dt6RAEBGFUhm+61mrkHmuVucd4NVAkBEjJHu0vsPlxmK
	gbUTLsLlH+WIUHi9Sa1A7rsetuYMg7DacDs40+Qtz2S80pI3UAHosiIPElR509ts
	q2VTteSr22H8PPunsJcSAg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wxt118b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 19:55:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47EILN0h000679;
	Wed, 14 Aug 2024 19:55:50 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxnaaavu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 19:55:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+Sq793O3sFU2vjIzw06HjDcO7wBAhuWeRaPXfH+3JEmeRwcE8y+CaVhJZmjq1yHKXyFb+xrSs9pup7+foSjoD4oS1lgSk+LHnA6RU7N3WZR03n8/joE+If1vM+qaX45wIatRL3x276n0/LYEr9OIdcPegkKVHjiFaA33e8feVPP4YYyDw+YTpVFsuWsFp9ekzsNAhV+ieGmMemkm4Z4zHZVXZvoVGIjD2mO9Bd5T/sS30kkXZAzwbvQx9kC9S8eyncyxCGEPeSxbKfnLblM0OtGcRQxTkhOZAd1+f/D0dyb6WAcLWDNne9hCZKFrfQfe2GqJLbl0EL+Rl3421242Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHKdbL+kmW//SPJ/8MfNcR00potmnc+URCvxzfOLbRI=;
 b=QImtglZvjJxeuvQc9Z/lMpPPYQon6bF0DpwYxyFrZoE+BmBEkO+p9+7bNjvoxrradmvCh4YE6vq4+vEbonkH3JWf3gq63XNxzfwaZdQtW5y4CDAWnx0e63uLHlWMRFSy+aWPmWP7nCbe8e6lDe4td1FNco1SVr3c4P04d1mFAf+kUn5psuwA2evQxLoIKCxQTc+y0XXsfzvpFvUB/Kg0KC70E+Ra5dUttLaLxmaWYQDwEJ2yfw0bFCQU2C311Gks1ZzrUC6jvIJ3Ncof6J07ND9wDhsWcA3L+RnaChSjvSPMUpjM2W1J19M/k6QL8XYZdfufQTS293xRyZ3f6LUIZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHKdbL+kmW//SPJ/8MfNcR00potmnc+URCvxzfOLbRI=;
 b=WCzhXCB1gf3MY/P4p9OBwB6sENRjJaRFMknr9aN/Kc/FUQa74O7lGKlDGULkYbfZukPx2sDyNLZt8cyKGVYwW2fhJ7hOCmWzGW8KVos2s14cL7a6yW30Ve33NV1lOKRTB9/6CJiGvNK8yrR8JWe5ps2jNOw80onEzwa7a38fKD0=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB5894.namprd10.prod.outlook.com (2603:10b6:510:14b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Wed, 14 Aug
 2024 19:55:47 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 19:55:47 +0000
Date: Wed, 14 Aug 2024 15:55:44 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: akpm@linux-foundation.org, willy@infradead.org,
        torvalds@linux-foundation.org, pedro.falcato@gmail.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org, jeffxu@google.com,
        lorenzo.stoakes@oracle.com, mpe@ellerman.id.au, oliver.sang@intel.com,
        vbabka@suse.cz, keescook@chromium.org
Subject: Re: [PATCH v1 0/2] mremap refactor: check src address for vma
 boundaries first.
Message-ID: <mlwues5aus4uie52zi2yi6nwlaopm2zpe4qtrnki7254qlggwl@cqd42ekhrxez>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org, willy@infradead.org, 
	torvalds@linux-foundation.org, pedro.falcato@gmail.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	jeffxu@google.com, lorenzo.stoakes@oracle.com, mpe@ellerman.id.au, 
	oliver.sang@intel.com, vbabka@suse.cz, keescook@chromium.org
References: <20240814071424.2655666-1-jeffxu@chromium.org>
 <slrsrycj73xrph5o2poicpt4cogpqw36bbwi5iqykvyce4pve3@suldmmv2mmo5>
 <CABi2SkV2LcrkYOGzkGm80eYw-mhPNN=Q=P3aKGm0j8_gAwXjog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABi2SkV2LcrkYOGzkGm80eYw-mhPNN=Q=P3aKGm0j8_gAwXjog@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0225.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::13) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: 8932c810-ccbd-4686-1653-08dcbc9b16fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDBKTzk0R0ducjZWV1RrbnBWSEpqOWpLbnE3Q2tDMitZaVhkTGhmc2YrN0VM?=
 =?utf-8?B?UUNaeEJPNVFka0NSbmFWREZhVE00SHlNS2d2Q2xOYTlxd0ZqZ0tGcENnV3Fn?=
 =?utf-8?B?ckJ1YkovSHd5dnUyTWtvLzRHMTN2UERKZ1Zob3JyU3hScDkvc2NKYUR3NFMx?=
 =?utf-8?B?dm94R28zanFLNlhud0ZqZWNGY3JiRmZPeXJweWdjY296RUhKajdKcVZwa0pp?=
 =?utf-8?B?ejUwT3BHL3BESFpVL3JZK2R4Sk9lNHM3bHh6UkFkUDZUQlFITzcwSEJCeUJM?=
 =?utf-8?B?ckx0dTRNM2Y3S3l5KzdsdWM1TUIvK0xBelNjTmNqWWxjR044WGVuN0Vic1Fa?=
 =?utf-8?B?YXpSTmhVckZGMHlGaStFc0lsd3FSZ2o2V29WMFc2enUrRnpuNm9HN3p5K0pH?=
 =?utf-8?B?QzcxZVJWTnZGY2Nld1VXN0xhSUQxRk52NDhYQWVJbW44a0x6MVh6TCtTa1JM?=
 =?utf-8?B?c3FYblMyeDI3b2g0bGVsUnV6TVhqa0htRXFOeTVhR25vNU9XN3RUQkNFeXAy?=
 =?utf-8?B?MmJVSklzeUsyREMycVV3dnEzODEwdzVtbzRjcW8yemZlZ2ZPUHhnckxqUlNz?=
 =?utf-8?B?THRtM2RHc3g1QjdpNjV5SENIYVpiTUlZN1Q5Q2xkUnhQRmN1Ylp1dEVkQVZ3?=
 =?utf-8?B?UlBvNU42RUp2K0xmRmF4OEhsRWp1SUpZUk54NG9hV3IySHFtWWtyNXZKL3dk?=
 =?utf-8?B?eGdyb2piODd5VngySVZwV0kxNnRTcEZpQW9LYkNMN2lPU0tLZG53UjcycjEv?=
 =?utf-8?B?WEVYbFBTZ1IrMTVaVVBnbkd1aXVGRWJ1SE55ZFFpQTFtNmkzS0VzUUdJNnFT?=
 =?utf-8?B?Y1NvYy85T2wwU1o3TGFaVjRNa1dYNGtjVG5vREMvWkplMUVUdHU5ZUVuRnI4?=
 =?utf-8?B?UENzWVpkcVpQbHF0MjIzd3plc0ZzbGxpZkoxWjltZ0J1VmZxb0h3OUIvUmhO?=
 =?utf-8?B?WGJDdzVTZXBvZDgvaTFzTHplZVBUYVphVm1rcURxMDdHZmNaYnZkdURrREJ0?=
 =?utf-8?B?Y0RoSVU2QjA2RllnWUd5eE1YUitmNFFrTjJ2QklreDJITjNFTjV5QTJzM3ZI?=
 =?utf-8?B?RmlrWkZxT2ovY3NRYVVhOWdqQzl0SG1wak9SbFV0QnU2d3hFYVoxRmFMSGo0?=
 =?utf-8?B?TTFVQWFiNTJRQzIzeWQ5YW52USs3WVV6d0VseW96TlErdCt4eTkwbzUzNWtZ?=
 =?utf-8?B?UVJieUJhaTR4SjJHRmUyejFtOENvVGJZZ284V2Fjd1NCdTVuU0tDVnZQUUFq?=
 =?utf-8?B?ZEthcnBXdGtaVWxKK1VpVGdETjZna2ZIQUhjaTA0QklSYmRFcXlzR244S0lm?=
 =?utf-8?B?Q0F5d21VVmxRb1Y1c1h2VWtCUEpkVTQ3eXFUVmVXdVFrOXBIeU9QcnljR3V0?=
 =?utf-8?B?ejB3SlZXcUlTQXhaaUVLZFNRVHRQbFU4VnJ2MnRFSG9uSEEvcExoSlNpcHM5?=
 =?utf-8?B?QjEzTmtPNnlkNkdvSzhYWVQ3OTlaRlM4U3hqQ1gzeVZhVUoxdUZYMFBKK2px?=
 =?utf-8?B?MmwrZkFwNDZNT2hPUFhqSFovR3NzRW1rZjlnVlZiNk9veTFITW54MTh4Qmh5?=
 =?utf-8?B?bEk4TVhhMC9jcFViZUJXemRZcVFRT1pXdFFrODdtcnpkU1pCV2RHd0lVSU5s?=
 =?utf-8?B?OHdzU3doTHozNE5zQjJZV2IvT0FtQXh3cTFUQlFTTFJocEg5TjBWNWhhSjBI?=
 =?utf-8?B?RnYyRzF1UVhueGZLQTRyQUhaSVY4VCtHRXN0ZXdyS2JheHR0WWRWSzlQa2JS?=
 =?utf-8?Q?MtxB19fGgm0DWX2f2g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2ExK0dDT0xMc1NsTkVFVHhabUhzcW9wZDR0ZEdQV1c5TzYyb1J4eFpkSGRs?=
 =?utf-8?B?Y3M0Q3RUdHcrZHRxb2FJRmVzQ3JCL3U0OEwyUldXTGpuU0w3NUx5RzR6ZEVa?=
 =?utf-8?B?WTJ6eFVsMytMOE5FVEJ5QlN2TWZPWkdyZUpacEFtTkREaTFiSFVwMGtHWlFX?=
 =?utf-8?B?aStCSVFBYmlrRXJvdW9JdmdRZlVpWXdUY0lQaStaaTAzYm4rWWlLQnZNMnBo?=
 =?utf-8?B?d1FER0d4SlNmTWxmcW5wZ2hTamt5MWpabW1vdWtoOU9YTlM2bDF2NzhvN0d0?=
 =?utf-8?B?M0FqcXdvc2I5aHpMNFU0SjlFMmp1dXZZMlA0Z3dmVnJnSVZ0c3JSQ01jc1pa?=
 =?utf-8?B?cGNEamord21DY2NHcDRPUFlmbUZEbzlLWGpRQkJvN3FQMiswNXRqSHBXOWdi?=
 =?utf-8?B?bnZkcjR3YnRBbkg3NzNlRStFVENNenlMNUdJQ1V2YlUvR1JHZE96QzRlZi9T?=
 =?utf-8?B?VCtnd09KNkUzM2ZmWVNJTkp1bktJRnVlSlo3WVQ1MnB6ZWc2bDJuVWZpWUlJ?=
 =?utf-8?B?U2hKbk9xQkprWk82ckU1ZitIb0w5em55bHRpZGhGa1NCQWJacXhOSmxOZjUx?=
 =?utf-8?B?cFdWNDViMzNYRU9EUGoyYU9ZTC9PRmx6SWdqTVl3UzEzbFFWNTk0dVZpczVw?=
 =?utf-8?B?NUtDWDdJMmZiQVpJSnlmQkZPdHpUdDFLalRiS05lRW1ZQkJDZEtRVVR5Qlls?=
 =?utf-8?B?cFlkR2pCanF6a1grT0hBKytidnRHQ3JKdmU2YmxnYXNycWVlT29oR0Vzd0lx?=
 =?utf-8?B?Rnk4RzJRclkwUUVtbXZOTnJNU2xZSnIrdzliUEhQei8yY0IvcXAwc1l0djBr?=
 =?utf-8?B?LzFla3IwbExFaS9mMk94U2JZRjNEdXBXanl1NzRvZnJibnhwOWdoT2NyR0Vk?=
 =?utf-8?B?SXg4RVB1TncwTkQ1cFlucXpaM2x0SEVBZFFRLy9KazFqNHNNVG02Rzdid0tT?=
 =?utf-8?B?WUlGbTFURFFGbm1MTStkdlR3UnIrL293ZXJJdHF0ZWZiVDZSeTMxaXZOQXZJ?=
 =?utf-8?B?TnMxU0tMY0Y3OVBGWXIrOThzZmZYc05Wb0hHUHBGWmkvK2V4NGU0VDRBMnJj?=
 =?utf-8?B?a0Q0OTFZcm95WUFnNW5QUllEMWkxdkRJbnZHVy9QbmpHNU9BMFBQbVBSZGFU?=
 =?utf-8?B?Si91cC8yNXhDY2d2TFdlYmZqMEVWUmU2ZEpDenJyaUdOanBvTmhZRU96QUFT?=
 =?utf-8?B?QVFQTFBSa0dFeVFHV1JRYTBQeU5hRi9GT3NQUVBSV0RVUnZCclcvWjk5aEFt?=
 =?utf-8?B?ZGFDT3pPYmRWa0N6aGd2RklRcnJaeG8rVlA4ZUd6MDJVcko0TnZlSmxibWFa?=
 =?utf-8?B?T2N1NHhmQjZQakJrZktoTG5Uck93bzljOGdIYkpMMXk2TGFGSmVQZTZ6Tmtr?=
 =?utf-8?B?ZzljM29wOTRZdDVYUGVvSTFQa0I5alRlcHJoaUs1Qy9sL3p5U0xSSnZNWkZU?=
 =?utf-8?B?YTVuUjBiNUdqRU9LdDBvaWhrWjJrUERiano2ZzBjQlF2Rkd5TWF2TWlyTFJ0?=
 =?utf-8?B?SXRFVWhKb0FZTWtBOHpteFFRMGhhSnAzbXFMVXg1QnJNTjBPS1JnTFhTdUxa?=
 =?utf-8?B?OXZyTktrZ1lVNURaUWFvZHJhN05wWXJjL0JSK1ZFYlNvOGtwdUhWaGhIQng5?=
 =?utf-8?B?MDh1SXhTNVVPUDgwTDNmKytmZVl3U2NIdXpSRGNyNVk1dEVRNC9CdXRxTWNk?=
 =?utf-8?B?WWdFcVBRSHZpbndiSFQ5Y1VKMCsxeS80OUtwZFMveE9YaCt0VSs2U1FET2pk?=
 =?utf-8?B?Wk5iU21hNWVWcFREY3FUaTNtaXhNUXk1cnVlT3J0MmV4RzJEWWI1eU9YQk4x?=
 =?utf-8?B?TVIveFNzWE1jTlcwNGp2NUZ2RG5kTjlKZm5GWFZWY296VmcwM3dqNHFiVnds?=
 =?utf-8?B?dTM5ZDdBbDBIMlQ4YWNWVDZ2aTZZbGJJVzNUU3ZjaURrd2w1a01tbUZSbUp0?=
 =?utf-8?B?bzBSTTByQU5qTElzNE1jQTdDU2VTTUxackRTaThyeEtOemZISFNueXdnRVZS?=
 =?utf-8?B?UmNKdXo1Wk9TYkU1OTh1L2R0S1pPQlZtNkxkQmZtbXRDV2dIQjlJTU5uSisv?=
 =?utf-8?B?NDBWZW5KNUxpMFdPdWRycFpYazM1TnlMd24zU3kxTlVvU1dscGRvRkZkVG5a?=
 =?utf-8?Q?N6S5CNiWBXUm6TjNgLnxIvF67?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gmsZbddyqB60cWFs/0ADASGtZSOwGwoUIMlqin32vCGU+88CUQAa4Z7nH8KtjZn+CgIoM7x0ENq15wMxX0Jx0mlP2b6vmhstlI7A/noBRGFUm5CT8/R/o3YQsEmZFV/fU22GUYyZWZtNq5GDG5fWBcTRXrA2c7egWLRjgouakGBQeWnq5APcPWAxHd9F7kX8e4cqq4H9ZMNx56KYzv3brbAdndvObJsoe6j+xgCaubmu5ZG+clrtQh1ySuT/b5t4d8G1ppxshx1EXX64k2sO6XQ/dPwe105NJ0OZB0CiwQ7VI54SJ+JLan/VSDZfTXsYvysSmt9pZUR1oncZIx8iv5mRAdyjcQkPQE0spG7XrgZfRPpYn7F6d7f1ikzyKTwh+x36sgs1JDeTRMwqFE1swUqz0pvN4sPIchle149LKrhZ+sGVQ5lvrToDOlNXvbdi08PlpNcmv0BdVpv1VYCmJCUxLPkwLX7aLAlhh5TCuUAH/tBPzj3yPEi/gKcwbo9zNrQ1hHWb3ZJdlGN23kFJNicR9F7SXCjjO1yp1Nqy0OlmPS9ZjWhKyq8zhj14qx9ZTGAnDSjcj4p7GQRc3yU6qDVhD8Em/BaKvNGe9Eflu8g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8932c810-ccbd-4686-1653-08dcbc9b16fc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 19:55:47.2967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G1gxYwGCs4kq8AvOsw+kJqF1UyWfDPxWF6dtEWxklkM/WgWSEsJ6I6J8LW5jFr5szCRPb8tNjihJPs7yZXucMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5894
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_16,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408140136
X-Proofpoint-GUID: EAJ5E4YxHIkGCjboydPmZo9Fk6t_rBbM
X-Proofpoint-ORIG-GUID: EAJ5E4YxHIkGCjboydPmZo9Fk6t_rBbM

* Jeff Xu <jeffxu@chromium.org> [240814 12:57]:
> On Wed, Aug 14, 2024 at 7:40=E2=80=AFAM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > * jeffxu@chromium.org <jeffxu@chromium.org> [240814 03:14]:
> > > From: Jeff Xu <jeffxu@chromium.org>
> > >
> > > mremap doesn't allow relocate, expand, shrink across VMA boundaries,
> > > refactor the code to check src address range before doing anything on
> > > the destination, i.e. destination won't be unmapped, if src address
> > > failed the boundaries check.
> > >
> > > This also allows us to remove can_modify_mm from mremap.c, since
> > > the src address must be single VMA, can_modify_vma is used.
> >
> > I don't think sending out a separate patch to address the same thing as
> > the patch you said you were testing [1] is the correct approach.  You
> > had already sent suggestions on mremap changes - why send this patch se=
t
> > instead of making another suggestion?
> >
> As indicated in the cover letter, this patch aims to improve mremap
> performance while preserving existing mseal's semantics.

They are not worth preserving.

> And this
> patch can go in-dependantly regardless of in-loop out-loop discussion.

No, it conflicts with the other mremap patch as it changes the same
code - in a very similar way.

>=20
> [1] link in your email is broken, but I assume you meant Pedro's V1/V2
> of in-loop change.

Yes, the email where you delayed discussing the fix so that you could
test it.  Which brings up the question you didn't answer and deleted:
Does your testing pass on those patches?

> In-loop change has a semantic/regression risk to
> mseal, and will take longer time to review/test/prove and bake.

There are no uses, so the risk is minimal.

> We can leave in-loop discussion in Pedro's thread,

No, it is directly linked to these patches as this should have just been
a comment on a patch in that series.

> I hope the V3 of
> Pedro's patch adds more testing coverage and addresses existing
> comments in V2.

The majority of the comments to V2 are mine, you only told us that
splitting a sealed vma is wrong (after I asked you directly to answer)
and then you made a comment about testing of the patch set. Besides the
direct responses to me, your comment was "wait for me to test".

You are holding us hostage by asking for more testing but not sharing
what is and is not valid for mseal() - or even answering questions on
tests you run.  Splitting a vma doesn't change the memory, but that's
not allowed for some reason.

These patches should be rejected in favour of fixing the feature like it
should have been written in the first place.  Anything less is just to
simplify backports and avoiding testing - "avoiding the business logic".

Liam

[1] https://lore.kernel.org/all/CALmYWFvURJBgyFw7x5qrL4CqoZjy92NeFAS750XaLx=
O7o7Cv9A@mail.gmail.com/

