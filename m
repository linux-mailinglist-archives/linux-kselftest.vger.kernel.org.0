Return-Path: <linux-kselftest+bounces-36738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230D8AFC071
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 04:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 540FB3AB56F
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 02:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D721F20F067;
	Tue,  8 Jul 2025 02:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XoD5oA01"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC76220B7ED;
	Tue,  8 Jul 2025 02:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940397; cv=fail; b=KCgI3ny2LwRnZF/IxxzOhPnrP4hF5URnD4FJTEKWUUJcM1A3cNQKFYAmYRjYLF2PW1ONTXLHOTNJ16wRYF1yqOKxJYby+1skEgZUf1nkKoWCC+AWmnGemg54WHgAozSrXuwQe9/9xWR5eB9GOmE1VtuNoqh+vi4muaoPRoUfjO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940397; c=relaxed/simple;
	bh=qA7Y4ddaKd2COuJP4csJSvAWBhOCs4GOlcQ9otFaPZE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RPTj4scTeTjFMKcAu3NQynic5yZVLTUN33bH1J8eKPCNsKC1JgZZ1++J+o8+z0HmZnOHxriplrVi3xu1SbsWccLCfK1Jo6mmibZTwtFpu0S4wduYzNDyt6p3Gq2Ezi0VC+/V7Waa9zu6e1rgfp6CYFsHoNl7SxZs4Jxjgo5Ec+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XoD5oA01; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751940396; x=1783476396;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qA7Y4ddaKd2COuJP4csJSvAWBhOCs4GOlcQ9otFaPZE=;
  b=XoD5oA01jmdA5rCDqIPKlVOKOAI5AFUGzWAawrbhNPaJxAfqMdgBgLOO
   gKWuidM6UWr1iR7W5TEtB8pm3iUsoJH0T3ktfOQXZfgUltuxEM7+eSFoa
   9OAKlVGpApG3W0o9OWbrwDqnMYYl1T6ve4Ogc3OFz0Rko+zLuaSnuYVkX
   W3gWISNm2q9UijFcM0J6sld+kj74RroqhAJ6vIBquPCkupjrWYP8t5/Hq
   W7tZ00wMT/eOt3RwFcWnWU+WlvEI7quydmS4WJUb/lxLO24c5SnAPLaeP
   WnhZhrFrPs8dD6+FZBTGGOj6nplIKCRHhuFYVp4aNd6y2Ct66EPjSb+1W
   w==;
X-CSE-ConnectionGUID: xqVw6qkNT4Scc4NmGVQYfw==
X-CSE-MsgGUID: 8nVkf+ARTdymOuaGc1x2iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="65520657"
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="65520657"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 19:06:31 -0700
X-CSE-ConnectionGUID: KZNGCc3LRNyMzld7hFuGgA==
X-CSE-MsgGUID: /Jgzs2RFQNGyuUEGG+zCpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="154770242"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 19:06:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Jul 2025 19:06:30 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 7 Jul 2025 19:06:30 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.76)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Jul 2025 19:06:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUXc9diilhJTMoEnitmvA9cliDPG3IA1BxwsxJ1QNE7douWP0kLzlqzUMp0jejeYqkAL5kXwGxbAE6e6UjWbruV4O6gX1iTN1xbDPkudZUVMr6MyUg8xf0iYObg3reCzAS+cbyw87OImhOoFu+RdmcChzGEsC1oGMQl+t7o3WxrKRtOIMSrumkErdz70ZYOLrE62pc/Re5Dp52mPHTFtEAk6EVzrkTr0HYEAwbKOP9mYOnGJxDZoUN3sHddJuyI78OgG0h+XHPmzyr1PTHG/x7HjBo57k3bSa4uq1RZ4EH3Ou59plWovFxO5qX7OTfcxsJHk+MaYVbkLJ8SccV4SbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qA7Y4ddaKd2COuJP4csJSvAWBhOCs4GOlcQ9otFaPZE=;
 b=fXc7y4vxeZSM3gEYhlq5I+YEDZpCVx7gDnXxOLujUq2EoQsHqD2bLRXJ76pxJVsSCkXiDknYe69GsWUCAzEeFZiLhr/TGN+78mUrJRJYL5da7gmZBzTo6pK+33mRObx16nf5enFGSPK/YVyLVcTsWhIh6Hrrvu11tM975VUobW9RtxeuT2tQwZILmaew8VnFXIpCGPMA89vWaQwBcbFuRD2r3+To4nbzxQnv2g6gKQG+BjwdVaMQUP9EvcmhkujxanJYCYjf2vpq2RZyNcKSfNpRGxCtuA5p81jmWA455B0/Qzpc66qgigtfhqtRwKit7HQ5QiCBZ14RogtRnYqJNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9254.namprd11.prod.outlook.com (2603:10b6:208:573::10)
 by DM4PR11MB8090.namprd11.prod.outlook.com (2603:10b6:8:188::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 02:06:13 +0000
Received: from IA3PR11MB9254.namprd11.prod.outlook.com
 ([fe80::8547:f00:c13c:8fc7]) by IA3PR11MB9254.namprd11.prod.outlook.com
 ([fe80::8547:f00:c13c:8fc7%5]) with mapi id 15.20.8901.023; Tue, 8 Jul 2025
 02:06:12 +0000
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
Thread-Index: AQHb6kDv34r7CwtKZU+M/H+rEE6nILQnLlWAgAA5NRCAABe7gIAABI8w
Date: Tue, 8 Jul 2025 02:06:11 +0000
Message-ID: <IA3PR11MB92545C3B2CD5778EE24244C1D84EA@IA3PR11MB9254.namprd11.prod.outlook.com>
References: <20250701042940.3272325-1-yoong.siang.song@intel.com>
	<20250707135507.29cb55be@kernel.org>
	<IA3PR11MB9254DC4B7984E014206A1FBFD84EA@IA3PR11MB9254.namprd11.prod.outlook.com>
 <20250707184449.42736a0a@kernel.org>
In-Reply-To: <20250707184449.42736a0a@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9254:EE_|DM4PR11MB8090:EE_
x-ms-office365-filtering-correlation-id: d2c0e2c7-f95a-45b8-c563-08ddbdc4030f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?SJRKzT9i7OUVr+YKaFCqrBmP+PltBoNATxQNdsyhtfs+tHzJWA41jx7+wIth?=
 =?us-ascii?Q?IY6U6a4gX6weU6ZtsVoFok2bZlctz4FuuzB4pmJsIhNdm+XmsvYW310lHGwl?=
 =?us-ascii?Q?R6LKDawFlCkkaTxywpBEcaG9lOfvQm1HLh/epJjnd9++sMdPMR4Fsr1FPPV/?=
 =?us-ascii?Q?aWPq+0Tkgd+aCikDNIVpSBFviBPhnEMBBRvYkVZl805fgI/86+XwsgrOD0Bx?=
 =?us-ascii?Q?tvf1dpmZJE/0JR/WRjZhiFgsudkgsXkwEU1oDJqEchXDmmIZ9Vd5bXxSBWQl?=
 =?us-ascii?Q?Qb7KDdzolV/1plp55oXTCaJudCt92QQcPD4Mqos7k04ZaEpLBe85l8ondKth?=
 =?us-ascii?Q?14+YbWXHxr6hLonMkviKrojbU63w6tFe9qrLG1UiKOjI75aQP6SPs/OpZnYS?=
 =?us-ascii?Q?ayuvS6ooFq4mv2xSoqTjnyIXq4v2K3R8FXZDmFOt9Rhbr6JgmMCfABmzXu1k?=
 =?us-ascii?Q?lye8wv3wBj0zkXry1LHv6XiKuLiuPLb6piBMLR7+VyY6LuxaQppR796Le1In?=
 =?us-ascii?Q?G1IXxXQnnGXb8w03oLr11/hXmM8xIrpNPHPcnsrdi3ipoxkHT59L0+XYEccW?=
 =?us-ascii?Q?06XtwYsxdoQJnvUKTjZwCEQNB0HY3Nq1TFxB3hJaTO9ewi1M0ZXGhRlnIXoy?=
 =?us-ascii?Q?L5nAh9uyD/eyb7rF9jowBR7OZL7euOuLHQ3o3rdVbl92Wa2fhZzLytKAWmIG?=
 =?us-ascii?Q?KyPnFboLiug4HfuAb3961pNWQdWcAcFj3W4ffFF9clib7QZThezP/uFM649Y?=
 =?us-ascii?Q?Cm9cyVkFNBP9UU+D9NOg+yAjOU6XFivvwMVWC9GcdR7kt2l+eEjWI89YSX4A?=
 =?us-ascii?Q?LIWiei1u371C78o+BAR0+uL9bhXaz3EESuAsEpg4GBoDBt2ipVebaygpW6le?=
 =?us-ascii?Q?J3iu0rp3Z85Li89awXKtnMOaygUm7cuLH979jUj5m03tJDbSKFJJC/4+Yhfp?=
 =?us-ascii?Q?+rbA2OEDFuqs19K1Cqy6St5luZNA3HzePD4+wz96MlL+B1hfdQQFHq3dhRI0?=
 =?us-ascii?Q?J/Xi+NAU5hdsl5GUYJf+dK5sELjo1tXmo2voly9dO3UXAMPb2KAGR6ilMJ3a?=
 =?us-ascii?Q?pIUZvG9//5i/xzEZLZr/q2RWBnO5kfgOenfb5jjQdLQuesuPM2wTzZKpdXKu?=
 =?us-ascii?Q?2ZI/bo1SDNfwBYQTZn92DZN2ciLvC5kJxbyRZ25hFfgaRbo5ZmIUCSQaHzpE?=
 =?us-ascii?Q?y0F0Am/kb2+vsOup/KQKAvml3SaYBldBE3bcHVZhL3LnjYCP42QWHVsHgl9I?=
 =?us-ascii?Q?6p+NZL2WZHuZBf5B3IwEAGXMzzRAfEOvVkxpD/qg4P0M7G3XZeGZ4YxW3qG0?=
 =?us-ascii?Q?x6xNOBl/U/DRM5wNrOZb6GmgMduNwL0b/ODZY7Z5rnpO/d1LtUvb7/ezJXLT?=
 =?us-ascii?Q?wIqZ3vR9NqRv1UUwbJtQGmtys8I5pPDTux3ij4jUIvJn4QSAxOsEkNO415Ko?=
 =?us-ascii?Q?XHrc+N5iaCwPHLcwuHAPUgv7/fzuJdlPmrlITZPnV6DU+RJLY0ZfNA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9254.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7LQAla4Xy5r6n6YpztQS3lSqP4q+Nq+TB5TqJJkLGtE263Va8RBB8K2zhTBY?=
 =?us-ascii?Q?5G5d6ikknvhRIefZbrYbykjE6lvHxMr9mubqluhRbDqeDwLE5TWtXTMa4np9?=
 =?us-ascii?Q?RJ16uFR8rl6kskHDupseTbKDPcG9m2mFvBNrsiQu0o8zP1JYEy9u0TXNc42E?=
 =?us-ascii?Q?zfmbStlyJqm4pKNBcKH9JescBs14IJmMG1zYMwD684WALBKw01Git2IrdDEj?=
 =?us-ascii?Q?BKyQDxdE98SvgtLflJM5CUuWCi3nYHKTss/DES8SBnWbaMz+ZN4i1babqJMs?=
 =?us-ascii?Q?GJCYr/MyfYuB32ZdEfCAVaW+v1mMuYZ2z23CHLnjCDwrHXNGSqlnKAVTOTLt?=
 =?us-ascii?Q?FMSbxhvbHtuSIR3WbxjrP3Ytl5HJK3BAzKkwItj7QM16dEyHMBM8JabucC4d?=
 =?us-ascii?Q?6DTAO8KRE2/LPuuVbH56GlJbs1rzaPigjnsPzwj5il2V/mjRUBNbRHmUOfBQ?=
 =?us-ascii?Q?2d/8NHLOk7nwd2q29q4ns3FFoCuSgnPTPPa6Ra2y+CSNbhL2XJE/f2g7xIv7?=
 =?us-ascii?Q?ShuSEU7pw9m5VPINOopb0tdnNTr2nPdlc2zyjzefzCnr1NUrnyQnnGHNMHz4?=
 =?us-ascii?Q?JhFzxTX6CNIvci32yYRCg3yOqD05I8JtO0qc4Tp8OJMrpa6qVrSTQO+IfvG3?=
 =?us-ascii?Q?ZWLynT8Wi45Xe6c5B9RV7rEm/DRq6LwObjwr3f0Vbmyn0rmIeaucIok204zF?=
 =?us-ascii?Q?KRUM0iiUuyQAjKGX2BXSa7k8i+NS+ck9I4D3A8kwHiJd840kuegR8WcBJGCt?=
 =?us-ascii?Q?VHBClj0D0j325MkLkJ9tkKk4KzsKEuKjjCVmdCXLmflMjO+RAUmSPZvdH9iB?=
 =?us-ascii?Q?8Hn3W31301Wqst03yWl5MaoT5j107wopUgysO5l3GZtINDkCB47z/cx063yi?=
 =?us-ascii?Q?8BEsTydyVvlIkP7z6RpEjXj+1fvAXdEjWoElpFAMRDrdB4sPtxAhYuu97WkY?=
 =?us-ascii?Q?TiZmOF5nhLHlgezyYKE8rTtAus37nCdsdRMTMPXDO4AFhsXaUiGO8w42CJBV?=
 =?us-ascii?Q?CTe2ruSR9ausp/St4qsc+6NLLbxIPoSrRnNnb03CkqGnSzFQD3x/kKBqffUz?=
 =?us-ascii?Q?OSH3vfwNZA02jCb5UH/zYb7wxmzbg3CUHDESOkkHdGQFqtGVSeo/kDESYl4r?=
 =?us-ascii?Q?2Gj5sgKFbgSypO2Bd57TXibXyvRt9bFs0oo4lsiZQDkwN7r2K+7pyN4J3wDR?=
 =?us-ascii?Q?nKxOqrx9BpZFNwDyw4rzPppl4XLvOleL9gmHE2WAHk8yld5ITtiYzU2QAVrH?=
 =?us-ascii?Q?Yk7r1CdoGCPcl8+H2u+5H6h3LyHy+91DX2VC7/htKzC1QutETrLULGgEcEwY?=
 =?us-ascii?Q?H22/vR963ExIXrEAd/hyC4GL7jBSEjIzTYhc8jnNVrBQx4AoFfD6CJ9wAe6R?=
 =?us-ascii?Q?/P/bDaFJGOT5UdSKaL1lC2UtXBHn5IEmaHD0O1dU1MP8LqhxWdqOcquSjxny?=
 =?us-ascii?Q?v2dRrVnY0np0ExcGnZPL12nIQSt4DHQ7YgVlKrmAbX4IhNKi66o7pD31mTzv?=
 =?us-ascii?Q?vsK32fHFgPm1Cp+fDKHoL1GevOESCahz5SKzyLVafrHlQ8/fU9LMhmvmidmL?=
 =?us-ascii?Q?mGfki19WufW4A0QZ/SeGrhDgK6ubYuAqPnEmFWBPxZFpf4NzejgpZ/aQHtBS?=
 =?us-ascii?Q?WA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c0e2c7-f95a-45b8-c563-08ddbdc4030f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 02:06:11.8509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +xojRm1Iw1C9S1m/dQADqPCD0v93xeflUnicSfbTcUJNrjIpWYeJIaLxCv8WAfrmszGit+vCnfy2uFrO6Qr6SbQcn43uYezvI42ApHR7u7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8090
X-OriginatorOrg: intel.com

On Tuesday, July 8, 2025 9:45 AM, Jakub Kicinski <kuba@kernel.org> wrote:
>On Tue, 8 Jul 2025 01:34:13 +0000 Song, Yoong Siang wrote:
>> >For normal XDP my understanding is that its the driver's responsibility
>> >to move the "reserved" stuff out of place before presenting the frame t=
o
>> >program.
>>
>> Is it means that driver needs to move out the "reserved" stuff before XD=
P program
>> and then move back the stuff after XDP program for certain situation, li=
ke
>XDP_PASS?
>
>Why would the driver need to move it back?
>On XDP_PASS an skb is constructed, so the metadata should
>be transferred to the skb. There is no need to copy it back
>as a prepend.

I said so because I thought need to put back the timestamp
as prepend and then point skb_shared_hwtstamps.netdev_data to it
to support the ndo_get_tstamp().

I haven't study the code flow in detail, so I might be missing something.

