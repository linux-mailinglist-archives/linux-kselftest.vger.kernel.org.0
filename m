Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3645B720BC3
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 00:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236474AbjFBWMQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 18:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbjFBWMP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 18:12:15 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B910AE51;
        Fri,  2 Jun 2023 15:12:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZDfKThexGHn/si2pCaQV7Y7POSA7s7MlU8+7j+ZJAt2K73gPSVMamF1M1EaBiv2veV24tKQyUSTRe7nCpJPQDVQgUSeMXOYYjk7m6craBKvohxAtSjEbAyQNe6GV38EG2JOj97aeeusPWAKJTENEH9CVYxtcvDFKKoCYexu5reRObRFGJ4muGj5NT8t7oPyNrLzkO68xG9uFSzB6Q4QXKy+9dJeGj1efAfrIDUuIM6BFv5W16WfKZAtOQBb3WycowstBaRP8TL9MzD/MNrp2yqXYmc2KynC0PbuXkSNKSxZTDF5FGwwqKEUI2HnyWlM48B9D75/mylB0XifwTn2mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwVH3vehgBlIGrEmlsc48lcJca/reH3qswtkqgnuDCo=;
 b=A5NOkJ++5cTTD/+MSE0DKw0IxoWRu6nVOKkwkhjsuXdnpKrV9qvu56pTylTmRb+rZ+TmRRLVDd/f/wrPxwtbR59yZb3s292VN708e/kenKQdNEiVK0GJtE6wlTa7b05la3OEWVeq/j51cO3PEaYUQdRPL520aVrXgW49oytUb8UovqWh1AnNDG2HNHrZhe5cM8azdjODyn4tImJmffFFvsnqVXNpPg8oZCknwAg9RrbdRmsGOOvpxOkv1eAhsgEKxAuKWDM8LyzZyWdPcjr5cv5smlQpeL0kenDk0J9jFcKb6yG4D6smnQzjktpNvQ02QLCnm0rQYXkPiek50697og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwVH3vehgBlIGrEmlsc48lcJca/reH3qswtkqgnuDCo=;
 b=mFUkcETOC0TGb6zGISIowNQ0jLNJ06Fb7skybS1SjQIythoh+9Sy5ubvvD021hGn2j4UsFJXVXfqODCkT/d8qHMVNuDp2ciQ3iw8SCbzRHhxYmqVQAW4bQh09JW13NS9WWn30p/NlWV1k2e2hfT2KeGFPJtQybI81lwYVuHLpq63NgJRtLM5MJxjvf0/lpotoFO3T+D2ssgR0SdUqLdcbFrWK5zobFrB0+6PNU9tCNnzNu/7mWf8WR+lA62QqzSDYiF+Pn59i7MtnaUaiagTvrudnxk06Fp+1AHnGt09yTqwB0xQLGP+KSCfLqGBAPQJ+gbEevixgmohHO+vDx25nQ==
Received: from BN9PR03CA0684.namprd03.prod.outlook.com (2603:10b6:408:10e::29)
 by MN2PR12MB4456.namprd12.prod.outlook.com (2603:10b6:208:266::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.27; Fri, 2 Jun
 2023 22:12:07 +0000
Received: from BN8NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::37) by BN9PR03CA0684.outlook.office365.com
 (2603:10b6:408:10e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Fri, 2 Jun 2023 22:12:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT076.mail.protection.outlook.com (10.13.176.174) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.28 via Frontend Transport; Fri, 2 Jun 2023 22:12:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 2 Jun 2023
 15:11:53 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 2 Jun 2023
 15:11:53 -0700
Message-ID: <68549f29-fe41-04d4-f648-245f399c350b@nvidia.com>
Date:   Fri, 2 Jun 2023 15:11:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 10/12] selftests/mm: move uffd* routines from vm_util.c to
 uffd-common.c
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-11-jhubbard@nvidia.com> <ZHoR+3v+zUENBhi4@x1n>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ZHoR+3v+zUENBhi4@x1n>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT076:EE_|MN2PR12MB4456:EE_
X-MS-Office365-Filtering-Correlation-Id: a72fa764-a438-420c-94ce-08db63b66754
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4O1MH/kghmz16qpTacL9htESWa28AIHkQ4IqkKVm1iifNI7yjYJQMQ5dK/zvaqLlxgZ2BIyfV4zmm0vavEgACClGZur9Ae+nHLpnrSO26xtUBLk0qUEcHTC3wkUg1GixgRALHUE5jJ5z3b8WY17I706B3Spmri2h6DnIZRM4egE4XPrV5JhN+iyL8CJcAAlVkdZhDKtrzTjqFzFkZ66cMTxIPFW/TT33hvZ1xixCPrcGpAqixYMR2DM5b+C73/uAn57QEqdjQ/C23sorLni9a8RUivsXeTpoyz7CLOFkjmrojV7XnFiNaPrBSdBZloMe3XVBV1WwrFiiHiRqEdbM2KfLYQQJzUCPHbhBiub/zKolPkDgk/CMGAFcML0em35IU1IHMGf2TriFEA5ysx1A8T0zNDy/eULIB4cBL+GHR0puwOPynNLDB3edv196iwA+FkouyX8GziP6igfAMuXMQy7q2pF7uG+Mf6SyRkMWQJv671ilUB/Sud9sNLb8aIn6uTJAG2YYpS3YU3bc8tDYelEgAC7Huxx3j7UOpsDh7l68uRkLvWFM7CGAScTssd9PxOOA79SGAfWtLB8mj0H3sPhNiDMKyethai5vhVsYb7ASInniPS/VBBXcZunzK0/UPxGDmd4Bvl/GuZhG0peXb79KpqWSsnvxSvJEEolnHg5BmSy3gJCpuHCKVT4O1XQasqX4ja8KYbnO+FcteAjKrpsvr/CZ+tHIOFXpfxdRoltqx6/Yh3RKWN/xMZCbxrFjbFdxB2EjO1s2hoFEXP3iZA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(36860700001)(5660300002)(2616005)(16526019)(40480700001)(47076005)(36756003)(426003)(336012)(86362001)(31696002)(186003)(356005)(82310400005)(7636003)(82740400003)(2906002)(8676002)(8936002)(26005)(53546011)(478600001)(41300700001)(6916009)(4326008)(31686004)(16576012)(54906003)(70586007)(70206006)(316002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 22:12:06.9976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a72fa764-a438-420c-94ce-08db63b66754
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4456
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

On 6/2/23 08:59, Peter Xu wrote:
> On Thu, Jun 01, 2023 at 06:33:56PM -0700, John Hubbard wrote:
>> This is where they belong, and this makes it cleaner to apply a
>> follow-up fix to the uffd builds.
>>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> 
> Thanks for further looking into this.
> 
> I'm fine to move it over if you think proper, but just to mention I had
> those in vm_utils.h just because I left all uffd specific tests shared code
> in uffd-common.h, so my plan was uffd-common.h shouldn't be included in
> most test cases except uffd tests.

I think we're in agreement that we want to only include uffd-common.h
where it's actually required. Likewise with the uffd*() routines. So I
would like to still move this over, yes, just to have things in their
best-named location.

> 
> I'm not sure whether we can just make your next patch of "ifndef.." into
> vm_utils.h to avoid the movement, or is it a must?
> 

Actually, I think I can drop the next patch entirely, based on
Muhammad's observation that we should be doing a "make headers"
to pull in those items. I'll have more to say over on that thread.


thanks,
-- 
John Hubbard
NVIDIA

