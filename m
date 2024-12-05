Return-Path: <linux-kselftest+bounces-22847-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC679E4B8B
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 01:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B6416A80A
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 00:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239713AC2B;
	Thu,  5 Dec 2024 00:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TXPKGx8F";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D4DrhS/u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70A479D2;
	Thu,  5 Dec 2024 00:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733360325; cv=fail; b=l4vul+u2e4oIWdH5/FlxpeuL2PTFxcsRqlNwQ3e6BtymOtu5CAQeef3za7P2aMizz4r5nRxaFJRQBlt/JdHPbJIEOXkiHT04gRsL4TQkOfXKnTjcSVcz24KuChRSKyP3dxmcn/+DiuXtaVVuzTFIHQLdy3texCvAMh4uj3g0lkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733360325; c=relaxed/simple;
	bh=lPDlK+Hpl0CICEis0OqhLh3ytE64sZeGDRz6Cu6dQQg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TgnJMKATdfVjqifBUyQEwk9k2UUfxY8J9fm6bzkmWCFR13ezTW5tIPVTAzWHEmC4HP+RcAwAvKLNSg5mL8uCGkbwNg0xBSyD9OTK5EQ05xwnPPQNrcHQ9b8KIA5cNZF36hhRv7J6hMCs9lOgtflbkIKbYuIYN6sMind8FoxxDoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TXPKGx8F; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D4DrhS/u; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4ItwmU031074;
	Thu, 5 Dec 2024 00:57:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=lPDlK+Hpl0CICEis0OqhLh3ytE64sZeGDRz6Cu6dQQg=; b=
	TXPKGx8FkrKOhukjoPwV9yw0lmHJjEKe1NWDRWyQ912Mcs0T+03j3HNSKsFH4e3+
	i04y41yONOpHU8Fi6GBn+2aP3YdwUzIcLPLmO+4Wy/oPzg3v07H9ybYjkC5DNxo3
	Ndr2fm0jp/o6KC/M6lQflJtygT0Ozwc6oM+Pv+R2GKmT90Nej5O2zlZzm9cmrnR+
	nA21FQ0SUQ8drv1G+y1Eu4hmGBQ1ztnU+p36/9giSOaZK3x7BrvmfcZ69B77OoFA
	0JYplTr1Enb+XrriZRidoV3KjwocXIFDoKhbI7ar5KQoih/QY9RU/mmyY5TNRGrJ
	ZolBgUvGY8ZYRxhdQ+fIGg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437tas9q9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Dec 2024 00:57:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B50FtuW020400;
	Thu, 5 Dec 2024 00:57:37 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 437s5a7tcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Dec 2024 00:57:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=feyc1ReTlYGhrRk1NEQYJ+ifx2lr73VG4UthRVcrw5pLOQIgLHELGQtEcNmT/Vh37RE1Q29Q3hXUjImrSj6cfw0w20+liWf59CFj2RzLQJqqn4eOkLXqxhGRZI9c+v4jyXkQi45gU0mS0XDAbqj/z9LzJM4Ck/+/2d+og/kqctaRXxDR+kLbtnrYeqdITXgE14+KNcPZ5Vw+vAOL+PU6+R9+4shkZa2fkUiEPnvaOvrEDgBJXGzZKPQv2cdilAALV35Qi+QA8eymdLQSuyhGZNyxTLPp3fqpehH67iL3ZdOhDXMPiUIGeqXbJXTlUTsrdc4hqVm12b8cJexbM3XitA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPDlK+Hpl0CICEis0OqhLh3ytE64sZeGDRz6Cu6dQQg=;
 b=cX6mryiC+TS2MdLLFl5pUIz7ee7OWFUkgUUrpabbug1nEXWxRuF7DgArzyTtEcJqyKTmt2O7wo/nDjf93Kozw/krgoyQtiuAf3wcIyBIyqsDkG9wAbVpa+4LEf8m9c4y2cIoInBKSoWmmnNL/2t85ehAuAtryMRnocx08dvEyDIkXL9ZlRjA22eNNInvjUfBWreamY0xCGR6z+yVMj79BQNH2ki7dlCi39/Wko6/9RPdcvpHyxLbZeF7MM9E7yMPJCd6kD8wh7D40/yAau0vuOlHtNzbS9ChWAKm1+KVS8CMTce9mWiFv6/9t3MQSjnioRt4Dhk/rZz1+i8oQksWWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPDlK+Hpl0CICEis0OqhLh3ytE64sZeGDRz6Cu6dQQg=;
 b=D4DrhS/uher7Tt2nXc/JGsJyW4jQwfPvW1Gi/uOLppPZsEGY3fkUO8y5It6aw+qpmbl5XQc5P+cem+tI8Hmo3wBYmnCtRFL9mLZDJgTQXSGFuYuq4CHofLtQntARW1rSsZHaZ6N4xOQ45cGkxUZ7E3H6/hx8ZHerE8xlbCLOUxs=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by IA1PR10MB6687.namprd10.prod.outlook.com (2603:10b6:208:419::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Thu, 5 Dec
 2024 00:57:33 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%7]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 00:57:32 +0000
From: Eric Snowberg <eric.snowberg@oracle.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
CC: Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin
	<dmitry.kasatkin@gmail.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "petr.pavlu@suse.com"
	<petr.pavlu@suse.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "da.gomez@samsung.com" <da.gomez@samsung.com>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com"
	<serge@hallyn.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        "wufan@linux.microsoft.com"
	<wufan@linux.microsoft.com>,
        "pbrobinson@gmail.com" <pbrobinson@gmail.com>,
        "zbyszek@in.waw.pl" <zbyszek@in.waw.pl>, "hch@lst.de" <hch@lst.de>,
        "mjg59@srcf.ucam.org" <mjg59@srcf.ucam.org>,
        "pmatilai@redhat.com"
	<pmatilai@redhat.com>,
        "jannh@google.com" <jannh@google.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "jikos@kernel.org"
	<jikos@kernel.org>,
        "mkoutny@suse.com" <mkoutny@suse.com>,
        "ppavlu@suse.com"
	<ppavlu@suse.com>,
        "petr.vorel@gmail.com" <petr.vorel@gmail.com>,
        "mzerqung@0pointer.de" <mzerqung@0pointer.de>,
        "kgold@linux.ibm.com"
	<kgold@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v6 00/15] integrity: Introduce the Integrity Digest Cache
Thread-Topic: [PATCH v6 00/15] integrity: Introduce the Integrity Digest Cache
Thread-Index: AQHbOnDjfg4en7nkgkyalKK8KF8lk7LIuzaAgACvegCAC539gIAA9ZKAgADuJoA=
Date: Thu, 5 Dec 2024 00:57:32 +0000
Message-ID: <B0DC94E7-78A3-4797-B864-31DE0A2C903C@oracle.com>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
 <C4BE31F8-1FA3-4AD1-A712-ED2AA7E61E96@oracle.com>
 <17ef4f662e594c8431a00fe423507af4f6a82286.camel@huaweicloud.com>
 <B135AC90-7CE5-4E51-90B1-9D82031668A8@oracle.com>
 <00f3eb72042aedaa4644ff0932d06d4e8d215f6b.camel@huaweicloud.com>
In-Reply-To: <00f3eb72042aedaa4644ff0932d06d4e8d215f6b.camel@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR10MB7730:EE_|IA1PR10MB6687:EE_
x-ms-office365-filtering-correlation-id: 4b8ee951-2380-4885-f26d-08dd14c7ccc3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZlRJQ1p0bGVVVURwdUt1bCtVMlN0b29mcWJVSm5EMTYwektnT05JS0ZrWFU5?=
 =?utf-8?B?U3pCRG4vVzBCbEtxd2FUTExsaTYzbkF6SFFHRmJHRGxDZjg4dXg5bkN5bGtv?=
 =?utf-8?B?TkdhMTl4Z2F2WEtwSE9GRWNEWEVYRWcvSGI1UGhkSkIxVEh3Vm9LRWxlbWNC?=
 =?utf-8?B?b1FkWE5MT1doNHFXei9Ic1dVaWRZTVpyUDRhRU9TeW16RXNmUW5EdENmVDli?=
 =?utf-8?B?N0lQUjQ1aG5FTGRxQ3pHZGg5TUZIcFNpUzk1QnRwZTRZWnMzb0RlSVVsUUFV?=
 =?utf-8?B?MXRCVzhNSlppYmRGUklGQU4wWWNaa2N0RE1MeFM4S3JLN3laU3J0c3NPWG9V?=
 =?utf-8?B?YmdtNUxMa0puRk5LbGdkRE5FTjFQSlcyL0RrZldXZGJNcm8yRlhSYWREOGpH?=
 =?utf-8?B?cHh2NmNBRVFpTVFLU2xkaTQwSGRzRlYrREwxQ0ZPOWo0aEhPSDFkVTJlRTVo?=
 =?utf-8?B?eGovT1N6YS8zTVhwWWJ4SzRPVXYyQndldFFpeWZxZHhrOGEzTkU2THNLVmN2?=
 =?utf-8?B?QnI3bTQ2V2ozQnRmRnZwSEZPdUhucnBhYVlxMDZGaHpRTDlXaDNxamxHQnVj?=
 =?utf-8?B?ZXRDNlY0blg0amk0UXJ5VG5Md0U4SUxBcUFLQ2l0SzNGOW1zOUFaMTBCOHll?=
 =?utf-8?B?Z0I1Yi9iTDdDUjU5Z1lqTjJ1Tzd3YU00MGdiQ1dnUnVrdlZVR2xCMGY3VUFX?=
 =?utf-8?B?Mnozak1KL0NZenFyVkVkTnZld2NaY1lScU11aHhQNy9XbmJTYjhWZGVZdUtX?=
 =?utf-8?B?M1ZxL3F0RVJYSFpOTkRjaThIb2FOTkFJODZYWnFFZXcvc1g3Y2ZTaUlvdEJL?=
 =?utf-8?B?VmF1VFJPT3hEVEViSFpNWm5PL3hpNTdSSDZpRFJVeGZiWm9uU3lmUlBXUWRt?=
 =?utf-8?B?eDhYK3oyS3U1cWNNQlBrRkJHRGZ1NE1YUTNjWnlTbjdNaGIzQkVnZXhrc2J4?=
 =?utf-8?B?UHBjd0JYOHg2Q2dDWUlibVpBa3dFYkFsN0ZNS25KWE5VKzdWckhTRUFLZDRE?=
 =?utf-8?B?bHBxQXE3OFRrd3M1TkdmUmwraWhuWDFkVzVUSUh0bmlGN1NzR2RGWlg3QnpZ?=
 =?utf-8?B?QzI4aVdnMytiWTVDNmxOK2dTeWNpOW94MkNTUDl0cDlMTmlWMVByQnlyemU5?=
 =?utf-8?B?bU8wRUpPbVdaTDE1a2RjV0YxWWlTck9DdzRUSWYyOUg2cGJQQjR5b2J6SDBH?=
 =?utf-8?B?SitKMG9kanBUYnM4d1JHbmtxWmM0dHNhNlZuUjMycFpRbzJIcVBvdjJqdXI4?=
 =?utf-8?B?S3hYMU1mNG9HckJKYUFFWFFKdjdIcmhOTTROZy9HWDl4L2Erd0RCVlhGRmFF?=
 =?utf-8?B?VUJLVGN5ZUowRmwrdHFqQU1hVGUrL3l3V3grT1czMU51eDRZZkUxSGNsZCtk?=
 =?utf-8?B?S1Zlbk1IaklLNFJDYVJ2NjgrYXIrV08rSDJUMitURzlET01HbHc2K0NHbG9z?=
 =?utf-8?B?T0k3R0dId0MwWnZxdUtFVnltWXhSTk9YUWM0aTJmN3dNVXZYRW00ZU8zeTM3?=
 =?utf-8?B?Z1ROUTlxZXdOS2Q4dnlBMWxrdTdQSjlTNGRjM2loNGpORXU2ZGFJbU44aHdm?=
 =?utf-8?B?bzU2a3RQZ3h6SFFoRGtFbjhaNFZxL0V1SmluaHZmY2hYa05yME1pbCtqVzNQ?=
 =?utf-8?B?NzhHU3NLVlBMUmNpY3A4VFRsejdDaDY5NjJDSXF2NmtUSWZFUlNmamVTcmcx?=
 =?utf-8?B?eld6UVNmVG0yTkhxejRIMGVBN052T2lmTmhleXZUWUVEbm12a3RqTlNVdUVY?=
 =?utf-8?B?ai9EQ2d1UEpzREU1a2E3bGxhenVWMUprdnJIdE94UGEzQXRlZ2x6a21xcEdi?=
 =?utf-8?B?OTU5ZGpjbkhhUWJkWVNrUnFDWGFNSUxUVWg4VGtFSy9GWmJWaEtkdWdyU3cr?=
 =?utf-8?B?R04yanU3cll6V0Vud295SGhLRnZBRnlnUVk4Uk80eHpsRVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QkptazUweVNMRlBWaitTYVpWOUhWL2p0aFg4Uit4bGpVa3ZVZVBqZnVLamtR?=
 =?utf-8?B?UTFNOE1PZEJKdUo5VG1GZlk5T3VHTGl1WUkrclhuWm41ZXhZQkV3WnVGL05T?=
 =?utf-8?B?dW9EcDZ2aldYL25QTUVvNElWOVcycVp0UHkyaGFMaDRFVE9NK3dBQVVuY1Yx?=
 =?utf-8?B?clp2NnQ4cC9CVjJKUkY4QzJJMFFocWkzSVZQcmowK1UwMEdFaUR3Rjg2SGJa?=
 =?utf-8?B?MjFKdTg4TTQ4RkFJUTJQQTFHVXhiVE0rU20vVHBvcVNXQ0NKakFjeDN4UUFZ?=
 =?utf-8?B?Z2ZuK3RXd1VySGJvQ3kxay8yV3lWWXkwTmR5ZjlQcXc4L3p4R2lxSXc5aG83?=
 =?utf-8?B?SCtaMTFZV0VWWmFGZWE5bDdJQmFVV2VmTysrcmNyL1c0MDN5L0JxenBkQmU1?=
 =?utf-8?B?V0VLSWJJaWhkN2tTL3h5cUU2Z0pFbE5yUXE0a2xPRVA1aitHMVd1SThsWkhH?=
 =?utf-8?B?SU9rNTI0KzhsZGlVeWFVczNJZTRTOXp3NnMwM3NkTUJJa29hR1EzNFJWaHM5?=
 =?utf-8?B?TzVKMGlqN0dQeTRxcytJeW9tUzk4TnJRbG8zSldYWUdaM0lzb2JYSkQ5VjYz?=
 =?utf-8?B?Zy9DWUdWalF4V2ppWnhWcm0rekhsRkVvNUo2R1R1bVQ2YStVR1JFUkUyOTlv?=
 =?utf-8?B?YncvTDNwUzlIZkhXbzNBcis4WjA2eFlmb1hvOWE0WXFQY2xMeVJuem9uSXMz?=
 =?utf-8?B?M3hLcXhibHRxM0NvUXlPNzlEcXBKWWw1R1lSV295VzI2RTJPK3M0aUdGekRr?=
 =?utf-8?B?czdiV1NFNWdpNlluSHRWZ2o2ckIzYzVIaHVocVR1MjBTMmJXczhYZXRKRG93?=
 =?utf-8?B?amhFazFCcXd2bHdtYjkyN1E3V0RvZ0JVRElFaEVpT1BaQzZicVhReU5hT0pF?=
 =?utf-8?B?WENZTTIzVzFqeGRNWmxsdjlHQ0FONEVIMlpud0pCSitxaWE3aFpPZWtJRkxp?=
 =?utf-8?B?QWtRUlphTzlqSzJrMVUwc2ZyaW9QYVFWTDBUV1A5S3B4alJvQThZUklieGhm?=
 =?utf-8?B?ckhhTVJGellkaEdPclVMZ3VwTGo4VHhFY2NXd1pvWU45Z0VXR1pGZkEvNFQ4?=
 =?utf-8?B?bmpqYkFsa3loTm1IMmljWCt2MWR4eXhCS0xzYm5QTXQ2TTFjeHlYR1pUbTJy?=
 =?utf-8?B?RlJUdzFIMWR3cy9hTm51aWorblRhMmRXcFBVZnJkeUVJYS9raDRURGNYeTZ4?=
 =?utf-8?B?eW1hV0NKZUxhODcvemtnRUs5UzZzYVN0SmphSzU2SSt4SEY2RHJqVjlrTlA0?=
 =?utf-8?B?Rk02MVNZRThWTklDeCtRLzZIQXlkc0ZpekJ5UC9BKzhLd2lOVmtYOHBPaEh6?=
 =?utf-8?B?bjdCKzMzRE0yQTBXc0MzM2JhenJ3UG5XUThKdG9jSURVMXNtT3R3WlhtK2la?=
 =?utf-8?B?WVhlM2hOMjlqaHcrS0RDam1SbGd1YzhQdlRsV3NKK0ZRSmtkaStLSWxNYmc5?=
 =?utf-8?B?WGozVWFIQjM2VGhMR0M2T1pOK2hVMlp3RHNDM2ZBZFpHMzR2anNuZ0g4bHdx?=
 =?utf-8?B?bjUrV2lNaS9GTC9vVWtDV0k2NXE1VlBFMnE1MUR4MGxMcUtPcUlPNi9tTUJW?=
 =?utf-8?B?SWpsaFJWL3BKRHBCMktleDQ3TEY3U21MUjlGMERIZVR5emJWMmFCWVErcHR1?=
 =?utf-8?B?QWhqYVJwbTJWSGxJTlBrOG5jNVIvVVgzQXAyT3I0R2hjWCthWFEwU3k2RUF1?=
 =?utf-8?B?WW1hY3hNN09DNzlLV2ZMcTdiSDJGaTRXclZJbWFydFMwWFI2cXREMjlKeHpL?=
 =?utf-8?B?VFFHS21uQnB6K1NNREkrQ3ovcnBwY2JNNzArMnFKTHBJZkw5bjRQUUVnaE1K?=
 =?utf-8?B?eVRaT0xFc1FMcC9LYVhkN1kvdXVxM0c0SkhnRm5qaFZ3UlNLM0xVRkVhaFM5?=
 =?utf-8?B?M0d6SUpyTXkzdEVKbHdlczd1d281aXJyYkxvT1dEUGRHSGh1ZmZwVlNmcW0w?=
 =?utf-8?B?N1VtMTlTVHlQQmhFVnBCN0FTTnZ3c2x3SGoxQW9mT0FBdlROWmN3ODNldlNk?=
 =?utf-8?B?aEp6L1B3dzhzYnU3bndaeHpnejdFcWVkNjJxZjZ1blUyWXlvc2xaditKdndF?=
 =?utf-8?B?QlFuRkxkMkIzenpsZzMzaFZZUkh1b0FDaTcyUmR6UmNRY1NseDErMngvSmpa?=
 =?utf-8?B?ZitPbmhEQURsL01Da3NqUmczQ3phWEpCbFN3OXNBOTJEZDlVa0IzOSs4eHdr?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <24EBDB8E8DE2CC4099144ABF04F5889E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zuuP0XYW04cvIoj2bfzwxylRWJZjq7V1tDNwmdHgcxIO7V6+K+8APc9Ig3TDdR81nnePPfnJBnLU8iH1roL8/8BZGLlqvLmzaWJS34RNsct4lD8sPd3/QRnVCimKx8VmdxAYAts3Xz7IJ6tmW5gzfEjEC1J/bMnAe+IUCTXlSWcrhoJ1CXOQMfG2pF/bVvvrgNkQu5/r4Q+8Iy2tRCeSHF5gYXbeObeh/XslZXaYlW1Zg4utklFekguM3eK1E5uYnp4txWSf8JNX4ahTnSP1/thygeuAszfcstr43/Uwjq2CKXcfLCjNuFxyWFEPkcNYLN3iUqoL35tU2/YMZfBNwqsVMScqymwECR/m4A2ufbmm99vw0J1PdqyBfbiY+5ZF2nwr5tkvVqLnMCxuGL4EAJvEXjWlPjjJ3f9hxwpXrgyI7pDz+E8aEKsaTGoTK9mosaAuvUsj6nnGMDxSKqPT1BCbu3tKrFQkWe/neDUPVaLPW6mbTMljcDfyW4Nz3offgKMiM6DO9P+DB7FbTIUOO69yOHnpTuCAhITmIJjMLEmKPUv50Q+ZrK+hlT/3zDp0iwqk8X0wZalu525qtD+xyT6dbVW/YbouS4ituZc2kVA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8ee951-2380-4885-f26d-08dd14c7ccc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 00:57:32.2385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sAwtQJttt1fqOgtmbF4hQhTiy6PU8Xru3P2NVl+/9LUPISgrApzgsXJgvtqHmgrgMovxBTaA0pKw/IBp/KC3vaupgrRw7S8Q0LWblUza8rY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-04_20,2024-12-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412050005
X-Proofpoint-GUID: NpOU4uaWq3gf2MTEzabyZfU-ZUyX5Ojb
X-Proofpoint-ORIG-GUID: NpOU4uaWq3gf2MTEzabyZfU-ZUyX5Ojb

DQoNCj4gT24gRGVjIDQsIDIwMjQsIGF0IDM6NDTigK9BTSwgUm9iZXJ0byBTYXNzdSA8cm9iZXJ0
by5zYXNzdUBodWF3ZWljbG91ZC5jb20+IHdyb3RlOg0KPiANCj4gT24gVHVlLCAyMDI0LTEyLTAz
IGF0IDIwOjA2ICswMDAwLCBFcmljIFNub3diZXJnIHdyb3RlOg0KPj4gDQo+Pj4gT24gTm92IDI2
LCAyMDI0LCBhdCAzOjQx4oCvQU0sIFJvYmVydG8gU2Fzc3UgPHJvYmVydG8uc2Fzc3VAaHVhd2Vp
Y2xvdWQuY29tPiB3cm90ZToNCj4+PiANCj4+PiBPbiBUdWUsIDIwMjQtMTEtMjYgYXQgMDA6MTMg
KzAwMDAsIEVyaWMgU25vd2Jlcmcgd3JvdGU6DQo+Pj4+IA0KPj4+Pj4gT24gTm92IDE5LCAyMDI0
LCBhdCAzOjQ54oCvQU0sIFJvYmVydG8gU2Fzc3UgPHJvYmVydG8uc2Fzc3VAaHVhd2VpY2xvdWQu
Y29tPiB3cm90ZToNCj4+Pj4+IA0KPj4+Pj4gRnJvbTogUm9iZXJ0byBTYXNzdSA8cm9iZXJ0by5z
YXNzdUBodWF3ZWkuY29tPg0KPj4+Pj4gDQo+Pj4+PiBUaGUgSW50ZWdyaXR5IERpZ2VzdCBDYWNo
ZSBjYW4gYWxzbyBoZWxwIElNQSBmb3IgYXBwcmFpc2FsLiBJTUEgY2FuIHNpbXBseQ0KPj4+Pj4g
bG9va3VwIHRoZSBjYWxjdWxhdGVkIGRpZ2VzdCBvZiBhbiBhY2Nlc3NlZCBmaWxlIGluIHRoZSBs
aXN0IG9mIGRpZ2VzdHMNCj4+Pj4+IGV4dHJhY3RlZCBmcm9tIHBhY2thZ2UgaGVhZGVycywgYWZ0
ZXIgdmVyaWZ5aW5nIHRoZSBoZWFkZXIgc2lnbmF0dXJlLiBJdCBpcw0KPj4+Pj4gc3VmZmljaWVu
dCB0byB2ZXJpZnkgb25seSBvbmUgc2lnbmF0dXJlIGZvciBhbGwgZmlsZXMgaW4gdGhlIHBhY2th
Z2UsIGFzDQo+Pj4+PiBvcHBvc2VkIHRvIHZlcmlmeWluZyBhIHNpZ25hdHVyZSBmb3IgZWFjaCBm
aWxlLg0KPj4+PiANCj4+Pj4gSXMgdGhlcmUgYSB3YXkgdG8gbWFpbnRhaW4gaW50ZWdyaXR5IG92
ZXIgdGltZT8gIFRvZGF5IGlmIGEgQ1ZFIGlzIGRpc2NvdmVyZWQgDQo+Pj4+IGluIGEgc2lnbmVk
IHByb2dyYW0sIHRoZSBwcm9ncmFtIGhhc2ggY2FuIGJlIGFkZGVkIHRvIHRoZSBibGFja2xpc3Qg
a2V5cmluZy4gDQo+Pj4+IExhdGVyIGlmIElNQSBhcHByYWlzYWwgaXMgdXNlZCwgdGhlIHNpZ25h
dHVyZSB2YWxpZGF0aW9uIHdpbGwgZmFpbCBqdXN0IGZvciB0aGF0IA0KPj4+PiBwcm9ncmFtLiAg
V2l0aCB0aGUgSW50ZWdyaXR5IERpZ2VzdCBDYWNoZSwgaXMgdGhlcmUgYSB3YXkgdG8gZG8gdGhp
cz8gIA0KPj4+IA0KPj4+IEFzIGZhciBhcyBJIGNhbiBzZWUsIHRoZSBpbWFfY2hlY2tfYmxhY2ts
aXN0KCkgY2FsbCBpcyBiZWZvcmUNCj4+PiBpbWFfYXBwcmFpc2VfbWVhc3VyZW1lbnQoKS4gSWYg
aXQgZmFpbHMsIGFwcHJhaXNhbCB3aXRoIHRoZSBJbnRlZ3JpdHkNCj4+PiBEaWdlc3QgQ2FjaGUg
d2lsbCBub3QgYmUgZG9uZS4NCj4+IA0KPj4gDQo+PiBJdCBpcyBnb29kIHRoZSBwcm9ncmFtIGhh
c2ggd291bGQgYmUgY2hlY2tlZCBiZWZvcmVoYW5kIGFuZCBmYWlsIGlmIGl0IGlzIA0KPj4gY29u
dGFpbmVkIG9uIHRoZSBsaXN0LiANCj4+IA0KPj4gVGhlIC5pbWEga2V5cmluZyBtYXkgY29udGFp
biBtYW55IGtleXMuICBJZiBvbmUgb2YgdGhlIGtleXMgd2FzIGxhdGVyIA0KPj4gcmV2b2tlZCBh
bmQgYWRkZWQgdG8gdGhlIC5ibGFja2xpc3QsIHdvdWxkbid0IHRoaXMgYmUgbWlzc2VkPyAgSXQg
d291bGQgDQo+PiBiZSBjYXVnaHQgZHVyaW5nIHNpZ25hdHVyZSB2YWxpZGF0aW9uIHdoZW4gdGhl
IGZpbGUgaXMgbGF0ZXIgYXBwcmFpc2VkLCBidXQgDQo+PiBub3cgdGhpcyBzdGVwIGlzbid0IHRh
a2luZyBwbGFjZS4gIENvcnJlY3Q/DQo+IA0KPiBGb3IgZmlsZXMgaW5jbHVkZWQgaW4gdGhlIGRp
Z2VzdCBsaXN0cywgeWVzLCB0aGVyZSB3b24ndCBiZSBkZXRlY3Rpb24NCj4gb2YgbGF0ZXIgcmV2
b2NhdGlvbiBvZiBhIGtleS4gSG93ZXZlciwgaXQgd2lsbCBzdGlsbCB3b3JrIGF0IHBhY2thZ2UN
Cj4gbGV2ZWwvZGlnZXN0IGxpc3QgbGV2ZWwsIHNpbmNlIHRoZXkgYXJlIHN0aWxsIGFwcHJhaXNl
ZCB3aXRoIGENCj4gc2lnbmF0dXJlLg0KPiANCj4gV2UgY2FuIGFkZCBhIG1lY2hhbmlzbSAoaWYg
aXQgZG9lcyBub3QgYWxyZWFkeSBleGlzdCkgdG8gaW52YWxpZGF0ZSB0aGUNCj4gaW50ZWdyaXR5
IHN0YXR1cyBiYXNlZCBvbiBrZXkgcmV2b2NhdGlvbiwgd2hpY2ggY2FuIGJlIHByb3BhZ2F0ZWQg
dG8NCj4gZmlsZXMgdmVyaWZpZWQgd2l0aCB0aGUgYWZmZWN0ZWQgZGlnZXN0IGxpc3RzLg0KPiAN
Cj4+IFdpdGggSU1BIGFwcHJhaXNhbCwgaXQgaXMgZWFzeSB0byBtYWludGFpbiBhdXRoZW50aWNp
dHkgYnV0IGNoYWxsZW5naW5nIHRvIA0KPj4gbWFpbnRhaW4gaW50ZWdyaXR5IG92ZXIgdGltZS4g
SW4gdXNlci1zcGFjZSB0aGVyZSBhcmUgY29uc3RhbnRseSBuZXcgQ1ZFcy4gIA0KPj4gVG8gbWFp
bnRhaW4gaW50ZWdyaXR5IG92ZXIgdGltZSwgZWl0aGVyIGtleXMgbmVlZCB0byBiZSByb3RhdGVk
IGluIHRoZSAuaW1hIA0KPj4ga2V5cmluZyBvciBwcm9ncmFtIGhhc2hlcyBuZWVkIHRvIGJlIGZy
ZXF1ZW50bHkgYWRkZWQgdG8gdGhlIC5ibGFja2xpc3QuICAgDQo+PiBJZiBuZWl0aGVyIGlzIGRv
bmUsIGZvciBhbiBlbmQtdXNlciBvbiBhIGRpc3RybywgSU1BLWFwcHJhaXNhbCBiYXNpY2FsbHkg
DQo+PiBndWFyYW50ZWVzIGF1dGhlbnRpY2l0eS4NCj4+IA0KPj4gV2hpbGUgSSB1bmRlcnN0YW5k
IHRoZSBpbnRlbnQgb2YgdGhlIHNlcmllcyBpcyB0byBpbmNyZWFzZSBwZXJmb3JtYW5jZSwgDQo+
PiBoYXZlIHlvdSBjb25zaWRlcmVkIHVzaW5nIHRoaXMgdG8gZ2l2ZSB0aGUgZW5kLXVzZXIgdGhl
IGFiaWxpdHkgdG8gbWFpbnRhaW4gDQo+PiBpbnRlZ3JpdHkgb2YgdGhlaXIgc3lzdGVtPyAgV2hh
dCBJIG1lYW4gaXMsIGluc3RlYWQgb2YgdHJ5aW5nIHRvIGltcG9ydCBhbnl0aGluZyANCj4+IGZy
b20gYW4gUlBNLCBqdXN0IGhhdmUgdGhlIGVuZC11c2VyIHByb3ZpZGUgdGhpcyBpbmZvcm1hdGlv
biBpbiBzb21lIGZvcm1hdCANCj4+IHRvIHRoZSBEaWdlc3QgQ2FjaGUuICBVc2VyLXNwYWNlIHRv
b2xzIGNvdWxkIGJlIGJ1aWx0IHRvIGNvbGxlY3QgYW5kIGZvcm1hdCANCj4gDQo+IFRoaXMgaXMg
YWxyZWFkeSBwb3NzaWJsZSwgZGlnZXN0LWNhY2hlLXRvb2xzDQo+IChodHRwczovL2dpdGh1Yi5j
b20vbGludXgtaW50ZWdyaXR5L2RpZ2VzdC1jYWNoZS10b29scykgYWxyZWFkeSBhbGxvdw0KPiB0
byBjcmVhdGUgYSBkaWdlc3QgbGlzdCB3aXRoIHRoZSBmaWxlIGEgdXNlciB3YW50cy4NCj4gDQo+
IEJ1dCBpbiB0aGlzIGNhc2UsIHRoZSB1c2VyIGlzIHZvdWNoaW5nIGZvciBoYXZpbmcgdGFrZW4g
dGhlIGNvcnJlY3QNCj4gbWVhc3VyZSBvZiB0aGUgZmlsZSBhdCB0aGUgdGltZSBpdCB3YXMgYWRk
ZWQgdG8gdGhlIGRpZ2VzdCBsaXN0LiBUaGlzDQo+IHdvdWxkIGJlIGluc3RlYWQgYXV0b21hdGlj
YWxseSBndWFyYW50ZWVkIGJ5IFJQTXMgb3Igb3RoZXIgcGFja2FnZXMNCj4gc2hpcHBlZCB3aXRo
IExpbnV4IGRpc3RyaWJ1dGlvbnMuDQo+IA0KPiBUbyBtaXRpZ2F0ZSB0aGUgY29uY2VybnMgb2Yg
Q1ZFcywgd2UgY2FuIHByb2JhYmx5IGltcGxlbWVudCBhIHJvbGxiYWNrDQo+IHByZXZlbnRpb24g
bWVjaGFuaXNtLCB3aGljaCB3b3VsZCBub3QgYWxsb3cgdG8gbG9hZCBhIHByZXZpb3VzIHZlcnNp
b24NCj4gb2YgYSBkaWdlc3QgbGlzdC4NCg0KSU1ITywgcHVyc3VpbmcgdGhpcyB3aXRoIHRoZSBl
bmQtdXNlciBiZWluZyBpbiBjb250cm9sIG9mIHdoYXQgaXMgY29udGFpbmVkIA0Kd2l0aGluIHRo
ZSBEaWdlc3QgQ2FjaGUgdnMgd2hhdCBpcyBjb250YWluZWQgaW4gYSBkaXN0cm8gd291bGQgcHJv
dmlkZSBtb3JlDQp2YWx1ZS4gQWxsb3dpbmcgdGhlIGVuZC11c2VyIHRvIGVhc2lseSB1cGRhdGUg
dGhlaXIgRGlnZXN0IENhY2hlIGluIHNvbWUgd2F5IA0Kd2l0aG91dCBoYXZpbmcgdG8gZG8gYW55
IHR5cGUgb2YgcmV2b2NhdGlvbiBmb3IgYm90aCBvbGQgYW5kIHZ1bG5lcmFibGUgDQphcHBsaWNh
dGlvbnMgd2l0aCBDVkVzIHdvdWxkIGJlIHZlcnkgYmVuZWZpY2lhbC4NCg0KSXMgdGhlcmUgYSBi
ZWxpZWYgdGhlIERpZ2VzdCBDYWNoZSB3b3VsZCBiZSB1c2VkIHdpdGhvdXQgc2lnbmVkIGtlcm5l
bCANCm1vZHVsZXM/ICBJcyB0aGUgcGVyZm9ybWFuY2UgZ2FpbiB3b3J0aCBjaGFuZ2luZyBob3cg
a2VybmVsIG1vZHVsZXMgDQpnZXQgbG9hZGVkIGF0IGJvb3Q/ICBDb3VsZG4ndCB0aGlzIHBhcnQg
anVzdCBiZSBkcm9wcGVkIGZvciBlYXNpZXIgYWNjZXB0YW5jZT8gIA0KSW50ZWdyaXR5IGlzIGFs
cmVhZHkgbWFpbnRhaW5lZCB3aXRoIHRoZSBjdXJyZW50IG1vZGVsIG9mIGFwcGVuZGVkIHNpZ25h
dHVyZXMuIA0KDQo=

