Return-Path: <linux-kselftest+bounces-18305-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88087984895
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 17:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 140481F2251C
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 15:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2D61B960;
	Tue, 24 Sep 2024 15:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gJKJkRPl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CoPhbYro"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413271E48A;
	Tue, 24 Sep 2024 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727191551; cv=fail; b=iGGGQI/U6MuA6Y51J3Yms6iJ7Q/64gnVQpsbwIJKVsMt46AVoRNUc0gpEcWjDfdZhCcXQzfo7uP0tRwy2ZSfj8IcASPH3inliafxlFBUiCHwmGOLvsFepntAZkFUpHqsbXyPyiPatp4Eeilc/BT7GGJneDYMP56ibxAwppN70lU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727191551; c=relaxed/simple;
	bh=E7XRUUCM5MOvXcjhlIUtbxk0FLZcucRdnT/ga7RFpLE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XmMOO9yKVP4DzITg/rpPfD2yf76l3ecamsdEQCENRIPuJugzPNtrCzEyqGxrwfwDw6/WA5GxcL/hPxriK5GZuyK7XGS33qhOCZ7FuNIVI2VkBZ8rTJoDtBifR1T8S8GdGoshbMyNlZu9U6td9ADR2n1OZpsdYtKMhFBLJ0ZPOnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gJKJkRPl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CoPhbYro; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OEQY43012951;
	Tue, 24 Sep 2024 15:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=E7XRUUCM5MOvXcjhlIUtbxk0FLZcucRdnT/ga7RFp
	LE=; b=gJKJkRPlcn8C/R6PaLna5RKGC2oCmKuQLiIZ27O/Wh0oQ9h2YsL8rlCcA
	Qnp8EUHGWWP3vniQz+zfXKffUzUX49WHupqQIHUKCgAWc5Wn3hs/fK1iv4btETcB
	64o97csN0/uMltiv5K7A2lCvXjp2zlqYAQRm8j5K0JffQ08vaMFqLcf10QPYLwwp
	riTpXVvXPiLz7LB787OdKhF8EKOkv3Y0J9EtzUQ8o8qlF1YYEex47ynd2crJK8s9
	I3ngdIkmAXbECISbO2cl10GiVmnDvuNTrzIMyMJkv9CUAIQYBAmcLsAValXVPlRC
	dALlhaPdr6gqh9bMrqdThgRpnYfLA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smjd5a52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 15:25:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48OFBZJd028224;
	Tue, 24 Sep 2024 15:25:35 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smkfnp84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 15:25:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPLVIvCzz7EtRy1jvpBgvjsDkSg4WvOKlTWN3UjxUrLbOj0eRgTwjE2A8B1XjyAW4WGyx9QAstC+roT8nxP3VLZnWlAyerdSELzP+TpBo+r6zkVIoMJYeOoYK91rYBRYukuVvhQ9/fGQoIpCw7PQ+31WickwNAst8xpBC3EjdFddL6PF9F75rVyCML4gKxhJ1MBOSUyvAkR+7D4bSsiunErfB4e1cRumOKDSTD0a4XqSlHJNlL3P2ELYoGXiZSK0OmTt7BHapKAmVhQzJFXKDFyobBr3KXvswFH+bxeObNroEDhtUHoxnQB3Jd3u4Ma5Ddu/pRbrEKHJMtjkki2EzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7XRUUCM5MOvXcjhlIUtbxk0FLZcucRdnT/ga7RFpLE=;
 b=hrW/IQKY01UZvKiUMdvtMDO7fMvYwi7x7lSakQ3cD1uUlbWY4Ck2ZHro+rLWz0/HR4E9T1I2fhbJMQAkhm7s6d0zeKlG686RU0LfNh2Mv7USI2Zi10RZVvQiVGG2M+7c/yI0b/gJYSJxM7CTOzNMHoZsB+rlZL8pdBTCkc+rfnBR7WmCfU8DY6MSX8+E7obX2G0Ku2tkjGC3YWZsozbaZxfAH5vw+Dds5KmNyqJwv6wWbBc6u0fN2ybujoykb67c3Zp/2QU8zlIIufrjVqOWoNonS+HQVxtfQ3LP2w4vGa4HQV8Y9e+/ukZFgyXuJsqBVFqeJpNAyVMHBbXyE6fLFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7XRUUCM5MOvXcjhlIUtbxk0FLZcucRdnT/ga7RFpLE=;
 b=CoPhbYrocunxO9CHaRGOo9BlkFjaL8l6XLR0Vp2u1QFgHeBXLly4M2uAjut4FpUav0dNLGFoDImpNEbGAQzDGu+HO/iJwBbK3y1CLnFG2OonNRDkTpGQvVNameXkVTJcR+y/4IyWPu0XZnEz5kX95QMJV5QK/bqTcaTBx3OHHMU=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by CH3PR10MB7211.namprd10.prod.outlook.com (2603:10b6:610:125::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.7; Tue, 24 Sep
 2024 15:25:24 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%7]) with mapi id 15.20.8005.010; Tue, 24 Sep 2024
 15:25:24 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "kees@kernel.org"
	<kees@kernel.org>,
        "javier.carrasco.cruz@gmail.com"
	<javier.carrasco.cruz@gmail.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>
CC: "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH 2/4] selftests: rds: add include.sh to EXTRA_CLEAN
Thread-Topic: [PATCH 2/4] selftests: rds: add include.sh to EXTRA_CLEAN
Thread-Index: AQHbDoAtrtfGNOL6DEaYyAMUrCy0VrJnDvAA
Date: Tue, 24 Sep 2024 15:25:24 +0000
Message-ID: <d6a24c2862535e00c9294e6c7d1f90354c992d72.camel@oracle.com>
References: <20240924-selftests-gitignore-v1-0-9755ac883388@gmail.com>
	 <20240924-selftests-gitignore-v1-2-9755ac883388@gmail.com>
In-Reply-To: <20240924-selftests-gitignore-v1-2-9755ac883388@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|CH3PR10MB7211:EE_
x-ms-office365-filtering-correlation-id: 8a96ec48-e229-4875-be0c-08dcdcad1c75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NElwYXFFT2tYYnI4M1JlUUppUlM2T1BudStVNnBmU1hoTWU4THNBOUw0R3Fl?=
 =?utf-8?B?TFJsM3ZEUktLQnIwdnh0N3V4R1hsWDRmaEs3TUhCM1Y3cjcyeTJVZnBvbmFS?=
 =?utf-8?B?Tk1YRXU1ZmR3d29ZSDA4ckdhejNDQ3VwZnN3NkZwYVFGNk9ucXlLVnl5SGhP?=
 =?utf-8?B?T1pVK3BtYUg2V1pHK0tFQUpSQzlQdTdXRGVaaHdUbTZwZmpXOEU3WVpQZ05h?=
 =?utf-8?B?QmJ5NHBlL295V1BYeWt2ZmRwTzUydVNJQVF2eFVBRm45NnhYenlnYkRnRU5z?=
 =?utf-8?B?N0dLWlZlR2F5UDdEWWhZdkkxUGJqaHJtbVdjL08xU1haeUNOUlpkSlhVemh5?=
 =?utf-8?B?dGRzOWlmYVZyTWJKdGtCY0I3NHQxajEvTTNGVVhqZUtmazR3R0hxTDYrNWlI?=
 =?utf-8?B?TW91SEVlMEdNbU9Qbmg5VTQySWRFRlhVMVVGdlgvY2did0FsZmZlMEtxQlJn?=
 =?utf-8?B?WkVyMzROZEUxWXlhS3YzMEtwTnhkWTY2NS9uQm5wTmVyRkF5TlJ1MmtKYXQ5?=
 =?utf-8?B?NGdGZC9yT0N5aHJxc1pPakNYQ2IyYUZsK2FnN2JRVkc2d01ZRmlkZ0xOVkhC?=
 =?utf-8?B?bVB3RCs3SzcvckY3bGFJY2N0WkxrcjU2a2xrQjJ5M3ppajZZZHFKb2pLdDA2?=
 =?utf-8?B?R1pzUTMxcHhpOWR2TWUyS05aK3Qxa3pyYUxocHczc1BRRWZiR3ZWUU10MTdj?=
 =?utf-8?B?cnJzNE40OUdLeWV5WVJqbVM5V2Z2cmlkYmFpb0hjcXJkK1BDUGlmOUhnVWdY?=
 =?utf-8?B?bFVwOFp6enU4TE1xeVR3ckFRS2RVcW1OUjJzcmNxWE9vM0piN1g3ZFFVNWsz?=
 =?utf-8?B?a1VveFphSkpFZDFoRnY2Z1dQZDdkRmFjRjM5TEw1NVh0VytXWHVDWThScUp4?=
 =?utf-8?B?STNRRkhlbjNqcHdZOUVQd1J4eVpqTVpFZ0tmcjFZaVlPalZNVkJEOWV0YmJt?=
 =?utf-8?B?T0IzaVhoRmh4eVpQNk44MmhmOU14dzNsMUdDOHp2SDhjUlJPSVFZdloxQ0pK?=
 =?utf-8?B?Q2xaemxkZlJQTmQ4dmdwNEx5Qm9ydVRrcmtoTmJsaUYvRFhUcFcxS0FkN2di?=
 =?utf-8?B?V2ZQa0ZPTjErUzY5VzNKekoxWlJGODZmdlhRbUJ4eXlkamlkYlgzWHRjeGdK?=
 =?utf-8?B?Zm8zRW1nV0pmbnlpeW14eThoNnFZQlF5ZWRRSmNKOWFKQmZ1a1lBRkp3Vy9P?=
 =?utf-8?B?citsZlJNREd2cnZPdTZLY2VHR2JLQ2tHYTdCVm52Snk0VDVFVlVvYXBTQ2NQ?=
 =?utf-8?B?a0tDMitPOG9rY0pnWStReG9ZRVFELzMyenBDRDZjd0hIVTBYeWpKZHQ1MGty?=
 =?utf-8?B?RWNKU2ZSaVpHZjRwY1pKN29VTFQwVklzR0o5eU1ES1pHV3ZnekJ5VFVTVi8r?=
 =?utf-8?B?enNWQVoxR0NUTWhHNlorWXl1SWlOUUExR2o0K2hscFg4VUxNQXhQejFpWGJR?=
 =?utf-8?B?RWZaNkYxYTNzZUR2dGg5RU55empLRDBMVGd5dmRtcU9GZnl1ZUgxQ3poMHkz?=
 =?utf-8?B?S1hZTVFFaU92eTNwcmtJUHR0RGROYVdoOU5UNUtFVStLZ1FpWk5sMXJsOUNR?=
 =?utf-8?B?eVh4QTNLWDFJZDlHNmV1MFJWSG5rRC93ek9Qc0J0TjJIeHVsakxDR0VhV242?=
 =?utf-8?B?VTA3VGtSbVVxRk1PSEhXKzlKS3FFSUYwSDNTSVdRRzBVS0ZGeUY0UEtkOGxz?=
 =?utf-8?B?ckJ1UUs4aE1VaXQwdmV3bm1ndzRrNzdRYnlnUVlPdGlRSmttZ3R5eWJUSWhZ?=
 =?utf-8?B?bTBNV25OdUpoeHozSUZaYnFTT1hGa283RTFBbEU4cEw0MkJEQ0Z3TzZIa2N6?=
 =?utf-8?B?OFFycDBET1RWcjFkQTN5cHRaR2ZJOWc0bkEyUlhBTzJBRmtCYUxrWVI0amp0?=
 =?utf-8?B?TXA5SklBSnN0em8xMkJOcVhhRkZ1dDIva3N2ZVp6SnBNOVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R2ZBYXZxSWtPd011RG1uNFNiMXZ0UnRPZmI3SjNnYUo2L2N0RzN4UnF1OVRY?=
 =?utf-8?B?dlBtSUZTZ3ZQVzJiTzhIVDFFTTRKdTJRSjV0UVJxVGVQYmEyMDF6a1VUMjBH?=
 =?utf-8?B?OE1VVVNRc1BzdURYdzlFZGU5bFF6dG1FeW8vN0c2TGRJdm1HOXRUNjRETFhh?=
 =?utf-8?B?aDFPRHV6bTJKcTJ3dG9CRDZvaCtoVm93YmZ2S1VjbGE2Ujl5ZURHRThzSVRL?=
 =?utf-8?B?VHNOZUdrZ2lnOHY5MzMrc3JSVHpuU0RCK3k2amFHQjIyUEZCZDRJUWxWSkVK?=
 =?utf-8?B?dHhFbGRZK0pibDJnYWYyVHRXY3UrTiszVXduVFo2QXQvUTFwZ1hQR0tkWlJ4?=
 =?utf-8?B?OTJ2Z1ExMVdVTlNrL2ZWTHdoQzZJTmRPUkw4dTVub3JSdFJLeEVWcHJKcDQw?=
 =?utf-8?B?aVRsakNoYnVVUk4vR2RuTzFUQVAzaW4vbFU2ejlvem9kOGVNOUNGeStJaWw4?=
 =?utf-8?B?NHEvNmxGU1hJYXFEQWpSSCtRN0t4bkxxSTZtYXNseGE1aWRNVk00aVIyWWpI?=
 =?utf-8?B?dnJwZ0h0Z21JTHZpcXd0Q3NURkdOR3J5b3o3b0xKZVgvVlkwa3UvcllPUHVY?=
 =?utf-8?B?RnJpQkk2U1dRMkh4QWdDTmRWQ21CR3U3cEwzVTc3RFNwYVplN2l5S1QxWmlV?=
 =?utf-8?B?eFUzT0RFYlVaQUdxd21ORVliRld2c0pRekVnK3hJZ1dKeTVmZHo5V1NiZ1Q1?=
 =?utf-8?B?RmhSUjB4Mjd0UDJqd1BFOXJ3SkxwQ0tKSm4xa25NM0phK1c4dFYxWGJDK3Ny?=
 =?utf-8?B?R1FsWHdsZU9sYWhWdU8vTlNPMy9sN2FEVXBSNzNUYWJ0WWtmWFphL2JiRlpJ?=
 =?utf-8?B?THhlbkdMSHoxL0ZNME5McERsVi9RUCtPaG5maisvcHhBdFFYNitGdmFEK3hv?=
 =?utf-8?B?S3dVWTRTZ1hDWjlIMkZTZG13NXFqNTI5cFU5ZmxHUHFJS0FqM1NPNVZGbDUw?=
 =?utf-8?B?aTFEakc4ejFJRzdDdGVORlBDbCtJQm81V043VElZaFc4b2tSM1pEVnZUcUdj?=
 =?utf-8?B?SWhRMXJuRHF4Q3Z2TlByU245L0haVFE0cjdvV0ZUd2xWOHRTNjJvQ3hpaVEr?=
 =?utf-8?B?Nnk1NmtKaVZreTZNb3ZEaS8waUhFaDJCVXJTa0lXNGd6Ny8yWmMrTTlaaFBU?=
 =?utf-8?B?RVdDYUdBc0NiZWNXZUJ3T0J0SzRQNThQTVErV0lXTzd3V1FaNWRjc2xvTUV3?=
 =?utf-8?B?Sy9oUEp0RmNLZ2E2SGtzU2k1a2RMK0U1NHorZTU5a21tZzdwam4ybkt3M201?=
 =?utf-8?B?VlVrZDBjc2E1azFCbVZBV0F1bU9ka0xqN05WY2VPY2tMSi9FVm54MGQ5dlJK?=
 =?utf-8?B?dFFSMmZxemUyekF5ZHB4UnRJUDBpVnFOUDV1bDJXdCticWNSeDFRMUtTS25U?=
 =?utf-8?B?aTZldU1HMVRHbW1tbUViMFdkSWhnenRPV3VRdUY3dzRvVmVVUTFFYXZ0RGlD?=
 =?utf-8?B?MktKRlllSDRUVHBET3k1Rm5LV1B3VjdBTDVIbitwZ1RwbjNVZTlhMDc0RFJ5?=
 =?utf-8?B?VlF5ZWJsSCt5RVMyckFrUjF0ZllsbnNiQ1VzZ25zSTZDc3MvaUFGWmhWamZw?=
 =?utf-8?B?YlJUN1NmNVN3RkU4dmZYZmEvN1g5cWpzTGxWd3FZVkxhdXNoMzVndWFrazRY?=
 =?utf-8?B?TUNCd3RGY0hQQXBrNE1CUjVIU01SWEpvaDVrZEpKc1NTMmVmYVlDaWlkNHV5?=
 =?utf-8?B?RnFaaFl6ZzhhWENmSmhkakw4dU1TWEZ4VGZpWWg1VGQ0aXJBdjVremZLZlNS?=
 =?utf-8?B?VjdKQk9ZRXV3Q0NGMm91TUZpUHFleEtvamJaekxhOVVYOUZrb3Z5bXN0MGxv?=
 =?utf-8?B?TVVoL1ltak9sYmQ0YVpKYmJlaWUxQzlWR1A1NW5NdVhiTHd4c1ViNWk0YnE3?=
 =?utf-8?B?UVJHekRZVGdjWjB1ZitqUElVa1hNcXpTcWZIcTBHN0pTeVppSHA0RjFiL2Y0?=
 =?utf-8?B?SkE4WlBxMFBpcjRLQU1OTzNMQTZyK05GVWRYd3Y2amhNUXdqeEVlSjRRWTE0?=
 =?utf-8?B?Uyt5YkZ1V3pKTzg4UzZTQUFJOURpWjYyVDVvdGlPQUIzV3pTYjVJaDFPNlNE?=
 =?utf-8?B?VG00K0g3SUNHTkZ2aGlib25WdDY0b0E5eUZYM2VtNzJHQUJtWFpRYVp0Q1pX?=
 =?utf-8?B?VDVUeW1Qc2V0QnhEOU1IZnlkU2U5NkljdlEvd3Nac1hscmF6b01qRm5vR2JB?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A05F24AB8298A4FA04CE86263B11D1D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KVhxXK64bUYQeFYPH37ZO7edywVPHgbGs0JHH0+0eyeOxoWdGZAISMJWMoI89hfhWT/7+JRtDDRe27lp6R7SCjJ8Zc1hqJnzoyxUKcF5/xVR7T6batE0Y6pGwjJZBh1KBOVTI4jnGNnDEgIQQzwley99tyqQJaDxrVx1hNexOyX9E1KBWFcXkRczlGjCsY246oZ2njoPcEbFsXJ14I5Yuj0qcyPuMeEFHUEeMrAvpIk4L+ym1WaWlZi00kxd+56qWu2mVNbzEy6kloaT1WecPv5uokB9MIj5JowrV7zVWvmLxw2KL3Lb9qu8tX3Z3SMiEFtSwZ67xUskoHWCJOPW2QZZ2cviZffE6+UT7adHgFPNYwhy4sm6aVwkmWIiew4J1LdwFmAi2XQqmP0XV2rh7oitmkf6CtJekv2xVN6rwd7HZhU+jnnJyAsneZxpt49uE41EPlNLnosjqOQwsc5udtpIT4vtykWxhMS85vmR+fu3oJaQdC+InJT9UhDg7k5RIMn/GF1hksG0kBPc6TkBk0rkM9weM0/wON2PM19Uno8vPHv+EACFrDbhHBSnY1vL2aUPm1fWYFvlLlRz0Wu7dNOBF7uSyHkxm/22Ud3d7eE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a96ec48-e229-4875-be0c-08dcdcad1c75
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 15:25:24.4209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tcNrJifCeeUAiMP8BYkkTPFBrObhdOPbW1gXsZmnpOEtoSOYRTYy//8gThSBT2SiPS764j6lvfyTeCuViOfLdX6xymWenKHV4GeKvpRtf4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7211
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409240110
X-Proofpoint-ORIG-GUID: J954Q0sWQhOgejfWYTU9VJL1943mVLJR
X-Proofpoint-GUID: J954Q0sWQhOgejfWYTU9VJL1943mVLJR

T24gVHVlLCAyMDI0LTA5LTI0IGF0IDE0OjQ5ICswMjAwLCBKYXZpZXIgQ2FycmFzY28gd3JvdGU6
DQo+IFRoZSBpbmNsdWRlLnNoIGZpbGUgaXMgZ2VuZXJhdGVkIHdoZW4gYnVpbGRpbmcgdGhlIG5l
dC9yZHMgc2VsZnRlc3RzLA0KPiBidXQgdGhlcmUgaXMgbm8gcnVsZSB0byBkZWxldGUgaXQgd2l0
aCB0aGUgY2xlYW4gdGFyZ2V0LiBBZGQgdGhlIGZpbGUNCj4gdG8NCj4gRVhUUkFfQ0xFQU4gaW4g
b3JkZXIgdG8gcmVtb3ZlIGl0IHdoZW4gcmVxdWlyZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBK
YXZpZXIgQ2FycmFzY28gPGphdmllci5jYXJyYXNjby5jcnV6QGdtYWlsLmNvbT4NCg0KT2ssIGxv
b2tzIGdvb2QuIFRoYW5rcyBmb3IgY2F0Y2hpbmcgdGhpcw0KUmV2aWV3ZWQtYnk6IEFsbGlzb24g
SGVuZGVyc29uIDxhbGxpc29uLmhlbmRlcnNvbkBvcmFjbGUuY29tPg0KDQo+IC0tLQ0KPiDCoHRv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9yZHMvTWFrZWZpbGUgfCAyICstDQo+IMKgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L3Jkcy9NYWtlZmlsZQ0KPiBiL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL25ldC9yZHMvTWFrZWZpbGUNCj4gaW5kZXggZGE5NzE0YmM3YWFkLi4w
YjY5NzY2OWVhNTEgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9y
ZHMvTWFrZWZpbGUNCj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L3Jkcy9NYWtl
ZmlsZQ0KPiBAQCAtNyw2ICs3LDYgQEAgVEVTVF9QUk9HUyA6PSBydW4uc2ggXA0KPiDCoMKgwqDC
oMKgwqDCoMKgaW5jbHVkZS5zaCBcDQo+IMKgwqDCoMKgwqDCoMKgwqB0ZXN0LnB5DQo+IMKgDQo+
IC1FWFRSQV9DTEVBTiA6PSAvdG1wL3Jkc19sb2dzDQo+ICtFWFRSQV9DTEVBTiA6PSAvdG1wL3Jk
c19sb2dzIGluY2x1ZGUuc2gNCj4gwqANCj4gwqBpbmNsdWRlIC4uLy4uL2xpYi5taw0KPiANCg0K

