Return-Path: <linux-kselftest+bounces-34087-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9608FAC9533
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 19:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 540E2A8054A
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 17:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D6B275862;
	Fri, 30 May 2025 17:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="alJ4l2Jx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GXBrcr3f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FCB14D433;
	Fri, 30 May 2025 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748627423; cv=fail; b=E3709fUEFUSC71DHREDIOtZRGCFp04///XoK9r3A+908JOCFqaxBwzEVElDudf3pywvWKK4AmJytUgMFlnDXuqcymffFT/9ppTBNwMNHpFdrjTANZCkPBFxLKsUda7rYRETPlycCH1/9ot2awmC0hwBkBHbFMNcsobtHMBEkDTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748627423; c=relaxed/simple;
	bh=kKOoG9lUbAfSkWHQpgbyTPZXLVAJlk2xR5m/3OLkbok=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BWi+8VrdbddI3y8Ds/9qLY97KVw+63xjaLI1SmGmALdWqLDFUQoHeF4NJ3vBi86daNOvsblkSXz2SyViX8U91KI9OOBqQhmMUzaO6XdaOTnBas+ADXrrhefl77MAewQkdPCVGzTv/vru/pn5Bjdzwtq2FehGs9vuWIE7FF+Pov8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=alJ4l2Jx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GXBrcr3f; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54UHY23c004314;
	Fri, 30 May 2025 17:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kKOoG9lUbAfSkWHQpgbyTPZXLVAJlk2xR5m/3OLkbok=; b=
	alJ4l2Jxc537tb1GDmJXPwEQyqkJTnG7iwzIki+8w/SnraASu/g/dj6uEbPBgqt/
	nZPEO+TzE+IVqnojNB6rpZx/GhhpTXAfXptigErFq4lF1UpDNkR7END26iOsKQwv
	eDd+6Ithkc+E/h6baqioSEGb26Z+9Hr7bVxpbXsgJTjDPTITGn59/FBYeE2c55rK
	s2YQifH5z1WRN4jgFDIW+Ih/urOSv4ZNYHg6oTEuoy8ORA8WGqQ1GIBQVSH8Lgyq
	R4zfPqkaHqVARnS14fYbzgsCwKU25letkZYwDI5Rtb//Xn/ZTQFPSzJ7JiSCZkM4
	oLdLNxz1Sv2vg4GaRSoQvw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46wjbcpqa9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 May 2025 17:49:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54UGE2Ld019261;
	Fri, 30 May 2025 17:49:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jdjwtt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 May 2025 17:49:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YS7c/4kr3d4C8Itr76azqTUUbRqNU42IR6HGk4aFw5zJ4MAC0K1rpQHQ1kx93+zwmRaBj6nqwygrFsVyKACnV952DAGAcmP4BO5AhbCtI28j27C5LCJgMLe5h4tpdz6Rwjh1IPOSuwHLNRDV9RqHUwJYv4ANyQFMHhdtFeUpP5R5W+awOC83LzPrDymk1NS9ayjFQrbJ0VSIU1u+nDiMPSWFRKUKWBCUKkPVpm2qE5LHyd9QMJixH5hr1J06oJhl88t7sJkPTgblvNrhsQu7k3XOwnvlGFPsM4BFQNtX5VdQuOBhlbTc/OEY5Mv7FQq8NA41Yc8SuCnMIq4VcTHKVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKOoG9lUbAfSkWHQpgbyTPZXLVAJlk2xR5m/3OLkbok=;
 b=LKwc3g+eqwOlSvku2lqidlJ3CnjI7BzdddmFrh5i2aeIQPoD/+e8ecURhN60iu86/rj/2z+15+43brLWz/H2k2Dhf5mCBbRFgVxm9lM/M2JPmqYADkn7LQRYmiGma1W3BdnESqquIL+iHAdCMbvxYFtliC9l39fmEyEfHA3GDCtc+U5tHqAG3M58AY+MwkIlYYobu+yvZ7wQhoD8Dsl26ewLDKeMkF6Tj1/qWIMMYQyQLejqOR72m+MFKiIi86TBVvfV8M5q/1k6OBpESvbh3R6008doOzeCo54OSzMbFhAGSb5aMfFC7RCsdeUaqcX6F1chUr+Bz1aHCZ2kcYpHtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKOoG9lUbAfSkWHQpgbyTPZXLVAJlk2xR5m/3OLkbok=;
 b=GXBrcr3fW8lbHoNa8sop4aBPmfCNes5YvvyrTxmo+hTfBA08AKuwIR8OQhTw9SjLhwKYfPHU9l7ulJoqRybM5bHpSMnYm9H/tcgXs81v6cU1HlvZxaSfSH+qncHqJ/JvFQiR4wSMP4cXM/nQX3Ik30mlddtReU2OpKILQVqN2A0=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by PH3PPF2B2347B8A.namprd10.prod.outlook.com (2603:10b6:518:1::792) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Fri, 30 May
 2025 17:49:52 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%7]) with mapi id 15.20.8746.035; Fri, 30 May 2025
 17:49:52 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
        "joey.gouly@arm.com"
	<joey.gouly@arm.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
        "seanjc@google.com"
	<seanjc@google.com>,
        "darren@os.amperecomputing.com"
	<darren@os.amperecomputing.com>
Subject: Re: [RFC PATCH v2 0/9] KVM: Enable Nested Virt selftests
Thread-Topic: [RFC PATCH v2 0/9] KVM: Enable Nested Virt selftests
Thread-Index: AQHbwyy4KRyGRkZ9VUGcwCynMZ7uJrPrkBSA
Date: Fri, 30 May 2025 17:49:52 +0000
Message-ID: <194C6167-6F9E-47DA-A002-F64630137D1B@oracle.com>
References: <20250512105251.577874-1-gankulkarni@os.amperecomputing.com>
In-Reply-To: <20250512105251.577874-1-gankulkarni@os.amperecomputing.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|PH3PPF2B2347B8A:EE_
x-ms-office365-filtering-correlation-id: 6ccaccbd-01aa-4062-adde-08dd9fa26141
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bUFXaU5IT0o5QjVVcGFvVVFqNHRwS0tUUzNRLzV1MUVONUQwb3hDK2pOUmR6?=
 =?utf-8?B?NXg3NEJVVDlnUGRvSlFiZVljNGlIT3JhVE5BRmF1UTh3Wit5WkJ0TWowRmt5?=
 =?utf-8?B?cDdzc2ZIVUxtUmhaMWx6TTRlTzhSSHVEdWdHM0xPMGY5eCtXeHJQVml6MkMy?=
 =?utf-8?B?RnhiRmIxam5mNk9WbkswUXlSdXk5d012ZnhCdnJSTW9tcUI3WnVtcHZDVmkw?=
 =?utf-8?B?SmEvUGdmekpFNnJvNklIMm4zTVh3a3NIQUROY2FqZW5wR0JwTWYxdFhEcm5C?=
 =?utf-8?B?YUtYbUwxS29rRzMrbFdKRVozMjYvYVhEYzhBNXd5STZ5MXFFMXdRM1o3OS9n?=
 =?utf-8?B?NWJnVkp1eHpsSSt3SE54Wmp0ZzlOcWRBVHdBN0ZWSXc1OVo4T1NvSklIeDNX?=
 =?utf-8?B?UW1xVkdsdHA0U0xRVDdTbEhHRDBWZ1pYOEtQWStscGo4WUJzWmJRZ2E2c2k2?=
 =?utf-8?B?Y3kyc2ZlS2U3NjRMTlBhTzBlRGJ5SmZYWVVMclNGYnBoajJsQjBtMmdUYlNJ?=
 =?utf-8?B?QzI1WVNibElHRjdwN0QrTSswR3FLWVhCT09aOGIzKzB2VzFhdklPQnBoNmx5?=
 =?utf-8?B?SVFXRm1qWlVKRkI3S2szakhWclpIWlRjRHpsVjUvaGxicFNxaWFOUW00Nktv?=
 =?utf-8?B?a2FaaGVFRUk0ZWo2Nm5IS0RBY2xHR0ZMS3ZiSmowMUYreURMd0I1UmE1ejlL?=
 =?utf-8?B?OFpkNWtLa1FCanVhYkJsS3lhRm5xb0JxajJJOXZvMXR4Tnk0cmJLVEhPMmJs?=
 =?utf-8?B?NjBqcHJMNUtxZDhyZXN3dTFQdmlzcDVvSEd5dGRsMXBjNnVsQ2lSVlh3MzNw?=
 =?utf-8?B?bStmVWNSVTEzNXVZRWZLQ3hUN1RXRXA2aGxRaHlVL01MNFNVMEtPc3RuM0ln?=
 =?utf-8?B?cUsyOEV5bTZ0N0EvZ1VMM0xFdkNMMmtBZlBxeWFGcys4LzhjYzdWYW5FbERy?=
 =?utf-8?B?TWFYZWdGWTlGVXp3TXRjbk1RTmdwY2x1bGRMOVlsemdKM0x0K2lTT1lqZ3p5?=
 =?utf-8?B?cklMVTUyZXhwb1pOVjVvUi9USzh5Sm1pZnhHV1VvMWFMZkFOelRLeVpaZ0Z0?=
 =?utf-8?B?eXRNczc2dmQyRS9IQlAzT0ZTOFZUWEF3VzIzMTFEbi9qQjhWdm1DWjFYWnRm?=
 =?utf-8?B?cVl5cXZ0TTQ2SDZSUSs5Ky9ScGtTYzFNU21kOWI0Um5KMTNxZzEvb1N1ZGNH?=
 =?utf-8?B?WVBkODI2S1NSU2tIZ2NCdjBEYW11cUJOQ1JNOHl0bG45LzFHYlZRV2dPeHU4?=
 =?utf-8?B?WU0xTjJPWVpwa2xOcTNOanpZOTM4RGUwUnN0NTdtZXhKQ1g3SDhpY2IrOEkz?=
 =?utf-8?B?QjZzZVhCNDQ5V3VIcHBxS0Y4TnovQWJ0MUNLRVNkRmZocCtUQmdpaXd0QTdB?=
 =?utf-8?B?RXcrYWxvak5GR0xZM0JJMlY3SWRucUhZWEJFZnYySnJrc3lQRmE4dHBENDk3?=
 =?utf-8?B?VzREVFU3eC9NVTVTdFdmTFdHWElnQ0lHVTRWdWFRZjdnUytSZmRFaHlSWUE4?=
 =?utf-8?B?Z2pOaDl5RGhEa2FGODkzWEFMNlVuVlZiSkh4SzYyZFB1ZFc4NTl1dENtOWFl?=
 =?utf-8?B?ak9PM1B1MnRsTVFZWmppb1hXMit0azhhQjJDcWpUYWxjMU1LSEpibk1tZjM2?=
 =?utf-8?B?QlphbktHWXBVNDBMVHNDQnBDSytONE1NNzZCRWtyUnN3ajB1N3l5UzFCbDN2?=
 =?utf-8?B?U0dCZE9uN0t3WDVTVGQzdXpiZTBtK3R6V3ZnQlZSRUpnTnRmMHJqZHhXamR3?=
 =?utf-8?B?QjRNb1hXSktjK1VuU1ZLTXVDSUVseWlqNGFaTmtkT3J4SnltaWgxWStoRFQr?=
 =?utf-8?B?RGpYenZTelloc3BnRXFPc2JrOXdxUlFITC9Mb2c2WjNwS2Z4SVI2QzBSU1Z3?=
 =?utf-8?B?R2lCbkI5bEd0UnZic3AveEY4dDc1MXhjMmc0ZmM3VEpvZDUwc0xDRSsrRmIw?=
 =?utf-8?B?ZTg4YnhhVkdsdTFwQWkwSGlCcWdTY09JRE1TVUNPcjhlL01ZaXFMdlFRelRr?=
 =?utf-8?Q?Gr5AMDgSQ2LV9Rot0//FYdvmiI5XBQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M0VSdDlzaXpZTXJGN09vOGxERGVtc3hGMExlWkxhakVQbExHOGgwQ2c3cDVB?=
 =?utf-8?B?QUpjeDRpU3JZTTdxa0YvSnAyTHFOL09VMmpMdjlhVGlwc1Q1YnJYbndQL2tp?=
 =?utf-8?B?NXhZZGlUSE5hZlpzeVcwcG5CN1dFUGZSeDRINzI5bXdwTDMrS0xJV3RGUVpY?=
 =?utf-8?B?OWpPdVg5emFwcVNFSHhxelIvZEFVWFo2dENqUUY3VTRQZCs5eUVRancvUDVV?=
 =?utf-8?B?dmdnSW9NSjZkSHR3cUFHaU0wSGY1d2MvZWxiUXR5aHAzTGFPQ1dGRjdDZFVI?=
 =?utf-8?B?dmRqNXhaS3A2ZERXZlZXem4wcE1sdERWUjRDaEl1T0N6M0oxNGp2aWU0ME1k?=
 =?utf-8?B?NksxVEdaWGZMVnJ2dDVXbHVYb2pmR3hVK1NzOEFJVVdPSzh6YmdXMW1kVnMz?=
 =?utf-8?B?cDdNR3BBMlA2amVXdmwyajA1QUtjdGJpaXJpSXBsRGplU1ZOMzg4UGVmc2xx?=
 =?utf-8?B?VlNhWHpiMlZKYnhOaWtKL0dBMEVQa3hGcUVnb3luWE1uditMcEt5b3hpY3I0?=
 =?utf-8?B?QWFERDZNUGx5Tk04V3lzNjFLaU1IMmxvRUxEREdFZExGYkxhZVZBdSs2aU43?=
 =?utf-8?B?VW83cHBxMS9WKy9hekFlc1ZLR3U2VnBGZnlXb0MyL2RFdmFEamhyQVdzLzFh?=
 =?utf-8?B?S2hKckxpRUc3NEhSSEhaenNHa25LVHUvZjV1NWpjWlJKOU1ZZmFqWWwyc3JZ?=
 =?utf-8?B?akhhU1c5c2UrS2tPSXUzQkF6Unp0NFQ4OWVGaUtqRVhvSVpqMmNBVnRFdW9a?=
 =?utf-8?B?d1JYZmI4NFh1bGRPclViN3FrcS8wOXFhdmYwMFNsbzRnbkw2ODZSQXFhQmgz?=
 =?utf-8?B?S0VVdi9ReDdqRGpCRUVhd0oxRzRiNVR4bTRCa1JQbmY5KzBlQmhDMEV1YUZp?=
 =?utf-8?B?QnQ0WHMzY25qWnlOdFFkK1lCT2xKY3ZDeUVQOWpJME1BSjFVYkxFRFpEaHZT?=
 =?utf-8?B?aVFubUU2aFphQW40aUFIUTV6MFk0TTZzVEJrTFVPdWZoNXZ4RW5BSTdZRU9q?=
 =?utf-8?B?eUZmT0R6NklvOHV4dnRJRzVXUDR6WDNzem95WDYvcGxpRVl1WjZoV2dOS2Qy?=
 =?utf-8?B?dGQ3VHVGdDJEWXBUdEgyS1BMUXdqeVNSZkovR3ViTjVhb013Z0QwMXQzZmdp?=
 =?utf-8?B?NENkQ2grdGRWUlZmMmlCSzJHR3ZoaFZ0QS9WWHdPN2MyWTN4ZUpGZjBQZm84?=
 =?utf-8?B?eHRwZTBESGYxclNONGI5N1lwbU1Ud1poR0NSajZMZjY1Z2hXS3U4ZFd1alF0?=
 =?utf-8?B?Vys2YmZaSnJBc0pOVDdIbHpSOEhTbGFOMVQrOTlaUi9Kb01iZUN0R1AvMWpl?=
 =?utf-8?B?UklFeEVVemFxNjFuY0hhRVFoRmdYRnNuSldEUVJ3a3BxU1hsSEFqQmdLNlVF?=
 =?utf-8?B?bndUZzJsU0x1T1A5Vm5wMjBNUFppcmJUMkcwbW1mai9oQ3VvVEpFUlZIMlB5?=
 =?utf-8?B?cUpNeU9iVGZzWi91QU5ucWJlRThZYkVJN3lrZmt4bTR5S2J4MEcvcnladkdm?=
 =?utf-8?B?UGsxc3ZnM1ZaVTFXU3hjR0xTV3JWcjN6TUkybGhNNm5ocFR0d2daSDZIVlB0?=
 =?utf-8?B?UC91bFRaWkpQNVkzd0dob2JNU0lZVGZCUFhpTDRJdHVkaml3bjRHVlo5b1Jy?=
 =?utf-8?B?eFNEWEU2L0VBUWoyWmtHSng4ajVBN3p0WUNzV2ljYWtxc2FvQm5Ic053ZlF3?=
 =?utf-8?B?WWp2aWFjQU5jUkdYNWhWRzRqQkdxQmpQMUczSHd4ZjFYdDFqdU9NcGtoaURz?=
 =?utf-8?B?UWE0VkR5NXlqN3U0b0dSc0toTEtEanFNZWUwekI0M1dJK3RDTHZVOE5zWjhO?=
 =?utf-8?B?bVN0SlNoMU03bW5wenlnQjhVZXY5cnVlOHF2MHMwRG5JbTUreVhveGZ6VUow?=
 =?utf-8?B?RTREcDRaa2VONUZHMjdQSnVOY3Mzcml4ZGZlWXZ1K0o5d0tXOHkzSFlUdmRK?=
 =?utf-8?B?dnBsZzdsQ3lNVkxjSjdwMVRRc1RpdlFzMDFEdzNWR1doMW5wTm5wSkF3T0RT?=
 =?utf-8?B?WkY3cWUwTlhPS045RHJCL2FURDdIK1JVWkxMWTgwVnhlNDREQUUrSFhUTXVp?=
 =?utf-8?B?aGRXb2txNnVZSTh1OFcxZ1pUNVhLNW1DRzgxWmRpeTdTZndLRE9qTWt2eFNa?=
 =?utf-8?B?bXdMZG9xc0RFNFU0RHVUeFhXQ2lvM1huU2dVRmticU5SU3ZrS0lTMVA3SHE0?=
 =?utf-8?B?Mmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D203FA54260CE40867AB585778ED2FF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RXhpaOJf+eRq0oafsZtuI9cghEhFK/pAOgq4CcIgnu2/kH/UdPkhCbCT9cTvIxtNZClfIwzq0b26BqjpslajPC9cJBfOkAIqwUXh19ka84tDbvO6jv0OtEctlu+wYfP5dUYCCCoUhxAgHgv3XR0X9klrq48KV5MsMZ2teY2SFa+dAnbkUmD+IgcNuEGiZeYhFl0x4t351FiWW1066pO0hRZBR4BTuEdmoHarPLmtRNSmctiof0fyNc4UTGBKVCKhEcxCeya1ePFIBqfi0r53+sIxylFCuLSpOvjv7VH4QpBK86VV6VYBwZneDXe2IQUVYTblcisc9TkxXfsSlWB7hkCopFav5/+mFMbTlhRyPLWMvBUZnGGeo/VMtOEhZsRkOZZF/32RiVzvYopCBflF129lNACUhojg3obe9Iyj9rclP7n8m7Wm/12l4f5/eFcrDhyYEcDPaBRSqN6OWFN3Yh2v1E9AMW5Jei2E11/hgfGZsu1qQljWTrv2rRgL87FVTFiFKov+rYULtgFS0O4WURDKIzGce9TMYtK8jZ0WMXbyzrSwV7BopLC2994u0WHFMcLcI9+lZoJGWLnIUduUCtJsYPceyCj7O1bloMFIZzo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ccaccbd-01aa-4062-adde-08dd9fa26141
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2025 17:49:52.1305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: URWdWXcGXmNmFk57Z0769016WK66SZT27wWAfyccNTYKJUDgBrKgl+LZ2rT0hjpRKkeXu9K7Cd5mP+FT8C1wmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF2B2347B8A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_08,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505300157
X-Proofpoint-GUID: 4rP0dQgDIjacmyIDjJsxK9FZm3Gw5K2s
X-Proofpoint-ORIG-GUID: 4rP0dQgDIjacmyIDjJsxK9FZm3Gw5K2s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDE1NyBTYWx0ZWRfX6VDMY88pJB45 X7NcirgqwQXwhXnFrkNo2wSK9Z7aFdAXVIfYG4+SbZBD9nMfVIff9/s2Muk4UnIDaHDcbmR2ky/ NyfqAUjpuUtFaoeyrzMVA0yEeHg/MdaEupYPBFdOHwcam0dspvLujwJrOKBulUnbyOLkVy0TS6q
 zjFXirgTqzOtLZ0tQ4o/1Qj/asl/uBy8R1Brv2+/k0iH++4pGIEPL5T187ZmvsfoGaqmzbILkuH jNRn8r6XRfExBrvGT4THXNaqZ88cDNstMlGohkcmtk9Vaa+9uAu3N55635kHimMqLp4URBtcL/1 hGeq/hVQeTMUDAF3RkwM2boU4FLmSaafcb3awD0ssqDqYH98zMEunHde5sGDnTuarHH784jJDts
 o6z5NpjQERUyk9GqJM+ZUB1IXL+QbNcSH0Jx99OIClVRrxxPhpZK9/UVrKaqCvRj3yqX6b1S
X-Authority-Analysis: v=2.4 cv=c8qrQQ9l c=1 sm=1 tr=0 ts=6839efc4 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=IA0wh2spAAAA:8 a=vzhER2c_AAAA:8 a=AxVN_PpnYj800W2gfEoA:9 a=QEXdDO2ut3YA:10 a=Kzd_KcwRQRMA:10 a=0YTRHmU2iG2pZC6F1fw2:22 cc=ntf awl=host:13206

SGkgR2FuYXBhdHJhbywNCg0KPiBPbiAxMiBNYXkgMjAyNSwgYXQgMTA6NTIsIEdhbmFwYXRyYW8g
S3Vsa2FybmkgPGdhbmt1bGthcm5pQG9zLmFtcGVyZWNvbXB1dGluZy5jb20+IHdyb3RlOg0KPiAN
Cj4gVGhpcyBwYXRjaCBzZXJpZXMgbWFrZXMgdGhlIHNlbGZ0ZXN0IHdvcmsgd2l0aCBOViBlbmFi
bGVkLiBUaGUgZ3Vlc3QgY29kZQ0KPiBpcyBydW4gaW4gdkVMMiBpbnN0ZWFkIG9mIEVMMS4gV2Ug
YWRkIGEgY29tbWFuZCBsaW5lIG9wdGlvbiB0byBlbmFibGUNCj4gdGVzdGluZyBvZiBOVi4gVGhl
IE5WIHRlc3RzIGFyZSBkaXNhYmxlZCBieSBkZWZhdWx0Lg0KPiANCg0KVGhlIGZvbGxvd2luZyB0
d28gdGVzdHMgYXJjaF90aW1lciBhbmQgdmdpY19scGlfc3RyZXNzIHBhc3MgZm9yIGEgZ3Vlc3Qg
aW4gVkhFDQptb2RlIGJ1dCBpbiBhIG5WSEUgbW9kZSBndWVzdCB0aGV5IGFyZSBmYWlsaW5nIGZv
ciBtZS4gSeKAmXZlIHRlc3RlZCB0aGVtIG9uDQpNYXJj4oCZcyByZXBvIHRhZyAna3ZtYXJtLWZp
eGVzLTYuMTYtMScgb24gYW4gQW1wZXJlT25lLg0KDQpEbyB5b3UgaGF2ZSBwbGFucyB0byBhZGQg
bnZoZSBtb2RlIHRlc3RpbmcgdG8gdGhpcyBzZXJpZXM/DQoNClRoYW5rcw0KTWlndWVsDQoNCj4g
TW9kaWZpZWQgYXJvdW5kIDEyIHNlbGZ0ZXN0cyBpbiB0aGlzIHNlcmllcy4NCj4gDQo+IENoYW5n
ZXMgc2luY2UgdjE6DQo+IC0gVXBkYXRlZCBOViBoZWxwZXIgZnVuY3Rpb25zIGFzIHBlciBjb21t
ZW50cyBbMV0uDQo+IC0gTW9kaWZpZWQgZXhpc3RpbmcgdGVzdHNjYXNlcyB0byBydW4gZ3Vlc3Qg
Y29kZSBpbiB2RUwyLg0KPiANCj4gWzFdIGh0dHBzOi8vbGttbC5pdS5lZHUvaHlwZXJtYWlsL2xp
bnV4L2tlcm5lbC8yNTAyLjAvMDcwMDEuaHRtbCANCj4gDQo+IEdhbmFwYXRyYW8gS3Vsa2Fybmkg
KDkpOg0KPiAgS1ZNOiBhcm02NDogbnY6IHNlbGZ0ZXN0czogQWRkIHN1cHBvcnQgdG8gcnVuIGd1
ZXN0IGNvZGUgaW4gdkVMMi4NCj4gIEtWTTogYXJtNjQ6IG52OiBzZWxmdGVzdHM6IEFkZCBzaW1w
bGUgdGVzdCB0byBydW4gZ3Vlc3QgY29kZSBpbiB2RUwyDQo+ICBLVk06IGFybTY0OiBudjogc2Vs
ZnRlc3RzOiBFbmFibGUgaHlwZXJ2aXNvciB0aW1lciB0ZXN0cyB0byBydW4gaW4NCj4gICAgdkVM
Mg0KPiAgS1ZNOiBhcm02NDogbnY6IHNlbGZ0ZXN0czogZW5hYmxlIGFhcmNoMzJfaWRfcmVncyB0
ZXN0IHRvIHJ1biBpbiB2RUwyDQo+ICBLVk06IGFybTY0OiBudjogc2VsZnRlc3RzOiBFbmFibGUg
dmdpYyB0ZXN0cyB0byBydW4gaW4gdkVMMg0KPiAgS1ZNOiBhcm02NDogbnY6IHNlbGZ0ZXN0czog
RW5hYmxlIHNldF9pZF9yZWdzIHRlc3QgdG8gcnVuIGluIHZFTDINCj4gIEtWTTogYXJtNjQ6IG52
OiBzZWxmdGVzdHM6IEVuYWJsZSB0ZXN0IHRvIHJ1biBpbiB2RUwyDQo+ICBLVk06IHNlbGZ0ZXN0
czogYXJtNjQ6IEV4dGVuZCBrdm1fcGFnZV90YWJsZV90ZXN0IHRvIHJ1biBndWVzdCBjb2RlIGlu
DQo+ICAgIHZFTDINCj4gIEtWTTogYXJtNjQ6IG52OiBzZWxmdGVzdHM6IEVuYWJsZSBwYWdlX2Zh
dWx0X3Rlc3QgdGVzdCB0byBydW4gaW4gdkVMMg0KPiANCj4gdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMva3ZtL01ha2VmaWxlLmt2bSAgICAgIHwgICAyICsNCj4gdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMva3ZtL2FyY2hfdGltZXIuYyAgICAgIHwgICA4ICstDQo+IC4uLi9zZWxmdGVzdHMva3ZtL2Fy
bTY0L2FhcmNoMzJfaWRfcmVncy5jICAgICB8ICAzNCArKysrLQ0KPiAuLi4vdGVzdGluZy9zZWxm
dGVzdHMva3ZtL2FybTY0L2FyY2hfdGltZXIuYyAgfCAxMTggKysrKysrKysrKysrKysrLS0tDQo+
IC4uLi9zZWxmdGVzdHMva3ZtL2FybTY0L252X2d1ZXN0X2h5cGVydmlzb3IuYyB8ICA2OCArKysr
KysrKysrDQo+IC4uLi9zZWxmdGVzdHMva3ZtL2FybTY0L3BhZ2VfZmF1bHRfdGVzdC5jICAgICB8
ICAzNSArKysrKy0NCj4gLi4uL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS9hcm02NC9zZXRfaWRfcmVn
cy5jIHwgIDU3ICsrKysrKysrLQ0KPiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0vYXJtNjQv
dmdpY19pbml0LmMgfCAgNTQgKysrKysrKy0NCj4gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3Zt
L2FybTY0L3ZnaWNfaXJxLmMgIHwgIDI3ICsrLS0NCj4gLi4uL3NlbGZ0ZXN0cy9rdm0vYXJtNjQv
dmdpY19scGlfc3RyZXNzLmMgICAgIHwgIDE5ICsrLQ0KPiAuLi4vdGVzdGluZy9zZWxmdGVzdHMv
a3ZtL2d1ZXN0X3ByaW50X3Rlc3QuYyAgfCAgMzIgKysrKysNCj4gLi4uL3NlbGZ0ZXN0cy9rdm0v
aW5jbHVkZS9hcm02NC9hcmNoX3RpbWVyLmggIHwgIDE2ICsrKw0KPiAuLi4va3ZtL2luY2x1ZGUv
YXJtNjQva3ZtX3V0aWxfYXJjaC5oICAgICAgICAgfCAgIDMgKw0KPiAuLi4vc2VsZnRlc3RzL2t2
bS9pbmNsdWRlL2FybTY0L252X3V0aWwuaCAgICAgfCAgNDUgKysrKysrKw0KPiAuLi4vc2VsZnRl
c3RzL2t2bS9pbmNsdWRlL2FybTY0L3ZnaWMuaCAgICAgICAgfCAgIDEgKw0KPiAuLi4vdGVzdGlu
Zy9zZWxmdGVzdHMva3ZtL2luY2x1ZGUva3ZtX3V0aWwuaCAgfCAgIDMgKw0KPiAuLi4vc2VsZnRl
c3RzL2t2bS9pbmNsdWRlL3RpbWVyX3Rlc3QuaCAgICAgICAgfCAgIDEgKw0KPiAuLi4vc2VsZnRl
c3RzL2t2bS9rdm1fcGFnZV90YWJsZV90ZXN0LmMgICAgICAgfCAgMzAgKysrKy0NCj4gdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMva3ZtL2xpYi9hcm02NC9udi5jICAgIHwgIDQ2ICsrKysrKysNCj4g
Li4uL3NlbGZ0ZXN0cy9rdm0vbGliL2FybTY0L3Byb2Nlc3Nvci5jICAgICAgIHwgIDYxICsrKysr
Ky0tLQ0KPiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0vbGliL2FybTY0L3ZnaWMuYyAgfCAg
IDggKysNCj4gMjEgZmlsZXMgY2hhbmdlZCwgNjA0IGluc2VydGlvbnMoKyksIDY0IGRlbGV0aW9u
cygtKQ0KPiBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3ZtL2Fy
bTY0L252X2d1ZXN0X2h5cGVydmlzb3IuYw0KPiBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMva3ZtL2luY2x1ZGUvYXJtNjQvbnZfdXRpbC5oDQo+IGNyZWF0ZSBtb2Rl
IDEwMDY0NCB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0vbGliL2FybTY0L252LmMNCj4gDQo+
IC0tIA0KPiAyLjQ4LjENCj4gDQo+IA0KDQo=

