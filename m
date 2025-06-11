Return-Path: <linux-kselftest+bounces-34747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2169AD5BDD
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 18:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84D547A4EFB
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 16:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCAB1C245C;
	Wed, 11 Jun 2025 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mV1gxgra";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vHGTnXdF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4F61AD3E0;
	Wed, 11 Jun 2025 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749658690; cv=fail; b=idt1yRqqZsW6e6kkQkhDAkOSj7v1tkxt0dOIEY1QtPosV92w6noqkvn5+jrjO3pWNUcm0O0dBFV4NG0MaNU08O4IjG6LjgvxUdLh5LKASjsTs6Hi/93Fzw1ClO8+HDwpDZlv1Ys0G3q2KQp08iYLoeHZkvouhRKcSEO6pmAKumE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749658690; c=relaxed/simple;
	bh=DCbO+BgPjO0mPkRlpxgipi4qjSJcCR5L6y9a1eXn1rg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sqxo0tQgv+wt+1qGz0rqk5n/Xh63fy4S8sbs9d5+M9Eslfn5PCgw/WecjlR8emsKAts8sgniA8+bStS8DJfTHKaDz8D4NIbQ5tD5y3vL713KKu7mi5C7AyYRgdpkPJT2S5+6g5OG1ght1OSW03Oa0ezhCWDbUt/zXxCQhnuwfm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mV1gxgra; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vHGTnXdF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BFx4Gr007788;
	Wed, 11 Jun 2025 16:16:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Xw1TgASixOVP0Wb+fUdUD2BjaB3GvRG98m2+dPvvO3Y=; b=
	mV1gxgra1txUnCmXnN78yRztEjjrCezH7VUHp3T5yfyvM9+pQRwTW+FX+/7OP4Uq
	ocT+DhAdX1697TRDCoWitIp1GpPwexV0WjnU0G92wBHfUHuTDqKXrulNVwoUOjP5
	2L60xWhXgV9goWkUHmsClfGh01mfd73nJRfU+JuVEzg9XoE3qcm3WuAtE227xHI1
	a2QPRiGpX8WmjdSbV+N0D5kwW72xtYwDY2yQOVhQo7MCrIQg5o9t8IUVuQckzR6M
	5MPIvzyogyBddIqDNIOdsPQAm5CXY+zIS8beJo+6yVQA98eu0Hwpfv8kCglRmT0i
	cX7Ix8tVjy/MHIOZJWpUSw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c75000u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 16:16:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55BFH4wZ003281;
	Wed, 11 Jun 2025 16:16:46 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010017.outbound.protection.outlook.com [52.101.85.17])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bvadpj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 16:16:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sx6yAaCvOeGR3AYceGDzwptxgQWek9Cd2AZ8yLc7I9TZ9m2UnqCWumq9mu6g+mDxwhTjDwvPRapBm+axvHxLmh1/Tqf4Ud6kNHXI74RMOc9RCy3Lo1O7yFGz8O61X/AewFatzzwYI1R7RjwnGReM0JJg2B8fCWeTXwn4Pwp3CVwk6zHSEIWGjzMXz1xMzd3tZ/4ULZZRDA7K+N0LQ8iPmhTb6uF4PjJBei84i6EViTvz2Dqk/AYgWXaj/SOJEDVy+JL6mJvhAf23Vn8dc7++cWWdDNtFziXR0ACMPXAZQWWkkBTPIREjmVwFaqJZXx0axPO6OAHjvSDmUUlxThH4iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xw1TgASixOVP0Wb+fUdUD2BjaB3GvRG98m2+dPvvO3Y=;
 b=unEE7NUbfleSQBG+c/mpcZrsw8ivps1aneNQuAr/b52yNwxaKLuR1wq42bFsYRXKkyxzj0JL9ptzcF/bFw1kSU8cTHQJhNSa0VUovsx1IgGqOOcLu3E2K/YE184X4f2RJXB67uyo5EgjJNCFZgHrvLT04x5b0TUqB4vy+1di9kGQWUc7A0e84neHb4oFZhH31+JE86BUtsxyIWC5kcpinOsh9KK+inoeHRelcrfe6l0Vm8A6e87uiPm1Lzd0u6im9EJAw0nCCI9g2UaAcjzlqeett81tXEdZICoiXpxrPZJWZ7ijojTZuSBgnDa54C9ZD2/At3p7yADA6A5VnqlXfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xw1TgASixOVP0Wb+fUdUD2BjaB3GvRG98m2+dPvvO3Y=;
 b=vHGTnXdFMfMqA5NXTOaYAzjKcxlBx0/NHEFNEhJFmHG1wx47QbiLEOzEHxSw2Qvlv5xHVwRIM3hehVVaHrYElEFmhssQ4Pr4uNILSM91ZfGODG6PpkWIB5JKSFigi/pYkfv63VGb2q6C/x4HLYEzsx/DumouObhxAoQPrFJcg68=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DM4PR10MB5941.namprd10.prod.outlook.com (2603:10b6:8:ab::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Wed, 11 Jun
 2025 16:16:41 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 16:16:41 +0000
Message-ID: <966ed106-1b78-4c7b-964a-d3d7ffcb09f0@oracle.com>
Date: Wed, 11 Jun 2025 21:46:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 RESEND iproute2-next 1/1] tc: add dualpi2 scheduler
 module
To: chia-yu.chang@nokia-bell-labs.com, donald.hunter@gmail.com,
        xandfury@gmail.com, netdev@vger.kernel.org, dave.taht@gmail.com,
        pabeni@redhat.com, jhs@mojatatu.com, kuba@kernel.org,
        stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, horms@kernel.org,
        andrew+netdev@lunn.ch, ast@fiberby.net, liuhangbin@gmail.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Olga Albisser <olga@albisser.org>,
        Oliver Tilmans <olivier.tilmans@nokia.com>,
        Bob Briscoe <research@bobbriscoe.net>,
        Henrik Steen <henrist@henrist.net>
References: <20250611150841.23203-1-chia-yu.chang@nokia-bell-labs.com>
 <20250611150841.23203-2-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250611150841.23203-2-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DM4PR10MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab201c4-75df-4884-6b65-08dda90359c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHYxYTR5WGlVM01tajZWRkYwUmhXcnNrVDNkMDhvM3l4YTBRbDRwTUFwU1Jj?=
 =?utf-8?B?enM2bGJBTGM3aC9tQlhablhueDh1TytyWkUzQ2h4MVNyMnlOUVlZYWExWm4z?=
 =?utf-8?B?OEx6SVVPanZlS2tGbUh5ajhyU09udG5hVjVJZVU5WHIwM2dTbk9vWlNpV01N?=
 =?utf-8?B?S3VUSzlKSFpwdHdVK2Q0UzRQTkdNaTVjTG10QWRjNGJJNHZETVNEU28rMTc3?=
 =?utf-8?B?YURyTVAya21nNXRjcWw5K2FITmZEWk53QjlCQ29QaWlpNFBXbkI5bVZQalp6?=
 =?utf-8?B?TWtwZzNoYnZPc0wrYlYzUFoxU1pzNXdtREx3MlkvanBPZmREdzBaTExZUnl6?=
 =?utf-8?B?clYxaCsrNnNlQXNHNUxWcWw2dGV4UGV3YXBqT0FJYUdJY0poVnA4SWtWMGNW?=
 =?utf-8?B?aVV6d3pOVVdyUFdtYUExQzVHam55Zjloa2QwZ3Rqc0o4RExNbTlRYWtOaksz?=
 =?utf-8?B?QjZHZGhteU14akhkUlRFMEdBaVpwSU94TkRXajcrcm02akFPRUVPZTBoR3Rj?=
 =?utf-8?B?U0pSSGxoaEdPUXJsNzdvM083c1Vudk9NSUxBc1pnUGdHbTdHZ3ovQ0dhMXQy?=
 =?utf-8?B?eUNlMFBNZ3hZQWlPSVQ1MzJ2WlNmQjNyT3h6TmZmQUZpR1R6VHI1RW9kM0pE?=
 =?utf-8?B?OXYzek1hcC9ITWl1a01vRHlwU3RFR25xNldnVlBlTzJ2bFpNUjZvOWY4QzdD?=
 =?utf-8?B?M2ZJRnpsRE1HdnBaTEJrZmNwaUZTMDVXWWoreGRJV0hDdkxZemVIZitwcitU?=
 =?utf-8?B?VlByTmhjS0V6V1FmM0N2Q0ZHN29RUDU1ODhtOW5CWENnMDVrdmkwRk43NnB6?=
 =?utf-8?B?cmFLTXdOc0FjWVpXekVyVTRZV1hHeVlOcGprcDRBWWpGaDA1dWtpOGNHbFhG?=
 =?utf-8?B?aURxR0NNdDlmMWNOSmZEY1dNSElGQUVOaXd3ZWQ1WDZWVVhHWjFHQ25QaWZV?=
 =?utf-8?B?MkVVQmJVTkZpenVyelRxSVRHYWY0dmJ2aFA0QUY3YkR0L3VhbC9obmVwejMy?=
 =?utf-8?B?WHlaWXNDUzl6RnZVQkR1OGZ6QTBmU0FJVGxYcFdoM2F6Q2lGbGV3WDRHODZJ?=
 =?utf-8?B?M0tlUlQzbjRVYkxUYVJzekFrUnM1ZnkreENkNUozMno3eEs3Z0d4MmdIc1lG?=
 =?utf-8?B?NVQ3YzZNc1VBRytBVEdjejdSbFN3THJOVjlWYVY5aFJKVklWakR4ODJwTFht?=
 =?utf-8?B?MVBkVUFsMzlGbjNSbGNtN292VEN0dlpnRUJCNGVqQ2l2L0hhQzNpblpoTitZ?=
 =?utf-8?B?RU1Hai82djNqWWNBaXdiS2hWMkJKSDBYT1piNGIzOG16anVsME00QnhHU29r?=
 =?utf-8?B?M3ZWQUZlNmdLak1YZExIWWlSaDNVdGkyNDQrY1Z5UlZBd2xXOFE2ZnY4ZlhI?=
 =?utf-8?B?eW41Z1VTQVJ5eTVSMEFjL29YSkNIS3JGdjF5VFA5eExlQjZpWkhUM2FjcDh1?=
 =?utf-8?B?UEUyNG1DWHNPMzltNVBTbjF2SCthYWxEMFlHaUpZVDdkTCtWSjJ6WlZOendJ?=
 =?utf-8?B?T3g1SE1ueDJpcFFxSHEwVEd0QzRFODBDS3BSSHE0Mk1IN2lLbENaRmJ4TnY3?=
 =?utf-8?B?eFlCT0tRTGthMXY3a0h4bHlXaEMyY0pPeGNsY3p4SjJWVnM2Q2JtbHNOSG5S?=
 =?utf-8?B?aU85ejNvSHRtcFNFSkUwVElEeUwvdFlCZmhDUEJXZ2pHM25uUTZib2wrNFBX?=
 =?utf-8?B?V3lPU25QSDk3U21PdnQ2bXpxcjNObDVNOTJ3UHR5d0tTMWQ2UnpyRlRzVVJ5?=
 =?utf-8?B?dHBwWjV1NXFoRjlzeGdZRjdIS3B5dUlxQTMwbHVNUWxmN2JIUnkrbzNvNkxi?=
 =?utf-8?B?M3NzaVpHWXVSUkRjVXBTZ2UwY1ZyTzd4czlpQ20zbzJsWWlkeklHUFpQb2Zy?=
 =?utf-8?B?cVZOSFpJNS8raWZOWXVveXZSUTA1V2w1RCtZaTZyK2d5elgzMVZGdklQc1cx?=
 =?utf-8?B?RkR6M2xjMlVpZlBDZUNUTy8vS3RnMEZaRFZIbGp1WEViY1JRSkVmS0NCdElH?=
 =?utf-8?B?L1luVTVDeHNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUhWMEM3NkVQTDltZGlrMHA0OTV6KzU3TytqYnpiTzlwelEwSEh3RTdvSFlY?=
 =?utf-8?B?cmloRlFnQWdudkVBS09BZU5sSExmYndPWU1HOTczeXR2c05oRFZQMktEaHRJ?=
 =?utf-8?B?bzJvOHgwNEozZm1FWE9QNlVnTDBBYVZrTC84R21RQ2J6QVg3MzBDYm5yZWVT?=
 =?utf-8?B?dzBLaGJuaEh5NkxBQWtHY29TZU8zbEtJaTN3SC9wZFFnRVRPUG43eHNFK3Qw?=
 =?utf-8?B?L1FXZ3JzUnFJbkgxT0h5MzZIM0ZvSE9OY3d2aVBZUFI5L0hhdFRxWHVaWncy?=
 =?utf-8?B?WWRUcHpkTnVTQW9QdXVzOVpYWHRmeitjRENqNytKRWJsNk5YQXpaU3FvNnNs?=
 =?utf-8?B?YTNhRmRYVXBRZDF2OEVGS2Vyckc4WkdubmRYVENsS3hINmhtTFFZMWtOUUt6?=
 =?utf-8?B?WTRTYlRueHdiMGhXb25Fd0dLTUg4alR2dGFqOW53YTk0NS8vTUxMY2I0UkVH?=
 =?utf-8?B?WTRMdW5zQVVZT1RaWHhtalJDVExrMUxySHdiUFF3bkZ5TkFtUzhWZkhsNCsy?=
 =?utf-8?B?N2JjYkEzTmhaYUhWdDVHcWdFN29JTFhqN3pTaTFrNisrTTdVTGptVVRDeFFR?=
 =?utf-8?B?K1V1bWZNWit5MlkyZ3M5a0V1QzJZNjdGM1hITno5b3RBUzNheUdVeEVCN2Ev?=
 =?utf-8?B?YVZoR1dFUTU4QUZjWFYvbTRKSnhCVElKb1lpRlo1b0NuQ1hnVk9sOE9EbkRH?=
 =?utf-8?B?Z2xOZFVDNmlrdi9vYUhjdldqRVljUkdrT3ZsYVE3bGRzNkNoUm5IbmNQRmpB?=
 =?utf-8?B?NXJxaGVZdGpTRmptcC9yN1NpSGlHK29GT0o0VXA2TjNIek5YNUMwcUlqcUZT?=
 =?utf-8?B?TG9GUjg5WlhZWDlzNnoxRW5paWJvL0lZT2krZzNGcGQ4bDBLaXNWR1IzMGQ2?=
 =?utf-8?B?bUtnUjQ4T2w4ckpHazg1cWZZNERSWHl3Mmk1d2VUc3dieXYvbC9Rbk9mblNZ?=
 =?utf-8?B?bGxpRFdrYlNtMlNDaVV1Q1FpeHhPL2FySFY1cUdGSlIzOVRRbEZteGRCcFQ1?=
 =?utf-8?B?bmM3aTlpa1NPQmlDbENzZm9zYVNTeWV2NVViOHFPcTViMmp3cm5aWUgwZHIx?=
 =?utf-8?B?cFgzMlpSMzZxdzJnNnAySjIvcHNZZ0hDaVRHRXBFaGNxbVRleHVyRkFSWi95?=
 =?utf-8?B?eHN2SGNoaG4vNWk5ZTZ3WTZQYXFWUlhEWVhwc2NFYVo0L0xWbFYwRTNKcmda?=
 =?utf-8?B?K3haQlF6bHViUzBUUmw1RDdFMnEraXg0RE5TSk5GeGh6OVBGNFhQenRHM2ZH?=
 =?utf-8?B?YVZNRzNaUFJ0L1VMVEVWeCt1WnUzS2RMSkdwdVAxeXFXbjMvMm42a2RkRjVq?=
 =?utf-8?B?VUVCTzNBVnZZRFVVRlpHTytQLzZBaksrdW53YjdMUDIvc0VFd2RFMDE5Rlpi?=
 =?utf-8?B?VkRmbzl1Slhra1B4T3RHd2VZWEljN1dKdElVb1d1c1lPUmoxeGhER29sZzRN?=
 =?utf-8?B?M1o1aW12MEJQOXZqVDV4SHBQd3FuU3lKVklHeGZ2QXhmSnh3S1g5OWhhMzdr?=
 =?utf-8?B?OXNsMkFnNnc4cEVkOUYrbzJ6WTN4ZUJ4bVJZZHVVNlpOM01ralZQWmpITEVU?=
 =?utf-8?B?dlVmb3c3by8xVVdTalJpaERWS2VCREp0b2pCRmtpUmpaU0RMRlpYdjN4eGNj?=
 =?utf-8?B?blRxTU90R3gxVE51bWk0cFM5OUpmYmVVaWZiSUQ4d3JjSml3UTRDbDZLSVg1?=
 =?utf-8?B?MUY3OElZWjhBU1RRaFZnTGtEbWpHdE9JNHJoY0l0QTlEQVgzVFFjTkJwam1V?=
 =?utf-8?B?SGNEa3VrTjNMN2Z1N0tUUVVpS283NGRkY0M5REZTM0tWZmRMWEY4TTkrQ3BV?=
 =?utf-8?B?aDFwNjJpTXdZS1NhYWxLZ1FYVkZOZlZ0SVMyRkdlc25IdU04cDB5YVJyYVZh?=
 =?utf-8?B?SktMOE96cHdobWcrSjA5V3I1akdUVWZvVkQwQ0YxWXdSK1MxRWt1RkJ3Sm5X?=
 =?utf-8?B?ZXdreUNwbG9zSzNIaWQwV29seGtWTFNUL09LdlZkazVsOXRkWUNSb0IzZVE2?=
 =?utf-8?B?RlYrRGFSeXBWamc1Q1pjTTdnejdoRW9VNm1MRHlCU05yQ0svdWRubFlvL28v?=
 =?utf-8?B?bE9QQm9zYy9RM3hWWW1IN0dNYmxrV3ZCZ2dKWUxDc2dQSVBYUlNYZzliSDZa?=
 =?utf-8?B?bW03aGFYbzNjZHAxNXAzbHhGYW4xeTVVdmhReDIvSno5Z3RVQ0xiOEd1NTdJ?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	InOgUQN5W+L05570aLP1SmBjfbE8jEGCrcJO/pfVGk7MzcRXTvvkfqgZE1/EgcHEM96+dkxNyhZXtjywqoXgeemLzs0QjAzCTvSYN+KPYXFWz99GX6amnSNXZBSP8p9m/F1JZnjtGB+EdGuFMrObtz5NdadkxRhaEax93VCBt9Cnqx8X1Ahrj+5jiDvV6rLG4xqv8uytq8a20cdX0aojGGciaSitRrBpYCJE/fvH6Gb+jcr+utTrNLafDignSZ0mNnQRh0PFF+WWv8tc2krqTq0yMpJmMagqEHgHmxSzqb7SCl5lf9jwpAUIMFnS84C4tMHtg44Zl7Wbt3bmhs8e7vAtWr3dMd1wmjRkdgtK9gdnnhWow+UHbYlQgXx5zUYLEpSfY68oHW2nGyQfYpNHgMvblWpCfNtONsHd3gFmj3Z8/5adPBmYA8VMAYoc9mMV0MrLTME1UbajwZUS5ZEsDYvXBlR1AqDOYEqEoAtGR/ECwUHeh2YdES95QLABFDnaOf4GUSAo6MQzdWdEB/YNksomqPDmajTcrMXfhlOY5K4WmqfYrCGEsp7aMjxnBIXBGx995xVuwpsRGxF/av3+nsAUcjjgTB1ZFyvxTXy3oe0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab201c4-75df-4884-6b65-08dda90359c6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 16:16:41.5547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CYBHKuoP4cjPrZjKPSZKgHZOAAnFjh4jFgvoeXQYwtdY2HOUlQibZfiU4uocHahFk5QruSw+qewqyj+DndhBA+qFbreRw1BYdeMCfmCZfmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5941
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506110136
X-Authority-Analysis: v=2.4 cv=LIpmQIW9 c=1 sm=1 tr=0 ts=6849abef b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=QRfgzcQfAAAA:8 a=T5h9VGK7AAAA:8 a=9qxNCY_qAAAA:8 a=ZYOxkDpqAAAA:8 a=wsYdVedNAAAA:8 a=yPCof4ZbAAAA:8 a=BFS-9a7cxSCpqrojkncA:9 a=QEXdDO2ut3YA:10
 a=bWi_NY57ueRCZMPDbo1P:22 a=4sjnvvPVYadLTVfh1zOT:22 a=DSX8VK-MHXYh3DGVmxOZ:22 a=5TmgkJrYsa9NT1YAuGZe:22 cc=ntf awl=host:14714
X-Proofpoint-ORIG-GUID: WgWVW72j07s9v6USYk874pgA9RUDzTru
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDEzNiBTYWx0ZWRfX0CZISDcH3CCi FFW6weommz+ONOdku4sUVMtciWz4JYVu4tfg1/0VySA8qqFM1n0R77Qs7+st5fsaoOrTE7vxg5e t8v3ghUkzBJX7TPA/MLryzsxL3dF5fLbw/YUgmk319En4xlesqTQs0wtpd8PLCIYhKT5u/i+xRG
 gE8Elk7fhnUvyjlekHsomHgNZ6ybM+eJvU/0uyWo+p8E966OaAu3LxLrnyiRIaDkiPxw6huoa8u o08vE/ePz3qRMawbiHh2YLDj7xeuqqtBw+qeaBWtR0ngSv3DP/wi+goSs7rDLH9VQpJOP38x3x1 3uhDGMc8rHKO4KiliDV7CYJsSv2RHdLf8H9f84U7SkxdRwhhOemjgguzyE1PB8QPG0J28smJ5eU
 M5RlLZ6+5u1SXzMsUjshFA3ayp7481Skiw9sP+P+k+nZyhHwYYrHBEROD9C2mu7Tt/LuxB03
X-Proofpoint-GUID: WgWVW72j07s9v6USYk874pgA9RUDzTru



On 11-06-2025 20:38, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> DUALPI2 AQM is a combination of the DUALQ Coupled-AQM with a PI2
> base-AQM. The PI2 AQM is in turn both an extension and a simplification
> of the PIE AQM. PI2 makes quite some PIE heuristics unnecessary, while
> being able to control scalable congestion controls like TCP-Prague.
> With PI2, both Reno/Cubic can be used in parallel with Prague,
> maintaining window fairness. DUALQ provides latency separation between
> low latency Prague flows and Reno/Cubic flows that need a bigger queue.
> 
> This patch adds support to tc to configure it through its netlink
> interface.
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Co-developed-by: Olga Albisser <olga@albisser.org>
> Signed-off-by: Olga Albisser <olga@albisser.org>
> Co-developed-by: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
> Signed-off-by: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
> Co-developed-by: Oliver Tilmans <olivier.tilmans@nokia.com>
> Signed-off-by: Oliver Tilmans <olivier.tilmans@nokia.com>
> Signed-off-by: Bob Briscoe <research@bobbriscoe.net>
> Co-developed-by: Henrik Steen <henrist@henrist.net>
> Signed-off-by: Henrik Steen <henrist@henrist.net>
> ---
>   bash-completion/tc             |  11 +-
>   include/uapi/linux/pkt_sched.h |  68 +++++
>   include/utils.h                |   2 +
>   ip/iplink_can.c                |  14 -
>   lib/utils.c                    |  30 ++
>   man/man8/tc-dualpi2.8          | 249 +++++++++++++++
>   tc/Makefile                    |   1 +
>   tc/q_dualpi2.c                 | 534 +++++++++++++++++++++++++++++++++
>   8 files changed, 894 insertions(+), 15 deletions(-)
>   create mode 100644 man/man8/tc-dualpi2.8
>   create mode 100644 tc/q_dualpi2.c
> 
> diff --git a/bash-completion/tc b/bash-completion/tc
> index 61f0039d..c18288a3 100644
> --- a/bash-completion/tc
> +++ b/bash-completion/tc
> @@ -4,7 +4,7 @@
>   
>   QDISC_KIND=' choke codel bfifo pfifo pfifo_head_drop fq fq_codel gred hhf \
>               mqprio multiq netem pfifo_fast pie fq_pie red sfb sfq tbf \
> -            drr hfsc htb prio qfq '
> +            drr hfsc htb prio qfq dualpi2'
>   FILTER_KIND=' basic bpf cgroup flow flower fw route u32 matchall '
>   ACTION_KIND=' gact mirred bpf sample '
>   
> @@ -366,6 +366,15 @@ _tc_qdisc_options()
>               _tc_once_attr 'default r2q direct_qlen debug'
>               return 0
>               ;;
> +        dualpi2)
> +            _tc_once_attr 'limit memlimit coupling_factor step_thresh \
> +                min_qlen_step classic_protection max_rtt typical_rtt \
> +                target tupdate alpha beta'
> +            _tc_one_of_list 'drop_on_overload overflow'
> +            _tc_one_of_list 'drop_enqueue drop_dequeue'
> +            _tc_one_of_list 'l4s_ect any_ect'
> +            _tc_one_of_list 'split_gso no_split_gso'
> +            ;;
>           multiq|pfifo_fast|drr|qfq)
>               return 0
>               ;;
> diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
> index 25a9a470..e5a58167 100644
> --- a/include/uapi/linux/pkt_sched.h
> +++ b/include/uapi/linux/pkt_sched.h
> @@ -1210,4 +1210,72 @@ enum {
>   
>   #define TCA_ETS_MAX (__TCA_ETS_MAX - 1)
>   
> +/* DUALPI2 */
> +enum {
> +	TCA_DUALPI2_DROP_OVERLOAD_OVERFLOW = 0,
> +	TCA_DUALPI2_DROP_OVERLOAD_DROP = 1,
> +	__TCA_DUALPI2_DROP_OVERLOAD_MAX,
> +};
> +#define TCA_DUALPI2_DROP_OVERLOAD_MAX (__TCA_DUALPI2_DROP_OVERLOAD_MAX - 1)
> +
> +enum {
> +	TCA_DUALPI2_DROP_EARLY_DROP_DEQUEUE = 0,
> +	TCA_DUALPI2_DROP_EARLY_DROP_ENQUEUE = 1,
> +	__TCA_DUALPI2_DROP_EARLY_MAX,
> +};
> +#define TCA_DUALPI2_DROP_EARLY_MAX (__TCA_DUALPI2_DROP_EARLY_MAX - 1)
> +
> +enum {
> +	TCA_DUALPI2_ECN_MASK_L4S_ECT = 1,
> +	TCA_DUALPI2_ECN_MASK_CLA_ECT = 2,
> +	TCA_DUALPI2_ECN_MASK_ANY_ECT = 3,
> +	__TCA_DUALPI2_ECN_MASK_MAX,
> +};
> +#define TCA_DUALPI2_ECN_MASK_MAX (__TCA_DUALPI2_ECN_MASK_MAX - 1)
> +
> +enum {
> +	TCA_DUALPI2_SPLIT_GSO_NO_SPLIT_GSO = 0,
> +	TCA_DUALPI2_SPLIT_GSO_SPLIT_GSO = 1,
> +	__TCA_DUALPI2_SPLIT_GSO_MAX,
> +};
> +#define TCA_DUALPI2_SPLIT_GSO_MAX (__TCA_DUALPI2_SPLIT_GSO_MAX - 1)
> +
> +enum {
> +	TCA_DUALPI2_UNSPEC,
> +	TCA_DUALPI2_LIMIT,		/* Packets */
> +	TCA_DUALPI2_MEMORY_LIMIT,	/* Bytes */
> +	TCA_DUALPI2_TARGET,		/* us */
> +	TCA_DUALPI2_TUPDATE,		/* us */
> +	TCA_DUALPI2_ALPHA,		/* Hz scaled up by 256 */
> +	TCA_DUALPI2_BETA,		/* HZ scaled up by 256 */

HZ -> Hz for consistency

> +	TCA_DUALPI2_STEP_THRESH,	/* Packets or us */
> +	TCA_DUALPI2_STEP_PACKETS,	/* Whether STEP_THRESH is in packets */
> +	TCA_DUALPI2_MIN_QLEN_STEP,	/* Minimum qlen to apply STEP_THRESH */
> +	TCA_DUALPI2_COUPLING,		/* Coupling factor between queues */
> +	TCA_DUALPI2_DROP_OVERLOAD,	/* Whether to drop on overload */
> +	TCA_DUALPI2_DROP_EARLY,		/* Whether to drop on enqueue */
> +	TCA_DUALPI2_C_PROTECTION,	/* Percentage */
> +	TCA_DUALPI2_ECN_MASK,		/* L4S queue classification mask */
> +	TCA_DUALPI2_SPLIT_GSO,		/* Split GSO packets at enqueue */
> +	TCA_DUALPI2_PAD,
> +	__TCA_DUALPI2_MAX
> +};
> +
> +#define TCA_DUALPI2_MAX   (__TCA_DUALPI2_MAX - 1)
> +
> +struct tc_dualpi2_xstats {
> +	__u32 prob;		/* current probability */
> +	__u32 delay_c;		/* current delay in C queue */
> +	__u32 delay_l;		/* current delay in L queue */
> +	__u32 packets_in_c;	/* number of packets enqueued in C queue */
> +	__u32 packets_in_l;	/* number of packets enqueued in L queue */
> +	__u32 maxq;		/* maximum queue size */
> +	__u32 ecn_mark;		/* packets marked with ecn*/

Missing space after before */

> +	__u32 step_marks;	/* ECN marks due to the step AQM */
> +	__s32 credit;		/* current c_protection credit */
> +	__u32 memory_used;	/* Memory used of both queues */

used of both-> used by both

> +	__u32 max_memory_used;	/* Maximum used memory */
> +	__u32 memory_limit;	/* Memory limit of both queues */
> +};
> +
[clip]
> +.BI coupling_factor " NUMBER"
> +Set the coupling rate factor between Classic and L4S. Defaults to
> +.I 2
> +.PD
> +.TP
> +.BI l4s_ect | any_ect
> +Configures the ECT classifier. Packets whose ECT codepoint matches this are sent to the L-queue, where they receive a scalable marking. Defaults to
> +.I l4s_ect
> +, i.e., the L4S identifier ECT(1). Setting this to
> +.I any_ect
> +causes all packets whose ECN field is not zero to be sent to the L-queue. This enables it to be backward compatible with, e.g., DCTCP. Note DCTCP should only be used for intra-DC traffic with very low RTTs and AQM delay targets bigger than those RTTs, separated from Internet traffic (also if Prague compliant CC), as it does not support all Prague requirements that make sure that a congestion control can work well with the range of RTTs on the Internet.
> +.PD
> +.TP
> +.BI step_thresh " TIME | PACKETS"
> +Set the step threshold for the L-queue. This will cause packets with a sojourn time exceeding the threshold to always be marked. This value can either be specified using time units (i.e., us, ms, s), or in packets (p, pkt, packet(s)). A value without units is assumed to be in time (us). If defining the step in packets, be sure to disable GRO on the ingress interfaces. Defaults to
> +.I 1ms
> +.PD
> +.TP
> +.BI min_qlen_step " PACKETS"
> +Incoming packets enqueued to the L-queue may apply the step threshold when the queue length of the L-queue exceeds this value. Default to
> +.I 0
> +packets. This means that every enqueued packets to the L-queue with a sojourn time exceed the step threshold will be marked.

exceed -> exceeds

> +.PD
> +.TP
> +.B drop_on_overload | overflow
> +Control the overload strategy.
> +.I drop_on_overload
> +preserves the delay in the L-queue by dropping in both queues on overload.
> +.I overflow
> +sacrifices delay to avoid losses, eventually resulting in a taildrop behavior once the
> +.I limit
> +is reached. Defaults to
> +.I drop_on_overload
> +.PD
> +.TP
> +.B drop_enqueue | drop_dequeue
> +Decide when packets are PI-based dropped or marked. The
> +.I step_thresh
> +based L4S marking is always at dequeue. Defaults to
> +.I drop_dequeue
> +.PD
> +.TP
> +.BI classic_protection " PERCENTAGE
> +Protects the C-queue from unresponsive traffic in the L-queue. This bounds the maximal scheduling delay in the C-queue to be
> +.I (100 - PERCENTAGE)
> +times greater than the one in the L-queue. Defaults to
> +.I 10
> +.TP
> +.BI typical_rtt " TIME"
> +.PD 0
> +.TP
> +.PD
> +.BI max_rtt " TIME"
> +Specify the maximum round trip time (RTT) and/or the typical RTT of the traffic that will be controlled by DUALPI2. These values are specified using time units (i.e., us, ms, s). A value without units is assumed to be in us. If either
> +.I max_rtt
> +or
[clip]
> +		} else if (strcmp(*argv, "max_rtt") == 0) {
> +			NEXT_ARG();
> +			if (get_time(&rtt_max, *argv)) {
> +				fprintf(stderr, "Illegal \"rtt_max\"\n");
> +				return -1;
> +			}
> +		} else if (strcmp(*argv, "typical_rtt") == 0) {
> +			NEXT_ARG();
> +			if (get_time(&rtt_typ, *argv)) {
> +				fprintf(stderr, "Illegal \"rtt_typical\"\n");

use typical_rtt not rtt_typical

> +				return -1;
> +			}
> +		} else if (strcmp(*argv, "help") == 0) {
> +			explain();
> +			return -1;
> +		} else {
> +			fprintf(stderr, "What is \"%s\"?\n", *argv);
> +			explain();
> +			return -1;
> +		}
> +		--argc;
> +		++argv;
> +	}
> +

Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Thanks,
Alok


