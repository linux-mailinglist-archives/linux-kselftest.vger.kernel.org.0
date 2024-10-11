Return-Path: <linux-kselftest+bounces-19515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469F2999C60
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 07:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24748B2126A
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 05:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879BE1F942E;
	Fri, 11 Oct 2024 05:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dzlETznh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bs4ou/Kt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56034219FF;
	Fri, 11 Oct 2024 05:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728626341; cv=fail; b=Zog/pmF5nRGVIRlVUFO3j4lXBs/E/AI5Xw5g89vtdoTBN7Y2u0YutLjPFBp5RaBjeoxFF4NliZTP9zs6KVtzOgUM9rxTr9nox5l/lWMXuiBaatxbce6jq/SdMXMdPL5jONlQUhUbGHpmAUdmXQWp6E4j71En1E0XdSfBIjCWHm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728626341; c=relaxed/simple;
	bh=cQj66jNlwhqMmdO1k2eEJ0nA5rRcIH6rDd68zjEye+I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o6gXhTixaFbIW4ImOUWp9XFvz3Xr9FY4iV/n9nqNGCk+P9uDqrNB4Er8XwHnvY5Fr84fBrHUx8aDf4zuD9wYBAe5Vbp9d73STNjdzSbuBft0Cd+I5UKuQ5VunpkEJ1sjhnb9xlcEJz9IaXMjxMEo3WkV5tqqdzGUHwC8gBic2ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dzlETznh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bs4ou/Kt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49B5MfmW008495;
	Fri, 11 Oct 2024 05:58:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=cQj66jNlwhqMmdO1k2eEJ0nA5rRcIH6rDd68zjEye+I=; b=
	dzlETznhsa8WeLiB4JjYya18LBk6yHMynwhYaN04uxdN8eU7Zr9cWgtioSTwIWz5
	GszgORFr80KVl4g+SZWlZYfGXWEdHRib0Zct65Nn3JEZRokv9QYl2XxaK/V4MMjh
	dEdIPEXzxetl7ne8oNEIkV8wFSE/RRwk2ws3LRJUsuk4WEnOHzywsLZ5T4UBS8pW
	itYnk66SoC/n9H8FCTywfDGgzgWnDv8FIBDVK6rM7O/OpL6beaXk/r04eyrsw7ck
	d/MOvtrLNgB8HjtF75yu2K/CY+kmaTCEPLMa25buyIcaT7k7XXCjVVDvcyETgqyf
	wewUw5RRFeAj0K4USc8jOA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423063v701-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 05:58:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49B3HAfK017499;
	Fri, 11 Oct 2024 05:58:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwb1h6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 05:58:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYUHj22dn6RG2BrAkBiZIbCJ5FYaXiKoYXlZX/RhAE7Jr94gqv/PcweNIWH5YMBvhU0Ql7ZakpWl/D6AQUt+m8e9o4YL06lVr45flPQp/91LueO64OfJaRq/x47c+ViUuAIY+z8k866V/OLL2QM61iR5lgAMksR8XCDcwrd4IR5JvJ5E5x/dT3WgRegzz9B1XdwUiygW/xnIyOfyU0k6eSLG8DNpY8lNCDYxyQuxgAsjQEGFV2EXWYMGOxYxqfLG0AdoG3ojwRBCJJoOH0U1lzNIWlkwqPYBanBUbFYNLTU10XU5/88YaC0yZugM9XEaWQV0lwwcnPOmJLkubqSB5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQj66jNlwhqMmdO1k2eEJ0nA5rRcIH6rDd68zjEye+I=;
 b=x+0KEK6V0tXGuyW6SCvg9G9hGRkG3f//dDyYK8o31AvsskPNXTpz6qEkE7lV+fq+4Yhv5K0fpbyISwIDF6MkES4F5cQ4n38DZoM/Z0LqF95rOy7YhG0unr8d/irM4Nujky6iRcfE2Le+emIlopAqCa/QFH3b/xrsaWwbxxIcexbMwDbWCED+dK4hyKkwFfTWQhoQQXYdcYNetkfeaeKq/5TJ71ec7lwORu7t8t2VKzzjCahz9CPSvlug7CY4Z3lnUGhMEHGUjMyj4wiHzEOkNRlaj0MfWMxHtVvTIsxcQq1FQ08G6onPHAQ8f6zBl8dmARL7ZwrHDnktIlyLcoxQMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQj66jNlwhqMmdO1k2eEJ0nA5rRcIH6rDd68zjEye+I=;
 b=bs4ou/KtGjwEZrNGk5JeVJvDWelGzaxGdtMmxmNrSYKbb6UkbQPLRM9B+q6XrGkLLrYlWVHQMuMU5/HxqqbVwbgRZZrOSAZYYz28LAmTKaRryG39nxBt8d0G7w85iAlnFJggGdbIzxn7XloDVJtbw4gYln+ihb0zcuDbDtNXF88=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by IA1PR10MB7262.namprd10.prod.outlook.com (2603:10b6:208:3f8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 05:58:44 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%7]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 05:58:44 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "shuah@kernel.org" <shuah@kernel.org>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "alessandro.zanni87@gmail.com"
	<alessandro.zanni87@gmail.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "anupnewsmail@gmail.com" <anupnewsmail@gmail.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>,
        "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2] selftests: net/rds: add module not found
Thread-Topic: [PATCH v2] selftests: net/rds: add module not found
Thread-Index: AQHbG0zXRN8KAiBV1EaFOyLushIv+rKBDqYA
Date: Fri, 11 Oct 2024 05:58:44 +0000
Message-ID: <53ab195125ebacfd182d004a5913e0da070c5984.camel@oracle.com>
References: <20241010194421.48198-1-alessandro.zanni87@gmail.com>
In-Reply-To: <20241010194421.48198-1-alessandro.zanni87@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|IA1PR10MB7262:EE_
x-ms-office365-filtering-correlation-id: 8dcda50d-bf01-4cb5-e020-08dce9b9c40b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cDdIZGZtNlcycEIxV1VtWDBOenQ4cGo4MktDcmVXTzBXQVdUbUsxVkQrSFB0?=
 =?utf-8?B?M1g0WUVISXBsbW5CTVZVMmVzejZJaVNzZEhyVDduR0R2NUcrTy9TQUJsMnJ3?=
 =?utf-8?B?RzFsUHRnMXpQM1ZTVzd2R1QwTm5vOGVVKzFNVndUdmdOclI2UTlKK1hLVmFP?=
 =?utf-8?B?L1ovTStvRlFjbkNNa2dya0E5TUFJNEUrcDFOaEhYV0RnbVVjaFNRcDJYa3hX?=
 =?utf-8?B?ekZPc1kxaWVzU1YwN2VHZ1FzcDBVdGpka0Z6M29uZmdHQ2ErREQzUDQ2dHFa?=
 =?utf-8?B?cHRZajZxcHNOTG9xZ1gyWFFyZFdScm91SzFZRGVxNUlBcVFOa2lETW9SL1ha?=
 =?utf-8?B?MWdJdlB3Smc1UDVwOCtEMXh0NmFSMmhubGwveGtYMnAvU0FSeDRXWXNKR05E?=
 =?utf-8?B?VWQ4SmhQQWIwdXI3MVhnWTEyZTdNNmVJalJMZTJ3SUQwRWtZZndjeGNkS2lT?=
 =?utf-8?B?cDJhdlg5MFZSM2JzQkZycjVLSDBEc3llcHVGdWhuemVjWDZRQVFwckh6bmEx?=
 =?utf-8?B?SDFWQU1Sb2ZienREOXV3eHdmdzhWMDBwdEtxSUxuS1ZaY0tUTk5KLzZ3bFEv?=
 =?utf-8?B?dmdCLzBMOGNNMGtBVFg5ZzNpMjd0MlJXOUR3VEd6SEx0ZEh0UW9tdTNZNlRn?=
 =?utf-8?B?RWFFYmFzeGRNV3hhTjllUUlJS1FRLzAxSUJjRERETVBrcklrMGtMdGswL1d5?=
 =?utf-8?B?bjdoS3VMWFZqTHpaWkdPNU40VEdsMHlvM1UyZC9OUjYyVWtsUDdiSWxTeDIv?=
 =?utf-8?B?Tks0ZUlzSkIzUnFSd3VSWmIvbzZ1NG53MmlyYVV3Si9kWmNzZDNRRlFtemh0?=
 =?utf-8?B?VVdLRzgzL2JHZjlFM0hWTzI0OW0zMVV0dmY5dWE4UnZKZTJ0UTNGL1A2Q0Q1?=
 =?utf-8?B?TXYwc3NPcmsxUllRaVpucTNuaWw3TG9lTFpKN2xlSENTRFhkTG1wa0RFY1lB?=
 =?utf-8?B?dm1TdC9ya0F0dkMvbWhMU212anVnUXlrbEpaN2RjZDVMZ2VUNnJPQ3NBd3ZN?=
 =?utf-8?B?Mi9VaEhHMnI0WjI5eHUyU1ViekdLMmVSK01Zb2E1T1MwOUthbGR0TCtBbVF2?=
 =?utf-8?B?SHFXcElzWml6aWxoakpQeFo2RXJsU2VDSWswM1o0bExmVG5TdXlndnViMFcy?=
 =?utf-8?B?MGRORXorNlF4cG5TRnp5cnJPbnRjNVZaRXo0eG1TdmEzb0djYjJoVkdDWWRU?=
 =?utf-8?B?MFA5SVQxOFZLbWUza0hCdVNkVm1DS3JVVE9yUDQ1OTM5Z3lacXdFRTZNdjF1?=
 =?utf-8?B?TWxpM1EzM091Und1cU43aWM2SjJPOU9XZnliUDFTNHZ2ZEVDUXZwNVFzWE9I?=
 =?utf-8?B?dUFYYTNhTTYvdXdldkJaS1RaeDVRSjArdzVLN3ZJWGhab2dEekRqc0dVdlpj?=
 =?utf-8?B?cC9uL3lPYTdzT3hZTFdhOW5Xc0MvM0hZWkNGMVdMQXRTSnJEWm81SDJCclhW?=
 =?utf-8?B?cnFhVmcyZFZxNzhFQjd6Z0pTc081aUdJNDE1ODBBMStVYndrSURud3JKeEkv?=
 =?utf-8?B?ZUlSS3haUHdBbXVjQ2NnVyt2K1VaeUFUQkVNZzdUODhQa1phdGZENXFMU2o1?=
 =?utf-8?B?QnN4a2tQaTd5Zm1yQ1V3MWVUWWxrWUZJMjRjMDJqV0lIZW5TVUxpSnR3TDhm?=
 =?utf-8?B?NXQwcDF3bys2UFJsNEFzS1BuNlloQjR1bDJsVmduNlRLOHJVcFZKODdWMjdM?=
 =?utf-8?B?VTY2OWpESk41WHg5VzBKV1hWeDBmZW1NNjIxaXlKa3ZjdFV1cVBjT3NTWmNW?=
 =?utf-8?B?VFJUOVFpajcyNk5qMUZmYThEZzJ5dnE1aGZjVGxDb3FXUW4wRHZrK1NLYkQy?=
 =?utf-8?B?Vm1MMUNnOEZ1NHRqNFlsdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OXExc3g4a2t6Y0czY0I4S2R1S1VZUWw0UEpOaDBQOXQvczBsVUVhUXl4Mmsv?=
 =?utf-8?B?cGpGMlAxRU95Tk80Z2F2bHcwbVZmM2tCR2RxMUo0K1dJUEJyU0FIa0xIcE9r?=
 =?utf-8?B?YlRsWlhuZEN5b2VzSFFJak4wUVpMdDB4bll6UE9lcUxuTXZ5b29rdjVMT1p4?=
 =?utf-8?B?Mk80T0FKRjRrZ2UwWFdXSnJzVGtqeXNNd1BqOTNyVVErdWxWeHpQd3AyWEJz?=
 =?utf-8?B?eGZjNUt6czR0cFZxTjJmWlF0bFFtRDBFY1JkUmlmYTcxMm1aWUEzUjErNlND?=
 =?utf-8?B?TUswMmpEUmdmc281MUNMN0xZWVVTMnBOVXdhMTRWMW1sMVlJV09ZS3JvUnBp?=
 =?utf-8?B?QlRERjhqL3BHUHRDcWFFdE5YclRXRmxqRFFoNjA3QjlBa3VEbHRaNm8rY09P?=
 =?utf-8?B?cFJ4N2dhd0JZSFF2TmVrSzBKdHlGRzA0NXRZVnRjT0UrT2w4czNlT2Zxc080?=
 =?utf-8?B?MUVjV0YwZHI2bzdmR21OcEdIbVp4ZGNzSUhMYVNmTzcvSkVUYTFxMFJmR2Vu?=
 =?utf-8?B?aWhSL2ExSW1iVHk0WWQ4MjBud1dyMU80cW1zZW5GWEZWU01lVUhtRm41MTNT?=
 =?utf-8?B?U3RjRHFMZ3J6bmJpQUNzT1NZOUZBeEdsdnN0SWx4cWVCOEVqeGtWT2RhYTAx?=
 =?utf-8?B?a1hkYXZDU1ZDTEFmSHpaMmVCUG5aaEhvUUJoYUFzS2UrSHJnc2JnRTFrTXF1?=
 =?utf-8?B?VE80RXRQQU4xQnE3Rlp4KytvK0FoN1NXM01iT3dXZFFmL1lFWjdFUHVhLzlm?=
 =?utf-8?B?VWYva1ZGRnNDcGgzMWJCalA1a01QZWRRRmhVWm9XOXl0NzA4K0RVa1JUOTF1?=
 =?utf-8?B?eWV4TUpjZk9MUXFhWUJXeGtYTkg3eUhkeEhwdDAzK01EbTRBbG5vUmk3RkRC?=
 =?utf-8?B?ZHo3WmdDTFk0NlU3S1NqdGJaMWFmemNVdlY5cVpRNGZLWFVyVE1jQkVyTXJH?=
 =?utf-8?B?dW9GaFVHSDdGTGd1ZnVNR1Bna3dJSFY2UnE2TVB5U25sd3V6ZnNTNHpyNis2?=
 =?utf-8?B?V2xPTU5MS1RqOU9EWkEydlA3MzEvU0lQQlBSSXBBSVdURmRXcXEzU3YyWEx6?=
 =?utf-8?B?VTRqTnUrQVZBRVAxVm9mWVRlbzB1U01taUEyZTJVZ3BGSmxBSjBoaUQ1elhU?=
 =?utf-8?B?MjNadUVzM25rMUFiMFNPaHVRZU14VkVUMkFaQ1JQN3RxckZzZGdIMWdjbkFa?=
 =?utf-8?B?Q1NoaFk5M3ZyU0xSTDFXcGZ1eHBDc1YzSU1obU5mOGRSWldQa1FhK1BXeXVq?=
 =?utf-8?B?bEt1azIwWExWekhmOGdEZEtwVTFmSnA4VDZmRUZHVFdkQW0yZmZGRmM5OFNO?=
 =?utf-8?B?WGh6d3FpaEJHWi9vaWlDanRuV0xiMFNBdUJGOWVJWERPVVhUMHZvVlpOY2xz?=
 =?utf-8?B?RnhmVitKUkZxM05qZlZlSlZTc1BoVkExNmpqUmxXK1JqWnNYU2ZDVlpLM3A2?=
 =?utf-8?B?SW1LcVRWM1VqaG9yOHl4VjNiWDVwQ2dJTUNqNVBFeXFZcXdLb2JQM3l6aTVE?=
 =?utf-8?B?cU05REg1bExTeFJOdVp4Sk1iY21Gd0Z3SWo3d0cyNmNTWmRaUXZ6N0w4NVF3?=
 =?utf-8?B?djVGbU9KSFdUSDFhR1QrSnJDdkZWU0l1aFlmU2xWZkV1VG1xWThXODdIdHow?=
 =?utf-8?B?aXhMRndVMUtBTkdHMVk4VmJlOU9teGs1dmNaSnE1RW1uUk0xSmdqeldzcjdY?=
 =?utf-8?B?Vm9Ub25hOWIvRnZFUlIrQVVqZkRoRDJFbkhWWk5iSnp1TE43bUlQSFJ0VSt5?=
 =?utf-8?B?UVFvWXJpUTJJS3BxRUhQR3paakJKTThUa1VLVTdCdVZmejFVdi9zTXd0MlN3?=
 =?utf-8?B?Qkg2ZW1pQ2dFUFZNUS96Q2R0ek1MclJZcUJDdVU2WHZBRFZvRUU3YkV0bFZO?=
 =?utf-8?B?VGtkcW1NN3UrejJHNmpXanM0R1J1TFVndVBHNm56SmJYSDZsQkJ0ZDdjTEpQ?=
 =?utf-8?B?djdDN2tFS21yRG5xbVJySUduaDNGbHAzRkZIQTBnaDNGUUtwWGlGSnVRUXp3?=
 =?utf-8?B?MkcwazJ1WVhQUVI1bUVVcDRTTTlkZy9pY000bmZHQnRMMXRFN0d2Y3M2c21l?=
 =?utf-8?B?c2JkYWVEeGovcDRNdXQrd2Z0L0h2NjM2ZERDOWhRSkhlYnFkampBVzd1Z05J?=
 =?utf-8?B?WlRXSVpadUFxcmpJMDFpTjdObktxU2EwL0FaNjB3QVlJNGxDbFdSOEo0TmZZ?=
 =?utf-8?B?aHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20E1121E0D5AD240BE0328DB4F9D085E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	24mVVOQWqeNafFptdUZ/v3Au0104MbVA+pdZHEbJ4Yet22J8KakBnNALstQ6hOL9AKDTOIECsAGydfJ0T2mzZi1MgB9ha/5B0VWrdyV3GkYpa3xeAx315edBb1TSUBb5g6d1QDc8hY36o6f8BPFeBykmURaIZhEkX4I7dW01EU7Lt9nV4mPUmzOAfQ4qQiTSE5TmD5ARsI0GZ0fMqNydxiIEyvcMbR8OSsYApWxrWjjVLw7c4gLz4DSD1oVhketDNRMSrhvfh+BzvhyeZ/Mz9TxVu9beUCBJ+KUKxVJC8pUnDR4vM882of7Smqpyj/ohXaXl/RL+dhPs8ZYSnsrhuwCOz/6H5t8DKXeeeThykaMeUWPXmucUDSKR9XJD4tJWjQe2jBbxLhyyCvyimL+aiW0qSSmsrCbbDTTyQu/RWmomekW4sGZC941FYzMxPY8JXbidVXdKMXQWCJLWege1SCkRO3nnH+V6RffMa/DX1LsM2yD6II/QGgAahUd6mqOnzELcKeKh/owc5eZNgh+IoyfldpnX8Hs964QWdaDNyB4uDQJYrj569XRLC6wnQ3WVn4/tuMNqolHyUJr8P/wCgjyeTT9FnWa4sV8X6vpEWFk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dcda50d-bf01-4cb5-e020-08dce9b9c40b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 05:58:44.6819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OL+mo/pkx0DLOLwYRpGQFgfDEgW+1haptw57iuJZjHpnlBcw6A6NWL2fI2WIbNqY17/+y33ZtTEtd05madZT/XKVRxxpSYA4E8CSXdItmIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7262
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_02,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410110037
X-Proofpoint-ORIG-GUID: suSP7to17219TxQ2GdPc1zUus_YKcHpJ
X-Proofpoint-GUID: suSP7to17219TxQ2GdPc1zUus_YKcHpJ

T24gVGh1LCAyMDI0LTEwLTEwIGF0IDIxOjQ0ICswMjAwLCBBbGVzc2FuZHJvIFphbm5pIHdyb3Rl
Og0KPiBUaGlzIGZpeCBzb2x2ZXMgdGhpcyBlcnJvciwgd2hlbiBjYWxsaW5nIGtzZWxmdGVzdCB3
aXRoIHRhcmdldHMNCj4gIm5ldC9yZHMiOg0KPiANCj4gVGhlIGVycm9yIHdhcyBmb3VuZCBieSBy
dW5uaW5nIHRlc3RzIG1hbnVhbGx5IHdpdGggdGhlIGNvbW1hbmQ6DQo+IG1ha2Uga3NlbGZ0ZXN0
IFRBUkdFVFM9Im5ldC9yZHMiDQo+IA0KPiBUaGUgcGF0Y2ggYWxzbyBzcGVjaWZpZXMgdG8gaW1w
b3J0IGlwKCkgZnVuY3Rpb24gZnJvbSB0aGUgdXRpbHMNCj4gbW9kdWxlLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogQWxlc3NhbmRybyBaYW5uaSA8YWxlc3NhbmRyby56YW5uaTg3QGdtYWlsLmNvbT4N
CkkgdGhpbmsgdGhpcyBvbmUgbG9va3Mgb2suICBUaGFua3MgQWxlc3NhbmRybyENCg0KUmV2aWV3
ZWQtYnk6IEFsbGlzb24gSGVuZGVyc29uIDxhbGxpc29uLmhlbmRlcnNvbkBvcmFjbGUuY29tPg0K
PiAtLS0NCj4gDQo+IE5vdGVzOg0KPiDCoMKgwqAgdjI6DQo+IMKgwqDCoMKgwqAgbW9kaWZpZWQg
dGhlIHdheSB0aGUgcGFyZW50IHBhdGggaXMgYWRkZWQNCj4gwqDCoMKgwqDCoCBhZGRlZCB0ZXN0
IHRvIHJlcHJvZHVjZSB0aGUgZXJyb3INCj4gDQo+IMKgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
bmV0L3Jkcy90ZXN0LnB5IHwgNSArKysrLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9uZXQvcmRzL3Rlc3QucHkNCj4gYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQv
cmRzL3Rlc3QucHkNCj4gaW5kZXggZTZiYjEwOWJjZWFkLi40YTcxNzhkMTExOTMgMTAwNzU1DQo+
IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9yZHMvdGVzdC5weQ0KPiArKysgYi90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvcmRzL3Rlc3QucHkNCj4gQEAgLTE0LDggKzE0LDEx
IEBAIGltcG9ydCBzeXMNCj4gwqBpbXBvcnQgYXRleGl0DQo+IMKgZnJvbSBwd2QgaW1wb3J0IGdl
dHB3dWlkDQo+IMKgZnJvbSBvcyBpbXBvcnQgc3RhdA0KPiAtZnJvbSBsaWIucHkgaW1wb3J0IGlw
DQo+IMKgDQo+ICsjIEFsbG93IHV0aWxzIG1vZHVsZSB0byBiZSBpbXBvcnRlZCBmcm9tIGRpZmZl
cmVudCBkaXJlY3RvcnkNCj4gK3RoaXNfZGlyID0gb3MucGF0aC5kaXJuYW1lKG9zLnBhdGgucmVh
bHBhdGgoX19maWxlX18pKQ0KPiArc3lzLnBhdGguYXBwZW5kKG9zLnBhdGguam9pbih0aGlzX2Rp
ciwgIi4uLyIpKQ0KPiArZnJvbSBsaWIucHkudXRpbHMgaW1wb3J0IGlwDQo+IMKgDQo+IMKgbGli
YyA9IGN0eXBlcy5jZGxsLkxvYWRMaWJyYXJ5KCdsaWJjLnNvLjYnKQ0KPiDCoHNldG5zID0gbGli
Yy5zZXRucw0KDQo=

