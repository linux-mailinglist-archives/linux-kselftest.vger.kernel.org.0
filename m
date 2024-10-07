Return-Path: <linux-kselftest+bounces-19148-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6B9992E2A
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 16:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2E9F1F20F10
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 14:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9ACA1D279B;
	Mon,  7 Oct 2024 14:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a9t//1nh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TuR6f1aU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239141D2F6D;
	Mon,  7 Oct 2024 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309754; cv=fail; b=VvcO5T5xn5Vdk+CmTYhrYPfILfVeXLruRqyNVAYeKXmA7giMsNtaMdKm/HEu0IisZrm8Y88iDTT1ktzOAjKs/VujFK36r0xmj6LiWHgPhUss/lzKLcThCoWyUKOZLBrIvesk0pKeMObg2mIkOrdtJjtGl042siBhZ9pTLZxKUSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309754; c=relaxed/simple;
	bh=1T+Z7aYMo0KmE6adPI0hyfTn/Dj04aPvM5l7RWbfgZc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dyH/zLtqK9/xweiigXcL5D9xdKGGine4hxqZoUsCLwF0Vcgiks5q1lxU4T5UPd7FcljQwKUt1x6Za8GGAC1v+y/RwEaLTAxhSgf++Ym0UXfRD9wV9ai/qAZ8nnGplyN4MR0x11L7zauxfoUEYuWBmVpI5edV/N1vm+rv4m3Iz7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a9t//1nh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TuR6f1aU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497CtMYg023712;
	Mon, 7 Oct 2024 14:02:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=DZUeQL0ZBJDZD9ea7fpv0wMuFqPNLuv8zSHmNeIN/Yw=; b=
	a9t//1nhqVYlzNed43rHjVI81fPCb1iPbFe5j9ePZ+mDbffBaTlKFC86NAsVj0Wa
	dgavyM/Ok+g5MUD79Z1abb0hmiSL351px9lfCO5viz3J6A0YnRhjdLWIbwn2ld9/
	/pIpirgB8Bfd99i7WGkgaoGFnfH+y1+xGtBUKNH4BEaKv27ey9v+9LHhpGi28evw
	n+kxEx7FDgy41fTqV6+FzN2nTjdRbnYiMnA1X5eWPR2jovsbAjSn7lzKfIfcAuaD
	7hyMH0PhvceyPU+LAXma80wRpAEnfB9UapZpCqU1k2i3M3Ryb+Q1IYA5cP4r16Xu
	nUIgUHYKoPwy/RplQj2AMw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 422yyv3fqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 14:02:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 497CJFtS011495;
	Mon, 7 Oct 2024 14:02:13 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw5tc1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 14:02:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VG/AA/NWepv0dkx04hZzgVSQxFRCWm6wfs+Yv9HZD03Z4+Zhxk4Rzo9R084p3J5VYQGKwlRvUZsA8bzfpNgsiox7eC22NEk5xVZaXMxI4VSMijEYShHue1znA/h7492fB3SXgGwI4N/oIzPU1mnifVKpSgMB+Hy1dBbVp740JOc9VJpvyP/hV0yBVorm0FLeoYvsLNjSFi1nnIZNAK6OhveWsNS5XVDV4V1wXF6Q8HQMy8Qd4u08No2Ik4efwZRLjguM5Sq0Cg6DDBtsi+ARYqDsRWYQsIbnci28nB3pRGGu0rfNR1FPydelb2XndqSTw2vYGsU5383NsZCS8Jn2bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZUeQL0ZBJDZD9ea7fpv0wMuFqPNLuv8zSHmNeIN/Yw=;
 b=mldlw/fvQRqVclMtSnwLXTaFAh/Qh6gQRPXHeuvLaaiEFsfe0GdNjSxAI8UqxQBNyudCzk7UJDoJABmEDmK10Hgb9yVR2tUAOAzB079IDQrYb8FEKANShIZBfqWQKEZo7C0/FMQpres4zCsSC4zOzNPu7dzg5f5UlNXRCUOxyb7ugmf+qMbnLgDz2C3r108c6mj/vvz4ckQ1+BMWwcpBaLEf+loYQ/YNjJaR6HhbrzTiI2FBiMlIicNU4K5/hOeMGDn23hom55eBl5QHM/tMYNND80H2lhoEZsvYD32maxyq7oJhgnghLmsIGKkmLG4tUEGuPeB5lfMw2pJ1dSLO7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZUeQL0ZBJDZD9ea7fpv0wMuFqPNLuv8zSHmNeIN/Yw=;
 b=TuR6f1aUu/G+rsfJBcfzPnUbTVq/b3LCQYeoMHKkt/3cVZtECKIikvcLwAqeaMSW14uxrfCTVo17ojZGng2aIHXdKPh5Pzf9bNWyWQKrVi7zL0nnFiQXXg1Vg7JC9XU9kd4Fs020h2eKlxTdaEx7pAJTxWMZGegRPO7cITSafGM=
Received: from BN0PR10MB5030.namprd10.prod.outlook.com (2603:10b6:408:12a::18)
 by BN0PR10MB4854.namprd10.prod.outlook.com (2603:10b6:408:123::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Mon, 7 Oct
 2024 14:02:10 +0000
Received: from BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::44db:1978:3a20:4237]) by BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::44db:1978:3a20:4237%5]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 14:02:10 +0000
From: Liam Merwick <liam.merwick@oracle.com>
To: Maxim Levitsky <mlevitsk@redhat.com>,
        "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Merwick
	<liam.merwick@oracle.com>
Subject: Re: [PATCH] KVM: selftests: memslot_perf_test: increase guest sync
 timeout
Thread-Topic: [PATCH] KVM: selftests: memslot_perf_test: increase guest sync
 timeout
Thread-Index: AQHbFqki86hSCOc58Uespab1L7kvkbJ7ZQcA
Date: Mon, 7 Oct 2024 14:02:10 +0000
Message-ID: <9071cc6f-05af-4f00-9a95-3b413b92de84@oracle.com>
References: <20241004220153.287459-1-mlevitsk@redhat.com>
In-Reply-To: <20241004220153.287459-1-mlevitsk@redhat.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-imapappendstamp: BN0PR10MB5030.namprd10.prod.outlook.com
 (15.20.8026.020)
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5030:EE_|BN0PR10MB4854:EE_
x-ms-office365-filtering-correlation-id: 7f8f6eb6-b60a-4399-4f01-08dce6d8a31c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?q3lRBrvMbzw1/Sx479ynjzqiH4c7IuoZKJ/NVi0Vaibi2//rZOLR+F7SbP?=
 =?iso-8859-1?Q?rwQPCR3joEBRy4Hvwx+PrdErIJjMaJOU+6dcDJ7QoHb/kg5i6YYVvOjjgu?=
 =?iso-8859-1?Q?xhi6JN5FgEKAWCpglXuEpAUOmJqW4CySqv0EqfqvERN6EswihzNiRyYu/g?=
 =?iso-8859-1?Q?1ibyda+cDRfsdUCK8hIFUBx5CQqj59QQSc4i2UY5floGLjLwhb2XLJkg1Q?=
 =?iso-8859-1?Q?VRTp7fefp4dXnSTWZdnRVjuGZyudxhCFk7fpFZirH4+kMnrFqdlCpVz7UR?=
 =?iso-8859-1?Q?Ttoa7IiYzcMno/Jfvj4pEROM5IfInbIeL324gv1i41+k+cnV9UYrNva9Hd?=
 =?iso-8859-1?Q?mO31cJ9fn7Ua4Koxfb3ad+fv8vwVeeOJgF92U4bbiW2gTzR0ismZWZ8JbT?=
 =?iso-8859-1?Q?NHiTUhAoqckNvURRT7uiz3oBu9IJDw/dzYL7FbWdWY7s7XD+AZIZIddW++?=
 =?iso-8859-1?Q?DbM+90mdCQqaBH3dAV+RJoa0WceNFH4MzB1c0/+bTZpGiNLdIUsqZoo6sa?=
 =?iso-8859-1?Q?OGBmbLSK/fXy0tH3/F2xoQtjBIwfa5LjgYo5Rhr7M1lgzXCJv/ovhhhCxJ?=
 =?iso-8859-1?Q?bOoD1s6g85/GGmjJ/OsIfRhSinPvwhU2AqyPmedmzAJaVAx3eGv1zFt+Xx?=
 =?iso-8859-1?Q?pMqVXfL5WhQStqvYNK0B1sylswXlb+Oyxk9mNahVb7DKg3v7fijIaWdnz1?=
 =?iso-8859-1?Q?yWCf0FrZwtNyShTtwLfRWlxKDqwJwDlDpj/6jzsLGKwlUnd3DNnW5L/SIx?=
 =?iso-8859-1?Q?zMX5iOETLzvImHOeptkqXcZYURW5uNDaqi/PRQnN1zy3cL+V7JhMwXf3DC?=
 =?iso-8859-1?Q?dNaJ0mSsqcyKkZDqfZmIuZCgf00ljDAjNlD82J6WpOExdq7tNpGqvKqs+b?=
 =?iso-8859-1?Q?cppEnIxS88iNczU/Gif5Nlz/tnS/Idy/vY9DMYUZUxZc+05Z1J96WJwj0N?=
 =?iso-8859-1?Q?tRuVdLFsfVQXLtjGI9yfjrRZ8BScmTZXEl/WYgbWup6SSPWgF8EJoJgsnI?=
 =?iso-8859-1?Q?V22J6/N4niNs4trn3Irk7JVjkoOtX4B53dahRkN+MbwBW0wFnnzeZ1GV9j?=
 =?iso-8859-1?Q?JqXHWCkLohh1FVqv8WJMJMNsl/b45sW22PJdIGKfYwmtwtI3a02gMrOakW?=
 =?iso-8859-1?Q?YhCdfJT8H5OYoeJehXl2HhvqBfuTZN8gTMWIvhYstgaGbRsFX8aPtEZHlE?=
 =?iso-8859-1?Q?jiT9V1jyOXtQwSp/pLBBsadmP1PW7HgwI+3bwE4BJf+/1PDy0A4Sgs/aDE?=
 =?iso-8859-1?Q?O1r6x2XvvFHqCF1HSlHpAIomjdyGF6XbURwC4YQPNLdqckZR/josvDkeOH?=
 =?iso-8859-1?Q?NRDKww/L3kaxRTmWM4wo5oE8bqd4Or8JDrbRzJ+0+qHXNscXkbLCpe06PF?=
 =?iso-8859-1?Q?/0YlHOr56QpNiw5jvUUbzJaCCnh5Nifg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5030.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?DazZD2TR4LnXSd68vtYarEi5oWLOtnZeDZiQMkUL8HIiqVK7gAd2JXbmLc?=
 =?iso-8859-1?Q?VEJI3uIIRNpw1vanDO/V9QVegV2hB3ulicD2oV13Ux4XCtxrmuzLoMYvsO?=
 =?iso-8859-1?Q?Je22mtU7Obvz3ToezS/MCVeu7TAfaWR5RTlKrQoc9xv5CF4qHvNlS6IGYh?=
 =?iso-8859-1?Q?8iaSe54lAbquIuOUaWGQmTf8eHCXh/vwUTDfe7HvvR5ZP067xOsLvF8N2l?=
 =?iso-8859-1?Q?XWPo+w9R0nm4k8b8dHLBRUaB2qmebPyd6F269JjBADcLKx1tO5aCWxCuli?=
 =?iso-8859-1?Q?qbWB/1kOjzd2nw17JIhmaCkhBOsC8uZSXxWv7e/3a8HUaabV6JjHXbu6pr?=
 =?iso-8859-1?Q?rZp7KHqYu+s+nNHJRUIQ/Jg/mxwSOdadLEkBF1M9qj7cE7VRxSYVRC0n/N?=
 =?iso-8859-1?Q?PQQsq0L9GVudFhT95F86kxsGUICtIAPLHlpajSsd9TOrUqLyBdb4hPYDIF?=
 =?iso-8859-1?Q?OE+Z329ZWTx2j7MPDFFFmBWg02jx+4HrOlq4ENWRG5bg0RdCyzyMj5AANo?=
 =?iso-8859-1?Q?DFIm6HejtTz/PuYPcrl9eVdzuS37s0d0cUtQa5dOgYlEA+z148zfWpJq07?=
 =?iso-8859-1?Q?KnDBvrlThAlkx0ZUEDA1Dfmkx0P73eQgEJlSMLTmLfj1DvjvoBPK3YblVB?=
 =?iso-8859-1?Q?HgAOcjopG2lzTjiNNhXKelQE2VHAvgHrL2FO9VcTqYdMdL8kqlrvO9Z0rR?=
 =?iso-8859-1?Q?yw3SLzJpgGJBa2yKiF7dizaHBqMhm1+IenzQ/i3wj8f2UZVmfpx8VpSv73?=
 =?iso-8859-1?Q?KR9tdL/xn1bonwBTa5/0wW3RVRc70dKjk8puz018iE+KPfUXhOvQMMql7k?=
 =?iso-8859-1?Q?0O780NZiLKUOJfoMahSQviVYw+QIoMt9W79BMY4ShOe1qkwRbBqckKgEFl?=
 =?iso-8859-1?Q?BKA4Q3CuHHs+oC3p5jq6D+hd55x0OGhTcfXjNQ+xbZ4ww5QMcbhsDShFnj?=
 =?iso-8859-1?Q?G2k+lUdUzxpEqFXfGAEHDmRdGqt92pnNrseIOicUlj3PUVDPV1MwrhgOlp?=
 =?iso-8859-1?Q?fSZGvZPwenmw9n8NyLjI5hEjIdXh629tYhICUapbysmrMTcpugsLAbaETV?=
 =?iso-8859-1?Q?Y2pPg9fyRc0j17rHh3UGAXX9uozCRWfuV4g5QH2nhyWXm+rhMkT0Lzj7rS?=
 =?iso-8859-1?Q?U3FLZ6P0tprU4OaGGlNkR5co15FmYye+4Z8ktnxW/bAybPw+f44o5/gKev?=
 =?iso-8859-1?Q?PmwSBEjNwpKyB6DrGWNOjdkk6j8qloky6BySRne/j+qFdjEgRUsb964qn5?=
 =?iso-8859-1?Q?GfSv2fUXO3USzHtKTiDGnmluzTlTkKTBYr7zhauloXf18PmL3P2GxrpIbc?=
 =?iso-8859-1?Q?p3+t0VlyXqevUo3yEaYfR6MiDlgwl4xEiJrz6OYteZkwLVFCNw/5pHR3Yr?=
 =?iso-8859-1?Q?Wd7E6i8IWEpDNz5YLSzMG9XMjIzNZKjuzOMyRSjDtnoN5SDrVD8qHd0joS?=
 =?iso-8859-1?Q?cojZlDj8qJ/iHIVTkvkBwWgufi5M8IsL+c89hVUzw4xCSGQcfE53gnvwUA?=
 =?iso-8859-1?Q?ZQQKVODmOPV1/BlIPK7nES7frWGckzN+ynNF8UXBC6S2GHlsTCVxE12gkX?=
 =?iso-8859-1?Q?LG+DJU24TQNKIb/EpQTFWGj0pcK4rci0vfKWDBOk7LpqdJUfqc4BGchnDE?=
 =?iso-8859-1?Q?VlF5NQwVJz7gNZ6/pO78IQ59SKandg+A3T?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <82C217ED7C50B54DABD964D54E28B0C8@oracle.onmicrosoft.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rU9nsrB+aai6YS+WTydysOq1ejfxxUeOoCrfAsa3It4uLzK5u21cl1FKunWrKLzE4y0fVjFgOa9Ic+33xGPE0Mh0tZrtJ6unLDCl6eiHdobnmUENufz7Jxvr7wCZ6TUA4mmVf2CSHNbnQSnXMdLTS2pSh8TfHe2qIfoqNzR0I2HWn2qcEPhaER40RlgzpPNfFR5NieN+InyOk3zNesA0fZwENJYX4O50nLBk2HBRSVKwFCia95sClYfleRxcXQvwL+mbiFZZlcEzcjj6KWXDMKZ9i86j1TSQtt/cKMv22KldEfqvktL3Bqj2CFa4YIi1eVVsEgakLPD9I0UtvErZxlDsUetVOVA+bUDnuPOQNWyx5c5s3NOkepprcSRHmblne6lx+NY5ME7LfeA0ArB8S4U2MLGzvnznVtJDxJmmAGkcdxdvXxeAPOKS9L7Zl2kxnK1pDiYwAxJD4tAlrVC5o6SCopWZKtE/Osaphde0eeCu5/7F+W++iG5zb/kfSb+oY0Ns5aCshnei9HqQN7cRX0G5CECoAjF228b132U+fWxPCxDnzqjVbnTtlG5Q6/UYdO2zrCw986VPwgj6ukWC2n8LwW0M0niYJWyRd9oPE7A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5030.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8f6eb6-b60a-4399-4f01-08dce6d8a31c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2024 14:02:10.3553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6JhNl7prxsGuM8+X5HrJoD+FOOy2FoZ5RxJPWSB2Xua7uyoHdLChGAme/Dn/tOMdsaJRsQ+JdsOgbk26hgBZLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4854
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_05,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410070099
X-Proofpoint-GUID: W3JUGWqNdW20DBKOJjdSHD6z_5Ux1GAi
X-Proofpoint-ORIG-GUID: W3JUGWqNdW20DBKOJjdSHD6z_5Ux1GAi

On 04/10/2024 23:01, Maxim Levitsky wrote:=0A=
> When memslot_perf_test is run nested, first iteration of test_memslot_rw_=
loop=0A=
> testcase, sometimes takes more than 2 seconds due to build of shadow page=
 tables.=0A=
> =0A=
> Following iterations are fast.=0A=
> =0A=
> To be on the safe side, bump the timeout to 10 seconds.=0A=
> =0A=
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>=0A=
=0A=
I see the issue without this fix.=0A=
=0A=
Tested-by: Liam Merwick <liam.merwick@oracle.com>=0A=
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>=0A=
=0A=
=0A=
> ---=0A=
>   tools/testing/selftests/kvm/memslot_perf_test.c | 2 +-=0A=
>   1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/tools/testing/selftests/kvm/memslot_perf_test.c b/tools/test=
ing/selftests/kvm/memslot_perf_test.c=0A=
> index 893366982f77b..e9189cbed4bb6 100644=0A=
> --- a/tools/testing/selftests/kvm/memslot_perf_test.c=0A=
> +++ b/tools/testing/selftests/kvm/memslot_perf_test.c=0A=
> @@ -415,7 +415,7 @@ static bool _guest_should_exit(void)=0A=
>    */=0A=
>   static noinline void host_perform_sync(struct sync_area *sync)=0A=
>   {=0A=
> -	alarm(2);=0A=
> +	alarm(10);=0A=
>   =0A=
>   	atomic_store_explicit(&sync->sync_flag, true, memory_order_release);=
=0A=
>   	while (atomic_load_explicit(&sync->sync_flag, memory_order_acquire))=
=0A=
=0A=

