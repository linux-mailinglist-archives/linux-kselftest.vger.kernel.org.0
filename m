Return-Path: <linux-kselftest+bounces-40245-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F8AB3B01E
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 03:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C300C5E1005
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 01:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329E119F40B;
	Fri, 29 Aug 2025 01:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A63Sh92J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LRZMlJfY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8931CAB3;
	Fri, 29 Aug 2025 01:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756429213; cv=fail; b=QTdRsXUadLCMLRfumGmmRTjoS824ZFfbisnu51OJWP5Go6xdi83Tf6aqTzc5iYkwLPfB5DyWccqjpAAvm1eFhuDYbycJABXQ4XStNdcoNPokTHpb/A1TzT5mntMtcFThJ0hj54ADtmQ/XuweXujAfufSuKhL15MnRFkaJUOqNZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756429213; c=relaxed/simple;
	bh=yVUsZg7ZR2GcuypOAD65L5ARnf2EevnJ1rYT1nX/xnU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D8fvowLF8MWQbMmiXOjsX8VrekSXjOmj6fRm+8jblLjtZwBJxZOoS+vgOGbdklE88USVSyuGqSEIE4uqzSAJE/YeiePpoTk4rYpN5KR881fqvOQujvMleBzh0hO5gWXZHN+DUQvDFsw3K8pSkbbtXCErJDApLRvfQzq09B22Izs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A63Sh92J; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LRZMlJfY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SLUtrx007182;
	Fri, 29 Aug 2025 00:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=TvYn2LpypaFaA3JAn2d6oODpDxHOycYdL7OWYwjVcys=; b=
	A63Sh92JZviBbwtN8i/AicxO0C79FZOQFUNIOqNfYgV86ptbBkujCFCA/b68E7pT
	Tex4dmZonVhtV3qWnz3Qe9AY4NeuTc9HZ7HaDxPw8CF1Mv9N+dMwjsjGZKgJmavQ
	P7haqSkFfSDrixVu2soOiWSKGHTOo2LKyZ9po9Jrd9NB+fVPo/x5AWJgZljQGJz+
	NHLAdKScgXL1l7razj8xhMqoQPmbVv1mOTViA0mZbKH5Z5o20MHFa9dr9jyBT8mo
	OqdcF7JuV/FiDRXYLU1mmKgrl2A9KjHtVQhsEWAhLoeZJYI+tnir8I6XrE/Fsy4J
	8L2T1qJEnMK7Nrj5LyUNHQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4e29r1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 00:59:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57T052l3014543;
	Fri, 29 Aug 2025 00:59:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48q43cjj42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 00:59:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngRozCIBNT1sfWsSEpDaM12+mnmNyxN9Ha3TXoH/bxDc9vNGJ57QqKtRewSuS8ic9K1+l2AeYNANZfsbaQhMyJXV3P5EGXkwBghsq+utHOnTlXcg7m7VyirK4H2GMUuXUV+u0Cf+TwFxN1h6i32i9+oLEjQm6TUvI/iC7tLTh2WVIAzS2JtjcV2O3NumRhuTrY0jZX83hRar/jYfYt8DUlBoLi5on1YDwdACaRvlPwi4ePh7NHWGzvi9cd8zSRW+ZVu6GW4LBv1Mydny81Z5WH46ZuEobHAC0eV0WwtdzVNqIAcagnEbhqI5SyMKjeCBMabKHve8OiMdlK0+fe4p5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvYn2LpypaFaA3JAn2d6oODpDxHOycYdL7OWYwjVcys=;
 b=dcpWfqxf+9+RKbcwsFxcGdxY1E2vCIb/6nv3G16xou/QAJovONQPamj5XVsexf/lMJ9eUcJ0jGxrSnRk8PDF+sMLHeBBzqjPFo4ZKlsqnTU23ayZZ40aqISI3q1GgevZAvUuD8OVVxSLE32kNqiPJUJMH+LihIgx0pICjHZ+xiL5dLQkR79HZzjg2apK5ZTZNDYI1rb6SbnmzNWtqJhXY8fvMnP0NCdr7UyPTUWi+f/b3sktVNeC/bEJdB8vtt1RW1cwF/IS3rjI5Q8fYvNL61OXf27KKrce7FJk0XbD6CXw+zGQkBTtCll2rxyyuPQDow8qGCh9gSIKe3++Wc/3qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvYn2LpypaFaA3JAn2d6oODpDxHOycYdL7OWYwjVcys=;
 b=LRZMlJfYkCNzo6hymPa4MQDkOscWrwahvvDlOxAfeefJ4sfxWWLn/SfZqEB8jH3NuKEm2lDOjhcXr2Lx+hasDzwZlygjgGuoBbaT/uGiI8zdt6urJOb47P/yujkZIhIrgYDhhds32rD+CRI6TF7o4NRHtUHQwvZlRKivC9jFJ/k=
Received: from MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
 by DM3PPF76BAA8D48.namprd10.prod.outlook.com (2603:10b6:f:fc00::c31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Fri, 29 Aug
 2025 00:59:48 +0000
Received: from MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15]) by MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15%7]) with mapi id 15.20.9073.014; Fri, 29 Aug 2025
 00:59:47 +0000
Message-ID: <18530429-cac2-42a4-891e-24033dc54461@oracle.com>
Date: Thu, 28 Aug 2025 17:59:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] mshare: selftests: Add test case shared memory
To: Yongting Lin <linyongting@bytedance.com>, khalid@kernel.org,
        shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org
References: <20250825145719.29455-1-linyongting@bytedance.com>
 <20250825145719.29455-5-linyongting@bytedance.com>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <20250825145719.29455-5-linyongting@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:510:174::13) To MW6PR10MB7660.namprd10.prod.outlook.com
 (2603:10b6:303:24b::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7660:EE_|DM3PPF76BAA8D48:EE_
X-MS-Office365-Filtering-Correlation-Id: dc4dd110-98dc-4ab3-deb9-08dde69759a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGFabS9TdUVOcHBkcVM1NXJkYjl1anJpakprclJDdmZnR3hEVFF1M2F0cWVk?=
 =?utf-8?B?TlFNc0ZWeTNvOFE1bXRFWlpuRlgrZkYwTzFJV3M4MGdCSVJCZHdiM3NKelQr?=
 =?utf-8?B?RjRLNzMxeWdQR05OcFl0eENkeWhZeG5sK2U4elRXMkJqbkFka3JQckltRnlm?=
 =?utf-8?B?OVozZWVOSnRsanVEWEYvamtjS1pGVUFwSjg1N1p5eG5JVjN3dTRhQmc0RnZD?=
 =?utf-8?B?T1dBVVhQZm9nbXZROURlV0JwTUdaNXNTd21WUTBKNW9DTlIvSXdVVnM4TjFX?=
 =?utf-8?B?MjZGb2ZlMVlQL2FsYmkvRzNNVWxUbHJOdUpVdXBwWXUrVDlkcCtzMmhRSUlE?=
 =?utf-8?B?bDNkaGZXMDRmcXVsS0JBamc4QmtWNlRyWFlwVGFjV3VRM3lHTGJVU1B4bmlS?=
 =?utf-8?B?cUxCd2MzRTRjc29JTldJak85Ny9oRTcyT0lET0t0aXF6NXczdjJiWERDMGV2?=
 =?utf-8?B?eTk3RzgwM2JsY1NldFBNb2VrU3p3cWZlQ1FEbEtMY2w0OVEvamxIV2Z5MExw?=
 =?utf-8?B?YUpWRkZib3dNUlE5Y0pxVXpSbU1MeEd4QVpuS2VObU85MWFlU3NHZG5XOUJa?=
 =?utf-8?B?am1oR3Rqb0RQVkRwdUhqekl1TjMrVmZxUFlaRHcxNWNERGM3UVBXcWtzY1Vs?=
 =?utf-8?B?S2pYTGFGdHNoQUdNdDJIdk53cUp5WEZ2U05PWWFxMENhbVpBMmlPMTF0L1ZD?=
 =?utf-8?B?ODJHcmltN3pWZ0REa01yUEkyTkNuU2xTQXV0NFNDMU9KOUczdUpQeGgrbG9K?=
 =?utf-8?B?SDBHY1ZESWp6MVdKSG54TGlSamt4TEFrVlozcGdSUW1qQm9VdUViNEV1K1dx?=
 =?utf-8?B?bkdDem1abitES2daZTNvQmpVZjRUeE84Q0M5UmRkc1JXRzFvckxJVys2NmhY?=
 =?utf-8?B?ZHQ0Ymgza0xMTGtQZ2psU0VkeGJqV1pyV1l3RXkwR0IvdC9KUVNLbnNURWZz?=
 =?utf-8?B?WXRjSXZuMzhkVmwyUHNzVkZoVlhyZm9EV0tNSmF5RGZodTZaOW1jMGxHOWNu?=
 =?utf-8?B?TitaM3hYT05HemUyeFl4RXlzVDRUSElJSVZPYTJKeDNDK2drdDNQOFNkbHE5?=
 =?utf-8?B?Y2JsdTlRUzdxVHA4blkzR1RkZVErRm9KZlNkTXkwVVA2MVg0MVRqZ1ZLRDlX?=
 =?utf-8?B?LzNBN0tuUEZNVlMxeGVRUjdWYm01cXRKRzFieEIrNTl1SEhUSHdWQm1aM1o1?=
 =?utf-8?B?V2I0UWM0NThOcVVuUlhjSUdOOU9RSzh5NWJLcWwyT085YVQ3eE9SWmpNdFYx?=
 =?utf-8?B?REQyRjRPU3lGZlJqZ2lKaUswUFZDYmROZ1JRRitVZmJWK1lMUVJtOHNKZVBn?=
 =?utf-8?B?SE1XT09wK3BiTlFjWUdublZIeW1ndDVuaWJlY3R3TmdUN0gzYzFhdWZOVERu?=
 =?utf-8?B?U2tIdUZsekdWRVcxL2xrMTZBUENqaE1MNjRleDExSzZvMzVMZTBPQkcvd01L?=
 =?utf-8?B?NFdQVnozQVUzL1MxSUtaeVNUQ3h1UGpsbHRheHI5MTJBb1AyRWRtOEVHa2pS?=
 =?utf-8?B?QklHVmNTK05RdjZBZUtiSXVIVFhRRzBuNFU4NlZIT21ZUVRTUVRWS3ZWNmVN?=
 =?utf-8?B?d0hBdE9NR0w0QnJwN3NiVFhFb3VMU2pxNW5iT0JOMFZpYlJIcTJzajNDd3gr?=
 =?utf-8?B?UHY1b3lYSXhScmNZMkVUd1ppZGxpYklnYUszOHoyRVhLYmFOTE5tcVdaN0Yv?=
 =?utf-8?B?SjRkM05kZE1yOUVoTkVrVURta1gvc0FpN1lESnNZRmRFTk43SEFZWmxJSnd2?=
 =?utf-8?B?a2VUa1g5b0pnUENXSHZBK2dsVDF5bWY2YVVSRXczYjlXVnlJTURDamxpMEl6?=
 =?utf-8?B?SEFhNTlFSEJxcWJrVGlFampUWUtiaHprY3B3QUxGYis1NFoyN0FPQUY3bkhD?=
 =?utf-8?B?VVloa1VXWFYyK09KUE9ZYndObkJ1WDZSaTZnaTNETkp6Rm9kbm03VFo4WVZK?=
 =?utf-8?Q?NQj9XWs1Iyw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7660.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZksyTEdKSVBpTFVzanFvVGRKRHExMWpKS3Y2YXNZaTBsS010SkNJSHZwTUpN?=
 =?utf-8?B?WkVxU2FpaHZwK1Y4eXVxakNWZFUvT3c5VHIyZ0RZOC9jQTNMYkMxQkRIa25Y?=
 =?utf-8?B?TlpwKzd2NGh6NnplRlBQMG5wWnVGSXpTUUpMMFhTNm9zYVVITzRWMUFhQTkx?=
 =?utf-8?B?aStpOVBMVUwxcjhQRllRa000N1pWZGVveGpLNnd3R1o4RVIrZDVkT2d5MUFy?=
 =?utf-8?B?aW9MVmxTc3IwOGw0d2dPZ1hZTDN1aTA3QkFPdWhhSUJobS81R3BkYm5MYWIr?=
 =?utf-8?B?TVdoNlcvMjA4UjMvbSs2VmNSQXRkWUYzSGpKeXUxbUhxVjc5MDBQZkE0S3Z6?=
 =?utf-8?B?am1PUTFDYXVESmdram1CcW5XOWtkL2ptTjRTTWhFK2pQaXhJVncwdEluN2x1?=
 =?utf-8?B?cTVPV2N1dFp0RGYzUENTS0Z4M2gwRXU2V0k2a2JiY2ZKem5Bd0llNEpiRzRJ?=
 =?utf-8?B?VDJHSnJuZjJiVVJTbEhpaEhHWjN2amlEY082eS9LWExnUDlicjBNMUxLQTUy?=
 =?utf-8?B?UWYwV21wWnk2MWZONEZWeWRINEFQQ0N0ME13a0hPbzM5SndJUkl4WUpyWWpO?=
 =?utf-8?B?Y1lPM28ycCtpZkFZZVNUTXBWYU5RQktUL2ZZWmlMYjZDSlYzdHErbklDM2g3?=
 =?utf-8?B?c2FPQTdmUkYrbXByb2tTOU1acDRWV29Ldll1bHhhS1JaYkp4ZFRTK2wyRzFZ?=
 =?utf-8?B?RVAyeVE2VEg2WW51TjFvUjQxSEg0NkdJVXFsVm5oUWNJL0dKVTFaRkFJT2ZN?=
 =?utf-8?B?SmloUUMvSU1VNkZTSHBJUHdvUE1wTzZOakZJQnVUSDdxZjdQZzZJWGhqUmtv?=
 =?utf-8?B?K2xIZm5RWUV2aWlrMzFaTzFwaFd0em9OdGJqeG5nMTJtMXdGZWtZNE5IRXZv?=
 =?utf-8?B?WnJJbHZWK0tzeitFS2FER0lTZlpxRzJ6a2dPUFZjKyt5R0RmRHViVjE2TEF2?=
 =?utf-8?B?L1V2ZFd5UzI2OXRNcWdBaHFFMHhKZ1RYZzBKR08xRVNKRGR5OUFjZ2JMSmRi?=
 =?utf-8?B?Nkx1ZUNTRXRrdzA5d0pjYm11amtpc09vZXBwL2ZLbGpzNmNwVUdEcGhDR0k1?=
 =?utf-8?B?ZnVvZUFhekNIMk9ib3k5MHhaWEFTa21Cd1ArZHd6RGNHWEFHZTBwTzNVN0lm?=
 =?utf-8?B?OGVQd2lNT1NYL1dzSXpmNExhMm9kZ3d2TXg2Q2QyZnkxMnEvS216eTR3TDVM?=
 =?utf-8?B?Mm1ZZGp6MzQrWHhEeEQxWDFjdncwdFVUaDFBeXJWUC9oMTJuOVd0eG8xN3Nx?=
 =?utf-8?B?VHM0Q3lZMlRQUVY4dWNzSFR1QVIvTkwxQlN0eHltM0FpME5qalMrZEUzODZS?=
 =?utf-8?B?YkNUSUQ5VWhObFFPckZPYUFiVFdZbkVhZUhxQlBLUzBHcmIvYmpHaEo0eUZr?=
 =?utf-8?B?UGJpVkNGdzNjbytaNGduUHBJZlpXUWdoRWgrQnIybmdQam9UUis0TndNSVFQ?=
 =?utf-8?B?eGZtcGQvc09oQmtYaFJMZmdXekxMZW1CcTBuM3lqVENUbVROYjB4Y1ZsUXZO?=
 =?utf-8?B?UlE3RitVSi9TQnJsRHBWOVNLZjNXVW9lYXZCSGJUUExvNVQrSVFHeFAwU1Iy?=
 =?utf-8?B?OTUrdEdGNnpKSnJCN2hYSUpGQXBia1RQTWVzZVFvd2FLbkJKQ0ZNeUkyc01J?=
 =?utf-8?B?Qm85dG9sQ2VySy8vT2hEdy9Vb2dtQzJtOHRQa1V2NlRrUlYxczhXWTJHMnhK?=
 =?utf-8?B?N3o5M0hnRnhHckprNEhJdzVYTzhvdndJOEE3WnZyZDR2WUlVWjRuRm0wRkFs?=
 =?utf-8?B?SW9MQzNjZEUzRlpLckZHeXdWdkh0VkNRbjB0WCt0VStiRm5EOE5RWFdKZ1F3?=
 =?utf-8?B?NDZKVzh2U1BtaklhM2lDTTZKb0JIdFcrOEdnV1RmVVNpMEFocTBJdm8wVFZU?=
 =?utf-8?B?YjIrUFJUSXlOWWtCa1J1NVhTNUxZNGVWZ0xnV3Q2NUZLa2dTMnZOMDMwMVhT?=
 =?utf-8?B?b0FxbDRBYTJXQzg2OXdzNnZNM0hSMFc2aDVaWVk3SVBLaXc3OVBpTEtzNE5m?=
 =?utf-8?B?TnFlMGJkci9iTWYvdFRKc1hsOGNONDMxSEJMck9EMFBtdUc0cjVwNWYvNmF4?=
 =?utf-8?B?RldMMTNiVldseFFBOG9VUGd3MmxiWm9UbjNCNDJoN1pmbDhpcENndW1CWk9p?=
 =?utf-8?B?dnI4eU5lank4SDkzQk5JTEVIelBtK2EvcGxncVE4TzVXVmtxanh0Y1hEMWNT?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i5iMQPWGpLyiihQA12srDHRLOfD+yxbXAp9h1x8cLmBD4JdDZA2l29rAcxVNzjZtDUbGyVqhclGuc5Ruj2ymcPHfW4gsqJKKJ6gxfn7qoFNCqpw69uuNWLJGjp1P8zKvrRhGgH61GHh4lBvvBdGHx6LD9uZQ6XUP1zON9RDWB8IVqq367Hc9T6thNvJljUCLtkThhKvScrJKAqOh6uIe/qYwws9RDPT+9tlXt9hG0LOcvEuC34GTW0QG2o87pvZvjoFjlsOrO+pSJelfiY2ypgF8X2Jlv+v/JUXSqFWIZBf2jkL8gHhy724dCLdTZwLBMEzImtquMdWj6IyZjVSn3ykNyut1mT09iVysr8o4Idpi6mN0MlSZByRnEnmCtvFoPIt+xxnc0rukFmW+bvCSS7EI3fHQz7BvSV41Y2XHQWPxk6JULL2jnYquq8SxJYThdqDBYgCztGoiwh8AaVMTbtc7uZZ9rUY3A0m8E8MZrdqecxz8tr8tVi9ofNIj0PIT1fVCuaZjYDYUotxIXCqTzq7LGHeayFvV8LUjg1BkAtkaBsbnSMgZfzcgMC2+rQJ1oipEpgrE4uNuaKxJxoMJZGCyKLjR/K0LwRc7rGR6gEk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc4dd110-98dc-4ab3-deb9-08dde69759a9
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 00:59:47.8611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zHTdoX2s98RQokU6XN2WUfn1PEjdTE9hqP8dnABmJQHGBvD1vGgjtzf2ZwYDDVi94OBBb3zkX+qrkbo2JpipcfH3ljPH3JIaLbSXfqmMbvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF76BAA8D48
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=987
 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508290006
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNyBTYWx0ZWRfXwv826/YZ8QpS
 txwggzFuLXVrNcd/0E3uDZ0clYGOS49sUUFPV4q0XY1t271e1pjxrHLGDBDda6wGc8JvAk28J9d
 4qRUJhjJ0zG7JCSs1V4NsS6LfvkYceNV2ixZCG9lyQACB4naL0tquH791KwL7vPseeFBQ5o+XZD
 T9o0pDVuMfdQGtC6Kat6XffOJdpYI5weOCqelpedQS5R+Adbs8HnMjVnlYUOzE4s0RyfZ/gPQQC
 Vfst9WsekLU8V08BTHezZRvKpFRoOdR9eXSBArgjZ+gU3PYodfp0dHhtl8e4hFAvkqoDgT9O8kn
 lHNmMfFzg4C3QOXNxygQsUfTZS+F2xxFOWahPQlEpvLeXPTTSCpf+A73OM7mJ0NodgTdNAk+r75
 z0+bYamkMSp+292v+pRZR7S5QTd0Bg==
X-Proofpoint-ORIG-GUID: vIxQolOoXED__4Vs2cPhSvqJ4SdBivFL
X-Proofpoint-GUID: vIxQolOoXED__4Vs2cPhSvqJ4SdBivFL
X-Authority-Analysis: v=2.4 cv=IauHWXqa c=1 sm=1 tr=0 ts=68b0fb88 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=968KyxNXAAAA:8 a=3OVWkxgYNdqha19WIGUA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13602

Hi Yongting,

Thank you for doing this. This is a great start for testing mshare.
I do have some comments below.

On 8/25/25 7:57 AM, Yongting Lin wrote:
> This test case aims to verify the basic functionalities of mshare.
> 
> Create a mshare file and use ioctl to create mapping for host mm
> with supportive flags, then create two processes to map mshare file
> to their memory spaces, and eventually verify the correctiness
> of sharing memory.
> 
> Signed-off-by: Yongting Lin <linyongting@bytedance.com>
> ---
>   tools/testing/selftests/mshare/basic.c | 81 +++++++++++++++++++++++++-
>   1 file changed, 79 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/mshare/basic.c b/tools/testing/selftests/mshare/basic.c
> index 35739b1133f7..2347d30adfee 100644
> --- a/tools/testing/selftests/mshare/basic.c
> +++ b/tools/testing/selftests/mshare/basic.c
> @@ -3,9 +3,86 @@
>   #include "../kselftest_harness.h"
>   #include "util.c"
>   
> -TEST(basic)
> +#define STRING "I am Msharefs"
> +
> +FIXTURE(basic)
> +{
> +	char filename[128];
> +	size_t align_size;
> +	size_t allocate_size;
> +};
> +
> +FIXTURE_VARIANT(basic) {
> +	/* decide the time of real mapping size besed on align_size */
> +	size_t map_size_time;
> +	/* flags for ioctl */
> +	int map_flags;
> +};
> +
> +FIXTURE_VARIANT_ADD(basic, ANON_512G) {
> +	.map_size_time = 1,
> +	.map_flags = MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED,
> +};
> +
> +FIXTURE_VARIANT_ADD(basic, HUGETLB_512G) {
> +	.map_size_time = 1,
> +	.map_flags = MAP_ANONYMOUS | MAP_HUGETLB | MAP_SHARED | MAP_FIXED,
> +};
> +
> +FIXTURE_VARIANT_ADD(basic, ANON_1T) {
> +	.map_size_time = 2,
> +	.map_flags = MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED,
> +};
> +
> +FIXTURE_VARIANT_ADD(basic, HUGETLB_1T) {
> +	.map_size_time = 2,
> +	.map_flags = MAP_ANONYMOUS | MAP_HUGETLB | MAP_SHARED | MAP_FIXED,
> +};
> +
> +FIXTURE_SETUP(basic)
>   {
> -	printf("Hello mshare\n");
> +	int fd;
> +
> +	self->align_size = mshare_get_info();
> +	self->allocate_size = self->align_size * variant->map_size_time;
> +
> +	fd = create_mshare_file(self->filename, sizeof(self->filename));
> +	ftruncate(fd, self->allocate_size);
> +
> +	ASSERT_EQ(mshare_ioctl_mapping(fd, self->allocate_size, variant->map_flags), 0);

The tests should differentiate between how much VA space is allocated to 
an mshare region (i.e with ftruncate()) and how much memory is allocated 
within an mshare region through the ioctl. While the bounds of an mshare 
region need to be aligned to 512 GB, the memory allocated within it does 
not. Right now the tests will try to map 512 GB or 1 TB of anon or 
hugetlb memory in an mshare region which will fail on smaller systems to 
due to insufficient memory. Better to allocate smaller amounts so the 
tests can run on more systems.

Anthony

> +	close(fd);
> +}
> +
> +FIXTURE_TEARDOWN(basic)
> +{
> +	ASSERT_EQ(unlink(self->filename), 0);
> +}
> +
> +TEST_F(basic, shared_mem)
> +{
> +	int fd;
> +	void *addr;
> +	pid_t pid = fork();
> +
> +	ASSERT_NE(pid, -1);
> +
> +	fd = open(self->filename, O_RDWR, 0600);
> +	ASSERT_NE(fd, -1);
> +
> +	addr = mmap(NULL, self->allocate_size, PROT_READ | PROT_WRITE,
> +		       MAP_SHARED, fd, 0);
> +	ASSERT_NE(addr, MAP_FAILED);
> +
> +	if (pid == 0) {
> +		/* Child process write date the shared memory */
> +		memcpy(addr, STRING, sizeof(STRING));
> +		exit(0);
> +	}
> +
> +	ASSERT_NE(waitpid(pid, NULL, 0), -1);
> +
> +	/* Parent process should retrieve the data from the shared memory */
> +	ASSERT_EQ(memcmp(addr, STRING, sizeof(STRING)), 0);
>   }
>   
>   TEST_HARNESS_MAIN


