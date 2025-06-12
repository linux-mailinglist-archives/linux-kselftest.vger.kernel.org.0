Return-Path: <linux-kselftest+bounces-34787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0655AD66B8
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 06:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB58A1BC1B7C
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 04:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1861A1DF751;
	Thu, 12 Jun 2025 04:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="NnimW7P1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0841EF38E;
	Thu, 12 Jun 2025 04:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749702068; cv=fail; b=q30NKBiTfb2TwKRHD8365bTbvukTPNXOj55Gaxmig5zzlFpAbzVujk7VHbBASxZJTN2GJ5xhHb7s0zf095aT7iXhiX02gldFO5y8rBYZZF8IZ0/4y2I/RyCXMAZGJmk21ElYhwm6gjVci742KspFqNN2jk8qZJUyXLauKvNekgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749702068; c=relaxed/simple;
	bh=99xV20JvaYluhIOUrWSoCRUSC/qJKpGeEGzSmeaslL4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=e8SbpHlffJYh505kBZgXoN3dVZP1nrB8DPCfY5dLHy2yLmgtt4k4CpjvcDMIHKG18SxdB2kws5ExfWJlDohk1iH/IiMIqkN/jFMbF1H9fcU8MCTRCeeLWp/323EorzLji6yiCOjz9oIRVvNvxUj/TJHwaL04XjuwfoTmCr9bBdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=NnimW7P1; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BMUQdR016787;
	Thu, 12 Jun 2025 04:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=wcZAdo7
	8I9gx2Ns8AejpYydAkfBsjN7WXOU27hYek8Y=; b=NnimW7P14EOexe5gFBYi5Vf
	TbGV9oA6inakBD9i6pprzsgM87Vrg35t6M+R+/i9xo/IY8zq68fr+YhaK7gXbYw2
	+TlU7HK+CwtKeKo1jQZKiTckBekvEm4qCd2fWrpjwFaL8T7khhjCMQBME+HglsKV
	DhgNhDzz0P/km0WUgbtgU+yMWf3/etrC8SIJ15aB7lVWoGzcEj1Sjw4+scjutCPs
	kZ1zzRu9T7Zx4DLRUj5syrFOl29Z99lwq8FKKK1vDGpTIMM41Q70FsBdvHrJwTuC
	jiT6jhRv3fYO7mVzQaPGDYzs+Y/9XBXSUrn1gcposQ3Ay0i34orc9TbKh6oOulg=
	=
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 474dttux0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 04:20:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bv6evvjKmS7CXIfIzeciM5t9EnyD66iCgTTF8hhzuxJN9OhKHYIUOzYjwud34CbleHwaJQTpJc9CmKsq/Ir6gGoDsVLkzTo/QZekge8+fYxzW19lmxtNNt9QSVj+I75bbwp0GDy7NhvqRyMVdk5w8W6Gl4DQpXigplFkegq0lxOnP8yKI2p5S80p9Vr/CNHdgqz5nfn2AMoYppLjc3RNqvsAFtImFRh8NRe/QMFO1i7W03Q3zxXR7jpDKY9bzChHZGtldvcU8cfMGvY7ObcyE+l8N1HMo+OmqwKZ3hxHlHjYwDZO32r8Lwvqn81ifIhqLbHNzWOOZPAKCs4zVTR4FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6SSkEBOSc8jWMjZaIKghwoAqgKBXltc8YFqWabx2j8=;
 b=ErU6QVChgKuv+E4oqpj1zOXgmoRcWEhpRUms9RI7PctFBCLbdTvkDf1Rrrcwi7OKhYyT840e7w9ZvA0Klp1u2Ml1in+gG6qN3e8vsn4q3/h9KG3iNFH93Cup9S1dPd0mH3rYLcDgJlZeO0buw3lLYl8PwD2JDM67oCrvFBG1+cA5yHZMnbyBttr9OORhIgzwktEunOszH7gwAzisp9VeqsoeHe9CXYPYZOSgnPnEK6GoCpZ0b9eX346ubvJqASj+kbWcQADGx25XgI3L/QNx3o+ibpfo0EOgkHqseD/dEyprlaenOrhiqTEa3VVmLmYBxJfO9XPfXr2yJMSuGJ8aUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from MW5PR13MB5632.namprd13.prod.outlook.com (2603:10b6:303:197::16)
 by IA2PR13MB6632.namprd13.prod.outlook.com (2603:10b6:208:4b9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Thu, 12 Jun
 2025 04:20:19 +0000
Received: from MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197]) by MW5PR13MB5632.namprd13.prod.outlook.com
 ([fe80::df7c:a5b9:aa3e:9197%5]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 04:20:19 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>,
        "david@redhat.com" <david@redhat.com>
CC: "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
        "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
        "npache@redhat.com"
	<npache@redhat.com>,
        "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
        "dev.jain@arm.com" <dev.jain@arm.com>,
        "baohua@kernel.org"
	<baohua@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "ziy@nvidia.com"
	<ziy@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] selftests: mm: add shmem collpase as a default test
 item
Thread-Topic: [PATCH 2/2] selftests: mm: add shmem collpase as a default test
 item
Thread-Index: AQHb203Ks5i0+nPBjESSBCrtye6MErP+67VQ
Date: Thu, 12 Jun 2025 04:20:19 +0000
Message-ID:
 <MW5PR13MB563297B61566E15E59B02330FD74A@MW5PR13MB5632.namprd13.prod.outlook.com>
References:
 <c16d1d452aa876b449324d12df6465677158a711.1749697399.git.baolin.wang@linux.alibaba.com>
 <1352b17c513364164f6231ac32283cbb7093b603.1749697399.git.baolin.wang@linux.alibaba.com>
In-Reply-To:
 <1352b17c513364164f6231ac32283cbb7093b603.1749697399.git.baolin.wang@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR13MB5632:EE_|IA2PR13MB6632:EE_
x-ms-office365-filtering-correlation-id: d9aeb909-690c-4b82-b35c-08dda96870fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c0RJbHVhTFlnUjB2WDJHTGR4UTd4MWNnaDdUWVJiVXBENnk5OTZEWFFmcTRh?=
 =?utf-8?B?b3BJczlHVDR6RzhmZ0RwdFkvVTJGMjdXaDF3NU5jMnRJdDc1dnZSM2JYUHl1?=
 =?utf-8?B?R0tKL1Z2aWRLOXNMR284VkUyMHpLUGdPYkZZenptVkVlaGVSVFZQSjRIRFRu?=
 =?utf-8?B?VXVJU3UyTlVsOUZXdzlhVmNtYVJYbFhOVFFJYUF4TFJ5UDVxRUtzdkpwL3Vp?=
 =?utf-8?B?NnRYYjkrVVRJSDlNayswZFhQaGoxTFJOeDd2QkIrdHNwd0lXTExtQW5EdGtt?=
 =?utf-8?B?QmQ2UjZsMUtyWE5WVFJRVTZNU3VpS3ZPWEt5TVhwcXF0MWUvWFByejdtNUlz?=
 =?utf-8?B?OVNHU3VJMTVZUzBBK3JBbUdsVFJyNHN5MlFBdnh3cW9SUFkyNnhBVUh5QTFO?=
 =?utf-8?B?MFN1ajVyVzZ1WFd0Z1pKaEE1Q0w1RmpVU0lFTjIwSnA3WGR1NTlmYU15NUVG?=
 =?utf-8?B?MkxrbW9sT1p0b08zZndLTi9qR0JtOUh2UklQOTNCS1RRMFZOSjJSME03T01U?=
 =?utf-8?B?WlRXNTRLbkhEdlZqOUExL3RrNVF1VzBnS3ViRkxobnB5WlVQUm9qZU9xLzRS?=
 =?utf-8?B?V3dzWTNsQWlBNURxaDQzZms0RWozQzV2a1k2eUZKSS9IR05sRjB3REUyVXp3?=
 =?utf-8?B?aU4wbU5ubUN3V2VweWFMYnJTSDZyNjlQQTljTXpnUkIvQTE5ZmFldHhSVjRR?=
 =?utf-8?B?cytLckw2eVJKU1pXMldFVlBwNDBWc0lxRTl2R09UYWFNemU1QXpBSzY4SGJw?=
 =?utf-8?B?T0F2eGFQQ2NFQkJhamNSRFBEQzhmY1kwK2RCdDJlckpvbm9Ocmh0dElLendE?=
 =?utf-8?B?R3pGam9YQklsRTAxT1JwTmZrQ0MwU1YrQWZTYi9qbzJHempaTWl4bmVqUUhi?=
 =?utf-8?B?emVzVWdSUkRDSzBMd2dzWnhDb0RRdlpCRk85UVdiTHQyS0R3dGJHQjEwQUhP?=
 =?utf-8?B?QUdVVDdBRUZKcUk3SUFzT0I1YVA5VldjdDZ1YTFhTlpvQktvdXdRZjJXcVR0?=
 =?utf-8?B?b3ZMZkRDMWd4RzFYKy92YlRUQ3dBUE8xRkg3RWkvem95cS9jRjJIY3c0aXBh?=
 =?utf-8?B?alFtM3FnL1kxeVZDSmo0NUpxRjloeGR0dVFZOFFyNGM3a0V5UnlsWll4NEYv?=
 =?utf-8?B?QkJSU01oUXgyZnJxcDlqQjZRVFB1U0poUmpWaWJHcjIrdXVxYVRWdjlTNHFN?=
 =?utf-8?B?eUl4TytjY25HT3FQT2plUDIrOUwrNmR2OWJyQmRuOHNkTTFnZHpYWXMzSkc2?=
 =?utf-8?B?d01SazRFMTdtU1MzaVlkbzNFaERrSVFSZkpySzVqK0N6ZWh1NEt1aTQ1eFZL?=
 =?utf-8?B?TFVnKzhMRWZCUTZpa0VKZ3k0STdrbVI5eDRQWmkvT0QxcTEwVlJWTS9RbVJP?=
 =?utf-8?B?YkVCeXRqRm1ROC9BL2dXOWJUT1hxd2RGMFl1dmNrcjIveTBlbXdybk1JMkow?=
 =?utf-8?B?aWlyYjBJTlhrNFhLRytmUXRUK2hMWlNyRktMRC9UWUxwWU1IaFlWYkJIT2F1?=
 =?utf-8?B?QkszVW1iTHl5Qlc5ekNISEtldXFoM3V5SUZyN2ZFaEd4Y2FFazJ0dll1S2w4?=
 =?utf-8?B?VHFIM0pVUFFQQ2Mzc3ppTG13K09WUGpSdUlwZ09WMEQ5eWRvUzJhWVpYc2tm?=
 =?utf-8?B?QkJySzRybkdXNmxFOEZDZ3o3Z2NXN3hFZUFTK2hZckpXL2JkVFR1M3cyYURC?=
 =?utf-8?B?SkQ2QVRNamxRYjFlajdsUzNTTnNoem51aFl1QTExQWtZRjlndGdqeFk2RXl4?=
 =?utf-8?B?YWpRTlp5MHZ5cHYxL2xnQy9vbWM1T3JNNzA0cjY4NG04TEdHS0pyU0NLMWl4?=
 =?utf-8?B?U3hId1dBTGpwTTBOV0c1enlKOW5wdHNhVjc4elE4ZVk0Qy9McTFmVENDS2dj?=
 =?utf-8?B?WDErVkNSanhFeEZLZkxFeFlUbXZJVk5xSUtaMWlpMk9BSW5jdStwZVlWdmhK?=
 =?utf-8?B?TjI4STd0RkNRVUFmNnM3TkxzUW13UExZelpseTNCQWhEU0YzQ3p1ODNOaTJk?=
 =?utf-8?Q?5J4EvjgYg+W7qRc1A+NrQ2/CpTVkSk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR13MB5632.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U2RGdnNjWTNoYlowVDB2eHcxTDZLZStEQytYQmpXQVo3bDlOUVMzcm01Q3NF?=
 =?utf-8?B?dDQ1MHZQVkdXOThBNDBEeXYxeTJjV2ZIUUFTNHo0bTRCZW5uazdiY3M4THNu?=
 =?utf-8?B?VmNscWRvQXl4WlViUkhuOVBBVkQvVEdaeVV6eGxzSWY0T0NVeVFKdFhjWHYw?=
 =?utf-8?B?Qk8zclJydDlRWG9wQmdNMlo5bWQ4WjNvNHU2cFk3YWo2ckRTdXNWU3lKQkor?=
 =?utf-8?B?YldGSjVLVFhITnJ5ZTZEYjRlYnNtUjBvVjVBRkUrVFFLeFF3eWEraEJkQzBV?=
 =?utf-8?B?dTFGTmlKWUpjRnlsVTY1VXE2Ung5SzZOUnNkOE1uNVliSXNNV21Jblc2cWl3?=
 =?utf-8?B?aThQMERTZkpvK0VPK0F6bFVVS2lsSWI2UzNZcnVoL2ZBcUJRWEIzSnhjcXFF?=
 =?utf-8?B?TGNZSHBFVDhzNGtpa2pnbU83MUFuYVN3YmhhL29Oa1FaY04yUm56TE93RlJI?=
 =?utf-8?B?QnliNHB3RWgvaVFEbjJ0UWxKcjNVRktMWEZIOGoxd2tPMWlleU4zSHc2Y1Ux?=
 =?utf-8?B?TzJDbE9IbksrbDlOL0pJK1BqTVkyMFBJMWRTSE16ajRFMWZxeHhUcHg0dS9N?=
 =?utf-8?B?L3hFdFM2dTRlUWdXQ3BEY2V1MUpNQ0dTR3JYNWd2VStRTnpycnJQTEZ0dENJ?=
 =?utf-8?B?YVlyUWREQTZDeVp5SHdMQkQrSDFDWXMxeGpsT2FkS0RqdU1lODlzdm8zVzdn?=
 =?utf-8?B?dWc1NU0rdko1c3k0ZHpqM3Z0VXNwQ0RZcjZwUlN4OWpOVTFPbHNUT0FpY1VF?=
 =?utf-8?B?T0o2c1VPMHd3dDlXc010ZnpDUnpMQjAraFJxa09IdysydDJvek1mS2krWEh0?=
 =?utf-8?B?WUY4YktkSFJSUm9sZzVDTkVkMzZyRXE3MGgzclE2R2UwbTBFWVdBMlRGYTBx?=
 =?utf-8?B?UkNIWTd0akdhams5ZDFpWkFQNk5LUC81a0RlYWN2Z3pRazhTVVcwR0wxcG82?=
 =?utf-8?B?WjdSQ0FCNkp4cWNINEthUzJ1dEtOY3ZWdFQ1NDNISDRlMTk0ajRBZ3dhdUdR?=
 =?utf-8?B?bTFld0xNVDBzV29tY1RzdGN2M2I2TVk0OHRuY2tGWVF1cU52ZWhjR0FvOTBW?=
 =?utf-8?B?MWJSRy9kOU9hMlJrbXBLa2dNZHNFV01DR3gyYnZEdEtpZmE5eHIrTnVNU3Q0?=
 =?utf-8?B?N2M2NnAzaFlVTk01TjV3YVp1VmU0T1VhZjRBcWlyQjI0a1hwRDZITzVsRGtj?=
 =?utf-8?B?OVVkdm5KY1hiRDFIc2NBQkQrWklvV3FQSXBUQjR5cVJSYWFpWnFudjNlZGhX?=
 =?utf-8?B?TmRuWlU1UTduY0VqUS9SVWozV1IzRU4ydW5ja2M1cTMvazV2NndveEM5TzQz?=
 =?utf-8?B?d2FPOS9KZjJyQW5pTVdRbUl4aFp4SHoxU3B4TEZhU21pdy9DVE9oanFOdVZK?=
 =?utf-8?B?WEdLbnZQS1FzVWw3RDIyeGV3T1Q4MGlUV2t1ZEFjOE16MWk3R0xxWklVZ3Ix?=
 =?utf-8?B?ZTRmQjltblUxbzhIVm41c1JhQ0Y0MWZ5S0piZVZJbmRaQkx6bTVIZDVqbHBB?=
 =?utf-8?B?REx0VEo2RWFENk5HbmUrUU10SVJjcEVXaExEN3Nwa3RZcWN2MlhTYUYzZ0ZT?=
 =?utf-8?B?K2pVLzhhM25OVnByVGtkRVMwcnBrWW5rMEZUVG1FSnZyMXVWS0FxOE9hc3BC?=
 =?utf-8?B?NFRqazZZUVRrZ3FxUWtUQU8zZHdHd09NYWxJNWM0dEJVdm1qMkx6b0Q3OGVu?=
 =?utf-8?B?ZDUwbGJJWTJ3djIzSlNJaUs3azBJM0NDQUx4QlIrdWhtZ0FBK1dTcGdpeUJP?=
 =?utf-8?B?SVE2RFJXRDRIQ05xMXpUR2x0N05EcGxjcXhjT2NhMGJrUEVLdS8rT3RwdHM4?=
 =?utf-8?B?RFVlRDZscWVUeDBCMmVqNit3cy82aG5kQkVkdXBDZUxLQ3VwWlU0MG41VDkw?=
 =?utf-8?B?UVUyVzBLUjdmaFhCME5sdnV6L1Z5WnVjN05qOGl1RjZBV3dEVlZoQnN0ZWYx?=
 =?utf-8?B?TjJVWkZ2bWJ0Y2ZHZEpGRzlQVXRhZDRWVTM4MVFKNktJTS9PelRsSWV2VDdI?=
 =?utf-8?B?bkFaQStMajJhQlpzWGc0d3pjbkVBSExrVW9JcXBXNmFHenF5cnJxRzZaL1Aw?=
 =?utf-8?B?amdxZUZxTHd6RC9URFoxd0tESVZYaGNSTnk3dDZMcmxVUFo3Z2V2VEV2akZO?=
 =?utf-8?Q?ic1M=3D?=
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mLv99P9WSuSDFYzsUa9teVdk2bCGqHi5pk3plZNVy3n1PASTQ0a0ouKhLeLsi9CRjjmw9dId0t4OubaS4FmDkzLti3RoiIeeoUroVbBLIjJV8uFL6sa6EspK+1G28Lc4ahqkMIXvu00NAMvu09vqg0ORrpBmuyNwIN8QcIToNoX2hY/eEgw0+IQPIS40NR+wJ0Lr3XIs1qEtfFs9ArHkrDXAYlTIyc7D63bLU8/vNc3hFmQ6fOt2x9RfNqQG2h9F4EP8OiI51BrOoMYqQyWZpKtPf1WKG+tQKkPnWboEP7GGMrL3yGq3xJUnlYcJx+Ssz4l/Ryex8A6BkpU3AeT0izkOiyRL0J027ydrTLS0sKCW/wCqUIJ7CTr4UGcUdvQajB9dfixhp4M4X5MtFnXrrTNsJyuXfLuu3olCWKGcYt47qTmOE2Czp+/lk6hANtczBRCHiIN/3kck3VmQWXJBtNodMvCbHn6L8/EMt0k4p4c6P8i6F/nq7MNE3RCqT2199nHaVtAe9L6ssMADaV5GPcNtP28pgP7kM1x7sdqzcIWcTWUaJ52D40EZB5JubN+il8Coo9v9a+agfHnMFtkmrzwwFfq/tw+dudNj7vdM5YsCPmnuLdFRBP/GqNVuyPCB
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR13MB5632.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9aeb909-690c-4b82-b35c-08dda96870fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 04:20:19.3475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uFhpGSfPJXttsrQt4avKUzaDxkjRqhluv9Qj7gmiXZu5RrQuKIx5gBm8Y40WcYqH3dc1lL6NHNsh8lgwW6w0vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR13MB6632
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: -y3Bb4DPPA15JiDHcBzDkfyX2Fmf2Zd2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDAzMSBTYWx0ZWRfX9+GRNNFdKs4c sSh0Y8TlX+PTboVxGDNzmE+IJvrLOdp+MGoQ6Pjx3u+CcT4lXm+NKvSriXU9WkfEYo8tNOtNewR vf07cMqGq29vyf3XLrZcPnif0rrADb9gUuoucJvAC+zv23GqngoO5W9LWxIatxj9H4X92oBJ8/p
 cKNcc4EPh9jOqSHF+XuBB2fwLsd+4dkb6t/gz4lU9c5SRVj8jvy+li90OKc22v1FBjVC5xUDjHR QOvwX/rw2n9vW5p9a2Mv1YwXMYFSG/lzYbCUSKgBiz+s+jOeK5DBE5/uVSSTPpjdU4FpTEqju/8 eNuE/MeHXIIqp6mUadoNHBXxObUDqIYGECb6CHO5+XVMBjmM44pRm+qEuuVyU/Nt98OS8JqPEi3
 I1Xn1YFbC3XWIIYox/lN45u9FJgvu3IozYaldtu8xNuJlsxQv2bZWxznZERotBJbJ4EBwgMH
X-Authority-Analysis: v=2.4 cv=KaPSsRYD c=1 sm=1 tr=0 ts=684a5589 cx=c_pps a=kCcHEhArWiBOTpcczqSLvA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=xR56lInIT_wA:10 a=SRrdq9N9AAAA:8 a=Hiey9j-r7o24BsEoXjQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -y3Bb4DPPA15JiDHcBzDkfyX2Fmf2Zd2
X-Sony-Outbound-GUID: -y3Bb4DPPA15JiDHcBzDkfyX2Fmf2Zd2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_02,2025-06-10_01,2025-03-28_01

collpase in the subject line should be collapse
 -- Tim

> -----Original Message-----
> From: Baolin Wang <baolin.wang@linux.alibaba.com>
> Subject: [PATCH 2/2] selftests: mm: add shmem collpase as a default test =
item
>=20
> Currently, we only test anonymous memory collapse by default. We should a=
lso add shmem collapse as a default test item to catch issues that
> could break the test cases. Signed-off-by: Baolin Wang <baolin.=E2=80=8Aw=
ang@=E2=80=8Alinux.=E2=80=8Aalibaba.=E2=80=8Acom> --- tools/testing/selftes=
ts/mm/run_vmtests.=E2=80=8Ash
>=20
> Currently, we only test anonymous memory collapse by default. We should a=
lso
> add shmem collapse as a default test item to catch issues that could break
> the test cases.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  tools/testing/selftests/mm/run_vmtests.sh | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/se=
lftests/mm/run_vmtests.sh
> index 33fc7fafa8f9..a38c984103ce 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -485,6 +485,10 @@ CATEGORY=3D"thp" run_test ./khugepaged
>=20
>  CATEGORY=3D"thp" run_test ./khugepaged -s 2
>=20
> +CATEGORY=3D"thp" run_test ./khugepaged all:shmem
> +
> +CATEGORY=3D"thp" run_test ./khugepaged -s 4 all:shmem
> +
>  CATEGORY=3D"thp" run_test ./transhuge-stress -d 20
>=20
>  # Try to create XFS if not provided
> --
> 2.43.5
>=20


