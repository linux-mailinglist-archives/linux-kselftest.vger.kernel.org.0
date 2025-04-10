Return-Path: <linux-kselftest+bounces-30490-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F390FA84BAD
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 19:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89CE189C66D
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 17:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9220428C5C7;
	Thu, 10 Apr 2025 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XcYTiKhn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rsu7YLIZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E077B28541F;
	Thu, 10 Apr 2025 17:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744307533; cv=fail; b=mOGUPRH/7NZEvkhMCcKdYxyPtXWFBWdEZfDuDyceAHnN4RGusNssG+m+Al8oUFy8lRA6jDKLKDmPZ1o0fA+KKkJlD/wbnn83egymzpMF9d9Z/+8U1f8Iosa9hg2RKrnjQjlsOliv9lG+rZTWFoznEwLdvY3FYqjgcwJfNKPEv/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744307533; c=relaxed/simple;
	bh=uBAtWGS524KwwaXCFkN+skHZKp5qlWVAHIO3oRnkfGg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T1pBTwp7YESxcJJZScU705eb6Kqq3qrmvQuyxUK7Qyh2F0jp5zXCoWf05wBUCVTGxvR3LHPqORO2DJuLLwZZp+FIGrJ3NzcV3lo8B6fLzBVDksgR8iP5BjSi9DJN3Y5ogm6ofvGPkfgUOTgDNI5411StMc/FnaeQe7tA78Ne3qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XcYTiKhn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rsu7YLIZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AHC2GL002960;
	Thu, 10 Apr 2025 17:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=dwYMmYBGcRdrsU5XQ+hAL+JBZw/kI8UKZxF4m6ObHrs=; b=
	XcYTiKhni323uJRl6rUShi7o8aDPhb0yGMijmwh3QlFh7t9TJIKw6wlzI3w12Icd
	qeE71wD1m+CbNsAQkqqsHMw85bu2LCHvvPNI1RRlfjd+aNuDKahYMPKbtrc3zlql
	SzKynnaUKM5ezG50WTm5hxTJqbz50xBgh9cBM9dXGdyn0D1NgAxjScp09HW5NuLe
	hUdfZzkN684h4pY+LxpEaZa8HYp0laVm3CQoqN3epRGEk/tgj9jurWdcJJP/8/Ct
	wRuRhfnyFFmlWizMgsUfiSIIP5/rYa9Nf1RK3WuLXem14o0qK1htVkeRAyKZQoZ6
	GFW4yqRx/sszpshvLuML6Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45xj6402we-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 17:51:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53AGxfbp023915;
	Thu, 10 Apr 2025 17:51:55 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012051.outbound.protection.outlook.com [40.93.20.51])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyjx9kp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 17:51:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPaOl2Yhh0OgseYDOlviaHaR1hHYuFUlzfTuE2IXXre/5w8iFJ+8Q3l6hWzgr8h3gQvUiripRMJhV2QZYXXHl9A0tqlVwQlw4upmdmP6t/rIUNZE+MbHaEH5awS3TAFmFvJtD0ckxs3dy1dPDzYRmvCL09EsrSeafaAEgUetV5WAyKzWe8Lp3C2j5+cTEuFYVZAjWFM2QdSHRK/ErqLFBByvjKaeoxPf4JG/hYdcKtU4hZoXRDsV4DSGZ5ssQF3jgLzZ3GNNwFouuDDA8bmZYIs1lTBdXmESCMKt0UXDaCQGXw6r7bLuCOP7AiMPTqRI+rVsrz4NTBohjw113ecS+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwYMmYBGcRdrsU5XQ+hAL+JBZw/kI8UKZxF4m6ObHrs=;
 b=tG8EFDMC70W6OqQiJC19Xq6qLczEaJ0Acx5zL/7dn3AWAZK5FqXLSAdQZ5Aa2KAQhJjddZAEHHR5N9xOgWpJiu26AOBi7CcZcgDj4bPOg2Dl6zZ9f5y2Q2av5JgKeyYYyaJpgQputo8dpa051DcaqZNiEYzNMWx2ChErkYdx458WchlAGMVH5H3qgWq8Yj5cWpVaoH/EpSMbR7ngLRgjabFLIY9kqcJQ5G4nIm0nXKoTZ/3RwI5OvrPVyzsv9ZmciKp9JiXGBQPleQXLkZcLMmaJotEXA5jALg1QHxP20GDAatdTfvlnscmnfjHxjC285vnw8LoR+qb13GuY658Exg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwYMmYBGcRdrsU5XQ+hAL+JBZw/kI8UKZxF4m6ObHrs=;
 b=rsu7YLIZz2e2n7iBG1f7UergJjmxsBaD5VKX52V85cIa1qn1Iffg6+/c3j4HGVryLSuVr3jeo9yJiHXxPnnoIy4I67iXmXJ20v1oeOYj6pqVupO05e4mxGTow+k8M90EDZTXRAMhYDAUiqnEVCKjlb/z5g+4299ZFCz+l4hUHYA=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by IA0PR10MB7181.namprd10.prod.outlook.com (2603:10b6:208:400::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.24; Thu, 10 Apr
 2025 17:51:52 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.8632.017; Thu, 10 Apr 2025
 17:51:52 +0000
Message-ID: <7bffe8a8-56f6-40e1-90cb-d9589fd41bee@oracle.com>
Date: Thu, 10 Apr 2025 23:21:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v25 01/23] net: introduce OpenVPN Data Channel
 Offload (ovpn)
To: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
        sd@queasysnail.net, ryazanov.s.a@gmail.com,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
        steffen.klassert@secunet.com, antony.antony@secunet.com
References: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
 <20250407-b4-ovpn-v25-1-a04eae86e016@openvpn.net>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250407-b4-ovpn-v25-1-a04eae86e016@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|IA0PR10MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: da6ae527-d631-4514-2d66-08dd7858606a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V29tVmhsZkhYd05CZnhEYWg5VnlQTWxqejY2WUNTTmRBT1ljRGV0SVpRRU5I?=
 =?utf-8?B?SmVxNi9GRzBMWnZ1cFEzZW5rZWdlYnd5R2g5bGEvWG5mR0pSQU5jYTQybVZX?=
 =?utf-8?B?U3IvSXFNa1UveHRQejY2b0Jqd2hBd3RHUjFDK0lyYkpIZlpRZ1RWeVJPdFpm?=
 =?utf-8?B?bGNHbjBnbmpWQjlBcEZ0OEErYlZnNEx3V2pzY1pWVkJEUkl6Wi9wRXgrUmc3?=
 =?utf-8?B?RkdZVlR6cUdEbVN0VWs3M3RuWHZyVDdTZFVibThJcS9LNms2T1Y1R0xHMXRS?=
 =?utf-8?B?RE4vaCt3TUVXdE55K2M4U3NhU01MMjZMWVg1aXcrTDJoYlU1VXVuQ09xdUxw?=
 =?utf-8?B?Nmg3Uml4YkhudmFuOWJPbUFMMitYR29JQnRyTm1mT0xPOWpWZEF2aDY1bjRJ?=
 =?utf-8?B?d3FzdEZUT3R1Q04vM2JnQU1nN3k5MjlVc2RGNms0a21tWDA0OE0vT2sxbUtD?=
 =?utf-8?B?TjB3ejBDWkxid0huVktld2xReEZLN2FnTThubHBzSk9rM2NrTWxrbTNrUTNo?=
 =?utf-8?B?bEgyTEM4b2VQSTJYb0xzUVV2QWYrNytuUVdrT1ZyeVJmVWg3V3ZzQU8yWGQr?=
 =?utf-8?B?dktEWTlIa0U4V0xmTWx4NWZjMUVQQmc4cFhFQmNKOThLK21DL1ZzRWp6SXJp?=
 =?utf-8?B?THZTRnVyTkpsbk45bWNadnRQT1RZZ3lqbU5rU0k1Tyt2V21jN3YvdE16czND?=
 =?utf-8?B?M1hFcWlJMHJwWkJ0aU5ia1hzN25TeC96Y2RuMThna3ZnTndmRHFHSHpMS3JM?=
 =?utf-8?B?UnNjeFFZMzVyRjFWb0w3NmUvRGRYNGx2aEI3NzlmMUJscmpjVjE2eG1ON1pW?=
 =?utf-8?B?QjFWekpvaE5FNVpZK3JkWXMyRkhONjNKVkh6TkRjK1d5enltdVpOYWdCdUpG?=
 =?utf-8?B?MzQwUlJZU2x2UzFhMjFBQW12M21HU016TU01ZnU2YkcvdUdKSEo4Snp0c0tB?=
 =?utf-8?B?anJLN1NtQVZUSnZ1dXlCdTR4Qk10bHFTcWI2OE1FZ3l3b2hWV2NIU1JGdzll?=
 =?utf-8?B?Q24yUFp6RXYxbkxVQy9XNU8rSTVGc1FoczZQRFllekkrSnZ0eTBCMEtObTRC?=
 =?utf-8?B?TlF3ZXdUVTdoWnNaREtOOTA5R2twM0NRTVJYeERJV2FYby81YUMvMnIzVDVr?=
 =?utf-8?B?eXp2SEllMC8vZU1mOFJBUDNwWklWVmhDUjFXZWh1Sy84NHJFbEV6MEpoajNV?=
 =?utf-8?B?M1NXaTR5RmdHN2Z2em5PODdjMG5yRXZncWVGbktTQ2h1N3hDN3p5SGFKc2hJ?=
 =?utf-8?B?MmNPQVAyQXcrV0FVWFlEUUNHeFBiM0t2cHk3UGFJaU1hMVZzY3NzR2lFOWhI?=
 =?utf-8?B?Wm5Yd3lSdkRHbGdBOUNzOWY1RmRQR2dDbHd1eElBN3Z2elF4MzA0WEFpSGJa?=
 =?utf-8?B?VUtKemVFbGoyZHdVcjUxbjVTVXJpVXhEbmRPb1V2YklzNWFtWlVHSzdQQkxn?=
 =?utf-8?B?STRoZ0dOekJQamFQUnpkVXNycHgzVlZ1SldQMjlnSjJ0cW9Ddys5aUZLVzhp?=
 =?utf-8?B?L3JrMDlVQmJHUGROei95V0o1OGVrNFlMSFQxTFVReCtQNS9NdHdaanJYeXRT?=
 =?utf-8?B?ZTkvT2FIZlhNV1EraU5xSFRZMkVVV3dUNU1MbTVmdUNOL0NZTmszazc0cVNT?=
 =?utf-8?B?aHhNYk5lMTRGYms2bldiQTBlOHlUdnZVY3NpVWRoRWFCMFN0SHFqZXg1VGFD?=
 =?utf-8?B?WlI5Z0xRZ1FTQllQN0t2L1B1TlphbnJvRHlWYllEZHJHLzVUZEVkZklEdlFL?=
 =?utf-8?B?L3N1UEU4c1pQcXR6cEYzUDJuZUM3R3p6UFJkcXJwZVhaR21IS3FOWGgyMGpw?=
 =?utf-8?B?V3pqYnFuUFpXbE9LZndFc1J1MmtzYXdacXRtUzZGaFNvME1LQ3FPbjd5MjJD?=
 =?utf-8?B?UHl2ekRiSW1NUnNaUFhOVG9oWUpOSkZ0eS9WR3NBa2JYdGR1czh5NGxab0hz?=
 =?utf-8?B?cmZtdzBycENqb0pUQ1dIV0ZGTlJkSUZ2b1hBVjJjWHlyN2tJVTlkY0xXaTZu?=
 =?utf-8?B?NVFMKzJZc3F3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjVqVU51MnRLMDlLS3BBSW00V3lqd0hVZEtsUmlwdm1zd0tSNFk3K2dkQnlF?=
 =?utf-8?B?Y3ZjdmNUSnY0TmNwMFJ5dGRFZ2U3RFg5cHNGNHlIZ013UlordjR0S2ZyOThE?=
 =?utf-8?B?dmpYUnJXdHhpRWxxVXUzcURjN1pPeDRKWWRmMGg3NHo5RVBsTzlybWx1MER4?=
 =?utf-8?B?QjBHanBRMmdHL0xyRVpBaTVYbXhRS1FOZ1lWWk9nZi9KT2xCcGNIbVhLeEh5?=
 =?utf-8?B?WXkzZmdPdHluZ3RVSElJd2M0NU53MitDUjJXUEp5MHR2RWxzNTd1RUJQWHRp?=
 =?utf-8?B?aGFFUGRDYTVmUHdCRnRWTEExQWpGQ1NpMFpwMEJrSysraGRkWDFwNkJFT3FK?=
 =?utf-8?B?NWVvUEJqQ1REZmtvcm4vdGROMHBDRURPVzV4TDVqYTl1eUdYV2srcE5JWGpG?=
 =?utf-8?B?b2dQQzhtd25IcXpYU0NqQUJaczZxSHhZN1hXNTl2NGp1OGlRTys0Sk1DUjI0?=
 =?utf-8?B?OHpaYngzVVcxTG45V0daamd1aHk2bm9OZDBBem9WQWJyWm5PUlBQSlBLWktz?=
 =?utf-8?B?UVNya2tMSFAyeVJaVDNYZVNvVUdyNFlzaDJsWVRTSTRxSGpDaFBMSGlZQlg5?=
 =?utf-8?B?bUZja2RUMXppNmdNb2FjWXM0ZDNiYlQwWXozbU50cW5XU3ZmTzZWbGlKMnNL?=
 =?utf-8?B?b1ZlaFpqbnJ3eVVuY0t4c0hiMGErSnYwRGFCeGg2OTQ4TVRoZktNMWkySHAz?=
 =?utf-8?B?dHlSTEkwVzFQV2IzU3pJQkJaNmNyY1g2RzZyaDdrbXNYMmJmUUFSbkNQdytX?=
 =?utf-8?B?cW1sL0ZsSkVST1BYSG1BejYyREdiUnlveVV6TytsRGdYNVRlVmxuTEVUZCt0?=
 =?utf-8?B?OUJBR0FDdE1Ia0I3MittZDJJWXN6RG5RWE1uS09kSEJ3TnR2d2w0ZGhIRmE2?=
 =?utf-8?B?a1c0dXRRbDhPb1ZWcVZIMlIrUXpybmdvSFVBR05QT3V1amlVMVo5N3B6Mm8y?=
 =?utf-8?B?bHFoL2FTbXI5ajloVXZoLzh5Sm5IOXBKa1BxaDIzRlQzdlp4UjY3NzFrNk55?=
 =?utf-8?B?Sy9CeHRuZDFNVzVrN3BKU3pEeEN3NnlHemo5WXV2QkNtb3hrQW82bUQ4OXN5?=
 =?utf-8?B?MkViODhSeUVkbHVnR01LVlhEVTVtSjJFeGkyaEVkbndTcjJnMHNzNWpWb21W?=
 =?utf-8?B?Um1KTjRIRmhxMmlSMktwSlJBV1p0b3VkcGZla2JZV0ozc0FFWTRmMldPK2hY?=
 =?utf-8?B?NnpCWW9rZGE2Ny83WmNXVjU5WGYzY1kxdXhEYnp3d0pucXRjR25xV3BRTGtD?=
 =?utf-8?B?S0hoRmo0Y0VDU0pBaTNyNE40TFdEU1NEa0M0dnRMQkNqZ3lJSm8xb3hoYy96?=
 =?utf-8?B?Sk1nUjZMK1Q0Q0Y2L2FlYWRKRDRCOWlzcng1OU5ZbWZ1aXhIWkh4NmMvY0lN?=
 =?utf-8?B?aHJiaTZ5OUpFT0hlT3h2YUlQMmV6KzJyVzhPREJ1M1V4clhNUjJIYUNLaXRC?=
 =?utf-8?B?enA5bHVETjBORysvRlZZTnFyditJZlNWamsxZWtCcjV5OGdyR01WcGpCWlN6?=
 =?utf-8?B?NS9zN25UMkI4WlBhVk1HMWJ3NVVvYmZXMVlSSlRHQjhTS0Jjc1BpUzlkZjRY?=
 =?utf-8?B?YUtOdjBmekpTdVhjRDRLbmk3N2g0SHZUcDNONnpMcVRVZWo1ekZlZTQ3SU5k?=
 =?utf-8?B?OEpscDd3OEhEbWo0cTNRamFlUTlKL3VLNGgvU1NHME84aHFrSXRnRU14d2Iv?=
 =?utf-8?B?UUFiTVUxZHNYYlRCVUlYNXZHOGR4T3VhTmxMVHMycHl2ckZ3bmZ6ZlU4Zk84?=
 =?utf-8?B?SkFlYlQ4WCtaZ2tqQkg2WnhNMjVCOWZDVjFkQjVLSERlMElHaXF5SHZjTE9T?=
 =?utf-8?B?NURNVDJSeTV6TnVNTEt0SWRPcWFhS05aLzNqRjlJR0x4RlVON01BVWIyZmU1?=
 =?utf-8?B?RVNhOXRaUENiNmUvZTB5Q08rcG56Y1VCb0pNWDM5K1NsbVZSVEE4UkFRTXVh?=
 =?utf-8?B?VnFIOS8wcWdRYlEvcWpNRlZIWVhNUlArMmV6NTE1cUd4NHJjM3FGOVNIalN0?=
 =?utf-8?B?NzdWditqbjBUaWkxdi9vZlhrek1TRjdMTXFxNW9zK3VCWGdXZG5XUlhDRkZY?=
 =?utf-8?B?MWlJTGNndFNZTEpEOHBEL2JXdTBlVHZvNWNmTGNQVWpYMEYvTGlMZEFsZEJ1?=
 =?utf-8?B?MGIxSFZ5dzVsNXRBOU9pZ1REOE5LZDIzUy83MXhvSXJKQUtnN0ZDb1dtN2M1?=
 =?utf-8?B?Vnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KhTl2cDqUFWcExN0SMlYV5rnsEAhi3jUSxHIIPa64QSUjK6CNgQis6mce5u+Lkwt2KZts08xfFkdKAqckv0CicW51PY9KszObtHiHCE3x/WJ3SvW9mXzDUJkJR//WEXdSmQzGxlK1DsaqGrpeGRzyiNbACccU7jpLykbfR+2lvf9iZ9x4bAMOdrFw+m2HvfqxkeY+1rq8OX7yP33b+9DDml5MFzb1tPYtqg9U040/v7kV3/8DfQTWT1Kfb2cIL2yAJoi2jIMjedQPpH0Ed3sKsvt4vixQuGZGeZ5bRv9EUExbNF6ZMEgeiPwGGQIIH2JOrM0vD12X7B+7RrfTnrzj4DzPPNCfPr9P3uJ8GMGyhInj+OYnPldXRnJWQX+xzDPC1TlzKkLuo8IPtFaTaXdw4+RByIIsWvnY1Pd9Ry8ZlhRpNyd7swk5QekT04UnOc5EBOYdfRIzuLuvs6Jrjcg5+EbvFQvQvyH99D/WKMfcv44c7RCtc94DPNxCQi7g65bpRNKo2IVyG1eAN1b99zX8Fu6yNeR+ziWkgmMepCzkkcBzJaBAJW+W2pyEtBetCttY40Aor7xLOm+VyPZkO6P82zTEefUzdp+3/p3D4UGqsQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da6ae527-d631-4514-2d66-08dd7858606a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 17:51:52.7794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /GdkO4M2DKt0FEg5328jZRH52rKM1TDDw5QVLd45HEDvBOpq0jo/FcKfE8hPnzm0h00/R7TxkhAB+/y4N6Md26+I2jwmXNClc2nzu7+gSuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7181
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504100128
X-Proofpoint-GUID: Xeh0tIoFKHXW5bjKx8Ln_a2fyJmQpjRK
X-Proofpoint-ORIG-GUID: Xeh0tIoFKHXW5bjKx8Ln_a2fyJmQpjRK



On 08-04-2025 01:16, Antonio Quartulli wrote:
> Although it wasn't easy to convince the community, `ovpn` implements
> only a limited number of the data-channel features supported by the
> userspace program.
> 
> Each feature that made it to `ovpn` was attentively vetted to
> avoid carrying too much legacy along with us (and to give a clear cut to
> old and probalby-not-so-useful features).
> 

typo - probably

> Notably, only encryption using AEAD ciphers (specifically
> ChaCha20Poly1305 and AES-GCM) was implemented. Supporting any other
> cipher out there was not deemed useful.


Thanks,
Alok

