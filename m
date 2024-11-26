Return-Path: <linux-kselftest+bounces-22519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 989C99D8F80
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 01:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1849AB227E1
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 00:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCB738C;
	Tue, 26 Nov 2024 00:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BBTyZDWR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BOAplysS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D11EEBE;
	Tue, 26 Nov 2024 00:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732580092; cv=fail; b=Zk4fxFHLF1aQ5PpIW+j9v8J8kiDjl74PfszVf5BJs/AtFX2GauVRS6WJFg2KZt4hPf93jj1Kgbsogwnr4H5am1P3dTMXWje7p3lpycP6QzJEzihNvm8tEV0XvktmIuVsUkYIh692/e9FRQqeGrHu6B4J1HaBeow+KKgO8Wwp+uA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732580092; c=relaxed/simple;
	bh=q3NwfFUxjvgvLEMa6ZlIrZBc9hKdOoVjyNB/SCQDEvg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qgjstMxY4C1rrjRPC0y0CKGIBpdxDYzoI0hABaMjtcnH8FRziRhRgmvBIwFF67DUpTB1ITNRZKZysE2pwW2FAQ8QAyAIZR7j2kpQVBXb1tyko4SRkJOZv8TxGwLAeJpPYy0ewiqdn0jGliSg7/hgnCh44jNM5wKeuStolUJo6UQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BBTyZDWR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BOAplysS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APHXXl2000741;
	Tue, 26 Nov 2024 00:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=q3NwfFUxjvgvLEMa6ZlIrZBc9hKdOoVjyNB/SCQDEvg=; b=
	BBTyZDWRQi+lIEMk8mCzj7qG6ib/g+zx1V097n+OwbaMNP0K7CRWH8WAYYFVWlKf
	OlnqMn7iAECUEJVd9L2Mq+2Ydg5r5RKeqJJbqgev0vUhUrKtItAi32ECHsBjXfAT
	3GPMqmnk4fNNDxpoBGYhsFjsh9MgAOJWjkCZNRKlScdArMAdcyDItjOYw73Shjjc
	gCZ0vpsMWxbQH70JaOfar8LHMMHNRib5oyImoY6m07i2GA4/tdqcfFMH3GpOE4j4
	8pscFtiRfRgsw/2EBTHTJwbbRWe6EOCsfbU/QPufzmlUoH5ETCLv0qCqPGPV0PdY
	2zm5fV4jRIfwqtDBqF/aBQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43384avcdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 00:13:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4APNREkM002669;
	Tue, 26 Nov 2024 00:13:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4335g8erp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 00:13:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wsatmEC26oS0byjuZM2Ofa9ugRyqHQ+LGY81XPr5IH7qvX0eBEKSWRqwRwEb7CbiJM+epuJSVsMZRd/acsvpPlIQYsbPMpRep1O38HCxk7bHD7haeTBazj3/XzSwQtI26RGc/zlrd3+ie9lLnq1v0dAikk8jkZjYgBd9v3a99ho0vvW6qyyHeDumvfjE8quvMDLEqy+OacyENobTNts2dxp1dFNmfiWcGTKSY2R+0GA10zkBXA9ScGWuc1L52zJq/sFxaxTrX7Zq80ABEQ2nSmzpCsnNbNaJRKgtwt/Zx2KbwnCPNVmuNI9MXpqpKYTWozMNvrj7jq+1CVNLoLYhxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3NwfFUxjvgvLEMa6ZlIrZBc9hKdOoVjyNB/SCQDEvg=;
 b=EiAbE0KV4gxjN/PK1niKDobEa5S1S9o0+ofAzSteOIRNhme9rjJogwI+K4wrArxun6/jN/jlwY2W8JrVEyDvToNbbWHTmAzEtq6mVcGbPyWWLE0Dn0ptBZPH8z1kpfvyNTCQCLCJc2xKb2uNvno3mSYJdWwWbaIJ4YcmBOlt2iFhmuwa+RIaQpvdYgSAgoLLYwtGppRTXHfHI8H6c7+iiuygZz3Q0zDlSMdJGSCxjIHOCkkejhuqCjSDLBNoTgA+OC96lwB8Td/ChvGCWUMklKWQLJYKwrREuwKhw+L3ISqGhpSghw065mTkvEuAK/mKg29QL3IR3XSnYhQQ7iSASQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3NwfFUxjvgvLEMa6ZlIrZBc9hKdOoVjyNB/SCQDEvg=;
 b=BOAplysSifpb+PEOl1LsmJRMVID1IM8l2qp6/BZNahzqAhCXHcjO9/xwUp6DS/yoqXxoCkKm0pE7Zsy0ukfAJYEaYgvuQjvzmEF7I0CiNVlRbOtO2xXa54TfnfVShp0+xayF3yx0hASUJOzr/ipnljwej0wIPLFnR7ZR7/MtI4o=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by CH3PR10MB7959.namprd10.prod.outlook.com (2603:10b6:610:1c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Tue, 26 Nov
 2024 00:13:52 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%6]) with mapi id 15.20.8182.018; Tue, 26 Nov 2024
 00:13:52 +0000
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
Thread-Index: AQHbOnDjfg4en7nkgkyalKK8KF8lk7LIuzaA
Date: Tue, 26 Nov 2024 00:13:51 +0000
Message-ID: <C4BE31F8-1FA3-4AD1-A712-ED2AA7E61E96@oracle.com>
References: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20241119104922.2772571-1-roberto.sassu@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR10MB7730:EE_|CH3PR10MB7959:EE_
x-ms-office365-filtering-correlation-id: 36530bca-3025-47a5-3c13-08dd0daf3539
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S0VHdnpwSkt5U3FGa1hYUXcyUDJMSHl6bktmSXpBdnpibDFiTDFyeHVnLy93?=
 =?utf-8?B?TStWV3F2ZFZjNDVGQmFxYmk5ZTl4M1ZkMklrVDhPOSt4MUhpL3h3SGFGY2R4?=
 =?utf-8?B?cXowQ3dONzBDMkIvU0kxS2lBbXN3Mk5jVnJqYmxFM2RyZTkzaVdjQ2ZiZXEz?=
 =?utf-8?B?aFFsRlpFSDZvYUN6aDFNMU5ON3hibDlyK3VPcENlV0s3V2FYbDBnQ2gzTHhJ?=
 =?utf-8?B?bEdKdUQ4TGdLQjhMZ1JoazZ4bVJkaFhtTUUzRjZkQjFzc0dMNmNBcW8xYjI1?=
 =?utf-8?B?WXJWTEcxS2plZFYvN1FnZ215S2dydlRVSGlicXpQdk5BbGJWNHNGVmFucSsz?=
 =?utf-8?B?MXB0V281bEZsemtPa3ZUd0tRcVZBRFRCUFNJZmZ2b25NVFArOTVITmcrai96?=
 =?utf-8?B?cXlkSXZjL1k1T3JZSW1aZSs4YVIyYnA2QnE4N2xWcThFUlpyUkNYUEZXNTJ4?=
 =?utf-8?B?MVRBSFFNanFNeDRHQWw2N3NJRTZQSE1KaCtraVplTjZORytRTXowZEdVUEFO?=
 =?utf-8?B?Wk5QNnMyMVF5VWVUekpGeGJXdmV3azBML28yc3N6NnpBMkRYN3dJMEszRm5y?=
 =?utf-8?B?MFYyVlZ5V1dIVVl6Z2xaWkEvTU1yTHhrUDBLbDZPdXRQelpUNHJ3OHRwMmVK?=
 =?utf-8?B?K004M1Fvd2tGTnlUSDVpVFJFNFhEWlhXQUNWNUF3R2hXa3pId1lldTZZQVJl?=
 =?utf-8?B?YlUvNC82YnNXRnk1MDhFRmpsaVdWM0xzZnRpNDVoUXVjcHprZm5mWUY4RWNY?=
 =?utf-8?B?SFNDeWlQUkdKbCtSNXNxWWdPWW5UaFRqUFY4WGprTlNOdm5YVnIybEQrcVdB?=
 =?utf-8?B?cXdqaS9aZi9SNjk0dnE3S2dxZnEvMkJqMURQNlEzVDF2YkVFeWVyNHFsVkhz?=
 =?utf-8?B?VTdMR1c3K0ZxVG1Ea20rTjljdkZ5c0puRUo5WnpCVkRuSkxaNmhHMy9zbTdi?=
 =?utf-8?B?M1IwL1pJb21rNGhSc29jd0RzRGMvSnVMMHdJR3dmZENucW44VTVoQ0dXeGRv?=
 =?utf-8?B?Mms4dHg5Q3FNTFdWSkpKb3NMcHJOaFNhQjFsbWp2WXQrQ3FCTjR1T1ZFNGpU?=
 =?utf-8?B?ZTVtRGJWQ3VZQW9pcWFtTzdOdlVneEIzL3hwdHE1aGlzRytFNkppRDlhVXZ6?=
 =?utf-8?B?MmVJY2laSFQwWFhqSlJ4TWFwc3Z0S0dpdVA0RGV6YkVLaFpXNFFJblZhaEVt?=
 =?utf-8?B?YTBIS09TVzFrYVNzdTlxZE40cEd3SnV6cy9aUEVKRTlDcUtZT0YxdWZRK3li?=
 =?utf-8?B?d0cwWVN0Nm1VUldYVStZcEd4eG56elNrMkNiVEtPMEQvZDY1SDlYS29PbXgx?=
 =?utf-8?B?NzZFcGpIWFZpNGg2YVkzdit4TFJNL3NBUEx1SitqaVArMjVnb0o1OFRFeExK?=
 =?utf-8?B?dkdiRVhJRHRxOGNWUXVSb0hFQXBMK0k1TkNwclBIN0FaSlVIS3ZsSlJML2xS?=
 =?utf-8?B?V1FqTVNLcXFBWlBNSENFU0xsSmZuVkxlUmRBcDQrZXhaMDJXeXROLzNEa3lk?=
 =?utf-8?B?RkQwaWwxaEIzRWtBTkk5eWFHRDJnYWtwZVlzcGdMRUNmVkRPeit1WUJvUGRh?=
 =?utf-8?B?eWJTZ2pCTHJuSVVGelBlUlNmRXQvMU1XdVdWR2t0ZE5YVjZuaVBrc1RqTEV1?=
 =?utf-8?B?OElUNlZqbmFRbDBDK2s1NEtjUnB0eGFybDYxTG5sTTc4Rkhvczg2dUtETmRY?=
 =?utf-8?B?dkxQQWYxK1dBQ1FqL0VJb0VsSE4zVmFHbERWQVZMWHREQTB4VUtyL0lwbnlo?=
 =?utf-8?B?dWUrS1BSSzVSdXNqRDU5YXhHZGNkVzN0cjJEdTE4RkRJanZ3Z0dZMEhobzNk?=
 =?utf-8?B?VWdYUm5lTElKZGNzRVNwM2Npb0hjQ3JrTHBCczZ2djJ6cE0xYXFQUDEwaFlW?=
 =?utf-8?B?cmVQQ2ROaEtXY3dyZ3ltNGxnM2tpOGtBMUhsUENBNHJVVXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RzdzWmVZc3JtK0JuYWtuaHhoOEFWWThHYWsvOEVTRkhWVkVtMlVJWTlrUFpt?=
 =?utf-8?B?ZjdZVlk3VmNLYXl2cENQcWJoK2pNbVFaeVFQSjVGb0Y5Q3RBcCt1dWUweWU5?=
 =?utf-8?B?aExxSVBkWnpHOWlWalVZSlArMlB2UmJlOVZrUWM2U28xaGpJbU1vM09nQlM1?=
 =?utf-8?B?SVd3MkQ1elFKaG5YWG1ZbUR2OVd6MVkxNjQyZWNtUUJIWVl4bUxXVjVVU0du?=
 =?utf-8?B?M093WkF3UWFGaFIybk41eVVwYmFHL3cxQ2kvZ1JDMHZuMDlkMDBHOWJlSG0z?=
 =?utf-8?B?ZE5xb0tlQWxhMTR5czgvTzJBZ1JXYnZ1WklRNWx4TEdKcUVNSzA0bUFWSUdU?=
 =?utf-8?B?d1NoTTNQb0s1NzZWaWdJN0diWkJOVGMwZnlhZzM4UDc1QU9icUNmT2FpamlH?=
 =?utf-8?B?TlBxL1o1d2FQdXV6VFNRTnVKcys3WUZBMGY0Tmk3VmwyS2NhbVBOQkdrc1lV?=
 =?utf-8?B?VVFiVkRvR2JwbUZoQjJTUGd4WU1PeFFudTRtQWY0dUZwUVlCKzRVWi91d3Vj?=
 =?utf-8?B?Mm5iNmNjbkFrQ2VlV2dLSVZIdE9uMTc0UStJVURENU12dllVZndpclBNbmVS?=
 =?utf-8?B?NHN5c0owOHVwZDREcE1rcXRQOEF4S05DZ1dTdnlRZjlOT2hNNlRid0NmSWZo?=
 =?utf-8?B?OGE4Z1VDQUdKb0hOTUF3QmVrcThnYjdmVTdWS3FnNVdIVlpaOWoydCtrSmFY?=
 =?utf-8?B?bVJlbEE5RGxZUHFabVZYNkV4Uit3OUdCdEtsZ0pXclJuUFUwQ0czM0poeHEy?=
 =?utf-8?B?OWUxRnJqY2lRb3Y5c1M4UDRaSUIwd1RMVm5KUUo1REMxbVR4TjdZb0dsZ0Vh?=
 =?utf-8?B?NzNuOGhrYlBoejdyazFQT0Y2bmNXcDhCdUpNdENFTDcyaVRCazgyamVvb2Ev?=
 =?utf-8?B?RGxJWUsvRnBGQjJ1dDg0WVJHT2NsWHpuZG1vZEQ0em9WZ3BSejZ0THBUWS9V?=
 =?utf-8?B?NUl1ZWpLS3lsRHBkcDh3dTV5OFlmODI5Z1JhWHdnaHBSQm9LNGh5d0czcmx5?=
 =?utf-8?B?ZllYVEdHbnlhMUZkRlFCZGFwNjZwSFpQVkRhVWw4Z0h5RE1xSldSWStZRjZP?=
 =?utf-8?B?Wno3ZldNS3ZzaVBvSGNOOGoydk9mV0laMTNsR2YrMjNVZFphbVVqZElqK0pB?=
 =?utf-8?B?NHh3Vm5iaytkbWJlWWpsdUVSQ2w1VXRyaGpaK1hYMklrWGJtVWJuM2xlTUc4?=
 =?utf-8?B?ZnYzY0cxNmV6MzVlejMyTTMwZlBzTzRJODd5MHYyamRkbXFtZ2M5SHU5VnFY?=
 =?utf-8?B?TG1weW90WVNZdVlRL3o1WmtJS1VhMlEzQ2pSNHRFVDErWnc0eXIrcEIzeGYy?=
 =?utf-8?B?Y3VEK0ZtbDRjR2U0dDZaRUxkWTlGR0V2TDhHZHFKOWIvR0c4K09FcWlJMkpQ?=
 =?utf-8?B?ZWZsOE5pQ2tTOVVuQ05iVjlWZEVVUEtZTkdSTHR4OWJ5a1A3bGhRbGUrTnRt?=
 =?utf-8?B?R3c2USt2Kzl0bnl4OEs3ZjZFdEk4YUU1Z3dyUXBVdTRYdXdyZGllWFBHOXQ0?=
 =?utf-8?B?c0RscUNrOXpWeHp1Q0llTVY5UWNCSTdhY3RUUjQvVnZLRVlRSHZDYVZuK3Bq?=
 =?utf-8?B?Qit2ZjYrYmZ6NFVDVmxaNjk4Q0FZay9pNnc2d1d2WjM5RlJWNy9yTDJDeHo0?=
 =?utf-8?B?UzhWOVdSM3dWdkhjdkFDT2NHN1ZhU0M5dkRFM1BrTWtybGNpNTc0Y1ZVZ2cw?=
 =?utf-8?B?SzRLdVdkYyt0dkRnTUJiQUdBKzVlZGpMTmZVUmI1Z2RSUElZNlNDZW1NZDFL?=
 =?utf-8?B?bERFcXFSRVdRanJVZHZlZnVIckkrcHRLUUpsNjREOVdZa0tYVjgyOXdkbmFw?=
 =?utf-8?B?Ym1xL2NJMjZJcXNsbUNuNFQrNkFMWVlZVGxvWCtoZktZQjF6a1NIUlU3bzZM?=
 =?utf-8?B?RVRRTlZPV3djOFlLUDd4M1dYZmxaOUs3b1JGanA5bGY3cU00ZjVrZlVqQ0M5?=
 =?utf-8?B?SzN6S2FwNlJOa1NORlAxelNoR3cyTExqOFErNEs2aEFtZUJWNjNpLzY5MEE4?=
 =?utf-8?B?bzlTZU1tUzlsTi9yQlVTbldCb3NZYUx2QmhlejZGTEkzM1l5cXVSOWpobzdB?=
 =?utf-8?B?QW1uclBYQkh0TGs2VUIweWE1TmY2aDV5cmZRODlxSVBFME5hVnBCT2o1cmtp?=
 =?utf-8?B?djVJdlFQcmZlV3R0YllidElsK2V5M1ZJRFphZE94S2V1aVdYQm14TXNiTG1O?=
 =?utf-8?B?c1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41D8080CD9E22449BBEC4B75105D1993@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1C3Uuq8t80iOigS2/bT5IWj40Gt0KvN3HO4VBC6oTc2bna+OOuxVlX1xZ3d/ThtovLu2p287sH9W8s3oGRxStpwjVWCPe2B9rrQ0D1IY74sQm5zDE2D8pXjBbROE4FkTPmY8pIErw7dABEmlxwByh5sYizNVkQxvKnig3VafAOWCboHlX1WuCFDl4uCXQSR2a0+AWiHKLWVJ9EONoEYe5I4zxYi9DzCALB1KnUWrN+HfaAfsa4HNZFmwgSpFQD+qM9bX2/M+wm1hOtozJbpvhm+4DDLw6NWh4iHMHd+P7F8CfS3e+jHd9E5WK83qMXXN6hEzYjFqEfR4Yt+eswcZE2WKvZFo4+yxjOo6e6nc5zMeQ5GGIXtaALrlIi5d95lzobl2R5g389QbtfaNIBQqQEFRGwOLV+dQtPRr7pHH72r4ZPI1g/8qYY8IOhEItC7S8PELLFuCAfPGtO9jRfny5mIwjv01rhrPJpVLFNyFJHNw8fXDXv8Lz96G1DDXD+zdkyEHZpnamK0DjqGS+RAoy84pEsmadrui+a2T2+vh15Ex+qil1QLD5dq8QzKiBohwDRixeRvu+lYasrehEVWy/A4/rk3Ft1vB20tfevPKLlY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36530bca-3025-47a5-3c13-08dd0daf3539
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2024 00:13:51.9784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vHhCExH/+0SQjGtLEvPcpx6nutVPtQ9UGq1HzhD4YazZPAQ8fb4gSPFkXCUs5vz3HmVfDUDT5ox1kRb82IXHhQNveCU+LdkIftCuNZAZ8rU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7959
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-25_15,2024-11-25_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411260000
X-Proofpoint-ORIG-GUID: YW2KJ2ZNsRflZ_GxX_weu12JAx_wFXTP
X-Proofpoint-GUID: YW2KJ2ZNsRflZ_GxX_weu12JAx_wFXTP

DQoNCj4gT24gTm92IDE5LCAyMDI0LCBhdCAzOjQ54oCvQU0sIFJvYmVydG8gU2Fzc3UgPHJvYmVy
dG8uc2Fzc3VAaHVhd2VpY2xvdWQuY29tPiB3cm90ZToNCj4gDQo+IEZyb206IFJvYmVydG8gU2Fz
c3UgPHJvYmVydG8uc2Fzc3VAaHVhd2VpLmNvbT4NCj4gDQo+IFRoZSBJbnRlZ3JpdHkgRGlnZXN0
IENhY2hlIGNhbiBhbHNvIGhlbHAgSU1BIGZvciBhcHByYWlzYWwuIElNQSBjYW4gc2ltcGx5DQo+
IGxvb2t1cCB0aGUgY2FsY3VsYXRlZCBkaWdlc3Qgb2YgYW4gYWNjZXNzZWQgZmlsZSBpbiB0aGUg
bGlzdCBvZiBkaWdlc3RzDQo+IGV4dHJhY3RlZCBmcm9tIHBhY2thZ2UgaGVhZGVycywgYWZ0ZXIg
dmVyaWZ5aW5nIHRoZSBoZWFkZXIgc2lnbmF0dXJlLiBJdCBpcw0KPiBzdWZmaWNpZW50IHRvIHZl
cmlmeSBvbmx5IG9uZSBzaWduYXR1cmUgZm9yIGFsbCBmaWxlcyBpbiB0aGUgcGFja2FnZSwgYXMN
Cj4gb3Bwb3NlZCB0byB2ZXJpZnlpbmcgYSBzaWduYXR1cmUgZm9yIGVhY2ggZmlsZS4NCg0KSXMg
dGhlcmUgYSB3YXkgdG8gbWFpbnRhaW4gaW50ZWdyaXR5IG92ZXIgdGltZT8gIFRvZGF5IGlmIGEg
Q1ZFIGlzIGRpc2NvdmVyZWQgDQppbiBhIHNpZ25lZCBwcm9ncmFtLCB0aGUgcHJvZ3JhbSBoYXNo
IGNhbiBiZSBhZGRlZCB0byB0aGUgYmxhY2tsaXN0IGtleXJpbmcuIA0KTGF0ZXIgaWYgSU1BIGFw
cHJhaXNhbCBpcyB1c2VkLCB0aGUgc2lnbmF0dXJlIHZhbGlkYXRpb24gd2lsbCBmYWlsIGp1c3Qg
Zm9yIHRoYXQgDQpwcm9ncmFtLiAgV2l0aCB0aGUgSW50ZWdyaXR5IERpZ2VzdCBDYWNoZSwgaXMg
dGhlcmUgYSB3YXkgdG8gZG8gdGhpcz8gIA0KDQo=

