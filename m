Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA60B720BF0
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 00:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236334AbjFBW0w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 18:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbjFBW0v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 18:26:51 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915699D;
        Fri,  2 Jun 2023 15:26:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKBTCK8tAeI/8Opy86Spi0r50jh2soRIcsJbWaldiSbxT37GJyEYi6+K5LGDcqHFyT6FhMZBetcy5A8WKTh+TGJOkNlalfHUKL837pGzyXe0SB5Aqs2ieVm3STdKkbFrciQvWQ+l6LKqiEorrubHJc8lYEs0Njm5zvWUFlP4Klwz42424wR4wF425tkNk0smDYpkRDL4t51rIqNw4L3xo/jmkUllNsfyT1NN13j8GpNDHAvBRLHSEN2fLOIcRZG3mRl0WxMz9h+4TyZfDgdljdjwBLSGZ8oSB8m8xDszX8/Tv0g6xbpT01W574KYkU6ZbBQpM7Jhjjd3+zr34eIvdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7g5eGNA9vEM3qifb5Rwso5LCvTX5/ywAiVKYxOinZQ=;
 b=cwQBouo9bY18RYM8/dsWT8sbXnza0Lqelu9V722ApcEVjWj1qeVS1iUF0KqEA7M7zxmp6TwNFVpbaUf+FORpByHsX1WuPlG5DFTh3z7JPTGSCdLaEfQ5O2T9kFLR++RNzkgeU9bDUDb2BO13P9ziscV6K2twqNM9SV4ooK52YpwhitDnqoRlYbZdvlTwqxanX0iWxJR25Q8KJP/Qn5NLjz/brflBeHVXCUJJTQvfcx2NgTCV5RISzVR3+6RkMNQKQkXSqYxf9gVkSUCSqZZCMVQ8o1W9bpBF9p2XZo4mjOnoLXQpRX3f1K5hmS3TPnS5tKVwKnFfvQN2lIhOHkB8Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=collabora.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7g5eGNA9vEM3qifb5Rwso5LCvTX5/ywAiVKYxOinZQ=;
 b=OOBPE2LdaQFeNQZIknJMsSgUe6ko5WdwZOdRdxODjLtDH7l0i6nh//CDWjiKwybE24zd4QjWNtjCMHJTl3aKBtVIzWz/XW7R2m69uZnzl0ut8p97HR5pYwPWIusk8Asv0jpXnFSefCcCcGMIi1b3LIonWl6yWUTTEwHFYVY34jqnBPB53Kt5zqmnjnRzOeIU5UsQkKTRMfmYssH1xVIRez35L1l3vM0WbJr0pk/VRuUrZkcoz2WhVc/Zle3ZpikUrf5lP0+e/TuDsdoCkmZ5LE/scF8bgeGqj97nTtcLohGE9m852+obcLc86OPF3BryfK1tZbCy22Cib38wX0y65w==
Received: from DM5PR07CA0079.namprd07.prod.outlook.com (2603:10b6:4:ad::44) by
 PH7PR12MB5975.namprd12.prod.outlook.com (2603:10b6:510:1da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Fri, 2 Jun
 2023 22:26:48 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::70) by DM5PR07CA0079.outlook.office365.com
 (2603:10b6:4:ad::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.25 via Frontend
 Transport; Fri, 2 Jun 2023 22:26:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.26 via Frontend Transport; Fri, 2 Jun 2023 22:26:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 2 Jun 2023
 15:26:38 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 2 Jun 2023
 15:26:38 -0700
Message-ID: <03ce1d4b-b8ba-bb92-4e8b-018f16afe634@nvidia.com>
Date:   Fri, 2 Jun 2023 15:26:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 12/12] selftests/mm: fix uffd-unit-tests.c build failure
 due to missing MADV_COLLAPSE
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-13-jhubbard@nvidia.com>
 <740b9d62-ba83-0297-aa2f-66af29f9afbe@collabora.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <740b9d62-ba83-0297-aa2f-66af29f9afbe@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT035:EE_|PH7PR12MB5975:EE_
X-MS-Office365-Filtering-Correlation-Id: b619e339-0d9d-4dfb-16e1-08db63b87439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GqHKif9QPp8l2Uazrl31Ts8WjdeuoqhR1B33cc3dhex7826jGv6uZPxk+pisMyap3wazME7T2tLKwHHDwIr6Qi/XCzt1O/iL7YsV+XIbpuR5ID+mC0ZmdVt72hYLO6Ioj/20I74pdqwWxRG/0hDjSnRS2gm04wX1zTMM6L1GiS3ahGFLbeKWQpluRbcJwGronLwAWVoKmqOmsfiD1d9hrd4l5bx74F8m4IN5tfrbMsnMnAUwV2Q9yX7rLLKR8WaM/UJMtJ05qRNoKcTZb/VKFn8DG3MITS6dowmFoi4s3n3E8FY3JjTqKKbtvmqPLFqfSlqK35U6MfuReduJC/aQecSaKxcNJ+I6nuSNknY2NznPDPg7SmrZ404zl5WRKEpQDHl3lFoHte/J28ZSg6oyIRGcG5JBpcJj/E/8b8nruISwub8ptwH7XUV5Xa4tW0qgCePvGRcFVYHhjGkSCNxUqOkOxsFAk1BGUl8zEiHeThklYRF3l4LWXgP9MukrrxKy2ue3eLdsIuTvwwKdYoGGAOZRzWWqnbBOI4XJ26KKP4SDiUImvooY57aLUQvc82cELL9IOi/TNWkfisiloB4qE7H6rX50zWA1ZyMR39KEblXHWAWLXmDGJF7y8Q3Hcx1tkCZm0oLosKSCQdvURmRYWJSj9GnBZi0NXVEV+754VQo1s/0M1KpmcxNwraWzCsCJ9o9Hn4MxtCbfI2k/K3KjgDMO86D+V/BcYmeI0Vz/BxH5sWzJxtx40n6TA07GlWbQGz+8AG6wij9cs+kNlDPrKw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199021)(40470700004)(36840700001)(46966006)(31696002)(86362001)(8676002)(8936002)(31686004)(2906002)(82310400005)(316002)(356005)(82740400003)(4326008)(7636003)(70206006)(70586007)(5660300002)(54906003)(110136005)(16576012)(478600001)(36860700001)(41300700001)(83380400001)(40460700003)(47076005)(2616005)(36756003)(40480700001)(26005)(53546011)(426003)(336012)(16526019)(186003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 22:26:47.6520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b619e339-0d9d-4dfb-16e1-08db63b87439
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5975
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

On 6/2/23 09:34, Muhammad Usama Anjum wrote:
> On 6/2/23 6:33 AM, John Hubbard wrote:
>> MADV_PAGEOUT, MADV_POPULATE_READ, MADV_COLLAPSE are conditionally
>> defined as necessary. However, that was being done in .c files, and a
>> new build failure came up that would have been automatically avoided had
>> these been in a common header file.
> There is a better way. Just like I've mentioned that building in-tree
> kernel headers and then mm selftests don't produce any build failures as
> they pick up in-tree compiled kernel header files. Don't move these

OK.

> definations to vm_util.h. Instead include asm-generic/mman-common.h which
> has all these definitions already. I've just removed what you have removed
> in this patch and include asm-generic/mman-common.h. It builds fine. But
> then there are more duplicated definition warnings.

umm, that's still a major problem. But let me look into it, based on
your recommended approach of "make headers" first, thanks.


thanks,
-- 
John Hubbard
NVIDIA

