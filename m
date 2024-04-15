Return-Path: <linux-kselftest+bounces-7930-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3A48A47D0
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 08:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E67A1C21F4A
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 06:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7562B6FDC;
	Mon, 15 Apr 2024 06:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RO8W/E3C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D956FB8;
	Mon, 15 Apr 2024 06:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713161511; cv=fail; b=sdqB4iZQm3Knd/MlzH5KO4AumzDqDqbzFvhEX0iO12fJ6APtcBtAyjWI7hwb5OM501GtIHy+Zsgy9XG0drWGsc3yZ1bPMmL+uzN7EJ0dGIfRRbI/Nd9RpBn1rutlo+OFiCgPN+E4G4rMfcPKz4qc3JUfSX/CmGfYcyazA6QoNQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713161511; c=relaxed/simple;
	bh=7aQ3LqtyBY2VpMwPrZ/VK+TyX/XgfeHBUaW8VEUa9bo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=CvX7wjZFzoQhY0DdoDqzMtTB0mjVjBJsLleqvHszB02Ihf9R6PY6umWU8veLstin8kkBFvX9Uqrrb1ILvwQRbCmBA7iSRHXPDB6hwcWRluxmVFbT0ZAbLpNaFUylKH0AWMpu+ZZgj1Ri6ucY6d7mgrrymNC9aTnCs5jpKLRhTOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RO8W/E3C; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713161510; x=1744697510;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7aQ3LqtyBY2VpMwPrZ/VK+TyX/XgfeHBUaW8VEUa9bo=;
  b=RO8W/E3CXCiYtUUpaWx3kLbA43jRaiDWiSWXt8xRmG1zNEetMcfo04So
   ZTiRPkzpJYIlKkgj1xYXyAC3JcpMKRfLImcqkPgT5bT3fPH5AiLxWk4yf
   lcZEim5EA9C+Ed0rOqAYzPg2eM0baBsjWZ0Dxit9MF+LP9GTyqKLLOAia
   Y1ro6hIg+OIDcXPMyu6eLOiy4atdaQmx5ArCMizC68aEWGAFDZEfSXW27
   eSxbe21Wity4f3EX2D/O4ACEJ9DIICsD7CYi6ZRxy1RIWU8ZcpLFi48O+
   gB6J2maPX0KrE3wwbWz8pElBFIP4UWlg7V34Nlo3qhSXGRl7ISDR5BFbz
   w==;
X-CSE-ConnectionGUID: 75/WuDTKTDeB6SNJN509vA==
X-CSE-MsgGUID: bz8B/wDjSGKU7elQmgCXbQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="8399840"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="8399840"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 23:11:50 -0700
X-CSE-ConnectionGUID: okrxbmS6T3yQGiVif3WDhg==
X-CSE-MsgGUID: sr9lem8kQuqz6LoyQhel1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="21797738"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Apr 2024 23:11:48 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 14 Apr 2024 23:11:47 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 14 Apr 2024 23:11:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 14 Apr 2024 23:11:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 14 Apr 2024 23:11:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PS3PhDKaQdAwEr5HiOa2QvZQ5SinFhQBFWvPPjWkLeQ/udxpoB+cGVAUZdmbhSqYhP011jRrMN3o83NBBJEGNBvq3HXpBOd7WZimoCiQHDh0Kh2ge0iBcjZOehR5I5qRvauFK1yGDqec4oevFNZwSc9Y8rrO6hLtz72Wwz+N7K/0rNFLoXVUdC31JoIkQ3ZuzGkjyr5X+CqDcH4RFiYV1vAwIZ6UEalXRIGVw+2BLz3HD5Myvku0GOvaGjvwp+Boras3DL2VMJNKaEkZnWqtFe1FqZjktLDzVfVZA3p0CzuYYgOIDTLgjXm3IwUrB0UJsKwc7wfAFcrxMKdSfTKgzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tVE5mT4TaF58BIYSFoHd+3EEuzG78Ln8k63uMlcI9c=;
 b=hL6vvpPDaWC7gBOXjFQNDkbQ71T6S6cFRkFo7IqFY7VZ9yMT/TRc3JQRj9xDxLvNRRQEHe7xZtbs3M8N9lMWOK67mGOgdLkvynj/ygkABp/orOS4/6DW4GGBfu45d2WIXMOBGs7Iu8UHsXAaanS7aNJnREJK2yY9elaiQ9SnurklUfVF5AYk4gfCkjhsxmy/zwQDnp2J2AHejYsifnPx2btjWD4KoDmbhghF/0FscjAXa07Dm/gPFMmM9tYPmxUULMf/bSMZl2P2mKywgD8eRCqJP44Q6j9B9s8dFfKIi/Tld/L5vVB3sNTBtek0WkUF7+RwfFtMKs4ncCl+5b4tlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN2PR11MB4709.namprd11.prod.outlook.com (2603:10b6:208:267::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.30; Mon, 15 Apr
 2024 06:11:45 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7472.025; Mon, 15 Apr 2024
 06:11:45 +0000
Date: Mon, 15 Apr 2024 14:11:34 +0800
From: kernel test robot <oliver.sang@intel.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Shuah Khan <skhan@linuxfoundation.org>, Brendan Higgins
	<brendanhiggins@google.com>, "Eric W. Biederman" <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>, David Gow <davidgow@google.com>, Rae Moar
	<rmoar@google.com>, <linux-kselftest@vger.kernel.org>,
	<kunit-dev@googlegroups.com>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [kunit]  9353399610:
 kunit.VCAP_API_DebugFS_Testsuite.vcap_api_show_admin_raw_test.fail
Message-ID: <202404151340.5b152d96-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:4:186::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN2PR11MB4709:EE_
X-MS-Office365-Filtering-Correlation-Id: 3552c42b-f116-4350-ba55-08dc5d12ed3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nvETYtBSFPdhK3EPSVkxB+V/NG8H2uWPLuJKdmTT2gmqNouYC/s5Uiy8UNJgjAAzF1LtkHuUjhCdiU/ZFuSZ1rGkvphaW1LEXAgj+JeNcS78Ne+59WqV4jqHmqEhVbyAaJlMOXPGQdPdQEF2js7/dq4Cx97ob8ntiym/dOECSNxfaKlGFdk9/g1wQYffz7niIlV1F1+ezXOlYKDv3U+Wo60b9sPpbJi/d1Eqfk1ye7zY+6xiboDgvhVaFaSsjlaoHH+e5yxZ/qYk49ng4AtFfIVu0TJLBC0DbqRAynZ42NHist3Qhqf5lu6B5t1g3Cx+1XxmnKMGEUxHrxpz7EAauxm9r3LrwnlqUKbr7ag/RYEkSsL45pPa9pmGxFF0Y6FFYCXlSNOHilxc+mCmxYzZQ/zNQvbqzAsUv7qeeNwYMSZI4LkRJdN5UiFm2O36Iqby3GvGNppjbsoK5jvs7E7gEINH0KQYOLX27wFuzkYwfht6rW9uN8nIePB4RX09Ux5mi2teOTJYG21omoFp1JJYZUwYXq5HZvOSl6Asf/WOpFAVXNkZ6alyFR0G/cklGim1RRZQIOLNS87NghV4fokjy7pQxtAv2gtaYkFIxyJFWok=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?urTXEVcCaL4wUxvUQLGxQs/N5SEK/ykuLvbOYYSxe16rcKpmgvRm5XA8VTWs?=
 =?us-ascii?Q?kRAcKRR3kL1PcxdmGgzad7aJkPHRikhGDlJKbeS8ipCSBxhywv+8TfsqFK/O?=
 =?us-ascii?Q?BDxHJfvU67u3iUvx7VMVj2TYYY5W1pbrB0qHV6XWug7HD2vZdd4SEs5SS1XX?=
 =?us-ascii?Q?09Lu1KPjSkCB4aguTlA6MBEADOxk0UgvQZafZkm7TmKYUkDrXwamGKnLM/u2?=
 =?us-ascii?Q?rV4irz1XgTK4F969C8/3Fzdfuu2IkKKHkyePrkLZ0RSSc9JvyUcaXoMMBbUo?=
 =?us-ascii?Q?jILO1JXds6cpCeo/2ihmr+puzseiN2bgIbome0ncTbr5MMfDrd6BAcCiGOym?=
 =?us-ascii?Q?afDGlLj2pIQmR6bsLluoGM7FCSVjOz1xJpZslKrITxrW3q3xJ8oEwafcfMW/?=
 =?us-ascii?Q?fXEX3Fd3Hz57kLyTZR7+jpTzP8B+PWn960e3LiZ6Kuz4rYp7x63i5FWZ7g55?=
 =?us-ascii?Q?DRUbghRCg4qBt0mgxpFoEy7fAhso8aJj/0quy3lrst1247FNbUvywipxBKBp?=
 =?us-ascii?Q?786iJusZRJ9LuxYlzlIibe6GepOqR79+Zq3se1f3qKVR+nMV9r6SiP4SZvLq?=
 =?us-ascii?Q?7ZiVNsky1/sryxbJzTYxnaRBk1X/Xl6BKnE6xVR+z4w9X3s18VMCXnkOYld8?=
 =?us-ascii?Q?I1Y+FNXIsW817NgI84WXLaZgcMgEwzrchnPqxmP28Zc/VM/nKiEKszHcloWQ?=
 =?us-ascii?Q?BUvINNPPP+Mnmr5qVvVvrGR+mm8P0SCe1oLeaYsWRYCLxQy5dKZ5i4RdOYHC?=
 =?us-ascii?Q?TT9Xgb75S1T73d0Is9PS4Evdnqep9fj1FCydcUPM73+SnG91Lm/XgyX+EG+X?=
 =?us-ascii?Q?wwn7hLhBWLd7eXzPJA9a0n/VHSIQJle5saGgCqUBR04D447Rt0W67SPGvPWK?=
 =?us-ascii?Q?yyE/XggzvGYtNI07PpEMcsgQHZxpwWdcxndLj9l91XCvmAdqeBpphXOJTm7Z?=
 =?us-ascii?Q?QXJl1NdDVSBuEs4gZHfIutxPAYHAR1+D5MOaGTTCgmsa6aubFHil9Nktv5uM?=
 =?us-ascii?Q?JFmj4ihkHHquMytFFvo0QShPy5DrR0aAHz02gmVQzpTWH/50FPX7YECU2tJw?=
 =?us-ascii?Q?6EdBEPaAJpYTWd/U8t+ysrsRGkMy+sviXycbhjYLfxbyniIhDG0Gr+U/EbDn?=
 =?us-ascii?Q?W/f+OypxbIyNp60LohcnV8/0CxySZYXxwUiKh5vfuYKcvWyw/SHx5Z3fNdwU?=
 =?us-ascii?Q?FHppA1E44Kc/0zSC6XuN32umO/I5YpJieX3o5BKiJpxduquHjiYecp6fevQ4?=
 =?us-ascii?Q?dsd7LhMf0yFSYbWrlweUUm/ZZjraVM2C3bX1t4EiFYY+0N2Jmcfz785NEZXz?=
 =?us-ascii?Q?7ektsteZNco1f7AAv0iLkKYfEVH767q2d9ApIvGILkW4jx6tQG5ZsZ/GfFqX?=
 =?us-ascii?Q?88F8MPKa9Hguo7UecCqjSeTi6ddPQ7Q5D8e98kSEfuarQoTmqMSytpyVhCK5?=
 =?us-ascii?Q?ignlzHybfKK4J97LJQS2Eww0kvp7aPWLg+fS+KjKfxiXJDNJe9JfDjY16V3t?=
 =?us-ascii?Q?GdYHlRpVoLXHdBnuyuSIab7SNIGrx0Ueu51J5LVH9ShG/6Z/0zZ4c1tivMOQ?=
 =?us-ascii?Q?hvY2tXmjZV3Ze6aTqfXCz2pUuPwTMHBUgdu1TDcV2lL5Mg07Xufy57YeJn22?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3552c42b-f116-4350-ba55-08dc5d12ed3b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 06:11:45.1959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JShzXQB0IMFXyynpwL/ch6Z2Ibc+8aFYEpMeTWP6DRsRv9bra84S+hIboSZROCCrJxwm0vZ/dVctwwfODiEAhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4709
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kunit.VCAP_API_DebugFS_Testsuite.vcap_api_show_admin_raw_test.fail" on:

commit: 93533996100c60ea6d4342c454752c0eb1e4b6b1 ("kunit: Handle test faults")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 9ed46da14b9b9b2ad4edb3b0c545b6dbe5c00d39]

in testcase: kunit
version: 
with following parameters:

	group: group-03



compiler: gcc-13
test machine: 16 threads 1 sockets Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz (Broadwell-DE) with 48G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404151340.5b152d96-lkp@intel.com



[  206.153880][ T2978]     # vcap_api_show_admin_raw_test: EXPECTATION FAILED at drivers/net/ethernet/microchip/vcap/vcap_api_debugfs_kunit.c:377
[  206.153880][ T2978]     Expected test_expected == test_pr_buffer[0], but
[  206.153880][ T2978]         test_expected == "  addr: 786, X6 rule, keysets: VCAP_KFS_MAC_ETYPE
[  206.153880][ T2978] "
[  206.153880][ T2978]         test_pr_buffer[0] == ""
[  206.159902][    T1]     not ok 2 vcap_api_show_admin_raw_test



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240415/202404151340.5b152d96-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


