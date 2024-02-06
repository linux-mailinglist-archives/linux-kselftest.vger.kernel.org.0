Return-Path: <linux-kselftest+bounces-4202-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3980D84BCC6
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 19:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B8CCB23CC3
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 18:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049BA11702;
	Tue,  6 Feb 2024 18:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="ZWr3GurS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B48012B71;
	Tue,  6 Feb 2024 18:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707243347; cv=fail; b=uhGGr/ZsZbB0oHGTM50Yd6Y+/5alaQoXgEZtH0qxohocawujYbBNGqeMb6ykKVeM8oofPMFZLdYZhwH+fz2B/GRnOvCaL8kBsuFDmPOU3KP/rJ0mkqa8/IAuPDH4iMa6PB0lQWo5yMZDjx3fjGzXeJaLBiMaPsBzFABhO/cmmNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707243347; c=relaxed/simple;
	bh=JNxu2OqVOastr/0AodZeX9XwO14c74oIHZ9dj4EgBdQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=BJeLNmbBM+0PGNOLp05NXAXhfbcZ7AoiDmPg44EaDlv07QeKq7KvAo6cLaIuFUHUqx1swpemznv2PW3DUPFF3uL8MhjFhuS1eBMIg35lZ2Pwj3rG7Pq1okeIl5NfUvb4TmrA7XLATzFJDFa5hayJSgwnNn8VN/rV5aIcR8dKg5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=ZWr3GurS; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 416HDY3J029914;
	Tue, 6 Feb 2024 18:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=S1;
 bh=JNxu2OqVOastr/0AodZeX9XwO14c74oIHZ9dj4EgBdQ=;
 b=ZWr3GurSaS0J/76WMP/T2d5RzqergyyGGQZrknqZGJqAoF+HTMypxpM9kT+tndsOKeRj
 9J6utL/0RimvNlwyA1cegoImqEG75rYcxeVFPug/1j0Ye4NPsRAEf8WgADTjlSZtX9mw
 91UO4RsZ7AvWSYLay5A0zpIcVjd7ND3yCQBSTZmNrDa0y2AmktUPo4bVv/7kp65cHleH
 Snr9+4J3sF6fXvpq9n8idIqmlbVS2HLbR5cW2nG1TXoUNsz1qAvwfU8maFhWF2zqE+w9
 /aMzDUIILYGCj9GsHlQfkR8EAhTbD020C4d3cnzXOPHt7be4+/nQtQ7Q8x1k+3hkpqks Yg== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3w1c97ba6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 18:15:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCGUfzH+WIEtI2loUuICO04VYUsQJc7CoaZ1oltYu2KN4gwpP9Y9RQR6H9QaMrBy+Ai/fcFEIL442l0O86hB/irieLn5BKuTshitIAdpav5tIMjZ9aYV4T13rHa20KZ2dlc8+8J6ul/LSEaO5TrxHE4Hkd4ZZAAERnp5IEZB3uhd4B7eGvUVfJPq64t9sv+8tAkblHANvp9Y3QZb+42RPh7Om+YP+3JfB3cfMivcL0AYUfMlqYsY1y8BTefFV8dihR3wTEdQZL6jnTD6E/ziqhD0o97rCmFRS8Hjzo/+6QzTwNyyGRScm6eXpHM679e/NSrk8L1rlJeAElTwnnJPCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNxu2OqVOastr/0AodZeX9XwO14c74oIHZ9dj4EgBdQ=;
 b=InTJMK6tPup/uHGbNxms6rLB0fXNmUjsBKNobFFQdtDAUuG20TsK9TD3W456AdUzS8uaERd2ca+DqQEysOuuFR+U2waBUyDZJ+kLa/DGyDDv/P5EM5dlcwUVOcwn0fLD/fPsD2SFsAoqRVHW2FCdFluCdEQiEALKkuvaRz3Y04+xe2Gx0/xV/F3+EIuMOADgc7JVeSd4mYeSMw4cq8m5bvdTDEKghByEOEu1Cd8sdMEkVaKxuXU1CPDx1fuoD7DOvFKvWgvDDIOlVRe6Wbyr45Jk/MnMWOZtCEPO7o5lqLI96OfzMzYCx1fXyrhHgchtRN0zeCG/LVGTDw5UPkaCyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from SA3PR13MB6372.namprd13.prod.outlook.com (2603:10b6:806:37d::13)
 by CO3PR13MB5797.namprd13.prod.outlook.com (2603:10b6:303:17e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 18:15:02 +0000
Received: from SA3PR13MB6372.namprd13.prod.outlook.com
 ([fe80::8c8a:cf2f:25e9:909b]) by SA3PR13MB6372.namprd13.prod.outlook.com
 ([fe80::8c8a:cf2f:25e9:909b%7]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 18:15:02 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: Rae Moar <rmoar@google.com>, Kees Cook <kees@kernel.org>
CC: "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "davidgow@google.com"
	<davidgow@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "brendanhiggins@google.com"
	<brendanhiggins@google.com>,
        "dlatypov@google.com" <dlatypov@google.com>,
        "tytso@google.com" <tytso@google.com>,
        "gustavo.padovan@collabora.com"
	<gustavo.padovan@collabora.com>,
        "ricardo.canuelo@collabora.com"
	<ricardo.canuelo@collabora.com>,
        "guillaume.tucker@collabora.com"
	<guillaume.tucker@collabora.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "kernelci@lists.linux.dev" <kernelci@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [KTAP V2 PATCH v2] ktap_v2: add test metadata
Thread-Topic: [KTAP V2 PATCH v2] ktap_v2: add test metadata
Thread-Index: AQHaV2qZUizaEXTiD0W5Zadi9PydxbD8tuAAgADqpYA=
Date: Tue, 6 Feb 2024 18:15:02 +0000
Message-ID: 
 <SA3PR13MB6372535451AF4CA69B4C00D7FD462@SA3PR13MB6372.namprd13.prod.outlook.com>
References: <20240126221426.4173112-1-rmoar@google.com>
 <6CCB5F6D-EC6C-452A-9D25-0D7B3F9739AB@kernel.org>
 <CA+GJov5nCLjD1iTUGxQOPMCXjBCci8-VbUje46Qd66szJgGtxQ@mail.gmail.com>
In-Reply-To: 
 <CA+GJov5nCLjD1iTUGxQOPMCXjBCci8-VbUje46Qd66szJgGtxQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR13MB6372:EE_|CO3PR13MB5797:EE_
x-ms-office365-filtering-correlation-id: 9e32c3a1-8238-468f-360c-08dc273f895d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 kLzM2UMXzDbWIz+ddjNZhsJBnUUWZGhB456WuGVQVk8PanbxNRfkoYO+UBSblaCYZHVTMT+CSwWDJDO4enTAiMWLU8kQx2FCtaTtC0/aiU/kq08dBIp+SrGNw35OW/AZ2WFzajWXV3LXw1d64CMSbYvNA1bx0pi+X2Ifop7dPaiIih3Dw6kXnVQn4R0hilvcGfJUUf33XDBCJNsoTvjXBBQwq8EA0oKkEu9UVqKkzLvH26fwhv+7ZJz4FUVxTqRHFQMWGGk1roI8kQWJ8ogTwsr81XxNa+7UTlH8fo86fTUry1iwU56I1QR1jIjmHrbpMVVTblkUH0XtvQufU35MmglMOBJirMx13xA2AmGAPgsE1h3aoy0NlJcZRBLS0UjVBV+xBAIrT+XclC6d7sR/Tyj58ZOjdkQBoAGiLKLmhVLKBhPUzhoYIcEDHvtJV4T13IPqFDjxVwbjGptfl4DrUFf9chRCG/aIds6MkUa2E/Foj29KIAaJkb+HD9MiI1ErvuR57qF9kBs0xKM51EUGXBwr/Op+9cDN7jnWbfHkzWuLKt2vopk66t3KDnefY4n6/rDf74YgD5m160Jt1VDRy1MXBtrWVk/dD70dyIQLy/jejT5XokSYX3hVgcThbPKk
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR13MB6372.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(41300700001)(66446008)(66476007)(66946007)(66556008)(54906003)(64756008)(76116006)(110136005)(53546011)(33656002)(8936002)(71200400001)(8676002)(478600001)(9686003)(6506007)(4326008)(316002)(7696005)(38070700009)(122000001)(82960400001)(38100700002)(86362001)(83380400001)(26005)(5660300002)(7416002)(52536014)(2906002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OFVVc2FzeW1SeS9STnlTOVFERHlwN1dyYTVCSjFKSmt2OUpTYVltR1pxelgy?=
 =?utf-8?B?SzVIdGNFdG5XQWx4SGtVM1I5SHY5b2YrYkpBb0xaTzFkRWJ3UjVTSzFvbDRm?=
 =?utf-8?B?Q09FTUZPR2xFMmVNcVBFelR3Ry9veXJXOTBvODkzdHc0UWRjZ3pVSEJXd3lD?=
 =?utf-8?B?N2FxdzhEUmpoTnBHazdDSjFOSVd6S2dXR1VCTmc2VlFaVHZsMHNMYkljcEIr?=
 =?utf-8?B?cFNWTzFQWTVhQXgrSWxWOS9CVHdLLzZGMmFsT3RaLytNRkZRSXI4R1ozMFQ5?=
 =?utf-8?B?WTNrKzgzYnZVVHZnU1NvcGR0NDg5R2xNdVZycGdZSXVJL3UyVytkVkxISnJn?=
 =?utf-8?B?T0pScGNyVGR4anpZWlhmZXpvYVVaOUh4cThhVUJyNGlKdDI3QmdFa21CaEF1?=
 =?utf-8?B?NkFyRlhkOWZCVGdwMUR6RHljcDRkeEJOamR3ZHM4U0dnZHhXdFZFVWUxNTRp?=
 =?utf-8?B?V3Z6bGZVQ2VhNWxqdk9IMFBIREpVUkozOS9mS1FReGEvc3J4Y0VlSUo1RGZv?=
 =?utf-8?B?clNKSjg3dVBMSzErRHdoU1QyM2JLTmloWGFsSVdKOXhZYmZ1WDZLVTNIQ2Fn?=
 =?utf-8?B?dkFkdmNLMGhXeFhkV3BUa1g3eWNwU3dTc2p4M0pQU3pmY0U1NTFQTXRabXph?=
 =?utf-8?B?NEhsZS9Eai82L01oeGVkUisvc1V1N2ZodGdjdzFZSkErUkJmeURBVDFBZmxl?=
 =?utf-8?B?dGs2RDMxNUZ6TUVsUjBydEFTcHhlSlhFWWsydlAwMFFDSE5uTW12YnVabWpW?=
 =?utf-8?B?VW9pRzFjTGF2TFhuMmROTXJUcUxTd0hrWkptOW5nUk1ENms4ejFON0ptVktU?=
 =?utf-8?B?K3ppOUZqMGdGT2NNanE4WGNiZXhFWVYvMDFxVFE4bmJJNWs5TUduR3hqdzBq?=
 =?utf-8?B?UGRweHJNdmtQdi9jLzNWZlN3Q1E3VWl2YjFEL00vWitBR1hzczk3VXVEN3Vz?=
 =?utf-8?B?Vkh0VTFSQVVHRGQ0aU00UTZqeWF4Z0dzYUl6MWI5bnBIb3hCbHQ3ektCTGl1?=
 =?utf-8?B?Y2VwaWJ5d3FYOG5OS29nWFRXemVnUGhjVFY4QjZKNG1wbWZxUUd2Yjkxb0g5?=
 =?utf-8?B?UUlVRUQ5QWN6T0ViMXZsbTI1dlJmd0ZlcUpibTZab1ZpUWl1cG5NVHFicDFs?=
 =?utf-8?B?VVRpUC91bDZJblJWZGNkQ2NmQjYvd0ZJVG1iRjhpWEFmbEpWcGhIa2RBOG1y?=
 =?utf-8?B?VGdxSTZ1clVpYVF1ellra2h3L0VYdDNnYTRwT3ZkUCtUemRGUHNyUmRIMjF2?=
 =?utf-8?B?ZTZsMWVPbjlZQktNWFB1elcrb0h0c2hFL3NPdWlwZUlmb3RhSEoyTGNQUDk3?=
 =?utf-8?B?cCtrWVNnZUF0NEgvNlMwUzdJRTRpb3RKUy9FcFFjb0VpbXZ4SHV4MkVwZmV2?=
 =?utf-8?B?bEE3SnJtU1U4dlozSEo0c0c0SU1VMzlqenFySXhjL3pkVU5pQXB3cU5DVThN?=
 =?utf-8?B?cm9ic0hUTmJyYXB5cmFBdmhnbHpsUUVYQkFXTE1Sdjg2QjB0ZUdqN01ZYnBn?=
 =?utf-8?B?a1I1Y3N0QVV3L1VwekFpTGlhQ2tndTQ4elkvMnBYZmgva2lGcXRaMEdNK1dh?=
 =?utf-8?B?NVVHeEpiaE5PQkFxbXJXcTlzY05YTlJVRVA3V3NtTkZhUmRYS1JTQVhBOTdV?=
 =?utf-8?B?OEJDejlCNzFIVnZveHpXZnlJMGdXd2dqMGpDckRPa25ZZzJBRzlJeXlVdHhV?=
 =?utf-8?B?R2FlNFRXRWZNb1owU2UrYS9FQk9XWWY3NXVDK0Zwc3lhNGJLcHJTUnpEZ0NS?=
 =?utf-8?B?S0ptUzdybGlUMkxVRWc1WjRjb1duTWRLZU1hcnRmYnJXOFl5UDNINVZ4djRR?=
 =?utf-8?B?eVhNbTJvR1U4bWd5ZnN1MXk1MExSNVlIVWdaNjBhWWc1VUVLaDc3UDMyMVRZ?=
 =?utf-8?B?QnVRekRCcE0ySW9KUVJXZlM3NWM3VzIwOWdMZjlJamJlSUJhNEU1ellwU1Q2?=
 =?utf-8?B?QkVTL3hIZ1VOanQ2L2lsY1pGWDlhb0h4NGJ2L2Q4enlyVkF3RWZ5eVJFcG1n?=
 =?utf-8?B?djBMd1BSRGtrUHBCMnhEbTc5K3BRSi94OWFtTlpXYXFGN250Y2ZPN2tyTFZn?=
 =?utf-8?B?Rlc2aWlESng0UWNMejlYOG1PWnQ0d2hPU1U5dDJtbWk0NjJRZ3NLNmhGdVQz?=
 =?utf-8?Q?LvRo=3D?=
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	HwdB6n5mQ+SIxmtFbEcpyilcNd50Z0lkqINWJeyVIO1LgPWhTBRe4McTYPSn8S2V6MMCtJo/ji5bNPj6NRb1LhWNbDetx1diYnebIp1d0Ex9xRB3mbhxc8tJmHfRXwBBhWvPNW+WI+clEZoZeovAcNZi4i0bBh42gPD7ctCYJALg8Udw08SxwW5Fmwbj09A4DLLWwrcAR7mzkX0TwXyoHlwRqwlgVSSf+x0U3Dz6Qo/pOKtr6+GfOd2AznzIZ/22SF3Cc6DXxPRPZxkaJ1rspmhBr90QPvK1oLMqxFeSKK6/5t7t/ro/d9TnoKS0us4AESm1GBw1cP1K6QQbJLEeR87JCOOLr5pAfsd6zUPhwQoA9jHamb58/JrhzddwfQFCdRla+IJNK3tioST382GE+zSAW5y1BZ7v62tK5uc8BEY1JTHoLyBWJpn7tYVh+AxxWvz1ZrVArQ3bp+DnsG65xVV4ItNpWYuJAwIf2FMZMI2nR7vnoEIwn9XB7ZmT5quLK+f/XNHw0MOqpX2YasGQ3pt85xTn/ANJBYzfffSl4r53SxMtD3lWF1Q3JPzDMfPil1BcCKfWZmBxonP4AkVsomcw3RKzEiuSmGqqpiHTHxN7+4Sb/UojssAyvT4qAVOc
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR13MB6372.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e32c3a1-8238-468f-360c-08dc273f895d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 18:15:02.0652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NWdfrXucQBCJOaXIm4yE/ogQjBJ2I6u2mE4qb11xyYa7FJf5l5+2rXHrUkjjZTcQTmIa6Vwj9tRrkbIEbuZR6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR13MB5797
X-Proofpoint-ORIG-GUID: ZNpdEMJlHHs2sarVY8suarmDLVhY0zNz
X-Proofpoint-GUID: ZNpdEMJlHHs2sarVY8suarmDLVhY0zNz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: ZNpdEMJlHHs2sarVY8suarmDLVhY0zNz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_11,2024-01-31_01,2023-05-22_02

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYWUgTW9hciA8cm1vYXJAZ29v
Z2xlLmNvbT4NCj4gT24gU3VuLCBGZWIgNCwgMjAyNCBhdCA4OjAz4oCvQU0gS2VlcyBDb29rIDxr
ZWVzQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gT24gSmFudWFyeSAyNiwgMjAyNCAxMTox
NDoyNiBQTSBHTVQrMDE6MDAsIFJhZSBNb2FyIDxybW9hckBnb29nbGUuY29tPiB3cm90ZToNCj4g
PiA+IEtUQVAgdmVyc2lvbiAyDQo+ID4gPiAjIGt0YXBfdGVzdDogbWFpbg0KPiA+ID4gIyBrdGFw
X2FyY2g6IHVtbA0KPiA+ID4gMS4uMQ0KPiA+ID4gICAgIEtUQVAgdmVyc2lvbiAyDQo+ID4gPiAg
ICAgIyBrdGFwX3Rlc3Q6IHN1aXRlXzENCj4gPiA+ICAgICAjIGt0YXBfc3Vic3lzdGVtOiBleGFt
cGxlDQo+ID4gPiAgICAgIyBrdGFwX3Rlc3RfZmlsZTogbGliL3Rlc3QuYw0KPiA+DQo+ID4gSSB0
aGluayBpdCdzIGEgbWlzdGFrZSB0byBtaXggImRpYWdub3N0aWNzIiBsaW5lcyB3aXRoIHNlbWFu
dGljIGxpbmVzLiBTaW5jZSB0aGUgZGlhZ25vc3RpYyBwcmVmaXggaXMgWyMgXSAoaGFzaCBzcGFj
ZSkgaG93IGFib3V0IG1ha2UgdGhlIHRlc3QNCj4gbWV0YWRhdGEgbGluZXMgYmUgWyM6XSAoaGFz
aCBjb2xvbikuIEZvciBleGFtcGxlOg0KPiA+DQo+ID4NCj4gPiAgICAgIDEuLjINCj4gPiAgICAg
IG9rIDEgdGVzdF8xDQo+ID4gICAgICAjOmt0YXBfdGVzdDogdGVzdF8yDQo+ID4gICAgICAjOmt0
YXBfc3BlZWQ6IHZlcnlfc2xvdw0KPiA+ICAgICAgIzpjdXN0b21faXNfZmxha3k6IHRydWUNCj4g
PiAgICAgICMgZm9ybWF0LWZyZWUgc3R1ZmYgZ29lcyBoZXJlDQo+ID4gICAgICBvayAyIHRlc3Rf
Mg0KPiA+IC4uLg0KPiANCj4gSGVsbG8hDQo+IA0KPiBJIHJlYWxseSBsaWtlIHRoaXMgaWRlYS4g
VGhlIHJlYXNvbiBJIGNob3NlIHRoZSBkaWFnbm9zdGljIGxpbmUgZm9ybWF0DQo+IHdhcyB0byBt
YWtlIGl0IGVhc2llciBmb3IgZXhpc3RpbmcgcGFyc2VycyB0byBwYXJzZSB0aGUgS1RBUCBNZXRh
ZGF0YQ0KPiBsaW5lcy4gSG93ZXZlciwgaWYgaXQgd29uJ3QgYmUgdG9vIG11Y2ggb2YgYW4gaXNz
dWUgZm9yIGN1cnJlbnQNCj4gcGFyc2VycywgSSB0aGluayB0aGlzIGlkZWEgd291bGQgYmUgYmV0
dGVyLiBTbyBJIGFtIGhhcHB5IHRvIGNoYW5nZQ0KPiB0aGlzIGluIHRoZSBuZXh0IHZlcnNpb24g
aWYgdGhlcmUgYXJlIG5vIGNvbXBsYWludHMuDQoNCkkgbGlrZSB0aGlzIHN1Z2dlc3Rpb24gYXMg
d2VsbC4gIFNvIHRoaXMgcmVzcG9uc2UgaXMgdGhlIG9wcG9zaXRlIG9mIGEgY29tcGxhaW50Lg0K
IC0tIFRpbQ0KDQo=

