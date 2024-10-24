Return-Path: <linux-kselftest+bounces-20538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0121E9AE2DF
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 12:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229611C20B97
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 10:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA01D1C07D1;
	Thu, 24 Oct 2024 10:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HGV6a74G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mp1iEah/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790091B85C4;
	Thu, 24 Oct 2024 10:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729766589; cv=fail; b=T9db02MpM7XmBsRJVtC20wi+5qp5CEpYSqziHht/q/CrvVjOtLK9mh1aZt7n2Q9Z5Vi5TvjPwxYmCckKCOmIMyIih4TucmwOX81t8AwsVc3gQplL7PCwfaAsVAOoJe6BBPgqfVe52xFMj6p+CAWNGIHDY2kupuJ4ZbdkPmCk2tQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729766589; c=relaxed/simple;
	bh=GH2uLW2zOlUri+mfAe4HvhtBBcqhzZZLAuV7PaIcuTc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YRHQvFJdYqSUht1qaXOfRKAIUUGmhZWdfPx6KgavvsMZX+TGzvX12KZZhb1cgD9ty/0P/rT1uIWjbyGMA7o3flGc3zQm+7mH62d9Rb8bIhTFx+elNuyLhJXldAAfImXUzhDy3mej2dwX75s4vO9E0X9tFBqE3P8S7fAbNj1ynyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HGV6a74G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mp1iEah/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49O2fb8C021571;
	Thu, 24 Oct 2024 10:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=GH2uLW2zOlUri+mfAe4HvhtBBcqhzZZLAuV7PaIcuTc=; b=
	HGV6a74G6AfR7pNb8Vs84+AgrOp4GDxgLslyxVz1Caje/P0zPcmCq9UuronWRoAt
	NDpEwRg6ssNWn97dxcN66QBQAVn/+mW8Xnaxj2sTg68h+k41yuTYzcbaGyrT2h3h
	VKcvjf30vd6dyW/SXN25jTISUQ79rguRccDj6OqyTtY6FLW2ZqQSdLWlKH8Eo1TK
	o/DE+LJjUII0OzSzAOYtV0B7x1Npg2n4LX535zvfYxvANl4/aQDhrciwJ3RH1/rZ
	2XFpKETY9TxximXLEupL4iIn/MJKgv7ksvGFscVf95W/OrryN5dqpXZ+0G1HeaD8
	v+GmY8UUsxwV4P4+Xqa1jA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkr1jg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 10:42:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49O9pq6P030987;
	Thu, 24 Oct 2024 10:42:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh2r98h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 10:42:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snZlgEsbYuwOp3sEbfwJUN1PY/yTEb94/cY3TXpABEr7q5pRpilZ1wsLMvUSz10wjIYU99UJ5CrM5OVeJPv0imjwTynKAShdEi1o8aLtVwuYslNtVTYGUNHhXaH5EcnOzn0p5Q/BVSDXA8aLXABJZuDKo6bFBafudNSU+PMIwSH3eg4m7FRE7uIJOF5gOkcQrD9hfJIaVNv6DnfibgF7V+dWViWTu2nRPUi9N37VXOKq/r85MtKBiZ4dPDzVRtASAyoXxI1JpFXvwVY8IMFHVmOTXDOYf6qG1DT9jpRYcwxWL+tVHWAy3t4nsBWOMTERcjlQxdXdc4PqO46wt0XKTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GH2uLW2zOlUri+mfAe4HvhtBBcqhzZZLAuV7PaIcuTc=;
 b=lPbzRVmL/eFP/aitKLPoBXc5Csm3vbZLD0BBYW2T7YRj1rWLE+S5g9+lwZY9SyaT1C5PXfy4ZC3Ml2jw6R7k71GKzzBJyr3+B6Sr1R9p7S0O6qa/uHlQ95bsX9+t2QKYSO5bjDBrz2skUbEQx5g54HrHOAQguSIUY6o9oRqizL6OPpIyfj4V1wRyUUMaGqRmjZWl2WSegbytcKxlHaVFYTKBlhVJ0QpwOrxUNUACNGyFe0is6+fkbmbQ1QqbchsbJATRNqg6edtTcTZvNDZRYTp9VGxPLx2dUbkg0FJO2n8rzd4KuoUvRRyP26EVqDYPx1tRiZAmp4vr8bF+rtjnsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GH2uLW2zOlUri+mfAe4HvhtBBcqhzZZLAuV7PaIcuTc=;
 b=mp1iEah/Be7O2UtBTJe6xJEXAmMaE+K0HVaGW+fgAhMt02xBuaiK6U9rrIv8Qs84bZeewekjl/x/wAvw9+62lFstYXdnHYJG93XB7q5TpEg24tPmJDcdXe6PZH98fWLrIkfUL2vvlkVhw1NSwbCzsC7z+wfdFQlsAaMm8RXKiMU=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by PH7PR10MB6036.namprd10.prod.outlook.com (2603:10b6:510:1fc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Thu, 24 Oct
 2024 10:42:34 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%7]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 10:42:34 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: David Woodhouse <dwmw2@infradead.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
        James
 Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Lorenzo
 Pieralisi <lpieralisi@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>, Shuah Khan
	<shuah@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>,
        "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        Francesco Lavra
	<francescolavra.fl@gmail.com>
Subject: Re: [PATCH v6 5/6] KVM: arm64: nvhe: Pass through PSCI v1.3
 SYSTEM_OFF2 call
Thread-Topic: [PATCH v6 5/6] KVM: arm64: nvhe: Pass through PSCI v1.3
 SYSTEM_OFF2 call
Thread-Index: AQHbIkvkaVUmDaGoVkWNgCx6/MRr/7KVvjgA
Date: Thu, 24 Oct 2024 10:42:34 +0000
Message-ID: <29F1BA71-4271-4D95-A8C6-3A2F54EE72D9@oracle.com>
References: <20241019172459.2241939-1-dwmw2@infradead.org>
 <20241019172459.2241939-6-dwmw2@infradead.org>
In-Reply-To: <20241019172459.2241939-6-dwmw2@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|PH7PR10MB6036:EE_
x-ms-office365-filtering-correlation-id: 97f80da4-011e-4c5e-740a-08dcf41891d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1m+vykZJZtGoVkz1ejYKNdoJWtc9/NHgT0amMLxCrvkWCDv1eYGVM6rBXFRm?=
 =?us-ascii?Q?J0BWRdqztVhyUimVeB3CJxtBoo+rsxG2N5re7VCTJoF2KObFd65tP2OQkALB?=
 =?us-ascii?Q?hoW8EOR5fN0zab4owRS0p3CuiE83DThh5zU4jFsFJb5YvqknQTkv0e8VuOPG?=
 =?us-ascii?Q?oJ8lKCSACRraTvo99T7hLuSgDlpI+mhz1ulAnz0H35j437wGOjQoWhJoMXqq?=
 =?us-ascii?Q?ML+CPXRrTzL4a+PwpAKEkJJf7C4XJ0KHi3S+danu1+8sPjZsLu1HZ2l8ca7m?=
 =?us-ascii?Q?vx5mrWxD68bxeBdLBOSnKKnhFJHTz9xc0gZFzNaAzS8y1GNBgDT1nvATwCta?=
 =?us-ascii?Q?Psu8ShDcEz33jYQ45DKUZDsDqlheKJhH07DxIWId6QT+EyaPL+0wD75yU/2/?=
 =?us-ascii?Q?UG1syx3faX3apOjbnygxT/xDqiNXuyyBONbW/gVA41Mo7VcZfTiuz2nrqS3M?=
 =?us-ascii?Q?Fr9PySWKMkLJ2x8dJrQHe+bO/6w9gzr4wpyq8019MkSRfq4UnNAJMXyTnEVb?=
 =?us-ascii?Q?kPFNaR4WTYPINZJ3DnNF10j+u6c2LOpvnPimXIcfq/UEdFc1jHOxKLoIapga?=
 =?us-ascii?Q?8Nn5fxHUGz5CRfjXk1Qdk00ymHj4J2NaC+MxrCIZoygx5u7EYULPywMjASX3?=
 =?us-ascii?Q?49qdh2WnOZGRps7s4uRHXzibc+HOg49E/oDhQMo1FaOq2cHwEWphK8CdmFyT?=
 =?us-ascii?Q?elY4cR00ZoUfSnOW1PcQ8CUNmKReN0LfZcXOoZw488fG7MVAdnA6kUeB4TCH?=
 =?us-ascii?Q?t+orQCF7nhQxQ1gRz4BauZ+nVAJtcDoKAHjraDERed5j3B36kbBjiTW7ODwS?=
 =?us-ascii?Q?zsw2lwzfPxLjYk+k71DcuPqa7ieFXP50Hqf9Yeh/SNek+DmE5dehEPlVzM5Z?=
 =?us-ascii?Q?9gsqCihSXYCKjRNSXXEyL2pIUyD7QAWe+nEiabMDAxroZGpmPxgQH0rfHih7?=
 =?us-ascii?Q?u44U0/MzvER540vWDEsjvoY93Yj2BI+5Io98Ie2bcDoACiWXk/9Pot3mXSK3?=
 =?us-ascii?Q?hj+3T4ZMykgmXnP2wesdB7YE67F/kK/tlZWHvyeBOxVGd5YLT65wdCUDBrF6?=
 =?us-ascii?Q?eqA52qGZOe6d5nFbhVXtAL8fvaYKyj4WdhGcdnCCE/oEKd28/HhaTgPyIQKb?=
 =?us-ascii?Q?aTiEJBWgdsSbrPOLcXQeIhBHdkhc00sU3is9js2I06+vbPzrUsVdVSq4XsLN?=
 =?us-ascii?Q?cqTp6uMVrBNRkF6L3b90Q4uxHX66SYyp5KzbkEbiAGBBcgpPsL4Z2Rr5U7YF?=
 =?us-ascii?Q?gEBalXPed+ZUTWl4X0PniGVPCzrXpDHJtTsjk50NmpRulKgyZJoQsTYMrS85?=
 =?us-ascii?Q?FNr6BDkrOXO0PQX+9faNP0hwj7VWkJNkmIefweWqduNuq7uClLHf8UjAkONY?=
 =?us-ascii?Q?djMgoOQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PDy0zm9DuJNaxqjtVOV/kt/sbJBrV9oqBxFZ/yLn0+1wlm7T6AfmZ8Hf75Hl?=
 =?us-ascii?Q?hCoHMpla/UYZQEcHgPEkx+wFw24PKvWnuonZt1Uc5WISn4KCDqI2Czg7IW6K?=
 =?us-ascii?Q?Vih4A2LvxSfuxWxvEoa+iW5oKIJl6gd7BNWCcRhrhWvMVUKSshrfszTutogr?=
 =?us-ascii?Q?aVgE5DcjJ0JkEw4eIAuYJv15+KBICG4kq6H0oHBoHTJTL9YU09WIPSn/kzJ6?=
 =?us-ascii?Q?PC9exHX93REIHCHCf9FI3Lea62gOoqRDBhBQenl3TCyNAwFt8XjKH05uZvjL?=
 =?us-ascii?Q?N32Uy/Pp7l4hxAjcAVPEyKT4X+4VDrvkIm3F2cEwS1PJe/Wpk+nGbnXbxjVs?=
 =?us-ascii?Q?dF6emUsLXfSre8hIxBNCpV/XFF5tqXnIn2tE++Y6xV6qgbFNVnP6A5K0vFIg?=
 =?us-ascii?Q?BwG+5S8jUIiCCtxFMncpSs5SmW5d4ls61NLf+y1TdSCHsq2g3ilYAgsLL1gH?=
 =?us-ascii?Q?EIiiWQT5xuRn83RHmHqDxSSmvZyMttF7Kxz0lJO8pbYcgbjNFvry1h0FrXqy?=
 =?us-ascii?Q?/fdmd87Vqj+YOFDAAysl5Y/a/YliyCmDKiH++sDaIwSeyJuSK+oMml9xbzZW?=
 =?us-ascii?Q?sS4D5c+1yu7VZ6rPBNkuC5ksYIaAUBi9of/6coc9kJLf6pgUbCz5UqnC/H4q?=
 =?us-ascii?Q?4QpMidlaoHwLtSW0DvPiGsBkSgIaYoL15ivcHyU4Y8QcHtK4wGTtlrq/WBR4?=
 =?us-ascii?Q?oVOCrzg+FBZur57R4FBWVyVDgIhDZNcZgsazziwrGTqpY9OO5Bw+cb4JS57C?=
 =?us-ascii?Q?vRuGTH22UpQVDczB97uPq2c8doqbqMAxpbJuMHrA2217o8lUV/PaWBRDDMoA?=
 =?us-ascii?Q?bVJTD6Xp71K+xUfgeJ/x272cyuaaoubsa0QzY9OjCP7MxQTjopTu8XmppFOT?=
 =?us-ascii?Q?1MEV6kSr5eZ1GAwPZjAZNmO0MS2bG+eIaF5xKA9B2vuotZwpyjiTlvCowF+w?=
 =?us-ascii?Q?zqXKDhNVWouk4whxqp+2yrbSUsgAmW+AP/XGWpJlNdO6Md61oUChBUiLt2cD?=
 =?us-ascii?Q?Id7LJ7IziXm5Q+c5AkEy9qomVAv+Sr9DMMA7D0DdBcRjS6QBn9J71IQP0io6?=
 =?us-ascii?Q?vYzq1wCstAlO9h4HTiK8PrxlqixQpC66sv0CHvQ9SSc9yXmy/rX4WnB4d00p?=
 =?us-ascii?Q?G+uXyLA+cotL/BtshuY51lLNc4qwl6zwjEPclee7DfT6Zdb4R2cRN7kFcEHl?=
 =?us-ascii?Q?uCrSBToHKJGkBY+DPb39NwwrdJHRoiUJh4Lb5zkpzFlds46i9eLjhdmFh2fV?=
 =?us-ascii?Q?qasyhLDHJc5G6t7qe1NWOI2iMR2l40m0R3o70cymObVZYhTIQO0CWbsOLsyU?=
 =?us-ascii?Q?nbLaC5sEP+FvvkRKWeiWynTMCKtyo9LoB2AfvJW6TBDr79dlvdUxHOBo4fcw?=
 =?us-ascii?Q?tzHsWBhHVlsK+TKGh9hO1RfAMqzHOLM044+3XObTmQ+a85BddF7VY2rxpWCS?=
 =?us-ascii?Q?eorr6dPRGPmOEZEeNKPN8VL/SC0INF+CKPB6rr/TpjkBJ6sh+d8A2r3hlrjU?=
 =?us-ascii?Q?XA5a83IJImJ2bI27xnalc8GLk5tox8ckTHxvoMmO7LCyQB2bEEp2evDJu6Gz?=
 =?us-ascii?Q?9KFUOygcilsROgMpYWKgNIM/tBJLVuV6DhwGVf/CYdhTEWG65t+niMGcoikQ?=
 =?us-ascii?Q?Sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B8064D500DA7D04B9AA36F5D5A14AE81@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QBQP7A4f8yyJ63OWvRMqr69mYjDueNWz75c3zbZFOCZIv6sZC9dElYrU9ekjfwYDxJvFU6AUAWZ9w9qQwQyBZ5U5E3/jpe7jkwjVXI2eiLAGGzHrjhcstwI7wuAQPzslTAtQIqGs0JqiKFbPrrYSlFUCrrHHxLdYaFmqjbBFaAUsMXXUN2IbhrsFFCH/AeQv3NVSDEinMibuXPhOBZqX2zkU19NphdIxb6m0V4fiO8BI+j/MKsCp5sav4LpEJ62OtWpZSIPVqxXrrs8OVRp96WdFG76znKb3gxJC5MKVP0oPtGXgWc5xX8CM0zukzp404H0reMKZF1Vb4iTpYaY8upq0knRYXUGD83lylF044HMnGGU1+WX+wgqjw8UUmPmlteAkk7u3NQ8mDxGg9Jo3SzKP/1ykCPfKOlARg7L3bEnBmUizNV8xcECY/kgrtpHhDq5WqcmJqve4ePFDNwb7vWF5NjNvGSspihQSegLGeAUyQPiNrC8Wn/B6oTMBIvbYPcLMzsQdHMEVLy+7SGTS88ENArRZlyS6ktKat16lsFhmCciT8IusBL4A9vdwzbgbZrYokD1r8R8vKywUjSgF9AG0a1GjP6GeRoRRaa07DxA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f80da4-011e-4c5e-740a-08dcf41891d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 10:42:34.2966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f87xub+L/q+9IdVYZ4B2pKNwmxc/BuDIIfW8jI47MQCRXoxe8MvmzrIpw0DkihSj/yVRsp1dY9fqp9c72jzmiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6036
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-24_09,2024-10-24_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410240085
X-Proofpoint-GUID: c0y-T63XQii4VdPXI0mFtSfuO5Nzpn1V
X-Proofpoint-ORIG-GUID: c0y-T63XQii4VdPXI0mFtSfuO5Nzpn1V



> On 19 Oct 2024, at 17:15, David Woodhouse <dwmw2@infradead.org> wrote:
>=20
> From: David Woodhouse <dwmw@amazon.co.uk>
>=20
> Pass through the SYSTEM_OFF2 function for hibernation, just like SYSTEM_O=
FF.
>=20
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
> arch/arm64/kvm/hyp/nvhe/psci-relay.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c b/arch/arm64/kvm/hyp/nv=
he/psci-relay.c
> index dfe8fe0f7eaf..9c2ce1e0e99a 100644
> --- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> +++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> @@ -265,6 +265,8 @@ static unsigned long psci_1_0_handler(u64 func_id, st=
ruct kvm_cpu_context *host_
> case PSCI_1_0_FN_PSCI_FEATURES:
> case PSCI_1_0_FN_SET_SUSPEND_MODE:
> case PSCI_1_1_FN64_SYSTEM_RESET2:
> + case PSCI_1_3_FN_SYSTEM_OFF2:
> + case PSCI_1_3_FN64_SYSTEM_OFF2:

Reviewed-by: Miguel Luis <miguel.luis@oracle.com>

> return psci_forward(host_ctxt);
> case PSCI_1_0_FN64_SYSTEM_SUSPEND:
> return psci_system_suspend(func_id, host_ctxt);
> --=20
> 2.44.0
>=20
>=20


