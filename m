Return-Path: <linux-kselftest+bounces-6822-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 873998911B6
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 03:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C1F1C246F0
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 02:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537C633070;
	Fri, 29 Mar 2024 02:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qi5/uoF/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F571C691;
	Fri, 29 Mar 2024 02:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711680189; cv=fail; b=YIujUwBKLHotGIx/JWiIbT+NtyrKKLTAw9PIYZ6v2KUly15+NMzMyeO0YXUtH2j6EuW4GbDMD+VL7yBjR0w8rmLJHaYJVs3tLZAuJ3728acRY0kle49b2AmAxaTsR0D1/qGPyYW4zpfCxVQ6IYXJca8JgGeFIPAqWh3Fo/r5os8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711680189; c=relaxed/simple;
	bh=xPsUM2eGtelz6uETpbh7bkTi9YMrj2Jo20fvTvdjpiw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=o/kPTbMIjITZ21XL306nJsBsUZiAkgKay+KgAstFbjgoXhdj+l/igzFYyCU/OMMRQfDVeuyH085yGxEWiVhafMk2gnoPkmrixy/nfgHzEEsoOLl5G5w4nfur2/4BfPA11Eep1coUQR8VEqHIShujoif8yHkCGwnV94V5pVgHQZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qi5/uoF/; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711680187; x=1743216187;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xPsUM2eGtelz6uETpbh7bkTi9YMrj2Jo20fvTvdjpiw=;
  b=Qi5/uoF/r6YsNKZefJUEzV+qjjQ3BGSvr4nWD63jHqJVDI792h9lWQbn
   feoggCsAjfLpblBJbUpYDzXBGWGzeTROG04fZh5WS/rZ6zabq3Y5OqMWA
   emso2arY+5tJuI/iBGLzbAquUx5uDizDedBzbvXrSMqr8HHKbQcEKww8l
   snjuC9zBEMVwy7sD2XxshiiGNU27cESwvHvrPLRTcbxWl5hQ70NwkVpeM
   J30PbGjhzqxMZyviQUr4ySorFoi7pZ1/wrLsvC6yFnZY3ou2L0nFOLMQ0
   UMlOGaOYO9vJW7mLe+aGlN/pxhQXTRCz8RB0RESLPxs0P2vkR9N2hjRJh
   A==;
X-CSE-ConnectionGUID: XngZ92GMQtGDbD3INqe8dg==
X-CSE-MsgGUID: RVsbUseWTX2uv2XLjrzDjA==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="10671217"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="10671217"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 19:43:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="16808812"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Mar 2024 19:43:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 19:43:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 19:43:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 19:43:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 19:43:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/SG+t76nDPlMdKGOV1M5nc3xDS5VQRrTQYFjHu4NY85gI8dxRKfwXxLayF3lxjXVFouL6QIkKkc2wh4QH4Igt1uqP0LI+AqaKROyzBTF1ikc/H7RyiVfSYrSw+25lMB4xCSZRMGJ5rUvvzcFZaH12+NwgqMLkjRet/SMo2gQoZBJIESGvYc0SLVwlcgDVhVQSkCqo/Ls3zWcrf7X0+sEc3jZ5leBiQcTm4+ObLLyVp1lPD+Zd/87dmaHaXn8wIBx+3VP9YYp5h1WaUUCuhMbqma97HDkpaSSv/TOUSL7YQy/c/VaZbcu1cCZoWOD7D9n27em0D4nRdBIF9Gas+tOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kt+FO5SozjCYlJahjvba7azpiF0n0F/nmL82Bjtx7Qk=;
 b=BGxsF0xAvg88ql8kM9DH8VieA70uLlm/XfqnJtpIniYz5q0tzMeSLxapuD8m0BiN+Xi2InMV05GjYKYYC8F+uVxbfsIOur5qAl8a9IayQI9sbguCKpoqdlOATw6gru3qXraRm2GMy/iu2KUiceQHnk1bDUUpK/7ASMUOgVSCT/XhRm0phg8scD9j1Z3J/e3NEp7zOTn4dnNIdGqk+bKDggBbgGuFLpJftKUEO+xhEUyMvx9CPzwa+SJagM2szMHavK0PIpsSDMs4yEHdQmgDqeaHcQMn/3eubeoa5Ct4sQXxI+O35fcI1/JAmQMJ7zp/hIZLAuiOL8WfJrZHzvvnzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW4PR11MB6714.namprd11.prod.outlook.com (2603:10b6:303:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 02:43:02 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7409.031; Fri, 29 Mar 2024
 02:43:01 +0000
Date: Fri, 29 Mar 2024 10:42:51 +0800
From: kernel test robot <oliver.sang@intel.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>, =?iso-8859-1?Q?G=FCnther?= Noack
	<gnoack@google.com>, Shuah Khan <shuah@kernel.org>, Will Drewry
	<wad@chromium.org>, Kees Cook <keescook@chromium.org>, Jakub Kicinski
	<kuba@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [selftests/harness]  0710a1a73f:
 kernel-selftests.pidfd.pidfd_setns_test.fail
Message-ID: <202403291015.1fcfa957-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR06CA0213.apcprd06.prod.outlook.com
 (2603:1096:4:68::21) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW4PR11MB6714:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vmtGMTr6Xwn9Ep/6Cc7uUomAIoWrf9XAVlR0NA2hDEq8BV/Hn5qGDi/HHX5RC/Ley4wiF4mVByOQWZ0HQdAckN8lri2iYFhdPfSMkm/RcGUUXc+NB6nLfPLJ5RT0sDaq6VqWpuOFgGle2DauF6WTQUibJ9IBhoZB897mnBv2rUyhyfygFH/h+5RYiun69Zwh8x2ngrH8U77vXo/tz6G+7F0cabwEMWt5CePYmjr7ihsvQHIt8ZTb3Okln6MhkB2eoWm/rgWLSLakJCL8ywq+Xt5o6KSmF6nI/W7+rBT5XMUOU6wXUxSu4foBUwi9lF5U+Zz83KjKJmINPeYZ9AxUJh+ZQkuQvLYP7RukHd4l0O/2lZfLnmq05GsvTLgzkZcXbB7FDAlz/ovDHbDU8DLt8V+p0VjwPH9G35j4YAsnRylXWop3s0Yst4o4wNALslrJF4HrxF3kknN6/UE0YRkDAg3X2/FuqBFQeviAQhuj4MvQX1gjq3uKATVLXAhadtMk65fcCaSL0ZXRxXc/tGR3ENw8Bsht5TU+aADY28Gi8OtElXeF/v6uLKudB/CPHO+aSsbxFf0cIFpsL71A/m/Nich8FnXOFkb2N0YEbSfMCaN0CufXpQXb/IEVR0LVXX6S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y2ZYMm5prznj/nWejske8FqZjnlQ8KD3qSbO+68V7gbe2D15fskTIegDKpcI?=
 =?us-ascii?Q?2SHrfFCB8oeisbPG+uB+v6m9y0In713LNTtUYNJrZTAvOonSuY6pJ4QqNxVe?=
 =?us-ascii?Q?sQddxzPx4NhEoH3lveti/nPxxeyxMtwmLW9f9C2qkYPgLTd8Wb0AWuPhoNko?=
 =?us-ascii?Q?XPJGozX7gD0PIEWbKyydPMUVCAvxY/P8cgaX8je9RBvaeQXefbgd2HrKda3P?=
 =?us-ascii?Q?AymbMHVRhOXEAr7HEV+Yzse/RUOE/La0MFYZJpoBeQQN3h2T9A+9ip1TTLLX?=
 =?us-ascii?Q?T8jqRZLK22uTtB7TMnCmIWUp6R4t/YsKSzeA5LPo9g3pYGoum92dC2SU1ILV?=
 =?us-ascii?Q?8tEvl/si3GxJRt1mZLk/t6cz0ii1YtzwgBQnOfewvXrg8VzbhY575eH4r082?=
 =?us-ascii?Q?Qjg8HdWHDg3+wSvMfrg0ugYqGDcIq2eLnhlGSmt4o+0gAw6Ry0LfyOOa3KWg?=
 =?us-ascii?Q?qzIn/cpeYrTtGOVcLewp/pNuXVY6sK+KWNjTjz6YhX+iCjaB3gn+NNWr9oT0?=
 =?us-ascii?Q?ptIEWYVZBqJ7TGAqlblmtIsqvuzOMp+Qu2/hx35zTpxTsHAmP8cTya66R4ix?=
 =?us-ascii?Q?wvVGF4gxT2+5Ai/nKPqBQ8zpb0SFaoOc9KBrne16OnyH25kRhQMKKNV8hsRp?=
 =?us-ascii?Q?/Ug3Cs8EsUN4G/Xc/mK13eTnZj3R/qw3+QMB73g+QJMhJ0VMajInbJCbCLPD?=
 =?us-ascii?Q?D9zsvKrEIC8aP29ojBmGUu7EvIfY8+wu/xi2P+kPmdC64iEgm24okCrLvaXr?=
 =?us-ascii?Q?G/zem3AQjiHAajFhobr88Xt6A7yaqsndDZtYVlEd1bIp7/3PYStt658XhEwP?=
 =?us-ascii?Q?BJu/5iBWzwbweKhloeiAVkPeNnZa9IHMtmPkrxWlaNLxwfUhmo/h6S2Qrhei?=
 =?us-ascii?Q?J1lqmxbDZljdCeq4wtO/ccB2PMoVamls0xbtsZljp2Otg7i6w5FNFj+tInLN?=
 =?us-ascii?Q?+UNUlUUwJm1jczaiPa6tPTn31rC17h4zR2Q6wEHhapbSDHApA4K1epdvnOeq?=
 =?us-ascii?Q?hKVBm8AO9J7jZ822Uq3nlofQu9FirmN61wSYryLYVZf9eWY7XZwiOfq+UZ9g?=
 =?us-ascii?Q?1l3jQl7ZqCKRr+8pKI5E8LUi5laF8GOfOVz5HDvYFZZnQuwQUIpejvSdkUtb?=
 =?us-ascii?Q?7exyz9OccQ0ySWw+6eKkte96HeOTCGZfTztTJF6MkC2ke/r3ix0nx7gM4u0j?=
 =?us-ascii?Q?aT1YjRsxAATvDkm8TVhKItlPlHE0Jai4ktRFitqZZ99h1XmsApninUA+U4yr?=
 =?us-ascii?Q?rxLS7FSlrFTmKvkJnFIobQf+L3skaEY3L0wRpRXlDok8S1D4mvp5/TfPNAAy?=
 =?us-ascii?Q?1QPOEUyxyT17d1XRxn0s2My7MjT75oddaaRHJapDniPbDOrXJF9LU6SZJTRy?=
 =?us-ascii?Q?Hpxheg/LYFfjm4AQu01z5wm0kVrSF4R/c9US4FnZMIOwhV25ZBLMDVa4L5jR?=
 =?us-ascii?Q?9+V0S1zzDPHcl4zSEECGiAR3Um1woufvy7PCbblnQyC18kH8Ab1NMau0BmYs?=
 =?us-ascii?Q?XTpHT7G5OWiup+n7WdIhkAfjVYIvf/wo3gVbnxBQy5FJsR6yvXbCYEOwUCZ9?=
 =?us-ascii?Q?6ALxPnQBgBcL8d4ivgxTHsg3LvAJ6++w4hmxhjrn/k4lt7wBY9NgxCfzXCbu?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4634e923-7739-4ae1-37d0-08dc4f99f336
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 02:43:01.1677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bjGeTQr9UQ51L5fZsSGu+ySDx4pzljbYmv/iFBs9035EatLWYiDegraoyZjK68FeLHGVBcgTTBLMlp8jonTNOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6714
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.pidfd.pidfd_setns_test.fail" on:

commit: 0710a1a73fb45033ebb06073e374ab7d44a05f15 ("selftests/harness: Merge TEST_F_FORK() into TEST_F()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 4cece764965020c22cff7665b18a012006359095]

in testcase: kernel-selftests
version: kernel-selftests-x86_64-4306b286-1_20240301
with following parameters:

	group: pidfd



compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202403291015.1fcfa957-oliver.sang@intel.com



# timeout set to 300
# selftests: pidfd: pidfd_setns_test
# TAP version 13
# 1..7
# # Starting 7 tests from 2 test cases.
# #  RUN           global.setns_einval ...
# #            OK  global.setns_einval
# ok 1 global.setns_einval
# #  RUN           current_nsset.invalid_flags ...
# # pidfd_setns_test.c:161:invalid_flags:Expected self->child_pid_exited (0) > 0 (0)
# #            OK  current_nsset.invalid_flags
# ok 2 current_nsset.invalid_flags
# #  RUN           current_nsset.pidfd_exited_child ...
# # pidfd_setns_test.c:161:pidfd_exited_child:Expected self->child_pid_exited (0) > 0 (0)
# #            OK  current_nsset.pidfd_exited_child
# ok 3 current_nsset.pidfd_exited_child
# #  RUN           current_nsset.pidfd_incremental_setns ...
# # pidfd_setns_test.c:161:pidfd_incremental_setns:Expected self->child_pid_exited (0) > 0 (0)
# # pidfd_setns_test.c:408:pidfd_incremental_setns:Managed to correctly setns to user namespace of 45423 via pidfd 20
# # pidfd_setns_test.c:408:pidfd_incremental_setns:Managed to correctly setns to mnt namespace of 45423 via pidfd 20
# # pidfd_setns_test.c:408:pidfd_incremental_setns:Managed to correctly setns to pid namespace of 45423 via pidfd 20
# # pidfd_setns_test.c:408:pidfd_incremental_setns:Managed to correctly setns to uts namespace of 45423 via pidfd 20
# # pidfd_setns_test.c:408:pidfd_incremental_setns:Managed to correctly setns to ipc namespace of 45423 via pidfd 20
# # pidfd_setns_test.c:408:pidfd_incremental_setns:Managed to correctly setns to net namespace of 45423 via pidfd 20
# # pidfd_setns_test.c:408:pidfd_incremental_setns:Managed to correctly setns to cgroup namespace of 45423 via pidfd 20
# # pidfd_setns_test.c:408:pidfd_incremental_setns:Managed to correctly setns to pid_for_children namespace of 45423 via pidfd 20
# # pidfd_setns_test.c:391:pidfd_incremental_setns:Expected setns(self->child_pidfd1, info->flag) (-1) == 0 (0)
# # pidfd_setns_test.c:392:pidfd_incremental_setns:Too many users - Failed to setns to time namespace of 45423 via pidfd 20
# # pidfd_incremental_setns: Test terminated by timeout
# #          FAIL  current_nsset.pidfd_incremental_setns
# not ok 4 current_nsset.pidfd_incremental_setns
# #  RUN           current_nsset.nsfd_incremental_setns ...
# # pidfd_setns_test.c:161:nsfd_incremental_setns:Expected self->child_pid_exited (0) > 0 (0)
# # pidfd_setns_test.c:444:nsfd_incremental_setns:Managed to correctly setns to user namespace of 45524 via nsfd 19
# # pidfd_setns_test.c:444:nsfd_incremental_setns:Managed to correctly setns to mnt namespace of 45524 via nsfd 24
# # pidfd_setns_test.c:444:nsfd_incremental_setns:Managed to correctly setns to pid namespace of 45524 via nsfd 27
# # pidfd_setns_test.c:444:nsfd_incremental_setns:Managed to correctly setns to uts namespace of 45524 via nsfd 30
# # pidfd_setns_test.c:444:nsfd_incremental_setns:Managed to correctly setns to ipc namespace of 45524 via nsfd 33
# # pidfd_setns_test.c:444:nsfd_incremental_setns:Managed to correctly setns to net namespace of 45524 via nsfd 36
# # pidfd_setns_test.c:444:nsfd_incremental_setns:Managed to correctly setns to cgroup namespace of 45524 via nsfd 39
# # pidfd_setns_test.c:444:nsfd_incremental_setns:Managed to correctly setns to pid_for_children namespace of 45524 via nsfd 42
# # pidfd_setns_test.c:427:nsfd_incremental_setns:Expected setns(self->child_nsfds1[i], info->flag) (-1) == 0 (0)
# # pidfd_setns_test.c:428:nsfd_incremental_setns:Too many users - Failed to setns to time namespace of 45524 via nsfd 45
# # nsfd_incremental_setns: Test terminated by timeout
# #          FAIL  current_nsset.nsfd_incremental_setns
# not ok 5 current_nsset.nsfd_incremental_setns
# #  RUN           current_nsset.pidfd_one_shot_setns ...
# # pidfd_setns_test.c:161:pidfd_one_shot_setns:Expected self->child_pid_exited (0) > 0 (0)
# # pidfd_setns_test.c:462:pidfd_one_shot_setns:Adding user namespace of 45630 to list of namespaces to attach to
# # pidfd_setns_test.c:462:pidfd_one_shot_setns:Adding mnt namespace of 45630 to list of namespaces to attach to
# # pidfd_setns_test.c:462:pidfd_one_shot_setns:Adding pid namespace of 45630 to list of namespaces to attach to
# # pidfd_setns_test.c:462:pidfd_one_shot_setns:Adding uts namespace of 45630 to list of namespaces to attach to
# # pidfd_setns_test.c:462:pidfd_one_shot_setns:Adding ipc namespace of 45630 to list of namespaces to attach to
# # pidfd_setns_test.c:462:pidfd_one_shot_setns:Adding net namespace of 45630 to list of namespaces to attach to
# # pidfd_setns_test.c:462:pidfd_one_shot_setns:Adding cgroup namespace of 45630 to list of namespaces to attach to
# # pidfd_setns_test.c:462:pidfd_one_shot_setns:Adding pid_for_children namespace of 45630 to list of namespaces to attach to
# # pidfd_setns_test.c:462:pidfd_one_shot_setns:Adding time namespace of 45630 to list of namespaces to attach to
# # pidfd_setns_test.c:466:pidfd_one_shot_setns:Expected setns(self->child_pidfd1, flags) (-1) == 0 (0)
# # pidfd_setns_test.c:467:pidfd_one_shot_setns:Too many users - Failed to setns to namespaces of 45630
# # pidfd_one_shot_setns: Test terminated by timeout
# #          FAIL  current_nsset.pidfd_one_shot_setns
# not ok 6 current_nsset.pidfd_one_shot_setns
# #  RUN           current_nsset.no_foul_play ...
# # pidfd_setns_test.c:161:no_foul_play:Expected self->child_pid_exited (0) > 0 (0)
# # pidfd_setns_test.c:506:no_foul_play:Adding user namespace of 45737 to list of namespaces to attach to
# # pidfd_setns_test.c:506:no_foul_play:Adding mnt namespace of 45737 to list of namespaces to attach to
# # pidfd_setns_test.c:506:no_foul_play:Adding pid namespace of 45737 to list of namespaces to attach to
# # pidfd_setns_test.c:506:no_foul_play:Adding uts namespace of 45737 to list of namespaces to attach to
# # pidfd_setns_test.c:506:no_foul_play:Adding ipc namespace of 45737 to list of namespaces to attach to
# # pidfd_setns_test.c:506:no_foul_play:Adding net namespace of 45737 to list of namespaces to attach to
# # pidfd_setns_test.c:506:no_foul_play:Adding cgroup namespace of 45737 to list of namespaces to attach to
# # pidfd_setns_test.c:506:no_foul_play:Adding time namespace of 45737 to list of namespaces to attach to
# # pidfd_setns_test.c:510:no_foul_play:Expected setns(self->child_pidfd1, flags) (-1) == 0 (0)
# # pidfd_setns_test.c:511:no_foul_play:Too many users - Failed to setns to namespaces of 45737 vid pidfd 20
# # no_foul_play: Test terminated by timeout
# #          FAIL  current_nsset.no_foul_play
# not ok 7 current_nsset.no_foul_play
# # FAILED: 3 / 7 tests passed.
# # Totals: pass:3 fail:4 xfail:0 xpass:0 skip:0 error:0
not ok 7 selftests: pidfd: pidfd_setns_test # exit=1
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-0710a1a73fb45033ebb06073e374ab7d44a05f15/tools/testing/selftests/pidfd'



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240329/202403291015.1fcfa957-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


