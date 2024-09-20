Return-Path: <linux-kselftest+bounces-18173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A54A97D7A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 17:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2851C20F35
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 15:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4FE17D345;
	Fri, 20 Sep 2024 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZksHT2UF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OAWYX6Fi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB6917BB11;
	Fri, 20 Sep 2024 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726846993; cv=fail; b=IzRGorwHd65lSzhxlmUvHtV/qrF5hp9dZQAG28172qwAXKqAgGJXUG5DaJ/M3ClYNtCwEwOzW8UVjqPn8DLGtuhxSAfw4xKHD/mbS51p3Sw6yjv/pslEjMtSNAY96LlPFfNibOem3bQStjxTpMgXKXMKdxk2qV+oi3CgQ+GBqPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726846993; c=relaxed/simple;
	bh=OaZqKWRzUxhvaijs96sxK9tl0HELPdoMs3WkUuR6ebk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Um+FFA3+o7pIxz5lKrRzQAh/q+EM1+R22dLMxUq/yS400RJXDSZlCop4SH3h0pfapl8XwqvuWp1VC1QaeC0pMtVMF9gl0VUwxNaCRLtoilxTPAA9zPsoDlSFv7Btswh0lEcrWtnVC/JoLPxcmd0r64DoVdqcM9kqHAB76xI6Cn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZksHT2UF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OAWYX6Fi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48KBfRqO023836;
	Fri, 20 Sep 2024 15:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=OaZqKWRzUxhvaijs96sxK9tl0HELPdoMs3WkUuR6e
	bk=; b=ZksHT2UFhXlRQoPy9y08xFZrYBZaaoH04YYR4C/DJcMrt99UohALxNiC4
	IGh51zfjhliQJJ6/YTI0JMoiqCFWV0NrxCOB+jI0ps4IgOHwvtWGJlCD5bqov588
	GopF+o9JzAzvT8V7GDR/pASU18p99J++mucmwtqZ1NZhCGS/21MpFwaotPqIKPrc
	3mtLSM+MpZm97AjpxrVodXuFa14ppqjSyvSMEojHIFHRhLdrQVQvgm04ZR38j+BO
	Z3W3LYG5v/37EHf0E9ufRPFWU/vnbB3vShHVLr1hhYrg+aFrDyPz3WBy9Yx7/XSx
	sY8DW+Y83dakjODQzv8ZmEboyxp/g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3rx712u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 15:42:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48KEAp04010478;
	Fri, 20 Sep 2024 15:42:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nybb85ce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 15:42:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHIiLqgUdp6teQzj8WI0iBvXbbGVyGwyB9QLVxIQobs39nZVf03Xt1WuMAVMFhWziNieN11JhdvmASDIMTCdS+Ixn/Ij29+iqc0lU2bKEwQf3gNHg2F6b4Ks7cvC/cTOmF0D4GRS/ngeVYCZcPP0PV5z2K2Wp5yPlUF5apskpNsleFXXky2dHkGUAVVdRYZP9O0EPiCrCErIccnxecBBAUojPLar29hW8BkoUMh4e9jL2ODbxl5r+Ru1hl5t4KYly9KyAHXL4z6/AGSs4nSj6ch81QhR/CQIhZqzylnxxoZyhJt/13zWcyKiNqGL4q4ZHhFXfRqR9q9T3sNW55wkcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaZqKWRzUxhvaijs96sxK9tl0HELPdoMs3WkUuR6ebk=;
 b=YqqhfFaMpo26kLNmYZVqqS5jnOj1n1PlcW6Ezm6MIJNbT5tzC8Iqk/z2OOlKmPEWKViG78HFYu+jxXcZ9CP6RVqDyr1HSED1FpmqPImkHJZGJ4qfHDQ9uXJkKj1fN3tNBv50LyiuP1zMYlkUmqyTsvYlCdD0ylgVuG7k0RUDy7FZFfrgzQBCTH6tAmIg3ekyiTLVSNVAlpW5k1eTrH7Dm/Al5BbQt5cNgt4zu6sI0569v9JZyYsmVV1zKc8tyJQ837So7y9OJ6lhG0dvQ2EBrVIcqBwHM1qu7rsY1IBNtCrhE+8RtPjUmi7smrBBwI3QiO0Fo+JhrTtzY6pqfMotHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaZqKWRzUxhvaijs96sxK9tl0HELPdoMs3WkUuR6ebk=;
 b=OAWYX6FiOcwoVQiAzytfx06Dd5IjUyV+YrY+bXjSpGHhy9RmSt2gjJhg4D++8Fox0aPROSUGQZMmOoBi2IxKB76KtYSkMxxoSj+QBd+7ZzvM1MHgSUk0lOdPI+UxH5GRwkZb2mq9fGDmefUHSbr4Sjlpu48HgaHyWjB43nwOkqI=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.7; Fri, 20 Sep
 2024 15:42:37 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::3c5e:9043:1ca9:4c60]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::3c5e:9043:1ca9:4c60%3]) with mapi id 15.20.8005.008; Fri, 20 Sep 2024
 15:42:37 +0000
From: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To: Oleg Nesterov <oleg@redhat.com>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        Liam Howlett
	<liam.howlett@oracle.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "axboe@kernel.dk"
	<axboe@kernel.dk>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "alexjlzheng@tencent.com"
	<alexjlzheng@tencent.com>,
        "willy@infradead.org" <willy@infradead.org>,
        Michael Christie <michael.christie@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "shuah@kernel.org"
	<shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        Pei Li <peili.io@oracle.com>,
        "Eric W.
 Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH net-next 1/2] connector/cn_proc: Handle threads for proc
 connector
Thread-Topic: [PATCH net-next 1/2] connector/cn_proc: Handle threads for proc
 connector
Thread-Index: AQHbCvFjDQh6bC0JZkaatsp5diOi/LJggrGAgABOzgA=
Date: Fri, 20 Sep 2024 15:42:37 +0000
Message-ID: <72426AB7-DAF9-4779-A29E-EA5FF8816695@oracle.com>
References: <20240920000933.185090-1-anjali.k.kulkarni@oracle.com>
 <20240920000933.185090-2-anjali.k.kulkarni@oracle.com>
 <20240920110022.GA15795@redhat.com>
In-Reply-To: <20240920110022.GA15795@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|DM6PR10MB4347:EE_
x-ms-office365-filtering-correlation-id: 922ff827-672c-4aa0-2efd-08dcd98ada7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SmJGb3lGS29DMHAxMmdzSEdkVms4N1F6OGY2eitoNFhLQXdDMVJCN1BiOTB0?=
 =?utf-8?B?bnNBaVZNNm0za3YwNUh0UW90cDVWZkhpdnlEbDhyMXV6ZjZmcnp5WEFWaUtm?=
 =?utf-8?B?VTIzaFVjWFNoQVRtQVl5blBEV1ZRd2lLUStkU0dkOGg4aERGV3pIeUdMclJ4?=
 =?utf-8?B?QmtzOFd4MExLQWdaZTVuVkZ2bTUzTEluRVY2amwzNksrWkJjU2JScmFLZVZv?=
 =?utf-8?B?Y0pRUGU0SHU3UERjQ2l6NTVhZ3RhemNiaXNVVFNXeXhrOTNRMWcxR2xUeHE1?=
 =?utf-8?B?dVo5SFlIWEdYR0Uza0hVN2NrYzJCVGxmZGlZV2Z4SjhwNytaS01vMWdPUWMz?=
 =?utf-8?B?YWxHcXV3N0VYRWRKaC9EbzAraGg4ZU9qcGpzdHY2SFV0MHU4Sm42blFaMzJJ?=
 =?utf-8?B?MDNrcXNPUU5ZUWhVZjFndVplVFJQQUtGeTdkK0JLdVMzUmZUU0k2K0owQ1lk?=
 =?utf-8?B?S2tFQmk3SXIxRkxNeXhzUXF3alB6R1M5UEFsUksvVlUzZlNHSVBycUpwaEln?=
 =?utf-8?B?TlVENlVwS2V4d0hMa1ZQa2s5bUNDL0libVBqSTY1eUhLcis5OTZob2o3Tmw2?=
 =?utf-8?B?Z1NBV1FLekluZzMyZFpuZnJkam9oRHNvNVFXUER1R3FsZ1pTdmxWYmxKL1Iy?=
 =?utf-8?B?WjF6YjlvLy9sdVZKOVhFMW94NFRmZUVOUHI1d3RyakJ3bXBaUDNWTmdvZ3o1?=
 =?utf-8?B?RmtSazJMT296NFhYbFVrSUR4ZDdzbDQ5Snd4K3Q5dXRMSmJST09GUHdIT2ZX?=
 =?utf-8?B?cU5WSWtjWUltT1RIU0pDY08zRjNtVDUrR0ptTTdlOTBUdTh4Nk1tZWRVdXdq?=
 =?utf-8?B?TW1WWWxPSytZMWxmdllLbDh4WE50U0dEWFdQZ0FVbVdGUE1jOEpVNk9zM2pG?=
 =?utf-8?B?QXJEYjZjVzhXZ3JkQ1pYRmFWMUUycGRHb3RGQkduL28wUGxJTXFuMmJEUyt6?=
 =?utf-8?B?T1NTUDFPL1Urai9XaG5VbUVoOWt1Mmo3WGdxdW9INkJDZThud3VCWG1nRzlx?=
 =?utf-8?B?dXIxN0JiVFNnVk9KK3c4cFZnbWU0N21mQzh0dTRHRHQ3SmtKWEF0RHR4U2VO?=
 =?utf-8?B?eTluTHpsZEcyNGlITDJPckJWYjFWekdUNVNzSGxQMVdjU2Q5UHg5ZTBiZStT?=
 =?utf-8?B?aUtMZUIrKzZWNGFIU0xOZTBXU2UwV0lLWmRzVkduU09yQkY1LzBwVmdvNEJL?=
 =?utf-8?B?ZXpiN0RmdU1SMit2Tng5YlhRTFFuVW5LOGdLZ09uT1ZLRWRVRG04MjRFR0Vt?=
 =?utf-8?B?UFp3SG50b0Q3c1o1blUrQ0ZNNHBtYVphaVlRQ3BsdmJsTnlwS2FobmJYc1dQ?=
 =?utf-8?B?NjlrdTA1SE9uQ0YyYTkxMEY2ZCttWmxFWnR4UjhIaG5oSGtwQXJYRWE5MTVU?=
 =?utf-8?B?cksvbDJsNTVjb3RtWlV5b1o0STU1LyszOUVGNnJRbVdiczZWNHpweUxjZEZa?=
 =?utf-8?B?aWQ5OVN0c0NtcVQySVROYzJsTC9KNFlGc0JPQXBrajJaeFdadEJMWXBnMS9Y?=
 =?utf-8?B?SHd6bk5HcDRFRVFXOHFGNnJ6VW1JZFFSM1hKdEY1WHd2S2U1N2IxNWZyeU9D?=
 =?utf-8?B?MWN6UmhjN2s3QXhXdDlkaWJwdjVTNGxXR09pNzRSanpzaTlxbFZZbFZJL0ww?=
 =?utf-8?B?eHdKcVZmZWI2NVpiYWptSEk0UHJKdU1nZVd3d2dxQno0UEpGOU45ZVE4eGp4?=
 =?utf-8?B?LzUxL2RkdHZkM0ZDdzNmOUYzLzJzUTZsS1dyMXpEK2ZnUlJrRmZDWUJaL3d0?=
 =?utf-8?B?QVcrQUdjbFdYN0RuWE1GRlpjK1hwbHNZZzZVdTh4eFhSc0JxTXVTRHljUkZr?=
 =?utf-8?B?ZGVNeU9Gbkx0K3lhVzJvTkpvQUNZSzR2dm53cFBBZG85enhUdU9PRTlwVWFO?=
 =?utf-8?B?cjlFVXJmVElVYm16SklZeGx2Q01tUXd1YkE3b3ZvZmxhQVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aGFoZElVa09RSERCWm9pVFl3VzFzSWlERC9tVDhMVEwwVTM2RlgybHRoQzRD?=
 =?utf-8?B?M0VZYk5PdzN3MThzbURYUmNyVGQxSkNINHA4ZElETU1EcWxPemtZbzJ1V1A4?=
 =?utf-8?B?dTY2cVE0Y0QxdTVFbU50NVZDQlFldDZrU0VYOXlRejEwcjVsTnJnWmM0MVlj?=
 =?utf-8?B?cE9YWWIyUU1NTEQ2bktRWHg5OWp4WGZZUUo4UGNrZTZmOTdZSFBGbjRaQ3hP?=
 =?utf-8?B?VUpLMWdhbHpRNGVYREd2RkpRNEptRXhIN1pwVXpiZ0ZXektkTGZZMUxIUmE3?=
 =?utf-8?B?bC9pang4MkJIOFlmSHF1aXV1Q2xicEVHY09ibE5iZ25mcEZwTDlyWURBVzVa?=
 =?utf-8?B?ekowVWpIWXdwbFBiMTk3Nndlc2FHNUFIQ0s1WFh2cE5ZUStNQW1FNEdqVlhK?=
 =?utf-8?B?Uno4c3Y5dW5wb3dPVkJWTTh1Y2NVL3lBcUU3SzRkL3Ruc3ppNlN2VjJaTU01?=
 =?utf-8?B?b2hUM0lEclVEMjVSUGtVMW1RVmFvd09aUHl1L2pQbDVNemk0bGxPcUI1S08r?=
 =?utf-8?B?ZVRTNlU2dDJ0TDJrU2YzbjdPZUFra05NVjhXQ3dCOGNUSDQ4R1k5R0ZuU1R1?=
 =?utf-8?B?K2J3VHAvemV3ZWo4cXVCd29RaDhoN0xOSDZUcGFiTWQ5WkdkekZBbmtUejhV?=
 =?utf-8?B?RzBsQjVRUjQya2dNSGdrVFU5cWRlK1NPaDQ2TFV0Wi9ZeDRmSzB5aEVUS2E0?=
 =?utf-8?B?NUNIOEdsUUxMTVU0aWRxUjc4eVRmcXhKNHVmZkJsK0FaT3AveCtpaW5iZlpo?=
 =?utf-8?B?UTBvaUhla2NCejlyYkhGWmg4VmJvRkZ2VlQzcFZYelQzNFQ5VjRGeXgyckZo?=
 =?utf-8?B?ZUhnN2hrZW96QzhHaitVYktuNG5MUnJYdU5wdTloTExRZUszNVgzajkvdXJ3?=
 =?utf-8?B?WWMzWnJqT1d6a3gra3dHTXJydG00cWhYOWtkSkd4TjJpODg5bzNwT292Y2Fs?=
 =?utf-8?B?THBydUw5Nks0b1hXZDZYQStRWkl5NEdCZmlZQUhjZDFXb0xzdUhGK2NQck8w?=
 =?utf-8?B?R2pOS0k2Sm5YdHBuTEFkczhDRmtOLy95dFAzUWpCMU04RWU4UzBuZTduanFq?=
 =?utf-8?B?eXJIc1d2NTI2VmlyUEE5SFpPSW5ta25iMjFhb3UvM1NBNVRRWjlFdm5QZDB3?=
 =?utf-8?B?Sm9oZ3o1WndZQ29yQlFOOVpGRHR4ejZETGczUmU3YklqeVRNRlpoMWNxNWhX?=
 =?utf-8?B?QWV5dlRIRWVpclVRNytMU3JoaXg5b204NVc5RW1YUzFzTFhsME1lSk1TWUp0?=
 =?utf-8?B?Qll6SzNoVjBUMDlwM05WdzM1WFZZa2FCU3JNdHpYOThSRkc5cDlhaldtVjJM?=
 =?utf-8?B?L3JUY1lpd1NmWXJQWGpzcUZiZzNlanh5Y2tqYmhCSEhtQmlFR0piUGxMZzNU?=
 =?utf-8?B?K2dpMnR0SnZPTVFlV29OdjdyZ1k5YlQ2cnAzZ3hXbmJHNlJtQUdkYXI0V3ZV?=
 =?utf-8?B?Zy9GQUxGUzdENWh4d1lUVWZlTGhtTEhhRmFXbS9GZ2tJeEE1ajRha1dTQUl6?=
 =?utf-8?B?Z3VFMTNJeHdzY0tqeEhVcFJEQm56aUdNU0FWa3JuYlZQR0pXTGVXUjZ0QmZD?=
 =?utf-8?B?b0tUQWp1RTFMN2xGcXZSdlM5ZUFxcGtJV09Bd3owd2JSMndpNGhpd3NDRXFQ?=
 =?utf-8?B?elJpbWFtVFAyOEg3aUF4ZkxzaWVBUmpjSEpnNmd6OHJUMlZUeVZQMmN0bk1O?=
 =?utf-8?B?bFZ2eUpGTENKK01wSUlMTG1OM1Z5eW9uaTJhcnhNWUxZcHg1ZVkrU0o0VmNR?=
 =?utf-8?B?RlFOS0Y5d1VsMDdFZ3dSbXJqS2lma1AyUU1qMVlWZmdnMHNEVkRmcVBGM1ZM?=
 =?utf-8?B?ajg1UnRYQnJHdUlvTHMyQU5CSU1HbnpNbUppZ0lOWFNBSkwzeWdveGV1MlAr?=
 =?utf-8?B?ZUxjaUVVcDBnK242eFhtYkQrSmpCRjl3Yy9Mc09VRG1obUFHVnhFN05hVGVh?=
 =?utf-8?B?ZnhZMDBUeHA2ekMxVXVkekJUN2VTMzhlZ2dQeEZiU1h0SnI1WDlKTXZrdDRt?=
 =?utf-8?B?V0R3QUFOMHhrZWc0b0FTakpuR0tzT3QxYzlDc0pLTzhCa0dkSnhwckxnWDFo?=
 =?utf-8?B?dWtVcFlKZVBOYVVkRjJ2dEtlTlRrN1RkcENoeXJCVCsrcnNHUkJvN1FuQWhW?=
 =?utf-8?B?RzI2anFBMndtckNpT2JrRkJsRjh2UDdXamdCMW5rQnVYeUNHV3JhcWlMd3l3?=
 =?utf-8?Q?+MqAgNwsLlQECGSbNDD2HpHl0pJ7RRhARJds7w87UoEu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DF4A36301CBAD4084A9F3FD02D9EFA0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hSfy/GdfYYO0uzMcZcHuJOx/Jka2J60ERBjZj5JFGzkGpbkEg3pq7ED78HqFD9UiFgJ+DwcGMPVvQP/uaF3+FXkE1bWM0eUBVUBU1O1tDDy2GOTR1+FUnGAXqMlJys8bFnCKMh7vwc2HD/xxnVq2uTMYzuRZnB0H1abB3nUWhq7ndRdK/1+G4GEBhwyy/z8IjJ7MFG4EQLXzM35UjIYJi8LqAdYRw0n0G1+C4/oEjbOD6TY5AmHlv7R2JB0DwYvBnqf9mtZ7mGXi4z7lpNmr/1NdkB6zta5HhFFLIL7/igTWZT5Y+hkUC+qJpk4gFNW4xL+Z302Ou2IYZCUCahdcoa9BloUNHQtZqhLrRv1txZofqy7tDqy6hvRu0O/u7qXCaLjflGYM0y+YIntOdD7L4LzAnOkHAn5nqjHV3TsO3Wm0zZ2GnNR0t9FCjgZXcCk7s4+F7zRZexFNym+O9+wxaawZ5V/Ochceg1+roxcCs8l1cYCLDSiNKD3NdYLo8ZdLjeaosZ6UWNIq/7NWCMNREdxo8fVeREswTSU19MG3o3R+r5QGfWnxSjIgyNYcZEZxenalWdWA8qdYpJTd1UBHFdTsvlq07fIU/SUxNVLYTVk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 922ff827-672c-4aa0-2efd-08dcd98ada7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 15:42:37.3604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5aLdJ36XuDfEM6E0vKSboT5Y7SqNM78JXF6gKihBHl2JzgorDQP7dtakg3OTJ1tdWqenq/Q5uBdImF3qw+OvSD4+BSpAs9bcyVh+nLLgaIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-20_08,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409200115
X-Proofpoint-GUID: 6VQFHymwvHn4RyuC--UwhwOzkM4u0htv
X-Proofpoint-ORIG-GUID: 6VQFHymwvHn4RyuC--UwhwOzkM4u0htv

DQoNCj4gT24gU2VwIDIwLCAyMDI0LCBhdCA0OjAw4oCvQU0sIE9sZWcgTmVzdGVyb3YgPG9sZWdA
cmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBPbiAwOS8xOSwgQW5qYWxpIEt1bGthcm5pIHdyb3Rl
Og0KPj4gDQo+PiBAQCAtNDEzLDYgKzQxNiwxMCBAQCBzdGF0aWMgdm9pZCBjbl9wcm9jX21jYXN0
X2N0bChzdHJ1Y3QgY25fbXNnICptc2csDQo+PiAJaWYgKG1zZy0+bGVuID09IHNpemVvZigqcGlu
cHV0KSkgew0KPj4gCQlwaW5wdXQgPSAoc3RydWN0IHByb2NfaW5wdXQgKiltc2ctPmRhdGE7DQo+
PiAJCW1jX29wID0gcGlucHV0LT5tY2FzdF9vcDsNCj4+ICsJCWlmIChtY19vcCA9PSBQUk9DX0NO
X01DQVNUX05PVElGWSkgew0KPj4gKwkJCWN1cnJlbnQtPmV4aXRfY29kZSA9IHBpbnB1dC0+dWV4
aXRfY29kZTsNCj4+ICsJCQlyZXR1cm47DQo+IA0KPiAuLi4NCj4gDQo+PiAtLS0gYS9rZXJuZWwv
ZXhpdC5jDQo+PiArKysgYi9rZXJuZWwvZXhpdC5jDQo+PiBAQCAtODIxLDYgKzgyMSw3IEBAIHZv
aWQgX19ub3JldHVybiBkb19leGl0KGxvbmcgY29kZSkNCj4+IHsNCj4+IAlzdHJ1Y3QgdGFza19z
dHJ1Y3QgKnRzayA9IGN1cnJlbnQ7DQo+PiAJaW50IGdyb3VwX2RlYWQ7DQo+PiArCV9fdTMyIHVl
eGl0X2NvZGU7DQo+PiANCj4+IAlXQVJOX09OKGlycXNfZGlzYWJsZWQoKSk7DQo+PiANCj4+IEBA
IC04NjMsNiArODY0LDggQEAgdm9pZCBfX25vcmV0dXJuIGRvX2V4aXQobG9uZyBjb2RlKQ0KPj4g
CQl0dHlfYXVkaXRfZXhpdCgpOw0KPj4gCWF1ZGl0X2ZyZWUodHNrKTsNCj4+IA0KPj4gKwl1ZXhp
dF9jb2RlID0gdHNrLT5leGl0X2NvZGU7DQo+IA0KPiBJIGRvbid0IHRoaW5rIHlvdSBjYW4gdXNl
IHRhc2tfc3RydWN0LT5leGl0X2NvZGUuIElmIHRoaXMgdGFzayBpcyBwdHJhY2VkLA0KPiBpdCBj
YW4gYmUgY2hhbmdlZC9jbGVhcmVkIGluLCBzYXksIHB0cmFjZV9zdG9wKCkgYWZ0ZXIgUFJPQ19D
Tl9NQ0FTVF9OT1RJRlkuDQo+IA0KDQpUaGFuayB5b3UsIHRoYXTigJlzIGEgZ29vZCBwb2ludCEg
SG93ZXZlciwgdGhlIHVzZSBjYXNlIG9mIHB0cmFjZSwgd2hpY2ggSSBhc3N1bWUgaXMgZm9yIG1v
c3RseSBkZWJ1ZyBhbmQgdHJhY2luZywgaXMgZXhjbHVzaXZlIG9mIHRoZSB1c2UgY2FzZSBJIGFt
IHVzaW5nIGl0IGZvciAtIGZvciBwcm9kdWN0aW9uIGFuZCBtb3N0bHkgc2NhbGluZyBzY2VuYXJp
b3MuIFRoYXQgaXMsIEkgYXNzdW1lIHB0cmFjZSBjYWxscyBjYW4gYmUgZG9uZSBvbmx5IHRvIHlv
dXIgb3duIHByb2Nlc3NlcyAoZXhjZXB0IHN1cGVydXNlciksIHNvIHRoZSB0cmFjaW5nIHByb2Nl
c3Mgc2hvdWxkIHVuZGVyc3RhbmQgYW5kIG9ubHkgZG8gb25lKHB0cmFjZSkgb3IgdGhlIG90aGVy
IChyZXF1ZXN0IGZvciBhIGV4aXQgbm90aWZpY2F0aW9uIGJ5IHVzaW5nIGEgc3lzdGVtIGNhbGwp
IGFuZCBub3QgYm90aD8gSSBjb3VsZCBhZGQgYSBjb21tZW50IG9yIHNvbWV0aGluZyB3aGljaCBk
ZXNjcmliZXMgdGhpcyBzb21ld2hlcmUuIEFub3RoZXIgcG9pbnQgaXMgLSBpZiBhbiBleGl0X2Nv
ZGUgaXMgbW9kaWZpZWQsIGl0IHdpbGwgYW55d2F5cyBiZSBvdmVyd3JpdHRlbiBpbiB0aGUgZG9f
ZXhpdCgpIGNhbGwgLSBzbyBpdOKAmXMgbm90IGNsZWFyIHRvIG1lIHdoYXQgdGhlIHB1cnBvc2Ug
b2Ygd3JpdGluZyB0aGF0IGZpZWxkIHdvdWxkIGJlIGZvciBwdHJhY2Vfc3RvcCgpIG9yIGFueSBv
dGhlciBmdW5jdGlvbuKApj8gSXMgdGhlcmUgYW55IG90aGVyIHJlYXNvbiBmb3IgcHRyYWNlX3N0
b3AoKSB0byBtb2RpZnkgdGFza19zdHJ1Y3QtPmV4aXRfY29kZT8NCg0KQW5qYWxpDQoNCj4gT2xl
Zy4NCj4gDQoNCg==

