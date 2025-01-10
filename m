Return-Path: <linux-kselftest+bounces-24221-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39599A096FD
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 17:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BEBB16730A
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 16:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADE7212FB8;
	Fri, 10 Jan 2025 16:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="hVowY8FH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020139.outbound.protection.outlook.com [52.101.191.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A40211715;
	Fri, 10 Jan 2025 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736525821; cv=fail; b=Q5GOK2y4tPXWt9vUHJSlyo9XdgSdlx+vCVHiLE4r3jgqKnt132niSKiPlPYaj02D8PrOSRzAk9BzdQ9bCVImaTGSU/EtMueLM2AmujjseuqGRThDOLwoKHxFGJVLr7r70FOSJB9wtTXJPAnCDImN0zaoM/EhUVkLdHM1wlF7E4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736525821; c=relaxed/simple;
	bh=8s5luUvoVuBm+e8sjw79w6gXrApqOZ2FNNR6C7mPTnw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xy4mKoA4olxjzP3k0h7X9vMcYhEBA4fCIusEht511I8WYr5VUx48zhzkc3dLdhP7JSYKaiyRH10xOIZDR0lmfZA7bw32sGNH4kqZOeuxJrC+x5crnqNyFXpI/bpwcqAm0OSkuaqFdOmvxSiY0QnGQzqnwPyYNsGgaCbpmgAZ+DI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=hVowY8FH; arc=fail smtp.client-ip=52.101.191.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zy3sPCCrA6ZHDlVrgKAM1O/2RAdz3CNtIK+xhoGTSu6Sp1qlFDr4ekpMhMW13K51gYxlQI4ufP1+dIhDMr0tJeSkH62UndxM1pX8T/UKQ+IR8AdnnT5GjdXhCzwFsh64SEGYIWZa/nYsObpfkAaVgXSiae5BP7HEX3CDwMZoHphAW7x8MrhWflTkod0IMKC7Pj66yL/JP8osx1jOkpKatKWRb1ss5zAGj9pFyw+j6e1mWflRugYfXQmSiwZtN7cdt9CRKpRbmke9buiAaOVhTTYdZPlIotAxi8F7JA3mviSjOUZg45R8pOMlxAlab/thJQKmDoE21qhGU5vTRgvJvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7kpsy5O/3doe8rg3nPHV7Wh4zcugyCxgyUBKtjPZKw=;
 b=nlZhQ1KlvNNAB0I5EywHpj2XBtqMW1SRazrSpHRcaJ5whMCbXAPkae8a30rGFozLgDOWD+ioVl1aa3nNIOghXHnVWh6nFAWNNFQrFe/jbOOtLDZRtF97I2jmVtefDdXC5Hum5tvXHZWi+ywYUzPTFxwM4HZOo7p9rhBvzbMWxNeMRwK824iSLTBBEO6NegE0oGqAXQulRygrgZLMzmwi9XqGb5HH/fS2V1+cb+WqyxzMVpKseZFmDZeERZ7eC+64mgZ98HVVauBbuLKAD3XuwIQf7k4cPYi4u6p19gXY2iqoNbnS7Q0tE1XMhoa7DhJ/zdFxPi4jghhxnKHGb5JqhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7kpsy5O/3doe8rg3nPHV7Wh4zcugyCxgyUBKtjPZKw=;
 b=hVowY8FHcur8OoHRrcVLVlfJaZamurK5sWxH5s8VhJbWYpwQ0ut+V+PJrSB7Yb9XBVMuMsXoqKEpCbWSXGae+Uz1i+pwcqOqHoZcC9VBfMpTPufCO/+/gLlch/itK318q6ZgvzNrPjtD+N1+vnpHOIyKyyOciIvwlTEHPUJsBwYBXN+3l/mk2UDxQJJxQsS9Zb0oqc6DESoKMUf63yKx0HMCP+O12K3iR5Nu24DO/0ic2OR3YxPJtO/6BXgFIvhkZTK/qIN0LUPfPOU1joVli5bsMxUSfBEKaHFR2UDahlWSyfBr9I6Hv23OoEjnMwklIepE5mE/M22qozdynUVe5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR01MB10829.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:79::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 16:16:56 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 16:16:56 +0000
Message-ID: <cf78a480-e38f-496c-931c-cd889fb29d59@efficios.com>
Date: Fri, 10 Jan 2025 11:16:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] rseq/selftests: Add support for OpenRISC
To: Stafford Horne <shorne@gmail.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
References: <20250110102248.3295944-1-shorne@gmail.com>
 <20250110102248.3295944-4-shorne@gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250110102248.3295944-4-shorne@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::17) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR01MB10829:EE_
X-MS-Office365-Filtering-Correlation-Id: db0f6b02-468e-48a2-ba40-08dd319233dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2JzTG1WaWFXSCs4T1ppa2MvMEphQTVKenRaTnVYbVhqL3dGWkVQbVJLL2ls?=
 =?utf-8?B?ZHZJUW1aSzMyb1lCVExjcHBXTTJmNDZOWENabmhZZW5yaytObXVFVEVlVnhM?=
 =?utf-8?B?bWQ5ZDEwb3NsZXRwNDFEVFRINDBETmdUZjV2dFRaOGl3bGswSGlTZFBzUCtp?=
 =?utf-8?B?Q3h1Tjg0eSsvejFwOXl2Unh4amJwYVY5a3NXb1RRMnVrRmpRWGZJeUVha0Nn?=
 =?utf-8?B?VFZaOXQzODdOaDhtb2xOQ25sSTU5VE45QnlYUHdobTZMNGh4ZXRnUzZlTHl4?=
 =?utf-8?B?S2kyc2xsRVBEUGdMSmE5ZUtRRTVDQmwvZ05KTy81aWVDY2JKSlRzRkpuRVg4?=
 =?utf-8?B?Y3FUcEhUWnkyRGQ0RkpPOUtMQXA5SFEzdUYyQ3JVR2dtVkcvWTZHMTdaZFh4?=
 =?utf-8?B?N1RWdFlBTkduWTlPTUxJY2RSaE1BKzcweWdjcnh2dndyUVJ0ZjkvYnU0NU83?=
 =?utf-8?B?Wmo2MDVnNVE3OE5UYjlzeVJWNXdSNDYwYkhRM1cybnk2VXp6SUdPL2pleG1Q?=
 =?utf-8?B?VS96N2wxamQzek9IZ3liS3ZOcURvQWxTNWNQbGQ1ZEtnQWlrRmZrQi9mMk5G?=
 =?utf-8?B?dk9MdlN4N0EreHhhdzh5SzU3ZGJ1cklpY0lQUkwycnNycFd0WHVqb2FSVUFM?=
 =?utf-8?B?azJVaXMrbVpEMExVZkZJU2VzVWdXdDN4c1Q2K3JlT2JUK3hPbXVUZ2d5a1dq?=
 =?utf-8?B?Qml1Zi9pM3N0N3FIVkhmWk5pdi9rcXozMHBnYk9EcjVaK25LNUcvbE5Ha0Yx?=
 =?utf-8?B?czg1bVB0WEZpNDZkWEkyQ1V2cGo1cUUrZGNvd3JyOXNBOHI4S3lKRU52d29C?=
 =?utf-8?B?UklaT2g5Slh5QU9KWUsxakEyU0dnSXV2KzZUcmNqN0dsT0hkRnVEK0s2eGti?=
 =?utf-8?B?NkJ3dVBjaE9PUDNxVTRjVDErN0psdzUyaGt6SVhmbXBScGVjdE5TR1pIRFZF?=
 =?utf-8?B?NnU2akhlNmkyb0RHTklnMEZ3Ynh4TzRBamFqY2JOZlZSWmRsbW1YUkdVUkds?=
 =?utf-8?B?Y3dsamJEUUJFb043ck1ubnZQaFZrNkZndmNtdis5VTRKNWxrT2VSdEdGYk0r?=
 =?utf-8?B?cCtaK213ejZnZ3pzaVQrU3dTQ0xrL0szN21tNDZCWTlkemdxV25NMUY3Z2xm?=
 =?utf-8?B?c1NDUE1OZEY0c1Yza2gwMHJoWUtyRk1SY0p0WHZ1K3ZiRXQ3dkdKZ25nMmJQ?=
 =?utf-8?B?VUREUWhCYXpSQXZCYkhaU1crMDI1QjNGRnppTTlxelJnRHhvMCtFdnVUMjhN?=
 =?utf-8?B?YzVvanZMeUEwa1hvVWxRaSs0WDQ2S3dtZjZ2akJvYUFmcVBlN0llc3lKWHZh?=
 =?utf-8?B?SEJmRERvQmxwRkkzOHJUemhZeDBGeE9ZTkJwWFZ4NWZKY05MZSt6SkFlMldO?=
 =?utf-8?B?RGl5WTNNSk9vYkpRblhqbkxVY0t6NzFHYjRLYUtoYXQ5YlJkUndYSVZRN2VX?=
 =?utf-8?B?b1JzVEtmUVFPa2JXK2EveTd6aTVib3dLeitqVDVQREdsb3R5Y3gvWlBwLzNa?=
 =?utf-8?B?aUd2M25FREtaelhSZ215T3BvQlNVRnR1Y21uTEFSbnNGV04vc1BBbG5nVUE4?=
 =?utf-8?B?TllTd3p5dlRpanVCR2twYUFFRlNtWlVsV25jZGVnS1JwbGJyYjBoeExvaVhI?=
 =?utf-8?B?eVQ0L2YzTE1VbEpKNDZaQ2x2czdJOTVyemFHVlVvQTVvQjczNkdlOE1HTlZZ?=
 =?utf-8?B?blMvVnB4SWdaM0NWUElLUDUxRnV6M3A5M0MwNGdqWmFqdjFKZVlJeFMyd2Fw?=
 =?utf-8?B?cUxLZGZjS3lPeVFFQ1UvSmdtWE96US8zWWU1azkyVnd5d3F6bzZNVmhPbXl2?=
 =?utf-8?B?VURvU0Z2cDVMMVdaNGwydz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVpCVDZSUTVDWTVQVkpHQTZjUCtoSVhaYVRjSzVySFUxTmVqSWlLK0NjUUNy?=
 =?utf-8?B?Tk54VkRGVitFdGhrWEdiOXJKSXlHK3dwTngzTnJnWU1SYWRXcE5pMXJYUnRw?=
 =?utf-8?B?cUZpZnZvVndHZHJ5dkRiVWxQUUtVVEFNaTBMMUpYY2xjaW8yNllBcGEzd2xW?=
 =?utf-8?B?eldOdVgxSUIvMDhvNFZUL2pkM3pwWW9vTEhnV3BRd0V6MXQydzgvcEZKZFJS?=
 =?utf-8?B?VjVUSEZYZnpIUWdXWlJBKyt0WVpITlR0TVVjcTI0cUpSZU0wNVZjR0Rtcjh6?=
 =?utf-8?B?S2h6WFhsNTVyR1B6T2VYU1lqSi9XVVdlYXh5dnV0RTZ2K2lPUG1pSE1FU3Er?=
 =?utf-8?B?RCtFWFBSUm8yOG56S3BzVjZZYkt6Z25RME9iTkZZTVgxVG10OE1CblpBU2Rj?=
 =?utf-8?B?V0RYN2d0cjFMd2wvZzBDaGlSczhIZ092d0l1ZUVvNXNjRTFCZUJmMHF2Q2Fo?=
 =?utf-8?B?eGI0VlBHdHVYQnQ0Qm1WYXFBaWlZcloxK1o2VFQ3bVplTzNDNFJNM1hsRGNJ?=
 =?utf-8?B?TmF0S1E3WHNzbmFRZ0ZJc2hIU093MVBoSkgwUXgyL0tVZTR2eEN3VkRqMk1p?=
 =?utf-8?B?RnZPcUFXeExNbTEwb1VIQU16OElaQXFHcDBtcU9GOTNIVXNsYWtjQVZiMDRa?=
 =?utf-8?B?MXhRMGZLSWRJb1dMWHNjaTRWNHFmbndBUEplWERtL1VGeDJob1dGVlhpRytJ?=
 =?utf-8?B?bWtVTTFVc3hjWmtZN1h6OVZzeUVmYXQwK0dQaVRXanJ3R3pXaTg0T2VRZXlZ?=
 =?utf-8?B?Z2xHNmpvTUhJTmliaW5rTXZtcE1GWkpvZ242LzdrMHVpODFGaHlXcERrVGNy?=
 =?utf-8?B?ZDlMU2xNZFNEL2hTcHVKSEJjbDNXdmZZNUw5eFVaTEg4TWIyM0Y1YnkzaHkr?=
 =?utf-8?B?Z1RETVR2am5pY0R4MzRyWDZobTkrYUc0Sjc1dkxhSC9JbUxsSFN6NUN6eXM0?=
 =?utf-8?B?QzhCQUdKdVp6QkhYYlRZZmFxdXprZ01tOHhsM3Bja2l5WDBmZC9lREEyOVFz?=
 =?utf-8?B?Q25abkFZUDFJbGEzbDIrZk5KSmwzWERpTTlBUWtuQ0toUk5qNnRTdVFsYUsy?=
 =?utf-8?B?WXhzb25yVjZVTjdKL1hxODJGZHM4RDJHVS9aSUxqNDFCK3RINThvTEYzSTlC?=
 =?utf-8?B?QlhzUU1uUzl5bGtYZ2tjZitlbHczc200VkMrOUlvSWY3dnBXMnZCa1p4b1Y5?=
 =?utf-8?B?RGptU3I4eFV4Qy9URUZsNHVLNmdxUGVjT2tEcENXRHRoSUxlU0lnZkYrMFdB?=
 =?utf-8?B?Vk5hVlgvdjN5c1M2Skd5T3JpUWhvaW9hL0tnNzdPSGNxcHFNNnVXbDlSSWVy?=
 =?utf-8?B?NS9YU0E3RFpQRVd6WmVTeTAraUN6U2UrRGtPOUQ1UFlOZzBzK0I1Wk5JN0lU?=
 =?utf-8?B?N3RLcVdkV3NVU2VUWUdnYU9lOS93a3VmcWtBRUs2YjBuMHFvQTA2aFB3TlN3?=
 =?utf-8?B?Skl4Nk8yN1NYMTB2MjU5OWNxNUZCMjJXMTdVU0JiOUQzQ25UUUREdnp0akNw?=
 =?utf-8?B?WGNyZlc1SVRQcEpRbVlFd0grTDIyTzcxSTdRZDd0ME1yZUhTbjFSc2xJMXE1?=
 =?utf-8?B?U1BKeHBIa0JGVzh0Z0QyRnFwL2JMMS80aG94Nk9DN0UrcUtPK2MrWWFGcklM?=
 =?utf-8?B?a0ZjOW5VWSt5SVBpbjkvRWpsNEt3T2srUnNEcnQ1SVNTc1dRK2N5eGFXbXpt?=
 =?utf-8?B?UmhWM0RtbFhSMm56UXd0RkEzRDVKK0Nzanp6eDhVUTZaeXFPRVlqaThQajgx?=
 =?utf-8?B?SGtvK21TMGxsQ1IwQ2NCMXQyVXptc29FNGZBK2MxOFB4SjVFK0RFSDc1YWRZ?=
 =?utf-8?B?UDhxMUpFYkVBaE05Y2R1TkVHVk9IVyswbThXcDcxYXJ2VFVsN2FIcjBSTnNH?=
 =?utf-8?B?SW5FM0syMXpISEd2b0U5eUZsdG9OelhEUFRuNE5CeWFtV1Z5MmljQXhJa0dY?=
 =?utf-8?B?L05RTE85MXhLQWF1WjFBcDN6OUNTZzNWakYrbDRKZ2xQZ3J4SlZOTXEyYnFw?=
 =?utf-8?B?bTN6RmlnaHFkNzlWN3FrSU50WFBrZmRLV0tGUkdyR3Z3VnZ6djFaZkM4MTkw?=
 =?utf-8?B?OGQ2WFFpNnN4emtVR1hKRDZKQlJ2eERiREs5b0F0Rm4wd0ZFbGEydDVLSmt2?=
 =?utf-8?B?UlZjbm8wNGtoSUdNNGhnanBXYW5GWlpZTW10Sk1TQ2g2WGZ4TjJwdVovVk5L?=
 =?utf-8?Q?c5KV4AtchFOrRN9MT7I62Cc=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db0f6b02-468e-48a2-ba40-08dd319233dc
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 16:16:56.2899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zKA6lug58HY+6t5Z/lpJltO/PF29QwMCdyEmyJN/ZC9t8/2T9m1OIRGw88ZLZlCzjSRV9bDjGriMi2qNgPXQY9qCquCxDfa99/lhpC6FyKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR01MB10829

On 2025-01-10 05:22, Stafford Horne wrote:
> Add support for OpenRISC in the rseq selftests.  OpenRISC is 32-bit
> only.
> 
> Tested this with:
> 
>      Compiler:  gcc version 14.2.0 (GCC)
>      Binutils:  GNU assembler version 2.43.1 (or1k-smh-linux-gnu) using BFD version (GNU Binutils) 2.43.1.20241207
>      Linux:     Linux buildroot 6.13.0-rc2-00005-g1fa73dd6c2d3-dirty #213 SMP Sat Dec 28 22:18:39 GMT 2024 openrisc GNU/Linux
>      Glibc:     2024-12-13 e4e49583d9 Stafford Horne   or1k: Update libm-test-ulps
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Thanks!

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> ---
>   tools/testing/selftests/rseq/param_test.c     |  24 +
>   tools/testing/selftests/rseq/rseq-or1k-bits.h | 412 ++++++++++++++++++
>   .../selftests/rseq/rseq-or1k-thread-pointer.h |  13 +
>   tools/testing/selftests/rseq/rseq-or1k.h      | 181 ++++++++
>   .../selftests/rseq/rseq-thread-pointer.h      |   2 +
>   tools/testing/selftests/rseq/rseq.h           |   2 +
>   6 files changed, 634 insertions(+)
>   create mode 100644 tools/testing/selftests/rseq/rseq-or1k-bits.h
>   create mode 100644 tools/testing/selftests/rseq/rseq-or1k-thread-pointer.h
>   create mode 100644 tools/testing/selftests/rseq/rseq-or1k.h
> 
> diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
> index 2f37961240ca..05d03e679e06 100644
> --- a/tools/testing/selftests/rseq/param_test.c
> +++ b/tools/testing/selftests/rseq/param_test.c
> @@ -226,8 +226,32 @@ unsigned int yield_mod_cnt, nr_abort;
>   	"addi  " INJECT_ASM_REG "," INJECT_ASM_REG ", -1\n\t"	\
>   	"bnez " INJECT_ASM_REG ", 222b\n\t"			\
>   	"333:\n\t"
> +#elif defined(__or1k__)
>   
> +#define RSEQ_INJECT_INPUT \
> +	, [loop_cnt_1]"m"(loop_cnt[1]) \
> +	, [loop_cnt_2]"m"(loop_cnt[2]) \
> +	, [loop_cnt_3]"m"(loop_cnt[3]) \
> +	, [loop_cnt_4]"m"(loop_cnt[4]) \
> +	, [loop_cnt_5]"m"(loop_cnt[5]) \
> +	, [loop_cnt_6]"m"(loop_cnt[6])
>   
> +#define INJECT_ASM_REG	"r31"
> +
> +#define RSEQ_INJECT_CLOBBER \
> +	, INJECT_ASM_REG
> +
> +#define RSEQ_INJECT_ASM(n)					\
> +	"l.lwz   " INJECT_ASM_REG ", %[loop_cnt_" #n "]\n\t"	\
> +	"l.sfeqi " INJECT_ASM_REG ", 0\n\t"			\
> +	"l.bf 333f\n\t"						\
> +	" l.nop\n\t"						\
> +	"222:\n\t"						\
> +	"l.addi  " INJECT_ASM_REG "," INJECT_ASM_REG ", -1\n\t"	\
> +	"l.sfeqi " INJECT_ASM_REG ", 0\n\t"			\
> +	"l.bf 222f\n\t"						\
> +	" l.nop\n\t"						\
> +	"333:\n\t"
>   #else
>   #error unsupported target
>   #endif
> diff --git a/tools/testing/selftests/rseq/rseq-or1k-bits.h b/tools/testing/selftests/rseq/rseq-or1k-bits.h
> new file mode 100644
> index 000000000000..15d0e8200cd1
> --- /dev/null
> +++ b/tools/testing/selftests/rseq/rseq-or1k-bits.h
> @@ -0,0 +1,412 @@
> +/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
> +
> +#include "rseq-bits-template.h"
> +
> +#if defined(RSEQ_TEMPLATE_MO_RELAXED) && \
> +	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID))
> +
> +static inline __always_inline
> +int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_storev)(intptr_t *v, intptr_t expect, intptr_t newv,
> +				int cpu)
> +{
> +	RSEQ_INJECT_C(9)
> +
> +	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
> +				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
> +#ifdef RSEQ_COMPARE_TWICE
> +				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
> +				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
> +#endif
> +				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
> +				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
> +				  RSEQ_INJECT_ASM(3)
> +				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[cmpfail]")
> +				  RSEQ_INJECT_ASM(4)
> +#ifdef RSEQ_COMPARE_TWICE
> +				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
> +				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[error2]")
> +#endif
> +				  RSEQ_ASM_OP_FINAL_STORE(v, newv, 3)
> +				  RSEQ_INJECT_ASM(5)
> +				  RSEQ_ASM_DEFINE_ABORT(4, abort)
> +				  : /* gcc asm goto does not allow outputs */
> +				  : [cpu_id]		"r" (cpu),
> +				    [current_cpu_id]	"m" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
> +				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
> +				    [v]			"m" (*v),
> +				    [expect]		"r" (expect),
> +				    [newv]		"r" (newv)
> +				    RSEQ_INJECT_INPUT
> +				  : "memory", RSEQ_ASM_TMP_REG_1
> +				    RSEQ_INJECT_CLOBBER
> +				  : abort, cmpfail
> +#ifdef RSEQ_COMPARE_TWICE
> +				    , error1, error2
> +#endif
> +	);
> +
> +	return 0;
> +abort:
> +	RSEQ_INJECT_FAILED
> +	return -1;
> +cmpfail:
> +	return 1;
> +#ifdef RSEQ_COMPARE_TWICE
> +error1:
> +	rseq_bug("cpu_id comparison failed");
> +error2:
> +	rseq_bug("expected value comparison failed");
> +#endif
> +}
> +
> +static inline __always_inline
> +int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpnev_storeoffp_load)(intptr_t *v, intptr_t expectnot,
> +			       off_t voffp, intptr_t *load, int cpu)
> +{
> +	RSEQ_INJECT_C(9)
> +
> +	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
> +				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
> +#ifdef RSEQ_COMPARE_TWICE
> +				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
> +				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
> +#endif
> +				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
> +				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
> +				  RSEQ_INJECT_ASM(3)
> +				  RSEQ_ASM_OP_CMPNE(v, expectnot, "%l[cmpfail]")
> +				  RSEQ_INJECT_ASM(4)
> +#ifdef RSEQ_COMPARE_TWICE
> +				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
> +				  RSEQ_ASM_OP_CMPNE(v, expectnot, "%l[error2]")
> +#endif
> +				  RSEQ_ASM_OP_R_LOAD(v)
> +				  RSEQ_ASM_OP_R_STORE(load)
> +				  RSEQ_ASM_OP_R_LOAD_OFF(voffp)
> +				  RSEQ_ASM_OP_R_FINAL_STORE(v, 3)
> +				  RSEQ_INJECT_ASM(5)
> +				  RSEQ_ASM_DEFINE_ABORT(4, abort)
> +				  : /* gcc asm goto does not allow outputs */
> +				  : [cpu_id]		"r" (cpu),
> +				    [current_cpu_id]	"m" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
> +				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
> +				    [v]			"m" (*v),
> +				    [expectnot]		"r" (expectnot),
> +				    [load]		"m" (*load),
> +				    [voffp]		"Ir" (voffp)
> +				    RSEQ_INJECT_INPUT
> +				  : "memory", RSEQ_ASM_TMP_REG_1
> +				    RSEQ_INJECT_CLOBBER
> +				  : abort, cmpfail
> +#ifdef RSEQ_COMPARE_TWICE
> +				    , error1, error2
> +#endif
> +	);
> +	return 0;
> +abort:
> +	RSEQ_INJECT_FAILED
> +	return -1;
> +cmpfail:
> +	return 1;
> +#ifdef RSEQ_COMPARE_TWICE
> +error1:
> +	rseq_bug("cpu_id comparison failed");
> +error2:
> +	rseq_bug("expected value comparison failed");
> +#endif
> +}
> +
> +static inline __always_inline
> +int RSEQ_TEMPLATE_IDENTIFIER(rseq_addv)(intptr_t *v, intptr_t count, int cpu)
> +{
> +	RSEQ_INJECT_C(9)
> +
> +	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
> +#ifdef RSEQ_COMPARE_TWICE
> +				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
> +#endif
> +				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
> +				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
> +				  RSEQ_INJECT_ASM(3)
> +#ifdef RSEQ_COMPARE_TWICE
> +				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
> +#endif
> +				  RSEQ_ASM_OP_R_LOAD(v)
> +				  RSEQ_ASM_OP_R_ADD(count)
> +				  RSEQ_ASM_OP_R_FINAL_STORE(v, 3)
> +				  RSEQ_INJECT_ASM(4)
> +				  RSEQ_ASM_DEFINE_ABORT(4, abort)
> +				  : /* gcc asm goto does not allow outputs */
> +				  : [cpu_id]		"r" (cpu),
> +				    [current_cpu_id]	"m" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
> +				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
> +				    [v]			"m" (*v),
> +				    [count]		"r" (count)
> +				    RSEQ_INJECT_INPUT
> +				  : "memory", RSEQ_ASM_TMP_REG_1
> +				    RSEQ_INJECT_CLOBBER
> +				  : abort
> +#ifdef RSEQ_COMPARE_TWICE
> +				    , error1
> +#endif
> +	);
> +	return 0;
> +abort:
> +	RSEQ_INJECT_FAILED
> +	return -1;
> +#ifdef RSEQ_COMPARE_TWICE
> +error1:
> +	rseq_bug("cpu_id comparison failed");
> +#endif
> +}
> +
> +static inline __always_inline
> +int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_cmpeqv_storev)(intptr_t *v, intptr_t expect,
> +			      intptr_t *v2, intptr_t expect2,
> +			      intptr_t newv, int cpu)
> +{
> +	RSEQ_INJECT_C(9)
> +
> +	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
> +				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
> +#ifdef RSEQ_COMPARE_TWICE
> +				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
> +				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
> +				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error3]")
> +#endif
> +				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
> +				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
> +				  RSEQ_INJECT_ASM(3)
> +				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[cmpfail]")
> +				  RSEQ_INJECT_ASM(4)
> +				  RSEQ_ASM_OP_CMPEQ(v2, expect2, "%l[cmpfail]")
> +				  RSEQ_INJECT_ASM(5)
> +#ifdef RSEQ_COMPARE_TWICE
> +				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
> +				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[error2]")
> +				  RSEQ_ASM_OP_CMPEQ(v2, expect2, "%l[error3]")
> +#endif
> +				  RSEQ_ASM_OP_FINAL_STORE(v, newv, 3)
> +				  RSEQ_INJECT_ASM(6)
> +				  RSEQ_ASM_DEFINE_ABORT(4, abort)
> +				  : /* gcc asm goto does not allow outputs */
> +				  : [cpu_id]		"r" (cpu),
> +				    [current_cpu_id]	"m" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
> +				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
> +				    [v]			"m" (*v),
> +				    [expect]		"r" (expect),
> +				    [v2]		"m" (*v2),
> +				    [expect2]		"r" (expect2),
> +				    [newv]		"r" (newv)
> +				    RSEQ_INJECT_INPUT
> +				  : "memory", RSEQ_ASM_TMP_REG_1
> +				    RSEQ_INJECT_CLOBBER
> +				  : abort, cmpfail
> +#ifdef RSEQ_COMPARE_TWICE
> +				    , error1, error2, error3
> +#endif
> +	);
> +
> +	return 0;
> +abort:
> +	RSEQ_INJECT_FAILED
> +	return -1;
> +cmpfail:
> +	return 1;
> +#ifdef RSEQ_COMPARE_TWICE
> +error1:
> +	rseq_bug("cpu_id comparison failed");
> +error2:
> +	rseq_bug("expected value comparison failed");
> +error3:
> +	rseq_bug("2nd expected value comparison failed");
> +#endif
> +}
> +
> +#define RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
> +
> +/*
> + *   pval = *(ptr+off)
> + *  *pval += inc;
> + */
> +static inline __always_inline
> +int RSEQ_TEMPLATE_IDENTIFIER(rseq_offset_deref_addv)(intptr_t *ptr, off_t off, intptr_t inc,
> +				int cpu)
> +{
> +	RSEQ_INJECT_C(9)
> +
> +	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
> +#ifdef RSEQ_COMPARE_TWICE
> +				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
> +#endif
> +				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
> +				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
> +				  RSEQ_INJECT_ASM(3)
> +#ifdef RSEQ_COMPARE_TWICE
> +				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
> +#endif
> +				  RSEQ_ASM_OP_R_DEREF_ADDV(ptr, off, inc, 3)
> +				  RSEQ_INJECT_ASM(4)
> +				  RSEQ_ASM_DEFINE_ABORT(4, abort)
> +				  : /* gcc asm goto does not allow outputs */
> +				  : [cpu_id]		"r" (cpu),
> +				    [current_cpu_id]	"m" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
> +				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
> +				    [ptr]		"r" (ptr),
> +				    [off]		"r" (off),
> +				    [inc]		"r" (inc)
> +				    RSEQ_INJECT_INPUT
> +				  : "memory", RSEQ_ASM_TMP_REG_1
> +				    RSEQ_INJECT_CLOBBER
> +				  : abort
> +#ifdef RSEQ_COMPARE_TWICE
> +				    , error1
> +#endif
> +	);
> +	return 0;
> +abort:
> +	RSEQ_INJECT_FAILED
> +	return -1;
> +#ifdef RSEQ_COMPARE_TWICE
> +error1:
> +	rseq_bug("cpu_id comparison failed");
> +#endif
> +}
> +
> +#endif /* #if defined(RSEQ_TEMPLATE_MO_RELAXED) &&
> +	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID)) */
> +
> +#if (defined(RSEQ_TEMPLATE_MO_RELAXED) || defined(RSEQ_TEMPLATE_MO_RELEASE)) && \
> +	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID))
> +
> +static inline __always_inline
> +int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trystorev_storev)(intptr_t *v, intptr_t expect,
> +				 intptr_t *v2, intptr_t newv2,
> +				 intptr_t newv, int cpu)
> +{
> +	RSEQ_INJECT_C(9)
> +
> +	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
> +				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
> +#ifdef RSEQ_COMPARE_TWICE
> +				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
> +				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
> +#endif
> +				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
> +				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
> +				  RSEQ_INJECT_ASM(3)
> +				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[cmpfail]")
> +				  RSEQ_INJECT_ASM(4)
> +#ifdef RSEQ_COMPARE_TWICE
> +				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
> +				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[error2]")
> +#endif
> +				  RSEQ_ASM_OP_STORE(v2, newv2)
> +				  RSEQ_INJECT_ASM(5)
> +#ifdef RSEQ_TEMPLATE_MO_RELEASE
> +				  RSEQ_ASM_OP_FINAL_STORE_RELEASE(v, newv, 3)
> +#else
> +				  RSEQ_ASM_OP_FINAL_STORE(v, newv, 3)
> +#endif
> +				  RSEQ_INJECT_ASM(6)
> +				  RSEQ_ASM_DEFINE_ABORT(4, abort)
> +				  : /* gcc asm goto does not allow outputs */
> +				  : [cpu_id]		"r" (cpu),
> +				    [current_cpu_id]	"m" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
> +				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
> +				    [expect]		"r" (expect),
> +				    [v]			"m" (*v),
> +				    [newv]		"r" (newv),
> +				    [v2]		"m" (*v2),
> +				    [newv2]		"r" (newv2)
> +				    RSEQ_INJECT_INPUT
> +				  : "memory", RSEQ_ASM_TMP_REG_1
> +				    RSEQ_INJECT_CLOBBER
> +				  : abort, cmpfail
> +#ifdef RSEQ_COMPARE_TWICE
> +				    , error1, error2
> +#endif
> +	);
> +
> +	return 0;
> +abort:
> +	RSEQ_INJECT_FAILED
> +	return -1;
> +cmpfail:
> +	return 1;
> +#ifdef RSEQ_COMPARE_TWICE
> +error1:
> +	rseq_bug("cpu_id comparison failed");
> +error2:
> +	rseq_bug("expected value comparison failed");
> +#endif
> +}
> +
> +static inline __always_inline
> +int RSEQ_TEMPLATE_IDENTIFIER(rseq_cmpeqv_trymemcpy_storev)(intptr_t *v, intptr_t expect,
> +				 void *dst, void *src, size_t len,
> +				 intptr_t newv, int cpu)
> +{
> +	RSEQ_INJECT_C(9)
> +	__asm__ __volatile__ goto(RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
> +				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[cmpfail]")
> +#ifdef RSEQ_COMPARE_TWICE
> +				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error1]")
> +				  RSEQ_ASM_DEFINE_EXIT_POINT(2f, "%l[error2]")
> +#endif
> +				  RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
> +				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
> +				  RSEQ_INJECT_ASM(3)
> +				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[cmpfail]")
> +				  RSEQ_INJECT_ASM(4)
> +#ifdef RSEQ_COMPARE_TWICE
> +				  RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, "%l[error1]")
> +				  RSEQ_ASM_OP_CMPEQ(v, expect, "%l[error2]")
> +#endif
> +				  RSEQ_ASM_OP_R_BAD_MEMCPY(dst, src, len)
> +				  RSEQ_INJECT_ASM(5)
> +#ifdef RSEQ_TEMPLATE_MO_RELEASE
> +				  RSEQ_ASM_OP_FINAL_STORE_RELEASE(v, newv, 3)
> +#else
> +				  RSEQ_ASM_OP_FINAL_STORE(v, newv, 3)
> +#endif
> +				  RSEQ_INJECT_ASM(6)
> +				  RSEQ_ASM_DEFINE_ABORT(4, abort)
> +				  : /* gcc asm goto does not allow outputs */
> +				  : [cpu_id]		"r" (cpu),
> +				    [current_cpu_id]	"m" (rseq_get_abi()->RSEQ_TEMPLATE_CPU_ID_FIELD),
> +				    [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
> +				    [expect]		"r" (expect),
> +				    [v]			"m" (*v),
> +				    [newv]		"r" (newv),
> +				    [dst]		"r" (dst),
> +				    [src]		"r" (src),
> +				    [len]		"r" (len)
> +				    RSEQ_INJECT_INPUT
> +				  : "memory", RSEQ_ASM_TMP_REG_1, RSEQ_ASM_TMP_REG_2,
> +				    RSEQ_ASM_TMP_REG_3, RSEQ_ASM_TMP_REG_4
> +				    RSEQ_INJECT_CLOBBER
> +				  : abort, cmpfail
> +#ifdef RSEQ_COMPARE_TWICE
> +				    , error1, error2
> +#endif
> +	);
> +
> +	return 0;
> +abort:
> +	RSEQ_INJECT_FAILED
> +	return -1;
> +cmpfail:
> +	return 1;
> +#ifdef RSEQ_COMPARE_TWICE
> +error1:
> +	rseq_bug("cpu_id comparison failed");
> +error2:
> +	rseq_bug("expected value comparison failed");
> +#endif
> +}
> +
> +#endif /* #if (defined(RSEQ_TEMPLATE_MO_RELAXED) || defined(RSEQ_TEMPLATE_MO_RELEASE)) &&
> +	(defined(RSEQ_TEMPLATE_CPU_ID) || defined(RSEQ_TEMPLATE_MM_CID)) */
> +
> +#include "rseq-bits-reset.h"
> diff --git a/tools/testing/selftests/rseq/rseq-or1k-thread-pointer.h b/tools/testing/selftests/rseq/rseq-or1k-thread-pointer.h
> new file mode 100644
> index 000000000000..cda740f7aff3
> --- /dev/null
> +++ b/tools/testing/selftests/rseq/rseq-or1k-thread-pointer.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: LGPL-2.1-only OR MIT */
> +#ifndef _RSEQ_OR1K_THREAD_POINTER
> +#define _RSEQ_OR1K_THREAD_POINTER
> +
> +static inline void *rseq_thread_pointer(void)
> +{
> +	void *__thread_register;
> +
> +	__asm__ ("l.or %0, r10, r0" : "=r" (__thread_register));
> +	return __thread_register;
> +}
> +
> +#endif
> diff --git a/tools/testing/selftests/rseq/rseq-or1k.h b/tools/testing/selftests/rseq/rseq-or1k.h
> new file mode 100644
> index 000000000000..9e78eebdf79a
> --- /dev/null
> +++ b/tools/testing/selftests/rseq/rseq-or1k.h
> @@ -0,0 +1,181 @@
> +/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
> +
> +/*
> + * Select the instruction "l.nop 0x35" as the RSEQ_SIG.
> + */
> +#define RSEQ_SIG   0x15000035
> +
> +#define rseq_smp_mb()	__asm__ __volatile__ ("l.msync" ::: "memory")
> +#define rseq_smp_rmb()	rseq_smp_mb()
> +#define rseq_smp_wmb()	rseq_smp_mb()
> +#define RSEQ_ASM_TMP_REG_1	"r31"
> +#define RSEQ_ASM_TMP_REG_2	"r29"
> +#define RSEQ_ASM_TMP_REG_3	"r27"
> +#define RSEQ_ASM_TMP_REG_4	"r25"
> +
> +#define rseq_smp_load_acquire(p)					\
> +__extension__ ({							\
> +	rseq_unqual_scalar_typeof(*(p)) ____p1 = RSEQ_READ_ONCE(*(p));	\
> +	rseq_smp_mb();							\
> +	____p1;								\
> +})
> +
> +#define rseq_smp_acquire__after_ctrl_dep()	rseq_smp_rmb()
> +
> +#define rseq_smp_store_release(p, v)					\
> +do {									\
> +	rseq_smp_mb();							\
> +	RSEQ_WRITE_ONCE(*(p), v);					\
> +} while (0)
> +
> +#define __RSEQ_ASM_DEFINE_TABLE(label, version, flags, start_ip,	\
> +				post_commit_offset, abort_ip)		\
> +	".pushsection	__rseq_cs, \"aw\"\n"				\
> +	".balign	32\n"						\
> +	__rseq_str(label) ":\n"						\
> +	".long " __rseq_str(version) ", " __rseq_str(flags) "\n"	\
> +	".long 0x0, " __rseq_str(start_ip) ", "				\
> +		"0x0, " __rseq_str(post_commit_offset) ", "		\
> +		"0x0, " __rseq_str(abort_ip) "\n"			\
> +	".popsection\n\t"						\
> +	".pushsection __rseq_cs_ptr_array, \"aw\"\n"			\
> +	".long 0x0, " __rseq_str(label) "b\n"				\
> +	".popsection\n"
> +
> +#define RSEQ_ASM_DEFINE_TABLE(label, start_ip, post_commit_ip, abort_ip) \
> +	__RSEQ_ASM_DEFINE_TABLE(label, 0x0, 0x0, start_ip,		 \
> +				((post_commit_ip) - (start_ip)), abort_ip)
> +
> +/*
> + * Exit points of a rseq critical section consist of all instructions outside
> + * of the critical section where a critical section can either branch to or
> + * reach through the normal course of its execution. The abort IP and the
> + * post-commit IP are already part of the __rseq_cs section and should not be
> + * explicitly defined as additional exit points. Knowing all exit points is
> + * useful to assist debuggers stepping over the critical section.
> + */
> +#define RSEQ_ASM_DEFINE_EXIT_POINT(start_ip, exit_ip)			\
> +	".pushsection __rseq_exit_point_array, \"aw\"\n"		\
> +	".long 0x0, " __rseq_str(start_ip) ", 0x0, " __rseq_str(exit_ip) "\n"	\
> +	".popsection\n"
> +
> +#define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)		\
> +	RSEQ_INJECT_ASM(1)						\
> +	"l.movhi " RSEQ_ASM_TMP_REG_1 ", hi(" __rseq_str(cs_label) ")\n"\
> +	"l.ori   " RSEQ_ASM_TMP_REG_1 ", " RSEQ_ASM_TMP_REG_1		\
> +		", lo(" __rseq_str(cs_label) ")\n"\
> +	"l.sw  %[" __rseq_str(rseq_cs) "], " RSEQ_ASM_TMP_REG_1 "\n"	\
> +	__rseq_str(label) ":\n"
> +
> +#define RSEQ_ASM_DEFINE_ABORT(label, abort_label)			\
> +	"l.j 222f\n"							\
> +	" l.nop\n"							\
> +	".balign	4\n"						\
> +	".long "	__rseq_str(RSEQ_SIG) "\n"			\
> +	__rseq_str(label) ":\n"						\
> +	"l.j %l[" __rseq_str(abort_label) "]\n"				\
> +	" l.nop\n"							\
> +	"222:\n"
> +
> +#define RSEQ_ASM_OP_STORE(var, value)					\
> +	"l.sw %[" __rseq_str(var) "], %[" __rseq_str(value) "]\n"
> +
> +#define RSEQ_ASM_OP_CMPEQ(var, expect, label)				\
> +	"l.lwz  " RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(var) "]\n"	\
> +	"l.sfne " RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(expect) "]\n"	\
> +	"l.bf   " __rseq_str(label) "\n"				\
> +	" l.nop\n"
> +
> +#define RSEQ_ASM_OP_CMPNE(var, expect, label)				\
> +	"l.lwz  " RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(var) "]\n"	\
> +	"l.sfeq " RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(expect) "]\n"	\
> +	"l.bf   " __rseq_str(label) "\n"				\
> +	" l.nop\n"
> +
> +#define RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, label)		\
> +	RSEQ_INJECT_ASM(2)						\
> +	RSEQ_ASM_OP_CMPEQ(current_cpu_id, cpu_id, label)
> +
> +#define RSEQ_ASM_OP_R_LOAD(var)						\
> +	"l.lwz " RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(var) "]\n"
> +
> +#define RSEQ_ASM_OP_R_STORE(var)					\
> +	"l.sw %[" __rseq_str(var) "], " RSEQ_ASM_TMP_REG_1 "\n"
> +
> +#define RSEQ_ASM_OP_R_LOAD_OFF(offset)					\
> +	"l.lwz " RSEQ_ASM_TMP_REG_1 ", "				\
> +		"%[" __rseq_str(offset) "](" RSEQ_ASM_TMP_REG_1 ")\n"
> +
> +#define RSEQ_ASM_OP_R_ADD(count)					\
> +	"l.add " RSEQ_ASM_TMP_REG_1 ", " RSEQ_ASM_TMP_REG_1		\
> +		", %[" __rseq_str(count) "]\n"
> +
> +#define RSEQ_ASM_OP_FINAL_STORE(var, value, post_commit_label)		\
> +	RSEQ_ASM_OP_STORE(var, value)					\
> +	__rseq_str(post_commit_label) ":\n"
> +
> +#define RSEQ_ASM_OP_FINAL_STORE_RELEASE(var, value, post_commit_label)	\
> +	"l.msync\n"							\
> +	RSEQ_ASM_OP_STORE(var, value)					\
> +	__rseq_str(post_commit_label) ":\n"
> +
> +#define RSEQ_ASM_OP_R_FINAL_STORE(var, post_commit_label)		\
> +	"l.sw %[" __rseq_str(var) "], " RSEQ_ASM_TMP_REG_1 "\n"		\
> +	__rseq_str(post_commit_label) ":\n"
> +
> +#define RSEQ_ASM_OP_R_BAD_MEMCPY(dst, src, len)				\
> +	"l.sfeq	%[" __rseq_str(len) "], r0\n"				\
> +	"l.bf 333f\n"							\
> +	" l.nop\n"							\
> +	"l.ori  " RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(len) "], 0\n"	\
> +	"l.ori  " RSEQ_ASM_TMP_REG_2 ", %[" __rseq_str(src) "], 0\n"	\
> +	"l.ori  " RSEQ_ASM_TMP_REG_3 ", %[" __rseq_str(dst) "], 0\n"	\
> +	"222:\n"							\
> +	"l.lbz  " RSEQ_ASM_TMP_REG_4 ", 0(" RSEQ_ASM_TMP_REG_2 ")\n"	\
> +	"l.sb   0(" RSEQ_ASM_TMP_REG_3 "), " RSEQ_ASM_TMP_REG_4 "\n"	\
> +	"l.addi " RSEQ_ASM_TMP_REG_1 ", " RSEQ_ASM_TMP_REG_1 ", -1\n"	\
> +	"l.addi " RSEQ_ASM_TMP_REG_2 ", " RSEQ_ASM_TMP_REG_2 ", 1\n"	\
> +	"l.addi " RSEQ_ASM_TMP_REG_3 ", " RSEQ_ASM_TMP_REG_3 ", 1\n"	\
> +	"l.sfne " RSEQ_ASM_TMP_REG_1 ", r0\n"				\
> +	"l.bf 222b\n"							\
> +	" l.nop\n"							\
> +	"333:\n"
> +
> +#define RSEQ_ASM_OP_R_DEREF_ADDV(ptr, off, inc, post_commit_label)	\
> +	"l.ori  " RSEQ_ASM_TMP_REG_1 ", %[" __rseq_str(ptr) "], 0\n"	\
> +	RSEQ_ASM_OP_R_ADD(off)						\
> +	"l.lwz  " RSEQ_ASM_TMP_REG_1 ", 0(" RSEQ_ASM_TMP_REG_1 ")\n"	\
> +	RSEQ_ASM_OP_R_ADD(inc)						\
> +	__rseq_str(post_commit_label) ":\n"
> +
> +/* Per-cpu-id indexing. */
> +
> +#define RSEQ_TEMPLATE_CPU_ID
> +#define RSEQ_TEMPLATE_MO_RELAXED
> +#include "rseq-or1k-bits.h"
> +#undef RSEQ_TEMPLATE_MO_RELAXED
> +
> +#define RSEQ_TEMPLATE_MO_RELEASE
> +#include "rseq-or1k-bits.h"
> +#undef RSEQ_TEMPLATE_MO_RELEASE
> +#undef RSEQ_TEMPLATE_CPU_ID
> +
> +/* Per-mm-cid indexing. */
> +
> +#define RSEQ_TEMPLATE_MM_CID
> +#define RSEQ_TEMPLATE_MO_RELAXED
> +#include "rseq-or1k-bits.h"
> +#undef RSEQ_TEMPLATE_MO_RELAXED
> +
> +#define RSEQ_TEMPLATE_MO_RELEASE
> +#include "rseq-or1k-bits.h"
> +#undef RSEQ_TEMPLATE_MO_RELEASE
> +#undef RSEQ_TEMPLATE_MM_CID
> +
> +/* APIs which are not based on cpu ids. */
> +
> +#define RSEQ_TEMPLATE_CPU_ID_NONE
> +#define RSEQ_TEMPLATE_MO_RELAXED
> +#include "rseq-or1k-bits.h"
> +#undef RSEQ_TEMPLATE_MO_RELAXED
> +#undef RSEQ_TEMPLATE_CPU_ID_NONE
> diff --git a/tools/testing/selftests/rseq/rseq-thread-pointer.h b/tools/testing/selftests/rseq/rseq-thread-pointer.h
> index 977c25d758b2..3d5019307a1b 100644
> --- a/tools/testing/selftests/rseq/rseq-thread-pointer.h
> +++ b/tools/testing/selftests/rseq/rseq-thread-pointer.h
> @@ -12,6 +12,8 @@
>   #include "rseq-x86-thread-pointer.h"
>   #elif defined(__PPC__)
>   #include "rseq-ppc-thread-pointer.h"
> +#elif defined(__or1k__)
> +#include "rseq-or1k-thread-pointer.h"
>   #else
>   #include "rseq-generic-thread-pointer.h"
>   #endif
> diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
> index 4e217b620e0c..cbf114d5bb8a 100644
> --- a/tools/testing/selftests/rseq/rseq.h
> +++ b/tools/testing/selftests/rseq/rseq.h
> @@ -122,6 +122,8 @@ static inline struct rseq_abi *rseq_get_abi(void)
>   #include <rseq-s390.h>
>   #elif defined(__riscv)
>   #include <rseq-riscv.h>
> +#elif defined(__or1k__)
> +#include <rseq-or1k.h>
>   #else
>   #error unsupported target
>   #endif

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


