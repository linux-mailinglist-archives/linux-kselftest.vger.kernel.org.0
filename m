Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED597D7D6B
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 09:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjJZHMA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 03:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZHMA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 03:12:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6FB18D
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Oct 2023 00:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698304318; x=1729840318;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JbVWIM1g9pp4BFkUQ1iurVKsSeHdpO8zBGdwLfHgE7c=;
  b=RwPID3BazzIVNOufRRmokHfYdUDafOg9w1+D1QzoEXVLk8vKynwv/TyJ
   bNTBwXUthL2taiU8vV8z7gM5kSIPBzfLFS4Q+ilmw7/paowLFEOZyUHna
   wgEMoVwYKxylZnu95D7R4sXwx6SLLrEYwSYdeIS7dYXUQ0TTm3uAV15PE
   3Aft78KRRIUHi+lbVfCo6OJWI9vKcywvZYQHieUg5HcSQJcXUtlXKhohN
   yVuChtbOOFjES4hJcmR7erqqBqVh4woL4VzeRFOjzqsTa7bbF5jeE7sa3
   TLLRyBXLO1z2sJu9nxIhqFctdY33nzpMZGEN8xKniryBHhBU9aIbVYzrm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="9034462"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="9034462"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 00:11:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="794103732"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="794103732"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 00:11:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 00:11:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 00:11:33 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 26 Oct 2023 00:11:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COW53BHsUCs8sFJb1dgak52yopVq3pGI+nrJ6Kg86g0WhptRqiFcKHN4XLHcYnzRHs2iBocE/Xsz5K3lyAcR/+oizURhPKv8kFZOsBgF1DuTa78RiwasCNcMyEsyyMFYawlR4/UmzlmsH94gb26FiRLsS/yXNnCdkT/EPwwXj603Ry6KF8MU2g1GWtB2Q4dKTsMmGCrjcp4O15Xdo/uBbgrS8NtC+Zf8MnR8rMYpvr8Mle03F25IfYRv7+ACDDuL+m+SI3fEktKULWpSpq2JgP1vQ39TokNknw6KcpsezsqB+M90+fMvKLAWoygg7Quql3RrBpg97TOqChPAIKxhwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k99rPRyD54mwgZNh6sD5LTEUN9bV5d27xNtdjLjShWA=;
 b=JeqXr75dvQK4+ksuMoRtaspaUe5b5AFS7yvnZc/g/jb+MGCdZv65pHY8ZY1TibJbghxMgAH6s0V/QkmwNXoEakOb5/ntppf/mUNdKm0tVL2X3+myu/Yjh8Wre0VMBoANIi/3K3mM7NXlO/brZEStSfKpV86XGl5uj6eCmylHkq+4kf0vX8daV31pmcBeDCsUFStb4dUTkaYZTvwrHsPBz07Bmcen1UgxGMwQsttNTQYchJbrR9k+FV/dluLFMkqDbhZmQh+q6Xgf9DUUsdqF0IJg19Q8KgEQmaXwPARg3wChRZKdM5vxqza5vcIoPZJOWdoI3BXiFfFqav7qLyvT6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by CY8PR11MB7057.namprd11.prod.outlook.com (2603:10b6:930:53::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 07:11:26 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6%3]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 07:11:26 +0000
Date:   Thu, 26 Oct 2023 15:11:18 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Javier Carrasco <javier.carrasco.cruz@gmail.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [selftests]  5b45a75377:
 kernel-selftests.uevent.uevent_filtering.fail
Message-ID: <202310261454.46082aaa-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KL1PR01CA0079.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::19) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|CY8PR11MB7057:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a947508-9032-4765-f319-08dbd5f2c4eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GIqJGMENXAYRiB88rLHcmyaJFFJGhHb0Hq0VkeQYGWc567PyKk6m0JBxCif9SrpOg8a7rO0kP/labkYF5Rc6P02yAdTdXx6Ta6KeCldxjxdV8nHer8Tn9AOrAWIo4fGhjKb+HYqe+pIfxMcvupUE8nyxEtAaSZ5kB/KiCop519HIOFug8KHRGqjnxBKNWC6aQSm5uEM7K5QeIwQ/PMExhS30XcOisUgCakMBDhQBK0/v9nblgVrRf0sS/xesVncbFYdNPq9wQMXRbSxYxilvYRwis7uGbyrXMQob39y5bdroSg2NU4hCAK5hf7tzqp6SmQSx69Do+kfQjAFWAFeZC6to3K5YUNMwEvtPwXvRDGRESTXTlAqGh8g5qpDk53Ktw/QBoK6OlxY1SvnGrVjHCxFZfNDNXGLZrVuO3Wb28stB5M9N6S0I1251Upn50rJa43y3+KccnPG4ClFOi819IsQuACL940dF3ajpuPzEtIfghUn7Njx7baBXDoQIRi9CXeJgSNYxdElDE4tMMwoWSvYIoPcD31zlQ7m5DJvau+H74tfVfTbAEd+058LcZVfH3I4jFD2xfJqupFG6bAVWOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(86362001)(2906002)(38100700002)(6506007)(54906003)(41300700001)(6916009)(66946007)(316002)(66556008)(6666004)(107886003)(2616005)(1076003)(478600001)(6486002)(6512007)(966005)(66476007)(83380400001)(36756003)(5660300002)(82960400001)(8676002)(4326008)(8936002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ncnp4kxWZps6sQhY/4WwxSlMjRF7+TYT2MvteVJjEk+m6ApZ8g6S6TTqyrQY?=
 =?us-ascii?Q?ttUJpmrI+qiDDAKBepOD1zStCtGROfP7BS0o3CMDeKjgDdymtzvdhxDp2Y2A?=
 =?us-ascii?Q?9ToTDeeFjdT+yWYJEurlSDeFdcYc9tPlE89bpHOmDdZyXxW0AMhKatdcnWXH?=
 =?us-ascii?Q?neKVsX+16pZl7rIyaTWCeB7p8DOcAh+mtGFREyiypJGmyMwV+eowghm4C4NU?=
 =?us-ascii?Q?47HjzDMoFbJVoHPfGzZCbtSEKT9XMYXZeKVkYT9Tde+AfkwGy52Nkh7bgIQv?=
 =?us-ascii?Q?JfvgijWqvrjcNZu2AjUYzvE1fgNZY7ugrETdHb8DRFIwxvjYReH/v4piYbsW?=
 =?us-ascii?Q?OVNZ1wGYWLIM+gZzL6rG471+RqFHufzhF2ig8XSSm2xrKl9T6fBsA1XnjXdg?=
 =?us-ascii?Q?y5jaMiRiJVn6LRUGaS/ZuNd4y3g1Lid0Vhm3bo8M92G9ZsrO3NEGG46iEkU8?=
 =?us-ascii?Q?vgqAUoRRu1xgoGHaF97rR+SkpqnZsvoPgtB8XnesviVxghjvKIpBexhxtp7Q?=
 =?us-ascii?Q?SzHGLTsHC4x4FkIB85MCv/pw++0Cp5O+PVZ4KETQ9Mwb+UOte4MsBMf6uxr2?=
 =?us-ascii?Q?KkdBGpoFzY3pHUHmZLnjCEl0Brk6Yi/7bV0ZcaAWGwhR9eBVDQWzLnaN55Bo?=
 =?us-ascii?Q?eaVAT/qvf8YQ9Tp93NYLz6oMVS/ltOBopRVSjnPBzY9eFF4VhZ8uVenekXox?=
 =?us-ascii?Q?js8/WeYzHKpMFdXA1jL7VyR9VXSoMMfr+t55JnjRLpOi2hhtnx64pF8ySmdC?=
 =?us-ascii?Q?VmIlalgefffSLE1CXnc5YDFchvYdFWsJIQ0AujkQ9t5fm5g0hfjexzKf3j0i?=
 =?us-ascii?Q?t5ei4td+QNXR+VtaiT7Lf+n+TQ/Yu7haAbEZ0Op9gG06mcU4px5xPy0166qp?=
 =?us-ascii?Q?2xK3OkHr7eMPb740U/jIOAQ2eHsR8COWxlYVL0ffdrS1TeQQEq62shmUZGW4?=
 =?us-ascii?Q?T0Bx1+ZI+If7R39JScrNe8XaiBt8f0Cn3NLl7LfO9bHFq0ZPL2InVbwexK8z?=
 =?us-ascii?Q?mUWNX989N9phM9AEIevEY8raXKr6aoOTN45vvxKVQvUvcxA5vyFrf/vk0t/q?=
 =?us-ascii?Q?LVi7znuFDIk/c/tfw4kIbqmwC5V+a4JqfS1bRp0jtx9NJgpZA6+m8vkyihcv?=
 =?us-ascii?Q?Pg5hhIXIm2YV/a+U2+TFkfwLB25cLqD9GQwdHgI0knGr54POKguOUF/JKTlH?=
 =?us-ascii?Q?PZ9hPegCOxDjGAFUd+cvVA09KMdBNsFE9F56/YIzQtA10xybE+Z+WifAnLE4?=
 =?us-ascii?Q?9gS+U3DVTo+9S1oTXCE96atrU9/+Dv4R/Bv/By+tfbfCx8ZIf6KmJ8AVukEW?=
 =?us-ascii?Q?cwQ4Rx0ALmgAYJ5oamUBL4RF6CRHW1UyL3liKls1y5MmDrOGfIB4viuo7I/c?=
 =?us-ascii?Q?xFp2j18sMS+47boswgmBPpJwWIEXivWP4xWsTRQl99pMQgcoKq8AuBvC0VzM?=
 =?us-ascii?Q?7DwmuqMN8r5gvEkpmIbpASfJh4avxv3T6CA9reD90mkS1yeIJ/YC517synqI?=
 =?us-ascii?Q?NBjEe9FXmKHIsSzINn7LiM76VV6P6IbZZ8TacGhtAQHbdl3TkUfIaNoI/Y0k?=
 =?us-ascii?Q?e7bndqsakKj859oZlQDqaCLNN/wFNPVO41P6MfRdi03/QNAxlG0AaJjlxY+S?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a947508-9032-4765-f319-08dbd5f2c4eb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 07:11:26.6677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwlNbjrJd8vvDbD4ECX9K8fp7v3XdLLScYetieqjpwbIK5V/7D6Wjk3FBPxIIz+3Jwh1iDDRwXWdDInu2btc5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7057
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



Hello,

kernel test robot noticed "kernel-selftests.uevent.uevent_filtering.fail" on:

commit: 5b45a753776be5d21cf395ec97e81c9187fbeaca ("selftests: uevent filtering: fix return on error in uevent_listener")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 2030579113a1b1b5bfd7ff24c0852847836d8fd1]

in testcase: kernel-selftests
version: kernel-selftests-x86_64-60acb023-1_20230329
with following parameters:

	group: group-03



compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


we also noticed this issue does not always happen. as below, we saw 15 failures
out of 50 runs. however, parent keeps passing.


37013b557b7f39e6 5b45a753776be5d21cf395ec97e
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :50          30%          15:50    kernel-selftests.uevent.uevent_filtering.fail



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310261454.46082aaa-oliver.sang@intel.com



TAP version 13
1..1
# timeout set to 300
# selftests: uevent: uevent_filtering
# TAP version 13
# 1..1
# # Starting 1 tests from 1 test cases.
# #  RUN           global.uevent_filtering ...
# add@/devices/virtual/mem/fullACTION=addDEVPATH=/devices/virtual/mem/fullSUBSYSTEM=memSYNTH_UUID=0MAJOR=1MINOR=7DEVNAME=fullDEVMODE=0666SEQNUM=3532
# add@/devices/virtual/mem/fullACTION=addDEVPATH=/devices/virtual/mem/fullSUBSYSTEM=memSYNTH_UUID=0MAJOR=1MINOR=7DEVNAME=fullDEVMODE=0666SEQNUM=3546
# add@/devices/virtual/mem/fullACTION=addDEVPATH=/devices/virtual/mem/fullSUBSYSTEM=memSYNTH_UUID=0MAJOR=1MINOR=7DEVNAME=fullDEVMODE=0666SEQNUM=3556
# add@/devices/virtual/mem/fullACTION=addDEVPATH=/devices/virtual/mem/fullSUBSYSTEM=memSYNTH_UUID=0MAJOR=1MINOR=7DEVNAME=fullDEVMODE=0666SEQNUM=3585
# add@/devices/virtual/mem/fullACTION=addDEVPATH=/devices/virtual/mem/fullSUBSYSTEM=memSYNTH_UUID=0MAJOR=1MINOR=7DEVNAME=fullDEVMODE=0666SEQNUM=3595
# No buffer space available - Failed to receive uevent
# # uevent_filtering.c:479:uevent_filtering:Expected 0 (0) == ret (-1)
# # uevent_filtering: Test failed at step #10
# #          FAIL  global.uevent_filtering
# not ok 1 global.uevent_filtering
# # FAILED: 0 / 1 tests passed.
# # Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
not ok 1 selftests: uevent: uevent_filtering # exit=1



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231026/202310261454.46082aaa-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

