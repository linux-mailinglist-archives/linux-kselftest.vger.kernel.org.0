Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE8274E042
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jul 2023 23:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjGJVcI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 17:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjGJVcH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 17:32:07 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E26DF;
        Mon, 10 Jul 2023 14:32:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfMhIbnoXqzUdF0qXvQMVxf1mlW6H4Cco01j5dbZX2CzKZxRJW/c7AqZ3FxGtubQ+LYLYzwyO+btyUxnsTgFVkFXisPd7sg2t4KH1x85Qy7X+VcFCppMe6SqM8wagqhY1lBO/vwX853uJuRmFuOQO24e9VY1jWcoqmEYwmITS8qHxKl5RITOWIh1x6lfkL+GXtz3JRdeKx+LHhzOl4j7CBXO54CzmXFL3Pz7LIRcKy4yN2774RNIxIZ5AYifxlCiWqOXmUdYDYEvdw91ppCuR6VIPPDYwtkMDgU5dloN//sAauX6ev2zQVcfpmQbXNqFXfIpTbHpsYDtKgNFD0moSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irdCaAKmqKmVR7ZFAY454nxKH4i/+kPr1lPgM8fs0kQ=;
 b=I9GDbX8hfBlOScbSRJ4vroWpQc2A7JoZqsvxCeflyLw0sMoEL0rhr0p4U8rCkfJ+N8XxoFcQZ8AjLqhL9iWQEP0UCVJoKzIMma8pJVInVogsTxhWI4vNYZCClL3mF5AEmu4SBn0tKNuLj6dFB3m0BOl3Xr0ABop4gxeAgrSt4yZk6bWCt80NnaEpq+I07zOVr/NTa06imutbix62aY2HW4dFOLQLhTGxGiAxksg4wBdS3SGjzYbSd+I55puondQp8y2EVtd+CMIMwmg3lucfwXKnB11MSjtoBM04sHY5k3mIeqSXpzfY4obo1bWvIYaN0unXdeNvIa2f8rZz2LspAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irdCaAKmqKmVR7ZFAY454nxKH4i/+kPr1lPgM8fs0kQ=;
 b=LmGjhF1fz/+XLBOAR6ts6fvnDI01Tu77HXNwa2wcuY7entPGisStTMMZT5cKyDuOcQ3g/CZo6SyiKhZ9txCf/F84C0EvUJk8mS2LOAClFHEoutqaflypLrgBbZbBsNSObttf+QaFqDtlLqVmqpEXEq02aqlwtLzQhlYzRitttGtl2whODUniifEMRR1HNsvCP75pwdahRX0ub1rh2WvClsV5yNukkT4EEs1b8OkdDmiuWKoqRj5aZeeg/0B/plPI0jP4n6AHZOseMx8nbTwcnoae7sbNCooL2TmQbSLN9WDz9TT10uhZxb0LLGO88ZgXtXQGRm9xmI+zJJVKxChR3Q==
Received: from SJ0P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::12)
 by DM4PR12MB6302.namprd12.prod.outlook.com (2603:10b6:8:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 21:32:04 +0000
Received: from DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:41b:cafe::3c) by SJ0P220CA0005.outlook.office365.com
 (2603:10b6:a03:41b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Mon, 10 Jul 2023 21:32:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT098.mail.protection.outlook.com (10.13.173.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.18 via Frontend Transport; Mon, 10 Jul 2023 21:32:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 10 Jul 2023
 14:31:57 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 10 Jul
 2023 14:31:56 -0700
Message-ID: <ec86c0eb-5c6d-48a2-c216-ec4f40710ca1@nvidia.com>
Date:   Mon, 10 Jul 2023 14:31:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] selftests: Fix arm64 test installation
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
CC:     Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230710-kselftest-fix-arm64-v1-1-48e872844f25@kernel.org>
 <04a35122-5020-5ad9-7bdc-c17f9a27bf50@nvidia.com>
 <ZKx17G7ULaQox7Xo@finisterre.sirena.org.uk>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ZKx17G7ULaQox7Xo@finisterre.sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT098:EE_|DM4PR12MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: d887d46d-66c5-492a-b188-08db818d1a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7KlT/YaurnjHeq1V+yr41PoA2hKDdjHVf98K1miUH5c73DsLy7WFUBcc9y6PgRV2lYXDtB1fQxwYQJaz6s3SJ8HDTCZPLUbzA2Th0uvOrOs7WrUBvgjx3KncHGVXxvNFYR4lXe4i7kZ9/g10BZFYJ7aJeJcLCa0kzhUGkw60/CHFZ96jTcDZrsDVJVnx76u+SvUwPfkfZ6J4m2Wx+UHpOEqYB1RRJJVdTPjEiJ3gJ3GmD+Ke3hmdEN6aadvRTzO96HTzUWBXHZko4L5UQD02Sh4fHGIu89F6UMorU986toL4N3dDuMVr3G6VDTRMwlpKJpB7aTvpfvOS6uPo0T1h8N/SAPbO4kSl+UrODDyEyn0MUm6quNsgCmfeVxB4CkpW2kMgoyQAkrQK/ewybSe4AZGkVtP3gqr3uMCFpWW5vvwcwSqCBMhnG0dZEnC0uwRK7qcRDpJodGP/4qH46aZS4eJkZuZ3yctjKYX3GaEskD82dkcng0nvv6KwFsaa37QTIK/Z6m1p5Rm9iMSa/Hf9JO2J5kGGgGZiy1fVl+Mvsggu0q8rqQ5eyfWExwmEcQYjAppBPTqUUzrF47/f9VZttvAvTb8zXsDuakA+kuE1AtKucq28NynF7xPd5tbtmKlcYJIFWp/L90z6nbmq8BLd5T2PRuvGw/jImNXVNgz8z9voINvi833LrRQjCiJYyP/6IrfEYgk82a5+ucPZ8whkUQmBxJFABcrjGeB1uEeRwiU47lOTYYsOL9WOT5ekCSyF8wZQ88hNd279e+AvdMjq5w==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(86362001)(31696002)(82310400005)(82740400003)(31686004)(66899021)(40460700003)(40480700001)(36756003)(54906003)(70206006)(16576012)(70586007)(356005)(7636003)(478600001)(26005)(186003)(2616005)(53546011)(36860700001)(16526019)(5660300002)(316002)(2906002)(8936002)(8676002)(47076005)(426003)(336012)(83380400001)(4326008)(6916009)(41300700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 21:32:03.3165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d887d46d-66c5-492a-b188-08db818d1a4d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6302
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/10/23 14:20, Mark Brown wrote:
> On Mon, Jul 10, 2023 at 01:22:41PM -0700, John Hubbard wrote:
> 
>> There are 30 or 50 other pre-existing arm64 selftest build failures which were
>> quite misleading at first, until I got into the "right" selftests mindset of,
>> "massive swaths of selftests are broken, deal with it". :)
> 
> There are no such thing as far as I am aware - the arm64 selftests are
> *very* actively used by a range of people and CI systems, I certainly
> build them pretty consistently and am aware of no build failures with
> either GCC or clang.  You do need to install the headers to get the
> current APIs but until your commit everything was building cleanly.
> 
> If you are seeing any problems please report them.

oh wow, yes, I am! It's on a slightly older installation (gcc version
8.5.0 20210514 (Red Hat 8.5.0-18)), but there are a lot of basic build
failures, I'll get them together and send out a note.

Meanwhile, if you would like to try a quick fix, I have one that fixes
the problem on my system. I'm inclined to dress it up with a comment
that explains it (with a "TODO: stop using recursive Make here"), and
send it out as an actual fix:

diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
index 9460cbe81bcc..ace8b67fb22d 100644
--- a/tools/testing/selftests/arm64/Makefile
+++ b/tools/testing/selftests/arm64/Makefile
@@ -42,7 +42,7 @@ run_tests: all
         done
  
  # Avoid any output on non arm64 on emit_tests
-emit_tests: all
+emit_tests:
         @for DIR in $(ARM64_SUBTARGETS); do                             \
                 BUILD_TARGET=$(OUTPUT)/$$DIR;                   \
                 make OUTPUT=$$BUILD_TARGET -C $$DIR $@;         \
<blueforge> arm64 (master)$


thanks,
-- 
John Hubbard
NVIDIA

