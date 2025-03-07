Return-Path: <linux-kselftest+bounces-28489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A90A56A35
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 15:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4FFE16D332
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 14:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAB421B8FE;
	Fri,  7 Mar 2025 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AMcKEnDo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8337621ABA2;
	Fri,  7 Mar 2025 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357272; cv=fail; b=hDgtQIeGwbRfDEk4g+dcKN+ilijkM5/ImTMc21LgXVVjd5NyLWTFGDFvT+Jl/autCd7/aZS0TeROlG1/pQPZ0Llx0/f9q/4bMa4lW7kxtqD8wpPDjk+roasrMGCjiuhFryWahlBfJAmAYx+gu5ZNt+FaE6lXf8wdae1FBH0v4wE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357272; c=relaxed/simple;
	bh=CfjpXFiY3a8da/2BcfuGk5JY8Eo78pqmBMBly+Kejbs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bprfo44H5N+zu1oEm7Hk4LtrAv43zuSlUJfbojUTWAwWpJBEqxRI05SAm7j1V1XwbKPMx/61v9L4gY7zRMJHghL/k/9FBfe6b3X2TlxrZHi2VNJH4cIBge7ZDq91JJq6Uz3D4isSrsRGgpkEEEQidQgztStWUKIm6iZvzD9K0kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AMcKEnDo; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741357271; x=1772893271;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CfjpXFiY3a8da/2BcfuGk5JY8Eo78pqmBMBly+Kejbs=;
  b=AMcKEnDo0I9+0FmridDSFUQS7MWIkxrktK/djgfdywn7E+GIsmdAcHMZ
   sfyI62Cn7iCSQvlgbrbov0IkiLQo6YNtHNWfSguhm9KFbKgzbHoc3Z5WC
   8+5BiQPj6HNByV/Ox7cPEg6uvjKgX2G7l9qWWxImWcLhfGKxPkEZODSs7
   DEWUKKc9OLzV8oEp6+J0/+66mrMgeHYRme5DrxSQlsqgp0Hm3kOIhASXs
   CDNzB935R67G+YjsOU3AwxB48IAvRVff0Mbqj3tVqrlOquEXaHHSoav80
   lFOOLzQYJBqYDfGA+KNNXnVkAnrMhlZb3Ywx01WJWVNkD5o2SVxC8cKPa
   g==;
X-CSE-ConnectionGUID: Vjad3pW5RKKiLyUW+RQr3Q==
X-CSE-MsgGUID: TwB4PWWrQAmw0CYOXSaXCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="53045946"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="53045946"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 06:21:09 -0800
X-CSE-ConnectionGUID: BxX4uothQxyYoPnd+Rs6fA==
X-CSE-MsgGUID: tFExabKKTbiIcBy5+FeVpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119260937"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 06:21:08 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 7 Mar 2025 06:21:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 06:21:07 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 06:21:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pyrq6JUlVNlHoZlTMXujN/iO9SjWvLxUuy2H4gTGx6ky758npudWzv6cKu7BB06mqKqBwaNiMWsbwsuad0jys4xjRipIfzjy7PjzzE8wpf9T5TgqTFQqksivvU/YMDkYGCl1L8OaARkaOx1+aUBaf6H9cgo6iJsQYuXXAY9+jpOFH5fPSWaMliOrlxpf3a/1/Zg2qs8j5D+Dczgeicn7dLfiLYwKmChPQl3aF8uPqoGV6t1u+3VbUNqccYfi5ARb9blsUGDb4AeXQD2pHmmao2NUj3ZQC6OSZ5IvSXUShboerxHlRlWxqj58w1J8kqooawkYHz2p1hiclaxbnQfv8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4+3Q5FZE2eH6tqLcrpYIBHRVeM8J0uO6XdUI/WEkW0=;
 b=W0/HqwJKiK7A7Q1qhLh8CW7LddZfu75YOTbl0AdAmzRz0cEPvSobaB91DTShTceU86SflhdkyMbi6a4Wz1OEXOZCCHxWf9F6WzYrm/uthVDW8HJlFbHpTvYS+bAw5TmcpVdAWGI74rn4auOHedS7nETWNGvU2Th6mhHDy6DJc+RAOxuyOXy1QzAzZp0ExPpAwx6pBZAPLIMsV9FxXumgQK4gol1wx6tVM2WwbhOQxfPVIZc3WrLd1LBdIn89gXzalfNYOqo2liZ8Y4BkGnOX0BVQm8lY79B5GL8iPddAy9XCN+8x28RVwyYXR2EUvKtczfwNZ28+hLPM46cRRYCB+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by BY1PR11MB8080.namprd11.prod.outlook.com (2603:10b6:a03:528::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 14:20:49 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 14:20:49 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: "Bouska, Zdenek" <zdenek.bouska@siemens.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Willem de Bruijn <willemb@google.com>, "Bezdeka, Florian"
	<florian.bezdeka@siemens.com>, Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Bjorn Topel <bjorn@kernel.org>, "Karlsson,
 Magnus" <magnus.karlsson@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
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
	<yong.liang.choong@linux.intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "xdp-hints@xdp-project.net"
	<xdp-hints@xdp-project.net>
Subject: RE: [PATCH bpf-next v12 5/5] igc: Add launch time support to XDP ZC
Thread-Topic: [PATCH bpf-next v12 5/5] igc: Add launch time support to XDP ZC
Thread-Index: AQHbgFYqWswECC+nwUG+ZJIc0oRjPrNnyA+AgAALhdA=
Date: Fri, 7 Mar 2025 14:20:49 +0000
Message-ID: <PH0PR11MB58302B9F3C23B4BBEB7BAACCD8D52@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20250216093430.957880-1-yoong.siang.song@intel.com>
 <20250216093430.957880-6-yoong.siang.song@intel.com>
 <AS1PR10MB5675D13A436CB20FFE5E1082EBD52@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AS1PR10MB5675D13A436CB20FFE5E1082EBD52@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=32c776a1-e37e-408e-8746-b3b86ed4e75a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-03-07T13:03:43Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|BY1PR11MB8080:EE_
x-ms-office365-filtering-correlation-id: f38fcd35-3bf4-4f67-a356-08dd5d83425d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018|921020;
x-microsoft-antispam-message-info: =?us-ascii?Q?OSRvj1DGMMfqRqjvRTtsF9e4rzCvxZnb1CwyASuMx3B7GOFtu9wiOPPDPXcN?=
 =?us-ascii?Q?kufYwyMVQ1cbsQ7eB4O1gFH5AKFgEiGL9HIQ3IFgO9/37tXlX945RP0Tiy7a?=
 =?us-ascii?Q?ykD/EUW/R1rcbN30RaTygVbF4DkoqYrFtcupnzZFY6+WYdzAfyzCVurGJ8dX?=
 =?us-ascii?Q?C8I2waEosxZiAyVQ21hGNI2jIHCoupc5MFQGa2FDNHVW3TFoij2hymfepVRv?=
 =?us-ascii?Q?HFAdl6q7u/ghnZ2KFrVMaE/rbEW8IrPcUFHgZFXXQMXgYZ27YDEXy32LKozI?=
 =?us-ascii?Q?ryNjdfr9iz07gE42xf8JK5c9P7lbvief9JYmNCIRqMCzKQp8ggjp4eTgCaA+?=
 =?us-ascii?Q?G3HdMO8yRDaYR6jHiJ7ZdHTv0JEHP3jViPlMhBc5KEC2F5LVSbOHxm+jce8P?=
 =?us-ascii?Q?A2RiWcSlQn1FzbVFvdBpmi0UfS7OD+/e6Jsex9gzTscWwxDRiwA4YfsbqoYu?=
 =?us-ascii?Q?+E031rtLuyYh055k6pVjcM8nWzUHr0t0yjXjF5Wt9v1P8Fo1tY1xOI2ase7V?=
 =?us-ascii?Q?FkwWv8yIy4R/MSrAJqAZmhpSsSUVReHprXYl/418wstyqBQq2h5gHIqKdKFU?=
 =?us-ascii?Q?5b+u26gu4ruqB1bkpj5FJmyPpX5jEs2A5r/RMczl6m/JGpx3kZM7iOEYUMvA?=
 =?us-ascii?Q?vwD0wsZAayyJ+vM7HJ6znoaC3R5BDvaH02W2rgV2TvDq0g/alCZy8kZO463D?=
 =?us-ascii?Q?aYDqgNDBL88o4YAiy5SK8XnJaP4qnSptbPiBkfiYyVmXqDt7CVkScdaWiUsW?=
 =?us-ascii?Q?5uZgvZU0wpD59t55N3JmT6wKyPlZMJpwwcnKOdPH6OiPsU/sr+cxvXLOjCh2?=
 =?us-ascii?Q?MxWHCA/E7zdVApiYZuKUAQpOVXUAa+M0S1XaCxQo0zdVlWDDKGNYINUdR2rO?=
 =?us-ascii?Q?5q9qiLMvsKyD3/mLAFvSVP0/f6U8Wl9WKTK7d8AzpVY/5NfSsjprLm2x2lvB?=
 =?us-ascii?Q?yHqKwaTLUd/PrlfJ/eQvOmxGSa3vepBIkd7R+MpuqM+TFFKIhZ3dtfyelmoZ?=
 =?us-ascii?Q?6zqxNoINX+0gfn6vEZrpg0s78R5h3Drg0SjWFlqBOz0d07jnqK+ogbwK7WjI?=
 =?us-ascii?Q?86z5N/xId1vArINXGNZMgn307iUcKaB6RfQWxD6mdzV6VrMRDGRftTXDvrpX?=
 =?us-ascii?Q?AWo9zP9Pqc7tv2tyBNuCAf7Uerpqa+Lh3+0bEYrE8T0ImSIWAOhi6YyKokvA?=
 =?us-ascii?Q?m6+Rv+kfIS112bwUnLBGJSbty5DYj8DFMKPth4to5KPWCy5JpXScEPyw+xEW?=
 =?us-ascii?Q?sUsCcDw0Q3JZIXdwAi/semzUb6flDP5AnEwXxw1e1jpMd8xj49bwfWi3xMP2?=
 =?us-ascii?Q?Tsy2Bg0NoAEt5lS0RuwdxjaN6Yl/kYm0M6SGW4aX7dNPZoBRa8cSEmthEFMA?=
 =?us-ascii?Q?R8rEQ8hoggGdie2urZwSpmXihn0tgk8kD4uqDHdzaVJS9LHCwC2L6uNTBoVA?=
 =?us-ascii?Q?RDPcv/0u7DNyjoA7sfBHOhT2RLw/ITib/UR2Zm7G6mwVGkKwz9xpxw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n2i8ubMDHCmvfm513zjQdrH19i8pMbkFOVrGoAUuU7UsCRgsboy0CsSR5i8G?=
 =?us-ascii?Q?SY235asVcL6vInveZ7FzSlqsC31ieDlf0gAx8+RZpr4ehkiLpV6R5H4FEIbQ?=
 =?us-ascii?Q?bcFx8JhFk5ZVGn3TvgD2TKsx7R2KcHGyqrfVcZu3Hw3vOltcKAXA9OaswVtE?=
 =?us-ascii?Q?Smk6plRnE2w6Ci2pCj6D0wpZpENiLph94lQjrhAhHB43StAp0zfv3LZ8Bcrc?=
 =?us-ascii?Q?cHILjrzBd37yQlV7qPURrE2FM4F7bMIwaPmLj2qk04yr0+rGqDG3t8vc2jLO?=
 =?us-ascii?Q?adpjzYTMkeOoVYMJvfzVaDVYvY++4KrRZCGS3Ps4t7QeOQZcKg4GSP7YYYCT?=
 =?us-ascii?Q?0FTST4Uf9OvkDLBGQYFdC10ZVvdRcleJPcWVLlLs4eTugfh6Vky8eAhgvwYF?=
 =?us-ascii?Q?2IfJiDs43uJ06EAv1IjQYc9p44cgzwzUZqfHk6ZMqQU0U8NaH0O1d+KudWOl?=
 =?us-ascii?Q?5Z+X544wkzphMWgJLBL+xvHprKNLKrGY0yow2ZTf8+wuKzHKsKiW3eqvwf6J?=
 =?us-ascii?Q?D5BZRogtzTvUiikZm4ghzrqdiDQHdWcD8PW40C1UH2YC2lI0GvM8nNUqcgO0?=
 =?us-ascii?Q?OsnH4t+paup252Z9kuPBrt/sxvEA2EH4+zREOADRJfWgrYme9Gdw0XFkBUxW?=
 =?us-ascii?Q?436Yi+uxpRShOS8sshjrIk5eW+qa9CEgB1kgWxx94OjaGlVTZwA8YUBx471B?=
 =?us-ascii?Q?rMTVmXjWvwPucC6utLAz0JVoYEcGrFRbeWnYh8Tv6ENF4wWmn5sauqbFeCs1?=
 =?us-ascii?Q?iPxgHIfefi3V+UjfUJtZwpXQve+XHaWOTiH91t5zJL/Qt0dLB15llsKJlkXO?=
 =?us-ascii?Q?g2CAg/xEMOabL6cgGTF1h6J8/wyRlaWTqJqIpystUGS7BvS0qfxVi7i2oHCa?=
 =?us-ascii?Q?vBxEKvubZmCAgpZUZ+Lye/y81RC68Z6lSJcCMsS6D2UQveXsCAE4Uuxf5X91?=
 =?us-ascii?Q?5QkhXw7w2ThDqgnUOoELJBYARyVKVQU1qWbZ0/4XMp+Ua2QgQ51DFnKaro49?=
 =?us-ascii?Q?VaH+2pq+KITERh1829YsTHeo38F3HD3cBzB9tWcSXN1wMWqshNphjKTkmiWL?=
 =?us-ascii?Q?mou22ymHI+lTnasi39CpIgVNKt3ANVRJdArAA7XZSLAT8AH9kjidhop6aQVx?=
 =?us-ascii?Q?VzAVLLPpUgrO3LaJnYhMo0pZNuhmeFGyjfyhmEa7WQwCXWYuslEWSFZ87708?=
 =?us-ascii?Q?PDASUUVujxB8kmG2J8Og2ZB6+Z/evgzhSTLgocYw4VD8faz6yMAMRs8f+FKq?=
 =?us-ascii?Q?fpAovrNhf88VMeIns3zgHxGf3TqCCChoIqtiyZQPrAXDU9zDJ1QPVTSa/f0+?=
 =?us-ascii?Q?nCVlhEvQOKiNA240LLcTjtSF7wOKcwy4RMMVM+cJIycgtvXJGMnxJpvvpCbT?=
 =?us-ascii?Q?DqsIiAouPc4wJqaqSZdqpOzr45nzP7JSnfdTJp0HxAxhiHkKJJ7cykpVNRn1?=
 =?us-ascii?Q?WKkPu9BUm0QQXNUfTQ663lj52ZJm4GghkeZ0KptEXSdtdMDnEM/UZw1b/bzr?=
 =?us-ascii?Q?r1xu7W7SkY4dfl5jIrJL7Y+hoOQKfmHcyeLJsor1svnWeDfJXxwh54h0wRMA?=
 =?us-ascii?Q?c7BEfmceCnuJwyJPCWktJmsHDWr+Pmk1XPVHSXLgAUrHctf8T8nPObP/OdYf?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5830.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f38fcd35-3bf4-4f67-a356-08dd5d83425d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 14:20:49.1811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UJCKjqCSnS0WNX2ESmnDH+rfoOg7hQBh7Tui+/Lw+seodO+YlTX6Culw+llvi1xuua6XTN8RxLYMlXt9b0cxI5Y1kRN+hzqxWChpBT768QY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8080
X-OriginatorOrg: intel.com

On Friday, March 7, 2025 9:25 PM, Bouska, Zdenek <zdenek.bouska@siemens.com=
> wrote:

[...]

>> @@ -2996,7 +3035,13 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring=
)
>>  	ntu =3D ring->next_to_use;
>>  	budget =3D igc_desc_unused(ring);
>>
>> -	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget--) {
>> +	/* Packets with launch time require one data descriptor and one contex=
t
>> +	 * descriptor. When the launch time falls into the next Qbv cycle, we
>> +	 * may need to insert an empty packet, which requires two more
>> +	 * descriptors. Therefore, to be safe, we always ensure we have at lea=
st
>> +	 * 4 descriptors available.
>> +	 */
>> +	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget >=3D 4) {
>
>I think that here is a bug: some frames could be missed if budget < 4.
>I was able to reproduce it by sending 100000x 60 B frames with minimal IPG
>(672 ns between starts of frames) on 1Gbit/s. Always 1026 frames were not =
sent
>and were missing a AF_XDP competition. Interesting was that then even when=
 I
>sent more
>frames for hours it still was 1026 frames not sent and missing competition=
.
>
>Bug seems to be fixed when I change this line to:
>
>	while (budget >=3D 4 && xsk_tx_peek_desc(pool, &xdp_desc)) {
>
>Do you think this is a good fix?
>
>I think this bug is also in original code base, but I was only able to rep=
roduce
>it with launch time.
>

Thank you for pointing out this issue and for providing a detailed
explanation of your findings. I personally agree with your proposed fix
that make sure there is enough budget in the driver, before go peek the xsk
descriptor. Do you plan to submit bug fix patch to iwl-net?

Best regards,
Siang

