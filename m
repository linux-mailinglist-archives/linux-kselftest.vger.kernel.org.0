Return-Path: <linux-kselftest+bounces-36344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 972A1AF5DB2
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 17:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FD23487394
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 15:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD0D2EE976;
	Wed,  2 Jul 2025 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZcC2xYBm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD04C2E7BA9;
	Wed,  2 Jul 2025 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751471800; cv=fail; b=DtMacUF60Tu2KNhIFRX6/sc76tgm/6YKkQDjC5+xKeRx9cqZEasfktfeiMG/Ry3OnGzqGgJSRQbI0gSbNtDi3wyLreWkGbjqXUA3F3NKLCBqTKgvx9f0pzyZfyxKigVzq8ui0NhPuEJZSBR5KQloS0OAIlSw7FiUIuF0d02BpPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751471800; c=relaxed/simple;
	bh=MLiQ6UyqsLEa1jKvn3sU3jm19jfKJ/3PGvOB6PvcMqQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kgszKZpML0xiKVAfnBrcH8zDugtoCLJZMLQkbX13JTUu0U55NRh3nVVA8F4pl6sTuu+EhxVVnVMuBiW5b1zxk4jHU4ZXXiIgNs7kYvlgKMoIq9FVT7KQktGzLYQzFqRIGD0KY6ujZAjtSZadqpwt6R6CbCQKDsQ/g2/j5d1djo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZcC2xYBm; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751471799; x=1783007799;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MLiQ6UyqsLEa1jKvn3sU3jm19jfKJ/3PGvOB6PvcMqQ=;
  b=ZcC2xYBmqApGtGgAwIWrARPBuhdwvB7vmufE2kxeGlfp0O3Tw8g0AaLR
   WGnGoIipJNB2H6VMn5qmoBnWlDBVZeHLBzHEPRt5mc70MbVIJQjYfXLDP
   Ehq6pyPQE0hdXWwlAXjvdP3INLKnPToZpYE/MHXbtyh4LthlqJU20bXT6
   0NuwlLfEwEeNn50SKhSwJD9vHbEwoioLZVOn7zp1vE03jh3cbJtq9WZyH
   KzSNJbHgfcs7DrNDBTJwUklkKhKmQxGBQu4+MV7was611Nu1lhb6F/xKL
   8M/nHHXWWPhX/zPrKwpXhC6ZeCeVpiI0jpSQDBZEdSl4fz5R7jVvgTsc1
   w==;
X-CSE-ConnectionGUID: SVkmPAr8QIywYy+3tvOTlQ==
X-CSE-MsgGUID: dDfKGb9WRdSiU7rU1Xw9fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="64019402"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="64019402"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 08:56:38 -0700
X-CSE-ConnectionGUID: FsSV6yXaSfuiB+5slGbzUQ==
X-CSE-MsgGUID: VpcrbAB+SISNv9X8iKewPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="177791850"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 08:56:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 08:56:36 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 08:56:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.74)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 08:56:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLz+TP8x5uMvOLo6ymCQ4lc9wO3lv3BFxXeTJSiEmkv4ATD7/0a3TtzLDfHpOQ3A/o2Si3iH2gtMR+9FwNwdHzR39RV2eXu4NCiuewueIr5424NI4RcZECTyxTST7FAaBKlknf6Ps95d/8M6eZhWwr6OpJ4f6jKWndo+e/8q31/ZE3WuxjPNaHmJUog6c8oq8qV7NiwtCaekd8VvnUdM3v7Lm+jmDuZoHv5fk6iwE+LMTJWZTg3muNJjhzF95+MevCe65VcAZEyBtBS2bzo+0pSQ0krG8IGm2IG5DW3W9s7cDSRXFaOcRvhCcTYJNBOJjf4sFw2spP8XGD+P+2BAow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLiQ6UyqsLEa1jKvn3sU3jm19jfKJ/3PGvOB6PvcMqQ=;
 b=jF6tmhlz5uaoM7rBcYMU4EXzQcCMm0DT+ucOOYmNvQ2pQPles1HcirTzh5LbXJlxovHY2HMFJy6iQUoqYedvyABg8EZNmABBQ2n1Jcei/hiEsUMM8BCCFWxJROdUb9atD23Rrskv4mGpblci5dXnrhNYcV66pb4OhbV+6z59swFCzxyATLZR3+oCsoASSfWUM3Gng2P0z6d0iQiFoUl8zS/B6WLPiYanto51xyrExKXT8VmbvwyGrDXCmqEfMXfXdFmScJz8FZcdi7VTNmAPg1oS9l1qVb5pdfn+1wEa0lkkMO2Z5jlExYIqmRd71G/4V2iwka8q18E2++Wq//N3aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9254.namprd11.prod.outlook.com (2603:10b6:208:573::10)
 by CH3PR11MB7868.namprd11.prod.outlook.com (2603:10b6:610:12e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Wed, 2 Jul
 2025 15:56:34 +0000
Received: from IA3PR11MB9254.namprd11.prod.outlook.com
 ([fe80::8547:f00:c13c:8fc7]) by IA3PR11MB9254.namprd11.prod.outlook.com
 ([fe80::8547:f00:c13c:8fc7%5]) with mapi id 15.20.8857.016; Wed, 2 Jul 2025
 15:56:34 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko
	<mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH bpf-next 2/2] selftests/bpf: Enhance XDP Rx Metadata
 Handling
Thread-Topic: [PATCH bpf-next 2/2] selftests/bpf: Enhance XDP Rx Metadata
 Handling
Thread-Index: AQHb6kEMHPOPYZSFok6IH5vzoGeGvLQddqWAgACgmGCAABl5kIAAw/mAgAAHb3A=
Date: Wed, 2 Jul 2025 15:56:34 +0000
Message-ID: <IA3PR11MB92541178AAF28F03639A9435D840A@IA3PR11MB9254.namprd11.prod.outlook.com>
References: <20250701042940.3272325-1-yoong.siang.song@intel.com>
 <20250701042940.3272325-3-yoong.siang.song@intel.com>
 <aGQNWXe6FBks8D3U@mini-arch>
 <IA3PR11MB925416396633E361F37E819DD840A@IA3PR11MB9254.namprd11.prod.outlook.com>
 <IA3PR11MB9254C961FD048793FD0013EAD840A@IA3PR11MB9254.namprd11.prod.outlook.com>
 <aGVN01flIJzvCo6S@mini-arch>
In-Reply-To: <aGVN01flIJzvCo6S@mini-arch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9254:EE_|CH3PR11MB7868:EE_
x-ms-office365-filtering-correlation-id: 07c6ecd9-1d0a-4a4c-a1ea-08ddb981052f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M0xHVEpnb3QyeDFucmMyNFhSRm44aHFqZXoyT1Brc0xpVkdYVkYyRzVPK0JP?=
 =?utf-8?B?WjJrT2tsR21uQUVRcGhXS0lScjQ3N1R4UnpieXg1bU1sMm0wS3EyMzFJZjdN?=
 =?utf-8?B?UUJZcE5oWGV4L2Z3L04vVVRtcjhSamRJVmVnOVRJRjFtZTlzZmptTWFIcXlx?=
 =?utf-8?B?M1NOd0dadzVjMHZMaDNTbG9OWEljWnJmNFkzRE9ieExUeGtYdlR0Y2hSeSsr?=
 =?utf-8?B?Q0JFbDB3ZGNHalhtbmFQUmM3WjcyeC84TWZLZGhzQ0h1VzR2UUFpR0RwODYv?=
 =?utf-8?B?YTJUcDVYTzZZbkphZjdGa1dzemN6c0ROaE5sbElkaXJzeXRpY0ZYaWMrdXNF?=
 =?utf-8?B?WEJoRHBVOGwxaVZmRkFnNFMwRVUwS3RVdVZia2l4K2FLSlgyOXVoc0JSc29W?=
 =?utf-8?B?dDFmc2V4bCt2WXgvRGQ4cnp1cDZhY0MwcXhYeThGaE9JczY0YmFWNklnajFU?=
 =?utf-8?B?YStmM1QwZUp2MnFHZUU0Mnl3WWFFRTFqZEg3cG1tN2FRMU4zc3AxS1M1TnUx?=
 =?utf-8?B?dzN4UWxpR0d1OUhBUS82WVI0K013UVc4VkY5VWNTNnltWENLTDdEbHpqTjBi?=
 =?utf-8?B?RG9lUjVmeUtFdCtxTmNUQmkzaERVVEQwZnNaMWd1YlloZkxNN2dRSkdtc0Fs?=
 =?utf-8?B?RzNrNU1LSTlIa0N1dTVRRUxiR2x6bVIvMmsvMEhyQ0NNa3A4eXdmUU1UQVd1?=
 =?utf-8?B?SnluUnBldkJGWEF0b3Q2UmppY3MxcldibFowQmZyUjJXTHRTZm5aYzFwQWx4?=
 =?utf-8?B?RTBlTHhwR1pvOEpiOHlKd20vK3BwcENnbmV6clYxNDY4TFNTdERrSHBLV29L?=
 =?utf-8?B?cWU1b0F2cWJMY3BrMmswb0l5SStYdEtvYjVmTnUzSDFQNlFWNTkyTEhmNmR4?=
 =?utf-8?B?Nk90UEF1Zk0yRGRzY2V6b0lzYnk1ZTFDTUpDUngvOWNySlNFaThuSFY0OEpy?=
 =?utf-8?B?U1pKNVZsaVUwK3QxbTV0b1dmTU9hbncya05GckpId0JBQ3dQb2ticlhCRUhI?=
 =?utf-8?B?U2J1aW93WXdLQkNBR0M4VUYyQ1VqKzB4ZENQbGNWNWhmOU8xWW1McDNCNjg4?=
 =?utf-8?B?TkF1bm4xU2lTUkhDK3RYRGx3UGJYTjd5V1RMZElxbG1XT0tHanBiMUdSZzh0?=
 =?utf-8?B?RDNhYitoU21OZkhxTFllTXdRUWdzRmkyQnkxaFVuSFZKR0RIK0s3ejlDbTFU?=
 =?utf-8?B?cXBOeG83cEJYcDVUWnB4cDBQQUZVOUNjUVZ5MFViMVRkYllsTGYvN1VsK3ZH?=
 =?utf-8?B?T2JuT21tTTlJSVc4SnJlVHRUZzhKaTZPNnp0UUxvR0o3d0EzRVhlL1RTOVhO?=
 =?utf-8?B?akovdGFPdk9NWkZudzJhelI4aHU0c1VkZUtCNTVPUlBURUJmb2p0c1V6R2xt?=
 =?utf-8?B?KzhVd05RVXlZZGc0SGRIYmw3TGVscUJjckwwQVBRRHhZZnhFS2FqaVFvUmty?=
 =?utf-8?B?VWY2SG9FaTNpUU1wcDAyNTZrL2Y3dHJJRFRGQkdvTkNiTUJtRnFFZXZMZG1n?=
 =?utf-8?B?OWgzTElXWXByM0hKVTdSVXpGNVlBeHh3aWdSYlI4c0dlTzVjNHlDVWgxcGxH?=
 =?utf-8?B?b1BURlBPaUVOMWluWjZvaDRiS1U3ckcrSHNrd1lCQUZLcFREcjZ2VUFycWkw?=
 =?utf-8?B?NHFsd01wOVJ5ZlBzeEo4VXoxLy8wSXlYeE9VclpDWlVra1I0M3Z2VXZFZnZv?=
 =?utf-8?B?cExJSW9jdmRoTFN4dVkvckMzUkRPV3ljeGd5a2RyUUFIc0JEcUZOZWtjenlN?=
 =?utf-8?B?NW1SSWJJdFNMRk4vN3FjY0pIVUQxelFBeG15YnlPQzRBc0FxdzVzM3dFSWl6?=
 =?utf-8?B?Ym54VDVGNk0xM0lWTW5NOFFQMFdZM1lZdHNTK1pRK2ZEUkdPd3piVXdQRmho?=
 =?utf-8?B?RjErbDNpU1ZUeFRSMXFYYjFmTjg1UWVzWlVpOWVxaXFhUjVyb0szSnhsTVNZ?=
 =?utf-8?B?OXR6TkRYZy9zWWFITjNSbFk5SVAwQ0VTZHJPVFVITEpmaEZZdGxTUUN2TTZR?=
 =?utf-8?Q?1gU2uIpl96pqDUra7lceIVAMyD9FCg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9254.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UndORVBnL1JmdkszaWxvak1CUktUZXhHU3lDUFVMeFFjMFozQXl0Vkpxdy80?=
 =?utf-8?B?RmNQZEVnK291enp6a3BTR1Rpd2EvaDZ3WDhuekp6U1duNlNYMFhWTENlQ3dr?=
 =?utf-8?B?Q0svMmsvMFdkV0N1UGQ4bjczYW9tZVZMcHVIY050VkRlQzZWZTFRblVMZ2tv?=
 =?utf-8?B?VFZEWmUyRUFhUUpONTdpSnN1SkdOVjdaRXRaSUZhclFObWFLekp3NDE3VGJ4?=
 =?utf-8?B?TDU5NVAwWi91RTNGV2pCSzA2MGN3NmdOVjJqRzNacHR0Nk9hdWhzTmVQd3Zy?=
 =?utf-8?B?a01CQ2cvWHVhQ3ZqNmkzVzZQa1pCdWxabElyRzZOdmlIdWYveGd3clVxdFRu?=
 =?utf-8?B?eEI4a1F3RlR4eHdhc1dwMnk2dEVmWjdrNW1MSFlWeEEvdzhDMUNla1VaOHV1?=
 =?utf-8?B?T2cxWmVCUjJiQ0hlU1ZFVk9tcngwV3YyWlk1a1VUc2pyRkNheTdiS1cyMUVo?=
 =?utf-8?B?ejNTSWZBSTNmRTQ2dUJZdFJPR0NyUFdSRUFZSWw1ZSsyb1RhRzRvOW5ZcWFW?=
 =?utf-8?B?ZG5xdnBReHpZM1V6c2ZLelp1dDg4ZmJsajE4N2MraEo5ZnJMSGJxdFRBS1pE?=
 =?utf-8?B?MG1GUmI1dnhVOWJkdE8wQkNyOFk1c0VtWi9MZEI4WnFUMXFod3gzSzlreXhL?=
 =?utf-8?B?VjhlaHVrQXpXV3ZWQU9UdUo5ekxqYjNza3hRZFordWFYMHJEOVpEZmIrVW4w?=
 =?utf-8?B?VXNoWTJ2Q2VNRmUvK1hEVFRERWRxZ0IwaFJmS0hpeXNkRDRVTnNBQ1k5dXZl?=
 =?utf-8?B?Y2h1Y1Z5ei9kVlZueE82eGJHM1NtR1hJbXB5VDNPUjNic3R1RG8zNEdEczlW?=
 =?utf-8?B?MFVoQVRBaTkya1VvTEJ2eGh6WHFvdXQ0ZEdPQnNIRFg5bDQ2c25HWTdaU05C?=
 =?utf-8?B?SVJvWHRzdjZEUStoaU42S3IwNDNQcEJrbVUycjJRSDlCSkllelluQ0NrY3JS?=
 =?utf-8?B?cS9LT0tjSWlsMFVQbU1pWGtEeUdTVE9ZVnliRDBYV3RzRGVuTGQzenM1cHdD?=
 =?utf-8?B?ZE9xMWF5VUlUT1d2RWkyandrNUZNK0NpdW9CbXh1OVo1NFdMQTZmNktVYitN?=
 =?utf-8?B?NUorU05Fb2c2V0JVVVNueHMrU3NSNE9JVjREb0toby9HRTZoa2JaRUtMdTlG?=
 =?utf-8?B?VytrNlEvdnY2NTFPQXdNOTVCUmh5WnBpdjhxaFF0RHRGUGVxbTV0aVhPRjRa?=
 =?utf-8?B?TnFuL2dkMUl0bmJweHdybXJUbXRMQ1MxUFJwb2Uxa3IzZk5MSTZBc1Y5R1NC?=
 =?utf-8?B?SkUvckZEdm5NSEZFMHdQbTBiSEZlWFB4eCtkeWxqQk1EVUU4ZXZ6TGZYTHU3?=
 =?utf-8?B?M3o5UHZQcXNWTW1wdnE3UjJPTGREdXdHZ2hXMWRXUENvdG5Xd01tcmRueEl6?=
 =?utf-8?B?dGMxcjd4b01uMnFoSDZZVTBHU1NpcmsxLzZROVBXR21JZGlONEx2RFM1cnls?=
 =?utf-8?B?Q3J4dDFEUjA5ZHd5aGhtdk9SR215R1dYM3ltdW5YWUtuakVGMFpBQ0hQZTgr?=
 =?utf-8?B?N3V6LzJ6RytZZFkyQnZGei9ZUHluQm1DNThaZFhERWJwQml4TDM0Y3dwaW0z?=
 =?utf-8?B?NzdiQSs0dUk5Y3plaVFJN01rMjRhRVlaVGEzZlFQdWRDN2UrUWdETFJVZ0xZ?=
 =?utf-8?B?bXJJUlMzeXNvcEl4ZEpSQ1FiSlR2a2JKb0kvUFBjZWdVOHV5K211akFkU2Jp?=
 =?utf-8?B?OUhEM2R2YlhST2tTMXl6MnJ4emhnWDRHSTA5elBRQW9OclNBTVUzWllEM0Ny?=
 =?utf-8?B?end0UW9kNUpsYUdWSmx2NGduWGw0TUlaYnlWa1NvQVg4RzZnQVJVUVdKUlVI?=
 =?utf-8?B?S0tobXExTVQ0a0UrMFVHYTlyblZkcURhaDBwUlJ1MkEwUkFjUHJ6VllsL1Ax?=
 =?utf-8?B?WDlUMHpTMFRUTkF3WForVVMvTWlJSVVwQk1CelFxbXZIZUxIdEJpQmwwMDVH?=
 =?utf-8?B?d0tzWUtsYWpwR29HMFYybXVwcTJUS0NrUnhTdmNjUExzWndkL3ZTRE8vQUIx?=
 =?utf-8?B?WC84M2NqMkljNzRjbnB5US9EMkVsaW8vQ202QTd2U1N2eHBXenNrWkp5Q3ho?=
 =?utf-8?B?cmZ6a1BVeWN3RFNUMlI4US94UVVSOUhwZjd6U3ZONi8vUlNCVnZNSnJIYlJk?=
 =?utf-8?B?NnJkdktRYzFneWMyNG9EVjRHek1reCtDcUhnWW5TYm9uYzJFRnVqdGxjKytH?=
 =?utf-8?B?Vnc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c6ecd9-1d0a-4a4c-a1ea-08ddb981052f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 15:56:34.5207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cZ1iMYN/IVVyW+0VbnbKRDogCUmcRieZ0MNy902ahthIXN32cCDuq8qtm7YcUMf/zywZuEWZjNp9btGbPKfRNT76gjWjV5kcBW4lHor0hyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7868
X-OriginatorOrg: intel.com

T24gV2VkbmVzZGF5LCBKdWx5IDIsIDIwMjUgMTE6MTkgUE0sIFN0YW5pc2xhdiBGb21pY2hldiA8
c3Rmb21pY2hldkBnbWFpbC5jb20+IHdyb3RlOg0KPk9uIDA3LzAyLCBTb25nLCBZb29uZyBTaWFu
ZyB3cm90ZToNCj4+IE9uIFdlZG5lc2RheSwgSnVseSAyLCAyMDI1IDEwOjIzIEFNLCBTb25nLCBZ
b29uZyBTaWFuZw0KPjx5b29uZy5zaWFuZy5zb25nQGludGVsLmNvbT4gd3JvdGU6DQo+PiA+T24g
V2VkbmVzZGF5LCBKdWx5IDIsIDIwMjUgMTI6MzEgQU0sIFN0YW5pc2xhdiBGb21pY2hldg0KPjxz
dGZvbWljaGV2QGdtYWlsLmNvbT4NCj4+ID53cm90ZToNCj4+ID4+T24gMDcvMDEsIFNvbmcgWW9v
bmcgU2lhbmcgd3JvdGU6DQo+PiA+Pj4gSW50cm9kdWNlIHRoZSBYRFBfTUVUQURBVEFfU0laRSBt
YWNybyB0byBlbnN1cmUgdGhhdCB1c2VyIGFwcGxpY2F0aW9ucyBjYW4NCj4+ID4+PiBjb25zaXN0
ZW50bHkgcmV0cmlldmUgdGhlIGNvcnJlY3QgbG9jYXRpb24gb2Ygc3RydWN0IHhkcF9tZXRhLg0K
Pj4gPj4+DQo+PiA+Pj4gUHJpb3IgdG8gdGhpcyBjb21taXQsIHRoZSBYRFAgcHJvZ3JhbSBhZGp1
c3RlZCB0aGUgZGF0YV9tZXRhIGJhY2t3YXJkIGJ5DQo+PiA+Pj4gdGhlIHNpemUgb2Ygc3RydWN0
IHhkcF9tZXRhLCB3aGlsZSB0aGUgdXNlciBhcHBsaWNhdGlvbiByZXRyaWV2ZWQgdGhlIGRhdGEN
Cj4+ID4+PiBieSBjYWxjdWxhdGluZyBiYWNrd2FyZCBmcm9tIHRoZSBkYXRhIHBvaW50ZXIuIFRo
aXMgYXBwcm9hY2ggb25seSB3b3JrZWQgaWYNCj4+ID4+PiB4ZHBfYnVmZi0+ZGF0YV9tZXRhIHdh
cyBlcXVhbCB0byB4ZHBfYnVmZi0+ZGF0YSBiZWZvcmUgY2FsbGluZw0KPj4gPj4+IGJwZl94ZHBf
YWRqdXN0X21ldGEuDQo+PiA+Pj4NCj4+ID4+PiBXaXRoIHRoZSBpbnRyb2R1Y3Rpb24gb2YgWERQ
X01FVEFEQVRBX1NJWkUsIGJvdGggdGhlIFhEUCBwcm9ncmFtIGFuZCB1c2VyDQo+PiA+Pj4gYXBw
bGljYXRpb24gbm93IGNhbGN1bGF0ZSBhbmQgaWRlbnRpZnkgdGhlIGxvY2F0aW9uIG9mIHN0cnVj
dCB4ZHBfbWV0YSBmcm9tDQo+PiA+Pj4gdGhlIGRhdGEgcG9pbnRlci4gVGhpcyBlbnN1cmVzIHRo
ZSBpbXBsZW1lbnRhdGlvbiByZW1haW5zIGZ1bmN0aW9uYWwgZXZlbg0KPj4gPj4+IHdoZW4gdGhl
cmUgaXMgZGV2aWNlLXJlc2VydmVkIG1ldGFkYXRhLCBtYWtpbmcgdGhlIHRlc3RzIG1vcmUgcG9y
dGFibGUNCj4+ID4+PiBhY3Jvc3MgZGlmZmVyZW50IE5JQ3MuDQo+PiA+Pj4NCj4+ID4+PiBTaWdu
ZWQtb2ZmLWJ5OiBTb25nIFlvb25nIFNpYW5nIDx5b29uZy5zaWFuZy5zb25nQGludGVsLmNvbT4N
Cj4+ID4+PiAtLS0NCj4+ID4+PiAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVz
dHMveGRwX21ldGFkYXRhLmMgfCAgMiArLQ0KPj4gPj4+ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9icGYvcHJvZ3MveGRwX2h3X21ldGFkYXRhLmMgICB8IDEwICsrKysrKysrKy0NCj4+ID4+PiAg
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL3hkcF9tZXRhZGF0YS5jICAgICAgfCAg
OCArKysrKysrLQ0KPj4gPj4+ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYveGRwX2h3X21l
dGFkYXRhLmMgICAgICAgICB8ICAyICstDQo+PiA+Pj4gIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2JwZi94ZHBfbWV0YWRhdGEuaCAgICAgICAgICAgIHwgIDcgKysrKysrKw0KPj4gPj4+ICA1IGZp
bGVzIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+PiA+Pj4NCj4+
ID4+PiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMv
eGRwX21ldGFkYXRhLmMNCj4+ID4+Yi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ190
ZXN0cy94ZHBfbWV0YWRhdGEuYw0KPj4gPj4+IGluZGV4IDE5ZjkyYWZmYzJkYS4uOGQ2YzI2MzM2
OThiIDEwMDY0NA0KPj4gPj4+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9n
X3Rlc3RzL3hkcF9tZXRhZGF0YS5jDQo+PiA+Pj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvYnBmL3Byb2dfdGVzdHMveGRwX21ldGFkYXRhLmMNCj4+ID4+PiBAQCAtMzAyLDcgKzMwMiw3
IEBAIHN0YXRpYyBpbnQgdmVyaWZ5X3hza19tZXRhZGF0YShzdHJ1Y3QgeHNrICp4c2ssIGJvb2wN
Cj4+ID4+c2VudF9mcm9tX2FmX3hkcCkNCj4+ID4+Pg0KPj4gPj4+ICAJLyogY3VzdG9tIG1ldGFk
YXRhICovDQo+PiA+Pj4NCj4+ID4+PiAtCW1ldGEgPSBkYXRhIC0gc2l6ZW9mKHN0cnVjdCB4ZHBf
bWV0YSk7DQo+PiA+Pj4gKwltZXRhID0gZGF0YSAtIFhEUF9NRVRBREFUQV9TSVpFOw0KPj4gPj4+
DQo+PiA+Pj4gIAlpZiAoIUFTU0VSVF9ORVEobWV0YS0+cnhfdGltZXN0YW1wLCAwLCAicnhfdGlt
ZXN0YW1wIikpDQo+PiA+Pj4gIAkJcmV0dXJuIC0xOw0KPj4gPj4+IGRpZmYgLS1naXQgYS90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MveGRwX2h3X21ldGFkYXRhLmMNCj4+ID4+Yi90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MveGRwX2h3X21ldGFkYXRhLmMNCj4+ID4+
PiBpbmRleCAzMzBlY2UyZWFiZGIuLjcyMjQyYWMxY2RjZCAxMDA2NDQNCj4+ID4+PiAtLS0gYS90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MveGRwX2h3X21ldGFkYXRhLmMNCj4+ID4+
PiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MveGRwX2h3X21ldGFkYXRh
LmMNCj4+ID4+PiBAQCAtMjcsNiArMjcsNyBAQCBleHRlcm4gaW50IGJwZl94ZHBfbWV0YWRhdGFf
cnhfdmxhbl90YWcoY29uc3Qgc3RydWN0DQo+PiA+PnhkcF9tZCAqY3R4LA0KPj4gPj4+ICBTRUMo
InhkcC5mcmFncyIpDQo+PiA+Pj4gIGludCByeChzdHJ1Y3QgeGRwX21kICpjdHgpDQo+PiA+Pj4g
IHsNCj4+ID4+PiArCWludCBtZXRhbGVuX3VzZWQsIG1ldGFsZW5fdG9fYWRqdXN0Ow0KPj4gPj4+
ICAJdm9pZCAqZGF0YSwgKmRhdGFfbWV0YSwgKmRhdGFfZW5kOw0KPj4gPj4+ICAJc3RydWN0IGlw
djZoZHIgKmlwNmggPSBOVUxMOw0KPj4gPj4+ICAJc3RydWN0IHVkcGhkciAqdWRwID0gTlVMTDsN
Cj4+ID4+PiBAQCAtNzIsNyArNzMsMTQgQEAgaW50IHJ4KHN0cnVjdCB4ZHBfbWQgKmN0eCkNCj4+
ID4+PiAgCQlyZXR1cm4gWERQX1BBU1M7DQo+PiA+Pj4gIAl9DQo+PiA+Pj4NCj4+ID4+PiAtCWVy
ciA9IGJwZl94ZHBfYWRqdXN0X21ldGEoY3R4LCAtKGludClzaXplb2Yoc3RydWN0IHhkcF9tZXRh
KSk7DQo+PiA+Pg0KPj4gPj5bLi5dDQo+PiA+Pg0KPj4gPj4+ICsJbWV0YWxlbl91c2VkID0gY3R4
LT5kYXRhIC0gY3R4LT5kYXRhX21ldGE7DQo+PiA+Pg0KPj4gPj5JcyB0aGUgaW50ZW50IGhlcmUg
dG8gcXVlcnkgaG93IG11Y2ggbWV0YWRhdGEgaGFzIGJlZW4gY29uc3VtZWQvcmVzZXJ2ZWQNCj4+
ID4+YnkgdGhlIGRyaXZlcj8NCj4+ID5ZZXMuDQo+PiA+DQo+PiA+Pkxvb2tpbmcgYXQgSUdDIGl0
IGhhcyB0aGUgZm9sbG93aW5nIGNvZGUvY29tbWVudDoNCj4+ID4+DQo+PiA+PgliaS0+eGRwLT5k
YXRhICs9IElHQ19UU19IRFJfTEVOOw0KPj4gPj4NCj4+ID4+CS8qIEhXIHRpbWVzdGFtcCBoYXMg
YmVlbiBjb3BpZWQgaW50byBsb2NhbCB2YXJpYWJsZS4gTWV0YWRhdGENCj4+ID4+CSAqIGxlbmd0
aCB3aGVuIFhEUCBwcm9ncmFtIGlzIGNhbGxlZCBzaG91bGQgYmUgMC4NCj4+ID4+CSAqLw0KPj4g
Pj4JYmktPnhkcC0+ZGF0YV9tZXRhICs9IElHQ19UU19IRFJfTEVOOw0KPj4gPj4NCj4+ID4+QXJl
IHlvdSBzdXJlIHRoYXQgbWV0YWRhdGEgc2l6ZSBpcyBjb3JyZWN0bHkgZXhwb3NlZCB0byB0aGUg
YnBmIHByb2dyYW0/DQo+PiA+WW91IGFyZSByaWdodCwgdGhlIGN1cnJlbnQgaWdjIGRyaXZlciBk
aWRuJ3QgZXhwb3NlIHRoZSBtZXRhZGF0YSBzaXplIGNvcnJlY3RseS4NCj4+ID5JIHN1Ym1pdHRl
ZCBbMV0gdG8gZml4IGl0Lg0KPj4gPg0KPj4gPlsxXSBodHRwczovL3BhdGNod29yay5vemxhYnMu
b3JnL3Byb2plY3QvaW50ZWwtd2lyZWQtDQo+PiA+bGFuL3BhdGNoLzIwMjUwNzAxMDgwOTU1LjMy
NzMxMzctMS15b29uZy5zaWFuZy5zb25nQGludGVsLmNvbS8NCj4+ID4NCj4+ID4+DQo+PiA+Pk15
IGFzc3VtcHRpb25zIHdhcyB0aGF0IHdlIHNob3VsZCBqdXN0IHVuY29uZGl0aW9uYWxseSBkbw0K
PmJwZl94ZHBfYWRqdXN0X21ldGENCj4+ID4+d2l0aCAtWERQX01FVEFEQVRBX1NJWkUgYW5kIHRo
YXQgc2hvdWxkIGJlIGdvb2QgZW5vdWdoLg0KPj4gPg0KPj4gPlRoZSBjaGVja2luZyBpcyBqdXN0
IGZvciBwcmVjYXV0aW9ucy4gTm8gcHJvYmxlbSBpZiBkaXJlY3RseSBhZGp1c3QgdGhlIG1ldGEN
Cj4+ID51bmNvbmRpdGlvbmFsbHkuDQo+PiA+VGhhdCB3aWxsIHNhdmUgcHJvY2Vzc2luZyB0aW1l
IGZvciBlYWNoIHBhY2tldCBhcyB3ZWxsLg0KPj4gPkkgd2lsbCByZW1vdmUgdGhlIGNoZWNraW5n
IGFuZCBzdWJtaXQgdjIuDQo+PiA+DQo+PiA+VGhhbmtzICYgUmVnYXJkcw0KPj4gPlNpYW5nDQo+
PiA+DQo+Pg0KPj4gSGkgU3RhbmlzbGF2IEZvbWljaGV2LA0KPj4NCj4+IEkgc3VibWl0dGVkIHYy
LiBCdXQgYWZ0ZXIgdGhhdCwgSSB0aGluayB0d2ljZS4gSU1ITywNCj4+IGVyciA9IGJwZl94ZHBf
YWRqdXN0X21ldGEoY3R4LCAoaW50KShjdHgtPmRhdGEgLSBjdHgtPmRhdGFfbWV0YSAtDQo+WERQ
X01FVEFEQVRBX1NJWkUpKTsNCj4+IGlzIGJldHRlciB0aGFuDQo+PiBlcnIgPSBicGZfeGRwX2Fk
anVzdF9tZXRhKGN0eCwgLShpbnQpWERQX01FVEFEQVRBX1NJWkUpOw0KPj4gYmVjYXVzZSBpdCBp
cyBtb3JlIHJvYnVzdC4NCj4+DQo+PiBBbnkgdGhvdWdodHM/DQo+DQo+TXkgcHJlZmVyZW5jZSBp
cyBvbiBrZWVwaW5nIGV2ZXJ5dGhpbmcgYXMgaXMgYW5kIGNvbnZlcnRpbmcgdG8NCj4tKGludClY
RFBfTUVUQURBVEFfU0laRS4gTWFraW5nIElHQyBwcm9wZXJseSBleHBvc2UgKHRlbXBvcmFyeSkg
bWV0YWRhdGEgbGVuDQo+aXMgYSB1c2VyIHZpc2libGUgY2hhbmdlLCBub3Qgc3VyZSB3ZSBoYXZl
IGEgZ29vZCBqdXN0aWZpY2F0aW9uPw0KDQpUaGFuayB5b3UgZm9yIHlvdXIgZmVlZGJhY2suIEkg
YWdyZWUgdGhhdCB3ZSBkb24ndCBoYXZlIGEgc3Ryb25nIGp1c3RpZmljYXRpb24NCmZvciBtYWtp
bmcgdGhlIG1ldGFkYXRhIGxlbmd0aCB1c2VyLXZpc2libGUgYXQgdGhpcyB0aW1lLiBJIGNvbmN1
ciB3aXRoIHlvdXINCnByZWZlcmVuY2UgdG8ga2VlcCBldmVyeXRoaW5nIGFzIGlzIGFuZCBwcm9j
ZWVkIHdpdGggLShpbnQpWERQX01FVEFEQVRBX1NJWkUuDQoNCkJ0dywgZG8geW91IHRoaW5rIHdo
ZXRoZXIgbXkgZmlyc3QgcGF0Y2ggd2hpY2ggY2hhbmdlcyB0aGUgZG9jdW1lbnRhdGlvbiBpcw0K
c3RpbGwgbmVlZGVkIG9yIG5vdD8NCg0K

