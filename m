Return-Path: <linux-kselftest+bounces-16970-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5CC9687A6
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 14:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAB8A283813
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 12:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE90B185B6B;
	Mon,  2 Sep 2024 12:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b="OwuJASZW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2074.outbound.protection.outlook.com [40.107.105.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6F118595A;
	Mon,  2 Sep 2024 12:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725280762; cv=fail; b=Lo9YzJ/8/HakyQaAicOgc4bST0J+ayC69MTKFuqGnNY/jhFwPDdiA3xblBTzcnZOg4KTptmvlLXyn7nXgNG0BS0jFP1xhQfHj763Mk95dR13kPUOrkMvfu+Ky2Z9dBwToR2Narjd4QqAY0lGFa5qFwhRX+mV0UOWH25RXBEw4SU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725280762; c=relaxed/simple;
	bh=DUtYcXNAy9Yci3krvKLuRgCBbY0lVcb+b1hQnihR1rQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PGnaaTPNTOxfTNdg0Hh/lFtqI6mVffQlw0S/sZMtyPCxO2sXfhqPfHZ5jHQ8DDlTSEaLY+2bgNfcqSfMm7FCGrxpTby9fuRRQaaQuObxddeZVUsvtf/OAKIXpLxjRwUihSHnbPLCBRVnbUCCxGgKmBQPu9yEYBrGXQFV1PWqkp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com; spf=pass smtp.mailfrom=cs-soprasteria.com; dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b=OwuJASZW; arc=fail smtp.client-ip=40.107.105.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs-soprasteria.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktKvDTzMlKlNZsSsNQVGROav8+DhWUjkQmb5vfByOX8B1KeifF+9mmZXutiUBAlc/yE+Rm7tLH7b1FVMchi/lWFZScIAGhkx8lOjEmK40CLSRpzwYOwHfwGpWVhOpZW6T13WSCTyG2dyd0xmY4AsDLboq0Wyq0dXjPIgwVb2ECKhpjoUROeZEYY7hBQQYWOFovd6Imjt9wrRcdcxV5I9QXx8dEXn3VxIZKL8wJ23j9JJc4PmjhDoPQV26EXcCYDD+e3FItk9Livqki3mFDCh9TeS39XTyGJ4VavqYqOOB1KjkSAgachrYZOShdGkLMlcE5OgcptyS09CTI5ebdYuvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUtYcXNAy9Yci3krvKLuRgCBbY0lVcb+b1hQnihR1rQ=;
 b=uuZ5vTf28/Bjq6yRDwkpxKCGjUtA316vdJuGfpptdGhT2FaIadib6sUpCVzxcrOE0/FEvTE0SWpH2/1NyPdB4nJSsuPqZA8FszhOFUbSVcTD1YXd7BTZCwY/D9S+599kYeHbcwUo6dC67O6g0+7wVDCyZGKl2K5HOYwejqq3Sk3Rf2lHH+B621UCPd5Y4Yb76J8K+YUhGnvw/cdqN93F2eaO4jQKfp8cradNsL1wKNzN+4B5HBCkmxufEcppaeZst54OY5MZ1qm3biEKbk3rQTaQ2d8EKEO7u8oIpxpOZMjq72fsNyvunD1jtiFhZVz1R1JsZFzeEB8bPtKynZaJ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs-soprasteria.com; dmarc=pass action=none
 header.from=cs-soprasteria.com; dkim=pass header.d=cs-soprasteria.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs-soprasteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUtYcXNAy9Yci3krvKLuRgCBbY0lVcb+b1hQnihR1rQ=;
 b=OwuJASZWLrxoIiCHVbK4MkyfzLn84m2g8yGFI6PH/sCOA5nhqmS/A76pwdOKFbvAXa1m54BMFDFrixTjeO83QQ5DvinpFp6EeegCxRBIGb0GcosJDCjE/7SyoOxo/HvHuIhoTi/v/cmaxoqIBm7h2uwPOHZW9MQjruDHVVKpq9CWKyrENJGZuftN+Lc4LdWJlIawCvJEKEGYtL7raBDoapyvH0db/jY48OjsmI4Oxcy3WfUWukm0US/vfoVwwuCvi2k1gA4W7OsMvN3gW7rWGKGS8ibdCWJepZXvfkG4CsooVGjU1ICiPxI1H+Y4obNE3CBFUTLNZY20DaEb4+yGCQ==
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com (2603:10a6:208:f3::19)
 by AS8PR07MB8358.eurprd07.prod.outlook.com (2603:10a6:20b:445::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 12:39:17 +0000
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2]) by AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2%4]) with mapi id 15.20.7897.021; Mon, 2 Sep 2024
 12:39:17 +0000
From: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, LEROY Christophe
	<christophe.leroy2@cs-soprasteria.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, Xi Ruoyao
	<xry111@xry111.site>, "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [PATCH] selftests: vDSO: Do not rely on $ARCH for
 vdso_test_getrandom && vdso_test_chacha
Thread-Topic: [PATCH] selftests: vDSO: Do not rely on $ARCH for
 vdso_test_getrandom && vdso_test_chacha
Thread-Index: AQHa+8jYVkJwiI6qkE+4TCLpqGSM7LJC7ICAgABOUfCAAHpEhYAAvZiA
Date: Mon, 2 Sep 2024 12:39:17 +0000
Message-ID: <74494efd-7cfc-4535-a33d-b86fbae1c322@cs-soprasteria.com>
References:
 <ddf594c81787dba708fc392cb03027470dee64fb.1725124064.git.christophe.leroy@csgroup.eu>
 <ZtRqp-uZe5C07qOF@zx2c4.com>
 <667622ae-dde5-410f-a9f8-4801788af278@csgroup.eu>
 <ZtSsTkTUCGyxaN_d@zx2c4.com>
 <efca582d-20e9-4871-bcd8-5abcdb0c22f3@csgroup.eu>
 <ZtUS3TecFTjE5A94@zx2c4.com>
In-Reply-To: <ZtUS3TecFTjE5A94@zx2c4.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cs-soprasteria.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR07MB4962:EE_|AS8PR07MB8358:EE_
x-ms-office365-filtering-correlation-id: f480d52b-9eca-4c83-e52d-08dccb4c429b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NUN6aDZTakJkd0xoREpKeU0vdDFmK0xBcVFlUjU4bWlqT3hlNmlUQ3NQRjNn?=
 =?utf-8?B?K2FXRXFsdzdqQ2NTUFdMME5LQ2FBMHFQK3lhWFRxdDl3REQ2V0pUUFZIcGhw?=
 =?utf-8?B?aVkrVjQwb21Pemd5N2o4VUNwNHdtWnQ2MEg0VUNwMzNQMXpSTWJ2YSsza0lp?=
 =?utf-8?B?Mkh5SUJzRDhqNSt3TXc1N3h5djQvbUtZT1FMc0hPUklrTlYzZ2locWFpbW9F?=
 =?utf-8?B?a2NUWjZEbnk5TmFXYTNyWXNmdllFa29rSnArOXlKQ0I1N3VLZnk1QUprRHRU?=
 =?utf-8?B?amh3eFpMMmFqbFBEWTFJNXkyWmZYWTdIRDZSeW9oSDh3T1gzMlJTVDVVeWRC?=
 =?utf-8?B?b1Y0K3YvVU9xMEpFUWdNbmRwcllENHR0SzhzVzRCR2Z3QjY1VlhFekVOeHpI?=
 =?utf-8?B?dW9SWm4yUS8xY2dRM3FpMXRjSVNGQjM0cmJwYzRYUmcwQ25aK1NHdDRFeDRZ?=
 =?utf-8?B?NkF2cTVyckVPR05JcXJwTStBNGd5NlR2RzhPYm13cHRhRjgzWURDdkg4SGJP?=
 =?utf-8?B?bUJ2UDVsV0FwdCtCMzlMY1F1Ykl0UEVEMmN2SFN6VWlHcGVhdWFVZWVPM01v?=
 =?utf-8?B?bEtjdDFLOWZwaE9pZXhGNXY1emM0YWFrUk0vbUFrSlVZM3g5M2FVL3dVU3lh?=
 =?utf-8?B?OTc3Q3NtcldkSU8vT1BVVXR3Q2x6bVhCQzByUXFOb0o2Y3h6Vk5kQUhDaFJv?=
 =?utf-8?B?YnFPUnZsQ1M5ZjZuOGR3RDBWbnlWcHNHc29KUWpOQlRYRzBlMlVCRmNCejRR?=
 =?utf-8?B?WEVjbHBEQWcySm9VejUwdUdwTnlFWXl3Y2orVHpxVERnUndLanMxVDJ6Ymc3?=
 =?utf-8?B?UmNrNWllRUpKQ1ppaHA1d2s2VHJPRk96MDdhYmp6REtBOXhFUkZJTEJtVHdw?=
 =?utf-8?B?R21UMHl0NzhPeHNEQ3E3dWhGZGl0NTU2VndDZFV6b25Pc3MyRWZoN25BaW1k?=
 =?utf-8?B?VmhyNHZrcGZxS2p0bFVoZndwcU9NTmVxK2JhOU5zZVVJNFJpR0IvMmhuYzBj?=
 =?utf-8?B?ZkczdVhJK1dPQjNCbTBEMEgrTWpWRHBuYUZpdG1ZWWlvRUlzLzM3Q1RSOEM5?=
 =?utf-8?B?L09sc3FudUlKbXRBSlNHTWhBdVNrZzNhWU50OWdmZXV3SVl4a2xvcUZvWjJQ?=
 =?utf-8?B?VlJOTjl0b01tcWZhcmpqSDJ4cGk0UTNKZVpaNnRZeTYxbkdRcGVDSjVIMWQ1?=
 =?utf-8?B?UURrOHBGVitmYnhCbTRmd05qVWl6SWJYU0o5clZVK2UyOXBSZHA1SGc0QUJY?=
 =?utf-8?B?RDBBd3JDSDhnbjRoRG4xQy8yT0orYUFHamxnSkZSZ1BoZXpnYU1HWHZZb0ZR?=
 =?utf-8?B?N3p2SXFsNDZCTTRkNklBRjJnWmVRcW8vbncvbkhyei9Va051WFpOS0psOFhx?=
 =?utf-8?B?Nytha3diSm01SXdlRzhrSithQm1CUGVwVnphWENTVzZGWC9sT1lKMFVTNnR3?=
 =?utf-8?B?eEpCZDBlbDE1cExFSkhkeEV0bTZFYjh4M0JIWkdEdkJlWXltclVZWU9Ucmwx?=
 =?utf-8?B?ZjJId1hFNWEwZVJRYnJTN0ltbmFRbWRxdHByQnpDbWFXdWQyV2dWUzdvcVh3?=
 =?utf-8?B?QlBHdmF1cGNMWUZ4R1BqczhRemVRa2VGTEpLanR4Q0FUVTRGcHZuQldWK0E1?=
 =?utf-8?B?aGhpbno0Y0hYRGMxemFpYkFrT3BOc1VJcW5rU3B1YjNYRlFNenY4ZW10NWZQ?=
 =?utf-8?B?TXk1T1JaTklaTVkvS3pLT0ZKNWc3YXB1cWsrbnJQamtkKzB2bURUVTNkY1NP?=
 =?utf-8?B?ZVhScFMwblFnNG5GdjMwU2FrVER0WDV3OGFkMmQ1aERDbXJLNUpOL3hsaEx5?=
 =?utf-8?B?N2dpZzlkcTJGR0RCYlByUE04WUUxWE5wTVFmUFNVTlozMDdWRDkyaVFYL2Ur?=
 =?utf-8?B?V3NOTjIzTjNJbzA5Mk1KQStaUEYzMk9EakQyNm5oRnlLSEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4962.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c1NuNnFvK1d3LzlYYm1ERGdtcUE0VVordWRKWWpJdkZiWERzd0EzQjBkRHMw?=
 =?utf-8?B?cHN0bTc1M0FUYTVIeXhreXVscVlFdmdEV0dFYS92Q0tGNEYzUEJhbzZ3Q0t4?=
 =?utf-8?B?V05iajRTK21YQ28rOHdVbmVGcnhwSWc4VUY3VE52ZGlJY1NyRHFHSnB4a3I1?=
 =?utf-8?B?YTB0cjcvazlQK055T3g2ZEFLclkrSllkYjBRa2dQN0xwc0M5Qm1jdWwyaFQr?=
 =?utf-8?B?bXNPU0tJdkdRczZiWkxXRkhyeEVtV0lscnZ5dXpOYWFzUmkxVVpYcXN2cjhr?=
 =?utf-8?B?bkZ5YUVpQVlnT09LSzVHa29HQy9uK2xpbjc0VG1rQWZsNDhQNlV5Z1M1cldo?=
 =?utf-8?B?ekhsKzBWb0ZHMFN4UnFQalhPUExZdEwvK2cyMzNBMC9XRmZNeVo5cy82QTcw?=
 =?utf-8?B?dktXSDhVdXZNZkNwTlZjNStyZmlpd0NLbjR2QzBoeEVZc0E4MUJPQTBUZ2Fx?=
 =?utf-8?B?M3RQT0VtSFBvZG9FUTJqTncwc3g3bjJoYzJKOEpaN0dtWWU0dng3WWhpMmVx?=
 =?utf-8?B?TFdwMWR5TE9OVWlMVm1tM0NOc21majVMK0duSDVMN1RKVnlQSVZGL25DV3gr?=
 =?utf-8?B?T2VHWTBzUGNIZDBzTkEwNVl4aStJN1JXbUZqNlB1SnJKakNJSmZUaWw3NXJr?=
 =?utf-8?B?WkQ2TXNQdUQzN1BpVFA4VWlvMmlwMUtGOFc2amtSWit6eXllNEZGU2s4QWZo?=
 =?utf-8?B?bFBUc1lmRS9qa1RwTUs0Y3JTQTlvelBFWDhocHBreWJ4cDNZSUdUbnNGVlpE?=
 =?utf-8?B?dktrQjN6L1NnZmY0RllFc2hKZkk1MHlrc3hxYzVoVVFoeEhaQlhnbXVQWmd3?=
 =?utf-8?B?SXFWZ2Z6UWVBSFBpblpqT3Y2T2NSZFhIZTJad0N4QUJZOE1qNEl3SlJtdEc2?=
 =?utf-8?B?SStBVDlnWWhGOUtKODhBM3B3VlliSmozSUwwc0FUdWhydXR5S3lLQm9mVjEv?=
 =?utf-8?B?MFVjU2UxekxOcFJ5UFI3bGdRMGpmY1NPMmVYUEVKM1JhMk1OTDNQU29zTFA4?=
 =?utf-8?B?a2Z3STlaV2g0ekVqdU8yZmdpYkFCR1EwYzFkZ3JJR3Bzclg3cUNaazlRTjls?=
 =?utf-8?B?UnR0SlJ1NjVQUm8rbEpIa3llRmw4T28rUm8yVmJjQVFoTjU5empDc3lWWFVm?=
 =?utf-8?B?dXZ2czUveEhPTGpzbEF4YkFuQXE0VG1RZXJEQUpvVTZpc2lkUmZqMU5WL2ow?=
 =?utf-8?B?SzNtL01sR0ZGd3M3TkpIaFpzV1hCTSszMkNhVEEyVGNMUGVwc1NyRHFjRmxu?=
 =?utf-8?B?cFU1cmM2NFlDaG05eTdzV2xLdktHL0U3Y0h5NjlyU3lBdWFnUjFqSURScURp?=
 =?utf-8?B?VGJnZzhRRVBzRElOc3l6VkVISFl2NzRXdXR1SzN0MGo5ZVdPVzYyNmxRUG1k?=
 =?utf-8?B?bEY5d1FDV21LR0plTzJWT1BqYnRaRjBMMHZmZmZEbFZQNkU1WGh1WkRsYWdz?=
 =?utf-8?B?cStaaXlsVWFqaXdzZ0NOUWxTY1AzMzI2TEdoeG1YZ1hnMHdoM2dGUXA2dkEz?=
 =?utf-8?B?YWVwWGlpNWd1L1pWSHVyZlNYbTJWRWQrTUNZUUlpS0Rqa3NxUTB4Q0Rydlls?=
 =?utf-8?B?SVhmMkxoay9vb2FPYU9EdlFMdEhjeEx6dGNBQjVuZ0lWb3RLQTFjOXM0a0N2?=
 =?utf-8?B?bldIMGxUSS9xNnZpZzVjWmVXWVdSUlVvLzYzdk9GMHE1bHhSbE45ZmhNQjN0?=
 =?utf-8?B?N0FGS1JMZDEwZ0JQT241RzFQUnp1Q3ZWWDRWZTUwRUFIMDZyWS9QWjNCUUt0?=
 =?utf-8?B?R2pKVkp1OWREczgxVmFHbzNQamJRQnBTM2ZpRjByWmtoZ1RlS2tDNVFzSGlt?=
 =?utf-8?B?Vmg2TjhRVzJ2eHg0UUtKQW03TE1yTUZTWHI2RkhFRzVhM0tYcTBkT3RoZW9u?=
 =?utf-8?B?RWNKTklva1grOHhZRTZRazU3UHNMU1pPeVRpcmVoQ3JkYnpianNiZXAyZk9R?=
 =?utf-8?B?YlFFSGNWUFJvT1JrVy84Tkg2SGJUTkQrbFRsRkEzRUN5NUQ5cGd5dmxTdzBI?=
 =?utf-8?B?ckF5N1pHWlB2cXUrS0pyTVd6OHFkcUFxTlhrUkFCRTVvZDNzTkNHNnRadlJV?=
 =?utf-8?B?aDlSSlU0RUpDN0tCeEdVay9mdXdtUm9qRHJJS2F2Z25GMFROZWNqYjRvcjBE?=
 =?utf-8?B?Ykt0ZHE5RXhEeHRuUU1vVm9WMDdiWFBxcysrcmw1aHBOQkJlL0NnUDRFYkkz?=
 =?utf-8?B?REVZYklaWmRMVVdTd3hJRVdBS1JNMUZpTUE0cDl2T05ZdUhDZE9ZTnBiUXgr?=
 =?utf-8?Q?4yLpipj1ExNBOkYn/tZYRs5+OETWeHnrXN+ziEfXTo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F6593C6BED8454EB4EEC0A4CFCF0902@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cs-soprasteria.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4962.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f480d52b-9eca-4c83-e52d-08dccb4c429b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 12:39:17.4904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b87af7d-8647-4dc7-8df4-5f69a2011bb5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tZzdmSDhQUUXYiL+uTa60t7Q2+96a7Xl8hXPwb8bCfeRISjOQBlHnsC/zW6XyjgYLsbh7KUadIulv6iczXrQTGc26LKh3dGNhirQ+JNrHHwRNsb/+eFqmyFYXAfTId1R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8358
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 04
X-MS-Exchange-CrossPremises-AuthSource: AM0PR07MB4962.eurprd07.prod.outlook.com
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-messagesource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-originalclientipaddress: 2a01:e0a:511:aad0:9f10:86ad:5cd0:9703
X-MS-Exchange-CrossPremises-transporttraffictype: Email
X-MS-Exchange-CrossPremises-antispam-scancontext: DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-processed-by-journaling: Journal Agent
X-OrganizationHeadersPreserved: AS8PR07MB8358.eurprd07.prod.outlook.com

DQoNCkxlIDAyLzA5LzIwMjQgw6AgMDM6MjAsIEphc29uIEEuIERvbmVuZmVsZCBhIMOpY3JpdMKg
Og0KPiBPbiBTdW4sIFNlcCAwMSwgMjAyNCBhdCAwODo0MzoxMFBNICswMjAwLCBDaHJpc3RvcGhl
IExlcm95IHdyb3RlOg0KPj4+PiBIb3cgd291bGQgdGhpcyBmaXQgaW4gdGhlIGxvZ2ljIHdoZXJl
IElJVUMgeW91IGp1c3QgcmVtb3ZlICdfNjQnIGZyb20NCj4+Pj4gJ3g4Nl82NCcgdG8gZ2V0ICd4
ODYnDQo+Pj4NCj4+PiBIdWg/IFRoYXQncyBub3Qgd2hhdCB0b29scy9zY3JpcHRzL01ha2VmaWxl
LmFyY2ggZG9lcy4NCj4+DQo+PiBIdW0gLi4uIHllcyBzb3JyeSBJIGxvb2tlZCBhdCBpdCB0b28g
cXVpY2tseSBhbmQgbWl4ZWQgdGhpbmdzIHVwIHdpdGgNCj4+IHRoZSBvdGhlciBwYXRjaC4NCj4+
DQo+PiBOZXZlcnRoZWxlc3MsIGlmIEkgdW5kZXJzdGFuZCB3ZWxsIHdoYXQgdG9vbHMvc2NyaXB0
cy9NYWtlZmlsZS5hcmNoIGRvZXMNCj4+IG9uIGFuIHg4Nl82NCBmb3IgaW5zdGFuY2U6DQo+Pg0K
Pj4gdW5hbWUgLW0gcmV0dXJucyB4ODZfNjQNCj4+IEhPU1RBUkNIID0geDg2IChzZWQgLWUgcy94
ODZfNjQveDg2KQ0KPj4gQVJDSCA9IHg4Ng0KPj4gU1JDQVJDSCA9IHg4Ng0KPj4NCj4+IElmIHlv
dSBidWlsZCB3aXRoIG1ha2UgQVJDSD14ODZfNjQsDQo+PiBTUkNBUkNIID0geDg2DQo+Pg0KPj4g
U28gSSBzdGlsbCBjYW4ndCBzZWUgaG93IHlvdSBjYW4gdXNlIHRoYXQgdG8ga25vdyBpZiBpdCBp
cyBhIHg4Nl82NCBvciBub3QuDQo+IA0KPiBCeSB0aGUgdXNlIG9mIENPTkZJR19YODZfMzIsIHdo
aWNoIGlzIGFsc28gdXNlZCBlbHNld2hlcmUgaW4gdGhhdA0KPiBzYW1tZSBtYWtlZmlsZSBmb3Ig
c29tZXRoaW5nIGVsc2UgKHNvIEkgYXNzdW1lIGl0J3Mgd2lyZWQgdXAgaW4gdGhlDQo+IGNvbnRl
eHQgd2hlcmUgaXQgY291bnRzLCBhbmQgaWYgbm90LCB0aGF0J3MgYSBidWcgdGhhdCBhZmZlY3Rz
IGJvdGgNCj4gc3BvdHMgYW5kIHNob3VsZCBiZSBmaXhlZCkuLg0KDQpJIGxvb2tzIGxpa2UgaXQg
aXMgYSBsZWZ0LW92ZXIgZnJvbSB0aGUgdGltZSB2RFNPIHNlbGZ0ZXN0cyB3ZXJlIGluIA0KRG9j
dW1lbnRhdGlvbi92RFNPIGFuZCB3ZXJlIGxpa2VseSBidWlsdCB3aXRoIGtlcm5lbCBjb25maWcu
DQoNCkNPTkZJR19YODZfMzIgd2FzIGJyb3VnaHQgaW50byB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy92RFNPIGJ5IGNvbW1pdCANCmY5YjZiMGVmNjAzNCAoInNlbGZ0ZXN0czogbW92ZSB2RFNPIHRl
c3RzIGZyb20gRG9jdW1lbnRhdGlvbi92RFNPIikgYW5kIA0Kd2FzIG1lYW50IHRvIHBhc3MgLWxn
Y2NfcyB3aGVuIGJ1aWxkaW5nIHZkc29fc3RhbmRhbG9uZV90ZXN0X3g4NiBmb3IgDQppMzg2LCBi
dXQgb2J2aW91c2x5IGl0IGRvZXNuJ3Qgd29yazoNCg0KJCBtYWtlIEFSQ0g9aTM4NiBWPTENCmdj
YyAtc3RkPWdudTk5IC1PMiAtRF9HTlVfU09VUkNFPSAgICB2ZHNvX3Rlc3RfZ2V0dGltZW9mZGF5
LmMgDQpwYXJzZV92ZHNvLmMgIC1vIA0KL2hvbWUvY2hsZXJveS9saW51eC1wb3dlcnBjL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL3ZEU08vdmRzb190ZXN0X2dldHRpbWVvZmRheQ0KZ2NjIC1zdGQ9
Z251OTkgLU8yIC1EX0dOVV9TT1VSQ0U9ICAgIHZkc29fdGVzdF9nZXRjcHUuYyBwYXJzZV92ZHNv
LmMgIC1vIA0KL2hvbWUvY2hsZXJveS9saW51eC1wb3dlcnBjL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL3ZEU08vdmRzb190ZXN0X2dldGNwdQ0KZ2NjIC1zdGQ9Z251OTkgLU8yIC1EX0dOVV9TT1VS
Q0U9ICAgIHZkc29fdGVzdF9hYmkuYyBwYXJzZV92ZHNvLmMgIC1vIA0KL2hvbWUvY2hsZXJveS9s
aW51eC1wb3dlcnBjL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3ZEU08vdmRzb190ZXN0X2FiaQ0K
Z2NjIC1zdGQ9Z251OTkgLU8yIC1EX0dOVV9TT1VSQ0U9ICAgIHZkc29fdGVzdF9jbG9ja19nZXRy
ZXMuYyAgLW8gDQovaG9tZS9jaGxlcm95L2xpbnV4LXBvd2VycGMvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvdkRTTy92ZHNvX3Rlc3RfY2xvY2tfZ2V0cmVzDQpnY2MgLXN0ZD1nbnU5OSAtTzIgLURf
R05VX1NPVVJDRT0gIC1sZGwgIHZkc29fdGVzdF9jb3JyZWN0bmVzcy5jICAtbyANCi9ob21lL2No
bGVyb3kvbGludXgtcG93ZXJwYy90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy92RFNPL3Zkc29fdGVz
dF9jb3JyZWN0bmVzcw0KDQpJbiBhbm90aGVyIHBsYWNlIGluIHNlbGZ0ZXN0cyAodG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvaXBjLyksIHRoZXkgDQptYW51YWxseSBhZGQgaXQ6DQoNCmlmZXEgKCQo
QVJDSCksaTM4NikNCiAgICAgICAgIEFSQ0ggOj0geDg2DQoJQ0ZMQUdTIDo9IC1EQ09ORklHX1g4
Nl8zMiAtRF9faTM4Nl9fDQplbmRpZg0KaWZlcSAoJChBUkNIKSx4ODZfNjQpDQoJQVJDSCA6PSB4
ODYNCglDRkxBR1MgOj0gLURDT05GSUdfWDg2XzY0IC1EX194ODZfNjRfXw0KZW5kaWYNCg0KDQpT
byBJIHRoaW5rIHRoaXMgaXMgYSBjb25maXJtYXRpb24gdGhhdCBDT05GSUdfWDg2XzMyIGRvZXNu
J3QgZXhpc3QgaW4gDQpzZWxmdGVzdHMuDQoNCkNocmlzdG9waGUNCg==

