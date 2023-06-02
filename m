Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE27720B21
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 23:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbjFBVqZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 17:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236143AbjFBVqZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 17:46:25 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865611A5;
        Fri,  2 Jun 2023 14:46:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfwCmPCs6F7OWg2F4tB/gwXPvlvbolFmjtxHxUhkDbYM8hOoeuASsdltCb7DN8wblcPlKNT8gp/SwfXakDINU5inB//FnQoFUotMUk/sOQ6F3wKjimk+i5YdMroDrDfUK4pKAx7W5solNxIkxoTMPq4uZd4i4dMQXI+WBoVEZthjp58thbHbnPwBcdpZfQEQ9Rski2bTWEBY/fEbZsRcSW7gzyR1IIT35Y4+3HaUb3ew155aFs3rQFdTdqMWS9vq+8jmdMpy7imfZR4oru6/zjUkZkOFCTQpLc86xTq00r6ugMPl1QyVmQ0LxAzCwTZ1DHtdzXNHMM0AN5dm8C2wTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vCQ4Y8ahXkZkLI7ZnWhw5jf5dbga5Zlmxa5WjSkbis=;
 b=m4+9usyC1VJfakblc99fy/PW3cb0oc2g00K2+8VuAdrk98/O1hsLAYby2qLVZw+ATcaPj3GSAhOMkUjEeXNkNTMgE2ZtDPXwzFxsXHUiYiTje3zA27Klzi3ocQLdD8tVKqXG1X6rrMpP5RuFtso3dIY9eGD68hHqgbnZDv42M9Fq2hDmZhXN+SRH5bXyCdeddsMExubJgXChAURcQ27ODkoGtbOqQVe6cp+iTIygYaoGbztSpXmvsuXkt7dJGBLnVszfrvOjNM4R5ZMpNLw/aAdbnnUvsWooHnFyf1nOOcoGL/zKf5oHu9CsyMQeABjttzI3RucYcIhu9enMQNpyHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vCQ4Y8ahXkZkLI7ZnWhw5jf5dbga5Zlmxa5WjSkbis=;
 b=IauUmEl+mkRx2OhLvqSCzXQG2pa5ckmqXp2y0d8RLdjfT2rDtWli9lG3O9S5cYDYDtvvTBxbpm6+FOr1sO1pNeYExCs96KPcFVjs1RmLi1ABr8rrT4nIjrpO988VKlq3K1m4X1+vnnZ/V1b7bvglju4Sf6K+UG4uwbdvdMMpcSuQhW4NbbcaN+3xmIc1ZCj2accV8+JIYHjzWuc/Ek9pPwBHrFp4sTwVgf7/UdCLjDSdQbml2G69bEHClzwVSFWnLqykTYjkLUoRT3aUjYhcLoSsHWxsBmBl9KkY2yYOSrfW+lUNsRXhy972JyPI2YTOSGkZnlK5Wq1wTgCDDUPPtA==
Received: from DS7PR03CA0245.namprd03.prod.outlook.com (2603:10b6:5:3b3::10)
 by IA0PR12MB7723.namprd12.prod.outlook.com (2603:10b6:208:431::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Fri, 2 Jun
 2023 21:46:20 +0000
Received: from DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::21) by DS7PR03CA0245.outlook.office365.com
 (2603:10b6:5:3b3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Fri, 2 Jun 2023 21:46:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT095.mail.protection.outlook.com (10.13.172.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.24 via Frontend Transport; Fri, 2 Jun 2023 21:46:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 2 Jun 2023
 14:46:11 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 2 Jun 2023
 14:46:10 -0700
Message-ID: <c1655a88-f07a-0b33-ced4-e96951f6e6fb@nvidia.com>
Date:   Fri, 2 Jun 2023 14:46:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 05/12] selftests/mm: fix invocation of tests that are run
 via shell scripts
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-6-jhubbard@nvidia.com> <ZHoL8vJPIUzP2RKN@x1n>
 <e31f1411-1986-c25d-af74-05ad73a53c8d@nvidia.com> <ZHpgybHDDAMFsADT@x1n>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ZHpgybHDDAMFsADT@x1n>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT095:EE_|IA0PR12MB7723:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c19a4ef-4db0-467b-b57d-08db63b2cceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qRRhLhkMMllEIFULEC3M0BqUy9RWEuoyV37YCHRBcohaazmiQYClP9DzUALiy/O3IiuonhmVgg3v4Wn2N1x7vDqXj2iF6A3KQNVqFNEnQAxkg0PfUAveO4JHiD0qupIzym5MkjaTW83HAjwkRbjxbXejqujRCLfvzO0j3AeSA3vPELcI16Nx2aabEGwvdyKcY7uJeVKHR1g9qq6xyYCPmO0T7VRUExphnb5eh2utJFLD4cT2jHg3IfvENZFraAuSuqYN3qKk789x9IA26eFvTxTrPMU+TPpxpVh6ohOeJR9FgUKzGHJYHmp5tV68/8HA5lKe1HhELVQxTcRI/bdKWfFTih2Bvd1gFVKhHXC9UvNiVlpCzl1I/SBEfeoEePfr46kaHM2mUQr8Y/5E3QupTGrGk9vewNDUhaDAxWZvtIq2YQ1reSZf7nbnjACBOlQyxhlPu7F/SYa/kNAnc712pRW1n3xjUlqJ+na5ejWQOeF53M0JZkjX2t3ZUusBbfTkLaaV90vltw0PdITcorb7H3wJr8jkYQeL9tfVbuw8wTsaItcSlaer8+O/Mwv0GIq/G0m2Jyr4sycrtdoAWexqgb8pztP+JXB7USfThRLks0Is5ybvthhOU4P4soo6E5HLJ6rK5ZK6/hluN7zKy4Z9lM0DsBSai6BNQyNZikFi5XrEAjUdjhNcYmGYQpokjn6qXmtbI75atIahVbLePdPfd3ceIWYH5XWvjaHKZMwM1IhZct1v904Rzx+lTHgFcEiJFkjEqWnv5pZi/ruQOT3uLtRmbtF2arQ52Feit6ktdRc=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(426003)(336012)(40460700003)(47076005)(2616005)(2906002)(36756003)(86362001)(82310400005)(31696002)(7636003)(356005)(82740400003)(36860700001)(40480700001)(316002)(41300700001)(5660300002)(8936002)(8676002)(478600001)(16576012)(54906003)(70206006)(70586007)(4326008)(6916009)(31686004)(26005)(16526019)(186003)(53546011)(66899021)(21314003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 21:46:19.4978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c19a4ef-4db0-467b-b57d-08db63b2cceb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7723
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/2/23 14:36, Peter Xu wrote:
...
>> But here, the run_vmtests.sh file requires bash already, as per the
>> first line:
>>
>>      #!/bin/bash
>>
>> ...which is ultimately why I decided to use bash, rather than sh here.
> 
> That one can be easily override with $XXX run_vmtests.sh, hard-coded "bash"
> in Makefiles can't, afaiu.

Yes, but then you'd have to deal with the rest of the kernel, and bash
is just completely woven into the whole thing. Just in the selftests
alone, there are dozens or hundreds of direct invocations.

$ git grep -w bash | wc -l
1146

$ cd tools/testing/selftests/

$ git grep -w bash | wc -l
560

$ git grep -w bash | grep -v '/bin' | wc -l
113

That ship really has sailed: it's not practical to expect that kind
of portability here.

...
> Just to mention that I was not talking about $(shell ...), but the
> environment var $(SHELL), or "env | grep SHELL".
> 
> Please feel free to have a look at tools/perf/arch/x86/Makefile.

Yes, but that is a *Makefile*. (And only one out of 145, the others do
not use this.) There is no use of SHELL outside of Makefiles, nor in
fact anywhere in the kernel.


thanks,
-- 
John Hubbard
NVIDIA

