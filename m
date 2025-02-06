Return-Path: <linux-kselftest+bounces-25881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A5EA29FB2
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 05:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFD6F7A40D8
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 04:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CB517BEC6;
	Thu,  6 Feb 2025 04:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ia0gaxSa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ABA16EB54;
	Thu,  6 Feb 2025 04:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738816331; cv=fail; b=SLGUD5RxwSn22ZvlG6riEQKVig36Q+SmrSU2/LJ3/T/qHJytGGh9CgWlv6eO1RldPqXm7xOurMfhbceos0OQivdm8I9mVDVMRLwpf6l/XG055cyblVcFbWfxkEoAJUJ0oD/9DdD0jgII2FBKjFw8BEWZEEY9Q25/HlXBSWZ2h2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738816331; c=relaxed/simple;
	bh=oImKCwuik/YXM2Johvgd1oc02EfXkfg8IW6WfyNiJaQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dPgzu2djtEShfzKKNrN37ayYrL9BDNdP4bn5IS9G8DUl/Z5dSLj+dtgz+36KwcGNEzy7Q7omEqR2Gph5PeSy/b4+sXyczz22gi0azVHFfv8LHgXPb4gEzEAohtuOJEUDSe7xHzB70ExgDbOVmK+mQWMcgQI+EPEU5JGZqWYP7w8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ia0gaxSa; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738816328; x=1770352328;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oImKCwuik/YXM2Johvgd1oc02EfXkfg8IW6WfyNiJaQ=;
  b=ia0gaxSa4ysnS/rXpVPHwg7LzPT3dfZtBJ14/D4fNbiLDoclJRHOk9ob
   VqjaKjtgQ2E6ZrGFH8mlmKJIUiKg0gPiQah2lSXpNm/LkfClwYqOwn0MS
   tvtb0jJgtqH3cbmNIzOttdAhmogS1w+QtAE+LHHMekvQoypD+NqypqRW5
   tW0nXxIvnDeSBzASeBVMoPps5aCSj5yW+MPkKo3Ek085tozdQh0SXMPjW
   WK0e4QMeMVvP0N1ppNLOsSH3yUw8qwoMjyiy4siKd7maXmm8NGvC/PTFv
   Ak+qz73V/GFMFPyB3sTT4kJ8mQrh9okMr/PjJqloqBiLxzRToELbuZeYX
   Q==;
X-CSE-ConnectionGUID: pLJZ0YGbT1ytB/WfgZI8Rg==
X-CSE-MsgGUID: 2SUGMK+yQKWOkOicB3z8UA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39282452"
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; 
   d="scan'208";a="39282452"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 20:32:07 -0800
X-CSE-ConnectionGUID: Xt8YsoWYTFWIDesPOx4Afw==
X-CSE-MsgGUID: OKOefC11Ty6pCMGFrQXouQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; 
   d="scan'208";a="111679806"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2025 20:32:05 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 20:32:04 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 20:32:04 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 20:32:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmXvDB7gzjJa5YvltffhZKe/HBul5/TTn8NnXkSdjPX6Q+QFMZ2QVVG1w3ZqNtcjdguQdp8L/y22jwDRWI7LGbHlOQhdmM4xI65HY1sBL1Sfz0dMpYKENXnP94S2s+tX6tfVRwSSEa/csKEvfCh3NzH40U2hhX8JmJC51d7UljSPVBK/b1DUHPTqDbI2IjnmWARsDTeE2Wt0afISx/56wKxLSplYjTsqLIIvkhmO0gZriiozoDTE8lWXPnn29x5FHkl+QIO8Cwm4ETjT3iUrm/Xd34NsoXUcAxcgJb3QJFNEGrPatxBni4LG8mrzHXNB6FyG+caqnEcDlTLYxbPvJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mk+ZxzYKXiLDWtKu3AD0ty3j1GdvIxC1oJM1HmbL8iY=;
 b=TiH7Jn29X7Z3uA9uLvWNspUqPlB/zgW/Tdj9zdagn8usSv/KIO2o7Tgfnok+tWTSFim68HBdX4LnBUSfkrBBZhj8qNzNWsZMwzOaeKDv1uoKt+kHh/mlW7qFLWQ1jYBP5o2m7Ka9DREEY/mNWJ1x+D90pk68HfbfRs4+/gDNl2BaTmAgc8B+mavM7RhDZi/eipCSUBobS9vj/ymGOfblSVXXoUHAolEVdLqv8X28YyYcGCy4U73lMmiUKoFyl3PwqAz2kXaONFQ8CbNSIk+v+qZnywU3O0cCbesjzdMtwPhrl5GnHcQqnWC91w/YYtMkkIj1p2KO94AWPKdhOi6/vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by DS0PR11MB7802.namprd11.prod.outlook.com (2603:10b6:8:de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Thu, 6 Feb
 2025 04:32:01 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6%4]) with mapi id 15.20.8422.009; Thu, 6 Feb 2025
 04:32:01 +0000
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
Subject: RE: [PATCH bpf-next v8 4/5] igc: Refactor empty packet insertion into
 a reusable function
Thread-Topic: [PATCH bpf-next v8 4/5] igc: Refactor empty packet insertion
 into a reusable function
Thread-Index: AQHbd3eRdwLqM9RAOUG+CEwq4T8dPbM4pMYAgAAd5GCAAB6EAIAAzl9w
Date: Thu, 6 Feb 2025 04:32:01 +0000
Message-ID: <PH0PR11MB583003D5657395162DD4253AD8F62@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20250205024116.798862-1-yoong.siang.song@intel.com>
 <20250205024116.798862-5-yoong.siang.song@intel.com> <Z6NaFkPBZA18oILE@boxer>
 <PH0PR11MB58305176708A48DD8EA60B96D8F72@PH0PR11MB5830.namprd11.prod.outlook.com>
 <Z6OMwvk9zANCD8jI@boxer>
In-Reply-To: <Z6OMwvk9zANCD8jI@boxer>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|DS0PR11MB7802:EE_
x-ms-office365-filtering-correlation-id: bd21ca59-1bf1-44bc-3099-08dd4667333e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?gHf8zeb3MO2HWcZerOcIfn/0PTvqm3GdUWLfYeOUB4Ncd+knGbFwYbiZeBpT?=
 =?us-ascii?Q?c+Amipwo9SZq9aH5jkmIfDURLXt9cMtKisFPgWGX8j0J3uLkvzMKGd8a85iC?=
 =?us-ascii?Q?Hus3aWfrYzlppfaknxi9ZyKBbp942KLr77czudzvWmmFqnFidjPcIQdFOhag?=
 =?us-ascii?Q?LW0rvQ1H0sd7u7m1cnJC6fu3w8p8Gr1QtEWjfrub7Rxws5zE84Q9RDnJIvc2?=
 =?us-ascii?Q?TOvz2JFwOI8Uk9vQ894rDU8yDZbt/H7wasYX/MjStM1X+qsIGxcpr2a1zpub?=
 =?us-ascii?Q?v/qjU6by3nX0lpm2xo/2BYXEfsmGbbUR4oXdy5JTCuoPw6nQ3fMdqJPquh8r?=
 =?us-ascii?Q?pUSBKcwRoMo9jRoiRKWRVplEgCxnTeX+g8SUMwEHQVwe7E+899GnzosqNtcR?=
 =?us-ascii?Q?mEzrzapNXtaZDoIZEboQ4JdDQFIg6unuhqI8dB+1iqgNEGtSJ7EJMerNvUdI?=
 =?us-ascii?Q?Rp9HOz8y8s41UYPYUKVdMQQ867L9GYuNVWbdZxWGVv7WnytcSLy9LBjoU5dw?=
 =?us-ascii?Q?J/Ts9Elv0Mr6qSnzva5L7eDzhqrcj6qmFM83Jsyk3a4RIM10iO3AFBs1CxA+?=
 =?us-ascii?Q?FDsLxKXSWTVeMrfyspN9vj2RmS8d1hkzoeby/C6/xK0Y2g3n/Maqhj+OQyNQ?=
 =?us-ascii?Q?E2c3u96wDAXvvs2f+VmM+eiC9HWlXteBUcXc+9uCpxzw35q6P2CV63Ech4Uq?=
 =?us-ascii?Q?21oPYKJCju0vCTYLLrR6sa/4nVWDAM6MlOQwOribsQdII/Bv8enkMD98EGXW?=
 =?us-ascii?Q?qQjdLmsEzsb6Sc5gHnsBCfHc8NnNo68jkV8dfPccMLIKEBV1ety5eq6THkHm?=
 =?us-ascii?Q?vO7hgW1EOEvKlmTlNFugvepHyxSBzd00AvEf7Y0h3x2FVW+9QgSOzogpkqQZ?=
 =?us-ascii?Q?VNIFKKl2LavF3zL5HtLjDhZ0o4tEGkxLy9W34urLM86Jtw9lP8kjYdBDpsOf?=
 =?us-ascii?Q?R2X9OlT52C97p3k/YyAjpOAOh4nvAUo+vXle2IRGI1kiznT4SBOZ03QJZmYg?=
 =?us-ascii?Q?a10K5+rCt6Ea0EDkLvXoz1bV/AE5z0WbFgHVFRdAcw3gXnciQMVBwhkOT66R?=
 =?us-ascii?Q?qsaz0l8MAgQW8JP5bwDgRK7WCoAY4+0LWDRGJ9coMgJgZ5DxfDcUXhHsouo4?=
 =?us-ascii?Q?DV+7QjKv1y9JkCF27XXQ30jB+RTHlM57ynMMRhw8vzYAyi8ndYVGW2YUBpj+?=
 =?us-ascii?Q?rg+gbP6D+ty9tqghYrnIi/2jrvME7E+PqQxn72u5TlyqIkjTC2A0FyzocYm9?=
 =?us-ascii?Q?73HHegdUrlULCtK8PVXIXkdt60qIUT+8IVUB5MFic4Au2S59wzNd3fuOXx5J?=
 =?us-ascii?Q?vjDmJD7f4mgHHQ0XGx5unoeIDX17OaxVd4vr+N9di65mNz+/CdOyRBbG4X6D?=
 =?us-ascii?Q?MUcpBA0oBQy4U0PQ1vxQCMSBeIs3810jh+tocbl02eagH5Dp80rlwCmRJe2h?=
 =?us-ascii?Q?qg1Szo//GpT4eHJMCQG4bZjVPlo5x1Js?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?67kvq3ixt3beHEzAvhvPkJte2KK5J25N19sjd1gyyvAjvwvxCk1a7cjfsK/h?=
 =?us-ascii?Q?xQlxbZWvSDmQOylVkbHps/q/I8grOXAx0iF4bOAZn0xUtq6WcE08LfmYjOeX?=
 =?us-ascii?Q?EmY2LHOvlHJRiQarmjAQjzyzNZRUbSrFnF9lNI+ZWqKiu6YiiAct67rKGMxP?=
 =?us-ascii?Q?3zVve8PZhJXIy9bc1yyjLecBebiZJe64qtaUDoLcpOy+dRbq0OYjYTqiRcCe?=
 =?us-ascii?Q?Nu26NWRCqv+Tr5TjLaaaQ7g3AOZYBQgxmqMRHccQ8y/9ps7OYXb9SzpaAyba?=
 =?us-ascii?Q?+s9XGcOFsSIicoTvLx3KIMkDrMWcGYImHhdiNDFuLZh4Uc1nAG5eByQxCtU2?=
 =?us-ascii?Q?vxfr++aVb8d+4k1dRO8H73hwhjXtcvJpvqhz0hQDgKJ8+NxA/RK0pqXgluRQ?=
 =?us-ascii?Q?gQK/WhFjbZ2lB4PedVe6xneFAEOAAOlH5WI1HafFQxfKQtI1QiSWRxCKgomZ?=
 =?us-ascii?Q?YDsaZveCzH/xyUA/yduTEYVLiuVKlU2qhnrIbykwTvFPlVobur24/PsE8kIu?=
 =?us-ascii?Q?j7ilveky1tMmcSghEOVjMoDFr07A3sg0zfsRbgibcUVuq99tjnGJZltM0ms8?=
 =?us-ascii?Q?T2iDavpQ6ljA5W3gKgXNV8MWBNyQgBK2C1R1ow2rCKtaJIpC6/6i9cOjTaKi?=
 =?us-ascii?Q?bW9ex8AZ7oep9F0BB6vOx9d06EHxS4GaH7nMRY2HKNKgTcts+p3PArPrKf80?=
 =?us-ascii?Q?BuhIYa7X7WvZx/yx+IA/ZDNtMFYwkl/NkOQK8KfG7dmzmERYRaBK2L2NdNcz?=
 =?us-ascii?Q?7DiCpsgH/WdP86OFkD5keG7jmGMcZK9t+mogLT+VNeWXmIUeGioWKdHjIrEf?=
 =?us-ascii?Q?+EeKGrBpu2Jf90u/YWh/jKYZ8+ZwlVt4pYvbR0VaHCwTpneNXD7E+gJ7mf8C?=
 =?us-ascii?Q?MokPOQtvvOvR3KdV8XR6Nd2d0x1K9VuKZGLjgn60zuppuR1ImhszWm1aIk0c?=
 =?us-ascii?Q?3eLwHvwEcpRhhNvypfrWQC5k60ndyCCa0PEqLcXrXYlAYz57zXIySe3cpfM6?=
 =?us-ascii?Q?Yk83Bu95QkNaPVoYxraqttus+8R5JYAy49D0dFyMpNOYkFYoKHI0cTll3Vvo?=
 =?us-ascii?Q?598VTOpMlIvngVLKb5z5dk+gZH5BVAanajzie/EtA9JiCZyADsBoQPBooZOq?=
 =?us-ascii?Q?9XUUqo6EUBzQPwcPbn67XplQZJM+SjEgXKmEwFbcVULFWp5pf6mB01a+JMIp?=
 =?us-ascii?Q?/Pvk5UFhn2HYHYjyRinfTsZYUuyzBOlxsFAyfk31qpg2rpfiCY5AmXkJubS0?=
 =?us-ascii?Q?tVsCBiQaYPuG79KeN9hYV6CWpWd+9+LNQwSYyXC661PbDdRnlfZmv294S/WX?=
 =?us-ascii?Q?b7rxV09NlFiL5B4uKfcXfQ35EdW2+45ckBju2LtXwMV+vo/BhIT0vKqr3+EK?=
 =?us-ascii?Q?QdQkyPDCEBjVBOhOEAVvQIXBgmu7L7XgBtRUrs44xnQbRx/0K6DUIai2c4UJ?=
 =?us-ascii?Q?S/gWGkgAuZN1CbHnoQ6XLSLSR0FbwdSBkbHKgLtUN7Z1ZUKvIAsdrThm0BGM?=
 =?us-ascii?Q?g6kV9lr7MMpvsYEUSoNjznPkdxaLemVnTUmXQvQxXo3ZCpCpzn1biKkiZBRO?=
 =?us-ascii?Q?JdFuB/ykV7KGzbXx9lmrmyPCqyrsDrRqezij5qIWmFEB1LxZqHFBI9pTXLdy?=
 =?us-ascii?Q?jw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bd21ca59-1bf1-44bc-3099-08dd4667333e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 04:32:01.1616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7XUVbZCxYB9/hJBmWYIEp57+igpWrNQBlzQWc/UqCxFMY/30WXFED4ixrPLb6GuXDXiTIbBbIPomP/qUQi0IQZrOtMtcpDfIFzWC/HCVmwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7802
X-OriginatorOrg: intel.com

On Thursday, February 6, 2025 12:08 AM, Fijalkowski, Maciej <maciej.fijalko=
wski@intel.com> wrote:
>On Wed, Feb 05, 2025 at 03:43:19PM +0100, Song, Yoong Siang wrote:
>> On Wednesday, February 5, 2025 8:31 PM, Fijalkowski, Maciej<maciej.fijal=
kowski@intel.com> wrote:
>> >On Wed, Feb 05, 2025 at 10:41:15AM +0800, Song Yoong Siang wrote:
>> >> Refactor the code for inserting an empty packet into a new function
>> >> igc_insert_empty_packet(). This change extracts the logic for inserti=
ng
>> >> an empty packet from igc_xmit_frame_ring() into a separate function,
>> >> allowing it to be reused in future implementations, such as the XDP
>> >> zero copy transmit function.
>> >>
>> >> This patch introduces no functional changes.
>> >>
>> >> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
>> >
>> >Your SoB should be last in the set of tags.
>> >
>>
>> Noted. Thanks for the tips.
>>
>> >> Reviewed-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
>> >> ---
>> >>  drivers/net/ethernet/intel/igc/igc_main.c | 42 ++++++++++++---------=
--
>> >>  1 file changed, 22 insertions(+), 20 deletions(-)
>> >>
>> >> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
>> >b/drivers/net/ethernet/intel/igc/igc_main.c
>> >> index 21f318f12a8d..553d6d82af0d 100644
>> >> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> >> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> >> @@ -1566,6 +1566,26 @@ static bool igc_request_tx_tstamp(struct igc_a=
dapter
>> >*adapter, struct sk_buff *s
>> >>  	return false;
>> >>  }
>> >>
>> >> +static void igc_insert_empty_packet(struct igc_ring *tx_ring)
>> >> +{
>> >> +	struct igc_tx_buffer *empty_info;
>> >> +	struct sk_buff *empty;
>> >> +	void *data;
>> >> +
>> >> +	empty_info =3D &tx_ring->tx_buffer_info[tx_ring->next_to_use];
>> >> +	empty =3D alloc_skb(IGC_EMPTY_FRAME_SIZE, GFP_ATOMIC);
>> >> +	if (!empty)
>> >> +		return;
>> >> +
>> >> +	data =3D skb_put(empty, IGC_EMPTY_FRAME_SIZE);
>> >> +	memset(data, 0, IGC_EMPTY_FRAME_SIZE);
>> >> +
>> >> +	igc_tx_ctxtdesc(tx_ring, 0, false, 0, 0, 0);
>> >> +
>> >> +	if (igc_init_tx_empty_descriptor(tx_ring, empty, empty_info) < 0)
>> >> +		dev_kfree_skb_any(empty);
>> >
>> >I still don't like the fact igc_insert_empty_packet() doesn't communica=
te
>> >to caller whether it successfully produced descriptors or not.
>> >
>> >Look at this from igc_xmit_frame_ring() POV:
>> >- at the beginning you peek at Tx ring whether there is required amount=
 of
>> >  descriptors free to be used
>> >- but then here's your additional routine which might consume two more
>> >  descs and you are not aware of the status
>> >- then you continue to further produce descriptors assuming there is
>> >  enough space in Tx ring
>> >
>> >Right now igc_init_tx_empty_descriptor() returns -EBUSY when ring is fu=
ll.
>> >How can that happen in the first place + what if it would *really* happ=
en
>> >though? You just continue with your Tx flow.
>> >
>> >What I'm trying to say here is, at least from correctness POV, you shou=
ld
>> >take into the account two potential descriptors for launchtime feature
>> >when calling igc_maybe_stop_tx(). And igc_init_tx_empty_descriptor()
>> >should not really care about space in ring, it should be a caller's job=
 to
>> >call it only when it will be sure it's safe to do so.
>> >
>>
>> Agree with you.
>>
>> In db0b124f02ba ("igc: Enhance Qbv scheduling by using first flag bit"),
>> the 2 descriptors needed by empty packet is already taken into
>> consideration by changing igc_maybe_stop_tx(tx_ring, count + 3) to
>> igc_maybe_stop_tx(tx_ring, count + 5), so not enough ring space issue wi=
ll not
>> happened. However, the comment session is not updated, maybe i can updat=
e
>> it in next version of this patch as below:
>>
>> @@ -1586,6 +1608,7 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_b=
uff
>*skb,
>>          *      + 1 desc for skb_headlen/IGC_MAX_DATA_PER_TXD,
>>          *      + 2 desc gap to keep tail from touching head,
>>          *      + 1 desc for context descriptor,
>> +        *      + 2 desc for inserting an empty packet for launch time,
>>          * otherwise try next time
>>          */
>>         for (f =3D 0; f < skb_shinfo(skb)->nr_frags; f++)
>
>Ahh good then, I didn't pay enough attention to comment. So it meant that
>first two entries from comment were covered by @count and 2 desc gap + 1
>ctxt desc were behind '3', previously.
>

Yes, you are right.

>>
>> Since number of descriptor needed is guaranteed. I will take out the
>> igc_desc_unused() checking in igc_init_tx_empty_descriptor().
>
>Yes
>
>> However, empty packet insertion might fail due to skb allocation failure
>> and DMA mapping error. How about i make sure skb allocation and DMA
>> mapping working, before proceed to fill in igc_tx_buffer, context desc,
>> and data desc?
>> IMHO, because these two errors are unlikely to happen, print a kernel
>> warning msg should be enough.
>>
>> @@ -1108,20 +1108,12 @@ static int igc_init_empty_frame(struct igc_ring =
*ring,
>>         return 0;
>>  }
>>
>> -static int igc_init_tx_empty_descriptor(struct igc_ring *ring,
>> +static void igc_init_tx_empty_descriptor(struct igc_ring *ring,
>>                                         struct sk_buff *skb,
>>                                         struct igc_tx_buffer *first)
>>  {
>>         union igc_adv_tx_desc *desc;
>>         u32 cmd_type, olinfo_status;
>> -       int err;
>> -
>> -       if (!igc_desc_unused(ring))
>> -               return -EBUSY;
>> -
>> -       err =3D igc_init_empty_frame(ring, first, skb);
>> -       if (err)
>> -               return err;
>>
>>         cmd_type =3D IGC_ADVTXD_DTYP_DATA | IGC_ADVTXD_DCMD_DEXT |
>>                    IGC_ADVTXD_DCMD_IFCS | IGC_TXD_DCMD |
>> @@ -1140,8 +1132,6 @@ static int igc_init_tx_empty_descriptor(struct igc=
_ring
>*ring,
>>         ring->next_to_use++;
>>         if (ring->next_to_use =3D=3D ring->count)
>>                 ring->next_to_use =3D 0;
>> -
>> -       return 0;
>>  }
>>
>>  #define IGC_EMPTY_FRAME_SIZE 60
>> @@ -1567,6 +1557,38 @@ static bool igc_request_tx_tstamp(struct igc_adap=
ter
>*adapter, struct sk_buff *s
>>         return false;
>>  }
>>
>> +static void igc_insert_empty_packet(struct igc_ring *tx_ring)
>> +{
>> +       struct igc_tx_buffer *empty_info;
>> +       struct sk_buff *empty;
>> +       void *data;
>> +
>> +       empty_info =3D &tx_ring->tx_buffer_info[tx_ring->next_to_use];
>> +       empty =3D alloc_skb(IGC_EMPTY_FRAME_SIZE, GFP_ATOMIC);
>> +       if (unlikely(!empty)) {
>> +               netdev_warn(tx_ring->netdev,
>> +                           "Fail to alloc skb for empty packet\n");
>
>That should be at least ratelimited I think, but what really is the

No problem, I will add net_ratelimit() checking.

>problem to make these routines return status and check them on caller
>side?
>

Ok, I will add return value and handle the case where the insertion of
an empty frame fails and explain the reason behind.

Thanks & Regards
Siang

