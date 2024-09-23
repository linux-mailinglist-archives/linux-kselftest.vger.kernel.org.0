Return-Path: <linux-kselftest+bounces-18259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D479B983940
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 23:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58FBF1F218C7
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 21:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E39384A32;
	Mon, 23 Sep 2024 21:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZpSldXIt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="juHA/h0L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4C618027
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 21:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727128457; cv=fail; b=s0OGZzmmTm4Tze9ozYkzpuMrHeZ3QL0YDYcmxADbpt4bC1ZhJwfhyDdbBYWG9qdWlfTRNP43jr9+HWyJG7x48y/b0BeGydqWroUqyBZ49c1WpjrBiFIL4l03G+Z7ThQC8kPcHZde1zZcm4FnmkbZRmRGlgcHqnEbuq65sXClpJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727128457; c=relaxed/simple;
	bh=nxxrK+qAy2FD5imlQAHpflqPWPygVp9fpy3xZnAV9DY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K6SwunzHhVytaXMPdQxRYmn8fj+wj2Cje8maPDHUX4+w4S7+mGCW/g6qEd+KXvQcEwElieUeUwUFl666IpVgpVOvtqfGaSDIEPhJeXyWdjf3gGojoVHsJDk4y88jiQPgFnEXk/Nrmjc+mwFWPrfY7QzZnFaSikdh8DYoUa/ul5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZpSldXIt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=juHA/h0L; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NLsBmb016750;
	Mon, 23 Sep 2024 21:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=nxxrK+qAy2FD5imlQAHpflqPWPygVp9fpy3xZnAV9
	DY=; b=ZpSldXItn0DNR1UXMbmPT2y63eS7pXd1U+HI29i+Fx602gXrAxTTQ2NWh
	ZhkYwYh77sbr2hd07ISkbLP+QGIIEzSz0TqoLKXZl6p1K9bNTTEtZvseoVwbdpkF
	dswIXkeJhfyLR/+u/Pw/NMXTWEud+TAaig+RxGTpazoT0q3hJ9Q85V1KY0W7kewg
	Z39Od8Pk9skiZVdf1lsf5CzOwch4z8ZAJU5k7Z0eGWG2fDa5rCsG01xOTs9akkta
	vStkaK4MUkYA21iBHe80aSRQCW3KFL5mxn/y3WRNThbeWtgC6Eeqjp+rfoX0Od/H
	qD4YsLGis1mR7uCG3shAqa+kCcdew==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sn2cp0qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 21:54:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48NK1FUl038051;
	Mon, 23 Sep 2024 21:53:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41tkc4yu40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 21:53:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fd7giUlJB+VxCEcgrK4UcYXxnvQk/FhFTw0HXjmjYrF+LCpZ6RO0x4Z8qjYtCpWRs2oR4kCIpNZtE/1A87Mnvp4iIde+gsKVzK5Vu3+9ymzEYZEdvjEddNnN8qpOjsds3mbLOs1cYwOORXDhWiR3lYZt3iVwZq7sosw0JSHfK6rP+9WGoGpy6w4N5rQk7FjTuhaih2kOGklhz4xlt91USb1UfYtATnn+A6bmcLssvJH7PZmSUyXdkf8A/P4ateRsOQwFDD/fxx8IJ2/cuPTU6t+wAHJCWLLU7SaELN2CWb98ylGvrDgKIoNYq/XrOeNZQHJUKoc70kVTNwjMPSpF5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxxrK+qAy2FD5imlQAHpflqPWPygVp9fpy3xZnAV9DY=;
 b=EdwzrVCdDjV6bWRfr4RhR1omOFwKQ46z86PezPJD52z6/qUo5EQrSB5cM20MysQNyRbIfCr75t0BkkvFsmCHaY39RM3Z63cVmT/HZ/Jf3NEUnjWis/LL1Q3brQf2yV8+MK4cF3Q5ekOcwLSvFNSGGV+EGhpaYBWsOsFcNgaGCth9A2mlb6tzR7G3craWM8Tr/EHCpyhQz+YvA4l+WGNAjrHKdDbVwdiSuv+KITawWnsfXwOXbJA7/HXCYEyDba+L7cZ+f8o/t5A5twOKXjnscaLgzAtpoKTZeavduGUP+KV9SuPpSL+WQaQCGobGzRz1K8IivKB6pbMN/MEn7W0Ltw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxxrK+qAy2FD5imlQAHpflqPWPygVp9fpy3xZnAV9DY=;
 b=juHA/h0L+tDXYuZByf4mf4kbHn7DW6yB0DQxMqtFMqSnELoFTUdEez5ZzU3bA1/VUxgY2+w31UXrs/N5iNSSSUKmuE5UwBT5BOFdk+Zjf8iqlWM3VRROB4ENdTUrgO6O6uWpjNf+r1bAjMzSt9cz3gQrs2LZjABy+3prnxuWIY4=
Received: from SA1PR10MB7634.namprd10.prod.outlook.com (2603:10b6:806:38a::17)
 by SN7PR10MB6595.namprd10.prod.outlook.com (2603:10b6:806:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.9; Mon, 23 Sep
 2024 21:53:39 +0000
Received: from SA1PR10MB7634.namprd10.prod.outlook.com
 ([fe80::5d7d:6585:d28f:3d9b]) by SA1PR10MB7634.namprd10.prod.outlook.com
 ([fe80::5d7d:6585:d28f:3d9b%5]) with mapi id 15.20.8005.010; Mon, 23 Sep 2024
 21:53:39 +0000
From: Yifei Liu <yifei.l.liu@oracle.com>
To: Shuah Khan <skhan@linuxfoundation.org>
CC: "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        Ramanan Govindarajan
	<ramanan.govindarajan@oracle.com>,
        Sinadin Shan <sinadin.shan@oracle.com>
Subject: Re: [External] : Re: [PATCH v6.11 v5.15 v5.4 v4.19 1/1] selftests:
 breakpoints: use remaining time to check if suspend succeed
Thread-Topic: [External] : Re: [PATCH v6.11 v5.15 v5.4 v4.19 1/1] selftests:
 breakpoints: use remaining time to check if suspend succeed
Thread-Index: AQHbDfnROi+E4QCQzUenn4jAawAnH7Jl2h2AgAAGGwCAAAfZgIAAAgYA
Date: Mon, 23 Sep 2024 21:53:39 +0000
Message-ID: <B82A3AAE-7B08-4431-8237-6725C866EF1C@oracle.com>
References: <20240923204718.1862074-1-yifei.l.liu@oracle.com>
 <0a5b473a-281b-4911-984b-cf456d42a44f@linuxfoundation.org>
 <703DFBEE-D5EA-4798-B3EB-7F1E62533659@oracle.com>
 <5c23ed68-3d4b-4acc-b912-69639efda103@linuxfoundation.org>
In-Reply-To: <5c23ed68-3d4b-4acc-b912-69639efda103@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR10MB7634:EE_|SN7PR10MB6595:EE_
x-ms-office365-filtering-correlation-id: 9c5fdb7e-42b2-471c-567e-08dcdc1a2ec6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aW5EWlZ6R1RaMUFHM0k2UHlxQnhiTlZqbVI3UVV1RS9KeHBQczRvZzNRdFRR?=
 =?utf-8?B?QlJsTDVUWENjMkhsOGRjSWkveUxZOTBLMGc3WlBjaVEwVUxrNXZRZlZUN1kr?=
 =?utf-8?B?MjlHajhEd09EMXFqQlBiN3B1REZadjZzMHo5N0tpSVRPaU1mTVlDcDZtU2N1?=
 =?utf-8?B?Y2U4TGhMSDhkSUhqWVFRU2g1MXRCemV4dDY4NUdtNmJhZXN3WUZKYTJaMG0w?=
 =?utf-8?B?Rk1uUFBsQ2dyUWJQVFFIWFYyMDU4dGN1UlE5TVI3UGJqZjhtcjFMeEIvYmZC?=
 =?utf-8?B?TTlyWkRsTHVmUXd1QS9GR2xLSnpVekVGNmd1c3I3L2Q1VUJvSjQ1cDgvQkQv?=
 =?utf-8?B?L3VETjc1Y2dDVzd1MmVlZlVBM3AxVXBqaFdzOFBmVzI1eFdZSGdJbkpzdk9B?=
 =?utf-8?B?VkJ4VGNoU3l5QWxKQ1N4WXd4TWxObEJLNk96Wk1aMlhXVWRGMVlpMTN3ZTh0?=
 =?utf-8?B?VkVTTnFoYXlOdVJFSmkxMUg2SzltcWIwRzJ6RUhYdHI4Q2t2Z1U0dzhwVnFz?=
 =?utf-8?B?QVM1anl4dWhmWkQ5bWQ3K1VkWlcycFRHNTN2b1VMZGRXU2xmZzBDcDh6cWtY?=
 =?utf-8?B?eHBpOCsvSWRaSWtBWEZVSThMcE9hWVVNV2Y2NlZLNVIyU1hzNjcxd1lZTllU?=
 =?utf-8?B?Um1yWGFiR3FmTjl0WDVhQUQyQVVTSUhiK3NFcnBTRDMyL1dTMThEQ2doMkJh?=
 =?utf-8?B?RncwamlubS9YYVM4TVNGWG5xWUpnbGVncnByQW9XYkozbjVDTUxZcVo1N2RN?=
 =?utf-8?B?L0pQWWhTOTFaUi95UmhORkFYSkFBQ2hYd09tVllVcXBPRXArak5BT1V5NXh3?=
 =?utf-8?B?b1FGaytFWWE5eFNIYk84S1REMVpid0hLTHBoOUNjTDF4NUY1ZEI4MW5lVEhZ?=
 =?utf-8?B?cWhDVGFmVE5SSHVvQ1pZM3lRQ3ozS0FhR1h5Z2Nqd09aL1plUkdvTVpYR3Vs?=
 =?utf-8?B?ejU1WEUyVHR5TjFiYkF0dE9NdHlxUGk1VnVUU211Y1A1a05TcWYyYmxUVnYy?=
 =?utf-8?B?ek5IbG40emJJUG9IeUVoSTRCTEZ0a2tWR0RCdUZYN1B3TXFSQVdENTFONzU0?=
 =?utf-8?B?NnRjUDdsbFdEdFJ5Z2lEblZmZ0tKNGM1OHBFdS80NWM2R2MzYTZYWFo4cHY3?=
 =?utf-8?B?Q3lGSGtOWEcybXFBbklYbzYxQ0pBUGtodm91cGJKZ3lpbk9CR3dJTEFUQ2E1?=
 =?utf-8?B?ekZadGpqZVJLd0F4a3VSV1VRcXhJVGZaV2hwNTVzUVFySllsWGdqcERzQmZK?=
 =?utf-8?B?c3Z6ZzdWZGZrRWlhblZ4M1kwT2R5cUFDUXhNT2d2aDBiME11Ykg2VDdYTTZi?=
 =?utf-8?B?VjRsSm1qdFN3NUR3WW9tV3JncU5FYnZHeVlBeVpEWFA1U1IwYnBhdEZ5dlRj?=
 =?utf-8?B?M2czMTQ4NmlBS2dDL043Z1dQaVo5RlRMNlFiQWJSNWJ2S2ttYlZqUFV1M1lw?=
 =?utf-8?B?Z1llVXJXaWJPSlF5am5mcGp1SDdQT3o4OVRQWm1GWmVobk5vSVJtTWZJT01G?=
 =?utf-8?B?OWYxK3VxdGpXUktBQmtHNU0rZTc2dDQxdUxaNzNlbEdwcGVqWDBVVGxtcVJO?=
 =?utf-8?B?ZWRodnJrMVVKR3E0YllleWZaaU5tYlF5a0s1c2FDV3g2WXJDNEFhQVppNnJT?=
 =?utf-8?B?OHVPOUZOUjdhL3hlRmpoODNMc0lZNytQa3JQM2pFRXdQWmE3MU1WdFVyaXUz?=
 =?utf-8?B?K0VzaGxuNmp1eWpJM1BWR2htaEp0ZkQ3dHVKYmJMMnFiZFFXdW9HRTlrY3ow?=
 =?utf-8?B?dDBlVi9qTFdQVk4vc3RnMFd1eXBzUjJ5bFdlQVVCeXJNMTVScmVaVGljTlNa?=
 =?utf-8?B?enJpeTYvNmJXZE9SUnFvS3hrZSttaEdMRjIycXd0QWtOVkNPcnpRS2xTMk9x?=
 =?utf-8?B?b2M1Y0FyS25lSGh3NEVaaWRhSGlGUDVlUk94R2VmWjJXaVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB7634.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YkF4M21uK2xqdXFuV01GNlJ4R1ZjZTdiSUd6OGZVMzg1OWppUHFZREtmNk9B?=
 =?utf-8?B?QXlKTFZUV2lpTUw5RFJxL1lXYmhWdzJXczA3dEh5NDdmeERpWkRPVTBMK3dq?=
 =?utf-8?B?cndDcVZpL2QxUUZHcmtJajF6QjNSdkJwVlJnMkZqZGE1aDVvTHV0OWRhR2Vu?=
 =?utf-8?B?ME82V09iZitxOFVxMStTSThtZmpBcGcrb2IzMkdtZ0JidWlNQkVCM2tRNE0r?=
 =?utf-8?B?dWxxRm13MTNGWjYvZUZqMEd0ZTVzU2ozd2N5UnJZK3dPMG03SXBWcXUyc3B3?=
 =?utf-8?B?NGJmZ0xuM0Z0L21NRkZZSGR4YWI4Q1E5WmJnblo0TGdCV01xSTAzK1BNSE1R?=
 =?utf-8?B?MmZMK3Q5VEYxVlI3MjdtQlN5bDJla3ZXbit1SkZiZnlkZ3ZDTGR1OFU0OVZz?=
 =?utf-8?B?VzNXbGhSQXlQOW5hUTRiNmpmYUhMaDE0V25Ba2IrTENtZWx5L2ZqZmhwTnF3?=
 =?utf-8?B?K3pMbXpJV1AydDVNcUt3OUJaSG14RUNia0pXdVRnTmdDYWF5M3dBanVPdWpN?=
 =?utf-8?B?WHkxUjlsaFJlRmxYY082SjdGR3lFNi9WSnRHVzZ3SStXQ0tnK2NOeEY3NmJp?=
 =?utf-8?B?R0R4Y2dQQWkxTFI2RUpmVTVDNzRLTy9ObHdTRDhuTFRERFdYVVZkMml1SU1m?=
 =?utf-8?B?aG8vZC82d29DODI1THZNd2Fsd3hPOGV0c1doaC9CNWJWUVZCeE14Mzdvc0Nn?=
 =?utf-8?B?amRuSUFHdlBRRXUvZURYcWliWTV0Nm5KVWdsN1EvNzYzTjRIZzY3RVF3U2x3?=
 =?utf-8?B?dHpWcG5tRkt1ZTBPYW5BSlR0aEtEc1E3MVFjbzE0V3o2RWE4d203SytvM01s?=
 =?utf-8?B?enpwRDRPeTRWS1E0U0tzemF0VHFRR2xyanhhbWVaVm9tKzVOUFNGRmNxV0dE?=
 =?utf-8?B?MnZibjhLcGxsK2U0dzQ0akZzQmJHb2hNUFRxNnZjZWNTaElEZHgyWkozMHp5?=
 =?utf-8?B?QTZ0bnAzZXA5QjhhREUwbjhQUGZ6clovVDNIS2Jldmg0T3JhejFzNFFZTmxL?=
 =?utf-8?B?VHBiazM1TUdEeE1ESmlQSkI1UzVPRXRreWRSTWR1YW56ZTdkRDlDRWs0Lzcx?=
 =?utf-8?B?eEhwSllCQ2V5enJzektORWpZMGgxUE9pYjJ3OXdaNS8wOW03RndXejlOamRQ?=
 =?utf-8?B?WFJtM2tvVkhraXMvcG1VRGNoQ2JGemtXLzhyMUNvK1VLNy9OWXdmMzlpNGQ2?=
 =?utf-8?B?ZjFmR1BVSzJqK01jQmtGdFhKMEpWek50a2FicTJXZWRPam1tZzBvcXNrVWRn?=
 =?utf-8?B?MUtaV1JqVnd2WnNYUFljN2YvaGZWZDJxeTNEY0VQR0hJRENNRjlrT3VOa2xE?=
 =?utf-8?B?MXQvdm40YTVvL2ljSjhjNEdEY1o5VnQwUE1HMGd6L0toVU1NUmZ4SzBXclY5?=
 =?utf-8?B?NkxhaFY5c1g3NFAzVUJVRlhBYjBWRThMdkZEZ20wL1doOW10OFQvRDh0cFJt?=
 =?utf-8?B?ZlNRUFRMeEhuSVBHRG85R3BpTTd6c29Wdk8rQmFxUXArR2JOdjgvYkxIbkVv?=
 =?utf-8?B?VUpDVGdiUkJseFFFQmhTUXI3RE1DZXhuMEI0a2JNeDNlTUl0S2Ywdy9BNW9x?=
 =?utf-8?B?NlUvaFJhSTlGM0dkdVh4WEJRTkhEcGRXZldYK3BDZXpnWDYzVUxvMlFWZkVP?=
 =?utf-8?B?bmRYSEJFdjQvM2l4eGlIclNSa2wxVTF5TzFyMWVzQ1lmU25xeXdpMmY1QVhn?=
 =?utf-8?B?bWg0UTN1OTBTSTNHT0FPcHZEV1FXZzJxaHYwaVd0dW5rcEs1MmtQdmN4UWkx?=
 =?utf-8?B?SlFBYkhUalBoYjg3Z1hON3cxN0k1YU80U3pHK3lrWFFyNVZEaWlSclJma2Nk?=
 =?utf-8?B?K3BmM3NIL1VYZHVZbVNLMEFHY2drcjdMR3BzL2dtR1ZlN2tXYUx2S0NTeElL?=
 =?utf-8?B?TjhLcHFaVG51azV1YlkzdmN4QmdMcVl4Tk5WcWNTc21TMWJNUFpEclRVd1Zk?=
 =?utf-8?B?cFJkWWlENWJxT1NRWEFvdHpGcTlPS3B6Q24rY0psbER4emMwaURBWG5qZUtK?=
 =?utf-8?B?QmI3T2R6ZktiZHhuWkJLMzZQQzFDK0NWam1CMmVHVitOQW1WZVRsZjRuYXFT?=
 =?utf-8?B?QzF6ZW1ZaTM1Q1U2bkpxY0xNMnIrYjRzbE8yaGNsTVo5NXVGMTZ3NHBtWXF1?=
 =?utf-8?B?bUpRU25TS0tlRFEwM283dGVMc1A2Y25uNFNucHNYTGVpdm1PV2Q3bXY5ajd5?=
 =?utf-8?Q?rpDtRbnrbr4cdVubgSMLPyo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <21DE946A705BB54C8C79A5FE8545062F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PFhCsgC9E5YGWWaTTSeqYLA3YPVNNx3YZEReNTfN8UYUllYAVbo9iJfe63oKOCEcOG1TZUsGtqNKB3ycvmwZO91ZhqbBb+lLMRRSkldVeEmsfenE3aS+FvneJOwrsXq3s7aNGPNQ8IDFZGfz1cUNmpSbYvocKCSI9spRa8FQDFPMEZ98WqM/3pJhZxVPEqHLvhcf/v6llWy9ZDtJ4j88tU3XdZifenYlyMwR3tyZqpKOpF/++5ocK5UfE4WTAmpSBiMocrrdwh40YtZk8rZG7LqpKIZ0YgyOZhEBbHA9PEskaZyCdxXqzyQvN264N4scEwOsoaQR9SwuZa9u4GkWsdc5lVATfKHELAiI1OkDvzXPBYvlrFvN6E6TtURRqj6YdUoexB4+EYagZeWmxoXWngpHXPbD8Mzb7zppH9jE7TBAbVYFIa+p0+aKw7sG6pkI0aOvxsN/mHSggwDyY2I2gth6r+PjchL4/4cGKPLkj6QyhDDdTYw2OeuemqEx3AyrAoqksiqaYKbo8EcLzVpmwLqSksLPlmLvHq7XYll/cpIxIH1gNdX+4cye10KUoEMXvUvJ8XclNmv8Yco54DXwpe2GQ+GiM9eOH+tEVrUfuF8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB7634.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5fdb7e-42b2-471c-567e-08dcdc1a2ec6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2024 21:53:39.1166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sN6TFZXcEfGQ0W47f6Sa+CIiHndDrbTcTy8WsfY9CcyLY/SL6ZppWNFFvrv0oLaYrzKsrYSMAYj0osT+AGzJSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_15,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409230157
X-Proofpoint-GUID: HsZ5PBa65Y3dNbE3y6viaY2_PF-XsbaP
X-Proofpoint-ORIG-GUID: HsZ5PBa65Y3dNbE3y6viaY2_PF-XsbaP

DQoNCj4gT24gU2VwIDIzLCAyMDI0LCBhdCAyOjQ24oCvUE0sIFNodWFoIEtoYW4gPHNraGFuQGxp
bnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiANCj4gT24gOS8yMy8yNCAxNToxOCwgWWlmZWkg
TGl1IHdyb3RlOg0KPj4+IE9uIFNlcCAyMywgMjAyNCwgYXQgMTo1NuKAr1BNLCBTaHVhaCBLaGFu
IDxza2hhbkBsaW51eGZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4+PiANCj4+PiBPbiA5LzIzLzI0
IDE0OjQ3LCBZaWZlaSBMaXUgd3JvdGU6DQo+Pj4+IFdlIHJlY2VudGx5IG5vdGljZSB0aGF0IHRo
ZSBzdGVwX2FmdGVyX3N1c3BlbmRfdGVzdCB3b3VsZA0KPj4+IA0KPj4+IG5vdGljZWQNCj4+IEhv
dyBhYm91dCBjaGFuZ2UgdGhpcyB0byBmaW5kPw0KPiANCj4gRWl0aGVyIGlzIGZpbmUgLSBpdCB3
b3VsZCBmb3VuZCBpbnN0ZWFkIG9mIGZpbmQgLSBvciB5b3UgY291bGQgd3JpdGUNCj4gaXQgYXMg
YmVsb3c6DQo+IA0KPiAic3RlcF9hZnRlcl9zdXNwZW5kX3Rlc3QgZmFpbHMgd2l0aCBkZXZpY2Ug
YnVzeSBlcnJvciB3aGlsZQ0KPiB3cml0aW5nIHRvIC9zeXMvcG93ZXIvc3RhdGUgdG8gc3RhcnQg
c3VzcGVuZC7igJ0NClRoYW5rcw0KPiANCj4+PiANCj4+Pj4gZmFpbCBvbiBvdXIgcGxlbnR5IGRl
dmljZXMuICBUaGUgdGVzdCBiZWxpZXZlc2l0IGZhaWxlZCB0bw0KPj4+IA0KPj4+ICJzZXZlcmFs
IG9mIG91ciBkZXZpY2VzIiAgYmVsaWV2ZXMgaXQNCj4+Pj4gZW50ZXIgc3VzcGVuZCBzdGF0ZSB3
aXRoDQo+Pj4gDQo+Pj4gUGxlYXNlIGRvIGZpeCB0aGUgYWJvdmUgYXMgcG9pbnRlZCBvdXQgZWFy
bGllciBvbiB2MS4NCj4+IEFwb2xvZ2llcywgZm9yZ2V0IHRvIGZpeC4gV2lsbCBmaXggdGhhdC4N
Cj4+Pj4gJCBzdWRvIC4vc3RlcF9hZnRlcl9zdXNwZW5kX3Rlc3QNCj4+Pj4gVEFQIHZlcnNpb24g
MTMNCj4+Pj4gQmFpbCBvdXQhIEZhaWxlZCB0byBlbnRlciBTdXNwZW5kIHN0YXRlDQo+Pj4+IEhv
d2V2ZXIsIGluIHRoZSBrZXJuZWwgbWVzc2FnZSwgSSBpbmRlZWQgc2VlIHRoZSBzeXN0ZW0gZ2V0
DQo+Pj4+IHN1c3BlbmRlZCBhbmQgdGhlbiB3YWtlIHVwIGxhdGVyLg0KPj4+PiBbNjExMTcyLjAz
MzEwOF0gUE06IHN1c3BlbmQgZW50cnkgKHMyaWRsZSkNCj4+Pj4gWzYxMTE3Mi4wNDQ5NDBdIEZp
bGVzeXN0ZW1zIHN5bmM6IDAuMDA2IHNlY29uZHMNCj4+Pj4gWzYxMTE3Mi4wNTIyNTRdIEZyZWV6
aW5nIHVzZXIgc3BhY2UgcHJvY2Vzc2VzDQo+Pj4+IFs2MTExNzIuMDU5MzE5XSBGcmVlemluZyB1
c2VyIHNwYWNlIHByb2Nlc3NlcyBjb21wbGV0ZWQgKGVsYXBzZWQgMC4wMDEgc2Vjb25kcykNCj4+
Pj4gWzYxMTE3Mi4wNjc5MjBdIE9PTSBraWxsZXIgZGlzYWJsZWQuDQo+Pj4+IFs2MTExNzIuMDcy
NDY1XSBGcmVlemluZyByZW1haW5pbmcgZnJlZXphYmxlIHRhc2tzDQo+Pj4+IFs2MTExNzIuMDgw
MzMyXSBGcmVlemluZyByZW1haW5pbmcgZnJlZXphYmxlIHRhc2tzIGNvbXBsZXRlZCAoZWxhcHNl
ZCAwLjAwMSBzZWNvbmRzKQ0KPj4+PiBbNjExMTcyLjA4OTcyNF0gcHJpbnRrOiBTdXNwZW5kaW5n
IGNvbnNvbGUocykgKHVzZSBub19jb25zb2xlX3N1c3BlbmQgdG8gZGVidWcpDQo+Pj4+IFs2MTEx
NzIuMTE3MTI2XSBzZXJpYWwgMDA6MDM6IGRpc2FibGVkDQo+Pj4+IC0tLSBzb21lIG90aGVyIGhh
cmR3YXJlIGdldCByZWNvbm5lY3RlZCAtLS0NCj4+Pj4gWzYxMTIwMy4xMzYyNzddIE9PTSBraWxs
ZXIgZW5hYmxlZC4NCj4+Pj4gWzYxMTIwMy4xNDA2MzddIFJlc3RhcnRpbmcgdGFza3MgLi4uDQo+
Pj4+IFs2MTEyMDMuMTQxMTM1XSB1c2IgMS04LjE6IFVTQiBkaXNjb25uZWN0LCBkZXZpY2UgbnVt
YmVyIDcNCj4+Pj4gWzYxMTIwMy4xNDE3NTVdIGRvbmUuDQo+Pj4+IFs2MTEyMDMuMTU1MjY4XSBy
YW5kb206IGNybmcgcmVzZWVkZWQgb24gc3lzdGVtIHJlc3VtcHRpb24NCj4+Pj4gWzYxMTIwMy4x
NjIwNTldIFBNOiBzdXNwZW5kIGV4aXQNCj4+Pj4gQWZ0ZXIgaW52ZXN0aWdhdGlvbiwgSSBub3Rp
Y2UgdGhhdCBmb3IgdGhlIGNvZGUgYmxvY2sNCj4+PiANCj4+PiBub3RpY2VkPw0KPj4gSG93IGFi
b3V0IHVzZSBmaW5kIGhlcmU/DQo+IA0KPiBJdCBpcyB0aGUgdGVuc2UgaXNzdWUgLSBmb3VuZCBv
ciBub3RpY2VkIHdvdWxkIHdvcmsuDQpUaGFua3MNCj4+PiANCj4+Pj4gaWYgKHdyaXRlKHBvd2Vy
X3N0YXRlX2ZkLCAibWVtIiwgc3RybGVuKCJtZW0iKSkgIT0gc3RybGVuKCJtZW0iKSkNCj4+Pj4g
a3NmdF9leGl0X2ZhaWxfbXNnKCJGYWlsZWQgdG8gZW50ZXIgU3VzcGVuZCBzdGF0ZVxuIik7DQo+
Pj4+IFRoZSB3cml0ZSB3aWxsIHJldHVybiAtMSBhbmQgZXJybm8gaXMgc2V0IHRvIDE2IChkZXZp
Y2UgYnVzeSkuDQo+Pj4+IEl0IHNob3VsZCBiZSBjYXVzZWQgYnkgdGhlIHdyaXRlIGZ1bmN0aW9u
IGlzIG5vdCBzdWNjZXNzZnVsbHkgcmV0dXJuZWQNCj4+Pj4gYmVmb3JlIHRoZSBzeXN0ZW0gc3Vz
cGVuZCBhbmQgdGhlIHJldHVybiB2YWx1ZSBnZXQgbWVzc2VkIHdoZW4gd2FraW5nIHVwLg0KPj4+
PiBBcyBhIHJlc3VsdCwgSXQgbWF5IGJlIGJldHRlciB0byBjaGVjayB0aGUgdGltZSBwYXNzZWQg
b2YgdGhvc2UgZmV3IGluc3RydWN0aW9ucw0KPj4+PiB0byBkZXRlcm1pbmUgd2hldGhlciB0aGUg
c3VzcGVuZCBpcyBleGVjdXRlZCBjb3JyZWN0bHkgZm9yIGl0IGlzIHByZXR0eSBoYXJkIHRvDQo+
Pj4+IGV4ZWN1dGUgdGhvc2UgZmV3IGxpbmVzIGZvciA1IHNlY29uZHMuDQo+Pj4+IFRoZSB0aW1l
ciB0byB3YWtlIHVwIHRoZSBzeXN0ZW0gaXMgc2V0IHRvIGV4cGlyZWQgYWZ0ZXIgNSBzZWNvbmRz
IGFuZCBuby1yZWFybS4NCj4+Pj4gSWYgdGhlIHRpbWVyIHJlbWFpbmluZyB0aW1lIGlzIDAgc2Vj
b25kIGFuZCAwIG5hbm8gc2Vjb21kLCBpdCBtZWFucyB0aGUgdGltZXINCj4+Pj4gZXhwaXJlZCBh
bmQgd2FrZSB0aGUgc3lzdGVtIHVwLiBPdGhlcndpc2UsIHRoZSBzeXN0ZW0gY291bGQgYmUgY29u
c2lkZXJlZCB0bw0KPj4+PiBlbnRlciB0aGUgc3VzcGVuZCBzdGF0ZSBmYWlsZWQgaWYgdGhlcmUg
aXMgYW55IHJlbWFpbmluZyB0aW1lLg0KPj4+IA0KPj4+IFdoYXQgd291bGQgeW91IGdldCBpZiB5
b3Ugd2VyZSB0byBjYXQgL3N5cy9wb3dlci9zdGF0ZSBhdCB0aGlzIHBvaW50Pw0KPj4gQWNjb3Jk
aW5nIHRvIGZpbGUga2VybmVsL3Bvd2VyL3N1c3BlbmQsIHRoZSBjYXQgd2lsbCBhbHdheXMgcmV0
dXJuIGZyZWV6ZSBtZW0gZGlzay4NCj4+PiBEb2VzIHRoaXMgZml4IHRoZSBwcm9ibGVtIHlvdSBh
cmUgc2VlaW5nPyBXaGF0IGlzIHRoZSBvdXRjb21lPw0KPj4gWWVzLCBpdCBmaXhlcy4gVGhlIHRl
c3Qgd291bGQgbm90IGZhaWwgZm9yIGl0IGJlbGlldmVzIHRoZSBzeXN0ZW0gZG9lcyBub3Qgd2Vu
dCB0byBzdXNwZW5kIGJ5IG1pc3Rha2UuIEl0IG5vdyBjb3VsZCBjb250aW51ZSB0byB0aGUgcmVz
dCBwYXJ0IG9mIHRoZSB0ZXN0IGFmdGVyIHN1c3BlbmQuDQo+IA0KPiBDYW4geW91IGFkZCB0aGlz
IHRvIHRoZSBjaGFuZ2UgbG9nLg0KU3VyZS4gSSB3aWxsIHNlbmQgYSB2MyBsYXRlci4gDQo+IA0K
Pj4+PiBGaXhlczogYmZkMDkyYjhjMjcyOCAoInNlbGZ0ZXN0czogYnJlYWtwb2ludDogYWRkIHN0
ZXBfYWZ0ZXJfc3VzcGVuZF90ZXN0IikNCj4+Pj4gUmVwb3J0ZWQtYnk6IFNpbmFkaW4gU2hhbiA8
c2luYWRpbi5zaGFuQG9yYWNsZS5jb20+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFlpZmVpIExpdSA8
eWlmZWkubC5saXVAb3JhY2xlLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICAuLi4vdGVzdGluZy9zZWxm
dGVzdHMvYnJlYWtwb2ludHMvc3RlcF9hZnRlcl9zdXNwZW5kX3Rlc3QuYyAgfCA1ICsrKystDQo+
Pj4+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4+
IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icmVha3BvaW50cy9zdGVwX2Fm
dGVyX3N1c3BlbmRfdGVzdC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnJlYWtwb2ludHMv
c3RlcF9hZnRlcl9zdXNwZW5kX3Rlc3QuYw0KPj4+PiBpbmRleCBkZmVjMzFmYjliMzBkLi4zM2Y1
NTQyYmY3NDFkIDEwMDY0NA0KPj4+PiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icmVh
a3BvaW50cy9zdGVwX2FmdGVyX3N1c3BlbmRfdGVzdC5jDQo+Pj4+ICsrKyBiL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL2JyZWFrcG9pbnRzL3N0ZXBfYWZ0ZXJfc3VzcGVuZF90ZXN0LmMNCj4+Pj4g
QEAgLTE1Miw3ICsxNTIsMTAgQEAgdm9pZCBzdXNwZW5kKHZvaWQpDQo+Pj4+ICAgaWYgKGVyciA8
IDApDQo+Pj4+ICAga3NmdF9leGl0X2ZhaWxfbXNnKCJ0aW1lcmZkX3NldHRpbWUoKSBmYWlsZWRc
biIpOw0KPj4+PiAgLSBpZiAod3JpdGUocG93ZXJfc3RhdGVfZmQsICJtZW0iLCBzdHJsZW4oIm1l
bSIpKSAhPSBzdHJsZW4oIm1lbSIpKQ0KPj4+PiArIHN5c3RlbSgiKGVjaG8gbWVtID4gL3N5cy9w
b3dlci9zdGF0ZSkgMj4gL2Rldi9udWxsIik7DQo+Pj4+ICsNCj4+Pj4gKyB0aW1lcmZkX2dldHRp
bWUodGltZXJmZCwmc3BlYyk7DQo+Pj4+ICsgaWYgKHNwZWMuaXRfdmFsdWUudHZfc2VjICE9IDAg
fHwgc3BlYy5pdF92YWx1ZS50dl9uc2VjICE9IDApDQo+Pj4+ICAga3NmdF9leGl0X2ZhaWxfbXNn
KCJGYWlsZWQgdG8gZW50ZXIgU3VzcGVuZCBzdGF0ZVxuIik7DQo+Pj4+ICAgICBjbG9zZSh0aW1l
cmZkKTsNCj4+PiANCj4gDQo+IHRoYW5rcywNCj4g4oCUIFNodWFoDQpZaWZlaQ0KDQoNCg==

