Return-Path: <linux-kselftest+bounces-44302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E04A7C1C575
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 18:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC9E86E6589
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 15:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E663446C9;
	Wed, 29 Oct 2025 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mdErMgb7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9EC33F39E;
	Wed, 29 Oct 2025 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752674; cv=fail; b=resJNuinRk7o2ICXvK9E0PNqMfB7E6wgi930iGPN196P/v+Yyg8XxP668rXoXs90cyD0IZL4BiErZGoAhBe2Vy0xenOhB0m/yVLX0dqquItkaIIbAl9/tV9A+qNZLtAuWbqtp1Uc1vtSg72odq4HYQ2tcRe8v4/3k6wttdpBNdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752674; c=relaxed/simple;
	bh=DahHyupwEU392E4DqVbm66ZAON34CBdPKlUwQY76AP4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gM2lMQgMytkjaQntXAyzhl/vrTkFE6zcCOUvrKBrRohO7F4R/Ex18g5hS+RWmDSUZk10+2nvY2P+gpLvDhRqrY2qZSq8NyDFxu157SKawgGt+8fzAN1i22YO5oakKVjrqV6+YZqW0X8T/vOtfxwTBvbvJcO07JIkdt52LEVqNXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mdErMgb7; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761752673; x=1793288673;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DahHyupwEU392E4DqVbm66ZAON34CBdPKlUwQY76AP4=;
  b=mdErMgb7qlxXfKJcqHRdNioizxKLNj04JIkNtcnRDmewXr8QIbd56zNb
   zQpmD9MCwEL7U6KEZUIqgooGh6zOe/zXvMpn21MpX26iRi1l2HWp7Lz8A
   7nh+IgyZ4d6MwNcB6HDAMipmkBxn0M+eSJCHrL+YqkQbX1jzqg8//Qqai
   1SkgYmwSJnRBWDq7HTqIVwiEqJ3rtpsvBenymcvF6v5wf2DpNV4msh9qb
   dPJmDJ1oGQGNCejmcdIJfZCoVEZ1zMAaHzd3SmrwZsUC2PhLgHXfpDSBI
   VYY2AGuDau9DvG2JNQ2tVLz6ifpDvXEAOepELqgaOlqQVy6Q9K5LpMX7r
   g==;
X-CSE-ConnectionGUID: BK019xvkSly71SbRQW/5Qg==
X-CSE-MsgGUID: u70AsA6zThWBl6Nw3JFDTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="63085143"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="63085143"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 08:44:33 -0700
X-CSE-ConnectionGUID: RPPpi6dXSxiLeWPeq7olxg==
X-CSE-MsgGUID: 3/i3f2kDT4ahtpKlJ+r7Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="185397401"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 08:44:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 08:44:31 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 08:44:31 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.58) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 08:44:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQBjWZ0K9o0tjs4ywm5kPpplYTRNeCOTn4ocI99lhJiMT7iSn+IeRE4feejOTh9CjMpKbWG5J3/Kp+BEsfW2cId/aTyVgKtJx0iL3iqoAvqRBasJk3Yb97cAH7kxdhBZfIoqXaiMRIOfUWa2xbI0DrXJm2GgYwo6idQOotsk4gW9iJDfsZV3Ab4LYkzOzJnwpTXiYceGMTgUwdZgGoKAueqUMZkbNQapQyyzhGOBf2KQKSlmJrMZfyyK1M4jZcwRYI8LUHXa5cW6wgD7P10fWTYcbCT2DjAemQd8Qz3tKAowgRxOs2SanidTYcitl8ss0Qh8I55n9L7fNGt64/HFUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iQGbGt/nB7wwdj2Prlm4YIWiBMHfJY4EBeZSYhYEnw=;
 b=Hd+5Cf28KNuZNM6GprGLJZSSo6buNgtDMQSsIeuyvBj7VEsSuJ1lNesy54XK1NFW3ZUzw/De/thHcye2dntIxJwVkg7RfBUMsrJo+dfnEk8PcHQcsEdDUgbNl0XZNg7hYErqe5Ts1s8L/dXAYL2bt39tBuyjy4HPk00eW6DzmhWC4Gsltw4Gg3ouoJcZY+MsRJvVcOUGbYQ9mil1l2sD7vW1YhRyaLecBjfaiX8QOo7jMu6aeslHWFpU4x1wL7xJqM5MpwgNnbiRMrhouaPTCSe+FBPmv0CYeHBCuHL0rJR5Kd6OrtfFxjAUKlAhQlYtiRskV1siF8QTDoK5TcU08g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by BN9PR11MB5275.namprd11.prod.outlook.com
 (2603:10b6:408:134::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 15:44:29 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c%8]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 15:44:28 +0000
Date: Wed, 29 Oct 2025 10:46:49 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>, Sagi Shahar <sagis@google.com>
CC: <linux-kselftest@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>,
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>,
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata
	<isaku.yamahata@intel.com>, Erdem Aktas <erdemaktas@google.com>, "Rick
 Edgecombe" <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>,
	Oliver Upton <oliver.upton@linux.dev>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, Chenyi Qiang
	<chenyi.qiang@intel.com>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>
Subject: Re: [PATCH v12 07/23] KVM: selftests: Add kbuild definitons
Message-ID: <690236e95d6f7_20bb41100aa@iweiny-mobl.notmuch>
References: <20251028212052.200523-1-sagis@google.com>
 <20251028212052.200523-8-sagis@google.com>
 <4a8c783a-e930-44ca-9222-ce6d8ce26463@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4a8c783a-e930-44ca-9222-ce6d8ce26463@linux.intel.com>
X-ClientProxiedBy: SJ0PR13CA0143.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::28) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|BN9PR11MB5275:EE_
X-MS-Office365-Filtering-Correlation-Id: bd6367cb-886e-46f4-2d30-08de17020b60
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BvPBKsOYP5uW3sPNecoAyj745+KFjWuWpEuqM4TusV4WFiLg3tJ9tSkfe6a8?=
 =?us-ascii?Q?JyNdc0cr5LuDt1zYSN4db97/pUX2L8eukq3xHcOLylrNV/hqPHi8C9NrAeHC?=
 =?us-ascii?Q?3BNgXMuW1fkYPKIek00WTZzSbfr13WlBkdtXql4FnTPj4SlzozRtufOxBcep?=
 =?us-ascii?Q?ZQ0Pxg+j0f1u8lT52xfDnzFkYda5P3ipxO2vsJFEBPx5LoPPODQOrVC9oT9e?=
 =?us-ascii?Q?VIwhOkJoL2sKlDjdetKUVR6WVPiLFciwkTln18NJnPuEiRGyiTDRUgci6JXs?=
 =?us-ascii?Q?uXD8qiVVJJsONSwRFlzMEoFR/YnustI7PKBnKEj3pVSgUvzLEkODLazn3Azv?=
 =?us-ascii?Q?gvGI1hrnBANaIWwExponoRy96TpAEQFQYhP/o2HXLv7aGFe7JBjRCux/JPRB?=
 =?us-ascii?Q?Kbz0a5lB9U0crHuPqJMsYP5OY3DBgOTHY9dz+6h4BkIwjyPuTKsC2unfx8eq?=
 =?us-ascii?Q?eYm1/aS9yJTSpiZNRRqWySku7an4mvQEVKvDqCNWfJgWc0WXY3bbJgzgko+f?=
 =?us-ascii?Q?CmG9DeGftpf6BOwjZq4ZYyMBSL45ZjM1MQf5HoIRrw+K6nNdMl0HS6nz11WI?=
 =?us-ascii?Q?qVpH03KXqSwnGJKI/9a7h49GRD2SmqejDxjJmK1KoY4CFvgF05VbGStDIMZ8?=
 =?us-ascii?Q?le6kkrxpRgLVmGWXox9UKhI0mynEXRalW8aOVdNhMXjARBba2EsE5omxHGkW?=
 =?us-ascii?Q?VsNb82iFxIrdmqou8b4nLI4QVLX7G02Y3UNL+A6MxtJTmeBuXQjeWBMeGdt+?=
 =?us-ascii?Q?espiIC06Dc047OvzvmLTpFiWy1HFQRSjCG3sFAyVRGfqlgrLxB37SgGJy/p1?=
 =?us-ascii?Q?NWvJIIkl09gzn4WCmLPz+yntExS3J3uSpocEMGt8k2Un42QA44HeAPr7Vi10?=
 =?us-ascii?Q?pq9omFEr4nNCqe/bPUzzi75Z6J1qA55VwQEjnk4QqmQKNcse/4ml75u5UfNC?=
 =?us-ascii?Q?gH07b3VTVkTHKGIlWt/n3qgQP2zYuWke/tTzVYbkMkBq4pWVBrWWBMO5mBUe?=
 =?us-ascii?Q?VStXYn0stRYF5vPhAv0c0+3d2GzhpD6UFL+j9pFeNmakRZsX/I4NyNeLwLrz?=
 =?us-ascii?Q?CIuNSXkwmqWKaB1YTjLM+SjfkRAxlpTLMmwtePm2X4cU86bOk3g7kUDPNboL?=
 =?us-ascii?Q?6lnhZpcuV5KtDsWJkjAloyON5fLKXyV0JYtYGureD1DNQFcGRN5PrFhNZ+mh?=
 =?us-ascii?Q?/7F7t+wqllSjXJ41LAsSxRvnRIqp6YNA02c0iKzkLWTqTzBmIgG5eUc2HWb3?=
 =?us-ascii?Q?8nL3gSOIIyX/WRn+SGPQX5ZZ4s1gXMeS/3w6YHCLnONAEbry68vWIi98u9ZB?=
 =?us-ascii?Q?ljNJJJMqzrV4oFex8iRnj7gB6i2EIYetCpR7b/B9WnDwyrcb7I1DVC+MCMQQ?=
 =?us-ascii?Q?lHHl4y1emPXQO1215IBSpQqABWI+N6E1eH6ou+AsYh1M1B8uSj6+BgOf78hG?=
 =?us-ascii?Q?VltYGERtoz8+ceijqGMDkqN79Ql6IuFY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nVHp8NfBOZ3wnav5RyPhiuqxka+6jP22EpVkXHaVfqhBKGU9UDQCLT/1VQlz?=
 =?us-ascii?Q?whYzGEf0yKEqNr+h1lbMICDfMu4zw4AeAK62c0RekkZ4uHyUCVkAE4DCpjfT?=
 =?us-ascii?Q?6JmAzdemaXa+0cr2zhCDq6U/SlbbvJEDbTJdG0VY0s65aUst8lfRdrjmABkN?=
 =?us-ascii?Q?pGLnIJBSLKQ0V2igLm2vOIsums+BDcGSibC8rQei61xjVqHd9FE76vYgnUeI?=
 =?us-ascii?Q?BszIs/qecJNtGsm0OX3MB6hRiPc+FRwFY/sBe4scrL6J5p3ftY4hX4VX+csC?=
 =?us-ascii?Q?7Q2UjAjxJpPRcy3pllIdtOeJ/N7U/kUnDdZLpgKUBs6Ng9lWenhrlqT0oeHq?=
 =?us-ascii?Q?P7ZFi5EJCJrdgIdBmfzAAxGuz+5w5O2bW14iwdVsRwMFLSSgARjdD6SNa/PF?=
 =?us-ascii?Q?vmaujp4f3APc87dDBw3wo5AHGLEFkyLVTO43xNFeKSGygz6z6NdSe99fDA3E?=
 =?us-ascii?Q?bFahKv0osYsbFsV0LquNoCd0LaroLr8281Jzc0QGpn3IsyqCXPiIU0/M0zCR?=
 =?us-ascii?Q?3OpnblPreLHelrs1ZFjYoLYutF6W67MNiqq/isfwX7OewGeSmAKSsJxAK3bd?=
 =?us-ascii?Q?7Qo2aH4wXHuD+hsBiYC6JkdjmlAr3VOsHTdyNpe1lRpOs3pvl3vWPLhh7JWY?=
 =?us-ascii?Q?5nAFsIvKH2njDIM/uAGSbJvMclJyB6qrOQfoOQ8OuNnyB1vkKQhH/Pc+jn6e?=
 =?us-ascii?Q?RG9DZ95tWLPr2HjzgtNTR7L9fPGB8jRsXkzRSVEUp3ut3qR57s64N5Jxb3/K?=
 =?us-ascii?Q?Ioi7pEr2ptAbah91oxDXvisHP3zWJ6T9aZqHdcbBoBkEZ0FwKKx2ezUA5KT4?=
 =?us-ascii?Q?QnIuSkwj+oBjoz91rInwvflPxrZyMA0UCO3IzfNvveU4JDRZdYjAqp9vaGh3?=
 =?us-ascii?Q?1fK681YxLaV/t3SvCTbBPOGveomfb9o+LRyLRw3YhOgrrjM9n1de8uODVLbU?=
 =?us-ascii?Q?+i5CXIcOkNiMwucryNoMQFlRLC2TxeeVohy4vPcaT5K8y55mIVk4AJX9yPV2?=
 =?us-ascii?Q?rwLEWPLTj5nij37G7BdOpTTPuaQKMTtVXodbdXPjIL2LfSQ1AhaOm6G91GF3?=
 =?us-ascii?Q?SovRAc+X5DVI4/P0ib74PG92Z/FyxX6MvnIyuZHXlZUTDQzUcDv58fbGCw6a?=
 =?us-ascii?Q?XA0vlmhHT83xRZVUgc+JsW7K6EPhO3xHswSXG0+Wld97IGSdZMA5cH2zlMR8?=
 =?us-ascii?Q?kGBYBM46gmmfgZscA9xuSzpaFcstS+JJO+1mYW5wgvtclA8rMF2qXgrba8KG?=
 =?us-ascii?Q?LMG1xtoMcST2aTwbCqPp+wBACf6N3dyYbCDx+S8tLP/G+cC4k8cHq+HRkOTI?=
 =?us-ascii?Q?fVl8+7n8reU5Nai26awmhWH/IM22pyyYr7Uc8aSKfoQMKq6MTKQ99ZyxE6ie?=
 =?us-ascii?Q?j5r++TaHdEcCISOKMorPpbZ2NHUcnjINImbrsDQoDc0vU4GDGMM/29tAilZq?=
 =?us-ascii?Q?4Av+hVPjT3QpsbgHDFiUJtkttDl8a51QiV6VBiIrcaZXN5HKihz76zMQ40ur?=
 =?us-ascii?Q?K7fbETmd/j33qvlN/eWMISyYc9d5lQKuqhF/v41yrolnwuTo1We7JWN1DvIJ?=
 =?us-ascii?Q?mozo6+LH1JTQvcLQ05LUj8xAet2HcwcnTF6E8DMx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6367cb-886e-46f4-2d30-08de17020b60
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 15:44:28.3040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgLlKZcYuYtmRAG9rBRSyn4pcUUAyri4jQBanr6nc9UuIK4parhOOJFvd628+bXEUUaDuMBj25p5mtGUmq85kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5275
X-OriginatorOrg: intel.com

Binbin Wu wrote:
> 
> 
> On 10/29/2025 5:20 AM, Sagi Shahar wrote:
> > Add kbuild.h that can be used by files under tools/
> >
> > Definitions are taken from the original definitions at
> > include/linux/kbuild.h
> >
> > This is needed to expose values from c code to assembly code.
> >
> > Signed-off-by: Sagi Shahar <sagis@google.com>
> > ---
> >   tools/include/linux/kbuild.h | 18 ++++++++++++++++++
> >   1 file changed, 18 insertions(+)
> >   create mode 100644 tools/include/linux/kbuild.h
> >
> > diff --git a/tools/include/linux/kbuild.h b/tools/include/linux/kbuild.h
> > new file mode 100644
> > index 000000000000..62e20ba9380e
> > --- /dev/null
> > +++ b/tools/include/linux/kbuild.h
> > @@ -0,0 +1,18 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __TOOLS_LINUX_KBUILD_H
> > +#define __TOOLS_LINUX_KBUILD_H
> > +
> > +#include <stddef.h>
> 
> This is not in kernel's version.
> Instead, consumers of kbuild.h include the necessary header.
> 
> Maybe it can follow kernel's style?

Is there a need to not include what is needed?  Generally that is a good
idea unless the header file dependencies cause some build slowdowns.  I
don't think that is the case here.

Ira

> 
> > +
> > +#define DEFINE(sym, val) \
> > +	asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
> > +
> > +#define BLANK() asm volatile("\n.ascii \"->\"" : : )
> > +
> > +#define OFFSET(sym, str, mem) \
> > +	DEFINE(sym, offsetof(struct str, mem))
> > +
> > +#define COMMENT(x) \
> > +	asm volatile("\n.ascii \"->#" x "\"")
> > +
> > +#endif /* __TOOLS_LINUX_KBUILD_H */
> 



