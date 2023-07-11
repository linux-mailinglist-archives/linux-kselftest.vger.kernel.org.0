Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD3474E2DE
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jul 2023 02:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjGKA6v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 20:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjGKA6s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 20:58:48 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6389712A;
        Mon, 10 Jul 2023 17:58:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+4+jyXxlIEcGaA2tr8ANrY5pxyNwadn13/5eGa8a703KrS89E3xLaXvszxGramco+/MOg5F6lfSqaDfLwqT5xg3hUFeXUZJdYtTEGxBcbqxuboQEwSk1YfeNXAu/r6ypfyTTqtoj/eVKxqo8IazILPK4cUOQ08kmRgtwdT2widwgF4eMuoJ+mYW667DJade5nln3pchjqKOpYWkghy5Pw/ISKfO8AuoIXZ1NhZ2HxqLoJt8UeLj2sTYnz7Yu0fo1i0JzjWtXwC475aMCDYf10gGG0JaGU2uAU38M/EyYfcSsLPODhQ8VPgcHc4gxJCmAT0vH+wDxSGZLsJtmREgYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUDwL0zqhWGOHFaKc5MiLdKQad2/05T8RLmNdvFxkHQ=;
 b=K6RZsn4BZSE3UsGr6wDszl+83GWSmzLZi1xqR4eH/AeEmS6QPO+p+syCKteJY21ndr+rdFYvLwRK0CdEZQFxIEk2JQHkLGztsMLUd59cApdUDehZ0+O8jOw5sBxludLDkunONvE4JOpZwg0lnfx+Pi4wqfhVTUsnANecBeaRGS/OZV5gIFMwtwWBcv/jaRyC4Xym8Z3VpldNKlabl8F/mauLm4w+HNsAb9jqv04vOvdm3YGtlO0BvKnAlTOxANqb6mKcdQdHO9ruY7mRU0jpeACTEf8URlLtZyfRbRxOcpJa6xJGuH1TWJpG4ThN7BjHkIFGVvpfyMoLCTgmSHes2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUDwL0zqhWGOHFaKc5MiLdKQad2/05T8RLmNdvFxkHQ=;
 b=q9srowv+ud68RNDTT7O9b8+4sdhGp+scpjK1a6sDrPz+TdFipcUDWeEPgAsAu4kPs9eiU5NiejRp73xSzSofickLCxIdR3Xgv2fEKPZA995r3WO61TxJgg4Li0H3APehDZOUrXhAVcrYt3q/utU7DJ6Wfw12wCyFIs1Bmq0/pTrEDA+8Vc595OBj/EBXpX0Har5p7sExReD0926WAniFB4kXYYLauBTN28W9r82TwLez6GVqAsg59gOWdlDs0LA2N26n4Um+kT36HM0ONyRnk/0fZeEFXGx2YNR3pUDbELt74eds9iwtWMWrtzCljL99033zh00L8vfwCYN9/R8Mcw==
Received: from BN9PR03CA0766.namprd03.prod.outlook.com (2603:10b6:408:13a::21)
 by DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Tue, 11 Jul
 2023 00:58:43 +0000
Received: from BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::2b) by BN9PR03CA0766.outlook.office365.com
 (2603:10b6:408:13a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Tue, 11 Jul 2023 00:58:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT075.mail.protection.outlook.com (10.13.176.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20 via Frontend Transport; Tue, 11 Jul 2023 00:58:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 10 Jul 2023
 17:58:31 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 10 Jul
 2023 17:58:30 -0700
Message-ID: <c30ff285-176f-4d76-38a0-4917a1c55c2b@nvidia.com>
Date:   Mon, 10 Jul 2023 17:58:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] selftests/arm64: fix build failure during the
 "emit_tests" step
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Anders Roxell <anders.roxell@linaro.org>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Mark Brown" <broonie@kernel.org>
References: <20230711005629.2547838-1-jhubbard@nvidia.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20230711005629.2547838-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT075:EE_|DM6PR12MB4516:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f3af72f-5c36-484e-b305-08db81a9f8fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LtR20+7QfcOazvBQW4AAyhAs8GpVpQNC9jsfayNfg2REeRiojIXmAQl/52f4bM62xVNuphQt+ajsjZC1g2SQDAAQzConUIV4m5nNKutdTv7jhRbAypeqMcv0sh9pnLps4kPiac8H/Y8uzxVDN1TW3audiTlw+wdTxDIIYZmsgHTjho+qYiwlPhzCKVko1JGHb550XK3xVn99cyWLmcVVoJwbdq0zdt9zlz5hhPE4KTRL0ZR6tQTFtvn6rygv+gJMyytHlNdGXQxZb6qBscoaj+SqMCMhqf67wOhxMbnxOooNhuPQgzhjX2QjgSWjjkK65l9nTc/XkmetoWG6O2ZiuaAUfP92lOiJieJDTlqGSkmPcMdhfLrrJKBQLePl/wi55KB5LlK61S9OTTxpumSiBZJL7uI41f2cu9hEA7VzLXUQVLcNpflJQBvtqP72sRJA3uweQ10YWRONxe+mBqqhNXXH3/FKgHNfV2zgW6NaVPhPMSYdTcbcSEWFhN1Ds7y47wMcJ0rktvtrLu80QcdIL6cN7UtHJDkaSPSAsLO1gWLIcPvFtI5iEdzBTimClaWihzekp5fdeWpiLWOaJ4OCSCkV4dDGKe5UGy+B/BEz1T9Y7RR/ZLiv0UfMUVdg+i1YXhVt+fHfSFNu7m70jJxZtC3jJTkf8/CC+NTVphtpWD+ErHA4eSHKcLgddxDsBwrviCIpZ2D/J27PF43Q3obwNb4HRWGrHnD5keUjjYMjitAys4yPx53BVqmz/ZfyCon4A8MedlnPHeDVR6ecLW44ehnDdclSOHfXuynCGVFob5n9OPMmqd9PphTizfnIIljT
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199021)(46966006)(40470700004)(36840700001)(478600001)(54906003)(16576012)(26005)(16526019)(2616005)(53546011)(966005)(82740400003)(2906002)(70586007)(82310400005)(186003)(316002)(4326008)(5660300002)(41300700001)(8676002)(6916009)(8936002)(7416002)(7636003)(356005)(70206006)(40460700003)(86362001)(31696002)(36756003)(47076005)(426003)(36860700001)(336012)(83380400001)(40480700001)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 00:58:42.7701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3af72f-5c36-484e-b305-08db81a9f8fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4516
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/10/23 17:56, John Hubbard wrote:
> The build failure reported in [1] occurred because commit 9fc96c7c19df
> ("selftests: error out if kernel header files are not yet built") added
> a new "kernel_header_files" dependency to "all", and that triggered
> another, pre-existing problem. Specifically, the arm64 selftests
> override the emit_tests target, and that override improperly declares
> itself to depend upon the "all" target.

I also have a corresponding fix for selftests/riscv, which has copied the
arm64 selftest approach. But I'll wait to see how reviews go here,
before sending that out.

thanks,
-- 
John Hubbard
NVIDIA

> 
> This is a problem because the "emit_tests" target in lib.mk was not
> intended to be overridden. emit_tests is a very simple, sequential build
> target that was originally invoked from the "install" target, which in
> turn, depends upon "all".
> 
> That approach worked for years. But with 9fc96c7c19df in place,
> emit_tests failed, because it does not set up all of the elaborate
> things that "install" does. And that caused the new
> "kernel_header_files" target (which depends upon $(KBUILD_OUTPUT) being
> correct) to fail.
> 
> Some detail: The "all" target is .PHONY. Therefore, each target that
> depends on "all" will cause it to be invoked again, and because
> dependencies are managed quite loosely in the selftests Makefiles, many
> things will run, even "all" is invoked several times in immediate
> succession. So this is not a "real" failure, as far as build steps go:
> everything gets built, but "all" reports a problem when invoked a second
> time from a bad environment.
> 
> To fix this, simply remove the unnecessary "all" dependency from the
> overridden emit_tests target. The dependency is still effectively
> honored, because again, invocation is via "install", which also depends
> upon "all".
> 
> An alternative approach would be to harden the emit_tests target so that
> it can depend upon "all", but that's a lot more complicated and hard to
> get right, and doesn't seem worth it, especially given that emit_tests
> should probably not be overridden at all.
> 
> [1] https://lore.kernel.org/20230710-kselftest-fix-arm64-v1-1-48e872844f25@kernel.org
> 
> Fixes: 9fc96c7c19df ("selftests: error out if kernel header files are not yet built")
> Reported-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   tools/testing/selftests/arm64/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
> index 9460cbe81bcc..ace8b67fb22d 100644
> --- a/tools/testing/selftests/arm64/Makefile
> +++ b/tools/testing/selftests/arm64/Makefile
> @@ -42,7 +42,7 @@ run_tests: all
>   	done
>   
>   # Avoid any output on non arm64 on emit_tests
> -emit_tests: all
> +emit_tests:
>   	@for DIR in $(ARM64_SUBTARGETS); do				\
>   		BUILD_TARGET=$(OUTPUT)/$$DIR;			\
>   		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;		\
> 
> base-commit: d5fe758c21f4770763ae4c05580be239be18947d


