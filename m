Return-Path: <linux-kselftest+bounces-31482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 721ACA99FBE
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 05:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6206D1945F3B
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 03:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A6417A2FF;
	Thu, 24 Apr 2025 03:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ag6xDmUJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95364C96;
	Thu, 24 Apr 2025 03:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745466965; cv=fail; b=O8EHz4OjFx/scThpO7NUxj2RCKbHbWa7vBO1z5BsxzpDcZva4Mq+2zTJierCNjRXyyeTJky5RA/1xChCJ1rMDO8cwtDDNjZ4e/3fHYgQw3k+uE1bHk4Icam6vVTzPA6boPyzDu6ekgkn9KzhKKo0/vSw7ODsT/2B5LrdsLDHmp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745466965; c=relaxed/simple;
	bh=a7hLfy55HOF+jsnOv3mAmNQKaVAWEDzACfSAGS7RY2k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jjdNsS80nX8bXIXnjz9RL0Z09YmFix6DjJnmIKMOO84sZ9ibEl2xP+1duBbZNrSbndIoEp0dHExvH3fAgx3VRpV3wx2iWEXoq0JyzDUfrYTox4IXT9O9ZeAj/JwsfTT0WYTdDG0QLjISJ1X0bv/JSsVjqr4tZdZnDZNl2ynNG+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ag6xDmUJ; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745466963; x=1777002963;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=a7hLfy55HOF+jsnOv3mAmNQKaVAWEDzACfSAGS7RY2k=;
  b=ag6xDmUJO3IqEsJKZx4rmNxQyH545vqFt4pSotGwZv+r+9Yj9ZvyK2A4
   AsCoMQs+x/PfR4Dhlhw20gH6N3LFAj66qME71Up5Sps5E35rZWvEimaZi
   HIuNPsiqE8SnDWTLbLGjXPBPf28gIhAC2Mk0VsL1GguC5ud72ZtGc0xl7
   S2JxmyyXs5g7sGEKIzHuwU7toMWsFwKsa3/TYEEhl+IUy4Qwv6NpSNomN
   Ukhy03ZLfG46ZLBV9HC2CHiH4ZuCMQCHt/5JugFNalmziqh0Zi1XXEgdD
   J9WChKF+PZZ190XzsxrsWsJPUHzuXVXoBxwqG+MDBW3qLQl8rjjYDlPbp
   w==;
X-CSE-ConnectionGUID: qVMcPgDUQV+naUuHDITxiw==
X-CSE-MsgGUID: zz7Q2x/XQ2WL//nkl1IAMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="47098476"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="47098476"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 20:56:02 -0700
X-CSE-ConnectionGUID: YlBc3xaTTISAR+Rtky1xtw==
X-CSE-MsgGUID: 9st81Pf2QCW99mXwlm0/bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="132475322"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 20:56:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 20:56:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 23 Apr 2025 20:56:00 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 20:55:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8C+zqI4QPbVbVBpOiE4/88MTtp0ljeXFTYU4xrfUN1GbidHLcaHsaYD8TyDoHYAYmxPihYKn9dJwdyEJ9KlLfz/D3gYz7C7FsuxuhWFRDrouRieQwRNaoZLkuL4eN3oRLe7VFcb0fuJzFjl73sGiNoaNFIMF2m258S8K5X7iMh7aLJbIbsUlHg5oaK7q5GvCQVhIVWdVRkYU2V2XaJp+vjpgOW7xSrHxZKOvN5ehb5fheqD3kx/ZCOINV9hsyFPCmW4sbq26DIapg0kAejoHuY0DtSmpNOlExfdjJHbm0i4BIs+YwcPuwOS1GbQ5tb7jOFkh9R+yaaz/EKLY+Q2AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/koFAUM+YZx1s1MYJ9nYu607ffUgjGviKpu4fUOKW0w=;
 b=riGkbQ2/igazBngo9kkimuJXKjO1ICDy04ZrAorRiLPXpyOGnAPXvIOy+msZPvHIvf1fugloJBt2xMWJ2VzK7LbuiPt+486/4Y2JfcftO+Ao8zNbKp3Lb5a7fBkaUtvUiRhBdqb29G7LYf3+ZnlX2JfZ8DxCFxLUu/imjE0g9UpR11b1w8xhrDujMugNLpLB1LDBFJktLAaGbXFgLNdVV5jZEMKj/JN6Y+qzPFEHPLVh2HLXejij+nx2M9V3wlhyJN+PuokzQPZasRyOVHB3sIrhF4SoD77imc/cLDoJGkB+XEDgXjEDLokNgKn37/Ydn2Kj6SsB3NUGu2bs8eM5Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 DS0PR11MB7802.namprd11.prod.outlook.com (2603:10b6:8:de::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.35; Thu, 24 Apr 2025 03:55:30 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 03:55:30 +0000
Date: Thu, 24 Apr 2025 11:53:30 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Ackerley Tng <ackerleytng@google.com>
CC: <tabba@google.com>, <quic_eberman@quicinc.com>, <roypat@amazon.co.uk>,
	<jgg@nvidia.com>, <peterx@redhat.com>, <david@redhat.com>,
	<rientjes@google.com>, <fvdl@google.com>, <jthoughton@google.com>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <zhiquan1.li@intel.com>,
	<fan.du@intel.com>, <jun.miao@intel.com>, <isaku.yamahata@intel.com>,
	<muchun.song@linux.dev>, <mike.kravetz@oracle.com>, <erdemaktas@google.com>,
	<vannapurve@google.com>, <qperret@google.com>, <jhubbard@nvidia.com>,
	<willy@infradead.org>, <shuah@kernel.org>, <brauner@kernel.org>,
	<bfoster@redhat.com>, <kent.overstreet@linux.dev>, <pvorel@suse.cz>,
	<rppt@kernel.org>, <richard.weiyang@gmail.com>, <anup@brainfault.org>,
	<haibo1.xu@intel.com>, <ajones@ventanamicro.com>, <vkuznets@redhat.com>,
	<maciej.wieczor-retman@intel.com>, <pgonda@google.com>,
	<oliver.upton@linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-fsdevel@kvack.org>
Subject: Re: [RFC PATCH 13/39] KVM: guest_memfd: Make guest mem use guest mem
 inodes instead of anonymous inodes
Message-ID: <aAm1utyxYWAowbPD@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <cover.1726009989.git.ackerleytng@google.com>
 <d1940d466fc69472c8b6dda95df2e0522b2d8744.1726009989.git.ackerleytng@google.com>
 <Z+y2nU7KDmRpuISM@yzhao56-desk.sh.intel.com>
 <diqzselyzl07.fsf@ackerleytng-ctop.c.googlers.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <diqzselyzl07.fsf@ackerleytng-ctop.c.googlers.com>
X-ClientProxiedBy: SG2PR06CA0191.apcprd06.prod.outlook.com (2603:1096:4:1::23)
 To DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|DS0PR11MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: 90ca9ad7-a528-4f8c-4083-08dd82e3db2d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sxqYiA208PC3XhKBEm+ZnyCRcL/abE3ak4YWXKBWNHhqlGPGsYrOREN772vc?=
 =?us-ascii?Q?KiKVMLMRw2cbpp+b7XYzkWf3Dj6A85GCmyPzeFrAtaguV5gCHKHqa/V5BWIW?=
 =?us-ascii?Q?gq1g4s36K77gkZSGYZrMljNm5xMeFihqEBO1f9YastFinPtvkObilMjSZyZU?=
 =?us-ascii?Q?yHOaZZodHgbnG9N6ea5eZ2yveaLSm7VDdGKv2dVNz0pFcKNxS3nxQTcguOy8?=
 =?us-ascii?Q?KbhfelOWkkOvrBMkbdC4u8EdzoX3grrF89eQp4qCUyflOBvlFQfc3Aw/QM2b?=
 =?us-ascii?Q?MuPG4KLStikgeAoyD1bJ3Fy9ad2POLDzocV+xFMU5itoOnKN3/5dSud4YPd0?=
 =?us-ascii?Q?gQgj6XVK0rlT/N0OXmeGt6k+nXxxF8g8CMvcpXvRFJ9DWniPGMrjQ0gcibgG?=
 =?us-ascii?Q?lpY0Dang+tiBfNcuchtywRS3cCfWyp1D3epVZyAZaZDH7ewZxAqxrAV1kDq0?=
 =?us-ascii?Q?z+QtGwLFO9EBKtmq2DvyIm8KxoPqzSZQJ37BykD/t/YxGiwx35o1Xmd8xx0A?=
 =?us-ascii?Q?rCr2qhH0udZamv2IozohXWguiK6uyNXthwszl3wWzI4TuM8Cl41gUhTC0mdu?=
 =?us-ascii?Q?r0szpMbfgEGBqSzUZYTKm3Th38tkiR/hz5UAkHcsUUuDJTmEJvn6y6qE9bJv?=
 =?us-ascii?Q?0fqWHz/R2O1lhvkUqqCHmoivMK9g2Taw1P4h/nXdrsd5Kp5X1Dx+DJdJx9/o?=
 =?us-ascii?Q?ft7Z2l6HGCJZ6c1eRB4fiTayt3dLtZOTkw3Zq2pV6U9vnv1kFNDedxbafOQF?=
 =?us-ascii?Q?dCAXBt4QW2CegQT9iNA5kpR+CpAgiHBSydqZ5VtuMwv7M3acVSy6uppoEjNy?=
 =?us-ascii?Q?94HlxZa42ICyL/JuGXGkhEXkeuVnKnyMKFCh00/5UlhW2tMb52SgBX+VPKg5?=
 =?us-ascii?Q?cp4H6ySzwB72vLXkN/NZNT1QrQ/DJe3KUMC2DE+q+2fnpsvSY7BB2baW65pO?=
 =?us-ascii?Q?m1Z+Zr4b76/EpFVYOmP6ZCkJz9VuZEgK/B2WEsXdFQkZ6DUFhZk6Ef72wL4k?=
 =?us-ascii?Q?aHzywpXAV6xfLv1XjOr0Yy9M3E2hwdr5T1n0nKOvCBtjfgtundcv4SrzvJvs?=
 =?us-ascii?Q?sDkYrbuKJRfMq6GN1256AeFk1mOddurEBR6jErgB6z2henBDANkZYzSNOK27?=
 =?us-ascii?Q?s+K10brQDamUrzUr4XJ6XQ7oR24dgUPRupvKkMX2oAh/l4HOjj1mAROuk5ra?=
 =?us-ascii?Q?hSJ8HG3ZXLFw5KLLerJ2mblkAz00KMmqrnIx6pufNICcwVcf4R78Su3N6kHv?=
 =?us-ascii?Q?+b5GTZjFJ3a0giQzfBC4SN2R/am9ABegGjEmw618DtilzX0pXVK79GRzQNJr?=
 =?us-ascii?Q?R2BvPfDJ4H+t53sjoP2a5k+Wdv5wWRB402fOnmLXKT5+bA9/Kx+tXKF0GxWv?=
 =?us-ascii?Q?GmUZBRehd8jxWm6JHzzlgHZ7aeBfevZm6liVZ1D8hwM5BQlOsQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?27JRMMW6ZOuBpZwVBzKsIUiZh4t/ZAZ66eMdSpSLvYpnh2W1Xo/e+9N9vIkR?=
 =?us-ascii?Q?FUfiIvN0SZ5zK0rtTYthpZW69f4vzacAuv0xkMqmes7buUF1kVqKc2F6ctAh?=
 =?us-ascii?Q?l99nc/7tqiskdzdytK3Nk8YNoZpeEndqwb7zdZRPJOMBpoCyPCB34osh4X81?=
 =?us-ascii?Q?yo0Ti/b3jP3ghpc3TcBUIQktTefwwoYD7tI8cjxZxRYX6EA6CeaHZ8Z3Loez?=
 =?us-ascii?Q?WJoDdD0iqNtARbWAiqk1680F1JKvoNmAuG5dPkcS5f7fATrNhShUImF2RVOX?=
 =?us-ascii?Q?YCReguZPfBN74tfk3xYnotuPylHDaNCgDNqVsE+YL03KmmWKlLk0MGJm2gDp?=
 =?us-ascii?Q?GYyAd/OK3MavKzyWqoE6JUB0+wfr9+NApJ477nR62j8AfOtQGxA7z5SKAaf5?=
 =?us-ascii?Q?ZResfUCsPTnOODEEH0qn8+XPG/4UOGJmJDFgakeeDV5t2ESt9PAGQGNHBFm0?=
 =?us-ascii?Q?PD/YYxM7esLDxiDHhekMhsGh1Y+4q3BFSZVmlq9uwroCYFTQzNZktz1BmYbK?=
 =?us-ascii?Q?H2EDVIJor7Upl+eLP3KLaEj9kawZwDgHtmUzYgFpOAaN8lWdEJ6RBQnOjK/u?=
 =?us-ascii?Q?0nWouGDsthKW3CUU5YMaZ7nG+MiAt8D0HzmKVXXfHTdoue77jKZPZbWXl7cO?=
 =?us-ascii?Q?Oz5iMhav8QxQZNVKv1mc252ofOQsODxOsVKpepmfFMA8nlC39fdURpZqhqgw?=
 =?us-ascii?Q?E+iJod1Goy9xghOf5Yecf7ox6BPwj5VH50l3Dg3/p3EvQrerprcUEG2WD0kn?=
 =?us-ascii?Q?WeW9cEUk7t9HF1RtlgfStUarqyYhn3/WkG3CYcY503NW3dpcaDFfc5Ft3uzn?=
 =?us-ascii?Q?nyFp4XmB/FLkpecGg0611bAoIXQTGSdYiMrcMrTUKZMvOpCrCSHJJfL2EPzW?=
 =?us-ascii?Q?KOQ7VAtAYxHDfOucVeuCEZ3rMBGHXztaKYP7A8vd3Kn6G0nJvkEZqBYNhKp2?=
 =?us-ascii?Q?SsDMJo6YgCZrlRtBzUUBkE37SVRUL+Tc36nlnPaxtnwjjFkWrm+nWXsIZlEH?=
 =?us-ascii?Q?UsF8L5rxnA33wakMWcDr6dITMEVGJkj41lCO0KQwA4Q40KYgOgoUi6gxznSl?=
 =?us-ascii?Q?MVRu0nmE4QS9MBn/bOMoLHb7v7LAOIXmNoGeibfQxoARbLnCdj7Tu9xStbpW?=
 =?us-ascii?Q?CvJg4/zEMZna605TlgNV3N+/Hlw2pnRqidVOsi7y9j9VtvlqJHYSLkg7Zkbp?=
 =?us-ascii?Q?iZOmfuAsKEiDNnSz188AJn2ypzdNPWBCe0zSRaWJa/p7uLuq+cFxjoyP35N7?=
 =?us-ascii?Q?HhNtINwuoTHFQN06axgalme+z+i58oiUAPqv7EHu7K/frBOOBeTtvM+ENaqk?=
 =?us-ascii?Q?z9zKzWap/cUsp24yv/l8k2hRgcBDJCbooLb0Zmk1tqa2Snfg0pIFIiHKrWPf?=
 =?us-ascii?Q?ttLRxTAC9cSyHURqDqzFK2UJRbtJL+WcJByLn5YQYbptndndc3j8/amc93vj?=
 =?us-ascii?Q?s5ag7jKsp9xn1d26Gcw+s3fs6JfOLUYjGIAZOuYBWmppJeRcjAivpfEFpkBT?=
 =?us-ascii?Q?gx9OAZtgBLyKnax9K4RaZSj1G3SgdHyQ1jA52h7PqwlvX7FF5QBI0F6a+FB6?=
 =?us-ascii?Q?AvxKzyjVdC7aAZ2V9ZTyA27mtbtNepGCw234bC4P?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ca9ad7-a528-4f8c-4083-08dd82e3db2d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 03:55:30.4820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ehkl+mNB+Ge0YZ4OdIruZTqaxVQ9Hnt9+QNyGzwT5gGHoa+L0B10tEW+1thqNYp0vRpTsmRELlrOPhId5lmm5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7802
X-OriginatorOrg: intel.com

On Wed, Apr 23, 2025 at 01:22:00PM -0700, Ackerley Tng wrote:
> Yan Zhao <yan.y.zhao@intel.com> writes:
> 
> > Hi Ackerley,
> >
> > Not sure if below nits have been resolved in your latest code.
> > I came across them and felt it's better to report them anyway.
> >
> > Apologies for any redundancy if you've already addressed them.
> 
> No worries, thank you so much for your reviews!
> 
> >
> > On Tue, Sep 10, 2024 at 11:43:44PM +0000, Ackerley Tng wrote:
> >> +static void kvm_gmem_init_mount(void)                                         
> >> +{                                                                             
> >> +     kvm_gmem_mnt = kern_mount(&kvm_gmem_fs);                                 
> >> +     BUG_ON(IS_ERR(kvm_gmem_mnt));                                            
> >> +                                                                              
> >> +     /* For giggles. Userspace can never map this anyways. */                 
> >> +     kvm_gmem_mnt->mnt_flags |= MNT_NOEXEC;                                   
> >> +}                                                                             
> >> +                                                                              
> >>  static struct file_operations kvm_gmem_fops = {                               
> >>       .open           = generic_file_open,                                     
> >>       .release        = kvm_gmem_release,                                      
> >> @@ -311,6 +348,8 @@ static struct file_operations kvm_gmem_fops = {            
> >>  void kvm_gmem_init(struct module *module)                                     
> >>  {                                                                             
> >>       kvm_gmem_fops.owner = module;                                            
> >> +                                                                              
> >> +     kvm_gmem_init_mount();                                                   
> >>  } 
> > When KVM is compiled as a module, looks "kern_unmount(kvm_gmem_mnt)" is
> > missing in the kvm_exit() path.
> >
> > This may lead to kernel oops when executing "sync" after KVM is unloaded or
> > reloaded.
> >
> 
> Thanks, Fuad will be addressing this in a revision of [1].
> 
> > BTW, there're lots of symbols not exported under mm.
> >
> 
> Thanks again, is there a good way to do a build test for symbols not
> being exported?  What CONFIG flags do you use?
I compiled kvm.ko and kvm-intel.ko as modules.

CONFIG_KVM=m
CONFIG_KVM_INTEL=m
CONFIG_KVM_INTEL_TDX=y

 

