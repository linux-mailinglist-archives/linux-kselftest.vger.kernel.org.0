Return-Path: <linux-kselftest+bounces-19661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6935099D3F6
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 17:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8177B1C23C0A
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 15:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D06C1AB501;
	Mon, 14 Oct 2024 15:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fMjlWWuD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j0JhGeYt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C336F175B1;
	Mon, 14 Oct 2024 15:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728921250; cv=fail; b=H9rObNDM/kAiJBUHU8khMdh3j3ZtYwVV13QhNkVl1jw4L8d4SwjyhUXCAaDtzr30fSWoj/MAMLx4KzYhlx0JoUqBvWu3+UGW7a2gULPGfvZK6e1SH+UPl/8Hm81o1kduDMNXbXFtFFUEu0zgT+CLJ4rDy8KnfDkGYefg3+8ts+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728921250; c=relaxed/simple;
	bh=Vh+Pc6+x4Qj9jegyMu2gIcYRd3cn56v62cQDtlGlBb0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RjMVj5FQcPiadXnk8jXqtNfUCH7UN+YwJwkm5t8fiWfwNmmix6VDfVVKrubUNsEvt9shtA6mh2YmV4V5aVzPWWAEoQ/uT1oCM67H1g4NJtdCvciJuRtdhWwAmzitn6yIey1SE+RTuEZ+i+CUqmd2Ff7OiHfyCAZUI9uDxFFMWXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fMjlWWuD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j0JhGeYt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EEfhYk019239;
	Mon, 14 Oct 2024 15:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Vh+Pc6+x4Qj9jegyMu2gIcYRd3cn56v62cQDtlGlBb0=; b=
	fMjlWWuDeBBXpQGs1fneeMUKcKFGqbFyWo16zDd3v4R93vz/0DQDjdKS5oOrFt91
	TNp0N9xbyFkxj2TUCtaeWeTiCJIPkvOE51l0HKiLlrj32RRji+0N1XAePzV+EVaR
	DLhccq3leSQrElPmRIB+MFWteHk71FArAmxM0ZKd8OjSexd0XgcEZRvODsu26Jgx
	TE8ymrbK5Vs8MA1K/cpLmYDPDWyPx1ZCsxp7d7O4pEOFWlX936FZxAypv9FrkY1c
	qTJnnFaZiGh+2HY27qQq9Mbw7xHb0qAtiOpkOmg4tAbQcjO2OYLolRh8b9ejD4Ar
	NLaveVm5PfZYXFDsCplyVw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhceb49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 15:52:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49EFPclt013978;
	Mon, 14 Oct 2024 15:52:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj688hj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 15:52:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AeV6OcSfYP2J/j74kCvlPwIE98V5HhGrTYZlaLzuru7hgqDEALkm4roAQAsu4BI2i88t/HcidpjKcQ8h4VR5sa+fQKmjnOUQikUASXYq3C7QvCzlmz5w/CtOOp8InBQSgHnLahgEZ2bUNNow18Frw9AdFNR97vU6ZEe/K0Ypwbl99GU6cPbH0rjK91lR3Zwixb/OcLVGJHPQ/UxDv1XMWrM6L3B3vp4jmYJsuNzgkrGpBaqdchkOPw10LWNY5+fSXNhvd+crpBII/QPkKFlCy1sQ0dxwaEGOPyCMBrnxOpnnEo5IZSkdIQFQ2YiYknK7/3wp2kUUebXUMF7XeDfgjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vh+Pc6+x4Qj9jegyMu2gIcYRd3cn56v62cQDtlGlBb0=;
 b=nDiVILyGcGz3jsYZE/kiQEBgQV2hnr427JVoCotwzPodzVFgFgHkiRB/pBPUrfEW2aYFT6riXK7NZelZ0hENEchuiEklJSztFpzR/a1dtZ1oQrs5X0WehqlqKCqsp5UfS2E0VZUSjr12zcHqDgx/6IvJZbz875j60wzbdDspjFwWFJz+B1eGpBNB4nUEw5SX7KhmxEgU2ZX4LTr8h5+YI/NUeVYJiNYFIpGzgQ14U3GhqprDKXuRbuFm1GwQ5iPyV9zGzBY9IIuew0EFn1QfTd9jQv7M9jID/2nXuru+b0fpfquP7IxJ0Ov4Q3+MCuggkEa570pz/CuTewFqbVsK1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vh+Pc6+x4Qj9jegyMu2gIcYRd3cn56v62cQDtlGlBb0=;
 b=j0JhGeYtQb8nSGaWcTxnu0FZopmRlOXrIIZazyBvqJf4cTxlIKCq6ORlyXmN46iojSI3QBFw4+faTJROwO5RllJP62kCR5QFCWkplWZyGqDk/ppJ0tcl+smPXw3lF3LRKz4h3sZAHRtfWgpMk3HAqU1wjt2CowzcIzd2oZctRnA=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by PH8PR10MB6313.namprd10.prod.outlook.com (2603:10b6:510:1cc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24; Mon, 14 Oct
 2024 15:52:14 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::3c5e:9043:1ca9:4c60]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::3c5e:9043:1ca9:4c60%3]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 15:52:14 +0000
From: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        Liam Howlett
	<liam.howlett@oracle.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com"
	<juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com"
	<dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de"
	<mgorman@suse.de>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Pei Li
	<peili.io@oracle.com>
Subject: Re: [PATCH net-next v1 1/3] connector/cn_proc: Add hash table for
 threads
Thread-Topic: [PATCH net-next v1 1/3] connector/cn_proc: Add hash table for
 threads
Thread-Index: AQHbHZJBt6c/N3nv20mczbrbHivDf7KF6r6AgAAG1oA=
Date: Mon, 14 Oct 2024 15:52:13 +0000
Message-ID: <EE08E47B-ABCD-4C4B-BE5A-5C81740E03FB@oracle.com>
References: <20241013170617.2139204-1-anjali.k.kulkarni@oracle.com>
 <20241013170617.2139204-2-anjali.k.kulkarni@oracle.com>
 <20241014082745.GT17263@noisy.programming.kicks-ass.net>
In-Reply-To: <20241014082745.GT17263@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|PH8PR10MB6313:EE_
x-ms-office365-filtering-correlation-id: 2d05a45a-9195-4725-eb0e-08dcec682c13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?blFmZkJTZDl1clBwdHFGZ3N2YVBURE1jWmpZVG5SSUxnMXQrWlFJNHFMbFVo?=
 =?utf-8?B?RUVDNnFxY0pTekhZb1BVNmY3aDFwZVowa09uQjR2OGMyVGdvSFFGU1dxSEtI?=
 =?utf-8?B?NWdKaTZjS0JDdTZIQlhvSTZIQWM3cHUrMzNzRE1aNUh3ZjdDN0xocm43Vk5p?=
 =?utf-8?B?aDBrRDdlcU5NT0prNXAzTUpIT2dWM0hkdk9lNjZzMVJJM0djc29QTERhbnd3?=
 =?utf-8?B?VDJFZU1rK0FxcytsNEhBNTlhS3NjS1NvNzVCYVpYdmVET1Jpa2tyclFIUGU3?=
 =?utf-8?B?eUJkUkZlY1VxemxUTVo2dWRkMkduRkREY0FaWU52YStFbG1wTXpzSGh5OXJP?=
 =?utf-8?B?TzVTbUpzU2tDSmZCcTUxUkx6Q3pacTI3YWdoVFRnMjkwUElZMnZBS2I2SXlX?=
 =?utf-8?B?L2ZYVFJKL2dsSmEzMGxtelFRMjUwVEJHb2MrV0JWTWozanBZWWhWRU5CQkl4?=
 =?utf-8?B?MzFqYnV2YTVVRzZGemo5bkx2cUFBT0tVajdFVXErclpFV2RNRUQ1TS9zYmww?=
 =?utf-8?B?ODd6OGVTWDg4ek1YV0VSc0hDYkFKY1FHNHd5dWdid0srZ1VGNC9mT2o3THVi?=
 =?utf-8?B?VStiSmpzRThmUnZLK2ZiTzY0eDQrcVpKVW1ibTdHY21SWTY0UG9SaHEzdjk2?=
 =?utf-8?B?L3FodVpLeTM4S1VTK2ZqbndUSzRsOWVldERtcHUvK3czRDR4RlZHdWg3NVI3?=
 =?utf-8?B?YUExa09ySngzVE0yM2RITS9oclN5VWwrL0hGYUJjdWMrSlZPcFA1Sndtek1O?=
 =?utf-8?B?SUk2elprSmhTN1UxWEFSa2lzNWEySVRkYTdScVllQW9DcHVYWVZhbEdjOFBz?=
 =?utf-8?B?cDBPWTNQd3ZFQ0xFQU5OVitpV2NzZzdaUktoeVBmdG9WTUxSQldLR2dKckxh?=
 =?utf-8?B?V3cyeEpwNFJPbWVnUUVSNTFFeG81QWRSeHVXSTlOdE80M1ZFRlJwbXl0dSta?=
 =?utf-8?B?cTlJZkUyTTAwODMxMFZGSGp3YUhWSG1KVU1mNzljQy90dGJtMVNBNmxaOWFS?=
 =?utf-8?B?YStSdWZlcXJ5M2ZhSlJjbDZYWCs5a2dPK0k2YS9YYTkzSVdDRGZzZ3pNcndq?=
 =?utf-8?B?SXFCS1huY2ZITjNtYW1Zay83ZkJ5NEVUSkcwUVhPUUpMeDgrc3pVY0xwalRI?=
 =?utf-8?B?SUh5Zzh6TlZSaS9PeGRMaGFlb3hGS2JNVFk1RU1IeW1OaDBFTUtkOFV1cm5m?=
 =?utf-8?B?QWJ1SU11dEtUZ2t3MmZjOFBUbjZ1TEtXQkRNUkdzOVU1SmJBc2pHLzgydzdF?=
 =?utf-8?B?OW5XWHlTRUNFV2RybW1ndW4yZW5nNkhUMDBwcTM2VnN3MnpGaUxiWWVyYXJM?=
 =?utf-8?B?S0V6Mm1tQks4c0p4Z0Q0UFlvOGJDa1I1YXNXVERUeEZ5a1RnckZ3bjRISFVj?=
 =?utf-8?B?M2lidlUwbUVKRlptemZVZVFkK0NJOUdINWlwRUZBWERoTUJRTWxoNWJMaHVa?=
 =?utf-8?B?ZzJjV0hCMnF4NlJtdnlSM1MxQUM0N3dnWXNVRHVZMVk0bG9UdXVoTkRyeEJs?=
 =?utf-8?B?SFJWNkpDVTZmbE5sU0dUcTBmbTU0Y3o2cmpNeThlQnArYXdlWHZyMHRyUEdY?=
 =?utf-8?B?UzJPa1N0bmc5b1pTU0xaditrSWpGU2NYV3VSMWNoNmZsNlViQ2RDdU1mTVN3?=
 =?utf-8?B?c09Lb2t4Z2ptSlhtTlpEWDY4THBGVmNIcWl1TG5mWUNLQStlNVVPd1RrTGpu?=
 =?utf-8?B?eWtCZkpRbnE1QTRlNHRGK3EyTU8yWTlwQWlUU295aHFpbjJnWVYweVZyek1p?=
 =?utf-8?B?SjFQeXNFVTVSMkJIZjd0RFhWdnBwU1NtcVEweUtCb3BrOFhUeDZyNDJpcjVD?=
 =?utf-8?B?UkY2UUNKejJWd25DbXpEdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cHZGN3dUSEdQME1MMTg3SURRMU9uVENvQWUzQVkxWElsUDc2OTJRYzdKS0dq?=
 =?utf-8?B?RE1VaHBsMXhPWTNkc3FkNmlvV3dtV1J4V2l5ZUxOL1VJK2o0U3FjUGRSay8y?=
 =?utf-8?B?ZWxzQUw3MnVWL0ZWblRCQ2xEWHFrNklGQVl0V0M1R3pJL2lpNk90UG5BcXdk?=
 =?utf-8?B?V21HbUVmTzhwMUVsU3IwSXN5R2dRYTIyK3JMYnFLMDVkQisydmNyTmZEUlVS?=
 =?utf-8?B?VGJWaThGUTdBMnc2Z3Y3YWhTMTZ1SFJpZFRkRzkrRXBzSWZSdmh0K0twTGlp?=
 =?utf-8?B?WWk5VmdZK01uZFErTWxaRDkrU09UZ0VxK2YyZjZscU4rYktvRVBlcXZ1QzZt?=
 =?utf-8?B?cEl2U3J4VjJ2SjUzazVtUjYrcEwyZzN2RFBPRzhhdS80R2NSUFNtN0U5Mk9Z?=
 =?utf-8?B?YkdGMm5vTHVMOHdGNlVtZHU1K1UyVVZUdWZCVldWUjZ5bTQ4U0IrNkFpMTV2?=
 =?utf-8?B?ZEVReTVyTUFuRnU4MUdJMWtDVkt1Q05TWHZLWlJXcDhHcWhyKzN1YWN6em9J?=
 =?utf-8?B?c08xaDdITlg1eUUxSHMzMHRFTFlXN25XcVlCZDVYZnVlT0V3VGFVaUJQemND?=
 =?utf-8?B?RWdiTzNSSG52RVBkQmR0S0NVekNqdWwzUU05bEkwc2JXNk9nSVJzWFFRcTlt?=
 =?utf-8?B?MUFNYjRzem03Sms0aHJoQWpaWUg1R3hRNVM0QW0yTHRXZURBbGQ0WllORjha?=
 =?utf-8?B?ZDhqSlpGallYYnVaTk5pTkp1OVVTWnpHa01Cenk0WUJ3UFVLM0hWNnJ3NFRQ?=
 =?utf-8?B?U2VCa21ET3ozdmtRR3JIc0hZb25ucldGUmpOR3U2YmVobkY2UXdoTHh6Rngz?=
 =?utf-8?B?VTlmU0d4VkdnSzNqUVhyMWdIWHZ1eWI1aE5mUS9udjdFZmtZZFV4OE5FLzFF?=
 =?utf-8?B?aGdyS0hTZlR2TExBT0hUK0QxU2JTT2hFcjY5cWIzc2xJUk9HRVZUbGhsMUJC?=
 =?utf-8?B?cmV3dXNGSUVyb24rU1JQTmxqNDBhaFh3Z2xUZUtacFJxTWd2KzlwS0RYOGtP?=
 =?utf-8?B?RjZaYzhlMnMxSTQvK3ZleDhhYy84Vi9wYzEwMEs1Y0lyanRnaUhRdHY3Z05V?=
 =?utf-8?B?ZW5xVlJYQlRYL25vUlI4d2puWmdzNXJUODllcFM5Tit0d1NibnUxSDNqZVQ3?=
 =?utf-8?B?S1RDSDBYS2RqZWtJTkdGWmZMaEpIMmdJbTlGWGswaTczYk1BZ1ZhdVdpZzI3?=
 =?utf-8?B?eU1mMnlIR2Q1bHRWVHloSXlISUxiRHlqNTR5S2YyUnJBVVRsUTB2Qkp6TTdO?=
 =?utf-8?B?Y2MraHJvempZMmJPanhrYXNEWDBhU1NIaTRLNEhZMWNVR3hMM2t5bnlCMS9W?=
 =?utf-8?B?RUp0MllkREpJd3RLeEh2d1FaTDFtM1pGS3diN2dSZzIvRmljVlFEZ1ExalZw?=
 =?utf-8?B?a0psQ2hvRkV0SHl5ZUpVY3Rydi91bHZPRXhmNk9QbGZDWUVyeHJyK1FWRU1L?=
 =?utf-8?B?bUN0QXBOVWdkTFJjZFU3TUR6c05NMlV0UStrYW1oYUFBS083ek9uMkE5dFN3?=
 =?utf-8?B?a2k2ZU1uL1JSWXRQVWpNeGF6ZGQwVVRWOVZJczBYWWlBUjkvODdlNzNFbU9a?=
 =?utf-8?B?VEkvVVlhMlZJQVdSUDh1L2tYSDVHdjd4b3orUnpwZ1haUWh4VnRCcXJkTDdN?=
 =?utf-8?B?NEVsSks2Mm5qN3NFaVhWVE95Vy91a1RyTkdKZUhQM2xrVFNEMVIzZitBTEFk?=
 =?utf-8?B?K2RxSWdya1ROM0o1ckVmdDhlUnVRRUhqTU9zSVlSZS9JQTMvZTFNeG10T3JN?=
 =?utf-8?B?bTBaTFFJSkVsd0pDWnR2dWFTTDB1Z2plbzZwNEk2UXhQZHU3c2xIejgxUkhG?=
 =?utf-8?B?Tlk3bmF3K2V3USs2WFEzNmY4d3RLMzE4c2VMRWE1Lzh3WlJBK2l0ODhFUXVv?=
 =?utf-8?B?bVZoa2p4MjhkT2R3ckxnZFpzSFRPdnNwT1djaTBnZ3c4V253RngvYVNlUHJ3?=
 =?utf-8?B?QVFhUHJCTkRubkJmYTNKZjZOYjlXZkYvcUcvMldXSFFhakRLRTZnSThDS2kv?=
 =?utf-8?B?eTFpQ1pwZ1h4UU9udit3Qi9wRys3eWI2V244K01zWVdJN3ZIQTFNeGQrOGk1?=
 =?utf-8?B?T1U5L2o3eXAwa2ZCYWY5bkExSkw4SGE2a3AwQlVYWVBNQkhYWVoyby91VnZC?=
 =?utf-8?B?MXpMRW9td3M2YmdLR1BiMEhmTUNaTFhYL2VoZnd4M2pHS1lUU3lqWXVvM1FY?=
 =?utf-8?Q?bxrZBnY2K+iiTYxPXzy5ofhQGqswDMGktqzeq58HnBab?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E69F2D236B5B584082C8C2B6F0284C3F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5lb8wgQGwv/ci0jLmXC3IMwz78JBuPmqnZ4XmkHotLJznvM6zTiCMZsykjDG3Giaiq3Bdl2bzQ1NU89KdbTNya4Q5ud3DKpOQ53/J+sFNxqGkXr8VUXcRYDLeQ+P9VB4i1C+UCm1uC2trJGIrBPf/21cgrFzvi/HiTsiwOsklGPD4gzUmUSlw2El56Oi7EBJ+c7G6zCr5WtxbhkyYuufclPQ7Gekpn4BsuIccOweTQHIalPwVUAu0wl+7Lu9tWsTylwjLH4sN3SrZpt7ECNhFHsRMSPYDw9RrramW105+SYbjUZV4WWIOLP5OxOJqZ0sOzRnr5wW53dO3/nBce8RsAcpdn5o87cb2ABikCVDB5kDFVSVnWPAxExxHErdpMthVJPFxun05X//KAJlc+aqf1uaK6qQa/vJ1EQrCX8k6tr0zqynAfzz/hKacZ2Yk3uIZ/K3jqV2ElA6OvZdWu/pMcWIlU6DjWInc028dJSyZld6oiXwpsDWcpIA/wXE+YpInbjz+QOmSbWCs7pkenaVkOBX53mZQFiLrFnn7BBI8f5MJf2L8pHhvfDz9QIFMD4TByLczhc7oW7fRpycrRAmAgxS4aJ22hlrHqNh98/JYEA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d05a45a-9195-4725-eb0e-08dcec682c13
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 15:52:13.9535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DEqmWWAKuR+doKsm7rbq4Vn9DNWTLOozJmlrlXz5SVg2sns3lJOM4IiTfrtdsDu+aDUAtuK5gpUd3IQanCkSxaA5LXFWleM48V4hhISroS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6313
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_10,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=908 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410140115
X-Proofpoint-GUID: b02doY11kSGhqxpT2FMp2LP_AldeaQSY
X-Proofpoint-ORIG-GUID: b02doY11kSGhqxpT2FMp2LP_AldeaQSY

DQoNCu+7v09uIDEwLzE0LzI0LCAxOjI4IEFNLCAiUGV0ZXIgWmlqbHN0cmEiIDxwZXRlcnpAaW5m
cmFkZWFkLm9yZyA8bWFpbHRvOnBldGVyekBpbmZyYWRlYWQub3JnPj4gd3JvdGU6DQoNCg0KT24g
U3VuLCBPY3QgMTMsIDIwMjQgYXQgMTA6MDY6MTVBTSAtMDcwMCwgQW5qYWxpIEt1bGthcm5pIHdy
b3RlOg0KDQoNCj4gKyBpZiAodW5saWtlbHkodGFzay0+ZmxhZ3MgJiBQRl9FWElUX05PVElGWSkp
IHsNCj4gKyB0YXNrX2xvY2sodGFzayk7DQo+ICsgdGFzay0+ZmxhZ3MgJj0gflBGX0VYSVRfTk9U
SUZZOw0KPiArIHRhc2tfdW5sb2NrKHRhc2spOw0KPiArDQoNCg0KPiBAQCAtNDEzLDYgKzQ0MCwx
NSBAQCBzdGF0aWMgdm9pZCBjbl9wcm9jX21jYXN0X2N0bChzdHJ1Y3QgY25fbXNnICptc2csDQo+
IGlmIChtc2ctPmxlbiA9PSBzaXplb2YoKnBpbnB1dCkpIHsNCj4gcGlucHV0ID0gKHN0cnVjdCBw
cm9jX2lucHV0ICopbXNnLT5kYXRhOw0KPiBtY19vcCA9IHBpbnB1dC0+bWNhc3Rfb3A7DQo+ICsg
aWYgKG1jX29wID09IFBST0NfQ05fTUNBU1RfTk9USUZZKSB7DQo+ICsgcHJfZGVidWcoIiVzOiBS
ZWNlaXZlZCBQUk9DX0NOX01DQVNUX05PVElGWSwgcGlkICVkXG4iLA0KPiArIF9fZnVuY19fLCBj
dXJyZW50LT5waWQpOw0KPiArIHRhc2tfbG9jayhjdXJyZW50KTsNCj4gKyBjdXJyZW50LT5mbGFn
cyB8PSBQRl9FWElUX05PVElGWTsNCj4gKyB0YXNrX3VubG9jayhjdXJyZW50KTsNCj4gKyBlcnIg
PSBjbl9hZGRfZWxlbShwaW5wdXQtPnVleGl0X2NvZGUsIGN1cnJlbnQtPnBpZCk7DQo+ICsgcmV0
dXJuOw0KPiArIH0NCg0KDQpZb3Ugc2VlbSB0byB0aGluayB0aGF0IHRhc2tfbG9jayBwcm90ZWN0
cyB0YXNrLT5mbGFncyA/IFdoeT8NCg0KQU5KQUxJPiBNaXNzZWQgdGhpcyBlYXJsaWVyLCBidXQg
aXQgc2hvdWxkIGFjdHVhbGx5IG5vdCBiZSBuZWVkZWQsIGFzIGJvdGggcGF0aHMgd2hpY2ggbW9k
aWZ5IHRoZSBmbGFncyBhcmUgdmlhIGEgc3lzY2FsbD8gSSB3aWxsIGdvIGFoZWFkIGFuZCByZW1v
dmUgdGhlIGxvY2tpbmcsIGFuZCBzZW5kIG91dCBpbiBteSBuZXh0IHJldmlzaW9uIChpZiBJIG1p
c3NlZCBhbnl0aGluZyBsZXQgbWUga25vdykuIA0KDQoNCg0K

