Return-Path: <linux-kselftest+bounces-14385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B429C93FBF3
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 19:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A003282A67
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 17:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342AB156220;
	Mon, 29 Jul 2024 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KPxbFS6L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ax8+8y8C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0B67603A;
	Mon, 29 Jul 2024 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722272425; cv=fail; b=IJPtesxwAbQQ4+mCS/xKRbkddcKjJhsrMtUmUsraicnEVY3m6UA7aAM7YsZbbmD1qRMd/IPjnPyAxIQItPlVumG/fV3BbJIQIox4fIAEWSm2aZLRryUS7rz9k4eT+50qF5FEGH4Q1sS9N74YPyv5oTdjF1ST6st2jhhspjhI3JU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722272425; c=relaxed/simple;
	bh=OXjRi7/LLPWmpLfjv0YiKvCkMAltJ4B5mdWB0xVIorM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Aqp7iIA8Jg7VuMlHsVKYWxh1P5xlYpNZgprxvPYIFhxlgyVXFwoEx6ua4w/CVz0ck6dEcuuE1bG/WsgqZuuI2tyshAedRnfZnGsBFYZTmIkNJco5fVoNl/BC+lRQDJsVUOSfWhFFJgWMwUM4SFGj+dHGqVWoACZne+b0uRJeHmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KPxbFS6L; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ax8+8y8C; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TFMdlq018589;
	Mon, 29 Jul 2024 16:59:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=rjmn3a5oP3+8lcdISnkKpZw6fJ+a6zOvYpBanNQbXfU=; b=
	KPxbFS6LOONK8Fors2PnATrM2g7FwuEfzZwanCyyRtHf8OIf/d/PUtuspgFBwMJC
	w3HfukDFQbHhYQoj98oZ22Ze5jkKBdjcYgdBrYwGsm4WFhDxG2XBQMcXbiFnIU0a
	swM9OVwyPtrPUoQADB7CdFnOG8vglZ/+GkF/CiQVpQNbgMa9ElYjUueaTjA+O60C
	x5BUTjoE1BpzyEBdzG1+K5Wu7qbFU5hbBCw9nfoq6PhX177AjFgtoCPH91RyUZl8
	cjPZYZ6gpx5UvUvVmW++mnY9nKyVoZs52DjrEvB5yJyVprwhnuEXSKAYAbE5myIJ
	ZM4RLdQx0vsdM0OvuZU0Fg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mrs8k3e8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 16:59:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46TFg9Di012285;
	Mon, 29 Jul 2024 16:59:54 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40nkh5fsm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 16:59:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XmacqUvWOdkeNANhuB2fvVUWl3TjrGi+oThI8Z5y5tAA5q3rtzK3GOFWJnxBT5AWewiHW+Lt9piWSkBysuXJkciUH7wM6XnsuDgRMqyUKIFb9vb2+n5s6D5kd5vNMvP+Yp58pBUaE7AokN+PcTeQvAtQQ3uSYOyiR5soJHBvcxJzS6UqQdMz37lgu+GTXQdpFe3WQZpOpDP5fqQ8sFvUnOYvK+FHrVhycNCwtpj14G65UQSTyOMWs5Poszk7pDU2m1lrnG/0t7BKopBgORW5s+yuxljbpYvL/Plrw8bhPPLSMwPE0xEy76MctGjf47tYJZCvd17PregeXuKhp4uB2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjmn3a5oP3+8lcdISnkKpZw6fJ+a6zOvYpBanNQbXfU=;
 b=RO/UHt5KZpWo0h7etxExvImAfeNsaipoGXJ5fDDis1WtgyVEDmfZslgWKzcSW9SECdmuk1mOJDytsaXZFhmMuiYw1WheFLCU1unoGH+JVVy3kgSh5MjkS1ntCcgnG7enQhJp38G2N5hLjHC4ts+cxxqp/g9nPgAKBpCNRq9+nD8y0HmS4rxIn20lnxidssOiimovbaPFtOGxg9ADVNRfyuqFTPGcuaKiunPTacBH3bR0qJi4kFW0uDqNvqG+rVXMp0ZYn0qoRZXPEM1hNUStD9fM9RBIAsr6liYAqzYbUq+arnvhZHCVYawOxCwvknepw8oad7UD+vXROzHpycrt7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjmn3a5oP3+8lcdISnkKpZw6fJ+a6zOvYpBanNQbXfU=;
 b=ax8+8y8CLkhDfpcqhlE8yXD7sYN1hW/KQixkg9azR0ai2aA+3cq5OX29Ab4EtSuQLDV7L4KGuoegU9KrAsh9Qf3GfDUdR5YQLv1sftkmVoKeKslJVQ1IyMTbdTS33k2T0VmJxEIsCWZsc9yPwPDW6L/kQAI3rYKbGFbyxgQyj5k=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DM6PR10MB4170.namprd10.prod.outlook.com (2603:10b6:5:213::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 16:59:51 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 16:59:51 +0000
Message-ID: <39781c99-95db-4c48-b363-a482a426e3b0@oracle.com>
Date: Mon, 29 Jul 2024 17:59:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/3] selftests/bpf: do not disable /dev/null
 device access in cgroup dev test
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240729-convert_dev_cgroup-v2-0-4c1fc0520545@bootlin.com>
 <20240729-convert_dev_cgroup-v2-1-4c1fc0520545@bootlin.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240729-convert_dev_cgroup-v2-1-4c1fc0520545@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0035.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::14) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DM6PR10MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: ea472db7-c78a-4bd7-44ac-08dcafefdcae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTBvVllobEJkU1V3NmV3cy91RzJicmVmaTdvc1FnUHU0eEdUL2d4RHBuWjQz?=
 =?utf-8?B?RGl1aHVPR0FyRW43RFN1bVZiV3M2QnVLMFY1bWhVWEhVaWZ6bXhsZXVpam5U?=
 =?utf-8?B?a29ieHc1cWI2TGdidUpsdlc2dXFZb2JGUGhKb200SHB4SEZhazZ6dkRiZjNF?=
 =?utf-8?B?dnI0dWtsLzVrVnc3YldJVDNyWDZMYjAxNzRaWFVRbkV4WHFQcW5WM0g2VHJu?=
 =?utf-8?B?UHFUcTVuZHhkaUlVUEp6eGxKSFBmQjdqMmVMSzNyQ04xanhhK0dhSklZUGdk?=
 =?utf-8?B?cER6c1l1eDNlY2JpN3JOVEpjc3BwQmNTMktQTVBKNXFqSExYNkd0K2FJM20v?=
 =?utf-8?B?Tm5IemY1a0hSOThCNUVlODJUa2ZCdW9KUDFWTlpOYzBnbE5ZZ2dJS0FaNmNu?=
 =?utf-8?B?bWxzWDE3ZDlGcWErbElvc0t1WHlZUW5xR0wvcVBjVHZVbkQ4cWxkWmFNSDAw?=
 =?utf-8?B?UVVGQVFJU0dzbDBTYnM3bDZZbUdSc2F4aW43WmpQT0Nqa1JLcElGUFRHSTB3?=
 =?utf-8?B?dEs0cmxsVE9RRDBlUFArV3pxd0FwRnd2akpkYy9YSXdBVWNxMHdpR2FvQzg5?=
 =?utf-8?B?WFdVUk5EczdydmIxblJGcjAvMEVzZ1UzU3AwYkJXSEU2SUNSb3VuZGRpNk1v?=
 =?utf-8?B?MHN4V3Q2NGp3OVcwTjFyQ1F1REc4VW04SHp5UVM4T1RsREVhNTA5b2ZIcVRX?=
 =?utf-8?B?VExvdXRqdVdIOXZkem9Lak16T1VyM1c3UjcrZUx6VmJJUXgwZTQxOUVDT0Fl?=
 =?utf-8?B?WnJDRWtWMm5VdmdkZVZCQnFXWDJuUm8wZWxkd05hNzhUYmF4bFh0eElqWTMy?=
 =?utf-8?B?UFJKcXJCZ3dvNnBucEYvVU9VUFBSM0dCdDNnT09IaGRzRGpFUm1CUUwvYkZt?=
 =?utf-8?B?ZUZ1L0RUY2pTUnNUbDdGVUJxaG80RUIrU1kzY3I3bkV4Zmo5WVJWdDJ2Wjhm?=
 =?utf-8?B?UGxhWlFGKyt6TldHTzR1YkxtOFQ3N2NHWE9hWldVSWk3b0JadFVZRVBCVEdo?=
 =?utf-8?B?SGo2RnRCcDhzdC9OYjdkRmRRdGZIa1hCSUJmSUcxU1EwQ2gyaG9QZFpxYUVM?=
 =?utf-8?B?SnBXdmc3RGtuVUZQUG1qK3h3dXpNcEdsZFhxTXZZUEdHR3NQTW1RZ0dUeVRJ?=
 =?utf-8?B?Y1dnOXNyOFh4NEJHSUw3TzArV0piSXdPMm84TGM4bEtrY05OaGhSd1JCRm5F?=
 =?utf-8?B?d3JqQ2xOUFRvRkpTODFUdHErbmxJOHpnbS84Z2ZreEJWU0pBemQ3Q21lem9C?=
 =?utf-8?B?ZTBzb0s2TnJ6L3ZVLzdhTDlRdUNJaFN4Y3RlaXRodytPVExLdmVmRUZvS3hh?=
 =?utf-8?B?K1MrZGxhUWhldXAyS29XeXVrSWdvVDlGTVB6dm9IWWNsdWJ4aW10aUxyZGNr?=
 =?utf-8?B?UVNHbFhMK0gvd3drMk1wY3JrR3pPTmNTU253ZVBpb3N5R29WNzJ3UWxyb0hk?=
 =?utf-8?B?aHRLSDlxcDN2bG84UitxTWM5aHJ2b0N0MXlsdENIWlRhMUk3STRtaGhhV0pO?=
 =?utf-8?B?NllIWE9lVmVlVUpOV3dmbXlXQmkvUlNrRDk5OU11MGJQR1lEcDErRkgrYnh3?=
 =?utf-8?B?Nld3azBCeERMeXZDVUZ1QjU2UDB0NkFiRmNIT1Vnek9zQTVweWlNNGY1MEJV?=
 =?utf-8?B?Ukw1RmZaZFFlNjJDVjhDME5yVlNodTJIWGFsNGE4S3pJdVJEYXB4YlhheU9S?=
 =?utf-8?B?N3J2eDdTOFcwbTVUbWI0ZnNrUGJzUGdnRTRjVy9qVkdWWnJLWGJReE8xK1Fp?=
 =?utf-8?B?K3BVQTZ5SitxVDZQVkQ3MDViMndtVmw5WFpYaWhYYkxMSmFrbjJ2R1FhbEw2?=
 =?utf-8?B?TCtNaGtaL3BXTncrNUZ5cWZ5b1NjNkZNOE5NTFl2N2szQVJ0N3haaThtREJa?=
 =?utf-8?Q?STA4tD8UZ6IdD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWNnTFIzT3FWdVluR1craW02a0NrZ2pycE4vYkVJNll6VXVQNGV5ZVBZRy9J?=
 =?utf-8?B?ak00TE9YU3h0L01rUGIyeTVXa3N6Mk50WGI5cVJSRVh2SVpDNFdiYS8ySk9S?=
 =?utf-8?B?d3pUVXpVNXZ3MDUxOGJ1TTNQTWNiMVZmUTRUMFczNGFpMVllR04xZitQUXpQ?=
 =?utf-8?B?Z0JMcGRmZ3lTZytmYWdQbXFiY0xaQUJUNm84TTJBdXRVYVRrMkt2MUZiWDhT?=
 =?utf-8?B?ZDhzd1d4N3F2NWJtdDc2RHRqM2ZXSlQxWEkzR2hPV3F2Y1RYNUk1WXkyTi9U?=
 =?utf-8?B?S2YxbVV0akREZ3NLZUxScHJIWFZRTnlsYlhxK1VpbE5kYitsZkdrcDBDTGVH?=
 =?utf-8?B?THZ6RUM2RTh2bWZ1K0xUcUYwZElMWkNERDhxb2xVNExVVjJYUk9QK2wvZnZE?=
 =?utf-8?B?N2RrK2FzRUdaUTFFVEEyRTAyRXV4WUdLOUNERU9PMXBKc3FWL2Rmc2NKUjl3?=
 =?utf-8?B?TlVVaXZOUEhjdHF3Q1RMcnpGMEh0OVQyTzdXejlwOHU4dlVKNzJzT3FrSTZV?=
 =?utf-8?B?Njh0TE13TVBpWm1obTRhVU9vTVd6Q1BxYStmdG1Td3VXL1FPcTdrOUNVNTlR?=
 =?utf-8?B?N2NycVVoc2trK3JTZElFVnZhenZqWVhPK3EvU2ljY0xmMHNmdkJ2T0x5UDR4?=
 =?utf-8?B?V0xUY1MxbjJGMUxBOUh2RnVqT2lNeWNOcTZ0emdpUDc2b3Q1OHE2czJLOFdB?=
 =?utf-8?B?VkpzalNXRWhiWittQ1BObUJqSW5ST0pwSEJoeEw2blZKWHlEZFJsWlFRSE5q?=
 =?utf-8?B?Z1NoeDlwV21YYkIxTmdjREppNTViamU5MG1GTUJ4NFhsZDlTNHI2OUZJMm80?=
 =?utf-8?B?RmRvYWpuR01zWVBDTGpwUHJyMGhBYnJXVEpTSEYwS0tEcEQ4bXZyc2ZENU5S?=
 =?utf-8?B?SkQwczRscGFET2VTdzNRd3VOT1hqUy9HdkRRTE5qZ3Z2SVFrcWZuVzV6ME95?=
 =?utf-8?B?RGlrRmJydDBIMk1iSlEwbUx0dVJ2NGVyZUlNeWZkck1TWlpvZkk5eHpEVXRJ?=
 =?utf-8?B?dFRydS9mbmZlYis2UVRMS0RsSDFhek9HWktORDVlV0VoMjRWTEJYeUpBRjFT?=
 =?utf-8?B?dDNOMVkzVlpSZUsvcGR6bmxjelBpb2lUYVNxcWZYM3J2dENYREFnL3p2RHRp?=
 =?utf-8?B?RVp0RWdwdDFUdnRETkYzOXNOb2ZzYXN0dDVSZXAvMENIQ0psSk1DRnJPS2U2?=
 =?utf-8?B?TThqTnMzcmFBaHZuQXRWeXlzajE0NGVFaFAvRC9YSlloRzVFMHI4cVJ2eUtr?=
 =?utf-8?B?amVINE9JVWJwMGR5eHZWZnZNNGpIcU9YV2cyanlaV3k3K01ya3NzdEhjNnEz?=
 =?utf-8?B?NjYwTlhXa0ZjRkQ1R0JSK0NXNWhlN3RBYm80RHp4VytRK1I3VEdRRFo3cmg2?=
 =?utf-8?B?QlF4MGd5Nlh4L3c3ZnliOFVFSjY4QVhLWFhvSmZqOUgrSlU5ZU1TbXRYK2xt?=
 =?utf-8?B?Qk5hYWFZQ3l2b05peFEzUjlad2JDbnFlZDRFSnV1enFtaFJLSzBzZTdIV3l4?=
 =?utf-8?B?MDFJNVd1ZVJ1RWxMRjhtSFh0K2owY0hKZUNmcUxzL2t4VHdiUmJNRzYyNU5L?=
 =?utf-8?B?M1hnVi82OStrZlFzR040cXF4bjI1SURUTDdJYjZCYW81SFVmOXlVS0hBbDV2?=
 =?utf-8?B?d0huVUMxSDY1MmNqa3Z5QlMyempqS3RzRDJNRlBPdFFMc3hYVmh1SGVrSC9H?=
 =?utf-8?B?YWlzOTBEYmRqaFlnQkI4eVZTMG80Z1k1U0x5VU1IcDdMWFZEZ0NGazRucWd1?=
 =?utf-8?B?NnRBSkRUOFk5UlpMN3lzNitKVk5XdzNLVXNIT2ZLb2s4N0k4SGNHMW5zc0Na?=
 =?utf-8?B?OFpVT0xWZ0tkZU1HdjlXZE5OWkVYUTlmejMvNDJWQ1BPMDE2Zi9jRDg3aDJN?=
 =?utf-8?B?bUc2dWNXcFdIK3Raays2dG16RmpvYkVCY1pMUXZOOEF4eGFxOCtHWVVvUHR3?=
 =?utf-8?B?cTQwdWRZc3hDdkJNTGFoYlMyRGJmNzJSbE10bTVvT1hldWJ6bGQ3d09aZEhw?=
 =?utf-8?B?ZHpBRE0rUmM2VS8xanNjakFkMDZnNWlnTmNMN0FUdHg3djVXZU05M3ZIVWFU?=
 =?utf-8?B?VlJwVndTeDlucGNxL1JRcTZTam1HUnlWZnBCUjBMR2hrcjQ0T2orZHFWMklE?=
 =?utf-8?B?cTFXZ3ZFNlJUT0I3VFN5NUNmaW04TTMxZ2ZkUlpuQUI2UlkyVTR1K0NCR2Q3?=
 =?utf-8?Q?PGt0H4r0SpSK/FlVUOzdjqY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DEtgQBh1zQLBfhv6XqZNFv3nSoC8BqYby9I68LxOsefVuOHsifJ/6a0JmbFiIpuQ06IfUWO4ch+S/XiQj18GSyYfMwpdmLkRoJtyWqDkhfX30hByjtbJ4KgBdpaTZYAAo6rlqPvetpgtzCQYUg9SrCOKZZq6pvMnaO2RBujpBEF88KerJuJd4huokfNqXRf2M5qvESGAeJnA+G1Hsn8JwciqmBR0ZhRY4N/lBfBnIQaY6YoVIdSRO6mLnz3m19iZuEak5DU/gH+nMargp2p3oWDP0l5xtb0+rjOnxJ+irbbiYHWcCXyIyZ4JCwwmF3uLojg5KqBcG8kwlRB+1b9iXyFktsXrDYEqZFQ0P81UyN5rlUdSTVx0Hx+SLjdlhvFjBonJI5s7IvJ2LJ/kTUWV/gDsaVpE5WTw4Pgl5Mg3daXcqcMe8hCMweWHd5vkEqmI5EuMGmrx7dRjxVcucQcMcjreSV5R2jvor9NyrEhackA9tu3dId4pf8bizYpvC1uE4Oxiyp9AW2UbsO/gqU0s8Sj4ZBxL19JewNptTk0XHSNB5cZZnOJoR/366lnyN5X2QXI/gSSyg44OKC/vZelm44jFqzBPQ6Lkz1oGepCmAVc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea472db7-c78a-4bd7-44ac-08dcafefdcae
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 16:59:51.5953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +KiRzGvNuv14Fhtb3+LrPUtCdnqvZIseckjOVgE+QNzUa2ubaVmLbl7H0eQXio2kcv1hAP3gQR9xThQx6mJ+Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4170
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_15,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407290114
X-Proofpoint-GUID: ELJH5BKj2mZtL2TMLDCO9tmoWwEiYDit
X-Proofpoint-ORIG-GUID: ELJH5BKj2mZtL2TMLDCO9tmoWwEiYDit

On 29/07/2024 09:20, Alexis Lothoré (eBPF Foundation) wrote:
> test_dev_cgroup currently loads a small bpf program allowing any access on
> urandom and zero devices, disabling access to any other device. It makes
> migrating this test to test_progs impossible, since this one manipulates
> extensively /dev/null.
> 
> Allow /dev/null manipulation in dev_cgroup program to make its usage in
> test_progs framework possible. Update test_dev_cgroup.c as well to match
> this change while it has not been removed.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> ---
>  tools/testing/selftests/bpf/progs/dev_cgroup.c |  4 ++--
>  tools/testing/selftests/bpf/test_dev_cgroup.c  | 18 +++++++++---------

Not a big deal, but I found it a bit confusing that this file was
modified then deleted in patch 2. Would it work having patch 1 stop
building the standalone test/remove it and .gitignore entry, patch 2
updating progs/dev_cgroup.c to allow /dev/zero, /dev/urandom access,
patch 3 add cgroup_dev.c test support, and patch 4 add the device type
subtest? Or are there issues with doing things that way? Thanks!

Alan

