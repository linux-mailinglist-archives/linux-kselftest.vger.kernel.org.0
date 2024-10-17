Return-Path: <linux-kselftest+bounces-19971-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F3B9A2735
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 17:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 814871F218BC
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 15:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F6B1DEFFD;
	Thu, 17 Oct 2024 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IQlJPMnR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C9e87qek"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673CE1DEFD3;
	Thu, 17 Oct 2024 15:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179881; cv=fail; b=vCeLAz/vrbGwGLovwGUhL/JrEkBS2En0KzGu+863wZyz1P6pwNFAYZ1QtMV4MuVWJHrR+KVFxDNW9lfJ1n1tKi93QmRHuVbXYZy0CUy0Ey8jw0kOOFr8WEAQjxPfknM3B7QFCqMJqRdgdY8fLAO2/GvJi63eob1ywnJENvwtiTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179881; c=relaxed/simple;
	bh=r9x1DIQLUQHaxIivnCQUAXc4xb7bXzRCHf/ldwzLdOo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MIVHBc7RcM8QlVA9ktuQfZzD2fp/6YstxbM1YyoZxH/X9h/7F/i3WmP0UbJ0gpU2pJSUrIlhztfH89PD0/S17fKsAi8HPfiJzy0YPAG5fv93Ocv7rzFTj06o/lNKeNnR61u7o66nMPsCqHoGFZS7YxxJCxaEnlGpLel5kwCSUmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IQlJPMnR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C9e87qek; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFZ916004045;
	Thu, 17 Oct 2024 15:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=r9x1DIQLUQHaxIivnCQUAXc4xb7bXzRCHf/ldwzLdOo=; b=
	IQlJPMnRgj0LZLFE3ha72c2tydjKJBr598vOw5R8cbH1rfs7oaOW7zDBmFPWm0lG
	aC5hdUFqgHI0XVxC7Rx/n8mmsDiu2mK74XphLvC9shd8u3lz0aJt63VlWc7dNixn
	Ihm42mWbeBv6LDiJa4Hn3s9wJM1uFR5xp5dHsP8XtN14Mz4qy6rnvPGjy3DyPjY9
	WmI8ueOaJfNNjmqrgEQ8RV6d0i3q3SpiBewfAL9OG/5Se4B336rNLYJdffgatB7a
	FGCU/fYs1GhWeCFkT1TXe6JoW+9fVs4RymJy3e1V287U2kBlZceIRk7KGcilIZqk
	pFK/cfluU3SjKRtAuL8Nvg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1apjct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 15:44:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HEZttk019986;
	Thu, 17 Oct 2024 15:44:14 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjadwmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 15:44:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecnakx55chonyhpgBEVM6Bt+ky++6syg9sC0ft2aLOp0E5oOdIYKV1Pf+PbjJoVNXnIMWZIH/IZ+tz59/LnDWadfm4KMApb9YrYPmBL5PU6BTB+c8IcL+R+ehm3pDS6HtJuTCYfbtEdRZyu1CEXhWTAVlzeSOSmXJSO6SfSWFyNLhxCF4SJf/ctE1KREN9AzXi5AY5XjAhZDGPxfVEkW4yMaZDdbV1RDijkStVJS8itb1hX5samwdQ79akrLScmJr3+Nvxj92ZHuajid84VkuO0wVl+Hzge8SEJPlkHAT2tSFVeZbJ34CTiFdSQulbwAFX3vZ+RioewuJrt+AItgLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9x1DIQLUQHaxIivnCQUAXc4xb7bXzRCHf/ldwzLdOo=;
 b=GM0w3jjbO1H4goBKAAD/yYMmsJmCdp+gLf0bS3dxXDeMLCYcmKp3/OS4uG4IAVa4TIHibuePHkCg3ReBlG1bFQSEcMDh4P2eCkRNfHXqAat3jaTpz11NiUlNDqfKdrjNXPlHR1zlPOsx0l1sI8gl/JUxTXg03DiZro3NsUiUvzOJByTRWjHAWH9taCZLGrnI7Uwde42KX1vx+2MYzEetjNXumX88gPSgWMspWDVnsDvswpj2XgkhS1ijpGW5fWjCIh/SWQb1qcD2dr1q+zW1SaPr+ytFv8XB4SvtUlSlqnKUlHOIlGwx9wPcyZxjqR9Ia6dRtCdmQi/LzSWEX1qmcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9x1DIQLUQHaxIivnCQUAXc4xb7bXzRCHf/ldwzLdOo=;
 b=C9e87qekVILO8X8OzAFW/g2KbB2J54qt1Ca8QVharsRkOd9V5OySUxXZWAxQYq0g2g4X46+gsF8pRYOrSE2O7ONGalWTeVyxZZdHEmP5vlb7w2PdhzhBCVcBdw0UeNYWh+KfRLECNq04b1jALQ0WaYaGCR74X/9QP+pAo+UhJpo=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by CH3PR10MB7763.namprd10.prod.outlook.com (2603:10b6:610:1bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Thu, 17 Oct
 2024 15:43:20 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::3c5e:9043:1ca9:4c60]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::3c5e:9043:1ca9:4c60%5]) with mapi id 15.20.8069.018; Thu, 17 Oct 2024
 15:43:20 +0000
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
Subject: Re: [PATCH net-next v4 1/3] connector/cn_proc: Add hash table for
 threads
Thread-Topic: [PATCH net-next v4 1/3] connector/cn_proc: Add hash table for
 threads
Thread-Index: AQHbICtJTROHAzZbpUCRnpsa78WWprKLEPYAgAAFO4A=
Date: Thu, 17 Oct 2024 15:43:19 +0000
Message-ID: <8B104F28-3DD6-412F-B8D1-0120033890A4@oracle.com>
References: <20241017002652.1474358-1-anjali.k.kulkarni@oracle.com>
 <20241017002652.1474358-2-anjali.k.kulkarni@oracle.com>
 <ZxEsKmvJKe8Z3QUs@mini-arch>
In-Reply-To: <ZxEsKmvJKe8Z3QUs@mini-arch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|CH3PR10MB7763:EE_
x-ms-office365-filtering-correlation-id: 368ec3a2-d7a1-4dea-706c-08dceec26cff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dmh0a0YrQmhhQXpXakVMZm5VQlN1VWUzaFp0cjBwcituTmp1L1M2amRZOXUr?=
 =?utf-8?B?R3VUZDYrbWhHWHV5blBMZE5hL1ZhYnlrMVVxaFJLbDR3QnE4OFM1aUVsTWtD?=
 =?utf-8?B?L0dtU3FLTEhjWHZ4czZEUGU4Z29ya3VIVlFheUdvSENBeHZuNzRGRVBVQUd1?=
 =?utf-8?B?K1lJQ0poUU5OSkZMbGV1aWxyNGdocENZaGh2azdxdFk1aVZ5M1QxZzR0WWhH?=
 =?utf-8?B?d1QzZS9NTmR3VGNxZkhDc005eUFhTllhamV2a2haSUtaSGFOUml3L2RoUVRq?=
 =?utf-8?B?ajZDNENyTVFLQmlib0xsUXZrTzR5UXVlemJaQ1krb3VIWGN1R04vY3pwM3ZB?=
 =?utf-8?B?YjZldGdOUGtLWUhveStFakIrYlJRTnFteDVSalVoSmE5M0tKVDY0a0lvMVVk?=
 =?utf-8?B?dzZVTktTa2ZPMWttMkovVCtrM3dPZVhtWGVCWDhWSlRBTXIyK0liQ3AvVWpT?=
 =?utf-8?B?c291aHJCb0dKRHZhQUZackJmNkdKekFoZVBBOGFYRVN5WGlxNnJLb1ZqaHJl?=
 =?utf-8?B?K1lpMVZNUGtmUnBoQWxOa0dWcHB2MkF2Y0Z1MnZXdFgzaVF4QmF3bXdvb0w2?=
 =?utf-8?B?czBxRFpGMzdjYlQ3SjhLcFJPYUhUSUtmcUtLVGlJU3F5U2NWZzJmV01YcmxN?=
 =?utf-8?B?WDdSZldLYVNrOHVkOEFFblY5SWFrOEpGWHNyTk9BeTdJQ2lTZ0g2c1Rkd1ZF?=
 =?utf-8?B?dXBKRDR2MUNEeHFHZU11RFl3L3NIeFhVbXVKOU8wUnFxU1JZalpVclZjT2p5?=
 =?utf-8?B?N3BWVGlmbmFlYmd4ZU04NTI4VWR6enhXd1hMZDc5dTN0MWx0aGFXdnlkdjh4?=
 =?utf-8?B?Tm5DVE5WQjQ3NDR3Z1NMcE9rcG8wcGFmaWlnejBzNm4xbGFXSmJXdTFzQW14?=
 =?utf-8?B?QTlSL1lhNWsybVhTUkYvQ2VjQnhBTFpmZHlOMjMvL3VGUnE5SU50SDV0eWNR?=
 =?utf-8?B?NFlBYm9VNDJiVDkwRkhyYk1OSFh0aDEzZmhqQkZxbEhvQlQrLzZRQWs3WXFm?=
 =?utf-8?B?UTF1Z3psaFpVMldscThVeDI2aHhwSVI3OUkxWnJtTXdyN0I2Q2dDY3Z5M2VE?=
 =?utf-8?B?TVh1MkRPZ3kvbUVXeEJ1bWp0Z2p5RTRjMnJvZWQ2M0JwajNabklOMWpYRFp5?=
 =?utf-8?B?ZzhyWnJXeERBWjhuSzBPM1c3WmFJMTIzQWN0ckpyTVJaRDZtWEIyNTVOanBp?=
 =?utf-8?B?S1ZHdnVFUk5vMHZXd0JtNkJLNEoveGR5SjFQcFVldmxCNmdzdGdmRGdOLzBk?=
 =?utf-8?B?bG8xT0g4TnFMaTB4RDZQeHAzV1RDb2Rwd21wcTQ1ZXV2aVYraE1zay9zb1FS?=
 =?utf-8?B?U1hRS292NHFoaUtyQUg3cmFPUzVIejdYUjZKN1hBdTJScDdNWW11c1BZNnN5?=
 =?utf-8?B?dkJKL2g2WmhBck1SY2c2UnQ2bEsyQXhiMm0vcVpkSDFCNEkzcE5YeFpVSVls?=
 =?utf-8?B?eTJibFRTMHY5NktWWDN0NjZMb3lUVTNaSkUyam5CajA1MnJnSWRFN1hTazN2?=
 =?utf-8?B?bEl3Qk56Y3lYZzg2STNaZ2lNRklJaEE1Ly81TlJlaHdCcFAwZEdRVGF6ajJG?=
 =?utf-8?B?RGhsZlJxMHZ0SEFIMmdkMi94amxBdmxwNVl1Rmx3WStDV2szLzRJY1RxeC9W?=
 =?utf-8?B?M0RPa1BjdG12ejdSanBjbGZRZFBsUitPQTZ5Y01LL3pLZDZJdFkwTnQ2RXBJ?=
 =?utf-8?B?SXhMYlQ3UEdFUzFyQlpkc0h3L0I2bVZibFhrT0dzeGZDb29IaUZpQmE2U2di?=
 =?utf-8?B?SkZpTlF0ems5NnM0WGYzb2ozVVRONWVQMi9ZN0I2S1NvSG5VOXdETnJCMzNy?=
 =?utf-8?Q?ktN2DbALcmxUmUQ3C6rW+KPphCMF22IHV98o4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b3JyK0FLZHdvRnJBclhEUWtoRmNQdkFPRTdicFVlbGpNT21MVTdtR3B1RHo3?=
 =?utf-8?B?ZXpTM1ppbjRFTS9scE5kK1FobnlFWTgyUGJoK2dwQUI3aHNOeWpGUm5SUWQ5?=
 =?utf-8?B?QnlTSi9PRGh5MHQwcU41MFZQU1QrVVdteUpISmszaFRMdk9QTURUNzRrbUV1?=
 =?utf-8?B?c3kvTDhmY1JnZ3lIZ2JOd2I2WE1PSlBwMkwzczhGZVdlWFA3SWhERzNQcWo4?=
 =?utf-8?B?Rm1uL0JDTUcxQTdSaVZIdks3dkhvQXJIRENhRTlpUWhnT1B0dDRjZEdSMVE2?=
 =?utf-8?B?OHhIY1k2YlM2bDlZa3hia1JkVWRXellybkdMeXhqd2orNys4MVBZYUNOMnUv?=
 =?utf-8?B?SHMrVjlmeHA2N0Y5Ry8rSXVzN1diczl5ZUZvRGZ3SXRZbWxZeTR2U3UwOUVy?=
 =?utf-8?B?V1FyY1N1VkNqVDRwblJFSWZlVTZoNTFGQTlJMzRwSVU0bzNFdEZ1U0E5RkFR?=
 =?utf-8?B?UEdUSXFLM1FKNVhuZVU0N01pcW0vY1hYb1FMaFVvMGdYQXFZQmlQb3MvQlRw?=
 =?utf-8?B?alRmKzZQQnF4RGFVb2Y3TEl4WTRqTGx2dXRZSVh5cjhlN2FqK1dLVTBMT3Vj?=
 =?utf-8?B?MXNwSlc5ZlNUSU1BMjV6Y1JtZ2hMbmJRWDhzeVI4Q2dRblpFaWNGRHFHRXdm?=
 =?utf-8?B?WEZmd1RPT3NJNGJBMmRkRHBVaE9XUWk0N0hmbWFHaTA5c2NVb0R3VVE4VTQ5?=
 =?utf-8?B?cjUwRUN6Y3d3VFdEQjREbUozVitHQXBoN0ptdzBIOXV0ZG9LUGdUZEFzTjZl?=
 =?utf-8?B?S2VuRE9QdUdOdEk1WldTSUl1KzhrblIwUUU2Sjc4N0l3YUlyV2ZQbEJ4WmY2?=
 =?utf-8?B?YjNzc1ZCV0E2OFdCR3g4YjY4emUrNXg5K25pYVA3WEl2dnd1bE8yZ29sZVQw?=
 =?utf-8?B?ckcyUmt5N3FHYmdueHBVY2d6RVI5Zys4VlhqZTJHQ1ZXSEVQN3FoOHVVMHgr?=
 =?utf-8?B?NEJDbmxjN0hJcWZCRnFoTjBEazVZRDUyV0VjVjNmM0VBRy9QdHUrMkY1UGN1?=
 =?utf-8?B?Q3o5VlF5MTU5MjNtN2tybDl1RjJtZzBGaXhlRTcxMEp5ZzRLVmhhcElIMUlU?=
 =?utf-8?B?WHpOS3ROK045dzRMSUxUajA5RERFZVNxRVQxemVwSVF4VFh5QjlGVFgva0li?=
 =?utf-8?B?MGdZUWEvbzdYd3Q2OU1HbDhZQjJyNmVFV2VBbG1zaStnTWNCaVVRUkJvcnE3?=
 =?utf-8?B?SE1aWCtucXo4N0JsK2tGbHJXdjR5dmJVUVBVbE5MS3FYNlVZRUo0YXF6VVNV?=
 =?utf-8?B?a1JQbmdEemxYOE14UkxTT1QzaEkybkRzb0xBUW56eVZveVpXMHNWdU8vd1hW?=
 =?utf-8?B?OGRJbHRBRU16b3I3WktUVGRpTnlsc0RxVjFEWlRIUW9tcmVtdGhFYmVQY3gw?=
 =?utf-8?B?L3QxNG12cjVjY2ZYbTNqWS8yU0x6MUVoT2Mvb29iQk4wYU9Mc0FDdEJNMXR4?=
 =?utf-8?B?R3ExQzNnYVZFR0FxcTFCYUplQjgySE5udDBObXh5MFZOL1hERWcvYUcvcFF2?=
 =?utf-8?B?OXcyeElSQmpsRzRCYmxjUWRtejQ2d3lWR2F6Y1NpOUdnK3hoRUU0VFJhTE93?=
 =?utf-8?B?L3M2YU9iS1BBTjFrNGkzbm11N25FVi9YTzhSU0V2dlpaVjZsOU1uWm1KYUxU?=
 =?utf-8?B?eUx6ZVptWEFocjFmTVhza1dlL3gwa2gzV3Jkek54d0ZnU1F1RVNzZThiQTJ4?=
 =?utf-8?B?RzF3cXJCdk5pWU9WdGlYSlZ4akIyRWZUR1BBaDR5WmFkemlpWGk1Zjlhbm1z?=
 =?utf-8?B?WGVVeWZKNlVKdm5VZ2hrRmsrMWdvUytjSjdqQnVKUEhrclhuQWFvUEduaElS?=
 =?utf-8?B?Y1IrYXMyNU9CSHR3N1JMZjIyQVFuc3IwLzBvbTFBZXhmNU5HVHdLU0lTMWhz?=
 =?utf-8?B?Nnp1RTFZeTR0SmJ3TzFnVFhuL0hEbERUcUhmOWsya0s1T1dhVTFIS3N5a1Rk?=
 =?utf-8?B?K1MwQjlScmZra2V1RlJVNjJQV3VMRHhZQW9EVzM5dHpydVFHcG82OExEV1N1?=
 =?utf-8?B?ZldpVDdhdkZpNnBTaWVLaXJOaTNVbXlWS1lDeHRMSEZTcWFzY3JMdS9yaXMz?=
 =?utf-8?B?dGZ1Z0dIRHI3WTdIazA3Sm10TThucEFSdXR5RHdMK2tzbm10cEt2SFFZdVdF?=
 =?utf-8?B?SytYclJzcjVvbXY5VGg3OGNOenk4L2hZOFhxYjlkcXE3NmJqUEJrazBIMmxs?=
 =?utf-8?Q?KTYobcq5rVRwjPDkGBRUMkwj8oJBLWgFhGpi9UTiZZ+G?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <583FF7F240A6244AAF64A76D1A0515DF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bOYRgcD1wMmmvJrJZOT61CiuFG1v0OzDFV16E9A64tTRBopk2p75WFg+5cA2sUeNywmlw+wDaGrzEcD7Cc0j68nUF8HGB1ly2ALfWp/7ZppNLrOtqQz/gyEU17hSF0/Tp04br7JgUbYCANIItvb5aAwzNjBIpJ+r6zAHvdsos38DtRwjCkbeEoItStH+UfAiIJoDXedS9h0RNvRBMgA5mk4FmXU6w8nhuBmJ8HAJrEcHFTgSaRD28c4u7vX/OmxIA1yYC0NM4j1bBFfauOmmZTA07Fj98aP3oCagQTDGuV5gP6Xj0hgFCD4mBQAIVLiap/27BYk4HyE4ZAhKmiuP0hmrx9rYWx4Sor6JRI1Xmw6JP7+TacjluweyTPFJ3IKguK8EHWTZ8u51LlBQ3StdVsKGCoXypEnytpPD0aFefhT4CiwrbJMsHYgf7pQWzrfKP2+bt4PPd1K3sT9iGQcaLVf33a4xTRaV/IFVvUaKCjhQcMr4ZvK1zkOr6ChWpNzMc8jjAq1aZ/vAf61hfnA5QTSH57WePMaQ3vin6XoYB3Zuwvts1bqN4LTJYyvDougUi3xOWT3S02YRk4S/9Oa+Hp0iSIwH4EQZbDR86BtdXc0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 368ec3a2-d7a1-4dea-706c-08dceec26cff
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 15:43:19.9146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3kZ6CF7WtVVKXOkLdJ/Ff7SQd9VyZeXbhzgWxLPpZgxj90Go/KBHOWkTrytKQW5PkPZcncRkpaQoEZwuaaU1V+ihwOVpj43MX3iI/lgQowo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_18,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170109
X-Proofpoint-GUID: 9LcQCZU9JNWwN4DU_rmX-bHHksNDMLFt
X-Proofpoint-ORIG-GUID: 9LcQCZU9JNWwN4DU_rmX-bHHksNDMLFt

DQoNCj4gT24gT2N0IDE3LCAyMDI0LCBhdCA4OjI04oCvQU0sIFN0YW5pc2xhdiBGb21pY2hldiA8
c3Rmb21pY2hldkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gMTAvMTYsIEFuamFsaSBLdWxr
YXJuaSB3cm90ZToNCj4+IEFkZCBhIG5ldyB0eXBlIFBST0NfQ05fTUNBU1RfTk9USUZZIHRvIHBy
b2MgY29ubmVjdG9yIEFQSSwgd2hpY2ggYWxsb3dzIGENCj4+IHRocmVhZCB0byBub3RpZnkgdGhl
IGtlcm5lbCB0aGF0IGlzIGdvaW5nIHRvIGV4aXQgd2l0aCBhIG5vbi16ZXJvIGV4aXQNCj4+IGNv
ZGUgYW5kIHNwZWNpZnkgdGhlIGV4aXQgY29kZSBpbiBpdC4gV2hlbiB0aHJlYWQgZXhpdHMgaW4g
dGhlIGtlcm5lbCwNCj4+IGl0IHdpbGwgc2VuZCB0aGlzIGV4aXQgY29kZSBhcyBhIHByb2MgZmls
dGVyIG5vdGlmaWNhdGlvbiB0byBhbnkNCj4+IGxpc3RlbmluZyBwcm9jZXNzLg0KPj4gRXhpdGlu
ZyB0aHJlYWQgY2FuIGNhbGwgdGhpcyBlaXRoZXIgd2hlbiBpdCB3YW50cyB0byBjYWxsIHB0aHJl
YWRfZXhpdCgpDQo+PiB3aXRoIG5vbi16ZXJvIHZhbHVlIG9yIGZyb20gc2lnbmFsIGhhbmRsZXIu
DQo+PiANCj4+IEFkZCBhIG5ldyBmaWxlIGNuX2hhc2guYyB3aGljaCBpbXBsZW1lbnRzIGEgaGFz
aCB0YWJsZSBzdG9yaW5nIHRoZSBleGl0DQo+PiBjb2RlcyBvZiBhYm5vcm1hbGx5IGV4aXRpbmcg
dGhyZWFkcywgcmVjZWl2ZWQgYnkgdGhlIHN5c3RlbSBjYWxsIGFib3ZlLg0KPj4gVGhlIGtleSB1
c2VkIGZvciB0aGUgaGFzaCB0YWJsZSBpcyB0aGUgcGlkIG9mIHRoZSB0aHJlYWQsIHNvIHdoZW4g
dGhlDQo+PiB0aHJlYWQgYWN0dWFsbHkgZXhpdHMsIHdlIGxvb2t1cCBpdCdzIHBpZCBpbiB0aGUg
aGFzaCB0YWJsZSBhbmQgcmV0cmlldmUNCj4+IHRoZSBleGl0IGNvZGUgc2VudCBieSB1c2VyLiBJ
ZiB0aGUgZXhpdCBjb2RlIGluIHN0cnVjdCB0YXNrIGlzIDAsIHdlDQo+PiB0aGVuIHJlcGxhY2Ug
aXQgd2l0aCB0aGUgdXNlciBzdXBwbGllZCBub24temVybyBleGl0IGNvZGUuDQo+PiANCj4+IGNu
X2hhc2guYyBpbXBsZW1lbnRzIHRoZSBoYXNoIHRhYmxlIGFkZCwgZGVsZXRlLCBsb29rdXAgb3Bl
cmF0aW9ucy4NCj4+IG11dGV4X2xvY2soKSBhbmQgbXV0ZXhfdW5sb2NrKCkgb3BlcmF0aW9ucyBh
cmUgdXNlZCB0byBzYWZlZ3VhcmQgdGhlDQo+PiBpbnRlZ3JpdHkgb2YgdGhlIGhhc2ggdGFibGUg
d2hpbGUgYWRkaW5nIG9yIGRlbGV0aW5nIGVsZW1lbnRzLg0KPj4gY29ubmVjdG9yLmMgaGFzIHRo
ZSBBUEkgY2FsbHMsIGNhbGxlZCBmcm9tIGNuX3Byb2MuYywgYXMgd2VsbCBhcyBjYWxscw0KPj4g
dG8gYWxsb2NhdGUsIGluaXRpYWxpemUgYW5kIGZyZWUgdGhlIGhhc2ggdGFibGUuDQo+PiANCj4+
IEFkZCBhIG5ldyBmbGFnIGluIFBGXyogZmxhZ3Mgb2YgdGFza19zdHJ1Y3QgLSBFWElUX05PVElG
WS4gVGhpcyBmbGFnIGlzDQo+PiBzZXQgd2hlbiB1c2VyIHNlbmRzIHRoZSBleGl0IGNvZGUgdmlh
IFBST0NfQ05fTUNBU1RfTk9USUZZLiBXaGlsZQ0KPj4gZXhpdGluZywgdGhpcyBmbGFnIGlzIGNo
ZWNrZWQgYW5kIHRoZSBoYXNoIHRhYmxlIGFkZCBvciBkZWxldGUgY2FsbHMNCj4+IGFyZSBvbmx5
IG1hZGUgaWYgdGhpcyBmbGFnIGlzIHNldC4NCj4+IA0KPj4gQSByZWZjb3VudCBmaWVsZCBocmVm
Y250IGlzIGFkZGVkIGluIHN0cnVjdCBjbl9oYXNoX2RldiwgdG8ga2VlcCB0cmFjaw0KPj4gb2Yg
bnVtYmVyIG9mIHRocmVhZHMgd2hpY2ggaGF2ZSBhZGRlZCBhbiBlbnRyeSBpbiBoYXNoIHRhYmxl
LiBCZWZvcmUNCj4+IGZyZWVpbmcgdGhlIHN0cnVjdCBjbl9oYXNoX2RldiwgdGhpcyB2YWx1ZSBt
dXN0IGJlIDAuDQo+PiBUaGlzIHJlZmNudCBjaGVjayBpcyBhZGRlZCBpbiBjYXNlIENPTkZJR19D
T05ORUNUT1IgaXMgY29tcGlsZWQgYXMgYQ0KPj4gbW9kdWxlLiBJbiB0aGF0IGNhc2UsIHdoZW4g
dW5sb2FkaW5nIHRoZSBtb2R1bGUsIHdlIG5lZWQgdG8gbWFrZSBzdXJlDQo+PiBubyBoYXNoIGVu
dHJpZXMgYXJlIHN0aWxsIHByZXNlbnQgaW4gdGhlIGhkZXYgdGFibGUuDQo+PiANCj4+IENvcHkg
dGhlIHRhc2sncyBuYW1lICh0YXNrLT5jb21tKSBpbnRvIHRoZSBleGl0IGV2ZW50IG5vdGlmaWNh
dGlvbi4NCj4+IFRoaXMgd2lsbCBhbGxvdyBhcHBsaWNhdGlvbnMgdG8gZmlsdGVyIG9uIHRoZSBu
YW1lIGZ1cnRoZXIgdXNpbmcNCj4+IHVzZXJzcGFjZSBmaWx0ZXJpbmcgbGlrZSBlYnBmLg0KPj4g
DQo+PiBTaWduZWQtb2ZmLWJ5OiBBbmphbGkgS3Vsa2FybmkgPGFuamFsaS5rLmt1bGthcm5pQG9y
YWNsZS5jb20+DQo+PiAtLS0NCj4+IGRyaXZlcnMvY29ubmVjdG9yL01ha2VmaWxlICAgIHwgICAy
ICstDQo+PiBkcml2ZXJzL2Nvbm5lY3Rvci9jbl9oYXNoLmMgICB8IDE4MSArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+PiBkcml2ZXJzL2Nvbm5lY3Rvci9jbl9wcm9jLmMgICB8
ICA2MiArKysrKysrKysrKy0NCj4+IGRyaXZlcnMvY29ubmVjdG9yL2Nvbm5lY3Rvci5jIHwgIDYz
ICsrKysrKysrKysrLQ0KPj4gaW5jbHVkZS9saW51eC9jb25uZWN0b3IuaCAgICAgfCAgMzEgKysr
KysrDQo+PiBpbmNsdWRlL2xpbnV4L3NjaGVkLmggICAgICAgICB8ICAgMiArLQ0KPj4gaW5jbHVk
ZS91YXBpL2xpbnV4L2NuX3Byb2MuaCAgfCAgIDUgKy0NCj4+IDcgZmlsZXMgY2hhbmdlZCwgMzM4
IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+PiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy9jb25uZWN0b3IvY25faGFzaC5jDQo+PiANCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nv
bm5lY3Rvci9NYWtlZmlsZSBiL2RyaXZlcnMvY29ubmVjdG9yL01ha2VmaWxlDQo+PiBpbmRleCAx
YmY2N2QzZGY5N2QuLmNiMWRjZGYwNjdhZCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvY29ubmVj
dG9yL01ha2VmaWxlDQo+PiArKysgYi9kcml2ZXJzL2Nvbm5lY3Rvci9NYWtlZmlsZQ0KPj4gQEAg
LTIsNCArMiw0IEBADQo+PiBvYmotJChDT05GSUdfQ09OTkVDVE9SKSArPSBjbi5vDQo+PiBvYmot
JChDT05GSUdfUFJPQ19FVkVOVFMpICs9IGNuX3Byb2Mubw0KPj4gDQo+PiAtY24teSArPSBjbl9x
dWV1ZS5vIGNvbm5lY3Rvci5vDQo+PiArY24teSArPSBjbl9oYXNoLm8gY25fcXVldWUubyBjb25u
ZWN0b3Iubw0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY29ubmVjdG9yL2NuX2hhc2guYyBiL2Ry
aXZlcnMvY29ubmVjdG9yL2NuX2hhc2guYw0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGlu
ZGV4IDAwMDAwMDAwMDAwMC4uYTA3OWU5YmNlYTZkDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysg
Yi9kcml2ZXJzL2Nvbm5lY3Rvci9jbl9oYXNoLmMNCj4+IEBAIC0wLDAgKzEsMTgxIEBADQo+PiAr
Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQ0KPj4gKy8qDQo+PiArICog
QXV0aG9yOiBBbmphbGkgS3Vsa2FybmkgPGFuamFsaS5rLmt1bGthcm5pQG9yYWNsZS5jb20+DQo+
PiArICoNCj4+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjQgT3JhY2xlIGFuZC9vciBpdHMgYWZmaWxp
YXRlcy4NCj4+ICsgKi8NCj4+ICsNCj4+ICsjaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQo+PiAr
I2luY2x1ZGUgPGxpbnV4L2luaXQuaD4NCj4+ICsjaW5jbHVkZSA8bGludXgvY29ubmVjdG9yLmg+
DQo+PiArI2luY2x1ZGUgPGxpbnV4L211dGV4Lmg+DQo+PiArI2luY2x1ZGUgPGxpbnV4L3BpZF9u
YW1lc3BhY2UuaD4NCj4+ICsNCj4+ICsjaW5jbHVkZSA8bGludXgvY25fcHJvYy5oPg0KPj4gKw0K
Pj4gK3N0cnVjdCBjbl9oYXNoX2RldiAqY25faGFzaF9hbGxvY19kZXYoY29uc3QgY2hhciAqbmFt
ZSkNCj4+ICt7DQo+PiArIHN0cnVjdCBjbl9oYXNoX2RldiAqaGRldjsNCj4+ICsNCj4+ICsgaGRl
diA9IGt6YWxsb2Moc2l6ZW9mKCpoZGV2KSwgR0ZQX0tFUk5FTCk7DQo+PiArIGlmICghaGRldikN
Cj4+ICsgcmV0dXJuIE5VTEw7DQo+PiArDQo+PiArIHNucHJpbnRmKGhkZXYtPm5hbWUsIHNpemVv
ZihoZGV2LT5uYW1lKSwgIiVzIiwgbmFtZSk7DQo+PiArIGF0b21pY19zZXQoJmhkZXYtPmhyZWZj
bnQsIDApOw0KPj4gKyBtdXRleF9pbml0KCZoZGV2LT51ZXhpdF9oYXNoX2xvY2spOw0KPj4gKyBo
YXNoX2luaXQoaGRldi0+dWV4aXRfcGlkX2h0YWJsZSk7DQo+PiArIHJldHVybiBoZGV2Ow0KPj4g
K30NCj4+ICsNCj4+ICt2b2lkIGNuX2hhc2hfZnJlZV9kZXYoc3RydWN0IGNuX2hhc2hfZGV2ICpo
ZGV2KQ0KPj4gK3sNCj4+ICsgc3RydWN0IHVleGl0X3BpZF9obm9kZSAqaG5vZGU7DQo+PiArIHN0
cnVjdCBobGlzdF9ub2RlICp0bXA7DQo+PiArIGludCBidWNrZXQ7DQo+PiArDQo+PiArIHByX2Rl
YnVnKCIlczogRnJlZWluZyBlbnRpcmUgaGRldiAlcFxuIiwgX19mdW5jX18sIGhkZXYpOw0KPj4g
Kw0KPj4gKyBtdXRleF9sb2NrKCZoZGV2LT51ZXhpdF9oYXNoX2xvY2spOw0KPj4gKyBoYXNoX2Zv
cl9lYWNoX3NhZmUoaGRldi0+dWV4aXRfcGlkX2h0YWJsZSwgYnVja2V0LCB0bXAsDQo+PiArIGhu
b2RlLCB1ZXhpdF9waWRfaGxpc3QpIHsNCj4+ICsgaGFzaF9kZWwoJmhub2RlLT51ZXhpdF9waWRf
aGxpc3QpOw0KPj4gKyBwcl9kZWJ1ZygiJXM6IEZyZWVpbmcgbm9kZSBmb3IgcGlkICVkXG4iLA0K
Pj4gKyBfX2Z1bmNfXywgaG5vZGUtPnBpZCk7DQo+PiArIGtmcmVlKGhub2RlKTsNCj4+ICsgfQ0K
Pj4gKw0KPj4gKyBtdXRleF91bmxvY2soJmhkZXYtPnVleGl0X2hhc2hfbG9jayk7DQo+PiArIG11
dGV4X2Rlc3Ryb3koJmhkZXYtPnVleGl0X2hhc2hfbG9jayk7DQo+PiArDQo+PiArIC8qDQo+PiAr
ICAqIFRoaXMgcmVmY250IGNoZWNrIGlzIGFkZGVkIGluIGNhc2UgQ09ORklHX0NPTk5FQ1RPUiBp
cw0KPj4gKyAgKiBjb21waWxlZCB3aXRoID1tIGFzIGEgbW9kdWxlLiBJbiB0aGF0IGNhc2UsIHdo
ZW4gdW5sb2FkaW5nDQo+PiArICAqIHRoZSBtb2R1bGUsIHdlIG5lZWQgdG8gbWFrZSBzdXJlIG5v
IGhhc2ggZW50cmllcyBhcmUgc3RpbGwNCj4+ICsgICogcHJlc2VudCBpbiB0aGUgaGRldiB0YWJs
ZS4NCj4+ICsgICovDQo+PiArIHdoaWxlIChhdG9taWNfcmVhZCgmaGRldi0+aHJlZmNudCkpIHsN
Cj4+ICsgcHJfaW5mbygiV2FpdGluZyBmb3IgJXMgdG8gYmVjb21lIGZyZWU6IHJlZmNudD0lZFxu
IiwNCj4+ICsgaGRldi0+bmFtZSwgYXRvbWljX3JlYWQoJmhkZXYtPmhyZWZjbnQpKTsNCj4+ICsg
bXNsZWVwKDEwMDApOw0KPj4gKyB9DQo+PiArDQo+PiArIGtmcmVlKGhkZXYpOw0KPj4gKyBoZGV2
ID0gTlVMTDsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIHN0cnVjdCB1ZXhpdF9waWRfaG5vZGUg
KmNuX2hhc2hfYWxsb2NfZWxlbShfX3UzMiB1ZXhpdF9jb2RlLCBwaWRfdCBwaWQpDQo+PiArew0K
Pj4gKyBzdHJ1Y3QgdWV4aXRfcGlkX2hub2RlICplbGVtOw0KPj4gKw0KPj4gKyBlbGVtID0ga3ph
bGxvYyhzaXplb2YoKmVsZW0pLCBHRlBfS0VSTkVMKTsNCj4+ICsgaWYgKCFlbGVtKQ0KPj4gKyBy
ZXR1cm4gTlVMTDsNCj4+ICsNCj4+ICsgSU5JVF9ITElTVF9OT0RFKCZlbGVtLT51ZXhpdF9waWRf
aGxpc3QpOw0KPj4gKyBlbGVtLT51ZXhpdF9jb2RlID0gdWV4aXRfY29kZTsNCj4+ICsgZWxlbS0+
cGlkID0gcGlkOw0KPj4gKyByZXR1cm4gZWxlbTsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIGlu
bGluZSB2b2lkIGNuX2hhc2hfZnJlZV9lbGVtKHN0cnVjdCB1ZXhpdF9waWRfaG5vZGUgKmVsZW0p
DQo+PiArew0KPj4gKyBrZnJlZShlbGVtKTsNCj4+ICt9DQo+PiArDQo+PiAraW50IGNuX2hhc2hf
YWRkX2VsZW0oc3RydWN0IGNuX2hhc2hfZGV2ICpoZGV2LCBfX3UzMiB1ZXhpdF9jb2RlLCBwaWRf
dCBwaWQpDQo+PiArew0KPj4gKyBzdHJ1Y3QgdWV4aXRfcGlkX2hub2RlICplbGVtLCAqaG5vZGU7
DQo+PiArDQo+PiArIGVsZW0gPSBjbl9oYXNoX2FsbG9jX2VsZW0odWV4aXRfY29kZSwgcGlkKTsN
Cj4+ICsgaWYgKCFlbGVtKSB7DQo+PiArIHByX2VycigiJXM6IGNuX2hhc2hfYWxsb2NfZWxlbSgp
IHJldHVybmVkIE5VTEwgcGlkICVkXG4iLA0KPj4gKyBfX2Z1bmNfXywgcGlkKTsNCj4+ICsgcmV0
dXJuIC1FTk9NRU07DQo+PiArIH0NCj4+ICsNCj4+ICsgbXV0ZXhfbG9jaygmaGRldi0+dWV4aXRf
aGFzaF9sb2NrKTsNCj4+ICsgLyoNCj4+ICsgICogQ2hlY2sgaWYgYW4gZW50cnkgZm9yIHRoZSBz
YW1lIHBpZCBhbHJlYWR5IGV4aXN0cw0KPj4gKyAgKi8NCj4+ICsgaGFzaF9mb3JfZWFjaF9wb3Nz
aWJsZShoZGV2LT51ZXhpdF9waWRfaHRhYmxlLA0KPj4gKyBobm9kZSwgdWV4aXRfcGlkX2hsaXN0
LCBwaWQpIHsNCj4+ICsgaWYgKGhub2RlLT5waWQgPT0gcGlkKSB7DQo+PiArIG11dGV4X3VubG9j
aygmaGRldi0+dWV4aXRfaGFzaF9sb2NrKTsNCj4+ICsgY25faGFzaF9mcmVlX2VsZW0oZWxlbSk7
DQo+PiArIHByX2RlYnVnKCIlczogcGlkICVkIGFscmVhZHkgZXhpc3RzIGluIGhhc2ggdGFibGVc
biIsDQo+PiArIF9fZnVuY19fLCBwaWQpOw0KPj4gKyByZXR1cm4gLUVFWElTVDsNCj4+ICsgfQ0K
Pj4gKyB9DQo+PiArDQo+PiArIGhhc2hfYWRkKGhkZXYtPnVleGl0X3BpZF9odGFibGUsICZlbGVt
LT51ZXhpdF9waWRfaGxpc3QsIHBpZCk7DQo+PiArIG11dGV4X3VubG9jaygmaGRldi0+dWV4aXRf
aGFzaF9sb2NrKTsNCj4+ICsNCj4+ICsgYXRvbWljX2luYygmaGRldi0+aHJlZmNudCk7DQo+PiAr
DQo+PiArIHByX2RlYnVnKCIlczogQWZ0ZXIgaGFzaF9hZGQgb2YgcGlkICVkIGVsZW0gJXAgaHJl
ZmNudCAlZFxuIiwNCj4+ICsgX19mdW5jX18sIHBpZCwgZWxlbSwgYXRvbWljX3JlYWQoJmhkZXYt
PmhyZWZjbnQpKTsNCj4+ICsgcmV0dXJuIDA7DQo+PiArfQ0KPj4gKw0KPj4gK2ludCBjbl9oYXNo
X2RlbF9nZXRfZXh2YWwoc3RydWN0IGNuX2hhc2hfZGV2ICpoZGV2LCBwaWRfdCBwaWQpDQo+PiAr
ew0KPj4gKyBzdHJ1Y3QgdWV4aXRfcGlkX2hub2RlICpobm9kZTsNCj4+ICsgc3RydWN0IGhsaXN0
X25vZGUgKnRtcDsNCj4+ICsgaW50IGV4Y2RlOw0KPj4gKw0KPj4gKyBtdXRleF9sb2NrKCZoZGV2
LT51ZXhpdF9oYXNoX2xvY2spOw0KPj4gKyBoYXNoX2Zvcl9lYWNoX3Bvc3NpYmxlX3NhZmUoaGRl
di0+dWV4aXRfcGlkX2h0YWJsZSwNCj4+ICsgaG5vZGUsIHRtcCwgdWV4aXRfcGlkX2hsaXN0LCBw
aWQpIHsNCj4+ICsgaWYgKGhub2RlLT5waWQgPT0gcGlkKSB7DQo+PiArIGV4Y2RlID0gaG5vZGUt
PnVleGl0X2NvZGU7DQo+PiArIGhhc2hfZGVsKCZobm9kZS0+dWV4aXRfcGlkX2hsaXN0KTsNCj4+
ICsgbXV0ZXhfdW5sb2NrKCZoZGV2LT51ZXhpdF9oYXNoX2xvY2spOw0KPj4gKyBrZnJlZShobm9k
ZSk7DQo+PiArIGF0b21pY19kZWMoJmhkZXYtPmhyZWZjbnQpOw0KPj4gKyBwcl9kZWJ1ZygiJXM6
IEFmdGVyIGhhc2hfZGVsIG9mIHBpZCAlZCwgZm91bmQgZXhpdCBjb2RlICV1IGhyZWZjbnQgJWRc
biIsDQo+PiArIF9fZnVuY19fLCBwaWQsIGV4Y2RlLA0KPj4gKyBhdG9taWNfcmVhZCgmaGRldi0+
aHJlZmNudCkpOw0KPj4gKyByZXR1cm4gZXhjZGU7DQo+PiArIH0NCj4+ICsgfQ0KPj4gKw0KPj4g
KyBtdXRleF91bmxvY2soJmhkZXYtPnVleGl0X2hhc2hfbG9jayk7DQo+PiArIHByX2VycigiJXM6
IHBpZCAlZCBub3QgZm91bmQgaW4gaGFzaCB0YWJsZVxuIiwNCj4+ICsgX19mdW5jX18sIHBpZCk7
DQo+PiArIHJldHVybiAtRUlOVkFMOw0KPj4gK30NCj4+ICsNCj4+ICtpbnQgY25faGFzaF9nZXRf
ZXh2YWwoc3RydWN0IGNuX2hhc2hfZGV2ICpoZGV2LCBwaWRfdCBwaWQpDQo+PiArew0KPj4gKyBz
dHJ1Y3QgdWV4aXRfcGlkX2hub2RlICpobm9kZTsNCj4+ICsgX191MzIgZXhjZGU7DQo+PiArDQo+
PiArIG11dGV4X2xvY2soJmhkZXYtPnVleGl0X2hhc2hfbG9jayk7DQo+PiArIGhhc2hfZm9yX2Vh
Y2hfcG9zc2libGUoaGRldi0+dWV4aXRfcGlkX2h0YWJsZSwNCj4+ICsgaG5vZGUsIHVleGl0X3Bp
ZF9obGlzdCwgcGlkKSB7DQo+PiArIGlmIChobm9kZS0+cGlkID09IHBpZCkgew0KPj4gKyBleGNk
ZSA9IGhub2RlLT51ZXhpdF9jb2RlOw0KPj4gKyBtdXRleF91bmxvY2soJmhkZXYtPnVleGl0X2hh
c2hfbG9jayk7DQo+PiArIHByX2RlYnVnKCIlczogRm91bmQgZXhpdCBjb2RlICV1IGZvciBwaWQg
JWRcbiIsDQo+PiArIF9fZnVuY19fLCBleGNkZSwgcGlkKTsNCj4+ICsgcmV0dXJuIGV4Y2RlOw0K
Pj4gKyB9DQo+PiArIH0NCj4+ICsNCj4+ICsgbXV0ZXhfdW5sb2NrKCZoZGV2LT51ZXhpdF9oYXNo
X2xvY2spOw0KPj4gKyBwcl9kZWJ1ZygiJXM6IHBpZCAlZCBub3QgZm91bmQgaW4gaGFzaCB0YWJs
ZVxuIiwNCj4+ICsgX19mdW5jX18sIHBpZCk7DQo+PiArIHJldHVybiAtRUlOVkFMOw0KPj4gK30N
Cj4+ICsNCj4+ICtib29sIGNuX2hhc2hfdGFibGVfZW1wdHkoc3RydWN0IGNuX2hhc2hfZGV2ICpo
ZGV2KQ0KPj4gK3sNCj4+ICsgYm9vbCBpc19lbXB0eTsNCj4+ICsNCj4+ICsgaXNfZW1wdHkgPSBo
YXNoX2VtcHR5KGhkZXYtPnVleGl0X3BpZF9odGFibGUpOw0KPj4gKyBwcl9kZWJ1ZygiSGFzaCB0
YWJsZSBpcyAlc1xuIiwgKGlzX2VtcHR5ID8gImVtcHR5IiA6ICJub3QgZW1wdHkiKSk7DQo+PiAr
DQo+PiArIHJldHVybiBpc19lbXB0eTsNCj4+ICt9DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9j
b25uZWN0b3IvY25fcHJvYy5jIGIvZHJpdmVycy9jb25uZWN0b3IvY25fcHJvYy5jDQo+PiBpbmRl
eCA0NGIxOWU2OTYxNzYuLjA2MzJhNzBhODlhMCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvY29u
bmVjdG9yL2NuX3Byb2MuYw0KPj4gKysrIGIvZHJpdmVycy9jb25uZWN0b3IvY25fcHJvYy5jDQo+
PiBAQCAtNjksNiArNjksOCBAQCBzdGF0aWMgaW50IGNuX2ZpbHRlcihzdHJ1Y3Qgc29jayAqZHNr
LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCB2b2lkICpkYXRhKQ0KPj4gaWYgKChfX3UzMil2YWwgPT0g
UFJPQ19FVkVOVF9BTEwpDQo+PiByZXR1cm4gMDsNCj4+IA0KPj4gKyBwcl9kZWJ1ZygiJXM6IHZh
bCAlbHgsIHdoYXQgJXhcbiIsIF9fZnVuY19fLCB2YWwsIHdoYXQpOw0KPj4gKw0KPj4gLyoNCj4+
ICAqIERyb3AgcGFja2V0IGlmIHdlIGhhdmUgdG8gcmVwb3J0IG9ubHkgbm9uLXplcm8gZXhpdCBz
dGF0dXMNCj4+ICAqIChQUk9DX0VWRU5UX05PTlpFUk9fRVhJVCkgYW5kIGV4aXQgc3RhdHVzIGlz
IDANCj4+IEBAIC0zMjYsOSArMzI4LDE1IEBAIHZvaWQgcHJvY19leGl0X2Nvbm5lY3RvcihzdHJ1
Y3QgdGFza19zdHJ1Y3QgKnRhc2spDQo+PiBzdHJ1Y3QgcHJvY19ldmVudCAqZXY7DQo+PiBzdHJ1
Y3QgdGFza19zdHJ1Y3QgKnBhcmVudDsNCj4+IF9fdTggYnVmZmVyW0NOX1BST0NfTVNHX1NJWkVd
IF9fYWxpZ25lZCg4KTsNCj4+ICsgaW50IHVleGl0X2NvZGU7DQo+PiANCj4+IC0gaWYgKGF0b21p
Y19yZWFkKCZwcm9jX2V2ZW50X251bV9saXN0ZW5lcnMpIDwgMSkNCj4+ICsgaWYgKGF0b21pY19y
ZWFkKCZwcm9jX2V2ZW50X251bV9saXN0ZW5lcnMpIDwgMSkgew0KPj4gKyBpZiAobGlrZWx5KCEo
dGFzay0+ZmxhZ3MgJiBQRl9FWElUX05PVElGWSkpKQ0KPj4gKyByZXR1cm47DQo+PiArDQo+PiAr
IGNuX2RlbF9nZXRfZXh2YWwodGFzay0+cGlkKTsNCj4+IHJldHVybjsNCj4+ICsgfQ0KPj4gDQo+
PiBtc2cgPSBidWZmZXJfdG9fY25fbXNnKGJ1ZmZlcik7DQo+PiBldiA9IChzdHJ1Y3QgcHJvY19l
dmVudCAqKW1zZy0+ZGF0YTsNCj4+IEBAIC0zMzcsNyArMzQ1LDI2IEBAIHZvaWQgcHJvY19leGl0
X2Nvbm5lY3RvcihzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRhc2spDQo+PiBldi0+d2hhdCA9IFBST0Nf
RVZFTlRfRVhJVDsNCj4+IGV2LT5ldmVudF9kYXRhLmV4aXQucHJvY2Vzc19waWQgPSB0YXNrLT5w
aWQ7DQo+PiBldi0+ZXZlbnRfZGF0YS5leGl0LnByb2Nlc3NfdGdpZCA9IHRhc2stPnRnaWQ7DQo+
PiAtIGV2LT5ldmVudF9kYXRhLmV4aXQuZXhpdF9jb2RlID0gdGFzay0+ZXhpdF9jb2RlOw0KPj4g
KyBpZiAodW5saWtlbHkodGFzay0+ZmxhZ3MgJiBQRl9FWElUX05PVElGWSkpIHsNCj4+ICsgdGFz
ay0+ZmxhZ3MgJj0gflBGX0VYSVRfTk9USUZZOw0KPj4gKw0KPj4gKyB1ZXhpdF9jb2RlID0gY25f
ZGVsX2dldF9leHZhbCh0YXNrLT5waWQpOw0KPj4gKyBpZiAodWV4aXRfY29kZSA8PSAwKSB7DQo+
PiArIHByX2RlYnVnKCIlczogZXJyICVkIHJldHVybmluZyB0YXNrJ3MgZXhpdCBjb2RlICV1XG4i
LA0KPj4gKyB1ZXhpdF9jb2RlLCBfX2Z1bmNfXywNCj4+ICsgdGFzay0+ZXhpdF9jb2RlKTsNCj4g
DQo+IChJIG1pZ2h0IGhhdmUgY29tbWVudGVkIG9uIHRoZSBvbGRlciByZXZpc2lvbiwgYnV0IHNh
bWUgaXNzdWUgaGVyZSkNCj4gDQo+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSAuL2luY2x1ZGUvbGlu
dXgva2VybmVsLmg6MzEsDQo+ICAgICAgICAgICAgICAgICBmcm9tIGRyaXZlcnMvY29ubmVjdG9y
L2NuX3Byb2MuYzoxMToNCj4gZHJpdmVycy9jb25uZWN0b3IvY25fcHJvYy5jOiBJbiBmdW5jdGlv
biDigJhwcm9jX2V4aXRfY29ubmVjdG9y4oCZOg0KPiBkcml2ZXJzL2Nvbm5lY3Rvci9jbl9wcm9j
LmM6MzUzOjM0OiBlcnJvcjogZm9ybWF0IOKAmCVz4oCZIGV4cGVjdHMgYXJndW1lbnQgb2YgdHlw
ZSDigJhjaGFyICrigJksIGJ1dCBhcmd1bWVudCAzIGhhcyB0eXBlIOKAmGludOKAmSBbLVdlcnJv
cj1mb3JtYXQ9XQ0KPiAgMzUzIHwgICAgICAgICAgICAgICAgICAgICAgICAgcHJfZGVidWcoIiVz
OiBlcnIgJWQgcmV0dXJuaW5nIHRhc2sncyBleGl0IGNvZGUgJXVcbiIsDQo+ICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fg0KPiANCg0KVGhhbmtzIGEgbG90ISBJIGhhZCBzZWVuIHRoaXMgZXJy
b3IgYW5kIGNvcnJlY3RlZCBpdCwgYW5kIGNvbXBpbGVkIGVhY2ggcGF0Y2ggc2VwYXJhdGVseSBh
bmQgYWxsIHRvZ2V0aGVyIGJlZm9yZSBzZW5kaW5nLCBzbyBub3Qgc3VyZSBob3cgdGhpcyBoYXBw
ZW5lZCwgYnV0IHdpbGwgcmVzZW5kIGFub3RoZXIgcGF0Y2ggdmVyc2lvbi4gVGhhbmtzIGZvciBj
YXRjaGluZyBpdC4NCg0KQW5qYWxpDQoNCj4gLS0tDQo+IHB3LWJvdDogY3INCg0KDQo=

