Return-Path: <linux-kselftest+bounces-32730-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B427AB0B82
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 09:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC11A1BC4AA6
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 07:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE1F255F59;
	Fri,  9 May 2025 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LXEhy5AV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3874221CA10;
	Fri,  9 May 2025 07:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746775316; cv=fail; b=qg9pCSvKb5XBh/20L2T4vlEdewH87x8GcQ1vQZkm2f+UPAoosPiyD57NO8A5j4SHoeA4/meSB3mfPW2tJQEMLzKktB58vtouQj97Qs6CSqUWJCgl6Ev/3eM4gDc1fLyxBPj4URxouhOvEzvUx5GNM6UIE9HJoYxjpsRFhvkrnvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746775316; c=relaxed/simple;
	bh=ksXWhiaGp7lUB36j+Ydzg78lg2w1yIaGYf2si5950Eg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X9bBJiRCB/xuCcEPhmaH3LkaJqu0TrADI6GfG1BNnEIlzPnTncZ6+1LGJfOlduUq7vioZYJV1N5flOTt6u/1zhUwtArKrcNEkIdz9EUwBydYPn+ZgLAzaLrbVZfvylw2l+TKCvZ5P2N1ypIc38h52CcrH/Sq0JwYtHGZFSSw3ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LXEhy5AV; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVaBK9qc1QCA8ubM31uE5qcyGjdFY7W/kh5Esn+R4yfQHGs6oGjEdDSyX2qRy0DRNSmQL4/Olkt+jGlLQEx0pu8SCaicH06s+ermOJo2QV8zFr/bkNhcJ5eZRTp1j9H+68IWLbBSq4vp6qrZc2s8npGNcsOVNu9EkeOPYvQE0vDpfbtphQpekhGxUWcxUtl0UPE8ITB78buZQ3eU40GbYbUx6Nyjqq/460b26CSs7IETjRSnt0dsc/SX86+njyOUJZcR8GcKTOWq7vzJCAL1tm+I7ok9Crtwz6gazYjPpWmYEqDwWZGKS+64CYRaILsjjcnbfNOahktZE0ayz+70yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksXWhiaGp7lUB36j+Ydzg78lg2w1yIaGYf2si5950Eg=;
 b=F3XbnM+84yZeghU02L6C1yi7/E43Ql6wBaQYHuiZ03FXZYkpbs7s4n6AbWPA7+z0S39O6aEAArTJCSKMyXglei945i4LxZPxAMtHse6pSdt+yrYF2zKFzMUzq8Nc7Jlmr74QkWS86DE8k1Upbe5PulScqNaZOH1upWmT30+rlznXImFCfadAl8rQ5Avg8oKBuSTPq4UqlsJUh3DX23qTekr2MvDwWXHL5Gha0SFyN7/uajsEEVr7tNoCQLtuCsobSw6gNrWtkzgRdW3lXsnipXtx0AyQNxWAGpWTh+YDVs3mcfaVFg9CMcBpePcpz6H6Tq79q+ycYkrJH2VlRqR40A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksXWhiaGp7lUB36j+Ydzg78lg2w1yIaGYf2si5950Eg=;
 b=LXEhy5AVBbz9iNh9QZ0C3rjYjQEhxq35ifdw35jqXy6Vs5JZlvoMly+RXEb4VJ8oKxOJr5/3jUwjmJ/36fzNdDiEdfl3CZDuPZAPl97zHF9ht6plRwYZune80IGHuij8e7VpHSrb4NTAZAj/8VP301lYoaViLZ+d92NxBYEt0GuEcZ9916Mbe+6k5befHY/qIlOqMukGpcrk263Sr5kDjLmG3oR3LntqvE+uLSmU5x07ntYR/CmiU85KFPbDTLTmszkGjWNzkRx/stgw3CX3mEM9V7KvpdOUmSscR6KfpFZ4cjYEfbA36Eh5sy7LoELECK6L10GW615KjCq/auypGg==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by CH3PR12MB8710.namprd12.prod.outlook.com
 (2603:10b6:610:173::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 07:21:45 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::a991:20ac:3e28:4b08]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::a991:20ac:3e28:4b08%6]) with mapi id 15.20.8655.033; Fri, 9 May 2025
 07:21:45 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "jdamato@fastly.com" <jdamato@fastly.com>, Tariq
 Toukan <tariqt@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "sdf@fomichev.me" <sdf@fomichev.me>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "almasrymina@google.com" <almasrymina@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH net v2] tests/ncdevmem: Fix double-free of queue array
Thread-Topic: [PATCH net v2] tests/ncdevmem: Fix double-free of queue array
Thread-Index: AQHbv/WIgVX6+V0IbkCpxG+F980BrbPJDuUAgADXN4A=
Date: Fri, 9 May 2025 07:21:45 +0000
Message-ID: <86045fadea030cb8c925c09942ebc5cb164a0f85.camel@nvidia.com>
References: <20250508084434.1933069-1-cratiu@nvidia.com>
	 <aBz4fjK8bPKG3KLM@LQ3V64L9R2>
In-Reply-To: <aBz4fjK8bPKG3KLM@LQ3V64L9R2>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|CH3PR12MB8710:EE_
x-ms-office365-filtering-correlation-id: 8668f277-4910-4d64-330c-08dd8eca2756
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?QkZKeXFkTzVSZGg5T1MwVGlRRDRHcXM5UHoySTlNQ3dKMFc4OExiNXZLVjVT?=
 =?utf-8?B?U25BVVV0RzlDOVd0STk4ZlM2dk1hTC9vSzlxNDVqN0NpSkZBY3dyMVVpY0hG?=
 =?utf-8?B?bTA1RjM3ZlhyVGxpVHk5ZzlQaUVnRXFFam1aOUhMZER2NEtGQStLTHNnclkv?=
 =?utf-8?B?SW03Z0JHeEVBV2xwZmkzcnpuOTUxVDJJOG1tdExqaTBjdnhndE53cG9FU1kr?=
 =?utf-8?B?YThNU09RQitBbDE4UzBhYUFhcVNYUGtvWlZoaTBrc1BVSnZweWJHWWgvdCs2?=
 =?utf-8?B?OXh3ZXd2ZDBWUFEzN1hIa3doS1JkSHhxV1ZEdmV1MmVWVjI4RExkS0lEUjFs?=
 =?utf-8?B?U014Wm5QNDI4YzlvMWJpNjZ6RXd5NzJFQXhKNjFncUFuODVvSm45bkdCSVd4?=
 =?utf-8?B?QkRNbUZLcTRkZE81WWxYNi9TK24zRS82eXBEVWJLbFZFWVIydzlOTTlaWUox?=
 =?utf-8?B?SlpPRHgvREdZUk5Ta2ZNVm5RbXA2LytFbTVVOExkRk1FQzRHWDFtUm5FcVRy?=
 =?utf-8?B?VWJjdW1oVW1NR1dCUU5Sck9NTjlpTno1NzBPZTFFK3FkT1BsNERJK0N4TitM?=
 =?utf-8?B?VGI0Q1dtaXVFcG5veTBrWTI3RnhjZnU4U0JMWHQ2QldzT0Y3NE5xWm53UVJL?=
 =?utf-8?B?LzhTaWZucjd3RzVRTTh0U3lKMVQ2VEx5eWdkMUdMeno2K1ZLdGFvRUpDRDY5?=
 =?utf-8?B?ZFk1K054Yi95bkNWMUZhdW5Nek9CMW5rRHQxcGFPNUZvN0NFdTFFcWVmUEdN?=
 =?utf-8?B?a2ZTRE96QXgzQzJqazZBM2paTk5zRTRHMVFnK2tNaFZFdnkwUmg1ZVZVK3Zi?=
 =?utf-8?B?Q285ZnlLZG5xaUkwUUJvczdDU3c2N0hmcUVsekgwM3RoWGNnbWNJTWZ3dnJq?=
 =?utf-8?B?NHZ6WUF0SEwybFBVbnB6eU41YWh1Q0tpL2VEL2xRL20vRGRqWVFUNHFUVFhk?=
 =?utf-8?B?bmtvOHk4ZEhKNTM1eWxjejJVL2hWSW5TeitlaHVOU01EYWFmMnYySWZ6YUdX?=
 =?utf-8?B?MCtQb0dQL2p6ZUZiSW90cm55YlUwZmhoRmlwYmZOMU9IdWJlaUFxbkpDdkZI?=
 =?utf-8?B?NUZ2di9YS0c2US9mMnhna1JQdmU1Z1lVV20wbDRuYjBQSEdOUGtobGEyQk1I?=
 =?utf-8?B?WUtUaFB4WnVkMXdyNmE1bDVBRy9mYUFXU3lCTjRxcEpCRzRrYlMxSDFFb3pT?=
 =?utf-8?B?azNZMWFySkR1UGlWVDZoT0RHMkxRay9mSkdYcGswalFBTm5GaWtNS2lqVmkz?=
 =?utf-8?B?SGVrNVlnMGdYQVFFYUQ1Tld1SXJYUkQwNHBLZWU4ajBRTjF6ZTI5T1UrYll0?=
 =?utf-8?B?ZUdVeDlPZHJnaEp1VDJDNGJJWW1zS3F5YVd5VVRpekV1TDRLaGlRekNSNnFp?=
 =?utf-8?B?elNNQVRJcTlHT0RQZ2w2c0F4emRITUhtMkxheE91RWVZV3pwaUQ5aXVyWjBN?=
 =?utf-8?B?MUprc1p0R0thVVZTYkJrOUpITkZYdkdxSU4wdVJWUFRDS0Jock9BVHo2cm1x?=
 =?utf-8?B?dHNJNkNwdEZZZ0MwQWVreHBwa2FmTkw2MUZtVjdBOGFid3hzUmNEbFNxUlIv?=
 =?utf-8?B?bC9ZY1pJaWh2alNsN2FReFFKbS9MVTh6MlUrZlU0M09pNFYzUWQwK2VXRGxE?=
 =?utf-8?B?TksrOU8yZUhnMjRsZTJvdnJobDM4eVlvR3dFQlZLTitBbVJVRy82WkQ5TzRD?=
 =?utf-8?B?QURjUXo3N29VbzNaUk0wUGdWK2g1bCttSVc0cmpVT1UvcVc4K0dpV3M3V0cx?=
 =?utf-8?B?cHdaRUhNWTVLQVJZRzBOMG4wTng2U1ZhSWphTlkvSm1UQUJkNmljZHJVdHpC?=
 =?utf-8?B?NjJLM3VHdkxDTVBaT1hQbHZsUzBXT1NUajJIREhKWXd1c2V3Rkxlcm5rd05Z?=
 =?utf-8?B?T0w2UHE0VHAyYTFvdmMzVWFGSDZYMGJsTDFRYmcyaW5GVEZ6QjJJa1FBWi9E?=
 =?utf-8?B?ZHFBR0U0c3BHYXlXTHYvYlFUbDVPTFN4QmVUdjZLSVdaU3dtS0JkbUdaMXpn?=
 =?utf-8?Q?cBWrSse83eVZ6Yvi8s+Q8WPjn5WWHU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WkNId29mNGkyZGFmZC8xai96d003UFVXN1Y5L2lBTTdqNGFTMVgrRnhQQTZs?=
 =?utf-8?B?MDZWWWdSaHJveGpjMzZSZU96dXlvb1V2am9HQWZoZEQvZ3BpTG4zM3hMNmt2?=
 =?utf-8?B?Ymo1aWlPM1pOeWZOZXlhOUlUVUU3MGVRdmxZeVhXOW1GbGRQK05PSFlTaVlQ?=
 =?utf-8?B?dWtyM25hSVkwOWYxY3Nod0pHRlRYMXRVMWVIMmdZTWRuc2dXdjEwVWtvYXpE?=
 =?utf-8?B?WXZJcEpIcktQNm9ZRWIxRFJRblR0WWJKMWxCQ1VyQjZodDQvNnpFVWFNWnNX?=
 =?utf-8?B?WWwzSkRlNjYrUUJEQ1l1UmVXNlJLT0ZXUlR2NmlaaHhVbzV5S0I1c3hkclh5?=
 =?utf-8?B?cUYyNndTWWU2S1dsU2x2YVVFL1ZPMXB0U2pKa2d6MkRmb0IzQWltY3ZVNHBJ?=
 =?utf-8?B?OWFHK1I3ZUNyMzZJbEhkWmpaa2VEWTJ6R2FPQU5zbW93NnVvbFlkVGVzc1Nj?=
 =?utf-8?B?QmRCVURHOHVmdVBxeCt3YzdnV0h3VTJ3TUpGWkhkeERraHF4N1FRTWxra0JQ?=
 =?utf-8?B?aFVsNmlSZXRkY2hFbUc5bGdhWWorU1doTDFNOFltRlhML1ZmUTY3MnIvQXYx?=
 =?utf-8?B?VVhyRThycENJZ0RzUU1zVGJQb2FHVHY3Zk15cjI1SzN5VmREZWcwY2hjeU40?=
 =?utf-8?B?M2FabUdtMUhPbnBBaGJwZ3lleWNpTFNPaGt6UFpjUjI2WWJDYjdVWGROTVUr?=
 =?utf-8?B?a2FNMWozdncvQzAzcTFZTzE3Q2xXbG4yZVNPSXozdTFUUFA1a2hkNVQ3OC83?=
 =?utf-8?B?cnl6UUx1QVJSR2Rmamt1WXBOL1BudTJRYWx3TjFxRkw4MDI2cEJjL2IzdzJG?=
 =?utf-8?B?dUY2d0NtQk9KWWYxWGtFODNTZ2FEWUNaZUJvYzhSSFJVendMMFYvU2ZGMGgw?=
 =?utf-8?B?OFlTUEZlQlVLK3lFc20wcnU0K2lWZmtZNlBqem93aU10SC9QZjIvVmlIcjlV?=
 =?utf-8?B?NHdaUDkzMS9UM04xRi9aaHZoR1VraWlUYTg0NnVVZ3VmaE52R0wxWFprelh0?=
 =?utf-8?B?REF4MFVYQ3VwUVF3bkhQbldvZVJBY3dNZnRWKzFnOVNtY1BwNzY1TGhld1lr?=
 =?utf-8?B?T2prMkRyemszRmIyeEJTQmluYVR4dTlEdTNrUDcxcHlWNFVMOTVaUkVyemlW?=
 =?utf-8?B?TlRpSUNGdlpDblVSYUtPNmFQazU4dTdOMXBzamlEQ3hYenRZMWpCNkFhUkl6?=
 =?utf-8?B?ZXI1eHdjcHpVeUtNa28rOHYzSUJrM0cyejlTWk1uWm5aT3dQSkc4cjA4emxY?=
 =?utf-8?B?TGJuRVZJZE4xNFZ6emVBVTBxbjNXVGhjRjBMd3RmbVMxQjdvRCtQZ0k3MlBY?=
 =?utf-8?B?aHY4dDl5YWpwbExPdGdIc1JLRVNJby9HUWU5UGEwNFhma1h2NG94eUYyOTk3?=
 =?utf-8?B?R21FL1dxbklBaUxQUzZMV3hicEF6VXhPa0JGNlVTNDRpV0kzajBYNmJzaEht?=
 =?utf-8?B?MzJHODQ2SnJOK1hFanNTRk9vR2prSGcrNzgzd0h4YmEvU0ozZG9NaG1BMFUx?=
 =?utf-8?B?QWZPanpNSkUxWmN3Y21XVlZwS29xNDlsWHZpcnBCTERLai9QcTlXaU9zZ21K?=
 =?utf-8?B?SHYxMUdiS3g3Y3B5NC9GQWI0UU5TQTJWSk5lZ3RKdVpiNW1LTDY2SG0vOGUv?=
 =?utf-8?B?dlpZUHFTN0JDY3A0bndTa1c2bWlBVDFIZ0pSTmNTMkVPUEVzSnRSeVJ3NXRx?=
 =?utf-8?B?ZFNvWHdWMk9Od0oxdERzYWw1ZDl5MG13Q1d1c3RwYjhCTG51S0lCOVVkUGhq?=
 =?utf-8?B?RE1RcG43Vk5teVl1QVJzOHlLbVpSbUNWM2tmVHFLL2JrUFU2NS8xWUl6V0d3?=
 =?utf-8?B?V2lmeW1sUWxQZDZ4aHMwUGJNZXNzY0c5VFFabXdyL1NjZWE2L1BLT0lnZkhx?=
 =?utf-8?B?QWxkdTR5d0dJYkhPa1lBZXBCRHdrUW5mQzJBZDFUU2F1VEVQdy9maXdMblpn?=
 =?utf-8?B?R1o3NXFZT1JjSWJUc1Z1YjROSERCdjdUNFViemQ3dUxmNUhHZm1Kb3cxVklw?=
 =?utf-8?B?N1pjWUMwaFZNQXhKeTdHUW1OSzRpelRBQzlqOEV2bHA2TXI2MGtlNUp4YUVz?=
 =?utf-8?B?T3RtRVY2Y015TG5WNUJZUm04QTlYNlNWbUVaaUtDWDloR25rTEFEMzd6YmN5?=
 =?utf-8?Q?LU28pZlpia9T7kEnw/f48ZP7N?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AB7324BE7C34A48B8B86EE80C8A398E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8668f277-4910-4d64-330c-08dd8eca2756
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 07:21:45.0946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9c4vv0UATOru063P5XyXkxIvKbYUPxpllC6KhfDQenBbGnnhrt5Edk0tB+rHzj4rGsgHKuCDFAzvfMTbLQqorg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8710

T24gVGh1LCAyMDI1LTA1LTA4IGF0IDExOjMxIC0wNzAwLCBKb2UgRGFtYXRvIHdyb3RlOg0KPiAN
Cj4gTml0OiBpdCBsb29rcyBsaWtlIGluIHRoZSBvcmlnaW5hbCB3ZSBkaWRuJ3QgY2FyZSBhYm91
dCBtYWxsb2MNCj4gcG90ZW50aWFsbHkgZmFpbGluZy4gRG8gd2UgY2FyZSBhYm91dCBjaGVja2lu
ZyBmb3IgdGhhdCBub3cgd2l0aA0KPiB0aGlzIGNsZWFudXA/DQoNClRoYW5rIHlvdSBmb3IgdGhl
IHJldmlldywgSm9lLg0KDQpJIGxvb2tlZCBhIGJpdCBpbnRvIGFkZGluZyBlcnJvciBtZXNzYWdl
cyBhbmQgSSB0aGluayBpdCB3b3VsZG4ndCBtYWtlDQpzZW5zZSBqdXN0IGZvciB0aGVzZSBhbGxv
Y2F0aW9ucywgYXMgdGhlcmUgYXJlIG90aGVycyB3aGljaCBkbyBub3QNCmNoZWNrIGZvciBtYWxs
b2MvY2FsbG9jIGVycm9yIChlLmcuIGFsbCBnZW5lcmF0ZWQgeW5sIGxpYnMpLg0KDQpGdXJ0aGVy
bW9yZSwgSSBhbSB1bmRlciB0aGUgaW1wcmVzc2lvbiB0aGF0IG9uIHRoZSBraW5kIG9mIHN5c3Rl
bXMNCm5jZGV2bWVtIHdvdWxkIHJ1biwgbWFsbG9jL2NhbGxvYyB3b3VsZCBhbG1vc3QgbmV2ZXIg
ZmFpbCBiZWNhdXNlIG9mDQpvdmVyY29tbWl0Lg0KDQpGaW5hbGx5LCBldmVuIGlmIHRoZXkgZGlk
IGZhaWwsIHRoZSB1c2VyIHByb2dyYW0gd291bGQganVzdCBzZWdmYXVsdA0KKG5vdCB2ZXJ5IHVz
ZXIgZnJpZW5kbHksIGJ1dCBnb29kIGVub3VnaCkuDQoNCkNvc21pbi4NCg0K

