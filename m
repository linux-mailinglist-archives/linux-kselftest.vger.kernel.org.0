Return-Path: <linux-kselftest+bounces-14601-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E77F9446B9
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 10:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33EF62837E8
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 08:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B712216F0E0;
	Thu,  1 Aug 2024 08:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GNOZ1N4s";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TUUD3aBi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFFA16DECA;
	Thu,  1 Aug 2024 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722501374; cv=fail; b=JuFL1yD92sTuDAiuMkJlzw0hCaiDKcRnCQ7IqgAHkXzMJx2xAb2/k9fl/CY3uzwLU+JBr4LlY9X22B61psdNa2/VAqXwbqnmbneALEuEkVKFvIihEe4R8X2SAYkvmUtTeZHzz7RfdZqkFrV5QSsUjFANdAz/tAmcaNsQ9hszHL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722501374; c=relaxed/simple;
	bh=JAR8yBj18+QMBlylETosV72nLerlefuL0bUb1qUwwgM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PHyB+o3kBYr2CUdMmQjyEKewVV7B5rsM2pD6JKkR5d1Y2DuzrfxQ+izypmWgzsUxiernDB+50127XjwYfeQa6dD11jdqvct2k415mGF5Fc5ox+n9PPGm5iojejwFbvertg1AyLGU58M+gjUmsCrT1Ykkxbt+rcdr1YgSxPgW0SE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GNOZ1N4s; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TUUD3aBi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4717tuWC004947;
	Thu, 1 Aug 2024 08:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=YQS7kJE2cKOg/dwTehNDIwimCWJCnU4JrA9aFfmf+JA=; b=
	GNOZ1N4sSLgmJEeKy2a2kL21Fw8Dd2Wa0lxaepcgYISafnau52fXaoS0l5cyW9yA
	hJYOGOwLbgBXQd3yDvj7t/P8t6Hur/LB873KNA+JyvdW5sRGkDXsTIBln5w04ARP
	p8XVREx78Iu+SKsXwZsQEovtx0lcLMDWyx3wFoM87p0aYh1D1wTUgzH9I87DmqrV
	B7aW07LTkv/IdhM9gXbhPXqeDJqCHEOuOBz9+u9R1elAn7pX3zUN+LkIqSnSlEao
	X7a8vwgbma9U+sRHSQQE06wMeTX3lorYQSwCQjkiMkfa0VP5BfIkIqtJTCECoVBx
	10zsyAHi6P/5Ne4kT/9/ow==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mrgs98jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 08:35:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47188Iav000726;
	Thu, 1 Aug 2024 08:35:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40pm85pa11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 08:35:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2Vl0ePldo5vUvo7Yvz1Wuk+yxQ9hKmFJr8eLBtao5mWGYQ0gItAGx+5V5SV8itU1PFnFSjkqEEF/8nN2qvDZA+KhPAJ8VnvCQ+dgRvj9AuLa07viGwQJcq/UGKUsCnzJyQ/l6JvaAdRom9FsoGs6txcrAQbQg3agYbTIM5r9h/dh169JShWuVePodQAnyRfF5Et7SLlhOVSq9lTLjRG84/X7KRAeYgYFIaGJzOsOUmq3TGULr7qoeflW+/tFL3Wiz/fTIkbjiF4kA2zoot7+G0w/eJhXX60zvE/Id73iSZa34XxazdtFPxGxHvqdM1RX9NTxuRrQ34XWSGHKTph3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQS7kJE2cKOg/dwTehNDIwimCWJCnU4JrA9aFfmf+JA=;
 b=js1FSiNfpoTc05jv+2MSQteNP+Cb0JuNVVIOHwBzbEOAWDjrj/T7cpDEpdj5GjuFQUI/OVALek+g/g1TxJOGqDenvXScdEmJDNjMIjeSHYPg80aAM3JT+nO8QpX2zQStWVvYXGt4UkilSLmRHZSE5eFt5tOcA6gnMe2RqdCm2Zg/1CFMNTLV0LOgVxWtWZsaFlYNSuqIH0WsJszydwubwAHOl6NU/+Cwjs0T6FMOZYK04g/Nqap0Xty8huLeoS6SoIAFdZHy5w/vVZO6gbx9/wNTpQGHkn4CyT/QQX/0qTm9JBZqZJxSf12JE+plk9Kt2tC3J9vKNObqRufUyTcpzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQS7kJE2cKOg/dwTehNDIwimCWJCnU4JrA9aFfmf+JA=;
 b=TUUD3aBimGb+2L0RYmfeBAfcSE1WQsYm8vVVAP09aIamrWHMdn+Fv9sJ66zaKd3v0HYQGT7jsEgGbXxkgNSjdjFnfX+9Td9b3emfJ/y77jGe/2VnOtTEiDUP01SdZZG55k7jNxi5WmbGS5Qk8v9Hi7t7jNj4HNSEpUm4vQ0Cajk=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS0PR10MB7405.namprd10.prod.outlook.com (2603:10b6:8:15e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 08:35:44 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 08:35:44 +0000
Message-ID: <e8b88d27-4e85-46f1-8ed4-df883abc8a51@oracle.com>
Date: Thu, 1 Aug 2024 09:35:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/4] selftests/bpf: add proper section name to
 bpf prog and rename it
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
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20240731-convert_cgroup_tests-v1-0-14cbc51b6947@bootlin.com>
 <20240731-convert_cgroup_tests-v1-3-14cbc51b6947@bootlin.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240731-convert_cgroup_tests-v1-3-14cbc51b6947@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0417.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::8) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS0PR10MB7405:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e216ba4-239f-4b47-d729-08dcb204ef0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDRrbzdnWE9waE13b2wzRDlxN0FNRlMzakE3OTVpeFlXemR2VGlydmJyT1V0?=
 =?utf-8?B?YkF5cDZyc05aWE5DWW41OHZveEdsSHR6amM5NUlhWStkc2tPL1lyZnpZSjlZ?=
 =?utf-8?B?TVk5bVZEU3FIZWtTVXd4VE1wWVI4d2ZISTV4THVwaXpEMWs4bGdFMWc1dm1E?=
 =?utf-8?B?cTVYT3R4N1VIdXZTT29Ic09FUzEzQkZJVkZkMEF2aWYxZEhrdXMxbzVKU08x?=
 =?utf-8?B?Q3VpaWxKV1pXbmpIdDBiOGEyWXQzcmpwZWlzOTJHcExpSHhpNXBQeithZ3ha?=
 =?utf-8?B?YTZVOVM5QUZ2bTBtc3IrU0R4Tmh5QzduZjVDOElEVlhPb1Zjc0l5dnM4VEU5?=
 =?utf-8?B?THVIQkl3RzlObWJsTlNubzZ6SXRMVnhMdUdmd0pLL1FSdzFXVjVhWVhFRnpG?=
 =?utf-8?B?RFVnTkgvby9rUHF4Tm95bTdOMU5iSlZlVU5ROGg3RVBLaERoUXFaYmoxUy9Z?=
 =?utf-8?B?b3pCRXFJd2o4RzhhMmdUcDRDMDlvTUs4S0R6UzF6enY5QUJXRzBXTFVaTkM3?=
 =?utf-8?B?Nk1iVU04V1llSGZWU1l2YWFIM1lUMnpPZXV4aVBSS2FMdDl3dU82enM1K09s?=
 =?utf-8?B?Z0YvYldYMEQvLzFZazJsamVvT2tpQ09DVGNwbXB6emZTOXZFYlBhYTlFR0xS?=
 =?utf-8?B?bGRKTVJBbFNybCs2dEVRNVVtemMzWWFycCtPQWY2bzVhOUVxOGlFNTRrQldy?=
 =?utf-8?B?RjB5TVhwMlZLMDNSMUw5QXNWK3lUc1JXSUdCb2lxT01kelpBL1hEWDg5Vjlv?=
 =?utf-8?B?azREaU9DbXNnUkNlSDJYd2J4Q09vbVRLUlVLM1dCVWRacUVlWVR4SWtBOTA2?=
 =?utf-8?B?NEF5aGtENFQ2OTdncC9HaGhvd1BpaGF1NnErRjRITnRDOEdSL2o2ZWlDS2kv?=
 =?utf-8?B?dzJBVkVZYUxOUU1xUmxqQnhDRjZ5NHk3UUhiS2dNT3hLSGdKclU1dlZzaFlx?=
 =?utf-8?B?Z3VXSGZQSWxEcUtaVnJnTkJUSUNHTDU2dUIwNVZ3UkxremdhYTVWKzV6NUUv?=
 =?utf-8?B?WEpHOVl2dVFZV1hvbGlDQWhuNVBCRlE4YUtpTUhEdXgwQjdlRzFuNkdFeC9K?=
 =?utf-8?B?N00xVjNyZHRkN2g0cUp2dmFkZE1JeVVIVDlxVEpTRUxjbDY4MkN6SHlSOG5P?=
 =?utf-8?B?aHR3TnhyeGwxRnZNbXRNbFhWblRQM2JqZ3dGTnpnaGNQS0haSWRPNUhUTzNl?=
 =?utf-8?B?THBTNTZDNjd5Z1graXdHK0kzeDJCWHJjalBiK3hyaytDNG1oM3ZSMDBMclBP?=
 =?utf-8?B?OWdMekZBYzBMaitiKy9hT2lmc2c4bFNzNE5vL0Y4dW0xdlZjZXNwamNLa1hj?=
 =?utf-8?B?c3FsdVVKa3dNTmh5aExjdmI2TlBPNVhQTGhjczFsQ0szNzFtbXBkNCtMMWtZ?=
 =?utf-8?B?V3hBOU9TMGY3dFcvSmtIWEVobUkwb3ptemJPNEI0WGNSOXc4M3pHbEF6anZN?=
 =?utf-8?B?Y2MxejQ5QWNIVHY5MUhmdHV4REx4QmxMUGdtaFMwSGdjaXNPeHQrVXB3ZklW?=
 =?utf-8?B?WHhXYVZqRGRmMW1nK3JEMEpzK2FaeHoyeXA1T1dEQWNpQTRnN1paTG5EbE9X?=
 =?utf-8?B?VkNabk5kOFordGxWeDlOaDR2RFVNTjN4Zy8vUk1jQmtZSyt4WElObTdtYWZ3?=
 =?utf-8?B?MXNTUTlQUnlFc3dvWXhMcWV4VHhVTzQ4QnRqZFR6TGVEQlRLb0Jzb1BSdGtz?=
 =?utf-8?B?dnhuTXdUc2pNY05vMUp6UFJRYStjTjJlaHB3R2E1T3ZsR0Zob1cyZFVzeGZR?=
 =?utf-8?B?UTNXSE9GbzRTMzNjS2NicktabGpYSVI4VlRSTnMraGlMelBxRTZHNndhUm5z?=
 =?utf-8?B?QS90amVTTXpxUmNOS0V4dXBXL1crcmpZWEEyS2dsRG9KeFNxaENTeGQzM1RJ?=
 =?utf-8?Q?5/b99EodMi2l0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alU1aUhNN0I0U1pIRnlIYWxmeTdaM0JaQzFzTU9yT1QyNWRRdHJkOHpOZ2lh?=
 =?utf-8?B?cFRUMW9RNUV2RUxaL09mT3FxbmtsN0UzVHI1dDZxbkNCeEpsM0FXWUEyQUll?=
 =?utf-8?B?aWQyem00aDh1cU8wRXIzYTAreHlLbXZqdDA2RzYycjFtLzI4aWt0ZU5VTkh4?=
 =?utf-8?B?NTI3Qkg3dGJPWGZGZGVsaFBialoxcGMxTWR0cXh2Rmg0STZIMFFxcVJoNGRJ?=
 =?utf-8?B?bEVsbEt3ZUV5VEorTW5WM2xlbkhMZWpsNGpzeVRXZ3pONmRIYUdtRmhBUWNP?=
 =?utf-8?B?Nk5aREQ2MUQ2K1FpNVdHTVl3dVBlcVkyRklId0RrWm82VWJ4NU9jV01LekZD?=
 =?utf-8?B?Ry9TSWdmQktISldPNDF0SmpIWVFaNnF6bm1NUWdteEFxK1JBb1N3eCtHY3cv?=
 =?utf-8?B?V1ZHbFlpSWJ1eTJUMzRVbG8rTmlLajZZZlkxTXFpUC96cFFCWlE5YnhvcXh5?=
 =?utf-8?B?dTJJY2JteTJmYzRsblUxbyt3bWlGWS9NYnNNNFBySm5kODdUWnZVamF0SHpU?=
 =?utf-8?B?aFpDS0RNeVdDQlJPVjZVTmg4K29CMWtSRFJTcGdDdXVOdGF5dXpuZ2ZDVjM5?=
 =?utf-8?B?WmRhaVFLazVLOTZldEd5TXBleW9QTFA0TUt0K0pJM2JtdzR5SXdMVnJ4NmV2?=
 =?utf-8?B?NVNhcDhYMENSd0FtRUVGQ1Zxc0F5QzYwQU1qbWhtK3MzNWVBcjA1MlNOMENN?=
 =?utf-8?B?QXFrK3pkMDQzM1Y2ekI3RjdRZ1E4NlhpTlhvTnRLNnl3VFNHZHNMOFBrV25p?=
 =?utf-8?B?Uk1zM2pyWG9QSFcvWUpMV2J3WERMQnRSUjI1cENXZzRPYW01UE5JcWkySkYr?=
 =?utf-8?B?NVBuYmhWdEVMVFlSZnR4RXlvcVZZT1grVTlzNndRN0lBaUt0N3lyYWhndGVa?=
 =?utf-8?B?NEhUS3ZWeldzaXVVR296RTlSY0FLQnVOOEFxR2ZscGpHcUNvSmxGSmF4bGR6?=
 =?utf-8?B?bE9KVFdIbWQrcHNMcFRaZU9TQ0VqMVhxcGkrY2JlQ21jUnQ5MnIyRlNjdUVZ?=
 =?utf-8?B?ZTdwQ3hNNUh6MGcvb3NtT0FPeTNSWkNjMHpEY0xXTUpSNERxOWNWVGF6M0VX?=
 =?utf-8?B?U05WZ1NHTzNJN3JUc2dHZ2Z5VFdXeUk2TS9Xdmovb2cwUkRRZUdlcFhVM2dE?=
 =?utf-8?B?ZTJGZWpzbE54SFZ2VUsxNmFUVjNNdGYyWGxkNk1yM1o2TElzSmN2bldKbFF1?=
 =?utf-8?B?ZGdjTm5pYk5kMnV1ZVBGUFM0dkV3bEJaenBiT2EweUtlZUxoKzFBb2pyMjBU?=
 =?utf-8?B?RFlSb3FmM1JTNE9zMjdYTUZPWXIvQ2ZITTVsYWRzeUY4SEVpNGFFTzBtcnZ1?=
 =?utf-8?B?UkZzWUh5VGt1MTd0UGw5em1EWXd6aFJlR0RmenB6eWJUR3V1VDBRRTRPK2tS?=
 =?utf-8?B?Q0E5K1lDVHJQL1l2d053V1Zub2ROWTNOT2pPSWpBZngxeG4zbjZzYUtzZ1FS?=
 =?utf-8?B?TitBNGxPSGxINEtWWURObkpDUE80SzB2bXpvbjJMa0JXbU5HV3RPUmVPUVd3?=
 =?utf-8?B?bk5GU0tjUlZvdUZFUjVLWmxRc2p1dWcvYlNHZkI3NFUzYXk1WE5YaEIxbnEz?=
 =?utf-8?B?bDcyOWxTMDJhMGFEMHR4SWk4b3ZFR0c3WWVSaTJTMy9RSjVoeWIxdldKaGkz?=
 =?utf-8?B?TVpSazBsdmdMN1pXTTZXYy9HajVtb3piTEtvaE1hSnZlSDdjQ09uWm5zc0tE?=
 =?utf-8?B?N09UcGdFMGp6SFpOdW1ZMHhjNy9uUXNDQkc1Ym9BQ2xSN3ZnVC91SnZEcENx?=
 =?utf-8?B?UFNoQ21naGk2amowOHk2aU9kRXhGZ1VzK2I3WndiNERwWWkwaWRYcnNDQmhY?=
 =?utf-8?B?N3BTWFR3MW92bTArSWxXS1BWcXZlNWtVQUlmeTJZZDh0MkZyWDRsZjV0bXV6?=
 =?utf-8?B?S1ZOQmVRMHd3Y0dTT21wRnZpMm9wUFJQU2RaSkpxenZkem80RDQrRkNsS0x2?=
 =?utf-8?B?N0VSUnE3VCtrRlYwWHJ3dlJTc0RRUUgwaEk1VzNCQWhmWFRZaWl0bERnd01G?=
 =?utf-8?B?c1o0Tm1lTXB0L2FiZ0RMOXhSb1c0ODJUL3hvWlVCbUxsN1hMNzRYNGJHK2h6?=
 =?utf-8?B?SmJDQlh2b1dlS3E5VjBycGtpQkl2eDV6QWQvcFV3Z2xqc3lTS25vbThTN2h3?=
 =?utf-8?B?OEE4T0pmRFVCeHRpY2tWZmNkc0ViaEVic0RTZVlubFlIT0VDcXpKWUlqNG9r?=
 =?utf-8?Q?UvxzzwcjU3D40K7oKb7rv0A=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SLvG+8/W2KGIf5mII30D+0kpb/hWWeVcnw1+XgoxHA4ftxsyhXku6TsHBQBD0fMbia5gtFsrT2nM+QplWVz/70zUo7smlnIbQuUQhdupr/2lyJo3Nm2oaCPu+9DvejqD+WRrUSx3I9qYAVj0cusoImt1dFYpJOFjttCylslQOik1ELGZBo+evT6c9VEn38gcpUqAER3M3qlkHFkkX0d0wuZpY0FDs/vFETLYjVeBdx3dudEJZxzcFq8ZST0qDoUgkiWxmKK1CzU+Z6JrrcnwVoCID0FoybBqmWNwdXmY0Vb3jJ5e3b5HV2U/PAa/JvLaUPHaoMc71U+0Emf1wlO30aPHLzmmnXNM5eunbU6Gv1pe1uE7vZQPKkvdkMUVS0vDXwwLC4W1PBKX3QSsoCJ2tSkxEHIWlcIFyN3qobIdcvawE7/ShPGZnVD/1aMexGSrFlGJx7jjg2HSJ/uoUgm5VfPrJYS4JEzDvaMgGA7X5qD9qWwbPGEz3d6gZ3sj3t6HEUnXRdPaEkB1wv0w9pGgFn3xTeoq9C1C8LkNgfkgMTPoKGH/PpBslg7nyb9vLnES7MYvk92wQNyVXr9DrxJaxl126w6u7rG0f93iaACtf+I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e216ba4-239f-4b47-d729-08dcb204ef0c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 08:35:44.2152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jDNGxUPYpKSsFmVlMqRMk3aRRmZLptLa/rT2cl6UB8GWHMdXsGOtegm0nqTc4jgrtVx52vIjK/tjT3MK+XSRzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7405
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_05,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408010051
X-Proofpoint-GUID: jVE0hbiNzrGz9wKSepZJM7wUWNd2ZYB1
X-Proofpoint-ORIG-GUID: jVE0hbiNzrGz9wKSepZJM7wUWNd2ZYB1

On 31/07/2024 11:38, Alexis Lothoré (eBPF Foundation) wrote:
> test_skb_cgroup_id_kern.c is currently involved in a manual test. In its
> current form, it can not be used with the auto-generated skeleton APIs,
> because the section name is not valid to allow libbpf to deduce the program
> type.
> 
> Update section name to allow skeleton APIs usage. Also rename the program
> name to make it shorter and more straighforward regarding the API it is
> testing. While doing so, make sure that test_skb_cgroup_id.sh passes to get
> a working reference before converting it to test_progs
> - update the obj name
> - fix loading issue (verifier rejecting the program when loaded through tc,
>   because of map not found), by preloading the whole obj with bpftool
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  .../progs/{test_skb_cgroup_id_kern.c => cgroup_ancestor.c}   |  2 +-
>  tools/testing/selftests/bpf/test_skb_cgroup_id.sh            | 12 ++++++++----
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/test_skb_cgroup_id_kern.c b/tools/testing/selftests/bpf/progs/cgroup_ancestor.c
> similarity index 97%
> rename from tools/testing/selftests/bpf/progs/test_skb_cgroup_id_kern.c
> rename to tools/testing/selftests/bpf/progs/cgroup_ancestor.c
> index 37aacc66cd68..4879645f5827 100644
> --- a/tools/testing/selftests/bpf/progs/test_skb_cgroup_id_kern.c
> +++ b/tools/testing/selftests/bpf/progs/cgroup_ancestor.c
> @@ -28,7 +28,7 @@ static __always_inline void log_nth_level(struct __sk_buff *skb, __u32 level)
>  	bpf_map_update_elem(&cgroup_ids, &level, &id, 0);
>  }
>  
> -SEC("cgroup_id_logger")
> +SEC("tc")
>  int log_cgroup_id(struct __sk_buff *skb)
>  {
>  	/* Loop unroll can't be used here due to [1]. Unrolling manually.
> diff --git a/tools/testing/selftests/bpf/test_skb_cgroup_id.sh b/tools/testing/selftests/bpf/test_skb_cgroup_id.sh
> index 515c2eafc97f..d7dad49175c2 100755
> --- a/tools/testing/selftests/bpf/test_skb_cgroup_id.sh
> +++ b/tools/testing/selftests/bpf/test_skb_cgroup_id.sh
> @@ -30,8 +30,10 @@ setup()
>  	wait_for_ip
>  
>  	tc qdisc add dev ${TEST_IF} clsact
> -	tc filter add dev ${TEST_IF} egress bpf obj ${BPF_PROG_OBJ} \
> -		sec ${BPF_PROG_SECTION} da
> +	mkdir -p /sys/fs/bpf/${BPF_PROG_PIN}
> +	bpftool prog loadall ${BPF_PROG_OBJ} /sys/fs/bpf/${BPF_PROG_PIN} type tc
> +	tc filter add dev ${TEST_IF} egress bpf da object-pinned \
> +		/sys/fs/bpf/${BPF_PROG_PIN}/${BPF_PROG_NAME}
>

Just out of curiosity; did you find that the pin is needed? I would have
thought tc attach would be enough to keep the program aroud.

>  	BPF_PROG_ID=$(tc filter show dev ${TEST_IF} egress | \
>  			awk '/ id / {sub(/.* id /, "", $0); print($1)}')
> @@ -41,6 +43,7 @@ cleanup()
>  {
>  	ip link del ${TEST_IF} 2>/dev/null || :
>  	ip link del ${TEST_IF_PEER} 2>/dev/null || :
> +	rm -rf /sys/fs/bpf/${BPF_PROG_PIN}
>  }
>  
>  main()
> @@ -54,8 +57,9 @@ DIR=$(dirname $0)
>  TEST_IF="test_cgid_1"
>  TEST_IF_PEER="test_cgid_2"
>  MAX_PING_TRIES=5
> -BPF_PROG_OBJ="${DIR}/test_skb_cgroup_id_kern.bpf.o"
> -BPF_PROG_SECTION="cgroup_id_logger"
> +BPF_PROG_PIN="cgroup_ancestor"
> +BPF_PROG_OBJ="${DIR}/${BPF_PROG_PIN}.bpf.o"
> +BPF_PROG_NAME="log_cgroup_id"
>  BPF_PROG_ID=0
>  PROG="${DIR}/test_skb_cgroup_id_user"
>  type ping6 >/dev/null 2>&1 && PING6="ping6" || PING6="ping -6"
> 

