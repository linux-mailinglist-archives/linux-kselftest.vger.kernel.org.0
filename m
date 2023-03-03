Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502076A90C3
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Mar 2023 07:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjCCGGY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Mar 2023 01:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjCCGGW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Mar 2023 01:06:22 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3CD1EBDD;
        Thu,  2 Mar 2023 22:06:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDzsKiEEfZSJEpxtGd+y89y6shnzqPy1WJMpA5F6FaADxg8imsi1m7lxmGeBfg+bOpZfgWO/GGszaf3y0EvcHRtbT0U1n8hIwso1SvwRCcDeKV8gdcZTrkPe7uoTYlxZ20jkp9IeMIg9bn1kXSN+NDhzM/nNzNxJdTlUg3SMsIb+qX4vCAzUUMLFp+DwNmKoj6DdBZ7xduqGxHASQdJVFaRDcJIO4Gc35RMnfCJ0bgSnMXSLj+L3oVH+OB89Q5uXUI44e3x/5H3jagXgb8aN4zE87BkTe3b5NsLczfO0M9gBAW82jOAGKGLS23Tbi8vyJLXd6dWwcg2mJVAO1C0arQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drZz7/y9CT47Huvn3ZqIC06bI48swzXivSxNEoHE42U=;
 b=Ya5l85v8ShNT5TvISnlMNdPnXvwMD0xe4Zc/rQBjreIHTx0K6ZPcAdISFstBhMwrcWThRvhyHNVqdXt7l2XzpAsRFWOdZFl6fI3b7wk2SOqgDyCKG/Cphx+yjasOFTD0NlFKdu6KCk1HrBwhvQaP1fD+URpByFQTZn3WqGiTdMfA5mjbpoo2fP/bRF0LgbMlIvDvkVoZ3v1seLXqr9D5bib7ZccA7uvCXZPakW1uMGKk/wlZIECCNDlaZwi/NZBN5SHExLlsPOKlXXKU1kBR7XztsTGF+SOIYJvRWxHgumKo1easZFg90OwK0okJefbGZsUczwOpO639nUSevEGGQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drZz7/y9CT47Huvn3ZqIC06bI48swzXivSxNEoHE42U=;
 b=bEj0K8KBwyXWlzV2Je/5dNvZ32+/aCk4xZ56EH1/tzeKqp7/sgFcZlTQgLUJdi2q9ClM/bkLZjUAEJDFef36D5dzM5s5Zd19zQHQxq9dsDNvcz+gKaZoaIrag2Yc9aEPFvjiW/bk94eHAN2C+Ds1dEKZZVNCH218L2xY4YwoXnI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 SA0PR12MB4527.namprd12.prod.outlook.com (2603:10b6:806:73::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.19; Fri, 3 Mar 2023 06:06:18 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::93f9:c1df:8ca3:fc5b]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::93f9:c1df:8ca3:fc5b%7]) with mapi id 15.20.6086.024; Fri, 3 Mar 2023
 06:06:18 +0000
Date:   Fri, 3 Mar 2023 14:05:55 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        Doug Smythies <dsmythies@telus.net>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernelci@lists.linux.dev" <kernelci@lists.linux.dev>
Subject: Re: [PATCH] selftests: amd-pstate: fix TEST_FILES
Message-ID: <ZAGOQznWjSNuhn73@amd.com>
References: <20230204133454.260066-1-guillaume.tucker@collabora.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230204133454.260066-1-guillaume.tucker@collabora.com>
X-ClientProxiedBy: SG2PR01CA0150.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::30) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|SA0PR12MB4527:EE_
X-MS-Office365-Filtering-Correlation-Id: bb5a2b70-2c91-4023-fa7a-08db1bad6769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V4LG9o/iTlBFEhD+6v6xH9LEmnkWK1g9HC2mBh77tku3U2R/uQ0UCEyfeiDs3pjwKWpp6FJ7+mjVjE/b9GJpzDnQW7SSvSmeGlx4kCcA+KCXovj5YQmlLYIAPRGFSJYxZWbq8Uxx0HILI+5eFgdnkejVepfaL8qn/KWQIwLltPPhyGxVMSzQ0wMeRQ+eGhj/eSlIuyZ5QjV5gsw8mehoxMdhjBw1RJmeq50qNFd1jZmxRm/vzp59Bt8w2jtTSsMRM2W/u6cpgTAbJWS7U+9I9GMoVoa5P7FfuMgtiAn5Fy/nTgZVFXk1BCpEelpjNAjuH/9PlwV7nmsiSiPWtUQelaPa3z07VFPTLxYOLh6uIi4gWvurTt1OQpBSVytuwnwO051n+8dzJHqPzDpe0LJk8l1jnQLtidT98i38GU1Rcaey00JCE4J7qVe/j4mvERUD09EAYWJnouNwf+3gpCn1UAcldMWYcwPjRndMqIMKFqhkiJ458Xk4bUhvJChDnWCW/TXnfu821VZsmddYMUg8doMBKnLDL7Z3tjYB6ImLkPUiBgZ9fI7xI0xXpUHXYTaNaLqdJkUveAuZmSt5spgi3D9xerIkfA2Kw3IhG/kWpqNolMGMWeOCKqpOnOvKSdDEXt/yBDeJBa19FKswaeVX/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199018)(2616005)(36756003)(8936002)(41300700001)(6512007)(54906003)(4326008)(66476007)(8676002)(66556008)(66946007)(186003)(86362001)(2906002)(6916009)(83380400001)(26005)(6506007)(6666004)(5660300002)(316002)(6486002)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YbhxI3C51rmaVpSV/rVcrJl2l6tR1IW5W7PqFgzimismn4PsMqKvkmoebqHd?=
 =?us-ascii?Q?z8Jzsi1gK6GzBAHlJYnAg7o+a6NQVrEfNPp9XWvyymQdmG16HTDm09GakGCQ?=
 =?us-ascii?Q?23Rx/jOsXQLD38DB/8xhlXctsMRv/68c1CvsKc0IoeKxeR7R8h9Qz3CzhMun?=
 =?us-ascii?Q?NDXfuIoyuWh3aPTgs5qZh7Rmqk6/yzl1YoW9Jn7CIRmGKcbF4EMbm06uc542?=
 =?us-ascii?Q?JUKanViuDwPnRjtoi/0CarK6rdDraFyTyfLtKfwnR16a+s7Dno3DGxopSgzW?=
 =?us-ascii?Q?gdIeZCC4tO3UP413escJwjStGb5eF2/8lQeJUJ2p+GG8gUHRKsvjRyWfV9Y3?=
 =?us-ascii?Q?gvmUWFFJUEg3y7CKyx1Uw+W8VlnoP4uOZ8l6B6zu+lEAyEJB93gWgAHh32TV?=
 =?us-ascii?Q?zFKAqQJa9rgCTDTgSBRo8V1f30a6ScYkT1TiSEpLaDTAyWdwccvlWpgCKUVj?=
 =?us-ascii?Q?Ho/XWGSaNVPV6NjddT+zFWy55fw8U93w/W4fRtLA49yqzU9AogK5qkg6ecTb?=
 =?us-ascii?Q?N+5bPnK1XeQJgz8wW4vtQGlEFcJionXe48g7xk+PQq5E7tWv8t9lNKWGYyt3?=
 =?us-ascii?Q?IeqSAakJLJV7JW820LZ2ywGy9xxj5OzrgGcUWpBGB6pcqFHiwdkwrxFFrUwt?=
 =?us-ascii?Q?S2K3H5AHGAlmwuuOla4hQGuNfX+hc5GGCywfDxJk/J9H3x9sItqEAY8SFO+O?=
 =?us-ascii?Q?SnoanKr9Orxtou0mEJbDzOA49otgSELKmKD3mdXRwjnfNlLKPBgUdYL50/2R?=
 =?us-ascii?Q?N67YJXJa0BAPl10jO+vhovAbBMGrHFUzNPdCZLcTxhQSwDJciEV+wxSF7KV2?=
 =?us-ascii?Q?k4lAPBO3OcFMwmXfcF9QTQl+v9P7hf7zhqUFkdlQ0c0W8vkk+6RfLbIyFYtW?=
 =?us-ascii?Q?bV0xCw+sjdl1LY295JF/dfkT76hbBUBnClw+hHatRIsKAw1xo16Fe6t1+LX/?=
 =?us-ascii?Q?DxVXFKi+76M7m4/K+DzhjTHI55a8lIDhg8mMUkPMgpjuWD0L2bxrnAC7Krkz?=
 =?us-ascii?Q?+VHCstA1qSDRIF5bIYYHlGQssnrQBvujqDxlXkr7kK31ncJBoA78brVjthsx?=
 =?us-ascii?Q?wrONlUpIcmY3+CyGYMwqRLDDoj9SNMBtoQwErYrwljNAPy5gTV+1bxe9UiUi?=
 =?us-ascii?Q?vBfOZ7ztHFQamDGuqbdNqS+W7FkAs5LNg0RfVxWhw+CPTchzVYq7ChYWMxcG?=
 =?us-ascii?Q?BAdReIsYTrOrpmtkkmkRcGdfAqSye4z5z53ntAu+nPjvYpr5yfvmc9ipB/N3?=
 =?us-ascii?Q?Ld+DvQDohmzi/xTC0p2ojUkGXC8a63rMAzRo1oQNYzfQTHupecsy5Ht/cLT5?=
 =?us-ascii?Q?n37lkXydzxrvlPwrMrhk2eU2Q8/2Y7eiUD/6XYTKf3HUaXgC4Rc4jTXYjJne?=
 =?us-ascii?Q?9cbRcsAQs+T6B9CcpU3ycG1fW+X+q2QOU0ICkCi8dIwMf3fbGpdu7qooN48I?=
 =?us-ascii?Q?5uWOubWqWvVS4o5NCnMgIn7dY9j9G5A0+Tg17+GFVlVFprh9pTvek6AwxR4k?=
 =?us-ascii?Q?IW31Qkuab95Okr8WeWy1tKNSy0NjznxA0Gd87GenG/54kINRiE5witZQkaPy?=
 =?us-ascii?Q?vAvt6frQzJcscpoaxg5KU8Qz3uSTOEFAvXWETulx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5a2b70-2c91-4023-fa7a-08db1bad6769
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 06:06:18.3379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLlrVuOzoEPlO0GCsUndLw4RkRoT1cOVJ1poBpNvBlSmsgq+6kmcMw7tDq2trrEZeBISHOf5qLeVTY/WnU2/bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4527
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Feb 04, 2023 at 09:34:54PM +0800, Guillaume Tucker wrote:
> Bring back the Python scripts that were initially added with
> TEST_GEN_FILES but now with TEST_FILES to avoid having them deleted
> when doing a clean.  Also fix the way the architecture is being
> determined as they should also be installed when ARCH=x86_64 is
> provided explicitly.  Then also append extra files to TEST_FILES and
> TEST_PROGS with += so they don't get discarded.
> 
> Fixes: ba2d788aa873 ("selftests: amd-pstate: Trigger tbench benchmark and test cpus")
> Fixes: ac527cee87c9 ("selftests: amd-pstate: Don't delete source files via Makefile")
> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  tools/testing/selftests/amd-pstate/Makefile | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
> index 5fd1424db37d..c382f579fe94 100644
> --- a/tools/testing/selftests/amd-pstate/Makefile
> +++ b/tools/testing/selftests/amd-pstate/Makefile
> @@ -4,10 +4,15 @@
>  # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
>  all:
>  
> -uname_M := $(shell uname -m 2>/dev/null || echo not)
> -ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
> +ARCH ?= $(shell uname -m 2>/dev/null || echo not)
> +ARCH := $(shell echo $(ARCH) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>  
> -TEST_PROGS := run.sh
> -TEST_FILES := basic.sh tbench.sh gitsource.sh
> +ifeq (x86,$(ARCH))
> +TEST_FILES += ../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py
> +TEST_FILES += ../../../power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> +endif
> +
> +TEST_PROGS += run.sh
> +TEST_FILES += basic.sh tbench.sh gitsource.sh
>  
>  include ../lib.mk
> -- 
> 2.30.2
> 
