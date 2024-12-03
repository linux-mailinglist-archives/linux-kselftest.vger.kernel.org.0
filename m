Return-Path: <linux-kselftest+bounces-22776-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3AD9E2CB9
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 21:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8A1D1620A6
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 20:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4CA1DF73E;
	Tue,  3 Dec 2024 20:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Nm0T6uZO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rqnh2EBN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF592500A8;
	Tue,  3 Dec 2024 20:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256438; cv=fail; b=H0Zvpsg3l7ADEA65szi2dekLGH5RcjykyjmwK8DwnlNwaHTtYhT+Ut+j04jOigy+0oTk8z1QftTX+/y7DzrF708MZn0IsoldJrGymD9go8zD3j283nlNyIqegt1mBTPHuXiBei9whSodffKZ0eQECAdZQB4PQQTuHOQZu98TinM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256438; c=relaxed/simple;
	bh=VQhCyGqtoIQksqKP3axNEGaIsXYVPmaAnHwmrB7e100=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KHKxwokloLmSQ8x/XP4zjwsoQN+zOkpOP4WlOqC3trWrYcTvx+CKvmkpYEzpoWgZfhVrUdOHzsmzy3BThOQkOhE+S1JrBVCtfprWYEgjROuuQ5EmNdjrwuJZziSIKAKp/apP3suB6LAayGUf8GcccVa5UcXj3ds9DBc2jSIwT6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Nm0T6uZO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rqnh2EBN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3K2xr4018357;
	Tue, 3 Dec 2024 20:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=VQhCyGqtoIQksqKP3axNEGaIsXYVPmaAnHwmrB7e100=; b=
	Nm0T6uZOkBgGUyYxPh2nMJyYc09y0I99rKFfVFswrlscfF9D8JOXv1Qa0X0mvbBt
	HyGdu3ZXMGohUNmq4f9QSWpUIuJb1SZrELP1GYY9zEKUq1cJqI5gfUrLQgVKFz8F
	e9577bJxh4jvj95jhfENFpBVwDqjklnw3QFnI5QRZeXuWipfg8BNsualBS6Yc0EY
	X2DGIOrXNaCdgNx/4W7Vn5bTCHUOrziQAsVzA5buojDlJ2Y5iqEE0XKmkSetYVHZ
	k4W6p0hsRL88C/PKrW13RXezh9/6/ciTtpn3FezKeyyH+QKdutCJl52FR7i1LFaa
	RGnQd3laEzdTs9HoOgF0CQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437tas6vd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 20:06:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3JrUSH032961;
	Tue, 3 Dec 2024 20:06:19 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 437s58f75x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 20:06:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/UNWnNF915EaVzY4kWoM1E5aOGNdxB+7QIoC5bb+unfZmKgP0pvxOceHNJk5gENAuxEkPCkyyNtPsSgGLsWpAUvUmDsSkUCNZl6OkecH2OAYdptX3lu2JUaJrnb9ypQrEZAX7ZKDDulCpuKXq7T3Cpm9IlUx0beqALHM9d7fvpMP4jngQm3InoGac4Gql5fYHTyS5Cl3VBtAIsECroaJ66afFo4eTj6IK7IP9/ap2CDHOQGy6hwHjouiANWfUwAwNvlb4TBvWpaSo4Mk3SL6YqcqvxeH48lw/PCFkPzdigeXqSyeRFeaNaPyYGp4TLgfadEn/8RLQyb4u6sOXI8Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQhCyGqtoIQksqKP3axNEGaIsXYVPmaAnHwmrB7e100=;
 b=H3zx6PuIIacpcE/W2r1+crauOw62ErGXn0n8Bpmyj6BUupFseb5FTRWbEo0B4b5ZoYVoEFgY12cLWHSBD9cyPMkrsMG4au18i+8vJSIMoJq6IPtR5zjNoCHbWlEMDq2ELHMcqMhlnw5eV5eH3A3FsH8tPG0sZpG1g4yjJpMnr4nmYnP5+590XpnpveatRmeQHIkZ4LyfNBD81f09tqmdYgIK7tKzxK371oTTeIeKBadJbtwnksd+sQLGjLWIjKu2TpVtD1MBe8It80sgLBW2unEUrX5rPUWwC7fdWRyF2D0PITqOw+a+5DyuZpkUrDK+nPsvrBtxgLVIlAs/qu/Z3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQhCyGqtoIQksqKP3axNEGaIsXYVPmaAnHwmrB7e100=;
 b=rqnh2EBNew8bnxXStcpdPkhj+mHzdgGB+xftS2ZEPMvA4i3SrWTRyxirwCnc7hzJC9KpG898Tc6JPeH7aynK3XlI90zlWe8eqNP0u0Nju0o8Vxp+BD2h2lTtfKCwFhCTyXO7TUqo2OWZcZ7gKc1q9hGXgPtDUbOkSuzuMWfBfA0=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by MW4PR10MB5812.namprd10.prod.outlook.com (2603:10b6:303:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 20:06:15 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%7]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 20:06:15 +0000
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
Thread-Index: AQHbOnDjfg4en7nkgkyalKK8KF8lk7LIuzaAgACvegCAC539gA==
Date: Tue, 3 Dec 2024 20:06:14 +0000
Message-ID: <B135AC90-7CE5-4E51-90B1-9D82031668A8@oracle.com>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
 <C4BE31F8-1FA3-4AD1-A712-ED2AA7E61E96@oracle.com>
 <17ef4f662e594c8431a00fe423507af4f6a82286.camel@huaweicloud.com>
In-Reply-To: <17ef4f662e594c8431a00fe423507af4f6a82286.camel@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR10MB7730:EE_|MW4PR10MB5812:EE_
x-ms-office365-filtering-correlation-id: 9c301d1d-4639-403c-0ce4-08dd13d5f113
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MnJOWEIrK2l4UVdJWlRVbGNUWkM0Z3ZWaTFCbko2QWk5SW1hVS90Y3hycVE4?=
 =?utf-8?B?WWVmS2trb2QxZndmWVNiVVduNlpibHAxWWh0QWs0eUdvWk9IS3V4VkVvU3g0?=
 =?utf-8?B?TlhVTldJUzgrVkJBS0Q2cEhGdHV1VVJIUnRmWU9RRkQvN0V5MFhaMVNrRGdO?=
 =?utf-8?B?dzdac2hIdElMbVVCZXB1Tm84YVRZTysrN0lub3BrdFh2YW1OMkcxM1B0Q2l1?=
 =?utf-8?B?WEZEOGEwdCt1OUorcE1mWCtGS243SnRMcWt3VEZMMnpUdUJ1Y2Q3R0d4ajEx?=
 =?utf-8?B?a3VvMXh2bXJVMzZvMDRmYjVaUGRkb1YxcEtoK05aNU5rMzl0Qnc1dlc4bERV?=
 =?utf-8?B?MEF0RWNoTGRZRmxuUlluYStPRDZvZ0ErQmdWbVdkUjdhbHJyK29BTVVNdHJr?=
 =?utf-8?B?bGZ2LzBBTDU0QjJmZzlsUkhINTZRMzNkSXBhMDhxelZUQy8rbGpCc2NWa2xM?=
 =?utf-8?B?ZVFYOGFNZnhOTk8wOHhqRjRuUlMweVlpcWJ3QUM4M3pkQm1xWnpZSUxGdHBV?=
 =?utf-8?B?aEI2NzlCWXl1ay83RmZNQjFrWDUyc0NWdmdKYUVRNDBHWit2MGs5eGF2SkRK?=
 =?utf-8?B?d1ZDZGsvaFhzZU0xb0dwcm9mVU5TMHdpeGZpTmZvcnNqZHJkcHpZU0NEdXhN?=
 =?utf-8?B?L1Q2dG1KaE5xU3o5WEx1UzRidVNGV1NIWWlLbktpM2h1eFJGUG1xWE8xWENQ?=
 =?utf-8?B?NTBiWWxSZVBCalJBWHExM3BRY2YrSnNZVkUvclEyc2xNd0gySlFsclBUU05P?=
 =?utf-8?B?TXE5dUtRZ3A1OFYrckFHTzVYZ2pxc1diTHYvYVN4U1NWWXRHVDZta1RrY21m?=
 =?utf-8?B?Ri9QZmtjbWdBbnFJOTdJS25WMUl0WU1JaGZpT1ovdk5RQ3U2NlN4Y1RyTjh1?=
 =?utf-8?B?Q04vRVR2OTRhYmJ3c2hOVFRCTlZ4UnUzVG03UllrdDZocDZ4RExZYktXU2VU?=
 =?utf-8?B?a0ZaOCtjVm5ocG1JWHJFOEtvbHpuaTE5cGNjbnUyeGNpMW9nRmNaSUxVZzRO?=
 =?utf-8?B?VVdLdldEa1V5bW9raW4vYUQva2pCbW1tUUZKdUVXc1JvREZNR0J3VmdzL29X?=
 =?utf-8?B?Q3ZTNmphUnU0d3lvSFJXRXVUSlhoZkV0alhRQkhXTHpVazd2cVZPVHFWRnE5?=
 =?utf-8?B?aTlWYnFMNHljcHMyeG56MmdGaGdHUjViMzZWZTJzaHV1aDZKcmlXU3cxVTlV?=
 =?utf-8?B?NXcwaG1zd29zUlZXNXpkbldKeFhYS0psZ2ZjbndwUmtZQlVUMStIQllwazBS?=
 =?utf-8?B?TkJoUG4vZUVkS0MydzRPdStaUnhYbGpnS0ZjblZCV0wyOURCUUQ2eU9jNHVm?=
 =?utf-8?B?azRnbnN6a2hGdmk0UFAyQVI1bjg1VytHZnY4UlhNRDhXUU5MenBlQzFzOUd1?=
 =?utf-8?B?bExGdDRmQkRBSUM2aDRTTUZOSHV3a3QzVHBOd3U5dmNpN0p0UG15VEZxYXZO?=
 =?utf-8?B?Z1NhVnNxU3JOcWJrMEN4MEppN3NJTGRlTVhCd0xTYldEajZPWnhvVHhXYkhj?=
 =?utf-8?B?bkxGRkdYOEhqTjlGU21VYlh2NUZlL0l2b0pBTkJDR1JKNVk1eWMwOWh3TGVN?=
 =?utf-8?B?cEozM0FHZnVjTmxFNDJPS1NCcmxabm9EMHF6dkRsRHk3TDMwTVJPTTRySUtL?=
 =?utf-8?B?aG1RZkc3T25NOVdvSlBRZGdGbWl5aU5WSnVka2J1UFdrRGdIbkxBQVZyNGY0?=
 =?utf-8?B?UFlBbjJGaHBhbDdYeUpkU09LanhLS05DOUJ6UzFRQ3NiaDBJN0E4VDQ5NlNK?=
 =?utf-8?B?Yll0c05rZmllQ0YvNWpQZXdzdy9LMnVyUHpoM21iWjY1YVVtSXJIRFd2YURU?=
 =?utf-8?B?cjJSWW5BTE5hVlZVQk9GcWZjczU0WHpuOXo0dlF0RzU5bjlBNHcrMHdzVktq?=
 =?utf-8?B?aE0rOXdSTFlBYjZiblRudE01dURjdDBuZ0dYejZkK2VnSmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXNRelRwb1Bxem4rcnNzVUI4RUtkQ3draXhna2o0cjY1MW5vRDBodUNUL0RP?=
 =?utf-8?B?ZFZSQ0x4Yi9oRUtrdjAyN3dMTitpTFlYOFlldEMyczFJazh6TWVuMWpFUTcy?=
 =?utf-8?B?SXJ3NENjV1JnMHQ2Vko5cS9VR1BKVjRqS3hJODhHcXZjVEV6cHRyOG5RQWll?=
 =?utf-8?B?R3BRR1A1UVdyUTNFemh4V3ZOc2pnRW1rMFYxb1BPTnZ1bWl0N2tPSXBQWkVT?=
 =?utf-8?B?T3lNcnJhbzFTWm5MaGNqUzJFOUlGL3RuazdTeVd0WjNmcHJpaEM3UlpzUjYz?=
 =?utf-8?B?a1hFeVN6cFA2ZU0zcE9sUGNlQkJsU2RtZWpFRFIwR2sxTExobEg2aDg5UW93?=
 =?utf-8?B?V0drYUs2cmJrTWE0QWg2NnkvaGlYUWk1NEhmR1ArTkRQNmdCU0l1OUw1ajVs?=
 =?utf-8?B?K2tVY2RnL0pHeWJrL24rd0t0RkQxRWd5Q2E2SHl3Qk9YcUF5NWgvNHc2S3k4?=
 =?utf-8?B?eExPcTFMQVdXRmxISFptbHhZbEl1Y0dSSFFSNnhpZTNGcG92YURvRDAzODl6?=
 =?utf-8?B?VTZzQ0NnMHVXQ3F1dUgwV3VRQmJrM2NpRXVGQTFBaDdsR0xCOUlVNWJPNUpW?=
 =?utf-8?B?UjlDTndITFJLdGhld21lTzJUREJzWTd6RWVSeXNNS2NCRElSSDg0aTBXNXZO?=
 =?utf-8?B?WkJiL0Q1NTQyT2hvcW1ZajFhWkpwaENUbzl4bHlsSmtlUGNzZlBrT091TWJy?=
 =?utf-8?B?TndGOHJvbkdQTDZkbDlNaEhLWjlta2tEd0lsdXZheDl2YW1nUTU5SGh2R1R6?=
 =?utf-8?B?TTdiS013Nk5UUnl0VityOHVWVFJ5SWpCTU45UlR2K2VVSFZGMnNWanJMc2wv?=
 =?utf-8?B?WllUKzdpRjlxNkxPMXFIenlkVVcxenM1S1hvOEtYamk0R3lpbzlyaFh5VE81?=
 =?utf-8?B?cjQrcUV2eDFqd0JwRkxRY1dzNnlYT2YrYzg5a2hsQmFUUDk1cFhMVHgzbERy?=
 =?utf-8?B?MFBYcGhtd01nSjViTnpFNWdLcWFHR1A2c1k4aXRrWStkQTBQbnBNNFgxTlB3?=
 =?utf-8?B?RW5Ea0VsaXROelE5bmU3c1hJYkl3YnZnaU90ZUZxaTNFMHZtRHhrcXFPMVNI?=
 =?utf-8?B?UjdjZ09pMHZkZmQ4VU11ODJOcWJncmFOQU1sS0pQR09RQUxTb3JabGp6NGRN?=
 =?utf-8?B?K3EwL3JESXA5WnJoRlhSN2xlOHVVREljaVhQR1ZKOXdFZkI4eDBVdFdoTXdI?=
 =?utf-8?B?NER2eGFoWnAwT1I1S25Ud214T0VTQmFkalVOYzNPbG4wai9jbWRCSm55ajU1?=
 =?utf-8?B?WjcrYmh6SWV3YWI2ZVlwdHpleHFVckVvVGtDMU9rYk1TZ1RybVNBWVFWWHFj?=
 =?utf-8?B?cWlkekpYVzVDc3hzVnIvYVQxdUh1dXlDcVFSZnl6N3ozSlpqWWdkYjJncnUz?=
 =?utf-8?B?eGk5NFdMY0J6aExkSnJYVU95QjRXTnFtYWZZZWV1cmRDdkRDYWFRR0ZIeHNw?=
 =?utf-8?B?WEQ0VU5BSEgyQmI1UVZJd3cvOVZDdXFtc00yajhCdUttRFZPUTlMTEhVblJ1?=
 =?utf-8?B?MnJkZkhMYnJ6Y1Fnc1k1bE4zbS9ITWZ3eFJXSWNWZEd4YmJDdHNuUTEwSzV6?=
 =?utf-8?B?WmZ4V0VxMjJpZnZxTWtTclpFVUptRXF4dHJaQlFyMzQycVhEY0pvRlZFUHM0?=
 =?utf-8?B?MTZyRDdlenhVaUIreGpYZng3aWtwVVFSUEJ2dm5MZXdPRjBRTnhYYjBjODlH?=
 =?utf-8?B?eUZQQVM2ajZlMzZ3M3R4ZU1zcjhNZHlDdFVPcGtlUUFLeGRsRkd3djY2V2Rh?=
 =?utf-8?B?RTZ0c3JQRFphZERrdGhZd01vOVJ6NWd4ZEZJNWFLY3o2RnNENDVLWUZmSWEz?=
 =?utf-8?B?NThkOEFrVEh2S2VhU2xlZ0FzSEU2cUxKcGkwZWpRY3lYOUU1VTFTUllPcFZv?=
 =?utf-8?B?YXdZd2dYcVFJamVKRWNZVUorRU5SdlRjYWV5YlZnSU9ycjNQSzFwcUNhNy9o?=
 =?utf-8?B?aGhidHlKdWgzT2hSaUswYTdyRHdrRTFKY1hodmJ1M2NVcmxjc0NsaGllc1I4?=
 =?utf-8?B?ZzgzRWsrOHBiMXl0aS9YRjdkRzM1eUVyWVdyODJsTk8zZEgzQVNxRkZYUyth?=
 =?utf-8?B?WEtmVGVhOGpuclY4MzJtK1E4R0pielF5S296T0s4TlVCenNKSTNRWDZqQzJ1?=
 =?utf-8?B?UFdsV1Z1NXhBMHc2Y1crTlBuTXR0VFEvYVFQcklrc2JaSFlZM0dxZHhLdWFP?=
 =?utf-8?B?eFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25D9F66A98944944969665EDEE96AE3C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tcwDQCGl9zAkhX9e6I46TPK40B7/sx7lyvhpQ806BgJuOKngC9KvnS/mUClXJznsy+jyigBNU7+k10Jv83sJEjsNzh4z3US1bnh1iRCzdyE+EShWWCpDWkZYUahNf1fqS0PFyE6ktUfmB5vJlKdNbeZ1gui5ggu+8di1RzhQ0uDbWA6CFj2hPQyjILuW1If/OQ4abyk/MZZhXTSZ1zOqYucw9hadVEMzIBYFbDzo1M4HBPClZbMpXY0x1xEg+RPVCfQ6h/olCDkkwch74Lz4H3iFWBHnzYjv9BajTWMjC2P9vv+7uLyQ1T9DUiDgJVKlZzMfMlOEB5EhZgTtAI4W6aF007DlbZi6yQtiv8ed9Adn5LYIvvPX/0GcIv6rz1Si2OloXk058YotcoaI3OsxpweC8F3g3lYtGDk2b00yVC3PBloT2x2Xl/43B0AaIVqKlGMssdNWGaodTL/3QOlnv9ZNv5Y/0x2abwk0QTDZ+oTMjhaFlYBIEQ1DTszEDN2SY8QyZShN8CHUJyIUSYaes25h68qJ4gE7O09R2JS0cd07rYXKSu1HJHKfRUeSjZmmI9ZuYtrlDeKerRuR/fI738BuyVVMOt2OWMb7PEZaQvw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c301d1d-4639-403c-0ce4-08dd13d5f113
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 20:06:14.9620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n0zvOZzIzJKXOUm/tpuKgR7brJZgT+hgIW1zADkq2j0VSDwLhKOO8N+CxWQfoQwoaHPkY2yGtVB5N1geP4+b/yH3gFVCEFv/IfS1JTS+S+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5812
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-03_08,2024-12-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412030166
X-Proofpoint-GUID: qWQ5Smz8YeFr89rIXXqfFTRF-TUumHfi
X-Proofpoint-ORIG-GUID: qWQ5Smz8YeFr89rIXXqfFTRF-TUumHfi

DQoNCj4gT24gTm92IDI2LCAyMDI0LCBhdCAzOjQx4oCvQU0sIFJvYmVydG8gU2Fzc3UgPHJvYmVy
dG8uc2Fzc3VAaHVhd2VpY2xvdWQuY29tPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgMjAyNC0xMS0y
NiBhdCAwMDoxMyArMDAwMCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+IA0KPj4+IE9uIE5vdiAx
OSwgMjAyNCwgYXQgMzo0OeKAr0FNLCBSb2JlcnRvIFNhc3N1IDxyb2JlcnRvLnNhc3N1QGh1YXdl
aWNsb3VkLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4gRnJvbTogUm9iZXJ0byBTYXNzdSA8cm9iZXJ0
by5zYXNzdUBodWF3ZWkuY29tPg0KPj4+IA0KPj4+IFRoZSBJbnRlZ3JpdHkgRGlnZXN0IENhY2hl
IGNhbiBhbHNvIGhlbHAgSU1BIGZvciBhcHByYWlzYWwuIElNQSBjYW4gc2ltcGx5DQo+Pj4gbG9v
a3VwIHRoZSBjYWxjdWxhdGVkIGRpZ2VzdCBvZiBhbiBhY2Nlc3NlZCBmaWxlIGluIHRoZSBsaXN0
IG9mIGRpZ2VzdHMNCj4+PiBleHRyYWN0ZWQgZnJvbSBwYWNrYWdlIGhlYWRlcnMsIGFmdGVyIHZl
cmlmeWluZyB0aGUgaGVhZGVyIHNpZ25hdHVyZS4gSXQgaXMNCj4+PiBzdWZmaWNpZW50IHRvIHZl
cmlmeSBvbmx5IG9uZSBzaWduYXR1cmUgZm9yIGFsbCBmaWxlcyBpbiB0aGUgcGFja2FnZSwgYXMN
Cj4+PiBvcHBvc2VkIHRvIHZlcmlmeWluZyBhIHNpZ25hdHVyZSBmb3IgZWFjaCBmaWxlLg0KPj4g
DQo+PiBJcyB0aGVyZSBhIHdheSB0byBtYWludGFpbiBpbnRlZ3JpdHkgb3ZlciB0aW1lPyAgVG9k
YXkgaWYgYSBDVkUgaXMgZGlzY292ZXJlZCANCj4+IGluIGEgc2lnbmVkIHByb2dyYW0sIHRoZSBw
cm9ncmFtIGhhc2ggY2FuIGJlIGFkZGVkIHRvIHRoZSBibGFja2xpc3Qga2V5cmluZy4gDQo+PiBM
YXRlciBpZiBJTUEgYXBwcmFpc2FsIGlzIHVzZWQsIHRoZSBzaWduYXR1cmUgdmFsaWRhdGlvbiB3
aWxsIGZhaWwganVzdCBmb3IgdGhhdCANCj4+IHByb2dyYW0uICBXaXRoIHRoZSBJbnRlZ3JpdHkg
RGlnZXN0IENhY2hlLCBpcyB0aGVyZSBhIHdheSB0byBkbyB0aGlzPyAgDQo+IA0KPiBBcyBmYXIg
YXMgSSBjYW4gc2VlLCB0aGUgaW1hX2NoZWNrX2JsYWNrbGlzdCgpIGNhbGwgaXMgYmVmb3JlDQo+
IGltYV9hcHByYWlzZV9tZWFzdXJlbWVudCgpLiBJZiBpdCBmYWlscywgYXBwcmFpc2FsIHdpdGgg
dGhlIEludGVncml0eQ0KPiBEaWdlc3QgQ2FjaGUgd2lsbCBub3QgYmUgZG9uZS4NCg0KDQpJdCBp
cyBnb29kIHRoZSBwcm9ncmFtIGhhc2ggd291bGQgYmUgY2hlY2tlZCBiZWZvcmVoYW5kIGFuZCBm
YWlsIGlmIGl0IGlzIA0KY29udGFpbmVkIG9uIHRoZSBsaXN0LiANCg0KVGhlIC5pbWEga2V5cmlu
ZyBtYXkgY29udGFpbiBtYW55IGtleXMuICBJZiBvbmUgb2YgdGhlIGtleXMgd2FzIGxhdGVyIA0K
cmV2b2tlZCBhbmQgYWRkZWQgdG8gdGhlIC5ibGFja2xpc3QsIHdvdWxkbid0IHRoaXMgYmUgbWlz
c2VkPyAgSXQgd291bGQgDQpiZSBjYXVnaHQgZHVyaW5nIHNpZ25hdHVyZSB2YWxpZGF0aW9uIHdo
ZW4gdGhlIGZpbGUgaXMgbGF0ZXIgYXBwcmFpc2VkLCBidXQgDQpub3cgdGhpcyBzdGVwIGlzbid0
IHRha2luZyBwbGFjZS4gIENvcnJlY3Q/DQoNCldpdGggSU1BIGFwcHJhaXNhbCwgaXQgaXMgZWFz
eSB0byBtYWludGFpbiBhdXRoZW50aWNpdHkgYnV0IGNoYWxsZW5naW5nIHRvIA0KbWFpbnRhaW4g
aW50ZWdyaXR5IG92ZXIgdGltZS4gSW4gdXNlci1zcGFjZSB0aGVyZSBhcmUgY29uc3RhbnRseSBu
ZXcgQ1ZFcy4gIA0KVG8gbWFpbnRhaW4gaW50ZWdyaXR5IG92ZXIgdGltZSwgZWl0aGVyIGtleXMg
bmVlZCB0byBiZSByb3RhdGVkIGluIHRoZSAuaW1hIA0Ka2V5cmluZyBvciBwcm9ncmFtIGhhc2hl
cyBuZWVkIHRvIGJlIGZyZXF1ZW50bHkgYWRkZWQgdG8gdGhlIC5ibGFja2xpc3QuICAgDQpJZiBu
ZWl0aGVyIGlzIGRvbmUsIGZvciBhbiBlbmQtdXNlciBvbiBhIGRpc3RybywgSU1BLWFwcHJhaXNh
bCBiYXNpY2FsbHkgDQpndWFyYW50ZWVzIGF1dGhlbnRpY2l0eS4NCg0KV2hpbGUgSSB1bmRlcnN0
YW5kIHRoZSBpbnRlbnQgb2YgdGhlIHNlcmllcyBpcyB0byBpbmNyZWFzZSBwZXJmb3JtYW5jZSwg
DQpoYXZlIHlvdSBjb25zaWRlcmVkIHVzaW5nIHRoaXMgdG8gZ2l2ZSB0aGUgZW5kLXVzZXIgdGhl
IGFiaWxpdHkgdG8gbWFpbnRhaW4gDQppbnRlZ3JpdHkgb2YgdGhlaXIgc3lzdGVtPyAgV2hhdCBJ
IG1lYW4gaXMsIGluc3RlYWQgb2YgdHJ5aW5nIHRvIGltcG9ydCBhbnl0aGluZyANCmZyb20gYW4g
UlBNLCBqdXN0IGhhdmUgdGhlIGVuZC11c2VyIHByb3ZpZGUgdGhpcyBpbmZvcm1hdGlvbiBpbiBz
b21lIGZvcm1hdCANCnRvIHRoZSBEaWdlc3QgQ2FjaGUuICBVc2VyLXNwYWNlIHRvb2xzIGNvdWxk
IGJlIGJ1aWx0IHRvIGNvbGxlY3QgYW5kIGZvcm1hdCANCnRoZSBkYXRhIG5lZWRlZCBieSB0aGUg
RGlnZXN0IENhY2hlLiAgVGhpcyBkYXRhICBtYXkgYWxsb3cgbXVsdGlwbGUgdmVyc2lvbnMgDQpv
ZiB0aGUgc2FtZSBwcm9ncmFtLiAgVGhlIGRhdGEgd291bGQgdGhlbiBiZSBzaWduZWQgYnkgb25l
IG9mIHRoZSBzeXN0ZW0gDQprZXJuZWwga2V5cyAoZWl0aGVyIHNvbWV0aGluZyBpbiB0aGUgc2Vj
b25kYXJ5IG9yIG1hY2hpbmUga2V5cmluZyksIHRvIG1haW50YWluIA0KYSByb290IG9mIHRydXN0
LiAgVGhpcyB3b3VsZCBnaXZlIHRoZSBlbmQtdXNlciB0aGUgYWJpbGl0eSB0byBoYXZlIGludGVn
cml0eSBob3dldmVyIA0KdGhleSBzZWUgZml0LiAgVGhpcyBsZWF2ZXMgdGhlIGRpc3RybyB0byBw
cm92aWRlIHNpZ25lZCBwcm9ncmFtcyBhbmQgdGhlIGVuZC11c2VyIA0KdGhlIGFiaWxpdHkgdG8g
ZGVjaWRlIHdoYXQgbGV2ZWwgb2Ygc29mdHdhcmUgdGhleSB3YW50IHRvIHJ1biBvbiB0aGVpciBz
eXN0ZW0uICBJZiANCnNvbWV0aGluZyBpc24ndCBpbiB0aGUgRGlnZXN0IENhY2hlLCBpdCBnZXRz
IGJ1bXBlZCBkb3duIHRvIHRoZSB0cmFkaXRpb25hbCANCklNQS1hcHByYWlzYWwuICBJIHRoaW5r
IGl0IHdvdWxkIHNpbXBsaWZ5IHRoZSBwcm9ibGVtIHlvdSBhcmUgdHJ5aW5nIHRvIHNvbHZlLCAN
CmVzcGVjaWFsbHkgYXJvdW5kIHRoZSBtaXNzaW5nIGtlcm5lbCBQR1AgY29kZSByZXF1aXJlZCBm
b3IgYWxsIHRoaXMgdG8gd29yaywgDQpzaW5jZSBpdCB3b3VsZG4ndCBiZSBuZWNlc3NhcnkuICAg
V2l0aCB0aGlzIGFwcHJvYWNoLCBiZXNpZGVzIHRoZSBwZXJmb3JtYW5jZSANCmdhaW4sIHRoZSBl
bmQtdXNlciB3b3VsZCBnYWluIHRoZSBhYmlsaXR5IHRvIG1haW50YWluIGludGVncml0eSB0aGF0
IGlzIGVuZm9yY2VkIGJ5DQp0aGUga2VybmVsLg0KDQo=

