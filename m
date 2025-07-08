Return-Path: <linux-kselftest+bounces-36741-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C09BAFC0D7
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 04:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7352F42237E
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 02:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19F721FF4E;
	Tue,  8 Jul 2025 02:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OFt9Wxdv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DCA1F92A;
	Tue,  8 Jul 2025 02:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751941944; cv=fail; b=ekeW7Z4+fY5xjE80yrMdMqg7OlmiAKSu9b3ME5ct5Wn9jwJw5/zdxqGt51rNX45gqy5MU/ho6Q0/l4T/qyMLEk6iZz1xFtv+ggNWYl6bGJh+mg/sVh8Jc2yk+f/NcIE0vd+evK40qj9uUyZpg0dZbBzTqkBYc6sFbnsFe8qj0EA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751941944; c=relaxed/simple;
	bh=NklhxcDAQf6ksnsK6+YIl2+IPmnR8ywoVFcwUn/hORE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y0Y6WA3t4bor1fQ3akUdEIMRDKAsStYKYjmrZC62jFidEDfVwNBhy9dAAktms6MnKXwLdboKsVYcu5W2+ErLSWOzEdg8OJhDch9uPjTKZJE14REGKyNuci+e0LxCdDOJ4MfWxlNBDJIst1phOIvnjOT2dclpVhm/lba5cgHefEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OFt9Wxdv; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751941944; x=1783477944;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NklhxcDAQf6ksnsK6+YIl2+IPmnR8ywoVFcwUn/hORE=;
  b=OFt9WxdvZaayzkDCo57dSJ9ZMN8aVQW08/L/5/VFiYFO2eujPtOjSSTa
   aIezIcVWGooVBpf9NTb5ukhKuOhplilXIv1vCDJLM1bnHzUSPPAoszuT4
   hQonXdi7iT9ZgTtmw5sXIF/IHHUgyN3+h0deHqQ7V1TqDZHfVlFD5zMJx
   z9yqV3yeKzYzogHh++bR3IX4SSw9esnPOyVkmt60OJ3KU2a5SVVYgDH1L
   mNd9xD0jSnuK6jM/cbHYyNFmXHyztevzXej2o1uTVr+ZiGJT4o0T1hkQ8
   oS4WCQqHK8RNPSJaKBjyFPESAA9mSng+r+9AOVWnQ/FcggJ16ywsrgy8J
   g==;
X-CSE-ConnectionGUID: f5S1lWYwT6WBjRn6fLuWNw==
X-CSE-MsgGUID: K0YstAlJQ++i7xw4UyvCvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54296998"
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="54296998"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 19:32:23 -0700
X-CSE-ConnectionGUID: dN/pbRX1Q8yiANeAbxq9HQ==
X-CSE-MsgGUID: 77f54Yg0SimMr8ZVG65a0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="186398976"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 19:32:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Jul 2025 19:32:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 7 Jul 2025 19:32:21 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.74)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Jul 2025 19:32:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSSW67qm+8+zjg+gdNk1856NPuSFliZtfizaEdrqogLx2bhwdXWeiF1iiojMEO36lKdfQtLOPj8Rb1krx9odAoxotUYanngu9VCT6tswI7xtR7SlTjFq3L9lQV4RYVDNqlAROJlCgtcCMprw2KlGolejK1qrmShkYIaJLXOadBuoCryef7QP3IdsC2L8RWHCBoakXaiQxS8vHb4YoPySdz2s4YXzRcFoFO5Rgxho1ljAhxMVNFoPsne1TKH9Ji6QdHXNQuHuovNQ40otu9YfDW0Yz5WBxn3F7TafMTJL72Nq8sw6jTg+ZMLS6xBq19sn8PkReKPGArrFYqz1LdJ5Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NklhxcDAQf6ksnsK6+YIl2+IPmnR8ywoVFcwUn/hORE=;
 b=Tw6tWnYhi9TPKN+8IgcNGTcyuFlo9Sj5t/5kKmdVd+23UErcifN65fQjSd4QByBrPNi6NLw1OlrNijFCfjtmKgEs6r7u6nd0KusCaNSEAhN5J0k591iJiipx2Sqjvco4xLifElwSBrPe4PGOLSNoovNfypII1/4a4iE1Y7Aq+eEVGwJ21ddOn34OYm6Bt8CCb1Xyn+3j15Jh7MUh0LATYMfyW2g+yCmgnSgcBjnICzUcBW1XDrNC+fjdEs28kaIVEli7FqdAFD5GJBqOvY5jcYoy5An3xhPNDt0aeoFxXkKPKZgZ4n6ylwL7S9C0TscWwvBr+ivtH4v0RMv40FIgDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9254.namprd11.prod.outlook.com (2603:10b6:208:573::10)
 by IA3PR11MB8919.namprd11.prod.outlook.com (2603:10b6:208:576::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 02:32:03 +0000
Received: from IA3PR11MB9254.namprd11.prod.outlook.com
 ([fe80::8547:f00:c13c:8fc7]) by IA3PR11MB9254.namprd11.prod.outlook.com
 ([fe80::8547:f00:c13c:8fc7%5]) with mapi id 15.20.8901.023; Tue, 8 Jul 2025
 02:32:03 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
	<eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko
	<mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH bpf-next 0/2] Clarify and Enhance XDP Rx Metadata Handling
Thread-Topic: [PATCH bpf-next 0/2] Clarify and Enhance XDP Rx Metadata
 Handling
Thread-Index: AQHb6kDv34r7CwtKZU+M/H+rEE6nILQnLlWAgAA5NRCAABe7gIAABI8wgAAEoQCAAAIzQA==
Date: Tue, 8 Jul 2025 02:32:03 +0000
Message-ID: <IA3PR11MB9254F5CDD8812A6D56932407D84EA@IA3PR11MB9254.namprd11.prod.outlook.com>
References: <20250701042940.3272325-1-yoong.siang.song@intel.com>
	<20250707135507.29cb55be@kernel.org>
	<IA3PR11MB9254DC4B7984E014206A1FBFD84EA@IA3PR11MB9254.namprd11.prod.outlook.com>
	<20250707184449.42736a0a@kernel.org>
	<IA3PR11MB92545C3B2CD5778EE24244C1D84EA@IA3PR11MB9254.namprd11.prod.outlook.com>
 <20250707191742.662aeffb@kernel.org>
In-Reply-To: <20250707191742.662aeffb@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9254:EE_|IA3PR11MB8919:EE_
x-ms-office365-filtering-correlation-id: 9a633546-86de-4891-44b4-08ddbdc79ff0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ws8ncSW93hny+Gul7C4zXwHUOPQPL8yGyzDFXlTFyjkMHUzp2N6jSA/Zj8Uj?=
 =?us-ascii?Q?eBLw9wnhimYSVFRdNjTIcZqF6HqU+6xGxF5l0XD64+GtWSm2hsfW2MUVRu8F?=
 =?us-ascii?Q?DNDwdyiSZpfDjzJb+vx5doLABnTEPNqAWTmN+SUZGL2KwyXPcpfFmppmCZOM?=
 =?us-ascii?Q?4uLTWKcqFYmIbe+2V6mCAtYJ3DIn/uZ7UuFcu2CO8cqJC93TmkfNJ4cVizSk?=
 =?us-ascii?Q?EOZqMhkObKe83CMndp4W5gKqZm9ByID7IQyhteLB/3Id0j40Qoo4ZnIB7cEH?=
 =?us-ascii?Q?u3DXV54XLUiSovpgdwu/3BVRVxxA1PjIJAAtXNv1p5my2jYITAVHdjvlmvU7?=
 =?us-ascii?Q?iOparViPfJGsCHs6b27iyyQ/zzrEpCbhKhJ55M1hI2ghT0XeNRMy20SRwu8Z?=
 =?us-ascii?Q?NKVBAvXU7Be2W/gv7iSHBB0kY5fVHVhmf9cPcNALONxP5kO2S6RnuNNzeI3y?=
 =?us-ascii?Q?uthxJLp4Z5af9t8hb73J8qx6FsDhbisWqMqj8VEixr1qbFYLiocadtVp7NCn?=
 =?us-ascii?Q?Pbli1sc+ga9bspW5KQ3rI1+2Qnp+lDStKDd0sAIEKkJzosa8ggy5BzHyyAWn?=
 =?us-ascii?Q?wLeUxcg2rnUzBcisqHlG3y/BmwYu+aGrxxKiNF8kLWpwoF2E7awDRHWUtDQl?=
 =?us-ascii?Q?rSauVuR+ILc8r3i5xTxNFkMEp8EWpFgdJ/+QMm9tmHmLm1WSVdd+OUt55eKm?=
 =?us-ascii?Q?VHsbHzpbiO89GcVQTBviKxt6pUHCWLLm50EsTBV2IW7U5Jw7D/Qz39Ss4L1U?=
 =?us-ascii?Q?bDnSYX7obEjV1yawxRhBu3eYK2Uq49O/Pxdr9ErTjj9LBye3M+QDXMU+H+KL?=
 =?us-ascii?Q?1X2aOfI0So2lmsIfn+KstLk7tDwIzUdp4Wi/ZZO+zhul+Ih6wG00k/lVt6l6?=
 =?us-ascii?Q?VvCGUQ8g+4AOesIl9pMjVREPNCwFn0kojUoITx+cD0Rp4bi1xJjQPlF6Q7L0?=
 =?us-ascii?Q?0GisYXCiFKgiTimsJnd35fAywgOd/a4PpQwr0rZ4cID47Q/dvbo4NPHMGTzM?=
 =?us-ascii?Q?IbnaEAw3MD0iZH7LJ/lO4xNe/Tgk88bbLEIHIx0zHAa8w/mDrzLFm9NVV4AQ?=
 =?us-ascii?Q?1R6YWOVzLJk0eyDv8YYB6gnmY6MvhU3X0a51fXZDEOHR4EZ/8kD2B6sbX7Dc?=
 =?us-ascii?Q?5+VqTBwiZjngOaojR/V6ENCfBumvUwWRqMGy9v97zgTTL9ccuyQh5qiPswd1?=
 =?us-ascii?Q?MM9zqOix3DQNVnpJw2S7A1YKxA61nrMpnlTRGjy1FLLGr+fBlzc4XoV68Yh3?=
 =?us-ascii?Q?oYFRz9CwrDNAuQ1pr2gxJwsgxERWELKsJTO4a32efkpFdM3bPHmGn3NG/VY6?=
 =?us-ascii?Q?Y/WSFG4jho9pX9Bx8v/KfujfAoECr/fmmvnXdtLarwgOiWEtQQop0n1mp425?=
 =?us-ascii?Q?Oa/g7QI7FQ5E/pZnrl675z19jdtL1euA65jsLrzZlZenrEz7PIm0jY60B1a3?=
 =?us-ascii?Q?9c3HFXLiUIGwbID7Y1jv4ItG44N2sG/RlT1r9WZzNZV+mBSFIG1gGw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9254.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6EPJ/pa4AHcbe05h4F17Z5xAQwpZRuFU1ZLQTiyLxNdpP+kk8yNCT3tk3bAJ?=
 =?us-ascii?Q?bdqTjh8wPNe36NZ75vFIUJ9vad90pv6UmjLKw7CdVxNzIGddH7Q/JAbyejaZ?=
 =?us-ascii?Q?ELhoueG1+6IXAdOqz/WZ1SRsfFVZ/VSW3V0zxZApOWaBOVRv1EFM4kHdwH2/?=
 =?us-ascii?Q?aNc1wompa+HHFy/7t31kRIXzyiCDDJH4pQYqMK1pdorbjCbaLdo3UXqC6H/c?=
 =?us-ascii?Q?C3gB6kzk5QVkEZ3uHHGWlRqEOMoITCewMuqn70Z5VySMCDLIQX7vhHFbzeMk?=
 =?us-ascii?Q?iOZ1SPzjeGOgUG+8ocT2bnKDB/v7chhdx1AgV9sFPBt60r8lgplRyuj8ED6O?=
 =?us-ascii?Q?9/1OPNLZyHqPGjaghS1NCqWP4l/ySWfZhnB9n22J5cjDh8Aep6n9eoyUNhml?=
 =?us-ascii?Q?GMSYzR64okSDQIbJTpLdUFtEMA0S3IyZ6/JQRquAYk42+bXJ1dfryu9nmlsE?=
 =?us-ascii?Q?6nGcX8TXI4qlbZSOCrkJWZiPRlSxYF3pakms8Fp/gGzoDWSphGm29SYz1YZN?=
 =?us-ascii?Q?a2OLoObLmJRSveXgqRQYmPSqweRob8SPTkVD5afJMVfw8ChrzsEo3tTIN6Im?=
 =?us-ascii?Q?e6vBKlreSlMs6LwQ7lLc+j3g4RXb8eyWlt/UuX9A2Zid+YkLEc77Z8hIUhks?=
 =?us-ascii?Q?cnzBMWva49jYThIeomlQK/QwJ7gpuHn49epivcmdrY99nVQgRFhmosxnCikV?=
 =?us-ascii?Q?qz7b+kOzHMIISLXmqAUZGEhy4+LM366ELcNl3PlS3Poi/07l0M+++11Jva1u?=
 =?us-ascii?Q?4xHIu0W67Dzwjmk4iz7m0BKnGD3pHkksQierSG5DC0Qe+5zskMXNagF3vdfq?=
 =?us-ascii?Q?03CZ1BnRScCv5bK3kSCqpKgOQtHbu7woE4W0SojOyJ1A4Tuqm+/Mbae5gd3I?=
 =?us-ascii?Q?cFz62YEiE6mC9mxIQcG9gxstbOGOIJZwqPAJD519UKgM9IcaiuOBjcYmfQjz?=
 =?us-ascii?Q?VE/KaoNovqLU6F6YYyDvx8fVvyitZ6j+AhWHFt3mUUeEFQz8uFtuC1nc8yS0?=
 =?us-ascii?Q?BX8EY4uy1BI/f+0otfWpqgHU+lXzf8bX6db/T3AGErLQcFjLG+zr5jkqKNYf?=
 =?us-ascii?Q?OtZtJ4SqGsfABjUsOaUBWKPGVwj9bddfSFuWKxc+9NxaFxcLqzxBPLs6NrJy?=
 =?us-ascii?Q?i6fOLcjuLSrzwvFQFCkzsVtEsp22wOyS6eHAFeNgz9UOB+l6hN5GG5sFKZod?=
 =?us-ascii?Q?Uy7ENGBsDSXS3G+oAyYdc6uH8GJ/dYinHsMIL2+0t0iq1akBvRbEpWTxT6hN?=
 =?us-ascii?Q?DXS2yKUPHv/25Ua2NGTTpEm1VgTstq0kHG24shmWB1N7975qxpXqjFD7rbD3?=
 =?us-ascii?Q?jg8vKRs5KLu8+qmbkhW4s0NXsgssJt0iYtyywHlltCodDrxtjJl3H/4lsWkd?=
 =?us-ascii?Q?WKq8Az0aHbzoGMWPKbSzU/rB2u7Fc7JOhQWULZIuR090AVJOiZIPQ9GWHYA9?=
 =?us-ascii?Q?42pBBKzes7TmVDgaYXBpVUynAnlCdRmFKFZ2pS2LZgyXdTHcwCcQpWzT//9T?=
 =?us-ascii?Q?v3tWM/z8ee5f2if0vHfc24nPYzyorgGVeitAJbk1TIChfwTnXqmhW1wxMyt7?=
 =?us-ascii?Q?wfZBB4/qEv3ay+HK1fnmuDYrqjPfvOKGM62CFYiPrPPPL5TWrg1yWeKqmc2+?=
 =?us-ascii?Q?Mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9254.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a633546-86de-4891-44b4-08ddbdc79ff0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 02:32:03.5912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CFeII+BtucdAgi9P1pClIQmyZO98JTFqw3iF/ninVZ/dOE6syCyStzYB1sZaRT3CngwfmuaE1Iv1YGijtuXgz+EGKVfWtW2DUUOJajqJzO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8919
X-OriginatorOrg: intel.com

On Tuesday, July 8, 2025 10:18 AM, Jakub Kicinski <kuba@kernel.org> wrote:
>On Tue, 8 Jul 2025 02:06:11 +0000 Song, Yoong Siang wrote:
>>> Why would the driver need to move it back?
>>> On XDP_PASS an skb is constructed, so the metadata should
>>> be transferred to the skb. There is no need to copy it back
>>> as a prepend.
>>
>> I said so because I thought need to put back the timestamp
>> as prepend and then point skb_shared_hwtstamps.netdev_data to it
>> to support the ndo_get_tstamp().
>
>No need, the timestamps are set in shared info directly.
>There are multiple drivers which use the metadata prepend
>method, so I'm pretty sure it should work.

Thanks for pointing me in the right direction.
I'll proceed with updating the IGC driver and conduct tests
to ensure everything works as expected.


