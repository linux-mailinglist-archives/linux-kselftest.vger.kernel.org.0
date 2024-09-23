Return-Path: <linux-kselftest+bounces-18257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E0A9838BE
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 23:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958621C21761
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 21:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4240683CDB;
	Mon, 23 Sep 2024 21:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B+2JpIZh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="S7Mf6czv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B188289E
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 21:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727126314; cv=fail; b=d4/cyu7Nhp7rv/OUZTIWSx77QsdyZo2zaSJmP2NN7Cj5Cpjn1w9vbVA7HNDrB6QAU/nkj1h5S6T74C+3+bUDEvXkFef3xxfSPsqHs+TwRM+ta7Bwolg/s4MuqQbl2r76RL4pM4WEGOTnrkp23XmU48GZapxLgyIf31qGrT6TOlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727126314; c=relaxed/simple;
	bh=vB3PKJXYX1HZ7VCVLFgpnYXFW9VanXeOBDSuyguHXAI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AaWhkvKh/yejdw15nYyYmIgQPXX2TWJKACOzdy8KDlSFQxPW0Q91ScL5J8W2OQkFpW9OlfLETwg613Eex/kYQQsIhxTsnu5b7c8otG5jtaTPuApRiwqUodJyzIxFQ50gHZdnDbu/shGJBD/vvoo+kHjIjrmRDkmElHy0uUWQ0eI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B+2JpIZh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=S7Mf6czv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NIMYkt029695;
	Mon, 23 Sep 2024 21:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=vB3PKJXYX1HZ7VCVLFgpnYXFW9VanXeOBDSuyguHX
	AI=; b=B+2JpIZhQ/6hTKOdRVeYdf4fExYIBQR8+vb9KgF8XmCukba+rifhNNXnU
	Njzr8Tzs/29Xph7SePoeI77VM5V+T26asg2fXV3KPDTnxSV2sbh8gKl51N1JlYhf
	e4Z/h1lYgmfR6SzDTFVCO/F9JQ3sR8dpXrMKFZOLMIUCgMcWbDdnHUw5YaXKi7GP
	dNHWQu2xK7KGeQ2A8e6b4CYuWMH2AT+xbu7+OQzhZlqRCqnmbi6zGEeL3dRO57lz
	9ahACamSt5e6sW5leZeAp5kQB6Xz3uj8mlwy1kOlzboyADNp7wpYQ9UQvc/9Gfci
	FzjVyoBwTA2G1xkawfPZiKZwfEySA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smr15xq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 21:18:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48NKmxGP029720;
	Mon, 23 Sep 2024 21:18:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41smk8bgym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 21:18:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SH53dFEiCNrhjVxPdR/UbEBEErFLa8Duj20jMTy6UdhIGs7TLd4Ud2oNCeDr6xUZbE35pSF/TJtmK/vJub0t99cLltAYx1OUrQ3NV/L0S7A1yl5MGY6TAG5jZcre042xfWjSetx86nmsyktzv0xI7BFOamTQBgOv4IJXXmkBmSelNRnxXixtvg2Tu4loIn21ndQQhnSVQi0E7aiTpcDSbSESZDXC8eCtpCsKWbkCRuqUIC/3V+RcusQa6RJ6cfJymcqu9UYLFMtIMbBFD5FK0QuCzfmMzFfRodKbw+GGNK+HNbPXHf5+spsqYonlicZ2GIBtBrvXUfJEFXZnWEAx4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vB3PKJXYX1HZ7VCVLFgpnYXFW9VanXeOBDSuyguHXAI=;
 b=ptxALCjHBtBtpsMRgyL118eu1fjOIGCXYtTeSR/6YYrIMeKceA3/hXLCSw5h4oADxZVj+uIB0ww5GHTHFkjqAKSs4isoZUtR2GH8gCyqUbRnwop8uYbc/b/X+qHmF94a3k3fbVR8x9w5TBV4eg9WUvwmEOEwlejGZlR/w8FWTFOSC6obDZRW2pYfuYfBSKaWwJp6E3UMKZSnG5f52xSpFfuCoHQHluRF+xnuEA9C2T/8pHUeWESlMSfiRHxVk/9rH2rYn26BzHb+woexI2TfuBCZXz8Alv5thI3WWmMMZdYhPBbYjlGfzuoJz5KQ2iXkTkmPnnyhn/AWhWrxqDWkzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vB3PKJXYX1HZ7VCVLFgpnYXFW9VanXeOBDSuyguHXAI=;
 b=S7Mf6czv/49PH4hG3JF5wze6SPlPScfBbvlJ0z0dNzlSBuis/jPzIjrjr7a3cMbe7HCPqEDmtC1iZDzj4M5/J/j7tnu2+h8fa2rRDfu4TdajiRgsB1QNIfDdcgQnVsAaUYuQ1qhZi/jwpGWZnnW3058H2bQGS+RFAZO7x8G8cUM=
Received: from SA1PR10MB7634.namprd10.prod.outlook.com (2603:10b6:806:38a::17)
 by DS7PR10MB5214.namprd10.prod.outlook.com (2603:10b6:5:3a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Mon, 23 Sep
 2024 21:18:19 +0000
Received: from SA1PR10MB7634.namprd10.prod.outlook.com
 ([fe80::5d7d:6585:d28f:3d9b]) by SA1PR10MB7634.namprd10.prod.outlook.com
 ([fe80::5d7d:6585:d28f:3d9b%5]) with mapi id 15.20.8005.010; Mon, 23 Sep 2024
 21:18:19 +0000
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
Thread-Index: AQHbDfnROi+E4QCQzUenn4jAawAnH7Jl2h2AgAAGGwA=
Date: Mon, 23 Sep 2024 21:18:19 +0000
Message-ID: <703DFBEE-D5EA-4798-B3EB-7F1E62533659@oracle.com>
References: <20240923204718.1862074-1-yifei.l.liu@oracle.com>
 <0a5b473a-281b-4911-984b-cf456d42a44f@linuxfoundation.org>
In-Reply-To: <0a5b473a-281b-4911-984b-cf456d42a44f@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR10MB7634:EE_|DS7PR10MB5214:EE_
x-ms-office365-filtering-correlation-id: 09e96928-957a-4ed5-ecf1-08dcdc153f56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eWtqVjBJbzM5RG5UZ0QwOXBYY09TeUVYWkxVbkxVeEd5QVhZbjNxR0Z1VXpT?=
 =?utf-8?B?VkJTZGszWG5aRDA4alZTcTNrTTRwcVpNTlhxM21hd2F5cWdYS21FZWo0TDAy?=
 =?utf-8?B?cTJSSmRXTjNtek9aOXBXdXMrR0F6eHlCaGVSNXNzRnVTRmppYTJLYVEwcE1F?=
 =?utf-8?B?QStRamZ1NklLRXN0cHBSamh1ZkM2Q0J3WnA1bjBZRXVZMW9DNWErWExja1Uw?=
 =?utf-8?B?NzNXQ082dVNFTyt4eVhzcjlwV3VldFBYMWpWM2JKVjdXMzlqYUxTV0RNTDBT?=
 =?utf-8?B?RVBKVXhNYXhWY09kNHpnM2RiM1lNMWRWV3FnaERRbE5XUEJDK1RhcE5JNTZ2?=
 =?utf-8?B?bjcwM2Z0Q3FZSlF2eC92Vm9vT0RlbXlKVVhCUHdaK2EwQWlSNUwxS01xcWFh?=
 =?utf-8?B?Rys1OThURCtjVlJXV2NYKzBlR1pFOHRXaEl2UGxVZ3lGWll4d2NnNnppMUV1?=
 =?utf-8?B?VVBNZDgwWG9DWXFhR01hU3ZGQ2crb1FwYW5nUjV5a3pmNUdWM3llcEx5ZXA5?=
 =?utf-8?B?UEh4dm5veWtPSFUxUTFnalU4bUtTKzZneXYrUFRwRWZoRXp5K2FIV0htMWN5?=
 =?utf-8?B?ZUM3NjNTOW9DL1VZU1dJQmdpSkZjQkUwbnJXRGVaQ1hicjlNUGxmNCt3YjZi?=
 =?utf-8?B?cXJjeXNXdFZHb1NpeEpqR0hrY2J2OE5vTEp2MEhRVmEyUDUxMkJmSjdSL1pW?=
 =?utf-8?B?RmtlRDRZOFFRQWpyVC9IYWtpNjl2QVEwQVhDd3l4ZUxpOU0rTDJvMDR0VVhS?=
 =?utf-8?B?S1JRdXpYb21iMjZwRk9INDNXeXFiRVNPeWJTWXh5NVJjUEVsUThFY1YyUFZK?=
 =?utf-8?B?M2NIT2dLb2NBYnpIUGtQdTJKZmM4aVdlbWQ3NkNEcVY2OGRKTldsZ0Myem90?=
 =?utf-8?B?ZUU4TFlndXVBajNzTHp5NTVTNkw4VDhSWmNHM0pBdWlJak00bFlUbGtTY0tZ?=
 =?utf-8?B?VVpmK1hWaWlkTkFnRjY3UkF0aHlxY3poN0dGcWJ3Y04zcjIxUWVIQkYzZ2U0?=
 =?utf-8?B?bXRWMlphL2dWVlFVeUo5TjRxajBIdHlTZUdYUTcxZXVid1d2cnF2SEd0NmRU?=
 =?utf-8?B?VThJQldOOWNqWnphenlGNWVLTE1IVko2bXcwdlhMaVpacmpNckdBcDdvY2Ri?=
 =?utf-8?B?MzVZK2NiT0g2TW5ZYS83bFcyVFhnaHR4a1E0VE16Y1FFM0QwRlVnN1FEbGR4?=
 =?utf-8?B?MzFpVjE0b3QyQmREYktWMWJmT3pxOFIrN1p1RmJWWnpwSGdFYktxMDQ5OFhD?=
 =?utf-8?B?Znd1cnN0UVA3eGF0UVNiVEhnSW13eXhabXo4WnlSOG9ZZkd0Rk5BVmFMNW1n?=
 =?utf-8?B?Z3BFOXpLMllxTEt2cUxmTHN4c24rM1FsajVQQ0QySVVhKzBxaS9STzV4RzdB?=
 =?utf-8?B?N0FlczlDRE1FUzlpOFZLN1dETkRUMEFOKzhncDR4VmpUUGNBeUN1cnpFdUtu?=
 =?utf-8?B?NzFseU5QZXhpbm9JelVXVzVHbWZFSUtaUFU2dUlJM0dvNGd0S29zN0kzbXMy?=
 =?utf-8?B?eWhhVHdzdk1NUG5tL0lPNVRvcjh2WnFQTTdRclIranI0Y2YvSVBVaE9COExE?=
 =?utf-8?B?azNQcUMvcVZSQVBFeElGTEFzRnpOc2l3U2pnU3poeXROdEhoSnFVbi9sRC9H?=
 =?utf-8?B?WUhZRGYzTmJsVkYybk9wUDBvY25Xd3hhQ3NXc1Y2TTd0WFpjamtUM0V5bVlD?=
 =?utf-8?B?bXgrVHl4K1VIRkE1eXRqYlduWitNelVHTzFwakNMcFRxWk4xQkxnN2IwWi9N?=
 =?utf-8?B?VUNlMFhhM09Tek5RT0lCSnZvbDErcWxQL3dVaEUya0Ftang4S1JiT1hGVFUy?=
 =?utf-8?B?Q2hUYXRDdTRsS3czcnZYZTIxam5jRDZNekNqd1BrKzRpcWU0eXYrMWdIQmln?=
 =?utf-8?B?ZWxyOVpEVUdMbENXOWcwbGtpcXJ5M2Z1Y3c0M0o4elA2cVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB7634.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?THo1LzVVcHBBZEhTc0p2UmZoRDNtbW9UQ2FvdGRCSEMxSlVhazQ0Y2J4S0wx?=
 =?utf-8?B?U3NUYnFLM2FkVDI1ZmNFanlGR1o1TWswUWplOGhMYmxDUVJhekFqenBwUGZs?=
 =?utf-8?B?UjlEQk1VVVFRRVd2N0dXOGg0UkVCd09SOWM3TERYOUM3TXI0RjQxQnpNcU52?=
 =?utf-8?B?QmdjK0FQZGNLbzh2S1pDTzhHRmxMd3F1Nzh0MFBFOW1qa0duM2ZGVXI1K0RL?=
 =?utf-8?B?U0FJZHRDQWM2SWlUSjhRZCtqc2JUcGN4YnZhT2g4NnlMN2VZSGhGV3dNaFM4?=
 =?utf-8?B?SjI5UENUckhwOFlXVE9tQmNBMU0zalBROE1WdHhlUmVpeG1neGNycVRFZlJP?=
 =?utf-8?B?UFBaK2FNOVcrdWUrUnJWVWxxRi9lUDY5SElOWFNLREZrY2laaDN1aTNhL2dz?=
 =?utf-8?B?NmpRR0I5UGUzZU5mdG1LdjgxMGxXcDRwZHZyR2syWjJTazhKYjVIcGhlaVlr?=
 =?utf-8?B?RVVYc3BUU09EVVhiN0I2UlVrS1J4NVUyYXhEMmhsV1pqK0lKNGR0bEx0OTJK?=
 =?utf-8?B?d042OUFLdDRnd0lhdTREMmt0YmZHWkNhUG9SQi9PUER3djFSeU05QXhFbVlW?=
 =?utf-8?B?VlBhSENOZHVaRlAyRHJDV1dOVnE1bVZnUU03MXFSb0wxUzJGMHpIL1lySG1o?=
 =?utf-8?B?Y3UyZ3hMamVHNEVRbUxyS2dYOENUc0R5Y1RObTlkdmRnQklWcC9iS1RYblhF?=
 =?utf-8?B?emFnK3dsVEpzZ2RoNHp2YTluMWF5a2h2N3hvR0t5S3pGTlpzcGNFNEtBVU4z?=
 =?utf-8?B?L2R5Skt1Q2pGQUVPQWdiTG5PYksrdWtock5IdVFiU1l0VHYwOExRSnlxcEpl?=
 =?utf-8?B?TnhmTEZJUnB3Y0EwU25BODdHaGpCVzE2WUE5cnRoZ1V4SGRpa2IwQ1dvTCtZ?=
 =?utf-8?B?Sm4yM3dsbnNyTUpHNWF3RE9LM0lnb014RGhRSlBORmFvYkZvOS96YzJoSUVV?=
 =?utf-8?B?Ry9SSXdhMnFtK0JWUmErckFSQWxGUVJVZHNEenB3N3hhSWRGQ1dmV0E4TU5w?=
 =?utf-8?B?emVGR2NScGplaVNJT0gxWDN1cTdVZFNzSzVlZ2o1azhEYllDME93QVRXVVN4?=
 =?utf-8?B?WHUyeSs2OUkrSkM1THc3YndIMlh1ZkxWZ1poV0pzMDNzeEF2ZW4vQUMyUDBo?=
 =?utf-8?B?anNyQVZLOUdaWlFTSW93aTJTNWdyN0pGSms3eFFmdENYRmdxNXdsc2N6bHFp?=
 =?utf-8?B?YlM1NUlHZDB0T0YrSEcrTThVS3BkaC91N0dmU2ozbThYdVZaaWt2U2t0bGF3?=
 =?utf-8?B?V2s5TUJmT01aYzhKcXQwWnU2Tm1rVmhrWkFsWm5oQkNsS1djQTR2cGdVclkz?=
 =?utf-8?B?Z2FHVXBVU2dSbEhwYnlpT3ZRYS9rdTlMMG0xMjZoQmZ2RzBTaVRYN1RJUFpF?=
 =?utf-8?B?T2xkMjA4RzV2aUdTVkt3eDMrYUpjY0RmYy8xejBadzVsSjh5aUVqbHFvSnhn?=
 =?utf-8?B?cVBvQkFDZGdCUFpJS2pOazQ0QTBSRnY5bFNrV3U4WTVXRUgvQWd1TnBZVzZ2?=
 =?utf-8?B?NGt2dkpqT05XTFAxaHpKU2VjMXJaTElYQkUrWEtpS0hMMnh4U1lBN3RkOHJw?=
 =?utf-8?B?Mkc5cWZQZllKaWMzQ0F5RHdnYTBNUnhsSjdDVWtyaW9jdUdRRFlUUDhOOStN?=
 =?utf-8?B?WXFvVkZtdVo2QUc2d0RUSGxyQ05rZVMvQWNjcG0wcEVBL0xDeTBDNFNjZHFV?=
 =?utf-8?B?S0FwL1RLMEhrUFhoZitBbWZWQ2JiaFFjRHE0Um9JUnJGMk5VMitPWnBiU0dh?=
 =?utf-8?B?NVd3T3g1RHRLWXFPMUprWUlDb1kwWFpGUU1kKzd3WHhTYUdHbHQ0cVQ3Ujlh?=
 =?utf-8?B?TjVmMVAxK1ZNSzFMSzloVk1iU2RLSE5abnZ1ZGpERnpNV3dpUDc3ZC9OMDVh?=
 =?utf-8?B?L3piRmQvRWRBaG4wdUZrcWJBZ0w2dExJUVFhaWYrYzJEQnBramY5cTNuRSta?=
 =?utf-8?B?V2RXYWNUY1hTM2F4enNTUUVRaEFvTFJJcTVyeVByMFN4RWV6T2R5OGN5akll?=
 =?utf-8?B?ajhqTFU3MkNGSEpZQzVLd1E2aDgzdUZ6dWswQjdhNFRhUjlyNEhPUnkyblU5?=
 =?utf-8?B?QVFSOGpiak9OTnErWEZTUDhQMHZaZXpONHpUbGdUelVlczJGVlJQdG1raWg0?=
 =?utf-8?B?VjA0aVIyOVU0M1h3SnEzSmVnelV2ODJ1K1hsSzZOdTRoclpxaWRLcGRaM01E?=
 =?utf-8?Q?wE0Op4Cs6EN9qmM7CGXA5WQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF743C407E262B41839E16B37AAE48AE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BmBixg84lvkdWlf5jmUSqdf2epRlHoO1OzYKuFRkM5VPJtXzu/vXam4HtQHazXQcvyN06te/764bTp+VXPjkhtWrMrFb4pHntZYIsXB0hDAvyWKi2WY+7oy0Ba+OMgzKNB4QVSoX5cfUfmOxXby8777OL/Nf9nYJ1w52sXTV8q+MpStmz/MADwpabW174NKt1eccrmvJpgyKOmtQri4VytpDv+bhMJ/BQq04+k7cLxirET0x0y9pliJ/kSyZW3sNGY4nVAZyVArWAMtW5N0A/lARnXfp0IlP6L9/PMxESuxt1CXsCcQ/tA9BwOZzmCavPv8TEWsRaogzHRaRaT05S/yhPtqxt15gvXnOHZtIcZCamuMUMPqEAiQJRWADkTxU5gvFU+R8GiH/+T+brUv9Eu9+35jRK/UnAgmS+Obv1v6SXgYpOP29dme3VDISx1LPn4dMQluIR6ug5VdRjR5sZPd7NHjAnVfnMg25Ww5kd/577HuxYkL9ljSdoUl236yXV4KOpZjO0jRDP/Emu2K61dPtShx/wA9nPWHpRwbkUwwCzCdM7MSbnjwnz6pJFq9rZ+Gf1priGnR3ske8xVeNVzDcrRLIXTc7gPml/VeX/g4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB7634.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e96928-957a-4ed5-ecf1-08dcdc153f56
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2024 21:18:19.4801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Nk4KEIpmo0ICmOBUVIAn09qbhmDKtn8gVbGnnB1w83PgdGAFjd9ONOlQrY5CO45AcaYnHfObesapOPdqHwAhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_15,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409230153
X-Proofpoint-ORIG-GUID: IiymPd4TCinodCFua_pTKjELAxyDC7N_
X-Proofpoint-GUID: IiymPd4TCinodCFua_pTKjELAxyDC7N_

DQoNCj4gT24gU2VwIDIzLCAyMDI0LCBhdCAxOjU24oCvUE0sIFNodWFoIEtoYW4gPHNraGFuQGxp
bnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiANCj4gT24gOS8yMy8yNCAxNDo0NywgWWlmZWkg
TGl1IHdyb3RlOg0KPj4gV2UgcmVjZW50bHkgbm90aWNlIHRoYXQgdGhlIHN0ZXBfYWZ0ZXJfc3Vz
cGVuZF90ZXN0IHdvdWxkDQo+IA0KPiBub3RpY2VkDQpIb3cgYWJvdXQgY2hhbmdlIHRoaXMgdG8g
ZmluZD8NCj4gDQo+PiBmYWlsIG9uIG91ciBwbGVudHkgZGV2aWNlcy4gIFRoZSB0ZXN0IGJlbGll
dmVzaXQgZmFpbGVkIHRvDQo+IA0KPiAic2V2ZXJhbCBvZiBvdXIgZGV2aWNlcyIgIGJlbGlldmVz
IGl0DQo+PiBlbnRlciBzdXNwZW5kIHN0YXRlIHdpdGgNCj4gDQo+IFBsZWFzZSBkbyBmaXggdGhl
IGFib3ZlIGFzIHBvaW50ZWQgb3V0IGVhcmxpZXIgb24gdjEuDQpBcG9sb2dpZXMsIGZvcmdldCB0
byBmaXguIFdpbGwgZml4IHRoYXQuIA0KPj4gJCBzdWRvIC4vc3RlcF9hZnRlcl9zdXNwZW5kX3Rl
c3QNCj4+IFRBUCB2ZXJzaW9uIDEzDQo+PiBCYWlsIG91dCEgRmFpbGVkIHRvIGVudGVyIFN1c3Bl
bmQgc3RhdGUNCj4+IEhvd2V2ZXIsIGluIHRoZSBrZXJuZWwgbWVzc2FnZSwgSSBpbmRlZWQgc2Vl
IHRoZSBzeXN0ZW0gZ2V0DQo+PiBzdXNwZW5kZWQgYW5kIHRoZW4gd2FrZSB1cCBsYXRlci4NCj4+
IFs2MTExNzIuMDMzMTA4XSBQTTogc3VzcGVuZCBlbnRyeSAoczJpZGxlKQ0KPj4gWzYxMTE3Mi4w
NDQ5NDBdIEZpbGVzeXN0ZW1zIHN5bmM6IDAuMDA2IHNlY29uZHMNCj4+IFs2MTExNzIuMDUyMjU0
XSBGcmVlemluZyB1c2VyIHNwYWNlIHByb2Nlc3Nlcw0KPj4gWzYxMTE3Mi4wNTkzMTldIEZyZWV6
aW5nIHVzZXIgc3BhY2UgcHJvY2Vzc2VzIGNvbXBsZXRlZCAoZWxhcHNlZCAwLjAwMSBzZWNvbmRz
KQ0KPj4gWzYxMTE3Mi4wNjc5MjBdIE9PTSBraWxsZXIgZGlzYWJsZWQuDQo+PiBbNjExMTcyLjA3
MjQ2NV0gRnJlZXppbmcgcmVtYWluaW5nIGZyZWV6YWJsZSB0YXNrcw0KPj4gWzYxMTE3Mi4wODAz
MzJdIEZyZWV6aW5nIHJlbWFpbmluZyBmcmVlemFibGUgdGFza3MgY29tcGxldGVkIChlbGFwc2Vk
IDAuMDAxIHNlY29uZHMpDQo+PiBbNjExMTcyLjA4OTcyNF0gcHJpbnRrOiBTdXNwZW5kaW5nIGNv
bnNvbGUocykgKHVzZSBub19jb25zb2xlX3N1c3BlbmQgdG8gZGVidWcpDQo+PiBbNjExMTcyLjEx
NzEyNl0gc2VyaWFsIDAwOjAzOiBkaXNhYmxlZA0KPj4gLS0tIHNvbWUgb3RoZXIgaGFyZHdhcmUg
Z2V0IHJlY29ubmVjdGVkIC0tLQ0KPj4gWzYxMTIwMy4xMzYyNzddIE9PTSBraWxsZXIgZW5hYmxl
ZC4NCj4+IFs2MTEyMDMuMTQwNjM3XSBSZXN0YXJ0aW5nIHRhc2tzIC4uLg0KPj4gWzYxMTIwMy4x
NDExMzVdIHVzYiAxLTguMTogVVNCIGRpc2Nvbm5lY3QsIGRldmljZSBudW1iZXIgNw0KPj4gWzYx
MTIwMy4xNDE3NTVdIGRvbmUuDQo+PiBbNjExMjAzLjE1NTI2OF0gcmFuZG9tOiBjcm5nIHJlc2Vl
ZGVkIG9uIHN5c3RlbSByZXN1bXB0aW9uDQo+PiBbNjExMjAzLjE2MjA1OV0gUE06IHN1c3BlbmQg
ZXhpdA0KPj4gQWZ0ZXIgaW52ZXN0aWdhdGlvbiwgSSBub3RpY2UgdGhhdCBmb3IgdGhlIGNvZGUg
YmxvY2sNCj4gDQo+IG5vdGljZWQ/DQpIb3cgYWJvdXQgdXNlIGZpbmQgaGVyZT8NCj4gDQo+PiBp
ZiAod3JpdGUocG93ZXJfc3RhdGVfZmQsICJtZW0iLCBzdHJsZW4oIm1lbSIpKSAhPSBzdHJsZW4o
Im1lbSIpKQ0KPj4ga3NmdF9leGl0X2ZhaWxfbXNnKCJGYWlsZWQgdG8gZW50ZXIgU3VzcGVuZCBz
dGF0ZVxuIik7DQo+PiBUaGUgd3JpdGUgd2lsbCByZXR1cm4gLTEgYW5kIGVycm5vIGlzIHNldCB0
byAxNiAoZGV2aWNlIGJ1c3kpLg0KPj4gSXQgc2hvdWxkIGJlIGNhdXNlZCBieSB0aGUgd3JpdGUg
ZnVuY3Rpb24gaXMgbm90IHN1Y2Nlc3NmdWxseSByZXR1cm5lZA0KPj4gYmVmb3JlIHRoZSBzeXN0
ZW0gc3VzcGVuZCBhbmQgdGhlIHJldHVybiB2YWx1ZSBnZXQgbWVzc2VkIHdoZW4gd2FraW5nIHVw
Lg0KPj4gQXMgYSByZXN1bHQsIEl0IG1heSBiZSBiZXR0ZXIgdG8gY2hlY2sgdGhlIHRpbWUgcGFz
c2VkIG9mIHRob3NlIGZldyBpbnN0cnVjdGlvbnMNCj4+IHRvIGRldGVybWluZSB3aGV0aGVyIHRo
ZSBzdXNwZW5kIGlzIGV4ZWN1dGVkIGNvcnJlY3RseSBmb3IgaXQgaXMgcHJldHR5IGhhcmQgdG8N
Cj4+IGV4ZWN1dGUgdGhvc2UgZmV3IGxpbmVzIGZvciA1IHNlY29uZHMuDQo+PiBUaGUgdGltZXIg
dG8gd2FrZSB1cCB0aGUgc3lzdGVtIGlzIHNldCB0byBleHBpcmVkIGFmdGVyIDUgc2Vjb25kcyBh
bmQgbm8tcmVhcm0uDQo+PiBJZiB0aGUgdGltZXIgcmVtYWluaW5nIHRpbWUgaXMgMCBzZWNvbmQg
YW5kIDAgbmFubyBzZWNvbWQsIGl0IG1lYW5zIHRoZSB0aW1lcg0KPj4gZXhwaXJlZCBhbmQgd2Fr
ZSB0aGUgc3lzdGVtIHVwLiBPdGhlcndpc2UsIHRoZSBzeXN0ZW0gY291bGQgYmUgY29uc2lkZXJl
ZCB0bw0KPj4gZW50ZXIgdGhlIHN1c3BlbmQgc3RhdGUgZmFpbGVkIGlmIHRoZXJlIGlzIGFueSBy
ZW1haW5pbmcgdGltZS4NCj4gDQo+IFdoYXQgd291bGQgeW91IGdldCBpZiB5b3Ugd2VyZSB0byBj
YXQgL3N5cy9wb3dlci9zdGF0ZSBhdCB0aGlzIHBvaW50Pw0KQWNjb3JkaW5nIHRvIGZpbGUga2Vy
bmVsL3Bvd2VyL3N1c3BlbmQsIHRoZSBjYXQgd2lsbCBhbHdheXMgcmV0dXJuIGZyZWV6ZSBtZW0g
ZGlzay4gDQoNCj4gRG9lcyB0aGlzIGZpeCB0aGUgcHJvYmxlbSB5b3UgYXJlIHNlZWluZz8gV2hh
dCBpcyB0aGUgb3V0Y29tZT8NClllcywgaXQgZml4ZXMuIFRoZSB0ZXN0IHdvdWxkIG5vdCBmYWls
IGZvciBpdCBiZWxpZXZlcyB0aGUgc3lzdGVtIGRvZXMgbm90IHdlbnQgdG8gc3VzcGVuZCBieSBt
aXN0YWtlLiBJdCBub3cgY291bGQgY29udGludWUgdG8gdGhlIHJlc3QgcGFydCBvZiB0aGUgdGVz
dCBhZnRlciBzdXNwZW5kLiANCj4+IEZpeGVzOiBiZmQwOTJiOGMyNzI4ICgic2VsZnRlc3RzOiBi
cmVha3BvaW50OiBhZGQgc3RlcF9hZnRlcl9zdXNwZW5kX3Rlc3QiKQ0KPj4gUmVwb3J0ZWQtYnk6
IFNpbmFkaW4gU2hhbiA8c2luYWRpbi5zaGFuQG9yYWNsZS5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBZaWZlaSBMaXUgPHlpZmVpLmwubGl1QG9yYWNsZS5jb20+DQo+PiAtLS0NCj4+ICAuLi4vdGVz
dGluZy9zZWxmdGVzdHMvYnJlYWtwb2ludHMvc3RlcF9hZnRlcl9zdXNwZW5kX3Rlc3QuYyAgfCA1
ICsrKystDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KPj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JyZWFrcG9pbnRzL3N0
ZXBfYWZ0ZXJfc3VzcGVuZF90ZXN0LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icmVha3Bv
aW50cy9zdGVwX2FmdGVyX3N1c3BlbmRfdGVzdC5jDQo+PiBpbmRleCBkZmVjMzFmYjliMzBkLi4z
M2Y1NTQyYmY3NDFkIDEwMDY0NA0KPj4gLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnJl
YWtwb2ludHMvc3RlcF9hZnRlcl9zdXNwZW5kX3Rlc3QuYw0KPj4gKysrIGIvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvYnJlYWtwb2ludHMvc3RlcF9hZnRlcl9zdXNwZW5kX3Rlc3QuYw0KPj4gQEAg
LTE1Miw3ICsxNTIsMTAgQEAgdm9pZCBzdXNwZW5kKHZvaWQpDQo+PiAgIGlmIChlcnIgPCAwKQ0K
Pj4gICBrc2Z0X2V4aXRfZmFpbF9tc2coInRpbWVyZmRfc2V0dGltZSgpIGZhaWxlZFxuIik7DQo+
PiAgLSBpZiAod3JpdGUocG93ZXJfc3RhdGVfZmQsICJtZW0iLCBzdHJsZW4oIm1lbSIpKSAhPSBz
dHJsZW4oIm1lbSIpKQ0KPj4gKyBzeXN0ZW0oIihlY2hvIG1lbSA+IC9zeXMvcG93ZXIvc3RhdGUp
IDI+IC9kZXYvbnVsbCIpOw0KPj4gKw0KPj4gKyB0aW1lcmZkX2dldHRpbWUodGltZXJmZCwmc3Bl
Yyk7DQo+PiArIGlmIChzcGVjLml0X3ZhbHVlLnR2X3NlYyAhPSAwIHx8IHNwZWMuaXRfdmFsdWUu
dHZfbnNlYyAhPSAwKQ0KPj4gICBrc2Z0X2V4aXRfZmFpbF9tc2coIkZhaWxlZCB0byBlbnRlciBT
dXNwZW5kIHN0YXRlXG4iKTsNCj4+ICAgICBjbG9zZSh0aW1lcmZkKTsNCj4gDQo+IHRoYW5rcywN
Cj4gLS0gU2h1YWgNCg0K

