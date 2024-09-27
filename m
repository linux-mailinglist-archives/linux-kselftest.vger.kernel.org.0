Return-Path: <linux-kselftest+bounces-18470-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E88B988569
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 14:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53B41F283CF
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 12:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E3418CC05;
	Fri, 27 Sep 2024 12:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EhXsil3L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lJ/uRJQE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EEA18CBEF;
	Fri, 27 Sep 2024 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727441054; cv=fail; b=dnlW/BWlsYCSDZ00H7zi2rS+driQb1j/wuD9aBQOM98HyEvNrINTmYBSUhioo4PJVSeyxplP7Ol6z42kaqbZRk3fmiA4zu5R2xohaQBK0dliXdWkSvQtqoEMfaJfslbeXwp6XMSR8KDBalZ++bzsotsXRZSvCzzw+ZmSsS5bv/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727441054; c=relaxed/simple;
	bh=r/JmFmOlLELu+Ho8csvEIDWoXKpJRMM1nMJTYZAkC34=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BmOuucoXHVwwqBLRpFeSwS/HAY9ljscA/jdCpMeKEADehMkkg00LTvNceuGWz9g9Dzt69Jp3rbjdql/r6uxCHQQeJAU7INi6DACBxOzq1qeqP2ZvuP6WT/HjUoBnzk5f9r6PEZrp8BcwjGONfw63i9EjW2UCtHcmvfYeoNMlh/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EhXsil3L; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lJ/uRJQE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R5gdIo020800;
	Fri, 27 Sep 2024 12:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=r/JmFmOlLELu+Ho8csvEIDWoXKpJRMM1nMJTYZAkC
	34=; b=EhXsil3LSNAkqo4JiBGMirnLb8OVrPKmpMp3W8YRKOaxnDCU+bqon23ZG
	D3DpzaumCVVfIpN9DcZ+9AC/wneM7sVBXiV7ybGfusmkjfFCkY1+8Ug/OiT3JQ8K
	630LOAt1vl8lyRvVkQIB7DIhb+0Hc00ddU00+XnSMdeVaQF/A8/xDavQBzO5WzDP
	ZUZVlZvNyc9GlSRKMH0fl/Gu9qc+MELKzeLhR0PqfLE4lKg/0YZ6w5QDy/eOQdDC
	sNfn7JymF+rcibY6O/hrD0anu9jlXumqCckj46ZrzsfSC2swcfRaeGdvlB8/TdGV
	x2ZKjd9bbwSd/L6ZNPS0DoaDPqAEA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sppufjj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 12:43:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48RBWduK030602;
	Fri, 27 Sep 2024 12:43:33 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smkdk4d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 12:43:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FOpAMoJwm8wnWLKq4cbpvN0kv6gdxqegrKLjVNAMe0PBrtq5c47yBGi4Ub++OhWuRnHRdbJgFo6ljtTv9XNGPhPbCalXhBZnQ6qqPLg49803OonWSG2U4Zo2HbXhHzsOtGgXDcZKtYRxJKO4ksCNDvxFmDFmzsyG118NQzYSKUX9Y2EDYjBGTzGZHhS+5O4wEFjNK7/BO9kjdx7IgjgmOUKFa4MWfnIAWxcfY3F6BSHrDIc0oLaWPYvaal4TmEoHI/6XgVPWFtzHVI6FdjOjRjCwkBe9Oklyjs1DbT+xnna4lhkWbNgOPe8bAD3vjWhwryZuD0+J6SFViqsj5lKuTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/JmFmOlLELu+Ho8csvEIDWoXKpJRMM1nMJTYZAkC34=;
 b=AIAr5YkDb5kPSnmQnKEiRAuBRMfubw+Iu3jofOCUG1AVwZFf9Q7dRsyIuM5fMijCL4cDWW96+5wGsIh4OfROJ0iYjVHSS+/wWQPibiei6xb8/1x14LDvsWpaMGVsQMHCM9l73P4Ze8GEeloYJiJF76hMqlAKcz4qyuUoOkWQRtlH9Pg/+KlC3aySivKkJ2rKugBI46V2KjAnezp5W/murfSy55iKfprIlMafvSpZr0N8gGpgTmdTP4afCwcrBIry7yXqsB8wi17cRPsZgkf1kH0L2/pTOQbTJNX6mrYD9du4uy5WLtFXPGCaB8VIlhCNH9uagPMfvyDvMXl/VRjswg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/JmFmOlLELu+Ho8csvEIDWoXKpJRMM1nMJTYZAkC34=;
 b=lJ/uRJQEwDnJmzQ6US5VWpz8ZuOIH9mwdfuUW2IZarQ0y4wDXXUGhPzDjce+Km+6y4fDhsKO75d4i//qmJ8NrNg39VxvYd1CPzF1Ik51yaPgJo94dCLQaFRv8rW6027/ROQAjMuYIXwRGGeCsMuCRCtsLzUQ5WVkycIFBp/4QY8=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by PH7PR10MB6355.namprd10.prod.outlook.com (2603:10b6:510:1b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.10; Fri, 27 Sep
 2024 12:43:29 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%6]) with mapi id 15.20.8026.009; Fri, 27 Sep 2024
 12:43:29 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: David Woodhouse <dwmw2@infradead.org>
CC: Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Paolo Bonzini
	<pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Marc Zyngier
	<maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
        James Morse
	<james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu
	<yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will
 Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Lorenzo
 Pieralisi <lpieralisi@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>, Shuah Khan
	<shuah@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>,
        "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 1/6] firmware/psci: Add definitions for PSCI v1.3
 specification
Thread-Topic: [PATCH v4 1/6] firmware/psci: Add definitions for PSCI v1.3
 specification
Thread-Index: AQHbDpvhaEWnn85b+0SYmsB4oiosBrJp14AAgABuLwCAAVK9gA==
Date: Fri, 27 Sep 2024 12:43:29 +0000
Message-ID: <CB344CC7-E6E2-4325-9669-9BE7EA47C56B@oracle.com>
References: <20240924160512.4138879-1-dwmw2@infradead.org>
 <2868989D-73CA-4208-8B54-CC3C78A2F1EF@oracle.com>
 <d23d2cdcab3a2fca5cb36023b42ad9d4a0c7ff22.camel@infradead.org>
In-Reply-To: <d23d2cdcab3a2fca5cb36023b42ad9d4a0c7ff22.camel@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|PH7PR10MB6355:EE_
x-ms-office365-filtering-correlation-id: 227286eb-1e85-499c-41fb-08dcdef1fcf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZWRSWXRVblVJdWw4bUNhQlppMXVROE0rM25BUW8xUkNqbHp3ZndQZXowVnRj?=
 =?utf-8?B?YkZkTk0wTGowUnp2aWxick05ZitsSEQ1cnJMSVVtZHpIWExEMUljazFhRTlQ?=
 =?utf-8?B?bStqS1JwRkJVMjE5bDg3Sldld2dtZWRGSDU1OUk2UURob0pnb2wrcjczUDBX?=
 =?utf-8?B?bzAxNnlVaktkNTg3ZFlmTlpKWVpmZ1RiUE5FSUZkZDRwVjR6bXF6bDZKaUNF?=
 =?utf-8?B?STg5dFFaQzJTc0NEZFdxTUhuaE9Vd2M2Qnl3Q3o1K1JiVVZrN0dkNmVTN3Bv?=
 =?utf-8?B?MDZNZ0MrNmc1Qy80V29TcnRNaTdINmFaazAxaU5CQjFLTXdHcWRpbFhQZkRX?=
 =?utf-8?B?R09KWVJHM25TeTROb2YwOVNieXo0bzJqazdMdHV4ZnBZUWZDeUoreTZZczRr?=
 =?utf-8?B?Nk9tb1pGTDNOWGl4R3dMaStoRTd2TngyZ1FjS1lkNHhHOThOaGpMOEM5MUdt?=
 =?utf-8?B?YjE5N1MzMU1UMlU2V0h1ZDg3SzU2RFJyV28zVGx6Ni9KZ0dQTC9SMThyZy9s?=
 =?utf-8?B?Y1pWbVlnT1owNXZ1R0pFWnBNcFY5Rnd2UHZ2U0ZLU2I3YTRZUm1vSG8zSmxj?=
 =?utf-8?B?R1NnYlUwNzVYTHhQSVo3VEZxUks4alZOeFByOUR0Q0prNU9KaEVmTzMvZFRG?=
 =?utf-8?B?NW81THlLZmVkZjVGMXVBRHNmMFgzaDk0SndENWZJTVUwZmxSVFNIdUJ6M2E3?=
 =?utf-8?B?dm5qczBIQjczR2xTTm80cHJBb3JrKzVlblpKMExtV0htYVk3RC82V3VVZWRi?=
 =?utf-8?B?REdXMXdxQlcxT0J2c3ZKR2F4RU5UZW0rQWRhVXlGY3pQZXlRZGdTcmlTWDYy?=
 =?utf-8?B?cFVhWEczc2tPYlZJblY2ajhtcGw5VlBTa2FUK29LWGFqTWpUaDFyV2lFckx3?=
 =?utf-8?B?QVYrSGZxTWVVWE9KOXFSV3R0ZkVGNjNIWXJsam03MmpRU3lTQ3hBWGkvVG9x?=
 =?utf-8?B?TTNDcTNQWU1lM0RDVmg4aTNlTVprVG1VUWlVMkdpT3lNclZVWDBieDBnQkRk?=
 =?utf-8?B?M2ZrVGFhajJ2Z1BpLzJkdFhtV2VNRXdaVERvcnFZcG5yTWRqdHFFZWY1dVRt?=
 =?utf-8?B?M0JPZU14MCtBQWpYZnVXWFRjL1VaM0xWNk1EZW5nQnVlbUFvWkJra0FXNlJ6?=
 =?utf-8?B?OUxnKzNMeHlDTGtPdFV1SXJpMHlZME1WSDR2a2NyVlVqRUdWVXNxcytpNHQ1?=
 =?utf-8?B?UmcvRlNDaURqUWR1cThMWlpGNkF0K2FITVIyc1Zoamp5dE1mQjB4OEU5dWhG?=
 =?utf-8?B?N0pLWDJ6SkRaMkNyVzN1Q2dQUGNOZTgwSjZOUDh3Rkd0R1o0RTR3MURWR1VM?=
 =?utf-8?B?cWhkcCtMbXJaSUR3UkxpTWRpeDBoZVE1eVUyZjJJL3A2WGFrMnA0am1sUnZN?=
 =?utf-8?B?TDNBTXRlN1k3cW1ROG9tRFVNdVE1cUU2R0R1dk82dXU1M1NXZi9WOERIaWVz?=
 =?utf-8?B?M2xIdWR1NDNERG1kakd2S2k5YUlwVDljRGlnSGZpcFl6Mng4bE91UlI5K0Jt?=
 =?utf-8?B?MDdZazRYWURjbzRiQ2Y4Y3JBbjRQbW5IYlhZRDBvWmRSTnA3VGRDVFhLdUpV?=
 =?utf-8?B?djlWbzRuVnhML2IzVVh3Ung0ejBYUm1uMlFIL2w1TGRES2FXZ0xVdWltZVpo?=
 =?utf-8?B?TEFVRDN6Q2RlU2M3SElGeVV5a1J0TFNYeWoxRWorZjhpaDM4d0FjcUtuL2Zr?=
 =?utf-8?B?RGdmUTdubVAwTmFQZHh5czNCVlMxU2dnUVdweTVnajBpNXVjV1MrTzJXMDl3?=
 =?utf-8?B?RzlEWEpuY3FtcWRIbnVORUoxTkl2d0F6SnIwMDZ4NGxrMWVXYjI1S0s0RWgw?=
 =?utf-8?B?a3RLMXhpWTRab3kra3dyUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cmhoUjVPb0lpWUM3QlViSVJoMUQ1UTdFRHViN3RhT2hDd1hId2ltQ2UzUHJ3?=
 =?utf-8?B?S1F6K25XQmdJNTV2M0hWRkpoL2s5SDV4TDEvMW9aK01KbDZibVhUZFdQZTI4?=
 =?utf-8?B?MFFqT0ZMdlZqZk9saGM3aVFFNlpIN3JEQkdVdTZHckJwb2xYVkZWTStUdDlN?=
 =?utf-8?B?ZEY4cUFuZHp4c0FIUkF5ZGNESXlManpNYTJHeWV5TDVGeERUamJpY1U5bXR3?=
 =?utf-8?B?VW9ZM3hLREV1WEsxVFpZd1JYL0tnMUdnRVdmK1kxQTdEdDBQdXVxWk1TTnMx?=
 =?utf-8?B?VlV5amVzWEs4Yi9TWkV3aUNtdDBFL3F0LzhWUzlPTEd3QnlINDRVYnZXTVVv?=
 =?utf-8?B?cC9FdHpDbExFczhtN2JCZ2JXM1p4WjZyQWV1WkVqQjZramlBckdjY2ZmVTJG?=
 =?utf-8?B?N0xvU09lMThuTDhHM0doODJxTENlRVEvZ1h2RmtidGg1aUhGQ05Ub2xzanFw?=
 =?utf-8?B?bWVxZ092T01Ic1JUTkJ1SnN2Tk9udWNFMGZUUTV2RVZ1cG9QeXJ2NGRKdWdI?=
 =?utf-8?B?MURYR1c5RGJYdVV3OU9HSFNWa0ZsZjIrVGN6WWl3djBDa01pT2xQQlZvQTlE?=
 =?utf-8?B?MFFUREk2WEl3Nzc3bUhtbm8ydCtVUU5lcUlUZGRZbUVQaVhJUS8vRENhSHBk?=
 =?utf-8?B?VTR1OFZxUlA4U1dyRFpUMnVheWdQQzBERk8vUUJaYWtqTXBaN1BIbnZDOC81?=
 =?utf-8?B?ZHZUa0RoQ1NEcEo0eUxvTlRXRFI4UmYvS0FNd2ZrWUJvYkFQaU1iMGFOSGkr?=
 =?utf-8?B?Mjc4d3RsdWxJQkRROHhqekdqMFluVXIzdXovWC9uNUpRRUtzalJsVGljYUQ3?=
 =?utf-8?B?dzl3cVFCMVMxSm0yOVFIbE9OeVVXd3cwdmNWNEY4TWhaSE1QVXdJTlJKamRN?=
 =?utf-8?B?L3hXS3I4QW8yMmtxLysvVDNNTU1qNEMrSElvZE1uMmlsNlJlQjgyNnRpbFd0?=
 =?utf-8?B?ZUtYRU9mU2tFNzc4NlBBMG90a1dZTkdxQjFWeDRiTFhVUmhZL1NOSlpLVnRv?=
 =?utf-8?B?M1BHelp6cUJucUwvQ2NQRy9mL1BRNzkvekRGb2JYS2dRSlZpN3hiMldyYnkr?=
 =?utf-8?B?MmNCWkQvVFRtbHMvM1FmaUhPRnZReWV3K0xtMGxQWmM1cjY5ekc0ekgwWjdC?=
 =?utf-8?B?TE1ERE5Jdk1KWlF4UGlVTEk2QmI3bU5ueUZud0gzeHZnZzlmNitSczl2V3lH?=
 =?utf-8?B?Z0xadlZmMnFmTG9JY2Z1REtscHBtYnprRHNGYXBZVCtaaWhZemZtbVlNRlg4?=
 =?utf-8?B?d3FrQTlHTHhsVlcwZ3BoTWJQelJ5SUUxMDNGR0dNVGVocXhrNFZpQlJqRGhJ?=
 =?utf-8?B?UlpFQWs0VkZVVXdUOEhlcDBCRHltOEwxMDZ5N3dDQUdOOGlaNlFtZENHWTV6?=
 =?utf-8?B?VU0zMW5YTXF2QlAyNVgxYVBnNmcxUzFFL21kMnpNWS9zeFpXc2tvYjM3WkZY?=
 =?utf-8?B?SmdQZmUvUjBIVURXSkpDc2o5S05Sb3RFbkswZWlpdDIvLzVLdDhPSDh0RXRF?=
 =?utf-8?B?UWs4WnFkZGxPVHVtTkdWOENORGJwMWNYWWFyNWpCRkJyRUxtZVVxRmhzcERv?=
 =?utf-8?B?UnVycjR6eDZRdzZNMkEwaUJWaFMwVDhUTmovWUxEYXZNeDVrbFY2UzUraEdW?=
 =?utf-8?B?R0RoRUxkVFdPR3BzNGh6WmVMOXk1cWt1QXpySzlyaHQ2cG1RVFJWRlJGYUkx?=
 =?utf-8?B?aVRGZ0IrcWllV1NjVzQzeG54cHNUblg2L2Q5aTkxZ09qeUFUT1FSdkdlaGl1?=
 =?utf-8?B?ZmlzWHBXckppQUxHdWV5WU1NRVlDbWZTeDlUVVBuM0gyQ2NaNjFVYXNhcFUz?=
 =?utf-8?B?M0pyN0E3MUhTQmwzRkxqbXFLUmdad0JGQ1JTZXdxWVpwRmtPUkVYUVBzUFQ4?=
 =?utf-8?B?eEhSL1BZeFRRd3JGMGVPQ3E5Y1U5QmhYTHk0TVRkcndXR1crdDVkMGNnamls?=
 =?utf-8?B?ZmNmSmxxNlkrYnZvWWpoSC9Bc0NldTExMWlteW1HTEppZDg3T2gxSy9GVmlC?=
 =?utf-8?B?aGZXbzZlYWZ6ZTNOZko1eTFObXVqUEpERnNiUGFKdjRleHM2NDBSdnlyWUpE?=
 =?utf-8?B?YTUvNVluY3lKZyt6UXByUHZHbWF6VWVINkZiUmxNeEhpUGIrWW1aNkFBbGEv?=
 =?utf-8?B?cUd0QTJxdTVmTmJyaURJcUUyQkppV0hHYkdVNFJwNjhEKy94WjVYL29NemJ4?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DD1D71AE233584D81F20B690958FF06@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/iHXDNd52nCq5E/fL1jkkmwkGHkEheNHvyokC7qWJMdUOJS70JZsuzNL5G8BjppTivGNlWwWw6U4cznIGQ3BhaLdWX+M2fD2Cw5zYJt0u0R9FOWQiS0CH3MWiBL5jhD47PIZ6LkHkvZisYcJTGjBb7rLyKQ9ocCxQPFMLOREKsERZ9mN8U/SnNlcsepkx364YpxfSwS+4B4dcxGdlQLsHaIVnm41hfJBK9HIbkuCrB5VnLyq/ADzU2JNt1DLKbdukPT4csCRkIgqXI6FZNdQXsm2wc6QUOkqDACUN3CcIehXxzBI6KTaBv+J30k6aukOOtD1jCKr1ZRDzsxpopoYlNb0UzPux9P5BauvulP9NZnZ1S0flNTcfAChHeVQlmNwnJnEQ3pjrMkQWlbDBQfW+NQM+NelL8uOeKf/VfR9sNYUNwcGh4NVgxPxtzgHTbfNNkxkJHYAWmwbm+JBENtjACQ087EzpnVevfK8V2FTyAWDtfnCQ+zkW8cHU2GBVN6jB713Tyijm0H9Z8IZdxqsAX7voLzch+ytbHjeZVWWC5qeUDpZxvorBadmWyBJXc/fAwcIeCOmOY8ihEfYS57qH/errrTSorxvPaGNS4rqUOA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 227286eb-1e85-499c-41fb-08dcdef1fcf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 12:43:29.1482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f4fF+ELR9efOCCqIpwxlPqjp8qM9z29FnsbTou7mO7SlNCXsGXSck3w9HYLbQMdP8Gq9IgtIEA/EuQsCogbNZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6355
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_06,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409270092
X-Proofpoint-GUID: DAnM0nju2QuajnO3USB9HYrDpRqOgC7r
X-Proofpoint-ORIG-GUID: DAnM0nju2QuajnO3USB9HYrDpRqOgC7r

SGkgRGF2aWQsDQoNCj4gT24gMjYgU2VwIDIwMjQsIGF0IDE2OjMwLCBEYXZpZCBXb29kaG91c2Ug
PGR3bXcyQGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVGh1LCAyMDI0LTA5LTI2IGF0
IDA5OjU2ICswMDAwLCBNaWd1ZWwgTHVpcyB3cm90ZToNCj4+IA0KPj4+ICsvKiBQU0NJIHYxLjMg
aGliZXJuYXRlIHR5cGUgZm9yIFNZU1RFTV9PRkYyICovDQo+Pj4gKyNkZWZpbmUgUFNDSV8xXzNf
SElCRVJOQVRFX1RZUEVfT0ZGIDANCj4+IA0KPj4gU2hvdWxkIGl0IGJlIDEgYXMgaGliZXJuYXRl
IHR5cGU/DQo+IA0KPiBJdCBpcyBpbiBkaXNjb3ZlcnksIGFzIEJJVChQU0NJXzFfM19ISUJFUk5B
VEVfVFlQRV9PRkYpID09IDE8PDAgPT0gMS4NCj4gDQoNCk5vdyBJIHNlZSB0aGUgZGVmaW5pdGlv
biBmb3IgUFNDSV8xXzNfSElCRVJOQVRFX1RZUEVfT0ZGIHdhcyBtaXNsZWFkaW5nIGZvciBtZQ0K
d2hlbiBCSVQoUFNDSV8xXzNfSElCRVJOQVRFX1RZUEVfT0ZGKSB3b3JrcyBmb3IgYm90aCBkaXNj
b3ZlcnkgYW5kIGFzIGFyZ3VtZW50DQpmb3IgU1lTVEVNX09GRjIuDQoNClRoZSBjb21tb24gZmFj
dG9yIGJlaW5nIHRoZSBiaXQgb2Zmc2V0IGluIHRoZSBiaXRtYXAgZm9yIFNZU1RFTV9PRkYyIGRp
c2NvdmVyeQ0KYW5kIGFyZ3VtZW50IHRvIGNhbGwgU1lTVEVNX09GRjIgYXMgd2VsbC4gV291bGQg
aXQgYmUgY2xlYXJlciBzb21ldGhpbmcgbGlrZToNCg0KI2RlZmluZSAgUFNDSV8xXzNfSElCRVJO
QVRFX1RZUEVfT0ZGIEJJVCgwKQ0KDQpBc3N1bWluZyBmdXR1cmUgZGVmaW5pdGlvbnMgd291bGQg
a2VlcCB0aGUgc2FtZSBjb21tb24gZmFjdG9yIGNhbiBiZSBoZWxwZnVsLCBob3dldmVyDQpwbGVh
c2UgbGV0IG1lIGtub3cgd2hldGhlciBJIGFtIG1pc3Npbmcgc29tZXRoaW5nLg0KDQpUaGFua3Ms
DQpNaWd1ZWwNCg0KPiBCdXQgdXNpbmcgYSBiaXRtYXNrIHdhcyBvbmx5IHN1cHBvc2VkIHRvIGJl
IGZvciB0aGUgZGlzY292ZXJ5IHdpdGgNCj4gUFNDSV9GRUFUVVJFUywgYXMgdGhhdCBoYXMgdG8g
YWR2ZXJ0aXNlIGFsbCB0aGUgYXZhaWxhYmxlIGhpYmVybmF0aW9uDQo+IHR5cGVzLg0KPiANCj4g
VGhlIGFjdHVhbCBTWVNURU1fT0ZGMiBjYWxsIHdhcyBzdXBwb3NlZCB0byBqdXN0IHRha2UgdGhl
IG51bWVyaWMgdmFsdWUNCj4gYXMgYW4gYXJndW1lbnQsIHNpbmNlIG9idmlvdXNseSAqdGhhdCog
b25lIGlzbid0IGEgYml0bWFzay4gDQo+IA0KPiBFeGNlcHQuLi4gSSBzZWUgdGhhdCBub3cgdGhl
IHNwZWMgaGFzIGZpbmFsbHkgYmVlbiB1cGRhdGVkLCBpdCBzZWVtcyB0bw0KPiBzYXkgdGhhdCAw
eDEgaXMgdGhlIHZhbHVlIHRvIHBhc3MgdG8gdGhlIFNZU1RFTV9PRkYyIGNhbGwgZm9yDQo+IEhJ
QkVSTkFURV9PRkYsIG5vdCAweDAuIFdoaWNoIGRvZXNuJ3Qgc2VlbSB0byBtYWtlIG11Y2ggc2Vu
c2UsIGFuZCBJDQo+IGRvbid0IHJlY2FsbCBpdCBiZWluZyB3aGF0IHdlIGRpc2N1c3NlZC4gU291
dmlrLCB3aGF0IGhhcHBlbmVkIHRoZXJlPw0KPiANCj4gTXkgdW5kZXJzdGFuZGluZyB3YXMgdGhh
dCBmb3IgZWFjaCBzdXBwb3J0ZWQgaGliZXJuYXRpb24gdHlwZSAjbiwgZm9yDQo+IHdoaWNoIEhJ
QkVSRVJOQVRFX09GRiBpcyB6ZXJvKSwgdGhlIFBTQ0lfRkVBVFVSRVMgcXVlcnkgd291bGQgaW5j
bHVkZQ0KPiB0aGUgYml0ICgxPDxuKSB0byBpbmRpY2F0ZSB0aGF0IGl0IGlzIHN1cHBvcnRlZCwg
YW5kIHRoZW4gdGhlIGFjdHVhbA0KPiBTWVNURU1fT0ZGMiBjYWxsIHBhcmFtZXRlciB3b3VsZCBi
ZSAobikgaXRzZWxmLCBwcmVjaXNlbHkgYXMNCj4gaW1wbGVtZW50ZWQgaGVyZS4NCj4gDQo+IEJ1
dCB0aGUgc3BlYyBub3cgc2VlbXMgdG8gc2F5IHRoYXQgSElCRVJOQVRFX09GRiBpcyBhZHZlcnRp
c2VkIGFzDQo+ICgxPDwwKSBpbiBQU0NJX0ZFQVRVUkVTLCBidXQgaW52b2tlZCB3aXRoIHRoZSB2
YWx1ZSAoMSkuDQo+IA0KPiBJcyBpdCB0b28gbGF0ZSB0byBmaXg/DQo+IA0KPiBJZiBpdCBpc24n
dCBqdXN0IGEgdGhpbmtvLCB3aGF0IGlzIHRoZSBpbnRlbnQgaW4gdGhlIGN1cnJlbnQgc3BlYz8N
Cj4gDQo+IElmIHdlIGhhdmUgbmV3IGhpYmVybmF0ZSB0eXBlcyBzdWNoIHRoYXQNCj4gDQo+ICNk
ZWZpbmUgUFNDSV8xXzNfSElCRVJOQVRFX1RZUEVfT0ZGIDANCj4gI2RlZmluZSBQU0NJXzFfM19I
SUJFUk5BVEVfVFlQRV9GT08gMQ0KPiAjZGVmaW5lIFBTQ0lfMV8zX0hJQkVSTkFURV9UWVBFX0JB
UiAyDQo+IA0KPiBJdCBzZWVtcyBvYnZpb3VzIHRoYXQgdGhlIFBTQ0lfRkVBVFVSRVMgcmVzcG9u
c2Ugd2lsbCBjb250YWluICgxPDwwKSwNCj4gKDE8PDEpIGFuZCAoMTw8MikgZm9yIHRoZW0gcmVz
cGVjdGl2ZWx5LCBidXQgd2hhdCBpcyBzdXBwb3NlZCB0byBiZQ0KPiBwYXNzZWQgdG8gdGhlIGFj
dHVhbCBTWVNURU1fT0ZGMiBjYWxsPyBJcyBpdCBhbHdheXMganVzdCBnb2luZyB0byBiZQ0KPiAo
UFNDSV8xXzNfSElCRVJOQVRFX1RZUEVfeHh4ICsgMSk/DQo+IA0KPiBJIHRoaW5rIHdlIHNob3Vs
ZCBqdXN0IGZpeCDCpzUuMS4xMCB0byByZXBvcnQgdGhhdCAweDAgaXMgSElCRVJOQVRFX09GRiwN
Cj4geWVzPw0KPiANCg0K

