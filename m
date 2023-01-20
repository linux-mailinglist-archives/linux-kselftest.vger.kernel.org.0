Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71C7675089
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jan 2023 10:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjATJST (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 04:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjATJSS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 04:18:18 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAE78C93C;
        Fri, 20 Jan 2023 01:17:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehhFrPr0P9J4lHZGciYr1F2x4XJ3fGmJVRt0iZc0dXh2tEIIuO+xDmyx3t3F/UTMNz94ESm+NgucyEuz+w9qp3SiYmxD8XXF6aIAHNzrvdRuP31UqHqUWbvUuNBggR64ezzNB0XvAvqA/+Bmly3MOMdxb3KGdBk0O4CvkCTWjmIo8RZ8wsQyTvNKyHUmEQLDZZ9uZ7fDOkQ1JWGPrNsqtnEmzkYxu6QAq+HQToPtMdDtSOWV5GtLT3YvUbVVpdC76fAjzikr4sh7Oih84nfrZ2nrxMv2bO6jJQdJI6qopZDcFspCaUruOD66jlAT6urWpSxvIZogESMrEOLDX2XKyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZn4OMGsCV86U/h2Ga6h84yHy07sctOxL+zbszGpj/E=;
 b=aMxkAuIDuZyiPbNW874eLPucYd0Ph1CQfwJbEdrdysCtnUgDQ4ymDIhmHEjv+98Ec2YsvHMEqtxCwHSyW+wkMEUlIxa2io9lTFj5XZAN/lapYLZi5HdJzy+RSxVRRVls5zJNPA4zMuMJTGJNV7GmA46/XDxH913GX1EA9pahLvoA+p4aTl8LgfnzEcwTqhYKo3vk0Hka9oXJ3/3Qpol3Oq6rBRwYWm1Z3qPRKl8JbQoYxw6a6+T8GVTZGsbvrAmcMYuU9IJyd6hY1Ekk6digTDUOW9gFqi7LffoMcCScioxE9iYfR+qXzlLCq7CVzSUF+ArqgXpsp02M1fLP6chRQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZn4OMGsCV86U/h2Ga6h84yHy07sctOxL+zbszGpj/E=;
 b=0UHmtoAdaugEdF1Lo5V4YEJZZmTSnk7aud/zxPksiPxL2SFYLqTzEC4UOyFmPJ+ucKYTlh1kCdXzMnoeoneS6w+j5H0hJozOgl27plEoABmoUFnSQTu7M5bV7PS1ylqXnILb5JoOR1tv1dyY0a00O0bLT2VpxFaNUtgLTYR8u7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 IA0PR12MB7650.namprd12.prod.outlook.com (2603:10b6:208:436::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 09:17:43 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::d17b:f929:12fd:8ae]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::d17b:f929:12fd:8ae%4]) with mapi id 15.20.6002.025; Fri, 20 Jan 2023
 09:17:43 +0000
Date:   Fri, 20 Jan 2023 17:17:22 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Doug Smythies <dsmythies@telus.net>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        "sedat.dilek@gmail.com" <sedat.dilek@gmail.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: amd-pstate: Don't delete source files via
 Makefile
Message-ID: <Y8pcIjGsikDeGqoU@amd.com>
References: <001201d92c93$98c8a040$ca59e0c0$@telus.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001201d92c93$98c8a040$ca59e0c0$@telus.net>
X-ClientProxiedBy: TY1PR01CA0197.jpnprd01.prod.outlook.com (2603:1096:403::27)
 To DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|IA0PR12MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: df9a4714-850a-4770-e35c-08dafac72fc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FlZ/79Zi6rlgu82h1uTCgFbk9axRBCsKW/7QmPOCRCU9jOCCQnq9FAhx2dEBMGXXnJbCda+sSNg9mE1omsoqTGngFd8m7fnzQYbSszDKCeWLfjCOIVTW142t3QdHbX7k4HDqugdnVUeM/7vVQThQcCC9fo83QtX6CrRV9QQlaUnVp+a9sZHnwQZdUCAQzBxoY35ZSkubpr2z4uajx7MQZLxhCHEAFxXd/N0BItFGR9Cg+1NE3vOTZsPaZKNojm5U6Y2VLh1MC+8L6GdlSPGXEVUF2twNZdCAM8NV1AkH3pDHyVuCUig64p7f/BGOxTNtGCAh2KBXRk7lgIY4tSvS0vtrdzGEH0YzVkO3Vu0eKExfHT6xiKr+oDP2MhPVgi1Kc48WJVwkc6lEdkMayt/1an/BCe1w7uRCcP1t0wpHbZTAYvQxKrWWiMZN+NamU+1z6ylX6AJAA8ix7PCPN2qrzIQcckuTtdp7Qzt7xReGeGneSGz+LgfMTdNWKRgFGU7/k9qblDNOobx0DAqsPjKOROuyRIaDFp5X5h1T3wamQyTf5krXN9v+C0f6fguFyAj0UUbTJwAj/jxqwgH0ATRqHvm4BLnQartO1J7kPIfq+dUIYDH90cGkujSWhyB2y1r7g+Zq0rgEN5d8y+/Mhd7ZZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199015)(2906002)(186003)(6512007)(26005)(54906003)(110136005)(6506007)(316002)(2616005)(6486002)(478600001)(36756003)(6666004)(38100700002)(86362001)(83380400001)(41300700001)(4326008)(5660300002)(8936002)(66946007)(66476007)(66556008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gGvSooCfVHWjx7MDvRQ20BHJPNzUSJY4O4twRu5Ddq9A8eq/Yvog3JVZPoJS?=
 =?us-ascii?Q?V3R+UWxLD/D+1X+w2cPZnqsuJ5TTbIfEhFzQy6Qpc6WDRSDt6yRacP1LdCFJ?=
 =?us-ascii?Q?+Cj1j5794UiWa5UHiTs0ZNKWJb4gAMzPwDQSQsB36puJKktTU015ttoQKhbR?=
 =?us-ascii?Q?GX8qR9vvTxmpppe+w75rOOLW+3wV0noyW8BRMUj0L9dvCtiV6qEcL2sJftzL?=
 =?us-ascii?Q?2ROhBYH9iZ7/GC81XlernVu1F3c5cRc14SbHZBVqNmZsRX1vsl0Ga4xbuwkJ?=
 =?us-ascii?Q?qfdOVsCVse9CHZLu5cVqk/QUjnV+dzf25R+BXkfQvLD1PzJPGoYhG18sn6AK?=
 =?us-ascii?Q?icXFy1IQZ5dJWQAfG5xsDnwO8mew/dO9HCTiJFf0B2m/SYfBu07B5TDn/m0O?=
 =?us-ascii?Q?YEx20pSXkurQWstsoVeO7o0auTP5qOf2hZiRYdnbJT0V10daZCegwC6DeGDy?=
 =?us-ascii?Q?q/Xj/9/h0Cx9qK+raCwKKWzkIAmEr/VHt8iJ1GOqP4oYV5p2T/VQOU+rcgSf?=
 =?us-ascii?Q?THcqFdzKmFQJFVXPZCNGxy2CRJeZDsVXcMM539dfaCIY4o+NwQ7VPbTr/7gg?=
 =?us-ascii?Q?SU8DVvrt/myA1OZ40STwsp0um6RtljM3Fq1GR9eNDl2dJZHts8wEGiXF6/9t?=
 =?us-ascii?Q?7K+alzXsqE9nHBeo15M+aQKLPcy96SQwe2m22k0o1oXcv77LY2UvfMHqkoup?=
 =?us-ascii?Q?TF7RI6c4woJgZrO0NhalcV9EGhkBwuSEET7KpSU7y+g+/ej/BXo5hyltQZwr?=
 =?us-ascii?Q?5i8unXxV+udAOnatCdHP8RtzQhIFjzddksL0yDKhdVONFqSTfWNl2x1HmpbW?=
 =?us-ascii?Q?ucT+ftgLI75ATm7ILHejAMa2P1WU71RBYjA+aiNt0hkQRwLB1xS7Ro6vGtbm?=
 =?us-ascii?Q?VATX5eIh8acw5Na5ofMcWtXRon9AhQBrAxDEvvPuQSs4JWTwYrLZ7LXk+1ay?=
 =?us-ascii?Q?uUR6vNzF50Zo5PJPBgJgsUicyd6/gk6Gxs2tMG2ziGrgZli7jMjS53U/fFzb?=
 =?us-ascii?Q?b6+MHuTaTuqW/7m5ma8bWuAqkyjaYiF8B4GygvCqC5Yw7f9DukHxj/t4h1I3?=
 =?us-ascii?Q?SpHMa4BmgVLF+/mwi4nQriWQaNw6P4amCtUgiWupnXex5iCl0Bo59wIGjiF+?=
 =?us-ascii?Q?76/a7QEtDpqUX49A33fZb1qnH70dByXqh6Qces3lHREzD8ZM9ObKTz7IO5tZ?=
 =?us-ascii?Q?pppTir+GggVDUYXIAtHndk4s2p9HhcsStPkhkvVTxw7DOi0JEYxUdOx2Lqzu?=
 =?us-ascii?Q?6eVT1ASgsgGpcwiUIltaSaFeuu1kIgC3AHuDXVb6ExqsP4/ZiamY2+MeSkW1?=
 =?us-ascii?Q?ElYFZlZXHErfDHe9s2dEqF/WkTp60B8+lVlPnfkffuO/Yn/FrwFHWqUAUvbB?=
 =?us-ascii?Q?8mMDXqocgLgKpGzno3AtLvlSzfmotn/W0FdygW9pTAJBvTh3xKXERzNJoMIC?=
 =?us-ascii?Q?UPbqwxKhGtv2RuHpAJw2gceDiXhKeCQdnOXmr/LvFAiaxgRbGexlO8mDAL61?=
 =?us-ascii?Q?8+H791aCDkVDDur0PCugHlke3IxBPW12DnxL48Qxf+pnCInhTlvO0b0tDbdc?=
 =?us-ascii?Q?Tscl5sqZitpWHoyIcxf+imzeCaG0p9pRkJERflhX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df9a4714-850a-4770-e35c-08dafac72fc6
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 09:17:43.4908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pj/F3kY+XFDV60A2fAfbLVOfojGJ7zxnS6p1YaTlSxoAfUHoxu8K5USYFgnxdKuAG8rnk8yvYFSFlhr3vtWUAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7650
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 20, 2023 at 01:54:01PM +0800, Doug Smythies wrote:
> Revert the portion of a recent Makefile change that incorrectly
> deletes source files when doing "make clean".
> 
> Fixes: ba2d788aa873 ("selftests: amd-pstate: Trigger tbench benchmark and test cpus")
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Doug Smythies <dsmythies@telus.net>

(+ Shuah and linux-kselftest mailing list)

Thanks for fix!

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  tools/testing/selftests/amd-pstate/Makefile | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
> index 5f195ee756d6..5fd1424db37d 100644
> --- a/tools/testing/selftests/amd-pstate/Makefile
> +++ b/tools/testing/selftests/amd-pstate/Makefile
> @@ -7,11 +7,6 @@ all:
>  uname_M := $(shell uname -m 2>/dev/null || echo not)
>  ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
> 
> -ifeq (x86,$(ARCH))
> -TEST_GEN_FILES += ../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py
> -TEST_GEN_FILES += ../../../power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> -endif
> -
>  TEST_PROGS := run.sh
>  TEST_FILES := basic.sh tbench.sh gitsource.sh
> 
> --
> 2.25.1
> 
> 
