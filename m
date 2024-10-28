Return-Path: <linux-kselftest+bounces-20767-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EBF9B2199
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 01:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A3D8B20C83
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 00:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44585A7AA;
	Mon, 28 Oct 2024 00:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="lw52VY/q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1C14594C;
	Mon, 28 Oct 2024 00:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.247
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730076621; cv=fail; b=upRlA3iS6cjUEHj745vUQ+3IRDJqCpHoDnZddOAjojU/UkRT8jBI2KJhAJMFM7rR9IILZAedS0y1tVJBom/QcN2tmS0zw+gHVqekN3s2ZITvQU2Ce3ie2hR+zRhRUcXjpS3Yd2fvGqsvBLUYuJpW5Q9JJzRlSP7i1WjEBmvmB0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730076621; c=relaxed/simple;
	bh=9BQTbBwhfb7jvWHUsynNowP1oN4KdTVqcSkzR2ONlGk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lsqsFYyIqFnvX45nscZqTBgmlJmRcmXc7vnbR7PGN4KWbitlwm1NAcEXUoHeVs/Xb957PP4PSqV7SnabhhknMfBTZt2s0mZv+Giu6RmnLGnQYn3ooZEHdEmdIVyYW2PsMPzvdMrDQAqvDJQV1fcSg+/Svm7gxeDgTVzgcBPFgnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=lw52VY/q; arc=fail smtp.client-ip=68.232.159.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1730076619; x=1761612619;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9BQTbBwhfb7jvWHUsynNowP1oN4KdTVqcSkzR2ONlGk=;
  b=lw52VY/qP/2xAWc12KSV4XyvyXKeehrrTDBlz44milx2gjq4eeLfIYqM
   ND8ZwYL8TisNJN8/g3YO/yya+i+dO1OGtq9JcuSB/dyBOvYk6iSjI1bXQ
   aUlNmi9plWwz1pPIr2KaMb6a2bm2F6VttoQeH84ueqSnJvwuI0K+tpG5V
   TvdvHFc65t6M4x5tWVvZvyuobaAyLdnGTC+e7nTtmmOOPZE8EynS210KQ
   B4h9If70OgQAk7iXXMnkDqigPHhvTyXi8Dgko6b6bMx8f5WYD6VrCHot6
   GBrKGwNII7cj0rP5k1HDEh5Xt45f1T1ffRG1sU2MmF4qVncnf8M8Akc7l
   Q==;
X-CSE-ConnectionGUID: ZkCmz++LS3+ojCRHOQngKw==
X-CSE-MsgGUID: iTgXphITQKG2y8Z0BQPxBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="135055483"
X-IronPort-AV: E=Sophos;i="6.11,238,1725289200"; 
   d="scan'208";a="135055483"
Received: from mail-japanwestazlp17011030.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.30])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 09:50:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GuRUzhpWmfzWJkujltvyOZqKDzgF3HlwynymiF7rZOeCqwmZCLY2Dt7ZYdl0xmk+aXYyFfJlsIktc04wImiwvsVYk5dHhx34+C5SNzi2+2CZTaWEpkRwur8a98oZNPMgFgFKe1rr9lmyaOcYc1pXWjWyyhGJQ85Sdw/+2NYr3Td3AzrFWPDa9HN8Zva8t49UMym1nHjspdwuP+KGuVf5PP3uffZpXjDcqHIEouDSMerD2Ox/3pfylheeI7ruenuGzX2CydjrK7d1Fmm/yCXHxu/IiXaFpfoYYCg416lMcwA3QSj94GEuZAnBArWDUiVpLXPKH6Y1sdnZ9cOgR7efgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BQTbBwhfb7jvWHUsynNowP1oN4KdTVqcSkzR2ONlGk=;
 b=xK2WLL5zPTFhDQknkBOYOzoOMeUzByjsWz3IQ26p/q/FvEbT9PHDOec52/aRx77JTbJmt/iMdGNLDoaaL64223UfLaxV6gtGXQTBXzuGD+LWw4xTmvT+5RnQuGoo147+RhU3uJHpliDuwT1jkZznzPOE7K/bOLb+RiTaNUylI+wNRd0cuTBjc5nXRq+H2TSL/CGwruqS7Vc7LVAy7cSddXDufh9iwiFtoz6W1ltW2llg6UWN8Qa4bR6pTgKbPsI69mv7sqZirssj+3GMpKGIeuCmjLV7P49BZcvyH/51lpffNhLYWLbeJnO+ukiByAJYe1bn+soMYLUoNWUaU0iTOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYCPR01MB10762.jpnprd01.prod.outlook.com (2603:1096:400:296::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Mon, 28 Oct
 2024 00:50:03 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%7]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 00:50:03 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Shuah Khan <skhan@linuxfoundation.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
CC: "shuah@kernel.org" <shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next 1/3] selftests/watchdog: add count parameter for
 watchdog-test
Thread-Topic: [PATCH for-next 1/3] selftests/watchdog: add count parameter for
 watchdog-test
Thread-Index: AQHbJn6pWUq1FBNyBUCuyGcWUIOetrKZwW0AgAGYNoA=
Date: Mon, 28 Oct 2024 00:50:02 +0000
Message-ID: <0861d73d-4fd9-4118-91c8-5a619c7d7ca0@fujitsu.com>
References: <20241025013933.6516-1-lizhijian@fujitsu.com>
 <c2cae7a7-1a0d-48ef-9b8f-8d2436532ea7@linuxfoundation.org>
In-Reply-To: <c2cae7a7-1a0d-48ef-9b8f-8d2436532ea7@linuxfoundation.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYCPR01MB10762:EE_
x-ms-office365-filtering-correlation-id: d8654614-03f3-4504-1c8f-08dcf6ea754c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UFJ2bVVaVnd2RXE5SUV6VHd1dXBDSnpwUlZkemdlUGlwaDk2R1EzaGpmUlBW?=
 =?utf-8?B?amthMS9WSnA3bmpJV1dsck1DaEJpc1h6L3lYQkhxd2pSSDEyV01hYTdYL2w0?=
 =?utf-8?B?RW9nc1E0ZHVUczdPVGFha2RHVjNpU29vT1BvUFhZeVBXVFJDbnRlSlBGTElU?=
 =?utf-8?B?bXhsd1diQUtHWm10YUtFMG9aWlZlK1c5a3o1MU1aZUJESFl4Tm5xRkxmbUtD?=
 =?utf-8?B?VEFhMThIK2tZdUtTN2h1ajVBZzJsQVg3UVRpbDJINzhxV04zTGNmTzFVZzlv?=
 =?utf-8?B?L3EwRzV2N3p3a1dNN1EyMzBGY1FWRE9GQkJLVEdoRHpvL25qYmtTRzhvb0hI?=
 =?utf-8?B?WWlTdDdyR09Qc0NlWldVcHZkNTAxdlJMRlBmZDRDSGV3ejl5WnU1RWFmWGxY?=
 =?utf-8?B?ZGN6OUtKS1dmem1WbFZ5eW5oS1VQOWdybUVJR0U5SlBpMFo4TjNkL2ZzSEFx?=
 =?utf-8?B?M0RGNlRMVitQd2hOVzlGMFhuQmxkUlBlMXk2bHVueXZJdC9rbWZVVjVSNis1?=
 =?utf-8?B?eXpydWtRaWdTeENjU2FGbXB1bkNlQnIxM1NUNnlldzZ5WFA4L2NvUW1zUWlF?=
 =?utf-8?B?bmhDcnJBeGFKZ2U1UDZJaVFqdExEUDNVQ0YvMWprWDV5b1M4SzNaZmhSNUI3?=
 =?utf-8?B?K245cm9VeDBnVUxuR2dlM3FYYlF1NUo1UTRYRVMyUzdQY1lWSGc0cFRMdFVo?=
 =?utf-8?B?RXhPUzdZY1FRZ3lCUlhkRWpLcm83WjZvajJaUTVFdGp6U3JYV0crRHFMRmRD?=
 =?utf-8?B?SnFYVUg3L0d3ODRNbkFYaDFmdXVoakMwN3Axd2ZLaWpOcE1BS2tQS05DRzRE?=
 =?utf-8?B?Tjl6cmFmZHVCOGRyTzVGUjhrR1dnejNMZ2xyd0VHTm1hL1oxTmIvakJGZ25R?=
 =?utf-8?B?aVlac2ZJUERMTm9CS3BRa0hLaTBPTFRDb050cmJHVjNoZVJKbnpGa3JyazRl?=
 =?utf-8?B?YVB6WTEzOXpoTjN6SmVpMTNVU2dPVTVmNlBvczVDUWxScWI0RXM4RkpiV1ZS?=
 =?utf-8?B?UlRZbGJPOExHcUE2VGsrVVdYM1pyM3N1Ylo0QjJSQ2FCYmphb1RKaVFUd0lQ?=
 =?utf-8?B?VVpvRmxEdlhGRlBwOU9SamF4NFovd1BkNUYzNnEvSzVFMGlKOUNlSEFMRE9i?=
 =?utf-8?B?eHJ4SlE1U1VKcmxYOEdaWnpyb29HYTNEMDJBOVZYblM4aVZZMHhFQk9QL1VR?=
 =?utf-8?B?US90bjl4WGZXU3NRN2Q5c1p2QzY4SU8zTDJWUmdVSTk5dG8xOSttVTBLbzk5?=
 =?utf-8?B?WkdIdXVxNGx5S3VXcmN1WFE0dVNlVGhCM0Y4MW4yQitocmVpaXFXL244WFFu?=
 =?utf-8?B?MjRJK2VYZFk4cGpCWWNwdGYyQ21WZVpDU0hXRS9mSFFuLzluaEFzSlNvQTF4?=
 =?utf-8?B?VjZFMC85RTkxRXE5cWZhMFQ3Rm12MHVkbGlXSkJRNVJuVFR3RldxLzNQL1hH?=
 =?utf-8?B?UWJVVHgydnhlVGs3NUt5S2FEcWlFNlJqeVRIVU1NTGs0K3RMQVBPL1NKd1I2?=
 =?utf-8?B?RnNSVG1Hdy9ZNXA3YTE2VkxDZEUrZGxHdWd5WHRmYU4rWTh0RlYwdGV6Ritz?=
 =?utf-8?B?L25rVksrcGNTQVlXZENsdENjMFVmVUJrUTRNVjJWRW5rcVIzU0k1QkV3Ly9v?=
 =?utf-8?B?dFRpN0dEbmJlb01FNFFFM0lUeTZKWllpNmNaanBqTGRrL1hEUy9CdDByTEdL?=
 =?utf-8?B?YzBGWXJoRjBVUGlkbmNLS2ZUdXU4TG91YldwZFdLNENDM0RZT2tiSmJhVE56?=
 =?utf-8?B?TndwZXQ5bXNYOWdDY3dxRjZXRUxzdnBlK2xidTJIcjN2TmtwNEF3S21zSTZL?=
 =?utf-8?B?UTZGbm9zZXNVZ3VnaUxZSXV1Wmhjd3ZLVXZrdDlCbHROWUNLeW1HQm5sa2lS?=
 =?utf-8?B?eEtJTzQ2QmVmTmlHT1lIeVR4RVIrNFFWZHVHWDd1ckVVT0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dkVNemUxYUxheHJ5bzF0M0QyblM1UVFZTkRBay9aaE9oVXpPSHJqSFZkSnVB?=
 =?utf-8?B?R3B2N09TRlJVT3ZGcGhDL3VPNzNVbzRjcmZUb3dGbEJqV3NudG5xUWI5NWZQ?=
 =?utf-8?B?RkNBbEZTc2ZRdDAzRkQyWnhYMHB6OVB4WkFUTGk2OFM5SmtMUEZ0RG9XdzBZ?=
 =?utf-8?B?UlNUbVVjb3BwOXZxZ05GK2h6VjhGSGtzckZndjFWNkdqOTFiaWFJaFlweE1p?=
 =?utf-8?B?VkRvVUkyREZHUFRUVGd0Nlc4RmZDM0t1QzJWaFNyZGZkcHlBaW5aUHl4T0ty?=
 =?utf-8?B?ay9ERktCK0tTOEN6R3hMT0prM1d6aldKZGx1YVZDcTdQWkowUnRXRmR0cUFn?=
 =?utf-8?B?WlF5QUNJUW01MXA5dWN3cWRGeUNLYkNjei9iOEFiemtkRGlsbHFSc2IwTEs0?=
 =?utf-8?B?OU9oQlRwVlYrdlNtalZRV2xwYzFkWEdiT01VTjVQcUJ2SHBHaFRLU1NZREVQ?=
 =?utf-8?B?ajVWdVc1MkVycGN0dWxvRk9aRVZHWi9vNXBmdkRUUGZua2N5aEdGVTVhQkgz?=
 =?utf-8?B?S0ZtSmVxOTl0WjJ3TjdKZldDd0k4azFMSWp5aTNGWHB3NUxyTG9mc2FKa1R4?=
 =?utf-8?B?Q2F4RDVOUTJDVHZ6U2ZZTkdPRGVIckd2bXJLaHY0K29ROXhNbFZreUFxaUd0?=
 =?utf-8?B?WWhWZkRvQkNQZ2xrWklKaXpVR0J1YXVySmZNNVZFYWtMbVkzTlRPa2N6V0tK?=
 =?utf-8?B?M3JsMnpYbmhOL3U1SzJoc3E0dUM1THpMS3pNcEIxbmtTQnhpMlNwNk95MWtE?=
 =?utf-8?B?aWdpT3JNaWdVVzVxUDVRaVFvM3ZqdnQ1ZDQ4VWt4Y1liM2JmbkhuVWkzTVpF?=
 =?utf-8?B?dGorR0VLSHRJeTN3MlQvWGNoRkVIdHNhby8xazNQR205dTZZYXJVK2l4TVRM?=
 =?utf-8?B?L1J4VGRPZ1p1YkVxK2ZONTdMNVJOVERIZnVzckxiOWdSMHJUT1NoNnRGQ3Z5?=
 =?utf-8?B?bnpiTXE2bDlibmlyaUJQMUllK1JYRFlWL0xWbkUyNzcrM2hsT2pUcDBDdjVN?=
 =?utf-8?B?N05obzFiMy9pYnVMYnBQdGtkaUE5bnZEendRelE1QnczZitLZy9la3ljcjEw?=
 =?utf-8?B?OEVrUHk0MTh6NTRBZTJjMFFEVE9McGFJSkJZTDNmV3Q1SHUxdEpiNGJaY1ow?=
 =?utf-8?B?MkpqemhBYW51NHZGVkw1R1hMb0t0elZDY0F4eGlJbVZsRVNuVmpZUkNlTCt1?=
 =?utf-8?B?T3Q1VVlJcFU1TW92QmtwYUQ1aUNvZXhCZjlVeVA3UTJzenVaSy9lRDlKUThp?=
 =?utf-8?B?RDFmV1hhRHhWUll2bnZmWWdaQVpSTjFJL0E5OVRtS3BqNUlsbDh5MXdnOGE0?=
 =?utf-8?B?Sm5TQUVuZktuN0F2NHorcXN5b1hHRndqL1ZMT2FHWGM1amJWTkFxdmlMWEdD?=
 =?utf-8?B?bjRycWtJOU1zWmw3dFZzTTZEOTlPcjNBOVlpVE9CTFZZLzJxU01yejB1L1RZ?=
 =?utf-8?B?c2hZbHllMGoxTFNWZXcvTG55N3pJZDlxSVNaV2NCMFhsejNUTTRYeWhxZ2l5?=
 =?utf-8?B?TjNFUjgrRW9XWE1ESkNwNGI5dzBJVkRqMHhDRUpzWHEybnlJc0Ixcm44TzhL?=
 =?utf-8?B?c2lWVU9pYU1BUU4yZjZZbHR4akRFUEltTTI1ZElvSHlyU0JhcUpSMWc5US85?=
 =?utf-8?B?cUxSM1A4cG1zK3o3THlDV25FZ1paTnBVU1JKWVhqVXUxdiswejMwc3VlQXNi?=
 =?utf-8?B?ZUllRTJUWFI0N2tIdFhDTFlPZHRyUlJZVzk0bXNjVWhMNjJtTjhoL3V0WVpU?=
 =?utf-8?B?VW1ocEo4OGk0MWplT0ZWdWNVOTJ6d1p4MHduaUM0d2xmR08vYmZXKzBWWFpq?=
 =?utf-8?B?emMzT3ZqNkNPUVFUTVljRSt0cWYveVc3Y2I1eEF5bFhvQjNmeTYzT3dwSnA2?=
 =?utf-8?B?bjZXUzRwTXJVci8wRjdrYmRreUZ1V2Z6MzRUQmZjNzJwMFR0dFZzM21QTUg4?=
 =?utf-8?B?ZmxjWExYMTVnd1hjY3ArbnI2WGV0dVNUWGpjK3UvdDZOWE5DRjJUYm5NRnVw?=
 =?utf-8?B?cXlrZURCUEliZXhnSUtFZTIyZjJlOWtONkhGR0hIUGpBMkY1WnZQVSsvcm43?=
 =?utf-8?B?UVdRRk5keUM1ZnpPU0gxVHRaY3BxUUFRYjd0M085Y2NJd1NxYjg4eFZnaDhI?=
 =?utf-8?B?eXpIVHNaYWJvV2s4a2IyZUNEbThMUlZYcGpKSTc0Wk02Vy9GL1ZDeDlKM2Vm?=
 =?utf-8?B?TFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF3EE0A0FE3E3446936085411ABA425B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TBw8PNBPc3Ug21DvDTQZ1CF8AMFqem8xrfTvdjrXMGSb+3faYMoCV8Qt8cwyKxf3062RJHYvD3zyHecXpSbCSHO3A0Xz9oPwthl+GOB1nGb9OjyTAwHqyMJWF+IUCnltyqzhETdCJgd0apIEJTzPTTUeky0ReXdV+nxHtfr7ZogzT+20r9j/l99489ZOT3Ajf9zL8ujZiYtCsJZDe7uiGrOvgzECkmm0OfUy+Rog0ycUHsGGYH9yNxiyWO6h1XoSWEGvwt6gr3prdAOC6o+fYUQ0sZoKQD3RBDfZ1OBf01a3LpcVD1FPvnQ6vMnBJgAkDLhnZySpeWjJqW6RlXHO8UuqEbFA5UScCGp1NarzPh5/KEOiOg3e9OFgo1sq5H7UaSoc/KjxB/7hFw9HY4Sl7LRsm5TLLue0Wc+LFPByO6ZPyzNthBLhdUh+DN7Q3ZJ5pTBuaiAh0413Pme+czelfxwsN4VcLe4BoLn0KPET0gNr/0CUllZeZFm23ABUmFWk4Xl4eQNS3kn9sbr1MvKAeAO4C8vXAg5FefzBRtWTdb92rATahY3UHu/m4DdKeNUGWxuPh3JrvuSol1sDQugFFOKu4GbTHrKMlSbuzFecdK2n48Jg3QxJSG+y1tmx+Mck
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8654614-03f3-4504-1c8f-08dcf6ea754c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 00:50:03.0324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y8A7raP/zBszLOMfFiDliZ7s0tRUB9ez3FvtwJxhiSyeRBTSYnAdGtw7hG/CyUZBj0IfOsHLH9Ne4mrxg2PX8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10762

DQoNCk9uIDI3LzEwLzIwMjQgMDg6MjgsIFNodWFoIEtoYW4gd3JvdGU6DQo+IE9uwqAxMC8yNC8y
NMKgMTk6MzkswqBMacKgWmhpamlhbsKgd3JvdGU6DQo+PiBDdXJyZW50bHkswqB3YXRjaGRvZy10
ZXN0wqBrZWVwwqBydW5uaW5nwqB1bnRpbMKgaXTCoGdldHPCoGHCoFNJR0lOVC7CoEhvd2V2ZXIs
DQo+PiB3aGVuwqB3YXRjaGRvZy10ZXN0wqBpc8KgZXhlY3V0ZWTCoGZyb23CoHRoZcKga3NlbGZ0
ZXN0c8KgZnJhbWV3b3JrLMKgd2hlcmXCoGl0DQo+PiBsYXVuY2hlc8KgdGVzdMKgdmlhwqB0aW1l
b3V0wqB3aGljaMKgd2lsbMKgc2VuZMKgU0lHVEVSTcKgaW7CoHRpbWXCoHVwLsKgVGhpc8KgY291
bGQNCj4+IGxlYWTCoHRvDQo+PiAxLsKgd2F0Y2hkb2fCoGhhdmVuJ3TCoHN0b3AswqBhwqB3YXRj
aGRvZ8KgcmVzZXTCoGlzwqB0cmlnZ2VyZWTCoHRvwqByZWJvb3TCoHRoZcKgT1MNCj4+IMKgwqDC
oMKgaW7CoHNpbGVudC4NCj4+IDIuwqBrc2VsZnRlc3RzwqBnZXRzwqBhbsKgdGltZW91dMKgZXhp
dMKgY29kZSzCoGFuZMKganVkZ2XCoHdhdGNoZG9nLXRlc3TCoGFzDQo+PiDCoMKgwqAnbm90wqBv
aycNCj4+DQo+IFRoaXPCoHRlc3TCoGlzbid0wqByZWFsbHnCoHN1cHBvc2VkwqB0b8KgYmXCoHJ1
bsKgZnJvbcKga3NlbGZ0ZXN0wqBmcmFtZXdvcmsuDQo+IFRoaXPCoGlzwqB0aGXCoHJlYXNvbsKg
d2h5wqBpdMKgaXNuJ3TCoGluY2x1ZGVkwqBpbsKgdGhlwqBkZWZhdWx0wqBydW4uDQoNCk1heSBJ
IGtub3cgd2hhdCdzIHRoZSBkZWZhdWx0IHJ1biwgaXMgaXQgZGlmZmVyZW50IGZyb20gYG1ha2Ug
cnVuX3Rlc3RzYCA/DQoNCg0KPiANCj4+IFRoaXPCoHBhdGNowqBpc8KgcHJlcGFyZcKgdG/CoGZp
eMKgYWJvdmXCoDLCoGlzc3Vlcw0KPiANCj4gVGhpc8Kgc2VyaWVzwqBuZWVkc8KgYcKgc2VwYXJh
dGXCoGNvdmVywqBsZXR0ZXLCoGV4cGxhaW5pbmfCoGhvd8KgdGhpc8KgcHJvYmxlbcKgaXMNCj4g
YmVpbmfCoGZpeGVkLg0KDQpDb3ZlciBsZXR0ZXIgaXMgaW4gdGhpcyBwYXRjaCwgc2VlIGJlbG93
Og0KSW4gYWRkaXRpb24sIHdlIGNhbiBnZXQgdGhlICdIb3cnIGJ5IHJlYWRpbmcgdGhlIHNpbXBs
ZSBjaGFuZ2UgaW4gZWFjaCBjaGFuZ2UuDQoNCg0KPiANCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OsKg
TGnCoFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCj4+IC0tLQ0KPj4gSGV5LA0KPj4g
Q292ZXLCoGxldHRlcsKgaXPCoGhlcmUuDQo+Pg0KPj4gSXQnc8Kgbm90aWNlwqB0aGF0wqBhwqBP
U8KgcmVib290wqB3YXPCoHRyaWdnZXJyZWTCoGFmdGVywqByYW7CoHRoZcKgd2F0Y2hkb2ctdGVz
dA0KPj4gaW7CoGtzZWxmdGVzdHPCoGZyYW13b3JrwqAnbWFrZcKgcnVuX3Rlc3RzJyzCoHRoYXQn
c8KgYmVjYXVzZcKgd2F0Y2hkb2ctdGVzdA0KPj4gZGlkbid0wqBzdG9wwqBmZWVkaW5nwqB0aGXC
oHdhdGNoZG9nwqBhZnRlcsKgZW5hYmxlwqBpdC4NCj4+DQo+PiBJbsKgYWRkaXRpb24swqBjdXJy
ZW50wqB3YXRjaGRvZy10ZXN0wqBkaWRuJ3TCoGFkYXB0wqB0b8KgdGhlwqBrc2VsZnRlc3RzDQo+
PiBmcmFtZXdvcmvCoHdoaWNowqBsYXVuY2hzwqB0aGXCoHRlc3TCoHdpdGjCoC91c3IvYmluL3Rp
bWVvdXTCoGFuZMKgbm/CoHRpbWVvdXQNCj4+IGlzwqBleHBlY3RlZC4NCj4+IC0tLSA=

