Return-Path: <linux-kselftest+bounces-26949-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF29A3B6B4
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 10:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B76F7A704F
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 09:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EFD1DE2C0;
	Wed, 19 Feb 2025 09:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FAum7mu+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I2MAGAp/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6931BEF77;
	Wed, 19 Feb 2025 09:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955846; cv=fail; b=gTHG5NKZMaIQBFbc+zbm8cGx3ZY1vlTYE1I2km/ImAtUCOkGZ0amjipRzKAPJcwPHY272t/HPq8ABZ89nU1o3kTVn3cObErMH7nSMO0KieCz0d6wYSwKLqR7EBFfsejMWiavPOrjLOpbi+wtsdecJnK+pg4YvAFZwGkLxsL+6D4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955846; c=relaxed/simple;
	bh=89NIgvF7CWRKYBGts/so4m4Jl3y37n7005XgETEPEKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rokGIjZf5/L1Ak1TkwTXAhhSW5zfKyODvfbHN6B0E1Ry0GZUoPFuIMqbhws/LHb+ORfRJ2KRDcX+X9cFV1ar/uMLaPv6vg88NZZhVClhHBQgW1mGk/Z3usk5Hj/dmIgIEk5rVsJO/XYJyf0KyKwkmCVbXvswXbFNmxce/bCnzms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FAum7mu+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I2MAGAp/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J1tWFl008310;
	Wed, 19 Feb 2025 09:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=NmLOyVAe3ZECNfsJesdWPYaSu27U3xJD1kps8b4YKqo=; b=
	FAum7mu+fbdGFBe5Bur7QVtqpqetJ/M8B0T5UdEczPdCeZHHTvikIWlu34KYgwng
	Vyx+nsY9B8J5Gj8+pXp7P5kRWUayhzweHkt6XXHPyj/zs2RIr3U5QGCLymipoOsf
	6q1MsqgT/eBlr5H9Gubr3rJufRCNMqsk+HNSdU5q0qVEfNVFzIozr8ktqcuV0axb
	0x8r9EqhLokmiPhNhCvpy4Dujj4c7G4x+w2zcg7gKxDQmX+sFoVj7XDmDye67Erf
	2JcTMa9Bl5KVFZRZjyHr4CNraxmdVPCvrjju8CSTA35h4JqQ9sDkhk3pwbWI5pxd
	LejLQYEbeVN22Lsb8cuZgQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00kh661-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 09:03:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51J8Kirs026208;
	Wed, 19 Feb 2025 09:03:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w0snpbd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 09:03:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNFOGlPJe1sb6qzKsjoptzlmvUDoFU0Q4R/zTMYH8+Wz5nehXaBPk5aNfj3+m4OQ24yJrIQzRfjwRUmWLduOHv75t/y1yx/hIJGMP5BCJMZpYrF32TzJKYvbEy3dVEodjzncSVRV77duCiSTHPvyw6Ut+3RS/5F9weKvnZ6mVBROMSS70kYnB+CCnG5kcw+y/vNkIW5GF1kIFDojVuOLM4i2NSlIswxm2/IQrZ+6ct9nsBs2GKuNGkY1ktcqcYlcEIOtGvlmsuXVjqzPdl6iy9/kziRrHm1+mfQdiKG2PxsdPntpSZoa7m2t7W7quD8Ut0EwUXT78OQtcG5ZHFL/Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmLOyVAe3ZECNfsJesdWPYaSu27U3xJD1kps8b4YKqo=;
 b=C4+BK5BpGmuQS4RNPVQMf19RilQ3WHwkjmF3UwDJCMGWLmva4Ernb09t1wCt0+49qEtguPqd5ZRLZ+uiNnEOLfW4ua3bVoWtRXom2bucfhc7cF+7eFUQ0Fqjgc5vQg9k7pr1im6THWBIUoShOpi+8HoiKpKNqh6TkVOxQxyu1VsPcEaR14u/dYvU7wGdsO+9yrKDYPv+80McFoAfo4pYXEWs1WHkeU7aNkH5ByTkM/26ZRos6j/XhRsgcUXmQlZlDccKv2wMzsr5ekMHMvwt0PNrFSb9e7ch9PmvP/GLA7izNrUzIMCzVrm4poMDWjILqPsrLttRS802IJMLyckI1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmLOyVAe3ZECNfsJesdWPYaSu27U3xJD1kps8b4YKqo=;
 b=I2MAGAp/RhYpmqvJn3C1H+THuUsc5ouU24n7xY98qHJIPUMArCKrFJgYcBU/J3PMEr0SdEu91uOwdD9xaneiCHs/h7Nuey71G9qeTS0QT6enHqFPvy4Er2Eu7Z/f6ACImzOzhAW5Zoo+1QKraExklInjC7twH/Z8DHcxEwfdi2w=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM3PR10MB7925.namprd10.prod.outlook.com (2603:10b6:0:46::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 09:03:44 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 09:03:44 +0000
Date: Wed, 19 Feb 2025 09:03:41 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>, Juan Yescas <jyescas@google.com>
Subject: Re: [PATCH 0/4] mm: permit guard regions for file-backed/shmem
 mappings
Message-ID: <45297010-a0a4-4a42-84e8-6f4764eab3b3@lucifer.local>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <CAC_TJveMB1_iAUt81D5-+z8gArbVcbfDM=djCZG_bRVaCEMRmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC_TJveMB1_iAUt81D5-+z8gArbVcbfDM=djCZG_bRVaCEMRmg@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0241.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::15) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM3PR10MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: 65195a17-ef39-4672-b9e6-08dd50c44fc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTRVZ2tIWkN0VVFTSkNaQ1Z1U2J2UC96RnBNMnJWSVB2UW9rV210dUVtcFE2?=
 =?utf-8?B?QitkbTQ0VmI2U3FKeFdBZlNnZldjc1Ara0ZQdURGRW52Q3RLK0NGK3ZQbXYr?=
 =?utf-8?B?QUl0OWdQY1BzOUtZNUQ2dG8rd2QvNVBIN0J4RFVaMHUzdlVzK3h0MDdiS20r?=
 =?utf-8?B?TllKOG05T0FoM1BLQmlUMzFzM1dUWnlBZFlYYm1Gc0VlQklUSEpjLzduSFJ5?=
 =?utf-8?B?ZGVzUHRFcjUxdDZoSzR4cS9aQ3VGaENhbGJWVVJKaFpLbUg1N2Vwek94a2w1?=
 =?utf-8?B?SjlKVU1wOFp0Q0VHcUVqalVScXNxTFpVQzYyVFRmbzJiR2NlU2x5NlBmUHBY?=
 =?utf-8?B?SW5FTzlYNTNFSWJIRDZHRWJaQXhnQTBPdmxwSDA0K1llVDEybFdLZy9FV0ts?=
 =?utf-8?B?Rm5wNjdSU2VBQU9XR3p0RFpiZEk3VXI5c1d4QkhTNTN0UGJ6c2twb001YWpa?=
 =?utf-8?B?UUMyaDNCY0k4a3NiZUJ1T1hJcDdSWE1aaXp5cUpuZ2M2UGRrWk9YSGRJaWcz?=
 =?utf-8?B?WXZPaVhHdDFuYmw1ZndLM3NsemQ1dDA1MnIwOUVIZjZZMy9ET3VCTHpwM3JG?=
 =?utf-8?B?OXU5NG9kTFE3TXdlSm03Vkgra21oMy9CdjFCZFRzWHE5RVFOTmpzaHBWM3po?=
 =?utf-8?B?SzNXeWxwNzRZVkFXckd3TG5ob2lOZS9lSUpoSmJLTmZnT0Rtc0pnczZ5OEh1?=
 =?utf-8?B?djl2ZkJJY0FkTmtzOThvN3lLYmlyM1NybFVSVTNXcVR1c2VhWHVDdTZTY3pa?=
 =?utf-8?B?WHN2eTZCejU2Unc0SnhQZDJ4ckdFbUEvVW1oeVhUTWhiU0xIUVA2NHB5L1pX?=
 =?utf-8?B?ZHFFbjlCai90T0JabmpNL3pleXJZUklPaUFvcXowVTVQTUhjdCtkazFhbzAy?=
 =?utf-8?B?MHRySXU0dXNuaW44a2xHVnhkK25VMGlqTU9wREU0a2hwZGRSRHZHV0laN3dS?=
 =?utf-8?B?U1BlblI3eHU5dkVudm5ML3NieExmV2tVeElFZ3ZJMEdmdWhIZXVVNHlTNjhS?=
 =?utf-8?B?VGdUeXRCMWsvcTJncTBGd1VkMDBFV3M1cE9wUFZVTGtaaENaUHdCVTc4NkVY?=
 =?utf-8?B?NlNZSHllUS9SUDlRODV4T0dCaTR5Sm5mTW1rZENyczdYTGxwbHZYVnh5T2NN?=
 =?utf-8?B?cGk5ZHl6cWFlcWhheGtDWHA4NHdYM1pTamxGeWp1dXZwcnB2Um95eXBNRU8y?=
 =?utf-8?B?RWNJbm5pWWFPWUszWTZPSy9rNFJOMW96UHBXa0lTV0x4TGQrVmlsS09PVkNh?=
 =?utf-8?B?QUptVEdlZHZreDIzalpSTTJtaG4vWTVjUG9BelFUWTExQmlnRkhDSFRPdXk4?=
 =?utf-8?B?TXNVdUh2VWF2eE9LSGd6V0MwL0RpbHJ5UWRpSldNQTc3ZzBySXl2SW9wVTJS?=
 =?utf-8?B?UFVjblA4aFNQaUkxZWM5WW9GY0k3Y0RZUmZlV0hCQlJkUUtlNCtPVHRPbDlk?=
 =?utf-8?B?N3J3MlM3emVaTW4xZ3Q2V1JNUWNjbU5HNHdmQm5Udk5NNlZHcndaZUFXdWtR?=
 =?utf-8?B?a3QrMzB6WEFoWlFPZU1PZDNLZ043R2tJT3pwdzdmQlF0MWJ4L0dFZWtTTWoz?=
 =?utf-8?B?cWU1eUJOWFhULzNtZFV6emxuVjFvSkpKeVdVZnFMbHl0R0JWa3JsYitVb3FK?=
 =?utf-8?B?SkZKRDVKWXFveWFXQmxUVFMyOGlrNTBiY05ISlFUWWJHb2RjNVN6c0xuTkZC?=
 =?utf-8?B?Rm0xcUFaUUdlUjRwQkdJZG10SUNxakVESFA1OXk2a2c1Z1ZlLzdLZFFvQ01i?=
 =?utf-8?B?QytmQ2ErYVg5aWxsQXhTOVVYODZ5cXJUUDRwMVo5QVJUTkt1RHJNRXZQazg0?=
 =?utf-8?B?SFY2SER2T2dGczFXUGYxY2pEZXFqZWpnMDZNeFhNT3ZUcERXSlh5M0s0SEdi?=
 =?utf-8?Q?jOMDyPMGbaIgp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eW5TdTMrMytJSWFBVnZiNnVDV3JlZ3c1em83RFFnSGFHR21wakxSbWdtZGR4?=
 =?utf-8?B?cHUyZHp5cTl0V056Z0hjUXlxRkx6RDRvZVhhcWRJSmFpMUVtQ1dYK0tGYmpy?=
 =?utf-8?B?ZUNYTUJ1K0FiaFJBZ3lqSUl3RWgwN3drT0dnWEN5T01wemNqaUpJN0JHaXRC?=
 =?utf-8?B?MFV3ZTl1UlM1dUtaMzhCZHlGSTkybXpKTThuMHBRZ2Q2ZmhEdFFkQjZKcUdx?=
 =?utf-8?B?QW9FVUd1MXdxSjVyRjZZZmNDSWZ3L3BTblp0R0xrRmpJZG5relVjSXVhVFdi?=
 =?utf-8?B?NXVpaCtlN2hQY0J4WktKS3VlN2Y4QjgwNFNHTTlWeng3YUc0Rm41Ris3N0wz?=
 =?utf-8?B?alBlRUFKWmx6RW1idTN5NnFrTkF5SGF4K2MzNlhpWFpmWDdZVDB4cjhsOFNV?=
 =?utf-8?B?NEt5clpKNThsK0RvT2gxRVZybkNvdjJjL1RxWExUME8xMkhtZE54OVFTUkVt?=
 =?utf-8?B?WFI5VEFYa2RySGlwU3FGbFNuVnVCNEFiZ0VKRThIQ3dsSUhCQVNvRW4zQ0NH?=
 =?utf-8?B?bEdwRENVdG9yaDQwNmg0SFM3UFp2amtqTnZicEpZeXA1SyswZW5sSkNsK2xa?=
 =?utf-8?B?NTl5bkttOURHZmlNV0xWR2Fscm1WVUlDWElVV2F0a3czdURoSFhaMmt4eXpB?=
 =?utf-8?B?T1g1Z3dRY2tXZlo0d3FXVE9XRWdZSGlQYlVYaWZ3MFJhWmlIMFBSWnZRYzkz?=
 =?utf-8?B?Smt2R1VlalJuYUg1ZUZ6UTgrTmpwRVVJUkw3VkZZZTNyRWFQUk5Sb3R2dVBS?=
 =?utf-8?B?STJST0YzdnhOeXQ2L1VXN21CTjUveldBNTZSZ2VzdXpad3U4UlhQR2RRY2p2?=
 =?utf-8?B?Ky90WE5zSy9tSTd1STM3TDhaUm9lcmwyL3VHdDdSRGxPZ3NUQUtPb24zQWpT?=
 =?utf-8?B?LzY0UlJGdHVuVHNBNFdlUC9rQnhSbWgvbUF1K01vUzF4SFVVV3duTXdrK0M3?=
 =?utf-8?B?MTdOeHdTM3NVQjBlMVU2ZlA5Qmk2VzlMZmd4amw5Y3M1N2VXWVBZRWV4ZkU0?=
 =?utf-8?B?SG9MUk1IZUFjSGl1cXFkMXFnR2ZVNXhtUkM5ZFVKTmZvbDl1OEdxekJDVTdi?=
 =?utf-8?B?Tml6bkhkS2tLS3RtQW03ZlNlRndjYTZ1U0JwYUw4UThLVnd4OWxLdVNYQldP?=
 =?utf-8?B?ZGphbWtOa1JOT1NsQndaeXNuVjA2bHY2VktSOHlyOWNRbXZsRlFEdmJ4aHlv?=
 =?utf-8?B?QXM3S0txLzNzbjhkTC9sY0JaemM2YkxXYkdmOXdqWE1ZVG9EajlSSkNwVmtL?=
 =?utf-8?B?c1JmNFpDYTVTVFNob2xjZTAxZ1QxRzFHNlhKeFFubFYzSjdkSGZZOHl0VGsw?=
 =?utf-8?B?dWs5RldORzZwSE53YlFCa0FZRjh3YlJYbGNwU2dhaGxJN3MxZVNja1pySFN0?=
 =?utf-8?B?K3JndWQwcER1bzRvUVBSTVhDbEtlUjhmSW1zWnFDYlhQayt2eU51TXdRREdT?=
 =?utf-8?B?WncyZEhkbkNCQ09TOEJNRnR3MXlaaEpkUmdYUnN5LzNwYStVOEMxV2FGemcw?=
 =?utf-8?B?Rnc1d29BYThXMk85L2FyVXc5MS9odVhOZjBweER1dlBLdnFDNVBaRXR6N1Nk?=
 =?utf-8?B?Tk9yK3U2RnNsZ05VSkdybkNiQ28zcnpGMHhzL013SXNrZW5VOXNWWnNTajkv?=
 =?utf-8?B?OFpoR2ZGK1l1NUlXbkNlNjkzSUpNQzViS1kvajNvWXJmWWFPTmVDdklwUkIx?=
 =?utf-8?B?Y0psUFZqTVRHY3VncXhETlh1UVhEUEk3dzJlc3FSbzJYYThyalhZNUkxQU5h?=
 =?utf-8?B?bERWK0Z4TFprditEay9mRFNIWkVJZ2twMUtCaHVqeEVWOENTSGVqbjBBZjBC?=
 =?utf-8?B?UDZxZ3hJaG5EU05paFZTZzNkNmZXR2lzYXlWNUQvQW1IT0JoQWtOR1ZhZTNC?=
 =?utf-8?B?ZXZ6SkdzVnFEZUVoV1YwdkNjbmhoMjdEcWVRNlZMcFFDb1RuSER3eTcyUHg3?=
 =?utf-8?B?ZFNINGlpTjNwVFQyS3lUWjVuN0ZCRVozRE1vSUwxWGNjRnl4QytRRjlOajVz?=
 =?utf-8?B?eDBuTGxwWnplbVJoVUxnZitnYThFNWpLdVJsS2FzbkZlaDVTTHdJbHlYeUpB?=
 =?utf-8?B?RVEvOXhlUzc2NHl5OHdiV2s4V0RSTEdEODVGU3pMVTdVTnpVOXZjUkZ1S2pT?=
 =?utf-8?B?OVRzTHkwWkJlRUJVT0I3R0Fnai9FUUZJNU12cnAzdmJNV1p5WVZBMUJjRXl6?=
 =?utf-8?B?bkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cFLq1FV+BeMZxXVQ9zWE/ZYpcmuGwbNpvOj+CDet+6Pxd9/5jlqSzGbu6bbn9HCtXrOLzQ+EwSjm/MOo3EvXrFUTmxBK+rQBceCENiIMi9PpB1lYKoWgcuAtLesvEgJ+8zrUoY8Rm29dsOM6+oVLjVOVbp9HvxQJtqagy+65G2dkyHxkrYok2In/SaSdl2bNyCw08g/kNeVLcKYp6BN7t14a1dDlPnFlczjEH3nZWjYean2oWtG162nzNADWfZdlZ9DTsDChS54tn0ZztCg0uvma5xUxYXI/+KjnhaDdu+cQhWBLPgYdqrf2y6ZmuqqQo5LxAQWuBXc0TZwcCKeu44UYfG2B1HQdlx5GWPKSsJTjPx5gq28WSVpFbVx5scl2U9q0HVbdGBSEMHtNiEfij7M9j13jMysAw38LWjuChU+yya5YooHokSc8LAO4RIk+qDciwxXo4SKm6H+sBT6xiUem0NzKI0+O60Bs5XUOdN4sCE4Les7az901T+lJdI98GcZ5iTaCydXF9nAlYr439XQOgfg3Jm+15kaOSzeGX8yI6pYYTVsiLzupySF3zoAdNDIjVr6NKp6hj86KcsC7ttcESuBJ+otuukPFE2SsYhs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65195a17-ef39-4672-b9e6-08dd50c44fc7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 09:03:44.1463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbq6DVRTDgvVwF9fYYw816EG5Hg1VcXJm/vPv4NcIMQ4Oj1pk6bi/1qy/waBqYC7szNPlTK/aWRw08WviDaXehKAIz8FtxstvlVDMECVv60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7925
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_04,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502190071
X-Proofpoint-ORIG-GUID: 9a9WUOJTg91_elldYP9RCR6b1MrZwcVW
X-Proofpoint-GUID: 9a9WUOJTg91_elldYP9RCR6b1MrZwcVW

On Wed, Feb 19, 2025 at 12:25:51AM -0800, Kalesh Singh wrote:
> On Thu, Feb 13, 2025 at 10:18 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > The guard regions feature was initially implemented to support anonymous
> > mappings only, excluding shmem.
> >
> > This was done such as to introduce the feature carefully and incrementally
> > and to be conservative when considering the various caveats and corner
> > cases that are applicable to file-backed mappings but not to anonymous
> > ones.
> >
> > Now this feature has landed in 6.13, it is time to revisit this and to
> > extend this functionality to file-backed and shmem mappings.
> >
> > In order to make this maximally useful, and since one may map file-backed
> > mappings read-only (for instance ELF images), we also remove the
> > restriction on read-only mappings and permit the establishment of guard
> > regions in any non-hugetlb, non-mlock()'d mapping.
>
> Hi Lorenzo,
>
> Thank you for your work on this.

You're welcome.

>
> Have we thought about how guard regions are represented in /proc/*/[s]maps?

This is off-topic here but... Yes, extensively. No they do not appear
there.

I thought you had attended LPC and my talk where I mentioned this
purposefully as a drawback?

I went out of my way to advertise this limitation at the LPC talk, in the
original series, etc. so it's a little disappointing that this is being
brought up so late, but nobody else has raised objections to this issue so
I think in general it's not a limitation that matters in practice.

>
> In the field, I've found that many applications read the ranges from
> /proc/self/[s]maps to determine what they can access (usually related
> to obfuscation techniques). If they don't know of the guard regions it
> would cause them to crash; I think that we'll need similar entries to
> PROT_NONE (---p) for these, and generally to maintain consistency
> between the behavior and what is being said from /proc/*/[s]maps.

No, we cannot have these, sorry.

Firstly /proc/$pid/[s]maps describes VMAs. The entire purpose of this
feature is to avoid having to accumulate VMAs for regions which are not
intended to be accessible.

Secondly, there is no practical means for this to be accomplished in
/proc/$pid/maps in _any_ way - as no metadata relating to a VMA indicates
they have guard regions.

This is intentional, because setting such metadata is simply not practical
- why? Because when you try to split the VMA, how do you know which bit
gets the metadata and which doesn't? You can't without _reading page
tables_.

/proc/$pid/smaps _does_ read page tables, but we can't start pretending
VMAs exist when they don't, this would be completely inaccurate, would
break assumptions for things like mremap (which require a single VMA) and
would be unworkable.

The best that _could_ be achieved is to have a marker in /proc/$pid/smaps
saying 'hey this region has guard regions somewhere'.

But I haven't seen any demand for this and presumably this wouldn't help
your imagined program?

I don't really understand your use case though, what programs would read
/proc/maps, then... try to use /proc/$pid/mem or whatnot to arbitrarily
read regions? Such applications would be in danger of SIGBUS in any case if
they were to read invalid portions of file-backed mappings, and have no way
of knowing this, so they seem fundamentally broken as it is?

>
> -- Kalesh
>
> >
> > It is permissible to permit the establishment of guard regions in read-only
> > mappings because the guard regions only reduce access to the mapping, and
> > when removed simply reinstate the existing attributes of the underlying
> > VMA, meaning no access violations can occur.
> >
> > While the change in kernel code introduced in this series is small, the
> > majority of the effort here is spent in extending the testing to assert
> > that the feature works correctly across numerous file-backed mapping
> > scenarios.
> >
> > Every single guard region self-test performed against anonymous memory
> > (which is relevant and not anon-only) has now been updated to also be
> > performed against shmem and a mapping of a file in the working directory.
> >
> > This confirms that all cases also function correctly for file-backed guard
> > regions.
> >
> > In addition a number of other tests are added for specific file-backed
> > mapping scenarios.
> >
> > There are a number of other concerns that one might have with regard to
> > guard regions, addressed below:
> >
> > Readahead
> > ~~~~~~~~~
> >
> > Readahead is a process through which the page cache is populated on the
> > assumption that sequential reads will occur, thus amortising I/O and,
> > through a clever use of the PG_readahead folio flag establishing during
> > major fault and checked upon minor fault, provides for asynchronous I/O to
> > occur as dat is processed, reducing I/O stalls as data is faulted in.
> >
> > Guard regions do not alter this mechanism which operations at the folio and
> > fault level, but do of course prevent the faulting of folios that would
> > otherwise be mapped.
> >
> > In the instance of a major fault prior to a guard region, synchronous
> > readahead will occur including populating folios in the page cache which
> > the guard regions will, in the case of the mapping in question, prevent
> > access to.
> >
> > In addition, if PG_readahead is placed in a folio that is now inaccessible,
> > this will prevent asynchronous readahead from occurring as it would
> > otherwise do.
> >
> > However, there are mechanisms for heuristically resetting this within
> > readahead regardless, which will 'recover' correct readahead behaviour.
> >
> > Readahead presumes sequential data access, the presence of a guard region
> > clearly indicates that, at least in the guard region, no such sequential
> > access will occur, as it cannot occur there.
> >
> > So this should have very little impact on any real workload. The far more
> > important point is as to whether readahead causes incorrect or
> > inappropriate mapping of ranges disallowed by the presence of guard
> > regions - this is not the case, as readahead does not 'pre-fault' memory in
> > this fashion.
> >
> > At any rate, any mechanism which would attempt to do so would hit the usual
> > page fault paths, which correctly handle PTE markers as with anonymous
> > mappings.
> >
> > Fault-Around
> > ~~~~~~~~~~~~
> >
> > The fault-around logic, in a similar vein to readahead, attempts to improve
> > efficiency with regard to file-backed memory mappings, however it differs
> > in that it does not try to fetch folios into the page cache that are about
> > to be accessed, but rather pre-maps a range of folios around the faulting
> > address.
> >
> > Guard regions making use of PTE markers makes this relatively trivial, as
> > this case is already handled - see filemap_map_folio_range() and
> > filemap_map_order0_folio() - in both instances, the solution is to simply
> > keep the established page table mappings and let the fault handler take
> > care of PTE markers, as per the comment:
> >
> >         /*
> >          * NOTE: If there're PTE markers, we'll leave them to be
> >          * handled in the specific fault path, and it'll prohibit
> >          * the fault-around logic.
> >          */
> >
> > This works, as establishing guard regions results in page table mappings
> > with PTE markers, and clearing them removes them.
> >
> > Truncation
> > ~~~~~~~~~~
> >
> > File truncation will not eliminate existing guard regions, as the
> > truncation operation will ultimately zap the range via
> > unmap_mapping_range(), which specifically excludes PTE markers.
> >
> > Zapping
> > ~~~~~~~
> >
> > Zapping is, as with anonymous mappings, handled by zap_nonpresent_ptes(),
> > which specifically deals with guard entries, leaving them intact except in
> > instances such as process teardown or munmap() where they need to be
> > removed.
> >
> > Reclaim
> > ~~~~~~~
> >
> > When reclaim is performed on file-backed folios, it ultimately invokes
> > try_to_unmap_one() via the rmap. If the folio is non-large, then map_pte()
> > will ultimately abort the operation for the guard region mapping. If large,
> > then check_pte() will determine that this is a non-device private
> > entry/device-exclusive entry 'swap' PTE and thus abort the operation in
> > that instance.
> >
> > Therefore, no odd things happen in the instance of reclaim being attempted
> > upon a file-backed guard region.
> >
> > Hole Punching
> > ~~~~~~~~~~~~~
> >
> > This updates the page cache and ultimately invokes unmap_mapping_range(),
> > which explicitly leaves PTE markers in place.
> >
> > Because the establishment of guard regions zapped any existing mappings to
> > file-backed folios, once the guard regions are removed then the
> > hole-punched region will be faulted in as usual and everything will behave
> > as expected.
> >
> > Lorenzo Stoakes (4):
> >   mm: allow guard regions in file-backed and read-only mappings
> >   selftests/mm: rename guard-pages to guard-regions
> >   tools/selftests: expand all guard region tests to file-backed
> >   tools/selftests: add file/shmem-backed mapping guard region tests
> >
> >  mm/madvise.c                                  |   8 +-
> >  tools/testing/selftests/mm/.gitignore         |   2 +-
> >  tools/testing/selftests/mm/Makefile           |   2 +-
> >  .../mm/{guard-pages.c => guard-regions.c}     | 921 ++++++++++++++++--
> >  4 files changed, 821 insertions(+), 112 deletions(-)
> >  rename tools/testing/selftests/mm/{guard-pages.c => guard-regions.c} (58%)
> >
> > --
> > 2.48.1

