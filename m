Return-Path: <linux-kselftest+bounces-13693-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7B69300E0
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 21:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3210DB2347F
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 19:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F56282F4;
	Fri, 12 Jul 2024 19:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="WxtyVYnT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220E03A1DA;
	Fri, 12 Jul 2024 19:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720812156; cv=fail; b=G8U08iFHQdWNVsdGud3FMe5ENUVX1mMB/qNVOZHRDpcztfUBakG9Nb+uLxqT/wnvzQBUPA3qy57ZTMfL5tvA0eHs1YwLS75BVnJszxSa+5gDAemE8QsP2cvj0SxLiaB71GvZhc8SFezJb27TdlTrQBk3tC0QTxsFFr85gZ8xAWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720812156; c=relaxed/simple;
	bh=KoteJbFRNnPgVcutwABM4ZsVu2EC1fbhV95O4ry4ghE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L6vLI2r0Kc75vcRgeVKrk7rJHM0suxOSQydOhoUp1q9PfEyG2qJ7v7GhZiAKf5+UA+Zwe/tsFr/8apgeMVI+YcKkupFvAaWDOFw+mDcZC6dDW9J8zfl+qX6iX4ZD+DyA12DseEx3rqw7ARJvrygplsDY6ZpO3OtlL4JVCD+Fbo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=WxtyVYnT; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CGXPxm017688;
	Fri, 12 Jul 2024 17:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=KoteJbF
	RNnPgVcutwABM4ZsVu2EC1fbhV95O4ry4ghE=; b=WxtyVYnTdvkL+Uk7qUro+5z
	cBg9XBB4/23UaaJGqwBL0JAu2OReV+4muyA4eFDEiQUDOJWACNWCggrUL79l1Zoc
	d/6BqOHEscIV7X+mrFhyvkdfbp9En078h9x/6o53KQywiN+x0IG4sHy6swpj6puT
	iNJ2ezehr4tOn38r0ZRoRkOo+Rzkwiwpu5r/Bi8ICFJW44dlvwli6IQvqnxeMi7W
	O+5M2+vNRgcpPHr1pPg/VIdpsvrxC1OVtogA+JDWFSQ9uDtXJpw8hXM2nBB0KF2V
	NuKDpA+xPPnHoVfpgbqEk+bXWhCyQc3YH8wgaWH4DUBkBeiMmldM7l59R/yrjcQ=
	=
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 406wubxrnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 17:48:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVc4qZ3hL/5JikcqPwZOM+8NnKFsgcjAsmyQDmWJ9h2H0E4LvUfAArJiGPAFkOxceKRLssxywcEy5vSYSHWm6quW6AcwpAcs8AyLUOv6jAxWekGZkOV/6kU0MAS6VVtITR/DznkXgntS6aimp1039M5vIPlHjEXt4PwI55dKhjpFuGLKK4vcAe0SlXxBHjQWvMNhCY1VncyWJMZ14YKfooiL+X3bxjX8jLZL1H7VL9ISuS8jWRLIf0GvLsQmEZZuMT3nlJpCSd/KNcT00HLw6gT1Pns4AjGQEi7Cy5nkReg/b5PYS0BmNjmxG20+CL21YFbMhAGWHsZMWYcg69okQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoteJbFRNnPgVcutwABM4ZsVu2EC1fbhV95O4ry4ghE=;
 b=vLkA/BUt4y3KycmME4px/b3iUdkiOGTLbPQWc2K3uGra3+rXBHD3BEqzZt5TaUu/Zy8b06XWOmV4Zj3wDH2GAn1EpYrCUCAe9t4tJVvl+uzAZ2Sxr8DZs+UxOBXLZX/IdGUfZMM1AKJdNs64e/vLI6QyDNrYX3STMyV5OQlNItoTYx3LF60d3nupM8TwR8+QcJFXQMvDQvRoKzd2A9qZmbw4i+xxkWV4TU2+fiH+6XuJcjowReaYhtsRtP1Mga2YEJL+uFV5+PsjZ7qn4CZ37uBvTuZU088zxXXQ04RPVdgN4fQ8LQlTUj24sxZ27wFInVhuzVqv5m9834xKpcrDUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BN6PR13MB3041.namprd13.prod.outlook.com (2603:10b6:405:7b::18)
 by PH0PR13MB6156.namprd13.prod.outlook.com (2603:10b6:510:292::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 17:48:17 +0000
Received: from BN6PR13MB3041.namprd13.prod.outlook.com
 ([fe80::3661:5a0d:34d0:7c4]) by BN6PR13MB3041.namprd13.prod.outlook.com
 ([fe80::3661:5a0d:34d0:7c4%5]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 17:48:15 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
        Shuah Khan <skhan@linuxfoundation.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan
	<shuah@kernel.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernelci@lists.linux.dev" <kernelci@lists.linux.dev>
Subject: RE: [PATCH v2 0/3] kselftest: Add test to report device log errors
Thread-Topic: [PATCH v2 0/3] kselftest: Add test to report device log errors
Thread-Index: AQHazzNNfIfe5Y6CL02pGYTvvUdvzrHv9t8AgACQvoCAAXIGgIAAHuUAgAFLL3A=
Date: Fri, 12 Jul 2024 17:48:14 +0000
Message-ID: 
 <BN6PR13MB30412D89F6389C30BD1DEFDBFDA62@BN6PR13MB3041.namprd13.prod.outlook.com>
References: <20240705-dev-err-log-selftest-v2-0-163b9cd7b3c1@collabora.com>
 <2024071003-islamist-expediter-a22c@gregkh>
 <71c479fb-cd25-45ec-8dd3-0521ef951f58@linuxfoundation.org>
 <e1e32c72-6bd3-4c15-b301-c5670690ba99@linuxfoundation.org>
 <1417b57a-ac0b-4e8c-b157-bbe9ebb14e57@notapiano>
In-Reply-To: <1417b57a-ac0b-4e8c-b157-bbe9ebb14e57@notapiano>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR13MB3041:EE_|PH0PR13MB6156:EE_
x-ms-office365-filtering-correlation-id: bfe4a9ba-ae0d-42b5-b1a1-08dca29ace44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?dHFoWDY4NDdSRDEvcWpZTkhxcFlpWDgwTzcwYyt0UDhMVU9iNGxFOXJ1YlNT?=
 =?utf-8?B?YmpYc21PdmdSL2E5cmFiZTNWbTV1UWxDc3h5SmhHSmZFaC92ZTNxTnoxUkNG?=
 =?utf-8?B?ZjFjSjEzYlA4eWN3QnN6LzA3cUllbnhnUW5NV0I5dE0vUkI3anJ4dlBRVmlo?=
 =?utf-8?B?NG5LQWwrZEQwWFBrd09hMkJwa0cyNWZsTWt6S0JnOVNVeDR2QSs3TGtSQW5K?=
 =?utf-8?B?Mk9la2V4UTBxcGI2T1d0WVhzS1lVL3dJU3E1YXVSSWkzd3o1WkRleTBrTDd0?=
 =?utf-8?B?V1BudFROem1LcGJUdHNRUi96Qko4Um9WODc0bkRHNXJxcGM5ZlN5d0MwM3Zz?=
 =?utf-8?B?WTd6amo4dm5lNzhWN3poWW9DR0dmZENBVE01TDA5a0hZcFB3SVc1VVZENEk0?=
 =?utf-8?B?NnpKbnFsQlZWNHg4emlLYmE0cUdXUkpLRkluQXVRMEc2WE0wOTNUVzZVVjVR?=
 =?utf-8?B?ckZqdHV3TVJYNXJiT0ZIRGFXRzlqWFpHUWxMbzhGWW5BZmlMMlFZNGN3a3VQ?=
 =?utf-8?B?T1k2a05qZkM5Y3U2VDh1MTIzUE92UXlXTHI2UHp1aEZLdUNEcEtKNzZ4WVRE?=
 =?utf-8?B?QjRsNVQ4d1NPSW1xbWdReDlvVFpKd3N3RU9XeG95ZjNKVGhVaXdRcGwxb1pw?=
 =?utf-8?B?aUxrNXZ6NUJXT1dvZGZ0WGZvNGVqQ0FpSnR0a0l1QnQ5VzZkSi9SeXI5aE81?=
 =?utf-8?B?TWRVZzRhNUsvSnVJRi9TeDBiQkdIMGZmZXRKamRQQXVaaHk1WWViRjNaajBq?=
 =?utf-8?B?RGcyWi90UGNpUUNYNWFMcFBQQnM1a0NtUEF1N2tjelBScDhWVFdBamlycnVZ?=
 =?utf-8?B?TEttc2M1TWRoSit0QzFkeU5xQmk3V3hsVGNXbHEvWWVISGFvTlBVS2E0NzZx?=
 =?utf-8?B?NnlUZjVuUllPQXNNVXJER1BZVmhBekFkV3I1b05ENjhqNmdFV2VqZ0ZJZmRW?=
 =?utf-8?B?MEtKbnNabFA3TEFGY0g3enpGQmdybWEvTlhyNEFQQjhDV2J5NFpLczgrSzR2?=
 =?utf-8?B?Q2NONExDMzhGZFRHdmJzSVBabGxPbm9NeWdFZE1uY05JUG1QZVliQzBTK0ZP?=
 =?utf-8?B?enk4QWZuL0g1Tm81MDhxWkIyWVNtQ3NzUTFUaEp5S0VPN21JZFJOVkxrT3VV?=
 =?utf-8?B?enM0RUt4bENrYkUzQnQvaDhFT2c1M2tvUjF6YnUyLzIxdXM2eVNxMGo2YUlL?=
 =?utf-8?B?Vlpoc3U2b3ZmZHFGV1d5QlozUXpscDFQSmFvelVwN2xYYWJqc3pQZTNzaEVq?=
 =?utf-8?B?eHk3eDc0cW8rYjczM01EMWZ4ZlBZVTFjNlRyWkdudDJ1aGxSdzVEMmZkWUds?=
 =?utf-8?B?TnoremlnU0o1b1JVTWIyVXUxK3JKM1lpcFozNE9OM1JJWmFvVUs0cFBuWGVs?=
 =?utf-8?B?R3hxaXE5c08zRmgxanJpSHU0ZFd3OEgrL1BsMERqWDZQYkxrdnVyejdGTUQz?=
 =?utf-8?B?MnlSeGFwQ1BpNlh5T3JYSEdxKzBub1RFQUZYVFh3ZkI0aGxjbWZNMXA2S215?=
 =?utf-8?B?dGJHTW1pSDg1b0YzK29WRHJBR0dGTy82OUc4SGQ4OVZPdWEyWEVOWHZNbUhJ?=
 =?utf-8?B?aE92L3l0bU9KYlNNRURiNFJNZ25MTkZSYkdpN01SQlpvS2g5T3pYZTNXd0Rx?=
 =?utf-8?B?ZUtGL2dRcG5Kbi9qenIzT05ZNWI5dGJIQ2NrVWhnaTBaZFZwV1JJcWdiTG8z?=
 =?utf-8?B?S1Q5WFE5RXUxaEE4VVVjbmUvbkpISytoL2NQZ0Vva1FQVGpjYXlHYm1RUGZo?=
 =?utf-8?B?bGxGRjJpa3A4ZzMvMXpUQUJzSkNKOGtCaHRoU25kMTZqQ3p6QlZ2MWNrWndH?=
 =?utf-8?B?ZkNYN3gzOEdzOTN4TVFvUWxrQ2VmNXREeGs3Um54MGVSMUptZXlIdm55bHAw?=
 =?utf-8?B?MDc3VFB2djBGNmdoWm9wZzhhN2xJU1JuSy9IeUEvUFlPQ1E9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR13MB3041.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RlYwRGJMN3Y3cnFSQzlNMS90dU0zSndicmd5VUZiMHIzTkl2ZkJWMXZFWFZF?=
 =?utf-8?B?VC9VMXZEdmViTmtrbFhjVmlDUDFnVm5sUC9MbW5xM0pCeWFDSnM4NWMvNCtE?=
 =?utf-8?B?NVFFRGlxeWh1UjNpamRNWE9Mc0VGOVM1VHIrVDdseXhTZ25BTTJpb2hBTVFi?=
 =?utf-8?B?VFV4TGFlSG1HTXEzYXFnSHhCL2NpclNvVCtvZHFuNnlMd0dtaGpWNzAzNkRi?=
 =?utf-8?B?S1B6UXB3RHM0dkI4Wk9ydmdZQTlhblB4ZlJyNkw2TnV6cWZsbHcxZytFMnhp?=
 =?utf-8?B?NzVFOTJIdHl3MzVyRGdwWHdmazdVVzArMzBaK3pZQ2EzUlcrT0loTW94YzRx?=
 =?utf-8?B?Mk8rS2NhdStmeldzeWhIdld1cnFOUmhySFY4ZkpkV1FlQy9tM25VVFhoL2ZO?=
 =?utf-8?B?T3ZaSGFsV01qVHFIY3V3RzM4aHFldnBKQVErZTUxQ1FxNzlZSzY3U2JuYTZL?=
 =?utf-8?B?T1FqQlBReHIvWll4ZlhVcGVhdEFoemk0ZHdlS2g4Rm9ieTlKQzZGWnFacXc4?=
 =?utf-8?B?YndpVzZVSEdDWmpITm5HOHBmZUNQM2toQmRnUENrVkcrcWpub0puYTMydTBs?=
 =?utf-8?B?RlFTNWYwMlNOKzNFTmE4c1ZqVUUrTjFTU045VDYxUU5DVUVZTTM3ZGpSM1Ni?=
 =?utf-8?B?ekwzS01OUnk5Rmg1RWVoMFU2S2drNUsxUlU4eHdKWEZXL09EamdWZjViUzFL?=
 =?utf-8?B?TVlaWTNqaHpSaVh3dE4vMko4UXI3MXhQZW9SNWp4bHo2bDJEZHNqSFJ5bDQ0?=
 =?utf-8?B?b0hieUtwb1YySmZGYWxiWlNIdWdkN3JKdFd3bGRBRk1DcVA0NXIrQTNmVnY1?=
 =?utf-8?B?em5NNTVvenExam4rNHlaM2VETUF0cTNHOFk1ZVE2T1VJeDVLWU1OdzJHZEQw?=
 =?utf-8?B?TXV6OFVTN1BRUDN2Qjl1U3MyQ29qWG5hVE5mSHUvSGtKdm95ZnlTbDB5Z3cv?=
 =?utf-8?B?UTFzZjF0cU1zclE1dUxJRThaaVpreWg2U0s2d3lQTncwa2c2bS81MUpobFpW?=
 =?utf-8?B?bUhDQmFoRWl2NVBPUXFhaUdlYnVIdU1vNGs3bkxQdUowS0VjM1Y2Qlk0WUNJ?=
 =?utf-8?B?WGNsWldIdmRDMzZ6UWQ0Zno4cEtNa3ZZZjdaUjFaMWZuTDdpdjB3ZktjK2Vh?=
 =?utf-8?B?a3R5ZWJycjlWQ3haOE1IMEhVcFRRRVEvdHZWM0pzWFNEb293b2E0UDdNeXpU?=
 =?utf-8?B?S3pvYXVnM1kybFJ4dEF3QkIxa21BR01zM1pYdStlR1BEMDg1QkNxN01hMzVJ?=
 =?utf-8?B?aHgrNG56NWRZc1FyYTJKQzVUdEtkdjRnbWlCT3k4eUI1WUQ5WGZPTklBTTdl?=
 =?utf-8?B?cmhRZXRNeVVFTFpJL2VqSGZKNVdickk2K1RRTEs0K3ZHMmtCcjRDMCtIQUxw?=
 =?utf-8?B?aXRhZWNFTkFwS0dxRHplNkhXSHVvaTBmbk93U24rWlJuejJCWDNSTDZHQXdN?=
 =?utf-8?B?eGxEb0tmRDR3V2QwVWNSYjk0S1BmVHE3di9LaEh2MUZJRHpxc0FKQW5CeXZF?=
 =?utf-8?B?eEk5UUZIVFlzbFVZdUhwaWJmSnBBS1ByVW5NN081UHpVRnJQOXAyQWwyaURR?=
 =?utf-8?B?SkR6SU55a3IyUTNDYWkvNGNvL1RlWW9pdUROUFdBWEJ0WnIvUU8yV0JRQ0hx?=
 =?utf-8?B?dERHRGRYeFdRZmZvcWJOQUFGRitGQzRrNlAvb0JvTCt4bWpxUVRwVlN4cTJo?=
 =?utf-8?B?OHVRTVBtd0Fpb3BoYlZDeFR4NTZUOGRPUENvZ2FHZVp5Qy9uRE1QTXR5UkJp?=
 =?utf-8?B?b1dRVzhFZ0ZHZTlNb0dTNlR4VHdXTS9FaUl6VW1mQW96QXBkRmtFcTd3azIv?=
 =?utf-8?B?K0oyRktSVkZOUnArcTRaSnY2a0J0QlBLS1EyMmdoT3lIOXVUZUwzTGpEdXlK?=
 =?utf-8?B?aHJQU01jcWZXdTFreUVOZlhKdVYvc1I2U05qMHNISFl4ZGIvczFxZWFTNSsy?=
 =?utf-8?B?RWw0aVVzdm4wVGY1dlI2RE5DT2kwR3lCUWNqMmJlOXBNQ1Z3NGh6VFRCaGF3?=
 =?utf-8?B?aVE0MEtpSFM3RkZ4cTNCQjVUWnpIWXJkT09CVWd3cHRZVHRFbDB6eldBaGRl?=
 =?utf-8?B?bWQwS05jRzllMHpYbW1NZXovSDVUR3VEVnQzcEFjd1NXb0V6Yk9Ud2RZQ2ZW?=
 =?utf-8?Q?djfU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	E5H7o/J7C0CLFBCzc8ZdsHjbs7BPnA9C4WgcmdXA7AVMgWOkqnjPGzzSmHYBQivuZYiq2hLOxVp7iO/JcOrGtj8OazjgTxvVS6iUnEj6AcWbEkN2gDinDBvNHGAbZo1g0SncWJxgx8HcLIjsKvlMNrJLes8lpEEi74vTNlBE239oFsKvIDYfwJzebeb2rHITdkCcUAcOr+/NmsXz4KLIavaTaGPstSNg6IufPXP7wpoiqrb8Fv7I1ha8z/yQwHnX+/iRh+dduMgt7o+2D0IRIsm9H+BgKsOiKGmsXXveW1Qo/0jj7nCtpzBwKpXT60nu/Shv6am/aD7gcYuGhRjaHI/+4xjGQOlJAaopJBBdL0PgEuNO4yDOpaP1ZxaTeQZjHAYS4xkOfGhxAcOaxCDW5HoM64bR5rc/n6tr/QuakBahw0PQC+XJ4cSNEb1AGXpWCotNnn5Z3wZZxHzQzsOmWTe0vR2FAUD30eKG/4fjbDM3uPVwyTJnQ+P4SU1nl3ODGXr88/HLvMFft3JBqBiqJ9N1crHVJI/+8F58/xawpkw3oV73FbvF5v4iKSC3b0TXb01lM2ho8jVhhh9x1D4y7KnUBJyQNctgUodDAcAOtnHpghUjlWyLTaybFWa4c3u5
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR13MB3041.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe4a9ba-ae0d-42b5-b1a1-08dca29ace44
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 17:48:14.8689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OEWigM2wE7+Jtb8DmHneRtf+eOyCPjlOKIi1dGw6vQj5CAM+Gw18ZM6V6W2AAFK41ZB8EeP3uRXn2pdz6O2eWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB6156
X-Proofpoint-GUID: 8n0NDMBwBcJfTVhjyVUPK7myHlIvoKnj
X-Proofpoint-ORIG-GUID: 8n0NDMBwBcJfTVhjyVUPK7myHlIvoKnj
X-Sony-Outbound-GUID: 8n0NDMBwBcJfTVhjyVUPK7myHlIvoKnj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_13,2024-07-11_01,2024-05-17_01

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTsOtY29sYXMgRi4gUi4g
QS4gUHJhZG8gPG5mcmFwcmFkb0Bjb2xsYWJvcmEuY29tPg0KPiBPbiBUaHUsIEp1bCAxMSwgMjAy
NCBhdCAwMTo1MzozN1BNIC0wNjAwLCBTaHVhaCBLaGFuIHdyb3RlOg0KPiA+IE9uIDcvMTAvMjQg
MTU6NDksIFNodWFoIEtoYW4gd3JvdGU6DQo+ID4gPiBPbiA3LzEwLzI0IDA3OjExLCBHcmVnIEty
b2FoLUhhcnRtYW4gd3JvdGU6DQo+ID4gPiA+IE9uIEZyaSwgSnVsIDA1LCAyMDI0IGF0IDA3OjI5
OjUzUE0gLTA0MDAsIE7DrWNvbGFzIEYuIFIuIEEuIFByYWRvIHdyb3RlOg0KPiA+ID4gPiA+IExv
ZyBlcnJvcnMgYXJlIHRoZSBtb3N0IHdpZGVseSB1c2VkIG1lY2hhbmlzbSBmb3IgcmVwb3J0aW5n
IGlzc3VlcyBpbg0KPiA+ID4gPiA+IHRoZSBrZXJuZWwuIFdoZW4gYW4gZXJyb3IgaXMgbG9nZ2Vk
IHVzaW5nIHRoZSBkZXZpY2UgaGVscGVycywgZWcNCj4gPiA+ID4gPiBkZXZfZXJyKCksIGl0IGdl
dHMgbWV0YWRhdGEgYXR0YWNoZWQgdGhhdCBpZGVudGlmaWVzIHRoZSBzdWJzeXN0ZW0gYW5kDQo+
ID4gPiA+ID4gZGV2aWNlIHdoZXJlIHRoZSBtZXNzYWdlIGlzIGNvbWluZyBmcm9tLiBUaGlzIHNl
cmllcyBtYWtlcyB1c2Ugb2YgdGhhdA0KPiA+ID4gPiA+IG1ldGFkYXRhIGluIGEgbmV3IHRlc3Qg
dG8gcmVwb3J0IHdoaWNoIGRldmljZXMgbG9nZ2VkIGVycm9ycy4NCj4gPiA+ID4gPg0KPiA+ID4g
PiA+IFRoZSBmaXJzdCB0d28gcGF0Y2hlcyBtb3ZlIGEgdGVzdCBhbmQgYSBoZWxwZXIgc2NyaXB0
IHRvIGtlZXAgdGhpbmdzDQo+ID4gPiA+ID4gb3JnYW5pemVkIGJlZm9yZSB0aGlzIG5ldyB0ZXN0
IGlzIGFkZGVkIGluIHRoZSB0aGlyZCBwYXRjaC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEl0IGlz
IGV4cGVjdGVkIHRoYXQgdGhlcmUgbWlnaHQgYmUgbWFueSBmYWxzZS1wb3NpdGl2ZSBlcnJvciBt
ZXNzYWdlcw0KPiA+ID4gPiA+IHRocm91Z2hvdXQgdGhlIGRyaXZlcnMgY29kZSB3aGljaCB3aWxs
IGJlIHJlcG9ydGVkIGJ5IHRoaXMgdGVzdC4gQnkNCj4gPiA+ID4gPiBoYXZpbmcgdGhpcyB0ZXN0
IGluIHRoZSBmaXJzdCBwbGFjZSBhbmQgd29ya2luZyB0aHJvdWdoIHRoZSByZXN1bHRzIHdlDQo+
ID4gPiA+ID4gY2FuIGFkZHJlc3MgdGhvc2Ugb2NjdXJyZW5jZXMgYnkgYWRqdXN0aW5nIHRoZSBs
b2dsZXZlbCBvZiB0aGUgbWVzc2FnZXMNCj4gPiA+ID4gPiB0aGF0IHR1cm4gb3V0IHRvIG5vdCBi
ZSByZWFsIGVycm9ycyB0aGF0IHJlcXVpcmUgdGhlIHVzZXIncyBhdHRlbnRpb24uDQo+ID4gPiA+
ID4gSXQgd2lsbCBhbHNvIG1vdGl2YXRlIGFkZGl0aW9uYWwgZXJyb3IgbWVzc2FnZXMgdG8gYmUg
aW50cm9kdWNlZCBpbiB0aGUNCj4gPiA+ID4gPiBjb2RlIHRvIGRldGVjdCByZWFsIGVycm9ycyB3
aGVyZSB0aGV5IHR1cm4gb3V0IHRvIGJlIG1pc3NpbmcsIHNpbmNlDQo+ID4gPiA+ID4gaXQgd2ls
bCBiZSBwb3NzaWJsZSB0byBkZXRlY3Qgc2FpZCBpc3N1ZXMgYXV0b21hdGljYWxseS4NCj4gPiA+
ID4gPg0KPiA+ID4gPiA+IEFzIGFuIGV4YW1wbGUsIGJlbG93IHlvdSBjYW4gc2VlIHRoZSB0ZXN0
IHJlc3VsdCBmb3INCj4gPiA+ID4gPiBtdDgxOTItYXN1cmFkYS1zcGhlcmlvbi4gVGhlIHNpbmds
ZSBzdGFuZGluZyBpc3N1ZSBoYXMgYmVlbiBpbnZlc3RpZ2F0ZWQNCj4gPiA+ID4gPiBhbmQgd2ls
bCBiZSBhZGRyZXNzZWQgaW4gYW4gRUMgZmlybXdhcmUgdXBkYXRlIFsxXToNCj4gPiA+ID4gPg0K
PiA+ID4gPiA+IFRBUCB2ZXJzaW9uIDEzDQo+ID4gPiA+ID4gMS4uMQ0KPiA+ID4gPiA+ICAgcG93
ZXJfc3VwcGx5IHNicy04LTAwMGI6IGRyaXZlciBmYWlsZWQgdG8gcmVwb3J0IGB0aW1lX3RvX2Vt
cHR5X25vdycgcHJvcGVydHk6IC01DQo+ID4gPiA+ID4gICBwb3dlcl9zdXBwbHkgc2JzLTgtMDAw
YjogZHJpdmVyIGZhaWxlZCB0byByZXBvcnQgYHRpbWVfdG9fZW1wdHlfbm93JyBwcm9wZXJ0eTog
LTUNCj4gPiA+ID4gPiAgIHBvd2VyX3N1cHBseSBzYnMtOC0wMDBiOiBkcml2ZXIgZmFpbGVkIHRv
IHJlcG9ydCBgdGltZV90b19lbXB0eV9ub3cnIHByb3BlcnR5OiAtNQ0KPiA+ID4gPiA+ICAgcG93
ZXJfc3VwcGx5IHNicy04LTAwMGI6IGRyaXZlciBmYWlsZWQgdG8gcmVwb3J0IGB0aW1lX3RvX2Vt
cHR5X25vdycgcHJvcGVydHk6IC01DQo+ID4gPiA+ID4gICBwb3dlcl9zdXBwbHkgc2JzLTgtMDAw
YjogZHJpdmVyIGZhaWxlZCB0byByZXBvcnQgYHRpbWVfdG9fZW1wdHlfbm93JyBwcm9wZXJ0eTog
LTUNCj4gPiA+ID4gPiAgIHBvd2VyX3N1cHBseSBzYnMtOC0wMDBiOiBkcml2ZXIgZmFpbGVkIHRv
IHJlcG9ydCBgdGltZV90b19lbXB0eV9ub3cnIHByb3BlcnR5OiAtNQ0KPiA+ID4gPiA+ICAgcG93
ZXJfc3VwcGx5IHNicy04LTAwMGI6IGRyaXZlciBmYWlsZWQgdG8gcmVwb3J0IGB0aW1lX3RvX2Vt
cHR5X25vdycgcHJvcGVydHk6IC01DQo+ID4gPiA+ID4gICBwb3dlcl9zdXBwbHkgc2JzLTgtMDAw
YjogZHJpdmVyIGZhaWxlZCB0byByZXBvcnQgYHRpbWVfdG9fZW1wdHlfbm93JyBwcm9wZXJ0eTog
LTUNCj4gPiA+ID4gPiAgIHBvd2VyX3N1cHBseSBzYnMtOC0wMDBiOiBkcml2ZXIgZmFpbGVkIHRv
IHJlcG9ydCBgdGltZV90b19lbXB0eV9ub3cnIHByb3BlcnR5OiAtNQ0KPiA+ID4gPiA+ICAgcG93
ZXJfc3VwcGx5IHNicy04LTAwMGI6IGRyaXZlciBmYWlsZWQgdG8gcmVwb3J0IGB0aW1lX3RvX2Vt
cHR5X25vdycgcHJvcGVydHk6IC01DQo+ID4gPiA+ID4gICBwb3dlcl9zdXBwbHkgc2JzLTgtMDAw
YjogZHJpdmVyIGZhaWxlZCB0byByZXBvcnQgYHRpbWVfdG9fZW1wdHlfbm93JyBwcm9wZXJ0eTog
LTUNCj4gPiA+ID4gPiAgIHBvd2VyX3N1cHBseSBzYnMtOC0wMDBiOiBkcml2ZXIgZmFpbGVkIHRv
IHJlcG9ydCBgdGltZV90b19lbXB0eV9ub3cnIHByb3BlcnR5OiAtNQ0KPiA+ID4gPiA+ICAgcG93
ZXJfc3VwcGx5IHNicy04LTAwMGI6IGRyaXZlciBmYWlsZWQgdG8gcmVwb3J0IGBtb2RlbF9uYW1l
JyBwcm9wZXJ0eTogLTYNCj4gPiA+ID4gPiAgIHBvd2VyX3N1cHBseSBzYnMtOC0wMDBiOiBkcml2
ZXIgZmFpbGVkIHRvIHJlcG9ydCBgdGltZV90b19lbXB0eV9ub3cnIHByb3BlcnR5OiAtNQ0KPiA+
ID4gPiA+ICAgcG93ZXJfc3VwcGx5IHNicy04LTAwMGI6IGRyaXZlciBmYWlsZWQgdG8gcmVwb3J0
IGBlbmVyZ3lfZnVsbF9kZXNpZ24nIHByb3BlcnR5OiAtNg0KPiA+ID4gPiA+ICAgcG93ZXJfc3Vw
cGx5IHNicy04LTAwMGI6IGRyaXZlciBmYWlsZWQgdG8gcmVwb3J0IGB0aW1lX3RvX2VtcHR5X25v
dycgcHJvcGVydHk6IC01DQo+ID4gPiA+ID4gICBwb3dlcl9zdXBwbHkgc2JzLTgtMDAwYjogZHJp
dmVyIGZhaWxlZCB0byByZXBvcnQgYHRpbWVfdG9fZW1wdHlfbm93JyBwcm9wZXJ0eTogLTUNCj4g
PiA+ID4gPiAgIHBvd2VyX3N1cHBseSBzYnMtOC0wMDBiOiBkcml2ZXIgZmFpbGVkIHRvIHJlcG9y
dCBgdGltZV90b19lbXB0eV9ub3cnIHByb3BlcnR5OiAtNQ0KPiA+ID4gPiA+ICAgcG93ZXJfc3Vw
cGx5IHNicy04LTAwMGI6IGRyaXZlciBmYWlsZWQgdG8gcmVwb3J0IGB0aW1lX3RvX2VtcHR5X25v
dycgcHJvcGVydHk6IC01DQo+ID4gPiA+ID4gICBwb3dlcl9zdXBwbHkgc2JzLTgtMDAwYjogZHJp
dmVyIGZhaWxlZCB0byByZXBvcnQgYHRpbWVfdG9fZW1wdHlfbm93JyBwcm9wZXJ0eTogLTUNCj4g
PiA+ID4gPiBub3Qgb2sgMSArcG93ZXJfc3VwcGx5OnNicy04LTAwMGINCg0KU29ycnkgdGhpcyBm
ZWVkYmFjayBpcyBjb21pbmcgbGF0ZS4gDQoNClRoZSB0ZXN0IGRlc2NyaXB0aW9uIG9ubHkgaW5j
bHVkZXMgdGhlIGRldmljZSBpZGVudGlmaWVyLCBhbmQgbm90IGEgZGVzY3JpcHRpb24gb2YgdGhl
IHRlc3RjYXNlLg0KKFNlZSBiZWxvdyBmb3Igd2h5IHRoaXMgbWlnaHQgYmUgdGhlIGNhc2UpLg0K
DQpNYXliZSBhIGJldHRlciB0ZXN0Y2FzZSBkZXNjcmlwdGlvbiBtaWdodCBiZTogImNoZWNrIHRo
YXQgcG93ZXJfc3VwcGx5OnNicy04LTAwMGIgZGV2aWNlIGhhcyBubyBlcnJvciBtZXNzYWdlcyIN
Cg0KSSBub3RlIHRoYXQgdGhlcmUgYXJlIDMgZGlmZmVyZW50IGVycm9yIG1lc3NhZ2VzLCBidXQg
b25seSBvbmUgdGVzdGNhc2UgcmVwb3J0IGdlbmVyYXRlZC4NCkl0IHdvdWxkIGJlIGEgbG90IG9m
IHdvcmsgKHByb2JhYmx5IHRvbyBtdWNoKSwgZm9yIHRoaXMgdGVzdCB0byBpbnRlcnByZXQgdGhl
IGVycm9yIG1lc3NhZ2VzDQphbmQgY29udmVydCB0aGVtIGludG8gdGVzdGNhc2UgbGFuZ3VhZ2Uu
ICBCdXQgaXQgbWlnaHQgYmUgd29ydGh3aGlsZSB0byByZXBvcnQgYSB0ZXN0IHJlc3VsdA0KZm9y
IGVhY2ggdHlwZSBvZiBlcnJvciBtZXNzYWdlIGdlbmVyYXRlZC4NCg0KPiA+ID4gPiA+ICAgVG90
YWxzOiBwYXNzOjAgZmFpbDoxIHhmYWlsOjAgeHBhc3M6MCBza2lwOjAgZXJyb3I6MA0KPiA+ID4g
PiA+DQoNClRoZXJlIGFyZSBhIGZldyBpbnRlcmVzdGluZyBpc3N1ZXMgdGhhdCB0aGlzICd0ZXN0
JyByYWlzZXMuDQoNCkl0IGlzIG5vdCBzbyBtdWNoIGEgdGVzdCBpdHNlbGYsIGFzIGEgd2F5IHRv
IGNvbnZlcnQgYW4gZXJyb3IgbG9nIHJlcG9ydCBpbnRvIEtUQVAgb3V0cHV0Lg0KDQpUaGUgJ3Rl
c3QnIGhhcyBubyBrbm93bGVkZ2Ugb2Ygd2hhdCB0aGUgdGVzdGNhc2VzIGFyZSwgdGhhdCBhcmUg
YmVpbmcgcmVwb3J0ZWQuDQpUaGF0IGlzLCB0aGUgYWN0dWFsIHRlc3QgaGFzIG9jY3VycmVkIGF0
IHJ1bnRpbWUsIGluc2lkZSB0aGUgZHJpdmVyIG9yIGRldmljZSBtYW5hZ2VyDQpjb2RlLCB3aGlj
aCBwcm9kdWNlZCB0aGUgZXJyb3Igc3RyaW5nLiAgVGhpcyAndGVzdCcganVzdCByZXBvcnRzIHRo
YXQgdGhlIGRldmljZSByZXBvcnRlZA0KYW4gZXJyb3IuIA0KDQpBcyBjdXJyZW50bHkgc3RydWN0
dXJlZCwgdGhlcmUgaXMgbm8gd2F5IGZvciB0aGlzIHRvIHJlcG9ydCBhbiAnb2snIHRlc3RjYXNl
Lg0KSSB0YWxrZWQgd2l0aCBOaWNvbGFzIG9uIGEgS2VybmVsQ0kgY29uZmVyZW5jZSBjYWxsLCBp
dCBpcyBhcHBhcmVudGx5IHBvc3NpYmxlIHRvIHRyeSB0byBmaW5kDQphbGwgcG9zc2libGUgZGV2
aWNlcyBvbiBhIHN5c3RlbSwgYW5kIHJlcG9ydCB0aGVtIGFzICdvaycuICBCdXQgdGhpcyB3b3Vs
ZCBwcm9kdWNlDQphIExPVCBvZiBub2lzZSwgYXMgYWxsIHRoZSBkZXZpY2VzIHRoYXQgZGlkIG5v
dCBoYXZlIGVycm9ycyB3b3VsZCBiZSByZXBvcnRlZCBhcyAnb2snLg0KVGhpcyBsZXZlbCBvZiB2
ZXJib3NpdHkgaXMgcHJvYmFibHkgbm90IGRlc2lyYWJsZS4gIChJdCdzIHNpbWlsYXIgdG8gaG93
IGEgY29tcGlsZXIgZG9lcw0Kbm90IHJlcG9ydCB0aGUgc3VjY2VzcyBvZiBldmVyeSB0ZXN0IGl0
IGNvbmR1Y3RzIG9uIHRoZSBzb3VyY2UgY29kZSwgYXMgaXQgaXMgYmVpbmcgY29tcGlsZWQuDQpS
YXRoZXIgYSBjb21waWxlciBvbmx5IG91dHB1dHMgZXJyb3JzIGFuZCB3YXJuaW5ncyBmb3IgdGVz
dCBmYWlsdXJlcy4pDQoNCkluIHRlcm1zIG9mIHRyYWNraW5nIHJlZ3Jlc3Npb25zLCBpdCB3b3Vs
ZCBiZSB1c2VmdWwgdG8gaWRlbnRpZnkgdGhlIGRpZmZlcmVudCB0aGluZ3MgdGhhdCBjb3VsZA0K
Y2F1c2UgYW4gZXJyb3IgbWVzc2FnZSB0byBhcHBlYXIgb3IgZGlzYXBwZWFyLiAgRm9yIGV4YW1w
bGUsIHNvbWUgZXJyb3JzIHJlbGF0ZWQgdG8gaGFyZHdhcmUNCm1pZ2h0IGNoYW5nZSBkdWUgdG8g
Zmxha2luZXNzIG9mIHRoZSBoYXJkd2FyZS4gIFNvbWUgZXJyb3JzIG1pZ2h0IGJlIGludHJvZHVj
ZWQgb3IgZ28gYXdheQ0KYmFzZWQgb24gYSBjaGFuZ2UgaW4gdGhlIGtlcm5lbCBjb25maWd1cmF0
aW9uLiAgVGhpcyBpcyBvbmUgY2FzZSwgd2hlcmUgaGF2ZSBhIGxvbmcgbGlzdCBvZiAib2siDQps
aW5lcyB3b3VsZCBiZSB1c2VmdWwgLSB0byBkaXNhbWJpZ3VhdGUgZHJpdmVycyB0aGF0IHdlcmUg
cHJlc2VudCwgYnV0IGRpZG4ndCBoYXZlIGFuIGVycm9yLCBmcm9tDQpkcml2ZXJzIHRoYXQgd2Vy
ZSBub3QgcHJlc2VudCBhdCBhbGwuDQoNCkkgdGhpbmsgdGhpcyB0ZXN0IGlzIHVzZWZ1bCwgYW5k
IGFtIG5vdCBOQUstaW5nIGl0LiAgSSdtIGp1c3QgZ2l2aW5nIHNvbWUgZmVlZGJhY2sgb24gdGhl
IGdlbmVyYWwNCmFwcHJvYWNoLCBhbmQgaG9wZWZ1bGx5IHJhaXNpbmcgc29tZSBpc3N1ZXMgdG8g
Y29uc2lkZXIsIHRvIG1ha2UgdGhlIHRlc3QgbW9yZSB1c2VmdWwuDQoNCiAtLSBUaW0NCg0K

