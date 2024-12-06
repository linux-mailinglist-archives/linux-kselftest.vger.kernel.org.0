Return-Path: <linux-kselftest+bounces-22918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4FD9E7395
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 16:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD292882B9
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 15:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC35207DFA;
	Fri,  6 Dec 2024 15:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lGClOsk5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VN9nXcZA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F6E1514CE;
	Fri,  6 Dec 2024 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498525; cv=fail; b=LBQ1hd01Qx8JeMQwWrGjh8doxzsegdHNYweyzMlHPHeKjg+/pk30JSxjnWEZzlGtmgcfm1GMCVLUgFzlXO2acB7wAzPfRaf/u5wCOucELxQ9MOAPbCh0+dCZMMfqAwJcoRcx2veyO030OaqUxRVVzSrwLUyFkHEHg0RoTw13kJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498525; c=relaxed/simple;
	bh=mZSX3TRln3zKS4tByq35V3QVlKlCCkW3KV/Hdd81CjM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FiNqowFIiN+eqI72kRSxronTI3ydbGk2u4q4V7UsskejC9X9KWWSVkYKIYGzijdkithMZhsOzynpseZXhzFP8MrPTJTkVHNLIDEUw1YJtctNgmwIpyU0cLRz1rG5P4SJKL+rzLPwN+8JoU7+aWvr4PX2zLkIy4hksws/99n7nCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lGClOsk5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VN9nXcZA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B66sNU5007992;
	Fri, 6 Dec 2024 15:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=mZSX3TRln3zKS4tByq35V3QVlKlCCkW3KV/Hdd81CjM=; b=
	lGClOsk5u6Q5F/0RR4PutU1btHrsCq2NL4s+r3NfYE3fLVFLMNXyYtmrXmH5rS5L
	VOCdyHdPQ/lJ3RDiqE33hg++Kb6ZPpMNAI+UpAPi64X5GlqhogUcKYoKqvdmh1ET
	9oXpADRM+iHCim4hLxb4sxR6N6W76HaIfhscIC55ZBrykTG7BO256H/+NQyeSKaJ
	elXT7vgeUZjkGDDTtPHCdX/swCRCCLKdSHziTdkPDcBYvTr+YFTDpuQXlDZ5mDkp
	ikR7uaiExHWoJ8bmSUyyBgD5pfnPMEx3d7t1Z90xXmshBzySRhHcvNv+AA60eGjK
	fp7gh+TEZkXjVRAnSpgpww==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437smansb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 15:16:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6E5kna011752;
	Fri, 6 Dec 2024 15:16:04 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s5cddpj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 15:16:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xubr6tAG9/Ap4uqfHJ2sG+d53byRvp9MeohKwUXjvikxoNxzwYA3RmIjrHsruaD3/B2anlAvcOLVNAkcvVRI+gTIGiOGzXX+uHU/1Ktk8yYg7ApKY/HGv3g5HJwj0fipPGIy7UybuIF+Je9mPLBFHRe2foBJtBP5w7lToZ/3m2aXkUloHoXcWth/6uvtMHTsNK/6M+A4nVsw/9NZs8G5VHubNQusHPmPDk43tz2DXazW/fj82U2h7h30OZwWMTi4wypSjd4Ik5jRZp3Pf08wtitOGetDZlo+CKw9MZKYJgMIlP87ItufmYl23oo5i95U23enWQUJNxNv7ScHkvww2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZSX3TRln3zKS4tByq35V3QVlKlCCkW3KV/Hdd81CjM=;
 b=CjQDZQSFXZSIzRzmeOgLRo2i9QFk2nb5KLrccqL+J0rrZv++82QEj3sIg0ZPfrFlx4Kz8sR2muMt4ZDK6JXudB9py/goJNB9/6KODpzlwYkqq4ByM29jbP6/Eel9TBhV53ruo6OqQY1unRpcgPNHTt9PV25q3MWkZJEi0j4GPZSGV5KkEFW5BkKN51AEHbQzdMlIBQxfGujdRjBsvCmhwRNWUBj8VkJoyOspoSuD25Te9IDZQOu+cmJzSlKi1xXsSRQWU4HUtzMwotcSkVsC47m2Whggx/cbQQAARj+XldQ5MXfQdYi87hjpKqpbpN2rBQ552pb96ZnZrE9/z00tvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZSX3TRln3zKS4tByq35V3QVlKlCCkW3KV/Hdd81CjM=;
 b=VN9nXcZAnNQkUMD/ELlvLsoPqyK/wwQAxWIlo/Yvk+r1nkhR1Ns+DvcZK6vK22RI2JQdRWEbL2VWQeI+TPskQp75NgiOY2M5pqaIHKugylmR7QMEdMWJOniyBEcmTf0Z7cSs88QdLHw70WCFnb3vJ1KDDB8MuUCnrPB7qQWx45w=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by CH0PR10MB4971.namprd10.prod.outlook.com (2603:10b6:610:c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 15:15:59 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%7]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 15:15:59 +0000
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
Thread-Index:
 AQHbOnDjfg4en7nkgkyalKK8KF8lk7LIuzaAgACvegCAC539gIAA9ZKAgADuJoCAAIUbgIAAe8GAgAA5TACAAPG+gIAAVkmA
Date: Fri, 6 Dec 2024 15:15:59 +0000
Message-ID: <C5C46D67-F45B-406A-AD84-8CC8285E40C3@oracle.com>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
 <C4BE31F8-1FA3-4AD1-A712-ED2AA7E61E96@oracle.com>
 <17ef4f662e594c8431a00fe423507af4f6a82286.camel@huaweicloud.com>
 <B135AC90-7CE5-4E51-90B1-9D82031668A8@oracle.com>
 <00f3eb72042aedaa4644ff0932d06d4e8d215f6b.camel@huaweicloud.com>
 <B0DC94E7-78A3-4797-B864-31DE0A2C903C@oracle.com>
 <3a759c091ac097be84b882dd992e6e216ec11723.camel@huaweicloud.com>
 <d3b1c297e860339a00d3e11d1a777362833aadad.camel@huaweicloud.com>
 <F9EE3709-2A90-4E9A-8531-44EC0F9C240C@oracle.com>
 <d7eb63db3ee2c04fc92efe30dc9c1eadabd3f61a.camel@huaweicloud.com>
In-Reply-To: <d7eb63db3ee2c04fc92efe30dc9c1eadabd3f61a.camel@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR10MB7730:EE_|CH0PR10MB4971:EE_
x-ms-office365-filtering-correlation-id: 50d68059-165b-4ca7-ed78-08dd1608e412
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NTNVR2d6SENOY0ZSTWZCV0hKanJOWmpsdjUvOHd6cmVtakZmTlBoVkg5cktQ?=
 =?utf-8?B?Z1dXZXIzd3lQTmVQNjJ3Y0JQTWY4RkNoZHZqNHU4bzRrZTRmNlVMdm1PK25E?=
 =?utf-8?B?UHl0bVJaMmlnL2Y4NVlFaEJ6YWNIeTh5c1lGdHdHWTd2QlozanR6SVNFY0M4?=
 =?utf-8?B?QmFkc2dYd2pnQ2JGaldibjYxVjhBbmVyL3BNbGp0dzUyOHdNWlNDYXFwdTdR?=
 =?utf-8?B?bU9SaHJGS0Y2SnVyc2NqK3BrY3dXZWd0VmpkZ1FmNEUrUThRZUxnaTFJZDIr?=
 =?utf-8?B?ZzFpOG5sb2dMYXlBYW9Oa1BocW41Q01TQ2c0anJTbTRtNW5xd2VoVjM5aEU5?=
 =?utf-8?B?OTIydis4eVNRZEZoUmp6RE55THhlVHB4ZktKZTNxOUFZUCtFeC9qN0ZxdlRk?=
 =?utf-8?B?VE9KUTFtMXBzZkYvbUtkYWcrc1RhaEZDNXl6UUhrWWFyN2kwdVlna3QvWGRw?=
 =?utf-8?B?UFNkNC9ialJTWnN2NEE4REFYTS80SFdwVkdGMHlKUXlYRk5lY01qd2xEQzVP?=
 =?utf-8?B?UFZBUUpaQit5bktQSVBGWVk1d0FYK1RnWVBXWGR5UDdiOWNVdEhVRzVySFVN?=
 =?utf-8?B?WlRoK2pIajIwaDBJcSttTGVtRjV3a3JLc2dKUzg0ZTdsK3ZzUDRrUCs4QVR6?=
 =?utf-8?B?SW5vQlpTNXBuRHBWVzNXU2k5VmNvWk9tSXFvNmoxSFhPWERDUHpKRE9JUHM5?=
 =?utf-8?B?WVNzanpzamh6RmtSZWgrc1JOM2ZCdGJTVWcxOFBUQzlTN2J5N3BIRERCdUdT?=
 =?utf-8?B?d1Z3bkRXMzJIcFllaDArcWtYOEpUT0kxK0VEMkZvU3NGWThtb3NkK1V6NmVU?=
 =?utf-8?B?M0NWNnliTkpXd05jaWNHNlR5Y3l6NTZmcXRXdWhuVXY5NW4xZkQ0SUFueDdz?=
 =?utf-8?B?UU9RRmM4NytCS2hTVGNFUW1panlnNG9VNjJablR5Q1JyMTNQcGd6eURUcSsr?=
 =?utf-8?B?YzgwMlVSa0FpNTRpM3ZmeWw1T3lQcnhwTkNYOUs0aGdOSW1xb0hTOUhkZUxJ?=
 =?utf-8?B?aW9ucUFwR2hHalVZR1Z6K0dLTmV3VmJyZTdXNkUwNE1VK2NQV2h4ZExtcnJI?=
 =?utf-8?B?RG1iSHZ4R05RNExVMy9RS3Z0UmFTQ0cvUkNqY2NORDVyWVhMMGlNK3ZvOVdD?=
 =?utf-8?B?dHFYUWUvWXJLaHB5UU4vKytzQUdZKzZ0Mit5a0pZNVJIUXROcmRDZk8xQ080?=
 =?utf-8?B?cEZWQ3BZRUMvZXFEOWV5amVLRkN6U2ZYNis4Ty82Y2lxV3E2b2lkcG5TYTNB?=
 =?utf-8?B?c3lzWWJQNzgzclZ4VmQwS2g0RU5xb3ZXUmx6aVdOLzFBMnRFbDN6cVBOUWxl?=
 =?utf-8?B?d2xFUGJFMVpwWGtYWVprNHBWeXVab1ovQUp1T2xxK1BrVjlqdyticlR6bFFw?=
 =?utf-8?B?NWJKeElhbWNlWjB3Ukp1UDhIWjRrOVJwYWgzT1M5V3JvczBNdmVENmh6NnVr?=
 =?utf-8?B?SlZvTE9pcGZ2QmwvcWxqMnNXWUtBVHZwanVqbzFhakJVWG9IaGhwc1FDMEd6?=
 =?utf-8?B?elpBWnl3OC80NkNhZUk4MjJkOFFUait2c1lYNGk2VjR1d0wxWjVNZnBHQ0tI?=
 =?utf-8?B?VTExQk53QlU2WGNteDZpVjlCTVMwQVVnTThuVUw3T1BmQjVkdTNZWW5SRU9z?=
 =?utf-8?B?VWVNMWtWWmt0Y1pyUlQxczZmam1zbmM4dnFvMFNRb213YzJwYndWemRZNGJ2?=
 =?utf-8?B?b1d6c1RUOWFJNHhJVlg5L3dMODhjdFVhYll6dkhSaHJNbWhnMkxudWhNckth?=
 =?utf-8?B?c1EvRnh0bTZCa2h1MERBbDhiUWwrazlFdllUWTRYYUN6aUtPS0V1T05EaHVi?=
 =?utf-8?B?UXdISkRjaDQyRzZIa3RtQ2FqZUNkMWdJRjV3VVAwMnpmTnVxK1p3aTRlNkVL?=
 =?utf-8?B?VU4yL3Nja244Q29ob1BaVXJHTXBUNzNUdTJ4RG1oVzlqak9tNFFGYWg0dGZx?=
 =?utf-8?Q?oGisIs02LGw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QnZKMEQyMlRCVUp6UGVoRXczS0pmZFZjYlhTaENscGNKQlFkaGJKaTd2T3Ax?=
 =?utf-8?B?S1RjcTNzQUpuT0c2QVgrVTNic1FEUW5OeDZ5UTl2bWFZN3NYV21HOHhQT0ty?=
 =?utf-8?B?Tm9BLzlrbTNkYmx5NTFYYTFxV255OVhrMDB1YnFnN1JZK29QSUhmdjRlZW1W?=
 =?utf-8?B?MDV3M2czV3BVbkN6MHkxdnplanRlQ2VlNFNxa2F3MXlOR3JTTndQTC9nT2FO?=
 =?utf-8?B?ZXRnUG1qVEpXWG5tUWEvemhNWXhsdm4rL1ZlSmFlTkdRTGZKRStPVUpiUDho?=
 =?utf-8?B?blNuWHdJcnp3OGxOTDJWdlVBS0ZWeUt0U1poY3hnZ01MRVZzTnhsZzFHL21J?=
 =?utf-8?B?T0QyUUpOYmZrNlUxUktyNWZuWVA2cVk2citnbUtYWWNaRktJVFVVWjRjL3pa?=
 =?utf-8?B?VHVsNmtubkVKK09FTEM0MUpxemowS05HL1NMazRhRHNvaEU5QjE1dlV6Y1ZX?=
 =?utf-8?B?NXlJUS9Xb2FnNWpnV09jZUtIUy81YXFhVEVRRUVHYUROb0l3WnRhRmdTc3dt?=
 =?utf-8?B?VElPWFNNVmNrUFFFZmRHSFl6V0VaN0NVVmxiY0drd0dSbFJTQkluakhjMFhZ?=
 =?utf-8?B?V3crREtEZlVYa0FSSVMvUVRhL011ZTNrcHRXejU3N2dEMkFIemdVQ3h0Vzhq?=
 =?utf-8?B?ZnlVNmM5UEpNZDRCa2IycEF5cTZJb1Q0eUxZLzMyUU44VHMxYnNIbDNaNm1O?=
 =?utf-8?B?Y1dSTlN1QTYwN1JjNHVncTJ3RzE1LzcxcEJITzBYSDlZaHpIVFJVU1UvcWVL?=
 =?utf-8?B?amg4a0VEMGNaR1gwSzVmUEg1akdZd3RQNDdUL2ROV0pia1FxMGJhSXg1QmFX?=
 =?utf-8?B?RUM5bWhTN2F4MW90QnpTRWtGeDlmU0dnRk50cDR0TndvLzd0bWk5ZG5lOC9O?=
 =?utf-8?B?d0p5SVFiU3Z1aGJuZ2tnNCtzcmdXYTlXbEExbEV4dnRQVWdac0ViZ1ZrUjNS?=
 =?utf-8?B?YnhWVWNXNTBKbldkRTM1K3F0T1FLblM0akRHYmg3ektMUWR0bzZTY3VIZ041?=
 =?utf-8?B?TFdFenUxUjFnRko1ZHlhVkJiemV5bW9HUDU5bDhwejFGQlR0RHBJbE84b3l2?=
 =?utf-8?B?cnRMc1B5U3I5MytkajBaUWFkWEtIOFlBRW1sWHBUdG5DMXJrbzJRUkJDWElh?=
 =?utf-8?B?REpYNWs0NXdVOWxQbGh4MTk5RGVVOUdUSGhSWlZiT1QyUmNRS1Zyd3pEN3Bs?=
 =?utf-8?B?L2p1UG43M3hBSHhXeVRJTHFGT0VxKzdIckJCMXVCbXpyRmo0Q0FzOTFML0pi?=
 =?utf-8?B?SU1MTmJRNHRxdmNsallZdXhJMWlWRUVQUGJ5RkdTNEU5dytKU005cmhkbXZ5?=
 =?utf-8?B?QmpFZG5wTjlENHpMQ2pLKzhnSDVNNW5lQTJ0R25KNHViWjJnNG9BNk9VMkJK?=
 =?utf-8?B?Z3VVZWFVR2lOUk54a0J6Y0R4NmRtSDlzNlJXcnVTc0paeFJiU0Vja2RCZ3lr?=
 =?utf-8?B?aHZDYVQxdGU5N3FPenA0WHZZMTV0UElKTWliQVpwaTNsOHkrWXhSYkErZ3NR?=
 =?utf-8?B?OHJ1T0ZoSEUrL0dScXpKNnlhd0Q3SGxmRTJrUzBzU1hsejNaWTJiT1dpekMy?=
 =?utf-8?B?TUlDRGJ1U2E2bGlRV1R1bW1qU2EzNGRyMThHZUFWU0x0eVRMNHhaS0xMTEVi?=
 =?utf-8?B?L1pod2FVejlZdmlibXYwOG1wOHN5MUx1Sy9EMnBCMStoYzgxMktORnkxb0tt?=
 =?utf-8?B?SGlyZXZ6MDF6bkpQMnJIT1V6N2ZXQm05dkx0U1lRZUtHdTRPM0NvVFIwU2lY?=
 =?utf-8?B?bTNqOEMwVnp1SUdlQlliQWYxVDgzQ2s2WTh4Z2d5SVpRU1hZN0VRMm5kbm16?=
 =?utf-8?B?R1VrMEExSWYvaGZOdGU5ZkV2NDR4TU5VT1RRUEhaNktYTmp1WHcxSG4zeEZw?=
 =?utf-8?B?M09SRGFtL1pMcmx2Y2tRcUtUY3NWdU1BQzNSaTRhTDlCMzFRT0NBNTgyV0hB?=
 =?utf-8?B?cHdqUGMyWmlxeGJjZU1ZTmtuMTl2SXhBbEs4UGV2a09xVkhQVWNIZXVTcGVH?=
 =?utf-8?B?VlY5WDRsR3dhNEQ2NnUzZFkzcnNURmRpTGtyQUEwM0RoSzVJWmdsbCtPQzhN?=
 =?utf-8?B?TEUvK3J2TFdVV2pVMDZhTFlSZ3l2R3NuNTNuNkVYVHpNY1h0NDJPQkI5dSs0?=
 =?utf-8?B?STd6WWtjdmY1OVhwejVmWlU5YjhDMlZQMUxFUnd2elRjR3Y0RlpBaFlTSVln?=
 =?utf-8?B?bVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B7FA27023B90241B56B4BAA0F64A2C1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jJl8QlsCVEAn8/IcceGI4b8H53s/e6V+95c1pU8zCSCk1HgO5ZInzbgCZxnU6xrFKZGGbpnlUNqqt405225P6DUSM1uy0LqLNk27a8k4xqCIVO2Q6eB38uoDj1S2E0ykkbO9TbfpLp+ml1aypd9Aishuqojx1jAzJfSINxAAeaETSCfyx/lW7PS3glmQHJk+KbQjywGdwvJFp7VO46zc1nL2xyq1tnzl5wcF3sEUToJs6+yQ5/NfKr3JVqV4PvNQmwr/dq+sAoB2E10FO02qXMfrxy3HcvXcu6e/qakswhG8zdKsFTk+eOm0vGrN2IRJLkvtUR/msjJ73V+yWPcG6crdeo40WioFTFEz4ZFG7knIO0tax6vFHChpJAssGAtimmeshy+ZWXnLddJt1r/hmtrq0eJ8p3QatTgl9HcUjswLfq7Q0Wjur4eN0pebN4C65xZcM3FRMSP9YHWYfBJycei0z0c5Udu/mmiMSzWf2at6h1UBkbzMxP+/6WbT3nvnxDboW+CQcgRR4gwUNOP4iXhkdCxIX7EMg17aJheJaEvTbswomqiJ82KXMX1hk6leWGoANXUwTv+JnK4KpgOlYX2hOfCdxlXgbu+UCadajrU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d68059-165b-4ca7-ed78-08dd1608e412
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 15:15:59.8224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PfdK06SrZyZBPndutseVrljlfkBM+YvC8UEd5W/dej7LWdsG4aIy4EbkbWVVsAmdhpFAtkUh+iL8zXcl7oMW50GXDdS1rKsZg3l7A6jwhC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4971
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-06_10,2024-12-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412060115
X-Proofpoint-ORIG-GUID: lXRaXAPitHsEeYXVO7S_k4K7vuNIiBkr
X-Proofpoint-GUID: lXRaXAPitHsEeYXVO7S_k4K7vuNIiBkr

DQoNCj4gT24gRGVjIDYsIDIwMjQsIGF0IDM6MDbigK9BTSwgUm9iZXJ0byBTYXNzdSA8cm9iZXJ0
by5zYXNzdUBodWF3ZWljbG91ZC5jb20+IHdyb3RlOg0KPiANCj4gT24gVGh1LCAyMDI0LTEyLTA1
IGF0IDE5OjQxICswMDAwLCBFcmljIFNub3diZXJnIHdyb3RlOg0KPj4gDQo+Pj4gT24gRGVjIDUs
IDIwMjQsIGF0IDk6MTbigK9BTSwgUm9iZXJ0byBTYXNzdSA8cm9iZXJ0by5zYXNzdUBodWF3ZWlj
bG91ZC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIFRodSwgMjAyNC0xMi0wNSBhdCAwOTo1MyAr
MDEwMCwgUm9iZXJ0byBTYXNzdSB3cm90ZToNCj4+Pj4gT24gVGh1LCAyMDI0LTEyLTA1IGF0IDAw
OjU3ICswMDAwLCBFcmljIFNub3diZXJnIHdyb3RlOg0KPj4+Pj4gDQo+Pj4+Pj4gT24gRGVjIDQs
IDIwMjQsIGF0IDM6NDTigK9BTSwgUm9iZXJ0byBTYXNzdSA8cm9iZXJ0by5zYXNzdUBodWF3ZWlj
bG91ZC5jb20+IHdyb3RlOg0KPj4+Pj4+IA0KPj4+Pj4+IE9uIFR1ZSwgMjAyNC0xMi0wMyBhdCAy
MDowNiArMDAwMCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBPbiBO
b3YgMjYsIDIwMjQsIGF0IDM6NDHigK9BTSwgUm9iZXJ0byBTYXNzdSA8cm9iZXJ0by5zYXNzdUBo
dWF3ZWljbG91ZC5jb20+IHdyb3RlOg0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBPbiBUdWUsIDIwMjQt
MTEtMjYgYXQgMDA6MTMgKzAwMDAsIEVyaWMgU25vd2Jlcmcgd3JvdGU6DQo+Pj4+Pj4+Pj4gDQo+
Pj4+Pj4+Pj4+IE9uIE5vdiAxOSwgMjAyNCwgYXQgMzo0OeKAr0FNLCBSb2JlcnRvIFNhc3N1IDxy
b2JlcnRvLnNhc3N1QGh1YXdlaWNsb3VkLmNvbT4gd3JvdGU6DQo+Pj4+Pj4+Pj4+IA0KPj4+Pj4+
Pj4+PiBGcm9tOiBSb2JlcnRvIFNhc3N1IDxyb2JlcnRvLnNhc3N1QGh1YXdlaS5jb20+DQo+Pj4+
Pj4+Pj4+IA0KPj4+Pj4+Pj4+PiBUaGUgSW50ZWdyaXR5IERpZ2VzdCBDYWNoZSBjYW4gYWxzbyBo
ZWxwIElNQSBmb3IgYXBwcmFpc2FsLiBJTUEgY2FuIHNpbXBseQ0KPj4+Pj4+Pj4+PiBsb29rdXAg
dGhlIGNhbGN1bGF0ZWQgZGlnZXN0IG9mIGFuIGFjY2Vzc2VkIGZpbGUgaW4gdGhlIGxpc3Qgb2Yg
ZGlnZXN0cw0KPj4+Pj4+Pj4+PiBleHRyYWN0ZWQgZnJvbSBwYWNrYWdlIGhlYWRlcnMsIGFmdGVy
IHZlcmlmeWluZyB0aGUgaGVhZGVyIHNpZ25hdHVyZS4gSXQgaXMNCj4+Pj4+Pj4+Pj4gc3VmZmlj
aWVudCB0byB2ZXJpZnkgb25seSBvbmUgc2lnbmF0dXJlIGZvciBhbGwgZmlsZXMgaW4gdGhlIHBh
Y2thZ2UsIGFzDQo+Pj4+Pj4+Pj4+IG9wcG9zZWQgdG8gdmVyaWZ5aW5nIGEgc2lnbmF0dXJlIGZv
ciBlYWNoIGZpbGUuDQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4gSXMgdGhlcmUgYSB3YXkgdG8gbWFp
bnRhaW4gaW50ZWdyaXR5IG92ZXIgdGltZT8gIFRvZGF5IGlmIGEgQ1ZFIGlzIGRpc2NvdmVyZWQg
DQo+Pj4+Pj4+Pj4gaW4gYSBzaWduZWQgcHJvZ3JhbSwgdGhlIHByb2dyYW0gaGFzaCBjYW4gYmUg
YWRkZWQgdG8gdGhlIGJsYWNrbGlzdCBrZXlyaW5nLiANCj4+Pj4+Pj4+PiBMYXRlciBpZiBJTUEg
YXBwcmFpc2FsIGlzIHVzZWQsIHRoZSBzaWduYXR1cmUgdmFsaWRhdGlvbiB3aWxsIGZhaWwganVz
dCBmb3IgdGhhdCANCj4+Pj4+Pj4+PiBwcm9ncmFtLiAgV2l0aCB0aGUgSW50ZWdyaXR5IERpZ2Vz
dCBDYWNoZSwgaXMgdGhlcmUgYSB3YXkgdG8gZG8gdGhpcz8gIA0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+
PiBBcyBmYXIgYXMgSSBjYW4gc2VlLCB0aGUgaW1hX2NoZWNrX2JsYWNrbGlzdCgpIGNhbGwgaXMg
YmVmb3JlDQo+Pj4+Pj4+PiBpbWFfYXBwcmFpc2VfbWVhc3VyZW1lbnQoKS4gSWYgaXQgZmFpbHMs
IGFwcHJhaXNhbCB3aXRoIHRoZSBJbnRlZ3JpdHkNCj4+Pj4+Pj4+IERpZ2VzdCBDYWNoZSB3aWxs
IG5vdCBiZSBkb25lLg0KPj4+Pj4+PiANCj4+Pj4+Pj4gDQo+Pj4+Pj4+IEl0IGlzIGdvb2QgdGhl
IHByb2dyYW0gaGFzaCB3b3VsZCBiZSBjaGVja2VkIGJlZm9yZWhhbmQgYW5kIGZhaWwgaWYgaXQg
aXMgDQo+Pj4+Pj4+IGNvbnRhaW5lZCBvbiB0aGUgbGlzdC4gDQo+Pj4+Pj4+IA0KPj4+Pj4+PiBU
aGUgLmltYSBrZXlyaW5nIG1heSBjb250YWluIG1hbnkga2V5cy4gIElmIG9uZSBvZiB0aGUga2V5
cyB3YXMgbGF0ZXIgDQo+Pj4+Pj4+IHJldm9rZWQgYW5kIGFkZGVkIHRvIHRoZSAuYmxhY2tsaXN0
LCB3b3VsZG4ndCB0aGlzIGJlIG1pc3NlZD8gIEl0IHdvdWxkIA0KPj4+Pj4+PiBiZSBjYXVnaHQg
ZHVyaW5nIHNpZ25hdHVyZSB2YWxpZGF0aW9uIHdoZW4gdGhlIGZpbGUgaXMgbGF0ZXIgYXBwcmFp
c2VkLCBidXQgDQo+Pj4+Pj4+IG5vdyB0aGlzIHN0ZXAgaXNuJ3QgdGFraW5nIHBsYWNlLiAgQ29y
cmVjdD8NCj4+Pj4+PiANCj4+Pj4+PiBGb3IgZmlsZXMgaW5jbHVkZWQgaW4gdGhlIGRpZ2VzdCBs
aXN0cywgeWVzLCB0aGVyZSB3b24ndCBiZSBkZXRlY3Rpb24NCj4+Pj4+PiBvZiBsYXRlciByZXZv
Y2F0aW9uIG9mIGEga2V5LiBIb3dldmVyLCBpdCB3aWxsIHN0aWxsIHdvcmsgYXQgcGFja2FnZQ0K
Pj4+Pj4+IGxldmVsL2RpZ2VzdCBsaXN0IGxldmVsLCBzaW5jZSB0aGV5IGFyZSBzdGlsbCBhcHBy
YWlzZWQgd2l0aCBhDQo+Pj4+Pj4gc2lnbmF0dXJlLg0KPj4+Pj4+IA0KPj4+Pj4+IFdlIGNhbiBh
ZGQgYSBtZWNoYW5pc20gKGlmIGl0IGRvZXMgbm90IGFscmVhZHkgZXhpc3QpIHRvIGludmFsaWRh
dGUgdGhlDQo+Pj4+Pj4gaW50ZWdyaXR5IHN0YXR1cyBiYXNlZCBvbiBrZXkgcmV2b2NhdGlvbiwg
d2hpY2ggY2FuIGJlIHByb3BhZ2F0ZWQgdG8NCj4+Pj4+PiBmaWxlcyB2ZXJpZmllZCB3aXRoIHRo
ZSBhZmZlY3RlZCBkaWdlc3QgbGlzdHMuDQo+Pj4+Pj4gDQo+Pj4+Pj4+IFdpdGggSU1BIGFwcHJh
aXNhbCwgaXQgaXMgZWFzeSB0byBtYWludGFpbiBhdXRoZW50aWNpdHkgYnV0IGNoYWxsZW5naW5n
IHRvIA0KPj4+Pj4+PiBtYWludGFpbiBpbnRlZ3JpdHkgb3ZlciB0aW1lLiBJbiB1c2VyLXNwYWNl
IHRoZXJlIGFyZSBjb25zdGFudGx5IG5ldyBDVkVzLiAgDQo+Pj4+Pj4+IFRvIG1haW50YWluIGlu
dGVncml0eSBvdmVyIHRpbWUsIGVpdGhlciBrZXlzIG5lZWQgdG8gYmUgcm90YXRlZCBpbiB0aGUg
LmltYSANCj4+Pj4+Pj4ga2V5cmluZyBvciBwcm9ncmFtIGhhc2hlcyBuZWVkIHRvIGJlIGZyZXF1
ZW50bHkgYWRkZWQgdG8gdGhlIC5ibGFja2xpc3QuICAgDQo+Pj4+Pj4+IElmIG5laXRoZXIgaXMg
ZG9uZSwgZm9yIGFuIGVuZC11c2VyIG9uIGEgZGlzdHJvLCBJTUEtYXBwcmFpc2FsIGJhc2ljYWxs
eSANCj4+Pj4+Pj4gZ3VhcmFudGVlcyBhdXRoZW50aWNpdHkuDQo+Pj4+Pj4+IA0KPj4+Pj4+PiBX
aGlsZSBJIHVuZGVyc3RhbmQgdGhlIGludGVudCBvZiB0aGUgc2VyaWVzIGlzIHRvIGluY3JlYXNl
IHBlcmZvcm1hbmNlLCANCj4+Pj4+Pj4gaGF2ZSB5b3UgY29uc2lkZXJlZCB1c2luZyB0aGlzIHRv
IGdpdmUgdGhlIGVuZC11c2VyIHRoZSBhYmlsaXR5IHRvIG1haW50YWluIA0KPj4+Pj4+PiBpbnRl
Z3JpdHkgb2YgdGhlaXIgc3lzdGVtPyAgV2hhdCBJIG1lYW4gaXMsIGluc3RlYWQgb2YgdHJ5aW5n
IHRvIGltcG9ydCBhbnl0aGluZyANCj4+Pj4+Pj4gZnJvbSBhbiBSUE0sIGp1c3QgaGF2ZSB0aGUg
ZW5kLXVzZXIgcHJvdmlkZSB0aGlzIGluZm9ybWF0aW9uIGluIHNvbWUgZm9ybWF0IA0KPj4+Pj4+
PiB0byB0aGUgRGlnZXN0IENhY2hlLiAgVXNlci1zcGFjZSB0b29scyBjb3VsZCBiZSBidWlsdCB0
byBjb2xsZWN0IGFuZCBmb3JtYXQgDQo+Pj4+Pj4gDQo+Pj4+Pj4gVGhpcyBpcyBhbHJlYWR5IHBv
c3NpYmxlLCBkaWdlc3QtY2FjaGUtdG9vbHMNCj4+Pj4+PiAoaHR0cHM6Ly9naXRodWIuY29tL2xp
bnV4LWludGVncml0eS9kaWdlc3QtY2FjaGUtdG9vbHMpIGFscmVhZHkgYWxsb3cNCj4+Pj4+PiB0
byBjcmVhdGUgYSBkaWdlc3QgbGlzdCB3aXRoIHRoZSBmaWxlIGEgdXNlciB3YW50cy4NCj4+Pj4+
PiANCj4+Pj4+PiBCdXQgaW4gdGhpcyBjYXNlLCB0aGUgdXNlciBpcyB2b3VjaGluZyBmb3IgaGF2
aW5nIHRha2VuIHRoZSBjb3JyZWN0DQo+Pj4+Pj4gbWVhc3VyZSBvZiB0aGUgZmlsZSBhdCB0aGUg
dGltZSBpdCB3YXMgYWRkZWQgdG8gdGhlIGRpZ2VzdCBsaXN0LiBUaGlzDQo+Pj4+Pj4gd291bGQg
YmUgaW5zdGVhZCBhdXRvbWF0aWNhbGx5IGd1YXJhbnRlZWQgYnkgUlBNcyBvciBvdGhlciBwYWNr
YWdlcw0KPj4+Pj4+IHNoaXBwZWQgd2l0aCBMaW51eCBkaXN0cmlidXRpb25zLg0KPj4+Pj4+IA0K
Pj4+Pj4+IFRvIG1pdGlnYXRlIHRoZSBjb25jZXJucyBvZiBDVkVzLCB3ZSBjYW4gcHJvYmFibHkg
aW1wbGVtZW50IGEgcm9sbGJhY2sNCj4+Pj4+PiBwcmV2ZW50aW9uIG1lY2hhbmlzbSwgd2hpY2gg
d291bGQgbm90IGFsbG93IHRvIGxvYWQgYSBwcmV2aW91cyB2ZXJzaW9uDQo+Pj4+Pj4gb2YgYSBk
aWdlc3QgbGlzdC4NCj4+Pj4+IA0KPj4+Pj4gSU1ITywgcHVyc3VpbmcgdGhpcyB3aXRoIHRoZSBl
bmQtdXNlciBiZWluZyBpbiBjb250cm9sIG9mIHdoYXQgaXMgY29udGFpbmVkIA0KPj4+Pj4gd2l0
aGluIHRoZSBEaWdlc3QgQ2FjaGUgdnMgd2hhdCBpcyBjb250YWluZWQgaW4gYSBkaXN0cm8gd291
bGQgcHJvdmlkZSBtb3JlDQo+Pj4+PiB2YWx1ZS4gQWxsb3dpbmcgdGhlIGVuZC11c2VyIHRvIGVh
c2lseSB1cGRhdGUgdGhlaXIgRGlnZXN0IENhY2hlIGluIHNvbWUgd2F5IA0KPj4+Pj4gd2l0aG91
dCBoYXZpbmcgdG8gZG8gYW55IHR5cGUgb2YgcmV2b2NhdGlvbiBmb3IgYm90aCBvbGQgYW5kIHZ1
bG5lcmFibGUgDQo+Pj4+PiBhcHBsaWNhdGlvbnMgd2l0aCBDVkVzIHdvdWxkIGJlIHZlcnkgYmVu
ZWZpY2lhbC4NCj4+Pj4gDQo+Pj4+IFllcywgZGVsZXRpbmcgdGhlIGRpZ2VzdCBsaXN0IHdvdWxk
IGludmFsaWRhdGUgYW55IGludGVncml0eSByZXN1bHQNCj4+Pj4gZG9uZSB3aXRoIHRoYXQgZGln
ZXN0IGxpc3QuDQo+Pj4+IA0KPj4+PiBJIGRldmVsb3BlZCBhbHNvIGFuIHJwbSBwbHVnaW4gdGhh
dCBzeW5jaHJvbml6ZXMgdGhlIGRpZ2VzdCBsaXN0cyB3aXRoDQo+Pj4+IGluc3RhbGxlZCBzb2Z0
d2FyZS4gT2xkIHZ1bG5lcmFibGUgc29mdHdhcmUgY2Fubm90IGJlIHZlcmlmaWVkIGFueW1vcmUN
Cj4+Pj4gd2l0aCB0aGUgSW50ZWdyaXR5IERpZ2VzdCBDYWNoZSwgc2luY2UgdGhlIHJwbSBwbHVn
aW4gZGVsZXRlcyB0aGUgb2xkDQo+Pj4+IHNvZnR3YXJlIGRpZ2VzdCBsaXN0cy4NCj4+Pj4gDQo+
Pj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC1pbnRlZ3JpdHkvZGlnZXN0LWNhY2hlLXRvb2xz
L2Jsb2IvbWFpbi9ycG0tcGx1Z2luL2RpZ2VzdF9jYWNoZS5jDQo+Pj4+IA0KPj4+PiBUaGUgZ29v
ZCB0aGluZyBpcyB0aGF0IHRoZSBJbnRlZ3JpdHkgRGlnZXN0IENhY2hlIGNhbiBiZSBlYXNpbHkN
Cj4+Pj4gY29udHJvbGxlZCB3aXRoIGZpbGVzeXN0ZW0gb3BlcmF0aW9ucyAoaXQgd29ya3Mgc2lt
aWxhcmx5IHRvIHNlY3VyaXR5DQo+Pj4+IGJsb2JzIGF0dGFjaGVkIHRvIGtlcm5lbCBvYmplY3Rz
LCBsaWtlIGlub2RlcyBhbmQgZmlsZSBkZXNjcmlwdG9ycykuDQo+Pj4+IA0KPj4+PiBBcyBzb29u
IGFzIHNvbWV0aGluZyBjaGFuZ2VzIChlLmcuIGRpZ2VzdCBsaXN0IHdyaXR0ZW4sIGxpbmsgdG8g
dGhlDQo+Pj4+IGRpZ2VzdCBsaXN0cyksIHRoaXMgdHJpZ2dlcnMgYSByZXNldCBpbiB0aGUgSW50
ZWdyaXR5IERpZ2VzdCBDYWNoZSwgc28NCj4+Pj4gZGlnZXN0IGxpc3RzIGFuZCBmaWxlcyBuZWVk
IHRvIGJlIHZlcmlmaWVkIGFnYWluLiBEZWxldGluZyB0aGUgZGlnZXN0DQo+Pj4+IGxpc3QgY2F1
c2VzIHRoZSBpbi1rZXJuZWwgZGlnZXN0IGNhY2hlIHRvIGJlIHdpcGVkIGF3YXkgdG9vICh3aGVu
IHRoZQ0KPj4+PiByZWZlcmVuY2UgY291bnQgcmVhY2hlcyB6ZXJvKS4NCj4+Pj4gDQo+Pj4+PiBJ
cyB0aGVyZSBhIGJlbGllZiB0aGUgRGlnZXN0IENhY2hlIHdvdWxkIGJlIHVzZWQgd2l0aG91dCBz
aWduZWQga2VybmVsIA0KPj4+Pj4gbW9kdWxlcz8gIElzIHRoZSBwZXJmb3JtYW5jZSBnYWluIHdv
cnRoIGNoYW5naW5nIGhvdyBrZXJuZWwgbW9kdWxlcyANCj4+Pj4+IGdldCBsb2FkZWQgYXQgYm9v
dD8gIENvdWxkbid0IHRoaXMgcGFydCBqdXN0IGJlIGRyb3BwZWQgZm9yIGVhc2llciBhY2NlcHRh
bmNlPyAgDQo+Pj4+PiBJbnRlZ3JpdHkgaXMgYWxyZWFkeSBtYWludGFpbmVkIHdpdGggdGhlIGN1
cnJlbnQgbW9kZWwgb2YgYXBwZW5kZWQgc2lnbmF0dXJlcy4gDQo+Pj4+IA0KPj4+PiBJIGRvbid0
IGxpa2UgbWFraW5nIGV4Y2VwdGlvbnMgaW4gdGhlIGRlc2lnbiwgYW5kIEkgcmVjZW50bHkgcmVh
bGl6ZWQNCj4+Pj4gdGhhdCBpdCBzaG91bGQgbm90IGJlIHRhc2sgb2YgdGhlIHVzZXJzIG9mIHRo
ZSBJbnRlZ3JpdHkgRGlnZXN0IENhY2hlDQo+Pj4+IHRvIGxpbWl0IHRoZW1zZWx2ZXMuDQo+Pj4g
DQo+Pj4gRm9yZ290IHRvIG1lbnRpb24gdGhhdCB5b3VyIHVzZSBjYXNlIGlzIHBvc3NpYmxlLiBU
aGUgdXNhZ2Ugb2YgdGhlDQo+Pj4gSW50ZWdyaXR5IERpZ2VzdCBDYWNoZSBtdXN0IGJlIGV4cGxp
Y2l0bHkgZW5hYmxlZCBpbiB0aGUgSU1BIHBvbGljeS4gSXQNCj4+PiB3aWxsIGJlIHVzZWQgaWYg
dGhlIG1hdGNoaW5nIHJ1bGUgaGFzICdkaWdlc3RfY2FjaGU9ZGF0YScgKGl0cyBmb3Jlc2Vlbg0K
Pj4+IHRvIGJlIHVzZWQgYWxzbyBmb3IgbWV0YWRhdGEpLg0KPj4gDQo+PiBJIHNlZSBhIGxvdCBv
ZiBiZW5lZml0IGlmIG1ldGFkYXRhIGludGVncml0eSBjb3VsZCBiZSBtYWludGFpbmVkLCBidXQg
aW4gdGhlIA0KPj4gY3VycmVudCBmb3JtIG9mIHRoaXMgc2VyaWVzLCBJIGRvbid0IHRoaW5rIHRo
YXQgaXMgcG9zc2libGUuICBUaGUgRGlnZXN0IENhY2hlIA0KPj4gZG9lc24ndCBjb250YWluIG9y
IGVuZm9yY2UgdGhlIGZpbGUgcGF0aCwgd2hpY2ggd291bGQgYmUgbmVjZXNzYXJ5IHRvIA0KPj4g
bWFpbnRhaW4gaW50ZWdyaXR5LiAgSGVyZSBpcyBhbiBleGFtcGxlIG9mIHdoeSBpdCB3b3VsZCBi
ZSBuZWVkZWQsIHNheSANCj4+IHlvdSBoYXZlIHR3byBhcHBsaWNhdGlvbnMgdGhhdCBuZWVkIGEg
Y29uZmlndXJhdGlvbiBmaWxlIHRvIHN0YXJ0LiAgVGhlIGZpcnN0IA0KPj4gYXBwbGljYXRpb24g
aGFzIGFuIGVtcHR5IGZpbGUgd2hlcmUgbm8gY29uZmlndXJhdGlvbiBvcHRpb25zIGFyZSBjdXJy
ZW50bHkgDQo+PiBkZWZpbmVkLiBOb3cgdGhlcmUgaXMgYSBoYXNoIGZvciBhbiBlbXB0eSBmaWxl
IGluIHRoZSBEaWdlc3QgQ2FjaGUuICBUaGUgDQo+PiBzZWNvbmQgYXBwbGljYXRpb24gY2FuIGJl
IHN0YXJ0ZWQgd2l0aCBhbiBlbXB0eSBjb25maWd1cmF0aW9uIGZpbGUsIGhvd2V2ZXIgDQo+PiB0
aGUgZW5kLXVzZXIgaGFzIGFkZGVkIHNvbWUgb3B0aW9ucyB0byBpdC4gIElmIHRoZSBjb25maWd1
cmF0aW9uIGZpbGUgZm9yIHRoZSANCj4+IHNlY29uZCBhcHBsaWNhdGlvbiBpcyByZXBsYWNlZCB3
aXRoIGFuIGVtcHR5IGZpbGUsIGl0IHdpbGwgbm90IGJlIGRldGVjdGVkLCANCj4+IHNpbmNlIHRo
ZSBEaWdlc3QgQ2FjaGUgd291bGQgc2VlIHRoZSBlbXB0eSBmaWxlIGhhc2ggaW4gaXRzIGNhY2hl
Lg0KPiANCj4gSSB3YXMgdGhpbmtpbmcgbW9yZSB0byBzdG9yZSBpbiB0aGUgZGlnZXN0IGNhY2hl
IGRpZ2VzdHMgb2YgbWV0YWRhdGENCj4gKGluY2x1ZGluZyBmb3IgZXhhbXBsZSB0aGUgZXhwZWN0
ZWQgU0VMaW51eCBsYWJlbCksIHRoYXQgRVZNIGNhbg0KPiBsb29rdXAuDQo+IA0KPiBJbiB0aGF0
IHdheSwgdGhlIHByb2JsZW0geW91IGZvcmVzZWUgY2Fubm90IGhhcHBlbjogaWYgeW91IHJlcGxh
Y2UgdGhlDQo+IGZpbGUgYmVsb25naW5nIHRvIGFwcDJfdCB3aXRoIHRoZSBvbmUgYmVsb25naW5n
IHRvIGFwcDFfdCwgU0VMaW51eA0KPiB3b3VsZCBkZW55IHRoZSBwZXJtaXNzaW9uIHRvIGFjY2Vz
czsgaWYgeW91IGNoYW5nZSB0aGUgU0VMaW51eCBsYWJlbCBvZg0KPiB0aGUgZmlsZSwgRVZNIHdp
bGwgZGVueSB0aGUgYWNjZXNzLg0KDQpJZiB0d28gZGlmZmVyZW50IGFwcGxpY2F0aW9ucyBoYXZl
IGNvbmZpZyBmaWxlcyBpbiAvZXRjLCB3b3VsZG4ndCBib3RoIGZpbGVzIA0KaGF2ZSB0aGUgc2Ft
ZSBTRUxpbnV4IGxhYmVsPw0KDQo+IFlvdSBjYW4gc3RpbGwgZ28gYmFjayB0byB0aGUgaW5pdGlh
bCBzdGF0ZSwgZm9yIHRoYXQgYSByb2xsYmFjaw0KPiBwcmV2ZW50aW9uIG1lY2hhbmlzbSBpcyBu
ZWVkZWQgKG1heWJlIEVWTSBjYW4gcmVtb3ZlIHRoZSBkaWdlc3Qgb2YgdGhlDQo+IGluaXRpYWwg
c3RhdGUgZnJvbSB0aGUgZGlnZXN0IGNhY2hlIHdoZW4gaXQgc2VlcyBhbiB1cGRhdGU/KS4NCj4g
DQo+IEluIGdlbmVyYWwsIHRoZSBJbnRlZ3JpdHkgRGlnZXN0IENhY2hlIHNob3VsZCBiZSBjb25z
aWRlcmVkIGFzIGFuDQo+IGFsdGVybmF0aXZlIG1lY2hhbmlzbSB0byB2YWxpZGF0ZSBpbW11dGFi
bGUgZmlsZXMsIG9yIHRoZSBpbml0aWFsIHN0YXRlDQo+IG9mIG11dGFibGUgZmlsZXMuIEZvciBt
dXRhYmxlIGZpbGVzLCBFVk0gSE1BQyB3aWxsIHByb3RlY3QgZnVydGhlcg0KPiB1cGRhdGVzLg0K
DQpJbiB0aGUgZXhhbXBsZSBhYm92ZSwgZnJvbSBhIGRpc3RybyBzdGFuZHBvaW50LCBtb3N0IGZp
bGVzIGNvbnRhaW5lZCBpbiAvZXRjIA0KYXJlIHZpZXdlZCBhcyBiZWluZyBtdXRhYmxlLiAgSG93
ZXZlciBhbiBlbmQtdXNlciB0aGF0IHdhbnRzIHRvIG1haW50YWluIA0KaW50ZWdyaXR5IG9uIHRo
ZWlyIHN5c3RlbSB3b3VsZG4ndCB2aWV3IGl0IHRoYXQgd2F5LiAgVGhleSBkb24ndCB3YW50IGNv
bmZpZyANCmNoYW5nZXMgdGhleSBoYXZlIG1hZGUgdG8gYmUgYmFja2VkIG91dC4gSW4gdGhlIGN1
cnJlbnQgZm9ybSB0aGV5IHdvdWxkIA0KdmlldyB0aGlzIHNlcmllcyBhcyBhbiBBdXRoZW50aWNp
dHkgRGlnZXN0IENhY2hlLiBJJ20ganVzdCB0cnlpbmcgdG8gc2hvdyB0aGF0IA0KdGhpcyBjb3Vs
ZCBiZSBhIGxvdCBtb3JlIHZhbHVhYmxlIHRvIHRoZSBlbmQtdXNlciBpZiBzb21lIHRoaW5ncyB3
ZXJlIGNoYW5nZWQuDQoNCg0K

