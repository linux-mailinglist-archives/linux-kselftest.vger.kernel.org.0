Return-Path: <linux-kselftest+bounces-44964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B897AC3B2BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 14:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936BA560AC5
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 13:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DCD32D426;
	Thu,  6 Nov 2025 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Eh+D3nBq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fMGPn0u+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B02432ABC1;
	Thu,  6 Nov 2025 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762434800; cv=fail; b=EKvNDdA5Vs8TroMJVY7dNsKaBqQAB0tZ7QNBoOkFGGV39BWhtZaWcaf/Hn2N2cONJb0MNW3ahs778xoMvEsjp//yqqS+CMZsVxs61WLX1JeSF1N291w20W0Yx3PQNBauGKl5WnAZc44RbiG8DcVZqy68x5TanMqdOy+u2qoR+ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762434800; c=relaxed/simple;
	bh=/ukb1SQdFpycoqtKrOhM3loEovtG/OpiE0ZK5Mcf4JA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iFl5ZZ2LdMZSgYBxSe3rOfjAzWtXhHOIpjdY1ZDMOAjNoyyQaDxmDhLO6cWEw6m/Mjgh4t7UOFWPJZYmHZ7JKNajl5551tqQFyJ3rORrxH+0E0PQ7XRrQ7ALM/NmpLZDjl2OoeizXV+XBvB6ILWBVZ3QlAlzIUT3nfKcZdcnybQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Eh+D3nBq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fMGPn0u+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6BvpNd017059;
	Thu, 6 Nov 2025 13:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ia2SPE0zmdnXh3/Xj5DJ0ZJuFb865c4HOtU22AMgwHY=; b=
	Eh+D3nBq7EpB8bv9fPwf+wctgQPXyNFJPlQQSq2Z9bQEh2IWhHa5lsZlaQbrWJ60
	r62kc0wY3uWcYwOlsjCPnytL3tyOzquvkZryl81Y4PSB/fcmFQkN4KP1F6vOw2Le
	6FwxVzhdwC8z/OFIn53wnwQAXM56YhvNN5l2Qbcje7Y37Umy/2PItBRnZJ9wzjmW
	skmd8l3CquZJ+9Zv/frqgfB4ygiU5L1wpLA7LmsAauCV6gPFQ7X/6s6Sw7BHHbcE
	BQAm9GMfVMDBc0Rtf3e+Kzfmd4s8fAcv6I7XH3x1Yqs4CaT0vwQ7UEp3AprtvrO7
	BXnV8Lk6+nGP99WdXjpn0A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8aejt1bc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 13:12:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6COUY9010767;
	Thu, 6 Nov 2025 13:12:53 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010040.outbound.protection.outlook.com [52.101.85.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nccvur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 13:12:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mt+MIJ9QwaYMKOTHBiBOpOVHSKqzqHAHPqrJOlan5JwyIlf5CZpkxVJ7hWy4e6XxeVj3g9MW9U3+sb10q/AtvIhADDZa74/BzcKwuwDa2cbLY3pVxXRNP53c3tB7EX0Hua+/A7exC/9VenehEjk3DJgBRatqQk8PhVS0lHvJYUK7Iol39GOjMPSTHDr5Oze+E79xAPiq8KqKbxWxEbLgdyr1OW8sUdCqTSJzhHcWiTZ6szOXfeuqUsiMKH/bwBi4fGTRWKlut5qsuOv/W9n9NHJQOfvh4PMs/aKYzoTsEqtfcihlzKu1F90T+UOK/gtbAqPVRTTRU2W7TIlUv67fBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ia2SPE0zmdnXh3/Xj5DJ0ZJuFb865c4HOtU22AMgwHY=;
 b=Kp0/aiS4ZaLUX+XbQMyu5sHOgpyX2B+BW6xj2aLIVuixuoJ8XSTMbiOv0k+t9A2oe2j2t7/AvyJ5tKNXfuFnVufvw8IHKqfYIl2qlfvZa6CiF0fDM2vmF5zw0+yymNVg9tC5GKWjBpETw3Fo+Cv+kCtjQ4zWaIkenRjXyeKz8+Sxsk/LcoAaALa7t8gyYZ/AAlJjAl0EtOr2RcMCGSoFU//tnSSY9ztuPeyVRqW99lyC75cVUtU29ApTQTssaTGXsFaik2cO4H8FSQSys2xW4pbEGqENXiE5enDcqW5vmml2Bju9z+8ghmhFVI6AZFT7NZ8PEjg1FEs3zK8RwWrzFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ia2SPE0zmdnXh3/Xj5DJ0ZJuFb865c4HOtU22AMgwHY=;
 b=fMGPn0u+Q5pT1c30g5nzGoFv96GAr+cHxqA03wbSTZXyD9C6+zm6/5UwpZ9nxbiSQL0jZPrUNxgvOhh7itAtHVmUTV+XfeZCDcZJluTdOO88uQXFpudStkHX40WKOFFYSOL4DHczi9CmXAgzwe5MH/aMXL+E7Av2h0irbv6GhWc=
Received: from IA4PR10MB8421.namprd10.prod.outlook.com (2603:10b6:208:563::15)
 by BY5PR10MB4226.namprd10.prod.outlook.com (2603:10b6:a03:210::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Thu, 6 Nov
 2025 13:12:49 +0000
Received: from IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77]) by IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77%6]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 13:12:49 +0000
Message-ID: <ccbb1ed5-fc35-4084-9c13-1e4b1ede96f4@oracle.com>
Date: Thu, 6 Nov 2025 18:42:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] bpftool: Print map ID upon creation and support
 JSON output
To: Quentin Monnet <qmo@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alan Maguire <alan.maguire@oracle.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov
 <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20251101193357.111186-1-harshit.m.mogalapalli@oracle.com>
 <20251101193357.111186-2-harshit.m.mogalapalli@oracle.com>
 <CAADnVQLe6a8Kae892sVaND-2p1DQDXGD5gqxHWHHUC85ntLCqw@mail.gmail.com>
 <e9d43dab-cfae-48a8-9039-e050ea392797@kernel.org>
 <CAADnVQKzSBZYaj0iMkNBk6FvaOket1mWPksX661zwC2rg2FBkQ@mail.gmail.com>
 <7874cfab-3f96-4cfb-9e52-b9d8108bc536@kernel.org>
 <CAADnVQL7cLYPKEQOLWi1DjTZjhE_Fy4zWLrWG+=NSeN821SyMw@mail.gmail.com>
 <667fb65c-d8d3-4af9-8efe-196e6d1befcc@kernel.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <667fb65c-d8d3-4af9-8efe-196e6d1befcc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0214.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::21) To IA4PR10MB8421.namprd10.prod.outlook.com
 (2603:10b6:208:563::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8421:EE_|BY5PR10MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: f21f0f08-2a83-443a-deb3-08de1d362ef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2FzeWRLdzVuY0pDVXVRdzdoMzk5enFUTmcweG1zNzRjdUNQN0w1RWg1VnRS?=
 =?utf-8?B?bVQwSHpTMUJobmZhNDM2RzV6S3lFQlBzWmtCTGxxVHlycC9RUDBVeWZ0dkY4?=
 =?utf-8?B?OWZIU0Y0dHp3SEY5MStRSE5KeU1NNFI0V3ZkVTc5RzRhdk1jZjhDRjdxTi9Q?=
 =?utf-8?B?eHU5Yk9TOW1MUjdRNGF3U1d6TW5OS0dCOFpxcVJwOXhINGh2ZWhiTFhIaGUr?=
 =?utf-8?B?bkFJZm90WTR0bFQyam4ycTh4Rm9ORzA0Q3BTa21hZkhxazNud1BMME1PMUZn?=
 =?utf-8?B?c3JISVRnWW9sOXlsZ25Dem5VM2dCZnNCeUZxWDhQNHdmWk0vSUJNVzBqRHNH?=
 =?utf-8?B?d0YwWjUzK0R4Y05MSmdJR3JoR2NHa0dFUEJGTmZtOEs0NEUwS1YwQmJZUmpW?=
 =?utf-8?B?bW1KQWpMYTlkb3o5dEY2SEcyVkdGVUppNFJWSTcxazA5MnpmWlkxYmEvc1c0?=
 =?utf-8?B?RDZoek9xSnNtU01OSktNejhzU3FIQUoyRmFVUC9oWEh2QlFWZUw3L01vVEdt?=
 =?utf-8?B?WFRvemlXSTNSUU9OaXJnd210cVI0dW9RT1IxdjBiRmRCMVZnTU51cmxaTzdq?=
 =?utf-8?B?V0RXSEIzZVRCd3RRNTYxamd2UEtqblZBSGVXOTI2cFJpOFVIRkR6ek9VdFZ0?=
 =?utf-8?B?TG51SkNzdFlPK2tNdXQ0bElXdnNhekNmMVpYcm1HRnhWUUc4UlJzRFJLMVFu?=
 =?utf-8?B?Nit4bkxxSnNaTHM1clgxNGwvK1hXeS9HWEY5MGEvTndWU2Zqc0xZUURoa3lq?=
 =?utf-8?B?VGRGeTdmclFjU3NhVXVZdEdpZ1dMTVNVY1hXNk5CdzF3Q1hKYUxTU0J4U25v?=
 =?utf-8?B?dDJrZ2hTR1RxTUlWb0hDZ2VDKzhHYmtBbGV4MHMvSEYrYkdFNnRYNFZxWU9S?=
 =?utf-8?B?MHNIdFA2L3liRTF4WEJZbHlXQ1FzVENXaE9Od2xpcHdTa1lJSGE0Y1o2b2tj?=
 =?utf-8?B?V2xyRUEza29PUE9scmhBRkoxcFJWekJUeWNlM21aeVA3SDQrZStjUlhLck9W?=
 =?utf-8?B?Sk1IUWlodUxRTkFBQ0NsNkRBQlZoWFVZQ25wMFBmczRYb3JYd2kzN09GNzJC?=
 =?utf-8?B?M25JWmZjMmQyYk5uaVJBMkVOWStDRllDeTdDNEVRYkt6aWV1MHM0UE0xTEow?=
 =?utf-8?B?b3ZWRmVUNDFzdmhhcUhpMlhxbW1abjd0bUZXSVRoNlVnb3F6VXBUZXFmU283?=
 =?utf-8?B?SHRaMmlWNE1CNDJiK01EVFEvdXpJVlpyRWFYV2J5d2ZVajZGMFFpTXVaU0p3?=
 =?utf-8?B?TW9sM2FjdTBQOGRqZVFkOG1XQ0Rxb0JoRXVCUjFnMEVrZHA4UjZldWNBUzZs?=
 =?utf-8?B?TkpWTi9xWjI2TFdIYUJ6V25xVE5BTU13OG02Qks1MGQ3czNwL0U0VlFST0Rh?=
 =?utf-8?B?OWVCSmJHMWF6aW00cndXY3p6OERhY2V4OHNaRHpMcDUrMHRDeHZNaXNCNGlP?=
 =?utf-8?B?Z3ZQRjlkeHd1dW9VSzFSWEEwNnFxRUNPTXNvSGlzeVVONGVUUlZHdi9OdFFW?=
 =?utf-8?B?d3huTWFkTzhCa2FDM1hleC9JZzBPV1lmL2U2V3UvOWh6ZkhCYkxPQ0VJU0tM?=
 =?utf-8?B?SU5nc3BKV2JaSVAyUC9GTkNWTzBGMUVFaGQrUVdFdnJkU1pScEtHcjZFZ1di?=
 =?utf-8?B?dDZ0REx1eEZxVUtpL295QTFZTloydVZZTERBd1NXTG5zdWZUWmFYWG9ZUHBF?=
 =?utf-8?B?bnc2TDFaYkM0RzFNYUlwcmQ1a2w1WjBEby9vY1NBYzB3Tk5VNmNwSmlBYU5V?=
 =?utf-8?B?bVdlQlRndlo2TlkzUXJCR2s0dFJuQ2xaYlAwb2YxdCt4ZkY1V2p1QXVwRnll?=
 =?utf-8?B?bjhzTzZvM1RXMVgxdEY2cjBMV3hNQ3ZDakhlWk5DU0pqQmxwdXMrVWJMaHRp?=
 =?utf-8?B?anJOWGdoSEU1aGFGS216K3o1QnI3eElYQ0lMRG5aNkJIU2ZxUkNGWFVDRlJH?=
 =?utf-8?B?K05Oa0ZYbkFLdXovVXVoakFBQnN6R1ZtRHE5RlJEYmc2UlFLVXlVRVdKdDBs?=
 =?utf-8?B?anJ1QlpiV2t3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8421.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzZ1dmxYZzQ2dVNHbUlsbHhWYlJyT1dGY3dLd2FpaGNpdWhIUUdCZXNpbjhL?=
 =?utf-8?B?YTFnQ0VsSnorOG9vZlQ1YktJYlE2SGRtblp6bjJWQ3o1MFowMmhYTkNWc3Vy?=
 =?utf-8?B?WUZrbHI1TmFkUFppVHpkelR2NWpCR0ZHSC91dXBWeDVCYXYranJYUEN3Ull2?=
 =?utf-8?B?OWNkandhb28zNXpHeTRtT3kweHlUdU9IZkNDaTFvRDBBRlZOS0VibktpZVIy?=
 =?utf-8?B?cGNmRzVaejl0dUJsb2hhYTU2RTNOZGIvQ2I0VTR5dytOenJUa2NybUxadUty?=
 =?utf-8?B?UER1Y3NiNGkwS1dvSGZXaVRSQTJWOEtTUzdBQmpqeHUvZGYxWmprQUQxdUxE?=
 =?utf-8?B?L2NPY2xUMkIvd0FqTlBCOER2ZDZiWWtRODdoaFB4WEJUajJQTFNBd2haMTRY?=
 =?utf-8?B?cm1WZ0N1NUp4Wi9SMHBZcXBkRHhFa1F2TThCUnBGTU1GUHhJeHJObnVmY2Fz?=
 =?utf-8?B?VmlwckJWeS8xbnVUcVI5bTA0a3VNcEtyeEN6ZXU4NXprN1FySlJHbmVMS3VQ?=
 =?utf-8?B?Vk1WN2g1L0pTbTdmdDhlTkxDTko4N2RFQndvQjlwK2V0bEE5dUZFcWZjSmMr?=
 =?utf-8?B?MDBHSDdRaWk0RlRWVjVBY3F3eEtOSGtCR09obkdKdzgyM1NKb2Z1WUNzcytX?=
 =?utf-8?B?VW9namxyWXpwRSt3ZWFwZXFOVDJIYkhKdnQ5VzYvWHVZRE1HYVM3anhMQWFy?=
 =?utf-8?B?MFVHa05rYmtJQXBDcUwwYUZJeWJ2RVFZc1ZrODNwWVF5SmgyMXZRY3pNUEFL?=
 =?utf-8?B?WUhCWlArSWwvZGtvMzdSY2ZDeFZ6OVlvNHIwY3FtenhKUTZ3YTBvUlA4d2NQ?=
 =?utf-8?B?a01PT3diUWMveEFuVFRhKzlES3p5bDJUVnNsVmcxcFlMbEZ4TUNtYkJXTUk2?=
 =?utf-8?B?WmNwaFU3RzBKVSsxRVdTSlZ1dDBnOHFsOFoydE1ITmpYUW9VelhVM3VWTFdU?=
 =?utf-8?B?Q3g3Ylc1QVZWUXdxL2dDcm5tRUUyeWZRQkxGV2hzbUx3TG5RTWRrMDFONC9u?=
 =?utf-8?B?QUdYM09Ic1lLdXVaNFJZVU1Za2dQNTZYQWdtS1gzYjNOcnZLcVlUeitqRFgz?=
 =?utf-8?B?dkZWVlA3TUxHUklXOUNUSDIwdWUzTDZuRnNhUHhmMjlpbmN0dTd5SU14UFZJ?=
 =?utf-8?B?Zmg2eGNzc2tvWWRHMjduZ3R5QXRac1lUK1dlWXE5K0V5elAwZGhvQ2ZrZ3NZ?=
 =?utf-8?B?MUk0ejFVNTN2L1AvMzM0ZVFEOElQKzlxWU9qbXc3VVdRZmYrQ0lGN1NkeHZF?=
 =?utf-8?B?ZUg1aEFSZFk0Vjh6QUNST3RidjZZQVBUWXJMTkRGT1VxOTUrTlNzV3dnSitK?=
 =?utf-8?B?UFJFQll4RXVuUHVXaFhxMUx4cFIwdkpQUTg2SlYwNllTUUx5NURIald1dElp?=
 =?utf-8?B?am5KOUo5RW5OSVBxWmk0aWovVzFlaytvbzVUcnU0N3piR092T1p2bk5aUy9q?=
 =?utf-8?B?Z0luOGJKZnRLc2NXcm9xeU5sSENCYWJXTytKbXBicTBHWkJMQnAyWGRUSVN6?=
 =?utf-8?B?ejduSHNUZUMyT1B6TnZPZk9peTF4SGplY2RJZ3ZXVDUxTFJyNkZjbFhKangv?=
 =?utf-8?B?MmJIL0JYcHY2blAwMFd6NnFWaGJMd3d2d2NkR2NuRlB4c1JwbkNuSmtDZEZF?=
 =?utf-8?B?ZGIvZy91dGJmeWhzditaTnZHMWFVamtzbmRsbzBXL3ZxYnYrcG1uL2ZaR0dZ?=
 =?utf-8?B?blY2ZFo5aW5Ydi9idmhmWXRpalhJNlpEMmZWVXVualBRZW56M002MERhMndo?=
 =?utf-8?B?Um5ncXJma3VMZzJiSmJ1ZXpuQnNIdVRzdUhWWTQrblg3WTVLa2pGbUNla2tk?=
 =?utf-8?B?ZFBnMGFISU1mYUpYRFBSV1QwOUJvY0JaRWx3WlYrc2VSNUIzalAwamRiMllF?=
 =?utf-8?B?dythT2dCZGlRM1huUUVoMktFNzJhWEI2eTFnZkxQSTRwUnRlQXo5enZkQXU4?=
 =?utf-8?B?NlBEYnFkd0thVGdvUlk3dDcwMWh1Qm5Cc2E4bVUyQkhjdmQ5OHFpS1RrMlZn?=
 =?utf-8?B?ZDVuc3RxZEpzSWhUV2FJMC9uR2U5OFc3b1hoaXhFSnBwTTluMEtiZm1RZlAv?=
 =?utf-8?B?Unh6d1hrdkNzM3MvWlJCdEVSbExiandwNlRBWkxTei9nZFFYdmJwQVlUelFz?=
 =?utf-8?B?NkViWjZNOXU5VGgrL0ZzeHZGTzNiSk9lRkYvWVNsaTdTNWdiTVFUTGN0ZDQ5?=
 =?utf-8?Q?uif2aaIyAAYctQb8T6P3BtY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2HhvKOVKx7c68M+4xHk6cHOyfbxBWNw+es1u90Pq1lwh5KOGYXqeY019xXP6/mLZAmR6olkQ8x4Da2t1oXkGpoO9ELZwT6r2Ri6BRmr7LUHKe3uO9PeCUom/Q+ikWHCb7CpDbz0+k4bDouvjEwFLlaAV4ODkkCkc54JDqtOK6rZw8cZ2a+BuP47DWo/VyRLeWAf6sjSdAOR++LCBKA4ty5LgRiQv0G/ucYjEpHlOMeZ6b0G+VBeT6mftEGgvq+2Vhi+Machk9C0NHWFwCOxvrHkCCHYptc8E0SkSQEWEKwHfZ9WpnP1+6sI7jd2ucMzPdqT5hzn7QtfI00DmWsZOtDpdjohi/2W5EnO8CDPhXl5YF+GWF/JG1RjZ65hKDxM4Kd47o/VLuq73gNH+65M41i1k1L6CIdZDG4f3P0L2ntFlFdsdUkWtb+Z2ZvyDbvFgZhu1+T8YEQSGauSh1BINlRsdLGQtwmbTOlZoSWGmNtwYMbP8LKWLbR3/VcbS2Iu3KF56pL48+bucwMkXy7bhl3gac3+ajcW1hzF05zw9AyoSeqiZB/5HeoYljPM3DbN6FUd7a5a5cwCWQbndebsEW2+UoCo74srfMP+rQtch7rU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f21f0f08-2a83-443a-deb3-08de1d362ef3
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8421.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 13:12:48.9615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t0ZYb4XdJPRylts/dmmskYmlodxHy8RHoCUz7Hl4mN4yEwEyHu4JlngpbS5TDrl5NUrRgTPx9NRKfyyw7yJ3jFlC0atlnHKYkq4JRXxULahdKIXQiHSibotxfUle+5re
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4226
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511060104
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzMCBTYWx0ZWRfX0jXM3ASYlaWZ
 fL91Yx6yTVrC967z9mDJmMjlJlyeJJr40m81XbcRRx86X6DwO8nFdb7oTb9nCPwoD0/u9M726TG
 84509dUPByjegoQZ5G6fxWCIPVQ1E4QtJ9X453/GabAmEnuNOda3CmwLeslk/Ur74FUGiuBM3HS
 8aat/RR78fIcv3ws3+VN627XlAFadkB0V4AzWt0x+kFB19XANZILEtaoEqtPAbEEG+h/D33X32v
 Pw6UMTd7cSsF7VbCYyiBoWwTrP/LGuv9gGb3vBVss+jdIVxZJ5gQi1+2tQbN+05oXggiLA4r3Sy
 vlCsZilP5VJzfh53MPvrgyU4+Uj8FxQvs9ismtsj7T3skb6aHTAwLHkG3ESnY48apcginMIYDZO
 UB0my0H/HYxcuGT91f8A9pUmqVW5KQ==
X-Authority-Analysis: v=2.4 cv=R8IO2NRX c=1 sm=1 tr=0 ts=690c9ed6 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=tTCVkzBRXDljeeFqwEQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: YKKsxxnJRexytwImdsl_AyE7jv2mC6N4
X-Proofpoint-GUID: YKKsxxnJRexytwImdsl_AyE7jv2mC6N4

Hi Alexei and Quentin,

On 06/11/25 07:55, Quentin Monnet wrote:
> 2025-11-05 18:14 UTC-0800 ~ Alexei Starovoitov
> <alexei.starovoitov@gmail.com>
>> On Wed, Nov 5, 2025 at 6:05 PM Quentin Monnet <qmo@kernel.org> wrote:
>>>
>>> 2025-11-05 17:29 UTC-0800 ~ Alexei Starovoitov
>>> <alexei.starovoitov@gmail.com>
>>>> On Wed, Nov 5, 2025 at 1:38 AM Quentin Monnet <qmo@kernel.org> wrote:
>>>>>
>>>>> 2025-11-04 09:54 UTC-0800 ~ Alexei Starovoitov
>>>>> <alexei.starovoitov@gmail.com>
>>>>>> On Sat, Nov 1, 2025 at 12:34 PM Harshit Mogalapalli
>>>>>> <harshit.m.mogalapalli@oracle.com> wrote:
>>>>>>>
>>>>>>> It is useful to print map ID on successful creation.
>>>>>>>
>>>>>>> JSON case:
>>>>>>> $ ./bpftool -j map create /sys/fs/bpf/test_map4 type hash key 4 value 8 entries 128 name map4
>>>>>>> {"id":12}
>>>>>>>
>>>>>>> Generic case:
>>>>>>> $ ./bpftool  map create /sys/fs/bpf/test_map5 type hash key 4 value 8 entries 128 name map5
>>>>>>> Map successfully created with ID: 15
>>>>>>>
>>>>>>> Bpftool Issue: https://github.com/libbpf/bpftool/issues/121
>>>>>>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>>>>>>> Reviewed-by: Quentin Monnet <qmo@kernel.org>
>>>>>>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>>>>>>> ---
>>>>>>> v2->v3: remove a line break("\n" ) in p_err statement. [Thanks Quentin]
>>>>>>> ---
>>>>>>>   tools/bpf/bpftool/map.c | 21 +++++++++++++++++----
>>>>>>>   1 file changed, 17 insertions(+), 4 deletions(-)
>>>>>>>
>>>>>>> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
>>>>>>> index c9de44a45778..f32ae5476d76 100644
>>>>>>> --- a/tools/bpf/bpftool/map.c
>>>>>>> +++ b/tools/bpf/bpftool/map.c
>>>>>>> @@ -1251,6 +1251,8 @@ static int do_create(int argc, char **argv)
>>>>>>>          LIBBPF_OPTS(bpf_map_create_opts, attr);
>>>>>>>          enum bpf_map_type map_type = BPF_MAP_TYPE_UNSPEC;
>>>>>>>          __u32 key_size = 0, value_size = 0, max_entries = 0;
>>>>>>> +       struct bpf_map_info map_info = {};
>>>>>>> +       __u32 map_info_len = sizeof(map_info);
>>>>>>>          const char *map_name = NULL;
>>>>>>>          const char *pinfile;
>>>>>>>          int err = -1, fd;
>>>>>>> @@ -1353,13 +1355,24 @@ static int do_create(int argc, char **argv)
>>>>>>>          }
>>>>>>>
>>>>>>>          err = do_pin_fd(fd, pinfile);
>>>>>>> -       close(fd);
>>>>>>>          if (err)
>>>>>>> -               goto exit;
>>>>>>> +               goto close_fd;
>>>>>>>
>>>>>>> -       if (json_output)
>>>>>>> -               jsonw_null(json_wtr);
>>>>>>> +       err = bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
>>>>>>> +       if (err) {
>>>>>>> +               p_err("Failed to fetch map info: %s", strerror(errno));
>>>>>>> +               goto close_fd;
>>>>>>> +       }
>>>>>>>
>>>>>>> +       if (json_output) {
>>>>>>> +               jsonw_start_object(json_wtr);
>>>>>>> +               jsonw_int_field(json_wtr, "id", map_info.id);
>>>>>>> +               jsonw_end_object(json_wtr);
>>>>>>> +       } else {
>>>>>>> +               printf("Map successfully created with ID: %u\n", map_info.id);
>>>>>>> +       }
>>>>>>
>>>>>> bpftool doesn't print it today and some scripts may depend on that.
>>>>>
>>>>>
>>>>> Hi Alexei, are you sure we can't add any input at all? I'm concerned
>>>>> that users won't ever find the IDs for created maps they might want to
>>>>> use, if they never see it in the plain output.
>>>>>
>>>>>
>>>>>> Let's drop this 'printf'. Json can do it unconditionally, since
>>>>>> json parsing scripts should filter things they care about.
>>>>>
>>>>> I'd say the risk is the same. Scripts should filter things, but in
>>>>> practise they might just as well be comparing to "null" today, given
>>>>> that we didn't have any other output for the command so far. Conversely,
>>>>> what scripts should not do is rely on plain output, we've always
>>>>> recommended using bpftool's JSON for automation (or the exit code, in
>>>>> the case of map creation). So I'm not convinced it's justified to
>>>>> introduce a difference between plain and JSON in the current case.
>>>>
>>>> tbh the "map create" feature suppose to create and pin and if both
>>>> are successful then the map will be there and bpftool will
>>>> exit with success.
>>>> Now you're arguing that there could be a race with another
>>>> bpftool/something that pins a different map in the same location
>>>> and success of bpftool doesn't mean that exact that map is there.
>>>> Other tool could have unpinned/deleted map, pinned another one, etc.
>>>> Sure, such races are possible, but returning map id still
>>>> looks pointless. It doesn't solve any race.
>>>> So the whole 'lets print id' doesn't quite make sense to me.
>>>
>>> OK "solving races" is not accurate, but returning the ID gives a unique
>>> handle to work with the map, if a user runs a follow-up invocation to
>>> update entries using the ID they can be sure they're working with the
>>> same map - whatever happened with the bpffs. Or they can have the update
>>> fail if you really want that particular map but, for example, it's been
>>> recreated in the meantime. At the moment there's no way to uniquely
>>> identify the map we've created with bpftool, and that seems weird to me.
>>
>> ID is not unique. If somebody rm -rf bpffs. That ID will not point anywhere.
>> Also it's 31-bit space and folks in the past demonstrated an attack
>> to recycle the same ID.
>> So the users cannot be sure what ID is this.
>>
> 
> Ah. I did assume it was unique :/. My bad, then in that case it doesn't
> make too much sense, indeed.

Thanks a lot for your inputs on this. I have learnt a lot by following 
this discussion.

Thanks,
Harshit


