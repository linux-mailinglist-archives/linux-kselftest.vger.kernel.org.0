Return-Path: <linux-kselftest+bounces-18929-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AD498E46F
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 22:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E20F1C21A16
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 20:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3401E212F18;
	Wed,  2 Oct 2024 20:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mJAHmrhs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H4CwXH8p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455758F40
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Oct 2024 20:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727902245; cv=fail; b=dFAWLbdiaiSVN0zvRRN9/CPhwt6uT7f8qCU+/e4J2oV02XyeLA9O54fT72htQ2iH7cCCjhJXM7hbhx4QYcUW6cz5vqm8Zo7eACw+T/sOuI/BEeRM/gytsnUPi42Wp1FOdZ6/Rj8NoKXMRUIzDKQGG7MS+Ad+pd0IpuSRXNfE0UM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727902245; c=relaxed/simple;
	bh=sQUldyuKN/p9rpiwuLYDV1KnWmQ6SfUlM5bUhuiX0YU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D5CXTn517/0yIjmIMkEZ+rrGOe0xsNocPJy41y+Tc89TnUb5PyeWLzWr7qp5BQRn742zvh/y//ooH32WZ7EJbc/Ucw/Mvj4+RZGCjzVnoQwGHQ5R/ej1bB0OxE8MbI/Pr+6408JCbIA/tQUrMfM/B6ovOi0b0A8nvq0KIzCC0/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mJAHmrhs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H4CwXH8p; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492J0Z7I022514;
	Wed, 2 Oct 2024 20:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=sQUldyuKN/p9rpiwuLYDV1KnWmQ6SfUlM5bUhuiX0
	YU=; b=mJAHmrhs+eRGXV1grmvIuj3FrNgrpQS47fRc55EzF07M4Opk7keSydgwN
	iNlX0bDYIWDruMqJ89KPU7yXZrUhp+gXZhNo9JUJNz9z/ohyl73hC3P5XfVbuKwY
	gC5Id3VMQJvjJ2d6ogJRd/i16JC/3DcDpPlNzscSMyLCV6Ppp0Axcd4TVG+ua+L4
	V3viEnTUr4C9Z7F3vxGVNULelqIBDaKXYiJGdJlpn63mEjut/NIAe6yyl2+x9f6+
	Ygq0VdcIhLD07T1NOjvqSKC48509rIuDbayPhrGNNPLS3e017rM2r8lw3Rm3r4JV
	WS1Uujyns2Lj9VoKiNd5cMV6h8m1A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x87damxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 20:50:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492K50b6038656;
	Wed, 2 Oct 2024 20:50:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x889dr5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 20:50:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysXXWPNu8w0g1BErIRRGI8Dw0IAeay5jB4zqkmevAlG8a5FX157neic01UQhgx0FtPf7xOGhqGBrFtuGM6uD7QD7vxtPCrNv/bDfmr8uRdIRW8zCU3Ol35/VvFVp133PeYo7FFi0s3MQFnEg+ouwidM81FeaKBSGgP/YRmjcVyTlQ2dxN0FaMkuJY04dRp1fczJbI2lZgi6ZuCH6mxNW37doP/fTgAYXj2m7OwZayyTEbhB7jWjEAvdzohduqSUB8m4XpfJjjVdXa7DebvfmSwaxPqKsB5ZapZzRdPqCKf7ISinCHXB9L3W4hOJGMEilgo4VDWCpMI18Td/bzV2XXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQUldyuKN/p9rpiwuLYDV1KnWmQ6SfUlM5bUhuiX0YU=;
 b=UInVSXLu2PUuiB4NIhCUtanandlaTY82bYaAaPUjwNsuaquN3hk+lM/iCKXHUuY2J2SnvKJiiA+2iHK1AW0ip05uBNv6ARL2wkK+59POh+4NRhU221HyDJFHM5FfYKZxNpu3u9or9oTJhac/WIa8pJjBAmbu8N5aivVm/g2FSjehdzyVin42DBEGzgVfupRiJem2zlOiJsgy/WUZJ14kJK1fTvDqDo5To3j8oGiIZVhSRBwyVOibAJePnxhtSy43uPx3X7a83pwM45R4laQqvXZm8c6VHyXNcDs95GVm5ONbO2zumsz/DX5rOvv2muhf8ud05JoJOsh7XtOfEzFZJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQUldyuKN/p9rpiwuLYDV1KnWmQ6SfUlM5bUhuiX0YU=;
 b=H4CwXH8piF1dVe8amArce7QdJwWcJpmGBIomL9/Ucyx4NMDcc0JpHe1WNJIgbQxDR3D1QVzjX8L7zmR+CauwC2+wtxsUA9WVvvDWMlYWpHOXxrodJhbK7uoNoJKw0oFOvinGLHdzJMxIjVkbikCDtuUDmyjsRtCyh47Z7u6HoVQ=
Received: from SA1PR10MB7634.namprd10.prod.outlook.com (2603:10b6:806:38a::17)
 by CY5PR10MB5962.namprd10.prod.outlook.com (2603:10b6:930:2d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 20:50:35 +0000
Received: from SA1PR10MB7634.namprd10.prod.outlook.com
 ([fe80::5d7d:6585:d28f:3d9b]) by SA1PR10MB7634.namprd10.prod.outlook.com
 ([fe80::5d7d:6585:d28f:3d9b%5]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 20:50:35 +0000
From: Yifei Liu <yifei.l.liu@oracle.com>
To: Shuah Khan <skhan@linuxfoundation.org>
CC: "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        Ramanan Govindarajan
	<ramanan.govindarajan@oracle.com>,
        Sinadin Shan <sinadin.shan@oracle.com>
Subject: Re: [External] : Re: [PATCH v5 v6.11 v5.15 v5.4 v4.19 1/1] selftests:
 breakpoints: use remaining time to check if suspend succeed
Thread-Topic: [External] : Re: [PATCH v5 v6.11 v5.15 v5.4 v4.19 1/1]
 selftests: breakpoints: use remaining time to check if suspend succeed
Thread-Index: AQHbE4nFHDEtN03TUkar24PotL30tLJz7wSAgAADUYA=
Date: Wed, 2 Oct 2024 20:50:35 +0000
Message-ID: <4D45C90F-EAB2-4CCF-A240-9BD84C299A6A@oracle.com>
References: <20240930224025.2858767-1-yifei.l.liu@oracle.com>
 <1164a0d6-e12e-4ec9-9a32-97ba4e1d9548@linuxfoundation.org>
In-Reply-To: <1164a0d6-e12e-4ec9-9a32-97ba4e1d9548@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR10MB7634:EE_|CY5PR10MB5962:EE_
x-ms-office365-filtering-correlation-id: 30dcd7d7-6f57-4cd3-e359-08dce323dd57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UjZOMDc5VHlWUXJGc1VHdTU3dG9TbDBOWVBSSzRUUjdZWHEvUVpDK2JUK2wy?=
 =?utf-8?B?b2t0VkprM1NuUjdTSnMrT1EvKy9OeUhNZEdacDVmZVBLV2lFWDhMNTJsVGtU?=
 =?utf-8?B?Z1dCUWdiOWEvZmRyeE1CTVdZcytFTWFpQVVnTVJRaWJ1c3hIMEZmOVVkcith?=
 =?utf-8?B?VktQSnZHeGl6YzVTaGFVT2VNUnIvRzN6anFKNGtja2tqVkhkTlA3NFp0UmRt?=
 =?utf-8?B?Q3dLSndRVE5yRkJDT0Jadk10dU04NHNlNnJ5MGF4L3RMVGhFWmRKbkJqTmp3?=
 =?utf-8?B?OElNU2hMNTdVcnV4VHh5Ri9BbHB4clJ1ZDRiM3BYN04rSnF0OXZWKy92TlBa?=
 =?utf-8?B?L2ZDaG1HWW1YSEExWjZ1S3o0TDFtT0ZhQlR6aWpYVjB0clFreU1lakV6NXJC?=
 =?utf-8?B?ZGpWcncwZGxqenBGT0ZkYXh2UjVPTjMxUHdDNDkyR2grdlFjMi9vYlFqTmc2?=
 =?utf-8?B?UFRUdTJ5UDJwZGhlczNwc0RpazJOZEExNjRNdVZ3OVJPZlNUT240QVlVQlA0?=
 =?utf-8?B?VkRuV2w5Nmduc0lDRzJEVDdvNlJjazBNd1hJQWhyUWFjYmxPRW9TY1hGNlBF?=
 =?utf-8?B?TFVqbTNYWUhmRFl6TmZ1OEN4dVNGZ1ZYSEY1T2pGcE14U2M3aGlhTDd6T0Zj?=
 =?utf-8?B?YTV3QWF2aGRXejFSNUtqODY1YzBhYVpEMzhHejRSZDd4bVB1dGcycnNQQ0hI?=
 =?utf-8?B?Z0xpcHhYdkxseEtVKytvb1Q5Vkg1VjZXYWFMQ1Z3YUtqbWtMTWRVMGNnR3VF?=
 =?utf-8?B?K1gyYlRMY01DaHBUdGtMdm14Wnk3RDAvdmd1WVFwdVZXYU0xaStlR3pCRDZB?=
 =?utf-8?B?Z1VoMTZlS1BsR2tKVkZLb25VRjlXalIrMVluOFhqVnA3dCs5K1BKWjNPWHNn?=
 =?utf-8?B?MDE1ejR4cGRVSkQwUktXYzdYS25ZdUYwNGE1WVJkVVZCMHNNZUNkNDUwMjZ0?=
 =?utf-8?B?NXdpamR6b0ZKVlJJOGFjQ1UzS2lCYUJMT2xwWllRQmxGQm0ramk5TE5Dd3lV?=
 =?utf-8?B?QzY3OFJjQ3JOeXJzeE9pSUNjcU50L01vMzNRdnFmOUMxWVM4VTIxVUJ2UTc5?=
 =?utf-8?B?eFlkY0EwSW4zUVdUcUYvQ2IwUndONmZoYllRRFVuUmxlcFlUbGhpYzdTTXNu?=
 =?utf-8?B?RytmT0RlZ2svOGg0STVseGJQRUtBMkkwUzVlMEhVYVRJK05iaXRZQjJZVEts?=
 =?utf-8?B?a2U4dVNZUGpsNEhOcEtIK0RTMjhNVmdOU1VacFhPQ1VVcEhxSkFneXFkdlBT?=
 =?utf-8?B?dEs2VEJvc0kwUzdQOGdRRkNwMmE4QmhxYXpWZEZiQUFJejcySytTdm9YZ3ZE?=
 =?utf-8?B?d0RmQjdiTEJiWWc1d29UQzdGYnZzZHVETkEvRFE1Mlh5dDBEL0V0NkhWVWZ3?=
 =?utf-8?B?UVIzeEQ4ajYxc2V1RVhVeDRieFhwQmI1a2FpWXFseUYxZEpIaHdRbGg1UkJo?=
 =?utf-8?B?c1BTY1VmazBrTm0yVGNieXFIdjBpTWlNKzdsVVhDZXljY0xGaFROLzAwMy9t?=
 =?utf-8?B?MzFEN1IvTjRmNmRWK20wdzEvS0NCeld3SnZxYzJPNlJzWlROeFJqOThMU3Ux?=
 =?utf-8?B?dzgwQXFkMHFtcUZ6dnhETWZrWlFkOWhhV0QwdVNGUTdZU3JXK3RWU1phZFJF?=
 =?utf-8?B?dE1pODBaOEZBajlhRkswMGxhMjFiQTRaVlNVTUh3QzBuY2VWdmNaK2RNYzhp?=
 =?utf-8?B?UEJ1UjRSRDE5bVp6S2FxYXYvV2d6d0tPcWpJemZsWEhadFRsVzc5YmFndFFy?=
 =?utf-8?B?UFJkTHYxNWllVU9rdU82eWlRZWJIWVYvTEVFM1IydFQ1dVozK3dETVBScERF?=
 =?utf-8?B?WFoyUEZNUWdTdlRsRnRkUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB7634.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WlJuaEZkVWUzS0RMdnpIVndqYS9FczJiSTgwbG1wSUtxM2hvTk5lK2hkUGNh?=
 =?utf-8?B?bnFwb0pYbjVibGJsREIyUUhoWTlHcEd0M21WOWVkM2ZWdHM4R2hiVU5NN3JH?=
 =?utf-8?B?R0p5S0Y1UDNQdnV1cG5tOEhFMVlrUnNtWTh2N0Z1aVlsUnFiN3lxQjdmN1Qw?=
 =?utf-8?B?N1FUcG1kMFRQZkxQTVRZMHh4NGRIYnRLaTZNZ2xGaWJQZFA5b2FGMEZhT1BJ?=
 =?utf-8?B?TjlkSFBJd1RrL2JQdTM0WnJJaTNDNFZacG5JdTRVWVEwWGY4a2ZoN1pMSm4w?=
 =?utf-8?B?R2k4QW5LSExxaDlSTUVIeU40M2NpcHVtMlk2dko5dnZ0a2d2YkJ4YXZpVkVj?=
 =?utf-8?B?NFJyS2U5TjlCYi9zK1czaytMRXVzWXZlS25pYkVQalRyNStaL3pqMjBIdUt1?=
 =?utf-8?B?NmljMzdvV1lkcDQ4QmlwbDZhUmNzVVVITUxudWlickJSY0F5ZThYb01EaVFR?=
 =?utf-8?B?WGlXalV0bWFaV1JxRTMzc2taVi94bjNsRHhaK2ZhNm9UbWpLNzNVakkwZXVP?=
 =?utf-8?B?elpQQ05ydExjb1E1c3lQelplVUlmTnFpRzNtVGlHZ3pZT1pMaVBXNGtUUmt1?=
 =?utf-8?B?czIrbEJMaU42U2ljT2d6Qk01cEliU3M4dktEV3IvajlrSzAwaE90akh3ckF2?=
 =?utf-8?B?MUdBemVCQWRMY0Nha2lhekdkNFIyTHZlOXZxRHhUcE44dUhjZlpEaEFsTy9m?=
 =?utf-8?B?U0RXMmNoNy9odW5ZTnJUYlk5WGNEOElGZUVVcW1Ec1pwK0lSSnFRTXRleHVD?=
 =?utf-8?B?emI0QzhGMEpVd0VyZFp6YUJYVXNhVXk4TVZ4cnlybHZjODBWckhYYTViUEw4?=
 =?utf-8?B?K0c5UjBjZWlnb3hJaFFmZHRSWGZTR1lwOGNnQnRFZXppOGU3UlFjbjZjZVdE?=
 =?utf-8?B?QjNaeVMraDhUajBYVTdmRmEvMTIxV1JvSXZKU3Y2OVcxTzBZNmRFZVhDRHZ4?=
 =?utf-8?B?Z24xMWRCZ212aHQ3UDVta0NjbkhsRVdzekhOS1ZEaWVQdS92R2FSeDJEbzZX?=
 =?utf-8?B?TUljZ3l6amgyeEV6WlcwODFTbVhOZ0dwVUN3MzhpNXM5U1phV1N2NnlaNVZ1?=
 =?utf-8?B?UDFZbE9nRGZ0dERESGU2NHB6cGRXb0tNeGVQancrMStPaEw3WkcxM0ViczJQ?=
 =?utf-8?B?ZzFjeUJ0SmhtenFNai83Y2NDQkRyTE9EZjc1QzM3bG5HbDJ0R2ZpZGRVZDVL?=
 =?utf-8?B?NmJGZWU0Z1BoU3EwNUVFSE5KemIrdGpiRkdHMngwREcrclhUTm45clRWRkxI?=
 =?utf-8?B?YktQQ0hzSWovYzJ2UU9WTmpwTnRpQXhQOXg5b2VpaVlLdVZCM2lHT2dKREsv?=
 =?utf-8?B?TkpKQUJoUXBZMVJGWi9ZRTZqMGoyQm5QRGJrYXFtbEFLVDVLNVcvU05NVURr?=
 =?utf-8?B?OXNDTXI0TkdMUGR4L2VVblV0WDdLZGUwQURVcXlOVGxwcG5zSjhBUFNuU013?=
 =?utf-8?B?V0k4cjJwbGlqTnNRVVFmcGQveXdyaGFMcmx4SFEvazNzNXJRZ3F3cWlLQTQ4?=
 =?utf-8?B?dTJnOFhYK1AvTGQ0cks3akwvbkJHdVhVQXNNeTlUV0FWVVRwOWFzc1JiSURt?=
 =?utf-8?B?ZHRCVkRXeDVZREIyU3pZamhSVHdaRGR0TmNNNExZa3lkblRaNi9TQncvbU1s?=
 =?utf-8?B?dkVHYng5ZURNclE2QzNMcjRxNlJiazU3WE9NRThlVzlOdSt3STl3YmVFMHQ4?=
 =?utf-8?B?UzBXdkxuVHc5Tm5mMnhaUzJQL1FieDIzdlc1eVVTS0UzVzBUSFdpM1p6aXZT?=
 =?utf-8?B?c0lLcFFuaW9MZjE5VjlVRUxDczhoYVRkeUdoYXliT2xLeWQzdXpPMkxZaEFu?=
 =?utf-8?B?UEoxVzFCbldmK2k5N3ZHemdvWWpjMndSUUtPUlRVcUhMbktlK1ZFU0JPbjZ1?=
 =?utf-8?B?ME9lRzlpSkd4RzZyNStnemJJckljWlVkb2FJUHUxWEdtSGFIQVduVXB6eUVF?=
 =?utf-8?B?QytmS0xhMElzTHBjQTYyNlNKQTFEZWRmZjBTNUlBOUpFaFpCZ1ZSMVpqYmhM?=
 =?utf-8?B?TjB3bW5hNWdieW1UaTlsWjZ3T3FwNkhkRTJ3VTlBSmN0RlVtTjkwTE1oKzhT?=
 =?utf-8?B?aW5FeGlGaXlXZDZKOE5IYS9zLy9UYmJXdzFBMzIvZlNqYTlpRjBBc0o2c01M?=
 =?utf-8?B?M2NEN0JobEQyc3lnQmdIRjNMYkVNdHVRaFVvamE4MmpIUUJxT0p2SVFJbDVt?=
 =?utf-8?B?OEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D173342D7536E641972FCD318992A6C9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yw4Afi/DM5hVt4mzg4CFmpbttF0r7nsIcvl7rFGOOuTGte8OyPJ0eFSNVHUbiFWUfwoD/7aupx0fi7ZbCM4BDHwDc/2/wA8u4cvmRMmFvYR77h0hivnFtjh2Jqw8C2Oe1Z8lYvfEmRxSlTDXkIqmPlW+4Aef8ER3QXwcsI4TCBY/RJ//9oeKCnd6dOfgEUljUdKCRUirspYEvFwCWdGwXx/h0sj3AzSElxamJr/4vLNYseyYdJfcpIFvpnRQZytHfIwTdebzEdwS+mGTlGSc7v1XPstmb/adutvIdtt22YbYu0E+urmfHArQA1Z1ih6WmS16Mjs2rzl+PGqahVPCGAVRINAqFi1ow5N1zWrYeGFA3/0vA+A7OQHwtVQICn6LA82EZ6LAlk6C3GQRrBcjxDVcSv885daCw9yJxMd83r5hDf13kGXh9mbOMdWme1Far2pEGC5Sqzd2qjJQnmpRHaN/p0coEQnRNn9hm1SGvnfd+KscHxCxhemH4UQotqAXVsdDfcbeX38GKMJXmKIe7FEbWH2yhb8inRQyOHOQRcARhalnb3jYZvOFkWmbv3meDEOwU+egCVMWLtH1OqULmw3/L8F2d4NfPmhagrUH4aw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB7634.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30dcd7d7-6f57-4cd3-e359-08dce323dd57
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2024 20:50:35.6329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UaVdvQqvd5I/vHU0sGVCjUWDtdJqhzz5JGIB59eifPi/6BdQQVwBHT8+KoL7p1nFiaibym9WDdeKBSXfh33+CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5962
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_21,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020149
X-Proofpoint-GUID: fq7blU2DXBE6odb7twGwY08OPDTJ1SeV
X-Proofpoint-ORIG-GUID: fq7blU2DXBE6odb7twGwY08OPDTJ1SeV

VGhhbmsgeW91IQ0KWWllaQ0KDQo+IE9uIE9jdCAyLCAyMDI0LCBhdCAxOjM44oCvUE0sIFNodWFo
IEtoYW4gPHNraGFuQGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiANCj4gT24gOS8zMC8y
NCAxNjo0MCwgWWlmZWkgTGl1IHdyb3RlOg0KPj4gc3RlcF9hZnRlcl9zdXNwZW5kX3Rlc3QgZmFp
bHMgd2l0aCBkZXZpY2UgYnVzeSBlcnJvciB3aGlsZQ0KPj4gd3JpdGluZyB0byAvc3lzL3Bvd2Vy
L3N0YXRlIHRvIHN0YXJ0IHN1c3BlbmQuIFRoZSB0ZXN0IGJlbGlldmVzDQo+PiBpdCBmYWlsZWQg
dG8gZW50ZXIgc3VzcGVuZCBzdGF0ZSB3aXRoDQo+PiAkIHN1ZG8gLi9zdGVwX2FmdGVyX3N1c3Bl
bmRfdGVzdA0KPj4gVEFQIHZlcnNpb24gMTMNCj4+IEJhaWwgb3V0ISBGYWlsZWQgdG8gZW50ZXIg
U3VzcGVuZCBzdGF0ZQ0KPj4gSG93ZXZlciwgaW4gdGhlIGtlcm5lbCBtZXNzYWdlLCBJIGluZGVl
ZCBzZWUgdGhlIHN5c3RlbSBnZXQNCj4+IHN1c3BlbmRlZCBhbmQgdGhlbiB3YWtlIHVwIGxhdGVy
Lg0KPj4gWzYxMTE3Mi4wMzMxMDhdIFBNOiBzdXNwZW5kIGVudHJ5IChzMmlkbGUpDQo+PiBbNjEx
MTcyLjA0NDk0MF0gRmlsZXN5c3RlbXMgc3luYzogMC4wMDYgc2Vjb25kcw0KPj4gWzYxMTE3Mi4w
NTIyNTRdIEZyZWV6aW5nIHVzZXIgc3BhY2UgcHJvY2Vzc2VzDQo+PiBbNjExMTcyLjA1OTMxOV0g
RnJlZXppbmcgdXNlciBzcGFjZSBwcm9jZXNzZXMgY29tcGxldGVkIChlbGFwc2VkIDAuMDAxIHNl
Y29uZHMpDQo+PiBbNjExMTcyLjA2NzkyMF0gT09NIGtpbGxlciBkaXNhYmxlZC4NCj4+IFs2MTEx
NzIuMDcyNDY1XSBGcmVlemluZyByZW1haW5pbmcgZnJlZXphYmxlIHRhc2tzDQo+PiBbNjExMTcy
LjA4MDMzMl0gRnJlZXppbmcgcmVtYWluaW5nIGZyZWV6YWJsZSB0YXNrcyBjb21wbGV0ZWQgKGVs
YXBzZWQgMC4wMDEgc2Vjb25kcykNCj4+IFs2MTExNzIuMDg5NzI0XSBwcmludGs6IFN1c3BlbmRp
bmcgY29uc29sZShzKSAodXNlIG5vX2NvbnNvbGVfc3VzcGVuZCB0byBkZWJ1ZykNCj4+IFs2MTEx
NzIuMTE3MTI2XSBzZXJpYWwgMDA6MDM6IGRpc2FibGVkDQo+PiBzb21lIG90aGVyIGhhcmR3YXJl
IGdldCByZWNvbm5lY3RlZA0KPj4gWzYxMTIwMy4xMzYyNzddIE9PTSBraWxsZXIgZW5hYmxlZC4N
Cj4+IFs2MTEyMDMuMTQwNjM3XSBSZXN0YXJ0aW5nIHRhc2tzIC4uLg0KPj4gWzYxMTIwMy4xNDEx
MzVdIHVzYiAxLTguMTogVVNCIGRpc2Nvbm5lY3QsIGRldmljZSBudW1iZXIgNw0KPj4gWzYxMTIw
My4xNDE3NTVdIGRvbmUuDQo+PiBbNjExMjAzLjE1NTI2OF0gcmFuZG9tOiBjcm5nIHJlc2VlZGVk
IG9uIHN5c3RlbSByZXN1bXB0aW9uDQo+PiBbNjExMjAzLjE2MjA1OV0gUE06IHN1c3BlbmQgZXhp
dA0KPj4gQWZ0ZXIgaW52ZXN0aWdhdGlvbiwgSSBub3RpY2VkIHRoYXQgZm9yIHRoZSBjb2RlIGJs
b2NrDQo+PiBpZiAod3JpdGUocG93ZXJfc3RhdGVfZmQsICJtZW0iLCBzdHJsZW4oIm1lbSIpKSAh
PSBzdHJsZW4oIm1lbSIpKQ0KPj4ga3NmdF9leGl0X2ZhaWxfbXNnKCJGYWlsZWQgdG8gZW50ZXIg
U3VzcGVuZCBzdGF0ZVxuIik7DQo+PiBUaGUgd3JpdGUgd2lsbCByZXR1cm4gLTEgYW5kIGVycm5v
IGlzIHNldCB0byAxNiAoZGV2aWNlIGJ1c3kpLg0KPj4gSXQgc2hvdWxkIGJlIGNhdXNlZCBieSB0
aGUgd3JpdGUgZnVuY3Rpb24gaXMgbm90IHN1Y2Nlc3NmdWxseSByZXR1cm5lZA0KPj4gYmVmb3Jl
IHRoZSBzeXN0ZW0gc3VzcGVuZCBhbmQgdGhlIHJldHVybiB2YWx1ZSBnZXQgbWVzc2VkIHdoZW4g
d2FraW5nIHVwLg0KPj4gQXMgYSByZXN1bHQsIEl0IG1heSBiZSBiZXR0ZXIgdG8gY2hlY2sgdGhl
IHRpbWUgcGFzc2VkIG9mIHRob3NlIGZldw0KPj4gaW5zdHJ1Y3Rpb25zIHRvIGRldGVybWluZSB3
aGV0aGVyIHRoZSBzdXNwZW5kIGlzIGV4ZWN1dGVkIGNvcnJlY3RseSBmb3INCj4+IGl0IGlzIHBy
ZXR0eSBoYXJkIHRvIGV4ZWN1dGUgdGhvc2UgZmV3IGxpbmVzIGZvciA1IHNlY29uZHMuDQo+PiBU
aGUgdGltZXIgdG8gd2FrZSB1cCB0aGUgc3lzdGVtIGlzIHNldCB0byBleHBpcmUgYWZ0ZXIgNSBz
ZWNvbmRzIGFuZA0KPj4gbm8gcmUtYXJtLiBJZiB0aGUgdGltZXIgcmVtYWluaW5nIHRpbWUgaXMg
MCBzZWNvbmQgYW5kIDAgbmFubyBzZWNvbWQsDQo+PiBpdCBtZWFucyB0aGUgdGltZXIgZXhwaXJl
ZCBhbmQgd2FrZSB0aGUgc3lzdGVtIHVwLiBPdGhlcndpc2UsIHRoZSBzeXN0ZW0NCj4+IGNvdWxk
IGJlIGNvbnNpZGVyZWQgdG8gZW50ZXIgdGhlIHN1c3BlbmQgc3RhdGUgZmFpbGVkIGlmIHRoZXJl
IGlzIGFueQ0KPj4gcmVtYWluaW5nIHRpbWUuDQo+PiBBZnRlciBhcHBsaW5nIHRoaXMgcGF0Y2gs
IHRoZSB0ZXN0IHdvdWxkIG5vdCBmYWlsIGZvciBpdCBiZWxpZXZlcyB0aGUNCj4+IHN5c3RlbSBk
b2VzIG5vdCBnbyB0byBzdXNwZW5kIGJ5IG1pc3Rha2UuIEl0IG5vdyBjb3VsZCBjb250aW51ZSB0
byB0aGUNCj4+IHJlc3QgcGFydCBvZiB0aGUgdGVzdCBhZnRlciBzdXNwZW5kLg0KPj4gRml4ZXM6
IGJmZDA5MmI4YzI3MiAoInNlbGZ0ZXN0czogYnJlYWtwb2ludDogYWRkIHN0ZXBfYWZ0ZXJfc3Vz
cGVuZF90ZXN0IikNCj4+IFJlcG9ydGVkLWJ5OiBTaW5hZGluIFNoYW4gPHNpbmFkaW4uc2hhbkBv
cmFjbGUuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWWlmZWkgTGl1IDx5aWZlaS5sLmxpdUBvcmFj
bGUuY29tPg0KPj4gLS0tDQo+PiB2NC0+djU6IFJlbW92ZSB0aGUgYWJvdmUgcXVvdGVzIGluIHRo
ZSBmaXJzdCBwYXJ0Lg0KPj4gcmVtb3ZlIHRoZSBpbmNvcnJlY3QgZm9ybWF0IHdoaWNoIGNvdWxk
IGNvbmZ1c2UgdGhlIGdpdC4NCj4gDQo+IEFwcGxpZWQgdG8gbGludXgta3NlbGZ0ZXN0IGZpeGVz
IGJyYW5jaCBmb3IgbmV4dCByYy4NCj4gDQo+IHRoYW5rcywNCj4gLS0gU2h1YWgNCg0K

