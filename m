Return-Path: <linux-kselftest+bounces-25681-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3AFA273BB
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 15:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAA6F3A4248
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 14:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D45C21770E;
	Tue,  4 Feb 2025 13:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FIlpEG/h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F69E21507A;
	Tue,  4 Feb 2025 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738676786; cv=fail; b=VONE04q8XWN87tYGzJDSmdmuwLEYPS1bHU9h3JszYPr6pYI42ciTo04YFlZb5GBKgU61o0N/xPQvKCL39o+vSk47iWaKaghLCYb0fkemcNnQjB9s23Y8ai4v6G1tfm8/9jEQ3OkQtJh7p2669zS7hNUDup/lXs5WTygKQPAKHok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738676786; c=relaxed/simple;
	bh=/1Kpn10d8GQJ67BG5aOK1ZqWX9fLkr1jFC9yhvWSGLM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k/AGi+ejKymFNsHSx91jWqQLhc7ryhRbW5ViwLYkD4aAzzPIwg4JE8VfVR9fI51NzEEHFfFJIIFmTn3DMVDzScMefV1GL9XLIw93jXFn78QSoCT0szKTHDGiNla2cv6LL8/ChpZZCz5r4ZVEq/J8Vo3ccgDxF4vu+vKKw9WecSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FIlpEG/h; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738676784; x=1770212784;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/1Kpn10d8GQJ67BG5aOK1ZqWX9fLkr1jFC9yhvWSGLM=;
  b=FIlpEG/hF38mMSK7hcJbEA2nwG57XBYCWyWqd3+psx82CZpii7mBj2A3
   kiW5kz7mJsNujFAJHfg/PTBqO/ajHxHeZ1v7te+3aozh5smgFGFTg9W11
   uHF0VN/wGa+ngmrHHtTXzE78PjdbBC7WdZzZqBJGcXE9mDxpXu/tkjDX/
   X25M+hBX/jcfm5LB2oBmDE5u3cIezVgT16C6MWgqAxHHsZF5pTQ+EhPYA
   m7OTPxBI5YRPBKcfQoy1B97MOmBJR3rQdzj2MnGGo1YwL5sg4nPhda0P6
   OfkNvcfHKk5XupQmmLLVSgteWWjv215I2uiR9t7lYXiC4rn9YcqCpOzqo
   g==;
X-CSE-ConnectionGUID: j9/wennRT9qUqWy46hq4hA==
X-CSE-MsgGUID: 4scJl67iTKeVKw9gx1lk0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="26803485"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="26803485"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 05:46:22 -0800
X-CSE-ConnectionGUID: hrV6bUTTQqelPBNVp/xYgw==
X-CSE-MsgGUID: DMPJZrgxRHK5ZI5KVzFR3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="111145029"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 05:46:22 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 05:46:21 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 05:46:21 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 05:46:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0SeL9p10UTdC84fxYjwH8xPy7vrmdsT//q+ptsQMjHFwkmq3Q2huPgxCN0VWYbcibXgiMd8YxcWidWo4/9hkf0imQdip0lGbjKzAmP2V1quXPNsJofGkqD86436IgsifmsQnYw7Yq6f2KvIO5C2aLxPWKEk4Z5+n+plIo/LML8kE3GLZbX1T3sBpISFD1TECMGiofnvo0qHjCAIDMnK0QRI+jKjU7SksSIKFdtkO48qlRhlC2noeh91PFEm9ZjLH7mQzYi0sdQHHFmelThuE4DqHoylxF+OgpBOVbUZDreVdPu3zauafNUB6MxB1oVKIjg6ce9tnzQW9OCY3dU8RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1Kpn10d8GQJ67BG5aOK1ZqWX9fLkr1jFC9yhvWSGLM=;
 b=sEpg7yJhz8zwNtEp+3dMb+EiO9nJ5L6JN3LCEAax7jbZCaWxR5XI38bm+Xjs6hqKWGiEPNMGVhI33sig2zQ0VEP19+D/zdTkpg1M3xtcukfdnUeXqFx/BSA5rPeF2Um/85fxCVgAhtYAH0oPjAlPlvV4SO1ODq9cVjvs1Z25kY5zzsRnYc9aLksDyhQsSi0nrjY9Jblr7jL86zP8CktCSWC8kVp+rAZoOIJjiBB8pOmdYGf4f1liX1PSt8F0IykJ5Xgq4kO92adSoDdqAKoJKXBl35CltbmtTRJWs8kw98XyGdIQoTn88KZSS+z1mkRD3zUzPgOkiMqPxqaDP9Wcfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by MW6PR11MB8368.namprd11.prod.outlook.com (2603:10b6:303:246::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 13:46:18 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6%4]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 13:46:18 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Willem de Bruijn
	<willemb@google.com>, "Bezdeka, Florian" <florian.bezdeka@siemens.com>,
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Bjorn Topel <bjorn@kernel.org>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
	<hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Damato, Joe"
	<jdamato@fastly.com>, Stanislav Fomichev <sdf@fomichev.me>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Mina Almasry <almasrymina@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>, Andrii Nakryiko <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, "Jose
 Abreu" <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Faizal Rahim
	<faizal.abdul.rahim@linux.intel.com>, Choong Yong Liang
	<yong.liang.choong@linux.intel.com>, "Bouska, Zdenek"
	<zdenek.bouska@siemens.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "xdp-hints@xdp-project.net"
	<xdp-hints@xdp-project.net>
Subject: RE: [PATCH bpf-next v7 4/5] igc: Refactor empty packet insertion into
 a reusable function
Thread-Topic: [PATCH bpf-next v7 4/5] igc: Refactor empty packet insertion
 into a reusable function
Thread-Index: AQHbdp7rCY5AnKYQ8ka8t2MtMQljeLM25zMAgAAN7NCAACBIAIAAEEDg
Date: Tue, 4 Feb 2025 13:46:18 +0000
Message-ID: <PH0PR11MB5830FC4C6958D616A22D4428D8F42@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20250204004907.789330-1-yoong.siang.song@intel.com>
 <20250204004907.789330-5-yoong.siang.song@intel.com> <Z6Hi5G0ngTnb7lb/@boxer>
 <PH0PR11MB58306CEAFF46FD493030943BD8F42@PH0PR11MB5830.namprd11.prod.outlook.com>
 <Z6IJppEFhSzMbmi9@boxer>
In-Reply-To: <Z6IJppEFhSzMbmi9@boxer>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|MW6PR11MB8368:EE_
x-ms-office365-filtering-correlation-id: f17e1dfb-d27b-4636-7980-08dd45224d6b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?fbRAaD8oKAejFcSaGb5IpT9XERLQkrPrJikmIRyVlNg0DC1HXJea0gTUZYjl?=
 =?us-ascii?Q?HmyzUX7W75Xw2dtOMPSYzo9DpIgOetbd4XKiG/Lod7+tKoQukqSTLBDVIarM?=
 =?us-ascii?Q?quORszaqKc1Q5Q5vU4x9MwNWl/BGozOXUaYuVqHpKziL30Yw5HpMIuxtAOtd?=
 =?us-ascii?Q?+yJeF0vsoQdTpRRHs/Rol4yCRItAXV8xAbD9zRyI380shHLZWnypKIyrkLHx?=
 =?us-ascii?Q?7Vpk5lJ+yqBzvMJcTR5dNdVRdfrI69ZATDueeBvSo7kyFvLlbgBaJ8yIUO6m?=
 =?us-ascii?Q?prUYr/G3xMylrZ6MSFZ2YMUGQ0UcNq8H181z80WaQGtmfddBJcNr0lzM3PIT?=
 =?us-ascii?Q?5Byh2/tw9J3e6HNlEDGCqL/m9gUn/gT1siTw769Hzp8Fq8Jhv4z2kzIIE1ud?=
 =?us-ascii?Q?XB/9uVU0NBbd4caOO74qXP1I2WiHG1J017z9eSFJVOTgYvKnWpQqMop3RUMh?=
 =?us-ascii?Q?rThCB79CDtHmTZcpMVD8wx74wEa8YF/xzT/L5peUvOpeR+0d4/yakem0H8iT?=
 =?us-ascii?Q?nI0wyHe/3OLIjIz5lifaaXKj+gw8cnp+UX53rRk+D4kkRIlyFJ5GylSJQKK3?=
 =?us-ascii?Q?8KA05mb5BU85F9XCHXrv9+f2L3xr31B58ACgUzX+xU53Mjnji1BBccAwWxr+?=
 =?us-ascii?Q?8cGvZBQFOTmAK6Va4tEmX9MKXxgN4MyppSPxWZ/PFxcPpJ+FrYslc9KpIFkK?=
 =?us-ascii?Q?k3qTxCzoFnfauwzVq+QQ2nPnYV79NkXWBv82qApY59G7Zb1JrmXxv3+ubNV9?=
 =?us-ascii?Q?mjSO8cd/dAenO1UKny5YY7qx9VcmxLf+o+u34TLTRaRJmBXGlci3H1+Fx0oA?=
 =?us-ascii?Q?z0YPed4hWmNmxrBeRSX4aMQnDLWzFuWQ8V2z66DaNPw+hJZPjOwFtc0hxkOY?=
 =?us-ascii?Q?lUPxvoHc/jkG6Wqe0mBXdDo/gb7shBMh35UW0em//Cs2wFoya0oygrc7bAG3?=
 =?us-ascii?Q?e0YURUh6pMS+31JUXK0KVHZs81yMUSjGdivVcpbJYUv0jhZILO2LwMIbD8sS?=
 =?us-ascii?Q?YjPr24WB2SGpB1foM28JVIrsVw2w8IDfh4cYH2crACQw7hLUPqVajXl09VOE?=
 =?us-ascii?Q?ZT8ZAEchIRTPTb0jGECz/N2Vmw1r7uHePhRbmPS+sW/3t4iuZObWE0gwNa+b?=
 =?us-ascii?Q?TnORQLkW4GULO6GqSsKp8XOH8bZqevICLRjbRrdk8mgsOJRydFZgxbB0/LVE?=
 =?us-ascii?Q?MGwKZy4qdyR/mvZjsguLO0FwYqjbH7/CF+AojSx3idq734F2gPEIzDLkO1W5?=
 =?us-ascii?Q?V44BZuY4oF/+ufauHf52uEBYApSc8wJgh8BqJ+7cvtKPHAXS8jMzu3kEZQB9?=
 =?us-ascii?Q?E1GFZoqbDV6LdkGDwNjlm767p/6p2Uc7cuvYKEcZYNbCPs3XvA+B3Zi/btG9?=
 =?us-ascii?Q?J3uIpm9VBp7i9CvjQ/omvUtNrMdQLnArEdHy49Bx8hTjiZfCl734cXUBQRLA?=
 =?us-ascii?Q?JkkbvES/rrA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n2WwvjhcMD+pOmmRIDowUcihp1l5C9etJfzQec52thasLyZYkyBg2bFCG0xN?=
 =?us-ascii?Q?rj+FZT3i9SBnw+70Vuud2dLq/geJHIvV+rBzD4gks+/o5FA7TE0ldTPd/xh4?=
 =?us-ascii?Q?9qSDw7GijWevzx80kvHRaaac8on6sOzSLyDWEDbDLVN1pPOsyBXO7m5aFeRE?=
 =?us-ascii?Q?0b6AC4R3gP1WMNWkT1i1MsGQ0ydbO+nP6W3KCM26bw57PH1IBBczQQuWmckW?=
 =?us-ascii?Q?j2Y6ziiVKhu2JekfspIeV0UzVZlitMwDeAPwyzk1QQxTrQCbkI/njh9G4lrk?=
 =?us-ascii?Q?SDONkEupLM94mZGyqkoUPXvea7bvW4xsREkgRAZWCZk3oIEcMoerh+uB3joR?=
 =?us-ascii?Q?Fkd3hGSduj0PpP46CcJHSZ8709x31jozN2MF+B9IeT0opdYKwoXNhUtdGWD7?=
 =?us-ascii?Q?YMfeRtCh33VP8Dwf6uEgT5Ug2tQttIR2fOSN/lfwMbDxnJJLhJyAjACh+azQ?=
 =?us-ascii?Q?Z7GS3pg8OQVWkw6rpJw+VhZBEkz3TCCvSXoOwCVVAB5bJUmmINcEjIpqwjay?=
 =?us-ascii?Q?Dr9G/C+CzRYxyHCETKK22J+ikXmdBBTmWP8cektvjhcXnrS8B9QHfs22CqkI?=
 =?us-ascii?Q?5jGYo/AFG1OyJB+6rJNg30EJpiz6ZFUPP6cG5KZFMPVU445Hzf4IjqHR5zKK?=
 =?us-ascii?Q?zYsuh0Vw2RebNGNDwjATzRzVIN8fDEN5BQl3a8yXfC5XmZwrhfDPyrYQF0Il?=
 =?us-ascii?Q?UTC3SFWXAbKd8EG1TMwXDYgmUaZvh2IGL8kUvyX/SM2jwe1NuTrK5Z1TDaLw?=
 =?us-ascii?Q?14WppI9yzEdZ9YqnL2txlVdXyp4anOae/qQ4yZHqOHv7ohMUbDwubOFOosgb?=
 =?us-ascii?Q?+MJcjCh9pDtOiLhJJsK8Ao/J0V4WMulQ5LXyZRkNwI8FKGy97Nyq3EgpBgLr?=
 =?us-ascii?Q?t1u56RLxjAZEZOc2qj2ujy6NobC+MNkTMvflSMiAGGIgftxnMg/tg+PM+UfK?=
 =?us-ascii?Q?tcuH1EFnbujr/wwPIfVCl7vPP15mMBm05NbJUZ0nEm28FrITU/usS4BMKbpx?=
 =?us-ascii?Q?UgrG7E2gBZ0MEinKGXlV2TX7JUBCxjzVaNrFv5Tjla108XFNf5KgcWHx2qG8?=
 =?us-ascii?Q?Q0LzuLn9WYTyWNz3sdlnPQXw0VJPodIq0dolBH6TYFyClc0bNGgy9zLjtE/5?=
 =?us-ascii?Q?jvpCRWN4sOYsBueadSXhQYIeqs7QKmvIg8zf94qmi++Xw/3tbspFywiZL/7T?=
 =?us-ascii?Q?Q4Yblom64U4IIKSpChO9c5TTYmIb3pvVLLvSmtFVPJo93tlkUh/tar8VI1YN?=
 =?us-ascii?Q?UhFl16cx47wIue0x5zGBVfZlQ6Yy/zq+tUqRbK4NBn8y+ZE4fQEWEu1frD5L?=
 =?us-ascii?Q?htUslT9YP1y/scgXG6VknZrF3FahncJ5uDT/f8Lj1gmCEs9d0AhEidFRdAL/?=
 =?us-ascii?Q?cEZUlXHRPz8ocd90nJnisaUh1LnEB8QpJte7PK6BU3p/9VFFNWJBVTZGiubS?=
 =?us-ascii?Q?dCNxiZxLIbez/0I+XTD7YDqvpkh0fD/nIlSgqfXfqGcMWyIjMwzDeyGJmPm7?=
 =?us-ascii?Q?aAzGTLsNpXSj4s95Nk0XgSkRnsObAMXNmB2yvW4mnwE81izLpXZUvA6onNh7?=
 =?us-ascii?Q?A8EdYdJojvdHWTRIhIySDaswBEWUc6kQTxDjiVNcBduUtBKcEB6gk5c6v9DM?=
 =?us-ascii?Q?qA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5830.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f17e1dfb-d27b-4636-7980-08dd45224d6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2025 13:46:18.6086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YUGOFN29p+TUcd3ptIEXgM2BvgRmHZSZXTpYhsZfbURlXqrdVD/lfFH8/RTsIfAawnCDg9h+1OTfeaezgk0AwTxXx3JmrTD0NtttOKI967U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8368
X-OriginatorOrg: intel.com

On Tuesday, February 4, 2025 8:36 PM, Fijalkowski, Maciej <maciej.fijalkows=
ki@intel.com> wrote:
>On Tue, Feb 04, 2025 at 12:07:21PM +0100, Song, Yoong Siang wrote:

[...]

>>
>> "insert an empty packet" is a launch time trick to send a packet in
>> next Qbv cycle. The design is, the driver will still sending the
>> packet, even the empty packet insertion trick is fail (unable to
>> allocate). The intention of this patch set is to enable launch time
>> on XDP zero-copy data path, so I try not to change the original
>> behavior of launch time.
>>
>> btw, do you think driver should drop the packet if something went
>> wrong with the launch time, like launch time offload not enabled,
>> launch time over horizon, empty packet insertion fail, etc?
>> If yes, then maybe i can submit another patch to change the behavior
>> of launch time and we can continue to discuss there.
>
>That's rather a question to you since I am no TSN expert here :P
>the alloc skbs failures would rather be a minor thing but anyways it
>didn't look correct from a first glance to silently ignore this behavior
>if rest of the logic relies on this. I won't be insisting on any changes
>here but it's something you could consider to change maybe.

I got plan to refactor the launch time configuration, but that requires
more discussion, so I prefer to submit another separate patch for it.
I will keep the launch time configuration the original way, so that
this patch set have least impact to non XDP path.

>
>The real question is in 5/5, regarding the cleaning of these empty descs
>from ZC path.
>

Sure, I replied to your comments in 5/5. Let's continue the discussion ther=
e.

Thanks & Regards
Siang

