Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1981B7D972F
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 14:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345780AbjJ0MFg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 08:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345686AbjJ0MFf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 08:05:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF1D10A;
        Fri, 27 Oct 2023 05:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698408332; x=1729944332;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=BatFdEseDy9L1gzaIqxueoUIEACznbko3w1PG1UvQpI=;
  b=cqvT5R74e4xqISpF8msCkck6ULJoHkE1PRyuf6Ls5W9vJq8ShG+VLulW
   ti24rZcAmZuus0l2P6ERjpPbRlqy8bO2DJTV9tRQIEnLiygoRWXkPvbTq
   YbSYhumY2SjkWDmR25s2iynO4xaCJn4MDtrkGQtqKo4ZWxrWgP93QnLeE
   xdkBeXp5bUaC/JrhDG/6AOb6lQ5VYS0/JPWuMbHkv1exPmvqpBunZdyr9
   valFinDDo8oan//LRMbp5IfARof9uPhXzF1dAWX6ZMYdOf5qthxX5RmPB
   TZGNBhIswe+uscx4rLnk3wXSy1AoCbZbD/5oNblixKcbhKPUa9srPcMjP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="367972327"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="367972327"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 05:05:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="876317763"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="876317763"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 05:05:32 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 05:05:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 05:05:31 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 05:05:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 05:05:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRX1YSkW49afFiXakZ0O0IZWKFxSQdGi850AhT2ndXKCCZiXlKBbCYTCS/hFEiWKnSHDE/0XK6xKkvLOc85uBwTGpxHIAyHL2QTxoxHMBhJziPlSXC2djQyK6mCZ+sAWj8uufu70GU3GKylNPRphSgec0iHPyavE+OMA9y5bMA5YHax2RpT0g6n5QEXLdEQ23U84MmY+DeW8hCaERHhL5Txr6KCJgToEXQyLS7HWuEgkJdHkg4sNv1rjwfeKXqFd50F2gMISPwrjQMQRFw0zm01HqIVuCR2Ej+W0PKaqQ7eZgqcGl1Swwu8wKyQEMSOyPpU5saSe6iZwbQ5czM9pZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sy4MX/SFulLaFlAzH/zt+Y8HIONfrJYP2A7q0q6GRW4=;
 b=mE91Pt3h+DQvWxRlFIeS9MqE5cEy1r5jEhVLuV058CHEX1aBARzyRj+tgxR+Kfyf3Hu0SwkRAC1ZOw1/ZzoL2+pAxNtNTk2LmvzUWntfVJn9/GvcRhOPhwpRI8SjTsNwo3hVBIGZmmsOY9KXSep6I1kB278kSFfGOBZ2yZ87RHTcsX3GH7RxfFd8L2X2G/6wH5XXSV/f+saLn6zwTykzWMMdWna9ct5S9l8z+iGv2B4W/uyIgQniM+U18TrPo2Y3SaqVivz1BNZ5t+K3VAGGM5WKPwBJP3CvKXiTEb2zJencBlMc+Ds3glVfDwrQWrhZOwhS15R5gGgLdr47E8EMNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by LV8PR11MB8606.namprd11.prod.outlook.com (2603:10b6:408:1f7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Fri, 27 Oct
 2023 12:05:27 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 12:05:27 +0000
Date:   Fri, 27 Oct 2023 14:05:24 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-kselftest@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 16/24] selftests/resctrl: Rewrite Cache Allocation
 Technology (CAT) test
Message-ID: <kq6qds2hgcg3vlgokgyr4lukm7weuj3thvl7p2panfmk72ovpy@nshm6iva5wfr>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-17-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231024092634.7122-17-ilpo.jarvinen@linux.intel.com>
X-ClientProxiedBy: WA2P291CA0016.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::12) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|LV8PR11MB8606:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f536cf7-7c78-47a0-be16-08dbd6e50226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EZeiQDYABR+cAp1v/GXJvOB4+vHr25b3LfrU4KR18aKsr1Vss72e+Sgflxq+HAsQFoMGI7czY5AST2iDItVnai1OdZg9S+R34cCGgZmKIXEYpmHD8fJf7Di5UUoDmWF5bXumhMJSsOajbUGE9HFuL1W8GcF31mHTZQ0cb0h7oL0f7HPddQRAj2lzkw6g7g6VNXhgUjGBn2JCIwWcPIPQi4fqaroR2pr0u+XyJMxHwheTpOwvPqr5qQKtTcz3HPC49cESE2bWKH2QBt/gVutu7MyKqla7dVVMIKLsuKUly6PKEB+crLuHU8Mwxbqv6YThu8am2PQpR/CFzK6yODT+WO8iibzYWVAYtPdILF6ns8CtWewsagM4NwZBIxQQ7xfUDRXs0sxlYbqaP4ydUGygk36c6al4J0DnP6tk4aIf3DS562r+2Z01QYwQ5aGvlTLyEtvPzWW3jnzMIM4X8hHrfpJf5t0UX0/lqpomtd1KKVqUZus+Vp1CIWwd8GE0HKr3olHJBB0QItqvxLdCBoMMH2mOgo/hLCa3Wu+aZQ+sutpewpbtemaiSCwz+xETcISP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(4001150100001)(478600001)(83380400001)(6666004)(33716001)(86362001)(66574015)(8936002)(8676002)(5660300002)(9686003)(6512007)(38100700002)(4326008)(53546011)(26005)(41300700001)(6506007)(66476007)(316002)(6916009)(6486002)(82960400001)(2906002)(54906003)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ePLc1XFOqhCN2GZRzxxfS02psoRE6HMKtg+4GxOmy39rMUkm9uxhVAX3Ze?=
 =?iso-8859-1?Q?ZOHpK7xoQRkLRjY3R7VoRp6cTtzH7M3TUBE290M25UummPAzjPe1xmFIMO?=
 =?iso-8859-1?Q?cAsWebIV7f7y0E7VISstBv60GF11R9adxNlyh02JYEpxfsckWhyo3gcT99?=
 =?iso-8859-1?Q?W7e0MiRqkdYs/cXawtIxWDG9IZ71g1QoDBYxjiloZsOMmQruRvWE59k18u?=
 =?iso-8859-1?Q?tkykAm2EEBNokbHF8kVRrHAaIoBSKVm+LemPHdLMwRqOjLcvi9gShm30kb?=
 =?iso-8859-1?Q?7WnYW1sapyVpHplVwdKH7xeDOQy+6cIxXIoMIAR3sg7N5wzqREZE2pejPY?=
 =?iso-8859-1?Q?W5NcfCG8M4D0oPxF6WWRqtQn/VsXr86bzEznCea6ivVCUybNsRzEyWVtvJ?=
 =?iso-8859-1?Q?bxlBj+A9TX/1hQgjitcuUTBUgYO+qcrvZVjL9wQFpu2f3qCg2ea/h07E7E?=
 =?iso-8859-1?Q?pxHxdlfWhKu0yrgL8v++S36X7q8oIhDVlULItJSCn6qSBGFTtP5qXTJbXh?=
 =?iso-8859-1?Q?l3eCVJazkX0tQs8aFyyK/niesNA4TyFoWqK6Y5XPcKAMTycIrV6WNAin/x?=
 =?iso-8859-1?Q?nL9APfFvg3LwlqAGzoqYdPYAcs0/0Kcp3Xa7bK4PrCpaKwUCljs0+UsEcz?=
 =?iso-8859-1?Q?FtIUKdFZI+DDbqOfpR+8e/xCJIXSXlFwu936Lrn3Cz9v/xkSokYlhEzIw5?=
 =?iso-8859-1?Q?+mhX7KwIcsd5Rz9qWBwWpEmo1P90/aI0+x7wui6EZqKDEmbhqKKT9KvexE?=
 =?iso-8859-1?Q?InlBuKmQsxAmWdKR/vpveEUiLGBEa78MKVW5F2Ln3GtUbZs+V63qSKyAE4?=
 =?iso-8859-1?Q?DvxSMhxj73BZ18TnDqe6BP4xvuksOVkMYml3Is4kJjP/MXRfgmLUe0HJrI?=
 =?iso-8859-1?Q?wgmzXRebIJiux0s5Y0JS47V9LR+ehD0yejl0DQeo2Zg5BxNTEft8cphxg6?=
 =?iso-8859-1?Q?AGT/nnd5xAYSKikiRqCAwpHhIHnPgBbtoFnj+hdsc87Sd4eHWxXULQBY/0?=
 =?iso-8859-1?Q?EJ+No6pwc7ylPFJ0YekHuWKHtznWQ8SIn6pn3rDGR+Kf78R1ckWWvrWsKk?=
 =?iso-8859-1?Q?ErJk45O/NF7PUfvUtj3Gkqu84ZnjcG+hlHvy59I6fsSIFP3zz0lQrPS3MH?=
 =?iso-8859-1?Q?SFRF9l1zK62TBqazohb7T2yz5Foz32Td4N+QozxMwppLhLrWbG6E5x2O4H?=
 =?iso-8859-1?Q?SRY9wdLMWMya0nb0re42bKQf+oSk88ghjSG8+hxCsDITeayoRx71d1J5qx?=
 =?iso-8859-1?Q?Vl+SIzZhQst4F1IdJ0A+3mMbbOIRVF9umdDWcex5A8mL1jHG4GS3LIyxdK?=
 =?iso-8859-1?Q?q69WuqUIQ1TadlCbEw8LZLCKdOgieMmqmxmY5tIR8Ezw6Ef1tYf52HcZsn?=
 =?iso-8859-1?Q?zqElqRsPfcFW0HIGWTODPjcEgl9ZkkzFBzk+DbdaScStGkZxDlE+7F0k0h?=
 =?iso-8859-1?Q?Kc1SQclhapPfJhDRiJflS4SDzSku7xtam/ups3yQWU6hnr6iLFPlEo44HN?=
 =?iso-8859-1?Q?PdBwOED8F8XY3rtzrpt8paaSDuEAWKAZP1DGwZSb29J8SiaE3jcgGv0NEr?=
 =?iso-8859-1?Q?etz7Rs11gdJ2EAblR5FwVtt3mNS70cm42dOxi5WGHj+0fy8Yg1/pNmRBNt?=
 =?iso-8859-1?Q?iYoUoocGhY81SeK92S8URPW2groY2tObzl1lgAEICBtj/huWt7Wc5d01fU?=
 =?iso-8859-1?Q?+zgUnmShJC2uCfvdnSY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f536cf7-7c78-47a0-be16-08dbd6e50226
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 12:05:27.6768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fR5O5qCHW6h1JxWlfMfXlwDF5+EK6GaOhIEZmcxf93bB4+us7wdFmQ37eZcwCE+wS22FUKZJ29lMk30yU83gDJ4W8TepAYwPOemXy2myIrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8606
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

On 2023-10-24 at 12:26:26 +0300, Ilpo Järvinen wrote:
>CAT test spawns two processes into two different control groups with
>exclusive schemata. Both the processes alloc a buffer from memory
>matching their allocated LLC block size and flush the entire buffer out
>of caches. Since the processes are reading through the buffer only once
>during the measurement and initially all the buffer was flushed, the
>test isn't testing CAT.
>
>Rewrite the CAT test to allocate a buffer sized to half of LLC. Then
>perform a sequence of tests with different LLC alloc sizes starting
>from half of the CBM bits down to 1-bit CBM. Flush the buffer before
>each test and read the buffer twice. Observe the LLC misses on the
>second read through the buffer. As the allocated LLC block gets smaller
>and smaller, the LLC misses will become larger and larger giving a
>strong signal on CAT working properly.
>
>The new CAT test is using only a single process because it relies on
>measured effect against another run of itself rather than another
>process adding noise. The rest of the system is allocated the CBM bits
>not used by the CAT test to keep the test isolated.
>
>Replace count_bits() with count_contiguous_bits() to get the first bit
>position in order to be able to calculate masks based on it.
>
>This change has been tested with a number of systems from different
>generations.
>
>Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
>Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>---
> tools/testing/selftests/resctrl/cat_test.c  | 286 +++++++++-----------
> tools/testing/selftests/resctrl/fill_buf.c  |   6 +-
> tools/testing/selftests/resctrl/resctrl.h   |   5 +-
> tools/testing/selftests/resctrl/resctrlfs.c |  44 +--
> 4 files changed, 137 insertions(+), 204 deletions(-)
>
>diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
>index e71690a9bbb3..7518c520c5cc 100644
>--- a/tools/testing/selftests/resctrl/cat_test.c
>+++ b/tools/testing/selftests/resctrl/cat_test.c
>@@ -11,65 +11,68 @@
> #include "resctrl.h"
> #include <unistd.h>
> 
>-#define RESULT_FILE_NAME1	"result_cat1"
>-#define RESULT_FILE_NAME2	"result_cat2"
>+#define RESULT_FILE_NAME	"result_cat"
> #define NUM_OF_RUNS		5
>-#define MAX_DIFF_PERCENT	4
>-#define MAX_DIFF		1000000
> 
> /*
>- * Change schemata. Write schemata to specified
>- * con_mon grp, mon_grp in resctrl FS.
>- * Run 5 times in order to get average values.
>+ * Minimum difference in LLC misses between a test with n+1 bits CBM mask to
>+ * the test with n bits. With e.g. 5 vs 4 bits in the CBM mask, the minimum
>+ * difference must be at least MIN_DIFF_PERCENT_PER_BIT * (4 - 1) = 3 percent.
>+ *
>+ * The relationship between number of used CBM bits and difference in LLC
>+ * misses is not expected to be linear. With a small number of bits, the
>+ * margin is smaller than with larger number of bits. For selftest purposes,
>+ * however, linear approach is enough because ultimately only pass/fail
>+ * decision has to be made and distinction between strong and stronger
>+ * signal is irrelevant.
>  */
>-static int cat_setup(struct resctrl_val_param *p)
>-{
>-	char schemata[64];
>-	int ret = 0;
>-
>-	/* Run NUM_OF_RUNS times */
>-	if (p->num_of_runs >= NUM_OF_RUNS)
>-		return END_OF_TESTS;
>-
>-	if (p->num_of_runs == 0) {
>-		sprintf(schemata, "%lx", p->mask);
>-		ret = write_schemata(p->ctrlgrp, schemata, p->cpu_no,
>-				     p->resctrl_val);
>-	}
>-	p->num_of_runs++;
>-
>-	return ret;
>-}
>+#define MIN_DIFF_PERCENT_PER_BIT	1
> 
> static int show_results_info(__u64 sum_llc_val, int no_of_bits,
>-			     unsigned long cache_span, unsigned long max_diff,
>-			     unsigned long max_diff_percent, unsigned long num_of_runs,
>-			     bool platform)
>+			     unsigned long cache_span, long min_diff_percent,
>+			     unsigned long num_of_runs, bool platform,
>+			     __s64 *prev_avg_llc_val)
> {
> 	__u64 avg_llc_val = 0;
>-	float diff_percent;
>-	int ret;
>+	float avg_diff;
>+	int ret = 0;
> 
> 	avg_llc_val = sum_llc_val / num_of_runs;
>-	diff_percent = ((float)cache_span - avg_llc_val) / cache_span * 100;
>+	if (*prev_avg_llc_val) {
>+		float delta = (__s64)(avg_llc_val - *prev_avg_llc_val);
> 
>-	ret = platform && abs((int)diff_percent) > max_diff_percent;
>+		avg_diff = delta / *prev_avg_llc_val;
>+		ret = platform && (avg_diff * 100) < (float)min_diff_percent;
> 
>-	ksft_print_msg("%s Check cache miss rate within %lu%%\n",
>-		       ret ? "Fail:" : "Pass:", max_diff_percent);
>+		ksft_print_msg("%s Check cache miss rate changed more than %.1f%%\n",
>+			       ret ? "Fail:" : "Pass:", (float)min_diff_percent);

Shouldn't "Fail" and "Pass" be flipped in the ternary operator? Or the condition
sign above "<" should be ">"?

Now it looks like if (avg_diff * 100) is smaller than the min_diff_percent the
test is supposed to fail but the text suggests it's the other way around.

I also ran this selftest and that's the output:

# Pass: Check cache miss rate changed more than 3.0%
# Percent diff=45.8
# Number of bits: 4
# Average LLC val: 322489
# Cache span (lines): 294912
# Pass: Check cache miss rate changed more than 2.0%
# Percent diff=38.0
# Number of bits: 3
# Average LLC val: 445005
# Cache span (lines): 221184
# Pass: Check cache miss rate changed more than 1.0%
# Percent diff=27.2
# Number of bits: 2
# Average LLC val: 566145
# Cache span (lines): 147456
# Pass: Check cache miss rate changed more than 0.0%
# Percent diff=18.3
# Number of bits: 1
# Average LLC val: 669657
# Cache span (lines): 73728
ok 1 CAT: test

The diff percentages are much larger than the thresholds they're supposed to
be within and the test is passed.

>-	ksft_print_msg("Percent diff=%d\n", abs((int)diff_percent));
>+		ksft_print_msg("Percent diff=%.1f\n", avg_diff * 100);
>+	}
>+	*prev_avg_llc_val = avg_llc_val;
> 
> 	show_cache_info(no_of_bits, avg_llc_val, cache_span, true);
> 
> 	return ret;
> }
> 
>@@ -143,54 +168,64 @@ static int cat_test(struct resctrl_val_param *param, size_t span)
> 	if (ret)
> 		return ret;
> 
>+	buf = alloc_buffer(span, 1);
>+	if (buf == NULL)

Similiar to patch 01/24, wouldn't this:
	if (!buf)
be better?

>+		return -1;
>+

-- 
Kind regards
Maciej Wieczór-Retman
