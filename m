Return-Path: <linux-kselftest+bounces-25852-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79776A291D3
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 15:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0732188DA86
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 14:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF421198A38;
	Wed,  5 Feb 2025 14:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BSDviL40"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F35B198851;
	Wed,  5 Feb 2025 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738766611; cv=fail; b=TI+1MkIpqYuk+benoKo8o6AawyqD+pJHMzz+PYvsNkwyS+ZFxS21Bcs35bHOPIbMaJsES69ZmGwiFMXMhUBc2ZeUTD2XKVRoJnMxeYZXBIDEJ+J5LWlUIAc2B4RBang5AKUdPCNKZZCJ0YBiXgkKa/Eu2pdN0fLKFBxvCZmheC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738766611; c=relaxed/simple;
	bh=fOPY/eIIDJKanCVuUYDYYPXQfoc57nEExN2jXBi8JpI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yna0IM//aytOswC6CFOOv20uN8zqXFqjIbeD7qc0eSlu/f7zK/JxpthbaFNIXdyYRDDb8tovz/6gXtNaaahx2NqkgyFy/PUCiYlPMS1V7mjXosvmPuLLY7bbhilH9zXPJ1doPh6lOKX3hwngFGvITuc93SFCxOC4PVZ6ciswojo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BSDviL40; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738766610; x=1770302610;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fOPY/eIIDJKanCVuUYDYYPXQfoc57nEExN2jXBi8JpI=;
  b=BSDviL40E5EwVFgpLaeZmZBpRLuiQU1xy8tVfoAwKLnl1AwKMyJA6z3N
   NaenowULowCY8c/5Aflh8L3qsJYtYFd4sPqPfY29ihFnvwKZkEfCH1we4
   WFHtgv0f1OPrrPdApn4pSfuqYrcg4MRRWSfrFIztlVt4z0NAA58fd/5m6
   oxKibcn8NSxP2xolGkqRnVPquVgwKUm8cDv3iNipGh068VqmoQwKivgbA
   1mVItOSn6v2SlrP348ngKJKtjAMpohLNPe08tRDjABU6gftoA3ZNDlpMj
   PgPJMUuORTJ7BhwWNToupJumCTVht6n7gsLGFTu/DfJFu71Is5cOgjLWN
   w==;
X-CSE-ConnectionGUID: AVpOABBTR+OSKytqZPf/pg==
X-CSE-MsgGUID: yQRAP/ZZSLGkbxDHZJRnjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39217722"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="39217722"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 06:43:28 -0800
X-CSE-ConnectionGUID: dE7GoqvgQ/ivIGkcCcVWpg==
X-CSE-MsgGUID: UNYCVEQuSyiZDzKnqrp4Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="141817164"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2025 06:43:26 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 06:43:25 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 06:43:25 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 06:43:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkMbbYbqwBhJEzqgQeKAMSE1N0OdLcocoe8aMwKeBRAdo9MwfkHDjqGtc8g/ebx0sE2G2MzvAc0gjijIjBZMoZEhZGmmv3Z3puJt9YQFk4CUJEHgfsp/QPzvZ3B4PYT2wPgb+O6HGGn3ITixhl+d+PD9e1arYzPFT+PVdOnfaWL4hFxJmurbXFbzDy1ILPe4ToZiSfJzvUy4PGED9yqVCworTFAJsEImAJcJPvpu5RG6dJVUcRVUz+goz1FoA26Ml0UZs5WzwZBp6wGskIKLgo5Plwq3UHVk219/tIHxqcTXxwt9EodfcQ+DD1WtacEFXY+HOdHH8vfuEv9KNHUDKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jh+QDkFp+wkiDcnSdl4k914DhY1+t3s9r+mgwoUDjss=;
 b=Fc7TEDzL9CBaR69O1Kasvd/rYrYQrhHwkH5mxQv/iIvUWH3jsPJqQfoc2pOFxrUh9OTrgzfyjME80bqpNrv4+sD891afyTs2XJl5h443XrtdOswSzyOp1Cb48WhUS7gzuXREhc5eXFxXfFW/yvVQzWRlEtltXpxlOzlVOp6BrWW5vtjZcnFVYs7jBrC1Mb3/pzC+ctZ8v/xCvrMtZTPuVJEME3wCNM6MbU6PJ+u702afnqQ34Wy7Dsnlyx34hnjY7bbAA8SRr8QTG1xYFV/kjR6pxvZLP9NmWwOcatRLzH4gnv52rPQbquKezd2W4FyCEmN4fbH/ZDEqAZNoW37TLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by PH7PR11MB6426.namprd11.prod.outlook.com (2603:10b6:510:1f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 14:43:20 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6%4]) with mapi id 15.20.8422.009; Wed, 5 Feb 2025
 14:43:19 +0000
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
Thread-Index: AQHbd3eRdwLqM9RAOUG+CEwq4T8dPbM4pMYAgAAd5GA=
Date: Wed, 5 Feb 2025 14:43:19 +0000
Message-ID: <PH0PR11MB58305176708A48DD8EA60B96D8F72@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20250205024116.798862-1-yoong.siang.song@intel.com>
 <20250205024116.798862-5-yoong.siang.song@intel.com> <Z6NaFkPBZA18oILE@boxer>
In-Reply-To: <Z6NaFkPBZA18oILE@boxer>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|PH7PR11MB6426:EE_
x-ms-office365-filtering-correlation-id: f7c3997d-c5bc-46b2-218b-08dd45f36f0a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?XpH3xUTxaPcTA3IPS9J/WaW2iN6TNAlb/iZT1PZkhcy+Gs+wGKqLrTJmtWb/?=
 =?us-ascii?Q?vrgOMwccq9YG1V7oN83SnZWGTfUHTMBvIHKP+ypdIg+Pq1pgjsDx/JNdP1Ni?=
 =?us-ascii?Q?v8qQg8SqmQA/1A9Arvea4jNFjhaGPN/FSisko6rA9A+8Xxi8AppcxpgSp4nl?=
 =?us-ascii?Q?O1mmstalstlI8MdFo5otg2fVdHtK41kovejtjZbCbK/REKRgsnGGCMil3iIw?=
 =?us-ascii?Q?F4Laa2nPSvRMT9cuN5nvL66f2NYQiYhTrX95ODHzKUvwKum0Ko/lqWmapxws?=
 =?us-ascii?Q?Pn7NFGWTPxqThgxWkPMCSP24hKWroAx0DVIpu8hDnzu/YrwmDSzzvuOUprbG?=
 =?us-ascii?Q?+VuBOkE4LrevGkKLfpPWTCQpZlFrYAoasEkGjPpAvfQN0EV/JvrrE3C26phW?=
 =?us-ascii?Q?EuOyXqNqH9CuGglCCTY/SVJEXzPjcYVxSI9tGN9MPXwpcR/nzvii1Omwwvro?=
 =?us-ascii?Q?e+DvFoNBf1zZ6s79mMciqwoEed6F/PeN02CcM2WdNsm+9WYCq/KSM2u7KBcp?=
 =?us-ascii?Q?pGB6w66/N+XaKU2bbd5d6D2TTutvFgeZ4e/p7+RTeDX7HUMRifN4ycnJq49i?=
 =?us-ascii?Q?X/giKDJihm0eYlLRJKpstUOXgABO83804tHM9dRVq9LX6E/88HMKkek/cTyy?=
 =?us-ascii?Q?pmclkLO5WTFD19CY80eLT/1RgzWDBdX78wdIk2/xPasRiaIvQx31B5rr+Qu1?=
 =?us-ascii?Q?fvZTY5S4/Bah3IC7MNluylRU5bAGL7EWSeYhyASiI0rJK1e9KncB9/SrhOVl?=
 =?us-ascii?Q?JvsI1AyKqOrFsKItGpWqiO2l+EppbXH88uHqCvfB4BpLYINokerrVCXj2uG4?=
 =?us-ascii?Q?tHblIrnZZd59VdikqgDqVaZXq62Y8HQL4aOX8Ee+RfaNEqjfQkNQ8p0Km2uV?=
 =?us-ascii?Q?EV/KYJlVZ2X2uHald5aGtzdwu9cplO8xJ6h2SVN/LGNoEZuAcVtmwNf+yRTB?=
 =?us-ascii?Q?+F0FvJEDGSauc01awdM4R9BO8VQeEMXAAJiXVB9TJOn/m6UJ7cUe+4Kks7k9?=
 =?us-ascii?Q?1yepUyLTRFJkXScl8XcUBF+tZCxyfzVU608pwnOzwkTAZrGLjT4oMAFHUdog?=
 =?us-ascii?Q?pP+XLxw/VhclEn/hmg24n0yWGknZdaxdfjFqpJ+TByIQJjQER2LFzQDXmDnf?=
 =?us-ascii?Q?qs764FlKXPDVxM49pKpJXhnOOyselmLANYnygbbm1ySckR1urCfaNJnJMN7J?=
 =?us-ascii?Q?MnlikxhgfDfb3qscGuRdiYTrpar4tQ7p8gnCmZbBOJiP2Kr8g//uB0fzCasr?=
 =?us-ascii?Q?UCGq7peSllN553DmZ8W7Blv/FFYBa7YCU8P/bjhb8WK0EeFrjt936+6gvLp4?=
 =?us-ascii?Q?+zbh0C4LZCOr6jL846gZDlZAC18vjPSfChG+W72brldAjEnbtD5LYZVjaJ9a?=
 =?us-ascii?Q?LxUu0f/H9BZQdxSPY2WWPhWCWWSQwvGQjmZgv+g/eBzZIFtXMfHNKsEqiX/V?=
 =?us-ascii?Q?VQ+rSfomifcsOI+sn5vgCRkmCB95LUnl?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TI2wPjav51R92NxStUWzBz+/SoMWRrccmV0FFkUD1p3QjlTIBY+4QVmV7W91?=
 =?us-ascii?Q?NgZzn8DBozaBhN9l2OduvbZDOwz0e6lOgmVUrBroFOjCOWs4upkU/oyxfdPy?=
 =?us-ascii?Q?0CyJJXFi30P5NlFdckULg5RqyLkQVOYmWTFT+rmTG6WWgWSGU3LFInc4fXkX?=
 =?us-ascii?Q?Rjln4rnYODZzvdBvVwRy9WBtlLx4UvzF7fjbphlvMVmafaqheDid1ETzTNZC?=
 =?us-ascii?Q?PQlKOGwBA+iHvy8mFeCJ2rVw1yt2MaRhxans+EGRoUOUekwx4qWfH0XVLuhK?=
 =?us-ascii?Q?j3PlAdWIWPXTx3k1mKu5zsPpzemfkey6pzMvyd/QC/JIgLM1BZ2aA6ehsYOT?=
 =?us-ascii?Q?lfqVN3eIF2gQr1h3/yPkIYNXfXDVzD+WoUaALI6OoKQbGv3ZCkIYSaJVsGE0?=
 =?us-ascii?Q?yOjAGMETlZ76DFBPXntH50XEEORcxF12eIAbWAMokeqZQjQq4AVmqHeaeqRq?=
 =?us-ascii?Q?wCnQSmce6ZLdLNONAhJKZQZ8vjGHmELD/OAb3aVXNblqNV0jszKhtXzOwU8t?=
 =?us-ascii?Q?8D5obi2IdpngthtFu1U+YvbzcUvYC5TksaN2gKvQ79HYspCSWWvT4Z1gXR6F?=
 =?us-ascii?Q?uUVZ8lvjQmfspTaRckVL2pb1GipRsD58Xdc//+jwl4M8qR+l5nV/KgKVPRlN?=
 =?us-ascii?Q?NCVG2fZ3Hpj8kgCXLFZ9egez8K5d4W/4bmLfye0JGkHtXqnhnrbavLHFVf+m?=
 =?us-ascii?Q?XEs6lJhFG6Jsr8bnSz1vw3dBJDjSyLkHxyzu4JrSKJDR3147TEmbSg4kGip5?=
 =?us-ascii?Q?+dpKQ7/082VH1Bdd+OAPQrCPwu66Ce3BzjQWjD6rJvRF00/vN9HuYIjBDP1+?=
 =?us-ascii?Q?1l9Wjt0Gd/LU0dOA6ZDnv9GQ1EHi4FAXJcOkCACUy2GmBXt26I5VQ+RE3MUR?=
 =?us-ascii?Q?msx4LnibLsyG53nC2RuEezEZ5Iu7JTcNBUx6ufL9UvqYrOAP/GocDyQRRYqH?=
 =?us-ascii?Q?BtkgqAY4+OVqglVli+LGhWGxmFOpCtY64ZUKD9B7HCp+T3Qav4+Rfqg9ycM3?=
 =?us-ascii?Q?oPf9LCWOwNWVtQUVP3kB1+WtdpJzbJeccuFc06dcifq+c8tnUhpS5SvfV3jq?=
 =?us-ascii?Q?8xkeT5g2tXbuGTicza3C5cPE1Nr873B1kO5FfQey9SyJ6WQmKIMGUjS8mAEF?=
 =?us-ascii?Q?NdxoCPZjaK0ZTrr89xAZQd6oiUJ+LDtQK7a5sVQy3wYbUiEE5658H6eEV/cu?=
 =?us-ascii?Q?X8CQ7Hf1SstFD/SCj3xd3N4Va3f5Yeb0zdMhUohbi3DaOaYcShqrH9InVVEQ?=
 =?us-ascii?Q?Gq/XuaxrmH+cZJ2DvMDHcu47TqrQqAuRLGPGk6kt2aLCE7DsP+/r6kbSYU2W?=
 =?us-ascii?Q?ZkaixajbIkw3UlNakzyVjiFwpR/vxqQxd49Wkm6GoZJdfFastwpDIRovcoa2?=
 =?us-ascii?Q?I2Vr43zHxEPlZYAv/LF74Xb/dQ9aTcAlDXivnUM5ZbvJCTLiKYoLrATY/cXY?=
 =?us-ascii?Q?TE2c6jmnGPG/g4dfm5C9QRsFcNc8NL8KVfG2b3EzLFIdfVYEls0nW4EtN1mr?=
 =?us-ascii?Q?LnHajHZXiUt8MX1TuN17PpF27BD0ysLkyAfiR1j9j3avS/wfrM82QIViCWBI?=
 =?us-ascii?Q?dPx70fQ2t2LX7BsRMTOJ7TVbTgEgKRhmCB5IgUG69QgQgoeDIGf82UjiLRf3?=
 =?us-ascii?Q?7w=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c3997d-c5bc-46b2-218b-08dd45f36f0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 14:43:19.8253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4BTPea1kT4fR7vES1gLrA+vja/VMGuxCIPbLqkiAncd6Jq0hM9hjdpGLEh64T7fG5Q3qnyKNYGp6dP2g5zdyDExQZyntdL7X6Zc1uXQ98T8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6426
X-OriginatorOrg: intel.com

On Wednesday, February 5, 2025 8:31 PM, Fijalkowski, Maciej <maciej.fijalko=
wski@intel.com> wrote:
>On Wed, Feb 05, 2025 at 10:41:15AM +0800, Song Yoong Siang wrote:
>> Refactor the code for inserting an empty packet into a new function
>> igc_insert_empty_packet(). This change extracts the logic for inserting
>> an empty packet from igc_xmit_frame_ring() into a separate function,
>> allowing it to be reused in future implementations, such as the XDP
>> zero copy transmit function.
>>
>> This patch introduces no functional changes.
>>
>> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
>
>Your SoB should be last in the set of tags.
>

Noted. Thanks for the tips.

>> Reviewed-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
>> ---
>>  drivers/net/ethernet/intel/igc/igc_main.c | 42 ++++++++++++-----------
>>  1 file changed, 22 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
>b/drivers/net/ethernet/intel/igc/igc_main.c
>> index 21f318f12a8d..553d6d82af0d 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> @@ -1566,6 +1566,26 @@ static bool igc_request_tx_tstamp(struct igc_adap=
ter
>*adapter, struct sk_buff *s
>>  	return false;
>>  }
>>
>> +static void igc_insert_empty_packet(struct igc_ring *tx_ring)
>> +{
>> +	struct igc_tx_buffer *empty_info;
>> +	struct sk_buff *empty;
>> +	void *data;
>> +
>> +	empty_info =3D &tx_ring->tx_buffer_info[tx_ring->next_to_use];
>> +	empty =3D alloc_skb(IGC_EMPTY_FRAME_SIZE, GFP_ATOMIC);
>> +	if (!empty)
>> +		return;
>> +
>> +	data =3D skb_put(empty, IGC_EMPTY_FRAME_SIZE);
>> +	memset(data, 0, IGC_EMPTY_FRAME_SIZE);
>> +
>> +	igc_tx_ctxtdesc(tx_ring, 0, false, 0, 0, 0);
>> +
>> +	if (igc_init_tx_empty_descriptor(tx_ring, empty, empty_info) < 0)
>> +		dev_kfree_skb_any(empty);
>
>I still don't like the fact igc_insert_empty_packet() doesn't communicate
>to caller whether it successfully produced descriptors or not.
>
>Look at this from igc_xmit_frame_ring() POV:
>- at the beginning you peek at Tx ring whether there is required amount of
>  descriptors free to be used
>- but then here's your additional routine which might consume two more
>  descs and you are not aware of the status
>- then you continue to further produce descriptors assuming there is
>  enough space in Tx ring
>
>Right now igc_init_tx_empty_descriptor() returns -EBUSY when ring is full.
>How can that happen in the first place + what if it would *really* happen
>though? You just continue with your Tx flow.
>
>What I'm trying to say here is, at least from correctness POV, you should
>take into the account two potential descriptors for launchtime feature
>when calling igc_maybe_stop_tx(). And igc_init_tx_empty_descriptor()
>should not really care about space in ring, it should be a caller's job to
>call it only when it will be sure it's safe to do so.
>

Agree with you.

In db0b124f02ba ("igc: Enhance Qbv scheduling by using first flag bit"),
the 2 descriptors needed by empty packet is already taken into
consideration by changing igc_maybe_stop_tx(tx_ring, count + 3) to
igc_maybe_stop_tx(tx_ring, count + 5), so not enough ring space issue will =
not
happened. However, the comment session is not updated, maybe i can update
it in next version of this patch as below:

@@ -1586,6 +1608,7 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff=
 *skb,
         *      + 1 desc for skb_headlen/IGC_MAX_DATA_PER_TXD,
         *      + 2 desc gap to keep tail from touching head,
         *      + 1 desc for context descriptor,
+        *      + 2 desc for inserting an empty packet for launch time,
         * otherwise try next time
         */
        for (f =3D 0; f < skb_shinfo(skb)->nr_frags; f++)

Since number of descriptor needed is guaranteed. I will take out the
igc_desc_unused() checking in igc_init_tx_empty_descriptor().
However, empty packet insertion might fail due to skb allocation failure
and DMA mapping error. How about i make sure skb allocation and DMA
mapping working, before proceed to fill in igc_tx_buffer, context desc,
and data desc?
IMHO, because these two errors are unlikely to happen, print a kernel
warning msg should be enough.

@@ -1108,20 +1108,12 @@ static int igc_init_empty_frame(struct igc_ring *ri=
ng,
        return 0;
 }

-static int igc_init_tx_empty_descriptor(struct igc_ring *ring,
+static void igc_init_tx_empty_descriptor(struct igc_ring *ring,
                                        struct sk_buff *skb,
                                        struct igc_tx_buffer *first)
 {
        union igc_adv_tx_desc *desc;
        u32 cmd_type, olinfo_status;
-       int err;
-
-       if (!igc_desc_unused(ring))
-               return -EBUSY;
-
-       err =3D igc_init_empty_frame(ring, first, skb);
-       if (err)
-               return err;

        cmd_type =3D IGC_ADVTXD_DTYP_DATA | IGC_ADVTXD_DCMD_DEXT |
                   IGC_ADVTXD_DCMD_IFCS | IGC_TXD_DCMD |
@@ -1140,8 +1132,6 @@ static int igc_init_tx_empty_descriptor(struct igc_ri=
ng *ring,
        ring->next_to_use++;
        if (ring->next_to_use =3D=3D ring->count)
                ring->next_to_use =3D 0;
-
-       return 0;
 }

 #define IGC_EMPTY_FRAME_SIZE 60
@@ -1567,6 +1557,38 @@ static bool igc_request_tx_tstamp(struct igc_adapter=
 *adapter, struct sk_buff *s
        return false;
 }

+static void igc_insert_empty_packet(struct igc_ring *tx_ring)
+{
+       struct igc_tx_buffer *empty_info;
+       struct sk_buff *empty;
+       void *data;
+
+       empty_info =3D &tx_ring->tx_buffer_info[tx_ring->next_to_use];
+       empty =3D alloc_skb(IGC_EMPTY_FRAME_SIZE, GFP_ATOMIC);
+       if (unlikely(!empty)) {
+               netdev_warn(tx_ring->netdev,
+                           "Fail to alloc skb for empty packet\n");
+               return;
+       }
+
+       data =3D skb_put(empty, IGC_EMPTY_FRAME_SIZE);
+       memset(data, 0, IGC_EMPTY_FRAME_SIZE);
+
+       /* Prepare DMA mapping and Tx buffer information */
+       if (unlikely(igc_init_empty_frame(tx_ring, empty_info, empty))) {
+               dev_kfree_skb_any(empty);
+               netdev_warn(tx_ring->netdev,
+                           "Fail to map DMA for empty packet\n");
+               return;
+       }
+
+       /* Prepare context descriptor for empty packet */
+       igc_tx_ctxtdesc(tx_ring, 0, false, 0, 0, 0);
+
+       /* Prepare data descriptor for empty packet */
+       igc_init_tx_empty_descriptor(tx_ring, empty, empty_info);
+}
+
 static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
                                       struct igc_ring *tx_ring)
 {

Are above codes resolve your concern? If yes, i can test and add
them into this patch in next version submission.

Thanks & Regards
Siang

