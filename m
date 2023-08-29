Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A239278C47B
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Aug 2023 14:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbjH2Msz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Aug 2023 08:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235542AbjH2Msf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Aug 2023 08:48:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E559D;
        Tue, 29 Aug 2023 05:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693313312; x=1724849312;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=W+kf+rpp92wvRXpPL2jwhCyjONJUiqNhc/Zr02HgHgA=;
  b=dA4wVS/TVtLvo3Z6gepd+BQL7fq4TcX7SEX6CHq1RuBO08RClL4gFvOA
   XkmbN+ADqW/IdEour17Z93BaLgJFqvZIUJsjOWjDWcbMjtRlkXLIvuPhq
   9V4iDt5sK55JzUnT39mydqCpHBnMurM/xRiVMDuv9CigSqPyqaV+yUjU8
   nBkpRseZqHAlexxac0oMs+rwAaJzVDEb1qlb3YwQVjtRPo/Rotl1rI7ja
   lq9Ed8RTBLMD/EqLJ3clPvxglsLv+VHias9w1hcVLNJKePhd2bWnHs1Xz
   sy12cqZLFUkzki+5iTCvCZ6CFFKxEo+0iw5+uK8/2eV9oY3O2tMJEM1sW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="372769972"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="372769972"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 05:48:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="738685350"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="738685350"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 29 Aug 2023 05:48:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 05:48:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 05:48:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 29 Aug 2023 05:48:30 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 29 Aug 2023 05:48:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYa9AKW5XTMWhpWzM82QA5Z7LY83B9v8fiL4Z01CceMdbGaca9Auih9itOjnVTyrBk7rYUflLtTplHvGuZr0yeq8ET53gg/h7ZnoqVMyBvNZod1nJqvt8NNZM5avUvQABNByjRDkJHlIIFkK1OdjfNLFR8rn/TIWpCcCJ4YDt2a5SS0MzVBuL9iVyNwM0J5l0tWhMhPE1o8gb1IRMRk33WA6AJjn3OOyMjmkyQ3KSpc9FAYHGF5VtTg23AA7tlT4tYkaCGBdsbw4pcX+XflYXVenOZfGTlvLdrWinyRqTXvmYCQ8L5mVfXAQyJLpvaVrVUiu+JM8g/wYJF2Nu8nCOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaAcImsA9VxpHT9DBNvr14wEUlrShBE/6ZkxUlJDWtw=;
 b=Y0XaegekccZKiHl7iw5HofJ9NwsFBsdQ/AyW1mLnM5KA4lwQfruOzUcFP3B+wuFr0k+RNe21r/NjNEPNQ1PnI8JcsGE1ZKBMPt/I1qd0FkCbTBq6KUnbLpRqLBvCOckN/aHvl3TUwARgOCxe9EaNDDK3MOpdyiQrfDFf49NggiGDWtvQemafgQusGM0binr8W8isbF3eLYSMwvkw1QWaF5k2Jw2W9aKaa3P1JtbWdlgn5w9R6D3dF1/OmipN7eLEvSKs5sT6pGyrdslR8kjX5Mj9BZwrhfKmiNu2N/v0c6Q5ji4UecAZQaKXxWyMnP1d5e4ux3v1oGGbL/kPH3xfwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SJ0PR11MB5938.namprd11.prod.outlook.com (2603:10b6:a03:42d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 12:48:27 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107%4]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 12:48:27 +0000
Date:   Tue, 29 Aug 2023 14:48:13 +0200
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
Message-ID: <eetulhaho6ci25ahafo5qn4hag2ldnztnerxpmtuvh6vp2qlfn@lkazlrcje5sl>
References: <20230823131556.27617-1-ilpo.jarvinen@linux.intel.com>
 <20230823131556.27617-8-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230823131556.27617-8-ilpo.jarvinen@linux.intel.com>
X-ClientProxiedBy: BE1P281CA0447.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:81::26) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|SJ0PR11MB5938:EE_
X-MS-Office365-Filtering-Correlation-Id: f7b8ae72-1487-4a40-fffd-08dba88e3d08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c5ts5PxMg0rL9wlGbxO4EFTuT/7YX87Dhn0qD2zxAS66ATjd800h3fhx/cUKwG5XxTnFzbDmLw/Rij//60A54dAd2CCSVnzhxtsS6fVDWw+n4IvP8iOPKeKyByP6YJQuSAgR9fyPhXplAR0+XHUCxkAFEbF7aTk7plchRO6ly0M1s/NDQI6S7kI1HoDiD5HIliYkG7U71tkfypyu+2NtZLP2Ikx+7c6FcEW5h16bmhvtOCDErGBqRS1r01fZaawGHPo+tmbeYqs50w2/gQrS32Ma5qgYBljlAoWY1M5hD6ybzzcoP5MkiqL6ixMm9YA7QJ0uYnrh7SqLlO7YDT7gqCDWmu96EN/VY89NAXExa+rcbeqh11FhONoo+UUlNWFe5GMzSDxOgVixJ4VeLa5XJQVM8sUs9uosDQy0d4GUDF6Qv/VgHtOH7jjsKDot6Y+83mPE48vr8eGzBY+ON+7pIcJLzm86bXTnWKX1BWIwjvcddWxSXIefEcU0gVKYzerw4yqEuzMd6f+4ZEdiYkPbRAHIciy17BgYNWsNG6LbiywMO6RjjT6YHVpjkbkwr3kU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(366004)(346002)(376002)(396003)(451199024)(186009)(1800799009)(9686003)(6506007)(6486002)(6512007)(6666004)(86362001)(38100700002)(82960400001)(83380400001)(2906002)(53546011)(26005)(478600001)(41300700001)(66556008)(66946007)(8676002)(8936002)(5660300002)(66476007)(4326008)(33716001)(316002)(54906003)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ifkUsHr/Famt3ci4BjZUDbiKoDxRuwchixi77OHiLgOFSOVl63ZNxAh53P?=
 =?iso-8859-1?Q?D6+i+1z6rb47qCYaShc/MePbYqBIh0OUGh9w3wMau4+LDx5CNc6T5yiJo2?=
 =?iso-8859-1?Q?Ar2a44Zq5QWnmGcadGsLIlhoWbmf1xNL631kuMZAKMD47R6B7da02u5wkP?=
 =?iso-8859-1?Q?VFW9F+dB19j5ZevSiAfiF4FDnQ7GjtpUXI7CFFWC4cgL20hWgtzfsEgafP?=
 =?iso-8859-1?Q?G/5BrkTw8a6X9kq69PnD2hn0DuwFWWO9x+eZ10nPiyL9kZG0cJ3H0TWB5H?=
 =?iso-8859-1?Q?fDanyjD/llZcbRkbu9dYfx1+kRRTqMVxXp9Xb/pBPwbHqBPtyP4Nhshkzh?=
 =?iso-8859-1?Q?EvnJ0S+FwNNjn3cpVXpGlnD+O70lh/gAq8mxhiYiBUHM1t/8F9s+a4if9y?=
 =?iso-8859-1?Q?NjHZxGPnoYj97nfaoFR/rQW47XJ08fju/5v38s26qlN2ovlYPxuXIQYHFB?=
 =?iso-8859-1?Q?MHg83RqBx/KI2YcKWyrdIRkt1RdblTCCAJIzcXS6cesS6GPxUcur12hY2O?=
 =?iso-8859-1?Q?ClX179h1mfktE5a/oU7jsbRrAkCYADAxprMLgxxeoCp8e0Hr3QSclBkzLw?=
 =?iso-8859-1?Q?vb+fsqIkYDnt2mhhYbAuyJnbe2pDDve4cXNLoEkmSrCnGYxSpNhocLMduz?=
 =?iso-8859-1?Q?fzkojQi0bW0PlQXHJGe/c+d90vAjrrR3YPgX/Q8RBvUKuG1WPiy7qgsUsJ?=
 =?iso-8859-1?Q?ST3igochHDmHzmfKRmWOIfWN1ReUjIrVouUQ1gdSJzmlIOorG9UHXh8nnw?=
 =?iso-8859-1?Q?FyrfZ/KCML1wDQqa0WYGXzJoPTTJe4sqG/LV8FKgZJuIVffiZtf0hLUCat?=
 =?iso-8859-1?Q?KLtJn2q1+i/0NDeluw9Mvg+wx4OuPQB8un8bcdPOy2hGCQaTx55yCRDDLH?=
 =?iso-8859-1?Q?YEPCVz7j3UdciZVgWHkOIe6woehIVI6FAwrqu1u/8Tiyp2tFiCXKj+g1NX?=
 =?iso-8859-1?Q?Gphn/yWe2rq5aknsrcotexGnC+Lj7eo8Yx4C7LQnegpMkuEIi702sQcu3r?=
 =?iso-8859-1?Q?2qux0lsqYCTYixKFo9BjG8XGp1cDJNyiukAFyH2/BcSvPAGvDxMoBmhouu?=
 =?iso-8859-1?Q?boTmlT0bIb5B/mY39eie6N38DK/hSoZjNsCFIJsQ0xa0BF7ZXsqLPLpXnF?=
 =?iso-8859-1?Q?50WG/49T2Jup8d1VPr8wS2xwoMt8OgDQkOrth1V24d0mOru2wMjrcPQJnq?=
 =?iso-8859-1?Q?d0/9ZQG8AB+u2N6XBM4jM9Lm8JSkS0E68cXXjwLiHLHJTYHBeVEy0EuKSz?=
 =?iso-8859-1?Q?xRrz7Tjbm9oUoxzvY51Ifb36WVEGJAfH4Ti7N9np8vP9YAudINPCY7hBFb?=
 =?iso-8859-1?Q?r+M6Q/mX/iub45FmZPFcgkbdR2bdJ99Q5WutL7YsO+aRdgiCDxl0fdmC1m?=
 =?iso-8859-1?Q?xq10vWJVjK0/wcALvRF3q5U0CptDhmM9+anW1HOv8vNyaQO1ZQVFss/n3b?=
 =?iso-8859-1?Q?CsaI3JHNzpcxrm9U7vOFKD3UTqbBr2I+bVA63XMKo4IbdL6SOS3TRQB0J4?=
 =?iso-8859-1?Q?HHDqo8ql75ruOEYkbOZ+z9URtZknHcqPgUExQHQ9QAGQ7RZb/++V4zAjLY?=
 =?iso-8859-1?Q?IZtYwtSbWOvJ9sx47rlnN/ADQO9ZEyl4APw2HQPTPIPQlpUXs64Fm2OYlT?=
 =?iso-8859-1?Q?zEqE5BFo7Dz9taHcFH7nohwpTA6m8ULovU1jD6kQLfQmVcTYg66bbS44eH?=
 =?iso-8859-1?Q?+K2ncpVgrxRaQVVk4rw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b8ae72-1487-4a40-fffd-08dba88e3d08
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 12:48:26.8315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDUP8dZNwIuljMcmownyRNmSL8HTTFCTHQdJIEGj22EuqFfDtBLXId5vL3FsQrBm7pxwQQvREcPVjauHrXZtqeEiyjqkhi6J7OWo+I1chcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5938
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On 2023-08-23 at 16:15:56 +0300, Ilpo Järvinen wrote:
>Benchmark argument is handled by custom argument parsing code which is
>more complicated than it needs to be.
>
>Process benchmark argument within the normal getopt() handling and drop
>entirely unnecessary ben_ind and has_ben variables. If -b is not given,
>setup the default benchmark command right after the switch statement
>and make -b to goto over it while it terminates the getopt() loop.
>
>Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>---
> .../testing/selftests/resctrl/resctrl_tests.c | 71 ++++++++++---------
> 1 file changed, 36 insertions(+), 35 deletions(-)
>
>diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
>index 94516d1f4307..ae9001ef7b0a 100644
>--- a/tools/testing/selftests/resctrl/resctrl_tests.c
>+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
>@@ -169,28 +169,35 @@ static void run_cat_test(int cpu_no, int no_of_bits)
> 
> int main(int argc, char **argv)
> {
>-	bool has_ben = false, mbm_test = true, mba_test = true, cmt_test = true;
>-	int c, cpu_no = 1, argc_new = argc, i, no_of_bits = 0;
>+	bool mbm_test = true, mba_test = true, cmt_test = true;
>+	int c, cpu_no = 1, i, no_of_bits = 0;
> 	const char *benchmark_cmd[BENCHMARK_ARGS];
>-	int ben_ind, tests = 0;
> 	char *span_str = NULL;
> 	bool cat_test = true;
> 	char *skip_reason;
>+	int tests = 0;
> 	int ret;
> 
>-	for (i = 0; i < argc; i++) {
>-		if (strcmp(argv[i], "-b") == 0) {
>-			ben_ind = i + 1;
>-			argc_new = ben_ind - 1;
>-			has_ben = true;
>-			break;
>-		}
>-	}
>-
>-	while ((c = getopt(argc_new, argv, "ht:b:n:p:")) != -1) {
>+	while ((c = getopt(argc, argv, "ht:b:n:p:")) != -1) {
> 		char *token;
> 
> 		switch (c) {
>+		case 'b':
>+			/*
>+			 * First move optind back to the (first) optarg and
>+			 * then build the benchmark command using the
>+			 * remaining arguments.
>+			 */
>+			optind--;
>+			if (argc - optind >= BENCHMARK_ARGS - 1)
>+				ksft_exit_fail_msg("Too long benchmark command");

Isn't this condition off by two?

I did some testing and the maximum amount of benchmark arguments is 62
while the array of const char* has 64 spaces. Is it supposed to have
less than the maximum capacity?

Wouldn't something like this be more valid with BENCHMARK_ARGS equal to
64? :
			if (argc - optind > BENCHMARK_ARGS)

-- 
Kind regards
Maciej Wieczór-Retman
