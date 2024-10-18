Return-Path: <linux-kselftest+bounces-20083-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2D49A31B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 02:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8072A1C22F1E
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 00:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B7534545;
	Fri, 18 Oct 2024 00:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aBmKkBO4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dC/lRVzn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB9A20E307;
	Fri, 18 Oct 2024 00:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729211667; cv=fail; b=ci8WDjsNpcvh8lvmx2ZBUemY+hqsy68Bo5eN7yYvEeyyzOY2kIjCRB4Vfv0YkuOPb+tKX5DRKHGsMh6udGKfa5gLKikCRA//OE2+mGthiDQUS/TMpF9z0RoPXzRNR75XCxBvHbtEAMvLwooHnFyQirLrJWhXvb23zJceaPvGGNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729211667; c=relaxed/simple;
	bh=5tXrtrN6/v3UJBwWxuE32iza+V5x2l3BBKyE3Ecv/cs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dse9AgVGL0fhw5ptfpuDPCNQ1HmyonR0kvON6nr155I25zWlMdRzytfWi1RBvDXSuYfsMSOZpRml7LKeslOcqrklT+qeNHObmCgx/29NswpdH/+Yi9FZlWgVpJmMXZG7r82Son8zJP1haiTEcm+Z62xYBqNf+LjyXydMpHDdwfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aBmKkBO4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dC/lRVzn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HNnDIk029037;
	Fri, 18 Oct 2024 00:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=5tXrtrN6/v3UJBwWxuE32iza+V5x2l3BBKyE3Ecv/cs=; b=
	aBmKkBO49LnB/Gsi6nSCCo99Xqyq/ulpsxhlXLmhqewnIjGfzmT0oHPhgU/L1wv1
	uxBx34F0w164qfriurnz4HygJHRidxzpOwYMcmbBUeAYb1W6kei9LTvPZgdYU9mq
	cAeL89tKdb6rYeZjTtiDIN/ELry1aFTqUHGBZYD41SfsgWf1k+k5GdVByhLh4HCe
	xx+PTI4Oi+m8KWR6DF022j9YV/QeR2gz1cGHjKcoQB3LQjlbrfgy4xUEvGdR0/hJ
	fP/HrjDyRCiOEi6HSPZqOMiSHj1rPnjQt5FKKTvDq+n4wr0fVFEeRk4ogeGYkBUQ
	vIWQmskbNzXRWZ5m7M39CA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fw2qt7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 00:34:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HMD3PH013907;
	Fri, 18 Oct 2024 00:34:04 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjaxv54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 00:34:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpSnQRSET3XgkltTeaJLgBfqaAqE/IVAWgLKMEU5BYz7NZTjrZrUH+6mbE5gh9rPUjRKrNUTeqODgMCOR0f1Fi2eFyansNf7gaKc1D850NoxdtVLNw0UErPpbgIqxBejm1Mvk8xvAfXy8FitQKuPBKpH9Y9rGbgsXwnSIc/LnR/ncEzt8kdL22NBbBqhz92xTYp2jIaJ+vvARlwNOOq07tUgpyiSEVvAZQAehO3BbSs4PDcKaZF5Gb00A6Eg/NSUQhdfeZScvvGF7XO96wExORxrKJyD0s6g/LmYOL1U5Fu7O0w+OC0/sZEIlBP29m4JlXrUVGdchgA14L33OU4bgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tXrtrN6/v3UJBwWxuE32iza+V5x2l3BBKyE3Ecv/cs=;
 b=xXzX4s8BKiv1tOPaSqRXJZ98UDZVGh550vaF96aPVLM8vL/wOUlnLnpknaLOEiYsJ5M9dscdUrK8jYPTm+nbDOAIsxf/zV/dWF3B7kB1BId08BiyX9jq3qhRs4vGIol68r4p5ucQi+arVCJNzPcZkAvCL4BbfUjvt73MTdFezFmVsZDnzhLvFYNCjOHSw2ZN690u9vCyPVXnhI47iggoQRkpy6fNcqWsrTt4mqsV5MIK3YD4Pijy3QdEpY1Vb+GnBQtCKMb8YYRp4h6gAvnIRI3Z9Kx51rhGMxIJdAUxndKSTiuKKG5MLXJgJq9XqOItuB6z25XFSFHkSKOskrUeKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tXrtrN6/v3UJBwWxuE32iza+V5x2l3BBKyE3Ecv/cs=;
 b=dC/lRVznmIRpCDQidIxINa2o4sYBYZTtEQsvqO/uo8iGFZPFdxLgPNLlufZHZJu6ganx3fAC896mmQCcGxTMVujI72kAfBD2ygxEdjGjVivvIcAwooQXKGay95shDFusqxl7X2Vjc2qDKCjCjUEZ5NH/Zd+Ub56LXx0XKg1oiE8=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by PH0PR10MB4677.namprd10.prod.outlook.com (2603:10b6:510:3d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 00:34:02 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::3c5e:9043:1ca9:4c60]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::3c5e:9043:1ca9:4c60%5]) with mapi id 15.20.8069.018; Fri, 18 Oct 2024
 00:34:02 +0000
From: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        Liam Howlett
	<liam.howlett@oracle.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org"
	<peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org"
	<rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "vschneid@redhat.com"
	<vschneid@redhat.com>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "shuah@kernel.org"
	<shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        Pei Li <peili.io@oracle.com>
Subject: Re: [PATCH net-next v5 2/3] connector/cn_proc: Kunit tests for
 threads hash table
Thread-Topic: [PATCH net-next v5 2/3] connector/cn_proc: Kunit tests for
 threads hash table
Thread-Index: AQHbIMB0xnnjqPmQVEKeaxqXStpTkLKLo7gAgAAFlYA=
Date: Fri, 18 Oct 2024 00:34:01 +0000
Message-ID: <4DDCECB9-86A9-4796-8A27-34113A79C3EC@oracle.com>
References: <20241017181436.2047508-1-anjali.k.kulkarni@oracle.com>
 <20241017181436.2047508-3-anjali.k.kulkarni@oracle.com>
 <ZxGoQHqXTNW7C7MB@mini-arch>
In-Reply-To: <ZxGoQHqXTNW7C7MB@mini-arch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|PH0PR10MB4677:EE_
x-ms-office365-filtering-correlation-id: 87b5bcf7-b01b-4996-4f8d-08dcef0c904e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R3pkWElJTlo1OXhsbnpiSFN5Qk0xRW56RXVZdGFXTTk3WXJyTEFMbGFjWDdN?=
 =?utf-8?B?bC9tSXVOQXkxRGtremZEWjBSTk9maktNOTZvSUJSZ2c2MWdneVB2VEhlS1RN?=
 =?utf-8?B?THpOWHd2SjBjREsyQWFQQ0ZSem4vWmFnQWhuSTNXWHhMNGFoWGhWK2J0c1da?=
 =?utf-8?B?VTFQazR3VElOUWZwc3VRNThrdy9DRThuQXR6N2NhaUZLelVPL1hKTmxCait1?=
 =?utf-8?B?YUo5ZUl3Wm1Ua0JlVnRabWt2YUxVSjlYS2IzMDY4N3ZVZWFjYVg1TG0xb2oy?=
 =?utf-8?B?N0F2cnZTMWtyUW16NzUzcFhiRTZhb01MZk1VeTEzQ2FJZXZ6RFhKalFWK3l0?=
 =?utf-8?B?VWV2NjBEUFVQdGozV1E4M3BxaE5TNW9VS2VmK0s2WjhqdHZJKzg1blVBbkRM?=
 =?utf-8?B?OSs5bEt1T2FRTEhIME5BQUxMMWY2LzJlRFI5cEt1cE1YM2VOUHNrY2VBMnZY?=
 =?utf-8?B?elhKeGpuK0ZDeVFIUTg0Kzl5elpWM3M3UGZ0Zit2aHYvVGFHREFydkEvU2xD?=
 =?utf-8?B?RFNmZGFiL2hLc0dQdi9VQ1R1TGRqWHAxMDZ0V3Z5eGU0Sk9LOWgxNklYby9P?=
 =?utf-8?B?MEp0NjNmRXI0dmVEWjBwR1BSN3ZSZ1ozeCtUck9XbjYvWllMZWQ1MllKVkNk?=
 =?utf-8?B?YXNGV2w1aWdjY0owdi9PdWh1WmwyN2hjS21TRUFFbHRpMkN5UzBFMEcrRFR2?=
 =?utf-8?B?QjBERmJiK3BaSHRkczNMditxNUFDV0srWjV1T3BBa08zUVBIVXFpa1dBenFD?=
 =?utf-8?B?dVBLcjg0NXN2bTJkcGNJd3J1dUlEY1NnR043SlVjaTk5VElyNzFGTTZZcmZx?=
 =?utf-8?B?bGV3bFB0ZnlvSDZGSkxjTFhUYklaWmM2M2FPRFdtOG1lZHFtR00rV0FBdFFz?=
 =?utf-8?B?QmducVhTdE5IMy9lbDRSQ2ZOZ3pSL2xGM1FBaE83ZEFqN0l1eWNrTUV4QmJi?=
 =?utf-8?B?NWRsZ3NQTUMybnhKQW5IbXRWd1ZlT1ZOM0VTTWl1aXBGNEJUQ3EyZXgxbTQy?=
 =?utf-8?B?cHJSZFpOZE5yeUgzSW1TRVd2L28xLzlndHN1YTkrNFdJWTZoenIwOG9QZ21l?=
 =?utf-8?B?ZTNjQkc1R2I2OUxyR1g5UXZQakFGUnYvaUo4U3VjYTZGcDZzZGRjS3F4ditR?=
 =?utf-8?B?UHJORFJVd24vcE90VkMxdW00OVdOVFVxRHAzbXpwWTdBTGMwNGxveVdGcVlq?=
 =?utf-8?B?NjZCaGU4YjJ5alhBSUNKckdmV0hiQ1NCbGlhd1FvVGpEc1ovRk5KZFM1Y3or?=
 =?utf-8?B?MEhWYkdVd29nY0k5MkxNbEEyT2N2bHhQbEhmQ2dtY3pGcEJRdjZRMWdxV0Z6?=
 =?utf-8?B?Y2VBbUVkWXJDdXE4Mkt3ZGQ3OFJkbWtwTnhjU3JzUEhZMnlId0JWT1N1ampO?=
 =?utf-8?B?SVdVQXFaWFc1dVRSNTh2L29ZdG52UTd2RW1HTWduQks0R2RVenpkdVdSa1Fq?=
 =?utf-8?B?RDg1bUZhMGpDM05wVC8xQnlrYSs2VVJSQ1lXd1dwRmthN3k0ZlRWek10SmxM?=
 =?utf-8?B?Uy9RSGtpbWJnVnZJelV4NCtXU1UveGRiaEdTR2U4SlBHVkJVMUpXZHZVSWpy?=
 =?utf-8?B?ZjJubTR1SnVMMzUwUnUrSGNManFlYi9VbHlwT1VmdlVqSndxUzFYUGZZVk1R?=
 =?utf-8?B?SG5ISGRJM3RQVk1HSjdBb3hnVU1TOUdqK0htb0dKVThMNHJJclc2djdXaFZV?=
 =?utf-8?B?MlpRVFJXcXlJb25mVS9LZU9FWWZ5NDdQdFhLL1lacS9tdFE3a0hXMjQ1V2E5?=
 =?utf-8?B?OGZWWmExWTVLTkhHOXdhT09yT1VLc3A0NUx6SENMeXAwNXhab2ZmK1dmaU9E?=
 =?utf-8?Q?Z4EoX8rrJNis/G7P/N2Qwnss8JjRcW4d2TxdE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S1dHT0s4cGNDQXF1RzFMS2gzMTFiUGk4UXgvUGM3VEZIVnpQbjk1eHVvZzRI?=
 =?utf-8?B?WTB3bm0zbjZlTlN5ZTBmWWtMSnZUOWc3NUZvVkhoRXJxWEV4cUFleVBLZUVk?=
 =?utf-8?B?ZHUwWlNPdVc3N1RUZ2VxbU9teElKbmNvVytnVjVuM2ZsTkk3Q2hLVHFYZzM5?=
 =?utf-8?B?b01lbHloSjZmUC9taFZrN2UrZ0VIa2pJV3hKcWxUdVpJMEtrU1pITmpoVnBB?=
 =?utf-8?B?bjFDTWJaZG4yclozWGMySWNBSFZlTlUxNHlVZ3BSbHlXeUdiaFBoVm9MM0lJ?=
 =?utf-8?B?Z3BvVkxNbVNlcHd0Q2pVOEFWUTVhVGF5ZEhsYjYxcmMwMUNvYzM2UnpqWDEy?=
 =?utf-8?B?bFowalFmZEdlZldqcGRFREZaNTJTelA4YU1Gb2NFZ0NXV3QzVy93ZCtqTU93?=
 =?utf-8?B?NlFBdmR5M0NRQzV5UzVNZVJLRjFRbWJYRUcvVjVNY1FPYjhDM3VPcDFXSi95?=
 =?utf-8?B?STlLOGxybHBGSFA3emNDak8vTHRKSU5pWEV5ajk5NFE3OGtmSkVnaWNvSkR0?=
 =?utf-8?B?SU9hdWJJTVJNTFZnbFdTOE03NDRiZk5uWFpCWkpvMi84SEpXQ2NVamJlMUY2?=
 =?utf-8?B?SW55enhxRVI2ZWtyUU5Dbm9uRHhRUktEdnRFSWN0U0ZvOVhOYTI1akNkYjl4?=
 =?utf-8?B?S1doc1dkZnpSRzAwZkQ3N1NKYjI0TWF3YkFFM0I5akRHVlhUeG1GTDUzdkc4?=
 =?utf-8?B?dkQvMG45UURLaDc1WGV0Nlh5emlIenRxVHlMd3Y2bndpa1UydUY0cmtiMnRC?=
 =?utf-8?B?NU50cWM0bzl6VHhrR3JSTEpUR1FIbjFPaUhya2F1S3ZyR0NSL1hFTUJLYTBX?=
 =?utf-8?B?U2JzUjAwRVlpUzJlMm1Gd0FDOXBYYXpRejdpR3g0N1AvSU5ZNFNXV053QlJO?=
 =?utf-8?B?TldYeStoaVR3MU9SNnorSTNjeGFEMG1SeXdtbUpyN0h0eWplclpKdkIrTjJC?=
 =?utf-8?B?YnJkaElRSHEyZkEzSlZKeHN2eFZpcXpFZTA4enUyN3FISm9ZNU4zREtGeUlC?=
 =?utf-8?B?SGcxNTZPY1NkUkd5Z2VHSENqRDc3RHBiQm1KeFZpNUtBZ1N3M2NqZFlEMnVF?=
 =?utf-8?B?QVlQSGtoUGYzV3Bwb2s0OU1HYjRmQXVrVVl6VWMzOXQ5YTA2cTNTdVpraGJ4?=
 =?utf-8?B?YVdoYkZ2MG9LeVJtZlAwb1dyWlRuZVNiWFB3Z0lSK1JnWEIxRU5nUEQ4WEli?=
 =?utf-8?B?QWpGNVNTL1RjSEs1L2E2Q3dBOHAzcncrNnRCSjVYVzRUNWkvRVhveU9Mazl4?=
 =?utf-8?B?emo3ellPWWgwaGZhZXZmMHhnT0lkcnNZb1hONkFuNkdVY3ZjMmZYSklOdkh6?=
 =?utf-8?B?L0xML0lGamgyS2I4LzNabGd2eVlZRkRSMGxQUTBYZDJmVVplanVtQzhlb0Rm?=
 =?utf-8?B?WkhhcDlWQzNyN0hFVkc2dy9VMkd2ZXNjSDNiUUxaYVc4RDZ2UEplRnNrbTJi?=
 =?utf-8?B?Y0g4cGE0VWgvZFBrV1hZeHErOVRjM2hIZ1IrVi9IdXp5dmQyNGc3NHp2U3E3?=
 =?utf-8?B?L05zYS8zblBkNEU4dkFOT1lWOXlVeG5HVEtKRTJKS1JwZ2FGekYzOVlGclVO?=
 =?utf-8?B?c3c3Vk4rUmh1T0NnODdUcE0xYnQ1MVZsRW10WW9Gd3VGWkV5ZHJ5Wit1MnRu?=
 =?utf-8?B?Lzhsc0tCK0wxWk5MazBsOUJreldSRm5lTmRpSzJRc1lsMTQ1ZkxFdWJPTW5V?=
 =?utf-8?B?cXJaK1JiU2xsSWNGc2hoK3JYVUpyMjFocmdwOUwxNWEwQ0htYWRONXpOSFJE?=
 =?utf-8?B?aHRBbEU4NDhxdXpFcVoxMENWekVrUWUybHhlUWlGd3pabWFVdFFldmdKZllL?=
 =?utf-8?B?ZW4vb0hJU3hwdUJaUHpzbC9KSVZZMkZmU3E1d1cvNDUvaDlTd0VsOTR4KzlJ?=
 =?utf-8?B?M3ZXQzR1WThORHZsTUhrc0hhK1N5cDZUNnJXWTZZVm85aS9NUEdGSUludVp3?=
 =?utf-8?B?MENOQm9NUDJ3WUhwaDRyY2lFZUh4QTJWb3hIaVgzTTl3OCtRVTRIVDhSeldL?=
 =?utf-8?B?c2FWbi9rdmh5eSsrRlp6VDRWWVFTY0Q0bVc2Ykg1MjYwdEZPUGgyZTRZRFFN?=
 =?utf-8?B?SUhINVpiTXg1c0pXSTZDZEFicFNWbUJoNHloQUpjVUZBRmczNDdmS0h4Z0I3?=
 =?utf-8?B?Y1UwU1l2bUUvQ3hTYlg3Y0gvQ2x4ZmtpQzFmb2doZG90Y2VzV05aZXcxMDZw?=
 =?utf-8?Q?KIOhhq/MNFMU9X5DloAJ27CQdRPNR8D8ZSIrFHaVPJNN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68E870082D104F49A97B7971B1D8F083@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/WZ/sFx8iKez+ZdtWC75HQ/+56ePxPSRNGDRd9+EcN3u6r+vbXKZXiu4hiC/+5X/+cTAvRGI1KrymbaLD68XCaa07e+fRLLTt+HTjeruQASCJFyxnfwAGc/+6IRrRDTrAF2RXo2E1qIx0JsgJkjRmRKbns1lZVbjTObm37WD0e0vVjjHBGFsFEv+JPgSh5IA6DsjaH0YkUU6480c3DKx/5ixDMqR3o556CEHizuA3/lqrNb2JjaGwltbSnYOXDtl8eC6vTFDrf9X74iKoaj9N24Z9RVgiorXenzBjbachyVuX+4HrOzfFLSQxFL+s+S3z/G9aqSrrquIbvi1o9X9IeyvR8xV6VDehkqtlU2RrbpJvq7m/rpiRssWXbeR4uZBM9jrQedIq5g5kGPW0c5/3NwUwyMkjUjdStpCSFWcFNpioM03F1huIL4wON7fVn3OjVmyS702kQEf9SmBjoh9QSgR8F0IVPLo+iWoVQne8BIukIxjkoL1fMdA6RzlvrMxtvBYXAcjsOzfqGVK17Bkz3oadhBb4KQO85CMsOehBCS5vND6cKqCuIBpYoS1Fccs2FjEq3THMp54YSzHIcxK7ktkLHskeY43amkliiCYIHI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b5bcf7-b01b-4996-4f8d-08dcef0c904e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 00:34:01.8835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4JtV2AhrbDhwmXcqxt7YDqHybiFj+I99/0AuYyAApsQVtjjQCXpsFQaRP2uZNiQoPMb9UI5KYpdykV27uuka6gF/THw2zLSPAJ0z52iJz3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4677
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_27,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410180002
X-Proofpoint-GUID: CtjKmCD9tRdsZ325TObFn2ONFfYDp1b4
X-Proofpoint-ORIG-GUID: CtjKmCD9tRdsZ325TObFn2ONFfYDp1b4

DQoNCj4gT24gT2N0IDE3LCAyMDI0LCBhdCA1OjEz4oCvUE0sIFN0YW5pc2xhdiBGb21pY2hldiA8
c3Rmb21pY2hldkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gMTAvMTcsIEFuamFsaSBLdWxr
YXJuaSB3cm90ZToNCj4+IEt1bml0IHRlc3RzIHRvIHRlc3QgaGFzaCB0YWJsZSBhZGQsIGRlbGV0
ZSwgZHVwbGljYXRlIGFkZCBhbmQgZGVsZXRlLg0KPj4gQWRkIGZvbGxvd2luZyBjb25maWdzIGFu
ZCBjb21waWxlIGtlcm5lbCBjb2RlOg0KPj4gDQo+PiBDT05GSUdfQ09OTkVDVE9SPXkNCj4+IENP
TkZJR19QUk9DX0VWRU5UUz15DQo+PiBDT05GSUdfTkVUPXkNCj4+IENPTkZJR19LVU5JVD1tDQo+
PiBDT05GSUdfQ05fSEFTSF9LVU5JVF9URVNUPW0NCj4+IA0KPj4gVG8gcnVuIGt1bml0IHRlc3Rz
Og0KPj4gc3VkbyBtb2Rwcm9iZSBjbl9oYXNoX3Rlc3QNCj4+IA0KPj4gT3V0cHV0IG9mIGt1bml0
IHRlc3RzIGFuZCBoYXNoIHRhYmxlIGNvbnRlbnRzIGFyZSBkaXNwbGF5ZWQgaW4NCj4+IC92YXIv
bG9nL21lc3NhZ2VzIChhdCBLRVJOX0RFQlVHIGxldmVsKS4NCj4+IA0KPj4gU2lnbmVkLW9mZi1i
eTogQW5qYWxpIEt1bGthcm5pIDxhbmphbGkuay5rdWxrYXJuaUBvcmFjbGUuY29tPg0KPj4gLS0t
DQo+PiBkcml2ZXJzL2Nvbm5lY3Rvci9jbl9oYXNoLmMgICB8ICA0MCArKysrKysrKw0KPj4gZHJp
dmVycy9jb25uZWN0b3IvY29ubmVjdG9yLmMgfCAgMTIgKysrDQo+PiBpbmNsdWRlL2xpbnV4L2Nv
bm5lY3Rvci5oICAgICB8ICAgNCArDQo+PiBsaWIvS2NvbmZpZy5kZWJ1ZyAgICAgICAgICAgICB8
ICAxNyArKysrDQo+PiBsaWIvTWFrZWZpbGUgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+PiBs
aWIvY25faGFzaF90ZXN0LmMgICAgICAgICAgICB8IDE2NyArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+PiBsaWIvY25faGFzaF90ZXN0LmggICAgICAgICAgICB8ICAxMCArKw0K
Pj4gNyBmaWxlcyBjaGFuZ2VkLCAyNTEgaW5zZXJ0aW9ucygrKQ0KPj4gY3JlYXRlIG1vZGUgMTAw
NjQ0IGxpYi9jbl9oYXNoX3Rlc3QuYw0KPj4gY3JlYXRlIG1vZGUgMTAwNjQ0IGxpYi9jbl9oYXNo
X3Rlc3QuaA0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jb25uZWN0b3IvY25faGFzaC5j
IGIvZHJpdmVycy9jb25uZWN0b3IvY25faGFzaC5jDQo+PiBpbmRleCBhMDc5ZTliY2VhNmQuLjQw
MDk5YjU5MDhhYyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvY29ubmVjdG9yL2NuX2hhc2guYw0K
Pj4gKysrIGIvZHJpdmVycy9jb25uZWN0b3IvY25faGFzaC5jDQo+PiBAQCAtMTcwLDYgKzE3MCw0
NiBAQCBpbnQgY25faGFzaF9nZXRfZXh2YWwoc3RydWN0IGNuX2hhc2hfZGV2ICpoZGV2LCBwaWRf
dCBwaWQpDQo+PiByZXR1cm4gLUVJTlZBTDsNCj4+IH0NCj4+IA0KPj4gK2ludCBjbl9oYXNoX2Rp
c3BsYXlfaGxpc3Qoc3RydWN0IGNuX2hhc2hfZGV2ICpoZGV2LCBwaWRfdCBwaWQsIGludCBtYXhf
bGVuLA0KPj4gKyBpbnQgKmhrZXksIGludCAqa2V5X2Rpc3BsYXkpDQo+PiArew0KPj4gKyBzdHJ1
Y3QgdWV4aXRfcGlkX2hub2RlICpobm9kZTsNCj4+ICsgaW50IGtleSwgY291bnQgPSAwOw0KPj4g
Kw0KPj4gKyBtdXRleF9sb2NrKCZoZGV2LT51ZXhpdF9oYXNoX2xvY2spOw0KPj4gKyBrZXkgPSBo
YXNoX21pbihwaWQsIEhBU0hfQklUUyhoZGV2LT51ZXhpdF9waWRfaHRhYmxlKSk7DQo+PiArIHBy
X2RlYnVnKCJCdWNrZXQ6ICVkXG4iLCBrZXkpOw0KPj4gKw0KPj4gKyBobGlzdF9mb3JfZWFjaF9l
bnRyeShobm9kZSwNCj4+ICsgJmhkZXYtPnVleGl0X3BpZF9odGFibGVba2V5XSwNCj4+ICsgdWV4
aXRfcGlkX2hsaXN0KSB7DQo+PiArIGlmIChrZXlfZGlzcGxheVtrZXldICE9IDEpIHsNCj4+ICsg
aWYgKGhub2RlLT51ZXhpdF9waWRfaGxpc3QubmV4dCA9PSBOVUxMKQ0KPj4gKyBwcl9kZWJ1Zygi
cGlkICVkICIsIGhub2RlLT5waWQpOw0KPj4gKyBlbHNlDQo+PiArIHByX2RlYnVnKCJwaWQgJWQg
LS0+ICIsIGhub2RlLT5waWQpOw0KPj4gKyB9DQo+PiArIGNvdW50Kys7DQo+PiArIH0NCj4+ICsN
Cj4+ICsgbXV0ZXhfdW5sb2NrKCZoZGV2LT51ZXhpdF9oYXNoX2xvY2spOw0KPj4gKw0KPj4gKyBp
ZiAoKGtleV9kaXNwbGF5W2tleV0gIT0gMSkgJiYgIWNvdW50KQ0KPj4gKyBwcl9kZWJ1ZygiKGVt
cHR5KVxuIik7DQo+PiArDQo+PiArIHByX2RlYnVnKCJcbiIpOw0KPj4gKw0KPj4gKyAqaGtleSA9
IGtleTsNCj4+ICsNCj4+ICsgaWYgKGNvdW50ID4gbWF4X2xlbikgew0KPj4gKyBwcl9lcnIoIiVk
IGVudHJpZXMgaW4gaGxpc3QgZm9yIGtleSAlZCwgZXhwZWN0ZWQgJWRcbiIsDQo+PiArIGNvdW50
LCBrZXksIG1heF9sZW4pOw0KPj4gKyByZXR1cm4gLUVJTlZBTDsNCj4+ICsgfQ0KPj4gKw0KPj4g
KyByZXR1cm4gMDsNCj4+ICt9DQo+PiArDQo+PiBib29sIGNuX2hhc2hfdGFibGVfZW1wdHkoc3Ry
dWN0IGNuX2hhc2hfZGV2ICpoZGV2KQ0KPj4gew0KPj4gYm9vbCBpc19lbXB0eTsNCj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2Nvbm5lY3Rvci9jb25uZWN0b3IuYyBiL2RyaXZlcnMvY29ubmVjdG9y
L2Nvbm5lY3Rvci5jDQo+PiBpbmRleCBjMWMwZGNlYzUzYzAuLjJiZTJmZTFhZGMxMiAxMDA2NDQN
Cj4+IC0tLSBhL2RyaXZlcnMvY29ubmVjdG9yL2Nvbm5lY3Rvci5jDQo+PiArKysgYi9kcml2ZXJz
L2Nvbm5lY3Rvci9jb25uZWN0b3IuYw0KPj4gQEAgLTMwNCw2ICszMDQsMTggQEAgaW50IGNuX2dl
dF9leHZhbChwaWRfdCBwaWQpDQo+PiB9DQo+PiBFWFBPUlRfU1lNQk9MX0dQTChjbl9nZXRfZXh2
YWwpOw0KPj4gDQo+PiAraW50IGNuX2Rpc3BsYXlfaGxpc3QocGlkX3QgcGlkLCBpbnQgbWF4X2xl
biwgaW50ICpoa2V5LCBpbnQgKmtleV9kaXNwbGF5KQ0KPj4gK3sNCj4+ICsgc3RydWN0IGNuX2Rl
diAqZGV2ID0gJmNkZXY7DQo+PiArDQo+PiArIGlmICghY25fYWxyZWFkeV9pbml0aWFsaXplZCkN
Cj4+ICsgcmV0dXJuIDA7DQo+PiArDQo+PiArIHJldHVybiBjbl9oYXNoX2Rpc3BsYXlfaGxpc3Qo
ZGV2LT5oZGV2LCBwaWQsIG1heF9sZW4sDQo+PiArIGhrZXksIGtleV9kaXNwbGF5KTsNCj4+ICt9
DQo+PiArRVhQT1JUX1NZTUJPTF9HUEwoY25fZGlzcGxheV9obGlzdCk7DQo+PiArDQo+PiBib29s
IGNuX3RhYmxlX2VtcHR5KHZvaWQpDQo+PiB7DQo+PiBzdHJ1Y3QgY25fZGV2ICpkZXYgPSAmY2Rl
djsNCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2Nvbm5lY3Rvci5oIGIvaW5jbHVkZS9s
aW51eC9jb25uZWN0b3IuaA0KPj4gaW5kZXggNTM4NGU0YmI5OGU4Li5hNzVjM2ZjZjE4MmEgMTAw
NjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2Nvbm5lY3Rvci5oDQo+PiArKysgYi9pbmNsdWRl
L2xpbnV4L2Nvbm5lY3Rvci5oDQo+PiBAQCAtMTY4LDQgKzE2OCw4IEBAIGludCBjbl9nZXRfZXh2
YWwocGlkX3QgcGlkKTsNCj4+IGJvb2wgY25fdGFibGVfZW1wdHkodm9pZCk7DQo+PiBib29sIGNu
X2hhc2hfdGFibGVfZW1wdHkoc3RydWN0IGNuX2hhc2hfZGV2ICpoZGV2KTsNCj4+IA0KPj4gK2lu
dCBjbl9kaXNwbGF5X2hsaXN0KHBpZF90IHBpZCwgaW50IG1heF9sZW4sIGludCAqaGtleSwgaW50
ICprZXlfZGlzcGxheSk7DQo+PiAraW50IGNuX2hhc2hfZGlzcGxheV9obGlzdChzdHJ1Y3QgY25f
aGFzaF9kZXYgKmhkZXYsIHBpZF90IHBpZCwgaW50IG1heF9sZW4sDQo+PiArIGludCAqaGtleSwg
aW50ICprZXlfZGlzcGxheSk7DQo+PiArDQo+PiAjZW5kaWYgLyogX19DT05ORUNUT1JfSCAqLw0K
Pj4gZGlmZiAtLWdpdCBhL2xpYi9LY29uZmlnLmRlYnVnIGIvbGliL0tjb25maWcuZGVidWcNCj4+
IGluZGV4IDczMTVmNjQzODE3YS4uMjkwY2YwYTZiZWZhIDEwMDY0NA0KPj4gLS0tIGEvbGliL0tj
b25maWcuZGVidWcNCj4+ICsrKyBiL2xpYi9LY29uZmlnLmRlYnVnDQo+PiBAQCAtMjcwNSw2ICsy
NzA1LDIzIEBAIGNvbmZpZyBIQVNIVEFCTEVfS1VOSVRfVEVTVA0KPj4gDQo+PiAgSWYgdW5zdXJl
LCBzYXkgTi4NCj4+IA0KPj4gK2NvbmZpZyBDTl9IQVNIX0tVTklUX1RFU1QNCj4+ICsgdHJpc3Rh
dGUgIktVbml0IFRlc3QgZm9yIGNvbm5lY3RvciBoYXNodGFibGUgY29kZSIgaWYgIUtVTklUX0FM
TF9URVNUUw0KPj4gKyBkZXBlbmRzIG9uIEtVTklUDQo+PiArIGRlZmF1bHQgS1VOSVRfQUxMX1RF
U1RTDQo+PiArIGhlbHANCj4+ICsgIFRoaXMgYnVpbGRzIHRoZSBoYXNodGFibGUgS1VuaXQgdGVz
dCBzdWl0ZS4NCj4+ICsgIEl0IHRlc3RzIHRoZSBiYXNpYyBmdW5jdGlvbmFsaXR5IG9mIHRoZSBB
UEkgZGVmaW5lZCBpbg0KPj4gKyAgZHJpdmVycy9jb25uZWN0b3IvY25faGFzaC5jLg0KPj4gKyAg
Q09ORklHX0NPTk5FQ1RPUj15LCBDT05GSUdfUFJPQ19FVkVOVFM9eSBhbmQgQ09ORklHX05FVD15
IG5lZWRzDQo+PiArICB0byBiZSBlbmFibGVkIGFsb25nIHdpdGggQ09ORklHX0NOX0hBU0hfS1VO
SVRfVEVTVD1tIGFuZA0KPj4gKyAgQ09ORklHX0tVTklUPW0gaW4gLmNvbmZpZyBmaWxlIHRvIGNv
bXBpbGUgYW5kIHRoZW4gdGVzdCBhcyBhIGtlcm5lbA0KPj4gKyAgbW9kdWxlIHdpdGggIm1vZHBy
b2JlIGNuX2hhc2hfdGVzdCIuDQo+PiArICBGb3IgbW9yZSBpbmZvcm1hdGlvbiBvbiBLVW5pdCBh
bmQgdW5pdCB0ZXN0cyBpbiBnZW5lcmFsIHBsZWFzZQ0KPj4gKyAgcmVmZXIgdG8gdGhlIEtVbml0
IGRvY3VtZW50YXRpb24gaW4gRG9jdW1lbnRhdGlvbi9kZXYtdG9vbHMva3VuaXQvLg0KPj4gKw0K
Pj4gKyAgSWYgdW5zdXJlLCBzYXkgTi4NCj4+ICsNCj4gDQo+IExvb2tzIGxpa2UgdGhpcyBuZWVk
cyB0byBkZXBlbmQgb24gQ09ORklHX0NPTk5FQ1RPUj8gT3RoZXJ3aXNlLCB0aGUNCj4gZXhpc3Rp
bmcga3VuaXQgdGVzdGVyIGNvbXBsYWlucyBhYm91dCB0aGUgbWlzc2luZyBzeW1ib2xzIChzZWUg
YmVsb3cpLg0KPiBQbGVhc2UgYWxzbyBob2xkIG9mZiByZXBvc3RpbmcgZm9yIGEgY291cGxlIG9m
IGRheXMgdG8gZ2l2ZSBwZW9wbGUgc29tZQ0KPiB0aW1lIHRvIHJldmlldy4NCj4gDQo+IEVSUk9S
OnJvb3Q6bGQ6IHZtbGludXgubzogaW4gZnVuY3Rpb24gYGNuX2hhc2hfdGVzdF9kdXBfZGVsJzoN
Cj4gY25faGFzaF90ZXN0LmM6KC50ZXh0KzB4M2U5ZGMzKTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0
byBgY25fZGVsX2dldF9leHZhbCcNCj4gbGQ6IGNuX2hhc2hfdGVzdC5jOigudGV4dCsweDNlOWRl
ZSk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGNuX2RlbF9nZXRfZXh2YWwnDQo+IGxkOiBjbl9o
YXNoX3Rlc3QuYzooLnRleHQrMHgzZTllMjIpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBjbl90
YWJsZV9lbXB0eScNCj4gbGQ6IHZtbGludXgubzogaW4gZnVuY3Rpb24gYGNuX2Rpc3BsYXlfaHRh
YmxlJzoNCj4gY25faGFzaF90ZXN0LmM6KC50ZXh0KzB4M2U5ZjY3KTogdW5kZWZpbmVkIHJlZmVy
ZW5jZSB0byBgY25fZGlzcGxheV9obGlzdCcNCj4gbGQ6IHZtbGludXgubzogaW4gZnVuY3Rpb24g
YGNuX2hhc2hfdGVzdF9kZWxfZ2V0X2V4dmFsJzoNCj4gY25faGFzaF90ZXN0LmM6KC50ZXh0KzB4
M2VhMDM3KTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgY25fZGVsX2dldF9leHZhbCcNCj4gbGQ6
IGNuX2hhc2hfdGVzdC5jOigudGV4dCsweDNlYTA4OCk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8g
YGNuX3RhYmxlX2VtcHR5Jw0KPiBsZDogdm1saW51eC5vOiBpbiBmdW5jdGlvbiBgY25faGFzaF90
ZXN0X2R1cF9hZGQnOg0KPiBjbl9oYXNoX3Rlc3QuYzooLnRleHQrMHgzZWExNzYpOiB1bmRlZmlu
ZWQgcmVmZXJlbmNlIHRvIGBjbl9hZGRfZWxlbScNCj4gbGQ6IGNuX2hhc2hfdGVzdC5jOigudGV4
dCsweDNlYTE5ZSk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGNuX2dldF9leHZhbCcNCj4gbGQ6
IGNuX2hhc2hfdGVzdC5jOigudGV4dCsweDNlYTFkYyk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8g
YGNuX2FkZF9lbGVtJw0KPiBsZDogY25faGFzaF90ZXN0LmM6KC50ZXh0KzB4M2VhMjA1KTogdW5k
ZWZpbmVkIHJlZmVyZW5jZSB0byBgY25fZ2V0X2V4dmFsJw0KPiBsZDogdm1saW51eC5vOiBpbiBm
dW5jdGlvbiBgY25faGFzaF90ZXN0X2RlbCc6DQo+IGNuX2hhc2hfdGVzdC5jOigudGV4dCsweDNl
YTM4Nyk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGNuX2RlbF9nZXRfZXh2YWwnDQo+IGxkOiBj
bl9oYXNoX3Rlc3QuYzooLnRleHQrMHgzZWEzYWIpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBj
bl9nZXRfZXh2YWwnDQo+IGxkOiBjbl9oYXNoX3Rlc3QuYzooLnRleHQrMHgzZWEzZmQpOiB1bmRl
ZmluZWQgcmVmZXJlbmNlIHRvIGBjbl90YWJsZV9lbXB0eScNCj4gbGQ6IHZtbGludXgubzogaW4g
ZnVuY3Rpb24gYGNuX2hhc2hfdGVzdF9hZGQnOg0KPiBjbl9oYXNoX3Rlc3QuYzooLnRleHQrMHgz
ZWE1NzEpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBjbl9hZGRfZWxlbScNCj4gbGQ6IGNuX2hh
c2hfdGVzdC5jOigudGV4dCsweDNlYTU5MSk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGNuX2dl
dF9leHZhbCcNCj4gbWFrZVszXTogKioqIFsuLi9zY3JpcHRzL01ha2VmaWxlLnZtbGludXg6MzQ6
IHZtbGludXhdIEVycm9yIDENCj4gbWFrZVsyXTogKioqIFsvaG9tZS9rdW5pdC90ZXN0aW5nL01h
a2VmaWxlOjExNjY6IHZtbGludXhdIEVycm9yIDINCj4gbWFrZVsxXTogKioqIFsvaG9tZS9rdW5p
dC90ZXN0aW5nL01ha2VmaWxlOjIyNDogX19zdWItbWFrZV0gRXJyb3IgMg0KPiBtYWtlOiAqKiog
W01ha2VmaWxlOjIyNDogX19zdWItbWFrZV0gRXJyb3IgMg0KDQpZZXMsIEkgaGF2ZSBhZGRlZCBp
biB0aGUgY29tbWVudHMgZm9yIENOX0hBU0hfS1VOSVRfVEVTVCwgaXQgZGVwZW5kcyBvbjoNCkNP
TkZJR19DT05ORUNUT1IsIENPTkZJR19QUk9DX0VWRU5UUywgQ09ORklHX05FVC4gSSBkaWRu4oCZ
dCByZWFsaXplDQpJIGNvdWxkIGFkZCB0aGVzZSB0byB0aGUg4oCcZGVwZW5kc+KAnSBmaWVsZC4N
ClNvIHNvbWV0aGluZyBsaWtlIHRoaXM6IChsZXQgbWUga25vdyBpZiB5b3Ugc2VlIGFueSBpc3N1
ZXMpDQoNCiAgICAgICAgdHJpc3RhdGUgIktVbml0IFRlc3QgZm9yIGNvbm5lY3RvciBoYXNodGFi
bGUgY29kZSIgaWYgIUtVTklUX0FMTF9URVNUUw0KICAgICAgICBkZXBlbmRzIG9uIEtVTklUDQor
ICAgICAgIGRlcGVuZHMgb24gQ09OTkVDVE9SICYmIFBST0NfRVZFTlRTDQorICAgICAgIGRlcGVu
ZHMgb24gTkVUDQogICAgICAgIGRlZmF1bHQgS1VOSVRfQUxMX1RFU1RTDQoNClRoZXNlIGFyZSB0
aGUgY29uZmlncyBJIGFkZCB0byBteSAuY29uZmlnIGZpbGUgYW5kIGNvbXBpbGUgaXQgYXMgYSBt
b2R1bGUgYW5kIHRoZW4NCmRvIG1vZHByb2JlIHRvIHRlc3QuDQpBcmUgeW91IHJ1bm5pbmcgdGhl
IGt1bml0IHRlc3RlciB3aXRoIGt1bml0LnB5Pw0KDQpUaGFua3MNCkFuamFsaQ0KDQo+IA0KPiAt
LS0NCj4gcHctYm90OiBjcg0KDQo=

