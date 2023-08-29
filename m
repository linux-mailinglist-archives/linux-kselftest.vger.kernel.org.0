Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53C978C525
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Aug 2023 15:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjH2NY2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Aug 2023 09:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236063AbjH2NYP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Aug 2023 09:24:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407D4E56;
        Tue, 29 Aug 2023 06:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693315433; x=1724851433;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=bzEe6/oabQvGBhlUs/vLZQSO2BAHF5xq4qygyhONjYw=;
  b=YTHZzqIlAfrPyNaXkPAVNojssH9XAr3uohOWN+92ls3pH3wFqBobReqh
   Zqq1gFfBukNnwmNwi3K78UklfBhiQL/OUylR7OEOk4yi9w44yjq3Qaw1S
   nKZTaLmLm3w0vyuFktL9NG4vQn5zhT3c/jTThcErpziHD3W+CVknLKEw0
   3/4g0iRSMOBz0+5dLN0JLJyCPWjimUa68A50DmA8/CUFk5H2R4ne3tpad
   oQy1CoWJVK6gB7v8W1BMWMXsLQVbHpX5YLt1pae9oVmnfnuTczEOKmhIP
   WvWN6x8r2cNeUiTghrXaOfpRaF52z/U/Kbc/FvXpTFw1T38TvU1IKTmRq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="355685884"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="355685884"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 06:23:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="715525677"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="715525677"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 29 Aug 2023 06:23:43 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 06:23:43 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 06:23:43 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 29 Aug 2023 06:23:43 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 29 Aug 2023 06:23:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwLOp4EX1rq/pwxgI/3jfuCg/ntFeZH/lRKUAKJAkrHDf9vGBuEY8hA68/xBCwWkj6Lgax3iAMQQfHprcJMYXa/mmTwB693Tdr72JJOwFAUAy7Cdrw+vhA48AyRvJnaMSS9q8f3nzjRybIgqruT8NjpLRFT+yfYhFNPzlh8hsPMp6BEbWogh9U7Qlb8dMFTpgoXDzEr/8A/bpDmx/GNg1rAx0r1J87Va4rMze1SUVn8Y9WB5V183BoYyrjSoEo9PnslnOlmaHdGZ9cO8xh5rdyaZFL5egde8SoOlg3xsod0M6NrjjcWkbw1MWLc89rL+WnHm9xZUz4PTdOORsQVZHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4b2t8QDDHR8GF3pBYyMNAJzMXVTZzOG0/ACos10Th0=;
 b=R7Gg3lnFp6SBqvoXMa+vQxPiMQAJU0VPrL2rgm+1J5/xkyxitKT3xQsIoyWwe/WuCxwTUAGiOaAu4h5Bw2rrNF5NQLlffmeGKGg5kF+tlH9rE3jm+N4bhvGuUikWse1cYdKNwCljOoISjE/zSDUnmMIQdwU0i+ApI7hkADPPCWCXiUM0dw51PXUQEji5qtdMJLtMaGr/X5AkeTbBuyLejt3Iqdp6/WRW+plGiECtlPb251u8ZWT2Z3OhQY9WkTmMUGcgfRx/1oO41ljlNW2fa/3qiMjjBy0sAlgj6BsuGZ+vwS4m846MwbkA1Z1fR2Fb+wrsFsWDsRKYAg3XQeusVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by DM4PR11MB5392.namprd11.prod.outlook.com (2603:10b6:5:397::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 13:23:39 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107%4]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 13:23:39 +0000
Date:   Tue, 29 Aug 2023 15:23:29 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH v3 7/7] selftests/resctrl: Cleanup benchmark argument
 parsing
Message-ID: <h4ytykrf3cyisf4fdfs4nqobkzxt4r66slv6fsdr5v7uxqwk2v@gel7l6ymblh4>
References: <20230823131556.27617-1-ilpo.jarvinen@linux.intel.com>
 <20230823131556.27617-8-ilpo.jarvinen@linux.intel.com>
 <eetulhaho6ci25ahafo5qn4hag2ldnztnerxpmtuvh6vp2qlfn@lkazlrcje5sl>
 <f31c39-41ce-2dc2-26e7-62466abdac2@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f31c39-41ce-2dc2-26e7-62466abdac2@linux.intel.com>
X-ClientProxiedBy: FR3P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::19) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|DM4PR11MB5392:EE_
X-MS-Office365-Filtering-Correlation-Id: cc9c7dfa-67da-434b-e058-08dba8932817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tcOFBrO+LVrzy5IT8EXngSstOndUtvklD0Hge/st6ek/4FvH7r+mFArqlERUxXDOpbgTcts/JhrZfGorBTq1mCZr8q9rN2Z12UKmCzV+4NZe5XyeBV+8+MZNBepojNPZXp8qpGiW95gYkepplFuEV/Y5zzZCo8YdykWwEhKqTbifMPLgDPG3UYljztoXGg86rPJJkrs/VyWuG0UuyJ0q8GcEVfo6D+oPSUcSxmCrotTZtya9AQKQsQGUupi53xzpe6+KGf9nCGESi2GcwQvOcSLCxLkekxAkjqhtGoPhGkE5fgPDh3zceyXkRihR/I2GEwrC/3If1Tqdj0l6wzqz6xPkzHvsi6xr4DGroBeBIbYrmB0Z7WFb9gvrdXprpTjYYvXhupnf363Hk+ngxuz70bWiUuZ3DlNTNOG+9IqNDPTMmoZSu7vUV0Udh1EdZi4RQ5+HLvvh2AvkBpbLYpmo0pjeEUbGjuCpKmt5oBZG7bi3qcLgoNQvZrNdzNDerR294zjC9ecyhY7Gn4vMFRzRrQGESJ7rT2TxU8QHnhQQH9DRntAvD16yWuHCxCyx7hHE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199024)(1800799009)(186009)(8936002)(6666004)(66946007)(53546011)(478600001)(6506007)(66476007)(66556008)(54906003)(6486002)(6916009)(316002)(38100700002)(41300700001)(82960400001)(9686003)(6512007)(26005)(8676002)(5660300002)(83380400001)(2906002)(86362001)(33716001)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?tKwnK7P65Q7kz3lovn+nNtELe/Dpk062Pi+OqTa9I1MPjBHIxGxHkazq0u?=
 =?iso-8859-1?Q?Lan4vhN+gQiXW3GrgDbCYJLJyRWSFgsma9UgPx69ccx2+2bnBNha/668jb?=
 =?iso-8859-1?Q?BdoR/eoeaMy9BDP/PfDhUgtjL/9xydK+LogXi+/v9Gzr+h50Gp1BSh3x7G?=
 =?iso-8859-1?Q?0RHxMYYMHk5u1mousTbZT3kW6XqnAAlDf+Ev79Ig3UFG/fAiXahL2qFQXL?=
 =?iso-8859-1?Q?uwjB/MDGwPj62bt05O2zW7rO1OxgnrUncMOBfyxwQN64A9JdHtN3WZUFMG?=
 =?iso-8859-1?Q?Xs37Nj6mxCZdKgSU7dj7u+IFGYS93SuBxjNdcjCaD/oWhmOAxvK9iI3bMW?=
 =?iso-8859-1?Q?y8KO6i3lRubeQuGcYhrgmqngCyW4+LyzsrQKG4ZKqHUUYhEOW37e3t3EJi?=
 =?iso-8859-1?Q?exCHLrSKp+7qm1vp24Ue5onOEQR47c3hLtTeGDWdzq35z8COpyvqqalvIB?=
 =?iso-8859-1?Q?82DY0fkD2u2+32ys/JaabEjS1KEx3BNmquKUQ5Quwo3b8K8Hl24paDu1vw?=
 =?iso-8859-1?Q?axP/a3p4Bkv/vQSK+fXFGTwIYqv5SlLLAkJ5GS1JozGkRJtIej+DJZWAlD?=
 =?iso-8859-1?Q?r8vb9HbmfOmBlKsqzeAwErFhGnmTrsduLbZGGScivR+LejLCQfsO0rS3jt?=
 =?iso-8859-1?Q?it1R+5qD+kbofCm3rDWn6WFhN43vwp+AnL5dplTE6x38d/Tu2hLsjJI6UD?=
 =?iso-8859-1?Q?9r+q2IclLqjxrDdoqOpWAwQD7xZA75EpGp2eEPvkm6kf85YM1fGhzeq2Pr?=
 =?iso-8859-1?Q?zhVSmt9sDqBBfXn1RKXnuSjL2vwUzb8zGMkXff9xMRhvbohVVAFXKb1mOD?=
 =?iso-8859-1?Q?WjTNOTg0o/IdKu+hSs25BzUD42dv86RxuEILoldrYF/yrIttO9Qg6OChuh?=
 =?iso-8859-1?Q?5Uyw3MP83yAwnX9bAjGHGcnDDwwMFqzsliSt/h29EW0239eL/LF8MB9K71?=
 =?iso-8859-1?Q?yxqNIa9tkDSmYtWpxkjW0hCimXbZALgSONJ3gFKaPtttjd8Kw5tTmMsB4z?=
 =?iso-8859-1?Q?CfcxrKV2YK8N9naE2ZyV/4q2lAI1f5oYf26Y9SXKpQF2RgGQPgyGixuUh8?=
 =?iso-8859-1?Q?hG6/oePhgmLZGiY+wepTPgLYq063MPwDcR2uk4woxpHAM6R7InL4PndEc9?=
 =?iso-8859-1?Q?U3QJq/US5bBHRXJ5D9UfFkaUpd7ve4ZTZAxt+yn4cgSUsSpBQJZQK9QUc1?=
 =?iso-8859-1?Q?HlC4gS/rDctyxf9L7sXrbs+Qg0NHUpFuOFgTvXMwBFx363BFpQShbDTyO1?=
 =?iso-8859-1?Q?fySvZ7qF4+R1D5hgTiZ1AmYZCIw3t+6/CvR6dAzkFyBjCyNWlFSNLqtscV?=
 =?iso-8859-1?Q?JBZbckWdXpTnqKnJrNIP/v/u72Km4NFWIZhS4045D3WJGPu5S+b8Cgcmd4?=
 =?iso-8859-1?Q?c0AaI91F9nMgnRFwZhcbQrZVxPzxx8YFvG/yv17meh6g+MCzRoOQr2PU06?=
 =?iso-8859-1?Q?GEmVrbEb0FqKugmqQP2+ogW4YJvSlJ1NS4jrzlaGcvARSz42tHf4qkJf+2?=
 =?iso-8859-1?Q?NPGkgrTU5RfKxKylySE0qQzAs+EeYF1V9tSw8UOO4nCkAXsOQsTEwWHTAS?=
 =?iso-8859-1?Q?04PjxyaZqpDrkNLQQKezpBJUTFKscrVFKJuQ2KFFSdaQUiqBxqUtFRv8HS?=
 =?iso-8859-1?Q?wZ/w60+v8t/lMcJtV3Z7CGUEs33dy3M3QqKjMz5+ytAioTIxLIG3r4d/re?=
 =?iso-8859-1?Q?DTNOmGzDMWbThTjF93I=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9c7dfa-67da-434b-e058-08dba8932817
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 13:23:39.1170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6y3wEqNfcrHO1kY7yEkXwy1bOIbsZy3NClDe1k0dpNzLtfBWy5y8h1sPKmibcFiA+hJ6aSvtiHEVKnpRsAohcgtcNylsAv/DIB5H9yBariY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5392
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-08-29 at 16:04:29 +0300, Ilpo Järvinen wrote:
>On Tue, 29 Aug 2023, Maciej Wieczór-Retman wrote:
>> On 2023-08-23 at 16:15:56 +0300, Ilpo Järvinen wrote:
>> >Benchmark argument is handled by custom argument parsing code which is
>> >more complicated than it needs to be.
>> >
>> >Process benchmark argument within the normal getopt() handling and drop
>> >entirely unnecessary ben_ind and has_ben variables. If -b is not given,
>> >setup the default benchmark command right after the switch statement
>> >and make -b to goto over it while it terminates the getopt() loop.
>> >
>> >Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> >Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>> >---
>> > .../testing/selftests/resctrl/resctrl_tests.c | 71 ++++++++++---------
>> > 1 file changed, 36 insertions(+), 35 deletions(-)
>> >
>> >diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
>> >index 94516d1f4307..ae9001ef7b0a 100644
>> >--- a/tools/testing/selftests/resctrl/resctrl_tests.c
>> >+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
>> >@@ -169,28 +169,35 @@ static void run_cat_test(int cpu_no, int no_of_bits)
>> > 
>> > int main(int argc, char **argv)
>> > {
>> >-	bool has_ben = false, mbm_test = true, mba_test = true, cmt_test = true;
>> >-	int c, cpu_no = 1, argc_new = argc, i, no_of_bits = 0;
>> >+	bool mbm_test = true, mba_test = true, cmt_test = true;
>> >+	int c, cpu_no = 1, i, no_of_bits = 0;
>> > 	const char *benchmark_cmd[BENCHMARK_ARGS];
>> >-	int ben_ind, tests = 0;
>> > 	char *span_str = NULL;
>> > 	bool cat_test = true;
>> > 	char *skip_reason;
>> >+	int tests = 0;
>> > 	int ret;
>> > 
>> >-	for (i = 0; i < argc; i++) {
>> >-		if (strcmp(argv[i], "-b") == 0) {
>> >-			ben_ind = i + 1;
>> >-			argc_new = ben_ind - 1;
>> >-			has_ben = true;
>> >-			break;
>> >-		}
>> >-	}
>> >-
>> >-	while ((c = getopt(argc_new, argv, "ht:b:n:p:")) != -1) {
>> >+	while ((c = getopt(argc, argv, "ht:b:n:p:")) != -1) {
>> > 		char *token;
>> > 
>> > 		switch (c) {
>> >+		case 'b':
>> >+			/*
>> >+			 * First move optind back to the (first) optarg and
>> >+			 * then build the benchmark command using the
>> >+			 * remaining arguments.
>> >+			 */
>> >+			optind--;
>> >+			if (argc - optind >= BENCHMARK_ARGS - 1)
>> >+				ksft_exit_fail_msg("Too long benchmark command");
>> 
>> Isn't this condition off by two?
>> 
>> I did some testing and the maximum amount of benchmark arguments is 62
>> while the array of const char* has 64 spaces. Is it supposed to have
>> less than the maximum capacity?
>> 
>> Wouldn't something like this be more valid with BENCHMARK_ARGS equal to
>> 64? :
>> 			if (argc - optind > BENCHMARK_ARGS)
>
>Certainly not off by two as the array must be NULL terminated but it seems 
>to be off-by-one (to the safe direction), yes.

Sorry, yes, off by one, now I can see the NULL just after the loop.

-- 
Kind regards
Maciej Wieczór-Retman
