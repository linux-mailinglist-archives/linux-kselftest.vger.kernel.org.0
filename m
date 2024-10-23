Return-Path: <linux-kselftest+bounces-20483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFAA9ACFA5
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 18:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 275322827AE
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 16:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2AE1C9DCE;
	Wed, 23 Oct 2024 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kxwQbyg7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J3edG57d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF76211C;
	Wed, 23 Oct 2024 16:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729699373; cv=fail; b=mjnziesqFAKKUAQGcA5wrlHcBTCrgCCybI++4UzwcVtGJ+Y4l9K/Wkmt4vrzuUqaNd2+pUZyWf/jFLDqBRGkVxoF1fFredfmhSFjs49M6YebELnerGTS5LoY8Jr72n9BQczDFcm3wEedPhWsnIBur0MhmOnkjVRspRsx1u04kKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729699373; c=relaxed/simple;
	bh=y7zAQAqXjh8aBxlI1UEoAwos6T0nNa88NqZTlRAPrUE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sx4zKLntL3cMI6t0f9HB38T+eFhBrdrXdp9crq3mZIais5Z4n9rfeHDwi6LEGOB0QwxC/CymBQ5M6aTWt1/Knp6WSE8Zv22Tqqt5o57yxscR1UztDIijVtcbMoxJBrNkld/arBFYmypBCiEHVPho+f5UeRFcJg5P7Vj0dCuKKzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kxwQbyg7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J3edG57d; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfafI004637;
	Wed, 23 Oct 2024 16:02:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=y7zAQAqXjh8aBxlI1UEoAwos6T0nNa88NqZTlRAPrUE=; b=
	kxwQbyg7cVQDGs//cDjqlC/eiB3XdIu5HTOJB2sB64CpZFggXtD/G9ClNZGIhCQf
	pmjEkF5sJY6b2lsdMVXEkcK4DEHGwCokZxogR6UTYpwFtYnAZk809Uc1kEYXphQI
	ivWz8Wab+pTWCTdZThwL6uatyaHJ1xXf2lquJ4ZdB0x/1sPQi/dWKhRReTuLGBoJ
	+Cl2W6YjhGNn5SvaWeevLRwDuivpcZeH6d6fbItNu6HnW7+saKsYrIToZvC84LhT
	UFPsD/1Q0/wxRu6jaWyR3DEd8mqO1Kidxt/mnzVCiOT4g8HMXcoPTc0CS1r5XTqG
	yndig0aSnxihLP6byrCqDw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5458mw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 16:02:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NERcu7018441;
	Wed, 23 Oct 2024 16:02:21 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhjr7xy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 16:02:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqR3Bo1BLYdAjtEkkHNydqkcrUB3L1OGIGTY+ForZg44d02VT3t8JRy2L4QE+IKn9xuIN/z+3xQh+NR0fv43UpbhxhyyLCUWuBLC6+r4c5Unv8drMpxJsXRaIeJ/yh/Kjli5FiIYjlL6CL55cu9sZosFicd/ViO7afREsXspFNWccKcJ9z9/hkEQHEBpCHKVucm2HJhWsrprhYUM/k/EmwjepYJmW1Zhv4uDajfPD6ub/R6yv5r++Awyc/dXwLY8U45PZvaD0u6irxuYTsSmrYfudSgAPeYpBA+OOOywY+nS52nA+tWp74U1+kT/ScvWi1NDT48JKT0iDp5D8pvPKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7zAQAqXjh8aBxlI1UEoAwos6T0nNa88NqZTlRAPrUE=;
 b=WdbToVmtZ1zmqFShKLCoRQdg9o1laesmJuu3zy1WEpikqOBxekmgVZBM5eVAKiePkZe9JXAiM/ShpH9wA9YX6Si6UiWa+BD+SPY5XWoFWQYqeeelzGHo208Tdb6rAWaQwVg6at3tBiM5K3Pvy4fWcUKpyggIL+nrnj3tDEl1VPW2YBC3ItRzKMxsh5wyz0qH1Q8a0LjeN2NPIq4cTHPgXnI6c4PuObljb2xr539QV6qdFsd62roknYU6NZiprcaLIp28JcvQlnmMuqlf5efQ3bdOr6AxrLZXEHtC1wuUF0LhBJuLAJkLgh1z72q05faXA79P3kdLt6KqTq8gO7wfqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7zAQAqXjh8aBxlI1UEoAwos6T0nNa88NqZTlRAPrUE=;
 b=J3edG57dOvupxhTgJEbOmbNiiLeuHCL0xV9yfYmcc0kCUham9J1y5YDqfsC/GUcTeSIE2AsIUNODjK4RV+V5doNU981G0MCbetp/puZTmc8WUuFp5EJ1VHsdRswhdt3S196Nmq1Xz7DO/6ysnE2Hdz/3YQItqyt4hsGrXPy/B8M=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by IA1PR10MB7335.namprd10.prod.outlook.com (2603:10b6:208:3d8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 16:02:17 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%7]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 16:02:17 +0000
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
Subject: Re: [PATCH v6 2/6] KVM: arm64: Add PSCI v1.3 SYSTEM_OFF2 function for
 hibernation
Thread-Topic: [PATCH v6 2/6] KVM: arm64: Add PSCI v1.3 SYSTEM_OFF2 function
 for hibernation
Thread-Index: AQHbIkvjPjlFuVy1RUSTjGTs0GLeFrKUhTgA
Date: Wed, 23 Oct 2024 16:02:17 +0000
Message-ID: <006C5A0F-CBBB-4CAF-AC6F-AC350A412281@oracle.com>
References: <20241019172459.2241939-1-dwmw2@infradead.org>
 <20241019172459.2241939-3-dwmw2@infradead.org>
In-Reply-To: <20241019172459.2241939-3-dwmw2@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|IA1PR10MB7335:EE_
x-ms-office365-filtering-correlation-id: 90917f84-d511-448e-63ef-08dcf37c1161
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L0ZzTldyTzV1VkE4S3dNb28xQ2pEZmVId3JqaURiQ2RrTi83clZaM09wSXhR?=
 =?utf-8?B?WGNiQW12QmhtUTdIUWdVdmFNL3dCU0FYQVZLS0ZvV1NrdzBjMXVhdUx3T3do?=
 =?utf-8?B?WU1WbXMySkt5Y3U3QTRGNUx1cUNBbkpPaDM0T3dYNUJCTG85MGcvVUNOK2Ni?=
 =?utf-8?B?N3B4dXNUV1E4ck5MNlhtMy82aGN2S08zMlBGUDA3cElqeHBYb2VYWGExVEVS?=
 =?utf-8?B?QUFtSXVZenJRT3FmbTJLV3VDOFA3QWVpQ1luNERJcFJrUkRwcW9tZmZmUXBj?=
 =?utf-8?B?aTZJSlhmU3hTYlorUGNSZFR2Q3pFcEtudnhKWkZzcGhlRnlaYmNXdlRNem5j?=
 =?utf-8?B?RmhFQ0E0aHVCemNFZUNla3YzNzJTWUNMQWZxamZtYlFDU3p3TkpqSVJoTTQv?=
 =?utf-8?B?YXJwQWt3Qnk4ZURhQk5leGlUR0NvTkF5c2NuSWF5cFcxVURSS1dvRHYyQ0Vk?=
 =?utf-8?B?UVFpUEdyWWkzWVEvTXhhS2thRHo0cUEyQzJWSFIvbkM4VjlPSjhVVmo3SWE4?=
 =?utf-8?B?RWZOUGk2cXpzeEd4NHNlRFo1aldwVWxndzZsWDhxNjlUZlJXUTVCQmpiV2pF?=
 =?utf-8?B?Z3NxUzRxc3lzUFNoL0FIUjlmMkhVaUpqdjdTM1FWY1FHRW1ITjczNXNXZlZz?=
 =?utf-8?B?djhXblhFYUdNZHhlWTc2RkorQnBuQkxnVHoxRmZCZm4vYzhvWXBCV0ZYZFhT?=
 =?utf-8?B?UlBvczJSTTFZUUFmWmlXd2Z1NWNSZTF4YnZrR2tZaVd2dTlkOGZ5cG5ONXFx?=
 =?utf-8?B?SEplTG10MmdJelFQTm1PUUY3K3BoZ0haSlZyazhzQWdKdG5vMWR6U09uOWN1?=
 =?utf-8?B?VDkyVW4rYlg2OStVaGYzWVNzaVFXQWg1Ri9xQUV3dmFma3V3azYyc3gyL3JG?=
 =?utf-8?B?bWRCSGgyNWkvbCsvMTFxL0hHVDZlMEg5UXNiSjdCdmhWT2RvaVY4MnFOTUI5?=
 =?utf-8?B?Q29qeW5JeE5CWGxyQmZDVEt6V2kvVnJRNGNwOGU2dkNMa0VwWXZsNDBWV0tm?=
 =?utf-8?B?eTJJM0RvdlRBczNQTTB6NEg1RXUxSTBKVS9tdDhOQWtrTUR3Zks2SzYrblZ3?=
 =?utf-8?B?VmJySzBkRjFZNWFNSmdQYzZPVkJuU2MyQ1lCT2NIZ1ZOaTkydHM0RG5LazZI?=
 =?utf-8?B?Vkh2UEhUalRtRm5wbWQ0QTRxMWZqb2N0SnhWRnZYL1NGOEh4SC9SZ1JQa204?=
 =?utf-8?B?UTlVMXViS2JqaWRUcm9JRUc3emROeDRzaGdEeHdrMEVNaG5jdm9YQStZTDdY?=
 =?utf-8?B?T1lod1FhTHVIa2Q2L2VyVTU3c1pVV2RISmpjY3ZrbUNRcWZrRmZBSkdGdUVK?=
 =?utf-8?B?ODlvSWE4NHBHVnNoR1VrT3RvWEhPdGgzN3Y3WkE4SXZOd21TV2UrUWJQMVdu?=
 =?utf-8?B?KytqZ2J4K2wyeTJHa1Rsb2NGS2Y4NmJFVVBNKzBCeTAwWWZpM3ZGMjB2UXRJ?=
 =?utf-8?B?N2VSNzJ2cjZ4ZkJRcGJ0WXd4WmZ2Sm9JT1dpVVVpaHI3cG0veFRlZmxQTDJW?=
 =?utf-8?B?QVllMFZVNEdwTGlLY2tSbitUUVc5VG44ZjJRMXZ5TGpwTVFyeDlGRS9kY1Vi?=
 =?utf-8?B?UWFPZUFvRlBFT1d1OENOT1V2M2wyS0ZjQ3I3ZjhBL2JjVUZEcUVXaXBvQTUx?=
 =?utf-8?B?UDlpNVZsRS9Kb2RaV3FraCtNNWdZbC9hbHlDYU5OcVllQmxFOUtPNFl6UU1j?=
 =?utf-8?B?amFCcmU4aVlmdHR0UHFGeW9LRjdHNnU0eTk5dEpQOHYzUUZlclQrcms2U2Nt?=
 =?utf-8?B?ZFBpVFFBOHlmZW1zWTBuY2FWMmhUaDVXYWROQ3RXTnFkeUVYWTVPNFMyNnB4?=
 =?utf-8?Q?9+u4dMrjxyl9mq7LmI5H/Yt6qsUFqCLBdIoQw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ek0rUFVLaTZ2ZklXNENTaFQzSlBYRVdGTVdhV0UwWVpzK2FQc2ZVZzhsS1FM?=
 =?utf-8?B?SG9IWG9LOWJ4NHVhWTZvY3lsU0VPTEF1M0pGN0gxK1d2RFNNWUlYdkhaQVZL?=
 =?utf-8?B?b1hNTGxpQXh5Y1RpTGFqVnR2STdndFNlOHltTTR2Qlg0OTRZcHU0SkdNS1NQ?=
 =?utf-8?B?ZGZyYXV4UURYY3FBenJLU0ZydkZhb05EQnZ5dlUwZDNmMU9xNFhPelZWZ2FS?=
 =?utf-8?B?ZStCWEFEODZJMnlLZTBKOURKOWI3ZXhoMkFMTEFocElVVEdHTTdkZzF0WE1Z?=
 =?utf-8?B?a1pEcmQrLzFPcGpFUStTVDZtL3RaY3M1NHp1eWVweU11QzJHWElqc3JIeUJ6?=
 =?utf-8?B?dW1yRkRGR3FLSXdsb0Y3RlVNazY5a2tBRzdGOGk3d3JsRlRJa1haYjFaNVNK?=
 =?utf-8?B?bmFtKzZHSVRtR09LTmdmUDRnRUl1TjV1ejlOeHNrQ2Fmd1NhQnp4WURPM0ww?=
 =?utf-8?B?dmNmQnh1MGVaWmxkUDdVY0lSUVdmcDlzOUt1R2V3UitPb2h3elIwdnQrTzZr?=
 =?utf-8?B?VStrZmVQK0FvbEU0R0FkWEVMdmc5SkZPc2FlTjAvWm12TE43V3FvYjVMYU44?=
 =?utf-8?B?U09GcU5DRkRVSkJBbG1DU0NJTGJ5dUg0NEpqVXdIMC9vZ0p2MEZJMUlUN0cx?=
 =?utf-8?B?R2MyWGxFVkM4akxvSTZHVHQ2dndyVWh4dmJyTEZ4L05sT3IyaEEzOHZib25u?=
 =?utf-8?B?aWZqY3RsZHcxZFpkN3IvT0hzQWQ0Q0VuOVBoSmhHMjN6MHZBMW43VGhTengw?=
 =?utf-8?B?aTZnbE5tbmltcm01YmxobHlZRkkvUmpGa2lLNmlXTTRTVjdzQStCVjJUOTVr?=
 =?utf-8?B?cVhFZlgyUVh1Q2lpd3F3bzBKakVrN1c0VUxiUzlXNzVjNys5Q2tnUmpTRWYr?=
 =?utf-8?B?WlUvdVVTcmdMSWdqMU43Sm5jTFNRRFZFd08xdVBaRVNqa0VlMG9PckU1cTBX?=
 =?utf-8?B?WE5KMTlHbkZMYlQvdWZ3d2dTQ0JGcnNTb09IZ2hjV3JBS1lRUHlFalZWZTNU?=
 =?utf-8?B?WVJwdDBVY0xBRzBwZ2dkZWUvVjVFd0JNV0lpZ3VHNXhMQlUxVFYzK0xxQ0RK?=
 =?utf-8?B?Y0lCdkJ6OGUrR3JJNVdZQm5nTHMzQlBxczI0M3I3Qytob3F2RWNXMWhCNjV2?=
 =?utf-8?B?aXRLd25TRmpCMVFEUk1KTTVpUWg3dGhPekx0NUlJRWExaEVWMjdpdkFKRjFJ?=
 =?utf-8?B?cnVCMHRyWW9UbjlTeTFiTVNNT3c5dWxxa3RkQ1lOdldzNklMbHF0MFN5VlR1?=
 =?utf-8?B?YVlneTFlaXl4ZktHM0VSMUtDNUNmekVvMDZzdHpoRnMxTHQxTlBNQnRnc0Jh?=
 =?utf-8?B?TTBRNzAvUUFSWTNaTmFxUVRCcERGZnVlRTI2dHhaZlgwM3Zmd3NIVks3em9Q?=
 =?utf-8?B?U3ZyNkMxV0ZmL005c2pieGdZc1dIc2krQkgxc2F1TXphYWZIMHNwWlNIQW5l?=
 =?utf-8?B?WGRNT2xaUDdKbEZUVHlGMkxnZkFHODNQa1pkK2c4VnRVaHhZeUpDb3I0WGJp?=
 =?utf-8?B?OThhcTg3bi9uS0lFQnE3ZGh4L0RicUx4TEU5WnJOSUd2K3gzbktoWlg4cFR6?=
 =?utf-8?B?Mjd3c0VBZlh6NFkrNXUxeTd1cmZkY3Z3UkczMFo1ZXZBWkthUlVOaUFYQ0xK?=
 =?utf-8?B?aDEzVG9MQnNsczFwdXBpYWJacHNBVVpGQUdiTGwrbmFFV1dKWEJhakpKUHNy?=
 =?utf-8?B?N1prVXpUcVhkQ3h0QmF2NEpnMmV0Q3loaEMvc09oQnVJWTV3MmtaNTUxMS9K?=
 =?utf-8?B?QUM5TmJMZFFBK0NFVUdEbWR2SHVsLzlwQTRaaFppMFE0TFhWaW5wYWo5YUJU?=
 =?utf-8?B?RzN5WUF2a1BVZ3ZrSDF2Sm9YVmNaeWxrQ3pIdHkzWE84VWZtUjlOU1JremUy?=
 =?utf-8?B?V0lPUzRidnJWOXQ0V055M1dUZG45dFFWaEk4UGJEZy85Z2l6RFYwVyt5TG9x?=
 =?utf-8?B?UjRob0oxUXdGeUNOS0dTOTBGazRMRDIvWnEzYWRJUTRYdUFveGZYUitjYTcw?=
 =?utf-8?B?SjV2TzR6U3RDcFVIWm9GTHNWM29KSG1vM05JVytZVFdWR2dub0lMVUdQaWJi?=
 =?utf-8?B?MS9NbDliRDZ6SVlvZ0dSb0Vwd2piQVVoZ244NG42VXJUYjhXNm9YYzkvREZF?=
 =?utf-8?B?YmdyMkE3UXlBanVEVHVRWnVQbkhMeFdTTkxocnhoNitLKyt4OUs3NmpjQWh0?=
 =?utf-8?B?L2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32E5ED512EF0774FBB383F37E5FB0238@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fkAbWnRJ3/mqUTsMx29+olYp0jLf8gwBcnIecOEmKp34gQVFOS40sMn9qW2uj8dBZelYnjqcXG3hBjGODLUD67/DfnnZV/uwD6uuuyt2nFGgt5KOukagZetgdPpIHySpYJI49mFCIlRxo01E/o6/VzONz6b0aqF0am7S1S4DpkGKpBLIn2aQERVp4JOso4k2xCXcBEkItna1EqhkHw1IHX1r/W10lH6kc+SnKk2TtPYA4qxqeEhSOg7/7OZQF+fSMqpw7eG2DSM66orfR95PrDnT4ySHLtDmc3YKlzeQlm5EKmDwMs02PFhO8h0CBB7lUetqk/qKBFR6HmaMGgYDXOw5S6++zsaYHEVQEejyVvdfNUKWQgScYxuYWhvrNfAosEEpjjUBGIAXZx5ggccybgegDt3DNnjpN3hQEqaVAYfrYSgxrVYHqt83fON4oAuTvlQWz4GAvP5su5VMjP7aeWTY1izC7cAIXOqFXf39ASeQtLSyqwHIRPzFgST35Wp9bk/oxjNEib2KNo86UcF1wDdDq4Mh3Ujko4iF3m22XjKpO8B4gpo6uCC7Adv8Z6VreSR1gWje+5EBdl4xx0YrLbsl8EBaTOV4Fp4T0T29mto=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90917f84-d511-448e-63ef-08dcf37c1161
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 16:02:17.2587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zjhnbM8jqHk5lsS5wdT51prBpshtO/6aglJr/TnMTbRF1S3DYvybgqtJnNcPA7YNBrXFbLCDpdkPqP7jTz+Dxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7335
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_13,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410230095
X-Proofpoint-ORIG-GUID: OB2J3lSfcVm55oDg9JeqLinvYyzJtKPf
X-Proofpoint-GUID: OB2J3lSfcVm55oDg9JeqLinvYyzJtKPf

SGkgRGF2aWQsDQoNCj4gT24gMTkgT2N0IDIwMjQsIGF0IDE3OjE1LCBEYXZpZCBXb29kaG91c2Ug
PGR3bXcyQGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiANCj4gRnJvbTogRGF2aWQgV29vZGhvdXNl
IDxkd213QGFtYXpvbi5jby51az4NCj4gDQo+IFRoZSBQU0NJIHYxLjMgc3BlY2lmaWNhdGlvbiBh
ZGRzIHN1cHBvcnQgZm9yIGEgU1lTVEVNX09GRjIgZnVuY3Rpb24NCj4gd2hpY2ggaXMgYW5hbG9n
b3VzIHRvIEFDUEkgUzQgc3RhdGUuIFRoaXMgd2lsbCBhbGxvdyBob3N0aW5nDQo+IGVudmlyb25t
ZW50cyB0byBkZXRlcm1pbmUgdGhhdCBhIGd1ZXN0IGlzIGhpYmVybmF0ZWQgcmF0aGVyIHRoYW4g
anVzdA0KPiBwb3dlcmVkIG9mZiwgYW5kIGVuc3VyZSB0aGF0IHRoZXkgcHJlc2VydmUgdGhlIHZp
cnR1YWwgZW52aXJvbm1lbnQNCj4gYXBwcm9wcmlhdGVseSB0byBhbGxvdyB0aGUgZ3Vlc3QgdG8g
cmVzdW1lIHNhZmVseSAob3IgYnVtcCB0aGUNCj4gaGFyZHdhcmVfc2lnbmF0dXJlIGluIHRoZSBG
QUNTIHRvIHRyaWdnZXIgYSBjbGVhbiByZWJvb3QgaW5zdGVhZCkuDQo+IA0KPiBUaGlzIGZlYXR1
cmUgaXMgc2FmZSB0byBlbmFibGUgdW5jb25kaXRpb25hbGx5IChpbiBhIHN1YnNlcXVlbnQgY29t
bWl0KQ0KPiBiZWNhdXNlIGl0IGlzIGV4cG9zZWQgdG8gdXNlcnNwYWNlIHRocm91Z2ggdGhlIGV4
aXN0aW5nDQo+IEtWTV9TWVNURU1fRVZFTlRfU0hVVERPV04gZXZlbnQsIGp1c3Qgd2l0aCBhbiBh
ZGRpdGlvbmFsIGZsYWcgd2hpY2gNCj4gdXNlcnNwYWNlIGNhbiB1c2UgdG8ga25vdyB0aGF0IHRo
ZSBpbnN0YW5jZSBpbnRlbmRlZCBoaWJlcm5hdGlvbiBpbnN0ZWFkDQo+IG9mIGEgcGxhaW4gcG93
ZXItb2ZmLg0KPiANCj4gQXMgd2l0aCBTWVNURU1fUkVTRVQyLCB0aGVyZSBpcyBvbmx5IG9uZSB0
eXBlIGF2YWlsYWJsZSAoaW4gdGhpcyBjYXNlDQo+IEhJQkVSTkFURV9PRkYpLCBhbmQgaXQgaXMg
bm90IGV4cGxpY2l0bHkgcmVwb3J0ZWQgdG8gdXNlcnNwYWNlIHRocm91Z2gNCj4gdGhlIGV2ZW50
OyB1c2Vyc3BhY2UgY2FuIGdldCBpdCBmcm9tIHRoZSByZWdpc3RlcnMgaWYgaXQgY2FyZXMpLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgV29vZGhvdXNlIDxkd213QGFtYXpvbi5jby51az4N
Cj4gLS0tDQo+IERvY3VtZW50YXRpb24vdmlydC9rdm0vYXBpLnJzdCAgICB8IDExICsrKysrKysr
DQo+IGFyY2gvYXJtNjQvaW5jbHVkZS91YXBpL2FzbS9rdm0uaCB8ICA2ICsrKysrDQo+IGFyY2gv
YXJtNjQva3ZtL3BzY2kuYyAgICAgICAgICAgICB8IDQ0ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCj4gMyBmaWxlcyBjaGFuZ2VkLCA2MSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi92aXJ0L2t2bS9hcGkucnN0IGIvRG9jdW1lbnRhdGlvbi92
aXJ0L2t2bS9hcGkucnN0DQo+IGluZGV4IGUzMjQ3MTk3N2QwYS4uMWVjMDc2ZDgwNmU2IDEwMDY0
NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL3ZpcnQva3ZtL2FwaS5yc3QNCj4gKysrIGIvRG9jdW1l
bnRhdGlvbi92aXJ0L2t2bS9hcGkucnN0DQo+IEBAIC02ODU1LDYgKzY4NTUsMTAgQEAgdGhlIGZp
cnN0IGBuZGF0YWAgaXRlbXMgKHBvc3NpYmx5IHplcm8pIG9mIHRoZSBkYXRhIGFycmF5IGFyZSB2
YWxpZC4NCj4gICAgdGhlIGd1ZXN0IGlzc3VlZCBhIFNZU1RFTV9SRVNFVDIgY2FsbCBhY2NvcmRp
bmcgdG8gdjEuMSBvZiB0aGUgUFNDSQ0KPiAgICBzcGVjaWZpY2F0aW9uLg0KPiANCj4gKyAtIGZv
ciBhcm02NCwgZGF0YVswXSBpcyBzZXQgdG8gS1ZNX1NZU1RFTV9FVkVOVF9TSFVURE9XTl9GTEFH
X1BTQ0lfT0ZGMg0KPiArICAgaWYgdGhlIGd1ZXN0IGlzc3VlZCBhIFNZU1RFTV9PRkYyIGNhbGwg
YWNjb3JkaW5nIHRvIHYxLjMgb2YgdGhlIFBTQ0kNCj4gKyAgIHNwZWNpZmljYXRpb24uDQo+ICsN
Cj4gIC0gZm9yIFJJU0MtViwgZGF0YVswXSBpcyBzZXQgdG8gdGhlIHZhbHVlIG9mIHRoZSBzZWNv
bmQgYXJndW1lbnQgb2YgdGhlDQo+ICAgIGBgc2JpX3N5c3RlbV9yZXNldGBgIGNhbGwuDQo+IA0K
PiBAQCAtNjg4OCw2ICs2ODkyLDEzIEBAIGVpdGhlcjoNCj4gIC0gRGVueSB0aGUgZ3Vlc3QgcmVx
dWVzdCB0byBzdXNwZW5kIHRoZSBWTS4gU2VlIEFSTSBERU4wMDIyRC5iIDUuMTkuMg0KPiAgICAi
Q2FsbGVyIHJlc3BvbnNpYmlsaXRpZXMiIGZvciBwb3NzaWJsZSByZXR1cm4gdmFsdWVzLg0KPiAN
Cj4gK0hpYmVybmF0aW9uIHVzaW5nIHRoZSBQU0NJIFNZU1RFTV9PRkYyIGNhbGwgaXMgZW5hYmxl
ZCB3aGVuIFBTQ0kgdjEuMw0KPiAraXMgZW5hYmxlZC4gSWYgYSBndWVzdCBpbnZva2VzIHRoZSBQ
U0NJIFNZU1RFTV9PRkYyIGZ1bmN0aW9uLCBLVk0gd2lsbA0KPiArZXhpdCB0byB1c2Vyc3BhY2Ug
d2l0aCB0aGUgS1ZNX1NZU1RFTV9FVkVOVF9TSFVURE9XTiBldmVudCB0eXBlIGFuZCB3aXRoDQo+
ICtkYXRhWzBdIHNldCB0byBLVk1fU1lTVEVNX0VWRU5UX1NIVVRET1dOX0ZMQUdfUFNDSV9PRkYy
LiBUaGUgb25seQ0KPiArc3VwcG9ydGVkIGhpYmVybmF0ZSB0eXBlIGZvciB0aGUgU1lTVEVNX09G
RjIgZnVuY3Rpb24gaXMgSElCRVJOQVRFX09GRg0KPiArMHgwKS4NCg0KSSBkb27igJl0IHRoaW5r
IHRoYXQg4oCYMHgw4oCZIGFkZHMgc29tZXRoaW5nIHRvIHdoYXTigJlzIGFscmVhZHkgZXhwbGFp
bmVkDQpiZWZvcmUsIElNTy4NCg0KPiArDQo+IDo6DQo+IA0KPiAvKiBLVk1fRVhJVF9JT0FQSUNf
RU9JICovDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2luY2x1ZGUvdWFwaS9hc20va3ZtLmgg
Yi9hcmNoL2FybTY0L2luY2x1ZGUvdWFwaS9hc20va3ZtLmgNCj4gaW5kZXggOTY0ZGYzMWRhOTc1
Li42NjczNmZmMDQwMTEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQvaW5jbHVkZS91YXBpL2Fz
bS9rdm0uaA0KPiArKysgYi9hcmNoL2FybTY0L2luY2x1ZGUvdWFwaS9hc20va3ZtLmgNCj4gQEAg
LTQ4NCw2ICs0ODQsMTIgQEAgZW51bSB7DQo+ICAqLw0KPiAjZGVmaW5lIEtWTV9TWVNURU1fRVZF
TlRfUkVTRVRfRkxBR19QU0NJX1JFU0VUMiAoMVVMTCA8PCAwKQ0KPiANCj4gKy8qDQo+ICsgKiBT
aHV0ZG93biBjYXVzZWQgYnkgYSBQU0NJIHYxLjMgU1lTVEVNX09GRjIgY2FsbC4NCj4gKyAqIFZh
bGlkIG9ubHkgd2hlbiB0aGUgc3lzdGVtIGV2ZW50IGhhcyBhIHR5cGUgb2YgS1ZNX1NZU1RFTV9F
VkVOVF9TSFVURE9XTi4NCj4gKyAqLw0KPiArI2RlZmluZSBLVk1fU1lTVEVNX0VWRU5UX1NIVVRE
T1dOX0ZMQUdfUFNDSV9PRkYyICgxVUxMIDw8IDApDQo+ICsNCj4gLyogcnVuLT5mYWlsX2VudHJ5
LmhhcmR3YXJlX2VudHJ5X2ZhaWx1cmVfcmVhc29uIGNvZGVzLiAqLw0KPiAjZGVmaW5lIEtWTV9F
WElUX0ZBSUxfRU5UUllfQ1BVX1VOU1VQUE9SVEVEICgxVUxMIDw8IDApDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvYXJjaC9hcm02NC9rdm0vcHNjaS5jIGIvYXJjaC9hcm02NC9rdm0vcHNjaS5jDQo+IGlu
ZGV4IDFmNjliNjY3MzMyYi4uZGY4MzRmMmU5MjhlIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0
L2t2bS9wc2NpLmMNCj4gKysrIGIvYXJjaC9hcm02NC9rdm0vcHNjaS5jDQo+IEBAIC0xOTQsNiAr
MTk0LDEyIEBAIHN0YXRpYyB2b2lkIGt2bV9wc2NpX3N5c3RlbV9vZmYoc3RydWN0IGt2bV92Y3B1
ICp2Y3B1KQ0KPiBrdm1fcHJlcGFyZV9zeXN0ZW1fZXZlbnQodmNwdSwgS1ZNX1NZU1RFTV9FVkVO
VF9TSFVURE9XTiwgMCk7DQo+IH0NCj4gDQo+ICtzdGF0aWMgdm9pZCBrdm1fcHNjaV9zeXN0ZW1f
b2ZmMihzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpDQo+ICt7DQo+ICsga3ZtX3ByZXBhcmVfc3lzdGVt
X2V2ZW50KHZjcHUsIEtWTV9TWVNURU1fRVZFTlRfU0hVVERPV04sDQo+ICsgS1ZNX1NZU1RFTV9F
VkVOVF9TSFVURE9XTl9GTEFHX1BTQ0lfT0ZGMik7DQo+ICt9DQo+ICsNCj4gc3RhdGljIHZvaWQg
a3ZtX3BzY2lfc3lzdGVtX3Jlc2V0KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkNCj4gew0KPiBrdm1f
cHJlcGFyZV9zeXN0ZW1fZXZlbnQodmNwdSwgS1ZNX1NZU1RFTV9FVkVOVF9SRVNFVCwgMCk7DQo+
IEBAIC0zNTgsNiArMzY0LDExIEBAIHN0YXRpYyBpbnQga3ZtX3BzY2lfMV94X2NhbGwoc3RydWN0
IGt2bV92Y3B1ICp2Y3B1LCB1MzIgbWlub3IpDQo+IGlmIChtaW5vciA+PSAxKQ0KPiB2YWwgPSAw
Ow0KPiBicmVhazsNCj4gKyBjYXNlIFBTQ0lfMV8zX0ZOX1NZU1RFTV9PRkYyOg0KPiArIGNhc2Ug
UFNDSV8xXzNfRk42NF9TWVNURU1fT0ZGMjoNCj4gKyBpZiAobWlub3IgPj0gMykNCj4gKyB2YWwg
PSBQU0NJXzFfM19PRkZfVFlQRV9ISUJFUk5BVEVfT0ZGOw0KPiArIGJyZWFrOw0KPiB9DQo+IGJy
ZWFrOw0KPiBjYXNlIFBTQ0lfMV8wX0ZOX1NZU1RFTV9TVVNQRU5EOg0KPiBAQCAtMzkyLDYgKzQw
MywzOSBAQCBzdGF0aWMgaW50IGt2bV9wc2NpXzFfeF9jYWxsKHN0cnVjdCBrdm1fdmNwdSAqdmNw
dSwgdTMyIG1pbm9yKQ0KPiBicmVhazsNCj4gfQ0KPiBicmVhazsNCj4gKyBjYXNlIFBTQ0lfMV8z
X0ZOX1NZU1RFTV9PRkYyOg0KPiArIGt2bV9wc2NpX25hcnJvd190b18zMmJpdCh2Y3B1KTsNCj4g
KyBmYWxsdGhyb3VnaDsNCj4gKyBjYXNlIFBTQ0lfMV8zX0ZONjRfU1lTVEVNX09GRjI6DQo+ICsg
aWYgKG1pbm9yIDwgMykNCj4gKyBicmVhazsNCj4gKw0KPiArIGFyZyA9IHNtY2NjX2dldF9hcmcx
KHZjcHUpOw0KPiArIC8qDQo+ICsgKiBQU0NJIHYxLjMgaXNzdWUgRi5iIHJlcXVpcmVzIHRoYXQg
emVybyBiZSBhY2NlcHRlZCB0byBtZWFuDQo+ICsgKiBISUJFUk5BVEVfT0ZGIChpbiBsaW5lIHdp
dGggcHJlLXB1YmxpY2F0aW9uIHZlcnNpb25zIG9mIHRoZQ0KPiArICogc3BlYywgYW5kIHRodXMg
c29tZSBhY3R1YWwgaW1wbGVtZW50YXRpb25zIGluIHRoZSB3aWxkKS4NCj4gKyAqIFRoZSBzZWNv
bmQgYXJndW1lbnQgbXVzdCBiZSB6ZXJvLg0KPiArICovDQo+ICsgaWYgKChhcmcgJiYgYXJnICE9
IFBTQ0lfMV8zX09GRl9UWVBFX0hJQkVSTkFURV9PRkYpIHx8DQo+ICsgICAgc21jY2NfZ2V0X2Fy
ZzIodmNwdSkgIT0gMCkgew0KPiArIHZhbCA9IFBTQ0lfUkVUX0lOVkFMSURfUEFSQU1TOw0KPiAr
IGJyZWFrOw0KPiArIH0NCj4gKyBrdm1fcHNjaV9zeXN0ZW1fb2ZmMih2Y3B1KTsNCj4gKyAvKg0K
PiArICogV2Ugc2hvdWxkbid0IGJlIGdvaW5nIGJhY2sgdG8gZ3Vlc3QgVkNQVSBhZnRlcg0KPiAr
ICogcmVjZWl2aW5nIFNZU1RFTV9PRkYyIHJlcXVlc3QuDQo+ICsgKg0KPiArICogSWYgdXNlciBz
cGFjZSBhY2NpZGVudGFsbHkvZGVsaWJlcmF0ZWx5IHJlc3VtZXMNCj4gKyAqIGd1ZXN0IFZDUFUg
YWZ0ZXIgU1lTVEVNX09GRjIgcmVxdWVzdCB0aGVuIGd1ZXN0DQo+ICsgKiBWQ1BVIHNob3VsZCBz
ZWUgaW50ZXJuYWwgZmFpbHVyZSBmcm9tIFBTQ0kgcmV0dXJuDQo+ICsgKiB2YWx1ZS4gVG8gYWNo
aWV2ZSB0aGlzLCB3ZSBwcmVsb2FkIHIwIChvciB4MCkgd2l0aA0KPiArICogUFNDSSByZXR1cm4g
dmFsdWUgSU5URVJOQUxfRkFJTFVSRS4NCj4gKyAqLw0KPiArIHZhbCA9IFBTQ0lfUkVUX0lOVEVS
TkFMX0ZBSUxVUkU7DQo+ICsgcmV0ID0gMDsNCj4gKyBicmVhazsNCg0KT3RoZXIgdGhhbiB0aGF0
IGl0IGxvb2tzIGdvb2QgdG8gbWU6DQoNClJldmlld2VkLWJ5OiBNaWd1ZWwgTHVpcyA8bWlndWVs
Lmx1aXNAb3JhY2xlLmNvbT4NCg0KVGhhbmtzLA0KTWlndWVsDQoNCj4gZGVmYXVsdDoNCj4gcmV0
dXJuIGt2bV9wc2NpXzBfMl9jYWxsKHZjcHUpOw0KPiB9DQo+IC0tIA0KPiAyLjQ0LjANCj4gDQoN
Cg==

