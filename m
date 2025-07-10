Return-Path: <linux-kselftest+bounces-37005-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E92F2B00766
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 17:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C59B5807B0
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 15:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CC3277CA1;
	Thu, 10 Jul 2025 15:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aedIKvlt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FAA275844;
	Thu, 10 Jul 2025 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161741; cv=fail; b=m39bdszH2zNHlwYZPt8MzvB6u0ZH14Iy429ne/iSYCxgIelwe/DYjLajmrKmekBHhPO2xNYnW74PNC1xC5qOW0Iiu+oQ+6G43tkbY84BbQYdLgVcvPfoqWB0JNS5nuRMzm+5vA1zQnim6LHn7qVInrca70vDI77/hKX8+/A7RIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161741; c=relaxed/simple;
	bh=VxDvMx+xYiIiO4D5nHyD9x1hSQfdJlYeXYtB3T/mAyU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MojNjkkRQh9RnLIdBF8IW9P6KhK+dZpGhmygNV1AT/vGtROK6LOqQ5CVUf0uK4mWh1ozSreA2G7sJ/+JUxEyfYSdUH0uNboZhtCZq5/KnoxogQ+i9sU64ClSoCn7JCvvfSh9Op9XKLduKC4uRYfFNiS4NSDYfKeioSLpZ+4qnkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aedIKvlt; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752161739; x=1783697739;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VxDvMx+xYiIiO4D5nHyD9x1hSQfdJlYeXYtB3T/mAyU=;
  b=aedIKvlt6qoQ8/zFaOJ/exzetUEIN5QlS19vzfyriUgzIJSKpWEKhWb9
   NTfV/EXTfLAps42to+JjKp++cVVT6GiS7bNWDBfNVzeqxgguS2NkuJBqx
   umXD/ojGTchW3oN/WU5tKX631YjA/ugEoF/oy4THfp0IMep9/l3WX7E+a
   V/sx+H9Q8OSFtwo6T0FNR7tQcBjPGX97i5V4Rr8rwn8KKFqubRTlIcJnm
   08T+2WcnoTkQG9KzV/Bj59S9fLUva4w1KsjmDwA/P4zhaAsXbpQlhUOLJ
   e6eGhzYIe4xA9igaSSoD33hZtli1RlJG0cF5nngRvJUY+mRU+gIAXjVnX
   w==;
X-CSE-ConnectionGUID: I/UZ5kG4QcehBMqjFVZoBg==
X-CSE-MsgGUID: g9uufKRmR9m8kgyp88a0bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="72032699"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="72032699"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 08:35:38 -0700
X-CSE-ConnectionGUID: gN9HJx0uQ+SWFNBbg5C70Q==
X-CSE-MsgGUID: lvcTmcKgR0SnS7ThWENzXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="160146233"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 08:35:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 08:35:36 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 08:35:36 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.87) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 08:35:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9YZ2sl66NvEfoDYhO80eqjsV2SCj3kFUHZhFRBIJMCHPpNPZllL3fX8o7alPK/v0gnAH/r7Fz8dv8NTGq18wYZMgDAhAYI3VfvmqPtElwpKXuothnnNEB2ta8CEUZf51yQXqCcEkbDmqeJbV09HUpEZGEPvZLc3AkxN7hm+52TkNE6j1cG8qtLniMviLTdtaYPfQ50Vo6ZcDWdq74CiFCyarw8BpO9+SvJWwHhYbRKK1jDN6tTyjpfc+aWeJxVaoCh2RTVRbQlXVVs4m+JfkK7GhrX2OyG3+xbSphyX38BN55qXzBBsRhkeH3EpzsUtDSP7oEhfSE/kfSJgIuTIJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxDvMx+xYiIiO4D5nHyD9x1hSQfdJlYeXYtB3T/mAyU=;
 b=xaL/l0czZfHsdt9MAT0Kbb6NCphv+2zzWnKD2DtMyTwbGL7526+r8KV3niBVr1Y9j/g9SCU8EgqTsSM0DA8Fkr1jZW1X3GqCSsqG6QXK8c5Dt7pB5fvpLTYZqekB14J50Yn9dOuXnYOR3LfDNEx1ulv+MHc6iSjhw4Q5fRWhPi38AvYGAjeyGGjCBVFMYtYHkw1fGgs/IZjYQ9vBRqLXYEqorVslacHUrSC3bnjK4QMxVNwKc2WVopqlHxf+PkBGX4jnkBa0Y4fb4SH2BCi0W1wajPv1pXcOFMrrC5+s92WUnjKDku7OE2pHoaJOLstmgtk7LNILQuaA0DI12KOCGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9254.namprd11.prod.outlook.com (2603:10b6:208:573::10)
 by IA4PR11MB9252.namprd11.prod.outlook.com (2603:10b6:208:561::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 10 Jul
 2025 15:35:33 +0000
Received: from IA3PR11MB9254.namprd11.prod.outlook.com
 ([fe80::8547:f00:c13c:8fc7]) by IA3PR11MB9254.namprd11.prod.outlook.com
 ([fe80::8547:f00:c13c:8fc7%5]) with mapi id 15.20.8901.023; Thu, 10 Jul 2025
 15:35:32 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: Stanislav Fomichev <stfomichev@gmail.com>, Daniel Borkmann
	<daniel@iogearbox.net>
CC: Jesper Dangaard Brouer <hawk@kernel.org>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov
	<ast@kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
	"Song Liu" <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan
	<shuah@kernel.org>, Magnus Karlsson <magnus.karlsson@gmail.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH bpf-next,v3 2/2] selftests/bpf: Enhance XDP Rx metadata
 handling
Thread-Topic: [PATCH bpf-next,v3 2/2] selftests/bpf: Enhance XDP Rx metadata
 handling
Thread-Index: AQHb63K+8Xxuwt12i0SASQIfKldL1rQgojsAgAB9hECAAJ3HgIAAG8kAgATwcACAAxLsAIAAKZ8AgAF7V+A=
Date: Thu, 10 Jul 2025 15:35:32 +0000
Message-ID: <IA3PR11MB92540CF6DB5BCFD34384A280D848A@IA3PR11MB9254.namprd11.prod.outlook.com>
References: <20250702165757.3278625-1-yoong.siang.song@intel.com>
 <20250702165757.3278625-3-yoong.siang.song@intel.com>
 <77463344-1b1a-443a-97be-a7ef8a88b8af@kernel.org>
 <IA3PR11MB92546301B67FB3A9FDCD716DD842A@IA3PR11MB9254.namprd11.prod.outlook.com>
 <88a64a65-bd8c-4b73-af19-6764054d4572@kernel.org>
 <f5d724ab-0eb6-41a1-b694-8aea566e99ab@iogearbox.net>
 <aGvhzDLSuOolCCWW@mini-arch>
 <27edae8a-f1a8-4000-ac1e-fd4d5b01e807@iogearbox.net>
 <aG6Y1J9Li2DdjqWv@mini-arch>
In-Reply-To: <aG6Y1J9Li2DdjqWv@mini-arch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9254:EE_|IA4PR11MB9252:EE_
x-ms-office365-filtering-correlation-id: cfb806ef-f414-407f-99ae-08ddbfc7687d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M1BxOEJyMlhyWTFWNFg0LytFSXh4c3ZONlY0elBBK0hEaWlmU0JXTlRoMEJv?=
 =?utf-8?B?UGNVQUJGblo4SGFFcEhDS1l3c3F2TjU2QWdtd1BWYS9ONENDc0tTY0NrZ21r?=
 =?utf-8?B?S1UwOHhmOWJUbHRqWGRvOTFPOGpDYzlnazYvVEZaWEw0bXU0TVYvL28vNUg5?=
 =?utf-8?B?cFNBUVZ1MDNCUWJrU3pPRHlqQlpvUi9JTk5QU003Ti9UcytMd0JiYVV6M2NB?=
 =?utf-8?B?cnFncjVwMWZsdVJHMkdMcjVZSk0vMXl0UmtUUERFMFQ1MTRBOTV1SVNvcVpa?=
 =?utf-8?B?MjRKd1dOSE5kNkh1SnBoMFQwTE1HQWR3STRKZUgrbHRDRWp1a2pSTEZxZUV1?=
 =?utf-8?B?Qk4xOFpaU3R0cDNyY3IrMURJeElNb3ZFS0xuRkwwRi84blFFZWR2VlhOQWxC?=
 =?utf-8?B?c2xCM0JIYk43Sm4rWDJUUXJDWVcrR1lRRVN4ZWI0QUhqcFVtT0hoTUZUY2ZZ?=
 =?utf-8?B?emdxY2JLaXZzVzRUZ293MXoxWTg5b2FzcGNNQzRXV0VER3B2Mk9uSU5ic21z?=
 =?utf-8?B?WHhMOUt3SHVMQSs0VUV4TDFlVHMvL1l6NFRyL0dRWmtkb2dQOXkzVEU4NXNy?=
 =?utf-8?B?RWRLWW5INXVmTEorRm1Nd1A1aVpzSm1RSnRrOWJObEo3cFZsQXY2RGw2OW5y?=
 =?utf-8?B?R2JQTlpQZ3JPTVB5dENERFEyY0dMVVMzS3ZXL0lpa1VTZFdkSjJ2cG4rZmVC?=
 =?utf-8?B?dTBBNUFoRnZLRDVFa3ZLYjlRYjhyN0o0SXNqRkVDVjM5NE1BNkhKb0lTU3Qw?=
 =?utf-8?B?dWY4TEo2azZscnNkRVBNSEk5d1pEaDd1Qk1IRlpURnNWRE5iMFh2VWRXNFd0?=
 =?utf-8?B?ZWJPbE4vY2ZUTU4yYm91TDlrZ2wvdHREM0N0YysxZTZVUTN5SGVlR1dqU2pT?=
 =?utf-8?B?QW9CZC9tazBkdkVIZVBBTnY3YVhEQ0QxY2xBenI1cWRYcmxJTEd6V1dHRERT?=
 =?utf-8?B?SlNwdHlwK3pIdmJzYjZTbTNJNkNrSEQ0ZU45U2haRlE5bjVoK1NDQXl2cHJX?=
 =?utf-8?B?STVZTVFLRDhLRzdaQW80dmJBRTJTK0Z0TTJIckpnUjNuQXB4ZndCRFZvSHNi?=
 =?utf-8?B?SXB3K3E5ZVV3QkwwbXJleHlCcWVsNVVDWnVyODB3M29YemRvUjF2OEVOa0Jh?=
 =?utf-8?B?Zjd3SDB3QjJMaGp0VXBMbHR6TW5tMzJBeW0vSjFYd0ZFNDBvUnltRU5lOTlY?=
 =?utf-8?B?TkVGcTUxN3ZxWXJaRGE4czcwdDliVHp2Z3FvT1dPaUZXMCswdWxyNHlUWnA4?=
 =?utf-8?B?cEZkTTVueDlmVWpUN0hCcHMrdGUvOU9KQWFXK0hWUXcwdzc0THBkV2h0d2wx?=
 =?utf-8?B?d1JoTXJBZXR6VFZsL0dOSk5oR2pvTnozVmlqVHc1QWtmTlA2d3JkUElzMnNZ?=
 =?utf-8?B?cEhhU0sydFlTb09PS3B5RFdubFJ2dll5RVNldXdjT3BIVWU4MkhScFZvTmlF?=
 =?utf-8?B?ZkRFU3BrNlFPb0ZTWnF6STY4a1lUQk9STm1TMGdhYkRjQ3VhN256QnNxQ1Bq?=
 =?utf-8?B?bVdSV2Rad3hTaXlnUHpwTFlCOUIycTRkOEIxVkhpUEQvdmlMMTRsSTVzTkgr?=
 =?utf-8?B?Tml4Nk9ra3N4MFlJRzlQNjJlaklTdjhORk4xdEZsRUlMNlBDZWJ2NmY2Z2d2?=
 =?utf-8?B?cWtYZ1cxMGI2blZTdjVaTkpEWUJBWWlTQjdwNnNJQUNGYXlWWUhqNENRQ21l?=
 =?utf-8?B?bjU3cFBLdnJESjMwcVVBMVhTVVp0NXlEcGhaMGZZSndBaFJ4bXB1OEhqQXVZ?=
 =?utf-8?B?SXdMTitteVowRi9QUjJtZzdsMlMxcUpYSStsdmxvOWdMRDVsUnVPdFYzOUJQ?=
 =?utf-8?B?Ui9UQzA5OGhWT0FvS3IzekRwZWdWbkxnZjE5UTZpM3UxUUlONmF5VUxmSGJX?=
 =?utf-8?B?MGlrNCtSeWZyeWJ1bENlSFhYbEtSOXJJUHV6VC94dzFQTjBrOEs5YUVVc1Nn?=
 =?utf-8?B?L0MyZVppb2ZTY2tvUlNTNTFmZE04NHJOVzZWZ1ptWEtqblJrMjJpZktMRTlU?=
 =?utf-8?Q?k1jmPvS51vxpq/VVbVYzoFHnctnm0I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9254.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFo2dm5HaDI3YlJBOXZPeStwQWFWcklmUmpVdjYzU2dkZVJBdUdKcFk5TnRG?=
 =?utf-8?B?TmFhMnZCT2xEK3dvZkVjV0pEYkNmTnhOeFhEdCsyU2ZpUnp5WmNWNXRhT2lE?=
 =?utf-8?B?UjNKWjVYb21mdXNRMXI0dGhkS0JLeGluUkpSeFduUFFrZkVkUTlPL0N6NWxL?=
 =?utf-8?B?K3RFTDVZYUJhWXFwNmJJcmtWbTZVOGJLM0VlaUhwQ2pLNTBmZlRsemhjN3lJ?=
 =?utf-8?B?RVBjQTlGR3VSVlNTdy9IeGRIZ210MHRPL25IMEVtb1hManM2aU1JR1pBZmxX?=
 =?utf-8?B?M1MrSjdZM3RPcm56dHg2MTJQeDdlRWJmZUJSb0o2M1V0UVRHSjZ3L3VnU0xT?=
 =?utf-8?B?djR3dGUxUFhlZDJqNTU2SUlHSEZRQTBCMWVTOVpxQXJNblNmV3NteWVUTVdv?=
 =?utf-8?B?S1lTVkNJaFdpL3ZiRmxVK245aGhZQlIrYVBna3kyekhQeDcwb2UzbUx2UElh?=
 =?utf-8?B?L3FpdlFQZXVyb3BoNysvUFkrbmZmT056ZTBuTnR3RzhvYkZQREhxc1o5UC8x?=
 =?utf-8?B?RHBESC9HakYxMzFYdzVxMGpJNUZ2SmxWS1B6eHJtSWtXWHVNaUdoVjB0d3lw?=
 =?utf-8?B?VFQrODVLWEhkNDBWWllxVkRKNzArVWgvWjY3MEJmcmhUVTR3MGxRMkdXYVU4?=
 =?utf-8?B?TWhYZzhKd3poNWpUUnAxcjZCY3Rnc1dCZXVUdmxpV3FIYlEzdWpPVzZ6ZWI4?=
 =?utf-8?B?QnV2V2RhSDUyWERuMi9oSXpJUUVaeWtubksxQW94V0NnempzZGYwcXd5UGIy?=
 =?utf-8?B?aEVMa3VDcnFIb2lFLzNCUmZRMVFIZ2VtN0R2UDBDZ0F1bzMvVHNvSTk1clIw?=
 =?utf-8?B?VmxUMlVCbmxKd1NzNUk2UFFiaXJVbHZzRHI1b2t6eGFoL2ZlTDJqeVM3RUJB?=
 =?utf-8?B?cjRFVkNyeng1enNVamtoaDJmMlh0L2Q2eHFtVHBTTVcybFJvY09ud0tHbndr?=
 =?utf-8?B?YkxaRDZBczZtZ3VqYm9VdDQvOFhycGZYRkZtVE1yVGVUa0R4UzZ1djdhS09Z?=
 =?utf-8?B?MGhzeUhQNEZ5c01iblpPVjNvckgyUFd1bVREdUpKSm1DcXZIRndzamF6YmQ0?=
 =?utf-8?B?OWdFN0k2UCtlaS9mUitRTWI5V2xUNitVaUdlbVVRZXJxcllvcUJ1MlpNMlps?=
 =?utf-8?B?OGUzSmRZSkxVb1IyQXROZnMraUFJUnBrNHdxWURjR3M1R0hGRlpwODlSV2Nl?=
 =?utf-8?B?MmRWdGhHeGdyNEpjclIzWm5VQkJUNTQ2WGxhOFo1OGVZTkIxbkQweTNDM3No?=
 =?utf-8?B?TjdaRXFnNHpRVXFvNU1NRU5Gb0FYVy9hb24yMElBSG1ZQ1RTNDNVLzdOa0Va?=
 =?utf-8?B?YnluWWtUYTJWZE9rdlUzb2JaSjJkU1B2UzYyaE9rdkNvbVkzQ3owUU5taUZa?=
 =?utf-8?B?c0pSNXE4dlBxWDlyMzZ6R0RCeC83cXVKVGhQc0syRmpWT3JQQmZ1c3NMQUZ3?=
 =?utf-8?B?VGJpb3dzQldnV0owSnp4THJlK2w1VWxxMHkrUVNweXJEU3VIRVQyYnZ4ZGVl?=
 =?utf-8?B?RU81d3I0NVpLTlJjcFRzcTA5TlFDSXJGNzl0U0dEUFRvMzZHOGJHaUJDOXg5?=
 =?utf-8?B?dFdwcVVtYi92T2U3c3BBNWdMclczTWlzdXRieVlLWjFRNGdFdE1JeS9tMkVw?=
 =?utf-8?B?NDlRemlmc3JLVGlvTlAyS0hsdS9IbmF0ZW4rUEFySUkrTVZBYlhrcm50dUdV?=
 =?utf-8?B?WnlndWl3ZDJCQ2I2aklCM20rOVEydEdUdWtTMmNJWWFlRGJUeXRJTFVXVUJB?=
 =?utf-8?B?Q3NCVHUyWXlZNVdPM2lyb1R6ZWFjcVBrckd0YkFmRUttT2JaTXBpRFZ3RmJ4?=
 =?utf-8?B?SWVpdTVyY1pReTRZOEVnb0JHUG9RTVltRnkxZzE5ZjExT0xGWlRlcVNteVRK?=
 =?utf-8?B?MXFvdDZKWjhoOXNqcG1zUEtRc3JrRDVFNVpKZEF6QXBQamowVW0wakVHMXp5?=
 =?utf-8?B?WFZod3YrQ25zZG4rdmdRMXdtd1E1a2dGbkEvWEQ3M3NNVFpZUFZJUm5OUXlG?=
 =?utf-8?B?K0RvTldWQStlbkZvakVhRWp4L0ZONG9xRzE1cG1MRDVrMTJIOG1EZWQvc1E3?=
 =?utf-8?B?aEszZjhIa1loNzlvOHZodUJLZS9RSjZHeExrNEV3L0l2VldLSkJSbFVBclBU?=
 =?utf-8?B?TUY0Y25CRlh4VWYyU2tuTnIrOWYvL2NrajFKVWxxRG81M0poYy9EMU1maThl?=
 =?utf-8?B?Y3c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb806ef-f414-407f-99ae-08ddbfc7687d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 15:35:32.8888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TRz4ZnV7kya8HpJdOZgtj0FYUbgwfup6lIFEW6cVq3OTkn+5JLn969ry2WAkHuH4KSLzKEULyu+uXsdvALW6TNv5u6azldaVuOc224NOM1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9252
X-OriginatorOrg: intel.com

T24gVGh1cnNkYXksIEp1bHkgMTAsIDIwMjUgMTI6MjkgQU0sIFN0YW5pc2xhdiBGb21pY2hldiA8
c3Rmb21pY2hldkBnbWFpbC5jb20+IHdyb3RlOg0KPk9uIDA3LzA5LCBEYW5pZWwgQm9ya21hbm4g
d3JvdGU6DQo+PiBPbiA3LzcvMjUgNTowMyBQTSwgU3RhbmlzbGF2IEZvbWljaGV2IHdyb3RlOg0K
Pj4gPiBPbiAwNy8wNCwgRGFuaWVsIEJvcmttYW5uIHdyb3RlOg0KPj4gPiA+IE9uIDcvNC8yNSAx
MTo1OCBBTSwgSmVzcGVyIERhbmdhYXJkIEJyb3VlciB3cm90ZToNCj4+ID4gPiA+IE9uIDA0LzA3
LzIwMjUgMDMuMTcsIFNvbmcsIFlvb25nIFNpYW5nIHdyb3RlOg0KPj4gPiA+ID4gPiBPbiBGcmlk
YXksIEp1bHkgNCwgMjAyNSAxOjA1IEFNLCBKZXNwZXIgRGFuZ2FhcmQgQnJvdWVyDQo+PGhhd2tA
a2VybmVsLm9yZz4gd3JvdGU6DQo+PiA+ID4gPiA+ID4gT24gMDIvMDcvMjAyNSAxOC41NywgU29u
ZyBZb29uZyBTaWFuZyB3cm90ZToNCj4+ID4gPiA+ID4gPiA+IEludHJvZHVjZSB0aGUgWERQX01F
VEFEQVRBX1NJWkUgbWFjcm8gYXMgYSBjb25zZXJ2YXRpdmUgbWVhc3VyZSB0bw0KPj4gPiA+ID4g
PiA+ID4gYWNjb21tb2RhdGUgYW55IG1ldGFkYXRhIGFyZWFzIHJlc2VydmVkIGJ5IEV0aGVybmV0
IGRldmljZXMuDQo+PiA+ID4gPiA+ID4NCj4+ID4gPiA+ID4gPiBUaGlzIHNlZW1zIGxpa2UgYSBz
bG9wcHkgd29ya2Fyb3VuZCA6LSgNCj4+ID4gPiA+ID4gPg0KPj4gPiA+ID4gPiA+IFRvIG1lLCB0
aGUgcHJvYmxlbSBhcmlzZSBiZWNhdXNlIEFGX1hEUCBpcyBsYWNraW5nIHRoZSBhYmlsaXR5IHRv
DQo+PiA+ID4gPiA+ID4gY29tbXVuaWNhdGUgdGhlIHNpemUgb2YgdGhlIGRhdGFfbWV0YSBhcmVh
LsKgIElmIHdlIGhhZCB0aGlzIGNhcGFiaWxpdHksDQo+PiA+ID4gPiA+ID4gdGhlbiB3ZSBjb3Vs
ZCBhbGxvdyB0aGUgSUdDIGRyaXZlciB0byB0YWtlIHNvbWUgb2YgdGhlIHNwYWNlLCBoYXZlIHRo
ZQ0KPj4gPiA+ID4gPiA+IEJQRi1wcm9nIGV4cGFuZCBpdCBmdXRoZXIgKGJwZl94ZHBfYWRqdXN0
X21ldGEpIGFuZCB0aGVuIHVzZXJzcGFjZQ0KPj4gPiA+ID4gPiA+IEFGX1hEUCB3b3VsZCBzaW1w
bHkgYmUgYWJsZSB0byBzZWUgdGhlIHNpemUgb2YgdGhlIGRhdGFfbWV0YSBhcmVhLCBhbmQNCj4+
ID4gPiA+ID4gPiBhcHBseSB0aGUgc3RydWN0IHhkcF9tZXRhIGF0IHJpZ2h0IG9mZnNldC4NCj4+
ID4gPiA+ID4gPg0KPj4gPiA+ID4gPiBUaGFua3MgZm9yIHlvdXIgaW5wdXQuDQo+PiA+ID4gPiA+
DQo+PiA+ID4gPiA+IEkgYWdyZWUgd2l0aCB5b3UgdGhhdCB0aGUgaW1wbGVtZW50YXRpb24gd2ls
bCBiZSBzaW1wbGUgaWYgdXNlciBhcHBsaWNhdGlvbg0KPj4gPiA+ID4gPiBhYmxlIHRvIGdldCB0
aGUgc2l6ZSBvZiBkYXRhX21ldGEgYXJlYS4gVGhlIGludGVudGlvbiBvZiB0aGlzIHBhdGNoIHNl
dCBpcyB0byBsZXQNCj4+ID4gPiA+ID4gZGV2ZWxvcGVyIGF3YXJlIG9mIHN1Y2ggbGltaXRhdGlv
bnMgYmVmb3JlIHdlIGhhdmUgYSBwZXJmZWN0IHNvbHV0aW9uLg0KPj4gPiA+ID4gPg0KPj4gPiA+
ID4gPiBCdHcsIGRvIHlvdSBnb3QgYW55IHN1Z2dlc3Rpb24gb24gaG93IHRvIGV4cG9zZSB0aGUg
bWV0YWRhdGEgbGVuZ3RoPw0KPj4gPiA+ID4gPiBJIG5vdCBzdXJlIHdoZXRoZXIgeGRwX2Rlc2Mu
b3B0aW9ucyBpcyBhIHNpbXBsZSBhbmQgZ29vZCBpZGVhIG9yIG5vdD8NCj4+ID4gPiA+DQo+PiA+
ID4gPiBUaGF0IGlzIGEgcXVlc3Rpb24gdG8gdGhlIEFGX1hEUCBtYWludGFpbmVycy4uLiBhZGRl
ZCB0aGVtIHRvIHRoaXMgZW1haWwuDQo+PiA+ID4gPg0KPj4gPiA+ID4gLyogUngvVHggZGVzY3Jp
cHRvciAqLw0KPj4gPiA+ID4gc3RydWN0IHhkcF9kZXNjIHsNCj4+ID4gPiA+ICAgwqDCoMKgwqBf
X3U2NCBhZGRyOw0KPj4gPiA+ID4gICDCoMKgwqDCoF9fdTMyIGxlbjsNCj4+ID4gPiA+ICAgwqDC
oMKgwqBfX3UzMiBvcHRpb25zOw0KPj4gPiA+ID4gfTsNCj4+ID4gPiA+DQo+PiA+ID4gPiBBcyBm
YXIgYXMgSSBrbm93LCB0aGUgeGRwX2Rlc2Mub3B0aW9ucyBmaWVsZCBpc24ndCB1c2VkLCByaWdo
dD8NCj4+ID4gPg0KPj4gPiA+IFRoZSBvcHRpb25zIGhvbGRzIGZsYWdzLCBzZWUgYWxzbyBYRFBf
UEtUX0NPTlREIGFuZCBYRFBfVFhfTUVUQURBVEEuDQo+PiA+ID4NCj4+ID4gPiA+IChQbGVhc2Ug
QUZfWERQIGV4cGVydHMsIHBsZWFzZSB2ZXJpZnkgYmVsb3cgc3RhdGVtZW50czopDQo+PiA+ID4g
PiBTb21ldGhpbmcgZWxzZSB3ZSBsaWtlbHkgd2FudCB0byBkb2N1bWVudDogVGhlIGF2YWlsYWJs
ZSBoZWFkcm9vbSBpbiB0aGUNCj4+ID4gPiA+IEFGX1hEUCBmcmFtZS7CoCBXaGVuIGFjY2Vzc2lu
ZyB0aGUgbWV0YWRhdGEgaW4gdXNlcnNwYWNlIEFGX1hEUCB3ZSBkbyBhDQo+PiA+ID4gPiBuZWdh
dGl2ZSBvZmZzZXQgZnJvbSB0aGUgVU1FTSBwYWNrZXQgcG9pbnRlci7CoCBJSVJDIG9uIFJYIHRo
ZSBhdmFpbGFibGUNCj4+ID4gPiA+IGhlYWRyb29tIHdpbGwgYmUgZWl0aGVyIDI1NSBvciAxOTIg
Ynl0ZXMgKGRlcGVuZGluZyBvbiBOSUMgZHJpdmVycykuDQo+PiA+ID4gPg0KPj4gPiA+ID4gU2xp
Z2h0bHkgY29uZnVzaW5nIHdoZW4gQUZfWERQIHRyYW5zbWl0dGluZyBmcm9tIHVzZXJzcGFjZSB0
aGUgVU1FTQ0KPj4gPiA+ID4gaGVhZHJvb20gaXMgZGVmYXVsdCB6ZXJvIChYU0tfVU1FTV9fREVG
QVVMVF9GUkFNRV9IRUFEUk9PTSBpcw0KPnplcm8pLg0KPj4gPiA+ID4gVGhpcyBpcyBjb25maWd1
cmFibGUgdmlhIHhza191bWVtX2NvbmZpZy5mcmFtZV9oZWFkcm9vbSwgbGlrZSBJIGRpZCBpbg0K
Pj4gPiA+ID4gdGhpcyBleGFtcGxlWzFdLg0KPj4gPiA+ID4NCj4+ID4gPiA+IE1heWJlIEkgZGlk
IHNvbWV0aGluZyB3cm9uZyBpblsxXSwgYmVjYXVzZSBJIHNlZSB0aGF0IHRoZSBuZXcgbWV0aG9k
IGlzDQo+PiA+ID4gPiBzZXR0aW5nIHhza191bWVtX2NvbmZpZy50eF9tZXRhZGF0YV9sZW4gKyBm
bGFnIFhEUF9VTUVNX1RYX01FVEFEQVRBX0xFTi4NCj4+ID4gPiA+IFRoaXMgaXMgbmljZWx5IGRv
Y3VtZW50ZWQgaW4gWzJdLiBIb3cgZG9lcyB0aGlzIGludGVyYWN0IHdpdGggc2V0dGluZw0KPj4g
PiA+ID4geHNrX3VtZW1fY29uZmlnLmZyYW1lX2hlYWRyb29tID8NCj4+ID4gPg0KPj4gPiA+IElm
IHlvdSByZXF1ZXN0IFhEUF9VTUVNX1RYX01FVEFEQVRBX0xFTiB0aGVuIG9uIFRYIHNpZGUgeW91
IGNhbiBmaWxsDQo+PiA+ID4gc3RydWN0IHhza190eF9tZXRhZGF0YSBiZWZvcmUgdGhlIHN0YXJ0
IG9mIHBhY2tldCBkYXRhLCB0aGF0IGlzLA0KPj4gPiA+IG1ldGEgPSBkYXRhIC0gc2l6ZW9mKHN0
cnVjdCB4c2tfdHhfbWV0YWRhdGEpLiBUaGUgdmFsaWRpdHkgb2YgdGhlDQo+PiA+ID4gbGF0dGVy
IGlzIGluZGljYXRlZCB2aWEgZGVzYy0+b3B0aW9ucyB8PSBYRFBfVFhfTUVUQURBVEEgYW5kIHRo
ZW4NCj4+ID4gPiB5b3UgZmlsbCBtZXRhLT5mbGFncyB3aXRoIHRoaW5ncyBsaWtlIFhEUF9UWE1E
X0ZMQUdTX0NIRUNLU1VNIHRvDQo+PiA+ID4gdGVsbCB0aGF0IHRoZSByZWxhdGVkIGZpZWxkcyBh
cmUgdmFsaWQgKGV4LiByZXF1ZXN0LmNzdW1fc3RhcnQsDQo+PiA+ID4gcmVxdWVzdC5jc3VtX29m
ZnNldCkgYW5kIHRoYXQgeW91IGV4cGVjdCB0aGUgZHJpdmVyIHRvIGRvIHRoZQ0KPj4gPiA+IG9m
ZmxvYWQgd2l0aCB0aGlzIGluZm8uIFRoaXMgaXMgYWxzbyB3aGF0IEkgbWVudGlvbmVkIGluIHRo
ZSBvdGhlcg0KPj4gPiA+IHRocmVhZCBzb21lIHRpbWUgYWdvIHRoYXQgaW1obyBpdCB3b3VsZCBt
YWtlIHNlbnNlIHRvIGhhdmUgdGhpcyBhbHNvDQo+PiA+ID4gb24gUlggc2lkZSBzb21ld2hhdCBz
aW1pbGFyIHRvIHZpcnRpb19uZXRfaGRyLi4NCj4+ID4NCj4+ID4gTGV0J3MgYXQgbGVhc3QgZG9j
dW1lbnQgdGhlIGN1cnJlbnQgYmVoYXZpb3Igd2hlcmUgc29tZSAoc21hbGwgbWlub3JpdHkgb2Yp
DQo+PiA+IGRyaXZlcnMgY2FuIHJldXNlIHRoZSByeCBtZXRhZGF0YSBhcmVhIGZvciBzb21lIG9m
IGl0cyBzdGF0ZT8gSWYgd2Ugd2FudA0KPj4gPiB0byBpbXByb3ZlIG9uIHRoYXQgYnkgYWRkaW5n
IGFub3RoZXIga25vYiwgd2UgY2FuIGZvbGxvdyB1cD8NCj4+ID4gKGJ1dCBJIHJlbWVtYmVyIGxh
c3QgdGltZSBpdCB3YXMgZGlzY3Vzc2VkLCBhYm91dCBhIHllYXIgYWdvLCBwZW9wbGUNCj4+ID4g
d2VyZSBub3QgZW50aHVzaWFzdGljIGFib3V0IGFub3RoZXIgcGFyYW1ldGVyIGV4cG9ydGVkIGFz
IHVhcGkpDQo+Pg0KPj4gQnV0IGl0cyBzdGlsbCBmdW5kYW1lbnRhbGx5IGJyb2tlbiBubz8gVW5s
ZXNzIHRoZXJlIGlzIG5vIGhhcm0gZm9yIEJQRiBkZXZzDQo+PiB0byBvdmVycmlkZSB0aGF0IHJ4
IG1ldGFkYXRhIGFyZWEgd2hlbiB0aGUgcGt0IGxhdGVyIG9uIGdvZXMgdXAgdGhlIHN0YWNrLCBi
dXQNCj4+IGl0IHNvdW5kcyB0aGlzIGlzIG5vdCB0aGUgY2FzZSBoZXJlLiBJaXVjLCBZb29uZyBp
cyB0cnlpbmcgYSBkaWZmZXJlbnQgYXBwcm9hY2gNCj4+IG5vdyB0byBwcmVwZW5kIGJlZm9yZSBk
YXRhX2hhcmRfc3RhcnQgWzBdPw0KDQpJIHBsYW4gdG8gcmV0cmlldmUgdGhlIHRpbWVzdGFtcCBm
cm9tIG1ldGFkYXRhIGFyZWEgYW5kIHB1dCBpdCBpbiB4ZHBfYnVmZl94c2suY2INCmFyZWEgdmlh
IHN0cnVjdCBpZ2NfeGRwX2J1ZmYuDQoNCj4+IFRoZW4gaWYgQlBGIHByb2cgbmVlZHMgaXQsIGln
Yw0KPj4gYWxyZWFkeSBpbXBsZW1lbnRzIHhtb19yeF90aW1lc3RhbXAgY2FsbGJhY2sgd2hpY2gg
Y2FuIGNvcHkgaXQgZnJvbSB0aGVyZS4NCg0KPj4NCj4+ICAgWzBdIGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2JwZi8yMDI1MDcwNzE5MTc0Mi42NjJhZWZmYkBrZXJuZWwub3JnLw0KPg0KPlRydWUs
IEpha3ViIG1lbnRpb25lZCB0aGUgc2FtZSB0aHJlYWQgdG8gbWUuIFRoaXMgaXMsIGluZGVlZCwg
YSBiZXR0ZXINCj5pZGVhIQ0KDQpXb3VsZCBpdCBiZSBhZHZpc2FibGUgdG8gdXBkYXRlIHRoZSBk
b2N1bWVudGF0aW9uIHRvIGluZGljYXRlIHRoYXQNCmRyaXZlcnMgYXJlIGV4cGVjdGVkIHRvIGNv
cHkgYW55IGRldmljZS1yZXNlcnZlZCBtZXRhZGF0YSBmcm9tIHRoZQ0KbWV0YWRhdGEgYXJlYT8g
VGhpcyB3b3VsZCBlbnN1cmUgdGhhdCB4ZHBfYnVmZi0+ZGF0YV9tZXRhIGlzIGVxdWFsDQp0byB4
ZHBfYnVmZi0+ZGF0YSBiZWZvcmUgYSBCUEYgcHJvZ3JhbSBpcyBleGVjdXRlZC4gVGhpcyBhcHBy
b2FjaA0Kd291bGQgYWxsb3cgQlBGIHByb2dyYW1zIHRvIGZyZWVseSBtYW5pcHVsYXRlIHRoZSBt
ZXRhZGF0YSBhcmVhDQppbiBYRFBfUkVESVJFQ1Qgc2NlbmFyaW9zLg0KDQpBZGRpdGlvbmFsbHks
IEkgYW0gdW5jZXJ0YWluIGFib3V0IHRoZSBuZWVkIHRvIG92ZXJyaWRpbmcgbWV0YWRhdGEgaW4N
ClhEUF9QQVNTIHNjZW5hcmlvcy4gU2hvdWxkIEJQRiBwcm9ncmFtcyByZWZyYWluIGZyb20gb3Zl
cnJpZGluZyB0aGUNCm1ldGFkYXRhIGluIHRoaXMgY2FzZT8NCg0K

