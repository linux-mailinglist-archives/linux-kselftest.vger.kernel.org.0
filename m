Return-Path: <linux-kselftest+bounces-1126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1B6804CE7
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 09:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA0F21F212C9
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 08:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4523BB21;
	Tue,  5 Dec 2023 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PBbkCk7L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C12C9;
	Tue,  5 Dec 2023 00:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701766097; x=1733302097;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=bnbNnlzHmH9M6Grkk65o+a2fL0+dR8NLyQsmUSZYslU=;
  b=PBbkCk7LqqtGbCTaiKf7lMQxwObPbDtcBjKC1LfOJQmP58PQNnkHU2JL
   JjJtIgQbs7EDwr4Qz7HwvLP0Z/Fjnl91y+lYAuPVbE9fv3FY1yXWHNCdP
   gCde/KuBniMrWYLLOl5IEGL5UFYf9RRnyc8ffUt7Q5zotqvOOpAbdfXsk
   +biRGmkLOyVU9G3c4zYnTJsimJBYtLxVehRvCkpFRHBWPHWxfnmKtN87C
   c4PTgTzm1vcqvCtxM/lKBfvAJqSsanlCeEOkYSz5Gv0BHDEMN8Ihc4T5v
   1nL7F31waw9oOHAARNlKvBOIbolPVWK2IxY5biVLj5RZnw49hsuJTZlZi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="384262557"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="384262557"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 00:48:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="944183498"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="944183498"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 00:48:17 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 00:48:16 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 00:48:16 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Dec 2023 00:48:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkDeZWt6FvLbsktTOrIfA/QFUQA0+ra8tZH7SaayK9jLVMhuitdAgy6uGCEUABRHcLNLckmZ2mr7ub1yglDrp3ZQIeT4lUGBARt4IWZS+xwWkC2tmEU/uV/VFpMcuLIyQCUIKuLmZMq2sAx8w0no0wrev9WSqLLdUTU2/UkkjkrEBeTWhrjjCaNrylzbJfTemuG92kY+H9ZXX58DhXut7naHc7zs1dGwwajP7vWWG5/wyzpZO+gtKZ6tbH7Q6/b0Tce3Jh/DMOmUXY8TFdET29EzFwX8pSa/4IWY65th6CvHWLJQOjQWchZA9Wo422DvkPWb8Lct5qaPrVlo0QBRQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hf02N7zSt/cb4/ZnTSE+6+d3Q9B2hzdF1U33vDmTP0E=;
 b=dry8tV2WUm4F3R1Im+e5P1WTf9qBXCgdA7h/7kqaRwNc5jXs8I2t7N/97cR1CxQhV4GT0m9JvE2qy3rB6XHihNB991ITZUA/8ZBhA/H+IgDoMLSS0876veETfRXnP2XNJGPV3CBhQ04dqo7jhHv/v/8l6M+xVU23FOujMjsLpng1cgEZQcDor+xkIb2zbqsCvHHeVgSOySmRUioXePIHRvWAn9mBHiGtO/qCG2yziYJSHylXq7nM+tkcWH7a3h3xNSxFdeRZ3/pXR+1DwkXMA6/BaWzH3WeX7lGQQPPZMc2rMD0s1ZgqziQFv7LtYs/ubp8aSEWf6d5D7MWjrDDlVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB8161.namprd11.prod.outlook.com (2603:10b6:8:164::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Tue, 5 Dec
 2023 08:48:11 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 08:48:11 +0000
Date: Tue, 5 Dec 2023 16:48:02 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Hengqi Chen <hengqi.chen@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<keescook@chromium.org>, <luto@amacapital.net>, <wad@chromium.org>,
	<alexyonghe@tencent.com>, <hengqi.chen@gmail.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v3 3/3] selftests/seccomp: Test seccomp filter load and
 attach
Message-ID: <202312051652.ecd5fbc7-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231129053440.41522-4-hengqi.chen@gmail.com>
X-ClientProxiedBy: SG2PR06CA0244.apcprd06.prod.outlook.com
 (2603:1096:4:ac::28) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB8161:EE_
X-MS-Office365-Filtering-Correlation-Id: cb4695c1-a25c-4946-6538-08dbf56ee972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 25T2lWyO68mxWdPGa0fF/qBoBNRLF0OdRFjO/YcQa/n2EX5IhjESblrZJg75IbIXroP2qqYuAsmYDWTncRZid56DGbJm3+DF1gSK13Xe31kPRc4Qv7BK74u/EvC+Xvc3wZ3g4c2KG5Ezat9SpmhEE8VgLl2VXj2D50TYwqQQ1knXfJ4oCqk4/yC9wTXjPHn6joE4+08trC42n5I2h6B48fkYd7UEUNiTE+CG11kbfXTiHZZgGMf8+yJ8a3QPBKLOuvw9PKge8XF+KCmxerriuDNC+sqZ5mRO18yEhSJboFwtbmMscPox/EMM/QxY7RB9JySPnaeCZZc/63boaUjvoANTAEuKs9eveYHawjiu7gcKkY0y6iroIQ8IEHQIee8Bg5xFm+wYE3Jr24Bxv2gNdmJXrzKMCsxN+zyTLRBjWzugUiBro4OYnLSmSc/TDDBGPKiQ2whYEChKmByOFHtJttqz4oUhgqYK7ovrUiABDMOuNV80EZIsUwVpwZgzL6COugjNey6rey78wWtnDMcVHUnspvfQ/kfOPWQfKmCoEkdAmWGoBStVxptgx9poWszVkRDS1yM+aDj04DK1nc6fkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(5660300002)(4326008)(86362001)(2906002)(8676002)(8936002)(41300700001)(6512007)(36756003)(107886003)(2616005)(1076003)(6506007)(82960400001)(83380400001)(6486002)(966005)(478600001)(26005)(6666004)(38100700002)(316002)(6916009)(66556008)(66476007)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I5g2MpooBkXN18Il5/eT/lw3Sj9iMWmr8hKBE+wKzaT78f+muLqTYTXJnmiC?=
 =?us-ascii?Q?zO7rKhdHGKWCsEyFZyJxlwCQI8eacejryJ9N1pKwUFugA5LUKfyDPpAoVmWo?=
 =?us-ascii?Q?nexr1nHTJ6aR7rnp1c0ekh0Hbrbqp0IOcVXTjKyQc/eTV74AR5QsmuPgkuIy?=
 =?us-ascii?Q?sBraie3nasQhf0k21+i5Y3en1LYTuQ5te5+F+4wrDmN7QA9SDjSuO+6FsCjL?=
 =?us-ascii?Q?9y5aFqlSvjuEExIPKNZi/YlOd6WIeCVOMuhocXuCPtP8X/+IFgfBIbfrRku0?=
 =?us-ascii?Q?sNSA1Ak8E3tf+43yIoVwD/24+kTUkgv+XyDFkXwakxOv71yzV7RfZkVN5+KT?=
 =?us-ascii?Q?uduum8XyRN/znMpMRUBVyi6BUhefBD1akKoi1nj7Ua1moP38cIBHS0ugdJnh?=
 =?us-ascii?Q?/XyWcnNwtG57Exo2Zi6idI1uzWXzmTkYrHEwPhu9gnbueP2faHKs7RjoljKd?=
 =?us-ascii?Q?Xhf4BoDkbHENH48M209LM5ckS5u984k+GoaImalGfdrA6LpXPddPCZ0OkJxD?=
 =?us-ascii?Q?xVadCwkR35Dt4GTP+jfMte0l6voxFL5fHYGBtdiezZdgxF1qKgQSYcWRpaAW?=
 =?us-ascii?Q?3uiMgnDGMIYQXsLMrCHumCYOV+aetFRbX7kMJlmmOKaOfROsytlsQg8Ge+y5?=
 =?us-ascii?Q?H9PM0X0kleX+LWY/8LXGsIyemQ05NvsjY5iU7R2qIqpkzTVkfN2dUiCjsaP8?=
 =?us-ascii?Q?x5xDJgLxuwCsKNJWdGnXivW42XgUbcRNl/0GZt7H6sUIftwbkdW0Jn31uSg4?=
 =?us-ascii?Q?SSY2ngc6ve9BGxX/49zivb0jSOgJKkekQiCZFjBxb6yBRCls77Gz55AeqnaC?=
 =?us-ascii?Q?AHxjFpLULXsHSpV/vImrT2+IzGetIxPT8vk/s0Kk/CS5a407Tmis0p1UGrIu?=
 =?us-ascii?Q?NP08u0G3qQR6A5ERHTImCnlDnWtPQC6DIIosmsuZ45YxZND5gFz0Ou614Vq3?=
 =?us-ascii?Q?qVl704dR0ga8Bz5fsYhc+LTXbkYcIeV4yOTaKTAC+x/7cF6GU95BeXT/gwtM?=
 =?us-ascii?Q?lacSH4oUD2TH0bkK02NWisBlHNSeQ9R852Y76aV/kZsAt30NWZg88K6ZTvpx?=
 =?us-ascii?Q?1lc/qyAfl9iGl2iE4AL/ks11e2yXyn2wfCc3DzX0GFUCLu/UwpogJC39swWP?=
 =?us-ascii?Q?CkchoEFFD9kg2g/wAzHtv1XkHlUZid66zpl9qpEgf8oSi1V+NL/v+AFsT6Te?=
 =?us-ascii?Q?ebr4LKXtSHqE6/HenKtbyrQwrVcl9EyfBaQAGIN7VCU+oWEkVqE1CcQfH88W?=
 =?us-ascii?Q?MoRfGb7+3fcE1MrpvbzC4aLVMajm+/SX17xXX6q7DGWeOmWPPQcl8qTqfKXK?=
 =?us-ascii?Q?3PHv8UwBSYlzDfiDMaHPj5hzONB+A5jYMcPXexxQSs2NH6Rku5pxKnrJ6Iyn?=
 =?us-ascii?Q?6Zw3Xvqyt8pfFnlaHlGnV6/gZuXxItwwN2K/4/XUMp7tCcVSf1i+oaLFeXfZ?=
 =?us-ascii?Q?hh6pOPHrKtQO6ZwE7sqFuGarAVQsCVX5aXtNkXT5z75nFryagIOpgjmwez/L?=
 =?us-ascii?Q?GnV9urLfATPOkFgRW13YqUOVci42gQTLuM53yPP3Fqxha9aHhNotLUpp6dju?=
 =?us-ascii?Q?hvGnm19m68RyrVX4ImjPxLhT3iVmgFnvgqVMniDXOOgNpM2UGfJo8rc5AoFU?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4695c1-a25c-4946-6538-08dbf56ee972
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 08:48:11.5793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufqB/ewdRSgWzauvmzDNZJzAKzrgn28fpV8QXH7Ys8LH2LhJlmO8XJrdTyHg9evCJdTgJwbTVDWIuoU6/U8lEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8161
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.seccomp.seccomp_bpf.fail" on:

commit: 95084d9b2b5f0b593724819288f3cb4e2c585cb0 ("[PATCH v3 3/3] selftests/seccomp: Test seccomp filter load and attach")
url: https://github.com/intel-lab-lkp/linux/commits/Hengqi-Chen/seccomp-Introduce-SECCOMP_LOAD_FILTER-operation/20231129-134337
base: https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git for-next/seccomp
patch link: https://lore.kernel.org/all/20231129053440.41522-4-hengqi.chen@gmail.com/
patch subject: [PATCH v3 3/3] selftests/seccomp: Test seccomp filter load and attach

in testcase: kernel-selftests
version: kernel-selftests-x86_64-60acb023-1_20230329
with following parameters:

	group: group-s



compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202312051652.ecd5fbc7-oliver.sang@intel.com


we noticed one test added in this commit can pass, but another will fail.


# #  RUN           global.seccomp_filter_load_and_attach ...
# #            OK  global.seccomp_filter_load_and_attach
# ok 56 global.seccomp_filter_load_and_attach
# #  RUN           global.seccomp_attach_fd_failed ...
# # seccomp_bpf.c:4792:seccomp_attach_fd_failed:Expected errno (22) == EFAULT (14)
# # seccomp_attach_fd_failed: Test terminated by assertion
# #          FAIL  global.seccomp_attach_fd_failed
# not ok 57 global.seccomp_attach_fd_failed

...

# # FAILED: 97 / 98 tests passed.
# # Totals: pass:97 fail:1 xfail:0 xpass:0 skip:0 error:0
not ok 1 selftests: seccomp: seccomp_bpf # exit=1


we applied the patch set upon 31c65705a8cfa like below:

95084d9b2b5f0 (linux-review/Hengqi-Chen/seccomp-Introduce-SECCOMP_LOAD_FILTER-operation/20231129-134337) selftests/seccomp: Test seccomp filter load and attach
8fcda1c36e519 seccomp: Introduce new flag SECCOMP_FILTER_FLAG_FILTER_FD
bd86f21cfe1e0 seccomp: Introduce SECCOMP_LOAD_FILTER operation
31c65705a8cfa (kees/for-next/seccomp, kees/for-linus/seccomp) perf/benchmark: fix seccomp_unotify benchmark for 32-bit
ce9ecca0238b1 (tag: v6.6-rc2, hyperv/hyperv-next) Linux 6.6-rc2


not sure if this is the correct base, or is there any other dependency to run
new test seccomp_attach_fd_failed?


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231205/202312051652.ecd5fbc7-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


