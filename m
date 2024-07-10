Return-Path: <linux-kselftest+bounces-13457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5214192D0A3
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 13:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0812D285288
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 11:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE7019007E;
	Wed, 10 Jul 2024 11:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L7lCjpVH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DRDS28a8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A5E190071;
	Wed, 10 Jul 2024 11:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720610841; cv=fail; b=i1gYvm/0w+hmTezuCoipnmn2O2PhIlVvLabU3OzHk69CYR6bMTWfOgFr/6tfQjSzcM/f6c9ekITSXULAFBredW/roaTf/JyaJ9Qo7Uj1OeAgXhQn3VF4hLrTp8QbWO+ajC9O128NGujhQhMUXKACnnD3FNeJ3GctRb1H+OmIhO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720610841; c=relaxed/simple;
	bh=Y+LZ8/wWkpM5mxvw4k3V9/q65WhrzII5m30sUutkG60=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ph4A7hbtIGRZehy3lCTdCW34ewNUto1XX9CP2qALPjnpSS6hmNj8Fzw8XptKKLx5/HZglAaIsG5AwVkaxJ9PHUd+hag/Ih+WmxRxCIioHkpvTrAaB9T0IKGgcK6+fS7huMopFhXvCCAv3Sh2nWSu8tv2QL8e12z8M2o+z0n6P7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L7lCjpVH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DRDS28a8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A7fVWA029616;
	Wed, 10 Jul 2024 11:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=BPAfQkw+rJhvHTeE9rASndxXOWzME9+A9YXoUhgm1BU=; b=
	L7lCjpVHGLtfrvjIVVuv/Qg/GEyitw4trmxY6rLTo8Yh+pLuLj/wQsYhviZMDC8G
	qQlQsypZbhuIC3oT8JguVzxltQciQsnlxMII3zIcU9EeOn0p5tlYLghriZtG4f2K
	aPKdcQZ0IEXS/QhKM1RjASbvWwQlGLjNJxYTJ30IgTKKEuog5DurJ/VHOPjiywSt
	Sur/dB4Jxi2GR52vx36uXN0OLj1sk9JbD+DAqjXHbwk62NOlXhsleWs8nSRvFQRX
	wUI4xFmxoMWpIR+nmzh+XAilSSedfqT88+u+p7hKLNvdxHRVZ4fJ6s4Ox9AaO3Fa
	jWdq/3ko222udvs/nQx9lg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wgpy214-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 11:26:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46AB3MLJ005824;
	Wed, 10 Jul 2024 11:26:08 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407tx44xn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 11:26:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuWVYZEjmFqg9QVaelg3gE60nQSYWhuqFWMIljKtemrp3FCuIGIS6+yXkfI1vYmh5iZo5ThqwRNOU0DN4Jxgc8fBUpnT/mnBTNfGaDxtsRH0zjHZVYMUX6RhGXmV+NJBfddi0th/X+ya4xLOf91rs1ZZzBe07MvRcIPT0L0XIzSLA9BV7RmEqw2bt2uGvy2KFaDsC9/oEhaASSNBBzp4HZO2hBYFObG/4hJcD5J4dq8IpJbEEmLGCyB2+iaA5VDS347oV6hosiV6zDJwZ0+wOaI8xlofRe67lbjysH78Bf8vzhb1Qf2aiyeK3jX0U0pFFmBxe3Qty3XReUJq6Sq21w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPAfQkw+rJhvHTeE9rASndxXOWzME9+A9YXoUhgm1BU=;
 b=TTG9B/hnyrCxaxWJuShkUFX63SRDV9RF59ebtP5aEb3Q3Z4es5lKXtTuiw+AnNyy1d4JLRHoA5n3fSgSRUl6yyww40KgdADqf5vPqx49Ad6SPgJBRD5LMEeEjXHHFzmnGDdwZ5+GRvDk1FiBHpubsqdfAGirOk7BTb4n8YiR+YQz7XAlCm0CW4824I8m6Te83mmu5ERalwtxj3Q2mkWoS4u6i145rmnqdWAIhGJlYl7XPxn2sc9b8tI1heCJtcFEnSs+ulLMbgEu3xqKf2f2Wy0hRRBKJhPuG5TlDA89jpbYyTuW/YmYk8lhgbUWb2z+jdVgRBeaxBntJWHA0Oyn8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPAfQkw+rJhvHTeE9rASndxXOWzME9+A9YXoUhgm1BU=;
 b=DRDS28a8WmyZv6JpVRwHBKXAt1meakQoDcbSL68za0XLe8Tyrq83o/mrsr4e4rJNHEceV7y8B9ZoC1m33CrV9MFDw6ZXOz+Wl/LMXsI3jEfsJeXMFOx2catj/CVYAV+SD1fB9n/BHGPs2Zr+ODV39Q4+5xmS8kRwIo0svez+Ewk=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH0PR10MB5578.namprd10.prod.outlook.com (2603:10b6:510:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 11:26:05 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 11:26:05 +0000
Message-ID: <2f6ee147-2868-493f-bf2e-09d771d2e259@oracle.com>
Date: Wed, 10 Jul 2024 12:25:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: Null checks for links in
 bpf_tcp_ca
To: Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <cover.1720521482.git.tanggeliang@kylinos.cn>
 <3ac5d24825bdf666eae4089a8c69d8e97a6194d2.1720521482.git.tanggeliang@kylinos.cn>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <3ac5d24825bdf666eae4089a8c69d8e97a6194d2.1720521482.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P251CA0023.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::28) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH0PR10MB5578:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd89cc2-8d57-4054-3213-08dca0d31658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cHZ6clExM2FHZjc4bEt2Qitab0JMSk1rRDlMdVNvN0dXZitWSEMxTG9DMTRs?=
 =?utf-8?B?bXBWYkNDOGNYVEFGYmdsazdmRlB2Qi9OTzZxYWdNU0JNRGhZVU9hYkJDVUxN?=
 =?utf-8?B?bGRYNVo2OEtYUVEwMkJpTUFoeWVBVVVNZE00bjdpNlRybmZpekV5SDZzRDN3?=
 =?utf-8?B?U1JHTTdyNXVtQWlPYzFBMVNibjIrV1pmUU5neStHaTNwZzRFYW9qaVgxVXkr?=
 =?utf-8?B?Nkh6M0l5RDRLcVV2MHg2UUVkeDlqQlllRXJXTDhOdGZ4cVJEdnFISHBubkow?=
 =?utf-8?B?czFHUmFkL3BPcGdnNzRDZUZMV3BkU3BTOFFsNEhrNjJya3o5VG5POUtlWGcr?=
 =?utf-8?B?d3hpbmtWaUgrOEgzOXNwRDRta2Zha0VHVjNwcGF4UTZMTURRU3NIc0l3NExP?=
 =?utf-8?B?THBjLzhlZlA5YzhFbVpCTEdqZnpLVHF5L05wRlgxblY0WXp2cXVXTTl3Rmd3?=
 =?utf-8?B?aUM0djgrNm9jUDdqV2JaL2ZkS0lHT3c4VE9TZnZYUjc4aVBkU04xeUxuSmNr?=
 =?utf-8?B?bTFjZ0NYd2Raekd6dVhFLzFRSStjWWtmY0pabHBtQVp0d3RTd283eDZkK1l4?=
 =?utf-8?B?RndkMS9qbGwxd3RJQWYwRUM0bWVCVXU3Skp3VWQ5K2VLaFAxUFhsTmF0U2pH?=
 =?utf-8?B?U2ZJYmgxMFByVTFBN05zaWtnNGdoa3o4NmxFSzAzWkMzeTlsaUgwUllDZGth?=
 =?utf-8?B?bUxXWXB1U2pYRDVuUUVFYkVhVTFmdEs4SU1SeWY2RUdSSGdSZFJqejdpaGJL?=
 =?utf-8?B?dFlxVk1ucXg4ZXlpVnMwcVVEZW8wSS9taU40R3lET0FSWmxrdlIxUTZOdkxJ?=
 =?utf-8?B?ckVVdUYwdFY1blFJUU44a2N0VHl2NGlGTkpXR0xVWUw4MEt2K2VZM1FsUjZo?=
 =?utf-8?B?WDdQdzlGQUdSeTFiWDlQazdDUCtEMVJYaEdqcTN5c2xwTHd1dlRnQzloV0N1?=
 =?utf-8?B?aEF3ZW1nZGNsZTFqckNsREkydnZHSk5JVnVGTTQ5ZHRoQitKVW1XT1UwTTZZ?=
 =?utf-8?B?TStVQTV4MFVCSUM3bjRiUG5FSWpaVHQwREZ4M0xtTUU3ckpGZTVNTVVHbS9U?=
 =?utf-8?B?WW9GSzM0NWJQRDFWSDJrT1h0V3hlOFJTdEFEaWpxSGMyaG1NYUUzVHdFdVYx?=
 =?utf-8?B?MGNkU3k3ZTlGYlExMVY3RkF6VTNTd0pBTlZlRDFXMWNyUmR3SHFsUUErSW5Y?=
 =?utf-8?B?N0IzWlNHbCs3aUI3UzJrRk15eHl0UXI5YzM1TnBVTTdoSGowaXU3bEswcGR4?=
 =?utf-8?B?UnUxaGlvcEF3eGk5YU9aK1JNZTZVOWZHSTBlcmtHdUZLWnd3TXVVdDVDbm9B?=
 =?utf-8?B?cm0vT0Vpam1iUmhRWll2M2Z3ODBlamRXdm0xcTlrR3BSTmNESjlTTERsVkM0?=
 =?utf-8?B?ZGZOQlVyNzBUMEVFc3hEYjZNSEhpb3FLcjNDbHVGSjBOc29LcEV0amtWV3Uv?=
 =?utf-8?B?QXJMWUtxeDlUYVFsSmJuM1hMU1Zoc2JFTTV1NVlZd2NXUUtpSnVmUUVFLzk2?=
 =?utf-8?B?YXJIMGNJRkVaZFZuanUrR1dOOU1LRkxvVlN3aU9uK253QlhlOWpsbjVObDR4?=
 =?utf-8?B?b3o4eHFZVFRTVEdzRmJpem5xb21qTlkxRGZRQ3VZTHFVUk5iN1JUaTRBRklO?=
 =?utf-8?B?YmRYWjNrM0NQVHlSSlVwRVVaMEkvb3E3MFZ6MnlXaE16OEd6VU50SjVLQUYv?=
 =?utf-8?B?MmpxQmh5eVJQQW10KzhtcnJ6SmRrWjI5R1ZiNDFJem0weFdrQ0lLT1BPZjhV?=
 =?utf-8?B?SWpqalJGbGtDM3AwdVJoR3pQNFRwcW11MmV3YkpjNXNrTEN1YmJZZmdhQXVz?=
 =?utf-8?B?OUNrYnlBYnVsRm1hMThLdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TGNFVEM0YVVOQ1pQK2pRU1dSYm5IcW1YT3pBWkN4UlVUZEwrU05DWnBGak0x?=
 =?utf-8?B?UXdjMUY4bnZKV0VTaDZlRkJ3MFp3amlwNmVHMFJDUkw2Ykl2L0U0aEtESlFL?=
 =?utf-8?B?K3k3ckk5eUMzRTN3RG5zOWNlUFRsdjlqRDBzalZiU29EWlEvbUJpdnNtQjF3?=
 =?utf-8?B?VTB2WENDdHBIN0ljc0Zsb292VlVqNXQ5L2pucktTSlZycUtQY2xyNkRhcnN6?=
 =?utf-8?B?YWxoVHpqTlNXbFNUdzlqMHZRTTU1dHRoaGptOWEvanB5ZnF3VlFJVjI0eDJr?=
 =?utf-8?B?b1RxRklnMUZEZnB3eFE5dXdBdCt4OEZ2d21EaHJ1bUJPOWJrMjBPQUZ4WkFj?=
 =?utf-8?B?WXRGWGh3M0E0RkY4OEs3V0ZzZ0lodUVZYWNOM3dTdmlvQ3FaVStENEU4YUhH?=
 =?utf-8?B?QTVvTG12Mm1NZzdDUkRDVDBzMnpxRk8yd0h0ZE1ZWktySC9WczlFUHkwMktv?=
 =?utf-8?B?RzUyTmRFVjV6d0JkN0F3ZlZKbGdROUEyUHBZWDJJQit3VHFHSFJUZTVGMGhS?=
 =?utf-8?B?SUxFRXJSd005TkFvdDU5K0lwc1VzM3R2M0kwQlVCaXhQVzM2TC84Ynl2NVJ1?=
 =?utf-8?B?YnlwVS9oM3ZSREtFZ3p1RmZaNHhzYitKQWdneFVOTGZkR0p2VmorVkNHRENC?=
 =?utf-8?B?MUwvZEpkVEdnNEpVS0JxeUhCbjRXWU1nWjE0MEh2RVcraVhzNVB6NE1vYkNa?=
 =?utf-8?B?c09PUGUxTUMvdFR5MUxSRlhOYTlFaS84VFU4c3lsMDdvdU9VUXBrbzBzbGNB?=
 =?utf-8?B?SlArK3NWeEZRaTQvZmFYMW9TUG45dUhyMlRLSUUrRTVubGZXM0dtRXlsbi9G?=
 =?utf-8?B?VWw3ZXQxMUwwMUhlNys2OXlwVE9TNkZBeWVqeHV1TE1CeTQ5eENGR2tRWVR4?=
 =?utf-8?B?M01rR0t4MmxSd0RyWkFHeUU4d3NHaFZkWThDZS91UHF2TFluNGFwNUJncEdO?=
 =?utf-8?B?NWE1S0tTZjVoMExGbDRBZGVXdkFMYkpUbUFhSXV1M0E5YXZmVGx4UTRjREZV?=
 =?utf-8?B?Vk9xbFdpT2FHYjhGdnhjd29zUEZCOGpFdXpTbU5ibXJiK2Z3bWVpdkRHdk03?=
 =?utf-8?B?WVQvY2hmMTV6bTV6Q0hobFkrL0pLOEdmd2hTVHJGeWJ3Wm9zcjY3TTV0Ym1y?=
 =?utf-8?B?aURxV2cyOUFTRnZMdDFhV0tFV0l0UVl6a1U2VEkrYTdqakk0TldBeVJnYk5p?=
 =?utf-8?B?dERhaG9BZUFydWd4RVE3WDJyUGhEay81dVNvVDlMaW4xanM1eHMvaTdtTFpz?=
 =?utf-8?B?UHEyUUZLbEVUMlN5UmtVZmszbHh5aUgzdFpab0trSW1qcCtrNUsrZEFsN0xX?=
 =?utf-8?B?dm5NR1RsY0hlRVpMUHh3MW91dWl1Z0xjOFR4N0pOVG1ZMmhYbjNibEZFQmRG?=
 =?utf-8?B?eEtvS3RFbkdsQ2tVdk9zN2RVOUhaN1E2QmVKdUJSRWI4ZTByZmRvSUJQOURk?=
 =?utf-8?B?MHI4RVF3NTlhbXF3QWlHL1Zkdm1tVnZKNzB2bTd5dXNDNE9pRmUwUlZyMlBY?=
 =?utf-8?B?MmpSdFBPK1pnS3NjbGM5aUQ2SDJNRUJoUGJzU2ZOK2ZPTjhzS1gxMTliSEgy?=
 =?utf-8?B?MFBLYk9IMWIyb2R0NUgxY0N5VnVmRFB4SHhnVFRpMEtjZ2VHUmM0U0hnRDF3?=
 =?utf-8?B?eDllSTljMHFlNzNKMDBUZFpwTEZ4R0ZIeEhacWQ0eGN6ZU9lTGY2VUNLbnIy?=
 =?utf-8?B?WmltMXRWTW5TVGlkT29BTkJKUGQxWWhDR296UnpqZW1xZVN4ZlZzY3BCamJx?=
 =?utf-8?B?TEowV3hUbmwvbVJ0NW1qN2xub1ROTUE5UHFNTlZQZkZNWGhOTzdMYS9BVFFS?=
 =?utf-8?B?ZG9XVWcycU5vZ3UrakNNK3NxR3NYYWF6L3hXZC9jenVqeWpVNTZFT01mSTYv?=
 =?utf-8?B?dDhjOWg2amRXS1luZDJRR05paVRCZktnSmhrWTNOcVZtczMwY084UVBsY2FD?=
 =?utf-8?B?MUd4dWpBRDVOVWtTeVJPUVAzMXJLbjAzd3NvNWdIcUZQWEZSUDVQL3pYa3JF?=
 =?utf-8?B?WEtvTUNxRW83UlJoUDFGcjJhNTJTRmo1RGJVUjJ3TFRONVAzdEMyZVNBQ2FJ?=
 =?utf-8?B?ZFpHTjZUdUI0ampHc1VDNWxuSW9CN2VmekIvNDBhV1RwVFlNQTQrU1pCemRQ?=
 =?utf-8?B?QnZadVh3UXNoOCtxbDJQRGtkcm4rTWFQb2E0dGw4SjZnT2YyRy82UC93V05a?=
 =?utf-8?Q?1I5961yYRBqXYxvweDQ449E=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2skVVRpOCh1VndyzlOvTbFIu3+QSdexO/AxLmBiczCrpmwlwcz7mxHMGg1iKLJtNovyjdDJruK/FUHyrz1jfgtLoss2jmpn436/brDOvs+YhjXJiKi8ghL+HSCE9LqjmAIimUmN8ZAi9chVeYojpPl1Jwxk/oWGuf8V0REWqENhOl154/Mdj60DhYpIv8ox5Z1kmdkNFgLa9csvz26wN07kdYZFwZsbRh3yz6zt8WvbeX3Ndvq8TauNBHOcDSA8AMKfYh8CiRSuZeXb/cbTp5KbxAdzH0XdcwzEilTkRC5Eo2bQg7EhVZrULNmQk9HZMyPBXzNgosKe+1K8llnxjAJ1Lpb3tmG/AL/ZG8doCP10XUuxtVj+2L1yo//fVN0M2iiOl/I5/V3TBu5rqPyTDXZvD1MnJZnaNGSkLt5inmSMCYwlvIH/01XaNdRPGoFkonvR68brA4/K3+mS9Ys0hz4UB3Vavag1Ku1xDqPW7go2sHj6gxFG7B9ZI77XRmfQzR490AKGwERBlMPKmgctXINc9Flt1cWfcu1LvXU8P8Rc2FxK+140Dbgn/fYQcOdLbo7uFsGfuVzOLbbZ+FJcy0Ub1Rk7Bhq6MAWY/Ey8tckI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd89cc2-8d57-4054-3213-08dca0d31658
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 11:26:05.4434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bXatQUmVgk2CjKhfz3pV82t77a6r5AkjKSDlgnsbS505AYYlvilN5nQH96te4S3uiEpO8fjs1d8r5IMxUTKUJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5578
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_06,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407100078
X-Proofpoint-ORIG-GUID: hsg27K8zSCTsxdw_2tucHzmlqTsN9tzo
X-Proofpoint-GUID: hsg27K8zSCTsxdw_2tucHzmlqTsN9tzo

On 09/07/2024 11:45, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Run bpf_tcp_ca selftests (./test_progs -t bpf_tcp_ca) on a Loongarch
> platform, some "Segmentation fault" errors occur:
> 
> '''
>  test_dctcp:PASS:bpf_dctcp__open_and_load 0 nsec
>  test_dctcp:FAIL:bpf_map__attach_struct_ops unexpected error: -524
>  #29/1    bpf_tcp_ca/dctcp:FAIL
>  test_cubic:PASS:bpf_cubic__open_and_load 0 nsec
>  test_cubic:FAIL:bpf_map__attach_struct_ops unexpected error: -524
>  #29/2    bpf_tcp_ca/cubic:FAIL
>  test_dctcp_fallback:PASS:dctcp_skel 0 nsec
>  test_dctcp_fallback:PASS:bpf_dctcp__load 0 nsec
>  test_dctcp_fallback:FAIL:dctcp link unexpected error: -524
>  #29/4    bpf_tcp_ca/dctcp_fallback:FAIL
>  test_write_sk_pacing:PASS:open_and_load 0 nsec
>  test_write_sk_pacing:FAIL:attach_struct_ops unexpected error: -524
>  #29/6    bpf_tcp_ca/write_sk_pacing:FAIL
>  test_update_ca:PASS:open 0 nsec
>  test_update_ca:FAIL:attach_struct_ops unexpected error: -524
>  settcpca:FAIL:setsockopt unexpected setsockopt: \
> 					actual -1 == expected -1
>  (network_helpers.c:99: errno: No such file or directory) \
> 					Failed to call post_socket_cb
>  start_test:FAIL:start_server_str unexpected start_server_str: \
> 					actual -1 == expected -1
>  test_update_ca:FAIL:ca1_ca1_cnt unexpected ca1_ca1_cnt: \
> 					actual 0 <= expected 0
>  #29/9    bpf_tcp_ca/update_ca:FAIL
>  #29      bpf_tcp_ca:FAIL
>  Caught signal #11!
>  Stack trace:
>  ./test_progs(crash_handler+0x28)[0x5555567ed91c]
>  linux-vdso.so.1(__vdso_rt_sigreturn+0x0)[0x7ffffee408b0]
>  ./test_progs(bpf_link__update_map+0x80)[0x555556824a78]
>  ./test_progs(+0x94d68)[0x5555564c4d68]
>  ./test_progs(test_bpf_tcp_ca+0xe8)[0x5555564c6a88]
>  ./test_progs(+0x3bde54)[0x5555567ede54]
>  ./test_progs(main+0x61c)[0x5555567efd54]
>  /usr/lib64/libc.so.6(+0x22208)[0x7ffff2aaa208]
>  /usr/lib64/libc.so.6(__libc_start_main+0xac)[0x7ffff2aaa30c]
>  ./test_progs(_start+0x48)[0x55555646bca8]
>  Segmentation fault
> '''
> 
> This is because BPF trampoline is not implemented on Loongarch yet,
> "link" returned by bpf_map__attach_struct_ops() is NULL. test_progs
> crashs when this NULL link passes to bpf_link__update_map(). This
> patch adds NULL checks for all links in bpf_tcp_ca to fix these errors.
> If "link" is NULL, goto the newly added label "out" to destroy the skel.
> 
> v2:
>  - use "goto out" instead of "return" as Eduard suggested.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

Maybe I'm missing it, but I'm not seeing this series on
patchwork.kernel.org/project/netdevbpf, so we don't have an associated
CI run (the series is in the kselftest patchwork however). Is there some
patchwork bot magic that will do this?

> ---
>  .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 21 +++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> index d842ff64bc2a..efc1bf2ff7de 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> @@ -411,7 +411,8 @@ static void test_update_ca(void)
>  		return;
>  
>  	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
> -	ASSERT_OK_PTR(link, "attach_struct_ops");
> +	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
> +		goto out;
>
>  	do_test(&opts);
>  	saved_ca1_cnt = skel->bss->ca1_cnt;
> @@ -425,6 +426,7 @@ static void test_update_ca(void)
>  	ASSERT_GT(skel->bss->ca2_cnt, 0, "ca2_ca2_cnt");
>  
>  	bpf_link__destroy(link);
> +out:
>  	tcp_ca_update__destroy(skel);
>  }
>  
> @@ -447,7 +449,8 @@ static void test_update_wrong(void)
>  		return;
>  
>  	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
> -	ASSERT_OK_PTR(link, "attach_struct_ops");
> +	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
> +		goto out;
>  
>  	do_test(&opts);
>  	saved_ca1_cnt = skel->bss->ca1_cnt;
> @@ -460,11 +463,13 @@ static void test_update_wrong(void)
>  	ASSERT_GT(skel->bss->ca1_cnt, saved_ca1_cnt, "ca2_ca1_cnt");
>  
>  	bpf_link__destroy(link);
> +out:
>  	tcp_ca_update__destroy(skel);
>  }
>  
>  static void test_mixed_links(void)
>  {
> +	struct bpf_link *link = NULL, *link_nl = NULL;
>  	struct cb_opts cb_opts = {
>  		.cc = "tcp_ca_update",
>  	};
> @@ -473,7 +478,6 @@ static void test_mixed_links(void)
>  		.cb_opts	= &cb_opts,
>  	};
>  	struct tcp_ca_update *skel;
> -	struct bpf_link *link, *link_nl;
>  	int err;
>  
>  	skel = tcp_ca_update__open_and_load();
> @@ -481,10 +485,12 @@ static void test_mixed_links(void)
>  		return;
>  
>  	link_nl = bpf_map__attach_struct_ops(skel->maps.ca_no_link);
> -	ASSERT_OK_PTR(link_nl, "attach_struct_ops_nl");
> +	if (!ASSERT_OK_PTR(link_nl, "attach_struct_ops_nl"))
> +		goto out;
>  
>  	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
> -	ASSERT_OK_PTR(link, "attach_struct_ops");
> +	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
> +		goto out;
>  
>  	do_test(&opts);
>  	ASSERT_GT(skel->bss->ca1_cnt, 0, "ca1_ca1_cnt");
> @@ -492,6 +498,7 @@ static void test_mixed_links(void)
>  	err = bpf_link__update_map(link, skel->maps.ca_no_link);
>  	ASSERT_ERR(err, "update_map");
>  
> +out:
>  	bpf_link__destroy(link);
>  	bpf_link__destroy(link_nl);
>  	tcp_ca_update__destroy(skel);
> @@ -536,7 +543,8 @@ static void test_link_replace(void)
>  	bpf_link__destroy(link);
>  
>  	link = bpf_map__attach_struct_ops(skel->maps.ca_update_2);
> -	ASSERT_OK_PTR(link, "attach_struct_ops_2nd");
> +	if (!ASSERT_OK_PTR(link, "attach_struct_ops_2nd"))
> +		goto out;
>  
>  	/* BPF_F_REPLACE with a wrong old map Fd. It should fail!
>  	 *
> @@ -559,6 +567,7 @@ static void test_link_replace(void)
>  
>  	bpf_link__destroy(link);
>  
> +out:
>  	tcp_ca_update__destroy(skel);
>  }
>  

