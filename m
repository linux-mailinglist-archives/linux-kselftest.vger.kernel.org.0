Return-Path: <linux-kselftest+bounces-36493-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16192AF851B
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 03:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76EE51BC4792
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 01:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64BF72628;
	Fri,  4 Jul 2025 01:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gR38Tsn/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2668F5B;
	Fri,  4 Jul 2025 01:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751591840; cv=fail; b=tlXZ1TBhPxwNle6wx35McLsVTUojxcQ6KO7v+mKsBhobMbqXV9Ym8pk4ugWcFULSnmhuI5uEpvOP9PQOU33eV0up7p3jhSjQyFswQ4Fui9IpzSYa1n2IPWVEoKjwLRqUfTy/rCIdjTzo3XPL48QQGc7ohNArdNeqzIYei1Hx5AM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751591840; c=relaxed/simple;
	bh=t2+zV3dCiAvuQHfJNx0XOJP+qlKmnjRBTqaIb8QJWRw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cvvoPJPHp03KJx3k8KO08m2T/MomOIKx7z4YGi2+Hiv0Tn/neOMJV2xDWQpdEaVWOv2WXn3NhSHRQIh1QL6ZdiPH3zmQkuosetiRLhKDulT+UR8BFWNkQDULT5EdoZwRCaVLx424Mxr8umMe2CodkvlA3Ugz8dnIvsCraOeT58A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gR38Tsn/; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751591838; x=1783127838;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t2+zV3dCiAvuQHfJNx0XOJP+qlKmnjRBTqaIb8QJWRw=;
  b=gR38Tsn/JqaSMAx4rYlCq7/WyHhCBB6bRp34Qpp2ZmMjVZAi1EwDGESS
   NoDX9SxA5n2CGAZperdTXSzighPVNgLqJt/+0EowefaYBeLYkNBqkS88y
   2ojijYzkdWydjTbUoK47wHINsZdMFv/pmZ8LqYYPfgdkI40DqeRFIsYL3
   Lxjy2vPX+mPEVo52F7NLxKYsWV1yPNKKy1QO/8l+/uiYmJQ4/HgqsOUQJ
   PgXanHaBsVHyCDAOYPtqVu62PoAVIW15VtGaRoF512mgGt/6tr6qpYAO2
   wKVsmnuHqoGYZ3jkfpUEwTJ/s/tSBo6X8vKv1QexoNnGE0W1U3J/wYKjn
   A==;
X-CSE-ConnectionGUID: 7C2SOp3lR1SrsdHxfRhQRQ==
X-CSE-MsgGUID: 5+2WajQLTfGGevC6tOe3OA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53795174"
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="53795174"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 18:17:16 -0700
X-CSE-ConnectionGUID: MocfU1opRfmTNQTjaBYRng==
X-CSE-MsgGUID: ej14tjh4Rm2t6Cc6tOK5Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="178184957"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 18:17:15 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 18:17:15 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 3 Jul 2025 18:17:15 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.79)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 18:17:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SgSa3YhG4EhTwejrtrE//yrnJ5GKA8/H6hGs9fO1y+3Btcz1cK6jnEaRbXh3VZoqfxwzTUPt1YFLCOGqca8/rnfmYZRiEeIB+PQAfRgdkeK0dfhmjccspW9Gnb+BRwpQVe8TA5keFyBtZc/4JWZsE9Ghqnhree3YHYWe71n5IyJKmwIQ6Dd6mc0LYKnOmBMLSvCrtruHokn8AIHfGfWfwyHCBVnUwaiQ9wwmm8tSqalM6AI/CuVH+BMO5ErGxIcSwUX38x1YDWDwPTq768gj/zg8m0vTQ9wJGk8uSSXr2FFIuddo1uUykLEf0q6h7xRCYOV15j6u1H2NwFp9LNr22A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2+zV3dCiAvuQHfJNx0XOJP+qlKmnjRBTqaIb8QJWRw=;
 b=bcRKuL2T1dRId9jrFbGwfVib0Vx7xfnJfTw3hzTfROMzohUKflubfdWekU/9Z6IdN/CYrizdZQYPmfywRryOOSlbjOtcyPnioA9GxcWh/HLJOXqGFpQGoqILEKN9fjYww0vnwazioPDwqnU4rop2QLd1ko5oybFW1iMBxi19Kt/anrVxJmJGCz13P45M72rbjO0OXsNpf1KmPk3JJbhTFAKWTuinXgyeVLFhTauw3zpoHu3QRa14xuw/SynSg0Jpo9xlo4Yu/kTaZLmpJ2x6YP020t0BGfeU1sSLQrN9uo4vTBGNIMZ7PIzKgN1sKcJcgLoAhEF1mCP1ka2yNbQgKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9254.namprd11.prod.outlook.com (2603:10b6:208:573::10)
 by PH3PPF681F257FD.namprd11.prod.outlook.com (2603:10b6:518:1::d29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 4 Jul
 2025 01:17:07 +0000
Received: from IA3PR11MB9254.namprd11.prod.outlook.com
 ([fe80::8547:f00:c13c:8fc7]) by IA3PR11MB9254.namprd11.prod.outlook.com
 ([fe80::8547:f00:c13c:8fc7%5]) with mapi id 15.20.8857.016; Fri, 4 Jul 2025
 01:17:07 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, "Andrii
 Nakryiko" <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko
	<mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH bpf-next,v3 2/2] selftests/bpf: Enhance XDP Rx metadata
 handling
Thread-Topic: [PATCH bpf-next,v3 2/2] selftests/bpf: Enhance XDP Rx metadata
 handling
Thread-Index: AQHb63K+8Xxuwt12i0SASQIfKldL1rQgojsAgAB9hEA=
Date: Fri, 4 Jul 2025 01:17:06 +0000
Message-ID: <IA3PR11MB92546301B67FB3A9FDCD716DD842A@IA3PR11MB9254.namprd11.prod.outlook.com>
References: <20250702165757.3278625-1-yoong.siang.song@intel.com>
 <20250702165757.3278625-3-yoong.siang.song@intel.com>
 <77463344-1b1a-443a-97be-a7ef8a88b8af@kernel.org>
In-Reply-To: <77463344-1b1a-443a-97be-a7ef8a88b8af@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9254:EE_|PH3PPF681F257FD:EE_
x-ms-office365-filtering-correlation-id: d312fb7c-7ace-4e20-fcb4-08ddba987e0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VHRVVDFJSFZJdHpyQ2srNk9vMUNnYmtKa0JDZ29tYWpVeDY5SDlpc3RpOWNn?=
 =?utf-8?B?RlZqTlRnYW9aRkRXb0h5aE1nVWJmeDhQQWhNVk1HTmFPNncxNFZuSEJ3c05I?=
 =?utf-8?B?aVZURXRzaHhIK0M2TDJGZU8wZkVjL081UUJHN283Y3BZeTliRkVDR1g0S0Zo?=
 =?utf-8?B?dXhqb21uZWZwN25PcVZEK0s0SnY3bm1FbmJ1VnJRQytHZjFESnZzLzErUFcz?=
 =?utf-8?B?TjlnRjVrbmp5R2pvVzdpWTA3OFlnd2dxeE43QTU0akZ6VEMrWGZoNTN0Z0FU?=
 =?utf-8?B?TElQKzd0SXMrRFpDRXU5SEJkUTcwbmtXUGhZelU2Z3Buc3FnMTRhVHhmZ29t?=
 =?utf-8?B?UlBLWVE0NDNDYUJuVzhlRWxnOWxYWHQzMWlCQlhMM2VXMDl6a25iOE5jVEpF?=
 =?utf-8?B?OE52emgzME42a1ZKcEhHUDdIcXd4U1JNU2swUFpuU1R1Q2xGb1Njdll1Z3M2?=
 =?utf-8?B?OTE5SW44RC9NUWZWUEhvcC9sYWhOa2tNczBSNDdIdTIydVZnV2xHV3k3d2wy?=
 =?utf-8?B?SDk0OVQ4dGZTMkdpbXlOc1BxTElndVpraGp6VTFURmZlVzBwQUdaWlhxeW5o?=
 =?utf-8?B?aENMMXdackRiRjg2VHVyaStmc1NmbVllS2JZU2NybjE4L09PQ2Z5a3dmbllX?=
 =?utf-8?B?ZG9ITGN1dWE5djRMbTZmMitPcFBpVGZ2VjRBbnZpWlJLeEhrMk9vcC8zd2Y2?=
 =?utf-8?B?QmxUdWhmZVVlVFZyNVlQamQxU0RuVmZEeE85OWxPSUpUSnJMRWU3SVZvQlZz?=
 =?utf-8?B?d0J2V2lxTnovNEJ5RFJ5b2MrM1ViblN2cmNNV1VvdWtXOFpQcldSRy84a2RG?=
 =?utf-8?B?NUZiUStocCtNZkxpeGY1NS9uUTVMbzdrZG1LdWpEZVk3OW15Y3VXbWM2NjND?=
 =?utf-8?B?WjBsM2V5VDRJMERMbnE3QVUwOEEzcWhUVzUyUkpFUWNtV1ZkTktDR3lMaGhW?=
 =?utf-8?B?OSsxV0FoNVkxYjhtOTI2d0oxNDlGNU9DWmVXV0V5U202V1REQ2xKYm5Bb3R4?=
 =?utf-8?B?VUxhbDVvWW94cTE5VmNpdVZCMjhyQWlLRUgxbnlEYTRtaFIxYnBYUmRaNms4?=
 =?utf-8?B?YitKZ0I4ajI4cEdybnRpbjl6TlcyenU0TmdTL3VKUWxoMXppRFVTRVFZQkdi?=
 =?utf-8?B?RGdITyszUGFWdUFIT3NMbHpxL0R2OFgrUHJ4aVRqUm43Z1ZSanZreHluODd5?=
 =?utf-8?B?QjdjYnZFR29tTlltcXczRkZzWUJ5c2x3WmZoNUNGcWZtY01HMlczWHg3T2Qz?=
 =?utf-8?B?cklYeXdkRzFnb3NZMUlwcHBjT3FlZXoyNFlTU3J0dWpmN3c4OHlidW12WUM2?=
 =?utf-8?B?UUVzMUtGT1dTV0dOSzA5bDdlbS9Od2Z3a0N6WVhwcjA5UFBWc3o1dDJoSXVB?=
 =?utf-8?B?TjlxTVZ5VXhQOW5WMk40L1IzTEIzMjMxUlgxd2JZZGU2eEFBekJJWERaWG9U?=
 =?utf-8?B?enJzaGRPakwwK3FaTEdwN0s3bm5ldERsZGlTKzVGOFdpc1llc2NrNFErQVpE?=
 =?utf-8?B?bmorbkVsUXRUYVdHUGlpUHIwNjk5TDZkVU5XdWF0R3NEVlBJMmpSTk9uSWtU?=
 =?utf-8?B?ZVVYMjA1WXA1d2VZeWlEUEY1MjVLNDFkR1hZRnZaT3kwOXNoVW95WUdtQWJz?=
 =?utf-8?B?cmxPd2t2d1lGUVEwU3RwTWlPaUFtWTczTE01MUN2TXpTcFFxemZpdTduS0xq?=
 =?utf-8?B?SUUzVnJEZmd4Y3JHS0FCNEdtQThRWkI2dENybkpKbGk4bTFUV013cVd0SXB2?=
 =?utf-8?B?KzlyaDhUMWM0N0sxUEJtZi9oYk44N05lVUdEY2h1TU9DWXFqaVZWYkdxM2ZV?=
 =?utf-8?B?QlNuOHpXQU1NcUJJS0U2WjRkT2k1RmQrUjlUVWZ5ejRXanFZeDh6cldtR1Bm?=
 =?utf-8?B?K296MTRZL1hWeHdYcDdndW55QmxSYzZnMmhDYlhMQjJ2Wm5UOFhCYzZSMXM3?=
 =?utf-8?B?UlIrVWlVdVU0VkxVbVZ3VVhaVkVHSjJaOFVOcXVqb2o4cUhzR2doY2k4Y0J6?=
 =?utf-8?Q?g/EHdcdUkXzzTxA05hjqh+egvXCsAk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9254.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTZKUnF0UndpVGhSS0xPYlMwa1FqTVAwbDBxTFZCQ2tOU3k0SjRBM2hJNHph?=
 =?utf-8?B?RStzK1BBNG1DejRQL0tOWlBPVUFFdEd5ZW9IWjdwdWR2UTdQUkVGaWc4aTNx?=
 =?utf-8?B?a0I1TnU0emtJNUNORE5mb0FORHROV3dCK2NpMHUrUW41YWtCSDRCTUh5bEdH?=
 =?utf-8?B?NjdxUVVlQmEzK3lEeTZMNFgxT1RTalVLMEs3QW1OWWFBaGt2ZWU4RHdCZHk1?=
 =?utf-8?B?QXlTU0dCTHNpM21wdDhvT2dhbi9zZGtSOXo0VndaRnVvQ3RXWmRLM1lHMnpW?=
 =?utf-8?B?VGJDanhiM3FYOUE1bnRJVHFIQzY3UVVXaXRySGl3dDJPNXdaaDRuYXBBTG1M?=
 =?utf-8?B?TFMrb2hraWVWcVF5TUQ4ZmtNN0JMcDJDdmJXa0ZPODNDUHhXMkZYN3kzYW1D?=
 =?utf-8?B?M1hnYUpRSTA3SXV1cDN3Q0xNdTVzY1UxTjJzcHdxbHYrTnMrR2k4dXdEWnlt?=
 =?utf-8?B?M0YrbTB3S1ZONUwzK2FHZzdjYTZxSldjTWVtSXpsNXc4Y201Q2pxZlFnZGZK?=
 =?utf-8?B?NDhsNUZwZ1MxUXFIM0lhaFliLzB1M3M4aTV1SVJJYTNZK1liRVZMNTZxQ0Fy?=
 =?utf-8?B?L0dUZ2loejdVWFRuZ3puanNtL3Boc25NVHgyZHdzRHhkWUZYVWdjZGdVdGlU?=
 =?utf-8?B?bTFwYU5lMldWbUNIZFNjOTU1ZTdtYVc3cmFNQ2IvY3RNU2tTQ0p3RGJtSkRt?=
 =?utf-8?B?VjF4V0tEamk0SysxNGpzOVowZEx4MllKVkhpWGlQdkhRT2VzYWs0SFZNVnZl?=
 =?utf-8?B?eWFPdVRvS1kxU2hIektmQ0tFUGJoRFMxdVlsbnE4Y2UrZjR0azFRbnR2Nzdt?=
 =?utf-8?B?N1hVcllic1RmSXBYZGIvVWorWGdvdkFJNjBYZ2dnQjByaDB6ajZvRTJWbnBJ?=
 =?utf-8?B?eVlXQ1lxUkFNeTdBVmpNMytWcXJ0L0p6OU9yb3V2L2Y5N25LM2FnV1pjY1VL?=
 =?utf-8?B?dUtycE8vQUkzdVo1THY5b1FwbFlBbllENmN0dldqWDgwL3Nub3J6NFVuT01Z?=
 =?utf-8?B?cjBoamEvZTA2NVlZVFVNaXlKUWRHV2VZWUEyTmJHWmhSQjI4QzNCK0Vvc01z?=
 =?utf-8?B?N1pGaEkyNVhNdEFjaG1DVEV2V2NHTC9hN0tqSnNkZnF0WnZsTUJlQkR0NWpn?=
 =?utf-8?B?TTBXS1FTK2RqeGNKZ1BsUVFJNjZSQW5vN0hkRmNSSWpmbXJqUEdMRUU4TWFZ?=
 =?utf-8?B?M2hrS0FDajRZR2NieEcvS2pRS1Awd1lzRWNHL09PcGRIYzRBeEphMThtSUVQ?=
 =?utf-8?B?UXN1bTUxZjVjZjg2LzRIMDZpd0h0NGdGNHhQbklhSlJYZWNRd2tWd1FEZkpT?=
 =?utf-8?B?Wi9pR3QzOFNKUzVGUHFpVXJIOGNxMGYvNjZ1SHNiU2dXSTZMYm03dkVwUmNS?=
 =?utf-8?B?UmVhbG0rUCs2MWJmNmpJNWExQWlSRFJLcDJVUU1KWEJFQTd2TlVoVXNKRzJ3?=
 =?utf-8?B?endOeEJVczdXN0JKMGNLT2dUQlFlNnVEN3hLdkZuVHowcyt0MjlMZXJLdWRv?=
 =?utf-8?B?UFYvUzE3angyZSt2L2hEd0pqY3AxTWc2anhnck5GU3hpUmwrNUtNQXBsUTNp?=
 =?utf-8?B?SDZ3cVUwak1rVCtzdVEwRnVnZDdSaWhtWE5VcE43dGU0YWZaZ3A3V29YcjBm?=
 =?utf-8?B?OFI2b1hvWHBaTTA4UEJPaHJ2RDY5QkFMb0g2UDFNMlZaUCtzYjNvQmVtbk9C?=
 =?utf-8?B?ampsd2hxZnhTSFJaM1F3TThrNkVVQWlDTTg2NHdIOCtFdHZuRDEwSjdKNVNr?=
 =?utf-8?B?TWJaWnBRWXJGaDlTZkI4V1A0UDRSNjFwNEVzV3pNdDIwTjBRWTlhZEMvRFU1?=
 =?utf-8?B?NUJEZnFjQm5FMDRsTEJRaE5lS1FJbGxMRFBlWHdadS8zcEZXL2d5Y1dETGJD?=
 =?utf-8?B?SVA0UGh3RVVhRkE0VXJvV0hNbzE3YThlcjBwUVBmb0h2NWkrdzIvVnFhTDNl?=
 =?utf-8?B?b08rQjRpMTJFOFpwTmsrM05Yc1JOODg4UmZxcVBWRGMzUWdnQ0swazdaZTFB?=
 =?utf-8?B?a3VZUmo2THliaDAwalk5aW4rT0ZVa291aTY0OU95U3drWktEYi9od3BNMU10?=
 =?utf-8?B?dzQvOEdodU1XZ1V0Z0M2Q1pBMjhSRXllSGg2THRWdmhxem5YU1ZRUTZTMkl4?=
 =?utf-8?B?Y3h0ZEpSQnFrbTEybjNYTTBad3JINzhFTEI0c215cGVMcm5kMEQyL29YQVFl?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9254.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d312fb7c-7ace-4e20-fcb4-08ddba987e0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2025 01:17:06.8969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: reQ6yXKCbLGOc3l4LhaYe4AOKOkKR/WWcxXDgy848VfEKyAqHVesm7sGHNMktbR94Otz59Uq0b+aD9G8ZVDv08GMJ5vS84QioVNX8oUUXto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF681F257FD
X-OriginatorOrg: intel.com

T24gRnJpZGF5LCBKdWx5IDQsIDIwMjUgMTowNSBBTSwgSmVzcGVyIERhbmdhYXJkIEJyb3VlciA8
aGF3a0BrZXJuZWwub3JnPiB3cm90ZToNCj5PbiAwMi8wNy8yMDI1IDE4LjU3LCBTb25nIFlvb25n
IFNpYW5nIHdyb3RlOg0KPj4gSW50cm9kdWNlIHRoZSBYRFBfTUVUQURBVEFfU0laRSBtYWNybyBh
cyBhIGNvbnNlcnZhdGl2ZSBtZWFzdXJlIHRvDQo+PiBhY2NvbW1vZGF0ZSBhbnkgbWV0YWRhdGEg
YXJlYXMgcmVzZXJ2ZWQgYnkgRXRoZXJuZXQgZGV2aWNlcy4NCj4+DQo+DQo+VGhpcyBzZWVtcyBs
aWtlIGEgc2xvcHB5IHdvcmthcm91bmQgOi0oDQo+DQo+VG8gbWUsIHRoZSBwcm9ibGVtIGFyaXNl
IGJlY2F1c2UgQUZfWERQIGlzIGxhY2tpbmcgdGhlIGFiaWxpdHkgdG8NCj5jb21tdW5pY2F0ZSB0
aGUgc2l6ZSBvZiB0aGUgZGF0YV9tZXRhIGFyZWEuICBJZiB3ZSBoYWQgdGhpcyBjYXBhYmlsaXR5
LA0KPnRoZW4gd2UgY291bGQgYWxsb3cgdGhlIElHQyBkcml2ZXIgdG8gdGFrZSBzb21lIG9mIHRo
ZSBzcGFjZSwgaGF2ZSB0aGUNCj5CUEYtcHJvZyBleHBhbmQgaXQgZnV0aGVyIChicGZfeGRwX2Fk
anVzdF9tZXRhKSBhbmQgdGhlbiB1c2Vyc3BhY2UNCj5BRl9YRFAgd291bGQgc2ltcGx5IGJlIGFi
bGUgdG8gc2VlIHRoZSBzaXplIG9mIHRoZSBkYXRhX21ldGEgYXJlYSwgYW5kDQo+YXBwbHkgdGhl
IHN0cnVjdCB4ZHBfbWV0YSBhdCByaWdodCBvZmZzZXQuDQo+DQpUaGFua3MgZm9yIHlvdXIgaW5w
dXQuDQoNCkkgYWdyZWUgd2l0aCB5b3UgdGhhdCB0aGUgaW1wbGVtZW50YXRpb24gd2lsbCBiZSBz
aW1wbGUgaWYgdXNlciBhcHBsaWNhdGlvbg0KYWJsZSB0byBnZXQgdGhlIHNpemUgb2YgZGF0YV9t
ZXRhIGFyZWEuIFRoZSBpbnRlbnRpb24gb2YgdGhpcyBwYXRjaCBzZXQgaXMgdG8gbGV0DQpkZXZl
bG9wZXIgYXdhcmUgb2Ygc3VjaCBsaW1pdGF0aW9ucyBiZWZvcmUgd2UgaGF2ZSBhIHBlcmZlY3Qg
c29sdXRpb24uDQoNCkJ0dywgZG8geW91IGdvdCBhbnkgc3VnZ2VzdGlvbiBvbiBob3cgdG8gZXhw
b3NlIHRoZSBtZXRhZGF0YSBsZW5ndGg/DQpJIG5vdCBzdXJlIHdoZXRoZXIgeGRwX2Rlc2Mub3B0
aW9ucyBpcyBhIHNpbXBsZSBhbmQgZ29vZCBpZGVhIG9yIG5vdD8NCg==

