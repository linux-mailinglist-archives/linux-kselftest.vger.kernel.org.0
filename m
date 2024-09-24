Return-Path: <linux-kselftest+bounces-18273-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0025A983FF8
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 10:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1BC1286A48
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 08:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5AC14D2BD;
	Tue, 24 Sep 2024 08:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="btAqethU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A0B14BF8D;
	Tue, 24 Sep 2024 08:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727165309; cv=fail; b=j1tlAtxZ+/VaqRvahULElpOr80fzjQIYMM8yiaZ8dMlt/uAmWJ4vPztUc+HoZfmwcSkRDs2ZrSXZTY1eB/3Gu0SXSsaROup7DoF0oHKYKdt9y8oxAHMlNzy5u6ruqUGf7aKPXrrF4lkwgWedELFtIfGIlEl9Yn0pJrQ2V9eZZss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727165309; c=relaxed/simple;
	bh=GMT3IqqKDdRYRb1QQhWSMg4Qqg+tXzXUfqaut1cXtIM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=H/iQMMZQcPdjuBRuajj5SMOMqkTjr864aV1GUQBg5xfshdqFDUDnyqqniqgY86vRoIQ/kyaX+xcn9hv1qlwpjc+uKGGPdkvd1Bkywm6S2uHdloYLlUukKDu2YRj6oso6rw5QHElMd80CB3uT+hfLdOz0B+samB9HScDK0RL9MOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=btAqethU; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727165308; x=1758701308;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GMT3IqqKDdRYRb1QQhWSMg4Qqg+tXzXUfqaut1cXtIM=;
  b=btAqethUN/GwLH/LX63X4uFobHxSh5OXZ+6HsU5KZJ1Or4IAOysZTdff
   lxazIEgxPQTb4f0Ty03AjCLZWhbp7IONGHAV1ORCgGdTjtApD0TcptEP+
   5jvOrBPT13TDjwMiVPcqiy4Z9TyGC6wY1KKwpGhD9pYAmb0eePuPHuXZd
   EwQygfKrgzvBuiLdbyw/3715Mr9Dq4xWAFvTH3afO3rFMXIt91Tu+UjXr
   jJAaL1Od5MBrjg0oh0qOfWEo6TFe5K5DpTekoJ/E3wPAlJwoPJj/PKjcM
   NtbJ8nVeii4clSmjzqA8PnBDKgXmUkgGwph63xdikpYTrZvwG5GA99a4y
   Q==;
X-CSE-ConnectionGUID: MkrZnNXCR02ybSfj6EpUdA==
X-CSE-MsgGUID: dQl7K+W5SFSfXOrKk724QQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="26096015"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="26096015"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 01:08:27 -0700
X-CSE-ConnectionGUID: MyEwSSFvRXu+RqWJEvPW7A==
X-CSE-MsgGUID: RWxZxAUxSuOSclLn/cH5Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="70934204"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Sep 2024 01:08:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 01:08:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Sep 2024 01:08:21 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Sep 2024 01:08:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FjRqVSMygBw07uLFcFkD+sF9aQo8/TcamZIPEb2whJT0d13UUeQ6V13dZyUIx/0HzamgAxzMaBIk+rQTosH2gSpRa9dDzu6ciMw3la3IUMp1Ep/aJTIa3D1uEI1+qzK0R9IWyUdRPDCEUOxSG1PgF63k3cyTafpLh0pZyRsYp16gkxULD2rKZnsBQgaEMPX7VoURlTZb8nVJ3YQN8IE6MqvneMgdcT8+tNBx6YqciOxthDrHTDcsk8j8clt2TK+ztz7kadTvMA+ZifCDph+k7/VEXhMcEMJYtO9Hg8QC1fA91iA2DT78QH5MuMJ0rUlU0pSMKjmbrplqHInfnxYUEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mu/J/PYqQsCo3wxrhW2dpHHndz1kI0NT+Zxj0+NGZD0=;
 b=jtGGLDQ7CKLXGDJb6gZdLpLOd3yLzqjz0BdWTOjo49ypPjXKJo2yVxQpBY5poBan88ATMQdSJqlXgQVTiNLJwzeeluOOkH9qj/3ToARnCbEr9ktkZA+8r8oHNEAALnR0FYc2eiUHVJaZIcMcpRQW5dDkwRa5Rdkb8mbv08rLkJ9zXUIYxqf+s/10OY7V2Lh3j/kNfsF3a7R1iNvAtZi3gzWIjPqg6L5PMn8NTf9Gpm8cRU0+16HxC4v6dAZtr5bx0eRl/FR++lQ7OCLTv4xnbwyx/fwsnlfkDpxfG0ATts2oJ5NxH2fcc8Elu3ZUXj/hJz6jhM96G1jYCg52NmxJBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB6831.namprd11.prod.outlook.com (2603:10b6:510:22d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 08:08:19 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 08:08:19 +0000
Date: Tue, 24 Sep 2024 16:08:10 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>, <linux-kselftest@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [selftests]  ecb8bd70d5:
 kernel-selftests.vDSO.vdso_standalone_test_x86.fail
Message-ID: <202409241558.98e13f6f-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB6831:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cf2fa16-8b57-4e55-381f-08dcdc700d23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?atIrowimI66VCg7zTl8bMXjiFDnCwuwTPd0HGpPU/TytAD87gJr4vWm7/oi/?=
 =?us-ascii?Q?g6O4lh3lBsX4bauSPsb/Na3Eaci/7QgZMU6JySt8T68Z+XV0t61tcycqiJ+u?=
 =?us-ascii?Q?v+HNRQjUl0ipMuBWHUEn5oWkbT22IUpascezZr0sZgfvc4jtdba65Jj8sTc+?=
 =?us-ascii?Q?7OougUwcASrIexAPpv3OHmWiBERRev8sYi975vyi8n5dPrF8YhB671R9hv1V?=
 =?us-ascii?Q?WClKyI4IHSdqbO13AdD/+n1QDMKvaeLCZAmf36ZilBQruZ9adZSgJDBDnxAv?=
 =?us-ascii?Q?e/+cwLCnwu6ed/h/PhBeKb82Z0Cwal+8JBQcM1NwsTQq5vLP25N6tECfEYZ8?=
 =?us-ascii?Q?pAyaN/1uMLEXsKylPM/p8SH5Fdaew4bZiCz0SX7XUYlDWJU3wIvqMdyyfrcx?=
 =?us-ascii?Q?pMW1RygDIbZkP5l5D82EpwDwFEgXz9DnvPcn8quE3pT+dYkZu7NLqCPF4IpK?=
 =?us-ascii?Q?k9TleCuWayy2HikUNmnxpXaOgd7VO1DaF1WV92xg7DE9Ad3YJfolAEUPdd12?=
 =?us-ascii?Q?+9KHTptyHvsZtuQQeqwz9xfOcFdaYWW0MUw9mcIFddVWaV7Dm+5+Uw7cZnaD?=
 =?us-ascii?Q?tiVmVXEYc8RYyT0i3/OV92HgJe2uPbnurnQhtiJj2nbETq0Th8Ug8PM3YP7O?=
 =?us-ascii?Q?Zg+sxyAUVyIOcao5zet0xpP+mnsSAfFeXJbKDcIobiGKfPgdhwZVabpFE70J?=
 =?us-ascii?Q?5HTweiZX28yJ+QyXN1eygp/iry1t9JzbBcao3bW4LkjFQVdg8+0WGi/Js5kP?=
 =?us-ascii?Q?5z4eQvUOzU2T373xh7nUPxaHSYbAOfPu3ml5ffsssqx+j4gtIcG9/yMVnBEb?=
 =?us-ascii?Q?vNaIP2c7J0mJzCpXui262igX66hweZHFVyCPpjiQL78XokUclHFnWzxtpPVs?=
 =?us-ascii?Q?uAynHQW8Odp/algbjyNMQsU74xKUPIEqKK7Mjb9q1loAqA430rouECGcvsOp?=
 =?us-ascii?Q?cUhCKXDdr9I4io3un+v7wDxb5Ub2WDF4EwDLwcZ8MI/tKoZ03m6ZLQ6HKGab?=
 =?us-ascii?Q?27LhzZXtyGa1ulhzs2dHOE6qsFhAyx+g2n0z2YeRZ7TeQuNVucA9UC/AV1zb?=
 =?us-ascii?Q?6yOPrtgXx7D8d1eqKwL3tw1nBGMVsr/KM+VFfqeQt7NukOoyB6pFCUnFtezf?=
 =?us-ascii?Q?BMO+2mCz4MkoP6MSpwlenX+S8E3my2IvMiOyDJh4Hnsd2EQj8CYTcQxKwzXD?=
 =?us-ascii?Q?dWNIYUOmJ0DgLsczMnajmUB2TW1/zxhpWblrM5w6PtkhRzkPFFWImoGtvMUm?=
 =?us-ascii?Q?n1XRCXhM3Es3vceNkCfTH/K9T9uJH8P/rjMWaMeXP1sPXie+dEHrzOnn9kAq?=
 =?us-ascii?Q?Ysg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l1sbJk0gzDbLHD82iJjRuXTeb7giDzeD7R88YjrBTxVMzc3HA5J3bbGWZ+Nv?=
 =?us-ascii?Q?E8ELvmTmixa+79ZLCu/Br4zU6om31pYY8orxyG0Lr3xyszm1XsndjaVt1nCM?=
 =?us-ascii?Q?gPseRl18tt/YmsYO2uKsFeCA1jNt1wVahhSFy51uEgIaWGFtrr9fbJaws1I4?=
 =?us-ascii?Q?qsH9JH+t497p17IGi2B10RqZ0wEpCrYE7KYgkKegyfs8BGGf6HS9tjbwG+BT?=
 =?us-ascii?Q?QWIFzoYFF1OCIgVu603pbI6K1SOGRVjAXdDKxTQOtqg9sTCscAaTZHoTTKe7?=
 =?us-ascii?Q?DRJwcMoOtru7saCroWbozpPE5P6RWL5kzuF/erM6tUGvyjMFcFIAvPHj9cmm?=
 =?us-ascii?Q?qgd+kBTl7kz2j9P+Cbj22tOcLgwTirYnvAxKGu50Lz7w8+RA0O4p5ubHRKSW?=
 =?us-ascii?Q?x3Gl4OdWBbTAnjtSY8FRatmleDYsKmLnHWGVfjLVfbCGCbeI/bcPn2/ouxmn?=
 =?us-ascii?Q?2+bcxau7JzJpBdbMjzjexcCGpaH14cNnC687OH7Y0Je3RYnHIhjZzQD61/nN?=
 =?us-ascii?Q?pNXAgXj/KIj+nuvyGrOuo/khbKXgUH1MrAcdw3V4CDZtr0S3oQcH/ARhymmz?=
 =?us-ascii?Q?4NaXlsPYi5HAuRJPOLBhky047UXYe9oqIL9DtWyq1Jqtx2+2U34LZoDnDtTL?=
 =?us-ascii?Q?TykT1EIYSWKFJoFqGehSqgyMn1EtkkAc6DSVdskIIeoaf6ZjDpX4e+MWMsZ7?=
 =?us-ascii?Q?nsvsREE7YnwWISQjy8nWoYidmKST9+SntiU4WInMu93vy4+9RUS/Y9cZvl1B?=
 =?us-ascii?Q?x95tUXXD3vjtib/RcUO28CqIb21H5qYpiWni52ShBhl2uWlQ4iUias2Lh866?=
 =?us-ascii?Q?C5Ghf3AkY9qJMzi1DE8Kgy6tpydnZA86f6zUCGmCzlHG5+kRktMoCy74DCqt?=
 =?us-ascii?Q?HQ9hGnoJ3lLSrojtIaivE3QnYLTxUISRU92shYOJDkGH/e1mx8VbU7q+yCUQ?=
 =?us-ascii?Q?dhX1qWobDOYaQzZpJYfFF7Q63jQXM2JHwKW5qUkeV/hG2bf0n0THCCTdnyuw?=
 =?us-ascii?Q?yA22XPHqUyUQ4sU87M5/4yQU486704lIgPSHg83WfPk+13u0Fvuf+wmFvJ3I?=
 =?us-ascii?Q?+4iUSbQvV2Zn7VuuEHyvN4KF+TYPnAbGJsM+HnQf+A+wsvCJLyMqw2Uc85fK?=
 =?us-ascii?Q?lSZdZ1hW83Gr9ptPn8zYkY4/MkK/8613AhyAQGSxXrZvjH0zE56fYcYD88vz?=
 =?us-ascii?Q?nee6q6yloDTY/pDH9Hr7+Gar7P56f5YedXj3ggTeUqDkfaVdJO8qM33/zqaU?=
 =?us-ascii?Q?AGJ/kYDmQbIBynb2Be5879vyaNrDbYGiksLbwD35lG8cE9wmWHA1OwIhM05r?=
 =?us-ascii?Q?qey+Ac0oktSWDa6QgwiRuK/9Wlni17BIulv+Ei03KoBuIQbaA0vXb277virN?=
 =?us-ascii?Q?fYrSyK/DXDBZ6TGUCTRrnsYUW5JOfK5Qgk2XD/5sJTLyIq8vJc+T34onyTPx?=
 =?us-ascii?Q?N6r8/obWfIkQV83tUS3gc3OQHtkJ2JCycaFwrN0+iXIG/ufZ2aDiF+DowKQX?=
 =?us-ascii?Q?au4QynmH5tpnN79qNF0cUIrJpl/4iZ3U3eeIWKfB8hiWH+c8x1qzPp0QoBYn?=
 =?us-ascii?Q?slAuXM2Se3H+2s/ExbJvZBGpl3ByYSc2atyFwRTmbHf5XMalX1bPUHL+afoT?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf2fa16-8b57-4e55-381f-08dcdc700d23
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 08:08:19.5329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKU/cmwTy2MsqX2EThZOme1kBFTNQBBJq1gSZSemO+ARWkeQqppdpBT6EsXCG7TNw+pMevzDq/dz4JHevcVHaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6831
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.vDSO.vdso_standalone_test_x86.fail" on:

commit: ecb8bd70d51ccf9009219a6097cef293deada65b ("selftests: vDSO: build tests with O2 optimization")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

in testcase: kernel-selftests
version: kernel-selftests-x86_64-977d51cf-1_20240508
with following parameters:

	group: group-03



compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409241558.98e13f6f-oliver.sang@intel.com



# timeout set to 300
# selftests: vDSO: vdso_standalone_test_x86
# Segmentation fault
not ok 5 selftests: vDSO: vdso_standalone_test_x86 # exit=139



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240924/202409241558.98e13f6f-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


