Return-Path: <linux-kselftest+bounces-21065-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDEC9B58D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 01:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AE161F23B93
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 00:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4459B29408;
	Wed, 30 Oct 2024 00:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="mSr4BNXx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697EA1773A;
	Wed, 30 Oct 2024 00:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730249667; cv=fail; b=tYrLB2He1d8zhFFf2+dWz77BXSC9xSL13kKwsEdt+RQW4nizmYFIh7cVmgyQ/mbhKLGOFe9C8hDzsnjh+npqLaY8nM7NrdrP7h+zeVB2X9liWhJvvlQvu7/5f1tkYYicE/ZHxNzE9n1XberQ115qou0gTI8ko7AS66SRVdTxpJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730249667; c=relaxed/simple;
	bh=/hioCN5uECXYavlKFCgmi6B+hyEiYz0fe4pa3n0LI5A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TeE+rqffI8hn9Ofcrj2bQ2TEwLLMEO0sxW2O+o4KSdtHLWERi0OM0ATGsrI3OfNd2OCTYUVPfATCeXNr04ETJ11N6ukpHWH+xXk8Fp6QqP7TV1y7GX8foWcl+db2uT1+2Ha78M/35zpY7Ey8ifNd6J6MmRaC36QUoLKuA2xyvuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=mSr4BNXx; arc=fail smtp.client-ip=216.71.156.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1730249664; x=1761785664;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/hioCN5uECXYavlKFCgmi6B+hyEiYz0fe4pa3n0LI5A=;
  b=mSr4BNXxaK8JQy6cPUOtfC6WhhfG7wdwAXXVT0tx6+DeJiUBjGOQdXjZ
   gkMn6TbUnZFvuB7mNaSCKbOWr36wXAqI03gtW9N2syDIHgM93uwjFSJSA
   fKyK7ibHN0XvwK4FxXxLeB6jx6ySdShBl8F/NxK09ajcg8Y2ysq/eJ9WH
   Ew7z2Nho4N9Pmlq5aB4uv9BdkPpdre8SBXnJOIWsXwrUxIOYxKaGg8+iq
   Bi2R8Hx/gRC10am5Qhzo0c/mJ9GeuY3o6Gi/zNX/GwqxbdGjT9V1v3xp4
   0FJZWfaybw4ZpFgz00KDi+4qNgYSNoUn+BXO4QQnzc9e8sLX5m+MoeEK1
   A==;
X-CSE-ConnectionGUID: GwDIyDaHSoCeSqeLPT5VRQ==
X-CSE-MsgGUID: TNHULmGmQ7SEGE7zDw8Azg==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="136099327"
X-IronPort-AV: E=Sophos;i="6.11,243,1725289200"; 
   d="scan'208";a="136099327"
Received: from mail-japanwestazlp17011030.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.30])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 09:54:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tkVfohO/ms2I3zrcoIFkr5rCupcmbHLiTQwsHT6w4lg0iB2Aj2plvsSzx+n8tW5RkHLCUW0nfyYoVSBy2fkS3hKluA89rA43MVCpDTJQFUHV0OsBAabuxmrEAAzOGf5tJvaEsIgVXzeWLTxLlK1wwip21cnzxm4wK+djXut4D8V0rwASWa7gKj0WFX7+iYbrW/qzsSpF9oOB08XtoEN5wBQZCqxkeQIqWu/pf669k+fcins5zz6NhrQb1T1OFE31/3zSS4nFW4qO+QS3ITZvxAsD82ecqxce3YnBpOpyaoH+csuRk6YUEo7cw2vM9UZgK2uc0Yrz+Yx7kZimKintNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hioCN5uECXYavlKFCgmi6B+hyEiYz0fe4pa3n0LI5A=;
 b=K2c4JUF3RM+7Tjtkb4WWxEyXd+twB63c8LatvXHDjkCAqBYv0Ht/Lq/u015bTiwl2mZ6lkihBkxiKYYH/hvKBYZQjNZerJAoX9s2A0PgszT+/hetRJYkPQmmd/cnCpLx3bvtvkL7t2W4MoHsVlK2eY6n8nUCZhUEsTu3uDEJly18jssIczvvT52br1s5DrSFYQazI73kxu0j79hOIa8NX5uPRAjIkTqLPQXGH3D5u9Omy4mXxjeve6IYQCvnEYqWCi/QlYLi9cVc3fTfUek67tM7jVzR2WSVpP6n87D9IENGkT3QcBhKIzgcdbr8QJOwniiYHRe7swywwWL/3Xj78g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OSZPR01MB6680.jpnprd01.prod.outlook.com (2603:1096:604:110::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.29; Wed, 30 Oct
 2024 00:54:10 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%7]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 00:54:10 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH for-next 7/7] selftests/net: Fix ./ns-XXXXXX not cleanup
Thread-Topic: [PATCH for-next 7/7] selftests/net: Fix ./ns-XXXXXX not cleanup
Thread-Index: AQHbJn7CKAK2MHfxf0a9GxUIioXkNbKea50AgAAT1gA=
Date: Wed, 30 Oct 2024 00:54:10 +0000
Message-ID: <8c1e556a-eebe-456a-909b-fb49dab0f520@fujitsu.com>
References: <20241025014010.6533-1-lizhijian@fujitsu.com>
 <20241025014010.6533-7-lizhijian@fujitsu.com>
 <20241029164306.6122b372@kernel.org>
In-Reply-To: <20241029164306.6122b372@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OSZPR01MB6680:EE_
x-ms-office365-filtering-correlation-id: 033c6a58-4800-44bc-f53e-08dcf87d5db5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eGVWK3hIODVCTDZMTnhBa3pJVGpTQTJpSHJwbDl2MHlYMFpTbjE1SDF2dEhG?=
 =?utf-8?B?MGRTTGJzNnAzazJLaDQ4dXpQNUhaeUJGOS9FR0RaQkxLc2hTSWNkN0IyUHJn?=
 =?utf-8?B?V0ZDc084Z2JyYXhkL1pPTG00Lzl3L1EyWWh1OGFCL3VCSTJhc3lrY3plaWdz?=
 =?utf-8?B?dnd4SWVPTDlGWjA2ZGVOSSswVUNVTkVLNy9BWEVBQVRQYXdGTjViZkxzTkdN?=
 =?utf-8?B?dGNvVzY3Uk5DWmN4YUFBd1p2OFRkYkRyVjlUcUFPQ01pUFFKNTRFTDgrZmFV?=
 =?utf-8?B?bmVHRlBYTnN2Skt6b3J1MU5qOTU2ODkvTU4vZ0JSaitWa0pBMUhIcmRLbWdj?=
 =?utf-8?B?NWsrektkNTFhN3dOUnJjUnZUVlZ2MERVc0krbkVpbi9JNFp0bjlyeUF5dXk5?=
 =?utf-8?B?N295Nk4zQmxhdEdud3BzWG9HTjczd1NtNkFsT2FZTHhrQ3hLc0ZMallGRGx0?=
 =?utf-8?B?dHAzd3h1dlo3dTc3YmwyaGZ4Mm5JZHEzL1YzZ3lYZnROME1nSmlmK0VsN1Yx?=
 =?utf-8?B?a3JZSVpsQlNTWmZoV0RLS3NraWJuU1hUbjgvaDkrWlNJNDdUcEJCVng3TWRY?=
 =?utf-8?B?eUhoQUN6MGltZjhRY3BKN3pzQkhrR1dLTEplNGtKOHFLSHp4ajFkUC9RYy9q?=
 =?utf-8?B?YzBaRy8vZUVXejBOMDlNc3pDMnZZb1Z2UlZQdEt3R200TVdDWG52U0MvcHhL?=
 =?utf-8?B?TCtOVEVxNnpRN3R2NlRKQ1M5VWhTOXR3enl4bU9wcGlLSUdWK1RsUTErVmpP?=
 =?utf-8?B?MXpxV2lBS2tUNTdHM3dqQ3ZjMHRnUDJmK0JWbEJVVkcxUFphSjdOTGxBeGZn?=
 =?utf-8?B?bUlZKy8wZE1wS0xDaUx2c1RaSWMyQWZyRDhwQ2JSQVJWZUdWTDBVN2N5aUxz?=
 =?utf-8?B?TFQ3TkJsNCtrNzdqbWNRcW83ak5vY3NrT3Fqd2xtVk9IUWNKOGU1bDFQdGdI?=
 =?utf-8?B?ZitKNk5LSlVaVGxSUE5nekY2SmdrUjIvaUpuNTIraXYvdTRMbklxV0NMY0ZH?=
 =?utf-8?B?S29SbmczekpGaUgwUndYQ1ZZK1pubzZGMFdKeERWZDdjQVZkMFpXTCtkb2dm?=
 =?utf-8?B?RS8yYmVVK25jZjJXSFlWZUlNcnd6Z3l3SE9OSllFZFM5cnJjQzkyUFczM2FN?=
 =?utf-8?B?UUFuT3k2LzNtNnhtNUo2VlZMeTBuR0l1WXB1VHZwUjV0YWZvaC9rZEJhSXFB?=
 =?utf-8?B?QmdZYUJKZlU2a25kMGxCamtRa0ZkV2VkZU5DSUtIeFJHUXRDOElyYzR6MXpq?=
 =?utf-8?B?T3pNS0plcExOakQ5aUlMb055TmV6cERpeFVMTWRYbCswYWFiK1IzTjRlWUhG?=
 =?utf-8?B?SzJWY2trYmtXajlvdllNV0dnM2gvcDRaWERDYmdrWXYvZzR3cFVCZGZlOHZJ?=
 =?utf-8?B?TzRpMFl6OWU4S09lQ0p1eWVmS2RMdlZDTmxrQmdBeDdzZ0dpTVBsa2J1eTBn?=
 =?utf-8?B?RTZyV1lwMjZyejBjbGFwZmNadXg2Z2N6RXU0eHFDRENEZXdLc3pqZUU3MzNr?=
 =?utf-8?B?QnpoTXlXWXR5ZmNoVnUrY2hBNCtKcjRlZEVySVN6LzltQUFMRFFUYXNsR3dx?=
 =?utf-8?B?a0ltQkV4YUVQSlRMa1AvTGdKK3M1SVNzbG1WejFKSWVYWUpSR2dDLzhlT3lO?=
 =?utf-8?B?cUVReWNTQ2dFZ1pMWVZXYSszODZBTjNodk4xSXFzTWthWkI4VXgwUVJiQnMv?=
 =?utf-8?B?Q3p3NWxaSllvRlJReE5GRmIxY2dqdTU4ZXo5VTB1Y1JhZ1BXbHRDMGlZbHkw?=
 =?utf-8?B?MS9aSUR5Z1dUaVBHOTlBQXJ0RFhnV091K3hoZGl4U0VHUDJJOUZZenJaNDZD?=
 =?utf-8?B?Z3FjR2c3aURUR1REbE5GU2E4NEY4SzArQysrOWJlZGRVTlpTM1ZrRERRb1FY?=
 =?utf-8?B?anpoVUZ1OFVORlYxNEpiWGU4RzlMYkFzb3U0VkhyMGIzMGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SlQxOTdnd1RsLzB2MEtzbmNCOUpLKzh0VlVaTGFZNVEyRk1aTGhYKzUrZmZO?=
 =?utf-8?B?d05EMy9xNjZ3OXlCUjdSazZQcFpuNjFSZktNUzVvRXJQMVp0enE0S0pFN2t5?=
 =?utf-8?B?MUg5YWIxQ2ZWR1NjelNEdUZGaGsxT3VBZFFtd1dxam1XUEdhZ1UvcllVOUFD?=
 =?utf-8?B?NGRnVHFJVjM5aFU3N3V6TFgzM2lTOGoxVG9uVUpIQjJlSlZTNmdxckVTY0NN?=
 =?utf-8?B?WEV4SC9XdXY5M3VKUmJEdUY1YTYxaDJqT2U3THBHYmtOZi9sZTkvZ3FlalVR?=
 =?utf-8?B?WlNLNE5Ea0x4L0RwN2RWU0JZM0dPc2R0Vldkdnd2STBZTWVOVE5jd1NiKzZS?=
 =?utf-8?B?TlZHM1lpbE92ZkErMEhzZFpSTzBiS0liVzdhNlpMbk1TdVVYQmhiSVZtVFhz?=
 =?utf-8?B?V294c3N1amRBZnVJMFF5cU1TRUNmaVJBL2wwT216bEE0amZKYWxVT09HZUht?=
 =?utf-8?B?U3lkMGt2MFp2ajFGU3BkUU10T2wzT3FlMlVldHplV28yNDNzM0ZQTzMwM3FT?=
 =?utf-8?B?TStzK1NwMFpMajJQeE0ya3NKTG9pa08ya0Jnck9DYVd4M09vMmNMUzE1Qmdy?=
 =?utf-8?B?OENSMm1MNnhFR0xsN05wa21TdHphVy9VSW1zTTYycVdVWXZWMzZQQXVPbmdH?=
 =?utf-8?B?QXNXNkRZb2EvKytZWU5Qd1ZyMktDcmJSZFJWTjQzM0VUTHRuanJHanJUdzdP?=
 =?utf-8?B?SXNzRFpTODdvRnFzZDZ0YVd2b3lmTEtXR3Z0NVBpbzM0NjRsUFpaZnZSdlhY?=
 =?utf-8?B?emNkcnpGRHdKVDVvY28wZDZ5bThTelBiMHBnY1ZzekdEMWI0WkFlU0Y3WERl?=
 =?utf-8?B?d0JmWjFqYjlJNWdXV2thQmQzVUxBSExLM3BrYXRQaG5VNkVTVzdtQmlCYTVv?=
 =?utf-8?B?WFlxMTdST1Z6MGVFMFBaR2RWR2p0NVNPUFZXTjhBaFRTbFdFNEJKMU42Mloy?=
 =?utf-8?B?MlI4MVZIM1lPNE5VSDIvdm1MMlFmbXI3VzI2UmFyWjJKN1BNeHJ1UE5qTUxN?=
 =?utf-8?B?elJFSzA5SksyS29FR1BWaHJ6TkVlSHdpUE5FbnZaRlNNUkgxQnFYUEUvRmVz?=
 =?utf-8?B?YnJab1BMb3VkZ3JFSjFVdXF1aXpTWTVRSGRjU0FEdFRqQ3FmYlFBNHNpRTdz?=
 =?utf-8?B?dkpHTkJHNXJEMTUzWGxVa2tYajNjRk5TN25CTEhCdWpzTXV5ZDY0aXlVcVE2?=
 =?utf-8?B?STVtRm5Wak9vZmIzbkxIOUVWNGxodjdyVUdudVB4YU9KUTdRMXZsNjhoeHdP?=
 =?utf-8?B?b3RoWDRQc0s3aWR2aFRsb1ZYV0VTZ2tXU1ZxT0FXcjgwNnI3dnArckQ1QWdY?=
 =?utf-8?B?endzOGQwRFJQT3g1MzVvbTVVK29HaHhHUklZcHJIekU3TmNFMHprbkZOMGY4?=
 =?utf-8?B?NXQvcFJ2KzhhSE8zZXdYanhQUkR6am5jWHdINW9Yb1JHdGNMektsNll0c3Aw?=
 =?utf-8?B?K2d3TDFlWUF1V2NRN08zSTZSSEhtWWFZcTV3c1piL3ZqdThzYlNVVkFKenBq?=
 =?utf-8?B?YjNwbHp0ZlBodE5mTkNjRVRFbVdVYjl3NkIrK0s0K1gyMXJJeXVodFhoVGxV?=
 =?utf-8?B?VjlEandmS1UrRVUrMlNqRklMbTdJTFdxQ3lFMlBuRVpwZmtDYWcyZWc0aGxC?=
 =?utf-8?B?Y2VmYlNKTXBuQmk0cmthcm1qYVd6cmtIMzhVUEdyWERvQVlnaUFKVTU5TEk4?=
 =?utf-8?B?VlNNOEhhQWRiSWZ1aFdQSTcyem91ZHJyRXE4aGhVV3FwZHlnbjBJeWdrZXBi?=
 =?utf-8?B?SU5BQmYycUhzM29OR24ybDhZSk1NVlpNbXc0WmU5U3gyR0E3Zm5XQkFKZXNq?=
 =?utf-8?B?M2p2NmFXeGh0R1Z1ZW4wZmtTZy8vYUoxWUltcHRNSUJ4bjd3WDZSZWwyS1V1?=
 =?utf-8?B?TzVzbTErZXAwVWwwVmVtSFFuUjFzUUlhSjI0Rkw0K3FFci9mNjlmamZMZ1VH?=
 =?utf-8?B?dVJ1VkpyL1VSZytxbHJDR3d2MUdqdEc1QjJYUUYzTTlKVHdtRzZrWndlQlc2?=
 =?utf-8?B?eG9sdVlmT2xzSUh0QWg0QklwMzZlKzQzckY5NURVQU5qMEtTL2ozeXYyM1Av?=
 =?utf-8?B?NUVzTWpUS1dOWnk5b2FTUjQ2R0ZiRHVscGhlL1lXZGNlVjk3RGtsV3NpcUY5?=
 =?utf-8?B?dmQ3L1ZMeDNjSzZFU1NhcmlnSVhHKzNIYTRheVZKeXk1QjBybnVaTXg4K2xX?=
 =?utf-8?B?Unc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A13EC1BADCFD5429E5F684C25F2C8D3@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FXW167LRtbtv9q5PLj6pQPYp1odAF/aVkhyGUnIotb5wXFTN/CADMltTjGxsRlzkIdTMAZiLaG205N5lPUmsDbGExhLFCxTSSj8E7XbtW+m2OyykFDZgblUu28IIztaYK+7qulHQ47vkYxP35PovkPmfdNie+o+P6auAtanuYDJkN7vgEjy2ZvHEpAaJNub7aHi0rPwqu8HTtHiSRCyCDuu1PE0sfp2UuaWNU5aPvK6hGhgcxcZhB10GWGObDhD/dBn+gZmKw61V8lDPWS7HmuNXyQurcCB1goAl/zYwp8q/G0Zy3hvNPEDWpGvtbwRs64LSe8AfAemQNAZ8ZMRoWAX2n8iwjtD9pSKNo43UIHQ683hBCiytW5+TmRB0uy0YrjA4InGW6oSli0is+I7kF3lawtv9GsKugA8a30ZLU0LLijIfZuNT9DKylCy+qkTCwIxp46hPp5VWLrUthLmugwqK9Y/bjhRxn7gv4CAVY26m/AF1OMmmHKAoA3Zmw0GVwESgNaJ3Z06PF7/BIUEkMxXG2d4rKiGWPQzam0XTOksYpfralcBlfeGHvTA4f7xd+TJC0t+H6BtfbO4f/7blfV7EaUPpeKUToU7TZ44vOpyrKopi0C+jTbkmggYFjEp5
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 033c6a58-4800-44bc-f53e-08dcf87d5db5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 00:54:10.6181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3PNXjngxU8iZ6rSo563hpEL3S6oWz5joqhRMDwPRUIC+k9q3d18CzLAZbWYUyXJqVmSGJbDNY6nfoMh/VXVB+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6680

DQoNCk9uIDMwLzEwLzIwMjQgMDc6NDMsIEpha3ViIEtpY2luc2tpIHdyb3RlOg0KPiBPbiBGcmks
IDI1IE9jdCAyMDI0IDA5OjQwOjEwICswODAwIExpIFpoaWppYW4gd3JvdGU6DQo+PiBgYGANCj4+
IHJlYWRvbmx5IFNUQVRTPSIkKG1rdGVtcCAtcCAvdG1wIG5zLVhYWFhYWCkiDQo+PiByZWFkb25s
eSBCQVNFPWBiYXNlbmFtZSAkU1RBVFNgDQo+PiBgYGANCj4+IEl0IGNvdWxkIGJlIGEgbWlzdGFr
ZSB0byB3cml0ZSB0byAkQkFTRSByYXRoZXIgdGhhbiAkU1RBVFMsIHdoZXJlICRTVEFUUw0KPj4g
aXMgdXNlZCB0byBzYXZlIHRoZSBOU1RBVF9ISVNUT1JZIGFuZCBpdCB3aWxsIGJlIGNsZWFuZWQg
dXAgYmVmb3JlIGV4aXQuDQo+IA0KPiBBZ3JlZWQsIGFsdGhvdWdoIHNpbmNlIHdlJ3ZlIGJlZW4g
Y3JlYXRpbmcgdGhlIHdyb25nIGZpbGUgdGhpcyB3aG9sZQ0KPiB0aW1lIGFuZCBldmVyeXRoaW5n
IHdvcmtlZA0KPi0tIHNob3VsZCB3ZSBqdXN0IGp1c3QgZGVsZXRlIHRob3NlIHR3byBsaW5lcyBj
b21wbGV0ZWx5Pw0KDQpZZXMsIGl0IGFsc28gd29ya3MuDQoNCg0KPiANCj4gU2ltaWxhcmx5IHRv
IHBhdGNoIDYgLSBwbGVhc2UgcmVwb3N0IGFzIGEgc3RhbmRhbG9uZSBwYXRjaCBzbyB0aGF0IG91
cg0KPiBDSSB3aWxsIHRlc3QgaXQuIElmIHlvdSBvbmx5IENDIGEgbWFpbGluZyBsaXN0IG9uIHN1
YnNldCBvZiBwYXRjaGVzDQo+IHRoZXkgYXJlIGxpa2VseSB0byBiZSBpZ25vcmVkIGJ5IGF1dG9t
YXRpb24uLg0KDQpHb3QgaXQNCg0KVGhhbmtzDQpaaGlqaWFu

