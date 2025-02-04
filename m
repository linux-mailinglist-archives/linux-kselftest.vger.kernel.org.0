Return-Path: <linux-kselftest+bounces-25691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B3CA274D7
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 15:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA8177A1715
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 14:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394092139CE;
	Tue,  4 Feb 2025 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aKHKyqTR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E6B182B4;
	Tue,  4 Feb 2025 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738680587; cv=fail; b=Wvwjt1Uz393mcOrsScb2r/3pUUVP5+amVSGhzBtjbB584iq9bLROAe65BwtcLsWQHrc1Dvegy+sPTUEuGbMHLQ7NcLkCoo/uv2UJusG10UxvHmouoeNfs5DpJRBEEh1nFiKcOmAPDFtnkBQI9e6ksuA3ZHAl42nQbn12NMgde7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738680587; c=relaxed/simple;
	bh=6AViNdXPTEYkp5pWHSxNfPytmfR8nz1oO4MUif223ds=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SisZ9Jlrw60L7VlJB93hkZMUJgcE+cyr0Q9Lwa6krMvSKLj5zb2aMBWdULdeCQA68XbzSRWS93HLLSF2iD87uR9l24MFWBNXETwf1fUh2dlTJG6CTsLzbW3x77ZvjnWAvJFMNYtRokv6ZsbSxmjM59HSQJECdAFUbekXzFr3Y5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aKHKyqTR; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738680585; x=1770216585;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6AViNdXPTEYkp5pWHSxNfPytmfR8nz1oO4MUif223ds=;
  b=aKHKyqTR8OeZVfx2EU1sKwaQnHKIkFPbDIqTdxhwtG1QtVEGZhwAoQNv
   iVvWPhosjyeWIS474qZH3wASCeWJ2eFQvMWYCQbwZcuMLU0uTuem8F1w6
   pYP226SUcBR4fwdR6MCiJmJzzd14EJzI9q7470ze3TlkPWclY3IftXwKK
   yX1tt+b2Pxu8NteQce3NLXLteffXApnN3z++vOv9mN8dOOksjbav4iwB/
   PKXg6jEt8T7Pu+LM2SFFB/TBTS0yKPV/lyK3GnNhrmzHQdcD1wJrk5gZK
   cqSgq2RvASPaqErSMyGVvRDn6wAGS4Isq4p/3wnJJ2OjRjB3a6pwm+4XW
   A==;
X-CSE-ConnectionGUID: YIwqSV9kT+u7wViEZQAAPA==
X-CSE-MsgGUID: wRMcr837RPCHbTmh8m5nGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39350045"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="39350045"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 06:49:44 -0800
X-CSE-ConnectionGUID: 0rcYD9HdQ/SzfljuQG8Elw==
X-CSE-MsgGUID: WQKniztvQgmwc3GlDl5oXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114675442"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 06:49:42 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 06:49:41 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 06:49:41 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 06:49:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WmdB21sV6KTFTIRFRNl4UXmTXsLNpFyWFOJ3GrnKn4ixG4IF/EOr0vc3+FloHVT/MfYEqfpRmY5tP5wimeRPY05gxQxbz/+oUio21MwaskLwFoVCbs28nptcSEman+qtEZesH7tpguR528MvhH18NwLsyOt9n5wJtcm6TjgoK9WVSu5jyfm7pk/Kbs4t7IHnT564rAax43DeErFcD/RqfsabqJFnINBNSeHoL+OMCfHQnG+LtDO1CpeM+kV7V//KVgNbC5wHwpE8YDxlXhJa7PkuN/ljUEKhjKy4BiAEjGf7YZ1Io2RzwKXUxdRZ65FJ13YyTK1/Owa1cFe3pWWu+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWA2mX7dRMI3rHNOtpg8+mpwDWfQTcObMKk4URLIIIc=;
 b=HpOKoOwvD09uEOMtoa+nUBpPisIIXoiIGL65GGv7WwIDYiB0GVRmogdFIRvo37e72gcCaO93pfCP4lIuaAEmWVfL17hTRp1dO380ItSi9uhQxnPOhMpBTmiTpj2wNP1yOepFv4Y3SGJmP9Pfr7liyL1TNsYdaxW7pHeGkTWrcGpihnOLT698xUPJzXDNpjvJnS0qgslaJhGT/D5jRCC9juRPiIPDIIpAqGaeTqFWJoc93GMZCsOJKIYL6iUlDBp/wdfPVbwXonfOOjlvKkErKZuAHnqqZNI1AXiIuIUqyFexI/oYF3gSZ1ccvbeRwv0LacR5U3btsf2oYA0L0Vov2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by IA0PR11MB8355.namprd11.prod.outlook.com (2603:10b6:208:480::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 14:49:32 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::c80d:3b17:3f40:10d6%4]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 14:49:32 +0000
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
Subject: RE: [xdp-hints] [PATCH bpf-next v7 5/5] igc: Add launch time support
 to XDP ZC
Thread-Topic: [xdp-hints] [PATCH bpf-next v7 5/5] igc: Add launch time support
 to XDP ZC
Thread-Index: AQHbdp72yuxX8HZUp0ilKWaa9j1bCbM27JUAgAArOGCAABYdAIAACecw
Date: Tue, 4 Feb 2025 14:49:32 +0000
Message-ID: <PH0PR11MB58308B675B0B9B95AEEBF192D8F42@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20250204004907.789330-1-yoong.siang.song@intel.com>
 <20250204004907.789330-6-yoong.siang.song@intel.com> <Z6HnaMQvgW+indqm@boxer>
 <PH0PR11MB5830422207B7D3BCB27DA04FD8F42@PH0PR11MB5830.namprd11.prod.outlook.com>
 <Z6IeNumqP1aNAphU@boxer>
In-Reply-To: <Z6IeNumqP1aNAphU@boxer>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|IA0PR11MB8355:EE_
x-ms-office365-filtering-correlation-id: 7b514b26-3ae9-451a-156a-08dd452b22cd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?FerD3LneRNADukZN8LtLlhboDXlwKkSibR2F5s0qKuknv+VD4idf1w8G/Dxj?=
 =?us-ascii?Q?nr9CPNt0Y9BQJ2LB1AHAX5MkDgYgFhQE2Kq85gRT9FjgDOdQmL6bvq7wJ73B?=
 =?us-ascii?Q?X2QfeN8VLSHhZcytW/PDUi/+BIMJLF+l26IyoiCR50bd1W+pNQPRRwWAVrcd?=
 =?us-ascii?Q?B8IWH5uhgE+wUKv1ulovrDCh20r7LsSFhP4kPX3NH9epNp0TGYn9s4UvDsRQ?=
 =?us-ascii?Q?XqYFUHMOesAHibXmbL3dpMSPcvrsPeWwXeqwNXeMODtahcOv1pXlmEQY13xU?=
 =?us-ascii?Q?q6cI4TvrpRTLp4vB5vufu5dHMEeJMAd6QCh+HxEaLl3WCIJhSkTtd7jmMz1R?=
 =?us-ascii?Q?w4xTxQ2hZb+z9bt4CQu5ODpbtcU0BqEomhtLEbto8lk7e9wYiYdq+f8E40Pf?=
 =?us-ascii?Q?HuYEX6LDCJ62m0C0oLlL0zRA0EFrETAXDse+G9xJBTcwdzYJfs8RhBQaLNRI?=
 =?us-ascii?Q?0RPJmuzVc45gS0FcKFpISE8wA6ZSVq93YIxcLK7XjqrJE1Ekfu3X2NQTjele?=
 =?us-ascii?Q?N8e4QLc9bXJ0FlPrFWBP0gE7Ytbbh6vE/vqtsxdfwfV6S8OE550TTfwQ83/1?=
 =?us-ascii?Q?BYRaDaWPolNu6o1TCYy9B0Y3ZI75x9u8ZhkKEUU6aWq+kcRzVrcMrduSwtzl?=
 =?us-ascii?Q?Yu5KanlmXaZZVBvZwmR74IxXws1GmGQUzgOSaVzJpxj7qgba3EzDqLCf3mmg?=
 =?us-ascii?Q?s1t1KeNtK/aVpRiAgBiulacYT5rL62kqt82HEZQegqL5hgXQ2GjutFWvFYcS?=
 =?us-ascii?Q?/7fLE0h17UhMOsvLFW4quxOkVvD1/HKLPAKMEdK2HIl4oMNnqW1lOCquA5GD?=
 =?us-ascii?Q?oW42SJNtukQMCwvyC8STxl8hWO3LmQ11G9Q5S7wuOTQ7Hgz15NJpRBBkKETB?=
 =?us-ascii?Q?+WX2tIgGcOkoTqdn2dZGyJuIjaxYBOYpPS3GSPi310JGejclwJ4F981pUNvj?=
 =?us-ascii?Q?dF8neZqR5Co9S5Oj8FkR98BoKbYpUyyHcX50n2qJ/JC3OIBFRy6PsHsImD/3?=
 =?us-ascii?Q?40pCoFVNDXJvWH0MoK5EcgTxbdptf2tDneK8GGCWrDyqDA9pER4pqHvtYoZ7?=
 =?us-ascii?Q?0iib4xIlQn2zHXjDnoFfryaBK4OQ6IvfbwosWtXM483bHWn4JpaClbqkSApo?=
 =?us-ascii?Q?5DrJTaKoAgeC4Woar2OVr8OPjkn6WDz9e6nuUBQskTdZUlVIfTtoMGiSQBGB?=
 =?us-ascii?Q?8rpvc2oeWe/zH3QUCi9WfHID2KsaSYZHpEJe+ygvwBovhdDdcY9KOAm5K7B0?=
 =?us-ascii?Q?NTZi37mZqQL7Uxj/cJ3WK6fmGXBNgg4khkKOhvURYOkgt0f+k61qL6C9jwym?=
 =?us-ascii?Q?miAS57SZsq1bjnjlwkPqm1bo2jWBwus1biNQhTrmqSbTTmTuY9TQduKuxpBY?=
 =?us-ascii?Q?k+HpwcdTThUYVnmEuEEBeGQOdA64TPj+cxc2PWwdFJ8GbxXywvmYqKoNZrOr?=
 =?us-ascii?Q?9XYg26/eOQrBV3rXo+sGwSTSEzLM2Sns?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?stNy36QAQgyaen9NVhAPV4QIWHIXNg9D8M773Ox4blqECNhCEfzOXJhLUOt1?=
 =?us-ascii?Q?RsXnKMU0qt9DpW3smN2+IVRCU34cA9acxBM4Si/7YDMjcQ5eZ2p6+mKygNCg?=
 =?us-ascii?Q?yhvsQJVtxWpaE0KO2uC10U1gWfnCxfRtunBGwWqAQFezo4i2d5Aeb2RlVc1Q?=
 =?us-ascii?Q?U4yhOx9eIV5XtO6kKgoxm0aafTAFAPartAvk1GNPITNLXOP8cyEqiDDGZF0r?=
 =?us-ascii?Q?SCAw5Ulg582rdWOjX5mU6x8ycqx22jzmNeUzoUZjXibpWac3ydHnuxeEM1hu?=
 =?us-ascii?Q?lbsCdOCM8nEtnz3SUQ0zhNTMwbhPewTswV3bWqsQay/N0wEjZKKeX3/D5DZI?=
 =?us-ascii?Q?w1zMUZ54pnZVwqBL3XINFh1D4unIN1tuAjxlh8FvA8nFStHl1aN3gbrjcacS?=
 =?us-ascii?Q?JtjxagFKt/z2Ifiab+BZc8EDkansSDMk5iE6MDb53dsLlbMk1V2syDBIjGnW?=
 =?us-ascii?Q?IAAgwDhK9/bhlRg9EDm3kcWFG8eKDTtqlVp5GBxQ1eUi2KFBiQtOewfABo4D?=
 =?us-ascii?Q?Ho5tk8WstqzGNPRHlW3k+AYYA2SE8/ZUyDLSkKCtOPHqf9UBRVCi4tBL3bqD?=
 =?us-ascii?Q?bA57XwDMJv8hhK1ghT5oLExlqmvBgS9VL/pcl8DgM3yHtLvgNp93AVRe5cDL?=
 =?us-ascii?Q?f1f+jaA/JB6UxwZLldNgvF5DUxMsGwUNyukNYpCsmJX0vifaZz9MRbNI7nQy?=
 =?us-ascii?Q?cI7qHfj6LdqnhYnt7pm6dqh/bmuONSUrfqQrs+bZjVaqnRzTMDuijdqqxZ6W?=
 =?us-ascii?Q?U23MlYp4hXt7xRjllb7t4wKrAudhNsl8Qn+sWTiO6PD8pinpwIeY5ny2d468?=
 =?us-ascii?Q?BvGBniCwcYhVaw/CmnAA2tn0td6ojneQywcY09tu5U4Kx335KF6fSewatvTF?=
 =?us-ascii?Q?cdmWzxNe8sH/FWJ7N7Au4eBd9huG2vMWKAuAxpkQPLU7WW4d9gRDKfpZSGJ9?=
 =?us-ascii?Q?UX/z+vYp7ESs88NfP5o9tmF7r/24GmdSbhG78kBIxkkCY4jDcUd5G0Tcm20D?=
 =?us-ascii?Q?viXiPVovpZfXmfVTqFqHBzbvCAc8Y+56vXFyuFKxeT9Q0qYVlLUy8NjQmZLV?=
 =?us-ascii?Q?2mkK7dHoZPNQOQsE8ZfF3mxYeqzwrAFvnC6/u2De59u265aJS9B6wps0+0vi?=
 =?us-ascii?Q?8o7TcwyZV076wkuTBzcEu4VUmvN2Pw1Gb4vLeowJsq+1LjQbPfD1nbQp+FMq?=
 =?us-ascii?Q?YIO3OagncGgu+g6s4HOdZVu8zAaFbOrIU0xDUJKTSAQrAOMzXQwRjyIR5frM?=
 =?us-ascii?Q?hR5EkcKBzjz5R2IdwbFBUEX9fEGuly0WlUdE6INR+sA/zeRQqqc7pOqlaklI?=
 =?us-ascii?Q?A3lXQAZ6aNGeBQqVaUKNbxa8M7mQUKjDb0uMOo3CEQrOlBdNIfK9F0t/qPw4?=
 =?us-ascii?Q?X24fa6r+cuEh8uehVKCOFjvj7MYitcA8o5gXZxQWiUuO9INm2rLkJOaIFbCJ?=
 =?us-ascii?Q?U78VcVGm3/fnVLqwy3YcNX57avvmn+UfRuWMPdQc2yqdTgXkxl0Fq2B5n+Ly?=
 =?us-ascii?Q?HjzGnI55j8MZ4TKpbmUX4Oo/4NBYFU4QC5gdBWeb7IU4RvY49eIGIlo9Ic0L?=
 =?us-ascii?Q?uzJBZzfg1yVDr3Fu8zmVg0Z+m5sX3KmtPofTWW/gqJON6nWL8i6rB76+9WBR?=
 =?us-ascii?Q?5g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b514b26-3ae9-451a-156a-08dd452b22cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2025 14:49:32.6138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aom5zlpbS78azHrjv4XCacc9G/Iuk0Z2crTdB5k3ePeIdmicERDPhoJzBNV1Zxq2IXnUDVaVlD9iiso/srCof+nodS3mNRNxIfPkYKQEjPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8355
X-OriginatorOrg: intel.com

On Tuesday, February 4, 2025 10:04 PM, Fijalkowski, Maciej <maciej.fijalkow=
ski@intel.com> wrote:
>On Tue, Feb 04, 2025 at 02:14:00PM +0100, Song, Yoong Siang wrote:
>> On Tuesday, February 4, 2025 6:10 PM, Fijalkowski, Maciej<maciej.fijalko=
wski@intel.com> wrote:
>> >On Tue, Feb 04, 2025 at 08:49:07AM +0800, Song Yoong Siang wrote:
>> >
>> >> Enable Launch Time Control (LTC) support for XDP zero copy via XDP Tx
>> >> metadata framework.
>> >>
>> >> This patch has been tested with tools/testing/selftests/bpf/xdp_hw_me=
tadata
>> >> on Intel I225-LM Ethernet controller. Below are the test steps and re=
sult.
>> >>
>> >> Test 1: Send a single packet with the launch time set to 1 s in the f=
uture.
>> >>
>> >> Test steps:
>> >> 1. On the DUT, start the xdp_hw_metadata selftest application:
>> >>    $ sudo ./xdp_hw_metadata enp2s0 -l 1000000000 -L 1
>> >>
>> >> 2. On the Link Partner, send a UDP packet with VLAN priority 1 to por=
t 9091
>> >>    of the DUT.
>> >>
>> >> Result:
>> >> When the launch time is set to 1 s in the future, the delta between t=
he
>> >> launch time and the transmit hardware timestamp is 0.016 us, as shown=
 in
>> >> printout of the xdp_hw_metadata application below.
>> >>   0x562ff5dc8880: rx_desc[4]->addr=3D84110 addr=3D84110 comp_addr=3D8=
4110 EoP
>> >>   rx_hash: 0xE343384 with RSS type:0x1
>> >>   HW RX-time:   1734578015467548904 (sec:1734578015.4675)
>> >>                 delta to User RX-time sec:0.0002 (183.103 usec)
>> >>   XDP RX-time:   1734578015467651698 (sec:1734578015.4677)
>> >>                  delta to User RX-time sec:0.0001 (80.309 usec)
>> >>   No rx_vlan_tci or rx_vlan_proto, err=3D-95
>> >>   0x562ff5dc8880: ping-pong with csum=3D561c (want c7dd)
>> >>                   csum_start=3D34 csum_offset=3D6
>> >>   HW RX-time:   1734578015467548904 (sec:1734578015.4675)
>> >>                 delta to HW Launch-time sec:1.0000 (1000000.000 usec)
>> >>   0x562ff5dc8880: complete tx idx=3D4 addr=3D4018
>> >>   HW Launch-time:   1734578016467548904 (sec:1734578016.4675)
>> >>                     delta to HW TX-complete-time sec:0.0000 (0.016 us=
ec)
>> >>   HW TX-complete-time:   1734578016467548920 (sec:1734578016.4675)
>> >>                          delta to User TX-complete-time sec:0.0000
>> >>                          (32.546 usec)
>> >>   XDP RX-time:   1734578015467651698 (sec:1734578015.4677)
>> >>                  delta to User TX-complete-time sec:0.9999
>> >>                  (999929.768 usec)
>> >>   HW RX-time:   1734578015467548904 (sec:1734578015.4675)
>> >>                 delta to HW TX-complete-time sec:1.0000 (1000000.016 =
usec)
>> >>   0x562ff5dc8880: complete rx idx=3D132 addr=3D84110
>> >>
>> >> Test 2: Send 1000 packets with a 10 ms interval and the launch time s=
et to
>> >>         500 us in the future.
>> >>
>> >> Test steps:
>> >> 1. On the DUT, start the xdp_hw_metadata selftest application:
>> >>    $ sudo chrt -f 99 ./xdp_hw_metadata enp2s0 -l 500000 -L 1 > \
>> >>      /dev/shm/result.log
>> >>
>> >> 2. On the Link Partner, send 1000 UDP packets with a 10 ms interval a=
nd
>> >>    VLAN priority 1 to port 9091 of the DUT.
>> >>
>> >> Result:
>> >> When the launch time is set to 500 us in the future, the average delt=
a
>> >> between the launch time and the transmit hardware timestamp is 0.016 =
us,
>> >> as shown in the analysis of /dev/shm/result.log below. The XDP launch=
 time
>> >> works correctly in sending 1000 packets continuously.
>> >>   Min delta: 0.005 us
>> >>   Avr delta: 0.016 us
>> >>   Max delta: 0.031 us
>> >>   Total packets forwarded: 1000
>> >>
>> >> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
>> >> ---
>> >>  drivers/net/ethernet/intel/igc/igc_main.c | 42 +++++++++++++++++++++=
--
>> >>  1 file changed, 40 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
>> >b/drivers/net/ethernet/intel/igc/igc_main.c
>> >> index c3edd8bcf633..535d340c71c9 100644
>> >> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> >> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> >> @@ -2951,9 +2951,33 @@ static u64 igc_xsk_fill_timestamp(void *_priv)
>> >>  	return *(u64 *)_priv;
>> >>  }
>> >>
>> >> +static void igc_xsk_request_launch_time(u64 launch_time, void *_priv=
)
>> >> +{
>> >> +	struct igc_metadata_request *meta_req =3D _priv;
>> >> +	struct igc_ring *tx_ring =3D meta_req->tx_ring;
>> >> +	__le32 launch_time_offset;
>> >> +	bool insert_empty =3D false;
>> >> +	bool first_flag =3D false;
>> >> +
>> >> +	if (!tx_ring->launchtime_enable)
>> >> +		return;
>> >> +
>> >> +	launch_time_offset =3D igc_tx_launchtime(tx_ring,
>> >> +					       ns_to_ktime(launch_time),
>> >> +					       &first_flag, &insert_empty);
>> >> +	if (insert_empty) {
>> >> +		igc_insert_empty_packet(tx_ring);
>> >> +		meta_req->tx_buffer =3D
>> >> +			&tx_ring->tx_buffer_info[tx_ring->next_to_use];
>> >
>> >in this case I think you currently are leaking the skbs and dma mapping=
s
>> >that igc_init_empty_frame() did. you're going to mix
>> >IGC_TX_BUFFER_TYPE_XSK with IGC_TX_BUFFER_TYPE_SKB and the latter is no=
t
>> >explicitly initialized. Even though IGC_TX_BUFFER_TYPE_SKB happens to b=
e
>> >equal to 0, igc_tx_buffer::type is never cleared in the tx clean desc
>> >routine.
>> >
>>
>> Hi Fijalkowski Maciej,
>>
>> Thanks for your inputs.
>>
>> Yes, you are right, IGC_TX_BUFFER_TYPE_SKB is mixed together with
>> IGC_TX_BUFFER_TYPE_XSK. Regarding the skb and dma map,
>> following code in igc_clean_tx_irq() will free the skb and unmap the dma=
,
>> Do these answer your concern on leaking?
>>
>> igc_main.c:3133:                case IGC_TX_BUFFER_TYPE_SKB:
>> igc_main.c-3134-                        napi_consume_skb(tx_buffer->skb,=
 napi_budget);
>> igc_main.c-3135-                        igc_unmap_tx_buffer(tx_ring->dev=
, tx_buffer);
>> igc_main.c-3136-                        break;
>>
>> Regarding the igc_tx_buffer::type never cleared, I think the
>> important thing is making the igc_tx_buffer::next_to_watch NULL
>> to indicate no remaining packet. Since transmit function will
>> always set the igc_tx_buffer::type to a proper type,
>
>igc_init_tx_empty_descriptor() does not set ::type, that was my point. So
>these empty descs might be treated as IGC_TX_BUFFER_TYPE_XSK, which is
>wrong and your qouted code above will never get called. You will then leak
>skb and dma map plus you will confuse XSK code due to xsk_frames miscount.
>

Now I understand what you mean. Thanks for the explanation. I will add the
missing IGC_TX_BUFFER_TYPE_SKB initialization in igc_init_empty_frame(),
as below.

--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1096,6 +1096,7 @@ static int igc_init_empty_frame(struct igc_ring *ring=
,
                return -ENOMEM;
        }

+       buffer->type =3D IGC_TX_BUFFER_TYPE_SKB;
        buffer->skb =3D skb;
        buffer->protocol =3D 0;
        buffer->bytecount =3D skb->len;

With above, IMHO, we no need to clear igc_tx_buffer::type,
Are you agree?

>> I think it is optional for us to clear it.
>> Is that make sense to you?
>>
>> >> +	}
>> >> +
>> >> +	igc_tx_ctxtdesc(tx_ring, launch_time_offset, first_flag, 0, 0, 0);
>> >> +}
>> >> +
>> >>  const struct xsk_tx_metadata_ops igc_xsk_tx_metadata_ops =3D {
>> >>  	.tmo_request_timestamp		=3D igc_xsk_request_timestamp,
>> >>  	.tmo_fill_timestamp		=3D igc_xsk_fill_timestamp,
>> >> +	.tmo_request_launch_time	=3D igc_xsk_request_launch_time,
>> >>  };
>> >>
>> >>  static void igc_xdp_xmit_zc(struct igc_ring *ring)
>> >> @@ -2976,7 +3000,13 @@ static void igc_xdp_xmit_zc(struct igc_ring *r=
ing)
>> >>  	ntu =3D ring->next_to_use;
>> >>  	budget =3D igc_desc_unused(ring);
>> >>
>> >> -	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget--) {
>> >> +	/* Packets with launch time require one data descriptor and one con=
text
>> >> +	 * descriptor. When the launch time falls into the next Qbv cycle, =
we
>> >> +	 * may need to insert an empty packet, which requires two more
>> >> +	 * descriptors. Therefore, to be safe, we always ensure we have at =
least
>> >> +	 * 4 descriptors available.
>> >> +	 */
>> >> +	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget >=3D 4) {
>> >>  		struct igc_metadata_request meta_req;
>> >>  		struct xsk_tx_metadata *meta =3D NULL;
>> >>  		struct igc_tx_buffer *bi;
>> >> @@ -3000,6 +3030,12 @@ static void igc_xdp_xmit_zc(struct igc_ring *r=
ing)
>> >>  		xsk_tx_metadata_request(meta, &igc_xsk_tx_metadata_ops,
>> >>  					&meta_req);
>> >>
>> >> +		/* xsk_tx_metadata_request() may have updated next_to_use */
>> >> +		ntu =3D ring->next_to_use;
>> >> +
>> >> +		/* xsk_tx_metadata_request() may have updated Tx buffer info */
>> >> +		bi =3D meta_req.tx_buffer;
>> >> +
>> >>  		tx_desc =3D IGC_TX_DESC(ring, ntu);
>> >>  		tx_desc->read.cmd_type_len =3D cpu_to_le32(meta_req.cmd_type);
>> >>  		tx_desc->read.olinfo_status =3D cpu_to_le32(olinfo_status);
>> >> @@ -3017,9 +3053,11 @@ static void igc_xdp_xmit_zc(struct igc_ring *r=
ing)
>> >>  		ntu++;
>> >>  		if (ntu =3D=3D ring->count)
>> >>  			ntu =3D 0;
>> >> +
>> >> +		ring->next_to_use =3D ntu;
>> >> +		budget =3D igc_desc_unused(ring);
>> >
>> >why count the remaining space in loop? couldn't you decrement it
>> >accordingly to the count of descriptors you have produced? writing ntu
>> >back and forth between local var and ring struct performance-wise does =
not
>> >look fine.
>> >
>>
>> Yes, I can check the number of used descriptor in xsk_tx_metadata_reques=
t()
>> by introducing a new field named used_desc in struct igc_metadata_reques=
t,
>> and then decreases the budget with it.
>>
>> Do this way looked good to you?
>
>Yes this makes sense to me, thanks!
>

Thanks, I will rework and submit next version.

>>
>> Thanks & Regards
>> Siang
>>
>> >>  	}
>> >>
>> >> -	ring->next_to_use =3D ntu;
>> >>  	if (tx_desc) {
>> >>  		igc_flush_tx_descriptors(ring);
>> >>  		xsk_tx_release(pool);
>> >> --
>> >> 2.34.1
>> >>

Thanks & Regards
Siang


