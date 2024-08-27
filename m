Return-Path: <linux-kselftest+bounces-16405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCBE960D29
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 16:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D1051C22B62
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 14:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977D51C3F29;
	Tue, 27 Aug 2024 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b="zpUGHyA4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA6F1E49E;
	Tue, 27 Aug 2024 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724767684; cv=fail; b=uOdhLFdsOBvcU6TUXCXzU+TRe5IRFHrskmjM9vrnYFXbKI6jQUo9qEyEUzRbI7N5uMjQH2K8RXsCbgx5YWhBjaxVUcA4TQJvouo+hUa9Q6+LXHXYgkK2AFnd/gGjrOULojs/OYcdnohvXkulhUObRtgkXqlQKj5Jxj1eMuDjkJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724767684; c=relaxed/simple;
	bh=oxXiopKonJ3RBQCBNMFEkYGF4aEPGNGqsx4fJt//4SA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nkm4NS5tfmdUZ0J8ATSdpnOnscKEWPu7oS7GWEirDPixUeAwpkBa+3bO00ngFShu6jsn9q0isO7jOfki2n/GtRIK6t1a4NR/OoKdOfVIZ+xiyH/LwQ+jcJ95sY4X8VfCHpeciMzrmDIMWJGewp80Gvk8te96PzJ87G9xmQWRTJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com; spf=pass smtp.mailfrom=cs-soprasteria.com; dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b=zpUGHyA4; arc=fail smtp.client-ip=40.107.20.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs-soprasteria.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LrJwJXuoeT9OtVUB9qlj9yYcLj6VCK0bJGUrHStL22Vd9DRnm2XewCxWQazXltVp+/6H85df1bRu4Fe3YFOiomM6Jvrnr8sSWZNKaUJaKapkTen9qtoBQoj73UV3bEvDHNmRIn/7hR7+fQb5FQ9DBikz46/sbtA812DNqHCuQurHS9IruiYhJj8atHEkfiH3QAuGvmowfSmfwjUzyZtTYp/6IEadYWKHcpx/HDnmAjauT79ndeAVi2+kIWixjTS7yKBlPs8QyIeeu1TvkuZdzfPcYh+gBPen4bdOZPzVz5BNJSzxiuEi/J0WGX/asEF28Oqs0qZdCQPBugx+fsUmvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxXiopKonJ3RBQCBNMFEkYGF4aEPGNGqsx4fJt//4SA=;
 b=n4Bn5GWVCtik74cbrOIbqtOa5cwt68uHoXkQ0jBoqGom46T9F119StHsv/vGcFPEf1AxBRF3lZe4/wltpGvv236SqxP2oaFN+4o9PDtnLhk4zm3iW4jRxmQ0tdVQYWaIO7uJspspD7vc3fBfn5UlMnOB9Y2oFn0OfXLfnimPBCrNtBrx7YXKS6WMMn/PT/l+6Gv48E82/pvGoOJG4etT8DNbU1hBIg6o6yMfCYz5y02Ranft6vZuEkufcsRtWjKuOkmoDUsEpdsGCfg77aNNxBJVkJAmukPmWPGmt2/a4zkGZuqbec4gpP7OoX2LCNecHGJr/mvNT8z1EMF++GCy9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs-soprasteria.com; dmarc=pass action=none
 header.from=cs-soprasteria.com; dkim=pass header.d=cs-soprasteria.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs-soprasteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxXiopKonJ3RBQCBNMFEkYGF4aEPGNGqsx4fJt//4SA=;
 b=zpUGHyA44DonY7SE4DQmiE20voqLot9Lfr52oVAint1/k4ILSlCllZwPH5ifhizTQD+YP3WkEizbSQXeV1laZE1wZmLu58XuGgBxpK48R9bmDXjp1Pl+dfRJSxPYzu6wxB5F73LzWhYvgDoWz+D7ZwSl0CsF4SoRQwJaCWD+w8aYEqnGuT5Z5+RH+YQeW8oSwK9hZjC1O/iKBGj5EOlCD/Iy5ziCxi+rZd80zYq5dgaNTdSqNhBBzbQOXwN2fAv4FefTpDOOkUevF2qoaJR40sLSEOvEEwmIcYJAwKKUJCe+c33AcAd/KMhzDqYxVhebyCAPSqzl9TLVckSdSdxp+w==
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com (2603:10a6:208:f3::19)
 by AS8PR07MB7733.eurprd07.prod.outlook.com (2603:10a6:20b:350::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 14:07:59 +0000
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2]) by AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 14:07:59 +0000
From: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, Xi Ruoyao <xry111@xry111.site>
CC: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, Jinyang He
	<hejinyang@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>, Arnd Bergmann
	<arnd@arndb.de>, LEROY Christophe <christophe.leroy2@cs-soprasteria.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] selftests/vDSO: Use KHDR_INCLUDES to locate UAPI
 headers for vdso_test_getrandom
Thread-Topic: [PATCH v4 3/4] selftests/vDSO: Use KHDR_INCLUDES to locate UAPI
 headers for vdso_test_getrandom
Thread-Index: AQHa+IlDZBvC5l2urUWOj88BNmT4CbI7I/cA
Date: Tue, 27 Aug 2024 14:07:59 +0000
Message-ID: <019268d4-c177-49e7-aab3-b8fa431905ca@cs-soprasteria.com>
References: <20240827132018.88854-1-xry111@xry111.site>
 <20240827132018.88854-4-xry111@xry111.site> <Zs3blfx1inX_FQLR@zx2c4.com>
In-Reply-To: <Zs3blfx1inX_FQLR@zx2c4.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cs-soprasteria.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR07MB4962:EE_|AS8PR07MB7733:EE_
x-ms-office365-filtering-correlation-id: a0d31dbd-7b3b-45fb-e971-08dcc6a1a839
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dnBGQ3YxejVRb3hqc1VJTlVFVlZtMURPWWxPU2J6dk1lKzdySHdDN2UzWHZq?=
 =?utf-8?B?Vy9CbllTMkhleFd1dkNud1pyOE1QNDhTc1RpQ1BHMGUzQlFCVlpxbVVXaU1S?=
 =?utf-8?B?dDFvaW5qMi80L0w5VXlUR1NLRWc5a1RnWUZjN1FqVnYrWG10N1NrKzJFaEZD?=
 =?utf-8?B?anZCMEtKdWhVcXcwYk9QU05nblVEL3Y3STFUc00rTklGVlh3cGVOV1BpQ1hs?=
 =?utf-8?B?d29tM1BBdU5FMG5OMEgwOHRJMmV4aExWTWJmMWhReGdTNVVMNDRhclVqRGx4?=
 =?utf-8?B?T3VKd1RQOC8wNkY1UlVoY1BKWWt5b3VsOVpZTGxTOEo3S0ZZcm5YWDQ2eW0w?=
 =?utf-8?B?c014RWtDVndWcExNc3JiOWhMVTNpN1JVRTl1ZWZxL3pPZWk0VVppdGNwdWNB?=
 =?utf-8?B?MTRUdzA5VnNNdkdVaDQzZlhkMDJEKzV4UkJiTVRuaXNzTUs5RHA4bEtzc0hU?=
 =?utf-8?B?bEsvYzZhak1kOUNlTEFNTVdqalFJd2xGYkVtcHFFdVliemlNQ0J2VGlERFJm?=
 =?utf-8?B?anRRcFZoS1N5L3FxVmp3UWtCazNIcW9CenhrczR0cXl0VzJETXlwMEx3T0ZE?=
 =?utf-8?B?UWpTVGlpaDNPcEhZcHJiWVc1eUoyTEZ1Qm54MkFBdG9pREJneS9NYXZ3aXhH?=
 =?utf-8?B?K3lZY3MrNXFTRFdhWmlzanRpcWQxOHJnbFpmYk45c1pXTDhpMURZZHVEZGVT?=
 =?utf-8?B?QktLRkg4dTZ4NlpOZ3cwZkc3UkhGcGx0MWRvd0c0TkE5YS8yNjIxZzlCa2pT?=
 =?utf-8?B?ZFVmTWNIenJha2JXNDZrL0FFZ0xER0dLNUxXNkU4Z2w3cnNHQVg0elczY0ls?=
 =?utf-8?B?VTQzMURIdWYzZUgraDMyYWhva1A0ZzNWY2g1b3RjbVY0RUp0QjBHczZRVWF2?=
 =?utf-8?B?UUNhZDM5N2R5a2xJRlFnejl4akVtbTFGbDN1b2p2bmZvemNtcTV3aUpRZ2Nz?=
 =?utf-8?B?TlluZENqNGNyMWJlMmwrM3liSExsWHFWQnNVYzhxTTZJSVJZdzVhai8yYm5W?=
 =?utf-8?B?QW8vY3BBcytDUlBFMkpneXkwQ0JXM2dKMzZzWERMWDRlVUhkOEY2TTRSdHA1?=
 =?utf-8?B?Z1NCQm1xK2daVVNZdlhKdWhtWUE3YS9Pb0M2UjlsOHo3T0hEc1NEMW1xRVB3?=
 =?utf-8?B?Qk9KRlVBRmhOVEFRSXJoaHFOeHFGMUZLdUFuZWUxVEM3cjRIMk9xOGJYWmhO?=
 =?utf-8?B?NmgwZnp4WklwY2xWdGh2Q1FUeldaMVhxV3lpN01iSVlBQmR4UzQ4V3JWWkQr?=
 =?utf-8?B?OXVwNlFvWjdZK2RuTFFSdTFNMGUrc0c0cGtZMEZ3c1h4NjBVcU9GMUVjdXM3?=
 =?utf-8?B?THpQVXF5dExUWWRINmlPSFo1UElVLzU1QVp4Sjd0eGcvWlNpM1FtaEtWSXNi?=
 =?utf-8?B?Q01DR1dyeUMyaEYvL3lQUU1RYUdyd0xoSlRwY0Z1QzVtR3FtdU1WNk5KWEJC?=
 =?utf-8?B?RkFyQXpWdW1SNzBtNkQ1My8xZGVoWklGWjhheVVsbUk4Umpwb0g1TGVKM2R1?=
 =?utf-8?B?cU43ZXljL1g2ZVhWN2ttbXlKTFhlWkk3aFJzb1JVMWo4QXJPU094MXFtV0c0?=
 =?utf-8?B?M29MWkpidzR1NitwR3ZYVWlPRUo4RHhvT3BiQmVxLzRqQnEyU0g1VktZWjdL?=
 =?utf-8?B?ZEZBN3dQNGtaa0V1bzJ3dGNmUWN3R2R6aUcyODdrNWRjWld0UlV3Qzd5bkxB?=
 =?utf-8?B?Smo4VUdpaW9CTVQ3RllZM1pRMjlVakNZRUVLdlgvamhUd2hFNmV6NnYwRkdN?=
 =?utf-8?B?T3JpbzZtSnRDTUkrdlVyS1ZlRXBFaXJJZzloWTVWajRlRjN5bUhkQTNyUFBI?=
 =?utf-8?B?M084RHlJWG1CcGkxd0kxc1UwY1lTVFNsR3pqZ1hEWEt4SHEzWWNBL3hKZHdE?=
 =?utf-8?B?cjB5aEdpM0NBd3YyeHpkMEVjbjFuLzZVd2dXV3dPcEMrenc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4962.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?czBKakNPbGNQRHYyYk0vTmZLNVE0Qm03VTlZK3NMS2sxVENXOThzRjdUcWpN?=
 =?utf-8?B?QXdJTjVwZDZKN0hldENmVnlGQ3JKQlRLVWdRcDlRUmpIM2tJbU4xM1lYWlVn?=
 =?utf-8?B?V1dUTHAxdnZNQ0VnZSsyVlZWaXV5OE1nYVV4YkdyY1FPMDB5dWdPS0QwUUNX?=
 =?utf-8?B?UjRuVlNxZ0RBd1FCbXVmUEFFU3JHRDBxQjJEVy9MQlNEMmkvRCtvai9MWVVG?=
 =?utf-8?B?UDdKbU9SNWhJSlM4ODN5VzJtalEyRk1oOHJWOUZGQ25ZTktrZm11SkxRaW1Q?=
 =?utf-8?B?TUhwd1JIdVErR0haK2Jwa0xxMHc2Ujh4NTZPWnlvODRpVGtXRU9wd0RtVzVs?=
 =?utf-8?B?Z05GV0x0Mm12ZmdwL0hNaDlRaEk2OE5iaWJSanVIS1VtWjZDQ2hLZmZzUVNI?=
 =?utf-8?B?ZUlUdnNzWEcvUDJRQmsvaVBLRmlLbytLZE44b1NtV0ZrQWVlRzVEdGFLNEJR?=
 =?utf-8?B?SjRvcWdGOWZRMUJpOGVHV3JUR0JmRXl6OUQ4YkdXeVZKSXo2Kzg3YW5lQnVr?=
 =?utf-8?B?TEY5cEVoU2pNMFBhbEFiSWtyS3pSV1dYOWVnYnQxRGlNNWZVQ3NTZ3o3TGx3?=
 =?utf-8?B?US8za3c1UVo0bWZKc25CdnlTUVNFczdIZkx0dng4WVlNOGF3eEIzZ2ZtSE1p?=
 =?utf-8?B?UDRmbi9LL1c5TERNdkZHVXhta1BtdFc1dE5OQ1dXVE5EVmJJN0hLN1FiVEx0?=
 =?utf-8?B?UFlkMXc1SXdPNm9BZmhnNjZUV2ZXWm4rWUdmcmxpaHZxR0t5dHZQWVA4NWE1?=
 =?utf-8?B?ZjNFWXg0Y013MEl4ZVRrY2VKc0VJbmMvYmtmZ3hlVTZRMnhIcmtwazhhcVVZ?=
 =?utf-8?B?aTE2U1F6bzhwNlM2NTJ3amNPbEJ4NHBJdlR5dHJtTVpGTGpwL1pvVWF4N0Zw?=
 =?utf-8?B?K05aZ3F1d1ErS3VvcGxMVW5EU1FocFB0a3l1MkZmOE5QT0FBdWpwRWhVbjF5?=
 =?utf-8?B?Z051bXIwSEREZUJNMnRPWGlSMXZUSkZKR0FPclV4clQ2eWZXeGJ2emRMZGhW?=
 =?utf-8?B?ZVd3MnJHYlVHRFFnck1KMHBmNUxpTjNGSllSaTJMMEh1ZEJoM0Z5VVZFYmR0?=
 =?utf-8?B?OXpOaHFjYVgyVFRXWUpSejd2UC9OVkpsNXdCUDhOQU9nVDFIUUJWNkxGYWRD?=
 =?utf-8?B?NXlRS0hrVXIySmg3MTRHaG9xS1N6WUowdFY2MHZxMVRuNVVSbFhSVkFTM2E5?=
 =?utf-8?B?ejBweHNsR0FJeEx6TVM1dTEybWxJNWxWd0M5eGlYVWY4SkpqWEI2WkE1cTFw?=
 =?utf-8?B?NVJ2Zkp3c2VYdmZpVVlzbmxwSU9vanJWVy90UWtPTUFyZmNUV2JISXpEVXVy?=
 =?utf-8?B?ZVFBQmt4TVpMNGVuQkVJcVRkSWViL2ZkN3ZOQjl0WXhSMEN0NS8yL0oxMUsz?=
 =?utf-8?B?dWhldFRwaWZsZ0MwVnhLMVEwN2xGMUFrRFI2ZjZVQkNQbk1DNFRoY3ZpL2tF?=
 =?utf-8?B?cHpFK3pTVUI1NWRtOTI5WXRMVzY3b0lJQThGVFo5WW4rZTdCZEpLK0RVY1gr?=
 =?utf-8?B?ZXRKY0crM2taS1NNY2kySzc3MWtna0xpV3BvWkRmWTVSR1g5WkpJaDlJZWI4?=
 =?utf-8?B?bktPVzBKZ05IbW1PMTRkZUpTVGtoWGI2SWRmVVZrbGFBUE9WTG5ZWE9LODVU?=
 =?utf-8?B?Ynh0MDgvVTFVKzVLaUdiaTlFUlFESEpINGxzYkViUEo3dnBlL21LU0RDYkNM?=
 =?utf-8?B?Rnl6MjdHNWNDbnB6VytWOVFrSmVXSW9iWEpFY1AreDdNZzNMTkFOSUNFL3JU?=
 =?utf-8?B?K3NzUEpsM0h1MGhyR3habUxFUURQdSswd2hkY3pocUZ4TUZVQ2ZYWkphWHlD?=
 =?utf-8?B?MGxtZE81Q2hCMy9tekgrL3JHQitidWs1T0E5aTNna2FJY2s3ZHJqRHh3NjV6?=
 =?utf-8?B?U0NpMVlSY1REZzFqT2pBd1dLREZDTzBFWkpORElaQ04yWUdoUXlmRElBaCtB?=
 =?utf-8?B?dCtTRDMzOWhvK0tINTd4ajYvSU16VmJocjJBenpVWjlpbGZuK0d3bmhBOVJp?=
 =?utf-8?B?SnVWVTNWWGJjdHBhUVBsbUVQNU5xT2JJbkRYcG1RNEg4ckdueWc3NVNzRkZB?=
 =?utf-8?B?dFovZUZEQTVvMHl0VWtoZmQzeXVWTkYycjczdmg0aXBFTXNkd2c0UG9WVnlO?=
 =?utf-8?B?NW9PckgrWmIzNHlEOG1UNWxTcEJ1YnJERWk5K1NLM252NXcvclJ2d1JET216?=
 =?utf-8?B?V1A3Y29iK0t3UUljc1hvSlNnMHpTOURCK0tqcnAyc3c2ZC9lKzlkWFJqNWly?=
 =?utf-8?Q?hRZjX2xICIwU1UXoWmvbXSGZwT9RXnVdEpDYr7MSLY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EFA7EB37D360A49BEE5950530638F4D@eurprd07.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d31dbd-7b3b-45fb-e971-08dcc6a1a839
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 14:07:59.3991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b87af7d-8647-4dc7-8df4-5f69a2011bb5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kd0GeytTLUa0XBi2zZNSSJu2Fo02gpH9XwvxvUTQY1qyPTb3zU61p/0zKSxMWqgE9h/NbAfUVi66Q16SAxTSgG4UiEuXTcV90e0BAx563aJnx1D+79qIRlYs58ms9h33
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7733
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
X-OrganizationHeadersPreserved: AS8PR07MB7733.eurprd07.prod.outlook.com

DQoNCkxlIDI3LzA4LzIwMjQgw6AgMTU6NTgsIEphc29uIEEuIERvbmVuZmVsZCBhIMOpY3JpdMKg
Og0KPiBPbiBUdWUsIEF1ZyAyNywgMjAyNCBhdCAwOToyMDoxNlBNICswODAwLCBYaSBSdW95YW8g
d3JvdGU6DQo+PiBCdWlsZGluZyB0ZXN0X3Zkc29fZ2V0cmFuZG9tIGN1cnJlbnRseSBsZWFkcyB0
byBmb2xsb3dpbmcgaXNzdWU6DQo+Pg0KPj4gICAgICBJbiBmaWxlIGluY2x1ZGVkIGZyb20gL2hv
bWUveHJ5MTExL2dpdC1yZXBvcy9saW51eC90b29scy9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyX3R5
cGVzLmg6MzYsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgZnJvbSAvaG9tZS94cnkxMTEvZ2l0
LXJlcG9zL2xpbnV4L2luY2x1ZGUvdWFwaS9saW51eC9zdGRkZWYuaDo1LA0KPj4gICAgICAgICAg
ICAgICAgICAgICAgIGZyb20gL2hvbWUveHJ5MTExL2dpdC1yZXBvcy9saW51eC9pbmNsdWRlL3Vh
cGkvbGludXgvcG9zaXhfdHlwZXMuaDo1LA0KPj4gICAgICAgICAgICAgICAgICAgICAgIGZyb20g
L3Vzci9pbmNsdWRlL2FzbS9zaWdjb250ZXh0Lmg6MTIsDQo+PiAgICAgICAgICAgICAgICAgICAg
ICAgZnJvbSAvdXNyL2luY2x1ZGUvYml0cy9zaWdjb250ZXh0Lmg6MzAsDQo+PiAgICAgICAgICAg
ICAgICAgICAgICAgZnJvbSAvdXNyL2luY2x1ZGUvc2lnbmFsLmg6MzAxLA0KPj4gICAgICAgICAg
ICAgICAgICAgICAgIGZyb20gdmRzb190ZXN0X2dldHJhbmRvbS5jOjE0Og0KPj4gICAgICAvaG9t
ZS94cnkxMTEvZ2l0LXJlcG9zL2xpbnV4L3Rvb2xzL2luY2x1ZGUvbGludXgvY29tcGlsZXItZ2Nj
Lmg6MzoyOiBlcnJvcjogI2Vycm9yICJQbGVhc2UgZG9uJ3QgaW5jbHVkZSA8bGludXgvY29tcGls
ZXItZ2NjLmg+IGRpcmVjdGx5LCBpbmNsdWRlIDxsaW51eC9jb21waWxlci5oPiBpbnN0ZWFkLiIN
Cj4+ICAgICAgICAgIDMgfCAjZXJyb3IgIlBsZWFzZSBkb24ndCBpbmNsdWRlIDxsaW51eC9jb21w
aWxlci1nY2MuaD4gZGlyZWN0bHksIGluY2x1ZGUgPGxpbnV4L2NvbXBpbGVyLmg+IGluc3RlYWQu
Ig0KPj4gICAgICAgICAgICB8ICBefn5+fg0KPj4NCj4+IEl0J3MgYmVjYXVzZSB0aGUgY29tcGls
ZXJfdHlwZXMuaCBpbmNsdXNpb24gaW4NCj4+IGluY2x1ZGUvdWFwaS9saW51eC9zdGRkZWYuaCBp
cyBleHBlY3RlZCB0byBiZSByZW1vdmVkIGJ5IHRoZQ0KPj4gaGVhZGVyX2luc3RhbGwuc2ggc2Ny
aXB0LCBhcyBjb21waWxlcl90eXBlcy5oIHNob3VsZG4ndCBiZSB1c2VkIGZyb20gdGhlDQo+PiB1
c2VyIHNwYWNlLg0KPiAgIA0KPiBIbW0uIElmIEkgcnVuIHRoaXMgb24gbXkgY3VycmVudCA2LjEw
LWJhc2VkIHN5c3RlbSwgSSBnZXQ6DQo+IA0KPiAkIG1ha2UNCj4gICAgQ0MgICAgICAgdmRzb19z
dGFuZGFsb25lX3Rlc3RfeDg2DQo+ICAgIENDICAgICAgIHZkc29fdGVzdF9nZXRyYW5kb20NCj4g
dmRzb190ZXN0X2dldHJhbmRvbS5jOjQzOjQxOiBlcnJvcjogZmllbGQg4oCYcGFyYW1z4oCZIGhh
cyBpbmNvbXBsZXRlIHR5cGUNCj4gICAgIDQzIHwgICAgICAgICBzdHJ1Y3QgdmdldHJhbmRvbV9v
cGFxdWVfcGFyYW1zIHBhcmFtczsNCj4gICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIF5+fn5+fg0KPiANCj4gQmVjYXVzZSBLSERSX0lOQ0xVREVTIGlzIC91
c3IvaW5jbHVkZSBpbnN0ZWFkLg0KPiANCj4gQ2hyaXN0b3BoZSwgYW55IHN1Z2dlc3Rpb25zIG9u
IHRoaXMgb25lPyBBbmQgYW55IGlkZWEgd2h5IGxvb25nYXJjaCBpcw0KPiBoaXR0aW5nIGl0LCBi
dXQgbm90IHg4NiBvciBwcGM/DQo+IA0KDQoNCkNhbiB5b3UgJ21ha2UgY2xlYW4nIHRoZW4gcHJv
dmlkZSB0aGUgb3V0cHV0IG9mICdtYWtlIFY9MScgPw0KDQpPbiBwb3dlcnBjIEkgZ2V0Og0KDQok
IG1ha2UgIEFSQ0g9cG93ZXJwYyBDUk9TU19DT01QSUxFPXBwYy1saW51eC0gDQpTT0RJVU09Ii1J
L3RtcC9zb2RpdW0vdXNyL2xvY2FsL2luY2x1ZGUvIC1ML3RtcC9zb2RpdW0vdXNyL2xvY2FsL2xp
Yi8gDQotbHNvZGl1bSIgVj0xDQpwcGMtbGludXgtZ2NjIC1zdGQ9Z251OTkgLURfR05VX1NPVVJD
RT0gICAgdmRzb190ZXN0X2dldHRpbWVvZmRheS5jIA0KcGFyc2VfdmRzby5jICAtbyANCi9ob21l
L2NobGVyb3kvbGludXgtcG93ZXJwYy90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy92RFNPL3Zkc29f
dGVzdF9nZXR0aW1lb2ZkYXkNCnBwYy1saW51eC1nY2MgLXN0ZD1nbnU5OSAtRF9HTlVfU09VUkNF
PSAgICB2ZHNvX3Rlc3RfZ2V0Y3B1LmMgDQpwYXJzZV92ZHNvLmMgIC1vIA0KL2hvbWUvY2hsZXJv
eS9saW51eC1wb3dlcnBjL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3ZEU08vdmRzb190ZXN0X2dl
dGNwdQ0KcHBjLWxpbnV4LWdjYyAtc3RkPWdudTk5IC1EX0dOVV9TT1VSQ0U9ICAgIHZkc29fdGVz
dF9hYmkuYyBwYXJzZV92ZHNvLmMgDQotbyAvaG9tZS9jaGxlcm95L2xpbnV4LXBvd2VycGMvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvdkRTTy92ZHNvX3Rlc3RfYWJpDQpwcGMtbGludXgtZ2NjIC1z
dGQ9Z251OTkgLURfR05VX1NPVVJDRT0gICAgdmRzb190ZXN0X2Nsb2NrX2dldHJlcy5jICAtbyAN
Ci9ob21lL2NobGVyb3kvbGludXgtcG93ZXJwYy90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy92RFNP
L3Zkc29fdGVzdF9jbG9ja19nZXRyZXMNCnBwYy1saW51eC1nY2MgLXN0ZD1nbnU5OSAtRF9HTlVf
U09VUkNFPSAgLWxkbCAgdmRzb190ZXN0X2NvcnJlY3RuZXNzLmMgDQotbyANCi9ob21lL2NobGVy
b3kvbGludXgtcG93ZXJwYy90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy92RFNPL3Zkc29fdGVzdF9j
b3JyZWN0bmVzcw0KcHBjLWxpbnV4LWdjYyAtc3RkPWdudTk5IC1EX0dOVV9TT1VSQ0U9IC1pc3lz
dGVtIA0KL2hvbWUvY2hsZXJveS9saW51eC1wb3dlcnBjL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
Ly4uLy4uLy4uL3Rvb2xzL2luY2x1ZGUgDQotaXN5c3RlbSANCi9ob21lL2NobGVyb3kvbGludXgt
cG93ZXJwYy90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy8uLi8uLi8uLi9pbmNsdWRlL3VhcGkgDQog
ICAgdmRzb190ZXN0X2dldHJhbmRvbS5jIHBhcnNlX3Zkc28uYyAgLW8gDQovaG9tZS9jaGxlcm95
L2xpbnV4LXBvd2VycGMvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdkRTTy92ZHNvX3Rlc3RfZ2V0
cmFuZG9tDQpwcGMtbGludXgtZ2NjIC1zdGQ9Z251OTkgLURfR05VX1NPVVJDRT0gLWlkaXJhZnRl
ciANCi9ob21lL2NobGVyb3kvbGludXgtcG93ZXJwYy90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy8u
Li8uLi8uLi90b29scy9pbmNsdWRlIA0KLWlkaXJhZnRlciANCi9ob21lL2NobGVyb3kvbGludXgt
cG93ZXJwYy90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy8uLi8uLi8uLi9hcmNoL3Bvd2VycGMvaW5j
bHVkZSANCi1pZGlyYWZ0ZXIgDQovaG9tZS9jaGxlcm95L2xpbnV4LXBvd2VycGMvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvLi4vLi4vLi4vaW5jbHVkZSANCi1EX19BU1NFTUJMWV9fIC1EQlVMSURf
VkRTTyAtRENPTkZJR19GVU5DVElPTl9BTElHTk1FTlQ9MCANCi1XYSwtLW5vZXhlY3N0YWNrIC1J
L3RtcC9zb2RpdW0vdXNyL2xvY2FsL2luY2x1ZGUvIA0KLUwvdG1wL3NvZGl1bS91c3IvbG9jYWwv
bGliLyAtbHNvZGl1bSAgICB2ZHNvX3Rlc3RfY2hhY2hhLmMgDQovaG9tZS9jaGxlcm95L2xpbnV4
LXBvd2VycGMvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvLi4vLi4vLi4vdG9vbHMvYXJjaC9wb3dl
cnBjL3Zkc28vdmdldHJhbmRvbS1jaGFjaGEuUyANCiAgLW8gDQovaG9tZS9jaGxlcm95L2xpbnV4
LXBvd2VycGMvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdkRTTy92ZHNvX3Rlc3RfY2hhY2hhDQok
DQoNClRoYW5rcw0KQ2hyaXN0b3BoZQ0K

