Return-Path: <linux-kselftest+bounces-20147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 631AE9A429A
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 17:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82C5D1C21675
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 15:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B045200CB8;
	Fri, 18 Oct 2024 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DsPC8Gz3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lBEls1Yh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212AE13D52E;
	Fri, 18 Oct 2024 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729265831; cv=fail; b=JVyq7gRzYc58f0tZZLS0VFZ2Lr0XUKgKYri9rKHBLmuCpY9ezKNdVMe9NgnKS+WjTJzWeDbrCeUl/999wGHFm87IysYCCKPEJ7x93tazlbzr/qqxdTuFM4/ssUsUWTWAlQJVFKIR9/g9V2LgK2TGGQYBWqC/GDV0enHqV2eyZ+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729265831; c=relaxed/simple;
	bh=HVrV5/F9I0HpOfO8iF6Bit7P5nMmGcZmcyG816QySzw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oBcWK0fLFDDrdyuLNwNalHPdHEl4sEfk//YUJNlRW0FLHe+Ymf36N7elEbFaVY1EN9D58ggduM09NxsShhxU4Pt5tQ4fH1tQQWuIWHUTaY9w5SRpSXLyGSACTmB231H/smg5OKyZxAufitC0atZMDeP1yxyQIVevLP8e074m3KE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DsPC8Gz3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lBEls1Yh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IEBghQ019364;
	Fri, 18 Oct 2024 15:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=HVrV5/F9I0HpOfO8iF6Bit7P5nMmGcZmcyG816QySzw=; b=
	DsPC8Gz3xSK6ioDrgciVoxjJujq2h45k6KUL5m48z46uKAX4KCvXxBM6KKMLfFvc
	LcfcX6ENqd0XDpGFDtzTErmWI35kZ871YMjBc4TxCspHuUtDnqVg/VJU0eRZiyo9
	2L4/5eY2lkpTab6eRd0g7HHBi5NvHAU1LtzvzIesJY0XTvxTGNQmvO5RU4lEAoMG
	UCoY0Xx32NrUnm07UVOioOCOTD9odasmS5p9IoiJ2p4YBiqmuThJMA7tmnt+QYSD
	pUkd7qumdT/CG1ngVpzltcE5aQZFyB0KKHhYd3MjYGug+dY0D1Wqu0Mdqrojrf7Q
	8qw5m051D6/0VzF2KZBN4w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhcrqra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 15:36:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IF2jRF026558;
	Fri, 18 Oct 2024 15:36:50 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjjbvkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 15:36:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YckOJLK0QIvU/1Obefo5TPZT9fXJLCOA4U1OZTwyxsL9KUwWA4gjTf1C36XS5LfpliGEFC3Su8bm5key28fm6MT4lYVLibvrxHvy0J36Py+wqUbFGsp+jMU7KaRlsrOq2qCQcZYYHec3Ou5uAPjm0K5U7oDUi8zGK4fJmEw+hxNssbu0s0xJ2PE3BQ2UBXJDzm3OcSUwNGd9/ZZgk6/O0sZppicv0BYMZhIJnMKuo6qTpxWPflVyVcJ8GruEH8X/walNStPIKtfqVhQcnJmP+oCY7bKENl/rfNBryHnAK2qZ8zB6ey0ATwkPU8XIoANybbSQyiSNUz1WBsQVUTkiuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVrV5/F9I0HpOfO8iF6Bit7P5nMmGcZmcyG816QySzw=;
 b=yuNm85vpD2SYGvf4XFustzpAbyWQPQVDvQJ+6PxYBA7jS/Lbb1Xt10h3s7OrF1+QwN797i/0sy0W5pK6Dzb9Ojk3TGLw5tlruCkHnwCEarLfaugWcBmGTJzeZ/4MfDDHlxsornKLqs2nkNXoCR/0nGiNdyoPmkDOsHp3CJK4+o2ZKjwRs3bBSKpE5Nt3R8sIOrYeaq3lvWr5Ptz+PNb14iV9bX3qd4emGXsm1Qw5jXsUuTxnbPcl+OA5+beGR4tOZh81MJGxOObWLaAeDU2aJh7CayQGe1zYJHdW/YDjn+BsEln0G2gILijMVbKug0Vs9jJNrxfHbnDmjbXYHtRaqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVrV5/F9I0HpOfO8iF6Bit7P5nMmGcZmcyG816QySzw=;
 b=lBEls1YhdiCaaC2x994ZwFOJ8GyaDxlrO7FCEqYMGGqZaBaZwAE7AcmNc6YGKtiu2iDGinJoHajrrd8E8cp7M0p1PWc5lb8YhyrwwKc6C2/w639yNmtps+oYmLSp+zGIUooa6qCJkcMjWe5mGhGfZVffJrRDwYE4SheRCpNBVHo=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by MN6PR10MB8024.namprd10.prod.outlook.com (2603:10b6:208:501::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Fri, 18 Oct
 2024 15:36:47 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::3c5e:9043:1ca9:4c60]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::3c5e:9043:1ca9:4c60%5]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 15:36:47 +0000
From: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To: Simon Horman <horms@kernel.org>
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
Subject: Re: [PATCH net-next v5 3/3] connector/cn_proc: Selftest for threads
Thread-Topic: [PATCH net-next v5 3/3] connector/cn_proc: Selftest for threads
Thread-Index: AQHbIMB2FIhLbAFOh0i6pbkkCWpoc7KMSMkAgABcvgA=
Date: Fri, 18 Oct 2024 15:36:47 +0000
Message-ID: <9A12EBCC-E23A-432A-80B7-F982F15C2573@oracle.com>
References: <20241017181436.2047508-1-anjali.k.kulkarni@oracle.com>
 <20241017181436.2047508-4-anjali.k.kulkarni@oracle.com>
 <20241018100440.GF1697@kernel.org>
In-Reply-To: <20241018100440.GF1697@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|MN6PR10MB8024:EE_
x-ms-office365-filtering-correlation-id: c18dee68-59d3-4fc9-f7c2-08dcef8aad68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VGMyQzRVcGlNNTUrY2FKU3R0dVp6N3NiUVNPZnJ3OStxTW9vQU9vby9zWUdD?=
 =?utf-8?B?KzhRVmEza0dIZitRZHlEWHk3b0pDZnp4dEh6WC9nSWhieEMvRGVvTmFJMFZm?=
 =?utf-8?B?SHIvZU92UUJNREJlVmFrUWxjVm1YVEZkU2JxdWorcklIbkVPZXhpZ3ZlY1ZJ?=
 =?utf-8?B?QmV1NExydG9SeTBQd0xYS2xJSUNBN3I1S0NNNFVGNUpZaEU5MitBWVRvMzUw?=
 =?utf-8?B?NXBCSk1jM2JOcW9idWgzUEVnSzFnK3RMUitHT1RLU2lMQ3VVclJMeU1QNENs?=
 =?utf-8?B?T1pWUHZ1bHoyNjdXcFdjTkFObUloSzFrK2VHdWptVmVDeVBraGFEZ2FjSFR6?=
 =?utf-8?B?Wnl0dndSNzlzMjZJKzduT0c3NlFWK0c4aUkzakt5eDJXWVNqWkh2QlJOaXNK?=
 =?utf-8?B?OFpQR29KNi9QS2pzWWRSZ0JzYlplUjZtZDh5b1lRaHYxQ0tXLzhQWnJWRHZq?=
 =?utf-8?B?ZHIxK3MwRjhGT2lJcFhGV005MW0xWTM3a2Q5cmE0ODZQSWRZclI4Z0RsN0k0?=
 =?utf-8?B?Zk5LS09JSmx2SzNReVEzTHlKaHdhTHpSZU1zbThEVThGNUlJanJGS3FYdis4?=
 =?utf-8?B?bTVOMFVObjNFeWp4VlZqOElEbC9uZkdXQ0J5VEF2STNqdURLcCtsR2RBVHQ3?=
 =?utf-8?B?Y2JaMWswcDBkV3dWRmkxNDhFR3g5TEVhRUdFR3lzQ1kvVHdzSXZPR2VZQnRn?=
 =?utf-8?B?bkFjY2ZzcGZpdTlxdzJheUIzbTFFYUlGbzJqRjd5TzFTVURDY0t3MktiOTdz?=
 =?utf-8?B?ZzFYZW1lWDFrM1RXNHhUR1Y0SGVDbVVOZEZlVHF1UTh2aVRlTXV3Q3puZ0ZX?=
 =?utf-8?B?anF0aEY0MUhiVExXb3I2NC9TK2xTK2lLVmsvbEFmMW9RNmtoN2FHSWdXR3NC?=
 =?utf-8?B?cVdUanhaM2owRjkzMFJRd3oxKysrY2N2WXpYaG8wdkt3MW5RTlFLU0RCMVRB?=
 =?utf-8?B?RmJ4a1kwNXZ5bXd6aG9OWDhhQko4QkM0ajZJam16OUZqWDBHN3J0VjA0SXZJ?=
 =?utf-8?B?dnhBekJ4cFVGZE96Zi85eDRrTnh2QVFjZ1QrL2lIa1p6bHVycDNIZ3dUUzJM?=
 =?utf-8?B?OU1YazZPTTk1YXVDTVVSdEwrMVVENXNCdTEwdFJwR3lFOHkyRlNYMUZ4K1h4?=
 =?utf-8?B?QUNnemtsU3ZwWnJDZUZ6OE83emFTZW9HL3JEdGxHNzRWTEsxNFVhWkw4czl6?=
 =?utf-8?B?U3d3ZTBjYlIwSXZhR3FJRXd0MUhCSC9Hd1BSanBRRTRYSE1TUmxPVTJpY3dz?=
 =?utf-8?B?K2NDVjNBbmlBM1BDVzk2NWZhVTB1ZmJjWjRFMG5CbVQyVlpkNkovOWQ1aDgv?=
 =?utf-8?B?dFVLSjlZTkRablc5c1gyUDBRcUo1Mi9BNkt2dmlyNWYrSytFVTgrSUJmOHJo?=
 =?utf-8?B?YWNDTUZHb0FVT1Y5dmNZZytZbDdkMW5pU0hQbXI5Q3ZWUVFDa3B6QjJwTGU2?=
 =?utf-8?B?RS84NVRxeXV0eDYwY2xIWGIzY1lCRHQ5UDMvY0EwbEhtRWMvQVpHb09xOWUx?=
 =?utf-8?B?cjBFUXBvamNjOWcwN2ZDOGdEcXVHN1B4MXZMOFYybUtya0NPMGszREUvd0ky?=
 =?utf-8?B?aDhGa0ZQQ2FOL0dRTzlsWS84VEN3MjJUTHRRV3daVjNaa3p4bitjN3RTdTNL?=
 =?utf-8?B?YjFOdTVEZkFBeEhWR0wzY2JmeEZ0QVo2NU1lVys5UlVCMTFRR1FDTjMraU42?=
 =?utf-8?B?ekVIYmhxMUtKNUgwdEVqeXM4OFl5cE9LaEV4M3pGVUJ3eTZweWNXVzRCSGNR?=
 =?utf-8?B?Y0wzSllydk56dE1QWlpRdFo0UnR2VG1hdzdROHNZcTJNT0FXZm8zSStXeUp3?=
 =?utf-8?Q?EbkwnCpu+cy/tqjOfJE0VrZbH3nlpyaw7E0Gw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YjNXV1JETTRlamYxTFd3YU91QmtUR3ZUOVJVZnBlVkw4MWgrb0RBUnBaTzNi?=
 =?utf-8?B?VkV5OThRVXlySXVORE8rR2V0ZE9mRHJtcHR3bGdpVnhyNE10YTBIRWRsYzZv?=
 =?utf-8?B?cjlCSWx6N2hUWGNRLzBXdy9RQTZjYWg1UDBiZ040bm90eENIMm1YSHU2UzVw?=
 =?utf-8?B?SmlnZkFaVWE0dmR5Mkd1c1hqbWliWUt3UW9PSlYzdnF4VUpNUms2Z3BvYUdu?=
 =?utf-8?B?cTJWaGxpck1DUGFyM1NteldMVW1WbnZ2dEVXMU9TMXRLRWxnYXowdVArWUpV?=
 =?utf-8?B?STVSTkt0aWVPSXVqNFM2N1VFMHVIZW94bGtjWmYzRk9GMjdpcVd2NjRKTmlG?=
 =?utf-8?B?cWY2NURrbFI1bW5XMVM0SzYyRWdGelU4QURvVjN4RGsvVDFMYzREN2szT2ZK?=
 =?utf-8?B?TnJmSm45ZlZpb00xS2c1bzNMaEE5Z0w5TG1ScW1KVlpnMDJsMk1LYmpFVi9Q?=
 =?utf-8?B?VHJpRWVucUJnUk9SM0Vqd25BOXY3SXo0VEsra0hDWXJqSFk3MW5JYkpQc2s5?=
 =?utf-8?B?L0ViMm9yOUpkZFFuSEI0QXJ0TmVqUnNTYUVBU2MxUFBNbm9uT2E5dVBoRUR6?=
 =?utf-8?B?RDRDUVBiNDhDMTFwQVZWQjVsL05KMTYyZER2VmcrRE0vMXdrZzVHWEZGSTQx?=
 =?utf-8?B?SDU2Smdub0Z6NFVTT1JML1FkUVJSRkpqSUtQSElxVjRJUkxwTWVRTW05VC9w?=
 =?utf-8?B?VGJCUTVmSXg4bXlhUEtpY1VjMTUwUVJNZjQ5dmh6TC9SQVh2ZitRSzEvNHJl?=
 =?utf-8?B?THVyMWg0R09abEhGcFh1OUQyTkluOWNKRmZJMC9iTVVNSnRXcE56ZElBQWh1?=
 =?utf-8?B?L1pOREhhbVQycElIY1E4VHRjNWF1ZFZ5b29mWm9oQ3dwdGEzQnpwdzRZOGlJ?=
 =?utf-8?B?YmtuNlQ0bm9SbkE2UVdtWktIRzdwNzJQb1p1WW9CT2kza29uNW9BSXBxdmR4?=
 =?utf-8?B?ZU9nZkJ1RXoxWEJRcXVTRWZPdk9ST1lqRU8yM3d1QTFxd21DS2FrdHNWOGVI?=
 =?utf-8?B?VEVLYzA3TThJR1RhMWk2K3MvdlZyOUs5c0ZpTmFUR1FpODAzMGt2RmthTDhn?=
 =?utf-8?B?V0dldit2WGZ4TmwrWDlaZXd4dkVLWitZTTk4S0l1bmdjMTV1bWYzRlNHV3Rm?=
 =?utf-8?B?akt2OUE3bjgxUTJkQ2M2MzBlVUlYODFtUHRTeW9xN0lodTJmZmVybDhPeUlT?=
 =?utf-8?B?c2V1RWxDd2dIZGtaU2ZCSGdJbmFCMk0wSW9pV25FZTBhdkQzMjZQV242THZq?=
 =?utf-8?B?bFdyenJsS3BoQncvUnQ3dkpaWkJpY2pJaDhKUkJHN2dNSXJEMm5WVnM0bXFJ?=
 =?utf-8?B?SzFpODcxdmNySHIvTXd5VG90MzdiekV6VitGeGMxVzVocmxLeW5kNFE0Umwr?=
 =?utf-8?B?N3ZVNEhMQ252ck13UkMwc0h1UWRFYjBiVVlkSXFkTHlyQ01ZSHRtY2huK2F0?=
 =?utf-8?B?aFBLdW9kUkRrNEJzd2duMlVndXEzcmVucS9DamJ3R2t0ZDY4WFBDK21MSUlM?=
 =?utf-8?B?VDBYdVBINjBPa2ZSaUFUdXQ3Y0hCS2VyS1Vnd3JGaDdSN2Z5TkhVSnpDNUdv?=
 =?utf-8?B?b2N3QjJoeVZOSVlPUjRJRy85U3lLNkMydDlwZW9aMTk4MHV1NDQzY0g5QmRv?=
 =?utf-8?B?ZGkzdDlsYTM1MTc2QVEzcWpGMVZvNytGRXY1ZWthdmZ2Skx2ZmN3bVJPaUU2?=
 =?utf-8?B?V0g1V3dFRU9LaWhYb1VQbUtqZCtWa0hWQjNLbHhvSWp3N29ZOHZndUpHdEZ5?=
 =?utf-8?B?dFV5MTNnajMybzZRME5iemF5VENPVUN4RUdSNE9LUEl0V2kranY4eXpQSzgz?=
 =?utf-8?B?UGRrK3hMcG1sTDNyNlJjbGp2MUcrNFhrWndFS3ZFejB3ZEdueDJNYzVWSmdQ?=
 =?utf-8?B?WE1teC80TGV2Vndwd3k2aGtYTEJ6elFCQlZtZERGMmJ6RVEyL2NKMEJKUHdu?=
 =?utf-8?B?RFhsWEIrclRmVGFjaTNWQkZMR3l5UmJxMFhhMkJrNG1tNTh5bExERGw2REpB?=
 =?utf-8?B?eE41SUxyeUtRSjFjQmhaRWVmTFF3Q3pjNjB4TW5rRmp5d1MwQnFMMTd3VzRF?=
 =?utf-8?B?YVRQcGpXRmpCMzQ1YW5uQ3E0VnZXbzR6N2lSRC82Q1pBTHNzeGNNdFNoSHRI?=
 =?utf-8?B?cjM3UlkwNXM5YkNWVTRzRWJwVjZTdXNtdW1JeWI3RUp0ZHN4NkhZTGNDb3Q0?=
 =?utf-8?Q?R2HYMRi8PLX7dFQkTXOBGQZ0sToIBouvRXgKANilXfGY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97919B606F774F44BB2D8946F537BACC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SLCuodC7d2z9kCgzulVZtP2s+6zBgML1VXXYxWm2fON+Lq+ZlejldJWPzGjUdEBNJJQyoetkKn8oaKa5cV5MEaeU9SyulOPASAwKYKY9RG8nDTDl5K9YuRUCrCy5eRb2Jxs8DEn33QM7IaI2Bx7Tu7ybX9xeFcCV3u/yJYI8NwFpNBlQCeZXoqQHSRJPnddyI0wpkD/qXT2nktjiWGEK88T8U2otQNjsBZVOY7VxSGTCOkkfPDDsGq4yfxjXvvccPMSiWZBEy5VP/9nuyM/Eymm0qdivRqBkSSmxRjnjZki7uqREqS68l49eWw6kht/vw6xbX5onQuxpNTKkMLtl/wZIXHv9XhlGYIYURQtkUaArM09q6ZSenwq+VcN0eotpAQnsjmF2VwHU6dux5yGkwdqaAp6Hpf3mPNxe4/unGjKq1XMABslDn4obvDNqCqwBdvB1FPtjsgExjIc6xTSCVO6GH7dkiAxcozDQub04lIvBdlqwYPGpUz1jGPX3F3PKBtgHvQg3oF9Z9QDB7Y523Bqr/f6Ci5/ALw5/77t3LLfWqoHwj+DymTYDCBcptviObLJWc/TQwDxfmdNV8ofwgkE+Br90HoEWilguGJGI7XE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c18dee68-59d3-4fc9-f7c2-08dcef8aad68
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 15:36:47.3348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AWeRpWwwNvhuAgK7LWHFEi/nT+NeV3gPgWFU/1/Np/3ROac+i6uZXjW66new3imLB7TB21UCGJEaGHpXX6WhhWKAYt/3Rl8Sp/84l+mPbtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8024
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_10,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410180099
X-Proofpoint-GUID: 7mYO5E5sEGhKXEFQM3Zg0AYS3nbKCS3T
X-Proofpoint-ORIG-GUID: 7mYO5E5sEGhKXEFQM3Zg0AYS3nbKCS3T

DQoNCj4gT24gT2N0IDE4LCAyMDI0LCBhdCAzOjA04oCvQU0sIFNpbW9uIEhvcm1hbiA8aG9ybXNA
a2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIE9jdCAxNywgMjAyNCBhdCAxMToxNDoz
NkFNIC0wNzAwLCBBbmphbGkgS3Vsa2Fybmkgd3JvdGU6DQo+PiBUZXN0IHRvIGNoZWNrIGlmIHNl
dHRpbmcgUFJPQ19DTl9NQ0FTVF9OT1RJRlkgaW4gcHJvYyBjb25uZWN0b3IgQVBJLCBhbGxvd3MN
Cj4+IGEgdGhyZWFkJ3Mgbm9uLXplcm8gZXhpdCBzdGF0dXMgdG8gYmUgcmV0dXJuZWQgdG8gcHJv
Y19maWx0ZXIuDQo+PiANCj4+IFRoZSB0aHJlYWRzLmMgcHJvZ3JhbSBjcmVhdGVzIDIgY2hpbGQg
dGhyZWFkcy4gMXN0IHRocmVhZCBoYW5kbGVzIHNpZ25hbA0KPj4gU0lHU0VHViwgYW5kIDJuZCB0
aHJlYWQgbmVlZHMgdG8gaW5kaWNhdGUgc29tZSBlcnJvciBjb25kaXRpb24gKHZhbHVlIDEpDQo+
PiB0byB0aGUga2VybmVsLCBpbnN0ZWFkIG9mIHVzaW5nIHB0aHJlYWRfZXhpdCgpIHdpdGggMS4N
Cj4+IA0KPj4gSW4gYm90aCBjYXNlcywgY2hpbGQgc2VuZHMgbm90aWZ5X25ldGxpbmtfdGhyZWFk
X2V4aXQoZXhpdF9jb2RlKSB0byBrZXJuZWwsDQo+PiB0byBsZXQga2VybmVsIGtub3cgaXQgaGFz
IGV4aXRlZCBhYm5vcm1hbGx5IHdpdGggZXhpdF9jb2RlLg0KPj4gDQo+PiBDb21waWxlOg0KPj4g
ICAgbWFrZSB0aHJlYWQNCj4+ICAgIG1ha2UgcHJvY19maWx0ZXINCj4+IFJ1bjoNCj4+ICAgIC4v
dGhyZWFkcw0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBBbmphbGkgS3Vsa2FybmkgPGFuamFsaS5r
Lmt1bGthcm5pQG9yYWNsZS5jb20+DQo+PiAtLS0NCj4+IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2Nvbm5lY3Rvci9NYWtlZmlsZSAgICB8ICAyMyArLQ0KPj4gLi4uL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2Nvbm5lY3Rvci9wcm9jX2ZpbHRlci5jIHwgIDM0ICsrLQ0KPj4gdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvY29ubmVjdG9yL3RocmVhZC5jICAgIHwgMjMyICsrKysrKysrKysrKysrKysrKw0KPj4g
Li4uL3NlbGZ0ZXN0cy9jb25uZWN0b3IvdGhyZWFkX2ZpbHRlci5jICAgICAgIHwgIDk2ICsrKysr
KysrDQo+PiA0IGZpbGVzIGNoYW5nZWQsIDM3OCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygt
KQ0KPj4gY3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nvbm5lY3Rv
ci90aHJlYWQuYw0KPj4gY3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2Nvbm5lY3Rvci90aHJlYWRfZmlsdGVyLmMNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2Nvbm5lY3Rvci9NYWtlZmlsZSBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2Nvbm5lY3Rvci9NYWtlZmlsZQ0KPj4gaW5kZXggOTIxODhiOWJhYzVjLi5iZjMzNTgyNmJj
M2IgMTAwNjQ0DQo+PiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9jb25uZWN0b3IvTWFr
ZWZpbGUNCj4+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nvbm5lY3Rvci9NYWtlZmls
ZQ0KPj4gQEAgLTEsNSArMSwyNiBAQA0KPj4gIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BM
LTIuMA0KPj4gLUNGTEFHUyArPSAtV2FsbCAkKEtIRFJfSU5DTFVERVMpDQo+PiArS0VSTkVMPSIu
Li8uLi8uLi8uLiINCj4+ICsNCj4+ICtDRkxBR1MgKz0gLVdhbGwgJChLSERSX0lOQ0xVREVTKSAt
SSAkKEtFUk5FTCkvaW5jbHVkZS91YXBpIC1JICQoS0VSTkVMKS9pbmNsdWRlDQo+PiArDQo+PiAr
cHJvY19maWx0ZXI6IHByb2NfZmlsdGVyLm8NCj4+ICsgY2MgcHJvY19maWx0ZXIubyAtbyBwcm9j
X2ZpbHRlcg0KPj4gKw0KPj4gK3Byb2NfZmlsdGVyLm86IHByb2NfZmlsdGVyLmMNCj4+ICsgY2Mg
LWMgcHJvY19maWx0ZXIuYyAtbyBwcm9jX2ZpbHRlci5vICQoQ0ZMQUdTKQ0KPj4gKw0KPj4gK3Ro
cmVhZDogdGhyZWFkLm8gdGhyZWFkX2ZpbHRlci5vDQo+PiArIGNjIHRocmVhZC5vIHRocmVhZF9m
aWx0ZXIubyAtbyB0aHJlYWQNCj4+ICsNCj4+ICt0aHJlYWQubzogdGhyZWFkLmMgJChERVBTKQ0K
Pj4gKyBjYyAtYyB0aHJlYWQuYyAtbyB0aHJlYWQubyAkKENGTEFHUykNCj4+ICsNCj4+ICt0aHJl
YWRfZmlsdGVyLm86IHRocmVhZF9maWx0ZXIuYw0KPj4gKyBjYyAtYyB0aHJlYWRfZmlsdGVyLmMg
LW8gdGhyZWFkX2ZpbHRlci5vICQoQ0ZMQUdTKQ0KPj4gKw0KPj4gK2RlZmluZSBFWFRSQV9DTEVB
Tg0KPj4gKyBybSAqLm8gdGhyZWFkDQo+PiArZW5kZWYNCj4+IA0KPj4gVEVTVF9HRU5fUFJPR1Mg
PSBwcm9jX2ZpbHRlcg0KPj4gDQo+IA0KPiBJIGFtIGEgbGl0dGxlIGNvbmZ1c2VkIGJ5IHRoaXMs
IGFzIGl0IHNlZW1zIHRvIHJlc3VsdCBpbiB1c2VyLXNwYWNlDQo+IGNvZGUgdXNpbmcga2VybmVs
IGhlYWRlcnMuIElzIHRoYXQgZXhwZWN0ZWQ/DQoNCklmIEkgZG8gbm90IGRvIHRoaXMsIHRoZW4g
aXTigJlzIG5vdCBwb3NzaWJsZSB0byBydW4gdGhlIHNlbGZ0ZXN0cyBvbiBhDQpzeXN0ZW0gd2hp
Y2ggZG9lcyBub3QgaGF2ZSB0aGUgYnVpbHQgaW1hZ2UgaW5zdGFsbGVkLiBUaGlzIGFsbG93cyBt
ZSB0bw0KdG8gdGVzdCB0aGUgc2VsZnRlc3QgY29kZSBpbiB0aGUgYnVpbGQgdHJlZSB3aXRob3V0
IGhhdmluZyB0byBpbnN0YWxsIHRoZSBidWlsZA0Ka2VybmVsIG9uIHRoZSBzeXN0ZW0sIGFzIGl0
IHVzZXMgdGhlIGhlYWRlciBmaWxlcyBpbiB0aGUgYnVpbGQgaXRzZWxmIGluc3RlYWQNCm9mIHRo
ZSBvbmVzIGluc3RhbGxlZCBvbiB0aGUgc3lzdGVtLg0KSSBjYW4gcmVtb3ZlIGl0IGlmIHJlcXVp
cmVkLg0KDQpBbmphbGkNCg0KPiANCj4gJCBtYWtlIC1DIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2Nvbm5lY3Rvcg0KPiAuLi4NCj4gY2MgLWMgcHJvY19maWx0ZXIuYyAtbyBwcm9jX2ZpbHRlci5v
IC1XYWxsIC1pc3lzdGVtIC9ob21lL2hvcm1zL3Byb2plY3RzL2xpbnV4L2xpbnV4L3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzLy4uLy4uLy4uL3Vzci9pbmNsdWRlIC1JICIuLi8uLi8uLi8uLiIvaW5j
bHVkZS91YXBpIC1JICIuLi8uLi8uLi8uLiIvaW5jbHVkZSAtRF9HTlVfU09VUkNFPQ0KPiBJbiBm
aWxlIGluY2x1ZGVkIGZyb20gLi4vLi4vLi4vLi4vaW5jbHVkZS91YXBpL2xpbnV4L25ldGxpbmsu
aDo3LA0KPiAgICAgICAgICAgICAgICAgZnJvbSBwcm9jX2ZpbHRlci5jOjExOg0KPiAuLi8uLi8u
Li8uLi9pbmNsdWRlL3VhcGkvbGludXgvdHlwZXMuaDoxMDoyOiB3YXJuaW5nOiAjd2FybmluZyAi
QXR0ZW1wdCB0byB1c2Uga2VybmVsIGhlYWRlcnMgZnJvbSB1c2VyIHNwYWNlLCBzZWUgaHR0cHM6
Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8va2VybmVsbmV3Ymllcy5vcmcvS2VybmVsSGVh
ZGVyc19fOyEhQUNXVjVOOU0yUlY5OWhRIVAzTGRIOXg3Vm1SdTlzYWxMR2llVUhlMjdZU3lpWVh5
VW9VZEhWOU5hcmY4VUFkbVhMVlB5SEZpNDF6SlZLRkFLVmdvOWVNZXZva0ZkUkx3VEg4cCQgIiBb
LVdjcHBdDQo+ICAgMTAgfCAjd2FybmluZyAiQXR0ZW1wdCB0byB1c2Uga2VybmVsIGhlYWRlcnMg
ZnJvbSB1c2VyIHNwYWNlLCBzZWUgaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8v
a2VybmVsbmV3Ymllcy5vcmcvS2VybmVsSGVhZGVyc19fOyEhQUNXVjVOOU0yUlY5OWhRIVAzTGRI
OXg3Vm1SdTlzYWxMR2llVUhlMjdZU3lpWVh5VW9VZEhWOU5hcmY4VUFkbVhMVlB5SEZpNDF6SlZL
RkFLVmdvOWVNZXZva0ZkUkx3VEg4cCQgIg0KPiAgICAgIHwgIF5+fn5+fn4NCj4gLi4uDQo+IA0K
Pj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nvbm5lY3Rvci90aHJlYWQu
YyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nvbm5lY3Rvci90aHJlYWQuYw0KPiANCj4gLi4u
DQo+IA0KPj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBpbml0X3RocmVhZHMocHRocmVhZF9hdHRyX3Qg
KmF0dHIpDQo+IA0KPiBQbGVhc2UgZG9uJ3QgdXNlIGlubGluZSBpbiAuYyBmaWxlcyB1bmxlc3Mg
dGhlcmUgaXMgYSBkZW1vbnN0cmFibGUsDQo+IHVzdWFsbHkgcGVyZm9ybWFuY2UsIHJlYXNvbiB0
byBkbyBzby4NCj4gDQo+IExpa2V3aXNlIHR3aWNlIG1vcmUgaW4gdGhpcyBwYXRjaCBhbmQgb25j
ZSBpbiBwYXRjaCAxLzMuDQo+IA0KPj4gK3sNCj4+ICsgaW50IHJldDsNCj4+ICsNCj4+ICsgcmV0
ID0gcHRocmVhZF9hdHRyX2luaXQoYXR0cik7DQo+PiArIGlmIChyZXQgIT0gMCkgew0KPj4gKyBw
ZXJyb3IoInB0aHJlYWRfYXR0cl9pbml0IGZhaWxlZCIpOw0KPj4gKyBleGl0KHJldCk7DQo+PiAr
IH0NCj4+ICsNCj4+ICsgcmV0ID0gcHRocmVhZF9hdHRyX3NldGRldGFjaHN0YXRlKGF0dHIsIFBU
SFJFQURfQ1JFQVRFX0RFVEFDSEVEKTsNCj4+ICsgaWYgKHJldCAhPSAwKSB7DQo+PiArIHBlcnJv
cigicHRocmVhZF9hdHRyX3NldGRldGFjaHN0YXRlIGZhaWxlZCIpOw0KPj4gKyBleGl0KHJldCk7
DQo+PiArIH0NCj4+ICt9DQo+IA0KPiAuLi4NCg0KDQo=

