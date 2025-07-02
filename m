Return-Path: <linux-kselftest+bounces-36348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 668ABAF5E56
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 18:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BEF44A1965
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 16:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902752F5460;
	Wed,  2 Jul 2025 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bBqKimbM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8083D2F3651;
	Wed,  2 Jul 2025 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751473078; cv=fail; b=Y+0v3Im///sfWFI13hue/B8EH8xdbx+AGWIRjRaXIxOyWSbcueBMUD4YJw5wSSrZZZctdZbK1pNX4Urm906by274uF24PG7IqRrDQiiaEYVIPEf4qkeusXz2YoXiZCD/pX8iBB1ZRz72dhmVqIFilC+f9TTOKVGkAf9LBD+QJ+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751473078; c=relaxed/simple;
	bh=pkvAJA6Dfs2feLyWU3QxfAio65NeIH/B0Hudh9Ln+tk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pDkA7SvMk+9oo/wqOb7rElDMsWONfY1xhAIt/oT2D2oAyhq1MxWC/nI5Cul12W2Bg5ISLiLDQdJ4AloTAatYnYiN1nG1cAWEh+REQ8MG/2hk6YchZNKSFvLolLVJa3WN5nB9BPyACDgTFIIzc42sOxOrjbaJsKRAbk96O27EtcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bBqKimbM; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751473077; x=1783009077;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pkvAJA6Dfs2feLyWU3QxfAio65NeIH/B0Hudh9Ln+tk=;
  b=bBqKimbMqknFGcRPib2NXHIEdiAOQ+fpip7D44upxtE77UemhhrZNwdf
   NLClT5Mkrx5q0U0Df9JXCaQODzahgQIqeuCljA35IeyqB9ZDJ5Gia3qK2
   FQGo2kp6YkT+8bN3T9FM4/MpIs4uiNp9ih7CV2MRVw5UnbxRlasW1FhcV
   X9zj2WF291VpXsEJsn93BKADAwZyHy7h+SS3o+PVLW7RSH1i3X7k4uKbg
   g72PMm87s8ec5DtAK2f7MoRw5CjmaWmmjAE9kCBS6xMTCg5tDJxiNOXgY
   5RKapxuToNhFzAyXxbYmQJMn7+2BxBCTLZof5vMxykWSy7R9lm0CZP68N
   g==;
X-CSE-ConnectionGUID: AiKM8Pw+QwWROTLFp2VajA==
X-CSE-MsgGUID: GkIv57RGQcaDOfu4NFGIwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53746392"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="53746392"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 09:17:50 -0700
X-CSE-ConnectionGUID: 7CBE1+xAT8eJX/44o9zcwQ==
X-CSE-MsgGUID: GyCBnta9SeOh5c609Yajwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="154627141"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 09:17:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 09:17:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 09:17:48 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.77)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 09:17:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RcF+r9lWVPS3rg+pTzFw5vccTneoyMQmRKzpVtjsSjIikkTg8fbGBpvwjRgUOjXtwvq3d7geIgeBzqAaoyaV1lwej47uPMTsKtJZJSaMEhCHBBWK241sxeiH+ysFwY3uNGqr3+AyyjkuFhV3Fq9C9wQ7B1tECCP/LiEJw9Pni9qdS3iQuhkHiLEwkvkV395g38ImwNJxuQvZxUxOGSsRuaGb56z/vYfSD8jWbNjdVSauiWO1g6cR7ewi8Ugk7lj7Qi2DJwW6QuX1f/QN7X3qZVttxRdzLvfraZa2vAclchus/GAWQbG93bcHyhASaB/4sFE5e/OAsokUbfShujrgFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkvAJA6Dfs2feLyWU3QxfAio65NeIH/B0Hudh9Ln+tk=;
 b=OfK8SBBYQ9rY/sZFttqyDHMvg/4lcvIMnpDtN6ID6vMBttGWbjvnb14l5/mbco2B7I+M4BvYhuW+iXt45UDUWUZbBfJA6HPkA2wumvF3QqSIY6RGKC0E6sds5juMSBrGtEmq0bSFkVjOkGV0bZsDX8/UHfHQYs2bCeY+43kLRGFi+t0r6ecfV6qV83UqZ4OSIGBQnLe+wJjsNg0Sqd99cMtOols749k35xHiCFApXbb29Y5CyV+guGwFQ1S3EUSumzZTsIgMJiUvERaJgdjfXw7G2I2jCwzETzIC6cUShZ3PZwl0kCTCVGq/TLqEtm1VicdHs+RI+pBN8PWXFRW9pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9254.namprd11.prod.outlook.com (2603:10b6:208:573::10)
 by LV8PR11MB8608.namprd11.prod.outlook.com (2603:10b6:408:1f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 16:17:46 +0000
Received: from IA3PR11MB9254.namprd11.prod.outlook.com
 ([fe80::8547:f00:c13c:8fc7]) by IA3PR11MB9254.namprd11.prod.outlook.com
 ([fe80::8547:f00:c13c:8fc7%5]) with mapi id 15.20.8857.016; Wed, 2 Jul 2025
 16:17:46 +0000
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
Thread-Index: AQHb6kEMHPOPYZSFok6IH5vzoGeGvLQddqWAgACgmGCAABl5kIAAw/mAgAAHb3CAAAU/AIAAAtJA
Date: Wed, 2 Jul 2025 16:17:45 +0000
Message-ID: <IA3PR11MB92546B2AEC69DB5FF17A12B2D840A@IA3PR11MB9254.namprd11.prod.outlook.com>
References: <20250701042940.3272325-1-yoong.siang.song@intel.com>
 <20250701042940.3272325-3-yoong.siang.song@intel.com>
 <aGQNWXe6FBks8D3U@mini-arch>
 <IA3PR11MB925416396633E361F37E819DD840A@IA3PR11MB9254.namprd11.prod.outlook.com>
 <IA3PR11MB9254C961FD048793FD0013EAD840A@IA3PR11MB9254.namprd11.prod.outlook.com>
 <aGVN01flIJzvCo6S@mini-arch>
 <IA3PR11MB92541178AAF28F03639A9435D840A@IA3PR11MB9254.namprd11.prod.outlook.com>
 <aGVYdjDKNBdWdrQ8@mini-arch>
In-Reply-To: <aGVYdjDKNBdWdrQ8@mini-arch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9254:EE_|LV8PR11MB8608:EE_
x-ms-office365-filtering-correlation-id: 9cde3e27-ec3f-4dfe-f9b4-08ddb983fb0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?a0JxbitsNU9Ba2RUN1JraVlmRUpaWXh5VXVmMEpLUnVlNk5zWGtRV0dpSVhy?=
 =?utf-8?B?eW0rMUN2RGhiZmdnVEYzelVqQi93OU5DdWU3VHhYRDBjTHRwSEZuY2JMUzYx?=
 =?utf-8?B?THZWbWEwcG9WZHNqS1hPaGc5bGV4Mi9GVmFsWGs3ZXZkMzQrWDRUQUVrV1pU?=
 =?utf-8?B?OXA0RjNNY1YxaVpDaEtsTWZQZnFnUGg0VnovbkdUQnB0S2ozT3h0RUlWMmlu?=
 =?utf-8?B?UTdLeFMxVldOMkNLdkU2RExqTXd0alJDOHJDRHBrWjlYbHd4RUNBUHNzSmFa?=
 =?utf-8?B?UmtPNzBMWjc2ZnZFblRndGRXTEhjbTI4QnpmZUg0OXZEMjZ0bmJwSUkvTUho?=
 =?utf-8?B?UG1SZk41ZjNyWFNKYXVXTGo5KytMMElSUlVydE1YNGFoQSttcEU5WEd3VmhO?=
 =?utf-8?B?WHMrdWF5QzZCNEpNc0o2dkVsM3hmL1N5M3RGUzE3UWhwaWFjSWQyYS9qaGJX?=
 =?utf-8?B?amxKK3ZxOGxac3JPdVI3QXR4bDZFMzAwaG5Ma2x6UUhNN2c2c25ibmZLaDFL?=
 =?utf-8?B?WjJkazRxL1dZOEQ0WmdyY213REhNWXoxZE9hWnhXQmd0ZTR6RHc1Y0V0YkdQ?=
 =?utf-8?B?WWZDRW9RRHVDcWhiWURKTWlWb0NRaWJmNEZ4Rk03bHdxUUZtUEh6RDBld3l4?=
 =?utf-8?B?dzNiZ01EczI2UmdUczU4bHBEQis1cHJ3Mm5ZYlJ6R0Z4UUFwekVLVmRoN1R1?=
 =?utf-8?B?MWlhaXc0VTJjZ2MzWGZiaXhXdlNYL011RWxDeXZaWUNSRmZVb25JcWU2UnFy?=
 =?utf-8?B?SG5SUUJlRDJQaHhiNTlDc0VrdEJkejdKQ1k4UDlQWW1CVHlaL3dsb3FDYWhI?=
 =?utf-8?B?T0VLdGdPUGZmcU5tbFZIa0NUZmRSOTNucGlHdVJGQVRIcHNNRUdQSU94enNM?=
 =?utf-8?B?bXVybyttdUhYZ0dtaGFUam5LcEpMTUJuWmR5b3MyVlVpZkN6aGpWa0VpSFBz?=
 =?utf-8?B?ZWRrL2p5R2tiTldCeFlQTW5kazdPb0FwYWg4aUJWcVhJQTZHdWwxY2RZRE5W?=
 =?utf-8?B?WHhvVGY4RGtFdVpyM0hQYUliZk8vYWtDZ0huSmY2TjRicUlMaWVKUWx4blA3?=
 =?utf-8?B?dFVoYVJobCtwaWU4MHBwRTRPdjY4ZHZ2czlIY0o0c0JCeDhIUFp2dTRpamtR?=
 =?utf-8?B?aXNIdDhoaksrY2twT2dSbTRvTUg4QXppbzN6YWc1UkdiT3ZBenJhZURmQW5a?=
 =?utf-8?B?ZUQ4V1FqTktnMm5FN0E1Z1BIa2JZNWE3V2oyZzNVbCtOWE0wcExEUHRMVVcy?=
 =?utf-8?B?cjVScjMrRXMyR2RYSUJGM3EreURCbkFHa2RTbkFkZUpMMHN6Y1VFMU1lZUdj?=
 =?utf-8?B?MUtxNXFhdFpHMXVmRmtES1pYU3pSSUdRb2w5OE94S2c4dWF2V1hPcFlUVTQz?=
 =?utf-8?B?RUZmMkpYc1U0M2l4emRyOEswV1J6S0NZZkZDUnYyNDlHSjVIN25XaHRUeXdm?=
 =?utf-8?B?dnY4WlQ5SHVFL0E0OVJZSExsNXBaUEtsdjF5WHBwWUJxdVd0b3JXeG9ya1Bt?=
 =?utf-8?B?aVF3WllQdWlSYW9JYkphc0ZLOTdGcmE2YloxY3BGM096bnNKME9GanVDbWV4?=
 =?utf-8?B?ZVA5VkI5YlYzdDZVWjJoYUNwMGxTaGhiSWdVWDJjOC82R1FPVUZKTGxQTzRu?=
 =?utf-8?B?YUtERVpWNEVTQ09iT1M2enVlNE9MUFlMS1VEMHNxL3ByZVVzWm9oWWJFbUVT?=
 =?utf-8?B?WlBTNVBLekxabENDRFJNYzBsdm9ISmRFbWwzRlA5aDJXRlBDSzg5OVdoZ2FX?=
 =?utf-8?B?Q29ac3V5aXlMa09pdTZ1Q2RHc1drZTg3QWpVNzNZQ0d1NlRUcWNyd0dId2Fj?=
 =?utf-8?B?anIzVXBCSEFtNWdEZjNyQVY5SmMzZHhJTjZmR1pJbXZudHlwZVJ6VlFqZWwx?=
 =?utf-8?B?eGEvUVJOVW5VVkxkU0s4ZzIyQ0paUTJPV29ORW5mVzV1bnVyOEh4U1A0a2Vq?=
 =?utf-8?B?N2txejVVL05OeVpsZWpqc1BYK2hNWjI0aWg0Y3BoMUduR1dEVnM0b2xZY052?=
 =?utf-8?Q?rg8lK380t5lSHabvq5B2/yuRqJAzo4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9254.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MitvTFZiTU5iVTR1NEtzQ0FUK0RCY2l5SFJNVURkMXFHZjFGOWgvMXpjYkdM?=
 =?utf-8?B?YTA1VEYvVUpDMGIyd0MxcGNUdDkzZHloR0dxck1xY242dEM1ZS9Mclhpb0px?=
 =?utf-8?B?Q2UycUZ2a09vNmcyODNBZGhmWEMxY25udE01L0dPSXVOV0ZYVXpuUkMzK2xC?=
 =?utf-8?B?U3ZpY3FYTDJLSi9yQ3Z0c3RpMTBmUERLbTl0a1lES1FwRUxhRmUya0k1ZEwx?=
 =?utf-8?B?MytsTmNQOUw1K1FSUGFQWkxPVFBRcnhTTE9QOXF3NXlCc1VqRkIxVDVwMFJy?=
 =?utf-8?B?b21TWXhTUGlseTI4b1hRNHJnYXgwazhGTFpSREVHL3ZlQytkam1pNHB1UmdF?=
 =?utf-8?B?NCs4WG1VNDZhZ3V0V1RWMlpWRitVczk0cFZFOStkemx0MUZycVo3MEYrRmsx?=
 =?utf-8?B?NmlIZDMweFRLOUpnZlgvdEdsckVPbjVvTjhnMEdGNlBlK3EzU05PVTlPemhR?=
 =?utf-8?B?dHh3K2JSeU9taUNmN0tmNloxOEZabmV6aXU1aUtqR0N6WmtlZE1CRm51dEV3?=
 =?utf-8?B?QU40OG9YL1NEZkwzdC9xckx1T0NPOFVMQ290cmVoSFdWSWVVSXRuUlpsbk4x?=
 =?utf-8?B?T2l3OCtGaGF4bEVXcWhnYzFWMURub2doOGc2YVRwbTl3ZG0yM1M3ZmQrejBE?=
 =?utf-8?B?aFhoVXpWM1lFN3IwWURRK0FxREFKT3NORDlIdHB6UTczYWhoQU1SWDBOQkJL?=
 =?utf-8?B?OUNoS1RZUk8zNU1Fd0xSRzZkSzBXTnpHUWlpeS9INms1bjUvbFZNQ3NMYzZC?=
 =?utf-8?B?QTlWVStjbnNmNVBxbC9uTEpEbytUdzV4WTdsVU5JSCs3d090akFsMkxGVEdZ?=
 =?utf-8?B?NWgveENCOFBXT2FVeEQ1dTg2SWZTOWQrckVkZkVGdWI4U1V2aUI4ekgyVWJW?=
 =?utf-8?B?OGNDelNUR2JXajFSU2dRWlVFOVNlVlJlNVkxanNtdngxaGZUaFBDOHR6ZmpV?=
 =?utf-8?B?WHdPYUlhbjBPRElMK1ZhWnZEOUNJeko3WThXemJ2ZDNuekVSU3dkZzM3RjZr?=
 =?utf-8?B?eDkvSzBpUXk5NGlPeTNNVUUwc2FqSFl4M3VNTnR3V0l4RnJ1NEVCNktGRWVF?=
 =?utf-8?B?dDJWM25EVTJmUUw0cW9EWUpXNlV1NWsvY2JnRm04eFROS3N1a3ZDbDRVVm83?=
 =?utf-8?B?UFlIRllZTFMwSGJOS0Y4RXpTOXhpQnR2dFFhcG9rUzNOeWtMeXBPSVJXbWFH?=
 =?utf-8?B?eHNtdzZZWEZxRWRQcHpabFN4Vmx6VEc1SFNEMGhxMTJYK2FDalA3aktkblpB?=
 =?utf-8?B?MDJ4RFlxY0RjNGpwVHNLVTh2MjVKeHg1Zm14bUpjSThtc1VzYm5qY1BMUlBx?=
 =?utf-8?B?UkhSTWY2c01tTTgzeXNNd2lGcENDUmlZR3VsNTBocXpuYUd5Vk80UHV5bjNh?=
 =?utf-8?B?MWxsVkQwQnlUQ3l3U1hOQ0dJVStQUGUyajZmZjZHVnZNM2VVdHJuMERBSzJn?=
 =?utf-8?B?d3JTc3N2SWc0WVk5NzUybVpDemdKa2ZmamI2YW5iZUo5RUJEeFh4MythR1Rr?=
 =?utf-8?B?KzJvTS9LLzVmNFB1NzlRUU5NckFBSnNYRkNuYm1OSkU0NlhwU1NmNDFKOHlj?=
 =?utf-8?B?d3h3QjZtSXVlVElKNXZXVnNOY1dLam8xT1BDSXZJVWtCZHV3U0E3ZmxJbjdp?=
 =?utf-8?B?SFp3VS9QSHc5WnZKcnFSZWFnZWNpS0NBeEJISzVKb1RlWnVva3RlYjA5UmFa?=
 =?utf-8?B?NStFdVQzNGoxamNaVTlSblFWdUY0Y3JnTk9TQ0p4Zk10YVRDanhZSmtXVHh3?=
 =?utf-8?B?UVVVWDgwdmF1a1MyMDlFcTBpQnhBU3pxN0dXZWhZWmR5aURudCtCN3dCTXFS?=
 =?utf-8?B?ckdFb0hySTdGU2lmSHQ2UE1HUmwyVW1ONk9BUks3ZFNvRVh0Rk0zTTFDSUFh?=
 =?utf-8?B?bTloQWRTRkpQK3NZLzZLZDRYdEpnWnljLzIvcCtVUklFMGk3bllhakY0V3Yw?=
 =?utf-8?B?eXFnL0M0eE1vVTQ2ZlF5TlZoUEhrTkV2YnhTTzNDUndCbGZqMFU1MTIzTFZU?=
 =?utf-8?B?ODVBRyt5OEgwdVRtVGprS0FldVNoWHRXNmlXTUpySHUwdHlzdC9NRkUraE5o?=
 =?utf-8?B?Qnh4Wmh0QktNcHNyR0NpUHc3bC84QlZDSWdNSm43ZmpHdXV5MDdwTTlHcVVq?=
 =?utf-8?B?RFlrSzdTSFdUT0FZbVVNTlc4SnRFWk51b1BRcTd3NkRYWW9WRlp1Y3JnQ0Fv?=
 =?utf-8?B?NVE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cde3e27-ec3f-4dfe-f9b4-08ddb983fb0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 16:17:46.0152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ulERuNqJ/UtZINyeK0WRB+/sHqDFXGVuKDPyGo5tD0Ziml4rh7kDNCqKG3aCTKOMY9KWllLi7ORsnHeMaoOvxCAmpSm8x2VQ49lc0iCQqQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8608
X-OriginatorOrg: intel.com

T24gVGh1cnNkYXksIEp1bHkgMywgMjAyNSAxMjowNCBBTSwgU3RhbmlzbGF2IEZvbWljaGV2IDxz
dGZvbWljaGV2QGdtYWlsLmNvbT4gd3JvdGU6DQo+T24gMDcvMDIsIFNvbmcsIFlvb25nIFNpYW5n
IHdyb3RlOg0KPj4gT24gV2VkbmVzZGF5LCBKdWx5IDIsIDIwMjUgMTE6MTkgUE0sIFN0YW5pc2xh
diBGb21pY2hldg0KPjxzdGZvbWljaGV2QGdtYWlsLmNvbT4gd3JvdGU6DQo+PiA+T24gMDcvMDIs
IFNvbmcsIFlvb25nIFNpYW5nIHdyb3RlOg0KPj4gPj4gT24gV2VkbmVzZGF5LCBKdWx5IDIsIDIw
MjUgMTA6MjMgQU0sIFNvbmcsIFlvb25nIFNpYW5nDQo+PiA+PHlvb25nLnNpYW5nLnNvbmdAaW50
ZWwuY29tPiB3cm90ZToNCj4+ID4+ID5PbiBXZWRuZXNkYXksIEp1bHkgMiwgMjAyNSAxMjozMSBB
TSwgU3RhbmlzbGF2IEZvbWljaGV2DQo+PiA+PHN0Zm9taWNoZXZAZ21haWwuY29tPg0KPj4gPj4g
Pndyb3RlOg0KPj4gPj4gPj5PbiAwNy8wMSwgU29uZyBZb29uZyBTaWFuZyB3cm90ZToNCj4+ID4+
ID4+PiBJbnRyb2R1Y2UgdGhlIFhEUF9NRVRBREFUQV9TSVpFIG1hY3JvIHRvIGVuc3VyZSB0aGF0
IHVzZXIgYXBwbGljYXRpb25zDQo+Y2FuDQo+PiA+PiA+Pj4gY29uc2lzdGVudGx5IHJldHJpZXZl
IHRoZSBjb3JyZWN0IGxvY2F0aW9uIG9mIHN0cnVjdCB4ZHBfbWV0YS4NCj4+ID4+ID4+Pg0KPj4g
Pj4gPj4+IFByaW9yIHRvIHRoaXMgY29tbWl0LCB0aGUgWERQIHByb2dyYW0gYWRqdXN0ZWQgdGhl
IGRhdGFfbWV0YSBiYWNrd2FyZCBieQ0KPj4gPj4gPj4+IHRoZSBzaXplIG9mIHN0cnVjdCB4ZHBf
bWV0YSwgd2hpbGUgdGhlIHVzZXIgYXBwbGljYXRpb24gcmV0cmlldmVkIHRoZSBkYXRhDQo+PiA+
PiA+Pj4gYnkgY2FsY3VsYXRpbmcgYmFja3dhcmQgZnJvbSB0aGUgZGF0YSBwb2ludGVyLiBUaGlz
IGFwcHJvYWNoIG9ubHkgd29ya2VkIGlmDQo+PiA+PiA+Pj4geGRwX2J1ZmYtPmRhdGFfbWV0YSB3
YXMgZXF1YWwgdG8geGRwX2J1ZmYtPmRhdGEgYmVmb3JlIGNhbGxpbmcNCj4+ID4+ID4+PiBicGZf
eGRwX2FkanVzdF9tZXRhLg0KPj4gPj4gPj4+DQo+PiA+PiA+Pj4gV2l0aCB0aGUgaW50cm9kdWN0
aW9uIG9mIFhEUF9NRVRBREFUQV9TSVpFLCBib3RoIHRoZSBYRFAgcHJvZ3JhbSBhbmQNCj51c2Vy
DQo+PiA+PiA+Pj4gYXBwbGljYXRpb24gbm93IGNhbGN1bGF0ZSBhbmQgaWRlbnRpZnkgdGhlIGxv
Y2F0aW9uIG9mIHN0cnVjdCB4ZHBfbWV0YSBmcm9tDQo+PiA+PiA+Pj4gdGhlIGRhdGEgcG9pbnRl
ci4gVGhpcyBlbnN1cmVzIHRoZSBpbXBsZW1lbnRhdGlvbiByZW1haW5zIGZ1bmN0aW9uYWwgZXZl
bg0KPj4gPj4gPj4+IHdoZW4gdGhlcmUgaXMgZGV2aWNlLXJlc2VydmVkIG1ldGFkYXRhLCBtYWtp
bmcgdGhlIHRlc3RzIG1vcmUgcG9ydGFibGUNCj4+ID4+ID4+PiBhY3Jvc3MgZGlmZmVyZW50IE5J
Q3MuDQo+PiA+PiA+Pj4NCj4+ID4+ID4+PiBTaWduZWQtb2ZmLWJ5OiBTb25nIFlvb25nIFNpYW5n
IDx5b29uZy5zaWFuZy5zb25nQGludGVsLmNvbT4NCj4+ID4+ID4+PiAtLS0NCj4+ID4+ID4+PiAg
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMveGRwX21ldGFkYXRhLmMgfCAg
MiArLQ0KPj4gPj4gPj4+ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MveGRwX2h3
X21ldGFkYXRhLmMgICB8IDEwICsrKysrKysrKy0NCj4+ID4+ID4+PiAgdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvYnBmL3Byb2dzL3hkcF9tZXRhZGF0YS5jICAgICAgfCAgOCArKysrKysrLQ0KPj4g
Pj4gPj4+ICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYveGRwX2h3X21ldGFkYXRhLmMgICAg
ICAgICB8ICAyICstDQo+PiA+PiA+Pj4gIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi94ZHBf
bWV0YWRhdGEuaCAgICAgICAgICAgIHwgIDcgKysrKysrKw0KPj4gPj4gPj4+ICA1IGZpbGVzIGNo
YW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+PiA+PiA+Pj4NCj4+ID4+
ID4+PiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMv
eGRwX21ldGFkYXRhLmMNCj4+ID4+ID4+Yi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJv
Z190ZXN0cy94ZHBfbWV0YWRhdGEuYw0KPj4gPj4gPj4+IGluZGV4IDE5ZjkyYWZmYzJkYS4uOGQ2
YzI2MzM2OThiIDEwMDY0NA0KPj4gPj4gPj4+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2JwZi9wcm9nX3Rlc3RzL3hkcF9tZXRhZGF0YS5jDQo+PiA+PiA+Pj4gKysrIGIvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMveGRwX21ldGFkYXRhLmMNCj4+ID4+ID4+PiBA
QCAtMzAyLDcgKzMwMiw3IEBAIHN0YXRpYyBpbnQgdmVyaWZ5X3hza19tZXRhZGF0YShzdHJ1Y3Qg
eHNrICp4c2ssIGJvb2wNCj4+ID4+ID4+c2VudF9mcm9tX2FmX3hkcCkNCj4+ID4+ID4+Pg0KPj4g
Pj4gPj4+ICAJLyogY3VzdG9tIG1ldGFkYXRhICovDQo+PiA+PiA+Pj4NCj4+ID4+ID4+PiAtCW1l
dGEgPSBkYXRhIC0gc2l6ZW9mKHN0cnVjdCB4ZHBfbWV0YSk7DQo+PiA+PiA+Pj4gKwltZXRhID0g
ZGF0YSAtIFhEUF9NRVRBREFUQV9TSVpFOw0KPj4gPj4gPj4+DQo+PiA+PiA+Pj4gIAlpZiAoIUFT
U0VSVF9ORVEobWV0YS0+cnhfdGltZXN0YW1wLCAwLCAicnhfdGltZXN0YW1wIikpDQo+PiA+PiA+
Pj4gIAkJcmV0dXJuIC0xOw0KPj4gPj4gPj4+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9icGYvcHJvZ3MveGRwX2h3X21ldGFkYXRhLmMNCj4+ID4+ID4+Yi90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MveGRwX2h3X21ldGFkYXRhLmMNCj4+ID4+ID4+PiBpbmRl
eCAzMzBlY2UyZWFiZGIuLjcyMjQyYWMxY2RjZCAxMDA2NDQNCj4+ID4+ID4+PiAtLS0gYS90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MveGRwX2h3X21ldGFkYXRhLmMNCj4+ID4+ID4+
PiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MveGRwX2h3X21ldGFkYXRh
LmMNCj4+ID4+ID4+PiBAQCAtMjcsNiArMjcsNyBAQCBleHRlcm4gaW50IGJwZl94ZHBfbWV0YWRh
dGFfcnhfdmxhbl90YWcoY29uc3QNCj5zdHJ1Y3QNCj4+ID4+ID4+eGRwX21kICpjdHgsDQo+PiA+
PiA+Pj4gIFNFQygieGRwLmZyYWdzIikNCj4+ID4+ID4+PiAgaW50IHJ4KHN0cnVjdCB4ZHBfbWQg
KmN0eCkNCj4+ID4+ID4+PiAgew0KPj4gPj4gPj4+ICsJaW50IG1ldGFsZW5fdXNlZCwgbWV0YWxl
bl90b19hZGp1c3Q7DQo+PiA+PiA+Pj4gIAl2b2lkICpkYXRhLCAqZGF0YV9tZXRhLCAqZGF0YV9l
bmQ7DQo+PiA+PiA+Pj4gIAlzdHJ1Y3QgaXB2NmhkciAqaXA2aCA9IE5VTEw7DQo+PiA+PiA+Pj4g
IAlzdHJ1Y3QgdWRwaGRyICp1ZHAgPSBOVUxMOw0KPj4gPj4gPj4+IEBAIC03Miw3ICs3MywxNCBA
QCBpbnQgcngoc3RydWN0IHhkcF9tZCAqY3R4KQ0KPj4gPj4gPj4+ICAJCXJldHVybiBYRFBfUEFT
UzsNCj4+ID4+ID4+PiAgCX0NCj4+ID4+ID4+Pg0KPj4gPj4gPj4+IC0JZXJyID0gYnBmX3hkcF9h
ZGp1c3RfbWV0YShjdHgsIC0oaW50KXNpemVvZihzdHJ1Y3QgeGRwX21ldGEpKTsNCj4+ID4+ID4+
DQo+PiA+PiA+PlsuLl0NCj4+ID4+ID4+DQo+PiA+PiA+Pj4gKwltZXRhbGVuX3VzZWQgPSBjdHgt
PmRhdGEgLSBjdHgtPmRhdGFfbWV0YTsNCj4+ID4+ID4+DQo+PiA+PiA+PklzIHRoZSBpbnRlbnQg
aGVyZSB0byBxdWVyeSBob3cgbXVjaCBtZXRhZGF0YSBoYXMgYmVlbiBjb25zdW1lZC9yZXNlcnZl
ZA0KPj4gPj4gPj5ieSB0aGUgZHJpdmVyPw0KPj4gPj4gPlllcy4NCj4+ID4+ID4NCj4+ID4+ID4+
TG9va2luZyBhdCBJR0MgaXQgaGFzIHRoZSBmb2xsb3dpbmcgY29kZS9jb21tZW50Og0KPj4gPj4g
Pj4NCj4+ID4+ID4+CWJpLT54ZHAtPmRhdGEgKz0gSUdDX1RTX0hEUl9MRU47DQo+PiA+PiA+Pg0K
Pj4gPj4gPj4JLyogSFcgdGltZXN0YW1wIGhhcyBiZWVuIGNvcGllZCBpbnRvIGxvY2FsIHZhcmlh
YmxlLiBNZXRhZGF0YQ0KPj4gPj4gPj4JICogbGVuZ3RoIHdoZW4gWERQIHByb2dyYW0gaXMgY2Fs
bGVkIHNob3VsZCBiZSAwLg0KPj4gPj4gPj4JICovDQo+PiA+PiA+PgliaS0+eGRwLT5kYXRhX21l
dGEgKz0gSUdDX1RTX0hEUl9MRU47DQo+PiA+PiA+Pg0KPj4gPj4gPj5BcmUgeW91IHN1cmUgdGhh
dCBtZXRhZGF0YSBzaXplIGlzIGNvcnJlY3RseSBleHBvc2VkIHRvIHRoZSBicGYgcHJvZ3JhbT8N
Cj4+ID4+ID5Zb3UgYXJlIHJpZ2h0LCB0aGUgY3VycmVudCBpZ2MgZHJpdmVyIGRpZG4ndCBleHBv
c2UgdGhlIG1ldGFkYXRhIHNpemUgY29ycmVjdGx5Lg0KPj4gPj4gPkkgc3VibWl0dGVkIFsxXSB0
byBmaXggaXQuDQo+PiA+PiA+DQo+PiA+PiA+WzFdIGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5v
cmcvcHJvamVjdC9pbnRlbC13aXJlZC0NCj4+ID4+ID5sYW4vcGF0Y2gvMjAyNTA3MDEwODA5NTUu
MzI3MzEzNy0xLXlvb25nLnNpYW5nLnNvbmdAaW50ZWwuY29tLw0KPj4gPj4gPg0KPj4gPj4gPj4N
Cj4+ID4+ID4+TXkgYXNzdW1wdGlvbnMgd2FzIHRoYXQgd2Ugc2hvdWxkIGp1c3QgdW5jb25kaXRp
b25hbGx5IGRvDQo+PiA+YnBmX3hkcF9hZGp1c3RfbWV0YQ0KPj4gPj4gPj53aXRoIC1YRFBfTUVU
QURBVEFfU0laRSBhbmQgdGhhdCBzaG91bGQgYmUgZ29vZCBlbm91Z2guDQo+PiA+PiA+DQo+PiA+
PiA+VGhlIGNoZWNraW5nIGlzIGp1c3QgZm9yIHByZWNhdXRpb25zLiBObyBwcm9ibGVtIGlmIGRp
cmVjdGx5IGFkanVzdCB0aGUgbWV0YQ0KPj4gPj4gPnVuY29uZGl0aW9uYWxseS4NCj4+ID4+ID5U
aGF0IHdpbGwgc2F2ZSBwcm9jZXNzaW5nIHRpbWUgZm9yIGVhY2ggcGFja2V0IGFzIHdlbGwuDQo+
PiA+PiA+SSB3aWxsIHJlbW92ZSB0aGUgY2hlY2tpbmcgYW5kIHN1Ym1pdCB2Mi4NCj4+ID4+ID4N
Cj4+ID4+ID5UaGFua3MgJiBSZWdhcmRzDQo+PiA+PiA+U2lhbmcNCj4+ID4+ID4NCj4+ID4+DQo+
PiA+PiBIaSBTdGFuaXNsYXYgRm9taWNoZXYsDQo+PiA+Pg0KPj4gPj4gSSBzdWJtaXR0ZWQgdjIu
IEJ1dCBhZnRlciB0aGF0LCBJIHRoaW5rIHR3aWNlLiBJTUhPLA0KPj4gPj4gZXJyID0gYnBmX3hk
cF9hZGp1c3RfbWV0YShjdHgsIChpbnQpKGN0eC0+ZGF0YSAtIGN0eC0+ZGF0YV9tZXRhIC0NCj4+
ID5YRFBfTUVUQURBVEFfU0laRSkpOw0KPj4gPj4gaXMgYmV0dGVyIHRoYW4NCj4+ID4+IGVyciA9
IGJwZl94ZHBfYWRqdXN0X21ldGEoY3R4LCAtKGludClYRFBfTUVUQURBVEFfU0laRSk7DQo+PiA+
PiBiZWNhdXNlIGl0IGlzIG1vcmUgcm9idXN0Lg0KPj4gPj4NCj4+ID4+IEFueSB0aG91Z2h0cz8N
Cj4+ID4NCj4+ID5NeSBwcmVmZXJlbmNlIGlzIG9uIGtlZXBpbmcgZXZlcnl0aGluZyBhcyBpcyBh
bmQgY29udmVydGluZyB0bw0KPj4gPi0oaW50KVhEUF9NRVRBREFUQV9TSVpFLiBNYWtpbmcgSUdD
IHByb3Blcmx5IGV4cG9zZSAodGVtcG9yYXJ5KSBtZXRhZGF0YQ0KPmxlbg0KPj4gPmlzIGEgdXNl
ciB2aXNpYmxlIGNoYW5nZSwgbm90IHN1cmUgd2UgaGF2ZSBhIGdvb2QganVzdGlmaWNhdGlvbj8N
Cj4+DQo+PiBUaGFuayB5b3UgZm9yIHlvdXIgZmVlZGJhY2suIEkgYWdyZWUgdGhhdCB3ZSBkb24n
dCBoYXZlIGEgc3Ryb25nIGp1c3RpZmljYXRpb24NCj4+IGZvciBtYWtpbmcgdGhlIG1ldGFkYXRh
IGxlbmd0aCB1c2VyLXZpc2libGUgYXQgdGhpcyB0aW1lLiBJIGNvbmN1ciB3aXRoIHlvdXINCj4+
IHByZWZlcmVuY2UgdG8ga2VlcCBldmVyeXRoaW5nIGFzIGlzIGFuZCBwcm9jZWVkIHdpdGggLShp
bnQpWERQX01FVEFEQVRBX1NJWkUuDQo+Pg0KPj4gQnR3LCBkbyB5b3UgdGhpbmsgd2hldGhlciBt
eSBmaXJzdCBwYXRjaCB3aGljaCBjaGFuZ2VzIHRoZSBkb2N1bWVudGF0aW9uIGlzDQo+PiBzdGls
bCBuZWVkZWQgb3Igbm90Pw0KPg0KPlllcywgdGhlIGRvY3VtZW50YXRpb24gaXMgc3VwZXIgdXNl
ZnVsLCBsZXQncyBrZWVwIGl0IQ0KDQpTdXJlLiBJIHdpbGwga2VlcCB0aGUgZG9jdW1lbnRhdGlv
biBidXQgc3VibWl0IHYzIHRvIHJlbW92ZSB0aGUgcG9ydGlvbiB0aGF0DQpzdWdnZXN0IHVzZXIg
dG8gdXNlIGJwZl94ZHBfYWRqdXN0X21ldGEgd2l0aCBNRVRBREFUQV9TSVpFIC0gKHhkcF9idWZm
LT5kYXRhIC0geGRwX2J1ZmYtPmRhdGFfbWV0YSkuDQoNCg0K

