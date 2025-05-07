Return-Path: <linux-kselftest+bounces-32600-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49921AAEC27
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 21:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4185A174E14
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 19:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93DC28E565;
	Wed,  7 May 2025 19:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VZzee+7y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mEV3tYMP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6AA2E40E;
	Wed,  7 May 2025 19:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746645928; cv=fail; b=KSG5etx3ODnNnlh+PWjk7NyC5nEjHjXsDMlUWlUjDBztlfubLZE2Yre4FaPkA/R05esTc3Oxlc6QbyBQkMyYkSNJzzUv1qlYjojh+8kHi06Ph1mlnCQ/84cMZPstzPOCb7S1Msh7uGBoYHxb92ogxyhJlBGn2+RXYD1M+muzuew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746645928; c=relaxed/simple;
	bh=3a1SjJi+76mLjmHYkMUyYYWw8fArgaz/OHZJxT+qu4M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tw/CJOXO3iFt/vrEhxKdcx+qiDa13lqVUgmiDE1PJ8vjJO0p5lEVVzkkTAqd/gDJqfZQjbtYG4RktelKdTBsBqWdB6MUZxVTvdc4gZrKVbibMO7T3LKXgaztnvU2y6DZYS7foxvX+cpRzoSNSx/rLjNoK14Ed2TzOX5UYdBOH3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VZzee+7y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mEV3tYMP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547JHgWu015286;
	Wed, 7 May 2025 19:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=minRejeA2jtGASmIXffL51c2GI8b5J/pHWbh2Q5pX+o=; b=
	VZzee+7y3rTuNZ82eddhZNdNUiW8D/hy+VndX1ldCun1BWTtqWOG+karex30vot9
	9HX5ZGeO1R3Z7kmr9Po2KgSGwdxo8RhJZYxRoH+jR/xipZPvLGhV86bgcP5AIqBG
	0rOTbMBzAIhYHo9dTEUApQ6xfP8ATuBTtmf4Zw08XEKATpj/jFhkpaH9UKUU6UTe
	D+44ktij86sGVc5HM5DHmdgc9XAfmoST7+vzobpvsyzGFb2JoijmRlBzFgbXMcQV
	lrLt9Rb4YRkw1VBtaE/yvdDYZIAmP4m8JQhKhV36CbQoTBpxY/7LNCUDpFpDrpYb
	tX5ONMplg+G6eyS50NhOeg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46gdhrr0ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 19:25:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 547Iu3wY035473;
	Wed, 7 May 2025 19:25:02 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazlp17011030.outbound.protection.outlook.com [40.93.13.30])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kh2m3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 19:25:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AuC9JKYuR7zIFOI+QXh6+T0Il8sZT2b4nSk7vlca/UmWEjGZUDg6Ljs0IzBJ6QZD1ulvg964zr6CUhzz40vEncuvm3edjfJT9H8yKfW3LgP7LNF2BZ9bwMl1zbog4i2LIjyTEpFcD+SZwrtJ0z+5LHSXsZCJwbn6UmcwM48EcZxos8LBELs/6E4OecuJUYAjoIQwrgGX/vKWjxrF6mF7+OsVq4WE0FEmfGd2/fI4CwEBKSyJDPQoTJultoxIZUqbYIOOfdfFSNL7aa+UvbRN3J6beT9NNHz1ysjc6Uk7Z7X74h9jw3Enr7InLS0nKEJ1j8PJjOXDWnYkFIgHlot6xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=minRejeA2jtGASmIXffL51c2GI8b5J/pHWbh2Q5pX+o=;
 b=uVjrdMIZy1iDc18IO1BP6W5Qm0UyHlPpLqsK6L8rcvlELKEbbjTQuiqjxiCo3MNT15I31+AKKqV5woqmTk4/MQXptyv5LfrFgXI2oK+m7Dzz8bRd9pCeeoUEJ0WjuRSW1Njw3PC0O5oCrnqwdieYCdqJGgFTyNUo4IfaRxtRyQuyYwJ3ZGFGdDDPngLtOxSeRW9kSg2BSYrcUeZqPOcGPc2DsZiA+xrfUrjx/cWQ1W8NTwxYQsDmU3bqblRjGbHH50MUawETIuV4Lkil6/ncYgFbg2shzHI/GudrQBA+pzqmmjWK5GSCrTQwCLx7G4p31c2KnwZ8LoR0j5QCIhZ7ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=minRejeA2jtGASmIXffL51c2GI8b5J/pHWbh2Q5pX+o=;
 b=mEV3tYMPEBUuuunQ4nxZG5u2sEYSamJs4trkgxbNB+oFSBZqPfSjhLMj0x2H+0nPb9CzajAuuWVUtDS2SBNarFFtVerHgSj/+D5LGm53T62zsmAz2Td/5E0FKH/mzgXwtFU3KhGb4zvSpaYH43DQ9PYPPFf0IU3A5tahSY52PgM=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DM6PR10MB4395.namprd10.prod.outlook.com (2603:10b6:5:211::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 19:24:55 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 19:24:55 +0000
Message-ID: <830ecd3d-13d4-4f12-9fea-e20cc69d0a5c@oracle.com>
Date: Thu, 8 May 2025 00:54:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/6] Documentation: kvm: new uAPI for handling SEA
To: Jiaqi Yan <jiaqiyan@google.com>, maz@kernel.org, oliver.upton@linux.dev
Cc: joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, will@kernel.org, pbonzini@redhat.com,
        corbet@lwn.net, shuah@kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, duenwen@google.com,
        rananta@google.com, jthoughton@google.com
References: <20250505161412.1926643-1-jiaqiyan@google.com>
 <20250505161412.1926643-7-jiaqiyan@google.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250505161412.1926643-7-jiaqiyan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYWPR01CA0023.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::10) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DM6PR10MB4395:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f19aefa-29db-44cc-eb19-08dd8d9cd8f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDAwSXIvY3BNQ0tXZUpzOGJENVR3ZWprWFZUanJiajVqNE0rd2ZaVXhuem0y?=
 =?utf-8?B?MTZCb1JpRmkyc0tObVdQdE9DQ1BVdy9yQXM4YjRhMTVqRGs5eGgzUENvZE5m?=
 =?utf-8?B?RzlDRkEvOENhUGY0T0NHQzlMbGJCMU9tNzB2Z3VIdlZJODZneTVoYkhneHE0?=
 =?utf-8?B?SnZFbVJCWU1EcGN0ak8xdlU3Umt0dktKa3BxUUtvdG9UcEc2L2w5cU9kcnlP?=
 =?utf-8?B?a28wZ1Vzc0JDbkxwdVlzekJnTHBTa2pIRDlTcy9rUzJNWVhERW1zVU5yVlND?=
 =?utf-8?B?Y3BYWW5WelgzMGtDSnhxbllpU01mT2QvSW9MdmhoNFBlWkw3UVN2ekViWk1S?=
 =?utf-8?B?amhQUGpDMDYrTTFPNUR1VTNwMXBZVDdVdmt1WGN1VjN4QXVYUjJQTWY2aVVE?=
 =?utf-8?B?WThKSHUvK3Q1L0FDVnBIOWxmSmtYS0tZLzUzOVZ4N0xFWmRRZVMrWk1rTjdP?=
 =?utf-8?B?dElvcVI4Nlp4MjdZbm45ZnNHZFcvcEFwOUxoREpZblV3bUtINDFMUGhPaGVV?=
 =?utf-8?B?VzdrT1BDQy9DbmR2U3IveEhmTjc3Um1rOFpkSmU1aWgyOVBaNmdwSVB4aHda?=
 =?utf-8?B?cUVIMERHemhIY01MWithcWJRZ0JsK2tjbEg3dFRsZjBhYStJSGY3aVpTdU5h?=
 =?utf-8?B?YndrcUZITitVTVk1TGcrYXZkcGlGWWtOKzBxVGk3akRUcitnZkxvbDg1cHBZ?=
 =?utf-8?B?VGFDZXNGWUUwNDc1bVd2SWhRY1hqa0RvNzJOZjdWZXdCcitJK2RabVliRVRy?=
 =?utf-8?B?ODlXdWpvTWJMREFGS1hSaUlmM090SEplblAyT01TM0tkNnJhclNRZ0p2eE45?=
 =?utf-8?B?b3pGMG0xWFcxdFBQL3E0U2JJZGhCc1NtbnBEcUlxVkl3Rk9kWGp6YmdrWVVM?=
 =?utf-8?B?Y1I5SUlPd2s1UHBnakxBMmVxRCt2OWNRMmptRlFCTG1jWlRnU0F5QVV1UHBH?=
 =?utf-8?B?Vmh6V2lqTFRtV1RIUGk3NFFsR2Nadk9EL1ExUWVIR1JKVlh1c1pVZ3FGY09S?=
 =?utf-8?B?SmNQbXprdDVmOTZ2NHErbnd3eThlMlVEQkhDdm5hYXBldC9zMG1KUGhZLzcw?=
 =?utf-8?B?T2xPYzVIdHNOTVZEVHY2bklnSzJDVHV5QmRyU0liV0d6Ynp3SC9DUnBqY1FM?=
 =?utf-8?B?aW9lUEswYm1hMXNOVitPSDZ5dm9adzVMc2FNelVCWGdtUWs1RUpJM1Vtbmtq?=
 =?utf-8?B?Q3pUdFcyb3ZyQjJNZ1hMZ01GcjhBMkxkV29WRi9QZ0UzcitWMHdyK25OeEhN?=
 =?utf-8?B?VkRKMlpoRnBlT2dNdDJOT2ZwemxqYktUNmNaQWN1WU1uUkh2MVBPQzdMRDU1?=
 =?utf-8?B?RERIanFWY1FZSi9nQ1VLTmNIZ3BHcW15eDlmQXhtU2FPcFNWc3hsZW5ualhh?=
 =?utf-8?B?L3N4Nzk2QS9hU0Z4Rld5bHREd2NVaXRjMVYwWXFwSnM3L0xORDhpOVhHUGFP?=
 =?utf-8?B?ZGNYa0tXSHJzZ3RVelF4aHRUQ080VnFwa1ZzcVc0N0V6RlB5YWJWSURua3o0?=
 =?utf-8?B?Z2E5cVlob1pTSHE1TXJmNG1zQmpLRmkrcDhVWDlkMXlTdjVoYXh5ODBwMzFa?=
 =?utf-8?B?SFUwLzlPT0dYOG9YMDkwRmJSNFF3Yzc1MXRVMmU2QXpRVk10aFh0cjMrUm45?=
 =?utf-8?B?aGVIZXVsQUxiQkZtTmxpUDRyR0pSS1BnMUlJaG55NlgxemQ3Zk5uNmtSaTRX?=
 =?utf-8?B?dFdmSkI0NDhlWTh0VitoalJNKzRWSDRVNnFxQkNRZkNNRFRTVGNGZE1oMHM0?=
 =?utf-8?B?MXl6VkZPR0FQZUgwOUZoMUhlL1l5QThMU2RuZUFLVEVtd2Z5bXVmbXNQNnRy?=
 =?utf-8?B?ckJ0eTNtVUdJcVdseS9QNWdyUWtpSExGNVZ4b2hNeDRrVDN5eDBsWjZrTmNF?=
 =?utf-8?B?Z2U2OFBjS29UbHZjZlJ4ajFqNWhyaFQ2c1lNN2VGYjhLTnd2RWVTVXg2Mzd3?=
 =?utf-8?Q?oJ2HihBhkic=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHBhQ2NxaXM4T0NXZ3hiMTc0aWZjbUtZYStFMDJwMkwwaWhsbEVLeWlmQTlp?=
 =?utf-8?B?Z25EVmlkcVhMOWxhbVJscWZwV0NTTk1UREt0djJwbVYwTWRqMnV0ODN0Ylho?=
 =?utf-8?B?YmJ6akhMeGNDVUlNV3p1N1hSejluS3pXaUFnMlJBVkQxNDJpVWVYc2UvS2Iy?=
 =?utf-8?B?Ui9OSzVLemRITnlGL0gyd0liZExUTyticlI0bmkyMVZ1SGNCU1ltNG9iOVFL?=
 =?utf-8?B?dk1zRmVPZUVOZTdSQnN3RTNTVXM0QW40WC9WbEdheGpKZ2oxUlBXM01rWHdN?=
 =?utf-8?B?K3gwaWt6Mkh3eitJaEtOR2cvT21vcy9XRk5uZ1FhaVNFTkpiRmY2NU9VS1ZZ?=
 =?utf-8?B?Qk5iTGRZQ0Ixek9UQjhqdXkwSjNwalhiajFyRlUyN01LOUhKeUJVNk91VFdl?=
 =?utf-8?B?ZEJNT3NOQlFRNndycS96WnUra0w0NFJnbzdiRXBBQ0VicFlscjVNZUpLeDhm?=
 =?utf-8?B?ZmxYVG9EMWViQnZiY0V2UXo3aVBjenlFaGdoeEwxN0JGTjJ5V1JGZzVqcGtu?=
 =?utf-8?B?VDdianhxTVVkS2g4SStvcUl6OEZacUhsTWxCVTRON1Z1UklQcWxhelFhc2ZV?=
 =?utf-8?B?TFE1emZGdVExVnRQNXlxK1YwdFlLK3JzQjNHVHpJcUxGelJuRDJVOEtOY0lS?=
 =?utf-8?B?djZyRTlqL2dVT21OSkZWb242Zm9SNnRmK0w3bGFYN1BqU2JnVDdyRlhUNito?=
 =?utf-8?B?bHlrT0tSSXpSUHJpQzU5TmZUTU1iYW0vMDVKNk43L0thaUoyYXdwemFna3BW?=
 =?utf-8?B?YTdkSVFwOHlMUUROSDV1VEFVbGRQOXV1bllFZWttVXhFQ1RWbWVZYjhVbytq?=
 =?utf-8?B?enV1ZE9pSkdFN1VIZHJhbVVBTFltKzdNUVEzMlJjV3J4Mkt0OGdEWW5vNXVQ?=
 =?utf-8?B?TE92MGh1d1lFamFpUTVmMGx4K1FyRm45SDJqbEJnaW5oUWFsOGdoNlhtUEt2?=
 =?utf-8?B?SXdGK1BkLzJwYW5pL2k5cjQydFY1QkNMdSs2K3lFNW0wM2NML0Z0Zmx2OWlE?=
 =?utf-8?B?cmdHdFUzcnNGMm5VcmcxM29pSTlNdkdiY05NUHhHaFpGc3AzTkxZMWUzZjVQ?=
 =?utf-8?B?V3FJREZpam5qSEtobHdkb0JxZExhVFlSdzlnZHVQUFpjTE1GUndPV2pkQmZ6?=
 =?utf-8?B?WWROQzFFeUV6MERzTnFXSUJLUHJOMkV5WEVFOVBPbktkRUNkalMyWTVUWFNE?=
 =?utf-8?B?bUhYUHhzOU85RzlmMDVCbXVaT2NMVWZtWXVTSDFMb0RYUXdKbTMxKzVOOVlK?=
 =?utf-8?B?Q2RYcWlndHk5T2I1d0EyaktrVDgwbUpjSlJQdjAvZXE1R0N3Uk9xN0tOVWRp?=
 =?utf-8?B?NCtKMERCaEVJUFNQbHlxRTJHL0I0K2xTeFBFMXp3VGs5YnFRUk5iMFpWQzlV?=
 =?utf-8?B?MGt1NDNWV0ltUy9wN25wZHJDYlNmVEdCb1JoOFFJR2dNWUc5amFOZUFTMnFI?=
 =?utf-8?B?RmozOE8xUS9IWlNjMXBERHRoMHFTMUZ1RFIvZnZxZ2tJcEgrTXFkMWJpbEdp?=
 =?utf-8?B?eHIrYmgxV0xIeStmR0dYQm9HOStSMmRlMVUrVVk0YWtHMWI4THhLblhWdlNn?=
 =?utf-8?B?VXFZU0tNcitlZTZRK2FWWjFJUEdQa0ZRYkJyN21xdmMrV09rREM2R1VMTDd2?=
 =?utf-8?B?enpWeldHOTlURGQxajlxSmg4S2Q1OXI0UGw0c094SkRHRVYrdU4wcWhVTFdS?=
 =?utf-8?B?WFI0YjNsdExlNXRza1lKTXpSeVVDTWlGSjd1QkpRYzdIb3ZYNDQxbGdqS3Bp?=
 =?utf-8?B?WkNicnV3MlRkcndhMUF6N004ZHZ3RytaQldDNmp3WmlGT0lzWFZ0V0E4Tk5D?=
 =?utf-8?B?Z2tMZERuNW4zN1ZRVWsvaWY1S21vVlpwRStTVDRhT0NmZHFRdVFENkRYQ2VB?=
 =?utf-8?B?UVZrOExUbG5odnBIa0tlMDR4TEJkUWs4Sk9qWEQrbTJFWFl5SFBKZktUdVBT?=
 =?utf-8?B?QnVlUUxnYUljcFBvVkF2U1ZiNFBRNkNObUsrcjNLRExTZmFlU0l0eEx6TmVn?=
 =?utf-8?B?SE4yNGFGM09oRDFFcDdSUmgrdy9FSkVPSTJMdjc1MDZwSHFEQW9KWHQyUkxu?=
 =?utf-8?B?b3hscldYeVI0eHNlWlJlZGJLbzE1QXVmWS9nL0FUeFQ1aWI0ai9Ua0c2eHFM?=
 =?utf-8?B?UGZIdnpCWHF4K2NlcE5CdEExN1plK3hpTENjYkR2WFpYMmxJeGlDMDlxaUdh?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BS+64cSJBoTulglI6ybCXxcEtoujmDaITSdIox94oME26dO9u6w4J9e1zteWkkK4AoR3H8ZRfYqhQtrWi05HSxSP48dVBNzcIPtqf2uyI7vNdIyxMyiTctFT/vBJnNhZ2Jojbwd3hpRPfLnMGBydfnlAU2EpJWx7ud7/KtuIpjbutvyyHfgCHPM20D74Szdtd4tIbUJtj0vfxtl8qk/R4HlemyIgbZFozc2rnFqZKP3StnQJ1Hwk7bJWF+zhGiZ9KkyU2PqOR3ZQDnE2g/1e4Iu81GPc6tGKbvWzo91/x8VC+ApQAHS5rddpYNoik4vfGe5zIMwMmp4q2YE6BMLXKGAX7PYgMd7hJCrdHRWS/onqj6cqrojQW7esvVOjlLR5nuFdpsa5s3kb9eGtkLE/4gWB3tpplM6lgjheLdKVy3wBqUO/PSC9DpxSI6AeT9wlEh/mCMzbXwoCCzQoZaM9gyNEI75t3e2PU7vB0kJnGnj7hFKizp+OMHUPom9OLHhSdkX4IVZH+FyfjscIgEsPzePggWS5GOcVkKoJkLWK6aM/RJTbwGwEBAYEzR9RE8NfEdcX7M5S/E+o+PvW9f9kmPxKhN22Y3cnTJXiQNfqFvg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f19aefa-29db-44cc-eb19-08dd8d9cd8f4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 19:24:55.4618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jF2yrytiR8C1BcNE4qTh8FVaHciPTGDBOC7S6qzctH15sXt0ilgoz0joafuk3Viktc9HDt07zlUIh5u700tDTKtcTdMTwF7PXcyHnygEc9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_06,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505070176
X-Authority-Analysis: v=2.4 cv=G/EcE8k5 c=1 sm=1 tr=0 ts=681bb38f b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=zV1IG8y9D3pZ-8S2KTMA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13186
X-Proofpoint-GUID: P6epyOmxjOAoSJ-8PYJmvfJnwpSYYAGp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE3NiBTYWx0ZWRfX9IfR7ghN1hc/ BXl+fuUSw/FHBtV9yL9rF0BI9rL9mWM/t7ryXErUUlzNVHreB1tyX+GZL75qXjCD60izXHRnofU uzYz1YXnCZMai4UHCEyMv6ilIjsp+8JqFEYuV8jxUVucXKbqdply0vuzoic/9zpl+8pMrpaiW9Y
 lh9YYE+Ezah/vEhWsYdc/w4W+NvFOXmX9qUf6kWp/lTJ6423tgEIFJL+tNyQHAnTUQmEYMAEEps +nPzZkKiO8flANnKQhBGwpRcxqNC2Dxza7I2MXQKQfZ2EpMw0AQnBwliQgRS7JuFUdVUq6sZwzd iLj8HxMIjZMQ0L5rMU0yCdOd0FFKpLfB89Fe0RiGYdmQwDuQ60J4kiS6ca38UcC5oY0JY9fWWKh
 XMt9/24LVbYq49FmeMvDZ/0sJMkXvP3uAdEIFdclPJZliqditvVlzxMD0bTuC8SwSo5X2cd0
X-Proofpoint-ORIG-GUID: P6epyOmxjOAoSJ-8PYJmvfJnwpSYYAGp

...
> +Inject SError
> +~~~~~~~~~~~~~
> +
>   Set the pending SError exception state for this VCPU. It is not possible to
>   'cancel' an Serror that has been made pending.
>   
> -If the guest performed an access to I/O memory which could not be handled by
> -userspace, for example because of missing instruction syndrome decode
> -information or because there is no device mapped at the accessed IPA, then
> -userspace can ask the kernel to inject an external abort using the address
> -from the exiting fault on the VCPU. It is a programming error to set
> -ext_dabt_pending after an exit which was not either KVM_EXIT_MMIO or
> -KVM_EXIT_ARM_NISV. This feature is only available if the system supports
> -KVM_CAP_ARM_INJECT_EXT_DABT. This is a helper which provides commonality in
> -how userspace reports accesses for the above cases to guests, across different
> -userspace implementations. Nevertheless, userspace can still emulate all Arm
> -exceptions by manipulating individual registers using the KVM_SET_ONE_REG API.
> +Inject SEA (synchronous external abort)
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +- If the guest performed an access to I/O memory which could not be handled by
> +  userspace, for example because of missing instruction syndrome decode
> +  information or because there is no device mapped at the accessed IPA.
> +
> +- If the guest consumed an uncorrected memory error, and RAS extension in the
> +  Trusted Firmware choose to notify PE with SEA, KVM has to handle it when
> +  host APEI is unable to claim the SEA. For the following types of faults,
> +  if userspace enabled KVM_CAP_ARM_SEA_TO_USER, KVM returns to userspace with
> +  KVM_EXIT_ARM_SEA:
> +
> +  - Synchronous external abort, not on translation table walk or hardware
> +    update of translation table.
> +
> +  - Synchronous external abort on translation table walk or hardware update of
> +    translation table, including all levels.
> +
> +  - Synchronous parity or ECC error on memory access, not on translation table
> +    walk.
> +
> +  - Synchronous parity or ECC error on memory access on translation table walk
> +    or hardware update of translation table, including all levels.
> +
> +For the cases above, userspace can ask the kernel to replay either an external
> +data abort (by setting ext_dabt_pending) or an external instruciton abort

typo instruciton -> instruction

> +(by setting ext_iabt_pending) into the faulting VCPU. KVM will use the address
> +from the exiting fault on the VCPU. Setting both ext_dabt_pending and
> +ext_iabt_pending at the same time will return -EINVAL.
> +
> +It is a programming error to set ext_dabt_pending or ext_iabt_pending after an
> +exit which was not KVM_EXIT_MMIO, KVM_EXIT_ARM_NISV or KVM_EXIT_ARM_SEA.
> +Injecting SEA for data and instruction abort is only available if KVM supports
> +KVM_CAP_ARM_INJECT_EXT_DABT and KVM_CAP_ARM_INJECT_EXT_IABT respectively.
> +
> +This is a helper which provides commonality in how userspace reports accesses
> +for the above cases to guests, across different userspace implementations.
> +Nevertheless, userspace can still emulate all Arm exceptions by manipulating
> +individual registers using the KVM_SET_ONE_REG API.
>   
>   See KVM_GET_VCPU_EVENTS for the data structure.
>   
> @@ -7151,6 +7184,55 @@ The valid value for 'flags' is:
>     - KVM_NOTIFY_CONTEXT_INVALID -- the VM context is corrupted and not valid
>       in VMCS. It would run into unknown result if resume the target VM.
>   
> +::
> +
> +    /* KVM_EXIT_ARM_SEA */
> +    struct {
> +      __u64 esr;
> +  #define KVM_EXIT_ARM_SEA_FLAG_GVA_VALID   (1ULL << 0)
> +  #define KVM_EXIT_ARM_SEA_FLAG_GPA_VALID   (1ULL << 1)
> +      __u64 flags;
> +      __u64 gva;
> +	    __u64 gpa;
> +    } arm_sea;
> +
> +Used on arm64 systems. When the VM capability KVM_CAP_ARM_SEA_TO_USER is
> +enabled, a VM exit is generated if guest caused a synchronous external abort
> +(SEA) and the host APEI fails to handle the SEA.
> +
> +Historically KVM handles SEA by first delegating the SEA to host APEI as there
> +is high chance that the SEA is caused by consuming uncorrected memory error.
> +However, not all platforms support SEA handling in APEI, and KVM's fallback
> +handling is to inject an async SError into the guest, which usually panics
> +guest kernel unpleasantly. As an alternative, userspace can participate into
> +the SEA handling by enabling KVM_CAP_ARM_SEA_TO_USER at VM creation, after
> +querying the capability. Once enabled, when KVM has to handle the guest
> +caused SEA, it returns to userspace with KVM_EXIT_ARM_SEA, with details
> +about the SEA available in 'arm_sea'.
> +
> +The 'esr' filed holds the value of the exception syndrome register (ESR) while

'esr' filed holds -> 'esr' field hold

> +KVM taking the SEA, which tells userspace the character of the current SEA,
> +such as its Exception Class, Synchronous Error Type, Fault Specific Code and
> +so on. For more details on ESR, check the Arm Architecture Registers
> +documentation.
> +
> +The 'flags' field indicates if the faulting addresses are available while
> +taking the SEA:
> +
> +  - KVM_EXIT_ARM_SEA_FLAG_GVA_VALID -- the faulting guest virtual address
> +    is valid and userspace can get its value in the 'gva' field.

the 'gpa' filed -> the 'gpa' field.

> +  - KVM_EXIT_ARM_SEA_FLAG_GPA_VALID -- the faulting guest physical address
> +    is valid and userspace can get its value in the 'gpa' filed.
> +
> +Userspace needs to take actions to handle guest SEA synchronously, namely in
> +the same thread that runs KVM_RUN and receives KVM_EXIT_ARM_SEA. One of the
> +encouraged approaches is to utilize the KVM_SET_VCPU_EVENTS to inject the SEA
> +to the faulting VCPU. This way, the guest has the opportunity to keep running
> +and limit the blast radius of the SEA to the particular guest application that
> +caused the SEA. If the Exception Class indicated by 'esr' field in 'arm_sea'
> +is data abort, userspace should inject data abort. If the Exception Class is
> +instruction abort, userspace should inject instruction abort.


Thanks,
Alok

