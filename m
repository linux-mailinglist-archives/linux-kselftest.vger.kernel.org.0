Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44D47D96F6
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 13:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345689AbjJ0Lvf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 07:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345688AbjJ0Lve (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 07:51:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A53C1;
        Fri, 27 Oct 2023 04:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698407492; x=1729943492;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=lE3TzLCkQvhj3kDTWnk5nRmEWBNRR9LCZ/rWCD5O2VA=;
  b=cqTI5jMQP4GvcWMRW/CgFYERYX0ih6UelnFcIgE8Frm7l3XrzSDEgM+N
   2WqGawu+briAMlLNoCYHjfvKaRVFmZ3apEY3bRr8Ilrr6MzA9ZFiNtWoJ
   q4aWgdfbdJ5I6PTJybQs/2L8bjFyDgCUbmDrKlJSzdY9QZU2dBFRa/G5j
   YHetwCfpICZdU7XlmpX/pGrW/JrF5kt4mORWdHroUN6fPSpDvaZthdDo/
   iwWHvYgMsyPGrOaX07r1e2yQQsNbF3Ahk09lzOBHcBOOuZT3jQ6/Ps1pL
   xY7cDM4IDIMwt+pJ8oXSA1VzspEImuXIXMEPyJVQLCiTxdZulid1ya7tJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="580675"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="580675"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 04:51:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="876312585"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="876312585"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 04:51:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 04:51:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 04:51:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 04:51:30 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 04:51:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZuioEuU3a2k1MGBLe2Ch0Dbx796eeF35ToW1xj8CrPNlVnW++KaXIz5DKFhgpwhDuj+MKPTFlH/x2xgcJsTokBqj1onVKU7SO/N0d9xlbcjdQIV3CKQh9zrct0wdsS3zkFDVOVCTUJMqXt9tQGT2qXKTXJ73b1iMqHQ+QWmszSfsrEBghWOz3+yqWeube0LeoPLOMNcHnjPKX7lB4823K4Ty343zSmFh26IzL7IYELqZ6ZnoZmlba2rZvO4oRp0OVCP++a9AA3sLskKAG0uwxqkzEL6bomBRxIpolLbBGYD1C1NBwaEH3d9dPkiaYe07waa77mDFyCFExMw++p2xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cl4OAhKkVNxwkWRiAD2ixmhYh/Kz12YkI8XKMARDxec=;
 b=aTvY+JXQZQzbU7iYNKM7iorVOte0nQcqjS29hFkvmreztlRkYcr2SW4qJBWw0cDnA8e21rZWqIc+XF6XM2shpyeNN93z9xK+Y7Fk6X/VQOS7eeV1bV6LE1UvtTDt8ZAaiMhm5UXz2GdHP1SluuTDL4FiAC6AWMV3YkZuM70SXRJZ+NucinFO52aT/r3TgdkvH/v8DlIJIZ4vHObaWaV4GNiDu7l5DsKti9KpwMucYbvwMlQg0n1JP/o+wfdseZd2dCF9gpGtzP+UxmWAnrFTNomRfjn6elpUo4tX5LAjRWNqtFsdtOLisPoSgRWCqpJ4iU3BMwxqD8FH/sDFsb4bYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by PH7PR11MB6905.namprd11.prod.outlook.com (2603:10b6:510:201::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 11:51:28 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 11:51:28 +0000
Date:   Fri, 27 Oct 2023 13:51:24 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-kselftest@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 14/24] selftests/resctrl: Move cat_val() to cat_test.c
 and rename to cat_test()
Message-ID: <5x3wlnejagee5hbigjo6dpvbc5453gnaab4ue6doplneumfgzd@q7yo3j3prh2h>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-15-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231024092634.7122-15-ilpo.jarvinen@linux.intel.com>
X-ClientProxiedBy: WA2P291CA0022.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::24) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|PH7PR11MB6905:EE_
X-MS-Office365-Filtering-Correlation-Id: c402dda6-dfd5-45e9-8539-08dbd6e30e06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j5yyvpnPIkwwwWhjGQSxTyNzobkvrtkZcUeVAd46sskABk14SlaRSYWydzzRpQsACGWyzX9hJCcGdc8GHY1AhlMXzb4m2sVYsv4UPVCbSa/kKj76NlfYtWbtidaZPhJq5RsX9Xwjom0ylIlm3t1GQ0aTxMHUFUeWQkR7CGfyHSB+WUat3jTptFi3i/fVS1ln0XtSlGDIAOu6VMHnp+5Q0mDkCbJmeTLvdXNofDe0HcIWPQz+XAHvPd2nyhtFjEatOjFzI50lO8FxjvPPdTWpXUbTABzKKwUOnp0niLTXOAjB2z9XbPQlgXWi9XAJB6RAZXDiYgzOminYluiXBmTa4KDQrwJd8Um5D6wdjKXcOXuf+vpfRVO32pAogVNNp0XEGGz1yB/5KB2lJ4l2vsfxVW+XwTfLL+DN6SICqcLQJA34Xs9SmMhcI48AmP3bG19Hdbxfx2I0h77I5bmt3luGUXusPpaGK9i9XVwcQ8P7cWTaEZDDTTyyEB408LP8GIIlLYXyw3rh/bCqTC2DE05DyVVnf2UVoj2Jecp5yYkADvkglSmDAj2QEvrZfVfzeZ5z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(346002)(136003)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(4001150100001)(66946007)(2906002)(8936002)(5660300002)(41300700001)(316002)(54906003)(66556008)(66476007)(478600001)(6486002)(53546011)(6916009)(6506007)(8676002)(4326008)(6666004)(26005)(66574015)(6512007)(9686003)(83380400001)(82960400001)(86362001)(38100700002)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?EE1sVpVPBNmlRvmjQuZL+MkdyXqz0m2ZwxeGr5LiVanuyxMYYK4wsSXSI8?=
 =?iso-8859-1?Q?o9TvkWf4w1YKSM+bvXCSPD6WkWCtcWks4uMpwMgVW/VwotAvSBEjwY6/F2?=
 =?iso-8859-1?Q?o8jQ2vRWYdGeHjGzzrhIg/sqfaLX/1mM8O5NXlcBDp5a5GSERU5fM2ekFa?=
 =?iso-8859-1?Q?Cf3DURS6KOShQjrclmfp5Kuygt34R4ATQDM1zfizdKFI77ro0k3cfFshm8?=
 =?iso-8859-1?Q?EbJi/3JcMcjsMID70uoyCt8ta1tbuZwfWgSzQMTyUg+v17j6DZM+XnJuqR?=
 =?iso-8859-1?Q?2hj5awIEkZy51qMTHu2bE+reveafxv2xDiXk3g5vDrHqitzygNSe5umP1N?=
 =?iso-8859-1?Q?6tHeIfSf0z5/0qG9jtg4LG4FHVXsGWsG9KEfBn4LNduIHJ7iI0aDv8YE3V?=
 =?iso-8859-1?Q?pDVCojipuaR90ldmJyIc0BHH/k+dXqwXVr48aQJZ2cy3QxCdRv9Nr2GLpw?=
 =?iso-8859-1?Q?ZUWqG1GwtLbp320SeMqZ80K5zX0DOTpUDzzKDhAPE8wVY0Arq+BbLMGoqa?=
 =?iso-8859-1?Q?+2fZlwrmfriUlSNemJtgSuRlvhuoNQVyGyZ0d7vfViICigzCTWSyiiR7oS?=
 =?iso-8859-1?Q?WSg131G7/1bOix8FVTFqmr5wEg5LVu8XpWd0qqNSw3uXvAhe8R48pHlQNY?=
 =?iso-8859-1?Q?Mjj8u/tZVnVQmnNlG7EK7F04re2tG/SsXyZNMfa4KwtKcgra+A3JPjyjn5?=
 =?iso-8859-1?Q?3VP7+1h9S1wMWTI9stSkr8NUa9ygW0xCOCdsYrhLJdjiIm3VCozu7tpTOH?=
 =?iso-8859-1?Q?ruGYoiMe+b+Q5tsAMywq07NgW0TIz0QNNG8BgXjqmcp33SrfADQkAluk1Q?=
 =?iso-8859-1?Q?JI2DBWVRIktn1oJQQGyqJtc6cGxwDClZXK4l8zGKrS0w9Hnt8/NobH+SzN?=
 =?iso-8859-1?Q?HNe7kOq/zUKA+76zqCYjsAZrtKC35fTUfAQ+Y0r9DpIVmuqmTFvHvwzvyT?=
 =?iso-8859-1?Q?3bUQIyWWiyZsh+0hAOVIbIyFF0KTePIePJOOQfYouF9nQ/ZadAH5Jt2I4z?=
 =?iso-8859-1?Q?aUNDlbSIKa02Hxj4+Q5OVzRM6V2loVqHkiPqXOlPS6XQauNTBE+9nGkHik?=
 =?iso-8859-1?Q?hg515GuKGgJglVgEQmqNWccC2AZJjtgQtQAQHMlWeaN/ATuB8MIHvfSBqT?=
 =?iso-8859-1?Q?3R2B6yV8PH6lR3yhWxnrZFjCNGhSsSLhBMhIj8OV9h/ZoKYrPxuXeRyApg?=
 =?iso-8859-1?Q?4uxJEX3R/Uy06IrlAGyzFtCOVhJcffgVAD7aG6rUErEZBmLBMZLXBEf1zF?=
 =?iso-8859-1?Q?u37vOAhvP0zqU9gsd2DezUnF+eBzODHkpgookJ+FAznCkFLD2mErj1lxX0?=
 =?iso-8859-1?Q?6xnZyoCGGe4mYTpoygwU8S0JAAyJnxz2tRVZjHegpHZ+VamULWOoJQ2YnR?=
 =?iso-8859-1?Q?B3UqtulTfnJ+P7zopoP9Llv4hSMM1ubDgNiffLks/4MW4sP5q3l+6f1fc6?=
 =?iso-8859-1?Q?Nx6FHQe8FVabIcVEvZhB+rMpqAE6jx1hXGDCHiZ88WRigmyO8cfXORZSGW?=
 =?iso-8859-1?Q?TZsP+jxzE/FAa1u4PI2JK1ce6FZX5jjYJHc2nbP1XoQX6gF4wp9tvWhZbI?=
 =?iso-8859-1?Q?BY5JpRtfpyyoJAp+es9vogIDAjeR/xbwEe29PGZz5jG11EjorSA1HRZjFB?=
 =?iso-8859-1?Q?CVVWXCzVVWcW/66OeDCDs+y6B9M5PtZWtquf/ASIQmg4cali/qxsz1vjwi?=
 =?iso-8859-1?Q?3YKd9DLfIVPCKYSYqPg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c402dda6-dfd5-45e9-8539-08dbd6e30e06
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 11:51:28.5133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVcwJvG6VoBBsCDlQxGNsgrGDb1lEw9Nleq/rxWOhBtwRmmyDsTfGMWWNvJhmnr8L6+mY0bSLj3/Y/UymQ+nGRtRTb/CIgC2BOgHTEjkiv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6905
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-10-24 at 12:26:24 +0300, Ilpo Järvinen wrote:
>diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
>index 2106cc3601d9..e71690a9bbb3 100644
>--- a/tools/testing/selftests/resctrl/cat_test.c
>+++ b/tools/testing/selftests/resctrl/cat_test.c
>@@ -111,6 +111,77 @@ void cat_test_cleanup(void)
> 	remove(RESULT_FILE_NAME2);
> }
> 
>+/*
>+ * cat_test:	execute CAT benchmark and measure LLC cache misses
>+ * @param:	parameters passed to cat_test()
>+ * @span:	buffer size for the benchmark
>+ *
>+ * Return:	0 on success. non-zero on failure.
>+ */
>+static int cat_test(struct resctrl_val_param *param, size_t span)
>+{
>+	int memflush = 1, operation = 0, ret = 0;
>+	char *resctrl_val = param->resctrl_val;
>+	static struct perf_event_read pe_read;

Is there a reason why this struct is declared as static?

>+	struct perf_event_attr pea;
>+	pid_t bm_pid;
>+	int pe_fd;
>+
>+	if (strcmp(param->filename, "") == 0)
>+		sprintf(param->filename, "stdio");
>+
>+	bm_pid = getpid();
>+
>+	/* Taskset benchmark to specified cpu */
>+	ret = taskset_benchmark(bm_pid, param->cpu_no);
>+	if (ret)
>+		return ret;
>+
>+	/* Write benchmark to specified con_mon grp, mon_grp in resctrl FS*/
>+	ret = write_bm_pid_to_resctrl(bm_pid, param->ctrlgrp, param->mongrp,
>+				      resctrl_val);
>+	if (ret)
>+		return ret;
>+
>+	perf_event_attr_initialize(&pea, PERF_COUNT_HW_CACHE_MISSES);
>+	perf_event_initialize_read_format(&pe_read);
>+
>+	/* Test runs until the callback setup() tells the test to stop. */
>+	while (1) {
>+		ret = param->setup(param);
>+		if (ret == END_OF_TESTS) {
>+			ret = 0;
>+			break;
>+		}
>+		if (ret < 0)
>+			break;
>+		pe_fd = perf_event_reset_enable(&pea, bm_pid, param->cpu_no);
>+		if (pe_fd < 0) {
>+			ret = -1;
>+			break;
>+		}
>+
>+		if (run_fill_buf(span, memflush, operation, true)) {
>+			fprintf(stderr, "Error-running fill buffer\n");
>+			ret = -1;
>+			goto pe_close;
>+		}
>+
>+		sleep(1);
>+		ret = perf_event_measure(pe_fd, &pe_read, param, bm_pid);
>+		if (ret)
>+			goto pe_close;
>+
>+		close(pe_fd);
>+	}
>+
>+	return ret;
>+
>+pe_close:
>+	close(pe_fd);
>+	return ret;
>+}
>+
> int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
> {
> 	unsigned long l_mask, l_mask_1;

-- 
Kind regards
Maciej Wieczór-Retman
