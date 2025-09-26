Return-Path: <linux-kselftest+bounces-42466-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0257BA3B8C
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 14:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 583C516F5AB
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 12:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D583D2E7BA0;
	Fri, 26 Sep 2025 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dC4Gw1ni"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCBE1EEE6;
	Fri, 26 Sep 2025 12:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758891460; cv=fail; b=L75MsYWrsxlNTaBPDkHtFzQOsYfswGEc2wg0F7LI2Zenas8BhsIoUb9+q1aySsTWQItdZOPbAUnZaiKN2bPuv0BzOwt1Cf4L82v0qXOg+gg+vW1DhUNzlzqHWArlC5M6ho9n9KJkt+eYFaj3Bouc2S2gl84Vj6N+AmCOQ/kEc+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758891460; c=relaxed/simple;
	bh=1dTwOgGS6ADFs47cJemFMBrbOQiGeMR2xxaYdbAs3sg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iEOWRMOnNw+zP8gCq3gfbEDcQz/nemCV1Fo9J8jNxq8L4OvxJghvQ+6YfPjujlyXqNGNg/WOKK/iD703mGjwdYL/RrdB6eZzcJULl0DziRxBTJb44HBfKJBR49r1J/1ol2k9gfqmZuJAYR8GflCMBaRHuMtw1WNQrPXHSvlQ/uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dC4Gw1ni; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758891459; x=1790427459;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=1dTwOgGS6ADFs47cJemFMBrbOQiGeMR2xxaYdbAs3sg=;
  b=dC4Gw1niPLjFmXpn1VHipwWryaTwNEDPuAR+zmVLDuLzaXe4PShzJWc2
   0DubT2RgRAPvCPWurFwwtZmWTjRPwi68En2D0VlU3b9vTrYdkNl8BQ+zz
   X4lnKSjWtXmPeqq/+27+Jns/LwWpnDvF2k1OZlPUunOp+r38d7Nd/OrTB
   pCvSGpk3hDsW9pE8J64K5Y4zxn5/vwHwq0ZN/88+SVzoo2eRBS3zYlLHN
   E033gIlCMnMsUDVz3ZEK8IuwZ4l5k8kAMlAkuk9rING9D5ESKyUqUhHt6
   12vqbLUAPuedjJzH/DjbVcLMoMWLxJp2SCbHgNoSyTmfWjdw4O71KqO6k
   Q==;
X-CSE-ConnectionGUID: IfUoaAEdTu6bsbjMqGV4OA==
X-CSE-MsgGUID: P4VK3xsjTp2AJ17TESiI4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="72655196"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="72655196"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 05:57:38 -0700
X-CSE-ConnectionGUID: cMchXkRwSJmUxM3JmfL1yA==
X-CSE-MsgGUID: nlu0KymKR2mVG1WfTUOhSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="201302395"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 05:57:37 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 05:57:36 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 26 Sep 2025 05:57:36 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.55) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 26 Sep 2025 05:57:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMf1Mu3yuDwV9tDzdqwnirZP/9ryplHPqaaNg+nQ5vsGqXg/ZrSN+Z6/or+O/QaZV1ulFH9BOtqSIfiXY4Jmxpz2Bz9IAo2fYZscISh+u3ZBSpnEZpyT29cJCP8w+Y5AiVOhtcsimZWPez7LmZLGLFWuDrj08Bfq8rzeoxAO5LVbp8suvUKsvrCWmHWeRGduoxRbz4ySkEUJllJvSTQbI+QdHzdoRaYZgdbjRJg+rtBn2fuoQEcLG9BwjOXHEaRz68DLBrykVacFl+Nt3lqpCMN8nwsVyKb5sj92s9wBEiwIOuGSXQzOdKMLebsZ5dcF6bZvZJD1XEm/kDKuNBo7Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkJye+874cysHMSugdUbKi7DSy++pWYq6eT22Rfjfrw=;
 b=sZ2xnE5UYCeKkTvM0YFKTLz1/Wb6LTKNhMc6Ot8fFJYBj0IOhZimJl8SBPU9cHoZsro3oEInDjW9FDz6O5G03eNeWnik1fQZAITyusYwea5V/6l9AjxgGJ12TDUX86mmTd8+4NgHnrAUb0TwkLEy84kDBfl/QI6I6aPxHZbQUqiYYBoOaeaPiLfrSG8V/ky28K1X79zmYGFmKIS4P96Irke6RtwMQ7p22FsVKw5SJz9go6bykzXdHKZejrkSIdREKbgAcMIfA8bdiDZQoWnFFO4+IVqPUl/YpjPJpHUfugqfLa9Q7TaMoWZmzYKgeq8Zc2NpkQS3sNcGagdgtxmYhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10)
 by DM3PPF96964A2A1.namprd11.prod.outlook.com (2603:10b6:f:fc00::f3b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Fri, 26 Sep
 2025 12:57:34 +0000
Received: from PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a]) by PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a%4]) with mapi id 15.20.9137.018; Fri, 26 Sep 2025
 12:57:34 +0000
Date: Fri, 26 Sep 2025 20:57:24 +0800
From: kernel test robot <lkp@intel.com>
To: Benjamin Berg <benjamin@sipsolutions.net>, <linux-um@lists.infradead.org>,
	Willy Tarreau <w@1wt.eu>, Thomas =?iso-8859-1?Q?Wei=DFschuh?=
	<linux@weissschuh.net>, <linux-kselftest@vger.kernel.org>, "Arnaldo Carvalho
 de Melo" <acme@redhat.com>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Benjamin
 Berg" <benjamin.berg@intel.com>
Subject: Re: [PATCH v3 09/12] um: use nolibc for the --showconfig
 implementation
Message-ID: <aNaNtI+mbyc4zgFy@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250924142059.527768-10-benjamin@sipsolutions.net>
X-ClientProxiedBy: SG2PR04CA0165.apcprd04.prod.outlook.com (2603:1096:4::27)
 To PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5674:EE_|DM3PPF96964A2A1:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e8f0c5-81c8-4ec5-06b8-08ddfcfc42c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3RCM9z00EBkaijyYh3p2mZDhOocMkU4mQcswZBY78lxAWqkrYxtKdQk4PseN?=
 =?us-ascii?Q?qMkRzeXin5/Wa5Cxt8IvjSiHX9iZIBGVdewIBAW+zLXs0YnQMtjP6k5VKWlx?=
 =?us-ascii?Q?I2CHyy2EuJwyCvxIOwO/9q+Mi6I/8yyR8NxgGl/uU/yNmr5IAPvZK1kU1uU3?=
 =?us-ascii?Q?z0DMhHGWVoKEvciEW7e3c9AfvlwvsMO8MyJfucQjEpIuFFEh2MuztlykL9Nc?=
 =?us-ascii?Q?6cZ1rEGE1ogDs2QFMw2e3pUra7gNVWXhaqu3sTxl5sTLxAT0sumfOdyqvsUD?=
 =?us-ascii?Q?IL1PFOI/Qz5peGGEU5MmTFz7qzSYpmQlgqf5OFTO5nFORH7DYE5D4pUckdIQ?=
 =?us-ascii?Q?t33yfX7Zf77lHCzZ21WEa7imatWK3DcQzAzmZwB5OYmmaf2gPAnTr61rjUGl?=
 =?us-ascii?Q?Jsdcv3DuIbQJPiqyF2pGVYGQbI092O+yBkZXg7l7aMqzVgsvJfTgzzEu1gkc?=
 =?us-ascii?Q?Qj043JH127sMNsFDSNqdqf/GkdrZbchxkgM0Xg0l88JElg7qwT6rmfEruos0?=
 =?us-ascii?Q?qocy234FyuQ0e37bysZtgOpUbZJG4Qr9TQ54PJ81xMQ+8mDqvbVge2bTyHH7?=
 =?us-ascii?Q?TDMaPxP15ETbZRHsyetTn6M6uZA5oY54n0bYkT6kJ+F2TlbkHaq1+GmrK/pR?=
 =?us-ascii?Q?2BUdP9YBgaBfd7Zn1yPw/uO5nzH/6Dz57T8pgOQjdYiV0oRceF++gfMSCLK9?=
 =?us-ascii?Q?cjeCdi5G6Dmhv7QoSv3g3ljjH3aitn/c4lCGrSH82KbcegOCxdXEFxIdNNVa?=
 =?us-ascii?Q?yAHQTqsEm61+jDVkjOZJGCBsmvK5Ev47cUAFmFV+lvJZM52ACaA/9xnhA0Ud?=
 =?us-ascii?Q?+CuQG42aQoSUS6AF0fIMHi4USS3JH8uH+QoqbxkV6/yUCFL6oQJRtqKkhQoO?=
 =?us-ascii?Q?z6410nzuikJm2YXjmjYX1RSKprnPuARRfg7/sna+2SM7j2kugONtcU7K1Mtr?=
 =?us-ascii?Q?FDf0QDX+op3QQIHU0I8td3HwVJV9+ej2/7HkdjRy60fV8mxqR9//gYoh0Rcb?=
 =?us-ascii?Q?yO5w30AHw2Gzt3MUewtHMKTQ54Hhs0QiVjaFFGv8chRTnWmr7uf5v1QPsz/f?=
 =?us-ascii?Q?CRuHV+T/KQha2Y0Y0HoIO0wz8+sHbYKLtGhTVnwgQ4OwHbbE+BBRKu1BScT2?=
 =?us-ascii?Q?E/sySJQXx0mTb1qO9AUGRN2DNQ5X1nmEW1mAVzggPC1Zmt91Uc7vV/MvcXZe?=
 =?us-ascii?Q?PJGG7nBgu5Y6KZWvyhGnOUL0Q9qUUYJb8e37D1XyhOwEeLR7x3c8SNaFwks3?=
 =?us-ascii?Q?ayi65WuBMZ+sZ4ew+D5KYEcMWmG7VuU4xpU87+BIIJWoJ89LHVRh4pIGHfOA?=
 =?us-ascii?Q?IK2pgKy/zVCea7X9dT7BP9VBrsWSk1oLe4eGjWN+U6VFU/558Bt/E776n2+R?=
 =?us-ascii?Q?E8yfkmkZEvg0Noa2Sar4gyUoMEQkS4LfIVWx0Y5QdFADiH7TdFJ3KbNx38ci?=
 =?us-ascii?Q?2D/ci/psl9w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5674.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jFgsPbRx112nh9lWzyUMCcwUbdPIgPfqyq5vGUAmTGN4pv35Yc3xzq7uy5tJ?=
 =?us-ascii?Q?nv5v29ndeKT43Wt3se9hIqoJR0tRghBf8z+OFF3G/UZxnpDVoskDHuEWDbiu?=
 =?us-ascii?Q?TN1kL4fKP2JazbxrtxmmNUL7SoIxspsJUgNLYl2AihdWcGM2mqXFTMnYVs/M?=
 =?us-ascii?Q?SfFuKL0KX9nOYwQgk9qH/0hXnnO2lrh6EGvQ75YjWzynd/oy4ZQPcpYc9ozE?=
 =?us-ascii?Q?/g4Nz4/A2aTGfkYtp3JxNe8xirF4jjt6IA53YdgSw23ImAzZObesEfdSwWFb?=
 =?us-ascii?Q?KRSIq9U4TKKDyX5GCnbGYG2tEVdNfMQ0sEU/UJeWNhiIxz3SRb+z+S50/9eN?=
 =?us-ascii?Q?y5TRlz/FGrFBS4Uhihhq3fExGBPAVs9FbaZh1KrA/4Txy4QF4uRrZ1x0/tPt?=
 =?us-ascii?Q?OlWoDlQmibYHSoDEV4Y+qaWL4MrV/EvvAmpRkUOn9GKFtKi4bM/o/VNGo7va?=
 =?us-ascii?Q?4MInKpVlWUYyhnYPI2sHarPTD9Y/qnjHUegk/xz3meUB1YGVxzi9fJlOyttP?=
 =?us-ascii?Q?6z1YW/hS2Hb15ZZw5NqX+p8jNVZhZda844BQMrQN7ox2kz8/0Xlb63Hd8VFw?=
 =?us-ascii?Q?ZzvSWK3O7fJ0L+VBgxPGCzyYb7Y37DqV24MWbiSOFLtq2NenozfTEQF76pEQ?=
 =?us-ascii?Q?QDq0wmVH3tcFJ1U1OQEsSrtHGryA848myVf2gqHVnN8JniiTwVeyY/KpXpYn?=
 =?us-ascii?Q?Rqq6ZXSYNwzMvl2qBuHSUT8XgtP0Kvs5LhFBdEgalTeDlVKdtlmcF7LPsD0I?=
 =?us-ascii?Q?/EtPL5or2+l5RrJJPdplFj4/d7W5E3PNe+JxEYO9bFw4veYclxxFdXYtHs9K?=
 =?us-ascii?Q?+Aj5pwu2G+b+UnpGcwIo3SvXrXf0GGvlRvMf3F6SnTsfSzni6XZIfpBDt2oK?=
 =?us-ascii?Q?k7gp66qLd5lzDYdPGXbhOhc2FOd62IlWwhnutpzkYExVebUqKaL9b3jGK/5s?=
 =?us-ascii?Q?Hm5guan5420bCpPFti/6os9qEsgTdKLlC2oH9h3ekEGx2uwfou749YIZEGkr?=
 =?us-ascii?Q?1qJ/3kcrZJnfpxQm6/Ea2bFXY300lqg2IDYgnW2f0cj5SLVltY1T4YirkEop?=
 =?us-ascii?Q?v2WGQPhJ+utDCg4XAPkBtMQSquFqvadAEIZqcVD45YuS7NaXUYu5kH5Bl+Za?=
 =?us-ascii?Q?XN91yeIjZAZ9hSTC+z1t7tW/Y5OtNpynDllBphljoWhfxm9duRdRLExThY0o?=
 =?us-ascii?Q?Q5wptkhTX4QFiychfv7N7xyjHS8hAWz3KAMyMo6ZfmTMSEXrUMUSowvmInTK?=
 =?us-ascii?Q?QaCG1V3fnxMmhJq/kEsW9HpB6/1Bx5tPM4huqQeE7dJ1IHlhuCP871vZi60J?=
 =?us-ascii?Q?3DCVlcT18ZV0mPNtkOgA5KStAAwE09jy+PNJ/Vmi9NWCDUlCdC/8Kz8Tjdvk?=
 =?us-ascii?Q?OW1ffKYCdihKzk8+RdIWMtdAunfWTx7ozbS5h6R/3x6ROyOccSRFjg2DJXyr?=
 =?us-ascii?Q?7exJ6whVSOnKjPHHiN+B3g9YKNRK31clE4yqeFTDgXp5Q058BSznzBvfa8oQ?=
 =?us-ascii?Q?Gy47tKimOkuAZIWINNxenyZqwnro9ICAzDm0Z/T22Co4unmiI8W1VX9UmbSg?=
 =?us-ascii?Q?yvO1JC8vqrVEz8cLY/iA/LAJgJqxAV0D5l0hG2q3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e8f0c5-81c8-4ec5-06b8-08ddfcfc42c8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5674.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 12:57:34.2278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INnYJzOCSNz2etjhVwzVEr0CwQVuheeJwuXGLLbWHzY7CSvirdE0bDIIWH8aBJnrqzvDXLiCqQGV50cwsBSqjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF96964A2A1
X-OriginatorOrg: intel.com

Hi Benjamin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on uml/next]
[also build test WARNING on uml/fixes shuah-kselftest/next shuah-kselftest/fixes linus/master v6.17-rc7 next-20250925]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Berg/tools-compiler-h-fix-__used-definition/20250924-222547
base:   https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux next
patch link:    https://lore.kernel.org/r/20250924142059.527768-10-benjamin%40sipsolutions.net
patch subject: [PATCH v3 09/12] um: use nolibc for the --showconfig implementation
:::::: branch date: 2 days ago
:::::: commit date: 2 days ago
config: um-randconfig-r111-20250926 (https://download.01.org/0day-ci/archive/20250926/202509261452.g5peaXCc-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250926/202509261452.g5peaXCc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202509261452.g5peaXCc-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   command-line: note: in included file (through tools/include/nolibc/nolibc.h, tools/include/nolibc/stddef.h, arch/um/include/shared/user.h, builtin):
>> tools/include/nolibc/sys.h:109:29: sparse: sparse: Using plain integer as NULL pointer
   command-line: note: in included file (through tools/include/nolibc/nolibc.h, tools/include/nolibc/stddef.h, arch/um/include/shared/user.h, builtin):
>> tools/include/nolibc/sys/reboot.h:31:16: sparse: sparse: Using plain integer as NULL pointer
>> tools/include/nolibc/sys/reboot.h:31:16: sparse: sparse: Using plain integer as NULL pointer
   command-line: note: in included file (through tools/include/nolibc/nolibc.h, tools/include/nolibc/stddef.h, arch/um/include/shared/user.h, builtin):
>> tools/include/nolibc/unistd.h:57:27: sparse: sparse: Using plain integer as NULL pointer
   tools/include/nolibc/unistd.h:57:30: sparse: sparse: Using plain integer as NULL pointer
   tools/include/nolibc/unistd.h:57:33: sparse: sparse: Using plain integer as NULL pointer
   tools/include/nolibc/unistd.h:70:27: sparse: sparse: Using plain integer as NULL pointer
   tools/include/nolibc/unistd.h:70:30: sparse: sparse: Using plain integer as NULL pointer
   tools/include/nolibc/unistd.h:70:33: sparse: sparse: Using plain integer as NULL pointer
   tools/include/nolibc/unistd.h:81:30: sparse: sparse: Using plain integer as NULL pointer
   tools/include/nolibc/unistd.h:81:33: sparse: sparse: Using plain integer as NULL pointer
   tools/include/nolibc/unistd.h:81:36: sparse: sparse: Using plain integer as NULL pointer
   command-line: note: in included file (through tools/include/nolibc/stdio.h, tools/include/nolibc/nolibc.h, tools/include/nolibc/stddef.h, ...):
   tools/include/nolibc/stdlib.h:56:6: sparse: sparse: symbol 'abort' redeclared with different type (different modifiers):
   tools/include/nolibc/stdlib.h:56:6: sparse:    void extern [addressable] [noreturn] [toplevel] [unused] abort( ... )
   tools/include/nolibc/stdlib.h:54:6: sparse: note: previously declared as:
   tools/include/nolibc/stdlib.h:54:6: sparse:    void extern [addressable] [toplevel] abort( ... )
   command-line: note: in included file (through tools/include/nolibc/nolibc.h, tools/include/nolibc/stddef.h, arch/um/include/shared/user.h, builtin):
   tools/include/nolibc/getopt.h:19:6: sparse: sparse: symbol 'optarg' was not declared. Should it be static?
   tools/include/nolibc/getopt.h:22:5: sparse: sparse: symbol 'optind' was not declared. Should it be static?
   tools/include/nolibc/getopt.h:22:17: sparse: sparse: symbol 'opterr' was not declared. Should it be static?
   tools/include/nolibc/getopt.h:22:29: sparse: sparse: symbol 'optopt' was not declared. Should it be static?
>> tools/include/nolibc/getopt.h:81:26: sparse: sparse: Using plain integer as NULL pointer

vim +109 tools/include/nolibc/sys.h

bd8c8fbb866fe5 Willy Tarreau 2022-02-07  104  
bd8c8fbb866fe5 Willy Tarreau 2022-02-07  105  static __attribute__((unused))
bd8c8fbb866fe5 Willy Tarreau 2022-02-07  106  void *sbrk(intptr_t inc)
bd8c8fbb866fe5 Willy Tarreau 2022-02-07  107  {
bd8c8fbb866fe5 Willy Tarreau 2022-02-07  108  	/* first call to find current end */
4201cfce15fe35 Zhangjin Wu   2023-07-07 @109  	void *ret = sys_brk(0);
4201cfce15fe35 Zhangjin Wu   2023-07-07  110  
4201cfce15fe35 Zhangjin Wu   2023-07-07  111  	if (ret && sys_brk(ret + inc) == ret + inc)
bd8c8fbb866fe5 Willy Tarreau 2022-02-07  112  		return ret + inc;
bd8c8fbb866fe5 Willy Tarreau 2022-02-07  113  
fb01ff635efd0a Willy Tarreau 2023-08-15  114  	SET_ERRNO(ENOMEM);
fb01ff635efd0a Willy Tarreau 2023-08-15  115  	return (void *)-1;
bd8c8fbb866fe5 Willy Tarreau 2022-02-07  116  }
bd8c8fbb866fe5 Willy Tarreau 2022-02-07  117  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


