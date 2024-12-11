Return-Path: <linux-kselftest+bounces-23129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 610129EC115
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 01:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACD28284225
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 00:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A2B42A95;
	Wed, 11 Dec 2024 00:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="BX7ZjW+6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9912C190;
	Wed, 11 Dec 2024 00:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733878217; cv=fail; b=nROOxy/d3eM/r3PvqNAICh1ynJZ3R1QnK756ZWPqO/RGoTSc8/20j5vmQOs/4rUpgzXAbLJS+JHAadwsdeaJYgvjr/w4UNsvsYm5accPiq84Nk7FdEpQgK42dK2f8eNK4G1NDjQBemdP8KkbO2bpeXjpjgbbfY2hjDbo20LdjPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733878217; c=relaxed/simple;
	bh=zr6U4Zo5sCvvnRuuhl5Y8XSuVSPjjt0z5Q4L3zwPfV0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IIuaWgTWN7qTSZaPhQ/fVVu6oCCiqf+jIrugmzTZkYw5N66TYePuh3Z0sdnKFVhGPhVd7hkQI6qVwfQb+ZRvz+A/5ZDTP5EpKSLDbLr9AChAA8s/3Kjgf0QTzSEfL10WKUGGLMLowHD0nkKDpjcCzT9zB67XWb22wUyXw7cD5Ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=BX7ZjW+6; arc=fail smtp.client-ip=68.232.152.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1733878216; x=1765414216;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zr6U4Zo5sCvvnRuuhl5Y8XSuVSPjjt0z5Q4L3zwPfV0=;
  b=BX7ZjW+6VDIScErTLZ303fg8i4rl74lVgC3Mzk/8lJl1KVYaD+2DTcQw
   oy8mKVFDKp9oS/T9sywsW2yYSgJ4g4KMIH8x+h2ciMrYbE03JWEaSq19/
   N01x1+3leSKiAP9v96JpI2AOdtk5dClfGEN4VwT9DqYKV/4leJ8JSwyB6
   J/Mvmb77pCG+CY0e+yx8JiyefYyPzix7/3JStNtiDIWTim3gmLlJ957WJ
   wgIV/5Q7eTZ7spmaQ4zAjyL3W8kULE5GFdKnp7taWZvVhfQkK9h4unbfd
   +4q3ddY4yLtnm764KWATvgGGDLtvgmdNvSd7lm4XmNghzk6qtWgGt7SrC
   A==;
X-CSE-ConnectionGUID: n0ucwGCbTfm/XjPpr97BOw==
X-CSE-MsgGUID: B6ubdZpARjaakgMDgjJdlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="50913615"
X-IronPort-AV: E=Sophos;i="6.12,224,1728918000"; 
   d="scan'208";a="50913615"
Received: from mail-japaneastazlp17011029.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.29])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 09:50:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DUh3gkziIBVr5ogjtADhHzxut5bIE2EiYT+wDRIx6fTMjKQg6GMgTPgu3OBPL/qPGHsEWTRTvMFEbET4Krgwc+XL7gM0aT/8H++ZHE66p8b+0sX/IaYimJgcg8ag99jaO/erD+kNbGa3kNLqyn+GhBeLIbXMACnGaYHlenPSQKXQW0nham79X5Et4v3VpKjc1vq9HD3/I1bRc3dpJkFeeHkjbB1+upZ28oR5/iJ8zlideKjWCCkjtVp8lQayBVm526jzulgCYAQ2YHoWPqXSvjp7T/kX8kyQPX1g27j6JStun8tZ6q8DxhnaEQNNdhCX46i5c36SQexhixXjcHeYsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zr6U4Zo5sCvvnRuuhl5Y8XSuVSPjjt0z5Q4L3zwPfV0=;
 b=x2cO9Y9oExHHpNcei8K8cj8S3RbFBf3njh5UdYjVpSvPWJwBr9uBACJ9IaQaqKU87chMHj8vTnTF34/HiSAu7PRXu+QD+p0nd4GgNY+JBYg6EH1zXZEzceQle6oHCU3gcsy69XtwTR6RHT2OBgoj9gAvbsAFgPlXUxx2EEJHO4nSsvzRBmBFCsZPPiD1Nph0nPPo+jfPaQk8K76o/s8cMHm/XwqxUbNr+wClEEhKfAZUEoyh1kwKp3dvGwcp42EPCun8lRIN87lc+SQJHwZhyGqixJzlYGVcNT2GIWE4eIat7Ua/wgggkB0XI9foHGg1xVWhPRKdoz1gUZb7yzddXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OSCPR01MB12881.jpnprd01.prod.outlook.com (2603:1096:604:33f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 11 Dec
 2024 00:50:09 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 00:50:08 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Shuah Khan <skhan@linuxfoundation.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
CC: "shuah@kernel.org" <shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next v3] selftests/zram: gitignore output file
Thread-Topic: [PATCH for-next v3] selftests/zram: gitignore output file
Thread-Index: AQHbPLL714SeDJIalUC6KloefGQuW7Lf0zSAgACAowA=
Date: Wed, 11 Dec 2024 00:50:08 +0000
Message-ID: <c3f355ca-7ac3-45c9-af7a-c8b29c537773@fujitsu.com>
References: <20241122074935.1583747-1-lizhijian@fujitsu.com>
 <d139fee4-aadc-4c04-8e1a-1fb8751c7734@linuxfoundation.org>
In-Reply-To: <d139fee4-aadc-4c04-8e1a-1fb8751c7734@linuxfoundation.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OSCPR01MB12881:EE_
x-ms-office365-filtering-correlation-id: 91bb2f94-f955-49df-3f16-08dd197dc2fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?d0h6ckhyTkZYVW11QWUzNFpYSnF0OVpyUGY3aVdUbDdMYnJDckNOSHFldHFT?=
 =?utf-8?B?ZG16L0J2UDh1ZkMwTUZmTGpKV3FnUFBvOUlwV0tWTFRVeWF3b3prQUwzcjNK?=
 =?utf-8?B?bk9hdTFkTk5xRGRHalFIZVNGampFSFdQMEgzNEtFQTRFMzA2ZVFlYkVVa29Q?=
 =?utf-8?B?M0QyejZsRXpKSEsybFc3bVlVS1RRNFl6T0t0WTNubW1IdUZ5VGM3UWlwUHJa?=
 =?utf-8?B?c1d2QXVURFhBWWhMWU56T2NDRFVrWXRucm9JbUwwS1E2S2ptUUJYY0dUVUI0?=
 =?utf-8?B?dUFoemdZd1B1WmVRTTc1Z1dtRnV6Q1dwS3pZQWxaWXh6Z1hqdUpDS3paT2VT?=
 =?utf-8?B?TFpndHZYbWZkcGxuQlNXdXdrOURlNjlVQ01rN2M4UHMxMnNxVEgrMFJtMVZ2?=
 =?utf-8?B?N3N2TWdIQkdLRkdKVzh1a1kyd1YyUkRDUzU4Z3pkZ2NETXo4Vmw1a2ovTFFB?=
 =?utf-8?B?Z3FQcW5uM3Y2bXBPT0czaS9ldWVCbWhhYUlWdkhYcFVXZDA2YmQzSEZLYWZZ?=
 =?utf-8?B?WVRwUmgrVmZCS0d5THZLenUraS93R2ZJT0hyWWJRbXk1ajBwbFBMWW5aa3VM?=
 =?utf-8?B?aHU0QUd4cGZnM1V4eEUreEFHVGhvUG40LzJzbTVkREpGdkRFRkZaaFhwc3dn?=
 =?utf-8?B?Nm1RanBQRVhhTUI3ZGJRNnVqK2tPMlZFU2tzU3YyS1ZHVTB3UzFVaWxKN1A4?=
 =?utf-8?B?VWhrcTdXZXA2dWdWNEI4ZlRPbkhQT3h1VnU1Ry9KVVN6T1MrTU5XdWNPZmNz?=
 =?utf-8?B?T1ZwTmNFR1RGeXNkMjlEeEZ1c0dQdjdhbVE1WHczT0xNazZYNHZSOUFWQkln?=
 =?utf-8?B?dDhrbk5JRVBUTHlNYXZNRDdobU5sMy9YRENDQ3VCeHhmQjdFQXRWWlJucllH?=
 =?utf-8?B?NUpUblhEcTN5UmduNUFocmZzMjlRTnFCYjNraCtRMWdic0x1WTJJajRhN3Zx?=
 =?utf-8?B?bVhOWVBsUHNRQ3NtQklwSFNwOVpud0JDcktRVzhuaTZyWWl0OU9Fd3lHcGcr?=
 =?utf-8?B?dlNxd0I1RS9wcS9NWS81azJuUEkvVHJtRzZ3OGZuSjluR1BwRXVZK1V1TUhr?=
 =?utf-8?B?WmpZeTBiMWxXbkpSQWE4ZENPanF1S3ZmYjVWblBmaFVja3pkeEx4eElsNWhT?=
 =?utf-8?B?OVpFOVhCNEdvbkZJam94VkljakN2M2pPNzd6N295MlNMWVZFZ0ZIcSt3ZSs2?=
 =?utf-8?B?dDRmWU5oZmp1WWtrN2JabnFkQ0ZtUHFwZmgwKzBlQjRJT3JZL1FxSnB2Vktj?=
 =?utf-8?B?ME1nSWVpRjhmQjN5N011NTYrMkxlL0pqaG14K3kwMjFaOXBKa3BYaWRXaFpj?=
 =?utf-8?B?VkhOSlA4b1IvTWRjd0IrSVczenJrYWtZVllmSnpqTzJvLzRKYzRMbDhUazBU?=
 =?utf-8?B?NjZkdS9DKzNML3BWUmVDK0gxcnZmamRmc1YrUjJOUXdWa0Nza1JFRHBzMy9L?=
 =?utf-8?B?bDNxc3JEcCtUYmNsMk82QkFDUUhLdUxySGtRZlpEbnBPWGVKUngzL3JKeksw?=
 =?utf-8?B?VzYyRlRlWG5lRE5Yd0FBYlYwbDR0R2ZmMTVsQnJXN1cvTjh1OXJDNElsZzg5?=
 =?utf-8?B?SGtFRFpBaHZpaW1UdlZ0dFhDbThtdFZqcnphcmJsUnYzOUFHZFRRSDFNZUxm?=
 =?utf-8?B?RUkxK1dGZ1ZsM3hXZ3YzMjNHLzlQRU9wb3R3Qko4K0ozVitkbEIxRTIwWXBC?=
 =?utf-8?B?d25Ua0R0amppUFVYNEZ5MjBZV2VjK1Y5WGQ5blBsMGhuWnhkQlo4Z0hESndy?=
 =?utf-8?B?VEprMUgvMmNKSUo5SzIrQzkzdkxibUFIOE5nUG9NZFRoL0JOaldyNTJYWExX?=
 =?utf-8?B?Q2hlWjk4TTJaa0Nka1lTWW5XaWU5YnVDdmFoMFcrdHFPSWRpWTNWWTdEMUUz?=
 =?utf-8?B?UzF4THBNQjM1b2hwem8wSHpPL3hqL3VGNWVvUjVOMWJ1cGNWU2pvZm4yRDNk?=
 =?utf-8?Q?/DopRuBTD0uVgRsQI61AtvHS63xsANdg?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bWNMM0xFZmFpWHV3NVMzQmFwN1VyNFdBSk1DMFZ2QmJ4aXZYL2pwRGZ4SkhL?=
 =?utf-8?B?T00wcW9HZmY4bDRCckVuUFpZR1JVeE9UTzQ5N1BORmYrR0hndFQ4eCtwSmRV?=
 =?utf-8?B?Wm04c1dPT2IwVnFYUE1rZUswdXNtSnpHRlh5R2xjQ2tjSDhPWTBJdGJHU3Fa?=
 =?utf-8?B?Zmp0RCtjVjZmTkZtRWVGSWNCVmZyN3EveHpZUmRQMUUzbEZDNzNPU1ZpcDRw?=
 =?utf-8?B?V0gwSTYxOUlpY05ibmJLVTdlU0lMWDlUd2FxSVJUU0Rzd2lCVjE2WkxQOFJh?=
 =?utf-8?B?dm5qUlF2K3BDNnhVaFE4SU9vUmV3UkRUeC9wemlUNmdVMFFqOUZwVVgyNTlF?=
 =?utf-8?B?NFhqaTJLRmNTdHUyT0NZSi9SYnpNQkRScnFyOTltOW9WZkswenFkVllINzBk?=
 =?utf-8?B?TTRsZ0VaRDhVejVuL2s3MUIxbWRqcW9EUDVyTERMSFd3WFJ0VFVlUkZYMDBS?=
 =?utf-8?B?REgwVDFOZWVwOWR6bXJyeUxSRUlUUExnOHBVKytVSFUrTWttZXE3V3VaaGd2?=
 =?utf-8?B?Mm1FTTVPNE1JTWVWTzF0SUp2UHJjSDU5dVhmb09qTWRhZ2FnM3N6L0dPM0kr?=
 =?utf-8?B?OFp3TTk3d3hiQVhWeUk2bjdMRWhURkpFMnVzUXZmRmp4YTlTclhVS2JYRUVU?=
 =?utf-8?B?RitXaktDWDRVRUdrbCtFL2tZbGczbWxocSs4VkZKRVpFb29WMzNjQ1pqTzZp?=
 =?utf-8?B?NHVDdTRsVWl0djA4akZKQ1ZKWThXT2Y1bG1xTEgwYit0RlRnUnMxYlpCMHlP?=
 =?utf-8?B?SHIvTkZ3OHEzSDNYTTluT21DTDExZFFUY3hRUTlaYTB3VjBmbnphKzNIeHhp?=
 =?utf-8?B?R0FkdU5UaitHc29jWksxN05RWE1aM00rRkc5SGdtWHhQb2wvWWorbW8zdXNE?=
 =?utf-8?B?NzVXclB2Y2xKR1BxcHRjVWNpajMvN29LVER0MkU4eGd2WWdqd002Z0p4UGZB?=
 =?utf-8?B?QmtoRzN6QzR1b05pN1VieDFFYUdTdHc5dlFkUWtFWmFxdkZwK2t0dHN5M3Zt?=
 =?utf-8?B?NUJIS3hWK3M5bmpYWVNuMHFkTkxjVnVTOXdIeVppblpPWUxMazdQQXFNWE9r?=
 =?utf-8?B?anZxOFRSREJRL3o1M2x3Vk5pNk5pWEtjUCt6TmVzNFZOYnl1c0FKVEE4eHBI?=
 =?utf-8?B?MlZqK1BtQ1NFRUl5MHNFVUlUVE9jcTBBcGhTZW01Y090L05yMTZrS2VEMEk3?=
 =?utf-8?B?MjFjU1ZzRi9xMUoxTW52QkxSV0I3Q255WHdSRStiS3lRN01KZXBWbys1MFYx?=
 =?utf-8?B?TkRUeWc5N25PZHRGMjcwdGhPVGgvS2Jla2R5M1o3MUMyNURMNnFsU2l6ZFRW?=
 =?utf-8?B?dHlSZFFacEVacWl1S0d4YjluN2xKRXdvcElqbUFDZCtCbW13SEhKc2pzVGRm?=
 =?utf-8?B?ZTZqek1Gd1BRczlpOS81WXRQY1Bmb1piZlpIU2ZxQmFHUTljcFJKcXRFZ1RF?=
 =?utf-8?B?NWVmbkMyWUJlcFVGQjZUN21nWlBkQ1MxUmhhZDdCenIxM2dweERCdk5Rc1F1?=
 =?utf-8?B?V3JtazlSd1dyUDNqQzQxZWxVRW5DZ3BISjJQR2phWDBEb1FGZnRIU2ROVlRx?=
 =?utf-8?B?KzFHZUg4QnUwcE9hYWVwSExUT0JEYUhKN21GNG1nR1QrN3VxMXRwRVlKWlFU?=
 =?utf-8?B?MlNEUXdCUTY4UEdvN3JGZjkwZCszb1V4TnZ1K2ZKS3c1bTF6YkVLMVEvOGRn?=
 =?utf-8?B?aUtVNGdieWtUakd2NndQZncyb0E4Z09PMEVJQTBod0t4eDBhSTkzMitEMytQ?=
 =?utf-8?B?bWU4bGVzTklMMTNkVXVSL1poV1Q3dklSTGwvYVUrcjN0N2FqT3VGWVN6T1F5?=
 =?utf-8?B?WDhrWUNSWHZmNFRvdVpxRVRSU08vQmhEc0tXbTBCVHZoampBbmd3eHo5c0Rp?=
 =?utf-8?B?S2M2SnpHK0l1N3ZRTHJlbDdaUXhBd3g2cmRVR0UySm9YV29hOG1SVXFuZ0hU?=
 =?utf-8?B?ZWJaNEZOSW9ORnpJVEhNNjhIdUpWSHRQaTlLUUxGaEwrOCtZVHFPVDNMT0Ex?=
 =?utf-8?B?NmU1K3lCR0pBUUROQWVqL2ZMMm1hVzNzODlpRXlNRVh4djM0aGQ2VysxVmxU?=
 =?utf-8?B?Nmxub29MSUFpWEkrTE9FcXR6OWdrUWcrRnVEMGJoVmV2NGJxQVJ0UE1oVlZF?=
 =?utf-8?B?VUNFNEEvdGdHSFJpQXAzdUs5T2NTZC9xNlBaU3dMaFdrZVF6d010VUluek5Q?=
 =?utf-8?B?eFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6F6F1EAE4BD184AA8D7F625A39A8D09@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8e1+yOqvo0zLw3V4K7eETwFYXfC4HDPjBiDJ7D50auZMrzOqq91siYQ8F1FURxdNxQ2qF3wYh7roHrwYHQVbljC5oHr8Fas9gDeCuqaokTkMeNH4kYNkm+q5SJUTvTe6jeDCEXjbOh8E+UbMsvuUVTIhA4D6+emgGi1GX/lq4vC/nnaoJyFx7QqY/t7O5hMaruGlZVdhhmdO0c3ILlQExWLmIsoNSr6EpqyXJIOSOs7aarXgnyvQit0CHjDWANQ5Xffx6zJIwmFgTTVwiu5Rm9tc+Gen4VFcxeRWpddg0d/4QcrhyQRWVcJ6CTTBp76RL2cMhxzMiaanYFDYFkuwI5YjHAeO3iPTe8yAYa1HvyhJojf6zfv32J9u2mL+HU0aP+3J4hrYDNP4CxSPSYASCI1zhcCmA5LWqP+jN1B0HBTMW2DGYHKcwHSLzpzCp18zFVwxL9GkkA9C3taFStQQbq8Vo4LnIAWWZiU6YQdoh6eCroLGwGEZUkIyoAr+lffG9t4RJFCth7AJ53ZOMDQHWMX8oFDNaaaH+dbUlz1Us3n4t3aUSfJYRzvfr8aMH+BOlunMd2bwqiUG/2/oSEpLnsM6PkX8q71oH4npkTxDxF3NtUCmyBHnzUSAZMyj61Dt
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91bb2f94-f955-49df-3f16-08dd197dc2fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 00:50:08.8868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M1XwOWUXO1xqW1xyYvtzJ7Ed2wRN7XdEqiy59qrwnfJRr7Sm+f5QhfWl1AWCSFRY4yABAG5Jzc46Fkm3p68ZsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12881

DQoNCk9uIDExLzEyLzIwMjQgMDE6MDksIFNodWFoIEtoYW4gd3JvdGU6DQo+IE9uIDExLzIyLzI0
IDAwOjQ5LCBMaSBaaGlqaWFuIHdyb3RlOg0KPj4gQWZ0ZXIgYG1ha2UgcnVuX3Rlc3RzYCwgdGhl
IGdpdCBzdGF0dXMgY29tcGxhaW5zOg0KPj4gVW50cmFja2VkIGZpbGVzOg0KPj4gwqDCoMKgwqAg
KHVzZSAiZ2l0IGFkZCA8ZmlsZT4uLi4iIHRvIGluY2x1ZGUgaW4gd2hhdCB3aWxsIGJlIGNvbW1p
dHRlZCkNCj4+IMKgwqDCoMKgwqDCoMKgwqAgenJhbS9lcnIubG9nDQo+Pg0KPj4gVGhpcyBmaWxl
IHdpbGwgYmUgY2xlYW5lZCB1cCB3aGVuIGV4ZWN1dGUgJ21ha2UgY2xlYW4nDQo+Pg0KPj4gQ2M6
IFNodWFoIEtoYW4gPHNodWFoQGtlcm5lbC5vcmc+DQo+PiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlq
aWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQo+PiAtLS0NCj4+IEhlbGxvLA0KPj4gQ292ZXIg
bGV0dGVyIGlzIGhlcmUuDQo+Pg0KPj4gVGhpcyBwYXRjaCBzZXQgYWltcyB0byBtYWtlICdnaXQg
c3RhdHVzJyBjbGVhciBhZnRlciAnbWFrZScgYW5kICdtYWtlDQo+PiBydW5fdGVzdHMnIGZvciBr
c2VsZnRlc3RzLg0KPj4gLS0tDQo+PiBWMzoNCj4+IMKgwqAgQWRkIENvcHlyaWdodCBkZXNjcmlw
dGlvbg0KPj4gVjI6DQo+PiDCoMKgwqAgc3BsaXQgYXMgYSBzZXBhcmF0ZSBwYXRjaCBmcm9tIGEg
c21hbGwgb25lIFswXQ0KPj4gwqDCoMKgIFswXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51
eC1rc2VsZnRlc3QvMjAyNDEwMTUwMTA4MTcuNDUzNTM5LTEtbGl6aGlqaWFuQGZ1aml0c3UuY29t
Lw0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNv
bT4NCj4+IC0tLQ0KPj4gwqAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvenJhbS8uZ2l0aWdub3Jl
IHwgMiArKw0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPj4gwqAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3pyYW0vLmdpdGlnbm9yZQ0K
Pj4NCj4+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy96cmFtLy5naXRpZ25v
cmUgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy96cmFtLy5naXRpZ25vcmUNCj4+IG5ldyBmaWxl
IG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjA4OGNkOWJhZDg3YQ0KPj4gLS0t
IC9kZXYvbnVsbA0KPj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvenJhbS8uZ2l0aWdu
b3JlDQo+PiBAQCAtMCwwICsxLDIgQEANCj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wLW9ubHkNCj4+ICtlcnIubG9nDQo+IA0KPiANCj4gSSBhbSBzZWVpbmcgZHVwbGljYXRl
IHNpZ25hdHVyZSB3YXJuaW5nIG9uIHRoaXMgcGF0Y2guIFBsZWFzZQ0KPiBmaXggYW5kIHNlbmQg
YSBjb3JyZWN0IHBhdGNoLg0KDQoNCkdvb2QgY2F0Y2gsIGZpeGVkIGFuZCBwb3N0ZWQgYW4gdXBk
YXRlZCByZXZpc2lvbi4NCg0KVGhhbmtzDQpaaGlqaWFuDQoNCg0KPiANCj4gdGhhbmtzLA0KPiAt
LSBTaHVhaA==

