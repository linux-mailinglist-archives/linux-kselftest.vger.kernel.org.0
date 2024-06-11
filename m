Return-Path: <linux-kselftest+bounces-11694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C86909042D6
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 19:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1962728C17F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 17:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DB554F8C;
	Tue, 11 Jun 2024 17:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N4Adh+lG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="laDchB16"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852D13D388;
	Tue, 11 Jun 2024 17:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718128548; cv=fail; b=QHLL/FSGGnapMOKy5M+g110wKtuzTbC3j/u8QusQQ8iPB+JdoMoFucv9d86NY3dUiVmrWwHXyLLaSxZkSMW/1MGGyeT8zn4PRbvaIexUNRUqfwGddQGzgsPmdPppq67Ruu6Ml5pFkn9eVfbbGoRWrTYCHMOx1cRzcJck+3KjYkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718128548; c=relaxed/simple;
	bh=7V/GKwMWB+r+ZX2KFQgKwuEFG4SbBtltLKUbv/mW1NE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EnPH9moeRm5Wi1m6HYkCqJ+/l2nBCfmA3hTK8JWVqsAjre8usKTywA9hG+DT9wnQs691SQ9SHRwinVAWaOhMUEF8XsPOF7jMDRk0NBzel2nL2+RCgOTh+zgKxgpVGrq7pUu0UW1G0ugjoJNBDUcEVLwiMOnV34UsMc/t1WUIYik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N4Adh+lG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=laDchB16; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BFhbub012582;
	Tue, 11 Jun 2024 17:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=Uuvz455fN86XLlstPAxa755wgMIsSq254o5XuQleJfI=; b=
	N4Adh+lGJBP6FhoOLppNtnFEiZSdS6YGhV1OidMDw/ywoNXB06gr/+wdZIP+NDi6
	vo8e0jaVuW7pQ6LcAZJVnMqWg/W5PlYtg+P13bBbVpg9uL+sEz4G0NruE85dejQl
	Lhm8AAkRpjukC/lHfOyrBcCpVR7mfHtuGuyu3kBtYeSHdreqtwVqcXt7n79DK1W4
	HxmlBP4CdcZO+yJes7gVQBPY+UqEU1mlf+EswJH8k7hGcTV+XpleKwRBhCTFP11j
	TjSxHRDlKs1tsuyrSFGjt/zQ7QucfePqoYi9ij7GzXSAo+1adZlAA3Tj+txmEVn5
	T2oVggWx7lZnh66tLcXPXA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymhaj5ewt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 17:55:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45BGqlFA014365;
	Tue, 11 Jun 2024 17:55:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ynceuabjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 17:55:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfs2w+FDd+OVEfQBCxsJqDbMG4oGPG0ycAbHRboexOlV5ViK1j9NCo3UfC0q4PjF8eOWqgO5l4N4Ub/5WrehQAMw1VDrz54rjCDGwigOkkXAwkmvgy4JJYkKNaXiWTCmMWtv6F7lnMokAb/c8rwnVjDM0GmBrZETdI7MzYOgDOvsolMDBPDLEOQAxYBe85IfdRL/bJZBE9bc+Qxt0kyqgYe6hYqM8138BcjNUE/gSYdqm1h1BMAemxV9B175HqL4QlqiU9dpJMJWhf+qq4dK6V/FkB166E4fk/8J9wa7cw52RcWj8Y8SFn2O1uk8xaZytii6C9iYc1nY1k6asClaHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uuvz455fN86XLlstPAxa755wgMIsSq254o5XuQleJfI=;
 b=dJ7Xuxq59OqvHGfPl58flPMQlwpxgLmStjM96WUUcP3aSjVCmYOCOHNbABdG4dyuq2N3Ma7TzHw8RLzBCWmWlcXiHs5noLwGB0O2Il8cmraWMUMQBLp+Q7ezrDNb67SYjradilv/pU5ja5oYAKnZD1st/nqnK2mrbFkU/7HmBTxuX7hp0yhHfPu/nCpYLX5pk1KNdBsSo8Bm7yeJZ4npkWUZZoyE1zgBHyyNJTKA95Qtb+Z2JhsQZidNesBoenuY4DoZ4QJliXoJegFukLtNCwpmA+zespQtffB9XcZ8qHLv16s3W1rAybSSzoURYS/68lhxG9kh/DVH81aK8gVhXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uuvz455fN86XLlstPAxa755wgMIsSq254o5XuQleJfI=;
 b=laDchB161AKT1BLhsN3JiYlMJLTC5zIvthk0ZukSoZlcX0R/wTommkcN4iSTXs0qMat6MHzIZIZZULl/hpaz6jAgwfxml7ZIDCZPlToh5LBEOUkklT0Dq5CROGXeTqT6QJQJ9usU09C8gV3DDvD1dSFNfqZR2rsJiGqMS/zubkc=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BLAPR10MB5204.namprd10.prod.outlook.com (2603:10b6:208:328::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 17:55:13 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::3db0:ec21:1957:f1b3]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::3db0:ec21:1957:f1b3%6]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 17:55:13 +0000
Message-ID: <f446406d-7739-4367-ac68-0a3f30c04612@oracle.com>
Date: Tue, 11 Jun 2024 10:55:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] Userspace controls soft-offline HugeTLB pages
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>, naoya.horiguchi@nec.com,
        akpm@linux-foundation.org, shuah@kernel.org, corbet@lwn.net,
        osalvador@suse.de, rientjes@google.com, duenwen@google.com,
        fvdl@google.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, muchun.song@linux.dev,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20240531213439.2958891-1-jiaqiyan@google.com>
 <21841726-6427-5a92-a3d1-8aac2687c01a@huawei.com>
 <CACw3F52Ws2R-7kBbo29==tU=FOV=8aiWFZH2aL2DS_5nuTGO=w@mail.gmail.com>
 <2738aa0e-99d8-44d7-ac81-e38fd64591b7@oracle.com>
 <CACw3F50rh08o0hAG1rSfUnuJ3wezjCa8_ZE4rUGRUntUfx+-OQ@mail.gmail.com>
Content-Language: en-US
From: Jane Chu <jane.chu@oracle.com>
In-Reply-To: <CACw3F50rh08o0hAG1rSfUnuJ3wezjCa8_ZE4rUGRUntUfx+-OQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:a03:331::16) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|BLAPR10MB5204:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d5b658a-7bc3-47cc-6503-08dc8a3fa48d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006|7416006;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UmF0ZllNOXdEaGdNdlFHeEM0ZE1rUEU1QmVxMW9rMU1BZWdnajArbFlKNDdi?=
 =?utf-8?B?eGVodHNRSFM0ZlJmbndtTDk0bXduMVZ1NHhtMXFCZVVYNGNzNWxTVi9VT042?=
 =?utf-8?B?TUwzTGZ0V0pEb2lEcXRnVEZoUFc5aEhqTi9DWHltSnVhczFMNFZZZXQ2c0N4?=
 =?utf-8?B?aDkvVk00UUdEU0w1THU4andmN2Y4S0puOVVoQ0tHTGttMUhubk5pdXVxSENR?=
 =?utf-8?B?cEpBVit6NW1CdDZvVnJ2NVE2b05ZWUp1ZEVjUks2UjZpb202Sy9FMUlFalc5?=
 =?utf-8?B?N1l5N3c1VHZ4eUpscm9seEV2UDZ2K3ZIdWZLL3hOSWVjWVFNQVpJZ2FvMGNW?=
 =?utf-8?B?Rk1nRnNHS2RVU3BTUmQzUFZUVGU3dGZLQmlmR0VQcDdLMStnREtMNmxtazlS?=
 =?utf-8?B?ZHczNkJjbERsYy90endJMmwva2oyMEhUTndUS0ZEdXNJaUZHNkZJQnF5dGM5?=
 =?utf-8?B?cEQ5Q0w1L3V6RktKZXpTcjN5bHYyL3R6UDkvNWtHNDZRT0ZqVXUydk96KzRq?=
 =?utf-8?B?aVNEU3pTdXpDSG13Q0JRK01odGRvVXdBK3d0dFFNdHRpc1NDS1FwZXMvOHVt?=
 =?utf-8?B?aG9FcHV2Y04zOFlPVnd0ZkttYmhVMVdWSTNmQ1h0N1BINmRlQ0F0UWk4dFJP?=
 =?utf-8?B?YTBKdk1ydlNVdFJOQWYzdDJWRStPZXpHelBVbjhYZzBzM1p3b00ybDdZbGI3?=
 =?utf-8?B?akROUzNKVFdnbE9URFhINXVzbzh0UHg5TW9zSStPMUhBQllQcnhRUUFoczNh?=
 =?utf-8?B?bkJIRFBXWkxhUG5kUDVpZzNjUEpLcmUvKzFldFc2UkxmdzNOOCtzV2s5aE40?=
 =?utf-8?B?b3R4Ym1LVkRzbFBtWEJ3ZTJnZ0JiWVhSOE0vQ3pQV3NVODI3UmQ1cThKcmxM?=
 =?utf-8?B?ekdrVlQ0clVEYlBMZ2FiNjA3QXAxRWwzeGtqYWxzUVlkb294RUFWTjFKNTk3?=
 =?utf-8?B?UURqSzducGxKYTRkTElqeSs3bVk3eHJvZ0hjdUdaMEhrSmhDdlFmcUxNZGxH?=
 =?utf-8?B?M2l1V0xPYi96WC9JUWMrdk15MGljMXlXcitnUlpnMnRhd0R3VEJkRDh3Vk82?=
 =?utf-8?B?VUl6UVgwTmxKRzNSS2d1bUhvVlRuOHNmMUc4WjQrcmoydElubnVjRFZhUlVp?=
 =?utf-8?B?ckZBM09acTh5ejR6ZURRMSsrVjB1VEd3MDl5UnhqVHdGZkF6ekhOalFsMjlq?=
 =?utf-8?B?WmQ4MlUyMm9HK0x5dndLWmNFS2VCL25xYUxqQmlCNjlsbDA1TUFUVUczUEVU?=
 =?utf-8?B?TWg2Q1BBczk3eEl3NG1KNHlRQVFBcHlyYnJ6UzRNRDQvZUxiWXBkZFhLQnBN?=
 =?utf-8?B?WTRmbzdJRE90NGJZcnJpWlV1dzF1cEF4ek1hOENTTW5OdS9CN1FadVZIUTVT?=
 =?utf-8?B?NURZODE2SVhTb05CRE04Y3dvQ3FnSVVJaW5QUjhFUWkrckk4TEZwWWd3Ujd5?=
 =?utf-8?B?N3JxRFBMWFN4UXBjOW96czZyUXpxSGZNaGx6NnZUdUx0SmZycFpzVEViVXpM?=
 =?utf-8?B?S0lpeG54Yjk3UWtWaXkzbUlyS0VlTDR0UVBLRzI0S2Y5Zll1ZEdZZllxb2Ra?=
 =?utf-8?B?UHZ2U1VtbDRQMHBUejJwb1NGVUE2VlZib2dkN05GTFdCUXdOWXdDRUVwcC9P?=
 =?utf-8?B?Sk1rSnkrQ2xwN0RWcWVOVzg2d3pmUi9sWUhHanV4K1JsUk9UVmdhTndlQWxN?=
 =?utf-8?B?T3hpVTFLUUFuWExpNlRjdlZycjFkTmJlWGpGRWRuaVZ2dzd1eGpFVTJGRnMz?=
 =?utf-8?Q?DH5Um4KoVNCO4BVusnhpz0w3g5mGQCr4aU22dBr?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006)(7416006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NFhCSk15ZFpOSThlOEpGQ2V3ZUw4UVVxY1RadXFFVDY3SWtEZys4anJYd2J3?=
 =?utf-8?B?MmxRaFk0K09weHNCbTBzQ3RwTFA0WXFUNndwcGZ2bngwWTRETHdVdVRlbllR?=
 =?utf-8?B?SlNCczlWTnd0ZDhNVmdxTlI2dE5oQ3Y5WjR6THdiam40TFU0cHR0NW4wUi9R?=
 =?utf-8?B?RmVGZjdwbC84RVFYbCtmNnJOOThlS3pDS21LQmRFWGN6cDF5NkRhMmpoeTJn?=
 =?utf-8?B?bk9pdVF3Z1N1a2tnNmZ6Y2ZaWTVlRlFqeWdEOEdSOVdiYWc4ZTg0Zm5lbDFT?=
 =?utf-8?B?MXgwTmdXOVk2SDY3RHhZZWhwZmdia01yTzFYN1MwTDVoOWEzUER5ZjRlbmxS?=
 =?utf-8?B?TlBMNUp2WDgxM2NaUktjaXZtazE4Sk1MS2pWb2RaYXNLS09mWUF6N3lRSi9U?=
 =?utf-8?B?b3VuaGNuOSsvR1Yxa1htVC91SzVwZVNNaHI5Vk1SMHJJQ2M2bkJ5RXFQSi9r?=
 =?utf-8?B?VzRkd3lQWWZTZW9aQ21xYUdzZXdoQnJaUlpNaUF1dnlKd0NYTVJmUHdjMUli?=
 =?utf-8?B?SEdXdlk3UEhlR1hYWCt6ai9OS3lvckRXdVIxamo1UlozbGkxeVl1RnUyN2Jt?=
 =?utf-8?B?REliZ2pQRk0yZDFTbVVkUzNCRVJNd25aRWtCaDE3UnFFWlBmZnhTK01hdHFi?=
 =?utf-8?B?RUtTV2R2ODZPUEZxVVcrM0hOZlJnbXJlTkErWkJyd2tTNkp3ZU5XWkxzVUta?=
 =?utf-8?B?V05MTmptRGo1ZUFPWCtyZVBwL0Z1VFJzK1I2WlBHQWRYZ0xpMGFqc2hyck5S?=
 =?utf-8?B?R1NKZFNtV0QrRWNCMmFPVHh3TXIrUHdXSGJUVXZpMEJGYlFnRDg4SDNYUGRx?=
 =?utf-8?B?VU13TTJFZVBicmhBWXdGZnBvdTdRbFkvMm44UlNrSE5UT0k5Ky82OVY5N29I?=
 =?utf-8?B?c0tNSjFjMndLc2ZPZEVIL0REWDRacDJTdVJ5c1ZVbENwMFN1WXRFc2RzcTlK?=
 =?utf-8?B?Q3dMc3k5NndvRnhxOEZ0RVQyOVEwY0lucXVMZjZodk5SQUFJYkwrU0JHbVdG?=
 =?utf-8?B?TEpWbHdoOGQ4NjJoUmdQa3FYOVNhWjFvYmJYOVRvVnl0VWhLNG8vTlJvMGhz?=
 =?utf-8?B?WWpaYUhXa1FLOU52Z0ovN1JnczZWWTVCWHM3dVV3TDVrWHEyL0RWNjhtOUhq?=
 =?utf-8?B?WkE1ZlRzemFQSTNyZnlxVURvb1FwZUtPR2dDQ2tFMEJScytaeU9PZG15cXRE?=
 =?utf-8?B?TFdpRVcwTDU0Zld1NEE1NWFNTGovb3pQSlpNZlUwdmp5cHlCS05WZXVwN25x?=
 =?utf-8?B?ZDcrMldrbnU2TDRJaFFmSC9XVU1hRUtPQUdBYXF5ZjVDQ3RFbEYzM1pwUEFJ?=
 =?utf-8?B?OFNETStvcnRRMmlteTRkTXp6Y1pMZ0YwY3Z1cy85RmNuMHFYSHJ2SmdMZVZw?=
 =?utf-8?B?ZjRSUllPL3F4N0VCeUwya3d2M0VIeWRYZDJxNTVrSzdxR2J5SGlXVHFPVkI0?=
 =?utf-8?B?SE5SUGNoNGtRVFI1eDNLWmZmWXMzeENJS29jYjN6SENtVFYyb2JzejFURUtv?=
 =?utf-8?B?WTZJMHZCemEvTlZacTNPa0dLVjBuUVVLS3NHWE5WaDAra2xNeWM0NzhMSWpI?=
 =?utf-8?B?MG1OL3h1VHMxUElSMUszUnBpSnZsemtLRTAxaVlxWEpheUxGRWxUdnFXVzZX?=
 =?utf-8?B?aTlpbVVtUmNDSjZJb1gzSlJOcnBXdkZRRDNqVFlGVjR1anNCQlZFSHArcEF3?=
 =?utf-8?B?R25jMlU0bzh1UE9rZFNqaEYrUGhBT3VCOTU2WFo4dzUxclFveC94ai9GOUl0?=
 =?utf-8?B?VHpCU1IyRXNBOGxLVExldXJ5WTRnU1p5RnRFbUdPOUVtRngxcjQ4dkltaGU2?=
 =?utf-8?B?bVNSNHdHckNZVEdmN0cvK2NBMmRyM2pKLzMvSk9Bem4rVGwzaU1JOVZJdW1v?=
 =?utf-8?B?STlsazhkR2RXVXdvaHVnNmc3VjRvUnBmR3NNLzJhODYzNHd5dzg0czlITm5H?=
 =?utf-8?B?N1ZYTmVvMVhUZjlPZ0Z6a1JZMFdzWXJXMGNPdFJPNCthU21hYXE5Qk5vOEVH?=
 =?utf-8?B?NTB5Mk5BVGpYZWhmcEJlajVmb2dzSlowTXRHMkl2QUJ1Mk5GcDVHVmVmNlEz?=
 =?utf-8?B?ZjNQeFVzOTlqVW5Gb080enRmMG5xa0kxa0xaMkxac0pVamJ1VnB5dGxVZlVo?=
 =?utf-8?Q?P1jHtRE7mdSIr9LG+S/IXmVLq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	IXHafbelvDAWiy+N78AhnS3Gmi2QinCH28DNUt+Jh1/qCEt7p5P2AtBH63m61tarYLh+tlKRpSU+w3JkiVgOgdzqHcyp+QmTCv6wsnOWQgni0Ehgmu+QfpbuV39BRKhuwPku1hjW6iA4VELwk5yb7eM7bt/ub2UZL5x2hv/THamFh8iSGjj2bTfPJooYtVATLglNCLgbpEfjQOY1dOLLMhuLRo+71MD/QkV+voIN+wgJlaRbWLYx0SVkdke/DHv3a7oacA4nZqIkaWEqNa6jy23XNKA5m2w5ABIxGTgopcBqVhQ3kkRpob8HGDZcrTydXTjHSGY9FCaFqmPtbdbD/95FzTZHnBBmYVwBJebFczgVdPW40X/fdLqWGfN01MhYag0TdkajnWTqGwAzquxEn/wjXdhA1Qk0ILmfr+rc7qy+XMHt4RiUtClwqjeAMLWqD6UKL2Re07F5o4V9mhpiAoU0MbS3IOG3ZMG7Ikx4NhJow1FOepsX0NTdIlx3jKWylKeCj2+bnMgPlkWFTeIlr4eOfNaBTF9K/8XuFovDm2KfHU1Ak4v9nr3Kjbj9McbOQWnuzd1uW+FzC9UXNQTv71hWCd8PlGU463U3a78v/Rc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5b658a-7bc3-47cc-6503-08dc8a3fa48d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 17:55:12.9226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxNkzHqawOTEZDdjuNM96aa7aTMubsvOpYnjd5ARZ2DWSJpzFAl2Rk1krIvrix8Pl5WGkGlpo4impOCK4LHt2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5204
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_09,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406110123
X-Proofpoint-GUID: DUPCtPQdKl7qDUGV44PjG7f_HxoiDU3e
X-Proofpoint-ORIG-GUID: DUPCtPQdKl7qDUGV44PjG7f_HxoiDU3e

On 6/10/2024 3:55 PM, Jiaqi Yan wrote:

> Thanks for your feedback, Jane!
>
> On Mon, Jun 10, 2024 at 12:41 PM Jane Chu <jane.chu@oracle.com> wrote:
>> On 6/7/2024 3:22 PM, Jiaqi Yan wrote:
>>
>>> On Tue, Jun 4, 2024 at 12:19 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>> On 2024/6/1 5:34, Jiaqi Yan wrote:
>>>>> Correctable memory errors are very common on servers with large
>>>>> amount of memory, and are corrected by ECC, but with two
>>>>> pain points to users:
>>>>> 1. Correction usually happens on the fly and adds latency overhead
>>>>> 2. Not-fully-proved theory states excessive correctable memory
>>>>>      errors can develop into uncorrectable memory error.
>>>> Thanks for your patch.
>>> Thanks Miaohe, sorry I missed your message (Gmail mistakenly put it in
>>> my spam folder).
>>>
>>>>> Soft offline is kernel's additional solution for memory pages
>>>>> having (excessive) corrected memory errors. Impacted page is migrated
>>>>> to healthy page if it is in use, then the original page is discarded
>>>>> for any future use.
>>>>>
>>>>> The actual policy on whether (and when) to soft offline should be
>>>>> maintained by userspace, especially in case of HugeTLB hugepages.
>>>>> Soft-offline dissolves a hugepage, either in-use or free, into
>>>>> chunks of 4K pages, reducing HugeTLB pool capacity by 1 hugepage.
>>>>> If userspace has not acknowledged such behavior, it may be surprised
>>>>> when later mmap hugepages MAP_FAILED due to lack of hugepages.
>>>> For in use hugetlb folio case, migrate_pages() is called. The hugetlb pool
>>>> capacity won't be modified in that case. So I assume you're referring to the
>>> I don't think so.
>>>
>>> For in-use hugetlb folio case, after migrate_pages, kernel will
>>> dissolve_free_hugetlb_folio the src hugetlb folio. At this point
>>> refcount of src hugetlb folio should be zero already, and
>>> remove_hugetlb_folio will reduce the hugetlb pool capacity (both
>>> nr_hugepages and free_hugepages) accordingly.
>>>
>>> For the free hugetlb folio case, dissolving also happens. But CE on
>>> free pages should be very rare (since no one is accessing except
>>> patrol scrubber).
>>>
>>> One of my test cases in patch 2/3 validates my point: the test case
>>> MADV_SOFT_OFFLINE a mapped page and at the point soft offline
>>> succeeds, both nr_hugepages and nr_freepages are reduced by 1.
>>>
>>>> free hugetlb folio case? The Hugetlb pool capacity is reduced in that case.
>>>> But if we don't do that, we might encounter uncorrectable memory error later
>>> If your concern is more correctable error will develop into more
>>> severe uncorrectable, your concern is absolutely valid. There is a
>>> tradeoff between reliability vs performance (availability of hugetlb
>>> pages), but IMO should be decided by userspace.
>>>
>>>> which will be more severe? Will it be better to add a way to compensate the
>>>> capacity?
>>> Corner cases: What if finding physically contiguous memory takes too
>>> long? What if we can't find any physically contiguous memory to
>>> compensate? (then hugetlb pool will still need to be reduced).
>>>
>>> If we treat "compensate" as an improvement to the overall soft offline
>>> process, it is something we can do in future and it is something
>>> orthogonal to this control API, right? I think if userspace explicitly
>>> tells kernel to soft offline, then they are also well-prepared for the
>>> corner cases above.
>>>
>>>>> In addition, discarding the entire 1G memory page only because of
>>>>> corrected memory errors sounds very costly and kernel better not
>>>>> doing under the hood. But today there are at least 2 such cases:
>>>>> 1. GHES driver sees both GHES_SEV_CORRECTED and
>>>>>      CPER_SEC_ERROR_THRESHOLD_EXCEEDED after parsing CPER.
>>>>> 2. RAS Correctable Errors Collector counts correctable errors per
>>>>>      PFN and when the counter for a PFN reaches threshold
>>>>> In both cases, userspace has no control of the soft offline performed
>>>>> by kernel's memory failure recovery.
>>>> Userspace can figure out the hugetlb folio pfn range by using `page-types -b huge
>>>> -rlN` and then decide whether to soft offline the page according to it. But for
>>>> GHES driver, I think it has to be done in the kernel. So add a control in /sys/
>>>> seems like a good idea.
>>> Thanks.
>>>
>>>>> This patch series give userspace the control of soft-offlining
>>>>> HugeTLB pages: kernel only soft offlines hugepage if userspace has
>>>>> opt-ed in for that specific hugepage size, and exposed to userspace
>>>>> by a new sysfs entry called softoffline_corrected_errors under
>>>>> /sys/kernel/mm/hugepages/hugepages-${size}kB directory:
>>>>> * When softoffline_corrected_errors=0, skip soft offlining for all
>>>>>     hugepages of size ${size}kB.
>>>>> * When softoffline_corrected_errors=1, soft offline as before this
>>>> Will it be better to be called as "soft_offline_corrected_errors" or simplify "soft_offline_enabled"?
>>> "soft_offline_enabled" is less optimal as it can't be extended to
>>> support something like "soft offline this PFN if something repeatedly
>>> requested soft offline this exact PFN x times". (although I don't
>>> think we need it).
>> The "x time" thing is a threshold thing, and if your typical application
>> needs to have a say about performance(and maintaining physically
>> contiguous memory) over RAS, shouldn't that be baked into the driver
>> rather than hugetlbfs ?
> I mostly agree, only that I want to point out the threshold has
> already been maintained by some firmware. For example, CPER has
> something like the following defined in UEFI Spec Table N.5: Section
> Descriptor:
>
>    Bit 3 - Error threshold exceeded: If set, OS may choose to discontinue
>    use of this resource.
>
> In this case, I think "enable_soft_offline" is a better name for "OS
> choose to discontinue use of this page" (enable_soft_offline=1) or not
> (enable_soft_offline=0). WDYT?

Yes, as long as enable_soft_offline=1 is the default. Out of thought, I 
suppose the CE count and threshold can be retrieved by the GHES driver? 
I haven't checked. If so, maybe another way is to implement a per task 
CE threshold: add a new field.ce_thresholdto the tsak struct, add a 
function to prctl(2) for a user thread to specify a CE threshold, also a 
function to retrieve the firmware defined default CE threshold, and let 
soft_offline_page() check against the task->ce_threshold to decide 
whether to offline the page. If you want to apply the CE threshold to 
patrol scrub triggered soft offline, than you could define a 
global/system wide CE threshold. That said, this might be an overblown 
to what you need, I'm just letting it out there for the sake of brain 
storming.

>
>> Also, I am not comfortable with this being hugetlbfs specific. What is
>> the objection to creating a "soft_offline_enabled" switch that is
>> applicable to any user page size?
> I have no objection to making the "soft_offline_enabled" switch to
> apply to anything (hugetlb, transparent hugepage, raw page, etc). The
> only reason my current patch is hugetlb specific is because
> softoffline behavior is very disruptive in the hugetlb 1G page case,
> and I want to start with a limited scope in my first attempt.
>
> If Miaohe, you, and other people are fine with making it applicable to
> any user pages, maybe a better interface for this could be at
> something like /sys/devices/system/memory/enable_soft_offline
> (location-wise close to /sys/devices/system/memory/soft_offline_page)?

Or, you could use /proc/sys/vm/enable_soft_offline, side by side with 
the existing 'memory_failure_early_kill' and 'memory_failure_recovery' 
switches.

You could also make 'enable_soft_offline' a per process option, similar 
to 'PR_MCE_KILL_EARLY' in prctl(2).*
*

thanks,

-jane

>
>> thanks,
>>
>> -jane
>>
>>> softoffline_corrected_errors is one char less, but if you insist,
>>> soft_offline_corrected_errors also works for me.
>>>
>>>> Thanks.
>>>> .
>>>>

