Return-Path: <linux-kselftest+bounces-22888-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA3B9E5F04
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 20:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 741791885AA0
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 19:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA2022E3E9;
	Thu,  5 Dec 2024 19:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H2o9BZV8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vWyaJwIe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C3F22D4EB;
	Thu,  5 Dec 2024 19:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733427776; cv=fail; b=YLWOYh0Q8/Q0Td3+WkhcxODlBl8oqGOGgRzZfEK1KCPQFByUx7ILi94t5239iS7o8qm4opkhYDpWlPzEQDCVbaWacoBfTMyzEq8zy7732aO/tmwgl6ZezQwJfuXJapzuoaps7dYUvP5RS4MDhZCk3sGIhZON1EQjW9sVfN3grlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733427776; c=relaxed/simple;
	bh=zEuVl6DDoYw6ACp2xQ2gAoEenmcN2qvXe//RCpWwEOY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ou9gqzJPDPJIqPdnu+dYJEPLgtjW9XdR/HbFV6XAlmBbGlyi9GZw5RDeXms/6L6AMYW/5bnqvoDAnUlliLy/N5d07PaJEMOwsRNj/NdAthP9BSUfTaD3dkAde5zWCjgn7MW+fRwx9lOFuHd2dvaXI83NHZWgFfG3FZ7KypMQC04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H2o9BZV8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vWyaJwIe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5JBrtR000837;
	Thu, 5 Dec 2024 19:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=zEuVl6DDoYw6ACp2xQ2gAoEenmcN2qvXe//RCpWwEOY=; b=
	H2o9BZV8HPhn7XCVto0hRyCrT+8Oe8OG6c3yf6tr0sqb3OoUMMCruAFjF33Z6Gp7
	e1rt40QZHCSW3OabcncuPeWHqlMxQ6+gKemiu9qGvZCw5S43lQHfdXV2B9yHnSWD
	h+kJCBX9JjTwED5Iq2h6VkQO7ZE3d4mS7Qe1NZUIPS1AHiIMtjqWH9M7LGKupBKA
	9J6Lw4V3gXoFKHsVM+XIDksK9fRMCqkMWlBoZohrv3T0h4DmoI6Vrj4SXILH6gK2
	ip0ULkFUAgFB4tkQTH8UEGamo0uuspRYE00LYldAYkT+MSSlZtGKsWOcs3WwOMbC
	RKSOTTqjcTcg8ZDiFD+xRw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437smam2n3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Dec 2024 19:42:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5JEiFx036915;
	Thu, 5 Dec 2024 19:42:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s5bw3ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Dec 2024 19:42:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYeZg53NIt/nlVgLZ34Fu6OTfQFJxfsWNkNvKx59sFo5acDjIS1GPkzi6hNbUpD6pzPAufiC8N8n6j2yVvx/xlFAyUOKBVzsGZEhQeYXUCqQTo6u3i3Upq+4QeVQLZwFNTCjZdQiAqxKZGdPUJ3fVUeXGStRUL+8DAN1c33c/r/nomMFRpg/yGfgOLAIfGOYsTu7PZTLrZOyx06TKS/FUDsyfFRTkHAi6yCrLGlbn+zkwWOA7figgOcLcnVGnLhPHSRBI9A1RaDqLOAyj3Yh5fhyyP9FLqJcFroVk8hXPfD4zTpQwZzkbxFlveibytKe4SKu8VDMWhThyOHBR/I1mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEuVl6DDoYw6ACp2xQ2gAoEenmcN2qvXe//RCpWwEOY=;
 b=SpSLpdzDL6hxs37vUVIg6iYPw99oL8HCtHALmqK9EVa7/ClryYCStUhCdh3GwDivnCbJ8z91Uh5q0/odoMXFqtAV/UxHm5s7F78cyx+EbNakSOU23drI00l63/yD+fQaFAtmtnV6e70VRQJrm8dEMX5cFpuf/N8FwEBbkvD3/Xls02FZbCKyd4C2yRZjDWEy/pyHpphDbifgNoC/t8yxgBDuR2UTnOLXFUJXfRbWkZCUlFYGxmXBKGI5kjrnh6ZRdkwmzlnPt2HdvfHHL8IN/3ZIxoSDICsjBrPYrgGC3Puo9qF9wY0ngPVBi84LlzkWKkgw126aegEGFauUkwZUIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEuVl6DDoYw6ACp2xQ2gAoEenmcN2qvXe//RCpWwEOY=;
 b=vWyaJwIewVYJUPChaIfjDymfLLvPtE6WQj/ILHnXZZHT5BFoUz89IfhjXQXlkw/lW+i/XaroNw52zTeVg/OmQdFnYcWUHgowWoqulpZsyyrrCAXwAHBNYBPUqJfvd19Ym81dZQPp/j18TbXf97aJvoriejSOJnXfFYFODkEhZuc=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by BN0PR10MB4934.namprd10.prod.outlook.com (2603:10b6:408:120::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 19:41:57 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%7]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 19:41:57 +0000
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
 AQHbOnDjfg4en7nkgkyalKK8KF8lk7LIuzaAgACvegCAC539gIAA9ZKAgADuJoCAAIUbgIAAe8GAgAA5TAA=
Date: Thu, 5 Dec 2024 19:41:57 +0000
Message-ID: <F9EE3709-2A90-4E9A-8531-44EC0F9C240C@oracle.com>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
 <C4BE31F8-1FA3-4AD1-A712-ED2AA7E61E96@oracle.com>
 <17ef4f662e594c8431a00fe423507af4f6a82286.camel@huaweicloud.com>
 <B135AC90-7CE5-4E51-90B1-9D82031668A8@oracle.com>
 <00f3eb72042aedaa4644ff0932d06d4e8d215f6b.camel@huaweicloud.com>
 <B0DC94E7-78A3-4797-B864-31DE0A2C903C@oracle.com>
 <3a759c091ac097be84b882dd992e6e216ec11723.camel@huaweicloud.com>
 <d3b1c297e860339a00d3e11d1a777362833aadad.camel@huaweicloud.com>
In-Reply-To: <d3b1c297e860339a00d3e11d1a777362833aadad.camel@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR10MB7730:EE_|BN0PR10MB4934:EE_
x-ms-office365-filtering-correlation-id: 11dbe025-8b86-4bfa-ac05-08dd1564e128
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TUtnM2I0THZ5NFQyVy9ETkMxL0c0cHVXQzVLMmxFcHd1dVVIOWdqOGJwaG9J?=
 =?utf-8?B?MGJ5ZjZKR2wzZ3FvV2pZT2d1enZ0V2J4b2dNT0plK1BKa3h2NHlpcldmMlhq?=
 =?utf-8?B?b28wendrVDFQVmxCKzBDTk14c3J3OENwbXgrc3d3QWZFODRralUzTEprdEVk?=
 =?utf-8?B?Zm8zcTIxMXM5Q2N1VjRscFJkT21iWjhIYm94OW1WREwrSThtZGNaUnFuaFFw?=
 =?utf-8?B?Qkw2WW4rakhZR24zdmhZdGJ4Q3FTWGRpcHpwTTFsVmRZMFJvMGp2NVdhdDZO?=
 =?utf-8?B?Y09EZjZ4RlVCZG5vK25EWE8vK2hXTXhnVXlRM3ozR0xvT0UvQ25jcXFhY1Rt?=
 =?utf-8?B?N0pBRzJEMXNESnpSZlV1ZHFoV05wVUlCTnlpY29TV1FpdXUxYThiUENlRWYz?=
 =?utf-8?B?d0JDTGlpNmRrNURaRlFNT09JWVJVZ1h6U0NWa2VzZ3FLSGdaRUdTRFpkVVN5?=
 =?utf-8?B?bnpiM3ZGRlJQTFpkSjlpQSt6b2FXdUxlNDBJaVdCd1Z5NUluWHUzTWpnL2xP?=
 =?utf-8?B?REVKKzlJRTlRelc3ZXQ1cTYvbVNRK2gwdTkxTk56ek40Vit6QTRvWEpndUxo?=
 =?utf-8?B?eHZLOEI3ZE1DL2lIL3JBd0JPVGpnWGppdEZzaDZjMmttRUFVc2E4ZVNOOFpV?=
 =?utf-8?B?TFBXNW9tcE0yTHl6bzBibEg2QzVVZTRkQkVJdzlUNkJXaW9FNElOVEdjZFR6?=
 =?utf-8?B?dkt1UUxVb2ExRnRyL3ZleExFSnhpOEd6emZPcHNKcUh1ME9sS0VRVjVWV2F5?=
 =?utf-8?B?QnJBOVU1ek4zUFlJZGJYODBROTNlZUh3ZHR5TVpHc0xzclRYKzNFUGVsYW5L?=
 =?utf-8?B?bkhlWTFyTjlkeWZzdnBsaFNJUk1JRHRRc2h0TE93QmR2cTk1WjZZUXBNaWVV?=
 =?utf-8?B?b0I5c2I0dnNyK1QxQStnbHFlTUpOZU0yb1BaTE9YdzNpUVZrbzkwWUppdzkv?=
 =?utf-8?B?TmFDVkh1MGcwNDBvMEp6ZG81VXVFTjUrRThjbW1UWmEzZXV0ZlpaRFFHcnc1?=
 =?utf-8?B?Nk93TzZ1TytsU2N4bXR4MGYzSk53eEVrQ0Y0S0N6eXBnYlNaVXh1ZEJ5emdh?=
 =?utf-8?B?QTQ4TXhRbnlOeHRLZWIzOUpCaTdFb2h4ek12TXNxeFhJbkFXL3g0eEJyU0tP?=
 =?utf-8?B?UW9pRmFrRUZLMXFJZUo2MVVLSXYvaXdpWEI0U0ptZ3VlMlk3Z1g3T2Q4aFJL?=
 =?utf-8?B?aUM2WlFnR1RuZTYvU05SUGIvajFrbkFDa1JuUUdmaDNzaE5CRmVmR01BSXNF?=
 =?utf-8?B?cEFOTG5JSVdjOUhiWXlqb3BiQVRoZXpWdXZjcnZITk5RSkpyTkh5MTF2Nmly?=
 =?utf-8?B?Vzl2aTBiaE9Wb1JkbkhmNHVSamFiNjlFaVo4U3VqRmhRWExZK2Q2T2hjVm5D?=
 =?utf-8?B?UzRsQ1pSOXlRR0lySUpNL1pSYzVUQTh2UFRNQjBNK3NvWTJlYUJIQ0JqeFdp?=
 =?utf-8?B?UkxkYnRZTGNEYUJoK3NVSFhVTmtzcVBVV3gvdzVPaEN6dFYxM3BmNUFORzdZ?=
 =?utf-8?B?SGJwM1hCTmJOSUNZQWtxRmh0cUtxdkNwWVpwMVlGN3Q3Y1JNSWlFazB4bWJX?=
 =?utf-8?B?RVQ5cXloNEdWdE9Fak9qdlAyMVhwZ0RkeHhIUjJ3Q1VnSjF1dHNRQUU2Qzho?=
 =?utf-8?B?SkpuaExJUVpxNjZaU0xlaEcrRytZcnVleUVLV3ErQTNGSk9qUEJ0TFFmSXFX?=
 =?utf-8?B?L3FMbTVwZ2JWc0VQNFQ3UGl3NmhwWitqVS9VMlRLSWpyUUNyc0hvenN3Y05m?=
 =?utf-8?B?Zi9iaDVKWHQ1eS9hU2RTY2RYMDVDWnFCaG02L29jSjZTNVBST3RqZGtsemJo?=
 =?utf-8?B?Ym1IaUR2L3VIYUl2dlhma0l4Z3U0bHBnaUNORThKQjdKdGZVZlFvM1hWK1gv?=
 =?utf-8?B?d0pQdzMyeTJCQ2FZWE5rbVQxYlVMOWFDcWxuZTN5ak1lRGZPbk1aZVNEWXZJ?=
 =?utf-8?Q?eewXfV46XJ0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QWZ6d0taSlBEMHFPVmlJVTZqT1kzZUZyeTdzajVzT3g4V0VxanBzWCtSSFBT?=
 =?utf-8?B?WFFKMmx4T0plak5ITDZoTmRNNjZrQmY2UTB4ZDV2Z2RrVlB0VHFkM2xLZW5Q?=
 =?utf-8?B?VkkrOU1la2FGdTVVeTVSTkZvRVhpL0wvR284ZXJ4aW96S1lwUWFIOVR1czk3?=
 =?utf-8?B?OHlwRDAyNDZDOGZBcHU2V20vK3F5RUJ0UHlJc0k2bVJtYklYRDhORDlYWnlG?=
 =?utf-8?B?eUpVTDhmc1daSUsrNS9LaHdSNVg5UkUwVzI4VWJLZ3d4TWFaZG8xOElFRGR3?=
 =?utf-8?B?d0tqZ1JhVHNobjdhQngvQkVIU3hqZTRGNzBIUmRGbndPWllUV2ZyUXd3eG9I?=
 =?utf-8?B?RkJiN3FMOU8yUGF2aCtqYldUWDVEZlRCZVlFYm0yZkVlZDdBSzdKM2puT1FK?=
 =?utf-8?B?MHN3MlJhSVFrZHcxUHlaQmQ3YWNnVXc4TUxqYjgyMHJsdGQ1a21wd2RISEJw?=
 =?utf-8?B?UkJnRURlNkxMekpWTjVhU2FDaG1jNW5lWmUxYVIvSS9FOWtaenB4UkhrRk1a?=
 =?utf-8?B?a21PbjdNT3ZIS2ZTcmRkejN5cUs4Rm5CMXloYXhHNk9EU3NmZTR6K0hKWTBt?=
 =?utf-8?B?L0lST3k1WTQ3Mzdpa29xazVyUm9zNUN0c09TaWw0S3I0SlRic1k0ckdXNnQw?=
 =?utf-8?B?K1FsNzNmb1IrbzVBQ0V4RXByQWlXUEhhalAvNXloTkJqMjYzVjk3UjB0amJz?=
 =?utf-8?B?aUVkQ0d2ak9ZM1V5REFkSWR3REFob05UdUdGcFZ6bCt1YllYZEFCTW85Uis1?=
 =?utf-8?B?L3A5U3hZMmFmRkxETGtxeHk3UjV3SVA0ejc3Qmhya3ZFOWcrUlM0T1ZRR2w0?=
 =?utf-8?B?NTlOVU1yeW5YUE5JVDB3cGozbERlSFRmVFpJVmRoTEhFTEk1dlJ6NHMwZTJ3?=
 =?utf-8?B?UFNsQmlxU0RkYlM4eXN6bWZyK0JCN0g5a0ZsYi80dEtYNGZCNHlqNExLYk1h?=
 =?utf-8?B?MlRSZDVwdGphS1BrT0NJU0FISkM5SmlIbG1pMG8vMEd6RVJ3cmxMeUNpY3Z1?=
 =?utf-8?B?WTBtYkxtYXN3aHZSVUpXOXBuVnBhZm8vVmFKY0JuWWFFaEhURk13VmgvSFhT?=
 =?utf-8?B?emxwOVdReXZyVmtHb2xkUk9qaGtwRTVmTlNwb2YvMlNkWExwRS9sbUpVNFQ0?=
 =?utf-8?B?YXBoMExsNE1wd2EzVVhSa3ZKN0NRRGlNWldOeFRCeEhXTmNKMjlma2g2aUhw?=
 =?utf-8?B?VDR6ajZ5NDhMSEMyRWF4YUtsdzhaalNhVDRQOTBVaW5ML3cybElpbDNRVUg4?=
 =?utf-8?B?Z0pUQkl2Y3RPUEZTcVJQdzJVT3VCLzhNQUhzM2dlNHFqTmFPaUNXczBFdzlU?=
 =?utf-8?B?R3ZkQjJ2Z0puTTYySWpORWZsZGxGU1NvbHBTTkl2aXJ1U3ZhUTNaZTRId1ZZ?=
 =?utf-8?B?cWFYS3l1NnE2STFpazZPK0U1YnNSZ1lkMmU2dFU2ZWM3TUtxVWJ5L0xXRDl1?=
 =?utf-8?B?Zjc0U1FPSTZSODMwOXNiYUVVai9hWi9YVGNMWXRuejdBVjRKNnBpZ1hOT25L?=
 =?utf-8?B?UHpnVDFaZkFQNHVyVWR2UlVVUWpXWXcvUE5JWjE0YlltOXNDZlZhNmliNE51?=
 =?utf-8?B?OStLaWNMelJzZ2JuUXBPK2o3UnVYUFBSY2tzdTNBTkZyam1KTHNTQVdMM041?=
 =?utf-8?B?dzlmNTZlZ0ZFQnNCWVBzUlNBVDBSTTNvTWZTMHM4djAzT0lEMWJlTTZIeGhr?=
 =?utf-8?B?RkV6aXVUcjY2c2loTzRtZ3FDVmZqYVd3TzFseEZscldZK0RtejRvVHI5bWt2?=
 =?utf-8?B?cktWMVlWa3VsMCtxZG5icWpTMk9iL2pFYlVjQ00xbFkrNlFHTEhrQlladzR3?=
 =?utf-8?B?d3Jxc2I3aHJOZyt0UkRCUW9ZWWtUb2ZhOVhId2JtUzNBbDU5T1VDRW5LcS9W?=
 =?utf-8?B?ZTQ3Sy9rY01PMHd0clhhQ05lcCt4aHJXVnZRbEV1UVorQTZVdzQ0V05penRR?=
 =?utf-8?B?SkxycU9Lc29QazY1aDYwNDR6Ly85TnppSHh0K3Q2alBzb2dJNk1rQlBTZHYz?=
 =?utf-8?B?QStqOEhrWGZISElKWmtWSnZ1bWZPQ0FldlpMS2pWUHZRT2xxSkphcnJ3ZHNw?=
 =?utf-8?B?cms3Ri9PU0kvN1NxaHRGRGZRaXM5U2VqYnhsM0hzVFMwZGRqOXNYSzc3V1dC?=
 =?utf-8?B?aVBFaU1Rdy9lK21WdnlBL0ZIeXRqcStVZVVjSXh2bkM3WkpFK01rSzh6Ykt0?=
 =?utf-8?B?b3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BEDE720BF5CD6041B007995B85CD6CB7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e57hW90cWgPo3Prk7L3iFs0AZncAHoCfNvin0v1easoTHAlRAj4PJcxh8j0kZjSzxdQrdaoV4mwq5O0RX/izopEa4c5Ihpt9fiPP7XfTJnGhyNZk+xq//RyW+hW4LrrxqCCAoPHP4rF9Q4QQoq176T2s5zy6hQTMPDcHJ7EELzKLjZYiK326Y2WK6M1JNeHk1KdLC1jGEJHFGbvQdqOq96iDNQE5NRXmNXH6pNKJGqflER5blhm7NNqFJuMUW42Ty/3j1qHtHPH6jlugTFz+PspRgw99DVSjgE+tAGyLnXLCaratnXp7Qi2VO7/AyGZ5KMq0bt083rMUp0cPYjpirDYX3fkggM3p+REoAkKflLhG3GemnkGTKGc1A0FHPBL+aIRM1T5XxkRRLH2pcfd6Ew2Mv/1Cm8d61FcnMa57qHgBzGY3axs1A0gX0n21CoOYL4RBJLYtVxRlXfzPuwUcXYZ6tISbnXfWCX9huXgM7QICNxKW748GRRg4IRMpJXVH/3rZixtPQQ7hSON8LxnvNLvOFBEPoF7NF87B5U0uaL8nmes8iUQVIhqt2632CFFH5aGaJ4ONTZ0X7F1+XsKBOxQgVZHRafFA3vVVz89BvGQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11dbe025-8b86-4bfa-ac05-08dd1564e128
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 19:41:57.4444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oMZmS7bbrM4zkrH3ZamEuKotCz+xpA8fed+NfxL0RASvxs3Hagq0nQY+1gIvqMVutT9W6Yalgx9aBInjwoxPzVKkbWEgvVcyjV7F3hm9hIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4934
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_14,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412050146
X-Proofpoint-ORIG-GUID: ipm4B_Fm65tN8vSvbg-zcb2atOeXllJ_
X-Proofpoint-GUID: ipm4B_Fm65tN8vSvbg-zcb2atOeXllJ_

DQoNCj4gT24gRGVjIDUsIDIwMjQsIGF0IDk6MTbigK9BTSwgUm9iZXJ0byBTYXNzdSA8cm9iZXJ0
by5zYXNzdUBodWF3ZWljbG91ZC5jb20+IHdyb3RlOg0KPiANCj4gT24gVGh1LCAyMDI0LTEyLTA1
IGF0IDA5OjUzICswMTAwLCBSb2JlcnRvIFNhc3N1IHdyb3RlOg0KPj4gT24gVGh1LCAyMDI0LTEy
LTA1IGF0IDAwOjU3ICswMDAwLCBFcmljIFNub3diZXJnIHdyb3RlOg0KPj4+IA0KPj4+PiBPbiBE
ZWMgNCwgMjAyNCwgYXQgMzo0NOKAr0FNLCBSb2JlcnRvIFNhc3N1IDxyb2JlcnRvLnNhc3N1QGh1
YXdlaWNsb3VkLmNvbT4gd3JvdGU6DQo+Pj4+IA0KPj4+PiBPbiBUdWUsIDIwMjQtMTItMDMgYXQg
MjA6MDYgKzAwMDAsIEVyaWMgU25vd2Jlcmcgd3JvdGU6DQo+Pj4+PiANCj4+Pj4+PiBPbiBOb3Yg
MjYsIDIwMjQsIGF0IDM6NDHigK9BTSwgUm9iZXJ0byBTYXNzdSA8cm9iZXJ0by5zYXNzdUBodWF3
ZWljbG91ZC5jb20+IHdyb3RlOg0KPj4+Pj4+IA0KPj4+Pj4+IE9uIFR1ZSwgMjAyNC0xMS0yNiBh
dCAwMDoxMyArMDAwMCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBP
biBOb3YgMTksIDIwMjQsIGF0IDM6NDnigK9BTSwgUm9iZXJ0byBTYXNzdSA8cm9iZXJ0by5zYXNz
dUBodWF3ZWljbG91ZC5jb20+IHdyb3RlOg0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBGcm9tOiBSb2Jl
cnRvIFNhc3N1IDxyb2JlcnRvLnNhc3N1QGh1YXdlaS5jb20+DQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+
IFRoZSBJbnRlZ3JpdHkgRGlnZXN0IENhY2hlIGNhbiBhbHNvIGhlbHAgSU1BIGZvciBhcHByYWlz
YWwuIElNQSBjYW4gc2ltcGx5DQo+Pj4+Pj4+PiBsb29rdXAgdGhlIGNhbGN1bGF0ZWQgZGlnZXN0
IG9mIGFuIGFjY2Vzc2VkIGZpbGUgaW4gdGhlIGxpc3Qgb2YgZGlnZXN0cw0KPj4+Pj4+Pj4gZXh0
cmFjdGVkIGZyb20gcGFja2FnZSBoZWFkZXJzLCBhZnRlciB2ZXJpZnlpbmcgdGhlIGhlYWRlciBz
aWduYXR1cmUuIEl0IGlzDQo+Pj4+Pj4+PiBzdWZmaWNpZW50IHRvIHZlcmlmeSBvbmx5IG9uZSBz
aWduYXR1cmUgZm9yIGFsbCBmaWxlcyBpbiB0aGUgcGFja2FnZSwgYXMNCj4+Pj4+Pj4+IG9wcG9z
ZWQgdG8gdmVyaWZ5aW5nIGEgc2lnbmF0dXJlIGZvciBlYWNoIGZpbGUuDQo+Pj4+Pj4+IA0KPj4+
Pj4+PiBJcyB0aGVyZSBhIHdheSB0byBtYWludGFpbiBpbnRlZ3JpdHkgb3ZlciB0aW1lPyAgVG9k
YXkgaWYgYSBDVkUgaXMgZGlzY292ZXJlZCANCj4+Pj4+Pj4gaW4gYSBzaWduZWQgcHJvZ3JhbSwg
dGhlIHByb2dyYW0gaGFzaCBjYW4gYmUgYWRkZWQgdG8gdGhlIGJsYWNrbGlzdCBrZXlyaW5nLiAN
Cj4+Pj4+Pj4gTGF0ZXIgaWYgSU1BIGFwcHJhaXNhbCBpcyB1c2VkLCB0aGUgc2lnbmF0dXJlIHZh
bGlkYXRpb24gd2lsbCBmYWlsIGp1c3QgZm9yIHRoYXQgDQo+Pj4+Pj4+IHByb2dyYW0uICBXaXRo
IHRoZSBJbnRlZ3JpdHkgRGlnZXN0IENhY2hlLCBpcyB0aGVyZSBhIHdheSB0byBkbyB0aGlzPyAg
DQo+Pj4+Pj4gDQo+Pj4+Pj4gQXMgZmFyIGFzIEkgY2FuIHNlZSwgdGhlIGltYV9jaGVja19ibGFj
a2xpc3QoKSBjYWxsIGlzIGJlZm9yZQ0KPj4+Pj4+IGltYV9hcHByYWlzZV9tZWFzdXJlbWVudCgp
LiBJZiBpdCBmYWlscywgYXBwcmFpc2FsIHdpdGggdGhlIEludGVncml0eQ0KPj4+Pj4+IERpZ2Vz
dCBDYWNoZSB3aWxsIG5vdCBiZSBkb25lLg0KPj4+Pj4gDQo+Pj4+PiANCj4+Pj4+IEl0IGlzIGdv
b2QgdGhlIHByb2dyYW0gaGFzaCB3b3VsZCBiZSBjaGVja2VkIGJlZm9yZWhhbmQgYW5kIGZhaWwg
aWYgaXQgaXMgDQo+Pj4+PiBjb250YWluZWQgb24gdGhlIGxpc3QuIA0KPj4+Pj4gDQo+Pj4+PiBU
aGUgLmltYSBrZXlyaW5nIG1heSBjb250YWluIG1hbnkga2V5cy4gIElmIG9uZSBvZiB0aGUga2V5
cyB3YXMgbGF0ZXIgDQo+Pj4+PiByZXZva2VkIGFuZCBhZGRlZCB0byB0aGUgLmJsYWNrbGlzdCwg
d291bGRuJ3QgdGhpcyBiZSBtaXNzZWQ/ICBJdCB3b3VsZCANCj4+Pj4+IGJlIGNhdWdodCBkdXJp
bmcgc2lnbmF0dXJlIHZhbGlkYXRpb24gd2hlbiB0aGUgZmlsZSBpcyBsYXRlciBhcHByYWlzZWQs
IGJ1dCANCj4+Pj4+IG5vdyB0aGlzIHN0ZXAgaXNuJ3QgdGFraW5nIHBsYWNlLiAgQ29ycmVjdD8N
Cj4+Pj4gDQo+Pj4+IEZvciBmaWxlcyBpbmNsdWRlZCBpbiB0aGUgZGlnZXN0IGxpc3RzLCB5ZXMs
IHRoZXJlIHdvbid0IGJlIGRldGVjdGlvbg0KPj4+PiBvZiBsYXRlciByZXZvY2F0aW9uIG9mIGEg
a2V5LiBIb3dldmVyLCBpdCB3aWxsIHN0aWxsIHdvcmsgYXQgcGFja2FnZQ0KPj4+PiBsZXZlbC9k
aWdlc3QgbGlzdCBsZXZlbCwgc2luY2UgdGhleSBhcmUgc3RpbGwgYXBwcmFpc2VkIHdpdGggYQ0K
Pj4+PiBzaWduYXR1cmUuDQo+Pj4+IA0KPj4+PiBXZSBjYW4gYWRkIGEgbWVjaGFuaXNtIChpZiBp
dCBkb2VzIG5vdCBhbHJlYWR5IGV4aXN0KSB0byBpbnZhbGlkYXRlIHRoZQ0KPj4+PiBpbnRlZ3Jp
dHkgc3RhdHVzIGJhc2VkIG9uIGtleSByZXZvY2F0aW9uLCB3aGljaCBjYW4gYmUgcHJvcGFnYXRl
ZCB0bw0KPj4+PiBmaWxlcyB2ZXJpZmllZCB3aXRoIHRoZSBhZmZlY3RlZCBkaWdlc3QgbGlzdHMu
DQo+Pj4+IA0KPj4+Pj4gV2l0aCBJTUEgYXBwcmFpc2FsLCBpdCBpcyBlYXN5IHRvIG1haW50YWlu
IGF1dGhlbnRpY2l0eSBidXQgY2hhbGxlbmdpbmcgdG8gDQo+Pj4+PiBtYWludGFpbiBpbnRlZ3Jp
dHkgb3ZlciB0aW1lLiBJbiB1c2VyLXNwYWNlIHRoZXJlIGFyZSBjb25zdGFudGx5IG5ldyBDVkVz
LiAgDQo+Pj4+PiBUbyBtYWludGFpbiBpbnRlZ3JpdHkgb3ZlciB0aW1lLCBlaXRoZXIga2V5cyBu
ZWVkIHRvIGJlIHJvdGF0ZWQgaW4gdGhlIC5pbWEgDQo+Pj4+PiBrZXlyaW5nIG9yIHByb2dyYW0g
aGFzaGVzIG5lZWQgdG8gYmUgZnJlcXVlbnRseSBhZGRlZCB0byB0aGUgLmJsYWNrbGlzdC4gICAN
Cj4+Pj4+IElmIG5laXRoZXIgaXMgZG9uZSwgZm9yIGFuIGVuZC11c2VyIG9uIGEgZGlzdHJvLCBJ
TUEtYXBwcmFpc2FsIGJhc2ljYWxseSANCj4+Pj4+IGd1YXJhbnRlZXMgYXV0aGVudGljaXR5Lg0K
Pj4+Pj4gDQo+Pj4+PiBXaGlsZSBJIHVuZGVyc3RhbmQgdGhlIGludGVudCBvZiB0aGUgc2VyaWVz
IGlzIHRvIGluY3JlYXNlIHBlcmZvcm1hbmNlLCANCj4+Pj4+IGhhdmUgeW91IGNvbnNpZGVyZWQg
dXNpbmcgdGhpcyB0byBnaXZlIHRoZSBlbmQtdXNlciB0aGUgYWJpbGl0eSB0byBtYWludGFpbiAN
Cj4+Pj4+IGludGVncml0eSBvZiB0aGVpciBzeXN0ZW0/ICBXaGF0IEkgbWVhbiBpcywgaW5zdGVh
ZCBvZiB0cnlpbmcgdG8gaW1wb3J0IGFueXRoaW5nIA0KPj4+Pj4gZnJvbSBhbiBSUE0sIGp1c3Qg
aGF2ZSB0aGUgZW5kLXVzZXIgcHJvdmlkZSB0aGlzIGluZm9ybWF0aW9uIGluIHNvbWUgZm9ybWF0
IA0KPj4+Pj4gdG8gdGhlIERpZ2VzdCBDYWNoZS4gIFVzZXItc3BhY2UgdG9vbHMgY291bGQgYmUg
YnVpbHQgdG8gY29sbGVjdCBhbmQgZm9ybWF0IA0KPj4+PiANCj4+Pj4gVGhpcyBpcyBhbHJlYWR5
IHBvc3NpYmxlLCBkaWdlc3QtY2FjaGUtdG9vbHMNCj4+Pj4gKGh0dHBzOi8vZ2l0aHViLmNvbS9s
aW51eC1pbnRlZ3JpdHkvZGlnZXN0LWNhY2hlLXRvb2xzKSBhbHJlYWR5IGFsbG93DQo+Pj4+IHRv
IGNyZWF0ZSBhIGRpZ2VzdCBsaXN0IHdpdGggdGhlIGZpbGUgYSB1c2VyIHdhbnRzLg0KPj4+PiAN
Cj4+Pj4gQnV0IGluIHRoaXMgY2FzZSwgdGhlIHVzZXIgaXMgdm91Y2hpbmcgZm9yIGhhdmluZyB0
YWtlbiB0aGUgY29ycmVjdA0KPj4+PiBtZWFzdXJlIG9mIHRoZSBmaWxlIGF0IHRoZSB0aW1lIGl0
IHdhcyBhZGRlZCB0byB0aGUgZGlnZXN0IGxpc3QuIFRoaXMNCj4+Pj4gd291bGQgYmUgaW5zdGVh
ZCBhdXRvbWF0aWNhbGx5IGd1YXJhbnRlZWQgYnkgUlBNcyBvciBvdGhlciBwYWNrYWdlcw0KPj4+
PiBzaGlwcGVkIHdpdGggTGludXggZGlzdHJpYnV0aW9ucy4NCj4+Pj4gDQo+Pj4+IFRvIG1pdGln
YXRlIHRoZSBjb25jZXJucyBvZiBDVkVzLCB3ZSBjYW4gcHJvYmFibHkgaW1wbGVtZW50IGEgcm9s
bGJhY2sNCj4+Pj4gcHJldmVudGlvbiBtZWNoYW5pc20sIHdoaWNoIHdvdWxkIG5vdCBhbGxvdyB0
byBsb2FkIGEgcHJldmlvdXMgdmVyc2lvbg0KPj4+PiBvZiBhIGRpZ2VzdCBsaXN0Lg0KPj4+IA0K
Pj4+IElNSE8sIHB1cnN1aW5nIHRoaXMgd2l0aCB0aGUgZW5kLXVzZXIgYmVpbmcgaW4gY29udHJv
bCBvZiB3aGF0IGlzIGNvbnRhaW5lZCANCj4+PiB3aXRoaW4gdGhlIERpZ2VzdCBDYWNoZSB2cyB3
aGF0IGlzIGNvbnRhaW5lZCBpbiBhIGRpc3RybyB3b3VsZCBwcm92aWRlIG1vcmUNCj4+PiB2YWx1
ZS4gQWxsb3dpbmcgdGhlIGVuZC11c2VyIHRvIGVhc2lseSB1cGRhdGUgdGhlaXIgRGlnZXN0IENh
Y2hlIGluIHNvbWUgd2F5IA0KPj4+IHdpdGhvdXQgaGF2aW5nIHRvIGRvIGFueSB0eXBlIG9mIHJl
dm9jYXRpb24gZm9yIGJvdGggb2xkIGFuZCB2dWxuZXJhYmxlIA0KPj4+IGFwcGxpY2F0aW9ucyB3
aXRoIENWRXMgd291bGQgYmUgdmVyeSBiZW5lZmljaWFsLg0KPj4gDQo+PiBZZXMsIGRlbGV0aW5n
IHRoZSBkaWdlc3QgbGlzdCB3b3VsZCBpbnZhbGlkYXRlIGFueSBpbnRlZ3JpdHkgcmVzdWx0DQo+
PiBkb25lIHdpdGggdGhhdCBkaWdlc3QgbGlzdC4NCj4+IA0KPj4gSSBkZXZlbG9wZWQgYWxzbyBh
biBycG0gcGx1Z2luIHRoYXQgc3luY2hyb25pemVzIHRoZSBkaWdlc3QgbGlzdHMgd2l0aA0KPj4g
aW5zdGFsbGVkIHNvZnR3YXJlLiBPbGQgdnVsbmVyYWJsZSBzb2Z0d2FyZSBjYW5ub3QgYmUgdmVy
aWZpZWQgYW55bW9yZQ0KPj4gd2l0aCB0aGUgSW50ZWdyaXR5IERpZ2VzdCBDYWNoZSwgc2luY2Ug
dGhlIHJwbSBwbHVnaW4gZGVsZXRlcyB0aGUgb2xkDQo+PiBzb2Z0d2FyZSBkaWdlc3QgbGlzdHMu
DQo+PiANCj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC1pbnRlZ3JpdHkvZGlnZXN0LWNhY2hl
LXRvb2xzL2Jsb2IvbWFpbi9ycG0tcGx1Z2luL2RpZ2VzdF9jYWNoZS5jDQo+PiANCj4+IFRoZSBn
b29kIHRoaW5nIGlzIHRoYXQgdGhlIEludGVncml0eSBEaWdlc3QgQ2FjaGUgY2FuIGJlIGVhc2ls
eQ0KPj4gY29udHJvbGxlZCB3aXRoIGZpbGVzeXN0ZW0gb3BlcmF0aW9ucyAoaXQgd29ya3Mgc2lt
aWxhcmx5IHRvIHNlY3VyaXR5DQo+PiBibG9icyBhdHRhY2hlZCB0byBrZXJuZWwgb2JqZWN0cywg
bGlrZSBpbm9kZXMgYW5kIGZpbGUgZGVzY3JpcHRvcnMpLg0KPj4gDQo+PiBBcyBzb29uIGFzIHNv
bWV0aGluZyBjaGFuZ2VzIChlLmcuIGRpZ2VzdCBsaXN0IHdyaXR0ZW4sIGxpbmsgdG8gdGhlDQo+
PiBkaWdlc3QgbGlzdHMpLCB0aGlzIHRyaWdnZXJzIGEgcmVzZXQgaW4gdGhlIEludGVncml0eSBE
aWdlc3QgQ2FjaGUsIHNvDQo+PiBkaWdlc3QgbGlzdHMgYW5kIGZpbGVzIG5lZWQgdG8gYmUgdmVy
aWZpZWQgYWdhaW4uIERlbGV0aW5nIHRoZSBkaWdlc3QNCj4+IGxpc3QgY2F1c2VzIHRoZSBpbi1r
ZXJuZWwgZGlnZXN0IGNhY2hlIHRvIGJlIHdpcGVkIGF3YXkgdG9vICh3aGVuIHRoZQ0KPj4gcmVm
ZXJlbmNlIGNvdW50IHJlYWNoZXMgemVybykuDQo+PiANCj4+PiBJcyB0aGVyZSBhIGJlbGllZiB0
aGUgRGlnZXN0IENhY2hlIHdvdWxkIGJlIHVzZWQgd2l0aG91dCBzaWduZWQga2VybmVsIA0KPj4+
IG1vZHVsZXM/ICBJcyB0aGUgcGVyZm9ybWFuY2UgZ2FpbiB3b3J0aCBjaGFuZ2luZyBob3cga2Vy
bmVsIG1vZHVsZXMgDQo+Pj4gZ2V0IGxvYWRlZCBhdCBib290PyAgQ291bGRuJ3QgdGhpcyBwYXJ0
IGp1c3QgYmUgZHJvcHBlZCBmb3IgZWFzaWVyIGFjY2VwdGFuY2U/ICANCj4+PiBJbnRlZ3JpdHkg
aXMgYWxyZWFkeSBtYWludGFpbmVkIHdpdGggdGhlIGN1cnJlbnQgbW9kZWwgb2YgYXBwZW5kZWQg
c2lnbmF0dXJlcy4gDQo+PiANCj4+IEkgZG9uJ3QgbGlrZSBtYWtpbmcgZXhjZXB0aW9ucyBpbiB0
aGUgZGVzaWduLCBhbmQgSSByZWNlbnRseSByZWFsaXplZA0KPj4gdGhhdCBpdCBzaG91bGQgbm90
IGJlIHRhc2sgb2YgdGhlIHVzZXJzIG9mIHRoZSBJbnRlZ3JpdHkgRGlnZXN0IENhY2hlDQo+PiB0
byBsaW1pdCB0aGVtc2VsdmVzLg0KPiANCj4gRm9yZ290IHRvIG1lbnRpb24gdGhhdCB5b3VyIHVz
ZSBjYXNlIGlzIHBvc3NpYmxlLiBUaGUgdXNhZ2Ugb2YgdGhlDQo+IEludGVncml0eSBEaWdlc3Qg
Q2FjaGUgbXVzdCBiZSBleHBsaWNpdGx5IGVuYWJsZWQgaW4gdGhlIElNQSBwb2xpY3kuIEl0DQo+
IHdpbGwgYmUgdXNlZCBpZiB0aGUgbWF0Y2hpbmcgcnVsZSBoYXMgJ2RpZ2VzdF9jYWNoZT1kYXRh
JyAoaXRzIGZvcmVzZWVuDQo+IHRvIGJlIHVzZWQgYWxzbyBmb3IgbWV0YWRhdGEpLg0KDQpJIHNl
ZSBhIGxvdCBvZiBiZW5lZml0IGlmIG1ldGFkYXRhIGludGVncml0eSBjb3VsZCBiZSBtYWludGFp
bmVkLCBidXQgaW4gdGhlIA0KY3VycmVudCBmb3JtIG9mIHRoaXMgc2VyaWVzLCBJIGRvbid0IHRo
aW5rIHRoYXQgaXMgcG9zc2libGUuICBUaGUgRGlnZXN0IENhY2hlIA0KZG9lc24ndCBjb250YWlu
IG9yIGVuZm9yY2UgdGhlIGZpbGUgcGF0aCwgd2hpY2ggd291bGQgYmUgbmVjZXNzYXJ5IHRvIA0K
bWFpbnRhaW4gaW50ZWdyaXR5LiAgSGVyZSBpcyBhbiBleGFtcGxlIG9mIHdoeSBpdCB3b3VsZCBi
ZSBuZWVkZWQsIHNheSANCnlvdSBoYXZlIHR3byBhcHBsaWNhdGlvbnMgdGhhdCBuZWVkIGEgY29u
ZmlndXJhdGlvbiBmaWxlIHRvIHN0YXJ0LiAgVGhlIGZpcnN0IA0KYXBwbGljYXRpb24gaGFzIGFu
IGVtcHR5IGZpbGUgd2hlcmUgbm8gY29uZmlndXJhdGlvbiBvcHRpb25zIGFyZSBjdXJyZW50bHkg
DQpkZWZpbmVkLiBOb3cgdGhlcmUgaXMgYSBoYXNoIGZvciBhbiBlbXB0eSBmaWxlIGluIHRoZSBE
aWdlc3QgQ2FjaGUuICBUaGUgDQpzZWNvbmQgYXBwbGljYXRpb24gY2FuIGJlIHN0YXJ0ZWQgd2l0
aCBhbiBlbXB0eSBjb25maWd1cmF0aW9uIGZpbGUsIGhvd2V2ZXIgDQp0aGUgZW5kLXVzZXIgaGFz
IGFkZGVkIHNvbWUgb3B0aW9ucyB0byBpdC4gIElmIHRoZSBjb25maWd1cmF0aW9uIGZpbGUgZm9y
IHRoZSANCnNlY29uZCBhcHBsaWNhdGlvbiBpcyByZXBsYWNlZCB3aXRoIGFuIGVtcHR5IGZpbGUs
IGl0IHdpbGwgbm90IGJlIGRldGVjdGVkLCANCnNpbmNlIHRoZSBEaWdlc3QgQ2FjaGUgd291bGQg
c2VlIHRoZSBlbXB0eSBmaWxlIGhhc2ggaW4gaXRzIGNhY2hlLg0KDQo+IEZvciBrZXJuZWwgbW9k
dWxlcywgaXQgaXMgc3VmZmljaWVudCB0byBub3QgcHJvdmlkZSB0aGF0IGtleXdvcmQgZm9yDQo+
IHRoZSBNT0RVTEVfQ0hFQ0sgaG9vay4NCj4gDQo+IEhvd2V2ZXIsIHRoZXJlIGlzIHRoZSBwb3Nz
aWJpbGl0eSB0aGF0IHlvdSBsb3NlIGFub3RoZXIgYWR2YW50YWdlIG9mDQo+IHRoZSBJbnRlZ3Jp
dHkgRGlnZXN0IENhY2hlLCB0aGUgcHJlZGljdGFiaWxpdHkgb2YgdGhlIElNQSBQQ1IuIEJ5IG5v
dA0KPiB1c2luZyBkaWdlc3QgY2FjaGVzLCB0aGVyZSBpcyB0aGUgcmlzayB0aGF0IHRoZSBJTUEg
UENSIHdpbGwgYmUNCj4gdW5zdGFibGUsIGR1ZSB0byBsb2FkaW5nIGtlcm5lbCBtb2R1bGVzIGlu
IGEgZGlmZmVyZW50IG9yZGVyIGF0IGVhY2gNCj4gYm9vdC4NCg0KVW5kZXJzdG9vZCwgbXkgcmVj
b21tZW5kYXRpb24gd2FzIGJhc2VkIG9uIHRyeWluZyB0byBuYXJyb3cgdGhlIHNlcmllcyANCnRv
IGhlbHAgdHJ5IHRvIGdldCBzb21ldGhpbmcgbGlrZSB0aGlzIGFkb3B0ZWQgcXVpY2tlci4NCg0K

